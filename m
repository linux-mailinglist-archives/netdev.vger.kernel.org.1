Return-Path: <netdev+bounces-198375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC7ADBE9B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1083AFFDA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375E1A5BBE;
	Tue, 17 Jun 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7yp3IbM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1ED194A59
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124397; cv=none; b=H0+CJrvqRqKsjxUhUOdW06oE3O7g7XPBSbIXlbIGZGybxeS/REQXxLcpMMDhTLylfrgiSxk7vr4ER2WBM3LNwyf5YBh8Od0iijA2YPtM3wR3d9EwCy640h5GwjHBdGMRwtlD3zgRvw1deoHlQs6zU8z3R6bDEC2Vy0NShbYAvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124397; c=relaxed/simple;
	bh=7goIh+4lswZjWVoZhcqVqBM6+ec0HeagRxDcn7yoZIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9CnPoDytnTzRdvva0uagpuf1b7HfnNrZyzWt9ECP5slSBaNl9GhmI6/H6YucwG3CYy1gGuRokNFT2lB1bhTDiuqT7MCudaCkg2n8NcS1d8ogyT+B/BUyKT/bM9MFWNk7Zgc5dM0rgJ/aQ+is6Dfqns0YLMCwyoSw7vGGKrIKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7yp3IbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA36C4CEEF;
	Tue, 17 Jun 2025 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124397;
	bh=7goIh+4lswZjWVoZhcqVqBM6+ec0HeagRxDcn7yoZIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7yp3IbMZ9zC2IuGC3BZ8GsCWGnDOaEQ/3FSJBFeV06kPRFisDwb9EMXQzmLZOCvN
	 Od5Lh2CKR777vLmCGa5FPA07BqVKB7/2Q5CFnWMDj8Bc8wa+8ypWj3wcKQdjA9e2I6
	 FJa4ZRtPt/d7lwrzcKh0oUWIxueCz8zsy3ZXLG/k2+AdczsTepV8JgRwZomFS29qeg
	 hWKbTjsgTjxop390v5f7ZhL3XfoUO2HbevejIeFNCx9DNE0qCrUOASq0zIcw0pYtHz
	 uNXHPTRIc3vUIZvwb95TJpKK0xgIaeLzhYpW/+exYZgf7IOsFVCZoNT+0Z8WeIT0u1
	 cwnejZR88qmzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] eth: sfc: falcon: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:39:52 -0700
Message-ID: <20250617013954.427411-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617013954.427411-1-kuba@kernel.org>
References: <20250617013954.427411-1-kuba@kernel.org>
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

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
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


