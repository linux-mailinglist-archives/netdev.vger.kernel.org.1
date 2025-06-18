Return-Path: <netdev+bounces-199224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478EADF7D5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8A97A4623
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117921CA03;
	Wed, 18 Jun 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfpZWq2C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221C21C9F6
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279144; cv=none; b=pp/OwJuCJqOZFxi2Zuw9025hsRWnhM0oWCy9TABOamUPxjb7PfTfVZJUxDPaNU8vX9N5GvQi7vCxzpg5UFcy/sM8GsSQf04eQJs8LaSqxxwLZahYGDE7gFt5yFeHrWh5LcsyVjeQgoV0L224iYQ1LGu9qiTo6q4ZhVkmNyvYzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279144; c=relaxed/simple;
	bh=U9W9ZVJWwrQK8nfLahsldUyDiAHVZ8/0aulygBWJ9MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0NnZhEOKp+GWtz+LkcKADmlg5QmZMI1FkqwTsjRz1UZ8Bznp8taJHQ11cClVjkStDXCSnvglTEQhmXAxEwOe44slvADidGYxf6qVlR81bcrso2wfw7N33TTYHr32GSjFuPFvrHSWM1uWTbgXxmT61oHLQt7POlRZMKV0seWicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfpZWq2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4074FC4CEEF;
	Wed, 18 Jun 2025 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279143;
	bh=U9W9ZVJWwrQK8nfLahsldUyDiAHVZ8/0aulygBWJ9MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfpZWq2CZvzacFUAEFkIrS73jsTA/mVoosc6XO9juAZ8iwYUcVDFQBDMPW01Av50D
	 NHumkLWRtoFO5P7CqOoKdoJgOFUerZQyAwwTy1LbMCelESOcaLjc+7oFYjL0UtDttp
	 /r7w92N39oxFgSwOwWgj7Nq0WIITQMupz2CXrjTZnlVREnbGdebqNRGKo+gEd6RKwb
	 +I5c0yLCCB1pZ5XyO2KvO40leT64X1NdhZpfHtvloc8a2Rygy5j70hD+Q6VrqADltj
	 8u1KlyJVMtiQCr+8k3yp72M523A3zX4jPSInuXoT5DGQ38BSJOdFj2Zg7dFi20dfD0
	 EjOFl/U7bM14Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	cai.huoqing@linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	louis.peens@corigine.com,
	mbloch@nvidia.com,
	manishc@marvell.com,
	ecree.xilinx@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/10] eth: sfc: siena: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:15 -0700
Message-ID: <20250618203823.1336156-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203823.1336156-1-kuba@kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
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
v2:
 - fix typo in the subject
v1: https://lore.kernel.org/20250617013954.427411-3-kuba@kernel.org
---
 .../net/ethernet/sfc/siena/ethtool_common.h   |  2 +
 drivers/net/ethernet/sfc/siena/ethtool.c      |  1 +
 .../net/ethernet/sfc/siena/ethtool_common.c   | 77 ++++++++++---------
 3 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.h b/drivers/net/ethernet/sfc/siena/ethtool_common.h
index d674bab0f65b..278d69e920d9 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.h
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.h
@@ -46,6 +46,8 @@ int efx_siena_ethtool_get_rxfh(struct net_device *net_dev,
 int efx_siena_ethtool_set_rxfh(struct net_device *net_dev,
 			       struct ethtool_rxfh_param *rxfh,
 			       struct netlink_ext_ack *extack);
+int efx_siena_ethtool_get_rxfh_fields(struct net_device *net_dev,
+				      struct ethtool_rxfh_fields *info);
 int efx_siena_ethtool_reset(struct net_device *net_dev, u32 *flags);
 int efx_siena_ethtool_get_module_eeprom(struct net_device *net_dev,
 					struct ethtool_eeprom *ee,
diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
index c5ad84db9613..994909789bfe 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool.c
@@ -264,6 +264,7 @@ const struct ethtool_ops efx_siena_ethtool_ops = {
 	.get_rxfh_key_size	= efx_siena_ethtool_get_rxfh_key_size,
 	.get_rxfh		= efx_siena_ethtool_get_rxfh,
 	.set_rxfh		= efx_siena_ethtool_set_rxfh,
+	.get_rxfh_fields	= efx_siena_ethtool_get_rxfh_fields,
 	.get_ts_info		= efx_ethtool_get_ts_info,
 	.get_module_info	= efx_siena_ethtool_get_module_info,
 	.get_module_eeprom	= efx_siena_ethtool_get_module_eeprom,
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index eeee676fdca7..47cd16a113cf 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -801,6 +801,46 @@ static int efx_ethtool_get_class_rule(struct efx_nic *efx,
 	return rc;
 }
 
+int efx_siena_ethtool_get_rxfh_fields(struct net_device *net_dev,
+				      struct ethtool_rxfh_fields *info)
+{
+	struct efx_nic *efx = netdev_priv(net_dev);
+	__u64 data;
+
+	data = 0;
+	if (!efx_rss_active(&efx->rss_context)) /* No RSS */
+		goto out_setdata;
+
+	switch (info->flow_type) {
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
+		if (efx->rss_context.rx_hash_udp_4tuple)
+			data = (RXH_L4_B_0_1 | RXH_L4_B_2_3 |
+				RXH_IP_SRC | RXH_IP_DST);
+		else
+			data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+		data = (RXH_L4_B_0_1 | RXH_L4_B_2_3 |
+			RXH_IP_SRC | RXH_IP_DST);
+		break;
+	case SCTP_V4_FLOW:
+	case SCTP_V6_FLOW:
+	case AH_ESP_V4_FLOW:
+	case AH_ESP_V6_FLOW:
+	case IPV4_FLOW:
+	case IPV6_FLOW:
+		data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	default:
+		break;
+	}
+out_setdata:
+	info->data = data;
+	return 0;
+}
+
 int efx_siena_ethtool_get_rxnfc(struct net_device *net_dev,
 				struct ethtool_rxnfc *info, u32 *rule_locs)
 {
@@ -813,43 +853,6 @@ int efx_siena_ethtool_get_rxnfc(struct net_device *net_dev,
 		info->data = efx->n_rx_channels;
 		return 0;
 
-	case ETHTOOL_GRXFH: {
-		__u64 data;
-
-		data = 0;
-		if (!efx_rss_active(&efx->rss_context)) /* No RSS */
-			goto out_setdata;
-
-		switch (info->flow_type) {
-		case UDP_V4_FLOW:
-		case UDP_V6_FLOW:
-			if (efx->rss_context.rx_hash_udp_4tuple)
-				data = (RXH_L4_B_0_1 | RXH_L4_B_2_3 |
-					RXH_IP_SRC | RXH_IP_DST);
-			else
-				data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		case TCP_V4_FLOW:
-		case TCP_V6_FLOW:
-			data = (RXH_L4_B_0_1 | RXH_L4_B_2_3 |
-				RXH_IP_SRC | RXH_IP_DST);
-			break;
-		case SCTP_V4_FLOW:
-		case SCTP_V6_FLOW:
-		case AH_ESP_V4_FLOW:
-		case AH_ESP_V6_FLOW:
-		case IPV4_FLOW:
-		case IPV6_FLOW:
-			data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		default:
-			break;
-		}
-out_setdata:
-		info->data = data;
-		return rc;
-	}
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = efx_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
-- 
2.49.0


