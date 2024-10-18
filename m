Return-Path: <netdev+bounces-136980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FC19A3D71
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAEE284A85
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA931362;
	Fri, 18 Oct 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NOnFYxvv"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5511A32;
	Fri, 18 Oct 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251944; cv=none; b=h8VTqrybr/lpUFaR0vcOOG8VrvHNMw5bvBkxqbFYRUK9H3+hH2JDbQRkfLgAdQ7v6VFkTlqhA3yg637jMfcA5vY/ydmuqy2qqFWbHIXsieQLlfBHyFKjvivQkosk50wfOFqzbZCjjDjYwxKHFntVUGe/re1/ADnzcuaIg5528b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251944; c=relaxed/simple;
	bh=qCdh2zMzL0Z76yj5dgirxEQYgFCsAW+1uSNgGtDgcmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAZ0P4uV/xDBlTyFtlNKI3RPGoZxf3D30dyVqceyazFYWXUkw5YFPs1fp7+4EZKVDyCzi5ELdiw2FZ82uuoWSCjf6ZC6q5AyZt96JAZnkvbJu8e8RriAXr1RYg4yGdBhEElOKMbbMsJbjv5eX7e+YXr2dhPAWnIA4AHpAsXlFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NOnFYxvv; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729251939; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ROzlH0PRT6Cxlwg6kW8QAqgg8DazNGwb0OtTEOwqX5s=;
	b=NOnFYxvvgVWNgfRd+GWDNNqwwQCGrC9Nd8zB1E/s4qo2fPk3f+dNufZ2R66SsBMqrqczQxfrc1phaae/yV0fJ2BaXadEPE6swtR+wv0Sj/dZm5ZVieXTorcib7Xnqh1KNjmIWvDVaMnZ02KIHe3fzUhFzshn+/UG/ua7ry/JzaI=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHO.8lc_1729251938 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 19:45:38 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	antony.antony@secunet.com,
	steffen.klassert@secunet.com,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	jakub@cloudflare.com,
	fred.cc@alibaba-inc.com,
	yubing.qiuyubing@alibaba-inc.com
Subject: [PATCH v5 net-next 2/3] net/udp: Add 4-tuple hash list basis
Date: Fri, 18 Oct 2024 19:45:34 +0800
Message-Id: <20241018114535.35712-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241018114535.35712-1-lulie@linux.alibaba.com>
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new hash list, hash4, in udp table. It will be used to implement
4-tuple hash for connected udp sockets. This patch adds the hlist to
table, and implements helpers and the initialization. 4-tuple hash is
implemented in the following patch.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
---
 include/linux/udp.h | 11 ++++++
 include/net/udp.h   | 87 ++++++++++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp.c      | 10 +++---
 3 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3eb3f2b9a2a0..09abd3700d81 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -56,6 +56,12 @@ struct udp_sock {
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+	/* For UDP 4-tuple hash */
+	__u16 udp_lrpa_hash;
+	struct hlist_node udp_lrpa_node;
+#endif
+
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
@@ -206,6 +212,11 @@ static inline void udp_allow_gso(struct sock *sk)
 #define udp_portaddr_for_each_entry_rcu(__sk, list) \
 	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
 
+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+#define udp_lrpa_for_each_entry_rcu(__up, list) \
+	hlist_for_each_entry_rcu(__up, list, udp_lrpa_node)
+#endif
+
 #define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
 
 #endif	/* _LINUX_UDP_H */
diff --git a/include/net/udp.h b/include/net/udp.h
index cd2158618329..8aefdc404362 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -50,7 +50,7 @@ struct udp_skb_cb {
 #define UDP_SKB_CB(__skb)	((struct udp_skb_cb *)((__skb)->cb))
 
 /**
- *	struct udp_hslot - UDP hash slot used by udp_table.hash
+ *	struct udp_hslot - UDP hash slot used by udp_table.hash/hash4
  *
  *	@head:	head of list of sockets
  *	@count:	number of sockets in 'head' list
@@ -81,12 +81,17 @@ struct udp_hslot_main {
  *
  *	@hash:	hash table, sockets are hashed on (local port)
  *	@hash2:	hash table, sockets are hashed on (local port, local address)
+ *	@hash4:	hash table, connected sockets are hashed on
+ *		(local port, local address, remote port, remote address)
  *	@mask:	number of slots in hash tables, minus 1
  *	@log:	log2(number of slots in hash table)
  */
 struct udp_table {
 	struct udp_hslot	*hash;
 	struct udp_hslot_main	*hash2;
+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+	struct udp_hslot	*hash4;
+#endif
 	unsigned int		mask;
 	unsigned int		log;
 };
@@ -109,6 +114,86 @@ static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
 	return &table->hash2[hash & table->mask].hslot;
 }
 
+#if IS_ENABLED(CONFIG_BASE_SMALL)
+static inline struct udp_hslot *udp_hashslot4(struct udp_table *table,
+					      unsigned int hash)
+{
+	BUILD_BUG();
+	return NULL;
+}
+
+static inline bool udp_hashed4(const struct sock *sk)
+{
+	return false;
+}
+
+static inline unsigned int udp_hash4_slot_size(void)
+{
+	return 0;
+}
+
+static inline void udp_table_hash4_init(struct udp_table *table)
+{
+}
+
+static inline bool udp_has_hash4(const struct udp_hslot *hslot2)
+{
+	return false;
+}
+
+static inline void udp_hash4_inc(struct udp_hslot *hslot2)
+{
+}
+
+static inline void udp_hash4_dec(struct udp_hslot *hslot2)
+{
+}
+#else /* !CONFIG_BASE_SMALL */
+static inline struct udp_hslot *udp_hashslot4(struct udp_table *table,
+					      unsigned int hash)
+{
+	return &table->hash4[hash & table->mask];
+}
+
+static inline bool udp_hashed4(const struct sock *sk)
+{
+	return !hlist_unhashed(&udp_sk(sk)->udp_lrpa_node);
+}
+
+static inline unsigned int udp_hash4_slot_size(void)
+{
+	return sizeof(struct udp_hslot);
+}
+
+/* Must be called with table->hash2 initialized */
+static inline void udp_table_hash4_init(struct udp_table *table)
+{
+	table->hash4 = (void *)(table->hash2 + (table->mask + 1));
+	for (int i = 0; i <= table->mask; i++) {
+		table->hash2[i].hash4_cnt = 0;
+
+		INIT_HLIST_HEAD(&table->hash4[i].head);
+		table->hash4[i].count = 0;
+		spin_lock_init(&table->hash4[i].lock);
+	}
+}
+
+static inline bool udp_has_hash4(const struct udp_hslot *hslot2)
+{
+	return UDP_HSLOT_MAIN(hslot2)->hash4_cnt;
+}
+
+static inline void udp_hash4_inc(struct udp_hslot *hslot2)
+{
+	UDP_HSLOT_MAIN(hslot2)->hash4_cnt++;
+}
+
+static inline void udp_hash4_dec(struct udp_hslot *hslot2)
+{
+	UDP_HSLOT_MAIN(hslot2)->hash4_cnt--;
+}
+#endif /* CONFIG_BASE_SMALL */
+
 extern struct proto udp_prot;
 
 extern atomic_long_t udp_memory_allocated;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2b7e72c4ed6d..74bfab0f44f8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3425,7 +3425,8 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 {
 	unsigned int i, slot_size;
 
-	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
+	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main) +
+		    udp_hash4_slot_size();
 	table->hash = alloc_large_system_hash(name,
 					      slot_size,
 					      uhash_entries,
@@ -3446,8 +3447,8 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
 		table->hash2[i].hslot.count = 0;
 		spin_lock_init(&table->hash2[i].hslot.lock);
-		table->hash2[i].hash4_cnt = 0;
 	}
+	udp_table_hash4_init(table);
 }
 
 u32 udp_flow_hashrnd(void)
@@ -3480,7 +3481,8 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 	if (!udptable)
 		goto out;
 
-	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
+	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main) +
+		    udp_hash4_slot_size();
 	udptable->hash = vmalloc_huge(hash_entries * slot_size,
 				      GFP_KERNEL_ACCOUNT);
 	if (!udptable->hash)
@@ -3498,8 +3500,8 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 		INIT_HLIST_HEAD(&udptable->hash2[i].hslot.head);
 		udptable->hash2[i].hslot.count = 0;
 		spin_lock_init(&udptable->hash2[i].hslot.lock);
-		udptable->hash2[i].hash4_cnt = 0;
 	}
+	udp_table_hash4_init(udptable);
 
 	return udptable;
 
-- 
2.32.0.3.g01195cf9f


