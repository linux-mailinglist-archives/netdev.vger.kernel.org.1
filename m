Return-Path: <netdev+bounces-128628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1529397AA1F
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EEA1C271E1
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBF413FF5;
	Tue, 17 Sep 2024 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DUL6PvTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46613C482
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535295; cv=none; b=Vkph7Uj93aTeVIpXkZtn277SlnnP+mOcpNrsP3BEUgdVCqdDKZq9PKPOqPRQLpSH+QgKIjGvrQrjIIaROD2kqqIVVoQ2uQYrPLdjpfHRBANGa8/JcRZL/BSLk+SogLA+Gj5s8nxGyJoSyaJ4T7vxSNI12QW/VmJ8leYL/4epS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535295; c=relaxed/simple;
	bh=VfyTS9zJEqwM+anpKyBRsf8Cz2EtSddwQ0WFDQqhwGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFu/QuEa/2AzC/qd4T5p4augE8VaJ8NYEzYLFxSosz+bGFIkwCJgFLxHa+kvYIVIut7q/3mVghjGnVCluldRuVtyXw/pekEELODrOUxlZJ8I+waN0zlNFbt78suxW37LI30O34UemPp5oq5WuCTupO0M1/WzK7wqYbc7deMjPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DUL6PvTb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso3976331f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535291; x=1727140091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vjzk6mexZF58WI9ylhD+Zdxr4ZrCUh/djN5bUDktEmI=;
        b=DUL6PvTbe3wwBtvaCZKgN75KrBa4r93PFDVUa4RJxTu0yVO8TlE3I76oELPQEXORs1
         KbdbqBneilibkGeEnQeLrYk96RRCegoMLKe6eORYa8bB8M5ucgUlJVyuvUKp80RLvHuW
         urqeKDQhGwLpLvMWbgaYYHB/IZlrBJ7jz2ap48iq9YL5f34QLGPYw4y04uT69whYtSOQ
         DsRJ2d2XlXFip+E/ZFbxBT8LYRE2vkS+vuGzTY1/bHNHxBjsOIecmFuQ5+qaIw60p0iB
         Ad9bieYIuJJ5dh/aVAImy3r7ro78dMqsQraY10TS2+2NGb5uecu6CHdRumFRDiY+REl1
         xYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535291; x=1727140091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vjzk6mexZF58WI9ylhD+Zdxr4ZrCUh/djN5bUDktEmI=;
        b=d8qgaPmAC/2m1eQMSRyGqo4WkWNUuLNqeVqhoA5VSAeC4pzjIuW5W/to0WjVxBdvhN
         FRH8kVPATuyoog52CZlx+ZEQwhHayihXb7fj/ObO2N0ODtYgbCMOLgTVTnufzF7TCEMr
         OV5HVXlq82bOYtPCcguw6c+U3jdo7VDZ30iM7PgxtVzNm+aO1AnGfFZiWK6EOWGu3rcI
         LI1/Kbw7+0tgVdZL/XntR71tgKtkfL835/APqqJxWaU2XZw0MRruDhJWz2LQTfiFgwYO
         1D2I0vRIgGzexWpUG087jnZ3vOQWdmgFlHx5I/FelutUMNujwny0OUqwyHKUWLRSbe79
         LVbw==
X-Gm-Message-State: AOJu0YxOYaTpCd9S5O2vUk0ykivAqL+qhb5m9413E13nLCkbe3glF6XS
	w8RXSOsskxZfnECUWR6rtR8+kT/K+rVfq2LpYi46TFc5V0ESCMiNjouCtG/HuXT5pMP/NRybPEb
	s
X-Google-Smtp-Source: AGHT+IGioip7nm/1ygzwG/wIqMj2/MEAOCVgwLflDF2AzPFejw/gahOa0gsiMs9p75Kpkp/YL6kgmg==
X-Received: by 2002:a05:6000:2ca:b0:378:81aa:2653 with SMTP id ffacd0b85a97d-378d61d49dbmr13943124f8f.9.1726535290655;
        Mon, 16 Sep 2024 18:08:10 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:10 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 11/25] ovpn: implement basic RX path (UDP)
Date: Tue, 17 Sep 2024 03:07:20 +0200
Message-ID: <20240917010734.1905-12-antonio@openvpn.net>
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

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |  66 ++++++++++++++++++++-
 drivers/net/ovpn/io.h         |   2 +
 drivers/net/ovpn/main.c       |   8 ++-
 drivers/net/ovpn/ovpnstruct.h |   3 +
 drivers/net/ovpn/proto.h      |  75 ++++++++++++++++++++++++
 drivers/net/ovpn/socket.c     |  24 ++++++++
 drivers/net/ovpn/udp.c        | 104 +++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h        |   3 +-
 8 files changed, 281 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ovpn/proto.h

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index dfd2c90c5684..78449b52a2f8 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,14 +9,78 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gro_cells.h>
 #include <net/gso.h>
 
-#include "io.h"
 #include "ovpnstruct.h"
 #include "peer.h"
+#include "io.h"
+#include "netlink.h"
+#include "proto.h"
 #include "udp.h"
 #include "skb.h"
 
+/* Called after decrypt to write the IP packet to the device.
+ * This method is expected to manage/free the skb.
+ */
+static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	unsigned int pkt_len;
+
+	/* we can't guarantee the packet wasn't corrupted before entering the
+	 * VPN, therefore we give other layers a chance to check that
+	 */
+	skb->ip_summed = CHECKSUM_NONE;
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
+	memset(skb->cb, 0, sizeof(skb->cb));
+
+	/* cause packet to be "received" by the interface */
+	pkt_len = skb->len;
+	if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
+				     skb) == NET_RX_SUCCESS))
+		/* update RX stats with the size of decrypted packet */
+		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
+}
+
+static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
+{
+	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+
+	if (unlikely(ret < 0))
+		goto drop;
+
+	ovpn_netdev_write(peer, skb);
+	/* skb is passed to upper layer - don't free it */
+	skb = NULL;
+drop:
+	if (unlikely(skb))
+		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+	ovpn_peer_put(peer);
+	kfree_skb(skb);
+}
+
+/* pick next packet from RX queue, decrypt and forward it to the device */
+void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_decrypt_post(skb, 0);
+}
+
 static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 {
 	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index aa259be66441..9667a0a470e0 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -12,4 +12,6 @@
 
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
+void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3a36a91c6bf6..b9779f4bcdeb 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -13,6 +13,7 @@
 #include <linux/inetdevice.h>
 //#include <linux/rcupdate.h>
 #include <linux/version.h>
+#include <net/gro_cells.h>
 #include <net/ip.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/if_arp.h>
@@ -45,11 +46,16 @@ static void ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
 
 static void ovpn_struct_free(struct net_device *net)
 {
+	struct ovpn_struct *ovpn = netdev_priv(net);
+
+	gro_cells_destroy(&ovpn->gro_cells);
 }
 
 static int ovpn_net_init(struct net_device *dev)
 {
-	return 0;
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+
+	return gro_cells_init(&ovpn->gro_cells, dev);
 }
 
 static int ovpn_net_open(struct net_device *dev)
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 25f4837b798b..65497ce115aa 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <net/gro_cells.h>
 #include <net/net_trackers.h>
 #include <uapi/linux/ovpn.h>
 
@@ -22,6 +23,7 @@
  * @lock: protect this object
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
+ * @gro_cells: pointer to the Generic Receive Offload cell
  */
 struct ovpn_struct {
 	struct net_device *dev;
@@ -31,6 +33,7 @@ struct ovpn_struct {
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
+	struct gro_cells gro_cells;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
new file mode 100644
index 000000000000..69604cf26bbf
--- /dev/null
+++ b/drivers/net/ovpn/proto.h
@@ -0,0 +1,75 @@
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
+	u8 byte = *(skb->data + offset);
+
+	return byte >> OVPN_OPCODE_SHIFT;
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
+#endif /* _NET_OVPN_OVPNPROTO_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 090a3232ab0e..964b566de69f 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -22,6 +22,9 @@ static void ovpn_socket_detach(struct socket *sock)
 	if (!sock)
 		return;
 
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+
 	sockfd_put(sock);
 }
 
@@ -71,6 +74,27 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
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
 /**
  * ovpn_socket_new - create a new socket and initialize it
  * @sock: the kernel socket to embed
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d26d7566e9c8..d1e88ae83843 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -21,9 +21,95 @@
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
+
+	ovpn = ovpn_from_udp_sock(sk);
+	if (unlikely(!ovpn)) {
+		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
+				    __func__);
+		goto drop_noovpn;
+	}
+
+	/* Make sure the first 4 bytes of the skb data buffer after the UDP
+	 * header are accessible.
+	 * They are required to fetch the OP code, the key ID and the peer ID.
+	 */
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
+				    OVPN_OP_SIZE_V2))) {
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
+			net_dbg_ratelimited("%s: received data with undef peer-id from unknown source\n",
+					    __func__);
+			goto drop;
+		}
+	}
+
+	/* pop off outer UDP header */
+	__skb_pull(skb, sizeof(struct udphdr));
+	ovpn_recv(peer, skb);
+	return 0;
+
+drop:
+	if (peer)
+		ovpn_peer_put(peer);
+	dev_core_stats_rx_dropped_inc(ovpn->dev);
+drop_noovpn:
+	kfree_skb(skb);
+	return 0;
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @ovpn: the openvpn instance
@@ -259,8 +345,12 @@ void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
  */
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 {
+	struct udp_tunnel_sock_cfg cfg = {
+		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.encap_rcv = ovpn_udp_encap_recv,
+	};
 	struct ovpn_socket *old_data;
-	int ret = 0;
+	int ret;
 
 	/* sanity check */
 	if (sock->sk->sk_protocol != IPPROTO_UDP) {
@@ -274,6 +364,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
+		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 		return 0;
 	}
 
@@ -302,3 +393,14 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 
 	return ret;
 }
+
+/**
+ * ovpn_udp_socket_detach - clean udp-tunnel status for this socket
+ * @sock: the socket to clean
+ */
+void ovpn_udp_socket_detach(struct socket *sock)
+{
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index e60f8cd2b4ac..fecb68464896 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -18,8 +18,9 @@ struct sk_buff;
 struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
-
+void ovpn_udp_socket_detach(struct socket *sock);
 void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
 		       struct sk_buff *skb);
+struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk);
 
 #endif /* _NET_OVPN_UDP_H_ */
-- 
2.44.2


