Return-Path: <netdev+bounces-265151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGqEE8xTrGkOowEAu9opvQ
	(envelope-from <netdev+bounces-265151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 17:35:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5D22CB43
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0826C302F384
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4F3A63E3;
	Sat,  7 Mar 2026 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvvVgR9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2C3A4F55
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772901275; cv=none; b=oZm8Ig9Q70BGaGi/I77q1mC6lA3mnZUjbFB54WY+eA/Rzr3PmDHaPltOLruQUmERsuESbx0mzspN+ifWl6pOZyjskTQLksAef4w5gpU4AQ37ajzpjicPhLeFeCKVTRwan3gTUzCxmgQy4KW8MBHCgC/J+CLnn6C5mReVeynSSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772901275; c=relaxed/simple;
	bh=TanHhOYEtuKFFolNKHEneRF1CLOPB8FiyE4E1WsqtUs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xd7iPc1Wn0cxd9TQnbIfLMYDssKBiQ0o4ag8D9GrJFV6tBFdEQsrXrEVMDo2xKfb7FCppx5VwVv3C2+6Lnr7S0KH+cEjQqkASIGDnChjDiTqvGtieKcn5aZHlDRbjOE50nYg9WE26gSCQgSnilTkKbfG1Li07NR7vBsaiVh01jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UvvVgR9E; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506b4005ab7so885443151cf.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772901272; x=1773506072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B/L2NtnWYT3/D//o5Owk0t4WwkSxK6Eq0HsnAyfct5U=;
        b=UvvVgR9E8U3t8G43CYCW0TtbHW78wEIb51ajtSTRJUHEBc/ZMxXL7iye/+IGitsBdM
         IErG1pRCrstMxtkY8OfYuY2t23qJ5Ehb07/5t0uNEPnpn2LBC22ARUG4NWQlrQwhRvaJ
         pWotBCP1l3nK295h2mwegSkfjCU7x5SMAIJYNLaxYdGlM0zHH3qS9I14WySkMmp/7Gb/
         599dYRjkXQRICyn126J8eWJ8DJq8WThynV0lu+XMRtM72uj89qN0KxeBK78EHaZK8aa3
         y3uUxpPSrP9GMEfmQSpcVL2jp5qW0CosYJW/CHfQrOWyGGRRNDXVzE/utDe6hbKtopea
         27ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772901272; x=1773506072;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/L2NtnWYT3/D//o5Owk0t4WwkSxK6Eq0HsnAyfct5U=;
        b=YllsbHFUe79oV0HAtJPCvmfPQQvVNktxLs7kmBTAenCLf5QPgJNwecKVUHqKIb9bew
         FtB9uYSTmQwSdtkfRSe1CpJ+kjCu3BBPx9t+s/gZZzVmeLUkfNGJS42ur1XwrduB6swm
         pWW94KWhkPCZiUaHfQhdGNorB8ybFq9gTKWwyEFQeVWFk8AkIfN67vT42vJ+wE4Xo/Ov
         3V74WJ6bNnHgvHy14lqdn9Qif784FnFSoH43GWdnbtO2VudA++0U7jx0dtN+u19ifrKX
         PMZd+EOGhCORqvTIe1K5AS7WOfqH19ftZU7zp9i+pv30U/mjAXnpQC3a0JNcNnvff0DP
         N6Kg==
X-Gm-Message-State: AOJu0YznqNCcdwbZ/USuwpKY9IE3oMAnm3Pd2ZIMXedtRPNcE1SSJSIW
	yZtTcWWfy1dCxprM2A/fLnbfm+Hzf0ddf4H6rpgUBjRLNUm8IeqaawYzXPoWI2BV9fQjvJpPKQy
	HLTmSE2YFqMgFZw==
X-Received: from qtuu11-n2.prod.google.com ([2002:a05:622a:aa4b:20b0:501:1ae8:35f9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5fd0:0:b0:4ee:1e63:a4e0 with SMTP id d75a77b69052e-508f4976c0fmr80792051cf.74.1772901271483;
 Sat, 07 Mar 2026 08:34:31 -0800 (PST)
Date: Sat,  7 Mar 2026 16:34:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307163430.470644-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net/sched: do not reset queues in graft operations
From: Eric Dumazet <edumazet@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A4B5D22CB43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,mojatatu.com,gmail.com,resnulli.us,redhat.com,google.com,huawei.com];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Following typical script is extremely disruptive,
because each graft operation calls dev_deactivate()
which resets all the queues of the device.

QPARAM="limit 100000 flow_limit 1000 buckets 4096"
TXQS=64
for ETH in eth1
do
 tc qd del dev $ETH root 2>/dev/null
 tc qd add dev $ETH root handle 1: mq
 for i in `seq 1 $TXQS`
 do
   slot=$( printf %x $(( i )) )
   tc qd add dev $ETH parent 1:$slot fq $QPARAM
 done
done

One can add "ip link set dev $ETH down/up" to reduce the disruption time:

QPARAM="limit 100000 flow_limit 1000 buckets 4096"
TXQS=64
for ETH in eth1
do
 ip link set dev $ETH down
 tc qd del dev $ETH root 2>/dev/null
 tc qd add dev $ETH root handle 1: mq
 for i in `seq 1 $TXQS`
 do
   slot=$( printf %x $(( i )) )
   tc qd add dev $ETH parent 1:$slot fq $QPARAM
 done
 ip link set dev $ETH up
done

Or we can add a @reset_needed flag to dev_deactivate() and
dev_deactivate_many().

This flag is set to true at device dismantle or linkwatch_do_dev(),
and to false for graft operations.

In the future, we might only stop one queue instead of the whole
device, ie call dev_deactivate_queue() instead of dev_deactivate().

I think the problem (quadratic behavior) was added in commit
2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
for lockless qdisc") but this does not look serious enough to deserve
risky backports.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
---
v2: clarified the changelog
    added kdoc missing part (kernel build bots)

 include/net/sch_generic.h |  4 ++--
 net/core/dev.c            |  2 +-
 net/core/link_watch.c     |  2 +-
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_generic.c   | 20 ++++++++++++--------
 net/sched/sch_htb.c       |  4 ++--
 net/sched/sch_mq.c        |  2 +-
 net/sched/sch_mqprio.c    |  2 +-
 net/sched/sch_taprio.c    |  2 +-
 9 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c355300893a3921740cf6b919cc58de953cd610c..16beba40914ee5a9454f9eec2ad6e600543c89f2 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -710,8 +710,8 @@ void dev_qdisc_change_real_num_tx(struct net_device *dev,
 void dev_init_scheduler(struct net_device *dev);
 void dev_shutdown(struct net_device *dev);
 void dev_activate(struct net_device *dev);
-void dev_deactivate(struct net_device *dev);
-void dev_deactivate_many(struct list_head *head);
+void dev_deactivate(struct net_device *dev, bool reset_needed);
+void dev_deactivate_many(struct list_head *head, bool reset_needed);
 struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 			      struct Qdisc *qdisc);
 void qdisc_reset(struct Qdisc *qdisc);
diff --git a/net/core/dev.c b/net/core/dev.c
index 203dc36aaed55e706f5d978ec02c6bf48201e3d4..6fc9350f0be8756ae849d5b0ca9b222055d96ced 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1756,7 +1756,7 @@ static void __dev_close_many(struct list_head *head)
 		smp_mb__after_atomic(); /* Commit netif_running(). */
 	}
 
-	dev_deactivate_many(head);
+	dev_deactivate_many(head, true);
 
 	list_for_each_entry(dev, head, close_list) {
 		const struct net_device_ops *ops = dev->netdev_ops;
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 25c455c10a01cf535d6a7d2952d51434fe462690..ff2c1d4538efbc89cd49d8d8477542a6e7bacbad 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -181,7 +181,7 @@ static void linkwatch_do_dev(struct net_device *dev)
 		if (netif_carrier_ok(dev))
 			dev_activate(dev);
 		else
-			dev_deactivate(dev);
+			dev_deactivate(dev, true);
 
 		netif_state_change(dev);
 	}
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cc43e3f7574fae203989f5c28b4934f0720e64c2..c0bab092ea809955b3a5aaa08c169bca55cfaf7f 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1120,7 +1120,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		}
 
 		if (dev->flags & IFF_UP)
-			dev_deactivate(dev);
+			dev_deactivate(dev, false);
 
 		qdisc_offload_graft_root(dev, new, old, extack);
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 556e0d8003161d3dfe68e484f6349714cf989c0c..d4fe907c4ad5895b1dda5249c55e4c1e0168023e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1370,11 +1370,12 @@ static bool some_qdisc_is_busy(struct net_device *dev)
 /**
  * 	dev_deactivate_many - deactivate transmissions on several devices
  * 	@head: list of devices to deactivate
+ *	@reset_needed: qdisc should be reset if true.
  *
  *	This function returns only when all outstanding transmissions
  *	have completed, unless all devices are in dismantle phase.
  */
-void dev_deactivate_many(struct list_head *head)
+void dev_deactivate_many(struct list_head *head, bool reset_needed)
 {
 	bool sync_needed = false;
 	struct net_device *dev;
@@ -1393,11 +1394,14 @@ void dev_deactivate_many(struct list_head *head)
 	if (sync_needed)
 		synchronize_net();
 
-	list_for_each_entry(dev, head, close_list) {
-		netdev_for_each_tx_queue(dev, dev_reset_queue, NULL);
+	if (reset_needed) {
+		list_for_each_entry(dev, head, close_list) {
+			netdev_for_each_tx_queue(dev, dev_reset_queue, NULL);
 
-		if (dev_ingress_queue(dev))
-			dev_reset_queue(dev, dev_ingress_queue(dev), NULL);
+			if (dev_ingress_queue(dev))
+				dev_reset_queue(dev, dev_ingress_queue(dev),
+						NULL);
+		}
 	}
 
 	/* Wait for outstanding qdisc_run calls. */
@@ -1412,12 +1416,12 @@ void dev_deactivate_many(struct list_head *head)
 	}
 }
 
-void dev_deactivate(struct net_device *dev)
+void dev_deactivate(struct net_device *dev, bool reset_needed)
 {
 	LIST_HEAD(single);
 
 	list_add(&dev->close_list, &single);
-	dev_deactivate_many(&single);
+	dev_deactivate_many(&single, reset_needed);
 	list_del(&single);
 }
 EXPORT_SYMBOL(dev_deactivate);
@@ -1473,7 +1477,7 @@ int dev_qdisc_change_tx_queue_len(struct net_device *dev)
 	int ret = 0;
 
 	if (up)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		ret = qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index cf6cd4ccfa2029d9a45e35d6780520290690732d..eb12381795ce1bb0f3b8c5f502e16ad64c4408c8 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1387,7 +1387,7 @@ htb_graft_helper(struct netdev_queue *dev_queue, struct Qdisc *new_q)
 	struct Qdisc *old_q;
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 	old_q = dev_graft_qdisc(dev_queue, new_q);
 	if (new_q)
 		new_q->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
@@ -1421,7 +1421,7 @@ static void htb_offload_move_qdisc(struct Qdisc *sch, struct htb_class *cl_old,
 		struct Qdisc *qdisc;
 
 		if (dev->flags & IFF_UP)
-			dev_deactivate(dev);
+			dev_deactivate(dev, false);
 		qdisc = dev_graft_qdisc(queue_old, NULL);
 		WARN_ON(qdisc != cl_old->leaf.q);
 	}
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index 0ed199fa18f04a06197116b6ab64ff3647dbace9..a0133a7b9d3b09a0d2a6064234c8fdef60dbf955 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -201,7 +201,7 @@ static int mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
 	struct net_device *dev = qdisc_dev(sch);
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	*old = dev_graft_qdisc(dev_queue, new);
 	if (new)
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index b83276409416fabeccc441e5127211632ddcfedb..002add5ce9e0ab04a6260495d1bec02983c2a204 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -469,7 +469,7 @@ static int mqprio_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
 		return -EINVAL;
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	*old = dev_graft_qdisc(dev_queue, new);
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f721c03514f6008ecc59fe4c4ca4a082099dc125..8e375281195061da848fb2bfaf79cf125afccac0 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2184,7 +2184,7 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
 		return -EINVAL;
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	/* In offload mode, the child Qdisc is directly attached to the netdev
 	 * TX queue, and thus, we need to keep its refcount elevated in order
-- 
2.53.0.473.g4a7958ca14-goog


