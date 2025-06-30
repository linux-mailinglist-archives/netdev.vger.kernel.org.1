Return-Path: <netdev+bounces-202647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D5AEE77A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB98617CC48
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2A2E7198;
	Mon, 30 Jun 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BgM92YfU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984301EBA0D
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311634; cv=fail; b=AB+IyrRwGHa2K9igeEwjWmjsBZrkxyJe2PjjiUD1oVl4JkR8lE+9RYzKkSJheCs/QU9RYkQQUqvqCEKcARAHZJOr+GxeFjEq31J8ZINgb8h6ncXXkEKmpaNx64SDK43ygnkKjuURM+RgNbVUfCwFNhuQIB2uw00LpLQNzqL1XOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311634; c=relaxed/simple;
	bh=DS2IatLFQHqzTU/gPlyxO3Lu3UYSRTKQymQrnDylPCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rxIp9oGCOLbFjzi9TW7jFwKsWw42h1P9nguownEM5JKCZVJL9s3ZSCJ8NeqabsQdECQIcp++/1fg7ErPuhRt/uACWNmbcFausZF0MVwOxBQUR61us3MHRxQy8xBNdcpNyYgLvn8dX1czfR+jAB/d1F3NmbGl2Pcsq+vhpE7P/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BgM92YfU; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlYxAC2pYye7xTUeo/4pOtGHbi7m54/WiqenTwL5S6f9uwv3OVZyIReLb1mWYtxJ3SkHmRVCiklAXPL9ySK6yvnoFZzQ/a66BpEC/srw5hfIRfBmEZZ5neU3bNiHpkmy6uajcXI7tkVDyocWggUv5+HowNRnmvFwV6lqD9pk/UVGB9UwBNQHuYSIW0x9DHdqi4Ddk+WpDDT0ekzmLI4mSITN+1woc0yYjZgZmaIEv4FTV57HlzC3Hf+pdgYHn4EvdLo0t9uUZRBWH/Y6LvU/OnaJ9akkCkR5LTM6Ul1SAoU8crc03CiUpsW7DIblEOOi/PoJiAbUHaEufCAPVFyTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRmN9hHyj+53YcXnm4B4okzR6VHKfc/brBCDzyC4Wrk=;
 b=wvBBxVfDqi49S37b+aQm77AtDcr6/0Q5pWnrBP0f8PZ437IlXJdOTztcLiz5Et6GTICZkEVxugx3f5JJZQSvM16zm8hr+7qkc666Gvk+t2HEAFTNhaHLOdxELV9k4RsyqpMqcymx9qHrLGAJac5p7/XMKdNNAFEraqZpyOUTpSkYt6sw3bcgytW0ENJUC3J3mqVSz9UBvjSgf1MN73LSSYc3qJ7A4RYBWGtZ3O0fyhDUWRks2d1rCg4AcBJc7QGQya/gW1+9zTLHY4la1FQXT6PzF9YMVSUcpI6k4jG8AxXjXF5LQaP8wdVvxt2wJeCk2daLy3N6PCBbkpBBvUPbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRmN9hHyj+53YcXnm4B4okzR6VHKfc/brBCDzyC4Wrk=;
 b=BgM92YfUPcNfrm/Urr/nS8Bk1sQGJqYcSoFx+uPDm8xPVMevdbGenCWwxpSRazumxO35tRe5tallFc4x3PynJwxLx+eqB3VYjN0B1Ln9QuCdUHVuN8v4CAbe7NBWLGBgf4HuwnPCQbUMY1AC3eLqVTsiedlUBf5jnZgK+TJNa10=
Received: from MN0P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::11)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 19:27:09 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::99) by MN0P222CA0004.outlook.office365.com
 (2603:10b6:208:531::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 19:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 19:27:08 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 14:27:05 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <thomas.lendacky@amd.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [net] amd-xgbe: align CL37 AN sequence as per databook
Date: Tue, 1 Jul 2025 00:56:36 +0530
Message-ID: <20250630192636.3838291-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 72debe82-8edd-4286-8873-08ddb80c1af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjWeJgI6fmBQGdSGoMZ5sDvejDFcU7NbsNh2dseQTy8ikgdKSVIk89zOgsQK?=
 =?us-ascii?Q?hpyQ7DOhR30saU+2nxebezHvFx59yDrm9/kzYpKg2Hh3riChqXS/dcJLBAeR?=
 =?us-ascii?Q?jSqEyJO1AWLPbxvHCdVJPtskVKUxqMAW2Mr6rOJXbCGzX7MkDarXDGFpMvLY?=
 =?us-ascii?Q?0AEEFR4HrKEs60hOjz97hfcDy5VFPwXZowC1mrD92CkycntLXi5ARyU/GQFH?=
 =?us-ascii?Q?Rj/0ObtCFzKnRsLTh4KWXaIfpmmozkBwq9hPPy+FW2IBYv1RZGe961oH4gsv?=
 =?us-ascii?Q?q4BZpzU/7YWBZoMJgzHEfdZKV89UkwqsBY6zG63gA7FPOlN6IvaY4rpzf9LP?=
 =?us-ascii?Q?Gm+Gh6jZp5nBokV5n0YEbUqSKTkpeY43QdsmW0FeOC4+CZO57cU8CewEaZ4L?=
 =?us-ascii?Q?xvX4mS8tc316anmjuaqnl3m3d22P7+o/E8rIjpKiJJ3trLq5FEQ47nz1uPmq?=
 =?us-ascii?Q?dOJS5FgXbiXorgqj4bZGPEqXyWjV8AvZMQ2SGzj9f7IXi5QBy/Hn684TTuBX?=
 =?us-ascii?Q?BIz4yj+up+6ChBFumXNLBcYVHBjQB4ZnoRen1uaz0fGzUgmqJxKeb0A8WnIQ?=
 =?us-ascii?Q?8t/K+zsJBdmiYBJk4CU/l6H0ukEeAn/guRabZUnWMphufuYSSfIdqDp3CdXT?=
 =?us-ascii?Q?RwKNznqsiYL0Fsd8DqwiFY83twhmwx6thM1YsE8fSjRL09mnTiVjn9wK6u/T?=
 =?us-ascii?Q?cE5iZN6B2qGjVedizMmQ7tNnUH/VbdI4XpmXUaa8qhE1MCoLbuKs4uM4bEYq?=
 =?us-ascii?Q?lU75nwGMwsOJwR5L8NqIyCDM1Zg2MD+2ThCU7zPuagRUjevzBUxXVjiFFbFy?=
 =?us-ascii?Q?2PFJg+XTJnbylbqKuVFlaK9MFRqB8wxmj5O546vJeVER0v8/+Tk4n4ru9Qtb?=
 =?us-ascii?Q?ZwhEO+5Co7BFj4Ki4DeZ3nhBdnVzfHuz2fKtGs1717r8lJV0HZ3ZUVQuyukD?=
 =?us-ascii?Q?2nbWmQ1Tyc4HeVNDKht3jPYEPmtXoSR0zOL+4ZDVlT5rFfgKF6TxmkLNM7JO?=
 =?us-ascii?Q?fXBB5b4eJuLw6pomD0duNP/Pa3eyIVDYQOvoV2Rp9OA8IvMURdY8PgNFqWoK?=
 =?us-ascii?Q?9G49r1JUyJEx9RnApHCX1ZKIkWYiCLgQmjP4WCZHD5zDkVlZOGvt6WebTkBS?=
 =?us-ascii?Q?xWpjK96CQIn6Jumb+VX3hiK+tyCK0W4Bd/log90+R6j36joHeX+EeJE/ZWBO?=
 =?us-ascii?Q?GDooJSB7npvsEx+7+API70FhL/Jk6L1djHzs+WVbV1f0trQZWwo6zQrkhLKo?=
 =?us-ascii?Q?Tv02/JGCfM7KIl77P7FgjriIhoLp3xkgjdjVWm8yXgwV8MJ1x6eqpPYWwtaO?=
 =?us-ascii?Q?n8ngaLb3h/Gutpbt73beRU0XJzOeL7SLGIteuAqAAP6UJtAYmwwTPIEHtV57?=
 =?us-ascii?Q?cXve90zI/K0dk416VGSzS3vnEkI5lAYqq6X8AGrxvRBWBcl3Zu/iM7z00C6T?=
 =?us-ascii?Q?4QiIPwMemJpVvhkQV1U2fYoVIeC94xM9mcjvOHGo0KCyLmlc1XSjnRQph5nr?=
 =?us-ascii?Q?D8Rw+Io9RngoxPOILvVedhoGXmRwmcb7NLdy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 19:27:08.7530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72debe82-8edd-4286-8873-08ddb80c1af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

Update the Clause 37 Auto-Negotiation implementation to properly align
with the PCS hardware specifications:
- Fix incorrect bit settings in Link Status and Link Duplex fields
- Implement missing sequence steps 2 and 7

These changes ensure CL37 auto-negotiation protocol follows the exact
sequence patterns as specified in the hardware databook.

Fixes: 1bf40ada6290 ("amd-xgbe: Add support for clause 37 auto-negotiation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 2 ++
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c   | 9 +++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index e1296cbf4ff3..9316de4126cf 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -1269,6 +1269,8 @@
 #define MDIO_VEND2_CTRL1_SS13		BIT(13)
 #endif
 
+#define XGBE_VEND2_MAC_AUTO_SW		BIT(9)
+
 /* MDIO mask values */
 #define XGBE_AN_CL73_INT_CMPLT		BIT(0)
 #define XGBE_AN_CL73_INC_LINK		BIT(1)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 71449edbb76d..fb5b7eceb73f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -266,6 +266,10 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
 		reg |= MDIO_VEND2_CTRL1_AN_RESTART;
 
 	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
+
+	reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
+	reg |= XGBE_VEND2_MAC_AUTO_SW;
+	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
 }
 
 static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
@@ -894,6 +898,11 @@ static void xgbe_an37_init(struct xgbe_prv_data *pdata)
 
 	netif_dbg(pdata, link, pdata->netdev, "CL37 AN (%s) initialized\n",
 		  (pdata->an_mode == XGBE_AN_MODE_CL37) ? "BaseX" : "SGMII");
+
+	reg = XMDIO_READ(pdata, MDIO_MMD_AN, MDIO_CTRL1);
+	reg &= ~MDIO_AN_CTRL1_ENABLE;
+	XMDIO_WRITE(pdata, MDIO_MMD_AN, MDIO_CTRL1, reg);
+
 }
 
 static void xgbe_an73_init(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 6359bb87dc13..057379cd43ba 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -183,12 +183,12 @@
 #define XGBE_LINK_TIMEOUT		5
 #define XGBE_KR_TRAINING_WAIT_ITER	50
 
-#define XGBE_SGMII_AN_LINK_STATUS	BIT(1)
+#define XGBE_SGMII_AN_LINK_DUPLEX	BIT(1)
 #define XGBE_SGMII_AN_LINK_SPEED	(BIT(2) | BIT(3))
 #define XGBE_SGMII_AN_LINK_SPEED_10	0x00
 #define XGBE_SGMII_AN_LINK_SPEED_100	0x04
 #define XGBE_SGMII_AN_LINK_SPEED_1000	0x08
-#define XGBE_SGMII_AN_LINK_DUPLEX	BIT(4)
+#define XGBE_SGMII_AN_LINK_STATUS	BIT(4)
 
 /* ECC correctable error notification window (seconds) */
 #define XGBE_ECC_LIMIT			60
-- 
2.34.1


