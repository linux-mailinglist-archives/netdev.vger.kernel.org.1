Return-Path: <netdev+bounces-193222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CCAC2F41
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4B4164D73
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3DE1A3BD8;
	Sat, 24 May 2025 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JFuRV/sz"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0D194A44;
	Sat, 24 May 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084611; cv=none; b=gflG5g12K2GRHXlz1wzWqP2EZyZqBM8ugAqDk5TpsbtmULlFTqwb2hN8O/1tjEpYZWiD0T4FDM5UiaHEiI/im02xJv7ddqOkc7e2j9/0Qbxj6iaiJXSGsoPX6/gRzB2DqbFVUt0MP4nhCu+MOPHRO+qGAZ38lImZIIprO+52TGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084611; c=relaxed/simple;
	bh=0JfAm6XyLt8Uvc0tgfIphr7NJd8emCwE8S+wsVjBD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXM1WIJRcfiWnVedTKeKtGK7ulYms9Yz40GQwBr+JZyRP8kE++oToEzBSbx5ygx4XLWNRv6Yz91XD6SrsdNE0+RDRSKQM3EKX6EJ1c9zPNcA3+rUGDMo6TwUUY6Do62Gtt0ZH6XMND3zF6f1x6AZS9c8qLczU63kvF74rX6r4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JFuRV/sz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C74AE439FF;
	Sat, 24 May 2025 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748084601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhGo38p9AkZZZjS8zqaVWp4e4joqF7J4aXzGFF+CwMo=;
	b=JFuRV/szLE4v7nVrWLQbgWBmGZsH0XwI8sozeptD2rLnQbxO3TnrRk77r8eMBK0eV4RDfq
	PcmSGE0xQkAmzXerO13gos8BDcag8sCIMUMbDFaSHNI4AI+0O3q2myRlmj/X7KiCgQF9lk
	xNey3XDpw2JxOtw0qfw51yMW0vRJu8qnNIG+qcw4f0x65+UIBOwn9UKeOqld3IJQhov/xe
	kycACu2V8DCFP1RgHj7HXMCsoT4iiDB921UpkSEsZdoqCfzw8Y/yT5xhb8UE3gbly4+P7z
	xxBO4f8k7YXRWkEWhe/xlnGzfHiUK4FKegWyplPA1uMZdUtkZGVUt676UT/gtQ==
Date: Sat, 24 May 2025 13:03:18 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v12 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250524130318.72daea05@kmaincent-XPS-13-7390>
In-Reply-To: <20250524-feature_poe_port_prio-v12-7-d65fd61df7a7@bootlin.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<20250524-feature_poe_port_prio-v12-7-d65fd61df7a7@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudehheculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemvgeigegsmegtkegrsgemvggvkeemjegvieeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemvgeigegsmegtkegrsgemvggvkeemjegvieekpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrt
 ghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Le Sat, 24 May 2025 12:56:09 +0200,
Kory Maincent <kory.maincent@bootlin.com> a =C3=A9crit :

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This patch introduces the ability to configure the PSE PI budget evaluati=
on
> strategies. Budget evaluation strategies is utilized by PSE controllers to
> determine which ports to turn off first in scenarios such as power budget
> exceedance.
>=20
> The pis_prio_max value is used to define the maximum priority level
> supported by the controller. Both the current priority and the maximum
> priority are exposed to the user through the pse_ethtool_get_status call.
>=20
> This patch add support for two mode of budget evaluation strategies.
> 1. Static Method:
>=20
>    This method involves distributing power based on PD classification.
>    It=E2=80=99s straightforward and stable, the PSE core keeping track of=
 the
>    budget and subtracting the power requested by each PD=E2=80=99s class.
>=20
>    Advantages: Every PD gets its promised power at any time, which
>    guarantees reliability.
>=20
>    Disadvantages: PD classification steps are large, meaning devices
>    request much more power than they actually need. As a result, the power
>    supply may only operate at, say, 50% capacity, which is inefficient and
>    wastes money.
>=20
>    Priority max value is matching the number of PSE PIs within the PSE.
>=20
> 2. Dynamic Method:
>=20
>    To address the inefficiencies of the static method, vendors like
>    Microchip have introduced dynamic power budgeting, as seen in the
>    PD692x0 firmware. This method monitors the current consumption per port
>    and subtracts it from the available power budget. When the budget is
>    exceeded, lower-priority ports are shut down.
>=20
>    Advantages: This method optimizes resource utilization, saving costs.
>=20
>    Disadvantages: Low-priority devices may experience instability.
>=20
>    Priority max value is set by the PSE controller driver.
>=20
> For now, budget evaluation methods are not configurable and cannot be
> mixed. They are hardcoded in the PSE driver itself, as no current PSE
> controller supports both methods.
>=20
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Forgot to add:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

