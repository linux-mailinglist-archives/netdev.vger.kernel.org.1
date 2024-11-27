Return-Path: <netdev+bounces-147589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023939DA69C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A508E1623A8
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD261EE00C;
	Wed, 27 Nov 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nUjmzZSp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D11198E6E
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705968; cv=none; b=jfxRiN+rzBH2p/SKGreGIZGG7oBidTF0sCSjH3Cv480pdGjvfblWzamB6cwEjiDEFjhvrUlsnx+nWYePE3dyPPQMNyouuW9pcsJ3tAMPma+Qd3diEvHrw5WFdtfZmrEee7paB/1ePfosMohfKzkipje7Agw8FdKlFt/mq9xkhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705968; c=relaxed/simple;
	bh=vdZH3/2aZfr6fG/Im9L3M1CFgUDwLeyFoFp+clCBCgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4YkaVEHwTtO5ydvkFkouHJdnSzuOF5FMQ4CrS+Vn279L9bLqUAG3hlcJ/32L/Yl56qaoW9VByTiyL29KYl9cZSD/ctQhlLIiz4ljzlcdahxxhzSPjjeID3l0NQeHVsLVhT04Q7MDHnE/lLyEH2/hq8OrWnk8689EhfD/9rDnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nUjmzZSp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YV7Ng+UILJGgeX2OpLHjyU7yknzjQ5R3jvrdw+xvoG8=; b=nUjmzZSp0723C2w0rHv8ZaBBLX
	XrkG0T8d+DtE6S1tVqA9igzcoRFqbPXKGKBIZ4RCgzvAxBiu8zSDZRkP20hWC2zi8ejzAABOEMym7
	kYc3vo4iaWZF96oJya2fXWPR/2ADrBQ2Zc0LVayYCZsQVkNbns4K+a83WfHjjVGA5cDWoE8WNokM1
	BTj6Cw6Y2MGA2Jun7EV5DrGKSxIzwuJwfIzhGN8NocCwFQ8KLj+3vKYKXnyWG1EIJTTSRYRTqE4Ok
	SFB0hKL53Udq4ZcTt7L3qRABwslS07W0/G/N7Vg31EgBkjZdFOHliWC/4WxGFkZcvzPgVJTyDpfDt
	SsxAZIxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39324)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tGFyC-0000E0-0T;
	Wed, 27 Nov 2024 11:12:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tGFy8-00076l-1e;
	Wed, 27 Nov 2024 11:12:28 +0000
Date: Wed, 27 Nov 2024 11:12:28 +0000
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
Subject: Re: [PATCH RFC net-next 02/23] net: phy: fix phy_ethtool_set_eee()
 incorrectly enabling LPI
Message-ID: <Z0b-nJ7bt8IlBMpz@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <E1tFv3F-005yhT-AA@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFv3F-005yhT-AA@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 26, 2024 at 12:52:21PM +0000, Russell King (Oracle) wrote:
> @@ -1685,15 +1685,21 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
>  static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
>  				      const struct eee_config *old_cfg)
>  {
> -	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
> +	bool enable_tx_lpi;
> +
> +	if (!phydev->link)
> +		return;
> +
> +	enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;
> +
> +	if (phydev->enable_tx_lpi != enable_tx_lpi ||
>  	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {

I'm wondering whether this should be:

	if (phydev->enable_tx_lpi != enable_tx_lpi ||
	    (phydev->enable_tx_lpi &&
	     phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer)) {

The argument for this change would be to avoid cycling the link when the
LPI timer changes but we're not using LPI.

The argument against this change would be that then we don't program the
hardware, and if the driver reads the initial value from hardware and
is unbound/rebound, we'll lose that update whereas before the phylib
changes, it would have been preserved.

The problem, however, are drivers where the LPI timer is dependent on
the speed.

Any thoughts?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

