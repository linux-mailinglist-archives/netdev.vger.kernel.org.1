Return-Path: <netdev+bounces-179713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F2A7E542
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970461885725
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED320459A;
	Mon,  7 Apr 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0YI0mJd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA122040B9
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040773; cv=none; b=ejkWvCaey+OSlukze3RDQ6kgAwlLVqySvNCguG9BHEGR/9j0caae5ONT63WiPA81nU9vQnFszS9EV0QtPC0cv+CFoNesDpUg+YcjnxgRlNnCN/awG4m5WnvGylwZxlUsFUCN9Kt4lypapAUHGHjhXxXUxzjVVERra3tJGVq1TGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040773; c=relaxed/simple;
	bh=zzRv415h8yriN7j+B/JaQfjE4zjkzQ26puDUDhUaLNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTb9UKmiF3SgLL3MJ7sHQs1nYUOPBYTIxt16BahiaAVknMIFPYp9oyt6JjovIIJK+Qc7p0LB+b4nk9tji9vcBvCdq6X/8GB2HpBPeNhLYByYT2/+4tkNL5IwWZd2Govezb3NVvNWZ9oIMxG5Z0Jo6wK8fNm8+8MzITtzd98QcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0YI0mJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744040770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUOjWRrfbMfWXEfUbK9BGm7RPiol1b+7cydimzKP2Wc=;
	b=X0YI0mJdYPrcLvearUlJnfDikbb7fIhto1kuux+7FSzpK0qUKW8Ql3E+fJkeEJUmemm4UA
	gX3ovPo2J6RcqJkTonZJ4Q/TumZun0hFviI+l1/2USefmAUcqvJQlpAMXr1niC0gWkjp7c
	cTXjEV7DpJZdMepj6nxwN/dNFOjKUhE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-L7b3zCX2O-mJlthgOxbgYA-1; Mon,
 07 Apr 2025 11:46:06 -0400
X-MC-Unique: L7b3zCX2O-mJlthgOxbgYA-1
X-Mimecast-MFC-AGG-ID: L7b3zCX2O-mJlthgOxbgYA_1744040765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6AE7180AB16;
	Mon,  7 Apr 2025 15:46:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FC081809B73;
	Mon,  7 Apr 2025 15:46:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v5 2/2] udp_tunnel: use static call for GRO hooks when  possible
Date: Mon,  7 Apr 2025 17:45:42 +0200
Message-ID: <53d156cdfddcc9678449e873cc83e68fa1582653.1744040675.git.pabeni@redhat.com>
In-Reply-To: <cover.1744040675.git.pabeni@redhat.com>
References: <cover.1744040675.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

It's quite common to have a single UDP tunnel type active in the
whole system. In such a case we can replace the indirect call for
the UDP tunnel GRO callback with a static call.

Add the related accounting in the control path and switch to static
call when possible. To keep the code simple use a static array for
the registered tunnel types, and size such array based on the kernel
config.

Note that there are valid kernel configurations leading to
UDP_MAX_TUNNEL_TYPES == 0 even with IS_ENABLED(CONFIG_NET_UDP_TUNNEL),
Explicitly skip the accounting in such a case, to avoid compile warning
when accessing "udp_tunnel_gro_types".

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - move the add hook in udp_tunnel_encap_enable() to deal with xfrm
 - avoid warnings when UDP_MAX_TUNNEL_TYPES == 0
---
 include/net/udp_tunnel.h |   4 ++
 net/ipv4/udp_offload.c   | 135 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 1bb2b852e90eb..288f06f23a804 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -193,13 +193,16 @@ static inline int udp_tunnel_handle_offloads(struct sk_buff *skb, bool udp_csum)
 
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
 void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
+void udp_tunnel_update_gro_rcv(struct sock *sk, bool add);
 #else
 static inline void udp_tunnel_update_gro_lookup(struct net *net,
 						struct sock *sk, bool add) {}
+static inline void udp_tunnel_update_gro_rcv(struct sock *sk, bool add) {}
 #endif
 
 static inline void udp_tunnel_cleanup_gro(struct sock *sk)
 {
+	udp_tunnel_update_gro_rcv(sk, false);
 	udp_tunnel_update_gro_lookup(sock_net(sk), sk, false);
 }
 
@@ -212,6 +215,7 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 	if (READ_ONCE(sk->sk_family) == PF_INET6)
 		ipv6_stub->udpv6_encap_enable();
 #endif
+	udp_tunnel_update_gro_rcv(sk, true);
 	udp_encap_enable();
 }
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 69fc4eae82509..787b2947d3a04 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -15,6 +15,38 @@
 #include <net/udp_tunnel.h>
 
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+
+/*
+ * Dummy GRO tunnel callback, exists mainly to avoid dangling/NULL
+ * values for the udp tunnel static call.
+ */
+static struct sk_buff *dummy_gro_rcv(struct sock *sk,
+				     struct list_head *head,
+				     struct sk_buff *skb)
+{
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
+			      IS_ENABLED(CONFIG_NET_FOU) * 2 + \
+			      IS_ENABLED(CONFIG_XFRM) * 2)
+
+DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
+static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
+static struct mutex udp_tunnel_gro_type_lock;
+static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
+static unsigned int udp_tunnel_gro_type_nr;
 static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
 
 void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
@@ -43,6 +75,105 @@ void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
 	spin_unlock(&udp_tunnel_gro_lock);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
+
+void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
+{
+	struct udp_tunnel_type_entry *cur = NULL;
+	struct udp_sock *up = udp_sk(sk);
+	int i, old_gro_type_nr;
+
+	if (!UDP_MAX_TUNNEL_TYPES || !up->gro_receive)
+		return;
+
+	mutex_lock(&udp_tunnel_gro_type_lock);
+
+	/* Check if the static call is permanently disabled. */
+	if (udp_tunnel_gro_type_nr > UDP_MAX_TUNNEL_TYPES)
+		goto out;
+
+	for (i = 0; i < udp_tunnel_gro_type_nr; i++)
+		if (udp_tunnel_gro_types[i].gro_receive == up->gro_receive)
+			cur = &udp_tunnel_gro_types[i];
+
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
+		if (unlikely(udp_tunnel_gro_type_nr == UDP_MAX_TUNNEL_TYPES)) {
+			pr_err_once("Too many UDP tunnel types, please increase UDP_MAX_TUNNEL_TYPES\n");
+			/* Ensure static call will never be enabled */
+			udp_tunnel_gro_type_nr = UDP_MAX_TUNNEL_TYPES + 1;
+		} else {
+			cur = &udp_tunnel_gro_types[udp_tunnel_gro_type_nr++];
+			refcount_set(&cur->count, 1);
+			cur->gro_receive = up->gro_receive;
+		}
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
+
+		/* Avoid gaps, so that the enable tunnel has always id 0 */
+		*cur = udp_tunnel_gro_types[--udp_tunnel_gro_type_nr];
+	}
+
+	if (udp_tunnel_gro_type_nr == 1) {
+		static_call_update(udp_tunnel_gro_rcv,
+				   udp_tunnel_gro_types[0].gro_receive);
+		static_branch_enable(&udp_tunnel_static_call);
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
@@ -654,7 +785,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
 	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
-	pp = call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+	pp = udp_tunnel_gro_rcv(sk, head, skb);
 
 out:
 	skb_gro_flush_final(skb, pp, flush);
@@ -804,5 +935,7 @@ int __init udpv4_offload_init(void)
 			.gro_complete =	udp4_gro_complete,
 		},
 	};
+
+	udp_tunnel_gro_init();
 	return inet_add_offload(&net_hotdata.udpv4_offload, IPPROTO_UDP);
 }
-- 
2.49.0


