#!/bin/bash

# Update package list
sudo apt update -y

# Download ngrok
wget -O ngrok.tgz "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz" 

# Download Windows ISO
wget -O win.iso "https://drive.massgrave.dev/en-us_windows_server_2022_updated_dec_2023_x64_dvd_f101ef8f.iso"  > /dev/null 2>&1

# Extract ngrok
tar -xf ngrok.tgz

# Set ngrok authtoken
./ngrok authtoken 2HOfzFybejy2wCyxIcOPMGLP9KP_4Yf8Mwg21ps9upjhi6z7J

# Start ngrok tunnel
./ngrok tcp --region eu 5900 &

# Install qemu-kvm
sudo apt install qemu-kvm -y

# Create a raw disk image for Windows
qemu-img create -f raw win.img 28G

# Run QEMU with specified parameters
sudo qemu-system-x86_64 -m 12G -smp 3 -cpu host -boot order=c -drive file=win.iso,media=cdrom -drive file=win.img,format=raw -device usb-ehci,id=usb,bus=pci.0,addr=0x4 -device usb-tablet -vnc :0 -smp cores=3 -device e1000,netdev=n0 -netdev user,id=n0 -vga qxl -accel kvm > /dev/null 2>&1
seq 1 43200 | while read i; do echo -en "\r Running .     $i s /43200 s";sleep 0.1;echo -en "\r Running ..    $i s /43200 s";sleep 0.1;echo -en "\r Running ...   $i s /43200 s";sleep 0.1;echo -en "\r Running ....  $i s /43200 s";sleep 0.1;echo -en "\r Running ..... $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1;echo -en "\r Running  .... $i s /43200 s";sleep 0.1;echo -en "\r Running   ... $i s /43200 s";sleep 0.1;echo -en "\r Running    .. $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1; done
