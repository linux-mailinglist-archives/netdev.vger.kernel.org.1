Return-Path: <netdev+bounces-171444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48312A4D011
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8923AD91A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377EA1D7E4A;
	Tue,  4 Mar 2025 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y0o+R6Ee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B2149C64
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048485; cv=none; b=kjILul+bmTJrkJc5Pr0FUgBdqNjw77VwhFNrowcgow0URA1o+EHfOhM9tzsOqHx6E0eK1a/5MnBHAOUgnXHuWiNL8nPAz1Wf8aQyU0DMpi2F3OV41rO7FWblpx8fjQ05apnBh3+v2YvsPyO3ICNgyhnoOIcWi8ahMRuHiEDjb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048485; c=relaxed/simple;
	bh=+ZmD4VX//jFIsZuykYdyBglH3ygRLBdrH09T/8XlLso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDLOkLVLZFfNRcVvGUE+yfxZMfkpagzYNMUOgi1VIrl3C0Tc5aofgTKAfZlpI3M8kSRXR9rAY0ttdVImtv88PfdjWL6IpEkigoDY90+QTrhOfZwhWh+Y7nUuSdu+2T+ZPsxxAYFszTQtetjwqgFDSnHmhVc6Z0YS0ifqLzj9ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y0o+R6Ee; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f406e9f80so3805113f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048480; x=1741653280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfXZPWN2BMRNGYT4Hc1WtPAybMctluarzmxD+uZ+FMk=;
        b=Y0o+R6EeselDkGqVt0s13+wl8sffj2kKg2KxtjpdxlKxMq8+bXMt9qTrh5yHFiRvUD
         S2arOD9u00mGh7ZkM1lE7vmgT6nwZOQCVo2jbcYkefy0+3zcOACIOagjbcUSHrM185io
         opixxRPPZuNiNDWN8NfzAxmlvjIdbCF2NUAN+RAO8Vjjmb1kZ6uur4ieL498rVCFA5mt
         K4J+5k90SKEF1QuVrxe9zet5e8QqYYi5Z1WPPAsIJIGgl2mq4gcF4ih+zU4AQZzOiQh1
         fEIpmxuswI1yHEFkCnlqPlTtAInUnxDel0tl6Oz4+9CMF2NH+0dgRQBUpqdGljUWOMK9
         nMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048480; x=1741653280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfXZPWN2BMRNGYT4Hc1WtPAybMctluarzmxD+uZ+FMk=;
        b=EJDs83x8zttCgoobIzY1CEIJYbLVk0e+NhXTD03LlGuQggdEZWPcxQvr4+ZrbtpnTN
         seNnWryTZCkfBaRla0L5z21mzKEa/N1qp9ABtPRi//UfjnBZIBeKwXrMMElzldwBxBrG
         0gSSwmRK/vY+4WjwIGgm9lK4pH0nujFlBfwdxk7zXOgtKQVZh2RlOi1cTQHHrvkDSNjS
         /e06XtOw47Q4EQMDfnvYNmzPqweWNimIuS6vJQ4siVRBqosq7IRgMX5Xiob0o10xJCTI
         NugP+xMLGJWcEuQCQJmN/yZuyAjeagmDwQRkKKE5WZ+goHXCuDqTbGCvMaAxOdq2o2pF
         CDCg==
X-Gm-Message-State: AOJu0YzGziFlbPWkuu+/ptD1+iZb6ZCHB3LvP10XlyvK3XjYSougjDmK
	XKo/IUoES4gvakU1xQzRAG2pHo8d/aRmOQu4iLgMUcN4/crugGovtmTXaBL9o8o=
X-Gm-Gg: ASbGncugPWAIxbwyxD+8MUX1afGkXav7kWnMWJd4eGLTckiln41TVBmDXJVtgJa9xW6
	JlqMPo7lGRCC8dRAeZR9vcs9KD89Obb2yIO6PdZLJHWU/nOn7hY/KaR9ASre007lR3Tr6G9l7ir
	qZM94oSJ3d6uonG35BFyIskot+lMOau/iuv4HZZqt+Qhwn1HHmsW8jldrB0JayENN27hGS/G++3
	i8zbIP1knm7GMKimoSdYS4G3es7vfvt4XLiQjS1NoR/I5hPLzdWW8U3/LQqgEb7A1izdfaiMjhe
	eIL7CDhn4fDiQakjAwXCmev/AoK7aw04Exkq9iJSxQ==
X-Google-Smtp-Source: AGHT+IEZPCb4CyzrMl4QLp51ZU/oWvKBS+3ccYM1Q86+nrpCpxba1quh/TPKsZlXp+uka0X3a5Ge5w==
X-Received: by 2002:a05:6000:178c:b0:38f:4fa6:68df with SMTP id ffacd0b85a97d-390eca80576mr11869229f8f.51.1741048480505;
        Mon, 03 Mar 2025 16:34:40 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:40 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:40 +0100
Subject: [PATCH v21 10/24] ovpn: store tunnel and transport statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-10-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7109; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+ZmD4VX//jFIsZuykYdyBglH3ygRLBdrH09T/8XlLso=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqPvyHlT6bzlO1zGmIY6zHJVNcbx0nJv8nBj
 sWZbK2fyIaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 h7hwB/wOfsRfLtWq7uJyz42hUMmTWNxqgyw1MPo9M3TgPpHzphUlbLqhTPEkhsQt9BFNb8t0Lsf
 zODSIBflnUWejHg+fVI/kQnSFW6weaFyJUIHBH9GFp/rEvqJW/yroYpOsOEH3OF6/n2HCrYh0eD
 ZYzYRKK0bpSVauueIhpHDMNUOibHssNDad9Lp5GEtenz/L2I3ydgqqM5QBhYibM7H9woc6E474J
 GFGOeOQ7nuLHDJdFFjSPxHK9wJbRJi375AXOvxYll+DciY8QKvqCUaXIK1ugTCJ9ro/Gx2Ka1QO
 /U8jWYzdGuTcVGtnQTttYoANIZ+34sCWY59TRUpP9CQmESWg
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |  1 +
 drivers/net/ovpn/io.c     | 12 +++++++++++-
 drivers/net/ovpn/peer.c   |  2 ++
 drivers/net/ovpn/peer.h   |  5 +++++
 drivers/net/ovpn/stats.c  | 21 +++++++++++++++++++++
 drivers/net/ovpn/stats.h  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 38c9fdca0e2e8e4af3c369ceb3971b58ab52d77b..04c3345807c5d759daf65cc80a290f784dbf5588 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index d0b410535ac340a53f010d0b2f20430b26bb012d..50dc2e4c03f01b02bdf616473b755b6e1e6b57f7 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnpriv.h"
 #include "peer.h"
@@ -55,9 +56,11 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* cause packet to be "received" by the interface */
 	pkt_len = skb->len;
 	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
-	if (likely(ret == NET_RX_SUCCESS))
+	if (likely(ret == NET_RX_SUCCESS)) {
 		/* update RX stats with the size of decrypted packet */
+		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
 		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
+	}
 }
 
 void ovpn_decrypt_post(void *data, int ret)
@@ -158,6 +161,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -181,6 +186,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -206,6 +212,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -220,6 +227,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err_unlock;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
@@ -341,6 +350,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 23eaab1b465b8b88a84cf9f1039621923b640b47..0fe5333c6b8104913526dacc4d7d2260b97f62aa 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -61,6 +61,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index a9113a969f94d66fa17208d563d0bbd255c23fa9..2453d39ce327c6d174cfb35fe5430865b32c2efe 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -14,6 +14,7 @@
 
 #include "crypto.h"
 #include "socket.h"
+#include "stats.h"
 
 /**
  * struct ovpn_peer - the main remote peer object
@@ -27,6 +28,8 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @vpn_stats: per-peer in-VPN TX/RX stats
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -45,6 +48,8 @@ struct ovpn_peer {
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
+	struct ovpn_peer_stats vpn_stats;
+	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind */
 	struct kref refcount;
diff --git a/drivers/net/ovpn/stats.c b/drivers/net/ovpn/stats.c
new file mode 100644
index 0000000000000000000000000000000000000000..d637143473bb913647c79832fd9eb3ebfd9efb59
--- /dev/null
+++ b/drivers/net/ovpn/stats.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/atomic.h>
+
+#include "stats.h"
+
+void ovpn_peer_stats_init(struct ovpn_peer_stats *ps)
+{
+	atomic64_set(&ps->rx.bytes, 0);
+	atomic64_set(&ps->rx.packets, 0);
+
+	atomic64_set(&ps->tx.bytes, 0);
+	atomic64_set(&ps->tx.packets, 0);
+}
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
new file mode 100644
index 0000000000000000000000000000000000000000..53433d8b6c33160845de2ae1ca38e85cf31950b7
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ *		Lev Stipakov <lev@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNSTATS_H_
+#define _NET_OVPN_OVPNSTATS_H_
+
+/* one stat */
+struct ovpn_peer_stat {
+	atomic64_t bytes;
+	atomic64_t packets;
+};
+
+/* rx and tx stats combined */
+struct ovpn_peer_stats {
+	struct ovpn_peer_stat rx;
+	struct ovpn_peer_stat tx;
+};
+
+void ovpn_peer_stats_init(struct ovpn_peer_stats *ps);
+
+static inline void ovpn_peer_stats_increment(struct ovpn_peer_stat *stat,
+					     const unsigned int n)
+{
+	atomic64_add(n, &stat->bytes);
+	atomic64_inc(&stat->packets);
+}
+
+static inline void ovpn_peer_stats_increment_rx(struct ovpn_peer_stats *stats,
+						const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->rx, n);
+}
+
+static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
+						const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->tx, n);
+}
+
+#endif /* _NET_OVPN_OVPNSTATS_H_ */

-- 
2.45.3


