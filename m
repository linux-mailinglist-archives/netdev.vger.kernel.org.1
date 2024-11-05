Return-Path: <netdev+bounces-141916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD3B9BCA3E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDDF1C22218
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51C1D2B22;
	Tue,  5 Nov 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yba7nZWr"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B21D2B0F;
	Tue,  5 Nov 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802023; cv=none; b=DwWfZfSAuN7nSTo5aIACEOjbbTnOt65AYzTjC+Fe4V4GnTUvBaPAEZzC5fGa/TyetCgCXH9hMpDFyWsUXCdETf71LY66JPqexspfzGV4ZisSyCiZJhIcgcMMoe+oRAy51gWWYNnmggVXabqoe9fkboBZo4um6baVxrzIgfOBrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802023; c=relaxed/simple;
	bh=v3ndVqHP3JRvh4yNpNPFvc9eMbj704RDjLO3v5uk7+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e26rrBfzB6B6HiQp28RWFiuk03P/dTcHZQmr+Fb+4t/doe1R81lafrOmn/dfEBnkQbHr62Y0o8KXfJ03X3jujXro66/x0hUa5cao8Yqq39AsvaBwW3RCCVbwE4cwrd3EigW6vGN5dlIXIFv/EU677muNfM5nd/uI8mrj41JpX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yba7nZWr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3360540006;
	Tue,  5 Nov 2024 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730802012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frgUE9MhZvamkR8/ewj/FH/e6YcRGcG2QNQN+94jcNI=;
	b=Yba7nZWr2CAkTBIK7Mj2OKyXuhW8Vz19vTFCdmac8rpbineGSAFFAtemZixk7v1lofDUVW
	luBANgbVN0srjxsnSOZk7Q40+m6qUWTLnzyCTFhG9+TRKyP0isbXXDHCKq+4zN06GyCBK+
	ukmpXaBubgFe/Gfuuns8mYFAiWNKxzisXVyZI7HbFavAJcVmM+B7/Kw+8tKXNJZEMW1lnP
	uXZ4O9NKC6LTV64+z3m7H6bBg7NVGUn9WqvOGe5M8lPlqJR1/ii2o9FJLjLETwoydNQXe5
	icwpNbRbw7nQwZQSQBhp2raay6/zXxorSgG7rlAnLUq0dm/2j5gH+O5jTIrtYw==
Date: Tue, 5 Nov 2024 11:20:10 +0100
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
Subject: Re: [PATCH RFC net-next v2 15/18] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <20241105112010.17d6f40b@kmaincent-XPS-13-7390>
In-Reply-To: <ZySsCuOvSnVZnIwq@pengutronix.de>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
	<ZyMpkJRHZWYsszh2@pengutronix.de>
	<20241031121104.6f7d669c@kmaincent-XPS-13-7390>
	<ZySR75i3BEzNbjnv@pengutronix.de>
	<ZySsCuOvSnVZnIwq@pengutronix.de>
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

On Fri, 1 Nov 2024 11:23:06 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Fri, Nov 01, 2024 at 09:31:43AM +0100, Oleksij Rempel wrote:
> > On Thu, Oct 31, 2024 at 12:11:04PM +0100, Kory Maincent wrote: =20
> > > On Thu, 31 Oct 2024 07:54:08 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >  =20
>  [...] =20
>  [...] =20
> > >=20
> > > Ack. So we assume PoDL could have the same interruption events.
> > >  =20
>  [...] =20
> >=20
> > After thinking about it more overnight, I wanted to revisit the idea of
> > having a priority strategy per port. Right now, if one port is set to
> > static or dynamic mode, all disabled ports seem to have to follow it
> > somehow too. This makes it feel like we should have a strategy for the
> > whole power domain, not just for each port.
> >=20
> > I'm having trouble imagining how a per-port priority strategy would wor=
k in
> > this setup.

Indeed you are right. I was first thinking of using the same port priority =
for
all the ports of a PSE but it seems indeed better to have it by Power domai=
n.

> > Another point that came to mind is that we might have two different
> > components here, and we need to keep these two parts separate in follow=
-up
> > discussions:
> >=20
> > - **Budget Evaluation Strategy**: The static approach seems
> > straightforward=E2=80=94if a class requests more than available, approp=
riate
> > actions are taken. However, the dynamic approach has more complexity, s=
uch
> > as determining the threshold, how long violations can be tolerated, and
> > whether a safety margin should be maintained before exceeding maximum l=
oad.
> >=20
> > - **Disconnection Policy**: Once a budget violation is detected, this
> > decides how to react, like which ports should be disconnected and in wh=
at
> > order.
> >=20
> > Would it make more sense to have a unified strategy for power domains,
> > where we apply the same budget evaluation mode (static or dynamic) and
> > disconnection policy to all ports in that domain? This could make the
> > configuration simpler and the power management more predictable. =20

Yes, these policies and the port priority mode should be per power domains.=
=20

> Except of user reports, do we have documented confirmation about dynamic
> Budget Evaluation Strategy in PD692x0 firmware?
>=20
> Do this configuration bits are what I called Budget Evaluation Strategy?
> Version 3.55:
> Bits [3..0]=E2=80=94BT port PM mode
> 0x0: The port power that is used for power management purposes is
>      dynamic (Iport x Vmain).

Yes it seems so. I can't find any more configurations on the budget evaluat=
ion
strategy than the power limit.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

