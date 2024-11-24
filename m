Return-Path: <netdev+bounces-146950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79E9D6E0B
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 12:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28230B21059
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34254186E27;
	Sun, 24 Nov 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eWMUMG72"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8E3BB24;
	Sun, 24 Nov 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732448891; cv=none; b=pEITZ5DoUB/7rK+259kQV7qotVvkY2DBnwkpErGSvmC2eO2W+v/dbiiWgqg3O8Ej5AAUdvoYRfZrh7GbeazWyRBSHuheUYxZD62DxHavj5ax5jLTrxwBQBqzL1JOGfNPFW5dTf0i4Yoki9OZYcrMgGaNlMnXffA7n6a3azcOOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732448891; c=relaxed/simple;
	bh=HEkvAW2uXzYYGNQB348wpthueAicu5dMe/S9f8kW4gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWjvGpoPQyKYecawZCMeohqTOOWRrz7aY0EwvakIlHz9GxdSlCUp6mp5RhUFBP2prkS+384ysXjmw/OVYaKzFi8+DMZzN91S79HC4BopXqZ2kt9rC/uHjdQMDiLN6elvSZHNjmH24bdcT/rEMbwq/wKmxS5YoNLyZrTOB9Objn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eWMUMG72; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2549E240003;
	Sun, 24 Nov 2024 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732448880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi1vwQlwjx5nx2feXQ31yCzJSrxxT7L8l/BotDlHXuU=;
	b=eWMUMG72VQ+252L5CR7PQ++DETQ4f/PvArlH0SNYLQL2nhHQqSIeexCqVjuOAnj0wB31Sn
	EuUChFtTxHm4XceLF0hdTsdhK6yNPrgW323KFHAa2+O6EByCaw1v2j9alYv0zsVO2PkiQs
	NysVP6yPeEu6C0mQvpG8sqxGxaXDqhgFo5iIhM9fVNuiT160LfXHFteOxtoc/1owQkI72q
	0z5yQoZEiiiMQvotHQEHjUR1t1o+5wa4mb/bGJ3FDlUufaZlRzWruSHWxEDZFOl4+9GDxa
	qDbRBqKLDhm4lyZt1HgzvEPoor9GQfph1x3ObClGy523JPrWMd94dJOCM3pB+A==
Date: Sun, 24 Nov 2024 12:47:56 +0100
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
Subject: Re: [PATCH RFC net-next v3 03/27] net: pse-pd: Avoid setting max_uA
 in regulator constraints
Message-ID: <20241124124756.2e54d2e8@kmaincent-XPS-13-7390>
In-Reply-To: <Z0F2SVsBOR-EOQJ-@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-3-83299fa6967c@bootlin.com>
	<Z0F2SVsBOR-EOQJ-@pengutronix.de>
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

On Sat, 23 Nov 2024 07:29:29 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Kory,
>=20
> On Thu, Nov 21, 2024 at 03:42:29PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Setting the max_uA constraint in the regulator API imposes a current
> > limit during the regulator registration process. This behavior conflicts
> > with preserving the maximum PI power budget configuration across reboot=
s.
> >=20
> > Instead, compare the desired current limit to MAX_PI_CURRENT in the
> > pse_pi_set_current_limit() function to ensure proper handling of the
> > power budget. =20
>=20
> Not enough coffee :) I still didn't correctly understood the problem.

Don't worry, if you don't understand as a PSE Maintainer no one will. The c=
ause
is the commit message.
=20
> MAX_PI_CURRENT is the hard limit according to the standard, so it is the
> intial limit anyway. Why it is bad to set it on registration? It feels
> still better compared to have no limit on init. Or do i'm missing
> things?

Using constraints.max_uA to set the max current limit will cause regulator =
core
to call the set_current_limit callback when registering a regulator. This c=
all
will be done using MAX_PI_CURRENT (1,92A) limit.

Is see two issues to this:
- There is a chance the power budget of the supply will be not sufficient f=
or
  all the PIs configured to MAX_PI_CURRENT. On that case the power budget of
  the supply is exceeded and the next PI of the PSE power domain can't probe
  with success. It will have -ERANGE error returned from
  devm_regulator_register() call. So the PSE driver can't probe with succes=
s.
- The PI current limit is reset at each boot. The next patch series will ta=
ckle
  permanent configuration feature of the PD692x0. This will conflict as
  we want to keep the PI current limit saved.

Another solution would be to add a no_apply_max_uA_constraint flag.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

