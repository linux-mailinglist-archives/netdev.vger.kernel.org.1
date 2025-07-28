Return-Path: <netdev+bounces-210636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8AB1419E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F018C2A25
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666F275861;
	Mon, 28 Jul 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w/2kJuuq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A02741CB
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725274; cv=none; b=AvIRufQbc8XhloDmUdiyvUZK4P/bum4hUkUhf5sJ4BFggIK/Xcqos8GFzolHNbQ+lyuiHgnWd8P0LwKkLspHb5Pb0mtUZVGuP1itrcHH1r1BR6Wtf72aqviCCbrtPrUXlwx+YEjduOePhrC2LfTZ3AH3blycaRkDX2wqYsZeehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725274; c=relaxed/simple;
	bh=TjquXh0YeO+PZ9RHPuMQcUpi9eHuBtywHaXCmZ7qv9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQpEjbxrn9mdy4TvE40CfmqUWhrWMA4kQx1LtP4uYTZ+HJP1yLsw3lEqJHaINiNOPf5Wor0g5L3IgnPoZI9a7MttQXjhFqm19TUJ6UkZxOIGwNzcJyKIlL81QcxNBgDjY/PUNH+tdW98w9JdAYtD+bW42kjw9TfdZR5vT6tZ3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w/2kJuuq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q2WJT/kxEOUhaPow0205LOsDK8JhmSJ5YD08xubhx7Q=; b=w/2kJuuqSsJEI0KehdTGiYkqcR
	dM2viPfSYwnUIBjCFJL7q4So1z0YVONyoC9eN9w1Hs1bIB/IeAHfb9lKJvR1bJ+QY/m3IXSCbfFkb
	DjPc2wG4L8i+e7biWmDrX5DUOFsFW3zBZcRwzHXi0xLsw1yPpjkmULobR0cq7cs9aX6CEWfITR/bT
	cUFc/RTcp1nl9sv4YkMfdd6jULWuM/QAAFBXQf5QSZcVFGD0U84+4XYjmiH29LHtWRwDjY/yxMxJy
	+2bGps5EpLl6Yc9vFkkLrxEMzuhI/0EV0WiFqsCHu33ocZoL6GG7zoYwqUbJVZqhr25a/pArX8sc7
	6XSkxvxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ugS3K-0000h8-0k;
	Mon, 28 Jul 2025 18:54:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ugS3G-0004wY-1k;
	Mon, 28 Jul 2025 18:54:18 +0100
Date: Mon, 28 Jul 2025 18:54:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 6/7] net: stmmac: add helpers to indicate
 WoL enable status
Message-ID: <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 28, 2025 at 07:28:01PM +0200, Andrew Lunn wrote:
> > +static inline bool stmmac_wol_enabled_mac(struct stmmac_priv *priv)
> > +{
> > +	return priv->plat->pmt && device_may_wakeup(priv->device);
> > +}
> > +
> > +static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
> > +{
> > +	return !priv->plat->pmt && device_may_wakeup(priv->device);
> > +}
> 
> I agree this is a direct translation into a helper.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> I'm guessing at some point you want to change these two
> helpers. e.g. at some point, you want to try getting the PHY to do the
> WoL, independent of !priv->plat->pmt? 
> 
> > -	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
> > +	if (stmmac_wol_enabled_phy(priv))
> >  		phylink_speed_down(priv->phylink, false);
> 
> This might be related to the next patch. But why only do speed down
> when PHY is doing WoL? If the MAC is doing WoL, you could also do a
> speed_down.

No idea, but that's what the code currently does, and, as ever with
a cleanup series, I try to avoid functional changes in cleanup series.

Also, bear in mind that I can't test any of this.

We haven't yet been successful in getting WoL working in mainline. It
_seems_ that the Jetson Xaiver NX platform should be using PHY mode,
but the Realtek PHY driver is definitely broken for WoL. Even with
that hacked, and along with other fixes that I've been given, I still
can't get the SoC to wake up via WoL. In fact, the changes to change
DT to specify the PHY interrupt as being routed through the PM
controller results in normal PHY link up/down interrupts no longer
working.

I'd like someone else to test functional changes!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

