Return-Path: <netdev+bounces-304224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yrk6JSSGRmpRXwsAu9opvQ
	(envelope-from <netdev+bounces-304224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:39:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF46F9849
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:39:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jvD+HDCJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304224-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304224-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14084300A8CE
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A59353A93;
	Thu,  2 Jul 2026 15:28:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA830E82D
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 15:28:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006129; cv=none; b=MAnVUTgUxqLOM6bFu9RUVNArdKBdirFgCSvQw9QoWktuQ43mi6X4faPxUmTHG7HfBhfRNRt4hljIMYbjH7y1yBhlyjhykmF6ZkT1Wht3kwZk1PNJ6wJMAsA8eVHpPyJJjy7WyieuuF+7vxyu24erB0PYMbz+LScHSxsLxwyZn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006129; c=relaxed/simple;
	bh=dYXESmoZyq6+W/erTtepBlbqYIfMAToFJFCgX3m7wrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tfp/tq5yGN0sYb0qak67My/swrZjOXZIAai/r4+sSz9wAU/EpDv2gYzLZEAkE8pGa0pXccjmTEXs9DzF/rfC/bW1LiR4loQVPvpVv7axoJMUsDBM57bH1GIwIbx2YwCidOLblYXB7AkIpm8zhlj3xf/1MzFEKj3gdE6rcEubQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvD+HDCJ; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so15030285ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783006127; x=1783610927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nX55HcCIgXeNDSs6UhoDWW9a/lSkFkcblQdBU0BYucI=;
        b=jvD+HDCJGczKv8ZM9jkgbyYuxM03yIhPpFsU4G2dvNJx1mvPTtnbm8rUj7lDsRW0H+
         0MyQTYYqQVljo9zK7QdhFSP3mX0ev1g7o6+BXXIIct0khnNc4GxWI/W/jzhfxkQvdumA
         6dMl68Q3WDFA/qftxnOsv4F48Ha+O3qX5TaEgIXfmAcGjtwHc+fZI2W0RuZCwRcUnPJU
         dbqseeEcXfwuJqH9fSHY7ej0vBXrd3+LL6KfsjEZxSsG38Y5wJNY/fCseq6MEM+itM+A
         2iY4+drpCBic0uP59lvm8j2ksvoVgvcDhaUljS2YvTVYEo5cGZJ2e9DS1Xp0K3SYxzWf
         MmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783006127; x=1783610927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nX55HcCIgXeNDSs6UhoDWW9a/lSkFkcblQdBU0BYucI=;
        b=Xs56YpMFYVIxMfDl/WPdgDru3EhSBpjDGaRrmcGjuPuOHGm7rIVDLoA4mP70MDJ+vM
         fZnWSsb0ZdmTaNnigDRCuk82upsRDKa+PuerGgbXKV1VsEXl7K3yq5fPoVdZTCDH37De
         bHEeErOLI81aAIrhPCKkwHqt6vjeJfBvCj5Ni4tc2qLsR+OI64NZ92A84f2L/dWNxkUi
         RU4RBxF+eOhQCXSIeO4py8qzrtudVXlzkV/jTXAK8ZtrUQ+WeM5rLv8DR/qflRYfnQ5j
         B6Hmv/oX0F5KSCucYF0+ovdtleHIfMfP0iu8ssHdBmbXTsJ8VZhoL5yrH5X53Bv2G63/
         NqTg==
X-Forwarded-Encrypted: i=1; AHgh+RrDQQO7k6kc/GZAaQ45wysaDv79goVUHJWXo3ho8P7ajw1G3dSNsurYMFQcZk7QFbVtGOmQxWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweU067cC0BJUQ3yg7Hv5FxceNoaBRhitNiOP1onOUxr32NDcqe
	SqLG6+QiXBmB5zRIYHfXCIwpT0A6+MMYzA2PoUHVns8j3LhlwwM3/P9o
X-Gm-Gg: AfdE7cmyi7f98GOTmTT7hqX8oGCH9P7PwZtqwGyyZIGH+CM1wr0D7JMA/oR6+FXf87n
	Vph/c2QHm1fMttuOsMOMrkKsLNI1xV7+VL/4oBlhvACVzWtVA9g1v4b1noqVsnb/Rivz8hRGZCs
	QKl9mUkxiHEOzdAEWFqjFLUbUh646KfzG+Wt/w5A/hdtCLE5wESWCH3E1ZOk4UKxjCN4IbqOHDG
	pMAN5q9nUK0+/X4lACkMiQ3WpPKKm9KBg73B1IS0yKsvIM2+Z/YKSvoLr/M1JkgCdwNxfxaJIPw
	uPze4ELteUFMlh2BnPdbsSu7Zya2hT2vemU6Ibb4m9hdq/ENWFdauVftW8AVrxjwPnZooKkU904
	3VUXBFtL2DPN7tKARXK8MAP6WAw4xWdAEAO+XYW2zLr4mKSsIwhntCLHQjIG9+kkGvNcuE9Zxft
	myudeLNSG5eWTxJGiCeJf8J+ugm5I=
X-Received: by 2002:a17:903:37d0:b0:2ca:660:b1d with SMTP id d9443c01a7336-2ca9114dfddmr56931265ad.11.1783006126637;
        Thu, 02 Jul 2026 08:28:46 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9d0393sm15561675ad.42.2026.07.02.08.28.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 08:28:45 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Jemmy Wong <jemmywong512@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/rps: consolidate RPS dispatch into netif_rps() helpers
Date: Thu,  2 Jul 2026 23:28:30 +0800
Message-ID: <20260702152830.39065-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304224-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jemmywong512@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,google.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:jemmywong512@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jemmywong512@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5AF46F9849

From: "Jemmy Wong" <jemmywong512@gmail.com>

The RPS steering logic in netif_rx_internal(), netif_receive_skb_internal()
and netif_receive_skb_list_internal() was open-coded three times, each with
its own #ifdef CONFIG_RPS block and manual rcu_read_lock()/unlock() pairs.

Factor it into two helpers, netif_rps() for the single-skb path and
netif_rps_list() for the list path, and switch the callers to
guard(rcu)/scoped_guard(rcu). A new internal NET_RX_UNHANDLED sentinel lets
a helper report "RPS did not take this skb" so the caller falls back to the
local enqueue / __netif_receive_skb() path; it never escapes to callers.

netif_rps_list() keeps the early static_branch_unlikely(&rps_needed) bail
out so the list is not needlessly walked and re-spliced when RPS is
compiled in but disabled.

No functional change intended.

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
---
 include/linux/netdevice.h |  5 ++-
 net/core/dev.c            | 94 +++++++++++++++++++--------------------
 2 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..c265b78082e3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -93,8 +93,9 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 void netdev_sw_irq_coalesce_default_on(struct net_device *dev);

 /* Backlog congestion levels */
-#define NET_RX_SUCCESS		0	/* keep 'em coming, baby */
-#define NET_RX_DROP		1	/* packet dropped */
+#define NET_RX_UNHANDLED	-1
+#define NET_RX_SUCCESS		0
+#define NET_RX_DROP		1

 #define MAX_NEST_DEV 8

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..259f8c8e5657 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5426,6 +5426,38 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	return NET_RX_DROP;
 }

+static inline int netif_rps(struct sk_buff *skb)
+{
+#ifdef CONFIG_RPS
+	if (static_branch_unlikely(&rps_needed)) {
+		struct rps_dev_flow voidflow, *rflow = &voidflow;
+		int cpu = get_rps_cpu(skb->dev, skb, &rflow);
+
+		if (cpu >= 0)
+			return enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
+	}
+#endif
+	return NET_RX_UNHANDLED;
+}
+
+static inline void netif_rps_list(struct list_head *head)
+{
+#ifdef CONFIG_RPS
+	struct sk_buff *skb, *next;
+	LIST_HEAD(undo_list);
+
+	if (!static_branch_unlikely(&rps_needed))
+		return;
+
+	list_for_each_entry_safe(skb, next, head, list) {
+		skb_list_del_init(skb);
+		if (netif_rps(skb) == NET_RX_UNHANDLED)
+			list_add_tail(&skb->list, &undo_list);
+	}
+	list_splice_init(&undo_list, head);
+#endif
+}
+
 static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
@@ -5695,33 +5727,20 @@ EXPORT_SYMBOL_GPL(do_xdp_generic);

 static int netif_rx_internal(struct sk_buff *skb)
 {
-	int ret;
+	int ret = NET_RX_UNHANDLED;
+	unsigned int qtail;

 	net_timestamp_check(READ_ONCE(net_hotdata.tstamp_prequeue), skb);

 	trace_netif_rx(skb);

-#ifdef CONFIG_RPS
-	if (static_branch_unlikely(&rps_needed)) {
-		struct rps_dev_flow voidflow, *rflow = &voidflow;
-		int cpu;
-
-		rcu_read_lock();
-
-		cpu = get_rps_cpu(skb->dev, skb, &rflow);
-		if (cpu < 0)
-			cpu = smp_processor_id();
+	scoped_guard(rcu)
+		ret = netif_rps(skb);
+	if (ret != NET_RX_UNHANDLED)
+		return ret;

-		ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
+	ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);

-		rcu_read_unlock();
-	} else
-#endif
-	{
-		unsigned int qtail;
-
-		ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);
-	}
 	return ret;
 }

@@ -6389,21 +6408,12 @@ static int netif_receive_skb_internal(struct sk_buff *skb)
 	if (skb_defer_rx_timestamp(skb))
 		return NET_RX_SUCCESS;

-	rcu_read_lock();
-#ifdef CONFIG_RPS
-	if (static_branch_unlikely(&rps_needed)) {
-		struct rps_dev_flow voidflow, *rflow = &voidflow;
-		int cpu = get_rps_cpu(skb->dev, skb, &rflow);
+	guard(rcu)();
+	ret = netif_rps(skb);
+	if (ret != NET_RX_UNHANDLED)
+		return ret;

-		if (cpu >= 0) {
-			ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
-			rcu_read_unlock();
-			return ret;
-		}
-	}
-#endif
 	ret = __netif_receive_skb(skb);
-	rcu_read_unlock();
 	return ret;
 }

@@ -6421,23 +6431,9 @@ void netif_receive_skb_list_internal(struct list_head *head)
 	}
 	list_splice_init(&sublist, head);

-	rcu_read_lock();
-#ifdef CONFIG_RPS
-	if (static_branch_unlikely(&rps_needed)) {
-		list_for_each_entry_safe(skb, next, head, list) {
-			struct rps_dev_flow voidflow, *rflow = &voidflow;
-			int cpu = get_rps_cpu(skb->dev, skb, &rflow);
-
-			if (cpu >= 0) {
-				/* Will be handled, remove from list */
-				skb_list_del_init(skb);
-				enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
-			}
-		}
-	}
-#endif
+	guard(rcu)();
+	netif_rps_list(head);
 	__netif_receive_skb_list(head);
-	rcu_read_unlock();
 }

 /**
--
2.25.1

