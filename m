Return-Path: <netdev+bounces-108632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3A924C57
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E29B2171C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894EF17DA3E;
	Tue,  2 Jul 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkUVs03J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652ED17DA3B
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964103; cv=none; b=eWT1uX0OI7PZnM1QoiqKiuhsjRRliYsmlHko+DLbM9TGkh3TG8FDzcuq2A/0T0dyViN4awoDzdDiMhozvfDwAXxzXoKSXfwunuRzdU0ryJk6Rz+egNmOD9q84tqkLkQZtPB38NnizWrEI6SwMZHmcCfDG9sZAj2+QDR4Zgj8ZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964103; c=relaxed/simple;
	bh=+HAB3SVTW9l/ta/LNWJ+dX1NPEQD6s8tgp8TG9EXgSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZXJgsAuJ/U2zH+A5ir9/VfdfmxmKUCOdQ3ugdS4rvuAFmjqPSgLh7OsmlEgKKIkXCjlx0VMUhe7peyHVFtEvo42ZOx01SxPmUWMVt7w+VxKsnQ/ObJVZRUE/YK64dY88Qr3Ns4ukfl19wmrJ/O8fEDhwzR2ie5/MJ68n1LedVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkUVs03J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF5CC4AF0F;
	Tue,  2 Jul 2024 23:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964102;
	bh=+HAB3SVTW9l/ta/LNWJ+dX1NPEQD6s8tgp8TG9EXgSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkUVs03J1gges4hjkBTRj9TA9ZSIfpGIUZFTKwYcaUbLzAAjMtgEnAoZVZmuVN/4a
	 zTUpAG3NiXvAMoqGoBIxC0/45ozkRTgp0ZXznBQrk7Nh9YvKnd1uSQ8QIhK0Vo1ZaP
	 yGtfmneLMKMMjwIeYQq2K3Zx+vXfV/WOmca2cdqAQmnyZeSHWd2L9TV+a+Hip0AJ/W
	 q5QUJZ8O6XCaum6ntceuP4Ew9UhyVYcPUKy0vHfqe3doTUTGUvgXLecencRle2wg7h
	 xW8+Pz72Bwu4T6jvTqCaqBu+UwsCCJhCHsJj/h0FrB6qpd3ZWQMdoAwuDgw8+UoytU
	 vPgnEpHgMXVrg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
Date: Tue,  2 Jul 2024 16:47:50 -0700
Message-ID: <20240702234757.4188344-6-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702234757.4188344-1-kuba@kernel.org>
References: <20240702234757.4188344-1-kuba@kernel.org>
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
index ab6dae416532..3dc43c263b91 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10242,6 +10242,7 @@ static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 			netdev_err(bp->dev, "Failed to restore RSS ctx %d\n",
 				   rss_ctx->index);
 			bnxt_del_one_rss_ctx(bp, rss_ctx, true);
+			ethtool_rxfh_context_lost(bp->dev, rss_ctx->index);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 0a7524cba5c3..a7f71ebca2fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1835,7 +1835,7 @@ static int bnxt_get_rxfh(struct net_device *dev,
 }
 
 static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
-			    struct ethtool_rxfh_param *rxfh)
+			    const struct ethtool_rxfh_param *rxfh)
 {
 	if (rxfh->key) {
 		if (rss_ctx) {
@@ -1860,44 +1860,35 @@ static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
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
@@ -1905,6 +1896,11 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
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
@@ -1939,33 +1935,65 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
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
@@ -1976,9 +2004,6 @@ static int bnxt_set_rxfh(struct net_device *dev,
 	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->rss_context)
-		return bnxt_set_rxfh_context(bp, rxfh, extack);
-
 	bnxt_modify_rss(bp, NULL, rxfh);
 
 	bnxt_clear_usr_fltrs(bp, false);
@@ -5271,6 +5296,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
 const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.cap_rss_ctx_supported		= 1,
+	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS_IRQ |
@@ -5308,6 +5334,9 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


