Return-Path: <netdev+bounces-174079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC67BA5D5B4
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC90189C766
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 05:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0821D515A;
	Wed, 12 Mar 2025 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/EKia1H"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123A1C32
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758449; cv=none; b=IzlxN2prQSUNNjfW0zzCGPYN4Q2dt+n/zdCFA9V+YdGpooG6WTWtU8MD0+EuoKuAlKSJisJvLu3GFI3mVNcpEGaemm8ZL7Cm+LVEOLxWYIdF7GVF1FRvpqH0vGcMaXIQ7iHQmrOEImuc+8CV8VEnbdebFQIOr79Y3YC4iqZHCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758449; c=relaxed/simple;
	bh=Hh2h29SUQ+x+D0lILZn4mOfgmnoQUq8RXw0WIv905Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtoFA6flkskxiXYUL2aAHfzp/Xg4g0cseE6Vy//hIHK/dWsldtAhsKCQvBhWgQM65fvq1/zhbbtigJ0/FWWBG8HnZt+d+l0yYKavhOjIjzTVTlewpUuNspSscVnclXQKPSpxVr4rKipzYr3H+Y04UwPyJxUfQosLG7ai1/3BG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U/EKia1H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d2aVYY6sXDxPbMJYVjYwVnG/5yAVcTKEEf49trOd3nY=; b=U/EKia1HrMhvMT2TTA74OyHqFy
	Ur9FgqMiSxT6l4wu6WCRgTCOQd+GVFrSc85Qjhp4PhKm0LEnM4mk4XUviM+eLWc5CZWD6G0D208vb
	N7bf3fXsToiNCrJSw6n4MibOlxq24zw9z7bFTS++IBDaXtUeEEw9VYTRwSzr4Ag/cufS9C0c6Ewqz
	MDyMtJto0poA/Q6MM0bU7U09pyKavZ/ADJseb8srav5MbtGX2G/v/OVwttGisVE9mF5kMEoYi6G6b
	WssQJzTqQasL0Dct/ocH0RAdFD9PENz3N++e3CipkFWijRFm6+EoHe9QshtSZV++B2i3EtJmkwkgl
	O5W2UgHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEwB-00000007XcK-0uen;
	Wed, 12 Mar 2025 05:47:27 +0000
Date: Tue, 11 Mar 2025 22:47:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z9Ef75c1ffTWGU_c@infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311111511.2531b260@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 11:15:11AM +0100, Jakub Kicinski wrote:
> On Mon, 10 Mar 2025 14:35:24 +0000 Matthew Wilcox (Oracle) wrote:
> > Long-term, networking needs to stop taking a refcount on the pages that
> > it uses and rely on the caller to hold whatever references are necessary
> > to make the memory stable. 
> 
> TBH I'm not clear on who is going to fix this.
> IIRC we already told NVMe people that sending slab memory over sendpage 
> is not well supported. Plus the bug is in BPF integration, judging by
> the stack traces (skmsg is a BPF thing). Joy.

slab over sendpage doesn't work because you refuse to take the patches
to make it work by transparently falling back to sendmsg.  It's a giant
pain for all network storage drivers caused by the networking
maintainers.  The ultimate root cause is the fact that networking messes
with the refcounts.


