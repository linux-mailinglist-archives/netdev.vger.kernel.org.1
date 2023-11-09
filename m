Return-Path: <netdev+bounces-46880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4AC7E6E5C
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF2F28109F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE221A12;
	Thu,  9 Nov 2023 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTrsclx/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A082136B
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C80CC433C9;
	Thu,  9 Nov 2023 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699546453;
	bh=Y0GW2muLw5+bWPBPEsnZmKIlY04MGh7SV8hoCZTderM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fTrsclx/4HZaDw1xtV2KqbL0Ap8/hODW23Ngi9nIJjRECN4V1vk8a7NI1/q83DcE1
	 NRAEvQkGlhzc1RRQtw+PS1WrvG/zbk+1Kks4ZNaEf3H/raTauzW9WJMie9nGWtMhCX
	 3KQmWmHOo71IsvatuLjTEyr8GVQmUZ6Uo5Bu0gfBDdIdj1DYvpYak137OmO64CxgnF
	 FJqjJ50NlJvmGP/h/8QiYNTE297uvXtmFWJIkPrkcfsLdcQsts3vTCM7ZN/ntZAS6b
	 j/AqcUOxIVuPEIs2b8PMXu77il6ID99WN0hPnr/T9mI/6YczXBF8S+/TC20NNtlnga
	 nxy5WY6AOPcdg==
Date: Thu, 9 Nov 2023 08:14:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Subject: Re: [PATCH net-next 00/15] net: page_pool: add netlink-based
 introspection
Message-ID: <20231109081412.161ce68f@kernel.org>
In-Reply-To: <CAC_iWjKi0V6wUmutmpjYyjZGkwXef4bxQwcx6o5rytT+-Pj5Eg@mail.gmail.com>
References: <20231024160220.3973311-1-kuba@kernel.org>
	<CAC_iWjKi0V6wUmutmpjYyjZGkwXef4bxQwcx6o5rytT+-Pj5Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 10:11:47 +0200 Ilias Apalodimas wrote:
> > We immediately run into page pool leaks both real and false positive
> > warnings. As Eric pointed out/predicted there's no guarantee that
> > applications will read / close their sockets so a page pool page
> > may be stuck in a socket (but not leaked) forever. This happens
> > a lot in our fleet. Most of these are obviously due to application
> > bugs but we should not be printing kernel warnings due to minor
> > application resource leaks.  
> 
> Fair enough, I guess you mean 'continuous warnings'?

Yes, in this case but I'm making a general statement.
Or do you mean that there's a typo / grammar issue?

> > Conversely the page pool memory may get leaked at runtime, and
> > we have no way to detect / track that, unless someone reconfigures
> > the NIC and destroys the page pools which leaked the pages.
> >
> > The solution presented here is to expose the memory use of page
> > pools via netlink. This allows for continuous monitoring of memory
> > used by page pools, regardless if they were destroyed or not.
> > Sample in patch 15 can print the memory use and recycling
> > efficiency:
> >
> > $ ./page-pool
> >     eth0[2]     page pools: 10 (zombies: 0)
> >                 refs: 41984 bytes: 171966464 (refs: 0 bytes: 0)
> >                 recycling: 90.3% (alloc: 656:397681 recycle: 89652:270201)
> 
> That's reasonable, and the recycling rate is pretty impressive. 

This is just from a test machine, fresh boot, maybe a short iperf run,
I don't remember now :) In any case not real workload.

> Any idea how that translated to enhancements overall? mem/cpu pressure etc

I haven't collected much prod data at this stage, I'm hoping to add
this to the internal kernel and then do a more thorough investigation.

