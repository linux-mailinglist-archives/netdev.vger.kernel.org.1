Return-Path: <netdev+bounces-228961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC78DBD69BB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A370718A311F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D52FE04C;
	Mon, 13 Oct 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v00Fjc84"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E12FB991
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394340; cv=none; b=Glj1zwB20TBEI9lfr5vZSsdOn1Es32UWPxW6lCGIpvXdnCgjG9yT5W7dRxWNtqP+coQ2w/veR9p77zfs3xWeK7gdw62LycajYugtKR2IRrRfLMF089ojmI4IuM/kRqzmdEgSQu0eG/Yon+rCxnkGG2uCsXEgozUiHq+NUg5Le2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394340; c=relaxed/simple;
	bh=yBJ86Xpo8lfKXSxDVaXOU4LWgg+xoZBMTFx90wqe2R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSJgk34mF16Qn68QU0BU0L3zU5wJh/0bInZoZmtI+y5sxr0j+YqQSJr66590i7Y2DYVaWNgohnygvL6mTj0ZDWIitp56PlcTnFNx3KKStCntvKrdRjF7npZN5PImAQr4XpX/WVgkfpQNFoPzDAoP2mZIkEdkxLSP0TGucclFFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v00Fjc84; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Oct 2025 15:25:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760394322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwYZKlSFt2TFGtm4ACaHZ9tJu+i/5nUbp4Hg7BFfIes=;
	b=v00Fjc845Tfg/YtbSUJqnqhYCp/u8vSfS8Gy3jolcyVjPw4OT7EJXAuPp4uoVf8yEIHJCw
	/AlKO4S4ddhigi8M5LktsJpBcZ0Tae50MwChbNJsshp2ZlM97DLNe8bn4hLAr/k7uI+R61
	yOkKcTX+Jx3XmMbtBG3X9TWd9ZCPqAY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Huacai Zhou <zhouhuacai@oppo.com>, Harry Yoo <harry.yoo@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <5ytqerlevrsaldgww6jhiqljim35bxruicrq7hj5rumt3lywto@3ejpuuar45hx>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <dhmafwxu2jj4lu6acoqdhqh46k33sbsj5jvepcfzly4c7dn2t7@ln5dgubll4ac>
 <CAADnVQKEhfFTSkn6f_PJr6xMcjB4d45E_+TsU6+945f2XD1SmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKEhfFTSkn6f_PJr6xMcjB4d45E_+TsU6+945f2XD1SmA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 13, 2025 at 02:53:17PM -0700, Alexei Starovoitov wrote:
> On Mon, Oct 13, 2025 at 2:35 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Mon, Oct 13, 2025 at 08:30:13PM +0200, Vlastimil Babka wrote:
[...]
> > >
> > > I'm a bit worried about proliferating "~__GFP_RECLAIM" allocations now that
> > > we introduced alloc_pages_nolock() and kmalloc_nolock() where it's
> > > interpreted as "cannot spin" - see gfpflags_allow_spinning(). Currently it's
> > > fine for the page allocator itself where we have a different entry point
> > > that uses ALLOC_TRYLOCK, but it can affect nested allocations of all kinds
> > > of debugging and accounting metadata (page_owner, memcg, alloc tags for slab
> > > objects etc). kmalloc_nolock() relies on gfpflags_allow_spinning() fully
> > >
> > > I wonder if we should either:
> > >
> > > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > > determine it precisely.
> > >
> > > 2) keep __GFP_KSWAPD_RECLAIM for allocations that remove it for purposes of
> > > not being disturbing (like proposed here), but that can in fact allow
> > > spinning. Instead, decide to not wake up kswapd by those when other
> > > information indicates it's an opportunistic allocation
> > > (~__GFP_DIRECT_RECLAIM, _GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC,
> > > order > 0...)
> > >
> > > 3) something better?
> > >
> >
> > For the !allow_spin allocations, I think we should just add a new __GFP
> > flag instead of adding more complexity to other allocators which may or
> > may not want kswapd wakeup for many different reasons.
> 
> That's what I proposed long ago, but was convinced that the new flag
> adds more complexity. 

Oh somehow I thought we took that route because we are low on available
bits.

> Looks like we walked this road far enough and
> the new flag will actually make things simpler.
> Back then I proposed __GFP_TRYLOCK which is not a good name.
> How about __GFP_NOLOCK ? or __GFP_NOSPIN ?

Let's go with __GFP_NOLOCK as we already have nolock variants of the
allocation APIs. 

