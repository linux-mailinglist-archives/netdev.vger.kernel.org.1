Return-Path: <netdev+bounces-111584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F19319E0
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475FF1C219F8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CC54918;
	Mon, 15 Jul 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRMRGJ1I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D254670;
	Mon, 15 Jul 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066181; cv=none; b=M70k6WFnrrw5tokeQVU+sKBngDdfMvM1aphq5kKX/aMamZF8sAEROLbmhm4LG7QMZ+LAhU+hioav5YaW/bEbj0WWRvSAcKR6qR9o/Czw4EFubUtzoYNC6ZWB+yEUW7lGkmE01vXPio0jpTvLNL4nJSVFmZc66DDR5Opz8MU7raM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066181; c=relaxed/simple;
	bh=BxGAdGTiJgz8Q5D2uHQ78tpjZdOMaIkZr5f589j4CL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCC4B5gj1EBa/UZWeBthCUolrFNoacJTaJ62XtHhhPv2J9H7jJnK4HDZB8cYjs9f9VYbGiAfebacKpeRrQrRiWr+yJxIgmIPXF+DaXtm51h+72B+gpP3j+FYp93wDRa0HPAjRmo9giUmt07RdKqCBozhb0bgioxIPELEoJYm3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRMRGJ1I; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so31909775e9.2;
        Mon, 15 Jul 2024 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721066178; x=1721670978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W0anjTUFyhsTzhkYxeiTEp5MjzFJ0+hG8HP5QZjcBU=;
        b=kRMRGJ1IM+agNKLWItmr0z0JV/CVgL7R1uCKrbVogG8icNpj3qoQFq508ctKVNrWnn
         G4qQOPSPOCZInulK1ZHNulRl4LI4tOz5deAxdnvpybsD+Gb/WRr9JRM8M50rkLXkH7ub
         IzDNL40RrkcCTHrCi1ebZ6WUk8FLyWjfQr3cqiqMlwovdZU/WZKoXUwrusiybRtGnvze
         zPVFEIJ7yzFaFkEU60YL3on67Fd97KYvdH5F9LsT7BAaliPB/AV2zahFXPVKEPN/znz9
         F8533pU20BQ31JvOIQyI41Ndg92zM9Ny8eqPTmaIhL1Xzybrm3vIH3RKaF18vOoARk+f
         mhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066178; x=1721670978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W0anjTUFyhsTzhkYxeiTEp5MjzFJ0+hG8HP5QZjcBU=;
        b=wdTs/MxktGA6Sgepi+HfrBlW8IhzYt2DqfY0eEOK9WIpD7KNLlDxQlJkURF7kqAHoR
         jDP66A6SACQT0krmnH15irHIXEhQbFcd/x2nUOTgseqsqPMhzIOort8Q4aw5b0rTGr0N
         lPI0kpxPWB6CMgVmHaRb1mRgZaIX/fzggJgkoY4rRkAWgxgrgCCIYopF77hraIQHgukT
         vW5YSVWRhB5pZQu17qBPRZKA7FL4X3fGJ5oO4jW2l2qvHVBc09ZbZnqnUhjusRU4ZEBs
         wn8Q6S725AF3978KvWIElnttuYw2ssBGGg5oJ/keQ9osM1RL4Cm3Pt/Ixif1m1gNUZW5
         kIAA==
X-Forwarded-Encrypted: i=1; AJvYcCXXDgrMxsRNrIdEnEpqs3wekrVPTOnMIEu5YnuUym1tOKr1DSC5XLRF4IyTpA3fac3XxaBe4ERsWa7mMKZwFyJ8WXubDa2VD22IoVSZr2UDdrm10cES45BzW3RpFyjh8KKWUPJ9
X-Gm-Message-State: AOJu0YypxGD6I138GE1Bl5sHmSnDdiCEFhAeAIQVNUteKpsTRMsxiehA
	WRJRk0cBt6Ka7CsSCmMJfF4voLXffXNk56K1iggGV+4iDW7ECsylxn3RZpG1gDTN5gMITKq2WBO
	6+R150Tpd2j+EFtuySy7kq/p8f1Uh9w==
X-Google-Smtp-Source: AGHT+IFk6VNFCK/xpbOPqFvPPxvE/7ruwrAkwWPKtUxFlAOsZs2IddEppQ2kmqqdXUJPhQwn2bActSLmPnZWrlu9U2Y=
X-Received: by 2002:adf:f707:0:b0:367:988d:fb99 with SMTP id
 ffacd0b85a97d-3682407cfe9mr347686f8f.8.1721066178313; Mon, 15 Jul 2024
 10:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com> <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com> <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com> <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
 <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com> <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
 <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com> <CAKgT0UdSjmJoaQvTOz3STjBi2PazQ=piWY5wqFsYFBFLcPrLjQ@mail.gmail.com>
 <29e8ac53-f7da-4896-8121-2abc25ec2c95@gmail.com> <CAKgT0Udmr8q8V7x6ZqHQVxFbCnwB-6Ttybx_PP_3Xr9X-DgjKA@mail.gmail.com>
 <12ff13d9-1f3d-4c1b-a972-2efb6f247e31@gmail.com>
In-Reply-To: <12ff13d9-1f3d-4c1b-a972-2efb6f247e31@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 Jul 2024 10:55:42 -0700
Message-ID: <CAKgT0Uea-BrGRy-gfjdLWxp=0aQKQZa3dZW4euq5oGr1pTQVAA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 9:52=E2=80=AFPM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> On 7/14/2024 12:55 AM, Alexander Duyck wrote:
>
> ...
>
> >>>>
> >>>> Perhaps the 'remaining' changing in this patch does seems to make th=
ings
> >>>> harder to discuss. Anyway, it would be more helpful if there is some=
 pseudo
> >>>> code to show the steps of how the above can be done in your mind.
> >>>
> >>> Basically what you would really need do for all this is:
> >>>     remaining =3D __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
> >>>     nc->remaining =3D remaining + fragsz;
> >>>     return encoded_page_address(nc->encoded_va) + size + remaining;
> >>
> >
> > I might have mixed my explanation up a bit. This is assuming remaining
> > is a negative value as I mentioned before.
>
> Let's be more specific about the options here, what you meant is below,
> right? Let's say it is option 1 as below:
> struct page_frag_cache {
>          /* encoded_va consists of the virtual address, pfmemalloc bit
> and order
>           * of a page.
>           */
>          unsigned long encoded_va;
>
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>          __s16 remaining;
>          __u16 pagecnt_bias;
> #else
>          __s32 remaining;
>          __u32 pagecnt_bias;
> #endif
> };
>
> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>                                   unsigned int fragsz, gfp_t gfp_mask,
>                                   unsigned int align_mask)
> {
>          unsigned int size =3D page_frag_cache_page_size(nc->encoded_va);
>          int remaining;
>
>          remaining =3D __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
>          if (unlikely(remaining + (int)fragsz > 0)) {
>                  if (!__page_frag_cache_refill(nc, gfp_mask))
>                          return NULL;
>
>                  size =3D page_frag_cache_page_size(nc->encoded_va);
>
>                  remaining =3D -size;
>                  if (unlikely(remaining + (int)fragsz > 0))
>                          return NULL;
>          }
>
>          nc->pagecnt_bias--;
>          nc->remaining =3D remaining + fragsz;
>
>          return encoded_page_address(nc->encoded_va) + size + remaining;
> }
>
>
> And let's say what I am proposing in v10 is option 2 as below:
> struct page_frag_cache {
>          /* encoded_va consists of the virtual address, pfmemalloc bit
> and order
>           * of a page.
>           */
>          unsigned long encoded_va;
>
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>          __u16 remaining;
>          __u16 pagecnt_bias;
> #else
>          __u32 remaining;
>          __u32 pagecnt_bias;
> #endif
> };
>
> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>                                   unsigned int fragsz, gfp_t gfp_mask,
>                                   unsigned int align_mask)
> {
>          unsigned int size =3D page_frag_cache_page_size(nc->encoded_va);
>          int aligned_remaining =3D nc->remaining & align_mask;
>          int remaining =3D aligned_remaining - fragsz;
>
>          if (unlikely(remaining < 0)) {
>                  if (!__page_frag_cache_refill(nc, gfp_mask))
>                          return NULL;
>
>                  size =3D page_frag_cache_page_size(nc->encoded_va);
>
>                  aligned_remaining =3D size;
>                  remaining =3D aligned_remaining - fragsz;
>                  if (unlikely(remaining < 0))
>                          return NULL;
>          }
>
>          nc->pagecnt_bias--;
>          nc->remaining =3D remaining;
>
>          return encoded_page_address(nc->encoded_va) + (size -
> aligned_remaining);
> }
>
> If the option 1 is not what you have in mind, it would be better to be
> more specific about what you have in mind.

Option 1 was more or less what I had in mind.

> If the option 1 is what you have in mind, it seems both option 1 and
> option 2 have the same semantics as my understanding, right? The
> question here seems to be what is your perfer option and why?
>
> I implemented both of them, and the option 1 seems to have a
> bigger generated asm size as below:
> ./scripts/bloat-o-meter vmlinux_non_neg vmlinux
> add/remove: 0/0 grow/shrink: 1/0 up/down: 37/0 (37)
> Function                                     old     new   delta
> __page_frag_alloc_va_align                   414     451     +37

My big complaint is that it seems option 2 is harder for people to
understand and more likely to not be done correctly. In some cases if
the performance difference is negligible it is better to go with the
more maintainable solution.

