Return-Path: <netdev+bounces-143206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A99C1626
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 06:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B4A1F24324
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDA1CF5F4;
	Fri,  8 Nov 2024 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pUJeHLua"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E391D14E2;
	Fri,  8 Nov 2024 05:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731044932; cv=none; b=RQyNed8gHeVqA31gXnobaXfooJfZ4xgAUSxHHizhH7uc/FZp0l3Ezp6YOnlHcLfv9F2UFNfmTt1iQLeRAUrG9wyXdKrA8U75Ss0kEBFw95e8e/+P/HgdPOSUGH1Vf0iVbn3BnGZaEMzv92XIvaDrmVF1b8ECUS+tfGTUEgpecYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731044932; c=relaxed/simple;
	bh=+ptdexXDalV1BfSG+CzpxB/ohs/moGFR6wcAjE+GpNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0A3wnAP2coTcsnK0mUo9SoF9sFzYogvQijzAtX4Je/pGRkR4+7KJboWWBo58Ktf34eoZK22zlTALf6y6Zzap9GJJq+4LdTFDYqqJHHdf9DhXImWllTEG/EvQ/sd15zsO7jzJS+bi5G6djAHTQPj86Y+0/e5d+vW1SyFgCKvGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pUJeHLua; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731044922; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+ooUyQM6ykbH93D5TeE9qnZ42E23tAqkspDx0UAypCk=;
	b=pUJeHLuaR6tKQ3l1xFf+b1FOclTJ044qFzhEd/nXOA2FFX5wDglf7htVrx3mKBmyLPgpCXzpjY294gPSW2C2qDnv29VGgaR9CDrnD7wiu0fDn/W9sUTYHQC8DS+pAoN3dt8zvJj6c2o0pF+7ZSmbBwhnNNrGxdOTZ9I9NcAMAgw=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIxkgld_1731044920 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 13:48:41 +0800
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
Subject: [PATCH v8 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected socket
Date: Fri,  8 Nov 2024 13:48:36 +0800
Message-Id: <20241108054836.123484-5-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241108054836.123484-1-lulie@linux.alibaba.com>
References: <20241108054836.123484-1-lulie@linux.alibaba.com>
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


