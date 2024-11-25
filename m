Return-Path: <netdev+bounces-147173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD89D7D65
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510472825DF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4718E047;
	Mon, 25 Nov 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gixFc15p"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9F18C03D
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524388; cv=none; b=p6VR5Knqr87j4yMvuI6YShy7ixVewmUFZVzEELkVWyKRBKc4ObyBYngnIJGZTc08L++eNdyoJbz1cy5jYCP8r4tXhHdlCh/g6mXRD0UJ2g7ULhBtGxWPh6p6U8JVQOmylv2CY2qdRtdCb+J9uc35Vp4J554ETmPSdPuIcapY5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524388; c=relaxed/simple;
	bh=uu3HHNt3Rdvk1WpSVbOtKHLZKPiU8tmajvfD52xK9VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkT6CUeVTayyn41OpLHsWUhp6F6gQeBErSUK8srlQ4SP+7pftYnGMbifJJisP1MkRnm+vwaE1M3uqMMlKv7IcWyY09UdJZRR9SEWbLxrEHadxDYRN29uc8F4+Lf5c6AYQLxlfH45ZzDw7nKLh4H7Xi50G1QieddnJ4DdaZ4zV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gixFc15p; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D60E240008;
	Mon, 25 Nov 2024 08:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732524384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIv/7RgBLzMpG3X4wiBwy2Iyu6e1pxYs+x3pUiKChdY=;
	b=gixFc15pm3KHP7+TzxQfBUAkRaJ15CrT4fsyFilY+W2XcGmuX2B+Ge+g2o/+x/FVB4ZJV3
	vNzn9t0Cdslr0yrfy9RVxYWy1mA3nmwc7YqnXzw357Wbr8NRmhvv+jjpm67i7CqoTYTdeO
	q3MmMtwdE7y7NJ7rzPBNSglVl/I5DR5mAgGLsyzT0YTTY7Yh3M1BsiRXEhh6Rmfdm/Vpph
	Y4n5hBFzdWttdwlS8a8m1zjWabK6vaI0ha61N7R/lpr3SxUyE32OdvfmK8nRJGiE+m4IxM
	aU+YRZVdi8F6sq30MXyqXjfaYzH7X455pomfhsyK8On2d2tP/J7FmhOhAZgeDA==
Date: Mon, 25 Nov 2024 09:46:22 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, Russell King <linux@armlinux.org.uk>, Romain Gantois
 <romain.gantois@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Kory Maincent <kory.maincent@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Moving forward with stacked PHYs
Message-ID: <20241125094622.65f0bb97@fedora.home>
In-Reply-To: <1646a5bd-24c7-43fb-9d52-25966aafb80f@lunn.ch>
References: <20241119115136.74297db7@fedora.home>
 <Zz7zqzlDG40IYxC-@pengutronix.de>
 <1646a5bd-24c7-43fb-9d52-25966aafb80f@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew,

On Thu, 21 Nov 2024 15:00:00 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > On that front, there's more work coming to improve on that :
> > >   - It would be good if the stats reported through ethtool would account
> > >     for all the PHYs on the link, so that we would get a full overview
> > >     of all stats from all components of the link  
> > 
> > Ack, i'm working right now on the standardized PHY stats. With some work on
> > kernel side it would be possible to get with something like this:
> > ethtool -S eth1 --all-groups  
> 
> Naming becomes interesting, when you have multiple PHYs. You need to
> indicate which PHY the stats are from. So it will need nested netlink
> properties. I don't think we have anything like that at the moment for
> ethtool statistics, but it does exist in other places, e.g. cable
> testing results.
> 
> > >   - A netlink notification to indicate that a new PHY was found on the
> > >     link is also in the plans.  
> > 
> > This will be cool. I was thinking about netlink notification for some
> > health issues, to avoid polling on the user side.  
> 
> We need to think about when we send the notification. During
> enumeration of the MDIO bus, during probe, or when the PHY is
> connected to its upstream?

The way I see this is based on the phy_link_topology. What is done
currently is that the SFP PHY is added to the topology when :

 - The .connect_phy() SFP upstream op is called, but ONLY if the
upstream PHY is attached to its netdev (otherwise, the upstream PHY
isn't in the topology)

 - Alternatively if the SFP phy is already attached to its upstream,
both the upstream PHY and the SFP PHY will be added to the tpopology
when the upstream PHY gets attached to its netdev.

The notification would be sent at that time. We can't really send it
before the PHYs are part of the topology because at that point we don't
know to which netdev it belongs.

> What are the userspaces user cases for this
> notification?

The way I see that, based on the appereance of PHYs, userspace may want
to re-ajust configuration, especially if :
 - The PHY is attached in .ndo_open() and
 - The PHY provides some kind of offloading capability (Timestamping,
maybe more such as macsec)

In that case, it's possible that userspace is interested in knowing
that a new PHY is here to re-adjust the offloads to the PHY.

But maybe a more correct approach would be a per-feature notif, such as
"there's a new timestamper on the link".

Some user also reported not so long ago the need to know when the SFP
PHY was attached to reconfigure the advertising.

> > > There's a lot more work to do however, as these user-facing commands aren't
> > > the only place where netdev->phydev is used.
> > > 
> > > The first place are the MAC drivers. For this, there seems to be 2 options :
> > > 
> > >  - move to phylink. The phylink API is pretty well designed as it makes
> > >    the phydev totally irrelevant for the MAC driver. The MAC driver doesn't
> > >    even need to know if it's connected to a PHY or something else (and SFP
> > >    cage for example). That's nice, but there are still plenty of drivers
> > >    that don't use phylink.  
> > 
> > This would be nice, but this is too much work. Last week I was porting lan78xx
> > to PHYlink. Plain porting is some hours of work, the 80% of time is
> > testing and fixing different issues. I do no think there are enough
> > resources to port all of drivers.  
> 
> It is clear that we the Maintainers cannot convert all MAC drivers to
> phylink. But i would be happy to say if you want to support multiple
> PHYs, you need to use phylink. To some extent, it is already that
> way. I don't think there are any systems with SFPs using phylib.  So i
> would not change the phylib API. Keep netdev->phydev meaning the first
> PHY, and maybe encode the assumption that it is the only PHY with a
> netdev_warn() if that assumption gets violated.

This is fine by me, this makes the path towards better isolation
between netdev and phydev much clearer, thanks Andrew :)

> > > There are other parts of the kernel that accesses the netdev->phydev. There
> > > are a few places in DSA where this is done.  
> 
> Many of the DSA drivers are now phylink, not phylib. Any using SFPs
> will be phylink. I would leave those using phylib alone, same as other
> MAC drivers.

No problem

> > > Finally, there's the whole work of actually configuring the PHY themselves
> > > correctly when they are chained to one another, and getting the logic right
> > > for the link-up/down detection, getting the ksettings values aggregated
> > > correctly, etc.
> > > 
> > > We have some local patches as well for that, to handle the stacked PHY
> > > state-machine synchronisation, link-reporting and negociation but
> > > it's still WIP to cover all the corner-cases and hard-to-test features, for
> > > example how to deal with WoL or EEE in these situations.  
> > 
> > I assume, even with stacked PHYs, some kind of power management would
> > be needed. The WoL is probably less interesting, since all attached PHYs are
> > under linux control, so we can suspend or resume them.
> > 
> > The EEE on other hand, may help to reduce run time power consumption.
> > Still, it the user space should know about it, since it may be critical
> > for time critical tasks.  
> 
> We also need to consider where in the chain EEE, WoL, Pause etc are
> relevant. Both EEE and Pause it about negotiation, and that happen in
> the PHY closet to the media. WoL in theory could happen anywhere, but
> ideally you want it as close to the media as possible, so you can
> power off intermediary PHYs. But can PHYs in SFP actually wake the
> system? I don't think i have ever seen that, there is no interrupt pin
> on the SFP cage.  However WoL is currently a mess and MAC driver
> writers get is wrong. I would say WoL is another area we need a new
> API moving as much code into the core as possible, same as we have
> done for EEE, phylink handling of Pause etc. But that is probably out
> of scope for this work, but should be kept in mind.

Indeed, to me at least it's a bit out of scope, but yes that's
something worth keeping in mind.

Thanks a lot for the answers Andrew and Oleksij.

Best regards,

Maxime

