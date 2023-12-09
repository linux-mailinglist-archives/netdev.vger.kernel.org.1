Return-Path: <netdev+bounces-55513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD75380B17D
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F4528184D
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08A80B;
	Sat,  9 Dec 2023 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTBMK6I2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFA7F8
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76566C433C8;
	Sat,  9 Dec 2023 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702085897;
	bh=Zb4W5U81zr9iBTuDWuPtvrYzyuDkADvK3X/33n9Wz2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTBMK6I2Qo22ZCH4loWVlOpI6nj2/x0LsQ/pcbnevM1+AQvfqXACDdbvX4osdUCzx
	 JKRJMKgSWFI7z5CPzgFiTcEB+Um7vJIzzQMwMpyzj+pzDT9jw/wY8a3rcvbBz0Dpk0
	 NCDc6IiBbqCEwlO+FdCsdj/ZaqOK5WlWXU8RkDel7GR/G4+8qbtMXHTJlyzaEzfrwS
	 Uzqo9uilwoD9cE1aQUn7gvSkO2aWgTocbuo+Jf7C7DwchMqJ+0Nei/dpq+cps4rRk7
	 RilhL24T1iSm38pYbdRtRq6sg4pIVu3uHTZQiDwNngI1a3nhHE2vwUrDVX9WtbgZxH
	 qf6GK95BckxvQ==
Date: Fri, 8 Dec 2023 17:38:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com,
 netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Subject: Re: [PATCH net-next v7 1/4] page_pool: transition to reference
 count management after page draining
Message-ID: <20231208173816.2f32ad0f@kernel.org>
In-Reply-To: <20231206105419.27952-2-liangchen.linux@gmail.com>
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
	<20231206105419.27952-2-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 18:54:16 +0800 Liang Chen wrote:
> -/* pp_frag_count represents the number of writers who can update the page
> +/* pp_ref_count represents the number of writers who can update the page
>   * either by updating skb->data or via DMA mappings for the device.
>   * We can't rely on the page refcnt for that as we don't know who might be
>   * holding page references and we can't reliably destroy or sync DMA mappings
>   * of the fragments.
>   *
> - * When pp_frag_count reaches 0 we can either recycle the page if the page
> + * pp_ref_count initially corresponds to the number of fragments. However,
> + * when multiple users start to reference a single fragment, for example in
> + * skb_try_coalesce, the pp_ref_count will become greater than the number of
> + * fragments.
> + *
> + * When pp_ref_count reaches 0 we can either recycle the page if the page
>   * refcnt is 1 or return it back to the memory allocator and destroy any
>   * mappings we have.
>   */

Sorry to nit pick but I think this whole doc has to be rewritten
completely. It does state the most important thing which is that
the caller must have just allocated the page.

How about:

/**
 * page_pool_fragment_page() - split a fresh page into fragments
 * @.. fill these in
 *
 * pp_ref_count represents the number of outstanding references
 * to the page, which will be freed using page_pool APIs (rather
 * than page allocator APIs like put_page()). Such references are
 * usually held by page_pool-aware objects like skbs marked for
 * page pool recycling.
 *
 * This helper allows the caller to take (set) multiple references
 * to a freshly allocated page. The page must be freshly allocated
 * (have a pp_ref_count of 1). This is commonly done by drivers
 * and "fragment allocators" to save atomic operations - either
 * when they know upfront how many references they will need; or
 * to take MAX references and return the unused ones with a single
 * atomic dec(), instead of performing multiple atomic inc()
 * operations.
 */

I think that's more informative at this stage of evolution of
the  page pool API, when most users aren't experts on internals.
But feel free to disagree..

>  static inline void page_pool_fragment_page(struct page *page, long nr)
>  {
> -	atomic_long_set(&page->pp_frag_count, nr);
> +	atomic_long_set(&page->pp_ref_count, nr);
>  }

The code itself and rest of the patches LGTM, although it would be
great to get ACKs from pp maintainers..

