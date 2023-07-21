Return-Path: <netdev+bounces-19916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DF075CD1D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520F1282189
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF131ED4B;
	Fri, 21 Jul 2023 16:05:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7327F0B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4932C433C7;
	Fri, 21 Jul 2023 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689955540;
	bh=n+7B7JXbObA21T6SHfyR3Yg+IUYoaIsrKd7a22j5a7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=smFGAbKn0LI+fv071eb+PjTEO6sCPi3FL/Jcof9rbJIUM6sE5d9mZpnWk8XjQ0ky0
	 NBMPn5cMV2cr3anapLEdxvNCh2LEbkQpc7AvcOA1MddGH8moykJ5ShyrU0D+ushlhc
	 kWhRDV6OAhBim+PuEnBfCh8Ou5jZlo1y9yFLIrOAnfGSd4QMJ5nlZBG92gde6+ilDI
	 oVxWJK/SpFwNalfGDKUBszB7ek2MpBHhBFrIvLajnHcESiSor23pPJtRErEkz8xaJ5
	 n9WmwVGzLTVNHfni62w2RhstSzI69AsOT7b2dQCfqnsbZxOM9jDfVD060QDu2JW8Fy
	 yXmEf7onV6Tgg==
Date: Fri, 21 Jul 2023 09:05:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <peterz@infradead.org>, <mingo@redhat.com>,
 <will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
 <hawk@kernel.org>, <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] page_pool: add a lockdep check for recycling
 in hardirq
Message-ID: <20230721090538.57cfd15d@kernel.org>
In-Reply-To: <4abeeded-536e-be28-5409-8ad502674217@intel.com>
References: <20230720173752.2038136-1-kuba@kernel.org>
	<4abeeded-536e-be28-5409-8ad502674217@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 17:48:25 +0200 Alexander Lobakin wrote:
> > Page pool use in hardirq is prohibited, add debug checks
> > to catch misuses. IIRC we previously discussed using
> > DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
> > that people will have DEBUG_NET enabled in perf testing.
> > I don't think anyone enables lockdep in perf testing,
> > so use lockdep to avoid pushback and arguing :)  
> 
> +1 patch to add to my tree to base my current series on...
> Time to create separate repo named "page-pool-next"? :D

You joke but I've been scheming how to expose the page pool stats
via the netdev netlink family, which would be another conflict to
be added to the pile :D When it rains it pours.

You should probably start sending uncontroversial stuff out even
if it doesn't have in-tree users yet.

> >  # define lockdep_assert_preemption_enabled() do { } while (0)
> >  # define lockdep_assert_preemption_disabled() do { } while (0)
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index a3e12a61d456..3ac760fcdc22 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -536,6 +536,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
> >  static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)  
> 
> Crap can happen earlier. Imagine that some weird code asked for direct
> recycling with IRQs disabled. Then, we can hit
> __page_pool_put_page:page_pool_recycle_in_cache and who knows what can
> happen.
> Can't we add this assertion right to the beginning of
> __page_pool_put_page()? It's reasonable enough, at least for me, and
> wouldn't require any commentary splats. Unlike put_defragged_page() as
> Yunsheng proposes :p
> 
> Other than that (which is debatable), looks fine to me.

No strong preference. Would you mind taking over this one? 
It'd also benefit from testing that the lockdep warning actually 
fires as expected, I just tested that it doesn't false positive TBH :)

