Return-Path: <netdev+bounces-108634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C1924C59
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2401C222CA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98F191F74;
	Tue,  2 Jul 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHHRWfmg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F8191F6E
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964104; cv=none; b=Zq7tjjun5g7juNyi8DlgTJIr1rg3DmcYAChtbxFIhJcmPEOIln8w154jukqgq/Kq6zUuYAHgjIVYMtI7eS61CK/bQygOfBDXtVBQ2LFZGuWsc6+RA8hWpbOEDiD/fJuykU0DZDHE+gnpPEOL4yB3nKB1FINgLGF9HrLL7uTa2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964104; c=relaxed/simple;
	bh=J4NkYTbrHWMHR6UzVquUafYcm+l8zOYZc5aPwOnbdrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1FivZC3YQ3fwq60fAHNEmiamEn6Ybz1qZPahpzrotn9yDkiOiHBU0N0SuyUYwHlVVxpSm6s8ZT/jkhrsiIzYzWFZ+mnxsKBRbMf43S18QUW4eHFf5KIftOCTXR/yttsfnMfVWf1Xsr1zSv8AMxpsJ/MmTALeXhQeInWu8HHScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHHRWfmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D18FC32781;
	Tue,  2 Jul 2024 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964104;
	bh=J4NkYTbrHWMHR6UzVquUafYcm+l8zOYZc5aPwOnbdrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHHRWfmg4iZaoLYJSHt9d5UV/G9QKjQR/R93mB9XciuNbGxNrMLqBpNKE3bi4Yc5/
	 K5ptLgoDLY9kyK1jus2jcWJPiH3zSm99YZ9m5qTUDZXcOCnzog56Z17jzOHE8jqNJ+
	 HJrIti9OtenB8vQ+OOOitfm7W7IZz3XUynvnx8NG35Z6lRKfQ2tFQn6kVcW0No6FqE
	 wCDV0ydue9jQ65UIOVHZo6SiDyr17c6Mz7JGD03jUFiyFnU6O5Fws2ErT/ylCEisMt
	 jv3JbyNmAj6+HeppcVFZRsk6p8YDBCMBc5JN+Eo5RsL5tEdo/1pDH/hfvqQzh0yn1q
	 KNhe51PeaLLGw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/11] eth: bnxt: depend on core cleaning up RSS contexts
Date: Tue,  2 Jul 2024 16:47:52 -0700
Message-ID: <20240702234757.4188344-8-kuba@kernel.org>
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

New RSS context API removes old contexts on netdev unregister.
No need to wipe them manually.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 11 ++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 02aeba4b5df5..b6915261c15d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10259,12 +10259,12 @@ struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp)
 	return rss_ctx;
 }
 
-void bnxt_clear_rss_ctxs(struct bnxt *bp, bool all)
+void bnxt_clear_rss_ctxs(struct bnxt *bp)
 {
 	struct bnxt_rss_ctx *rss_ctx, *tmp;
 
 	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list)
-		bnxt_del_one_rss_ctx(bp, rss_ctx, all);
+		bnxt_del_one_rss_ctx(bp, rss_ctx, false);
 }
 
 static void bnxt_init_multi_rss_ctx(struct bnxt *bp)
@@ -12316,7 +12316,7 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 		msleep(20);
 
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, false);
+		bnxt_clear_rss_ctxs(bp);
 	/* Flush rings and disable interrupts */
 	bnxt_shutdown_nic(bp, irq_re_init);
 
@@ -15227,8 +15227,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
-	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, true);
+	WARN_ON(bp->num_rss_ctx);
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	/* Flush any pending tasks */
 	cancel_work_sync(&bp->sp_task);
@@ -15879,8 +15878,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_clear_int_mode(bp);
 
 init_err_pci_clean:
-	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, true);
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	bnxt_free_hwrm_resources(bp);
 	bnxt_hwmon_uninit(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f4365a840e3a..04c4ff7b9052 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2846,7 +2846,7 @@ int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all);
 struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp);
-void bnxt_clear_rss_ctxs(struct bnxt *bp, bool all);
+void bnxt_clear_rss_ctxs(struct bnxt *bp);
 int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 48f8e14685a1..397aedad3d4f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -970,7 +970,7 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_clear_usr_fltrs(bp, true);
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, false);
+		bnxt_clear_rss_ctxs(bp);
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
-- 
2.45.2


