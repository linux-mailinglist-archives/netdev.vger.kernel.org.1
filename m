Return-Path: <netdev+bounces-110955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 744FC92F1B8
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242811F226D0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457A1A08BA;
	Thu, 11 Jul 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWV3FpY7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501B1A0705
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735643; cv=none; b=MmC2E7bLezzvJ2Cj6fwu9mjD+++o2GhVxgMITbcvkUNz2m90tTkaMS/abAEXEPOmI53VdwSV7uEicYiWs2nj96Ksyp8UZysqpbapg1rrjrmtwdZA129EVRF7uCoUvdbVr9NQay37rAaedOcakcDK4lrbwGIEjEczSPsGlcPH4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735643; c=relaxed/simple;
	bh=PzAeenRjo5OdxcNqBQZYS5U0OjJsATYXdam/0EC34gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOsYiF/GfKqtCkEydWWidHm8GtbXZgKX6tK1bHjoJFItQq8MMYD3/LoMhjXhFyStZbdZnMxviUE9BY4KB99sHDHXp/hqpWPfElBU8CCCoCPrl4X6jHjnwqUEezwbPrVyMT/x7hpm41EOeVpQojPwF1Jk1Aq2v8cR9wPkywwarDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWV3FpY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25348C116B1;
	Thu, 11 Jul 2024 22:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735643;
	bh=PzAeenRjo5OdxcNqBQZYS5U0OjJsATYXdam/0EC34gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWV3FpY7oLHGZGogTKo9KG6442ZWlCdOkXFoK/+Q99uIathFI2PJsTcTniou1FE5B
	 GVEMrIvN1pTZL3LXDmF3+86J+dcil8Lunm31LbPdWTAJjcXHugR5Mxijg0x3E9OQzZ
	 S1jnPJmInwEKD+QyVT8ogYdXDqnFg4qUf0o5s8haEIDCKk9T6KuvSExWIjzXGjUAYX
	 WzmjW4jEi9aK/TtOs2MdJQrpglfC37JnPouvO40H/ZmyG8fRmVfZHFHu7ECtb7fB59
	 TLws4gfDDcK9TlapK6oVcERCyRnEYSfaUbDWv/JhnDbg4E/4yOI/ub5SBGeSFgSuxp
	 IUcvCA1bMQGaw==
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
Subject: [PATCH net-next 06/11] eth: bnxt: depend on core cleaning up RSS contexts
Date: Thu, 11 Jul 2024 15:07:08 -0700
Message-ID: <20240711220713.283778-7-kuba@kernel.org>
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

New RSS context API removes old contexts on netdev unregister.
No need to wipe them manually.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 11 ++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 026ceaa0b329..d6a4ce5066c6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10274,12 +10274,12 @@ struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp)
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
@@ -12331,7 +12331,7 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 		msleep(20);
 
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, false);
+		bnxt_clear_rss_ctxs(bp);
 	/* Flush rings and disable interrupts */
 	bnxt_shutdown_nic(bp, irq_re_init);
 
@@ -15246,8 +15246,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
-	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, true);
+	WARN_ON(bp->num_rss_ctx);
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	/* Flush any pending tasks */
 	cancel_work_sync(&bp->sp_task);
@@ -15898,8 +15897,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_clear_int_mode(bp);
 
 init_err_pci_clean:
-	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, true);
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	bnxt_free_hwrm_resources(bp);
 	bnxt_hwmon_uninit(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9b0c6656ce27..df96524a8b8b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2847,7 +2847,7 @@ int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all);
 struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp);
-void bnxt_clear_rss_ctxs(struct bnxt *bp, bool all);
+void bnxt_clear_rss_ctxs(struct bnxt *bp);
 int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 04855846b5f6..5a64c0ea56c0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -976,7 +976,7 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_clear_usr_fltrs(bp, true);
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp, false);
+		bnxt_clear_rss_ctxs(bp);
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
-- 
2.45.2


