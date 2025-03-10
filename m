Return-Path: <netdev+bounces-173578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A25A59A39
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43F116B8A2
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF28C22D4DD;
	Mon, 10 Mar 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uQ+mDlOS"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C722ACD4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621358; cv=none; b=E79svj0D6ESK3VhEZQ73xVaW0lM5sT6lH5mcpiwO1+cqtIBmdLXiStJqNuauU/RlcoShV7kQMdUTo2kyng3GzLtoNEb7WZozs+Q0gpypZAIZrpHY/zR1Hsgyejy8gqPs4mbCl1wrKadpcYM9QcKBuRu9fsGVq8WvxVL0+5gIN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621358; c=relaxed/simple;
	bh=EU/SNjsP5bWRg6BwIAjupkyD+YRGhqljYWgBSXCO6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpT7y49YK9lhHJHp05xUOHTOQ/9+wEc02yQJBF0SRP7tYiVc2SpfrYcnCOGqZpiUi31oaxVf/c+qu8ahhltCmmN5whqgSZO/0elVcplFkuXmc3QfjoGDaJpAZbNPV9qbaf/fAbe62XMbrdAW16eNlQILVq9QT4g5YitbZfltoeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uQ+mDlOS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2PwaOKrUlM1k45ynkNwJ7drq3OLEHCYNFE9EcOdF2U4=; b=uQ+mDlOSHJVHyLncXcWH4fDmeB
	i/ZkX4w+eGcPsANymWdCzEFt2UMvKqZ4cIODj91sf+hOs9zU12bxCNiGFuCKDbpDpSfHORUd+XAYs
	3aEf1p6roFcMDeTGtsR2VuVFjhx048u/+zy3HiUz06TnUmUmiIXU3GnKzxNe5RHFWABXwu/vXeZXB
	+ezG3A1oXO9OPxdDrinHTD0ZZmKNm1MeuN6nF5+UDwYwRZduGnNX5u/C8PeOpROsmmrVa3JK8xEsB
	EVcDcgLbO0QcBGaeJCqMV83DQmC5lKwCoqgz6Oo4haic4p6gaL5Yg9Sy518OHJhCjxgyK3ulwnhNw
	kxct73vA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trfGq-00000006bQF-3qtc;
	Mon, 10 Mar 2025 15:42:25 +0000
Date: Mon, 10 Mar 2025 15:42:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Mina Almasry <almasrymina@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
Message-ID: <Z88IYPp_yVLEBFKx@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com>
 <87cyepxn7n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyepxn7n.fsf@toke.dk>

On Mon, Mar 10, 2025 at 10:13:32AM +0100, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
> > Also, Using the more space in 'struct page' for the page_pool seems to
> > make page_pool more coupled to the mm subsystem, which seems to not
> > align with the folios work that is trying to decouple non-mm subsystem
> > from the mm subsystem by avoid other subsystem using more of the 'struct
> > page' as metadata from the long term point of view.
> 
> This seems a bit theoretical; any future changes of struct page would
> have to shuffle things around so we still have the ID available,
> obviously :)

See https://kernelnewbies.org/MatthewWilcox/Memdescs
and more immediately
https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

pagepool is going to be renamed "bump" because it's a bump allocator and
"pagepool" is a nonsense name.  I haven't looked into it in a lot of
detail yet, but in the not-too-distant future, struct page will look
like this (from your point of view):

struct page {
	unsigned long flags;
	unsigned long memdesc;
	int _refcount;	// 0 for bump
	union {
		unsigned long private;
		atomic_t _mapcount; // maybe used by bump?  not sure
	};
};

'memdesc' will be a pointer to struct bump with the bottom four bits of
that pointer indicating that it's a struct bump pointer (and not, say, a
folio or a slab).

So if you allocate a multi-page bump, you'll get N of these pages,
and they'll all point to the same struct bump where you'll maintain
your actual refcount.  And you'll be able to grow struct bump to your
heart's content.  I don't know exactly what struct bump looks like,
but the core mm will have no requirements on you.

