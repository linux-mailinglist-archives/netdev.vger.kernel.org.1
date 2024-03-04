Return-Path: <netdev+bounces-77142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85388704E9
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0838A1C22563
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ECA4CB3D;
	Mon,  4 Mar 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bB3KHeJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99D4C62A
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564961; cv=none; b=tP3clo23XLrhof2dg1w+qzWKBMcMQs1BkLdlq42wuDVTctakDtn4XXR1ksCRAnMU8OZvXF1s9fGNB89wAwym6of30VXTG8/dCmen2RRlNCztJRNEB70UiBQ8riVNs5m3DrXZtUyHOReHLoZLT6DEwfXwu/VIpx2TAYbzMoVUSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564961; c=relaxed/simple;
	bh=G/Wem6xV3DiwITlagYJGqdLPexJ0Dud3h++2GQjnPv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiACa+mM3bdziPykQNpLMcyJD3BEaPiFYctLvmeK14BrwUfXxC/2WqMk01PXzeDmM3IMoUMOgZzxzAmtXygANYr4CDutqr1LRVRcr+k2dUsXYGGiM9ygT8BNTZZj8sgiP1V1NGwYXPzYPazdKrvPplhhSKCqGOAoZlEQwKHOy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bB3KHeJ1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51340e89df1so1673353e87.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564958; x=1710169758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCL8kuz/4saVQgwb/wh+TnYvmQFleEiRFa5sKtxEQ9s=;
        b=bB3KHeJ1QesS+01wodHbug4j98IAQczHWpFCb9GAz5e4W1nCrlJKBelmgPzcfGdZXH
         u/s1hFXoDeVLDkfvOZ4vpD/q4gEj4AOh4INGNzd81qfslFPszEWHT/WIwInBUYPRDksD
         UoFYwOC/vU8qwlhFFOfYz0wgVBaRuW4u79B0EMa3hfQ5hjqDZEfgz/UMSS3cTqMLPOj3
         gBlB3jjhbI2aI44/LnMyTcWU82yMA5FN0MRc6ijgK+MzKTGwq6Vj4BlTxbINcsqPRBj2
         AlOrPsRXanZg6tua3SySys+gYadJAnn+fAbciZJM0DgphbLv+UHysJJKY/Pz/TW2gpTO
         LFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564958; x=1710169758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCL8kuz/4saVQgwb/wh+TnYvmQFleEiRFa5sKtxEQ9s=;
        b=pECj44eXjCc+whKmmaO6Q0PquocsoYrJJjF00ZDkPdw7OEibM1OB5uMQkZ2V+1rzI5
         gW8SQ6VfPUb0ckGEN+h024NBzNWj6hH1s2xORV0KuGvSO8KA1cFdWyJfN7VW+JCFWgM5
         uSBVsOl1V7Slp4sJb9wvou6qG2Aiw68QPVKbUK4ehdWQ2vM4vJUYM/srKc+qJZ9piEHg
         uMQ0HxXRfDLjoVwljs2+qHThzgOYhr1VQ5MXF5DG7rZU4yY0W+RKN9TAjF5KLrqEjNkv
         fZTlYAtDhJVYONp2BLGc08iKXVX7BAiV95WRdNvm4msCz/oDq7zl+gxlqYP94il01ES7
         yDwQ==
X-Gm-Message-State: AOJu0YxV6d6N1gl1W6xjWgevRRhG4M9OeF10iYcLUyqLE4YBjovqk6D5
	GB9vIjLTpgRISrPAAgp5I75gSbDV07gs9F7ocMprNrKkxxCcgq9dz0E8ZOEj3xxw0Zg0F0t9r6l
	J
X-Google-Smtp-Source: AGHT+IFt/9v2aFFbc3AbhTd+1JcQZLalkMEDf2ckG07gh9X74sg9qhreEAO/Xc1DE/lqnkq8xw5vDA==
X-Received: by 2002:a05:6512:3488:b0:512:da79:91a with SMTP id v8-20020a056512348800b00512da79091amr5445778lfr.46.1709564957724;
        Mon, 04 Mar 2024 07:09:17 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:17 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 15/22] ovpn: implement keepalive mechanism
Date: Mon,  4 Mar 2024 16:09:06 +0100
Message-ID: <20240304150914.11444-16-antonio@openvpn.net>
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

OpenVPN supports configuring a periodic keepalive "ping"
message to allow the remote endpoint detect link failures.

This change implements the ping sending and timer expiring logic.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 76 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/io.h   |  1 +
 drivers/net/ovpn/peer.c | 52 ++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h | 36 +++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 91706c55784d..d070e2fd642f 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -22,6 +22,26 @@
 #include <net/gso.h>
 
 
+static const unsigned char ovpn_keepalive_message[] = {
+	0x2a, 0x18, 0x7b, 0xf3, 0x64, 0x1e, 0xb4, 0xcb,
+	0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
+};
+
+/* Is keepalive message?
+ * Assumes that the first byte of skb->data is defined.
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
@@ -186,6 +206,9 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 		goto drop;
 	}
 
+	/* note event of authenticated packet received for keepalive */
+	ovpn_peer_keepalive_recv_reset(peer);
+
 	/* increment RX stats */
 	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
 
@@ -203,6 +226,17 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 			goto drop;
 		}
 
+		/* check if special OpenVPN message */
+		if (ovpn_is_keepalive(skb)) {
+			netdev_dbg(peer->ovpn->dev, "ping received from peero %u\n", peer->id);
+			/* not an error */
+			consume_skb(skb);
+			/* inform the caller that NAPI should not be scheduled
+			 * for this packet
+			 */
+			return -1;
+		}
+
 		netdev_dbg(peer->ovpn->dev, "unsupported protocol received from peer %u\n",
 			   peer->id);
 
@@ -338,6 +372,9 @@ void ovpn_encrypt_work(struct work_struct *work)
 					break;
 				}
 			}
+
+			/* note event of authenticated packet xmit for keepalive */
+			ovpn_peer_keepalive_xmit_reset(peer);
 		}
 
 		/* give a chance to be rescheduled if needed */
@@ -437,3 +474,42 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
+
+/* Encrypt and transmit a special message to peer, such as keepalive
+ * or explicit-exit-notify.  Called from softirq context.
+ * Assumes that caller holds a reference to peer.
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
index dee121a36dd7..8e708857ec74 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -19,6 +19,7 @@ struct ovpn_struct;
 int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 int ovpn_napi_poll(struct napi_struct *napi, int budget);
+void ovpn_keepalive_xmit(struct ovpn_peer *peer);
 
 int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer, struct sk_buff *skb);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index acef27b1ca5d..58ea72557d89 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -23,6 +23,48 @@
 #include <linux/workqueue.h>
 
 
+static void ovpn_peer_ping(struct timer_list *t)
+{
+	struct ovpn_peer *peer = from_timer(peer, t, keepalive_xmit);
+
+	netdev_dbg(peer->ovpn->dev, "%s: sending ping to peer %u\n", __func__, peer->id);
+	ovpn_keepalive_xmit(peer);
+}
+
+static void ovpn_peer_expire(struct timer_list *t)
+{
+	struct ovpn_peer *peer = from_timer(peer, t, keepalive_recv);
+
+	netdev_dbg(peer->ovpn->dev, "%s: peer %u expired\n", __func__, peer->id);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_EXPIRED);
+}
+
+/* Configure keepalive parameters */
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
+{
+	u32 delta;
+
+	netdev_dbg(peer->ovpn->dev,
+		   "%s: scheduling keepalive for peer %u: interval=%u timeout=%u\n", __func__,
+		   peer->id, interval, timeout);
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
 /* Construct a new peer */
 struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 {
@@ -82,6 +124,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 
 	dev_hold(ovpn->dev);
 
+	timer_setup(&peer->keepalive_xmit, ovpn_peer_ping, 0);
+	timer_setup(&peer->keepalive_recv, ovpn_peer_expire, 0);
+
 	return peer;
 err_rx_ring:
 	ptr_ring_cleanup(&peer->rx_ring, NULL);
@@ -97,9 +142,16 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 #define ovpn_peer_index(_tbl, _key, _key_len)		\
 	(jhash(_key, _key_len, 0) % HASH_SIZE(_tbl))	\
 
+static void ovpn_peer_timer_delete_all(struct ovpn_peer *peer)
+{
+	del_timer_sync(&peer->keepalive_xmit);
+	del_timer_sync(&peer->keepalive_recv);
+}
+
 static void ovpn_peer_free(struct ovpn_peer *peer)
 {
 	ovpn_bind_reset(peer, NULL);
+	ovpn_peer_timer_delete_all(peer);
 
 	WARN_ON(!__ptr_ring_empty(&peer->tx_ring));
 	ptr_ring_cleanup(&peer->tx_ring, NULL);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 72bbe8ffd252..9e5ff9ee1c92 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -77,6 +77,20 @@ struct ovpn_peer {
 	/* our binding to peer, protected by spinlock */
 	struct ovpn_bind __rcu *bind;
 
+	/* timer used to send periodic ping messages to the other peer, if no
+	 * other data was sent within the past keepalive_interval seconds
+	 */
+	struct timer_list keepalive_xmit;
+	/* keepalive interval in seconds */
+	unsigned long keepalive_interval;
+
+	/* timer used to mark a peer as expired when no data is received for
+	 * keepalive_timeout seconds
+	 */
+	struct timer_list keepalive_recv;
+	/* keepalive timeout in seconds */
+	unsigned long keepalive_timeout;
+
 	/* true if ovpn_peer_mark_delete was called */
 	bool halt;
 
@@ -117,8 +131,30 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 	kref_put(&peer->refcount, ovpn_peer_release_kref);
 }
 
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
 struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
 
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
 struct ovpn_peer *ovpn_peer_find(struct ovpn_struct *ovpn, u32 peer_id);
-- 
2.43.0


