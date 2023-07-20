Return-Path: <netdev+bounces-19630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892FE75B7D0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F051C2147A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8D19BD7;
	Thu, 20 Jul 2023 19:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334242FA47
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1AAC433C8;
	Thu, 20 Jul 2023 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689880816;
	bh=7J8RBLCwafwPtaQ9gdKbvPgytbTGrbMuKVN30E0FCJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZIEIranBXAghUEn8aWNlwC2xwxMfluBCSUNbcdXxYRcg3nDj46sDuwcKMohX1aod
	 21J0PdrL49BC2Q7HfjBPxNHU0+t2CV0TUS6V8sbEqwxOs7C5CzMhAoUmsSj9hbH/9X
	 ZLSS4Sk8qWZJ3JZWFWkCjTDUJWuPYB/g4glqK4iAHuelQwqey6AoePPkaKTqeTGRZ6
	 PEVkqiYqTunUgZFDc+6VzGegHiD07F3HiyV+w4JBWo9I6JXNCyaJat1WUzuAalKPEp
	 pOdqZ+5oI65b88Y2QGu3lETqDm9lOzDnKfT0OEfjW65H4fegIY+gRIPcbGGJuMzx/D
	 lsYoTVVCkkzgA==
Date: Thu, 20 Jul 2023 12:20:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle
 PP pages directly when in softirq
Message-ID: <20230720122015.1e7efc21@kernel.org>
In-Reply-To: <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
	<20230714170853.866018-10-aleksander.lobakin@intel.com>
	<20230718174042.67c02449@kernel.org>
	<d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
	<20230719135150.4da2f0ff@kernel.org>
	<48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
	<20230720101231.7a5ff6cd@kernel.org>
	<8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
	<20230720110027.4bd43ee7@kernel.org>
	<988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
	<b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 20:13:07 +0200 Alexander Lobakin wrote:
> IOW, it reports we're in softirq no bloody matter if interrupts are
> enabled or not. Either I did something wrong or the entire in_*irq()
> family, including interrupt_context_level(), doesn't protect from
> anything at all and doesn't work the way that most devs expect it to work?
> 
> (or was it just me? :D)
> 
> I guess the only way to be sure is to always check irqs_disabled() when
> in_softirq() returns true.

We can as well check
	(in_softirq() && !irqs_disabled() && !in_hardirq())
?

The interrupt_context_level() thing is fairly new, I think.
Who knows what happens to it going forward...

> >> Right now page pool only supports BH and process contexts. IOW the
> >> "else" branch of if (in_softirq()) in page pool is expecting to be
> >> in process context.
> >>
> >> Supporting hard irq would mean we need to switch to _irqsave() locking.
> >> That's likely way too costly.
> >>
> >> Or stash the freed pages away and free them lazily.
> >>
> >> Or add a lockdep warning and hope nobody will ever free a page-pool
> >> backed skb from hard IRQ context :)  
> > 
> > I told you under the previous version that this function is not supposed
> > to be called under hardirq context, so we don't need to check for it :D
> > But I was assuming nobody would try to do that. Seems like not really
> > (netcons) if you want to sanitize this...

netcons or anyone who freed socket-less skbs from hardirq.
Until pp recycling was added freeing an skb from hardirq was legal,
AFAICT.

