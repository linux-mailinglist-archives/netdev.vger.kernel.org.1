Return-Path: <netdev+bounces-294950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RppwKCSpIGqw6QAAu9opvQ
	(envelope-from <netdev+bounces-294950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:22:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0263B8C7
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XxlVInkU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294950-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294950-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28E983014857
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7DC4B8DCE;
	Wed,  3 Jun 2026 22:22:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10543C061
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:22:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525346; cv=none; b=YL+h9ZYVponw1PHwUta4koVPvQLhOYGbbzUncgNCaBJhSg4Sxej9PtlwcH9nZ1BNKC4U+TBB9glIRUykmNnQY1Gz64NAo0QQo8dEHn595xN6CWVPRLtIFDPuX59kOFOalUCdJaCFdaH2+JqZINt2c9+YoOhnc3+FkRl2ljnjDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525346; c=relaxed/simple;
	bh=onGiGoG7634vEpGOB1Ha+zgD5kgWE7YXdn9cZqIKnxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaT/utLo+per7osSARHvzJddRF0P31fYsyjTio2Xg8SxsBgl/ieH8Dmd4WXEWUiGabSC5NXmDA67IZbkJUJkev917pUhZv+ISzitCUqaj/NJPufucAw5hAQJ4L3CniukYSNaWpJTg7kqjSOa4X3HQK6rrBOnAY/8BhrWLhRkLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxlVInkU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7BF1F00893;
	Wed,  3 Jun 2026 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780525345;
	bh=0NHaxnuzBKg/1kQxho2cbWb42UNVSO+ajp6l32sBYB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XxlVInkUR2WvW7FF+hGT2CPxilOpT2UhWwygEGbuTQvfj2DQOiaR9a37wPEeBm51I
	 kR3kzMAU32suQFga2at1a+fZ5XJNH0pDwvvGWtik8Q+Gy7LacF7SqrASceWm/pWH9m
	 844EvzrGa+SUmSysJKjUCn2vJ57lCAf/W76v/BD13PCclufX9ZHid48Aed+5eEzcEH
	 Ps0IkCH8uRvHF3Lpo8IeFgh7E0vw4e3Moj/QtPhUA6YcqSzvQStW5SUeVHSgm6BRim
	 Xsoj1Q0Pv6Om/xaT/INHbXb96mOmuDjlhGiWEwCUoefr61hL2It57k/7zwHAfTe2e0
	 BuiO+bqK67mdA==
Date: Wed, 3 Jun 2026 15:22:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 2/3] net_sched: sch_fq: convert skb->tstamp if
 not monotonic
Message-ID: <20260603152224.596d46b6@kernel.org>
In-Reply-To: <20260603190243.2789335-3-willemdebruijn.kernel@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
	<20260603190243.2789335-3-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294950-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AB0263B8C7

On Wed,  3 Jun 2026 15:01:29 -0400 Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> FQ currently assumes skb->tstamp holds monotonic time, as used by TCP.
> 
> Users with ns_capable CAP_NET_ADMIN can transmit skbs using SO_TXTIME
> with CLOCK_MONOTONIC, CLOCK_REALTIME or CLOCK_TAI clockids as of the
> below commit.
> 
> More recently, skbs also gained tstamp_type to explicitly communicate
> the clockid of skb->tstamp.
> 
> Detect other clocks and convert to monotonic for use in FQ. That is,
> convert fq_skb_cb(skb)->time_to_send. Do not convert skb->tstamp
> itself. Network device clocks are more commonly synchronized to TAI.
> 
> Conversion may be imprecise due to clock adjustment (e.g., adjfreq)
> between when SCM_TSTAMP is set and when it is converted in fq_enqueue.
> The common codepath is short, so skew will be well below common pacing
> operation. Even in edge cases, bursts (too soon) or beyond horizon
> (too late) are indistinguishable from network conditions. To which
> senders must be robust, as long as infrequent.
> 
> Avoid overflow due to negative offsets becoming huge when converting
> from signed ktime_t to u64 time_to_send. Bound lower to mono 1 and
> upper to now + q->horizon. This protects against bad input, e.g.,
> from BPF programs.
> 
> Detect legacy BPF programs that program skb->tstamp without setting
> skb->tstamp_type. Here tstamp_type is zero (SKB_CLOCK_REALTIME), but
> the value will be unrealistic for realtime in the 21st century. Follow
> existing TIME_UPTIME_SEC_MAX as bound between mono and realtime.
> 
> Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")

net-next + Fixes tag is not a thing! :(
What is it saying? "This is not urgent by I would like it to be
backported to stable"? Stable is for urgent fixes. If you want things
that never worked to work you must update your kernel. Such is life.

You can quite the commit which added the feature in the body of the
message.

> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  net/sched/sch_fq.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 33783c9f8e16..7cae082a9847 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -537,10 +537,10 @@ static void flow_queue_add(struct fq_flow *flow, struct sk_buff *skb)
>  	rb_insert_color(&skb->rbnode, &flow->t_root);
>  }
>  
> -static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
> +static bool fq_packet_beyond_horizon(ktime_t time_to_send,
>  				     const struct fq_sched_data *q, u64 now)
>  {
> -	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
> +	return unlikely((s64)time_to_send > (s64)(now + q->horizon));
>  }
>  
>  static void fq_flow_adjust_timer(struct fq_sched_data *q, struct fq_flow *flow,
> @@ -561,6 +561,36 @@ static void fq_flow_adjust_timer(struct fq_sched_data *q, struct fq_flow *flow,
>  	}
>  }
>  
> +static ktime_t fq_skb_tstamp_to_mono(struct sk_buff *skb)
> +{
> +	const ktime_t mono_max = NSEC_PER_SEC * TIME_UPTIME_SEC_MAX;
> +
> +	if (likely(skb->tstamp_type == SKB_CLOCK_MONOTONIC))
> +		return max(skb->tstamp, 1);
> +
> +	if (skb->tstamp_type == SKB_CLOCK_TAI)
> +		return max(ktime_sub(skb->tstamp, ktime_mono_to_any(0, TK_OFFS_TAI)), 1);
> +
> +	if (likely(skb->tstamp > mono_max))
> +		return max(ktime_sub(skb->tstamp, ktime_mono_to_real(0)), 1);
> +
> +	/* Handle BPF programs setting skb->stamp but not tstamp_type */
> +	net_warn_ratelimited("fq: likely mono tstamp with tstamp_type 0\n");
> +
> +	skb->tstamp_type = SKB_CLOCK_MONOTONIC;
> +	return max(skb->tstamp, 1);
> +}
> +
> +static void fq_mono_to_skb_tstamp(struct sk_buff *skb, ktime_t time_to_send)
> +{
> +	if (skb->tstamp_type == SKB_CLOCK_MONOTONIC)

fq_skb_tstamp_to_mono() has a likely() around monotonic, this one does not?
Is there a reason?

> +		skb->tstamp = time_to_send;
> +	else if (skb->tstamp_type == SKB_CLOCK_REALTIME)
> +		skb->tstamp = ktime_mono_to_real(time_to_send);
> +	else
> +		skb->tstamp = ktime_mono_to_any(time_to_send, TK_OFFS_TAI);
> +}
> +
>  static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		      struct sk_buff **to_free)
>  {
> @@ -579,17 +609,20 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	if (!skb->tstamp) {
>  		fq_skb_cb(skb)->time_to_send = now;
>  	} else {
> +		ktime_t time_to_send = fq_skb_tstamp_to_mono(skb);
> +
>  		/* Check if packet timestamp is too far in the future. */
> -		if (fq_packet_beyond_horizon(skb, q, now)) {
> +		if (fq_packet_beyond_horizon(time_to_send, q, now)) {
>  			if (q->horizon_drop) {
>  				q->stat_horizon_drops++;
>  				return qdisc_drop_reason(skb, sch, to_free,
>  							 QDISC_DROP_HORIZON_LIMIT);
>  			}
>  			q->stat_horizon_caps++;
> -			skb->tstamp = now + q->horizon;
> +			time_to_send = now + q->horizon;
> +			fq_mono_to_skb_tstamp(skb, time_to_send);
>  		}
> -		fq_skb_cb(skb)->time_to_send = skb->tstamp;
> +		fq_skb_cb(skb)->time_to_send = (u64)time_to_send;
>  	}
>  
>  	f = fq_classify(sch, skb, now);


