Return-Path: <netdev+bounces-185140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE22A98AF3
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787881641BA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ABD18DB19;
	Wed, 23 Apr 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBqjsgma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81E17E473
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414815; cv=none; b=PPm84RwBtdmNkQPs1Xrlq1vHg1HdKMyKc8duwfMlNUe89sZpxSx6AOI5JPQJoUTghW/jEjJJJcg/2a+6+HZj7273OlnQwUi+juCXV3k9y0Cui8eKCLyp/a4jW+SpDfGP+Te3YtP3H1AoWoUbknnJV+fZD0+mpYivRl8tkHgWsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414815; c=relaxed/simple;
	bh=qIskGtVs7GeF9GBQW9qfVRtNcUl45EcSAkD0wx5Bjto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNXhqibtTvoXajXAPTFo+2/eL53ytGX2m1TpgCWyOpQ3mtOHaUdh7WvSIq+YaMFVYQmBhr4tJyFJIU1u5Rbm4CtAbYmz2a4osypvCxfIBDEuBE65XAaASYxGDi+Q3Y/606uBHmkzZLkiEpN7oLeTGhKg9OwDX61EJJv8TpLElc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBqjsgma; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30828fc17adso5634390a91.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745414813; x=1746019613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHxjJhGXcD76oxltB2bAVjGrDapFSSNu8e0qmRJfMEY=;
        b=UBqjsgman7Yep5Fe9AWitM7qC+IEfj1POgXkMy+bDE478VX95SCoNxZITesjl9+bON
         juGc+7/DxM+VqNWYUvh9cbYZ7rnXHFmhMKqVXu5Tg3vNa7A8xKw36Gmc3safyCUrNSfz
         uXUc+Ei4Y/w+/90DDFkXaUSrq1IfPkdasxAqaIBZJcTrwla+KwGOBCFCGVlNmnP2Ra5t
         i2OyIi4CUJPj0rdP8w7LPC2cX0qQTppENyDo7VvxNXttNWfMy458V9jkWKg6Rb59ssOA
         MziR7qBzDNlAD9sg+qLgDuSsgTP42tYiyAwIo5hq+/uI0R0hRBw5Z5Wm4eN6zV4ES7b4
         /9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745414813; x=1746019613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHxjJhGXcD76oxltB2bAVjGrDapFSSNu8e0qmRJfMEY=;
        b=gSlbA3iblEHCEwjOswk6GkGNAq29r3AUjfCuEvQvTUpCjMY/jO0c7ViFUmnN69intn
         ffkJwuNeQRQpRNmIti1LVG9azogjyiky0LbPsEtKt64sWhiWv5RFSspLyAKvo8qiPpSC
         JTn10UfQytZEZpGzWMCvBqAqPfetN7PNtFESZ4d8DeuK1QCkiso88FEE0jnx/SuoRU2C
         G0ThEjJ1kfWSeC1n9pzi4mjciDn6tdjso71Lq6OjWNKiVoo989EaIA5p3y7q3/r2fIzq
         S063SVJZMaX+XuOUnH8QuS+gsAprfRQo3LldJjUoCBnV7hEVw8gybF2QpR4U6WeHLeGZ
         Go2A==
X-Gm-Message-State: AOJu0YzmRUyjtRz7OmIdijyW2C1+eYec99TnvKYc3wPzQ6BAyPNr61VH
	ipiyGOpDMHgKhc0pzJti9HZ9F6u/imfQ5BMlHNmPgjxrS9dLotQrZktMIDOt9rG3xMVS3csUyDJ
	aSvc72jAA/zUsQzN37YGHvYAyGPKtPy4C
X-Gm-Gg: ASbGncvOiBNFiBc5H5Urx/7O1Og6IiQ7QWn5WNzImNMk2IHvH/EVQYFgHI5p4bvSvyn
	Au67rkVgH9CxPM5C2WfnJElceY9T2S/f5xp1Vq/3BjLNuSlMziYrWWgnWRBDiwrInR+uYO2RviP
	1REjM4f0F6ZbSQqkx6pTWxYXO1eLitmmDRUlosyVEmUFtzDyc/iwxlIIHX
X-Google-Smtp-Source: AGHT+IFoG6C/PU7awwWR2yffLKL/9PYOnTul2Xo8XXviZhxPaHEFJjkcCDbelKEM/aIIZx5t+UcCd0AyqcfQ8C5EDI0=
X-Received: by 2002:a17:90b:5243:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-3087bb66a15mr32582930a91.16.1745414812585; Wed, 23 Apr 2025
 06:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
 <aAjSCwwuRpI8GdB7@shredder>
In-Reply-To: <aAjSCwwuRpI8GdB7@shredder>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Wed, 23 Apr 2025 06:26:40 -0700
X-Gm-Features: ATxdqUHGdJjfM9XygT-U0U6MPzrBFpg31sW2DgePl-nQ2PdEdUeyr7rAsizn-OQ
Message-ID: <CAEFUPH0cU-5ZJ_qAevp1DENYrUkSO4zipUTg0vzLmgz16nPbbw@mail.gmail.com>
Subject: Re: query on EAPOL multicast packet with linux bridge interface
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Ido.

Here is the details of my setup:

I have a microchip CPU connected to an 11 port marvell 88E6390 switch.
I am using the marvel  linux DSA driver  so that all the switch ports
(lan1, lan2, lan3 etc) are part of the linux kernel.

I am using hostapd as an authenticator.

An 802.1x client device is connected to port lan1 and binds this port
(lan1) to hostapd daemon, I can see EAPOL packets are being forwarded
to a radius server.

I have created a bridge with vlan filtering with below commands and
bind the bridge (br0) with hostapd daemon. Now EAPOL packets are not
forwarded.

ip link add name br0 type bridge vlan_filtering 1
ip link set dev lan1 master br0
ip link set dev lan2 master br0
bridge vlan add dev lan1 vid 10 pvid untagged
bridge vlan add dev lan2 vid 10 pvid untagged
ip link set dev br0 up
ip link set dev lan1 up
ip link set dev lan2 up
ip link add link br0 name br0.10 type vlan id 10
ip link set dev br0.10 up
ip addr add 192.168.2.1/24 dev br0.10
bridge vlan add vid 10 dev br0 self

bridge vlan show
port              vlan-id
lan1              10 PVID Egress Untagged
lan2              10 PVID Egress Untagged
br0                10

echo 8 > /sys/class/net/br0/bridge/group_fwd_mask
cat /sys/class/net/br0/bridge/group_fwd_mask
0x8

root@sama7g5ek-tdy-sd:~# cat /etc/hostapd.conf
##### hostapd configuration file ##########################################=
####
# Empty lines and lines starting with # are ignored

# Example configuration file for wired authenticator. See hostapd.conf for
# more details.
interface=3Dbr0
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>passing br0 as interface to
hostapd.
driver=3Dwired



Regards
Simon


On Wed, Apr 23, 2025 at 4:42=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Tue, Apr 22, 2025 at 06:42:58PM -0700, SIMON BABY wrote:
> > Hello,
> >
> > I have a difficulty with making EAPOL packet forwarding with the Linux
> > bridge interface.
> >
> >  I have configured the group_fwd_mask parameter with the below value.
> >
> >  echo 8 > /sys/class/net/br0/bridge/group_fwd_mask
> >
> > I still could not see the EAPOL packets being forwarded  from the
> > linux bridge interface . However I can see the EAPOL packets are
> > forwarded if I use it as a regular interface.
> >
> > Do we have any more settings?
>
> What do you mean by "linux bridge interface"? The bridge device itself
> or a bridge port? Also, what is "regular interface"?
>
> The following script [1] seems to work fine for me:
>
> EAPOL packets on h2 without group_fwd_mask: 0
> EAPOL packets on h2 with group_fwd_mask: 1
>
> Can you adjust it to show the problem you are referring to?
>
> Thanks
>
> [1]
> #!/bin/bash
>
> # Setup
> #
> for ns in h1 h2 br; do
>         ip netns add $ns
>         ip -n $ns link set dev lo up
> done
>
> ip -n h1 link add name veth0 type veth peer name veth1 netns br
> ip -n h2 link add name veth2 type veth peer name veth3 netns br
>
> ip -n h1 link set dev veth0 up
> ip -n h2 link set dev veth2 up
>
> ip -n br link add name br0 up type bridge
> ip -n br link set dev veth1 up master br0
> ip -n br link set dev veth3 up master br0
>
> tc -n h2 qdisc add dev veth2 clsact
> tc -n h2 filter add dev veth2 ingress pref 1 proto all \
>         flower dst_mac 01:80:c2:00:00:03 action pass
>
> # Without group_fwd_mask
> #
> ip netns exec h1 mausezahn veth0 -a own -b 01:80:c2:00:00:03 -c 1 -q
> sleep 1
> pkt=3D$(tc -n h2 -s -j -p filter show dev veth2 ingress | \
>         jq ".[] | select(.options.handle =3D=3D 1) | .options.actions[0].=
stats.packets")
>
> echo "EAPOL packets on h2 without group_fwd_mask: $pkt"
>
> # With group_fwd_mask
> #
> ip -n br link set dev br0 type bridge group_fwd_mask 0x0008
> ip netns exec h1 mausezahn veth0 -a own -b 01:80:c2:00:00:03 -c 1 -q
> sleep 1
> pkt=3D$(tc -n h2 -s -j -p filter show dev veth2 ingress | \
>         jq ".[] | select(.options.handle =3D=3D 1) | .options.actions[0].=
stats.packets")
> echo "EAPOL packets on h2 with group_fwd_mask: $pkt"
>
> # Cleanup
> #
> for ns in h1 h2 br; do
>         ip netns del $ns
> done

