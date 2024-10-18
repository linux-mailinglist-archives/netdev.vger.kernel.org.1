Return-Path: <netdev+bounces-137082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B29A4494
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241201C22C69
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5A204013;
	Fri, 18 Oct 2024 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLQv6oP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937714F136;
	Fri, 18 Oct 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272448; cv=none; b=avlDEd+ztIns8ZZrDeNR+47zn6fLeDMNXqJ3YCcEIwUmJ68pKLLCReuvDkCXYUzEwiXa2Z1H2idOscKKqyP93wRvAbmmNy9rWJ364L6KwyRBfRvm/k9lcfWrtvwuk9kyxqs/Hzd2ozRwdFe37e2+Gyu2AXv0ssrdKt5O/A6qYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272448; c=relaxed/simple;
	bh=VlIfCeOCYHviD838Htt2ZFgVvGpRFb064P8wHF6L5ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBBNh3eEL/rlZytubeylQF8WgyB3pIf+POgLs5dnrKb0yGHQk9eEJ+yk13ZSSnlIJvOCma+Vf+MPRgQLC5OIYLUuE151FoS0F7yAoDeFsL4qMr/5jPR0cmkLuRNz8pqHhWv5LYu67c837nmqyNxWKHHNlrGFCAM4jJCA10lYnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLQv6oP2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so2350173f8f.2;
        Fri, 18 Oct 2024 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272444; x=1729877244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92JIeKcyj6DKUiC6YryG10zMLa3wiMB0RTYm/202bFU=;
        b=DLQv6oP2phwUNkMgjc7hnTXY5MQUkjD7ut+6Qq+6xqYI8SXAvpVRvFQsgg+S8WvoqT
         4jVLCbNpvozlMWtJx7Npg731KWina8YJ56fbijrM0f2KfoVpnklnjbkonkm4NzH3LJky
         Q7AGdXnKxotZ0W1bXZSSzOWEdVxaafkejYFSLpac5fF12NDZ3KQWmMOehoiPZXX1OHBu
         m/3CusamSa9thZgDmvpYct4VG87H68gC6t6LelATtPz7EDVy2qT0UXor19L3V5/TZ/7C
         6z5FAZ9nwAuxnsP1IHrCqw0QloPs+R2j6bpgMBhTzxX+ke7kP++JGFdqzxb6DI0C0mRo
         R1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272444; x=1729877244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92JIeKcyj6DKUiC6YryG10zMLa3wiMB0RTYm/202bFU=;
        b=RxjSHvpCgDA+rihvjz2u9PYw96Jw3jvn+jAH1Em0dxaLD9Wu5Un8wj490q9BRtvumy
         +l8f8ubnVp2KKCvuWii1uVr1yOYazblWKZhS4y1C0ZXdHB/Ec/31V82paPAv2hPcw+Jt
         KBlV2HO2VGltO7Vp0J0sgGvlinhg/UFsjnhm4Cd7su+HnwuzUJsMxqRB/97uvh8GFq0n
         0MWloayCruP1BT75uGYarPw4w+iKALa8HVKjlS+NyDbQ1abs00UCUXE6LVKxPDAr9W8v
         UhAVKdHi1R7Bkyt1jz2uCJGkPgy7dv8q5clTVIrkXKAjlWFYrMCU/X7jL8MjqUYHqhuq
         7iOw==
X-Forwarded-Encrypted: i=1; AJvYcCUvLD6cUWld2v+AG+y9fkzEzSqUX3jJsP92huK5z9phm7e1uBdkHo/0dXAPrkwnoFFmwNDJMHrv@vger.kernel.org, AJvYcCW8s6HndM8tkfnaRkvVY7xrlUW86okgJiNtIcnd/Up2L1Efoh3rytFzviqGR+/Rt+Dp8CfY1TDKSIEiOOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBV/HUIeQbhJZmfa2tN9MNFxU1jgOY18wnBH0vawBhTFgeHMu6
	7X705Eu4dPC1+PfYtuWUQARsteErK9YRNaBrgU34lo7T/Ihx787Ajg/EeYNXi+1PRxtSSVDicw6
	fEbveBuHrGMlieg/RwjG707EoDKU=
X-Google-Smtp-Source: AGHT+IGys2BLDgm2mjdEHNZ6Cc0H/aMWsKZJ9DL+zpQUKfQJKUmosmgEMX9Iuu36JZigYsTfGl8dSriYMsqkkLs2r2s=
X-Received: by 2002:a5d:4308:0:b0:37d:4619:f975 with SMTP id
 ffacd0b85a97d-37ea21d8b00mr2875211f8f.19.1729272443899; Fri, 18 Oct 2024
 10:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105351.1960345-1-linyunsheng@huawei.com> <20241018105351.1960345-8-linyunsheng@huawei.com>
In-Reply-To: <20241018105351.1960345-8-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 18 Oct 2024 10:26:47 -0700
Message-ID: <CAKgT0UcBveXG3D9aHHADHn3yAwA6mLeQeSqoyP+UwyQ3FDEKGw@mail.gmail.com>
Subject: Re: [PATCH net-next v22 07/14] mm: page_frag: some minor refactoring
 before adding new API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Refactor common codes from __page_frag_alloc_va_align() to
> __page_frag_cache_prepare() and __page_frag_cache_commit(),
> so that the new API can make use of them.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h | 36 +++++++++++++++++++++++++++--
>  mm/page_frag_cache.c            | 40 ++++++++++++++++++++++++++-------
>  2 files changed, 66 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 41a91df82631..feed99d0cddb 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -5,6 +5,7 @@
>
>  #include <linux/bits.h>
>  #include <linux/log2.h>
> +#include <linux/mmdebug.h>
>  #include <linux/mm_types_task.h>
>  #include <linux/types.h>
>
> @@ -39,8 +40,39 @@ static inline bool page_frag_cache_is_pfmemalloc(struc=
t page_frag_cache *nc)
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
> +unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
> +                                           struct page_frag *pfrag,
> +                                           unsigned int used_sz);
> +
> +static inline unsigned int __page_frag_cache_commit(struct page_frag_cac=
he *nc,
> +                                                   struct page_frag *pfr=
ag,
> +                                                   unsigned int used_sz)
> +{
> +       VM_BUG_ON(!nc->pagecnt_bias);
> +       nc->pagecnt_bias--;
> +
> +       return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
> +}
> +
> +static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
> +                                           unsigned int fragsz, gfp_t gf=
p_mask,
> +                                           unsigned int align_mask)
> +{
> +       struct page_frag page_frag;
> +       void *va;
> +
> +       va =3D __page_frag_cache_prepare(nc, fragsz, &page_frag, gfp_mask=
,
> +                                      align_mask);
> +       if (unlikely(!va))
> +               return NULL;
> +
> +       __page_frag_cache_commit(nc, &page_frag, fragsz);

Minor nit here. Rather than if (!va) return I think it might be better
to just go with if (likely(va)) __page_frag_cache_commit.

> +
> +       return va;
> +}
>
>  static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
>                                           unsigned int fragsz, gfp_t gfp_=
mask,
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index a36fd09bf275..a852523bc8ca 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -90,9 +90,31 @@ void __page_frag_cache_drain(struct page *page, unsign=
ed int count)
>  }
>  EXPORT_SYMBOL(__page_frag_cache_drain);
>
> -void *__page_frag_alloc_align(struct page_frag_cache *nc,
> -                             unsigned int fragsz, gfp_t gfp_mask,
> -                             unsigned int align_mask)
> +unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
> +                                           struct page_frag *pfrag,
> +                                           unsigned int used_sz)
> +{
> +       unsigned int orig_offset;
> +
> +       VM_BUG_ON(used_sz > pfrag->size);
> +       VM_BUG_ON(pfrag->page !=3D encoded_page_decode_page(nc->encoded_p=
age));
> +       VM_BUG_ON(pfrag->offset + pfrag->size >
> +                 (PAGE_SIZE << encoded_page_decode_order(nc->encoded_pag=
e)));
> +
> +       /* pfrag->offset might be bigger than the nc->offset due to align=
ment */
> +       VM_BUG_ON(nc->offset > pfrag->offset);
> +
> +       orig_offset =3D nc->offset;
> +       nc->offset =3D pfrag->offset + used_sz;
> +
> +       /* Return true size back to caller considering the offset alignme=
nt */
> +       return nc->offset - orig_offset;
> +}
> +EXPORT_SYMBOL(__page_frag_cache_commit_noref);
> +

I have a question. How often is it that we are committing versus just
dropping the fragment? It seems like this approach is designed around
optimizing for not commiting the page as we are having to take an
extra function call to commit the change every time. Would it make
more sense to have an abort versus a commit?

> +void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int=
 fragsz,
> +                               struct page_frag *pfrag, gfp_t gfp_mask,
> +                               unsigned int align_mask)
>  {
>         unsigned long encoded_page =3D nc->encoded_page;
>         unsigned int size, offset;
> @@ -114,6 +136,8 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>                 /* reset page count bias and offset to start of new frag =
*/
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>                 nc->offset =3D 0;
> +       } else {
> +               page =3D encoded_page_decode_page(encoded_page);
>         }
>
>         size =3D PAGE_SIZE << encoded_page_decode_order(encoded_page);

This makes no sense to me. Seems like there are scenarios where you
are grabbing the page even if you aren't going to use it? Why?

I think you would be better off just waiting to the end and then
fetching it instead of trying to grab it and potentially throw it away
if there is no space left in the page. Otherwise what you might do is
something along the lines of:
pfrag->page =3D page ? : encoded_page_decode_page(encoded_page);


> @@ -132,8 +156,6 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>                         return NULL;
>                 }
>
> -               page =3D encoded_page_decode_page(encoded_page);
> -
>                 if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>                         goto refill;
>
> @@ -148,15 +170,17 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
>
>                 /* reset page count bias and offset to start of new frag =
*/
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +               nc->offset =3D 0;
>                 offset =3D 0;
>         }
>
> -       nc->pagecnt_bias--;
> -       nc->offset =3D offset + fragsz;
> +       pfrag->page =3D page;
> +       pfrag->offset =3D offset;
> +       pfrag->size =3D size - offset;

I really think we should still be moving the nc->offset forward at
least with each allocation. It seems like you end up doing two flavors
of commit, one with and one without the decrement of the bias. So I
would be okay with that being pulled out into some separate logic to
avoid the extra increment in the case of merging the pages. However in
both cases you need to move the offset, so I would recommend keeping
that bit there as it would allow us to essentially call this multiple
times without having to do a commit in between to keep the offset
correct. With that your commit logic only has to verify nothing
changes out from underneath us and then update the pagecnt_bias if
needed.

>
>         return encoded_page_decode_virt(encoded_page) + offset;
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

