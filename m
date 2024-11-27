Return-Path: <netdev+bounces-147586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33E9DA628
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AAF286921
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E881990C5;
	Wed, 27 Nov 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n7IcBDDl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E91990BB
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704598; cv=none; b=A0qBDCPCz78M+omPtHZ1a5VmTrlZ68cKzE1UvCC414UCKe+xJZAQfciLwKUufAqL/JhLjZNhpFYnEMxMsQxzgliYx2NvktU3dvtAtrmwkb8Eem1aA+EqbSgBAcvMnqk3PzcDIFOphxmFr+pd0Wwjmwq58+H4ldSDIeAcRRVmcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704598; c=relaxed/simple;
	bh=64ZLOpeB7mG+I1W7e1MgcEB9jUTK4RCTPuNYPQbkQho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgYM719ii52d15Mo7KCEZ5PPAiatAoHNcu7zn4uQoDehbiMUgpv9hF+Aa6uwLIKkfWPBgQmAglvvFC6/X4s1Tlgs89PzbxmyampXgBjjbnvprtW4Qv+VSlj4gn/9tFqVBtkAX+CNfC876Jo/mlQnMfz1gVuEuolricvjdCoZqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n7IcBDDl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2oZD0zN1OqlWY3Xl/s5KM7s42CEMCxfoFjW01Rsvl2k=; b=n7IcBDDliXi1TXfixo+nibhjRC
	6tliHVfbJRuMjwL23r8zVzg2t5H4Eu8qlexTRfd2g4dc6gUxTz6Rm3rank02nURIiNzNLE2c+LhUZ
	4oSEg0Ey0R+GpljVnyaYxZiC8anJQ9Z316HzOqyRPbmjm0ciiUq4cirUEI2hzNC4LmQ4Wzxq0buk+
	nKryo2u06SvVDKDMVxK9xQh1SvgckM8HzDvlLmB9WrTEV1lu7GAb0SGIn1xdRu+VOjKAr1ZgmBaVs
	qAVAbmtbaWyuVgS/axf4ldaRatPkkEts3hPjocFD8igQ8pJsIUWGbfdLKQdG6n4ppaZu4BGzjrJX4
	cVObfl9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38012)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tGFbu-00009L-1D;
	Wed, 27 Nov 2024 10:49:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tGFbp-00075l-2X;
	Wed, 27 Nov 2024 10:49:25 +0000
Date: Wed, 27 Nov 2024 10:49:25 +0000
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
Subject: Re: net: rtl8169: EEE seems to be ok (was: Re: [PATCH RFC net-next
 00/23] net: phylink managed EEE support)
Message-ID: <Z0b5NepJdXiEQ1IC@shell.armlinux.org.uk>
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

Looking at the rtl8169 driver, it looks pretty similar to the Marvell
situation. The value stored in tp->tx_lpi_timer is apparently,
according to r8169_get_tx_lpi_timer_us(), a value in bytes, not in a
unit of time. So it's dependent on the negotiated speed, and thus we
can't read it to set the initial phydev->eee_cfg.tx_lpi_timer state,
because in the _probe() function, the PHY may not have negotiated a
speed.

However, this driver writes keee->tx_lpi_timer after
phy_ethtool_get_eee() which means that it overrides phylib, so hasn't
been broken.

Therefore, I think rtl8169 is fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

