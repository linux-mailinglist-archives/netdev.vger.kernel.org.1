Return-Path: <netdev+bounces-136982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDEE9A3D75
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B81F24854
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB45817;
	Fri, 18 Oct 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ugKK8wRr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B133EADC;
	Fri, 18 Oct 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251949; cv=none; b=q+O4ZvTdlRhqMzHrdERRIRfUwNNftZY+7Jl4QhcWVWNMmlkiE00J4zYLkxgWxQe3b3MkzNlCmHWDr4PZyr9tOCCqqu5b5sjd41gxAEMQJRdrqUYc/95d1yhXF9wI6TCZuanwcRwPCeAbT+V8rNVqPX5R2yst99IhoZ2lWyCETrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251949; c=relaxed/simple;
	bh=1BNiMp5hft6BVcllpSQba4wculgblsP3M79IqEAZdPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=il+zqf3gJ71c47b+1wMs1WHhW9yOataNgkVkVmW5su4tFDDAsjA/bKWnnWnljlFtmgkCI4XDgNC2kxcJmNghP77bB/YBZDw2agOO6LT7bTfG0pQ5frqo2tM2Y3uW2dkEaf0g/dllKN1P/1nIx4G7nfNkkUfFLUW2yE2/dbjK9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ugKK8wRr; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729251938; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/44VCodUUm6O/Z7vpmu5lS38/1Ge/PgfRcDjU8R+TQA=;
	b=ugKK8wRr7zIMxDyRX2/OukeBKfLrwnlL+RZ9JNrkfFirXhF2TUvr8Vip6cNmHing81VSP3jyPXawCPx9hQSeGUIpkR+VCOwZFqlJXHV/Kk0m5AjDAElXWG2A2oR9HvYNFofNvoSfwmyROMwrrjPGTQlrCLuO/F6h8g3eZYMc0bM=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHO1lIp_1729251937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 19:45:37 +0800
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
Subject: [PATCH v5 net-next 1/3] net/udp: Add a new struct for hash2 slot
Date: Fri, 18 Oct 2024 19:45:33 +0800
Message-Id: <20241018114535.35712-2-lulie@linux.alibaba.com>
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

Preparing for udp 4-tuple hash (uhash4 for short).

To implement uhash4 without cache line missing when lookup, hslot2 is
used to record the number of hashed sockets in hslot4. Thus adding a new
struct udp_hslot_main with field hash4_cnt, which is used by hash2. The
new struct is used to avoid doubling the size of udp_hslot.

Before uhash4 lookup, firstly checking hash4_cnt to see if there are
hashed sks in hslot4. Because hslot2 is always used in lookup, there is
no cache line miss.

Related helpers are updated, and use the helpers as possible.

uhash4 is implemented in following patches.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/net/udp.h | 23 +++++++++++++++++++----
 net/ipv4/udp.c    | 44 +++++++++++++++++++++++---------------------
 net/ipv6/udp.c    | 15 ++++++---------
 3 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 61222545ab1c..cd2158618329 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -50,7 +50,7 @@ struct udp_skb_cb {
 #define UDP_SKB_CB(__skb)	((struct udp_skb_cb *)((__skb)->cb))
 
 /**
- *	struct udp_hslot - UDP hash slot
+ *	struct udp_hslot - UDP hash slot used by udp_table.hash
  *
  *	@head:	head of list of sockets
  *	@count:	number of sockets in 'head' list
@@ -60,7 +60,21 @@ struct udp_hslot {
 	struct hlist_head	head;
 	int			count;
 	spinlock_t		lock;
-} __attribute__((aligned(2 * sizeof(long))));
+} __aligned(2 * sizeof(long));
+
+/**
+ *	struct udp_hslot_main - UDP hash slot used by udp_table.hash2
+ *
+ *	@hslot:	basic hash slot
+ *	@hash4_cnt: number of sockets in hslot4 of the same (local port, local address)
+ */
+struct udp_hslot_main {
+	struct udp_hslot	hslot; /* must be the first member */
+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+	u32			hash4_cnt;
+#endif
+} __aligned(2 * sizeof(long));
+#define UDP_HSLOT_MAIN(__hslot) ((struct udp_hslot_main *)(__hslot))
 
 /**
  *	struct udp_table - UDP table
@@ -72,7 +86,7 @@ struct udp_hslot {
  */
 struct udp_table {
 	struct udp_hslot	*hash;
-	struct udp_hslot	*hash2;
+	struct udp_hslot_main	*hash2;
 	unsigned int		mask;
 	unsigned int		log;
 };
@@ -84,6 +98,7 @@ static inline struct udp_hslot *udp_hashslot(struct udp_table *table,
 {
 	return &table->hash[udp_hashfn(net, num, table->mask)];
 }
+
 /*
  * For secondary hash, net_hash_mix() is performed before calling
  * udp_hashslot2(), this explains difference with udp_hashslot()
@@ -91,7 +106,7 @@ static inline struct udp_hslot *udp_hashslot(struct udp_table *table,
 static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
 					      unsigned int hash)
 {
-	return &table->hash2[hash & table->mask];
+	return &table->hash2[hash & table->mask].hslot;
 }
 
 extern struct proto udp_prot;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 4b74a25d0b6e..2b7e72c4ed6d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -486,13 +486,12 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 		int sdif, struct udp_table *udptable, struct sk_buff *skb)
 {
 	unsigned short hnum = ntohs(dport);
-	unsigned int hash2, slot2;
 	struct udp_hslot *hslot2;
 	struct sock *result, *sk;
+	unsigned int hash2;
 
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
-	slot2 = hash2 & udptable->mask;
-	hslot2 = &udptable->hash2[slot2];
+	hslot2 = udp_hashslot2(udptable, hash2);
 
 	/* Lookup connected or non-wildcard socket */
 	result = udp4_lib_lookup2(net, saddr, sport,
@@ -519,8 +518,7 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 
 	/* Lookup wildcard sockets */
 	hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
-	slot2 = hash2 & udptable->mask;
-	hslot2 = &udptable->hash2[slot2];
+	hslot2 = udp_hashslot2(udptable, hash2);
 
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  htonl(INADDR_ANY), hnum, dif, sdif,
@@ -2266,7 +2264,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			    udptable->mask;
 		hash2 = ipv4_portaddr_hash(net, daddr, hnum) & udptable->mask;
 start_lookup:
-		hslot = &udptable->hash2[hash2];
+		hslot = &udptable->hash2[hash2].hslot;
 		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
 	}
 
@@ -2537,14 +2535,13 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 	struct udp_table *udptable = net->ipv4.udp_table;
 	INET_ADDR_COOKIE(acookie, rmt_addr, loc_addr);
 	unsigned short hnum = ntohs(loc_port);
-	unsigned int hash2, slot2;
 	struct udp_hslot *hslot2;
+	unsigned int hash2;
 	__portpair ports;
 	struct sock *sk;
 
 	hash2 = ipv4_portaddr_hash(net, loc_addr, hnum);
-	slot2 = hash2 & udptable->mask;
-	hslot2 = &udptable->hash2[slot2];
+	hslot2 = udp_hashslot2(udptable, hash2);
 	ports = INET_COMBINED_PORTS(rmt_port, hnum);
 
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
@@ -3185,7 +3182,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	batch_sks = 0;
 
 	for (; state->bucket <= udptable->mask; state->bucket++) {
-		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
+		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
 
 		if (hlist_empty(&hslot2->head))
 			continue;
@@ -3426,10 +3423,11 @@ __setup("uhash_entries=", set_uhash_entries);
 
 void __init udp_table_init(struct udp_table *table, const char *name)
 {
-	unsigned int i;
+	unsigned int i, slot_size;
 
+	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
 	table->hash = alloc_large_system_hash(name,
-					      2 * sizeof(struct udp_hslot),
+					      slot_size,
 					      uhash_entries,
 					      21, /* one slot per 2 MB */
 					      0,
@@ -3438,16 +3436,17 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 					      UDP_HTABLE_SIZE_MIN,
 					      UDP_HTABLE_SIZE_MAX);
 
-	table->hash2 = table->hash + (table->mask + 1);
+	table->hash2 = (void *)(table->hash + (table->mask + 1));
 	for (i = 0; i <= table->mask; i++) {
 		INIT_HLIST_HEAD(&table->hash[i].head);
 		table->hash[i].count = 0;
 		spin_lock_init(&table->hash[i].lock);
 	}
 	for (i = 0; i <= table->mask; i++) {
-		INIT_HLIST_HEAD(&table->hash2[i].head);
-		table->hash2[i].count = 0;
-		spin_lock_init(&table->hash2[i].lock);
+		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
+		table->hash2[i].hslot.count = 0;
+		spin_lock_init(&table->hash2[i].hslot.lock);
+		table->hash2[i].hash4_cnt = 0;
 	}
 }
 
@@ -3474,18 +3473,20 @@ static void __net_init udp_sysctl_init(struct net *net)
 static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_entries)
 {
 	struct udp_table *udptable;
+	unsigned int slot_size;
 	int i;
 
 	udptable = kmalloc(sizeof(*udptable), GFP_KERNEL);
 	if (!udptable)
 		goto out;
 
-	udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot),
+	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
+	udptable->hash = vmalloc_huge(hash_entries * slot_size,
 				      GFP_KERNEL_ACCOUNT);
 	if (!udptable->hash)
 		goto free_table;
 
-	udptable->hash2 = udptable->hash + hash_entries;
+	udptable->hash2 = (void *)(udptable->hash + hash_entries);
 	udptable->mask = hash_entries - 1;
 	udptable->log = ilog2(hash_entries);
 
@@ -3494,9 +3495,10 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 		udptable->hash[i].count = 0;
 		spin_lock_init(&udptable->hash[i].lock);
 
-		INIT_HLIST_HEAD(&udptable->hash2[i].head);
-		udptable->hash2[i].count = 0;
-		spin_lock_init(&udptable->hash2[i].lock);
+		INIT_HLIST_HEAD(&udptable->hash2[i].hslot.head);
+		udptable->hash2[i].hslot.count = 0;
+		spin_lock_init(&udptable->hash2[i].hslot.lock);
+		udptable->hash2[i].hash4_cnt = 0;
 	}
 
 	return udptable;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 52dfbb2ff1a8..bbf3352213c4 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -224,13 +224,12 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 			       struct sk_buff *skb)
 {
 	unsigned short hnum = ntohs(dport);
-	unsigned int hash2, slot2;
 	struct udp_hslot *hslot2;
 	struct sock *result, *sk;
+	unsigned int hash2;
 
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
-	slot2 = hash2 & udptable->mask;
-	hslot2 = &udptable->hash2[slot2];
+	hslot2 = udp_hashslot2(udptable, hash2);
 
 	/* Lookup connected or non-wildcard sockets */
 	result = udp6_lib_lookup2(net, saddr, sport,
@@ -257,8 +256,7 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 
 	/* Lookup wildcard sockets */
 	hash2 = ipv6_portaddr_hash(net, &in6addr_any, hnum);
-	slot2 = hash2 & udptable->mask;
-	hslot2 = &udptable->hash2[slot2];
+	hslot2 = udp_hashslot2(udptable, hash2);
 
 	result = udp6_lib_lookup2(net, saddr, sport,
 				  &in6addr_any, hnum, dif, sdif,
@@ -859,7 +857,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			    udptable->mask;
 		hash2 = ipv6_portaddr_hash(net, daddr, hnum) & udptable->mask;
 start_lookup:
-		hslot = &udptable->hash2[hash2];
+		hslot = &udptable->hash2[hash2].hslot;
 		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
 	}
 
@@ -1065,14 +1063,13 @@ static struct sock *__udp6_lib_demux_lookup(struct net *net,
 {
 	struct udp_table *udptable = net->ipv4.udp_table;
 	unsigned short hnum = ntohs(loc_port);
-	unsigned int hash2, slot2;
 	struct udp_hslot *hslot2;
+	unsigned int hash2;
 	__portpair ports;
 	struct sock *sk;
 
 	hash2 = ipv6_portaddr_hash(net, loc_addr, hnum);
-	slot2 = hash2 & udptable->mask;
-	hslot2 = &udptable->hash2[slot2];
+	hslot2 = udp_hashslot2(udptable, hash2);
 	ports = INET_COMBINED_PORTS(rmt_port, hnum);
 
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-- 
2.32.0.3.g01195cf9f


