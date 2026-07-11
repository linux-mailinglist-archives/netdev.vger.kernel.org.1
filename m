Return-Path: <netdev+bounces-306843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FRryKLMyUmo8NAMAu9opvQ
	(envelope-from <netdev+bounces-306843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:10:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707A741779
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:10:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qENWZoxT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306843-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306843-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C46300EAB3
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA23A9DA9;
	Sat, 11 Jul 2026 12:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC538AC83
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 12:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771819; cv=none; b=eX8MV6GDPEPxp/DV6znLfI/13ezpXsIiv4H5mgvYSpNUL6xHc7/5aFDSjva07Cci+7FT8xyuDWVTa2BcghWf+78Sq1UO2YyDBK7Fm+wRF/eusbuUYMOurfIul4tSctYfn+5XE7lNECbmJzNueO+QyiVAJaSs/SD2Q9KNgNeW15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771819; c=relaxed/simple;
	bh=S8b/4BsFSE8KlFURh/bHVzTH/0yIH3iw8lTmdGMTBMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dag3QGs71IetzNe1Ka0bNm0VZVNd2uIKEf+l2cbdDxuYS2gvKvPfCi8uG/crnyqe/Abb5TloGiejuvKd4Imrm4o/6Obea7JU/l2SX4N3/99wM39ZrX0etbOI3uqqCXTG5iuuOIImOcczGPe9ISnxJIKfLgJFCd/bhx0nOZvjXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qENWZoxT; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so28742895ad.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783771818; x=1784376618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwcep/f1okQ2Nd2drpl9IskC13P+jKJfO97boATnYJE=;
        b=qENWZoxTladv0WZ0OjR6jzpKCKID5dHu7wwdWd91MXzFplAsDtkVCRQC0hhqhs4U/L
         4K3TUNWr0F/tbSr749nVKhUQFc8O3IHL0Z1hPlzvumM9fXxUE+dubGkf2gMUZHd6PMvv
         DF8bm/mAwpK3+cdxLVRnhm+vltBnlSwjTWKdHEExJGoNu1iGpP9cGWB6/d4KUROOEX/D
         FInR+PK9RcEcpugGr9wynt8xt7dOH/1LSOw/08+NXz/UGkMMPZztNag9DqFhTCfKvPt+
         BuVz4bqOxzl6Pqu9T9DV1NYpIr3y66BKvX4X9UJ58Vq1PNzz/FXrjnksjI6n6eH4kgcH
         FLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783771818; x=1784376618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwcep/f1okQ2Nd2drpl9IskC13P+jKJfO97boATnYJE=;
        b=Qx9bLqOHNBPF3VBTobZXd6lvak9oNolugXkEHeV7MPo7suG4o1cUpdksMz6VW6xxEu
         GG0CnzvmYATRhEcW6vncWfZQ7jyyFS3h2k9AO9YABHEdsCtxozVxQvtMeDD2zYWrgm0f
         FZNM+eMfOAz2NrdW/Ee45YPP7zv9S+q5eop9FBhm1XCxpog7bbqO6078szr7fvde2dwJ
         +hk4xFD5QawBl05lI0vHCIZj2DOcyDSstvVmiVMGtIDGbWtqU216Rdl1oDoY+lwmGDBi
         e+PYYHO9LijLZkLhCS3gVm86zu5sP4eR+xs1IgQ4r6KQ8oHcbAlxo2Gq3sEUEAtCKro7
         Kt6g==
X-Gm-Message-State: AOJu0Yz8YHjHuA2nAMeLpAD6W5zHzpwsur6UUVazAvwsFxOCegaIkKjz
	sp7acMANkspnbhVYR5yZK9G2eg2lV7Yqu5uG1N00xMNY189ag75jh/LM
X-Gm-Gg: AfdE7cmiH3l6FMbOIFNgueIocspv/epiSTH1JW7WaZGUylPp0DvQXTqkCSRB+bsGQfa
	pM/w4D6Ypio+bFVxJACXcd+eOtw+lslQXzPsJFJg6u6DD6V0BsMa6B1BEr9Dd9rsQdY6djwWA7i
	u59PwNisAOgNxCv++17LNw7+oLXdXrhlTQ4VfuLJzZDt6JFz2c0mXM8QuGwBiEmVymU8ahpxiGu
	hghTDPygS/T1n6TzoP6T+fm+H0OyiFup4JHel6BB3IwS+htReQ7wG9IwQFnriap3qAPHn4twZbQ
	yWO7wtXf4tRJRy0AzWj751pab3Uj3RcfCleFD9+88iwYniAY5UPjCD3amdBxnGlIJILJaVLOGf8
	r/RfpOmU6jp0bYjSVF9zE/Ri6v364LIPBA/hZmizNBPcNZ40CJBhTpoi++IETHUByiSuIj9xSGO
	WfTIq5IQrPXApaEf1N6ZkVp29AstY=
X-Received: by 2002:a17:903:1b6b:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ce9e79f42bmr29829555ad.5.1783771817755;
        Sat, 11 Jul 2026 05:10:17 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bc42sm72537085ad.63.2026.07.11.05.10.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 05:10:17 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net/rps: consolidate RPS dispatch into helpers
Date: Sat, 11 Jul 2026 20:10:08 +0800
Message-ID: <20260711121009.76842-1-jemmywong512@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306843-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jemmywong512@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jemmywong512@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3707A741779

The RPS steering logic in netif_rx_internal(), netif_receive_skb_internal()
and netif_receive_skb_list_internal() was open-coded three times, each with
its own #ifdef CONFIG_RPS block and manual rcu_read_lock()/unlock() pairs.

Factor it into two helpers, netif_rps() for the single-skb path and
netif_rps_list() for the list path, sharing a common __netif_rps() inner
helper that runs the get_rps_cpu()/enqueue_to_backlog() step under RCU.

Both wrappers keep the early static_branch_unlikely(&rps_needed) check
and only enter an RCU read-side critical section when RPS is actually
enabled at runtime, so no extra rcu_read_lock()/unlock() is executed on
the hot netif_rx_internal() path when RPS is compiled in but disabled.

A new internal NET_RX_UNHANDLED sentinel lets a helper report "RPS did
not take this skb" so the caller falls back to the local enqueue /
__netif_receive_skb() path; it never escapes to callers.

No functional change intended.

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
---
Changes since v1 [1]:
  - Move rcu_read_lock()/unlock() inside the
    static_branch_unlikely(&rps_needed) check, so no RCU read-side section
    is entered when RPS is compiled in but disabled at runtime. Addresses
    Paolo's concern that netif_rx_internal() is performance critical and
    rcu_read_lock() is not a no-op.
  - Drop the guard(rcu) / scoped_guard(rcu) conversion; the RCU section
    is now scoped inside netif_rps() / netif_rps_list() themselves.
  - Split __netif_rps() out of netif_rps() so that netif_rps_list() can
    reuse the per-skb steering step without re-testing the static branch
    or dropping and reacquiring the RCU lock per skb.
  - netif_rps_list() now returns int; when RPS drains the entire list,
    netif_receive_skb_list_internal() skips the __netif_receive_skb_list()
    fall-through instead of walking an empty list. The result is decided
    directly from list_empty(&undo_list): drop the splice on the drained
    path and only splice back when there is something to fall through.

Verified generated code with objdump on aarch64 with CONFIG_RPS=y,
CONFIG_XPS=y, CONFIG_SMP=y, CONFIG_PREEMPT=y (so rcu_read_lock()
expands to a real preempt_disable(), i.e. not a no-op -- the
specific scenario Paolo asked about [2]):

  scripts/bloat-o-meter net/core/dev.o (before -> after):
    add/remove: 2/2 grow/shrink: 1/2 up/down: 720/-716 (4)
    Function                        old     new   delta
    __netif_rps                       -     660    +660
    netif_receive_skb_list_internal 640     700     +60
    netif_rx_internal               236     200     -36
    netif_receive_skb               204     136     -68
    get_rps_cpu                     608       -    -608
    Total: Before=335841, After=335849, chg +0.00%

  netif_rx_internal fast path (!rps_needed, i.e. static branch not
  taken -- the path Paolo asked about [2]):
    - identical instruction sequence to base, no rcu_read_lock/unlock
    - stack frame 16 bytes smaller (0x50 -> 0x40)
    - static_branch NOP is preserved
  netif_receive_skb_internal: inlined in both builds; caller
    netif_receive_skb shrinks by 68 bytes.
  netif_receive_skb_list_internal: !rps_needed fast path unchanged;
    rps_needed=true path grows +60 bytes for LIST_HEAD(undo_list)
    setup, the explicit list_empty(&undo_list)/list_splice_init()
    branch and its early NET_RX_SUCCESS return.

[1] https://lore.kernel.org/all/20260702152830.39065-1-jemmywong512@gmail.com/
[2] https://lore.kernel.org/all/e53482b8-4e1d-4a04-929c-f5cb443ba59d@redhat.com/

 include/linux/netdevice.h |   5 +-
 net/core/dev.c            | 118 +++++++++++++++++++++++---------------
 2 files changed, 74 insertions(+), 49 deletions(-)

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
index 4b3d5cfdf6e0..1a05ac8fdd50 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5426,6 +5426,65 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	return NET_RX_DROP;
 }

+#ifdef CONFIG_RPS
+static inline int __netif_rps(struct sk_buff *skb)
+{
+	int cpu;
+	int ret = NET_RX_UNHANDLED;
+	struct rps_dev_flow voidflow, *rflow = &voidflow;
+
+	cpu = get_rps_cpu(skb->dev, skb, &rflow);
+	if (cpu >= 0)
+		ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
+
+	return ret;
+}
+#endif
+
+static inline int netif_rps(struct sk_buff *skb)
+{
+	int ret = NET_RX_UNHANDLED;
+
+#ifdef CONFIG_RPS
+	if (!static_branch_unlikely(&rps_needed))
+		return ret;
+
+	rcu_read_lock();
+	ret = __netif_rps(skb);
+	rcu_read_unlock();
+#endif
+
+	return ret;
+}
+
+static inline int netif_rps_list(struct list_head *head)
+{
+	int ret = NET_RX_UNHANDLED;
+
+#ifdef CONFIG_RPS
+	LIST_HEAD(undo_list);
+	struct sk_buff *skb, *next;
+
+	if (!static_branch_unlikely(&rps_needed))
+		return ret;
+
+	rcu_read_lock();
+	list_for_each_entry_safe(skb, next, head, list) {
+		skb_list_del_init(skb);
+		if (__netif_rps(skb) == NET_RX_UNHANDLED)
+			list_add_tail(&skb->list, &undo_list);
+	}
+	rcu_read_unlock();
+
+	if (list_empty(&undo_list))
+		ret = NET_RX_SUCCESS;
+	else
+		list_splice_init(&undo_list, head);
+#endif
+
+	return ret;
+}
+
 static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
@@ -5695,34 +5754,18 @@ EXPORT_SYMBOL_GPL(do_xdp_generic);

 static int netif_rx_internal(struct sk_buff *skb)
 {
+	unsigned int qtail;
 	int ret;

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
-
-		ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
-
-		rcu_read_unlock();
-	} else
-#endif
-	{
-		unsigned int qtail;
+	ret = netif_rps(skb);
+	if (ret != NET_RX_UNHANDLED)
+		return ret;

-		ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);
-	}
-	return ret;
+	return enqueue_to_backlog(skb, smp_processor_id(), &qtail);
 }

 /**
@@ -6389,19 +6432,11 @@ static int netif_receive_skb_internal(struct sk_buff *skb)
 	if (skb_defer_rx_timestamp(skb))
 		return NET_RX_SUCCESS;

-	rcu_read_lock();
-#ifdef CONFIG_RPS
-	if (static_branch_unlikely(&rps_needed)) {
-		struct rps_dev_flow voidflow, *rflow = &voidflow;
-		int cpu = get_rps_cpu(skb->dev, skb, &rflow);
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
+	rcu_read_lock();
 	ret = __netif_receive_skb(skb);
 	rcu_read_unlock();
 	return ret;
@@ -6421,21 +6456,10 @@ void netif_receive_skb_list_internal(struct list_head *head)
 	}
 	list_splice_init(&sublist, head);

-	rcu_read_lock();
-#ifdef CONFIG_RPS
-	if (static_branch_unlikely(&rps_needed)) {
-		list_for_each_entry_safe(skb, next, head, list) {
-			struct rps_dev_flow voidflow, *rflow = &voidflow;
-			int cpu = get_rps_cpu(skb->dev, skb, &rflow);
+	if (netif_rps_list(head) == NET_RX_SUCCESS)
+		return;

-			if (cpu >= 0) {
-				/* Will be handled, remove from list */
-				skb_list_del_init(skb);
-				enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
-			}
-		}
-	}
-#endif
+	rcu_read_lock();
 	__netif_receive_skb_list(head);
 	rcu_read_unlock();
 }
--
2.54.0 (Apple Git-157)

