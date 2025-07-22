Return-Path: <netdev+bounces-209120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F240B0E651
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA1B1C85134
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E62874F2;
	Tue, 22 Jul 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmPmVruN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008EA937
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222652; cv=none; b=h7bCN2raPrPTrc0h4a8tGhxXLd65Nez+KR/Tw2ru1J/nKx8tw5uIPaIft2tdbYj+OkX5dYA4MU1WFj7iO6RDwUIXKFCcjdbf/0oO2gZdJEiCGhpyKXiirWeWfpUlyN7t2uDcAPXIKR4LzIoEVOS/rJZ/XQz8aMM1dzhGGkVXRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222652; c=relaxed/simple;
	bh=acLwYI+N/5u6Oa1eyWNy8txGMZV7MCxJjJ2D4IOQ6D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWCh0tThWS2Q3cmsMmtI8Ft2PkEB2POer52oOX90iIJ+GaIdXmrg8DgoTYtElZr4vato4zpE5lp6XLlod6PiJXFjt7x108cpvAOHPKhGDuCXvShI/UHISydc47mv0SyhdqzZJPeb+qHtXFsVOOqXVDa58K1YCaPeSNJtOvnlwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmPmVruN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235e389599fso87685ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753222650; x=1753827450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwq8/R8i8xM+jxXlYCuXM87SJ5yS6lKTE4JLQ6WPr1o=;
        b=tmPmVruNk1OJSpoM11yX9H5wHc7FUPLe7aGSzIxu9h0j/t7VDebEjvIygw8geeI/YC
         v3Hk8RGsiz6czRLd+bgzkdYB2KOv7fUJMDFIdHjQdeXlxY61qg84KYOXCQSSRseooW/y
         Y75/62fdE5jkNe/+epKQlXUMDLbBXlah2r/ftW2PCB6uWb9TJ9aCTbB7jBkeOhqIuTp8
         Dl6BHMcGHaqxnVO65/shehaRCHI28BwLkOjFAllona9DFKZWnxu5j44BatH/+kVU/Hi5
         wB6BUEGqcnxNsiKnwmJ3MP67X11/Tg/YSfC/fogVmJhfBI4+Q0Yx1NlZVp3FCpAzqPbD
         OhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222650; x=1753827450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwq8/R8i8xM+jxXlYCuXM87SJ5yS6lKTE4JLQ6WPr1o=;
        b=wednx9iw0iDpuOW2IN81uBchhbsYHioJM8e+D/kSCyDqFsvIdavkvsz4FYMZvN507Q
         iNe5MYbobSYypw32NCV3+yA02d1xBNrxTJIAac9BjKUHnIw6tlqjGYBSwe7HtdPOxgxc
         vsAkta1FFRiiRDge7KRiPKJXiQj08kKosF3ovaA/O3KFmb/3wQQlBTwo2ArC0/IjJXUZ
         XQPWyK7vpUtbxAL+7Gsw120bIUm6lEBUW5xJDFaUeCWf1gK13juvdip5F5KzjQRynw3x
         Bj90JBRMOIGehG7lMlONsUXwn1vWWl3ckw9G9VGsgKzmYvLe2CaXITNjb/yAbXwCbNbL
         +BQA==
X-Forwarded-Encrypted: i=1; AJvYcCUZEU2lzLtdEu4/t8sZGhPbkV7QUQGUvY+bVURN4lO7X+p0S42UuVZlmYaZO/zgeu4SPOWflHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Kwc+SKWb6p17a6MFx3h4qkgbUOzczrdRpAQUoy6qc3x/OLei
	4Z8nIDwfCIjYPYzXnSt449pjKC/LDPYPTS/TOAHnX00eOfCKY4FjpE2bbhahpjbWtCQC26zARgF
	a09I1IIk0XN+f7hVqfFQtSk55xoBE7DzGbKgV/EPn
X-Gm-Gg: ASbGnctbkUXfR7VIgJQaCWzzpNLHu/IfMMMelo0jHac2lrk0LW1+QaE1dsxzBMkqxhq
	9GMmgUhkQHFFbAnfUrhggXA6ih6CfcqQgvqq0hQNr2pkObPicRXmUunPd5nLN08zpiJG0CRTHAi
	mTfN75/5piW8+qewDL9EoWdCFOrRQQjV85O3DnLaM8INbHp5vHGKymi8dXIVXofHj6hzBC03VHH
	e8j3jZ5qqqQTaVvoUnMHsRDEQx1jz7qElOyiQ==
X-Google-Smtp-Source: AGHT+IE/ajbWm3e4FGD0Iam/+O5HMy51w2t6TfHeMRIh15ZibxtN49seddjK0pf9Q1p4k6AShrharBO0lOO8vm4xehk=
X-Received: by 2002:a17:902:ef4c:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-23f9768690amr1184045ad.0.1753222649125; Tue, 22 Jul 2025
 15:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721054903.39833-1-byungchul@sk.com>
In-Reply-To: <20250721054903.39833-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Jul 2025 15:17:15 -0700
X-Gm-Features: Ac12FXyQGTpNbFtlw2q6Pc3nggpdLqj6g3Hr7vfFoOMAJXp98eJzBFERPdnHCgk
Message-ID: <CAHS8izM11fxu6jHZw5VJsHXeZ+Tk+6ZBGDk0vHiOoHyXZoOvOg@mail.gmail.com>
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
 page type
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, asml.silence@gmail.com, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 10:49=E2=80=AFPM Byungchul Park <byungchul@sk.com> =
wrote:
>
> Hi,
>
> I focused on converting the existing APIs accessing ->pp_magic field to
> page type APIs.  However, yes.  Additional works would better be
> considered on top like:
>
>    1. Adjust how to store and retrieve dma index.  Maybe network guys
>       can work better on top.
>
>    2. Move the sanity check for page pool in mm/page_alloc.c to on free.
>
>    Byungchul
>
> ---8<---
> From 7d207a1b3e9f4ff2a72f5b54b09e3ed0c4aaaca3 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 21 Jul 2025 14:05:20 +0900
> Subject: [PATCH] mm, page_pool: introduce a new page type for page pool i=
n page type
>
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, page type e.i. PGTY_netpp can be used
> for that purpose.
>
> Use the page type APIs e.g. PageNetpp(), __SetPageNetpp(), and
> __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic() since they are totally replaced.
>
> This work was inspired by the following link by Pavel:
>
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmai=
l.com/
>
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>  include/linux/mm.h                            | 28 ++-----------------
>  include/linux/page-flags.h                    |  6 ++++
>  include/net/netmem.h                          |  2 +-
>  mm/page_alloc.c                               |  4 +--
>  net/core/netmem_priv.h                        | 16 ++---------
>  net/core/page_pool.c                          | 10 +++++--
>  7 files changed, 24 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/xdp.c
> index 5d51600935a6..def274f5c1ca 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq =
*sq,
>                                 xdpi =3D mlx5e_xdpi_fifo_pop(xdpi_fifo);
>                                 page =3D xdpi.page.page;
>
> -                               /* No need to check page_pool_page_is_pp(=
) as we
> +                               /* No need to check PageNetpp() as we
>                                  * know this is a page_pool page.
>                                  */
>                                 page_pool_recycle_direct(pp_page_to_nmdes=
c(page)->pp,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ae50c1641bed..736061749535 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4135,10 +4135,9 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   * DMA mapping IDs for page_pool
>   *
>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) a=
nd
> - * stashes it in the upper bits of page->pp_magic. We always want to be =
able to
> - * unambiguously identify page pool pages (using page_pool_page_is_pp())=
. Non-PP
> - * pages can have arbitrary kernel pointers stored in the same field as =
pp_magic
> - * (since it overlaps with page->lru.next), so we must ensure that we ca=
nnot
> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> + * arbitrary kernel pointers stored in the same field as pp_magic (since
> + * it overlaps with page->lru.next), so we must ensure that we cannot
>   * mistake a valid kernel pointer with any of the values we write into t=
his
>   * field.
>   *
> @@ -4168,25 +4167,4 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT=
 - 1, \
>                                   PP_DMA_INDEX_SHIFT)
> -
> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magi=
c is
> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit=
 0 for
> - * the head page of compound page and bit 1 for pfmemalloc page, as well=
 as the
> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> - */
> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> -
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #endif /* _LINUX_MM_H */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4fe5ee67535b..906ba7c9e372 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -957,6 +957,7 @@ enum pagetype {
>         PGTY_zsmalloc           =3D 0xf6,
>         PGTY_unaccepted         =3D 0xf7,
>         PGTY_large_kmalloc      =3D 0xf8,
> +       PGTY_netpp              =3D 0xf9,
>
>         PGTY_mapcount_underflow =3D 0xff
>  };
> @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>
> +/*
> + * Marks page_pool allocated pages.
> + */
> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> +
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
>   * @page: The page to test.
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index f7dacc9e75fd..3667334e16e7 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -298,7 +298,7 @@ static inline struct net_iov *__netmem_clear_lsb(netm=
em_ref netmem)
>   */
>  #define pp_page_to_nmdesc(p)                                           \
>  ({                                                                     \
> -       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));               \
> +       DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                          \
>         __pp_page_to_nmdesc(p);                                         \
>  })
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ef3c07266b3..71c7666e48a9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -898,7 +898,7 @@ static inline bool page_expected_state(struct page *p=
age,
>  #ifdef CONFIG_MEMCG
>                         page->memcg_data |
>  #endif
> -                       page_pool_page_is_pp(page) |
> +                       PageNetpp(page) |
>                         (page->flags & check_flags)))
>                 return false;
>
> @@ -925,7 +925,7 @@ static const char *page_bad_reason(struct page *page,=
 unsigned long flags)
>         if (unlikely(page->memcg_data))
>                 bad_reason =3D "page still charged to cgroup";
>  #endif
> -       if (unlikely(page_pool_page_is_pp(page)))
> +       if (unlikely(PageNetpp(page)))
>                 bad_reason =3D "page_pool leak";
>         return bad_reason;
>  }
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..39a97703d9ed 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -8,21 +8,11 @@ static inline unsigned long netmem_get_pp_magic(netmem_=
ref netmem)
>         return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
>  }
>
> -static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long p=
p_magic)
> -{
> -       __netmem_clear_lsb(netmem)->pp_magic |=3D pp_magic;
> -}
> -
> -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> -{
> -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_=
MASK);
> -
> -       __netmem_clear_lsb(netmem)->pp_magic =3D 0;
> -}
> -
>  static inline bool netmem_is_pp(netmem_ref netmem)
>  {
> -       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) =3D=3D PP_SI=
GNATURE;
> +       if (netmem_is_net_iov(netmem))
> +               return true;

As Pavel alludes, this is dubious, and at least it's difficult to
reason about it.

There could be net_iovs that are not attached to pp, and should not be
treated as pp memory. These are in the devmem (and future net_iov) tx
paths.

We need a way to tell if a net_iov is pp or not. A couple of options:

1. We could have it such that if net_iov->pp is set, then the
netmem_is_pp =3D=3D true, otherwise false.
2. We could implement a page-flags equivalent for net_iov.

Option #1 is simpler and is my preferred. To do that properly, you need to:

1. Make sure everywhere net_iovs are allocated that pp=3DNULL in the
non-pp case and pp=3Dnon NULL in the pp case. those callsites are
net_devmem_bind_dmabuf (devmem rx & tx path), io_zcrx_create_area
(io_uring rx path).

2. Change netmem_is_pp to check net_iov->pp in the net_iov case.

--=20
Thanks,
Mina

