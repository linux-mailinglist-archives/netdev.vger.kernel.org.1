Return-Path: <netdev+bounces-173618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B038A5A2EA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E281888B27
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C048233724;
	Mon, 10 Mar 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m6tqfjmq"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18822CBE9
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631319; cv=none; b=Jh/5n0CDhQCRTJfVRrBQZJKOHR40LsKhKPfXjZ4yjMVorzmJg+DFpDOXo/EoWUSdSVBzpVKdWk4I6BS0F+1bP4XftZfGaxcq46zg5F6nCJa74tCYyDZ9kZDZVNH4+bMqpSY7eWSydI5gKe7oarK4rDEJYa6YKtsUSRfobh5qssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631319; c=relaxed/simple;
	bh=1Lr2a5VjOKP0mnYdG4oSqaGCZ4GhoYDZjH7Vd3O+/z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G39L/Hd44mXW/JYDvJ0EuES56qSMOAGXXGIJCAiA37vZG2M1L8KV22HglxzWQky79CDXfUgnaZuxgl4G6wRwt9vSAxVFtlEfoMZDKLMxa/0OjWEcWjb8JBJTKT33QnxTHOdYIpTkb5cFWg9i5gSJCECK0xxVZssxHwY9c7Y7MME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m6tqfjmq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i9IqTrn9F8WIrjAwdTUnyDnHxdWJ+KdDCOlyNwgiA7A=; b=m6tqfjmqfczObV3yLT2uXiI7jp
	W9BJScDoc3+JoBseU16BkWdzfvhbxjsC2DFN2EJwK0k8s68qPPj60XcNBN+EvYCeqtQzFaK69xujQ
	nGqz2qe0VwSet9eEhWLrlLEkLD9nhNqqQ9pQbXWE2aoKGNobVrmw0uiJ/Pg4QzpOgzWOwpitbmMc+
	ervrckj/hH9k5iflKsJXO1BTn9Fooz56Ags5rhrtFY4QEcudlxr5uldioaED6DJTKQY2vjeDzNkGi
	lKQ+t+obMzB6Esf9rAnn5tS56xATftaMgal2IbnH/SCBG5xlCM5gB1LA+Qqs/p+nZ2pWV7R3OOiPN
	hQagk3SA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trhrd-00000008tGI-1qLx;
	Mon, 10 Mar 2025 18:28:33 +0000
Date: Mon, 10 Mar 2025 18:28:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: netdev@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z88vUFweLyk5s8UD@casper.infradead.org>
References: <20250310142750.1209192-1-willy@infradead.org>
 <77fa8d7e-4752-4979-affe-aa45c8d7795a@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fa8d7e-4752-4979-affe-aa45c8d7795a@suse.de>

On Mon, Mar 10, 2025 at 05:57:51PM +0100, Hannes Reinecke wrote:
> On 3/10/25 15:27, Matthew Wilcox (Oracle) wrote:
> I assume we will have a discussion at LSF around frozen pages/slab
> behaviour?
> It's not just networking, also every driver using iov_alloc_pages() and
> friends is potentially affected.
> And it would be good to clarify rules how these iterators should be
> used.

Sure, we can do that.  I haven't conducted a deep survey of how many
page users really need a refcount, so I'll have things to learn too.

