Return-Path: <netdev+bounces-93567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A248BC54E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9C282349
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F244C66;
	Mon,  6 May 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gz8kLSaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFC43AD5
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958150; cv=none; b=GlSQN8WXwhbymHh/NG0HQPtkEszlmDV78BRiLhmIU/+OBSRD8OnXnQRq3tXwvTuD/NeYCtBrn/Zo/kFtN/Nga+t4alvNgPCilOqSZYMKgGANVKHyRoC4xBLGu659jS62C+cAeEDdTvhKEQ7ULPDQEAk3MKlNRFQrIIQnnr+zdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958150; c=relaxed/simple;
	bh=EtWm+66Jr9LkZMilQ8EXoV6W8Cxa5wlGxnRcnoyIB3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+NfYqpWy1yzY1ovLMI6LzMx+trXuBJ+//H+cjXAwYF0Ebxu45wKHdl9wniA3zSjRBOdBjvJKkLHsIPUZcvBXA96nedZqIkTIzSfBZv7xjNwrUzMMKd1rfA2LJ3oznFiLeS6qR4biX3W7CZjjMA2U611r5108bQuvT3N8oLcI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gz8kLSaq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34f0e55787aso503091f8f.2
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958146; x=1715562946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iH1JY0/hXtdyTcDq+sefXKmXnhicTShB77yX55fVoo=;
        b=gz8kLSaqlcz57YMs0vwaHrPYvow7+51/GfISHL83VPKRPMY13AX+1l8SaNCn13Q/As
         g81OX2MhXHEplfo+KIhsbN0qVzPtzg6JpMeFFXbho27zxSnXXr9fyqUkYIoqKQY2u7LV
         E2B9k+5Pxkph2MVP4luwrYO+IJg708azRZqkEG++iLK8XnrPzw04cIpmlJsyDNll31WO
         Gtg2RRya/durDz/oSo33IQi6sND1aD4NlS6Ndn0uUPzI1QKzj8NGJU6/GSJlHBtTgWM/
         9NwPYDt40GxWmJTGi9PAJa3iHwuIC4zNUXnD7iLDz6jDgNByUMjas0Jr+no/vCrlDdBH
         HPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958146; x=1715562946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iH1JY0/hXtdyTcDq+sefXKmXnhicTShB77yX55fVoo=;
        b=OOQfcYAQpQ/IPwdn+rStnpCqOdaHioxpOpWTRrpAi7dWIo6Dqvoe/HWCOFb4gp0rN+
         q0O1RIC3DmCkFhhIC14rx/LshF514Fo0rU5JT5H7TJKTjVAsDyAuObV8KlKbHACsT6xt
         drkzYuQVlyg426zRWwwOlF1f804m8oNmHrpoPXvaMcgFqcol2YY2pv2Ggq6UPang/New
         a66a4HQ25R/zfidMg0SN/+P87R88yOCeG4wH7bgAAYnG5FdOZvu/AT+y8mGwVGwW9Q+l
         73ZedqaiurQCiXemMvPAUfGM0cN7+FrJ1Yr3j7KMGJjMUWPsTqorM/yL6ko2lI+5WCag
         rPnw==
X-Gm-Message-State: AOJu0Ywdx8tYcVGIdoq40wamnNH+IkHyuRpPfYbc5i9fTMYFgJ2FGPEd
	uNp7JVnJaZhPCCG+rmoJabvyN+eXCjShxu60yK5VfKX1c8cmavDLGYYY6+RBQCUxcGz0/RWJp5C
	5
X-Google-Smtp-Source: AGHT+IEnJMGIvg7Pt5/CKuDRhDPgh1p+2VG0hDwPCJ5R5Fqe3YTB10VzHFlbxpkRGhoL/HYFIpnlIg==
X-Received: by 2002:adf:dd88:0:b0:34d:e252:b57d with SMTP id x8-20020adfdd88000000b0034de252b57dmr5511161wrl.17.1714958146325;
        Sun, 05 May 2024 18:15:46 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:45 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 12/24] ovpn: store tunnel and transport statistics
Date: Mon,  6 May 2024 03:16:25 +0200
Message-ID: <20240506011637.27272-13-antonio@openvpn.net>
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

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |  1 +
 drivers/net/ovpn/io.c     | 10 ++++++++
 drivers/net/ovpn/peer.c   |  3 +++
 drivers/net/ovpn/peer.h   | 13 +++++++---
 drivers/net/ovpn/stats.c  | 21 ++++++++++++++++
 drivers/net/ovpn/stats.h  | 52 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 4 deletions(-)
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
index 66a4c551c191..699e7f1274db 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "io.h"
@@ -19,6 +20,7 @@
 #include "crypto_aead.h"
 #include "netlink.h"
 #include "proto.h"
+#include "socket.h"
 #include "udp.h"
 
 int ovpn_struct_init(struct net_device *dev)
@@ -163,6 +165,8 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	int ret = -1;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key Id in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -184,6 +188,9 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 		goto drop;
 	}
 
+	/* increment RX stats */
+	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
+
 	/* check if this is a valid datapacket that has to be delivered to the
 	 * tun interface
 	 */
@@ -278,6 +285,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 		goto err;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
+
 	/* encrypt */
 	ret = ovpn_aead_encrypt(ks, skb, peer->id);
 	if (unlikely(ret < 0)) {
@@ -289,6 +298,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	success = true;
 
+	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
 err:
 	ovpn_crypto_key_slot_put(ks);
 	return success;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1b941deeede0..99a2ae42a332 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -20,6 +20,7 @@
 #include "main.h"
 #include "netlink.h"
 #include "peer.h"
+#include "socket.h"
 
 struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 {
@@ -42,6 +43,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	INIT_WORK(&peer->encrypt_work, ovpn_encrypt_work);
 	INIT_WORK(&peer->decrypt_work, ovpn_decrypt_work);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index da41d711745c..b5ff59a4b40f 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,14 +10,15 @@
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
-
-#include <linux/ptr_ring.h>
-#include <net/dst_cache.h>
-#include <uapi/linux/ovpn.h>
+#include "stats.h"
 
 /**
  * struct ovpn_peer - the main remote peer object
@@ -36,6 +37,8 @@
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
+ * @vpn_stats: per-peer in-VPN TX/RX stays
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -60,6 +63,8 @@ struct ovpn_peer {
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
+	struct ovpn_peer_stats vpn_stats;
+	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind */
 	struct kref refcount;
diff --git a/drivers/net/ovpn/stats.c b/drivers/net/ovpn/stats.c
new file mode 100644
index 000000000000..78cd030fa26e
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
+	atomic_set(&ps->rx.packets, 0);
+
+	atomic64_set(&ps->tx.bytes, 0);
+	atomic_set(&ps->tx.packets, 0);
+}
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
new file mode 100644
index 000000000000..5134e49c0458
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,52 @@
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
+//#include <linux/atomic.h>
+//#include <linux/jiffies.h>
+
+/* per-peer stats, measured on transport layer */
+
+/* one stat */
+struct ovpn_peer_stat {
+	atomic64_t bytes;
+	atomic_t packets;
+};
+
+/* rx and tx stats, enabled by notify_per != 0 or period != 0 */
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
+	atomic_inc(&stat->packets);
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
2.43.2


