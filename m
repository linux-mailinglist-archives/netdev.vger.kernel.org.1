Return-Path: <netdev+bounces-108212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9249D91E61C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB61F21AE6
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C6215A86E;
	Mon,  1 Jul 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6RedJELs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2B8C1E;
	Mon,  1 Jul 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853243; cv=none; b=pZSsN7Q7qSngmB9BRSpDyDuYy212KtcfS42qCBIXkfgDjYmdf7ijg66ZiCyc2pKEQZf50/rOFDh4egdhxUuGXC4VmRLUVsbIOZEb8Cd2pkNlzxgfnr75sdOwcKOPJ19aV5iH8vMA0YplkdaSCmDJMWDdImAvm4oVs6jUBb6+tXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853243; c=relaxed/simple;
	bh=MUiM9ao2RvE94F7ZTjLTyTt/XiwJiWbHlGOcXiJW+xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjdfk/tAAB+hogOuFTLnHsSuy/lNMOQUPhzKyRIR5S/JiY5wda7vukzrOSB98lcX0EfAsp/B25kIwu5om1AIu0atz4C9M3aVlKJsES30T4pw9BA7WkuJqPVd2Hx4sJ8xrHKkNDdhApB24nn/alM3Z/hbi7ji61+I5cMWrfwL9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6RedJELs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2DldeZMtdvwKEVfE86XEEVj2HO43L/iuwsuOSidP0Fg=; b=6RedJELsuTvjekhk2pce8s+PiV
	XvdNCwWrC1BRHJUHX30Y01KUCEFx6YXjNLKzjXiI5SkJxX8LbzIj29qN9p74002anvPcjpNeZmOb5
	Eei+JHZY8mNzpoM6bLmHmRxUdAYIPPE+jQ8fZ5NCXyo64mzTyaAe4KDCcjPtMx5GmkGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOKOD-001Z45-Jm; Mon, 01 Jul 2024 19:00:29 +0200
Date: Mon, 1 Jul 2024 19:00:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP modules
Message-ID: <f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>

> +static int dp83869_connect_phy(void *upstream, struct phy_device *phy)
> +{
> +	struct phy_device *phydev = upstream;
> +	struct dp83869_private *dp83869;
> +
> +	dp83869 = phydev->priv;
> +
> +	if (dp83869->mode != DP83869_RGMII_SGMII_BRIDGE)
> +		return 0;
> +
> +	if (!phy->drv) {
> +		dev_warn(&phy->mdio.dev, "No driver bound to SFP module phy!\n");

more instances which could be phydev_{err|warn|info}().

> +		return 0;
> +	}
> +
> +	phy_support_asym_pause(phy);

That is unusual. This is normally used by a MAC driver to indicate it
supports asym pause. It is the MAC which implements pause, but the PHY
negotiates it. So this tells phylib what to advertise to the link
partner. Why would a PHY do this? What if the MAC does not support
asym pause?

> +	linkmode_set_bit(PHY_INTERFACE_MODE_SGMII, phy->host_interfaces);
> +	phy->interface = PHY_INTERFACE_MODE_SGMII;
> +	phy->port = PORT_TP;
> +
> +	phy->speed = SPEED_UNKNOWN;
> +	phy->duplex = DUPLEX_UNKNOWN;
> +	phy->pause = MLO_PAUSE_NONE;
> +	phy->interrupts = PHY_INTERRUPT_DISABLED;
> +	phy->irq = PHY_POLL;
> +	phy->phy_link_change = &dp83869_sfp_phy_change;
> +	phy->state = PHY_READY;

I don't know of any other PHY which messes with the state machine like
this. This needs some explanation.

> +
> +	dp83869->mod_phy = phy;
> +
> +	return 0;
> +}
> +
> +static void dp83869_disconnect_phy(void *upstream)
> +{
> +	struct phy_device *phydev = upstream;
> +	struct dp83869_private *dp83869;
> +
> +	dp83869 = phydev->priv;
> +	dp83869->mod_phy = NULL;
> +}
> +
> +static int dp83869_module_start(void *upstream)
> +{
> +	struct phy_device *phydev = upstream;
> +	struct dp83869_private *dp83869;
> +	struct phy_device *mod_phy;
> +	int ret;
> +
> +	dp83869 = phydev->priv;
> +	mod_phy = dp83869->mod_phy;
> +	if (!mod_phy)
> +		return 0;
> +
> +	ret = phy_init_hw(mod_phy);
> +	if (ret) {
> +		dev_err(&mod_phy->mdio.dev, "Failed to initialize PHY hardware: error %d", ret);
> +		return ret;
> +	}
> +
> +	phy_start(mod_phy);

Something else no other PHY driver does....

	Andrew

