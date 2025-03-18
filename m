Return-Path: <netdev+bounces-175543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE618A66574
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 02:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3484D3BA560
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB61CB518;
	Tue, 18 Mar 2025 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aXDi0cEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60C15ECDF
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262080; cv=none; b=Q1OlorlP3l04YIahwNq1pP1CQaAz8FegibN1hhm5v/MFwrcPFpgUZmCEs6J7REu6NjX0ton3wbc3vRzRR2csrMr2VQZvEnUyzsO8z850sgPDwgG4Gvl3x7XUHDHNHUW/ZTY7fVPRUykGSnGhfHeOspAlG8LuW6O5YFd9n2Yxh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262080; c=relaxed/simple;
	bh=Oh2mEmgHQDDqY5dgblelGUbUuKbQFp4SWFQf+RUcx98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDRAIAaDQpOA4agoe2nkhNcIAlSCy6d0Alf25YZ7sZcSPuO++VI1G8fv9eWhoIZOckmI+HHe3KORBq8zIAxqfgR43HoBTU9mK+DpPPYX/5iKPp+xuHxmzxVMas5bGn2pZOt2vx5qzvjn4j59uyG2p99cyrLrBC6hKpq7xZm1thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aXDi0cEq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913b539aabso3184038f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 18:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262075; x=1742866875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kURLIbnSivguxWg5ML91nymkzfyzsfJwPR62gK5nyAo=;
        b=aXDi0cEq8KZB4B3CjF/9qaYN7VPmr/QNwng/A6XuTRlXMhaco76r/KqMpz43WGPkgb
         +w2rFJEczM+rWHluV/mP/RC1ZeDvLo77mgsdA9VaOQHm2wAFeFkkYVpAN+Q+NOy5CNqx
         ePF5jBewxbd4+b9tgRbxKXdrlkk2tN2K42J9vshBI+OedOl+MRKP0Kw/smfqE6jpUHFn
         J5H1DyNXtJvw6wZJHbVSVLmaAGDezLTmBmZXvcE7zXy0d2/w2AHDyaG5arE7KeUkq7IK
         2/dgV0+7kl/r8yyZohPe33oACxuxAIr54OAe4Q9TQ6zx4MyfI9z/gKuyaJ+QIbd1Rl7w
         5pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262075; x=1742866875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kURLIbnSivguxWg5ML91nymkzfyzsfJwPR62gK5nyAo=;
        b=IEnmKZWSk/28sO5F+41VznQQOL9mxdmbAn9oDOIFy//PEq5841sINDmyYmhBgKo83K
         bMt+s/P6RBgciUP3lJ0haPqAAKISxb/JkWS2CjT95ayQz+3iOq2jXnme3HXl1GIEw/C5
         XxYPRovHfDjD20feHlZR+W6Cyw6V884d7bmUl6he815zZhCsVzz6EaMqkQpta/FkysPd
         bdVairJc7/sKFQEwYuZ9z4kbbyU3BezWAT1Ljp08H75JK62Pl1d8RMBvwN9/s3nqSJOm
         dorqw1tofFF1keCm0bTppdXw1qKWSuxm5PyCiAU3Evjq0BP1ntvzPsJKWGQpwzX5ZcOt
         eTow==
X-Gm-Message-State: AOJu0Yz3jj+3KoLVp6s2O0WYH/5zafULpq3aoHAjSga2rUaCO4eX7Bqi
	vk2jht7ZdQRx6h/fdMz2wuT/NvutZ1c6n/MBrsEWOeQGNhaWJktZ8fBvc82/VBge1RQ8gh4iEk5
	8N9Otff1lBtD0YUrtKWT+kkI9QojE9QxljCv+nHJc28V9arY=
X-Gm-Gg: ASbGncsEUYWUlY3NsFzdcG1K8L9/BcBIiqWUB7Dxm/sTtAUAvy5nHcaOUZLrQ8PNNVG
	IWLFPWUgId2/vhMsfUL+Mn9BW4Z/l9LAF7jecG057e2AQvQJPbOJKy/bviq10Arsw73WSvBahuP
	f/zq2Tq552r0JBoxrSXGTU7jC8YEqjRUkxEIjmQ9m8fU82ytql9+syMwT855oMSah5zX606RnXH
	YeJqQ1tigLltbQ2meWECqlfFrov6kt9c/VdK+3zQzmfDpjPCllMU1JxLB8P/Vx4jcmZ3lJahmOs
	Mp2DuwANKvLRKbicI1NpxQi/9bB8XzhF49k3Rn96qA==
X-Google-Smtp-Source: AGHT+IHgXFM1LD08u+gksAEzw/2vzGPLWfTRyUCCQ0yMVyVNcnakQY1MAxaaAqcLMJpdPcqVnT44tg==
X-Received: by 2002:a5d:5f54:0:b0:391:2fe3:24ec with SMTP id ffacd0b85a97d-3971e3a2fb4mr12654169f8f.14.1742262074687;
        Mon, 17 Mar 2025 18:41:14 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:14 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:45 +0100
Subject: [PATCH net-next v24 10/23] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-10-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=Oh2mEmgHQDDqY5dgblelGUbUuKbQFp4SWFQf+RUcx98=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8qYQ+CmbINS+1zjWNNqyR6RNZp6BTZWEggc
 pC30HSsAGeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKgAKCRALcOU6oDjV
 h2zcCACIrYI0W82I8juq5f94GGMSO8iFAd8mhO/DJcwy2xbGcyOfOMY7RxRNbu+Z9mSj+fWCRtQ
 LtvO+K5/WlIyhE4Ag8rnLRqrwL6FFBbJ0dw13FMgTO58+7yWJeEE91PSv8F3AWF6h53rdx93y6E
 rCNQXG+XCthEkljPz/dy1a7jLw4+xrSaHWpSALB2Cq4Ve3mIxYw+4+sbiBN4ngSVTcJqFvNXlQ3
 mCLVPtFMWemJqtFZsUbZ84TyyCUzfBJDZYy3gXC05tiQ3vuLuuMQrtiYp1hnjUrDfjvvzg9Px+I
 Q24KdK5hjgyT+G2S1d9ftDEJ86rSWCe9Eyii5P4li/kniSlu
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
index f8113f160148c5953c40f69a87a3ed7ce62abacb..a5bd21fb824f650094bd113485520be9a3cbb121 100644
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
@@ -334,6 +343,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
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
2.48.1


