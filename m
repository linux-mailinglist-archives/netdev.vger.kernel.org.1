Return-Path: <netdev+bounces-197270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E926AD7FD4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499087AB659
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7421DE4FC;
	Fri, 13 Jun 2025 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezh/tMpF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730091DE884;
	Fri, 13 Jun 2025 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776091; cv=none; b=EjHgJwNc2ZYeyveh3+I9O7rjiC0fhtSR7LUdSw2oDPAdnWjtQ4qVgaxqJVtHk/mycKimOeE7zItAa87z4Y28SVg93KnPlT4m4/IKwoK56Z/+F+VEceB8gjNsxjQO88ebyu+UWHf7I8CMDqFx9YSaCzgML4qfJ6kwWQkAGQGSSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776091; c=relaxed/simple;
	bh=DxdKppymL/PIhFq67u/hOifSsa2/rVcZavandpvYWUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzBDoqblg9qC0lw+8svu3mrYx1B3FA6Y7Wo9Q0oxzw0gmfrRky62Iyhz1KBPK089m49tPaHVqbBK13oE+KVRn5hFrKwCqd2P9aRg3ZI8K4dxUI2x6OJZ1NkuBBezk6PKxSBApTc9weScLjt1Lfn/av8xHdWq7a0i1ZiySV1FqL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezh/tMpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FB1C4CEEA;
	Fri, 13 Jun 2025 00:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776091;
	bh=DxdKppymL/PIhFq67u/hOifSsa2/rVcZavandpvYWUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezh/tMpFhng8jS9u/M3Rez6fkiQK2j2oAT6ZRIUBVHIXCMiPX5i4VKTpOzKMGAP5N
	 /oUkvocGvF22bOColo0qyFv2zM2vs+jnBpAevkubiehFIeNaJM7pqf96jWbnPK3Zry
	 REfhetxkvXsk8eYfNadlLp6cu2nVE8gU8QBRZQExFrZC7vpON6op1VbtkTxFv7CgCA
	 ySHJ2ETOJJebnbRlHnxI6koMmmMGRe3qTJKe8+BtqNgw/FXojPiPmwKAe0cOW/qEh2
	 RYBO1EqNDEPJWm5PO+aiUiAQG6s4gUQhUg71KjHJbYxX0LDXdBgeVbphHIMMeWlVgY
	 4uUiaULEd3T/w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bharat@chelsio.com,
	benve@cisco.com,
	satishkh@cisco.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com,
	rosenp@gmail.com,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/6] eth: sfc: falcon: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 17:54:09 -0700
Message-ID: <20250613005409.3544529-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613005409.3544529-1-kuba@kernel.org>
References: <20250613005409.3544529-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").
This driver's RXFH config is read only / fixed so the conversion
is purely factoring out the handling into a helper.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/sfc/falcon/ethtool.c | 51 +++++++++++++----------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 04766448a545..6685e71ab13f 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -943,6 +943,33 @@ static int ef4_ethtool_get_class_rule(struct ef4_nic *efx,
 	return rc;
 }
 
+static int
+ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
+			    struct ethtool_rxfh_fields *info)
+{
+	struct ef4_nic *efx = netdev_priv(net_dev);
+	unsigned int min_revision = 0;
+
+	info->data = 0;
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+		info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		fallthrough;
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case AH_ESP_V4_FLOW:
+	case IPV4_FLOW:
+		info->data |= RXH_IP_SRC | RXH_IP_DST;
+		min_revision = EF4_REV_FALCON_B0;
+		break;
+	default:
+		break;
+	}
+	if (ef4_nic_rev(efx) < min_revision)
+		info->data = 0;
+	return 0;
+}
+
 static int
 ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 		      struct ethtool_rxnfc *info, u32 *rule_locs)
@@ -954,29 +981,6 @@ ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 		info->data = efx->n_rx_channels;
 		return 0;
 
-	case ETHTOOL_GRXFH: {
-		unsigned min_revision = 0;
-
-		info->data = 0;
-		switch (info->flow_type) {
-		case TCP_V4_FLOW:
-			info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			fallthrough;
-		case UDP_V4_FLOW:
-		case SCTP_V4_FLOW:
-		case AH_ESP_V4_FLOW:
-		case IPV4_FLOW:
-			info->data |= RXH_IP_SRC | RXH_IP_DST;
-			min_revision = EF4_REV_FALCON_B0;
-			break;
-		default:
-			break;
-		}
-		if (ef4_nic_rev(efx) < min_revision)
-			info->data = 0;
-		return 0;
-	}
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = ef4_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
@@ -1343,6 +1347,7 @@ const struct ethtool_ops ef4_ethtool_ops = {
 	.get_rxfh_indir_size	= ef4_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= ef4_ethtool_get_rxfh,
 	.set_rxfh		= ef4_ethtool_set_rxfh,
+	.get_rxfh_fields	= ef4_ethtool_get_rxfh_fields,
 	.get_module_info	= ef4_ethtool_get_module_info,
 	.get_module_eeprom	= ef4_ethtool_get_module_eeprom,
 	.get_link_ksettings	= ef4_ethtool_get_link_ksettings,
-- 
2.49.0


