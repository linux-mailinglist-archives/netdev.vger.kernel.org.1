Return-Path: <netdev+bounces-144832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FDB9C88D1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47C3B2D455
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8E1F9431;
	Thu, 14 Nov 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HW8TwBE4"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8D1F8F18;
	Thu, 14 Nov 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581544; cv=none; b=ik1+oDuK7M7BCUXrwcQY9wqudgewL+Uni4dVV5JxVZtdaGS3uttHIuGW+36zg9QoBuqLpA78NRgvuC8JOtpOPgCvtEztce4AOqa0mopbe+ll4lxhzfkPKvV9797VUR2LaKNATDkyqhoZKn76h+WjdsjM/yUYYzSTmwkzOpmTHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581544; c=relaxed/simple;
	bh=HG0AW14VPCiey1EupX1B0LRzP4uyJFGDdIoAWz1S/iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/8EGel8N5E4tlZAYZAOqs0E9ZIz5mUYpkN8gy0/jIRAGersesseH7u6CjTcfBI+PYUvYk+oBdw9hSCRtLNX6LyrqvtbdtL65q0Trv16UH8uXa0s8GyVTGlikyp0XgInGkZAybz3RYIyComeLUMnoApXBI8C+OBxdYoPlyOU8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HW8TwBE4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731581533; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QDFQX78eU8LtaIZh/3Oxzzaa/awbPR/WDgtjUwJbNEU=;
	b=HW8TwBE49BeyrzlihW3qbC+p971Q+hZw5h+WFTe+mjIxezPaqEzC2YZtdzfroB0aqEQg0z/esAqN4qMBeFZwZk/sMIOUDSAXuQEeEidq1QF577a7sGD72mjZjWNoEfrlGlq89o7zH+Nd289czdYrkVFi0L+FJQe+DVsrZjPZE3s=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WJONEk8_1731581530 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 18:52:11 +0800
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
Subject: [PATCH v9 net-next 3/4] ipv4/udp: Add 4-tuple hash for connected socket
Date: Thu, 14 Nov 2024 18:52:06 +0800
Message-Id: <20241114105207.30185-4-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241114105207.30185-1-lulie@linux.alibaba.com>
References: <20241114105207.30185-1-lulie@linux.alibaba.com>
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

Co-developed-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Co-developed-by: Fred Chen <fred.cc@alibaba-inc.com>
Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
Co-developed-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/udp.h |  16 +++-
 net/ipv4/udp.c    | 197 +++++++++++++++++++++++++++++++++++++++++++++-
 net/ipv6/udp.c    |   2 +-
 3 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index edb669967130..feb06c0e48fb 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -302,13 +302,27 @@ static inline int udp_lib_hash(struct sock *sk)
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
+
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
index 0bc0881d6569..b6c5edd7ff48 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -478,6 +478,159 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
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
+static void udp_rehash4(struct udp_table *udptable, struct sock *sk,
+			u16 newhash4)
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
+	/* SLAB_TYPESAFE_BY_RCU not used, so we don't need to touch sk_refcnt */
+	udp_lrpa_for_each_entry_rcu(up, node, &hslot4->nulls_head) {
+		sk = (struct sock *)up;
+		if (inet_match(net, sk, acookie, ports, dif, sdif))
+			return sk;
+	}
+
+	/* if the nulls value we got at the end of this lookup is not the
+	 * expected one, we must restart lookup. We probably met an item that
+	 * was moved to another chain due to rehash.
+	 */
+	if (get_nulls_value(node) != slot)
+		goto begin;
+
+	return NULL;
+}
+
+/* In hash4, rehash can happen in connect(), where hash4_cnt keeps unchanged. */
+static void udp_rehash4(struct udp_table *udptable, struct sock *sk,
+			u16 newhash4)
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
+		hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
+					 &nhslot4->nulls_head);
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
+	/* Connected udp socket can re-connect to another remote address,
+	 * so rehash4 is needed.
+	 */
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
+	hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
+				 &hslot4->nulls_head);
+	hslot4->count++;
+	spin_unlock(&hslot4->lock);
+
+	spin_lock(&hslot2->lock);
+	udp_hash4_inc(hslot2);
+	spin_unlock(&hslot2->lock);
+
+	spin_unlock_bh(&hslot->lock);
+}
+EXPORT_SYMBOL(udp_lib_hash4);
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
+	hash = udp_ehashfn(net, sk->sk_rcv_saddr, sk->sk_num,
+			   sk->sk_daddr, sk->sk_dport);
+
+	udp_lib_hash4(sk, hash);
+}
+EXPORT_SYMBOL(udp4_hash4);
+#endif /* CONFIG_BASE_SMALL */
+
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
@@ -493,6 +646,13 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	hslot2 = udp_hashslot2(udptable, hash2);
 
+	if (udp_has_hash4(hslot2)) {
+		result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum,
+					  dif, sdif, udptable);
+		if (result) /* udp4_lib_lookup4 return sk or NULL */
+			return result;
+	}
+
 	/* Lookup connected or non-wildcard socket */
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
@@ -1933,6 +2093,18 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
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
@@ -1992,6 +2164,8 @@ void udp_lib_unhash(struct sock *sk)
 			hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
 			hslot2->count--;
 			spin_unlock(&hslot2->lock);
+
+			udp_unhash4(udptable, sk);
 		}
 		spin_unlock_bh(&hslot->lock);
 	}
@@ -2001,7 +2175,7 @@ EXPORT_SYMBOL(udp_lib_unhash);
 /*
  * inet_rcv_saddr was changed, we must rehash secondary hash
  */
-void udp_lib_rehash(struct sock *sk, u16 newhash)
+void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 {
 	if (sk_hashed(sk)) {
 		struct udp_table *udptable = udp_get_table_prot(sk);
@@ -2033,6 +2207,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
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
@@ -2044,7 +2231,11 @@ void udp_v4_rehash(struct sock *sk)
 	u16 new_hash = ipv4_portaddr_hash(sock_net(sk),
 					  inet_sk(sk)->inet_rcv_saddr,
 					  inet_sk(sk)->inet_num);
-	udp_lib_rehash(sk, new_hash);
+	u16 new_hash4 = udp_ehashfn(sock_net(sk),
+				    sk->sk_rcv_saddr, sk->sk_num,
+				    sk->sk_daddr, sk->sk_dport);
+
+	udp_lib_rehash(sk, new_hash, new_hash4);
 }
 
 static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
@@ -2937,7 +3128,7 @@ struct proto udp_prot = {
 	.owner			= THIS_MODULE,
 	.close			= udp_lib_close,
 	.pre_connect		= udp_pre_connect,
-	.connect		= ip4_datagram_connect,
+	.connect		= udp_connect,
 	.disconnect		= udp_disconnect,
 	.ioctl			= udp_ioctl,
 	.init			= udp_init_sock,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0d7aac9d44e5..1ea99d704e31 100644
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


