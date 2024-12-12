Return-Path: <netdev+bounces-151385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F369EE897
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2467B1888F30
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94D558BB;
	Thu, 12 Dec 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NHOcD6Lu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F458837
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013024; cv=none; b=KMS/XJn+d4BeJNP4g6B4erOT/oMIS0zftIZHMHAA0MgTnKOX69nFwvoOUEAwkffFsQBO7c7j9PrisHWV0R+2WACEWaN6trLKq/N60dv/fdm1p5F69yfkoFAN+xrnLe8RdVMJ20ZOpF14QwGNJd6bC9nOk/9kLhXfHptwUQXNyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013024; c=relaxed/simple;
	bh=V6LbFyoke2AvZrhyJYm8IE+1XUzJC01e2rE6mq5HQJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7xGdOLKf72zlEHTjeIZnibi3LXU6AZr5szGw0djmcQugj33JTg0ayoEcj+fPtg/YxWvNBjZ4c9JuR8wHAcNduSr1Akj9LHuFPP2tQEsuIEDKBvck5Rims4O/8O3xNDHkvWvAaqs0qtViAKQJYnR7Rh5g6k+9KWilXEkJ8K1djY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NHOcD6Lu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tKlHxR/knZ7URqeq8ja3L54tX/V0JbOxejsIk5s9qNs=; b=NHOcD6Luep6b09yHCRW1nBDSNw
	1ecP5gkEVVRjuWCr6LqtZgkdOesl1W1eaSVlG5apHX/voFy1cdfK7ROfXjnE1+z4VROB0TtzWFhMR
	iE8DkvHkYt1fwcrhBVylo2gXnudX2fFjLRRTpbrIf2sqC4tUPXAkZMM6ms1wzKRXZtlXLeS5KQF78
	ZL2a72S0uJHdGSIWwt7MKewOiJ2KQ6TsRU8EOio5j2+WK6aHJ5ad2Np5Xz/VAK7hNBaeh/Z6SoMAP
	WJ2U6kH/09pvYEDtCckSKNl3b/nxy2+dAFWRE4XnVkB7w1eXW/tWJh1bfoacvYzL7Rd3awAC2WVe1
	V8nCyifg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36426)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLjzn-0005IW-1Y;
	Thu, 12 Dec 2024 14:16:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLjzk-0005OJ-2n;
	Thu, 12 Dec 2024 14:16:48 +0000
Date: Thu, 12 Dec 2024 14:16:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next] net: phylink: improve
 phylink_sfp_config_phy() error message with missing PHY driver
Message-ID: <Z1rwUNWDotC0MgBk@shell.armlinux.org.uk>
References: <20241212140834.278894-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212140834.278894-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 12, 2024 at 04:08:34PM +0200, Vladimir Oltean wrote:
> It seems that phylink does not support driving PHYs in SFP modules using
> the Generic PHY or Generic Clause 45 PHY driver. I've come to this
> conclusion after analyzing these facts:
> 
> - sfp_sm_probe_phy(), who is our caller here, first calls
>   phy_device_register() and then sfp_add_phy() -> ... ->
>   phylink_sfp_connect_phy().
> 
> - phydev->supported is populated by phy_probe()
> 
> - phy_probe() is usually called synchronously from phy_device_register()
>   via phy_bus_match(), if a precise device driver is found for the PHY.
>   In that case, phydev->supported has a good chance of being set to a
>   non-zero mask.
> 
> - There is an exceptional case for the PHYs for which phy_bus_match()
>   didn't find a driver. Those devices sit for a while without a driver,
>   then phy_attach_direct() force-binds the genphy_c45_driver or
>   genphy_driver to them. Again, this triggers phy_probe() and renders
>   a good chance of phydev->supported being populated, assuming
>   compatibility with genphy_read_abilities() or
>   genphy_c45_pma_read_abilities().
> 
> - phylink_sfp_config_phy() does not support the exceptional case of
>   retrieving phydev->supported from the Generic PHY driver, due to its
>   code flow. It expects the phydev->supported mask to already be
>   non-empty, because it first calls phylink_validate() on it, and only
>   calls phylink_attach_phy() if that succeeds. Thus, phylink_attach_phy()
>   -> phy_attach_direct() has no chance of running.
> 
> It is not my wish to change the state of affairs by altering the code
> flow, but merely to document the limitation rather than have the current
> unspecific error:
> 
> [   61.800079] mv88e6085 d0032004.mdio-mii:12 sfp: validation with support 00,00000000,00000000,00000000 failed: -EINVAL
> [   61.820743] sfp sfp: sfp_add_phy failed: -EINVAL
> 
> On the premise that an empty phydev->supported is going to make
> phylink_validate() fail anyway, and that this is caused by a missing PHY
> driver, it would be more informative to single out that case, undercut
> the entire phylink_sfp_config_phy() call, including phylink_validate(),
> and print a more specific message for this common gotcha:
> 
> [   37.076403] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) has no driver loaded
> [   37.089157] mv88e6085 d0032004.mdio-mii:12 sfp: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
> [   37.108047] sfp sfp: sfp_add_phy failed: -EINVAL
> 
> Link: https://lore.kernel.org/netdev/20241113144229.3ff4bgsalvj7spb7@skbuf/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

