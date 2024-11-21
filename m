Return-Path: <netdev+bounces-146647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA89D4E34
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B36280CB0
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8551D90B6;
	Thu, 21 Nov 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y2SIF5nX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9011D6DB5
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197615; cv=none; b=qg9I9661S2TQbku7++ycNAkSha1PTpbteRT20llYkdzl0f4+UPJMQxBR/VE0I3s6Scf1u6fkZv/uGl2awG+g72dNF2dvpNaEAtMASwzTPu+k4UkPTshXNf7KW+zQvuPoE+C2aeWfLd7R4QPQ4jt2LwvVwrxLPYPwqHCrwq8iaaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197615; c=relaxed/simple;
	bh=7RgFP6UuxwQYmWQb6rn744Zd3NSDGlxQx4n7n6wtFzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnnqXlDo9IVlGJw2cpKctCJ4twnZpBQi8HQKaIjnByp+xl1mFP7LbZIlJYrm7aT7i52r0dHdNbz5b9ZPHVtT8l07M8xLbp3qXQeknzUJ9X46Ux75mRvgt3eVg6ozzCw2wGcy8tA+pZ0Y7b9yzC5GFS1PWX/Y0rERIl+J5nxeA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y2SIF5nX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kIDX6Fkl+Q7yxJZnKo0gK/TnsINUD39cdrx85nEWnFA=; b=Y2SIF5nXfBqPfvAlm3BbWzwLMk
	7yQm/qEjUMgDibsd8qtj8J9nXodw3hNuRg+ecZTNm/mYTH8vpxtNjQn81lfPduLxglB8zF6kwDgWp
	M61SUX10ytfrL7JyTxHdKwr7pXzh732/AW2MGIwiAFKSaQODiEW/Jivcwe6LhLfaSKjU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tE7iy-00E3qr-Uh; Thu, 21 Nov 2024 15:00:00 +0100
Date: Thu, 21 Nov 2024 15:00:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net,
	Russell King <linux@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Moving forward with stacked PHYs
Message-ID: <1646a5bd-24c7-43fb-9d52-25966aafb80f@lunn.ch>
References: <20241119115136.74297db7@fedora.home>
 <Zz7zqzlDG40IYxC-@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz7zqzlDG40IYxC-@pengutronix.de>

> > On that front, there's more work coming to improve on that :
> >   - It would be good if the stats reported through ethtool would account
> >     for all the PHYs on the link, so that we would get a full overview
> >     of all stats from all components of the link
> 
> Ack, i'm working right now on the standardized PHY stats. With some work on
> kernel side it would be possible to get with something like this:
> ethtool -S eth1 --all-groups

Naming becomes interesting, when you have multiple PHYs. You need to
indicate which PHY the stats are from. So it will need nested netlink
properties. I don't think we have anything like that at the moment for
ethtool statistics, but it does exist in other places, e.g. cable
testing results.

> >   - A netlink notification to indicate that a new PHY was found on the
> >     link is also in the plans.
> 
> This will be cool. I was thinking about netlink notification for some
> health issues, to avoid polling on the user side.

We need to think about when we send the notification. During
enumeration of the MDIO bus, during probe, or when the PHY is
connected to its upstream? What are the userspaces user cases for this
notification?

> > There's a lot more work to do however, as these user-facing commands aren't
> > the only place where netdev->phydev is used.
> > 
> > The first place are the MAC drivers. For this, there seems to be 2 options :
> > 
> >  - move to phylink. The phylink API is pretty well designed as it makes
> >    the phydev totally irrelevant for the MAC driver. The MAC driver doesn't
> >    even need to know if it's connected to a PHY or something else (and SFP
> >    cage for example). That's nice, but there are still plenty of drivers
> >    that don't use phylink.
> 
> This would be nice, but this is too much work. Last week I was porting lan78xx
> to PHYlink. Plain porting is some hours of work, the 80% of time is
> testing and fixing different issues. I do no think there are enough
> resources to port all of drivers.

It is clear that we the Maintainers cannot convert all MAC drivers to
phylink. But i would be happy to say if you want to support multiple
PHYs, you need to use phylink. To some extent, it is already that
way. I don't think there are any systems with SFPs using phylib.  So i
would not change the phylib API. Keep netdev->phydev meaning the first
PHY, and maybe encode the assumption that it is the only PHY with a
netdev_warn() if that assumption gets violated.

> > There are other parts of the kernel that accesses the netdev->phydev. There
> > are a few places in DSA where this is done.

Many of the DSA drivers are now phylink, not phylib. Any using SFPs
will be phylink. I would leave those using phylib alone, same as other
MAC drivers.

> > Finally, there's the whole work of actually configuring the PHY themselves
> > correctly when they are chained to one another, and getting the logic right
> > for the link-up/down detection, getting the ksettings values aggregated
> > correctly, etc.
> > 
> > We have some local patches as well for that, to handle the stacked PHY
> > state-machine synchronisation, link-reporting and negociation but
> > it's still WIP to cover all the corner-cases and hard-to-test features, for
> > example how to deal with WoL or EEE in these situations.
> 
> I assume, even with stacked PHYs, some kind of power management would
> be needed. The WoL is probably less interesting, since all attached PHYs are
> under linux control, so we can suspend or resume them.
> 
> The EEE on other hand, may help to reduce run time power consumption.
> Still, it the user space should know about it, since it may be critical
> for time critical tasks.

We also need to consider where in the chain EEE, WoL, Pause etc are
relevant. Both EEE and Pause it about negotiation, and that happen in
the PHY closet to the media. WoL in theory could happen anywhere, but
ideally you want it as close to the media as possible, so you can
power off intermediary PHYs. But can PHYs in SFP actually wake the
system? I don't think i have ever seen that, there is no interrupt pin
on the SFP cage.  However WoL is currently a mess and MAC driver
writers get is wrong. I would say WoL is another area we need a new
API moving as much code into the core as possible, same as we have
done for EEE, phylink handling of Pause etc. But that is probably out
of scope for this work, but should be kept in mind.

	Andrew

