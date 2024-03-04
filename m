Return-Path: <netdev+bounces-77138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F58704E5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899631C21B30
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE84AED4;
	Mon,  4 Mar 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CKQ/Hhx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAE47793
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564957; cv=none; b=LX4gusRCWm5Ni4wSGaZdedtAzpEG0gH0JoQuLoSqXQvLicR61lrub6d9eVav6trh8toCgX1LmSXHe4iifv6eqMWXr8s7EVPDyUA3nkF/w/nOG8qtpZ84/Mz/P9cTl3Tj7gjw7pNEorQpUezfqXmNbFktIRYfBHtLFDdflw0Pmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564957; c=relaxed/simple;
	bh=uHrFZI3hI7LZqjumpcGg5MdOMSzyCNVqbOGe6vJDydg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGLliEy54mlOeeZdlwgHsvIAOgzPs+rLvz3Iw1RjM1zjLlKTDkWeAo6znzNL6YfbNLfmln6n1VNUDZ/hFoWFW7pfL/1xe+U+ATxwRZPyi+3JCYc66BtUxSsPv0S/aGJwktMvh/R8ACVeioLsntz1UCQsWh1ey8IC2UYv3C5nU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CKQ/Hhx4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so6344000a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564952; x=1710169752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoxNwNxIbQFOzaqVts26zTC38n2xVialUuAm4hvB2SY=;
        b=CKQ/Hhx4Od3Fw7Cj7L6YpklB0vJGoFypgUC6+C8/tK1bsQB5zZ/hobI6Fyfok18A04
         vwmKfUziLr+VDGAwmA01z+wnrprhSsBmWyqudmJscYMuzFG+9j10YTRHqjgp5Y1+eoZz
         mcufpUHVInb5KHTDSCHm3oovG4rSO+mKJqz4AIc77s2rZXBnARc7sWGb6Te8WDW15Om5
         SP06/J/FyfjXgHxQkZmqofYfF8kzG5ySQ9stoLkcVQsSRT2wG9ECRt/BbpBSBLWQi/PT
         qfXX2E2ZNRxCe1707kr6/G94w+6OT4xqwPSw6Yri3UdiwRHoUBZFaVHB/B7VdzbKvyoO
         eNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564952; x=1710169752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoxNwNxIbQFOzaqVts26zTC38n2xVialUuAm4hvB2SY=;
        b=T0JTnIUXSWJSVXg8l2mpxST/euTN9/woUIXUrz2Jt7zE3fSToklSZ2GsSBxiaEORKK
         3Qd+ltlbY59Xul0RP2aGA2Q4+gx4i24TB77NX025/NhOuG5fGvox6vDY38wmjqIkE2Kj
         i+tvb0D64+jdSqScqHwp4WYoKK5yr1WS7MhPzMelWnkUHralZIm724fKeP9Au4UQ+9qW
         LaxyvAhE0s9CgujErmG/Cj+eSp37VxqEDYhXW9rRU1gIgTTkxnrmhROX2oH/uFsS4vEE
         ORA1coSvxru+IN5kix5uD6MeIQn4ldKNFb4A+97tWVYvfO/CLTZ7/51W0U05oAlcXbQ1
         606A==
X-Gm-Message-State: AOJu0YwHKu52p8ZQ6yNvI+RAP3CsuaW1hi3ioWVgSd85VVMPBbKnpUfF
	g0hQKQI6ENB2aOsAMv+TQuMjspjGQVqM2OrDi35YDTj6ez2KRTPo7rh8FcWqzX9ODaHaZNgnS/4
	a9M4=
X-Google-Smtp-Source: AGHT+IFiYxdrs5uhwAWdjEms+iPrY4ztZ2EOqrqwVEWEsTrnuJ7ZJTK64othYFmAsVN3wEONklrg0Q==
X-Received: by 2002:a17:906:34c6:b0:a45:7d2d:e30d with SMTP id h6-20020a17090634c600b00a457d2de30dmr965476ejb.59.1709564952353;
        Mon, 04 Mar 2024 07:09:12 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:11 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 11/22] ovpn: store tunnel and transport statistics
Date: Mon,  4 Mar 2024 16:09:02 +0100
Message-ID: <20240304150914.11444-12-antonio@openvpn.net>
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

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |  1 +
 drivers/net/ovpn/io.c     |  8 ++++++
 drivers/net/ovpn/peer.c   |  2 ++
 drivers/net/ovpn/peer.h   |  7 ++++++
 drivers/net/ovpn/stats.c  | 21 ++++++++++++++++
 drivers/net/ovpn/stats.h  | 51 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+)
 create mode 100644 drivers/net/ovpn/stats.c
 create mode 100644 drivers/net/ovpn/stats.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index eaa16c24573c..7eaee71bbe9f 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -16,4 +16,5 @@ ovpn-y += netlink.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 6c469fedb89a..e6c99e08cf41 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -162,6 +162,8 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	int ret = -1;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key Id in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -182,6 +184,9 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 		goto drop;
 	}
 
+	/* increment RX stats */
+	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
+
 	/* check if this is a valid datapacket that has to be delivered to the
 	 * tun interface
 	 */
@@ -268,6 +273,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 		goto err;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
+
 	/* encrypt */
 	ret = ovpn_aead_encrypt(ks, skb, peer->id);
 	if (unlikely(ret < 0)) {
@@ -278,6 +285,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	success = true;
 
+	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
 err:
 	ovpn_crypto_key_slot_put(ks);
 	return success;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 01b994801393..658d922d4ae8 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -45,6 +45,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	INIT_WORK(&peer->encrypt_work, ovpn_encrypt_work);
 	INIT_WORK(&peer->decrypt_work, ovpn_decrypt_work);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 03793f68a62b..788ec933fc00 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -13,6 +13,7 @@
 #include "bind.h"
 #include "crypto.h"
 #include "socket.h"
+#include "stats.h"
 
 #include <linux/ptr_ring.h>
 #include <net/dst_cache.h>
@@ -53,6 +54,12 @@ struct ovpn_peer {
 	/* true if ovpn_peer_mark_delete was called */
 	bool halt;
 
+	/* per-peer in-VPN rx/tx stats */
+	struct ovpn_peer_stats vpn_stats;
+
+	/* per-peer link/transport rx/tx stats */
+	struct ovpn_peer_stats link_stats;
+
 	/* why peer was deleted - keepalive timeout, module removed etc */
 	enum ovpn_del_peer_reason delete_reason;
 
diff --git a/drivers/net/ovpn/stats.c b/drivers/net/ovpn/stats.c
new file mode 100644
index 000000000000..10ae70ed9cc9
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
+#include "stats.h"
+
+#include <linux/atomic.h>
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
index 000000000000..afdf75947bd7
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,51 @@
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
+#include <linux/atomic.h>
+#include <linux/jiffies.h>
+
+struct ovpn_struct;
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
+static inline void ovpn_peer_stats_increment(struct ovpn_peer_stat *stat, const unsigned int n)
+{
+	atomic64_add(n, &stat->bytes);
+	atomic_inc(&stat->packets);
+}
+
+static inline void ovpn_peer_stats_increment_rx(struct ovpn_peer_stats *stats, const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->rx, n);
+}
+
+static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats, const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->tx, n);
+}
+
+#endif /* _NET_OVPN_OVPNSTATS_H_ */
-- 
2.43.0


