Return-Path: <netdev+bounces-61290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2013823169
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C91F244FB
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A931BDE6;
	Wed,  3 Jan 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avZqKUSp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436831BDCD
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5f254d1a6daso22540717b3.2
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704300150; x=1704904950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqB6CGz4FhyOFOssBdp4zvBdwCCulsiEvCo2tFN0c8g=;
        b=avZqKUSpV40gCfPgU1zk33tqmxI2LVpaTcIGXW/cL2e7x5yxQNm4LA7g21KvhlCNOS
         gsxsIGr26yy/a3hopEkFN8U6Mf87AfphaPVE/D2rvA/lDZcrUqkgxyuVDyGTuoKlm12b
         +oceCDbOoIPLg7xSEsELCng/F+3fRkxalKo9UerlRAwWSEjLRV5NCO4iCKLwsgVorAwE
         o7GjYZVAivc8K1RLu54R2BZy72AvefcyUAEMbTk1Pm6dMol2nVlFSmYCoCo5Cd3TYMeo
         QeKbgfEG8abBNsJZRHUTD4HtHM7jns2JoTpFm6xnwLY3zGU4lC4rGMxV6tJj2TOctiY2
         gy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300150; x=1704904950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqB6CGz4FhyOFOssBdp4zvBdwCCulsiEvCo2tFN0c8g=;
        b=VdIUZNnOopVKyZdVQhuKGdWgFoFu23jnjPtdeDfFEbu0qMlYAo4r8xRVH5jB7/5VUg
         ZfOXWLhZ3Wckc/BGj+SxGqqlVCZTUj8IK/TX481pXf1AtykpD2DlGCV2R6niSRr5I5KR
         22YfIK5J+L94QlcnoAWfIRBLPrc/lqF6FZOled4EtY8YY2557doXQ2fsUhM6fg+7u3o/
         Jnv6kBSYPC+C8qPLSr4MZQo+HFlUCpAcQH8mtcby/eM7x1RsqLXeCHcHcgAEC58N7+la
         CA/khjaiwZpubx5P0TSqgBAWw360C+e85QbwHQ0OSgEWbCtOXtPDPUtxsp3yPswD+C60
         riOg==
X-Gm-Message-State: AOJu0YxGi8Jgz5yBTDgA9wiAbmezd50HiNXFJKR10lhFxJ4xKBe4GScP
	+jm6ag4wZxYzYgaNDjTdH6rGPUotXj7NDvTaLBErnq/Bge9Fig==
X-Google-Smtp-Source: AGHT+IHG+3CJMzix7RqUcr1RTs3drNiVmJl0PBwHoasrhFF9x4L1y3cMk/tajLBq5aD9vYZ+fjVlbqGseYGu5CnZocY=
X-Received: by 2002:a05:690c:2848:b0:5ec:91e:9d68 with SMTP id
 ed8-20020a05690c284800b005ec091e9d68mr7280168ywb.18.1704300149634; Wed, 03
 Jan 2024 08:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102162718.268271-1-romain.gantois@bootlin.com>
 <20240102162718.268271-2-romain.gantois@bootlin.com> <CACRpkdZjOBpD6HoobgMBA27dS+uz5pqb8otL+fGtMvsywYBTPA@mail.gmail.com>
 <d3d73e26-10a9-bd2b-ff44-cbdc72e1f6ee@bootlin.com>
In-Reply-To: <d3d73e26-10a9-bd2b-ff44-cbdc72e1f6ee@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jan 2024 17:42:18 +0100
Message-ID: <CACRpkdbbPg0f0LSPrAhZ4cEajEx0W-FjkSjfZnJ_Lam-QQ=E2Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking
 COE on stmmac
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder <rtresidd@electromag.com.au>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 10:11=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> On Tue, 2 Jan 2024, Linus Walleij wrote:
> ...
> > > +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
> > > +{
> > > +       __be16 proto =3D eth_header_parse_protocol(skb);
> >
> > I made a new function for this in my patch
> > https://lore.kernel.org/netdev/20231222-new-gemini-ethernet-regression-=
v4-2-a36e71b0f32b@linaro.org/
> >
> > I was careful to add if (!pskb_may_pull(skb, ETH_HLEN)) because Eric
> > was very specific about this, I suppose you could get fragment frames t=
hat
> > are smaller than an ethernet header.
>
> Okay nice, then I'll rewrite this series to use the new function once you=
r
> changes make it in.

I just rewrote my patch to use eth_header_parse_protocol() instead.
I should not invent a new version of something that already exist.

> > Should we add an if (!pskb_may_pull(skb, ETH_HLEN)) to
> > eth_header_parse_protocol()?
>
> That does sound logical to me but I couldn't tell you what the impact on =
current
> callers would be. The net maintainers will probably have a better idea of=
 this.

I can propose a separate patch for this with RFC.

Yours,
Linus Walleij

