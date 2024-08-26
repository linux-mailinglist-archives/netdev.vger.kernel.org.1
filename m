Return-Path: <netdev+bounces-121974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957D95F703
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E52811A5
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284D0194096;
	Mon, 26 Aug 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2jGjECB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396285476B;
	Mon, 26 Aug 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690850; cv=none; b=R/6UonFS4UZxs+WAFyjJJNeju4UKnwqc9Q4THAADXa0s5L0/DDImJ/o19EpI9PiCmGWI8uMY1pXGZY6eIo3dBCD6FgMNTzCSyqvTSQTKXOkWdseJAO6MdT1WT5sUCdSWa9o1A53wHuMEVhzU7fuOfnE/3uo86T1u9rj+NAbeYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690850; c=relaxed/simple;
	bh=izioCexJK48o9UQtYxFI+H76BnTEAKguOiGppcefk/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0j009blY36VuQJno3Gb+Vc6laWL787MQK580ES5uJHBmlleqzlX7hxaho/Kl23T3HBTWIDrQrLWCOnhkO6LKf12viUDYUX2zzvE00tafybmmvtMPXgRw4hFNaIp3M27nhlftLXICZ2ARblIW4gS/Q6zaDf25FgNmuNMdhCQPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2jGjECB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42819654737so39205975e9.1;
        Mon, 26 Aug 2024 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690846; x=1725295646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szx7H5nibeV9OXvQnlfmFvfwbgNiPLWHXneUeuVFRCE=;
        b=H2jGjECBgsOEBRR7nmyteneTWnfn8vtit2r/p0ssyDTPPjxl0imrUUZ2Nm+Tnq5tdg
         r0R3b8oJj8DW8MHgL34+tR/oUIt+fqEC+0o+FnGXZ9mraZieuPWfNUEBnfzY3amHgnkf
         Z52uwarLY5rE66sbM2HZHOVwfwfmrBjiB/+inh3fPDGqewySlUKy+RbddMPLWiKDyGko
         vnK1k+6sUr6m81bux7JUv+IZ/CRot9NmRa2cyIxln3AYfY3l1kk0CaRs7gVg/MB67OPJ
         0g9dZ/nM6UA+lzj5EgrMs05tsGzm7HXrz4zVUjSQmiVXrpULVpmMDWjm2oSMYBculr8Z
         WHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690846; x=1725295646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szx7H5nibeV9OXvQnlfmFvfwbgNiPLWHXneUeuVFRCE=;
        b=G1JYJQnauXvrpUaOHB0kNVjhcqrUDKgg2vn6GtSWzUCIxAxL3iukijkLLgW7r1wKWK
         Npt23SxQOC6G1QTPObC+k68fup2v7efO/LXKWPr3v2bRzVICkDnaoJNCTcqYzPbWVSCW
         brJCjuqpw0wH4HcyNbGX2zSPTpoYCL9Ai2xW/BtYpqHXw6xpJ5KfFvZ/ynmIXPjZHxWj
         IyouMc26r9pGSwxacrmaSe8lMFYRNlADHLSDBO6g1ygh8xo6ekod2V08ZHCz8iPv3tQN
         LVjXTSzD0Rddiw6OPU3wmui7mjyG0MtEnJREf/wU/LykYc85TX4oErJH6e9+/RceSDs6
         c4lA==
X-Forwarded-Encrypted: i=1; AJvYcCUBdSF8yoF5Q94YC53s8Tz1K2scjJnvjVrahy+1PUl/PINZMgvkeTO4St4nror/6hN9zuboGssW@vger.kernel.org, AJvYcCXXlUkC47RkRhXtiE1WrOI3S1TKueUO53zsAX7pGBlQ/u3CxsoR9JpQ39Q/Os51j4CSzKlycyM8c3XhAqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKC9cfsfdPcWWC0pxBsMjyslE+M0cMnHKYgioRjKOIscNkRMi
	R4ej6t70gsLFESz3fxOdgH+zEZneQsAW5te0O9G7tS6qrHf1tXY1qtA6I0KGfuVCIXY4kgD/dfZ
	LsrOahtG1UyUYrJI5HAl1Gkrrrmk=
X-Google-Smtp-Source: AGHT+IEx3LpkKHy8rXxvKdKLggv+6qoGi/cT0E5RSpquS8L+eYvXm7iMq1KqgRqmbOCqXhlUNkBsnxCmM2ap1ORjATY=
X-Received: by 2002:a05:6000:82:b0:373:591:14e4 with SMTP id
 ffacd0b85a97d-373118c86d4mr6482636f8f.49.1724690846258; Mon, 26 Aug 2024
 09:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124021.2635705-1-linyunsheng@huawei.com> <20240826124021.2635705-7-linyunsheng@huawei.com>
In-Reply-To: <20240826124021.2635705-7-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 26 Aug 2024 09:46:49 -0700
Message-ID: <CAKgT0Uc7tRi6uGTpx2n9_JAK+sbPg7QcOOOSLK+a41cFMcqCWg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 06/13] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:46=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
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
>  include/linux/mm_types_task.h   | 19 ++++++-----
>  include/linux/page_frag_cache.h | 60 +++++++++++++++++++++++++++++++--
>  mm/page_frag_cache.c            | 51 +++++++++++++++-------------
>  3 files changed, 97 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index cdc1e3696439..a8635460e027 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -50,18 +50,21 @@ struct page_frag {
>  #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
>  struct page_frag_cache {
> -       void *va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +       /* encoded_page consists of the virtual address, pfmemalloc bit a=
nd order
> +        * of a page.
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
> index 0a52f7a179c8..372d6ed7e20a 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -3,18 +3,74 @@
>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>  #define _LINUX_PAGE_FRAG_CACHE_H
>
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
>  #include <linux/log2.h>
> +#include <linux/mm.h>
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
> +static inline unsigned long page_frag_encode_page(struct page *page,
> +                                                 unsigned int order,
> +                                                 bool pfmemalloc)
> +{
> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MA=
SK);
> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >=3D PAGE_SIZE);
> +
> +       return (unsigned long)page_address(page) |
> +               (order & PAGE_FRAG_CACHE_ORDER_MASK) |
> +               ((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_=
SHIFT);
> +}
> +
> +static inline unsigned long page_frag_encoded_page_order(unsigned long e=
ncoded_page)
> +{
> +       return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
> +}
> +
> +static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encod=
ed_page)
> +{
> +       return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
> +}
> +
> +static inline void *page_frag_encoded_page_address(unsigned long encoded=
_page)
> +{
> +       return (void *)(encoded_page & PAGE_MASK);
> +}
> +
> +static inline struct page *page_frag_encoded_page_ptr(unsigned long enco=
ded_page)
> +{
> +       return virt_to_page((void *)encoded_page);
> +}
> +
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
> -       nc->va =3D NULL;
> +       nc->encoded_page =3D 0;
>  }
>
>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
>  {
> -       return !!nc->pfmemalloc;
> +       return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
> +}
> +
> +static inline unsigned int page_frag_cache_page_size(unsigned long encod=
ed_page)
> +{
> +       return PAGE_SIZE << page_frag_encoded_page_order(encoded_page);
>  }
>
>  void page_frag_cache_drain(struct page_frag_cache *nc);

So how many of these additions are actually needed outside of the
page_frag_cache.c file? I'm just wondering if we could look at moving
most of these into the c file itself instead of making them accessible
to all callers as I don't believe we currently have anyone looking
into the size of the frag cache or anything like that and I would
prefer to avoid exposing such functionality if possible. As the
non-order0 allocation problem with this has pointed out people will
exploit any interface exposed even if unintentionally.

I would want to move the size/order logic as well as splitting out the
virtual address as we shouldn't be allowing the user to look at that
without going through an allocation function.

