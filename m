Return-Path: <netdev+bounces-107272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26E91A756
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0257A2818B7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0AA187353;
	Thu, 27 Jun 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QHtF1/70"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0BA1891A2
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493689; cv=none; b=i4XsAB01DqSiQKwqeYvYn1+jlSYY0CNZ5HPx+GbyaFyYd/yx8gIYVZVYWqDTwzMS6G5iiFl2m7O1c/1CvTeCV12PP97k1AADagIed5cp/EvBtARKV2wR/M9iPFesVQ+cVz9+FuKWSf1FK3OB6BTln4pY6eohsy3kp77tdc2Lz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493689; c=relaxed/simple;
	bh=xqGCA1tF8rjHAVfkRRZEw0VAyU5J9LbaR/Awsd4rebI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyOqhV7hkkC6epctMCzmnsOkcc53tyxuOQZRjJPk364p0cSQh8eQ9jOS+EsZQ2TnLMK6Gjj4B7aYshekERSDBOOaIT/CDojVi/ljE4h1Ylvpg9SkPsb7q2fU04mZGYrWnBqOYT81Mu7oOh1UoM6usEO6OjNxR1pGPQxZRe6r7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QHtF1/70; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-425624255f3so8025925e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493685; x=1720098485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HUcEzjs5XD1mqhlKyGFFAw6PEffJg7RgdJbeB2T5a0=;
        b=QHtF1/70OrZ/Di0z6C2RH40398fSMK/S6r5LefWCgNNdOXCEl02qpxgh3z+nVJI++C
         poxm83wMgkjWAEKF4HA0c8WXE23aTYD3ug19p5zi8u0m1oaxZ8gewUgjFxB6hfGRkulD
         O17c0E/HxiVeQhbxM/Vuea4CUiy1SLxCHQoq+IB73Lzv0Ia5BcwtEPJWTaXkVb1b315Y
         B94/aSSZMonj354OJpAK0q/452PTvziuP/MNu00f1dfv11Q3Nk+XXLwZ0d6HnXxcIpSL
         CxdnW1Ly8ctaJCGg+lShgvLFO3kcaPJ3+YzgznY1qqliXniLH6LclwH4K+A9fcvy1F92
         vEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493685; x=1720098485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HUcEzjs5XD1mqhlKyGFFAw6PEffJg7RgdJbeB2T5a0=;
        b=oVKe6VnZAglZDt/Y9pbmqLm39QdQFFYX8pECBgc2r9LEJAtHxN+BiWWHpLZgL3YxYf
         Czm0B8fDjPEuxdHTcfu1ELTM/39hyyRwG0RziVXlk+oc9TskGaCW7DX6HvKBJqwCsC8Y
         Nz0Ush3KEMHXZ94SrqRJUQrBlHN92YAB2cU+TCKnKGwoKNFNSGWPcwgbQSOLQJl93GBt
         xj7lyj395ow1ZqZe2+OMr0FRwcrUxUm+pb3rCyWn0Hyu5VGIcV7mjnhTf/LHvHwLZ5Xv
         j5FqK5x3MVTuhCRR4SkGgNP9NbH7oAn8Tky5xkX1wDHbzX4I1vvE+CYjuDqjSlzBb7o0
         tBXQ==
X-Gm-Message-State: AOJu0Yyvd5FvgWM2VkEtk0VbJteK/JFL5RgMAMDZJN0f0LcBZEfoWuwG
	mQGD8bebmCvI3MzlwvonJ7rM5fRR6FXEbnIqcPtw5VtAvdSb1rYFWjg5U8ke8kIH1hOhpO5yP/r
	2
X-Google-Smtp-Source: AGHT+IGFrQbBtjRHWorlFIQ/qVsK3DE3LWAx+bdgnf28+SYQ9PN6Wt7gsZnW5wCU1n/JjU2Pr47JPg==
X-Received: by 2002:a05:600c:3ba9:b0:424:86aa:b7e7 with SMTP id 5b1f17b1804b1-4256432c715mr19882445e9.9.1719493685094;
        Thu, 27 Jun 2024 06:08:05 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:08:04 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 13/25] ovpn: store tunnel and transport statistics
Date: Thu, 27 Jun 2024 15:08:31 +0200
Message-ID: <20240627130843.21042-14-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |  1 +
 drivers/net/ovpn/io.c     | 12 ++++++++++
 drivers/net/ovpn/peer.c   |  3 +++
 drivers/net/ovpn/peer.h   |  9 ++++++++
 drivers/net/ovpn/skb.h    |  1 +
 drivers/net/ovpn/stats.c  | 21 +++++++++++++++++
 drivers/net/ovpn/stats.h  | 47 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 94 insertions(+)
 create mode 100644 drivers/net/ovpn/stats.c
 create mode 100644 drivers/net/ovpn/stats.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index ccdaeced1982..d43fda72646b 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 7da1e7e27533..0475440642dd 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -19,6 +20,7 @@
 #include "crypto_aead.h"
 #include "netlink.h"
 #include "proto.h"
+#include "socket.h"
 #include "udp.h"
 #include "skb.h"
 
@@ -120,6 +122,11 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
 		goto drop;
 	}
 
+	/* increment RX stats */
+	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
+	ovpn_peer_stats_increment_rx(&peer->link_stats,
+				     ovpn_skb_cb(skb)->orig_len);
+
 	ovpn_netdev_write(peer, skb);
 	/* skb is passed to upper layer - don't free it */
 	skb = NULL;
@@ -148,6 +155,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	}
 
 	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_skb_cb(skb)->orig_len = skb->len;
 	ovpn_decrypt_post(skb, ovpn_aead_decrypt(ks, skb));
 }
 
@@ -176,6 +184,9 @@ void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats,
+				     ovpn_skb_cb(skb)->orig_len);
 
 	switch (peer->sock->sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
@@ -216,6 +227,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	}
 
 	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_skb_cb(skb)->orig_len = skb->len;
 
 	/* take a reference to the peer because the crypto code may run async.
 	 * ovpn_encrypt_post() will release it upon completion
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2a89893b3a50..f633b70bb140 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -18,6 +18,7 @@
 #include "main.h"
 #include "netlink.h"
 #include "peer.h"
+#include "socket.h"
 
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
@@ -47,6 +48,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 70d92cd5bd63..dd4d91dfabb5 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,10 +10,15 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
+#include <linux/ptr_ring.h>
+#include <net/dst_cache.h>
+#include <uapi/linux/ovpn.h>
+
 #include "bind.h"
 #include "pktid.h"
 #include "crypto.h"
 #include "socket.h"
+#include "stats.h"
 
 #include <net/dst_cache.h>
 #include <uapi/linux/ovpn.h>
@@ -30,6 +35,8 @@
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
+ * @vpn_stats: per-peer in-VPN TX/RX stays
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -48,6 +55,8 @@ struct ovpn_peer {
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
+	struct ovpn_peer_stats vpn_stats;
+	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind */
 	struct kref refcount;
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index 44786e34b704..99e5bfe252c0 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -22,6 +22,7 @@ struct ovpn_cb {
 	struct sk_buff *skb;
 	struct ovpn_crypto_key_slot *ks;
 	struct aead_request *req;
+	size_t orig_len;
 	unsigned int payload_offset;
 };
 
diff --git a/drivers/net/ovpn/stats.c b/drivers/net/ovpn/stats.c
new file mode 100644
index 000000000000..a383842c3449
--- /dev/null
+++ b/drivers/net/ovpn/stats.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
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
index 000000000000..868f49d25eaa
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
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
2.44.2


