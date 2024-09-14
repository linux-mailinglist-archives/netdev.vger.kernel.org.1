Return-Path: <netdev+bounces-128303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94985978EFC
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18799B262A9
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 08:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632EF12D75C;
	Sat, 14 Sep 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E11eIdHm"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1F43ADF;
	Sat, 14 Sep 2024 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726300877; cv=none; b=lTTZ/nc12Ot8KttsD/CmAZhXG+h4bSGq42d1oEpbgxz3tIMbdmZIE4NlRXn9dsvrDEE+awbtlCqjAbie53F2P2OuKR0d9sFp8Kifc+ZUoJ5M5ZCwQz3wt9M+sb29GydWid9gDHnSQjsji/cvXwVfPfAvPJxNM9Y43yg46vZs3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726300877; c=relaxed/simple;
	bh=8zW3qHATwHmhh62Rt3t1nuvcqJ5Ef2QgDF5Wc6yLSjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuywPRxpp8ENXVTdPVmiWKl6ock1ofku9jb12qeDaeRsPl9L6BreI6+rAnHFAvKduYU9JtkoNnZIEoVZl8dv/ePJRI/9BR3vHnHj4fvl22oH3NQglq/O9Gk23/t5Y2DOYlWOTLV1Xsoi7AyYgv+D5jaWP1OtsC91ouTHKfeBge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E11eIdHm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C0BF1BF204;
	Sat, 14 Sep 2024 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726300866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UTzwRfMDy5HUNy5t2BEx5nu4xKFJUQAXBDNug6N3+I=;
	b=E11eIdHm8uer8IY6NePNlmJm3NGTsjxqY6GGUbB9EAf+cI248nxxM7A1Fm7uafMUF5py8s
	4vmc4RMyl+1XQFnRUF2g+DFJqckPPeNA8ErIn4WZNqHi3NotlJg7fozFB+3uRPhhI2uTBc
	GePcRZUoddDQ00M80cSJXDCWFEPlD+OREATmKZWkHEUcDbyphuMznihlPA0L6YlOnJd3dE
	hoAFHk/Stu53BxfZM+QQQ7OmikgjpwoxGFeT+89iG5t6EBmG7Jy2sEkdhBT0jLPPxZKZjm
	UC0BxC3sUWpha4hHYy2lMGYwxjgJuOe5VfnQQh+AvC02nnShzT2VJHq8wL4Hgw==
Date: Sat, 14 Sep 2024 10:01:03 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Herve Codina
 <herve.codina@bootlin.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 7/8] net: ethernet: fs_enet: simplify clock
 handling with devm accessors
Message-ID: <20240914100103.37970b03@fedora.home>
In-Reply-To: <4e4defa9-ef2f-4ff1-95ca-6627c24db20c@wanadoo.fr>
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
	<20240904171822.64652-8-maxime.chevallier@bootlin.com>
	<4e4defa9-ef2f-4ff1-95ca-6627c24db20c@wanadoo.fr>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Christophe,

On Fri, 13 Sep 2024 22:24:28 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 04/09/2024 =C3=A0 19:18, Maxime Chevallier a =C3=A9crit=C2=A0:
> > devm_clock_get_enabled() can be used to simplify clock handling for the
> > PER register clock.
> >=20
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >   .../ethernet/freescale/fs_enet/fs_enet-main.c    | 16 ++++------------
> >   drivers/net/ethernet/freescale/fs_enet/fs_enet.h |  2 --
> >   2 files changed, 4 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/dr=
ivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > index c96a6b9e1445..ec43b71c0eba 100644
> > --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > @@ -900,14 +900,9 @@ static int fs_enet_probe(struct platform_device *o=
fdev)
> >   	 * but require enable to succeed when a clock was specified/found,
> >   	 * keep a reference to the clock upon successful acquisition
> >   	 */
> > -	clk =3D devm_clk_get(&ofdev->dev, "per");
> > -	if (!IS_ERR(clk)) {
> > -		ret =3D clk_prepare_enable(clk);
> > -		if (ret)
> > -			goto out_deregister_fixed_link;
> > -
> > -		fpi->clk_per =3D clk;
> > -	}
> > +	clk =3D devm_clk_get_enabled(&ofdev->dev, "per");
> > +	if (IS_ERR(clk))
> > +		goto out_deregister_fixed_link; =20
>=20
> Hi,
>=20
> I don't know if this can lead to the same issue, but a similar change=20
> broke a use case in another driver. See the discussion at[1].
>=20
> It ended to using devm_clk_get_optional_enabled() to keep the same=20
> behavior as before.

After digging around, there appears to be some platforms that don't
have this clock indeed. Thanks for catching this, the optional is the
way to go.

Thanks,

Maxime

