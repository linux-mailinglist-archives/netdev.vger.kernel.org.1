Return-Path: <netdev+bounces-211955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFAB1C9ED
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4718A71F1
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C228C2A6;
	Wed,  6 Aug 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I5K9k/CK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DA1E0E0B;
	Wed,  6 Aug 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498885; cv=none; b=owVHEbSFPt8owpXGuerZ5eAXVJH0CQuMvWYa/Eqj4UYm4p1bEOTd6oxv4qWZJdKYF48tzMtVj7yAS5ENZO9kO5Y+8iMzRQpVY84CQxQKg7F6V4QArUjRWvw9Fgn6K04FeWC3Fp3G+X3IoT6gBiqcyI/R1gOd5MHIC32XKhDXczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498885; c=relaxed/simple;
	bh=ciYWewOVMgSPCSH7WY07nuIbN1qGHOZw1W7rusM5pOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrjbJn6a4p8DIdVQheBx+G66vrmHRXVBv4TpvfR4tjLnOV0Q3OK53DQP2q4AK37jK17hMz5d2ElI0qLA6vJiQJHaufy1n5m+TcqwxdCypQnTYXOunsdsbg4fTYW9BeHiOOaglMEyp0LeUt/b/ERfUo3D5xLI7UddD0Ua5ciPVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I5K9k/CK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FJqi3W+1W9dANvOzW3UBzJD8P0EsYpYh1y8mcChjELA=; b=I5K9k/CKsHcahDPxkA5oE9oF7p
	9qd84S+DBBvjzxuaHkdMD8IGDHzuk+0I4iUDtJjeGIKMCgloPa52uC5kGiyLpu4rxHWRNqJbJBF79
	sRzLGWfcoDKyPel3MVjW26++GOXShF0yBORhqakvSLYTCCo3I9TsBosTVgOS6p5L97KnHLVZuP5y7
	jmxcxRFAnLDfxIUeMwstUBHI4el/kdaBUl2rH7/BNwivmuLRkM4JZLPXXxKUiCefXAw9adye7w/SN
	PttT7PU/Ojk5fyRzr0sqnELpglKB802VAmWY0ENBu7USnrZ7NHnCYyCMp4wQAhlgZYxr59IaVs0RX
	/N2T4VoQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45100)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ujhIy-0004qT-1C;
	Wed, 06 Aug 2025 17:47:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ujhIv-0007GE-2c;
	Wed, 06 Aug 2025 17:47:53 +0100
Date: Wed, 6 Aug 2025 17:47:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xu Yang <xu.yang_2@nxp.com>, hkallweit1@gmail.com,
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 06, 2025 at 05:01:22PM +0200, Andrew Lunn wrote:
> > > > Reproduce step is simple:
> > > > 
> > > > 1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
> > > >    DUB-E100 Fast Ethernet Adapter".
> 
> static const struct driver_info dlink_dub_e100_info = {
>         .description = "DLink DUB-E100 USB Ethernet",
>         .bind = ax88172_bind,
>         .status = asix_status,
>         .link_reset = ax88172_link_reset,
>         .reset = ax88172_link_reset,
>         .flags =  FLAG_ETHER | FLAG_LINK_INTR,
>         .data = 0x009f9d9f,
> };
> 
> {
>         // DLink DUB-E100
>         USB_DEVICE (0x2001, 0x1a00),
>         .driver_info =  (unsigned long) &dlink_dub_e100_info,
> }, {
> 
> Is this the device you have?
> 
> > > > 2. the asix driver (drivers/net/usb/asix_devices.c) will bind to this USB
> > > >    device.
> > > > 
> > > > root@imx95evk:~# lsusb -t
> > > > /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ci_hdrc/1p, 480M
> > > >     |__ Port 001: Dev 003, If 0, Class=Vendor Specific Class, Driver=asix, 480M
> > > > 
> > > > 3. then the driver will create many mdio devices. 
> > > > 
> > > > root@imx95evk:/sys/bus/mdio_bus# ls -d devices/usb*
> > > > devices/usb-001:005:00  devices/usb-001:005:04  devices/usb-001:005:08  devices/usb-001:005:0c  devices/usb-001:005:10  devices/usb-001:005:14  devices/usb-001:005:18  devices/usb-001:005:1c
> > > > devices/usb-001:005:01  devices/usb-001:005:05  devices/usb-001:005:09  devices/usb-001:005:0d  devices/usb-001:005:11  devices/usb-001:005:15  devices/usb-001:005:19  devices/usb-001:005:1d
> > > > devices/usb-001:005:02  devices/usb-001:005:06  devices/usb-001:005:0a  devices/usb-001:005:0e  devices/usb-001:005:12  devices/usb-001:005:16  devices/usb-001:005:1a  devices/usb-001:005:1e
> > > > devices/usb-001:005:03  devices/usb-001:005:07  devices/usb-001:005:0b  devices/usb-001:005:0f  devices/usb-001:005:13  devices/usb-001:005:17  devices/usb-001:005:1b  devices/usb-001:005:1f
> > > 
> > > This looks broken - please check what
> > > /sys/bus/mdio_bus/devices/usb*/phy_id contains.
> > 
> > root@imx95evk:~# cat /sys/bus/mdio_bus/devices/usb*/phy_id
> > 0x00000000
> > 0x00000000
> > 0x00000000
> > 0x02430c54
> > 0x0c540c54
> > 0x0c540c54
> > 0x0c540c54
> > 0x0c540c54
> 
> This suggests which version of the asix device has broken MDIO bus
> access.
> 
> The first three 0x00000000 are odd. If there is no device at an
> address you expect to read 0xffffffff. phylib will ignore 0xffffffff
> and not create a device. 0x00000000 suggests something actually is on
> the bus, and is responding to reads of registers 2 and 3, but
> returning 0x0000 is not expected.
> 
> And then 0x02430c54 for all other addresses suggests the device is not
> correctly handling the bus address, and is mapping the address
> parameter to a single bus address.

Notice that the following return the PHY 3 register 3 value, so
I suspect for anything that isn't PHY 3, it just returns whatever
data was last read from PHY 3. This makes it an incredibly buggy
USB device.

Looking at usbnet_read_cmd(), the above can be the only explanation,
as usbnet_read_cmd() memcpy()'s the data into &res, so the value
in the kmalloc()'d buf (which likely be poisoned on free, or if not
unlikely to reallocate the same memory - that needs to be verified)
must be coming from firmware on the device itself.

asix_read_cmd() will catch a short read, and usbnet_read_cmd() will
catch a zero-length read as invalid.

So, my conclusion is... broken firmware on this device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

