Return-Path: <netdev+bounces-137085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4519A4565
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453BF281EFD
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8520403F;
	Fri, 18 Oct 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqYy/M64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AA20264A;
	Fri, 18 Oct 2024 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274624; cv=none; b=mRuizrsv34FizkjuBVQ0V2zhjDTwNub+3Ex+H1RIopq4DevXNxRoQMJRq2tpkJLB/ajqTZs24kLBm3EhvOyT/rW40g289tVy/Pqw2Gd4W70VV2b7JMedTSz65eHlp/3keqqjNgiUGBCaM3fVeb7Rj4O6jEUTVumgIzWa8AbGugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274624; c=relaxed/simple;
	bh=lAq2B0GvCFBF3V9+QW5Jia+LxcIEjnw82vPSQ1vinIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ori0/4kwyDJlIl93IRQlUykZGEQhx827rvbHlozcNIqlGcT9Y46XDnr8+6KIW44Ihc5uyJflx6B57P2Jt5khf2CaY47FjJzz6KmEXD84EwfT/ELXCsNTG71U/5pIr59THVvuhjfTCrL+KEFKiBMQci/+E907Ia6xwKOd0pbHZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqYy/M64; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so21652825e9.3;
        Fri, 18 Oct 2024 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729274621; x=1729879421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTl/hUSj/UfTQkYKvku3PzPI4RSkWnNGUZziFInNPIM=;
        b=CqYy/M6486B6XQyMcxSY5YMGJcigTY0YWNvbEBD3/LFv6gqSXcVujbLstjodj4H9dU
         YYWEujqkRXo2Bpv4Fh3GPV9K7NyLbpFX7r9tWv1EX5D5/lXBI/huws06lOjxmgLDzvV3
         u7u/b29TcJWNmS+QN+bHexTmqJ2RccJG/fDW1QTc8YJXBULOinJoPm22v1diVQuwraw0
         8aqu19iPwRTFr9yERDVpKVRLw0MFp6q9YeZjwUrVSOVQp1bdv5VK3rubqQGa/lUWFm4k
         1N4HR/4/Tj7QIm+CiAKtQRGHYZHpszpXyJVrrY3vsn4tQCMBoC+4QPzO65iup6Z1K/gJ
         LVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274621; x=1729879421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTl/hUSj/UfTQkYKvku3PzPI4RSkWnNGUZziFInNPIM=;
        b=BQJAMlfpeomCIRf+K25q4vpsC8e5AIgN8nvCRVcYcuB+38nSHYcpbTq1waj0s4nXPM
         TR7ZWKUtW4Gu9feGHsiaw2LRqcD9G2ncz2T68iqE48594L5PqERi4Qp0AbEen9qfoJsO
         Xt+McwC1N99RLYTgiXxLhi5ORQP7hKf9eXE0OF4g/cGsocJJo/FEeechTn03wrUsMfdA
         HEN05EMZNquIiUoVoGhnjx0N3S+dHz9bK9CqwsPBQoi/WuwSRikUE4RN5sbj16az75c+
         o6tyKgEaPtZZX4aCGm/b7yYsif3PVL+c6ZNn1i4w+X0AgVloH2SB0VCRKgvTVE2DnFrg
         UGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0n9vb6zqGX66VPckGjm3gk7B29i3RxFjIIRoL4H0jLihElCO3ed1JkbNayh1vmMWoq+R72cxE17nHytU=@vger.kernel.org, AJvYcCXISw1TiA7j7KkcmoZOwVKEjrVc1PutNYQ/1Cae2rXrNmGXQpIyV/BhMoxjodYr6FXQgemJwZnp@vger.kernel.org
X-Gm-Message-State: AOJu0YzfX80ptnS5IR+Ssn2x2NwDE2SrzBryvXoxN0EnmwIpzxZxHLqJ
	VI7o0v0G1Yw2mkzID08L8nAI6Xfq0zkO5369CBY7Rt4qfIC9qKazCTgzMPmz8ZOec2ykhXLBEMR
	lYkpCzqzfslVYD4t7EPEHtJYA0vU=
X-Google-Smtp-Source: AGHT+IE53tP/trlIJhSThzo1jS5+hYd/nfh5lSF33/o7kCnAusq4BXbw0lmSqvYd8tM3bVJv0VSKJ2Rfe3i2z4xiiiI=
X-Received: by 2002:a5d:6892:0:b0:37d:890c:f485 with SMTP id
 ffacd0b85a97d-37ea21949e5mr2865340f8f.25.1729274620408; Fri, 18 Oct 2024
 11:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105351.1960345-1-linyunsheng@huawei.com> <20241018105351.1960345-11-linyunsheng@huawei.com>
In-Reply-To: <20241018105351.1960345-11-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 18 Oct 2024 11:03:03 -0700
Message-ID: <CAKgT0UcrbmhJCm4=30Y12ZX9bWD_ChTn5vqHxKdTrGBP-FLk5w@mail.gmail.com>
Subject: Re: [PATCH net-next v22 10/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> There are many use cases that need minimum memory in order
> for forward progress, but more performant if more memory is
> available or need to probe the cache info to use any memory
> available for frag caoleasing reason.
>
> Currently skb_page_frag_refill() API is used to solve the
> above use cases, but caller needs to know about the internal
> detail and access the data field of 'struct page_frag' to
> meet the requirement of the above use cases and its
> implementation is similar to the one in mm subsystem.
>
> To unify those two page_frag implementations, introduce a
> prepare API to ensure minimum memory is satisfied and return
> how much the actual memory is available to the caller and a
> probe API to report the current available memory to caller
> without doing cache refilling. The caller needs to either call
> the commit API to report how much memory it actually uses, or
> not do so if deciding to not use any memory.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h | 130 ++++++++++++++++++++++++++++++++
>  mm/page_frag_cache.c            |  21 ++++++
>  2 files changed, 151 insertions(+)
>
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index feed99d0cddb..1c0c11250b66 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -46,6 +46,10 @@ void *__page_frag_cache_prepare(struct page_frag_cache=
 *nc, unsigned int fragsz,
>  unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
>                                             struct page_frag *pfrag,
>                                             unsigned int used_sz);
> +void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
> +                                          unsigned int fragsz,
> +                                          struct page_frag *pfrag,
> +                                          unsigned int align_mask);
>
>  static inline unsigned int __page_frag_cache_commit(struct page_frag_cac=
he *nc,
>                                                     struct page_frag *pfr=
ag,
> @@ -88,6 +92,132 @@ static inline void *page_frag_alloc(struct page_frag_=
cache *nc,
>         return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
>  }
>
> +static inline bool __page_frag_refill_align(struct page_frag_cache *nc,
> +                                           unsigned int fragsz,
> +                                           struct page_frag *pfrag,
> +                                           gfp_t gfp_mask,
> +                                           unsigned int align_mask)
> +{
> +       if (unlikely(!__page_frag_cache_prepare(nc, fragsz, pfrag, gfp_ma=
sk,
> +                                               align_mask)))
> +               return false;
> +
> +       __page_frag_cache_commit(nc, pfrag, fragsz);
> +       return true;
> +}
> +
> +static inline bool page_frag_refill_align(struct page_frag_cache *nc,
> +                                         unsigned int fragsz,
> +                                         struct page_frag *pfrag,
> +                                         gfp_t gfp_mask, unsigned int al=
ign)
> +{
> +       WARN_ON_ONCE(!is_power_of_2(align));
> +       return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, -ali=
gn);
> +}
> +
> +static inline bool page_frag_refill(struct page_frag_cache *nc,
> +                                   unsigned int fragsz,
> +                                   struct page_frag *pfrag, gfp_t gfp_ma=
sk)
> +{
> +       return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, ~0u)=
;
> +}
> +
> +static inline bool __page_frag_refill_prepare_align(struct page_frag_cac=
he *nc,
> +                                                   unsigned int fragsz,
> +                                                   struct page_frag *pfr=
ag,
> +                                                   gfp_t gfp_mask,
> +                                                   unsigned int align_ma=
sk)
> +{
> +       return !!__page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask,
> +                                          align_mask);
> +}
> +
> +static inline bool page_frag_refill_prepare_align(struct page_frag_cache=
 *nc,
> +                                                 unsigned int fragsz,
> +                                                 struct page_frag *pfrag=
,
> +                                                 gfp_t gfp_mask,
> +                                                 unsigned int align)
> +{
> +       WARN_ON_ONCE(!is_power_of_2(align));
> +       return __page_frag_refill_prepare_align(nc, fragsz, pfrag, gfp_ma=
sk,
> +                                               -align);
> +}
> +
> +static inline bool page_frag_refill_prepare(struct page_frag_cache *nc,
> +                                           unsigned int fragsz,
> +                                           struct page_frag *pfrag,
> +                                           gfp_t gfp_mask)
> +{
> +       return __page_frag_refill_prepare_align(nc, fragsz, pfrag, gfp_ma=
sk,
> +                                               ~0u);
> +}
> +
> +static inline void *__page_frag_alloc_refill_prepare_align(struct page_f=
rag_cache *nc,
> +                                                          unsigned int f=
ragsz,
> +                                                          struct page_fr=
ag *pfrag,
> +                                                          gfp_t gfp_mask=
,
> +                                                          unsigned int a=
lign_mask)
> +{
> +       return __page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask, ali=
gn_mask);
> +}
> +
> +static inline void *page_frag_alloc_refill_prepare_align(struct page_fra=
g_cache *nc,
> +                                                        unsigned int fra=
gsz,
> +                                                        struct page_frag=
 *pfrag,
> +                                                        gfp_t gfp_mask,
> +                                                        unsigned int ali=
gn)
> +{
> +       WARN_ON_ONCE(!is_power_of_2(align));
> +       return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
> +                                                     gfp_mask, -align);
> +}
> +
> +static inline void *page_frag_alloc_refill_prepare(struct page_frag_cach=
e *nc,
> +                                                  unsigned int fragsz,
> +                                                  struct page_frag *pfra=
g,
> +                                                  gfp_t gfp_mask)
> +{
> +       return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
> +                                                     gfp_mask, ~0u);
> +}
> +
> +static inline void *page_frag_alloc_refill_probe(struct page_frag_cache =
*nc,
> +                                                unsigned int fragsz,
> +                                                struct page_frag *pfrag)
> +{
> +       return __page_frag_alloc_refill_probe_align(nc, fragsz, pfrag, ~0=
u);
> +}
> +
> +static inline bool page_frag_refill_probe(struct page_frag_cache *nc,
> +                                         unsigned int fragsz,
> +                                         struct page_frag *pfrag)
> +{
> +       return !!page_frag_alloc_refill_probe(nc, fragsz, pfrag);
> +}
> +
> +static inline void page_frag_commit(struct page_frag_cache *nc,
> +                                   struct page_frag *pfrag,
> +                                   unsigned int used_sz)
> +{
> +       __page_frag_cache_commit(nc, pfrag, used_sz);
> +}
> +
> +static inline void page_frag_commit_noref(struct page_frag_cache *nc,
> +                                         struct page_frag *pfrag,
> +                                         unsigned int used_sz)
> +{
> +       __page_frag_cache_commit_noref(nc, pfrag, used_sz);
> +}
> +

Not a huge fan of introducing a ton of new API calls and then having
to have them all applied at once in the follow-on patches. Ideally the
functions and the header documentation for them would be introduced in
the same patch as well as examples on how it would be used.

I really think we should break these up as some are used in one case,
and others in another and it is a pain to have a pile of abstractions
that are all using these functions in different ways.

> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
> +                                        unsigned int fragsz)
> +{
> +       VM_BUG_ON(fragsz > nc->offset);
> +
> +       nc->pagecnt_bias++;
> +       nc->offset -=3D fragsz;
> +}
> +

We should probably have the same checks here you had on the earlier
commit. We should not be allowing blind changes. If we are using the
commit or abort interfaces we should be verifying a page frag with
them to verify that the request to modify this is legitimate.

>  void page_frag_free(void *addr);
>
>  #endif
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index f55d34cf7d43..5ea4b663ab8e 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -112,6 +112,27 @@ unsigned int __page_frag_cache_commit_noref(struct p=
age_frag_cache *nc,
>  }
>  EXPORT_SYMBOL(__page_frag_cache_commit_noref);
>
> +void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
> +                                          unsigned int fragsz,
> +                                          struct page_frag *pfrag,
> +                                          unsigned int align_mask)
> +{
> +       unsigned long encoded_page =3D nc->encoded_page;
> +       unsigned int size, offset;
> +
> +       size =3D PAGE_SIZE << encoded_page_decode_order(encoded_page);
> +       offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> +       if (unlikely(!encoded_page || offset + fragsz > size))
> +               return NULL;
> +
> +       pfrag->page =3D encoded_page_decode_page(encoded_page);
> +       pfrag->size =3D size - offset;
> +       pfrag->offset =3D offset;
> +
> +       return encoded_page_decode_virt(encoded_page) + offset;
> +}
> +EXPORT_SYMBOL(__page_frag_alloc_refill_probe_align);
> +

If I am not mistaken this would be the equivalent of allocating a size
0 fragment right? The only difference is that you are copying out the
"remaining" size, but we could get that from the offset if we knew the
size couldn't we? Would it maybe make sense to look at limiting this
to PAGE_SIZE instead of passing the size of the actual fragment?

>  void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int=
 fragsz,
>                                 struct page_frag *pfrag, gfp_t gfp_mask,
>                                 unsigned int align_mask)
> --
> 2.33.0
>

