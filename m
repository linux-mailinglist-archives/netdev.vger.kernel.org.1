Return-Path: <netdev+bounces-238190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3956BC559FE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 05:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2BD4E3709
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6826461F;
	Thu, 13 Nov 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="go9YtWi4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D11EB9E3
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006766; cv=none; b=SE0/1K39MWKMt/bYIbk9utIlTWRsY8hZekZiIXtn7A7m31P+Owa1Hm/jP6Y3xP8twbZfxf1UnPnA/APamH+qcu7QQGi2AZsHjfx722n/CgJeXd41kDcahZ3Xm/q7EtIdV0gFz+02zeZV6t+R6MrXs1SIl6LBu4TOcc0ATgM6Epc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006766; c=relaxed/simple;
	bh=vx9MWxOi+QmlQCIQgELsJmPGv+V2H68DIRE94Eg8a1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqpbLUMrDB2aMWZXfwfWK4l0ipcPf7bH0Ig9B9dDDSPyrrP/EhUXiIKhiimEzEr+spIDuD9Ez/9826zTpuXvlDex55u9FI/fgVPWvTNNTRMq/W57T5s+uy0a4pdq9ljT5g+6+UJx9esBGAtGog1SVeNPKeksjiTF3dQst1Hh7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=go9YtWi4; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45030c45371so166510b6e.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 20:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763006761; x=1763611561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9zz0xslH/LPN0+Jg1QGCGjc2cuXrA8U9GcfZOgWYHM=;
        b=go9YtWi438y2YWUhcVcAq0KjEczCyPprhKuQe6889MGF8WRh46fXLcirMGC7mLfSPX
         wuM2VXayKoqKnGOdhHCpK77OClmW6QVmPMIlJp7rAcqRkkY3xBRXtT3tFA7PN+TpAN9f
         Tt0PwtKJNiZm/bQm3ktm8h48UViFu7JadoKsIPV7iZlhGQ8OQu4pxy8VrX/ogP1Tl30l
         pAEvyUprT3GJD4EEbLOfqIbku4yV78xcPQQjOQLnH1OuwW5S/PsmGs9mUYvYDB7LZMeM
         QXR9AWiKWC+FxVBQ75UaZlO00VXA0HTxvUmUly7rHAbm3iP73AWqn8YWesqsW1C63rJg
         rcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763006761; x=1763611561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9zz0xslH/LPN0+Jg1QGCGjc2cuXrA8U9GcfZOgWYHM=;
        b=t3paNWj0Y0MqJ00Hh2ko82RV7CdqZKt9VzXTC2vlQdAIQJ4Jj9AO3QknJ3ZSlsA7sT
         CO7u8F1zTScr5iPgfn//xEn3LQIchZ6IeYwduckul46D7Mwj4AOEl+4M7KWXRU+YoEho
         v9rHwUwmMuYerxTY1M/Ce80oT6EDgkbDKnQu8u5D3PNG4y3L/9Azo1TslcWST6j27EUI
         UzYGUId90o/9fF9Y4AHzZSecsL7comxrXDN0/1nDztpJ3l71L9w5ABeR6p3V2AUbd9Jt
         gZ8Br69fysP7Vk+/3t5rAVmbzkX7fOwFWJmfFABRirRkGo0RIalRN4wsjLM5sf+j8YBj
         +RBA==
X-Gm-Message-State: AOJu0YytYrGeVq51YVzt3S6oqcDy8e9neBbUjgrGwCvGPwU+E5x5O+SP
	lLWhm/43mwQNF0rCWQKX5WKfEpEc3EQu5cpkiutsxLwVbvBlU9xqaNNE1GCBgCaEalXjmVKJXh1
	ixzI=
X-Gm-Gg: ASbGncuQDAq2RNOVTPd3iqTE13Gb+NYceVDn/z7A7TxW/xFMYqMSDHP6sSvJPvbE6OI
	1pt0qgfEZBvOu5AveCR7t7nfqmTuDifjPQR+u5d3Hsc79X1+CWcxQR0QoRG/SdndyjMqPSNvYIK
	RNa5/ea3GazqgUcQ29riVR6hfATYC8X7wG6RObinUXcZvXGic2pqsFxQdiZ4tuMyHlJc73DEjOD
	OYBk+SRe8A0gTTmBz3X2QsJBkH6qUDG/v5pgU0wAXQjOEOJ49di8XAPMCmrr5VAfzf+kKrtR0yg
	s5pTGa4l6I0IPzwalAS5OHopBuOGuBbWaJVniQk8KMXXsP34ijiFaMQa7ocSGfrWFdR1zgobDsh
	i9GLnzN3NRcxVmwoQDsSMcl/TNUJjRE9uljIj3egZIYlY2Im3dCsMjOuGFpUm9seRCd4j2C+T/u
	MloGbvr7e3DrGil5Ge
X-Google-Smtp-Source: AGHT+IFjhw6PEACSVDzbXsL+3dJh/sE0YMUVqW/BTn2ChI57pQzedU1QRn8C1Lugbn+7VEqlX+HHog==
X-Received: by 2002:a05:6808:4f69:b0:44d:a3ed:ccfc with SMTP id 5614622812f47-45074549bbbmr2332025b6e.36.1763006761164;
        Wed, 12 Nov 2025 20:06:01 -0800 (PST)
Received: from p1 (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65724dd7c86sm462957eaf.13.2025.11.12.20.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:06:00 -0800 (PST)
Date: Wed, 12 Nov 2025 21:05:58 -0700
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org, toke@toke.dk, cake@lists.bufferbloat.net,
	bestswngs@gmail.com
Subject: Re: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen reduction
 in cake_drop
Message-ID: <aRVZJmTAWyrnXpCJ@p1>
References: <20251113035303.51165-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113035303.51165-1-xmei5@asu.edu>

On Wed, Nov 12, 2025 at 08:53:03PM -0700, Xiang Mei wrote:
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
> +		dropped++;
> +		drop_id = cake_drop(sch, to_free);
> +		if ((drop_id >> 16) == tin &&
> +		    (drop_id & 0xFFFF) == idx)
> +			same_flow = true;
> +	}
> +	b->drop_overlimit += dropped;
> +
> +	/* Compute the droppped qlen and pkt length */
> +	prev_qlen -= sch->q.qlen;
> +	prev_backlog -= sch->qstats.backlog;
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

Thank Toke for the suggestion to move qdisc_tree_reduce_backlog out of
cake_drop. It makes the logic cleaner.

The patch passed CAKE's self-test:
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

There is still one problem I am not very sure since I am not very 
experienced with cake and gso. It's about the gso branch [1]. The slen 
is the lenth added to the cake sch and that branch uses 
`qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);` to inform the 
parent sched. However, when we drop the packet, it could be probmatic 
since we should reduce slen instead of len. Is this a potential problem?

[1] https://elixir.bootlin.com/linux/v6.6.116/source/net/sched/sch_cake.c#L1803

Thanks,
Xiang

