Return-Path: <netdev+bounces-240896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAF1C7BDA5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20333A19C5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647D30AD12;
	Fri, 21 Nov 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NPO5K8Wr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FA2EB847
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763981; cv=none; b=JpjZPtsdG1gHFDXSAmoYNAvbzpd6LxjFNjJLMUgej8L97EKr0NRGuHGx3b+8tkqsfYhwU8GQkJbXodeFAmJ4ahykzltuS4qVCT1xQZTUaS23/+2hhLY5aXXo3nCHMPoEAIvSmX8bZ1av5lOYJaM/xFGdUa9Su+fo9aHXSFndads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763981; c=relaxed/simple;
	bh=ugVj4c4XLNrNMtF20NKbxMgGbvO4bGLS5P0U7fFYtP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtPGocZPhfNEr2GOZ6HkzieIMaCyUqgOI6y4V2Wc6UOYKoGWNYahOBypk7cvbHWwpsrqBKSULekU0gaNgqQfEMUqAKL+evRYErP2uz64kptWdTmPwhkcM9iDmgpl373Zt7zgzalcpdaG5RnpIJB4QZBRcEsYwAnurl/468cPNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NPO5K8Wr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2147274a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763763979; x=1764368779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+aXvindxkc7KUUXaP2TeHzXNGrm9JvSAlbMjmocB9Q=;
        b=NPO5K8Wr7P4JQgh+/dSdD99DZp5GroWYW4PvKLsYyji2pKxW8jp9nYzdp442HXKODz
         h+/wHFIYlWtW27DQuLkGEzQp31OkbNz9hOEwpMHVy80vjyz+f3om5byqwcYLmA4fR+Wc
         1F3YGHAemMVbw1LzzJaIyz8BugqNVcbHJg40TIRMogDYxqCFiAhm04HyoXSkS6IZ3t8G
         GWoqYjnyJVv06fNs0UVMsltMzhBrB646t/skjnriI07KZsMkI1MbJ8EuTRvD4ZqFMdaY
         M2Ovp2k/lFEljmPQjoTWitSJYv6uTsZCnix6B1xR4hqYQ/Z0YtU4L6+OloR7B1tyF7pd
         DwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763763979; x=1764368779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+aXvindxkc7KUUXaP2TeHzXNGrm9JvSAlbMjmocB9Q=;
        b=eY0v/FFB36ZcAj46E73MZFdtoA3qFRwZaVYWr9mfdoluWxBMxg0cxCiZ4XtYWv1rTy
         s1cM4EJB/oF+MPEH211xumgOwtg3xfrY2fFyv4T7f3YCuR6hXlIzYvrDaVyeyWaG7JjO
         IdoYSumdg+eJKZkSkqzWcdheXha5j397w4Y+GAi4G6Bx9607ck1+KVK8N58HipCjuyar
         oJXs5OaW+RFjRXazecxauXB3t4XXfsSoARrTIYhZKC1jN6au7FmvDyCd9GSRZgpKwRhO
         aCcovug+90vRPru6wb7fmNzDtDYwLEYRYFU0XhmcdlzQcWD2ojO+M/F7lDRfmfKIYWm+
         IFLA==
X-Gm-Message-State: AOJu0YysMSpcct/vCag6obLbVVOmihiTe0y8ty2cM8p3bOIlUkcU+hN/
	I1q7OtJen7W5Wt4/RbrRY3fD5jl2C4jZrWOxkHMQcXRHdPKtS2sQiW8LH4Jd/2xdJA==
X-Gm-Gg: ASbGncvzRg61bHoSNqE8P/IxNVMJsA/lVfUGQKXgmDyQhK0xNBEANN0HuJ1sRO42YWP
	5qvGgkIiyN2aeqqnAoBuAx6KQqJoecd2u2pajdeGZfxhd9HJ/IFFJKJvhjUWZwSoMgWEQOHmSxM
	TgYGroLgPmH5gBVStM7DQetYPT932ho1M1dV9vcCivRwVt4Ra4EUY1ASpq46kVSgXY9c7tpRAZZ
	p/pM8ZBjStXatf9jaY2qtC6YhBKvv4jg72hGskOqsNp58z0SfoGhEAmN2gBKpApUaGBM/kW3aG3
	bMqveyXQljTXw5ug+8EYAZ3Yav7pusr8vdpLQeFC62svFMzg+SLjpjm/VHYhBXw/DZQTYF5cmFO
	d+OSig5p258cEU7w7856cQYFPtFHRln2At/qDtcvZywRoN0XJSQSlBbRSpks0/PQ7YbFTm9KrhO
	5eVBkC/RmbzPXyq6Szz/ZP0RW/HQA=
X-Google-Smtp-Source: AGHT+IFRLERDz2rFOTDMUeMsS8Yz4Oy8FSoCEMV6s7E9XetdpFYay4lU2ivFQzZtS8f4qiivAYK04Q==
X-Received: by 2002:a05:693c:8151:b0:2a4:7ea4:3ece with SMTP id 5a478bee46e88-2a7190a307cmr1212595eec.7.1763763978890;
        Fri, 21 Nov 2025 14:26:18 -0800 (PST)
Received: from p1 (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm34957846eec.2.2025.11.21.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 14:26:18 -0800 (PST)
Date: Fri, 21 Nov 2025 15:26:16 -0700
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org, toke@toke.dk, xiyou.wangcong@gmail.com, 
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v4] net/sched: sch_cake: Fix incorrect qlen reduction
 in cake_drop
Message-ID: <mzxmprnusjqma7ykyowwlzxqaezui3enrjav32cukwpzv4i6si@hwhqiabzyotb>
References: <20251121221954.907033-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121221954.907033-1-xmei5@asu.edu>

On Fri, Nov 21, 2025 at 03:19:54PM -0700, Xiang Mei wrote:
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
> ---
>  net/sched/sch_cake.c | 52 +++++++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
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
>  
> -		if (same_flow)
> -			return NET_XMIT_CN;
> +	if (same_flow) {
> +		qdisc_tree_reduce_backlog(sch, prev_qlen - 1,
> +					  prev_backlog - len);
> +		return NET_XMIT_CN;
>  	}
> +	qdisc_tree_reduce_backlog(sch, prev_qlen, prev_backlog);
>  	return NET_XMIT_SUCCESS;
>  }
>  
> -- 
> 2.43.0
>

Thanks Toke for the suggestions and explanations. The new version removes
redundant variable (dropped) and hanles the ack branch correctly.

Original PoC can't crash the patched version and the new patch passed the
self-test cases:
```log
ok 1 1212 - Create CAKE with default setting
ok 2 3281 - Create CAKE with bandwidth limit
ok 3 c940 - Create CAKE with autorate-ingress flag
ok 4 2310 - Create CAKE with rtt time
ok 5 2385 - Create CAKE with besteffort flag
ok 6 a032 - Create CAKE with diffserv8 flag
ok 7 2349 - Create CAKE with diffserv4 flag
ok 8 8472 - Create CAKE with flowblind flag
ok 9 2341 - Create CAKE with dsthost and nat flag
ok 10 5134 - Create CAKE with wash flag
ok 11 2302 - Create CAKE with flowblind and no-split-gso flag
ok 12 0768 - Create CAKE with dual-srchost and ack-filter flag
ok 13 0238 - Create CAKE with dual-dsthost and ack-filter-aggressive flag
ok 14 6572 - Create CAKE with memlimit and ptm flag
ok 15 2436 - Create CAKE with fwmark and atm flag
ok 16 3984 - Create CAKE with overhead and mpu
ok 17 5421 - Create CAKE with conservative and ingress flag
ok 18 6854 - Delete CAKE with conservative and ingress flag
ok 19 2342 - Replace CAKE with mpu
ok 20 2313 - Change CAKE with mpu
ok 21 4365 - Show CAKE class
```

Best,
Xiang

