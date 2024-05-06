Return-Path: <netdev+bounces-93569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE68B8BC550
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B35282309
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD543AD2;
	Mon,  6 May 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CmKgbxa/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A53D984
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958152; cv=none; b=rbT3CpAbjsIIk7PMuibmVxtwlWj53Ag5UT3AZqdfPvFYVHm3nHfqnHA5Vy2NcI5QqnfwQ3WC/aScOHUFRta3pc5g+uNRkyaDw7vLGXc0HcctMUcQY02vaJSjMDFnqRmGw0GsawDIiirJpsmFhDJPZu6+TL1wt5Fw7RxfKchIhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958152; c=relaxed/simple;
	bh=+fP3FfyfqFOCHw7EkqTwdYzUdkBvvD0C5m9nP6J+Nhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxjgynaxkD2c06cMqWmiCFE7mqJK5iCwa0VVNJ2FDEJ2mv3kDk2s3RwuTkycpOuwddDUXUcJfCBposMW8nPgP/yIHzv5W6ybEB1TXRFZteE4FS+UESQQoKuXsj/4Y/W9z7VGigpDCZmBonrhomzYP2xiRVEYlBU/bh9xPtQpYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CmKgbxa/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34da35cd01cso1368948f8f.2
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958148; x=1715562948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAgTlKOQudDZW+WKhPS1/2+gxDKOxPa6tYTwDaf+t7Q=;
        b=CmKgbxa/EqcPdUcq8D/W6Dg8kTRKx5p04Sh+EbN8UFPPaTcNbPOqW42O7RV334HTVF
         51y/dI3v02b3lgXsiAMea17T0LEGYMrvZi7jn8grKMSg0lz04SE8bl5T2zQT2O6JLVWJ
         9QNyRJgamBFAI5rKrKTTQ+1BsZK9PfBMzpKyz4K2X/YQ9DC++0ccNDveya0LH72nLATi
         t1Lb0QN5XPNvVlnhaE7jGtz9GdZvlp35RKGVKu+3YsfBPSkSRrVbyNWY4zR4NHyVVhze
         x+VxwJiZnyM5OkF/58GrxGOd7ZpWCvl/Pl3HaouN3G3ADMX7Eaefb9afYorPCDgbQRrW
         Hlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958148; x=1715562948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAgTlKOQudDZW+WKhPS1/2+gxDKOxPa6tYTwDaf+t7Q=;
        b=mUBE3ojwo7aL9DaEC+BU1jxC4s054LykmRPqP3PBC3Q49Um0Fb/QIZotcSj/n9GCtD
         CpqNBlZ/n1Y+KPu8kSjdL4277u6eIwq8Y2/MLt0BL9hMht1vQE3EpqBFIi/aeL1cLw5J
         Ar4s/PxHiQAhZbwSbHWs+RflJWcIAJr1MkMod4voeyarbFqTzZ2GYmCYJEZGVchILLGx
         D8xjfr4NuJ4Ctd/uZmQkaH5WajutzokB3v7IfO8wyJF3RIcdxHLUB5a9FwBT7x4faTUd
         O3K2AmFrq+tFsu/8AT8s3ym6AGgvFQqPxtLm1doibcz0v7U0Ik8KeKVBdcmGASyDS1mE
         SlrA==
X-Gm-Message-State: AOJu0YwGqHVSCisXJGcvBDWuaeUBn11myL2aTLXXzX94Y0zxjf2X9Ug2
	60jzKt+Z99PpfvFQ/OPFueQCruu/x2VUPfBYkq4fCR0Je9uDoLyoBlXwxmS2wAfWSNee38GPmvk
	S
X-Google-Smtp-Source: AGHT+IErl/z1CjGcSVgImxrWWDMf2IEwlBQfDm6uwqD6S1iPOBSafoYi8J0KQroD4ds7U2++MWFhqQ==
X-Received: by 2002:a5d:494f:0:b0:34d:17f2:956d with SMTP id r15-20020a5d494f000000b0034d17f2956dmr7495907wrs.66.1714958147832;
        Sun, 05 May 2024 18:15:47 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:47 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 13/24] ovpn: implement TCP transport
Date: Mon,  6 May 2024 03:16:26 +0200
Message-ID: <20240506011637.27272-14-antonio@openvpn.net>
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

With this changem ovpn is allowed to communicate to peers also via TCP.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |   1 +
 drivers/net/ovpn/io.c     |   5 +
 drivers/net/ovpn/main.c   |   9 +-
 drivers/net/ovpn/peer.h   |  29 +++
 drivers/net/ovpn/skb.h    |  51 ++++
 drivers/net/ovpn/socket.c |  20 ++
 drivers/net/ovpn/socket.h |  15 +-
 drivers/net/ovpn/tcp.c    | 511 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h    |  42 ++++
 9 files changed, 681 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ovpn/skb.h
 create mode 100644 drivers/net/ovpn/tcp.c
 create mode 100644 drivers/net/ovpn/tcp.h

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
index 699e7f1274db..49efcfff963c 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -21,6 +21,7 @@
 #include "netlink.h"
 #include "proto.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 int ovpn_struct_init(struct net_device *dev)
@@ -307,6 +308,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 /* Process packets in TX queue in a transport-specific way.
  *
  * UDP transport - encrypt and send across the tunnel.
+ * TCP transport - encrypt and put into TCP TX queue.
  */
 void ovpn_encrypt_work(struct work_struct *work)
 {
@@ -340,6 +342,9 @@ void ovpn_encrypt_work(struct work_struct *work)
 					ovpn_udp_send_skb(peer->ovpn, peer,
 							  curr);
 					break;
+				case IPPROTO_TCP:
+					ovpn_tcp_send_skb(peer, curr);
+					break;
 				default:
 					/* no transport configured yet */
 					consume_skb(skb);
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9ae9844dd281..a04d6e55a473 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,7 @@
 #include "io.h"
 #include "packet.h"
 #include "peer.h"
+#include "tcp.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
@@ -247,8 +248,14 @@ static struct pernet_operations ovpn_pernet_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = register_netdevice_notifier(&ovpn_netdev_notifier);
+	int err = ovpn_tcp_init();
 
+	if (err) {
+		pr_err("ovpn: cannot initialize TCP component: %d\n", err);
+		return err;
+	}
+
+	err = register_netdevice_notifier(&ovpn_netdev_notifier);
 	if (err) {
 		pr_err("ovpn: can't register netdevice notifier: %d\n", err);
 		return err;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index b5ff59a4b40f..ac4907705d98 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -33,6 +33,16 @@
  * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
  * @napi: NAPI object
  * @sock: the socket being used to talk to this peer
+ * @tcp.tx_ring: queue for packets to be forwarded to userspace (TCP only)
+ * @tcp.tx_work: work for processing outgoing socket data (TCP only)
+ * @tcp.rx_work: wok for processing incoming socket data (TCP only)
+ * @tcp.raw_len: next packet length as read from the stream (TCP only)
+ * @tcp.skb: next packet being filled with data from the stream (TCP only)
+ * @tcp.offset: position of the next byte to write in the skb (TCP only)
+ * @tcp.data_len: next packet length converted to host order (TCP only)
+ * @tcp.sk_cb.sk_data_ready: pointer to original cb
+ * @tcp.sk_cb.sk_write_space: pointer to original cb
+ * @tcp.sk_cb.prot: pointer to original prot object
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
@@ -59,6 +69,25 @@ struct ovpn_peer {
 	struct ptr_ring netif_rx_ring;
 	struct napi_struct napi;
 	struct ovpn_socket *sock;
+	/* state of the TCP reading. Needed to keep track of how much of a
+	 * single packet has already been read from the stream and how much is
+	 * missing
+	 */
+	struct {
+		struct ptr_ring tx_ring;
+		struct work_struct tx_work;
+		struct work_struct rx_work;
+
+		u8 raw_len[sizeof(u16)];
+		struct sk_buff *skb;
+		u16 offset;
+		u16 data_len;
+		struct {
+			void (*sk_data_ready)(struct sock *sk);
+			void (*sk_write_space)(struct sock *sk);
+			struct proto *prot;
+		} sk_cb;
+	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
new file mode 100644
index 000000000000..ba92811e12ff
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
+#define OVPN_SKB_CB(skb) ((struct ovpn_skb_cb *)&((skb)->cb))
+
+struct ovpn_skb_cb {
+	union {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} local;
+	sa_family_t sa_fam;
+};
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
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index e099a61b03fa..004db5b13663 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -16,6 +16,7 @@
 #include "packet.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 /* Finalize release of socket, called after RCU grace period */
@@ -26,6 +27,8 @@ static void ovpn_socket_detach(struct socket *sock)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ovpn_udp_socket_detach(sock);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ovpn_tcp_socket_detach(sock);
 
 	sockfd_put(sock);
 }
@@ -69,6 +72,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ret = ovpn_tcp_socket_attach(sock, peer);
 
 	return ret;
 }
@@ -124,6 +129,21 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
 
+	/* TCP sockets are per-peer, therefore they are linked to their unique
+	 * peer
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_TCP) {
+		ovpn_sock->peer = peer;
+		ret = ptr_ring_init(&ovpn_sock->recv_ring, OVPN_QUEUE_LEN,
+				    GFP_KERNEL);
+		if (ret < 0) {
+			netdev_err(peer->ovpn->dev, "%s: cannot allocate TCP recv ring\n",
+				   __func__);
+			kfree(ovpn_sock);
+			return ERR_PTR(ret);
+		}
+	}
+
 	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
 
 	return ovpn_sock;
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 0d23de5a9344..88c6271ba5c7 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -21,12 +21,25 @@ struct ovpn_peer;
 /**
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
+ * @peer: unique peer transmitting over this socket (TCP only)
+ * @recv_ring: queue where non-data packets directed to userspace are stored
  * @sock: the low level sock object
  * @refcount: amount of contexts currently referencing this object
  * @rcu: member used to schedule RCU destructor callback
  */
 struct ovpn_socket {
-	struct ovpn_struct *ovpn;
+	union {
+		/* the VPN session object owning this socket (UDP only) */
+		struct ovpn_struct *ovpn;
+
+		/* TCP only */
+		struct {
+			/** @peer: unique peer transmitting over this socket */
+			struct ovpn_peer *peer;
+			struct ptr_ring recv_ring;
+		};
+	};
+
 	struct socket *sock;
 	struct kref refcount;
 	struct rcu_head rcu;
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
new file mode 100644
index 000000000000..84ad7cd4fc4f
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/ptr_ring.h>
+#include <linux/skbuff.h>
+#include <net/tcp.h>
+#include <net/route.h>
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
+static struct proto ovpn_tcp_prot;
+
+static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
+			      unsigned int in_offset, size_t in_len)
+{
+	struct sock *sk = desc->arg.data;
+	struct ovpn_socket *sock;
+	struct ovpn_skb_cb *cb;
+	struct ovpn_peer *peer;
+	size_t chunk, copied = 0;
+	void *data;
+	u16 len;
+	int st;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	rcu_read_unlock();
+
+	if (unlikely(!sock || !sock->peer)) {
+		pr_err("ovpn: read_sock triggered for socket with no metadata\n");
+		desc->error = -EINVAL;
+		return 0;
+	}
+
+	peer = sock->peer;
+
+	while (in_len > 0) {
+		/* no skb allocated means that we have to read (or finish
+		 * reading) the 2 bytes prefix containing the actual packet
+		 * size.
+		 */
+		if (!peer->tcp.skb) {
+			chunk = min_t(size_t, in_len,
+				      sizeof(u16) - peer->tcp.offset);
+			WARN_ON(skb_copy_bits(in_skb, in_offset,
+					      peer->tcp.raw_len +
+					      peer->tcp.offset, chunk) < 0);
+			peer->tcp.offset += chunk;
+
+			/* keep on reading until we got the whole packet size */
+			if (peer->tcp.offset != sizeof(u16))
+				goto next_read;
+
+			len = ntohs(*(__be16 *)peer->tcp.raw_len);
+			/* invalid packet length: this is a fatal TCP error */
+			if (!len) {
+				netdev_err(peer->ovpn->dev,
+					   "%s: received invalid packet length: %d\n",
+					   __func__, len);
+				desc->error = -EINVAL;
+				goto err;
+			}
+
+			/* add 2 bytes to allocated space (and immediately
+			 * reserve them) for packet length prepending, in case
+			 * the skb has to be forwarded to userspace
+			 */
+			peer->tcp.skb =
+				netdev_alloc_skb_ip_align(peer->ovpn->dev,
+							  len + sizeof(u16));
+			if (!peer->tcp.skb) {
+				desc->error = -ENOMEM;
+				goto err;
+			}
+			skb_reserve(peer->tcp.skb, sizeof(u16));
+
+			peer->tcp.offset = 0;
+			peer->tcp.data_len = len;
+		} else {
+			chunk = min_t(size_t, in_len,
+				      peer->tcp.data_len - peer->tcp.offset);
+
+			/* extend skb to accommodate the new chunk and copy it
+			 * from the input skb
+			 */
+			data = skb_put(peer->tcp.skb, chunk);
+			WARN_ON(skb_copy_bits(in_skb, in_offset, data,
+					      chunk) < 0);
+			peer->tcp.offset += chunk;
+
+			/* keep on reading until we get the full packet */
+			if (peer->tcp.offset != peer->tcp.data_len)
+				goto next_read;
+
+			/* do not perform IP caching for TCP connections */
+			cb = OVPN_SKB_CB(peer->tcp.skb);
+			cb->sa_fam = AF_UNSPEC;
+
+			/* At this point we know the packet is from a configured
+			 * peer.
+			 * DATA_V2 packets are handled in kernel space, the rest
+			 * goes to user space.
+			 *
+			 * Queue skb for sending to userspace via recvmsg on the
+			 * socket
+			 */
+			if (likely(ovpn_opcode_from_skb(peer->tcp.skb, 0) ==
+				   OVPN_DATA_V2)) {
+				/* hold reference to peer as required by
+				 * ovpn_recv().
+				 *
+				 * NOTE: in this context we should already be
+				 * holding a reference to this peer, therefore
+				 * ovpn_peer_hold() is not expected to fail
+				 */
+				WARN_ON(!ovpn_peer_hold(peer));
+				st = ovpn_recv(peer->ovpn, peer, peer->tcp.skb);
+				if (unlikely(st < 0))
+					ovpn_peer_put(peer);
+
+			} else {
+				/* prepend skb with packet len. this way
+				 * userspace can parse the packet as if it just
+				 * arrived from the remote endpoint
+				 */
+				void *raw_len = __skb_push(peer->tcp.skb,
+							   sizeof(u16));
+
+				memcpy(raw_len, peer->tcp.raw_len, sizeof(u16));
+
+				st = ptr_ring_produce_bh(&peer->sock->recv_ring,
+							 peer->tcp.skb);
+				if (likely(!st))
+					peer->tcp.sk_cb.sk_data_ready(sk);
+			}
+
+			/* skb not consumed - free it now */
+			if (unlikely(st < 0))
+				kfree_skb(peer->tcp.skb);
+
+			peer->tcp.skb = NULL;
+			peer->tcp.offset = 0;
+			peer->tcp.data_len = 0;
+		}
+next_read:
+		in_len -= chunk;
+		in_offset += chunk;
+		copied += chunk;
+	}
+
+	return copied;
+err:
+	netdev_err(peer->ovpn->dev, "cannot process incoming TCP data: %d\n",
+		   desc->error);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	return 0;
+}
+
+static void ovpn_tcp_data_ready(struct sock *sk)
+{
+	struct socket *sock = sk->sk_socket;
+	read_descriptor_t desc;
+
+	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
+		return;
+
+	desc.arg.data = sk;
+	desc.error = 0;
+	desc.count = 1;
+
+	sock->ops->read_sock(sk, &desc, ovpn_tcp_read_sock);
+}
+
+static void ovpn_tcp_write_space(struct sock *sk)
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	rcu_read_unlock();
+
+	if (!sock || !sock->peer)
+		return;
+
+	queue_work(sock->peer->ovpn->events_wq, &sock->peer->tcp.tx_work);
+}
+
+static bool ovpn_tcp_sock_is_readable(struct sock *sk)
+
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	rcu_read_unlock();
+
+	if (!sock || !sock->peer)
+		return false;
+
+	return !ptr_ring_empty_bh(&sock->recv_ring);
+}
+
+static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			    int flags, int *addr_len)
+{
+	bool tmp = flags & MSG_DONTWAIT;
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	int ret, chunk, copied = 0;
+	struct ovpn_socket *sock;
+	struct sk_buff *skb;
+	long timeo;
+
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_IP, IP_RECVERR);
+
+	timeo = sock_rcvtimeo(sk, tmp);
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	rcu_read_unlock();
+
+	if (!sock || !sock->peer) {
+		ret = -EBADF;
+		goto unlock;
+	}
+
+	while (ptr_ring_empty_bh(&sock->recv_ring)) {
+		if (sk->sk_shutdown & RCV_SHUTDOWN)
+			return 0;
+
+		if (sock_flag(sk, SOCK_DONE))
+			return 0;
+
+		if (!timeo) {
+			ret = -EAGAIN;
+			goto unlock;
+		}
+
+		add_wait_queue(sk_sleep(sk), &wait);
+		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+		sk_wait_event(sk, &timeo, !ptr_ring_empty_bh(&sock->recv_ring),
+			      &wait);
+		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+		remove_wait_queue(sk_sleep(sk), &wait);
+
+		/* take care of signals */
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			goto unlock;
+		}
+	}
+
+	while (len && (skb = __ptr_ring_peek(&sock->recv_ring))) {
+		chunk = min_t(size_t, len, skb->len);
+		ret = skb_copy_datagram_msg(skb, 0, msg, chunk);
+		if (ret < 0) {
+			pr_err("ovpn: cannot copy TCP data to userspace: %d\n",
+			       ret);
+			kfree_skb(skb);
+			goto unlock;
+		}
+
+		__skb_pull(skb, chunk);
+
+		if (!skb->len) {
+			/* skb was entirely consumed and can now be removed from
+			 * the ring
+			 */
+			__ptr_ring_discard_one(&sock->recv_ring);
+			consume_skb(skb);
+		}
+
+		len -= chunk;
+		copied += chunk;
+	}
+	ret = copied;
+
+unlock:
+	return ret ? : -EAGAIN;
+}
+
+static void ovpn_destroy_skb(void *skb)
+{
+	consume_skb(skb);
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
+	rcu_read_unlock();
+
+	if (!ovpn_sock->peer)
+		return;
+
+	peer = ovpn_sock->peer;
+
+	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
+	write_lock_bh(&sock->sk->sk_callback_lock);
+	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
+	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
+	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
+	rcu_assign_sk_user_data(sock->sk, NULL);
+	write_unlock_bh(&sock->sk->sk_callback_lock);
+
+	/* cancel any ongoing work. Done after removing the CBs so that these
+	 * workers cannot be re-armed
+	 */
+	cancel_work_sync(&peer->tcp.tx_work);
+
+	ptr_ring_cleanup(&ovpn_sock->recv_ring, ovpn_destroy_skb);
+	ptr_ring_cleanup(&peer->tcp.tx_ring, ovpn_destroy_skb);
+}
+
+/* Try to send one skb (or part of it) over the TCP stream.
+ *
+ * Return 0 on success or a negative error code otherwise.
+ *
+ * Note that the skb is modified by putting away the data being sent, therefore
+ * the caller should check if skb->len is zero to understand if the full skb was
+ * sent or not.
+ */
+static int ovpn_tcp_send_one(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL };
+	struct kvec iv = { 0 };
+	int ret;
+
+	if (skb_linearize(skb) < 0) {
+		net_err_ratelimited("%s: can't linearize packet\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* initialize iv structure now as skb_linearize() may have changed
+	 * skb->data
+	 */
+	iv.iov_base = skb->data;
+	iv.iov_len = skb->len;
+
+	ret = kernel_sendmsg(peer->sock->sock, &msg, &iv, 1, iv.iov_len);
+	if (ret > 0) {
+		__skb_pull(skb, ret);
+
+		/* since we update per-cpu stats in process context,
+		 * we need to disable softirqs
+		 */
+		local_bh_disable();
+		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, ret);
+		local_bh_enable();
+
+		return 0;
+	}
+
+	return ret;
+}
+
+/* Process packets in TCP TX queue */
+static void ovpn_tcp_tx_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+	int ret;
+
+	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
+	while ((skb = __ptr_ring_peek(&peer->tcp.tx_ring))) {
+		ret = ovpn_tcp_send_one(peer, skb);
+		if (ret < 0 && ret != -EAGAIN) {
+			net_warn_ratelimited("%s: cannot send TCP packet to peer %u: %d\n",
+					     __func__, peer->id, ret);
+			/* in case of TCP error stop sending loop and delete
+			 * peer
+			 */
+			ovpn_peer_del(peer,
+				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+			break;
+		} else if (!skb->len) {
+			/* skb was entirely consumed and can now be removed from
+			 * the ring
+			 */
+			__ptr_ring_discard_one(&peer->tcp.tx_ring);
+			consume_skb(skb);
+		}
+
+		/* give a chance to be rescheduled if needed */
+		cond_resched();
+	}
+}
+
+/* Put packet into TCP TX queue and schedule a consumer */
+void ovpn_queue_tcp_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	int ret;
+
+	ret = ptr_ring_produce_bh(&peer->tcp.tx_ring, skb);
+	if (ret < 0) {
+		kfree_skb_list(skb);
+		return;
+	}
+
+	queue_work(peer->ovpn->events_wq, &peer->tcp.tx_work);
+}
+
+/* Set TCP encapsulation callbacks */
+int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
+{
+	void *old_data;
+	int ret;
+
+	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
+
+	ret = ptr_ring_init(&peer->tcp.tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(peer->ovpn->dev, "cannot allocate TCP TX ring\n");
+		return ret;
+	}
+
+	peer->tcp.skb = NULL;
+	peer->tcp.offset = 0;
+	peer->tcp.data_len = 0;
+
+	write_lock_bh(&sock->sk->sk_callback_lock);
+
+	/* make sure no pre-existing encapsulation handler exists */
+	rcu_read_lock();
+	old_data = rcu_dereference_sk_user_data(sock->sk);
+	rcu_read_unlock();
+	if (old_data) {
+		netdev_err(peer->ovpn->dev,
+			   "provided socket already taken by other user\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* sanity check */
+	if (sock->sk->sk_protocol != IPPROTO_TCP) {
+		netdev_err(peer->ovpn->dev,
+			   "provided socket is UDP but expected TCP\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* only a fully connected socket are expected. Connection should be
+	 * handled in userspace
+	 */
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		netdev_err(peer->ovpn->dev,
+			   "provided TCP socket is not in ESTABLISHED state: %d\n",
+			   sock->sk->sk_state);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* save current CBs so that they can be restored upon socket release */
+	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
+	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
+	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
+
+	/* assign our static CBs */
+	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
+	sock->sk->sk_write_space = ovpn_tcp_write_space;
+	sock->sk->sk_prot = &ovpn_tcp_prot;
+
+	write_unlock_bh(&sock->sk->sk_callback_lock);
+
+	return 0;
+err:
+	write_unlock_bh(&sock->sk->sk_callback_lock);
+	ptr_ring_cleanup(&peer->tcp.tx_ring, NULL);
+
+	return ret;
+}
+
+int __init ovpn_tcp_init(void)
+{
+	/* We need to substitute the recvmsg and the sock_is_readable
+	 * callbacks in the sk_prot member of the sock object for TCP
+	 * sockets.
+	 *
+	 * However sock->sk_prot is a pointer to a static variable and
+	 * therefore we can't directly modify it, otherwise every socket
+	 * pointing to it will be affected.
+	 *
+	 * For this reason we create our own static copy and modify what
+	 * we need. Then we make sk_prot point to this copy
+	 * (in ovpn_tcp_socket_attach())
+	 */
+	ovpn_tcp_prot = tcp_prot;
+	ovpn_tcp_prot.recvmsg = ovpn_tcp_recvmsg;
+	ovpn_tcp_prot.sock_is_readable = ovpn_tcp_sock_is_readable;
+
+	return 0;
+}
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
new file mode 100644
index 000000000000..7e73f6e76e6c
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
+#include <linux/workqueue.h>
+
+#include "peer.h"
+
+/* Initialize TCP static objects */
+int __init ovpn_tcp_init(void);
+
+void ovpn_queue_tcp_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+
+int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer);
+void ovpn_tcp_socket_detach(struct socket *sock);
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
+	ovpn_queue_tcp_skb(peer, skb);
+}
+
+#endif /* _NET_OVPN_TCP_H_ */
-- 
2.43.2


