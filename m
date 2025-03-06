Return-Path: <netdev+bounces-172490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED7A54FD1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFED18951A8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E8211469;
	Thu,  6 Mar 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQk6FBv8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821672116EE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276647; cv=none; b=j5d1rUIkTEIkbFIm+Ehb/MsfYpc+CuySqGVnVzO+h4CvAbzbJt/Ac0+nbguRd8xWar1fk38GI+BDAhUQOTqmFRpEVxjDcnOrm02k0slQHXNxzP4sF/Jh4o9lFvrY0mkCyE8xocXHqrIzmVUyRj9igC2w2E6ES/G57pTlzOCMWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276647; c=relaxed/simple;
	bh=nyiMb4h/KO1xCYBpgGF0GTS6zj29NyoHS1KUfmI57lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjR46hlZM8++5u7kUEc4kYN09/pGaYR2hoBSKm+td86MEnq+4D8RsgajIE/im8XuDZeSKUZKdySmvNltoObhI1Gh2YdfKLhSTmQljQL0eStHFsioTQXAAoW1E3AYQtOHHTf41QTafzodVIvaCHdVA+hjfxYPtNoSNrtEfKbR4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQk6FBv8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741276644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTVAOUEJBmlBiXbGwU6e9R/tRR5TnJAX3ltWe0AalLY=;
	b=JQk6FBv87uuGa+agWdwzwHj3xykGpLoqAbr7L5SnL0DCmRuNC2PaKfLpVRHc3tuQJnBQ30
	a8IbdPPYlUHRhL2dr9QMJiSYjr23TDMb5h8GqGFA+9GVRzoGMD+sDj6Yxoc/2WpJLEaMEX
	Wh0uAKhhDZdv7wBZUiG7GAGpVzFbmsA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-M9-yZMzhPV2fS251jsAZrw-1; Thu,
 06 Mar 2025 10:57:12 -0500
X-MC-Unique: M9-yZMzhPV2fS251jsAZrw-1
X-Mimecast-MFC-AGG-ID: M9-yZMzhPV2fS251jsAZrw_1741276631
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A8FD180035C;
	Thu,  6 Mar 2025 15:57:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.236])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A89731828A86;
	Thu,  6 Mar 2025 15:57:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 1/2] udp_tunnel: create a fast-path GRO lookup.
Date: Thu,  6 Mar 2025 16:56:52 +0100
Message-ID: <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
In-Reply-To: <cover.1741275846.git.pabeni@redhat.com>
References: <cover.1741275846.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Most UDP tunnels bind a socket to a local port, with ANY address, no
peer and no interface index specified.
Additionally it's quite common to have a single tunnel device per
namespace.

Track in each namespace the UDP tunnel socket respecting the above.
When only a single one is present, store a reference in the netns.

When such reference is not NULL, UDP tunnel GRO lookup just need to
match the incoming packet destination port vs the socket local port.

The tunnel socket never set the reuse[port] flag[s], when bound to no
address and interface, no other socket can exist in the same netns
matching the specified local port.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/udp.h        | 16 ++++++++++++++++
 include/net/netns/ipv4.h   | 11 +++++++++++
 include/net/udp.h          |  1 +
 include/net/udp_tunnel.h   | 18 ++++++++++++++++++
 net/ipv4/udp.c             | 15 +++++++++++++--
 net/ipv4/udp_offload.c     | 37 +++++++++++++++++++++++++++++++++++++
 net/ipv4/udp_tunnel_core.c | 12 ++++++++++++
 net/ipv6/udp.c             |  2 ++
 net/ipv6/udp_offload.c     |  5 +++++
 9 files changed, 115 insertions(+), 2 deletions(-)

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
index 17c7736d83494..d1aa96ac52888 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2891,8 +2891,10 @@ void udp_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (udp_test_bit(ENCAP_ENABLED, sk))
-			static_branch_dec(&udp_encap_needed_key);
+		if (udp_test_bit(ENCAP_ENABLED, sk)) {
+			udp_tunnel_cleanup_gro(sk);
+			udp_encap_disable();
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
+		rcu_assign_pointer(net->ipv4.udp_tunnel_gro[1].sk, NULL);
+	}
+#endif
 	udp_sysctl_init(net);
 	udp_set_table(net);
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index c1a85b300ee87..ac6dd2703190e 100644
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
@@ -631,8 +663,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
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
index 619a53eb672da..b969c997c89c7 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -58,6 +58,15 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL(udp_sock_create4);
 
+static inline bool sk_saddr_any(struct sock *sk)
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
index 3a0d6c5a8286b..3087022d18a55 100644
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
@@ -1824,6 +1825,7 @@ void udpv6_destroy_sock(struct sock *sk)
 		}
 		if (udp_test_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udpv6_encap_needed_key);
+			udp_tunnel_cleanup_gro(sk);
 			udp_encap_disable();
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


