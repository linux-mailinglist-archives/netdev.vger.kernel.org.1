Return-Path: <netdev+bounces-147466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C109D9AAB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAA8164FED
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C821D63EA;
	Tue, 26 Nov 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I7Zaf7A7"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71921D61A3;
	Tue, 26 Nov 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636355; cv=none; b=cbEYWzfSGswozBy3/W2tM6MnkIz10GQiGkkW523YfDNevd8uuIEBociNkf9/VIhyM2JUGQYTpwaVBqGHCbnHdsGJRwmFqFzyTfUujH07tzjBoX+MYWVXg4bxMfgvCkIgmbc2AKAKcCPNo1Qs/lnMe/gIDEPoWveJBQhkEAz0zAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636355; c=relaxed/simple;
	bh=t0ByC8HXuqc41ac70t1b+57WZFJooCSmNwXA+TyXrsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn15qo85a/m2Fl8Bc93DOYQ5jSdQ9cCRXYmr7+YYGnenTr/8LCZ52xRMkhvkx3qWpzPhfHR+uMPYyG0J5OPvdsobWFkddkUeaktBz5dsresXKnbQDc6j6g9CdjM0axmwdIOOMsjgCj14CiGwititms5G7MqYhwGE22MXKxB2Qkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I7Zaf7A7; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EB49240004;
	Tue, 26 Nov 2024 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732636351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32bN/U8RBJm0I9OXWdazVO9fxAeU189cDI3fFLR4z+A=;
	b=I7Zaf7A7XX7rSAs4/EmM63eKsNcLTF8Rcp3nZ9PM//JcGn4iBZV6OsKTgcA1y5WcpWp678
	bFKJU09NuevECzGA8s9R5IRkELU19V6VRn033JsYwJmk/HOXNiCl7vMWVmwqqy+XBoSfjO
	UgkqExHZiz/VKwLcSb/rtW9HlDLyK+HnxUDOycNVBgaHN4kfpWItGZf/qI6FSEQipmcDPl
	JYLZl8wgF2CBOzI2l0EfLWlwZbpJE2jXoMWThYPSoZWASkRzS0CXTDxg94MSO72KMjgSai
	+DbdJXbKd1EDWnoRElA+NIyF+1mfQBiwlzG4XSS3t3bmHb61BVjfG1UxL8kNfA==
Date: Tue, 26 Nov 2024 16:52:28 +0100
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
Message-ID: <20241126165228.4b113abb@kmaincent-XPS-13-7390>
In-Reply-To: <20241126163155.4b7a444f@kmaincent-XPS-13-7390>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
	<Z0WJAzkgq4Qr-xLU@pengutronix.de>
	<20241126163155.4b7a444f@kmaincent-XPS-13-7390>
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

On Tue, 26 Nov 2024 16:31:55 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Hello Oleksij,
>=20
> Thanks for your quick reviews!
>=20
> On Tue, 26 Nov 2024 09:38:27 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>=20
> > > +int pse_ethtool_set_prio_mode(struct pse_control *psec,
> > > +			      struct netlink_ext_ack *extack,
> > > +			      u32 prio_mode)
> > > +{
> > > +	struct pse_controller_dev *pcdev =3D psec->pcdev;
> > > +	const struct pse_controller_ops *ops;
> > > +	int ret =3D 0, i;
> > > +
> > > +	if (!(prio_mode & pcdev->port_prio_supp_modes)) {
> > > +		NL_SET_ERR_MSG(extack, "priority mode not supported");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	if (!pcdev->pi[psec->id].pw_d) {
> > > +		NL_SET_ERR_MSG(extack, "no power domain attached");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	/* ETHTOOL_PSE_PORT_PRIO_DISABLED can't be ORed with another mode
> > > */
> > > +	if (prio_mode & ETHTOOL_PSE_PORT_PRIO_DISABLED &&
> > > +	    prio_mode & ~ETHTOOL_PSE_PORT_PRIO_DISABLED) {
> > > +		NL_SET_ERR_MSG(extack,
> > > +			       "port priority can't be enabled and
> > > disabled simultaneously");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ops =3D psec->pcdev->ops;
> > > +
> > > +	/* We don't want priority mode change in the middle of an
> > > +	 * enable/disable call
> > > +	 */
> > > +	mutex_lock(&pcdev->lock);
> > > +	pcdev->pi[psec->id].pw_d->port_prio_mode =3D prio_mode;   =20
> >=20
> > In proposed implementation we have can set policies per port, but it
> > will affect complete domain. This is not good. It feels like a separate
> > challenge with extra discussion and work. I would recommend not to
> > implement policy setting right now.
> >=20
> > If you will decide to implement setting of policies anyway, then we need
> > to discuss the interface.
> > - If the policy should be done per domain, then we will need a separate
> >   interface to interact with domains.
> >   Pro: seems to be easier to implement.
> > - If we will go with policy per port, wich would make sense too, then
> >   some rework of this patch is needed.
> >   Pro: can combine best of both strategies: set ports with wide load
> >   range to static strategy and use dynamic strategy on other ports.

We already talked about it but a policies per port seems irrelevant to me.
https://lore.kernel.org/netdev/ZySR75i3BEzNbjnv@pengutronix.de/
How do we compare the priority value of ports that use different budget
strategy? How do we manage in the same power domain two ports with
different budget strategies or disconnection policies?

We indeed may need a separate interface to configure the PSE power domain
budget strategies and disconnection policies.

I think not being able to set the budget evaluation strategy is not relevant
for now as we don't have PSE which could support both, but being able to
set the disconnection policies may be relevant.
If we don't add this support to this series how do we decide which is the
default disconnection policy supported?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

