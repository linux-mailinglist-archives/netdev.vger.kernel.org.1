Return-Path: <netdev+bounces-147221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E129D84A1
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 12:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FA8169D80
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4C1991C1;
	Mon, 25 Nov 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ia8UlVIT"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2A192D91;
	Mon, 25 Nov 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534748; cv=none; b=Awh1mrj1QXIOisju9KkeosVwJsMpRhKPt+w2ULLpuXwivIFN4FMS2IwAyHaJKidoqUlJVKvmZJIwdG244eepCFPRhAJY5CtGipobhHBve2yaVXrKh2dUm+YblydiZWIQwxHuxYYf55+1u0oy/vkLURufF06N838kbGFNzq5z8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534748; c=relaxed/simple;
	bh=r25yqzzOd7GcseCY5t0dfpTuxI0xYKpyNKx4CD1udpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgySTIVmHiQUrRje9Uk6eM/alnZtFvbapyu8Wlz+1fpvCdGDe90xGghvKXf0/mr75q9TnlzNdQnq4wnDa38de5aZ8D5HhL3NjI62kZMceKD4Ekr68H8j5MjpMJ/9spw3DfQer+EFB/5QlpO57MqQZ5PDaQSB6bynGb0ZI70W5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ia8UlVIT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9111C000B;
	Mon, 25 Nov 2024 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732534744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r25yqzzOd7GcseCY5t0dfpTuxI0xYKpyNKx4CD1udpA=;
	b=ia8UlVITv+yif5FYFLWcxVy9CMkHCYM1Xm8OtGkOhFKFZ6sG9QeNKyrgMR23a9byv9GorV
	uieFPUwHrdbTjAT+oHT/2vWmJ+flpMNaMGph9v0TVVJcR8380jUb5TC2OBgrF54kNV1jh7
	O6qkMiszSkrrsa+DLxXz6fC+jzsEV71PPiWPgzGpYJAsL3aMdeww+vMq7wWPvRhkyuDE8m
	2FnbKOw+U5USIJhgb4rGTb2UpdrXjRk5LJye5YONhiZ//0xOmMMdU8EDLCK0Lt3VY9tISp
	NReQAF4pMyoGlaULHHLQV71OhjVjQBo1sPWOWyUSS+IQfK5nNJ2eJIaCFCsoRw==
Date: Mon, 25 Nov 2024 12:39:00 +0100
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
Subject: Re: [PATCH RFC net-next v3 14/27] net: pse-pd: tps23881: Add
 support for PSE events and interrupts
Message-ID: <20241125123900.20157627@kmaincent-XPS-13-7390>
In-Reply-To: <Z0LzDE8cYdbvx79o@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-14-83299fa6967c@bootlin.com>
	<Z0LzDE8cYdbvx79o@pengutronix.de>
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

On Sun, 24 Nov 2024 10:34:04 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > =20
> > +/* Convert interrupt events to 0xff to be aligned with the chan
> > + * number.
> > + */
> > +static u8 tps23881_it_export_chans_helper(u16 reg_val, u8 field_offset=
) =20
>=20
> What is the meaning of _it_?

Interrupt. I will change it to irq ;)=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

