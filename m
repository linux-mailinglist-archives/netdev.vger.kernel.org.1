Return-Path: <netdev+bounces-261355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNWNEkBPoGmIiAQAu9opvQ
	(envelope-from <netdev+bounces-261355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:48:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A80EF1A6F01
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 207CF30A0C59
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422136BCF7;
	Thu, 26 Feb 2026 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLh01y8u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143936BCCA;
	Thu, 26 Feb 2026 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113458; cv=none; b=GzCzD9WvcNM53odzKqSbNiOF5O4rKy9uRjY/CmILoeANB+LG5rS8tT1DxpLJ2X9kQnappATYJBzjpVG8rJqL0YjyNCWVhfcYfrtkqIxrkogWidCblPKjsjSYNYcAUXzWbalEoracXIxnnFrXfyZlbWnxZ+oIrDQQGPfsEkdmYYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113458; c=relaxed/simple;
	bh=OBWz7rXJYELdCIdJR5ZZUX8Bbmrw+fNLcd9wzFwoO6I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUT59DpsmaFmxTK9dzM92ixMdOkRzG5dLLKakwjlSgDebmFMyhaWM1/8RVSD3hF0LQukwdcwL5euEDrtgyy9tKTrDug/O3mhTGsryo1oNYL+XkMokUaaCS7TOhy+nmjKi2NgAeC4K54pxFJPBx1z9jnTI12S0YCI5NOTY0mzbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLh01y8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4EEC116C6;
	Thu, 26 Feb 2026 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113458;
	bh=OBWz7rXJYELdCIdJR5ZZUX8Bbmrw+fNLcd9wzFwoO6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nLh01y8uPtAmG3XhHrxbAnxCnIIsH+/bns5ft5Hm6EL9FFtZ7xpum1NWm0W+rgThU
	 fw8c6o32AYH43EFtylYtRcF8WASJRB2E2EMPp9z63ApZH2hIMWOlTfRzrGOSzqQbiI
	 qRfJKCUSKeBgsJWBi047pzNXxPAYrUWkmuNJ/5fWaEwOecJ90H+oXMURwFk6yMqJAs
	 CWDslsdQtXyy7woQhLD4/V/p7D2R4p6sBdwjccTQogR25abu7SATWVFdEahdBIfZl+
	 6xgt1pLStmhN5WGSt9gouUaulF12al/KgQtCb7fJBqRJskYg6PROJXrP095IYZICSN
	 9v6eCn57PSNjQ==
Subject: [PATCH net-next v5 1/5] net: sched: introduce qdisc-specific drop
 reason tracing
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 26 Feb 2026 14:44:12 +0100
Message-ID: <177211345275.3011628.1974310302645218067.stgit@firesoul>
In-Reply-To: <177211325634.3011628.9343837509740374154.stgit@firesoul>
References: <177211325634.3011628.9343837509740374154.stgit@firesoul>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261355-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A80EF1A6F01
X-Rspamd-Action: no action

Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
for qdisc layer drop diagnostics with direct qdisc context visibility.

The new tracepoint includes qdisc handle, parent, kind (name), and
device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
for backwards compatibility via kfree_skb_reason().

Convert qdiscs with drop reasons to use the new infrastructure.

Change CAKE's cobalt_should_drop() return type from enum skb_drop_reason
to enum qdisc_drop_reason to fix implicit enum conversion warnings.
Use QDISC_DROP_UNSPEC as the 'not dropped' sentinel instead of
SKB_NOT_DROPPED_YET. Both have the same compiled value (0), so the
comparison logic remains semantically equivalent.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/dropreason-core.h  |   42 ++----------------
 include/net/dropreason-qdisc.h |   94 ++++++++++++++++++++++++++++++++++++++++
 include/net/dropreason.h       |    6 +++
 include/net/sch_generic.h      |   43 +++++++++++++-----
 include/trace/events/qdisc.h   |   51 ++++++++++++++++++++++
 net/core/dev.c                 |    8 ++-
 net/sched/sch_cake.c           |   26 ++++++-----
 net/sched/sch_codel.c          |    5 +-
 net/sched/sch_dualpi2.c        |    8 +--
 net/sched/sch_fq.c             |    7 +--
 net/sched/sch_fq_codel.c       |    4 +-
 net/sched/sch_fq_pie.c         |    4 +-
 net/sched/sch_generic.c        |   29 +++++++++++-
 net/sched/sch_gred.c           |    4 +-
 net/sched/sch_pie.c            |    4 +-
 net/sched/sch_red.c            |    4 +-
 net/sched/sch_sfb.c            |    4 +-
 17 files changed, 249 insertions(+), 94 deletions(-)
 create mode 100644 include/net/dropreason-qdisc.h

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a7b7abd66e21..3d8d284e05c8 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -68,12 +68,6 @@
 	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
 	FN(QDISC_BURST_DROP)		\
-	FN(QDISC_OVERLIMIT)		\
-	FN(QDISC_CONGESTED)		\
-	FN(CAKE_FLOOD)			\
-	FN(FQ_BAND_LIMIT)		\
-	FN(FQ_HORIZON_LIMIT)		\
-	FN(FQ_FLOW_LIMIT)		\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
 	FN(TC_INGRESS)			\
@@ -371,8 +365,10 @@ enum skb_drop_reason {
 	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
 	SKB_DROP_REASON_SECURITY_HOOK,
 	/**
-	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
-	 * failed to enqueue to current qdisc)
+	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc during enqueue or
+	 * dequeue. More specific drop reasons are available via the
+	 * qdisc:qdisc_drop tracepoint, which also provides qdisc handle
+	 * and name for identifying the source.
 	 */
 	SKB_DROP_REASON_QDISC_DROP,
 	/**
@@ -380,36 +376,6 @@ enum skb_drop_reason {
 	 * limit is hit.
 	 */
 	SKB_DROP_REASON_QDISC_BURST_DROP,
-	/**
-	 * @SKB_DROP_REASON_QDISC_OVERLIMIT: dropped by qdisc when a qdisc
-	 * instance exceeds its total buffer size limit.
-	 */
-	SKB_DROP_REASON_QDISC_OVERLIMIT,
-	/**
-	 * @SKB_DROP_REASON_QDISC_CONGESTED: dropped by a qdisc AQM algorithm
-	 * due to congestion.
-	 */
-	SKB_DROP_REASON_QDISC_CONGESTED,
-	/**
-	 * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection part of
-	 * CAKE qdisc AQM algorithm (BLUE).
-	 */
-	SKB_DROP_REASON_CAKE_FLOOD,
-	/**
-	 * @SKB_DROP_REASON_FQ_BAND_LIMIT: dropped by fq qdisc when per band
-	 * limit is reached.
-	 */
-	SKB_DROP_REASON_FQ_BAND_LIMIT,
-	/**
-	 * @SKB_DROP_REASON_FQ_HORIZON_LIMIT: dropped by fq qdisc when packet
-	 * timestamp is too far in the future.
-	 */
-	SKB_DROP_REASON_FQ_HORIZON_LIMIT,
-	/**
-	 * @SKB_DROP_REASON_FQ_FLOW_LIMIT: dropped by fq qdisc when a flow
-	 * exceeds its limits.
-	 */
-	SKB_DROP_REASON_FQ_FLOW_LIMIT,
 	/**
 	 * @SKB_DROP_REASON_CPU_BACKLOG: failed to enqueue the skb to the per CPU
 	 * backlog queue. This can be caused by backlog queue full (see
diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
new file mode 100644
index 000000000000..80a2d557e5f7
--- /dev/null
+++ b/include/net/dropreason-qdisc.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_DROPREASON_QDISC_H
+#define _LINUX_DROPREASON_QDISC_H
+#include <net/dropreason.h>
+
+#define DEFINE_QDISC_DROP_REASON(FN, FNe)	\
+	FN(UNSPEC)			\
+	FN(GENERIC)			\
+	FN(OVERLIMIT)			\
+	FN(CONGESTED)			\
+	FN(CAKE_FLOOD)			\
+	FN(FQ_BAND_LIMIT)		\
+	FN(FQ_HORIZON_LIMIT)		\
+	FN(FQ_FLOW_LIMIT)		\
+	FNe(MAX)
+
+#undef FN
+#undef FNe
+#define FN(reason)	QDISC_DROP_##reason,
+#define FNe(reason)	QDISC_DROP_##reason
+
+/**
+ * enum qdisc_drop_reason - reason why a qdisc dropped a packet
+ *
+ * Qdisc-specific drop reasons for packet drops that occur within the
+ * traffic control (TC) queueing discipline layer. These reasons provide
+ * detailed diagnostics about why packets were dropped by various qdisc
+ * algorithms, enabling fine-grained monitoring and troubleshooting of
+ * queue behavior.
+ */
+enum qdisc_drop_reason {
+	/**
+	 * @QDISC_DROP_UNSPEC: unspecified/invalid qdisc drop reason.
+	 * Value 0 serves as analogous to SKB_NOT_DROPPED_YET for enum skb_drop_reason.
+	 * Used for catching zero-initialized drop_reason fields.
+	 */
+	QDISC_DROP_UNSPEC = 0,
+	/**
+	 * @__QDISC_DROP_REASON: subsystem base value for qdisc drop reasons
+	 */
+	__QDISC_DROP_REASON = SKB_DROP_REASON_SUBSYS_QDISC <<
+				SKB_DROP_REASON_SUBSYS_SHIFT,
+	/**
+	 * @QDISC_DROP_GENERIC: generic/default qdisc drop, used when no
+	 * more specific reason applies
+	 */
+	QDISC_DROP_GENERIC,
+	/**
+	 * @QDISC_DROP_OVERLIMIT: packet dropped because the qdisc queue
+	 * length exceeded its configured limit (sch->limit). This typically
+	 * indicates the queue is full and cannot accept more packets.
+	 */
+	QDISC_DROP_OVERLIMIT,
+	/**
+	 * @QDISC_DROP_CONGESTED: packet dropped due to active congestion
+	 * control algorithms (e.g., CoDel, PIE, RED) detecting network
+	 * congestion. The qdisc proactively dropped the packet to signal
+	 * congestion to the sender and prevent bufferbloat.
+	 */
+	QDISC_DROP_CONGESTED,
+	/**
+	 * @QDISC_DROP_CAKE_FLOOD: CAKE qdisc dropped packet due to flood
+	 * protection mechanism (BLUE algorithm). This indicates potential
+	 * DoS/flood attack or unresponsive flow behavior.
+	 */
+	QDISC_DROP_CAKE_FLOOD,
+	/**
+	 * @QDISC_DROP_FQ_BAND_LIMIT: FQ (Fair Queue) dropped packet because
+	 * the priority band's packet limit was reached. Each priority band
+	 * in FQ has its own limit.
+	 */
+	QDISC_DROP_FQ_BAND_LIMIT,
+	/**
+	 * @QDISC_DROP_FQ_HORIZON_LIMIT: FQ dropped packet because its
+	 * timestamp is too far in the future (beyond the configured horizon).
+	 */
+	QDISC_DROP_FQ_HORIZON_LIMIT,
+	/**
+	 * @QDISC_DROP_FQ_FLOW_LIMIT: FQ dropped packet because an individual
+	 * flow exceeded its per-flow packet limit.
+	 */
+	QDISC_DROP_FQ_FLOW_LIMIT,
+	/**
+	 * @QDISC_DROP_MAX: the maximum of qdisc drop reasons, which
+	 * shouldn't be used as a real 'reason' - only for tracing code gen
+	 */
+	QDISC_DROP_MAX,
+};
+
+#undef FN
+#undef FNe
+
+#endif
diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 7d3b1a2a6fec..1df60645fb27 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -23,6 +23,12 @@ enum skb_drop_reason_subsys {
 	 */
 	SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
 
+	/**
+	 * @SKB_DROP_REASON_SUBSYS_QDISC: TC qdisc drop reasons,
+	 * see include/net/dropreason-qdisc.h
+	 */
+	SKB_DROP_REASON_SUBSYS_QDISC,
+
 	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
 	SKB_DROP_REASON_SUBSYS_NUM
 };
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3a7268b567e..31c25a6d6acc 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -20,12 +20,15 @@
 #include <net/rtnetlink.h>
 #include <net/flow_offload.h>
 #include <linux/xarray.h>
+#include <net/dropreason-qdisc.h>
 
 struct Qdisc_ops;
 struct qdisc_walker;
 struct tcf_walker;
 struct module;
 struct bpf_flow_keys;
+struct Qdisc;
+struct netdev_queue;
 
 struct qdisc_rate_table {
 	struct tc_ratespec rate;
@@ -1106,36 +1109,50 @@ static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
 	return cb;
 }
 
+/* TC classifier accessors - use enum skb_drop_reason */
 static inline enum skb_drop_reason
 tcf_get_drop_reason(const struct sk_buff *skb)
 {
-	return tc_skb_cb(skb)->drop_reason;
+	return (enum skb_drop_reason)tc_skb_cb(skb)->drop_reason;
 }
 
 static inline void tcf_set_drop_reason(const struct sk_buff *skb,
 				       enum skb_drop_reason reason)
 {
-	tc_skb_cb(skb)->drop_reason = reason;
+	tc_skb_cb(skb)->drop_reason = (enum qdisc_drop_reason)reason;
 }
 
-static inline void tcf_kfree_skb_list(struct sk_buff *skb)
+/* Qdisc accessors - use enum qdisc_drop_reason */
+static inline enum qdisc_drop_reason
+tcf_get_qdisc_drop_reason(const struct sk_buff *skb)
 {
-	while (unlikely(skb)) {
-		struct sk_buff *next = skb->next;
+	return tc_skb_cb(skb)->drop_reason;
+}
 
-		prefetch(next);
-		kfree_skb_reason(skb, tcf_get_drop_reason(skb));
-		skb = next;
-	}
+static inline void tcf_set_qdisc_drop_reason(const struct sk_buff *skb,
+					     enum qdisc_drop_reason reason)
+{
+	tc_skb_cb(skb)->drop_reason = reason;
+}
+
+void __tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
+			  struct netdev_queue *txq, struct net_device *dev);
+
+static inline void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
+				      struct netdev_queue *txq,
+				      struct net_device *dev)
+{
+	if (unlikely(skb))
+		__tcf_kfree_skb_list(skb, q, txq, dev);
 }
 
 static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
-				      enum skb_drop_reason reason)
+				      enum qdisc_drop_reason reason)
 {
 	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
 	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
 
-	tcf_set_drop_reason(skb, reason);
+	tcf_set_qdisc_drop_reason(skb, reason);
 	skb->next = q->to_free;
 	q->to_free = skb;
 }
@@ -1312,9 +1329,9 @@ static inline int qdisc_drop(struct sk_buff *skb, struct Qdisc *sch,
 
 static inline int qdisc_drop_reason(struct sk_buff *skb, struct Qdisc *sch,
 				    struct sk_buff **to_free,
-				    enum skb_drop_reason reason)
+				    enum qdisc_drop_reason reason)
 {
-	tcf_set_drop_reason(skb, reason);
+	tcf_set_qdisc_drop_reason(skb, reason);
 	return qdisc_drop(skb, sch, to_free);
 }
 
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index ff33f41a9db7..d8a5c2677470 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -74,6 +74,57 @@ TRACE_EVENT(qdisc_enqueue,
 		  __entry->ifindex, __entry->handle, __entry->parent, __entry->skbaddr)
 );
 
+#undef FN
+#undef FNe
+#define FN(reason)	TRACE_DEFINE_ENUM(QDISC_DROP_##reason);
+#define FNe(reason)	TRACE_DEFINE_ENUM(QDISC_DROP_##reason);
+DEFINE_QDISC_DROP_REASON(FN, FNe)
+
+#undef FN
+#undef FNe
+#define FN(reason)	{ QDISC_DROP_##reason, #reason },
+#define FNe(reason)	{ QDISC_DROP_##reason, #reason }
+
+TRACE_EVENT(qdisc_drop,
+
+	TP_PROTO(struct Qdisc *qdisc, const struct netdev_queue *txq,
+		 struct net_device *dev, struct sk_buff *skb,
+		 enum qdisc_drop_reason reason),
+
+	TP_ARGS(qdisc, txq, dev, skb, reason),
+
+	TP_STRUCT__entry(
+		__field(struct Qdisc *, qdisc)
+		__field(const struct netdev_queue *, txq)
+		__field(void *,	skbaddr)
+		__field(int, ifindex)
+		__field(u32, handle)
+		__field(u32, parent)
+		__field(enum qdisc_drop_reason, reason)
+		__string(kind, qdisc->ops->id)
+	),
+
+	TP_fast_assign(
+		__entry->qdisc = qdisc;
+		__entry->txq	 = txq;
+		__entry->skbaddr = skb;
+		__entry->ifindex = dev ? dev->ifindex : 0;
+		__entry->handle	 = qdisc->handle;
+		__entry->parent	 = qdisc->parent;
+		__entry->reason	 = reason;
+		__assign_str(kind);
+	),
+
+	TP_printk("drop ifindex=%d kind=%s handle=0x%X parent=0x%X skbaddr=%p reason=%s",
+		  __entry->ifindex, __get_str(kind), __entry->handle,
+		  __entry->parent, __entry->skbaddr,
+		  __print_symbolic(__entry->reason,
+				   DEFINE_QDISC_DROP_REASON(FN, FNe)))
+);
+
+#undef FN
+#undef FNe
+
 TRACE_EVENT(qdisc_reset,
 
 	TP_PROTO(struct Qdisc *q),
diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..7e16c0180185 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4166,7 +4166,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 	qdisc_calculate_pkt_len(skb, q);
 
-	tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+	tcf_set_qdisc_drop_reason(skb, QDISC_DROP_GENERIC);
 
 	if (q->flags & TCQ_F_NOLOCK) {
 		if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(q) &&
@@ -4274,8 +4274,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	spin_unlock(root_lock);
 
 free_skbs:
-	tcf_kfree_skb_list(to_free);
-	tcf_kfree_skb_list(to_free2);
+	tcf_kfree_skb_list(to_free, q, txq, dev);
+	tcf_kfree_skb_list(to_free2, q, txq, dev);
 	return rc;
 }
 
@@ -5800,7 +5800,7 @@ static __latent_entropy void net_tx_action(void)
 			to_free = qdisc_run(q);
 			if (root_lock)
 				spin_unlock(root_lock);
-			tcf_kfree_skb_list(to_free);
+			tcf_kfree_skb_list(to_free, q, NULL, qdisc_dev(q));
 		}
 
 		rcu_read_unlock();
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d2bbd5654d5b..6e1d3be76201 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -497,13 +497,13 @@ static bool cobalt_queue_empty(struct cobalt_vars *vars,
 /* Call this with a freshly dequeued packet for possible congestion marking.
  * Returns true as an instruction to drop the packet, false for delivery.
  */
-static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
-					       struct cobalt_params *p,
-					       ktime_t now,
-					       struct sk_buff *skb,
-					       u32 bulk_flows)
+static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
+						 struct cobalt_params *p,
+						 ktime_t now,
+						 struct sk_buff *skb,
+						 u32 bulk_flows)
 {
-	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
+	enum qdisc_drop_reason reason = QDISC_DROP_UNSPEC;
 	bool next_due, over_target;
 	ktime_t schedule;
 	u64 sojourn;
@@ -548,7 +548,7 @@ static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	if (next_due && vars->dropping) {
 		/* Use ECN mark if possible, otherwise drop */
 		if (!(vars->ecn_marked = INET_ECN_set_ce(skb)))
-			reason = SKB_DROP_REASON_QDISC_CONGESTED;
+			reason = QDISC_DROP_CONGESTED;
 
 		vars->count++;
 		if (!vars->count)
@@ -571,14 +571,14 @@ static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	}
 
 	/* Simple BLUE implementation.  Lack of ECN is deliberate. */
-	if (vars->p_drop && reason == SKB_NOT_DROPPED_YET &&
+	if (vars->p_drop && reason == QDISC_DROP_UNSPEC &&
 	    get_random_u32() < vars->p_drop)
-		reason = SKB_DROP_REASON_CAKE_FLOOD;
+		reason = QDISC_DROP_CAKE_FLOOD;
 
 	/* Overload the drop_next field as an activity timeout */
 	if (!vars->count)
 		vars->drop_next = ktime_add_ns(now, p->interval);
-	else if (ktime_to_ns(schedule) > 0 && reason == SKB_NOT_DROPPED_YET)
+	else if (ktime_to_ns(schedule) > 0 && reason == QDISC_DROP_UNSPEC)
 		vars->drop_next = now;
 
 	return reason;
@@ -1604,7 +1604,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 		cake_advance_shaper(q, b, skb, now, true);
 
-	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
+	qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 	sch->q.qlen--;
 
 	cake_heapify(q, 0);
@@ -2004,7 +2004,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
-	enum skb_drop_reason reason;
+	enum qdisc_drop_reason reason;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
@@ -2225,7 +2225,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 					     !!(q->config->rate_flags &
 						CAKE_FLAG_INGRESS)));
 		/* Last packet in queue may be marked, shouldn't be dropped */
-		if (reason == SKB_NOT_DROPPED_YET || !flow->head)
+		if (reason == QDISC_DROP_UNSPEC || !flow->head)
 			break;
 
 		/* drop this packet, get another one */
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index c6551578f1cf..dc2be90666ff 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -52,7 +52,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 {
 	struct Qdisc *sch = ctx;
 
-	qdisc_dequeue_drop(sch, skb, SKB_DROP_REASON_QDISC_CONGESTED);
+	qdisc_dequeue_drop(sch, skb, QDISC_DROP_CONGESTED);
 	qdisc_qstats_drop(sch);
 }
 
@@ -86,8 +86,7 @@ static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 	q = qdisc_priv(sch);
 	q->drop_overlimit++;
-	return qdisc_drop_reason(skb, sch, to_free,
-				 SKB_DROP_REASON_QDISC_OVERLIMIT);
+	return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 }
 
 static const struct nla_policy codel_policy[TCA_CODEL_MAX + 1] = {
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 6d7e6389758d..020cc20c6b56 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -393,13 +393,11 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 		qdisc_qstats_overlimit(sch);
 		if (skb_in_l_queue(skb))
 			qdisc_qstats_overlimit(q->l_queue);
-		return qdisc_drop_reason(skb, sch, to_free,
-					 SKB_DROP_REASON_QDISC_OVERLIMIT);
+		return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 	}
 
 	if (q->drop_early && must_drop(sch, q, skb)) {
-		qdisc_drop_reason(skb, sch, to_free,
-				  SKB_DROP_REASON_QDISC_CONGESTED);
+		qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_CONGESTED);
 		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	}
 
@@ -593,7 +591,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
 	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
 		if (!q->drop_early && must_drop(sch, q, skb)) {
 			drop_and_retry(q, skb, sch,
-				       SKB_DROP_REASON_QDISC_CONGESTED);
+				       SKB_DROP_REASON_QDISC_DROP);
 			continue;
 		}
 
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 80235e85f844..81322187bbe2 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -539,7 +539,7 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
-#define FQDR(reason) SKB_DROP_REASON_FQ_##reason
+#define FQDR(reason) QDISC_DROP_FQ_##reason
 
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)
@@ -552,8 +552,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	band = fq_prio2band(q->prio2band, skb->priority & TC_PRIO_MAX);
 	if (unlikely(q->band_pkt_count[band] >= sch->limit)) {
 		q->stat_band_drops[band]++;
-		return qdisc_drop_reason(skb, sch, to_free,
-					 FQDR(BAND_LIMIT));
+		return qdisc_drop_reason(skb, sch, to_free, FQDR(BAND_LIMIT));
 	}
 
 	now = ktime_get_ns();
@@ -579,7 +578,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (unlikely(f->qlen >= q->flow_plimit)) {
 			q->stat_flows_plimit++;
 			return qdisc_drop_reason(skb, sch, to_free,
-						 FQDR(FLOW_LIMIT));
+						 QDISC_DROP_FQ_FLOW_LIMIT);
 		}
 
 		if (fq_flow_is_detached(f)) {
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index dc187c7f06b1..3e384a344bc3 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -168,7 +168,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 		skb = dequeue_head(flow);
 		len += qdisc_pkt_len(skb);
 		mem += get_codel_cb(skb)->mem_usage;
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_OVERLIMIT);
+		tcf_set_qdisc_drop_reason(skb, QDISC_DROP_OVERLIMIT);
 		__qdisc_drop(skb, to_free);
 	} while (++i < max_packets && len < threshold);
 
@@ -275,7 +275,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 {
 	struct Qdisc *sch = ctx;
 
-	qdisc_dequeue_drop(sch, skb, SKB_DROP_REASON_QDISC_CONGESTED);
+	qdisc_dequeue_drop(sch, skb, QDISC_DROP_CONGESTED);
 	qdisc_qstats_drop(sch);
 }
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 7b96bc3ff891..9fe997179d78 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -130,7 +130,7 @@ static inline void flow_queue_add(struct fq_pie_flow *flow,
 static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				struct sk_buff **to_free)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
+	enum qdisc_drop_reason reason = QDISC_DROP_OVERLIMIT;
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
 	struct fq_pie_flow *sel_flow;
 	int ret;
@@ -162,7 +162,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->overmemory++;
 	}
 
-	reason = SKB_DROP_REASON_QDISC_CONGESTED;
+	reason = QDISC_DROP_CONGESTED;
 
 	if (!pie_drop_early(sch, &q->p_params, &sel_flow->vars,
 			    sel_flow->backlog, skb->len)) {
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 98ffe64de51f..556e0d800316 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -25,11 +25,11 @@
 #include <linux/skb_array.h>
 #include <linux/if_macvlan.h>
 #include <linux/bpf.h>
+#include <trace/events/qdisc.h>
 #include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 #include <net/dst.h>
 #include <net/hotdata.h>
-#include <trace/events/qdisc.h>
 #include <trace/events/net.h>
 #include <net/xfrm.h>
 
@@ -37,6 +37,31 @@
 const struct Qdisc_ops *default_qdisc_ops = &pfifo_fast_ops;
 EXPORT_SYMBOL(default_qdisc_ops);
 
+void __tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
+			  struct netdev_queue *txq, struct net_device *dev)
+{
+	while (skb) {
+		u32 reason = tc_skb_cb(skb)->drop_reason;
+		struct sk_buff *next = skb->next;
+		enum skb_drop_reason skb_reason;
+
+		prefetch(next);
+		/* TC classifier and qdisc share drop_reason storage.
+		 * Check subsystem mask to identify qdisc drop reasons,
+		 * else pass through skb_drop_reason set by TC classifier.
+		 */
+		if ((reason & SKB_DROP_REASON_SUBSYS_MASK) == __QDISC_DROP_REASON) {
+			trace_qdisc_drop(q, txq, dev, skb, (enum qdisc_drop_reason)reason);
+			skb_reason = SKB_DROP_REASON_QDISC_DROP;
+		} else {
+			skb_reason = (enum skb_drop_reason)reason;
+		}
+		kfree_skb_reason(skb, skb_reason);
+		skb = next;
+	}
+}
+EXPORT_SYMBOL(__tcf_kfree_skb_list);
+
 static void qdisc_maybe_clear_missed(struct Qdisc *q,
 				     const struct netdev_queue *txq)
 {
@@ -741,7 +766,7 @@ static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
 	err = skb_array_produce(q, skb);
 
 	if (unlikely(err)) {
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_OVERLIMIT);
+		tcf_set_qdisc_drop_reason(skb, QDISC_DROP_OVERLIMIT);
 
 		if (qdisc_is_percpu_stats(qdisc))
 			return qdisc_drop_cpu(skb, qdisc, to_free);
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 532fde548b88..66b72a09725f 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -251,10 +251,10 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	q->stats.pdrop++;
 drop:
-	return qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
+	return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 
 congestion_drop:
-	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_CONGESTED);
+	qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_CONGESTED);
 	return NET_XMIT_CN;
 }
 
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 0a377313b6a9..16f3f629cb8e 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(pie_drop_early);
 static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			     struct sk_buff **to_free)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
+	enum qdisc_drop_reason reason = QDISC_DROP_OVERLIMIT;
 	struct pie_sched_data *q = qdisc_priv(sch);
 	bool enqueue = false;
 
@@ -94,7 +94,7 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		goto out;
 	}
 
-	reason = SKB_DROP_REASON_QDISC_CONGESTED;
+	reason = QDISC_DROP_CONGESTED;
 
 	if (!pie_drop_early(sch, &q->params, &q->vars, sch->qstats.backlog,
 			    skb->len)) {
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 479c42d11083..c8d3d09f15e3 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -70,7 +70,7 @@ static int red_use_nodrop(struct red_sched_data *q)
 static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		       struct sk_buff **to_free)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_CONGESTED;
+	enum qdisc_drop_reason reason = QDISC_DROP_CONGESTED;
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *child = q->qdisc;
 	unsigned int len;
@@ -108,7 +108,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		break;
 
 	case RED_HARD_MARK:
-		reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
+		reason = QDISC_DROP_OVERLIMIT;
 		qdisc_qstats_overlimit(sch);
 		if (red_use_harddrop(q) || !red_use_ecn(q)) {
 			q->stats.forced_drop++;
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index d2835f1168e1..013738662128 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -280,7 +280,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		       struct sk_buff **to_free)
 {
 
-	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
+	enum qdisc_drop_reason reason = QDISC_DROP_OVERLIMIT;
 	struct sfb_sched_data *q = qdisc_priv(sch);
 	unsigned int len = qdisc_pkt_len(skb);
 	struct Qdisc *child = q->qdisc;
@@ -381,7 +381,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	r = get_random_u16() & SFB_MAX_PROB;
-	reason = SKB_DROP_REASON_QDISC_CONGESTED;
+	reason = QDISC_DROP_CONGESTED;
 
 	if (unlikely(r < p_min)) {
 		if (unlikely(p_min > SFB_MAX_PROB / 2)) {



