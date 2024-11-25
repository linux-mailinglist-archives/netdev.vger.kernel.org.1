Return-Path: <netdev+bounces-147211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD569D83AC
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40BA16864B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C1192D63;
	Mon, 25 Nov 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H3Jzblyl"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123918B499;
	Mon, 25 Nov 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531357; cv=none; b=l7QLBb6LwD5N8GFcMo2BS52amJtuAFT9tgs31KWMbDsFFdrei8ZFvQPhWO1rsqjK3Qw/ULFwPSwWpSEhYVBU6pTykVvCdLo4CiyuQb1jb3sxs0miQYhT8Jy9l9Mu5xE1zlgxWfcc/83oYZvHLapEr67JO1YwOqth8zYowLmlwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531357; c=relaxed/simple;
	bh=fbpMpvjVz/B3/gOZ3/Dx6wnBM1U/va2affDskte7L20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5AszIvnQ0wGehb1WpynlvfjAn7Kz/wxO8G8W6fcn5VJjm6MigxVjAUqiE3IW+niMieFinL8VkUT9Z0sAZMFzYJA4jJmsagQ2X8tm4GMiBTHYb1lkHJX4wv881wZ/Sn5EuISaEOJBBVplwApPWarfVKs6FIo0e5DwtfxchtisVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H3Jzblyl; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3682DFF805;
	Mon, 25 Nov 2024 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732531345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYkzOa4MnjUz4uK1cDYjGX03QHpE8p3bHHaNXeGHxgE=;
	b=H3Jzblylc0gkjPvGQONGfpTa+TSVkNeZisD1TZWATE8JwhhlX7JJ5q5nTEDivZdkszd1k9
	OQV8WqLKghr5THynmwU/mr0fUpEYuimQ3lid8m+DtKVcnQJENGcQ3m0RmZODQxF1Gyp6vM
	r1AShug3FznQflssMbHzYMrgMmz9tPNxy1I0knFcPWPEUp+O8sUJB7h/bLe88W6F9c6UT6
	KLITVZf7P/zdffeIJ5Vn8kjKiFRBkbgDaPIoZYBNwpJ/irOmrVRu7UVHxnrq9PjfMorzmi
	POh2ggUsSJk9lRsZUTe7NMMiCZ3kdSGr/L+ZiuVVYKiSxsz3qvaQu4+WFB8BFg==
Date: Mon, 25 Nov 2024 11:42:23 +0100
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
Subject: Re: [PATCH RFC net-next v3 12/27] net: pse-pd: Add support for
 reporting events
Message-ID: <20241125114223.7aa1a1de@kmaincent-XPS-13-7390>
In-Reply-To: <Z0LxSnmQqrsCqJ-Y@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-12-83299fa6967c@bootlin.com>
	<Z0LxSnmQqrsCqJ-Y@pengutronix.de>
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

On Sun, 24 Nov 2024 10:26:34 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Nov 21, 2024 at 03:42:38PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add support for devm_pse_irq_helper() to register PSE interrupts. This =
aims
> > to report events such as over-current or over-temperature conditions
> > similarly to how the regulator API handles them but using a specific PSE
> > ethtool netlink socket.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> ....
>=20
> > @@ -634,6 +752,7 @@ pse_control_get_internal(struct pse_controller_dev
> > *pcdev, unsigned int index) psec->pcdev =3D pcdev;
> >  	list_add(&psec->list, &pcdev->pse_control_head);
> >  	psec->id =3D index;
> > +	psec->attached_phydev =3D phydev; =20
>=20
> Hm, i guess, here is missing some sort of phy_attach_pse.
> Otherwise the phydev may be removed.

I don't think so as a phy_device remove call will also free the pse control
pointer through the pse_control_put() function.
https://elixir.bootlin.com/linux/v6.11.7/source/drivers/net/phy/phy_device.=
c#L1045

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

