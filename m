Return-Path: <netdev+bounces-140683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623989B7965
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AAC1C21ADF
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD619AA6B;
	Thu, 31 Oct 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZxbYVDg0"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381E199938;
	Thu, 31 Oct 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373073; cv=none; b=HkpkvUPMuKlDUNno9cW/acgI1NUYM1XSCB+nvs74EiZ4sukODCRevBxHMIn6XyimZJQtifqP7q8tGjilGg9HLurY2jkSe43kkUKuDchRBqLWQ3imKFAzWlX7D5uFk6XCTlTxlEw4zU3J2vdftzYMrtKFgoLK/qFbhdIN1LHiRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373073; c=relaxed/simple;
	bh=TV0wVUiqbaBLqqJfBKzLW+zvX7tmDihROeEg6pwNMwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dnzg8vCk8LrIMrp2jiNpQLjU+wwid9Mqdk7AD7UwL1Jb7VvaTVfviFp6bgokSNE554MblreeLAcctOOrIxyWGTNuPHR9t2K9n+loIDkUOLqw8ripXaixaaK9FgImd/uicgTjQ0i9+88dkGbw2jPLBk1XfiTm7T5lq/Y/oSGhJhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZxbYVDg0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B74401BF205;
	Thu, 31 Oct 2024 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730373067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3fwGAsiVjhiFN+U0RnYGt9DvUiZUwlPvWKhDGS9w9o=;
	b=ZxbYVDg0ud6CZzHns5bxh+lwbTLwVmMO3DRnsa9irmz3HgAJ0OKoboGDaskT0tGFG+5Rig
	JN0nq6d3DaGk6xziOpKv7lHwb7zPkd2vU7+5R5mCSYsAZmWSpdajtrk1AIT8ND+QMqIt9g
	Fp1H2800F/uo8qijfHyS93a4qFZAFSU5W2ZwQACJtKHEbLF/CHg8vNWQzDIcKLN9a/01cr
	XL1Rl5uiIHzl6pCb7aEhpoHds1azKE2tyb8WkxUxjZLhbII9a4EYX2O+8aZ/3C195vOdPQ
	NYDn0zGWciBZ8hGETfalr+N0gw8uKdDL9yjxWA4jR9ibKJS1dyraYVriUjF1zw==
Date: Thu, 31 Oct 2024 12:11:04 +0100
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
Message-ID: <20241031121104.6f7d669c@kmaincent-XPS-13-7390>
In-Reply-To: <ZyMpkJRHZWYsszh2@pengutronix.de>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
	<ZyMpkJRHZWYsszh2@pengutronix.de>
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

On Thu, 31 Oct 2024 07:54:08 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> > index a1ad257b1ec1..22664b1ea4a2 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -1002,11 +1002,35 @@ enum ethtool_c33_pse_pw_d_status {
> >   * enum ethtool_c33_pse_events - event list of the C33 PSE controller.
> >   * @ETHTOOL_C33_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
> >   * @ETHTOOL_C33_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
> > + * @ETHTOOL_C33_PSE_EVENT_CONNECTED: PD detected on the PSE.
> > + * @ETHTOOL_C33_PSE_EVENT_DISCONNECTED: PD has been disconnected on the
> > PSE.
> > + * @ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR: PSE faced an error in
> > static
> > + *	port priority management mode.
> >   */
> > =20
> >  enum ethtool_c33_pse_events {
> > -	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =3D	1 << 0,
> > -	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =3D	1 << 1,
> > +	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =3D		1 << 0,
> > +	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =3D		1 << 1,
> > +	ETHTOOL_C33_PSE_EVENT_CONNECTED =3D		1 << 2,
> > +	ETHTOOL_C33_PSE_EVENT_DISCONNECTED =3D		1 << 3,
> > +	ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR =3D	1 << 4,
> > +}; =20
>=20
> Same here, priority concept is not part of the spec, so the C33 prefix
> should be removed.

Ack. So we assume PoDL could have the same interruption events.

> > +/**
> > + * enum pse_port_prio_modes - PSE port priority modes.
> > + * @ETHTOOL_PSE_PORT_PRIO_DISABLED: Port priority disabled.
> > + * @ETHTOOL_PSE_PORT_PRIO_STATIC: PSE static port priority. Port prior=
ity
> > + *	based on the power requested during PD classification. This mode
> > + *	is managed by the PSE core.
> > + * @ETHTOOL_PSE_PORT_PRIO_DYNAMIC: PSE dynamic port priority. Port pri=
ority
> > + *	based on the current consumption per ports compared to the total
> > + *	power budget. This mode is managed by the PSE controller.
> > + */ =20
>=20
> This part will need some clarification about behavior with mixed port
> configurations. Here is my proposal:
>=20
>  * Expected behaviors in mixed port priority configurations:
>  * - When ports are configured with a mix of disabled, static, and dynamic
>  *   priority modes, the following behaviors are expected:
>  *     - Ports with priority disabled (ETHTOOL_PSE_PORT_PRIO_DISABLED) are
>  *       treated with lowest priority, receiving power only if the budget
>  *       remains after static and dynamic ports have been served.
>  *     - Static-priority ports are allocated power up to their requested
>  *       levels during PD classification, provided the budget allows.
>  *     - Dynamic-priority ports receive power based on real-time consumpt=
ion,
>  *       as monitored by the PSE controller, relative to the remaining bu=
dget
>  *       after static ports.

I was not thinking of supporting mixed configuration but indeed why not.
The thing is the Microchip PSE does not support static priority. I didn't f=
ind a
way to have only detection and classification enabled without auto activati=
on.
Mixed priority could not be tested for now.

"Requested Power: The requested power of the logical port, related to the
requested class. In case of DSPD, it is the sum of the related class power =
for
each pair-set. The value is in steps of 0.1 W.
Assigned Class: The assigned classification depends on the requested class =
and
the available power. An 0xC value means that classification was not assigned
and power was not allocated to this port."

We could set the current limit to all unconnected ports if the budget limit=
 goes
under 100W. This will add complexity as the PD692x0 can set current limit o=
nly
inside specific ranges. Maybe it is a bit too specific to Microchip.
Microchip PSE should only support dynamic mode.

>  *
>  * Handling scenarios where power budget is exceeded:
>  * - Hot-plug behavior: If a new device is added that causes the total po=
wer
>  *   demand to exceed the PSE budget, the newly added device is de-priori=
tized
>  *   and shut down to maintain stability for previously connected devices.
>  *   This behavior ensures that existing connections are not disrupted, t=
hough
>  *   it may lead to inconsistent behavior if the device is disconnected a=
nd
>  *   reconnected (hot-plugged).

Do we want this behavior even if the new device has an highest priority than
other previously connected devices?

>  * - Startup behavior (boot): When the system initializes with attached
> devices,
>  *   the PSE allocates power based on a predefined order (e.g., by port i=
ndex)
>  *   until the budget is exhausted. Devices connected later in this order=
 may
>  *   not be enabled if they would exceed the power budget, resulting in
> consistent
>  *   behavior during startup but potentially differing from runtime behav=
ior
>  *   (hot-plug).
>  *
>  * - Consistency challenge: These two scenarios=E2=80=94hot-plug vs. syst=
em boot=E2=80=94may
> lead
>  *   to different handling of devices. During system boot, power is alloc=
ated
>  *   sequentially, potentially leaving out high-priority devices added la=
ter
> due to
>  *   a first-come-first-serve approach. In contrast, hot-plug behavior fa=
vors
> the
>  *   status quo, maintaining stability for initially connected devices, w=
hich
>  *   might not align with the system's prioritization policy.

This could be solve by the future support of persistent configuration. Inde=
ed
the Microchip controller has a non-volatile memory to save the current
configuration (3.1.3) and we could hope future PSE controller could do
the same as there is indeed a consistency challenge.
This support will be added in a later patch series.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

