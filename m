Return-Path: <netdev+bounces-141956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1CB9BCC72
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DAD1C228C4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733FF1D618C;
	Tue,  5 Nov 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sNHIoNCM"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521951D5143;
	Tue,  5 Nov 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808762; cv=none; b=i21lcPrbxOECNil8Wj1meJ8/22yDfS4qAApCPkuyKS+S77h2xNYEOKjetwCKj+QzzdT4YBnEa9Ngw4OPVND87riVB+copShlkkVqz6VtxwYSf1XC7qag4UZLQVDxiqIBi7NIwOk8ki77tiFbv8wKz3OeIgfPEex6gFulroKvxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808762; c=relaxed/simple;
	bh=GvbWA5r4eOIL45+/OUMg0w4SDzzspi9GyZ0/eCU8jGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mI4Pq6D+6p/gPOuDwy9IhACJIXYV+ZXsR/hifI/dUussqoIsjTQWoQtPMhMOYSy73gbs4qmHlqf96fNPOskGWwQDHOX+46orClzzG0bnugGn63QbB2pQQ+sfMTLdRVagXxxARGNibLug1QRJ0409Cjtgc7oN8dtdap9tsxJu6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sNHIoNCM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730808750; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8y9G5MesFX0rC8FlO2JP1b7rV6EAhkIsZWnRadnk3q0=;
	b=sNHIoNCM/FJmI5v9vT9frKMdNP5yFENTcOmpH4XNz8l+wd4Sr6pH+PKW2+HvzRTr2z0hniOEuR3964q/HlMqzNwYXaz6K5/fRovwQSMIYESxTlV5tEGNklHYjBeEZ/DDHR8pOwiOX60Py+0GMlN/IZxKgX27ZeuUm+33xiFDxo4=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WImxzFN_1730808749 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 20:12:30 +0800
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
Subject: [PATCH v7 net-next 3/4] ipv4/udp: Add 4-tuple hash for connected socket
Date: Tue,  5 Nov 2024 20:12:24 +0800
Message-Id: <20241105121225.12513-4-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241105121225.12513-1-lulie@linux.alibaba.com>
References: <20241105121225.12513-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the udp_table has two hash table, the port hash and portaddr
hash. Usually for UDP servers, all sockets have the same local port and
addr, so they are all on the same hash slot within a reuseport group.

In some applications, UDP servers use connect() to manage clients. In
particular, when firstly receiving from an unseen 4 tuple, a new socket
is created and connect()ed to the remote addr:port, and then the fd is
used exclusively by the client.

Once there are connected sks in a reuseport group, udp has to score all
sks in the same hash2 slot to find the best match. This could be
inefficient with a large number of connections, resulting in high
softirq overhead.

To solve the problem, this patch implement 4-tuple hash for connected
udp sockets. During connect(), hash4 slot is updated, as well as a
corresponding counter, hash4_cnt, in hslot2. In __udp4_lib_lookup(),
hslot4 will be searched firstly if the counter is non-zero. Otherwise,
hslot2 is used like before. Note that only connected sockets enter this
hash4 path, while un-connected ones are not affected.

hlist_nulls is used for hash4, because we probably move to another hslot
wrongly when lookup with concurrent rehash. Then we check nulls at the
list end to see if we should restart lookup. Because udp does not use
SLAB_TYPESAFE_BY_RCU, we don't need to touch sk_refcnt when lookup.

Stress test results (with 1 cpu fully used) are shown below, in pps:
(1) _un-connected_ socket as server
    [a] w/o hash4: 1,825176
    [b] w/  hash4: 1,831750 (+0.36%)

(2) 500 _connected_ sockets as server
    [c] w/o hash4:   290860 (only 16% of [a])
    [d] w/  hash4: 1,889658 (+3.1% compared with [b])

With hash4, compute_score is skipped when lookup, so [d] is slightly
better than [b].

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
---
 include/net/udp.h |  15 +++-
 net/ipv4/udp.c    | 185 +++++++++++++++++++++++++++++++++++++++++++++-
 net/ipv6/udp.c    |   2 +-
 3 files changed, 197 insertions(+), 5 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 23a1a8198e166..6bfdd345e5f4b 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -301,13 +301,26 @@ static inline int udp_lib_hash(struct sock *sk)
 }
 
 void udp_lib_unhash(struct sock *sk);
-void udp_lib_rehash(struct sock *sk, u16 new_hash);
+void udp_lib_rehash(struct sock *sk, u16 new_hash, u16 new_hash4);
 
 static inline void udp_lib_close(struct sock *sk, long timeout)
 {
 	sk_common_release(sk);
 }
 
+/* hash4 routines shared between UDPv4/6 */
+#if IS_ENABLED(CONFIG_BASE_SMALL)
+static inline void udp_lib_hash4(struct sock *sk, u16 hash)
+{
+}
+static inline void udp4_hash4(struct sock *sk)
+{
+}
+#else /* !CONFIG_BASE_SMALL */
+void udp_lib_hash4(struct sock *sk, u16 hash);
+void udp4_hash4(struct sock *sk);
+#endif /* CONFIG_BASE_SMALL */
+
 int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		     unsigned int hash2_nulladdr);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0bc0881d6569a..799e86c6ee840 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -478,6 +478,149 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 	return result;
 }
 
+#if IS_ENABLED(CONFIG_BASE_SMALL)
+static struct sock *udp4_lib_lookup4(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     struct udp_table *udptable)
+{
+	return NULL;
+}
+
+static void udp_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
+{
+}
+
+static void udp_unhash4(struct udp_table *udptable, struct sock *sk)
+{
+}
+#else /* !CONFIG_BASE_SMALL */
+static struct sock *udp4_lib_lookup4(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     struct udp_table *udptable)
+{
+	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
+	const struct hlist_nulls_node *node;
+	struct udp_hslot *hslot4;
+	unsigned int hash4, slot;
+	struct udp_sock *up;
+	struct sock *sk;
+
+	hash4 = udp_ehashfn(net, daddr, hnum, saddr, sport);
+	slot = hash4 & udptable->mask;
+	hslot4 = &udptable->hash4[slot];
+	INET_ADDR_COOKIE(acookie, saddr, daddr);
+
+begin:
+	/* Because SLAB_TYPESAFE_BY_RCU is not used, we don't need to touch sk_refcnt. */
+	udp_lrpa_for_each_entry_rcu(up, node, &hslot4->nulls_head) {
+		sk = (struct sock *)up;
+		if (inet_match(net, sk, acookie, ports, dif, sdif))
+			return sk;
+	}
+
+	/* if the nulls value we got at the end of this lookup is not the expected one, we must
+	 * restart lookup. We probably met an item that was moved to another chain due to rehash.
+	 */
+	if (get_nulls_value(node) != slot)
+		goto begin;
+
+	return NULL;
+}
+
+/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
+static void udp_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
+{
+	struct udp_hslot *hslot4, *nhslot4;
+
+	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
+	nhslot4 = udp_hashslot4(udptable, newhash4);
+	udp_sk(sk)->udp_lrpa_hash = newhash4;
+
+	if (hslot4 != nhslot4) {
+		spin_lock_bh(&hslot4->lock);
+		hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
+		hslot4->count--;
+		spin_unlock_bh(&hslot4->lock);
+
+		spin_lock_bh(&nhslot4->lock);
+		hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->nulls_head);
+		nhslot4->count++;
+		spin_unlock_bh(&nhslot4->lock);
+	}
+}
+
+static void udp_unhash4(struct udp_table *udptable, struct sock *sk)
+{
+	struct udp_hslot *hslot2, *hslot4;
+
+	if (udp_hashed4(sk)) {
+		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
+		hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
+
+		spin_lock(&hslot4->lock);
+		hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
+		hslot4->count--;
+		spin_unlock(&hslot4->lock);
+
+		spin_lock(&hslot2->lock);
+		udp_hash4_dec(hslot2);
+		spin_unlock(&hslot2->lock);
+	}
+}
+
+void udp_lib_hash4(struct sock *sk, u16 hash)
+{
+	struct udp_hslot *hslot, *hslot2, *hslot4;
+	struct net *net = sock_net(sk);
+	struct udp_table *udptable;
+
+	/* Connected udp socket can re-connect to another remote address, so rehash4 is needed. */
+	udptable = net->ipv4.udp_table;
+	if (udp_hashed4(sk)) {
+		udp_rehash4(udptable, sk, hash);
+		return;
+	}
+
+	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
+	hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
+	hslot4 = udp_hashslot4(udptable, hash);
+	udp_sk(sk)->udp_lrpa_hash = hash;
+
+	spin_lock_bh(&hslot->lock);
+	if (rcu_access_pointer(sk->sk_reuseport_cb))
+		reuseport_detach_sock(sk);
+
+	spin_lock(&hslot4->lock);
+	hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &hslot4->nulls_head);
+	hslot4->count++;
+	spin_unlock(&hslot4->lock);
+
+	spin_lock(&hslot2->lock);
+	udp_hash4_inc(hslot2);
+	spin_unlock(&hslot2->lock);
+
+	spin_unlock_bh(&hslot->lock);
+}
+
+/* call with sock lock */
+void udp4_hash4(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	unsigned int hash;
+
+	if (sk_unhashed(sk) || sk->sk_rcv_saddr == htonl(INADDR_ANY))
+		return;
+
+	hash = udp_ehashfn(net, sk->sk_rcv_saddr, sk->sk_num, sk->sk_daddr, sk->sk_dport);
+
+	udp_lib_hash4(sk, hash);
+}
+#endif /* CONFIG_BASE_SMALL */
+
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
@@ -493,6 +636,12 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	hslot2 = udp_hashslot2(udptable, hash2);
 
+	if (udp_has_hash4(hslot2)) {
+		result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum, dif, sdif, udptable);
+		if (result) /* udp4_lib_lookup4 return sk or NULL */
+			return result;
+	}
+
 	/* Lookup connected or non-wildcard socket */
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
@@ -1933,6 +2082,18 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
+static int udp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+{
+	int res;
+
+	lock_sock(sk);
+	res = __ip4_datagram_connect(sk, uaddr, addr_len);
+	if (!res)
+		udp4_hash4(sk);
+	release_sock(sk);
+	return res;
+}
+
 int __udp_disconnect(struct sock *sk, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -1992,6 +2153,8 @@ void udp_lib_unhash(struct sock *sk)
 			hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
 			hslot2->count--;
 			spin_unlock(&hslot2->lock);
+
+			udp_unhash4(udptable, sk);
 		}
 		spin_unlock_bh(&hslot->lock);
 	}
@@ -2001,7 +2164,7 @@ EXPORT_SYMBOL(udp_lib_unhash);
 /*
  * inet_rcv_saddr was changed, we must rehash secondary hash
  */
-void udp_lib_rehash(struct sock *sk, u16 newhash)
+void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 {
 	if (sk_hashed(sk)) {
 		struct udp_table *udptable = udp_get_table_prot(sk);
@@ -2033,6 +2196,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
 				spin_unlock(&nhslot2->lock);
 			}
 
+			if (udp_hashed4(sk)) {
+				udp_rehash4(udptable, sk, newhash4);
+
+				if (hslot2 != nhslot2) {
+					spin_lock(&hslot2->lock);
+					udp_hash4_dec(hslot2);
+					spin_unlock(&hslot2->lock);
+
+					spin_lock(&nhslot2->lock);
+					udp_hash4_inc(nhslot2);
+					spin_unlock(&nhslot2->lock);
+				}
+			}
 			spin_unlock_bh(&hslot->lock);
 		}
 	}
@@ -2044,7 +2220,10 @@ void udp_v4_rehash(struct sock *sk)
 	u16 new_hash = ipv4_portaddr_hash(sock_net(sk),
 					  inet_sk(sk)->inet_rcv_saddr,
 					  inet_sk(sk)->inet_num);
-	udp_lib_rehash(sk, new_hash);
+	u16 new_hash4 = udp_ehashfn(sock_net(sk), sk->sk_rcv_saddr, sk->sk_num,
+				    sk->sk_daddr, sk->sk_dport);
+
+	udp_lib_rehash(sk, new_hash, new_hash4);
 }
 
 static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
@@ -2937,7 +3116,7 @@ struct proto udp_prot = {
 	.owner			= THIS_MODULE,
 	.close			= udp_lib_close,
 	.pre_connect		= udp_pre_connect,
-	.connect		= ip4_datagram_connect,
+	.connect		= udp_connect,
 	.disconnect		= udp_disconnect,
 	.ioctl			= udp_ioctl,
 	.init			= udp_init_sock,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0d7aac9d44e59..1ea99d704e31a 100644
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


