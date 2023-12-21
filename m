Return-Path: <netdev+bounces-59437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAF81AD69
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9BF1F2194A
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A1441A;
	Thu, 21 Dec 2023 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp5YNDY+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ACC4C64
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so3252571fa.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129121; x=1703733921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOzznX4Vz+MqK5F3bho12ZapwOO6rykchAEb63hPQ0I=;
        b=gp5YNDY+h1ErluIfQ6ziCiXzXhTKGkdeOtAuCIX7rsHcyzSBMDaKL0CCpLX0JKhaBa
         BrZ8QKl7EGRIRKScCMRPACjIF+OJu3Onnez1/6P06iZJxVoBKZAGnlrTIVaS1UR7DeWu
         KG6NJnlam41wBxxs5gw/oGJJVh8DsTMneHbftwIKWhM5+DCs1RgAtlhvYZthZ9Oq7bcv
         LJATPW0QYmqoLvttxpvkBNPqFm352fZ3Oq3NenoCyzj+dTNd1Akg0WfCCoUMTO6MG5RT
         R/yYJGDouwMPfSxETd6P3cEMWj4/d8nHW+GIaunryp5pzGgxXixC7Ci3VA403+dJWuaW
         Id7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129121; x=1703733921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOzznX4Vz+MqK5F3bho12ZapwOO6rykchAEb63hPQ0I=;
        b=S98Z/LPkjY/mjFin2qUl6va349Yi9g5fveYKKjaUirH9zaKSUZqDZbPJlUKKOgmsv9
         zIGW5d43uJTsx9iz7EqUX7X4SQo7aEcCNEqeGkr7goEYCajuEkvyGJ3EIbYSa3U/xdLV
         Ckhqi+q8l0/p11BbpkvZp93EehmwxmHs91Iw7lIXlhcd4EHJX+yMwCumV829F6LliPjR
         Yrjy/x7R4Zv95dEzvHcxTOI8rqmq+eJ8QLQmRR0ecc6YN/aSLPvB/rfcoMba49GSwXfH
         foiLdDIIqR1Uqj3NBcwtqVphuImBTAT2EYecyNg2PiYsTuWVDdgPjuwQUFCwh5U278nj
         qNaQ==
X-Gm-Message-State: AOJu0YwhCLFTY89hpmADReXjeuKfY8kMZ+IlA7JvvoJrRvoKm3stivJj
	p4NQExlDQ2dWytmA+nxyc3TS+S7V1xuXjnRbxp0=
X-Google-Smtp-Source: AGHT+IEmbkayrBEn3qqgdNGUkQGWKb+aa1gSXnZ6uQbsuh1WKXNFav8shyuG/zhS+uzy7OAhwrsUcu2tlyxpfHTG4XM=
X-Received: by 2002:a2e:8495:0:b0:2cc:5d33:c0bb with SMTP id
 b21-20020a2e8495000000b002cc5d33c0bbmr16512ljh.20.1703129121114; Wed, 20 Dec
 2023 19:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-4-luizluca@gmail.com>
 <m7aqhrk5zydicvxdrl225tcgwe5g3esu27mafoee7pqjitjnzs@5ldkbzqmmpte> <o3c4fxt5xtabsgdg6oz4qyy6rvc7l5qojl65hvd2x2zxyz34bn@7vjv6obs6rgk>
In-Reply-To: <o3c4fxt5xtabsgdg6oz4qyy6rvc7l5qojl65hvd2x2zxyz34bn@7vjv6obs6rgk>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Dec 2023 00:25:10 -0300
Message-ID: <CAJq09z5zupqd-p_rD4-WfpAhYi-Ny6QeR4PD7LbUV=UbnX_gBA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/7] net: dsa: realtek: common realtek-dsa module
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > > +   /* TODO: if power is software controlled, set up any regulators here */
> > > +
> > > +   priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > > +   if (IS_ERR(priv->reset)) {
> > > +           dev_err(dev, "failed to get RESET GPIO\n");
> > > +           return ERR_CAST(priv->reset);
> > > +   }
> > > +   if (priv->reset) {
> > > +           gpiod_set_value(priv->reset, 1);
> > > +           dev_dbg(dev, "asserted RESET\n");
> > > +           msleep(REALTEK_HW_STOP_DELAY);
> > > +           gpiod_set_value(priv->reset, 0);
> > > +           msleep(REALTEK_HW_START_DELAY);
> > > +           dev_dbg(dev, "deasserted RESET\n");
> > > +   }
> >
> > I simply cannot understand why you insist on moving this part despite
> > our earlier discussion on it where I pointed out that it makes no
> > sense to move it. Is chip hardware reset not the discipline of the chip
> > variant driver?
> >
> > Why don't you just keep it in its original place? It will make your
> > patch smaller, which is what you seemed to care about the last time I
> > raised this.
> >
> > Sorry, but I cannot give my Reviewed-by on this patch with this part
> > moved around.
>
> Well, to be fair, your original goal was to add support for reset
> controllers. And Vladimir pointed out that you end up with a lot of
> duplicated code when doing that. And he has a point.

Yes, it ended up bringing many more issues, like the driver dependency
direction, duplicated compatibles, and so on. Even issues with the OF
MDIO API and other drivers. However, at some point, we need to stop
adding stuff to the series or I might start to sign-of-by as Sisyphus.

And I still want to take a look at the LED code, which is not working at all.

> So on reflection, I think this part is OK for now. Then you can then get
> unblocked and put your reset controller patch on top when you get around
> to it, without the code duplication. I think code can be adapted to
> support regulators without too much churn. I'm sorry for the overly
> negative feedback.

It's OK. You are just reviewing the code considering what you want to
do on top of it but we need to focus on what makes sense as it is now.

Your reviews are always fruitful. Thank you, Alvin.

> But please have a look at my comments in patch 5, since they apply more
> broadly to your series.

I already did. :-)

> Kind regards,
> Alvin

