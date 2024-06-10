Return-Path: <netdev+bounces-102155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E5B901A44
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA87AB20E4A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53C179A3;
	Mon, 10 Jun 2024 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kzgc7Z97"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE720319;
	Mon, 10 Jun 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998006; cv=fail; b=Yh0PuL7kbVyIbppu9zk0CQ54Mx1TyzawbByiJ90TGoh1grgVFessx40WZHGrqW51h2gWrQT1cdnNDY8lodYCHYew8clx7zVK6zJww957SmXpoTkf3sFTDbrGFKRVNRJd2IhJsdPDhWdQ26zHOEDoVsj8q8QHAWPYQD3pd3DzkWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998006; c=relaxed/simple;
	bh=gZbbo4GYPChcRlKhSmn9ySsKG4mi5TDscqAvniEIzYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKwhvv75TdC9EraS9lRRRotWF1Qgi8shKwKUGf+RjIs6KXNJUwC0ADImg4/u+IHjIcmpn+4vVVGIIiV94QG81CYxK4HiNdTpkXu7Zv/42W33ey1U6WCgwuxtli0ABuV4jsJH4gbvK0G4hkge1JcWwHGdqaQ06OA67aAFMa52O5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kzgc7Z97; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jyg2qc3JUC6BTVsWxVUzAtxqxpOO1goSlX6Mlt/shPjmvpYUGXzbcljHFBH1be2++0LgX2sQCwkDzysVEZXW2Qk3UcpeVdXdhivGgFwURBAkBrIW+uj3XgcTpJOhwDPxk4R11ZJXDl2TidB264vXTmTcFzdZtkpPrY7WYKREoUy2hbhqVPgmGkqpCf/mo30E0XvHY0T84AudiWh+6H3w+5gqJsO+QfNwq2QX6J7iwP2a/qqo36OF2Gt09ICwJVUg2kPi0rfeAE2jURQLSpoORe0m/uMlJR0Z1Ls8+nnWoZLlVMACelgK1DZWviITZtXhhshc/atrRbwRqSpfEmPyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6Ff6uad9g5ee2rRew6PBHKJqa59JoBHkWRH35K1sWY=;
 b=KuDSnu2xE7HcXG5QmqTRx1v36ucL9GTCmJT4k7A51uTg+rGoG0FlM1HGPvZHdkAvBCPFe4cM2pETUF9OwieZXBNtWreLa2+YF3sz2miufUsy3AAxx4dXST9ayIkFN/O0m7K/AQDJ9mTPRcEeufQenUB0qa/pm+7BBHRXIjjCtSDOX/mPVaQCh4lSWMZm8lkOqmm+Dte9d28dTh14zFYyrv8XLyciwU5eQJRTFA6u/BN6JVSTYkhEx7FOLkad5xErUS2dvSSg/OPDCv4Pui8hitxT6XP6RNyzne9AsHy0Ss4Gp9GUGIL1Zqargc9MXuSneAqp9jmGOoq/MYWIZSEi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6Ff6uad9g5ee2rRew6PBHKJqa59JoBHkWRH35K1sWY=;
 b=Kzgc7Z97I9wyGv2eAtT/qHuWuNlUsCv1iueuwXgSHM2aZEi6dawrnDISF4jDQih2EW5W0/BcJtoL6Aw61wqEfyy/V5zNmN2rmoBSf92F2nNCw8aHPChTQFQnQVGOB2kSDz7UOV7KSxZldvq2RldBA+kjh4frzvJM4eWk0SOhgiQ=
Received: from PH8PR22CA0002.namprd22.prod.outlook.com (2603:10b6:510:2d1::26)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 05:40:01 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::52) by PH8PR22CA0002.outlook.office365.com
 (2603:10b6:510:2d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 05:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 05:40:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 00:39:59 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Jun 2024 00:39:55 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v4 3/4] net: macb: Add ARP support to WOL
Date: Mon, 10 Jun 2024 11:09:35 +0530
Message-ID: <20240610053936.622237-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
References: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4fad41-bbf6-406d-5d2f-08dc890fc5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|7416005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpKniSKl5E98FmJifOSjZDYhJ9l0HstCwNCWPS8MfWEfEDboZtWywnOL+JMY?=
 =?us-ascii?Q?0tX1uuJ06xEK9ShYM4trAMwjibRJB3pd8tM6PmNBe7DvtnX3lRlkIa3vzA7f?=
 =?us-ascii?Q?v+sTVxyb/MMnxmUshyRfJ2tZz1Zw8UkuKWMUBc1YGIPoWTmRaFNLUr098yGx?=
 =?us-ascii?Q?8zqE+5rDx/vqX0Eh/m1MxCDjj5RUVNdPMngJbVLOQz7jrozoYAts6REVkBcT?=
 =?us-ascii?Q?XYT3EURAt6k9ipTlTcggDg4c/o+SVQC77/64YhH1FaElfjGNtUf5UCyqhmIp?=
 =?us-ascii?Q?UrRQSQXnara9OREuPb1hG/6pcQW2YqTvvUq6GzzMyqCaRBwFF6fc1rJ61fIh?=
 =?us-ascii?Q?l9cwdJdc4vd4y9GfcsVIjUIf2xQRG5fECe5VsekGRxpMD6YYlyXaGF9Pz5pC?=
 =?us-ascii?Q?ZJIOuP9x7rD/mCs3sH4AfmTC33D9NxmTCEdVnLwwxayYWB/f3ewDh1HjzisR?=
 =?us-ascii?Q?zXBptWmWXS+elmHAAFUlT91MYstw1GV4vFe5kXatqADenNrct86iqpbdvXGC?=
 =?us-ascii?Q?bO1p3KW9/Iz6QM90lSckLVW2/rmW0wEZHvKhVGoOrNHX+/9R+581OXCaQ14t?=
 =?us-ascii?Q?uqwzOwFw3wC8IRNAfc8BX8TGBCpTJMnX+ndBhJmtdX3EBcS4Kiqhn1FiBQEA?=
 =?us-ascii?Q?Bze1VHKldHpYwnYLlV3La4kIiNzWlx52kNVW31hM+3CuKb1wxlISZVxMMdxj?=
 =?us-ascii?Q?1JDop6WX7Xtd9+Pd6TrAbAKIZ1+5YxKG+ARJhMj+RHptwyqLs80zfBvitK2R?=
 =?us-ascii?Q?Ed3Hku5IEjI/yIAbiYb40n5ne8VxBHD6XyqgYJhsqi4vVWHYL5/iwEkl1h1f?=
 =?us-ascii?Q?i8H1kfVhyY7dnPHILe66X0fK4ja6Qf/jSn9i8ip2FiKonSggointPk75VsBU?=
 =?us-ascii?Q?kFQu5sZ1Ep2QMugZK+Ss+mBjAUF0VlFQlpJo/18LtutgK6Y5fxHt9ClHXpeA?=
 =?us-ascii?Q?RdGMVQ0OaU0AVEC7qeUuSfGW/BhyRK9KjN3eNNCWuqKjcY/Aa4ZaGw3wq2Vj?=
 =?us-ascii?Q?34t0wkgMjkQQ6ztArFcGaH1GhcDHpkSMaSE6tA+aZIP/wrPPMP3WpmDSWC+U?=
 =?us-ascii?Q?AM64HeaIX7U+hZv51H4IqeEo7inK0BWonuoejZWLS/fB2pNMUoMCkG24p/u0?=
 =?us-ascii?Q?s/H8U50/jU4nrviXys/hXe5c6sVyULMqVn0g3d5fAOJH5xKnzD3sR3iexzeS?=
 =?us-ascii?Q?CaJlQJvT+TV/ZcvCqttfEXW5S1iCg9YbtkVg0UdXOHMhWG+SSlgUON2P5z2X?=
 =?us-ascii?Q?7IppehrJh4ZXIXrHRm5qe1FLXGgwnGEZ2KLAb1Xg6Ck4Vw9+J6Iadr/J3fa4?=
 =?us-ascii?Q?107X2/0Z8Ar5nBisY7er910JAs95T2di6MDnbDgzT66mv97SXRjdM217vvBn?=
 =?us-ascii?Q?OOf4ZuMO7KQu05h+/2nzWJtwXL+e/mM/sAz1csNb4APf9EpqXCeO7rvU/ivA?=
 =?us-ascii?Q?3rU3ECEHU50=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(7416005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 05:40:01.2561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4fad41-bbf6-406d-5d2f-08dc890fc5b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984

Extend wake-on LAN support with an ARP packet.

Currently, if PHY supports WOL, ethtool ignores the modes supported 
by MACB. This change extends the WOL modes with MACB supported modes.

Advertise wake-on LAN supported modes by default without relying on
dt node. By default, wake-on LAN will be in disabled state.
Using ethtool, users can enable/disable or choose packet types.

For wake-on LAN via ARP, ensure the IP address is assigned and
report an error otherwise.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
Changes in v4:
	- Extend MACB WOL supported modes to the PHY supported WOL modes.
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 56 +++++++++++++-----------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 50cd35ef21ad..122663ff7834 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1306,6 +1306,7 @@ struct macb {
 	unsigned int		jumbo_max_len;
 
 	u32			wol;
+	u32			wolopts;
 
 	/* holds value of rx watermark value for pbuf_rxcutthru register */
 	u32			rx_watermark;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4007b291526f..1844fe719e78 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -38,6 +38,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/reset.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/inetdevice.h>
 #include "macb.h"
 
 /* This structure is only used for MACB on SiFive FU540 devices */
@@ -84,8 +85,7 @@ struct sifive_fu540_macb_mgmt {
 #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
 #define MACB_NETIF_LSO		NETIF_F_TSO
 
-#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
-#define MACB_WOL_ENABLED		(0x1 << 1)
+#define MACB_WOL_ENABLED		(0x1 << 0)
 
 #define HS_SPEED_10000M			4
 #define MACB_SERDES_RATE_10G		1
@@ -3278,13 +3278,11 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
-		phylink_ethtool_get_wol(bp->phylink, wol);
-		wol->supported |= WAKE_MAGIC;
+	phylink_ethtool_get_wol(bp->phylink, wol);
+	wol->supported |= (WAKE_MAGIC | WAKE_ARP);
 
-		if (bp->wol & MACB_WOL_ENABLED)
-			wol->wolopts |= WAKE_MAGIC;
-	}
+	/* Add macb wolopts to phy wolopts */
+	wol->wolopts |= bp->wolopts;
 }
 
 static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
@@ -3294,22 +3292,15 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 
 	/* Pass the order to phylink layer */
 	ret = phylink_ethtool_set_wol(bp->phylink, wol);
-	/* Don't manage WoL on MAC if handled by the PHY
-	 * or if there's a failure in talking to the PHY
-	 */
-	if (!ret || ret != -EOPNOTSUPP)
+	/* Don't manage WoL on MAC if there's a failure in talking to the PHY */
+	if (!!ret && ret != -EOPNOTSUPP)
 		return ret;
 
-	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
-	    (wol->wolopts & ~WAKE_MAGIC))
-		return -EOPNOTSUPP;
-
-	if (wol->wolopts & WAKE_MAGIC)
-		bp->wol |= MACB_WOL_ENABLED;
-	else
-		bp->wol &= ~MACB_WOL_ENABLED;
+	bp->wolopts = (wol->wolopts & WAKE_MAGIC) ? WAKE_MAGIC : 0;
+	bp->wolopts |= (wol->wolopts & WAKE_ARP) ? WAKE_ARP : 0;
+	bp->wol = (wol->wolopts) ? MACB_WOL_ENABLED : 0;
 
-	device_set_wakeup_enable(&bp->pdev->dev, bp->wol & MACB_WOL_ENABLED);
+	device_set_wakeup_enable(&bp->pdev->dev, bp->wol);
 
 	return 0;
 }
@@ -5086,9 +5077,7 @@ static int macb_probe(struct platform_device *pdev)
 		bp->max_tx_length = GEM_MAX_TX_LEN;
 
 	bp->wol = 0;
-	if (of_property_read_bool(np, "magic-packet"))
-		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
-	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
+	device_set_wakeup_capable(&pdev->dev, 1);
 
 	bp->usrio = macb_config->usrio;
 
@@ -5245,6 +5234,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
+	struct in_ifaddr *ifa;
 	unsigned long flags;
 	unsigned int q;
 	int err;
@@ -5257,6 +5247,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		return 0;
 
 	if (bp->wol & MACB_WOL_ENABLED) {
+		/* Check for IP address in WOL ARP mode */
+		ifa = rcu_dereference(__in_dev_get_rcu(bp->dev)->ifa_list);
+		if ((bp->wolopts & WAKE_ARP) && !ifa) {
+			netdev_err(netdev, "IP address not assigned\n");
+			return -EOPNOTSUPP;
+		}
 		spin_lock_irqsave(&bp->lock, flags);
 
 		/* Disable Tx and Rx engines before  disabling the queues,
@@ -5290,6 +5286,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, TSR, -1);
 		macb_writel(bp, RSR, -1);
 
+		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
+		if (bp->wolopts & WAKE_ARP) {
+			tmp |= MACB_BIT(ARP);
+			/* write IP address into register */
+			tmp |= MACB_BFEXT(IP,
+					 (__force u32)(cpu_to_be32p((uint32_t *)&ifa->ifa_local)));
+		}
+
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
 		 */
@@ -5305,7 +5309,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
-			gem_writel(bp, WOL, MACB_BIT(MAG));
+			gem_writel(bp, WOL, tmp);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5317,7 +5321,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
-			macb_writel(bp, WOL, MACB_BIT(MAG));
+			macb_writel(bp, WOL, tmp);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 
-- 
2.34.1


