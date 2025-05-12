Return-Path: <netdev+bounces-189746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2CFAB379B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CBD3A7D4F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329672920A8;
	Mon, 12 May 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/SkoFB1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28D25C832
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054004; cv=none; b=CMyz0QJSwHdkUCi7YLDrhT+o1sLCLTOtr2ULULxRZUEByyV/gRTVG6/EpRIYSBihENk8ULjXrMN6Fb/yRa72JMqQm4jJZq+4mODujit6DlY8pTnQYRVErCYNVa5lX/fBdX32+BmBLMKtpZpmNFXtmnusAeS07PzgaE9Q/2CPHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054004; c=relaxed/simple;
	bh=SFrQ96SWjOHxF+NK26v1Qk+ijp7hkNrxd9MMXtK3qCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ciRdXLlBstxjuo23QGt0pqu+7Lo3lBp7BePJj/O0ophk8Rn7J+M5tbIbgBJbUM20JQe/5SnmOQELiA1+1t+ZemxQ2FyFgDcKHdXy06bXo4CvwJl6ffvMeMs2IwwLWcM2tllCjABYI6uzDbTbsoBbmwcEtcaG1PAj/Ied4hF74IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/SkoFB1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747054001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NkzqQd6U+yQ9nxd2lN/wdHj8OOAvjcAGxVttB90OmY=;
	b=V/SkoFB1VSJ/UhaJ7bpF1PVT/mU3zUZNJnkXfOC6HWNA55LzLBz0OrX7Mnrc1LmsQGTHtL
	Mnywhzx45mp7jA1dLAwq4KQkkisBuj8GYE8Ugrx5mkepDrjrLWQuFIioWnY5frQD0fQWo2
	vZ95TNndVd2WNliiUzCEOP1mp9s4F+E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-d9KH1I1ONjKfTN5dip7FhQ-1; Mon, 12 May 2025 08:46:39 -0400
X-MC-Unique: d9KH1I1ONjKfTN5dip7FhQ-1
X-Mimecast-MFC-AGG-ID: d9KH1I1ONjKfTN5dip7FhQ_1747053998
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad21aba2147so366991366b.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 05:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053998; x=1747658798;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NkzqQd6U+yQ9nxd2lN/wdHj8OOAvjcAGxVttB90OmY=;
        b=raB+MLtg+AZ+e4nHPWhcO7Yju+BU6vELbdVkvQaPaxDsKuRaNZ/PdGRkbnoL6rSZd+
         ZE27kUWsNu5tsElSsezxVgAUuXqliauePnBaiD5y5BmuRSnRAni1z3sfq0HD4K1s9E4B
         w4CDfpnPJqhLPGTA6imIXXU0IWNifW/bvKTLEWAiIdr4TZ7t2KFCM8pGRbiDcpwRYj4Q
         HkMqtUbghPtkRC4Cum8H1na6q8hGJsFJkANVhtRGOICEElnllN1+a+3LIDD7MS29z+HE
         HL6vdUM5TXahdN4d5KUpeoJdJB3ONyyPWDtgQzFxBnOBC9S7wKobHo0MeM9StWJdzwu4
         Z9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXH/fpNM2fcSyjilkktIsFN+0s0H5VIx6MlRRF8h8kjv63jVrKo+UDmqZXhxBuB+a5sg48OQWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUpg/Pc3nFevpfNg9JEOZFNFDGxCunRmHzAbDdwDqSfkNBq5p
	YP8CBnmSSuLGJZHudzgN/5JZOSW0v2Brc8O9mzDGsr6sPDddTPIjWu5/UJ/sTY3gt7Jx0TpPYjj
	oARMz1ATENs2g1z6TyFHZlZnLi6MHZHryyowWY+A+mIm3JMtwZ21b+g==
X-Gm-Gg: ASbGnctM7zYOl1GGfWI5emnGlIhSlZ3fqg4gILr0Q0q4+YngdkB6tkuTHMnZC5Oiv1T
	OsHseSR1uR7RopcmDL9NDvQC2rDzJ8WOq6eG26jMr5Bt1E8jiosnHhiNFc37l+GebzhiY7YJgko
	bye3jvR/vzuXV7aDIoynbVjOkvAwWLCvZIr3YecSk4ZAuskWFRCHDQD+MTqCzQc5czqZrltc+pb
	Q8gTlvSdQQUSO8Ww1aParQkroDEtnlPL+FHjWJiD93UYCZPN6+s5rGWITCbHJf6Ncvn+QJi0cpW
	wDMy3ChXg4+0qrGdGuFzzzpxSqjUqFFWmrM+
X-Received: by 2002:a17:907:60ca:b0:ad2:47e7:3f40 with SMTP id a640c23a62f3a-ad247e741d8mr610956966b.51.1747053998236;
        Mon, 12 May 2025 05:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv5Yseqz71/930sKihuYXBmsPyQO4+2Jp0cb013Gtt770NhHe4Wblb+klxHw4Q72ax0dlTvw==
X-Received: by 2002:a17:907:60ca:b0:ad2:47e7:3f40 with SMTP id a640c23a62f3a-ad247e741d8mr610953566b.51.1747053997827;
        Mon, 12 May 2025 05:46:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2521cc56bsm193357966b.109.2025.05.12.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:46:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3A9011A0C828; Mon, 12 May 2025 14:46:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Subject: Re: [RFC 13/19] page_pool: expand scope of is_pp_{netmem,page}() to
 global
In-Reply-To: <20250509115126.63190-14-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-14-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 12 May 2025 14:46:36 +0200
Message-ID: <87y0v22dzn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> Other than skbuff.c might need to check if a page or netmem is for page
> pool, for example, page_alloc.c needs to check the page state, whether
> it comes from page pool or not for their own purpose.
>
> Expand the scope of is_pp_netmem() and introduce is_pp_page() newly, so
> that those who want to check the source can achieve the checking without
> accessing page pool member, page->pp_magic, directly.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/page_pool/types.h |  2 ++
>  net/core/page_pool.c          | 10 ++++++++++
>  net/core/skbuff.c             |  5 -----
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 36eb57d73abc6..d3e1a52f01e09 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -299,4 +299,6 @@ static inline bool is_page_pool_compiled_in(void)
>  /* Caller must provide appropriate safe context, e.g. NAPI. */
>  void page_pool_update_nid(struct page_pool *pool, int new_nid);
>  
> +bool is_pp_netmem(netmem_ref netmem);
> +bool is_pp_page(struct page *page);
>  #endif /* _NET_PAGE_POOL_H */
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index b61c1038f4c68..9c553e5a1b555 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1225,3 +1225,13 @@ void net_mp_niov_clear_page_pool(struct netmem_desc *niov)
>  
>  	page_pool_clear_pp_info(netmem);
>  }
> +
> +bool is_pp_netmem(netmem_ref netmem)
> +{
> +	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
> +}
> +
> +bool is_pp_page(struct page *page)
> +{
> +	return is_pp_netmem(page_to_netmem(page));
> +}
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6cbf77bc61fce..11098c204fe3e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -893,11 +893,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>  		skb_get(list);
>  }
>  
> -static bool is_pp_netmem(netmem_ref netmem)
> -{
> -	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
> -}
> -

This has already been moved to mm.h (and the check changed) by commit:

cd3c93167da0 ("page_pool: Move pp_magic check into helper functions")

You should definitely rebase this series on top of that (and the
subsequent ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap
them when destroying the pool")), as these change the semantics of how
page_pool interacts with struct page.

Both of these are in net-next, which Mina already asked you to rebase
on, so I guess you'll pick it up there, put flagging it here just for
completeness :)

-Toke


