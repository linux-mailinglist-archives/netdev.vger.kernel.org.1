Return-Path: <netdev+bounces-19888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F675CADA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F847281F53
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4CA27F2C;
	Fri, 21 Jul 2023 15:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852627F27
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B3AC433C7;
	Fri, 21 Jul 2023 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689951736;
	bh=Vu3NoQAurmhoPH+A8AWZ9sXwoUG6CYqYH5VY6+sTzic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Br6U7oE+b75Pv50b/TwGXZtlgGcV8YRZ4eoswooeUU0xfkbZCJIw8n5t9iIF9TF8c
	 CNJIaR+RMArVkktWthvFAI5CrEKM6ILHBy3sXqcpMh89SSUq0kut8Ezt6JzcWhKbHN
	 EIqUTBqHdaH3xCnxveWLzHqkSOcRpenPaCTrA3a7/CmGWwW8ByA0NKJteMIjmKOf6x
	 wAioMvO4EO9cX7BxUdIQOAHaeaLw9VLoHmmoHyn64pGfgMO3gRg/EQYIzjv5OeOY6h
	 RiWPaRtlS1qwoSWi2WN6sRVuWKZH7s26pYX8RilslIs1GVTdfMRDf2V9mCBToqJwIH
	 Uh4LcXLvHPswQ==
Date: Fri, 21 Jul 2023 08:02:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <peterz@infradead.org>, <mingo@redhat.com>,
 <will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
 <hawk@kernel.org>, <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] page_pool: add a lockdep check for recycling
 in hardirq
Message-ID: <20230721080215.01b29a5a@kernel.org>
In-Reply-To: <382d00e5-87af-6a6b-17e2-6640fdd01db5@huawei.com>
References: <20230720173752.2038136-1-kuba@kernel.org>
	<382d00e5-87af-6a6b-17e2-6640fdd01db5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 19:53:30 +0800 Yunsheng Lin wrote:
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index a3e12a61d456..3ac760fcdc22 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -536,6 +536,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
> >  static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
> >  {
> >  	int ret;
> > +
> > +	lockdep_assert_no_hardirq();  
> 
> Is there any reason not to put it in page_pool_put_defragged_page() to
> catch the case with allow_direct being true when page_pool_recycle_in_ring()
> may not be called?

I was trying to stick it into places which make an assumption about
the calling context, rather than cover the full API.
I don't have a strong preference either way, but I hope it's good
enough. The benefit I see is that it should be fairly obvious to
a seasoned kernel code reader why this warning is here.
A warning that fires from page_pool_put_defragged_page() would need
a comment to explain the reason and may go stale.

> >  	/* BH protection not needed if current is softirq */
> >  	if (in_softirq())

