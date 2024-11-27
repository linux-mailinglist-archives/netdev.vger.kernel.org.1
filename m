Return-Path: <netdev+bounces-147597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FDA9DA7AC
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795F8280E63
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26FE1FBE8D;
	Wed, 27 Nov 2024 12:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F51FA82F
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710025; cv=none; b=Og5y7MkY+g+PGw6gGJMixsklhFlPzdAG+A1cKNhE4NkqFVrBQ2gm7GDSE78j0Z3Hhi90hOjb+N/6bA5NCVhDX4hQSu9e0oMLMjIuWORb9CJlQLFGh5rTkGeJ6nwTrKdooSxRAH7ENyV9fyUlnVLoh6M+C2JFPJ3oOH7Es5fKQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710025; c=relaxed/simple;
	bh=ixRFlcHFqDgDYLNxCjKTpa+gm1DaSPbQagqOIZbFrCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTN8e/fAStX0dg6DBoCnnZPcmOzJg1NWoXJr6FVco8NjMtDOjjZlKdT8mFT3/lmt3RyB2HYBPEFgw//n6i4TljlMmu+s6f5de3ABtPBsevHWhStRtbzdPz+iJ3h0/StqGlMHjZhdNSCxWfYf1fKJNiz+5FKN/ZAuQQFnoTWEh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGH1e-0005Oe-UA; Wed, 27 Nov 2024 13:20:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGH1c-000QZ6-2C;
	Wed, 27 Nov 2024 13:20:09 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGH1d-000xlP-15;
	Wed, 27 Nov 2024 13:20:09 +0100
Date: Wed, 27 Nov 2024 13:20:09 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC net-next 02/23] net: phy: fix phy_ethtool_set_eee()
 incorrectly enabling LPI
Message-ID: <Z0cOeUa2XSFQs0zq@pengutronix.de>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <E1tFv3F-005yhT-AA@rmk-PC.armlinux.org.uk>
 <Z0b-nJ7bt8IlBMpz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0b-nJ7bt8IlBMpz@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

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
> 
> The problem, however, are drivers where the LPI timer is dependent on
> the speed.
> 
> Any thoughts?

So far, i was not able to find any. But, like I said before, to get
optimal performance and power saving balance, the lpi_timer should be
link speed specific... at least, some day with appropriate user
interface.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

