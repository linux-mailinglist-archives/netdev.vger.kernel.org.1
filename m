Return-Path: <netdev+bounces-110956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8D292F1B9
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2B1C218F4
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DE1A08D0;
	Thu, 11 Jul 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpmD2PaN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228B1A08C7
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735644; cv=none; b=OsUbfZqfTVgGYqo6UBf295JRpXFCaT1ou4IdETWZKrzVvDaVGXz0pR4AdoiMXf/hPgEYhnla2eCUv8WYWW94g8F6AKT8dkSBHkZif5SIHt41xss5WsJaX7Xo4pxn2UXnwK2E2SRvuxeCSfJCKunLEW6y6PsVeh93427Bav3BXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735644; c=relaxed/simple;
	bh=/zOI9wSF+QS62FI3V5COHzO08xptmcDxzpkAb4zMKjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1nqFiMBn6D7C3JHHWte516dI+VuoFzs/pIwOdqzZ/CmDf/wg5L7NaZp2fPQ6e6raSB6DAxzXXz+iUf2josotKmy461NP8noaH1XQhQ0dSPKuhbEOIM58PCZaTAYn4wRZGLjANbRrDdzG9WecouuQpk1hpkuD+cFJ8uP8QdlNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpmD2PaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0EC4AF10;
	Thu, 11 Jul 2024 22:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735644;
	bh=/zOI9wSF+QS62FI3V5COHzO08xptmcDxzpkAb4zMKjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpmD2PaNAzaKqd+JJyKqxgEpZV2bb1k76f9PhvCltaazlUPFisVuUpQE6Y15/lb9V
	 9pkAQcnRH7mvWAUymBAPPdj8mW2jvL+LIEL72B8ZXVL4FMQrGD/8BZ9+cp2RmqerFU
	 rkb9i9TckgDwOiu6UjwWnJ9qCXnd/mwdBfHOF7cTez2IfSDJ4Vd4GpE6FuZRr6D/BX
	 YKWGb73T+8sP6VtNDYoRv8E1ILhJF1wEP6B62f75Ekutw5QfTTkXYUBwIdIqLu88RT
	 CCXTNyTu5B3rF8dNlWiP73wr8xGu1x0C34Vw+MJ3d7oGXbE/l8c4UGIbIyZuA1FT9H
	 ZxTnBGz+upmRA==
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
Subject: [PATCH net-next 07/11] eth: bnxt: use context priv for struct bnxt_rss_ctx
Date: Thu, 11 Jul 2024 15:07:09 -0700
Message-ID: <20240711220713.283778-8-kuba@kernel.org>
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
index d6a4ce5066c6..e3cc34712f33 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10239,7 +10239,6 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	kfree(rss_ctx->rss_indir_tbl);
 	list_del(&rss_ctx->list);
 	bp->num_rss_ctx--;
-	kfree(rss_ctx);
 }
 
 static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
@@ -10261,19 +10260,6 @@ static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
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
index df96524a8b8b..c5fd7a4e6681 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2846,7 +2846,6 @@ int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all);
-struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp);
 void bnxt_clear_rss_ctxs(struct bnxt *bp);
 int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 5a64c0ea56c0..de8e13412151 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1907,11 +1907,13 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
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
@@ -1964,12 +1966,7 @@ static int bnxt_modify_rxfh_context(struct net_device *dev,
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
 
@@ -1984,12 +1981,7 @@ static int bnxt_remove_rxfh_context(struct net_device *dev,
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
@@ -5298,6 +5290,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


