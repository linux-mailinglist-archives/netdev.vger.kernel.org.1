Return-Path: <netdev+bounces-156300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7F3A05FC5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA31B160F3B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A216192D66;
	Wed,  8 Jan 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wdvh5ZqS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1978126C13;
	Wed,  8 Jan 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349366; cv=none; b=HC0ReOMyiNNPDK7gvAwmPhUKUl4jYDPbukEWIQDZJk/hrRCXymLVrw1Q9y06VSt2a7pUiQAB/2AEPLoBqjBSGZctRn+7X0XJ330vMt9OGZzr1m+rLJVw8nri2lJCiCNo4nn8HvWlU8fPqCpcV6BckIxYEsG6bDf8PXGPwUns+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349366; c=relaxed/simple;
	bh=fUC+m3nwxrtFNP/KtgbbqNSnuzcseMWSgoGnut/18vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbwIAKOy+ikopRhQ5uAnXPifPdorUUYC2TYvy17MQFY1R7iBNNZw5qxeXYx8i5B5VVeE7DGFQW0f4SLVD6g8Ol4Wdp74loA6zFFuqnaROCsdD4NuBsvj5QNeUcHradOAH8dWcIfA7yyNkY5FHOtomOMjVZfvtqyxjrqE9LLH0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wdvh5ZqS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zo6OfvuhHp4sdZ10O6FDkeLKQUGmJO2YNdErvLunkBE=; b=wdvh5ZqSlJU0JlDGRrkedRHGtP
	tvP3DglrhXA74wVDkAeXEMLW2sr0kt8Yt/9fpW49c3Vl9lUinSNBa0GTXtdSTBZXzqe9QUqnEClHj
	Xj5I0f8GD9AcYgdlIZx+3lUY27/UKDyISxB2SN6ivBPiLWvhNden6/EtrLwWnaRSzuE+F85YA0e2v
	blWCayKWezUpou5zTGnNakSQ0CqVJAAVZ0PwSU8dD6Fn0AkGzKuIa3PYfLFPXiZJT+fCafrkppyPp
	FYuAOcMFGKsCf7E7cl9CnccOHYJGouKfAd/rCLFp9BxqWjlx2bV5VJXRMAzGWBHQQlIYbKaXeoR2l
	cKmHc5WQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47478)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVXml-0000nP-17;
	Wed, 08 Jan 2025 15:15:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVXmi-0006Oy-24;
	Wed, 08 Jan 2025 15:15:52 +0000
Date: Wed, 8 Jan 2025 15:15:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36KacKBd2WaOxfW@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 08, 2025 at 03:23:37PM +0100, Oleksij Rempel wrote:
> On Wed, Jan 08, 2025 at 12:47:37PM +0000, Russell King (Oracle) wrote:
> > On Wed, Jan 08, 2025 at 01:13:41PM +0100, Oleksij Rempel wrote:
> > > Refactor Energy-Efficient Ethernet (EEE) support in the LAN78xx driver
> > > to integrate with phylink. This includes the following changes:
> > > 
> > > - Use phylink_ethtool_get_eee and phylink_ethtool_set_eee to manage
> > >   EEE settings, aligning with the phylink API.
> > > - Add a new tx_lpi_timer variable to manage the TX LPI (Low Power Idle)
> > >   request delay. Default it to 50 microseconds based on LAN7800 documentation
> > >   recommendations.
> > 
> > phylib maintains tx_lpi_timer for you. Please use that instead.
> 
> Just using this variable directly phydev->eee_cfg.tx_lpi_timer ?

Yes. We're already accessing phydev->enable_tx_lpi directly, and we
have no helpers for this. Maybe it's more a question for Andrew,
whether he wishes to see phylib helpers for this state rather than
directly dereferencing phydev.

> > In any case, I've been submitting phylink EEE support which will help
> > driver authors get this correct, but I think it needs more feedback.
> > Please can you look at my patch set previously posted which is now
> > a bit out of date, review, and think about how this driver can make
> > use of it.
> 
> Ack, will do. It looks like your port of lan743x to the new API
> looks exactly like what I need for this driver too.
> 
> > In particular, I'd like ideas on what phylink should be doing with
> > tx_lpi_timer values that are out of range of the hardware. Should it
> > limit the value itself?
> 
> Yes, otherwise every MAC driver will need to do it in the
> ethtool_set_eee() function.

I've had several solutions, and my latest patch set actually has a
mixture of them in there (which is why I'm eager to try and find a way
forward on this, so I can fix the patch set):

1. the original idea to address this in Marvell platforms was to limit
   the LPI timer to the maximum representable value in the hardware,
   which would be 255us. This ignores that the hardware uses a 1us
   tick rate for the timer at 1G speeds, and 10us for 100M speeds.
   (So it limits it to 260us, even though the hardware can do 2550us
   at 100M speed). This limit was applied by clamping the value passed
   in from userspace without erroring out.

2. another solution was added the mac_validate_tx_lpi() method, and
   implementations added _in addition_ to the above, with the idea
   of erroring out for values > 255us on Marvell hardware.

3. another idea was to have mac_enable_tx_lpi() error out if it wasn't
   possible to allow e.g. falling back to a software timer (see stmmac
   comments below.) Another reason for erroring out applies to Marvell
   hardware, where PP2 hardware supports LPI on the GMAC but not the
   XGMAC - so it only works at speeds at or below 2.5G. However, that
   can be handled via the lpi_capabilities, so I don't think needs to
   be a concern.

> The other question is, should we allow absolute maximum values, or sane
> maximum? At some point will come the question, why the EEE is even
> enabled?

As referenced above, stmmac uses the hardware timer for LPI timeouts up
to and including 1048575us (STMMAC_ET_MAX). Beyond that, it uses a
normal kernel timer which is:

- disabled (and EEE mode reset) when we have a packet to transmit, or
  EEE is disabled
- is re-armed when cleaning up from packet transmission (although
  it looks like we attempt to immediately enter LPI mode, and would
  only wait for the timer if there are more packets to queue... maybe
  this is a bug in stmmac's implementation?) or when EEE mode is first
  enabled with a LPI timer longer than the above value.

So, should phylink have the capability to switch to a software LPI timer
implementation when the LPI timeout value exceeds what the hardware
supports? To put it another way, should the stmmac solution to this be
made generic?

Note that stmmac has this software timer implementation because not
only for the reason I've given above, but also because cores other than
GMAC4 that support LPI do not have support for the hardware timer.

> The same is about minimal value, too low value will cause strong speed
> degradation. Should we allow set insane minimum, but use sane default
> value?

We currently allow zero, and the behaviour of that depends on the
hardware. For example, in the last couple of days, it's been reported
that stmmac will never enter LPI with a value of zero.

Note that phylib defaults to zero, so imposing a minimum would cause
a read-modify-write of the EEE settings without setting the timer to
fail.

> > Should set_eee() error out?
> 
> Yes, please.

If we are to convert stmmac, then we need to consider what it's doing
(as per the above) and whether that should be generic - and if it isn't
what we want in generic code, then how do we allow drivers to do this if
they wish.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

