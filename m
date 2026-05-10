Return-Path: <netdev+bounces-286266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ORbGrtMAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4F4503472
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30A6C3006231
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A914D35B64B;
	Sun, 10 May 2026 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXes6/9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5D34F46D
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404510; cv=none; b=I/T7fVq+yggA5vbeOXxTJlURLKGkMHzQ7t+RqTKX3x3S+YOZZoTJ2QljWI2tEpwvAv/5dTLY6MCBFcmvmVAXzCH/JWoAQqLlf7HQtCqAzD0AYl/vkgvtrlUCmy0Tc5LqSmTC/yP8VsPvqJ785miuu0dlCTkfZupbX+O32yAlLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404510; c=relaxed/simple;
	bh=ZnA3OX5Xt/apyS28AXIW8yr/TiZkevmfw7z3GC755Eo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S9zc/cdRG87pfRia22ytjGZbKkpzBVSAy6XzJKOr6ZpyprQIh8s1yRvT2MDgvV1unM7r6usxVMSItIUXnjQcJa57QqL8OKbP52RCVKyZTmvzZmjmFG05evRBERZ/O0bC2pNl1JyU9NCJhVB9jeWu7yrvXnE0umV605nzoXDDg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXes6/9q; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d4c2906fdfso80497885a.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404507; x=1779009307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azugEo5okkeBZmSkhwS7WZylwD7Rsm5DuJws2ETZDV4=;
        b=OXes6/9q0gI75HGFGXCiOlmCxlH/I7xvXZ0E3OGehl4yt07d8TdhnTLVpYNrhd1rjh
         zKIa13ql2jMVaNEZd7mV1Mwfum7wHvl+nG6WUK/nW61QjiOP0/wSulBHsLvrXKgeNBdO
         cUc/hj8vqNG3JqlotMliGdF7F27KWzEqQlcLlfA+wIGkk/mGcsa1JwRRQMkuiQagfnrH
         MzKyV/mYmd+hCpThp3tnZ26UgEtlXvGLgH6fQv1j0q11DUhekjqL2XNKMtzy1Q5GHL8D
         FKaFj8nasgyIAZ3dDPajSGwRxQBE0pJjnbIiiq4+jQnZWnhRXbCLk8Zt3n3HBp8itW6j
         6jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404507; x=1779009307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azugEo5okkeBZmSkhwS7WZylwD7Rsm5DuJws2ETZDV4=;
        b=irjsX0nDwVkB9ArHLfo1FN80bu7uaId76QvqtWKTQEb1Adb5ywtBwN46xZljud5ahs
         Z6QyhCO6Wy2cjiz+0mIWDXThug6oSso+VpOElzigH7PB+mNMXtsDKRT0RaPuHX6USX+2
         aCsMYIFWETa4Blns6eaCFRKnFXt9fNWdac8g3C1rN0azZlS+kBffh5OCc1HZrw2YDM8D
         nNM3rAk3B/us8rRs6kfZRMTtSL6By98ldF/tNew57wK8qC5uHV5zYtAtnxHxYmAcfPHJ
         S+Mo5flZiR1nM3TpQkDCm5iK52nSzLWBvRMNqdGVjNhn8D/ETpkg0sjsa2vRrKGX4VTx
         EJLA==
X-Forwarded-Encrypted: i=1; AFNElJ8voJw/nndC3nscbqokvHFCQX3KDfgJGe0lVbdSDU1GJWhizJiR7xeI/o8yhKUC/hTfrcYjcVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAQOgdEZqsFvFrDLa4/Ax9ubhI56X2Dot+GYi6s0u3Lgm+ooe
	38ps+E7GMz1kEWWYIKw4U7ztnopDrTCb1Nu78lPNvrmPOB5fj8Yau0fryAoP7D+ZgMW5zgp4BeM
	978JXmV+T/C5Tng==
X-Received: from qktt29.prod.google.com ([2002:a05:620a:5d:b0:8d4:6c04:dbf7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:29c1:b0:8f0:f1a5:680c with SMTP id af79cd13be357-904d60f5805mr2968151985a.29.1778404507046;
 Sun, 10 May 2026 02:15:07 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:54 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-8-edumazet@google.com>
Subject: [PATCH v2 net-next 7/8] net/sched: mq_prio: no longer acquire qdisc
 spinlocks in mqprio_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6A4F4503472
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286266-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Prepare mqprio_dump() for RTNL avoidance.

Use RCU instead of RTNL, and no longer acquire each children spinlock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_mqprio.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 3b4881c389c535368687454ea268bec892ecb942..f9dab76f40ebbd1363121198bbc3af2bd951c101 100644
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
 
 	mqprio_qopt_reconstruct(dev, &opt);
-- 
2.54.0.563.g4f69b47b94-goog


