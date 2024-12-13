Return-Path: <netdev+bounces-151883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7579F1735
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD497A13D9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A2190057;
	Fri, 13 Dec 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aNI5GnhQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765818FDBE
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120397; cv=none; b=ss+pFt0TNkCR01ZWtJaStBON60s5q8QuGZJhEzZ94UzAAEfg9Ebx0yRD3cOtMPPL6ewh2n7DuRw09DcHG3+AJyQdbsz21EyWiIfw5/c+DZ9L1hqW4zLHtLGQKkSq/QD/f1Jyb2OXnpGJst+elPOWvWo0NFR57XLUtiQpbrJO3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120397; c=relaxed/simple;
	bh=cG6uc0NBxNWqJgE99oquIu0aGeIAk+VARYlI2XGXnNA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyujAFwYzqiZoRZWUe36L/4l86/zNXWYmNLLer8PVXDLccp2h8r8dclbyfr1GJdCwlbyzKUqCBL8RhSk1B8fkPeRE/nT0fbWVhyD7o0gOR7+//Eg0mWSdGuf5LREGhyl5S4RVkZv0sFhWq13cSMFGMubm7SObz8HiwKCv/YK8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aNI5GnhQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q6XBpg/4IY/h2oG4Vm6RRozZRxiEoSr8X5lqGM2zVMQ=; b=aNI5GnhQ6591BedH7CtBIbwC3F
	pPegR4DND7Y/V0E+4t4zeoFoiA4JLIzRvfkwicxC81fLd2Ni+pEJlR5DEadz7cng3p7F5+jqj7ut2
	0gy193TVuR83XUqRwvK60EUJQZjeEznMo5DK7ygI8PaY2FTQGbMeBIk/Jubz49CQe9Wnm1H1onRjF
	rWaijsyAlwiEioPkzZyU/rLwFrv3gujLHJGlaVMDMUlkgpfe6YqA6E4pmsgDMdYb7YtV+yd5VIpxF
	peu09WWvvSxecCx9Bc+jUMX103IOvU51cBhnpqBHpmJh/c9W2gjBpkthcxqGqa6l/3oYMHIl7KNp6
	XeeBe0yA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tMBvd-0007Iw-2d;
	Fri, 13 Dec 2024 20:06:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tMBva-0006ZC-0s;
	Fri, 13 Dec 2024 20:06:22 +0000
Date: Fri, 13 Dec 2024 20:06:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/7] net: stmmac: move tx_lpi_timer tracking to
 phylib
Message-ID: <Z1yTviYUZ8sbNOsK@shell.armlinux.org.uk>
References: <Z1r3MWZOt36SgGxf@shell.armlinux.org.uk>
 <E1tLkSX-006qfS-Rx@rmk-PC.armlinux.org.uk>
 <Z1wTqh-BnvPYLqU8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1wTqh-BnvPYLqU8@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 13, 2024 at 10:59:54AM +0000, Russell King (Oracle) wrote:
> On Thu, Dec 12, 2024 at 02:46:33PM +0000, Russell King (Oracle) wrote:
> > @@ -1092,6 +1092,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
> >  			phy_init_eee(phy, !(priv->plat->flags &
> >  				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
> >  		priv->eee_enabled = stmmac_eee_init(priv);
> > +		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
> >  		priv->tx_lpi_enabled = priv->eee_enabled;
> >  		stmmac_set_eee_pls(priv, priv->hw, true);
> >  	}
> 
> While looking deeper at stmmac, there's a bug in the above hunk -
> stmmac_eee_init() makes use of priv->tx_lpi_timer, so this member
> needs to be set before calling this function. I'll post a v2 shortly.

I'm going to hold off v2, there's a lot more that can be cleaned up
here - the EEE code is rather horrid in stmmac, and there's definitely
one race, and one logical error in it (e.g. why mark software EEE mode
*enabled* when EEE mode is being disabled - which can lead to the EEE
timer being added back onto the timer list.)

There's also weirdness with dwmac4's EEE register fiddling.

The stmmac driver uses hardware timed LPI entry if the timer is small
enough to be programmed into hardware, otherwise it uses software mode.

When software mode wants to enter LPI mode, it sets both:

	GMAC4_LPI_CTRL_STATUS_LPIEN (LPI enable)
	GMAC4_LPI_CTRL_STATUS_LPITXA (LPI TX Automate)

When software mode wants to exit LPI mode, it clears both of these
two bits.

In hardware mode, when enabling LPI generation, we set the hardware LPI
entry timer (separate register) to a non-zero value, and then set:

	GMAC4_LPI_CTRL_STATUS_LPIEN (LPI enable)
	GMAC4_LPI_CTRL_STATUS_LPITXA (LPI TX Automate)
	GMAC4_LPI_CTRL_STATUS_LPIATE (LPI Timer enable)

That seems logical. However, in hardware mode, when we want to then
disable hardware LPI generation, we set the hardware LPI entry timer to
zero, the following bits:

	GMAC4_LPI_CTRL_STATUS_LPIEN (LPI enable)
	GMAC4_LPI_CTRL_STATUS_LPITXA (LPI TX Automate)

and clear:

	GMAC4_LPI_CTRL_STATUS_LPIATE (LPI Timer enable)

So, hardware mode, disabled, ends up setting the same bits as
software mode wanting to generate LPI state on the transmit side.
This makes no sense to me, and looks like another bug in this driver.

Can anyone suggest any hardware that I could source which uses the
dwmac4 code and which supports EEE please, so that I have hardware to
run some tests on.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

