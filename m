Return-Path: <netdev+bounces-98508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68AD8D19CD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B81D28BB67
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C216D4FE;
	Tue, 28 May 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OVG36fSf"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A516D4C7;
	Tue, 28 May 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896292; cv=none; b=qE7zrpfe4R+RIqBEA24GY86P+ssCjqIMYRI4P5o6wz1BeE+aePQcIcJDIhJ/gYOaRGLWoueFn4RWuIOEbCPN6FNGCwEayLhWldVrUqKHYhmsiB4lZpVrtg1AR1VMqw88GInga1ZlasGjv+bs4ALsS8X6slGgdLbp3jPHnhpVY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896292; c=relaxed/simple;
	bh=teSRQulP8/vQHUOtZIdk6QCQr+soiqmHveWl7Fr0AGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alDpeEuxoTWEwmSWFIUDWzmqJNEXlrEEszOAO5sQl+UM/FN+lxh52O4XVuncd3h07DorNEt9FImksLFZ88lqz7SAQHG7S7Pomv9/8Jp9SzyOd4zHvIvRIiizf8GoJgC16utw+J4TQUtfFctSPbv9XyXwOirzq5hwWyyeYKT6u50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OVG36fSf; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SBbi83029389;
	Tue, 28 May 2024 06:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716896264;
	bh=2mM5jtU/kvxUwDKuDT2HsHKMNoLJkLzVeZPCywl44e0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OVG36fSfvFUNxgZWwYydEl4aOfik3evKsA+B+LiaPbTTAyxmlAEtfkRMlyqJ0gJE1
	 3O8KmkjLqAtpkM+PTKmcjz8bP6WiBci2/qE28cKLHRIsxB/rKqmiiBL4TKskEA3ZKo
	 4uUZoK9X5BIeYTZ3HyH8uoFywixEGvqZ36ohmn4U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SBbi8s028111
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 06:37:44 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 06:37:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 06:37:43 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SBbhvD083865;
	Tue, 28 May 2024 06:37:43 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44SBbgOf007909;
	Tue, 28 May 2024 06:37:43 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn
	<andrew@lunn.ch>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v6 3/3] net: ti: icssg-prueth: Add support for ICSSG switch firmware
Date: Tue, 28 May 2024 17:07:34 +0530
Message-ID: <20240528113734.379422-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528113734.379422-1-danishanwar@ti.com>
References: <20240528113734.379422-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for ICSSG switch firmware using existing Dual EMAC driver
with switchdev.

Limitations:
VLAN offloading is limited to 0-256 IDs.
MDB/FDB static entries are limited to 511 entries and different FDBs can
hash to same bucket and thus may not completely offloaded

Example assuming ETH1 and ETH2 as ICSSG2 interfaces:

Switch to ICSSG Switch mode:
 ip link add name br0 type bridge
 ip link set dev eth1 master br0
 ip link set dev eth2 master br0
 ip link set dev br0 up
 bridge vlan add dev br0 vid 1 pvid untagged self

Going back to Dual EMAC mode:

 ip link set dev br0 down
 ip link set dev eth1 nomaster
 ip link set dev eth2 nomaster
 ip link del name br0 type bridge

By default, Dual EMAC firmware is loaded, and can be changed to switch
mode by above steps

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   3 +-
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 152 +++++++++--
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 238 +++++++++++++++++-
 7 files changed, 386 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 1729eb0e0b41..f160a3b71499 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -204,6 +204,7 @@ config TI_ICSSG_PRUETH_SR1
 	select TI_ICSS_IEP
 	select TI_K3_CPPI_DESC_POOL
 	depends on PRU_REMOTEPROC
+	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 6e086b4c0384..59cd20a38267 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -39,7 +39,8 @@ icssg-prueth-y := icssg/icssg_prueth.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
 		  icssg/icssg_stats.o \
-		  icssg/icssg_ethtool.o
+		  icssg/icssg_ethtool.o \
+		  icssg/icssg_switchdev.o
 obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o \
 		      icssg/icssg_common.o \
diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 79ba47bb3602..8dee737639b6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -455,7 +455,7 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 {
 	const u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
 
-	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
+	rx_class_ft1_set_start_len(miig_rt, slice, 6, 6);
 	rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
 	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 088ab8076db4..873126dfc173 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -581,6 +581,8 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	} else {
 		/* send the filled skb up the n/w stack */
 		skb_put(skb, pkt_len);
+		if (emac->prueth->is_switch_mode)
+			skb->offload_fwd_mark = emac->offload_fwd_mark;
 		skb->protocol = eth_type_trans(skb, ndev);
 		napi_gro_receive(&emac->napi_rx, skb);
 		ndev->stats.rx_bytes += pkt_len;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 2213374d4d45..9444e56b7672 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -107,28 +107,49 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
 	},
 };
 
+static void icssg_config_mii_init_switch(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	int mii = prueth_emac_slice(emac);
+	u32 txcfg_reg, pcnt_reg, txcfg;
+	struct regmap *mii_rt;
+
+	mii_rt = prueth->mii_rt;
+
+	txcfg_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
+				       PRUSS_MII_RT_TXCFG1;
+	pcnt_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
+				       PRUSS_MII_RT_RX_PCNT1;
+
+	txcfg = PRUSS_MII_RT_TXCFG_TX_ENABLE |
+		PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE |
+		PRUSS_MII_RT_TXCFG_TX_IPG_WIRE_CLK_EN;
+
+	if (emac->phy_if == PHY_INTERFACE_MODE_MII && mii == ICSS_MII1)
+		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && mii == ICSS_MII0)
+		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+
+	regmap_write(mii_rt, txcfg_reg, txcfg);
+	regmap_write(mii_rt, pcnt_reg, 0x1);
+}
+
 static void icssg_config_mii_init(struct prueth_emac *emac)
 {
-	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
+	u32 txcfg, txcfg_reg, pcnt_reg;
 	struct regmap *mii_rt;
 
 	mii_rt = prueth->mii_rt;
 
-	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
-				       PRUSS_MII_RT_RXCFG1;
 	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
 				       PRUSS_MII_RT_TXCFG1;
 	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
 				       PRUSS_MII_RT_RX_PCNT1;
 
-	rxcfg = MII_RXCFG_DEFAULT;
 	txcfg = MII_TXCFG_DEFAULT;
 
-	if (slice == ICSS_MII1)
-		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
-
 	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
 	 * to be swapped also comparing to RGMII mode.
 	 */
@@ -137,7 +158,6 @@ static void icssg_config_mii_init(struct prueth_emac *emac)
 	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
 		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
 
-	regmap_write(mii_rt, rxcfg_reg, rxcfg);
 	regmap_write(mii_rt, txcfg_reg, txcfg);
 	regmap_write(mii_rt, pcnt_reg, 0x1);
 }
@@ -257,6 +277,66 @@ static int emac_r30_is_done(struct prueth_emac *emac)
 	return 1;
 }
 
+static int prueth_switch_buffer_setup(struct prueth_emac *emac)
+{
+	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
+	struct icssg_rxq_ctx __iomem *rxq_ctx;
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	u32 addr;
+	int i;
+
+	addr = lower_32_bits(prueth->msmcram.pa);
+	if (slice)
+		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+
+	if (addr % SZ_64K) {
+		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
+		return -EINVAL;
+	}
+
+	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
+	/* workaround for f/w bug. bpool 0 needs to be initialized */
+	for (i = 0; i <  PRUETH_NUM_BUF_POOLS; i++) {
+		writel(addr, &bpool_cfg[i].addr);
+		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
+		addr += PRUETH_EMAC_BUF_POOL_SIZE;
+	}
+
+	if (!slice)
+		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+	else
+		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
+
+	for (i = PRUETH_NUM_BUF_POOLS;
+	     i < 2 * PRUETH_SW_NUM_BUF_POOLS_HOST + PRUETH_NUM_BUF_POOLS;
+	     i++) {
+		/* The driver only uses first 4 queues per PRU so only initialize them */
+		if (i % PRUETH_SW_NUM_BUF_POOLS_HOST < PRUETH_SW_NUM_BUF_POOLS_PER_PRU) {
+			writel(addr, &bpool_cfg[i].addr);
+			writel(PRUETH_SW_BUF_POOL_SIZE_HOST, &bpool_cfg[i].len);
+			addr += PRUETH_SW_BUF_POOL_SIZE_HOST;
+		} else {
+			writel(0, &bpool_cfg[i].addr);
+			writel(0, &bpool_cfg[i].len);
+		}
+	}
+
+	if (!slice)
+		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
+	else
+		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+
+	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
+	for (i = 0; i < 3; i++)
+		writel(addr, &rxq_ctx->start[i]);
+
+	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	writel(addr - SZ_2K, &rxq_ctx->end);
+
+	return 0;
+}
+
 static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 {
 	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
@@ -321,25 +401,63 @@ static void icssg_init_emac_mode(struct prueth *prueth)
 	/* When the device is configured as a bridge and it is being brought
 	 * back to the emac mode, the host mac address has to be set as 0.
 	 */
+	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
+	int i;
 	u8 mac[ETH_ALEN] = { 0 };
 
 	if (prueth->emacs_initialized)
 		return;
 
-	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1,
-			   SMEM_VLAN_OFFSET_MASK, 0);
-	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, 0);
+	/* Set VLAN TABLE address base */
+	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
+			   addr <<  SMEM_VLAN_OFFSET);
+	/* Set enable VLAN aware mode, and FDBs for all PRUs */
+	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, (FDB_PRU0_EN | FDB_PRU1_EN | FDB_HOST_EN));
+	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
+			    EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET);
+	for (i = 0; i < SZ_4K - 1; i++) {
+		prueth->vlan_tbl[i].fid = i;
+		prueth->vlan_tbl[i].fid_c1 = 0;
+	}
 	/* Clear host MAC address */
 	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
 }
 
+static void icssg_init_switch_mode(struct prueth *prueth)
+{
+	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
+	int i;
+
+	if (prueth->emacs_initialized)
+		return;
+
+	/* Set VLAN TABLE address base */
+	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
+			   addr <<  SMEM_VLAN_OFFSET);
+	/* Set enable VLAN aware mode, and FDBs for all PRUs */
+	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, FDB_EN_ALL);
+	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
+			    EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET);
+	for (i = 0; i < SZ_4K - 1; i++) {
+		prueth->vlan_tbl[i].fid = i;
+		prueth->vlan_tbl[i].fid_c1 = 0;
+	}
+
+	if (prueth->hw_bridge_dev)
+		icssg_class_set_host_mac_addr(prueth->miig_rt, prueth->hw_bridge_dev->dev_addr);
+	icssg_set_pvid(prueth, prueth->default_vlan, PRUETH_PORT_HOST);
+}
+
 int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 {
 	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
 	struct icssg_flow_cfg __iomem *flow_cfg;
 	int ret;
 
-	icssg_init_emac_mode(prueth);
+	if (prueth->is_switch_mode)
+		icssg_init_switch_mode(prueth);
+	else
+		icssg_init_emac_mode(prueth);
 
 	memset_io(config, 0, TAS_GATE_MASK_LIST0);
 	icssg_miig_queues_init(prueth, slice);
@@ -353,7 +471,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
 			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
 	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
-	icssg_config_mii_init(emac);
+	if (prueth->is_switch_mode)
+		icssg_config_mii_init_switch(emac);
+	else
+		icssg_config_mii_init(emac);
 	icssg_config_ipg(emac);
 	icssg_update_rgmii_cfg(prueth->miig_rt, emac);
 
@@ -376,7 +497,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
 	writeb(0, config + QUEUE_NUM_UNTAGGED);
 
-	ret = prueth_emac_buffer_setup(emac);
+	if (prueth->is_switch_mode)
+		ret = prueth_switch_buffer_setup(emac);
+	else
+		ret = prueth_emac_buffer_setup(emac);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 4a9721aa6057..1ac60283923b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -35,6 +35,13 @@ struct icssg_flow_cfg {
 	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
 	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
 
+#define PRUETH_SW_BUF_POOL_SIZE_HOST	SZ_4K
+#define PRUETH_SW_NUM_BUF_POOLS_HOST	8
+#define PRUETH_SW_NUM_BUF_POOLS_PER_PRU 4
+#define MSMC_RAM_SIZE_SWITCH_MODE \
+	(MSMC_RAM_SIZE + \
+	(2 * PRUETH_SW_BUF_POOL_SIZE_HOST * PRUETH_SW_NUM_BUF_POOLS_HOST))
+
 #define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
 
 struct icssg_rxq_ctx {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 1db67a8107cc..6e65aa0977d4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -27,6 +27,7 @@
 #include <linux/remoteproc/pruss.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
+#include <net/switchdev.h>
 
 #include "icssg_prueth.h"
 #include "icssg_mii_rt.h"
@@ -35,6 +36,10 @@
 
 #define PRUETH_MODULE_DESCRIPTION "PRUSS ICSSG Ethernet driver"
 
+#define DEFAULT_VID		1
+#define DEFAULT_PORT_MASK	1
+#define DEFAULT_UNTAG_MASK	1
+
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
@@ -113,6 +118,19 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static struct icssg_firmwares icssg_switch_firmwares[] = {
+	{
+		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu0-prusw-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru0-prusw-fw.elf",
+	},
+	{
+		.pru = "ti-pruss/am65x-sr2-pru1-prusw-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu1-prusw-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru1-prusw-fw.elf",
+	}
+};
+
 static struct icssg_firmwares icssg_emac_firmwares[] = {
 	{
 		.pru = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
@@ -132,7 +150,10 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 	struct device *dev = prueth->dev;
 	int slice, ret;
 
-	firmwares = icssg_emac_firmwares;
+	if (prueth->is_switch_mode)
+		firmwares = icssg_switch_firmwares;
+	else
+		firmwares = icssg_emac_firmwares;
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0) {
@@ -446,9 +467,8 @@ static int emac_ndo_open(struct net_device *ndev)
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
 
 	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
-	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
-
 	icssg_class_default(prueth->miig_rt, slice, 0, false);
+	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
 
 	/* Notify the stack of the actual queue counts. */
 	ret = netif_set_real_num_tx_queues(ndev, num_data_chn);
@@ -845,6 +865,203 @@ bool prueth_dev_check(const struct net_device *ndev)
 	return false;
 }
 
+static void prueth_offload_fwd_mark_update(struct prueth *prueth)
+{
+	int set_val = 0;
+	int i;
+
+	if (prueth->br_members == (BIT(PRUETH_PORT_MII0) | BIT(PRUETH_PORT_MII1)))
+		set_val = 1;
+
+	dev_dbg(prueth->dev, "set offload_fwd_mark %d\n", set_val);
+
+	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
+		struct prueth_emac *emac = prueth->emac[i];
+
+		if (!emac || !emac->ndev)
+			continue;
+
+		emac->offload_fwd_mark = set_val;
+	}
+}
+
+static void prueth_emac_restart(struct prueth *prueth)
+{
+	struct prueth_emac *emac0 = prueth->emac[PRUETH_MAC0];
+	struct prueth_emac *emac1 = prueth->emac[PRUETH_MAC1];
+
+	/* Detach the net_device for both PRUeth ports*/
+	if (netif_running(emac0->ndev))
+		netif_device_detach(emac0->ndev);
+	if (netif_running(emac1->ndev))
+		netif_device_detach(emac1->ndev);
+
+	/* Disable both PRUeth ports */
+	emac_set_port_state(emac0, ICSSG_EMAC_PORT_DISABLE);
+	emac_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
+
+	/* Stop both pru cores for both PRUeth ports*/
+	prueth_emac_stop(emac0);
+	prueth->emacs_initialized--;
+	prueth_emac_stop(emac1);
+	prueth->emacs_initialized--;
+
+	/* Start both pru cores for both PRUeth ports */
+	prueth_emac_start(prueth, emac0);
+	prueth->emacs_initialized++;
+	prueth_emac_start(prueth, emac1);
+	prueth->emacs_initialized++;
+
+	/* Enable forwarding for both PRUeth ports */
+	emac_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
+	emac_set_port_state(emac1, ICSSG_EMAC_PORT_FORWARD);
+
+	/* Attache net_device for both PRUeth ports */
+	netif_device_attach(emac0->ndev);
+	netif_device_attach(emac1->ndev);
+}
+
+static void icssg_enable_switch_mode(struct prueth *prueth)
+{
+	struct prueth_emac *emac;
+	int mac;
+
+	prueth_emac_restart(prueth);
+
+	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
+		emac = prueth->emac[mac];
+		if (netif_running(emac->ndev)) {
+			icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
+					  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
+					  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+					  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
+					  ICSSG_FDB_ENTRY_BLOCK,
+					  true);
+			icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
+					  BIT(emac->port_id) | DEFAULT_PORT_MASK,
+					  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
+					  true);
+			icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
+			emac_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+		}
+	}
+}
+
+static int prueth_netdevice_port_link(struct net_device *ndev,
+				      struct net_device *br_ndev,
+				      struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int err;
+
+	if (!prueth->br_members) {
+		prueth->hw_bridge_dev = br_ndev;
+	} else {
+		/* This is adding the port to a second bridge, this is
+		 * unsupported
+		 */
+		if (prueth->hw_bridge_dev != br_ndev)
+			return -EOPNOTSUPP;
+	}
+
+	err = switchdev_bridge_port_offload(br_ndev, ndev, emac,
+					    &prueth->prueth_switchdev_nb,
+					    &prueth->prueth_switchdev_bl_nb,
+					    false, extack);
+	if (err)
+		return err;
+
+	prueth->br_members |= BIT(emac->port_id);
+
+	if (!prueth->is_switch_mode) {
+		if (prueth->br_members & BIT(PRUETH_PORT_MII0) &&
+		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
+			prueth->is_switch_mode = true;
+			prueth->default_vlan = 1;
+			emac->port_vlan = prueth->default_vlan;
+			icssg_enable_switch_mode(prueth);
+		}
+	}
+
+	prueth_offload_fwd_mark_update(prueth);
+
+	return NOTIFY_DONE;
+}
+
+static void prueth_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	prueth->br_members &= ~BIT(emac->port_id);
+
+	if (prueth->is_switch_mode) {
+		prueth->is_switch_mode = false;
+		emac->port_vlan = 0;
+		prueth_emac_restart(prueth);
+	}
+
+	prueth_offload_fwd_mark_update(prueth);
+
+	if (!prueth->br_members)
+		prueth->hw_bridge_dev = NULL;
+}
+
+/* netdev notifier */
+static int prueth_netdevice_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info;
+	int ret = NOTIFY_DONE;
+
+	if (ndev->netdev_ops != &emac_netdev_ops)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		info = ptr;
+
+		if (netif_is_bridge_master(info->upper_dev)) {
+			if (info->linking)
+				ret = prueth_netdevice_port_link(ndev, info->upper_dev, extack);
+			else
+				prueth_netdevice_port_unlink(ndev);
+		}
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int prueth_register_notifiers(struct prueth *prueth)
+{
+	int ret = 0;
+
+	prueth->prueth_netdevice_nb.notifier_call = &prueth_netdevice_event;
+	ret = register_netdevice_notifier(&prueth->prueth_netdevice_nb);
+	if (ret) {
+		dev_err(prueth->dev, "can't register netdevice notifier\n");
+		return ret;
+	}
+
+	ret = prueth_switchdev_register_notifiers(prueth);
+	if (ret)
+		unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+
+	return ret;
+}
+
+static void prueth_unregister_notifiers(struct prueth *prueth)
+{
+	prueth_switchdev_unregister_notifiers(prueth);
+	unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+}
+
 static int prueth_probe(struct platform_device *pdev)
 {
 	struct device_node *eth_node, *eth_ports_node;
@@ -972,6 +1189,9 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 	msmc_ram_size = MSMC_RAM_SIZE;
+	prueth->is_switchmode_supported = prueth->pdata.switch_mode;
+	if (prueth->is_switchmode_supported)
+		msmc_ram_size = MSMC_RAM_SIZE_SWITCH_MODE;
 
 	/* NOTE: FW bug needs buffer base to be 64KB aligned */
 	prueth->msmcram.va =
@@ -1077,6 +1297,14 @@ static int prueth_probe(struct platform_device *pdev)
 		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
 	}
 
+	if (prueth->is_switchmode_supported) {
+		ret = prueth_register_notifiers(prueth);
+		if (ret)
+			goto netdev_unregister;
+
+		sprintf(prueth->switch_id, "%s", dev_name(dev));
+	}
+
 	dev_info(dev, "TI PRU ethernet driver initialized: %s EMAC mode\n",
 		 (!eth0_node || !eth1_node) ? "single" : "dual");
 
@@ -1146,6 +1374,8 @@ static void prueth_remove(struct platform_device *pdev)
 	struct device_node *eth_node;
 	int i;
 
+	prueth_unregister_notifiers(prueth);
+
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
 		if (!prueth->registered_netdevs[i])
 			continue;
@@ -1187,10 +1417,12 @@ static void prueth_remove(struct platform_device *pdev)
 static const struct prueth_pdata am654_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 	.quirk_10m_link_issue = 1,
+	.switch_mode = 1,
 };
 
 static const struct prueth_pdata am64x_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
+	.switch_mode = 1,
 };
 
 static const struct of_device_id prueth_dt_match[] = {
-- 
2.34.1


