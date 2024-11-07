Return-Path: <netdev+bounces-142743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244649C02D2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7F21F22052
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5EB1DBB37;
	Thu,  7 Nov 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oZX0T0Qe"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93CB1D932F;
	Thu,  7 Nov 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976463; cv=none; b=B0l6ylNqlF43SKJ5faykbDw+UtMJN8y02grelya6jRRQf+Ki5rg99hDKsNII6/7OHlmX86AoFneQCD8QOESnQaiv4S1TOuV8W0DTU8RyXUNeMNtkv5TR6rQ+YXhB8BP/KB7Ez9SvAMd1IvNC+81G/7XJ3O8m/VjWlhFOujgkMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976463; c=relaxed/simple;
	bh=Cnxa1tCsanHSGqjuAhH8pqnLSS+wZUMsDLPxNRnuZuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uu9RW2VdxD3OMrioR9+oDPcdX7ih0ucW8xhM/BxdT8jAg3MYG0AOm74NWFESCQNUSF2SkQmpVQMUQH+OE2qv4EG3VzJ2D/pY5IaWlWQ8uOlVQ5eRIbBNzAvPugN+6+eQmsh4ZrnihAXRuxTGC2s1lk3+wQg5h4dSxhLAk40q3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oZX0T0Qe; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E23E26000F;
	Thu,  7 Nov 2024 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730976452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKJpWykVcJd+0xdKpQJ/zkwyZG5GBmfR2RA2zeLo5LY=;
	b=oZX0T0QerH27DR9/wz5lIe41T96lKQ/K6vZ4NGgqEuMsPcTAzifsUH7oHJhr/dvxjLc50A
	FklC5ob7oYdp8+royJTRYh2t85g242pruCaT7XhP+tC+oZZTm0tT8eFr7qGNk4f47xAJ2V
	87NFSgTVMdoHFdAqH32qrMFQIr5G676SEFVyGn8hfUiajSnFh9yW2xLsVP9wCovIh/DwCX
	7zgmJDMHILGSU0K0r9IfvWEqp4KpYdplWni/JEEFhROrSzgWTAgRs7q4+1yrfF58f23bwZ
	4/R/JaQmac23d3wKANqZEMwOp7RgYw3fEKMl/+mBYyiHi2DD4GQaX0CjBZsc5Q==
Date: Thu, 7 Nov 2024 11:47:28 +0100
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
Subject: Re: [PATCH RFC net-next v2 03/18] net: pse-pd: tps23881: Use
 helpers to calculate bit offset for a channel
Message-ID: <20241107114728.109051bc@kmaincent-XPS-13-7390>
In-Reply-To: <0e9ecb5a-3a6a-4b99-8177-1532134e3e25@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-3-9559622ee47a@bootlin.com>
	<0e9ecb5a-3a6a-4b99-8177-1532134e3e25@lunn.ch>
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

On Thu, 31 Oct 2024 22:11:18 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +	val =3D tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
> > +		val =3D tps23881_set_val(val, chan, 0, BIT(chan % 4),
> > +				       BIT(chan % 4));
> > +	val =3D tps23881_set_val(ret, chan, 4, BIT(chan % 4), BIT(chan % 4));
> > +		val =3D tps23881_set_val(val, chan, 4, BIT(chan % 4),
> > +				       BIT(chan % 4));
> > +	val =3D tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
> > +		val =3D tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
> > +	val =3D tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
> > +	val =3D tps23881_calc_val(ret, chan, 4, BIT(chan % 4));
> > +		val =3D tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
> > +		val =3D tps23881_calc_val(ret, chan, 4, BIT(chan % 4)); =20
>=20
> It looks like all the callers of this helper pass BIT(chan % 4) as the
> last parameter. Maybe move that into the helper as well?

There is different cases in the patch 4 of the series.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

