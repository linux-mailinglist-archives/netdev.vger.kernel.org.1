Return-Path: <netdev+bounces-118548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6E951F90
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C21C2135D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C11B86EF;
	Wed, 14 Aug 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdTWjsaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6501B583E;
	Wed, 14 Aug 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652032; cv=none; b=J6ugOuZiFY1VgNqK5xrPg3bf/P8O5ABXz4K2SrDjnt5/fRKY3+PeRL5al0RyfoUug/fH3urGoL4thrOuuy+Y1jSN3tsc5GMV1SvtAXFcfN9e+XczXbgHfdCwLdUx9f7IDLa9W0oiNWqEo3OPFGqze9PHfwaJi/Z4rhzct2aGoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652032; c=relaxed/simple;
	bh=K2X6lqIt4oqj9WozWOF5kI2WhgVoaEzw5fLqAo3f+E8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQpSD7zfHMkwrpLapv+VUci693ldVhsaWVAAnE9ft1MdmSMjiDqXGm7Ru0jF6e5zDUVe6yhwjODALqS55qjX+DzUikat94TFQElMdshbsVM5CDhXPlQ1cPjexK4FFZK1ZROP1B8wdjpPJAx1hXQXcESU0EH5eC7n8mX1hDEyT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdTWjsaP; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db14339fb0so3978841b6e.2;
        Wed, 14 Aug 2024 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723652030; x=1724256830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCyjb3mnfTPaKoctmLyaAyNHjt8Z0FPJhAgwTRiDEi0=;
        b=HdTWjsaPZgC0QUv6XfqYvYX7MyPPLmjCiuYs+E+YFoMXBXYkCo/QWrHcn85S2/zzkW
         8Yv00kO6NWCmohcmWlMP00GEuz0ujPhRw7hRnhh6VSsa9B1jL3uxzHJJf+5Yq1Rc3zl4
         qQiWJI5bFwOYMsuqDgQ8Rrzp5UVuvYS8tnHpu2QSzk84eu46UCmx+3PYYcbMb7rnMUdw
         XfrE9lsUH7sGHf6q5uisoslYvT7EZKgJ0Wbu7lm0yJiU3HcsTaQVr+G3gxkrGgTr2nJO
         kjI7yo1tdnVbRfTLq5EGGu81VKhO0tMUnGB0Ss8Xf9mJAMB79FKF1eQzOLykGNIHRsjm
         9Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652030; x=1724256830;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCyjb3mnfTPaKoctmLyaAyNHjt8Z0FPJhAgwTRiDEi0=;
        b=bACT3bq6k/TArx19em1c+RCGhoLeTK5L3ZD3bkJ92zF0Hwsvh3WIV88c2CZwloky3P
         JS4mdm4q4aQVwp4Ymxgkvt2pLPNjLlQhjnaRH1uvAXaS2pwAhcQbcyLh0VP/pAf01AhA
         0wYDmLMgoDVMcUd+iYwZhJjnE33HQt0icjY5wIfWUqoyojwPSwGez/ENqGWE1NVSGqWw
         S0LBGDeWqGRVrF1tFXJviwjWQ40AWSZ3qpGVbtDcaQdDa4Xk4rKyBbpjnMH1WwDicGsB
         jn8knTBZ+q7yT+6ZqkXmoq+J+CB1iCijpLRFVwlvZwCyC51QXLeipCqy4llkUoJUtfXU
         3itQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXA2wvhIY66mXTNq5mBl062KCWih+0LWPsG4Bu1j+nphQPniGx34gMlEbk0R84ipze1qbOAAlPVu3dx0SZaJUagf0B/q4+VyDyeVxq
X-Gm-Message-State: AOJu0YxulrYMd9zQlfnH6HvWHLx6emdsqLsANpTb/7jZZdTcC+Ge0BWE
	DMLSDHiCMGJJGa0cbVSHWAtdXkei8UAMqvG4812on3lEUMH9kP/J1o9u5FdG
X-Google-Smtp-Source: AGHT+IENU7cpU2pFm0qKgdOlSxiHsZ0ZHuOzmH9FVR0zSBS1p+ccnZee/GztUrMk/geixjsRlTd5Dw==
X-Received: by 2002:a05:6808:1154:b0:3d9:2bab:de1f with SMTP id 5614622812f47-3dd29914c49mr4057519b6e.25.1723652030211;
        Wed, 14 Aug 2024 09:13:50 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3dd060bc16csm2133562b6e.56.2024.08.14.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:13:49 -0700 (PDT)
Message-ID: <0002cde37fcead62813006ab9516c5b2fdbf113a.camel@gmail.com>
Subject: Re: [PATCH net-next v13 07/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 14 Aug 2024 09:13:47 -0700
In-Reply-To: <20240808123714.462740-8-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	 <20240808123714.462740-8-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> Currently there is one 'struct page_frag' for every 'struct
> sock' and 'struct task_struct', we are about to replace the
> 'struct page_frag' with 'struct page_frag_cache' for them.
> Before begin the replacing, we need to ensure the size of
> 'struct page_frag_cache' is not bigger than the size of
> 'struct page_frag', as there may be tens of thousands of
> 'struct sock' and 'struct task_struct' instances in the
> system.
>=20
> By or'ing the page order & pfmemalloc with lower bits of
> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> And page address & pfmemalloc & order is unchanged for the
> same page in the same 'page_frag_cache' instance, it makes
> sense to fit them together.
>=20
> After this patch, the size of 'struct page_frag_cache' should be
> the same as the size of 'struct page_frag'.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/mm_types_task.h   | 16 +++++-----
>  include/linux/page_frag_cache.h | 52 +++++++++++++++++++++++++++++++--
>  mm/page_frag_cache.c            | 49 +++++++++++++++++--------------
>  3 files changed, 85 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index b1c54b2b9308..f2610112a642 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -50,18 +50,18 @@ struct page_frag {
>  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>  struct page_frag_cache {
> -	void *va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	/* encoded_va consists of the virtual address, pfmemalloc bit and order
> +	 * of a page.
> +	 */
> +	unsigned long encoded_va;
> +

Rather than calling this an "encoded_va" we might want to call this an
"encoded_page" as that would be closer to what we are actually working
with. We are just using the virtual address as the page pointer instead
of the page struct itself since we need quicker access to the virtual
address than we do the page struct.

> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>  	__u16 remaining;
> -	__u16 size;
> +	__u16 pagecnt_bias;
>  #else
>  	__u32 remaining;
> +	__u32 pagecnt_bias;
>  #endif
> -	/* we maintain a pagecount bias, so that we dont dirty cache line
> -	 * containing page->_refcount every time we allocate a fragment.
> -	 */
> -	unsigned int		pagecnt_bias;
> -	bool pfmemalloc;
>  };
> =20
>  /* Track pages that require TLB flushes */
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 7c9125a9aed3..4ce924eaf1b1 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -3,18 +3,66 @@
>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>  #define _LINUX_PAGE_FRAG_CACHE_H
> =20
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
>  #include <linux/log2.h>
>  #include <linux/types.h>
>  #include <linux/mm_types_task.h>
> =20
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +/* Use a full byte here to enable assembler optimization as the shift
> + * operation is usually expecting a byte.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
> +#else
> +/* Compiler should be able to figure out we don't read things as any val=
ue
> + * ANDed with 0 is 0.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK		0
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(0)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	0
> +#endif
> +

You should probably pull out PAGE_FRAG_CACHE_PFMEMALLOC_BIT and just
define it as:
#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT \
	BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)

That way there is no risk of the bit and the shift somehow getting
split up and being different values.

> +static inline unsigned long encode_aligned_va(void *va, unsigned int ord=
er,
> +					      bool pfmemalloc)

Rather than passing the virtual address it might make more sense to
pass the page. With that you know it should be PAGE_SIZE aligned versus
just being passed some random virtual address.

> +{
> +	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
> +	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT >=3D PAGE_SHIFT);

Rather than test the shift I would test the bit versus PAGE_SIZE.

> +
> +	return (unsigned long)va | (order & PAGE_FRAG_CACHE_ORDER_MASK) |
> +		((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> +}
> +
> +static inline unsigned long encoded_page_order(unsigned long encoded_va)
> +{
> +	return encoded_va & PAGE_FRAG_CACHE_ORDER_MASK;
> +}
> +
> +static inline bool encoded_page_pfmemalloc(unsigned long encoded_va)
> +{
> +	return !!(encoded_va & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
> +}
> +
> +static inline void *encoded_page_address(unsigned long encoded_va)
> +{
> +	return (void *)(encoded_va & PAGE_MASK);
> +}
> +

This is one of the reasons why I am thinking "encoded_page" might be a
better name for it. The 3 functions above all have their equivilent for
a page struct but we pulled that data out and packed it all into the
encoded_page.



