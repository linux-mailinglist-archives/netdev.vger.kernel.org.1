Return-Path: <netdev+bounces-108295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BE91EB42
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 01:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4137A1F21B0A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4117108D;
	Mon,  1 Jul 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNTdoiNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB14779E;
	Mon,  1 Jul 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719875423; cv=none; b=eSzGtQf9aeXpG2JX029APraWV/IkP8M+jcyEANj4DxB+Px6hBRpSJ4ThO0gSXgt5SYx14QWXOfatjCMYbZiOhV12a5HB9SxwbMcS+YmyXvbD8PwgQDECAaNrK9f9C3tIOgxFHWoKy1rFPpwLJ7d+CVRDioKps0UHd13IXCz2/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719875423; c=relaxed/simple;
	bh=vLZGuUyMHYtbqDoUKeu0JwXEeYCGf5mLBM50cvOZ2FU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMKeZawSPXCI2CyyGkM85V+0IpeqrIkmfidD0fDFcPcWVARyHU5aUVOZWEFVV3hS1clZF7z0n1apdKZ6kVHteSK9Orzv8GklSmpMWGKqyLthx9rDbkWF//IjLwpD4zOVyvHAdAlgokEXsxkWuNZIXteOjv+7qm1nTxEVVtFS/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNTdoiNB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f9aeb96b93so24502285ad.3;
        Mon, 01 Jul 2024 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719875421; x=1720480221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JO3hxaUe4TBhQwaTOXXde5z2rexh9ciEnaN0UMs6Tpk=;
        b=mNTdoiNBDQMWgb/cjov6wqsCmzgteM8tofvEt3YuPqKHV9YT6IeNS3jz/wjTeDIjn+
         31UkVa5MWxSG/u1xK72gwiS61/gU988CmUQG1SJBuXlh8HmmG9MVZTYDsIeNbhoIALAU
         jBxPf1+9tgmEASW+d8OeFRPYatQ771Uhhk7INP1HL/UUT6+ImWYNJzE8F1mXCikL0Amn
         H1TqN8cJZpTXFCOya8QIpCpOtgxMvnSbRb3izsyVuyR8xjZkoJAdBIOL6JH1lrtWugIH
         dKXzhJadTxKZmteq3sqj7wi3NEBdcn2+v9Twkc9EsR+K1PHh7X3NvYEXdH3KXN+FCR07
         Kijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719875421; x=1720480221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JO3hxaUe4TBhQwaTOXXde5z2rexh9ciEnaN0UMs6Tpk=;
        b=KM+P27q7IiMppAns1byPMCR0NiKyOs3rqsy9p6hztXsM9oCryUMcUPakOwcK7xdZF+
         GDjgYHEqGAf/iXlAy4V7fxX0Bi0z5CXGyhYXM7NED4iW3jv+kidKYY8dLogcgwS/XOMV
         9rna+6GkVNFtHie8hrcXRcc3Lq5yUbzUPfCSBXxwcFSTvcw6nyTvkCeirZDLQG8BamQE
         MMkGgBP+iDGmTrTW8YaUpJZL68uxWokRWBLvHVx2psDJa0z2O/LdJjcLQlgs4iFtiVuj
         x7tifWWnXzEDXr8xucvPzwgfSN9m3gXophNw4W3yRBk4qIDrvRAofzlomZL5gRF3jvvh
         KbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjRPk6JaVNKtN5Qi4NXUkw1CcitVEGWsmu0DZYlyl9fHZAeEDHhzZwDCPQc1sPEEPEhgcQGAHoRpjwDb0kwNLvI5KtTALYZMh++hLK
X-Gm-Message-State: AOJu0YwNQBaP4zgbaEk+9fm5WtqWf2Kn6eefIpksN8jrRRJHMoqaWhlH
	jxSVE5fVsk8d4X8NMca8pOrDsT/dhjNHvXjYx3ucmcs3ViPM56jK
X-Google-Smtp-Source: AGHT+IGmzjdb0aTKtkaW71dZIduU2eZKMunrsnUFRabvXhvxs2FJYST83sKTf5cZlAIX0lRmG0H0QQ==
X-Received: by 2002:a17:902:eccc:b0:1f7:19b4:c7f5 with SMTP id d9443c01a7336-1fadbc5c25emr62078095ad.12.1719875421309;
        Mon, 01 Jul 2024 16:10:21 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fac1569d4bsm71988635ad.201.2024.07.01.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 16:10:20 -0700 (PDT)
Message-ID: <86c56c9a88d07efbfe1e85bec678e86704588a15.camel@gmail.com>
Subject: Re: [PATCH net-next v9 02/13] mm: move the page fragment allocator
 from page_alloc into its own file
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells
	 <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org
Date: Mon, 01 Jul 2024 16:10:19 -0700
In-Reply-To: <20240625135216.47007-3-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
> Inspired by [1], move the page fragment allocator from page_alloc
> into its own c file and header file, as we are about to make more
> change for it to replace another page_frag implementation in
> sock.c
>=20
> 1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.c=
om/
>=20
> CC: David Howells <dhowells@redhat.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

So one thing that I think might have been overlooked in the previous
reviews is the fact that the headers weren't necessarily self
sufficient. You were introducing dependencies that had to be fulfilled
by other headers.

One thing you might try doing as part of your testing would be to add a
C file that just adds your header and calls your functions to verify
that there aren't any unincluded dependencies.

> ---
>  include/linux/gfp.h             |  22 -----
>  include/linux/mm_types.h        |  18 ----
>  include/linux/page_frag_cache.h |  47 +++++++++++
>  include/linux/skbuff.h          |   1 +
>  mm/Makefile                     |   1 +
>  mm/page_alloc.c                 | 136 ------------------------------
>  mm/page_frag_cache.c            | 144 ++++++++++++++++++++++++++++++++
>  mm/page_frag_test.c             |   1 +
>  8 files changed, 194 insertions(+), 176 deletions(-)
>  create mode 100644 include/linux/page_frag_cache.h
>  create mode 100644 mm/page_frag_cache.c
>=20
...

> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> new file mode 100644
> index 000000000000..3a44bfc99750
> --- /dev/null
> +++ b/include/linux/page_frag_cache.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_PAGE_FRAG_CACHE_H
> +#define _LINUX_PAGE_FRAG_CACHE_H
> +
> +#include <linux/gfp_types.h>
> +

The gfp_types.h only really gives you the values you pass to the
gfp_mask. Did you mean to include linux/types.h to get the gfp_t
typedef?

> +#define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)

You should probably include linux/align.h to pull in the __ALIGN_MASK.

> +#define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)

I am pretty sure get_order is from asm/page.h as well.

> +
> +struct page_frag_cache {
> +	void *va;
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)

I am pretty sure PAGE_SIZE is included from asm/page.h

> +	__u16 offset;
> +	__u16 size;
> +#else
> +	__u32 offset;
> +#endif
> +	/* we maintain a pagecount bias, so that we dont dirty cache line
> +	 * containing page->_refcount every time we allocate a fragment.
> +	 */
> +	unsigned int		pagecnt_bias;
> +	bool pfmemalloc;
> +};
> +
> +void page_frag_cache_drain(struct page_frag_cache *nc);
> +void __page_frag_cache_drain(struct page *page, unsigned int count);
> +void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int f=
ragsz,
> +			      gfp_t gfp_mask, unsigned int align_mask);
> +
> +static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
> +					  unsigned int fragsz, gfp_t gfp_mask,
> +					  unsigned int align)
> +{
> +	WARN_ON_ONCE(!is_power_of_2(align));

To get is_power_of_2 you should be including linux/log2.h.

> +	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
> +}
> +
> +static inline void *page_frag_alloc(struct page_frag_cache *nc,
> +				    unsigned int fragsz, gfp_t gfp_mask)
> +{
> +	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
> +}
> +
> +void page_frag_free(void *addr);
> +
> +#endif
>=20

...

> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> new file mode 100644
> index 000000000000..88f567ef0e29
> --- /dev/null
> +++ b/mm/page_frag_cache.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Page fragment allocator
> + *
> + * Page Fragment:
> + *  An arbitrary-length arbitrary-offset area of memory which resides wi=
thin a
> + *  0 or higher order page.  Multiple fragments within that page are
> + *  individually refcounted, in the page's reference counter.
> + *
> + * The page_frag functions provide a simple allocation framework for pag=
e
> + * fragments.  This is used by the network stack and network device driv=
ers to
> + * provide a backing region of memory for use as either an sk_buff->head=
, or to
> + * be used in the "frags" portion of skb_shared_info.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/page_frag_cache.h>
> +#include "internal.h"

You could probably include gfp_types.h here since this is where you are
using the GFP_XXX values.

> +
> +static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
> +					     gfp_t gfp_mask)
> +{
> +	struct page *page =3D NULL;
> +	gfp_t gfp =3D gfp_mask;
> +
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> +		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> +	page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> +				PAGE_FRAG_CACHE_MAX_ORDER);
> +	nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> +#endif
> +	if (unlikely(!page))
> +		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> +
> +	nc->va =3D page ? page_address(page) : NULL;
> +
> +	return page;
> +}
> +
> +void page_frag_cache_drain(struct page_frag_cache *nc)
> +{
> +	if (!nc->va)
> +		return;
> +
> +	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
> +	nc->va =3D NULL;
> +}
> +EXPORT_SYMBOL(page_frag_cache_drain);
> +
> +void __page_frag_cache_drain(struct page *page, unsigned int count)
> +{
> +	VM_BUG_ON_PAGE(page_ref_count(page) =3D=3D 0, page);
> +
> +	if (page_ref_sub_and_test(page, count))
> +		free_unref_page(page, compound_order(page));
> +}
> +EXPORT_SYMBOL(__page_frag_cache_drain);
> +
> +void *__page_frag_alloc_align(struct page_frag_cache *nc,
> +			      unsigned int fragsz, gfp_t gfp_mask,
> +			      unsigned int align_mask)
> +{
> +	unsigned int size =3D PAGE_SIZE;
> +	struct page *page;
> +	int offset;
> +
> +	if (unlikely(!nc->va)) {
> +refill:
> +		page =3D __page_frag_cache_refill(nc, gfp_mask);
> +		if (!page)
> +			return NULL;
> +
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +		/* if size can vary use size else just use PAGE_SIZE */
> +		size =3D nc->size;
> +#endif
> +		/* Even if we own the page, we do not use atomic_set().
> +		 * This would break get_page_unless_zero() users.
> +		 */
> +		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> +
> +		/* reset page count bias and offset to start of new frag */
> +		nc->pfmemalloc =3D page_is_pfmemalloc(page);
> +		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +		nc->offset =3D size;
> +	}
> +
> +	offset =3D nc->offset - fragsz;
> +	if (unlikely(offset < 0)) {
> +		page =3D virt_to_page(nc->va);
> +
> +		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> +			goto refill;
> +
> +		if (unlikely(nc->pfmemalloc)) {
> +			free_unref_page(page, compound_order(page));
> +			goto refill;
> +		}
> +
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +		/* if size can vary use size else just use PAGE_SIZE */
> +		size =3D nc->size;
> +#endif
> +		/* OK, page count is 0, we can safely set it */
> +		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +
> +		/* reset page count bias and offset to start of new frag */
> +		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +		offset =3D size - fragsz;
> +		if (unlikely(offset < 0)) {
> +			/*
> +			 * The caller is trying to allocate a fragment
> +			 * with fragsz > PAGE_SIZE but the cache isn't big
> +			 * enough to satisfy the request, this may
> +			 * happen in low memory conditions.
> +			 * We don't release the cache page because
> +			 * it could make memory pressure worse
> +			 * so we simply return NULL here.
> +			 */
> +			return NULL;
> +		}
> +	}
> +
> +	nc->pagecnt_bias--;
> +	offset &=3D align_mask;
> +	nc->offset =3D offset;
> +
> +	return nc->va + offset;
> +}
> +EXPORT_SYMBOL(__page_frag_alloc_align);
> +
> +/*
> + * Frees a page fragment allocated out of either a compound or order 0 p=
age.
> + */
> +void page_frag_free(void *addr)
> +{
> +	struct page *page =3D virt_to_head_page(addr);
> +
> +	if (unlikely(put_page_testzero(page)))
> +		free_unref_page(page, compound_order(page));
> +}
> +EXPORT_SYMBOL(page_frag_free);
> diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c
> index 5ee3f33b756d..07748ee0a21f 100644
> --- a/mm/page_frag_test.c
> +++ b/mm/page_frag_test.c
> @@ -16,6 +16,7 @@
>  #include <linux/log2.h>
>  #include <linux/completion.h>
>  #include <linux/kthread.h>
> +#include <linux/page_frag_cache.h>
> =20
>  #define OBJPOOL_NR_OBJECT_MAX	BIT(24)
> =20


