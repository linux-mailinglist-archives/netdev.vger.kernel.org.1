Return-Path: <netdev+bounces-193220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA53AC2F43
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2752EA23E4B
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004C11E7C19;
	Sat, 24 May 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PcKLDZvq"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3931E1E04;
	Sat, 24 May 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084494; cv=none; b=PHfWD8XsSn7hogKJtDbW/YCM987WlB93zu+j/WpoPr5+qOlAw1gq9OwwTppDHsN6zucBnCKJCoKl7iAFyXO8sRgn2+oVqFZ3KkPrACVoM1fVpm4KNfg8L1pEemKYIxam/1HYJ+cKDrjifswEGheQljbeCfSYL+1KWgKHfAZzsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084494; c=relaxed/simple;
	bh=+E7Zlv1j/WSnUtLC3A+xvHRqK18kNCawdcvOM9lFT/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3MvCgmpFNwuNmPqWdTf8reEKkYOT/j1k1+vKIW2AWbx/ZCykRxJDxSqAwQNl0np8Xga9ipNmJhPVKGPIkJspl3E46k+Hub+n4TvuNlpFV5RDpqxEjrfkRypa3gZsVgVokvDifzG2IkRppFmOotgWC/ruLKihXKQa3Jxcxee1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PcKLDZvq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 661194389B;
	Sat, 24 May 2025 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748084484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+E7Zlv1j/WSnUtLC3A+xvHRqK18kNCawdcvOM9lFT/Y=;
	b=PcKLDZvqXSeNChRaI7+sp0EspGkysQUb8JeHEubYT+1+736sTLZE6BpuF/+/qNFBhQQr6Y
	OdmN42AJbYdGGSYEtDXP8OluSmvaQktyZ3NDxHYyApOW/rcjR5uGHGTP+yYFrJKTss/LwP
	2czPW042TPYK796ESfEPUECNzP67NZwBf5qyrgLU1V2WsoqQL68BnUNmk0y1zoxM+dV/EA
	dVtPiyZVENN8hGr5TJattasNARRghE68JAHYstpIy/LmWWUASx1DHyn3BGR14tnstvpwuM
	S+ycbjBAErRIrqxbSdklA4BMt4aAE8C+JiajSU3Dny1/57cn7Vt1ZdD5yyJ9kA==
Date: Sat, 24 May 2025 13:01:20 +0200
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
Subject: Re: [PATCH net-next v12 01/13] net: pse-pd: Introduce
 attached_phydev to pse control
Message-ID: <20250524130120.1fa0f039@kmaincent-XPS-13-7390>
In-Reply-To: <20250524-feature_poe_port_prio-v12-1-d65fd61df7a7@bootlin.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<20250524-feature_poe_port_prio-v12-1-d65fd61df7a7@bootlin.com>
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

Le Sat, 24 May 2025 12:56:03 +0200,
Kory Maincent <kory.maincent@bootlin.com> a =C3=A9crit :

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> In preparation for reporting PSE events via ethtool notifications,
> introduce an attached_phydev field in the pse_control structure.
> This field stores the phy_device associated with the PSE PI,
> ensuring that notifications are sent to the correct network
> interface.
>=20
> The attached_phydev pointer is directly tied to the PHY lifecycle. It
> is set when the PHY is registered and cleared when the PHY is removed.
> There is no need to use a refcount, as doing so could interfere with
> the PHY removal process.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Forgot to add:
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

