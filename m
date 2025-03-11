Return-Path: <netdev+bounces-173925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C026A5C3CE
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195A73A4FDF
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02F18A93C;
	Tue, 11 Mar 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5RrhMgm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13397E0FF
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703426; cv=none; b=twsf8pQbW/N/miUgAlX+uuTEIL6m+UZJia5NMK/NAzixRjgMVy1/dn/it/aQcxK/b9CNcwaGLphOZZ5w1olCgiVF9nEP6gDxAHZNobx2gHereZ7DjOSUcJgIZMzK1pmwkEN+DAgkLbIF3Io6BsGpnMmqB91lxS+BGWz96IcaBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703426; c=relaxed/simple;
	bh=ToLXW1npubV6+MA5hkrEj0NL95l9dDD6uQ5SvW+kKyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy+sOGN4VJr1WHsZ7DjcOSqYGjy0jY1iftkMkZOMlv8WFlgGskoZUVSDEIk70lhERvvYxPztmJ73LC3TAZrCfOjGUIWnLxeEAaelsksmcKjU7RMADNAGZ+VSg3wAvjl3oC7ciqtdJX83bhu+uA5Z+c4x3Vj+NJMrgqbu9oLkeKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5RrhMgm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so10494a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 07:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741703423; x=1742308223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2auOPhi4bZIiEkHpb0cKBJRANdnlQ5+djIgXbuC94M=;
        b=E5RrhMgm0nCUul4s7aGu6vgHLAHUEsHxWO9iYEL+o43Ym53iB8JU6hEP8H0ny9Dfek
         Of1ykcbvteZi5Dv6lMkERPhD8NZF4ZypZNU+JNiPP1MlKu+pvV1oMlnqhbJFwXqu6Mlb
         zPka4rptenzhUx05/+712oSKIMlJb86QJjrtAo6TaCu1XUYl21xbIPFikwtGvcEXL/Ku
         S2gIJDhHQds3iW41PLV/Jaw1R9Q047ouCMD5fvoqMA+n8pydxkx9VRg3d2al3mn7Zqoj
         y0kSerN0pDjau1qLJEgmLro40L4E9I8PS1/CpK15w+kwHumHEm1MxXe0GK0y2KzFcLXC
         GIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703423; x=1742308223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2auOPhi4bZIiEkHpb0cKBJRANdnlQ5+djIgXbuC94M=;
        b=Cf49Y5GPNz+Am9k9FxMrf0EmRshNnqtVR21ywc5X6Uq0oUkyf/E4IlILBRHzWdo0Pd
         XlPIMr1ElUMAu1RI62KlbovEeu4Y5zzGLRiCbU6/UkTM2W1z5rBlLVnY+oIKmTR9a1T3
         9icS/CbqSwIt66F7PJkHx6CpQxmBZu+SnERhpYkYlDLI5fC94EX9Rq8U/+tEthEt9QLc
         yqhxRwlpuT3XpXO/OCYTgLSj2HecgRFoK8yM2/7c4ZzNkbpzjGw4JX3NVAQnsrhhzvDr
         rykYNUAuHXAsoDN1fAOgH9h1OuP9k8XwgVwtnoXAmi67NvDxsDYdrcOr8M//uhDdA4YJ
         qOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpNLIS+5GxD1z9dNS3FhYP7mtCwhPAV/hqnf/3fZCjmGNifs7EKpuHW3BTOnAkt7VEvYLJjBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSqzUK9ahqgbDPyRkHTLvHlL/+TVDQLwbJ05rd1iGoamblsoH
	e2wqOCYprSPcZNQz951YK7jz2yuOF8YZOiH2/65fK4iGRtazuILd/jzXsEbyti7wPjvldqNwdbo
	PHqp/f7BqgzRMbYBXzdriUhgIuxjaKMN9297N
X-Gm-Gg: ASbGncsoTUk5flMYiRb/5mM3y6hxVDOV51kx536hvmixSNSMftLh8Kep4Uor5SqOmyh
	PnTc9Mum+njjr1p+tF6tsMH1CRNqMmLxC5mZnmdYBAJIJmJVh6QEX1RQxco4Q6bS5H8yMQUyPrV
	9IK0sS384tGoGTAj2Y2dDC9DKgpl+ZLJsCZJx0Glg1qCvYz/NlTXDvpXFiskK77DPy/gc=
X-Google-Smtp-Source: AGHT+IF7T4Q2CwdauwrENB4nIZYdP+6YCQX2JnxyVQFLj1OGrTXnHnehLQpgoHBXfu24l18e0NhQyfUYh5Nx8SzXGJE=
X-Received: by 2002:a05:6402:31ea:b0:5e5:be08:c07d with SMTP id
 4fb4d7f45d1cf-5e61993e1f8mr279820a12.7.1741703422692; Tue, 11 Mar 2025
 07:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309124719.21285-1-toke@redhat.com>
In-Reply-To: <20250309124719.21285-1-toke@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 07:30:07 -0700
X-Gm-Features: AQ5f1Jo0UYY1RggkgZBTxiHW6OjZU8Qa5a_G5kqjEHQr8gG_5_U-JbQuCn9uH0k
Message-ID: <CAHS8izNY73aJ+_JHX0mWWG-ZFfgUvAeYxjQTN2fCyx-3ynD5Hw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:50=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
> they are released from the pool, to avoid the overhead of re-mapping the
> pages every time they are used. This causes problems when a device is
> torn down, because the page pool can't unmap the pages until they are
> returned to the pool. This causes resource leaks and/or crashes when
> there are pages still outstanding while the device is torn down, because
> page_pool will attempt an unmap of a non-existent DMA device on the
> subsequent page return.
>
> To fix this, implement a simple tracking of outstanding dma-mapped pages
> in page pool using an xarray. This was first suggested by Mina[0], and
> turns out to be fairly straight forward: We simply store pointers to
> pages directly in the xarray with xa_alloc() when they are first DMA
> mapped, and remove them from the array on unmap. Then, when a page pool
> is torn down, it can simply walk the xarray and unmap all pages still
> present there before returning, which also allows us to get rid of the
> get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
> synchronisation is needed, as a page will only ever be unmapped once.
>
> To avoid having to walk the entire xarray on unmap to find the page
> reference, we stash the ID assigned by xa_alloc() into the page
> structure itself, using the upper bits of the pp_magic field. This
> requires a couple of defines to avoid conflicting with the
> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
> so should not affect run-time performance.
>
> Since all the tracking is performed on DMA map/unmap, no additional code
> is needed in the fast path, meaning the performance overhead of this
> tracking is negligible. The extra memory needed to track the pages is
> neatly encapsulated inside xarray, which uses the 'struct xa_node'
> structure to track items. This structure is 576 bytes long, with slots
> for 64 items, meaning that a full node occurs only 9 bytes of overhead
> per slot it tracks (in practice, it probably won't be this efficient,
> but in any case it should be an acceptable overhead).
>
> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KB=
G9DcVJcyWg@mail.gmail.com/
>
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

I only have nits and suggestions for improvement. With and without those:

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
> v2:
>   - Stash the id in the pp_magic field of struct page instead of
>     overwriting the mapping field. This version is compile-tested only.
>
>  include/net/page_pool/types.h | 31 +++++++++++++++++++++++
>  mm/page_alloc.c               |  3 ++-
>  net/core/netmem_priv.h        | 35 +++++++++++++++++++++++++-
>  net/core/page_pool.c          | 46 +++++++++++++++++++++++++++++------
>  4 files changed, 105 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 36eb57d73abc..d879a505ca4d 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -6,6 +6,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/ptr_ring.h>
>  #include <linux/types.h>
> +#include <linux/xarray.h>
>  #include <net/netmem.h>
>
>  #define PP_FLAG_DMA_MAP                BIT(0) /* Should page_pool do the=
 DMA
> @@ -54,6 +55,34 @@ struct pp_alloc_cache {
>         netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>  };
>
> +/*
> + * DMA mapping IDs
> + *
> + * When DMA-mapping a page, we allocate an ID (from an xarray) and stash=
 this in
> + * the upper bits of page->pp_magic. The number of bits available here i=
s
> + * constrained by the size of an unsigned long, and the definition of
> + * PP_SIGNATURE.
> + */
> +#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELT=
A))
> +#define _PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - =
1)
> +
> +#if POISON_POINTER_DELTA > 0
> +/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the =
DMA
> + * index to not overlap with that if set
> + */
> +#define PP_DMA_INDEX_BITS MIN(_PP_DMA_INDEX_BITS, \
> +                             __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_=
SHIFT)
> +#else
> +#define PP_DMA_INDEX_BITS _PP_DMA_INDEX_BITS
> +#endif
> +
> +#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT=
 - 1, \
> +                                 PP_DMA_INDEX_SHIFT)
> +#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
> +
> +/* For check in page_alloc.c */
> +#define PP_MAGIC_MASK (~(PP_DMA_INDEX_MASK | 0x3))
> +
>  /**
>   * struct page_pool_params - page pool parameters
>   * @fast:      params accessed frequently on hotpath
> @@ -221,6 +250,8 @@ struct page_pool {
>         void *mp_priv;
>         const struct memory_provider_ops *mp_ops;
>
> +       struct xarray dma_mapped;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         /* recycle stats are per-cpu to avoid locking */
>         struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 579789600a3c..96776e7b2301 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
> +#include <net/page_pool/types.h>
>  #include <asm/div64.h>
>  #include "internal.h"
>  #include "shuffle.h"
> @@ -873,7 +874,7 @@ static inline bool page_expected_state(struct page *p=
age,
>                         page->memcg_data |
>  #endif
>  #ifdef CONFIG_PAGE_POOL
> -                       ((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
> +                       ((page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNA=
TURE) |
>  #endif
>                         (page->flags & check_flags)))
>                 return false;
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index 7eadb8393e00..59face70f40d 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -3,10 +3,19 @@
>  #ifndef __NETMEM_PRIV_H
>  #define __NETMEM_PRIV_H
>
> -static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
> +static inline unsigned long _netmem_get_pp_magic(netmem_ref netmem)

Nit: maybe __netmem_get...() To be consistent (I used double
underscore elsewhere).

>  {
>         return __netmem_clear_lsb(netmem)->pp_magic;
>  }

nit: newline between function definitions.

> +static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
> +{
> +       return _netmem_get_pp_magic(netmem) & ~PP_DMA_INDEX_MASK;
> +}
> +
> +static inline void netmem_set_pp_magic(netmem_ref netmem, unsigned long =
pp_magic)
> +{
> +       __netmem_clear_lsb(netmem)->pp_magic =3D pp_magic;
> +}
>
>  static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long p=
p_magic)
>  {
> @@ -28,4 +37,28 @@ static inline void netmem_set_dma_addr(netmem_ref netm=
em,
>  {
>         __netmem_clear_lsb(netmem)->dma_addr =3D dma_addr;
>  }
> +
> +static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
> +{
> +       unsigned long magic;
> +
> +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
> +               return 0;
> +
> +       magic =3D _netmem_get_pp_magic(netmem);
> +
> +       return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
> +}
> +
> +static inline void netmem_set_dma_index(netmem_ref netmem,
> +                                       unsigned long id)
> +{
> +       unsigned long magic;
> +
> +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
> +               return;
> +
> +       magic =3D netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT=
);
> +       netmem_set_pp_magic(netmem, magic);
> +}
>  #endif
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index acef1fcd8ddc..dceef9b82198 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -226,6 +226,8 @@ static int page_pool_init(struct page_pool *pool,
>                         return -EINVAL;
>
>                 pool->dma_map =3D true;
> +
> +               xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
>         }
>
>         if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
> @@ -275,9 +277,6 @@ static int page_pool_init(struct page_pool *pool,
>         /* Driver calling page_pool_create() also call page_pool_destroy(=
) */
>         refcount_set(&pool->user_cnt, 1);
>
> -       if (pool->dma_map)
> -               get_device(pool->p.dev);
> -
>         if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>                 /* We rely on rtnl_lock()ing to make sure netdev_rx_queue
>                  * configuration doesn't change while we're initializing
> @@ -325,7 +324,7 @@ static void page_pool_uninit(struct page_pool *pool)
>         ptr_ring_cleanup(&pool->ring, NULL);
>
>         if (pool->dma_map)
> -               put_device(pool->p.dev);
> +               xa_destroy(&pool->dma_mapped);
>
>  #ifdef CONFIG_PAGE_POOL_STATS
>         if (!pool->system)
> @@ -470,9 +469,11 @@ page_pool_dma_sync_for_device(const struct page_pool=
 *pool,
>                 __page_pool_dma_sync_for_device(pool, netmem, dma_sync_si=
ze);
>  }
>
> -static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
> +static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem,=
 gfp_t gfp)
>  {
>         dma_addr_t dma;
> +       int err;
> +       u32 id;
>
>         /* Setup DMA mapping: use 'struct page' area for storing DMA-addr
>          * since dma_addr_t can be either 32 or 64 bits and does not alwa=
ys fit
> @@ -486,9 +487,19 @@ static bool page_pool_dma_map(struct page_pool *pool=
, netmem_ref netmem)
>         if (dma_mapping_error(pool->p.dev, dma))
>                 return false;
>
> +       if (in_softirq())
> +               err =3D xa_alloc(&pool->dma_mapped, &id, netmem_to_page(n=
etmem),
> +                              PP_DMA_INDEX_LIMIT, gfp);
> +       else
> +               err =3D xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_pag=
e(netmem),
> +                                 PP_DMA_INDEX_LIMIT, gfp);

I think there is a bit of discussion on this thread on whether
PP_DMA_INDEX_LIMIT is going to be large enough.

xa_alloc() returns -EBUSY if there are no available entries in the
xarray. How about we do a rate-limited pr_err or
DEBUG_NET_WARN_ON_ONCE when that happens?

From your math above it looks like we should have enough bits for
page_pools on 32-bits systems, but it may be good to warn when we hit
that limit.


--=20
Thanks,
Mina

