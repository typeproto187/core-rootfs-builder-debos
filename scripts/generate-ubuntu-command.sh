#!/bin/sh

# Generates an ubuntu_command file read by system-image for performing an image
# installation.
# The ubuntu-command file is echoed to stdout

# Each argument is a file you would like to update from. For example, call this
# as
# 'generate-ubuntu-command.sh "ubports.tar.xz" "device.tar.xz" "keyring.tar.xz" "version.tar.xz"'
# to generate an ubuntu_command file that loads the keyrings
# 'image_master.tar.xz' and 'image_signing.tar.xz', installs ubports.tar.xz,
# then device.tar.xz, then version.tar.xz, then keyring.tar.xz. The loaded
# keyring names are assumed.

echo '# Generated by ubports rootfs-builder-debos'

cat << EOF
format system
load_keyring image-master.tar.xz image-master.tar.xz.asc
load_keyring image-signing.tar.xz image-signing.tar.xz.asc
mount system
EOF

for FILE in "$@"; do
    echo "update $FILE $FILE.asc"
done

echo 'unmount system'
