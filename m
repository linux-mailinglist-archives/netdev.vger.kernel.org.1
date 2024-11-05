Return-Path: <netdev+bounces-141880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F499BC979
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9714A1C225DB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD951D150C;
	Tue,  5 Nov 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RUiKM27i"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003491D096F;
	Tue,  5 Nov 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799700; cv=none; b=b9nNZzkbACUIoFd9WjGaj/nxLG6nl0QFSFmgHpZWvCSrGVUQmHmuun71G+x9tEFuF/0JLzZeJzrGnI5XXOlXHjFvPcdaBb6A/QloWAlwddFkg5ShozQqOYYGRZlr7gpMcoUjzppuPZnf7e9RkhGQ2bnYEjYMxsq2THNGFxd/3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799700; c=relaxed/simple;
	bh=Bht3mVnw3eoSre2ku/X+CZwcS9IrWEnHjw2SqJO08Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If8+dLkglSSzDcanK83OvejtF3TgOTDSqujKXOMtqDYmXwvaVL/Vev6Ctm61tGWuf49qhKKd9T3lj1JBUHsQrj9nOac4u+Xqz4Oic5cm9LZ6JM6coFwcCHzpMr1BVXL0OzsJqBIl+ymeOoWzqaUgx7cbl5X54SLumtPBdahPjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RUiKM27i; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 560056001C;
	Tue,  5 Nov 2024 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730799696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSlKTSAxySHJjqChqONbCgqJ554fuVdntFyNBbMZcnY=;
	b=RUiKM27ifxsvhKGdHUwUehRrWR/ubOy2tPzHRt2dFcLhK1GRmGMnezUVAwuhdudenDOXnz
	HFSuFXWa8RbceDm9pw12pZX0zUw1HKkIuE8ZY31RYw58CPTf4gpfg3mUbwxcpMJE83a/HD
	3xUKHCl2cx0Zdx3rSA2SnFQdhPf4yb88Pou5aJ5HrcUdvcapsOCQNsqCeOvGTqxAGP9D6T
	cXLPPx9HPHjv2TsxtCVdBHY0SL71UFc+BWZotVxtodQ1L/iBHENd0+LX7ZucKAXjju338n
	fj+WH9Do6VOWnSakoMGopvtGi2XJHJZ1H+1XAwuVVVKxY0XR/wZW64mjrHgmeA==
Date: Tue, 5 Nov 2024 10:41:21 +0100
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
Subject: Re: [PATCH RFC net-next v2 08/18] net: pse-pd: Add support for
 reporting events
Message-ID: <20241105104121.75655186@kmaincent-XPS-13-7390>
In-Reply-To: <1ce06df3-e092-47a8-bec6-8829eeb826bc@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-8-9559622ee47a@bootlin.com>
	<1ce06df3-e092-47a8-bec6-8829eeb826bc@lunn.ch>
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

On Thu, 31 Oct 2024 23:00:48 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static unsigned long pse_to_regulator_notifs(unsigned long notifs)
> > +{
> > +	switch (notifs) {
> > +	case ETHTOOL_C33_PSE_EVENT_OVER_CURRENT:
> > +		return REGULATOR_EVENT_OVER_CURRENT;
> > +	case ETHTOOL_C33_PSE_EVENT_OVER_TEMP:
> > +		return REGULATOR_EVENT_OVER_TEMP;
> > +	}
> > +	return 0;
> > +} =20
>=20
>=20
> https://elixir.bootlin.com/linux/v6.11.5/source/include/uapi/regulator/re=
gulator.h#L36
>=20
>  * NOTE: These events can be OR'ed together when passed into handler.
>=20
> ETHTOOL_C33_PSE_EVENT_OVER_* are also bits which could be OR'ed
> together, so is this function correct?

You are right, thanks for seeing it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

