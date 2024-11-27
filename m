Return-Path: <netdev+bounces-147587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98209DA65D
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0AB282868
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04531E47BC;
	Wed, 27 Nov 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pv87Y4Sj"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B41E376D;
	Wed, 27 Nov 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705257; cv=none; b=Wy6evAXJRrKGESFioex1ovjDFfwSEhWF45c8t0y4XNCCVBpjP5hoO8aMnOKT87CIwgKLzYeQozaF+sHL31VFRn002fUENmOKVyZHHeRIoLRBtfJKwnYG7c7d8R8ayPm/VpadE+8SDlApblxXSNFoSkqzbVzyoRjPxMQuZGwJNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705257; c=relaxed/simple;
	bh=kcmvs+J47xjeOpvV1y4vvCfT5Bn5tQ+LmzuSzoC77YA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P035Hw+i5iFMrudanb3yzGsgnu0tqEAmb37fRoXadeGs+eoevilNwr+etVpD80GGZQwStx4mN1qZYwkjdYllpa1NVgUH9fRjhbpCyYTHWsYPBuKL6DL6Mi+Mtrt+7ysCY+wSAGRp+SSnVOKy7qqdIKJBh+VjS6B1sF20Nu5CT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pv87Y4Sj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42967E0002;
	Wed, 27 Nov 2024 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732705245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0+wffrVBsu3CHmy6gEtPliZGwnXtIwNd2yxS+QcjcQ=;
	b=Pv87Y4SjSRcbi5ayzlXj02F6fD6BzK0tkOWobmpUmuft8Vevh/Ek7luBCYyJg3d1JZlBN2
	tI7GRs1JIxQ02aZX4bujexhe38UCZS0hjtTUPeJLqx0hBd/2bYv/ahMDBcoaxcXVGjL1Bw
	4AXJEMpos2h/78tFwJuLBpgsN9YqaBoA1Q93cuWWgAPnRtSp5/q5zWyCL26QwhCmGajgSE
	ELShn8BuhUrv4onawvLItroIkU+WjXTQY3wsbc8Jakbcf4yALbJlXdETMvMR8RQMwLVLrW
	lRCLbSgQaSz1i3JWlpB/Z8Wltvc2kWfPBX42fQDZZvPi4FOPqHk0gwBShUMrsg==
Date: Wed, 27 Nov 2024 12:00:43 +0100
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
Message-ID: <20241127120043.481bf0a2@kmaincent-XPS-13-7390>
In-Reply-To: <Z0b09t5ww7FOTOow@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
	<Z0WJAzkgq4Qr-xLU@pengutronix.de>
	<20241126163155.4b7a444f@kmaincent-XPS-13-7390>
	<20241126165228.4b113abb@kmaincent-XPS-13-7390>
	<Z0bmw3wVCqWZZzXY@pengutronix.de>
	<20241127111126.71fc31e0@kmaincent-XPS-13-7390>
	<Z0b09t5ww7FOTOow@pengutronix.de>
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

On Wed, 27 Nov 2024 11:31:18 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, Nov 27, 2024 at 11:11:26AM +0100, Kory Maincent wrote:
> > On Wed, 27 Nov 2024 10:30:43 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >  =20
> > > On Tue, Nov 26, 2024 at 04:52:28PM +0100, Kory Maincent wrote: =20
>  [...] =20
>  [...] =20
> > >  [...] =20
> > >  [...]   =20
>  [...] =20
> > >=20
> > > Good question :)
> > >  =20
>  [...] =20
> > >=20
> > > And a way to upload everything in atomic way, but I see it as
> > > optimization and can be done separately
> > >  =20
>  [...] =20
> > >=20
> > > Both can be implemented for TI. By constantly polling the channel
> > > current register, it should be possible to implement dynamic strategy.
> > >  =20
>  [...] =20
> > >=20
> > > Use hard coded one =C2=AF\_(=E3=83=84)_/=C2=AF =20
> >=20
> > I think we could start with disabled disconnection policy for now.
> > The user cans still play with the priority value which is really reason=
able
> > as there is as many priority values as PSE ports in the static strategy=
. =20
>=20
> Hm, since prios without disconnecting do not make sens and it looks more =
like
> all disconnection policies are optimizations steps for configurations with
> multiple ports having same prio, i would suggest an implementation where
> no same prios are allowed on multiple ports.

This won't allow users that don't care about priorities.

I think as we support only budget strategy for now. On the case of power bu=
dget
exceeded we should disconnect all the ports that are on the lowest priority
until we get enough power. If there is no ports with a lower priority than =
the
newly connected we should not power on the newly connected.

With my proposition, at boot as all the ports have the same priority it is =
like
we don't care about priority.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

