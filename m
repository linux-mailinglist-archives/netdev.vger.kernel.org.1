Return-Path: <netdev+bounces-141013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110949B918D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B4E1F231A4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AD81A00FA;
	Fri,  1 Nov 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtJK4vGD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675219E982
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466610; cv=none; b=Jlw0HLlbISBLimNHmGF7xHc/+enxNfipcM/S6Yq2TMXd/CGqmlobLIR1PuewQAIET7aKQc1D+4KuOoSC0AuS2ZBmUtCVijKbseDkemyB5GbwW0dH1j/iDlEiBD2vfR+HEhLnMD8BTgRf+nll+sFD75aPyuX/bkeQT7hJEMNuUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466610; c=relaxed/simple;
	bh=l9cjlou6mpETLrQVOj1LeWVrg+4r4bM75qya6s4Z8dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CTbfL5Fb3ba3u86lZqLKFyngfoDlU8k3BVubtoTTpRoWu1cDgTyglc0Jp42Wp5qw1NIn8daGwrkUg1sp/VDnwJdSKmdyHHInfyhhGxTY9TvbXSIBopd3KA8/duTgiqiha45ZdSjwWYb94ETyyw4NspyZrUVUoceMFJJ59nwblNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtJK4vGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730466606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlrLEHSrIjMehLpiiUtAbg0zaECkOh0tWzc6F/xoVzU=;
	b=WtJK4vGDIazBCa1SaK5YUBdPxuqrk6pLezczECb9zkefyMR8GAF9asgCH5HV29bH309zrr
	E/fPm14jdEOOrAXzL8ftjypFnAlD7FFGvlVuzvXhghigo9xnPN5PoSzccDs6hU5wn/j4FY
	0DKXdTY68yAYILkrIAT0hY6pkuXQLt4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-W8ygPaGmPDu0gwYB5n2qJw-1; Fri, 01 Nov 2024 09:10:03 -0400
X-MC-Unique: W8ygPaGmPDu0gwYB5n2qJw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso10964955e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 06:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466602; x=1731071402;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlrLEHSrIjMehLpiiUtAbg0zaECkOh0tWzc6F/xoVzU=;
        b=XOvv7dcTdYOBpPHIhQxA1h1Wb8oTu88rh5jLIR1VAgxbrYU8t5XsNAToHeLpzhqVq4
         kh5VXCP1JsywripNF9wsd09w0snof5fOK0K2lUdfS30xlJ4VD5P0i9SltNwYb+FKd1SU
         QOg3tZZAbundWK/P/go7v4UNbaRParAcG44ZFTSCrx2HMoSc3twCCZzuKZ/kt+6dxnzB
         qs+4IISNRw7w23g+rLHHTKRNSh5JuRideZT6J2ZUNvYqplUIVMHL+8X32/eoetWMJXVh
         H/5O0oXY0C0w8rQebdgrJSQI7GloEJ4BugciDN311nlBD7knfVDFPLcjT0f0LMJV/bOn
         gE2A==
X-Forwarded-Encrypted: i=1; AJvYcCV1jIbiflS65ZtJoiqYiWaIw5sQFKKySw8jOnEIcB4JrkHoZ78Qa+2czYjexG1YX2pqmtTS1Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4PjUaUjtF/k3oC/3RGR7NyQLNVMbVUnPibo+uSLP/iLr73Wa
	h9EtgD/utZ8ExFNxUhBA0A/IgDWU5ZtmyKTTkbYisLhy97E2wIDDQmzI7skQW6nV3JJl0UXS/U5
	9IUm1xRLDIKQp5fUBFSunrmDFQFtZO4/HIe2YDVuGbkLqr30EbqhiLw==
X-Received: by 2002:a05:600c:46c5:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-43282fcfa63mr29332735e9.2.1730466602218;
        Fri, 01 Nov 2024 06:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsgHEsuAvFxkuf8HOXBXlUTTWg1Ksu26Xw7Mg7bz9nTOc2oVpqJ4spztSOBYj/kRFgbQ0gkQ==
X-Received: by 2002:a05:600c:46c5:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-43282fcfa63mr29332465e9.2.1730466601768;
        Fri, 01 Nov 2024 06:10:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a99d3sm92048415e9.38.2024.11.01.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:10:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 47E02164B963; Fri, 01 Nov 2024 14:09:59 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/18] page_pool: allow mixing PPs within
 one bulk
In-Reply-To: <20241030165201.442301-10-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-10-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:09:59 +0100
Message-ID: <87ldy39k2g.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The main reason for this change was to allow mixing pages from different
> &page_pools within one &xdp_buff/&xdp_frame. Why not?
> Adjust xdp_return_frame_bulk() and page_pool_put_page_bulk(), so that
> they won't be tied to a particular pool. Let the latter create a
> separate bulk of pages which's PP is different and flush it recursively.
> This greatly optimizes xdp_return_frame_bulk(): no more hashtable
> lookups. Also make xdp_flush_frame_bulk() inline, as it's just one if +
> function call + one u32 read, not worth extending the call ladder.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Neat idea, but one comment, see below:

[...]

>  /**
>   * page_pool_put_page_bulk() - release references on multiple pages
> - * @pool:	pool from which pages were allocated
>   * @data:	array holding page pointers
>   * @count:	number of pages in @data
> + * @rec:	whether it's called recursively by itself
>   *
>   * Tries to refill a number of pages into the ptr_ring cache holding ptr_ring
>   * producer lock. If the ptr_ring is full, page_pool_put_page_bulk()
> @@ -854,21 +865,43 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
>   * Please note the caller must not use data area after running
>   * page_pool_put_page_bulk(), as this function overwrites it.
>   */
> -void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
> -			     u32 count)
> +void page_pool_put_page_bulk(struct page **data, u32 count, bool rec)
>  {
> +	struct page_pool *pool = NULL;
> +	struct xdp_frame_bulk sub;
>  	int i, bulk_len = 0;
>  	bool allow_direct;
>  	bool in_softirq;
>  
> -	allow_direct = page_pool_napi_local(pool);
> +	xdp_frame_bulk_init(&sub);
>  
>  	for (i = 0; i < count; i++) {
> -		netmem_ref netmem = page_to_netmem(compound_head(data[i]));
> +		struct page *page;
> +		netmem_ref netmem;
> +
> +		if (!rec) {
> +			page = compound_head(data[i]);
> +			netmem = page_to_netmem(page);
>  
> -		/* It is not the last user for the page frag case */
> -		if (!page_pool_is_last_ref(netmem))
> +			/* It is not the last user for the page frag case */
> +			if (!page_pool_is_last_ref(netmem))
> +				continue;
> +		} else {
> +			page = data[i];
> +			netmem = page_to_netmem(page);
> +		}
> +
> +		if (unlikely(!pool)) {
> +			pool = page->pp;
> +			allow_direct = page_pool_napi_local(pool);
> +		} else if (page->pp != pool) {
> +			/*
> +			 * If the page belongs to a different page_pool, save
> +			 * it to handle recursively after the main loop.
> +			 */
> +			page_pool_bulk_rec_add(&sub, page);
>  			continue;
> +		}
>  
>  		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
>  		/* Approved for bulk recycling in ptr_ring cache */
> @@ -876,6 +909,9 @@ void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
>  			data[bulk_len++] = (__force void *)netmem;
>  	}
>  
> +	if (sub.count)
> +		page_pool_put_page_bulk(sub.q, sub.count, true);
> +

In the worst case here, this function can recursively call itself
XDP_BULK_QUEUE_SIZE (=16) times. Which will blow ~2.5k of stack size,
and lots of function call overhead. I'm not saying this level of
recursion is likely to happen today, but who knows about future uses? So
why not make it iterative instead of recursive (same basic idea, but
some kind of 'goto begin', or loop, instead of the recursive call)?

Something like:


void page_pool_put_page_bulk(void **data, int count)
{
	struct page *bulk_prod[XDP_BULK_QUEUE_SIZE];
	int page_count = 0, pages_left, bulk_len, i;
	bool allow_direct;
	bool in_softirq;

	for (i = 0; i < count; i++) {
		struct page *p = compound_head(data[i]));
                
		if (page_pool_is_last_ref(page_to_netmem(p)))
			data[page_count++] = p;
	}

begin:
	pool = data[0]->pp;
	allow_direct = page_pool_napi_local(pool);
	pages_left = 0;
	bulk_len = 0;

	for (i = 0; i < page_count; i++) {
                struct page *p = data[i];
		netmem_ref netmem;
                
		if (unlikely(p->pp != pool)) {
			data[pages_left++] = p;
			continue;
		}

		netmem = __page_pool_put_page(pool, page_to_netmem(p), -1, allow_direct);
		/* Approved for bulk recycling in ptr_ring cache */
		if (netmem)
			bulk_prod[bulk_len++] = (__force void *)netmem;
	}

	if (!bulk_len)
		goto out;

	/* Bulk producer into ptr_ring page_pool cache */
	in_softirq = page_pool_producer_lock(pool);
	for (i = 0; i < bulk_len; i++) {
		if (__ptr_ring_produce(&pool->ring, bulk_prod[i])) {
			/* ring full */
			recycle_stat_inc(pool, ring_full);
			break;
		}
	}
	recycle_stat_add(pool, ring, i);
	page_pool_producer_unlock(pool, in_softirq);

	/* Hopefully all pages was return into ptr_ring */
	if (likely(i == bulk_len))
		goto out;

	/* ptr_ring cache full, free remaining pages outside producer lock
	 * since put_page() with refcnt == 1 can be an expensive operation
	 */
	for (; i < bulk_len; i++)
		page_pool_return_page(pool, (__force netmem_ref)bulk_prod[i]);

out:
	if (pages_left) {
		page_count = pages_left;
		goto begin;
	}        
}
    
  
Personally I also think this is easier to read, and it gets rid of the
'rec' function parameter wart... :)

-Toke


