Return-Path: <netdev+bounces-262083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLO7G4Zuomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB46D1C0439
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D334305FFCD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDC244684;
	Sat, 28 Feb 2026 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ChedXQI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739D322B6F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252719; cv=none; b=EJt0ufMGMCSEtjGOOVefZ+xsQn9ld/etJjh5m+vQkZZ4B0RVoQXag+AmEPgH5kl0JXCBb2Dk5uyL+Zviho14FKvygeHM2uqwAw0iXe6N1NXt09lQoVpgVkrpObOQbcNvOIx4U1a1EyGjHfubMCQ5EMseQxmetfYNxSLcB/+j3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252719; c=relaxed/simple;
	bh=4czA7lfSP/DU3gq8B46FcHX5oxlsaFjdxeM0gx7IYQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GqKY/VEzyQTSYZUfIWqzaCiqpGP6gvSFaHWvW0PK+dlNIuCXzwsK9eOfHOHGN4PUlBIzgXv2p2Lue8wEYPUsAfEs9yBvc7EWFAJ+KguC1Qb4tLFdhjlhV9+CFKbbzg7FMNoMQJx90Y7cST9Jq5hRyoUFg4S+x94LPLGCgpLNrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ChedXQI; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8950562d351so90173506d6.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252716; x=1772857516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBiqdKTmtvotzTt+q2eW94Q1Q+9WunbVh0uwkPyjabs=;
        b=2ChedXQIUu2HZhmgdnV2asK4F3dpN8zVHkKaBWWvu2yRkcVLo/X7fgKH0l43pWACx8
         W2KXeSVHArPm21OIytbH4GGzTATkVKZcCfpbR4mYcBcGR1uw3vrhYavrC/9cm0uW9gXB
         OFLXvpsL5uisoI+ay67sYxeEvu6VqCHOtaTVkLZVCd/CaOTM2JKxQGJ/MX4PPoT2GIWE
         YI5ZfzlNd98dBSxjqiSFpQ1ecF8BEfVSGRhvTYfGocttoy0nbclIue6nXyabet2ey+2S
         LeUcTxwiwG6eARkHq+uFd1fRT+8gwMNDEQfok0I0iOhuzocOWPd7q2LAsHGHglVQvDdr
         1SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252716; x=1772857516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBiqdKTmtvotzTt+q2eW94Q1Q+9WunbVh0uwkPyjabs=;
        b=K6FT+9fhnW2Jq2F/XAOWWbQL0fvIZ/1Tq9THAHg6jVhK2Hb8n7mrsIwiJFSlhjVW/B
         6yNx5hoaL5neqtcfz76NxgbZxYsmlJjEY4W3iQ4WAPCil3JytR3vASOwzrMx6u+Odgic
         Vfgaeej2YwbmzjYlDkJtpw6YD8+P//3iOmDyovuIRnRm3a6bRUQT02ww7TkqDpTdvaXr
         5FjrJX8fqWHZA8wcA9/kytRnX4NwPMsLWUYShPWqWVU32JSpVE3wsKwfQ8nRlKVcscwq
         ef4jQqCf50WL5PiaLDtOsAk4m8w/wZksg4oxJvqivqqxYRcj56EwKOtqbbo3LZBXy8YF
         KoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVObpRvZZeu1KdO5Td5S2YsjCYg3sA6+DRBfLCunMNd3cvciu3MzNpimHt5u3TNja0rt5W328I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wCmWYFEGLm+fTeEC7a9QC3v3Ne4BcO5AYTm3gHX3L7y8ReSs
	jE1hnndam/wxu80bUMSbLmOOVIUfXPV/KbTpiK6KzurQAvQfnMQdi38/9tTWtbUMCrIvL0XQ53+
	PeSzDPCmCJ8QMLg==
X-Received: from qvkj21.prod.google.com ([2002:a0c:e015:0:b0:896:fff7:830])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ca3:0:b0:889:7c5b:8134 with SMTP id 6a1803df08f44-899d1dc4d12mr84431346d6.27.1772252716347;
 Fri, 27 Feb 2026 20:25:16 -0800 (PST)
Date: Sat, 28 Feb 2026 04:25:03 +0000
In-Reply-To: <20260228042503.3726451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228042503.3726451-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-8-edumazet@google.com>
Subject: [PATCH net-next 7/7] net-sysfs: use rps_tag_ptr and remove metadata
 from rps_dev_flow_table
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262083-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB46D1C0439
X-Rspamd-Action: no action

Instead of storing the @log at the beginning of rps_dev_flow_table
use 5 low order bits of the rps_tag_ptr to store the log of the size.

This removes a potential cache line miss (for light traffic).

This allows us to switch to one high-order allocation instead of vmalloc()
when CONFIG_RFS_ACCEL is not set.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netdev_rx_queue.h |  3 ++-
 include/net/rps.h             |  4 +--
 net/core/dev.c                | 43 ++++++++++++++++++------------
 net/core/net-sysfs.c          | 49 ++++++++++++++++++++---------------
 4 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cfa72c4853876c6fcb84b5c551580d9205f7b29d..08f81329fc11dc86767f9da661be8c7194dc1da2 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -8,13 +8,14 @@
 #include <net/xdp.h>
 #include <net/page_pool/types.h>
 #include <net/netdev_queues.h>
+#include <net/rps-types.h>
 
 /* This structure contains an instance of an RX queue. */
 struct netdev_rx_queue {
 	struct xdp_rxq_info		xdp_rxq;
 #ifdef CONFIG_RPS
 	struct rps_map __rcu		*rps_map;
-	struct rps_dev_flow_table __rcu	*rps_flow_table;
+	rps_tag_ptr			rps_flow_table;
 #endif
 	struct kobject			kobj;
 	const struct attribute_group	**groups;
diff --git a/include/net/rps.h b/include/net/rps.h
index 98f96d6c606e63f5ac31a9cf98ce8a0fb6486ba9..d065de46148f38f395e503ea6f086a283f819489 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -43,11 +43,9 @@ struct rps_dev_flow {
  * The rps_dev_flow_table structure contains a table of flow mappings.
  */
 struct rps_dev_flow_table {
-	u8			log;
 	struct rps_dev_flow	flows[];
 };
-#define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
-    ((_num) * sizeof(struct rps_dev_flow)))
+#define RPS_DEV_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_dev_flow_table, flows[_num]))
 
 /*
  * The rps_sock_flow_table contains mappings of flows to the last CPU
diff --git a/net/core/dev.c b/net/core/dev.c
index 23cc1fc5e608310d12956286c7b0199a481f19ab..d37de5de75da84d04b7c7bc8dfa6d96f990442b2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4968,9 +4968,9 @@ EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
 
-static u32 rfs_slot(u32 hash, const struct rps_dev_flow_table *flow_table)
+static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
-	return hash_32(hash, flow_table->log);
+	return hash_32(hash, rps_tag_to_log(tag_ptr));
 }
 
 #ifdef CONFIG_RFS_ACCEL
@@ -4986,7 +4986,7 @@ static u32 rfs_slot(u32 hash, const struct rps_dev_flow_table *flow_table)
  * Return: true if flow was recently active.
  */
 static bool rps_flow_is_active(struct rps_dev_flow *rflow,
-			       struct rps_dev_flow_table *flow_table,
+			       u8 log,
 			       unsigned int cpu)
 {
 	unsigned int flow_last_active;
@@ -4999,7 +4999,7 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 	flow_last_active = READ_ONCE(rflow->last_qtail);
 
 	return (int)(sd_input_head - flow_last_active) <
-		(int)(10 << flow_table->log);
+		(int)(10 << log);
 }
 #endif
 
@@ -5014,6 +5014,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *old_rflow;
 		struct rps_dev_flow *tmp_rflow;
+		rps_tag_ptr q_tag_ptr;
 		unsigned int tmp_cpu;
 		u16 rxq_index;
 		u32 flow_id;
@@ -5028,16 +5029,18 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 			goto out;
 
 		rxqueue = dev->_rx + rxq_index;
-		flow_table = rcu_dereference(rxqueue->rps_flow_table);
-		if (!flow_table)
+		q_tag_ptr = READ_ONCE(rxqueue->rps_flow_table);
+		if (!q_tag_ptr)
 			goto out;
 
-		flow_id = rfs_slot(hash, flow_table);
+		flow_id = rfs_slot(hash, q_tag_ptr);
+		flow_table = rps_tag_to_table(q_tag_ptr);
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
 		if (READ_ONCE(tmp_rflow->filter) != RPS_NO_FILTER) {
-			if (rps_flow_is_active(tmp_rflow, flow_table,
+			if (rps_flow_is_active(tmp_rflow,
+					       rps_tag_to_log(q_tag_ptr),
 					       tmp_cpu)) {
 				if (hash != READ_ONCE(tmp_rflow->hash) ||
 				    next_cpu == tmp_cpu)
@@ -5076,8 +5079,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		       struct rps_dev_flow **rflowp)
 {
 	struct netdev_rx_queue *rxqueue = dev->_rx;
-	struct rps_dev_flow_table *flow_table;
-	rps_tag_ptr global_tag_ptr;
+	rps_tag_ptr global_tag_ptr, q_tag_ptr;
 	struct rps_map *map;
 	int cpu = -1;
 	u32 tcpu;
@@ -5098,9 +5100,9 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 
 	/* Avoid computing hash if RFS/RPS is not active for this rxqueue */
 
-	flow_table = rcu_dereference(rxqueue->rps_flow_table);
+	q_tag_ptr = READ_ONCE(rxqueue->rps_flow_table);
 	map = rcu_dereference(rxqueue->rps_map);
-	if (!flow_table && !map)
+	if (!q_tag_ptr && !map)
 		goto done;
 
 	skb_reset_network_header(skb);
@@ -5109,8 +5111,9 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		goto done;
 
 	global_tag_ptr = READ_ONCE(net_hotdata.rps_sock_flow_table);
-	if (flow_table && global_tag_ptr) {
+	if (q_tag_ptr && global_tag_ptr) {
 		struct rps_sock_flow_table *sock_flow_table;
+		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *rflow;
 		u32 next_cpu;
 		u32 flow_id;
@@ -5130,7 +5133,9 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
+		flow_id = rfs_slot(hash, q_tag_ptr);
+		flow_table = rps_tag_to_table(q_tag_ptr);
+		rflow = &flow_table->flows[flow_id];
 		tcpu = rflow->cpu;
 
 		/*
@@ -5192,17 +5197,21 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 	struct netdev_rx_queue *rxqueue = dev->_rx + rxq_index;
 	struct rps_dev_flow_table *flow_table;
 	struct rps_dev_flow *rflow;
+	rps_tag_ptr q_tag_ptr;
 	bool expire = true;
+	u8 log;
 
 	rcu_read_lock();
-	flow_table = rcu_dereference(rxqueue->rps_flow_table);
-	if (flow_table && flow_id < (1UL << flow_table->log)) {
+	q_tag_ptr = READ_ONCE(rxqueue->rps_flow_table);
+	log = rps_tag_to_log(q_tag_ptr);
+	if (q_tag_ptr && flow_id < (1UL << log)) {
 		unsigned int cpu;
 
+		flow_table = rps_tag_to_table(q_tag_ptr);
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
 		if (READ_ONCE(rflow->filter) == filter_id &&
-		    rps_flow_is_active(rflow, flow_table, cpu))
+		    rps_flow_is_active(rflow, log, cpu))
 			expire = false;
 	}
 	rcu_read_unlock();
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fd6f81930bc6437957f32206c84db87ee242fede..77950dd8de55802383cddc74fd74e14c7cc4a02a 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1060,14 +1060,12 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 static ssize_t show_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 					   char *buf)
 {
-	struct rps_dev_flow_table *flow_table;
 	unsigned long val = 0;
+	rps_tag_ptr tag_ptr;
 
-	rcu_read_lock();
-	flow_table = rcu_dereference(queue->rps_flow_table);
-	if (flow_table)
-		val = 1UL << flow_table->log;
-	rcu_read_unlock();
+	tag_ptr = READ_ONCE(queue->rps_flow_table);
+	if (tag_ptr)
+		val = 1UL << rps_tag_to_log(tag_ptr);
 
 	return sysfs_emit(buf, "%lu\n", val);
 }
@@ -1075,8 +1073,10 @@ static ssize_t show_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 					    const char *buf, size_t len)
 {
+	struct rps_dev_flow_table *table;
+	rps_tag_ptr otag, tag_ptr = 0UL;
 	unsigned long mask, count;
-	struct rps_dev_flow_table *table, *old_table;
+	size_t sz;
 	int rc;
 
 	if (!capable(CAP_NET_ADMIN))
@@ -1107,24 +1107,31 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 			return -EINVAL;
 		}
 #endif
-		table = vmalloc(RPS_DEV_FLOW_TABLE_SIZE(mask + 1));
+		sz = max_t(size_t, RPS_DEV_FLOW_TABLE_SIZE(mask + 1),
+			   PAGE_SIZE);
+		if (sz <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER) ||
+		    is_power_of_2(sz))
+			table = kvmalloc(sz, GFP_KERNEL);
+		else
+			table = vmalloc(sz);
 		if (!table)
 			return -ENOMEM;
-
-		table->log = ilog2(mask) + 1;
+		tag_ptr = (rps_tag_ptr)table;
+		if (rps_tag_to_log(tag_ptr)) {
+			pr_err_once("store_rps_dev_flow_table_cnt() got a non page aligned allocation.\n");
+			kvfree(table);
+			return -ENOMEM;
+		}
+		tag_ptr |= (ilog2(mask) + 1);
 		for (count = 0; count <= mask; count++) {
 			table->flows[count].cpu = RPS_NO_CPU;
 			table->flows[count].filter = RPS_NO_FILTER;
 		}
-	} else {
-		table = NULL;
 	}
 
-	old_table = unrcu_pointer(xchg(&queue->rps_flow_table,
-				       RCU_INITIALIZER(table)));
-
-	if (old_table)
-		kvfree_rcu_mightsleep(old_table);
+	otag = xchg(&queue->rps_flow_table, tag_ptr);
+	if (otag)
+		kvfree_rcu_mightsleep(rps_tag_to_table(otag));
 
 	return len;
 }
@@ -1150,7 +1157,7 @@ static void rx_queue_release(struct kobject *kobj)
 {
 	struct netdev_rx_queue *queue = to_rx_queue(kobj);
 #ifdef CONFIG_RPS
-	struct rps_dev_flow_table *old_table;
+	rps_tag_ptr tag_ptr;
 	struct rps_map *map;
 
 	map = rcu_dereference_protected(queue->rps_map, 1);
@@ -1159,9 +1166,9 @@ static void rx_queue_release(struct kobject *kobj)
 		kfree_rcu(map, rcu);
 	}
 
-	old_table = unrcu_pointer(xchg(&queue->rps_flow_table, NULL));
-	if (old_table)
-		kvfree_rcu_mightsleep(old_table);
+	tag_ptr = xchg(&queue->rps_flow_table, 0UL);
+	if (tag_ptr)
+		kvfree_rcu_mightsleep(rps_tag_to_table(tag_ptr));
 #endif
 
 	memset(kobj, 0, sizeof(*kobj));
-- 
2.53.0.473.g4a7958ca14-goog


