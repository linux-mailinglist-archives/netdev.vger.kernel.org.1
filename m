Return-Path: <netdev+bounces-199225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3AEADF7D6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02441189EA39
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06F21CC64;
	Wed, 18 Jun 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF0JNqrZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AF21CC60
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279145; cv=none; b=kRnZgBSjgERVzR1snuOh/vKZu5UzQgrYbvONPD3H7aSYAXOZez/4ENf5CcVfBS1l/hHsWakviqnmxbjnDYbZIjgoKKBZ30d5kqMe5FtG1VD/JCV9qullvwvg6y1kray5L3MxXSg4+keuK7rqWEfVhtAVTi4eNVJjJSiQsNctgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279145; c=relaxed/simple;
	bh=Q8DVZ6XvS2TayI8+jzAQfxBbioFVBOKNPB6ywvcdgtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwvKGBfcvIQvEZOC2mTvjTEU0KUU45Na27KsOWKwQAPACk8F/02338VA/cY6vbIhPnx6ndC3xV3dL3VNywYLjYPsm9R1NBOuGBgF7nP+1NRBdQwRgDI2Za3iWagIPPG5GKODumc+e0CDp8q8ytW/EgwdSjD6l0BewqLFzKBETwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF0JNqrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0118AC4CEF0;
	Wed, 18 Jun 2025 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279144;
	bh=Q8DVZ6XvS2TayI8+jzAQfxBbioFVBOKNPB6ywvcdgtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pF0JNqrZce19tiEc+Qp6gCS2mW9tbAs3CJEJW4aE1I+Fn4lLI5Z7t2oIobxJi/HKR
	 v5z452ItCiYYUUpHDRX4PQClN9mh1wFJBHzCjDhAMEmlcJZVAkXVBOsv39qhCkaO3q
	 lxejTLytJWbTJM/EsU2cs6o2Zdol/xuRIC2lDUr3sasjDUfHuA5c8/UqrhoC67KSgk
	 ebQhBwEumcKjsFcFRt2DMCbBVv7wag5pO/zlFcZUkTLbs9kyAaxDvdaAddOIko1dAk
	 Onkf04crJi9QWkWPiXlUP+qnMkN1awSWJZHivnMbbBIcDeQpyS16lQzM/ZO5H5SHcG
	 3fTi4VPAAyJGA==
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
Subject: [PATCH net-next 03/10] eth: sfc: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:16 -0700
Message-ID: <20250618203823.1336156-4-kuba@kernel.org>
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
is purely factoring out the handling into a helper. One thing of
note that this is one of the two drivers which pays attention to
rss_context.

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - s/s32 rc/int rc/
v1: https://lore.kernel.org/20250617013954.427411-4-kuba@kernel.org
---
 drivers/net/ethernet/sfc/ethtool_common.h |   2 +
 drivers/net/ethernet/sfc/ethtool.c        |   1 +
 drivers/net/ethernet/sfc/ethtool_common.c | 104 ++++++++++++----------
 3 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.h b/drivers/net/ethernet/sfc/ethtool_common.h
index fc52e891637d..24db4fccbe78 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.h
+++ b/drivers/net/ethernet/sfc/ethtool_common.h
@@ -49,6 +49,8 @@ int efx_ethtool_get_rxfh(struct net_device *net_dev,
 int efx_ethtool_set_rxfh(struct net_device *net_dev,
 			 struct ethtool_rxfh_param *rxfh,
 			 struct netlink_ext_ack *extack);
+int efx_ethtool_get_rxfh_fields(struct net_device *net_dev,
+				struct ethtool_rxfh_fields *info);
 int efx_ethtool_create_rxfh_context(struct net_device *net_dev,
 				    struct ethtool_rxfh_context *ctx,
 				    const struct ethtool_rxfh_param *rxfh,
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index afbedca63b29..23c6a7df78d0 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -268,6 +268,7 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
+	.get_rxfh_fields	= efx_ethtool_get_rxfh_fields,
 	.create_rxfh_context	= efx_ethtool_create_rxfh_context,
 	.modify_rxfh_context	= efx_ethtool_modify_rxfh_context,
 	.remove_rxfh_context	= efx_ethtool_remove_rxfh_context,
diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 2d734496733f..823263969f92 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -800,6 +800,61 @@ static int efx_ethtool_get_class_rule(struct efx_nic *efx,
 	return rc;
 }
 
+int efx_ethtool_get_rxfh_fields(struct net_device *net_dev,
+				struct ethtool_rxfh_fields *info)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+	struct efx_rss_context_priv *ctx;
+	__u64 data;
+	int rc = 0;
+
+	ctx = &efx->rss_context.priv;
+
+	mutex_lock(&net_dev->ethtool->rss_lock);
+	if (info->rss_context) {
+		ctx = efx_find_rss_context_entry(efx, info->rss_context);
+		if (!ctx) {
+			rc = -ENOENT;
+			goto out_unlock;
+		}
+	}
+
+	data = 0;
+	if (!efx_rss_active(ctx)) /* No RSS */
+		goto out_setdata_unlock;
+
+	switch (info->flow_type) {
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
+		if (ctx->rx_hash_udp_4tuple)
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
+out_setdata_unlock:
+	info->data = data;
+out_unlock:
+	mutex_unlock(&net_dev->ethtool->rss_lock);
+	return rc;
+}
+
 int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 			  struct ethtool_rxnfc *info, u32 *rule_locs)
 {
@@ -812,55 +867,6 @@ int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 		info->data = efx->n_rx_channels;
 		return 0;
 
-	case ETHTOOL_GRXFH: {
-		struct efx_rss_context_priv *ctx = &efx->rss_context.priv;
-		__u64 data;
-
-		mutex_lock(&net_dev->ethtool->rss_lock);
-		if (info->flow_type & FLOW_RSS && info->rss_context) {
-			ctx = efx_find_rss_context_entry(efx, info->rss_context);
-			if (!ctx) {
-				rc = -ENOENT;
-				goto out_unlock;
-			}
-		}
-
-		data = 0;
-		if (!efx_rss_active(ctx)) /* No RSS */
-			goto out_setdata_unlock;
-
-		switch (info->flow_type & ~FLOW_RSS) {
-		case UDP_V4_FLOW:
-		case UDP_V6_FLOW:
-			if (ctx->rx_hash_udp_4tuple)
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
-out_setdata_unlock:
-		info->data = data;
-out_unlock:
-		mutex_unlock(&net_dev->ethtool->rss_lock);
-		return rc;
-	}
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = efx_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
-- 
2.49.0


