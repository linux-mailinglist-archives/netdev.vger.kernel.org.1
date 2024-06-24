Return-Path: <netdev+bounces-106087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586769148BA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB01C22681
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296EE13B59B;
	Mon, 24 Jun 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XX/yQ3P8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348413C9D3
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228611; cv=none; b=GR5I4FZiSq2HWH/2uvks8qkD2XWFnlypDn4aS6D+T+DF+EfLo5TwlIYII6x4GkyYpl6W3xfDRuEug3+vjgrJuuOZmKED+L8jVn/ThN6/VBB4p7CKMcxFpnQLcNlwXbGdUreMQFqjuXL4L1XbpR1DMHvcZp24R1UvhO2RYb8z4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228611; c=relaxed/simple;
	bh=LPjCvRA14ntjkMW/YXSpbGDxDGdoFuZ7Jocz4rJ6gP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqtZQUWUpgnWtY2dqthnYZwUBUNRnWuyxwp82+2zyXDFluLu/RcvBF1McBTBOK6/CIThDeS0DgQj0IiqFVyoeIeovSeK8wi45WNGDZxsk5/aNTHUnj6jV/vBl0QoruZ73fzQU+qV+wKwE+glJ3V/dQjxiESASg1vzRCK0o9W0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XX/yQ3P8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217926991fso36930855e9.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228607; x=1719833407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyZ0RMHf9/1ljPOjIQla479+x6fOXbjcBcrOsQxWf8o=;
        b=XX/yQ3P8pgBEmiLQXPalRZfIGgeealM//eAMLSHjVbWOqcLDOtjF1k+93TfDzBQjAg
         f0k4wD7b8udFlsJst7xtAHn41sQ/fn4q+91aMo30HuYevtXw8qrjxg/YbmvSvawaoODD
         rCEQ8oKc2G/DgNxuj6IOm/e1GxAvASI/+eJTFTOLwV0V57r1AZEr/z3AfL2HdUQLIKWc
         JWk2jfcaJr6MqrpKAHHv/6PLx5QE5B8gL6i8nc120ee2PnkhTpi3+k9o/QPlZ68+2s8g
         hLOE5PA2Y2t1wqsqVY7QDjJgDRCSA8dtzeq9iMeYSOC90k+NXVqrW5bUqHezOnp/iZ+B
         RXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228607; x=1719833407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyZ0RMHf9/1ljPOjIQla479+x6fOXbjcBcrOsQxWf8o=;
        b=bapwvGS7wuaF5Amhz49YUBDuM/IujTwZ2YIMn2hOJGBoJdxXFphe4oAwyzx2lMGk5U
         e4XVrCbqJy3TF3OYWGl9cAO4MB6a2+hcP9/epTL3jnBMmcAPGsF/NnR/rKb8Lb5A8dR4
         TmEZfD7kLLbVIvRpQvrtZaxiZaT9GzV15ERjKyI4eXN4gSx2IZ8eJj8tkRjVfCZ7y6NP
         sA5wWIQtdxGWSL46H9P3vlKJqYvnQbcoDtOUfbYj9cNLebY+zc9ua/GXBFDEJIDsGleb
         ikQH/r/1qP2TWuNLk2cRiXZ/GgViCfphqX4yOjIooWUeCEa7CdmAFxUG1J32heQbbfZQ
         fz7w==
X-Gm-Message-State: AOJu0Yza1d77L1/jZMdNOaXQu0wYLIB43Y6kIMxXSZ0kty1JW9MG2OGP
	bRYoLcarCVVmCMYYHA6gw6eBcH9pBm5uBhpQkeo4zf5C9bzdkMEgu2mSx9xijCmS505Tq9h4jLF
	/
X-Google-Smtp-Source: AGHT+IELxgA3Q7w0vl3PVnovdYYQiScjuomI4yBxoIvc52BS+I9yASEs80bzKjCVS+sma3bP1ifMtw==
X-Received: by 2002:a5d:5f48:0:b0:366:e8e4:599f with SMTP id ffacd0b85a97d-366e8e45a4amr3547017f8f.7.1719228607136;
        Mon, 24 Jun 2024 04:30:07 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:06 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 17/25] ovpn: implement keepalive mechanism
Date: Mon, 24 Jun 2024 13:31:14 +0200
Message-ID: <20240624113122.12732-18-antonio@openvpn.net>
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

OpenVPN supports configuring a periodic keepalive "ping"
message to allow the remote endpoint detect link failures.

This change implements the ping sending and timer expiring logic.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 82 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/io.h   |  1 +
 drivers/net/ovpn/peer.c | 72 ++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h | 45 ++++++++++++++++++++++
 4 files changed, 200 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 764b3df996bc..dedc4d4a1c72 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -25,6 +25,31 @@
 #include "udp.h"
 #include "skb.h"
 
+static const unsigned char ovpn_keepalive_message[] = {
+	0x2a, 0x18, 0x7b, 0xf3, 0x64, 0x1e, 0xb4, 0xcb,
+	0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
+};
+
+/**
+ * ovpn_is_keepalive - check if skb contains a keepalive message
+ * @skb: packet to check
+ *
+ * Assumes that the first byte of skb->data is defined.
+ *
+ * Return: true if skb contains a keepalive or false otherwise
+ */
+static bool ovpn_is_keepalive(struct sk_buff *skb)
+{
+	if (*skb->data != OVPN_KEEPALIVE_FIRST_BYTE)
+		return false;
+
+	if (!pskb_may_pull(skb, sizeof(ovpn_keepalive_message)))
+		return false;
+
+	return !memcmp(skb->data, ovpn_keepalive_message,
+		       sizeof(ovpn_keepalive_message));
+}
+
 /* Called after decrypt to write the IP packet to the device.
  * This method is expected to manage/free the skb.
  */
@@ -91,6 +116,9 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
 		goto drop;
 	}
 
+	/* note event of authenticated packet received for keepalive */
+	ovpn_peer_keepalive_recv_reset(peer);
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, ovpn_skb_cb(skb)->payload_offset);
 
@@ -107,6 +135,12 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
 			goto drop;
 		}
 
+		if (ovpn_is_keepalive(skb)) {
+			netdev_dbg(peer->ovpn->dev,
+				   "ping received from peer %u\n", peer->id);
+			goto drop;
+		}
+
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     peer->ovpn->dev->name, peer->id);
 		goto drop;
@@ -203,6 +237,7 @@ void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 		/* no transport configured yet */
 		goto err;
 	}
+	ovpn_peer_keepalive_xmit_reset(peer);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -345,3 +380,50 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
+
+/**
+ * ovpn_xmit_special - encrypt and transmit an out-of-band message to peer
+ * @peer: peer to send the message to
+ * @data: message content
+ * @len: message length
+ *
+ * Assumes that caller holds a reference to peer
+ */
+static void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
+			      const unsigned int len)
+{
+	struct ovpn_struct *ovpn;
+	struct sk_buff *skb;
+
+	ovpn = peer->ovpn;
+	if (unlikely(!ovpn))
+		return;
+
+	skb = alloc_skb(256 + len, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return;
+
+	skb_reserve(skb, 128);
+	skb->priority = TC_PRIO_BESTEFFORT;
+	memcpy(__skb_put(skb, len), data, len);
+
+	/* increase reference counter when passing peer to sending queue */
+	if (!ovpn_peer_hold(peer)) {
+		netdev_dbg(ovpn->dev, "%s: cannot hold peer reference for sending special packet\n",
+			   __func__);
+		kfree_skb(skb);
+		return;
+	}
+
+	ovpn_send(ovpn, skb, peer);
+}
+
+/**
+ * ovpn_keepalive_xmit - send keepalive message to peer
+ * @peer: the peer to send the message to
+ */
+void ovpn_keepalive_xmit(struct ovpn_peer *peer)
+{
+	ovpn_xmit_special(peer, ovpn_keepalive_message,
+			  sizeof(ovpn_keepalive_message));
+}
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index ad741552d742..63fcd576ddaf 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -13,6 +13,7 @@
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
+void ovpn_keepalive_xmit(struct ovpn_peer *peer);
 
 void ovpn_encrypt_post(struct sk_buff *skb, int ret);
 void ovpn_decrypt_post(struct sk_buff *skb, int ret);
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 8c23268db916..289fe3f84ed4 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -22,6 +22,63 @@
 #include "peer.h"
 #include "socket.h"
 
+/**
+ * ovpn_peer_ping - timer task for sending periodic keepalive
+ * @t: timer object that triggered the task
+ */
+static void ovpn_peer_ping(struct timer_list *t)
+{
+	struct ovpn_peer *peer = from_timer(peer, t, keepalive_xmit);
+
+	netdev_dbg(peer->ovpn->dev, "%s: sending ping to peer %u\n", __func__,
+		   peer->id);
+	ovpn_keepalive_xmit(peer);
+}
+
+/**
+ * ovpn_peer_expire - timer task for incoming keepialive timeout
+ * @t: the timer that triggered the task
+ */
+static void ovpn_peer_expire(struct timer_list *t)
+{
+	struct ovpn_peer *peer = from_timer(peer, t, keepalive_recv);
+
+	netdev_dbg(peer->ovpn->dev, "%s: peer %u expired\n", __func__,
+		   peer->id);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_EXPIRED);
+}
+
+/**
+ * ovpn_peer_keepalive_set - configure keepalive values for peer
+ * @peer: the peer to configure
+ * @interval: outgoing keepalive interval
+ * @timeout: incoming keepalive timeout
+ */
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
+{
+	u32 delta;
+
+	netdev_dbg(peer->ovpn->dev,
+		   "%s: scheduling keepalive for peer %u: interval=%u timeout=%u\n",
+		   __func__, peer->id, interval, timeout);
+
+	peer->keepalive_interval = interval;
+	if (interval > 0) {
+		delta = msecs_to_jiffies(interval * MSEC_PER_SEC);
+		mod_timer(&peer->keepalive_xmit, jiffies + delta);
+	} else {
+		timer_delete(&peer->keepalive_xmit);
+	}
+
+	peer->keepalive_timeout = timeout;
+	if (timeout) {
+		delta = msecs_to_jiffies(timeout * MSEC_PER_SEC);
+		mod_timer(&peer->keepalive_recv, jiffies + delta);
+	} else {
+		timer_delete(&peer->keepalive_recv);
+	}
+}
+
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
  * @ovpn: the openvpn instance inside which the peer should be created
@@ -63,9 +120,22 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 
 	netdev_hold(ovpn->dev, NULL, GFP_KERNEL);
 
+	timer_setup(&peer->keepalive_xmit, ovpn_peer_ping, 0);
+	timer_setup(&peer->keepalive_recv, ovpn_peer_expire, 0);
+
 	return peer;
 }
 
+/**
+ * ovpn_peer_timer_delete_all - killall keepalive timers
+ * @peer: peer for which timers should be killed
+ */
+static void ovpn_peer_timer_delete_all(struct ovpn_peer *peer)
+{
+	timer_shutdown_sync(&peer->keepalive_xmit);
+	timer_shutdown_sync(&peer->keepalive_recv);
+}
+
 /**
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
@@ -77,6 +147,8 @@ static void ovpn_peer_release(struct ovpn_peer *peer)
 
 	ovpn_crypto_state_release(&peer->crypto);
 	ovpn_bind_reset(peer, NULL);
+	ovpn_peer_timer_delete_all(peer);
+
 	dst_cache_destroy(&peer->dst_cache);
 }
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 6e92e09a3504..fd7e9d57b38a 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -50,6 +50,10 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @keepalive_xmit: timer used to send the next keepalive
+ * @keepalive_interval: seconds after which a new keepalive should be sent
+ * @keepalive_recv: timer used to check for received keepalives
+ * @keepalive_timeout: seconds after which an inactive peer is considered dead
  * @halt: true if ovpn_peer_mark_delete was called
  * @vpn_stats: per-peer in-VPN TX/RX stays
  * @link_stats: per-peer link/transport TX/RX stats
@@ -98,6 +102,10 @@ struct ovpn_peer {
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
+	struct timer_list keepalive_xmit;
+	unsigned long keepalive_interval;
+	struct timer_list keepalive_recv;
+	unsigned long keepalive_timeout;
 	bool halt;
 	struct ovpn_peer_stats vpn_stats;
 	struct ovpn_peer_stats link_stats;
@@ -144,4 +152,41 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
+/**
+ * ovpn_peer_keepalive_recv_reset - reset keepalive timeout
+ * @peer: peer for which the timeout should be reset
+ *
+ * To be invoked upon reception of an authenticated packet from peer in order
+ * to report valid activity and thus reset the keepalive timeout
+ */
+static inline void ovpn_peer_keepalive_recv_reset(struct ovpn_peer *peer)
+{
+	u32 delta = msecs_to_jiffies(peer->keepalive_timeout * MSEC_PER_SEC);
+
+	if (unlikely(!delta))
+		return;
+
+	mod_timer(&peer->keepalive_recv, jiffies + delta);
+}
+
+/**
+ * ovpn_peer_keepalive_xmit_reset - reset keepalive sending timer
+ * @peer: peer for which the timer should be reset
+ *
+ * To be invoked upon sending of an authenticated packet to peer in order
+ * to report valid outgoing activity and thus reset the keepalive sending
+ * timer
+ */
+static inline void ovpn_peer_keepalive_xmit_reset(struct ovpn_peer *peer)
+{
+	u32 delta = msecs_to_jiffies(peer->keepalive_interval * MSEC_PER_SEC);
+
+	if (unlikely(!delta))
+		return;
+
+	mod_timer(&peer->keepalive_xmit, jiffies + delta);
+}
+
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


