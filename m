Return-Path: <netdev+bounces-106081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F09148B3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98995B265F0
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A013AA39;
	Mon, 24 Jun 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LBusLptv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558013A879
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228605; cv=none; b=Q45qg1gsJ1qlv6Qgz8DWPk/Fodyvc9e4PxRZhDxn52zzW2OeTYDiIkntXDnXbfjeoeREYJ9j8v2CN5Mc7LnYVePRHDcKugmS7ahDdRrvKteU6kwZFDgouf+4WIKYx9apbbWwVwPMXV1eoBLwg7YUudTKxzKDH531vzvi17eaijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228605; c=relaxed/simple;
	bh=xqGCA1tF8rjHAVfkRRZEw0VAyU5J9LbaR/Awsd4rebI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPenZlnkiy/MzBUmJK8tGmDT1Urj8txnzmWN1QptzELQgIYMSgbuICydx+pP7EKjiw4N0JzMrhUCisAbKmPSvBwroVOooQYjZ4a1ye9lsPlMQX+2ajeXc8c7eDzW/rmbRaq1KrFVsnemubEUPJigxXTCokuSQZ7y8GIJ19pA/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LBusLptv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3632a6437d7so2425778f8f.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228601; x=1719833401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HUcEzjs5XD1mqhlKyGFFAw6PEffJg7RgdJbeB2T5a0=;
        b=LBusLptvjgCjOUy26tljSYOacT+To/c/iuRJl3+4LMV2emBY9rk8YN4kJefEsFYu2+
         1zOAfVryqBUqltana17oRhI3n6uNbQd7U6xSCDcZ/LUyn9JB7qZcK98By32MkJRPdX3q
         B29vcpgBFc8Rmp5Oo52P4Ygsjfh74YFcHCaj13CCJWIAgHtbpigbIQ2iuGJCHjSCHsCl
         +sBS16zpOBr+qSHpuAA8/x9twENeuAQrrWNFIiLvnAsLtJRDj3Y6xy4L0FJqhW8Ym5bk
         aMT3LCDbcfGW66tcpYpo5+G3j1VKNG4s2vrqCJbGD4baWZIes2cf4b5CFjUS9mK4uz5A
         kRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228601; x=1719833401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HUcEzjs5XD1mqhlKyGFFAw6PEffJg7RgdJbeB2T5a0=;
        b=Ip7T9hUnSHP5+2/qbS13VDlNypXPesCwyuM3Q+AO1oE2gC1FnjMjA3hzEOttFqe8Rf
         kGsCO49vLepelrx3T+OUmUzSyLXuYftQdwV1cMLRME99MknmCJkm+64ojCHmN83f67G3
         O/dbgPSk2X6hO5v4sip4TA/wM10PtUiXyF7F+dD5DaUN7Dijejh0MwkMCDMFAzYVtX4K
         n4dcVgrCOsvH/iPWrknYRQ33qTJS6AbEY9TMZaj1SwWykInrjhoiwOG86V+wfMkEC/rd
         t+r52muycwbqnsbF96W30ZfI54JeU3teCvQFiz19rbFMx3GC3BdAOByXwsiFs1u2+Pr6
         aAow==
X-Gm-Message-State: AOJu0YxwCEHU00thUGq3AakJIscu6KysMfjDgpq6eCjDK0CIFRiH1Lwe
	RBi9CMRDMfiD1tZf7qLMTN0Be3V/MbkeOnLQhfLBqlL+dmml9RlXYk8axEmBToTElVIuMlRUeHL
	7
X-Google-Smtp-Source: AGHT+IG8165kNFfKEyo2AlDxOZKHKRImE2Y06b4PlsuREtK+6C4/ivDFWHpqFKMDmqP8OvGjvfUVfw==
X-Received: by 2002:adf:e64f:0:b0:362:7b95:172c with SMTP id ffacd0b85a97d-366e36696f5mr4944628f8f.8.1719228601437;
        Mon, 24 Jun 2024 04:30:01 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 13/25] ovpn: store tunnel and transport statistics
Date: Mon, 24 Jun 2024 13:31:10 +0200
Message-ID: <20240624113122.12732-14-antonio@openvpn.net>
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


