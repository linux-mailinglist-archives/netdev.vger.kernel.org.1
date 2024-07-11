Return-Path: <netdev+bounces-110959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C7C92F1BC
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DD62866B0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273081A0B1B;
	Thu, 11 Jul 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJCokyYT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235C19F485
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735646; cv=none; b=OBa6BoKliS7NO2p4Ozyw0QnYpdPKSsZLrxtOClfh8Auz6NvlSO7EhPagSrBkWyTWE2YQuzAi8uOvCUPOaihnwXMl7qGRdJjcd22FGzFDvGvJrLAN1oDVYX07aeo7Jn5D13brU/dwiHVCQT6BQXXm2ChTQ8RPZpKH6OJhi+5dARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735646; c=relaxed/simple;
	bh=OB4v2rdbXorCKz4rp2P4CdP/ZdfXdVzh0kuoR5cD5ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0RoCwK+itv0BOtVWtxqQriVvn2eKAf4m7eOa+D7zIl+FnSKXqsngGDJ8JHoUMRHdL7Jf48yZfQWnsOivWSET5QDv4VgtbGkP6N4CxXHogPoq9Kol34mkYzSx3LDeYg8miTRScRLOEpuKzYccqtMdCF9VTPomxSOxyb/xOyx118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJCokyYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73540C4AF0A;
	Thu, 11 Jul 2024 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735645;
	bh=OB4v2rdbXorCKz4rp2P4CdP/ZdfXdVzh0kuoR5cD5ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJCokyYTYzJat1FuURHhskZrqdC2o1gp8Uc+PYPi9q6i5g5VvFCF/SxWW3brSk0zl
	 mdvMZheZEFGDrjsCtCWVWOe8WEtd/5dRxvZ9+jQFU71x7/7/pdNM+V8AL9zDvMw+5c
	 9Q60UBXDoA80ceh/Veq1izsj98FfV4RupZCXTrk2YmHNiS4IMRTA8/WgkYD93rgFyq
	 FsRsSnnSppMUvcXaey9NQieN2mzHS0/G6LkIDIZ3dOTxpZ47vKqQbhEWYeDg7qMyxk
	 jtrsN89t5ZGjuDFqwuKT+kd072yeDsR6Ajmj33HbeBDTFPA3ScLzfPtGG7MK5kyQT0
	 WYCtFMBm5j86Q==
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
Subject: [PATCH net-next 10/11] eth: bnxt: bump the entry size in indir tables to u32
Date: Thu, 11 Jul 2024 15:07:12 -0700
Message-ID: <20240711220713.283778-11-kuba@kernel.org>
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

Ethtool core stores indirection table with u32 entries, "just to be safe".
Switch the type in the driver, so that it's easier to swap local tables
for the core ones. Memory allocations already use sizeof(*entry), switch
the memset()s as well.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v2:
 - switch from sizeof(u32) to sizeof(*indir_tbl)
 - add a sentence to the commit msg
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f9554f512314..ed46d74533ed 100644
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
+		memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));
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
index 8c30f740a9c5..edcbb1a4f6c8 100644
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
-			memset(&indir_tbl[i], 0, pad * sizeof(u16));
+			memset(&indir_tbl[i], 0, pad * sizeof(*indir_tbl));
 	}
 }
 
-- 
2.45.2


