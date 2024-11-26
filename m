Return-Path: <netdev+bounces-147468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B209D9B61
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DFB2300E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D031D45F0;
	Tue, 26 Nov 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jYKJk0lq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8911187
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637678; cv=none; b=C+Q1YW4WEX0hKA705NO4SrV9mV3smREaRFHgr9nMmzxGf+UQVO9zZ1khz28ctdeXO0xqi32jOA5jkn/wodLl9/3qs/66owZXKnxYoRxC1EYCuGpMpESHLcmhFp37pkeekB1wIjje9uU3F1ECATaIs2eyAblKE/eo7d/9swYVekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637678; c=relaxed/simple;
	bh=koO/8LziUjzgYyg8i4r7utVGSG0ygxKNHvDE8lVTKGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fke+pRU4mGyALpdJmDP46YLBnndmj/70Ou02eeUxQRBZn67d+IiYTd1Nz/PFvre9yxXbureLhfS3ejIed60f3pB/1KPf5018+12wwE++WwLOhNZZXiDfkORqXRJWG4C7pFJ3zjlC28FNyweEF/U0/NWnQEMYuRN8tJ8d8u6Ro6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jYKJk0lq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9bEh6Q7is7zSazUqVxNmESa5J70olV6E8GbbdcoIHsY=; b=jYKJk0lqp9AxjkXjONk4Z8DHnS
	08uv8y6truPlScfoINQPnTqTF72NJJfAWNTtKWFizUFT96U1SV3AjccJEwV2KshentVPJRfd5wfzN
	EQ8hOrN7+qEy9CBbU3Fi4PyUrkea0PWtLvofFuW13bGuau8b+h3x3VX7xxv9EwwuYCzP3wnllvtUt
	hJ5VbYZoIeyyeo0yCOYThYzWHHlnHc4CSGcANEHfPYrXwNveznqfArowCdefAw9gHvWb5CDqUDaby
	XsHvj2L3+Dmz1O1qawZmIDfWWS2QR0XGDB3JWlBIwwLupw/bWe6B/ZusH6mQp3Lce/gDGWiVZo1MU
	7+p6MAmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48132)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tFyCf-0007Iq-38;
	Tue, 26 Nov 2024 16:14:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tFyCY-0004fu-2X;
	Tue, 26 Nov 2024 16:14:10 +0000
Date: Tue, 26 Nov 2024 16:14:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
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
Subject: Re: [PATCH RFC net-next 00/23] net: phylink managed EEE support
Message-ID: <Z0Xz0pQGXMIcG4jB@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <Z0XGl0caztvVarmZ@shell.armlinux.org.uk>
 <Z0XZZszZFVbVl_kN@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0XZZszZFVbVl_kN@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 26, 2024 at 03:21:26PM +0100, Oleksij Rempel wrote:
> Hi Russell,
> 
> On Tue, Nov 26, 2024 at 01:01:11PM +0000, Russell King (Oracle) wrote:
> > On Tue, Nov 26, 2024 at 12:51:36PM +0000, Russell King (Oracle) wrote:
> > > Patch 11 adds phylink managed EEE support. Two new MAC APIs are added,
> > > to enable and disable LPI. The enable method is passed the LPI timer
> > > setting which it is expected to program into the hardware, and also a
> > > flag ehther the transmit clock should be stopped.
> > > 
> > >  *** There are open questions here. Eagle eyed reviewers will notice
> > >    pl->config->lpi_interfaces. There are MACs out there which only
> > >    support LPI signalling on a subset of their interface types. Phylib
> > >    doesn't understand this. I'm handling this at the moment by simply
> > >    not activating LPI at the MAC, but that leads to ethtool --show-eee
> > >    suggesting that EEE is active when it isn't.
> > >  *** Should we pass the phy_interface_t to these functions?
> > >  *** Should mac_enable_tx_lpi() be allowed to fail if the MAC doesn't
> > >    support the interface mode?
> > 
> > There is another point to raise here - should we have a "validate_eee"
> > method in struct phylink_mac_ops so that MAC drivers can validate
> > settings such as the tx_lpi_timer value can be programmed into the
> > hardware?
> > 
> > We do have the situation on Marvell platforms where the programmed
> > value depends on the MAC speed, and is only 8 bit, which makes
> > validating its value rather difficult - at 1G speeds, it's a
> > resolution of 1us so we can support up to 255us. At 100M speeds,
> > it's 10us, supporting up to 2.55ms. This makes it awkward to be able
> > to validate the set_eee() settings are sane for the hardware. Should
> > Marvell platforms instead implement a hrtimer above this? That sounds
> > a bit problematical to manage sanely.
> 
> I agree that tx_lpi_timer can be a problem, and this is not just a
> Marvell issue.  For example, I think the FEC MAC on i.MX8MP might also
> be affected.  But I can't confirm this because I don't have an i.MX8MP
> board with a PHY that supports MAC-controlled EEE mode. The Realtek PHY
> I have uses PHY-controlled EEE (SmartEEE).
> 
> Except for this, I think there should be sane default values for
> tx_lpi_timer.  The IEEE 802.3-2022 standard (Section 78.2) describes EEE
> timing, but it doesn’t give a clear recommendation for tx_lpi_timer.

There are of course some parameters of EEE that should be fixed, and
IEEE specifies them in that section. These are Ts, Tq and Tr, and IEEE
gives a range of values for these which need to be conformed with in a
compliant implementation.

Please don't get confused by the mvneta/mvpp2 implementation, there are
parameters for Ts and Tw, but the Ts value is not the same as Ts in
IEEE. IEEE defines it as the period of time between the PHY transmitting
sleep and turning all transmitters off. Marvell define it as the minimum
time from the Tx FIFO being empty to asserting LPI - quite different!

Other parameters depend on the implementation, such as the propagation
delay of data through the PHY. These, we don't currently take account
of. I don't recall off-hand whether there's any standards defined
registers describing these parameters in the PHY (I need to delve into
802.3...) That's all needed for computing Tw.

> IMO, the best value for tx_lpi_timer should be the sum of the time
> needed to put the full chain (MAC -> PHY -> remote PHY) into sleep mode
> and the time needed to wake the chain. These times are link-speed
> specific, so defaults should consider PHY timings for each link speed.

One can only make a set of defaults that depend on the speed if we also
give the user the ability to set the tx_lpi_timer values on a per-speed
basis, otherwise how do we update the values when set_eee() gets called?

Also how do we know what the requirements of the remote PHY are? I think
the only way that could be known is by exchanging the EEE TLV with the
link partner as described in section 78.

> Except for tx_lpi_timer, some MACs also allow configuration of the Twake
> timer.  For example, the FEC driver uses the lpi_timer value to
> configure the Twake timer, and the LAN78xx driver also provides a
> configurable Twake timer register.
> 
> If the Twake timer is not configured properly, or if the system has
> quirks causing the actual Twake time to be longer than expected, it can
> result in frame corruption. 

I have been aware of it, and to me it sounds like another can of worms
that right now I'd rather not open until we have solved the basics of
EEE and got MAC drivers into better shape for the basics. I had been
wondering whether we would eventually need phylink to pass Tw along
with the LPI timer, and I think eventually we would need to - and we
also need some infrastructure for the EEE TLV, both sending it at the
appropriate time, and processing it when received. I don't think we
have any of that at the moment, so it would be another chunk of
development.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

