Return-Path: <netdev+bounces-93566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80FD8BC54D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1699E1C210C1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2B4315D;
	Mon,  6 May 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eyyf63bz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527053CF6A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958147; cv=none; b=GnW4zp7zZVN1d1E9jvE4EWVrv2l+FtkdUJgIDKWXpBwd4BDkBqsgPonU26S3rjsIojUB/31ZOyTHd7WGibl+Qc9IMcjrlgZ/WbM7BoF2Ixyze59zvxngPKpyt73DnruDImc4pXdH7s1YTc88ay+0ZE/yQj7aWaIkxHm8dW6knY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958147; c=relaxed/simple;
	bh=m7ASbRfaND+chD+A0ePIa1Cv5NFEZGbeMrW1qBRL5Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU/zIRlv6cmH981uOv+3tRQ26ortiFUn6q60GvkLDMCmxV41NC/Le2Z8MDtOzQpLGJXCBBLy9dUcSXNN5vhmRMsS9Wr0HRIuNZlreAI1lh27dOSRr0VD4GJaYcyBepDOhiKT81uz59h7YNMYkal+SP8xFMBhu1wbV8UzcquPupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eyyf63bz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34dc9065606so688980f8f.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958143; x=1715562943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bIQ0+O8OSTdvYTro4DbPe0bp3qS/DTCDTVmP585/MM=;
        b=eyyf63bzoNToAj0jEB9NqvRG8K+1o9ml7ta/7Cfz95tI7CyW8M5f5gUIVmaZ6jWFjB
         7NLAciuBWBAvTSpcc2LZUh11w2JgII446FwpNhjYn3apZrv0096GBKfA3A4SWL4dVU9X
         oaz+6bShLk2a+iCzO0zlIDbt4E072DHLRl2IPnQoIyjnSDsg8e1xzvBUuDSC+UOAu2M2
         cLoLG9OdviJp0wfmMfENqB6VhML0oEPOzwsCpeJ45HpvexMtmy1I4aUDbW+ur/i43NNF
         aNV5gJsc3WgUbs2CEUDEZtFg07rgcJD8JkNE2064cJpCRlXJPabu19hweBoIXuyN9gF0
         QZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958143; x=1715562943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bIQ0+O8OSTdvYTro4DbPe0bp3qS/DTCDTVmP585/MM=;
        b=rrxC2mGSI+3DhB/OaK4U1pyCN1fbfoia15URAMArW+SlBKnZzUzvkNDRCb1Po4gmkq
         3JzGcLX1WK5kemifgsL2+MUmAX5Zkj1BDKFQLRP0o4kuaYzp/AqJUdMlHi6DOmCD2rBD
         p2+szKzx5eDaL5hT45Y2qWGjumWj3mE7dRAepfS/qv9820KS9zljEfEv87m4UE5B85Fx
         FBaLhaQnJIsGaYVb+Sko3gBIrKs7o2T/oJ5NKeR4ownlmQItGoQ1nkiLwdSDKoegrV88
         Pd6J2fo/JCF3dYxc4ZXslqIkBAuRzuubkuz3ZlV6RSMVxgDlE9Y4ZDrL6QK9rtFwKown
         2Ljg==
X-Gm-Message-State: AOJu0YwbIzCMSzkMu+ijOp2r+a5CHnyWrr7M/HBV8FvOdYcpuWYpslWw
	wYtmFlz1TFnhl4oAl53vKAUcmaNKq7gTMZ3EFnqBrcEKww3GDMafuRoyGDc9IL+Bwd9ChqicTRu
	P
X-Google-Smtp-Source: AGHT+IGN7vicxXuci7DmM/Bfv3852LI3A9N/fA1zy3KqIxB+8ut0j2oAyazCPuSs+8Crjle5G3RcCA==
X-Received: by 2002:a5d:64c5:0:b0:34e:81ab:463f with SMTP id f5-20020a5d64c5000000b0034e81ab463fmr8162695wri.20.1714958143302;
        Sun, 05 May 2024 18:15:43 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
Date: Mon,  6 May 2024 03:16:23 +0200
Message-ID: <20240506011637.27272-11-antonio@openvpn.net>
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

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c     | 114 +++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/io.h     |   5 ++
 drivers/net/ovpn/peer.c   |   9 +++
 drivers/net/ovpn/peer.h   |   2 +
 drivers/net/ovpn/proto.h  | 115 +++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.c |  24 ++++++++
 drivers/net/ovpn/udp.c    | 125 +++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h    |   6 ++
 8 files changed, 397 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ovpn/proto.h

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 36cfb95edbf4..9935a863bffe 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -11,10 +11,10 @@
 #include <linux/skbuff.h>
 #include <net/gso.h>
 
-#include "io.h"
 #include "ovpnstruct.h"
-#include "netlink.h"
 #include "peer.h"
+#include "io.h"
+#include "netlink.h"
 #include "udp.h"
 
 int ovpn_struct_init(struct net_device *dev)
@@ -48,6 +48,116 @@ int ovpn_struct_init(struct net_device *dev)
 	return 0;
 }
 
+/* Called after decrypt to write the IP packet to the device.
+ * This method is expected to manage/free the skb.
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
+	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
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
+	/* we are in softirq context - hence no locking nor disable preemption
+	 * needed
+	 */
+	dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
+
+	/* cause packet to be "received" by the interface */
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
+	 * packets for delivery to the interface.
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
+int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+	      struct sk_buff *skb)
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
+/* pick next packet from RX queue, decrypt and forward it to the device */
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
index 171e87f584b6..63d549c8c53b 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -18,7 +18,12 @@
  */
 int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
+int ovpn_napi_poll(struct napi_struct *napi, int budget);
+
+int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
+	      struct sk_buff *skb);
 
 void ovpn_encrypt_work(struct work_struct *work);
+void ovpn_decrypt_work(struct work_struct *work);
 
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index f023f919b75d..4e5bb659f169 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -40,6 +40,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	kref_init(&peer->refcount);
 
 	INIT_WORK(&peer->encrypt_work, ovpn_encrypt_work);
+	INIT_WORK(&peer->decrypt_work, ovpn_decrypt_work);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
@@ -69,6 +70,11 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 		goto err_rx_ring;
 	}
 
+	/* configure and start NAPI */
+	netif_napi_add_tx_weight(ovpn->dev, &peer->napi, ovpn_napi_poll,
+				 NAPI_POLL_WEIGHT);
+	napi_enable(&peer->napi);
+
 	dev_hold(ovpn->dev);
 
 	return peer;
@@ -121,6 +127,9 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 
 void ovpn_peer_release(struct ovpn_peer *peer)
 {
+	napi_disable(&peer->napi);
+	netif_napi_del(&peer->napi);
+
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index f915afa260c3..f8b2157b416f 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -28,6 +28,7 @@
  * @tx_ring: queue of outgoing poackets to this peer
  * @rx_ring: queue of incoming packets from this peer
  * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
+ * @napi: NAPI object
  * @sock: the socket being used to talk to this peer
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
@@ -50,6 +51,7 @@ struct ovpn_peer {
 	struct ptr_ring tx_ring;
 	struct ptr_ring rx_ring;
 	struct ptr_ring netif_rx_ring;
+	struct napi_struct napi;
 	struct ovpn_socket *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
new file mode 100644
index 000000000000..0a51104ed931
--- /dev/null
+++ b/drivers/net/ovpn/proto.h
@@ -0,0 +1,115 @@
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
+ * ovpn_opcode_from_byte - extract OP code from the specified byte
+ * @byte: the byte in wire format to extract the OP code from
+ *
+ * Return: the OP code
+ */
+static inline u8 ovpn_opcode_from_byte(u8 byte)
+{
+	return byte >> OVPN_OPCODE_SHIFT;
+}
+
+/**
+ * ovpn_opcode_from_skb - extract OP code from skb at specified offset
+ * @skb: the packet to extract the OP code from
+ * @offset: the offset in the data buffer where the OP code is located
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first byte.
+ *
+ * Return: the OP code
+ */
+static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 offset)
+{
+	return ovpn_opcode_from_byte(*(skb->data + offset));
+}
+
+/**
+ * ovpn_key_id_from_skb - extract key ID from the skb head
+ * @skb: the packet to extract the key ID code from
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first byte.
+ *
+ * Return: the key ID
+ */
+static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
+{
+	return *skb->data & OVPN_KEY_ID_MASK;
+}
+
+/**
+ * ovpn_peer_id_from_skb - extract peer ID from skb at specified offset
+ * @skb: the packet to extract the OP code from
+ * @offset: the offset in the data buffer where the OP code is located
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first 4 bytes.
+ *
+ * Return: the peer ID.
+ */
+static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
+{
+	return ntohl(*(__be32 *)(skb->data + offset)) & OVPN_PEER_ID_MASK;
+}
+
+/**
+ * ovpn_opcode_compose - combine OP code, key ID and peer ID to wire format
+ * @opcode: the OP code
+ * @key_id: the key ID
+ * @peer_id: the peer ID
+ *
+ * Return: a 4 bytes integer obtained combining all input values following the
+ * OpenVPN wire format. This integer can then be written to the packet header.
+ */
+static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
+{
+	const u8 op = (opcode << OVPN_OPCODE_SHIFT) |
+		      (key_id & OVPN_KEY_ID_MASK);
+
+	return (op << 24) | (peer_id & OVPN_PEER_ID_MASK);
+}
+
+#endif /* _NET_OVPN_OVPNPROTO_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index a4a4d69162f0..2ae04e883e13 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -23,6 +23,9 @@ static void ovpn_socket_detach(struct socket *sock)
 	if (!sock)
 		return;
 
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+
 	sockfd_put(sock);
 }
 
@@ -69,6 +72,27 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
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
index f434da76dc0a..07182703e598 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -20,9 +20,117 @@
 #include "bind.h"
 #include "io.h"
 #include "peer.h"
+#include "proto.h"
 #include "socket.h"
 #include "udp.h"
 
+/**
+ * ovpn_udp_encap_recv - Start processing a received UDP packet.
+ * @sk: socket over which the packet was received
+ * @skb: the received packet
+ *
+ * If the first byte of the payload is DATA_V2, the packet is further processed,
+ * otherwise it is forwarded to the UDP stack for delivery to user space.
+ *
+ * Return:
+ *  0 if skb was consumed or dropped
+ * >0 if skb should be passed up to userspace as UDP (packet not consumed)
+ * <0 if skb should be resubmitted as proto -N (packet not consumed)
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
+		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
+				    __func__);
+		goto drop;
+	}
+
+	/* Make sure the first 4 bytes of the skb data buffer after the UDP
+	 * header are accessible.
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
+	/* some OpenVPN server implementations send data packets with the
+	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
+	 * and we try with the transport address
+	 */
+	if (peer_id != OVPN_PEER_ID_UNDEF) {
+		peer = ovpn_peer_get_by_id(ovpn, peer_id);
+		if (!peer) {
+			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
+					    __func__, peer_id);
+			goto drop;
+		}
+	}
+
+	if (!peer) {
+		/* data packet with undef peer-id */
+		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
+		if (unlikely(!peer)) {
+			netdev_dbg(ovpn->dev,
+				   "%s: received data with undef peer-id from unknown source\n",
+				   __func__);
+			goto drop;
+		}
+	}
+
+	/* At this point we know the packet is from a configured peer.
+	 * DATA_V2 packets are handled in kernel space, the rest goes to user
+	 * space.
+	 *
+	 * Return 1 to instruct the stack to let the packet bubble up to
+	 * userspace
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
+	/* should this be a non DATA_V2 packet, ret will be >0 and this will
+	 * instruct the UDP stack to continue processing this packet as usual
+	 * (i.e. deliver to user space)
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
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @ovpn: the openvpn instance
@@ -235,6 +343,11 @@ void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 {
+	struct udp_tunnel_sock_cfg cfg = {
+		.sk_user_data = ovpn,
+		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.encap_rcv = ovpn_udp_encap_recv,
+	};
 	struct ovpn_socket *old_data;
 
 	/* sanity check */
@@ -255,10 +368,20 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 			return -EALREADY;
 		}
 
-		netdev_err(ovpn->dev, "%s: provided socket already taken by other user\n",
+		netdev_err(ovpn->dev,
+			   "%s: provided socket already taken by other user\n",
 			   __func__);
 		return -EBUSY;
 	}
 
+	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+
 	return 0;
 }
+
+void ovpn_udp_socket_detach(struct socket *sock)
+{
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index f4eb1e63e103..46329aefd052 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -29,6 +29,12 @@ struct socket;
  */
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
 
+/**
+ * ovpn_udp_socket_detach - clean udp-tunnel status for this socket
+ * @sock: the socket to clean
+ */
+void ovpn_udp_socket_detach(struct socket *sock);
+
 /**
  * ovpn_udp_send_skb - prepare skb and send it over via UDP
  * @ovpn: the openvpn instance
-- 
2.43.2


