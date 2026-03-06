Return-Path: <netdev+bounces-264751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA4uA9C7qmmiVwEAu9opvQ
	(envelope-from <netdev+bounces-264751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:34:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0CF21FB63
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FB493041799
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75702264C0;
	Fri,  6 Mar 2026 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvMdicNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECA1F7916
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796847; cv=none; b=tayEqaioC5Z+6HhQfc9qcMb1KNhxL3oDpgrXTRvEfNpew52/vJysSoJ3RpPi3wh+Vz5vDPKCp01StJA1SqWFUUE3QR5opgxoB7kx5IQzGo+B6VYEdaJtw5FFTtdFuwuIRzlS81UNujN3MM3htDgnP7/OoSWQGjkWK3WqXaktYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796847; c=relaxed/simple;
	bh=0capAzWAeqw/LRABhb2AMbjYe+KV8ujvpye/S3kjFVE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f0vCRYu7ZN0uYseLC2CidIFVlLqHdLigI9IVcXcePr3lYbFjo+4MZNNf8DQLB7K5qpcbO472HABvkFhZwzkBlVQqUWA6ByjFtHBDijD6QZ/FIbj+bzTRBuduoGnwe9LZgb9kaQTiy2RUl7f/e3VkmZMyx7yci8iSUYFoK0BWbVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvMdicNC; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5069ba5af5bso514881821cf.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 03:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772796845; x=1773401645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHVLYlMUm/Yi7WUUBmUmUNil+uywKm5OLA05N2fjOsQ=;
        b=XvMdicNC0EvTtR1gIWT+yyxdkEzEl468Dy8P2MgHN1p0jU/02s3+QnwCFW6DXTg0+Z
         RVvhABLXP8IsvZaU4RMdyC4YxQj4qzCD8DTWYHKmPJE0ixiukIHwQ3zVgmUjo6Hm1KAV
         EiH+nr6uiG6isAcd7eBj27mlyvatrX2MnrSUkPliF4QmfZAW/2t3t3yHlLjzf0loZpFG
         YfuUQsb4hcmuiyuhJdYsI4I2zsX0WQGNDCfQIUrTpGi65/29uDDQ9lF+dsiszVPf3woU
         KkazI/jrgHBIL2LKMgx+KQrsZaIqX3BiXK+8KEd7Q+Kt9iNDwcSDY+V8+F3pgvRwx1Va
         L9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796845; x=1773401645;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHVLYlMUm/Yi7WUUBmUmUNil+uywKm5OLA05N2fjOsQ=;
        b=U8wT519bbFLmH6yqyYB9R6yAIPqAnyN/1mnTUtBpJGd8Nra++69v90Gl4wTBGrcEOH
         iOAoA3o7oNulnLKFGiWSh2mb+h33Zr//5DMQ3nayNlLGJzv63Kz0FPVlyFn0txgZAGvL
         DmCoSKGXXdV2veMSnZov6w+OJrf4+MjYNsatPf/QaayZHReyxqkJyai94KGErcVxdHXl
         R9sZABOryPIhrg0Nr30aZrQHoJqeEx9kH0LJLEoB1cVaVAEli1QnyYP7g+PRzP1dCp+x
         VFzJOMrRZekZCkhNQjdbCXcASZ88gPMq/nhT91lUAGYadV7Ehs+IMf8DMvX0wzac9nVt
         IC2g==
X-Forwarded-Encrypted: i=1; AJvYcCU9D3geQj0F+umi6RgHQgG63ArFPw77wt7wF20pKyG5rzbBI53n3KinfQ02PQ68wEuDVc/Z4rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkLqxYewJHreQ/oYs/AvLtNvzcLw4GUxCxTf/8K/HhygY59Aj
	euBc0n1FaPaqdZKQ8/iGuY85bMdBknnOtEPksbkLdM9Op/mFr1TwP0Iguo6FdYuda3M/lTgTgVE
	a5tZEftUTZwyBbg==
X-Received: from qtpp20-n1.prod.google.com ([2002:a05:622a:9d4:10b0:508:f3c1:694])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:14cd:b0:4ff:9688:7dca with SMTP id d75a77b69052e-508f470587fmr19484951cf.8.1772796844838;
 Fri, 06 Mar 2026 03:34:04 -0800 (PST)
Date: Fri,  6 Mar 2026 11:34:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306113402.435055-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: do not reset queues in graft operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5D0CF21FB63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264751-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h |  4 ++--
 net/core/dev.c            |  2 +-
 net/core/link_watch.c     |  2 +-
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_generic.c   | 19 +++++++++++--------
 net/sched/sch_htb.c       |  4 ++--
 net/sched/sch_mq.c        |  2 +-
 net/sched/sch_mqprio.c    |  2 +-
 net/sched/sch_taprio.c    |  2 +-
 9 files changed, 21 insertions(+), 18 deletions(-)

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
index 556e0d8003161d3dfe68e484f6349714cf989c0c..55e17f9e5636f2d9e798889ff59b2f69c9c1709c 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1374,7 +1374,7 @@ static bool some_qdisc_is_busy(struct net_device *dev)
  *	This function returns only when all outstanding transmissions
  *	have completed, unless all devices are in dismantle phase.
  */
-void dev_deactivate_many(struct list_head *head)
+void dev_deactivate_many(struct list_head *head, bool reset_needed)
 {
 	bool sync_needed = false;
 	struct net_device *dev;
@@ -1393,11 +1393,14 @@ void dev_deactivate_many(struct list_head *head)
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
@@ -1412,12 +1415,12 @@ void dev_deactivate_many(struct list_head *head)
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
@@ -1473,7 +1476,7 @@ int dev_qdisc_change_tx_queue_len(struct net_device *dev)
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


