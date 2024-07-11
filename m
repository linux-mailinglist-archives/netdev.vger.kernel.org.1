Return-Path: <netdev+bounces-110957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040A792F1BA
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9212D2866D0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C096616EB46;
	Thu, 11 Jul 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGIguAaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E41A0AFB
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735645; cv=none; b=CP/BQVuyXFXhm5q1SmCw2DRdDUoK/K4m30bcLi7j4kExVGwUKReCnJEo+p+BKuDJRz3MLo23DDe71AQNOxiesH4k57CV1+ke2gR5XyvMsSJ6uyC9CaVD3SmQHxwiIYiIoiOR8YBE6X4Da7STeRqTdAcyilRGLo18wLPfnaDeO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735645; c=relaxed/simple;
	bh=EkKHKenCFlkVEpqsKtn/fEIYDNNFa0ZanGKXul4zgZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRNsnAUIBIQWsgRSjqOFtU7BlCDVFYAywr1jbcSbDkljJBZ9jilj70iUoWlq9UsVIv6xNn9d9fIkQjOgFcXwqL0nXRe+5/uTg6Vj+ErKIv4VrIFsOeqxV3jnKjaENEZbZk7SzUVOKaCMuNYVqq/KVWtxuwR6ZOBRu6BVR7PxO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGIguAaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504EAC4AF0B;
	Thu, 11 Jul 2024 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735644;
	bh=EkKHKenCFlkVEpqsKtn/fEIYDNNFa0ZanGKXul4zgZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGIguAaY1xjtoxTU+xxw1LO3jttEjsw6qhYMpTOFHBB1+O3KDcVGkjDMjzPt7lzO9
	 JAi/0ghSbSBittNv2TOfTA/LGb8NDgolY8NS9qz6FCaYqmb1oWbSvg/BoqvJupXkn/
	 kO4g/3ZG+DeHipN4dCRH84PtCEYnPT9LDZZJewbZ4UmmqDxiCteqIz8A9rtF6ZEN0r
	 VRCi7ZKL49DKEoWi/X35mmFfyXIIdZrAIx2czCdkMqGJpKP9s5NiLvxqmQWo7Rnk7k
	 t4CGzpLcUYTzQRvTKH+emu/9Soww8VNI6QOFlEHQDX8ZB5L55Nq1HVuUOVrx+LcoEx
	 PJeCFe3j6+2kA==
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
Subject: [PATCH net-next 08/11] eth: bnxt: use the RSS context XArray instead of the local list
Date: Thu, 11 Jul 2024 15:07:10 -0700
Message-ID: <20240711220713.283778-9-kuba@kernel.org>
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

Core already maintains all RSS contexts in an XArray, no need
to keep a second list in the driver.

Remove bnxt_get_max_rss_ctx_ring() completely since core performs
the same check already.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove bnxt_get_max_rss_ctx_ring()
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 56 +++++++------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 -
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 17 ++----
 3 files changed, 26 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e3cc34712f33..f9554f512314 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5970,17 +5970,20 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 			  struct hwrm_cfa_ntuple_filter_alloc_input *req,
 			  struct bnxt_ntuple_filter *fltr)
 {
-	struct bnxt_rss_ctx *rss_ctx, *tmp;
 	u16 rxq = fltr->base.rxq;
 
 	if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
-		list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list) {
-			if (rss_ctx->index == fltr->base.fw_vnic_id) {
-				struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+		struct ethtool_rxfh_context *ctx;
+		struct bnxt_rss_ctx *rss_ctx;
+		struct bnxt_vnic_info *vnic;
 
-				req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
-				break;
-			}
+		ctx = xa_load(&bp->dev->ethtool->rss_ctx,
+			      fltr->base.fw_vnic_id);
+		if (ctx) {
+			rss_ctx = ethtool_rxfh_context_priv(ctx);
+			vnic = &rss_ctx->vnic;
+
+			req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 		}
 		return;
 	}
@@ -6282,21 +6285,6 @@ static u16 bnxt_get_max_rss_ring(struct bnxt *bp)
 	return max_ring;
 }
 
-u16 bnxt_get_max_rss_ctx_ring(struct bnxt *bp)
-{
-	u16 i, tbl_size, max_ring = 0;
-	struct bnxt_rss_ctx *rss_ctx;
-
-	tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
-
-	list_for_each_entry(rss_ctx, &bp->rss_ctx_list, list) {
-		for (i = 0; i < tbl_size; i++)
-			max_ring = max(max_ring, rss_ctx->rss_indir_tbl[i]);
-	}
-
-	return max_ring;
-}
-
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 {
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
@@ -10237,16 +10225,17 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 				  vnic->rss_table,
 				  vnic->rss_table_dma_addr);
 	kfree(rss_ctx->rss_indir_tbl);
-	list_del(&rss_ctx->list);
 	bp->num_rss_ctx--;
 }
 
 static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 {
 	bool set_tpa = !!(bp->flags & BNXT_FLAG_TPA);
-	struct bnxt_rss_ctx *rss_ctx, *tmp;
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
 
-	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list) {
+	xa_for_each(&bp->dev->ethtool->rss_ctx, context, ctx) {
+		struct bnxt_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
 		struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
 
 		if (bnxt_hwrm_vnic_alloc(bp, vnic, 0, bp->rx_nr_rings) ||
@@ -10262,16 +10251,14 @@ static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 
 void bnxt_clear_rss_ctxs(struct bnxt *bp)
 {
-	struct bnxt_rss_ctx *rss_ctx, *tmp;
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	xa_for_each(&bp->dev->ethtool->rss_ctx, context, ctx) {
+		struct bnxt_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
 
-	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list)
 		bnxt_del_one_rss_ctx(bp, rss_ctx, false);
-}
-
-static void bnxt_init_multi_rss_ctx(struct bnxt *bp)
-{
-	INIT_LIST_HEAD(&bp->rss_ctx_list);
-	bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+	}
 }
 
 /* Allow PF, trusted VFs and VFs with default VLAN to be in promiscuous mode */
@@ -15859,8 +15846,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
-		bnxt_init_multi_rss_ctx(bp);
-
+		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c5fd7a4e6681..be40e0513777 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1291,7 +1291,6 @@ struct bnxt_vnic_info {
 };
 
 struct bnxt_rss_ctx {
-	struct list_head list;
 	struct bnxt_vnic_info vnic;
 	u16	*rss_indir_tbl;
 	u8	index;
@@ -2330,7 +2329,6 @@ struct bnxt {
 	/* grp_info indexed by completion ring index */
 	struct bnxt_ring_grp_info	*grp_info;
 	struct bnxt_vnic_info	*vnic_info;
-	struct list_head	rss_ctx_list;
 	u32			num_rss_ctx;
 	int			nr_vnics;
 	u16			*rss_indir_tbl;
@@ -2812,7 +2810,6 @@ int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 void bnxt_fill_ipv6_mask(__be32 mask[4]);
 int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
 void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
-u16 bnxt_get_max_rss_ctx_ring(struct bnxt *bp);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index de8e13412151..74765583405b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -961,12 +961,6 @@ static int bnxt_set_channels(struct net_device *dev,
 		return rc;
 	}
 
-	if (req_rx_rings < bp->rx_nr_rings &&
-	    req_rx_rings <= bnxt_get_max_rss_ctx_ring(bp)) {
-		netdev_warn(dev, "Can't deactivate rings used by RSS contexts\n");
-		return -EINVAL;
-	}
-
 	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
 	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
 	    netif_is_rxfh_configured(dev)) {
@@ -1216,12 +1210,12 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 static struct bnxt_rss_ctx *bnxt_get_rss_ctx_from_index(struct bnxt *bp,
 							u32 index)
 {
-	struct bnxt_rss_ctx *rss_ctx, *tmp;
+	struct ethtool_rxfh_context *ctx;
 
-	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list)
-		if (rss_ctx->index == index)
-			return rss_ctx;
-	return NULL;
+	ctx = xa_load(&bp->dev->ethtool->rss_ctx, index);
+	if (!ctx)
+		return NULL;
+	return ethtool_rxfh_context_priv(ctx);
 }
 
 static int bnxt_alloc_rss_ctx_rss_table(struct bnxt *bp,
@@ -1909,7 +1903,6 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 
 	rss_ctx = ethtool_rxfh_context_priv(ctx);
 
-	list_add_tail(&rss_ctx->list, &bp->rss_ctx_list);
 	bp->num_rss_ctx++;
 
 	vnic = &rss_ctx->vnic;
-- 
2.45.2


