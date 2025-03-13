Return-Path: <netdev+bounces-174675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B64A5FC75
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6B188D804
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14745269AF4;
	Thu, 13 Mar 2025 16:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841E26A1AD
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884334; cv=none; b=FRQehx46vuxy8VGKs/YtaDOkO/psD6MeOk3dBKzc3qRifUAaiNogOFGqXCN9lqJsji5mNQiELhyV7+Sdc+YHXn8JMVQnaDjF1BuCPtd1SBVe0nbR/uZnTd6c9Fby7WSxDJp9NiHTZovCFa6VrLn1W3ANwlA5Aa2zZwFntOXpUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884334; c=relaxed/simple;
	bh=B2/rw++kDErVq6poDUptUuBqK5bMYY2FGJ7MlH3Tirw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnliApLOtIOW4sbqR2kK3ZVKp36j9kbHwWTtR1K78MuX39IJtGFIvVwg4dSWaNv27JzT7GGfDMjHPIgZtgC98at3qEfMvUTe2o9KBfx5kB+EpDansut0pWd5jorEcp6Lb2l58gPFVNAiilsTC9idMS3fDRFsuBe2orMJ2iHXs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300Fa272413901A38A4BC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BB7EEFA44B;
	Thu, 13 Mar 2025 17:45:30 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 09/10] batman-adv: Limit aggregation size to outgoing MTU
Date: Thu, 13 Mar 2025 17:45:18 +0100
Message-Id: <20250313164519.72808-10-sw@simonwunderlich.de>
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

If a B.A.T.M.A.N. IV aggregated OGM was prepared, it was always assumed
that 512 bytes (BATADV_MAX_AGGREGATION_BYTES) can be transmitted. But the
outgoing MTU might be too small for these 512 bytes and the aggregation
size must be adjusted in this case. Otherwise, the aggregates will cause
unnecessary packet loss.

For now, the non-aggregated packet length is not touched.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a20d7f3004c1..7b4f659612a3 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -23,6 +23,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
@@ -444,22 +445,26 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 			    const struct batadv_forw_packet *forw_packet)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	int aggregated_bytes = forw_packet->packet_len + packet_len;
+	unsigned int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct batadv_hard_iface *primary_if = NULL;
 	u8 packet_num = forw_packet->num_packets;
 	bool res = false;
 	unsigned long aggregation_end_time;
+	unsigned int max_bytes;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)forw_packet->skb->data;
 	aggregation_end_time = send_time;
 	aggregation_end_time += msecs_to_jiffies(BATADV_MAX_AGGREGATION_MS);
 
+	max_bytes = min_t(unsigned int, if_outgoing->net_dev->mtu,
+			  BATADV_MAX_AGGREGATION_BYTES);
+
 	/* we can aggregate the current packet to this aggregated packet
 	 * if:
 	 *
 	 * - the send time is within our MAX_AGGREGATION_MS time
 	 * - the resulting packet won't be bigger than
-	 *   MAX_AGGREGATION_BYTES
+	 *   MAX_AGGREGATION_BYTES and MTU of the outgoing interface
 	 * - the number of packets is lower than MAX_AGGREGATION_PACKETS
 	 * otherwise aggregation is not possible
 	 */
@@ -467,7 +472,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	    !time_after_eq(aggregation_end_time, forw_packet->send_time))
 		return false;
 
-	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
+	if (aggregated_bytes > max_bytes)
 		return false;
 
 	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
@@ -552,9 +557,9 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	unsigned int skb_size;
 	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 
-	if (atomic_read(&bat_priv->aggregated_ogms) &&
-	    packet_len < BATADV_MAX_AGGREGATION_BYTES)
-		skb_size = BATADV_MAX_AGGREGATION_BYTES;
+	if (atomic_read(&bat_priv->aggregated_ogms))
+		skb_size = max_t(unsigned int, BATADV_MAX_AGGREGATION_BYTES,
+				 packet_len);
 	else
 		skb_size = packet_len;
 
-- 
2.39.5


