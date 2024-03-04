Return-Path: <netdev+bounces-77136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D4B8704E3
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BBFB215F7
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2548CD4;
	Mon,  4 Mar 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AdxszqX0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00C487A7
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564953; cv=none; b=McojN/RZ+qJITZ9vvJ+xYi07+cklicJEY/u0xyS/1tXFnusrCSLl8yFrGdlKqSUE3POLD/G2+D667VJyJzW+NX/Gm0TzqBAuvDcNr10X05ixRI0XNwUMe0yw//QFsjinV624CYpNLqOl2F51E03vz7Ml/2dHaAgkMgZpZjsTX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564953; c=relaxed/simple;
	bh=xHLzr5U58BEhWJ+Bzl4Y1Wz/ax3LxbPDGVy2byNTwA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUqMkG/e93vYrjmkTarCj+Ia7T5R+flmlaqzrFqiLlZs9VALJwv5AEzsmsqud1WY/r6kpklS6QyLYN4kQshIhKh64zW9FtRfz4iU2QOUBjbvkrRBNzbA0qC4HA+CT3c2Z8/LP9AZhBNjiTe8BORJRSuen1VINnuvFoX7kkVcHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AdxszqX0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a446b5a08f0so582128166b.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564949; x=1710169749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMDW2kSL6lco97fIfQ4J82AwRbNBz84BihVYg/i18tM=;
        b=AdxszqX0pgrOh/J2Z3o4HRNuEdYNdyB7h3yVb1YMp5fboRuIVCmVMeCwjzqvRhV8mb
         EdNYhinnAPjTAQpfMqAPlEhQN34JtxQBSuDTx1Y/xPDzjX8bnEXI00m9eEAGPxXI4Reu
         fVMtr/lTbgMpS+vNVTPdaVK6U9/4A4NxjHKTVHCKPMqc6+fbvL2urXyT5dd2pLbL1Oq5
         6TlgIY0YNlu6UTNMwMNRDL+Pl2sPspfm0XNhpzUUGe6tDXNua2NLDkgHzcado3SQeHFO
         zjZTZC2ilnIfCyLmE698VsYzLvMUa/WgZnvNdZzP1mHTNoqOiJfuP/SwRNqJMfKWHcnC
         I5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564949; x=1710169749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMDW2kSL6lco97fIfQ4J82AwRbNBz84BihVYg/i18tM=;
        b=SWf0s9ARkEvtZYYdUSxq2NwKoplArZy24IHnmG/9iaijxeaajYaITBKoeUDghDY5La
         Ddcrim83HQAUR8+Imj1jDS0GwVInl7iFz/alnt6DJjDdLxKeaWqNLjiZF9LsvwPZPOQN
         kjT5IpeK9iXFhzAqgF/LrjvJzBcfqDmbEsHmZmsGQATqkhh3txyxmXxvSovwnmCMYMCC
         te0bZ3nCpjFZOSpr2tGKnTWPExQU9ewvKoKfRzA5FrAE6LcHp9roNAIQKBGlv8xcAmr/
         UZ+rTU+X4+ytnka8f5H4UBvrscAv4DZf7c8SKaeKLGtk8kw3vB204CeIUYpyYYeguBj7
         yHKg==
X-Gm-Message-State: AOJu0Yy0Psz7+DSkoE3pJRgO1iP0BUukcWaRY8+yvJgvr+4lXFSjpbBq
	xlg6qP+U+O3DHxbtp363nOs2wr3pRYekVAjYYOmEpdXxfd+t5u9XgvmI/mSP8KCGSWUw8JddTk/
	pUIw=
X-Google-Smtp-Source: AGHT+IF3srkCr1dxaMBok1nwxo1Efs3PK/kMrXpX9zgheCXaC3B25+/rcKO5+h+N4EQIYlAjjb/62w==
X-Received: by 2002:a17:906:6bd0:b0:a45:29f3:6cc8 with SMTP id t16-20020a1709066bd000b00a4529f36cc8mr4000861ejs.8.1709564949117;
        Mon, 04 Mar 2024 07:09:09 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:08 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 09/22] ovpn: implement basic RX path (UDP)
Date: Mon,  4 Mar 2024 16:09:00 +0100
Message-ID: <20240304150914.11444-10-antonio@openvpn.net>
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

Packets received over the socket are forwarded to the user device.

Impementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c     | 107 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/io.h     |   6 ++
 drivers/net/ovpn/peer.c   |   9 +++
 drivers/net/ovpn/peer.h   |   2 +
 drivers/net/ovpn/proto.h  | 101 ++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.c |  24 ++++++++
 drivers/net/ovpn/udp.c    | 118 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h    |   1 +
 8 files changed, 368 insertions(+)
 create mode 100644 drivers/net/ovpn/proto.h

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index d2fdb7485023..59a6e532bb8b 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -53,6 +53,113 @@ int ovpn_struct_init(struct net_device *dev)
 	return 0;
 }
 
+/* Called after decrypt to write IP packet to tun netdev.
+ * This method is expected to manage/free skb.
+ */
+static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	/* packet integrity was verified on the VPN layer - no need to perform
+	 * any additional check along the stack
+	 */
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->csum_level = ~0;
+
+	/* skb hash for transport packet no longer valid after decapsulation */
+	skb_clear_hash(skb);
+
+	/* post-decrypt scrub -- prepare to inject encapsulated packet onto tun
+	 * interface, based on __skb_tunnel_rx() in dst.h
+	 */
+	skb->dev = peer->ovpn->dev;
+	skb_set_queue_mapping(skb, 0);
+	skb_scrub_packet(skb, true);
+
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+	skb_probe_transport_header(skb);
+	skb_reset_inner_headers(skb);
+
+	/* update per-cpu RX stats with the stored size of encrypted packet */
+
+	/* we are in softirq context - hence no locking nor disable preemption needed */
+	dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
+
+	/* cause packet to be "received" by tun interface */
+	napi_gro_receive(&peer->napi, skb);
+}
+
+int ovpn_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct ovpn_peer *peer = container_of(napi, struct ovpn_peer, napi);
+	struct sk_buff *skb;
+	int work_done = 0;
+
+	if (unlikely(budget <= 0))
+		return 0;
+	/* this function should schedule at most 'budget' number of
+	 * packets for delivery to the tun interface.
+	 * If in the queue we have more packets than what allowed by the
+	 * budget, the next polling will take care of those
+	 */
+	while ((work_done < budget) &&
+	       (skb = ptr_ring_consume_bh(&peer->netif_rx_ring))) {
+		ovpn_netdev_write(peer, skb);
+		work_done++;
+	}
+
+	if (work_done < budget)
+		napi_complete_done(napi, work_done);
+
+	return work_done;
+}
+
+/* Entry point for processing an incoming packet (in skb form)
+ *
+ * Enqueue the packet and schedule RX consumer.
+ * Reference to peer is dropped only in case of success.
+ *
+ * Return 0  if the packet was handled (and consumed)
+ * Return <0 in case of error (return value is error code)
+ */
+int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	if (unlikely(ptr_ring_produce_bh(&peer->rx_ring, skb) < 0))
+		return -ENOSPC;
+
+	if (!queue_work(ovpn->crypto_wq, &peer->decrypt_work))
+		ovpn_peer_put(peer);
+
+	return 0;
+}
+
+static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	return true;
+}
+
+/* pick packet from RX queue, decrypt and forward it to the tun device */
+void ovpn_decrypt_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+
+	peer = container_of(work, struct ovpn_peer, decrypt_work);
+	while ((skb = ptr_ring_consume_bh(&peer->rx_ring))) {
+		if (likely(ovpn_decrypt_one(peer, skb) == 0)) {
+			/* if a packet has been enqueued for NAPI, signal
+			 * availability to the networking stack
+			 */
+			local_bh_disable();
+			napi_schedule(&peer->napi);
+			local_bh_enable();
+		}
+
+		/* give a chance to be rescheduled if needed */
+		cond_resched();
+	}
+	ovpn_peer_put(peer);
+}
+
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 {
 	return true;
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 633b9fb3276c..dee121a36dd7 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -13,10 +13,16 @@
 #include <linux/netdevice.h>
 
 struct sk_buff;
+struct ovpn_peer;
+struct ovpn_struct;
 
 int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
+int ovpn_napi_poll(struct napi_struct *napi, int budget);
+
+int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer, struct sk_buff *skb);
 
 void ovpn_encrypt_work(struct work_struct *work);
+void ovpn_decrypt_work(struct work_struct *work);
 
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4dbbd25b25c9..1ca59746ec69 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -45,6 +45,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	kref_init(&peer->refcount);
 
 	INIT_WORK(&peer->encrypt_work, ovpn_encrypt_work);
+	INIT_WORK(&peer->decrypt_work, ovpn_decrypt_work);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
@@ -70,6 +71,11 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 		goto err_rx_ring;
 	}
 
+	/* configure and start NAPI */
+	netif_napi_add_tx_weight(ovpn->dev, &peer->napi, ovpn_napi_poll,
+				 NAPI_POLL_WEIGHT);
+	napi_enable(&peer->napi);
+
 	dev_hold(ovpn->dev);
 
 	return peer;
@@ -114,6 +120,9 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 
 void ovpn_peer_release(struct ovpn_peer *peer)
 {
+	napi_disable(&peer->napi);
+	netif_napi_del(&peer->napi);
+
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index ef4174be7dea..8279af12dd09 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -38,6 +38,8 @@ struct ovpn_peer {
 	struct ptr_ring rx_ring;
 	struct ptr_ring netif_rx_ring;
 
+	struct napi_struct napi;
+
 	struct ovpn_socket *sock;
 
 	struct dst_cache dst_cache;
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
new file mode 100644
index 000000000000..c016422fe6f3
--- /dev/null
+++ b/drivers/net/ovpn/proto.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNPROTO_H_
+#define _NET_OVPN_OVPNPROTO_H_
+
+#include "main.h"
+
+#include <linux/skbuff.h>
+
+/* Methods for operating on the initial command
+ * byte of the OpenVPN protocol.
+ */
+
+/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in
+ * one byte
+ */
+#define OVPN_KEY_ID_MASK 0x07
+#define OVPN_OPCODE_SHIFT 3
+#define OVPN_OPCODE_MASK 0x1F
+/* upper bounds on opcode and key ID */
+#define OVPN_KEY_ID_MAX (OVPN_KEY_ID_MASK + 1)
+#define OVPN_OPCODE_MAX (OVPN_OPCODE_MASK + 1)
+/* packet opcodes of interest to us */
+#define OVPN_DATA_V1 6 /* data channel V1 packet */
+#define OVPN_DATA_V2 9 /* data channel V2 packet */
+/* size of initial packet opcode */
+#define OVPN_OP_SIZE_V1 1
+#define OVPN_OP_SIZE_V2	4
+#define OVPN_PEER_ID_MASK 0x00FFFFFF
+#define OVPN_PEER_ID_UNDEF 0x00FFFFFF
+/* first byte of keepalive message */
+#define OVPN_KEEPALIVE_FIRST_BYTE 0x2a
+/* first byte of exit message */
+#define OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE 0x28
+
+/**
+ * Extract the OP code from the specified byte
+ *
+ * Return the OP code
+ */
+static inline u8 ovpn_opcode_from_byte(u8 byte)
+{
+	return byte >> OVPN_OPCODE_SHIFT;
+}
+
+/**
+ * Extract the OP code from the skb head.
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first byte.
+ *
+ * Return the OP code
+ */
+static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 offset)
+{
+	return ovpn_opcode_from_byte(*(skb->data + offset));
+}
+
+/**
+ * Extract the key ID from the skb head.
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first byte.
+ *
+ * Return the key ID
+ */
+
+static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
+{
+	return *skb->data & OVPN_KEY_ID_MASK;
+}
+
+/**
+ * Extract the peer ID from the skb head.
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first 4 bytes.
+ *
+ * Return the peer ID.
+ */
+
+static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
+{
+	return ntohl(*(__be32 *)(skb->data + offset)) & OVPN_PEER_ID_MASK;
+}
+
+static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
+{
+	const u8 op = (opcode << OVPN_OPCODE_SHIFT) | (key_id & OVPN_KEY_ID_MASK);
+
+	return (op << 24) | (peer_id & OVPN_PEER_ID_MASK);
+}
+
+#endif /* _NET_OVPN_OVPNPROTO_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index b7ccc4882d1e..203d04825d88 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -19,6 +19,9 @@ static void ovpn_socket_detach(struct socket *sock)
 	if (!sock)
 		return;
 
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+
 	sockfd_put(sock);
 }
 
@@ -64,6 +67,27 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 	return ret;
 }
 
+/* Retrieve the corresponding ovpn object from a UDP socket
+ * rcu_read_lock must be held on entry
+ */
+struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
+{
+	struct ovpn_socket *ovpn_sock;
+
+	if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
+		return NULL;
+
+	ovpn_sock = rcu_dereference_sk_user_data(sk);
+	if (unlikely(!ovpn_sock))
+		return NULL;
+
+	/* make sure that sk matches our stored transport socket */
+	if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
+		return NULL;
+
+	return ovpn_sock->ovpn;
+}
+
 struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 {
 	struct ovpn_socket *ovpn_sock;
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index b7d972eb66c8..addcf55abf26 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -11,6 +11,7 @@
 #include "io.h"
 #include "ovpnstruct.h"
 #include "peer.h"
+#include "proto.h"
 #include "socket.h"
 #include "udp.h"
 
@@ -23,6 +24,108 @@
 #include <net/ipv6_stubs.h>
 #include <net/udp_tunnel.h>
 
+/**
+ * ovpn_udp_encap_recv() - Start processing a received UDP packet.
+ * If the first byte of the payload is DATA_V2, the packet is further processed,
+ * otherwise it is forwarded to the UDP stack for delivery to user space.
+ *
+ * @sk: the socket the packet was received on
+ * @skb: the sk_buff containing the actual packet
+ *
+ * Return codes:
+ *  0 : we consumed or dropped packet
+ * >0 : skb should be passed up to userspace as UDP (packet not consumed)
+ * <0 : skb should be resubmitted as proto -N (packet not consumed)
+ */
+static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = NULL;
+	struct ovpn_struct *ovpn;
+	u32 peer_id;
+	u8 opcode;
+	int ret;
+
+	ovpn = ovpn_from_udp_sock(sk);
+	if (unlikely(!ovpn)) {
+		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n", __func__);
+		goto drop;
+	}
+
+	/* Make sure the first 4 bytes of the skb data buffer after the UDP header are accessible.
+	 * They are required to fetch the OP code, the key ID and the peer ID.
+	 */
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) + 4))) {
+		net_dbg_ratelimited("%s: packet too small\n", __func__);
+		goto drop;
+	}
+
+	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
+	if (unlikely(opcode != OVPN_DATA_V2)) {
+		/* DATA_V1 is not supported */
+		if (opcode == OVPN_DATA_V1)
+			goto drop;
+
+		/* unknown or control packet: let it bubble up to userspace */
+		return 1;
+	}
+
+	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
+	/* some OpenVPN server implementations send data packets with the peer-id set to
+	 * undef. In this case we skip the peer lookup by peer-id and we try with the
+	 * transport address
+	 */
+	if (peer_id != OVPN_PEER_ID_UNDEF) {
+		peer = ovpn_peer_lookup_id(ovpn, peer_id);
+		if (!peer) {
+			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
+					   __func__, peer_id);
+			goto drop;
+		}
+	}
+
+	if (!peer) {
+		/* data packet with undef peer-id */
+		peer = ovpn_peer_lookup_transp_addr(ovpn, skb);
+		if (unlikely(!peer)) {
+			netdev_dbg(ovpn->dev,
+				   "%s: received data with undef peer-id from unknown source\n",
+				   __func__);
+			goto drop;
+		}
+	}
+
+	/* At this point we know the packet is from a configured peer.
+	 * DATA_V2 packets are handled in kernel space, the rest goes to user space.
+	 *
+	 * Return 1 to instruct the stack to let the packet bubble up to userspace
+	 */
+	if (unlikely(opcode != OVPN_DATA_V2)) {
+		ovpn_peer_put(peer);
+		return 1;
+	}
+
+	/* pop off outer UDP header */
+	__skb_pull(skb, sizeof(struct udphdr));
+
+	ret = ovpn_recv(ovpn, peer, skb);
+	if (unlikely(ret < 0)) {
+		net_err_ratelimited("%s: cannot handle incoming packet from peer %d: %d\n",
+				    __func__, peer->id, ret);
+		goto drop;
+	}
+
+	/* should this be a non DATA_V2 packet, ret will be >0 and this will instruct the UDP
+	 * stack to continue processing this packet as usual (i.e. deliver to user space)
+	 */
+	return ret;
+
+drop:
+	if (peer)
+		ovpn_peer_put(peer);
+	kfree_skb(skb);
+	return 0;
+}
+
 static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
 			    struct sk_buff *skb)
@@ -205,6 +308,11 @@ void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
 /* Set UDP encapsulation callbacks */
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 {
+	struct udp_tunnel_sock_cfg cfg = {
+		.sk_user_data = ovpn,
+		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.encap_rcv = ovpn_udp_encap_recv,
+	};
 	struct ovpn_socket *old_data;
 
 	/* sanity check */
@@ -230,5 +338,15 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 		return -EBUSY;
 	}
 
+	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+
 	return 0;
 }
+
+/* Detach socket from encapsulation handler and/or other callbacks */
+void ovpn_udp_socket_detach(struct socket *sock)
+{
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 4d6ba9ecabd1..8e3598daed17 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -16,6 +16,7 @@ struct ovpn_peer;
 struct ovpn_struct;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
+void ovpn_udp_socket_detach(struct socket *sock);
 void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
 		       struct sk_buff *skb);
 
-- 
2.43.0


