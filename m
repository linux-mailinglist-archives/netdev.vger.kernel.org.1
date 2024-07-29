Return-Path: <netdev+bounces-113598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782D593F417
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC471F22B5A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40871266A7;
	Mon, 29 Jul 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cmZjKnVK"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F3145B0B;
	Mon, 29 Jul 2024 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252776; cv=none; b=oNNyhEsSyAIV5dVvh+1LkPv3o2msGg3/lVB5/Sv2/4L/ns9vFszORPHsn288I2k0yknU2uqLelDpaocEXeKVpwLZhhFDbTT8HqeT4qOqrQexnXQeD7cCJhEmwJFSLcbgrH8nWlRfs/bwgNY3x3wyD+XtDFKMow09SPaOoLgmXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252776; c=relaxed/simple;
	bh=2j7/9XlZgn9J6KhBVOmGKLpR1kyMbrBkvxKsmmu1QSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3B9oHelWK61XCHSzzkfcq0u/Pg3AWT+GXeXlFsfVHqmHsnFGUcmIU1Cr6Z6viL2nXijgJRQyMeU7xTAuwmK9VMXBcPX2bq3VCkz7AUkcIXTG1IGrIfxNNR48J3NNEPJ1F+EjaFMrBLbkJicVyTN7xevQxt6TgzK3/k+qrdW8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cmZjKnVK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWYLt061585;
	Mon, 29 Jul 2024 06:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252754;
	bh=IUzAFkY6u3MjWxbKEgObp2riV3uhu8ZVpbjNt4vFIVM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cmZjKnVKatKOWpj8RIuE3wOCW2WH8ZmPSNLz2gWQTM2glzaPDUk4SSZdB2azu+4g2
	 FD3zaRTFoogqpl2+GD+iY7T+XrbW9WEXs+u6rFaoHOl7O0cTgZWriaCF4eIg9LA4lU
	 50as4Y3ysLXfack0wsMaXt1DANFPRTM5e6R12G7c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBWYTX115437
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:32:34 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:32:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:32:34 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWXSs012896;
	Mon, 29 Jul 2024 06:32:34 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46TBWXQI013186;
	Mon, 29 Jul 2024 06:32:33 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Tero
 Kristo <kristo@kernel.org>,
        <srk@ti.com>
Subject: [DO NOT MERGE][PATCH v4 2/6] net: ti: icssg_prueth: Add support for PA Stats
Date: Mon, 29 Jul 2024 17:02:22 +0530
Message-ID: <20240729113226.2905928-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729113226.2905928-1-danishanwar@ti.com>
References: <20240729113226.2905928-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for dumping PA stats registers

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 11 ++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 ++-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 12 +++++--
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 32 +++++++++++++++++++
 5 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5688f054cec5..713ce95d5baf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -90,6 +90,12 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 				p += ETH_GSTRING_LEN;
 			}
 		}
+
+		for (i = 0; i < ICSSG_NUM_PA_STATS; i++) {
+			memcpy(p, icssg_all_pa_stats[i].name, ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
+
 		break;
 	default:
 		break;
@@ -100,13 +106,16 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 				   struct ethtool_stats *stats, u64 *data)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
-	int i;
+	int i, j;
 
 	emac_update_hardware_stats(emac);
 
 	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
 		if (!icssg_all_stats[i].standard_stats)
 			*(data++) = emac->stats[i];
+
+	for (j = 0; j < ICSSG_NUM_PA_STATS; j++)
+		*(data++) = emac->stats[i + j];
 }
 
 static int emac_get_ts_info(struct net_device *ndev,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3e51b3a9b0a5..04bf7f1e14ff 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1181,6 +1181,12 @@ static int prueth_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
+	if (IS_ERR(prueth->pa_stats)) {
+		dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
+		return -ENODEV;
+	}
+
 	if (eth0_node) {
 		ret = prueth_get_cores(prueth, ICSS_SLICE0, false);
 		if (ret)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index f678d656a3ed..ac2291d22c42 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -50,8 +50,10 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
+#define ICSSG_NUM_PA_STATS 4
+#define ICSSG_NUM_MII_G_RT_STATS 60
 /* Number of ICSSG related stats */
-#define ICSSG_NUM_STATS 60
+#define ICSSG_NUM_STATS (ICSSG_NUM_MII_G_RT_STATS + ICSSG_NUM_PA_STATS)
 #define ICSSG_NUM_STANDARD_STATS 31
 #define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
 
@@ -263,6 +265,7 @@ struct prueth {
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
 	struct regmap *miig_rt;
 	struct regmap *mii_rt;
+	struct regmap *pa_stats;
 
 	enum pruss_pru_id pru_id[PRUSS_NUM_PRUS];
 	struct platform_device *pdev;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 2fb150c13078..c3d081cad3ca 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -11,6 +11,7 @@
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
 #define ICSSG_TX_BYTE_OFFSET	0xEC
+#define ICSSG_FW_STATS_BASE	0x0248
 
 static u32 stats_base[] = {	0x54c,	/* Slice 0 stats start */
 				0xb18,	/* Slice 1 stats start */
@@ -22,8 +23,8 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	int slice = prueth_emac_slice(emac);
 	u32 base = stats_base[slice];
 	u32 tx_pkt_cnt = 0;
-	u32 val;
-	int i;
+	u32 val, reg;
+	int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
 		regmap_read(prueth->miig_rt,
@@ -40,6 +41,13 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 		if (icssg_all_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
 			emac->stats[i] -= tx_pkt_cnt * 8;
 	}
+
+	for (j = 0; j < ICSSG_NUM_PA_STATS; j++) {
+		reg = ICSSG_FW_STATS_BASE + icssg_all_pa_stats[j].offset *
+		      PRUETH_NUM_MACS + slice * sizeof(u32);
+		regmap_read(prueth->pa_stats, reg, &val);
+		emac->stats[i + j] += val;
+	}
 }
 
 void icssg_stats_work_handler(struct work_struct *work)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 999a4a91276c..e834316092c9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -77,6 +77,20 @@ struct miig_stats_regs {
 	u32 tx_bytes;
 };
 
+/**
+ * struct pa_stats_regs - ICSSG Firmware maintained PA Stats register
+ * @u32 fw_rx_cnt: Number of valid packets sent by Rx PRU to Host on PSI
+ * @u32 fw_tx_cnt: Number of valid packets copied by RTU0 to Tx queues
+ * @u32 fw_tx_pre_overflow: Host Egress Q (Pre-emptible) Overflow Counter
+ * @u32 fw_tx_exp_overflow: Host Egress Q (Express) Overflow Counter
+ */
+struct pa_stats_regs {
+	u32 fw_rx_cnt;
+	u32 fw_tx_cnt;
+	u32 fw_tx_pre_overflow;
+	u32 fw_tx_exp_overflow;
+};
+
 #define ICSSG_STATS(field, stats_type)			\
 {							\
 	#field,						\
@@ -84,12 +98,23 @@ struct miig_stats_regs {
 	stats_type					\
 }
 
+#define ICSSG_PA_STATS(field)			\
+{						\
+	#field,					\
+	offsetof(struct pa_stats_regs, field),	\
+}
+
 struct icssg_stats {
 	char name[ETH_GSTRING_LEN];
 	u32 offset;
 	bool standard_stats;
 };
 
+struct icssg_pa_stats {
+	char name[ETH_GSTRING_LEN];
+	u32 offset;
+};
+
 static const struct icssg_stats icssg_all_stats[] = {
 	/* Rx */
 	ICSSG_STATS(rx_packets, true),
@@ -155,4 +180,11 @@ static const struct icssg_stats icssg_all_stats[] = {
 	ICSSG_STATS(tx_bytes, true),
 };
 
+static const struct icssg_pa_stats icssg_all_pa_stats[] = {
+	ICSSG_PA_STATS(fw_rx_cnt),
+	ICSSG_PA_STATS(fw_tx_cnt),
+	ICSSG_PA_STATS(fw_tx_pre_overflow),
+	ICSSG_PA_STATS(fw_tx_exp_overflow),
+};
+
 #endif /* __NET_TI_ICSSG_STATS_H */
-- 
2.34.1


