Return-Path: <netdev+bounces-147590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DA9DA6BF
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F14028103F
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D71F130C;
	Wed, 27 Nov 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MSah3XyK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A231F12E9
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706426; cv=none; b=Jz9TTPkByoKWGWj7OJa5bQN1K18GKiIbQFzNFWGIYOOQXBem9JgfOogEE5l4R0N2LdZUU9PcrSpT/vDcOH5GfviZMaZoq42UBF9T5io14y94E6JPoq8PwsLBFnmeZeY/EGT+RTs5bpGj4/RQFqntphAxFIvrshNOvLNzf2uF5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706426; c=relaxed/simple;
	bh=DNPsV9nacuboWCHutI4G2CClWQ9Sw/fbjD52ENMK0ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg9mikQUwevwqGqeXxvsh1wprB3imyo8p9xnBdAL1vJ/fzXZi9MKDi0AAjgK4d6swdJjtK4lskc9JwD5Xg4HDxwUVnoT9/z8Io3yN8K0hW0ANE3tVh/xfWSD3HWCq8nDEGmMXMhULXRZhAjrwt33XCTpyGja8fhAu2bHgvqvC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MSah3XyK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3pnFazxY8HzLhh4gTcIsD9NoAcCruO+q2t9IKoBKYJw=; b=MSah3XyKasAIMaryEwuVLGuety
	aV5UulyDIACFz2Fga7NQ4B3f+aS2m3NVO7MErNGrPkCd3cj/0I1CpmFK0f4Ngqiq0FOL/ZHPTHOvK
	/ckaHb7ObAZDGfZtkQIbsB102cURe9h/f7H//YFkWHFEbMlOJ6mlDiRcwIsXyRrSlbWogeyFpZH8v
	qCZJuSTKO4Eg4WLoFCef52QMAcuoAjzp0fhe7MaZOiagtSYi2jKQ1gpB4aXKd36D3Uco9+7Oy0Vag
	3tdkB8WZ1RZzSbHq9VUXWLF0kcS5OmlnP6WvlS+M8IZz8IAYiAkS+SCG1V+Y0jU2Adsb1r7PDqsdX
	GfM0qPQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36484)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tGG5b-0000FS-2u;
	Wed, 27 Nov 2024 11:20:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tGG5Y-00076z-1d;
	Wed, 27 Nov 2024 11:20:08 +0000
Date: Wed, 27 Nov 2024 11:20:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: net: ti: weirdness (was Re: [PATCH RFC net-next 00/23] net:
 phylink managed EEE support)
Message-ID: <Z0cAaH30cXo38xwE@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 26, 2024 at 12:51:36PM +0000, Russell King (Oracle) wrote:
> In doing this, I came across the fact that the addition of phylib
> managed EEE support has actually broken a huge number of drivers -
> phylib will now overwrite all members of struct ethtool_keee whether
> the netdev driver wants it or not. This leads to weird scenarios where
> doing a get_eee() op followed by a set_eee() op results in e.g.
> tx_lpi_timer being zeroed, because the MAC driver doesn't know it needs
> to initialise phylib's phydev->eee_cfg.tx_lpi_timer member. This mess
> really needs urgently addressing, and I believe it came about because
> Andrew's patches were only partly merged via another party - I guess
> highlighting the inherent danger of "thou shalt limit your patch series
> to no more than 15 patches" when one has a subsystem who's in-kernel
> API is changing.

Looking at the two TI offerings that call phy_ethtool_get_eee(), both
of them call the phylib functions from their ethtool ops, but it looks
like the driver does diddly squat with LPI state, which makes me wonder
why they implemented the calls to phy_ethtool_get_eee() and
phy_ethtool_set_eee(), since EEE will not be functional unless the PHY
has been configured with a SmartEEE mode outside the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

