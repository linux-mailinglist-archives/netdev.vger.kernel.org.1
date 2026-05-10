Return-Path: <netdev+bounces-286265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAzBFP5MAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E21503499
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76196302A536
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AB536E493;
	Sun, 10 May 2026 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajJ/lqLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6851345CAB
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404509; cv=none; b=g7oweJzmIcMoLh3ycXvpxeigUFBp3rHgDradKqegthv1Y5J6lYyuA60tL2zI/7Uby7DBAASk6YbtW9e1ymufZLJQc8k8O9I+SdY6gkptLB184VNr2/qiIG4UUbgOR93UiF56S8kP/V1cVCwdcvZLaIrql72D/bOmdkngR3ZnayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404509; c=relaxed/simple;
	bh=MI5Ft7+mUcVSGTqpsibEiMgnbkD3CXxStaIGqbYORpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QulX2uVKGA6bjgWBf5fDikE+FQEUmL9FIiK+YsDKJWrYjpEZ+dAPunkF2e7bXDonkaqxG11wwcUh+yLIQ/8VqQlbKWLefUFYgTbReZZG0yn3hl0PrQsa7dzy8AOYUEPxc2s8bSHLHrRZfKJ8MBkjU2GnOwru1K0psT50jmW9kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajJ/lqLO; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8eacc2008b2so618483085a.3
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404506; x=1779009306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KNm2GfapjcibK2AW0XsN4T82/nPvSadKj1btrioGwv8=;
        b=ajJ/lqLOdZ37a6Pf/70O45p8v583jd3S1nrscQXFoi0pAQ4vICfGoVHpn+rFFbYZHP
         blrRm4yhG4YoWHsvLEwSS2eFehdXpo+B1J6gjDZSwSS1Y3s/42vqLxoomkV9CA5JF27Q
         KmL6BRJkT8MUkh60szX1RJlAPVwQIS3JGL650P+NdTBryguvlm02145SOMQ5voD9TqTw
         7thXSdhLRNlSQoCXnRidDFQ+ii94Rs4I9JNuVyCtzAUQo30w5sj7ahkLoHGc9k29jwZR
         oPTMhWw7zNoAR1qBL52UQ0jtGUXTMR+75RveMRc2f9lFJnJXI80RD0ynx1wuYqX1mUTz
         5EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404506; x=1779009306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNm2GfapjcibK2AW0XsN4T82/nPvSadKj1btrioGwv8=;
        b=eMhXmsQ+SnAKfx+MNmPvgS/05iqZJuwIXYl+iqAD9vgQlbmrMxPC9DzjhubVEGXE8X
         ZZuSbe0iB5XrWcL86UUf3QvXeyt5p3oxGtQqDTFW41O5vpDOxqkMGsClGA66SMr1KZCv
         xoRSU6RAKJCpPjET1kFZ5iYzWoJGdREFfdS9NuYoGnxneyINYq+yaaAqXQnI3x8aQ0tb
         +yV0g6YK7JluYJOYKpNK+h03SBpU8L2+2IqMP53GDFF9RrO6fx6RotoMdtsD6Px8JnKh
         K6YDwsS1XcUXes1mrpUOmqLk1D+EqUYSkplVEFDC01j5N7Wb922tRddA4TCAnP49h8F+
         QfXA==
X-Forwarded-Encrypted: i=1; AFNElJ9raP9vV96jiUwpnDusxYwfPKjcdmXRvs4jfOtzPkdkA45MfPda4jZcvvY0ous09sQiUfc5wis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7x8fgZqneE23KDzPPRWchC+DWodMsWRwDb2OYcD0NTjILtgqW
	+hQGzm922PWj/EkA0abm8STJbVz3g/4cOONGrLDEk/4kouZAXMwur3BEWi3KIFUoNWqiNLGQfYk
	iLjpOKlcCf83ihQ==
X-Received: from qkgl5.prod.google.com ([2002:ae9:f005:0:b0:8cb:d089:6a14])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:371f:b0:8ec:9b8f:496a with SMTP id af79cd13be357-90910539e30mr753703285a.51.1778404505593;
 Sun, 10 May 2026 02:15:05 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:53 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/8] net/sched: mq: no longer acquire qdisc
 spinlocks in dump operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E6E21503499
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286265-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Prepare mq_dump_common() for RTNL avoidance.

Use RCU instead of RTNL, and no longer acquire each children spinlock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h |  9 +++++++++
 net/sched/sch_mq.c        | 32 ++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 2ce84b2c9423ee3b945c0a537620b2568279e1ca..9e6ed92729d282642e17a72cc578f25e1d22e4d9 100644
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
index 4172ec24a43d1c2fe56789986a46da93eb522721..5a6b14557d85fdc6c2462ee9e926155438f597b8 100644
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
-				     &qdisc->bstats, false);
-		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
+		gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, true);
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


