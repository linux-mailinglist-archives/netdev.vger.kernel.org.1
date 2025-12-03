Return-Path: <netdev+bounces-243387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01AC9EABD
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 11:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09DEE348B25
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A12DE707;
	Wed,  3 Dec 2025 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fYyximEM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B7213254;
	Wed,  3 Dec 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756977; cv=none; b=C0Mln1jk47ID28GrDnlHYEKDyS/BTjyZPG7ZMzMX+5bazrXMeA9PVBG0Y442lqit1ns47UNaUtX7jUVmb3jRD3tKt2zLs51+lXlJgBdH/2EmQ99IIvipj7xnU7djniylj6mXAplHlmkRQaHvGNk0GTOhmEZrIYU8r2x5tzt321w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756977; c=relaxed/simple;
	bh=TU7vM4OokVzQEkasMSQu8fbtSIlHHTnXL87GLSDV4KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjaVjz/TgM8gZJshVLsjt4tAA3M6JgcjSwk3C52ttqlgJeSmXlxu65pRAVb2jmoSR71eMaDBbCzY05ngT7FRHR85FTG7R3iJ3ai99GxeHeZ1ZSW7w1wliX973epuraEADeRfMdSVmC5ljjM6J1T3y6+e4TDqXPEiFzk25TtEfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fYyximEM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UPORv42reuuhu1DhxnhFSCa05PXnIEqlhFt69DhjJUE=; b=fYyximEMHMACRwivXvRICIR8c6
	xJtncZQYU0KG7QV/b3W/mWUPaTove4NwNVCy1Ps7wK3ySprb0g2jXRKD+q7OSq5NNgBWv03lIolA2
	NtSjphWJmvvDmy1w6lG9aUvlLk9809dkHyfPufZtiC4rQxj0G3ZYAlPAfjzTy3MOiFsJZlfuSKIva
	Jk9/UeimyH8CiZv3LF2aDQCdWSbgr2b8NRxY3H3NSICWEfz3cFKUsYelWLO3qoGXmdxtxKB78Dhe+
	YmVKTK10E+yMD8fLiz+xTWfFjkwhI83s+BA1meSCH0qWOMUuSaYYyHI8wFExXvcVqf2/UstTaT5QS
	hxo53fxg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32770)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQju5-000000002Rg-2VB5;
	Wed, 03 Dec 2025 10:16:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQju2-000000008NC-2vSo;
	Wed, 03 Dec 2025 10:16:06 +0000
Date: Wed, 3 Dec 2025 10:16:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Ivan Galkin <ivan.galkin@axis.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Message-ID: <aTAN5lX_OgwQh7E8@shell.armlinux.org.uk>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <20251203094224.jelvaizfq7h6jzke@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203094224.jelvaizfq7h6jzke@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 03, 2025 at 11:42:24AM +0200, Vladimir Oltean wrote:
> > +
> > +       ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_RXC, 0x5f00);
> > +       if (ret < 0) {
> > +               dev_err(dev, "RXC SCC configuration failed: %pe\n", ERR_PTR(ret));
> > +               return ret;
> > +       }
> 
> I'm going to show a bit of lack of knowledge, but I'm thinking in the context
> of stmmac (user of phylink_config :: mac_requires_rxc), which I don't exactly
> know what it requires it for.

stmmac requires _all_ clocks to be running in order to complete reset,
as the core is made up of multiple modules, all of which are
synchronously clocked by their respective clocks. So, e.g. for the
receive sections to complete their reset activity, clk_rx_i must be
running. In RGMII mode, this means that the RGMII RXC from the PHY must
be running when either the stmmac core is subject to hardware or
software reset.

> Does it use the RGMII RXC as a system clock?
> If so, I guess intentionally introducing jitter (via the spread spectrum
> feature) would be disastrous for it. In that case we should seriously consider
> separating the "spread spectrum for CLKOUT" and "spread spectrum for RGMII"
> device tree control properties.

I don't think it will affect stmmac - as long as the clock is toggling
so that the synchronous components in stmmac can change state, that's
all that the stmmac reset issue cares about.

However, looking at the RTL8211FS(I)(-VS) datasheet, CLKOUT and RXC
are two different clocks.

CLKOUT can be:
- reference clock generated from internal PLL.
- UTP recovery receive clock (for SyncE)
- Fibre recovery receive clock (for SyncE)
- PTP synchronised clock output

This can't be used for clocking the RGMII data, because it won't be
guaranteed to have the clock edges at the correct point, nor does it
switch clock speed according to the negotiated data rate. In SyncE
modes, the recovered clock is either 125MHz or 25MHz, whereas RXC
is 125, 25 or 2.5MHz.

There is a separate bit for enabling SSC on RXC - PHYCR2 bit 3 vs
CLKOUT SSC in bit 7.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

