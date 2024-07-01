Return-Path: <netdev+bounces-108297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A186D91EB55
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 01:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E31F222EB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D4171653;
	Mon,  1 Jul 2024 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l27lbFKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005E38DD9;
	Mon,  1 Jul 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719876473; cv=none; b=lbc0Lcf84tS3lDWPssdX+vEGofcX1jhbMabbrsO7WK9xgunu1aJHZgBvaYridjNFNeSC+eY/ootuXBMLyjuaTAXOIzfW3sB26bQBInk32RSNZDm5ymx0HzXn7fXQORep4i7O3QS9S3JKuf44MzT8tfrU+hnb5Rbp7WwEVvbRJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719876473; c=relaxed/simple;
	bh=SDGeeG5xkcsfZjbvgbd+7gf77Au1j8CYikgZAZsXgyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1ZghA0n9c1jF+RPWOlLqYq01JaScRYM1PssLMYilgDLGx7dFAUssF5dW3PTeIiEp/e3adisITMlmO8YNzKojcEuYM8L+J+Z7E5ZtKqevC9sQuzbijhR0GFcdLNwgDwZZCofiQ8kUZwO9AXM8RwNobmbBAjGRtis8eFo4meAB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l27lbFKO; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d56285aa18so1563062b6e.2;
        Mon, 01 Jul 2024 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719876470; x=1720481270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=76/gZ390qF9o/E7hcl7yvTWNr8WqJpJYNL9n9m4Vg/I=;
        b=l27lbFKO6vDU/3pM8drzoK3/FV4saTeFNIquYrZXgzoYZoxbXF+GFlIVfiW5UAX7Ij
         +gy7NoYx+j/oaqEe69F4QhOJiq5Fm/WMOe7jWO/J4jCzQekVcGjBm9uc08i04wusRQ3T
         vTdY003e30CwO/oH2QaWU5dU2+gARKLhcaWbkz/opTpLqNjluEYwomouhE2sCkErYLio
         Y/YhF+ZLqY5kUU+kOXVxVCMmyg9061vV6g5aMeYtp8KOuVltsEnf8qrPE/CUvEse7UGK
         O14ebP5QKCcC2IVwHFkf9Z6QIhLRPSDXLyzy0eWJUjHhqJuayJ6USD3RkrRj+Kew3eiq
         rntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719876470; x=1720481270;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76/gZ390qF9o/E7hcl7yvTWNr8WqJpJYNL9n9m4Vg/I=;
        b=qb6njEYlGzUZrpwrQJc5QfJwMxll23TUw26WWEgu6Zvqzu9T10gqECT3p7U8p1JSnP
         At1RfPr5aMzCc2tCFN8L7mEiy44au0OOW2BAmY+gLd/E+Adj7S3sk+vSiEyf78xd6QRc
         ZlB9G+Zt5ODYK+vRCqQmkkKi3S4I48aDSaEL7DzQXjVv3H/Fd1Dm3gxzi0xVxXIlW5ir
         t1IPOYH9u0QUxFTNDUpDSze99kDP43Lpx97ULdkzIfsHVI30zWui2FtPWY9etGTZluLz
         UbSlwCDth7/xawK5zbxDnkWWgumcYnLYWzhrIQkAmoZQQBn9vqPJU/4AgV9mEVrNQsRA
         tDDg==
X-Forwarded-Encrypted: i=1; AJvYcCXLdJZU02mNE3ZP7IKeYwgxHsS6Iuyf/+66S6kMdq6CpJfxYVYJJ+bUcbpKnRW4L+4F6EHdykxxGFYBjCf+eN2FeaeYLwuXjwAbGQCc
X-Gm-Message-State: AOJu0Yz64Ih+1jyhhBiqZIb0jnv90kX4wqh4xiH/S5RQDbHrrIT+Wa6a
	Qs//P+yva5q68+Df19/tO4cE9J5vqZ5F/juEAQEpTYJ7gpR1Y602
X-Google-Smtp-Source: AGHT+IFTas9QKVB5IeQv8pE6F/a4Mr2QBk6CLEqmOgnBodeX1KGm0+fpKOchpheX1cTy9E2wDqqg7g==
X-Received: by 2002:a05:6808:f8d:b0:3d6:32b4:b8fa with SMTP id 5614622812f47-3d6b30f45cemr9299758b6e.13.1719876470469;
        Mon, 01 Jul 2024 16:27:50 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.103.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70802567926sm7120203b3a.54.2024.07.01.16.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 16:27:49 -0700 (PDT)
Message-ID: <8e80507c685be94256e0e457ee97622c4487716c.camel@gmail.com>
Subject: Re: [PATCH net-next v9 03/13] mm: page_frag: use initial zero
 offset for page_frag_alloc_align()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Mon, 01 Jul 2024 16:27:48 -0700
In-Reply-To: <20240625135216.47007-4-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-4-linyunsheng@huawei.com>
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
> We are above to use page_frag_alloc_*() API to not just
"about to use", not "above to use"

> allocate memory for skb->data, but also use them to do
> the memory allocation for skb frag too. Currently the
> implementation of page_frag in mm subsystem is running
> the offset as a countdown rather than count-up value,
> there may have several advantages to that as mentioned
> in [1], but it may have some disadvantages, for example,
> it may disable skb frag coaleasing and more correct cache
> prefetching
>=20
> We have a trade-off to make in order to have a unified
> implementation and API for page_frag, so use a initial zero
> offset in this patch, and the following patch will try to
> make some optimization to aovid the disadvantages as much
> as possible.
>=20
> As offsets is added due to alignment requirement before
> actually checking if the cache is enough, which might make
> it exploitable if caller passes a align value bigger than
> 32K mistakenly. As we are allowing order 3 page allocation
> to fail easily under low memory condition, align value bigger
> than PAGE_SIZE is not really allowed, so add a 'align >
> PAGE_SIZE' checking in page_frag_alloc_va_align() to catch
> that.
>=20
> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.c=
amel@gmail.com/
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h |  2 +-
>  include/linux/skbuff.h          |  4 ++--
>  mm/page_frag_cache.c            | 26 +++++++++++---------------
>  3 files changed, 14 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 3a44bfc99750..b9411f0db25a 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -32,7 +32,7 @@ static inline void *page_frag_alloc_align(struct page_f=
rag_cache *nc,
>  					  unsigned int fragsz, gfp_t gfp_mask,
>  					  unsigned int align)
>  {
> -	WARN_ON_ONCE(!is_power_of_2(align));
> +	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
>  	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
>  }
> =20
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index eb8ae8292c48..d1fea23ec386 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3320,7 +3320,7 @@ static inline void *netdev_alloc_frag(unsigned int =
fragsz)
>  static inline void *netdev_alloc_frag_align(unsigned int fragsz,
>  					    unsigned int align)
>  {
> -	WARN_ON_ONCE(!is_power_of_2(align));
> +	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
>  	return __netdev_alloc_frag_align(fragsz, -align);
>  }
> =20
> @@ -3391,7 +3391,7 @@ static inline void *napi_alloc_frag(unsigned int fr=
agsz)
>  static inline void *napi_alloc_frag_align(unsigned int fragsz,
>  					  unsigned int align)
>  {
> -	WARN_ON_ONCE(!is_power_of_2(align));
> +	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
>  	return __napi_alloc_frag_align(fragsz, -align);
>  }
> =20
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 88f567ef0e29..da244851b8a4 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -72,10 +72,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *=
nc,
>  		if (!page)
>  			return NULL;
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -		/* if size can vary use size else just use PAGE_SIZE */
> -		size =3D nc->size;
> -#endif
>  		/* Even if we own the page, we do not use atomic_set().
>  		 * This would break get_page_unless_zero() users.
>  		 */
> @@ -84,11 +80,16 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>  		/* reset page count bias and offset to start of new frag */
>  		nc->pfmemalloc =3D page_is_pfmemalloc(page);
>  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->offset =3D size;
> +		nc->offset =3D 0;
>  	}
> =20
> -	offset =3D nc->offset - fragsz;
> -	if (unlikely(offset < 0)) {
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	/* if size can vary use size else just use PAGE_SIZE */
> +	size =3D nc->size;
> +#endif
> +
> +	offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> +	if (unlikely(offset + fragsz > size)) {

The fragsz check below could be moved to here.

>  		page =3D virt_to_page(nc->va);
> =20
>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> @@ -99,17 +100,13 @@ void *__page_frag_alloc_align(struct page_frag_cache=
 *nc,
>  			goto refill;
>  		}
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -		/* if size can vary use size else just use PAGE_SIZE */
> -		size =3D nc->size;
> -#endif
>  		/* OK, page count is 0, we can safely set it */
>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> =20
>  		/* reset page count bias and offset to start of new frag */
>  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		offset =3D size - fragsz;
> -		if (unlikely(offset < 0)) {
> +		offset =3D 0;
> +		if (unlikely(fragsz > PAGE_SIZE)) {

Since we aren't taking advantage of the flag that is left after the
subtraction we might just want to look at moving this piece up to just
after the offset + fragsz check. That should prevent us from trying to
refill if we have a request that is larger than a single page. In
addition we could probably just drop the 3 PAGE_SIZE checks above as
they would be redundant.

>  			/*
>  			 * The caller is trying to allocate a fragment
>  			 * with fragsz > PAGE_SIZE but the cache isn't big
> @@ -124,8 +121,7 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>  	}
> =20
>  	nc->pagecnt_bias--;
> -	offset &=3D align_mask;
> -	nc->offset =3D offset;
> +	nc->offset =3D offset + fragsz;
> =20
>  	return nc->va + offset;
>  }


