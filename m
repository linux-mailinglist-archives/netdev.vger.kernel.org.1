Return-Path: <netdev+bounces-201641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61054AEA322
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE18189BFEA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7B1A073F;
	Thu, 26 Jun 2025 16:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA9143C61;
	Thu, 26 Jun 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953653; cv=none; b=tzhktaTLQ949Mt3gbjmlEUSE8Aov5I1nBO70dTgGEOv2Pa/8WXqOoA6/H10hp4o/if2zLVi0RkX5/UwxTmCkjjAtdDwPOrnAPqrOfGnMpPqRbbBtkpKCf7oH0FtdPSmTxQ559lBWH0XRcAjJFES2dN/5Ye99T39AS2HMNvedy6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953653; c=relaxed/simple;
	bh=J4tCCktPmGM3U1s1ptTUChJ1yAHdZVeGT4zyCyvF5J0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wa6rCUnZBb1edLMYveojxKObrxQL/ve4ry1/ryfngKRRrxKmfmFTLB/XxXz065so8okCggIk01sHYaeQETbYpwBBHTXgljcOHzh9bLAuVI/OcVGeVFdSIqXsKbCDcVF+E+C4+wLDgno4e06f4RX1TOZeaPl6JdF8pQByRpJJIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <ecree.xilinx@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH net-next] sfc: siena: eliminate xdp_rxq_info_valid using XDP base API
Date: Thu, 26 Jun 2025 23:59:59 +0800
Message-ID: <20250626155959.88051-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

Commit eb9a36be7f3e ("sfc: perform XDP processing on received packets")
and commit d48523cb88e0 ("sfc: Copy shared files needed for Siena
(part 2)") use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
However, this driver-maintained state becomes redundant since the XDP
framework already provides xdp_rxq_info_is_reg() for checking registration
status.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/net/ethernet/sfc/net_driver.h       | 2 --
 drivers/net/ethernet/sfc/rx_common.c        | 6 +-----
 drivers/net/ethernet/sfc/siena/net_driver.h | 2 --
 drivers/net/ethernet/sfc/siena/rx_common.c  | 6 +-----
 4 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 5c0f306fb019..b98c259f672d 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -404,7 +404,6 @@ struct efx_rx_page_state {
  * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
  * @old_rx_bytes: Value of @rx_bytes as of last efx_init_rx_queue()
  * @xdp_rxq_info: XDP specific RX queue information.
- * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
  */
 struct efx_rx_queue {
 	struct efx_nic *efx;
@@ -443,7 +442,6 @@ struct efx_rx_queue {
 	unsigned long old_rx_packets;
 	unsigned long old_rx_bytes;
 	struct xdp_rxq_info xdp_rxq_info;
-	bool xdp_rxq_info_valid;
 };
 
 enum efx_sync_events_state {
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index f4f75299dfa9..5306f4c44be4 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -269,8 +269,6 @@ void efx_init_rx_queue(struct efx_rx_queue *rx_queue)
 			  "Failure to initialise XDP queue information rc=%d\n",
 			  rc);
 		efx->xdp_rxq_info_failed = true;
-	} else {
-		rx_queue->xdp_rxq_info_valid = true;
 	}
 
 	/* Set up RX descriptor ring */
@@ -302,10 +300,8 @@ void efx_fini_rx_queue(struct efx_rx_queue *rx_queue)
 
 	efx_fini_rx_recycle_ring(rx_queue);
 
-	if (rx_queue->xdp_rxq_info_valid)
+	if (xdp_rxq_info_is_reg(&rx_queue->xdp_rxq_info))
 		xdp_rxq_info_unreg(&rx_queue->xdp_rxq_info);
-
-	rx_queue->xdp_rxq_info_valid = false;
 }
 
 void efx_remove_rx_queue(struct efx_rx_queue *rx_queue)
diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
index 2be3bad3c993..4cf556782133 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -384,7 +384,6 @@ struct efx_rx_page_state {
  * @recycle_count: RX buffer recycle counter.
  * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
  * @xdp_rxq_info: XDP specific RX queue information.
- * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
  */
 struct efx_rx_queue {
 	struct efx_nic *efx;
@@ -417,7 +416,6 @@ struct efx_rx_queue {
 	/* Statistics to supplement MAC stats */
 	unsigned long rx_packets;
 	struct xdp_rxq_info xdp_rxq_info;
-	bool xdp_rxq_info_valid;
 };
 
 enum efx_sync_events_state {
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 98d27174015d..4ae09505e417 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -268,8 +268,6 @@ void efx_siena_init_rx_queue(struct efx_rx_queue *rx_queue)
 			  "Failure to initialise XDP queue information rc=%d\n",
 			  rc);
 		efx->xdp_rxq_info_failed = true;
-	} else {
-		rx_queue->xdp_rxq_info_valid = true;
 	}
 
 	/* Set up RX descriptor ring */
@@ -299,10 +297,8 @@ void efx_siena_fini_rx_queue(struct efx_rx_queue *rx_queue)
 
 	efx_fini_rx_recycle_ring(rx_queue);
 
-	if (rx_queue->xdp_rxq_info_valid)
+	if (xdp_rxq_info_is_reg(&rx_queue->xdp_rxq_info))
 		xdp_rxq_info_unreg(&rx_queue->xdp_rxq_info);
-
-	rx_queue->xdp_rxq_info_valid = false;
 }
 
 void efx_siena_remove_rx_queue(struct efx_rx_queue *rx_queue)
-- 
2.36.1


