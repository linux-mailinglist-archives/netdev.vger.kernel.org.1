Return-Path: <netdev+bounces-229102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A80BD8317
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE7423628
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3730F53D;
	Tue, 14 Oct 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4G4MFTvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412102DCF5B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430818; cv=none; b=AZ0R1Z/VVYbxMaL+Uhaye3VuPCLrOhib50T/O/gzPaH5dl1n1nqzohF2GKqMVbRpCUdhEXoe0D/PIW6z1BCD3XURUhwu8JbI+waxOR2yEFE89Lar9tww5KNiKTA3z2S0kFh5iUuYK3ysXbFxd9nzAA1VCaYgoDgBLZm6fmsjHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430818; c=relaxed/simple;
	bh=rmbd0/SmSIL0MhnxOdWl4HO3LgnmKXWuvHx3vCvjCrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4dmCGFJtdaDTNh90Z+SFIlmrCslnkyPIdzr7cCA/QL/7fIfAf21T6/8V/3bWTJTdep1Fv0jt/CbUvPbSy4TVVN1GpHUjaLvglL4VE9l/d4hSH9sQ6ohfAyPLD64FIuycZsDTnl4KfjYupoYpChs9cUZvTmK/lYfwA9LudpP6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4G4MFTvH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so88478706d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760430816; x=1761035616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5ki8eO3D7Ty74myIbidYqj2332TSTDOhoTV2Fp3soE=;
        b=4G4MFTvHQ8n88JaeEMUSceir98f73ZFK415GwLkWnxCJ7PUZPwE+gyRMbTsI+7x+Wj
         yaedIaUNBoOqZ8Hc4OEpbmxxEUwQ8wT6iZvY+nCItUqEjXi40IsCJxijLJtxeVag9WkA
         mJqCZgNkcG6q2MhaCGYTWyUGhuu8rR28yS0dc1ej1CCbl+1jDHULE4TR/otB6wGsS3vw
         csvhZ0NeLzX8qsmWU79qW3jMVMYy93iAGnEzt0hWyoZN20HXDgIZyGP8apvPgMo2JSr9
         3CRJJhUqXydW35a/2cIEdhIrse0D6+xPqt1PoI2j/D9LpED0QXiB/hx5B/NCb/6LPWyW
         kH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430816; x=1761035616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5ki8eO3D7Ty74myIbidYqj2332TSTDOhoTV2Fp3soE=;
        b=ZyU5pZkpK5MHYnk0uPQ+EVU6t4vpfcca8GPjuM+ncpDiqQ+nk31cWwUaQhtQTcjL2f
         7ol6gsyOLpV/0pZol0rYpiSMvbVAiAPB7axTr2PHYd/fiXFzpi7d4giupBGmH795Rn+C
         WWNvY22s6Gk6mVgFobJ59h8rXUr1DaFjYRBiZPRR+ews7yxvZQmWUJupbA2tlC/ZCkOb
         MAWXHQ4+IdePA4P7D/y63pcB4jH5RbocbNsdlY+Fhvl9LKHrl1zwoRVPHax081YiZGUe
         auATmaP/+1mv6IrAGTeTUTMv9r6XZpgiwEdUZv3LsA59s2RFG/shymt6H1lv196136YW
         RCJA==
X-Forwarded-Encrypted: i=1; AJvYcCXc4513vA3+b0Q9GvjLH8zs8Sk/lkrI37LrY9ozJShoJ1dJud6owrsGazde3GQOvzlukjM0X4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmniy47YC1YY5g6melEFaJyyWYQv5iLAE02nzbDUBJdrJyDTs
	9SJWwbxBV/JtS6HhjLw3wUfj6ihh7cdE/Dimpbina4Lugbdhx93dKNCufuB4Sz5a798YDLaw1Q+
	1t8MWL0kz9XtSVrSkmgTJyTHM53Rp5wweJPMEJRPqcGDHA3sVQL7m3kbr
X-Gm-Gg: ASbGnct8zzpq3XTdPZwKy0MjyPR28fDyYITjyJEIhD7wj7BZPGxLVF+jHPEhAiAD0LG
	ul372Yk6FnwvwKjwuZBgH7WVipusUDNFdyWce/mZUjPeCnEcxng5aQYyrkm3g5g32O4uyvp/UJ+
	bB2sMAl7iRE0CF2pyj3/E4ZQ4SRq9R0ielG1R/zmyuGXmxdw7fs0yijEKHrUPLJ6CivIk13LUeo
	zBrZAHBFdzOw1MrMo6SPqpIjcRitKn2
X-Google-Smtp-Source: AGHT+IFH54MT50hNqDb6HE6AU0St/fKsTDcWdJom82KiknKN60SG1UT50A/i9xfKyb2sSd1IDZ8yOsF3iF/RL5GTQ4U=
X-Received: by 2002:ac8:5755:0:b0:4e7:2b6a:643a with SMTP id
 d75a77b69052e-4e72b6a671cmr60433281cf.12.1760430815645; Tue, 14 Oct 2025
 01:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com> <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com> <aO4JqeYJftHa-I8O@krikkit>
In-Reply-To: <aO4JqeYJftHa-I8O@krikkit>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:33:24 -0700
X-Gm-Features: AS18NWAOuBILqWC2YQZIUDNrGMhSRr31kxh5jDbSfWP5BfgZalObTIcjz-PByH0
Message-ID: <CANn89iJLDmLZAxOJE0DV5HinTXZVCviBxn1OJBOorddNNywtCg@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:28=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2025-10-14, 01:06:04 -0700, Eric Dumazet wrote:
> > On Tue, Oct 14, 2025 at 1:01=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, Oct 14, 2025 at 12:43=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Tue, Oct 14, 2025 at 12:32=E2=80=AFAM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> > > > > > 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> > > > > >> Michal reported and bisected an issue after recent adoption
> > > > > >> of skb_attempt_defer_free() in UDP.
> > > > > >>
> > > > > >> We had the same issue for TCP, that Sabrina fixed in commit 9b=
6412e6979f
> > > > > >> ("tcp: drop secpath at the same time as we currently drop dst"=
)
> > > > > >
> > > > > > I'm not convinced this is the same bug. The TCP one was a "leak=
ed"
> > > > > > reference (delayed put). This looks more like a double put/miss=
ing
> > > > > > hold to me (we get to the destroy path without having done the =
proper
> > > > > > delete, which would set XFRM_STATE_DEAD).
> > > > > >
> > > > > > And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delet=
e
> > > > > > x->tunnel as we delete x").
> > > > >
> > > > > I think Sabrina is right. If the skb carries a secpath,
> > > > > UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() wil=
l be
> > > > > called by skb_consume_udp().
> > > > >
> > > > > skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
> > > > > skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cac=
he()),
> > > > > the skb will go through again skb_release_head_state(), with a do=
uble free.
> > > > >
> > > > > I think something alike the following (completely untested) shoul=
d work:
> > > > > ---
> > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > index 95241093b7f0..4a308fd6aa6c 100644
> > > > > --- a/net/ipv4/udp.c
> > > > > +++ b/net/ipv4/udp.c
> > > > > @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, stru=
ct
> > > > > sk_buff *skb, int len)
> > > > >                 sk_peek_offset_bwd(sk, len);
> > > > >
> > > > >         if (!skb_shared(skb)) {
> > > > > -               if (unlikely(udp_skb_has_head_state(skb)))
> > > > > +               if (unlikely(udp_skb_has_head_state(skb))) {
> > > > >                         skb_release_head_state(skb);
> > > > > +                       skb->active_extensions =3D 0;
> > >
> > > We probably also want to clear CONNTRACK state as well.
> >
> > Perhaps not use skb_release_head_state() ?
> >
> > We know there is no dst, and no destructor.
>
> Then, do we need to do anything before calling skb_attempt_defer_free()?
> skb_attempt_defer_free() only wants no dst and no destructor, and the
> secpath issue that we dealt with in TCP is not a problem anymore.
>
> Can we just drop the udp_skb_has_head_state() special handling and
> simply call skb_attempt_defer_free()?

Good point ! I need a second cup of coffee !

