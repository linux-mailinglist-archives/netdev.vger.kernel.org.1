Return-Path: <netdev+bounces-113543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F4793EF9C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6721F2162D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997D84FAC;
	Mon, 29 Jul 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0Kgs4CSb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06B13AA40;
	Mon, 29 Jul 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240907; cv=none; b=MthPDSPft6skoDAnSM91+BtDcU4MvZJYXSjLGw2N1S6ftsL63gYNFXUWhgwNW3y9OZ4yMie564rqG3XDuhElDP5ECbT58wEMopIGtgkRu/EGPBVrdMNTh5kZQgTw5HNJVYch7F+cbc0oPS+GF/D/OKCh/mULj3FCbJYBLqGoy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240907; c=relaxed/simple;
	bh=F2v5MeGKnmKKTaw3EHVdF00N+R4ATTCAiEJUnAGaPd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnFit/RZJH7U8z/jfxL3WmkTgBfLBErLM0iOIetbTEsJpBqGiCLC1LQMuz0d0ftiMCLn5aalobyay3seRzwCWJqzZe3fLfAV8r3YonUqQ89IpzL+RfdAAckqkBgwKWZmrGaNPM6R15FY/raJ4nrQZvBqOXLeQvBekV+NJbR4rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0Kgs4CSb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=canEuZOszEHmYAtKmpnYXaodFh9iW9qRQJMHLOS1vGM=; b=0Kgs4CSbXWXFy1+dKZyoFDb/sn
	RUiVD7fgrFLWHJCed267jLB4Ljm24hsWqXddNNnudileRngnaCxi9F00s9I//mP7M3z+Od30urJKt
	Ap0AS3eL5Zn6hOn6s+HucrPJsLO7RVfoCU5clBj3ddnhr/llE4ftx+bHQk7xAfPQVPtcvXFWrtf7f
	V9uH+UhluIAFTk2x1b1Nm6QRbaYM1ym3CG2i4Hrkm1xvILLycIF+iH245TxKjv5yLpuJvwTBYJSnP
	SJKgRVkmQkildvammOfBzJP6zsnhOonZL2nss6/CF0jyH5sg4B4q0GTGoywKcE1EfnUB0zjDNH4Pz
	p3zuu+9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51616)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYLWm-0003Ni-39;
	Mon, 29 Jul 2024 09:14:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYLWp-0004AH-QZ; Mon, 29 Jul 2024 09:14:47 +0100
Date: Mon, 29 Jul 2024 09:14:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Yuiko Oshino <yuiko.oshino@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Michal Kubiak <michal.kubiak@intel.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Message-ID: <ZqdPd/ieyLgVmX8v@shell.armlinux.org.uk>
References: <20240705085550.86678-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705085550.86678-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jul 05, 2024 at 10:55:50AM +0200, Oleksij Rempel wrote:
> +static int lan937x_tx_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_config_aneg(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return lan937x_tx_config_mdix(phydev, phydev->mdix_ctrl);

Should the MDIX configuration be changed _after_ aneg has possibly
been restarted (by genphy_config_aneg()) or should the MDIX config
be done before?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

