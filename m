Return-Path: <netdev+bounces-202525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F324AEE208
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CC6189AAA6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A467E28C005;
	Mon, 30 Jun 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="45K+C3/2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB2289E00
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296214; cv=fail; b=nEv0GM7avkVmBonQIP9vODHCiKQVdOcTW4/4JMlRscEhQq+hLht+gnAGpRUQ8g/0BNvnSQB2mJJW5Qorp9C8UhdiAAaSW8XQtWcyYW5P8kJihkFQrFm7KjjMvXIH3l71yYolXcgsSjT5JA1M44gw5KzZLfQhxtql/mxqZ1PLUi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296214; c=relaxed/simple;
	bh=qvqrF28WaF3N7DBVfd1NHsbuPvt4RFkGjyMiX2rievo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QwcK7QtR8iZSBZL4Ak2fOmQa49afOG7xreIHOQCB47Qpj4Hq9Bxy2qWEmiSfU7htSeYrRNLSmVWe4Rnk5h9cY1woTpGu0A/kLcqWfXNMgOFXgZSzp8IYlIrqkyXwwZ72RAieo1VBQ/EGpzC5dlbN818Dmldy9VMfMpcArTflFx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=45K+C3/2; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixB3ppWWEGNpvTfcWxX/OXVdtqSlhczD3lvHZzhhFJIxO0P4Ul+7cNakCRXhrHWjs5eL4Po0Rl575Vkr2ML74KkVoZwk/5Q3Z4t4m9ERKzzQ3E9CTjZwEk4/CcU9h1bXJT5UZWfrV416W7Fx5ZGop8E+K7SmlWl9hQxzfI3NR5FHbKQNwysTZmF7DK6k5JrREa5+BvVbUmERjJcvkeJOebbIjJ2meW7poAZyQG1YPDv7iStYjMuM3LLZP7m5nbkgsU5r6L5kp9WFsKOumZCMHXuH8NoaN8eTSj3v0ofzcbfiA5wmAZT83dmjE8KlDcp9koRZbgOWnLJYCWV99W88bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfajLmPuPSL6+CUvAY9JD5J4+PrwFSjiXFkXdYoEGpU=;
 b=AAyIYb1j9u0uJbW361rBDpX6n1puhjb4mzK4+bemRDaRbwqxh1ZAk65SIqZ5Swa1e/1UvCW+Ld5YXBFvTwHoyBVPcjjYSwx7b9GBQwdxiBO5wu/TjeykINNvYaRrnDx8EtEPWPiP5XOLQPXPjvWWwydqe8x5PdFvC+E4N+Ehs9qd9VKOLlrhfXzAMOsGZNEL4hyL2OG0SvV0O4ZDnRACG6xYTPlMIYoIBSUam7KACnoPygps+Umrxx7LlvRMitKOVgFSf9ix58E+NIZQRS9dLOM2+K6thFlmomUcGuNyM+7a0KYSCtcxECSel1rUqnGA+ZMK0/31AW92b6Vu2uqXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfajLmPuPSL6+CUvAY9JD5J4+PrwFSjiXFkXdYoEGpU=;
 b=45K+C3/2chlSy/yYeA18aBMbDm2iWOVoyWztEfx9Xg9oXNuYxPPSOC2+E2eW8BXhAfG+p/gJsjgqNBdqY12pp6CIgWUMSC7VMsT7xJJ5pLfZvaQGVdCilxgLNna1mSZ4h0Ypfqe0RrCv0xoLXIszmnDDJTRs5VMFpYlQo2Z2xtg=
Received: from PH8P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::20)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 15:10:08 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::1b) by PH8P223CA0010.outlook.office365.com
 (2603:10b6:510:2db::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Mon,
 30 Jun 2025 15:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 15:10:07 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 10:10:03 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [net-next] amd-xgbe: add support for giant packet size
Date: Mon, 30 Jun 2025 20:39:40 +0530
Message-ID: <20250630150940.2099618-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: a7260e35-db89-4f5b-de3b-08ddb7e83326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xa1S+N5F4T5bWAHLfeteT0PnOLAXL9Uh1ZoZAbLBWcd3QH6Be4/v21FyvtCw?=
 =?us-ascii?Q?7DsE1/uU3KxV2DTZeVnTqpeb4wm0J8iIaL2OY+5NhVr5FnQMSYBwGd0MvL3t?=
 =?us-ascii?Q?sjzRatdJEyIfq8fvaSfEvNRmQXxDtSL70yT+In0+zmFjEJK9tRx6Htp/U39b?=
 =?us-ascii?Q?lMolTIjmYlPwMZHDJveCydHo1Cnywhecg2S8Bpy/7L9zUEZ9rGoT+05jT1nj?=
 =?us-ascii?Q?Gw6NlFFVXNYEkPmOzYKDXARmUT0qnX1lCm0wYcElcZF27rpXA2L9bK83l9Ai?=
 =?us-ascii?Q?Zya2yr33a/Yi224F4JYym2PTRiobHth+oaSq9ImXZ4jGi959STD8hKI1uCkm?=
 =?us-ascii?Q?GSmPLClYLUgt0eDLTCiVnUugsa36AoeESzs+5llw6kROFaVKyCpAeSwtRWAZ?=
 =?us-ascii?Q?E3vFKXjznzUUgydhq57EpbpiNTlBO8eu6Dkw3vMzZeZoKmQHga/4uWzxMapk?=
 =?us-ascii?Q?St/zluUnnbXR9NBRyDJwYqcojWUVJS6W7jKfmmTtCAaiu8GeozHHtL0OCEei?=
 =?us-ascii?Q?tkBouows3h04VvMK5URV25Q4S3jDCqvpGAk5eZLgiYSsiq8O3vjnBqWC3Mdd?=
 =?us-ascii?Q?StmdpWqQMPOemQfUf18JJHHY4fIHZqzsJlP36NqTKkakxYN3AcSIatpuQNoF?=
 =?us-ascii?Q?3Fzhl2BMlIcuYKom/YllM3cXaG6JOOi/SDhftmEzEjCwWUG1IYRNV7ZPfJb/?=
 =?us-ascii?Q?yIQwvlA9Mg9iawZ/rWqC0OB8pdewyP3OjpGjidDaVa9Mk1VTBNKHM2n55gfV?=
 =?us-ascii?Q?FRlPHa/TugXiuslbVP0uFKpN7yjeWzaC7yfmo9wpgXdHPnjFrV3MtmIoUiSp?=
 =?us-ascii?Q?GMEgjxQb+99RkE0tRA3NVP5LQb5Yy7+Jm5G/J1BKLL7fGBds3FPyBeUe4kBE?=
 =?us-ascii?Q?0SKrEj+kHRYxyksUvz87qend1m6BMHD5ZqLDjt1w/VajPMnJh80gmZBWhT3U?=
 =?us-ascii?Q?oW/JkAwJcEVnYFm90At6AYO+h1xpF+4jz71F+RcK8ORauPurp/LQbo70cZG8?=
 =?us-ascii?Q?auJkr2mSuc1kufd9N6rqBB1KCIZUQ6Yxg29YuW2SFMrprW7jjE32g58ZOKkp?=
 =?us-ascii?Q?NGWZX4KHUJbTzaqBQyVEO9X5x2g1jYvJHedJ51BxDZASS18hA6EhAL7nrC/s?=
 =?us-ascii?Q?DJfjywENy/FfUeiS8sW3+dihCY+qD9G7moPal3YA2Vw/PLCMe3KLMo+sIGKA?=
 =?us-ascii?Q?/MMlI94Wv9JfnNix2dIo4/d1nncl5GCWF5YRSXjmCuhnN35YCiDb+oMKbEkA?=
 =?us-ascii?Q?Ctyuzn9C1de5drI7QfgHFo8BVwAmqseuWQyJwHtyrkVRdR3OzG98Hc5P7Pjs?=
 =?us-ascii?Q?Jz+GvhJ5wjJa0jhnekg+3OzO9b5ryjkc5YO4wVg2s/gGGPmFer+7iWGw4UyH?=
 =?us-ascii?Q?8koRIDjUebRcb3TXdLwrHFQ6tewEEj1RYkSh5KUXLrw1hotrNVh2usimu++r?=
 =?us-ascii?Q?R57aN3N9VAS5OI4fkTbPJvty6ntY25VD9KArs4xTXk4lVge2LR6ryqa+MHBl?=
 =?us-ascii?Q?HWAeSTHQelfURFwvsmOBc2xVCsn/vFixPfQ4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:10:07.4308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7260e35-db89-4f5b-de3b-08ddb7e83326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283

XGMAC IP supports Giant packets up to 16K bytes. Add necessary
changes to enable the giant packet support.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  8 ++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 16 +++++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-main.c   |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index e1296cbf4ff3..734f44660620 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -364,6 +364,10 @@
 #define MAC_RCR_CST_WIDTH		1
 #define MAC_RCR_DCRCC_INDEX		3
 #define MAC_RCR_DCRCC_WIDTH		1
+#define MAC_RCR_GPSLCE_INDEX		6
+#define MAC_RCR_GPSLCE_WIDTH		1
+#define MAC_RCR_WD_INDEX		7
+#define MAC_RCR_WD_WIDTH		1
 #define MAC_RCR_HDSMS_INDEX		12
 #define MAC_RCR_HDSMS_WIDTH		3
 #define MAC_RCR_IPC_INDEX		9
@@ -374,6 +378,8 @@
 #define MAC_RCR_LM_WIDTH		1
 #define MAC_RCR_RE_INDEX		0
 #define MAC_RCR_RE_WIDTH		1
+#define MAC_RCR_GPSL_INDEX		16
+#define MAC_RCR_GPSL_WIDTH		14
 #define MAC_RFCR_PFCE_INDEX		8
 #define MAC_RFCR_PFCE_WIDTH		1
 #define MAC_RFCR_RFE_INDEX		0
@@ -412,6 +418,8 @@
 #define MAC_TCR_VNE_WIDTH		1
 #define MAC_TCR_VNM_INDEX		25
 #define MAC_TCR_VNM_WIDTH		1
+#define MAC_TCR_JD_INDEX		16
+#define MAC_TCR_JD_WIDTH		1
 #define MAC_TIR_TNID_INDEX		0
 #define MAC_TIR_TNID_WIDTH		16
 #define MAC_TSCR_AV8021ASMEN_INDEX	28
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 466b5f6e5578..4212aca49e6f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -2850,9 +2850,19 @@ static void xgbe_config_jumbo_enable(struct xgbe_prv_data *pdata)
 {
 	unsigned int val;
 
-	val = (pdata->netdev->mtu > XGMAC_STD_PACKET_MTU) ? 1 : 0;
-
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, JE, val);
+	if (pdata->netdev->mtu > XGMAC_JUMBO_PACKET_MTU) {
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, GPSL,
+				   XGMAC_GIANT_PACKET_LEN);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, WD, 1);
+		XGMAC_IOWRITE_BITS(pdata, MAC_TCR, JD, 1);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, GPSLCE, 1);
+	} else {
+		val = pdata->netdev->mtu > XGMAC_STD_PACKET_MTU ? 1 : 0;
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, GPSLCE, 0);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, WD, 0);
+		XGMAC_IOWRITE_BITS(pdata, MAC_TCR, JD, 0);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, JE, val);
+	}
 }
 
 static void xgbe_config_mac_speed(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index 4ebdd123c435..b50cc2094778 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -275,7 +275,7 @@ int xgbe_config_netdev(struct xgbe_prv_data *pdata)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->min_mtu = 0;
-	netdev->max_mtu = XGMAC_JUMBO_PACKET_MTU;
+	netdev->max_mtu = XGMAC_GIANT_PACKET_LEN - XGBE_ETH_FRAME_HDR;
 
 	/* Use default watchdog timeout */
 	netdev->watchdog_timeo = 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 3e90631d0a4f..914c40421ab0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -80,11 +80,13 @@
 #define XGBE_IRQ_MODE_EDGE	0
 #define XGBE_IRQ_MODE_LEVEL	1
 
+#define XGBE_ETH_FRAME_HDR	(ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN)
 #define XGMAC_MIN_PACKET	60
 #define XGMAC_STD_PACKET_MTU	1500
 #define XGMAC_MAX_STD_PACKET	1518
 #define XGMAC_JUMBO_PACKET_MTU	9000
 #define XGMAC_MAX_JUMBO_PACKET	9018
+#define XGMAC_GIANT_PACKET_LEN	16368
 #define XGMAC_ETH_PREAMBLE	(12 + 8)	/* Inter-frame gap + preamble */
 
 #define XGMAC_PFC_DATA_LEN	46
-- 
2.34.1


