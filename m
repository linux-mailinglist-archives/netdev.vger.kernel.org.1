Return-Path: <netdev+bounces-128730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9A397B36A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 19:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3051C21D39
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2C17838F;
	Tue, 17 Sep 2024 17:16:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A5176FB6;
	Tue, 17 Sep 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593382; cv=none; b=CnF5DOWmaNO5/dxMSYzzZqPpXEauUcHqBu6BHe6mEzeVVGw0MuYuyVnnSjR+J59XUY5uHM0J6WOmC69TSB5yOKkQd2cBMBwbXuMkfFA7Dj4612ajOUHuSM580GhZa4OXwtvfYtv7zqCJdhdUGLBkg2vdGArPmfSRj32pzgT4g6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593382; c=relaxed/simple;
	bh=bNJO+f+3Ynt7m/2Phy4VIQv+/7KNQP8G4MVtVwXLurg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiETP59iYXR+4VvGpKtp5/fYU5d4OphQ/i/f0olfy97pLGj2120+chyoVM4wRDfaT9lqkmJ1wQo/KztqtWob93dTunJ0M1GYh6hEujW3HUv+QG/9mOC/ECLQ+yjv3MiZDRiz1kBjVDLieb78Lx8rUWmteFOO5+mDtDLxttRq+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sqbo9-000000003uJ-0sTh;
	Tue, 17 Sep 2024 17:16:09 +0000
Date: Tue, 17 Sep 2024 18:16:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <Zum5VTDZSv3d46aD@makrotopia.org>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
 <ebfeeabd-7f4a-4a80-ba76-561711a9d776@lunn.ch>
 <ZuhsQxHA+SJFPa5S@shell.armlinux.org.uk>
 <20240917175347.5ad207da@fedora>
 <ZumwjxMVpoJ+cqvH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZumwjxMVpoJ+cqvH@shell.armlinux.org.uk>

On Tue, Sep 17, 2024 at 05:38:39PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 17, 2024 at 05:53:47PM +0200, Maxime Chevallier wrote:
> > For the SFP case, the notification would trigger indeed at the
> > module_start/module_remove step.
> 
> This (the confusion of module_remove being the opposite of
> module_start)...
> 
> > 
> > All of that is still WIP, but I think it would reply to that exact need
> > of "notifying users when something happens to the ports", including SFP
> > module insertion.
> 
> and talking here about module insertion here, leads me to believe that
> you haven't grasped the problem with SFPs, where we don't know what
> the module supports at _insertion_ time.
> 
> If we're after giving userspace a notification so it can make decisions
> about what to do after examining capabilities, then insertion time is
> too early.
> 

Exactly. It needs to be after the PHY has been probed (which can take
up to 25 seconds after insertion).

> If we're after giving userspace a notification e.g. that a SFP was
> inserted, so please bring up the network interface, then that may be
> useful, but userspace needs to understand that SFPs are special and
> they can't go configuring the link at this point if it's a SFP.
> 
> Honestly, I do not want to expose to userspace this kind of complexity
> that's specific to SFPs. It _will_ get it wrong. I also think that it
> will tie our hands when working around module problems if we have to
> change the way module capabilities are handled - and I don't wish to
> be tied by "but that change you made to make module XYZ work breaks
> my userspace!" because someone's using these events to do some weirdo
> configuration.

The problem I'm trying to address (see initial post) is that the user may
want to configure some properties of the link, such as whether or not to
announce flow-control capabilities to the link partner, or (more rarely)
to limit to think speed to, let's say 100M/Full, even though 1000M/Full
would be possible, e.g. to work around problems with bad cabling.

Doing so, even right now, doesn't require much specific knowledge about
the MAC or SFP/PHY capabilities, all we need to do is to clear some
bits from the advertised field. So in my case userspace doesn't make
any attempt to identify the MAC ro SFP/PHY capabilities or act according
to them.

Currently, in order to know *when* to apply those settings (again) I'm
relying on an unreliable hack upon receiving RTNL events:

if ((flags & IFF_UP) && !(flags & IFF_LOWER_UP))
	system_set_ethtool_settings(dev, &dev->settings);

And that doesn't work well, which is why I started to reach out if there
is a better solution for that.

