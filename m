Return-Path: <netdev+bounces-230124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D37BE439F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B1B485163
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288A34DCE1;
	Thu, 16 Oct 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/TfLKPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC534DCC4
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628440; cv=none; b=FY+wlsNQsel1vsX/+Zi6JQsIZ3Zar9zO9edc5JrgazOhiAsABlSEaHon+6Vb6c9NL38xQvWIJ30d9swDiza+VBFjVBk1Ff7o+q3u+wocLQ+0aDqU1kEX6oTKW5NrULTAYCzjaj6LP09CLZCtnJg0rSRJs9x14JdbQAgsur+fglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628440; c=relaxed/simple;
	bh=YyKb/EOUJifA1JRQRqJ2RKC4NB4I5ikOZ6M71FLui+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE1BAnhKkUHwuJ4Eq4bcePOsEub5izR1Qd8Zb/i6E0YXGA2abxpefu1uv3Tt+YFLcwcxGKkseUuip0gVqXWnLbmn+CeGq3Ltzkxw10cWCCTnG85J0UviliCBzyRFnJvYRuAFUKChtP18ebRhg0ig/s8g/MPcfpEpuNxrBfhkOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/TfLKPE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-84827ef386aso109581785a.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760628437; x=1761233237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUnzh4YZaBSEW3/Ot9CVGb4TXhYMxv9bzIKKvA4RBT4=;
        b=v/TfLKPEYvr9se45jfRz2X1wczNniRMG7Et+y+pVATJTKkTj11YSzq2uagn2LF9N53
         hLA4AfdSLT3KBnt6xSxYZ4gcSB2VPXqwhlBs00nXSngIBXXTsuGRzsKezEObEHkwop34
         9H4VXjlLOhf6+Wv06a2w89L5fAd8pg+FHJZ+xsVL3d8d6906BKZ/hTIaKwui4TbnAnN9
         g7vCHRM5r66zaQ/ddtF22ha1bhBJbG6OFnkHt8zI/BBRIMEIi6k3HnAFUIQ9UeolUWZN
         k91kv+L8or7loFpQZLNV5WEwEWE5u3yvfqQ5tDtBLc5+1uVUXZNXWrrbwMMnZolITS2B
         oryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628437; x=1761233237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUnzh4YZaBSEW3/Ot9CVGb4TXhYMxv9bzIKKvA4RBT4=;
        b=uXc7gWkPXsDLCEa6ZhIEhJGEHGNcAVHsoRMo6Q48oe7iow+fZ3qcklyHIgg12FjuWM
         gI5aTjxlH8sP7AgiN1L1UXG8c+Z4gxcab7LWesqUMWZzPuR4rzZcnLXAoul4oCVeXDnp
         AIrjJqAOauN7k+SbURqxYcX+oWnKTm9+SjE5PeBBPh87YWw9MSRSNnh+cfnAYyoT+rOJ
         NHKeiKCjGDmvUpKiYHMEfUekHlsEktmQ92XGogH2EGzRHfag6xYQVVPP/kQngTfQMytS
         Ttzkf/zfTEamLOpykJwdCkwud5AaBR5PtAj3hNdi0nHfMxmMeRh92R9udpLo4OHrF7Cu
         s0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVorSmP8I5Bix3kcQwnikYpPS+FcmbasJ6chc1gxRRamcrMiTFXsz63XxYMpxq+ZdMtkesH2Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRfIiPf6Dwzly74n/R/G/US9LIFEN5TekSkfK8QhH9kuy1Vs9
	R5ORajOWEor/BLEZYh4i8n8UOrzPGHdRTntfg8pz0/kPQYxpl0MOvz4TVzM8TwJ9xfv0fcJYXxB
	BxK9s/UALYbENZgZ9703TLBcYZnkBoB+JDq9bzFf0Do/MAEjmUoaZgCc2
X-Gm-Gg: ASbGncsu6rqDnu3d58rxVivzL/xkfONSBLvsVLi+6O90IHWYnOxuGjJAx7t6ECC/Fwh
	80N3H60a3MvewBhgtSS32AkGDNBgeaHVUJUeaVkOsynCh5v2bJ2oofVaqBrdkbnYXNMK3KTEti5
	QbsimPGbrUzvOKZQk8OE76tq7+hV7BrpHkNmS571BFAKu5HwZj2BZhB97BEZ7KQ5rDGFaj0v9j5
	tBFv7PpHyVGDx4rs2NUYEbNm/EdhezD+KrrFvWyc9G03AytoTo3ss22ximpjg==
X-Google-Smtp-Source: AGHT+IF9LFBAhYJX+p97HetyVeZU/bC0i5fBVyj1SCPzv/vK6K/sBqK6hHatjLpYqYZo55z8Ua6DxOsDqenovP9A9q0=
X-Received: by 2002:a05:622a:46:b0:4e8:8fd9:b28d with SMTP id
 d75a77b69052e-4e89d35c5f5mr7761531cf.43.1760628436649; Thu, 16 Oct 2025
 08:27:16 -0700 (PDT)
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
 <CANn89iJo-b=B7jUtbazcCtgKJrnbgdEXJ-OPvOwFziP_OSLaYA@mail.gmail.com> <73ead084-2761-4106-8149-36301d0b0ea0@intel.com>
In-Reply-To: <73ead084-2761-4106-8149-36301d0b0ea0@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 08:27:04 -0700
X-Gm-Features: AS18NWCIaSwewzhXbKdvranEESGQRIUAGtzIadTEPd3Xh9nZJC67x9M80HwPw0o
Message-ID: <CANn89i+9W3r+j0zVJcUsX=7LuzjAA2rimd6B-mG9d181jYpBJA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:24=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 16 Oct 2025 06:36:55 -0700
>
> > On Thu, Oct 16, 2025 at 6:29=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Thu, Oct 16, 2025 at 5:56=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>
> >>> On Thu, Oct 16, 2025 at 4:08=E2=80=AFAM Alexander Lobakin
> >>> <aleksander.lobakin@intel.com> wrote:
> >>>>
> >>>> From: Eric Dumazet <edumazet@google.com>
> >>>>
> >>>> BTW doesn't napi_skb_cache_get() (inc. get_bulk()) suffer the same w=
ay?
> >>>
> >>> Probably, like other calls to napi_skb_cache_put(()
> >>>
> >>> No loop there, so I guess there is no big deal.
> >>>
> >>> I was looking at napi_skb_cache_put() because there is a lack of NUMA=
 awareness,
> >>> and was curious to experiment with some strategies there.
> >>
> >> If we cache kmem_cache_size() in net_hotdata, the compiler is able to
> >> eliminate dead code
> >> for CONFIG_KASAN=3Dn
> >>
> >> Maybe this looks better ?
> >
> > No need to put this in net_hotdata, I was distracted by a 4byte hole
> > there, we can keep this hole for something  hot later.
>
> Yeah this looks good! It's not "hot" anyway, so let it lay freestanding.
>
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..f3b9356bebc06548a055355=
c5d1eb04c480f813f
> > 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -274,6 +274,8 @@ void *__netdev_alloc_frag_align(unsigned int
> > fragsz, unsigned int align_mask)
> >  }
> >  EXPORT_SYMBOL(__netdev_alloc_frag_align);
> >
> > +u32 skbuff_cache_size __read_mostly;
>
> ...but probably `static`?

Sure, I will add the static.

>
> > +
> >  static struct sk_buff *napi_skb_cache_get(void)
> >  {
> >         struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache)=
;
> > @@ -293,7 +295,7 @@ static struct sk_buff *napi_skb_cache_get(void)
> >
> >         skb =3D nc->skb_cache[--nc->skb_count];
> >         local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> > -       kasan_mempool_unpoison_object(skb,
> > kmem_cache_size(net_hotdata.skbuff_cache));
> > +       kasan_mempool_unpoison_object(skb, skbuff_cache_size);
> >
> >         return skb;
> >  }
> > @@ -1428,7 +1430,7 @@ static void napi_skb_cache_put(struct sk_buff *sk=
b)
> >         if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
> >                 for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE=
; i++)
> >                         kasan_mempool_unpoison_object(nc->skb_cache[i],
> > -
> > kmem_cache_size(net_hotdata.skbuff_cache));
> > +                                               skbuff_cache_size);
> >
> >                 kmem_cache_free_bulk(net_hotdata.skbuff_cache,
> > NAPI_SKB_CACHE_HALF,
> >                                      nc->skb_cache + NAPI_SKB_CACHE_HAL=
F);
> > @@ -5116,6 +5118,8 @@ void __init skb_init(void)
> >                                               offsetof(struct sk_buff, =
cb),
> >                                               sizeof_field(struct sk_bu=
ff, cb),
> >                                               NULL);
> > +       skbuff_cache_size =3D kmem_cache_size(net_hotdata.skbuff_cache)=
;
> > +
> >         net_hotdata.skbuff_fclone_cache =3D
> > kmem_cache_create("skbuff_fclone_cache",
> >                                                 sizeof(struct sk_buff_f=
clones),
> >                                                 0,
>
> Thanks,
> Olek

