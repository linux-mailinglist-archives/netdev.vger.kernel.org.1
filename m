Return-Path: <netdev+bounces-147755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E59D9DB94E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D170AB20931
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06C1AA1FE;
	Thu, 28 Nov 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h20AFG9j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1A145A0F
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803135; cv=none; b=LTF/eeLLdIg5BpyHea1u1c44PADzVi7Mn4sLVNzGqMRbpUNrB5AmpJBj5ZOzDX1FFc15y4cF8vxzMXa+bjDC3HxkLLQ4sVwlt5Xvl/Z013x6JQW/irugUzOG5rpCVs3R8JUpWtunCPRmwIlDsjqnauUouR/rBUwEfJ6skP8oczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803135; c=relaxed/simple;
	bh=JyBwXL9SWi5M1aSDJM+ZQQ4STdCAKO6VsvJK/aFO9gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGAaJpyg3AHDh0kEaK5XzaJdeqB0MOthDZcQ5Qi4x4d/8UMfiJEHAhylzw1r0bwoeeIQdAyuuTcocQsM8tqzzkmX/UBeyczlG8iJGlR7kDBHbStOsnWhTUBgqAgADioZBQL0eipPAjSuxOkCtr/lZfjtNOQLJHJ/kZu8gHbAsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h20AFG9j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kftlvdSPNN2/qEIMi2IQIekU3CLHwUEfGfLj5UP8QHU=; b=h20AFG9jT3cuoAi2yE6w7EFyp3
	fj+TAnqizyy7nuytM97J2K97nfMOlvbGwli5n0+ZPpPl+czYij/Ku2QNYLKPPkNGDY6Y+14fRWG4n
	oHlkBTnWjaT+pNzB9buunLYN3St+uJ3k2RrdxU3IQ+MHMwq0vrEQbk93wIUCCO2Tcmqw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGfFF-00EiC6-5Z; Thu, 28 Nov 2024 15:11:49 +0100
Date: Thu, 28 Nov 2024 15:11:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
Subject: Re: [PATCH RFC net-next 02/23] net: phy: fix phy_ethtool_set_eee()
 incorrectly enabling LPI
Message-ID: <4e0fd2d9-ab05-4e0c-9179-ca5c7572084f@lunn.ch>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <E1tFv3F-005yhT-AA@rmk-PC.armlinux.org.uk>
 <Z0b-nJ7bt8IlBMpz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0b-nJ7bt8IlBMpz@shell.armlinux.org.uk>

On Wed, Nov 27, 2024 at 11:12:28AM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 26, 2024 at 12:52:21PM +0000, Russell King (Oracle) wrote:
> > @@ -1685,15 +1685,21 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
> >  static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> >  				      const struct eee_config *old_cfg)
> >  {
> > -	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
> > +	bool enable_tx_lpi;
> > +
> > +	if (!phydev->link)
> > +		return;
> > +
> > +	enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;
> > +
> > +	if (phydev->enable_tx_lpi != enable_tx_lpi ||
> >  	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
> 
> I'm wondering whether this should be:
> 
> 	if (phydev->enable_tx_lpi != enable_tx_lpi ||
> 	    (phydev->enable_tx_lpi &&
> 	     phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer)) {
> 
> The argument for this change would be to avoid cycling the link when the
> LPI timer changes but we're not using LPI.
> 
> The argument against this change would be that then we don't program the
> hardware, and if the driver reads the initial value from hardware and
> is unbound/rebound, we'll lose that update whereas before the phylib
> changes, it would have been preserved.

unbound/rebound is a pretty unusual use case. I would not consider
that a strong argument against it.

This is the case where we don't need to perform negotiation. So it is
going to be a fast operation compared to when we do need negotiation.
So i wounder if we really need to care?  Donald Knuth, Premature
optimisation is the root of all evil, etc...

	Andrew

