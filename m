Return-Path: <netdev+bounces-147461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE569D9A71
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEBCB22326
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842AF1D63CB;
	Tue, 26 Nov 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PFMT6Skn"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4741917E6;
	Tue, 26 Nov 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635123; cv=none; b=my2bmOI8fYa4mOv3k9Fp0dOkze402s0t6OQgMAbiSp/OFvScJvxW7uSlPpCPGA7OFIpYrAGACtKeUj768xiKAi2GJ+0LZyIvCHvHEivZXhE3y+EXzMckBwVgZtezWQ8EbTWlBc0Zw5lnSTEs23WK5HXE0/BnJUY9kOTToww+zp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635123; c=relaxed/simple;
	bh=bWWIwNB3omMtAB0EEKWIcFPkL0+jNsIwsilo00ia6nM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDu0eUeAJfUR0vRKc9BTC6pXhlM8u+NVToBImSSTTng0gyumUoBbGbDDDgoWs1C7qBIW5zpC+9H+R+DhQG8opd64WlXJ7ZY1/F4EXZY7DNlsoAc/3JkXDbxbxJXT+EcenKFBTs2UDZsE0ZG4s0nB01r0wOxKgWW4rO/oZwksb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PFMT6Skn; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5D4F240009;
	Tue, 26 Nov 2024 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732635118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efUBgvOu+GXnqy4wXRdjHPkVmMen40IYrQW2Xg/1YGA=;
	b=PFMT6SkntixfHotv4sVyEgY0TF9FJs6Sm21h+nPD7gFktloqhRSasX8peNrqFsd6+tIEzQ
	Z2i6u1HKqj2PCzRvCrZYcHICmiraS/eYCRjTAYJYvJdgGmsbdoO+M+H7d7nnyd7Kf08nCm
	9N8X1Oh4R1eqwikQaQ5e+losVph0GHRYm/yJyYnR+dGsO+fb+HOSZSe9Ykph0X9JVlM27x
	Ih8sYWvCNw3ynA06Rnji0LysQ/EGl9RlR0OyLUP1bwpiSr/7CF+aj8b68PJWnI3QZaKhlp
	pwvREdHQbJ5LE0Q2ioSkvP6tElrAUn6m2NZLcPMkuIZ8XSFb7KUJ09K2gbcgHA==
Date: Tue, 26 Nov 2024 16:31:55 +0100
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
Message-ID: <20241126163155.4b7a444f@kmaincent-XPS-13-7390>
In-Reply-To: <Z0WJAzkgq4Qr-xLU@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
	<Z0WJAzkgq4Qr-xLU@pengutronix.de>
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

Hello Oleksij,

Thanks for your quick reviews!

On Tue, 26 Nov 2024 09:38:27 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > +int pse_ethtool_set_prio_mode(struct pse_control *psec,
> > +			      struct netlink_ext_ack *extack,
> > +			      u32 prio_mode)
> > +{
> > +	struct pse_controller_dev *pcdev =3D psec->pcdev;
> > +	const struct pse_controller_ops *ops;
> > +	int ret =3D 0, i;
> > +
> > +	if (!(prio_mode & pcdev->port_prio_supp_modes)) {
> > +		NL_SET_ERR_MSG(extack, "priority mode not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (!pcdev->pi[psec->id].pw_d) {
> > +		NL_SET_ERR_MSG(extack, "no power domain attached");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	/* ETHTOOL_PSE_PORT_PRIO_DISABLED can't be ORed with another mode
> > */
> > +	if (prio_mode & ETHTOOL_PSE_PORT_PRIO_DISABLED &&
> > +	    prio_mode & ~ETHTOOL_PSE_PORT_PRIO_DISABLED) {
> > +		NL_SET_ERR_MSG(extack,
> > +			       "port priority can't be enabled and
> > disabled simultaneously");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ops =3D psec->pcdev->ops;
> > +
> > +	/* We don't want priority mode change in the middle of an
> > +	 * enable/disable call
> > +	 */
> > +	mutex_lock(&pcdev->lock);
> > +	pcdev->pi[psec->id].pw_d->port_prio_mode =3D prio_mode; =20
>=20
> In proposed implementation we have can set policies per port, but it
> will affect complete domain. This is not good. It feels like a separate
> challenge with extra discussion and work. I would recommend not to
> implement policy setting right now.
>=20
> If you will decide to implement setting of policies anyway, then we need
> to discuss the interface.
> - If the policy should be done per domain, then we will need a separate
>   interface to interact with domains.
>   Pro: seems to be easier to implement.
> - If we will go with policy per port, wich would make sense too, then
>   some rework of this patch is needed.
>   Pro: can combine best of both strategies: set ports with wide load
>   range to static strategy and use dynamic strategy on other ports.
>=20
> Right now we do not have software implementation for dynamic mode,
> implementing configuration of the policies from user space can be
> implemented later. It is enough to provide information about what
> hard coded policy is currently used.

There is no PSE that support static and dynamic mode indeed but the aim was=
 to
be able to disable the budget evaluation strategy.

In fact we could have static strategy with a disconnection policy that do n=
ot
power a newly connected PD if we become over budget. This behavior would be
something similar to no budget evaluation strategy.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

