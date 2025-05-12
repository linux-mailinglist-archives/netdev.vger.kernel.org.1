Return-Path: <netdev+bounces-189635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9BBAB2E5A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 06:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35C83A58C7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7938424EA87;
	Mon, 12 May 2025 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IknVuQA3"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93621411DE
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747023886; cv=none; b=TBfrFzx3FqrOdVkru3B7mA2xiyB8mLcgK5WuRU+FNUKJ0hhOt8eUpPeFrvIFKiwrstVGtm4GKQFIT0e2DcGzkjiJBu/UmGCk7vR9YdA+ckGSIz5tYbce8qutPlVpe4bFFDRnkQMgJ5kUJS3p27ETCmjVbGsVjglUOEvdkeOvOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747023886; c=relaxed/simple;
	bh=PJavjRWOpdACPSdJOLRdx5a3PHn5fJQp3edx2xrkSbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWY0jXx0gL6IgicoM5IL4Kx0NmApRBLSddts7rv1wNt+zLmqkXJH7cYyNuqPfoFejpLBld6hdte8lfhqWA+EWH48HXqHbZIYljKNIEe9C/W6yvklxlSgSrjDnBRwXgDrSYtRPKaakFUct5N4N94RMC6CFrbk+Se/SZzBBcGMhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IknVuQA3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qC9e38yOBZPe5pOACVwKPnNvAHgjR/ZBlShq6j7WTag=; b=IknVuQA3bofq78chLGBVguILEK
	Eq5WZPcPxZFj51BBLYvMwVTJuPcVNFbc5UQkpWk2i0uGsvUomKIrMc4p4wKne3m+pOlqyBYa3TQg9
	q+9sbdyNCBtaogyVvdEEHWJM0EDGfMejH5hGwnDu6Rp6nMy94RBFadLaxMEmQVkZL38hOwPU35o/c
	seg+t3BoVLVbRZuqbT7O2qbndbzhuPq66Xms2tW2i8LpqfWvvGfzZA/EXArTvBOeVSbPyzNbt1bjf
	e1/2QvbpE9TbBhvSBKjsm97XFAM+tNy4vL/3qyO2G5ssQ45pFm5QC5UafPpcACyzXnYofcKheUowR
	W2ZnPcvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEKiU-00000008Kks-3XKM;
	Mon, 12 May 2025 04:24:38 +0000
Date: Sun, 11 May 2025 21:24:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Byungchul Park <byungchul@sk.com>,
	willy@infradead.org, almasrymina@google.com,
	kernel_team@skhynix.com, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	hawk@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] shrinking struct page (part of page pool)
Message-ID: <aCF4Bm-2cpU__QDA@infradead.org>
References: <20250414013627.GA9161@system.software.com>
 <20250414015207.GA50437@system.software.com>
 <20250414163002.166d1a36@kernel.org>
 <CAC_iWjKr-Jd7DsAameimUYPUPgu8vBrsFb0cDJiNSBLEwqKF1A@mail.gmail.com>
 <c744c40b-2b38-4911-977d-61786de73791@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c744c40b-2b38-4911-977d-61786de73791@lunn.ch>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, May 10, 2025 at 03:53:47PM +0200, Andrew Lunn wrote:
> > Random thoughts here until I look at the patches.
> > The concept of devices doing DMA + recycling the used buffer
> > transcends networking.
> 
> Do you know of any other subsystem which takes a page, splits it into
> two, and then uses each half independently for DMA and recycling. A
> typical packet is 1514 octets, so you can get two in a page.

The mm/dmapool.c code is all about this.


