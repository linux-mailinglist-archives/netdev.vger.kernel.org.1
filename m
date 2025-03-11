Return-Path: <netdev+bounces-173970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55289A5CB14
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7023B8EAB
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0D325F987;
	Tue, 11 Mar 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBB4De6x"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92725C6EF
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711621; cv=none; b=rfwe0sNQ13FYsp2UdLjJj298xHI0nDQ3sm5aPuBsyAzyN08Xq8GxFU5gsWwnJAShqBm9lepVL33ovLRTpngAMBvfr9dz9ofNyVxRCUZwh2ZOwiCk6+VtmOKG7WpZwHlBH/VvJTg1Yq9+o1SNvr6QbKYCx8wzApOBiw8ABcXvpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711621; c=relaxed/simple;
	bh=uSMaVwgCiR10xZmS8tEHvMoeawuXN+2ERsjeV6fDh04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULL374LfM2XoPegmLAFSHxFJZ3Lzkva3rq7vVIPipADD69igRNaKrTWSgl1CMe/QPRGFY0Bdkn2E4cU0qgUnXTzht3Tj2qXgYF1SwtmJM2YzWitA6zjDFwxzjoRGyMmvqxQyTv9XHTp4rZyLEvEdU0SjaUE+3GY2ta4U5hwyHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FBB4De6x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MRtGxHdLKuVz+JB4WLbiMPKXHh6E0eYVmxLx4Nvz/lA=; b=FBB4De6xnCCyhjtglF3CkiyhT+
	3pei2JOli9l7iIy80Rm9kTFNhTsr8hvN6orDt2zXAee/7OvF5TFCBLLRl/mc51Q1MD2VOEhP7H2fS
	bwnUsPwCxqkVgQktSbjT6RnrexnoiIUtOMIOpE1V1c3vNRa0fltt/1gKLTUN6CxJ1MsZw7T6neZch
	SLLRXVd6HJzrNreXBlPWEWImd+SBYU4umBF8mokoZzvHBcltzizRnhsiE/NSx2CDRFV6+ehpyO4CB
	govgul4lFZEr/1wp9m5opL/BMv/JOWMf+j7b+Wut8DY1jLToY/NPIRayBgAW3+e8r50oP0NUedqGU
	C+iN98pw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ts2kg-00000002diG-1Wt0;
	Tue, 11 Mar 2025 16:46:48 +0000
Date: Tue, 11 Mar 2025 16:46:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
Message-ID: <Z9Bo9osGdjTWct98@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
 <87cyeqml3d.fsf@toke.dk>
 <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
 <87tt7ziswg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt7ziswg.fsf@toke.dk>

On Tue, Mar 11, 2025 at 02:44:15PM +0100, Toke Høiland-Jørgensen wrote:
> Pavel Begunkov <asml.silence@gmail.com> writes:
> > If we're out of space in the page, why can't we use struct page *
> > as indices into the xarray? Ala
> >
> > struct page *p = ...;
> > xa_store(xarray, index=(unsigned long)p, p);
> >
> > Indices wouldn't be nicely packed, but it's still a map. Is there
> > a problem with that I didn't consider?
> 
> Huh. As I just replied to Yunsheng, I was under the impression that this
> was not supported. But since you're now the second person to suggest
> this, I looked again, and it looks like I was wrong. There does indeed
> seem to be other places in the kernel that does this.
> 
> As you say the indices won't be as densely packed, though. So I'm
> wondering if using the bits in pp_magic would be better in any case to
> get the better packing? I guess we can try benchmarking both approaches
> and see if there's a measurable difference.

This is an absolutely terrible idea, only proposed by those who have no
understanding of how the XArray works.  It could not be more wasteful.

