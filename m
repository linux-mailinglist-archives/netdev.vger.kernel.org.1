Return-Path: <netdev+bounces-285531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP0bMTMQ/WmwXAAAu9opvQ
	(envelope-from <netdev+bounces-285531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:20:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75F4EFBA1
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF4E2300CBC7
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8DC389454;
	Thu,  7 May 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJ0XZ9m0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC3388371
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192404; cv=none; b=dv3kQMmMtxf2NXepR2/CrLz70EGNgwHQ8h3U2u6GXdaZhDaFgodFfJ6XziyS7QuWYweemtDVP9L1o1CO3uQ6N6wreSL75qQqQfw1MrPb/krwErRUzeTxsuoaWRQ1VCy6ItVyUvKShYGeMuDsjb2g+Q3b1qDHxeU0DfKiqz0W2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192404; c=relaxed/simple;
	bh=/YR3vuDtpjtlhVJl+QJZR6rMuQOvtGVeONiE2eAxYvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UUgwMw1mgdy8HyEYGcWyLQs83MZZAIwzqNSAk+PH8gCzsBiW1xh9/8r1SBmH6gHLQy8IxbW3gYPyyN3Ld5BSF3Y0jhmMDddRoccVUeOFvP2iwZi7n20t89ikCg56KlfMoMSKPffiNvQbxW83rgHcCH7tkeULx2gDKKtv3xiYFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJ0XZ9m0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7bd5c421975so2423427b3.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778192399; x=1778797199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgc+rECRk6r9633P3FdEBKCP+zSKjzSEVv6feaKe6TA=;
        b=vJ0XZ9m0SCXvS1X+x1hqPeKPxVK1UrPZ9iQH/M0Fo0tfrr5ysSlIQ+ynBQPUFNUKGV
         jQiMJMdmSlyviB0x92To5eYjxfSmvqhO5htarOKxMtS3kBnKYxMUMOWjHE9M/jkr/GkA
         YjVvfb6JMhx95CGfFNwAocH0tWcPpcq11XnZR+t9RdZyTAQw3Sv+FPEtbNZHAl+JeewC
         w9/w1TLvSK7LH7fzCKWGBHMXECejww1wx/os381AUCsuSlJ3GgyNLE2P6YC6svGRfN7v
         KoIHCGk67cA8DheXwJPaaKuCLwlgqw5hU0GhctSStGcSC+By4mMNfq5km2BXS3fA4Tj0
         iDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192399; x=1778797199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgc+rECRk6r9633P3FdEBKCP+zSKjzSEVv6feaKe6TA=;
        b=r+XYzwESdw5B4fZZfsNfDFngjhDZecULz07nELw0peExmfDymXTuut5dfvWRjTPQDR
         H+G5n1z5bIEXePNjDW/9FmI4b3vcdffee4dAkB40nI86si8MhbOOzFlYTG3fsk9WuYmF
         lUt15sIyOsALRkmOqaimh2DH1uIqTuHah1WQZ22vEK7H30vAzwMHWErZB1GnAp9zeb2R
         DggpQ0F+KyncWXcFiNkSCyjOzPm7t0uEbpsZQkrT815b3lLWyhn69ejK72oBS6Q1fOdF
         nZzBZ+7YbD9rR2kFuSNHNeuo/jtglxnDi5hQVqgRWj7A/IGrNDvHEZor6WpHncDSzdyt
         jflg==
X-Forwarded-Encrypted: i=1; AFNElJ/cJzOdz9zcQUtiX7ndbUsrbKE7QhdaYJ+ScjnRFN8ltbOViwukh19BKed71gmKtwg4BLWCbrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkm5jusRiJMwEdGdSxddeshL/pqO5UCcO9Qn0A4FfXkVNSfQg
	o28d2L+bYHpM+fcjZH7eT1irlU6SMBkvDteWbTd409Asbl3M+Mny8nZpyfo7FfnvyEK98TeOKT0
	MGXShJLko/kMF5Q==
X-Received: from ywbew2.prod.google.com ([2002:a05:690c:2f82:b0:7bf:75a:fbc2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:d95:b0:7ba:d5fb:b579 with SMTP id 00721157ae682-7bdf5ea84c5mr110419957b3.36.1778192398819;
 Thu, 07 May 2026 15:19:58 -0700 (PDT)
Date: Thu,  7 May 2026 22:19:46 +0000
In-Reply-To: <20260507221948.335726-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507221948.335726-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] net/sched: mq: no longer acquire qdisc spinlocks
 in dump operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CE75F4EFBA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285531-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Prepare mq_dump_common() for RTNL avoidance.

Use RCU instead of RTNL, and no longer acquire each children spinlock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h |  9 +++++++++
 net/sched/sch_mq.c        | 30 +++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 3070a717bb98386838f3e8149f34d52572fe208f..bfd1167ed575e5154c52a4491194e17e3998977c 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -952,6 +952,15 @@ static inline void _bstats_update(struct gnet_stats_basic_sync *bstats,
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
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index 4172ec24a43d1c2fe56789986a46da93eb522721..6bb1042e4595b50c6023d3ad81706ad7ab6fe0e5 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -143,30 +143,42 @@ EXPORT_SYMBOL_NS_GPL(mq_attach, "NET_SCHED_INTERNAL");
 void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct net_device *dev = qdisc_dev(sch);
+	struct gnet_stats_queue qstats = { 0 };
+	struct gnet_stats_basic_sync bstats;
+	const struct Qdisc *qdisc;
 	unsigned int qlen = 0;
-	struct Qdisc *qdisc;
 	unsigned int ntx;
 
-	gnet_stats_basic_sync_init(&sch->bstats);
-	memset(&sch->qstats, 0, sizeof(sch->qstats));
+	gnet_stats_basic_sync_init(&bstats);
 
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
+		gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
 				     &qdisc->bstats, false);
-		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
+		gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
 		qlen += qdisc_qlen_lockless(qdisc);
-
-		spin_unlock_bh(qdisc_lock(qdisc));
 	}
+	rcu_read_unlock();
+
+	spin_lock_bh(qdisc_lock(sch));
+	_bstats_set(&sch->bstats, u64_stats_read(&bstats.bytes),
+		    u64_stats_read(&bstats.packets));
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
-- 
2.54.0.563.g4f69b47b94-goog


