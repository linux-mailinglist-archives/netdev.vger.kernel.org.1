Return-Path: <netdev+bounces-110953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEAF92F1B6
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640D21C20DF8
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15171A071A;
	Thu, 11 Jul 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDT6rp4X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9861A0715
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735642; cv=none; b=nTbwyLTC1s263PjI23/keIGJPOWmowMyQE0F4+zdR9MH9ZEmfhwWeMi/nI0S2FwkEs8y+fXPQknA8p48RQXODG2pgtsDLaT3z8JmQJcI7eAeSS260DZ+4p1xTPASCuEy0VzICEX2DEZ3ji1d5hu7Ee2/vXSVpoOqrN5afHUrESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735642; c=relaxed/simple;
	bh=+xiWiPMg1O1fB5qkJ5w8F50SzQ49sTuGFURMZaDWHzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4Mk0uyxKFddLafJayhi/zUveTS1yX3qTbe17JojFCMJONGdDGd0FIVOAey1jT66fqYhJ7NPZFR+9h2c9SwKNTrZ5gsn8xvF7h8B2KLwpd1hfzwS5DvdNWWBIRB8Ft2CSRK1GKJzIhnvugWBn4FEyY0flpLLi223Nf+Nrdgaq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDT6rp4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08309C4AF0A;
	Thu, 11 Jul 2024 22:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735642;
	bh=+xiWiPMg1O1fB5qkJ5w8F50SzQ49sTuGFURMZaDWHzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDT6rp4XtGIt3iLgRXPzuVy/vA6gt/1AlFZQ794+7gsohllvtk5v9pn96sdIhyzw/
	 x+lART7pIV3YB0vi3yIEv29hRPIvMVLgzhwl/TgoC4ykjWZMxDSZasTENUZOJH9j+Q
	 3lamGBVtCtgeEWOThJ+izhhjgOgP8buyZgFy5O1x2rOcTSY22e7LkngYV1eANePlvk
	 PdrriTHJfBo7Uylsdop+7ZAgZigQxArHzoX7QDODey5fz8WJQjKOEYZjngLNa13hCJ
	 +8LScFifAJSIzr7NByBRHs1J2rnY1vSs7imVY+yzQQynlTjjgCyFeSiI8oWe1XoE2b
	 amr3mbawQhlvQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
Date: Thu, 11 Jul 2024 15:07:06 -0700
Message-ID: <20240711220713.283778-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
References: <20240711220713.283778-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new ethtool ops for RSS context management. The conversion
is pretty straightforward cut / paste of the right chunks of the
combined handler. Main change is that we let the core pick the IDs
(bitmap will be removed separately for ease of review), so we need
to tell the core when we lose a context.
Since the new API passes rxfh as const, change bnxt_modify_rss()
to also take const.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 119 +++++++++++-------
 2 files changed, 75 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e8965cf743fc..bd087c85af5c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10257,6 +10257,7 @@ static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 			netdev_err(bp->dev, "Failed to restore RSS ctx %d\n",
 				   rss_ctx->index);
 			bnxt_del_one_rss_ctx(bp, rss_ctx, true);
+			ethtool_rxfh_context_lost(bp->dev, rss_ctx->index);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 846a19b5f58d..afbb7546ee14 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1841,7 +1841,7 @@ static int bnxt_get_rxfh(struct net_device *dev,
 }
 
 static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
-			    struct ethtool_rxfh_param *rxfh)
+			    const struct ethtool_rxfh_param *rxfh)
 {
 	if (rxfh->key) {
 		if (rss_ctx) {
@@ -1866,44 +1866,35 @@ static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	}
 }
 
-static int bnxt_set_rxfh_context(struct bnxt *bp,
-				 struct ethtool_rxfh_param *rxfh,
-				 struct netlink_ext_ack *extack)
+static int bnxt_rxfh_context_check(struct bnxt *bp,
+				   struct netlink_ext_ack *extack)
 {
-	u32 *rss_context = &rxfh->rss_context;
-	struct bnxt_rss_ctx *rss_ctx;
-	struct bnxt_vnic_info *vnic;
-	bool modify = false;
-	bool delete;
-	int bit_id;
-	int rc;
-
 	if (!BNXT_SUPPORTS_MULTI_RSS_CTX(bp)) {
 		NL_SET_ERR_MSG_MOD(extack, "RSS contexts not supported");
 		return -EOPNOTSUPP;
 	}
 
-	delete = *rss_context != ETH_RXFH_CONTEXT_ALLOC && rxfh->rss_delete;
-	if (!netif_running(bp->dev) && !delete) {
+	if (!netif_running(bp->dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to set RSS contexts when interface is down");
 		return -EAGAIN;
 	}
 
-	if (*rss_context != ETH_RXFH_CONTEXT_ALLOC) {
-		rss_ctx = bnxt_get_rss_ctx_from_index(bp, *rss_context);
-		if (!rss_ctx) {
-			NL_SET_ERR_MSG_FMT_MOD(extack, "RSS context %u not found",
-					       *rss_context);
-			return -EINVAL;
-		}
-		if (delete) {
-			bnxt_del_one_rss_ctx(bp, rss_ctx, true);
-			return 0;
-		}
-		modify = true;
-		vnic = &rss_ctx->vnic;
-		goto modify_context;
-	}
+	return 0;
+}
+
+static int bnxt_create_rxfh_context(struct net_device *dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_rss_ctx *rss_ctx;
+	struct bnxt_vnic_info *vnic;
+	int rc;
+
+	rc = bnxt_rxfh_context_check(bp, extack);
+	if (rc)
+		return rc;
 
 	if (bp->num_rss_ctx >= BNXT_MAX_ETH_RSS_CTX) {
 		NL_SET_ERR_MSG_FMT_MOD(extack, "Out of RSS contexts, maximum %u",
@@ -1911,6 +1902,11 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
 		return -EINVAL;
 	}
 
+	if (test_and_set_bit(rxfh->rss_context, bp->rss_ctx_bmap)) {
+		NL_SET_ERR_MSG_MOD(extack, "Context ID conflict");
+		return -EINVAL;
+	}
+
 	if (!bnxt_rfs_capable(bp, true)) {
 		NL_SET_ERR_MSG_MOD(extack, "Out hardware resources");
 		return -ENOMEM;
@@ -1945,33 +1941,65 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
 		NL_SET_ERR_MSG_MOD(extack, "Unable to setup TPA");
 		goto out;
 	}
-modify_context:
 	bnxt_modify_rss(bp, rss_ctx, rxfh);
 
-	if (modify)
-		return bnxt_hwrm_vnic_rss_cfg_p5(bp, vnic);
-
 	rc = __bnxt_setup_vnic_p5(bp, vnic);
 	if (rc) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to setup TPA");
 		goto out;
 	}
 
-	bit_id = bitmap_find_free_region(bp->rss_ctx_bmap,
-					 BNXT_RSS_CTX_BMAP_LEN, 0);
-	if (bit_id < 0) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	rss_ctx->index = (u16)bit_id;
-	*rss_context = rss_ctx->index;
-
+	rss_ctx->index = rxfh->rss_context;
 	return 0;
 out:
 	bnxt_del_one_rss_ctx(bp, rss_ctx, true);
 	return rc;
 }
 
+static int bnxt_modify_rxfh_context(struct net_device *dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_rss_ctx *rss_ctx;
+	int rc;
+
+	rc = bnxt_rxfh_context_check(bp, extack);
+	if (rc)
+		return rc;
+
+	rss_ctx = bnxt_get_rss_ctx_from_index(bp, rxfh->rss_context);
+	if (!rss_ctx) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "RSS context %u not found",
+				       rxfh->rss_context);
+		return -EINVAL;
+	}
+
+	bnxt_modify_rss(bp, rss_ctx, rxfh);
+
+	return bnxt_hwrm_vnic_rss_cfg_p5(bp, &rss_ctx->vnic);
+}
+
+static int bnxt_remove_rxfh_context(struct net_device *dev,
+				    struct ethtool_rxfh_context *ctx,
+				    u32 rss_context,
+				    struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_rss_ctx *rss_ctx;
+
+	rss_ctx = bnxt_get_rss_ctx_from_index(bp, rss_context);
+	if (!rss_ctx) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "RSS context %u not found",
+				       rss_context);
+		return -EINVAL;
+	}
+
+	bnxt_del_one_rss_ctx(bp, rss_ctx, true);
+	return 0;
+}
+
 static int bnxt_set_rxfh(struct net_device *dev,
 			 struct ethtool_rxfh_param *rxfh,
 			 struct netlink_ext_ack *extack)
@@ -1982,9 +2010,6 @@ static int bnxt_set_rxfh(struct net_device *dev,
 	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->rss_context)
-		return bnxt_set_rxfh_context(bp, rxfh, extack);
-
 	bnxt_modify_rss(bp, NULL, rxfh);
 
 	bnxt_clear_usr_fltrs(bp, false);
@@ -5277,6 +5302,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
 const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.cap_rss_ctx_supported		= 1,
+	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS_IRQ |
@@ -5314,6 +5340,9 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_rxfh_key_size      = bnxt_get_rxfh_key_size,
 	.get_rxfh               = bnxt_get_rxfh,
 	.set_rxfh		= bnxt_set_rxfh,
+	.create_rxfh_context	= bnxt_create_rxfh_context,
+	.modify_rxfh_context	= bnxt_modify_rxfh_context,
+	.remove_rxfh_context	= bnxt_remove_rxfh_context,
 	.flash_device		= bnxt_flash_device,
 	.get_eeprom_len         = bnxt_get_eeprom_len,
 	.get_eeprom             = bnxt_get_eeprom,
-- 
2.45.2


