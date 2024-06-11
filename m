Return-Path: <netdev+bounces-102655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611A904151
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975051F21E39
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E015674A;
	Tue, 11 Jun 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fnAz3yvP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672D50276;
	Tue, 11 Jun 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123333; cv=fail; b=XQ3dY92e4Ae0UictipQg6yL1TdczWU8tkCUyD0JoYzgEDsgh7/V5my+3IaPZ4ekxLdyECauE80YF5dGXmHFehMHkFd/zI6EzsbEt/1R6qtIiDSAudcQDYSty8Sk6f7dCilYt0bQbaXdGKRGC3OwsngNlzRDrDX2KjDZ1fJoHRQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123333; c=relaxed/simple;
	bh=9pbARRDQ+Jb8D2sp/epEKjYrgaTK2FUR9VZ5Y76kuUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKAuLh8PT5noI5pScONWHYrJVBBm8tIIHnJdmY/CXvBp3ppqHgOcS0vZagVrsxuq3/7QxmQEalLp5GQ+VzI2458OyuOmZU5w8WgyZNi57fIZu3NyYbyt0ItcP0k8FkEJX0pvfqwO9abN8WkNRDucVoBjkngPVx2f6q+rmNE/4+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fnAz3yvP; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxdgnai2PykTrYSR1E8bgdVwmv+7OVMAdsYx6A8ADO50HrENpM1x2HwpFJX1F9xcbK55EG8VzdpzrKhbJo1nQFoOzURQbU8CP2/6LM4zdbBWUJ/hpcSl8116By/y3vupPEquNaMGia3Ok7DsaVDW9fvy/h7JYKG+kjobbbrnr7dqFg0TeNorQJ7BAPerFXLXbD71JAUC7KsSZyZJSaa0xkM6iCLIk2kxno9bCwzXHU8QcikPGN0P2AHKJHdulUSuhIT9qDOzEgYgeW3u1JK0nq5zKLdsUB1D7SDPuBmepCSvP2FHfxisRnK7BpgSFGZwxclZXJW+J/yC1hvrJnIJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed9hhAy82WMm99ok9osH4KbW8v7CCSU5hWZiIEMfCIE=;
 b=Oftng4ggoMMWvfjTbRcOPyZGP+ELnCXwGa8p0FBJUpONp9Dv4RMRQmYiGmKfUzsoI9i8EyJNg9iD62aFPyZFtKOHy/4+AUDgyro3Ovvtro4B5sa+aZRDNE/pWXnB4dfiMP0EOahyAZhTPWFX0WNpSw2LA7YV1dHL14g+xGLtCg2I6g6UjCBI4jheM0vIFCkBKl0IIs2YaI08cxKLtKYiKkTcBg9+DPD5eue1FPk+fAqDMCsr9PReCOSKHp1LoJRaG67wq+N39JG+a6zgFNPMRNGB0NTc18G+Z0r8nEu4GCm9EmQKc1B69RWl57PqFiDJBxcuu6hpqRDydR9VC27n4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed9hhAy82WMm99ok9osH4KbW8v7CCSU5hWZiIEMfCIE=;
 b=fnAz3yvPNCeMPdgDHQxy7dM6FkB/vBIddlyHXkbHKiONxtjxtvPZji09zZJgaJbGbdL3GlsQsXN5SUrj7KrXgTXoo8h4Vucv495Y2zohrxz/bz6kgmej0f8TqOOPcJhz+5vtzNoPlsLOWhdLJiYHWqkHP7D/DGhLeko/hSXyfV0=
Received: from SA9PR13CA0128.namprd13.prod.outlook.com (2603:10b6:806:27::13)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:28:49 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::c9) by SA9PR13CA0128.outlook.office365.com
 (2603:10b6:806:27::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16 via Frontend
 Transport; Tue, 11 Jun 2024 16:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:28:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:28:46 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:28:42 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v5 3/4] net: macb: Add ARP support to WOL
Date: Tue, 11 Jun 2024 21:58:26 +0530
Message-ID: <20240611162827.887162-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
References: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b1b4b1-fb49-4de1-071a-08dc8a3392bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|7416006|1800799016|921012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gnPy+ip7/Qvrtv3ICTK507k6BDMsBXkxp6fskusQcOU9nXA/57nbNrSw+YPl?=
 =?us-ascii?Q?pEr+B/lWBJjqrJm3DGcrLLwKtm3GeXuViCx8hhZhQ2uSQ/X4Cphi4Cu9bZCb?=
 =?us-ascii?Q?VAN3P7KbkanPC1HLtRAw/veRpLtnqkW7OgSl0Dx6MFi4nkZo/50PoazDLZno?=
 =?us-ascii?Q?iYj0gTtAkFkJs+AdcIQGeBXP68J1AwPmf5dZ/taQX8eJth+sNyIc3wx0Mv2D?=
 =?us-ascii?Q?rvLsJuWaCaaC1I3NAcSYgKyh/irkxFvhnpqHPgicw2xbPk74YBiUeFV2wkcg?=
 =?us-ascii?Q?XYFWBJNb0R8U8Hv8J/oRRLKST3YaX3TOPRdEjllSrlhB8mdqr6yd+m0BADrw?=
 =?us-ascii?Q?tuJ+/8FhGbJRGAqrKTIwdWerb9P7jCkT6f1FGSMYQFkZ2I6VZ/y7vFlV5tvJ?=
 =?us-ascii?Q?qZdnTRAlbt6pn2zZeZarDUh2UMplB3uwDRyodd4pjTnXmO7jnlf7EEQ3Zy1m?=
 =?us-ascii?Q?ZDizRLrwi8Tgwl/bOstSNPMEv6TW6CswDWM+jGiBp5H9moF4AljB392PU1Xf?=
 =?us-ascii?Q?/lh7Nb7m01b6AUnkrYSGfIRc0NsdF1y9GN9ELnfoOhigT1bl1YarrHsnVj8E?=
 =?us-ascii?Q?XnC6sXpfj+lbeuD6Gj+L/YoJOSHjEMqFnTp8mL/ka81vrPxnwUhA1In2Tsra?=
 =?us-ascii?Q?PBGSCANNpUctBW43xjTjihTu9v7tUXtZMf4zrzv93GiALQmBiPVqIdft+77p?=
 =?us-ascii?Q?ICZKgTAc3n+YQX4va5reHnzKqbtUDNBG1WdVsaiXCTpA8ibvfwklkcYw4w7i?=
 =?us-ascii?Q?HYUis9OYNgIS5izQHCarl42Fm7HGm6Kle2SgQbWvs0MUYq8I0JJR2xG2/GdH?=
 =?us-ascii?Q?+KAcatL4lwyNrNnY1A9sO//E0IIn6jMGtsQFKYLgMNKLtnXHYCkIYdKyvqFT?=
 =?us-ascii?Q?5dE9bJckZ/6wDTw+0xhsnG932ypLrOl/fRnncI1/8u34Um9WNFmG3iFYKe7S?=
 =?us-ascii?Q?jyptgTv1JC4Cne6ChGt0KCLQQxOKJ057zxCb4Eqsk3WcvXXEOYvlj8RiunDL?=
 =?us-ascii?Q?RQOEla3WQnbB9BFIQGMEpCPN7kYLj1aSPFlilBbJtM++gRb0oJFYybt8oHCL?=
 =?us-ascii?Q?otUc7uMavel1R82OcXyPiJvOFKyeJVKh3p1sbIsSG+gGqe6Pi1Ztun+UEG3x?=
 =?us-ascii?Q?oViYJj/Tg8Bi7AGZm+VkyuQ1IXIoev2ocnw0ARtK3EUYPOgWBb+45U2DO9ED?=
 =?us-ascii?Q?gsfMxw9SM051YoKA7Beqhc9Q9oPbfohMUrFqA1qNhDX35kOsuYq7Agn5Zbpb?=
 =?us-ascii?Q?SBK5qfIBRwFbbAnZUGIJZzqWQmNrfyQnaXJVocyMmDr3tMPlDvJryUmeNUqK?=
 =?us-ascii?Q?k8f0rEeSJOE6ZDSiUgXlrpxDaicE46p8heXMhkM3lz1xgGgzHWfh3oxgMCGS?=
 =?us-ascii?Q?Jfl5kKRLUYz4uZE/E00KUsfiTcRcxW16nZFh8t2Ow5GtQDjtbcyC7BJW/RDe?=
 =?us-ascii?Q?fF18DXN+1S4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(7416006)(1800799016)(921012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:28:48.7694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b1b4b1-fb49-4de1-071a-08dc8a3392bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

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
index 4007b291526f..69f4f8799a60 100644
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
+			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
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


