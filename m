Return-Path: <netdev+bounces-189784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9949AB3AE7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D4E188EF63
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB222A814;
	Mon, 12 May 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bESkWilg"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F501EC01B;
	Mon, 12 May 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060992; cv=none; b=mopn90uYBuvQOaHXoYcbVW9rcSVEVOlF5oYqoKbSUbSUzYJDfaKd6aljsyDOtR7r0l1UWAoZ1FbsFJCIttsF818Wle43biH+9Vjssrg8Bxp/vFuIK1eYfWuAxodKlAp6/qZPdbBKc+U/8UoxkowD2YhGs5qHgLYX5BF5k/LYa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060992; c=relaxed/simple;
	bh=uxSqh2KDm7g7YScPIYnVv/JvZ9TthkoVVYWYqyE/H8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdMbiLxjPik14BqBWVuvYyc/3Ht3i9PLytsZKRp0r3Djj7B0PLZL+M5TrVGofFKL/62U2qvBPsAsjY7yRGhBM4ihDQNPrYNG1gTWRONjIFPFtgcly2aCa3usgX9hi/Hphpxq72UV+95TlIEFuJY1l3ofqwxGWBfZ/l7tb37pFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bESkWilg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RA4ZhlJxbF9rcGrELaX/6RyxDDskOy/w1PeoiSu7p8c=; b=bESkWilghaOyeKKlfazFm68bHC
	IuS9HHExWJXKpfs4v+8oeQXiG0tP156firhDw4pzL0/xqJTsgMqasBO7lkzHOU8Qm6v7QQEbIZjWz
	5VN9bi+/CqoucPd24rUm/hLSQ5G1V5hQPkpQueCg51WAFygFXD1XVdY/xI/UmHgtxVdqopyXPfFFW
	FUomD/AYC7pX7EIWnq0fn+9AULDMEPNpGAEk01LvClV4ilQvnngbLgjt0S8rWMdOb8Pg0u8y8oXOL
	CVLofVfcbTC8Dqv5NqFwQEk/ckAkvApUcSc90/bQcmTtWCrCCYLOCgDOVZTdhMXGQWdNt8o/MeqEj
	+t8fMLQw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEUMo-00000009xQm-3PKL;
	Mon, 12 May 2025 14:42:54 +0000
Date: Mon, 12 May 2025 15:42:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct
 page
Message-ID: <aCII7vd3C2gB0oi_@casper.infradead.org>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <aB5DNqwP_LFV_ULL@casper.infradead.org>
 <20250512125103.GC45370@system.software.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512125103.GC45370@system.software.com>

On Mon, May 12, 2025 at 09:51:03PM +0900, Byungchul Park wrote:
> On Fri, May 09, 2025 at 07:02:30PM +0100, Matthew Wilcox wrote:
> > > +		struct __netmem_desc place_holder_1; /* for page pool */
> > >  		struct {	/* Tail pages of compound page */
> > >  			unsigned long compound_head;	/* Bit zero is set */
> > >  		};
> > 
> > The include and the place holder aren't needed.
> 
> Or netmem_desc overlaying struct page might be conflict with other
> fields of sturct page e.g. _mapcount, _refcount and the like, once the
> layout of struct page *extremly changes* in the future before
> netmem_desc has its own instance.

That's not how it'll happen.  When the layout of struct page changes,
it'll shrink substantially (cut in half).  That means that dynamically
allocating netmem_desc must happen first (along with slab, folio, etc,
etc).


