Return-Path: <netdev+bounces-134299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24631998A47
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D571C24117
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717D1CCEEF;
	Thu, 10 Oct 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifGxkPHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3B1CC8BC;
	Thu, 10 Oct 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570848; cv=none; b=ECpyKTy84eihjg7h9cVa8MPRtGLfYZ7GJfQZuNbEH2XoQa2xziZmCesj+LEZIdXUV4XLStMDIVcYpzf5qVQz50zRoXK9f5imgucHbNWbiYyGp9w+a+Qtp4vdyNEuyrrrNCuHEbGtF8R0qF0CMhRxuIp2rzJSeldgp/MmpcnudyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570848; c=relaxed/simple;
	bh=OKwd/7ZO9YfzRiWrVjFR5Em3wr9N9Q9E8EZqGUPPwb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvA8wgjP/yUHqhIK9iiMfjsz34ZZBv1hkrigzq/ySBJD3ya30xrqCBRHTpyPCbV9udnouWmSbOSRT/kQ1rW+tIY0fUB1mZofFAOP+p0IHUl+/8P2ivUezogk112KIG1q2tPoNbdTDtd3PMOVHcmr3Aa5XP98nnxSn6dgoawsrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifGxkPHb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43115887867so6823545e9.0;
        Thu, 10 Oct 2024 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728570845; x=1729175645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRcqszNxyUIAAOVOEfCGxTgUEsOz9kwyuMwhZN6S4qM=;
        b=ifGxkPHbrzR6fG7+aPVDwe7eufO4GDEyFCfoydBEa+HxQxeCauxUdjDlF7D1GjRBg0
         j9X7IO5BC5txM09uD2llPEAv1U+6XN85vHXQMP9UhTZl/8p2wb8TPDgBg3Xjm7e3WdC5
         +prAgASOx5P1Mibc+DNkqPHhcewvUgR7onrzxvbA0FGLVOBK2KcU1G5X5Qk5xI22HE5W
         rEp4kMiBUXlfhz8CZeEP23f27fNkrKPpYyvrnMNujCrpgl9qnmtf1FktYeCYIgtAhP+o
         e0zlrqwbO1FWJZRHgpyVowim1b4mtgdv8SFJ3SsIh1Y2qrgHBWqDnxYO2J8OeC48HOn/
         efvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570845; x=1729175645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRcqszNxyUIAAOVOEfCGxTgUEsOz9kwyuMwhZN6S4qM=;
        b=xOgn8r14KfmquxLpb0OO35n2/VTv4HtjAW4WfNTlGsuR/8yyQH2kHh2TG4w3JT7QUk
         J6DuJrmzAwFRCRxkFrl6PAQHs6xrHdkMV78fOqG8jCE3DIya009xxt3A+qb3MfUZgZtp
         mD56mSckr63apSUd6Hzb9BIkF9XX9IZi83QIdPHlE1ltp2ZL8Dlh87Lm/9eCQX9GqaCY
         ixdvxcRjMO0V2exu7a/CuwniDZz3Zq3ap7oxHiUOmpV2alKS6leK+6EHKo+aKBZ8QrB0
         NYZSgQ3qzX7LjUK9w8YTpAhR20xHJGbazBFUSv9p4TiJ0VaLBqiOIoB/WXGrEVsQN2Go
         oObw==
X-Forwarded-Encrypted: i=1; AJvYcCWTyB73yucoe5fcrb4oohMKFELOBteWaU2wLjVDeZzt044gv0pysImOZKvjHc/Fv2ohi+IVOdck+8jLxds=@vger.kernel.org, AJvYcCX+blfWRps3QVC9+QaYYXoP5bxWeyZxAVo2oNWwKg0n6KJNRsrLAG1Sdoleknll0Yw9qWKzWRSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0tZIVzSQTaB/REM/nVzbyfHIiL8Lx08QSN00/rYAolFn7pzN
	1SfxC+zgCmJKs2Q5nDpI3uR5wIhP9hgemWJfhU6VjHxm6zNianAFwguR+zDeplqJFvNIKv+Ql7P
	m4OMhXi8tVdGvKCYvtFJIS7pjQVY=
X-Google-Smtp-Source: AGHT+IFiCX82jVoo9UNG1nkAn8eMWn7soS/rn0DAy4Oe60tWsJi3sd+f5FD995Ap7EhQqDBAkC60hHgbhQLOulTcWX4=
X-Received: by 2002:a05:600c:1911:b0:426:5b17:8458 with SMTP id
 5b1f17b1804b1-43115abf3b6mr30732445e9.12.1728570844539; Thu, 10 Oct 2024
 07:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-7-linyunsheng@huawei.com> <CAKgT0UdgoyE0BzZoyXzxWYtAakJGWKORSZ25LbO1-=Q_Stiq9w@mail.gmail.com>
 <8bc47d27-b8ea-4573-937a-0056bdd8ea2c@huawei.com>
In-Reply-To: <8bc47d27-b8ea-4573-937a-0056bdd8ea2c@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 10 Oct 2024 07:33:27 -0700
Message-ID: <CAKgT0Uf0g9_P6fUBzueZ-rwq1RCu5TjruZGT+kXjsQi-=jqStQ@mail.gmail.com>
Subject: Re: [PATCH net-next v20 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:32=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/10/10 7:50, Alexander Duyck wrote:
>
> ...
>
> >> +
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         (PAGE_FRAG_CACHE_ORDER=
_MASK + 1)
> >> +
> >> +static inline bool page_frag_encoded_page_pfmemalloc(unsigned long en=
coded_page)
> >> +{
> >> +       return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
> >> +}
> >> +
> >
> > Rather than calling this encoded_page_pfmemalloc you might just go
> > with decode_pfmemalloc. Also rather than passing the unsigned long we
> > might just want to pass the page_frag_cache pointer.
> As the page_frag_encoded_page_pfmemalloc() is also called in
> __page_frag_alloc_align(), and __page_frag_alloc_align() uses a
> local variable for 'nc->encoded_page' to avoid fetching from
> page_frag_cache pointer multi-times, so passing an 'unsigned long'
> is perferred here?
>
> I am not sure if decode_pfmemalloc() is simple enough that it
> might be conflicted with naming from other subsystem in the
> future. I thought about adding a '__' prefix to it, but the naming
> seems long enough that some inline helper' naming is over 80 characters.

What you might do is look at having a page_frag version of the
function and a encoded_page version as I called out below with the
naming. It would make sense to call the two out separately as this is
operating on an encoded page, not a page frag. With that we can avoid
any sort of naming confusion.

> >
> >>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
> >>  {
> >> -       nc->va =3D NULL;
> >> +       nc->encoded_page =3D 0;
> >>  }
> >>
> >>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cac=
he *nc)
> >>  {
> >> -       return !!nc->pfmemalloc;
> >> +       return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
> >>  }
> >>
> >>  void page_frag_cache_drain(struct page_frag_cache *nc);
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index 4c8e04379cb3..4bff4de58808 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -12,6 +12,7 @@
> >>   * be used in the "frags" portion of skb_shared_info.
> >>   */
> >>
> >> +#include <linux/build_bug.h>
> >>  #include <linux/export.h>
> >>  #include <linux/gfp_types.h>
> >>  #include <linux/init.h>
> >> @@ -19,9 +20,41 @@
> >>  #include <linux/page_frag_cache.h>
> >>  #include "internal.h"
> >>
> >> +static unsigned long page_frag_encode_page(struct page *page, unsigne=
d int order,
> >> +                                          bool pfmemalloc)
> >> +{
> >> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER=
_MASK);
> >> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >=3D PAGE_SIZE);
> >> +
> >> +       return (unsigned long)page_address(page) |
> >> +               (order & PAGE_FRAG_CACHE_ORDER_MASK) |
> >> +               ((unsigned long)pfmemalloc * PAGE_FRAG_CACHE_PFMEMALLO=
C_BIT);
> >> +}
> >> +
> >> +static unsigned long page_frag_encoded_page_order(unsigned long encod=
ed_page)
> >> +{
> >> +       return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
> >> +}
> >> +
> >> +static void *page_frag_encoded_page_address(unsigned long encoded_pag=
e)
> >> +{
> >> +       return (void *)(encoded_page & PAGE_MASK);
> >> +}
> >> +
> >> +static struct page *page_frag_encoded_page_ptr(unsigned long encoded_=
page)
> >> +{
> >> +       return virt_to_page((void *)encoded_page);
> >> +}
> >> +
> >
> > Same with these. Instead of calling it encoded_page_XXX we could
> > probably just go with decode_page, decode_order, and decode_address.
> > Also instead of passing an unsigned long it would make more sense to
> > be passing the page_frag_cache pointer, especially once you start
> > pulling these out of this block.
>
> For the not passing the page_frag_cache pointer part, it is the same
> as above, it is mainly to avoid fetching from pointer multi-times.
>
> >
> > If you are wanting to just work with the raw unsigned long value in
> > the file it might make more sense to drop the "page_frag_" prefix from
> > it and just have functions for handling your "encoded_page_" value. In
> > that case you might rename page_frag_encode_page to
> > "encoded_page_encode" or something like that.
>
> It am supposing you meant 'encoded_page_decode' here instead of
> "encoded_page_encode"?
> Something like below?
> encoded_page_decode_pfmemalloc()
> encoded_page_decode_order()
> encoded_page_decode_page()
> encoded_page_decode_virt()

For the decodes yes. I was referring to page_frag_encode_page.
Basically the output from that isn't anything page frag, it is your
encoded page type so you could probably just call it
encoded_page_encode, or encoded_page_create or something like that.

