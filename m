Return-Path: <netdev+bounces-212968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AAB22ADF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6C53AD8BC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612529B78F;
	Tue, 12 Aug 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRuKzk9t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DA10E3
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009484; cv=none; b=ZouwGwInXxRzMdsz2PC73m58F6bTZBo5ItURqxndgWQxuPe86sGIlwiujKPHsu1BxMv9tLuccGlV5FzxSseq++qaHukYZtJ4xHdDWXUPh9afn64rGHc4q2eQMxGnO0dXVrmlTzqc3epijtjlmWySEFs1cNSR8p2yV7uVvpoYQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009484; c=relaxed/simple;
	bh=cYmVCd5Rzvoe/000+lsTOpd0liSu7p4yLDxRv6sO9YY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K10V2cDQvi2NuBFYvujaQL6DQAgXV9HY1JtitxmNwh6kadTY2hU3fa32Vwo/nRynHWjJSPqnA9Tsw07nK+Vjvcf80y6U+f7WY8yObrWvaav7MUvOQz0ZKgu/lSuN4R9syUYd1xCl/SgItEwxfV2/p7T3A12r4Sw1cwW8HTzd2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRuKzk9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB6AC4CEF0;
	Tue, 12 Aug 2025 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755009484;
	bh=cYmVCd5Rzvoe/000+lsTOpd0liSu7p4yLDxRv6sO9YY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WRuKzk9tkpWe6j+3WBngd8zna2EbpRv4dsiEYxx5AooTBjsamMsS1D9PCkP7ihIpH
	 zYL6kt6Vs4KQl1aWbKfg9Lx4JaZA7wEKMPE6tKflEutnwRXi663ODps7/eKKgMp6eN
	 PF6AjCO/ACGCESc8tOghfXu+6nNQ87xSMRjSFAsmVXOq6UClT6yKG9buz7+62kv/Jf
	 1GVS1HeNy6EihIuLwykUDRE6Z5lSYB3QenA048Q/AWrfAaYVsRYKALGtnwDgZdypkO
	 4IopLjQ/Dke9gQc3yFIdw7I3DY6fdq1CU/UF1yxBwCe9xSuGOgjxmc+3rmiq6lAQht
	 Yel3Fnhv90asQ==
Date: Tue, 12 Aug 2025 07:38:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io,
 victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
Message-ID: <20250812073802.28f86ab2@kernel.org>
In-Reply-To: <OF2YXaY19FGNBLPjTD_cAIQim1BVjj7pzMkq8j5mXSQJr9Kd6N04zf2YkLCEpxnIz-zrljMlV0Ask-hlUDuc3rkzIKfF7MzY-jgVtyTi2Q4=@willsroot.io>
References: <20250727235602.216450-1-will@willsroot.io>
	<20250808142746.6b76eae1@kernel.org>
	<n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io>
	<20250811082958.489df3fa@kernel.org>
	<-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io>
	<20250811102449.50e5f416@kernel.org>
	<Xd_A9IO0dh4NAVigE2yIDk9ZbCEz4XRcUO1PBNl2G6kEZF6TEAeXtDR85R_P-zIMdSL17cULM_GdmijrKs84RdMewdZswMDCBu5G7oBrajY=@willsroot.io>
	<20250811175120.7dd5b362@kernel.org>
	<OF2YXaY19FGNBLPjTD_cAIQim1BVjj7pzMkq8j5mXSQJr9Kd6N04zf2YkLCEpxnIz-zrljMlV0Ask-hlUDuc3rkzIKfF7MzY-jgVtyTi2Q4=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 02:10:02 +0000 William Liu wrote:
> > AFAICT only if the backlog adjustment is using the prev_qlen,
> > prev_backlog approach, which snapshots the backlog. In that case,
> > yes, the "internal drops" will mess up the count.  
> 
> Yep, that's why I added the dropped_qlen and dropped_backlog
> variables, though that is not a very pretty solution.
> 
> But even looking at the method you suggested (copy pasting for
> reference):
> 
> 	pkts = 0;
> 	bytes = 0;
>  	while (sch->q.qlen > sch->limit ||
>  	       q->memory_usage > q->memory_limit) {
>  		struct sk_buff *skb = qdisc_dequeue_internal(sch, false); 
> 		pkts++;
> 		bytes += qdisc_pkt_len(skb);
>  		rtnl_kfree_skbs(skb, skb);
>  	}
> 	qdisc_tree_reduce_backlog(sch, pkts, bytes);
> 
> qdisc_dequeue_internal can trigger fq_codel_dequeue, which can
> trigger qdisc_tree_reduce_backlog before returning (the only qdisc
> out of these that does so in its dequeue handler). 
> 
> Let's say the limit only goes down by one, and packet A is at the
> front of the queue. qdisc_dequeue_internal takes the dequeue path,
> and fq_codel_dequeue triggers a qdisc_tree_reduce_backlog from that
> packet before returning the skb. Would this final
> qdisc_tree_reduce_backlog after the limit drop not double count? 

The packets that got counted in qdisc_tree_reduce_backlog() inside
->dequeue are freed immediately via

  drop_func()
    kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_CONGESTED);

in the scenario you're describing ->dequeue should return NULL.
If that's possible, then we have another bug here :$

Normally backlogs get adjusted as the packet travels down the hierarchy
thru the parent chain. ->dequeue is part of this normal path so skbs it
returns are still in the parent's backlogs. qdisc_tree_reduce_backlog()
is only called when we need to do something to an skb outside of the
normal ->enqueue/->dequeue flow that iterates the hierarchy.

