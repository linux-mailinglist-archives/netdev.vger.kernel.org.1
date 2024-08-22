Return-Path: <netdev+bounces-120972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED195B4FD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB77B22661
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51341C9EA5;
	Thu, 22 Aug 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gNXmSee+"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FE1C9DCD;
	Thu, 22 Aug 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329641; cv=none; b=S0d5rL0xD1DTuOU7VfusmBtheL56KcmKpn2g+YjBtbE1BRAv6TCZzCf0UPA1Oms1DmFnX3Oh0r8yANrkDMJgQDusXhAWlSSg8MZt/WrIJ+99VYsrFhKoRJAYW/uA6LzxdaCxCVoKkkADmb3mrkzvopnDmAWLiRWYYvyzGy3Iphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329641; c=relaxed/simple;
	bh=QWa9CYm1Tvpc76kl4GmUq9oDb6O7fDDoC1EXVo8x888=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcu68ov4OAZto7V/8og9q4TycxfknN7MJQiTIVB1dPI4TQcPXPAqc23iyoVh+JKO5oC8N4VKK1tPVUwCAjlzXmYVw/vCKYUfu/Cg+VwHaQuyMlqraa2aMrUgd0Tic4wAThVOq64qxnZhooBh0zHFAypY6MiUPZxguafHFdvifkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gNXmSee+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MCR0td085903;
	Thu, 22 Aug 2024 07:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724329620;
	bh=6PAkTaIH0mPWUPAX3HSggY7yWwox5RBjrozFFmq0Tt0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gNXmSee+p50UyjDEmcy5eGmQfyd1lL0arYwXES3SHl1C1GqlEWgEL1RqfDDy4jQ3B
	 iSQo9A5KA6i9gRUeof8UFeLOcbvOixFX9u7U+a8VcDh5W6tvatQNt6nytVs6lur28J
	 cG2cVd0OSx0p0bXph7sGILT2zlkE2MxtceFkBRzk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MCR0ut037079
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 07:27:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 07:26:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 07:26:59 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MCQxSW116993;
	Thu, 22 Aug 2024 07:26:59 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47MCQwr0015181;
	Thu, 22 Aug 2024 07:26:59 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth
 Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add support for PA Stats
Date: Thu, 22 Aug 2024 17:56:52 +0530
Message-ID: <20240822122652.1071801-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822122652.1071801-1-danishanwar@ti.com>
References: <20240822122652.1071801-1-danishanwar@ti.com>
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

This commit also maintains consistency between miig_stats and pa_stats by
- renaming the array icssg_all_stats to icssg_all_miig_stats
- renaming the structure icssg_stats to icssg_miig_stats
- renaming ICSSG_STATS() to ICSSG_MIIG_STATS()
- changing order of stats related data structures and arrays so that data
  structures of a certain stats type is clubbed together.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  19 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   6 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  31 +++-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 158 +++++++++++-------
 5 files changed, 140 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5688f054cec5..5073ec195854 100644
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
+		for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++)
+			if (!icssg_all_miig_stats[i].standard_stats)
+				ethtool_puts(&p, icssg_all_miig_stats[i].name);
+		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
+			ethtool_puts(&p, icssg_all_pa_stats[i].name);
 		break;
 	default:
 		break;
@@ -104,9 +102,12 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 
 	emac_update_hardware_stats(emac);
 
-	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
-		if (!icssg_all_stats[i].standard_stats)
+	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++)
+		if (!icssg_all_miig_stats[i].standard_stats)
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
index f678d656a3ed..786bd1ba34ab 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -50,8 +50,10 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
+#define ICSSG_NUM_PA_STATS	4
+#define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
-#define ICSSG_NUM_STATS 60
+#define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
 #define ICSSG_NUM_STANDARD_STATS 31
 #define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
 
@@ -190,7 +192,8 @@ struct prueth_emac {
 	int port_vlan;
 
 	struct delayed_work stats_work;
-	u64 stats[ICSSG_NUM_STATS];
+	u64 stats[ICSSG_NUM_MIIG_STATS];
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
index 2fb150c13078..06a15c0b2acc 100644
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
+	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {
 		regmap_read(prueth->miig_rt,
-			    base + icssg_all_stats[i].offset,
+			    base + icssg_all_miig_stats[i].offset,
 			    &val);
 		regmap_write(prueth->miig_rt,
-			     base + icssg_all_stats[i].offset,
+			     base + icssg_all_miig_stats[i].offset,
 			     val);
 
-		if (icssg_all_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
+		if (icssg_all_miig_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
 			tx_pkt_cnt = val;
 
 		emac->stats[i] += val;
-		if (icssg_all_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
+		if (icssg_all_miig_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
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
+	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {
+		if (!strcmp(icssg_all_miig_stats[i].name, stat_name))
+			return emac->stats[icssg_all_miig_stats[i].offset / sizeof(u32)];
+	}
+
+	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
+		if (!strcmp(icssg_all_pa_stats[i].name, stat_name))
+			return emac->pa_stats[icssg_all_pa_stats[i].offset / sizeof(u32)];
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 999a4a91276c..e88b919f532c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -77,82 +77,114 @@ struct miig_stats_regs {
 	u32 tx_bytes;
 };
 
-#define ICSSG_STATS(field, stats_type)			\
+#define ICSSG_MIIG_STATS(field, stats_type)			\
 {							\
 	#field,						\
 	offsetof(struct miig_stats_regs, field),	\
 	stats_type					\
 }
 
-struct icssg_stats {
+struct icssg_miig_stats {
 	char name[ETH_GSTRING_LEN];
 	u32 offset;
 	bool standard_stats;
 };
 
-static const struct icssg_stats icssg_all_stats[] = {
+static const struct icssg_miig_stats icssg_all_miig_stats[] = {
 	/* Rx */
-	ICSSG_STATS(rx_packets, true),
-	ICSSG_STATS(rx_broadcast_frames, false),
-	ICSSG_STATS(rx_multicast_frames, true),
-	ICSSG_STATS(rx_crc_errors, true),
-	ICSSG_STATS(rx_mii_error_frames, false),
-	ICSSG_STATS(rx_odd_nibble_frames, false),
-	ICSSG_STATS(rx_frame_max_size, true),
-	ICSSG_STATS(rx_max_size_error_frames, false),
-	ICSSG_STATS(rx_frame_min_size, true),
-	ICSSG_STATS(rx_min_size_error_frames, false),
-	ICSSG_STATS(rx_over_errors, true),
-	ICSSG_STATS(rx_class0_hits, false),
-	ICSSG_STATS(rx_class1_hits, false),
-	ICSSG_STATS(rx_class2_hits, false),
-	ICSSG_STATS(rx_class3_hits, false),
-	ICSSG_STATS(rx_class4_hits, false),
-	ICSSG_STATS(rx_class5_hits, false),
-	ICSSG_STATS(rx_class6_hits, false),
-	ICSSG_STATS(rx_class7_hits, false),
-	ICSSG_STATS(rx_class8_hits, false),
-	ICSSG_STATS(rx_class9_hits, false),
-	ICSSG_STATS(rx_class10_hits, false),
-	ICSSG_STATS(rx_class11_hits, false),
-	ICSSG_STATS(rx_class12_hits, false),
-	ICSSG_STATS(rx_class13_hits, false),
-	ICSSG_STATS(rx_class14_hits, false),
-	ICSSG_STATS(rx_class15_hits, false),
-	ICSSG_STATS(rx_smd_frags, false),
-	ICSSG_STATS(rx_bucket1_size, true),
-	ICSSG_STATS(rx_bucket2_size, true),
-	ICSSG_STATS(rx_bucket3_size, true),
-	ICSSG_STATS(rx_bucket4_size, true),
-	ICSSG_STATS(rx_64B_frames, true),
-	ICSSG_STATS(rx_bucket1_frames, true),
-	ICSSG_STATS(rx_bucket2_frames, true),
-	ICSSG_STATS(rx_bucket3_frames, true),
-	ICSSG_STATS(rx_bucket4_frames, true),
-	ICSSG_STATS(rx_bucket5_frames, true),
-	ICSSG_STATS(rx_bytes, true),
-	ICSSG_STATS(rx_tx_total_bytes, false),
+	ICSSG_MIIG_STATS(rx_packets, true),
+	ICSSG_MIIG_STATS(rx_broadcast_frames, false),
+	ICSSG_MIIG_STATS(rx_multicast_frames, true),
+	ICSSG_MIIG_STATS(rx_crc_errors, true),
+	ICSSG_MIIG_STATS(rx_mii_error_frames, false),
+	ICSSG_MIIG_STATS(rx_odd_nibble_frames, false),
+	ICSSG_MIIG_STATS(rx_frame_max_size, true),
+	ICSSG_MIIG_STATS(rx_max_size_error_frames, false),
+	ICSSG_MIIG_STATS(rx_frame_min_size, true),
+	ICSSG_MIIG_STATS(rx_min_size_error_frames, false),
+	ICSSG_MIIG_STATS(rx_over_errors, true),
+	ICSSG_MIIG_STATS(rx_class0_hits, false),
+	ICSSG_MIIG_STATS(rx_class1_hits, false),
+	ICSSG_MIIG_STATS(rx_class2_hits, false),
+	ICSSG_MIIG_STATS(rx_class3_hits, false),
+	ICSSG_MIIG_STATS(rx_class4_hits, false),
+	ICSSG_MIIG_STATS(rx_class5_hits, false),
+	ICSSG_MIIG_STATS(rx_class6_hits, false),
+	ICSSG_MIIG_STATS(rx_class7_hits, false),
+	ICSSG_MIIG_STATS(rx_class8_hits, false),
+	ICSSG_MIIG_STATS(rx_class9_hits, false),
+	ICSSG_MIIG_STATS(rx_class10_hits, false),
+	ICSSG_MIIG_STATS(rx_class11_hits, false),
+	ICSSG_MIIG_STATS(rx_class12_hits, false),
+	ICSSG_MIIG_STATS(rx_class13_hits, false),
+	ICSSG_MIIG_STATS(rx_class14_hits, false),
+	ICSSG_MIIG_STATS(rx_class15_hits, false),
+	ICSSG_MIIG_STATS(rx_smd_frags, false),
+	ICSSG_MIIG_STATS(rx_bucket1_size, true),
+	ICSSG_MIIG_STATS(rx_bucket2_size, true),
+	ICSSG_MIIG_STATS(rx_bucket3_size, true),
+	ICSSG_MIIG_STATS(rx_bucket4_size, true),
+	ICSSG_MIIG_STATS(rx_64B_frames, true),
+	ICSSG_MIIG_STATS(rx_bucket1_frames, true),
+	ICSSG_MIIG_STATS(rx_bucket2_frames, true),
+	ICSSG_MIIG_STATS(rx_bucket3_frames, true),
+	ICSSG_MIIG_STATS(rx_bucket4_frames, true),
+	ICSSG_MIIG_STATS(rx_bucket5_frames, true),
+	ICSSG_MIIG_STATS(rx_bytes, true),
+	ICSSG_MIIG_STATS(rx_tx_total_bytes, false),
 	/* Tx */
-	ICSSG_STATS(tx_packets, true),
-	ICSSG_STATS(tx_broadcast_frames, false),
-	ICSSG_STATS(tx_multicast_frames, false),
-	ICSSG_STATS(tx_odd_nibble_frames, false),
-	ICSSG_STATS(tx_underflow_errors, false),
-	ICSSG_STATS(tx_frame_max_size, true),
-	ICSSG_STATS(tx_max_size_error_frames, false),
-	ICSSG_STATS(tx_frame_min_size, true),
-	ICSSG_STATS(tx_min_size_error_frames, false),
-	ICSSG_STATS(tx_bucket1_size, true),
-	ICSSG_STATS(tx_bucket2_size, true),
-	ICSSG_STATS(tx_bucket3_size, true),
-	ICSSG_STATS(tx_bucket4_size, true),
-	ICSSG_STATS(tx_64B_frames, true),
-	ICSSG_STATS(tx_bucket1_frames, true),
-	ICSSG_STATS(tx_bucket2_frames, true),
-	ICSSG_STATS(tx_bucket3_frames, true),
-	ICSSG_STATS(tx_bucket4_frames, true),
-	ICSSG_STATS(tx_bucket5_frames, true),
-	ICSSG_STATS(tx_bytes, true),
+	ICSSG_MIIG_STATS(tx_packets, true),
+	ICSSG_MIIG_STATS(tx_broadcast_frames, false),
+	ICSSG_MIIG_STATS(tx_multicast_frames, false),
+	ICSSG_MIIG_STATS(tx_odd_nibble_frames, false),
+	ICSSG_MIIG_STATS(tx_underflow_errors, false),
+	ICSSG_MIIG_STATS(tx_frame_max_size, true),
+	ICSSG_MIIG_STATS(tx_max_size_error_frames, false),
+	ICSSG_MIIG_STATS(tx_frame_min_size, true),
+	ICSSG_MIIG_STATS(tx_min_size_error_frames, false),
+	ICSSG_MIIG_STATS(tx_bucket1_size, true),
+	ICSSG_MIIG_STATS(tx_bucket2_size, true),
+	ICSSG_MIIG_STATS(tx_bucket3_size, true),
+	ICSSG_MIIG_STATS(tx_bucket4_size, true),
+	ICSSG_MIIG_STATS(tx_64B_frames, true),
+	ICSSG_MIIG_STATS(tx_bucket1_frames, true),
+	ICSSG_MIIG_STATS(tx_bucket2_frames, true),
+	ICSSG_MIIG_STATS(tx_bucket3_frames, true),
+	ICSSG_MIIG_STATS(tx_bucket4_frames, true),
+	ICSSG_MIIG_STATS(tx_bucket5_frames, true),
+	ICSSG_MIIG_STATS(tx_bytes, true),
+};
+
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
+#define ICSSG_PA_STATS(field)			\
+{						\
+	#field,					\
+	offsetof(struct pa_stats_regs, field),	\
+}
+
+struct icssg_pa_stats {
+	char name[ETH_GSTRING_LEN];
+	u32 offset;
+};
+
+static const struct icssg_pa_stats icssg_all_pa_stats[] = {
+	ICSSG_PA_STATS(fw_rx_cnt),
+	ICSSG_PA_STATS(fw_tx_cnt),
+	ICSSG_PA_STATS(fw_tx_pre_overflow),
+	ICSSG_PA_STATS(fw_tx_exp_overflow),
 };
 
 #endif /* __NET_TI_ICSSG_STATS_H */
-- 
2.34.1


