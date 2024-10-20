Return-Path: <netdev+bounces-137263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720989A536A
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 12:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35341F2207B
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30364204F;
	Sun, 20 Oct 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl0oywUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D192BAF9;
	Sun, 20 Oct 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729418571; cv=none; b=FM0QW6jf1FaeV55tdWAWWsu7h7m10q1YtlOXxm0h1IXpSjw/OFwCwGoiJgtiu6EprlLdpFcnYgq+Wez/GOJh4N7zHNpJay6+u480Z8EFsb6QYtMz8yPPxuZ3Y0tEPzaCxBpBqspQUAunCfn9VC4we8iD9SMfdNX3mSqNFLKSjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729418571; c=relaxed/simple;
	bh=lHWynjA0dgPViLd4HgZJtIVX/O33rolSuVWFag/A308=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmK6kOznUL284QNghoz6W4rBgapbBaLNtltr+WmqVAUbqgB8sGxj9aDFKt5NQm3VFf+3boLCt0CgLtCKmoxMoKqqExslEJweOSga9YqWMof3dicbBctEcQ0CxcURH7YUdTlSKvh7awpp8K/+Kn11dcXbYyErE/WgJI+0UX9wMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl0oywUr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce65c8e13so30564645ad.1;
        Sun, 20 Oct 2024 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729418569; x=1730023369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLv1WNe4x555lLPO/CsQHB1qpygJDPAMQIxtHZM5Cng=;
        b=jl0oywUrzfCG1X8zrH+j0bX+N4CX6af36UUnkynQskJlTqhssXX9p34EeABCBGuJTM
         3foYsrXKxmvfcfrFMBm+h0+4UtOBXKC+Ox5qyI/s9ByF1oq6K1yeyW9eUCT0kQAgDHRA
         ybJqpXcJT6u5Q+rdR+SVtOQ+WY6aselMnm+VK02hq6Ul/ISFxMU45A5oWv05DiE+z7qZ
         /1haFGpr5GKuoF3YHywiu1USyJN1333r4LFlJiBHcrlNQ0Gq3+fEQEFxULOiSH2Khrrc
         b3fsT+3OzTXcv5a2DmphEr+A/LXJK4GKpMWv5pUupcKErJKtk59LaTnyAr73hsF/7VFC
         9G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729418569; x=1730023369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLv1WNe4x555lLPO/CsQHB1qpygJDPAMQIxtHZM5Cng=;
        b=tTAo0Ed+GOA6/f1fI1aCqsBOyrMXOsxg6nSlwDZT0HOBBvvAuMrpKQhz1bKOwnD+v1
         tUMgBQwazw382vyy7KuCyCHc4bDmbAIY75kC3BluZUq2oiW3vNJ55ABToYejkAvfpdrs
         7OOZJLYNJAA+jBhCtii+L4xHavc1uRtG3isfr9li1amR+30eYGz0aFD1b7Qk2cU7EPJd
         /E3h7f8zwQ5kaxKPRJ+61WN5U76oz9KVp7xW1Qu/hCyk0+3AVWzqplvuhR9T1lfRZ9X8
         Oy9lKaw8PpGd8PKOWDX27jZIlr9SBVsOWJiRvydpPui9NvpcNwp90OYdJ7ry/bXu8j/3
         OwoA==
X-Forwarded-Encrypted: i=1; AJvYcCW2kSjrB839W7SvZj5k90/vjfS+hIhA6SPHL0UReWCfPr8x3/6m7MbhJIYPOfjwmT9qBDBiaMCnYq4=@vger.kernel.org, AJvYcCWSPltiPl+NpEzCF5Ym013dGDgAxcsd4xQbZr0CDt3rTCE3TTlnqpcBCQ9X9GIHoCvcSzCA/+5ZmvcBYxon@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8f5ods7Ya2Yrm5IQFJno5GciGyr19AzawYfmK6Ld5lcUmnkl2
	K6Xp2PyhHb4eJSf1hBfGfQNxiU0heEC5+P73I2RwjDgWh9iCvuhEQARIcg==
X-Google-Smtp-Source: AGHT+IFIiG5yzV9iBxkwwESuSB+cKcM/T6OPAsFcmrr2YC16cMPsS58jEon7/L82qkM9BAGoFq0f0Q==
X-Received: by 2002:a05:6a21:6e41:b0:1d9:28f8:f27d with SMTP id adf61e73a8af0-1d92c5757e9mr11584284637.38.1729418568723;
        Sun, 20 Oct 2024 03:02:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec140781fsm907431b3a.185.2024.10.20.03.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 03:02:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 776E6437667D; Sun, 20 Oct 2024 17:02:45 +0700 (WIB)
Date: Sun, 20 Oct 2024 17:02:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH net-next v22 13/14] mm: page_frag: update documentation
 for page_frag
Message-ID: <ZxTVRRecKRpna6Aj@archie.me>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-14-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4TvRmf7dRhYSYeH"
Content-Disposition: inline
In-Reply-To: <20241018105351.1960345-14-linyunsheng@huawei.com>


--x4TvRmf7dRhYSYeH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 06:53:50PM +0800, Yunsheng Lin wrote:
> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frag=
s.rst
> index 503ca6cdb804..7fd9398aca4e 100644
> --- a/Documentation/mm/page_frags.rst
> +++ b/Documentation/mm/page_frags.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Page fragments
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -40,4 +42,176 @@ page via a single call.  The advantage to doing this =
is that it allows for
>  cleaning up the multiple references that were added to a page in order to
>  avoid calling get_page per allocation.
> =20
> -Alexander Duyck, Nov 29, 2016.
> +
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
> +
> +.. kernel-doc:: include/linux/page_frag_cache.h
> +   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
> +		  __page_frag_alloc_align page_frag_alloc_align page_frag_alloc
> +		 __page_frag_refill_align page_frag_refill_align
> +		 page_frag_refill __page_frag_refill_prepare_align
> +		 page_frag_refill_prepare_align page_frag_refill_prepare
> +		 __page_frag_alloc_refill_prepare_align
> +		 page_frag_alloc_refill_prepare_align
> +		 page_frag_alloc_refill_prepare page_frag_alloc_refill_probe
> +		 page_frag_refill_probe page_frag_commit
> +		 page_frag_commit_noref page_frag_alloc_abort
> +
> +.. kernel-doc:: mm/page_frag_cache.c
> +   :identifiers: page_frag_cache_drain page_frag_free
> +		 __page_frag_alloc_refill_probe_align
> +
> +Coding examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Initialization and draining API
> +-------------------------------
> +
> +.. code-block:: c
> +
> +   page_frag_cache_init(nc);
> +   ...
> +   page_frag_cache_drain(nc);
> +
> +
> +Allocation & freeing API
> +------------------------
> +
> +.. code-block:: c
> +
> +    void *va;
> +
> +    va =3D page_frag_alloc_align(nc, size, gfp, align);
> +    if (!va)
> +        goto do_error;
> +
> +    err =3D do_something(va, size);
> +    if (err) {
> +        page_frag_abort(nc, size);
> +        goto do_error;
> +    }
> +
> +    ...
> +
> +    page_frag_free(va);
> +
> +
> +Preparation & committing API
> +----------------------------
> +
> +.. code-block:: c
> +
> +    struct page_frag page_frag, *pfrag;
> +    bool merge =3D true;
> +    void *va;
> +
> +    pfrag =3D &page_frag;
> +    va =3D page_frag_alloc_refill_prepare(nc, 32U, pfrag, GFP_KERNEL);
> +    if (!va)
> +        goto wait_for_space;
> +
> +    copy =3D min_t(unsigned int, copy, pfrag->size);
> +    if (!skb_can_coalesce(skb, i, pfrag->page, pfrag->offset)) {
> +        if (i >=3D max_skb_frags)
> +            goto new_segment;
> +
> +        merge =3D false;
> +    }
> +
> +    copy =3D mem_schedule(copy);
> +    if (!copy)
> +        goto wait_for_space;
> +
> +    err =3D copy_from_iter_full_nocache(va, copy, iter);
> +    if (err)
> +        goto do_error;
> +
> +    if (merge) {
> +        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
> +        page_frag_commit_noref(nc, pfrag, copy);
> +    } else {
> +        skb_fill_page_desc(skb, i, pfrag->page, pfrag->offset, copy);
> +        page_frag_commit(nc, pfrag, copy);
> +    }

Looks good.

> +/**
> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
> + * @nc: page_frag cache from which to check
> + *
> + * Used to check if the current page in page_frag cache is allocated fro=
m the
"Check if ..."
> + * pfmemalloc reserves. It has the same calling context expectation as t=
he
> + * allocation API.
> + *
> + * Return:
> + * true if the current page in page_frag cache is allocated from the pfm=
emalloc
> + * reserves, otherwise return false.
> + */
> <snipped>...
> +/**
> + * page_frag_alloc() - Allocate a page fragment.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + *
> + * Alloc a page fragment from page_frag cache.
"Allocate a page fragment ..."
> + *
> + * Return:
> + * virtual address of the page fragment, otherwise return NULL.
> + */
>  static inline void *page_frag_alloc(struct page_frag_cache *nc,
> <snipped>...
> +/**
> + * __page_frag_refill_prepare_align() - Prepare refilling a page_frag wi=
th
> + * aligning requirement.
> + * @nc: page_frag cache from which to refill
> + * @fragsz: the requested fragment size
> + * @pfrag: the page_frag to be refilled.
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + * @align_mask: the requested aligning requirement for the fragment
> + *
> + * Prepare refill a page_frag from page_frag cache with aligning require=
ment.
"Prepare refilling ..."
> + *
> + * Return:
> + * True if prepare refilling succeeds, otherwise return false.
> + */
> <snipped>...
> +/**
> + * __page_frag_alloc_refill_probe_align() - Probe allocing a fragment and
> + * refilling a page_frag with aligning requirement.
> + * @nc: page_frag cache from which to allocate and refill
> + * @fragsz: the requested fragment size
> + * @pfrag: the page_frag to be refilled.
> + * @align_mask: the requested aligning requirement for the fragment.
> + *
> + * Probe allocing a fragment and refilling a page_frag from page_frag ca=
che with
"Probe allocating..."
> + * aligning requirement.
> + *
> + * Return:
> + * virtual address of the page fragment, otherwise return NULL.
> + */

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--x4TvRmf7dRhYSYeH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxTVQQAKCRD2uYlJVVFO
o48dAP9w1/ikZVwkTZ7/6Z8gKCKSKyBXAc/aFC4yi/F/wg1m/gEAnZmKKYWDOFVX
sWPxiPDgoXCZ5BkNapDzwPg3sMi+/Ak=
=gYU5
-----END PGP SIGNATURE-----

--x4TvRmf7dRhYSYeH--

