Return-Path: <netdev+bounces-79128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76570877E91
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31700280F04
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670A381DA;
	Mon, 11 Mar 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="uX8e0chV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7918383A1
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155005; cv=none; b=pek27OC0lzeCIepboWaKwrTDl10dlrQxqybE/gCzsq50fzVGC8PYlma1qL/TjxnZiHLH9YpkqPPd423DO6ZMAbLDYXaaFtVwD1jVKzDAWV2MLKyRpfWgNoEYG0trHFiyROG/oO6GglrcOJ+iOIdItCM9f2XakfJwo75BNaSrzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155005; c=relaxed/simple;
	bh=gQkrDPxpS2EqSQo1lFnVAl0v8qesDjjlj8YPz5bYqM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc6YlmCAZsCkPFAtQwwLLWMHb6Gvsv8QdBYzkf7LRNpWdewHqycOxhrQYbUjGstc8pf57JPVCjKLj0sCTkq+T6e2I7xBug2VL9rRsseQW/9QHRI7nfe6Rs9nfeDGdz95tZ+R+JrbWUiusCbU9rwYy25Ci1kVPnC5hSXWwmkKr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=uX8e0chV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513b022a238so464537e87.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1710155000; x=1710759800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+eJcaivf1oVvQVDFOxNL/y8v7xDssxtOMnaOKKnTqo=;
        b=uX8e0chVZg5wXdYofGbhN9Y9D2w1psaR+zO5VF5V8hx3ee5G5xRpJRY53RcVdUpNKq
         DIfS7I6UTJRAn6BH+vAPi7S/YGFTmZpUttt0TVgQ/hbCYnSzjIgCEfPHM12aa97S75qQ
         73KaAVo7JojfatlTTxQfHk04xiFp12ueiNgsMhs/kYFhB4dL42H16xP2Ewv0q4midFz1
         DQEr7vFm0ktsbuNyQRKwUbhh8Jefje1fTeUVonxbORI8voQrOzqlpuQhuCDtmNvIiBLH
         ElGKTmMJHYjiZnoLdwxTUGqXyyDlzO27SD7qoaCYwb3yZXhBwsXMHM+ViRo04eoAl5F4
         oPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710155000; x=1710759800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+eJcaivf1oVvQVDFOxNL/y8v7xDssxtOMnaOKKnTqo=;
        b=PIfIfIWeI0tD2V7jCoIxeLz5FEcOR6leruWh3Q6Uidx1/5SgFWi8mLZfhj+P8i7rJZ
         LAT74i1OjUjzKPobgtpzq4dbajNU/yc8UtfqFLHggTXDhZBfACQ75dcie49Rs8CsB05k
         7bt0KP/p7LB32z6n7pdHqWjIp/T2XwKVrG9XqBY3oTprE5F2rPUAWd9R+ll7VuqzBsSh
         NNB+tMlYoKGzw2bk5d3uYFXoRglUAaVI0puD+7XLcWtF07F4lPybpFUa9rNHO7jZQBMs
         yylIWcN38+4hOAgphVCHTakEnyEvvHgOKZBhme6MxRfQEUUE8pHz0Vnhcap6mZ0Lg9L9
         bA4A==
X-Forwarded-Encrypted: i=1; AJvYcCXAk8HkHNSqn1WSwvrYe9o5ZWsk97YFMiZ3/robKyumwqzXVpW+MkgtgdpvA88OKBiGACGuskDLAVZwDkT9tM0SavM3J8XZ
X-Gm-Message-State: AOJu0Ywh+jsenmOgMB+sz3MYmIbMa1YgLyiyABqQtIQvIPojEh9JQUbG
	UXttNoOg1jesCrRSHHRs9PSLuWpojydsaYHAa8EmBdswmpmwo1eRh9eyNHkg2s8=
X-Google-Smtp-Source: AGHT+IHCeW/KiGNKh5pnO8aDXhMpbBef+uHHSz0cnNkmQDkNzqVeAL6zbpqGWin1+BefNMGf1qyY2g==
X-Received: by 2002:a05:6512:3e19:b0:513:2b35:2520 with SMTP id i25-20020a0565123e1900b005132b352520mr3581022lfv.58.1710154999925;
        Mon, 11 Mar 2024 04:03:19 -0700 (PDT)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b005139c3c584bsm989738lfs.241.2024.03.11.04.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:03:19 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:03:18 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 2/2] ravb: Add support for an optional MDIO mode
Message-ID: <20240311110318.GN3735877@ragnatech.se>
References: <20240309155334.1310262-1-niklas.soderlund+renesas@ragnatech.se>
 <20240309155334.1310262-3-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdVRftTVMmnBX9YH50jau-GJEM+Lmq8tVh2ynrCRsZU46g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVRftTVMmnBX9YH50jau-GJEM+Lmq8tVh2ynrCRsZU46g@mail.gmail.com>

Hi Geert,

Thanks for your suggestion.

On 2024-03-11 10:32:35 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Sat, Mar 9, 2024 at 4:55 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The driver used the OF node of the device itself when registering the
> > MDIO bus. While this works it creates a problem, it forces any MDIO bus
> > properties to also be set on the devices OF node. This mixes the
> > properties of two distinctly different things and is confusing.
> >
> > This change adds support for an optional mdio node to be defined as a
> > child to the device OF node. The child node can then be used to describe
> > MDIO bus properties that the MDIO core can act on when registering the
> > bus.
> >
> > If no mdio child node is found the driver fallback to the old behavior
> > and register the MDIO bus using the device OF node. This change is
> > backward compatible with old bindings in use.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Thanks for your patch!
> 
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -2582,8 +2583,20 @@ static int ravb_mdio_init(struct ravb_private *priv)
> >         snprintf(priv->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
> >                  pdev->name, pdev->id);
> >
> > -       /* Register MDIO bus */
> > -       error = of_mdiobus_register(priv->mii_bus, dev->of_node);
> > +       /* Register MDIO bus
> > +        *
> > +        * Look for a mdio child node, if it exist use it when registering the
> > +        * MDIO bus. If no node is found fallback to old behavior and use the
> > +        * device OF node. This is used to be able to describe MDIO bus
> > +        * properties that are consumed when registering the MDIO bus.
> > +        */
> > +       mdio_node = of_get_child_by_name(dev->of_node, "mdio");
> > +       if (mdio_node) {
> > +               error = of_mdiobus_register(priv->mii_bus, mdio_node);
> > +               of_node_put(mdio_node);
> > +       } else {
> > +               error = of_mdiobus_register(priv->mii_bus, dev->of_node);
> > +       }
> >         if (error)
> >                 goto out_free_bus;
> >
> 
> Perhaps the code should be streamlined for the modern case?
> 
>         mdio_node = of_get_child_by_name(dev->of_node, "mdio");
>         if (!mdio_node) {
>                 /* backwards compatibility for DT lacking mdio subnode */
>                 mdio_node = of_node_get(dev->of_node);
>         }
> 
>         error = of_mdiobus_register(priv->mii_bus, mdio_node);
>         of_node_put(mdio_node);
> 
> When deemed necessary, you can easily replace the backwards
> compatibility handling by error handling later.

This looks much better, will do so as well as s/OF/DT/ in the commit 
message for next version.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Kind Regards,
Niklas Söderlund

