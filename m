Return-Path: <netdev+bounces-19607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A2D75B609
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5624E28203D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6967418AFD;
	Thu, 20 Jul 2023 18:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED72FA50
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B174CC433C7;
	Thu, 20 Jul 2023 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689876029;
	bh=7zlXtpjQE5GsiUCG8T5VeQsjP7xxM1cSIbwNm1yLxBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9i2KlNic8DT0aV6wei/pn/69NnpnLEOl6A5KpT0D+5gBE5EQ75jsSPR2pszdDquy
	 h0Vr8sba6J3Z8Z6XUGYoqxiTYSvYq/y+u3YPm21zno40p5GItvroYgfGafZxv2OZdQ
	 NnROMTed50T0p4vtabWit1SP/F5q4TVbmVKy9UpfTC3qo676e0x5oda7gb++e3Bnc+
	 DqL86OoukRxtv1Nt4UKGoVBdt0YDTPzQuD4oo9eniO++HlR3BKBipBd70U4zH3FepH
	 oRGNqovTUNhPvvjJ52w35hqz4LV0ybJhcUEjw9ZGA4ggDpXYqRP8Prp8v4fG3Lj/y2
	 NKsx0/bGGfvsg==
Date: Thu, 20 Jul 2023 11:00:27 -0700
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
Message-ID: <20230720110027.4bd43ee7@kernel.org>
In-Reply-To: <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
	<20230714170853.866018-10-aleksander.lobakin@intel.com>
	<20230718174042.67c02449@kernel.org>
	<d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
	<20230719135150.4da2f0ff@kernel.org>
	<48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
	<20230720101231.7a5ff6cd@kernel.org>
	<8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 19:48:06 +0200 Alexander Lobakin wrote:
> >> My question was "how can two things race on one CPU in one context if it
> >> implies they won't ever happen simultaneously", but maybe my zero
> >> knowledge of netcons hides something from me.  
> > 
> > One of them is in hardirq.  
> 
> If I got your message correctly, that means softirq_count() can return
> `true` even if we're in hardirq context, but there are some softirqs
> pending? 

Not pending, being executed. Hardirq can come during softirq.

> I.e. if I call local_irq_save() inside NAPI poll loop,
> in_softirq() will still return `true`? (I'll check it myself in a bit,
> but why not ask).

Yes.

> Isn't checking for `interrupt_context_level() == 1` more appropriate
> then? Page Pool core code also uses in_softirq(), as well as a hellaton
> of other networking-related places.

Right now page pool only supports BH and process contexts. IOW the
"else" branch of if (in_softirq()) in page pool is expecting to be
in process context.

Supporting hard irq would mean we need to switch to _irqsave() locking.
That's likely way too costly.

Or stash the freed pages away and free them lazily.

Or add a lockdep warning and hope nobody will ever free a page-pool
backed skb from hard IRQ context :)

