Return-Path: <netdev+bounces-141872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D29BC94F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A3B28496A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3471D4329;
	Tue,  5 Nov 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R2DH6s1R"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0721D1F7F;
	Tue,  5 Nov 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799213; cv=none; b=DKzlX5V/6m3Miam0CMNyGI7ASV4ubPbX8KTjJkOlVCfYjycw9hYZKyFPMMqEzQtbQ5sgyC8CNcNw1ZbGqp2DsNbTgCNxw2rjoHfzmDO0r2hXK5wIZBNxpH0h/LTJ81ySGJFyp4J/o9rJzhbRJyf8lw4nI30y+InMZCd6SUWL6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799213; c=relaxed/simple;
	bh=ShZSBzlSJjGqReX5nZQtQ4Eh7QhJd/5jOt7l7Wr4Oxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+eI8773dRrrUDGbRFu4u3f17sS/gK3Zctn+phyc7YS3WL+y6q8HCQUleYq1WsWHpvPnM8qnDCd4cCkeq7+CoZAMhpbEYfNE7yfg6dyg7o//xRBvCxqIIIh7fwmrJg/pfhGtTgUE9XxZIzSYN2S2mncrdwXg1nSpnuJqyTUGS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R2DH6s1R; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BFFD1BF208;
	Tue,  5 Nov 2024 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730799209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/haLkH9+WBxFYlJ3qiO9MnhWkDDQb5uVYLN48k88xSA=;
	b=R2DH6s1RJqFZDXYjEb/yreJzKC5RuOc+Mt8tof3Q41usSUk0slq8IcaNpm0T9qb0rYnVy2
	igntyGhjXyQtrzZyuV/ViSBVRr0u4XycIkXjNZAKDyp97UThcoSTO85a7FBIJbKaqgt+v+
	BZimi4sY//k5PA7+1+28QxjT7r2YcTNDkgpRDhnjacsoa1plaB4nwz7p7Vqbu5RWy9T4XU
	Py+xiiRuV4ss4QQcofFBn8oJyr4MMILUofKcLfUvjY+CzaYwjNuKf7bnWrknLvRGNsG0aX
	LJ2OZ7NDNd3OLuqh9NIl73E0LRPdNNm21lubSr3TviUoLokBDeqSdWPr72ZS7g==
Date: Tue, 5 Nov 2024 10:33:26 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 05/18] net: pse-pd: Add support for PSE
 device index
Message-ID: <20241105103326.0360641d@kmaincent-XPS-13-7390>
In-Reply-To: <46d4b5be-60d3-4949-8eb9-9e8a036cb580@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-5-9559622ee47a@bootlin.com>
	<ZyMjbzK7SJq5nmYz@pengutronix.de>
	<46d4b5be-60d3-4949-8eb9-9e8a036cb580@lunn.ch>
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

On Thu, 31 Oct 2024 22:28:29 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Oct 31, 2024 at 07:27:59AM +0100, Oleksij Rempel wrote:
> > On Wed, Oct 30, 2024 at 05:53:07PM +0100, Kory Maincent wrote:
> >=20
> > ... =20
> > >  /**
> > >   * struct pse_control - a PSE control
> > > @@ -440,18 +441,22 @@ int pse_controller_register(struct
> > > pse_controller_dev *pcdev)=20
> > >  	mutex_init(&pcdev->lock);
> > >  	INIT_LIST_HEAD(&pcdev->pse_control_head);
> > > +	ret =3D ida_alloc_max(&pse_ida, INT_MAX, GFP_KERNEL); =20
> >=20
> > s/INT_MAX/U32_MAX =20
>=20
>  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
>  * or %-ENOSPC if there are no free IDs.
>=20
> static inline int ida_alloc_max(struct ida *ida, unsigned int max, gfp_t =
gfp)
>=20
> We need to be careful here, at least theoretically. Assuming a 32 bit
> system, and you pass it U32_MAX, how does it return values in the
> range S32_MAX..U32_MAX when it also needs to be able to return
> negative numbers as errors?
>=20
> I think the correct value to pass is S32_MAX, because it will always
> fit in a u32, and there is space left for negative values for errors.
>=20
> But this is probably theoretical, no real system should have that many
> controllers.

Indeed you are right we might have issue between S32_MAX and U32_MAX if we =
want
to return errors.
Small question, is S32_MAX better than INT_MAX? Is there a point to limit i=
t to
32 bits?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

