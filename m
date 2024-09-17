Return-Path: <netdev+bounces-128629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AE997AA20
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3158AB2A17A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4843C482;
	Tue, 17 Sep 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YC0lpxb7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91104B5C1
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535297; cv=none; b=jV1eBUlsOMt6YwAGaNNKQbIy3YABcdMXVzth2SLHWmVpyTPlwp8tfE2JU74ECuez6s6yhypg5LncQ6t8ogom36+Aq5DqrBrJOk04KQ3GA6WMwf0R42Cj8/sa45vR6FXeeSik4M0+YAbpwa3VNHA0WW5cIYQ4lNLyD8n7dBcRsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535297; c=relaxed/simple;
	bh=cyw95Ui5+mN9FhTU74nS8WAKfr6yGIfRZOM/dXrbXRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqYq5Bx7HgrcvVVyDjPVTGRVMhcvvR1OGSxZjuUwHwVsspdo4E0HismCFpPboeTYC45qDQHSeLJTL0D5sEoZhGtE1XBROwGTk1T9+GykGcFwzLh+4i3TqkxthDsgDigyuUTTzEfGZqwk4xM6u+E0r8k0NuWsehzF/KLbzQJ5PfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YC0lpxb7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae102702so31668005e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535293; x=1727140093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51/oC6Hzpo9Tf99MKIl6jatZTAHx5vYm2j0m9MaXazI=;
        b=YC0lpxb7sbo44vG/dXBrSnT65vTTME+EXvsWOLYOEx8KaaS5DYxwFgytMHINjYzeQd
         qqp4DMeOyi09VUygQa/lhm8+C9W/ii5vxAT5WU+b4+Hfgi9GyybiARBe2DVnNQM/qImY
         KUMr5lpiKncFkQMPiVTPVfMZKWmFVDo3aLLPINxH56U/msLNnx1sfkdPlBoJ4eePTTl/
         mtDMTRyDWSzAudUiha9qBlXY4gymNKmP5Qj4D7ae7PWOfCRoVOUENBhcDQ7O6pUr/s/I
         isYgsAHGUfFlPSdL2J0ZMdS2JpjP+A//xTWx5RNeSTKRSE5YUKMeqMK9sH9tCn5ajn1v
         43Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535293; x=1727140093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51/oC6Hzpo9Tf99MKIl6jatZTAHx5vYm2j0m9MaXazI=;
        b=dpFbJObC99MHPGQ8/TinEVdOmBbq5bmnKnuqRh0TqZltp0PkjGrHUF3bTfs3Rtfyo7
         kTuuTeQaIQSTluMZIU8hnVUVDW82wsHcdLYg6KCgM2j6mK9EX/xhWaKzC5AtWCofzQ4+
         Fw8HOKXhKf2vKpsIW/IZpd3kwAsj5CaeNsnocqB9AwnOHJVPnXP3XEayopf4X36vRHjD
         fe5Cl/RS+XRo2DKKfp4S0KZqmBgnYaVa8UQ92izo1ok+QhaeowvitiXPODSncQMMFNv5
         eB3CwJ7/aFoo+splknJZINy/ZtinVfA5yWB9lUdXznFhBEdTcLXwRlxPyBDETFc6DQfc
         URAA==
X-Gm-Message-State: AOJu0YxI3ea0eNp/5MdcikQhYFl6Z0Za/voA5TY8U7gUG5XFYgkk+UQ/
	Dz8/m4yluchrmIaES06iqGBiDPAd68mqN23watA3RGOhPZ5MGz9WIhe0z+Ci71KSEzxO7Pik2af
	d
X-Google-Smtp-Source: AGHT+IE1D2lAwWYouoOo6bsSAm0ZVtOTwDhj3ijaJWkqrmkLVSGjYodWPJMX7JQ5kVBiG8WnPQ9HNg==
X-Received: by 2002:a05:600c:3492:b0:42c:ad30:678 with SMTP id 5b1f17b1804b1-42d964d8446mr97993355e9.28.1726535292817;
        Mon, 16 Sep 2024 18:08:12 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:12 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 13/25] ovpn: store tunnel and transport statistics
Date: Tue, 17 Sep 2024 03:07:22 +0200
Message-ID: <20240917010734.1905-14-antonio@openvpn.net>
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

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile      |  1 +
 drivers/net/ovpn/crypto_aead.c |  2 ++
 drivers/net/ovpn/io.c          | 12 +++++++++
 drivers/net/ovpn/peer.c        |  3 +++
 drivers/net/ovpn/peer.h        |  8 ++++++
 drivers/net/ovpn/skb.h         |  1 +
 drivers/net/ovpn/stats.c       | 21 +++++++++++++++
 drivers/net/ovpn/stats.h       | 47 ++++++++++++++++++++++++++++++++++
 8 files changed, 95 insertions(+)
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
index 97134ac679c6..6599c8550390 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -128,6 +128,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
 	aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
 
+	ovpn_skb_cb(skb)->ctx->orig_len = skb->len;
 	ovpn_skb_cb(skb)->ctx->peer = peer;
 	ovpn_skb_cb(skb)->ctx->req = req;
 	ovpn_skb_cb(skb)->ctx->ks = ks;
@@ -216,6 +217,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	aead_request_set_ad(req, NONCE_WIRE_SIZE + OVPN_OP_SIZE_V2);
 
+	ovpn_skb_cb(skb)->ctx->orig_len = skb->len;
 	ovpn_skb_cb(skb)->ctx->payload_offset = payload_offset;
 	ovpn_skb_cb(skb)->ctx->peer = peer;
 	ovpn_skb_cb(skb)->ctx->req = req;
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a75aa301b99e..d54af1a0f03a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -20,6 +21,7 @@
 #include "crypto_aead.h"
 #include "netlink.h"
 #include "proto.h"
+#include "socket.h"
 #include "udp.h"
 #include "skb.h"
 
@@ -66,6 +68,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	unsigned int payload_offset = 0;
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
+	unsigned int orig_len = 0;
 	__be16 proto;
 	__be32 *pid;
 
@@ -80,6 +83,7 @@ void ovpn_decrypt_post(void *data, int ret)
 		payload_offset = ovpn_skb_cb(skb)->ctx->payload_offset;
 		ks = ovpn_skb_cb(skb)->ctx->ks;
 		peer = ovpn_skb_cb(skb)->ctx->peer;
+		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
 		kfree(ovpn_skb_cb(skb)->ctx);
@@ -133,6 +137,10 @@ void ovpn_decrypt_post(void *data, int ret)
 		goto drop;
 	}
 
+	/* increment RX stats */
+	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
+	ovpn_peer_stats_increment_rx(&peer->link_stats, orig_len);
+
 	ovpn_netdev_write(peer, skb);
 	/* skb is passed to upper layer - don't free it */
 	skb = NULL;
@@ -171,6 +179,7 @@ void ovpn_encrypt_post(void *data, int ret)
 {
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
+	unsigned int orig_len = 0;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -181,6 +190,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	/* crypto is done, cleanup skb CB and its members */
 	if (likely(ovpn_skb_cb(skb)->ctx)) {
 		peer = ovpn_skb_cb(skb)->ctx->peer;
+		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
 		ovpn_crypto_key_slot_put(ovpn_skb_cb(skb)->ctx->ks);
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
@@ -192,6 +202,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, orig_len);
 
 	switch (peer->sock->sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
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


