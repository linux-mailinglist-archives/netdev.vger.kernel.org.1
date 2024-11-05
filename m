Return-Path: <netdev+bounces-141957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8649BCC74
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B451C22B36
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C11D63DD;
	Tue,  5 Nov 2024 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uomfTp9+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFB1D5ACD;
	Tue,  5 Nov 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808763; cv=none; b=rcs/0EFhZi/rJNmXCbMhjZayWNIZmtn283BTFQ+OAAR/t4pK4NkvomjZ5HnBmPJ1EtJgY6oOpxX9hzAh1Yfi+LFVCRgppWL1DFYHOnSgttUTL16CFDdwI2/DhYvaBLreG79tbmZsAY/UyeT7S1qUimtqo1hTewGlb7+haeAPYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808763; c=relaxed/simple;
	bh=DIdDpWQ3NxUoL9BIp1YJ2o81SaeGTZzDaBZQcMAS4u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DimJwGzVMqpdq+awb8PT5a9fr66Wz/0UbgWRdcxKXfvGmcw3VMLoHjVSAhzc6PbqoBtvrXSoXy8YKqyl71QdoK1uJEFNKCYx8XniJR27F+BsJNKq81fpOcu3/x97tETlXvXdUU1cANlU1brEzJYPq0rKiw4BsW9K7d5dPTZIATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uomfTp9+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730808751; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=koq6BF5HxqiNE8UJRaUUI4bs/YWKbJT05XVFTXK7hmY=;
	b=uomfTp9+W03LDRy58LCClhD98+KXRMsijvs/LplpQ2ZmYoYkLGPx/xplNHObIekGgc9CmRUncqC4QKgevNVDHw20QC66o4jwdtJSvC+4SWEuugvxVV64W/JiGMsjCcu78vBpeXVvghO5LUnckApKRXH1+vkeOf2ABdsTiiYrLSg=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WImyjWu_1730808750 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 20:12:31 +0800
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
Subject: [PATCH v7 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected socket
Date: Tue,  5 Nov 2024 20:12:25 +0800
Message-Id: <20241105121225.12513-5-lulie@linux.alibaba.com>
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

Implement ipv6 udp hash4 like that in ipv4. The major difference is that
the hash value should be calculated with udp6_ehashfn(). Besides,
ipv4-mapped ipv6 address is handled before hash() and rehash(). Export
udp_ehashfn because now we use it in udpv6 rehash.

Core procedures of hash/unhash/rehash are same as ipv4, and udpv4 and
udpv6 share the same udptable, so some functions in ipv4 hash4 can also
be shared.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
---
 include/net/udp.h |  2 +
 net/ipv4/udp.c    |  1 -
 net/ipv6/udp.c    | 96 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 6bfdd345e5f4b..2e9c1b4e3f392 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -302,6 +302,8 @@ static inline int udp_lib_hash(struct sock *sk)
 
 void udp_lib_unhash(struct sock *sk);
 void udp_lib_rehash(struct sock *sk, u16 new_hash, u16 new_hash4);
+u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
+		const __be32 faddr, const __be16 fport);
 
 static inline void udp_lib_close(struct sock *sk, long timeout)
 {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 799e86c6ee840..102d0502c9985 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -410,7 +410,6 @@ static int compute_score(struct sock *sk, const struct net *net,
 	return score;
 }
 
-INDIRECT_CALLABLE_SCOPE
 u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 		const __be32 faddr, const __be16 fport)
 {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 1ea99d704e31a..64f13f258fca3 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -110,8 +110,17 @@ void udp_v6_rehash(struct sock *sk)
 	u16 new_hash = ipv6_portaddr_hash(sock_net(sk),
 					  &sk->sk_v6_rcv_saddr,
 					  inet_sk(sk)->inet_num);
+	u16 new_hash4;
 
-	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */
+	if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)) {
+		new_hash4 = udp_ehashfn(sock_net(sk), sk->sk_rcv_saddr, sk->sk_num,
+					sk->sk_daddr, sk->sk_dport);
+	} else {
+		new_hash4 = udp6_ehashfn(sock_net(sk), &sk->sk_v6_rcv_saddr, sk->sk_num,
+					 &sk->sk_v6_daddr, sk->sk_dport);
+	}
+
+	udp_lib_rehash(sk, new_hash, new_hash4);
 }
 
 static int compute_score(struct sock *sk, const struct net *net,
@@ -216,6 +225,71 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 	return result;
 }
 
+#if IS_ENABLED(CONFIG_BASE_SMALL)
+static struct sock *udp6_lib_lookup4(const struct net *net,
+				     const struct in6_addr *saddr, __be16 sport,
+				     const struct in6_addr *daddr, unsigned int hnum,
+				     int dif, int sdif, struct udp_table *udptable)
+{
+	return NULL;
+}
+
+static void udp6_hash4(struct sock *sk)
+{
+}
+#else /* !CONFIG_BASE_SMALL */
+static struct sock *udp6_lib_lookup4(const struct net *net,
+				     const struct in6_addr *saddr, __be16 sport,
+				     const struct in6_addr *daddr, unsigned int hnum,
+				     int dif, int sdif, struct udp_table *udptable)
+{
+	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
+	const struct hlist_nulls_node *node;
+	struct udp_hslot *hslot4;
+	unsigned int hash4, slot;
+	struct udp_sock *up;
+	struct sock *sk;
+
+	hash4 = udp6_ehashfn(net, daddr, hnum, saddr, sport);
+	slot = hash4 & udptable->mask;
+	hslot4 = &udptable->hash4[slot];
+
+begin:
+	udp_lrpa_for_each_entry_rcu(up, node, &hslot4->nulls_head) {
+		sk = (struct sock *)up;
+		if (inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
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
+static void udp6_hash4(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	unsigned int hash;
+
+	if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)) {
+		udp4_hash4(sk);
+		return;
+	}
+
+	if (sk_unhashed(sk) || ipv6_addr_any(&sk->sk_v6_rcv_saddr))
+		return;
+
+	hash = udp6_ehashfn(net, &sk->sk_v6_rcv_saddr, sk->sk_num,
+			    &sk->sk_v6_daddr, sk->sk_dport);
+
+	udp_lib_hash4(sk, hash);
+}
+#endif /* CONFIG_BASE_SMALL */
+
 /* rcu_read_lock() must be held */
 struct sock *__udp6_lib_lookup(const struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
@@ -231,6 +305,12 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
 	hslot2 = udp_hashslot2(udptable, hash2);
 
+	if (udp_has_hash4(hslot2)) {
+		result = udp6_lib_lookup4(net, saddr, sport, daddr, hnum, dif, sdif, udptable);
+		if (result) /* udp6_lib_lookup4 return sk or NULL */
+			return result;
+	}
+
 	/* Lookup connected or non-wildcard sockets */
 	result = udp6_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
@@ -1166,6 +1246,18 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
+static int udpv6_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+{
+	int res;
+
+	lock_sock(sk);
+	res = __ip6_datagram_connect(sk, uaddr, addr_len);
+	if (!res)
+		udp6_hash4(sk);
+	release_sock(sk);
+	return res;
+}
+
 /**
  *	udp6_hwcsum_outgoing  -  handle outgoing HW checksumming
  *	@sk:	socket we are sending on
@@ -1761,7 +1853,7 @@ struct proto udpv6_prot = {
 	.owner			= THIS_MODULE,
 	.close			= udp_lib_close,
 	.pre_connect		= udpv6_pre_connect,
-	.connect		= ip6_datagram_connect,
+	.connect		= udpv6_connect,
 	.disconnect		= udp_disconnect,
 	.ioctl			= udp_ioctl,
 	.init			= udpv6_init_sock,
-- 
2.32.0.3.g01195cf9f


