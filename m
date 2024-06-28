Return-Path: <netdev+bounces-107852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CC291C91F
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 00:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F131C21344
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266E811EB;
	Fri, 28 Jun 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jINno7Nt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5F7B3F3;
	Fri, 28 Jun 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614108; cv=none; b=E9HF7Jsxd/QyYwfs5j8zBOz37FWsX7qqqnaDdqGg+/Rik7+q/ZKcrjEteqx+mD+IKejCHTXqPpScs5CGFSDak9kRtOs/U0vBo8pjOxhmRRSBvBwG+DeQCuviFch/WWdFLfMX/y1HBUwrKV83b8FS0LZ4HY1G2b8j/Ey7rCjf+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614108; c=relaxed/simple;
	bh=07DYTvr+1cJJnnI4lcrtI01YvZ/CoNFQl7uUpMSlcko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivxGN39If3kcnGJxMkyT5cvRVFID1XvqtQZG2GXugHyc9+ITcdrDpLr9HzbkiT5Y5jH9U3+DOWiTNX3aYnGvigsFBaiFlYWQ9OovF+litJHu2Iji4jtLyEryxIkZpGaXdI4VhtLhLvsew7RmOhafm6NUi9AQeuI/mxjq9RL8g+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jINno7Nt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706b53ee183so1617604b3a.1;
        Fri, 28 Jun 2024 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719614106; x=1720218906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k/Il0CyJ05RUxTJn8nhYPqyFFh/jRSTkpMyOabX2+KY=;
        b=jINno7NtvDkk2buiveCWRx26AE1Z52u8j3DodteTCeygfxTX4nKdEDw319s9UAmbU1
         yV3sQpcuWNN4JZgZSDPBpWcMi5FqQGofIgLFpO5oxwFF0KlBHRyVXEWqhSNancZE1uvQ
         5IUrlKTj1450oxPskmxZJ6KBTk+ELdOxWH+L2Ciqw3UXAt7X/Ps/rXbo5IgQBXv2/jZX
         pWDPVQp1li4feqBBk/myo/8DFA1lmP38ciIxh0S5bJuPX8o5jZNd70mBbyNoQj9gvYv+
         B63GCWSQPEH2ykRcvMwMGcqluOffCleCzms5QpHQEOtY5lBLxclWgc2EtBwF3pBWJ0Vg
         UhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719614106; x=1720218906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/Il0CyJ05RUxTJn8nhYPqyFFh/jRSTkpMyOabX2+KY=;
        b=mooDNJawvp1Gua9L8TbegRJvWkfVcCgCSwuqABTNo2pjjJ95Z5+0EGWGiECk2qHMBU
         go4ilv3r6LhSiDPATmJUKZOpZM+v7yhkYOMk/d22bTnlMHgQTArAmeB9TGxdB3asvmap
         zi0gXHhQQFUOJTJF/GOti3x/Azoo+oxPa2hBY/J/4q6elVj9Wc0M8h0MDzgqCXyaUh1/
         wPR5M1DR1XRKuT6EO3/1bUXZU9ANimlsoeco31VyqiFZDag6lsAmTSHdC7arIzyEnbQR
         v95fs8ltnLrqMAkUWYSvzDkFJzE6mMEaEYEbpI4W3z5ydC4CgWq85F5p5jeYiX5KI6FT
         Z1VA==
X-Forwarded-Encrypted: i=1; AJvYcCWjdOCsfREIEwVRhwGUbRo51hyGjUqEIByt57ywiUO0GLj/2svB/cu32mTAF8OpPsJiMoriFDWp7M6GlpXJ9cN/f8exR+SakfO8KigC
X-Gm-Message-State: AOJu0Yx3hD1HkndhkV8du6TiuvMDuDNnWEqFd51TX/nF7XTuQqXEOCLS
	p+EOFmqAx0Tl7kViAdMYU6zTZb3lcTCiuNFt8UeJNmQMP+c6OeGjxIYkUQ==
X-Google-Smtp-Source: AGHT+IFdAI8lVdgvZ8QDwW9Tb7xEOZPV/kOLSX7mFxiYpppyd+S5/RqWY2OwYARoewQLD24aY4u95A==
X-Received: by 2002:a05:6a21:1a1:b0:1be:bfc9:dbcf with SMTP id adf61e73a8af0-1bee4926c47mr4315795637.13.1719614105892;
        Fri, 28 Jun 2024 15:35:05 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-72c69b53e3dsm1769146a12.9.2024.06.28.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 15:35:05 -0700 (PDT)
Message-ID: <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Fri, 28 Jun 2024 15:35:04 -0700
In-Reply-To: <20240625135216.47007-11-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-11-linyunsheng@huawei.com>
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
> There are many use cases that need minimum memory in order
> for forward progress, but more performant if more memory is
> available or need to probe the cache info to use any memory
> available for frag caoleasing reason.
>=20
> Currently skb_page_frag_refill() API is used to solve the
> above use cases, but caller needs to know about the internal
> detail and access the data field of 'struct page_frag' to
> meet the requirement of the above use cases and its
> implementation is similar to the one in mm subsystem.
>=20
> To unify those two page_frag implementations, introduce a
> prepare API to ensure minimum memory is satisfied and return
> how much the actual memory is available to the caller and a
> probe API to report the current available memory to caller
> without doing cache refilling. The caller needs to either call
> the commit API to report how much memory it actually uses, or
> not do so if deciding to not use any memory.
>=20
> As next patch is about to replace 'struct page_frag' with
> 'struct page_frag_cache' in linux/sched.h, which is included
> by the asm-offsets.s, using the virt_to_page() in the inline
> helper of page_frag_cache.h cause a "'vmemmap' undeclared"
> compiling error for asm-offsets.s, use a macro for probe API
> to avoid that compiling error.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h |  82 +++++++++++++++++++++++
>  mm/page_frag_cache.c            | 114 ++++++++++++++++++++++++++++++++
>  2 files changed, 196 insertions(+)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index b33904d4494f..e95d44a36ec9 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -4,6 +4,7 @@
>  #define _LINUX_PAGE_FRAG_CACHE_H
> =20
>  #include <linux/gfp_types.h>
> +#include <linux/mmdebug.h>
> =20
>  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
> @@ -87,6 +88,9 @@ static inline unsigned int page_frag_cache_page_size(st=
ruct encoded_va *encoded_
> =20
>  void page_frag_cache_drain(struct page_frag_cache *nc);
>  void __page_frag_cache_drain(struct page *page, unsigned int count);
> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
> +				unsigned int *offset, unsigned int fragsz,
> +				gfp_t gfp);
>  void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask);
> @@ -99,12 +103,90 @@ static inline void *page_frag_alloc_va_align(struct =
page_frag_cache *nc,
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
>  }
> =20
> +static inline unsigned int page_frag_cache_page_offset(const struct page=
_frag_cache *nc)
> +{
> +	return page_frag_cache_page_size(nc->encoded_va) - nc->remaining;
> +}
> +
>  static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
>  				       unsigned int fragsz, gfp_t gfp_mask)
>  {
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, ~0u);
>  }
> =20
> +void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned in=
t *fragsz,
> +				 gfp_t gfp);
> +
> +static inline void *page_frag_alloc_va_prepare_align(struct page_frag_ca=
che *nc,
> +						     unsigned int *fragsz,
> +						     gfp_t gfp,
> +						     unsigned int align)
> +{
> +	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
> +	nc->remaining =3D nc->remaining & -align;
> +	return page_frag_alloc_va_prepare(nc, fragsz, gfp);
> +}
> +
> +struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
> +					unsigned int *offset,
> +					unsigned int *fragsz, gfp_t gfp);
> +
> +struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
> +				     unsigned int *offset,
> +				     unsigned int *fragsz,
> +				     void **va, gfp_t gfp);
> +
> +static inline struct encoded_va *__page_frag_alloc_probe(struct page_fra=
g_cache *nc,
> +							 unsigned int *offset,
> +							 unsigned int *fragsz,
> +							 void **va)
> +{
> +	struct encoded_va *encoded_va;
> +
> +	*fragsz =3D nc->remaining;
> +	encoded_va =3D nc->encoded_va;
> +	*offset =3D page_frag_cache_page_size(encoded_va) - *fragsz;
> +	*va =3D encoded_page_address(encoded_va) + *offset;
> +
> +	return encoded_va;
> +}
> +
> +#define page_frag_alloc_probe(nc, offset, fragsz, va)			\
> +({									\
> +	struct page *__page =3D NULL;					\
> +									\
> +	VM_BUG_ON(!*(fragsz));						\
> +	if (likely((nc)->remaining >=3D *(fragsz)))			\
> +		__page =3D virt_to_page(__page_frag_alloc_probe(nc,	\
> +							      offset,	\
> +							      fragsz,	\
> +							      va));	\
> +									\
> +	__page;								\
> +})
> +

Why is this a macro instead of just being an inline? Are you trying to
avoid having to include a header due to the virt_to_page?


