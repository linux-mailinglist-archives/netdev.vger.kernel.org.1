Return-Path: <netdev+bounces-277147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LKaKI4f2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:52:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074FD3D007F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A2BD304741D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E58341ADF;
	Thu,  9 Apr 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUnIE/Dp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABD35B658
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771384; cv=none; b=QsSipvz/PjMmQz7P2J0uQF2QZId71X6qrBcI4QEu9Fj56a+RgFdJIMskMSS6Xf15nnqRw+fBPr08fEBmClwagOf6kDmzCkcRhxNxW4iBDIQHmYdUiFvNjmYvty4OaZVs4DoJxKOpe9E9Wt8Ko2tDEs76nHhrLGr99jj1RbEHm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771384; c=relaxed/simple;
	bh=Ibd+bVMznU6as2P0bUTruvhcgxOit5tNiOZ+THfXXyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ydtd5YO74WZXMpsbkwI8LW8lFN7CrDJDAED6oVsHEvrJy1A9UwFg5nI38MChneuZk6YaHYspZbHR6qUvYk1xBh1lJKwHU9Rt6L7cwaHmIP9UqIWoAD2pn9zlObNKMJnwr4B9t9+p3QXnjPstKKZO4Qh+E6qAa2jUxJziMUUncAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUnIE/Dp; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d4c2906fdfso153126885a.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771381; x=1776376181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSulQTQdJdirKxiu9TknoP5BKm/Ss1K5UPdLfI/RuVA=;
        b=hUnIE/DpWn/Sfn/xrZ5So07LfpBusnFm4pftJrBOtytOEnaWFiM1KpMuSOek7hIdOb
         Ob5Op4rtBZ8pGSqf0JwNfHiOmMuYVRolVEuyMqgILOcLvtiQaXTwp9rKkU/IGZS85VxO
         4VFqdTDQjwXFnoNQCNnbBSiB7eWQcAGAXDOU9IPImSWQvjQfw8ySH5avbTQXDgxfXT2z
         udZlxJwLITad5Jfca6v2Vt/QKqMMAmasWSBeg3urcjTgQ7wnVdZ/183h686CD+mugOgY
         dZTKs+loLZa8GzPC5kDv7Est7/m3Ggsz9chcxpA7IHqE21n5H6mObij+VohMotWf5xX8
         bThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771381; x=1776376181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSulQTQdJdirKxiu9TknoP5BKm/Ss1K5UPdLfI/RuVA=;
        b=UOuBYEk0x+ezT6Jhvt0kb3GASgyWlBdGdNPSc0Ub0vOVq5HpF2iHISEv978Yvyzxas
         eC8CQxCk4O1ERdSUGTvdOKGA8o7KIfVU75OFdHk7lp+j48eL6+noTkDJLOJacaQKQx8V
         1CcFjgIegNfMtPF79vgC6MjUAv7TIq6K98NgvnHJxyqJ05Vxzw1wt7vN3OX8y+W77NaA
         iE2Lf6w/uj0dQ8uls0zms/lKdoDDb1hEVWvFyhL8wRdT7ftMZFX1kwi4x2plpWl66BY/
         lkZBxvM9xsAqUl79IknGJ4YwCnC9UjMBH6Axc1XAhIkZt9jh/6WSifyZiRSMjNA1R8XO
         pJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+H1iucq3MigzL2RMigFhVipBuNoVa8oug/wqwVj8CfiYDNo4qKtMpGmZFdqP8Fjnt9zkxfww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EI2yaAjrXDb7erPohZLYe/iPrBUZ5hYeuYHN3CWrOUISshYg
	Y2eJGx9UEWrIgMWPi/mCHMU0bV+MKdt/AOhiolFv7WXWJFQ4tjWItF/LQtoKzi6OBEZDQwy2yaQ
	J1GFftWn+YDuCLA==
X-Received: from qkfw26.prod.google.com ([2002:ae9:e51a:0:b0:8cf:c124:567c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6cc2:b0:8d7:4f7c:8736 with SMTP id af79cd13be357-8ddcd603230mr92806085a.13.1775771381297;
 Thu, 09 Apr 2026 14:49:41 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:13 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-15-edumazet@google.com>
Subject: [PATCH v2 net-next 14/15] net/sched: mq: no longer acquire qdisc
 spinlocks in dump operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277147-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 074FD3D007F
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
 include/net/gen_stats.h   |  9 ++++-
 include/net/sch_generic.h |  5 +++
 net/core/gen_estimator.c  | 24 ++++++------
 net/core/gen_stats.c      | 17 ++++-----
 net/sched/sch_mq.c        | 34 ++++++++++-------
 net/sched/sch_mqprio.c    | 77 +++++++++++++++++++--------------------
 6 files changed, 89 insertions(+), 77 deletions(-)

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
index 2a07f45e6e915a03389ac54328ba500ca0cbe309..dccaf758894f47e1d2cf8aea95813c517980981c 100644
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
index a0133a7b9d3b09a0d2a6064234c8fdef60dbf955..290646e7574e582196357296c3fadb3a066ea577 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -143,30 +143,38 @@ EXPORT_SYMBOL_NS_GPL(mq_attach, "NET_SCHED_INTERNAL");
 void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct net_device *dev = qdisc_dev(sch);
-	struct Qdisc *qdisc;
+	struct gnet_stats_queue qstats = { 0 };
+	struct gnet_stats bstats = { 0 };
+	const struct Qdisc *qdisc;
+	unsigned int qlen = 0;
 	unsigned int ntx;
 
-	sch->q.qlen = 0;
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
-		sch->q.qlen += qdisc_qlen(qdisc);
-
-		spin_unlock_bh(qdisc_lock(qdisc));
+		qlen += qdisc_qlen_lockless(qdisc);
 	}
+	rcu_read_unlock();
+	u64_stats_set(&sch->bstats.bytes, bstats.bytes);
+	u64_stats_set(&sch->bstats.packets, bstats.packets);
+
+	WRITE_ONCE(sch->qstats.qlen, qstats.qlen);
+	WRITE_ONCE(sch->qstats.backlog, qstats.backlog);
+	WRITE_ONCE(sch->qstats.drops, qstats.drops);
+	WRITE_ONCE(sch->qstats.requeues, qstats.requeues);
+	WRITE_ONCE(sch->qstats.overlimits, qstats.overlimits);
+
+	WRITE_ONCE(sch->q.qlen, qlen);
 }
 EXPORT_SYMBOL_NS_GPL(mq_dump_common, "NET_SCHED_INTERNAL");
 
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index d35624e5869a4a6a12612886b2cd9cdac7b0b471..e2512b7bb2f4769190da918de52da0d8d4a915ca 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -554,32 +554,42 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
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
+	/* The following is probably racy on 32bit arches.
+	 * Acquiring bstats.syncp would require a spinlock.
+	 */
+	u64_stats_set(&sch->bstats.bytes, bstats.bytes);
+	u64_stats_set(&sch->bstats.packets, bstats.packets);
+
+	WRITE_ONCE(sch->qstats.qlen, qstats.qlen);
+	WRITE_ONCE(sch->qstats.backlog, qstats.backlog);
+	WRITE_ONCE(sch->qstats.drops, qstats.drops);
+	WRITE_ONCE(sch->qstats.requeues, qstats.requeues);
+	WRITE_ONCE(sch->qstats.overlimits, qstats.overlimits);
+
 	WRITE_ONCE(sch->q.qlen, qlen);
 
 	mqprio_qopt_reconstruct(dev, &opt);
@@ -661,45 +671,32 @@ static int mqprio_dump_class(struct Qdisc *sch, unsigned long cl,
 
 static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 				   struct gnet_dump *d)
-	__releases(d->lock)
-	__acquires(d->lock)
 {
 	if (cl >= TC_H_MIN_PRIORITY) {
-		int i;
-		__u32 qlen;
-		struct gnet_stats_queue qstats = {0};
-		struct gnet_stats_basic_sync bstats;
 		struct net_device *dev = qdisc_dev(sch);
 		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
-
-		gnet_stats_basic_sync_init(&bstats);
-		/* Drop lock here it will be reclaimed before touching
-		 * statistics this is required because the d->lock we
-		 * hold here is the look on dev_queue->qdisc_sleeping
-		 * also acquired below.
-		 */
-		if (d->lock)
-			spin_unlock_bh(d->lock);
+		struct gnet_stats_queue qstats = { 0 };
+		struct gnet_stats_basic_sync bstats;
+		struct gnet_stats _bstats = { 0 };
+		u32 qlen = 0;
+		int i;
 
 		for (i = tc.offset; i < tc.offset + tc.count; i++) {
 			struct netdev_queue *q = netdev_get_tx_queue(dev, i);
-			struct Qdisc *qdisc = rtnl_dereference(q->qdisc);
+			const struct Qdisc *qdisc = rtnl_dereference(q->qdisc);
 
-			spin_lock_bh(qdisc_lock(qdisc));
-
-			gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
-					     &qdisc->bstats, false);
+			gnet_stats_add_basic(&_bstats, qdisc->cpu_bstats,
+					     &qdisc->bstats, true);
 			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 					     &qdisc->qstats);
-			sch->q.qlen += qdisc_qlen(qdisc);
-
-			spin_unlock_bh(qdisc_lock(qdisc));
+			qlen += qdisc_qlen_lockless(qdisc);
 		}
-		qlen = qdisc_qlen(sch) + qstats.qlen;
+		u64_stats_init(&bstats.syncp);
+		u64_stats_set(&bstats.bytes, _bstats.bytes);
+		u64_stats_set(&bstats.packets, _bstats.packets);
+
+		qlen = qlen + qstats.qlen;
 
-		/* Reclaim root sleeping lock before completing stats */
-		if (d->lock)
-			spin_lock_bh(d->lock);
 		if (gnet_stats_copy_basic(d, NULL, &bstats, false) < 0 ||
 		    gnet_stats_copy_queue(d, NULL, &qstats, qlen) < 0)
 			return -1;
-- 
2.53.0.1213.gd9a14994de-goog


