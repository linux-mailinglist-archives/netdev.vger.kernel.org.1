Return-Path: <netdev+bounces-128627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D997AA1E
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D965F1F28D55
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B24964E;
	Tue, 17 Sep 2024 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Wkh0RY3W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4443AD4B
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535294; cv=none; b=fz6o3gw2gCeYWX7BU/tY7iIquZH6NCwrMg2pXG+thNmqHef5eqNqKHxrcIAjW+IVpLypRqcJYEfuiqWMVtThiVTq0WAWIl6w3jETSrSL9BSsLAGmKir1VlkHmAKYz/YM1wsmhETvG9KLC30U+MR19MpTYetsZkj4fhRIReT+poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535294; c=relaxed/simple;
	bh=5EKujXyXBBObYJJ03QFkwzlpvqWkeDyxQP9yW4JjVgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxDrWvHopPAuvLnCFlpZ2WAd5kwxprhMVXypiYRWzayNnhOA4MY6laDQwZo5IO+fabtJp8xZzFJbJpyvO7+nEbc8RY0ps4B17R3KBM04jYqkx/OzxpqeorWG/yovMYGAsespQaBF9XN9kRP9giFvJ4Ujb0b5Y9bldzdyls09N5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Wkh0RY3W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so40525115e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535290; x=1727140090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CifBbrAM7xg+/jkcKOzNnhwnXA/NbBbTvnCvQgwqxBI=;
        b=Wkh0RY3WBu66pnDaczyuB7R+H5TezAHAiH6W8hGoPT8IRPWFPLzZEZmF414Hc92AVc
         UibrgS2COodKhfUG9nC/5nPWBauLTcUs3XiJnBi8eiX3b5yyC6jVqT0QsX1Xfbqp4QGW
         1RGKzVRhfPigdv7hJI0ofC9/wsqdA5oa4chHNVlFSO+hq2E8WF/ZbWl1a0XOq0lSEvqM
         jC8e/sft0DDeamw2qqt53j3oYrJqX6b8HQq1c+HAsOPBMIQRfA1DVbNm4WgtY7QqizBa
         1Sk0y5nE2Gn0bypnH1ZQm8EEF8/wtS81N6718aIzubCq0jkxhSssPZ7Tzjp9bK4X+uZZ
         jN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535290; x=1727140090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CifBbrAM7xg+/jkcKOzNnhwnXA/NbBbTvnCvQgwqxBI=;
        b=fCkUXOB3UbXd27XwHBDBTwX7usQ/nyNNxBzMyOclRpwG2EFIuh4iGO5H7u8cZPec/M
         KrQ7wpfLZxgkV7Eu3+dh4s6DIbql7Uhvjoh+ydLChI8uVFWQCZVraHszEEbgco2mese6
         nutvKzZVb3JYlmglXGu8cdVlhyfCSo5vRQO6n7K1zJ5L7yqauRiVNOotz9g9HH1Ldw1H
         bSxa6KtzDR65Aa/qZlAMZtyGU60qh0hTPuNbcGr19fpa0Zc4GrraEznrLpXvxrCLqa1k
         NUcSmNux13gX6Mffe+VrE1YWq9VIS50T0XHq/NLiIgwMNyAO9vCbUk9N+JA4XSbIy8e4
         2piw==
X-Gm-Message-State: AOJu0YwzqBUlHO5rpIpo2xCx4t5nzbomyRicGEpLz8umar9c+qCGMFiI
	OKeGTjA2DUwOebBSXnwKu018BzZx4eAh8a16HOUM3GbwsvP1hwWfX+5oHiKGQUDS/la1LXpyUee
	E
X-Google-Smtp-Source: AGHT+IFh5r6evrMlVwbM+tVCyWj7L31lDdOMIvh5mvMMQ01xEi3QrLBoWWg645kDva8bqldeK9xuRQ==
X-Received: by 2002:a05:600c:1c04:b0:42c:bd5a:9479 with SMTP id 5b1f17b1804b1-42cdb54cf2amr109302795e9.18.1726535289704;
        Mon, 16 Sep 2024 18:08:09 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:09 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 10/25] ovpn: implement basic TX path (UDP)
Date: Tue, 17 Sep 2024 03:07:19 +0200
Message-ID: <20240917010734.1905-11-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packets sent over the ovpn interface are processed and transmitted to the
connected peer, if any.

Implementation is UDP only. TCP will be added by a later patch.

Note: no crypto/encapsulation exists yet. packets are just captured and
sent.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 137 +++++++++++++++++++++++-
 drivers/net/ovpn/peer.c |  37 ++++++-
 drivers/net/ovpn/peer.h |   5 +
 drivers/net/ovpn/skb.h  |  51 +++++++++
 drivers/net/ovpn/udp.c  | 232 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h  |   8 ++
 6 files changed, 467 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ovpn/skb.h

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ad3813419c33..dfd2c90c5684 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,14 +9,149 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 
 #include "io.h"
+#include "ovpnstruct.h"
+#include "peer.h"
+#include "udp.h"
+#include "skb.h"
+
+static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
+{
+	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+
+	if (unlikely(ret < 0))
+		goto err;
+
+	skb_mark_not_on_list(skb);
+
+	switch (peer->sock->sock->sk->sk_protocol) {
+	case IPPROTO_UDP:
+		ovpn_udp_send_skb(peer->ovpn, peer, skb);
+		break;
+	default:
+		/* no transport configured yet */
+		goto err;
+	}
+	/* skb passed down the stack - don't free it */
+	skb = NULL;
+err:
+	if (unlikely(skb))
+		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
+	ovpn_peer_put(peer);
+	kfree_skb(skb);
+}
+
+static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	ovpn_skb_cb(skb)->peer = peer;
+
+	/* take a reference to the peer because the crypto code may run async.
+	 * ovpn_encrypt_post() will release it upon completion
+	 */
+	if (unlikely(!ovpn_peer_hold(peer))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return false;
+	}
+
+	ovpn_encrypt_post(skb, 0);
+	return true;
+}
+
+/* send skb to connected peer, if any */
+static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
+		      struct ovpn_peer *peer)
+{
+	struct sk_buff *curr, *next;
+
+	if (likely(!peer))
+		/* retrieve peer serving the destination IP of this packet */
+		peer = ovpn_peer_get_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		net_dbg_ratelimited("%s: no peer to send data to\n",
+				    ovpn->dev->name);
+		dev_core_stats_tx_dropped_inc(ovpn->dev);
+		goto drop;
+	}
+
+	/* this might be a GSO-segmented skb list: process each skb
+	 * independently
+	 */
+	skb_list_walk_safe(skb, curr, next)
+		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			kfree_skb(curr);
+		}
+
+	/* skb passed over, no need to free */
+	skb = NULL;
+drop:
+	if (likely(peer))
+		ovpn_peer_put(peer);
+	kfree_skb_list(skb);
+}
 
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+	struct sk_buff *segments, *curr, *next;
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
+		dev_core_stats_tx_dropped_inc(ovpn->dev);
+		goto drop;
+	}
+
+	if (skb_is_gso(skb)) {
+		segments = skb_gso_segment(skb, 0);
+		if (IS_ERR(segments)) {
+			ret = PTR_ERR(segments);
+			net_err_ratelimited("%s: cannot segment packet: %d\n",
+					    dev->name, ret);
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
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
+		curr = skb_share_check(curr, GFP_ATOMIC);
+		if (unlikely(!curr)) {
+			net_err_ratelimited("%s: skb_share_check failed\n",
+					    dev->name);
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			continue;
+		}
+
+		__skb_queue_tail(&skb_list, curr);
+	}
+	skb_list.prev->next = NULL;
+
+	ovpn_send(ovpn, skb_list.next, NULL);
+
+	return NETDEV_TX_OK;
+
+drop:
 	skb_tx_error(skb);
-	kfree_skb(skb);
+	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 23ded79eb774..6bde4bd9395b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,7 +9,6 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
-#include <linux/workqueue.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -65,8 +64,10 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
  */
 static void ovpn_peer_release(struct ovpn_peer *peer)
 {
-	ovpn_bind_reset(peer, NULL);
+	if (peer->sock)
+		ovpn_socket_put(peer->sock);
 
+	ovpn_bind_reset(peer, NULL);
 	dst_cache_destroy(&peer->dst_cache);
 }
 
@@ -244,6 +245,38 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_get_by_dst - Lookup peer to send skb to
+ * @ovpn: the private data representing the current VPN session
+ * @skb: the skb to extract the destination address from
+ *
+ * This function takes a tunnel packet and looks up the peer to send it to
+ * after encapsulation. The skb is expected to be the in-tunnel packet, without
+ * any OpenVPN related header.
+ *
+ * Assume that the IP header is accessible in the skb data.
+ *
+ * Return: the peer if found or NULL otherwise.
+ */
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
+				       struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = NULL;
+
+	/* in P2P mode, no matter the destination, packets are always sent to
+	 * the single peer listening on the other side
+	 */
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		rcu_read_lock();
+		peer = rcu_dereference(ovpn->peer);
+		if (unlikely(peer && !ovpn_peer_hold(peer)))
+			peer = NULL;
+		rcu_read_unlock();
+	}
+
+	return peer;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 6c51959363c7..37de5aff54a8 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,7 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include "bind.h"
+#include "socket.h"
 
 #include <net/dst_cache.h>
 #include <uapi/linux/ovpn.h>
@@ -22,6 +23,7 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @sock: the socket being used to talk to this peer
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
@@ -38,6 +40,7 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct ovpn_socket *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
@@ -78,5 +81,7 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
+				       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
new file mode 100644
index 000000000000..e070fe6f448c
--- /dev/null
+++ b/drivers/net/ovpn/skb.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_SKB_H_
+#define _NET_OVPN_SKB_H_
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+struct ovpn_cb {
+	struct ovpn_peer *peer;
+};
+
+static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct ovpn_cb) > sizeof(skb->cb));
+	return (struct ovpn_cb *)skb->cb;
+}
+
+/* Return IP protocol version from skb header.
+ * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
+ */
+static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
+{
+	__be16 proto = 0;
+
+	/* skb could be non-linear,
+	 * make sure IP header is in non-fragmented part
+	 */
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
+#endif /* _NET_OVPN_SKB_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c10474d252e1..d26d7566e9c8 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,14 +7,246 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
 #include <linux/socket.h>
+#include <net/addrconf.h>
+#include <net/dst_cache.h>
+#include <net/route.h>
+#include <net/ipv6_stubs.h>
 #include <net/udp.h>
+#include <net/udp_tunnel.h>
 
 #include "ovpnstruct.h"
 #include "main.h"
+#include "bind.h"
+#include "io.h"
+#include "peer.h"
 #include "socket.h"
 #include "udp.h"
 
+/**
+ * ovpn_udp4_output - send IPv4 packet over udp socket
+ * @ovpn: the openvpn instance
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.saddr = bind->local.ipv4.s_addr,
+		.daddr = bind->remote.in4.sin_addr.s_addr,
+		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_dport = bind->remote.in4.sin_port,
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
+	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
+					RT_SCOPE_HOST))) {
+		/* we may end up here when the cached address is not usable
+		 * anymore. In this case we reset address/cache and perform a
+		 * new look up
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
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    ovpn->dev->name, &bind->remote.in4, ret);
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
+/**
+ * ovpn_udp6_output - send IPv6 packet over udp socket
+ * @ovpn: the openvpn instance
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp6_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+	int ret;
+
+	struct flowi6 fl = {
+		.saddr = bind->local.ipv6,
+		.daddr = bind->remote.in6.sin6_addr,
+		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_dport = bind->remote.in6.sin6_port,
+		.flowi6_proto = sk->sk_protocol,
+		.flowi6_mark = sk->sk_mark,
+		.flowi6_oif = bind->remote.in6.sin6_scope_id,
+	};
+
+	local_bh_disable();
+	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	if (dst)
+		goto transmit;
+
+	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
+		/* we may end up here when the cached address is not usable
+		 * anymore. In this case we reset address/cache and perform a
+		 * new look up
+		 */
+		fl.saddr = in6addr_any;
+		bind->local.ipv6 = in6addr_any;
+		dst_cache_reset(cache);
+	}
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	if (IS_ERR(dst)) {
+		ret = PTR_ERR(dst);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    ovpn->dev->name, &bind->remote.in6, ret);
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
+/**
+ * ovpn_udp_output - transmit skb using udp-tunnel
+ * @ovpn: the openvpn instance
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * rcu_read_lock should be held on entry.
+ * On return, the skb is consumed.
+ *
+ * Return: 0 on success or a negative error code otherwise
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
+	switch (bind->remote.in4.sin_family) {
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
+/**
+ * ovpn_udp_send_skb - prepare skb and send it over via UDP
+ * @ovpn: the openvpn instance
+ * @peer: the destination peer
+ * @skb: the packet to send
+ */
+void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+		       struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+	unsigned int pkt_len;
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
+	pkt_len = skb->len;
+	ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
+
+out_unlock:
+	rcu_read_unlock();
+out:
+	if (unlikely(ret < 0)) {
+		dev_core_stats_tx_dropped_inc(ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
+	dev_sw_netstats_tx_add(ovpn->dev, 1, pkt_len);
+}
+
 /**
  * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
  * @sock: socket to configure
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index f2507f8f2c71..e60f8cd2b4ac 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -9,9 +9,17 @@
 #ifndef _NET_OVPN_UDP_H_
 #define _NET_OVPN_UDP_H_
 
+#include <linux/skbuff.h>
+#include <net/sock.h>
+
+struct ovpn_peer;
 struct ovpn_struct;
+struct sk_buff;
 struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
 
+void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+		       struct sk_buff *skb);
+
 #endif /* _NET_OVPN_UDP_H_ */
-- 
2.44.2


