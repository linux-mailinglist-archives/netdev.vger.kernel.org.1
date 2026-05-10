Return-Path: <netdev+bounces-286267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LUeMCFNAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:17:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBA5034A0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B54E303133D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280032EF67A;
	Sun, 10 May 2026 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqdiygOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA3257452
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404512; cv=none; b=XaqNTNflrUROT+uo1K8c4CSi8xjuIAVLYd1mSlYFEjX+m4K3Z39cjCZSyRqvi96h60yrs1bQRYhtqmn0TCH44HrOFsxFEui8lgYvxU2hFqI7i5AMamEoO8m6ib39QUvp3sArIr/0Bmr1UNoNdUmQcU29NI3sbopXdBolx4mNmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404512; c=relaxed/simple;
	bh=CZ9mdwdyki1gXOqz/AtcCt0n9MpV0VdLvWWeci33sw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YWf8ZBAIWmNzAxdqxeOExo0VJCI1Hb6inpSPm3LE1lhZZetc6ZqoxpZNGRQnE3MbLU5af+GSC6xDgalFVJuUlM/QZ7AWOLdnYOOnx7lpNR1Yz7sYPAEI4sloWubrjLeXK3cMhR6SrXLflggaNQyq7btBtOb/iYDQQEw6Lw3ceZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqdiygOv; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8c3bdb60dadso6898726d6.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404509; x=1779009309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyHwiDQAXMvnGAgVyPGUXuSHBkX2buiUPnJCpUUbxgk=;
        b=JqdiygOvikQdvj8RzEzeAK9+vLrxVfbYq6CEEWi6B0LiL/DUGTqU9MSa6BBj+Lg43R
         E+s1iLrkVeWgnX+weYvYlOJaxMs+dEXJlXu6LR0nPgFlTEVvP+W6JnZTBGF3Z+9uQlj3
         V0kY6V2h93xngeDKjHDNOxgfpoYugMb1M8RwwZFozjNhGsp4yRL3Zh3HDxfHvoTusKPS
         7MIRMODUWE9oIPcvTgtYoH89BUB+zowKeozvAMqZld51dV7C/VOkVOIk2tJxPaXEFr+F
         lOGT1k7BHOc9Rvfge/ClTuG+URfUGLNzhZ1qk8OXKORC6TFZwXNKmv1KOyWqxzKIlnlq
         9Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404509; x=1779009309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyHwiDQAXMvnGAgVyPGUXuSHBkX2buiUPnJCpUUbxgk=;
        b=O3hydrStGeJNccSsiKaYtGXjpFNssm/XEpYlbXg+BXQFCVwFTGXZOMHkj3qRhIFlYT
         rggxQNwvPn+HzvFLsfVGYea5LDGsROcVJ5DRFujXmQ5PQeBts/eTXSHD+MRJLd7z8ybZ
         WEtSNTlJUGBlHdOc7ZDhWI4wBE7FOFQ7POKXnIE9C73OTPQvww1A1A1GW+a0A64RlQrg
         n8E961ozbR9cWLeUskWJgpoCRQTokGDaAFVfggRqkbgIzIb5kaPz2zlwEx3ux7JKe7T2
         6kEGQzUgKMVuifbcaDDeOx6/leeMiT21Yo61V75fSapsGdYDsnuil+NRgyulVDOd11x1
         iMUg==
X-Forwarded-Encrypted: i=1; AFNElJ+lHjbW8Vietm5abbvSVPTCRaWWldGUMYOr/1M5O+8/vQkEdswr6IjFtRcCDOtNW6yVrEwGSTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVBzJnhR/Yf/jMo1z0BH8fs4SA8uYA7MVvXVtJu/3eijYpJsnk
	/mxJLhKojHQK2sxCrbs2Ll0pGoN1ZpeD6S0lcg71ZjoAS3+tkEUZ8ltodiLfJCAoFwWgcY5gljL
	reN8ZRwh/+7yI8A==
X-Received: from qvbny2.prod.google.com ([2002:a05:6214:3982:b0:8b4:9c73:e1bb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ce4:0:b0:89c:a2ad:33a0 with SMTP id 6a1803df08f44-8bc46cbee8amr331258586d6.45.1778404508670;
 Sun, 10 May 2026 02:15:08 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:55 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-9-edumazet@google.com>
Subject: [PATCH v2 net-next 8/8] net/sched: mq_prio: no longer acquire qdisc
 spinlocks in mqprio_dump_class_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2DBBA5034A0
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286267-lists,netdev=lfdr.de];
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
X-Rspamd-Action: no action

Prepare mqprio_dump_class_stats() for RTNL avoidance.

Use RCU instead of RTNL, and no longer acquire each children spinlock.

As a bonus we no longer have to release/acquire d->lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_mqprio.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index f9dab76f40ebbd1363121198bbc3af2bd951c101..ae991fc25b43f24efb3b53fce6f6b53718a9b774 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -672,9 +672,11 @@ static int mqprio_dump_class(struct Qdisc *sch, unsigned long cl,
 
 static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 				   struct gnet_dump *d)
-	__releases(d->lock)
-	__acquires(d->lock)
 {
+	const struct Qdisc *qdisc;
+	int res = 0;
+
+	rcu_read_lock();
 	if (cl >= TC_H_MIN_PRIORITY) {
 		struct net_device *dev = qdisc_dev(sch);
 		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
@@ -684,46 +686,34 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 		int i;
 
 		gnet_stats_basic_sync_init(&bstats);
-		/* Drop lock here it will be reclaimed before touching
-		 * statistics this is required because the d->lock we
-		 * hold here is the look on dev_queue->qdisc_sleeping
-		 * also acquired below.
-		 */
-		if (d->lock)
-			spin_unlock_bh(d->lock);
 
 		for (i = tc.offset; i < tc.offset + tc.count; i++) {
 			struct netdev_queue *q = netdev_get_tx_queue(dev, i);
-			struct Qdisc *qdisc = rtnl_dereference(q->qdisc);
-
-			spin_lock_bh(qdisc_lock(qdisc));
 
+			qdisc = rcu_dereference(q->qdisc);
 			gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
-					     &qdisc->bstats, false);
+					     &qdisc->bstats, true);
 			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 					     &qdisc->qstats);
 			qlen += qdisc_qlen_lockless(qdisc);
-
-			spin_unlock_bh(qdisc_lock(qdisc));
 		}
+
 		qlen = qlen + qstats.qlen;
 
-		/* Reclaim root sleeping lock before completing stats */
-		if (d->lock)
-			spin_lock_bh(d->lock);
 		if (gnet_stats_copy_basic(d, NULL, &bstats, false) < 0 ||
 		    gnet_stats_copy_queue(d, NULL, &qstats, qlen) < 0)
-			return -1;
+			res = -1;
 	} else {
 		struct netdev_queue *dev_queue = mqprio_queue_get(sch, cl);
 
-		sch = rtnl_dereference(dev_queue->qdisc_sleeping);
-		if (gnet_stats_copy_basic(d, sch->cpu_bstats,
-					  &sch->bstats, true) < 0 ||
-		    qdisc_qstats_copy(d, sch) < 0)
-			return -1;
+		qdisc = rcu_dereference(dev_queue->qdisc_sleeping);
+		if (gnet_stats_copy_basic(d, qdisc->cpu_bstats,
+					  &qdisc->bstats, true) < 0 ||
+		    qdisc_qstats_copy(d, qdisc) < 0)
+			res = -1;
 	}
-	return 0;
+	rcu_read_unlock();
+	return res;
 }
 
 static void mqprio_walk(struct Qdisc *sch, struct qdisc_walker *arg)
-- 
2.54.0.563.g4f69b47b94-goog


