Return-Path: <netdev+bounces-177750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9657BA7189C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D025B3B10F4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544841EFF91;
	Wed, 26 Mar 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bw8L71c5"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A926AD0;
	Wed, 26 Mar 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999755; cv=none; b=R9epSUMUdXxcBsGrH36OoGOhfoKtOqiOZ298sPLWo0GqqqR4dnKI8escKPmbhjJnl4SecA77s8xY3ZexZAGkuf6Nwyp43EVMJlif5inEsrxwixk2jNgiF+vickDvUGzvGPcBinT72MJ3icfrv70G7eSJLUR92r6/eYxdVMzo4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999755; c=relaxed/simple;
	bh=qZADYuv1O0VMmv2xs3qYIXuBVFL1d4WAbkxhCqQ6Bwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA+yU5BzfeB+YMTRTn7XyueHlbekdUS0Dwp8UGUjN4LuSC8Bv7W5WHvpUkSnUYAbiFbCPE0fibYt8GP9YOWLvx8jm5887DE1gm2vtvJS4XILQzJ7k6l+qM/lWa0QHWPiuwSOv+3i/XJVEyk22lqkmTAOyHYz/f1JPmNMbw6bSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bw8L71c5; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF4A24440F;
	Wed, 26 Mar 2025 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742999750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQRovkh+/s+2V3L1Jz4o46KSoqh+7aTtBz4CLyvMG+k=;
	b=bw8L71c5N71riQY/nJmC/FN+V1CHLHLWuRY4mcv4aWmvThJJBw2g5nJVoLn3QrMP8dLpjH
	O1u+SGyX/13N2hYj/XGj/sVEliDjh0kbf47xwnpbglCRhkUSLCY4WdrpoZV4vM6iet+CKh
	eyEQJJB+TQMG9olSA7FfZ1rQVZdxYxtVbLjNYQpBIktV7kBYUDEGJncgWZwsq9Re00FM1i
	tM69hG6JFdue7rqrINrN3ACT+xvPV/t8nnzX0/O+VUb3yaZlUjnI4kkKyYej231PhzI3hm
	xy8qb4/mriNJfmzO9OLbwA0RtL3BKJXKZXSmfvSHVYnoSq93jnWJyi206zdR0g==
Date: Wed, 26 Mar 2025 15:35:45 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kyle Swenson <kyle.swenson@est.tech>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Dent Project
 <dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250326153545.6f1b16ab@kmaincent-XPS-13-7390>
In-Reply-To: <Z-PQbyKj1CBdqIQh@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
	<Z9gYTRgH-b1fXJRQ@pengutronix.de>
	<20250320173535.75e6419e@kmaincent-XPS-13-7390>
	<20250324173907.3afa58d2@kmaincent-XPS-13-7390>
	<Z-GXROTptwg3jh4J@p620>
	<Z-JAWfL5U-hq79LZ@pengutronix.de>
	<20250325162534.313bc066@kmaincent-XPS-13-7390>
	<Z-MUzZ0v_ZjT1i1J@p620>
	<Z-PQbyKj1CBdqIQh@pengutronix.de>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeekfeegrgemsggvvddvmegrtdgvugemkeguvdgrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemkeefgegrmegsvgdvvdemrgdtvggumeekugdvrgdphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpt
 hhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 26 Mar 2025 11:01:19 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi folks,
>=20
> On Tue, Mar 25, 2025 at 08:40:54PM +0000, Kyle Swenson wrote:
> > Hello Kory,
> >=20
> > On Tue, Mar 25, 2025 at 04:25:34PM +0100, Kory Maincent wrote: =20
> > > On Tue, 25 Mar 2025 06:34:17 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >  =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > Ack I will go for it then, thank you!
> > >=20
> > > Other question to both of you:
> > > If we configure manually the current limit for a port. Then we plug a
> > > Powered Device and we detect (during the classification) a smaller
> > > current limit supported. Should we change the current limit to the one
> > > detected. On that case we should not let the user set a power limit
> > > greater than the one detected after the PD has been plugged. =20
> >=20
> > I don't know that we want to prevent the user from setting a higher
> > current than a device's classification current because that would
> > prevent the PD and PSE negotiating a higher current via LLDP.
> >=20
> > That said, I'm struggling to think of a use-case where the user would be
> > setting a current limit before a PD is connected, so maybe we can reset
> > the current limit when the PD is classified to the classification
> > result, but also allow it to be adjusted after a PD is powered for the
> > LLDP negotiation case.
> >=20
> > In our implementation, don't really let the user specify something like,
> > "Only class 3 and lower devices on this port" because we've not seen
> > customers need this.  We have, however, implemented the LLDP negotiation
> > support after several requests from customers, but this only makes sense
> > when a PD is powered at it's initial classification result.  The PD can
> > then request more power (via LLDP) and then we adjust the current limit
> > assuming the system has budget available for the request.
> >  =20
> > >=20
> > > What do you think? Could we let a user burn a PD? =20
> >=20
> > This seems like a very rare case, and if the PD is designed such that
> > it's reliant on the PSE's current limiting ability then seems like it's
> > just an accident waiting to happen with any PSE.
> >=20
> > Very rarely have we seen a device actually pull more current than it's
> > classification result allows (except for LLDP negotiation). What's more
> > likely is a dual-channel 802.3bt device is incorrectly classified as a
> > single-channel 802.3at device; the device pulls more current than
> > allocated and gets shut off promptly, but no magic smoke escaped.   =20
>=20
> Here=E2=80=99s my understanding of the use cases described so far, and a =
proposal for
> how we could handle them in the kernel to avoid conflicts between differe=
nt
> actors.
>=20
> We have multiple components that may affect power delivery:
> - The kernel, which reacts to detection and classification
> - The admin, who might want to override or restrict power for policy or
> safety reasons
> - The LLDP daemon, which may request more power dynamically based on what=
 the
> PD asks for
>=20
> To avoid races and make things more predictable, I think it's best if each
> actor has its own dedicated input.
>=20
> ## Use Cases
>=20
> ### Use Case 1: Classification-based power (default behavior) =20
> - Kernel detects PD and performs classification
> - Power is applied according to classification and hardware limits
> - No override used
>=20
> Steps:
> 1. Detection runs
> 2. Classification result obtained (e.g. Class 2 =E2=86=92 7W)
> 3. Kernel computes:
>=20
>    effective_limit =3D min(
>        classification_result,
>        controller_capability,
>        board_limit,
>        dynamic_budget
>    )
>=20
> 4. Power applied up to `effective_limit`
>=20
> ### Use Case 2: Admin-configured upper bound (non-override) =20
> - Admin sets a policy limit that restricts all power delivery
> - Does not override classification, only bounds it
>=20
> Steps:
> 1. Admin sets `ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT =3D 15000`
> 2. Detection + classification run normally
> 3. Kernel computes:
>=20
>    effective_limit =3D min(
>        classification_result,
>        AVAIL_PWR_LIMIT,
>        controller_capability,
>        board_limit,
>        dynamic_budget
>    )
>=20
> 4. Classification is respected, but never exceeds admin limit
>=20
> This value is always included in power computation =E2=80=94 even if clas=
sification
> or LLDP overrides are active.
>=20
> ### Use Case 3: Persistent classification override (admin) =20
> - Admin sets a persistent limit that overrides classification
> - Power is always based on this override
>=20
> Steps:
> 1. Admin sets `CLASS_OVERRIDE_PERSISTENT =3D 25000` (mW)
> 2. Detection/classification may run, but classification result is ignored
> 3. Kernel computes:
>=20
>    effective_limit =3D min(
>        CLASS_OVERRIDE_PERSISTENT,
>        AVAIL_PWR_LIMIT,
>        controller_capability,
>        board_limit,
>        dynamic_budget
>    )
>=20
> 4. Power applied accordingly
> 5. Override persists until cleared
>=20
> ### Use Case 4: Temporary classification override (LLDP) =20
> - LLDP daemon overrides classification for current PD session only
> - Cleared automatically on PD disconnect
>=20
> Steps:
> 1. PD connects, detection + classification runs (e.g. 7W)
> 2. LLDP daemon receives PD request for 25000 mW
> 3. LLDP daemon sets `CLASS_OVERRIDE_TEMPORARY =3D 25000`
> 4. Kernel computes:
>=20
>    effective_limit =3D min(
>        CLASS_OVERRIDE_TEMPORARY,
>        AVAIL_PWR_LIMIT,
>        controller_capability,
>        board_limit,
>        dynamic_budget
>    )
>=20
> 5. Power is increased for this session
> 6. On PD disconnect, override is cleared automatically
>=20
> ---
>=20
> ### Use Case 5: Ignore detection and classification (force-on) =20
> - Admin forces the port on, ignoring detection
> - Useful for passive/non-802.3 devices or bring-up
>=20
> Steps:
> 1. Admin sets:
>    - `DETECTION_IGNORE =3D true`
>    - `CLASS_OVERRIDE_PERSISTENT =3D 5000`
> 2. Kernel skips detection and classification
> 3. Kernel computes:
>=20
>    effective_limit =3D min(
>        CLASS_OVERRIDE_PERSISTENT,
>        AVAIL_PWR_LIMIT,
>        controller_capability,
>        board_limit,
>        dynamic_budget
>    )
>=20
> 4. Power is applied immediately
>=20
> ## Proposed kernel UAPI
>=20
> ### SET attributes (configuration input)
>=20
> | Attribute                                 | Type     | Lifetime
>  | Owner           | Description |
> |-------------------------------------------|----------|-----------------=
-------|------------------|-------------|
> | `ETHTOOL_A_PSE_CLASS_OVERRIDE_PERSISTENT` | u32 (mW) | Until cleared
>   | Admin            | Persistent classification override | |
> `ETHTOOL_A_PSE_CLASS_OVERRIDE_TEMPORARY`  | u32 (mW) | Cleared on detecti=
on
> failure / PD replug | LLDP daemon / test tool | Temporary override of
> classification | | `ETHTOOL_A_PSE_DETECTION_IGNORE`          | bool     |
> Until cleared          | Admin            | Ignore detection phase | |
> `ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT`       | u32 (mW) | Until changed
> | Admin            | Static admin-defined max power cap (non-override) |
>=20
> ### GET attributes (status and diagnostics)
>=20
> | Attribute                                  | Type     | Description |
> |--------------------------------------------|----------|-------------|
> | `ETHTOOL_A_PSE_EFFECTIVE_PWR_LIMIT`        | u32 (mW) | Final power lim=
it
> applied by kernel | | `ETHTOOL_A_PSE_CLASS_OVERRIDE_PERSISTENT`  | u32 (m=
W) |
> Current persistent override (if set) | |
> `ETHTOOL_A_PSE_CLASS_OVERRIDE_TEMPORARY`   | u32 (mW) | Current temporary
> override (if active) | | `ETHTOOL_A_PSE_DETECTION_IGNORE`           | bool
>  | Current detection ignore state |
>=20
> ### Power Limit Priority
>=20
> Since we now have multiple sources that can influence how much power is
> delivered to a PD, we need to define a clear and deterministic priority
> order for all these values. This avoids confusion and ensures that the ke=
rnel
> behaves consistently, even when different actors (e.g. admin, LLDP daemon,
> hardware limits) are active at the same time.
>=20
> Below is the proposed priority list =E2=80=94 values higher in the list t=
ake
> precedence over those below:
>=20
> | Priority | Source / Field                          | Description |
> |----------|------------------------------------------|-------------|
> | 1        | Hardware/board-specific limit         | Maximum allowed by
> controller or board design (e.g. via device tree or driver constraints) |=
 | 2
>        | Dynamic power budget                  | Current system-level or
> PSE-level power availability (shared with other ports) | | 3        |
> `ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT`       | Admin-configured upper bound =
=E2=80=94
> applies even when classification or override is used | | 4        |
> `ETHTOOL_A_PSE_CLASS_OVERRIDE_TEMPORARY`  | Temporary override, e.g. set =
by
> LLDP daemon, cleared on PD disconnect or detection loss | | 5        |
> `ETHTOOL_A_PSE_CLASS_OVERRIDE_PERSISTENT` | Admin override that persists
> until cleared | | 6        | `ETHTOOL_A_PSE_CLASSIFICATION_RESULT`     |
> Result of PD classification, used when no override is present |
>=20
> The effective power limit used by the kernel will always be the minimum o=
f the
> values above.
>=20
> This way, even if the LLDP daemon requests more power, or classification
> result is high, power delivery will still be constrained by admin policie=
s,
> hardware limits, and current budget.

Kyle thanks for your PoE user side answer!
Oleksij, thanks, as usual you have done an intense brainstorm! ^^
These two replies could be helpful in the future.

I asked this because I found out that the over current event of the TPS23881
was resetting the power limit register of the port. I think I will simply
fix it by reconfiguring the power limit if this event happens.
So it won't change the current behavior where the user setting of power lim=
it
prevail over the power limit detected during classification.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

