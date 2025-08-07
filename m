Return-Path: <netdev+bounces-212050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D16B1D851
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63D1722DB2
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25112550D5;
	Thu,  7 Aug 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jARgqw6C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937F252287;
	Thu,  7 Aug 2025 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571320; cv=none; b=HhzkeLz5WCeANe9MoFRoFOkkFTVAbST1YcE6YNvK55PlwNHo0d0Y/5P535Os6AViuA8SUHgOY1qBIiw4FLeprIoGvZFX2XId5t1FiIOYIdtatoPq4/6tfrjUwVpMf6+9hEDAWTTqBQUKbtmNzmm1tm0ylDzTiJ5mt+7JsVkQBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571320; c=relaxed/simple;
	bh=VP1x1C2TMJw2qzgV/aK2US2O1jwTyKXCW6X2Wq7tbH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZBYYL1nOWQQPjBBppM2+G3d6YGYqI0gSPgtwSBDPdtDimeMtl8hYXsSSuuWTqFSVAkmwPnrjpqmFNjhbyIcVWSUeFpxIpRXY1MAkYTVvwNlu6wY/LQDk+X+X2ZlIcGMkSe7Tvhs1aRUH4BWM94gNRa/Tqgtod1R6yRVA3dVd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jARgqw6C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TuW6mAl/8kZ0b8oYSAZYeu8508XdSmqyTX6zbQ3bOI0=; b=jARgqw6C6mCszxBm2Rphmmo7ZB
	ZvbzzDPxBIN5I6cG/BiWA1OcoEdp21CA4utVWuYKs+SPX3O98fHgP+BD8nQ3G21me5lsJAUpI3R1Z
	Kh8ddcsNt04TqhZ1hFqP7gm3eH4fANsnBCBjIM5quOqDGfegkCXEPCSqVqvHBvg8eb8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uk09E-003y8D-Tt; Thu, 07 Aug 2025 14:55:08 +0200
Date: Thu, 7 Aug 2025 14:55:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, hkallweit1@gmail.com,
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <39d7c6be-c3e9-4c2f-b814-e0b2e838ad41@lunn.ch>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
 <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>

> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 9b0318fb50b5..9fba1cb17134 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
>         priv->mdio->read = &asix_mdio_bus_read;
>         priv->mdio->write = &asix_mdio_bus_write;
>         priv->mdio->name = "Asix MDIO Bus";
> +       priv->mdio->phy_mask = ~BIT(priv->phy_addr);
>         /* mii bus name is usb-<usb bus number>-<usb device number> */
>         snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
>                  dev->udev->bus->busnum, dev->udev->devnum);
> 
> Is this the right thing to do?

This is what i was trying to do, i just put it in the wrong place
because i had the wrong device.

ax88772_init_phy() will only use the PHY at address priv->phy_addr, so
this appears to be safe.

The alternative is to have a custom asix_mdio_read() for this device,
which returns -ENODEV if the phy_id being read does not equal
priv->phy_addr. That will also prevent these extra PHYs from being
created.

	Andrew

