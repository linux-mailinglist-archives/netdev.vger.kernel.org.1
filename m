Return-Path: <netdev+bounces-207369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E5B06E51
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6001B4A3BDF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0A28982E;
	Wed, 16 Jul 2025 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X66uTGoP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A228935A
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649023; cv=none; b=nIepvPEKT8lfi/3/CqnXP2t4WtsJR/2S6X1BqltWDxlF6dokilj4xmW4Y3GMq8fmrfQsy8KIBsjPMJ5BC+UwQRXGeo3PT+KyJEb62SZ70vT21TTpn3jOtf8cF90UAE7gcmwCewDD2RV7M8Stdot5SiQ2QCsyo2/9k7HKBZzUXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649023; c=relaxed/simple;
	bh=z1OmLW2zFRjjaJuAb/CcBCk7MfSb0DVua4kddTk8s5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqVYDP31WzoUrdHefHT1bcPULlOoMeJPDaqpSv68iHQ7PX0N4eS16f/VV7XA6/gNwbEQr1CdDpTuNc5RIbQYUfHxDzxst2nN4jhWYEeXw4RnQMoqbtZXJ47o27nxIBlCPXA/h3jS5vkRZ34Edyo8NoaApATH4//+5VelZqy5lak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X66uTGoP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3139027b825so4898605a91.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752649022; x=1753253822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMM2Qw6CDxEv8PEkN2wkJZJGMuFVyILEWkb8UVmz7pM=;
        b=X66uTGoPVvj1N7qJWBeNPUKZNcDVuuI8uz7QmnamCX6Q5fDMVUGC1p+MYjsowM/qOl
         sF20d6Z1L2Opko3MlW29boAKjpKmG+je0azD9dDc6kMn8kcWR2U48xITktB5af3EMwLN
         KsOXkM4Bhui32mLVZOYS4IARjPz9MxbTlXbrJTub+j7LFc2WVptQspZ4gSWY9c3ShG/6
         L5VBFonWp7dfHjWs5jxrkr4tFfyb4q2IkeGEn+Fx0EaGL3Z//rY15lBukfiFs+MNYix5
         Y0oVkDphF3VjuhjCoObS/d2CsN6D4dcG6V4V0hHnsvcbv/JYBm81tL5TF0vBzJp72yJU
         0rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649022; x=1753253822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMM2Qw6CDxEv8PEkN2wkJZJGMuFVyILEWkb8UVmz7pM=;
        b=oD8j/TKCNgvTFyfKpvk5aKJSQnZ7TjcOozELNgxGmzSsugw9WwcHi2h/9rEfWTMLTK
         tUanYKB1Nv0xJ/zrxuOyItn1aqjqJo4IugXsoyt7WrCrrif6rxDq4C+hIMpFRZLJGa8A
         d9ns02xCD3pxGGPiZFDf6R0xPP70C1xVDopn12DCcwbE1P10Mk+yeyyzI1tQ3i4eGabr
         MBPt8G6KF10yImyiTOyg5AhMmCbyOwFf9tQQdBx4kHAmWRS3C8tgACOEuQjaRw9rD5Qe
         QhpjKfhsTVT3Bakcydr2EpoBnIcyMNRmPE55fbdY6ald6t+NcyCtJgZg8OKFD1tEd0i7
         08ig==
X-Forwarded-Encrypted: i=1; AJvYcCUDQchlw3HBuxe4v53exuAIa4YpxzBFu4lZn5vin6lGec6LZsx840YtUzWXSISplwKXdt/wj4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQL2kBFq0EE+6FXpr8RV87ItWzqcglXBOWn+7crBC2MpABTAL
	wkuPcgHT4fpmNCLkwVcCV0sJQNbFCvwkdqSecHgPRgP8A0/7+2LUh4YYXR1InX0VccNOHC1YEWu
	aYegU4arQnK54WrtzgLll7kycjUMlFpVpCenXtjYpsD01qMkO2/RioMcH4WhKrg==
X-Gm-Gg: ASbGncujHUU1e6t3Gk8PAO/NbiJ7QwXlveY6v7Ma9VcQC1x2eDQvBF4uF4bvMTyI9RD
	HTAdY8XMO5OqmRDFMG0vEWrXlobB1KYz7o1QETRsUpCDJaeLbPCnjUPIkzsJ/1RQTp5stkw4w/J
	mSuWJZi3XWWMRMHGUKwQmTZcUtn5Oaa7/iI6ZpM/Vckb5zFnnVxzJG5MPWav9S432ITE2FRo465
	j92iVHAEIXhU9/iLtfIYZ3Kg5t2oMCNWNQPdf+e
X-Google-Smtp-Source: AGHT+IHSuEo6rfRAa58QtZhShwMNCttAVybGmlGO+HUbJFw2cAdO0jJk6dcC9yoQnDm5p+dYuejf94rd3TgveT3DU3w=
X-Received: by 2002:a17:90b:3c8f:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-31c9f42e8c8mr2492690a91.17.1752649021634; Tue, 15 Jul 2025
 23:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com> <20250712203515.4099110-3-kuniyu@google.com>
 <20250715182236.317f232d@kernel.org>
In-Reply-To: <20250715182236.317f232d@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Jul 2025 23:56:48 -0700
X-Gm-Features: Ac12FXyBhLuLKFWqSp2gIlZ7R9wkozxXQlp-MWfX_r0d621c0F8_64HD68uQEzo
Message-ID: <CAAVpQUD75jba51sMjWQ=rcG9x7W-uwrpMeVMmTpTVztj8Z9rRA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 02/15] neighbour: Move two validations from
 neigh_get() to neigh_valid_get_req().
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 12 Jul 2025 20:34:11 +0000 Kuniyuki Iwashima wrote:
> >       err =3D nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), =
tb,
> >                                           NDA_MAX, nda_policy, extack);
> >       if (err < 0)
> > @@ -2951,11 +2957,14 @@ static struct ndmsg *neigh_valid_get_req(const =
struct nlmsghdr *nlh,
> >       }
> >
> >       for (i =3D 0; i <=3D NDA_MAX; ++i) {
> > -             if (!tb[i])
> > -                     continue;
> > -
> >               switch (i) {
> >               case NDA_DST:
> > +                     if (!tb[i]) {
> > +                             NL_SET_ERR_MSG(extack, "Network address n=
ot specified");
> > +                             err =3D -EINVAL;
> > +                             goto err;
> > +                     }
>
> Any idea why this attr validation is coded up so weirdly?

Probably the author followed inet_rtm_valid_getroute_req() or
friends that do the similar to be strict and accept only known
attributes.


>
> NDA_DST is 1, so we could make this whole thing:
>
> const struct nla_policy nda_get_policy[] =3D {
>         [NDA_DST]               =3D { .type =3D NLA_BINARY, .len =3D MAX_=
ADDR_LEN },
> };
>
>         err =3D nlmsg_parse(nlh, sizeof(struct ndmsg), tb,
>                           ARRAY_SIZE(nda_get_policy) - 1,
>                           nda_get_policy, extack);
>
> and then no looping over the attributes would be necessary.

Looks cleaner.  I can post a followup series to convert such
places altogether.


>
> I'd also be tempted to replace the extack string with
>         NL_SET_ERR_ATTR_MISS(extack, NULL, NDA_DST);
> but I'm biased towards YNL :)

TIL: NL_SET_ERR_ATTR_MISS, and I like this too so will use it :)

