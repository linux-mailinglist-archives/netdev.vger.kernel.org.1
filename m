Return-Path: <netdev+bounces-125853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF196EF79
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811C11F2445B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238A1C8FD2;
	Fri,  6 Sep 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yr+yyoeP"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAC1C86F6;
	Fri,  6 Sep 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615462; cv=none; b=C1wo8bO0zT2JXy1f16d0+XUZYJjgHNNo4jNoslGENoJgJ+9ImEYqoyR9Oal0frnt0cCIwTygeNIeUTO5WvJPcf5HPG/neVowKOe0vAChud4XpUY0sf09veozTaV8YJlvvpXBJNl26HTHOZRRdW7hIXbtW+gW9ql4FazZDUPf/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615462; c=relaxed/simple;
	bh=ZjJAm8HU86AbVyh+QUcsqcfE3GZRta3r0DSC5GFF1fY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HQvH8tLSPHqZCBSu+QMhl8fkWD9BIBA114hksZaKeVgL2Haqrl09JfOzMg1JNoGjbdW/kjxN0EDlF5uJHK3IBO6p9XIsm3gJklYG1sSZTsJjcImzAhwSAIG+S73jxBcz2hphI1IZZ0xyIP/WeB0OSfxijznuVzpEU+Uc0AOFaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yr+yyoeP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4869arjo048909;
	Fri, 6 Sep 2024 04:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725615413;
	bh=+Jr/R2zvoa9OrlkdtJ3CRfJHk6CE8wO8NyUem2MPKOQ=;
	h=From:To:CC:Subject:Date;
	b=yr+yyoePBktxkhIe9qbJVTrBh5rZTVJY1ZvDpx3YB0nn4kNkro0fOXLv7zTDF+Mts
	 Y3AY5lmk174u4FKS7Di9aHmMgxeccSOXgdbPpYMX1GzfTiT+UBwbuKIWRofg4T6qCo
	 OkjiEjgUwTd0rF7MmTNgKTG/1r27e2Sp+GRONx+U=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4869arXS024347
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Sep 2024 04:36:53 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Sep 2024 04:36:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Sep 2024 04:36:52 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4869arQn004462;
	Fri, 6 Sep 2024 04:36:53 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4869aqcb018145;
	Fri, 6 Sep 2024 04:36:52 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <saikrishnag@marvell.com>, <robh@kernel.org>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <diogo.ivo@siemens.com>,
        <kory.maincent@bootlin.com>, <hkallweit1@gmail.com>, <andrew@lunn.ch>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2] net: ti: icssg-prueth: Make pa_stats optional
Date: Fri, 6 Sep 2024 15:06:49 +0530
Message-ID: <20240906093649.870883-1-danishanwar@ti.com>
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

v1 -> v2
*) Replacing the error code returned for optional resource to NULL in probe and
simplified the if checks as suggested by Andrew Lunn <andrew@lunn.ch>

v1 https://lore.kernel.org/all/20240905101739.44563-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 17 ++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 21 ++++++++++++-------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5073ec195854..6b5cc1e6d64b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -68,9 +68,13 @@ static int emac_nway_reset(struct net_device *ndev)
 
 static int emac_get_sset_count(struct net_device *ndev, int stringset)
 {
+	struct prueth_emac *emac = netdev_priv(ndev);
 	switch (stringset) {
 	case ETH_SS_STATS:
-		return ICSSG_NUM_ETHTOOL_STATS;
+		if (emac->prueth->pa_stats)
+			return ICSSG_NUM_ETHTOOL_STATS;
+		else
+			return ICSSG_NUM_ETHTOOL_STATS - ICSSG_NUM_PA_STATS;
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
+		if (emac->prueth->pa_stats)
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
+	if (emac->prueth->pa_stats)
+		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
+			*(data++) = emac->pa_stats[i];
 }
 
 static int emac_get_ts_info(struct net_device *ndev,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index becdda143c19..6644203d6bb7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1185,7 +1185,7 @@ static int prueth_probe(struct platform_device *pdev)
 	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
 	if (IS_ERR(prueth->pa_stats)) {
 		dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
-		return -ENODEV;
+		prueth->pa_stats = NULL;
 	}
 
 	if (eth0_node) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 06a15c0b2acc..8800bd3a8d07 100644
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
+	if (prueth->pa_stats) {
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
+	if (emac->prueth->pa_stats) {
+		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
+			if (!strcmp(icssg_all_pa_stats[i].name, stat_name))
+				return emac->pa_stats[icssg_all_pa_stats[i].offset / sizeof(u32)];
+		}
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);

base-commit: 43b7724487109368363bb5cda034b3f600278d14
-- 
2.34.1


