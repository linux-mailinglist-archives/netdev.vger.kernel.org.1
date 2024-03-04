Return-Path: <netdev+bounces-77135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542F08704E2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96211F22F75
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641A47772;
	Mon,  4 Mar 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TxqAPcSu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B44654D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564952; cv=none; b=o+f6BNGPhj0zQHkSaJ5Qn2R3tcFEUECgzih/VoVngvUQ6zfiZaBZwlbQX2O4liYsK9xgte4g72hA4ReVlWQ29tbfPKbMbk8uonK+tJ+tWYNsgG1G9rolefQh4O7PZw1X0IQyoyYUd0hfVUkhTWUlngOVgHicSuGiRzuA5fI2jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564952; c=relaxed/simple;
	bh=0uHvNqge0g5+oMCpAhJpb7pk3yrVFs1Um2wuDzpgEKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKBb8LgYOv34KojWNmV08tSApvv8bAtujaRJJ/LjQoh+EihHnOqwNKOcrQ45FFEzQ5bcT55OvYdXQdcE3Ah30kuieliV75MfiauIpw2dIZO3+vK+o+KAQFz7qK7XClJHHytCr1Fg/61fW36wsDf9/vrDP0g7TiRqWipmiLKcv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TxqAPcSu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso7061187a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564948; x=1710169748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVoD/qM4/J9XR9S2ryBZSRE0SrIwZoL90WAcffrOiRI=;
        b=TxqAPcSu+86DatwHwyFlboSVYgW34VisxWsDZTaXn+rARco+WpZ1VPsvYJLmSQjToI
         uW5fCo8XdT5y6/WzWrRngQ0vPCChBP2e8h0RJq+x4hp3Mt7wXsV4JW8wNK6KinD6L9a8
         QTz9a0aXdAl/I3mIlz3+rDSARNLtC8eQwj/5pmXz8e0H2xFkdQVy2+yqsAduMyOXyfGT
         RHe+rbF+4ZtEpebSK7+HrQXXkqgvYJHKQbduIgRjRCzJITO+0RY6KfegzA8BmUeVlYoT
         U7zrqDtLupa43IfGlsVSPkUVUOtQyxPRWc1PJkjL9OBAz4zr3k82WAIh0R51stTOBoj+
         5FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564948; x=1710169748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVoD/qM4/J9XR9S2ryBZSRE0SrIwZoL90WAcffrOiRI=;
        b=pWFzeix0+z3TdRegr+YcPZ0fqmWyUoN7VoshERzTMwLWqHk6jNgrOiBc7kCAA1Z1SX
         8BYWcal/qvQckKFywmO+W94YMxsuXS26QZN91jzMfnGPEh0jh2iVrmuQcbVFiscUfOji
         rmJwOBU/2oW2uJwe3ZAS328hjoogL3m/EefodcMFKD6inMmQMTjZi41dXJcElhFyMoDE
         bF4ltKMqujZVydOCm5WtOVofxiuwSj8JnXywwbym/5pdMcaPgIwPiAZUFH3sLFgxSuOn
         UDVNGSeMRdRfHbK2edAp3yCAsyNdUMvt3IK7CDRcJD1GioavDGljD2n58tPvyySRmr2f
         axqQ==
X-Gm-Message-State: AOJu0YxeJC54rj9K0heEQ8FSevuT6+mLg6TWR8eaORREzW/7YLJhI8K2
	cIi0fJdIQBcryXhJQqRc0d9nuHzPoT0J/WKiIErW/eoK/6DWkpG32qpyv7AurMchXAykDErfutG
	R/5s=
X-Google-Smtp-Source: AGHT+IGxTAzNHVlmQPZpBOsAj3s+tLpOLQdtbSzFBBjwhwsu0dG7VJ1OSwFv3Ss8wKicSi6mRH7Vcg==
X-Received: by 2002:a17:906:1114:b0:a43:bb3b:3b5a with SMTP id h20-20020a170906111400b00a43bb3b3b5amr6697829eja.22.1709564947775;
        Mon, 04 Mar 2024 07:09:07 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 08/22] ovpn: implement basic TX path (UDP)
Date: Mon,  4 Mar 2024 16:08:59 +0100
Message-ID: <20240304150914.11444-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packets sent over the ovpn interface are processed and transmitted to the
connected peer, if any.

Impementation is UDP only. TCP will be added by a later patch.

Note: no crypto/encapsulation exists yet. packets are just captured and
sent.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         | 165 ++++++++++++++++++++++++++++-
 drivers/net/ovpn/io.h         |   2 +
 drivers/net/ovpn/main.c       |   2 +
 drivers/net/ovpn/ovpnstruct.h |   3 +
 drivers/net/ovpn/peer.c       |   5 +
 drivers/net/ovpn/peer.h       |   9 ++
 drivers/net/ovpn/udp.c        | 188 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h        |   4 +
 8 files changed, 377 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ede15c84ea69..d2fdb7485023 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -11,9 +11,11 @@
 #include "ovpnstruct.h"
 #include "netlink.h"
 #include "peer.h"
+#include "udp.h"
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 
 
 int ovpn_struct_init(struct net_device *dev)
@@ -31,6 +33,11 @@ int ovpn_struct_init(struct net_device *dev)
 
 	spin_lock_init(&ovpn->lock);
 
+	ovpn->crypto_wq = alloc_workqueue("ovpn-crypto-wq-%s",
+					  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0, dev->name);
+	if (!ovpn->crypto_wq)
+		return -ENOMEM;
+
 	ovpn->events_wq = alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLAIM, 0, dev->name);
 	if (!ovpn->events_wq)
 		return -ENOMEM;
@@ -46,11 +53,167 @@ int ovpn_struct_init(struct net_device *dev)
 	return 0;
 }
 
+static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	return true;
+}
+
+/* Process packets in TX queue in a transport-specific way.
+ *
+ * UDP transport - encrypt and send across the tunnel.
+ */
+void ovpn_encrypt_work(struct work_struct *work)
+{
+	struct sk_buff *skb, *curr, *next;
+	struct ovpn_peer *peer;
+
+	peer = container_of(work, struct ovpn_peer, encrypt_work);
+	while ((skb = ptr_ring_consume_bh(&peer->tx_ring))) {
+		/* this might be a GSO-segmented skb list: process each skb
+		 * independently
+		 */
+		skb_list_walk_safe(skb, curr, next) {
+			/* if one segment fails encryption, we drop the entire
+			 * packet, because it does not really make sense to send
+			 * only part of it at this point
+			 */
+			if (unlikely(!ovpn_encrypt_one(peer, curr))) {
+				kfree_skb_list(skb);
+				skb = NULL;
+				break;
+			}
+		}
+
+		/* successful encryption */
+		if (likely(skb)) {
+			skb_list_walk_safe(skb, curr, next) {
+				skb_mark_not_on_list(curr);
+
+				switch (peer->sock->sock->sk->sk_protocol) {
+				case IPPROTO_UDP:
+					ovpn_udp_send_skb(peer->ovpn, peer, curr);
+					break;
+				default:
+					/* no transport configured yet */
+					consume_skb(skb);
+					break;
+				}
+			}
+		}
+
+		/* give a chance to be rescheduled if needed */
+		cond_resched();
+	}
+	ovpn_peer_put(peer);
+}
+
+/* send skb to connected peer, if any */
+static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb, struct ovpn_peer *peer)
+{
+	int ret;
+
+	if (likely(!peer))
+		/* retrieve peer serving the destination IP of this packet */
+		peer = ovpn_peer_lookup_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		net_dbg_ratelimited("%s: no peer to send data to\n", ovpn->dev->name);
+		goto drop;
+	}
+
+	ret = ptr_ring_produce_bh(&peer->tx_ring, skb);
+	if (unlikely(ret < 0)) {
+		net_err_ratelimited("%s: cannot queue packet to TX ring\n", peer->ovpn->dev->name);
+		goto drop;
+	}
+
+	if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
+		ovpn_peer_put(peer);
+
+	return;
+drop:
+	if (peer)
+		ovpn_peer_put(peer);
+	kfree_skb_list(skb);
+}
+
+/* Return IP protocol version from skb header.
+ * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
+ */
+static __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
+{
+	__be16 proto = 0;
+
+	/* skb could be non-linear, make sure IP header is in non-fragmented part */
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		return 0;
+
+	if (ip_hdr(skb)->version == 4)
+		proto = htons(ETH_P_IP);
+	else if (ip_hdr(skb)->version == 6)
+		proto = htons(ETH_P_IPV6);
+
+	return proto;
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+	struct sk_buff *segments, *tmp, *curr, *next;
+	struct sk_buff_head skb_list;
+	__be16 proto;
+	int ret;
+
+	/* reset netfilter state */
+	nf_reset_ct(skb);
+
+	/* verify IP header size in network packet */
+	proto = ovpn_ip_check_protocol(skb);
+	if (unlikely(!proto || skb->protocol != proto)) {
+		net_err_ratelimited("%s: dropping malformed payload packet\n",
+				    dev->name);
+		goto drop;
+	}
+
+	if (skb_is_gso(skb)) {
+		segments = skb_gso_segment(skb, 0);
+		if (IS_ERR(segments)) {
+			ret = PTR_ERR(segments);
+			net_err_ratelimited("%s: cannot segment packet: %d\n", dev->name, ret);
+			goto drop;
+		}
+
+		consume_skb(skb);
+		skb = segments;
+	}
+
+	/* from this moment on, "skb" might be a list */
+
+	__skb_queue_head_init(&skb_list);
+	skb_list_walk_safe(skb, curr, next) {
+		skb_mark_not_on_list(curr);
+
+		tmp = skb_share_check(curr, GFP_ATOMIC);
+		if (unlikely(!tmp)) {
+			kfree_skb_list(next);
+			net_err_ratelimited("%s: skb_share_check failed\n", dev->name);
+			goto drop_list;
+		}
+
+		__skb_queue_tail(&skb_list, tmp);
+	}
+	skb_list.prev->next = NULL;
+
+	ovpn_queue_skb(ovpn, skb_list.next, NULL);
+
+	return NETDEV_TX_OK;
+
+drop_list:
+	skb_queue_walk_safe(&skb_list, curr, next)
+		kfree_skb(curr);
+drop:
 	skb_tx_error(skb);
-	kfree_skb(skb);
+	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index e7728718c8a9..633b9fb3276c 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -17,4 +17,6 @@ struct sk_buff;
 int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
+void ovpn_encrypt_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3e054811b8c6..95a94ccc99c1 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -42,7 +42,9 @@ static void ovpn_struct_free(struct net_device *net)
 
 	security_tun_dev_free_security(ovpn->security);
 	free_percpu(net->tstats);
+	flush_workqueue(ovpn->crypto_wq);
 	flush_workqueue(ovpn->events_wq);
+	destroy_workqueue(ovpn->crypto_wq);
 	destroy_workqueue(ovpn->events_wq);
 	rcu_barrier();
 }
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index a595d44f2276..300906bc694f 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -28,6 +28,9 @@ struct ovpn_struct {
 	/* protect writing to the ovpn_struct object */
 	spinlock_t lock;
 
+	/* workqueue used to schedule crypto work that may sleep during TX/RX */
+	struct workqueue_struct *crypto_wq;
+
 	/* workqueue used to schedule generic event that may sleep or that need
 	 * to be performed out of softirq context
 	 */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4319271927a4..4dbbd25b25c9 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -44,6 +44,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
 
+	INIT_WORK(&peer->encrypt_work, ovpn_encrypt_work);
+
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
 		netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n", __func__);
@@ -112,6 +114,9 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 
 void ovpn_peer_release(struct ovpn_peer *peer)
 {
+	if (peer->sock)
+		ovpn_socket_put(peer->sock);
+
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index c3ccbb6bdf41..ef4174be7dea 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,7 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include "bind.h"
+#include "socket.h"
 
 #include <linux/ptr_ring.h>
 #include <net/dst_cache.h>
@@ -27,10 +28,18 @@ struct ovpn_peer {
 		struct in6_addr ipv6;
 	} vpn_addrs;
 
+	/* work objects to handle encryption/decryption of packets.
+	 * these works are queued on the ovpn->crypt_wq workqueue.
+	 */
+	struct work_struct encrypt_work;
+	struct work_struct decrypt_work;
+
 	struct ptr_ring tx_ring;
 	struct ptr_ring rx_ring;
 	struct ptr_ring netif_rx_ring;
 
+	struct ovpn_socket *sock;
+
 	struct dst_cache dst_cache;
 
 	/* our binding to peer, protected by spinlock */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 8bfd0eece1d9..b7d972eb66c8 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,12 +7,200 @@
  */
 
 #include "main.h"
+#include "bind.h"
+#include "io.h"
 #include "ovpnstruct.h"
+#include "peer.h"
 #include "socket.h"
 #include "udp.h"
 
+#include <linux/inetdevice.h>
+#include <linux/skbuff.h>
 #include <linux/socket.h>
+#include <net/addrconf.h>
+#include <net/dst_cache.h>
+#include <net/route.h>
+#include <net/ipv6_stubs.h>
+#include <net/udp_tunnel.h>
 
+static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.saddr = bind->local.ipv4.s_addr,
+		.daddr = bind->sa.in4.sin_addr.s_addr,
+		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_dport = bind->sa.in4.sin_port,
+		.flowi4_proto = sk->sk_protocol,
+		.flowi4_mark = sk->sk_mark,
+	};
+	int ret;
+
+	local_bh_disable();
+	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	if (rt)
+		goto transmit;
+
+	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr, RT_SCOPE_HOST))) {
+		/* we may end up here when the cached address is not usable anymore.
+		 * In this case we reset address/cache and perform a new look up
+		 */
+		fl.saddr = 0;
+		bind->local.ipv4.s_addr = 0;
+		dst_cache_reset(cache);
+	}
+
+	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
+		fl.saddr = 0;
+		bind->local.ipv4.s_addr = 0;
+		dst_cache_reset(cache);
+
+		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	}
+
+	if (IS_ERR(rt)) {
+		ret = PTR_ERR(rt);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n", ovpn->dev->name,
+				    &bind->sa.in4, ret);
+		goto err;
+	}
+	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+
+transmit:
+	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
+			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
+			    fl.fl4_dport, false, sk->sk_no_check_tx);
+	ret = 0;
+err:
+	local_bh_enable();
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int ovpn_udp6_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+	int ret;
+
+	struct flowi6 fl = {
+		.saddr = bind->local.ipv6,
+		.daddr = bind->sa.in6.sin6_addr,
+		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_dport = bind->sa.in6.sin6_port,
+		.flowi6_proto = sk->sk_protocol,
+		.flowi6_mark = sk->sk_mark,
+		.flowi6_oif = bind->sa.in6.sin6_scope_id,
+	};
+
+	local_bh_disable();
+	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	if (dst)
+		goto transmit;
+
+	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
+		/* we may end up here when the cached address is not usable anymore.
+		 * In this case we reset address/cache and perform a new look up
+		 */
+		fl.saddr = in6addr_any;
+		bind->local.ipv6 = in6addr_any;
+		dst_cache_reset(cache);
+	}
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	if (IS_ERR(dst)) {
+		ret = PTR_ERR(dst);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n", ovpn->dev->name,
+				    &bind->sa.in6, ret);
+		goto err;
+	}
+	dst_cache_set_ip6(cache, dst, &fl.saddr);
+
+transmit:
+	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
+			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
+			     fl.fl6_dport, udp_get_no_check6_tx(sk));
+	ret = 0;
+err:
+	local_bh_enable();
+	return ret;
+}
+#endif
+
+/* Transmit skb utilizing kernel-provided UDP tunneling framework.
+ * rcu_read_lock should be held on entry.
+ *
+ * On return, the skb is consumed.
+ */
+static int ovpn_udp_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
+			   struct dst_cache *cache, struct sock *sk,
+			   struct sk_buff *skb)
+{
+	int ret;
+
+	/* set sk to null if skb is already orphaned */
+	if (!skb->destructor)
+		skb->sk = NULL;
+
+	/* always permit openvpn-created packets to be (outside) fragmented */
+	skb->ignore_df = 1;
+
+	switch (bind->sa.in4.sin_family) {
+	case AF_INET:
+		ret = ovpn_udp4_output(ovpn, bind, cache, sk, skb);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		ret = ovpn_udp6_output(ovpn, bind, cache, sk, skb);
+		break;
+#endif
+	default:
+		ret = -EAFNOSUPPORT;
+		break;
+	}
+
+	return ret;
+}
+
+void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+		       struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+	struct socket *sock;
+	int ret = -1;
+
+	skb->dev = ovpn->dev;
+	/* no checksum performed at this layer */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* get socket info */
+	sock = peer->sock->sock;
+	if (unlikely(!sock)) {
+		net_warn_ratelimited("%s: no sock for remote peer\n", __func__);
+		goto out;
+	}
+
+	rcu_read_lock();
+	/* get binding */
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind)) {
+		net_warn_ratelimited("%s: no bind for remote peer\n", __func__);
+		goto out_unlock;
+	}
+
+	/* crypto layer -> transport (UDP) */
+	ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
+
+out_unlock:
+	rcu_read_unlock();
+out:
+	if (ret < 0)
+		kfree_skb(skb);
+}
 
 /* Set UDP encapsulation callbacks */
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 9ba41bd539aa..4d6ba9ecabd1 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -9,10 +9,14 @@
 #ifndef _NET_OVPN_UDP_H_
 #define _NET_OVPN_UDP_H_
 
+#include <linux/skbuff.h>
 #include <net/sock.h>
 
+struct ovpn_peer;
 struct ovpn_struct;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
+void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+		       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_UDP_H_ */
-- 
2.43.0


