Return-Path: <netdev+bounces-238355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF7CC57A6A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D98BA4E5114
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03F351FBA;
	Thu, 13 Nov 2025 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="eyNJzlxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB233F8D2
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040520; cv=none; b=sy3xb5iHRjd08sdRF20KY3izroBMpCXZFg2WTaFHH7KnMd9IGx7K+xcGIMtZsvPinmtj10Z6ZhYVlmBkCB3s/tDmYjWqRSHObzV8IjztyK3PVH4jSSd+aq52HpAvVlPf3fiEQNob40yzVs1EF+v25meD58ZI/aXARbp9cD7sa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040520; c=relaxed/simple;
	bh=O6l4vdIsHCK99eA/SnWM2kyLR+VrLR2rPpzCLtw7sBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJKtZyk4IjLfAQGyFjS+wHYAr8YQl/qRMeZPuI1R2VNerBz9qn1KrGmrCRL39EQdhn6A/7G08S4Jyx2b0cfSpVhfCmLHzIZbguZY8mYN87i7WuutxGc2+vrXy5h1o6klF3T0ZtmTBs6fjkYHQezMljXWWX8pNKIaAZb39agpniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=eyNJzlxV; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1763040115; bh=O6l4vdIsHCK99eA/SnWM2kyLR+VrLR2rPpzCLtw7sBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eyNJzlxVGWiBPpcfE0be6NkmLGTpv94GnMj8d2uVta+gFGHm9ZmygRc/w4cyRov1d
	 fSKKy4eyK3fgkh+OMY8bBpKMRZjKS875y5KskBN/n0lvl2wBcKLaBqzpezw0SoSCZ/
	 IElWEufaIqQMRkgnuUPX/BezxEhKn+PhIsHxHXO78X6AFMZu5EzNf6K2J0gwtQPdJU
	 Ui1ElV7Z0d3GxKfn5MyyN5EAqWrg+bYyKwv+NKhBjZYxuZNph7AkKfesuZIIdrytsN
	 48MmapyG/TUvMIQHKj/4VSO4T258YVleRFZTtOsDWAS0UDQWeU4e4RHNKU2jgomgCg
	 2M1pCU/n59GCQ==
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, cake@lists.bufferbloat.net, bestswngs@gmail.com,
 Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
In-Reply-To: <20251113035303.51165-1-xmei5@asu.edu>
References: <20251113035303.51165-1-xmei5@asu.edu>
Date: Thu, 13 Nov 2025 14:21:54 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875xbejcel.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xiang Mei <xmei5@asu.edu> writes:

> In cake_drop(), qdisc_tree_reduce_backlog() is called to decrement
> the qlen of the qdisc hierarchy. However, this can incorrectly reduce
> qlen when the dropped packet was never enqueued, leading to a possible
> NULL dereference (e.g., when QFQ is the parent qdisc).
>
> This happens when cake_enqueue() returns NET_XMIT_CN: the parent
> qdisc does not enqueue the skb, but cake_drop() still reduces backlog.
>
> This patch avoids the extra reduction by checking whether the packet
> was actually enqueued. It also moves qdisc_tree_reduce_backlog()
> out of cake_drop() to keep backlog accounting consistent.
>
> Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: add missing cc
> v3: move qdisc_tree_reduce_backlog out of cake_drop
>
>  net/sched/sch_cake.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 32bacfc314c2..179cafe05085 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1597,7 +1597,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
>  
>  	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
>  	sch->q.qlen--;
> -	qdisc_tree_reduce_backlog(sch, 1, len);
>  
>  	cake_heapify(q, 0);
>  
> @@ -1750,7 +1749,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	ktime_t now = ktime_get();
>  	struct cake_tin_data *b;
>  	struct cake_flow *flow;
> -	u32 idx, tin;
> +	u32 dropped = 0;
> +	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
> +	bool same_flow = false;
>  
>  	/* choose flow to insert into */
>  	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
> @@ -1927,24 +1928,31 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	if (q->buffer_used > q->buffer_max_used)
>  		q->buffer_max_used = q->buffer_used;
>  
> -	if (q->buffer_used > q->buffer_limit) {
> -		bool same_flow = false;
> -		u32 dropped = 0;
> -		u32 drop_id;
> +	if (q->buffer_used <= q->buffer_limit)
> +		return NET_XMIT_SUCCESS;

While this does reduce indentation, I don't think it's an overall
improvement; the overflow condition is the exceptional case, so it's
clearer to keep it inside the if statement (which also keeps the
variable scope smaller).

> -		while (q->buffer_used > q->buffer_limit) {
> -			dropped++;
> -			drop_id = cake_drop(sch, to_free);
> +	prev_qlen = sch->q.qlen;
> +	prev_backlog = sch->qstats.backlog;
>  
> -			if ((drop_id >> 16) == tin &&
> -			    (drop_id & 0xFFFF) == idx)
> -				same_flow = true;
> -		}
> -		b->drop_overlimit += dropped;
> +	while (q->buffer_used > q->buffer_limit) {
> +		dropped++;
> +		drop_id = cake_drop(sch, to_free);
> +		if ((drop_id >> 16) == tin &&
> +		    (drop_id & 0xFFFF) == idx)
> +			same_flow = true;
> +	}
> +	b->drop_overlimit += dropped;

The 'dropped' variable is wholly redundant after this change, so let's
just get rid of it and use the prev_qlen for this statistic instead.

-Toke

