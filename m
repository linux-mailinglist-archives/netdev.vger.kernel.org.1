Return-Path: <netdev+bounces-252839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CaZDqZoc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:25:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667F75BBB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4167031A0AF4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF78627CCF0;
	Fri, 23 Jan 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfIeo99t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09C222575;
	Fri, 23 Jan 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170731; cv=none; b=pA82xaKM3qKA0ziHtbhB27LG6taeUeRIFcQni2hzOXTjaF6Fi2qB3LcxnzjUV6yrYLB6xIjIpDCXhnbJ9f6FOCUPbqHkqS0LyousCTWbrnHSnQuqwFvPAYGqfzckmCRS641FXeGh5WQIrmotrP4IUqclIdT7D7eErGlsGgL1vA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170731; c=relaxed/simple;
	bh=RI7LGH0pvlSUbNfW4+4aeCZh8WWmVQu6y5LjvxFd9HM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mz5Fk2DKhy2E7CqwKDqnbXtG/5HJqvt88ZjKGpc52jSNSJnR6hW9Lxgt8raLQGnpYm65ABiGsf8hgnXRNXMv0/QXKn18l/530tm4LgpsAIhIMih+hnWoLL41+2HbdxLUfyAmry/TBHeXyXjFKVog9qBPcvc+RjjDJKn0thpP584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfIeo99t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55043C4CEF1;
	Fri, 23 Jan 2026 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769170731;
	bh=RI7LGH0pvlSUbNfW4+4aeCZh8WWmVQu6y5LjvxFd9HM=;
	h=Subject:From:To:Cc:Date:From;
	b=VfIeo99tMICRoLwFLK76V+fpUxMsLyoV0pnVvzfaT8FcxwUvgBrwTojA3Rg3DSPOP
	 vu/2//Y0TvinVOHMU5zyjBh2i0y9cH8hLhBaDqBATWix+36aR57/4oEWA/yMH9HPqt
	 OccGU+b+9N0Eai2keSHt49O/OY7gplXwa3NZ8qpw1GbXbfvu8GQ0CPFtHP1Cldo4Yv
	 9xN/6hBlW4GXXoC7kLpRY26A2Rm9Bk1kV8/FjnLTN+YxRe5bm2gf85LPGgNsvT9cgX
	 SZfqRL4u/WoV78ndqR9cZCRSlBbd0djncMLxcehrsSfVZeJYb9mdzC0mB3AQs4jwgF
	 k8n5OrQhec55Q==
Subject: [PATCH net-next v3] net: sched: sfq: add detailed drop reasons for
 monitoring
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
Date: Fri, 23 Jan 2026 13:18:46 +0100
Message-ID: <176917072608.1186611.11185920960590396939.stgit@firesoul>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,toke.dk,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8667F75BBB
X-Rspamd-Action: no action

Add specific drop reasons to SFQ qdisc to improve packet drop
observability and monitoring capabilities. This change replaces
generic qdisc_drop() calls with qdisc_drop_reason() to provide
granular metrics about different drop scenarios in production
environments.

Two new drop reasons are introduced:

- SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: Used when a new flow cannot
  be created because the maximum number of flows (flows parameter)
  has been reached and no free flow slots are available.

- SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: Used when a flow's queue
  length exceeds the per-flow depth limit (depth parameter),
  triggering either tail drop or head drop depending on headdrop
  configuration.

The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop()
when the overall qdisc limit is exceeded and packets are dropped
from the longest queue.

The naming uses qdisc-specific drop reasons tied to SFQ tunables,
following the pattern established by Eric's FQ commit 5765c7f6e317
("net_sched: sch_fq: add three drop_reason") which introduced
FQ_BAND_LIMIT, FQ_HORIZON_LIMIT, and FQ_FLOW_LIMIT.

The new drop reasons are inserted in the middle of the enum after
SKB_DROP_REASON_QDISC_CONGESTED to group all qdisc-related reasons
together. While drop reason enum values are not UAPI, the enum
names implicitly become UAPI as userspace tools rely on BTF to
resolve names to values. This makes middle-insertion safe as long
as names remain stable.

These detailed drop reasons enable production monitoring systems
to distinguish between different SFQ drop scenarios and generate
specific metrics for:
- Flow table exhaustion (flows exceeded)
- Per-flow congestion (depth limit exceeded)
- Global qdisc congestion (overall limit exceeded)

This granular visibility allows operators to identify capacity
planning needs, detect traffic patterns, and optimize SFQ
configuration based on real-world drop patterns.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
v3:
- Removed SFQ_DR() macro per upstream feedback
- Use full drop reason names (SKB_DROP_REASON_QDISC_SFQ_*) for easier grepping
- Split long lines to stay under 80 characters

v2:
- Changed to hierarchical naming: QDISC_SFQ_MAXFLOWS and QDISC_SFQ_MAXDEPTH
- Added QDISC_ prefix for pattern matching across qdisc subsystems
- Added rationale paragraph explaining userspace monitoring benefits

v1:
- Initial submission with QDISC_MAXFLOWS and QDISC_MAXDEPTH
---
 include/net/dropreason-core.h |   12 ++++++++++++
 net/sched/sch_sfq.c           |   11 +++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a7b7abd66e21..92c99169bb97 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -70,6 +70,8 @@
 	FN(QDISC_BURST_DROP)		\
 	FN(QDISC_OVERLIMIT)		\
 	FN(QDISC_CONGESTED)		\
+	FN(QDISC_SFQ_MAXFLOWS)		\
+	FN(QDISC_SFQ_MAXDEPTH)		\
 	FN(CAKE_FLOOD)			\
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
@@ -390,6 +392,16 @@ enum skb_drop_reason {
 	 * due to congestion.
 	 */
 	SKB_DROP_REASON_QDISC_CONGESTED,
+	/**
+	 * @SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: dropped by SFQ qdisc when the
+	 * maximum number of flows is exceeded.
+	 */
+	SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS,
+	/**
+	 * @SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: dropped by SFQ qdisc when a flow
+	 * exceeds its maximum queue depth limit.
+	 */
+	SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH,
 	/**
 	 * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection part of
 	 * CAKE qdisc AQM algorithm (BLUE).
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 96eb2f122973..ecc1028bdac8 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -302,7 +302,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		sfq_dec(q, x);
 		sch->q.qlen--;
 		qdisc_qstats_backlog_dec(sch, skb);
-		qdisc_drop(skb, sch, to_free);
+		qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 		return len;
 	}
 
@@ -363,7 +363,8 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (x == SFQ_EMPTY_SLOT) {
 		x = q->dep[0].next; /* get a free slot */
 		if (x >= SFQ_MAX_FLOWS)
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free,
+						 SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS);
 		q->ht[hash] = x;
 		slot = &q->slots[x];
 		slot->hash = hash;
@@ -420,14 +421,16 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (slot->qlen >= q->maxdepth) {
 congestion_drop:
 		if (!sfq_headdrop(q))
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free,
+					 SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH);
 
 		/* We know we have at least one packet in queue */
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
 		sch->qstats.backlog -= delta;
 		slot->backlog -= delta;
-		qdisc_drop(head, sch, to_free);
+		qdisc_drop_reason(head, sch, to_free,
+				  SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH);
 
 		slot_queue_add(slot, skb);
 		qdisc_tree_reduce_backlog(sch, 0, delta);



