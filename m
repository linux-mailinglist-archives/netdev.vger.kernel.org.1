Return-Path: <netdev+bounces-199070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93FADED36
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC2A16DB3E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347CF2E54BF;
	Wed, 18 Jun 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YxXnPoYN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A9288C86;
	Wed, 18 Jun 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251620; cv=none; b=Jv46OoSiO7HPd6wpYWdVvpf7BYupce45xVcGY1HWPCIbPB9wpbUoIuLXyAsHfXDamy6oWFVtrBiu2au6tLtaYLq+is71gUCQn+nh2LbwPkb0YPoOr7ZuP4Y+b1BLdrYUNF5+w0zr9TDJHj3I3lysW2AWFc5QfzEumM1LGc1Myu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251620; c=relaxed/simple;
	bh=jJHfgc2OeqXu69uwA+MX/1r3s/fuAbhMTVqpghnrcJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajEHAqvJOPs2d/5WNmik/2NslsHpmSvF84pmhvFDod1tqVJsMd+5QLxfJUbuISVl1/7thxkt7HGUzdcgx5G/U5ECJ3rLSYMGvcelfo5tJfdvIxpc6cFud++I5ebSkv1lrw3ikq3vhH9CrJxFqY2Kr+B7i9G6S41bGamhBsol8xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YxXnPoYN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EhzG6+txXBEciehkq/GMHreiztyW1JQ3tAQRP8QJsxk=; b=YxXnPoYNQKRPYFsVSXoURtMd4b
	UtcNUHyai4FPWqiFhYaUWKehIyK5TQH4tSWmujpRDBKfioxTqCqCtDetq1dA3s518ebnD4ywTZsXr
	QsnZ18Rw+7jyebZTL8z0FL9zPabbkLPoNtK+OIce7qNSTn6kmkmm4v56GLEAPsH+Z8OuEjotXWNzb
	K5y+tsG9i3ZGA1fYkkBKPgbRGUYq81ZqySWuEXqbGNf7N4ySzrx4Bww2Y+X0O0toDzOGME1G2wV3S
	XNvWmgkrhANSkUMEoaLMfDtUSgjjHr6bEC9nw+pMDzfRcwznfCzVJGYiTn9m8obW7rppis6XRBdi0
	VUr8v+Yw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43066)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uRsOb-0006TD-06;
	Wed, 18 Jun 2025 14:00:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uRsOX-0006qR-01;
	Wed, 18 Jun 2025 14:00:01 +0100
Date: Wed, 18 Jun 2025 14:00:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v8 1/6] net: usb: lan78xx: Convert to PHYLINK
 for improved PHY and MAC management
Message-ID: <aFK4UH7h14XbJXod@shell.armlinux.org.uk>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
 <20250618122602.3156678-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618122602.3156678-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 18, 2025 at 02:25:57PM +0200, Oleksij Rempel wrote:
> Convert the LAN78xx USB Ethernet driver to use the PHYLINK framework for
> managing PHY and MAC interactions. This improves consistency with other
> network drivers, simplifies pause frame handling, and enables cleaner
> suspend/resume support.
> 
> Key changes:
> - Replace all PHYLIB-based logic with PHYLINK equivalents:
>   - Replace phy_connect()/phy_disconnect() with phylink_connect_phy()
>   - Replace phy_start()/phy_stop() with phylink_start()/phylink_stop()
>   - Replace pauseparam handling with phylink_ethtool_get/set_pauseparam()
> - Introduce lan78xx_phylink_setup() to configure PHYLINK
> - Add phylink MAC operations:
>   - lan78xx_mac_config()
>   - lan78xx_mac_link_up()
>   - lan78xx_mac_link_down()
> - Remove legacy link state handling:
>   - lan78xx_link_status_change()
>   - lan78xx_link_reset()
> - Handle fixed-link fallback for LAN7801 using phylink_set_fixed_link()
> - Replace deprecated flow control handling with phylink-managed logic
> 
> Power management:
> - Switch suspend/resume paths to use phylink_suspend()/phylink_resume()
> - Ensure proper use of rtnl_lock() where required
> - Note: full runtime testing of power management is currently limited
>   due to hardware setup constraints
> 
> Note: Conversion of EEE (Energy Efficient Ethernet) handling to the
> PHYLINK-managed API will be done in a follow-up patch. For now, the
> legacy EEE enable logic is preserved in mac_link_up().
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

