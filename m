Return-Path: <netdev+bounces-285533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHmxF2gQ/WmwXAAAu9opvQ
	(envelope-from <netdev+bounces-285533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F16664EFBC4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D088C305B5B0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB438E5FE;
	Thu,  7 May 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTJlOrk0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDF38AC93
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192406; cv=none; b=CjB6CzBMgtMZHruX05RrQOcxSg6/yE8fQ2Fb91p9LcjpPOwSFNJ9lVidcxuXUgisjj9I2xvkwkLOolhP3gEzlQGBNON8kKK9skN6KTszyXrCrB9UABGaaHlbY0IIiSXfoWg/xaeQL3WkT6G1nCuOSAsE+FlycY8fd8DcJP4IDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192406; c=relaxed/simple;
	bh=SVDpdpPO/wWkIG/9Y1oxy/FBvgGE+o/2cI/bfc9q1tM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/EmU9s1YA3X/hLcsNYbpZ8G2toRHebra9NsnPWfoLo4bc4PciXA17W+2zAXEw48I93PvWGV9BLYb1yLJOJVfm3XnBEqIp9/rYUzzsNxNsg4VRIl49escKI+dVuUtbEoHisI8VBf9qvYXO1b7kRjjQSzU4GZsWN5syUrSgSQ2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTJlOrk0; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8b7a1ea06bfso31691186d6.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778192402; x=1778797202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsX6PwaabWUu6HNeM5JhB6N/YAWOfl5EmJ+qeQzPIFg=;
        b=nTJlOrk0IDF/mVKkWnrk0h3Lrf4W6GX6vTPJbMW5N0QZ4CNOWcbGDLoy8TG0017mKv
         k8vc0NFe5lHsjk5aykGOXGlMN9Zu6wZ9VhZFYqwA8ToCJ8+H6ffUznGm/840xluzGIOa
         hzXGHGtR1Fl5UBc1uV+vU1fl+zmX6IZH6kRjpV0QYq7ISZErdgOLaeCuW/gf8EVfTikG
         xUbp3ifApgBQwQhr2kGxmd03PNtxnBgHnDpQcSKM49YaGD04YjwaJx+ZlVA4b+YEQKVL
         ayqUHL2iJqzFQAObO/k/ZQCkK3epG4kObioAwQzLewsI5YTVZvEDRjxzUZOR8T4kBa8u
         yoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192402; x=1778797202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsX6PwaabWUu6HNeM5JhB6N/YAWOfl5EmJ+qeQzPIFg=;
        b=InnAZ0ZPbH7gqLb7z/ylNbcqYBfGgJkQxkcUaC2R7CtoCG8bf4FEFluA/tbG5IEg6L
         m7JN5Cr+047DsFV8QRkafVpIY2chLWgFyhb1abcjbDXT13FMEdPmtCvQOub/CSZwOBc+
         8DJsOP/VN+SklvSi1vq+TbE2JHg5MMkEd3GEX/JZQ2hXedYba0nFayDckjVBoPxdKPtk
         M6AuPP3xtMNfy4AZXP3rnbSIGMeJR9F9Bc8aIxnWB4mFMrXBTEKPel0lE6x1p4aqcfta
         DKh7ejpNyP7cL5+gHD6f6mZ0hfPq8J5AbN6OHpvogVSMRmXRO3rASfsTns73IUecuZom
         gYcg==
X-Forwarded-Encrypted: i=1; AFNElJ82uJUWPEU57Qef/YZs1I8ukNbYjC1+nnfd1Q583akjbC0gy7ytcVNys/F3OgTdb1YiBeXKgpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYD+7jrleQs4blw8W2bhEh1NfPB+SILrl5BOydvVoOytB6xdqF
	660jGZCejjzJRqUiidoxzxI1bFtjdNWi76HTLRVr2Oi0AoA8vU9FcQMAjGVCG9R5xLAY7XPcYJH
	xeF6GejJpBqj/QA==
X-Received: from qtb21.prod.google.com ([2002:a05:622a:8d15:b0:50e:5c76:d605])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a47:0:b0:50f:ae44:515b with SMTP id d75a77b69052e-5148e95029amr973331cf.37.1778192401750;
 Thu, 07 May 2026 15:20:01 -0700 (PDT)
Date: Thu,  7 May 2026 22:19:48 +0000
In-Reply-To: <20260507221948.335726-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507221948.335726-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] net/sched: mq_prio: no longer acquire qdisc
 spinlocks in mqprio_dump_class_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F16664EFBC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285533-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Prepare mqprio_dump_class_stats() for RTNL avoidance.

Use RCU instead of RTNL, and no longer acquire each children spinlock.

As a bonus we no longer have to release/acquire d->lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_mqprio.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 37756932d4917caa7c3b96dff1999e30623fe953..6eb1db7b5d67548643b3e84f254cc1e034d1e6c7 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -672,9 +672,9 @@ static int mqprio_dump_class(struct Qdisc *sch, unsigned long cl,
 
 static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 				   struct gnet_dump *d)
-	__releases(d->lock)
-	__acquires(d->lock)
 {
+	const struct Qdisc *qdisc;
+
 	if (cl >= TC_H_MIN_PRIORITY) {
 		struct net_device *dev = qdisc_dev(sch);
 		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
@@ -684,44 +684,37 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 		int i;
 
 		gnet_stats_basic_sync_init(&bstats);
-		/* Drop lock here it will be reclaimed before touching
-		 * statistics this is required because the d->lock we
-		 * hold here is the look on dev_queue->qdisc_sleeping
-		 * also acquired below.
-		 */
-		if (d->lock)
-			spin_unlock_bh(d->lock);
 
+		rcu_read_lock();
 		for (i = tc.offset; i < tc.offset + tc.count; i++) {
 			struct netdev_queue *q = netdev_get_tx_queue(dev, i);
-			struct Qdisc *qdisc = rtnl_dereference(q->qdisc);
-
-			spin_lock_bh(qdisc_lock(qdisc));
 
+			qdisc = rcu_dereference(q->qdisc);
 			gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
 					     &qdisc->bstats, false);
 			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 					     &qdisc->qstats);
 			qlen += qdisc_qlen_lockless(qdisc);
-
-			spin_unlock_bh(qdisc_lock(qdisc));
 		}
+		rcu_read_unlock();
+
 		qlen = qlen + qstats.qlen;
 
-		/* Reclaim root sleeping lock before completing stats */
-		if (d->lock)
-			spin_lock_bh(d->lock);
 		if (gnet_stats_copy_basic(d, NULL, &bstats, false) < 0 ||
 		    gnet_stats_copy_queue(d, NULL, &qstats, qlen) < 0)
 			return -1;
 	} else {
 		struct netdev_queue *dev_queue = mqprio_queue_get(sch, cl);
+		int res = 0;
 
-		sch = rtnl_dereference(dev_queue->qdisc_sleeping);
-		if (gnet_stats_copy_basic(d, sch->cpu_bstats,
-					  &sch->bstats, true) < 0 ||
+		rcu_read_lock();
+		qdisc = rcu_dereference(dev_queue->qdisc_sleeping);
+		if (gnet_stats_copy_basic(d, qdisc->cpu_bstats,
+					  &qdisc->bstats, true) < 0 ||
 		    qdisc_qstats_copy(d, sch) < 0)
-			return -1;
+			res = -1;
+		rcu_read_unlock();
+		return res;
 	}
 	return 0;
 }
-- 
2.54.0.563.g4f69b47b94-goog


