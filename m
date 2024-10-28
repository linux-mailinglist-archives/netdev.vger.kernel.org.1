Return-Path: <netdev+bounces-139606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5B9B3847
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA695282EC1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFE1DED40;
	Mon, 28 Oct 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIjmyJ86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B91552FC;
	Mon, 28 Oct 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138054; cv=none; b=TIgNi3cQkaKqQ9AaQsVwiqs/0NOVE70higEmmOQ9a8WZntb8BqNRiBtmZm/vX3qLiR3+gf9a0wyt2rSgeVUYZTZ2MA/4nblb+u1ktDR9ptMZKnxnIA6GSiaILrc4wzCWMYl2caVNXUQ1egSyjbHFxJcfQRzq+6h5sJaZ+TJoO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138054; c=relaxed/simple;
	bh=bPbqg2WP1InrE9RdXlMFH+zAOsQwV3DQCbqjQzAlBpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbI/CLm7Cdn/K/x8NUOWL9aGdGgLQgHlFgmj+eILRV4IeojvG0mEx6LJCTwC136rz2FZUju+mOqooifr1W7XA1+zuyGY4xIJn89RZVKZjaFeCFdV8RjanFF1Cqjezd4kIWAXBU97D1HUNhzuT72+3ooPvhC5v81DrI6ICsLwdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIjmyJ86; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso42605915e9.3;
        Mon, 28 Oct 2024 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730138050; x=1730742850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6UuyopKZ4h5skfASyHzs29ZguAavZNLDhMYIlEaFJI=;
        b=hIjmyJ865ci8KGChEfOpTHPC2V0ADRIohTUun9nsomMHlBFDrIascJ5MZIKlcKOYfW
         bGF90bWunxzhGGWOTmJSYnrUXCDsqAwQLNaLoE3kFTBFaEpKJSWejcDX9sTE43yopC0o
         fg1Q9tJSl3k/HdwKAd0hlxnKyfSEHPvCi3/bHdFKOJONoaVDA3pF9YNO216XaRtzYZx2
         cSzbW4lP6QvWMLASErdBdAafI+Z4sx5iCOHlqVx0bQYMCcseYm4K4IPMY+oOQZZq1q8K
         M8bBwsrBaGj/B0afLWHLecKSz8AeP0Eel/xU0c95iIqnh/w7ak4QU4+ccNtZGSIK/lVZ
         xaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138050; x=1730742850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6UuyopKZ4h5skfASyHzs29ZguAavZNLDhMYIlEaFJI=;
        b=rxLBW/rcuSxlXhnw/Zb3MIhwmcb8TFK4QQg/WptFuKoCy4tl6DVtxmTHK2rPX+2G46
         RHFIM3F/HMNMVckoOhtXwekieKhluXLCNG/mEEUpQOHCYgazWEWnduG+tvnIXIV0nVRp
         KhcTNQEcUcWjr3UIWuqUMfAyHvDJawhMHmCsboC2SHQ+vRVqTXzeXAVyqKDw+9DZrShz
         CzChSyK5eyGO+djHvfFvFplQ4Q0vOaRdrMTIvuybXzgB0PRNcI17LNfi9zVBqAZqgLIz
         v9Vbg4IfsOiQAIAVfLhH2gv2xJcD2yuarF8F3H4LxKtB2DhzBIIzg0P2PLMnpBoNszXl
         YYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTDMIQvNehiyXsqR9h39zQHVRAyoWg5ahUHX2iVHIEYe36SuUseSGrB6+vDflvjbEZ6PoYpNMDZSw=@vger.kernel.org, AJvYcCVn+WSOegPk8LTnoPqF1mng5UIEmP9nn1kBElAmvh5qGsihUX4wPoq5lFGpdTQFoLBbVrfKOBs5@vger.kernel.org, AJvYcCXQCivsCCiJYR7DC/P0GPlJz2UWJTDmfPAQ8o7n7wl3+IqK2hBIN0+TUxTz6b54i7docLMKb+6I6VJZ1xp6@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjYEWkVVC4UnK6nVvJTXJbajTRn0bUnuoPGKtxkSAM6v+3uor
	zkbGyPJn6b8MJieYxd8VW/U9Cc0DtB1fsG674HJs04jhY2q/eXSuoXNVzRR6C/rqGmF/tXB0wJO
	KjdXPO/rQ+wex76tvERxbwM3BtxvQRQ==
X-Google-Smtp-Source: AGHT+IHDF4FKUdkCw3jvLqzaE+MRg8G7+oBY30wWy8t6CmWPzpsWrLHilSvHlQUUJLdmkQ9yX3dPsu9z4QHqCFKcAWo=
X-Received: by 2002:adf:cf06:0:b0:37d:4afe:8c98 with SMTP id
 ffacd0b85a97d-38061159506mr6015970f8f.26.1730138050108; Mon, 28 Oct 2024
 10:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028115850.3409893-1-linyunsheng@huawei.com> <20241028115850.3409893-5-linyunsheng@huawei.com>
In-Reply-To: <20241028115850.3409893-5-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 28 Oct 2024 10:53:33 -0700
Message-ID: <CAKgT0UfouCZpX04yzvCrB_UBmy47p+=xm5qViYowerR9dPcCbg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] mm: page_frag: introduce page_frag_alloc_abort()
 related API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:05=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> For some case as tun_build_skb() without the needing of
> using complicated prepare & commit API, add the abort API to
> abort the operation of page_frag_alloc_*() related API for
> error handling knowing that no one else is taking extra
> reference to the just allocated fragment, and add abort_ref
> API to only abort the reference counting of the allocated
> fragment if it is already referenced by someone else.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Linux-MM <linux-mm@kvack.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  Documentation/mm/page_frags.rst |  7 +++++--
>  include/linux/page_frag_cache.h | 20 ++++++++++++++++++++
>  mm/page_frag_cache.c            | 21 +++++++++++++++++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frag=
s.rst
> index 34e654c2956e..339e641beb53 100644
> --- a/Documentation/mm/page_frags.rst
> +++ b/Documentation/mm/page_frags.rst
> @@ -114,9 +114,10 @@ fragsz if there is an alignment requirement for the =
size of the fragment.
>  .. kernel-doc:: include/linux/page_frag_cache.h
>     :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
>                  __page_frag_alloc_align page_frag_alloc_align page_frag_=
alloc
> +                page_frag_alloc_abort
>
>  .. kernel-doc:: mm/page_frag_cache.c
> -   :identifiers: page_frag_cache_drain page_frag_free
> +   :identifiers: page_frag_cache_drain page_frag_free page_frag_alloc_ab=
ort_ref
>
>  Coding examples
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -143,8 +144,10 @@ Allocation & freeing API
>          goto do_error;
>
>      err =3D do_something(va, size);
> -    if (err)
> +    if (err) {
> +        page_frag_alloc_abort(nc, va, size);
>          goto do_error;
> +    }
>
>      ...
>
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index a2b1127e8ac8..c3347c97522c 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -141,5 +141,25 @@ static inline void *page_frag_alloc(struct page_frag=
_cache *nc,
>  }
>
>  void page_frag_free(void *addr);
> +void page_frag_alloc_abort_ref(struct page_frag_cache *nc, void *va,
> +                              unsigned int fragsz);
> +
> +/**
> + * page_frag_alloc_abort - Abort the page fragment allocation.
> + * @nc: page_frag cache to which the page fragment is aborted back
> + * @va: virtual address of page fragment to be aborted
> + * @fragsz: size of the page fragment to be aborted
> + *
> + * It is expected to be called from the same context as the allocation A=
PI.
> + * Mostly used for error handling cases to abort the fragment allocation=
 knowing
> + * that no one else is taking extra reference to the just aborted fragme=
nt, so
> + * that the aborted fragment can be reused.
> + */
> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc, voi=
d *va,
> +                                        unsigned int fragsz)
> +{
> +       page_frag_alloc_abort_ref(nc, va, fragsz);
> +       nc->offset -=3D fragsz;
> +}
>
>  #endif
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index d014130fb893..4d5626da42ed 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -201,3 +201,24 @@ void page_frag_free(void *addr)
>                 free_unref_page(page, compound_order(page));
>  }
>  EXPORT_SYMBOL(page_frag_free);
> +
> +/**
> + * page_frag_alloc_abort_ref - Abort the reference of allocated fragment=
.
> + * @nc: page_frag cache to which the page fragment is aborted back
> + * @va: virtual address of page fragment to be aborted
> + * @fragsz: size of the page fragment to be aborted
> + *
> + * It is expected to be called from the same context as the allocation A=
PI.
> + * Mostly used for error handling cases to abort the reference of alloca=
ted
> + * fragment if the fragment has been referenced for other usages, to aov=
id the
> + * atomic operation of page_frag_free() API.
> + */
> +void page_frag_alloc_abort_ref(struct page_frag_cache *nc, void *va,
> +                              unsigned int fragsz)
> +{
> +       VM_BUG_ON(va + fragsz !=3D
> +                 encoded_page_decode_virt(nc->encoded_page) + nc->offset=
);
> +
> +       nc->pagecnt_bias++;
> +}
> +EXPORT_SYMBOL(page_frag_alloc_abort_ref);

It isn't clear to me why you split this over two functions. It seems
like you could just update the offset in this lower function rather
than do it in the upper one since you are passing all the arguments
here anyway.

