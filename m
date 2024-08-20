Return-Path: <netdev+bounces-120053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD299581EB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDDE1F2364D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA4318B468;
	Tue, 20 Aug 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xu1ycVxM"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5F18A924;
	Tue, 20 Aug 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145446; cv=none; b=otUTlQ8fJdyZ2mVwGejM4u382rA46jj05lLFOokQVrpHCd/G+V+bgJ7z+Fu3ez8X0Dr9pR3YWBY3utxLDBgJkbMyhey1lOENOJBIkdyooWtj5vxXNS61k/XseECJKs7JFnT5cuQMZ8N9kd0jUAPsVF5FYUbZRQHjcie0k4bAEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145446; c=relaxed/simple;
	bh=q3N/ZyqthH1O9NPUxqw1SVI3/NmTLIY2x3EzldPk0CU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pg+pLGf/qQ9w5kxRFRqPHVi29Ku/7zpe/uwGWegZtZmY7GJUzbTJO9SArwj2q/q1dyB8vO3e1klGZp70cxxo5CAujsiy65GGqvdnPA41T0e31EnJeufZJF5VGonYysaQccE4yupt0BPGRHe7xkxVtaVqib7F3QYB6+pyskBVJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xu1ycVxM; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47K9H47K079730;
	Tue, 20 Aug 2024 04:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724145424;
	bh=4hFI4/O6McZSFlPnXMFCdXCoskP61LHuUR3sjOS37YU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xu1ycVxM/8E799kX2/voDr8jW3rlaVC4us12sGeXKIrvGP5MXNN9k+Qw+vhuCGQWg
	 3q5KeLvNKjA55545CVsZQq8MQDRRQ17XGQ9ywmQEO5kalyWs4y4WQvcQrnCSPzzMEr
	 2Jle4sHb3JtH+aliRexGh/y92ipEcj2vbF5S58lY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47K9H427028135
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 04:17:04 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 04:17:03 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 04:17:03 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47K9H3Dp099400;
	Tue, 20 Aug 2024 04:17:03 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47K9H3XG016995;
	Tue, 20 Aug 2024 04:17:03 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Simon
 Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh Shilimkar
	<ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add support for PA Stats
Date: Tue, 20 Aug 2024 14:46:57 +0530
Message-ID: <20240820091657.4068304-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820091657.4068304-1-danishanwar@ti.com>
References: <20240820091657.4068304-1-danishanwar@ti.com>
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

This commit also renames the array icssg_all_stats to icssg_mii_g_rt_stats
and creates a new array named icssg_all_pa_stats for PA Stats.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 19 ++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  9 +++--
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 31 ++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 34 ++++++++++++++++++-
 5 files changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5688f054cec5..25832dcbada2 100644
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
+		for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++)
+			if (!icssg_mii_g_rt_stats[i].standard_stats)
+				ethtool_puts(&p, icssg_mii_g_rt_stats[i].name);
+		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
+			ethtool_puts(&p, icssg_all_pa_stats[i].name);
 		break;
 	default:
 		break;
@@ -104,9 +102,12 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 
 	emac_update_hardware_stats(emac);
 
-	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
-		if (!icssg_all_stats[i].standard_stats)
+	for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++)
+		if (!icssg_mii_g_rt_stats[i].standard_stats)
 			*(data++) = emac->stats[i];
+
+	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
+		*(data++) = emac->pa_stats[i];
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
index f678d656a3ed..996f6f8a194c 100644
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
 
@@ -190,7 +192,8 @@ struct prueth_emac {
 	int port_vlan;
 
 	struct delayed_work stats_work;
-	u64 stats[ICSSG_NUM_STATS];
+	u64 stats[ICSSG_NUM_MII_G_RT_STATS];
+	u64 pa_stats[ICSSG_NUM_PA_STATS];
 
 	/* RX IRQ Coalescing Related */
 	struct hrtimer rx_hrtimer;
@@ -230,6 +233,7 @@ struct icssg_firmwares {
  * @registered_netdevs: list of registered netdevs
  * @miig_rt: regmap to mii_g_rt block
  * @mii_rt: regmap to mii_rt block
+ * @pa_stats: regmap to pa_stats block
  * @pru_id: ID for each of the PRUs
  * @pdev: pointer to ICSSG platform device
  * @pdata: pointer to platform data for ICSSG driver
@@ -263,6 +267,7 @@ struct prueth {
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
 	struct regmap *miig_rt;
 	struct regmap *mii_rt;
+	struct regmap *pa_stats;
 
 	enum pruss_pru_id pru_id[PRUSS_NUM_PRUS];
 	struct platform_device *pdev;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 2fb150c13078..857bb956e935 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -11,6 +11,7 @@
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
 #define ICSSG_TX_BYTE_OFFSET	0xEC
+#define ICSSG_FW_STATS_BASE	0x0248
 
 static u32 stats_base[] = {	0x54c,	/* Slice 0 stats start */
 				0xb18,	/* Slice 1 stats start */
@@ -22,24 +23,31 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	int slice = prueth_emac_slice(emac);
 	u32 base = stats_base[slice];
 	u32 tx_pkt_cnt = 0;
-	u32 val;
+	u32 val, reg;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
+	for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++) {
 		regmap_read(prueth->miig_rt,
-			    base + icssg_all_stats[i].offset,
+			    base + icssg_mii_g_rt_stats[i].offset,
 			    &val);
 		regmap_write(prueth->miig_rt,
-			     base + icssg_all_stats[i].offset,
+			     base + icssg_mii_g_rt_stats[i].offset,
 			     val);
 
-		if (icssg_all_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
+		if (icssg_mii_g_rt_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
 			tx_pkt_cnt = val;
 
 		emac->stats[i] += val;
-		if (icssg_all_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
+		if (icssg_mii_g_rt_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
 			emac->stats[i] -= tx_pkt_cnt * 8;
 	}
+
+	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
+		reg = ICSSG_FW_STATS_BASE + icssg_all_pa_stats[i].offset *
+		      PRUETH_NUM_MACS + slice * sizeof(u32);
+		regmap_read(prueth->pa_stats, reg, &val);
+		emac->pa_stats[i] += val;
+	}
 }
 
 void icssg_stats_work_handler(struct work_struct *work)
@@ -57,9 +65,14 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
-		if (!strcmp(icssg_all_stats[i].name, stat_name))
-			return emac->stats[icssg_all_stats[i].offset / sizeof(u32)];
+	for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++) {
+		if (!strcmp(icssg_mii_g_rt_stats[i].name, stat_name))
+			return emac->stats[icssg_mii_g_rt_stats[i].offset / sizeof(u32)];
+	}
+
+	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
+		if (!strcmp(icssg_all_pa_stats[i].name, stat_name))
+			return emac->pa_stats[icssg_all_pa_stats[i].offset / sizeof(u32)];
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 999a4a91276c..2a1edbc55214 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -77,6 +77,20 @@ struct miig_stats_regs {
 	u32 tx_bytes;
 };
 
+/**
+ * struct pa_stats_regs - ICSSG Firmware maintained PA Stats register
+ * @fw_rx_cnt: Number of valid packets sent by Rx PRU to Host on PSI
+ * @fw_tx_cnt: Number of valid packets copied by RTU0 to Tx queues
+ * @fw_tx_pre_overflow: Host Egress Q (Pre-emptible) Overflow Counter
+ * @fw_tx_exp_overflow: Host Egress Q (Express) Overflow Counter
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
@@ -84,13 +98,24 @@ struct miig_stats_regs {
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
 
-static const struct icssg_stats icssg_all_stats[] = {
+struct icssg_pa_stats {
+	char name[ETH_GSTRING_LEN];
+	u32 offset;
+};
+
+static const struct icssg_stats icssg_mii_g_rt_stats[] = {
 	/* Rx */
 	ICSSG_STATS(rx_packets, true),
 	ICSSG_STATS(rx_broadcast_frames, false),
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


