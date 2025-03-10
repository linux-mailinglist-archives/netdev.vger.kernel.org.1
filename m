Return-Path: <netdev+bounces-173630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F48A5A3A7
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF80188FCE9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D462235BF3;
	Mon, 10 Mar 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYCD58Px"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5D1B395F
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633831; cv=none; b=Dhmb4XoL9wnn04uvEDDE6LAUQhzIyaB5mHbZWKF2wj7Sjop8daOqx7ukdSBHpFt+a9n2iy/E3Edvbkq5f8xwLO3ZUm55Gfcx7Nv+yEwwATGckhyPetpbJJsVzpynoE1G1WJu72U0QqyaFFjbZoIdaG99Ywk8AMGuRYzpPbaWjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633831; c=relaxed/simple;
	bh=wZu87+X6ftKQbmyNarhALtFPOue7R4ZxneKtipfb6s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlcyaoGrhu2xGPrDNShREQfGe4bBgLj4VglifC5WXEw+7Jig5l85s8tktX17XCD1+i0DINK0MzvYWXyuB56am28FeDr8KkpuqfHxvNpZnjUH0KtqqKo5rE35TXUlIdAeDOV8IaDGeg//zZ1AzXpvStF0lCl8nUVoehVTR3S1sCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYCD58Px; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741633828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sRfUVCukstTTBJ/CDTildIDkpuJpFRqmBQgzDMrrDk=;
	b=DYCD58PxkepuAT8lBjzUplL7S4iGvNFHPrVV8auCAo6XSmkV88yrqb23t6mG1gGONocnwQ
	O3bWtnR2ss+D7ULds7FsR4KhSdQestIOTp9eSPLhZQo4oR35viHXgBRv5SWH+0+wUXbXhh
	qcLK6CC4WCIJsPQeGsgcVoSuQ3LFJRg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-eT2_0n3RNaK7K02x-DaYAA-1; Mon,
 10 Mar 2025 15:10:26 -0400
X-MC-Unique: eT2_0n3RNaK7K02x-DaYAA-1
X-Mimecast-MFC-AGG-ID: eT2_0n3RNaK7K02x-DaYAA_1741633824
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D3A7195605E;
	Mon, 10 Mar 2025 19:10:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.22.89.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 166051956094;
	Mon, 10 Mar 2025 19:10:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	kuniyu@amazon.com
Subject: [PATCH v3 net-next 2/2] udp_tunnel: use static call for GRO hooks when possible
Date: Mon, 10 Mar 2025 20:09:49 +0100
Message-ID: <b65c13770225f4a655657373f5ad90bcef3f57c9.1741632298.git.pabeni@redhat.com>
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

It's quite common to have a single UDP tunnel type active in the
whole system. In such a case we can replace the indirect call for
the UDP tunnel GRO callback with a static call.

Add the related accounting in the control path and switch to static
call when possible. To keep the code simple use a static array for
the registered tunnel types, and size such array based on the kernel
config.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - avoid unneeded checks in udp_tunnel_update_gro_rcv()

v1 -> v2:
 - fix UDP_TUNNEL=n build
---
 include/net/udp_tunnel.h   |   4 ++
 net/ipv4/udp_offload.c     | 137 ++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp_tunnel_core.c |   2 +
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index eda0f3e2f65fa..a7b230867eb14 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -205,9 +205,11 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
 void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
+void udp_tunnel_update_gro_rcv(struct sock *sk, bool add);
 #else
 static inline void udp_tunnel_update_gro_lookup(struct net *net,
 						struct sock *sk, bool add) {}
+static inline void udp_tunnel_update_gro_rcv(struct sock *sk, bool add) {}
 #endif
 
 static inline void udp_tunnel_cleanup_gro(struct sock *sk)
@@ -215,6 +217,8 @@ static inline void udp_tunnel_cleanup_gro(struct sock *sk)
 	struct udp_sock *up = udp_sk(sk);
 	struct net *net = sock_net(sk);
 
+	udp_tunnel_update_gro_rcv(sk, false);
+
 	if (!up->tunnel_list.pprev)
 		return;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 054d4d4a8927f..500b2a20053cd 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -15,6 +15,39 @@
 #include <net/udp_tunnel.h>
 
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+
+/*
+ * Dummy GRO tunnel callback; should never be invoked, exists
+ * mainly to avoid dangling/NULL values for the udp tunnel
+ * static call.
+ */
+static struct sk_buff *dummy_gro_rcv(struct sock *sk,
+				     struct list_head *head,
+				     struct sk_buff *skb)
+{
+	WARN_ON_ONCE(1);
+	NAPI_GRO_CB(skb)->flush = 1;
+	return NULL;
+}
+
+typedef struct sk_buff *(*udp_tunnel_gro_rcv_t)(struct sock *sk,
+						struct list_head *head,
+						struct sk_buff *skb);
+
+struct udp_tunnel_type_entry {
+	udp_tunnel_gro_rcv_t gro_receive;
+	refcount_t count;
+};
+
+#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
+			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
+			      IS_ENABLED(CONFIG_FOE) * 2)
+
+DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
+static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
+static struct mutex udp_tunnel_gro_type_lock;
+static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
+static unsigned int udp_tunnel_gro_type_nr;
 static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
 
 void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
@@ -43,6 +76,106 @@ void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
 	spin_unlock(&udp_tunnel_gro_lock);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
+
+void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
+{
+	struct udp_tunnel_type_entry *cur = NULL, *avail = NULL;
+	struct udp_sock *up = udp_sk(sk);
+	int i, old_gro_type_nr;
+
+	if (!up->gro_receive)
+		return;
+
+	mutex_lock(&udp_tunnel_gro_type_lock);
+	for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
+		if (!refcount_read(&udp_tunnel_gro_types[i].count))
+			avail = &udp_tunnel_gro_types[i];
+		else if (udp_tunnel_gro_types[i].gro_receive == up->gro_receive)
+			cur = &udp_tunnel_gro_types[i];
+	}
+	old_gro_type_nr = udp_tunnel_gro_type_nr;
+	if (add) {
+		/*
+		 * Update the matching entry, if found, or add a new one
+		 * if needed
+		 */
+		if (cur) {
+			refcount_inc(&cur->count);
+			goto out;
+		}
+
+		if (unlikely(!avail)) {
+			pr_err_once("Too many UDP tunnel types, please increase UDP_MAX_TUNNEL_TYPES\n");
+			/* Ensure static call will never be enabled */
+			udp_tunnel_gro_type_nr = UDP_MAX_TUNNEL_TYPES + 2;
+			goto out;
+		}
+
+		refcount_set(&avail->count, 1);
+		avail->gro_receive = up->gro_receive;
+		udp_tunnel_gro_type_nr++;
+	} else {
+		/*
+		 * The stack cleanups only successfully added tunnel, the
+		 * lookup on removal should never fail.
+		 */
+		if (WARN_ON_ONCE(!cur))
+			goto out;
+
+		if (!refcount_dec_and_test(&cur->count))
+			goto out;
+		udp_tunnel_gro_type_nr--;
+	}
+
+	if (udp_tunnel_gro_type_nr == 1) {
+		for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
+			cur = &udp_tunnel_gro_types[i];
+			if (refcount_read(&cur->count)) {
+				static_call_update(udp_tunnel_gro_rcv,
+						   cur->gro_receive);
+				static_branch_enable(&udp_tunnel_static_call);
+			}
+		}
+	} else if (old_gro_type_nr == 1) {
+		static_branch_disable(&udp_tunnel_static_call);
+		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
+	}
+
+out:
+	mutex_unlock(&udp_tunnel_gro_type_lock);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_rcv);
+
+static void udp_tunnel_gro_init(void)
+{
+	mutex_init(&udp_tunnel_gro_type_lock);
+}
+
+static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+					  struct list_head *head,
+					  struct sk_buff *skb)
+{
+	if (static_branch_likely(&udp_tunnel_static_call)) {
+		if (unlikely(gro_recursion_inc_test(skb))) {
+			NAPI_GRO_CB(skb)->flush |= 1;
+			return NULL;
+		}
+		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
+	}
+	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+}
+
+#else
+
+static void udp_tunnel_gro_init(void) {}
+
+static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+					  struct list_head *head,
+					  struct sk_buff *skb)
+{
+	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+}
+
 #endif
 
 static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
@@ -654,7 +787,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
 	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
-	pp = call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+	pp = udp_tunnel_gro_rcv(sk, head, skb);
 
 out:
 	skb_gro_flush_final(skb, pp, flush);
@@ -804,5 +937,7 @@ int __init udpv4_offload_init(void)
 			.gro_complete =	udp4_gro_complete,
 		},
 	};
+
+	udp_tunnel_gro_init();
 	return inet_add_offload(&net_hotdata.udpv4_offload, IPPROTO_UDP);
 }
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b5695826e57ad..c49fceea83139 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -90,6 +90,8 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 
 	udp_tunnel_encap_enable(sk);
 
+	udp_tunnel_update_gro_rcv(sock->sk, true);
+
 	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sock->sk))
 		udp_tunnel_update_gro_lookup(net, sock->sk, true);
 }
-- 
2.48.1


