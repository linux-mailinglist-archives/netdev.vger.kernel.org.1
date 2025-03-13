Return-Path: <netdev+bounces-174674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 229BEA5FC76
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FBD7A2AC9
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2726A1D4;
	Thu, 13 Mar 2025 16:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69626A1A9
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884333; cv=none; b=NNgA1VLFdTr0tDZ4p3EDgq7XMXtuVQ+D4UAsQC8quW7PmumhzkVkju6nM23EdzitRhcbjnitxhfQPwzVQWR45I7tP+xXjDrN+dBE4bmYJl+QK2MSC98qX3SNAeGR/Rn3sw8e0DXhcDrWoL1sfsVYEaAcovZ50C6v/jBummawkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884333; c=relaxed/simple;
	bh=1AtYt7qCwKggQx5XOSY/xgkNKSswF2/UvXGlnzzg5Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svJyRXqVEgL3LlODNdHbDXA11LqYLk2i2jZNkChQO6dXy3JSp/u+7CMXW8ibMDq9Qt+GmiZJP0GYFQWfWmiJeJsah/WNjtJBPzLvH2MroeQeDrCJpqk5iNL8EzzUKDwuom2cDZP4ggbscsFryrNLi7tDZzmea0BOkdg8ZNpQUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300fA272413901A38A4BC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id DCA3BFA44A;
	Thu, 13 Mar 2025 17:45:29 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 08/10] batman-adv: Use actual packet count for aggregated packets
Date: Thu, 13 Mar 2025 17:45:17 +0100
Message-Id: <20250313164519.72808-9-sw@simonwunderlich.de>
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

The batadv_forw_packet->num_packets didn't store the number of packets but
the the number of packets - 1. This didn't had any effects on the actual
handling of aggregates but can easily be a source of confusion when reading
the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++--
 net/batman-adv/send.c       | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 87c1af540457..a20d7f3004c1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -446,7 +446,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct batadv_hard_iface *primary_if = NULL;
-	u8 packet_num = forw_packet->num_packets + 1;
+	u8 packet_num = forw_packet->num_packets;
 	bool res = false;
 	unsigned long aggregation_end_time;
 
@@ -600,12 +600,13 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 {
 	skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
 	forw_packet_aggr->packet_len += packet_len;
-	forw_packet_aggr->num_packets++;
 
 	/* save packet direct link flag status */
 	if (direct_link)
 		set_bit(forw_packet_aggr->num_packets,
 			forw_packet_aggr->direct_link_flags);
+
+	forw_packet_aggr->num_packets++;
 }
 
 /**
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 85478fdc8ce8..735ac8077821 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -532,7 +532,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 	forw_packet->queue_left = queue_left;
 	forw_packet->if_incoming = if_incoming;
 	forw_packet->if_outgoing = if_outgoing;
-	forw_packet->num_packets = 0;
+	forw_packet->num_packets = 1;
 
 	return forw_packet;
 
-- 
2.39.5


