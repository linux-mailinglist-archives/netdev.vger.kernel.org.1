Return-Path: <netdev+bounces-174469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C49A5EE43
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E75F7AB673
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DE261571;
	Thu, 13 Mar 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9ugxHfA"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E826156B
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855478; cv=none; b=h7bP3qy91as8+k7vIpQ7mRmSDukuYTcceucC8yJvBbSDMSUQkKhwgJSMTB9uMfWkmr8pN4HBuOatm2wBspPa7/aqLV+cWPx6tDsOJu/bLKhKuA3r9HGVF6XDZXZFFKESdJPySWdYQq/HZVM880bxxVro1Wdunu2Ca8eLOZo3/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855478; c=relaxed/simple;
	bh=pjhXZ5mkdKGtF7dOyIO0Xl30xgfDbOJ2tgP+dlGEawg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2wz3urFWh3nADRD7C1bmZF7Y+hIyCzCuWakqD5FHummQ/jN097vI45dmcKt9dA+jY5BpqCa8/jNgyuWfl5gN7JcslDo1fYWCDB668v6JA3Shbr0XQLPc66wb3L5KIB8V1NKdOjKv0ptUGysz91XRmX/e0TDNn1qYWfMsU6CWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O9ugxHfA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J93E6Vw3VK+dqosx/C38S2yEZoCxKiYDJPynkA042n4=; b=O9ugxHfAgY3WEudjUwN0Ar0xeU
	TbQNuDG9GefuP6cngv+wsY6/MzAfDSdqFiTuFFHLWP+l7kE9W2/W556UQe82tzHSzdY1jSk/Z0tuT
	W4h048ZXziXn9X3yWtR28bPmcZ5/O1+ZVTZM1BQLbgfCgBnyXvDp+S4xreX5JVpY1/mE5L/AA7Qsx
	nPMk4TlVD6/3Yo+5/ZyRPj1ZATrLoaqAGFQHtKqzeoNlatq5xVsjj6jOCdLGV9hCGu8phkz5p2e+D
	xqYlKFgxMEWuwZjK5sEMIWNwbA3CZYdvkFHWejT5KWGmM3wDf6FxCKjGUdGcAMJg3LkpHxvGIDJYJ
	yCZf1EQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tseB9-0000000AabG-2B0j;
	Thu, 13 Mar 2025 08:44:35 +0000
Date: Thu, 13 Mar 2025 01:44:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z9Ka8-aGagGH0rd5@infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
 <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
 <Z9BsCZ_aOozA5Al9@casper.infradead.org>
 <Z9EgGzPxjOFTKoLj@infradead.org>
 <9af6dff3-adce-40f8-8649-282212acad9e@suse.de>
 <Z9KK-n_JxOQ85Vgp@infradead.org>
 <17f4795a-f6c8-4e6c-ba31-c65eab18efd1@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f4795a-f6c8-4e6c-ba31-c65eab18efd1@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 09:34:39AM +0100, Hannes Reinecke wrote:
> nvmf_connect_command_prep() returns a kmalloced buffer.

Yes.

> That is stored in a bvec in _nvme_submit_sync_cmd() via
> blk_mq_rq_map_kern()->bio_map_kern().
> And from that point on we are dealing with bvecs (iterators
> and all), and losing the information that the page referenced
> is a slab page.

Yes. But so does every other consomer of the block layer that passes
slab memory, of which there are quite a few.  Various internal scsi
and nvme command come to mind, as does the XFS buffer cache.

> The argument is that the network layer expected a kvec iterator
> when slab pages are referred to, not a bvec iterator.

It doesn't.  It just doesn't want you to use ->sendpage.


