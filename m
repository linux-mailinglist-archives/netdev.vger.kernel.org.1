Return-Path: <netdev+bounces-64014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28369830AD6
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2DE1F2A2D0
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030622EE7;
	Wed, 17 Jan 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="dS/irmAU"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E645225CD
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508184; cv=none; b=XllFEb8XyRgW8dyphmIuhNwRXaqn4OxmamTJyzXPtHiayyG5LeQ2N2qVOagcHMjBCZjTqCad2Rj640CEmpJ3AUy1vw/lI1mk9xiRVdU+3oC3nv7yXZg78RQqVgq7j0s+uOYDDHUayqhCqq1GarGBiIqZQk93n4T3ViwHcZWsVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508184; c=relaxed/simple;
	bh=dneUxMBn/1Er22+7k5DVDfMHQXBlftKUq9rk4chfPF0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID; b=mgH2tEr7JQbpPWHu7dUp1T6dQscrPJ1RFX8oI7rGgxj3TTRasoUB3Z8Qk66OI6BC9+MAahTxcBkm/8AdJKdeG2x7URIidpVOK2AC8gKhGCIVaxCycu/iYQzS0KWeO3VeYtmN1sbZFjfL80Um5MlifzYigRy6mwJbUw1SNQUWu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=dS/irmAU; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240117161621c8d4da235c2129acb5
        for <netdev@vger.kernel.org>;
        Wed, 17 Jan 2024 17:16:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oEAvIuPcXWGB92RZhAfW/QaF1dMHzyGJuC3Be3ErKg4=;
 b=dS/irmAUsACM9eSfTZ7GSgvsOqr9ZmhGQ1/JxmytNnvOyTAEI6WQ50LRVz9b4iWH76RstU
 cSPWgdAJBWx/fNjVVLvTcUKtWfSIGvKcZ9nQUkQK5WR+01Lr5HPr8HsPsux3pRZO53wXzfaC
 RJ4SWyCh5HioCEhKd/EbGIGw4kMYo=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	jacob.e.keller@intel.com,
	grygorii.strashko@ti.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 5/8] net: ti: icssg-config: Add SR1.0 configuration functions
Date: Wed, 17 Jan 2024 16:14:59 +0000
Message-ID: <20240117161602.153233-6-diogo.ivo@siemens.com>
In-Reply-To: <20240117161602.153233-1-diogo.ivo@siemens.com>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

The SR1.0 firmware needs to configured differently from the
current SR2.0 firmware. Add the necessary functions.

Based on the work of Roger Quadros, Vignesh Raghavendra
and Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v2:
 - Removed explicit references to SR2.0
 - Added static keyword to icssg_config_sr1() 

 drivers/net/ethernet/ti/icssg/icssg_config.c | 86 ++++++++++++++++++--
 1 file changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 99de8a40ed60..34bc16599a2d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -18,6 +18,8 @@
  */
 
 /* IPG is in core_clk cycles */
+#define MII_RT_TX_IPG_100M_SR1	0x166
+#define MII_RT_TX_IPG_1G_SR1	0x1a
 #define MII_RT_TX_IPG_100M	0x17
 #define MII_RT_TX_IPG_1G	0xb
 
@@ -205,14 +207,20 @@ void icssg_config_ipg(struct prueth_emac *emac)
 
 	switch (emac->speed) {
 	case SPEED_1000:
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_1G);
+		icssg_mii_update_ipg(prueth->mii_rt, slice,
+				     prueth->pdata.is_sr1 ?
+				     MII_RT_TX_IPG_1G_SR1 : MII_RT_TX_IPG_1G);
 		break;
 	case SPEED_100:
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
+		icssg_mii_update_ipg(prueth->mii_rt, slice,
+				     prueth->pdata.is_sr1 ?
+				     MII_RT_TX_IPG_100M_SR1 : MII_RT_TX_IPG_100M);
 		break;
 	case SPEED_10:
-		/* IPG for 10M is same as 100M */
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
+		/* Firmware hardcodes IPG for SR1. SR2 same as 100M */
+		if (!prueth->pdata.is_sr1)
+			icssg_mii_update_ipg(prueth->mii_rt, slice,
+					     MII_RT_TX_IPG_100M);
 		break;
 	default:
 		/* Other links speeds not supported */
@@ -221,6 +229,56 @@ void icssg_config_ipg(struct prueth_emac *emac)
 	}
 }
 
+/* SR1: Set buffer sizes for the pools. There are 8 internal queues
+ * implemented in firmware, but only 4 tx channels/threads in the Egress
+ * direction to firmware. Need a high priority queue for management
+ * messages since they shouldn't be blocked even during high traffic
+ * situation. So use Q0-Q2 as data queues and Q3 as management queue
+ * in the max case. However for ease of configuration, use the max
+ * data queue + 1 for management message if we are not using max
+ * case.
+ *
+ * Allocate 4 MTU buffers per data queue.  Firmware requires
+ * pool sizes to be set for internal queues. Set the upper 5 queue
+ * pool size to min size of 128 bytes since there are only 3 tx
+ * data channels and management queue requires only minimum buffer.
+ * i.e lower queues are used by driver and highest priority queue
+ * from that is used for management message.
+ */
+
+static int emac_egress_buf_pool_size[] = {
+	PRUETH_EMAC_BUF_POOL_SIZE_SR1, PRUETH_EMAC_BUF_POOL_SIZE_SR1,
+	PRUETH_EMAC_BUF_POOL_SIZE_SR1, PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1,
+	PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1, PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1,
+	PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1, PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1};
+
+static void icssg_config_sr1(struct prueth *prueth, struct prueth_emac *emac,
+		      int slice)
+{
+	struct icssg_config_sr1 *config;
+	void __iomem *va;
+	int i, index;
+
+	va = prueth->shram.va + slice * ICSSG_CONFIG_OFFSET_SLICE1;
+	config = &prueth->config[slice];
+	memset(config, 0, sizeof(*config));
+	config->addr_lo = cpu_to_le32(lower_32_bits(prueth->msmcram.pa));
+	config->addr_hi = cpu_to_le32(upper_32_bits(prueth->msmcram.pa));
+	config->num_tx_threads = 0;
+	config->rx_flow_id = emac->rx_flow_id_base; /* flow id for host port */
+	config->rx_mgr_flow_id = emac->rx_mgm_flow_id_base; /* for mgm ch */
+	config->rand_seed = get_random_u32();
+
+	for (i = PRUETH_EMAC_BUF_POOL_START_SR1; i < PRUETH_NUM_BUF_POOLS_SR1; i++) {
+		index =  i - PRUETH_EMAC_BUF_POOL_START_SR1;
+		config->tx_buf_sz[i] = cpu_to_le32(emac_egress_buf_pool_size[index]);
+	}
+
+	memcpy_toio(va, &prueth->config[slice], sizeof(prueth->config[slice]));
+
+	emac->speed = SPEED_1000;
+}
+
 static void emac_r30_cmd_init(struct prueth_emac *emac)
 {
 	struct icssg_r30_cmd __iomem *p;
@@ -331,6 +389,11 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	struct icssg_flow_cfg __iomem *flow_cfg;
 	int ret;
 
+	if (prueth->pdata.is_sr1) {
+		icssg_config_sr1(prueth, emac, slice);
+		return 0;
+	}
+
 	icssg_init_emac_mode(prueth);
 
 	memset_io(config, 0, TAS_GATE_MASK_LIST0);
@@ -435,19 +498,32 @@ int emac_set_port_state(struct prueth_emac *emac,
 
 void icssg_config_half_duplex(struct prueth_emac *emac)
 {
+	struct icssg_config_sr1 *config;
+	void __iomem *va;
+	int slice;
 	u32 val;
 
 	if (!emac->half_duplex)
 		return;
 
 	val = get_random_u32();
-	writel(val, emac->dram.va + HD_RAND_SEED_OFFSET);
+	if (emac->is_sr1) {
+		slice = prueth_emac_slice(emac);
+		va = emac->prueth->shram.va + slice * ICSSG_CONFIG_OFFSET_SLICE1;
+		config = (struct icssg_config_sr1 *)va;
+		writel(val, &config->rand_seed);
+	} else {
+		writel(val, emac->dram.va + HD_RAND_SEED_OFFSET);
+	}
 }
 
 void icssg_config_set_speed(struct prueth_emac *emac)
 {
 	u8 fw_speed;
 
+	if (emac->is_sr1)
+		return;
+
 	switch (emac->speed) {
 	case SPEED_1000:
 		fw_speed = FW_LINK_SPEED_1G;
-- 
2.43.0


