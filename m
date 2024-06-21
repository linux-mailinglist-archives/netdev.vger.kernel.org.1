Return-Path: <netdev+bounces-105537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36499119E8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C16B231A5
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC1155300;
	Fri, 21 Jun 2024 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bmr7B3Th"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D4148841;
	Fri, 21 Jun 2024 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945880; cv=fail; b=sTS7mQlOC/hdGFMZ7JmN8T/FXve7nyfENZ+roePN8IXFiAiLXwWGv07odEkr06UwBsImT+BQYuONW9A/pFXL55S3JWmCL38FZLiQquLJ+xOeHmA/eJwjG2AnLG+sdrCy1LvpeYFrIEWNMDZjT/TuuyWWJclnf8NQwo3gh3FrWko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945880; c=relaxed/simple;
	bh=rxBwsVuEMm4en+iudM93JFNsQmWJ/vOD6p4igVb6t5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHYW3Kyhful6qLYl6LmDc6eZHbPX2z5d1I8l62WyRYG1fBkdwBb/StmQ4IR/Ws2ff75NprTtxxNjBtPm0cTmc/Rr7dzXL7UfsJGpeg0Zt3aZTGLy+mfsPELo2nKjDsXsfZCpud6+1Fh82iqC2EboIudu7ZW7Mt+HHAESnWXt4NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bmr7B3Th; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbJBuVA53wVF5UzjbqKAVmIIcwbmkk616+XYb7jhG3oj1UwzbH6ebu9vabJ9ZNYnocinc2b6R6ZyxHtSlvkvk1rZtOaZF7TGBvo65VHFFwB0akr1UaNpWvKAM1MMX4ixTOLyLaQICvRTIONlISXPSSshfMkQ8XWKHNOSvDvgxO/2rF8k5pnjQUPgtBM/Wm7/supUuGx2mqHc1qUf7zt6WVNY4v06n8OgxPHx+Es3rWdZ7ADB2l1nQ4PgNJCJRcUdoPskSIPpR6CoeD7iWHbzxD/qXfYG3rYqgXQCpYa9HxSURvZjJCZfAciheUIhm+GlDZ1pcHZXMzD60W3vOGkKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvg3jpW2lh2t3pX9aK6gtQZCKnwwi0XkmXf86dtFZRM=;
 b=QE8yu1EnO4iP/HA0TQkJNwzoY+vijrnuMYW6IUJzZC1bxsmyHKtx2BDCne3yvsZDN++hKaCNqZ20Ri5zAmBJhl7lEsmvGHxHgzPR1K/ZV2KHUCrGtRT9rImGB6GIaILENl7RD/xed/Fw6DVN8ZgySHT8JsspdOTlqrUkXbwV2S6qZG3TSAkwQXQFj+dZFNSvdOz8H9rTtXJv849glJCvo7x62ovCqbe+AF0GHhSvD7fdDmKZVYDEpvY/ME3MZ9zdASOJ/ZAZXPpaofowYp9/Nq6WmSMWip+nspfY+rCPHckY0Km7AFIOFt5PpN3hggJmwSw4kQiVr0+FHM+/dV4Jyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvg3jpW2lh2t3pX9aK6gtQZCKnwwi0XkmXf86dtFZRM=;
 b=Bmr7B3ThumG8oWhshOMtHN4FHmMRJnUjV+OD/hG17uu/kkWGxzfiVYCvDQGBf9PDXM6xd4h+SqfiryCYmnM0vtBoWwa8V7e3V1QtfYKHLLsFs3dU0dTTO2v4HrqQmVb8jkTU266MuBOv7Gcr4GWB7J9ZEmRAxKbpp9rFkI5AeFI=
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 04:57:56 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::3f) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Fri, 21 Jun 2024 04:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 04:57:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:57:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:57:54 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 23:57:50 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v7 3/4] net: macb: Add ARP support to WOL
Date: Fri, 21 Jun 2024 10:27:34 +0530
Message-ID: <20240621045735.3031357-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
References: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ed7aba-13d9-4dfa-6e3f-08dc91aeb6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|1800799021|376011|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mE51oVk/JuDy/C0udJQSSifq36PHnGywcwwZVnymJBlTEUwj0H0sgaviJn75?=
 =?us-ascii?Q?pJ5zuecUmpsAVMgnr1MWfwajxgJkF6FBWNFjjQRv/cEXBLzRDyM+nDVlX9Vu?=
 =?us-ascii?Q?yhJLC86HHXgCDVFPQmhmLoXY+HgBalY8quT0rf/rVGT7Npcvi8vditbNQIde?=
 =?us-ascii?Q?J1MPd8YQU0OL+s3Q/QJk9h+gaPPI7gENoo7OZ06XSLiHuPFgxzg8fp2pSCGl?=
 =?us-ascii?Q?015M30n0/5grExsDEkFx5OSE+UAcggXS4dQonAnlwuJ/gFsIjRatn2EKZDwO?=
 =?us-ascii?Q?/3MHmxJv5/FHuuB+8abL2zcPainWvOPxfX7GpDp3gMvCjwfC8VtBGf3wqc15?=
 =?us-ascii?Q?RC9nQwPn2mxJU7RRZ87jT4CuSHQULNpfUa4KwOGRwoAcwvtINKt34ZPJwsH5?=
 =?us-ascii?Q?HnnTF6HF2QVQ/CwhHx13gGZjuYZQ3iap798oOxQJjuJkRKc5nOLE9fR4y/yO?=
 =?us-ascii?Q?ORI6Stje/iRsWbh1f4KkWVBNPMzlkmsqsKko0MbHZuKLtImIf7E3a5NV275E?=
 =?us-ascii?Q?OQrzL31+vy87TbFtWIQOWnqdxHnccGnk7iPvSFTdIx0tBlH9ToR8uSsex4f+?=
 =?us-ascii?Q?frHVGL5tz9gqb9rqieDyEkF2vQoYP53SEnQMax4kNapbNpnJX27YA896aRJy?=
 =?us-ascii?Q?ix9cMT6SchSfUdbQ/JwCpzQUV3AvwSdbDfYh2uSty3n4f4wzmxG5CnL97g4N?=
 =?us-ascii?Q?pF7QBsslxcplc4DpEdepMj0rhKySNHtLv/f9BdyqUT8P3pvGnN7W4l6EBL2s?=
 =?us-ascii?Q?h6ZPvwwOXfBroUrI3xzNXwAK1VBhYvUJK+YgD9mabvG5cCxIcrjW8/hIW+U8?=
 =?us-ascii?Q?tPtwTEJDuflWesPhenZ8ADod00e942Ruyvvg4JRi1344S8IZ6u3NA0nfW4rS?=
 =?us-ascii?Q?WTrT3O9tkYHYqTlOFWsOXuIOuLJ1GTWOH54iYGklv+t4/6yVWhPnBEeJSTpa?=
 =?us-ascii?Q?nO+RxO+S4h7fXpeDU4myM7eHvyxe0DK6uUru4XhAlL9vnsH3YcptjOPBYX7F?=
 =?us-ascii?Q?UT1y0iIrEwTu7fa4JzTj2RNUeBe0zss84R9vfKopM8OPBPkRO/rShhX+lGhR?=
 =?us-ascii?Q?62TZ8tA3Tq68E8uF7Nzn6Hknv+yKfqNJgeHI6aiVYSd1wthwGSAn0AKC2tOr?=
 =?us-ascii?Q?1HY/KlIZZoZ1ybLW9s/8rZ66H+JYjMcIE9XhSalsMyMFrX15CpIOWfoBQpjO?=
 =?us-ascii?Q?xvtF9A7govgNCz+pB7cUfyoO8pUmioz9UfF3rEOTY8NdgPZRCxrlS9lXNFZf?=
 =?us-ascii?Q?JOXN0OFNhUE7CS1QrJQett65H9X3YFY1mWlHtsWAYfHO0w8rDW4r6ffWDA9L?=
 =?us-ascii?Q?8Ly3wEXdLd9UhBkbHwVs7+hh62w0GxEBBwmpJjh6J86lDcExoa6E9gshurAX?=
 =?us-ascii?Q?5wniCYLvQQuF9Gkysjtq9Wlesd5EbtWgZNvv/xLhTBJXmjLcub7YBxw9bsE9?=
 =?us-ascii?Q?JOsJyGwPg2I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(1800799021)(376011)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 04:57:55.6371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ed7aba-13d9-4dfa-6e3f-08dc91aeb6cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239

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
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 58 +++++++++++++-----------
 2 files changed, 33 insertions(+), 26 deletions(-)

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
index 4007b291526f..cecc3d6e630f 100644
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
+#define MACB_WOL_ENABLED		BIT(0)
 
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
@@ -5290,6 +5289,13 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, TSR, -1);
 		macb_writel(bp, RSR, -1);
 
+		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
+		if (bp->wolopts & WAKE_ARP) {
+			tmp |= MACB_BIT(ARP);
+			/* write IP address into register */
+			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
+		}
+
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
 		 */
@@ -5305,7 +5311,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
-			gem_writel(bp, WOL, MACB_BIT(MAG));
+			gem_writel(bp, WOL, tmp);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5317,7 +5323,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
-			macb_writel(bp, WOL, MACB_BIT(MAG));
+			macb_writel(bp, WOL, tmp);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 
-- 
2.34.1


