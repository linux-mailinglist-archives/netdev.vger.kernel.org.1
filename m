Return-Path: <netdev+bounces-57807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BBB81438E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F9283A41
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEEE125CF;
	Fri, 15 Dec 2023 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WBZ/+Db9"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED6171A6;
	Fri, 15 Dec 2023 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C67AAC32E2;
	Fri, 15 Dec 2023 08:22:35 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20E65240002;
	Fri, 15 Dec 2023 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702628548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2SdfyIEZV2kiNZwok/icKWjrI2x4IKlWemgzWowJp4=;
	b=WBZ/+Db9t2eJNWxJ1hfsHkxb/71yPIwTtHuWahx9bMiYjGDkJwMCP1NsQ2QvhPz6emKehO
	T5nGoke/sqhUo2tYlyUVwbMIuTu4Nxss9NxcKOoqB1pX4xWe+EMUQwQky7QcwBefJc1oDh
	ptQkuJSKZxlTWGLRS782j8V0llrvQ0oZvnetUvmdbTC5XQNWj7EMya5MDDg4pZa/sSMv4L
	BdCLIwDEiTmS5fmHb6ioUANOOD9KTgkndNId7nPIAas0MDBxsx/pUEeN1+lmZvplNTyeRS
	7RTd/hRMDN7IFRypSndpAH/OG2vC+1xYMNAo/8SUXXTWn4soSbAJty1r8gBQag==
Date: Fri, 15 Dec 2023 09:22:45 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>, 
    Marek Vasut <marex@denx.de>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
    Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    kernel@pengutronix.de, linux-clk@vger.kernel.org, 
    Stephen Boyd <sboyd@kernel.org>, 
    Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start
 up
In-Reply-To: <ZXsyA+2USrmIaF3u@shell.armlinux.org.uk>
Message-ID: <4148e039-9c36-cea4-5787-3e4f254e1728@bootlin.com>
References: <20230804175842.209537-1-marex@denx.de> <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com> <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de> <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de> <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com> <20230809060836.GA13300@pengutronix.de> <ZNNRxY4z7HroDurv@shell.armlinux.org.uk> <ZNS8LEiuwsv660EC@shell.armlinux.org.uk>
 <7aabc198-9df5-5bce-2968-90d4cda3c244@bootlin.com> <ZXsyA+2USrmIaF3u@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com


On Thu, 14 Dec 2023, Russell King (Oracle) wrote:

> On Thu, Dec 14, 2023 at 09:13:58AM +0100, Romain Gantois wrote:
> > Hello Russell,
> > 
> > I've implemented and tested the general-case solution you proposed to this 
> > receive clock issue with stmmac drivers. The core of your suggestion is pretty 
> > much unchanged, I just added a phylink_pcs flag for standalone PCS drivers that 
> > also need to provide the receive clock.
> 
> So this affects the ability of PCS to operate correctly as well as MACs?
> Would you enlighten which PCS are affected, and what PCS <--> PHY link
> modes this is required for?

The affected hardware is the RZN1 GMAC1 that is found in the r9a06g032 SoC from 
Renesas. This MAC controller is internally connected to a custom PCS that
functions as a RGMII converter. This converter is handled by a standalone PCS 
driver that is already upstream, unlike the GMAC1 driver. So in hardware, the 
MAC/PHY links are organised this way:

    RZN1 GMAC1 <--[GMII]--> MII_CONV1 (internal) <--[RGMII]--> external PHY

The issue is that the RX clock from the external PHY has to be transmitted by 
the MII converter before it reaches GMAC1. Therefore, if the RZN1 PCS driver 
isn't configured to let the clock through before the stmmac GMAC1 driver 
initializes its hardware, then said initialization will fail with a vague DMA 
error.

To solve this, I added a flag to phylink_pcs and made the phylink core set it in 
phylink_validate_mac_and_pcs(). This gives the PCS driver a chance to check the 
flag in pcs_validate() and allow the clock through before the GMAC1 net device 
is brought up.

Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

