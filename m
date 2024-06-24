Return-Path: <netdev+bounces-106083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E09148B5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18031F23416
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B913C8FE;
	Mon, 24 Jun 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TbF1qJnJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CC13B59B
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228607; cv=none; b=Zf9zFgMV0QEfbynSpblKOKPXUUwYr8gz+W7HFsvzFT/kG0vW4FK/uyQz5MegtPiS5/F8WJFDgTf73zAq0Hp4Dg3fROaJFs1FkuGVy2NBdihyerN7AwajvEHYwZPt7qKfP9hzkW6j8CoecoQyZxIdqIH7Uhdhnx6qxY+jU7XTLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228607; c=relaxed/simple;
	bh=c2WVvhVOpjCUXqYaMQm4fAbAYLx+J0b36ztqErU4NIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goQjghbUgJEbbl9ChtL7zSOW/xoSskeaW4IRpo0K+UT01n3sB+s9H0rc6LDoC3gDabitvU4JqbNEWbwgbwiVysUHyGKczgEqhfuvXxAsdwsd+AvZNMcZCeY4ZgZZark7eIqPtJM+RljRqXR15AEkICtZ1Exnn7t+6g+46sR6r6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TbF1qJnJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-366dcd21604so1484921f8f.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228603; x=1719833403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw7huSWbmJoGVZIBZPXSk4w2n5hxSgleJBOLDoIIfjY=;
        b=TbF1qJnJjoM7p/s4HE9K3x55cACQKURTj+6SD2i4sNZB/IDGK48msG2aSazLT2njzO
         PVmSsKZshDlVFBOsn6DhZLL63tPahrsuer3FpfmSDQ0jWeOboeVSrAy3qev2RPBqdQHT
         VMpuQFHmRWmJ5qgXcUdHzfn0lwOmmxP79u7+F7CayLmsBSVa9W8gzNw51ggHZ1qTSOFS
         AKosdGxOm9DsLX8o4+E2suKg3qBcAS6R5YQJr+FkpmT3syqF67fzzqoD62sQzwPhar0E
         SuNfaK8TwSW0HJPHVpIs5mEoLfXmz+jycwKhhmSlMzrkzRD+YuH4uvdlKNPN2GEEez0G
         XY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228603; x=1719833403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw7huSWbmJoGVZIBZPXSk4w2n5hxSgleJBOLDoIIfjY=;
        b=h7bdn6Mf5Q8E+Yqa8e8fmsy/kHqbMPMM72BIPN4h40VeXo9CXXRGDgY2AfQz2R3QtC
         +H2l/00ReSCgWwQENAk9A8+zCVMjLOXU3ALeyo/9oAfbkKZXAQul87ew4xP0zO1L/tXm
         gLLmIwjsqS4drhedrXtWMvvmYtzUn9d4ToTtYTHGYu0vfksPfWrojpxINDLthq1roarD
         pPqR9S9nKr74gCSbry9S0OLCnL9RFbBszWUj6grXJPeL7w6GMMf2HPWmBJvOtz1P3V7J
         f8rKnrwBg9diMNq/gR3JYobM+Ui8NfNbfxtP7Jwsu6BoC4rhWw3/gB3xadQaepMjnptQ
         AiYw==
X-Gm-Message-State: AOJu0YydGpMYOVqDKKJqDFquSySwfdkF3sex7I0IRlh08/QawSq3V7qW
	3qzpYBv3ZmB9cA71fFuiXKLip/ptYS23wDvxMfWYqk+cOgllFS+B6fEKBUwKn1XTIzi4HYZP/AW
	j
X-Google-Smtp-Source: AGHT+IHD0Vii/Gjx8k8lvKnxVsLNSgPxPMgF1PKd3kGHQ1Hy4nezAKUt4G9u2XZ5javqljArNPkRrQ==
X-Received: by 2002:a5d:526d:0:b0:35e:4f42:6016 with SMTP id ffacd0b85a97d-366e7a35de0mr3492834f8f.30.1719228602879;
        Mon, 24 Jun 2024 04:30:02 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:02 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 14/25] ovpn: implement TCP transport
Date: Mon, 24 Jun 2024 13:31:11 +0200
Message-ID: <20240624113122.12732-15-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this change ovpn is allowed to communicate to peers also via TCP.
Parsing of incoming messages is implemented through the strparser API.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig       |   1 +
 drivers/net/ovpn/Makefile |   1 +
 drivers/net/ovpn/io.c     |   9 +-
 drivers/net/ovpn/main.c   |   3 +
 drivers/net/ovpn/peer.h   |  38 ++-
 drivers/net/ovpn/socket.c |  27 +-
 drivers/net/ovpn/socket.h |   7 +-
 drivers/net/ovpn/tcp.c    | 502 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h    |  42 ++++
 9 files changed, 624 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ovpn/tcp.c
 create mode 100644 drivers/net/ovpn/tcp.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c5743288242d..ddc65bc1e218 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -118,6 +118,7 @@ config WIREGUARD_DEBUG
 config OVPN
 	tristate "OpenVPN data channel offload"
 	depends on NET && INET
+	select STREAM_PARSER
 	select NET_UDP_TUNNEL
 	select DST_CACHE
 	select CRYPTO
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index d43fda72646b..f4d4bd87c851 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -18,4 +18,5 @@ ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
 ovpn-y += stats.o
+ovpn-y += tcp.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 0475440642dd..764b3df996bc 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -21,6 +21,7 @@
 #include "netlink.h"
 #include "proto.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 #include "skb.h"
 
@@ -84,8 +85,11 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
 	/* PID sits after the op */
 	pid = (__force __be32 *)(skb->data + OVPN_OP_SIZE_V2);
 	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		net_err_ratelimited("%s: PKT ID RX error: %d\n",
+				    peer->ovpn->dev->name, ret);
 		goto drop;
+	}
 
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, ovpn_skb_cb(skb)->payload_offset);
@@ -192,6 +196,9 @@ void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 	case IPPROTO_UDP:
 		ovpn_udp_send_skb(peer->ovpn, peer, skb);
 		break;
+	case IPPROTO_TCP:
+		ovpn_tcp_send_skb(peer, skb);
+		break;
 	default:
 		/* no transport configured yet */
 		goto err;
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 4e6f6fd5ae56..19f7c0ff679b 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -25,6 +25,7 @@
 #include "io.h"
 #include "packet.h"
 #include "peer.h"
+#include "tcp.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
@@ -279,6 +280,8 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	ovpn_tcp_init();
+
 	return 0;
 
 unreg_rtnl:
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dd4d91dfabb5..86d4696b1529 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,8 +10,8 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
-#include <linux/ptr_ring.h>
 #include <net/dst_cache.h>
+#include <net/strparser.h>
 #include <uapi/linux/ovpn.h>
 
 #include "bind.h"
@@ -31,6 +31,18 @@
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
  * @sock: the socket being used to talk to this peer
+ * @tcp: keeps track of TCP specific state
+ * @tcp.strp: stream parser context (TCP only)
+ * @tcp.tx_work: work for deferring outgoing packet processing (TCP only)
+ * @tcp.user_queue: received packets that have to go to userspace (TCP only)
+ * @tcp.tx_in_progress: true if TX is already ongoing (TCP only)
+ * @tcp.out_msg.skb: packet scheduled for sending (TCP only)
+ * @tcp.out_msg.offset: offset where next send should start (TCP only)
+ * @tcp.out_msg.len: remaining data to send within packet (TCP only)
+ * @tcp.sk_cb.sk_data_ready: pointer to original cb (TCP only)
+ * @tcp.sk_cb.sk_write_space: pointer to original cb (TCP only)
+ * @tcp.sk_cb.prot: pointer to original prot object (TCP only)
+ * @tcp.sk_cb.ops: pointer to the original prot_ops object (TCP only)
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
@@ -51,6 +63,30 @@ struct ovpn_peer {
 		struct in6_addr ipv6;
 	} vpn_addrs;
 	struct ovpn_socket *sock;
+
+	/* state of the TCP reading. Needed to keep track of how much of a
+	 * single packet has already been read from the stream and how much is
+	 * missing
+	 */
+	struct {
+		struct strparser strp;
+		struct work_struct tx_work;
+		struct sk_buff_head user_queue;
+		bool tx_in_progress;
+
+		struct {
+			struct sk_buff *skb;
+			int offset;
+			int len;
+		} out_msg;
+
+		struct {
+			void (*sk_data_ready)(struct sock *sk);
+			void (*sk_write_space)(struct sock *sk);
+			struct proto *prot;
+			const struct proto_ops *ops;
+		} sk_cb;
+	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 964b566de69f..8bb3b0cb18ec 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -15,6 +15,7 @@
 #include "io.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 static void ovpn_socket_detach(struct socket *sock)
@@ -24,6 +25,8 @@ static void ovpn_socket_detach(struct socket *sock)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ovpn_udp_socket_detach(sock);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ovpn_tcp_socket_detach(sock);
 
 	sockfd_put(sock);
 }
@@ -70,6 +73,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ret = ovpn_tcp_socket_attach(sock, peer);
 
 	return ret;
 }
@@ -131,14 +136,30 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	}
 
 	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
-	if (!ovpn_sock)
-		return ERR_PTR(-ENOMEM);
+	if (!ovpn_sock) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	ovpn_sock->ovpn = peer->ovpn;
 	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
 
+	/* TCP sockets are per-peer, therefore they are linked to their unique
+	 * peer
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_TCP) {
+		ovpn_sock->peer = peer;
+	} else {
+		/* in UDP we only link the ovpn instance since the socket is
+		 * shared among multiple peers
+		 */
+		ovpn_sock->ovpn = peer->ovpn;
+	}
+
 	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
 
 	return ovpn_sock;
+err:
+	ovpn_socket_detach(sock);
+	return ERR_PTR(ret);
 }
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 08ca1ec25aa2..65883231f6ab 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -21,12 +21,17 @@ struct ovpn_peer;
 /**
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
+ * @peer: unique peer transmitting over this socket (TCP only)
  * @sock: the low level sock object
  * @refcount: amount of contexts currently referencing this object
  * @rcu: member used to schedule RCU destructor callback
  */
 struct ovpn_socket {
-	struct ovpn_struct *ovpn;
+	union {
+		struct ovpn_struct *ovpn;
+		struct ovpn_peer *peer;
+	};
+
 	struct socket *sock;
 	struct kref refcount;
 	struct rcu_head rcu;
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
new file mode 100644
index 000000000000..357aeed977ee
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/skbuff.h>
+#include <net/hotdata.h>
+#include <net/inet_common.h>
+#include <net/tcp.h>
+#include <net/route.h>
+#include <trace/events/sock.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "io.h"
+#include "packet.h"
+#include "peer.h"
+#include "proto.h"
+#include "skb.h"
+#include "socket.h"
+#include "tcp.h"
+
+static struct proto ovpn_tcp_prot __ro_after_init;
+static struct proto_ops ovpn_tcp_ops __ro_after_init;
+static struct proto ovpn_tcp6_prot;
+static struct proto_ops ovpn_tcp6_ops;
+static DEFINE_MUTEX(tcp6_prot_mutex);
+
+static int ovpn_tcp_parse(struct strparser *strp, struct sk_buff *skb)
+{
+	struct strp_msg *rxm = strp_msg(skb);
+	__be16 blen;
+	u16 len;
+	int err;
+
+	/* when packets are written to the TCP stream, they are prepended with
+	 * two bytes indicating the actual packet size.
+	 * Here we read those two bytes and move the skb data pointer to the
+	 * beginning of the packet
+	 */
+
+	if (skb->len < rxm->offset + 2)
+		return 0;
+
+	err = skb_copy_bits(skb, rxm->offset, &blen, sizeof(blen));
+	if (err < 0)
+		return err;
+
+	len = be16_to_cpu(blen);
+	if (len < 2)
+		return -EINVAL;
+
+	return len + 2;
+}
+
+/* queue skb for sending to userspace via recvmsg on the socket */
+static int ovpn_tcp_to_userspace(struct ovpn_socket *sock, struct sk_buff *skb)
+{
+	struct sock *sk = sock->sock->sk;
+
+	skb_set_owner_r(skb, sk);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	skb_queue_tail(&sock->peer->tcp.user_queue, skb);
+	sock->peer->tcp.sk_cb.sk_data_ready(sk);
+
+	return 0;
+}
+
+static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
+	struct strp_msg *msg = strp_msg(skb);
+	size_t pkt_len = msg->full_len - 2;
+	size_t off = msg->offset + 2;
+
+	/* ensure skb->data points to the beginning of the openvpn packet */
+	if (!pskb_pull(skb, off)) {
+		net_warn_ratelimited("%s: packet too small\n",
+				     peer->ovpn->dev->name);
+		goto err;
+	}
+
+	/* strparser does not trim the skb for us, therefore we do it now */
+	if (pskb_trim(skb, pkt_len) != 0) {
+		net_warn_ratelimited("%s: trimming skb failed\n",
+				     peer->ovpn->dev->name);
+		goto err;
+	}
+
+	/* we need the first byte of data to be accessible
+	 * to extract the opcode and the key ID later on
+	 */
+	if (!pskb_may_pull(skb, 1)) {
+		net_warn_ratelimited("%s: packet too small to fetch opcode\n",
+				     peer->ovpn->dev->name);
+		goto err;
+	}
+
+	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
+	if (likely(ovpn_opcode_from_skb(skb, 0) == OVPN_DATA_V2)) {
+		/* hold reference to peer as required by ovpn_recv().
+		 *
+		 * NOTE: in this context we should already be holding a
+		 * reference to this peer, therefore ovpn_peer_hold() is
+		 * not expected to fail
+		 */
+		WARN_ON(!ovpn_peer_hold(peer));
+		ovpn_recv(peer, skb);
+	} else {
+		/* The packet size header must be there when sending the packet
+		 * to userspace, therefore we put it back
+		 */
+		skb_push(skb, 2);
+		memset(skb->cb, 0, sizeof(skb->cb));
+		if (ovpn_tcp_to_userspace(peer->sock, skb) < 0) {
+			net_warn_ratelimited("%s: cannot send skb to userspace\n",
+					     peer->ovpn->dev->name);
+			goto err;
+		}
+	}
+
+	return;
+err:
+	netdev_err(peer->ovpn->dev,
+		   "cannot process incoming TCP data for peer %u\n", peer->id);
+	dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+	kfree_skb(skb);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+}
+
+static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			    int flags, int *addr_len)
+{
+	int err = 0, off, copied = 0, ret;
+	struct ovpn_socket *sock;
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (!sock || !sock->peer) {
+		rcu_read_unlock();
+		return -EBADF;
+	}
+	/* we take a reference to the peer linked to this TCP socket, because
+	 * in turn the peer holds a reference to the socket itself.
+	 * By doing so we also ensure that the peer stays alive along with
+	 * the socket while executing this function
+	 */
+	ovpn_peer_hold(sock->peer);
+	peer = sock->peer;
+	rcu_read_unlock();
+
+	skb = __skb_recv_datagram(sk, &peer->tcp.user_queue, flags, &off, &err);
+	if (!skb) {
+		if (err == -EAGAIN && sk->sk_shutdown & RCV_SHUTDOWN) {
+			ret = 0;
+			goto out;
+		}
+		ret = err;
+		goto out;
+	}
+
+	copied = len;
+	if (copied > skb->len)
+		copied = skb->len;
+	else if (copied < skb->len)
+		msg->msg_flags |= MSG_TRUNC;
+
+	err = skb_copy_datagram_msg(skb, 0, msg, copied);
+	if (unlikely(err)) {
+		kfree_skb(skb);
+		ret = err;
+		goto out;
+	}
+
+	if (flags & MSG_TRUNC)
+		copied = skb->len;
+	kfree_skb(skb);
+	ret = copied;
+out:
+	ovpn_peer_put(peer);
+	return ret;
+}
+
+void ovpn_tcp_socket_detach(struct socket *sock)
+{
+	struct ovpn_socket *ovpn_sock;
+	struct ovpn_peer *peer;
+
+	if (!sock)
+		return;
+
+	rcu_read_lock();
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+
+	if (!ovpn_sock->peer) {
+		rcu_read_unlock();
+		return;
+	}
+
+	peer = ovpn_sock->peer;
+	strp_stop(&peer->tcp.strp);
+
+	skb_queue_purge(&peer->tcp.user_queue);
+
+	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
+	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
+	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
+	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
+	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+	rcu_assign_sk_user_data(sock->sk, NULL);
+
+	/* cancel any ongoing work. Done after removing the CBs so that these
+	 * workers cannot be re-armed
+	 */
+	cancel_work_sync(&peer->tcp.tx_work);
+	strp_done(&peer->tcp.strp);
+	rcu_read_unlock();
+}
+
+static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
+{
+	struct sk_buff *skb = peer->tcp.out_msg.skb;
+
+	if (!skb)
+		return;
+
+	if (peer->tcp.tx_in_progress)
+		return;
+
+	peer->tcp.tx_in_progress = true;
+
+	do {
+		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
+					       peer->tcp.out_msg.offset,
+					       peer->tcp.out_msg.len);
+		if (unlikely(ret < 0)) {
+			if (ret == -EAGAIN)
+				goto out;
+
+			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
+					     peer->ovpn->dev->name, peer->id,
+					     ret);
+
+			/* in case of TCP error we can't recover the VPN
+			 * stream therefore we abort the connection
+			 */
+			ovpn_peer_del(peer,
+				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+			break;
+		}
+
+		peer->tcp.out_msg.len -= ret;
+		peer->tcp.out_msg.offset += ret;
+	} while (peer->tcp.out_msg.len > 0);
+
+	if (!peer->tcp.out_msg.len)
+		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
+
+	kfree_skb(peer->tcp.out_msg.skb);
+	peer->tcp.out_msg.skb = NULL;
+	peer->tcp.out_msg.len = 0;
+	peer->tcp.out_msg.offset = 0;
+
+out:
+	peer->tcp.tx_in_progress = false;
+}
+
+static void ovpn_tcp_tx_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer;
+
+	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
+
+	lock_sock(peer->sock->sock->sk);
+	ovpn_tcp_send_sock(peer);
+	release_sock(peer->sock->sock->sk);
+}
+
+void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	if (peer->tcp.out_msg.skb)
+		return;
+
+	peer->tcp.out_msg.skb = skb;
+	peer->tcp.out_msg.len = skb->len;
+	peer->tcp.out_msg.offset = 0;
+
+	ovpn_tcp_send_sock(peer);
+}
+
+static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+{
+	struct ovpn_socket *sock;
+	int ret, linear = PAGE_SIZE;
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	peer = sock->peer;
+	rcu_read_unlock();
+
+	if (msg->msg_flags & ~MSG_DONTWAIT)
+		return -EOPNOTSUPP;
+
+	lock_sock(sk);
+
+	if (peer->tcp.out_msg.skb) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+
+	if (size < linear)
+		linear = size;
+
+	skb = sock_alloc_send_pskb(sk, linear, size - linear,
+				   msg->msg_flags & MSG_DONTWAIT, &ret, 0);
+	if (!skb) {
+		net_err_ratelimited("%s: skb alloc failed: %d\n",
+				    sock->peer->ovpn->dev->name, ret);
+		goto unlock;
+	}
+
+	skb_put(skb, linear);
+	skb->len = size;
+	skb->data_len = size - linear;
+
+	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
+	if (ret) {
+		kfree_skb(skb);
+		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
+				    sock->peer->ovpn->dev->name, ret);
+		goto unlock;
+	}
+
+	ovpn_tcp_send_sock_skb(sock->peer, skb);
+	ret = size;
+unlock:
+	release_sock(sk);
+	return ret;
+}
+
+static void ovpn_tcp_data_ready(struct sock *sk)
+{
+	struct ovpn_socket *sock;
+
+	trace_sk_data_ready(sk);
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	strp_data_ready(&sock->peer->tcp.strp);
+	rcu_read_unlock();
+}
+
+static void ovpn_tcp_write_space(struct sock *sk)
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	schedule_work(&sock->peer->tcp.tx_work);
+	sock->peer->tcp.sk_cb.sk_write_space(sk);
+	rcu_read_unlock();
+}
+
+static void ovpn_tcp_build_protos(struct proto *ovpn_tcp_prot,
+				  struct proto_ops *ovpn_tcp_ops,
+				  const struct proto *orig_prot,
+				  const struct proto_ops *orig_ops);
+
+/* Set TCP encapsulation callbacks */
+int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
+{
+	struct strp_callbacks cb = {
+		.rcv_msg = ovpn_tcp_rcv,
+		.parse_msg = ovpn_tcp_parse,
+	};
+	int ret;
+
+	/* make sure no pre-existing encapsulation handler exists */
+	if (sock->sk->sk_user_data)
+		return -EBUSY;
+
+	/* sanity check */
+	if (sock->sk->sk_protocol != IPPROTO_TCP) {
+		netdev_err(peer->ovpn->dev,
+			   "provided socket is not TCP as expected\n");
+		return -EINVAL;
+	}
+
+	/* only a fully connected socket are expected. Connection should be
+	 * handled in userspace
+	 */
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		netdev_err(peer->ovpn->dev,
+			   "provided TCP socket is not in ESTABLISHED state: %d\n",
+			   sock->sk->sk_state);
+		return -EINVAL;
+	}
+
+	lock_sock(sock->sk);
+
+	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
+	if (ret < 0) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		release_sock(sock->sk);
+		return ret;
+	}
+
+	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
+	__sk_dst_reset(sock->sk);
+	strp_check_rcv(&peer->tcp.strp);
+	skb_queue_head_init(&peer->tcp.user_queue);
+
+	/* save current CBs so that they can be restored upon socket release */
+	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
+	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
+	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
+	peer->tcp.sk_cb.ops = sock->sk->sk_socket->ops;
+
+	/* assign our static CBs and prot/ops */
+	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
+	sock->sk->sk_write_space = ovpn_tcp_write_space;
+
+	if (sock->sk->sk_family == AF_INET) {
+		sock->sk->sk_prot = &ovpn_tcp_prot;
+		sock->sk->sk_socket->ops = &ovpn_tcp_ops;
+	} else {
+		mutex_lock(&tcp6_prot_mutex);
+		if (!ovpn_tcp6_prot.recvmsg)
+			ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
+					      sock->sk->sk_prot,
+					      sock->sk->sk_socket->ops);
+		mutex_unlock(&tcp6_prot_mutex);
+
+		sock->sk->sk_prot = &ovpn_tcp6_prot;
+		sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
+	}
+
+	/* avoid using task_frag */
+	sock->sk->sk_allocation = GFP_ATOMIC;
+	sock->sk->sk_use_task_frag = false;
+
+	release_sock(sock->sk);
+	return 0;
+}
+
+static void ovpn_tcp_close(struct sock *sk, long timeout)
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+
+	strp_stop(&sock->peer->tcp.strp);
+	barrier();
+
+	tcp_close(sk, timeout);
+
+	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	rcu_read_unlock();
+}
+
+static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
+			      poll_table *wait)
+{
+	__poll_t mask = datagram_poll(file, sock, wait);
+	struct ovpn_socket *ovpn_sock;
+
+	rcu_read_lock();
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+	if (!skb_queue_empty(&ovpn_sock->peer->tcp.user_queue))
+		mask |= EPOLLIN | EPOLLRDNORM;
+	rcu_read_unlock();
+
+	return mask;
+}
+
+static void ovpn_tcp_build_protos(struct proto *tcp_prot,
+				  struct proto_ops *tcp_ops,
+				  const struct proto *orig_prot,
+				  const struct proto_ops *orig_ops)
+{
+	memcpy(tcp_prot, orig_prot, sizeof(struct proto));
+	memcpy(tcp_ops, orig_ops, sizeof(struct proto_ops));
+	tcp_prot->recvmsg = ovpn_tcp_recvmsg;
+	tcp_prot->sendmsg = ovpn_tcp_sendmsg;
+	tcp_prot->close = ovpn_tcp_close;
+	tcp_ops->poll = ovpn_tcp_poll;
+}
+
+/* Initialize TCP static objects */
+void __init ovpn_tcp_init(void)
+{
+	ovpn_tcp_build_protos(&ovpn_tcp_prot, &ovpn_tcp_ops, &tcp_prot,
+			      &inet_stream_ops);
+}
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
new file mode 100644
index 000000000000..11c12a9cbe1b
--- /dev/null
+++ b/drivers/net/ovpn/tcp.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_TCP_H_
+#define _NET_OVPN_TCP_H_
+
+#include <linux/net.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "peer.h"
+
+void __init ovpn_tcp_init(void);
+
+int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer);
+void ovpn_tcp_socket_detach(struct socket *sock);
+void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+
+/* Prepare skb and enqueue it for sending to peer.
+ *
+ * Preparation consist in prepending the skb payload with its size.
+ * Required by the OpenVPN protocol in order to extract packets from
+ * the TCP stream on the receiver side.
+ */
+static inline void ovpn_tcp_send_skb(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	u16 len = skb->len;
+
+	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
+
+	bh_lock_sock(peer->sock->sock->sk);
+	ovpn_tcp_send_sock_skb(peer, skb);
+	bh_unlock_sock(peer->sock->sock->sk);
+}
+
+#endif /* _NET_OVPN_TCP_H_ */
-- 
2.44.2


