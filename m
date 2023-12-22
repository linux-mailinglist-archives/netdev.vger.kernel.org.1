Return-Path: <netdev+bounces-59981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0EB81CFAF
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 23:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94D7284FF4
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219402D035;
	Fri, 22 Dec 2023 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYCyIogO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4692EAFA
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc6eecd319so27804281fa.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703283178; x=1703887978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rvTXTkRcE6SrdWefcdC5W859bSKJE/cg6RfZJkk8i10=;
        b=TYCyIogOZ4B+LmF+wflP2/JadVgJjy9OgoVM6AwbA11rZG4MKpV6WbrKzR/x+bFuDM
         bVU3SJBmmfwzzSDQdPOdiwxsFNb1nOXz0/lUcURfZ4LCBSXPi5MBqrixWcksxylfQMAT
         ts3dbCHBzpJHdiDI4aWpSnZLKywZqqpkKZTJ0WUJ+m3UB/3jcYYanND1P4Bsl0nJH401
         +iGYS3wzLkZ8JV+nYhnzjVqT6c16HHH/UPI54rRsWog2xqLO1kQ4zsP6CNkN7gxqJ2Ol
         mqPC16uFjWbQCrKXhehsOmEHjulmIFDavqUINptwIFr7YawE/MhUroii9raNI7NenX+L
         XI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283178; x=1703887978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvTXTkRcE6SrdWefcdC5W859bSKJE/cg6RfZJkk8i10=;
        b=vRLukwfIJSUx1+bvxlqSms34JgRMCbhkvA0LCSXaOB6ksAfvy+mkGsaKjYWhownbUQ
         J825hGjMbYuBfNCFtMLefW3mA0MAGUe9WaVjadTydWcSdnDwEL8UBUaqyeehgOE8mBnp
         dyfvqGndgyhdpH3E3tFgObgIsEFpnSUsZ2H5iALJuX1iWxo0VLvTPNL51am7UeDqESGG
         /2dtR6363Ax1lJLIyk0kKZ97/E1aIP6wc+qyGa/qTtLcttDQaCcDg1heeIAr5psxTHyy
         z3K9a9MHZBhcRMKZEbFFHoGWpBRt2xt+MXDP9aoDRbndZeJOiwQvquqgcq8RAXqH1NFi
         5gHg==
X-Gm-Message-State: AOJu0Ywp8JpJUD4eOyfmGQXONazEx/ctDEQww7+J6IpS3qcG++JMwlrI
	2kpJSiHn4WuFnUirF/4XdgMKMttsdOVxoJfCGcU=
X-Google-Smtp-Source: AGHT+IH+MDdzyvC2ZmxIo13/gTe56MuPwzg+xhxu9lYHXqTwheC2jsAef75BQ61MqQnsOV7jzmDCsCarqRqQAwByPn4=
X-Received: by 2002:a05:651c:2223:b0:2cc:ae37:f8ad with SMTP id
 y35-20020a05651c222300b002ccae37f8admr919711ljq.3.1703283177341; Fri, 22 Dec
 2023 14:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf> <CAJq09z5zN86auxMOtfUOqSj9XzU-Vs8_=7UzfY-d=-N9dgAPyA@mail.gmail.com>
 <20231222220955.77j7nmvhbelv2t7a@skbuf>
In-Reply-To: <20231222220955.77j7nmvhbelv2t7a@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 22 Dec 2023 19:12:46 -0300
Message-ID: <CAJq09z4z_2mxTLCuojgLt5Sd_EMmB-O_RVP7mE85iaFW26geSA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On Fri, Dec 22, 2023 at 05:03:38PM -0300, Luiz Angelo Daros de Luca wrote:
> > > Having the MDIO bus described in OF, but no phy-handle to its children
> > > is a semantically broken device tree, we should make no effort whatsoever
> > > to support it.
> >
> > OK. I was trying to keep exactly that setup working.
>
> Which setup exactly?

Ports without a phy-handle. But, as you said, it is a broken device
tree without a known device using it.

> > Should I keep the check and bail out with an error like:
> >
> > +       dsa_switch_for_each_user_port(dp, ds) {
> > +               phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> > +               of_node_put(phy_node);
> > +               if (phy_node)
> > +                       continue;
> > +               dev_err(priv->dev,
> > +                       "'%s' is missing phy-handle",
> > +                       dp->name);
> > +               return -EINVAL;
> > +       }
> >
> > or should I simply let it break silently? The device-tree writers
> > might like some feedback if they are doing it wrong. I guess neither
> > DSA nor MDIO bus will say a thing about the missing phy-handle.
>
> FWIW, it will not break silently, but like this (very easy to test, no need to guess):
>
> [    7.196687] mscc_felix 0000:00:00.5 swp3 (uninitialized): failed to connect to PHY: -ENODEV
> [    7.205168] mscc_felix 0000:00:00.5 swp3 (uninitialized): error -19 setting up PHY for tree 0, switch 0, port 3
>
> If you have no other decision to make in the driver based on the
> presence/absence of "phy-handle", it doesn't make much sense to bloat
> the driver with dubious logic just to get an arguably prettier error.
> I'm saying "dubious" because my understanding is that rtl8365mb "extint"
> ports can also serve as user ports, and can additionally be fixed-links.
> But arbitrary logic like this breaks that.
>
> The cost/benefit ratio does not seem too favorable for this addition.

OK, I'll remove them. Thanks.

Regards,

Luiz

