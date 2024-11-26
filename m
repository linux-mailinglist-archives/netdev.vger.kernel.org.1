Return-Path: <netdev+bounces-147450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 965DC9D999C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF44B21619
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D783398E;
	Tue, 26 Nov 2024 14:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4081CB32A
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630909; cv=none; b=X3aFGkz91VnRcpOHycShoGLVuilTR04cs1pGrWfyw9ncLKa0rv714ELw5QKusdrFfLmLNsK8GWFYDteeDBi6g7CF204/h5dDDewi3y49V7nKSRsG5Io6CMVR+yJCvemNkHoeNYPxXbqatRO0qn9/zGDwCrU9zT07/CMp195WBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630909; c=relaxed/simple;
	bh=dS9yVchjTv0/oJ9s3FhzGaMWyMMfzEkXHhtOmGGcwdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRZed+syeDUPP9jIoJR6sqBD+vNXcQUyLqvoKf8INMjEdZnrrlKdiU67azLmK8lF/9RVlmDXnv4CYzeEuhrjrLVwVTUD7GK8YfwUEG+OLmOf+hKJXjnpcH5dzR88pRbuzPLzgJ98KVNfI+rYzz+DRm1IuYCzLlLNzNo2MyQIGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tFwRV-0001t6-Mp; Tue, 26 Nov 2024 15:21:29 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tFwRR-000GRf-2M;
	Tue, 26 Nov 2024 15:21:26 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tFwRS-00GeR7-1E;
	Tue, 26 Nov 2024 15:21:26 +0100
Date: Tue, 26 Nov 2024 15:21:26 +0100
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
Subject: Re: [PATCH RFC net-next 00/23] net: phylink managed EEE support
Message-ID: <Z0XZZszZFVbVl_kN@pengutronix.de>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <Z0XGl0caztvVarmZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0XGl0caztvVarmZ@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Russell,

On Tue, Nov 26, 2024 at 01:01:11PM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 26, 2024 at 12:51:36PM +0000, Russell King (Oracle) wrote:
> > Patch 11 adds phylink managed EEE support. Two new MAC APIs are added,
> > to enable and disable LPI. The enable method is passed the LPI timer
> > setting which it is expected to program into the hardware, and also a
> > flag ehther the transmit clock should be stopped.
> > 
> >  *** There are open questions here. Eagle eyed reviewers will notice
> >    pl->config->lpi_interfaces. There are MACs out there which only
> >    support LPI signalling on a subset of their interface types. Phylib
> >    doesn't understand this. I'm handling this at the moment by simply
> >    not activating LPI at the MAC, but that leads to ethtool --show-eee
> >    suggesting that EEE is active when it isn't.
> >  *** Should we pass the phy_interface_t to these functions?
> >  *** Should mac_enable_tx_lpi() be allowed to fail if the MAC doesn't
> >    support the interface mode?
> 
> There is another point to raise here - should we have a "validate_eee"
> method in struct phylink_mac_ops so that MAC drivers can validate
> settings such as the tx_lpi_timer value can be programmed into the
> hardware?
> 
> We do have the situation on Marvell platforms where the programmed
> value depends on the MAC speed, and is only 8 bit, which makes
> validating its value rather difficult - at 1G speeds, it's a
> resolution of 1us so we can support up to 255us. At 100M speeds,
> it's 10us, supporting up to 2.55ms. This makes it awkward to be able
> to validate the set_eee() settings are sane for the hardware. Should
> Marvell platforms instead implement a hrtimer above this? That sounds
> a bit problematical to manage sanely.

I agree that tx_lpi_timer can be a problem, and this is not just a
Marvell issue.  For example, I think the FEC MAC on i.MX8MP might also
be affected.  But I can't confirm this because I don't have an i.MX8MP
board with a PHY that supports MAC-controlled EEE mode. The Realtek PHY
I have uses PHY-controlled EEE (SmartEEE).

Except for this, I think there should be sane default values for
tx_lpi_timer.  The IEEE 802.3-2022 standard (Section 78.2) describes EEE
timing, but it doesn’t give a clear recommendation for tx_lpi_timer.
IMO, the best value for tx_lpi_timer should be the sum of the time
needed to put the full chain (MAC -> PHY -> remote PHY) into sleep mode
and the time needed to wake the chain. These times are link-speed
specific, so defaults should consider PHY timings for each link speed.

Except for tx_lpi_timer, some MACs also allow configuration of the Twake
timer.  For example, the FEC driver uses the lpi_timer value to
configure the Twake timer, and the LAN78xx driver also provides a
configurable Twake timer register.

If the Twake timer is not configured properly, or if the system has
quirks causing the actual Twake time to be longer than expected, it can
result in frame corruption. 

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

