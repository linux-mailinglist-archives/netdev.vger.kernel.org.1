Return-Path: <netdev+bounces-173199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B261A57DBE
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 20:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15711891533
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084DE1E51E5;
	Sat,  8 Mar 2025 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g73aAhfn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B77188CB1
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461752; cv=none; b=Vyp+HpOL2JpeQX4BBpozu01ZypBNvAT7nLmDwF2faDWUwTdyHa1t2hWDXAUEtc/k014+2yQcbCLeESbp09X3B3q1vHAUb8XtlsFDurecQJ/l4RNyJmtefcOiLC+2mYj/gI4l0dw+8poHHjfrQM8SQszGLpxHtIRmckUK3Gl2baE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461752; c=relaxed/simple;
	bh=8NyfTLEfNNSIgTyDsxV1fwG1GEL3Tw6mxrigRdp4EJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i78+CPrHvY9I9nnDTVLKOHZK91t1enIG/QEvwdkndN/IkQWpSR+/J1TrL+EHhX9E/oetIAI8IXMFnXN/+W9kJUE/f9l1hzn/UwTNgzP0g3Zu8FKlr+SSqRGffodz1pMukDK7sMubX/xjkzQwYKReXz7OU4+epbYPp7cdic9G4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g73aAhfn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240aad70f2so95235ad.0
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 11:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741461750; x=1742066550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ohk4ZGzrKb24wO0NxSW3j8TMIMIVLFeUJRm6pP0vhoI=;
        b=g73aAhfnSmldPrsWrB7IvQgox7HxieCeuorWZyncvXgCKBUkXrZhQ3aeFzV9kMtw6/
         L/0qqKrXJmLpfIW7uZCt9e0koqsMJtCT6qhW5YJLvJBPIgqQNzlO3JqTMvQJmRC4atJd
         0EvNSyP/q4tim98ba55w4sVTg8kMosEhciPd27qsReBsdXyrBVzGBLxizYNgKOL8Bya7
         MRje7U76EscEKifWXG9bKiSKBhEfmxwly9hA/Da6sQ0Fm5RKnJBjbswfIMxIu+fzbuHO
         +Ye0LXUClsO4CZhOxRnOy4nWVYoqAZ1mHXE3J7sXCwcglnYKu+aSNCJqXK/BUM3Gbulz
         TgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741461750; x=1742066550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ohk4ZGzrKb24wO0NxSW3j8TMIMIVLFeUJRm6pP0vhoI=;
        b=aV24aZhnTaabBkhG/HGdz+F87e+mgVxwEzl5bb/INquhf79wRS/a6K2qhKO/oYe5RL
         r6ygy8Boe+ko+sslEYyZqxU8ODCgPWXG/Zgjov9h1MR/I+KSkqteEaiMmFaRkQ07YJGg
         idfz2BmeFmVSyGcTxNg+0kRf8nXVoSHSApXDSSvF1pwPK81Is13QuQ8fYlD91L2SDAxW
         A+45x35ZWHAbD/0qmH7uYVD0+qctkB1xbVDMGGye2uCcLx5n5RzvPPX+Lz7DLxHhm8TB
         l4pQlRydBrhgjC9rJzSuWxzGTrZa/ionY+Ta72n7T2YXPwArOCVB+MHwnSo7f6ZmvKBY
         79PA==
X-Forwarded-Encrypted: i=1; AJvYcCU6HAZW9CkpCHOXfjsHpoAZRVy7lVtgCorq252l4PpPvzaO4dsiEAKzhaHgANt+xdPcyIiMUk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDGm7aMipSk0cIaPX87K4DOUYNLgYb69C1aQW1pYiqpe0CDg0
	8AIoa7M+PHEb8Mnl0/+14T2fl3C6I2f7TPLM6PxStzQMg0s/p1EjvO3OGoofxDsNrxCjncWCek/
	NBYT3VBoxZ8QCWgeya9vYGeiVSFzV6BnYCEWH
X-Gm-Gg: ASbGnctGnP70qdTvNWGzYpBPlhZJWjvaamoPbceRWn25B23OMNFYJHmdO90x27CNcCh
	wqXnsm2mSD19y07ugd5xGwrS7ay/DVJAQ1OeIQgMBAR3osPxQQGnSuLawPU/VSzfG0vl7dCFn9K
	w3HUSolWilCjN3miVLJEchV71WwNY=
X-Google-Smtp-Source: AGHT+IFSIs79HgmgHgtKAR7enQqs0R9subNe5uCAm9nCjK5vphbIXdFsgLIb2CNs2BIb4dBtE8L+EIXRhWwoHmYCxpc=
X-Received: by 2002:a17:902:f693:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-22540d84badmr2018635ad.0.1741461749925; Sat, 08 Mar 2025
 11:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308145500.14046-1-toke@redhat.com>
In-Reply-To: <20250308145500.14046-1-toke@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 8 Mar 2025 11:22:16 -0800
X-Gm-Features: AQ5f1JrR286rUechKgWwQfHsS5kkOGQfcIwm1OTdS6Y6I_-SSJkSLVMw_RjZrfM
Message-ID: <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 6:55=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
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
> get/put_device() calls in page_pool.

THANK YOU!! I had been looking at the other proposals to fix this here
and there and I had similar feelings to you. They add lots of code
changes and the code changes themselves were hard for me to
understand. I hope we can make this simpler approach work.

> Using xa_cmpxchg(), no additional
> synchronisation is needed, as a page will only ever be unmapped once.
>

Very clever. I had been wondering how to handle the concurrency. I
also think this works.

> To avoid having to walk the entire xarray on unmap to find the page
> reference, we stash the ID assigned by xa_alloc() into the page
> structure itself, in the field previously called '_pp_mapping_pad' in
> the page_pool struct inside struct page. This field overlaps with the
> page->mapping pointer, which may turn out to be problematic, so an
> alternative is probably needed. Sticking the ID into some of the upper
> bits of page->pp_magic may work as an alternative, but that requires
> further investigation. Using the 'mapping' field works well enough as
> a demonstration for this RFC, though.
>

I'm unsure about this. I think page->mapping may be used when we map
the page to the userspace in TCP zerocopy, but I'm really not sure.
Yes, finding somewhere else to put the id would be ideal. Do we really
need a full unsigned long for the pp_magic?

> Since all the tracking is performed on DMA map/unmap, no additional code
> is needed in the fast path, meaning the performance overhead of this
> tracking is negligible. The extra memory needed to track the pages is
> neatly encapsulated inside xarray, which uses the 'struct xa_node'
> structure to track items. This structure is 576 bytes long, with slots
> for 64 items, meaning that a full node occurs only 9 bytes of overhead
> per slot it tracks (in practice, it probably won't be this efficient,
> but in any case it should be an acceptable overhead).
>

Yes, I think I also saw in another thread that this version actually
produces better perf results than the more complicated version,
because the page_pool benchmark actually does no mapping and this
version doesn't add overhead when there is no mapping.

As an aside I have it in my todo list to put the page_pool benchmark
in the upstream kernel so we don't have to run out-of-tree versions.

> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KB=
G9DcVJcyWg@mail.gmail.com/
>
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

I'm only holding back my Reviewed-by for the page->mapping issue.
Other than that, I think this is great. Thank you very much for
looking.

Pavel, David, as an aside, I think we need to propagate this fix to
memory providers as a follow up. We probably need a new op in the
provider to unmap. Then, in page_pool_scrub, where this patch does an
xa_for_each, we need to call that unmap op.

For the io_uring memory provider, I think it needs to unmap its memory
(and record it did so, so it doesn't re-unmap it later).

For the dmabuf memory provider, I think maybe we need to call
dma_buf_unmap_attachment (and record we did that, so we don't re-do it
later).

I don't think propagating this fix to memory providers should block
merging the fix for pages, IMO.

> ---
> This is an alternative to Yunsheng's series. Yunsheng requested I send
> this as an RFC to better be able to discuss the different approaches; see
> some initial discussion in[1], also regarding where to store the ID as
> alluded to above.
>
> -Toke
>
> [1] https://lore.kernel.org/r/40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.=
com
>
>  include/linux/mm_types.h      |  2 +-
>  include/net/page_pool/types.h |  2 ++
>  net/core/netmem_priv.h        | 17 +++++++++++++
>  net/core/page_pool.c          | 46 +++++++++++++++++++++++++++++------
>  4 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6..d2c7a7b04bea 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -121,7 +121,7 @@ struct page {
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
> -                       unsigned long _pp_mapping_pad;
> +                       unsigned long pp_dma_index;
>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
>                 };
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 36eb57d73abc..13597a77aa36 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -221,6 +221,8 @@ struct page_pool {
>         void *mp_priv;
>         const struct memory_provider_ops *mp_ops;
>
> +       struct xarray dma_mapped;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         /* recycle stats are per-cpu to avoid locking */
>         struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index 7eadb8393e00..59679406a7b7 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -28,4 +28,21 @@ static inline void netmem_set_dma_addr(netmem_ref netm=
em,
>  {
>         __netmem_clear_lsb(netmem)->dma_addr =3D dma_addr;
>  }
> +
> +static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
> +{
> +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
> +               return 0;
> +
> +       return netmem_to_page(netmem)->pp_dma_index;
> +}
> +
> +static inline void netmem_set_dma_index(netmem_ref netmem,
> +                                       unsigned long id)
> +{
> +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
> +               return;
> +
> +       netmem_to_page(netmem)->pp_dma_index =3D id;
> +}
>  #endif
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index acef1fcd8ddc..d5530f29bf62 100644
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
> +                              XA_LIMIT(1, UINT_MAX), gfp);
> +       else
> +               err =3D xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_pag=
e(netmem),
> +                                 XA_LIMIT(1, UINT_MAX), gfp);

nit: I think xa_limit_32b works here, because XA_FLAGS_ALLOC1 avoids 1 anyw=
ay.

--=20
Thanks,
Mina

