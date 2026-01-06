Return-Path: <netdev+bounces-247297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C0CF6994
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 04:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D70A301D948
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 03:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54761E9B3F;
	Tue,  6 Jan 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQev8DxU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3BD26ACC
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669941; cv=none; b=AgVHXwk0uKGOqUrYFIuN6vcRxifs35YOsq08HquLC0twpcRFfCqlLoopxkbm7Cn/cntngxL0FKxDX9e/op7s4ZqPaqlnEvWMP4c2XMU8TTQi3ECUUh7go2Fewgi6pEmjXuh13sDyUcDvHMLvY5CJy4p1Kc3RfU6k7hov/+o14kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669941; c=relaxed/simple;
	bh=fFdZERkQq7qcoX44VzNM9NF/W5K6GE3Gkb6xhhWGgiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgjaBvmdEb+njQoPywpk+uNbdrDFjhdcF+qq2wGO/DTRTjECLGXcFlydzrzLBykM5cCzYf1hTr357MeyE+kb5QgH/FHEXOAjasRvo8mestwJQUtd/rtj1Os7ExYcwWeY83wBp7wN+u7qxnoIYVFG3vlgzb2vP2oQyGuHVc4Dxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQev8DxU; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65d132240b5so304314eaf.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 19:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767669939; x=1768274739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7adoCRWWLhZQUEHRqlXRuMHWuAIXead0Q42trhJ7/5c=;
        b=WQev8DxUoroT658VM5yA6uZvGDDXtncDyL8daFIqtnZJbqpKr6sBoF+OtWPk06m976
         1SPOC9vGV6zSxADREkl5H0UIYl9Q8RLlcfI69/u062DS+4kpR0aF+oxMvdS9deQbXLhR
         UI0E0eCMAcv0KOPmGVGhdNDdutSn3HT8V7MT9bqbQVgbov8Axjj0AoVEC345dBU78wQA
         71YAVkl3qtg1CMaRdFJxLm0wJ7WtduS7mmLNDzC49KZHVjWJZsExhp5ta7hXF3ENRAtx
         RtZw3zp03pMHvDFynY8ra/ZPotEtXo4IZXKTLAxJrISgk+uVFUhNJ93oqUxaJG3twuDK
         WElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767669939; x=1768274739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7adoCRWWLhZQUEHRqlXRuMHWuAIXead0Q42trhJ7/5c=;
        b=t2+eAzlIlopTAB3pyjKA6RZ8+o9HEiKJAgWwqDWYSIu7rIbnDTV/yfs72nCJtVnIs7
         OU0F27MQPhyybckHsxItMVZm3tot6lBAIuvSVQR1NDO83G2J03IRwiIHRrYjjugOSeQ2
         RQ1X+a4jFdzdhPqscXahGNZhCL2XdI4/x9XKpoBVK4JuJy71oZuJ94D7NRIz/1W7XRKk
         eeRnleHR16SVRno2KMRNzSHYG3K/IMBl6yheCV9glWkQ5GuKh/WH4QjfrfWfymzUZIRk
         lTCRlW8wtCOQQEGLK2azyySB9hd4ESKldG0xafDJoq0WnvR6dwWnCZeR6po8c9oFyWlt
         2nzw==
X-Forwarded-Encrypted: i=1; AJvYcCWtiUrE3kf+PzMjupzD3ENdnA+qtczm3TgtsdVKdGRVWMeiNUMqwC9WBB9Gmm8bGb0g9gCFORg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySga5jOJtiWIpXp6uZunlE/uCkhKJ2lhZzFb41oSi4cbKWjkkQ
	nOOOKq3dgsKtMdWALLLXIG9sdTtXjJL/0W/1y9a1f86O9UVZdN4qNJn3/hDkcBUWKRAwT+FWXNt
	DSu9zPet4B7Q1+13oBrlQx5JkxV4/7Hg=
X-Gm-Gg: AY/fxX6p4wc51MKdSiM6wSG4mHklvJzpNYhQTSszH76asf2O+Dbc26dNeMaruBuCv0E
	iM06yQ2U9z/lt2ePDT/o907K9nPWuhdA0pCpB61Y0Xfse3CBnPUrg5kqOTldEOb/XR8Q+ycFZXv
	zCvpIyOJ90CwPjF1PEd9/yWKLRQqfR/K0Glw6AU9AERs2nyrKPuJCVJc4pH8cRl8dcnVTw1NZxC
	FAbNR/dzAvTazWan0vwrl7WRcxA3n0tb0d+TCJKMCnB2WIbQYMIyKikjo73NXHoxgmiDfHd
X-Google-Smtp-Source: AGHT+IE5K5h7PkETUmLZNIi2espKhWrZ/bV63HHw1GbilIoMq0LWNjMm/em3uFC9RVyPysLjbOR4QCMhToU5QexgT0U=
X-Received: by 2002:a05:6820:1501:b0:65d:88b:c012 with SMTP id
 006d021491bc7-65f47ab1515mr1059429eaf.72.1767669938846; Mon, 05 Jan 2026
 19:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106013112.56250-3-kerneljasonxing@gmail.com> <89fee0bdf782c9fab10781be2a42c099bfb9f99a53c342dd6e41fd99651943f6@mail.kernel.org>
In-Reply-To: <89fee0bdf782c9fab10781be2a42c099bfb9f99a53c342dd6e41fd99651943f6@mail.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 6 Jan 2026 11:25:02 +0800
X-Gm-Features: AQt7F2rLl5PRrK_saI0AlLXbGM3sprVHqPrvdAsBvJqZUrt6U1Qh_jNjwM51pBM
Message-ID: <CAL+tcoAHRct5w4xpfzHcafpf0ZHiUAofDjLuhxKibwrB3aaZ=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] xsk: introduce a dedicated local
 completion queue for each xsk
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernelxing@tencent.com, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:47=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f41e0b480aa4..f80721165fdc 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > -static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > +static int xsk_cq_reserve_addr_locked(struct xdp_sock *xs, u64 addr)
> >  {
> > +     struct xsk_buff_pool *pool =3D xs->pool;
> > +     struct local_cq *lcq =3D xs->lcq;
> >       int ret;
> >
> >       spin_lock(&pool->cq_cached_prod_lock);
> >       ret =3D xskq_prod_reserve(pool->cq);
> >       spin_unlock(&pool->cq_cached_prod_lock);
> > +     if (!ret)
> > +             lcq->desc[lcq->prod++ & lcq->ring_mask] =3D addr;
> >
> >       return ret;
> >  }
>
> [ ... ]
>
> > +/* Record the position of first desc in local cq */
> > +static void xsk_skb_destructor_set_addr(struct sk_buff *skb,
> > +                                     struct xdp_sock *xs)
> >  {
> > -     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x=
1UL);
> > +     long val;
> > +
> > +     val =3D ((xs->lcq->prod - 1) & xs->lcq->ring_mask) << XSK_DESTRUC=
TOR_DESCS_SHIFT;
> > +     skb_shinfo(skb)->destructor_arg =3D (void *)val;
> >  }
>
> [ ... ]
>
> > +static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
> > +{
> > +     struct xsk_buff_pool *pool =3D xdp_sk(skb->sk)->pool;
> > +     u32 idx, pos =3D xsk_get_start_addr(skb);
> > +     struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > +     u64 addr;
> > +
> > +     idx =3D xskq_get_prod(pool->cq) + desc_processed;
> > +     addr =3D xs->lcq->desc[(pos + desc_processed) & xs->lcq->ring_mas=
k];
> >                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +     xskq_prod_write_addr(pool->cq, idx, addr);
> > +}
>
> Can this read stale or corrupted data from lcq->desc[] if skb destructors
> run out of order?
>
> Consider this scenario with a completion queue of 4 entries:
>   1. SKB1 reserves and writes to lcq[0], stores start_pos=3D0
>   2. SKB2 reserves and writes to lcq[1], stores start_pos=3D1
>   3. SKB3 reserves and writes to lcq[2], stores start_pos=3D2
>   4. SKB4 reserves and writes to lcq[3], stores start_pos=3D3
>   5. Backpressure - cq is full
>   6. Network completes SKB4 first (out of order), destructor reads lcq[3]=
,
>      submits to cq, space becomes available
>   7. SKB5 reserves and writes to lcq[0] (wraparound), overwriting SKB1's =
data
>   8. SKB1's destructor finally runs, reads lcq[0] which now contains SKB5=
's
>      address instead of SKB1's original address
>
> The old code stored addresses in a per-skb xsk_addrs structure, so each s=
kb
> had its own copy that could not be overwritten. The new shared ring buffe=
r
> design appears to be vulnerable to out-of-order completion corrupting the
> address data.

Right, this case makes me rethink if I should continue with this
series as it's apparently becoming more and more complicated than
expected.

I will try to fix it well with minimum changes.

Thanks,
Jason

>
> > +static void xsk_cq_submit_addr_locked(struct sk_buff *skb)
> >  {
> > -     u32 num_descs =3D xsk_get_num_desc(skb);
> > -     struct xsk_addrs *xsk_addr;
> > -     u32 descs_processed =3D 0;
> > +     struct xsk_buff_pool *pool =3D xdp_sk(skb->sk)->pool;
> > +     u8 i, num =3D xsk_get_num_desc(skb);
> >       unsigned long flags;
> > -     u32 idx, i;
> >
> >       spin_lock_irqsave(&pool->cq_prod_lock, flags);
> > -     idx =3D xskq_get_prod(pool->cq);
> > -
> > -     if (unlikely(num_descs > 1)) {
> > -             xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destruc=
tor_arg;
> > -
> > -             for (i =3D 0; i < num_descs; i++) {
> > -                     xskq_prod_write_addr(pool->cq, idx + descs_proces=
sed,
> > -                                          xsk_addr->addrs[i]);
> > -                     descs_processed++;
> > -             }
> > -             kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> > -     } else {
> > -             xskq_prod_write_addr(pool->cq, idx,
> > -                                  xsk_skb_destructor_get_addr(skb));
> > -             descs_processed++;
> > -     }
> > -     xskq_prod_submit_n(pool->cq, descs_processed);
> > +     for (i =3D 0; i < num; i++)
> > +             xsk_cq_write_addr(skb, i);
> > +     xskq_prod_submit_n(pool->cq, num);
> >       spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
> >  }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/207350=
04935

