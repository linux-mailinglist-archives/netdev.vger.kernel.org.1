Return-Path: <netdev+bounces-93572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A88BC554
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E863F1F21105
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98094481A7;
	Mon,  6 May 2024 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CK0rcAmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBC47F53
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958156; cv=none; b=EzidVq5J1bLNB3CmDAymlvTYDAQzcbg+vYIvoYAOVi5qAMV7o0Gv1dYRXzXB3DJyy38b5Pyfu+4cwQ+I23A/Fz1vor2BhUH/inMjXjs4GQahooKGSWmPFVd4QA7GEiV78SaG7HcYCrHInOEebvEMDIhSF6QUHB5OKSdecb3Vt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958156; c=relaxed/simple;
	bh=U5BX8p+bSPJQDLm+QTkjlH51J8XMityvZCPER1GRiKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aalEL6rM7Fb074Zu4+CVYqKUuBWQSSyqgZOvqYhhXIxUlY3K9SEA5edcmt8gerxgV48acZaNDv2bx2fwgdbhjGIJbV+GL6tH651sLIPRII1KJj1l2bJLZJK38v/M/EcfZPoWVutRUkp1RzfWc6gbMEayIZ8izw0C1k91AN/wkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CK0rcAmx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so722409f8f.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958152; x=1715562952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu4/f577hKikHig5xVNi3bkbBMJ2G5AH7KXkEi2IshI=;
        b=CK0rcAmxLD88Tbafgk+EimURGIiFZggzsYpKq8023Tc6gpBvUIFVMSkqSgYo1LqM7d
         1TViRG0IjoE7osXNG0DCIZ1FGitwfi24TJEhl24ue1tHAT2wLubTzNBEpZvIn0zH6Ey2
         4saBhQqNnC7+pvBTuql/DUiPimar9BijuyLvh2PYRzLrbEAEYqtWRpJYoCzS9cBiHmdf
         oBcn3MdooqxsE66S1UNsBExeqPSkp6DXRkJEwgEUdoQPFTlDDtNrrcqeYmo+pj1jNw3J
         S61ZGEGD1k2f+14jSpjKntgkZTbaN2p9KumjW7KkJ0CC73GgX4uT6pvWkUkQkDQTDL4t
         106Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958152; x=1715562952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu4/f577hKikHig5xVNi3bkbBMJ2G5AH7KXkEi2IshI=;
        b=OWjO80Uey0UlwnFS0ZmIxY1OeOBdEhxu+NBaNw+1VJiLYXO5244qC+lwT3lgDcDFwR
         x7C6kG+HdKVDSr/Z2zQ8RG+WIUJ3PaWcUpTCiTuSw1U+npLdF1KNfhMQKKetbg9ujwRI
         Hc/+YQEjG2fhRERZA2abTriKwWMvARSGLRLOJLCwzZRc5bDqtfzeOsMIBlgtoTvVvvAV
         DpRnMQTsEa0qTiCGSxb7pKcNnboE1XajrVk1bohDh2NnbckxfLj10xsxVIzBmpbrrrBV
         NLAFLCnOICUUf/jZqvAuOmHixcwGjDYD7S3N6uwdQVjs7TzDpbJkBBkw8qPYVdMel1ov
         6xSg==
X-Gm-Message-State: AOJu0YzauGC8eRAobRK06Z/7NzzVAprR3jA8TvS+zhtSyAdjfv7Q/3V2
	Jxe1r9YzjuHvvN9JGvVAOYZVTIkKBBLGjOAgkKT8dz0/9JU/uKaoKH6ol3FjC/U/oTatdExGNdU
	s
X-Google-Smtp-Source: AGHT+IEQCpFstjqI2e2TS+zdHktmobWq5aaJbKQB4ZEk2mbn1Nd0ty7zTxhthm9WXb7DH6P2NxEkzQ==
X-Received: by 2002:a05:6000:186:b0:34c:600b:b016 with SMTP id p6-20020a056000018600b0034c600bb016mr8089290wrx.27.1714958152432;
        Sun, 05 May 2024 18:15:52 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:52 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 16/24] ovpn: implement keepalive mechanism
Date: Mon,  6 May 2024 03:16:29 +0200
Message-ID: <20240506011637.27272-17-antonio@openvpn.net>
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

OpenVPN supports configuring a periodic keepalive "ping"
message to allow the remote endpoint detect link failures.

This change implements the ping sending and timer expiring logic.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 88 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/io.h   |  6 +++
 drivers/net/ovpn/peer.c | 65 ++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h | 51 ++++++++++++++++++++++++
 4 files changed, 210 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 8ccf2700a370..2469e30970b7 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -24,6 +24,31 @@
 #include "tcp.h"
 #include "udp.h"
 
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
 int ovpn_struct_init(struct net_device *dev)
 {
 	struct ovpn_struct *ovpn = netdev_priv(dev);
@@ -190,6 +215,9 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 		goto drop;
 	}
 
+	/* note event of authenticated packet received for keepalive */
+	ovpn_peer_keepalive_recv_reset(peer);
+
 	/* increment RX stats */
 	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
 
@@ -208,6 +236,18 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 			goto drop;
 		}
 
+		/* check if special OpenVPN message */
+		if (ovpn_is_keepalive(skb)) {
+			netdev_dbg(peer->ovpn->dev,
+				   "ping received from peer %u\n", peer->id);
+			/* not an error */
+			consume_skb(skb);
+			/* inform the caller that NAPI should not be scheduled
+			 * for this packet
+			 */
+			return -1;
+		}
+
 		netdev_dbg(peer->ovpn->dev,
 			   "unsupported protocol received from peer %u\n",
 			   peer->id);
@@ -352,6 +392,11 @@ void ovpn_encrypt_work(struct work_struct *work)
 					break;
 				}
 			}
+
+			/* note event of authenticated packet xmit for
+			 * keepalive
+			 */
+			ovpn_peer_keepalive_xmit_reset(peer);
 		}
 
 		/* give a chance to be rescheduled if needed */
@@ -456,3 +501,46 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
+	ovpn_queue_skb(ovpn, skb, peer);
+}
+
+void ovpn_keepalive_xmit(struct ovpn_peer *peer)
+{
+	ovpn_xmit_special(peer, ovpn_keepalive_message,
+			  sizeof(ovpn_keepalive_message));
+}
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 63d549c8c53b..e11bfa0d3e43 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -20,6 +20,12 @@ int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 int ovpn_napi_poll(struct napi_struct *napi, int budget);
 
+/**
+ * ovpn_keepalive_xmit - send keepalive message to peer
+ * @peer: the peer to send the message to
+ */
+void ovpn_keepalive_xmit(struct ovpn_peer *peer);
+
 int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
 	      struct sk_buff *skb);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 31d7fb718b6b..79a6d6fb1be1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -23,6 +23,57 @@
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
+		del_timer(&peer->keepalive_xmit);
+	}
+
+	peer->keepalive_timeout = timeout;
+	if (timeout) {
+		delta = msecs_to_jiffies(timeout * MSEC_PER_SEC);
+		mod_timer(&peer->keepalive_recv, jiffies + delta);
+	} else {
+		del_timer(&peer->keepalive_recv);
+	}
+}
+
 struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 {
 	struct ovpn_peer *peer;
@@ -85,6 +136,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 
 	dev_hold(ovpn->dev);
 
+	timer_setup(&peer->keepalive_xmit, ovpn_peer_ping, 0);
+	timer_setup(&peer->keepalive_recv, ovpn_peer_expire, 0);
+
 	return peer;
 err_rx_ring:
 	ptr_ring_cleanup(&peer->rx_ring, NULL);
@@ -100,6 +154,16 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 #define ovpn_peer_index(_tbl, _key, _key_len)		\
 	(jhash(_key, _key_len, 0) % HASH_SIZE(_tbl))	\
 
+/**
+ * ovpn_peer_timer_delete_all - killall keepalive timers
+ * @peer: peer for which timers should be killed
+ */
+static void ovpn_peer_timer_delete_all(struct ovpn_peer *peer)
+{
+	del_timer_sync(&peer->keepalive_xmit);
+	del_timer_sync(&peer->keepalive_recv);
+}
+
 /**
  * ovpn_peer_free - release private members and free peer object
  * @peer: the peer to free
@@ -107,6 +171,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 static void ovpn_peer_free(struct ovpn_peer *peer)
 {
 	ovpn_bind_reset(peer, NULL);
+	ovpn_peer_timer_delete_all(peer);
 
 	WARN_ON(!__ptr_ring_empty(&peer->tx_ring));
 	ptr_ring_cleanup(&peer->tx_ring, NULL);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 10f4153f7c8f..d5b63c07408e 100644
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
@@ -99,6 +103,10 @@ struct ovpn_peer {
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
@@ -222,4 +230,47 @@ struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
  */
 void ovpn_peers_free(struct ovpn_struct *ovpn);
 
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
+/**
+ * ovpn_peer_keepalive_set - configure keepalive values for peer
+ * @peer: the peer to configure
+ * @interval: outgoing keepalive interval
+ * @timeout: incoming keepalive timeout
+ */
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.43.2


