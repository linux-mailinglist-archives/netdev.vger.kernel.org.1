Return-Path: <netdev+bounces-108638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C7924C5D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58561F2372F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660871ABC2E;
	Tue,  2 Jul 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFabid1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AE17A58B
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964106; cv=none; b=hoV3VZDRdizk45KzjtbrXMqrzko62dA+8rVSoNp0U3582TVSlf8YBz8AkWgwOIX6KCEkz05xUWR+DpQvFsFrmz58xB33N2Gf7TQFZn64pE7y0y3aq91mPpgfHUvAIWj2S4yE7akyCGTQaLP9SUR4Ef94ZCNiF4P0voNBmA0wQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964106; c=relaxed/simple;
	bh=JXPL6+Mlg1vFhwdXpYUetEaOAHIQlfmnJYKN1XIf76A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHa3I0W0fe1QTAEjGgg3YgSY44SK0UbaLsSwxg0jo/s+MfBXUHmlOHH3bHxxvDJ8PFhTdQfLn3WIr5pCsvBZTUz2CwJqCFJZT++RWBK8gIh6jUpb37k2FQfIeANmMJujDXldAmiHBtmt/ZP/+bKHVjaHNSixc1Hake3sl7/TtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFabid1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB69EC4AF0A;
	Tue,  2 Jul 2024 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964106;
	bh=JXPL6+Mlg1vFhwdXpYUetEaOAHIQlfmnJYKN1XIf76A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFabid1U6LpoKjhIBdRwULb2jpt5wuBoJJduXT5sObvAxAkObncSXUJfHlURZkwJh
	 g1Hbv/FlBMXP6uz9INcvvsrsu28NW3Ry3RWc/LbgZmeSKfI51DrVwT5kV+K9u6v634
	 ECb5kJnmLC9qV7hEWRtwp4DZ1uMf9qQCcNtCevYjB2vJr1vquuiJ/W9wXA0E7rOhYK
	 MSFiun44WO7OvRvG/HwT1QXXAAMqxjh0ul6tYN4/Y32PfkPTQYo4oMvXbpFcZT9R2g
	 ey77LPDFhCfh7stEvjJyXos4DxhcmVca4eiAPQ/2NiMXOQ/MVBiWPF+kCJYgNcRKK3
	 R2arKsxS7MmDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/11] eth: bnxt: use the indir table from ethtool context
Date: Tue,  2 Jul 2024 16:47:56 -0700
Message-ID: <20240702234757.4188344-12-kuba@kernel.org>
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

Instead of allocating a separate indir table in the vnic use
the one already present in the RSS context allocated by the core.
This doesn't save much LoC but we won't have to worry about syncing
the local version back to the core, once core learns how to dump
contexts.

Add ethtool_rxfh_priv_context() for converting from priv pointer
to the context. The cast is a bit ugly (understatement) and some
driver paths make carrying the context pointer in addition to
driver priv pointer quite tedious.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 27 +++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 34 +++++++++----------
 include/linux/ethtool.h                       |  5 +++
 4 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4176459921b5..8ee57b07ffb6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6222,10 +6222,9 @@ static u16 bnxt_cp_ring_for_tx(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 		return bnxt_cp_ring_from_grp(bp, &txr->tx_ring_struct);
 }
 
-int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
+static int bnxt_alloc_rss_indir_tbl(struct bnxt *bp)
 {
 	int entries;
-	u32 *tbl;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		entries = BNXT_MAX_RSS_TABLE_ENTRIES_P5;
@@ -6233,19 +6232,16 @@ int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 		entries = HW_HASH_INDEX_SIZE;
 
 	bp->rss_indir_tbl_entries = entries;
-	tbl = kmalloc_array(entries, sizeof(*bp->rss_indir_tbl), GFP_KERNEL);
-	if (!tbl)
+	bp->rss_indir_tbl =
+		kmalloc_array(entries, sizeof(*bp->rss_indir_tbl), GFP_KERNEL);
+	if (!bp->rss_indir_tbl)
 		return -ENOMEM;
 
-	if (rss_ctx)
-		rss_ctx->rss_indir_tbl = tbl;
-	else
-		bp->rss_indir_tbl = tbl;
-
 	return 0;
 }
 
-void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
+void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp,
+				 struct ethtool_rxfh_context *ctx)
 {
 	u16 max_rings, max_entries, pad, i;
 	u32 *rss_indir_tbl;
@@ -6259,8 +6255,8 @@ void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 		max_rings = bp->rx_nr_rings;
 
 	max_entries = bnxt_get_rxfh_indir_size(bp->dev);
-	if (rss_ctx)
-		rss_indir_tbl = &rss_ctx->rss_indir_tbl[0];
+	if (ctx)
+		rss_indir_tbl = ethtool_rxfh_context_indir(ctx);
 	else
 		rss_indir_tbl = &bp->rss_indir_tbl[0];
 
@@ -6315,10 +6311,12 @@ static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
 				    struct bnxt_vnic_info *vnic)
 {
 	__le16 *ring_tbl = vnic->rss_table;
+	struct ethtool_rxfh_context *ctx;
 	struct bnxt_rx_ring_info *rxr;
 	u16 tbl_size, i;
 
 	tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
+	ctx = ethtool_rxfh_priv_context(vnic->rss_ctx);
 
 	for (i = 0; i < tbl_size; i++) {
 		u16 ring_id, j;
@@ -6326,7 +6324,7 @@ static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
 		if (vnic->flags & BNXT_VNIC_NTUPLE_FLAG)
 			j = ethtool_rxfh_indir_default(i, bp->rx_nr_rings);
 		else if (vnic->flags & BNXT_VNIC_RSSCTX_FLAG)
-			j = vnic->rss_ctx->rss_indir_tbl[i];
+			j = ethtool_rxfh_context_indir(ctx)[i];
 		else
 			j = bp->rss_indir_tbl[i];
 		rxr = &bp->rx_ring[j];
@@ -10224,7 +10222,6 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 		dma_free_coherent(&bp->pdev->dev, vnic->rss_table_size,
 				  vnic->rss_table,
 				  vnic->rss_table_dma_addr);
-	kfree(rss_ctx->rss_indir_tbl);
 	bp->num_rss_ctx--;
 }
 
@@ -15685,7 +15682,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			bp->flags |= BNXT_FLAG_CHIP_P7;
 	}
 
-	rc = bnxt_alloc_rss_indir_tbl(bp, NULL);
+	rc = bnxt_alloc_rss_indir_tbl(bp);
 	if (rc)
 		goto init_err_pci_clean;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1a33824a32a8..a4420db55de9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1292,7 +1292,6 @@ struct bnxt_vnic_info {
 
 struct bnxt_rss_ctx {
 	struct bnxt_vnic_info vnic;
-	u32	*rss_indir_tbl;
 	u8	index;
 };
 
@@ -2808,8 +2807,8 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 			   u32 tpa_flags);
 void bnxt_fill_ipv6_mask(__be32 mask[4]);
-int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
-void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
+void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp,
+				 struct ethtool_rxfh_context *ctx);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index e5f687d4a455..13e9b3b26f09 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1218,11 +1218,10 @@ static struct bnxt_rss_ctx *bnxt_get_rss_ctx_from_index(struct bnxt *bp,
 	return ethtool_rxfh_context_priv(ctx);
 }
 
-static int bnxt_alloc_rss_ctx_rss_table(struct bnxt *bp,
-					struct bnxt_rss_ctx *rss_ctx)
+static int bnxt_alloc_vnic_rss_table(struct bnxt *bp,
+				     struct bnxt_vnic_info *vnic)
 {
 	int size = L1_CACHE_ALIGN(BNXT_MAX_RSS_TABLE_SIZE_P5);
-	struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
 
 	vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
 	vnic->rss_table = dma_alloc_coherent(&bp->pdev->dev,
@@ -1801,7 +1800,6 @@ static u32 bnxt_get_rxfh_key_size(struct net_device *dev)
 static int bnxt_get_rxfh(struct net_device *dev,
 			 struct ethtool_rxfh_param *rxfh)
 {
-	u32 rss_context = rxfh->rss_context;
 	struct bnxt_rss_ctx *rss_ctx = NULL;
 	struct bnxt *bp = netdev_priv(dev);
 	u32 *indir_tbl = bp->rss_indir_tbl;
@@ -1815,10 +1813,13 @@ static int bnxt_get_rxfh(struct net_device *dev,
 
 	vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	if (rxfh->rss_context) {
-		rss_ctx = bnxt_get_rss_ctx_from_index(bp, rss_context);
-		if (!rss_ctx)
+		struct ethtool_rxfh_context *ctx;
+
+		ctx = xa_load(&bp->dev->ethtool->rss_ctx, rxfh->rss_context);
+		if (!ctx)
 			return -EINVAL;
-		indir_tbl = rss_ctx->rss_indir_tbl;
+		indir_tbl = ethtool_rxfh_context_indir(ctx);
+		rss_ctx = ethtool_rxfh_context_priv(ctx);
 		vnic = &rss_ctx->vnic;
 	}
 
@@ -1834,7 +1835,8 @@ static int bnxt_get_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
+static void bnxt_modify_rss(struct bnxt *bp, struct ethtool_rxfh_context *ctx,
+			    struct bnxt_rss_ctx *rss_ctx,
 			    const struct ethtool_rxfh_param *rxfh)
 {
 	if (rxfh->key) {
@@ -1851,7 +1853,7 @@ static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 		u32 *indir_tbl = bp->rss_indir_tbl;
 
 		if (rss_ctx)
-			indir_tbl = rss_ctx->rss_indir_tbl;
+			indir_tbl = ethtool_rxfh_context_indir(ctx);
 		for (i = 0; i < tbl_size; i++)
 			indir_tbl[i] = rxfh->indir[i];
 		pad = bp->rss_indir_tbl_entries - tbl_size;
@@ -1909,15 +1911,11 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 	vnic->rss_ctx = rss_ctx;
 	vnic->flags |= BNXT_VNIC_RSSCTX_FLAG;
 	vnic->vnic_id = BNXT_VNIC_ID_INVALID;
-	rc = bnxt_alloc_rss_ctx_rss_table(bp, rss_ctx);
+	rc = bnxt_alloc_vnic_rss_table(bp, vnic);
 	if (rc)
 		goto out;
 
-	rc = bnxt_alloc_rss_indir_tbl(bp, rss_ctx);
-	if (rc)
-		goto out;
-
-	bnxt_set_dflt_rss_indir_tbl(bp, rss_ctx);
+	bnxt_set_dflt_rss_indir_tbl(bp, ctx);
 	memcpy(vnic->rss_hash_key, bp->rss_hash_key, HW_HASH_KEY_SIZE);
 
 	rc = bnxt_hwrm_vnic_alloc(bp, vnic, 0, bp->rx_nr_rings);
@@ -1931,7 +1929,7 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Unable to setup TPA");
 		goto out;
 	}
-	bnxt_modify_rss(bp, rss_ctx, rxfh);
+	bnxt_modify_rss(bp, ctx, rss_ctx, rxfh);
 
 	rc = __bnxt_setup_vnic_p5(bp, vnic);
 	if (rc) {
@@ -1961,7 +1959,7 @@ static int bnxt_modify_rxfh_context(struct net_device *dev,
 
 	rss_ctx = ethtool_rxfh_context_priv(ctx);
 
-	bnxt_modify_rss(bp, rss_ctx, rxfh);
+	bnxt_modify_rss(bp, ctx, rss_ctx, rxfh);
 
 	return bnxt_hwrm_vnic_rss_cfg_p5(bp, &rss_ctx->vnic);
 }
@@ -1990,7 +1988,7 @@ static int bnxt_set_rxfh(struct net_device *dev,
 	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	bnxt_modify_rss(bp, NULL, rxfh);
+	bnxt_modify_rss(bp, NULL, NULL, rxfh);
 
 	bnxt_clear_usr_fltrs(bp, false);
 	if (netif_running(bp->dev)) {
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index dc8ed93097c3..5b28407d0619 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -190,6 +190,11 @@ static inline void *ethtool_rxfh_context_priv(struct ethtool_rxfh_context *ctx)
 	return ctx->data;
 }
 
+static inline struct ethtool_rxfh_context *ethtool_rxfh_priv_context(void *priv)
+{
+	return container_of((u8(*)[])priv, struct ethtool_rxfh_context, data);
+}
+
 static inline u32 *ethtool_rxfh_context_indir(struct ethtool_rxfh_context *ctx)
 {
 	return (u32 *)(ctx->data + ALIGN(ctx->priv_size, sizeof(u32)));
-- 
2.45.2


