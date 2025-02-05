Return-Path: <netdev+bounces-163027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628CA28DD6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95131650C4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BEF155333;
	Wed,  5 Feb 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EIKNio7h"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233711519AA;
	Wed,  5 Feb 2025 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764351; cv=none; b=Vyj/TuNKHkV6fy4WkFvQ/IQp0MwcDiUrQ3Kh2sR4wJPH9iT0R9ElG4Q9OSNvZI2q6A7umyDxaVeekMo0lg2bs0zvv4LHFZ9dgLbi6k8GiizsWyn+m3p9yU2ZmyFJ0blUryyK8gpp+c3iJzanc0ZeGq+5CdAWiKB5TmoELup43ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764351; c=relaxed/simple;
	bh=zK4I8a/Y4mpy9XKso8C5wpxuU2XVKbVEC233IlFK+5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TumWNeBzJYg4k06jhKqB8nr1gRQOB5MS7ZQQVQtHbcLayMhzIBxgAoV0Eeyq362l9fQIZjpBVu/P8FiDFK/oxKyijHoKMNlSL9OrzDAZ+QkvrQxyDR6PhpRGA2FxWPgbsOA9gk1quzIIsqUTEH8lnot5zgKX45SNcKXqXMTRp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EIKNio7h; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24E81440EC;
	Wed,  5 Feb 2025 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738764346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYwn+oUNBIEmYxC3PFxocPoMODj85DdyaB/6dKEjRn8=;
	b=EIKNio7hdZ8vnqBZNmjLN/k7KMiMV4Vz+dlCMGu1bd7PrtxErJZ8dsDzxmIsrQI33ybtRi
	z3kZgtle+04vHPyxMmJ9aKiMYxp9GMA7zgEjOpINxkdcz2mbjWGiny0jzZBCo/FY3l7psi
	NV+AmX/MKuydZLpJOOCCAdumICywkt3mzpfMkBbSwv/DgW/KAcxketWNDFdtVqILvB9cQM
	6OcHPTwJLkpvSnHzUt49jQ1QTxIP4OQcDV5FuYQVdaboEpZdXKxSQzTMfPS1AVV2tBDV7m
	Xk/7FX/9HXmgszuGMEbp7of7x+tuXibFFL6d0fQq9HLPZq++9JpUpOrBXxgPjA==
Date: Wed, 5 Feb 2025 15:05:42 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 25/27] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Message-ID: <20250205150542.46733638@kmaincent-XPS-13-7390>
In-Reply-To: <rva5vyuksnw64j7hbgdjp2n4qw22a7niw4oc66dyaz5ndaa7ja@u6z4mavekjsw>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
	<20250103-feature_poe_port_prio-v4-25-dc91a3c0c187@bootlin.com>
	<rva5vyuksnw64j7hbgdjp2n4qw22a7niw4oc66dyaz5ndaa7ja@u6z4mavekjsw>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqfedtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhjeevfeeggeeghffgudfhhedvvedvueekleevjeduvddutefhvddugedtfeeludenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: kory.maincent@bootlin.com

Hello Krzysztof,

On Sat, 4 Jan 2025 10:52:55 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Jan 03, 2025 at 10:13:14PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This patch adds the regulator supply parameter of the managers. =20
>=20
> > +          vmain-supply:
> > +            description: Regulator power supply for the PD69208X manag=
er. =20
>=20
> s/Regulator//
> Keep it simple, no need to state obvious. What is not obvious here is
> why there are no main device supplies (VDD, VDDA).
>=20
> And what about VAUX5 and VAUX3P3? So basically the description is not
> only redundant but actually incorrect because it suggests it is entire
> supply, while there are others.

VMAIN can be the only power supply, with VAUX5 and VAUX3P3 derived internal=
ly
from VMAIN. However having the descriptions of all the regulator supplies is
indeed maybe better. I will update the patch accordingly.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

