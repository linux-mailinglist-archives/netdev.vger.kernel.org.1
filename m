Return-Path: <netdev+bounces-211921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05303B1C81A
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290C756578B
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A06B28FA87;
	Wed,  6 Aug 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xfjbSbKw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0428F958;
	Wed,  6 Aug 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492493; cv=none; b=NFdQUPjAKj0mGhdDrqTWCZeZphteE1Y8J9q2CA3csW9cTKL91Jwdv/krWjb6roQBZIsaV5cZhiLU4XXLOPkDLoU067DjrrV4udDa+Rbdk8BGes5iaOfSWdDc0CJ3A2rmZxyrOfGdlNlTTB2iI/rA6Ww+xF8huJ9qXtv3e1cWt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492493; c=relaxed/simple;
	bh=rQNIJlHRHG4C4FgpSDwf66MC/i7tJ+Xz17XeBAYuppg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXIzG8MrBnwrqAc3rSR0e8WPzpEBy54KYoUWcUJ8/AYAq67AP1flCDv0Ol/5CY/2f9fx7Br4rogUQMEx5+v32aglJnvZB/vRYqHqka/nKLpu3UtO4GpF53bMTfkjsnmTGQr8iv4xNgol3LC5rOHS/ERGGyOtFTqfrgmsu116lTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xfjbSbKw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ryoa+Ztf111PO2c6Sqsua4pClHmpT5cAMCQqHL/qJjY=; b=xfjbSbKwbPlNkpJVFJlfUR23Tw
	i3hDZ6cZZgt2wxW38lWbp3fQuJIms89XGInfbcyuvw7m/OcPaNFemqGVxHKnz48S85CGCdaRJyxOO
	Er8/xi7Ewr13KUYVqOkpIFuJWs7+asspOM2lOPLID72aIMFL8Cy1jW/twCYr+NigEQlk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujfdq-003tJZ-IS; Wed, 06 Aug 2025 17:01:22 +0200
Date: Wed, 6 Aug 2025 17:01:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, hkallweit1@gmail.com,
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>

> > > Reproduce step is simple:
> > > 
> > > 1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
> > >    DUB-E100 Fast Ethernet Adapter".

static const struct driver_info dlink_dub_e100_info = {
        .description = "DLink DUB-E100 USB Ethernet",
        .bind = ax88172_bind,
        .status = asix_status,
        .link_reset = ax88172_link_reset,
        .reset = ax88172_link_reset,
        .flags =  FLAG_ETHER | FLAG_LINK_INTR,
        .data = 0x009f9d9f,
};

{
        // DLink DUB-E100
        USB_DEVICE (0x2001, 0x1a00),
        .driver_info =  (unsigned long) &dlink_dub_e100_info,
}, {

Is this the device you have?

> > > 2. the asix driver (drivers/net/usb/asix_devices.c) will bind to this USB
> > >    device.
> > > 
> > > root@imx95evk:~# lsusb -t
> > > /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ci_hdrc/1p, 480M
> > >     |__ Port 001: Dev 003, If 0, Class=Vendor Specific Class, Driver=asix, 480M
> > > 
> > > 3. then the driver will create many mdio devices. 
> > > 
> > > root@imx95evk:/sys/bus/mdio_bus# ls -d devices/usb*
> > > devices/usb-001:005:00  devices/usb-001:005:04  devices/usb-001:005:08  devices/usb-001:005:0c  devices/usb-001:005:10  devices/usb-001:005:14  devices/usb-001:005:18  devices/usb-001:005:1c
> > > devices/usb-001:005:01  devices/usb-001:005:05  devices/usb-001:005:09  devices/usb-001:005:0d  devices/usb-001:005:11  devices/usb-001:005:15  devices/usb-001:005:19  devices/usb-001:005:1d
> > > devices/usb-001:005:02  devices/usb-001:005:06  devices/usb-001:005:0a  devices/usb-001:005:0e  devices/usb-001:005:12  devices/usb-001:005:16  devices/usb-001:005:1a  devices/usb-001:005:1e
> > > devices/usb-001:005:03  devices/usb-001:005:07  devices/usb-001:005:0b  devices/usb-001:005:0f  devices/usb-001:005:13  devices/usb-001:005:17  devices/usb-001:005:1b  devices/usb-001:005:1f
> > 
> > This looks broken - please check what
> > /sys/bus/mdio_bus/devices/usb*/phy_id contains.
> 
> root@imx95evk:~# cat /sys/bus/mdio_bus/devices/usb*/phy_id
> 0x00000000
> 0x00000000
> 0x00000000
> 0x02430c54
> 0x0c540c54
> 0x0c540c54
> 0x0c540c54
> 0x0c540c54

This suggests which version of the asix device has broken MDIO bus
access.

The first three 0x00000000 are odd. If there is no device at an
address you expect to read 0xffffffff. phylib will ignore 0xffffffff
and not create a device. 0x00000000 suggests something actually is on
the bus, and is responding to reads of registers 2 and 3, but
returning 0x0000 is not expected.

And then 0x02430c54 for all other addresses suggests the device is not
correctly handling the bus address, and is mapping the address
parameter to a single bus address.

What does asix_read_phy_addr() return?

This is completely untested, not even compiled:

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 9b0318fb50b5..e136b25782d9 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -260,13 +260,20 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
        dev->mii.dev = dev->net;
        dev->mii.mdio_read = asix_mdio_read;
        dev->mii.mdio_write = asix_mdio_write;
-       dev->mii.phy_id_mask = 0x3f;
        dev->mii.reg_num_mask = 0x1f;
 
        dev->mii.phy_id = asix_read_phy_addr(dev, true);
        if (dev->mii.phy_id < 0)
                return dev->mii.phy_id;
 
+       if (dev->mii.phy_id > 31) {
+               netdev_err(dev->net, "Invalid PHY address %d\n",
+                          dev->mii.phy_id);
+               return -EINVAL;
+       }
+
+       dev->mii.phy_id_mask = BIT(dev->mii.phy_id);
+
        dev->net->netdev_ops = &ax88172_netdev_ops;
        dev->net->ethtool_ops = &ax88172_ethtool_ops;
        dev->net->needed_headroom = 4; /* cf asix_tx_fixup() */

The idea is to limit the scanning of the bus to just the address where
we expect the PHY to be.  See if this gives you a single PHY, and that
PHY actually works.

	Andrew

