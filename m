Return-Path: <netdev+bounces-108636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D6B924C5B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223631C22952
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A5191F8D;
	Tue,  2 Jul 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYS7Q9MU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAA191F8A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964105; cv=none; b=RhZZ+JCkd5OHYI6DgOQzRJAcNP/hquQ6fHRblmAQHCH8qJThwKAzlJ7BIKlk6JBAL2jd3DEHJImsUnSMdWW91zKxliZNuGVNnwlMOhx0HOPGw3AwFb3MlqR3FGBm854VOTzP9yiNP21ON/cyga60jnyUM7yXmIte/uTtQ3JQqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964105; c=relaxed/simple;
	bh=ksqBWIsShSQ/uPMgWp+zzDBbsK0SZd9wc4TOExnJjUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=untZfktvYyTC+rE4TpUFrUuGKu1HRZqGQ7ZQHyK4GlRvwq6tyxMEyFI0SLdUGZ95GQJQQy6I2bH5s2w5qdxMqOvRGpP0PPEprO7wyl9cqKfVBam8HLU+BWLHAhEzUvKMXGOi+viVa/Yairn/suO9YNo+IrJMJxJ+5ukklHzAnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYS7Q9MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F12C116B1;
	Tue,  2 Jul 2024 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964105;
	bh=ksqBWIsShSQ/uPMgWp+zzDBbsK0SZd9wc4TOExnJjUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYS7Q9MUVDOpvLmScjM3xBk7lRdQHK9Oyg7/6cbNQwgZZbMHW0sW8P12IyMXwMfAt
	 GyC3Kc92MFcmcS68n5Xia0cY0XPMMIA9wiGHShfZAJqUenBiC8+9QYu4IvZFK27exq
	 ndGMF+coxZb9P6OmeQa+TZfhLlEhbNpGf006aEya0JOFacQVzkjWc8s6oLI3P+MzdG
	 +w7YxoFpzug5s3UGWaAIzUM6+Tx36XrB7NfIVephPFC1TCFabT+JIyptALvimJBICl
	 5jQl74n/XnQhV6AV9bTF6BveugFMT2qM3RnyuSll61AVG//PkIyiIYVJrIyBwt7yuE
	 JzFvD6vDvgGKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/11] eth: bnxt: use the RSS context XArray instead of the local list
Date: Tue,  2 Jul 2024 16:47:54 -0700
Message-ID: <20240702234757.4188344-10-kuba@kernel.org>
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

Core already maintains all RSS contexts in an XArray, no need
to keep a second list in the driver.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 41 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 -
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 +++--
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 39876feae1a4..6b8966d3ecb6 100644
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
@@ -10222,16 +10225,17 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
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
@@ -10247,16 +10251,14 @@ static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 
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
@@ -15840,8 +15842,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
-		bnxt_init_multi_rss_ctx(bp);
-
+		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 21c3296cf6d9..be40e0513777 100644
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
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2e6e060e2b44..74765583405b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1210,12 +1210,12 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
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
@@ -1903,7 +1903,6 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 
 	rss_ctx = ethtool_rxfh_context_priv(ctx);
 
-	list_add_tail(&rss_ctx->list, &bp->rss_ctx_list);
 	bp->num_rss_ctx++;
 
 	vnic = &rss_ctx->vnic;
-- 
2.45.2


