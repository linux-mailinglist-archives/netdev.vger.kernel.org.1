Return-Path: <netdev+bounces-173939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B36A5C522
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5BC179F63
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234E25DCE5;
	Tue, 11 Mar 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F7ny6Yqh"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E71C5D77
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705770; cv=none; b=o07qek1T/X8Cu5oWhG3iGXhZz80SDOEvDJR/6XUkWQZnTp/i2Y0FqPm3paMgMZHl0dZJwf4miAtyEAP7OgU+1Y5CpmYoOFTu4de1TngsXrWFXAHaVNpfcRjvgC5nZYzo2ZHMSU7HhfnraMbyFLsC1GDOD5nxZ71XIC8w3n7rZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705770; c=relaxed/simple;
	bh=id1//S6Z9aZevEkKLigsbBYh9v6b0LVKcPlcfKrumAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h79FE4OWB3Gz++dmTNyvYOKhgPXYz6+AUOlyVAaPhvKCzON75h9Y+TymkHANjQFnKr7jrYKVfR9KtV41Q5Shp9sINU+XTIN4koB+lFYlAA3fsH+W2VudSmNX2dRmX0eKDN+5fyR/eg+f7+Yex1XeDL3BLoUENIbERQpLZ9ZaE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F7ny6Yqh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=AfTRT/JhpcsnYEnYQ+uGgKzz43omc/1mvdTGaT2ZjsI=; b=F7ny6Yqhm3LnNVbKfocRH200qT
	6NpiS2a8ijtGVt3JA9ywB3muXAp9MAIrcbiTUUobpkhi4jmH9uALtRE09bL50hO46PXvPQwTaL+sz
	ED+t34ZEKPHwAOuov2wt3dPiLBFYwvaL4+CH0Ku+31oBvVjJdtN6eOTxNzaDg7IEPaAo+juFi7u1w
	0cEFN500ZPKICiU4s2NkAMkhs+wVEQXCb5clu1K0pz9w6bt9RuAAbvHE0kwh0DYHvpscRdpL5JdUi
	2mfTf1rch/zWMtF6ZX6+ODm1sfzLwhIU5RyTKrkTFTLVvDLbmozUf8b63mL5PBJ05wAx5u2iRyFM+
	ZzEyNmuw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ts18g-00000001nLu-2qro;
	Tue, 11 Mar 2025 15:04:33 +0000
Date: Tue, 11 Mar 2025 15:03:26 +0000
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
Message-ID: <Z9BQvgdAzvTriOj1@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com>
 <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
 <87v7sgkda8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7sgkda8.fsf@toke.dk>

On Mon, Mar 10, 2025 at 06:26:23PM +0100, Toke Høiland-Jørgensen wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > See https://kernelnewbies.org/MatthewWilcox/Memdescs
> > and more immediately
> > https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> >
> > pagepool is going to be renamed "bump" because it's a bump allocator and
> > "pagepool" is a nonsense name.  I haven't looked into it in a lot of
> > detail yet, but in the not-too-distant future, struct page will look
> > like this (from your point of view):
> >
> > struct page {
> > 	unsigned long flags;
> > 	unsigned long memdesc;
> > 	int _refcount;	// 0 for bump
> > 	union {
> > 		unsigned long private;
> > 		atomic_t _mapcount; // maybe used by bump?  not sure
> > 	};
> > };
> >
> > 'memdesc' will be a pointer to struct bump with the bottom four bits of
> > that pointer indicating that it's a struct bump pointer (and not, say, a
> > folio or a slab).
> >
> > So if you allocate a multi-page bump, you'll get N of these pages,
> > and they'll all point to the same struct bump where you'll maintain
> > your actual refcount.  And you'll be able to grow struct bump to your
> > heart's content.  I don't know exactly what struct bump looks like,
> > but the core mm will have no requirements on you.
> 
> Ah, excellent, thanks for the pointer!
> 
> Out of curiosity, why "bump"? Is that a term of art somewhere?

https://en.wikipedia.org/wiki/Region-based_memory_management

(and the term "bump allocator" has a number of hits in your favourite
search engine)

> And in the meantime (until those patches land), do you see any reason
> why we can't squat on the middle bits of page->pp_magic (AKA page->lru)
> like I'm doing in v2[0] of this patch?

I haven't had time to dig into this series.  I'm trying to get a bunch
of things finished before LSFMM.

