Return-Path: <netdev+bounces-257605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P4aDckVhmk1JgQAu9opvQ
	(envelope-from <netdev+bounces-257605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:24:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441810036C
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4300C3002B70
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C85327209;
	Fri,  6 Feb 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxnBBhHu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798C2DF132;
	Fri,  6 Feb 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395075; cv=none; b=WV4v3MWXSRY2NBG/3rnnH6DJ0buZZytvd9+zIiJKiy10UlZ/QJ3j16AvInsqFmM2/WG13EesU+ebG8yA0Hr/Lx9QnGwW/o3GUjqXmI/NQWiqLQ6Seo4ljh0qozrip4rW+Kr0Z2ZxgH+J6Ue8avKuaULCEUrJE6XkV2GUxy/uZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395075; c=relaxed/simple;
	bh=zgebKyL0uzcvJEp7bf09ffJFJuVNdOLocqXxpzS72WU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8QZCpXGm2pe3AMX9V4FQY+yeSKIcQbSdWEzLoBSSD8+hOkV259kSXAmWr9Kb+kILb83d22vNbDPgGvIva8Afr03KcUhdyOKjCKBbbgpBMRyrv/X1iLXd7GwTp51OQBF7UQ5y124suGIKkBvhoJnrmC49nImT6AZKYLj3stlQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxnBBhHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740A0C116C6;
	Fri,  6 Feb 2026 16:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395074;
	bh=zgebKyL0uzcvJEp7bf09ffJFJuVNdOLocqXxpzS72WU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sxnBBhHuMBfsMtFygAaHvujgtLuYa77VyCDsORO4yGkKHDnhsmcBAT7+YeXVkZN31
	 QyVUCG9NFNgUv1gaR18MbSAdBsKh6MPRJja53/EXK0zGdnWFCt2zg7QZozfHFM0KjK
	 chnNKXBTcTQPt5otUJkTkMJQ5rbzswOVCIsS5kCs2gU+lxiPt1tDqoPEU5+GOpO6vS
	 etqcxYiW4D3oI+C1cTmjMHfq8qVI482zsRbPn7nsFCSgozFZ0oncdymFw2E0ttJZ41
	 d+4FFWUqfFWNq9JEymMG+UDCm3HCDx4uFgFU9JQEtEIDkDJRFFIT/gRQI0zhbyaR7M
	 DOI8h/WafiCGA==
Subject: [PATCH net-next v3 2/6] net: sched: sfq: convert to qdisc drop
 reasons
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Fri, 06 Feb 2026 17:24:29 +0100
Message-ID: <177039506943.2258217.14978587773203412149.stgit@firesoul>
In-Reply-To: <177039500964.2258217.2989656069254156812.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257605-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4441810036C
X-Rspamd-Action: no action

Convert SFQ to use the new qdisc-specific drop reason infrastructure.

This patch demonstrates how to convert a flow-based qdisc to use the
new enum qdisc_drop_reason. As part of this conversion:

- Add QDISC_DROP_MAXFLOWS for flow table exhaustion
- Rename FQ_FLOW_LIMIT to generic FLOW_LIMIT, now shared by FQ and SFQ
- Use QDISC_DROP_OVERLIMIT for sfq_drop() when overall limit exceeded
- Use QDISC_DROP_FLOW_LIMIT for per-flow depth limit exceeded

The FLOW_LIMIT reason is now a common drop reason for per-flow limits,
applicable to both FQ and SFQ qdiscs.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-qdisc.h |   22 ++++++++++++++++------
 net/sched/sch_fq.c             |    2 +-
 net/sched/sch_sfq.c            |    8 ++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index db81b3471a65..b019a3a0a59b 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -9,10 +9,11 @@
 	FN(GENERIC)			\
 	FN(OVERLIMIT)			\
 	FN(CONGESTED)			\
+	FN(FLOW_LIMIT)			\
+	FN(MAXFLOWS)			\
 	FN(CAKE_FLOOD)			\
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
-	FN(FQ_FLOW_LIMIT)		\
 	FNe(MAX)
 
 #undef FN
@@ -59,6 +60,20 @@ enum qdisc_drop_reason {
 	 * congestion to the sender and prevent bufferbloat.
 	 */
 	QDISC_DROP_CONGESTED,
+	/**
+	 * @QDISC_DROP_FLOW_LIMIT: packet dropped because an individual flow
+	 * exceeded its per-flow packet/depth limit. Used by FQ and SFQ qdiscs
+	 * to enforce per-flow fairness and prevent a single flow from
+	 * monopolizing queue resources.
+	 */
+	QDISC_DROP_FLOW_LIMIT,
+	/**
+	 * @QDISC_DROP_MAXFLOWS: packet dropped because the qdisc's flow
+	 * tracking table is full and no free slots are available to allocate
+	 * for a new flow. This indicates flow table exhaustion in flow-based
+	 * qdiscs that maintain per-flow state (e.g., SFQ).
+	 */
+	QDISC_DROP_MAXFLOWS,
 	/**
 	 * @QDISC_DROP_CAKE_FLOOD: CAKE qdisc dropped packet due to flood
 	 * protection mechanism (BLUE algorithm). This indicates potential
@@ -77,11 +92,6 @@ enum qdisc_drop_reason {
 	 * packets with unreasonable future timestamps from blocking the queue.
 	 */
 	QDISC_DROP_FQ_HORIZON_LIMIT,
-	/**
-	 * @QDISC_DROP_FQ_FLOW_LIMIT: FQ dropped packet because an individual
-	 * flow exceeded its per-flow packet limit.
-	 */
-	QDISC_DROP_FQ_FLOW_LIMIT,
 	/**
 	 * @QDISC_DROP_MAX: the maximum of qdisc drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 1ae254971326..d36da3918b55 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -580,7 +580,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (unlikely(f->qlen >= q->flow_plimit)) {
 			q->stat_flows_plimit++;
 			return qdisc_drop_reason(skb, sch, to_free,
-						 QDISC_DROP_FQ_FLOW_LIMIT);
+						 QDISC_DROP_FLOW_LIMIT);
 		}
 
 		if (fq_flow_is_detached(f)) {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 96eb2f122973..efb796976a5b 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -302,7 +302,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		sfq_dec(q, x);
 		sch->q.qlen--;
 		qdisc_qstats_backlog_dec(sch, skb);
-		qdisc_drop(skb, sch, to_free);
+		qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 		return len;
 	}
 
@@ -363,7 +363,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (x == SFQ_EMPTY_SLOT) {
 		x = q->dep[0].next; /* get a free slot */
 		if (x >= SFQ_MAX_FLOWS)
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_MAXFLOWS);
 		q->ht[hash] = x;
 		slot = &q->slots[x];
 		slot->hash = hash;
@@ -420,14 +420,14 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (slot->qlen >= q->maxdepth) {
 congestion_drop:
 		if (!sfq_headdrop(q))
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_FLOW_LIMIT);
 
 		/* We know we have at least one packet in queue */
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
 		sch->qstats.backlog -= delta;
 		slot->backlog -= delta;
-		qdisc_drop(head, sch, to_free);
+		qdisc_drop_reason(head, sch, to_free, QDISC_DROP_FLOW_LIMIT);
 
 		slot_queue_add(slot, skb);
 		qdisc_tree_reduce_backlog(sch, 0, delta);



