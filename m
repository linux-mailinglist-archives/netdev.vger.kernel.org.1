Return-Path: <netdev+bounces-128073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249D5977CFA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EE81F28071
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81DC1D7E37;
	Fri, 13 Sep 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GleGUMva"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671C1BD00C;
	Fri, 13 Sep 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222195; cv=none; b=fxxghVX9r/z4xreDWcWiogYunsmzCVBXDUy4UlZRJ9ICLPKkNLi/+TFPsbQslyHd0kg2xUKTr6+lIDauSBk1y3xRkHkAfRyuKi/6Lw/6txayeVsRArtolMg3nIhd6tgXz7Zzk3zSOG5nx2eUhCahVFsO2jLgh74r88vCHHUvOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222195; c=relaxed/simple;
	bh=5NL6uJk5LsiQIDKXPQWx1qh9J00FQM8sUX7ubiq7xEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MwxG23g2H/c3UGr4FxQponbrlwjRHgIuMtBSANQ5ZTnrY5BGGZuzhN8Z/Et3UoqPFrVOGuXEmiSmkm5feWxYsnoGXNAuJNy9xYT6hulWLSWbD7eGu9q3kkIGbWVAvEHkat9xzrezRRGksU8fJQDtX9RShtSf3TXX+6q6SkMRTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GleGUMva; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726222183; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EzddndEhDLh4njeVTOgqDCB9YBh4kB/8IqneKpFCkv8=;
	b=GleGUMvanjiPIkTE2xDa3V4NOzsHCHTyI3brDCi+EYcQYUHOotByGQaQXeQAIOBd+4vXnMiXyH5dDB1TvQlyTgLwPD1r2qMKxSWahSx8e2qfUsIBOK7WLGgHU7cJpdJmJDN8lrnb8biqDhvHeVTqT0UPSMOVnSqRoEtJuiTQ6iI=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEueUUv_1726222181)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 18:09:42 +0800
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
	jakub@cloudflare.com
Subject: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected socket
Date: Fri, 13 Sep 2024 18:09:41 +0800
Message-Id: <20240913100941.8565-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch introduces 4-tuple hash for connected udp sockets, to
make udp lookup faster. It is a tentative proposal and any comment is
welcome.

Currently, the udp_table has two hash table, the port hash and portaddr
hash. But for UDP server, all sockets have the same local port and addr,
so they are all on the same hash slot within a reuseport group. And the
target sock is selected by scoring.

In some applications, the UDP server uses connect() for each incoming
client, and then the socket (fd) is used exclusively by the client. In
such scenarios, current scoring method can be ineffcient with a large
number of connections, resulting in high softirq overhead.

To solve the problem, a 4-tuple hash list is added to udp_table, and is
updated when calling connect(). Then __udp4_lib_lookup() firstly
searches the 4-tuple hash list, and return directly if success. A new
sockopt UDP_HASH4 is added to enable it. So the usage is:
1. socket()
2. bind()
3. setsockopt(UDP_HASH4)
4. connect()

AFAICT the patch (if useful) can be further improved by:
(a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
once turned on until the socket closed.
(b) Better interact with hash2/reuseport. Now hash4 hardly affects other
mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
unnecessary.
(c) Support early demux and ipv6.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/linux/udp.h      |   8 +++
 include/net/udp.h        |  17 +++++-
 include/uapi/linux/udp.h |   1 +
 net/ipv4/udp.c           | 127 +++++++++++++++++++++++++++++++++++++--
 net/ipv6/udp.c           |   2 +-
 5 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3eb3f2b9a2a0..c7b28e52fc49 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -42,6 +42,7 @@ enum {
 	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
 	UDP_FLAGS_UDPLITE_SEND_CC, /* set via udplite setsockopt */
 	UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
+	UDP_FLAGS_HASH4_ENABLED, /* Use 4-tuple hash */
 };
 
 struct udp_sock {
@@ -56,6 +57,10 @@ struct udp_sock {
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
+	/* For UDP 4-tuple hash */
+	__u16 udp_lrpa_hash;
+	struct hlist_node udp_lrpa_node;
+
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
@@ -206,6 +211,9 @@ static inline void udp_allow_gso(struct sock *sk)
 #define udp_portaddr_for_each_entry_rcu(__sk, list) \
 	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
 
+#define udp_lrpa_for_each_entry_rcu(__up, list) \
+	hlist_for_each_entry_rcu(__up, list, udp_lrpa_node)
+
 #define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
 
 #endif	/* _LINUX_UDP_H */
diff --git a/include/net/udp.h b/include/net/udp.h
index 61222545ab1c..a05d79d35fbb 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -67,12 +67,15 @@ struct udp_hslot {
  *
  *	@hash:	hash table, sockets are hashed on (local port)
  *	@hash2:	hash table, sockets are hashed on (local port, local address)
+ *	@hash4:	hash table, sockets are hashed on
+ *		(local port, local address, remote port, remote address)
  *	@mask:	number of slots in hash tables, minus 1
  *	@log:	log2(number of slots in hash table)
  */
 struct udp_table {
 	struct udp_hslot	*hash;
 	struct udp_hslot	*hash2;
+	struct udp_hslot	*hash4;
 	unsigned int		mask;
 	unsigned int		log;
 };
@@ -94,6 +97,17 @@ static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
 	return &table->hash2[hash & table->mask];
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
@@ -193,7 +207,7 @@ static inline int udp_lib_hash(struct sock *sk)
 }
 
 void udp_lib_unhash(struct sock *sk);
-void udp_lib_rehash(struct sock *sk, u16 new_hash);
+void udp_lib_rehash(struct sock *sk, u16 new_hash, u16 new_hash4);
 
 static inline void udp_lib_close(struct sock *sk, long timeout)
 {
@@ -286,6 +300,7 @@ int udp_rcv(struct sk_buff *skb);
 int udp_ioctl(struct sock *sk, int cmd, int *karg);
 int udp_init_sock(struct sock *sk);
 int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int udp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int __udp_disconnect(struct sock *sk, int flags);
 int udp_disconnect(struct sock *sk, int flags);
 __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait);
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 1a0fe8b151fb..5b9ecbbec144 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -34,6 +34,7 @@ struct udphdr {
 #define UDP_NO_CHECK6_RX 102	/* Disable accpeting checksum for UDP6 */
 #define UDP_SEGMENT	103	/* Set GSO segmentation size */
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
+#define UDP_HASH4	105	/* Enable 4-tuple hash with connect() */
 
 /* UDP encapsulation types */
 #define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8accbf4cb295..aac0251ff6fa 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -478,6 +478,27 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 	return result;
 }
 
+static struct sock *udp4_lib_lookup4(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     struct udp_table *udptable)
+{
+	unsigned int hash4 = udp_ehashfn(net, daddr, hnum, saddr, sport);
+	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
+	struct udp_hslot *hslot4 = udp_hashslot4(udptable, hash4);
+	struct udp_sock *up;
+	struct sock *sk;
+
+	INET_ADDR_COOKIE(acookie, saddr, daddr);
+	udp_lrpa_for_each_entry_rcu(up, &hslot4->head) {
+		sk = (struct sock *)up;
+		if (inet_match(net, sk, acookie, ports, dif, sdif))
+			return sk;
+	}
+	return NULL;
+}
+
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
@@ -490,6 +511,10 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 	struct udp_hslot *hslot2;
 	struct sock *result, *sk;
 
+	result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum, dif, sdif, udptable);
+	if (result)
+		return result;
+
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	slot2 = hash2 & udptable->mask;
 	hslot2 = &udptable->hash2[slot2];
@@ -1933,6 +1958,51 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
+/* call with sock lock */
+static void udp4_hash4(struct sock *sk)
+{
+	struct udp_hslot *hslot, *hslot4;
+	struct net *net = sock_net(sk);
+	struct udp_table *udptable;
+	unsigned int hash;
+
+	if (sk_unhashed(sk) || udp_hashed4(sk) ||
+	    inet_sk(sk)->inet_rcv_saddr == htonl(INADDR_ANY))
+		return;
+
+	hash = udp_ehashfn(net, inet_sk(sk)->inet_rcv_saddr, inet_sk(sk)->inet_num,
+			   inet_sk(sk)->inet_daddr, inet_sk(sk)->inet_dport);
+
+	udptable = net->ipv4.udp_table;
+	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
+	hslot4 = udp_hashslot4(udptable, hash);
+	udp_sk(sk)->udp_lrpa_hash = hash;
+
+	spin_lock_bh(&hslot->lock);
+	if (rcu_access_pointer(sk->sk_reuseport_cb))
+		reuseport_detach_sock(sk);
+
+	spin_lock(&hslot4->lock);
+	hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &hslot4->head);
+	hslot4->count++;
+	spin_unlock(&hslot4->lock);
+
+	spin_unlock_bh(&hslot->lock);
+}
+
+int udp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+{
+	int res;
+
+	lock_sock(sk);
+	res = __ip4_datagram_connect(sk, uaddr, addr_len);
+	if (!res && udp_test_bit(HASH4_ENABLED, sk))
+		udp4_hash4(sk);
+	release_sock(sk);
+	return res;
+}
+EXPORT_SYMBOL(udp_connect);
+
 int __udp_disconnect(struct sock *sk, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -1974,7 +2044,7 @@ void udp_lib_unhash(struct sock *sk)
 {
 	if (sk_hashed(sk)) {
 		struct udp_table *udptable = udp_get_table_prot(sk);
-		struct udp_hslot *hslot, *hslot2;
+		struct udp_hslot *hslot, *hslot2, *hslot4;
 
 		hslot  = udp_hashslot(udptable, sock_net(sk),
 				      udp_sk(sk)->udp_port_hash);
@@ -1992,6 +2062,14 @@ void udp_lib_unhash(struct sock *sk)
 			hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
 			hslot2->count--;
 			spin_unlock(&hslot2->lock);
+
+			if (udp_hashed4(sk)) {
+				hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
+				spin_lock(&hslot4->lock);
+				hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
+				hslot4->count--;
+				spin_unlock(&hslot4->lock);
+			}
 		}
 		spin_unlock_bh(&hslot->lock);
 	}
@@ -2001,16 +2079,20 @@ EXPORT_SYMBOL(udp_lib_unhash);
 /*
  * inet_rcv_saddr was changed, we must rehash secondary hash
  */
-void udp_lib_rehash(struct sock *sk, u16 newhash)
+void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 {
 	if (sk_hashed(sk)) {
+		struct udp_hslot *hslot, *hslot2, *nhslot2, *hslot4, *nhslot4;
 		struct udp_table *udptable = udp_get_table_prot(sk);
-		struct udp_hslot *hslot, *hslot2, *nhslot2;
 
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 		nhslot2 = udp_hashslot2(udptable, newhash);
 		udp_sk(sk)->udp_portaddr_hash = newhash;
 
+		hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
+		nhslot4 = udp_hashslot4(udptable, newhash4);
+		udp_sk(sk)->udp_lrpa_hash = newhash4;
+
 		if (hslot2 != nhslot2 ||
 		    rcu_access_pointer(sk->sk_reuseport_cb)) {
 			hslot = udp_hashslot(udptable, sock_net(sk),
@@ -2033,6 +2115,18 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
 				spin_unlock(&nhslot2->lock);
 			}
 
+			if (udp_hashed4(sk) && hslot4 != nhslot4) {
+				spin_lock(&hslot4->lock);
+				hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
+				hslot4->count--;
+				spin_unlock(&hslot4->lock);
+
+				spin_lock(&nhslot4->lock);
+				hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
+				nhslot4->count++;
+				spin_unlock(&nhslot4->lock);
+			}
+
 			spin_unlock_bh(&hslot->lock);
 		}
 	}
@@ -2044,7 +2138,10 @@ void udp_v4_rehash(struct sock *sk)
 	u16 new_hash = ipv4_portaddr_hash(sock_net(sk),
 					  inet_sk(sk)->inet_rcv_saddr,
 					  inet_sk(sk)->inet_num);
-	udp_lib_rehash(sk, new_hash);
+	u16 new_hash4 = udp_ehashfn(sock_net(sk),
+				    inet_sk(sk)->inet_rcv_saddr, inet_sk(sk)->inet_num,
+				    inet_sk(sk)->inet_daddr, inet_sk(sk)->inet_dport);
+	udp_lib_rehash(sk, new_hash, new_hash4);
 }
 
 static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
@@ -2757,6 +2854,14 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		udp_assign_bit(ACCEPT_L4, sk, valbool);
 		set_xfrm_gro_udp_encap_rcv(up->encap_type, sk->sk_family, sk);
 		break;
+	case UDP_HASH4:
+		/* Currently, reset HASH4_ENABLED is not supported */
+		if (!valbool && udp_test_bit(HASH4_ENABLED, sk))
+			return -EPERM;
+
+		if (valbool && !udp_test_bit(HASH4_ENABLED, sk))
+			udp_set_bit(HASH4_ENABLED, sk);
+		break;
 
 	/*
 	 * 	UDP-Lite's partial checksum coverage (RFC 3828).
@@ -2846,6 +2951,10 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		val = udp_test_bit(GRO_ENABLED, sk);
 		break;
 
+	case UDP_HASH4:
+		val = udp_test_bit(HASH4_ENABLED, sk);
+		break;
+
 	/* The following two cannot be changed on UDP sockets, the return is
 	 * always 0 (which corresponds to the full checksum coverage of UDP). */
 	case UDPLITE_SEND_CSCOV:
@@ -2938,7 +3047,7 @@ struct proto udp_prot = {
 	.owner			= THIS_MODULE,
 	.close			= udp_lib_close,
 	.pre_connect		= udp_pre_connect,
-	.connect		= ip4_datagram_connect,
+	.connect		= udp_connect,
 	.disconnect		= udp_disconnect,
 	.ioctl			= udp_ioctl,
 	.init			= udp_init_sock,
@@ -3429,7 +3538,7 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 	unsigned int i;
 
 	table->hash = alloc_large_system_hash(name,
-					      2 * sizeof(struct udp_hslot),
+					      3 * sizeof(struct udp_hslot),
 					      uhash_entries,
 					      21, /* one slot per 2 MB */
 					      0,
@@ -3449,6 +3558,12 @@ void __init udp_table_init(struct udp_table *table, const char *name)
 		table->hash2[i].count = 0;
 		spin_lock_init(&table->hash2[i].lock);
 	}
+	table->hash4 = table->hash2 + (table->mask + 1);
+	for (i = 0; i <= table->mask; i++) {
+		INIT_HLIST_HEAD(&table->hash4[i].head);
+		table->hash4[i].count = 0;
+		spin_lock_init(&table->hash4[i].lock);
+	}
 }
 
 u32 udp_flow_hashrnd(void)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 52dfbb2ff1a8..47659381222d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -111,7 +111,7 @@ void udp_v6_rehash(struct sock *sk)
 					  &sk->sk_v6_rcv_saddr,
 					  inet_sk(sk)->inet_num);
 
-	udp_lib_rehash(sk, new_hash);
+	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */
 }
 
 static int compute_score(struct sock *sk, const struct net *net,
-- 
2.32.0.3.g01195cf9f


