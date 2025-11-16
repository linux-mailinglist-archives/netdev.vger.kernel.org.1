Return-Path: <netdev+bounces-238926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696F0C611D9
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 09:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B2B3A0365
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5041225779;
	Sun, 16 Nov 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4KPjtZV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7120FAAB
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763282913; cv=none; b=rseT9e+hk3fUYizbOqb17VzaZeqL+boXS1khX/u9jn78/rYwdhXayIQB81hVXJcMQcGgzsJd8ct5ZdZwqHJkKB3DpQWZdDzsFYCv4gttkm4nXY5yanyEpWKA9mYKwSRdozfSxLTVeh65rVyTCOWUB7vPEueUgC21bCudp24twzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763282913; c=relaxed/simple;
	bh=slKdwHafhow7dloL59W+zFaQY0w00Mq7xViexOU5RQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4oZYuchTn0Pv3KhiY3jejRwzDNjn5zBe3ftAdmQcweFhH1jVN94RMKiwmyRDPVxy3mc79wATZIXava0E292LtBgZbDiJPPYAVplGPrrG4X0UIPif2fDQUMJ1rlm+5EWj1Dw8NhhQU5wodvDdqr8nGtp4DuNRmOL/oWzB/rRfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4KPjtZV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee1879e6d9so5988541cf.1
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 00:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763282911; x=1763887711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoqFw6oCCnUpU9ChJ0lDJZrZlLUp+Vj4PSkyuiVNz04=;
        b=C4KPjtZVs1KGJbPQHwNaf0l05LdptTvNNjIk6iVEo5hA08QXCypUY6MpPEBocRvopm
         DlD2uCS7HqHjaWueNIIFQe3Emfe9//vhg4tEaKMhri1HFUKrNqyabe9mmzEYgyzynqbp
         h5csXZCmR61TKmuEEnj3/LSvo6V/ssBye2zKuEYORfn7xkgEgPRRdAgG6dXQcFgy9Q7X
         ceEGPb7sUTdAC7iunMe4juIOmPhd3Qvot1jXAFUvQ2A9wqMUyx3XJt/OuMjNbpVbVYvI
         udBfmYeIyI6K06rDvUNpvTojpafzNOJP305rGgrrWyV9IYXZmJ4ZIg6gmC5Jd/V1FGPL
         qO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763282911; x=1763887711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoqFw6oCCnUpU9ChJ0lDJZrZlLUp+Vj4PSkyuiVNz04=;
        b=u40EYafABEiWgU/24yFbAUvczTeu9CFONcyJqB/13jEfWwvjnCDxE/jMFEm4B0kYRm
         oZ+vzrqyNs+b9uU8CCXZfADVceppY5ZIhK/DqGrc8FhOS/KXCuu4yEc6Y9yXiCkAMRIf
         MU4/3zRCTZerlhEL7UdCLlW7e0p9USd1mQT5zs8ORYYnjoxpj8MNc0G8rxK09hQWVFcn
         SgMYoRFFhty+rYdZkueCYYK4lPk5uOsGC3Xtjk0Wx1b+Fvp0X8NCdoziTjwQnuNjZFXJ
         L9NpOnsHi7jww3jv7+MkiGhNjn2WMiNy0dATcBoQyWUebUTrmHgk6Z9WM/UkHKdC5Cnu
         cbww==
X-Forwarded-Encrypted: i=1; AJvYcCUIn5oSpzUYc0wrhTCMOxBjwJejx+3oG43KyelYOLJoifFs7r8+c+znZsJDrsqspm18CtG2WBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NBtqdl0MQlLAmFlz7jPb7BtJMoFl22+E80Eibx7frTzL3qkF
	0lEquUvAOF2blsqZlUgPxYPG1aUkEgqqlLACbDF2S5zSM94IMBIqrshxclzdPAqiDfi5bCbXEyC
	n8udoSJT98Xx/zfNkqjzeprjhU3cXAOcgshuLVTPy
X-Gm-Gg: ASbGncu8Y+XX2S4U4pxUk34+PbR/wWzyjxv8gQwkmWQ1jmzIXlCJEkR/Al8NPAPLqkS
	jkKf1/mmhlxkPsb+ROrZ4jw3kFOPuzJxKwSH6XwPbpJoGbs2PtXNgDnnbKSRoX2C1Q0YPZCgQif
	Hvsq7H7DOYU1FSoQnNuE6G1COH/7KBTR6yeDjS0l/RKOtHdgJiZ3DE/wmCzNr0Pwh+17BLOJiZk
	hfRy+rKFeVqVDpFDKqyjdE3hOk8e4YREJJgxji+rMz6vexrpthBoFnKBoxM8QiJXld3HV4=
X-Google-Smtp-Source: AGHT+IGo19LSVHXDsKRaBIcXYJY7d55xpGeiLKotjtdnGxL1jC98YuIxoB0p72+YWPVLP33hkkPjSAmt+y3LhlZXqQw=
X-Received: by 2002:ac8:5d8f:0:b0:4ec:e1aa:ba4a with SMTP id
 d75a77b69052e-4edf20487d5mr123157171cf.1.1763282910518; Sun, 16 Nov 2025
 00:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114121243.3519133-1-edumazet@google.com> <20251114121243.3519133-3-edumazet@google.com>
 <CAL+tcoCdLA2_N4sC-08X8d+UbE50g-Jf-CTkg-LSi4drVi2ENw@mail.gmail.com>
In-Reply-To: <CAL+tcoCdLA2_N4sC-08X8d+UbE50g-Jf-CTkg-LSi4drVi2ENw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 16 Nov 2025 00:48:19 -0800
X-Gm-Features: AWmQ_bn9LHqJeAljDgweB0QUI4YkOxGxDvCzxEs3bCHpm6F9GKlTapcH-XXSLMM
Message-ID: <CANn89iKbV=mmPacj2d0parv9PKyWhKqasU=ufLBvrY90Lbs3Yg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] net: __alloc_skb() cleanup
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 5:08=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Nov 14, 2025 at 8:12=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > This patch refactors __alloc_skb() to prepare the following one,
> > and does not change functionality.
>
> Well, I think it changes a little bit. Please find below.
>
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/core/skbuff.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 88b5530f9c460d86e12c98e410774444367e0404..c6b065c0a2af265159ee618=
8469936767a295729 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -646,25 +646,31 @@ static void *kmalloc_reserve(unsigned int *size, =
gfp_t flags, int node,
> >  struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
> >                             int flags, int node)
> >  {
> > +       struct sk_buff *skb =3D NULL;
> >         struct kmem_cache *cache;
> > -       struct sk_buff *skb;
> >         bool pfmemalloc;
> >         u8 *data;
> >
> > -       cache =3D (flags & SKB_ALLOC_FCLONE)
> > -               ? net_hotdata.skbuff_fclone_cache : net_hotdata.skbuff_=
cache;
> > -
> >         if (sk_memalloc_socks() && (flags & SKB_ALLOC_RX))
> >                 gfp_mask |=3D __GFP_MEMALLOC;
> >
> > -       /* Get the HEAD */
> > -       if ((flags & (SKB_ALLOC_FCLONE | SKB_ALLOC_NAPI)) =3D=3D SKB_AL=
LOC_NAPI &&
> > -           likely(node =3D=3D NUMA_NO_NODE || node =3D=3D numa_mem_id(=
)))
> > +       if (flags & SKB_ALLOC_FCLONE) {
> > +               cache =3D net_hotdata.skbuff_fclone_cache;
> > +               goto fallback;
> > +       }
> > +       cache =3D net_hotdata.skbuff_cache;
> > +       if (unlikely(node !=3D NUMA_NO_NODE && node !=3D numa_mem_id())=
)
> > +               goto fallback;
> > +
> > +       if (flags & SKB_ALLOC_NAPI)
> >                 skb =3D napi_skb_cache_get(true);
>
> IIUC, if it fails to allocate the skb, then...
>
> > -       else
> > +
> > +       if (!skb) {
> > +fallback:
> >                 skb =3D kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DM=
A, node);
>
> ...it will retry another way to allocate skb?

Yeah, I guess we can avoid a retry.

