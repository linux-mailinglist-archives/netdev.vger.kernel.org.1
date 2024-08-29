Return-Path: <netdev+bounces-123524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546F9652C9
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFE02849F0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B11B5EDB;
	Thu, 29 Aug 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC3/FNGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B118B479;
	Thu, 29 Aug 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970020; cv=none; b=XEnIyvU0scu2jkr0pXeF23OQ5aYLVY9Hg727b6cVHAZalYNFRKA//uS28cNVCSz7w0nk+fAh4JSMoIqemlbGetBnnHLrP7ZQ9SE4IseStzKfLtWQFhUSOaB1Gi7afCnRMm6se3AxA/23Jh212LDoHEES45s0yVTnjklDxedKZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970020; c=relaxed/simple;
	bh=UDORaHvAN7S3yc9tW4mZMSnJAbxzblHMs30iSNOwhoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9M+NNEM/HGX3TnK4UtJoZoMnJlCaFc5DHJfjEJk56QuT3OApvNJW4ae12jaF4q/aUHkM/KlWk3RddMqCILMlfJXW2kFQgseKjLmElUUIu6zKKvvA+4EwLTEbThrxuvPOvh7A1TxAoWlc8yK2eQAZce2NwJZEYuQuPjFOson4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC3/FNGw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5353d0b7463so2163415e87.3;
        Thu, 29 Aug 2024 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724970017; x=1725574817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRGrTDKjDwHQeb9wkPVV5Mt+a0Du/e6zQoQAuS3WCHI=;
        b=PC3/FNGw6IeSG/JvauVu/W8Vc0NEZs8vMD5BG2MnnEg6PFlv1QzhYQqjZzaqFTzdxF
         Aw5mVTPYqfeMZparEkfSrlI42d8510cUxPO01dRo4yp8GkmIi2GZ2oX8kUOT0/0y0LS6
         vMAXcyxd3gnigcGV9X1+t4pboK6HeFnr0WRhEx7bsgIfjXd0Uj1HnEwoxkC0LY95cv5G
         R+J4+IFU9p9W1/JmNYdlSg8ljPkdca96NRChlQcZzxM44fyFVKEN/s/9NukfLEjbZW+M
         8V5GAEuRv75xCRQEXwB6oWeGodCBMJeUIfMf+Rv7gZBM7XsvwycwN8fe9s75SfUPpFeJ
         pIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724970017; x=1725574817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRGrTDKjDwHQeb9wkPVV5Mt+a0Du/e6zQoQAuS3WCHI=;
        b=TazkgVi/3RdprUjG1VoHPIqMghBqLLOmYzsqUhTbYtv0b1kL1AEGAIa5LzO7MDi6Bn
         yBQ/l/W0jOwkm4Kjh90AZRW+71V7i6MHuoxsOW5mGn5mQN53gPXZ0pXYP7c2EQ4dLQhD
         rBAJKO8M7rRGgityZxVCSAuuU6qPOrH2Hq+PZqMD5L8Vfjw6pp2HqJi/GIIa8kVlq1pj
         P1McmHD/mQP6msYLeKtrGw3vMbJiomquYqzZK9fUUKXIB5+SgpI93VUrkd8N2V7ieWyt
         jqqYIRiHg4ReV0oXAiWx/a9Hc6r/MWPEy5ODZD2L2v7Wwz77G7+OH44/a32B/3gjbV3z
         O+5w==
X-Forwarded-Encrypted: i=1; AJvYcCX+1frR17udRJr0Hkod6jycwDT/lKbQuOd0rl98kQ3kbRfsXWE43G/UsASDvQ4+UR4zbIGcA1nF@vger.kernel.org, AJvYcCXdvshXECKOrvdajnrjPokcRdpkHXTg7qD8J9+cHO46QhOMC1Qk+AP/t5RxWQJ+pOSyL+SHPp6DPiZcI8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/kC/Np1IZe68jAjHBvbHwrN9lOaS6J3tJqXygKx+mDhI1JsS
	t55+PSREuYbK+qYpg2DvE96x4EhGiGWAZBONHfEAXP25wJ7Q4ey5zkEfNYByJNjnl/jXs5/OtQf
	CWc1ubMA9dmuCM3Lp387hCqGfAWA=
X-Google-Smtp-Source: AGHT+IGeOo6Fnay+28SkVGmqj5xc7t/rED5v7GH0KaG/tn2nYGCHhZtfFa7d2JSpqiC88PrN/TtCh/rGR5/EHzwRnWY=
X-Received: by 2002:ac2:4c45:0:b0:530:b773:b4ce with SMTP id
 2adb3069b0e04-53546b5a1dfmr42454e87.33.1724970017043; Thu, 29 Aug 2024
 15:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826212205.187073-1-rosenp@gmail.com> <20240827161258.535f8835@kernel.org>
 <CAKxU2N-SDtFCrXWDc_2fGKSjosjBg=s4PJ2ztETrocTDo75ayQ@mail.gmail.com>
In-Reply-To: <CAKxU2N-SDtFCrXWDc_2fGKSjosjBg=s4PJ2ztETrocTDo75ayQ@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 29 Aug 2024 19:20:05 -0300
Message-ID: <CAJq09z6JvN4t=xSsxAY97FAtkL2YfkVCGJ6G5YA_PTsC=jFtHg@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
To: Rosen Penev <rosenp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Tue, Aug 27, 2024 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 26 Aug 2024 14:21:57 -0700 Rosen Penev wrote:
> > > Currently, the of variant is missing reset_control_put in error paths=
.
> > > The devm variant does not require it.
> > >
> > > Allows removing mdio_reset from the struct as it is not used outside =
the
> > > function.
> >
> > > @@ -683,6 +682,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
> > >       struct device *dev =3D &ag->pdev->dev;
> > >       struct net_device *ndev =3D ag->ndev;
> > >       static struct mii_bus *mii_bus;
> > > +     struct reset_control *mdio_reset;
> >
> > nit: maintain the longest to shortest ordering of the variables
> > (sorted by line length not type length)
> >
> > >       struct device_node *np, *mnp;
> > >       int err;
> > >
> > > @@ -698,10 +698,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
> > >       if (!mii_bus)
> > >               return -ENOMEM;
> > >
> > > -     ag->mdio_reset =3D of_reset_control_get_exclusive(np, "mdio");
> > > -     if (IS_ERR(ag->mdio_reset)) {
> > > +     mdio_reset =3D devm_reset_control_get_exclusive(dev, "mdio");



> > > +     if (IS_ERR(mdio_reset)) {
> > >               netif_err(ag, probe, ndev, "Failed to get reset mdio.\n=
");
> > > -             return PTR_ERR(ag->mdio_reset);
> > > +             return PTR_ERR(mdio_reset);
> > >       }
> > >
> > >       mii_bus->name =3D "ag71xx_mdio";
> > > @@ -712,10 +712,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
> > >       mii_bus->parent =3D dev;
> > >       snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->m=
ac_idx);
> > >
> > > -     if (!IS_ERR(ag->mdio_reset)) {
> > > -             reset_control_assert(ag->mdio_reset);
> > > +     if (!IS_ERR(mdio_reset)) {
> >
> > Are you planning to follow up to remove this check?
> > Would be nice to do that as second patch in the same series
> I actually have no idea why this is here. I assume it's some mistake.
> I don't think it's meant to be optional...

{devm,of}_reset_control_get_exclusive() will return an error if the OF
node is missing. If it should be optional, it should be
devm_reset_control_get_optional_exclusive(), which would return NULL
if it is missing.

The equivalent driver used in OpenWrt does explicitly make it
optional. https://github.com/openwrt/openwrt/blob/4646aa169986036772b9f7539=
3c08508d20ddf8b/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71x=
x/ag71xx_main.c#L1532,
while the mac_reset is mandatory. They might have a reason for that or
maybe only heritage from Atheros AG7100 driver.

> >
> > > +             reset_control_assert(mdio_reset);
> > >               msleep(100);
> > > -             reset_control_deassert(ag->mdio_reset);
> > > +             reset_control_deassert(mdio_reset);
> > >               msleep(200);
> > >       }

Regards,

Luiz

