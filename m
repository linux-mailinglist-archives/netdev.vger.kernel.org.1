Return-Path: <netdev+bounces-258914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KssJ2c5k2ns2gEAu9opvQ
	(envelope-from <netdev+bounces-258914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:36:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0C145AB0
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865CE3038F4D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C3E330B12;
	Mon, 16 Feb 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbc7bVEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73358330679;
	Mon, 16 Feb 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255860; cv=none; b=GVy8SWV3AEldyZ2DdSVI1lc9tMQ9+Hs+9Luh13KTzs6g7X+1hFrpdoUP3mCdz5xviF9lQlTIxuu65crczYUGNcaeo3MkmbRsLr4yDsguW7X82LgP6taYQ+nR1FBc4mtbwbGHDZyjr4e5fg5ibyZBQgAB5JRpVkPtHUajUtGLvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255860; c=relaxed/simple;
	bh=Quyklt0OpgDW5NcjhvRx5Josr55CGYucwL1ahUwcM5Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdW9XGA9ZARQfSs9iTQCbZmqlxyNFcp2Uqe+qnBhKnK3w76QLueXRmCGTy9EcTd6JvYdEN0KwXu3NCMqpaUD7s1uUrK66u/tJLqCo5p0gpdeOTeEhtwGSM6viHPHiYJAKsIaHeCl7DyEDDvdZE0gOU96PbmqGrMUbc7NLrsWXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbc7bVEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1638C116C6;
	Mon, 16 Feb 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771255860;
	bh=Quyklt0OpgDW5NcjhvRx5Josr55CGYucwL1ahUwcM5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Wbc7bVElf0xKKa6Wv1UGbA3Pqh60qFdYPVQHcyZzmO5bCCAJXy1Gf/3NwxDflh1sy
	 muY1WpL9o9ADYgDFECry2N2mDA2C+i5++daKSug/yiIH/eAlVEkdcew5yBaRiVgp8t
	 xpI7EAsflfEj57TCCoSkK04C6EvbzbSa0SpjugEWnN77MBDlACrh+hyyVoOXBIkFIi
	 /f+0f2Qr20ERCJP1bLIeTvelEHkRjEQh38n8mtUQZ+CrA/uZ5DXzGvlpCuWlb31a2p
	 ZTkVbFV2VZxY1Zaty49O8+o71ZnZmFokQ6QbfwjM2PsM+onRXBIARyTJv+1BZqlKxo
	 Rg6o+WVBERYPA==
Subject: [PATCH net-next v4 5/5] net: sched: sch_dualpi2: use
 qdisc_dequeue_drop() for dequeue drops
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Mon, 16 Feb 2026 16:30:55 +0100
Message-ID: <177125585500.2500844.3560416262684938063.stgit@firesoul>
In-Reply-To: <177125575993.2500844.8718737675156179479.stgit@firesoul>
References: <177125575993.2500844.8718737675156179479.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258914-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAA0C145AB0
X-Rspamd-Action: no action

DualPI2 drops packets during dequeue but was using kfree_skb_reason()
directly, bypassing trace_qdisc_drop. Convert to qdisc_dequeue_drop()
and add QDISC_DROP_L4S_STEP_NON_ECN to the qdisc drop reason enum.

- Set TCQ_F_DEQUEUE_DROPS flag in dualpi2_init()
- Use enum qdisc_drop_reason in drop_and_retry()
- Replace kfree_skb_reason() with qdisc_dequeue_drop()

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/dropreason-core.h  |    6 ------
 include/net/dropreason-qdisc.h |    8 ++++++++
 net/sched/sch_dualpi2.c        |   12 ++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3d8d284e05c8..5c8c2eb3d2c5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -121,7 +121,6 @@
 	FN(CANFD_RX_INVALID_FRAME)	\
 	FN(CANXL_RX_INVALID_FRAME)	\
 	FN(PFMEMALLOC)	\
-	FN(DUALPI2_STEP_DROP)		\
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FNe(MAX)
@@ -579,11 +578,6 @@ enum skb_drop_reason {
 	 * reached a path or socket not eligible for use of memory reserves
 	 */
 	SKB_DROP_REASON_PFMEMALLOC,
-	/**
-	 * @SKB_DROP_REASON_DUALPI2_STEP_DROP: dropped by the step drop
-	 * threshold of DualPI2 qdisc.
-	 */
-	SKB_DROP_REASON_DUALPI2_STEP_DROP,
 	/** @SKB_DROP_REASON_PSP_INPUT: PSP input checks failed */
 	SKB_DROP_REASON_PSP_INPUT,
 	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index 84f19a51382c..fb151cd31751 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -14,6 +14,7 @@
 	FN(BAND_LIMIT)		\
 	FN(HORIZON_LIMIT)		\
 	FN(FLOW_LIMIT)			\
+	FN(L4S_STEP_NON_ECN)		\
 	FNe(MAX)
 
 #undef FN
@@ -93,6 +94,13 @@ enum qdisc_drop_reason {
 	 * monopolizing queue resources.
 	 */
 	QDISC_DROP_FLOW_LIMIT,
+	/**
+	 * @QDISC_DROP_L4S_STEP_NON_ECN: DualPI2 qdisc dropped a non-ECN-capable
+	 * packet because the L4S queue delay exceeded the step threshold.
+	 * Since the packet cannot be ECN-marked, it must be dropped to signal
+	 * congestion. See RFC 9332 for the DualQ Coupled AQM step mechanism.
+	 */
+	QDISC_DROP_L4S_STEP_NON_ECN,
 	/**
 	 * @QDISC_DROP_MAX: the maximum of qdisc drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 0b6a38704a3b..fe6f5e889625 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -571,11 +571,11 @@ static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
 }
 
 static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
-			   struct Qdisc *sch, enum skb_drop_reason reason)
+			   struct Qdisc *sch, enum qdisc_drop_reason reason)
 {
 	++q->deferred_drops_cnt;
 	q->deferred_drops_len += qdisc_pkt_len(skb);
-	kfree_skb_reason(skb, reason);
+	qdisc_dequeue_drop(sch, skb, reason);
 	qdisc_qstats_drop(sch);
 }
 
@@ -590,15 +590,13 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
 
 	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
 		if (!q->drop_early && must_drop(sch, q, skb)) {
-			drop_and_retry(q, skb, sch,
-				       QDISC_DROP_CONGESTED);
+			drop_and_retry(q, skb, sch, QDISC_DROP_CONGESTED);
 			continue;
 		}
 
 		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
 			qdisc_qstats_drop(q->l_queue);
-			drop_and_retry(q, skb, sch,
-				       SKB_DROP_REASON_DUALPI2_STEP_DROP);
+			drop_and_retry(q, skb, sch, QDISC_DROP_L4S_STEP_NON_ECN);
 			continue;
 		}
 
@@ -915,6 +913,8 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	int err;
 
+	sch->flags |= TCQ_F_DEQUEUE_DROPS;
+
 	q->l_queue = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				       TC_H_MAKE(sch->handle, 1), extack);
 	if (!q->l_queue)



