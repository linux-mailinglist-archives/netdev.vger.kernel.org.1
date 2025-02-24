Return-Path: <netdev+bounces-169018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA2A420D6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B924169B17
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46024886A;
	Mon, 24 Feb 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MXBoTjUs"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491624889B;
	Mon, 24 Feb 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404028; cv=none; b=mpELaj2H/d71GH1uLe2+BE8RkXjHWecOP2x8WRrjXOOdwDrdFjDWba1catR5tcF9KQYMqAACFNZiHm7c8v3ze1r44Yp0Fv34BqMAzkZk0AOMj/uazRXEJYmUPbHxdJYOwMqbRi2hBQBseisnUeAqI3TqQAUPcEjqCNkYZ1tPLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404028; c=relaxed/simple;
	bh=2dHd4KnjPWv2ykRzFr7ZhW+iP+q3WqoFHN6uZ4GxReo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvY52QgfEdcTxZCGpLwEcBpGUEFoIvqXuBPCCyocVj28S2xu4oE8v0DmZZDZZ0WST6f8CIIbr5+W0E+B+unWVRRPG6K+UnLl0KBI0ndT1RykILhpm61AgIZ/E9OD1xRskEPwL3zXEfNSN/dR0ITtRe9p33235fYiX8KaVUQT6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MXBoTjUs; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A855B204D6;
	Mon, 24 Feb 2025 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740404023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dHd4KnjPWv2ykRzFr7ZhW+iP+q3WqoFHN6uZ4GxReo=;
	b=MXBoTjUsFDtLVczTsN4dMXf43jF2koAdK5EIfBKg4ENAdHqXp5w2JEb1xVZAL6fqsOKdRq
	U0rOBTWHDmhx0vGFHc32l5Y4k0HmuAK8EEGnvezGIjoE8XSQsC31wsDM/+UPAp/HxBrXQ0
	Nfx8PuANGov2QhT2D8jqZHHqulPFcj164vujplLNOH8h6mV/JDF7kDNJ9qjKTFa4PbCr2S
	lqrN8qM/9KDYn/eiCl4tLrb8SQ0YrEjJ4toQ/rvdYwicwc+hWZzm3pmrCEJ9Lu3fg7DeqM
	Mq/3B4D585JjQveoylMrg/DJD2OK+Y5LfbtXioJHcnOu6pUB5R/5MtsurRT0eQ==
Date: Mon, 24 Feb 2025 14:33:39 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 05/13] net: phy: Use an internal, searchable
 storage for the linkmodes
Message-ID: <20250224143339.3e9ba797@kmaincent-XPS-13-7390>
In-Reply-To: <20250222142727.894124-6-maxime.chevallier@bootlin.com>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
	<20250222142727.894124-6-maxime.chevallier@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepv
 gguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 22 Feb 2025 15:27:17 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

Only small typos:

> The canonical definition for all the link modes is in linux/ethtol.h,

ethtool

> which is complemented by the link_mode_params array stored in
> net/ethtool/common.h . That array contains all the metadata about each
> of these modes, including the Speed and Duplex information.
>=20
> Phylib and phylink needs that information as well for internal
> managmement of the link, which was done by duplicating that information

management

> in locally-stored arrays and lookup functions. This makes it easy for
> developpers adding new modes to forget modifying phylib and phylink
> accordingly.
>=20
> However, the link_mode_params array in net/ethtool/common.c is fairly
> inefficient to search through, as it isn't sorted in any manner. Phylib
> and phylink perform a lot of lookup operations, mostly to filter modes
> by speed and/or duplex.
>=20
> We therefore introduce the link_caps private array in phy_caps.c, that
> indexes linkmodes in a more efficient manner. Each element associated a
> tuple <speed, duplex> to a bitfield of all the linkmodes runs at these
> speed/duplex.
>=20
> We end-up with an array that's fairly short, easily addressable and that
> it optimised for the typical use-cases of phylib/phylink.
>=20
> That array is initialized at the same time as phylib. As the
> link_mode_params array is part of the net stack, which phylink depends
> on, it should always be accessible from phylib.

The rest looks ok for me.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

