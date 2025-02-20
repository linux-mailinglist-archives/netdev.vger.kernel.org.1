Return-Path: <netdev+bounces-168078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A12A3D471
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C183B7F22
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17101C3316;
	Thu, 20 Feb 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T/xVVx0m"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050111BC09A;
	Thu, 20 Feb 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043174; cv=none; b=uNFVPf7t4l+DFvIpACAuiJtVd5qfmPas2gRITIaMtwd1sJtKUqNJ8p0Zkj9dRFqq9X0bGoIAaTjOBQ4+y3USIPXuwRcezCsxgFNFHmXbRt7LFdpVDalMuxdikmXocYUNTkYkHoOxYNAKIZ4Y32GjEQ3kok8KrNFznP80sRoOre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043174; c=relaxed/simple;
	bh=3rP7TAb0u+ZRptaXKAknV42oirdWm6E+vqJLe99bC1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLTWQAH7CfAafAB6eHxW107rofd6TLJOwwM9uy74vz0/XwQniQ0eNzr/HgordxZPFcVY4wrUPes+WIuCAJ3/olUVIeoqjwu7CmP6BWciw7qaYdmar1yobLLQIVY8QqD/+i/cJ/j0LzqlzZMwLlOBxnQ83uQYM/C63jGEeo4R5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T/xVVx0m; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD1754328A;
	Thu, 20 Feb 2025 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740043170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rP7TAb0u+ZRptaXKAknV42oirdWm6E+vqJLe99bC1s=;
	b=T/xVVx0mGjOl7ELVAzCD5pSvFSXkMjNZa7402DIZ+9ZILP+LVehVA4XrnACrPWtXcOtH8e
	BWnDrqejayE9WjADFyPpdMU2AAZiaUnf7rJQ4e84DFY4pq08D9dlAiaTaZUWiVoU2vYtX0
	YAqM4y8ObtkYLTLP1Y/4/R8JF9ykSXG5UtnCIzq56CgR3Y8Fty6pHQL/9vlJDo0B7/eBSo
	260n94rDo7w8kuuaSG6/qNNErRQ9lcyvg9lG+aXpBkXicV/Fk/anF2amkN0dtTIkWyK8mr
	vUnR7RZcwHClAF58U8z4mkTC0BYZOtkezRvkZ4F69+qCXCIaEs7F3wjc1qlKdg==
Date: Thu, 20 Feb 2025 10:19:25 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Niklas =?UTF-8?B?U8O2?=
 =?UTF-8?B?ZGVybHVuZA==?= <niklas.soderlund+renesas@ragnatech.se>, Gregor
 Herburger <gregor.herburger@ew.tq-group.com>, Stefan Eichenberger
 <eichest@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: phy: marvell-88q2xxx: Enable
 temperature measurement in probe again
Message-ID: <20250220101925.5cd1d9d3@kmaincent-XPS-13-7390>
In-Reply-To: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
References: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopeguihhmrgdrfhgvughrrghusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegur
 ghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 20 Feb 2025 09:11:10 +0100
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Patchset fixes these:
> - Enable temperature measurement in probe again
> - Prevent reading temperature with asserted reset
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

