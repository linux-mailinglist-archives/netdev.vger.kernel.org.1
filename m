Return-Path: <netdev+bounces-108633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B214A924C58
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690331F23075
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142F191F69;
	Tue,  2 Jul 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7i/x2yW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AD191F65
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964103; cv=none; b=YVxW1RvyhxDU8pDpjiG1Qiq4drdz/1+RIeF7usJWZT9DYAHqNg6OdJi824ylcsG1BojVbHuZ1Ru/xlfrcFhmxrL8XuntZtzwl+YHg3WSwHw/BORTywauDDWRR4iAcBzPXLFdZwDM012kRmd6lFGE3qxR6Z9eupA4rS3R0dVH/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964103; c=relaxed/simple;
	bh=+eiCL86bGJmVweprTK/TGa9M/g5l17Q36dvpSozeslw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDxC6dIvrZFse1GiHfVYjt0p40Zxf0SsNq5WaTYovi+Vs0ahw4rmPz1oql0RrQLP1TJHtfJLZvrAoyng+0TS9clojpJbsmkX8XOY8BeSos2fgeegXHvrT3Rle2CmILNGmn74KwKL/kI8dYScnKrWwh6Aq5FugMnion9Yty/VTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7i/x2yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D33EC4AF12;
	Tue,  2 Jul 2024 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964103;
	bh=+eiCL86bGJmVweprTK/TGa9M/g5l17Q36dvpSozeslw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7i/x2yWuljJwMBndq66bMjxsGnS4PJA3szmRHKiXP+2425bO8XqOXjg84EW2EfX6
	 rBRPmZ+n4Y62hizeb7H/Jp5+8rulWvB4TCaLObkld9/x52TQsg3eAjNWoy84BiAbTk
	 6IDIpSBo78gEDnz9R1nisDu68pIYMHNqfX+UuxEHUxry9AbkvpyhaGEzUFPX2u1Q6u
	 defAAwrraaH8kSDk4mMB50lwsntPV0fk7euE9hzPy4bPS6pyqgSKD6pIDzwu1tPIRO
	 XrRZyNmvEhvnm0sRf6uvf6TQnn83qNxWaYcNPIgNx++hUzvRtON5BWOofymE77jKwp
	 xcAZgUUOIBzzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/11] eth: bnxt: remove rss_ctx_bmap
Date: Tue,  2 Jul 2024 16:47:51 -0700
Message-ID: <20240702234757.4188344-7-kuba@kernel.org>
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

Core will allocate IDs for the driver, from the range
[1, BNXT_MAX_ETH_RSS_CTX], no need to track the allocations.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 13 ++-----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  2 --
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 -----
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3dc43c263b91..02aeba4b5df5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10224,7 +10224,6 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	kfree(rss_ctx->rss_indir_tbl);
 	list_del(&rss_ctx->list);
 	bp->num_rss_ctx--;
-	clear_bit(rss_ctx->index, bp->rss_ctx_bmap);
 	kfree(rss_ctx);
 }
 
@@ -10266,20 +10265,12 @@ void bnxt_clear_rss_ctxs(struct bnxt *bp, bool all)
 
 	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list)
 		bnxt_del_one_rss_ctx(bp, rss_ctx, all);
-
-	if (all)
-		bitmap_free(bp->rss_ctx_bmap);
 }
 
 static void bnxt_init_multi_rss_ctx(struct bnxt *bp)
 {
-	bp->rss_ctx_bmap = bitmap_zalloc(BNXT_RSS_CTX_BMAP_LEN, GFP_KERNEL);
-	if (bp->rss_ctx_bmap) {
-		/* burn index 0 since we cannot have context 0 */
-		__set_bit(0, bp->rss_ctx_bmap);
-		INIT_LIST_HEAD(&bp->rss_ctx_list);
-		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
-	}
+	INIT_LIST_HEAD(&bp->rss_ctx_list);
+	bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
 }
 
 /* Allow PF, trusted VFs and VFs with default VLAN to be in promiscuous mode */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e46bd11e52b0..f4365a840e3a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1298,7 +1298,6 @@ struct bnxt_rss_ctx {
 };
 
 #define BNXT_MAX_ETH_RSS_CTX	32
-#define BNXT_RSS_CTX_BMAP_LEN	(BNXT_MAX_ETH_RSS_CTX + 1)
 #define BNXT_VNIC_ID_INVALID	0xffffffff
 
 struct bnxt_hw_rings {
@@ -2332,7 +2331,6 @@ struct bnxt {
 	struct bnxt_ring_grp_info	*grp_info;
 	struct bnxt_vnic_info	*vnic_info;
 	struct list_head	rss_ctx_list;
-	unsigned long		*rss_ctx_bmap;
 	u32			num_rss_ctx;
 	int			nr_vnics;
 	u16			*rss_indir_tbl;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index a7f71ebca2fe..48f8e14685a1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1896,11 +1896,6 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (test_and_set_bit(rxfh->rss_context, bp->rss_ctx_bmap)) {
-		NL_SET_ERR_MSG_MOD(extack, "Context ID conflict");
-		return -EINVAL;
-	}
-
 	if (!bnxt_rfs_capable(bp, true)) {
 		NL_SET_ERR_MSG_MOD(extack, "Out hardware resources");
 		return -ENOMEM;
-- 
2.45.2


