Return-Path: <netdev+bounces-112334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 000B09385BE
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 19:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9811F20CD1
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D731167DB7;
	Sun, 21 Jul 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT+PV+6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B54400;
	Sun, 21 Jul 2024 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721584740; cv=none; b=MEEaqyZKGaph13xAjTDXUuQeZcfarRY/EtKQfhnjeZyfKHgM1LqVof5rgvIDwzQEgwwBsBpWFEsZr0vefJXxFOK9AgPM9q7z0S6dD0PoPJGDcS7vv+ngzj3DqdI/rOU4Qa43kXaP05CrbbAZRLb5/ObSaEyUEixZqq7I2Qyk6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721584740; c=relaxed/simple;
	bh=JldrNLHeJUKpHsfD34VseUwYt1aswwia5txlOlosGCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2xHSEpulC9XWONhI6Z3qvCGFQFpJeOdHCALrajPN5wshDPiIKqJyBY/4PFmrTSl6eg9cZ6Hc6c9KPGl6ol44Wdm0sjz1lZLfvcd0NY3ztKQVR+UxC3vwR3UYRBRj2vGaYgAW4U93Bc6qqq8ZuTjpMNO7CDl+mZyTVQMKsrHh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT+PV+6m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3685a5e7d3cso1831574f8f.1;
        Sun, 21 Jul 2024 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721584737; x=1722189537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuucJBZjxT13NBnA+XGQcHrdAK4apS6ULN3Imcv4PZg=;
        b=lT+PV+6m4p1nbpVj0sPFtmcLBHA0/WFR9lV7E1LuLPMqh5zs0bSWA3y9GzkNQbQMuL
         LlSSQB4qqa+PSFNNRzgTf4mzr1dnhwdAM2dLCyo7OjsTSZ7mYuQgmBDBiknj+re7dQw8
         znqKT+k3T9ZkfgdBPXtqzZiimxCNZk7vVcpVSyYO9MU4G+81n9Z/PdFs7R/96oQfB511
         XaJvW1d2gH8cY+vWMZmk1H+N4d0tADTQ0LDcjCbrVsl4Ixr8SePWQydg6tVdRjQMXqha
         nf67s5gEFl7vsTPOhu1HmIc86qT/WJDa16U1peq7ofQZJu3ZwX73IYaOmrP/fIaTs4Bv
         sZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721584737; x=1722189537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuucJBZjxT13NBnA+XGQcHrdAK4apS6ULN3Imcv4PZg=;
        b=InHmmor4JwDFvS4Yz99MptVGF1Rc9NtB4+NjhOWlqc7qyHzYd9bvSrPRXuH/DJb3pk
         Df4X8w7h6cPVhDyjCbodE0dwsp7ckXMPeMqwwxLwMMmekNoOmO7ntLzTfyWl7ESq44Sn
         R9thdygGBi+ixNS9fAmvDQRwOTKTQ90poPdzTCgwtalTGhSTPZC5Ui0vGIKHKUP1iev3
         zvR5eScpj/9gsgkZtVBZvb0xvVcVECf1j0O8heBiX87wIMJni45PV9ypdhdLt490mN6t
         344ZXaeyggWvW2RVjRc0LcYlhOPrGSdEgt5wR0UZIDbWlBrTbqVTP5PyN/L9ZYctM2NH
         LLCw==
X-Forwarded-Encrypted: i=1; AJvYcCUzt+yk97ZzlJVqDNE2+BfYuIGFoYnunWB2OA4GXXUI4DHiYrIYu5CiImuKzxo5NSDMxyFMfy++i8dPXZpzp86DyGQdqppM9H7DTlhPAMQ+KcCg/EFE4Q3OjxAm5+vrLykcQvgc
X-Gm-Message-State: AOJu0YyTtC+wsfNjjIyHCqgdfUrvevVBiGmlGIanNepY23lFLMZo5ucp
	Fgneqp6YF2Ff9h7x7R8cd9WhoIyckC057ka8EjrKTNlgEgqtykRJfNnHX9NQ+w7+c9Vm9JqbFBQ
	FNmMEu1PG4YaS35u9FTjSl3Ii+zwI6ReK
X-Google-Smtp-Source: AGHT+IHyfeVOFnNjAZlWNZW5IgjcIak0nSqY1PbLswws8Vpau308enwVu85wB509FQHD23lMTExJg8AP/yearQWWSHY=
X-Received: by 2002:a05:6000:2a2:b0:364:3ba5:c5af with SMTP id
 ffacd0b85a97d-369bb336d3bmr3622830f8f.61.1721584737268; Sun, 21 Jul 2024
 10:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719093338.55117-1-linyunsheng@huawei.com> <20240719093338.55117-3-linyunsheng@huawei.com>
In-Reply-To: <20240719093338.55117-3-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 Jul 2024 10:58:21 -0700
Message-ID: <CAKgT0UdHrEzXwceS-5m1Hc1dV9r_XiPjSSc=_vWCUu0C5pfE4w@mail.gmail.com>
Subject: Re: [RFC v11 02/14] mm: move the page fragment allocator from
 page_alloc into its own file
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:37=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Inspired by [1], move the page fragment allocator from page_alloc
> into its own c file and header file, as we are about to make more
> change for it to replace another page_frag implementation in
> sock.c
>
> As this patchset is going to replace 'struct page_frag' with
> 'struct page_frag_cache' in sched.h, including page_frag_cache.h
> in sched.h has a compiler error caused by interdependence between
> mm_types.h and mm.h for asm-offsets.c, see [2]. So avoid the compiler
> error by moving 'struct page_frag_cache' to mm_types_task.h as
> suggested by Alexander, see [3].
>
> 1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.c=
om/
> 2. https://lore.kernel.org/all/15623dac-9358-4597-b3ee-3694a5956920@gmail=
.com/
> 3. https://lore.kernel.org/all/CAKgT0UdH1yD=3DLSCXFJ=3DYM_aiA4OomD-2wXykO=
42bizaWMt_HOA@mail.gmail.com/
> CC: David Howells <dhowells@redhat.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/gfp.h             |  22 -----
>  include/linux/mm_types.h        |  18 ----
>  include/linux/mm_types_task.h   |  18 ++++
>  include/linux/page_frag_cache.h |  32 +++++++
>  include/linux/skbuff.h          |   1 +
>  mm/Makefile                     |   1 +
>  mm/page_alloc.c                 | 136 ------------------------------
>  mm/page_frag_cache.c            | 145 ++++++++++++++++++++++++++++++++
>  mm/page_frag_test.c             |   2 +-
>  9 files changed, 198 insertions(+), 177 deletions(-)
>  create mode 100644 include/linux/page_frag_cache.h
>  create mode 100644 mm/page_frag_cache.c
>

...

> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index a2f6179b672b..cdc1e3696439 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -8,6 +8,7 @@
>   * (These are defined separately to decouple sched.h from mm_types.h as =
much as possible.)
>   */
>
> +#include <linux/align.h>
>  #include <linux/types.h>
>
>  #include <asm/page.h>
> @@ -46,6 +47,23 @@ struct page_frag {
>  #endif
>  };
>
> +#define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
> +#define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
> +struct page_frag_cache {
> +       void *va;
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +       __u16 offset;
> +       __u16 size;
> +#else
> +       __u32 offset;
> +#endif
> +       /* we maintain a pagecount bias, so that we dont dirty cache line
> +        * containing page->_refcount every time we allocate a fragment.
> +        */
> +       unsigned int            pagecnt_bias;
> +       bool pfmemalloc;
> +};
> +
>  /* Track pages that require TLB flushes */
>  struct tlbflush_unmap_batch {
>  #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> new file mode 100644
> index 000000000000..43afb1bbcac9
> --- /dev/null
> +++ b/include/linux/page_frag_cache.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_PAGE_FRAG_CACHE_H
> +#define _LINUX_PAGE_FRAG_CACHE_H
> +
> +#include <linux/log2.h>
> +#include <linux/types.h>
> +#include <linux/mm_types_task.h>

You don't need to include mm_types_task.h here. You can just use
declare "struct page_frag_cache;" as we did before in gfp.h.
Technically this should be included in mm_types.h so any callers
making use of these functions would need to make sure to include that
like we did for gfp.h before anyway.

> +#include <asm/page.h>
> +

Not sure why this is included here either. From what I can tell there
isn't anything here using the contents of page.h. I suspect you should
only need it for the get_order call which would be used in other
files.

> +void page_frag_cache_drain(struct page_frag_cache *nc);
> +void __page_frag_cache_drain(struct page *page, unsigned int count);
> +void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int f=
ragsz,
> +                             gfp_t gfp_mask, unsigned int align_mask);
> +
> +static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
> +                                         unsigned int fragsz, gfp_t gfp_=
mask,
> +                                         unsigned int align)
> +{
> +       WARN_ON_ONCE(!is_power_of_2(align));
> +       return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
> +}
> +
> +static inline void *page_frag_alloc(struct page_frag_cache *nc,
> +                                   unsigned int fragsz, gfp_t gfp_mask)
> +{
> +       return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
> +}
> +
> +void page_frag_free(void *addr);
> +
> +#endif

...

> diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c
> index cf2691f60b67..b7a5affb92f2 100644
> --- a/mm/page_frag_test.c
> +++ b/mm/page_frag_test.c
> @@ -6,7 +6,6 @@
>   * Copyright: linyunsheng@huawei.com
>   */
>
> -#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> @@ -16,6 +15,7 @@
>  #include <linux/log2.h>
>  #include <linux/completion.h>
>  #include <linux/kthread.h>
> +#include <linux/page_frag_cache.h>
>
>  #define OBJPOOL_NR_OBJECT_MAX  BIT(24)

Rather than making users have to include page_frag_cache.h I think it
would be better for us to just maintain the code as being accessible
from mm.h. So it might be better to just add page_frag_cache.h to the
includes there.

