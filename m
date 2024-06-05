Return-Path: <netdev+bounces-100937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C808FC8F4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CED61F26B40
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2D192B84;
	Wed,  5 Jun 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1fwshQEm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAA192B78;
	Wed,  5 Jun 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583126; cv=fail; b=kdjV1eE7MX4zACxl1sdFZI55secfW8kvmST3KvsiWK3EpDqDzgZwtJemcG3VAcUMOIpFuuQFu8cTIIb2VONXf/DZzAlSbQJBt+1WQcY4wj7hAx0S1O2qqhCApuL+EgfF18kqVXBDKrOremun0jG6/c6NdpAZhy5E0YwizGRBdKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583126; c=relaxed/simple;
	bh=P7Xa4RQruexyyRzBwhNfiYAZdJGXGmyvHHNlf29iROE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iou/lnXdaMO/Ac8AKAddgDRbhVTo1VNlz1GIDNGCpEIWbQR0KjzuMLiVk3cNOtH2Z2ouEN3yT7IBizwE/Dz6/PZJgfBAHrofgFauopcuR+kH7xCHU0HUNfdJt05tJtpdmy89bokgAypgbDyolURXmCz1lEf4ldkCpogja1XaV+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1fwshQEm; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVSLd1shVmqBIcussW9gesZ4bExHJnTX20+tvEgQ5EOz10vAy5/7WJAKM7ezjBo5uAK/+wzdefILNnxxFGGgrKJsmrM4WkgJBEzSMs2s4WnXHywhA/2LbGiIHjf2M3YDjoSEQLInlqGwLjMHfBJwtrY2TkA50BR0H0YDtcw3lFfThH+OlVcJ83FnrcLUXvvc7fQfrSsWq1g9ZPLpaQ9azhJ2HrtS/QaUt/kQih8vL+ixv66qhcKWC/C8Oypa8RDVtnoLdJkbtZGzp4sPbNsaS38uaz1idKRvF5cRTvMZxLDp2VnrCu9HCQ6gVaXm2xyP/VXe3sIMSpzTbbiiNJ+GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YDSvEHgHWBIHS2oUhFWyS3cIeoJH4fBkyG4ggnFFXM=;
 b=UKvloEQwY/Z3ZAKsjsxE8jFUflSf9qrPVu8AK5m7zfpcmHNyxT6P4L8R2G7MYqYlTBCLfmy8wiRpGcMyH3EPk2d4kRP59QgfxJ4qy6htzhVNM23mx2oFL2nRhg13U/srnvlZAZCs5YHoSr3goMENJ1IWZtA+6dzz/6+69/iawD8rA1psM6z7Kh6thTCf9tozLe//cPgJU6T4iHnUvmxKBWIqUhkJMkzzk1L7FsuUSrJDMyfeW5i1ZBsZxdQT+RNgpvXZFEuhar2hDO9g2sBiLtf+v21AkoY9EmBaBw06Evi+23OzQ54a6jDyDUGGAeDvVMiNoXceYhJ4Gxh4E0afqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YDSvEHgHWBIHS2oUhFWyS3cIeoJH4fBkyG4ggnFFXM=;
 b=1fwshQEmY0N81ZXm7FSfcyBHzBmoxzfW58hVZkS0Ex6HuXwfFGwBmMwQIlv6qurZypu5JhDsqhW7JtZwW2eFa36MbnT4HrFk3XN3AZY68H2Eastn9AQDnzlkNV/0Po4W/DuxdPd31fIF5AIgvOzDuxpbLTT20ETuxvq/VNYFqVo=
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 10:25:22 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::a) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 10:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:25:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:25:20 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:25:16 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v3 3/4] net: macb: Add ARP support to WOL
Date: Wed, 5 Jun 2024 15:54:56 +0530
Message-ID: <20240605102457.4050539-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: d91fc176-9844-4ac0-3fd4-08dc8549ce40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|376005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LG4+rNFdCzmnDWI4fekxkqq9aJ+tS9NUTU7jj3GDWSu0sTjvBVvNj021VI0R?=
 =?us-ascii?Q?gcm5rMxqIw3dArPTKIf2oimcq52jOpPQtu05v0ySVSSDZ+4QClC6sA5UZSha?=
 =?us-ascii?Q?MYeEghlIPfhQhqeD16EoGYpY8rzgUpkTSpaGWHT+GBzvuqRKr3IX13FagMIr?=
 =?us-ascii?Q?0OvBkD1RTWamUOk9fiTPmVib7G0MizL33mwwcEGGBN+AmqG0skCC5XbJlfhM?=
 =?us-ascii?Q?4DvHDTH8hepHTOeul6jBsx+BhXGYKEV9C6GBZFELs6aaFmXfuaVzfvkkWDCO?=
 =?us-ascii?Q?6EBoOS5o4cH+yneRXtCZ7ZbJGLK6zMGw+oqs6+xEqHf/3jxuSr2GJl92XcVs?=
 =?us-ascii?Q?njz4Y9yCtJ/rP23N8W7cM18J7gvkxRQIG4QfvTeU7PJet0keH0rbP3xGsxQL?=
 =?us-ascii?Q?3umsjDEoE9C3tv5oxD2Mnw5dZCdY+OA4JKQyIVybhcKDyf+96T242S1BlOcW?=
 =?us-ascii?Q?snkMfTYcGmINWTqem+KQ3jbwY6uOQthlxqF4MkF3wdFWsYF63EJM4OVANh5O?=
 =?us-ascii?Q?Q0Lls606w6hVh4UWeMuWhK84bToLtSjsmF7PaRJhoJk7iafl00j6BGqSlmG5?=
 =?us-ascii?Q?bJNxS5twTz/7w2/kHxkGzMjzR2ePTZSOj200puLmOgdTzBwGLkl6gCJLJNPV?=
 =?us-ascii?Q?PCOlRxo/MGfV8MFpbSZCbISQUEQBsG4Q4NhkijFqg1JlAED74Kk++5LxdLGx?=
 =?us-ascii?Q?YQKnDPaGN3wFQnY27s+JkWbCKfsMGPTL/EiK454ngawqu7898K4aW4w6kj0c?=
 =?us-ascii?Q?A7N/t61BzmsomfuYTUCGMp6xWuEPz1JQBTi4wd+hFCaA1BL1laxo0Zid4Tlf?=
 =?us-ascii?Q?5DIt1YfDPVJ+Ism6n2VKqSa5IaKKUThcdcBRo+tv09HexFxixNhnuh5GHFbl?=
 =?us-ascii?Q?DdyJBi9uOS5dwhOKjgv3ad00L0X6DgqDAAqADfLUM0gaiwkIt8Yd2ymeSFr1?=
 =?us-ascii?Q?DZE2nG971UmX7NBvsYqe+rXCvWutd2n7eLDhCux1LKjhGnoI/y3MNpeKPmQf?=
 =?us-ascii?Q?c6mPiMpEObBB82qkC0KGzjCSgIxIYo9ga2CP2ZnRXv38YG/6bS/wq6TYBEOq?=
 =?us-ascii?Q?ngNkcTUNpVGjo1y9LjSj9gpbaO5ZKqz7BYncvpavC3IlO27vff/Q2C0+glNQ?=
 =?us-ascii?Q?NTVNglf7n0mWF2QZkGxumbSFzQySZhuG2DuLZJH20CmYnu53liQTZsZOgM8L?=
 =?us-ascii?Q?a/QfWHC9HoGx9g5WwTT0BbkCCD86rcjMugRdeXrxsp7BpuGK4oX9tlHQCT5U?=
 =?us-ascii?Q?nqyktsQFJ69bfnpazEkYb3fNktvzR0XUpm1T5x667Fqna4wAgsZ0XdGf46Y0?=
 =?us-ascii?Q?zzdB7as6FVmrjcmh1AZfsEDt/lR801S1JWA3L5Qyj3YOrVQLOEMSSBBIcNq6?=
 =?us-ascii?Q?XFZurUKMTF1UNSFCmPOrGYmD9wD0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:25:21.8254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d91fc176-9844-4ac0-3fd4-08dc8549ce40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

Extend wake-on LAN support with an ARP packet.

Advertise wake-on LAN supported modes by default without relying on
dt node. By default, wake-on LAN will be in disabled state.
Using ethtool users can enable/disable or choose packet types.

For wake-on LAN via ARP, ensure the IP address is assigned and
report an error otherwise.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 50 +++++++++++++++---------
 2 files changed, 32 insertions(+), 19 deletions(-)

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
index 4007b291526f..7eabd9c01f23 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -38,6 +38,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/reset.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/inetdevice.h>
 #include "macb.h"
 
 /* This structure is only used for MACB on SiFive FU540 devices */
@@ -84,8 +85,9 @@ struct sifive_fu540_macb_mgmt {
 #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
 #define MACB_NETIF_LSO		NETIF_F_TSO
 
-#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
-#define MACB_WOL_ENABLED		(0x1 << 1)
+#define MACB_WOL_ENABLED		(0x1 << 0)
+#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 1)
+#define MACB_WOL_HAS_ARP_PACKET		(0x1 << 2)
 
 #define HS_SPEED_10000M			4
 #define MACB_SERDES_RATE_10G		1
@@ -3278,13 +3280,11 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
-		phylink_ethtool_get_wol(bp->phylink, wol);
-		wol->supported |= WAKE_MAGIC;
-
-		if (bp->wol & MACB_WOL_ENABLED)
-			wol->wolopts |= WAKE_MAGIC;
-	}
+	phylink_ethtool_get_wol(bp->phylink, wol);
+	wol->supported |= (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ? WAKE_MAGIC : 0;
+	wol->supported |= (bp->wol & MACB_WOL_HAS_ARP_PACKET) ? WAKE_ARP : 0;
+	/* Pass wolopts to ethtool */
+	wol->wolopts = bp->wolopts;
 }
 
 static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
@@ -3300,11 +3300,10 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	if (!ret || ret != -EOPNOTSUPP)
 		return ret;
 
-	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
-	    (wol->wolopts & ~WAKE_MAGIC))
-		return -EOPNOTSUPP;
+	bp->wolopts = (wol->wolopts & WAKE_MAGIC) ? WAKE_MAGIC : 0;
+	bp->wolopts |= (wol->wolopts & WAKE_ARP) ? WAKE_ARP : 0;
 
-	if (wol->wolopts & WAKE_MAGIC)
+	if (bp->wolopts)
 		bp->wol |= MACB_WOL_ENABLED;
 	else
 		bp->wol &= ~MACB_WOL_ENABLED;
@@ -5085,10 +5084,8 @@ static int macb_probe(struct platform_device *pdev)
 	else
 		bp->max_tx_length = GEM_MAX_TX_LEN;
 
-	bp->wol = 0;
-	if (of_property_read_bool(np, "magic-packet"))
-		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
-	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
+	bp->wol = (MACB_WOL_HAS_ARP_PACKET | MACB_WOL_HAS_MAGIC_PACKET);
+	device_set_wakeup_capable(&pdev->dev, 1);
 
 	bp->usrio = macb_config->usrio;
 
@@ -5245,6 +5242,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
+	struct in_ifaddr *ifa;
 	unsigned long flags;
 	unsigned int q;
 	int err;
@@ -5257,6 +5255,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
@@ -5290,6 +5294,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
@@ -5305,7 +5317,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
-			gem_writel(bp, WOL, MACB_BIT(MAG));
+			gem_writel(bp, WOL, tmp);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5317,7 +5329,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
-			macb_writel(bp, WOL, MACB_BIT(MAG));
+			macb_writel(bp, WOL, tmp);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 
-- 
2.34.1


