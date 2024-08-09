Return-Path: <netdev+bounces-117099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7394CA72
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F572855E6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85EB16D315;
	Fri,  9 Aug 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfzxFIVV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6416C6B0;
	Fri,  9 Aug 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184789; cv=fail; b=dZFFzLlHvIDcgNWYPVcO65J+I2D5sDcfwMWnxooa5dhoVZpRzM12iB2LlArzBeev6C4niFSz7WGm1Mc3Qn3aJnulICyx2Jmql/CdzH6VL7ELe9gjkbxOmPbEkFQKQjsegcQqp2+EZmVmJJQfXFITFXipFSwaCfIo/c2N5C6lR5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184789; c=relaxed/simple;
	bh=5HCwmmoF/6FZE3DIk2NEZA+WHisVQCFYpMFhEPF8VSo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzqOO/EreNKXIhODI7fn1kuGX1CYRO32LWqI4BXnucn+xC61dpcOPyqiQU3a/b4laV6Dbq1cBqsDIuNJUUHPFXafATgtizr2i8s0uQdcqxdbp7Kle3KHOSZUZuOA15jCsWpJuQJYy2X44I0lE3cW7n0TrXY0nknjKcXdfauwGxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfzxFIVV; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLKpKOwhJGWVAAAQdNJStGcTqRKrpX2ZgGEGk02ZFtOi9RSHeq/EmYBrPnPGd5IAo1+8K6pxOMMcbxrE1QibjsGcXlOWXRgx4umYsJT7ZMGhUfezv+Gq32Z3q4f3bOjQeWfJeCCZsePje1peqrD9VPDGbYEz7DOiYHiXRzSoWL2cX9K3tiOFVivs8C5pnU4aTGyxQM5MZZ8QZ1iY/sIiv6fTaYoXtFO0OSv02ZwlCTpBoNa07gUwfeC0iNn1AevKEsWmwpjSEv4mBYG7KQ6N24JKxbFBJIy+14Irl5aQjUkv21FW3lCF16xAHLiNpeO7Y8nR85A9q3mDVIDn0qHByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3seCZOmsBsnMRZIa5IoEFNyL+1tY5y5KKM1Hn3mlT+o=;
 b=cGk58wsxViBwPHsKP0zQTlmw8fmuECv7PZdTdETBYwN4FvPLd3BSOx6FVFvpz01vs+f50wQHxr+jmMg0vOj9DAnqou7OIUM9uCi3SD2fxdbx9LSRmMpSJbxZDDZ1QL/SVroqI3BSYkkUUQ4KYCsLB0+AzA1uXDrqtIOrj0eE+JOmiRDBGsaYfWVgyAYS64JJE+tSbXGoWIonBjZvDifCK6IhbWi2w07my00MFrkl7Qms92zaTPTkjPP1SH0xEVvqv5HFEHvmeA4aUrfg5TfHysH4h8b/y+bbDkYzfQlcm/9FMwUf67nwJcSPTuKMwFHNk9dhsIEqpxeThs3NMc2f9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3seCZOmsBsnMRZIa5IoEFNyL+1tY5y5KKM1Hn3mlT+o=;
 b=UfzxFIVV11DuaBCsl1hLREBxfZe69Ejr0Wq59bPmHpIkitSMxvG1VZMnOqHr/BnRFNnf9mGYarmhkTb1LTL1XmNqduE0Gmhe8x2HfGtDZC5q6Yhpo5noE8WTPGqla1BOiuyrYYiNrZhy5PNFrL0DziW76TcYRSGJQ2l5219aAgw=
Received: from BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) by
 IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 06:26:24 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::2a) by BL0PR01CA0024.outlook.office365.com
 (2603:10b6:208:71::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17 via Frontend
 Transport; Fri, 9 Aug 2024 06:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 06:26:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:26:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:26:22 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 9 Aug 2024 01:26:16 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <ariane.keller@tik.ee.ethz.ch>,
	<daniel@iogearbox.net>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net v2] net: axienet: Fix register defines comment description
Date: Fri, 9 Aug 2024 11:56:09 +0530
Message-ID: <1723184769-3558498-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6ec2be-27d8-4b83-a8fa-08dcb83c30fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1Lf1K/jSG/hQPUPQdL9YNvVPfMHoH3zF8tCeJB5zRot6yqHmjIvdif7BCQC?=
 =?us-ascii?Q?7b8dBFN6T2q4ZLa1VPMlNzqclyrHpy69Vn14lLi2x3W1FaN8s7uISKE2aWrt?=
 =?us-ascii?Q?FqZpws/MoKFsqELSt79bN/k928Bwces7JTWursZ22INEsljHPivEXLKKUUcY?=
 =?us-ascii?Q?QUWvlzwqazhrYGCTizmBO/aUDxVHkkPytV715S16x9pyJNP/Q/6EXiarR+0w?=
 =?us-ascii?Q?QXG4lrhqR6WwbHqFJNF31V1hGmwm+u9iZIrDypbF+VyoZh6lZgnI0jO0qLsX?=
 =?us-ascii?Q?9RBolsPu2T2eKAzSjZUo2yG3HJrZ4AL2nBdn3qlMsR1arAPDVCmCSdJo0hWg?=
 =?us-ascii?Q?YSWK5UxBQvxTK+yw0hrYymqtFMPeaHJIWRn0Ao8tdifNio2NzorXJfqr5VBf?=
 =?us-ascii?Q?OZfw7DJ0zhz606PyE4aWgFs5FVuQnsgHSiH0XwGdFDvPSYMf911D0rCMNmMX?=
 =?us-ascii?Q?sj+mLHHgo74OHMMGMuioitp1rXSQqg31I+smvQ3TEzftqJSDrJbKEJrXen17?=
 =?us-ascii?Q?lUCj/6h7lPD8hax4aF7E/C+8BE9C253pwmdzFG0T3pV6MVa/3y7tyKIeCHb4?=
 =?us-ascii?Q?mTvWJimZ/JGEKwKx/OUboIt8rTJpMd0KfIm7jYv/Wt/nguPmrMNYW0P8gOMa?=
 =?us-ascii?Q?hs1auHd+BPuy0ZN855wJJOAlxcWX2IvoN9aouRIshGNkOzTuqTxHPcBxlmKO?=
 =?us-ascii?Q?ykdFYq+3A8O9RbO4BjWqrJ8xkwI9FTUOXDDLuWnVYB+pu44aP2pYgqnysG/W?=
 =?us-ascii?Q?L2AixVyyun+GJQRQyVZj734/AHNsMmVDFq4gUBomwlpHWqiVlvkadAjXcTet?=
 =?us-ascii?Q?V6aWmK+kzt6/RkiWZcHV2LcYtN4NUq3L3qa8nZuS+f6SFxl6DD611sWuZ82Z?=
 =?us-ascii?Q?Hwj6HxAmelrPLyJAyBsRIwmkOJo9b6whkgOgCNqzk2CGkDXh0NRwdRONqrlC?=
 =?us-ascii?Q?3w6qDEK////pQKJnKsfcnR392Wxq4gPHxQcbXkefYJoO4/u2i1hCeyjHJaWt?=
 =?us-ascii?Q?dzhycWcpDFJprNzDppBFanGTBarP63rTm1+CtQa4FlMmB8frGwXKWdXaTmRD?=
 =?us-ascii?Q?J6DmAVPkkfZksYjPY33DMzq49v0SzHub4i1hI+GSkynpZHNl0AMyKBLv46Di?=
 =?us-ascii?Q?BAEfi1PB7ekPaJ+NHtHqTkCs59/QvJDtcUmZJiJ1LOQvDhx/CI/08q1jKykP?=
 =?us-ascii?Q?gQMWKrmb/PxIzeTn4h7MrNDYJqF4VZssQcw2J8G9CgSuzEg3ECtfWdN1hRVF?=
 =?us-ascii?Q?v8J2jOvMZBxlh207Brag23T5oZ7SJRwEyLZkbIyIFqjJbXpwOcRn+Ycx4PU5?=
 =?us-ascii?Q?PYfTqFthZGg/MJQwo89nw9LDg6EfX6Xd9Bc6lQWfp9zxX9hFrxfT+mWEsmvR?=
 =?us-ascii?Q?hIitKmbAFqUVNuyS82kkXdyf4JtltWi56K/lUicAFgaqufTCUEtHZ1K4EQWg?=
 =?us-ascii?Q?toK5dI0Ttjl8jAPrZlpkuvlvv6oqjZFP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:26:23.8112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6ec2be-27d8-4b83-a8fa-08dcb83c30fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

In axiethernet header fix register defines comment description to be
inline with IP documentation. It updates MAC configuration register,
MDIO configuration register and frame filter control description.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
- As suggested by Andrew renaming defines make it harder to
  backport fixes so drop define renaming.
- Drop removal of ununsed bit masks for PHYC register and
  MDIO interface MIS, MIP, MIE, MIC registers as there are
  other unused defines as well and may be used in future.
- Add fixes tag.
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fa5500decc96..c7d9221fafdc 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -160,16 +160,16 @@
 #define XAE_RCW1_OFFSET		0x00000404 /* Rx Configuration Word 1 */
 #define XAE_TC_OFFSET		0x00000408 /* Tx Configuration */
 #define XAE_FCC_OFFSET		0x0000040C /* Flow Control Configuration */
-#define XAE_EMMC_OFFSET		0x00000410 /* EMAC mode configuration */
-#define XAE_PHYC_OFFSET		0x00000414 /* RGMII/SGMII configuration */
+#define XAE_EMMC_OFFSET		0x00000410 /* MAC speed configuration */
+#define XAE_PHYC_OFFSET		0x00000414 /* RX Max Frame Configuration */
 #define XAE_ID_OFFSET		0x000004F8 /* Identification register */
-#define XAE_MDIO_MC_OFFSET	0x00000500 /* MII Management Config */
-#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MII Management Control */
-#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MII Management Write Data */
-#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MII Management Read Data */
+#define XAE_MDIO_MC_OFFSET	0x00000500 /* MDIO Setup */
+#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MDIO Control */
+#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MDIO Write Data */
+#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MDIO Read Data */
 #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
 #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
-#define XAE_FMI_OFFSET		0x00000708 /* Filter Mask Index */
+#define XAE_FMI_OFFSET		0x00000708 /* Frame Filter Control */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
 
@@ -308,7 +308,7 @@
  */
 #define XAE_UAW1_UNICASTADDR_MASK	0x0000FFFF
 
-/* Bit masks for Axi Ethernet FMI register */
+/* Bit masks for Axi Ethernet FMC register */
 #define XAE_FMI_PM_MASK			0x80000000 /* Promis. mode enable */
 #define XAE_FMI_IND_MASK		0x00000003 /* Index Mask */
 

base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
-- 
2.34.1


