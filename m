Return-Path: <netdev+bounces-32428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D17977F7
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC441C20D96
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842DD12B8D;
	Thu,  7 Sep 2023 16:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB858134C2
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 16:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C74C43395;
	Thu,  7 Sep 2023 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694104717;
	bh=doH2Ipa+K30k1xtAqDsX27JKiStd1k7S5/DQ0ZIzSjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=byj3V30uebT2aqsPOpUIcbMHDdf8k+FFiC/OpNOxjPqZdoBrm18qozEfNP3xVbSMT
	 rtLWA3im2nzeChLUmdMV/ZOzuUsjHOSxQtohcKxeA4FPNxaqzvpun81yKhD6hgrite
	 enypqZyGHGftZFf8xmWZ1iCD7BW34YHrAwvadt0T4Sa8SgMTfDnjnfiYxq1qGwLMXG
	 MDEvNx97paTGEktB7oc+StyXTxks755mV7A6uNLfoxJ8NYUgmCJJoANHcMOki11D/R
	 QLWQfFNHYORmYEm4C2lD0MXH9fzMqwGtyQeehP5By8UJS5e650TiemlbT0VfD42Q6L
	 fKkXRxJzFZ2Pw==
Date: Thu, 7 Sep 2023 09:38:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hayes Wang <hayeswang@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, nic_swsd <nic_swsd@realtek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v2] r8152: avoid the driver drops a lot of packets
Message-ID: <20230907093836.3253c0d5@kernel.org>
In-Reply-To: <7f8b32a91f5849c99609f78520b23535@realtek.com>
References: <20230906031148.16774-421-nic_swsd@realtek.com>
	<20230906172847.2b3b749a@kernel.org>
	<7f8b32a91f5849c99609f78520b23535@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Sep 2023 07:16:50 +0000 Hayes Wang wrote:
> > Before we tweak the heuristics let's make sure rx_bottom() behaves
> > correctly. Could you make sure that
> >  - we don't perform _any_ rx processing when budget is 0
> >    (see the NAPI documentation under Documentation/networking)  
> 
> The work_done would be 0, and napi_complete_done() wouldn't be called.
> However, skb_queue_len(&tp->rx_queue) may be increased. I think it is
> not acceptable, right?

If budget is 0 we got called by netconsole, meaning we may be holding
arbitrary locks. And we can't use napi_alloc_skb() which is for
softirq/bh context only. We should only try to complete Tx in that
case, since r8152_poll() doesn't handle any Tx the right thing seems
to be to add if (!budget) return 0;

> >  - finish the current aggregate even if budget run out, return
> >    work_done = budget in that case.
> >    With this change the rx_queue thing should be gone completely.  
> 
> Excuse me. I don't understand this part. I know that when the packets are
> more than budget, the maximum packets which could be handled is budget.
> That is, return work_done = budget. However, the extra packets would be queued
> to rx_queue. I don't understand what you mean about " the rx_queue thing
> should be gone completely". I think the current driver would return
> work_done = budget, and queue the other packets. I don't sure what you
> want me to change.

Nothing will explode if we process a few more packets than budget
(assuming budget > 0). If we already do allocations and prepare
those skbs - there's no point holding onto them in the driver.
Just sent them up the stack (and then we won't need the local rx_queue).

> >  - instead of copying the head use napi_get_frags() + napi_gro_frags()
> >    it gives you an skb, you just attach the page to it as a frag and
> >    hand it back to GRO. This makes sure you never pull data into head
> >    rather than just headers.  
> 
> I would study about them. Thanks.
> 
> Should I include above changes for this patch?
> I think I have to submit another patches for above.
> 
> > Please share the performance results with those changes.  
> 
> I couldn't reproduce the problem, so I couldn't provide the result
> with the differences.

Hm, if you can't repro my intuition would be to only take the patch for
budget=0 handling into net, and the rest as improvements into net-next.

