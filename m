Return-Path: <netdev+bounces-128634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8ED97AA25
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FAA1F28E9D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC8762E0;
	Tue, 17 Sep 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IW9uJW9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C004B5C1
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535301; cv=none; b=jA3+PBfhogv9jKVFWMN22SLphxUA5kf/MPs5qjmFmxqt7xokSI4OcSwWzlctukI/90ktEVEQY+Qv1gGicUTMkQzvAB2uuOQTfpoKgDrMhxv7TV90dyE9icT9tdsL8C0I/vxp1r/UmWPvnVTlXA10hlIYgH+uAoR+hEmybRa32WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535301; c=relaxed/simple;
	bh=XQue5hH013GySGTEXC9Nb/WMDZQaonpFs4/Z/Rvckl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUS8lRGIQXWsvT11cl89RpBXGeWZ/47r9w119Mp+yuLzR9WIBdFxqe4+61MH4sprafORv2VvdhYXpP5DFmYaV934jAWr1EfRVIw1tEbUHo/9JfQOtyeTApUCvBMxQ6LlOatdK9yf6M4T7/MmzZia1NMHbJFXmprtjAWUXAYx758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IW9uJW9W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-375e5c12042so2789938f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535297; x=1727140097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3LDN95LJnc5CNkFhAcll2HOHQATA4CvU9kRWgqBRnQ=;
        b=IW9uJW9WrLrhMys7iqcjo7UscO2vu4aEKUBzebUxO4dQzf6WqW/geznvLalWNkNO9n
         TRsA1YY3+EGcqtAkmKa5P9/eyaiyJrn7trrSpnJYRJz/vM3GtUanH8b0g/1A+JcqNpow
         STh1+9u1aSsLQssgJttwoB6KPIUdYeTQ81QRJcG5wk/ZOahAc4wjXHillblC4Nxpm7i7
         Izq1XUUNoazLp5PLwcI5JE8wDSBdSB5cdPYAdLiAItSIhHjjFblqBP9yxrG1DNaQwzb2
         0NfBgLc34hkJS4idI6MZ8O0i3LpYXWm3PL5+jKTis4aiH/4AT4YQ2URGgh39N+QdaHjX
         95hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535297; x=1727140097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3LDN95LJnc5CNkFhAcll2HOHQATA4CvU9kRWgqBRnQ=;
        b=v9np8ambRk1ee5yKtj9x3udzOcZR4AlabzbX+h4U+WFHS9EEeKa2o1Gpuh4+3z1L+9
         lMCGLYItKfEzbeernkgUC5JZ1BDZ05SGiS80TIsC6c65xkVcFIgzsnk0ujPP3uJ8VIog
         o5map13YEFnbu/Y7qv2yI7Lid15p2g0vV4ftBBf+o0g22forTyRqqXgEhsptTkEYZWa+
         ZaB5RBej+LIQOqbz84BCT3Fb4Gz+6nXhP8x7BwCitxCbi+CbJjOXTzHvav3iG3aQvI39
         qk2kF1zWAhr0V3BmfU25dN2QcLL3uzgn1sYEqUGSeUc9aQZPld/eYTLsQb/QJTcPQR8H
         aJUg==
X-Gm-Message-State: AOJu0YxZmLPYKSMQttfri58lK9b5aK10TPZeE7AM2SInOcPf6/akKjHZ
	zu014gXeINC2Nf9vmvZ8tY1+sC6se60amtjixIkw37XGVYF8GFT/fgAAezYBF1wta0vtMsEYdK4
	4
X-Google-Smtp-Source: AGHT+IESrl3h7NemnwCaLmhEOwFvqyqrlVGANz/ibsspk7bjI406jRrKKf2gAuGgLvmPvehObbLWZw==
X-Received: by 2002:adf:9bdc:0:b0:374:bfc4:b62f with SMTP id ffacd0b85a97d-378c2cfec06mr9813318f8f.3.1726535296754;
        Mon, 16 Sep 2024 18:08:16 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:16 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 17/25] ovpn: implement keepalive mechanism
Date: Tue, 17 Sep 2024 03:07:26 +0200
Message-ID: <20240917010734.1905-18-antonio@openvpn.net>
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

OpenVPN supports configuring a periodic keepalive packet.
message to allow the remote endpoint detect link failures.

This change implements the keepalive sending and timer expiring logic.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |  77 ++++++++++++++
 drivers/net/ovpn/io.h         |   5 +
 drivers/net/ovpn/main.c       |   3 +
 drivers/net/ovpn/ovpnstruct.h |   2 +
 drivers/net/ovpn/peer.c       | 188 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  15 +++
 drivers/net/ovpn/proto.h      |   2 -
 7 files changed, 290 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 985f8bba6f13..4e69f31382d2 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -26,6 +26,33 @@
 #include "udp.h"
 #include "skb.h"
 
+const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE] = {
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
+	if (*skb->data != ovpn_keepalive_message[0])
+		return false;
+
+	if (skb->len != OVPN_KEEPALIVE_SIZE)
+		return false;
+
+	if (!pskb_may_pull(skb, OVPN_KEEPALIVE_SIZE))
+		return false;
+
+	return !memcmp(skb->data, ovpn_keepalive_message, OVPN_KEEPALIVE_SIZE);
+}
+
 /* Called after decrypt to write the IP packet to the device.
  * This method is expected to manage/free the skb.
  */
@@ -103,6 +130,9 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* keep track of last received authenticated packet for keepalive */
+	peer->last_recv = ktime_get_real_seconds();
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
@@ -119,6 +149,12 @@ void ovpn_decrypt_post(void *data, int ret)
 			goto drop;
 		}
 
+		if (ovpn_is_keepalive(skb)) {
+			net_dbg_ratelimited("%s: ping received from peer %u\n",
+					    peer->ovpn->dev->name, peer->id);
+			goto drop;
+		}
+
 		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
 				     peer->ovpn->dev->name, peer->id);
 		goto drop;
@@ -217,6 +253,10 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err;
 	}
+
+	/* keep track of last sent packet for keepalive */
+	peer->last_sent = ktime_get_real_seconds();
+
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -355,3 +395,40 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
+void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
+		       const unsigned int len)
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
+	__skb_put_data(skb, data, len);
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
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index ad81dd869246..eb224114152c 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -10,9 +10,14 @@
 #ifndef _NET_OVPN_OVPN_H_
 #define _NET_OVPN_OVPN_H_
 
+#define OVPN_KEEPALIVE_SIZE 16
+extern const unsigned char ovpn_keepalive_message[OVPN_KEEPALIVE_SIZE];
+
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
+void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
+		       const unsigned int len);
 
 void ovpn_encrypt_post(void *data, int ret);
 void ovpn_decrypt_post(void *data, int ret);
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 97cf93f06d8d..e63845658885 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -43,6 +43,7 @@ static void ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
 	ovpn->dev = dev;
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
+	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 }
 
 static void ovpn_struct_free(struct net_device *net)
@@ -242,6 +243,8 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 
 	ovpn->registered = false;
 
+	cancel_delayed_work_sync(&ovpn->keepalive_work);
+
 	switch (ovpn->mode) {
 	case OVPN_MODE_P2P:
 		ovpn_peer_release_p2p(ovpn);
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 66c90682c7f0..6a15c48348f7 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -41,6 +41,7 @@ struct ovpn_peer_collection {
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  * @gro_cells: pointer to the Generic Receive Offload cell
+ * @keepalive_work: struct used to schedule keepalive periodic job
  */
 struct ovpn_struct {
 	struct net_device *dev;
@@ -52,6 +53,7 @@ struct ovpn_struct {
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 	struct gro_cells gro_cells;
+	struct delayed_work keepalive_work;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 93606b3c3001..cbe7b12be132 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -22,6 +22,34 @@
 #include "peer.h"
 #include "socket.h"
 
+/**
+ * ovpn_peer_keepalive_set - configure keepalive values for peer
+ * @peer: the peer to configure
+ * @interval: outgoing keepalive interval
+ * @timeout: incoming keepalive timeout
+ */
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
+{
+	time64_t now = ktime_get_real_seconds();
+
+	netdev_dbg(peer->ovpn->dev,
+		   "%s: scheduling keepalive for peer %u: interval=%u timeout=%u\n",
+		   __func__, peer->id, interval, timeout);
+
+	peer->keepalive_interval = interval;
+	peer->last_sent = now;
+	peer->keepalive_xmit_exp = now + interval;
+
+	peer->keepalive_timeout = timeout;
+	peer->last_recv = now;
+	peer->keepalive_recv_exp = now + timeout;
+
+	/* now that interval and timeout have been changed, kick
+	 * off the worker so that the next delay can be recomputed
+	 */
+	mod_delayed_work(system_wq, &peer->ovpn->keepalive_work, 0);
+}
+
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
  * @ovpn: the openvpn instance inside which the peer should be created
@@ -76,6 +104,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 
 	ovpn_crypto_state_release(&peer->crypto);
 	ovpn_bind_reset(peer, NULL);
+
 	dst_cache_destroy(&peer->dst_cache);
 }
 
@@ -815,6 +844,19 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 	}
 }
 
+static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
+				enum ovpn_del_peer_reason reason)
+{
+	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_del_mp(peer, reason);
+	case OVPN_MODE_P2P:
+		return ovpn_peer_del_p2p(peer, reason);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 /**
  * ovpn_peers_free - free all peers in the instance
  * @ovpn: the instance whose peers should be released
@@ -830,3 +872,149 @@ void ovpn_peers_free(struct ovpn_struct *ovpn)
 		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
 	spin_unlock_bh(&ovpn->peers->lock);
 }
+
+static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
+						time64_t now)
+{
+	time64_t next_run1, next_run2, delta;
+	unsigned long timeout, interval;
+	bool expired;
+
+	spin_lock_bh(&peer->lock);
+	/* we expect both timers to be configured at the same time,
+	 * therefore bail out if either is not set
+	 */
+	if (!peer->keepalive_timeout || !peer->keepalive_interval) {
+		spin_unlock_bh(&peer->lock);
+		return 0;
+	}
+
+	/* check for peer timeout */
+	expired = false;
+	timeout = peer->keepalive_timeout;
+	delta = now - peer->last_recv;
+	if (delta < timeout) {
+		peer->keepalive_recv_exp = now + timeout - delta;
+		next_run1 = peer->keepalive_recv_exp;
+	} else if (peer->keepalive_recv_exp > now) {
+		next_run1 = peer->keepalive_recv_exp;
+	} else {
+		expired = true;
+	}
+
+	if (expired) {
+		/* peer is dead -> kill it and move on */
+		spin_unlock_bh(&peer->lock);
+		netdev_dbg(peer->ovpn->dev, "peer %u expired\n",
+			   peer->id);
+		ovpn_peer_del_nolock(peer, OVPN_DEL_PEER_REASON_EXPIRED);
+		return 0;
+	}
+
+	/* check for peer keepalive */
+	expired = false;
+	interval = peer->keepalive_interval;
+	delta = now - peer->last_sent;
+	if (delta < interval) {
+		peer->keepalive_xmit_exp = now + interval - delta;
+		next_run2 = peer->keepalive_xmit_exp;
+	} else if (peer->keepalive_xmit_exp > now) {
+		next_run2 = peer->keepalive_xmit_exp;
+	} else {
+		expired = true;
+		next_run2 = now + interval;
+	}
+	spin_unlock_bh(&peer->lock);
+
+	if (expired) {
+		/* a keepalive packet is required */
+		netdev_dbg(peer->ovpn->dev,
+			   "sending keepalive to peer %u\n",
+			   peer->id);
+		ovpn_xmit_special(peer, ovpn_keepalive_message,
+				  sizeof(ovpn_keepalive_message));
+	}
+
+	if (next_run1 < next_run2)
+		return next_run1;
+
+	return next_run2;
+}
+
+static time64_t ovpn_peer_keepalive_work_mp(struct ovpn_struct *ovpn,
+					    time64_t now)
+{
+	time64_t tmp_next_run, next_run = 0;
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
+		tmp_next_run = ovpn_peer_keepalive_work_single(peer, now);
+		if (!tmp_next_run)
+			continue;
+
+		/* the next worker run will be scheduled based on the shortest
+		 * required interval across all peers
+		 */
+		if (!next_run || tmp_next_run < next_run)
+			next_run = tmp_next_run;
+	}
+	spin_unlock_bh(&ovpn->peers->lock);
+
+	return next_run;
+}
+
+static time64_t ovpn_peer_keepalive_work_p2p(struct ovpn_struct *ovpn,
+					     time64_t now)
+{
+	struct ovpn_peer *peer;
+	time64_t next_run;
+
+	spin_lock_bh(&ovpn->lock);
+	peer = rcu_dereference_protected(ovpn->peer,
+					 lockdep_is_held(&ovpn->lock));
+	next_run = ovpn_peer_keepalive_work_single(peer, now);
+	spin_unlock_bh(&ovpn->lock);
+
+	return next_run;
+}
+
+/**
+ * ovpn_peer_keepalive_work - run keepalive logic on each known peer
+ * @work: pointer to the work member of the related ovpn object
+ *
+ * Each peer has two timers (if configured):
+ * 1. peer timeout: when no data is received for a certain interval,
+ *    the peer is considered dead and it gets killed.
+ * 2. peer keepalive: when no data is sent to a certain peer for a
+ *    certain interval, a special 'keepalive' packet is explicitly sent.
+ *
+ * This function iterates across the whole peer collection while
+ * checking the timers described above.
+ */
+void ovpn_peer_keepalive_work(struct work_struct *work)
+{
+	struct ovpn_struct *ovpn = container_of(work, struct ovpn_struct,
+						keepalive_work.work);
+	time64_t next_run = 0, now = ktime_get_real_seconds();
+
+	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		next_run = ovpn_peer_keepalive_work_mp(ovpn, now);
+		break;
+	case OVPN_MODE_P2P:
+		next_run = ovpn_peer_keepalive_work_p2p(ovpn, now);
+		break;
+	}
+
+	/* prevent rearming if the interface is being destroyed */
+	if (next_run > 0 && ovpn->registered) {
+		netdev_dbg(ovpn->dev,
+			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
+			   next_run, now, next_run - now);
+		schedule_delayed_work(&ovpn->keepalive_work,
+				      (next_run - now) * HZ);
+	}
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dc51cc93ef20..b632fabf9524 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -50,6 +50,12 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @keepalive_interval: seconds after which a new keepalive should be sent
+ * @keepalive_xmit_exp: future timestamp when next keepalive should be sent
+ * @last_sent: timestamp of the last successfully sent packet
+ * @keepalive_timeout: seconds after which an inactive peer is considered dead
+ * @keepalive_recv_exp: future timestamp when the peer should expire
+ * @last_recv: timestamp of the last authenticated received packet
  * @halt: true if ovpn_peer_mark_delete was called
  * @vpn_stats: per-peer in-VPN TX/RX stays
  * @link_stats: per-peer link/transport TX/RX stats
@@ -98,6 +104,12 @@ struct ovpn_peer {
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
+	unsigned long keepalive_interval;
+	unsigned long keepalive_xmit_exp;
+	time64_t last_sent;
+	unsigned long keepalive_timeout;
+	unsigned long keepalive_recv_exp;
+	time64_t last_recv;
 	bool halt;
 	struct ovpn_peer_stats vpn_stats;
 	struct ovpn_peer_stats link_stats;
@@ -144,4 +156,7 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+void ovpn_peer_keepalive_work(struct work_struct *work);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index 32af6b8e5743..0de8bafadc89 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -35,8 +35,6 @@
 #define OVPN_OP_SIZE_V2	4
 #define OVPN_PEER_ID_MASK 0x00FFFFFF
 #define OVPN_PEER_ID_UNDEF 0x00FFFFFF
-/* first byte of keepalive message */
-#define OVPN_KEEPALIVE_FIRST_BYTE 0x2a
 /* first byte of exit message */
 #define OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE 0x28
 
-- 
2.44.2


