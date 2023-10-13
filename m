Return-Path: <netdev+bounces-40888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEFD7C9052
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE2B20B38
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4FE250E8;
	Fri, 13 Oct 2023 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzd2Yy3F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9782C852
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 22:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D5EC433C8;
	Fri, 13 Oct 2023 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697236566;
	bh=KDeqnuX0ftWufp6sZJSSV2ClFe0LdNja3kr0DCnhBs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uzd2Yy3FEwOuBO2HUqdBnmennzrD5jLTuTUPpYUijS8vrTSdAoxt/kqCeRjj2OXHm
	 51w1yH+KX9Sz+VClafpo0c4iZCHUsCKIf+8+YJ2914ndSe3bsfsLfrAXtb6VoU7B2a
	 Ts1Q1eK2vCgSJEOMsErZsVEel00yItoi6UBnC+fgtC3GAuq/MQPVuYuG2XhgiBx7OS
	 Due2Y7Yr8oM1NM6AlPz2aj3agXLGqdhWrLx3oxLqWiYJUsN0M67jqolJc71STHGZ3t
	 ofIeh+adnloM8Y535EyqnKYMNRsLJkRQIsUBT+s/jzc05netCaTgqhkcdMG8JKQ1au
	 z6mEqbMWWyDVQ==
Date: Fri, 13 Oct 2023 15:36:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel =?UTF-8?B?R3LDtmJlcg==?= <dxld@darkboxed.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Richard Weinberger <richard@nod.at>, Serge Hallyn
 <serge.hallyn@canonical.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <20231013153605.487f5a74@kernel.org>
In-Reply-To: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
References: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Oct 2023 14:10:03 +0200 Daniel Gr=C3=B6ber wrote:
> Changing a device's netns and renaming it with one RTM_NEWLINK call causes
> a rogue MOVE uevent to be delivered to the new netns in addition to the
> expected ADD uevent.
>=20
> iproute2 reproducer:
>=20
>     $ ip netns add test
>     $ ip link add dev eth0 netns test type dummy
>     $ ip link add dev eth0 type dummy
>=20
>     $ ip -netns test link set dev eth0 netns 1 name eth123
>=20
> With the last command, which renames the device and moves it out of the
> netns, we get the following:
>=20
>     $ udevadm monitor -k
>     KERNEL[230953.424834] add      /devices/virtual/net/eth0 (net)
>     KERNEL[230953.424914] move     /devices/virtual/net/eth0 (net)
>     KERNEL[230953.425066] move     /devices/virtual/net/eth123 (net)

FTR I don't see the move on current net-next, I see two adds=20
and one move.

 [ ~]# udevadm monitor -k &
 monitor will print the received events for:
 KERNEL - the kernel uevent

 [ ~]# ip netns add test
 [ ~]# ip link add dev eth0 netns test type dummy
 KERNEL[115.393650] add      /module/dummy (module)
 [ ~]# ip link add dev eth0 type dummy
 KERNEL[121.702300] add      /devices/virtual/net/eth0 (net)
 KERNEL[121.704608] add      /devices/virtual/net/eth0/queues/rx-0 (queues)
 KERNEL[121.704733] add      /devices/virtual/net/eth0/queues/tx-0 (queues)
 [ ~]# ip -netns test link set dev eth0 netns 1 name eth123
 KERNEL[135.598907] add      /devices/virtual/net/eth0 (net)
 KERNEL[135.600425] move     /devices/virtual/net/eth123 (net)

I don't think it matters for the problem you're describing, tho.

> The problem is the MOVE event hooribly confuses userspace. The particular
> symptom we're seing is that systemd will bring down the ifup@eth0.service
> on the host as it handles the MOVE of eth0->eth123 as a stop for the
> BoundTo sys-subsystem-net-devices-eth0.device unit.
>=20
> I also create a clashing eth0 device on the host in the repro to
> demonstrate that the RTM_NETLINK move+rename call is atomic and so the MO=
VE
> event is entirely nonsensical.
>=20
> Looking at the code in __rtnl_newlink I see do_setlink first calls
> __dev_change_net_namespace and then dev_change_name. My guess is the order
> is just wrong here.

Interesting. My analysis is slightly different but only in low level
aspects.. tell me if I'm wrong:

1. we have tb[IFLA_IFNAME] set, so do_setlink() will populate ifname

2. Because of #1, __dev_change_net_namespace() gets called with=20
   new name provide (pat =3D eth123)

3. It will do netdev_name_in_use(), which returns true.

4. It will then call dev_get_valid_name() which, (confusingly?) already
   sets the new name on the netdevice itself.

5. It then calls device shutdown from the source netns.
   This results in Bug#1, the netlink notification carries=20
   the new name in the old netns.

 [ ~]# ip -netns test link add dev eth0 netns test type dummy
 [ ~]# ip -netns test link add dev eth1 netns test type dummy
 [ ~]# ip -netns test link set dev eth0 netns 1 name eth1

ip monitor inside netns:

 5: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default=20
     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff
 6: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default=20
     link/ether 1e:4a:34:36:e3:cd brd ff:ff:ff:ff:ff:ff

 Deleted inet eth0=20
 Deleted inet6 eth0=20
 Deleted 5: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group de=
fault=20
     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff new-netnsid 0 new-i=
findex 7

tells us we deleted eth1, ifindex 5, which is not true. It was eth0.

Small sidebar - altnames are completely broken when it comes to netns,
too:

 [ ~]# ip link add dev eth0 type dummy
 [ ~]# ip link add dev eth1 type dummy
 [ ~]# ip link property add dev eth1 altname eth0
 RTNETLINK answers: File exists

^ it's not letting us use eth0 because device eth0 exists, but

 [ ~]# ip netns add test
 [ ~]# ip -netns test link add dev ethX netns test type dummy
 [ ~]# ip -netns test link property add dev ethX altname eth0
 [ ~]# ip -netns test link set dev ethX netns 1 =20

 [ ~]# ip li
 ...
 3: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT gro=
up default qlen 1000
     link/ether 02:40:88:62:ec:b8 brd ff:ff:ff:ff:ff:ff
 ...
 5: ethX: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT gro=
up default qlen 1000
     link/ether 26:b7:28:78:38:0f brd ff:ff:ff:ff:ff:ff
     altname eth0

and we have eth0 altname. So that's Bug#2.
Picking back up after the shutdown in old netns.

6. We call:

   kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
   dev_net_set(dev, net);
   kobject_uevent(&dev->dev.kobj, KOBJ_ADD);

Those are the calls you see in udev, recall that device core has
its own naming, so both of those calls will use the _old_ name.
REMOVE in the source netns and ADD in the destination netns.

The kobject calls were added by Serge in 4e66ae2ea371c, in 2012,
curiously it states:

    v2: also send KOBJ_ADD to new netns.  There will then be a
    _MOVE event from the device_rename() call, but that should
    be innocuous.

Which was based on this conversation:
https://lore.kernel.org/all/20121012031328.GA5472@sergelap/

7. Now we finally call:

   err =3D device_rename(&dev->dev, dev->name);

Which tells device core that the name has changed, and gives you=20
the (second) MOVE event. This time with the correct name.

Which is what you're seeing, Bug#3, the ADD event should be after
the call to device_rename()...

Bug#1 and Bug#2 we can fix in networking. Bug#3 is a bit more tricky,
because what we want is a "silent" rename, without generating the MOVE.
This email is a bit long, so let me cut off here..

