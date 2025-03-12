Return-Path: <netdev+bounces-174080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA2A5D5B6
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDDA3AB106
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 05:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433D1DB124;
	Wed, 12 Mar 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p5WolXg/"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68033F6
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758494; cv=none; b=i2rf0kBJG53wUjLeiE6s3MxZMu2e3L01YqrbY40/u1IhYb1F/dieh06NF3Bms9n/64zeoig3U2txS7Pvfb72vx8xMCOic2s+bQJ3kekoXDHYgpRo/UxC/e4MeNqZX5JkLp02N08uk8xMX/xVo12fqnrsHl3l0uRUEWaAy3uCaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758494; c=relaxed/simple;
	bh=jdvB7G+B+hSY6QZdcS9h74i/g4HKrArNza0b+mU9icE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW0k2Iur58HEK6RJRkaRgKh1uC0xA6hGsqZNsgPJQcsxVSKEeBFn07a877ZY0wt1+ART8x4T9/Qx+zQOoM0ARGguynEt/+uXiAvLPb+B38AHZMKtSA8QTPhWNdIUSH7C6vSKLNctjdohNiqMCpL2X59EtNlOAk8Q0UKpCPd/25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p5WolXg/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kLGKLRJCoEeclR7VoCYrhU0Cfj/El2Bt99Hj4o0aaZU=; b=p5WolXg//w8g8og2fh15f3tUlZ
	j6IGcOybc9MgFxon9oWNM6EJBrK1RG3BLqb2X6k+iVYQdQwZm2abx7VY/ooj3LjgS3P/idlvorCso
	tSSW+2HxvAOQLXna0QGgphvZylHdHUMm70y87fAoraZ6N/+Y6pXKghVySl1JjojeqYRzBrvCEXZtS
	wpPTCpYwk4rNo1XMaEFQvZUBjYJsv8dvsbEtixlJmKpKnqJdEPEQOHTUizoHZdFffku9UBQAmTfBy
	oStGxSNiCs/wdyuv1znzA4Kt005iE3aUIcxv/4NAdsOT5gG+X0r6jkTWlJ3lSPdPptCL0J/x0+5Bs
	DlpkwGyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEwt-00000007Xhl-1U8O;
	Wed, 12 Mar 2025 05:48:11 +0000
Date: Tue, 11 Mar 2025 22:48:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z9EgGzPxjOFTKoLj@infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
 <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
 <Z9BsCZ_aOozA5Al9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9BsCZ_aOozA5Al9@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 04:59:53PM +0000, Matthew Wilcox wrote:
> So I have two questions:
> 
> Hannes:
>  - Why does nvme need to turn the kvec into a bio rather than just
>    send it directly?

It doensn't need to and in fact does not.


