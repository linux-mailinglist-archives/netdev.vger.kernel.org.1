Return-Path: <netdev+bounces-174459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675F7A5ED1B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31883A7451
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065F1FC0FD;
	Thu, 13 Mar 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7v7YufW"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303F13BC3F
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851392; cv=none; b=G+Iqf1njoaClhGUKLUDalb/uJsHfWlyGE1ZJxG8dd0S743Ft4rUQ51xJ8FIBmV8j7elVHU8AzBQN0r6UMTcCpApbv+KQ9M4Xk2ursd7lBbkQd9vAKQsFZVIhyoFhnKLngVqmas8faD74GA+8cx3YQSLR+r9uGg0TAs4US15pgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851392; c=relaxed/simple;
	bh=RWkwYtzAIUj1du0PFALShvHIzkZHM1xnk1UXtJxOehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUtg+t7VL2LQ8WRmYFWLQqjtD5MTGaOs/te+IwSRX6jLMnmgubKTFk4QAQZ5+JskxDdvewpABSdfSKMYIl9Hb1+jMt4f/N7AIokoyGVbiPI1CDfTAVt7gRZydb9yGp8YSLWN6gijTiJIYJER+0hoAMskFlnXDZOo8w0GPeL8xJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S7v7YufW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=adVMyEKDHlK9ZEcO8p3E8a9SlKk/oifJ9PPfTaa+lzw=; b=S7v7YufWR0c8vkTn7ndDpkiw0V
	p+zT/slKZRqYj/abHLAmaj3tQv0rVh+y4ByeZkxdlwh33j9F+Uhdf3rE3i+Bzf7Gg98BNHik82vLd
	nFuctkrL8zzZYJ7Fe0X3ZrJVCk6xebeyiZwiXbCKMdvgBwhoAoSFS4cspPxDjTvzIv9ZEIRKH9oUh
	mqaTpVkfC6gxpwk+CDB+MllAP2AkudLdFT9nKUoYeT+s3UHVUwmy2dhzXI0vtRr/shZSPOkova4y+
	GzLiF43E2ufzyqO7z6yAiUU9oBFwSBetW8SB6PSbFFKYVrUoJaBbn7huhiMQTtCHVJfRYuvIfXPpS
	B5LDEd0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsd7C-0000000AOso-1Qt4;
	Thu, 13 Mar 2025 07:36:26 +0000
Date: Thu, 13 Mar 2025 00:36:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z9KK-n_JxOQ85Vgp@infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
 <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
 <Z9BsCZ_aOozA5Al9@casper.infradead.org>
 <Z9EgGzPxjOFTKoLj@infradead.org>
 <9af6dff3-adce-40f8-8649-282212acad9e@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af6dff3-adce-40f8-8649-282212acad9e@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 08:22:01AM +0100, Hannes Reinecke wrote:
> On 3/12/25 06:48, Christoph Hellwig wrote:
> > On Tue, Mar 11, 2025 at 04:59:53PM +0000, Matthew Wilcox wrote:
> > > So I have two questions:
> > > 
> > > Hannes:
> > >   - Why does nvme need to turn the kvec into a bio rather than just
> > >     send it directly?
> > 
> > It doensn't need to and in fact does not.
> > 
> Errm ... nvmf_connect_admin_queue()/nvmf_connect_io_queue() does ...

No kvec there.  Just plain old passthrough commands like many others.

