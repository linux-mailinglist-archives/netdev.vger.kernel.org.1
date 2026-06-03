Return-Path: <netdev+bounces-294962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cPuuGN2xIGow6wAAu9opvQ
	(envelope-from <netdev+bounces-294962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:59:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30463BB43
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:59:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y37Ovvit;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294962-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294962-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C94E630095F1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D37F49551D;
	Wed,  3 Jun 2026 22:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AA4D90C8
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:59:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527575; cv=none; b=EHEyOzZNnhMF9FMtjO3ItJFcERJpHvQY0Z1u+OsNsIBOV8zKlCroXhC8LtS3Z9X+yfrMxsBO0ucZ//Ls+Dv8/YMhVutxNAXUOghx99goY8Tt+Jr8Wr1nAR7qsn0UAQq1BwDwvT/lbwlqiGc03t9XGtDjQolYOxuEFsUd96sCgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527575; c=relaxed/simple;
	bh=KtQkFRdXpIBhalmEilEsJ8qrHz6L0opUiA0OvRbMvsM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W/Gav8E/V7BvdSyjYJx3HP0IIJsZV4y7ntooDyhDUBrvm1bEgboil1uFPh+f15bxp7WNYbeTnMLHmCFgbdYc79v32sW5wLS12b00AIbtc6kwNEAl9mkO1hle7L+YZFEMqo56/gozlIfn4rKoEHLnzem8Lfg864IkoVZ2vZsp7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y37Ovvit; arc=none smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dc93d02916so1266817b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780527573; x=1781132373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NawvuB1zfHBL8ln2BryN/EJy/EqNlTVHbvu6d6Fmo7g=;
        b=Y37Ovvit4x40wVJ+XBtmOsgOtAicHUEC7YQSks4RzkDLt+3JlZ0SHDHRf+S18ZCj/S
         TkCgMgNKzyS6OCTwrkdECgApkN4NY0Mu5diTYIt2l7/VUzTGbVV1wGu0jpbueEwxtKRy
         cPwC1xMcRiYq3jPm7r7ab1qkK5tqqynxLnQFypym6vs5LwNPqG0HKRpcIqCiMbXFYNzb
         gXa7Y+AMhGwF9K0Va7xYW9SmQ4KiuydC5PZAIQYUHaz1mWTRiGFfw2z5DiguLL5Neaes
         2c1SRHFTWIk1HY9qWtkNQSdETO1fDTwvLXDdNj9KPv++6FCqXVx6xKnstSLvjItV4phx
         cQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527573; x=1781132373;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NawvuB1zfHBL8ln2BryN/EJy/EqNlTVHbvu6d6Fmo7g=;
        b=JXY6frN1cVH08JMA7QQ2R347v91p6vMwwpjvP8nJp//8jqajTtxkE/SOz+1y/OXwz7
         5uBc53vdnKJaqqWhc1N8BrbVRi0OkiLdlyshDM2JYkM4sE1UU6BTr4oQ/A47B/u6+kL0
         i95Q4M5dNW0XIcuuJBH6GAhxY5BTHX7Bh/Zpgz/X4nmjmX/bClocXKrZbQNYTDFgJ7Ix
         4t3BeRDSuaKcErvLSTuVT6F4vjcyK01Ys8TksCa/fiE950kio6A2LneRMwHnn2VWtRla
         pjOmX1TtuSKKopKo5DHOfus1b660oWqkubGvAV2/iUASJs/m76YHAkdPgD/+oealL6TE
         eg+Q==
X-Gm-Message-State: AOJu0YyQA9GdYHqN63/DEAGd2fITrzP3uLVp6x9qSaiEngT1JtjNHZDS
	4Tb30/ULPMc9PNxaZh3RMWTLESmQ53ORaQTOnLMySttTVBqwHHmtX4eo
X-Gm-Gg: Acq92OGAR3xpSVGuVNHA7ocVki7iA+kKXx82c7C30g6LRY6uSgrDskXuScrvrrme8LC
	H7spauwnOqTqMfRAFfY/h//l2N8FbkPXqHDN2FlvJLU4+sfKOjNq7rvKVHvM2rgQqXDxv6DFnm8
	NmQmap+8/nZo33thmspaNhX5rvRU/Zq8M2mAfRdJ/CHMVBr/WSMrVBADGlWQh2jFb9DqPMCRiMb
	UjuBviWZMNAPpQDD1dfQul9rdo8OTs9MoO/T1zeuVkgMH4BJtJdwLTlB5bfvmR0LK0SeqzC6v9u
	TND3q4oMthUzy2ShMoVZfjqfkjqmwfhlLZfj3ThhgurFE/MBokmomyZUclk3evhpjNfShK12fYA
	AgDxU+PZmyUZqTiygPdfFSTHUqrq7htlj0Eh3U9XtRoafaOw73IqF/YSATlCroHlPHhHjWSc+BX
	H9gkdjfFkADfpZR2hy3j+PHnS/vlHgYbhssFG6AEgyfQpZH7dP5E/Uz3DgrOcLHEDgektScjenx
	jcnaEjfCCNusNI18AEiOvQoW51i
X-Received: by 2002:a05:690c:7402:b0:7dc:4b2c:58d0 with SMTP id 00721157ae682-7ea49879f96mr50640547b3.16.1780527572765;
        Wed, 03 Jun 2026 15:59:32 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8191sm24760587b3.8.2026.06.03.15.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:59:31 -0700 (PDT)
Date: Wed, 03 Jun 2026 18:59:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.f08367f74d8@gmail.com>
In-Reply-To: <20260603152224.596d46b6@kernel.org>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
 <20260603190243.2789335-3-willemdebruijn.kernel@gmail.com>
 <20260603152224.596d46b6@kernel.org>
Subject: Re: [PATCH net-next 2/3] net_sched: sch_fq: convert skb->tstamp if
 not monotonic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F30463BB43

Jakub Kicinski wrote:
> On Wed,  3 Jun 2026 15:01:29 -0400 Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > FQ currently assumes skb->tstamp holds monotonic time, as used by TCP.
> > 
> > Users with ns_capable CAP_NET_ADMIN can transmit skbs using SO_TXTIME
> > with CLOCK_MONOTONIC, CLOCK_REALTIME or CLOCK_TAI clockids as of the
> > below commit.
> > 
> > More recently, skbs also gained tstamp_type to explicitly communicate
> > the clockid of skb->tstamp.
> > 
> > Detect other clocks and convert to monotonic for use in FQ. That is,
> > convert fq_skb_cb(skb)->time_to_send. Do not convert skb->tstamp
> > itself. Network device clocks are more commonly synchronized to TAI.
> > 
> > Conversion may be imprecise due to clock adjustment (e.g., adjfreq)
> > between when SCM_TSTAMP is set and when it is converted in fq_enqueue.
> > The common codepath is short, so skew will be well below common pacing
> > operation. Even in edge cases, bursts (too soon) or beyond horizon
> > (too late) are indistinguishable from network conditions. To which
> > senders must be robust, as long as infrequent.
> > 
> > Avoid overflow due to negative offsets becoming huge when converting
> > from signed ktime_t to u64 time_to_send. Bound lower to mono 1 and
> > upper to now + q->horizon. This protects against bad input, e.g.,
> > from BPF programs.
> > 
> > Detect legacy BPF programs that program skb->tstamp without setting
> > skb->tstamp_type. Here tstamp_type is zero (SKB_CLOCK_REALTIME), but
> > the value will be unrealistic for realtime in the 21st century. Follow
> > existing TIME_UPTIME_SEC_MAX as bound between mono and realtime.
> > 
> > Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
> 
> net-next + Fixes tag is not a thing! :(
> What is it saying? "This is not urgent by I would like it to be
> backported to stable"? Stable is for urgent fixes. If you want things
> that never worked to work you must update your kernel. Such is life.

Sorry, I did not know that Fixes implies stable.

No, I don't think this is stable material.

Will remove the tag and reference in the text.
 
> You can quite the commit which added the feature in the body of the
> message.
> 
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  net/sched/sch_fq.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 33783c9f8e16..7cae082a9847 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -537,10 +537,10 @@ static void flow_queue_add(struct fq_flow *flow, struct sk_buff *skb)
> >  	rb_insert_color(&skb->rbnode, &flow->t_root);
> >  }
> >  
> > -static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
> > +static bool fq_packet_beyond_horizon(ktime_t time_to_send,
> >  				     const struct fq_sched_data *q, u64 now)
> >  {
> > -	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
> > +	return unlikely((s64)time_to_send > (s64)(now + q->horizon));
> >  }
> >  
> >  static void fq_flow_adjust_timer(struct fq_sched_data *q, struct fq_flow *flow,
> > @@ -561,6 +561,36 @@ static void fq_flow_adjust_timer(struct fq_sched_data *q, struct fq_flow *flow,
> >  	}
> >  }
> >  
> > +static ktime_t fq_skb_tstamp_to_mono(struct sk_buff *skb)
> > +{
> > +	const ktime_t mono_max = NSEC_PER_SEC * TIME_UPTIME_SEC_MAX;
> > +
> > +	if (likely(skb->tstamp_type == SKB_CLOCK_MONOTONIC))
> > +		return max(skb->tstamp, 1);
> > +
> > +	if (skb->tstamp_type == SKB_CLOCK_TAI)
> > +		return max(ktime_sub(skb->tstamp, ktime_mono_to_any(0, TK_OFFS_TAI)), 1);
> > +
> > +	if (likely(skb->tstamp > mono_max))
> > +		return max(ktime_sub(skb->tstamp, ktime_mono_to_real(0)), 1);
> > +
> > +	/* Handle BPF programs setting skb->stamp but not tstamp_type */
> > +	net_warn_ratelimited("fq: likely mono tstamp with tstamp_type 0\n");
> > +
> > +	skb->tstamp_type = SKB_CLOCK_MONOTONIC;
> > +	return max(skb->tstamp, 1);
> > +}
> > +
> > +static void fq_mono_to_skb_tstamp(struct sk_buff *skb, ktime_t time_to_send)
> > +{
> > +	if (skb->tstamp_type == SKB_CLOCK_MONOTONIC)
> 
> fq_skb_tstamp_to_mono() has a likely() around monotonic, this one does not?
> Is there a reason?

Thought process is that the first is a standalone if, so predicted
not to be taken. While this is an if/else, where the if is predicted
taken (which is why it's first even if not first in the enum).

Not sure how true these heuristics still are. Not very with good
branch predictors probably, let alone FDO.

> > +		skb->tstamp = time_to_send;
> > +	else if (skb->tstamp_type == SKB_CLOCK_REALTIME)
> > +		skb->tstamp = ktime_mono_to_real(time_to_send);
> > +	else
> > +		skb->tstamp = ktime_mono_to_any(time_to_send, TK_OFFS_TAI);
> > +}
> > +
> >  static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> >  		      struct sk_buff **to_free)
> >  {
> > @@ -579,17 +609,20 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> >  	if (!skb->tstamp) {
> >  		fq_skb_cb(skb)->time_to_send = now;
> >  	} else {
> > +		ktime_t time_to_send = fq_skb_tstamp_to_mono(skb);
> > +
> >  		/* Check if packet timestamp is too far in the future. */
> > -		if (fq_packet_beyond_horizon(skb, q, now)) {
> > +		if (fq_packet_beyond_horizon(time_to_send, q, now)) {
> >  			if (q->horizon_drop) {
> >  				q->stat_horizon_drops++;
> >  				return qdisc_drop_reason(skb, sch, to_free,
> >  							 QDISC_DROP_HORIZON_LIMIT);
> >  			}
> >  			q->stat_horizon_caps++;
> > -			skb->tstamp = now + q->horizon;
> > +			time_to_send = now + q->horizon;
> > +			fq_mono_to_skb_tstamp(skb, time_to_send);
> >  		}
> > -		fq_skb_cb(skb)->time_to_send = skb->tstamp;
> > +		fq_skb_cb(skb)->time_to_send = (u64)time_to_send;
> >  	}
> >  
> >  	f = fq_classify(sch, skb, now);
> 



