Return-Path: <netdev+bounces-247483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9660CFB2DD
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABF4D300EA15
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2F92D7D2F;
	Tue,  6 Jan 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKWHeoeI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8E2D1F6B
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736639; cv=none; b=UiEsLNqa/JOpgO3ofTOBtie8Y/2POdC7fjqvd8465cxlHjzWx6ouoiumsGRq3SMRUKxXWhk2m1Ih6DDOYsAjZb4ZltmX83J+4ammWsFdKou11+7GjnRV96apPXHBMz8TbwfCyL3/s9vmWoaQ6roTtToCJnX/64O3MQj+Rh2i140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736639; c=relaxed/simple;
	bh=8uYtNLgiR3tQJsh5NXZ803DECF5yF7cTzP7+1LLqQ2E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HkoDtGxBGdnZRRkWOphjLYNHLX3kLF7WA+Q8yK3A0Dd1TpJUsghe8M/hWrl7IXTm5Sdq1I3GonpEaBR79oJgyuBtMyctbGWSitcF0NtwQBQi2ePD5scooBOVsvPJusRQ/XfhhpUjarK74EQUIGSnht9uzvu0Mkw/7TT/ItzfLYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKWHeoeI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79045634f45so17592017b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 13:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767736636; x=1768341436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c7sTn/Py5FZZ3UkQZ4CbjYlT8RY3X2GxydVfX4G0nc=;
        b=iKWHeoeI6wi5eNnmLCGJ9KX5tesg9aLjQgJcvhzDSGUaOupE6/VyHruqh99zCypn+5
         D6Iyslitk3s/hOr3645qbmbm1rCHUhtFsFqvl0uiwMajql7EJ5yMVquqeJEwd61cS9di
         xI9rq97YnSkUKRGBkVc3Q/PZ5ArJ7+0q0O9JayHSYatPYM0YFXRKC/1T+emphZPINsJR
         FEBEcjh7b06c8QCRS+YsiQCcEptM4K07DgVRozgLEYl6MLsDeyHuXOTMleomjJfPrWfN
         DFylvtM/hgwXnZS55vb5BNCaiB8gRWw0FLIbbsKlxwIuwk8/AvQkKlDSOVp4OM1ai+Ck
         zO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767736636; x=1768341436;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9c7sTn/Py5FZZ3UkQZ4CbjYlT8RY3X2GxydVfX4G0nc=;
        b=KrNRytllHe9lyzgB6KDeXiqa7gOf+1b1/OItTeixeVXVwZv9YLV9ejQr+ytRoh/3z3
         Ef0buMqaG6FGxX1ZCbcr25H/B2J4JcSy4zpomesaU7sVbqw4PWVG2fHnGPy/jAPQqsXR
         HnVx8d6IbTvRlJ9eki86kToisKCrRUJNexDYW4SkAxxelxuHve+bLl9i+r5okLXrtFlD
         +MY+6FVpyeQzJufWz/GCyZrv6pYRsIZt2uMkr5JdEJVo1S93h5l4c7Ro+iofuT0tpOTi
         bQ1n4TaP7s5Arx+RGD72kZgRX4sgXojCv5Ixxy5WTw25A3/FyHgN7TE+R5WNtSh+k8BK
         AnbA==
X-Forwarded-Encrypted: i=1; AJvYcCWhehl3pEmHuQsz9V4gYigRPOeW4iEUC/h5EVHi8qd309Tziz/7KVvIYprCEOtzrZ9MJUe+B6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzDn8Z++PYmlEHV9//4CPxWQcFjf5zxV4OYYHxS+RrI825E0x
	Q9tE5WNsrURJGMOlvtTCxFTaKbynLtdBnsiADj2NcC0mcIfXr5nsY9/k
X-Gm-Gg: AY/fxX4rarG1+a08R3AEMaPoonwdBN81/Hr/NxNx9b+rXziKMFqRZa9pdxcNhRPFVxr
	4BWsvgfXoZjaWN8GRPDfhIX2cEe41J6Cyk92Hfp0KxvFXM2LQJobx0SMaS9cZlXONjGzyttDQyW
	Fl8kCU5jTyhniZ35y6eGX2IomDvKGqLeRYE0z1E3KhEmA8jFQc82fCT6SANJByNkov7mSV1QoWH
	e6LCjbo9YPGcq5aab+MCmjwwxfqpA2ZZcwo8fzN0EiHGLNK5TizaVAWt/8w57S3YsVog68XgjwD
	k+MENz7i3C++tJKhUCBsm+BMbdFH1duo8Uq0iaWkR/79E5CVNW90fI6AW8RnH32gddJUaTUDBDD
	ZCSUkF9NCXbvKY81lS7v1hc2SFXD7a2NL2ewxhHcscR+GbAkKVFkXrfv5mNc/K7zojety+76mO+
	MBk/jE6kdD/fyH2xpCvSyUI9diRXaxLs9VSaiUO7kkj0wr8M7wlPJclKEp0pA=
X-Google-Smtp-Source: AGHT+IG9iV1FmB161RLJvM/93cGPVGoILduBsAQcdMQ+GL7bnAh+34oxutqFi/uzefh9XlSADMZFiA==
X-Received: by 2002:a05:690e:1186:b0:642:836:1048 with SMTP id 956f58d0204a3-64716b39bc9mr444475d50.2.1767736636502;
        Tue, 06 Jan 2026 13:57:16 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa670b21sm11884687b3.33.2026.01.06.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 13:57:15 -0800 (PST)
Date: Tue, 06 Jan 2026 16:57:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Message-ID: <willemdebruijn.kernel.21e0da676fe64@gmail.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-2-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
 <20260106-mq-cake-sub-qdisc-v6-2-ee2e06b1eb1a@redhat.com>
Subject: Re: [PATCH net-next v6 2/6] net/sched: sch_cake: Factor out config
 variables into separate struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Factor out all the user-configurable variables into a separate struct
> and embed it into struct cake_sched_data. This is done in preparation
> for sharing the configuration across multiple instances of cake in an m=
q
> setup.
> =

> No functional change is intended with this patch.
> =

> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/sched/sch_cake.c | 245 ++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 133 insertions(+), 112 deletions(-)
> =

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 4a64d6397b6f..d458257d8afc 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -197,40 +197,42 @@ struct cake_tin_data {
>  	u32	way_collisions;
>  }; /* number of tins is small, so size of this struct doesn't matter m=
uch */
>  =

> +struct cake_sched_config {
> +	u64		rate_bps;
> +	u64		interval;
> +	u64		target;
> +	u32		buffer_config_limit;
> +	u32		fwmark_mask;
> +	u16		fwmark_shft;
> +	s16		rate_overhead;
> +	u16		rate_mpu;
> +	u16		rate_flags;
> +	u8		tin_mode;
> +	u8		flow_mode;
> +	u8		atm_mode;
> +	u8		ack_filter;
> +};
> +
>  struct cake_sched_data {
>  	struct tcf_proto __rcu *filter_list; /* optional external classifier =
*/
>  	struct tcf_block *block;
>  	struct cake_tin_data *tins;
> +	struct cake_sched_config *config;
>  =

>  	struct cake_heap_entry overflow_heap[CAKE_QUEUES * CAKE_MAX_TINS];
> -	u16		overflow_timeout;
> -
> -	u16		tin_cnt;
> -	u8		tin_mode;
> -	u8		flow_mode;
> -	u8		ack_filter;
> -	u8		atm_mode;
> -
> -	u32		fwmark_mask;
> -	u16		fwmark_shft;
>  =

>  	/* time_next =3D time_this + ((len * rate_ns) >> rate_shft) */
> -	u16		rate_shft;
>  	ktime_t		time_next_packet;
>  	ktime_t		failsafe_next_packet;
>  	u64		rate_ns;
> -	u64		rate_bps;
> -	u16		rate_flags;
> -	s16		rate_overhead;
> -	u16		rate_mpu;
> -	u64		interval;
> -	u64		target;
> +	u16		rate_shft;
> +	u16		overflow_timeout;
> +	u16		tin_cnt;
>  =

>  	/* resource tracking */
>  	u32		buffer_used;
>  	u32		buffer_max_used;
>  	u32		buffer_limit;
> -	u32		buffer_config_limit;
>  =

>  	/* indices for dequeue */
>  	u16		cur_tin;
> @@ -1198,7 +1200,7 @@ static bool cake_tcph_may_drop(const struct tcphd=
r *tcph,
>  static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
>  				       struct cake_flow *flow)
>  {
> -	bool aggressive =3D q->ack_filter =3D=3D CAKE_ACK_AGGRESSIVE;
> +	bool aggressive =3D q->config->ack_filter =3D=3D CAKE_ACK_AGGRESSIVE;=

>  	struct sk_buff *elig_ack =3D NULL, *elig_ack_prev =3D NULL;
>  	struct sk_buff *skb_check, *skb_prev =3D NULL;
>  	const struct ipv6hdr *ipv6h, *ipv6h_check;
> @@ -1358,15 +1360,17 @@ static u64 cake_ewma(u64 avg, u64 sample, u32 s=
hift)
>  	return avg;
>  }
>  =

> -static u32 cake_calc_overhead(struct cake_sched_data *q, u32 len, u32 =
off)
> +static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32=
 off)
>  {
> +	struct cake_sched_config *q =3D qd->config;
> +
>  	if (q->rate_flags & CAKE_FLAG_OVERHEAD)
>  		len -=3D off;
>  =

> -	if (q->max_netlen < len)
> -		q->max_netlen =3D len;
> -	if (q->min_netlen > len)
> -		q->min_netlen =3D len;
> +	if (qd->max_netlen < len)
> +		qd->max_netlen =3D len;
> +	if (qd->min_netlen > len)
> +		qd->min_netlen =3D len;
>  =

>  	len +=3D q->rate_overhead;
>  =

> @@ -1385,10 +1389,10 @@ static u32 cake_calc_overhead(struct cake_sched=
_data *q, u32 len, u32 off)
>  		len +=3D (len + 63) / 64;
>  	}
>  =

> -	if (q->max_adjlen < len)
> -		q->max_adjlen =3D len;
> -	if (q->min_adjlen > len)
> -		q->min_adjlen =3D len;
> +	if (qd->max_adjlen < len)
> +		qd->max_adjlen =3D len;
> +	if (qd->min_adjlen > len)
> +		qd->min_adjlen =3D len;
>  =

>  	return len;
>  }
> @@ -1586,7 +1590,7 @@ static unsigned int cake_drop(struct Qdisc *sch, =
struct sk_buff **to_free)
>  	flow->dropped++;
>  	b->tin_dropped++;
>  =

> -	if (q->rate_flags & CAKE_FLAG_INGRESS)
> +	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>  		cake_advance_shaper(q, b, skb, now, true);
>  =

>  	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT)=
;
> @@ -1656,7 +1660,8 @@ static u8 cake_handle_diffserv(struct sk_buff *sk=
b, bool wash)
>  static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
>  					     struct sk_buff *skb)
>  {
> -	struct cake_sched_data *q =3D qdisc_priv(sch);
> +	struct cake_sched_data *qd =3D qdisc_priv(sch);
> +	struct cake_sched_config *q =3D qd->config;
>  	u32 tin, mark;
>  	bool wash;
>  	u8 dscp;
> @@ -1673,24 +1678,24 @@ static struct cake_tin_data *cake_select_tin(st=
ruct Qdisc *sch,
>  	if (q->tin_mode =3D=3D CAKE_DIFFSERV_BESTEFFORT)
>  		tin =3D 0;
>  =

> -	else if (mark && mark <=3D q->tin_cnt)
> -		tin =3D q->tin_order[mark - 1];
> +	else if (mark && mark <=3D qd->tin_cnt)
> +		tin =3D qd->tin_order[mark - 1];
>  =

>  	else if (TC_H_MAJ(skb->priority) =3D=3D sch->handle &&
>  		 TC_H_MIN(skb->priority) > 0 &&
> -		 TC_H_MIN(skb->priority) <=3D q->tin_cnt)
> -		tin =3D q->tin_order[TC_H_MIN(skb->priority) - 1];
> +		 TC_H_MIN(skb->priority) <=3D qd->tin_cnt)
> +		tin =3D qd->tin_order[TC_H_MIN(skb->priority) - 1];
>  =

>  	else {
>  		if (!wash)
>  			dscp =3D cake_handle_diffserv(skb, wash);
> -		tin =3D q->tin_index[dscp];
> +		tin =3D qd->tin_index[dscp];
>  =

> -		if (unlikely(tin >=3D q->tin_cnt))
> +		if (unlikely(tin >=3D qd->tin_cnt))
>  			tin =3D 0;
>  	}
>  =

> -	return &q->tins[tin];
> +	return &qd->tins[tin];
>  }
>  =

>  static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> @@ -1746,7 +1751,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  	bool same_flow =3D false;
>  =

>  	/* choose flow to insert into */
> -	idx =3D cake_classify(sch, &b, skb, q->flow_mode, &ret);
> +	idx =3D cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
>  	if (idx =3D=3D 0) {
>  		if (ret & __NET_XMIT_BYPASS)
>  			qdisc_qstats_drop(sch);
> @@ -1781,7 +1786,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  	if (unlikely(len > b->max_skblen))
>  		b->max_skblen =3D len;
>  =

> -	if (qdisc_pkt_segs(skb) > 1 && q->rate_flags & CAKE_FLAG_SPLIT_GSO) {=

> +	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLI=
T_GSO) {
>  		struct sk_buff *segs, *nskb;
>  		netdev_features_t features =3D netif_skb_features(skb);
>  		unsigned int slen =3D 0, numsegs =3D 0;
> @@ -1823,7 +1828,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  		get_cobalt_cb(skb)->adjusted_len =3D cake_overhead(q, skb);
>  		flow_queue_add(flow, skb);
>  =

> -		if (q->ack_filter)
> +		if (q->config->ack_filter)
>  			ack =3D cake_ack_filter(q, flow);
>  =

>  		if (ack) {
> @@ -1832,7 +1837,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  			ack_pkt_len =3D qdisc_pkt_len(ack);
>  			b->bytes +=3D ack_pkt_len;
>  			q->buffer_used +=3D skb->truesize - ack->truesize;
> -			if (q->rate_flags & CAKE_FLAG_INGRESS)
> +			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>  				cake_advance_shaper(q, b, ack, now, true);
>  =

>  			qdisc_tree_reduce_backlog(sch, 1, ack_pkt_len);
> @@ -1855,7 +1860,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  		cake_heapify_up(q, b->overflow_idx[idx]);
>  =

>  	/* incoming bandwidth capacity estimate */
> -	if (q->rate_flags & CAKE_FLAG_AUTORATE_INGRESS) {
> +	if (q->config->rate_flags & CAKE_FLAG_AUTORATE_INGRESS) {
>  		u64 packet_interval =3D \
>  			ktime_to_ns(ktime_sub(now, q->last_packet_time));
>  =

> @@ -1887,7 +1892,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  			if (ktime_after(now,
>  					ktime_add_ms(q->last_reconfig_time,
>  						     250))) {
> -				q->rate_bps =3D (q->avg_peak_bandwidth * 15) >> 4;
> +				q->config->rate_bps =3D (q->avg_peak_bandwidth * 15) >> 4;
>  				cake_reconfigure(sch);
>  			}
>  		}
> @@ -1907,7 +1912,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  		flow->set =3D CAKE_SET_SPARSE;
>  		b->sparse_flow_count++;
>  =

> -		flow->deficit =3D cake_get_flow_quantum(b, flow, q->flow_mode);
> +		flow->deficit =3D cake_get_flow_quantum(b, flow, q->config->flow_mod=
e);
>  	} else if (flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
>  		/* this flow was empty, accounted as a sparse flow, but actually
>  		 * in the bulk rotation.
> @@ -1916,8 +1921,8 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  		b->sparse_flow_count--;
>  		b->bulk_flow_count++;
>  =

> -		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
> -		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
> +		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
> +		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
>  	}
>  =

>  	if (q->buffer_used > q->buffer_max_used)
> @@ -2104,8 +2109,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  				b->sparse_flow_count--;
>  				b->bulk_flow_count++;
>  =

> -				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
> -				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
> +				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
> +				cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
>  =

>  				flow->set =3D CAKE_SET_BULK;
>  			} else {
> @@ -2117,7 +2122,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  			}
>  		}
>  =

> -		flow->deficit +=3D cake_get_flow_quantum(b, flow, q->flow_mode);
> +		flow->deficit +=3D cake_get_flow_quantum(b, flow, q->config->flow_mo=
de);
>  		list_move_tail(&flow->flowchain, &b->old_flows);
>  =

>  		goto retry;
> @@ -2141,8 +2146,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  				if (flow->set =3D=3D CAKE_SET_BULK) {
>  					b->bulk_flow_count--;
>  =

> -					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
> -					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
> +					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
> +					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
>  =

>  					b->decaying_flow_count++;
>  				} else if (flow->set =3D=3D CAKE_SET_SPARSE ||
> @@ -2160,8 +2165,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  				else if (flow->set =3D=3D CAKE_SET_BULK) {
>  					b->bulk_flow_count--;
>  =

> -					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
> -					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
> +					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
> +					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
>  				} else
>  					b->decaying_flow_count--;
>  =

> @@ -2172,14 +2177,14 @@ static struct sk_buff *cake_dequeue(struct Qdis=
c *sch)
>  =

>  		reason =3D cobalt_should_drop(&flow->cvars, &b->cparams, now, skb,
>  					    (b->bulk_flow_count *
> -					     !!(q->rate_flags &
> +					     !!(q->config->rate_flags &
>  						CAKE_FLAG_INGRESS)));
>  		/* Last packet in queue may be marked, shouldn't be dropped */
>  		if (reason =3D=3D SKB_NOT_DROPPED_YET || !flow->head)
>  			break;
>  =

>  		/* drop this packet, get another one */
> -		if (q->rate_flags & CAKE_FLAG_INGRESS) {
> +		if (q->config->rate_flags & CAKE_FLAG_INGRESS) {
>  			len =3D cake_advance_shaper(q, b, skb,
>  						  now, true);
>  			flow->deficit -=3D len;
> @@ -2190,7 +2195,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
>  		qdisc_qstats_drop(sch);
>  		qdisc_dequeue_drop(sch, skb, reason);
> -		if (q->rate_flags & CAKE_FLAG_INGRESS)
> +		if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>  			goto retry;
>  	}
>  =

> @@ -2312,7 +2317,7 @@ static int cake_config_besteffort(struct Qdisc *s=
ch)
>  	struct cake_sched_data *q =3D qdisc_priv(sch);
>  	struct cake_tin_data *b =3D &q->tins[0];
>  	u32 mtu =3D psched_mtu(qdisc_dev(sch));
> -	u64 rate =3D q->rate_bps;
> +	u64 rate =3D q->config->rate_bps;
>  =

>  	q->tin_cnt =3D 1;
>  =

> @@ -2320,7 +2325,7 @@ static int cake_config_besteffort(struct Qdisc *s=
ch)
>  	q->tin_order =3D normal_order;
>  =

>  	cake_set_rate(b, rate, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  	b->tin_quantum =3D 65535;
>  =

>  	return 0;
> @@ -2331,7 +2336,7 @@ static int cake_config_precedence(struct Qdisc *s=
ch)
>  	/* convert high-level (user visible) parameters into internal format =
*/
>  	struct cake_sched_data *q =3D qdisc_priv(sch);
>  	u32 mtu =3D psched_mtu(qdisc_dev(sch));
> -	u64 rate =3D q->rate_bps;
> +	u64 rate =3D q->config->rate_bps;
>  	u32 quantum =3D 256;
>  	u32 i;
>  =

> @@ -2342,8 +2347,8 @@ static int cake_config_precedence(struct Qdisc *s=
ch)
>  	for (i =3D 0; i < q->tin_cnt; i++) {
>  		struct cake_tin_data *b =3D &q->tins[i];
>  =

> -		cake_set_rate(b, rate, mtu, us_to_ns(q->target),
> -			      us_to_ns(q->interval));
> +		cake_set_rate(b, rate, mtu, us_to_ns(q->config->target),
> +			      us_to_ns(q->config->interval));
>  =

>  		b->tin_quantum =3D max_t(u16, 1U, quantum);
>  =

> @@ -2420,7 +2425,7 @@ static int cake_config_diffserv8(struct Qdisc *sc=
h)
>  =

>  	struct cake_sched_data *q =3D qdisc_priv(sch);
>  	u32 mtu =3D psched_mtu(qdisc_dev(sch));
> -	u64 rate =3D q->rate_bps;
> +	u64 rate =3D q->config->rate_bps;
>  	u32 quantum =3D 256;
>  	u32 i;
>  =

> @@ -2434,8 +2439,8 @@ static int cake_config_diffserv8(struct Qdisc *sc=
h)
>  	for (i =3D 0; i < q->tin_cnt; i++) {
>  		struct cake_tin_data *b =3D &q->tins[i];
>  =

> -		cake_set_rate(b, rate, mtu, us_to_ns(q->target),
> -			      us_to_ns(q->interval));
> +		cake_set_rate(b, rate, mtu, us_to_ns(q->config->target),
> +			      us_to_ns(q->config->interval));
>  =

>  		b->tin_quantum =3D max_t(u16, 1U, quantum);
>  =

> @@ -2464,7 +2469,7 @@ static int cake_config_diffserv4(struct Qdisc *sc=
h)
>  =

>  	struct cake_sched_data *q =3D qdisc_priv(sch);
>  	u32 mtu =3D psched_mtu(qdisc_dev(sch));
> -	u64 rate =3D q->rate_bps;
> +	u64 rate =3D q->config->rate_bps;
>  	u32 quantum =3D 1024;
>  =

>  	q->tin_cnt =3D 4;
> @@ -2475,13 +2480,13 @@ static int cake_config_diffserv4(struct Qdisc *=
sch)
>  =

>  	/* class characteristics */
>  	cake_set_rate(&q->tins[0], rate, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  	cake_set_rate(&q->tins[1], rate >> 4, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  	cake_set_rate(&q->tins[2], rate >> 1, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  	cake_set_rate(&q->tins[3], rate >> 2, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  =

>  	/* bandwidth-sharing weights */
>  	q->tins[0].tin_quantum =3D quantum;
> @@ -2501,7 +2506,7 @@ static int cake_config_diffserv3(struct Qdisc *sc=
h)
>   */
>  	struct cake_sched_data *q =3D qdisc_priv(sch);
>  	u32 mtu =3D psched_mtu(qdisc_dev(sch));
> -	u64 rate =3D q->rate_bps;
> +	u64 rate =3D q->config->rate_bps;
>  	u32 quantum =3D 1024;
>  =

>  	q->tin_cnt =3D 3;
> @@ -2512,11 +2517,11 @@ static int cake_config_diffserv3(struct Qdisc *=
sch)
>  =

>  	/* class characteristics */
>  	cake_set_rate(&q->tins[0], rate, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  	cake_set_rate(&q->tins[1], rate >> 4, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  	cake_set_rate(&q->tins[2], rate >> 2, mtu,
> -		      us_to_ns(q->target), us_to_ns(q->interval));
> +		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
>  =

>  	/* bandwidth-sharing weights */
>  	q->tins[0].tin_quantum =3D quantum;
> @@ -2528,7 +2533,8 @@ static int cake_config_diffserv3(struct Qdisc *sc=
h)
>  =

>  static void cake_reconfigure(struct Qdisc *sch)
>  {
> -	struct cake_sched_data *q =3D qdisc_priv(sch);
> +	struct cake_sched_data *qd =3D qdisc_priv(sch);
> +	struct cake_sched_config *q =3D qd->config;
>  	int c, ft;
>  =

>  	switch (q->tin_mode) {
> @@ -2554,36 +2560,37 @@ static void cake_reconfigure(struct Qdisc *sch)=

>  		break;
>  	}
>  =

> -	for (c =3D q->tin_cnt; c < CAKE_MAX_TINS; c++) {
> +	for (c =3D qd->tin_cnt; c < CAKE_MAX_TINS; c++) {
>  		cake_clear_tin(sch, c);
> -		q->tins[c].cparams.mtu_time =3D q->tins[ft].cparams.mtu_time;
> +		qd->tins[c].cparams.mtu_time =3D qd->tins[ft].cparams.mtu_time;
>  	}
>  =

> -	q->rate_ns   =3D q->tins[ft].tin_rate_ns;
> -	q->rate_shft =3D q->tins[ft].tin_rate_shft;
> +	qd->rate_ns   =3D qd->tins[ft].tin_rate_ns;
> +	qd->rate_shft =3D qd->tins[ft].tin_rate_shft;
>  =

>  	if (q->buffer_config_limit) {
> -		q->buffer_limit =3D q->buffer_config_limit;
> +		qd->buffer_limit =3D q->buffer_config_limit;
>  	} else if (q->rate_bps) {
>  		u64 t =3D q->rate_bps * q->interval;
>  =

>  		do_div(t, USEC_PER_SEC / 4);
> -		q->buffer_limit =3D max_t(u32, t, 4U << 20);
> +		qd->buffer_limit =3D max_t(u32, t, 4U << 20);
>  	} else {
> -		q->buffer_limit =3D ~0;
> +		qd->buffer_limit =3D ~0;
>  	}
>  =

>  	sch->flags &=3D ~TCQ_F_CAN_BYPASS;
>  =

> -	q->buffer_limit =3D min(q->buffer_limit,
> -			      max(sch->limit * psched_mtu(qdisc_dev(sch)),
> -				  q->buffer_config_limit));
> +	qd->buffer_limit =3D min(qd->buffer_limit,
> +			       max(sch->limit * psched_mtu(qdisc_dev(sch)),
> +				   q->buffer_config_limit));
>  }
>  =

>  static int cake_change(struct Qdisc *sch, struct nlattr *opt,
>  		       struct netlink_ext_ack *extack)
>  {
> -	struct cake_sched_data *q =3D qdisc_priv(sch);
> +	struct cake_sched_data *qd =3D qdisc_priv(sch);
> +	struct cake_sched_config *q =3D qd->config;
>  	struct nlattr *tb[TCA_CAKE_MAX + 1];
>  	u16 rate_flags;
>  	u8 flow_mode;
> @@ -2637,19 +2644,19 @@ static int cake_change(struct Qdisc *sch, struc=
t nlattr *opt,
>  			   nla_get_s32(tb[TCA_CAKE_OVERHEAD]));
>  		rate_flags |=3D CAKE_FLAG_OVERHEAD;
>  =

> -		q->max_netlen =3D 0;
> -		q->max_adjlen =3D 0;
> -		q->min_netlen =3D ~0;
> -		q->min_adjlen =3D ~0;
> +		qd->max_netlen =3D 0;
> +		qd->max_adjlen =3D 0;
> +		qd->min_netlen =3D ~0;
> +		qd->min_adjlen =3D ~0;
>  	}
>  =

>  	if (tb[TCA_CAKE_RAW]) {
>  		rate_flags &=3D ~CAKE_FLAG_OVERHEAD;
>  =

> -		q->max_netlen =3D 0;
> -		q->max_adjlen =3D 0;
> -		q->min_netlen =3D ~0;
> -		q->min_adjlen =3D ~0;
> +		qd->max_netlen =3D 0;
> +		qd->max_adjlen =3D 0;
> +		qd->min_netlen =3D ~0;
> +		qd->min_adjlen =3D ~0;
>  	}
>  =

>  	if (tb[TCA_CAKE_MPU])
> @@ -2705,7 +2712,7 @@ static int cake_change(struct Qdisc *sch, struct =
nlattr *opt,
>  =

>  	WRITE_ONCE(q->rate_flags, rate_flags);
>  	WRITE_ONCE(q->flow_mode, flow_mode);
> -	if (q->tins) {
> +	if (qd->tins) {
>  		sch_tree_lock(sch);
>  		cake_reconfigure(sch);
>  		sch_tree_unlock(sch);
> @@ -2721,14 +2728,20 @@ static void cake_destroy(struct Qdisc *sch)
>  	qdisc_watchdog_cancel(&q->watchdog);
>  	tcf_block_put(q->block);
>  	kvfree(q->tins);
> +	kvfree(q->config);
>  }
>  =

>  static int cake_init(struct Qdisc *sch, struct nlattr *opt,
>  		     struct netlink_ext_ack *extack)
>  {
> -	struct cake_sched_data *q =3D qdisc_priv(sch);
> +	struct cake_sched_data *qd =3D qdisc_priv(sch);
> +	struct cake_sched_config *q;
>  	int i, j, err;
>  =

> +	q =3D kvcalloc(1, sizeof(struct cake_sched_config), GFP_KERNEL);
> +	if (!q)
> +		return -ENOMEM;
> +

Can this just be a regular kzalloc?

More importantly, where is q assigned to qd->config after init?

>  	sch->limit =3D 10240;
>  	sch->flags |=3D TCQ_F_DEQUEUE_DROPS;
>  =

> @@ -2742,33 +2755,36 @@ static int cake_init(struct Qdisc *sch, struct =
nlattr *opt,
>  			       * for 5 to 10% of interval
>  			       */
>  	q->rate_flags |=3D CAKE_FLAG_SPLIT_GSO;
> -	q->cur_tin =3D 0;
> -	q->cur_flow  =3D 0;
> +	qd->cur_tin =3D 0;
> +	qd->cur_flow  =3D 0;
> +	qd->config =3D q;
>  =

> -	qdisc_watchdog_init(&q->watchdog, sch);
> +	qdisc_watchdog_init(&qd->watchdog, sch);
>  =

>  	if (opt) {
>  		err =3D cake_change(sch, opt, extack);
>  =

>  		if (err)
> -			return err;
> +			goto err;
>  	}
>  =

> -	err =3D tcf_block_get(&q->block, &q->filter_list, sch, extack);
> +	err =3D tcf_block_get(&qd->block, &qd->filter_list, sch, extack);
>  	if (err)
> -		return err;
> +		goto err;
>  =

>  	quantum_div[0] =3D ~0;
>  	for (i =3D 1; i <=3D CAKE_QUEUES; i++)
>  		quantum_div[i] =3D 65535 / i;
>  =

> -	q->tins =3D kvcalloc(CAKE_MAX_TINS, sizeof(struct cake_tin_data),
> -			   GFP_KERNEL);
> -	if (!q->tins)
> -		return -ENOMEM;
> +	qd->tins =3D kvcalloc(CAKE_MAX_TINS, sizeof(struct cake_tin_data),
> +			    GFP_KERNEL);
> +	if (!qd->tins) {
> +		err =3D -ENOMEM;
> +		goto err;
> +	}
>  =

>  	for (i =3D 0; i < CAKE_MAX_TINS; i++) {
> -		struct cake_tin_data *b =3D q->tins + i;
> +		struct cake_tin_data *b =3D qd->tins + i;
>  =

>  		INIT_LIST_HEAD(&b->new_flows);
>  		INIT_LIST_HEAD(&b->old_flows);
> @@ -2784,22 +2800,27 @@ static int cake_init(struct Qdisc *sch, struct =
nlattr *opt,
>  			INIT_LIST_HEAD(&flow->flowchain);
>  			cobalt_vars_init(&flow->cvars);
>  =

> -			q->overflow_heap[k].t =3D i;
> -			q->overflow_heap[k].b =3D j;
> +			qd->overflow_heap[k].t =3D i;
> +			qd->overflow_heap[k].b =3D j;
>  			b->overflow_idx[j] =3D k;
>  		}
>  	}
>  =

>  	cake_reconfigure(sch);
> -	q->avg_peak_bandwidth =3D q->rate_bps;
> -	q->min_netlen =3D ~0;
> -	q->min_adjlen =3D ~0;
> +	qd->avg_peak_bandwidth =3D q->rate_bps;
> +	qd->min_netlen =3D ~0;
> +	qd->min_adjlen =3D ~0;
>  	return 0;
> +err:
> +	kvfree(qd->config);
> +	qd->config =3D NULL;
> +	return err;
>  }
>  =

>  static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
>  {
> -	struct cake_sched_data *q =3D qdisc_priv(sch);
> +	struct cake_sched_data *qd =3D qdisc_priv(sch);
> +	struct cake_sched_config *q =3D qd->config;
>  	struct nlattr *opts;
>  	u16 rate_flags;
>  	u8 flow_mode;
> =

> -- =

> 2.52.0
> =




