Return-Path: <netdev+bounces-302386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k+QKMMkBQWqokAkAu9opvQ
	(envelope-from <netdev+bounces-302386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:13:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C92686D3A7A
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=te+G3WaV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302386-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD3F5300B3E1
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994734041C;
	Sun, 28 Jun 2026 11:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F0A299937
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 11:13:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782645191; cv=none; b=T4k+QUyZXTkxn5X1m/2JDr3zF3OuqTZSdLMXPUoScam7+1rrdu5gv3lnFtdXiXfrxmdDDfN88n+du36CTV1/2hLHp99KfP0c2HfRjTu1xsN0fCnV7/pgg8TepWl3dKuJMJghMxFkbgnr4o7Q32EXbi4KrPgKxOdxpBJSh9OTG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782645191; c=relaxed/simple;
	bh=/HuH1IYSueDw0bo6V8qM1IOyNOcXxeTGKHvADJLStBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFJUfRB1dvzFv3qqpYk4M05zc1CpiWo+bC4u/AEyqWR0TAGBLUlBXJpSBYh9kxK9hOsvi/1OAmGarA2Whwttqeot21GTzh/9wmnHWzYKk3BscgRFWKv5+uL4SVlGcNCyBCfe4UEiXj52A+zCzGvbsw0Z8dUwKVckecu/bD7LrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=te+G3WaV; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92cf01c0e95so81323585a.0
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782645187; x=1783249987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UgPg6DIBbOx8NWbHsuvFVLyMA+HywY5jsKyVEL2lB8=;
        b=te+G3WaVbugoeova3Bn0LZkjsM8Vnswvu1IlSdxTuVi4lyppAsJQHm3D4tEW3gGEhY
         VwOpS5FVhm8z4pkHH4NbSPJIMBrKWWUsv7eqgW7RDj2K2pn7MYD5f0lviygtuWCAdvq8
         /NK2M1+UDlJF7HDpQrbMTdRoK4gmwaI3haTPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782645187; x=1783249987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UgPg6DIBbOx8NWbHsuvFVLyMA+HywY5jsKyVEL2lB8=;
        b=H3rmd29ZRyH5JHuOqu+Rq1yceEEE6jhT5l9XYhOt8ZZi4RQ3nkdWnzOXQG8FQOS1Yz
         MKGvS8jFJjHsuRU4R3+mg/Bj//smSNgC/dwVu05MU2HviyBZJY7w5bhL1uafaisXXqj8
         W4/btClXWPzUG8hwKgYYkWsasa2rHnmKP5mPPT0ws9Z9N0Gbn2y8aZd4EtDihRN0ha2y
         Of/JGTU4goepctugjPgnpDUPC0vnI/6fMQ//eWHQb+vkben/hblPzlUrvMLmqccTE2BE
         dvNuDwaFGy2LqMSLYEARJaMf81EcwiCx07xgusFsR8iIufhYN9Jw10l5yuCZSF0lcKVg
         hSRw==
X-Gm-Message-State: AOJu0Yy7z31FLPm17UUwyfJYBgJOLEt/sVqMHvS+AwUpHsqVmupr/7cU
	ETimE6hkmVuxM+kuIPsMsvgRvUdCKw4kXaMYNvw8G0+L/m7FO4oE+N6DsFMDxhMO/J9o6q3iGOE
	6uSI=
X-Gm-Gg: AfdE7ckcZW3/+fqVNT0ddi3ZaOeyQZ+fwAI+pDjc1ua7QFrsKcpxGBOCsjBzjal/ld7
	5ApU++z1IpQz7NXhiYmIxEo9w64Lrs5gUHJVkZ0/pF6GShOooaKNcLz0LJcXkFJ4QzB7X0uciFs
	VHvdhz/S+s255D7XvwBgZvqSdu2EpnPb2viqNrTfhUPIajslqFbba2NqVOhTnshptnxdzEIDeJu
	BhOEh9ynl6UdrdohonpCFz9KqqwNdaOmzggRckGMVIOI1tCn6IZZpM6TsXLVD4IA+kFIXkx1Zp7
	pasjwmp2+Vu9R0pnR0JtmXevY8pjM1a/y/KtnUBxRm4yksaL8MPh9rJ5o1RXXRTT9CldCDe7cv5
	jR7tQG4v0PmSr3egfGwNlGxIa0Niifehd28U/ZMHy6wtcj5phAzk0gty93to54q06BRbxlgGgsC
	qYbRpVVA==
X-Received: by 2002:a05:620a:45ac:b0:915:cf88:1e26 with SMTP id af79cd13be357-92b3e676792mr974760985a.48.1782645187131;
        Sun, 28 Jun 2026 04:13:07 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a2530sm1736607385a.39.2026.06.28.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 04:13:05 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	zdi-disclosures@trendmicro.com,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
Date: Sun, 28 Jun 2026 07:12:29 -0400
Message-Id: <20260628111229.669751-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302386-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:victor@mojatatu.com,m:jiri@resnulli.us,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,m:jhs@mojatatu.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trendmicro.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C92686D3A7A

The teql master->slaves singly linked list is not protected against
multiple writes. It can be mod'ed concurently from teql_master_xmit(),
teql_dequeue(), teql_init() and teql_destroy() without holding any list
lock or RCU protection.

zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
after an RCU grace period, but teql_master_xmit() running on another
CPU can still hold a stale pointer into the list, resulting in a
slab-use-after-free:

BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
Read of size 8 at addr ffff888013fb0440 by task poc/332
Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-512)

The fix?
Add a per-master slaves_lock spinlock that serializes all mutations of
master->slaves and the NEXT_SLAVE() links in teql_destroy() and
teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
around those updates.
Annotate master->slaves and the per-slave ->next pointer with __rcu and
use the appropriate RCU accessors everywhere they are touched:
rcu_assign_pointer() on the writer side (under slaves_lock),
rcu_dereference_protected() for the writer-side loads (also under
slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() and
rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
which run under RTNL.
Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
traversal in teql_master_xmit(), so that readers either observe a fully
linked list or are deferred until the in-flight mutation completes. The two
early-return paths in teql_master_xmit() are updated to release the RCU-bh
read-side critical section before returning, since leaving it held would
disable BH on that CPU for good.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2->v3
1) Thanks to Simon's persistence:
 The writeback in teql_master_xmit() should not blindly write NEXT_SLAVE(q)
 into master->slaves. It should re-read master->slaves under slaves_lock and
 only update it if q is still the current head
2) Appease sashiko by mentioning teql_dequeue() on the commit and ensuring
 consistency on rcu_dereference_bh()/rcu_dereference_protected()
---

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index e7bbc9e5174d..78c74c1182d7 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -52,7 +52,8 @@
 struct teql_master {
 	struct Qdisc_ops qops;
 	struct net_device *dev;
-	struct Qdisc *slaves;
+	struct Qdisc __rcu	*slaves;
+	spinlock_t		slaves_lock; /* serializes writes to ->slaves */
 	struct list_head master_list;
 	unsigned long	tx_bytes;
 	unsigned long	tx_packets;
@@ -61,7 +62,7 @@ struct teql_master {
 };
 
 struct teql_sched_data {
-	struct Qdisc *next;
+	struct Qdisc __rcu	*next;
 	struct teql_master *m;
 	struct sk_buff_head q;
 };
@@ -101,7 +102,9 @@ teql_dequeue(struct Qdisc *sch)
 	if (skb == NULL) {
 		struct net_device *m = qdisc_dev(q);
 		if (m) {
-			dat->m->slaves = sch;
+			spin_lock_bh(&dat->m->slaves_lock);
+			rcu_assign_pointer(dat->m->slaves, sch);
+			spin_unlock_bh(&dat->m->slaves_lock);
 			netif_wake_queue(m);
 		}
 	} else {
@@ -132,34 +135,49 @@ teql_destroy(struct Qdisc *sch)
 	struct Qdisc *q, *prev;
 	struct teql_sched_data *dat = qdisc_priv(sch);
 	struct teql_master *master = dat->m;
+	struct netdev_queue *txq = NULL;
+	bool reset_master_queue = false;
 
 	if (!master)
 		return;
 
-	prev = master->slaves;
+	spin_lock_bh(&master->slaves_lock);
+	prev = rcu_dereference_protected(master->slaves,
+					 lockdep_is_held(&master->slaves_lock));
 	if (prev) {
 		do {
-			q = NEXT_SLAVE(prev);
-			if (q == sch) {
-				NEXT_SLAVE(prev) = NEXT_SLAVE(q);
-				if (q == master->slaves) {
-					master->slaves = NEXT_SLAVE(q);
-					if (q == master->slaves) {
-						struct netdev_queue *txq;
-
-						txq = netdev_get_tx_queue(master->dev, 0);
-						master->slaves = NULL;
-
-						dev_reset_queue(master->dev,
-								txq, NULL);
-					}
-				}
-				skb_queue_purge(&dat->q);
-				break;
+			struct Qdisc *head, *next;
+
+			q = rcu_dereference_protected(NEXT_SLAVE(prev),
+						      lockdep_is_held(&master->slaves_lock));
+			if (q != sch) {
+				prev = q;
+				continue;
 			}
 
-		} while ((prev = q) != master->slaves);
+			next = rcu_dereference_protected(NEXT_SLAVE(q),
+							 lockdep_is_held(&master->slaves_lock));
+			rcu_assign_pointer(NEXT_SLAVE(prev), next);
+
+			head = rcu_dereference_protected(master->slaves,
+							 lockdep_is_held(&master->slaves_lock));
+			if (q == head) {
+				rcu_assign_pointer(master->slaves, next);
+				if (q == next) {
+					txq = netdev_get_tx_queue(master->dev, 0);
+					rcu_assign_pointer(master->slaves, NULL);
+					reset_master_queue = true;
+				}
+			}
+			skb_queue_purge(&dat->q);
+			break;
+		} while (prev != rcu_dereference_protected(master->slaves,
+							   lockdep_is_held(&master->slaves_lock)));
 	}
+	spin_unlock_bh(&master->slaves_lock);
+
+	if (reset_master_queue)
+		dev_reset_queue(master->dev, txq, NULL);
 }
 
 static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
@@ -168,6 +186,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct net_device *dev = qdisc_dev(sch);
 	struct teql_master *m = (struct teql_master *)sch->ops;
 	struct teql_sched_data *q = qdisc_priv(sch);
+	struct Qdisc *first;
 
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
@@ -184,7 +203,9 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	skb_queue_head_init(&q->q);
 
-	if (m->slaves) {
+	spin_lock_bh(&m->slaves_lock);
+	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
+	if (first) {
 		if (m->dev->flags & IFF_UP) {
 			if ((m->dev->flags & IFF_POINTOPOINT &&
 			     !(dev->flags & IFF_POINTOPOINT)) ||
@@ -192,8 +213,10 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			     !(dev->flags & IFF_BROADCAST)) ||
 			    (m->dev->flags & IFF_MULTICAST &&
 			     !(dev->flags & IFF_MULTICAST)) ||
-			    dev->mtu < m->dev->mtu)
+			    dev->mtu < m->dev->mtu) {
+				spin_unlock_bh(&m->slaves_lock);
 				return -EINVAL;
+			}
 		} else {
 			if (!(dev->flags&IFF_POINTOPOINT))
 				m->dev->flags &= ~IFF_POINTOPOINT;
@@ -204,14 +227,17 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			if (dev->mtu < m->dev->mtu)
 				m->dev->mtu = dev->mtu;
 		}
-		q->next = NEXT_SLAVE(m->slaves);
-		NEXT_SLAVE(m->slaves) = sch;
+		rcu_assign_pointer(q->next,
+				   rcu_dereference_protected(NEXT_SLAVE(first),
+							     lockdep_is_held(&m->slaves_lock)));
+		rcu_assign_pointer(NEXT_SLAVE(first), sch);
 	} else {
-		q->next = sch;
-		m->slaves = sch;
+		rcu_assign_pointer(q->next, sch);
+		rcu_assign_pointer(m->slaves, sch);
 		m->dev->mtu = dev->mtu;
 		m->dev->flags = (m->dev->flags&~FMASK)|(dev->flags&FMASK);
 	}
+	spin_unlock_bh(&m->slaves_lock);
 	return 0;
 }
 
@@ -285,7 +311,9 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
-	start = master->slaves;
+	rcu_read_lock_bh();
+
+	start = rcu_dereference_bh(master->slaves);
 
 restart:
 	nores = 0;
@@ -317,10 +345,17 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					master->slaves = NEXT_SLAVE(q);
+					spin_lock_bh(&master->slaves_lock);
+					if (rcu_dereference_protected(master->slaves,
+								      lockdep_is_held(&master->slaves_lock)) == q)
+						rcu_assign_pointer(master->slaves,
+								   rcu_dereference_protected(NEXT_SLAVE(q),
+											     lockdep_is_held(&master->slaves_lock)));
+					spin_unlock_bh(&master->slaves_lock);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
+					rcu_read_unlock_bh();
 					return NETDEV_TX_OK;
 				}
 				__netif_tx_unlock(slave_txq);
@@ -329,14 +364,21 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			master->slaves = NEXT_SLAVE(q);
+			spin_lock_bh(&master->slaves_lock);
+			if (rcu_dereference_protected(master->slaves,
+						      lockdep_is_held(&master->slaves_lock)) == q)
+				rcu_assign_pointer(master->slaves,
+						   rcu_dereference_protected(NEXT_SLAVE(q),
+									     lockdep_is_held(&master->slaves_lock)));
+			spin_unlock_bh(&master->slaves_lock);
+			rcu_read_unlock_bh();
 			return NETDEV_TX_OK;
 		default:
 			nores = 1;
 			break;
 		}
 		__skb_pull(skb, skb_network_offset(skb));
-	} while ((q = NEXT_SLAVE(q)) != start);
+	} while ((q = rcu_dereference_bh(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
 		skb_res = skb;
@@ -345,29 +387,32 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (busy) {
 		netif_stop_queue(dev);
+		rcu_read_unlock_bh();
 		return NETDEV_TX_BUSY;
 	}
 	master->tx_errors++;
 
 drop:
 	master->tx_dropped++;
+	rcu_read_unlock_bh();
 	dev_kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
 
 static int teql_master_open(struct net_device *dev)
 {
-	struct Qdisc *q;
+	struct Qdisc *q, *first;
 	struct teql_master *m = netdev_priv(dev);
 	int mtu = 0xFFFE;
 	unsigned int flags = IFF_NOARP | IFF_MULTICAST;
 
-	if (m->slaves == NULL)
+	first = rtnl_dereference(m->slaves);
+	if (!first)
 		return -EUNATCH;
 
 	flags = FMASK;
 
-	q = m->slaves;
+	q = first;
 	do {
 		struct net_device *slave = qdisc_dev(q);
 
@@ -389,7 +434,7 @@ static int teql_master_open(struct net_device *dev)
 			flags &= ~IFF_BROADCAST;
 		if (!(slave->flags&IFF_MULTICAST))
 			flags &= ~IFF_MULTICAST;
-	} while ((q = NEXT_SLAVE(q)) != m->slaves);
+	} while ((q = rtnl_dereference(NEXT_SLAVE(q))) != first);
 
 	m->dev->mtu = mtu;
 	m->dev->flags = (m->dev->flags&~FMASK) | flags;
@@ -417,14 +462,15 @@ static void teql_master_stats64(struct net_device *dev,
 static int teql_master_mtu(struct net_device *dev, int new_mtu)
 {
 	struct teql_master *m = netdev_priv(dev);
-	struct Qdisc *q;
+	struct Qdisc *q, *first;
 
-	q = m->slaves;
+	first = rtnl_dereference(m->slaves);
+	q = first;
 	if (q) {
 		do {
 			if (new_mtu > qdisc_dev(q)->mtu)
 				return -EINVAL;
-		} while ((q = NEXT_SLAVE(q)) != m->slaves);
+		} while ((q = rtnl_dereference(NEXT_SLAVE(q))) != first);
 	}
 
 	WRITE_ONCE(dev->mtu, new_mtu);
@@ -444,6 +490,7 @@ static __init void teql_master_setup(struct net_device *dev)
 	struct teql_master *master = netdev_priv(dev);
 	struct Qdisc_ops *ops = &master->qops;
 
+	spin_lock_init(&master->slaves_lock);
 	master->dev	= dev;
 	ops->priv_size  = sizeof(struct teql_sched_data);
 

