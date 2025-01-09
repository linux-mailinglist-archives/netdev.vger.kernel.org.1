Return-Path: <netdev+bounces-156881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB55A082D4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63EB188B3D3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771772054EF;
	Thu,  9 Jan 2025 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hoKdpzET"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB0A2D;
	Thu,  9 Jan 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736462215; cv=none; b=p3kIyKLDEq0sRedjuq9OvcLGPauRjziqZRRBPyy/35QrrmleoUoegJSL+r9DWwNfanKyR0M7jrVNwLWxNIwKaMI91ZgNsdGSqLhVPorJVbOV1LRtF6uUWXwWk53QjkWE/NaWivLS0ZaBsRyCpZKRcLe9ZWcpkLU6zga5J2GU1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736462215; c=relaxed/simple;
	bh=V7QjGkH9h1BubB5/P3bw6GihXP391rCP0N48jsGWA+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaHzW41fzMWho8fLT49bm0mwOp90MUspffTgpmpRh+GAWVcH0XKN70F+TfQAs563LCKvTO334cYUXJNr++nrkOERqQ3NjnqLeJMjsq9fXzLYx20qSWG00mmidapzEcehPRm4zkr9wa25pleYs+PlcDsjnnLX2sP7LsYW3UG9CtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hoKdpzET; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F643C0003;
	Thu,  9 Jan 2025 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736462210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7QjGkH9h1BubB5/P3bw6GihXP391rCP0N48jsGWA+8=;
	b=hoKdpzETHRdw3/d1zWOBAosjxMUlHlFXAJXFJjqTrptqt8r9tXoGD3VbMup1GWCC1iJlis
	/Md2xk58T63juShIFr/OrZKV/1DNXuP2EQs8WkOy+WCI0K0RPjuXZ84CJRnsAkG10PLSLq
	ZmIMNHZOlhm/JDfXtntNxy79vOYTO7O68qy1k9MLFwBauxKTaC390qCJwYbibUwL7A3h3p
	C496p3QgIGa7S9s2DKaqQ8codka3/5sTndLWGpu/JmyzcG5ZIEa5s9iflP8WMHcN2dLBGx
	zUhr59y7ctxFT8b5LbQscyACFfo2z5sihL4CXWfAO0ZT8FdqK4bmfyDY3IYB1A==
Date: Thu, 9 Jan 2025 23:36:47 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Liam Girdwood
 <lgirdwood@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE
 device index
Message-ID: <20250109233647.7d063fa2@kmaincent-XPS-13-7390>
In-Reply-To: <94386bd6-18b7-4779-a4eb-98e26c90326b@sirena.org.uk>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
	<20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
	<20250109075926.52a699de@kernel.org>
	<20250109170957.1a4bad9c@kmaincent-XPS-13-7390>
	<Z3_415FoqTn_sV87@pengutronix.de>
	<20250109174942.391cbe6a@kmaincent-XPS-13-7390>
	<20250109115141.690c87b8@kernel.org>
	<94386bd6-18b7-4779-a4eb-98e26c90326b@sirena.org.uk>
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

On Thu, 9 Jan 2025 19:59:20 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jan 09, 2025 at 11:51:41AM -0800, Jakub Kicinski wrote:
> > On Thu, 9 Jan 2025 17:49:42 +0100 Kory Maincent wrote: =20
>=20
> > > I think I should only drop patch 11 and 12 from this series which add
> > > something new while the rest is reshuffle or fix code. =20
>=20
> > I mentioned 13 & 14 because I suspected we may need to wait for
> > the maintainers of regulator, and merge 13 in some special way.
> > Looks like Mark merged 13 already, so =F0=9F=A4=B7=EF=B8=8F =20

Yes, Mark is really responsive!
Tomorrow I will send a new version without the regulator patch and the PSE
device index support.

> Well, you were saying that the subdevice structure didn't make sense and
> you wanted to see it dropped for now so given that it's -rc6 and it's
> unlikely that'll get fixed for this release it made sense to just apply
> the regulator bit for now and get myself off these huge threads.
>=20
> There's no direct dependency here so it should be fine to merge the
> networking stuff separately if that does get sorted out.

Thanks Mark for taking the patch!

About the following two patches do you prefer to let them in the future bud=
get
evaluation strategy support net series or should I send them directly in
regulator tree?
https://lore.kernel.org/netdev/20250103-feature_poe_port_prio-v4-17-dc91a3c=
0c187@bootlin.com/
https://lore.kernel.org/netdev/20250103-feature_poe_port_prio-v4-18-dc91a3c=
0c187@bootlin.com/

If I send them in regulator tree do you think it would be doable to have th=
em
accepted before the merge window. I will resend them with the fixes asked by
Krzysztof (convert miniwatt to milliwatt).

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

