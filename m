Return-Path: <netdev+bounces-202119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77161AEC520
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61A617DDDB
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 05:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0B1487D1;
	Sat, 28 Jun 2025 05:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2E2111;
	Sat, 28 Jun 2025 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751087764; cv=none; b=XVyaNomVP1wIyB7iIBSnlTtQSI5AcoyNQpEH9rG3H/Zp5AfGnGQ8umcFu5jszW9SK/0GoM1u+XTM2GrKQ0ggX5nLGGx1IYY1FIOqXH/Nq101MMbbZbS3Ya3T6xjntScHYOTclEBp2Y17VweScyBiZ63IEnnAbbnzppXG2b7BTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751087764; c=relaxed/simple;
	bh=znJpnjGHe9qC23nhYpBqirFXtlcJ2hX0/8+ege+12fE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tADjoIrpitQsxmHRwzhxNlVfLmkjK9livHefHPqF/QLzW5VHlAKA7jtVcGYUk6WTGZrkJCsNflOEbJuC28DtZ0vsqilQ+sfbpNuHMqJxcLdROtFue3qrdhEpS8HZDs7RX7ucunegjy7dBJBipPwtdxe46eU3V3+zp0+LcCFQs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <ecree.xilinx@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH net-next v2] sfc: siena: eliminate xdp_rxq_info_valid using XDP base API
Date: Sat, 28 Jun 2025 13:10:33 +0800
Message-ID: <20250628051033.51133-1-wangfushuai@baidu.com>
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

Commit d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
However, this driver-maintained state becomes redundant since the XDP
framework already provides xdp_rxq_info_is_reg() for checking registration
status.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/net/ethernet/sfc/siena/net_driver.h | 2 --
 drivers/net/ethernet/sfc/siena/rx_common.c  | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

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


