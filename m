Return-Path: <netdev+bounces-144833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8A49C881C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D938428314C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C48D1F9A8D;
	Thu, 14 Nov 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="le10QRS8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AE1F80D9;
	Thu, 14 Nov 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581544; cv=none; b=AHpTLmN45vA21KyP6qaSuAxnPl4ewFII+9F9fYhHaZc9azuXOkBdPOto1wa5onfPtynC4fOj4ISypXySS8aSf8hAZ+Z7aGkUH9NeSEvCUEWYFGwGUkCGFI/mwp9JSrjBiXfdzgJuFARCpPJ3435Gb76UdbmoPmoy/p2gjxlh+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581544; c=relaxed/simple;
	bh=z/p/eaCVV5C/WkQgpWNnNC2jH9CtDmwenZWe8kewcbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnNEB1avbvJNSLXZE68wQ0Y3fH9YOEmijOC1BT9fgqkmAO0RkL72mBLWiPmLeh1qJpCn9dCp70A4k6MdiauhWWaKyKTpc7e+uuShpMhEYlbnQS+J/fcJqqkMKjUZluDvVjw1fAD3dA6lnXRcax4wiSCQqNRkDmdEqeK6cuqKPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=le10QRS8; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731581533; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ldS/y3NY/7g2RWEJFB3EcIA192QL1XT5lXXWYGJuVZU=;
	b=le10QRS86b4+Ilu4NEt8Q3GmxEHGIV+flQhuS/xfEWfvCrLoy8uo+AJTULpg/mZmTqAXleOgDeI03fsEtDP3txbZTkzTJ4WWOnF4GupoNR2SGfrS2TUEFsiFE4vULUnKKCCd9CfaPhkUCHf5d3Mdc85HYQASSbdAA9HHogaJVSw=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WJOMu5Z_1731581531 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 18:52:12 +0800
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
Subject: [PATCH v9 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected socket
Date: Thu, 14 Nov 2024 18:52:07 +0800
Message-Id: <20241114105207.30185-5-lulie@linux.alibaba.com>
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

Implement ipv6 udp hash4 like that in ipv4. The major difference is that
the hash value should be calculated with udp6_ehashfn(). Besides,
ipv4-mapped ipv6 address is handled before hash() and rehash(). Export
udp_ehashfn because now we use it in udpv6 rehash.

Core procedures of hash/unhash/rehash are same as ipv4, and udpv4 and
udpv6 share the same udptable, so some functions in ipv4 hash4 can also
be shared.

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
 include/net/udp.h |   2 +
 net/ipv4/udp.c    |   2 +-
 net/ipv6/udp.c    | 102 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index feb06c0e48fb..6e89520e100d 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -303,6 +303,8 @@ static inline int udp_lib_hash(struct sock *sk)
 
 void udp_lib_unhash(struct sock *sk);
 void udp_lib_rehash(struct sock *sk, u16 new_hash, u16 new_hash4);
+u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
+		const __be32 faddr, const __be16 fport);
 
 static inline void udp_lib_close(struct sock *sk, long timeout)
 {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b6c5edd7ff48..6a01905d379f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -410,7 +410,6 @@ static int compute_score(struct sock *sk, const struct net *net,
 	return score;
 }
 
-INDIRECT_CALLABLE_SCOPE
 u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 		const __be32 faddr, const __be16 fport)
 {
@@ -419,6 +418,7 @@ u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 	return __inet_ehashfn(laddr, lport, faddr, fport,
 			      udp_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL(udp_ehashfn);
 
 /* called with rcu_read_lock() */
 static struct sock *udp4_lib_lookup2(const struct net *net,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 1ea99d704e31..d766fd798ecf 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -110,8 +110,19 @@ void udp_v6_rehash(struct sock *sk)
 	u16 new_hash = ipv6_portaddr_hash(sock_net(sk),
 					  &sk->sk_v6_rcv_saddr,
 					  inet_sk(sk)->inet_num);
+	u16 new_hash4;
 
-	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */
+	if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)) {
+		new_hash4 = udp_ehashfn(sock_net(sk),
+					sk->sk_rcv_saddr, sk->sk_num,
+					sk->sk_daddr, sk->sk_dport);
+	} else {
+		new_hash4 = udp6_ehashfn(sock_net(sk),
+					 &sk->sk_v6_rcv_saddr, sk->sk_num,
+					 &sk->sk_v6_daddr, sk->sk_dport);
+	}
+
+	udp_lib_rehash(sk, new_hash, new_hash4);
 }
 
 static int compute_score(struct sock *sk, const struct net *net,
@@ -216,6 +227,74 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 	return result;
 }
 
+#if IS_ENABLED(CONFIG_BASE_SMALL)
+static struct sock *udp6_lib_lookup4(const struct net *net,
+				     const struct in6_addr *saddr, __be16 sport,
+				     const struct in6_addr *daddr,
+				     unsigned int hnum, int dif, int sdif,
+				     struct udp_table *udptable)
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
+				     const struct in6_addr *daddr,
+				     unsigned int hnum, int dif, int sdif,
+				     struct udp_table *udptable)
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
@@ -231,6 +310,13 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
 	hslot2 = udp_hashslot2(udptable, hash2);
 
+	if (udp_has_hash4(hslot2)) {
+		result = udp6_lib_lookup4(net, saddr, sport, daddr, hnum,
+					  dif, sdif, udptable);
+		if (result) /* udp6_lib_lookup4 return sk or NULL */
+			return result;
+	}
+
 	/* Lookup connected or non-wildcard sockets */
 	result = udp6_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
@@ -1166,6 +1252,18 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
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
@@ -1761,7 +1859,7 @@ struct proto udpv6_prot = {
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


