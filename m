Return-Path: <netdev+bounces-174673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6891A5FC71
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B4A179BEC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77B26A1B8;
	Thu, 13 Mar 2025 16:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F566EB7C
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884332; cv=none; b=WfPf4alWXH4/Y6j6mBZ2g+wHAFV7yaqkOXLFz8J+gs69LhvG/IL2cDftZHq4DPpOFtSJZ4T4GxZkM4JaKzjjN2xnRRP4FWUc2qe6E26Qz/CFu5hvrPjJs+lzNhcCFwub+mTEhgMMkrycF1twqqLELgWrXdkjPUkY11LMxz2tbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884332; c=relaxed/simple;
	bh=kMPZ5VbKs3iY6uVBrjToKJGsqfhJiWHURSa52yeCWxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVRxYtV9pyy8UGxncueTNwWskrO2yBbV2lpc7UVcywVOk/4KRMwGlJMu8kN/G2UHc4h0SxRUgBNlqxwIH3Q7F/1mCJPjnC/RkGltvXGJBVDhajdW+eSTtlwfykrjKBXFa5OaafHFLDOwRwbR83ZoA1851sEklw2dl9TPSnJWzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300fa272413901a38a4bC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 06C94FA14B;
	Thu, 13 Mar 2025 17:45:29 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 07/10] batman-adv: Switch to bitmap helper for aggregation handling
Date: Thu, 13 Mar 2025 17:45:16 +0100
Message-Id: <20250313164519.72808-8-sw@simonwunderlich.de>
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

The aggregation code duplicates code which already exists in the the bitops
and bitmap helper. By switching to the bitmap helpers, operating on larger
aggregations becomes possible without touching the different portions of
the code which read/modify direct_link_flags.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 19 +++++++++----------
 net/batman-adv/main.h       |  1 +
 net/batman-adv/types.h      |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b715f7343ffd..87c1af540457 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -355,7 +355,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 		/* we might have aggregated direct link packets with an
 		 * ordinary base packet
 		 */
-		if (forw_packet->direct_link_flags & BIT(packet_num) &&
+		if (test_bit(packet_num, forw_packet->direct_link_flags) &&
 		    forw_packet->if_incoming == hard_iface)
 			batadv_ogm_packet->flags |= BATADV_DIRECTLINK;
 		else
@@ -460,6 +460,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	 * - the send time is within our MAX_AGGREGATION_MS time
 	 * - the resulting packet won't be bigger than
 	 *   MAX_AGGREGATION_BYTES
+	 * - the number of packets is lower than MAX_AGGREGATION_PACKETS
 	 * otherwise aggregation is not possible
 	 */
 	if (!time_before(send_time, forw_packet->send_time) ||
@@ -469,7 +470,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
 		return false;
 
-	if (packet_num >= BITS_PER_TYPE(forw_packet->direct_link_flags))
+	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
 		return false;
 
 	/* packet is not leaving on the same interface. */
@@ -578,12 +579,13 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	memcpy(skb_buff, packet_buff, packet_len);
 
 	forw_packet_aggr->own = own_packet;
-	forw_packet_aggr->direct_link_flags = BATADV_NO_FLAGS;
+	bitmap_zero(forw_packet_aggr->direct_link_flags,
+		    BATADV_MAX_AGGREGATION_PACKETS);
 	forw_packet_aggr->send_time = send_time;
 
 	/* save packet direct link flag status */
 	if (direct_link)
-		forw_packet_aggr->direct_link_flags |= 1;
+		set_bit(0, forw_packet_aggr->direct_link_flags);
 
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
 			  batadv_iv_send_outstanding_bat_ogm_packet);
@@ -596,17 +598,14 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 				    const unsigned char *packet_buff,
 				    int packet_len, bool direct_link)
 {
-	unsigned long new_direct_link_flag;
-
 	skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
 	forw_packet_aggr->packet_len += packet_len;
 	forw_packet_aggr->num_packets++;
 
 	/* save packet direct link flag status */
-	if (direct_link) {
-		new_direct_link_flag = BIT(forw_packet_aggr->num_packets);
-		forw_packet_aggr->direct_link_flags |= new_direct_link_flag;
-	}
+	if (direct_link)
+		set_bit(forw_packet_aggr->num_packets,
+			forw_packet_aggr->direct_link_flags);
 }
 
 /**
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index c08c96b5b8b1..67af435ee04e 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -104,6 +104,7 @@
  */
 #define BATADV_TQ_SIMILARITY_THRESHOLD 50
 
+#define BATADV_MAX_AGGREGATION_PACKETS 32
 #define BATADV_MAX_AGGREGATION_BYTES 512
 #define BATADV_MAX_AGGREGATION_MS 100
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b222f8a80ed9..0ca0fc072fc9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2139,7 +2139,7 @@ struct batadv_forw_packet {
 	u16 packet_len;
 
 	/** @direct_link_flags: direct link flags for aggregated OGM packets */
-	u32 direct_link_flags;
+	DECLARE_BITMAP(direct_link_flags, BATADV_MAX_AGGREGATION_PACKETS);
 
 	/** @num_packets: counter for aggregated OGMv1 packets */
 	u8 num_packets;
-- 
2.39.5


