#!/usr/bin/env bash

inputs=($(pacmd list-sink-inputs | grep index |awk '{print $2}'))

# headset with mic
if [ $1 == '1' ]
then
    sink='bluez_sink.00_1C_EF_7E_E6_69'
    pacmd set-card-profile bluez_card.00_1C_EF_7E_E6_69 hsp &> /dev/null
    pacmd set-default-sink bluez_sink.00_1C_EF_7E_E6_69 &> /dev/null
    pacmd set-sink-volume bluez_sink.00_1C_EF_7E_E6_69 35000 &> /dev/null
    pacmd set-default-source bluez_source.00_1C_EF_7E_E6_69 &> /dev/null
    notify-send "Audio device changed" "Now using bluetooth mono/mic" -t 3000 -i /usr/share/notify-osd/icons/gnome/scalable/status/notification-audio-play.svg
fi

# headset no mic
if [ $1 == '2' ]
then
    sink='bluez_sink.00_1C_EF_7E_E6_69'
    pacmd set-card-profile bluez_card.00_1C_EF_7E_E6_69 a2dp &> /dev/null
    pacmd set-default-sink bluez_sink.00_1C_EF_7E_E6_69 &> /dev/null
    pacmd set-sink-volume bluez_sink.00_1C_EF_7E_E6_69 35000 &> /dev/null
    notify-send "Audio device changed" "Now using bluetooth stereo" -t 3000 -i /usr/share/notify-osd/icons/gnome/scalable/status/notification-audio-play.svg
fi

# speakers
if [ $1 == '3' ]
then
    sink='alsa_output.pci-0000_00_14.2.analog-stereo'
    pacmd set-default-sink alsa_output.pci-0000_00_14.2.analog-stereo &> /dev/null
    pacmd set-default-source alsa_input.pci-0000_00_14.2.analog-stereo &> /dev/null
    pacmd set-sink-volume alsa_output.pci-0000_00_14.2.analog-stereo 5000  &> /dev/null
    notify-send "Audio device changed" "Now using stereo speakers" -t 3000 -i /usr/share/notify-osd/icons/gnome/scalable/status/notification-audio-play.svg
fi

for i in ${inputs[*]}; do pacmd move-sink-input $i $sink &> /dev/null; done
