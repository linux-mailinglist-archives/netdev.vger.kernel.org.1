Return-Path: <netdev+bounces-107904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E191CE4F
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C776B21579
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4C81720;
	Sat, 29 Jun 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVB4FFGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A9132101;
	Sat, 29 Jun 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682704; cv=none; b=cXFlOogWhjLmj9OJT+7VGqLgxXQSXF/dCO/8cz43S/qntac4s0A70eWAG+b8FqbHlRoL1r+x8hcfNv3gXNT+op9lQSqWtbU5m4AvrnoXlU5GZRsQxtv6nO5m4Vr6rXrLqj3NuBUMp7oFIfjW2THJffyXlP84IQGxvcTXugZLSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682704; c=relaxed/simple;
	bh=o94cM3T/cGcDU6sUbN+h7zzTJ/Cs9FyldfXPbQXrvbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoANLiiL2PwRveUYnOJdOjyi8WTIYGLQ9fBIli7STfVktwZYF/vokNLtJhDNCGxZcpZrkLpEbNR6eN0l2Am7r3ZJIsJ3lHfcRmHGxYmoVQnvCpy9gaYhttHYn1g3fLPqQqSiwNONeb6fcu/8SP968b1WThMFxK/tSMbV15n5ZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVB4FFGY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42564316479so10789625e9.2;
        Sat, 29 Jun 2024 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719682700; x=1720287500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zhHRLj3j1cSIdzwblrg0PYdMtiKz5IrX7f7JfITYcc=;
        b=TVB4FFGY86l2WMe/dVO9ZDzX2MKQ6P9e4MzP+mSol5VbpV5n4gcSxqjPlKWBdoeGWA
         xGJu7uCO7KlLgDZVWYepMuJmyOxuxSGCsxGzxxtEfRZ87w0hjomS7QALkUhmqut8+bsQ
         /wA1DNjhF7PXvacObmrP20Ii0T5AR56sHkHjZHd1Fg3byiiJ/NXomhI27Xt/PcUqUsyD
         BvZcILn0LdjiveNOaDmZbmOZYJ/chWfnN0cG8DRJPfRo9jHz7iMcy0hsOK6vESddymGM
         eJrEYDgUVSyrO6gIJCiIrTPvtFnfGzm8BzdkJ5xjGoSgGg1SrmR6JVafvRZ8NwJLcR2A
         WPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719682700; x=1720287500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zhHRLj3j1cSIdzwblrg0PYdMtiKz5IrX7f7JfITYcc=;
        b=fhZ1O3CJ8ETEQgs/VPevbKf3nxuthRm367JrDi85IcuO6ZchfnpSqi6mC2eovVBKXf
         wS4lEgFwA87Lq3MNNuX9BRbbI6QM2bQhL/onyRceHxC/AReePoGqTmYKq2VPdz8N0Y28
         CgdDmWWr22z2tQAdR8RC0sbU2S2cRX1eHIc2l9wtYKkWpd8i+dYnDts8kAreNf8eJjBG
         yoD45XSTpOBvuN2bNI7F3qoIJCQhxpzmjo774+76nT+voLNBDYghXKe9wx1126on5v7m
         Pn2GN4Kc2iHRI3dzpKSFWSpVUoWgOjHZA5BKHu77n0jgYt/rdT7LW5u5SM9BmrawwN10
         2bPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFsGtnsAWotZz3BS+n63CIjBHZASh7f/JzZSxmzSWLaCYIC+xxb95BMj7BjJtSg/oRdluwTt/zC5cJyQVUhiCfOt5QPQw1+A7UQZ1ck6BiC2ChBmBhA7H22PcUWLmyyARRXFIl
X-Gm-Message-State: AOJu0YxmIscN+K0e6bGiJZAOX+xJsdFBlTnW4gOObCHqdguHWf4o6bzo
	varZCPRB5ZknnNfBwnRZPbF0RjSKYtMh/QhEqzTCGJD13puqcAvCtmEJ/z42Nm1lvogDIIAUgs6
	4pXkyXF2SP61FC0/BNZ3S7j37uU8=
X-Google-Smtp-Source: AGHT+IH6MwOruFrrnck6lTQwGix6wuCeMGq8hKMDdGXoRm6SbfYwGwoBAjleU8Ocbjki/4mRJRJ5uLFqDctz4OWAwms=
X-Received: by 2002:a5d:4905:0:b0:367:3417:a4bb with SMTP id
 ffacd0b85a97d-367757297d0mr778616f8f.63.1719682700237; Sat, 29 Jun 2024
 10:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com> <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com>
In-Reply-To: <38da183b-92ba-ce9d-5472-def199854563@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 29 Jun 2024 10:37:43 -0700
Message-ID: <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 4:15=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/6/29 6:35, Alexander H Duyck wrote:
> > On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
> >> There are many use cases that need minimum memory in order
> >> for forward progress, but more performant if more memory is
> >> available or need to probe the cache info to use any memory
> >> available for frag caoleasing reason.
> >>
> >> Currently skb_page_frag_refill() API is used to solve the
> >> above use cases, but caller needs to know about the internal
> >> detail and access the data field of 'struct page_frag' to
> >> meet the requirement of the above use cases and its
> >> implementation is similar to the one in mm subsystem.
> >>
> >> To unify those two page_frag implementations, introduce a
> >> prepare API to ensure minimum memory is satisfied and return
> >> how much the actual memory is available to the caller and a
> >> probe API to report the current available memory to caller
> >> without doing cache refilling. The caller needs to either call
> >> the commit API to report how much memory it actually uses, or
> >> not do so if deciding to not use any memory.
> >>
> >> As next patch is about to replace 'struct page_frag' with
> >> 'struct page_frag_cache' in linux/sched.h, which is included
> >> by the asm-offsets.s, using the virt_to_page() in the inline
> >> helper of page_frag_cache.h cause a "'vmemmap' undeclared"
> >> compiling error for asm-offsets.s, use a macro for probe API
> >> to avoid that compiling error.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  include/linux/page_frag_cache.h |  82 +++++++++++++++++++++++
> >>  mm/page_frag_cache.c            | 114 +++++++++++++++++++++++++++++++=
+
> >>  2 files changed, 196 insertions(+)
> >>
> >> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag=
_cache.h
> >> index b33904d4494f..e95d44a36ec9 100644
> >> --- a/include/linux/page_frag_cache.h
> >> +++ b/include/linux/page_frag_cache.h
> >> @@ -4,6 +4,7 @@
> >>  #define _LINUX_PAGE_FRAG_CACHE_H
> >>
> >>  #include <linux/gfp_types.h>
> >> +#include <linux/mmdebug.h>
> >>
> >>  #define PAGE_FRAG_CACHE_MAX_SIZE    __ALIGN_MASK(32768, ~PAGE_MASK)
> >>  #define PAGE_FRAG_CACHE_MAX_ORDER   get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
> >> @@ -87,6 +88,9 @@ static inline unsigned int page_frag_cache_page_size=
(struct encoded_va *encoded_
> >>
> >>  void page_frag_cache_drain(struct page_frag_cache *nc);
> >>  void __page_frag_cache_drain(struct page *page, unsigned int count);
> >> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
> >> +                            unsigned int *offset, unsigned int fragsz=
,
> >> +                            gfp_t gfp);
> >>  void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
> >>                               unsigned int fragsz, gfp_t gfp_mask,
> >>                               unsigned int align_mask);
> >> @@ -99,12 +103,90 @@ static inline void *page_frag_alloc_va_align(stru=
ct page_frag_cache *nc,
> >>      return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
> >>  }
> >>
> >> +static inline unsigned int page_frag_cache_page_offset(const struct p=
age_frag_cache *nc)
> >> +{
> >> +    return page_frag_cache_page_size(nc->encoded_va) - nc->remaining;
> >> +}
> >> +
> >>  static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
> >>                                     unsigned int fragsz, gfp_t gfp_mas=
k)
> >>  {
> >>      return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, ~0u);
> >>  }
> >>
> >> +void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned=
 int *fragsz,
> >> +                             gfp_t gfp);
> >> +
> >> +static inline void *page_frag_alloc_va_prepare_align(struct page_frag=
_cache *nc,
> >> +                                                 unsigned int *fragsz=
,
> >> +                                                 gfp_t gfp,
> >> +                                                 unsigned int align)
> >> +{
> >> +    WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
> >> +    nc->remaining =3D nc->remaining & -align;
> >> +    return page_frag_alloc_va_prepare(nc, fragsz, gfp);
> >> +}
> >> +
> >> +struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
> >> +                                    unsigned int *offset,
> >> +                                    unsigned int *fragsz, gfp_t gfp);
> >> +
> >> +struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
> >> +                                 unsigned int *offset,
> >> +                                 unsigned int *fragsz,
> >> +                                 void **va, gfp_t gfp);
> >> +
> >> +static inline struct encoded_va *__page_frag_alloc_probe(struct page_=
frag_cache *nc,
> >> +                                                     unsigned int *of=
fset,
> >> +                                                     unsigned int *fr=
agsz,
> >> +                                                     void **va)
> >> +{
> >> +    struct encoded_va *encoded_va;
> >> +
> >> +    *fragsz =3D nc->remaining;
> >> +    encoded_va =3D nc->encoded_va;
> >> +    *offset =3D page_frag_cache_page_size(encoded_va) - *fragsz;
> >> +    *va =3D encoded_page_address(encoded_va) + *offset;
> >> +
> >> +    return encoded_va;
> >> +}
> >> +
> >> +#define page_frag_alloc_probe(nc, offset, fragsz, va)                =
       \
> >> +({                                                                  \
> >> +    struct page *__page =3D NULL;                                    =
 \
> >> +                                                                    \
> >> +    VM_BUG_ON(!*(fragsz));                                          \
> >> +    if (likely((nc)->remaining >=3D *(fragsz)))                      =
 \
> >> +            __page =3D virt_to_page(__page_frag_alloc_probe(nc,      =
 \
> >> +                                                          offset,   \
> >> +                                                          fragsz,   \
> >> +                                                          va));     \
> >> +                                                                    \
> >> +    __page;                                                         \
> >> +})
> >> +
> >
> > Why is this a macro instead of just being an inline? Are you trying to
> > avoid having to include a header due to the virt_to_page?
>
> Yes, you are right.
> I tried including different headers for virt_to_page(), and it did not
> work for arch/x86/kernel/asm-offsets.s, which has included linux/sched.h,
> and linux/sched.h need 'struct page_frag_cache' for 'struct task_struct'
> after this patchset, including page_frag_cache.h for sched.h causes the
> below compiler error:
>
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from ./arch/x86/include/asm/page.h:89,
>                  from ./arch/x86/include/asm/thread_info.h:12,
>                  from ./include/linux/thread_info.h:60,
>                  from ./include/linux/spinlock.h:60,
>                  from ./include/linux/swait.h:7,
>                  from ./include/linux/completion.h:12,
>                  from ./include/linux/crypto.h:15,
>                  from arch/x86/kernel/asm-offsets.c:9:
> ./include/linux/page_frag_cache.h: In function =E2=80=98page_frag_alloc_a=
lign=E2=80=99:
> ./include/asm-generic/memory_model.h:37:34: error: =E2=80=98vmemmap=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98mem_map=
=E2=80=99?
>    37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:65:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    65 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/x86/include/asm/page.h:68:33: note: in expansion of macro =E2=80=
=98pfn_to_page=E2=80=99
>    68 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_S=
HIFT)
>       |                                 ^~~~~~~~~~~
> ./include/linux/page_frag_cache.h:151:16: note: in expansion of macro =E2=
=80=98virt_to_page=E2=80=99
>   151 |         return virt_to_page(va);
>       |                ^~~~~~~~~~~~
> ./include/asm-generic/memory_model.h:37:34: note: each undeclared identif=
ier is reported only once for each function it appears in
>    37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:65:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    65 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/x86/include/asm/page.h:68:33: note: in expansion of macro =E2=80=
=98pfn_to_page=E2=80=99
>    68 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_S=
HIFT)
>       |                                 ^~~~~~~~~~~
> ./include/linux/page_frag_cache.h:151:16: note: in expansion of macro =E2=
=80=98virt_to_page=E2=80=99
>   151 |         return virt_to_page(va);
>
>

I am pretty sure you just need to add:
#include <asm/page.h>

