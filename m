Return-Path: <netdev+bounces-125490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E97E96D5A6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C2E1F2AAB2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEFB194149;
	Thu,  5 Sep 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LVkKEJyP"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE064174C;
	Thu,  5 Sep 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531504; cv=none; b=MTS1poEGeI2/GLFye0ZRajg1VmXGmY+vHltIR1/6izLS2Mj02SW5I59hcL5nWb8wp9B7D3ytvOzfMtgSiy7pPa56VJOAENDXAEBXgUY5CS1UYyj7yQ6gLaSlmgkS1f568PRCR9mnUn2CySBvVLnk2FwKeO66G9GXyFUW+RlSfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531504; c=relaxed/simple;
	bh=DFH0z/7ItyhB2/uuj5yj5+ee8iNypAoQ9DMj6rq7TWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qTdX4p/++roisdrPLSWQj1Syvs3Yj8tTPIyZaWQBQjlswhbSrhtampyoQ7Nv5euyBxDJlvV2GUDCIxvvpXMkVCds/pLOcSWGgD3hG5zvv1xUPSAbdyOY1Rps4xJ8Sg6nnTSUvtp++C11nZAv2O+V/GVa4JIQljt9zTEpsij8YdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LVkKEJyP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 485AHllX061040;
	Thu, 5 Sep 2024 05:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725531467;
	bh=E6dXBt7QIZnuVpKBRs1k+5PNTANOLdzwA1XUWEuZ6V4=;
	h=From:To:CC:Subject:Date;
	b=LVkKEJyPurpRdryGnT2cVPvCYN9ZVHU/xjdxBY+EliXY9/7t4XtIuapr2xXgSiiGt
	 4uyZayNAbsVFsEbuLRO5lRuJaWpjFZDiLzE9e+19qqIxN3nonnQI8QC9YXiUMGrrTA
	 a7Gtjbzz6FhtawUQBQjVCuG56iph/FPdEqQcMW8w=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 485AHlqs008681
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Sep 2024 05:17:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 05:17:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 05:17:47 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 485AHlYn074592;
	Thu, 5 Sep 2024 05:17:47 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 485AHkFm004147;
	Thu, 5 Sep 2024 05:17:46 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <saikrishnag@marvell.com>, <robh@kernel.org>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <hkallweit1@gmail.com>,
        <diogo.ivo@siemens.com>, <kory.maincent@bootlin.com>, <andrew@lunn.ch>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next] net: ti: icssg-prueth: Make pa_stats optional
Date: Thu, 5 Sep 2024 15:47:39 +0530
Message-ID: <20240905101739.44563-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

pa_stats is optional in dt bindings, make it optional in driver as well.
Currently if pa_stats syscon regmap is not found driver returns -ENODEV.
Fix this by not returning an error in case pa_stats is not found and
continue generating ethtool stats without pa_stats.

Fixes: 550ee90ac61c ("net: ti: icssg-prueth: Add support for PA Stats")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Jan Kiszka <jan.kiszka@siemens.com>
NOTE: This fix is targetted to net-next because the concerned commit is not
yet synced to net. So the issue isn't present in net.

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 17 ++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  4 +---
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 21 ++++++++++++-------
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5073ec195854..b85c03172f68 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -68,9 +68,13 @@ static int emac_nway_reset(struct net_device *ndev)
 
 static int emac_get_sset_count(struct net_device *ndev, int stringset)
 {
+	struct prueth_emac *emac = netdev_priv(ndev);
 	switch (stringset) {
 	case ETH_SS_STATS:
-		return ICSSG_NUM_ETHTOOL_STATS;
+		if (IS_ERR(emac->prueth->pa_stats))
+			return ICSSG_NUM_ETHTOOL_STATS - ICSSG_NUM_PA_STATS;
+		else
+			return ICSSG_NUM_ETHTOOL_STATS;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -78,6 +82,7 @@ static int emac_get_sset_count(struct net_device *ndev, int stringset)
 
 static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
+	struct prueth_emac *emac = netdev_priv(ndev);
 	u8 *p = data;
 	int i;
 
@@ -86,8 +91,9 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++)
 			if (!icssg_all_miig_stats[i].standard_stats)
 				ethtool_puts(&p, icssg_all_miig_stats[i].name);
-		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
-			ethtool_puts(&p, icssg_all_pa_stats[i].name);
+		if (!IS_ERR(emac->prueth->pa_stats))
+			for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
+				ethtool_puts(&p, icssg_all_pa_stats[i].name);
 		break;
 	default:
 		break;
@@ -106,8 +112,9 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 		if (!icssg_all_miig_stats[i].standard_stats)
 			*(data++) = emac->stats[i];
 
-	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
-		*(data++) = emac->pa_stats[i];
+	if (!IS_ERR(emac->prueth->pa_stats))
+		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
+			*(data++) = emac->pa_stats[i];
 }
 
 static int emac_get_ts_info(struct net_device *ndev,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index becdda143c19..2eba126b2a45 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1183,10 +1183,8 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
-	if (IS_ERR(prueth->pa_stats)) {
+	if (IS_ERR(prueth->pa_stats))
 		dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
-		return -ENODEV;
-	}
 
 	if (eth0_node) {
 		ret = prueth_get_cores(prueth, ICSS_SLICE0, false);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 06a15c0b2acc..43d8b7c8c550 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -42,11 +42,14 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 			emac->stats[i] -= tx_pkt_cnt * 8;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
-		reg = ICSSG_FW_STATS_BASE + icssg_all_pa_stats[i].offset *
-		      PRUETH_NUM_MACS + slice * sizeof(u32);
-		regmap_read(prueth->pa_stats, reg, &val);
-		emac->pa_stats[i] += val;
+	if (!IS_ERR(prueth->pa_stats)) {
+		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
+			reg = ICSSG_FW_STATS_BASE +
+			      icssg_all_pa_stats[i].offset *
+			      PRUETH_NUM_MACS + slice * sizeof(u32);
+			regmap_read(prueth->pa_stats, reg, &val);
+			emac->pa_stats[i] += val;
+		}
 	}
 }
 
@@ -70,9 +73,11 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 			return emac->stats[icssg_all_miig_stats[i].offset / sizeof(u32)];
 	}
 
-	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
-		if (!strcmp(icssg_all_pa_stats[i].name, stat_name))
-			return emac->pa_stats[icssg_all_pa_stats[i].offset / sizeof(u32)];
+	if (!IS_ERR(emac->prueth->pa_stats)) {
+		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
+			if (!strcmp(icssg_all_pa_stats[i].name, stat_name))
+				return emac->pa_stats[icssg_all_pa_stats[i].offset / sizeof(u32)];
+		}
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);

base-commit: 43b7724487109368363bb5cda034b3f600278d14
-- 
2.34.1


