Return-Path: <netdev+bounces-212047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E83B1D82C
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3135A17EDC6
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140AE253939;
	Thu,  7 Aug 2025 12:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAD22522B4
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570729; cv=none; b=hpE04iMBEwhDeknxD1e7KzulscwOlhsd974Z8Zpa+AqtuQeetBT3yjZCqANf1uOrCKKGXTDMcht9YomE1UrwRRhTFOY3Gs+oTHRgv+My+uwVq3t1YdgwxAb5xC5Kp36hHURhvCIhvCUf/SURnSwTfK/kfdvDoQsBOHOjQQDSi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570729; c=relaxed/simple;
	bh=Y4YLzyteEcWT1U2UnCNBtRt82dIF4KnUK/CPV4evvjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYi2tRpCT/bFxoAgMRZ/J3YnY+wIiEKGSd0jlNjHv0rChlqNPPdPgGG+hAVXgByCVtRF/lOpRcZSjS6aqmdIG607mlNPOx4CG1FPCMHOf/bF8YpT94k6/GMaJvMN6ifqsOXEfAC/3KNKHqFlVvQROd0Bfxed4BIHv5DWALfpzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ujzzV-0003GE-FK; Thu, 07 Aug 2025 14:45:05 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ujzzU-00CNVQ-37;
	Thu, 07 Aug 2025 14:45:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ujzzU-00EJ2f-2h;
	Thu, 07 Aug 2025 14:45:04 +0200
Date: Thu, 7 Aug 2025 14:45:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Xu Yang <xu.yang_2@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	hkallweit1@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <aJSf0JaBl4cKphFi@pengutronix.de>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
 <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
 <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Aug 07, 2025 at 12:47:02PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 07, 2025 at 07:21:46PM +0800, Xu Yang wrote:
> > Hi Russell and Andrew,
> > 
> > With more debug on why asix_devices.c driver is creating so many mdio devices,
> > I found the mdio->phy_mask setting may be missing.
> 
> mdio->phy_mask is really only a workaround/optimisation to prevent
> the automatic scanning of the MDIO bus.
> 
> If we know for certain that we're only interested in a PHY at a
> certain set of addresses, then it's appropriate to tell the MDIO/phylib
> layer not to bother scanning the other addresses, but this will mean
> if the driver uses e.g. phy_find_first(), it will find the first PHY
> amongst those that phy_mask allows to be scanned, rather than the first
> on the bus.
> 
> In other words... it's dependent on the driver.
> 
> > diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> > index 9b0318fb50b5..9fba1cb17134 100644
> > --- a/drivers/net/usb/asix_devices.c
> > +++ b/drivers/net/usb/asix_devices.c
> > @@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
> >         priv->mdio->read = &asix_mdio_bus_read;
> >         priv->mdio->write = &asix_mdio_bus_write;
> >         priv->mdio->name = "Asix MDIO Bus";
> > +       priv->mdio->phy_mask = ~BIT(priv->phy_addr);
> >         /* mii bus name is usb-<usb bus number>-<usb device number> */
> >         snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
> >                  dev->udev->bus->busnum, dev->udev->devnum);
> > 
> > Is this the right thing to do?
> 
> If we're only expecting a MDIO device at priv->phy_addr, then I
> guess it's fine. Looking at the driver, I don't understand the
> mixture of dev->mii.* and priv->mdio->*, and sadly I don't have
> time to look in depth at this driver to work that out.

Hm, I guess, with this change there will be a subtile regression.
In case of an external PHYs the ax88772_init_phy() is using PHYlib to
suspend the internal PHY.

May be:
  priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

