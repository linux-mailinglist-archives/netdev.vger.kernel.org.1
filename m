Return-Path: <netdev+bounces-129520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8F984425
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC51B25AD8
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A841A7047;
	Tue, 24 Sep 2024 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vpeD71Ji"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218B1A4E95;
	Tue, 24 Sep 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175864; cv=none; b=JYhiyoBm1j/wXGboxFEv/xxdyGALXinr1dMmDmYN23+QK512DNqzOyyNGjpuQkyGWOhTgne3T/x5zpmN14EPkNfs0GsVyFTg8SEvScDrv2qPis7ovQvA/D2Ipts1YueO/48XVjxucktjSTnUN7TLHqmSpyb1rcP/MlW7DBnkwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175864; c=relaxed/simple;
	bh=bZ8XOgRYx+YaKS0KS2693vaNToGxxnRkfmbA4ydOF+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hx3FN2/35flrLDhmAfNE1mKXoqBWtxXpcIgi3v8VVcN27/MIuzHP74rIGbqwqVtGv++kAG0lyIppYXIrmX8OPlZp/XBCye0LH1PAe4Ld7c7is7swJMfjGmXJFL4F7Y3d9FZK1n2ffwbe3fkIFUmxAQ7sdb6AI2Tliobn7LPH5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vpeD71Ji; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727175858; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XhkQruGVjV1/Xx6IVscGGstSs8JuhW+tSK1dKwqn0E0=;
	b=vpeD71JiQHRALUMYQxBQPX5s91tox30jn7DYQviZB9+P1Oh9fRynIevrNOoCyrs2fX5/9FIvptIMo8EF3F6Yei2Fk9tdxgkfVJvBbRWLmw+2R2nB77UyqRxW1WK6uoh8tUw5KcTRcDJM1gNw2ZQA6d6ADibnPIJTMiWBtJAnzyQ=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFgCs8q_1727175857)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 19:04:17 +0800
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
Subject: [RFC PATCHv2 net-next 2/3] net/udp: Add 4-tuple hash list basis
Date: Tue, 24 Sep 2024 19:04:13 +0800
Message-Id: <20240924110414.52618-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240924110414.52618-1-lulie@linux.alibaba.com>
References: <20240924110414.52618-1-lulie@linux.alibaba.com>
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
 include/linux/udp.h |  7 +++++++
 include/net/udp.h   | 16 +++++++++++++++-
 net/ipv4/udp.c      | 17 +++++++++++++----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3eb3f2b9a2a05..c04808360a05d 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -56,6 +56,10 @@ struct udp_sock {
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
+	/* For UDP 4-tuple hash */
+	__u16 udp_lrpa_hash;
+	struct hlist_node udp_lrpa_node;
+
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
@@ -206,6 +210,9 @@ static inline void udp_allow_gso(struct sock *sk)
 #define udp_portaddr_for_each_entry_rcu(__sk, list) \
 	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
 
+#define udp_lrpa_for_each_entry_rcu(__up, list) \
+	hlist_for_each_entry_rcu(__up, list, udp_lrpa_node)
+
 #define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
 
 #endif	/* _LINUX_UDP_H */
diff --git a/include/net/udp.h b/include/net/udp.h
index f13f7220c2f41..94005363b8abd 100644
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
@@ -79,12 +79,15 @@ struct udp_hslot_main {
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
+	struct udp_hslot	*hash4;
 	unsigned int		mask;
 	unsigned int		log;
 };
@@ -113,6 +116,17 @@ static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
 	return (struct udp_hslot *)udp_hashslot2_main(table, hash);
 }
 
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
 extern struct proto udp_prot;
 
 extern atomic_long_t udp_memory_allocated;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e17c8ae121f27..5564896686fa5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3425,7 +3425,7 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 {
 	unsigned int i, slot_size;
 
-	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
+	slot_size = 2 * sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
 	table->hash = alloc_large_system_hash(name,
 					      slot_size,
 					      uhash_entries,
@@ -3437,6 +3437,7 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 					      UDP_HTABLE_SIZE_MAX);
 
 	table->hash2 = UDP_HSLOT_MAIN(table->hash + (table->mask + 1));
+	table->hash4 = (struct udp_hslot *)(table->hash2 + (table->mask + 1));
 	for (i = 0; i <= table->mask; i++) {
 		INIT_HLIST_HEAD(&table->hash[i].head);
 		table->hash[i].count = 0;
@@ -3448,6 +3449,11 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 		spin_lock_init(&table->hash2[i].hslot.lock);
 		table->hash2[i].hash4_cnt = 0;
 	}
+	for (i = 0; i <= table->mask; i++) {
+		INIT_HLIST_HEAD(&table->hash4[i].head);
+		table->hash4[i].count = 0;
+		spin_lock_init(&table->hash4[i].lock);
+	}
 }
 
 u32 udp_flow_hashrnd(void)
@@ -3480,16 +3486,15 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 	if (!udptable)
 		goto out;
 
-	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
+	slot_size = 2 * sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
 	udptable->hash = vmalloc_huge(hash_entries * slot_size,
 				      GFP_KERNEL_ACCOUNT);
 	if (!udptable->hash)
 		goto free_table;
 
 	udptable->hash2 = UDP_HSLOT_MAIN(udptable->hash + hash_entries);
-	udptable->mask = hash_entries - 1;
+	udptable->hash4 = (struct udp_hslot *)(udptable->hash2 + hash_entries);
 	udptable->log = ilog2(hash_entries);
-
 	for (i = 0; i < hash_entries; i++) {
 		INIT_HLIST_HEAD(&udptable->hash[i].head);
 		udptable->hash[i].count = 0;
@@ -3499,6 +3504,10 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 		udptable->hash2[i].hslot.count = 0;
 		spin_lock_init(&udptable->hash2[i].hslot.lock);
 		udptable->hash2[i].hash4_cnt = 0;
+
+		INIT_HLIST_HEAD(&udptable->hash4[i].head);
+		udptable->hash4[i].count = 0;
+		spin_lock_init(&udptable->hash4[i].lock);
 	}
 
 	return udptable;
-- 
2.32.0.3.g01195cf9f


