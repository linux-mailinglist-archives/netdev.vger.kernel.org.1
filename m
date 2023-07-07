Return-Path: <netdev+bounces-16112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF9674B68E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6D61C21028
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1817AA6;
	Fri,  7 Jul 2023 18:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FE17AC8
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E168EC43391;
	Fri,  7 Jul 2023 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755189;
	bh=DT4i/zGi0mHVmbKExuDYjRGG0R2U2zcOJDTDEy1541w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZDxVmuw9V1RJap5EfohD8J5h4O1cp9V/f94V1jGUcMUbJMckV8/IzNPKq/O7By6R
	 dbJf6/P7w+MXbze+gguEKxoK2vFnxEaKceQbSFLAtVpQhUnk3zZ7GEW8LfyxXyclw4
	 KrY2YIorcj0tr2wS0RjxT/XmaB3Fu+boefcY/EpxRaDR9aWHbpPJ5Cz3jm8jRJR789
	 urdVtYnBOPQ+d42S7deRIduaxnvv5Wsa62yPYT+W/JGARh2TwLYcM/NLst1SeRLlKV
	 bsDujyFGnSbnocdkVGLj8POY5xfMpztowTrd140tuOrAhL1fY7MLh+NWxlbrWrWht4
	 Ys4EolwpzcCEg==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 12/12] eth: bnxt: hack in the use of MEP
Date: Fri,  7 Jul 2023 11:39:35 -0700
Message-ID: <20230707183935.997267-13-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
References: <20230707183935.997267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Well, the uAPI is lacking so... module params?

No datapath changes needed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 29 ++++++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  5 ++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b36c42d37a38..e745ce1f50d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -58,6 +58,8 @@
 #include <linux/align.h>
 #include <net/netdev_queues.h>
 
+#include <net/dcalloc.h>
+
 #include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
@@ -76,6 +78,9 @@
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
 				 NETIF_MSG_TX_ERR)
 
+static int pp_mode;
+module_param(pp_mode, int, 0644);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom BCM573xx network driver");
 
@@ -2834,13 +2839,14 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 static void *bnxt_alloc_coherent(struct bnxt *bp, unsigned long size,
 				 dma_addr_t *dma, gfp_t gfp)
 {
-	return dma_alloc_coherent(&bp->pdev->dev, size, dma, gfp);
+	ASSERT_RTNL();
+	return dma_cocoa_alloc(bp->mp.dco, size, dma, gfp);
 }
 
 static void bnxt_free_coherent(struct bnxt *bp, unsigned long size,
 			       void *addr, dma_addr_t dma)
 {
-	return dma_free_coherent(&bp->pdev->dev, size, addr, dma);
+	dma_cocoa_free(bp->mp.dco, size, addr, dma);
 }
 
 static void bnxt_free_tx_skbs(struct bnxt *bp)
@@ -3220,6 +3226,8 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.napi = &rxr->bnapi->napi;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = DMA_BIDIRECTIONAL;
+	pp.memory_provider = pp_mode;
+	pp.init_arg = bp->mp.mp;
 
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
@@ -13607,6 +13615,14 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc < 0)
 		goto init_err_free;
 
+	bp->mp.mp = mep_create(&pdev->dev);
+	if (!bp->mp.mp)
+		goto init_err_pci_clean;
+
+	bp->mp.dco = dma_cocoa_create(&bp->pdev->dev, GFP_KERNEL);
+	if (!bp->mp.dco)
+		goto init_err_mep_destroy;
+
 	dev->netdev_ops = &bnxt_netdev_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
@@ -13614,7 +13630,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rc = bnxt_alloc_hwrm_resources(bp);
 	if (rc)
-		goto init_err_pci_clean;
+		goto init_err_dco_destroy;
 
 	mutex_init(&bp->hwrm_cmd_lock);
 	mutex_init(&bp->link_lock);
@@ -13788,6 +13804,11 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_shutdown_tc(bp);
 	bnxt_clear_int_mode(bp);
 
+init_err_dco_destroy:
+	dma_cocoa_destroy(bp->mp.dco);
+init_err_mep_destroy:
+	mep_destroy(bp->mp.mp);
+
 init_err_pci_clean:
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	bnxt_free_hwrm_resources(bp);
@@ -13826,6 +13847,8 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 		dev_close(dev);
 
 	bnxt_clear_int_mode(bp);
+	dma_cocoa_destroy(bp->mp.dco);
+	mep_destroy(bp->mp.mp);
 	pci_disable_device(pdev);
 
 	if (system_state == SYSTEM_POWER_OFF) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 080e73496066..9b323b27075f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2170,6 +2170,11 @@ struct bnxt {
 	struct dentry		*debugfs_pdev;
 	struct device		*hwmon_dev;
 	enum board_idx		board_idx;
+
+	struct {
+		struct mem_provider *mp;
+		struct dma_cocoa *dco;
+	} mp;
 };
 
 #define BNXT_NUM_RX_RING_STATS			8
-- 
2.41.0


