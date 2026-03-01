Return-Path: <netdev+bounces-262442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MGYN9iCpGnOiwUAu9opvQ
	(envelope-from <netdev+bounces-262442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:18:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434971D111A
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DF830338AB
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324932720C;
	Sun,  1 Mar 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3WSXkg3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390C338593
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388912; cv=none; b=T8GL7aXLnsXIhx2xUu01UvbUb+fc5bi5ksQupjhewYIAQTWUHBrwxQxOd8pWfXVWpW6kCKNwxcVCLSQwy9AQFsOKIKqZ6+AgooPISJNkLuEH2kX8FMPX6mfvsp17J77lm29EVmfEiIdOrLgHYPOejZz4l+S32LTveQ1uTiMULIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388912; c=relaxed/simple;
	bh=pFqQHTtDynoM9B1qu4j6a2SL6etXaWRiH/A7qlGQxY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTh5b0MPQplMB0e0c63N4fEGTxBq41kUqUkDuy9Jw5fwu9/25uoR8rwx3Sc5DwFEdwuFToIDDJ5Mq9GvgzeMGpptjF4aul2l8Ga25ScI95zbPnIaAGODEKGEHQ4jouoWg44t4iyg0qWanz5ab1MUhNjgRweqByVG22fX0UxA3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3WSXkg3; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c71655aa11so4688231285a.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772388910; x=1772993710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQPq+tbYQmoH0pf0nf+w2lzoG1NsGkh16A4EnOCYnyA=;
        b=E3WSXkg3uGnhrU+NW+BhxTqA6zE/v18jsaWsC1nVQM3SiLJL94Bx23UqJefPRwzFGI
         5/mASLq2CZ7WWU1uNSbubYMuqse2ttQedcl9ihOEuBoNt9y5Ylt47/+jVLSuj7Kjasau
         4T8vBqw8cRZlUZqr8XIsHd6xz6ecf+hKMO3wrdX4aquGfJbDiA3bUqul1uyeuMzoYzl2
         hH1bYCEiiJcMEiKFLwhjF4Ov6Sj7oALWZerz5UhyGDK0I8ZXqMpxqpPJc1kKQq+AlMeg
         ztYZW7hSRSHGFjIMm/aSKFsrvbTTh4uDIcQWU3Wk1JwqCJOHZ/X5SGzyG+HA1cGUPgYa
         ShhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772388910; x=1772993710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQPq+tbYQmoH0pf0nf+w2lzoG1NsGkh16A4EnOCYnyA=;
        b=ig35Ip44qSzz5Qci9I7kPhrDPKBF8OfQs0rZS3OhKJ9uf+RfRAtTwF1bJ9wxY1kUJA
         iorMzyrn/09DTGnfUS8+ssDMfNoWwznVwckfPZ9R/L3AgltwuHYil7G1bnkQd2rpQOIN
         /sA8RMSVPaI8WbpVqZcH6++M7/QOrztAax5JOhc71h73VWKMdUMqIq56DCBLzpaH0p8u
         X1PbYU9KpiZOdNgSXYfyKXZIwW1USLhwOQ+hn6mXMFqzZPQuG5AfnMEEUusIRn7tL8+n
         jxGggAI2TdUGtmvDwr1Wjlton9UWOB6FIh/P9JjbLQFaRIsbN3gW2ii2ddAdLwBzodDg
         3CZA==
X-Forwarded-Encrypted: i=1; AJvYcCWO49PoXMGdbEOJYgxsvEvDgxUFpClWOEf7zk9FSRkquTacu2pzBJANO0brQZnIVe49PNOguyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEfjwhhWp5rvud1snhQPve83K3P/V0qC4XJwMsNEVj5YOJdP0
	lSe10QBHa20nQoVpOCXNlK3UG+3a6kY0fTXyf9o7umWPibQPZtjdaoD9TdpdYVE8LIXGY3i0kp3
	h3KxVABDkULziNw==
X-Received: from qknot9.prod.google.com ([2002:a05:620a:8189:b0:8cb:381c:4ae1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2892:b0:8c6:abc5:f169 with SMTP id af79cd13be357-8cbc8e844c5mr1292408185a.73.1772388909872;
 Sun, 01 Mar 2026 10:15:09 -0800 (PST)
Date: Sun,  1 Mar 2026 18:14:57 +0000
In-Reply-To: <20260301181457.3539105-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260301181457.3539105-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301181457.3539105-8-edumazet@google.com>
Subject: [PATCH v2 net-next 7/7] net-sysfs: use rps_tag_ptr and remove
 metadata from rps_dev_flow_table
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262442-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 434971D111A
X-Rspamd-Action: no action

Instead of storing the @log at the beginning of rps_dev_flow_table
use 5 low order bits of the rps_tag_ptr to store the log of the size.

This removes a potential cache line miss (for light traffic).

This allows us to switch to one high-order allocation instead of vmalloc()
when CONFIG_RFS_ACCEL is not set.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: removed "struct rps_dev_flow_table" to address kernel build bot report.

 include/net/netdev_rx_queue.h |  3 +-
 include/net/rps.h             | 10 -------
 net/core/dev.c                | 53 ++++++++++++++++++++---------------
 net/core/net-sysfs.c          | 53 ++++++++++++++++++++---------------
 4 files changed, 63 insertions(+), 56 deletions(-)

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
index e900480e828b487c721b3ef392f4abb427ad442c..e33c6a2fa8bbca3555ecccbbf9132d01cc433c36 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -39,16 +39,6 @@ struct rps_dev_flow {
 };
 #define RPS_NO_FILTER 0xffff
 
-/*
- * The rps_dev_flow_table structure contains a table of flow mappings.
- */
-struct rps_dev_flow_table {
-	u8			log;
-	struct rps_dev_flow	flows[];
-};
-#define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
-    ((_num) * sizeof(struct rps_dev_flow)))
-
 /*
  * The rps_sock_flow_table contains mappings of flows to the last CPU
  * on which they were processed by the application (set in recvmsg).
diff --git a/net/core/dev.c b/net/core/dev.c
index d4837b058b2ff02e94f9590e310edbcb06dad0f2..053a30a8c0ea4464d3b61c7dde8ad916eeef1c19 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4968,16 +4968,16 @@ EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
 
-static u32 rfs_slot(u32 hash, const struct rps_dev_flow_table *flow_table)
+static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
-	return hash_32(hash, flow_table->log);
+	return hash_32(hash, rps_tag_to_log(tag_ptr));
 }
 
 #ifdef CONFIG_RFS_ACCEL
 /**
  * rps_flow_is_active - check whether the flow is recently active.
  * @rflow: Specific flow to check activity.
- * @flow_table: per-queue flowtable that @rflow belongs to.
+ * @log: ilog2(hashsize).
  * @cpu: CPU saved in @rflow.
  *
  * If the CPU has processed many packets since the flow's last activity
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
 
@@ -5011,9 +5011,10 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		u32 head;
 #ifdef CONFIG_RFS_ACCEL
 		struct netdev_rx_queue *rxqueue;
-		struct rps_dev_flow_table *flow_table;
+		struct rps_dev_flow *flow_table;
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
-		tmp_rflow = &flow_table->flows[flow_id];
+		flow_id = rfs_slot(hash, q_tag_ptr);
+		flow_table = rps_tag_to_table(q_tag_ptr);
+		tmp_rflow = flow_table + flow_id;
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
+		struct rps_dev_flow *flow_table;
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
+		rflow = flow_table + flow_id;
 		tcpu = rflow->cpu;
 
 		/*
@@ -5190,19 +5195,23 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 			 u32 flow_id, u16 filter_id)
 {
 	struct netdev_rx_queue *rxqueue = dev->_rx + rxq_index;
-	struct rps_dev_flow_table *flow_table;
+	struct rps_dev_flow *flow_table;
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
 
-		rflow = &flow_table->flows[flow_id];
+		flow_table = rps_tag_to_table(q_tag_ptr);
+		rflow = flow_table + flow_id;
 		cpu = READ_ONCE(rflow->cpu);
 		if (READ_ONCE(rflow->filter) == filter_id &&
-		    rps_flow_is_active(rflow, flow_table, cpu))
+		    rps_flow_is_active(rflow, log, cpu))
 			expire = false;
 	}
 	rcu_read_unlock();
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fd6f81930bc6437957f32206c84db87ee242fede..38bf2b42efb9abbf0a2b66b1d7dae130c85f1966 100644
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
+	struct rps_dev_flow *table;
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
+		sz = max_t(size_t, sizeof(*table) * (mask + 1),
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
-			table->flows[count].cpu = RPS_NO_CPU;
-			table->flows[count].filter = RPS_NO_FILTER;
+			table[count].cpu = RPS_NO_CPU;
+			table[count].filter = RPS_NO_FILTER;
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


