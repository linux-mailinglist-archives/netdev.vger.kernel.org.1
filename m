Return-Path: <netdev+bounces-122420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F7961379
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A59B22CE6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC01C6896;
	Tue, 27 Aug 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSVAmCPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D91C232B;
	Tue, 27 Aug 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774449; cv=none; b=DJLkk1stl6Uje/VEj6PY66dSf72kdfs6lduj67eYCamdgI/4PTWXHntL1lldId0IG9ht/E3pP1+ZNEf/XAD8ci7wjywPJlWlS5Nurfy0ZvMh5SDkqLoRLGgEfV3JeezIkR6PCrSgl9THIEiyQX1xV3tv+4y60iCE57MUsoLAaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774449; c=relaxed/simple;
	bh=evURTedKlFz4k1JNkwqeMUdQoBnzg2SGga+NmDTOp4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqLJkABv2Te6E1+OiEtj/c4wEveAk5zFW+htLZJYxkJ9KKf5uumWExwtXKNqoo5PwJNFTun48QS7eSgJ4VaQTtb5Cr7OJoyoPrrd8V1wO1sAnSBZ0n622fLlhBr327uaIz6jgk2D3pYfode/BlXguWW3iYZ61H5mZA+bReGXLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSVAmCPv; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-829e86cb467so81119539f.1;
        Tue, 27 Aug 2024 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774446; x=1725379246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKLMWrg6g9OU+cV8ThfWWZDxMIrdaGFl7c8JSKNiFKQ=;
        b=QSVAmCPvcEgPULzRvd7+eJR0Oj48QCMgsJvGt69+csLUULzL4sN9KX3oS72FpRGfw3
         wf5TOJhV7m5AEAZ5gpMEl5vEK3qLnHUiwBalMmAY3j34sJE3GlXn+2kQAqq/eDvuw0Aa
         GhE0XWQlIi5KXPnP9aV7yII65AOwXlJTcr8LHz283mofOrerfka5q17WoSIo9Iy/Ibwy
         yYI3jup1JYtqe/rRf0601NM906Kwh92lEGmo1R0oVo+mfXWNfQFyD+5OFwRM90c0e02O
         aJHXecxxuCZmctPUF94Eu2QLEAUCQQsfSoHgbuPQvuLVaXOA5kje0QHtycBbZJSKCHQt
         ISQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774446; x=1725379246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKLMWrg6g9OU+cV8ThfWWZDxMIrdaGFl7c8JSKNiFKQ=;
        b=AIq+nS0SXcZMISoVgcZWT8xmneNTMiZ/1dJXUxtu9RjYt2TAFDOa40NGcibOlnQTi2
         dI+ZYyoatQ2G2LyE7gnuuGwZMYYTGEWa8kyRNPydPwJH2+d3dgykmBpYyX/6ZX/EOO1P
         ecBhSppseZ9E1bhcbYU3kfEnOALtR6xwVUwaeka/DQ9Dak5zG/Wb7+rKQN2n6++0Ie3X
         wc054OrQJgjHzJ/IN04SPglbPp1PpHNYK+ng0jxC0hkMSF3GWKHdTCTVnyEMjJ76LrAI
         WckH69aJWvfp0CnxhQGXx0tUTH07sHaI1Xf5bsQSnBcmL/uNAy/8DZLhgr3ZAcw72fom
         MxFg==
X-Forwarded-Encrypted: i=1; AJvYcCUvmblVrj1zPWvIOM2F1YL5lOBVu7mPsEcxuOSBWKRJTbGnd3QKrshaLIBDSi/dlmI4IVeamcc5iaOs5kE=@vger.kernel.org, AJvYcCX2CFStguanK6/g7rwWI1ZpAQX8btT0hQ1xegAp1Zll4go2CQOTY1vzpbEUtC40iAAjcEecbYsy@vger.kernel.org
X-Gm-Message-State: AOJu0YxZl+6GNRslMV2M+1Pu0HNPOlecgOy+r3jZ+3MXSG36ECqnvBTW
	+ORNkgJBIURy9WV5h0LW88oELC+LauGZcxuqMG7FqriPvBxWR3UtmQZeUdrM9rLPPAgmMHeJMwP
	HyOaKlt/lbr9aLZlqprCKqqzZ+Kc=
X-Google-Smtp-Source: AGHT+IEXbBzBotSspCNr329ppunAPqBGFxziRxfGF+s9zT3UuNt8tn9xzLCMG8+eOSmv8TOYSl7rZYAUpWO6AbxuoKU=
X-Received: by 2002:a05:6602:6421:b0:824:d5ff:6a55 with SMTP id
 ca18e2360f4ac-829f132a1a3mr381013839f.16.1724774446130; Tue, 27 Aug 2024
 09:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124021.2635705-1-linyunsheng@huawei.com> <20240826124021.2635705-8-linyunsheng@huawei.com>
In-Reply-To: <20240826124021.2635705-8-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 27 Aug 2024 09:00:08 -0700
Message-ID: <CAKgT0UcD7BqqQiEzuZUh9CEy4=pPHqWHwD5NGNtckk3HFx2DNw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 07/13] mm: page_frag: some minor refactoring
 before adding new API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:46=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Refactor common codes from __page_frag_alloc_va_align() to
> __page_frag_cache_prepare() and __page_frag_cache_commit(),
> so that the new API can make use of them.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h | 51 +++++++++++++++++++++++++++++++--
>  mm/page_frag_cache.c            | 20 ++++++-------
>  2 files changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 372d6ed7e20a..2cc18a525936 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -7,6 +7,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/log2.h>
>  #include <linux/mm.h>
> +#include <linux/mmdebug.h>
>  #include <linux/mm_types_task.h>
>  #include <linux/types.h>
>
> @@ -75,8 +76,54 @@ static inline unsigned int page_frag_cache_page_size(u=
nsigned long encoded_page)
>
>  void page_frag_cache_drain(struct page_frag_cache *nc);
>  void __page_frag_cache_drain(struct page *page, unsigned int count);
> -void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int f=
ragsz,
> -                             gfp_t gfp_mask, unsigned int align_mask);
> +void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int=
 fragsz,
> +                               struct page_frag *pfrag, gfp_t gfp_mask,
> +                               unsigned int align_mask);
> +
> +static inline void __page_frag_cache_commit(struct page_frag_cache *nc,
> +                                           struct page_frag *pfrag, bool=
 referenced,
> +                                           unsigned int used_sz)
> +{
> +       if (referenced) {
> +               VM_BUG_ON(!nc->pagecnt_bias);
> +               nc->pagecnt_bias--;
> +       }
> +
> +       VM_BUG_ON(used_sz > pfrag->size);
> +       VM_BUG_ON(pfrag->page !=3D page_frag_encoded_page_ptr(nc->encoded=
_page));
> +
> +       /* nc->offset is not reset when reusing an old page, so do not ch=
eck for the
> +        * first fragment.
> +        * Committed offset might be bigger than the current offset due t=
o alignment
> +        */

nc->offset should be reset when you are allocating a new page. I would
suggest making that change as you should be able to verify that the
fragment you are working with contains the frag you are working with.
The page and offset should essentially be equal.

> +       VM_BUG_ON(pfrag->offset && nc->offset > pfrag->offset);
> +       VM_BUG_ON(pfrag->offset &&
> +                 pfrag->offset + pfrag->size > page_frag_cache_page_size=
(nc->encoded_page));
> +
> +       pfrag->size =3D used_sz;
> +
> +       /* Calculate true size for the fragment due to alignment, nc->off=
set is not
> +        * reset for the first fragment when reusing an old page.
> +        */
> +       pfrag->size +=3D pfrag->offset ? (pfrag->offset - nc->offset) : 0=
;

The pfrag->size should be the truesize already. You should have stored
it as fragsz so that all you really need to do is push the offset
forward by pfrag->size.

> +
> +       nc->offset =3D pfrag->offset + used_sz;
> +}
> +

I think this function might be better to keep in the .c file versus
having it in the header file.

...

> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 228cff9a4cdb..bba59c87d478 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -67,16 +67,14 @@ void __page_frag_cache_drain(struct page *page, unsig=
ned int count)
>  }
>  EXPORT_SYMBOL(__page_frag_cache_drain);
>
> -void *__page_frag_alloc_align(struct page_frag_cache *nc,
> -                             unsigned int fragsz, gfp_t gfp_mask,
> -                             unsigned int align_mask)
> +void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int=
 fragsz,
> +                               struct page_frag *pfrag, gfp_t gfp_mask,
> +                               unsigned int align_mask)
>  {
>         unsigned long encoded_page =3D nc->encoded_page;
>         unsigned int size, offset;

The 3 changes below can all be dropped. They are unnecessary
optimizations of the unlikely path.

>         struct page *page;
>
> -       size =3D page_frag_cache_page_size(encoded_page);
> -
>         if (unlikely(!encoded_page)) {
>  refill:
>                 page =3D __page_frag_cache_refill(nc, gfp_mask);
> @@ -94,6 +92,9 @@ void *__page_frag_alloc_align(struct page_frag_cache *n=
c,
>                 /* reset page count bias and offset to start of new frag =
*/
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>                 nc->offset =3D 0;

Your code above said that offset wasn't reset. But it looks like it is
reset here isn't it?

> +       } else {
> +               size =3D page_frag_cache_page_size(encoded_page);
> +               page =3D page_frag_encoded_page_ptr(encoded_page);
>         }
>
>         offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> @@ -111,8 +112,6 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>                         return NULL;
>                 }
>
> -               page =3D page_frag_encoded_page_ptr(encoded_page);
> -
>                 if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>                         goto refill;
>

These 3 changes to move the size and page are unnecessary
optimization. I would recommend just dropping them and leave the code
as is as you are just optimizing for unlikely paths.

> @@ -130,12 +129,13 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
>                 offset =3D 0;
>         }
>
> -       nc->pagecnt_bias--;
> -       nc->offset =3D offset + fragsz;
> +       pfrag->page =3D page;
> +       pfrag->offset =3D offset;
> +       pfrag->size =3D size - offset;

Why are you subtracting the offset from the size? Shouldn't this just be fr=
agsz?

>
>         return page_frag_encoded_page_address(encoded_page) + offset;
>  }
> -EXPORT_SYMBOL(__page_frag_alloc_align);
> +EXPORT_SYMBOL(__page_frag_cache_prepare);
>
>  /*
>   * Frees a page fragment allocated out of either a compound or order 0 p=
age.
> --
> 2.33.0
>

