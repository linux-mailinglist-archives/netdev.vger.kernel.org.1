Return-Path: <netdev+bounces-108635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9A924C5A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90361F23739
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0194191F80;
	Tue,  2 Jul 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3XDWL2b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B09E191F7A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964104; cv=none; b=hrcvK6F2Ehs3E/54iDNpJmDYMIu1/K1Cnjhdi6BefL0a7AeD5axhO8p4atS9vr0/CLD17ZMfNz76i10CzX8yLTq24VO94FHiHwLJQF/Sox5QaQjMpeGO2zs8WNq+kTN4q4kGPATRHwNjtoS7r6qt403CG5mOwyDPtdCij0aLjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964104; c=relaxed/simple;
	bh=wsqLICet8/BuezYj4ZeNpLgNxjGWR46Cx9rmcKiHYFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwcTh7qlkn4BCDDJyre3WuGhob1aLGv5moI/cafO4oxly7J2ADu/1zFAbrGstTf6K2rmv03P0GFnGGJgFq+rLu8MthBiNcgsv3yKWOmUKqIcRbDKjLZzTURgfAEmuQEdUJO9u/ozopecACYwxCPDXp0vnYt1nBnbkV1DIqR4Ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3XDWL2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EF1C4AF0E;
	Tue,  2 Jul 2024 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964104;
	bh=wsqLICet8/BuezYj4ZeNpLgNxjGWR46Cx9rmcKiHYFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3XDWL2bs9rZsqm8igRKPgiQOLfqj5st9c01WARwLe7z7SNEGTzPgN/EI2kCRfPE2
	 +ntYNkXNJRtmfgNtOHpPl292RcnTuZR+B8vUtVdZv8q+aCZZXC0lgd7lVDIKRlc1vN
	 luWMGh1+8vjf6MRDmsuMnVXIe1tbFwk8EETF+iknOvaxH/s47Vft9fTC0bFbYGS+RX
	 jpRVKoRPTB4jvI7t/Mx7HESDO5b25pMVIO2vboXr2voH6zxwm2TB7D3xAy7V5phFgR
	 qvoBjQbyqLgWNpoKL4HsdFPPk/9tI/FBCUAyySHTkJtezQepLdXekalH3Zj3C4dJ/i
	 eTvZpsy1cNnyw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/11] eth: bnxt: use context priv for struct bnxt_rss_ctx
Date: Tue,  2 Jul 2024 16:47:53 -0700
Message-ID: <20240702234757.4188344-9-kuba@kernel.org>
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

Core can allocate space for per-context driver-private data,
use it for struct bnxt_rss_ctx. Inline bnxt_alloc_rss_ctx()
at this point, most of the init (as in the actions bnxt_del_one_rss_ctx()
will undo) is open coded in bnxt_create_rxfh_context(), anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 14 -----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 -
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 24 +++++++------------
 3 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b6915261c15d..39876feae1a4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10224,7 +10224,6 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	kfree(rss_ctx->rss_indir_tbl);
 	list_del(&rss_ctx->list);
 	bp->num_rss_ctx--;
-	kfree(rss_ctx);
 }
 
 static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
@@ -10246,19 +10245,6 @@ static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 	}
 }
 
-struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp)
-{
-	struct bnxt_rss_ctx *rss_ctx = NULL;
-
-	rss_ctx = kzalloc(sizeof(*rss_ctx), GFP_KERNEL);
-	if (rss_ctx) {
-		rss_ctx->vnic.rss_ctx = rss_ctx;
-		list_add_tail(&rss_ctx->list, &bp->rss_ctx_list);
-		bp->num_rss_ctx++;
-	}
-	return rss_ctx;
-}
-
 void bnxt_clear_rss_ctxs(struct bnxt *bp)
 {
 	struct bnxt_rss_ctx *rss_ctx, *tmp;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 04c4ff7b9052..21c3296cf6d9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2845,7 +2845,6 @@ int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all);
-struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp);
 void bnxt_clear_rss_ctxs(struct bnxt *bp);
 int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 397aedad3d4f..2e6e060e2b44 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1901,11 +1901,13 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 		return -ENOMEM;
 	}
 
-	rss_ctx = bnxt_alloc_rss_ctx(bp);
-	if (!rss_ctx)
-		return -ENOMEM;
+	rss_ctx = ethtool_rxfh_context_priv(ctx);
+
+	list_add_tail(&rss_ctx->list, &bp->rss_ctx_list);
+	bp->num_rss_ctx++;
 
 	vnic = &rss_ctx->vnic;
+	vnic->rss_ctx = rss_ctx;
 	vnic->flags |= BNXT_VNIC_RSSCTX_FLAG;
 	vnic->vnic_id = BNXT_VNIC_ID_INVALID;
 	rc = bnxt_alloc_rss_ctx_rss_table(bp, rss_ctx);
@@ -1958,12 +1960,7 @@ static int bnxt_modify_rxfh_context(struct net_device *dev,
 	if (rc)
 		return rc;
 
-	rss_ctx = bnxt_get_rss_ctx_from_index(bp, rxfh->rss_context);
-	if (!rss_ctx) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "RSS context %u not found",
-				       rxfh->rss_context);
-		return -EINVAL;
-	}
+	rss_ctx = ethtool_rxfh_context_priv(ctx);
 
 	bnxt_modify_rss(bp, rss_ctx, rxfh);
 
@@ -1978,12 +1975,7 @@ static int bnxt_remove_rxfh_context(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rss_ctx *rss_ctx;
 
-	rss_ctx = bnxt_get_rss_ctx_from_index(bp, rss_context);
-	if (!rss_ctx) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "RSS context %u not found",
-				       rss_context);
-		return -EINVAL;
-	}
+	rss_ctx = ethtool_rxfh_context_priv(ctx);
 
 	bnxt_del_one_rss_ctx(bp, rss_ctx, true);
 	return 0;
@@ -5292,6 +5284,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.cap_rss_ctx_supported		= 1,
 	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,
+	.rxfh_indir_space		= BNXT_MAX_RSS_TABLE_ENTRIES_P5,
+	.rxfh_priv_size			= sizeof(struct bnxt_rss_ctx),
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS_IRQ |
-- 
2.45.2


