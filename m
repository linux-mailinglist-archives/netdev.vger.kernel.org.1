Return-Path: <netdev+bounces-141994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB19BCE42
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B0F1C21172
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564DB1D515B;
	Tue,  5 Nov 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JJhQRaAy"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DDBE4E;
	Tue,  5 Nov 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814562; cv=none; b=RCePAyOGYCUnxxyeJlrDuU21Dh1SA+ACJVGEyFRu5xNDaZCckiJXtJZ4ejVIy+ahvmNcnC8Eipm2prI2zTU+147Y9Gp/Y40RDe866uZgByqiNZRwRXHJxFywbUBMMID7cmN/PBnlhk8w1NPx7AoD5sOAAbsYppNq7OjaIb4deSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814562; c=relaxed/simple;
	bh=LGtATLDN+vwUzWiQ/Mccv0jBoothaCwWGgNXVsGSGK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/WuY76yMmQ4bWJB3lnmdw+WGQFe1sqdu3SfU2IPWlXYwHJluflCrm2lvomIaE94fNaPYo9PueuvC7BNtOP0lfyZLnsMWBGPupyCDKLIny9Vkm92K2wkFrebppUajlK74D4oAHfEplWF1iK4mN3QyaVXLDdomDieWeIxOVWvoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JJhQRaAy; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EDBE240002;
	Tue,  5 Nov 2024 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730814556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfo9PRjLxKPm1Z7BISg4mBOSMwFufrQ6DXAOo7cnLrA=;
	b=JJhQRaAyrd0eYUMZEYWLQzFw3lvWee36MSZc8SFrv3OjIboHuVrsEAjGOU1YfxyoESrC1l
	Y7mJJfKoUt80PiNgJQd0c06b+ErGd0SHo0zxGKA6Y5Q5UFMSsY3A9sOxo6rBHkysa/SxE0
	HyNVcO/sSRHqLZMOdxAheU+fPaIvZ8zIdvyzWQRHtgJyolk68kYAuGQhoXEQnbv2p7Bp4K
	jgbCvQNpr0dtKiQp/5YMgB9O+Iqh5vmm/307Hec+OpqSLuLliGvikY0fnp8v+8bhfFvAfs
	AU7vWyd0quozxH/Pxh7ixY/R521eaEGfUD6P84ggVSjDz5R7FS0bF+nnTg7CoQ==
Date: Tue, 5 Nov 2024 14:49:13 +0100
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
Message-ID: <20241105144913.3c25b476@kmaincent-XPS-13-7390>
In-Reply-To: <ZyO_N1EOTZCprgMJ@pengutronix.de>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
	<ZyMpkJRHZWYsszh2@pengutronix.de>
	<20241031121104.6f7d669c@kmaincent-XPS-13-7390>
	<ZyO_N1EOTZCprgMJ@pengutronix.de>
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

On Thu, 31 Oct 2024 18:32:39 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:
=20
> > >  *
> > >  * Handling scenarios where power budget is exceeded:
> > >  * - Hot-plug behavior: If a new device is added that causes the total
> > > power
> > >  *   demand to exceed the PSE budget, the newly added device is
> > > de-prioritized
> > >  *   and shut down to maintain stability for previously connected dev=
ices.
> > >  *   This behavior ensures that existing connections are not disrupte=
d,
> > > though
> > >  *   it may lead to inconsistent behavior if the device is disconnect=
ed
> > > and
> > >  *   reconnected (hot-plugged). =20
> >=20
> > Do we want this behavior even if the new device has an highest priority=
 than
> > other previously connected devices? =20
>=20
> Huh... good question. I assume, if we go with policy in kernel, then it
> is ok to implement just some one. But, I assume, we will need this kind of
> interface soon or later:=20
>=20
> Warning! this is discussion, i'm in process of understanding :D
>=20
> /**
>  * enum pse_disconnection_policy - Disconnection strategies for same-prio=
rity
>  *   devices when power budget is exceeded, tailored to specific priority
> modes. *
>  * Each device can have multiple disconnection policies set as an array of
>  * priorities. When the power budget is exceeded, the policies are execut=
ed
>  * in the order defined by the user. This allows for a more nuanced and=20
>  * flexible approach to handling power constraints across a range of devi=
ces
>  * with similar priorities or attributes.
>  *
>  * Example Usage:
>  *   - Users can specify an ordered list of policies, such as starting wi=
th
>  *     `PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST` to prioritize based on cla=
ss,
>  *     followed by `PSE_DISCON_LRC` to break ties based on connection tim=
e.
>  *     This ordered execution ensures that power disconnections align clo=
sely
>  *     with the system=E2=80=99s operational requirements and priorities.
=20
...

>  * @PSE_DISCON_STATIC_CLASS_BUDGET_MATCH: Disconnect based on static
> allocation
>  *   class, targeting devices that release enough allocated power to meet=
 the
>  *   current power requirement.
>  *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
>  *   - Behavior: Searches for the lowest-priority device that can release
>  *     sufficient allocated power to meet the current budget requirement.
>  *     Ensures that disconnection occurs only when enough power is freed.
>  *   - Rationale: This strategy is useful when the goal is to balance pow=
er
>  *     budget requirements while minimizing the number of disconnected
> devices.
>  *     It ensures that the system does not needlessly disconnect multiple
>  *     devices if a single disconnection is sufficient to meet the power
> needs.
>  *   - Use Case: Ideal for systems where precise power budget management =
is
>  *     necessary, and disconnections must be efficient in terms of freeing
>  *     enough power with minimal impact on the system.

Not sure about this one. PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST would be
sufficient for that case.
=20
>  * @PSE_DISCON_LOWEST_AVG_POWER: Disconnect device with the lowest average
>  *   power draw, minimizing impact on dynamic power allocation.
>  *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_DYNAMIC
>  *   - Behavior: Among devices with the same priority level, the system
>  *     disconnects the device with the lowest average power draw.
>  *   - If multiple devices have the same average power draw and priority,
>  *     further tie-breaking mechanisms can be applied, such as disconnect=
ing
>  *     the least recently connected device.
>  *   - Rationale: Minimizes disruption across dynamic devices, keeping as=
 many
>  *     active as possible by removing the lowest-power ones.
>  *   - Use Case: Suitable for dynamic-priority systems where maximizing t=
he
>  *     number of connected devices is more important than individual devi=
ce
>  *     power requirements.
>=20
>  * @PSE_DISCON_LONGEST_IDLE: Disconnect device with the longest idle time
>  *   (low or no recent active power usage).
>  *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_DYNAMIC
>  *   - Behavior: Disconnects the device with the longest period of inacti=
vity,
>  *     where "idle" is defined as low current draw or absence of recent d=
ata
>  *     transmission.
>  *   - If multiple devices have the same idle time and priority, a
> tie-breaking
>  *     mechanism, such as round-robin based on port index, can be used.
>  *   - Rationale: Optimizes resource allocation in dynamic-priority setup=
s by
>  *     maintaining active devices while deprioritizing those with minimal
>  *     recent usage.
>  *   - Use Case: Ideal for dynamic environments, like sensor networks, wh=
ere
>  *     devices may be intermittently active and can be deprioritized duri=
ng
>  *     idle periods.
>  *
>  * These disconnection policies provide flexibility in handling cases whe=
re
>  * multiple devices with the same priority exceed the PSE budget, aligning
>  * with either static or dynamic port priority modes:
>  *   - `ETHTOOL_PSE_PORT_PRIO_STATIC` benefits from policies that maintain
>  *     stable power allocation, favoring longer-standing or higher-class
>  *     devices (e.g., `PSE_DISCON_LRC`, `PSE_DISCON_ROUND_ROBIN_IDX`,
>  *     `PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST`,
> `PSE_DISCON_STATIC_CLASS_LOWEST_FIRST`,
>  *     `PSE_DISCON_STATIC_CLASS_BUDGET_MATCH`).
>  *   - `ETHTOOL_PSE_PORT_PRIO_DYNAMIC` supports policies that dynamically
>  *     adjust based on real-time metrics (e.g., `PSE_DISCON_LOWEST_AVG_PO=
WER`,
>  *     `PSE_DISCON_LONGEST_IDLE`), ideal for setups where usage fluctuates
>  *     frequently.
>  *   - Users can define an ordered array of disconnection policies, allow=
ing
>  *     the system to apply each policy in sequence, providing nuanced con=
trol
>  *     over how power disconnections are handled.
>  */

I think I can add support for one or two of these modes in this patch serie=
s.
Modes relevant for dynamic port priority can't be used for now as nothing
support them.
Do you think I should add this full enumeration in ethtool UAPI even if not=
 all
of them are supported yet?=20


> PD692x0 seems to use @PSE_DISCON_ROUND_ROBIN_IDX_HIGHEST_FIRST disconnect=
ion
> policy.

Yes.

> ETHTOOL_PSE_PORT_PRIO_DYNAMIC and ETHTOOL_PSE_PORT_PRIO_STATIC seems to b=
e the
> source of information which should be used to trigger the disconnection
> policy. Correct?

Yes.
The management of disconnection in ETHTOOL_PSE_PORT_PRIO_DYNAMIC case is
managed directly by the PSE firmware on the PD692x0.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

