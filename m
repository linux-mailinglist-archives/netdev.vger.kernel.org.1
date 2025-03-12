Return-Path: <netdev+bounces-174313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA47A5E3F4
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57FD7ADC4B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33A255E3C;
	Wed, 12 Mar 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuEwTH8q"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064A1DE894
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805806; cv=none; b=mEbdyh0CsaX2g8xwsflyCPWXrt9erIw/zwrZPKyTl2njEWzFzr433TnU1k7WvxPA7LAHVyngC8JdcEGCBUD+QRDXjW9AEgYSNOJCJq5tkfa+aS+PNB3rpIUKHM4Nre8u/y8zwfUJUIRa0XeAHfTqUeccY42j3AgblNQCiWbIaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805806; c=relaxed/simple;
	bh=enTOxWrM7i1KApt74qYxlOVXMuYLZwKw9aPhzyTET3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7HEEzISJMV8VRZcoANNxLe4OhRUHXTaUNl3lHgNCIuITRsmIZfNP5f45wmzRj7FyMhOPNPmzLWbyZRlLUIuVt8CCSNi2XTy5D5TKgo0MbtgFxI2zRaxadbfIEE/rUrbNzv2XrTKIOsoX1e5204tytwFogtL6pugDVkadQ4CQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kuEwTH8q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=enTOxWrM7i1KApt74qYxlOVXMuYLZwKw9aPhzyTET3w=; b=kuEwTH8qv1mgH/B1LolgwE2pqN
	UHKPiCO3xrRUS0D37Xb7fzQq+SJPOOBQd+iziutMoxKnnQAnrXn2rcD+sPQFyMkrO7Pi8qsm4uD3l
	qxtseJEgNmZNQ0gNr8dVk9j/RsBLsv8StRwq0fvn3NZcdqBeyPsp8XZVvutdqKZINWf92CRHglQ5H
	X4xkSDF8RalWVU6QnYSPsINxSPUdjtgZLT2e7F7o1SZIh1ykJa5VqSR3ttMyvwOkTxsW3VV/IIYmd
	SMSKW17rZgXeRjfHyN0/ecUlgTWIf+VV56g2I/EuTc+KHVr9YE9LH6qsC2rG1BJoxitRhKei5ULMi
	zrLY2y9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsRFr-0000000DDPa-1EjH;
	Wed, 12 Mar 2025 18:56:35 +0000
Date: Wed, 12 Mar 2025 18:56:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: shuah <shuah@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
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
	netdev@vger.kernel.org, conduct@kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
Message-ID: <Z9HY42sGyOOz4oCm@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com>
 <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
 <c6ef4594-2d87-4fff-bee2-a09556d33274@huawei.com>
 <Z9BSlzpbNRL2MzPj@casper.infradead.org>
 <8fa8f430-5740-42e8-b720-618811fabb22@huawei.com>
 <52f4e8b1-527a-42fb-9297-2689ba7c7516@kernel.org>
 <d143b16a-feda-4307-9e06-6232ecd08a88@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d143b16a-feda-4307-9e06-6232ecd08a88@kernel.org>

On Wed, Mar 12, 2025 at 12:48:56PM -0600, shuah wrote:
> This message is a rude personal attack. This isn't the way to treat your
> peers in the community. Apology is warranted.

I apologise for using the word "fucking".

