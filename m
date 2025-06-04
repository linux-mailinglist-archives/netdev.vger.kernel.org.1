Return-Path: <netdev+bounces-195058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110EACDB0A
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1F318982D3
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EF82185A6;
	Wed,  4 Jun 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zs30AHFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1F28CF7B;
	Wed,  4 Jun 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029487; cv=none; b=vE8BbaHR+rezfX392W3EHIB5yYRcAQCI+WsaPOZ5Er/ffppbJoceKiUqMCidgblm87HhvJzyh7euLfuRApoZyE/EyFQt/1LCZW5zpshkY1Hhct5cbL1Y0fSIKFCB4alRLFRY3isrGkG/aiWWX08ycgRHFCGoX8B6wWpX75OhEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029487; c=relaxed/simple;
	bh=mhH4mj1f10E1+mINLkuRBuY+Byi4tPTB63LRjImVY4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJ2AiH+SMjeh2kFSvYOgIsJecYS2sjdM23mRaMviApUqhPEqSlVmVHiK2qx8Pa+z0Vw0P5/BxIivmqD37ihpprybJASAIzoEyVDqaioX5/9a796nvlamXoqdeW3Gj3nHCDYDyMIutVdNrt8dsORmh9Anart6jZ4mF5E4bUNMWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zs30AHFQ; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7132758308E;
	Wed,  4 Jun 2025 09:07:04 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12A101FD80;
	Wed,  4 Jun 2025 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749028017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yB6BN7KUkI2qIVI8YcoJEME4af0JbYm40UT3uJsfZF4=;
	b=Zs30AHFQrCih7XU3IqWWJnOT8luyt026RknmtfpGCWNNvAl0B14CQ1BTTrBQXu0oo+p4zx
	RDb0KPBXTsW6HiP3vxh1AN0UHw9hhLJoe943MdnXsFdnZf7Tc8MUwjMmVsJkOaMmiC/uA/
	Bp3cJmkkeOTveyGYRDxVDrYNbN2wLeg83TZxNtJcouL9YQOf/rC0dtHqQXRjCOPsd8mxEj
	oaxPh9en8sHW5ojJvkV+/yiVCoq+a/furYMwSsHFr2coAnk1MGt6gHM4OqmfL1CobQ/KTS
	FrsbKrGB45OSZQUACeQsDWXZ+7K3FFx4YyskLhmVbQq4VHuI5FWNq2MWCSaj/g==
Date: Wed, 4 Jun 2025 11:06:54 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: pse-pd: Describe the
 LTC4266 PSE chipset
Message-ID: <20250604110654.52dd736b@kmaincent-XPS-13-7390>
In-Reply-To: <20250603230422.2553046-2-kyle.swenson@est.tech>
References: <20250603230422.2553046-1-kyle.swenson@est.tech>
	<20250603230422.2553046-2-kyle.swenson@est.tech>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeghedvgfetudeuhfejieeuvdetteduvdetkedtveevfedvheelueeludffhfevnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepkhihlhgvrdhsfigvnhhsohhnsegvshhtrdhtvggthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgth
 hdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Tue, 3 Jun 2025 23:04:37 +0000,
Kyle Swenson <kyle.swenson@est.tech> a =C3=A9crit :

> Add the LTC4266 PSE controller from Linear Technology to the device-tree
> bindings.

Hello Kyle,

Nice to see your patch!

Your Sign-off-by tag is missing on all your patches.

> ---
>  .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.ya=
ml
> b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml new file
> mode 100644 index 000000000000..874447ab6c84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LTC LTC4266 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kyle Swenson <kyle.swenson@est.tech>
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc4266
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pse-cells':
> +    const: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  channels:
> +
> +    description: This parameter describes the mapping between the logical
> ports
> +      on the PSE controller and the physical ports.

The channels parameter is not describing the mapping but only the channels
list. I also have to change the tps23881 binding doc similarly.
We discussed about this here
https://lore.kernel.org/netdev/20250517003525.2f6a5005@kmaincent-XPS-13-739=
0/

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

