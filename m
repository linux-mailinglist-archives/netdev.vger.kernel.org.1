Return-Path: <netdev+bounces-173940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824EA5C586
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66670189AEC4
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3403C25DB0D;
	Tue, 11 Mar 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="toa2+2Rt"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F01C3BEB
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705942; cv=none; b=AFut2NvIbKWlb0l8nCqh6gXUKhKz42g/QjiDwVUjglKkt1Hx6fX2lNnmBbLW8HO1khTeXx1El6O3pU7JGFcvgRAOzsrj6AyEN73JO95p+Urp+kw3OzGaGyX97DDY93HOJL+ahdXPl7Wugs+P7NRRAMkvzNQj0mdqsC3AVQn/onI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705942; c=relaxed/simple;
	bh=2zOC5U0mjgipDVNzo08qHxVCRR/I2HojojdOf+ynufQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf9TB7kcAsrsoLR0/rHYh4OPnE/cHUHyAcVg6kH/24k9zMiJe08yXAZzm2gB1ljMG7SE8Fd3KEeFkprWkf2E06+AmrFjRPm5hfkLbrLYZRj7f/yMZavWOAodmMRBVnIgu6KsLAh0KZqN/Xdfn/stRhcC1m4LFXZVW2jk77w6YSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=toa2+2Rt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vmHrb0b24qlyWrlqCdDj4UGq4nq9/s6Su9V1a9JlSO4=; b=toa2+2RttopItVIdFS/UqMj7dZ
	y2J7Xr77rRqURBhWbPDwlckYlaxzLUtpCiGA1bre9o/XBJGGAUFxlMji+ppmLd7fFHo1jTetTnWtv
	ye74EjPgi7lGi2Zm+XvONJoGzxxTH2YhEDlUnGiCTg3i0RWlx77/HSt5t1lJmoNoAZBz91Y+3eGEZ
	dfWWnEGCCm1GRKPUdrttP5YJFuUs/ZQoa3UYT7vlgVNLcE7U/g1A0KwacrL/5t90TN92j0YC470h1
	24w0a24jK9qGBqA76KOZnIcNoWrRkwsaBAIqp7BcecKskEUEZbrFfLVWKbk4iIeIv/Tu7BUOJIito
	+qgGO8KQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ts1GJ-00000001vOb-27i7;
	Tue, 11 Mar 2025 15:11:21 +0000
Date: Tue, 11 Mar 2025 15:11:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Yunsheng Lin <yunshenglin0825@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Mina Almasry <almasrymina@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
Message-ID: <Z9BSlzpbNRL2MzPj@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com>
 <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
 <c6ef4594-2d87-4fff-bee2-a09556d33274@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ef4594-2d87-4fff-bee2-a09556d33274@huawei.com>

On Tue, Mar 11, 2025 at 08:25:25PM +0800, Yunsheng Lin wrote:
> > struct page {
> > 	unsigned long flags;
> > 	unsigned long memdesc;
> 
> It seems there may be memory behind the above 'memdesc' with different size
> and layout for different subsystem?

Yes.

> I am not sure if I understand the case of the same page might be handle in
> two subsystems concurrently or a page is allocated in one subsystem and
> then passed to be handled in other subsystem, for examlpe:
> page_pool owned page is mmap'ed into user space through tcp zero copy,
> see tcp_zerocopy_vm_insert_batch(), it seems the same page is handled in
> both networking/page_pool and vm subsystem?

It's not that arbitrary.  I mean, you could read all the documentation
I've written about this concept, listen to the talks I've given.  But
sure, you're a special fucking snowflake and deserve your own unique
explanation.


