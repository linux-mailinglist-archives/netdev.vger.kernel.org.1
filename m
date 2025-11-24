Return-Path: <netdev+bounces-241132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C96D6C7FFBE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39AB44E3FBF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259E13B293;
	Mon, 24 Nov 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="qZqJq229"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B02248A5
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981315; cv=none; b=tKTgPI/vyU0Kn1kP5+/bvoAYR3tG3mkqvR7Byz30O4fCDG2apGdlvDFERqNkFQiwN94hMP84bqaO+OwADa38V1P6M0iaq7uc7aGbqMTNZg75Wh53VPqx4RjBAqc0WDkEiFN/x+BAtIVwQ8Sr79ZtcTKQDa1MglwuhhVOwD2cY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981315; c=relaxed/simple;
	bh=1yb3M4hfB/tKbjzz3y5h6f2pqjVegDPjjgujDu0OjoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tRnryVJIFkZ8WzrfF8kyqRtKZVSNmLGs5UqLWE5OoqMg8dADSPDbsEyp3CBkhUjV+XJH6LloIOUIH1NzeySx1SctJy6eFI2v/iaCnmOH0SasiXF4u+LB8U4tWRQrFDLNJUgaEOnhhZ9/g+3fwWDVkx2JwX9yXdIGxjMzP8oJekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=qZqJq229; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1763981301; bh=1yb3M4hfB/tKbjzz3y5h6f2pqjVegDPjjgujDu0OjoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qZqJq229HjzYDpjHhk1uIZgEV+Yk3kD3EwdI+5Fz2BXXf0/ndnxkvIOsFxFSXCLXn
	 FerNXDAs9BD7+bZo+kiL8/r9NKjy+FKV1OiNLcCBz4Ou7eyXxiFNga5uDJpZhWxVAu
	 VIyRh10bGvGoKibYlBpJxOc+FTsrZp2UX8mHqR+zCqVyneWSiN+gdDi4/FLOpj2N+B
	 vUorOeKIsQEarRVdCiKZLCFORoHG/rae3zOTJWQitk9b29lfuuFtQTqLnlaXucAPEl
	 Mc8DH5BqACua4r1J53Znepd1Q53xykfbwgto5D3Llt1X3XS22J3MYFXxYK3MLUQxcN
	 XHHMlOjAEZ3/Q==
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com,
 cake@lists.bufferbloat.net, bestswngs@gmail.com, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v5] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
In-Reply-To: <20251121232735.1020046-1-xmei5@asu.edu>
References: <20251121232735.1020046-1-xmei5@asu.edu>
Date: Mon, 24 Nov 2025 11:48:14 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ms4bn1u9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xiang Mei <xmei5@asu.edu> writes:

> In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> that the parent qdisc will enqueue the current packet. However, this
> assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> accounting inconsistent. This mismatch can lead to a NULL dereference
> (e.g., when the parent Qdisc is qfq_qdisc).
>
> This patch computes the qlen/backlog delta in a more robust way by
> observing the difference before and after the series of cake_drop()
> calls, and then compensates the qdisc tree accounting if cake_enqueue()
> returns NET_XMIT_CN.
>
> To ensure correct compensation when ACK thinning is enabled, a new
> variable is introduced to keep qlen unchanged.
>
> Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: add missing cc
> v3: move qdisc_tree_reduce_backlog out of cake_drop
> v4: remove redundant variable and handle ack branch correctly
> v5: add the PoC as a test case

Please split the test case into its own patch and send both as a series.

Otherwise, the changes LGTM apart from the few nits below:

> ---
>  net/sched/sch_cake.c                          | 52 +++++++++++--------
>  .../tc-testing/tc-tests/qdiscs/cake.json      | 28 ++++++++++
>  2 files changed, 58 insertions(+), 22 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 32bacfc314c2..cf4d6454ca9c 100644
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
> @@ -1750,7 +1749,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	ktime_t now = ktime_get();
>  	struct cake_tin_data *b;
>  	struct cake_flow *flow;
> -	u32 idx, tin;
> +	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
> +	bool same_flow = false;

Please make sure to maintain the reverse x-mas tree ordering of the
variable declarations.

>  
>  	/* choose flow to insert into */
>  	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
> @@ -1823,6 +1823,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		consume_skb(skb);
>  	} else {
>  		/* not splitting */
> +		int ack_pkt_len = 0;
> +
>  		cobalt_set_enqueue_time(skb, now);
>  		get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
>  		flow_queue_add(flow, skb);
> @@ -1834,7 +1836,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  			b->ack_drops++;
>  			sch->qstats.drops++;
>  			b->bytes += qdisc_pkt_len(ack);
> -			len -= qdisc_pkt_len(ack);
> +			ack_pkt_len = qdisc_pkt_len(ack);

There's a qdisc_tree_reduce_backlog() that uses qdisc_pkt_len(ack) just
below this; let's also change that to use ack_pkt_len while we're at it.

>  			q->buffer_used += skb->truesize - ack->truesize;
>  			if (q->rate_flags & CAKE_FLAG_INGRESS)
>  				cake_advance_shaper(q, b, ack, now, true);
> @@ -1848,11 +1850,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  
>  		/* stats */
>  		b->packets++;
> -		b->bytes	    += len;
> -		b->backlogs[idx]    += len;
> -		b->tin_backlog      += len;
> -		sch->qstats.backlog += len;
> -		q->avg_window_bytes += len;
> +		b->bytes	    += len - ack_pkt_len;
> +		b->backlogs[idx]    += len - ack_pkt_len;
> +		b->tin_backlog      += len - ack_pkt_len;
> +		sch->qstats.backlog += len - ack_pkt_len;
> +		q->avg_window_bytes += len - ack_pkt_len;
>  	}
>  
>  	if (q->overflow_timeout)
> @@ -1927,24 +1929,30 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	if (q->buffer_used > q->buffer_max_used)
>  		q->buffer_max_used = q->buffer_used;
>  
> -	if (q->buffer_used > q->buffer_limit) {
> -		bool same_flow = false;
> -		u32 dropped = 0;
> -		u32 drop_id;
> +	if (q->buffer_used <= q->buffer_limit)
> +		return NET_XMIT_SUCCESS;
>  
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
> +		drop_id = cake_drop(sch, to_free);
> +		if ((drop_id >> 16) == tin &&
> +		    (drop_id & 0xFFFF) == idx)
> +			same_flow = true;
> +	}
> +
> +	/* Compute the droppped qlen and pkt length */
> +	prev_qlen -= sch->q.qlen;
> +	prev_backlog -= sch->qstats.backlog;
> +	b->drop_overlimit += prev_backlog;

drop_overlimit was accounted in packets before, so this should be += prev_qlen.

-Toke

