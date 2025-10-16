Return-Path: <netdev+bounces-230081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E12BE3BC3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37443B120E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A81527B4;
	Thu, 16 Oct 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAcKDf88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E1CA6F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621831; cv=none; b=Kde23g+iGO6NPuigd8W4gqy/gI9PC8YuS/XNKrNUVZxp5mjtQhNiy8OKiYVrO5qAfk20zH3jDdnVbQqK9fmn7lqt5nbGMoZNGUuiznaGp6v3uFZUQ5TWu87Ckxxw4XSpxLCy3LRKPZO+PgdCRCBmkgYtJwLNuILQ1UYsowNYkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621831; c=relaxed/simple;
	bh=N4F8FRAqLTwTh+GkfGRyW0rjmoUD8mBDEsVpYXMrW1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEKbOg8g5VjMbVE8utOL/4SSlm9mRY4LVa12MF/Uher/QqrUl4/RGrxpTHGpe1IsMmdPuOyAj/aiZRvW2TROhwlrhJSQwtGrhqs9aoJP8BlKM5ARszGA1ZqCCbgAMYcreINtDyidP3yfXiMdzi2BK7YcB42q31rR354qvdvDSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAcKDf88; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7e3148a8928so10358886d6.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760621828; x=1761226628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAZcdeK/xU+S/VhcXVMo554urSW0WUUc1ISGU3vEFIY=;
        b=CAcKDf88jE1Cdw5GwMUHq/yHB0+WktTyvaeOr0t4J2M9A28vGNGrisbKBlREVqTHsY
         +lsiY1s9G9fIOnE9wdAjocCQ0lT+4FS/UzLde5RWMea1C7H/Il5KjWLYiGuUoL0o65VA
         O8/JiL8fVq6r+bUFOO7+ezsW9g4BMSxAk5WpCsv+zkqsRJG6iSQTaiGPFI632XjGslR8
         k0+3zXS0CrKHegXBsm3MC9yC++wXoJauomFQRzNYid2Pe1RD24sQKjlGPJV9P1/pt46X
         DYKybfNuVULusdMhyeTIItFjZvAVoeIw+JpnRwLaf459mSzBIU/kBdkf0rvT3QbwFVlb
         YcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621828; x=1761226628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAZcdeK/xU+S/VhcXVMo554urSW0WUUc1ISGU3vEFIY=;
        b=cj3zY5xZyDRwIeLTEVguB3DWDXPgvIU80YJYjvoLechi5691UB5QMFFIlIVJlKzygm
         Tb0v8fk5aGpelAA7vlaKc8tx/kUDWNB4WRz+CRiVJZkCMICHNj/OPStGll7BQXW/+Vd1
         1gT4TpIDPpv/8X+dqArF04PHHVCutIyjHqfVaABiCq/kjYH4KQwG+8ODnutNR0yjT0Cz
         5lB4NTMknWBnvhEAPKI9MBvQDaD7RO3xET8PX/MVGV2JaGRoLtDTWIxM9O4VamDsFZmi
         KGjlloLTWdXYZ8sNAvtPeQu5h+rSsqSnEotYiV6qgRW6Ni0H4O6NSh1w0r5STXsefvA0
         nSYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/SAdx3e/fQ3yQs3Iw/kZUik5UJSEKToJo5X0ZDIRy5Reu3lfsiMw0x2sAbP/gaAzxfRxM22I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyayHwQf7rjVpptmapisS/6y1npASIqPhnpojIxSw/SuhR/uw0S
	oRz2rUbD2vWv56dS63yyyaABoT/x0i/Sv9Yt4n6VHVrqaOeNnGAV3MDEpCvqZnfITMR8BjJ3HWW
	HRvBq6AqZa4ZY3Gro/vRT+Ra2yG81YLMzeZrLX4uv
X-Gm-Gg: ASbGncti2mDpVTUk7GFqZcjWrsDmoOOQtAnvsOA1amgw7zwCcDip2GyVAIrTsFgagnc
	4OJEmPwDgDJkx0Do3XXtNYqqBijiHD6yinTvmExsArNJhlPM0XfqvBWkNhDx4AUDmLCDTlABiUs
	wqsXFYudAHCfrhsOLPUDlSAjvorb/J1aa9wAjfAJK2Y/sXFsE6EynpJGDf37xZRA/jFx7d6AUhs
	oFhUj2QRkZAR7QwfKN5Mq5qGrTpmbQV/KgwUINvwObaSGPMdhRjbiePqXwVlK1CQO9dShmzPnRZ
	TL8=
X-Google-Smtp-Source: AGHT+IFzD5eIw2s5D6MVnUdNdA0OsGxbsZRPNWq+ZjDDp3TolyfEK8CxB6JGiMgyQ4SGjbL8m25dgDcXoNuPMvW7Kgg=
X-Received: by 2002:ac8:5953:0:b0:4e8:944a:5e4d with SMTP id
 d75a77b69052e-4e89d3de4bfmr1873591cf.63.1760621827124; Thu, 16 Oct 2025
 06:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015233801.2977044-1-edumazet@google.com> <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
 <CANn89i+birOC7FA9sVtGQNxqQvOGgrY3ychNns7g-uEdOu5p5w@mail.gmail.com>
 <73aeafc5-75eb-42dc-8f26-ca54dc7506da@intel.com> <CANn89i+mnGg9WRCJG82fTRMtit+HWC0e7FrVmmC-JqNQEuDArw@mail.gmail.com>
 <CANn89iKBYdc6r5fYi-tCqgjD99T=YXcrUiuuPQA9K1nXbtGnBA@mail.gmail.com>
In-Reply-To: <CANn89iKBYdc6r5fYi-tCqgjD99T=YXcrUiuuPQA9K1nXbtGnBA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 06:36:55 -0700
X-Gm-Features: AS18NWA2qAUC9_l_rGaVjpNFnMzotPZbNbm3A2XtOQ2697y7ALlbiNFLW0dEkpU
Message-ID: <CANn89iJo-b=B7jUtbazcCtgKJrnbgdEXJ-OPvOwFziP_OSLaYA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:29=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Oct 16, 2025 at 5:56=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Oct 16, 2025 at 4:08=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> > >
> > > From: Eric Dumazet <edumazet@google.com>
> > >
> > > BTW doesn't napi_skb_cache_get() (inc. get_bulk()) suffer the same wa=
y?
> >
> > Probably, like other calls to napi_skb_cache_put(()
> >
> > No loop there, so I guess there is no big deal.
> >
> > I was looking at napi_skb_cache_put() because there is a lack of NUMA a=
wareness,
> > and was curious to experiment with some strategies there.
>
> If we cache kmem_cache_size() in net_hotdata, the compiler is able to
> eliminate dead code
> for CONFIG_KASAN=3Dn
>
> Maybe this looks better ?

No need to put this in net_hotdata, I was distracted by a 4byte hole
there, we can keep this hole for something  hot later.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..f3b9356bebc06548a055355c5d1=
eb04c480f813f
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -274,6 +274,8 @@ void *__netdev_alloc_frag_align(unsigned int
fragsz, unsigned int align_mask)
 }
 EXPORT_SYMBOL(__netdev_alloc_frag_align);

+u32 skbuff_cache_size __read_mostly;
+
 static struct sk_buff *napi_skb_cache_get(void)
 {
        struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
@@ -293,7 +295,7 @@ static struct sk_buff *napi_skb_cache_get(void)

        skb =3D nc->skb_cache[--nc->skb_count];
        local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
-       kasan_mempool_unpoison_object(skb,
kmem_cache_size(net_hotdata.skbuff_cache));
+       kasan_mempool_unpoison_object(skb, skbuff_cache_size);

        return skb;
 }
@@ -1428,7 +1430,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
        if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
                for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i+=
+)
                        kasan_mempool_unpoison_object(nc->skb_cache[i],
-
kmem_cache_size(net_hotdata.skbuff_cache));
+                                               skbuff_cache_size);

                kmem_cache_free_bulk(net_hotdata.skbuff_cache,
NAPI_SKB_CACHE_HALF,
                                     nc->skb_cache + NAPI_SKB_CACHE_HALF);
@@ -5116,6 +5118,8 @@ void __init skb_init(void)
                                              offsetof(struct sk_buff, cb),
                                              sizeof_field(struct sk_buff, =
cb),
                                              NULL);
+       skbuff_cache_size =3D kmem_cache_size(net_hotdata.skbuff_cache);
+
        net_hotdata.skbuff_fclone_cache =3D
kmem_cache_create("skbuff_fclone_cache",
                                                sizeof(struct sk_buff_fclon=
es),
                                                0,

