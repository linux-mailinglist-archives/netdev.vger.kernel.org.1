Return-Path: <netdev+bounces-103799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF49098B5
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5051C20D5E
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1A482EB;
	Sat, 15 Jun 2024 14:49:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A611DFEA;
	Sat, 15 Jun 2024 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718462974; cv=none; b=XmUtvcTi6tNtB1k7lGOnsE6JyZK6isl69PRE9GynGM52lEbpu7oWn2xyt3ZB3zlwvjPTUlM5Ops3XZ6N/RIifrTW8iTkmLxc78h/pCcPsEkDiQu+yOkq/ErEdztZ8LMaw7lBbaWnMDxiDV+S7syPeACRzqhw3hJCZn0aXGahOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718462974; c=relaxed/simple;
	bh=76LIfSrMxlpIj4d0bev9L7y98p2HjHo5ZQ+5a2BpE/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVaw8pCQhajOT/O5SEwixc2isgR3Usx3Yftq1AFneqgN/eLG2rh59ijBe6Zpu44Fb4BuPxbKtSoNKhlOks5BU6fkFJMo8ziLnKDCzARRAjZC5H9oG7r13fRZkjhblpl1T9DIV4NUNwQpn17ojnx9x//s7gxsVP0sQee6zWadFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sIUTJ-00000000661-10GU;
	Sat, 15 Jun 2024 14:33:37 +0000
Date: Sat, 15 Jun 2024 15:33:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: John Thomson <git@johnthomson.fastmail.com.au>, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: dsa: generate port ifname if exists or
 invalid
Message-ID: <Zm2mOZGPuPstMdlB@makrotopia.org>
References: <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
 <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
 <20240613114314.jxmjkdbycqqiu5wn@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613114314.jxmjkdbycqqiu5wn@skbuf>

Hi Vladimir,

On Thu, Jun 13, 2024 at 02:43:14PM +0300, Vladimir Oltean wrote:
> On Sat, Jun 08, 2024 at 11:47:24AM +1000, John Thomson wrote:
> > RFC:
> > Not a full solution.
> > 
> > Not sure if supported, I cannot see any users in tree DTS,
> > but I guess I would need to skip these checks (and should mark as
> > NEM_NAME_ENUM) if port->name contains '%'.
> > 
> > name is also used in alloc_netdev_mqs, and I have not worked out if any
> > of the functionality between alloc_netdev_mqs and the register_netdevice
> > uses name, so I added these test early, but believe without a rntl lock,
> > a colliding name could still be allocated to another device between this
> > introduced test, and where this device does lock and register_netdevice
> > near the end of this function.
> > To deal with this looks to require moving the rntl_lock before
> > these tests, which would lock around significantly more.
> > 
> > As an alternative, could we possibly always register an enumerated name,
> > then (if name valid) dev_change_name (not exported), while still within
> > the lock after register_netdevice?
> > 
> > Or could we introduce a parameter or switch-level DTS property that forces
> > DSA to ignore port labels, so that all network devices names can be
> > managed from userspace (using the existing port DSA label as intended name,
> > as this still seems the best place to define device labels, even if the
> > driver does not use this label)?
> 
> Why not just _not_ use the 'label' device tree property, and bring
> a decent udev implementation into OpenWrt which can handle persistent
> naming according to the labels on the box? Even within DSA, it is
> considered better practice to use udev rather than 'label'. Not to
> mention that once available, udev is a uniform solution for all network
> interfaces, unlike 'label'.

Sounds fine generally. Where would you store the device-specific renaming
rules while making sure you don't need to carry the rules for all devices
onto every single device? Would you generate a device-specific rootfs for
each and every device? For obvious reasons this is something we'd very
much like to avoid, as building individual filesystems for ~ 1000 devices
would be insane compared to having a bunch (< 100) of generic filesystems
which some of them fitting a large group (ie. same SoC) of boards.
Most OpenWrt devices out there are based on the same SoCs, so currently
the devices in the popular targets like MT7621 or IPQ40xx all share the
same target-wide kernel **and rootfs**.

tl;dr: The good thing about the 'label' property is certainly that such
board- specific details are kept in DT, and hence a generic rootfs can
deal with it.

As having the 'label' property applied also for non-DSA netdevs by the
kernel has been rejected we did come up with a simple userland
implementation:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=2a25c6ace8d833cf491a66846a0b9e7c5387b8f0

For interfaces added at a later stage at boot, ie. by loading kernel modules
or actual hotplug, we could do the same in a hotplug script.

So yes, dropping support for dealing with the 'label' property in kernel
entirely would also fix it for us, because then we would just always deal
with it in userland (still using the same property in DT, just not applied
by the kernel).

> 
> Full disclosure: I myself tried for about 30 minutes to convert the udev
> rules below into an /etc/hotplug.d script that procd would run, before
> getting the impression it's never going to work as intended, because by
> the time all relevant "add" actions run (built-in drivers), user space
> hasn't even loaded, and thus hasn't got a chance to run any hooks.
> I haven't actually opened the source code to compare how other uevent
> handlers deal with this.
> 
> ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p0", NAME="swp0"
> ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p1", NAME="swp1"
> ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p2", NAME="swp2"
> ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p3", NAME="swp3"
> ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p4", NAME="swp4"
> ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p5", NAME="swp5"
> 

Yes, this is a problem in general. We will need better coldplug support,
right now only devices added after procd is launched are taken care of.


Cheers


Daniel

