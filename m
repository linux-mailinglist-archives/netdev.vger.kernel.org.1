Return-Path: <netdev+bounces-280738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFcbISwN6mn4sgIAu9opvQ
	(envelope-from <netdev+bounces-280738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983DC451D28
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72BDA301A6A5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B63BE16C;
	Thu, 23 Apr 2026 12:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1484A36D50D
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946357; cv=none; b=ORKSvI0vrbDT06lqDtQ8+hzjveXfJe1fVZMdHcM+p1vjdKelV66O9OV8WkXogp8xssrLarURlMDNpgwMly3OtKDWySTaRAOyhaA8sncf8ieTpWd/t+H6obgaxLgYiDDewlCHYICk3QhpM7n3/hGZaQ5GPJ9hGb7XmOcWaMtrXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946357; c=relaxed/simple;
	bh=gWsfEo/AIYBSS+1TnR2QX1OYKZe2ksUdRFUBi0d7W5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHmiuP5KrrtuSN8h50pUb/LdIJXr9v+eBu7HZfDQofrJ/ig6X+4lBntmOm076V35CPplIjDN9ji59ueUCs6E2+r7hMr53kkGlxNm0utx4JbYXLWMXv7sA4eMPvLU1/2BZuJ7hdXWyvggClv4tYALKQ8W3h2f3DxxOXVLpXY+2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 4/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (IV)
In-Reply-To: <20260423102324.3172448-5-edumazet@google.com>
References: <20260423102324.3172448-1-edumazet@google.com>
 <20260423102324.3172448-5-edumazet@google.com>
Date: Thu, 23 Apr 2026 14:12:33 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871pg5yixa.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.60 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-280738-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 983DC451D28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet <edumazet@google.com> writes:

> cake_dump_stats() runs without qdisc spinlock being held.
>
> In this fourth patch, I add READ_ONCE()/WRITE_ONCE() annotations
> for the following fields:
>
> - avg_peak_bandwidth
> - buffer_limit
> - buffer_max_used
> - avg_netoff
> - max_netlen
> - max_adjlen
> - min_netlen
> - min_adjlen
> - active_queues
> - tin_rate_bps
> - bytes
> - tin_backlog
>
> Other annotations are added in following patch, to ease code review.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
> ---
>  net/sched/sch_cake.c | 90 ++++++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 44 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index c5aae31565e984e40937b55201b498174a37180e..c3b09f67f0fdbc51d23b3d22d=
f9ab89a716c7e2b 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1379,9 +1379,9 @@ static u32 cake_calc_overhead(struct cake_sched_dat=
a *qd, u32 len, u32 off)
>  		len -=3D off;
>=20=20
>  	if (qd->max_netlen < len)
> -		qd->max_netlen =3D len;
> +		WRITE_ONCE(qd->max_netlen, len);
>  	if (qd->min_netlen > len)
> -		qd->min_netlen =3D len;
> +		WRITE_ONCE(qd->min_netlen, len);
>=20=20
>  	len +=3D q->rate_overhead;
>=20=20
> @@ -1401,9 +1401,9 @@ static u32 cake_calc_overhead(struct cake_sched_dat=
a *qd, u32 len, u32 off)
>  	}
>=20=20
>  	if (qd->max_adjlen < len)
> -		qd->max_adjlen =3D len;
> +		WRITE_ONCE(qd->max_adjlen, len);
>  	if (qd->min_adjlen > len)
> -		qd->min_adjlen =3D len;
> +		WRITE_ONCE(qd->min_adjlen, len);
>=20=20
>  	return len;
>  }
> @@ -1416,7 +1416,7 @@ static u32 cake_overhead(struct cake_sched_data *q,=
 const struct sk_buff *skb)
>  	u16 segs =3D qdisc_pkt_segs(skb);
>  	u32 len =3D qdisc_pkt_len(skb);
>=20=20
> -	q->avg_netoff =3D cake_ewma(q->avg_netoff, off << 16, 8);
> +	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
>=20=20
>  	if (segs =3D=3D 1)
>  		return cake_calc_overhead(q, len, off);
> @@ -1596,7 +1596,7 @@ static unsigned int cake_drop(struct Qdisc *sch, st=
ruct sk_buff **to_free)
>  	len =3D qdisc_pkt_len(skb);
>  	q->buffer_used      -=3D skb->truesize;
>  	b->backlogs[idx]    -=3D len;
> -	b->tin_backlog      -=3D len;
> +	WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
>  	sch->qstats.backlog -=3D len;
>=20=20
>  	flow->dropped++;
> @@ -1824,9 +1824,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  		}
>=20=20
>  		/* stats */
> -		b->bytes	    +=3D slen;
> +		WRITE_ONCE(b->bytes, b->bytes + slen);
>  		b->backlogs[idx]    +=3D slen;
> -		b->tin_backlog      +=3D slen;
> +		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
>  		sch->qstats.backlog +=3D slen;
>  		q->avg_window_bytes +=3D slen;

nit: these break up the aligned block, which hurts readability, IMO. Can
we keep the WRITE_ONCE() lines at the top or the bottom of the block?

> @@ -1847,7 +1847,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  			WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
>  			sch->qstats.drops++;
>  			ack_pkt_len =3D qdisc_pkt_len(ack);
> -			b->bytes +=3D ack_pkt_len;
> +			WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
>  			q->buffer_used +=3D skb->truesize - ack->truesize;
>  			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>  				cake_advance_shaper(q, b, ack, now, true);
> @@ -1861,9 +1861,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>=20=20
>  		/* stats */
>  		WRITE_ONCE(b->packets, b->packets + 1);
> -		b->bytes	    +=3D len - ack_pkt_len;
> +		WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
>  		b->backlogs[idx]    +=3D len - ack_pkt_len;
> -		b->tin_backlog      +=3D len - ack_pkt_len;
> +		WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pkt_len);
>  		sch->qstats.backlog +=3D len - ack_pkt_len;
>  		q->avg_window_bytes +=3D len - ack_pkt_len;

same here
>  	}
> @@ -1895,9 +1895,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  			u64 b =3D q->avg_window_bytes * (u64)NSEC_PER_SEC;
>=20=20
>  			b =3D div64_u64(b, window_interval);
> -			q->avg_peak_bandwidth =3D
> -				cake_ewma(q->avg_peak_bandwidth, b,
> -					  b > q->avg_peak_bandwidth ? 2 : 8);
> +			WRITE_ONCE(q->avg_peak_bandwidth,
> +				   cake_ewma(q->avg_peak_bandwidth, b,
> +					     b > q->avg_peak_bandwidth ? 2 : 8));
>  			q->avg_window_bytes =3D 0;
>  			q->avg_window_begin =3D now;
>=20=20
> @@ -1938,7 +1938,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  	}
>=20=20
>  	if (q->buffer_used > q->buffer_max_used)
> -		q->buffer_max_used =3D q->buffer_used;
> +		WRITE_ONCE(q->buffer_max_used, q->buffer_used);
>=20=20
>  	if (q->buffer_used <=3D q->buffer_limit)
>  		return NET_XMIT_SUCCESS;
> @@ -1978,7 +1978,7 @@ static struct sk_buff *cake_dequeue_one(struct Qdis=
c *sch)
>  		skb =3D dequeue_head(flow);
>  		len =3D qdisc_pkt_len(skb);
>  		b->backlogs[q->cur_flow] -=3D len;
> -		b->tin_backlog		 -=3D len;
> +		WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
>  		sch->qstats.backlog      -=3D len;
>  		q->buffer_used		 -=3D skb->truesize;
>  		sch->q.qlen--;

and here


-Toke

