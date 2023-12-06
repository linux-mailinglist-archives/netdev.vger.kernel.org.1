Return-Path: <netdev+bounces-54580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90A807815
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C62282153
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346993FB12;
	Wed,  6 Dec 2023 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0O0LvvN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1534410F0
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:49:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso7424866b.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701888585; x=1702493385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziRU2FnN4POMxpTQvqS7/l9aFbYDIfKx6N/Y5jodgA8=;
        b=L0O0LvvNNjbhyT9ng+k185k5Q31dsmzTsGAfyDlNRIje36M4+aEuyER3lmRbqowf/G
         TIqF8RXZNBfuTgoffihqqqmQRaDGXU/VA2FQtV4pG+QYo4tFZ2TZ/FlbTD1WWlxn2wdG
         mX7VGZY1xjy+jmPWIIu1uzSKd+uZjIlVJC34o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888585; x=1702493385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziRU2FnN4POMxpTQvqS7/l9aFbYDIfKx6N/Y5jodgA8=;
        b=hH5VAUOLKI4too4R2FNIcqmvGCA+z3QZzkAhCFiFDAlpFpv6kwQVunGbbLSQ+2qfYu
         +U2QnW+sTvZFPrSXmgiMa2C2nHShK/T4AVQPS+Aw2lrtEPOhiNZntdtgrD9xuyNyVOmX
         3Pv4uJL1gDSQE+xkcsY0MHsbPLOZfwBbmfnmHhfHgxuyljYAfDwepQnCb/wsNXEtVmeV
         hHEVtkEU2y6cD2W+Iig90cxs/+LbJ4/s9xp7uocM0SE/RmSkDmTaDo+eVBR9QaX2mz0V
         u8T7U3fsUUUNFWvW5zPxffK35ZiCAmFBwrKcUcW8ikFOWFoJXdJWO7jh4uPBHMuJASXk
         Tobw==
X-Gm-Message-State: AOJu0YwvXpS3mKgvSUl/gPlZn0Rhpjsna1mSz5Dr4CeUcSAdZTfuTPYX
	NW8tbMPl6Vspk/ApU7jtNBdfkL3YsjEBOdhBmoVS5kV1
X-Google-Smtp-Source: AGHT+IFGuO9wneWVNPuu5NdBKMrIKeKXR1JL3916gjUH4zztiilLM+6Dm5vnL+c8oiKVET6L/V2LGg==
X-Received: by 2002:a17:906:f156:b0:a19:a19b:78ab with SMTP id gw22-20020a170906f15600b00a19a19b78abmr775156ejb.110.1701888585622;
        Wed, 06 Dec 2023 10:49:45 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id ku3-20020a170907788300b00a1ccd1c7210sm284127ejc.99.2023.12.06.10.49.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 10:49:44 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so1245a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:49:44 -0800 (PST)
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr125503edc.6.1701888584617; Wed, 06 Dec
 2023 10:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
 <20231206093917.04fd57b5@hermes.local> <efd58582-31b6-47f0-ba14-bf369fddd1c0@kernel.org>
In-Reply-To: <efd58582-31b6-47f0-ba14-bf369fddd1c0@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Dec 2023 10:49:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
Message-ID: <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Judy Hsiao <judyhsiao@chromium.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Brian Haley <haleyb.dev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, 
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 6, 2023 at 9:51=E2=80=AFAM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 12/6/23 10:39 AM, Stephen Hemminger wrote:
> > On Wed,  6 Dec 2023 03:38:33 +0000
> > Judy Hsiao <judyhsiao@chromium.org> wrote:
> >
> >> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> >> index df81c1f0a570..552719c3bbc3 100644
> >> --- a/net/core/neighbour.c
> >> +++ b/net/core/neighbour.c
> >> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tb=
l)
> >>  {
> >>      int max_clean =3D atomic_read(&tbl->gc_entries) -
> >>                      READ_ONCE(tbl->gc_thresh2);
> >> +    u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
> >>      unsigned long tref =3D jiffies - 5 * HZ;
> >>      struct neighbour *n, *tmp;
> >>      int shrunk =3D 0;
> >> +    int loop =3D 0;
> >>
> >>      NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> >>
> >> @@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *t=
bl)
> >>                              shrunk++;
> >>                      if (shrunk >=3D max_clean)
> >>                              break;
> >> +                    if (++loop =3D=3D 16) {
> >
> > Overall looks good.
> > Minor comments:
> >       - loop count should probably be unsigned
> >         - the magic constant 16 should be a sysctl tuneable
>
> A tunable is needed here; the loop counter is just to keep the overhead
> of the ktime_get_ns call in check.

From context, I'm going to assume you meant a tunable is _NOT_ needed here.=
 ;-)

-Doug

