Return-Path: <netdev+bounces-305520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KlllN3chTWpcvgEAu9opvQ
	(envelope-from <netdev+bounces-305520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:55:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D071D8D0
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:55:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bhx3VxuL;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305520-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305520-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75F0630A14D5
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0C430CDB;
	Tue,  7 Jul 2026 15:49:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD23BD63B
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:49:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439350; cv=none; b=T+PGV1PVaPT7aMwMgeSGKVh77Y8ZKBOrrzH0H0ZPcQT46105t3dQ4Vtw+rqU6/Txb0A7QFicxsgpBCgLgvguCzMwIfik3iK5VyK7FJcvPgiOQzXX1UDuXwlk/pYIPv0TFbTY6Q2HC21YSO4LTT2bNx4d6532MLVp8jlJjnM1SAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439350; c=relaxed/simple;
	bh=dYXESmoZyq6+W/erTtepBlbqYIfMAToFJFCgX3m7wrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/Xq4y9siDsadO4GPbp1MKMNXADbY9ylyemIXySSzZQ0bW+L5ogRVa+7jSm5UwTsQuOvLUymfKyZnHYUK5E7Y4pEShm4pNHiZdbfVVAkWaksqdY7zTI+8u76yVAcNsV6/7T+a2EqGf0FMUnPoTSePBNzhpgobFjsjLrj57ginpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhx3VxuL; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caf4496889so5968945ad.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783439348; x=1784044148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX55HcCIgXeNDSs6UhoDWW9a/lSkFkcblQdBU0BYucI=;
        b=bhx3VxuLFtcR9s3Lw2T8b2vycj4p3tzVgjpZ3rXjYtlZ2J54WcBrbD8t8ezps805sz
         dOgo3VkqbLSTtpOXwlQRGL2TPLhCYi81Vupj0yivhtuU9euJBxLPDRKvH4F8HrsloMkb
         OwqnjwyjZGYfrISSKLE2ayo6X3wgAkqj5uTZpcuJ3WWUjf1C5pdZu4YK4LfStKvZUkUR
         qRvftOYF2Wzp7Mv5ce7YT6xuVzC0ASJdmHUJlsce34uD3Sm0x1Uznf8cubUmhtxWL9uD
         HclEiPlNHsZv+QSOH/Se4eIOEVPLRy70g4P4zJwmXbPfial9RXcBUFy1Totxhwe1nkQl
         31hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783439348; x=1784044148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nX55HcCIgXeNDSs6UhoDWW9a/lSkFkcblQdBU0BYucI=;
        b=p6qU0RmBvtaklm+oLS/SVBAZdYBWFb2B/fXIpEeSmzDbotZ7jsOOAzlX/zr9GhrzMd
         jh05s1uNnY4KawqNW8W0FyZ8JidTUyBAGtsoxp/f+KjudC/EQDtf/yNsxemZEvZvqB6v
         KdtKyDkP1/I86tn0Co7+2aWu4a+HtAtSaZrO+rGFLFGv6AA+ouS+zBNbeXtBykF9dkQ3
         adFbhGBEy+U5mycTyN9FUXPVyBAYT0Z3f0NJG7iO9Y9QmmPb3U9fWMrnTLNw9kScJjkm
         La54SvB0px8daKR4OL+M192dkYoTI78AV6F0WLG6PwDydD2oasD2yVqhDqkTCdl4Gg5q
         y3DA==
X-Gm-Message-State: AOJu0YyQjvNjrJ1zuRXX6jQTyOerLgWg32bxniye6pY27lC9kFBBtG5Z
	WW5hDWnn6ivz/t5d0WWF83C+50PLFwRb/g/48myHVC7ficqsk4U5XCng2a5sFo3y
X-Gm-Gg: AfdE7cmw0q7UMBoNOsldc+/Ljq/Nq0mUd5ipkfqtDXu2kActKdCYFh8BKbn4tVjrKxC
	peYAFLQ+W8BtUcQWxaKzqbVxomYKYdmgR1N3UzMgXejMQtonJCvLWKSCP9VTEVhBH37/f+e0W0n
	hHVaeyLAFcr49AdPJdxSkv26MQCV02U4twN9j1RvgdsdSVamD4D56GIz+EQMNDNQDx1GFOAudbj
	gTzTK8G8/Y2J9mhPCJb0cCjFPKtzpyFau6jzto8wimo+pVaPyv0CAJDXWHAc/0HulVIepLg1ed3
	HQI9IuojytpWZ4xFKmz9B/cGwJcr1pGGyurD+bgRmzm7ljf8mihYqXN6HbULrCfc3/0GT84loOt
	OoNy1xaefgs2vUKAi1BNDCRmZW1HYJRrEV8bCkPuot21gXanLmLgjqn/ubt/UQs9MtQ09qvogqc
	//bsvgxnu14eQ48+rTY0OXbRH5+aU=
X-Received: by 2002:a17:903:17c5:b0:2cc:6410:91b0 with SMTP id d9443c01a7336-2cccab18af2mr29269575ad.8.1783439348000;
        Tue, 07 Jul 2026 08:49:08 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm14315465ad.71.2026.07.07.08.49.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 08:49:07 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	"Jemmy Wong" <jemmywong512@gmail.com>
Subject: [RESEND PATCH] net/core: consolidate RPS dispatch into netif_rps() helpers
Date: Tue,  7 Jul 2026 23:48:55 +0800
Message-ID: <20260707154855.12134-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702152830.39065-1-jemmywong512@gmail.com>
References: <20260702152830.39065-1-jemmywong512@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305520-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jemmywong512@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jemmywong512@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jemmywong512@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C0D071D8D0

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

