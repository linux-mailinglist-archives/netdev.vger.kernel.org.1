Return-Path: <netdev+bounces-116335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EC794A126
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BF31F23E90
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9881B9B28;
	Wed,  7 Aug 2024 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Xfb7n1pc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D31B32AA
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013697; cv=none; b=AUve6j42JzUU+7kbXDQKqTpEKHOePS8tRF6d0PQ9ZtAH49x41Lv4ycD2awIdn/XH9tSn97lN/IbIBjq+g8BlqsA2DvxVcpjx98ZHIJck3y79OPTnK9f78+W7qoyTHvpcMcgP37LUe414kHYKqjhyeXceZVJckCR0WoRu3iZ92tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013697; c=relaxed/simple;
	bh=bjOv7cnBdRLrBxvCn4RRzJV010IZkExmKz8PAtWZqD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6pG8cM4vcaF6Fmr/D4wHoD9qk+RW+xoiFz66IGf/kJ2B9/c737xVChLentbw1vXn9oRunueDKdYg47TSmYoGiGMbt6oGT85jB9/tmRFd/qHO7QpWHGkVkHm7yRy6edoWb7k4FtMrwRSL8v0NrCtevk4TTb5ZNF6l598fQUAUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Xfb7n1pc; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 11C927DCFF;
	Wed,  7 Aug 2024 07:54:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013694; bh=bjOv7cnBdRLrBxvCn4RRzJV010IZkExmKz8PAtWZqD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org|Subject:=20[PATCH=20v2=20net-next=203/9]=20l2tp:=20move=20l2t
	 p_ip=20and=20l2tp_ip6=20data=20to=20pernet|Date:=20Wed,=20=207=20A
	 ug=202024=2007:54:46=20+0100|Message-Id:=20<8f7eafea23936989ba0e38
	 bccab195c5e4a6d51c.1723011569.git.jchapman@katalix.com>|In-Reply-T
	 o:=20<cover.1723011569.git.jchapman@katalix.com>|References:=20<co
	 ver.1723011569.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=Xfb7n1pcXKFaslEDuKjdeKhvZ/9jd0CxykUbT4Kn7HPQuYSIPz+NtNj6x9WdaPlZe
	 53J8kaScCD66yEt5TreCifJzbbwGqcjLhWoaO18PHnJW8z6bFvEvkD7yit/Vhezxet
	 UbgrCk7CmIotpxMQzUCFgntA22tw7/e48OSuXQYJAyDpcB1J8UMUWU7BG8rvqbtFdh
	 bqmdA/ZfwMbx72cjk/LKGfwRlYC0wmmRFpAOdiyiK1IMegaEIRYPkuBdTxz7HCq1us
	 kGIUNCD2OS9u6GhQlAD448EZmqRRKLOu8M2lHb2FZKVWJvW2493UEV2yC2Hcw8V9Nl
	 p7ow/zDJ2lydw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org
Subject: [PATCH v2 net-next 3/9] l2tp: move l2tp_ip and l2tp_ip6 data to pernet
Date: Wed,  7 Aug 2024 07:54:46 +0100
Message-Id: <8f7eafea23936989ba0e38bccab195c5e4a6d51c.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
References: <cover.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_ip[6] have always used global socket tables. It is therefore not
possible to create l2tpip sockets in different namespaces with the
same socket address.

To support this, move l2tpip socket tables to pernet data.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_ip.c  | 108 +++++++++++++++++++++++++++++++++----------
 net/l2tp/l2tp_ip6.c | 110 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 168 insertions(+), 50 deletions(-)

diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 9bd29667ae34..f563c8afd8f3 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -22,9 +22,19 @@
 #include <net/tcp_states.h>
 #include <net/protocol.h>
 #include <net/xfrm.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
 
 #include "l2tp_core.h"
 
+/* per-net private data for this module */
+static unsigned int l2tp_ip_net_id;
+struct l2tp_ip_net {
+	rwlock_t l2tp_ip_lock;
+	struct hlist_head l2tp_ip_table;
+	struct hlist_head l2tp_ip_bind_table;
+};
+
 struct l2tp_ip_sock {
 	/* inet_sock has to be the first member of l2tp_ip_sock */
 	struct inet_sock	inet;
@@ -33,21 +43,23 @@ struct l2tp_ip_sock {
 	u32			peer_conn_id;
 };
 
-static DEFINE_RWLOCK(l2tp_ip_lock);
-static struct hlist_head l2tp_ip_table;
-static struct hlist_head l2tp_ip_bind_table;
-
 static struct l2tp_ip_sock *l2tp_ip_sk(const struct sock *sk)
 {
 	return (struct l2tp_ip_sock *)sk;
 }
 
+static struct l2tp_ip_net *l2tp_ip_pernet(const struct net *net)
+{
+	return net_generic(net, l2tp_ip_net_id);
+}
+
 static struct sock *__l2tp_ip_bind_lookup(const struct net *net, __be32 laddr,
 					  __be32 raddr, int dif, u32 tunnel_id)
 {
+	struct l2tp_ip_net *pn = l2tp_ip_pernet(net);
 	struct sock *sk;
 
-	sk_for_each_bound(sk, &l2tp_ip_bind_table) {
+	sk_for_each_bound(sk, &pn->l2tp_ip_bind_table) {
 		const struct l2tp_ip_sock *l2tp = l2tp_ip_sk(sk);
 		const struct inet_sock *inet = inet_sk(sk);
 		int bound_dev_if;
@@ -113,6 +125,7 @@ static struct sock *__l2tp_ip_bind_lookup(const struct net *net, __be32 laddr,
 static int l2tp_ip_recv(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
+	struct l2tp_ip_net *pn;
 	struct sock *sk;
 	u32 session_id;
 	u32 tunnel_id;
@@ -121,6 +134,8 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 	struct l2tp_tunnel *tunnel = NULL;
 	struct iphdr *iph;
 
+	pn = l2tp_ip_pernet(net);
+
 	if (!pskb_may_pull(skb, 4))
 		goto discard;
 
@@ -167,15 +182,15 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 	tunnel_id = ntohl(*(__be32 *)&skb->data[4]);
 	iph = (struct iphdr *)skb_network_header(skb);
 
-	read_lock_bh(&l2tp_ip_lock);
+	read_lock_bh(&pn->l2tp_ip_lock);
 	sk = __l2tp_ip_bind_lookup(net, iph->daddr, iph->saddr, inet_iif(skb),
 				   tunnel_id);
 	if (!sk) {
-		read_unlock_bh(&l2tp_ip_lock);
+		read_unlock_bh(&pn->l2tp_ip_lock);
 		goto discard;
 	}
 	sock_hold(sk);
-	read_unlock_bh(&l2tp_ip_lock);
+	read_unlock_bh(&pn->l2tp_ip_lock);
 
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto discard_put;
@@ -198,21 +213,25 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 
 static int l2tp_ip_hash(struct sock *sk)
 {
+	struct l2tp_ip_net *pn = l2tp_ip_pernet(sock_net(sk));
+
 	if (sk_unhashed(sk)) {
-		write_lock_bh(&l2tp_ip_lock);
-		sk_add_node(sk, &l2tp_ip_table);
-		write_unlock_bh(&l2tp_ip_lock);
+		write_lock_bh(&pn->l2tp_ip_lock);
+		sk_add_node(sk, &pn->l2tp_ip_table);
+		write_unlock_bh(&pn->l2tp_ip_lock);
 	}
 	return 0;
 }
 
 static void l2tp_ip_unhash(struct sock *sk)
 {
+	struct l2tp_ip_net *pn = l2tp_ip_pernet(sock_net(sk));
+
 	if (sk_unhashed(sk))
 		return;
-	write_lock_bh(&l2tp_ip_lock);
+	write_lock_bh(&pn->l2tp_ip_lock);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l2tp_ip_lock);
+	write_unlock_bh(&pn->l2tp_ip_lock);
 }
 
 static int l2tp_ip_open(struct sock *sk)
@@ -226,10 +245,12 @@ static int l2tp_ip_open(struct sock *sk)
 
 static void l2tp_ip_close(struct sock *sk, long timeout)
 {
-	write_lock_bh(&l2tp_ip_lock);
+	struct l2tp_ip_net *pn = l2tp_ip_pernet(sock_net(sk));
+
+	write_lock_bh(&pn->l2tp_ip_lock);
 	hlist_del_init(&sk->sk_bind_node);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l2tp_ip_lock);
+	write_unlock_bh(&pn->l2tp_ip_lock);
 	sk_common_release(sk);
 }
 
@@ -253,6 +274,7 @@ static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	struct inet_sock *inet = inet_sk(sk);
 	struct sockaddr_l2tpip *addr = (struct sockaddr_l2tpip *)uaddr;
 	struct net *net = sock_net(sk);
+	struct l2tp_ip_net *pn;
 	int ret;
 	int chk_addr_ret;
 
@@ -283,10 +305,11 @@ static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (chk_addr_ret == RTN_MULTICAST || chk_addr_ret == RTN_BROADCAST)
 		inet->inet_saddr = 0;  /* Use device */
 
-	write_lock_bh(&l2tp_ip_lock);
+	pn = l2tp_ip_pernet(net);
+	write_lock_bh(&pn->l2tp_ip_lock);
 	if (__l2tp_ip_bind_lookup(net, addr->l2tp_addr.s_addr, 0,
 				  sk->sk_bound_dev_if, addr->l2tp_conn_id)) {
-		write_unlock_bh(&l2tp_ip_lock);
+		write_unlock_bh(&pn->l2tp_ip_lock);
 		ret = -EADDRINUSE;
 		goto out;
 	}
@@ -294,9 +317,9 @@ static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	sk_dst_reset(sk);
 	l2tp_ip_sk(sk)->conn_id = addr->l2tp_conn_id;
 
-	sk_add_bind_node(sk, &l2tp_ip_bind_table);
+	sk_add_bind_node(sk, &pn->l2tp_ip_bind_table);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l2tp_ip_lock);
+	write_unlock_bh(&pn->l2tp_ip_lock);
 
 	ret = 0;
 	sock_reset_flag(sk, SOCK_ZAPPED);
@@ -310,6 +333,7 @@ static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 static int l2tp_ip_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
 	struct sockaddr_l2tpip *lsa = (struct sockaddr_l2tpip *)uaddr;
+	struct l2tp_ip_net *pn = l2tp_ip_pernet(sock_net(sk));
 	int rc;
 
 	if (addr_len < sizeof(*lsa))
@@ -332,10 +356,10 @@ static int l2tp_ip_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 
 	l2tp_ip_sk(sk)->peer_conn_id = lsa->l2tp_conn_id;
 
-	write_lock_bh(&l2tp_ip_lock);
+	write_lock_bh(&pn->l2tp_ip_lock);
 	hlist_del_init(&sk->sk_bind_node);
-	sk_add_bind_node(sk, &l2tp_ip_bind_table);
-	write_unlock_bh(&l2tp_ip_lock);
+	sk_add_bind_node(sk, &pn->l2tp_ip_bind_table);
+	write_unlock_bh(&pn->l2tp_ip_lock);
 
 out_sk:
 	release_sock(sk);
@@ -640,25 +664,58 @@ static struct net_protocol l2tp_ip_protocol __read_mostly = {
 	.handler	= l2tp_ip_recv,
 };
 
+static __net_init int l2tp_ip_init_net(struct net *net)
+{
+	struct l2tp_ip_net *pn = net_generic(net, l2tp_ip_net_id);
+
+	rwlock_init(&pn->l2tp_ip_lock);
+	INIT_HLIST_HEAD(&pn->l2tp_ip_table);
+	INIT_HLIST_HEAD(&pn->l2tp_ip_bind_table);
+	return 0;
+}
+
+static __net_exit void l2tp_ip_exit_net(struct net *net)
+{
+	struct l2tp_ip_net *pn = l2tp_ip_pernet(net);
+
+	write_lock_bh(&pn->l2tp_ip_lock);
+	WARN_ON_ONCE(hlist_count_nodes(&pn->l2tp_ip_table) != 0);
+	WARN_ON_ONCE(hlist_count_nodes(&pn->l2tp_ip_bind_table) != 0);
+	write_unlock_bh(&pn->l2tp_ip_lock);
+}
+
+static struct pernet_operations l2tp_ip_net_ops = {
+	.init = l2tp_ip_init_net,
+	.exit = l2tp_ip_exit_net,
+	.id   = &l2tp_ip_net_id,
+	.size = sizeof(struct l2tp_ip_net),
+};
+
 static int __init l2tp_ip_init(void)
 {
 	int err;
 
 	pr_info("L2TP IP encapsulation support (L2TPv3)\n");
 
+	err = register_pernet_device(&l2tp_ip_net_ops);
+	if (err)
+		goto out;
+
 	err = proto_register(&l2tp_ip_prot, 1);
 	if (err != 0)
-		goto out;
+		goto out1;
 
 	err = inet_add_protocol(&l2tp_ip_protocol, IPPROTO_L2TP);
 	if (err)
-		goto out1;
+		goto out2;
 
 	inet_register_protosw(&l2tp_ip_protosw);
 	return 0;
 
-out1:
+out2:
 	proto_unregister(&l2tp_ip_prot);
+out1:
+	unregister_pernet_device(&l2tp_ip_net_ops);
 out:
 	return err;
 }
@@ -668,6 +725,7 @@ static void __exit l2tp_ip_exit(void)
 	inet_unregister_protosw(&l2tp_ip_protosw);
 	inet_del_protocol(&l2tp_ip_protocol, IPPROTO_L2TP);
 	proto_unregister(&l2tp_ip_prot);
+	unregister_pernet_device(&l2tp_ip_net_ops);
 }
 
 module_init(l2tp_ip_init);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index a7b7626ca2c6..dcec1de2898e 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -22,6 +22,8 @@
 #include <net/tcp_states.h>
 #include <net/protocol.h>
 #include <net/xfrm.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
 
 #include <net/transp_v6.h>
 #include <net/addrconf.h>
@@ -29,6 +31,14 @@
 
 #include "l2tp_core.h"
 
+/* per-net private data for this module */
+static unsigned int l2tp_ip6_net_id;
+struct l2tp_ip6_net {
+	rwlock_t l2tp_ip6_lock;
+	struct hlist_head l2tp_ip6_table;
+	struct hlist_head l2tp_ip6_bind_table;
+};
+
 struct l2tp_ip6_sock {
 	/* inet_sock has to be the first member of l2tp_ip6_sock */
 	struct inet_sock	inet;
@@ -39,23 +49,25 @@ struct l2tp_ip6_sock {
 	struct ipv6_pinfo	inet6;
 };
 
-static DEFINE_RWLOCK(l2tp_ip6_lock);
-static struct hlist_head l2tp_ip6_table;
-static struct hlist_head l2tp_ip6_bind_table;
-
 static struct l2tp_ip6_sock *l2tp_ip6_sk(const struct sock *sk)
 {
 	return (struct l2tp_ip6_sock *)sk;
 }
 
+static struct l2tp_ip6_net *l2tp_ip6_pernet(const struct net *net)
+{
+	return net_generic(net, l2tp_ip6_net_id);
+}
+
 static struct sock *__l2tp_ip6_bind_lookup(const struct net *net,
 					   const struct in6_addr *laddr,
 					   const struct in6_addr *raddr,
 					   int dif, u32 tunnel_id)
 {
+	struct l2tp_ip6_net *pn = l2tp_ip6_pernet(net);
 	struct sock *sk;
 
-	sk_for_each_bound(sk, &l2tp_ip6_bind_table) {
+	sk_for_each_bound(sk, &pn->l2tp_ip6_bind_table) {
 		const struct in6_addr *sk_laddr = inet6_rcv_saddr(sk);
 		const struct in6_addr *sk_raddr = &sk->sk_v6_daddr;
 		const struct l2tp_ip6_sock *l2tp = l2tp_ip6_sk(sk);
@@ -123,6 +135,7 @@ static struct sock *__l2tp_ip6_bind_lookup(const struct net *net,
 static int l2tp_ip6_recv(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
+	struct l2tp_ip6_net *pn;
 	struct sock *sk;
 	u32 session_id;
 	u32 tunnel_id;
@@ -131,6 +144,8 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 	struct l2tp_tunnel *tunnel = NULL;
 	struct ipv6hdr *iph;
 
+	pn = l2tp_ip6_pernet(net);
+
 	if (!pskb_may_pull(skb, 4))
 		goto discard;
 
@@ -177,15 +192,15 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 	tunnel_id = ntohl(*(__be32 *)&skb->data[4]);
 	iph = ipv6_hdr(skb);
 
-	read_lock_bh(&l2tp_ip6_lock);
+	read_lock_bh(&pn->l2tp_ip6_lock);
 	sk = __l2tp_ip6_bind_lookup(net, &iph->daddr, &iph->saddr,
 				    inet6_iif(skb), tunnel_id);
 	if (!sk) {
-		read_unlock_bh(&l2tp_ip6_lock);
+		read_unlock_bh(&pn->l2tp_ip6_lock);
 		goto discard;
 	}
 	sock_hold(sk);
-	read_unlock_bh(&l2tp_ip6_lock);
+	read_unlock_bh(&pn->l2tp_ip6_lock);
 
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto discard_put;
@@ -208,21 +223,25 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 
 static int l2tp_ip6_hash(struct sock *sk)
 {
+	struct l2tp_ip6_net *pn = l2tp_ip6_pernet(sock_net(sk));
+
 	if (sk_unhashed(sk)) {
-		write_lock_bh(&l2tp_ip6_lock);
-		sk_add_node(sk, &l2tp_ip6_table);
-		write_unlock_bh(&l2tp_ip6_lock);
+		write_lock_bh(&pn->l2tp_ip6_lock);
+		sk_add_node(sk, &pn->l2tp_ip6_table);
+		write_unlock_bh(&pn->l2tp_ip6_lock);
 	}
 	return 0;
 }
 
 static void l2tp_ip6_unhash(struct sock *sk)
 {
+	struct l2tp_ip6_net *pn = l2tp_ip6_pernet(sock_net(sk));
+
 	if (sk_unhashed(sk))
 		return;
-	write_lock_bh(&l2tp_ip6_lock);
+	write_lock_bh(&pn->l2tp_ip6_lock);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l2tp_ip6_lock);
+	write_unlock_bh(&pn->l2tp_ip6_lock);
 }
 
 static int l2tp_ip6_open(struct sock *sk)
@@ -236,10 +255,12 @@ static int l2tp_ip6_open(struct sock *sk)
 
 static void l2tp_ip6_close(struct sock *sk, long timeout)
 {
-	write_lock_bh(&l2tp_ip6_lock);
+	struct l2tp_ip6_net *pn = l2tp_ip6_pernet(sock_net(sk));
+
+	write_lock_bh(&pn->l2tp_ip6_lock);
 	hlist_del_init(&sk->sk_bind_node);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l2tp_ip6_lock);
+	write_unlock_bh(&pn->l2tp_ip6_lock);
 
 	sk_common_release(sk);
 }
@@ -265,11 +286,14 @@ static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct sockaddr_l2tpip6 *addr = (struct sockaddr_l2tpip6 *)uaddr;
 	struct net *net = sock_net(sk);
+	struct l2tp_ip6_net *pn;
 	__be32 v4addr = 0;
 	int bound_dev_if;
 	int addr_type;
 	int err;
 
+	pn = l2tp_ip6_pernet(net);
+
 	if (addr->l2tp_family != AF_INET6)
 		return -EINVAL;
 	if (addr_len < sizeof(*addr))
@@ -327,10 +351,10 @@ static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	}
 	rcu_read_unlock();
 
-	write_lock_bh(&l2tp_ip6_lock);
+	write_lock_bh(&pn->l2tp_ip6_lock);
 	if (__l2tp_ip6_bind_lookup(net, &addr->l2tp_addr, NULL, bound_dev_if,
 				   addr->l2tp_conn_id)) {
-		write_unlock_bh(&l2tp_ip6_lock);
+		write_unlock_bh(&pn->l2tp_ip6_lock);
 		err = -EADDRINUSE;
 		goto out_unlock;
 	}
@@ -343,9 +367,9 @@ static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	l2tp_ip6_sk(sk)->conn_id = addr->l2tp_conn_id;
 
-	sk_add_bind_node(sk, &l2tp_ip6_bind_table);
+	sk_add_bind_node(sk, &pn->l2tp_ip6_bind_table);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l2tp_ip6_lock);
+	write_unlock_bh(&pn->l2tp_ip6_lock);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 	release_sock(sk);
@@ -367,6 +391,7 @@ static int l2tp_ip6_connect(struct sock *sk, struct sockaddr *uaddr,
 	struct in6_addr	*daddr;
 	int	addr_type;
 	int rc;
+	struct l2tp_ip6_net *pn;
 
 	if (addr_len < sizeof(*lsa))
 		return -EINVAL;
@@ -398,10 +423,11 @@ static int l2tp_ip6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	l2tp_ip6_sk(sk)->peer_conn_id = lsa->l2tp_conn_id;
 
-	write_lock_bh(&l2tp_ip6_lock);
+	pn = l2tp_ip6_pernet(sock_net(sk));
+	write_lock_bh(&pn->l2tp_ip6_lock);
 	hlist_del_init(&sk->sk_bind_node);
-	sk_add_bind_node(sk, &l2tp_ip6_bind_table);
-	write_unlock_bh(&l2tp_ip6_lock);
+	sk_add_bind_node(sk, &pn->l2tp_ip6_bind_table);
+	write_unlock_bh(&pn->l2tp_ip6_lock);
 
 out_sk:
 	release_sock(sk);
@@ -768,25 +794,58 @@ static struct inet6_protocol l2tp_ip6_protocol __read_mostly = {
 	.handler	= l2tp_ip6_recv,
 };
 
+static __net_init int l2tp_ip6_init_net(struct net *net)
+{
+	struct l2tp_ip6_net *pn = net_generic(net, l2tp_ip6_net_id);
+
+	rwlock_init(&pn->l2tp_ip6_lock);
+	INIT_HLIST_HEAD(&pn->l2tp_ip6_table);
+	INIT_HLIST_HEAD(&pn->l2tp_ip6_bind_table);
+	return 0;
+}
+
+static __net_exit void l2tp_ip6_exit_net(struct net *net)
+{
+	struct l2tp_ip6_net *pn = l2tp_ip6_pernet(net);
+
+	write_lock_bh(&pn->l2tp_ip6_lock);
+	WARN_ON_ONCE(hlist_count_nodes(&pn->l2tp_ip6_table) != 0);
+	WARN_ON_ONCE(hlist_count_nodes(&pn->l2tp_ip6_bind_table) != 0);
+	write_unlock_bh(&pn->l2tp_ip6_lock);
+}
+
+static struct pernet_operations l2tp_ip6_net_ops = {
+	.init = l2tp_ip6_init_net,
+	.exit = l2tp_ip6_exit_net,
+	.id   = &l2tp_ip6_net_id,
+	.size = sizeof(struct l2tp_ip6_net),
+};
+
 static int __init l2tp_ip6_init(void)
 {
 	int err;
 
 	pr_info("L2TP IP encapsulation support for IPv6 (L2TPv3)\n");
 
+	err = register_pernet_device(&l2tp_ip6_net_ops);
+	if (err)
+		goto out;
+
 	err = proto_register(&l2tp_ip6_prot, 1);
 	if (err != 0)
-		goto out;
+		goto out1;
 
 	err = inet6_add_protocol(&l2tp_ip6_protocol, IPPROTO_L2TP);
 	if (err)
-		goto out1;
+		goto out2;
 
 	inet6_register_protosw(&l2tp_ip6_protosw);
 	return 0;
 
-out1:
+out2:
 	proto_unregister(&l2tp_ip6_prot);
+out1:
+	unregister_pernet_device(&l2tp_ip6_net_ops);
 out:
 	return err;
 }
@@ -796,6 +855,7 @@ static void __exit l2tp_ip6_exit(void)
 	inet6_unregister_protosw(&l2tp_ip6_protosw);
 	inet6_del_protocol(&l2tp_ip6_protocol, IPPROTO_L2TP);
 	proto_unregister(&l2tp_ip6_prot);
+	unregister_pernet_device(&l2tp_ip6_net_ops);
 }
 
 module_init(l2tp_ip6_init);
-- 
2.34.1


