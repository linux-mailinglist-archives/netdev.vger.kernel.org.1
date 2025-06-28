Return-Path: <netdev+bounces-202118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA426AEC51D
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E847D7A5FF7
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 05:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B121FF4C;
	Sat, 28 Jun 2025 05:14:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92A21E096;
	Sat, 28 Jun 2025 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751087648; cv=none; b=dX/7uIlHODhC5ka9WUsgxewxbv8Z2JL/heBraYHlwbz5Rt/pH4QEVjE1LV8i1yeEmcjq+HakaMr8wZ+ZclqTz6Z8cahodS0TeIa7gDSLd7vvArgFbHYE5xq4o470hLaOEa5YOfDLwbnHq71yfEWEuP0Uip5Dv24C+I4KKRqHrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751087648; c=relaxed/simple;
	bh=7ULAcR7l6YzyP86zeJHo/lnotJWcuRd6OcaoQrCIonQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQn8M0SdeZrCbrGtQxiGuDZMZC3WNypXSmvYzDFbW/fRnHJzoIESC8bpW+7X0Fq62xPulz7SSWfj7PAk6PcxCMgo7V9Yd7hqRXbH7NjTkj5uqka2Ue7IAN7Hc1ymSsv3NyIv4xJnnWdn/UcJ4FucvdWIX9irnBa7UJGas0bn3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <ecree.xilinx@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH net-next] sfc: eliminate xdp_rxq_info_valid using XDP base API
Date: Sat, 28 Jun 2025 13:10:16 +0800
Message-ID: <20250628051016.51022-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

Commit eb9a36be7f3e ("sfc: perform XDP processing on received packets")
use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
However, this driver-maintained state becomes redundant since the XDP
framework already provides xdp_rxq_info_is_reg() for checking registration
status.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/net/ethernet/sfc/net_driver.h | 2 --
 drivers/net/ethernet/sfc/rx_common.c  | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

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
-- 
2.36.1


