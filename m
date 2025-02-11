Return-Path: <netdev+bounces-164983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E907A2FF5F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42941889F41
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9ED1E47AD;
	Tue, 11 Feb 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="chqLDSHg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31F1E32B7
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234477; cv=none; b=ZQYrbjQDMrh7myW5TtoJQGVuwCc+gZAK7o/Wcddo/k/UU+JcgAL66QHhWTQpt0/cg1GKhcOhlh2pLm3Z3zfKw/+2t9UriAhuNp+b1nLS2uXfxtJh9x7j7biRmiKYVyZGi6Ofcp2/M9YD0txx4H5ASObIaW79UQ5kSZIGWC6Nv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234477; c=relaxed/simple;
	bh=wwQNq2Q0TBrFSrOZM1DftROi8CAvU51ZzQxaUwKNLLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkQ8yVZcxvCy2fZwZhb6ScBYKGgAKEiES7z6P8A38eDAf4V6Yo/8qDrvvSTnHnNjUmar66cxdKPsD3NIl0/h9Xq/rz9m2noE08adwTt0M/6LIxn3XROCKOetAIFtTiwOoNn1Orpnd6yGDIkf9/14D9bHV1tRIO4g+jMt5ihkHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=chqLDSHg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso14448595e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234473; x=1739839273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ9UHiO1m55OSa5PQN2n1Z3N7lCeet+dh1oBKi1r2jE=;
        b=chqLDSHgUSpn+HiMI8ZPVTCYPDecRZ3Tcdo+KsZMUU3mmrX+3bSIeMGDNq6PIqs7xs
         Xsrs+jGdXf3zJLc4ipGzh9KbvAXVsnCyMhkYSxXdfag/sD8/pEP3Yqygh5LCnKo4Adck
         4Uj0yNbEn6Z/MScGDR2oymg81/Anp7ykGNiuqWqwqyW6wEbsAH0iIz0dBITzq+IRchir
         hA9dnDmAJxcCvEs/lZ4sViFSFVCQyMt4pwwJmBOfiAZEwwh2hvi+a99VjayA5GYBlqx/
         LXj+3i54u30Gv5zIP1FHRP/prxVcZqQQM85GUhcBTebdvhHIYDS28zCmzibarOyJ+tL6
         bh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234473; x=1739839273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ9UHiO1m55OSa5PQN2n1Z3N7lCeet+dh1oBKi1r2jE=;
        b=NNqZiUXZPxoiLq8YKvFgfGF3N1i+7ZICaJ4+14WSemDb+62VfmxT4i9GOKhhUyMf6b
         1XgQ49HOoDWjb7Dwl27wrzsw5H42bEI1+cRRRgDc4a2mEtqHE0VwvnJmlxGU3B+tIc7E
         oXNv6byUvyF+mkjUdsajyU4tAykzZlM4VXiRuzyUgApqcReR78DTU6DtjwWyhBuiLyjC
         q+842Ra533eRITj/1GM9UWAF1xbkHiEIGtrxLFgCOs2xX4jpgFcixeQp6UAom5CgMv96
         GloDSdrrWKTQBoMuIEgFTWbm1WfKCShYtdJGQLlXFEoJSunrycu39fvX5wRcvp3MAfM7
         Zsbw==
X-Gm-Message-State: AOJu0YzIbAX68lQCHSqv9/H8UFDYPjUNoKIFZlx8ajW25cpwQqqJGnfL
	p2uhfqBiV66Qs42T4HXBkC6PS1BmiGi0KGtQbzH0oAJsgkrsL8HxDaSX7UgDRT5GTj822sjNmI5
	o
X-Gm-Gg: ASbGncvf+66upetP4LLR151DWPxBbSa1e+gS5BtNMoKOVLUzJuvhhKrXRj87RmvDAdb
	Q8ejj1NFeXs96QnMHd3OeQ4pe5tfuLPZzOSemX8GDasGHmFVU2Zwph90iq9DaJMdXhRIwFw0zNf
	lPJrBNWDmVMctIhxGV+sTKj17yrwh6uaISD88mbJUGJLr8wpHyivV/vPVSc5GMfvDaC3LSDBERk
	Gstt5bmecG4AuB4KnOhdUpliIvIIkNOhu/FPyZb2rTYhdSCzxuumYd+ixQu12PZ9hPzRE+x7xOi
	Jb5uIy10PwAMoanziylQBpPrQpc=
X-Google-Smtp-Source: AGHT+IE4DiC670IHEBjyjmj/cV0FLBPUPMeA1fUHppbR6djpiGVPa/vsnKqpm0NTDg/1eugCgJe/wQ==
X-Received: by 2002:a05:600c:3ba4:b0:439:4c7f:e167 with SMTP id 5b1f17b1804b1-4394ceb0ef5mr10580125e9.1.1739234472960;
        Mon, 10 Feb 2025 16:41:12 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:11 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:03 +0100
Subject: [PATCH net-next v19 10/26] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-10-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
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
 h=from:subject:message-id; bh=wwQNq2Q0TBrFSrOZM1DftROi8CAvU51ZzQxaUwKNLLo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyN4x7Lmu4CWFZAm3jGl+zHPwwPvZNkGJoNF
 D6qiaYCrdSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjQAKCRALcOU6oDjV
 hy5CCACLEtAxHzIDso4ajThT2HDI6sItY0+8E8EG8otg+zgktqiF1+DaksVHOezMN3Beg/nCEN2
 s2fB0Qo7NSUZ0N9HPO7v4nfF9xbQq+yK2BqBM2vEtl0dIBz99evdEkegSYsrZy1XayrHsIlM3+d
 C72P58RI8DGntEpnc8Dcmw6VUcMi6vD8Kqc03pYKVzv8jbPq0NqW2sWSjUMxnK9llFe0gYtPLGn
 Ci2266y0dV7zbE0TH3AhD+FyoTgMN/BOWnOH/yaimYbnnRXxebECEXMntdsUJVqVwVIgsW33clW
 CKpCUMZ8LlVzOnOIiKDyvNYLieDQlApYWh1jvxJuJmA0BCih
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
index ccdaeced1982c851475657860a005ff2b9dfbd13..d43fda72646bdc7644d9a878b56da0a0e5680c98 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 2cbae584efe946813d0857c7c2c3d3ec2965c3a5..34753eea78aa634f2e01370797e243b615d0c996 100644
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
index 0988b48e30d3b041d971e717313b05446e2ab2e2..2e69b098d53bd8c2e549b712530d746f5125cff0 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -47,6 +47,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index aae4611cf22519d00f3e4b63fc6546433c315648..9cc25ab350f4af98f8af3b75dfd57b8a493d433a 100644
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
index 0000000000000000000000000000000000000000..a383842c3449b73694c318837b0b92eb9afaec22
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
index 0000000000000000000000000000000000000000..868f49d25eaa8fef04a02a61c363d95f9c9ef80a
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
2.45.3


