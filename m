Return-Path: <netdev+bounces-204919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C83FAFC880
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849B14A4BEE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA682D8384;
	Tue,  8 Jul 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fwgq6mfL"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590B2D6404;
	Tue,  8 Jul 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970936; cv=none; b=Gw94czT5vF86cnHz8O69uwU6uHBbwZTHuF7EoqnBmnj52gS17FeRyyG4R1SM2lzRb0xQRt20FD+noHnAUzMVXFSLH0wOyynMZTlAGUm+K843DHeEvz2wKogeouU3DhGKbA8ePmME5g9ZPOSh2sazcDJPqUo6HzOn4dtMKELkAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970936; c=relaxed/simple;
	bh=jZKGVQUcc9WCbkWkXrCZxx5fdpxjAlmnnOed/zSS7LI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JrgcP8tiJV4CfAD6j+/f/jQCMD8F4RkkZlbga+c7/uiWSC2Pti4DU31rmBVaIVsJcMdEYWkZDXanDSkyDvGg+7F5jFdQXqePdwUEnqBSBOuIWiCwyKv4me01JndOTX43GoB628Tt7ffXCbzcKDUnxrcDQtf1/xsbYWcShW7YYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fwgq6mfL; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 568AZIGc1145761;
	Tue, 8 Jul 2025 05:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751970918;
	bh=G5IpErDkbr9ApeCh6EWnviXlGifQ81eSVsUEoXpxLTY=;
	h=From:To:CC:Subject:Date;
	b=fwgq6mfLSatlxjGc0Lqh49QR+N+zDf4122ZZWfcrFDoBD6K640pAqD5mSJpDVhEEd
	 hyVQoPl8NDe72dKlL1KfXEwiHcUMs0IgOWwRYS9O4mXuzx/pTPw13RnU6Cm4wWGtU+
	 U4eZOM5HZrnF2pcMYi7LRHRejwaa7e+LQ7Mx8Rfs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 568AZINi928923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 05:35:18 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 05:35:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 05:35:17 -0500
Received: from localhost (akira.dhcp.ti.com [10.24.69.4])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 568AZGcS1624100;
	Tue, 8 Jul 2025 05:35:17 -0500
From: Himanshu Mittal <h-mittal1@ti.com>
To: <horms@kernel.org>, <h-mittal1@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, <pratheesh@ti.com>, <prajith@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix buffer allocation for ICSSG
Date: Tue, 8 Jul 2025 16:05:16 +0530
Message-ID: <20250708103516.1268876-1-h-mittal1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Fixes overlapping buffer allocation for ICSSG peripheral
used for storing packets to be received/transmitted.
There are 3 buffers:
1. Buffer for Locally Injected Packets
2. Buffer for Forwarding Packets
3. Buffer for Host Egress Packets

In existing allocation buffers for 2. and 3. are overlapping
causing packet corruption.

Packet corruption observations:
During tcp iperf testing, due to overlapping buffers the received ack packet
overwrites the packet to be transmitted. So, we see packets on wire with the
ack packet content inside the content of next TCP packet from sender device.

Fixes: abd5576b9c57 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 148 ++++++++++++------
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  77 +++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  18 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   2 +
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   3 +
 5 files changed, 176 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index ddfd1c02a885..f06494c33e9f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -288,8 +288,12 @@ static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
 	int i;
 
 	addr = lower_32_bits(prueth->msmcram.pa);
-	if (slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+	if (slice) {
+		if (prueth->pdata.banked_ms_ram)
+			addr += MSMC_RAM_BANK_SIZE;
+		else
+			addr += PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE;
+	}
 
 	if (addr % SZ_64K) {
 		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
@@ -297,43 +301,60 @@ static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
 	}
 
 	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
-	/* workaround for f/w bug. bpool 0 needs to be initialized */
-	for (i = 0; i <  PRUETH_NUM_BUF_POOLS; i++) {
+
+	/* Configure buffer pools for forwarding buffers
+	 * - used by firmware to store packets to be forwarded to other port
+	 * - 8 total pools per slice
+	 */
+	for (i = 0; i <  PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE; i++) {
 		writel(addr, &bpool_cfg[i].addr);
-		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
-		addr += PRUETH_EMAC_BUF_POOL_SIZE;
+		writel(PRUETH_SW_FWD_BUF_POOL_SIZE, &bpool_cfg[i].len);
+		addr += PRUETH_SW_FWD_BUF_POOL_SIZE;
 	}
 
-	if (!slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
-	else
-		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
-
-	for (i = PRUETH_NUM_BUF_POOLS;
-	     i < 2 * PRUETH_SW_NUM_BUF_POOLS_HOST + PRUETH_NUM_BUF_POOLS;
-	     i++) {
-		/* The driver only uses first 4 queues per PRU so only initialize them */
-		if (i % PRUETH_SW_NUM_BUF_POOLS_HOST < PRUETH_SW_NUM_BUF_POOLS_PER_PRU) {
-			writel(addr, &bpool_cfg[i].addr);
-			writel(PRUETH_SW_BUF_POOL_SIZE_HOST, &bpool_cfg[i].len);
-			addr += PRUETH_SW_BUF_POOL_SIZE_HOST;
+	/* Configure buffer pools for Local Injection buffers
+	 *  - used by firmware to store packets received from host core
+	 *  - 16 total pools per slice
+	 */
+	for (i = 0; i < PRUETH_NUM_LI_BUF_POOLS_PER_SLICE; i++) {
+		/* The driver only uses first 4 queues per PRU so only initialize buffer for them */
+		if ((i % PRUETH_NUM_LI_BUF_POOLS_PER_PORT_PER_SLICE)
+			 < PRUETH_SW_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE) {
+			writel(addr, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].addr);
+			writel(PRUETH_SW_LI_BUF_POOL_SIZE,
+			       &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].len);
+			addr += PRUETH_SW_LI_BUF_POOL_SIZE;
 		} else {
-			writel(0, &bpool_cfg[i].addr);
-			writel(0, &bpool_cfg[i].len);
+			writel(0, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].addr);
+			writel(0, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].len);
 		}
 	}
 
-	if (!slice)
-		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
-	else
-		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	/* Express RX buffer queue
+	 *  - used by firmware to store express packets to be transmitted to host core
+	 */
+	rxq_ctx = emac->dram.va + HOST_RX_Q_EXP_CONTEXT_OFFSET;
+	for (i = 0; i < 3; i++)
+		writel(addr, &rxq_ctx->start[i]);
+
+	addr += PRUETH_SW_HOST_EXP_BUF_POOL_SIZE;
+	writel(addr, &rxq_ctx->end);
 
+	/* Pre-emptible RX buffer queue
+	 *  - used by firmware to store preemptible packets to be transmitted to host core
+	 */
 	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
 	for (i = 0; i < 3; i++)
 		writel(addr, &rxq_ctx->start[i]);
 
-	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
-	writel(addr - SZ_2K, &rxq_ctx->end);
+	addr += PRUETH_SW_HOST_PRE_BUF_POOL_SIZE;
+	writel(addr, &rxq_ctx->end);
+
+	/* Set pointer for default dropped packet write
+	 *  - used by firmware to temporarily store packet to be dropped
+	 */
+	rxq_ctx = emac->dram.va + DEFAULT_MSMC_Q_OFFSET;
+	writel(addr, &rxq_ctx->start[0]);
 
 	return 0;
 }
@@ -347,13 +368,13 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 	u32 addr;
 	int i;
 
-	/* Layout to have 64KB aligned buffer pool
-	 * |BPOOL0|BPOOL1|RX_CTX0|RX_CTX1|
-	 */
-
 	addr = lower_32_bits(prueth->msmcram.pa);
-	if (slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+	if (slice) {
+		if (prueth->pdata.banked_ms_ram)
+			addr += MSMC_RAM_BANK_SIZE;
+		else
+			addr += PRUETH_EMAC_TOTAL_BUF_SIZE_PER_SLICE;
+	}
 
 	if (addr % SZ_64K) {
 		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
@@ -361,39 +382,62 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 	}
 
 	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
-	/* workaround for f/w bug. bpool 0 needs to be initilalized */
-	writel(addr, &bpool_cfg[0].addr);
-	writel(0, &bpool_cfg[0].len);
 
-	for (i = PRUETH_EMAC_BUF_POOL_START;
-	     i < PRUETH_EMAC_BUF_POOL_START + PRUETH_NUM_BUF_POOLS;
-	     i++) {
-		writel(addr, &bpool_cfg[i].addr);
-		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
-		addr += PRUETH_EMAC_BUF_POOL_SIZE;
+	/* Configure buffer pools for forwarding buffers
+	 *  - in mac mode - no forwarding by firmware so initialize all pools to 0
+	 *  - 8 total pools per slice
+	 */
+	for (i = 0; i <  PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE; i++) {
+		writel(0, &bpool_cfg[i].addr);
+		writel(0, &bpool_cfg[i].len);
 	}
 
-	if (!slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
-	else
-		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE * 2;
+	/* Configure buffer pools for Local Injection buffers
+	 *  - used by firmware to store packets received from host core
+	 *  - 16 total pools per slice
+	 */
+	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
+	for (i = 0; i < PRUETH_NUM_LI_BUF_POOLS_PER_SLICE; i++) {
+		/* In EMAC mode, only first 4 buffers are used,
+		 * as 1 slice needs to handle only 1 port
+		 */
+		if (i < PRUETH_EMAC_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE) {
+			writel(addr, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].addr);
+			writel(PRUETH_EMAC_LI_BUF_POOL_SIZE,
+			       &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].len);
+			addr += PRUETH_EMAC_LI_BUF_POOL_SIZE;
+		} else {
+			writel(0, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].addr);
+			writel(0, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].len);
+		}
+	}
 
-	/* Pre-emptible RX buffer queue */
-	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
+	/* Express RX buffer queue
+	 *  - used by firmware to store express packets to be transmitted to host core
+	 */
+	rxq_ctx = emac->dram.va + HOST_RX_Q_EXP_CONTEXT_OFFSET;
 	for (i = 0; i < 3; i++)
 		writel(addr, &rxq_ctx->start[i]);
 
-	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	addr += PRUETH_EMAC_HOST_EXP_BUF_POOL_SIZE;
 	writel(addr, &rxq_ctx->end);
 
-	/* Express RX buffer queue */
-	rxq_ctx = emac->dram.va + HOST_RX_Q_EXP_CONTEXT_OFFSET;
+	/* Pre-emptible RX buffer queue
+	 *  - used by firmware to store preemptible packets to be transmitted to host core
+	 */
+	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
 	for (i = 0; i < 3; i++)
 		writel(addr, &rxq_ctx->start[i]);
 
-	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	addr += PRUETH_EMAC_HOST_PRE_BUF_POOL_SIZE;
 	writel(addr, &rxq_ctx->end);
 
+	/* Set pointer for default dropped packet write
+	 *  - used by firmware to temporarily store packet to be dropped
+	 */
+	rxq_ctx = emac->dram.va + DEFAULT_MSMC_Q_OFFSET;
+	writel(addr, &rxq_ctx->start[0]);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index c884e9fa099e..361cc9f5b24d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -26,21 +26,68 @@ struct icssg_flow_cfg {
 #define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
 #define PRUETH_RX_FLOW_DATA	0
 
-#define PRUETH_EMAC_BUF_POOL_SIZE	SZ_8K
-#define PRUETH_EMAC_POOLS_PER_SLICE	24
-#define PRUETH_EMAC_BUF_POOL_START	8
-#define PRUETH_NUM_BUF_POOLS	8
-#define PRUETH_EMAC_RX_CTX_BUF_SIZE	SZ_16K	/* per slice */
-#define MSMC_RAM_SIZE	\
-	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
-	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
-
-#define PRUETH_SW_BUF_POOL_SIZE_HOST	SZ_4K
-#define PRUETH_SW_NUM_BUF_POOLS_HOST	8
-#define PRUETH_SW_NUM_BUF_POOLS_PER_PRU 4
-#define MSMC_RAM_SIZE_SWITCH_MODE \
-	(MSMC_RAM_SIZE + \
-	(2 * PRUETH_SW_BUF_POOL_SIZE_HOST * PRUETH_SW_NUM_BUF_POOLS_HOST))
+/* Defines for forwarding path buffer pools:
+ *   - used by firmware to store packets to be forwarded to other port
+ *   - 8 total pools per slice
+ *   - only used in switch mode (as no forwarding in mac mode)
+ */
+#define PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE			8
+#define PRUETH_SW_FWD_BUF_POOL_SIZE				(SZ_8K)
+
+/* Defines for local injection path buffer pools:
+ *   - used by firmware to store packets received from host core
+ *   - 16 total pools per slice
+ *   - 8 pools per port per slice and each slice handles both ports
+ *   - only 4 out of 8 pools used per port (as only 4 real QoS levels in ICSSG)
+ *   - switch mode: 8 total pools used
+ *   - mac mode:    4 total pools used
+ */
+#define PRUETH_NUM_LI_BUF_POOLS_PER_SLICE			16
+#define PRUETH_NUM_LI_BUF_POOLS_PER_PORT_PER_SLICE		8
+#define PRUETH_SW_LI_BUF_POOL_SIZE				SZ_4K
+#define PRUETH_SW_USED_LI_BUF_POOLS_PER_SLICE			8
+#define PRUETH_SW_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE		4
+#define PRUETH_EMAC_LI_BUF_POOL_SIZE				SZ_8K
+#define PRUETH_EMAC_USED_LI_BUF_POOLS_PER_SLICE			4
+#define PRUETH_EMAC_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE	4
+
+/* Defines for host egress path - express and preemptible buffers
+ *   - used by firmware to store express and preemptible packets
+ *     to be transmitted to host core
+ *   - used by both mac/switch modes
+ */
+#define PRUETH_SW_HOST_EXP_BUF_POOL_SIZE	SZ_16K
+#define PRUETH_SW_HOST_PRE_BUF_POOL_SIZE	(SZ_16K - SZ_2K)
+#define PRUETH_EMAC_HOST_EXP_BUF_POOL_SIZE	PRUETH_SW_HOST_EXP_BUF_POOL_SIZE
+#define PRUETH_EMAC_HOST_PRE_BUF_POOL_SIZE	PRUETH_SW_HOST_PRE_BUF_POOL_SIZE
+
+/* Buffer used by firmware to temporarily store packet to be dropped */
+#define PRUETH_SW_DROP_PKT_BUF_SIZE		SZ_2K
+#define PRUETH_EMAC_DROP_PKT_BUF_SIZE		PRUETH_SW_DROP_PKT_BUF_SIZE
+
+/* Total switch mode memory usage for buffers per slice */
+#define PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE \
+	(PRUETH_SW_FWD_BUF_POOL_SIZE * PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE + \
+	 PRUETH_SW_LI_BUF_POOL_SIZE * PRUETH_SW_USED_LI_BUF_POOLS_PER_SLICE + \
+	 PRUETH_SW_HOST_EXP_BUF_POOL_SIZE + \
+	 PRUETH_SW_HOST_PRE_BUF_POOL_SIZE + \
+	 PRUETH_SW_DROP_PKT_BUF_SIZE)
+
+/* Total switch mode memory usage for all buffers */
+#define PRUETH_SW_TOTAL_BUF_SIZE		(2 * PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE)
+
+/* Total mac mode memory usage for buffers per slice */
+#define PRUETH_EMAC_TOTAL_BUF_SIZE_PER_SLICE \
+	(PRUETH_EMAC_LI_BUF_POOL_SIZE * PRUETH_EMAC_USED_LI_BUF_POOLS_PER_SLICE + \
+	 PRUETH_EMAC_HOST_EXP_BUF_POOL_SIZE + \
+	 PRUETH_EMAC_HOST_PRE_BUF_POOL_SIZE + \
+	 PRUETH_EMAC_DROP_PKT_BUF_SIZE)
+
+/* Total mac mode memory usage for all buffers */
+#define PRUETH_EMAC_TOTAL_BUF_SIZE		(2 * PRUETH_EMAC_TOTAL_BUF_SIZE_PER_SLICE)
+
+/* Size of 1 bank of MSMC/OC_SRAM memory */
+#define MSMC_RAM_BANK_SIZE			SZ_256K
 
 #define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 86fc1278127c..18c370c252aa 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1764,10 +1764,15 @@ static int prueth_probe(struct platform_device *pdev)
 		goto put_mem;
 	}
 
-	msmc_ram_size = MSMC_RAM_SIZE;
 	prueth->is_switchmode_supported = prueth->pdata.switch_mode;
-	if (prueth->is_switchmode_supported)
-		msmc_ram_size = MSMC_RAM_SIZE_SWITCH_MODE;
+	if (prueth->pdata.banked_ms_ram) {
+		/* Reserve 2 banks of MSMC RAM for buffers to avoid arbitration */
+		msmc_ram_size = (2 * MSMC_RAM_BANK_SIZE);
+	} else {
+		msmc_ram_size = PRUETH_EMAC_TOTAL_BUF_SIZE;
+		if (prueth->is_switchmode_supported)
+			msmc_ram_size = PRUETH_SW_TOTAL_BUF_SIZE;
+	}
 
 	/* NOTE: FW bug needs buffer base to be 64KB aligned */
 	prueth->msmcram.va =
@@ -1924,7 +1929,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 free_pool:
 	gen_pool_free(prueth->sram_pool,
-		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
+		      (unsigned long)prueth->msmcram.va,
+		      prueth->msmcram.size);
 
 put_mem:
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
@@ -1977,7 +1983,7 @@ static void prueth_remove(struct platform_device *pdev)
 
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va,
-		      MSMC_RAM_SIZE);
+		      prueth->msmcram.size);
 
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
 
@@ -1994,12 +2000,14 @@ static const struct prueth_pdata am654_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 	.quirk_10m_link_issue = 1,
 	.switch_mode = 1,
+	.banked_ms_ram = 0,
 };
 
 static const struct prueth_pdata am64x_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
 	.quirk_10m_link_issue = 1,
 	.switch_mode = 1,
+	.banked_ms_ram = 1,
 };
 
 static const struct of_device_id prueth_dt_match[] = {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 23c465f1ce7f..3bb9fd8c3804 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -251,11 +251,13 @@ struct prueth_emac {
  * @fdqring_mode: Free desc queue mode
  * @quirk_10m_link_issue: 10M link detect errata
  * @switch_mode: switch firmware support
+ * @banked_ms_ram: banked memory support
  */
 struct prueth_pdata {
 	enum k3_ring_mode fdqring_mode;
 	u32	quirk_10m_link_issue:1;
 	u32	switch_mode:1;
+	u32	banked_ms_ram:1;
 };
 
 struct icssg_firmwares {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 490a9cc06fb0..7e053b8af3ec 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -180,6 +180,9 @@
 /* Used to notify the FW of the current link speed */
 #define PORT_LINK_SPEED_OFFSET                             0x00A8
 
+/* 2k memory pointer reserved for default writes by PRU0*/
+#define DEFAULT_MSMC_Q_OFFSET                              0x00AC
+
 /* TAS gate mask for windows list0 */
 #define TAS_GATE_MASK_LIST0                                0x0100
 
-- 
2.34.1


