Return-Path: <netdev+bounces-198377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80DADBE9D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909D116B983
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992D11C861F;
	Tue, 17 Jun 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5rrPSne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733781C84AA
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124398; cv=none; b=WES9SbR8QPpdYeVpAW0lkzfCaYxI1/WMCNNV/qMT5wbN7KGrtynX0urv7cnj2jrygbct4Uo5y0gR76w8cZM5znym6viVgisB1iEtkIiPd4+VcE6YRg0h7e6MMoXmsgKWhOHN1i6M30/MDoTYtwjrhIDkSOEjBt799CW39+C0uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124398; c=relaxed/simple;
	bh=q7yeQ3Kp5P7sVk46SH5M1+CK8aFzEjqPFW6CeFSqGl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmzTcg5jTw55h4aR0IF69PGjvv4FxxvT2J/XAA2rA1u8wfKViBwObVnlfmYW9EpWXYyEIrB0Dd9/vyS+DT8+fzClitspMiTyFUlgxe4Qm0iWSKpSyoUUqcfNtfJgbIhZyrTDc6AMxUbQFj36baQjtFBOj49AV4zB483hmu3OWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5rrPSne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0334C4CEF0;
	Tue, 17 Jun 2025 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124397;
	bh=q7yeQ3Kp5P7sVk46SH5M1+CK8aFzEjqPFW6CeFSqGl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5rrPSneWEy/blDI1uh1DXhRVFmBjDgvNYoaywNBAdJLYWz3UmUzxPfn90Bdmk0wW
	 VyvC4t78cvUU8cvNR0s1tz46ZElMl7eHoCv6l+QhtYTTuva9U28LkmLkvxLJ8HQ9TK
	 BOo5L9IRwxMOxcttBVMRAk8aq3rrUDFzDg6oLNJJc1WtcBfzDMYMZhqUtxORSTSDke
	 09Xy9Q+c/5JkFYzVZ+wa+bAV8WTn99WUzbCV4IrSn7qXmp3T1hAV+VNjjDqgodgfAC
	 1vPzimKuGaH5itEv0lBSKrTX8RZDLDkO6XSqu+t4amGeoppxtPSUywsPH34xci6+Ck
	 z/BlgpKMhfSNg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] eth: sfc: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:39:54 -0700
Message-ID: <20250617013954.427411-4-kuba@kernel.org>
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
is purely factoring out the handling into a helper. One thing of
note that this is one of the two drivers which pays attention to
rss_context.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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
index 2d734496733f..9e06317f80b6 100644
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
+	s32 rc = 0;
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


