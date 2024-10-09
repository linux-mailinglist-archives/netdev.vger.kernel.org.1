Return-Path: <netdev+bounces-133801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0999714C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E541C223D3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A671E47D6;
	Wed,  9 Oct 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bXhiwuYf"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2081A070D;
	Wed,  9 Oct 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490658; cv=none; b=i9LWCf5vgQVrugddiJktvAnCV2/hTwo+ch8iFq1wbp13jzpVjO6qtpMnyaGIz9qXUpLyK1igjvAudfA7HcfvZdST1cnhu+DP1aoImEqzUjvyCLDLZwisaUC25wjVyOLZOFMUimm5qfW3gkwcmY8os3FNtfqGyUbuxZbpS/X98uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490658; c=relaxed/simple;
	bh=KARoP1r9P4E8BDNACruU0r9q8IrSkct1shMbzcayT1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHMn/JxOLxSL51QsvEf/5ulGECsaUcGMAy+dFpi3+rtr06Qu1XKZDU2WzT+OTTJeishxZ0knqv59cxxDu9wcCf9avZ06mYH7uWhWhvH9ReXl6xpRAuS/DzJVSL6lfUS925qAROEd6uq4EeJalKrLQiHykd7KDnR0HZ2rHoOHp4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bXhiwuYf; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0A9440003;
	Wed,  9 Oct 2024 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728490648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvg1u7XmoQ2cLHKggXLRQHDXFMduqdF43sXHLjurawU=;
	b=bXhiwuYfnC6VbQHd/shJX8Dl0FA4SkdmwMT6aVTsTf77jGa48C6Szcq+wp3pgIzL4Q1RL9
	GLLqrki9UWaQgm5pnXMNr5icPBXADknvfVtyrsU/kSFPao1rQqdAcR8WhKO7mA/Sq0FNeP
	Ftl+Bqk1Hs7/Sn6F5MP17Da5rC6tMij/K/0Q2bVCNxSBQ4nfuriGv5hanFdPWpvinkWX9b
	UbqKourjPlK1chMhaiUE61XPzAPRfk3W5rAPVZkVse75vmu8njTOGw7itHZmIQHnf8C6gQ
	fg+SY8k2hAMLBxiFjrnfgyxveJodVGlVyVB/OQH7f9SA5gP0+ia8UNCKN2zTYQ==
Date: Wed, 9 Oct 2024 18:17:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 04/12] net: pse-pd: tps23881: Add support for
 power limit and measurement features
Message-ID: <20241009181725.47ff98b8@kmaincent-XPS-13-7390>
In-Reply-To: <ZwaeRL9z310dBBlh@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-4-787054f74ed5@bootlin.com>
	<ZwYOboTdMppaZVmX@pengutronix.de>
	<20241009110501.5f776c9b@kmaincent-XPS-13-7390>
	<ZwaeRL9z310dBBlh@pengutronix.de>
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

On Wed, 9 Oct 2024 17:16:20 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > > This is a common pattern in this driver, we read and write two regist=
ers
> > > in one run and then calculate bit offset for the channel, can you ple=
ase
> > > move it in to separate function. This can be done in a separate patch=
 if
> > > you like. =20
> >=20
> > The pattern is common but the operations are always different so I didn=
't
> > found a clean way of doing it.
> > Here is a listing of it:
> > 	if (chan < 4)
> > 		class =3D ret >> 4;
> > 	else
> > 		class =3D ret >> 12;
> >=20
> > 	if (chan < 4)
> > 		val =3D (ret & 0xff00) | pol;
> > 	else
> > 		val =3D (ret & 0xff) | (pol << 8); =20
> >=20
> >         if (chan < 4)
> > val =3D (u16)(ret | BIT(chan));                                  =20
> >         else
> > val =3D (u16)(ret | BIT(chan + 4));
> >=20
> > 	if (chan < 4)
> > 		mW =3D (ret & 0xff) * TPS23881_MW_STEP;
> > 	else
> > 		mW =3D (ret >> 8) * TPS23881_MW_STEP;
> >=20
> >=20
> > Any idea?
> >  =20
>=20
> something like this:

Oh thanks, you rock!!
Indeed this should work, thanks for sorting this out.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

