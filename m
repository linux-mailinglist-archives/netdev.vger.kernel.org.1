Return-Path: <netdev+bounces-129521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B62E984427
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7644280C48
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA401A706C;
	Tue, 24 Sep 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IYl5YDUV"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D01A4F0A;
	Tue, 24 Sep 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175865; cv=none; b=Frm3gQ4GJOCSaBw6s6s/v5av+49MClwV4nPRFIOu1D9ZcfYDRf9YTn5lvpWte5yUVgVzoMcsQRnPVuImwPD7u5MEyHO2M0vQho8ecdbcDbgfV8F3n/U6aT0sKhYEgCqxxqAyQLcNHUWGdUBAMDTG9NGssLdEqhZOdmAMGHhE5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175865; c=relaxed/simple;
	bh=L1lTiuYqaoG9l3saISEXFq6MjQ230MuZiqo9sqIemJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSJPTkHmBtHYRgLwPfVmGjY74xggcfgPkt/g4uaKyWHlFt112QKba0+QjdVp9q6UJzMKSMViLuCqhRZktGssp6r4j4fgKSizZCCCrxsh6oRvGBvOb+maN+E3kk5MXpAmC97GYwU3MHs0+QRr93jQtgo2gf2WeFSetYIzMBHckII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IYl5YDUV; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727175860; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=k18h0fUC3QoH9KxvWe3zarEZOMXGU85CuInbIK3V6j0=;
	b=IYl5YDUVXnInI/m5bQgDxFMI2LJ5Oo/uaebARe6K9eU4hz4Ah2rjO77dm90RHQONeTIFQqQbcGjwdkpqyU/h1qrPhoc8CxzPprASaBIQhkZrA2R/Y8hKV+iK6CxHXNfUlSJu4D7xHI+hrPFxBQ5sYKJT56YLdRNeXp1OoG/CmCE=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFgDEKv_1727175858)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 19:04:18 +0800
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
Subject: [RFC PATCHv2 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected socket
Date: Tue, 24 Sep 2024 19:04:14 +0800
Message-Id: <20240924110414.52618-4-lulie@linux.alibaba.com>
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

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
---
 include/net/udp.h |   3 +-
 net/ipv4/udp.c    | 140 ++++++++++++++++++++++++++++++++++++++++++++--
 net/ipv6/udp.c    |   2 +-
 3 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 94005363b8abd..3bb0c4f24692a 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -226,7 +226,7 @@ static inline int udp_lib_hash(struct sock *sk)
 }
 
 void udp_lib_unhash(struct sock *sk);
-void udp_lib_rehash(struct sock *sk, u16 new_hash);
+void udp_lib_rehash(struct sock *sk, u16 new_hash, u16 new_hash4);
 
 static inline void udp_lib_close(struct sock *sk, long timeout)
 {
@@ -319,6 +319,7 @@ int udp_rcv(struct sk_buff *skb);
 int udp_ioctl(struct sock *sk, int cmd, int *karg);
 int udp_init_sock(struct sock *sk);
 int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int udp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int __udp_disconnect(struct sock *sk, int flags);
 int udp_disconnect(struct sock *sk, int flags);
 __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5564896686fa5..1d48d3ad17c57 100644
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
@@ -493,6 +514,12 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	hslot2 = udp_hashslot2(udptable, hash2);
 
+	if (UDP_HSLOT_MAIN(hslot2)->hash4_cnt) {
+		result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum, dif, sdif, udptable);
+		if (result) /* udp4_lib_lookup4 return sk or NULL */
+			return result;
+	}
+
 	/* Lookup connected or non-wildcard socket */
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
@@ -1931,6 +1958,83 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
+/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
+static void udp4_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
+{
+	struct udp_hslot *hslot4, *nhslot4;
+
+	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
+	nhslot4 = udp_hashslot4(udptable, newhash4);
+	udp_sk(sk)->udp_lrpa_hash = newhash4;
+
+	if (hslot4 != nhslot4) {
+		spin_lock_bh(&hslot4->lock);
+		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
+		hslot4->count--;
+		spin_unlock_bh(&hslot4->lock);
+
+		spin_lock_bh(&nhslot4->lock);
+		hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
+		nhslot4->count++;
+		spin_unlock_bh(&nhslot4->lock);
+	}
+}
+
+/* call with sock lock */
+static void udp4_hash4(struct sock *sk)
+{
+	struct udp_hslot *hslot, *hslot4;
+	struct udp_hslot_main *hslotm2;
+	struct net *net = sock_net(sk);
+	struct udp_table *udptable;
+	unsigned int hash;
+
+	if (sk_unhashed(sk) || inet_sk(sk)->inet_rcv_saddr == htonl(INADDR_ANY))
+		return;
+
+	hash = udp_ehashfn(net, inet_sk(sk)->inet_rcv_saddr, inet_sk(sk)->inet_num,
+			   inet_sk(sk)->inet_daddr, inet_sk(sk)->inet_dport);
+
+	udptable = net->ipv4.udp_table;
+	if (udp_hashed4(sk)) {
+		udp4_rehash4(udptable, sk, hash);
+		return;
+	}
+
+	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
+	hslotm2 = udp_hashslot2_main(udptable, udp_sk(sk)->udp_portaddr_hash);
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
+	spin_lock(&hslotm2->hslot.lock);
+	hslotm2->hash4_cnt++;
+	spin_unlock(&hslotm2->hslot.lock);
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
+	if (!res)
+		udp4_hash4(sk);
+	release_sock(sk);
+	return res;
+}
+EXPORT_SYMBOL(udp_connect);
+
 int __udp_disconnect(struct sock *sk, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -1972,7 +2076,7 @@ void udp_lib_unhash(struct sock *sk)
 {
 	if (sk_hashed(sk)) {
 		struct udp_table *udptable = udp_get_table_prot(sk);
-		struct udp_hslot *hslot, *hslot2;
+		struct udp_hslot *hslot, *hslot2, *hslot4;
 
 		hslot  = udp_hashslot(udptable, sock_net(sk),
 				      udp_sk(sk)->udp_port_hash);
@@ -1990,6 +2094,18 @@ void udp_lib_unhash(struct sock *sk)
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
+
+				spin_lock(&hslot2->lock);
+				UDP_HSLOT_MAIN(hslot2)->hash4_cnt--;
+				spin_unlock(&hslot2->lock);
+			}
 		}
 		spin_unlock_bh(&hslot->lock);
 	}
@@ -1999,7 +2115,7 @@ EXPORT_SYMBOL(udp_lib_unhash);
 /*
  * inet_rcv_saddr was changed, we must rehash secondary hash
  */
-void udp_lib_rehash(struct sock *sk, u16 newhash)
+void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 {
 	if (sk_hashed(sk)) {
 		struct udp_table *udptable = udp_get_table_prot(sk);
@@ -2031,6 +2147,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
 				spin_unlock(&nhslot2->lock);
 			}
 
+			if (udp_hashed4(sk)) {
+				udp4_rehash4(udptable, sk, newhash4);
+
+				if (hslot2 != nhslot2) {
+					spin_lock(&hslot2->lock);
+					UDP_HSLOT_MAIN(hslot2)->hash4_cnt--;
+					spin_unlock(&hslot2->lock);
+
+					spin_lock(&nhslot2->lock);
+					UDP_HSLOT_MAIN(nhslot2)->hash4_cnt++;
+					spin_unlock(&nhslot2->lock);
+				}
+			}
 			spin_unlock_bh(&hslot->lock);
 		}
 	}
@@ -2042,7 +2171,10 @@ void udp_v4_rehash(struct sock *sk)
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
@@ -2935,7 +3067,7 @@ struct proto udp_prot = {
 	.owner			= THIS_MODULE,
 	.close			= udp_lib_close,
 	.pre_connect		= udp_pre_connect,
-	.connect		= ip4_datagram_connect,
+	.connect		= udp_connect,
 	.disconnect		= udp_disconnect,
 	.ioctl			= udp_ioctl,
 	.init			= udp_init_sock,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index bbf3352213c40..4d3dfcb48a39d 100644
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


