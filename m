Return-Path: <netdev+bounces-147584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D29DA5D7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BED162129
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B7D192D7F;
	Wed, 27 Nov 2024 10:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C4198E76
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703512; cv=none; b=mBso7T/5vI2P3WR85O1bApRt+rHNdAWanNycuynK8DovQRldQnRKXmH7AhQ78tVjBUZCxPEgrTejEVrulgqdhBQs5GbRM5j+iWDaSWBAv05XZ9WVezCE3sDmGI9rpYtNFsk1FJ4wBv1tZHDYbyCiCUndwd8kKHP1tQgebP0gvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703512; c=relaxed/simple;
	bh=0njzOksj73e9dVaEyv4PWjXPUvpFtdhhtRD9RVOMZu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJXV6zG07k4WIvS7g4atAcTbgG/IBX45G//Hh9S9ijeWjdlNuaSFgU4IJ2Azy/lYteZCdhZvO5/wh3TbZ6ywYJCZ2uDZDEPXAjq7AmZcY4fbFYeSb2GkWT3cEBqVe9jjH/mqGxttqopE8btm36eWqipvU7cMLB2Qp+6W//jdqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGFKJ-00017z-Vk; Wed, 27 Nov 2024 11:31:19 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGFKH-000PRX-21;
	Wed, 27 Nov 2024 11:31:18 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGFKI-000vZt-0t;
	Wed, 27 Nov 2024 11:31:18 +0100
Date: Wed, 27 Nov 2024 11:31:18 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 21/27] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <Z0b09t5ww7FOTOow@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
 <20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
 <Z0WJAzkgq4Qr-xLU@pengutronix.de>
 <20241126163155.4b7a444f@kmaincent-XPS-13-7390>
 <20241126165228.4b113abb@kmaincent-XPS-13-7390>
 <Z0bmw3wVCqWZZzXY@pengutronix.de>
 <20241127111126.71fc31e0@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127111126.71fc31e0@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Nov 27, 2024 at 11:11:26AM +0100, Kory Maincent wrote:
> On Wed, 27 Nov 2024 10:30:43 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Tue, Nov 26, 2024 at 04:52:28PM +0100, Kory Maincent wrote:
> > > On Tue, 26 Nov 2024 16:31:55 +0100
> > > Kory Maincent <kory.maincent@bootlin.com> wrote:
> > >   
> > > > Hello Oleksij,
> > > > 
> > > > Thanks for your quick reviews!
> > > > 
> > > > On Tue, 26 Nov 2024 09:38:27 +0100
> > > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > >   
> >  [...]  
> >  [...]  
> > > 
> > > We already talked about it but a policies per port seems irrelevant to me.
> > > https://lore.kernel.org/netdev/ZySR75i3BEzNbjnv@pengutronix.de/
> > > How do we compare the priority value of ports that use different budget
> > > strategy? How do we manage in the same power domain two ports with
> > > different budget strategies or disconnection policies?  
> > 
> > Good question :)
> > 
> > > We indeed may need a separate interface to configure the PSE power domain
> > > budget strategies and disconnection policies.  
> > 
> > And a way to upload everything in atomic way, but I see it as
> > optimization and can be done separately
> > 
> > > I think not being able to set the budget evaluation strategy is not relevant
> > > for now as we don't have PSE which could support both,  
> > 
> > Both can be implemented for TI. By constantly polling the channel
> > current register, it should be possible to implement dynamic strategy.
> > 
> > > but being able to set the disconnection policies may be relevant.
> > > If we don't add this support to this series how do we decide which is the
> > > default disconnection policy supported?  
> > 
> > Use hard coded one ¯\_(ツ)_/¯
> 
> I think we could start with disabled disconnection policy for now.
> The user cans still play with the priority value which is really reasonable as
> there is as many priority values as PSE ports in the static strategy.

Hm, since prios without disconnecting do not make sens and it looks more like
all disconnection policies are optimizations steps for configurations with
multiple ports having same prio, i would suggest an implementation where
no same prios are allowed on multiple ports.

> Should we still report it in the status as there is no disconnection policy?
> Maybe we could add it at the time we will support several disconnection
> policies.

Yes. It would be better to have a discussion with some one having real use case.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

