Return-Path: <netdev+bounces-63473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A907682D3AE
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 05:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA01C20D1F
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 04:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5D622;
	Mon, 15 Jan 2024 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/aV7w5x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6717CD
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso6227414f8f.1
        for <netdev@vger.kernel.org>; Sun, 14 Jan 2024 20:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705293453; x=1705898253; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lDaEUOiZFKJ+LJhYlgC9SroZUDxRa2haIdbBjdzzs4=;
        b=X/aV7w5xgDsWbUDEBlyhJIO97fHECeM63uaomxpTR9z31cvmDvnTqBkoh2gvJhvBGu
         OFwP0s7ZLWQa43o3DJgUWpjB/QCxXZNvauJhCgKp2xe7ke3wBG2cD/XeYKJ6t0DJGORL
         /+heqlb2GeYhY6642ILZEYcU5GfL8fhnn8oQptQIcVzbNXmtDJFbpa1HP62Q087I8wJC
         V1hNIp4U9M6J7kspvEuLVC3/Pr2NYWTXcRQeJkr5Lyz/IYsGghRlFtBETlUIjitrsD2r
         dVxwM6xNBjTnM9ORhROtZvFl+tj3QjtNWOt+YX0Ni/9pLsRTDD0Y9pKpK3sm7EfAef+X
         +rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705293453; x=1705898253;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lDaEUOiZFKJ+LJhYlgC9SroZUDxRa2haIdbBjdzzs4=;
        b=nVD0iLr1lTwHz9QFHnDwNcq2OPelY1+LsFNQvInYpTTTA17tpFqHOv3Tct4VGhdZQm
         I89M18vF2oWNb7tPtNxyxaqJCsBGK4r7edf2PqZxFRNzUtPz0KX82vdq+/doJ6oNmnJO
         XtRzhHPrngoYYaA9mZrn7GrUGNG7ruaSKhm+g0Em8aIJ0aWcwXYEnF5zOW/XKNPye3+L
         P/aHdb70naxUm2s4kCFQGK3wLm+wE9m8+bg4UomDxF0LSQ9JGMpv4vvg6x1wkptSjnRx
         NzniOTq4fgLHNTo98z/eu4CUsfszwKlL1x7dsPAoDfjoCt9aRdnWX1KG5aAqH3//OLZd
         uK5A==
X-Gm-Message-State: AOJu0YyNZ7zHSusbynAlm4NhcQZuuT2pXFIKt5n/SAYr//fKgXlzJaie
	ex4sduarxwFXc+kyIv855VWu0UyufpQnbgmkWk8n4Sg6xjI=
X-Google-Smtp-Source: AGHT+IHXIxqfOEbfT7O0qbSboqKZFnbZZDnbDnVzAoivc/YTHi8oWPwR6UPyX9BdLYuHBEb42iqMxeEIr5ca7EQBatA=
X-Received: by 2002:a05:600c:4f50:b0:40e:4278:81f3 with SMTP id
 m16-20020a05600c4f5000b0040e427881f3mr1871685wmq.50.1705293453072; Sun, 14
 Jan 2024 20:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Waterer <simon.waterer@gmail.com>
Date: Mon, 15 Jan 2024 17:37:21 +1300
Message-ID: <CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com>
Subject: DSA switch: VLAN tag not added on packets directed to a PVID,untagged switchport
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm using a DSA switch with vlan_filtering enabled.

When tcpdumping on the DSA master interface, and looking at the
packets egressing the Linux host towards the CPU port of the switch,
I'm observing that 802.1q vlan tags are only being added on packets
directed towards a trunk port of the switch. VLAN tags are not being
added on packets directed to a PVID,untagged switchport. The VLAN tags
are seen when tcpdumping the br0 device, but are lost by the time they
reach the DSA master interface. This is an issue as the switch
hardware proceeds to tag the packet with the default VLAN id 1 when
the untagged packet ingresses the switch via the CPU port.

Is this behaviour expected of DSA switch integration with VLANs?
Please may anyone offer a suggestion on what further I may look into
to troubleshoot this issue?

More information:

The DSA switch consists of 2 Microchip LAN9373 switches in cascade mode.
The system is iMX8 running Linux 6.1.36.
The master interface is eth1.
The user ports are labelled afe0, afe1, afe2, etc.

Setup is as follows:

ethtool -K eth1 rx-vlan-offload off # in order to see vlan tags on
eth1 ingress traffic
ip link add br0 type bridge
ip link add link br0 name br0.10 type vlan id 10
ip addr add 192.168.10.1/24 dev br0.10
ip link add link br0 name br0.20 type vlan id 20
ip addr add 192.168.20.1/24 dev br0.20
ip link add link br0 name br0.30 type vlan id 30
ip addr add 192.168.30.1/24 dev br0.30
ip link set dev afe0 master br0
ip link set dev afe1 master br0
ip link set dev br0 type bridge vlan_filtering 1
bridge vlan add dev br0 vid 10 self
bridge vlan add dev br0 vid 20 self
bridge vlan add dev br0 vid 30 self
bridge vlan add vid 10 dev afe0
bridge vlan add vid 30 dev afe0
bridge vlan add vid 20 dev afe0
bridge vlan add vid 30 dev afe1 pvid untagged
ip link set dev br0 up
ip link set dev br0.10 up
ip link set dev br0.20 up
ip link set dev br0.30 up
ip link set dev afe0 up
ip link set dev afe1 up


Example showing expected behaviour:
-----------------------------------
When sending a ping to 192.168.30.1 from another device (IP:
192.168.30.251) that is connected to the tagged port "afe0", behaviour
is as expected:

tcpdump on device sending the ping:
   listening on enx00e04c3ff8c2, link-type EN10MB (Ethernet), capture
size 262144 bytes
   13:23:37.412278 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP, Request
who-has 192.168.30.1 tell 192.168.30.251, length 28
   13:23:37.414159 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 60: vlan 30, p 0, ethertype ARP, Reply
192.168.30.1 is-at ea:38:5b:06:97:75, length 42
   13:23:37.414170 00:e0:4c:3f:f8:c2 > ea:38:5b:06:97:75, ethertype
802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4,
192.168.30.251 > 192.168.30.1: ICMP echo request, id 48, seq 1, length
64
   13:23:37.415247 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4,
192.168.30.1 > 192.168.30.251: ICMP echo reply, id 48, seq 1, length
64

   Here, the ping is successful with the device receiving the ARP
reply and ICMP echo reply with vlan id 30 (as expected).

tcpdump on DSA master interface eth1:
   listening on eth1, link-type NULL (BSD loopback), snapshot length
262144 bytes
   13:27:46.917763 AF Unknown (4294967295), length 65:
       0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
       0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
       0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
       0x0030:  0000 0000 0000 0000 0000 0000 00         .............
   13:27:46.917905 AF Unknown (14699583), length 63:
       0x0000:  f8c2 ea38 5b06 9775 8100 001e 0806 0001  ...8[..u........
       0x0010:  0800 0604 0002 ea38 5b06 9775 c0a8 1e01  .......8[..u....
       0x0020:  00e0 4c3f f8c2 c0a8 1efb 0000 0000 0000  ..L?............
       0x0030:  0000 0000 0000 0000 2000 01              ...........
   13:27:46.918932 AF Unknown (3929561862), length 103:
       0x0000:  9775 00e0 4c3f f8c2 8100 001e 0800 4500  .u..L?........E.
       0x0010:  0054 022e 4000 4001 7a2e c0a8 1efb c0a8  .T..@.@.z.......
       0x0020:  1e01 0800 28d1 0030 0001 097b a465 0000  ....(..0...{.e..
       0x0030:  0000 5c4a 0600 0000 0000 1011 1213 1415  ..\J............
       0x0040:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
       0x0050:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
       0x0060:  3637 00                                  67.
   13:27:46.919035 AF Unknown (14699583), length 105:
       0x0000:  f8c2 ea38 5b06 9775 8100 001e 0800 4500  ...8[..u......E.
       0x0010:  0054 f562 0000 4001 c6f9 c0a8 1e01 c0a8  .T.b..@.........
       0x0020:  1efb 0000 30d1 0030 0001 097b a465 0000  ....0..0...{.e..
       0x0030:  0000 5c4a 0600 0000 0000 1011 1213 1415  ..\J............
       0x0040:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
       0x0050:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
       0x0060:  3637 2000 01                             67...

   Here, the vlan tag (81 00 00 1e) is shown on both the ingress and
egress packets with expected vid 30 (0x1e).

   Here also, the tailtags from/to the switch hardware (tag_ksz) are observed:
   - ingress tailtags (the 00 octet at end of ingress packets).
   - egress tailtags (the 20 00 01 octets at end of egress packets)

tcpdump on br0:
   listening on br0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
   13:27:46.917815 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806),
Request who-has 192.168.30.1 tell 192.168.30.251, length 46
   13:27:46.917869 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806),
Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
   13:27:46.918945 00:e0:4c:3f:f8:c2 > ea:38:5b:06:97:75, ethertype
802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4 (0x0800),
192.168.30.251 > 192.168.30.1: ICMP echo request, id 48, seq 1, length
64
   13:27:46.919016 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4 (0x0800),
192.168.30.1 > 192.168.30.251: ICMP echo reply, id 48, seq 1, length
64

   Here, vlan tag IDs have been decoded as the ingress packets passes
up to br0 and same vlan id 30 is shown on the reply packets.


Example showing the erroneous behaviour:
----------------------------------------
But, when connecting the other device to the PVID,untagged port
"afe1", the following is observed:

tcpdump on device sending the ping:
   listening on enx00e04c3ff8c2, link-type EN10MB (Ethernet), capture
size 262144 bytes
   13:31:23.862699 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
ARP (0x0806), length 42: Request who-has 192.168.30.1 tell
192.168.30.251, length 28
   13:31:23.864551 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply
192.168.30.1 is-at ea:38:5b:06:97:75, length 46
   13:31:24.890952 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
ARP (0x0806), length 42: Request who-has 192.168.30.1 tell
192.168.30.251, length 28
   13:31:24.892810 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply
192.168.30.1 is-at ea:38:5b:06:97:75, length 46
   13:31:25.910959 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
ARP (0x0806), length 42: Request who-has 192.168.30.1 tell
192.168.30.251, length 28
   13:31:25.912828 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply
192.168.30.1 is-at ea:38:5b:06:97:75, length 46

   Here, the reply packet errorneously contains vlan tag for vlan id
1, when it was expected to be untagged-on-egress from the switch, and
was expected to have vlan id 30.

tcpdump on DSA master interface eth1:
   listening on eth1, link-type NULL (BSD loopback), snapshot length
262144 bytes
   13:35:33.363982 AF Unknown (4294967295), length 65:
       0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
       0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
       0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
       0x0030:  0000 0000 0000 0000 0000 0000 01         .............
   13:35:33.364186 AF Unknown (14699583), length 63:
       0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
       0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
       0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
       0x0030:  0000 0000 0000 0000 2000 02              ...........
   13:35:34.392257 AF Unknown (4294967295), length 65:
       0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
       0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
       0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
       0x0030:  0000 0000 0000 0000 0000 0000 01         .............
   13:35:34.392385 AF Unknown (14699583), length 63:
       0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
       0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
       0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
       0x0030:  0000 0000 0000 0000 2000 02              ...........
   13:35:35.412251 AF Unknown (4294967295), length 65:
       0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
       0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
       0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
       0x0030:  0000 0000 0000 0000 0000 0000 01         .............
   13:35:35.412384 AF Unknown (14699583), length 63:
       0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
       0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
       0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
       0x0030:  0000 0000 0000 0000 2000 02              ...........

   Here, the vlan tag (81 00 00 1e) is *ONLY* present on the *ingress*
packets (the ARP requests), and *ABSENT* from the *egress* packets
(the ARP replies).

   Here also, the tailtags from/to the switch hardware (tag_ksz) are
observed and are as expected, this time corresponding to switch-port
"afe1".

tcpdump on br0:
   listening on br0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
   13:35:33.364069 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806),
Request who-has 192.168.30.1 tell 192.168.30.251, length 46
   13:35:33.364154 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806),
Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
   13:35:34.392307 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806),
Request who-has 192.168.30.1 tell 192.168.30.251, length 46
   13:35:34.392356 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806),
Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
   13:35:35.412300 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype
802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806),
Request who-has 192.168.30.1 tell 192.168.30.251, length 46
   13:35:35.412355 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype
802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806),
Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28

   Here, vlan tag IDs have been decoded as the packet passes up to
br0, and vlan id 30 is present on the replies, yet the vlan tag appear
to be dropped when the packet is sent down from br0 to eth1, as not
visible in the tcpdump of eth1 above.

I have checked and confirmed that "tx-vlan-offload" is "off" for eth1.

Other information:
------------------
root@imx8qxp-var-som:~# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.10.1.0       0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.10.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.10
192.168.20.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.20
192.168.30.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.30

root@imx8qxp-var-som:~# bridge vlan
port              vlan-id
afe0              1 PVID Egress Untagged
                 10
                 20
                 30
afe1              1 Egress Untagged
                 30 PVID Egress Untagged
afe3              1 Egress Untagged
                 30 PVID Egress Untagged
afe4              1 Egress Untagged
                 20 PVID Egress Untagged
afe2              1 Egress Untagged
                 30 PVID Egress Untagged
afe5              1 Egress Untagged
                 30 PVID Egress Untagged
afe6              1 Egress Untagged
                 30 PVID Egress Untagged
afe8              1 Egress Untagged
                 30 PVID Egress Untagged
afe9              1 Egress Untagged
                 30 PVID Egress Untagged
afe7              1 Egress Untagged
                 30 PVID Egress Untagged
br0               1 PVID Egress Untagged
                 10
                 20
                 30

Note: Another observation is that even after running "bridge vlan del
dev afe0 vid 1" or "bridge vlan del dev afe1 vid 1", the entry for
vlan-id 1 never disappears from the ouput of "bridge vlan show"

root@imx8qxp-var-som:~# bridge fdb
33:33:00:00:00:01 dev eth0 self permanent
01:00:5e:00:00:01 dev eth0 self permanent
33:33:00:00:00:01 dev eth1 self permanent
01:00:5e:00:00:01 dev eth1 self permanent
f8:dc:7a:bb:54:a1 dev afe0 vlan 20 master br0 permanent
f8:dc:7a:bb:54:a1 dev afe0 vlan 30 master br0 permanent
f8:dc:7a:bb:54:a1 dev afe0 vlan 10 master br0 permanent
f8:dc:7a:bb:54:a1 dev afe0 vlan 1 master br0 permanent
f8:dc:7a:bb:54:a1 dev afe0 master br0 permanent
00:e0:4c:3f:f8:c2 dev afe1 vlan 30 master br0
00:e0:4c:3f:f8:c2 dev afe1 vlan 10 self
00:e0:4c:3f:f8:c2 dev afe1 vlan 20 self
00:e0:4c:3f:f8:c2 dev afe1 vlan 30 self
33:33:00:00:00:01 dev br0 self permanent
01:80:c2:00:00:21 dev br0 self permanent
01:00:5e:00:00:6a dev br0 self permanent
33:33:00:00:00:6a dev br0 self permanent
01:00:5e:00:00:01 dev br0 self permanent
ea:38:5b:06:97:75 dev br0 vlan 30 master br0 permanent
ea:38:5b:06:97:75 dev br0 vlan 20 master br0 permanent
ea:38:5b:06:97:75 dev br0 vlan 10 master br0 permanent
ea:38:5b:06:97:75 dev br0 vlan 1 master br0 permanent
ea:38:5b:06:97:75 dev br0 master br0 permanent
33:33:00:00:00:01 dev br0.10 self permanent
01:00:5e:00:00:01 dev br0.10 self permanent
33:33:00:00:00:01 dev br0.20 self permanent
01:00:5e:00:00:01 dev br0.20 self permanent
33:33:00:00:00:01 dev br0.30 self permanent
01:00:5e:00:00:01 dev br0.30 self permanent

root@imx8qxp-var-som:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
group default qlen 1000
   link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
   inet 127.0.0.1/8 scope host lo
      valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
group default qlen 1000
   link/ether f8:dc:7a:bb:54:a0 brd ff:ff:ff:ff:ff:ff
   inet 10.10.1.4/24 brd 10.10.1.255 scope global eth0
      valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1507 qdisc mq state UP
group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
4: afe0@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
5: afe1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
master br0 state UP group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
6: afe3@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
7: afe4@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
8: afe2@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
9: afe5@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
10: afe6@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
11: afe8@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
12: lan1@eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
13: lan2@eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
14: afe9@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
15: afe7@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
   link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
16: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP group default qlen 1000
   link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
17: br0.10@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP group default qlen 1000
   link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
   inet 192.168.10.1/24 scope global br0.10
      valid_lft forever preferred_lft forever
18: br0.20@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP group default qlen 1000
   link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
   inet 192.168.20.1/24 scope global br0.20
      valid_lft forever preferred_lft forever
19: br0.30@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP group default qlen 1000
   link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
   inet 192.168.30.1/24 scope global br0.30
      valid_lft forever preferred_lft forever

Best Regards,
Simon

