Return-Path: <netdev+bounces-108354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16191F0D2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13F8285DCE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281814885D;
	Tue,  2 Jul 2024 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aNMrwpbr"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E794963F;
	Tue,  2 Jul 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907833; cv=none; b=e9FoKOkAkmB0oMzfJyflp6xAI9bEX38Gc3/UDZbVNaUY7bTu8ag3yIS3avqGOt+5gDnIy2Ns2IdLOkCH6vF6fK4pGSX/5PKIgdzlJboBTZRu/g+YR4HcNb5eeUVQ/wJxbfv1QG8dRTGgQlAwfFUvvR7o+CT+oJ1Nup7cgMEVEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907833; c=relaxed/simple;
	bh=DHYhZ0Wj6Ur8ukIc9YyWw24SCTfRe2ixIJL95ykzkoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhVSxJMZ4Dby9mlCEUaeNu7tBwSM5LoKFcWONbC++G3Umda8iC6qcASKtIStsh0hPz9/r2Y79vrrH7bMPGJ0zNUbUp6J3LRt4Om6jwk/pJ6gRbkqu+X7Aa1StnM6SxGrS4tLYnBlNkdoaPnM+Xmd4hKMJfgIY1Qm4/k4KWhEARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aNMrwpbr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11C221BF20D;
	Tue,  2 Jul 2024 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719907822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cplOtEQ3LRIUN6MKbmNtCu1CP2eNY8Fp3ezNCIONjsI=;
	b=aNMrwpbr72ZnA9fMmRIVOhbRFsxiMV3Iz+ZbQSBAm5p3X1393jZFHpCYw4IKiJm8VnjuvJ
	O+/Yu0F5sxxkriUx6zhNNnJ/qzzoVdRa/uYeZ6MvXhqL9tipphABdW/jZ3E8V8LVdxFPvC
	rj5NyTlJSWDcIwEQRgbxUuIhnZ4VvcS7v86kUxuq6WHxfIoKd8VUMtCt2UE+b/UnJQXCEk
	hIUaQI1tkIsG+sg4noCjRW0YN2jnNKtN4FRoiDYC1kvy9n1DjrtB/OPyzQjaOsOxrQx9Od
	glvXyQFlUWE8nc/2o81qE+TYb3SVUfUGRTQolxLp4CHszBqTxE2B7gkvCz9cUw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP modules
Date: Tue, 02 Jul 2024 10:11:07 +0200
Message-ID: <2273795.iZASKD2KPV@fw-rgant>
In-Reply-To: <f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
References:
 <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
 <f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

Hello Andrew, thanks for the review!

I think this particular patch warrants that I explain myself a bit more.

Some SGMII SFP modules will work fine once they're inserted and the appropriate 
probe() function has been called by the SFP PHY driver. However, this is not 
necessarily the case, as some SFP PHYs require further configuration before the 
link can be brought up (e.g. calling phy_init_hw() on them which will 
eventually call things like config_init()).

This configuration usually doesn't happen before the PHY device is attached to 
a network device. In this case, the DP83869 PHY is placed between the MAC and 
the SFP PHY. Thus, the DP83869 is attached to a network device while the SFP 
PHY is not. This means that the DP83869 driver basically takes on the role of 
the MAC driver in some aspects.

In this patch, I used the connect_phy() callback as a way to get a handle to 
the downstream SFP PHY. This callback is only implemented by phylink so far.

I used the module_start() callback to initialize the SFP PHY hardware and 
start it's state machine.

On lundi 1 juillet 2024 19:00:29 UTC+2 Andrew Lunn wrote:
> > +static int dp83869_connect_phy(void *upstream, struct phy_device *phy)
> > +{
> > +	struct phy_device *phydev = upstream;
> > +	struct dp83869_private *dp83869;
> > +
> > +	dp83869 = phydev->priv;
> > +
> > +	if (dp83869->mode != DP83869_RGMII_SGMII_BRIDGE)
> > +		return 0;
> > +
> > +	if (!phy->drv) {
> > +		dev_warn(&phy->mdio.dev, "No driver bound to SFP module phy!
\n");
> 
> more instances which could be phydev_{err|warn|info}().
> 
> > +		return 0;
> > +	}
> > +
> > +	phy_support_asym_pause(phy);
> 
> That is unusual. This is normally used by a MAC driver to indicate it
> supports asym pause. It is the MAC which implements pause, but the PHY
> negotiates it. So this tells phylib what to advertise to the link
> partner. Why would a PHY do this? What if the MAC does not support
> asym pause?
> 

The idea here was that the downstream SFP PHY should advertise pause 
capabilities if the upstream MAC and intermediate DP83869 PHY supported them. 
However, the way I implemented this is indeed flawed, since the DP83869 driver 
should check that the MAC wants to advertise pause capabilities before calling 
this on the downstream PHY.

I suggest the following logic instead:

if (pause bits are set in dp83869 advertising mask)
	copy pause bits from sfp_phy->supported to sfp_phy->advertising

> > +	linkmode_set_bit(PHY_INTERFACE_MODE_SGMII, phy->host_interfaces);
> > +	phy->interface = PHY_INTERFACE_MODE_SGMII;
> > +	phy->port = PORT_TP;
> > +
> > +	phy->speed = SPEED_UNKNOWN;
> > +	phy->duplex = DUPLEX_UNKNOWN;
> > +	phy->pause = MLO_PAUSE_NONE;
> > +	phy->interrupts = PHY_INTERRUPT_DISABLED;
> > +	phy->irq = PHY_POLL;
> > +	phy->phy_link_change = &dp83869_sfp_phy_change;
> > +	phy->state = PHY_READY;
> 
> I don't know of any other PHY which messes with the state machine like
> this. This needs some explanation.

phylink_sfp_connect_phy() does something similar. The reasoning behind setting 
PHY_READY is that the later call to phy_start() will fail if the PHY isn't in 
the PHY_READY or PHY_HALTED state.

No other PHY driver does this because as of now, phylink is the only implementer 
of the connect_phy() callback. Other PHY drivers don't seem to support handling 
the initial configuration of a downstream SFP PHY.

> 
> > +
> > +	dp83869->mod_phy = phy;
> > +
> > +	return 0;
> > +}
> > +
> > +static void dp83869_disconnect_phy(void *upstream)
> > +{
> > +	struct phy_device *phydev = upstream;
> > +	struct dp83869_private *dp83869;
> > +
> > +	dp83869 = phydev->priv;
> > +	dp83869->mod_phy = NULL;
> > +}
> > +
> > +static int dp83869_module_start(void *upstream)
> > +{
> > +	struct phy_device *phydev = upstream;
> > +	struct dp83869_private *dp83869;
> > +	struct phy_device *mod_phy;
> > +	int ret;
> > +
> > +	dp83869 = phydev->priv;
> > +	mod_phy = dp83869->mod_phy;
> > +	if (!mod_phy)
> > +		return 0;
> > +
> > +	ret = phy_init_hw(mod_phy);
> > +	if (ret) {
> > +		dev_err(&mod_phy->mdio.dev, "Failed to initialize PHY hardware: 
error
> > %d", ret); +		return ret;
> > +	}
> > +
> > +	phy_start(mod_phy);
> 
> Something else no other PHY driver does....

phy_init_hw() is necessary here to ensure that the SFP PHY is configured properly before 
the link is brought up. phy_start() is used to start the phylib state machine, which is what 
would happen if the SFP PHY was directly connected to a MAC.

As with the connect_phy() case, no other PHY  driver currently implements module_start(), 
only phylink does, which is why this code might look out of place.

Of course, there could be flaws in my understanding of phylib or the SFP core, please let 
me know what you think.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




