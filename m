Return-Path: <netdev+bounces-108637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03283924C5C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB58283FBA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926E1ABC20;
	Tue,  2 Jul 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDyUt3g+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563A15B10B
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964105; cv=none; b=imowAz2CJTfzMAaUPa3ssfL4c80YQjKGRdjXTN+fQ1ry/GZLkGdrwR4UeQnUehYClbBSFaKUtsu8wlM/l7/nT/5Ka/Og3C9k3iRuQ29eYNjTQe7Uq0olp3zIZAY4TgWR23D3Cy40x+VPHNposZJYJg7tSydA7vLBJTdQQQFB8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964105; c=relaxed/simple;
	bh=yTBX0frnr+EwLUvGQmLpe0F7gF5q6DZ6fmkEN8bBL6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX5zGvxpGa6Ov5OWnPVEy7IisixCqHyPdtZjXW9PjG6Gm5xz2S7eO+SPNzdPg1Vzy9kiOUasPP6D9pWuv+xLEVrGzZP7OaWaZrBzsy4eX8VGGxuBu1wpCVWvGdZMudbYGXSpxEaQ/yh8qgoVzB7xaK1rhsiOdaQRqOdduklqKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDyUt3g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B3FC2BD10;
	Tue,  2 Jul 2024 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964105;
	bh=yTBX0frnr+EwLUvGQmLpe0F7gF5q6DZ6fmkEN8bBL6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDyUt3g+S+6plskXk3WBzyh4E90vRqOjFeaHsp96Kjb8aj+udrVT9ZNhyseakliq4
	 2mDtBZ9y2NUO6vwKN1gpmay26AcrNdOVx6NayPm8Wza1s7Lg3jWEHTNgO+Yzll+hpN
	 bOtDW6emixpdDIAFgjri8/7iJe7xI0VtIEx0WBF9xXnI7OVRyKbPPYxXuqpuL2wbTP
	 Lmm8HEKSRdg9QKt+K74YNBVkEni/kVCAkD82XaF/c+CB2YS8WERL3yQwBsJ8sDHjQk
	 xkEPcfDLdHrDoO0EV3YBgevSJ/m0KIEpSsJiYB40uzclIy3vZ7WFP/uoFQh7aurXZE
	 U0a++8yB+9cpw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/11] eth: bnxt: bump the entry size in indir tables to u32
Date: Tue,  2 Jul 2024 16:47:55 -0700
Message-ID: <20240702234757.4188344-11-kuba@kernel.org>
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

Ethtool core stores indirection table with u32 entries, "just to be safe".
Switch the type in the driver, so that it's easier to swap local tables
for the core ones.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6b8966d3ecb6..4176459921b5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6225,7 +6225,7 @@ static u16 bnxt_cp_ring_for_tx(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 {
 	int entries;
-	u16 *tbl;
+	u32 *tbl;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		entries = BNXT_MAX_RSS_TABLE_ENTRIES_P5;
@@ -6248,7 +6248,7 @@ int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 {
 	u16 max_rings, max_entries, pad, i;
-	u16 *rss_indir_tbl;
+	u32 *rss_indir_tbl;
 
 	if (!bp->rx_nr_rings)
 		return;
@@ -6269,12 +6269,12 @@ void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 
 	pad = bp->rss_indir_tbl_entries - max_entries;
 	if (pad)
-		memset(&rss_indir_tbl[i], 0, pad * sizeof(u16));
+		memset(&rss_indir_tbl[i], 0, pad * sizeof(u32));
 }
 
 static u16 bnxt_get_max_rss_ring(struct bnxt *bp)
 {
-	u16 i, tbl_size, max_ring = 0;
+	u32 i, tbl_size, max_ring = 0;
 
 	if (!bp->rss_indir_tbl)
 		return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index be40e0513777..1a33824a32a8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1292,7 +1292,7 @@ struct bnxt_vnic_info {
 
 struct bnxt_rss_ctx {
 	struct bnxt_vnic_info vnic;
-	u16	*rss_indir_tbl;
+	u32	*rss_indir_tbl;
 	u8	index;
 };
 
@@ -2331,7 +2331,7 @@ struct bnxt {
 	struct bnxt_vnic_info	*vnic_info;
 	u32			num_rss_ctx;
 	int			nr_vnics;
-	u16			*rss_indir_tbl;
+	u32			*rss_indir_tbl;
 	u16			rss_indir_tbl_entries;
 	u32			rss_hash_cfg;
 	u32			rss_hash_delta;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 74765583405b..e5f687d4a455 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1804,7 +1804,7 @@ static int bnxt_get_rxfh(struct net_device *dev,
 	u32 rss_context = rxfh->rss_context;
 	struct bnxt_rss_ctx *rss_ctx = NULL;
 	struct bnxt *bp = netdev_priv(dev);
-	u16 *indir_tbl = bp->rss_indir_tbl;
+	u32 *indir_tbl = bp->rss_indir_tbl;
 	struct bnxt_vnic_info *vnic;
 	u32 i, tbl_size;
 
@@ -1848,7 +1848,7 @@ static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	}
 	if (rxfh->indir) {
 		u32 i, pad, tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
-		u16 *indir_tbl = bp->rss_indir_tbl;
+		u32 *indir_tbl = bp->rss_indir_tbl;
 
 		if (rss_ctx)
 			indir_tbl = rss_ctx->rss_indir_tbl;
@@ -1856,7 +1856,7 @@ static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			indir_tbl[i] = rxfh->indir[i];
 		pad = bp->rss_indir_tbl_entries - tbl_size;
 		if (pad)
-			memset(&bp->rss_indir_tbl[i], 0, pad * sizeof(u16));
+			memset(&bp->rss_indir_tbl[i], 0, pad * sizeof(u32));
 	}
 }
 
-- 
2.45.2


