Return-Path: <netdev+bounces-59000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF23818E96
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED569287A2D
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE953B781;
	Tue, 19 Dec 2023 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="g+WQUHmn"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F36E37D29
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231219174628970a525744b30b6d91
        for <netdev@vger.kernel.org>;
        Tue, 19 Dec 2023 18:46:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5DKysxN+FJbGA3PAbQCXZSkO0o69PiWU8qE7zhgUVdA=;
 b=g+WQUHmnBiToVx329Ln7PXAVfM9a70oY1RZ/cAdbnWQEvJuo/JH2cnDmiw6c5eORa+RGxx
 fplAynUU2BVCRwx55p/r4or1qLdnjfijjHkqMEt1s0VyAIfBDmlYHvdnY+VjaRlwbWwWv9aR
 HbGlarQoDfN1d3Ypn7lCe5vGUDU10=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	dan.carpenter@linaro.org,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC PATCH net-next 2/8] net: ti: icssg-config: add SR1.0-specific configuration bits
Date: Tue, 19 Dec 2023 17:45:40 +0000
Message-ID: <20231219174548.3481-3-diogo.ivo@siemens.com>
In-Reply-To: <20231219174548.3481-1-diogo.ivo@siemens.com>
References: <20231219174548.3481-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Add required definitions and structures to properly describe
SR 1.0 devices where they differ from SR2.0.

Based on the work of Roger Quadros, Murali Karicheri and
Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.h | 61 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 16 ++---
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 43eb0922172a..bbc652bda2fd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -23,15 +23,24 @@ struct icssg_flow_cfg {
 #define PRUETH_NAV_SW_DATA_SIZE	16	/* SW related data size */
 #define PRUETH_MAX_TX_DESC	512
 #define PRUETH_MAX_RX_DESC	512
-#define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
-#define PRUETH_RX_FLOW_DATA	0
+#define PRUETH_MAX_RX_FLOWS_SR1	4	/* excluding default flow */
+#define PRUETH_MAX_RX_FLOWS_SR2	1	/* excluding default flow */
+#define PRUETH_RX_FLOW_DATA_SR1	3       /* highest priority flow */
+#define PRUETH_RX_FLOW_DATA_SR2	0
+
+/* SR1.0 only */
+#define PRUETH_MAX_RX_MGM_DESC		8
+#define PRUETH_MAX_RX_MGM_FLOWS		2	/* excluding default flow */
+#define PRUETH_RX_MGM_FLOW_RESPONSE	0
+#define PRUETH_RX_MGM_FLOW_TIMESTAMP	1
 
 #define PRUETH_EMAC_BUF_POOL_SIZE	SZ_8K
 #define PRUETH_EMAC_POOLS_PER_SLICE	24
 #define PRUETH_EMAC_BUF_POOL_START	8
 #define PRUETH_NUM_BUF_POOLS	8
 #define PRUETH_EMAC_RX_CTX_BUF_SIZE	SZ_16K	/* per slice */
-#define MSMC_RAM_SIZE	\
+#define MSMC_RAM_SIZE_SR1	(SZ_64K + SZ_32K + SZ_2K) /* 0x1880 x 8 x 2 */
+#define MSMC_RAM_SIZE_SR2	\
 	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
 	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
 
@@ -94,6 +103,13 @@ enum icssg_port_state_cmd {
 #define EMAC_ACCEPT_TAG     0xfffe0002
 #define EMAC_ACCEPT_PRIOR   0xfffc0000
 
+#define PRUETH_NUM_BUF_POOLS_SR1		16
+#define PRUETH_EMAC_BUF_POOL_START_SR1		8
+#define PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1	128
+#define PRUETH_EMAC_BUF_SIZE_SR1		1536
+#define PRUETH_EMAC_NUM_BUF_SR1			4
+#define PRUETH_EMAC_BUF_POOL_SIZE_SR1	(PRUETH_EMAC_NUM_BUF_SR1 * \
+					 PRUETH_EMAC_BUF_SIZE_SR1)
 /* Config area lies in DRAM */
 #define ICSSG_CONFIG_OFFSET	0x0
 
@@ -101,6 +117,45 @@ enum icssg_port_state_cmd {
 #define ICSSG_CONFIG_OFFSET_SLICE0   0
 #define ICSSG_CONFIG_OFFSET_SLICE1   0x8000
 
+struct icssg_config_sr1 {
+	__le32 status;		/* Firmware status */
+	__le32 addr_lo;		/* MSMC Buffer pool base address low. */
+	__le32 addr_hi;		/* MSMC Buffer pool base address high. Must be 0 */
+	__le32 tx_buf_sz[16];	/* Array of buffer pool sizes */
+	__le32 num_tx_threads;	/* Number of active egress threads, 1 to 4 */
+	__le32 tx_rate_lim_en;	/* Bitmask: Egress rate limit en per thread */
+	__le32 rx_flow_id;	/* RX flow id for first rx ring */
+	__le32 rx_mgr_flow_id;	/* RX flow id for the first management ring */
+	__le32 flags;		/* TBD */
+	__le32 n_burst;		/* for debug */
+	__le32 rtu_status;	/* RTU status */
+	__le32 info;		/* reserved */
+	__le32 reserve;
+	__le32 rand_seed;	/* Used for the random number generation at fw */
+} __packed;
+
+/* SR1.0 shutdown command to stop processing at firmware.
+ * Command format : 0x8101ss00. ss - sequence number. Currently not used
+ * by driver.
+ */
+#define ICSSG_SHUTDOWN_CMD		0x81010000
+
+/* SR1.0 pstate speed/duplex command to set speed and duplex settings
+ * in firmware.
+ * Command format : 0x8102ssPN. ss - sequence number: currently not
+ * used by driver, P - port number: For switch, N - Speed/Duplex state
+ * - Possible values of N:
+ * 0x0 - 10Mbps/Half duplex ;
+ * 0x8 - 10Mbps/Full duplex ;
+ * 0x2 - 100Mbps/Half duplex;
+ * 0xa - 100Mbps/Full duplex;
+ * 0xc - 1Gbps/Full duplex;
+ * NOTE: The above are same as bits [3..1](slice 0) or bits [8..6](slice 1) of
+ * RGMII CFG register. So suggested to read the register to populate the command
+ * bits.
+ */
+#define ICSSG_PSTATE_SPEED_DUPLEX_CMD	0x81020000
+
 #define ICSSG_NUM_NORMAL_PDS	64
 #define ICSSG_NUM_SPECIAL_PDS	16
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 411898a4f38c..63f9bbea8237 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1058,8 +1058,8 @@ static void emac_adjust_link(struct net_device *ndev)
 static int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 {
 	struct prueth_emac *emac = prueth_napi_to_emac(napi_rx);
-	int rx_flow = PRUETH_RX_FLOW_DATA;
-	int flow = PRUETH_MAX_RX_FLOWS;
+	int rx_flow = PRUETH_RX_FLOW_DATA_SR2;
+	int flow = PRUETH_MAX_RX_FLOWS_SR2;
 	int num_rx = 0;
 	int cur_budget;
 	int ret;
@@ -1345,7 +1345,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS;
+	max_rx_flows = PRUETH_MAX_RX_FLOWS_SR2;
 	ret = prueth_init_rx_chns(emac, &emac->rx_chns, "rx",
 				  max_rx_flows, PRUETH_MAX_RX_DESC);
 	if (ret) {
@@ -1358,7 +1358,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		goto cleanup_rx;
 
 	/* we use only the highest priority flow for now i.e. @irq[3] */
-	rx_flow = PRUETH_RX_FLOW_DATA;
+	rx_flow = PRUETH_RX_FLOW_DATA_SR2;
 	ret = request_irq(emac->rx_chns.irq[rx_flow], prueth_rx_irq,
 			  IRQF_TRIGGER_HIGH, dev_name(dev), emac);
 	if (ret) {
@@ -1447,7 +1447,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
-	int rx_flow = PRUETH_RX_FLOW_DATA;
+	int rx_flow = PRUETH_RX_FLOW_DATA_SR2;
 	int max_rx_flows;
 	int ret, i;
 
@@ -1477,7 +1477,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 	for (i = 0; i < emac->tx_ch_num; i++)
 		napi_disable(&emac->tx_chns[i].napi_tx);
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS;
+	max_rx_flows = PRUETH_MAX_RX_FLOWS_SR2;
 	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
 
 	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
@@ -2074,7 +2074,7 @@ static int prueth_probe(struct platform_device *pdev)
 		goto put_mem;
 	}
 
-	msmc_ram_size = MSMC_RAM_SIZE;
+	msmc_ram_size = MSMC_RAM_SIZE_SR2;
 
 	/* NOTE: FW bug needs buffer base to be 64KB aligned */
 	prueth->msmcram.va =
@@ -2264,7 +2264,7 @@ static void prueth_remove(struct platform_device *pdev)
 
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va,
-		      MSMC_RAM_SIZE);
+		      MSMC_RAM_SIZE_SR2);
 
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
 
-- 
2.43.0


