Return-Path: <netdev+bounces-131807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F698F9F7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C484AB2157F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04491CDA3E;
	Thu,  3 Oct 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6n4xkV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BA1CDFA8;
	Thu,  3 Oct 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995274; cv=none; b=a0GBGp4jIBvjPSxNUrE/hxaGbBOjqkiLlpSJoUO8caOj35pxG4vIGCd+9mJthuHlxaWIBBfoSx/3Qek7jyOBrJKnRyaNdxdNHDDfYX0uAtk9E+FQKghUjQm+sb5e9ZzFD9tdlVui+fqgw6/2PlGAir9SHfwtBTzLsNEFCpPLDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995274; c=relaxed/simple;
	bh=GLvPQL3s2+cKbxSaOtUy8qApg11QAwmpzEehP7N+TkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPr/szErwVZWRshlcK8ak/mPo0fzUu5CzhNwrIXYHhRCwbg70ZH9B8FGihntKLDiW6/FnkWokf0ZfveM/F4v/li27a+eKnEKt0RaSp1oAUHkzyBm3ySaL6MwUZFg1mUskI2Tv9xHuGA/tM0/DuSb01CXYOFw8CRv+9XmxVNxn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6n4xkV6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc84c12c2so859587f8f.3;
        Thu, 03 Oct 2024 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727995271; x=1728600071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c3hGmLuHS4pscUC6pHa6uh6N08NC8gTb0JYFZQBbgo=;
        b=N6n4xkV6a0l6+dg7emD+A+P/sznqW0OuuAObh32vnMNiCys4QEhyEv5nAVx6LZryXr
         yX8ImCDPL/M6WjHmu0a5LCakXOKHyHMGOgkxCDmT7kU2WsGXB0ZLUpwig3kOHZkDRHpw
         KwqZeNJ1hKP2isfy6iDkmhjbwdP+jzuMcKJewFzB5/XhwjYFa095wy4ID4hjatu0kf69
         YFa/f/V455hukvEDfsI2Cb41xvktUfeSfwGBiIKSjxPVi7rudU6phAosCGEe0kwvXgvp
         kdFId7tUjCfbIRPvCF4YOfjBneklBFbSTH9jk3tTzTgUty5Y94Z25dLpHFT9QmGBJGgk
         qmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995271; x=1728600071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/c3hGmLuHS4pscUC6pHa6uh6N08NC8gTb0JYFZQBbgo=;
        b=IxOuUaQvYgs0LN0wL4JuuI0pdBHlDN1fyuabfRWK0EJs8FhRn0H4lXlKXivomgdQjW
         W6Zn+Jh/cbAq+2ZrL90axJcLtZ8UEpvY4zlLclz9Ff/sC6IZGQ/Mad7PtIXNDXK9qFxR
         O3qkSsHA3DuONossSpcHJAdw2HECzj3B4u+3ns+g0XMrGcMW6gwAEakpxJatugAgst23
         77kXXOtOFqSfFHhmq1oC0CEl+Wka/W/hYC1MVzwXFahKgMAPV9veNEO1GLowiija7W1u
         4y70X7lKOIQN6VCB1pct3PhMHECqO4KmmNKeA3Ep1GVUU4AUBFbLyZNvCBXgthnQu2uN
         k1lg==
X-Forwarded-Encrypted: i=1; AJvYcCVuMO/R056Rvz/HRxC6YTrb1NqRW7B2r50W0BoZV8kGh+15BZC2zKxp/qmuA2hJeEjIoBhj7lgf@vger.kernel.org, AJvYcCX0EciqlRzWcxCQ0sN97dSilOCwdr6e9kweM3v8gTT5dItBtScuQTBWyUD5zewGaLYrz+J8aOvdsoTdh+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeJZlIn3h3ope4mJpTOYHiEtYjGBJiwgRPFdI8efNsE9OQBG6
	h0tLwX2qj8QyrCXvmPWer+A2SwfFvXcMdEg4J8KUOkTx46OKzQoTPBB672HHY5VgYZENPEEVkIZ
	K+HToQc103iWxs0WZv/VbmNqvhDU=
X-Google-Smtp-Source: AGHT+IHfK6TyAzGjZEYhjfDzLgVDZmSbnKje6qw23KJ1XRBBiloYnMzwxbGx/BEfh+aDH9km1ubNbONqWOSSS0A14pc=
X-Received: by 2002:adf:ce8f:0:b0:371:8a3a:680a with SMTP id
 ffacd0b85a97d-37d0e782737mr444823f8f.32.1727995271184; Thu, 03 Oct 2024
 15:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001075858.48936-1-linyunsheng@huawei.com> <20241001075858.48936-7-linyunsheng@huawei.com>
In-Reply-To: <20241001075858.48936-7-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 Oct 2024 15:40:34 -0700
Message-ID: <CAKgT0UdMwDyf9u6sQVjsJuxpWmKNi3RYkB7UOSvH6QxXvG7_zQ@mail.gmail.com>
Subject: Re: [PATCH net-next v19 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yunsheng Lin <linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> Currently there is one 'struct page_frag' for every 'struct
> sock' and 'struct task_struct', we are about to replace the
> 'struct page_frag' with 'struct page_frag_cache' for them.
> Before begin the replacing, we need to ensure the size of
> 'struct page_frag_cache' is not bigger than the size of
> 'struct page_frag', as there may be tens of thousands of
> 'struct sock' and 'struct task_struct' instances in the
> system.
>
> By or'ing the page order & pfmemalloc with lower bits of
> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> And page address & pfmemalloc & order is unchanged for the
> same page in the same 'page_frag_cache' instance, it makes
> sense to fit them together.
>
> After this patch, the size of 'struct page_frag_cache' should be
> the same as the size of 'struct page_frag'.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/mm_types_task.h   | 19 +++++----
>  include/linux/page_frag_cache.h | 26 +++++++++++-
>  mm/page_frag_cache.c            | 75 +++++++++++++++++++++++----------
>  3 files changed, 88 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index 0ac6daebdd5c..a82aa80c0ba4 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -47,18 +47,21 @@ struct page_frag {
>  #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
>  struct page_frag_cache {
> -       void *va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +       /* encoded_page consists of the virtual address, pfmemalloc bit a=
nd
> +        * order of a page.
> +        */
> +       unsigned long encoded_page;
> +
> +       /* we maintain a pagecount bias, so that we dont dirty cache line
> +        * containing page->_refcount every time we allocate a fragment.
> +        */
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>         __u16 offset;
> -       __u16 size;
> +       __u16 pagecnt_bias;
>  #else
>         __u32 offset;
> +       __u32 pagecnt_bias;
>  #endif
> -       /* we maintain a pagecount bias, so that we dont dirty cache line
> -        * containing page->_refcount every time we allocate a fragment.
> -        */
> -       unsigned int            pagecnt_bias;
> -       bool pfmemalloc;
>  };
>
>  /* Track pages that require TLB flushes */
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 0a52f7a179c8..75aaad6eaea2 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -3,18 +3,40 @@
>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>  #define _LINUX_PAGE_FRAG_CACHE_H
>
> +#include <linux/bits.h>
>  #include <linux/log2.h>
>  #include <linux/mm_types_task.h>
>  #include <linux/types.h>
>
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +/* Use a full byte here to enable assembler optimization as the shift
> + * operation is usually expecting a byte.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK             GENMASK(7, 0)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       8
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEM=
ALLOC_SHIFT)
> +#else
> +/* Compiler should be able to figure out we don't read things as any val=
ue
> + * ANDed with 0 is 0.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK             0
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       0
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEM=
ALLOC_SHIFT)
> +#endif
> +

Minor nit on this. You probably only need to have
PAGE_FRAG_CACHE_ORDER_SHIFT defined in the ifdef. The PFMEMALLOC bit
code is the same in both so you could pull it out.

Also depending on how you defined it you could just define the
PFMEMALLOC_BIT as the ORDER_MASK + 1.

