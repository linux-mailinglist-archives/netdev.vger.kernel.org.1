Return-Path: <netdev+bounces-277513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP7rCStA2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4163DB6E0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2949E300B517
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329033E1D1F;
	Fri, 10 Apr 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzDd6eOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45678F29
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845414; cv=none; b=AI2kl2qYQoiKCk+mwtkfohjQB+H56nhw1EOYsbAFD6g5s/Av//fYy7DHN8bDOxeaxzFp6jXsojJUVSZjKzq77+i0hyW9b4hH+ltVUrdivXLR+Wb59RM5H13b55KOhtDX5wMHUirwQm9Zu7UAsJ2Td4BS5dwacWQHZLJGK/Ha9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845414; c=relaxed/simple;
	bh=A68+kTDo1PnM9jOva9AbGFOSalbvWj12qoKQC7F8ca4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NjarloPHQkFuUfv4T/LUI3od1BMmW1vpYZyYno0LSdec8tPMBtZ9bJhtirD8tmxsvtKF5qqM8HwKHUCfv2AEF0R3fqe6kB6Ak2UA7/YR3DsKG2WL55CakBhnxvo7Ja/5P659N+pe0YJ/jZ6Jb5eHslhO41omSmU3vFmS4kO1BY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzDd6eOj; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-65036e62f9bso3887925d50.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845412; x=1776450212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPILxc+MO2kLmgLEp1DJwkQduMtISlxjej/4IadVx/g=;
        b=WzDd6eOjm5w10kPdWOxfdqRJ/jUwKI2i9C3WcEBTaaS6AUmorlXnLwwX360bRMfn0/
         0vou3l4OmWTM2m6+QsmFbMv7mJ0xtpkaEZ7najYWlxjSXs6feBJYWxk9eLHuhj2qLawc
         622TTRDQM0CaYlqmdrexc4oNwk7qgrVf+QPWYNF/lshrtlg4N0QX2I+xE8e2A/zGZ651
         9dztSooPlaMF23C2lIx2sfSz9KIWjrT0Hy93FuE3C3qHc3wDmmGlfLYMq23oWOJN0jaK
         0W+MOmD75jVPswwXpZdT+tDMCiHZ7sHIuFVHhXCberR6+mjoyvQLF9AoSTmWARPc9JgV
         YlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845412; x=1776450212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPILxc+MO2kLmgLEp1DJwkQduMtISlxjej/4IadVx/g=;
        b=aIv8BSLGX74XP5eU63MrVVDwLB3rMockd9N0eA/NrMTptxZLCf2w+jNiiBw0mbfxPL
         jaTPHzCqsZAIqGNlbqOOHP0fwSGPg7VZGODyLD8qjsVs9EX1wkhPd1eGA0hOM+GmZDyF
         icnwyEaCJl1ZohNgBAtvKQCGmSyHDpgMtSBgLWkdDOhLq0IIHTvpNvwaXFj25q0ZOvb+
         6Z5o8L3DgeOtzW9GvJLQhUjjpJD0zm2IDvqk9Pkxok8Zsk/f1nJmsFjXOBoemRDHackY
         S60t41+1hdRmRPm8fngGg1H+ymyuxXQRcLmau/2pFt5oxXh9wICiJrnIDiPRkbaxILb4
         ZDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgDFQp9L0Um7hdLtUUwwIBtkHY0YAR0RNVgqxVmvbp7xbOJF/OSv3BXkv6jzxnHRRXyHSxrPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTa6dhW4+IzNQCksSTkEeeFgcFalRTlQlzEDqb7TxteQg/Gvl
	6JgVqR1A0kIEUglsyB3QXsbAeAnXDqP/Q64gNvgu1lZABCO0jTpMZVfwT4t4C790WzFemFGbFQC
	5kWqzCZDDGQmdkA==
X-Received: from yxtr16.prod.google.com ([2002:a53:ec50:0:b0:650:7ea:d887])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:cb03:0:b0:649:da44:78ad with SMTP id 956f58d0204a3-65198b89b2dmr2941682d50.49.1775845411428;
 Fri, 10 Apr 2026 11:23:31 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:56 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-15-edumazet@google.com>
Subject: [PATCH v3 net-next 14/15] net/sched: mq: no longer acquire qdisc
 spinlocks in dump operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277513-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2B4163DB6E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prepare mq_dump_common(), mqprio_dump() and mqprio_dump_class_stats()
for RTNL avoidance.

Use private variables instead of assuming sch->bstats and sch->qstats
can be used when folding stats from children.

This means the children qdisc spinlocks no longer need to be acquired.

Add qdisc_qlen_lockless() helper, and change gnet_stats_add_basic()
prototype.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/gen_stats.h   |  9 +++--
 include/net/sch_generic.h | 14 ++++++++
 net/core/gen_estimator.c  | 24 ++++++-------
 net/core/gen_stats.c      | 17 +++++-----
 net/sched/sch_mq.c        | 33 +++++++++++-------
 net/sched/sch_mqprio.c    | 71 +++++++++++++++++++--------------------
 6 files changed, 95 insertions(+), 73 deletions(-)

diff --git a/include/net/gen_stats.h b/include/net/gen_stats.h
index 7aa2b8e1fb298c4f994a745b114fc4da785ddf4b..5484b67298e3fe94fe84f0e929799362d21499df 100644
--- a/include/net/gen_stats.h
+++ b/include/net/gen_stats.h
@@ -21,6 +21,11 @@ struct gnet_stats_basic_sync {
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
 
+struct gnet_stats {
+	u64	bytes;
+	u64	packets;
+};
+
 struct net_rate_estimator;
 
 struct gnet_dump {
@@ -49,9 +54,9 @@ int gnet_stats_start_copy_compat(struct sk_buff *skb, int type,
 int gnet_stats_copy_basic(struct gnet_dump *d,
 			  struct gnet_stats_basic_sync __percpu *cpu,
 			  struct gnet_stats_basic_sync *b, bool running);
-void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
+void gnet_stats_add_basic(struct gnet_stats *bstats,
 			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b, bool running);
+			  const struct gnet_stats_basic_sync *b, bool running);
 int gnet_stats_copy_basic_hw(struct gnet_dump *d,
 			     struct gnet_stats_basic_sync __percpu *cpu,
 			     struct gnet_stats_basic_sync *b, bool running);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index b0564a39caf4471619b74179a06a0e41e3765d94..92683be33527bb0a5147d095ba08f5f8494933dd 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -542,6 +542,11 @@ static inline int qdisc_qlen(const struct Qdisc *q)
 	return q->q.qlen;
 }
 
+static inline int qdisc_qlen_lockless(const struct Qdisc *q)
+{
+	return READ_ONCE(q->q.qlen);
+}
+
 static inline void qdisc_qlen_inc(struct Qdisc *q)
 {
 	WRITE_ONCE(q->q.qlen, q->q.qlen + 1);
@@ -947,6 +952,15 @@ static inline void _bstats_update(struct gnet_stats_basic_sync *bstats,
 	u64_stats_update_end(&bstats->syncp);
 }
 
+static inline void _bstats_set(struct gnet_stats_basic_sync *bstats,
+			       u64 bytes, u64 packets)
+{
+	u64_stats_update_begin(&bstats->syncp);
+	u64_stats_set(&bstats->bytes, bytes);
+	u64_stats_set(&bstats->packets, packets);
+	u64_stats_update_end(&bstats->syncp);
+}
+
 static inline void bstats_update(struct gnet_stats_basic_sync *bstats,
 				 const struct sk_buff *skb)
 {
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index c34e58c6c3e666743e72978f9a78cf7f95a360c3..40990aee45590f2c56c070b0d28f856fc82d1f55 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -60,9 +60,10 @@ struct net_rate_estimator {
 };
 
 static void est_fetch_counters(struct net_rate_estimator *e,
-			       struct gnet_stats_basic_sync *b)
+			       struct gnet_stats *b)
 {
-	gnet_stats_basic_sync_init(b);
+	b->packets = 0;
+	b->bytes = 0;
 	if (e->stats_lock)
 		spin_lock(e->stats_lock);
 
@@ -76,18 +77,15 @@ static void est_fetch_counters(struct net_rate_estimator *e,
 static void est_timer(struct timer_list *t)
 {
 	struct net_rate_estimator *est = timer_container_of(est, t, timer);
-	struct gnet_stats_basic_sync b;
-	u64 b_bytes, b_packets;
+	struct gnet_stats b;
 	u64 rate, brate;
 
 	est_fetch_counters(est, &b);
-	b_bytes = u64_stats_read(&b.bytes);
-	b_packets = u64_stats_read(&b.packets);
 
-	brate = (b_bytes - est->last_bytes) << (10 - est->intvl_log);
+	brate = (b.bytes - est->last_bytes) << (10 - est->intvl_log);
 	brate = (brate >> est->ewma_log) - (est->avbps >> est->ewma_log);
 
-	rate = (b_packets - est->last_packets) << (10 - est->intvl_log);
+	rate = (b.packets - est->last_packets) << (10 - est->intvl_log);
 	rate = (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
 
 	preempt_disable_nested();
@@ -97,8 +95,8 @@ static void est_timer(struct timer_list *t)
 	write_seqcount_end(&est->seq);
 	preempt_enable_nested();
 
-	est->last_bytes = b_bytes;
-	est->last_packets = b_packets;
+	est->last_bytes = b.bytes;
+	est->last_packets = b.packets;
 
 	est->next_jiffies += ((HZ/4) << est->intvl_log);
 
@@ -138,7 +136,7 @@ int gen_new_estimator(struct gnet_stats_basic_sync *bstats,
 {
 	struct gnet_estimator *parm = nla_data(opt);
 	struct net_rate_estimator *old, *est;
-	struct gnet_stats_basic_sync b;
+	struct gnet_stats b;
 	int intvl_log;
 
 	if (nla_len(opt) < sizeof(*parm))
@@ -172,8 +170,8 @@ int gen_new_estimator(struct gnet_stats_basic_sync *bstats,
 	est_fetch_counters(est, &b);
 	if (lock)
 		local_bh_enable();
-	est->last_bytes = u64_stats_read(&b.bytes);
-	est->last_packets = u64_stats_read(&b.packets);
+	est->last_bytes = b.bytes;
+	est->last_packets = b.packets;
 
 	if (lock)
 		spin_lock_bh(lock);
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index 1a2380e74272de8eaf3d4ef453e56105a31e9edf..14ee7a4e3709ad5c64a158d3c8d1177ada3a32b0 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -123,10 +123,9 @@ void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
 }
 EXPORT_SYMBOL(gnet_stats_basic_sync_init);
 
-static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
+static void gnet_stats_add_basic_cpu(struct gnet_stats *bstats,
 				     struct gnet_stats_basic_sync __percpu *cpu)
 {
-	u64 t_bytes = 0, t_packets = 0;
 	int i;
 
 	for_each_possible_cpu(i) {
@@ -140,19 +139,18 @@ static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
 			packets = u64_stats_read(&bcpu->packets);
 		} while (u64_stats_fetch_retry(&bcpu->syncp, start));
 
-		t_bytes += bytes;
-		t_packets += packets;
+		bstats->bytes += bytes;
+		bstats->packets += packets;
 	}
-	_bstats_update(bstats, t_bytes, t_packets);
 }
 
-void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
+void gnet_stats_add_basic(struct gnet_stats *bstats,
 			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b, bool running)
+			  const struct gnet_stats_basic_sync *b, bool running)
 {
 	unsigned int start;
-	u64 bytes = 0;
 	u64 packets = 0;
+	u64 bytes = 0;
 
 	WARN_ON_ONCE((cpu || running) && in_hardirq());
 
@@ -167,7 +165,8 @@ void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
 		packets = u64_stats_read(&b->packets);
 	} while (running && u64_stats_fetch_retry(&b->syncp, start));
 
-	_bstats_update(bstats, bytes, packets);
+	bstats->bytes += bytes;
+	bstats->packets += packets;
 }
 EXPORT_SYMBOL(gnet_stats_add_basic);
 
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index ec8c91d3fde04e59daec2aecdb14d6bf50715e15..0d83e69f2f679988d56920c16acb659d2d1ba636 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -143,30 +143,39 @@ EXPORT_SYMBOL_NS_GPL(mq_attach, "NET_SCHED_INTERNAL");
 void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct net_device *dev = qdisc_dev(sch);
+	struct gnet_stats_queue qstats = { 0 };
+	struct gnet_stats bstats = { 0 };
+	const struct Qdisc *qdisc;
 	unsigned int qlen = 0;
-	struct Qdisc *qdisc;
 	unsigned int ntx;
 
-	gnet_stats_basic_sync_init(&sch->bstats);
-	memset(&sch->qstats, 0, sizeof(sch->qstats));
-
 	/* MQ supports lockless qdiscs. However, statistics accounting needs
 	 * to account for all, none, or a mix of locked and unlocked child
 	 * qdiscs. Percpu stats are added to counters in-band and locking
 	 * qdisc totals are added at end.
 	 */
+	rcu_read_lock();
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
-		spin_lock_bh(qdisc_lock(qdisc));
+		qdisc = rcu_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 
-		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
-				     &qdisc->bstats, false);
-		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
+		gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, true);
+		gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
-		qlen += qdisc_qlen(qdisc);
-
-		spin_unlock_bh(qdisc_lock(qdisc));
+		qlen += qdisc_qlen_lockless(qdisc);
 	}
+	rcu_read_unlock();
+
+	spin_lock_bh(qdisc_lock(sch));
+	_bstats_set(&sch->bstats, bstats.bytes, bstats.packets);
+	spin_unlock_bh(qdisc_lock(sch));
+
+	WRITE_ONCE(sch->qstats.qlen, qstats.qlen);
+	WRITE_ONCE(sch->qstats.backlog, qstats.backlog);
+	WRITE_ONCE(sch->qstats.drops, qstats.drops);
+	WRITE_ONCE(sch->qstats.requeues, qstats.requeues);
+	WRITE_ONCE(sch->qstats.overlimits, qstats.overlimits);
+
 	WRITE_ONCE(sch->q.qlen, qlen);
 }
 EXPORT_SYMBOL_NS_GPL(mq_dump_common, "NET_SCHED_INTERNAL");
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 91a92992cd24ab6c30bf7db2288c08cd493c7bc3..0f58b3a3e99a100df929de110fe0bda1a44cc7d6 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -554,32 +554,40 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct net_device *dev = qdisc_dev(sch);
 	struct mqprio_sched *priv = qdisc_priv(sch);
 	struct nlattr *nla = (struct nlattr *)skb_tail_pointer(skb);
+	struct gnet_stats_queue qstats = { 0 };
 	struct tc_mqprio_qopt opt = { 0 };
+	struct gnet_stats bstats = { 0 };
+	const struct Qdisc *qdisc;
 	unsigned int qlen = 0;
-	struct Qdisc *qdisc;
 	unsigned int ntx;
 
-	qlen = 0;
-	gnet_stats_basic_sync_init(&sch->bstats);
-	memset(&sch->qstats, 0, sizeof(sch->qstats));
-
 	/* MQ supports lockless qdiscs. However, statistics accounting needs
 	 * to account for all, none, or a mix of locked and unlocked child
 	 * qdiscs. Percpu stats are added to counters in-band and locking
 	 * qdisc totals are added at end.
 	 */
+	rcu_read_lock();
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
-		spin_lock_bh(qdisc_lock(qdisc));
+		qdisc = rcu_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 
-		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
-				     &qdisc->bstats, false);
-		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
+		gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, true);
+		gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
-		qlen += qdisc_qlen(qdisc);
-
-		spin_unlock_bh(qdisc_lock(qdisc));
+		qlen += qdisc_qlen_lockless(qdisc);
 	}
+	rcu_read_unlock();
+
+	spin_lock_bh(qdisc_lock(sch));
+	_bstats_set(&sch->bstats, bstats.bytes, bstats.packets);
+	spin_unlock_bh(qdisc_lock(sch));
+
+	WRITE_ONCE(sch->qstats.qlen, qstats.qlen);
+	WRITE_ONCE(sch->qstats.backlog, qstats.backlog);
+	WRITE_ONCE(sch->qstats.drops, qstats.drops);
+	WRITE_ONCE(sch->qstats.requeues, qstats.requeues);
+	WRITE_ONCE(sch->qstats.overlimits, qstats.overlimits);
+
 	WRITE_ONCE(sch->q.qlen, qlen);
 
 	mqprio_qopt_reconstruct(dev, &opt);
@@ -661,45 +669,34 @@ static int mqprio_dump_class(struct Qdisc *sch, unsigned long cl,
 
 static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 				   struct gnet_dump *d)
-	__releases(d->lock)
-	__acquires(d->lock)
 {
 	if (cl >= TC_H_MIN_PRIORITY) {
 		struct net_device *dev = qdisc_dev(sch);
 		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
-		struct gnet_stats_queue qstats = {0};
+		struct gnet_stats_queue qstats = { 0 };
 		struct gnet_stats_basic_sync bstats;
+		struct gnet_stats _bstats = { 0 };
 		u32 qlen = 0;
 		int i;
 
-		gnet_stats_basic_sync_init(&bstats);
-		/* Drop lock here it will be reclaimed before touching
-		 * statistics this is required because the d->lock we
-		 * hold here is the look on dev_queue->qdisc_sleeping
-		 * also acquired below.
-		 */
-		if (d->lock)
-			spin_unlock_bh(d->lock);
-
+		rcu_read_lock();
 		for (i = tc.offset; i < tc.offset + tc.count; i++) {
-			struct netdev_queue *q = netdev_get_tx_queue(dev, i);
-			struct Qdisc *qdisc = rtnl_dereference(q->qdisc);
-
-			spin_lock_bh(qdisc_lock(qdisc));
+			const struct netdev_queue *q = netdev_get_tx_queue(dev, i);
+			const struct Qdisc *qdisc = rcu_dereference(q->qdisc);
 
-			gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
-					     &qdisc->bstats, false);
+			gnet_stats_add_basic(&_bstats, qdisc->cpu_bstats,
+					     &qdisc->bstats, true);
 			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 					     &qdisc->qstats);
-			qlen += qdisc_qlen(qdisc);
-
-			spin_unlock_bh(qdisc_lock(qdisc));
+			qlen += qdisc_qlen_lockless(qdisc);
 		}
+		rcu_read_unlock();
+		u64_stats_init(&bstats.syncp);
+		u64_stats_set(&bstats.bytes, _bstats.bytes);
+		u64_stats_set(&bstats.packets, _bstats.packets);
+
 		qlen = qlen + qstats.qlen;
 
-		/* Reclaim root sleeping lock before completing stats */
-		if (d->lock)
-			spin_lock_bh(d->lock);
 		if (gnet_stats_copy_basic(d, NULL, &bstats, false) < 0 ||
 		    gnet_stats_copy_queue(d, NULL, &qstats, qlen) < 0)
 			return -1;
-- 
2.53.0.1213.gd9a14994de-goog


