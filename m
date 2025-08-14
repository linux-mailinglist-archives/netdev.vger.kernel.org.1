Return-Path: <netdev+bounces-213604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79EB25CD8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB23B1C27E78
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B126B2A5;
	Thu, 14 Aug 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k8lPlr42"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7126A087;
	Thu, 14 Aug 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155482; cv=fail; b=jVOhkL9m29nFH5gB4vVEFdHAwNYGmnjjTg9CAff2sYq/li2UeYq+gwdvzGzuK3uz6gQimeXRpyP1/zhd5muJE2pfSp6bbr1gmEll5wHDF38ome9pIeyl4h+oI1WBJaD6aVHnNR1+3O5dxWzK/efMr79+TmA+qHmvQqEaL0obGWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155482; c=relaxed/simple;
	bh=gJVtK6yW698mrOj8uf5kjHU9Hys/nxfSDI4CLDT2zOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZkk80a81wOggy9IrOgyIyQXOB5c0v+W0RymH8E2HirNhbHdDfcdffQnVGUa2sWuiVcVj6dYd+X5LJkE2guPoQe7zf35URUHpeNAMsPea9QF2k0Lr1NQmi+u4TvOukx83nkZmNkcSMI+ksn1Lt+O+Dq47BMsqyMd6qzxsoO5ehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k8lPlr42; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfORffQHK4WGXJki6osOSvd6EHgt8kKtmOXmNn2Gv638Lsceds7RZsSKfVLF/ACtgz83AjSY7O20bwAsUxVAx6pm4Sc4do3p9KTr6YmXbL0/jraRbAh8LXf+CvMv0hbMi9y8aBk0A9RycwDVds0oJ+MrjYYtxHPi7E4Ch07bjTyN+pR68CjL7jAX3ibvLSCP8OcciiKabp8if0WV/aCO1TLNLqQimGC8P+5UQzVRj+arMXmnLRVjEfneGrBsK/jUJUAJ2sv+740lwqMq9HVpdBrtIAS1Lj1OP3dWytpzxWCOeC5RHYB/vzXiQNi3JvurrQFD+dj6rBusCmcq7Mdy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quw4FNts2E9Y2iQkpz9IbOQmvKHlh2/AnZWXOUzh7SI=;
 b=tzOzoQeFPFo3WuLCLUUH+klXdLVFEHzvA5gebPN/YTYzUry9fpVXXHBxRYNiw9nyqHAyZjAaqJ9iCm10jWGhisc5QTrfbdL2I22RWw0C3zsV/33WIjYCj5NdG4CwqywpBfaQHro0biWBpmalVgSNxIiegfV/wKjviPswA2sFsjoS9u1VEH5jkCIl9V2l29J8tqONszdvRgHawajQvkdC4zvLwhXxKR3t3m0KEoEmI5N1DQzWiDfYFEJo0k/d2ewLDqvtxtcyA+nislDI0dfHJkhf8cu/9fy5po5HrBtK9IW0rVBtTPpyHr+UAHHNlwkf2/G7mfXuoPfIv1k1u24oEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quw4FNts2E9Y2iQkpz9IbOQmvKHlh2/AnZWXOUzh7SI=;
 b=k8lPlr42OGA9w8bfpdPxRnb51AKfYTfFPiWavDpACJHmv7B07iPO1RcpT5xNoCFg/VDd21pJaI1H7QVe2e7Q2QvHvo8Oyi/P44t3sgTi9Qo0ei8TNBsOFeyON2qXptPWeYaLjkIaq7Q2MpPkXBCK/XJSp6dSY+IR185VT8MarXs=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 07:11:16 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::ab) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 07:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.0 via Frontend Transport; Thu, 14 Aug 2025 07:11:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 02:11:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 02:11:13 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 02:11:10 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 2/2] net: macb: Add capability-based QBV detection and Versal support
Date: Thu, 14 Aug 2025 12:40:58 +0530
Message-ID: <20250814071058.3062453-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814071058.3062453-1-vineeth.karumanchi@amd.com>
References: <20250814071058.3062453-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: f36b04e8-a12b-43f5-7111-08dddb01c278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nREw5j2kKXhAG2XA8sn50xtmqkdlIaTGtdi/i1Cl/C0UgDU4cGSsOCrwEVjy?=
 =?us-ascii?Q?tewhv58jCbyARd+xuEvCkOB6cFvswzJOg60sq+L3CjNDjLvzHY4Fp5EPEPuM?=
 =?us-ascii?Q?Qff3zAM9Pn1x5a38jZX9YxOLRBZTpA2PMBP7KLQ0OaSGMPoqMycrcMekjhZN?=
 =?us-ascii?Q?mpjpgenl/k7od9Mtf4/xwKGSqBFDmAJ6W7f3rbjRFrD7oYLg0BLYmUSv3VUU?=
 =?us-ascii?Q?VS0O6Gb2cJn5H+lNB3VMpmCJbNo4wJfdFccuXlDfViUfqoiKFhMfTPiSRzhL?=
 =?us-ascii?Q?egjRPXpT8WiGhX/r3wJ4QMEo8QqBKddsTBXwiwcDYeTskhGMMK/K4vpxcXwy?=
 =?us-ascii?Q?i4km9+USDvazdvEVikmPdeVvYHd6NSRNBvXy3S9wfsBfnoOKvpiXURjg+H7h?=
 =?us-ascii?Q?o+hoOrJ5JwquCXKfgyEkczFVINNbcYXbq/S3kpHvY1sSRV8dcHFGQtN3Q5dZ?=
 =?us-ascii?Q?LUiGKXfpmFvxnYeKJDppLYRVFSFkzLK2R6BL47RDtOfawEZr0WKh+yFmliWm?=
 =?us-ascii?Q?7EBFFTZYRZ8lzqNvygS270+U6XwUZtIJC5BIkfy2ezSIOi59dAw/L/3U9J4e?=
 =?us-ascii?Q?o+qmNPlS/oJjLRg4xGnx1QVX8N9vDixutpZ/v9PkkHfTUhBTnPRTcI8u0y5R?=
 =?us-ascii?Q?dGA/JchTY3vb9m7vZPWDX27uO8Ysmi9b7EaJNABV8cdoIP4k8xNHLo6fIBY/?=
 =?us-ascii?Q?LjZBQfF4EwXqLoXO4cA9z9pZRO0HhM9Dd7zkBDzRcO9YW6CCOSZRlCHrat5x?=
 =?us-ascii?Q?CulKKv4X3cAkceQ0T7lm9udG+7Rnz9tN9pMfDo579l/MH/t0e0V9uhZORqSr?=
 =?us-ascii?Q?FkwKq0n3DkHY9E78KAjVhxsZIy5RBeWQ5ZuHQ5vt+09FVSEXaDbWuyQoLt13?=
 =?us-ascii?Q?R41MvH0Qazj0udwYGex86o3HAyYeblYS5Hm9+pM9fndlJ7fg2At8DzhEZ82y?=
 =?us-ascii?Q?31K6AsxyZ+Cb4N+4eUSVpuxHnHMMQxtIOeU/HkIHF/Vc8Llp7MOM965I7328?=
 =?us-ascii?Q?zseytFprKXwJ9KWqpa5eOTgzLDtua/sgjlXt5LOeLontxLm5eI1UwLJfyb9Q?=
 =?us-ascii?Q?5KFwr7vWpi4gLDLaugkLTk1E1fFAqJNGmvqLxnlQy/DdWhSW/NOxrXDNsHuh?=
 =?us-ascii?Q?iuUysFIMKWya36LeyvPceibotix4JUURr5k2Aa7AcfnfRfECw3bf3ZjLm9q3?=
 =?us-ascii?Q?MzAuaaem6TGXy1Iy7P2A1UuCqMVCpJeATE1HEmUjLpf3U1NRdS7uYquuU+T/?=
 =?us-ascii?Q?TqmNwjxzA3dwLwWJXfajb57Cr/xE3ZcRCD2ldj9U4tkqcqvJ8ueFPkbQ2NsQ?=
 =?us-ascii?Q?PvgHedN7t6pz8crn4LDgGu5ajkGEEpsssTaUi3Ntb5iZ4Ng+hGXMPHpmjomj?=
 =?us-ascii?Q?yNOqVRTfZ2sZDjTeS1owG3htZP+GEco2GRDBxRXuyHGuuecKZkm7SFS68dsL?=
 =?us-ascii?Q?F+PQtqF7uo5eP+BH8kZXxAGdMAU2P88xIidj2HbM4thBgtIV5MJJQHjURWB4?=
 =?us-ascii?Q?q/cj7t3zuOmIgzgXysnew6Yd76hArXkbFmE+6H5zvgyrNcVsDHVQKgpagw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 07:11:15.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36b04e8-a12b-43f5-7111-08dddb01c278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

The 'exclude_qbv' bit in the designcfg_debug1 register varies across
MACB/GEM IP revisions, making direct probing unreliable for detecting
QBV support. This patch introduces a capability-based approach for
consistent QBV feature identification across the IP family.

Platform support updates:
- Establish foundation for QBV detection in TAPRIO implementation
- Enable MACB_CAPS_QBV for Xilinx Versal platform configuration
- Fix capability line wrapping, ensuring code stays within 80 columns

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
v2:
  - Fixed CAPS syntax and resolved related clang error
  - Wrapped capability lines to stay within 80-column limit
v1: https://lore.kernel.org/netdev/20250722154111.1871292-1-vineeth.karumanchi@amd.com/
---
 drivers/net/ethernet/cadence/macb.h      | 1 +
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d1a98b45c92c..904954610611 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -770,6 +770,7 @@
 #define MACB_CAPS_MIIONRGMII			0x00000200
 #define MACB_CAPS_NEED_TSUCLK			0x00000400
 #define MACB_CAPS_QUEUE_DISABLE			0x00000800
+#define MACB_CAPS_QBV				0x00001000
 #define MACB_CAPS_PCS				0x01000000
 #define MACB_CAPS_HIGH_SPEED			0x02000000
 #define MACB_CAPS_CLK_HW_CHG			0x04000000
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d4b9737f83eb..f948da429107 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4602,6 +4602,10 @@ static int macb_init(struct platform_device *pdev)
 		dev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
 		dev->hw_features &= ~NETIF_F_SG;
+	/* Enable HW_TC if hardware supports QBV */
+	if (bp->caps & MACB_CAPS_QBV)
+		dev->hw_features |= NETIF_F_HW_TC;
+
 	dev->features = dev->hw_features;
 
 	/* Check RX Flow Filters support.
@@ -5345,8 +5349,9 @@ static const struct macb_config sama7g5_emac_config = {
 
 static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK |
-		MACB_CAPS_QUEUE_DISABLE,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
+		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
+		MACB_CAPS_QBV,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-- 
2.34.1


