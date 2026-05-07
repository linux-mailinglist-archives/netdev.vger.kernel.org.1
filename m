Return-Path: <netdev+bounces-285532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNTXFGUQ/WmwXAAAu9opvQ
	(envelope-from <netdev+bounces-285532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:21:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D04EFBBD
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 324A1305A8A0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019438B12E;
	Thu,  7 May 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1B5ZAFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D33876C7
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192406; cv=none; b=aMhbbMP8oTileKh1M1uw/U7qKIdedr4DQPrtkn1zGdDFvE7fs2Q7M9Z0bx8YrB2fmvcenWm1sy6oec0Lq5zOcUDX/ZoTBA0HrvP27kPZuBxWWbQTkllLow4XqMXDuXF2aWluRSLh2FRNk51acXlpxapXGJfzIVxwUWfWqiP8PvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192406; c=relaxed/simple;
	bh=K6ASptgGMj5y6Cm2Fh6jCLZ482ONxk1H3khYcyUD/X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CcnDeq3LF/FfXePTzT2EkbScHBDD7zwsSsdGlpgaBehXoNPHxMRHmih/vzFbOgEOLoxiA068xItvwo5C01iC8RlDipw+a8wcDuHxspdRLICeCG5ks0EWjoFOXkVs5gHYMytm9916zSHy4hNurTVd11t2VsWCOk7Yq+oClz/VYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1B5ZAFb; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d8e8c47a3so32696021cf.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778192400; x=1778797200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NM6EScnofZJShhaM40UXCi7ciLCoadKWU/UpJJa0ce0=;
        b=d1B5ZAFbVyap4X2G1JLJVwx6HOdGHJ6D63HAbc63Zx3gSJl7ZQVmgQA9fG8ASgfTUe
         NQQBAaukAHSj4d0SmKd06vTvUlD0qIgruR9gZ6HbXDCIxg5SL+Fa9k0FV33IzrqLdlsJ
         9HfKArWX9Ea3eLEJBrKMA81b9yncMdI8jxV2mHArpl9/o3xpccioIyhG3e1zuCH2vrys
         loPLv7IhsXLmbs++vmUk1Wdfw6JAkkzH9NecRTwCc5bVkPV3slvG8Mx4pRtvwQKLajlB
         ZkpQDCcy+7D7cRtlpik3GWai6rzlCMIt0/ilx2O5wrAnzQ7NfgQX9ZcTARC8EkbvSZnl
         Z0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192400; x=1778797200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM6EScnofZJShhaM40UXCi7ciLCoadKWU/UpJJa0ce0=;
        b=HVtRwKgWeg/mW2ryoGcI/t4Zi7MWRsAFNMSlFh8vKrspBMbJDGZKNrgDEV/ucJodUD
         il2IQHnVrU5/2aHyuhqrRjbsgFubjQDHrM2ISMvDgcT3xyKpFwyy1Fkjvgz+T2FBBYZG
         TTA992X+hxvVmm2CGWbaNl5Mg/5wFaY2+DKFUr4XgI339FSKwLfgViqueKMup5H0z3/o
         NkIkUKkv/8E5OfHK7IQJqkUkgVyylasJQXBUwaZwotIW1BdXBfyfAGcAtiHyseUSD2Is
         kjYnYWujjiIJIoC2c4vhkQq+aYYrnsLyUZxeavz4hFWPW8M4cCiOPV6OjIFLzTuUgrTv
         sVTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JwwY5jdpGAncIkEKk4Cs/zor4w4iv3s6/YGU76objNxlhCvQ1Wr4CA+RHw13msECsl4BArRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fo97t1LKBOMnzYG38uGiy/m4RH27gINAfcxlRHmerklSG9AO
	qaY71QZuuQrivNQ3zTCkxBceE5eZh+oItsjY12QrfwhhKMhl6fOp3zqp6v62Q1J+MEqWEcTSO/E
	U8DjXI298WJeqwg==
X-Received: from qtwy8.prod.google.com ([2002:a05:622a:48:b0:50e:629c:1a31])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a93:b0:50f:135e:d68 with SMTP id d75a77b69052e-514621c6e3cmr141519891cf.58.1778192400202;
 Thu, 07 May 2026 15:20:00 -0700 (PDT)
Date: Thu,  7 May 2026 22:19:47 +0000
In-Reply-To: <20260507221948.335726-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507221948.335726-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] net/sched: mq_prio: no longer acquire qdisc
 spinlocks in mqprio_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A43D04EFBBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285532-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Prepare mqprio_dump() for RTNL avoidance.

Use RCU instead of RTNL, and no longer acquire each children spinlock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_mqprio.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 3b4881c389c535368687454ea268bec892ecb942..37756932d4917caa7c3b96dff1999e30623fe953 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -551,35 +551,46 @@ static int mqprio_dump_tc_entries(struct mqprio_sched *priv,
 
 static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
-	struct net_device *dev = qdisc_dev(sch);
-	struct mqprio_sched *priv = qdisc_priv(sch);
 	struct nlattr *nla = (struct nlattr *)skb_tail_pointer(skb);
+	struct mqprio_sched *priv = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct gnet_stats_queue qstats = { 0 };
+	struct gnet_stats_basic_sync bstats;
 	struct tc_mqprio_qopt opt = { 0 };
+	const struct Qdisc *qdisc;
 	unsigned int qlen = 0;
-	struct Qdisc *qdisc;
 	unsigned int ntx;
 
-	qlen = 0;
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
 
 	mqprio_qopt_reconstruct(dev, &opt);
-- 
2.54.0.563.g4f69b47b94-goog


