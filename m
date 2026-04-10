Return-Path: <netdev+bounces-277351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEOSEP3g2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A52003D6426
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8633016295
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFF539DBC1;
	Fri, 10 Apr 2026 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0UhFAsG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2937C11E;
	Fri, 10 Apr 2026 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821050; cv=none; b=gwDYI9JAMq9TAoWaD5kHLtJHaMwDB8FVMTGWLPJTqDr18xqpYhc7UFxQMdmd1jReP73vS/4aV6k/I5PfyII9AIZNg0g4m95hMr5maf7MiG5eCh3K2mKjIA9najti+Pwtffcu6EfXj1plNzyJ42y/gtK1+B0cHB/kddftlRqDMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821050; c=relaxed/simple;
	bh=ctf7tAqzWy2jgKyTqKSoTxspzO0eZ3u9h51Rjz0Q5AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jF00KzbyxI5OUd866XKDRb5yPA9T+yTjffO4HUzEF4aaedkSZPPnvglM3OXyKRm9hZ587NNGsMXXCaQ4nKCuDWsAxWGUbfo7ELxkD85020wr1WxaBlraRwvA2B/+BbuQ0qGB9TyFD4T60L8Xa72JTjtlKPLB5DvzEJSakNJzdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0UhFAsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B437C19421;
	Fri, 10 Apr 2026 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775821050;
	bh=ctf7tAqzWy2jgKyTqKSoTxspzO0eZ3u9h51Rjz0Q5AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0UhFAsGpoaEoV6t82Oou8k60dPyMZHSXibMehm43lul39FaRTlsrdtrV493qkppg
	 hmvlSWktiCDBsDF8Eh5b+ufXf08dgTDIMiGH9vgVQ0dj+FK5KKEEu33RcXDuIu6PX+
	 haYSRf/dMqd2Zy3PJyG8TJVEJsWfytKq5Ex+rrXNUDx8DcJGmNoKTvIGUm4gJNARRo
	 rXt6FmPpmpVB3eapOtWU+fwdhFx6Yq3bLwaJFE6EXzvSuk94oCtNFte3BJwmNZ5DPz
	 fmYHohx+sCfbvoq94HMrqtRfp4RYH++Q0fCQjwhWPeE48kNqzTqeHLXj2jA4wxBqZF
	 JzNeBPpI3ri2g==
From: Simon Horman <horms@kernel.org>
To: stephen@networkplumber.org
Cc: Simon Horman <horms@kernel.org>,
	ncardwell@google.com,
	linux-kernel@vger.kernel.org (open list),
	francois.michel@uclouvain.be,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ysseung@google.com,
	edumazet@google.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	posk@google.com,
	jiri@resnulli.us
Subject: Re: [PATCH net v4 5/8] net/sched: netem: batch-transfer ready packets to avoid child re-entrancy
Date: Fri, 10 Apr 2026 12:36:13 +0100
Message-ID: <20260410113613.618124-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-6-stephen@networkplumber.org>
References: <20260406172627.210894-6-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277351-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A52003D6426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/sched: netem: batch-transfer ready packets to avoid child re-entrancy

netem_dequeue_child() previously transferred one packet from the tfifo
to the child qdisc per dequeue call. Parents like HFSC that track
class active/inactive state on qlen transitions could see an enqueue
during dequeue, causing double-insertion into the eltree
(CVE-2025-37890, CVE-2025-38001). Non-work-conserving children like
TBF could also refuse to return a just-enqueued packet, making netem
return NULL despite having backlog, which causes parents like DRR to
incorrectly deactivate the class.

Move all time-ready packets into the child before calling its dequeue.
This separates the enqueue and dequeue phases so the parent sees
consistent qlen transitions.

> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index e264f7aefb97..b93f0e886a2b 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c

[ ... ]

> @@ -743,31 +745,28 @@ static struct sk_buff *netem_dequeue_child(struct Qdisc *sch)
>  	u64 now = ktime_get_ns();
>  	struct sk_buff *skb;
>
> -	skb = netem_peek(q);
> -	if (skb) {
> -		u64 time_to_send = netem_skb_cb(skb)->time_to_send;
> -
> -		if (q->slot.slot_next && q->slot.slot_next < time_to_send)
> -			get_slot_next(q, now);
> -
> -		if (time_to_send <= now && q->slot.slot_next <= now) {
> -			struct sk_buff *to_free = NULL;
> -			unsigned int pkt_len;
> -			int err;
> +	while ((skb = netem_peek(q)) != NULL) {
> +		struct sk_buff *to_free = NULL;
> +		unsigned int pkt_len;
> +		int err;
>
> -			skb = netem_pull_tfifo(q, sch);
> -			netem_slot_account(q, skb, now);
> +		if (netem_skb_cb(skb)->time_to_send > now)
> +			break;
> +		if (q->slot.slot_next && q->slot.slot_next > now)
> +			break;

Does the batch transfer preserve slot gap behavior?

The old code called get_slot_next(q, now) when a slot expired by time:

    if (q->slot.slot_next && q->slot.slot_next < time_to_send)
        get_slot_next(q, now);

This advanced the slot to a new future window (slot_next = now + next_delay),
enforcing inter-slot gaps when a slot expired by time rather than by packet
or byte budget exhaustion.

The new batching loop only checks 'q->slot.slot_next > now' to break, and
relies solely on netem_slot_account() -> get_slot_next() for slot advancement
(which only triggers when packets_left or bytes_left reach zero).

When a slot expires by time but still has remaining budget, the new code
transfers packets immediately without creating a new inter-slot gap.

netem_dequeue_direct() still has the old slot gap logic:

    if (q->slot.slot_next && q->slot.slot_next < time_to_send)
        get_slot_next(q, now);

Should netem_dequeue_child() call get_slot_next() before the batching loop
to maintain consistent slot-based traffic shaping semantics between the
direct and child paths?

>
> -			pkt_len = qdisc_pkt_len(skb);
> -			err = qdisc_enqueue(skb, q->qdisc, &to_free);
> -			kfree_skb_list(to_free);
> -			if (err != NET_XMIT_SUCCESS) {
> -				if (net_xmit_drop_count(err))
> -					qdisc_qstats_drop(sch);
> -				sch->qstats.backlog -= pkt_len;
> -				sch->q.qlen--;
> -				qdisc_tree_reduce_backlog(sch, 1, pkt_len);
> -			}
> +		skb = netem_pull_tfifo(q, sch);
> +		netem_slot_account(q, skb, now);
> +
> +		pkt_len = qdisc_pkt_len(skb);
> +		err = qdisc_enqueue(skb, q->qdisc, &to_free);
> +		kfree_skb_list(to_free);
> +		if (unlikely(err != NET_XMIT_SUCCESS)) {
> +			if (net_xmit_drop_count(err))
> +				qdisc_qstats_drop(sch);
> +			sch->qstats.backlog -= pkt_len;
> +			sch->q.qlen--;
> +			qdisc_tree_reduce_backlog(sch, 1, pkt_len);
>  		}
>  	}

