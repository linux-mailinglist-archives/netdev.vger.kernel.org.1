Return-Path: <netdev+bounces-96778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938768C7B25
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30A6B22128
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E8156642;
	Thu, 16 May 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euvbl+qD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE6143C4A;
	Thu, 16 May 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880642; cv=none; b=GHIw3o+rN/E0D4TygfhAnFFPIm5XNeQpUJqxlF81V7QDfmL7WWI3IzEcOb558chQCxaQ80ZOyFg9WJaPvQ7KtMErE2Ac8jirBp0PHHw5QdeEsT9/tJdL3N04Yq7Dq8QmwnsDVtF9MEluoVWj7Ws/Qz4CHm4gMRHhRnOw9QKriNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880642; c=relaxed/simple;
	bh=sHmct3ycjOIA6IzRZXQuEN3LCSJ/X/Fb9HJyVK1LwX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6UKDfiVvPdY8EapsR1rxS/t26wkOY4WDkG4Q/4lhecy2VMcmfTbzxLZx/IdHSPPJXcnmNRwzXa36v8fkxeIsFV8W5b61HqQcKbWLQNnAVUUMHJdATXd4w3eRgYWwnwi6dp0kQpoDBZw/d32iUF2s15btbUEkgUsiAH4+lwNtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euvbl+qD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e7078a367eso6519451fa.0;
        Thu, 16 May 2024 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715880639; x=1716485439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SAMG08H3yiJiWQMEgiwa1OP1tw3ZMlEFual3rzKXv94=;
        b=euvbl+qDZX2KS/lOv3CQC4h3jVwsx9xz45z6s5H/x5WnBM6XlWg5R9oqEDy7VvE0qU
         VRZ08ttpl3NsJK3Tx5Ry67TZGOdn7WkS12jC4XzKOjIi54zqwz/8GT3hRnbuLUvpTjGV
         hf/qr67c7QvTmdAn42DqcZGZ3YFwK01QgdkFr5dfsD9itDdLL8YWSnfWnP8I7NrQUJG0
         EE6nq5LcG5aFMM6pRdQgYUT2AMRIlutBQSUDX4p+ii60lfZCzxj8NujGphAciss+pnwZ
         SPpMWNnyZZjrEfuO3r+x1+rTikpx8zh37j6wYlwmoqs9rgVecLIukSZNU1N0XRorLkwi
         SZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715880639; x=1716485439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAMG08H3yiJiWQMEgiwa1OP1tw3ZMlEFual3rzKXv94=;
        b=vTVx0EPVJvQe6NeOh6Y5tjjavLbvs7jUY4nj+nA2n/elVvFk0EsU4c8ZxDjqKnh5qe
         eGxoHl4+wz/9OVH6uL2aMHclRIBA18kmrRwp/UU1UgDD2JTCfFzpRh1wgVs+r3zFc/Gh
         1BgQmtoK/hsO40rCkDxqLA38xMtvYKJmiJhN4QJWqJellN53V7/YxprcROXfBn8T1qy4
         VW1o7O2VuNL40JvLxoKEp9/nQkvnM3ZFlqiDqbCY9oWBHsZxL+xIYUGWWrRyCfHNfDY8
         04uPW9GP5ajpDQx/RWJlJYMLSFQiqrwieAJptCUqzSvWubG8QA59F1Sw/63cD7x5ZbUx
         CPCA==
X-Forwarded-Encrypted: i=1; AJvYcCXLk6sbkiJpZP4aNsBxOEmFxQr3NTFXDMP01zwM3LJJvoJvCWLcVkwDL83V+9sdgcyB1527R+ujuhYNoat/9xbEBu4apxBMWxeFI5+Isn1BD+RM1wVYri1lilHxudM8sulO5ECdsCRyGnWr48P3lKeRgEJJJLlRrq6blh/USwPmqA==
X-Gm-Message-State: AOJu0YykBaXJdgL+NOKB5DbFLR/30/3NiJPGbBeOmjdc73qAk/05dvOk
	O+BU81CFq6ygty/cKEXJAnkLIe1TDzG98fLdH/fr/NUcwj1b1aEU8w0d7KPCafRsUWH3y6RubtC
	J3hJb3APuraSuyaBKhT2mvj+AW/4=
X-Google-Smtp-Source: AGHT+IFHa2k2P6yK5ONqm5TLzGqT3ljZplb/ngDQ317Bk4BL8/Gd4RFJeTqm0U/JQE9gOfSSuBLfWCLhCZYia3T2+zA=
X-Received: by 2002:a2e:9448:0:b0:2e2:6dd9:dd8a with SMTP id
 38308e7fff4ca-2e4afc25d1dmr71185301fa.0.1715880638775; Thu, 16 May 2024
 10:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
 <20240427-realtek-led-v2-3-5abaddc32cf6@gmail.com> <20240429063923.648c927f@kernel.org>
In-Reply-To: <20240429063923.648c927f@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 16 May 2024 14:30:27 -0300
Message-ID: <CAJq09z6kBRXKG6QVyfUO6qzKaOZL6sbRnNXu8aT+siywjX7xLg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: add LED drivers for rtl8366rb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Sat, 27 Apr 2024 02:11:30 -0300 Luiz Angelo Daros de Luca wrote:
> > +static int rtl8366rb_setup_leds(struct realtek_priv *priv)
> > +{
> > +     struct device_node *leds_np, *led_np;
> > +     struct dsa_switch *ds = &priv->ds;
> > +     struct dsa_port *dp;
> > +     int ret = 0;
> > +
> > +     dsa_switch_for_each_port(dp, ds) {
> > +             if (!dp->dn)
> > +                     continue;
> > +
> > +             leds_np = of_get_child_by_name(dp->dn, "leds");
> > +             if (!leds_np) {
> > +                     dev_dbg(priv->dev, "No leds defined for port %d",
> > +                             dp->index);
> > +                     continue;
> > +             }
> > +
> > +             for_each_child_of_node(leds_np, led_np) {
> > +                     ret = rtl8366rb_setup_led(priv, dp,
> > +                                               of_fwnode_handle(led_np));
> > +                     if (ret) {
> > +                             of_node_put(led_np);
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             of_node_put(leds_np);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
>
> coccicheck generates this warning:
>
> drivers/net/dsa/realtek/rtl8366rb.c:1032:4-15: ERROR: probable double put.
>
> I think it's a false positive.

Me too. I don't think it is a double put. The put for led_np is called
in the increment code inside the for_each_child_of_node macro. With a
break, we skip that part and we need to put it before leaving. I don't
know coccicheck but maybe it got confused by the double for.

> But aren't you missing a put(dp) before
> "return ret;" ?

dsa_switch_for_each_port doesn't get nodes. So, no put required.

Regards,

Luiz

