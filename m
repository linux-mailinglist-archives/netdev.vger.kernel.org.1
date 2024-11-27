Return-Path: <netdev+bounces-147582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644DD9DA577
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271C0284230
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C910194A7C;
	Wed, 27 Nov 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZZpbfrNs"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FD140360;
	Wed, 27 Nov 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702295; cv=none; b=s104kbSoCRgLhFzCY2y8QgfjcB9wd4nKh4HNoqKjERJY4zqW9iBf1QqxTGfLlJFGfBzMDPLr837qdWwEa/Mej9DCm4epHbcaDJiRblI2+zjWGFDUIjUbVvZOIESSvl6JYRyyJkYnJD7YjZBPS5psQlueA6ZU37BnfhYwwfQVRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702295; c=relaxed/simple;
	bh=EI9LR5pKa+UUa9dp/CkLwrd9muTLdk6vHx6xs9VeJOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idqwh0Px39ncD/lO4klPjhNk1tZRY068JG4HHkidEnpDwhq+S8JjZW5MYjIhIJ+4V2a2MDbJXL3ZMvcwxJLoFFmIp3PZ49+U1/4uPjc4MoMDDt1RriGLHtoxQTdX9k3zfbHDusqC+PystZQ00wE26AawTtie2MS10s87R5BNqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZZpbfrNs; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D3BB40002;
	Wed, 27 Nov 2024 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732702288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tGVW64f437lNQnHA6t9eLRBy/yYXyMtyYXZVg4zLDE=;
	b=ZZpbfrNs/DmyyFnfQnfHa9iDFZg9Sv1T6ulqJgXxnSf50cRBBjKDJzSa5BW6GxZgSlLi2a
	bUWTFq5N+5F/k4ipFGnRY5dqgaehyKWZhAawOTQsFEnpENMztutew1XoqhxHB4pxsSjSXK
	w3v/7kSIrDznRlzxeqNOuDQKSUN6pZYb9EukFAW/PDgwO3ycrVuqeZji+lIaruFxfcGQnu
	30F2ATqBlqNjkUsYgvLSC97g9k7Kr9mk3vIwY8kGg2aNes0gFZG7VVQbapxNBIpQ9o2iUv
	EqDlVADqv/nTmmFspO7S12ewm1ofJZcsaOyRKZNR6LSMq3rtNkPHeELyMYCuFw==
Date: Wed, 27 Nov 2024 11:11:26 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 21/27] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <20241127111126.71fc31e0@kmaincent-XPS-13-7390>
In-Reply-To: <Z0bmw3wVCqWZZzXY@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
	<Z0WJAzkgq4Qr-xLU@pengutronix.de>
	<20241126163155.4b7a444f@kmaincent-XPS-13-7390>
	<20241126165228.4b113abb@kmaincent-XPS-13-7390>
	<Z0bmw3wVCqWZZzXY@pengutronix.de>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 27 Nov 2024 10:30:43 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Nov 26, 2024 at 04:52:28PM +0100, Kory Maincent wrote:
> > On Tue, 26 Nov 2024 16:31:55 +0100
> > Kory Maincent <kory.maincent@bootlin.com> wrote:
> >  =20
> > > Hello Oleksij,
> > >=20
> > > Thanks for your quick reviews!
> > >=20
> > > On Tue, 26 Nov 2024 09:38:27 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >  =20
>  [...] =20
>  [...] =20
> >=20
> > We already talked about it but a policies per port seems irrelevant to =
me.
> > https://lore.kernel.org/netdev/ZySR75i3BEzNbjnv@pengutronix.de/
> > How do we compare the priority value of ports that use different budget
> > strategy? How do we manage in the same power domain two ports with
> > different budget strategies or disconnection policies? =20
>=20
> Good question :)
>=20
> > We indeed may need a separate interface to configure the PSE power doma=
in
> > budget strategies and disconnection policies. =20
>=20
> And a way to upload everything in atomic way, but I see it as
> optimization and can be done separately
>=20
> > I think not being able to set the budget evaluation strategy is not rel=
evant
> > for now as we don't have PSE which could support both, =20
>=20
> Both can be implemented for TI. By constantly polling the channel
> current register, it should be possible to implement dynamic strategy.
>=20
> > but being able to set the disconnection policies may be relevant.
> > If we don't add this support to this series how do we decide which is t=
he
> > default disconnection policy supported? =20
>=20
> Use hard coded one =C2=AF\_(=E3=83=84)_/=C2=AF

I think we could start with disabled disconnection policy for now.
The user cans still play with the priority value which is really reasonable=
 as
there is as many priority values as PSE ports in the static strategy.

Should we still report it in the status as there is no disconnection policy?
Maybe we could add it at the time we will support several disconnection
policies.

> In terms of user configuration:
>=20
> Users only need to set the top allowed priority for each port. For exampl=
e, if
> a port is set to LRC, it will always be considered first for disconnection
> during a budget violation. The connection order of all LRC ports should be
> preserved.
>=20
> If a port is set to Index, it will be preserved until all LRC ports are
> disconnected.
>=20
> Setting a port to RR will make it the last in line for disconnection, thus
> ensuring the fairest distribution when other more prioritized policies ha=
ve
> already been applied. However, in practice, it may never be executed if a=
ll
> ports have higher priority policies.

That's a nice brainstorm! With that we will have a first idea when we would
like to really implement the disconnection policies.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

