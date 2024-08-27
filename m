Return-Path: <netdev+bounces-122287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85396099F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD7B287356
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B011A38D2;
	Tue, 27 Aug 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gdEJ55al"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2411A08C1
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760417; cv=none; b=Pioa81soXj6yae2/euIR9K6dDl516mhKTmPa80ifdAFwhWIeLmQEKDp2E7kNQfMuYyztPlDInE71RNqGf+WFBmhlIUMglLFAj71qLPKoVzVxjW0fegVe9BMYmqTgwsb+6iSIYKpCQ1N4Zh3PLitWuOG450yTgq1EgT1Jrfbrjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760417; c=relaxed/simple;
	bh=2bZcVgEJdiYbN8n7yuBFiPw5pNox4W++hpKG6mGOxxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCIk1LzURjfHZMlvbtCkyFNq/evKJDETAwjYr6CZowqJ5br5Dvoap17lCDunDmR1YIoIYsTNMFeBpo7vOtIt+Mvbu1vax12ro0McALAYxyRZwXJyXAj8n2Sczrm9QmU8jaodV/T0FVwhN0HJDRUD74xCtY4QFmZBGa/5xu+P7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gdEJ55al; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e3129851so48432305e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760413; x=1725365213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PQxS1GsFL2aj3JNIrMMNjOj7bQH5jbUWuK18mclNZU=;
        b=gdEJ55al1bsMp1lNeUPusCCP7r3qDJiTks/Q4i8TB8VYwWCt/I+J5Z6AQyd+oBQs5f
         ufcZOCTW/Wp826XBte9tNHdeWm89NKCRVbk3UhVe2DqjHE3f4RCSk4Lq6l4XXm36yj+j
         cPxJ0G6H5M6veFmjPE7EnlME7NWv05BtLhsEUiUf83ekuA5IrDgUwmWy7D8YAbVg0C85
         BFrDYEYwEtciaOH6KzoQ43XNVBKvqvUAgY5ZVj2ol8hLBal69VRnMjWMDl5fniUpSUYR
         ja/AvL4DtpSG17+4K1G96LUFVx2YQ4NeotN5uUr3sw3iLxmHYmFEjxiaKsl8IUldwmKK
         4hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760413; x=1725365213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PQxS1GsFL2aj3JNIrMMNjOj7bQH5jbUWuK18mclNZU=;
        b=LZuduayC+m66WJ3RgClSN2SwGuCnUk+RVEVgA5tWMeja46d2Fk9sHq8lmoqODL539X
         3qHD9cbzH2wsA9raw4GS+vWSuHoqkechU5QFKRFrEvQ+1xDEy3gx4BfDKq/0HvtzbnPq
         kZ5tlenfY+PdCkV24GGq3IptZCFdtiKF29xTh9+VoQNwAWNLjaifaRwJ7TLzsHlAfa+j
         SJllA4TjMamDYkRnLcfxMTrIZXdU1f4i5Gwtxjb4MFhzssosXoNxckkQcVBlRd/ogzL7
         0otoSWxlS5EtXTjGx5bKFyJG6xgo0JrQhUv0zqEp6qkGTOW97+Zf5NedYMFAnHJ1/5bp
         l90g==
X-Gm-Message-State: AOJu0Ywsi8/MZ9MtsrVNYHQysRSjIiOWR035/CNbGtmw2CsLjZSI6sGL
	RiqhmNkm8+WDB3ZWfhRYvAhdkrm60oHVLmGwHCf48TcAReh1xNc/UJXUwtOg6WRnMGDCrUUJ0Et
	9
X-Google-Smtp-Source: AGHT+IHTEqE/g42uHN8FUq8fHwbXENPk3B94BzZF4XoPyHM4S8fwiYNC+WPsh7SMXU0gpnkzB9K/9A==
X-Received: by 2002:a05:6000:248:b0:368:4b61:7197 with SMTP id ffacd0b85a97d-3748c7d4d9bmr1495402f8f.24.1724760412946;
        Tue, 27 Aug 2024 05:06:52 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:52 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 13/25] ovpn: store tunnel and transport statistics
Date: Tue, 27 Aug 2024 14:07:53 +0200
Message-ID: <20240827120805.13681-14-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
 drivers/net/ovpn/Makefile      |  1 +
 drivers/net/ovpn/crypto_aead.c |  2 ++
 drivers/net/ovpn/io.c          | 10 ++++++++
 drivers/net/ovpn/peer.c        |  3 +++
 drivers/net/ovpn/peer.h        |  8 ++++++
 drivers/net/ovpn/skb.h         |  1 +
 drivers/net/ovpn/stats.c       | 21 +++++++++++++++
 drivers/net/ovpn/stats.h       | 47 ++++++++++++++++++++++++++++++++++
 8 files changed, 93 insertions(+)
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
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 2e36ba8c4bfd..dab11b60ae1b 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -139,6 +139,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
 	aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
 
+	ovpn_skb_cb(skb)->ctx->orig_len = skb->len;
 	ovpn_skb_cb(skb)->ctx->peer = peer;
 	ovpn_skb_cb(skb)->ctx->req = req;
 	ovpn_skb_cb(skb)->ctx->ks = ks;
@@ -236,6 +237,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	aead_request_set_ad(req, NONCE_WIRE_SIZE + OVPN_OP_SIZE_V2);
 
+	ovpn_skb_cb(skb)->ctx->orig_len = skb->len;
 	ovpn_skb_cb(skb)->ctx->payload_offset = payload_offset;
 	ovpn_skb_cb(skb)->ctx->peer = peer;
 	ovpn_skb_cb(skb)->ctx->req = req;
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 2b9311566971..82c18abc16a9 100644
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
+				     ovpn_skb_cb(skb)->ctx->orig_len);
+
 	kfree(ovpn_skb_cb(skb)->ctx);
 	ovpn_netdev_write(peer, skb);
 	/* skb is passed to upper layer - don't free it */
@@ -169,6 +176,9 @@ void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats,
+				     ovpn_skb_cb(skb)->ctx->orig_len);
 
 	kfree(ovpn_skb_cb(skb)->ctx);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 212d1210bc56..6d34c56a4a51 100644
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
index 70d92cd5bd63..89f6face7187 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,10 +10,14 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
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
@@ -30,6 +34,8 @@
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
+ * @vpn_stats: per-peer in-VPN TX/RX stays
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -48,6 +54,8 @@ struct ovpn_peer {
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
+	struct ovpn_peer_stats vpn_stats;
+	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind */
 	struct kref refcount;
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index 3f94efae20fb..3d9f38b081a6 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -23,6 +23,7 @@ struct ovpn_cb_ctx {
 	struct ovpn_crypto_key_slot *ks;
 	struct aead_request *req;
 	struct scatterlist sg[MAX_SKB_FRAGS + 2];
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


