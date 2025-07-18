Return-Path: <netdev+bounces-208204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034AB0A93B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81BF1C47D02
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2982E716C;
	Fri, 18 Jul 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f493Vym+"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1891F1315;
	Fri, 18 Jul 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858901; cv=none; b=XCvQxPcUDrZMuQ5+smqkzAzsMrMp8LUKJJkKIU4xwWW1Np6XnGQffAbx+vd2lZ/7MM1AJYGhV9+QuO/74GUu5HNxN0GJCr6w5oNhgKCXHZY2PKfkJTjkOkfI1gHgKymMEjdez1byaFKPUSlfWjQyZxIfuWdqj50LJOjxGpzkHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858901; c=relaxed/simple;
	bh=YGwx2M62WCpXsrvDIHg9O/NBRPSuZH7EMETUbV9AlZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2aL/dNrfJDyBRcKi1H8uWZSwYYkjFzSGowLxePeY0oBdJSr8Mr3M0VUXJ8iQBje8m40B+kCh1vk82xmZNeyQHmjBi5HvqLsSpSmKPOsUD/L9YaU5AKSq0ygqpx6uuCd1pi2nFSZZ+NYHntNkuqh+09KhApJU65oS7vZb1yElmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f493Vym+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3249242D7F;
	Fri, 18 Jul 2025 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752858897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGwx2M62WCpXsrvDIHg9O/NBRPSuZH7EMETUbV9AlZM=;
	b=f493Vym+PpOrr+qkJ1pxjkucvoZ3IKXLs17yzLUrnB+wHxGp7DvKs1RwDCnQByJfWNSiR5
	pQYyRNYYOQjbFfsVDgHY3+ayiRtkYnZMpofMDbCjOt6d38wCepNn1N6DmhBECCXdi0ucFw
	RcRAnFI+vWUN1dyDATKJDRAHGKzPamtceMRQd8tpqulqkTNMI5lHoPWfLj5As6GCuSJhEu
	nxBtViBwJ4e9dhwHQ3exuJZOZSROTuVve950L3eTq+QVcv2d0ydlpIn0w+ZHFi5KjveGxp
	xUcXz/c1iV7qFDWY+BtitbamMLbqxnnEDusF5/XfKoc0Sx/WqK6bNH7/d9KkvQ==
Date: Fri, 18 Jul 2025 19:14:55 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Piotr Kubik <piotr.kubik@adtran.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250718191455.5b441114@kmaincent-XPS-13-7390>
In-Reply-To: <20250715175328.43513c21@kernel.org>
References: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
	<b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
	<20250715175328.43513c21@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduheemfegvgeemtgehtddtmeekvddttgemiegvtddumeejkegrtgemvdgtugefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduheemfegvgeemtgehtddtmeekvddttgemiegvtddumeejkegrtgemvdgtugefpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhiohhtrhdrkhhusghikhesrgguthhrrghnrdgtohhmpdhrtghpthhtohepohdrrhgvmhhpv
 ghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Tue, 15 Jul 2025 17:53:28 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> On Fri, 11 Jul 2025 11:25:02 +0000 Piotr Kubik wrote:
> > From: Piotr Kubik <piotr.kubik@adtran.com>
> >=20
> > Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> > controller.
> >=20
> > Driver supports basic features of Si3474 IC:
> > - get port status,
> > - get port power,
> > - get port voltage,
> > - enable/disable port power.
> >=20
> > Only 4p configurations are supported at this moment. =20
>=20
> Hi Kory, it'd be good to have your review tag on this.

Yes, I am following this series, but not much actively due to holidays.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

