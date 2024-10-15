Return-Path: <netdev+bounces-135423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28899DD6C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DDA1F23EBC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 05:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7159616DEAA;
	Tue, 15 Oct 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqyHxwaI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A2158D9C;
	Tue, 15 Oct 2024 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969635; cv=none; b=aeBj4GM1ZCrNno5pzQYfFd/Pdlg+qfzGMQq1OVhLmrtzzsXzzvNWyJEPf2xUqUs+C2/D0wraQfF+L00jo2MEDhXzBn3eGk3eO1gGwdBJVun/SlBm9k5lr0dg53JbnfmuM0X7VZsDl3Yj3kiGeopH9ZogsyB7mybb5LKARDwTHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969635; c=relaxed/simple;
	bh=rZTuJA0XgneHld4XMUgodeC5ue8N4Ux6YuviVK1vDNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT5fuyI9hj2DuJUoC6+Vl0pFaYT2jKaxzHzAzzj3/WwZ63uRzXXU1ZLEC99C+XcuWdukPFUmK6JaoiTen/eQZM1GPqJSrC5XVGpGaOQQkyFILkjWF9afxYFUcVhCmE5+0FfYJsSw5nsqUdltaKEKvAYXJ9imX9HEH3k5Ftc/GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqyHxwaI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso1332307a12.2;
        Mon, 14 Oct 2024 22:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728969633; x=1729574433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2IhkJXPFLzz+hPR/kWflHimnMzSkOTzvQDFAvHBhxY=;
        b=IqyHxwaIjXxWg8yl/WZIPVpc9G0Q+vTXukjF7QXH0nQlIM+1kLET6TLEKL6CruS0hm
         cKHMhbU9/i7KGsj4LacrMI7nUg1h+ksQtMMJQw0eS4i5n8Xrqo/gZUUi+elHq1MExXCA
         qpLmUExzxpBCSQA4X6VmdKbSwERAyzBcQU1r8L47k0Y4/7AVNECtEqfVESPHW/7Bgf8n
         2LFP5zD1ugLJSsu2xlNsrERh5fLiyvJUm4sZPkpkHGi8/Aa5FeKIqJP3d72jP2KkOvln
         +dnCmG8n3lCiiRBoO3i0cHJlbqQrqvHrlowafmebrqJZ/H3m0qcdLWVr7o7VYOjrPg4u
         uDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728969633; x=1729574433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2IhkJXPFLzz+hPR/kWflHimnMzSkOTzvQDFAvHBhxY=;
        b=fU2wMPJz7uTNDe1GWBz8m5/DM2o1lDs974WhP56dWVdMdaan3ljlmvn/ge5mBXNLdm
         WbNKzWnqriIA2n4LydWKQZn/lf6ABS+1IzwCSR38jjzzIOq5GUp8Ziqvu0NMVkcS3/IQ
         vpUr0XX4pYnsj/T98fXVjIyYyFYWS/1XuF+P9hYQjwYKf/KQwaaxS33R1VVyVkqA3dK7
         RY3m5l7UzfYX2ck3dGuPT8vaVF+RJkPUSqfLN6SfMLOWX5PfnO4/zvqV5f+l8c8laywf
         mrrb2hrtm9bLijovNxu90BamQazBkCu2ZS/wEhSfFbRm2E5ICmW4rHnrlQtUmCtsFd3r
         92xw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rwrPl6+FfcPqqobE99CTYccAiybZpYsyIzAxSxbyuze/4HwhV/cw5D1Y6tktsnTVEDNwneepWxM=@vger.kernel.org, AJvYcCVkgZvnJT1lDuvEolXkEoDKtdQkiiLV1DVuHVLQ0aZwV5iRIVpGQPmynI7Ay0ZDnOAkN45QdWZ3DjGq4KHt@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiH2AhnkYCAX6wLvRPW8jePUU0NIPInRQ3v4/7U7y28YlYWZp
	yE0q1UXvht9nL6eKZzuHxj9T6RAc9FPouQKW0759WEVyHpjso89Z
X-Google-Smtp-Source: AGHT+IH3MzNOvexbhwEGTN4Lxk5gpsONFsFijM346VGqnxk5o8siCWx9cs7S/tdiu2/LDwkXCQUQpQ==
X-Received: by 2002:a05:6a21:6b0b:b0:1d2:e78d:214a with SMTP id adf61e73a8af0-1d8bcfbae38mr21602493637.44.1728969632596;
        Mon, 14 Oct 2024 22:20:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed3b5esm577391a91.18.2024.10.14.22.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 22:20:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 520064250F47; Tue, 15 Oct 2024 12:20:28 +0700 (WIB)
Date: Tue, 15 Oct 2024 12:20:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Cc: Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v21 13/14] mm: page_frag: update documentation
 for page_frag
Message-ID: <Zw37nCqT4RY1udAK@archie.me>
References: <20241012112320.2503906-1-linyunsheng@huawei.com>
 <20241012112320.2503906-14-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uausBQGM1VviM0gB"
Content-Disposition: inline
In-Reply-To: <20241012112320.2503906-14-linyunsheng@huawei.com>


--uausBQGM1VviM0gB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 07:23:19PM +0800, Yunsheng Lin wrote:
> +Architecture overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. code-block:: none
> +
> +                      +----------------------+
> +                      | page_frag API caller |
> +                      +----------------------+
> +                                  |
> +                                  |
> +                                  v
> +    +------------------------------------------------------------------+
> +    |                   request page fragment                          |
> +    +------------------------------------------------------------------+
> +             |                                 |                     |
> +             |                                 |                     |
> +             |                          Cache not enough             |
> +             |                                 |                     |
> +             |                         +-----------------+           |
> +             |                         | reuse old cache |--Usable-->|
> +             |                         +-----------------+           |
> +             |                                 |                     |
> +             |                             Not usable                |
> +             |                                 |                     |
> +             |                                 v                     |
> +        Cache empty                   +-----------------+            |
> +             |                        | drain old cache |            |
> +             |                        +-----------------+            |
> +             |                                 |                     |
> +             v_________________________________v                     |
> +                              |                                      |
> +                              |                                      |
> +             _________________v_______________                       |
> +            |                                 |              Cache is en=
ough
> +            |                                 |                      |
> + PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE         |                      |
> +            |                                 |                      |
> +            |               PAGE_SIZE >=3D PAGE_FRAG_CACHE_MAX_SIZE    |
> +            v                                 |                      |
> +    +----------------------------------+      |                      |
> +    | refill cache with order > 0 page |      |                      |
> +    +----------------------------------+      |                      |
> +      |                    |                  |                      |
> +      |                    |                  |                      |
> +      |              Refill failed            |                      |
> +      |                    |                  |                      |
> +      |                    v                  v                      |
> +      |      +------------------------------------+                  |
> +      |      |   refill cache with order 0 page   |                  |
> +      |      +----------------------------------=3D-+                  |
> +      |                       |                                      |
> + Refill succeed               |                                      |
> +      |                 Refill succeed                               |
> +      |                       |                                      |
> +      v                       v                                      v
> +    +------------------------------------------------------------------+
> +    |             allocate fragment from cache                         |
> +    +------------------------------------------------------------------+
> +
> +API interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +As the design and implementation of page_frag API implies, the allocatio=
n side
> +does not allow concurrent calling. Instead it is assumed that the caller=
 must
> +ensure there is not concurrent alloc calling to the same page_frag_cache
> +instance by using its own lock or rely on some lockless guarantee like N=
API
> +softirq.
> +
> +Depending on different aligning requirement, the page_frag API caller ma=
y call
> +page_frag_*_align*() to ensure the returned virtual address or offset of=
 the
> +page is aligned according to the 'align/alignment' parameter. Note the s=
ize of
> +the allocated fragment is not aligned, the caller needs to provide an al=
igned
> +fragsz if there is an alignment requirement for the size of the fragment.
> +
> +Depending on different use cases, callers expecting to deal with va, pag=
e or
> +both va and page for them may call page_frag_alloc, page_frag_refill, or
> +page_frag_alloc_refill API accordingly.
> +
> +There is also a use case that needs minimum memory in order for forward =
progress,
> +but more performant if more memory is available. Using page_frag_*_prepa=
re() and
> +page_frag_commit*() related API, the caller requests the minimum memory =
it needs
> +and the prepare API will return the maximum size of the fragment returne=
d. The
> +caller needs to either call the commit API to report how much memory it =
actually
> +uses, or not do so if deciding to not use any memory.

Looks OK.

> +Coding examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Init & Drain API
> +----------------

Initialization and draining API?

> +Alloc & Free API
> +----------------

Shouldn't it be called allocation API?

> +Prepare & Commit API
> +--------------------

This one looks OK.

> +/**
> + * page_frag_cache_init() - Init page_frag cache.
> + * @nc: page_frag cache from which to init
> + *
> + * Inline helper to init the page_frag cache.
> + */
s/Init/Initialize/
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
>  	nc->encoded_page =3D 0;
>  }
> =20
> +/**
> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
> + * @nc: page_frag cache from which to check
> + *
> + * Used to check if the current page in page_frag cache is pfmemalloc'ed.
                                                           is allocated by =
pfmemalloc()?
> + * It has the same calling context expectation as the alloc API.
> + *
> + * Return:
> + * true if the current page in page_frag cache is pfmemalloc'ed, otherwi=
se
> + * return false.
> + */
>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
>  {
>  	return encoded_page_decode_pfmemalloc(nc->encoded_page);
>  }
> =20
> +/**
> + * page_frag_cache_page_offset() - Return the current page fragment's of=
fset.
> + * @nc: page_frag cache from which to check
> + *
> + * The API is only used in net/sched/em_meta.c for historical reason, do=
 not use
> + * it for new caller unless there is a strong reason.

Then what does page_frag_cache_page_offset() do then?

> + *
> + * Return:
> + * the offset of the current page fragment in the page_frag cache.
> + */
>  static inline unsigned int page_frag_cache_page_offset(const struct page=
_frag_cache *nc)
>  {
>  	return nc->offset;
> @@ -66,6 +93,19 @@ static inline unsigned int __page_frag_cache_commit(st=
ruct page_frag_cache *nc,
>  	return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
>  }
> =20
> +/**
> + * __page_frag_alloc_align() - Alloc a page fragment with aligning
> + * requirement.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + * @align_mask: the requested aligning requirement for the 'va'
> + *
> + * Alloc a page fragment from page_frag cache with aligning requirement.
      Allocate
> + *
> + * Return:
> + * Virtual address of the page fragment, otherwise return NULL.
> + */
>  static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
>  					    unsigned int fragsz, gfp_t gfp_mask,
>  					    unsigned int align_mask)
> @@ -83,6 +123,19 @@ static inline void *__page_frag_alloc_align(struct pa=
ge_frag_cache *nc,
>  	return va;
>  }
> =20
> +/**
> + * page_frag_alloc_align() - Alloc a page fragment with aligning require=
ment.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache needs to be refilled
> + * @align: the requested aligning requirement for the fragment
> + *
> + * WARN_ON_ONCE() checking for @align before allocing a page fragment fr=
om
                                                allocating
> + * page_frag cache with aligning requirement.
> + *
> + * Return:
> + * virtual address of the page fragment, otherwise return NULL.
> + */
>  static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
>  					  unsigned int fragsz, gfp_t gfp_mask,
>  					  unsigned int align)
> @@ -91,12 +144,36 @@ static inline void *page_frag_alloc_align(struct pag=
e_frag_cache *nc,
>  	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
>  }
> =20
> +/**
> + * page_frag_alloc() - Alloc a page fragment.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + *
> + * Alloc a page fragment from page_frag cache.
      Allocate
> + *
> + * Return:
> + * virtual address of the page fragment, otherwise return NULL.
> + */
>  static inline void *page_frag_alloc(struct page_frag_cache *nc,
>  				    unsigned int fragsz, gfp_t gfp_mask)
>  {
>  	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
>  }
> =20
> +/**
> + * __page_frag_alloc_refill_prepare_align() - Prepare allocing a fragmen=
t and
> + * refilling a page_frag with aligning requirement.
> + * @nc: page_frag cache from which to allocate and refill
> + * @fragsz: the requested fragment size
> + * @pfrag: the page_frag to be refilled.
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + * @align_mask: the requested aligning requirement for the fragment.
> + *
> + * Prepare allocing a fragment and refilling a page_frag from page_frag =
cache.
      Prepare allocating?
> + *
> + * Return:
> + * virtual address of the page fragment, otherwise return NULL.
> + */
>  static inline void *__page_frag_alloc_refill_prepare_align(struct page_f=
rag_cache *nc,
>  							   unsigned int fragsz,
>  							   struct page_frag *pfrag,
> @@ -166,6 +324,21 @@ static inline void *__page_frag_alloc_refill_prepare=
_align(struct page_frag_cach
>  	return __page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask, align_mas=
k);
>  }

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--uausBQGM1VviM0gB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZw37lwAKCRD2uYlJVVFO
ozsyAQD/vI8ZDKqg1/mPx9QCFewRQlcaTj1hUmavIjvE6eMZIwD+MJo+IyfxYIMz
Vejvd38012SypK8hEnXwGWhvPMavcwU=
=GCX2
-----END PGP SIGNATURE-----

--uausBQGM1VviM0gB--

