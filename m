Return-Path: <netdev+bounces-118396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF26951786
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803DF1F22FEC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779C143C5D;
	Wed, 14 Aug 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sx6HzhWm"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8113A418;
	Wed, 14 Aug 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627264; cv=none; b=a2SbuHKB1Eh8ckMfce0X9bdEBgERY0E6/L8X1+EgBN5e8faQw0AbuL3AgCqI3F2RHX+7JD+66syVIgpFiLt+PaIF9e3kr3zDBdyzl2lfQ8H4BtksIBos3+orKPl6jRi3UjU2LbM1CMxzDdu8nARzl4hWRPr6y/dyCUi47QdTcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627264; c=relaxed/simple;
	bh=L/o0XutuzWBC9rHu8MQFRk6vrs9cDuZ0X/qxIiPb50o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky89Bj+Dj1a5j87qhk/JGw8uHknYPizGRondhCVj6gADyUF0Zuulryc0PbU6TfIE0uebUXGhGjzrE/j2PXxV3IxgpbXhneFy7GS7mJs0L5tDrsarQj1XTbgKFDi3/pExy0BcRLYJHZAGV//BB+VSvs6j7MNruB4oOQZw+KfGmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sx6HzhWm; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E9KeEj061101;
	Wed, 14 Aug 2024 04:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723627240;
	bh=xRqR2m8yat23hf8Mz8lEAbb1ABU93TVJJSu6uHFq1qQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Sx6HzhWmahGPpPoigacCErMVEQur+oYkQFsHU70tl8hT9Dio+5o6/xR3ykQwS7JXT
	 hl+UeBMLCjPMqCs6BPLI7LxTpHj5305F6BG7B5jRZU0DfvMfOoWaEtQMkNFt/Xtwxs
	 wNnhyI1uPOpTwIvmcIqOUVanmQr7bwZKLcPSPqwE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E9Ke4d119616
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 04:20:40 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 04:20:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 04:20:39 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E9Kd3f050150;
	Wed, 14 Aug 2024 04:20:39 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47E9KdMr031794;
	Wed, 14 Aug 2024 04:20:39 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory
 Maincent <kory.maincent@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish
 Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v5 2/2] net: ti: icssg-prueth: Add support for PA Stats
Date: Wed, 14 Aug 2024 14:50:33 +0530
Message-ID: <20240814092033.2984734-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814092033.2984734-1-danishanwar@ti.com>
References: <20240814092033.2984734-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for dumping PA stats registers via ethtool.
Firmware maintained stats are stored at PA Stats registers.
Also modify emac_get_strings() API to use ethtool_puts().

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 17 +++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 ++-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 19 +++++++++--
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 32 +++++++++++++++++++
 5 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5688f054cec5..51bb509d37c7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -83,13 +83,11 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
-			if (!icssg_all_stats[i].standard_stats) {
-				memcpy(p, icssg_all_stats[i].name,
-				       ETH_GSTRING_LEN);
-				p += ETH_GSTRING_LEN;
-			}
-		}
+		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
+			if (!icssg_all_stats[i].standard_stats)
+				ethtool_puts(&p, icssg_all_stats[i].name);
+		for (i = 0; i < ICSSG_NUM_PA_STATS; i++)
+			ethtool_puts(&p, icssg_all_pa_stats[i].name);
 		break;
 	default:
 		break;
@@ -100,13 +98,16 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
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
index 53a3e44b99a2..f623a0f603fc 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1182,6 +1182,12 @@ static int prueth_probe(struct platform_device *pdev)
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
index 2fb150c13078..ce6606e4a369 100644
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
@@ -55,13 +63,18 @@ EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
 
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
 		if (!strcmp(icssg_all_stats[i].name, stat_name))
 			return emac->stats[icssg_all_stats[i].offset / sizeof(u32)];
 	}
 
+	for (j = 0; j < ICSSG_NUM_PA_STATS; j++) {
+		if (!strcmp(icssg_all_pa_stats[j].name, stat_name))
+			return emac->stats[i + icssg_all_pa_stats[j].offset / sizeof(u32)];
+	}
+
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
 	return -EINVAL;
 }
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


