Return-Path: <netdev+bounces-140708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AABF9B7B02
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF10B21030
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62E19D8AD;
	Thu, 31 Oct 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iUAx6ygx"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E531957FD;
	Thu, 31 Oct 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378760; cv=none; b=eIBgoXGZ2Hdx6QWEUSm05O5bVND4dBQSwH9OwbDs1e9ST8dk667O7qak7BRXmTOjhLFiHNfzdtGSLuQ71OV6yw+CWh3G5G7uH3kTLGd6+kBDh6yTrrU0MUmYX/DVy1hR8CU4jdR8m88WwMCM+ddtgTaRQfB6wMTSHP58IzZGpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378760; c=relaxed/simple;
	bh=iZbEXCwKOHRKnfiUv1j6DSKqpPPWQLQkmtZ1d452Sg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJUGyIrJHRs2UwZ4tuDE8+qRoe4YV8Ib/QZr4UYVtkj1YPqS/Tc3Z2YEgrldpdGPqHgP0S5Jlvt2uzb+b32WwjyryFdaxf5WtQECJqhOslc3g2jDImotEc1VdgGB7BYb9sur/U43h5SIccj/c/4spN1VVE8O8yBevJ6/JjsNFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iUAx6ygx; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730378753; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a/kL4gsdu5OjPMekDrEr220ExXnxBK6N2v1p3ToKegg=;
	b=iUAx6ygxUhA3iEL08abbrkikUHoU3BcanRCQOpCBv2LlRBjt/hH7YL0kYLS8ZGwV83wGW20XxaOj26kT5pogcicn7IZeZM+uQc6c4EKTuxW2FxiV0feJ5E/Fxml0wHpQ7reSOrYPBqt/1GXXWhJ/ukjqc0Vnni/j4wCFlkWI28A=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIIdMxs_1730378752 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 20:45:53 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	antony.antony@secunet.com,
	steffen.klassert@secunet.com,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	jakub@cloudflare.com,
	fred.cc@alibaba-inc.com,
	yubing.qiuyubing@alibaba-inc.com
Subject: [PATCH v6 net-next 2/4] net/udp: Add 4-tuple hash list basis
Date: Thu, 31 Oct 2024 20:45:48 +0800
Message-Id: <20241031124550.20227-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241031124550.20227-1-lulie@linux.alibaba.com>
References: <20241031124550.20227-1-lulie@linux.alibaba.com>
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

hash4 uses hlist_nulls to avoid moving wrongly onto another hlist due to
concurrent rehash, because rehash() can happen with lookup().

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
---
 include/linux/udp.h | 11 ++++++
 include/net/udp.h   | 85 +++++++++++++++++++++++++++++++++++++++++++--
 net/ipv4/udp.c      |  6 ++--
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3eb3f2b9a2a0..0807e21cfec9 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -56,6 +56,12 @@ struct udp_sock {
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+	/* For UDP 4-tuple hash */
+	__u16 udp_lrpa_hash;
+	struct hlist_nulls_node udp_lrpa_node;
+#endif
+
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
@@ -206,6 +212,11 @@ static inline void udp_allow_gso(struct sock *sk)
 #define udp_portaddr_for_each_entry_rcu(__sk, list) \
 	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
 
+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+#define udp_lrpa_for_each_entry_rcu(__up, node, list) \
+	hlist_nulls_for_each_entry_rcu(__up, node, list, udp_lrpa_node)
+#endif
+
 #define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
 
 #endif	/* _LINUX_UDP_H */
diff --git a/include/net/udp.h b/include/net/udp.h
index f4e04616c27f..23a1a8198e16 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -50,14 +50,21 @@ struct udp_skb_cb {
 #define UDP_SKB_CB(__skb)	((struct udp_skb_cb *)((__skb)->cb))
 
 /**
- *	struct udp_hslot - UDP hash slot used by udp_table.hash
+ *	struct udp_hslot - UDP hash slot used by udp_table.hash/hash4
  *
  *	@head:	head of list of sockets
+ *	@nulls_head:	head of list of sockets, only used by hash4
  *	@count:	number of sockets in 'head' list
  *	@lock:	spinlock protecting changes to head/count
  */
 struct udp_hslot {
-	struct hlist_head	head;
+	union {
+		struct hlist_head	head;
+		/* hash4 uses hlist_nulls to avoid moving wrongly onto another hlist due to
+		 * concurrent rehash, because rehash() can happen with lookup().
+		 */
+		struct hlist_nulls_head	nulls_head;
+	};
 	int			count;
 	spinlock_t		lock;
 } __aligned(2 * sizeof(long));
@@ -81,12 +88,17 @@ struct udp_hslot_main {
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
@@ -113,13 +125,80 @@ static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
 static inline void udp_table_hash4_init(struct udp_table *table)
 {
 }
+
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
 #else /* !CONFIG_BASE_SMALL */
 
 /* Must be called with table->hash2 initialized */
 static inline void udp_table_hash4_init(struct udp_table *table)
 {
-	for (int i = 0; i <= table->mask; i++)
+	table->hash4 = (void *)(table->hash2 + (table->mask + 1));
+	for (int i = 0; i <= table->mask; i++) {
 		table->hash2[i].hash4_cnt = 0;
+
+		INIT_HLIST_NULLS_HEAD(&table->hash4[i].nulls_head, i);
+		table->hash4[i].count = 0;
+		spin_lock_init(&table->hash4[i].lock);
+	}
+}
+
+static inline struct udp_hslot *udp_hashslot4(struct udp_table *table,
+					      unsigned int hash)
+{
+	return &table->hash4[hash & table->mask];
+}
+
+static inline bool udp_hashed4(const struct sock *sk)
+{
+	return !hlist_nulls_unhashed(&udp_sk(sk)->udp_lrpa_node);
+}
+
+static inline unsigned int udp_hash4_slot_size(void)
+{
+	return sizeof(struct udp_hslot);
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
 }
 #endif /* CONFIG_BASE_SMALL */
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2fdac5fae2a8..0bc0881d6569 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3427,7 +3427,8 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 {
 	unsigned int i, slot_size;
 
-	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
+	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main) +
+		    udp_hash4_slot_size();
 	table->hash = alloc_large_system_hash(name,
 					      slot_size,
 					      uhash_entries,
@@ -3482,7 +3483,8 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 	if (!udptable)
 		goto out;
 
-	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
+	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main) +
+		    udp_hash4_slot_size();
 	udptable->hash = vmalloc_huge(hash_entries * slot_size,
 				      GFP_KERNEL_ACCOUNT);
 	if (!udptable->hash)
-- 
2.32.0.3.g01195cf9f


