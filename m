Return-Path: <netdev+bounces-174671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46649A5FC72
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC263A3EFA
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D426A0F9;
	Thu, 13 Mar 2025 16:45:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCEA26A0BA
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884330; cv=none; b=anPZmik9UK6tcWDvuLnQV+WVzhgcnDyb5Z69N2oG6poE+nY0n6L27P8tg2jrCN5pOJSzVOc4vLEVTIyGsw5fy8vLiD2G+YqBsNWRPDQKglRpnhJ9l+KmfL67I3XBsr/S31VpqBjGHmLaG0H0wvNqL8a1F+Zc8buwIFByudeZNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884330; c=relaxed/simple;
	bh=57k+p9NtsYaFb+udUZ6ErgcLaD4Fhbn3xv9/HG1RZ9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sx+iifIyUguyk85k3M/PZ91uq4Z24RxcJa4v7CjR+FV8vb1gObS+DQoOjyOwMZPaPl2BKfZgwRfQ1WHbhi1HaFxR9/u7IM7WhCaqqdoD7OIRKyz0GyT8o/Xkr/rga0I47brzlGx4JfMZuBaZdQuT4ZNc8+GSmevr6U0iFzBdlf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300FA272413901a38a4Bc9C0DE305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 36BD2FA1EE;
	Thu, 13 Mar 2025 17:45:26 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 04/10] batman-adv: Add support for jumbo frames
Date: Thu, 13 Mar 2025 17:45:13 +0100
Message-Id: <20250313164519.72808-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

Since batman-adv is not actually depending on hardware capabilities, it has
no limit on the MTU. Only the lower hard interfaces can limit it. In case
these have an high enough MTU or fragmentation is enabled, a higher MTU
than 1500 can be enabled.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 4 +---
 net/batman-adv/main.h           | 2 ++
 net/batman-adv/soft-interface.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 71b2236c0058..e7e7f14da03c 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -618,10 +618,8 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 
 	/* the real soft-interface MTU is computed by removing the payload
 	 * overhead from the maximum amount of bytes that was just computed.
-	 *
-	 * However batman-adv does not support MTUs bigger than ETH_DATA_LEN
 	 */
-	return min_t(int, min_mtu - batadv_max_header_len(), ETH_DATA_LEN);
+	return min_t(int, min_mtu - batadv_max_header_len(), BATADV_MAX_MTU);
 }
 
 /**
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 626618d0c366..4ecc304eaddd 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -22,6 +22,8 @@
 #define BATADV_THROUGHPUT_MAX_VALUE 0xFFFFFFFF
 #define BATADV_JITTER 20
 
+#define BATADV_MAX_MTU (ETH_MAX_MTU - batadv_max_header_len())
+
 /* Time To Live of broadcast messages */
 #define BATADV_TTL 50
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d893c8013261..b1127e6e8900 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -790,7 +790,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->log_level, 0);
 #endif
 	atomic_set(&bat_priv->fragmentation, 1);
-	atomic_set(&bat_priv->packet_size_max, ETH_DATA_LEN);
+	atomic_set(&bat_priv->packet_size_max, BATADV_MAX_MTU);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
@@ -1043,6 +1043,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	 * have not been initialized yet
 	 */
 	dev->mtu = ETH_DATA_LEN;
+	dev->max_mtu = BATADV_MAX_MTU;
 
 	/* generate random address */
 	eth_hw_addr_random(dev);
-- 
2.39.5


