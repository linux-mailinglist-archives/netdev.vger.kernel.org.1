Return-Path: <netdev+bounces-179905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41F6A7EDED
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD26117F7D9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78B253F0D;
	Mon,  7 Apr 2025 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZZ+gC8bG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2252528FF
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055247; cv=none; b=g/CgMzi3aMqx0neL//GNbm7izLg/RUmzx5iEFwrB9SLab4/8SK9kB030mpNFytiFCmhXoJOOt9QiE39jRPhslJgKwBlPpGy5YHcCcuRpd03wda2i7/zrCQTjy6GOuzTSdCn7UV3EBy66r8ICEO293Ya8QROjRIGzLgtPZPmVJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055247; c=relaxed/simple;
	bh=rY2CNEFsShP7PE3AH3l3Ilk+BpyF1VG9JCGhQkeTcds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/Hude2KaNcY/NcXGhD4i5H3n/yOXZbfZziPo99UcckahIH2wFDf2uH/99wJAlu1yq/ektaN6INQEt6WO/rRffhLKGVsDgKxTOfBLiLDU2vH0Wo4fFAFCj8LGs6d53RdzZbDqI8svtbD9wllYVako1HMcJFnDNyLpkZ3zsHlKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZZ+gC8bG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso32317485e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055243; x=1744660043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hBqWyZl2jX2WJFnu2RxF49Fn3JxP0vE7FGUTLxnC9E=;
        b=ZZ+gC8bGXHdOdBdCwgZqZYA4LWMp0HgSCgF7U++gsFB9j4kRPz2XSPShN2+lMie/As
         o9wTU81L7A2hoPN0U31YItLidClSHzfbBm6G79ydxCpq10TBa4x+kdnrjq6qv/dZTFGf
         5fGa5WG/kAbgi13h4Tz3IxGquymc52Ul/R5JJZvVPievQaaqklFfVqTLS4FnBN3MYWdK
         GGhOv3J0BZa/Jpah9FUhQ5LaTKbvz88T/N6Lfg4qpNgOa29Xz0f+oFbFBhqOxIVv8VAi
         7E5ULO6jRLIidx2/aXSL7t/ka3CWv9yMetwNiBaAxZkgfmVgjGLcjNgsLbe4CyBQWQTY
         Lj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055243; x=1744660043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hBqWyZl2jX2WJFnu2RxF49Fn3JxP0vE7FGUTLxnC9E=;
        b=HbGDTRyPryijT3Lh5dyD0dwQ+xRXkh88BZOxKv3jujCOM3l9zgJ7JFJbvUBpRn4TzX
         h9NxzCngZJcYVTFtrZI0iDMj3y56Dve2uxHVQAW63R07CxTiysV/O+es4vKwwFsp+qgR
         6Pae5cl8Qgk9KHBtwiKclVMMUpfEXT0q24Y61FrAgraQGzZobsVddhD9+dAiqw0Nulbr
         pRCW2DkJiwBU71o2L/65A9RiHQVPp2bDmPY0JENRd9XCQYkKAQLJEm2flksxk1k9QuRs
         dqu1ijit2Gk+Eqb2bN3JhKxEY/enMnbwN8wUVCvbkU1bl6F9pNp8dLFLpApFGAElg5ak
         Cp1Q==
X-Gm-Message-State: AOJu0YxOHA7HPLg0BZypVnKbQ0AktCx8zei+vw3OWpK8KnZ3eIezO1bw
	kyas7g/u9Tmaidwajn6Ck+SeNCsufZ3HTPQ3X/Ls5asyZqZdYq/ZAxTp0BPhMqNiN8YeHG1pRUY
	6fmo0pi7vUeSS3/nl51KhLmoYcAVoo8SleSQrzgifpVxQnoA=
X-Gm-Gg: ASbGncv/tYoWOapYd58jazso5DN+pQKWd1mUjfSEesqEN1jGUrfWd+tf4o6AhIRqfcq
	6Mml0GWLt6NTZ1tXuh7fiwC0RhKSxYS5MdmC8/CuJhsRPW1xTZzGE/0urdd0md6ugZkTIFrDMyh
	DKXpbxak/wAOEgyaZi/1T11iFQQsn04SN5ZxVowA0ZEPy+bpUy2uHYUOdLgx9qZhzBgOuSzXiyv
	jsNSAt3v43+o+csfq1gMe6kmmBA0CtcRsL0V3It6OSGH10tQP/lqdj+J3GcgYhLPlWfTQjafn3u
	HWzHz1Am8bywqPnmXmEII1LSSYwETGeEv0yn0udlPg==
X-Google-Smtp-Source: AGHT+IHwBTOJS916vsXD8X5FhgUXF+W13xk7fdFay5VqI0verCQGnQ416dbIKrOL2tgSOWY2UXrDqQ==
X-Received: by 2002:a05:600c:510d:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43ecf9c3e5emr98792265e9.20.1744055242874;
        Mon, 07 Apr 2025 12:47:22 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:18 +0200
Subject: [PATCH net-next v25 10/23] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-10-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
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
 h=from:subject:message-id; bh=rY2CNEFsShP7PE3AH3l3Ilk+BpyF1VG9JCGhQkeTcds=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu1qwjLqxdfyRnAQr7YSJEnsb2XGPl3797dM
 nOn7KHLld2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtQAKCRALcOU6oDjV
 h/LeB/9ralrm3BR7ZD8ngtU99Bt8RgZmk66ax5bbFcuPOKNJniUUpVOcLl7hcHaw1tA8wHzE/Sb
 Aqv2CaQhdIrMCVpWBwoHoQpjgI7npU83fch22MbaEu6wMSQtVsIUv7uUzzLyyhgikNt172i+BNd
 rgxiL9TzXMwDP8bVFLnUhMa3kiU2r+CpG58XgPU2aUyF2Ptr4SOcTraw+CR1li8+RMMEJ4JFhoR
 wlZpm8rUdyUP3OulyI98mviSDp8Mn06+Mp9n+7gI+LqzREJPNFsPVN25Nsgm3Hi/6ltD9VJtH4v
 M7GPH3BdwdKQldAVurMrgvjI6wHz/qrd7GhnB8qPt2Uz1JPi
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
index 3c854aa5017071ca9b3253298166ddc01b1896c3..72a96e08e00fc938cad987d067ad349af148e1d3 100644
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
@@ -152,6 +155,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -175,6 +180,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -194,6 +200,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -208,6 +215,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err_unlock;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
@@ -322,6 +331,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
2.49.0


