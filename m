Return-Path: <netdev+bounces-173971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE6A5CB7F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC64189E921
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C12620C3;
	Tue, 11 Mar 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nwl9tH17"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B426139D
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712399; cv=none; b=rnudePhBQNb6aspM1Pw15bbBby8memIElqtNqAfj6bZvHT+iHh38RJs9kKBLRPuyoa7jn7QVUhMHKklG5e+3RotU4VJFEKMAkLfG+IXe9biKpPHKsUHUWCFrca9v28/0YPfSGVOCjekGs5P9eH+2iOOkG94cF1JTxwYxlHkwF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712399; c=relaxed/simple;
	bh=20N9bES2vKfLIkZo7SSOElbszkh9FzpAbWNR+r44PMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWJ7aIXZzWOzwgVq3MTKIvkNyTXf/dqBdtshD34VXORA5PnKeje8Valndb9NToUzTerUxH1YZP8K65Qm/j7SIstQKf2zYT6w4Nv+4R1x1rch2A+eAKHKXHNIqyiOCxSzuKD9NvJ8KkodszU+GHCk8IF/i+wZcLMhUBK1Y4kuLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nwl9tH17; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kB0vBjwQMbAXC57N2hh4EhgT8+KTatVHUg/oZPcLv90=; b=Nwl9tH17616njv4gLKFYCBYpV2
	J5Z34e9qvqXPgyJJ8DBovI7groPT59BM4RDyTLvdIy7otln0HJKSdKKr7NbHMejgPK4nwvSpMA2Da
	jmbl7VxJn0opEDaJGR64sCMO4hIQDUQ0RxtMCagO1K2v1haK8Lg9B99coN4leG3vjUeIfdFU8iRqx
	tViPwkjKXc6zFMUZXepm2yFXeskmwV9XIoE2rtmAQTUXncWBQwsN3rx3S3QtIEU9tb86yCKigQ25m
	pV54weXVJ2DrY+LjcTaNOpf0shvaTKF+HaoNjI3sJ6KyE+MxmN4qVyYiHrlG2csFW+xl7a1pgqDcg
	CdEMUNOw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ts2xN-00000002hYK-46gt;
	Tue, 11 Mar 2025 16:59:54 +0000
Date: Tue, 11 Mar 2025 16:59:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z9BsCZ_aOozA5Al9@casper.infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
 <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>

On Tue, Mar 11, 2025 at 04:46:45PM +0100, Hannes Reinecke wrote:
> On 3/11/25 11:15, Jakub Kicinski wrote:
> > On Mon, 10 Mar 2025 14:35:24 +0000 Matthew Wilcox (Oracle) wrote:
> > > Long-term, networking needs to stop taking a refcount on the pages that
> > > it uses and rely on the caller to hold whatever references are necessary
> > > to make the memory stable.
> > 
> > TBH I'm not clear on who is going to fix this.
> > IIRC we already told NVMe people that sending slab memory over sendpage
> > is not well supported. Plus the bug is in BPF integration, judging by
> > the stack traces (skmsg is a BPF thing). Joy.
> 
> Hmm. Did you? Seem to have missed it.
> We make sure to not do it via the 'sendpage_ok()' call; but other than
> that it's not much we can do.
> 
> And BPF is probably not the culprit; issue here is that we have a kvec,
> package it into a bio (where it gets converted into a bvec),
> and then call an iov iterator in tls_sw to get to the pages.
> But at that stage we only see the bvec iterator, and the information
> that it was an kvec to start with has been lost.

So I have two questions:

Hannes:
 - Why does nvme need to turn the kvec into a bio rather than just
   send it directly?
Jakub:
 - Why does the socket code think it needs to get a refcount on a bvec
   at all, since the block layer doesn't?

