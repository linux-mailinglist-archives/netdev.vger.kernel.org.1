Return-Path: <netdev+bounces-146690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F09D5023
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 16:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24261B26BF5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043D3183CA2;
	Thu, 21 Nov 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IkQk+h08"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8AB15D5C3;
	Thu, 21 Nov 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204311; cv=none; b=jZvuC5lLozLzvYEEqu14yHRoGx7O1TFCV2ofdNcVykV3Czy5qxSuGEtM10URQGiXJtWuQDRNElla+p/Ccf7gc5FtuFgemH2+EIyROmPcn7o4eC8wbw7yw1CUhhwFRy4Tus0vBbFjxhD6F/Ep3KlZmJO4+PpMUfERVxJgdsU6Ioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204311; c=relaxed/simple;
	bh=X7hwPZmjY8q8t6ar3X/nRv/1vY7FPM9xlv+jJsMT4L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyXKrZ+1ZP94I4JZn2AlOEm+jq/BdJBPYlK3VdmOSIxFWKionM3QhFusOzyELTxa1eeVb+W25ki2UuFNih34vM55o1kRfA9ontjoOlUK9DdFRiNuTv83otu7l8mOE70JFCNdKSLhuZhLyD6DOvky3WMrRJvMT6AVfev4FArmiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IkQk+h08; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 16AE2C351D;
	Thu, 21 Nov 2024 15:27:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4498CE0015;
	Thu, 21 Nov 2024 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732202864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vNUEM2nqa5ru8I3224DdW8toFKm1983QOZjCOpdhak=;
	b=IkQk+h08kyzyl0ixQitvGKYANR/xMCGTYLxz+REOBqQ2sHLSvUez5TvQC8OF9DmBr2MHXp
	liDAmVLJzuMzHMGk7B/aD8IhuMo2Qy859j28+aN0UyuBZepcKG7X65GSToOn8Hksg/NHy8
	3TCmAmr76JWvf0ym9NkKxgatvqCq4CnYLKiCjCf14pIKyE0GketAiOH3CHCtt1m3PsKoE5
	K7OkzjtQMjXPVtYthRtTdDifYI/PvOfzQRYULXMQMNGC8/4sls67l/2oNREMiTckwx1lwa
	4py66em/riyMwXy4OOo7+eEygZZGNzaRVzYOC6llfdg7B+2eWTOTgVrmF9coAg==
Date: Thu, 21 Nov 2024 16:27:39 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 17/27] regulator: dt-bindings: Add
 regulator-power-budget property
Message-ID: <20241121162739.6c566d85@kmaincent-XPS-13-7390>
In-Reply-To: <9b5c62aa-fc01-4391-9fab-219889fa0cf6@sirena.org.uk>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-17-83299fa6967c@bootlin.com>
	<9b5c62aa-fc01-4391-9fab-219889fa0cf6@sirena.org.uk>
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

On Thu, 21 Nov 2024 14:58:06 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Nov 21, 2024 at 03:42:43PM +0100, Kory Maincent wrote:
> >    regulator-input-current-limit-microamp:
> >      description: maximum input current regulator allows
> > =20
> > +  regulator-power-budget:
> > +    description: power budget of the regulator in mW
> > + =20
>=20
> Properties are supposed to include the unit in the name.

Oh ok, thanks!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

