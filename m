Return-Path: <netdev+bounces-228959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94263BD67B1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E276019A1F6A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB830EF98;
	Mon, 13 Oct 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KTGXnn5K"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4D2FC88C;
	Mon, 13 Oct 2025 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392599; cv=none; b=gDSuEiG6XxO3f2BwZYJQwb0M6ZT63VtieLU3B0zU8/4ybFipNOMipunFgjjLUysKIReqFlo35TG7+0n75qzOJlikVRhk18MWQqkYBz3vB4ZdxuBxwnERF0lLXFzMOkc9j8cd8Jbexr8Rk7j5iPwwtOQVqU/Oofk/T0ElMrxdVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392599; c=relaxed/simple;
	bh=7KH7YmXKkp0g9IvgJqUrV7q+QZ/U4/HxzCC5Tip9fNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0y+mU154gLRNRkgJPOKTPWoJFPE64qZ2tmVhisLtGoPRabdg3564UM1nqm9qMk2qPFn+a9Oir3KeGwMakxB1D5o7qhE4uSkrEGSdmrwZSP3Y8KGGmdmNd6NxdgLSVbWjDUuR6tRUbgdXU/NnPTvrd5ZduXYidhrZ5eIyIXRPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KTGXnn5K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KhCn2KSyb7tmfiec5a5x+4NLc4rqOdPBeGr9lcN4QSI=; b=KTGXnn5Kkh8GuuVZ+yDqB/nMp7
	9qZbgtKKrXNedzKoDYnX3tzZhb9uDwdn2hMcprdjumK9Z7xg+vsBopb8QwAE77Ef9qWG1KrcoXtPW
	aUeK5DzGTpXGXz3SK6b2RMWtU76iQpbXrOFtDgTeXt2eLbt2bcVyg+qWrO670+aymw9gY9dbxP621
	feLZAf8tsnqlFpxBWRjO1BcZsP1VQtFs4DdvnweBQnZ3koCzLa1eFms2i0JtsMshkbVDRQq7bcIEP
	CaAiPgNmXtRwt0hLxXjKE4A2ePhFjxgjvsmEbyBLF7eCUVT9Zm7CDlOYOEWi0Ou9C0Jf3JiE6SBeJ
	l4IMOG2g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8QWs-0000000EcRu-2ayi;
	Mon, 13 Oct 2025 21:56:30 +0000
Date: Mon, 13 Oct 2025 22:56:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Huacai Zhou <zhouhuacai@oppo.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <aO11jqD6jgNs5h8K@casper.infradead.org>
References: <20251013101636.69220-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013101636.69220-1-21cnbao@gmail.com>

On Mon, Oct 13, 2025 at 06:16:36PM +0800, Barry Song wrote:
> On phones, we have observed significant phone heating when running apps
> with high network bandwidth. This is caused by the network stack frequently
> waking kswapd for order-3 allocations. As a result, memory reclamation becomes
> constantly active, even though plenty of memory is still available for network
> allocations which can fall back to order-0.

I think we need to understand what's going on here a whole lot more than
this!

So, we try to do an order-3 allocation.  kswapd runs and ... succeeds in
creating order-3 pages?  Or fails to?

If it fails, that's something we need to sort out.

If it succeeds, now we have several order-3 pages, great.  But where do
they all go that we need to run kswapd again?

