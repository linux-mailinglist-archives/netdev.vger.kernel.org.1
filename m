Return-Path: <netdev+bounces-233577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACCC15BB7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E61F1890AFE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F026342C80;
	Tue, 28 Oct 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTFwPIyW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE723ABBD
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667938; cv=none; b=a1xc8S18QnDYkqRtPPJCtqJqVYP5vE3tL3sy9l6wwuLuUcE8ktMQ0mk4vhCxbs0MFZdYy5McorbAYG0c5bAxcstH9uL8v8qK05nG4N0CtkIItz6dPkevQ6lm3WejwGwqNGuwC/Un9btY9vS1ppfHkm1QmXcmgWRO5EXt9sLmeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667938; c=relaxed/simple;
	bh=YmU+S2dpj2lpvbkcXW1CLOnuN+/RJrukgDz9Fq/nJcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPKvWf+NSR7xsC63VJ0DxYuSDjaEO77Hj0j7JXua6s6n40CDHurThsXkCIEhuNzRg8gG9fdRUXeiQHRSq0oRTPZ38EIGkkuVo7qTTVCtVewMd2ZcnKJUFA85U4lr+Rx5qvynzPVHwa1+07ygP3iOvrObdBgFICywURlpV9JKv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTFwPIyW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-58b027beea6so9389e87.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761667935; x=1762272735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxRI++0kUA4C88E54g3jys1xp+GEI9qFS2ZGVb0fFIA=;
        b=kTFwPIyW2dqp1qBON3q/aXQV5MLtLqLwIwvT8Pdqff9vx1eZEwHjNAZlcA0PgpDmJ2
         glAR3Wzmw91lfDywd77xM/fDySLBzYiGwZc8nQOsrH8GkOXPyfDbSeeQ/ClWeqe9rR8A
         4djVL1fkGJGx9aTTDyx0PdjpkDFCmNlCAAqh28LyBfBw5tmjxqMoIBAWrqAQGCOP92M6
         YJTW5Jclzi5nmQhqNNsG6dXfGcBXEXCMj5U9KZ6tz7lrUVg5kSZ4/U52vHtbUzIZ8XtI
         awBqQoOcC6cYOz96B/dYfXAUAnxDrsEjGhZjVHERUUONPO1uC3k7OAa5cS8/C1+beTCA
         HGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667935; x=1762272735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxRI++0kUA4C88E54g3jys1xp+GEI9qFS2ZGVb0fFIA=;
        b=H7kmCoMml2e7qOOQhrrUiKNDhr4qPIskPtJR7kWbxc2rquWhQ52hD0Q/9k4pW6XUCm
         BM296qCY3MP1JK6QPhToU+rXJaK/IBEx/Wl7GgYrdhbFrbRVGsqcgUGyDYaSkaD5/LRn
         Zoieu/whd1eFrogLa4J3BLuR+8gOYCpv7mbi4J5tZU7l8d7xqntWAbGRQy130hiAnM3+
         p8MA63tloHC0n/SvvVDnqwVtiYgiDBRIX0jQQ+cmZCSnSCJ46Plr5S2GIzMhL0xI+OE4
         Fd1E5rbeybHtNd2CqCSsMboXzA7wh3mJyyVFP6vB0vpaxJWQnz/WRc3i0sH7KTep2Ryb
         Y11g==
X-Forwarded-Encrypted: i=1; AJvYcCU/AfP7BE87d2Mpe56CNIAhi3ivcueI+LKR4dwq3H7/w5DdZP4xuLi8miW6LEsz4WNByO9L75M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4/KulQn4DOtIjf0Ss19JKb7M3m+q3RjlXvIooxv23bIoNU+j
	UVpc8PPKwQjTcL2ZTajszFTQJt3h6JRMjs759iiMeAGg3QYXaTk7mXQ3emQk2flTwTaSTR50EIO
	sf2g3f9p5ExifjCUxbmtwARcd8bJ9LfZLO05ZqXGY
X-Gm-Gg: ASbGncsWheM57usHaMODn6cixhsnB0PpvH7A2XjiRpzfiSHZ6fyOYYxVjENiR37aFCJ
	9+fS9DttFBMppnX/8k3vgaKBCBAobOBY2ko7GsGo/QJybMkBnzJsqMT4m+aINkwU9uRbknn1ZeK
	N0HZDWObN3l863UGiBzX+XOqBSsZiT9791nO75Jo1VePuZuiVD9FlMRxSkQtRASvx0etMiL/OA3
	fmNK6j/BwJ8Pb7zLCxc1nHdjRSQxzhMvya/erVrahw3cMlAS7GYgiGkAXzB7YBVPE470t4Bl2yF
	7ynHSPRpyebBAnWj/Get4CXT2w==
X-Google-Smtp-Source: AGHT+IGHjnuV06Q110K/XiF/19HksKvviTMay1daMlenEI88sIR67s4zP4V81F71auWP2H80fovhcnl0+5UV0L8pGUg=
X-Received: by 2002:a05:6512:b84:b0:586:8e3c:9456 with SMTP id
 2adb3069b0e04-5930eed566dmr430517e87.0.1761667934253; Tue, 28 Oct 2025
 09:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023074410.78650-1-byungchul@sk.com> <20251023074410.78650-3-byungchul@sk.com>
 <CAHS8izME4W3ENXNXf4Cxegmk9xnRmKajpRMQ18L0=FGTFebeaw@mail.gmail.com> <64E18E02-727B-47C4-8849-486AB98CACD8@nvidia.com>
In-Reply-To: <64E18E02-727B-47C4-8849-486AB98CACD8@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 28 Oct 2025 09:12:00 -0700
X-Gm-Features: AWmQ_bmxv3BL-tBNLLwsdAEGZyVMyLK1NK7F8-nJ_Ys_3boWKRkq5vfhkylVKmE
Message-ID: <CAHS8izNuSkxn1HZJ-1W_wa7QsQFE5yKUjbfSgKEzv9tLLOYveQ@mail.gmail.com>
Subject: Re: [RFC mm v4 2/2] mm: introduce a new page type for page pool in
 page type
To: Zi Yan <ziy@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, asml.silence@gmail.com, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, 
	dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:45=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 27 Oct 2025, at 21:28, Mina Almasry wrote:
>
> > On Thu, Oct 23, 2025 at 12:45=E2=80=AFAM Byungchul Park <byungchul@sk.c=
om> wrote:
> >>
> >> ->pp_magic field in struct page is current used to identify if a page
> >> belongs to a page pool.  However, ->pp_magic will be removed and page
> >> type bit in struct page e.i. PGTY_netpp can be used for that purpose.
> >>
> >> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(=
),
> >> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> >> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> >> netmem_clear_pp_magic().
> >>
> >> This work was inspired by the following link:
> >>
> >> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@g=
mail.com/
> >>
> >> While at it, move the sanity check for page pool to on free.
> >>
> >> Suggested-by: David Hildenbrand <david@redhat.com>
> >> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> Acked-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >> Hi Mina,
> >>
> >> I dropped your Reviewed-by tag since there are updates on some comment=
s
> >> in network part.  Can I still keep your Reviewed-by?
> >>
> >>         Byungchul
> >> ---
> >>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
> >>  include/linux/mm.h                            | 27 +++---------------=
-
> >>  include/linux/page-flags.h                    |  6 +++++
> >>  include/net/netmem.h                          |  2 +-
> >>  mm/page_alloc.c                               |  8 +++---
> >>  net/core/netmem_priv.h                        | 17 +++---------
> >>  net/core/page_pool.c                          | 14 +++++-----
> >>  7 files changed, 25 insertions(+), 51 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/driver=
s/net/ethernet/mellanox/mlx5/core/en/xdp.c
> >> index 5d51600935a6..def274f5c1ca 100644
> >> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> >> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> >> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdp=
sq *sq,
> >>                                 xdpi =3D mlx5e_xdpi_fifo_pop(xdpi_fifo=
);
> >>                                 page =3D xdpi.page.page;
> >>
> >> -                               /* No need to check page_pool_page_is_=
pp() as we
> >> +                               /* No need to check PageNetpp() as we
> >>                                  * know this is a page_pool page.
> >>                                  */
> >>                                 page_pool_recycle_direct(pp_page_to_nm=
desc(page)->pp,
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index b6fdf3557807..f5155f1c75f5 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -4361,10 +4361,9 @@ int arch_lock_shadow_stack_status(struct task_s=
truct *t, unsigned long status);
> >>   * DMA mapping IDs for page_pool
> >>   *
> >>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray=
) and
> >> - * stashes it in the upper bits of page->pp_magic. We always want to =
be able to
> >> - * unambiguously identify page pool pages (using page_pool_page_is_pp=
()). Non-PP
> >> - * pages can have arbitrary kernel pointers stored in the same field =
as pp_magic
> >> - * (since it overlaps with page->lru.next), so we must ensure that we=
 cannot
> >> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can h=
ave
> >> + * arbitrary kernel pointers stored in the same field as pp_magic (si=
nce
> >> + * it overlaps with page->lru.next), so we must ensure that we cannot
> >>   * mistake a valid kernel pointer with any of the values we write int=
o this
> >>   * field.
> >>   *
> >> @@ -4399,26 +4398,6 @@ int arch_lock_shadow_stack_status(struct task_s=
truct *t, unsigned long status);
> >>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SH=
IFT - 1, \
> >>                                   PP_DMA_INDEX_SHIFT)
> >>
> >> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_m=
agic is
> >> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve =
bit 0 for
> >> - * the head page of compound page and bit 1 for pfmemalloc page, as w=
ell as the
> >> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> >> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> >> - */
> >> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >> -
> >> -#ifdef CONFIG_PAGE_POOL
> >> -static inline bool page_pool_page_is_pp(const struct page *page)
> >> -{
> >> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> >> -}
> >> -#else
> >> -static inline bool page_pool_page_is_pp(const struct page *page)
> >> -{
> >> -       return false;
> >> -}
> >> -#endif
> >> -
> >>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
> >>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
> >>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
> >> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >> index 0091ad1986bf..edf5418c91dd 100644
> >> --- a/include/linux/page-flags.h
> >> +++ b/include/linux/page-flags.h
> >> @@ -934,6 +934,7 @@ enum pagetype {
> >>         PGTY_zsmalloc           =3D 0xf6,
> >>         PGTY_unaccepted         =3D 0xf7,
> >>         PGTY_large_kmalloc      =3D 0xf8,
> >> +       PGTY_netpp              =3D 0xf9,
> >>
> >>         PGTY_mapcount_underflow =3D 0xff
> >>  };
> >> @@ -1078,6 +1079,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> >>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> >>  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
> >>
> >> +/*
> >> + * Marks page_pool allocated pages.
> >> + */
> >> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> >> +
> >>  /**
> >>   * PageHuge - Determine if the page belongs to hugetlbfs
> >>   * @page: The page to test.
> >> diff --git a/include/net/netmem.h b/include/net/netmem.h
> >> index 651e2c62d1dd..0ec4c7561081 100644
> >> --- a/include/net/netmem.h
> >> +++ b/include/net/netmem.h
> >> @@ -260,7 +260,7 @@ static inline unsigned long netmem_pfn_trace(netme=
m_ref netmem)
> >>   */
> >>  #define pp_page_to_nmdesc(p)                                         =
  \
> >>  ({                                                                   =
  \
> >> -       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));             =
  \
> >> +       DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                        =
  \
> >>         __pp_page_to_nmdesc(p);                                       =
  \
> >>  })
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index fb91c566327c..c69ed3741bbc 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct pa=
ge *page,
> >>  #ifdef CONFIG_MEMCG
> >>                         page->memcg_data |
> >>  #endif
> >> -                       page_pool_page_is_pp(page) |
> >
> > Shouldn't you replace the page_pool_page_is_pp check with a PageNetpp
> > check in this call site and below? Or is that no longer necessary for
> > some reason?
>
> It is done in the hunk below this one:
>
> @@ -1379,9 +1376,12 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>                 mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>                 folio->mapping =3D NULL;
>         }
> -       if (unlikely(page_has_type(page)))
> +       if (unlikely(page_has_type(page))) {
> +               /* networking expects to clear its page type before relea=
sing */
> +               WARN_ON_ONCE(PageNetpp(page));
>                 /* Reset the page_type (which overlays _mapcount) */
>                 page->page_type =3D UINT_MAX;
> +       }
>
>         if (is_check_pages_enabled()) {
>                 if (free_page_is_bad(page))
>
> where
> free_pages_prepare()
>   -> free_page_is_bad()
>     -> page_expected_state()
>

Thanks, looks fine to me then. I'm not extremely familiar with this
code so I won't give a Reviewed-by, but here is an ack, FWIW:

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

