Return-Path: <netdev+bounces-93565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5F58BC54C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22D91C21118
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C03D0C2;
	Mon,  6 May 2024 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gN05dGrr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F534315D
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958146; cv=none; b=PcTjzOKxHOscRYogtiHhKwNOlzkFMZ8c+rWu91j6NVj6uZymFpVa8vXro4JstBsRME44mAe/fNC93k+wmkHn2iva61tPBkf7xLNyOOAViGIIGSwp3mU32PoZVcyXseKdtJbFy1PDlCIff/RjfuCYxLhrxr1GhGNGWW/nR6HlR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958146; c=relaxed/simple;
	bh=eV5B0qIy+t5Uomfa2fEFXD0ZRn6mRcpt4eJU8jFIfgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApCG+35q3lGwcuTsGtwvtxIUkugcEqwmM+wg7vVRWUjfJjBQ7k48iG+qL84zOdTBEFo7cPD688K6xKvEgThR0mxWyDr0IJBmHGcJzE++/8BpD7GvGBnogqVDFngyi0q3N5TYyBbJOyqqepINE65Cf2UTfcyTlnrxFr7sAQOfZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gN05dGrr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34f0e55787aso503059f8f.2
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958142; x=1715562942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH5o7SalaXtkoINcaO7v7MdlXcX0U3yrPX+HARBNnKI=;
        b=gN05dGrr9uY4u/vkEKJefGDGPyFK/dkf511B8LtZeLI2UUIgBU57uU1blhb7vl2+81
         ImNJJ6KK7HUGG8o18I+3XhKgZjje2KwGVezMUESOLoqAxjbWm6bGyRY8FKx4V+d+BTgr
         6egFwz6nflsAE3SEyxjA6DNJkBa13CRsv1qbk4BtOAOo7u3eBoyhnpo1149OZXHGR1DC
         18RZbsP3+5GfjI3ro5udWYQeQuqvNK82+sEfpQKGa6jDiIEvqd85O7D7EkklLUhLS4G/
         qv9cSlR/uKjY5aRbBBOMnz9lcpBxgAZAp3S8TRMJqxkBNbUSp66mrl8voAQBdXrt5IDC
         Wtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958142; x=1715562942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH5o7SalaXtkoINcaO7v7MdlXcX0U3yrPX+HARBNnKI=;
        b=AMff4eUYQ49FVDGaOYyGc0L2uMvJmCLOlZkczyOy6dQyMcxlcDKUl66AeeFqNWHrdD
         AQKDVhNR3gD0gYKO0P0S2eG42kpKbCzDeiweDqebqKPSrCwaxoAcDzs4qFDl99JGD3/F
         kcl2JFDrYDZ7Tm69ooi7MwEsjb1hr2FHeXpvhrePtKrWzrh5PgfcJhpJ+kvnvYf2/J40
         bShSddZzo+IxKBrAvIZc8QZqH8ySggJMYOXqbRaYY8ZZ8V2xxtN1F1ZrVkacxfEqMBQ+
         e6YejGL4RuK3dhg9Q7qe2ExDAGPxhzpDnpmn1bMZcHc0DqVF7VQWlGElXwIS1zM0WEsI
         bwVg==
X-Gm-Message-State: AOJu0Yyqpzvc0DSGCOEE/zLP9JYE3a/UKY2QwpaQQjXzXgNj0OzYRL3I
	KN9MPjcY/wGy+sQtdWXigUS40r0eYvDu0nmeTEu+kSjZE8utUtNzfMl8/FqrnkWg/MV+OZLYaP+
	z
X-Google-Smtp-Source: AGHT+IE5ybCNojHn+RvAl1hDmzmsSzhlZ0Bl853D3rSoyTDtTxJu5qbFDU1R/bywAht0kWBK1bqfhg==
X-Received: by 2002:a5d:4288:0:b0:34f:2cea:c87f with SMTP id k8-20020a5d4288000000b0034f2ceac87fmr738670wrq.24.1714958141687;
        Sun, 05 May 2024 18:15:41 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:41 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 09/24] ovpn: implement basic TX path (UDP)
Date: Mon,  6 May 2024 03:16:22 +0200
Message-ID: <20240506011637.27272-10-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
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
 drivers/net/ovpn/io.c         | 174 ++++++++++++++++++++++++++-
 drivers/net/ovpn/io.h         |   2 +
 drivers/net/ovpn/main.c       |   2 +
 drivers/net/ovpn/ovpnstruct.h |   2 +
 drivers/net/ovpn/peer.c       |  37 ++++++
 drivers/net/ovpn/peer.h       |   9 ++
 drivers/net/ovpn/udp.c        | 219 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h        |  14 +++
 8 files changed, 458 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a420bb45f25f..36cfb95edbf4 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,11 +9,13 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 
 #include "io.h"
 #include "ovpnstruct.h"
 #include "netlink.h"
 #include "peer.h"
+#include "udp.h"
 
 int ovpn_struct_init(struct net_device *dev)
 {
@@ -28,6 +30,12 @@ int ovpn_struct_init(struct net_device *dev)
 
 	spin_lock_init(&ovpn->lock);
 
+	ovpn->crypto_wq = alloc_workqueue("ovpn-crypto-wq-%s",
+					  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0,
+					  dev->name);
+	if (!ovpn->crypto_wq)
+		return -ENOMEM;
+
 	ovpn->events_wq = alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLAIM,
 					  0, dev->name);
 	if (!ovpn->events_wq)
@@ -40,11 +48,175 @@ int ovpn_struct_init(struct net_device *dev)
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
+					ovpn_udp_send_skb(peer->ovpn, peer,
+							  curr);
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
+static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb,
+			   struct ovpn_peer *peer)
+{
+	int ret;
+
+	if (likely(!peer))
+		/* retrieve peer serving the destination IP of this packet */
+		peer = ovpn_peer_get_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		net_dbg_ratelimited("%s: no peer to send data to\n",
+				    ovpn->dev->name);
+		goto drop;
+	}
+
+	ret = ptr_ring_produce_bh(&peer->tx_ring, skb);
+	if (unlikely(ret < 0)) {
+		net_err_ratelimited("%s: cannot queue packet to TX ring\n",
+				    peer->ovpn->dev->name);
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
+	/* skb could be non-linear, make sure IP header is in non-fragmented
+	 * part
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
+			net_err_ratelimited("%s: cannot segment packet: %d\n",
+					    dev->name, ret);
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
+			net_err_ratelimited("%s: skb_share_check failed\n",
+					    dev->name);
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
index 61a2485e16b5..171e87f584b6 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -19,4 +19,6 @@
 int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
+void ovpn_encrypt_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index dba35ecb236b..9ae9844dd281 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -39,7 +39,9 @@ static void ovpn_struct_free(struct net_device *net)
 	rtnl_unlock();
 
 	free_percpu(net->tstats);
+	flush_workqueue(ovpn->crypto_wq);
 	flush_workqueue(ovpn->events_wq);
+	destroy_workqueue(ovpn->crypto_wq);
 	destroy_workqueue(ovpn->events_wq);
 	rcu_barrier();
 }
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index b79d4f0474b0..7414c2459fb9 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -18,6 +18,7 @@
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @crypto_wq: used to schedule crypto work that may sleep during TX/RX
  * @event_wq: used to schedule generic events that may sleep and that need to be
  *            performed outside of softirq context
  * @peer: in P2P mode, this is the only remote peer
@@ -28,6 +29,7 @@ struct ovpn_struct {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
+	struct workqueue_struct *crypto_wq;
 	struct workqueue_struct *events_wq;
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2948b7320d47..f023f919b75d 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -39,6 +39,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
 
+	INIT_WORK(&peer->encrypt_work, ovpn_encrypt_work);
+
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
 		netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n",
@@ -119,6 +121,9 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 
 void ovpn_peer_release(struct ovpn_peer *peer)
 {
+	if (peer->sock)
+		ovpn_socket_put(peer->sock);
+
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
 
@@ -288,6 +293,38 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
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
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	/* in P2P mode, no matter the destination, packets are always sent to
+	 * the single peer listening on the other side
+	 */
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		rcu_read_lock();
+		tmp = rcu_dereference(ovpn->peer);
+		if (likely(tmp && ovpn_peer_hold(tmp)))
+			peer = tmp;
+		rcu_read_unlock();
+	}
+
+	return peer;
+}
+
 /**
  * ovpn_peer_add_p2p - add per to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 659df320525c..f915afa260c3 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,7 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include "bind.h"
+#include "socket.h"
 
 #include <linux/ptr_ring.h>
 #include <net/dst_cache.h>
@@ -22,9 +23,12 @@
  * @id: unique identifier
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @encrypt_work: work used to process outgoing packets
+ * @decrypt_work: work used to process incoming packets
  * @tx_ring: queue of outgoing poackets to this peer
  * @rx_ring: queue of incoming packets from this peer
  * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
+ * @sock: the socket being used to talk to this peer
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
@@ -41,9 +45,12 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct work_struct encrypt_work;
+	struct work_struct decrypt_work;
 	struct ptr_ring tx_ring;
 	struct ptr_ring rx_ring;
 	struct ptr_ring netif_rx_ring;
+	struct ovpn_socket *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
@@ -148,5 +155,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
  * Return: a pointer to the peer if found or NULL otherwise
  */
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
+				       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 4b7d96a13df0..f434da76dc0a 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,13 +7,232 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
 #include <linux/socket.h>
+#include <net/addrconf.h>
+#include <net/dst_cache.h>
+#include <net/route.h>
+#include <net/ipv6_stubs.h>
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
+				    ovpn->dev->name, &bind->sa.in4, ret);
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
+				    ovpn->dev->name, &bind->sa.in6, ret);
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
+
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 {
 	struct ovpn_socket *old_data;
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 16422a649cb9..f4eb1e63e103 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -9,7 +9,12 @@
 #ifndef _NET_OVPN_UDP_H_
 #define _NET_OVPN_UDP_H_
 
+#include <linux/skbuff.h>
+#include <net/sock.h>
+
+struct ovpn_peer;
 struct ovpn_struct;
+struct sk_buff;
 struct socket;
 
 /**
@@ -24,4 +29,13 @@ struct socket;
  */
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
 
+/**
+ * ovpn_udp_send_skb - prepare skb and send it over via UDP
+ * @ovpn: the openvpn instance
+ * @peer: the destination peer
+ * @skb: the packet to send
+ */
+void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+		       struct sk_buff *skb);
+
 #endif /* _NET_OVPN_UDP_H_ */
-- 
2.43.2


