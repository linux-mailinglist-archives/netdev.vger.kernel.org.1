Return-Path: <netdev+bounces-16159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E074B9B4
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467E61C21063
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E83317746;
	Fri,  7 Jul 2023 22:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC22F28
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA2BC433C7;
	Fri,  7 Jul 2023 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688769904;
	bh=YbpgSxKme18OyRTzP2MTRIbXoklWezKh6NZ3ZZ+pRmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVk2XsSgcIG1JQz7lkxU7ESK6y7wcyz5CMiDkg885jTk3YCIcjo++2UM81PL7DoXN
	 5jwBWbsah6Uh+FDzhg1a3c6PipAxnZ8R9C5u5v7meZIh+KSK5ANeoGJkhjK26qDLVO
	 RMdbbb4VJUbWvU9fA47U2iVDIFDbLlCU4cfSuWxeWLTFs2x8i86eH6i8OOYZYp7gsT
	 4gsKh/YjtEupe07zYlJCXRn+itkgFyPslPvhh6+wkxF/XDdUmIXVgn7+U5gE/sxu9U
	 6yh0uLzljnxcjuaxjt+mLdxEPY4BQtJsx+XG/wLW21PCa2WT+j+fHoqGGXEvxnxOmh
	 oQ0QTUQHb+xpw==
Date: Fri, 7 Jul 2023 15:45:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 edumazet@google.com, dsahern@gmail.com, michael.chan@broadcom.com,
 willemb@google.com
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Message-ID: <20230707154503.57cc834e@kernel.org>
In-Reply-To: <CAHS8izPmQRuBfBB2ddna-RHvorvJs7VtVUqCW80MaxPLUtDHGA@mail.gmail.com>
References: <20230707183935.997267-1-kuba@kernel.org>
	<CAHS8izPmQRuBfBB2ddna-RHvorvJs7VtVUqCW80MaxPLUtDHGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jul 2023 12:45:26 -0700 Mina Almasry wrote:
> > This is an "early PoC" at best. It seems to work for a basic
> > traffic test but there's no uAPI and a lot more general polish
> > is needed.
> >
> > The problem we're seeing is that performance of some older NICs
> > degrades quite a bit when IOMMU is used (in non-passthru mode).
> > There is a long tail of old NICs deployed, especially in PoPs/
> > /on edge. From a conversation I had with Eric a few months
> > ago it sounded like others may have similar issues. So I thought
> > I'd take a swing at getting page pool to feed drivers huge pages.
> > 1G pages require hooking into early init via CMA but it works
> > just fine.
> >
> > I haven't tested this with a real workload, because I'm still
> > waiting to get my hands on the right machine. But the experiment
> > with bnxt shows a ~90% reduction in IOTLB misses (670k -> 70k).
> 
> Thanks for CCing me Jakub. I'm working on a proposal for device memory
> TCP, and I recently migrated it to be on top of your pp-provider idea
> and I think I can share my test results as well. I had my code working
> on top of your slightly older API I found here a few days ago:
> https://github.com/kuba-moo/linux/tree/pp-providers
> 
> On top of the old API I had something with all my functionality tests
> passing and performance benchmarking hitting ~96.5% line rate (with
> all data going straight to the device - GPU - memory, which is the
> point of the proposal). Of course, when you look at the code you may
> not like the approach and I may need to try something else, which is
> perfectly fine, but my current implementation is pp-provider based.
> 
> I'll look into rebasing my changes on top of this RFC and retesting,
> but I should share my RFC either way sometime next week maybe. I took
> a quick look at the changes you made here, and I don't think you
> changed anything that would break my use case.

Oh, sorry I didn't realize you were working on top of my changes
already. Yes, the memory provider API should not have changed much.
I mostly reshuffled the MEP code to have both a coherent and
non-coherent buddy allocator since then.

> > In terms of the missing parts - uAPI is definitely needed.
> > The rough plan would be to add memory config via the netdev
> > genl family. Should fit nicely there. Have the config stored
> > in struct netdevice. When page pool is created get to the netdev
> > and automatically select the provider without the driver even
> > knowing.  
> 
> I guess I misunderstood the intent behind the original patches. I
> thought you wanted the user to tell the driver what memory provider to
> use, and the driver to recreate the page pool with that provider. What
> you're saying here sounds much better, and less changes to the driver.
> 
> >  Two problems with that are - 1) if the driver follows
> > the recommended flow of allocating new queues before freeing
> > old ones we will have page pools created before the old ones
> > are gone, which means we'd need to reserve 2x the number of
> > 1G pages; 2) there's no callback to the driver to say "I did
> > something behind your back, don't worry about it, but recreate
> > your queues, please" so the change will not take effect until
> > some unrelated change like installing XDP. Which may be fine
> > in practice but is a bit odd.
> 
> I have the same problem with device memory TCP. I solved it in a
> similar way, doing something else in the driver that triggers
> gve_close() & gve_open(). I wonder if the cleanest way to do this is
> calling ethtool_ops->reset() or something like that? That was my idea
> at least. I haven't tested it, but from reading the code it should do
> a gve_close() + gve_open() like I want.

The prevailing wisdom so far was that close() + open() is not a good
idea. Some NICs will require large contiguous allocations for rings 
and context memory and there's no guarantee that open() will succeed
in prod when memory is fragmented. So you may end up with a close()d
NIC and a failure to open(), and the machine dropping off the net.

But if we don't close() before we open() and the memory provider is
single consumer we'll have problem #1 :(

BTW are you planning to use individual queues in prod? I anticipated
that for ZC we'll need to tie multiple queues into an RSS context, 
and then configure at the level of an RSS context.

