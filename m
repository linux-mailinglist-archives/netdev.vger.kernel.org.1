Return-Path: <netdev+bounces-77139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0288704E6
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33D71C230CF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C254C3D0;
	Mon,  4 Mar 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PE0tCMlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF245945
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564958; cv=none; b=GNzfMLysaqGNuNkwrSgz2QFI7AKOLb7wus1PuhrcJcys00edd2ZgXbhvqlxoaZy9XdVspmwsrwejgbCgDBUacCAkgUW0j/Z4IueBrGQMdJPrPjYDZh6a6EDnQqeBivu4BQCt/6GPYO1sY4PQlEiu3BbgI+i1xz+qiAGnBTSRQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564958; c=relaxed/simple;
	bh=e7+yWeo7PvU6Wq7MGi1bNvKbPHPubDhtVYGXa/QS6y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ0D3oefpInV7Ce10y0thD0C125kxdq8wfd54CeXDv3TZbwfU5y8JuUuA3vjgTKY371uZot1uHLUsDF0K2f9DaezxuvCM5xJ5DurewDCEKz8Joq8J+q8cZ9W9ljb1moI6P+CIg5udkgsdyNWqwwfozydj8FtIKTO6Wc8+gLnyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PE0tCMlN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4417fa396fso575637666b.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564954; x=1710169754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjwyOpFD10TTisvts9KXsZLA4jgOOYrp/QpiTyYyYpc=;
        b=PE0tCMlNAiHUgc9mBWJsjjP/ossx7uqCzAp0F9HeK/9koIX532QbZHQEn4MkKuy8QG
         +LjhhZcb8qC4/K42eEgphKeJ0V04J7kzbnwzs+A7Bm7nRWt3leyTWb4YO/ZDF6wLXoks
         GuAAnNzfAS2ojyneD45j7wwpFCuW0uex2ad/y7JySgfQvWoU578sC2J037r2cMAEjX5t
         q++BcE4A1boYh99VjQjBfThzF6mQlVIlRbk2hpYCRUjAyDNxhGuIDH/BieQAKhnQ2plF
         Fzrz12+8KTZqkquBltAVICsIJ9rCLBfNwf7Tjmy2J2tBrtxbbmwtYtIZgjhKIQA41AJF
         uTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564954; x=1710169754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjwyOpFD10TTisvts9KXsZLA4jgOOYrp/QpiTyYyYpc=;
        b=tl63pCtv2Vs5Bv4DHUi1E4nixB+TKKsOGxwqKlj/Xnby+Vuwi7MqZH29mGjWsq9qqH
         xvWhKmusmxOWW3HvTUNBLMIB0B6pTwj/ktQ9BkTE3f7jhsAA5ue8nJ+kRGBJmRGitHLc
         nGbC7WXSbDAFfHOw9M5yBLRtpM7y5XcfC/jyuQazLzbGvL0jXNmXsUP1d4bnD57oWdMR
         QasK1vQcrcXaW2VfsfRmmTvrRnkUmfCloqu894mEl8Al3q6ZxBChB8BdRIFP2EnWvMDv
         ti3N4Se6BtrK2sMqIG1AD/OVt+PkqABrp5qh/4Q75T5Bm1ehSs/fJ6Z65wDPVhhujeJQ
         gfwQ==
X-Gm-Message-State: AOJu0Yykq7sRHWUVtvVZtxvboKZRg7GWdr8zYXOWc+R7hF+Wq1xQUS7p
	JvaRHwTVq13Pvlwn+NCbaRDHSBRXA3oQC+6ok6RYlRtPY6LMkvKd1pLycjSBWjOoSCO++SUBqF6
	eB0w=
X-Google-Smtp-Source: AGHT+IFpN/SPOXJ7h+mvil4TVld7dAVz4TGgHu/BmU/F8fasnxjMRhGKeiOEYJS6uT/f4BcRl7KlqA==
X-Received: by 2002:a17:906:eceb:b0:a44:1fa5:285b with SMTP id qt11-20020a170906eceb00b00a441fa5285bmr5331573ejb.72.1709564953700;
        Mon, 04 Mar 2024 07:09:13 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:13 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 12/22] ovpn: implement TCP transport
Date: Mon,  4 Mar 2024 16:09:03 +0100
Message-ID: <20240304150914.11444-13-antonio@openvpn.net>
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

With this changem ovpn is allowed to communicate to peers also via TCP.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |   1 +
 drivers/net/ovpn/io.c     |   5 +
 drivers/net/ovpn/peer.h   |  21 ++
 drivers/net/ovpn/socket.c |  18 ++
 drivers/net/ovpn/socket.h |  14 +-
 drivers/net/ovpn/tcp.c    | 474 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h    |  41 ++++
 7 files changed, 572 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ovpn/tcp.c
 create mode 100644 drivers/net/ovpn/tcp.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 7eaee71bbe9f..336d35a31147 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
 ovpn-y += stats.o
+ovpn-y += tcp.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index e6c99e08cf41..28d05e42cc98 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -14,6 +14,7 @@
 #include "netlink.h"
 #include "peer.h"
 #include "proto.h"
+#include "tcp.h"
 #include "udp.h"
 
 #include <linux/netdevice.h>
@@ -294,6 +295,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 /* Process packets in TX queue in a transport-specific way.
  *
  * UDP transport - encrypt and send across the tunnel.
+ * TCP transport - encrypt and put into TCP TX queue.
  */
 void ovpn_encrypt_work(struct work_struct *work)
 {
@@ -326,6 +328,9 @@ void ovpn_encrypt_work(struct work_struct *work)
 				case IPPROTO_UDP:
 					ovpn_udp_send_skb(peer->ovpn, peer, curr);
 					break;
+				case IPPROTO_TCP:
+					ovpn_tcp_send_skb(peer, curr);
+					break;
 				default:
 					/* no transport configured yet */
 					consume_skb(skb);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 788ec933fc00..1cae726bbbf5 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -44,6 +44,27 @@ struct ovpn_peer {
 
 	struct ovpn_socket *sock;
 
+	/* state of the TCP reading. Needed to keep track of how much of a single packet has already
+	 * been read from the stream and how much is missing
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
+			void (*sk_state_change)(struct sock *sk);
+			void (*sk_data_ready)(struct sock *sk);
+			void (*sk_write_space)(struct sock *sk);
+			struct proto *prot;
+		} sk_cb;
+	} tcp;
+
+
 	struct ovpn_crypto_state crypto;
 
 	struct dst_cache dst_cache;
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 203d04825d88..d0966992bd9d 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -9,8 +9,10 @@
 
 #include "main.h"
 #include "io.h"
+#include "ovpnstruct.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 /* Finalize release of socket, called after RCU grace period */
@@ -21,6 +23,8 @@ static void ovpn_socket_detach(struct socket *sock)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ovpn_udp_socket_detach(sock);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ovpn_tcp_socket_detach(sock);
 
 	sockfd_put(sock);
 }
@@ -63,6 +67,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ret = ovpn_tcp_socket_attach(sock, peer);
 
 	return ret;
 }
@@ -116,6 +122,18 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
 
+	/* TCP sockets are per-peer, therefore they are linked to their unique peer */
+	if (sock->sk->sk_protocol == IPPROTO_TCP) {
+		ovpn_sock->peer = peer;
+		ret = ptr_ring_init(&ovpn_sock->recv_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
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
index 92c50f795f7c..3d6e5414d980 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -23,8 +23,18 @@ struct ovpn_peer;
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  */
 struct ovpn_socket {
-	/* the VPN session object owning this socket (UDP only) */
-	struct ovpn_struct *ovpn;
+	union {
+		/* the VPN session object owning this socket (UDP only) */
+		struct ovpn_struct *ovpn;
+
+		/* TCP only */
+		struct {
+			/** @peer: the unique peer transmitting over this socket (TCP only) */
+			struct ovpn_peer *peer;
+			struct ptr_ring recv_ring;
+		};
+	};
+
 	/* the kernel socket */
 	struct socket *sock;
 	/* amount of contexts currently referencing this object */
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
new file mode 100644
index 000000000000..d810929bc470
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "main.h"
+#include "ovpnstruct.h"
+#include "io.h"
+#include "peer.h"
+#include "proto.h"
+#include "skb.h"
+#include "tcp.h"
+
+#include <linux/ptr_ring.h>
+#include <linux/skbuff.h>
+#include <net/tcp.h>
+#include <net/route.h>
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
+	int status;
+	void *data;
+	u16 len;
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
+		/* no skb allocated means that we have to read (or finish reading) the 2 bytes
+		 * prefix containing the actual packet size.
+		 */
+		if (!peer->tcp.skb) {
+			chunk = min_t(size_t, in_len, sizeof(u16) - peer->tcp.offset);
+			WARN_ON(skb_copy_bits(in_skb, in_offset,
+					      peer->tcp.raw_len + peer->tcp.offset, chunk) < 0);
+			peer->tcp.offset += chunk;
+
+			/* keep on reading until we got the whole packet size */
+			if (peer->tcp.offset != sizeof(u16))
+				goto next_read;
+
+			len = ntohs(*(__be16 *)peer->tcp.raw_len);
+			/* invalid packet length: this is a fatal TCP error */
+			if (!len) {
+				netdev_err(peer->ovpn->dev, "%s: received invalid packet length: %d\n",
+					   __func__, len);
+				desc->error = -EINVAL;
+				goto err;
+			}
+
+			/* add 2 bytes to allocated space (and immediately reserve them) for packet
+			 * length prepending, in case the skb has to be forwarded to userspace
+			 */
+			peer->tcp.skb = netdev_alloc_skb_ip_align(peer->ovpn->dev,
+								  len + sizeof(u16));
+			if (!peer->tcp.skb) {
+				desc->error = -ENOMEM;
+				goto err;
+			}
+			skb_reserve(peer->tcp.skb, sizeof(u16));
+
+			peer->tcp.offset = 0;
+			peer->tcp.data_len = len;
+		} else {
+			chunk = min_t(size_t, in_len, peer->tcp.data_len - peer->tcp.offset);
+
+			/* extend skb to accommodate the new chunk and copy it from the input skb */
+			data = skb_put(peer->tcp.skb, chunk);
+			WARN_ON(skb_copy_bits(in_skb, in_offset, data, chunk) < 0);
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
+			/* At this point we know the packet is from a configured peer.
+			 * DATA_V2 packets are handled in kernel space, the rest goes to user space.
+			 *
+			 * Queue skb for sending to userspace via recvmsg on the socket
+			 */
+			if (likely(ovpn_opcode_from_skb(peer->tcp.skb, 0) == OVPN_DATA_V2)) {
+				/* hold reference to peer as required by ovpn_recv().
+				 *
+				 * NOTE: in this context we should already be holding a
+				 * reference to this peer, therefore ovpn_peer_hold() is
+				 * not expected to fail
+				 */
+				WARN_ON(!ovpn_peer_hold(peer));
+				status = ovpn_recv(peer->ovpn, peer, peer->tcp.skb);
+				if (unlikely(status < 0))
+					ovpn_peer_put(peer);
+
+			} else {
+				/* prepend skb with packet len. this way userspace can parse
+				 * the packet as if it just arrived from the remote endpoint
+				 */
+				void *raw_len = __skb_push(peer->tcp.skb, sizeof(u16));
+
+				memcpy(raw_len, peer->tcp.raw_len, sizeof(u16));
+
+				status = ptr_ring_produce_bh(&peer->sock->recv_ring, peer->tcp.skb);
+				if (likely(!status))
+					peer->tcp.sk_cb.sk_data_ready(sk);
+			}
+
+			/* skb not consumed - free it now */
+			if (unlikely(status < 0))
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
+	netdev_err(peer->ovpn->dev, "cannot process incoming TCP data: %d\n", desc->error);
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
+		sk_wait_event(sk, &timeo, !ptr_ring_empty_bh(&sock->recv_ring), &wait);
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
+			pr_err("ovpn: cannot copy TCP data to userspace: %d\n", ret);
+			kfree_skb(skb);
+			goto unlock;
+		}
+
+		__skb_pull(skb, chunk);
+
+		if (!skb->len) {
+			/* skb was entirely consumed and can now be removed from the ring */
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
+	/* cancel any ongoing work. Done after removing the CBs so that these workers cannot be
+	 * re-armed
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
+	/* initialize iv structure now as skb_linearize() may have changed skb->data */
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
+			net_warn_ratelimited("%s: cannot send TCP packet to peer %u: %d\n", __func__,
+					    peer->id, ret);
+			/* in case of TCP error stop sending loop and delete peer */
+			ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+			break;
+		} else if (!skb->len) {
+			/* skb was entirely consumed and can now be removed from the ring */
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
+		netdev_err(peer->ovpn->dev, "provided socket already taken by other user\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* sanity check */
+	if (sock->sk->sk_protocol != IPPROTO_TCP) {
+		netdev_err(peer->ovpn->dev, "provided socket is UDP but expected TCP\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* only a fully connected socket are expected. Connection should be handled in userspace */
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		netdev_err(peer->ovpn->dev, "provided TCP socket is not in ESTABLISHED state: %d\n",
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
index 000000000000..ef6bfd90ca3a
--- /dev/null
+++ b/drivers/net/ovpn/tcp.h
@@ -0,0 +1,41 @@
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
+#include "peer.h"
+
+#include <linux/net.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
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
+static inline void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	u16 len = skb->len;
+
+	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
+	ovpn_queue_tcp_skb(peer, skb);
+}
+
+#endif /* _NET_OVPN_TCP_H_ */
-- 
2.43.0


