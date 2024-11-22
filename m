Return-Path: <netdev+bounces-146777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F869D5B33
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 09:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A9BB22448
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A83B18C336;
	Fri, 22 Nov 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l/6sXL+h"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7718C03C;
	Fri, 22 Nov 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264943; cv=none; b=HwsvWH8TgoT94DrlMfOASiF7RmzFtK7GQmhbYG1kolzC5NRqwUUZKevQ5QfxMedgncrIWwlQjfHj0IkXQLZVQKLGuzxWGdjhghS2F1hqKALC2NW0SUAuCC13kFhcd6U7QOJhg2AxV9py8dnWGFT4WjPBeZDlQmkwqSmU6H+9OAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264943; c=relaxed/simple;
	bh=c1Ts82AiyusAlYWb8emaHpqALdupvrkvlzytzMzD5Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvWKXEfvaoI0NZGasREMbMcQnNnowzeF11xH0VsRFYnj60Fum6dFq+EtjQr6iphpV17zW3AAI9Jgd25PbegOJVgYqHoVBLKVZuCalacxHySNvBVDdoiEPpr0FymemtEL+0QHC3fXdiXQHWeABrYNPrE1U619PYHH5krrIZEX3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l/6sXL+h; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94C4820009;
	Fri, 22 Nov 2024 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732264936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eBNAIQube8A2Bu+Kj23Enb+yOdyC1OAUgr86oyx5kY=;
	b=l/6sXL+h2vPwryDFM4PjAURn7ho/eOFEQOR/ch1FCknNwiyLugAlL6ogwsSvFT1mKxWaln
	hmcG3Gi00vdBLIneggouZsxZ4pLOZ/sPT4m8bdVvIlVWGSR5+8gVB135eb1mXtXq9Pafvp
	XlzxeUgHW/8ztHwoip08hYvf+qRegQkQCZjR4iRGU96h4TpmH8DpmkMJ1OzF8LMVDyXmfJ
	CkOgXfi9KG8HDjPi53Eq/THEf+iu9SR+LgJU0TNsgS4XtSuVQ1saNC0hyHqYeS6KfiU3h7
	BIWRBYYE5iPLSeZbLTwAswHYOtIX98uOH9+bn0tWJevxHd6cIC6YEBfzVkk07Q==
Date: Fri, 22 Nov 2024 09:42:10 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 25/27] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Message-ID: <20241122094210.5e643c1d@kmaincent-XPS-13-7390>
In-Reply-To: <32695cf7-01d4-4180-b7f0-230ad8a0e1a4@kernel.org>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-25-83299fa6967c@bootlin.com>
	<32695cf7-01d4-4180-b7f0-230ad8a0e1a4@kernel.org>
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

Hello Krzysztof,

On Fri, 22 Nov 2024 07:58:26 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 21/11/2024 15:42, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This patch adds the regulator supply parameter of the managers.
> > It updates also the example as the regulator supply of the PSE PIs
> > should be the managers itself and not an external regulator.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  =20
>=20
>=20
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>=20
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>=20
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>=20
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
>=20
> ... unless you do not expect review.

Indeed I didn't expected binding reviews on this series that's why I did no=
t add
you and devicetree mailing list to the CC. I would like to confirm the core=
 PSE
design choices before that.
Maybe I should have notify it somewhere to avoid you these emails, sorry.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

