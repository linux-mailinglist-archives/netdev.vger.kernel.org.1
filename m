Return-Path: <netdev+bounces-174484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A87A5EF52
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556953AD3A8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192E41EA7F0;
	Thu, 13 Mar 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Fo9esKP"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB5135A63
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857357; cv=none; b=sKUEnnMLpPo0DnMakBeu8tZDTPa4WMlGkgVYe/yS0eQfUBQ+PQmgQbAcXauM/4x/lisW/u2DrXDsu3nCpfNvIe/plHvfYekeSmt7zBHqCe14535y0F1MlaNGJ66aBpnYbPAGFjHvaq9o0WDbm2DRPQhwkCIyrG3JhVjZXReffgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857357; c=relaxed/simple;
	bh=5ML21bJoDmXlFqnocVxxzRO4/DZ8/Plp1fYl9bRYm3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcbEIi93F8g4CCyA+xiyHVH/TfzLDNufyQz5eBY9MTJPLwddRZMC77y5mJ1//fMfdBhmCSa8FhINZfxLF8tQuI/5R+gHKEWhDQlX8ZpRGjzIg7MvJgpEA9ktza4EXsYD8xeJL+n9b0sZvJBLyteGvikTVt12PE8y10L0dKPC/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0Fo9esKP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5wSKsE3YELzEVgXy2XV3NXt81xWdZW97g6MBMlpBv0I=; b=0Fo9esKPg//YV1hia5QzvfRY1W
	qeDFnPGMzFE5M8Vr5FliM4SO1cE8e4v4SeDxP/YrBtXWGxunRkUHSmuUwYG4g5e78vmxeLdTyKT87
	m5M73EXpJdwMAr1YLZ5uAy8vkz6MieagEMJmz1TqbTT8hgRru99ZJ+nU+Si6fign9xuEC6LKM87Q7
	nruVvjkccKdaHNrMgfylxU6CegljDs9Xre3OXdXf8c/H88KiHCJRRdG3VujV9JJaFYBo7t7Sd+vlI
	rqEwGeYXi2Z9DW3fylcGIncg/IjhN66ussaATCvnXOglOd915rB2SSzWi240EWY1XEE5M07ZgBvUk
	uK3hLpZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsefS-0000000AhKI-0atq;
	Thu, 13 Mar 2025 09:15:54 +0000
Date: Thu, 13 Mar 2025 02:15:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z9KiSspCLcS7DH6J@infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
 <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
 <Z9BsCZ_aOozA5Al9@casper.infradead.org>
 <Z9EgGzPxjOFTKoLj@infradead.org>
 <9af6dff3-adce-40f8-8649-282212acad9e@suse.de>
 <Z9KK-n_JxOQ85Vgp@infradead.org>
 <17f4795a-f6c8-4e6c-ba31-c65eab18efd1@suse.de>
 <Z9Ka8-aGagGH0rd5@infradead.org>
 <5075cd03-0a4a-46d3-abac-3eda27b9ddcc@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5075cd03-0a4a-46d3-abac-3eda27b9ddcc@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 09:52:18AM +0100, Hannes Reinecke wrote:
> > It doesn't.  It just doesn't want you to use ->sendpage.
> > 
> But we don't; we call 'sendpage_ok()' and disabling the MSG_SPLICE_PAGES
> flag.

MSG_SPLICE_PAGES really just is the new name for the old ->sendpage.
Sorry for being stuck in the old naming.

> Actual issue is that tls_sw() is calling iov_iter_alloc_pages(),
> which is taking a page reference.
> It probably should be calling iov_iter_extract_pages() (which does not
> take a reference), but then one would need to review the entire network
> stack as taking and releasing page references are littered throughout
> the stack.

Yes, it needs to use the proper pinning helpers, if only to not
corrupt out of place write file systems when receiving from a TLS
socket.  But for the network stack below it that doesn't matter,
it expects to be able to grab and release references, and for that
you need page backing.  If that page was pinned or referenced
when resolving the user address does not matter at all.


