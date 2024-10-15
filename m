Return-Path: <netdev+bounces-135524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9D99E2FA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56288B20E7A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C31DF261;
	Tue, 15 Oct 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dKQZGnHS"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE817DFEC;
	Tue, 15 Oct 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985439; cv=none; b=GxjJgFRazkv/iTVsnZC+O8V8Z5C03w4WX1GWeYfgMHKeZEue8dT96BW5I3lXpZKTtAoShwYQ7r7W30ARudUsnWXRl2s4xtP5WS1O/fCkRCSbG4Y+hcYR+s5N6mWm3kisYQ41MPtCo3mLRmwkuTAiJII9DMNvaVVeOu9kcLPn8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985439; c=relaxed/simple;
	bh=q3RvenNaWvWuufa2cPIodWwg2GSLjiri4xd0ZGajE+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXbpfJnJwwoYT3NNLW7HuQCFhy9HydzkZu03o8z7Q6xYSR7Wz5hSrxAMeB2XVU0ApykjYkiySSzzcW934RTYXeiJhyT6wCm/f70gtI19/08vMULmfdqIyA/CYQcm/WmrBhgkaPxdkW0+cuvliNWnLBUFyD4nWXFngIXsv/kE+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dKQZGnHS; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56FF5240008;
	Tue, 15 Oct 2024 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728985434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrVM59r+V4LCvVqdtekzbKy/TjFxpCMqo3i+vuDCG1E=;
	b=dKQZGnHSLfKXrMf9buiraUqtUF19RB5MQowCYWhXjuWovkx0HJDIKCWijc4eOKgwyPlTrE
	01Ri5PvUarPZIwVw6o9a4td7OZ7pbhrwSY+m7p/vyhlSWIAtNGcq5k2vZtbZ9VrRwNvAAZ
	eYKXS1twFnPmgDAnoSDen6YRBLxmR8xiZHArV3u6abLFY0hK8jqbR94l7IDra7nBdcHbqA
	dL9WScmhp7J6aU8bjSR72j/r6fBKjO3a6zA+jJ5g2n3u42Igkr30rEYkwR6Xhi/u/I+Zyn
	MwQiBY82dzlho7WUED09eXqYAF1s8rqgSW2TmxAvagZAO3Ge15frQ1RU5qh7Kw==
Date: Tue, 15 Oct 2024 11:43:52 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kyle Swenson <kyle.swenson@est.tech>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Dent Project
 <dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>
Subject: Re: [PATCH net-next 00/12] Add support for PSE port priority
Message-ID: <20241015114352.2034b84a@kmaincent-XPS-13-7390>
In-Reply-To: <ZwdpQRRGst1Z0eQE@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<ZwaLDW6sKcytVhYX@p620.local.tld>
	<20241009170400.3988b2ac@kmaincent-XPS-13-7390>
	<ZwbAYyciOcjt7q3e@est-xps15>
	<ZwdpQRRGst1Z0eQE@pengutronix.de>
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

Hello,

On Thu, 10 Oct 2024 07:42:25 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > The condition where we've exceeded our system-level power
> > budget is a little different, in that it causes a port to be shutdown
> > despite that port not exceeding it's class power limit.  This condition
> > is the case I'm concerned we're solving in this series, and solving it
> > for the PD692xx case only, and it's based off dynamic power consumption.
> >=20
> > So I guess I'm suggesting that we take the power budgeting concept out
> > of the PSE drivers, and put it into software (either kernel, userspace)
> > instead of the PSE hardware. =20
> >  =20
> > >   I can't find global power budget concept for the TPS23881.  =20
> >=20
> > This is because this idea doesn't exist on the TPS2388x. =20
> >  =20
> > >   I could't test this case because I don't have enough load. In fact,
> > > maybe by setting the PD692x0 power bank limit low it could work. =20
> >=20
> > Hopefully this helps clarify. =20
>=20
>=20
> Thank you for your detailed insights. Before we dive deeper into policies=
 and
> implementations, I=E2=80=99d like to clarify an important point to avoid =
confusion
> later. When comparing different PSE components, it's crucial to note that=
 the
> Microchip PD692x0 operates in two distinct categories:
> 1. PoE controller (PD692x0)
> 2. PoE manager (PD6920x)
>=20
> Comparing the PoE controller (PD692x0) with TPS2388x or LTC4266 isn't ent=
irely
> fair, as TPS2388x and LTC4266 are more comparable to the PoE manager
> (PD6920x). The functionalities provided by the PoE controller (PD692x0) a=
re
> things we would need to implement ourselves on the software stack (kernel=
 or
> userspace). The budget heuristic that is implemented in the PD692x0's
> firmware is absent in TPS2388x and LTC4266.
>=20
> Policy Variants and Implementation
>=20
> In cases where we are discussing prioritization, we are fundamentally tal=
king
> about over-provisioning. This typically means that while a device adverti=
ses a
> certain maximum per-port power capacity (e.g., 95W), the total system pow=
er
> budget (e.g., 300W) is insufficient to supply maximum power to all ports
> simultaneously. This is often due to various system limitations, and if t=
here
> were no power limits, prioritization wouldn't be necessary.
>=20
> The challenge then becomes how to squeeze more Powered Devices (PDs) onto=
 one
> PSE system. Here are two methods for over-provisioning:
>=20
> 1. Static Method:
> =20
>    This method involves distributing power based on PD classification. It=
=E2=80=99s
>    straightforward and stable, with the software (probably within the PSE
>    framework) keeping track of the budget and subtracting the power reque=
sted
> by each PD=E2=80=99s class.=20
> =20
>    Advantages: Every PD gets its promised power at any time, which guaran=
tees
>    reliability.=20
>=20
>    Disadvantages: PD classification steps are large, meaning devices requ=
est
>    much more power than they actually need. As a result, the power supply=
 may
>    only operate at, say, 50% capacity, which is inefficient and wastes mo=
ney.
>=20
> 2. Dynamic Method: =20
>=20
>    To address the inefficiencies of the static method, vendors like Micro=
chip
>    have introduced dynamic power budgeting, as seen in the PD692x0 firmwa=
re.
>    This method monitors the current consumption per port and subtracts it=
 from
>    the available power budget. When the budget is exceeded, lower-priority
>    ports are shut down. =20
>=20
>    Advantages: This method optimizes resource utilization, saving costs.
>=20
>    Disadvantages: Low-priority devices may experience instability. A poss=
ible
>    improvement could involve using LLDP protocols to dynamically configure
>    power limits per port, thus allowing us to reduce power on over-consum=
ing
>    ports rather than shutting them down entirely.

Indeed we will have only static method for PSE controllers not supporting s=
ystem
power budget management like the TPS2388x or LTC426.
Both method could be supported for "smart" PSE controller like PD692x0.

Let's begin with the static method implementation in the PSE framework for =
now.
It will need the power domain notion you have talked about.

> Recommendations for Software Handling
>=20
> Both methods have their pros and cons. Since the dynamic method is not al=
ways
> desirable, and if there's no way to disable it in the PD692x0's firmware,=
 one
> potential workaround could be handling the budget in software and dynamic=
ally
> setting per-port limits. For instance, with a total budget of 300W and un=
used
> ports, we could initially set 95W limits per port. As high-priority PDs (=
e.g.,
> three 95W devices) are powered, we could dynamically reduce the power lim=
it on
> the remaining ports to 15W, ensuring that no device exceeds that
> classification threshold.
>=20
> This is just one idea, and there are likely other policy variants we could
> explore. Importantly, I believe these heuristics don=E2=80=99t belong in =
the kernel
> itself. Instead, the kernel should simply provide the necessary interface=
s,
> leaving the policy implementation to userspace management software. At le=
ast
> this is a lesson learned from Thermal Management talk at LPC :D

I think the kernel is only missing the PSE notification events to be ready =
to
leave the port priority policy to the userspace.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

