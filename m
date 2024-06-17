Return-Path: <netdev+bounces-103935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8E90A674
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D901F24797
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892719005A;
	Mon, 17 Jun 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mxSwQss2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58B18C32F;
	Mon, 17 Jun 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607880; cv=fail; b=URud5/bcs0ppl71u3zDAoFBMLe+KuxgFrZTfP/8ZpTrmLAiaWw0+ghZhcZYPl9MeQr1/zeJNINggSYdo7eChc0Y4dBFaLatlGXaGWliYhgLxCcgeQ/xbiHlxeurdkbMFtulHC6/GfIS6gd/xT5q8VgKnJDSswxRB75phaXNq8S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607880; c=relaxed/simple;
	bh=7MqqlwKXQW3DO70DmjYbq4WsbU13xQauiww+nODbynE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIRiuV7Efzy5i/ytkCI1rf+ciajmQoCCJ39Ye/vfYhlWYlgh5gIKDpMOvxrUy2lPBLnW9CzUy+ePct0/ArF+SONWtgdHNjeMutvuECRP9vi0XbFsDg1uD0sczlgJi4aBCFIYUwflugzN0rDpV2oXnpCXq2VV8S9j0Jk5WYNIk2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mxSwQss2; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf1zTvUe+gDO7WCWZjNTWfeLNNQ5STEAHcDUrhQv3g2zj5IEq20gAb3PGmmINTFFQu+rC9uOxIZ+LUV5yqXTGavkXEssGbF3DZlcHyiXgh9BG6jRYBcKQ1iblhcJ61TX63UB9EKfAM3WShvJEayT/2qX97TaFrH6rHpk7+dhEbaGdJCEF8UwWVJieaJf+S6Lm2kfsJ2YarAGrK1f7nRbVabRkUY8nNdhuiy3e6s14eE/FCPA1U27z0WuoVpKXq6dchgVLLshMoKC2VsC21V+E8PPvYfE7NEUSQuv8v0+bzgK/eA18ArJOzcxtouRo+jSQHN0Q4dKWrLM2XSgWVDSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y75iML85IXLw79x3SJ4Qgq7zloc21EE8MNIIjB4ONQo=;
 b=fIQ1ey6rho2iACLp4Do/PakVRKLrUPZ0xncK9MRHwSpCoFFJ4dCXX11wz6TFYrGByowQ2J8xD4X3qVoy0BK3+aaQoaJ4g6FWbNsEjzuqFThhDIXX66tMmlmKYbTukWVkeULR8n4W8yLtCVCf7I+5mThz02zOMRkHPeVVsM47D3l0hWoEGeKmk9A3640wccNrf2Z1VknU0M86xYco+2D4eWcLMx66d+yLDO76AOQ+V/D1+FQe9N5hzIgF5UmTafPt6s/PtvZLjawGBf+NNyLoWiqoGkV1Xof49jfPml3K81PWgu6eC7/334NhT1ibv4HY5x9rDrOQzG8YO8RHkTXFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y75iML85IXLw79x3SJ4Qgq7zloc21EE8MNIIjB4ONQo=;
 b=mxSwQss2lNPD02zdCclHBqROKWhMKxnpO/fpX5R1tdtMYjh2Qe9Gujr8SiJM3LlSGhLO9cUsOpIxnR+rLmwryk5eu1YLop+ort8P7U9NVpYDK3ALz99V6O6Yv7ukBwZRcMHVtDFV2h33Ti36DHFkEpBNSuSD+xugOCBp6/dUVaw=
Received: from DM6PR06CA0069.namprd06.prod.outlook.com (2603:10b6:5:54::46) by
 LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 07:04:34 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::86) by DM6PR06CA0069.outlook.office365.com
 (2603:10b6:5:54::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:04:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:04:32 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 02:04:27 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v6 3/4] net: macb: Add ARP support to WOL
Date: Mon, 17 Jun 2024 12:34:12 +0530
Message-ID: <20240617070413.2291511-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
References: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 897e39bf-238a-40b1-f626-08dc8e9bbd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PYZmqooXrz/NPXW+kgfE8wsMJi3jFGp2XXPEZ73mF6T+Q8ujZgEpuNZWBBlU?=
 =?us-ascii?Q?8A6adfh5VBWWfZtxwuVA4D+s0KYdLUtCjaM5qlqGa7k+DAsasNCpTZeDhVju?=
 =?us-ascii?Q?hhLaRBvgBomKpjSMcMJrgAFeCoZ0eBjXfEwGXsE0Jdu8tQsycA9wQisdgg0k?=
 =?us-ascii?Q?s57bgfZit+Cau2tvmxd+o962kyGhx3rULF1ePKrK8FupM48AexRw6UXN29Y6?=
 =?us-ascii?Q?CreAggDPMbQS57Z+wih8OVTZSnNBL5/Pmm9YIgrf+s+DCWAR0uWQQDImnsv9?=
 =?us-ascii?Q?AjikgsWSiLiDXSwhLsYrBNkYPwsmlYsknIcI12Op1ZDnrxOhabKgbesseu0L?=
 =?us-ascii?Q?6rfh65HzZqO6pSjXNv3vzAGga3OPzI1ZDmkiRPycN97gKBJ4nm0bjEBOGTmg?=
 =?us-ascii?Q?8WkSBEmFw0ebB39Aw/rSjqhjTM69JwmvCzldIwNSoGNWVwe91kR1hLqlbQlb?=
 =?us-ascii?Q?0culb3tgL9h8YQbD1W1Gg2fFhqfBe6c9Shjqg0RSEz0z1USv0cd0eHThj/au?=
 =?us-ascii?Q?+d64b4NldAI3kixokHMKgg/1jLV9tDc+Yr4OmbROzjQT3Tq0XpNp8Z3ZaXNU?=
 =?us-ascii?Q?ko1cTjOHqKS8IrDoWyXtiQn3hz2wjZinFn7p7psvAP+6tD6/qeTpPsExAFVm?=
 =?us-ascii?Q?JttBsqw8dts2VjGIKcVLvR0SpmOU7yz3HRWC3XzVu2eTqkDt3xOkt62Xm1be?=
 =?us-ascii?Q?cWwMlO3uvMDCAPWmY3mbz2ZT8rhGLauGF1PcoQHNnDK/cn23FU58HwNe+k09?=
 =?us-ascii?Q?Ypski3jxD+LLMr/wkN2rRabvb/YTiWfwPaI6Qp+O/spxcgfA8y+CJqbPy9C5?=
 =?us-ascii?Q?buLZ6Etwb4HSoQ1EwuDek0srAToayfgdeYVLKTJTp2pnq7ZbJhs+PYT3NpvF?=
 =?us-ascii?Q?nVtVYWxrVXOIRvnNFR1L6PvEo1wQ8Y5Er0JJKLTtU6RkV5XhVN4jdOEA6V5p?=
 =?us-ascii?Q?sPAE2AebqFQZWXcmlyJ59laD1B57ATaef6CwaHpYx7EvmH3yPOTGBg0wwVFv?=
 =?us-ascii?Q?wvYWOP5tqmmTQC8vRrdH8IxspfB4hJPoBK8L2YSDJwVi2KukYv0OKZX8mBg2?=
 =?us-ascii?Q?RF7U+1M6JaUNUDuxo1Ij0RmhmsDeVVSZ9swv6MWa5GG0kR7VURo6EfbIJdM3?=
 =?us-ascii?Q?VhfbAPy7IsPZZCTVt3OsotRY2n1AxdvFwHSjdY64GmKt0Eat+ndlOonb5Kb9?=
 =?us-ascii?Q?ihuVpuxcNgFTFtkWYMqKbcuF7+IMclPSlOoHlKwT1OuKxz8Ryuoqpf5dR2oV?=
 =?us-ascii?Q?/1Q9o3rsppghQdNUW3QHm8mqNx1qwaSco90FJkF/6JggC6biBZmOvmYpQInG?=
 =?us-ascii?Q?pXvTHUpWkWn2vMe5c8RpMiFvT1Af7GuZ3LeNEr4wda8UfeyK6WH2heXCWyU9?=
 =?us-ascii?Q?EAq8kgUIOEUhmd8SU+UrhVhK6nMLkInn0CTTPTX6g4Pcx1bOfz8aEtEa5iyc?=
 =?us-ascii?Q?EVzFUiNiLmw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:04:32.9512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897e39bf-238a-40b1-f626-08dc8e9bbd84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134

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
Changes in V6:
- Use rcu_access_pointer() instead of rcu_dereference()
- Add conditional check on __in_dev_get_rcu() return pointer
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 59 +++++++++++++-----------
 2 files changed, 34 insertions(+), 26 deletions(-)

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
index 4007b291526f..8937445549a9 100644
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
+	/* Don't manage WoL on MAC, if PHY set_wol() fails */
+	if (ret && ret != -EOPNOTSUPP)
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
 
@@ -5244,7 +5233,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct in_ifaddr *ifa = NULL;
 	struct macb_queue *queue;
+	struct in_device *idev;
 	unsigned long flags;
 	unsigned int q;
 	int err;
@@ -5257,6 +5248,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		return 0;
 
 	if (bp->wol & MACB_WOL_ENABLED) {
+		/* Check for IP address in WOL ARP mode */
+		idev = __in_dev_get_rcu(bp->dev);
+		if (idev && idev->ifa_list)
+			ifa = rcu_access_pointer(idev->ifa_list);
+		if ((bp->wolopts & WAKE_ARP) && !ifa) {
+			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
+			return -EOPNOTSUPP;
+		}
 		spin_lock_irqsave(&bp->lock, flags);
 
 		/* Disable Tx and Rx engines before  disabling the queues,
@@ -5290,6 +5289,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
@@ -5305,7 +5312,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
-			gem_writel(bp, WOL, MACB_BIT(MAG));
+			gem_writel(bp, WOL, tmp);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5317,7 +5324,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
-			macb_writel(bp, WOL, MACB_BIT(MAG));
+			macb_writel(bp, WOL, tmp);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 
-- 
2.34.1


