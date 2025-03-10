Return-Path: <netdev+bounces-173629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D744A5A3A6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1680F3A815F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EFB22FF32;
	Mon, 10 Mar 2025 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWMuWj1R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDB235377
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633830; cv=none; b=NnJ4wW3UxHTBe1blSv9P3eaHE5EMyG6TNyiAXb3p68JqAYBGVgK3Va72qxJj5Ovzm6xXNaeLnQOnLxBW5HDk2avAr1yehApcDv2o0CD+P9eOg8Y2h7hebjH/oCsq0FUUFrbrsmkNOvaj44FjcTSCGyWhQ/1MEnfjzi+e/7KiDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633830; c=relaxed/simple;
	bh=TlJsukTdTfaK4kSrcDHVTocR4NuUk9iHkNoi+ZdiDPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/uGY69MhSPMRZRqUK9m2lnj6qrUVfIHpzXWx3lwIKueQ2HBGYdDylSZzf5vuq6T7OPvRVWDUDvNN+TvTQVkRCDl/O0FqCKgdLPiuVfeklU6+j/pGlAaIOfgYM9mI8RvwC02HtOc6Gr4kjOwc9Zwyd9yf2zabeL7v3/S7ZV4nyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWMuWj1R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741633827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hs28ZsLRtqICNLSagum6jBygtuKs3qTxQHZmFZj4u4=;
	b=WWMuWj1RNjXhwT/lcJuNmSK8O032POluVBrv/WVHymRtjRWy+FJNGIGgjdBuE/Xau021KZ
	pdihKDq9/acNILovIIrrz5+bY1SoEq6ymC1In6TKZkxcef7srK3vwmq5p1/9kI9HkGoLva
	fL3TbVqT6WGPOWklS867siqRz+F7kXU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-rqTFywWDPgu-FU33gnKWtA-1; Mon,
 10 Mar 2025 15:10:23 -0400
X-MC-Unique: rqTFywWDPgu-FU33gnKWtA-1
X-Mimecast-MFC-AGG-ID: rqTFywWDPgu-FU33gnKWtA_1741633821
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D1121956050;
	Mon, 10 Mar 2025 19:10:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.22.89.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0804A1956094;
	Mon, 10 Mar 2025 19:10:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	kuniyu@amazon.com
Subject: [PATCH v3 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
Date: Mon, 10 Mar 2025 20:09:48 +0100
Message-ID: <fe46117f2eaf14cf4e89a767d04170a900390fe0.1741632298.git.pabeni@redhat.com>
In-Reply-To: <cover.1741632298.git.pabeni@redhat.com>
References: <cover.1741632298.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Most UDP tunnels bind a socket to a local port, with ANY address, no
peer and no interface index specified.
Additionally it's quite common to have a single tunnel device per
namespace.

Track in each namespace the UDP tunnel socket respecting the above.
When only a single one is present, store a reference in the netns.

When such reference is not NULL, UDP tunnel GRO lookup just need to
match the incoming packet destination port vs the socket local port.

The tunnel socket never sets the reuse[port] flag[s]. When bound to no
address and interface, no other socket can exist in the same netns
matching the specified local port.

Note that the UDP tunnel socket reference is stored into struct
netns_ipv4 for both IPv4 and IPv6 tunnels. That is intentional to keep
all the fastpath-related netns fields in the same struct and allow
cacheline-based optimization. Currently both the IPv4 and IPv6 socket
pointer share the same cacheline as the `udp_table` field.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - use RCU_INIT_POINTER() when possible
 - drop 'inline' from c file

v1 -> v2:
 - fix [1] -> [i] typo
 - avoid replacing static_branch_dec(udp_encap_needed_key) with
   udp_encap_disable() (no-op)
 - move ipv6 cleanup after encap disable
 - clarified the design choice in the commit message
---
 include/linux/udp.h        | 16 ++++++++++++++++
 include/net/netns/ipv4.h   | 11 +++++++++++
 include/net/udp.h          |  1 +
 include/net/udp_tunnel.h   | 18 ++++++++++++++++++
 net/ipv4/udp.c             | 13 ++++++++++++-
 net/ipv4/udp_offload.c     | 37 +++++++++++++++++++++++++++++++++++++
 net/ipv4/udp_tunnel_core.c | 12 ++++++++++++
 net/ipv6/udp.c             |  2 ++
 net/ipv6/udp_offload.c     |  5 +++++
 9 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 0807e21cfec95..895240177f4f4 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -101,6 +101,13 @@ struct udp_sock {
 
 	/* Cache friendly copy of sk->sk_peek_off >= 0 */
 	bool		peeking_with_offset;
+
+	/*
+	 * Accounting for the tunnel GRO fastpath.
+	 * Unprotected by compilers guard, as it uses space available in
+	 * the last UDP socket cacheline.
+	 */
+	struct hlist_node	tunnel_list;
 };
 
 #define udp_test_bit(nr, sk)			\
@@ -219,4 +226,13 @@ static inline void udp_allow_gso(struct sock *sk)
 
 #define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
 
+static inline struct sock *udp_tunnel_sk(const struct net *net, bool is_ipv6)
+{
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+	return rcu_dereference(net->ipv4.udp_tunnel_gro[is_ipv6].sk);
+#else
+	return NULL;
+#endif
+}
+
 #endif	/* _LINUX_UDP_H */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 650b2dc9199f4..6373e3f17da84 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -47,6 +47,11 @@ struct sysctl_fib_multipath_hash_seed {
 };
 #endif
 
+struct udp_tunnel_gro {
+	struct sock __rcu *sk;
+	struct hlist_head list;
+};
+
 struct netns_ipv4 {
 	/* Cacheline organization can be found documented in
 	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
@@ -85,6 +90,11 @@ struct netns_ipv4 {
 	struct inet_timewait_death_row tcp_death_row;
 	struct udp_table *udp_table;
 
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+	/* Not in a pernet subsys because need to be available at GRO stage */
+	struct udp_tunnel_gro udp_tunnel_gro[2];
+#endif
+
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header	*forw_hdr;
 	struct ctl_table_header	*frags_hdr;
@@ -277,4 +287,5 @@ struct netns_ipv4 {
 	struct hlist_head	*inet_addr_lst;
 	struct delayed_work	addr_chk_work;
 };
+
 #endif
diff --git a/include/net/udp.h b/include/net/udp.h
index 6e89520e100dc..a772510b2aa58 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -290,6 +290,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
 	struct udp_sock *up = udp_sk(sk);
 
 	skb_queue_head_init(&up->reader_queue);
+	INIT_HLIST_NODE(&up->tunnel_list);
 	up->forward_threshold = sk->sk_rcvbuf >> 2;
 	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
 }
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index a93dc51f6323e..eda0f3e2f65fa 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -203,6 +203,24 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 	udp_encap_enable();
 }
 
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
+#else
+static inline void udp_tunnel_update_gro_lookup(struct net *net,
+						struct sock *sk, bool add) {}
+#endif
+
+static inline void udp_tunnel_cleanup_gro(struct sock *sk)
+{
+	struct udp_sock *up = udp_sk(sk);
+	struct net *net = sock_net(sk);
+
+	if (!up->tunnel_list.pprev)
+		return;
+
+	udp_tunnel_update_gro_lookup(net, sk, false);
+}
+
 #define UDP_TUNNEL_NIC_MAX_TABLES	4
 
 enum udp_tunnel_nic_info_flags {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 17c7736d83494..26863e51801fb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2891,8 +2891,10 @@ void udp_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (udp_test_bit(ENCAP_ENABLED, sk))
+		if (udp_test_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udp_encap_needed_key);
+			udp_tunnel_cleanup_gro(sk);
+		}
 	}
 }
 
@@ -3804,6 +3806,15 @@ static void __net_init udp_set_table(struct net *net)
 
 static int __net_init udp_pernet_init(struct net *net)
 {
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+	int i;
+
+	/* No tunnel is configured */
+	for (i = 0; i < ARRAY_SIZE(net->ipv4.udp_tunnel_gro); ++i) {
+		INIT_HLIST_HEAD(&net->ipv4.udp_tunnel_gro[i].list);
+		RCU_INIT_POINTER(net->ipv4.udp_tunnel_gro[i].sk, NULL);
+	}
+#endif
 	udp_sysctl_init(net);
 	udp_set_table(net);
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 2c0725583be39..054d4d4a8927f 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -12,6 +12,38 @@
 #include <net/udp.h>
 #include <net/protocol.h>
 #include <net/inet_common.h>
+#include <net/udp_tunnel.h>
+
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
+
+void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+	struct udp_sock *tup, *up = udp_sk(sk);
+	struct udp_tunnel_gro *udp_tunnel_gro;
+
+	spin_lock(&udp_tunnel_gro_lock);
+	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
+	if (add)
+		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
+	else
+		hlist_del_init(&up->tunnel_list);
+
+	if (udp_tunnel_gro->list.first &&
+	    !udp_tunnel_gro->list.first->next) {
+		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
+				  tunnel_list);
+
+		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);
+	} else {
+		rcu_assign_pointer(udp_tunnel_gro->sk, NULL);
+	}
+
+	spin_unlock(&udp_tunnel_gro_lock);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
+#endif
 
 static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	netdev_features_t features,
@@ -635,8 +667,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net_rcu(skb->dev);
+	struct sock *sk;
 	int iif, sdif;
 
+	sk = udp_tunnel_sk(net, false);
+	if (sk && dport == htons(sk->sk_num))
+		return sk;
+
 	inet_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 619a53eb672da..b5695826e57ad 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -58,6 +58,15 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL(udp_sock_create4);
 
+static bool sk_saddr_any(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
+#else
+	return !sk->sk_rcv_saddr;
+#endif
+}
+
 void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 			   struct udp_tunnel_sock_cfg *cfg)
 {
@@ -80,6 +89,9 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 	udp_sk(sk)->gro_complete = cfg->gro_complete;
 
 	udp_tunnel_encap_enable(sk);
+
+	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sock->sk))
+		udp_tunnel_update_gro_lookup(net, sock->sk, true);
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3a0d6c5a8286b..4701b0dee8c4e 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -46,6 +46,7 @@
 #include <net/tcp_states.h>
 #include <net/ip6_checksum.h>
 #include <net/ip6_tunnel.h>
+#include <net/udp_tunnel.h>
 #include <net/xfrm.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
@@ -1825,6 +1826,7 @@ void udpv6_destroy_sock(struct sock *sk)
 		if (udp_test_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udpv6_encap_needed_key);
 			udp_encap_disable();
+			udp_tunnel_cleanup_gro(sk);
 		}
 	}
 }
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 404212dfc99ab..d8445ac1b2e43 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -118,8 +118,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net_rcu(skb->dev);
+	struct sock *sk;
 	int iif, sdif;
 
+	sk = udp_tunnel_sk(net, true);
+	if (sk && dport == htons(sk->sk_num))
+		return sk;
+
 	inet6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-- 
2.48.1


