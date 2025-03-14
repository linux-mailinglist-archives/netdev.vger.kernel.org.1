Return-Path: <netdev+bounces-174952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6BA61912
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5696C19C4AF8
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86171201006;
	Fri, 14 Mar 2025 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOzTY4ZN"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85262E3389
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975786; cv=none; b=DKnX4w/BlibccuysSFe8qIS0JxnQTtiDNHw6AI3qqUd+pgoavG5mGYLx97V8mAj4uJuKbuvXnrIwNAbybsqz1D68bMvCquG2LlBo3NgQsarAxngFJ2G6J18OLNUEbqmOFhhEmFrXSP9bXnnY5aULc1CRsjn4lOZuGI2DS9svohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975786; c=relaxed/simple;
	bh=svtYVowsPXZ0W25ampgxRVUb9Tlp4lTaOg3zrZmUxoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om7j+k0IqIsvRKMqFxGXrKMBzB2m13FXv1/Mm+sCBk4xb4SGYfl8y2FCnEPN5/jW1SXnANGecKVc6BeVotiWWXFGGoxRg81xiCsDaVidTvtThqm/fyScmvO08Kq7vbTJ7PWG71yVZYCaeUynX6/OuLbWQBXlgX59go/19UE18vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HOzTY4ZN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=svtYVowsPXZ0W25ampgxRVUb9Tlp4lTaOg3zrZmUxoc=; b=HOzTY4ZNRSwLMgojXRn0uSxI0Z
	l1NmwI86+ro0wBFfsyv49L2Y3SgxnPEXZ/cq+uCgJAfXI8WcC+xZCmYUnseK3LxXwc7W4pKQoXpAX
	oe1DFr4EnSTZyvWvdptEs+1/3MUD3Bw6MnHAIumsXHjcoXSO0QU6DzKu1KeWzJs8nJxC9svCEoUeC
	AhGOSvSAlbszMCxbbOHoAVfaswmr0XwtkHNSMNc9YbD7QcouUjDlX8dgignbvEgitsLlPUWdUJd6b
	c1Du+z0SIaV0kP+gLEvwZai3WYSHcA6ixGm1pGms7QPk1xfnefCWkiGDuKIVO156/jBsW7rUqPic3
	264SeGZg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt9TB-00000004DDN-2IlR;
	Fri, 14 Mar 2025 18:09:17 +0000
Date: Fri, 14 Mar 2025 18:09:16 +0000
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
Message-ID: <Z9RwzMGadbRWnuqo@casper.infradead.org>
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

I apologise for the insult; that was unnecessary.

