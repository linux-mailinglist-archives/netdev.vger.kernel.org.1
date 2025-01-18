Return-Path: <netdev+bounces-159552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A8EA15C0B
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 10:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F61B7A3DD7
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1878B15573F;
	Sat, 18 Jan 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t97Uil/B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B1139CF2;
	Sat, 18 Jan 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737191065; cv=none; b=Gg4Iz5CyJTwKI/NMj80Le8aa7SLuXprLf/lsqTA2PMF2b4m6f6rO7F0bdnXrAiU7SAw5pzc8hkRaEtpqNMpC8KwMikcGUt/SdBJ5pb9deGeYo3K9ukrhoiiFAg+pZwD1Sb1cCjqocvIIjYiap3LWtV7htHWsfnsQAluLXx9lTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737191065; c=relaxed/simple;
	bh=naT3iph+nxR4OeylEHjLjgM3/XEaVsXA95TemKA4LsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqxF4jHVvZPApR7/XhZDQsgyci+BWWXw58qdTlE0C0EqfxISHwRatYZbkwJjFmkTDs+s2E7Ae0W2Dl81OlWDbjniPwN5tiNLAvWgLE2AlqgdADWXkrWfrpt1B7zz9GkK9rTkV6m87HhLf3qW8oGhakuMfk2BcDFAnFr5SZ8Q+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t97Uil/B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u9EnCPaSODmC3ne/xz6nn9IUgZ7FAMYszzHWXcwFOh4=; b=t97Uil/BaRP39fLNn3wIh01jFe
	CUswQgcfv2BB8Fi7A/V8BUe3c+fK2we1ea6hQsA/Rapevmu9fUOXpqxEaicyqVbLKEKSk0D3SWQl4
	4GxKPeYSMwhjnHZnIKGZ4Q3Vx6UeR+/39IG+W8EkPRtBLwsco2GghB0CkZSn4G42kvjtbp1LRijgT
	5ZmR0GLDg656o3n5YvRSgyaug5hxTy6x2bVH5BDu1lUGyTAmOKUyLR6JVCBBZJAP+diTlIN9l6+vU
	PHDV5QSGMz7qIcGXENujiWtQ787g3uyn7+v6s/ykQcSyoO0fFQH1yo+dIi2N8XuCHO+uHPB1896lG
	NAWodVIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58256)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tZ4kU-0004Qh-2e;
	Sat, 18 Jan 2025 09:04:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tZ4kR-0000kA-25;
	Sat, 18 Jan 2025 09:04:07 +0000
Date: Sat, 18 Jan 2025 09:04:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4tuhzHwiKFIGZ5e@shell.armlinux.org.uk>
References: <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
 <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
 <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
 <Z4qEGIRYvSuVR9AK@shell.armlinux.org.uk>
 <Z4tWpxvwDG9u4MwJ@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4tWpxvwDG9u4MwJ@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 18, 2025 at 08:22:15AM +0100, Oleksij Rempel wrote:
> On Fri, Jan 17, 2025 at 04:23:52PM +0000, Russell King (Oracle) wrote:
> > I'm unsure about many DSA drivers. mt753x:
> > 
> >         u32 set, mask = LPI_THRESH_MASK | LPI_MODE_EN;
> > 
> >         if (e->tx_lpi_timer > 0xFFF)
> >                 return -EINVAL;
> > 
> >         set = LPI_THRESH_SET(e->tx_lpi_timer);
> >         if (!e->tx_lpi_enabled)
> >                 /* Force LPI Mode without a delay */
> >                 set |= LPI_MODE_EN;
> >         mt7530_rmw(priv, MT753X_PMEEECR_P(port), mask, set);
> > 
> > Why force LPI *without* a delay if tx_lpi_enabled is false? This
> > seems to go against the documented API:
> > 
> >  * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
> >  *      that eee was negotiated.
> 
> According to MT7531 manual, I would say, the code is not correct:
> https://repo.librerouter.org/misc/lr2/MT7531_switch_Reference_Manual_for_Development_Board.pdf
> 
> The LPI_MODE_EN_Px bit has following meaning:
> 
> When there is no packet to be transmitted, and the idle time is greater
> than P2_LPI_THRESHOLD, the TXMAC will automatically enter LPI (Low
> Power Idle) mode and send EEE LPI frame to the link partner.
> 0: LPI mode depends on the P2_LPI_THRESHOLD.
> 1: Let the system enter the LPI mode immediately and send EEE LPI frame
>    to the link partner.

Okay, so LPI_MODE_EN_Px causes it to disregard the LPI timer, and enter
LPI mode immediately. Thus, the code should never set LPI_MODE_EN_Px.

> This chip seems to not have support for tx_lpi_enabled != eee_enabled
> configuration.

Sorry, I don't see your reasoning there - and I think your
interpretation is different from the documentation (which is
the whole point of having a generic implementation in phylib
to avoid these kinds of different interpretation.)

 * @eee_enabled: EEE configured mode (enabled/disabled).
 * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
 *      that eee was negotiated.

           eee on|off
                  Enables/disables the device support of EEE.

           tx-lpi on|off
                  Determines whether the device should assert its Tx LPI.

The way phylib interprets eee_enabled is whether EEE is advertised
to the remote device or not. If EEE is not advertised, then EEE is
not negotiated, and thus EEE will not become active. If EEE is not
active, then LPI must not be asserted. tx_lpi_enabled defines whether,
given that EEE has been negotiated, whether LPI should be signalled
after the LPI timer has expired.

phylib deals with all this logic, and its all encoded into the
phydev->enable_tx_lpi flag to give consistency of implementation.

Thus, phydev->enable_tx_lpi is only true when eee_enabled && eee
negotiated at the specified speed && tx_lpi_enabled. In that state,
LPI is expected to be signalled after the LPI timer has expired.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

