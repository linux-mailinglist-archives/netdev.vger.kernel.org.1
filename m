Return-Path: <netdev+bounces-301461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jgjmHrzTOmr1HwgAu9opvQ
	(envelope-from <netdev+bounces-301461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:43:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D36376B97EA
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:43:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=YXldRTr0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301461-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301461-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44B91303467B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69638D6A8;
	Tue, 23 Jun 2026 18:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B4388E68
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 18:43:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240184; cv=none; b=b58PJG9HnjGCCmVrx0jicNrOxqgmtzFkBaT1mD1YWEettKlKGRd9ye1wXL4nt8Y7l/TeJuiUNCn6fZDi4EdKYSBVNxcHUCdOsf/Z9l1ohGPLW6Q8/WDEKAXoQ1E2HGBRsMmGMAS600jPcVS3RQRkIKJ/5JkfNMQvZhcH6KgIOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240184; c=relaxed/simple;
	bh=LSOKCEmbln8Bsiarlr7DAKf9+v6TogPzxqdKe6GZP38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AwasWXrxNmt/fqRbB1j7zX1bdFuhcOUU1kSSu4UkZRKCKkRIuDb2QALq3LiARdbKMNitj9Q4EUjLp4nDm0nRhwEqF2IDRNrXVOFLzaDkXawrJuL/6qOZeTDuD9EpbDnhRgxdd69Qoace5SQg0589wLbtQRWdPV+tXW5NdWqRLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YXldRTr0; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91587626ae1so10395385a.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782240181; x=1782844981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGuAg1NPBYxczoa/cl+Ar/EX4r3MiGf0yGELuct39mo=;
        b=YXldRTr0QAARpn/4tAXDNUsErOa2ie7O3FINAkaT1kxVt/3bTHMz7Al/AUv3uoqOaI
         GCcTFVzIoReMae01kbQrqrEaBHmJH/oBVh9FddGlZRlVV+Ljc6S8aMWGzERHvpHZes+J
         JKT1Na1q1lZe8PVHX/pWIA5vkrpHodo4cLkYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240181; x=1782844981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGuAg1NPBYxczoa/cl+Ar/EX4r3MiGf0yGELuct39mo=;
        b=qa1xNZxi8FBXFhb7Ks8lzPwdC+DY0FirmmeNDE7Hye/+/RS/X4XSRdjysY3as4m64x
         zg1KNh60uvnriZSbY5J8xQi8HKoIcHkJEwwuux2BBnviJb8tvGSbjJfcbgDaPscF5Leh
         7PpgQfZdTSThNvxeU2En5L3Dd2cYT/to2OJUzQco6J8zB2pZFYdFaOi1yEgzofk3HmoL
         x/rwgiJpq0ypRnYGGjgxe/JPQew3i3PGax0wcUfJkAX6wAdyjgIyqjQv68B2p0Jx6CW9
         XMv6x+qBkFfV7cYY8jSEECPdgQyVd5a2/HHeiJqQNEEYvGsvP7LlJvqZQ6i1UPZpGDei
         IqIw==
X-Gm-Message-State: AOJu0YzYwt1Z7rjCwyVKnqh+01BSDFBtYOth5VYHIp0x0bdtl/4vx41a
	mmAoyzl9+hTRyKOXrSIRQ0ssetaljbbGULAyQTxzHpYImOnFWwUe/2IsfeuZP6VOlqQp19nlBpV
	Dg9Q=
X-Gm-Gg: AfdE7cn/RKsJ/MwYz8ACOLqHO6alOp8WVjZDcgIfYHjRbPPG5RNkMdm6svsF7p07uZ+
	97vh5KbLxNhMpFGm2Fp2UaCmMfw8hxAFgFZggGakoD2rc9SwQMJ86t76EnfKola4y3EBSNo/isg
	uz0xNsx8crBUehG7CsuBVW0ZxiLEdHEDWJSe+t1d01mWXXuM2fEkQbgvQcLukJ2sN/d42UAWmyJ
	xWab9mJaK9VySP2kaVYjCUvNySuTtNdFJMs5quldF46gwWrcygBvibtKBjMpO2/npVoG/64v59P
	jELb7cTdL4PHjLCitVY20X37iEVaKs9ctLxEAg2eIvDhxYw3Zr06UJs+hcaFGqWUvxbZwOSNYu+
	sBs9Bnh3DTp8Ed7aOwCAG+2nDL71nrWGweOh98lc+mtuPhFHu9JBdKSAnwlBQAiqNN89xEJFFPl
	6iknyfRw==
X-Received: by 2002:a05:620a:4147:b0:912:a170:265c with SMTP id af79cd13be357-927823ed80emr43125185a.20.1782240181509;
        Tue, 23 Jun 2026 11:43:01 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda62ef3sm354779285a.16.2026.06.23.11.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:43:00 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	andrew+netdev@lunn.ch,
	zdi-disclosures@trendmicro.com,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
Date: Tue, 23 Jun 2026 14:42:47 -0400
Message-Id: <20260623184247.508956-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-301461-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:victor@mojatatu.com,m:andrew+netdev@lunn.ch,m:zdi-disclosures@trendmicro.com,m:security@kernel.org,m:stable@vger.kernel.org,m:jhs@mojatatu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[mojatatu.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trendmicro.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D36376B97EA

The teql master->slaves singly linked list is not protected against multiple
writes. It can be mod'ed concurently from teql_master_xmit(), teql_dequeue(),
teql_init() and teql_destroy() without holding any list lock or RCU protection.

zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
after an RCU grace period, but teql_master_xmit() running on another
CPU can still hold a stale pointer into the list, resulting in a
slab-use-after-free:

BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net/sched/sch_teql.c:142
Read of size 8 at addr ffff88802923aa80 by task ip/10024

CPU: 1 UID: 0 PID: 10024 Comm: ip Not tainted 7.1.0-rc5 #1 PREEMPT(lazy)
Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack linux/lib/dump_stack.c:94
 dump_stack_lvl+0x100/0x190 linux/lib/dump_stack.c:120
 print_address_description linux/mm/kasan/report.c:378
 print_report+0x139/0x4ad linux/mm/kasan/report.c:482
 kasan_report+0xe4/0x1d0 linux/mm/kasan/report.c:595
 teql_destroy+0x3ca/0x440 linux/net/sched/sch_teql.c:142
 __qdisc_destroy+0x109/0x540 linux/net/sched/sch_generic.c:1100
 qdisc_put+0xad/0xf0 linux/net/sched/sch_generic.c:1128
 dev_shutdown+0x1cd/0x450 linux/net/sched/sch_generic.c:1493
 unregister_netdevice_many_notify+0xd30/0x24b0 linux/net/core/dev.c:12409
 rtnl_delete_link linux/net/core/rtnetlink.c:3552
 rtnl_dellink+0x476/0xb50 linux/net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x954/0xe80 linux/net/core/rtnetlink.c:6997
 netlink_rcv_skb+0x156/0x420 linux/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel linux/net/netlink/af_netlink.c:1318
 netlink_unicast+0x58d/0x860 linux/net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x89a/0xd80 linux/net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec linux/net/socket.c:787
 __sock_sendmsg linux/net/socket.c:802
 ____sys_sendmsg+0x9d9/0xb70 linux/net/socket.c:2698
 ___sys_sendmsg+0x194/0x1e0 linux/net/socket.c:2752
 __sys_sendmsg+0x171/0x220 linux/net/socket.c:2784
 do_syscall_x64 linux/arch/x86/entry/syscall_64.c:63
 do_syscall_64+0xff/0x890 linux/arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f linux/arch/x86/entry/entry_64.S:121
[..]

The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET senders
on a teql device against a thread that repeatedly adds/deletes the slave qdisc,
together with a SLUB spray that reclaims the freed slot; the resulting
UAF is controllable enough to be turned into a read/write primitive against the
freed qdisc object.

The fix?
Add a per-master slaves_lock spinlock that serializes all mutations of
master->slaves and the NEXT_SLAVE() links in teql_destroy() and
teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock around
those updates.
Pair this with READ_ONCE()/WRITE_ONCE() on the shared pointers and
rcu_read_lock_bh()/rcu_read_unlock_bh() around the list traversal in
teql_master_xmit() and teql_dequeue(), so that readers either observe a fully
linked list or are deferred until the in-flight mutation completes. The two
early-return paths in teql_master_xmit() are updated to release the RCU-bh
read-side critical section before returning, since leaving it held would disable
BH on that CPU for good.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 71 +++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index e7bbc9e5174d..dacdc46637df 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -53,6 +53,7 @@ struct teql_master {
 	struct Qdisc_ops qops;
 	struct net_device *dev;
 	struct Qdisc *slaves;
+	spinlock_t		slaves_lock;	/* serializes writes to ->slaves */
 	struct list_head master_list;
 	unsigned long	tx_bytes;
 	unsigned long	tx_packets;
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
@@ -132,34 +135,37 @@ teql_destroy(struct Qdisc *sch)
 	struct Qdisc *q, *prev;
 	struct teql_sched_data *dat = qdisc_priv(sch);
 	struct teql_master *master = dat->m;
+	struct netdev_queue *txq = NULL;
+	bool reset_master_queue = false;
 
 	if (!master)
 		return;
 
-	prev = master->slaves;
+	spin_lock_bh(&master->slaves_lock);
+	prev = READ_ONCE(master->slaves);
 	if (prev) {
 		do {
-			q = NEXT_SLAVE(prev);
+			q = READ_ONCE(NEXT_SLAVE(prev));
 			if (q == sch) {
-				NEXT_SLAVE(prev) = NEXT_SLAVE(q);
-				if (q == master->slaves) {
-					master->slaves = NEXT_SLAVE(q);
-					if (q == master->slaves) {
-						struct netdev_queue *txq;
-
+				WRITE_ONCE(NEXT_SLAVE(prev), READ_ONCE(NEXT_SLAVE(q)));
+				if (q == READ_ONCE(master->slaves)) {
+					WRITE_ONCE(master->slaves, READ_ONCE(NEXT_SLAVE(q)));
+					if (q == READ_ONCE(master->slaves)) {
 						txq = netdev_get_tx_queue(master->dev, 0);
-						master->slaves = NULL;
-
-						dev_reset_queue(master->dev,
-								txq, NULL);
+						WRITE_ONCE(master->slaves, NULL);
+						reset_master_queue = true;
 					}
 				}
 				skb_queue_purge(&dat->q);
 				break;
 			}
 
-		} while ((prev = q) != master->slaves);
+		} while ((prev = q) != READ_ONCE(master->slaves));
 	}
+	spin_unlock_bh(&master->slaves_lock);
+
+	if (reset_master_queue)
+		dev_reset_queue(master->dev, txq, NULL);
 }
 
 static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
@@ -184,7 +190,8 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	skb_queue_head_init(&q->q);
 
-	if (m->slaves) {
+	spin_lock_bh(&m->slaves_lock);
+	if (READ_ONCE(m->slaves)) {
 		if (m->dev->flags & IFF_UP) {
 			if ((m->dev->flags & IFF_POINTOPOINT &&
 			     !(dev->flags & IFF_POINTOPOINT)) ||
@@ -192,8 +199,10 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -204,14 +213,15 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			if (dev->mtu < m->dev->mtu)
 				m->dev->mtu = dev->mtu;
 		}
-		q->next = NEXT_SLAVE(m->slaves);
-		NEXT_SLAVE(m->slaves) = sch;
+		WRITE_ONCE(q->next, READ_ONCE(NEXT_SLAVE(m->slaves)));
+		rcu_assign_pointer(NEXT_SLAVE(m->slaves), sch);
 	} else {
-		q->next = sch;
-		m->slaves = sch;
+		WRITE_ONCE(q->next, sch);
+		rcu_assign_pointer(m->slaves, sch);
 		m->dev->mtu = dev->mtu;
 		m->dev->flags = (m->dev->flags&~FMASK)|(dev->flags&FMASK);
 	}
+	spin_unlock_bh(&m->slaves_lock);
 	return 0;
 }
 
@@ -285,7 +295,9 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
-	start = master->slaves;
+	rcu_read_lock_bh();
+
+	start = rcu_dereference_bh(master->slaves);
 
 restart:
 	nores = 0;
@@ -317,10 +329,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					master->slaves = NEXT_SLAVE(q);
+					spin_lock_bh(&master->slaves_lock);
+					rcu_assign_pointer(master->slaves,
+							   rcu_dereference_bh(NEXT_SLAVE(q)));
+					spin_unlock_bh(&master->slaves_lock);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
+					rcu_read_unlock_bh();
 					return NETDEV_TX_OK;
 				}
 				__netif_tx_unlock(slave_txq);
@@ -329,14 +345,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			master->slaves = NEXT_SLAVE(q);
+			spin_lock_bh(&master->slaves_lock);
+			rcu_assign_pointer(master->slaves,
+					   rcu_dereference_bh(NEXT_SLAVE(q)));
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
@@ -345,12 +365,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -444,6 +466,7 @@ static __init void teql_master_setup(struct net_device *dev)
 	struct teql_master *master = netdev_priv(dev);
 	struct Qdisc_ops *ops = &master->qops;
 
+	spin_lock_init(&master->slaves_lock);
 	master->dev	= dev;
 	ops->priv_size  = sizeof(struct teql_sched_data);
 
-- 
2.54.0


