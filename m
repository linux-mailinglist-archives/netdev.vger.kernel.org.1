Return-Path: <netdev+bounces-132508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A04B991F8A
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5982428187A
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C59189910;
	Sun,  6 Oct 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGprtw1B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491851F94A;
	Sun,  6 Oct 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728230890; cv=none; b=ZRwRdk5uM8RfdnJg3UVRadu3vew867KN/zWQY7WAVGtH8ukQeDEZn/67LIAS1YD7R/JDve/3E5iwvGyJTuhnn+SniR5QnLny2tJyLQ4MyN3k680/XmSXtGyrH+c51B8lTXzHgl4Ep5vRtlu/2yvF8VJxR1xhYjWfjW00MafpJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728230890; c=relaxed/simple;
	bh=Lreic1iRPX++5eE3HdN/f59iIdJMOcSa52+YiZtKLb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeQietrSwHP4Q1ffe6Xo+PPHe7r62iUvtmt/HrkNwbiSKLJxFsk5jDKfQvsxYrw4jHBbcxhccNyX4FcxJZjukjOW32kF4ln/REIhqC/DL3S3W1IGuoaFJy+yZCaYguy2RADoTYFhdSX9fxj76rujd576BEld6c+qT4lp2m7cx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGprtw1B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso35870765e9.2;
        Sun, 06 Oct 2024 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728230886; x=1728835686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsNcMiZIDNLMekYvfzBCcKUfltxAAz74Dl2YC6o5gfY=;
        b=TGprtw1BJBrCaNlIkGPFk+uxnENmdtJAm2eZUeYuknegNIBiMtIVZZeVjZIPbtF/Jr
         DMuS+Ugn/TD0VTCQpH00VFe4EU2Jv/fxMEhDwUZ7JBrnRuxnoWZo5/62k0Tk+whdxhSa
         vFXFLcay8sMOo19JhvXUMo0mzAsed/+TDeC3naFe8Xq8TiHnb0PxZO0RGtj7zX3NBdmW
         1pmGD/f6iAgGNb+Q4A2gKIo7TBPeeVJjOyEI/OraPDfnmIhSLUnfQ6+AXrfbl5XVQ2A/
         kjjs1qgzOkK2lb+klI+3JwQeL4kWAJ9mSeZiXXj1ct8tj4FNmm83N09RGPdEAKwYChIS
         gTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728230886; x=1728835686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsNcMiZIDNLMekYvfzBCcKUfltxAAz74Dl2YC6o5gfY=;
        b=wIUZy1xc0yKkuponHbetAFA0ToHnjT3qzda0to/4z7joD+aY3gfrJA8PhCWonaAuoA
         EaSIz1q4FP6dFdnxBbVJf+vDp4US60nLeRTBaQEnav2HsKsZkkfZPmn6R99aW7N9iawp
         g0cNZmg7cZWhTxAfXetjXmDd5dFlYIcLW4Z8Vecs/Nmc+SZSZskOxbBf0Q5k4M2zSB2I
         yucbasWkdfRktcNsSlhARcEhUtU4e5z1UXf7oSZvO+KR9nQAhTZyZBBcmV+jVvTHABEO
         +oo75OFc9zKNrbit05H70FtgeZs/x9HjXa/7aRMwZXqwcIhkyvwFQaozD/fx1C01ZLWp
         Vp0A==
X-Forwarded-Encrypted: i=1; AJvYcCWeZynFDB1T0zZ9hhtgiSoYL8gji78s5MrnHWSz7VBW6JnVNVb65tuiXmI/fu/kPsIvXa+sGgvnw3VcYM0=@vger.kernel.org, AJvYcCXhNMELyMatSBMoCqeCiEhGJZvIduIKEXXN/bE6O6GY4vEUWML65x1D9vFcRgeRshJDR1oEv5/n@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyIbWXPUIT6p37EbIagLMMys9yf82TZ3uAlLph7U5vhECmbXU
	16wT1itnsk1PbhyTKEy3EiccatUqu/TLGR8/61uFpV241f6zAFszglFy6stxSLMuKKK8ejh6ocp
	6b/CsHi+o/vxs2OPhEbruesvMlK7m3A==
X-Google-Smtp-Source: AGHT+IGOQ41gh4KuGUucHi4/IGlmrEKzSxSXLKsTklVro8WF8T4vcbtIwVd0LSIMqfiDV2eDxJ2FnO9Uy0WyBPbNGn0=
X-Received: by 2002:a05:600c:35c9:b0:42c:bb41:a079 with SMTP id
 5b1f17b1804b1-42f85a70035mr75631645e9.1.1728230886201; Sun, 06 Oct 2024
 09:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001075858.48936-1-linyunsheng@huawei.com>
 <20241001075858.48936-7-linyunsheng@huawei.com> <CAKgT0UdMwDyf9u6sQVjsJuxpWmKNi3RYkB7UOSvH6QxXvG7_zQ@mail.gmail.com>
 <a6091b22-29a8-4691-99c4-72cbd4318938@gmail.com>
In-Reply-To: <a6091b22-29a8-4691-99c4-72cbd4318938@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 6 Oct 2024 09:07:29 -0700
Message-ID: <CAKgT0UeC8m8LATjJtZS7pcgsqKj3WUygtcrzMNoBh-VkS11q8A@mail.gmail.com>
Subject: Re: [PATCH net-next v19 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yunsheng Lin <linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 6:06=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail.=
com> wrote:
>
> On 10/4/2024 6:40 AM, Alexander Duyck wrote:
> > On Tue, Oct 1, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <yunshenglin0825@g=
mail.com> wrote:
> >>
> >> Currently there is one 'struct page_frag' for every 'struct
> >> sock' and 'struct task_struct', we are about to replace the
> >> 'struct page_frag' with 'struct page_frag_cache' for them.
> >> Before begin the replacing, we need to ensure the size of
> >> 'struct page_frag_cache' is not bigger than the size of
> >> 'struct page_frag', as there may be tens of thousands of
> >> 'struct sock' and 'struct task_struct' instances in the
> >> system.
> >>
> >> By or'ing the page order & pfmemalloc with lower bits of
> >> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> >> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> >> And page address & pfmemalloc & order is unchanged for the
> >> same page in the same 'page_frag_cache' instance, it makes
> >> sense to fit them together.
> >>
> >> After this patch, the size of 'struct page_frag_cache' should be
> >> the same as the size of 'struct page_frag'.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>   include/linux/mm_types_task.h   | 19 +++++----
> >>   include/linux/page_frag_cache.h | 26 +++++++++++-
> >>   mm/page_frag_cache.c            | 75 +++++++++++++++++++++++--------=
--
> >>   3 files changed, 88 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_ta=
sk.h
> >> index 0ac6daebdd5c..a82aa80c0ba4 100644
> >> --- a/include/linux/mm_types_task.h
> >> +++ b/include/linux/mm_types_task.h
> >> @@ -47,18 +47,21 @@ struct page_frag {
> >>   #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MAS=
K)
> >>   #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX=
_SIZE)
> >>   struct page_frag_cache {
> >> -       void *va;
> >> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> +       /* encoded_page consists of the virtual address, pfmemalloc bi=
t and
> >> +        * order of a page.
> >> +        */
> >> +       unsigned long encoded_page;
> >> +
> >> +       /* we maintain a pagecount bias, so that we dont dirty cache l=
ine
> >> +        * containing page->_refcount every time we allocate a fragmen=
t.
> >> +        */
> >> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
> >>          __u16 offset;
> >> -       __u16 size;
> >> +       __u16 pagecnt_bias;
> >>   #else
> >>          __u32 offset;
> >> +       __u32 pagecnt_bias;
> >>   #endif
> >> -       /* we maintain a pagecount bias, so that we dont dirty cache l=
ine
> >> -        * containing page->_refcount every time we allocate a fragmen=
t.
> >> -        */
> >> -       unsigned int            pagecnt_bias;
> >> -       bool pfmemalloc;
> >>   };
> >>
> >>   /* Track pages that require TLB flushes */
> >> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag=
_cache.h
> >> index 0a52f7a179c8..75aaad6eaea2 100644
> >> --- a/include/linux/page_frag_cache.h
> >> +++ b/include/linux/page_frag_cache.h
> >> @@ -3,18 +3,40 @@
> >>   #ifndef _LINUX_PAGE_FRAG_CACHE_H
> >>   #define _LINUX_PAGE_FRAG_CACHE_H
> >>
> >> +#include <linux/bits.h>
> >>   #include <linux/log2.h>
> >>   #include <linux/mm_types_task.h>
> >>   #include <linux/types.h>
> >>
> >> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> +/* Use a full byte here to enable assembler optimization as the shift
> >> + * operation is usually expecting a byte.
> >> + */
> >> +#define PAGE_FRAG_CACHE_ORDER_MASK             GENMASK(7, 0)
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       8
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PF=
MEMALLOC_SHIFT)
> >> +#else
> >> +/* Compiler should be able to figure out we don't read things as any =
value
> >> + * ANDed with 0 is 0.
> >> + */
> >> +#define PAGE_FRAG_CACHE_ORDER_MASK             0
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       0
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PF=
MEMALLOC_SHIFT)
> >> +#endif
> >> +
> >
> > Minor nit on this. You probably only need to have
> > PAGE_FRAG_CACHE_ORDER_SHIFT defined in the ifdef. The PFMEMALLOC bit
>
> I guess you meant PAGE_FRAG_CACHE_ORDER_MASK here instead of
> PAGE_FRAG_CACHE_ORDER_SHIFT, as the ORDER_SHIFT is always
> zero?

Yes.

> > code is the same in both so you could pull it out.
> >
> > Also depending on how you defined it you could just define the
> > PFMEMALLOC_BIT as the ORDER_MASK + 1.
>
> But the PFMEMALLOC_SHIFT still need to be defined as it is used in
> page_frag_encode_page(), right? I am not sure if I understand what is
> the point of defining the PFMEMALLOC_BIT as the ORDER_MASK + 1 instead
> of defining the PFMEMALLOC_BIT as BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
> here.

Actually the shift probably isn't needed. Since it is a single bit
value you could just use a multiply by the bit and it would accomplish
the same thing as the shift and would likely be converted to the same
assembler code.

