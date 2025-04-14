Return-Path: <netdev+bounces-182526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A7A8902C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7177E17CF4D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FCB1FF7A5;
	Mon, 14 Apr 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBDAGf0z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC801FECBA
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744673404; cv=none; b=I0MeSjEfu5pEMI53nIHXom03bdRxfoaUaU0216ICwjppgIXwAnXdeVtzKqfZu/QDFqfOt0895fyki3yDNhY22crHM8JcYGoTbG9lSb3mMcEQrMTW8EqMcqZrD2FqWzVz28qAFnMMOa1LWJ0yN1vcSkupRRzcInb4Wc0kJ/YsABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744673404; c=relaxed/simple;
	bh=9FPxyHvmK86b7zqc4lYgfC1sZb0i4TzzabkBuGotnds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyU+UtraSiVLoZ3O1tQsBorndj7jny227atmqookKGO/l+krCLmGkfzJd6OROPnkfpY/3nVr+yi15q4jHRG1xszJ/Y8XtCe/PtVAfvvJNqU3gTRfM5LFJrrPKJdloadZaLNte35qquFe+ms6uQCNTGrOLAZTX2tbPXm8YhxUKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBDAGf0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A41C4CEE2;
	Mon, 14 Apr 2025 23:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744673403;
	bh=9FPxyHvmK86b7zqc4lYgfC1sZb0i4TzzabkBuGotnds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HBDAGf0zYFWzp6m1ye8QZC73cQWwlQ3pSDPvnmigCO6mksYbH8hwitr1tiuk1MA+z
	 EzI5Xoy7QModP55AB01nGamhEALPot5YhNFplpxGW6rW+5/wldc5JuxLYUAU+6iTZE
	 GCcGI/isQCsUMR5sK30mTkIRlIl/CJA32wdiKqzSWetAt2cVX7whIe7nnYn5UBVaCE
	 Z9SkqykpGa2aDEhQ4pPz5/0d/dAxFklElRkFXrxTXr0s1n+dWVHUbEKxw8xwBBUQXp
	 CtAFF8ZapZXKNL1RfHv+iYbpfM8sxsHcUb1RNWA5B9AXovAI3zR1Ieiqg+pj/qQ5sz
	 NyZIBiGcn9eRQ==
Date: Mon, 14 Apr 2025 16:30:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, ilias.apalodimas@linaro.org,
 almasrymina@google.com, kernel_team@skhynix.com, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, hawk@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] shrinking struct page (part of page pool)
Message-ID: <20250414163002.166d1a36@kernel.org>
In-Reply-To: <20250414015207.GA50437@system.software.com>
References: <20250414013627.GA9161@system.software.com>
	<20250414015207.GA50437@system.software.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 10:52:07 +0900 Byungchul Park wrote:
> > Fortunately, many prerequisite works have been done by Mina but I guess
> > he or she has done it for other purpose than 'shrinking struct page'.
> > 
> > I'd like to just finalize the work so that the fields above can be
> > removed from struct page.  However, I need to resolve a curiousity
> > before starting.

I don't understand what the question is but FWIW from my perspective
the ZC APIs are fairly contained, or at least we tried to make sure
that net_iov pages cannot reach random parts of the stack.

Replacing all uses of struct page would require converting much more
of the stack, AFAIU. But that's best discussed over posted patches.

> >    Network guys already introduced a sperate strcut, struct net_iov,
> >    to overlay the interesting fields.  However, another separate struct
> >    for system memory might be also needed e.g. struct bump so that
> >    struct net_iov and struct bump can be overlayed depending on the
> >    source:
> > 
> >    struct bump {
> > 	unsigned long _page_flags;
> > 	unsigned long bump_magic;
> > 	struct page_pool *bump_pp;
> > 	unsigned long _pp_mapping_pad;
> > 	unsigned long dma_addr;
> > 	atomic_long_t bump_ref_count;
> > 	unsigned int _page_type;
> > 	atomic_t _refcount;
> >    };
> > 
> > To netwrok guys, any thoughts on it?
> > To Willy, do I understand correctly your direction?
> > 
> > Plus, it's a quite another issue but I'm curious, that is, what do you
> > guys think about moving the bump allocator(= page pool) code from
> > network to mm?  I'd like to start on the work once gathering opinion
> > from both Willy and network guys.

I don't see any benefit from moving page pool to MM. It is quite
networking specific. But we can discuss this later. Moving code
is trivial, it should not be the initial focus.

