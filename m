Return-Path: <netdev+bounces-149377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A309E550F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F64280DFD
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231B217F2A;
	Thu,  5 Dec 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IUs8BUFf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE076217721;
	Thu,  5 Dec 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400610; cv=none; b=EV4MhCgya1P0JlZrSkhMwHvB72LCUFyo43cVGmqDilKgGM/IRMvt4aZap5MrnyjWgdc0ih1ockSAgYC0Z2Ia1Q4FT064fRxzc1uMm79ZfCf2ZsK+TZ77ouxCnEBFMt+hjvMdzXs2z5Lbk5JqalUvNKw9vM2vs0iixHVp2KHhlAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400610; c=relaxed/simple;
	bh=nSw2S081MxgrHQoHqBdbl/8uu8jfUiCqYx4YvPZLeIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwM7sEtLmMBjrD02I1GNlY1CmdKJPmEWL26GVNBn4jkBvh9nrUKJ75Td9nLXFuugmZ/jiVjaqqaUY4n0MT2KhErylV396apK5mMgoCkZ0NhY8jfxzVvxRl9yQcVLzmoZ58sRiNR7cvTNvIrEuLvH1CzwsCQw4BJ3CqUl3x+02kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IUs8BUFf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R0B5oB9aAdPieEE1LiKNCZn6NUPOqq3DmQIQCxFphuw=; b=IUs8BUFfac62xpFcOL+XmmpeXR
	X/nNP2vla5fKVcOzODcgoG3ekTWl7hd4kjDvDSBsdK8aA6V1OCm0VB8XqlZw6t3m1+PAp+d/4pAzq
	SlpqHjeM2JcGlT8PSTO0oqZ6qthBt0ZCh5LVUV9HayS+3kC6j1bO6+OyHO/tsWg2G1wJf60mh7CNl
	25TI3jZHzUSbf08E+gpR011c885Hd5paL2b3wyJ6YJptx0yNg3L8q2Sk+QEIVuesgpCf9HLYA8K4w
	vmK3/FGMN7os0wdsvzZL/wPCBP0tok1HXzK/BkpCrEP6VVP2dgldmshylW/+74PUaRQk1MK3AYw60
	FmC2ptlQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45496)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAg9-0004lB-1i;
	Thu, 05 Dec 2024 12:09:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAg7-0006Xr-2o;
	Thu, 05 Dec 2024 12:09:55 +0000
Date: Thu, 5 Dec 2024 12:09:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 4/7] phy: introduce optional polling
 interface for PHY statistics
Message-ID: <Z1GYEyQ6vxK67Yh1@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-5-o.rempel@pengutronix.de>
 <87c2743c-1ee0-4c6c-b20d-e8e4a4141d43@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c2743c-1ee0-4c6c-b20d-e8e4a4141d43@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 05, 2024 at 09:14:08AM +0100, Mateusz Polchlopek wrote:
> On 12/3/2024 8:56 AM, Oleksij Rempel wrote:
> > Add an optional polling interface for PHY statistics to simplify driver
> > implementation. Drivers can request the PHYlib to handle the polling task by
> > explicitly setting the `PHY_POLL_STATS` flag in their driver configuration.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >   drivers/net/phy/phy.c | 15 +++++++++++++++
> >   include/linux/phy.h   |  6 ++++++
> >   2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index 0d20b534122b..b10ee9223fc9 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -1346,6 +1346,18 @@ static int phy_enable_interrupts(struct phy_device *phydev)
> >   	return phy_config_interrupt(phydev, PHY_INTERRUPT_ENABLED);
> >   }
> > +/**
> > + * phy_update_stats - update the PHY statistics
> > + * @phydev: target phy_device struct
> > + */
> 
> As this is newly intoduced function I would love to see the full
> kdoc header, with information what the function returns, like here:
> 
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

As it's an internal phylib function, I don't think there's any need for
kernel-doc unless it's something more complex. It's obvious what the
function itself is doing.

What would be more helpful is to properly document the "update_stats"
method, since that is what PHY drivers are going to implement. Yes, I
know kernel-doc isn't good at that, but look at phylink.h to see how
to do it.

> > @@ -1591,6 +1594,9 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
> >   		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
> >   			return true;
> > +	if (phydev->drv->update_stats && phydev->drv->flags & PHY_POLL_STATS)
> > +		return true;

Is there a case where ->update_stats would be implemented but we
wouldn't have PHY_POLL_STATS set?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

