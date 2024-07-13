Return-Path: <netdev+bounces-111240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698899305B2
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22551F21D64
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220C13210F;
	Sat, 13 Jul 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2nibY0c8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF726296;
	Sat, 13 Jul 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876681; cv=fail; b=bpbkIudzgKrY/6m6oyQQIqsReaUBy6H6goB5G0gVxTPKguWCWDzRU0UWt7of7Vu/RDwEtwPdckEBtv4QTcuAh+K4YFgbRKbbtNjbcGjHAOO8adN6W3onbh75HwHMZPLABMED2gw362XJNU1uqRoBR4UoDCrcH1/be5CCg+BmHM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876681; c=relaxed/simple;
	bh=XxBK/OvB24PA+ejr4Y40M6cBfVscNDPmUPd3AkqSlm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WdCY56koEFJGvKctRnptlBEwR+F644hr5Hj7DkSz/tROUrWZmbGsT3un0HESpjcX8FkWmBk5EHyCtYjeZL3sKqFJB8yREQXvn0xaVHkYp+Tx6s5SY6ky7z12UmegKTz3VCx0EYn6C4VNnQH2oYhF2KSEbHSSbOS6CM6Bl+4Jy4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2nibY0c8; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPrrb/1zeRj5In7pdwbYQKbeqX3dKkKGzi9N9cAulGtK0ieHX/prQ8j+PD/oJq4TVXm6ctt6b2HQglyjd7bPH5Uu9uU/kWTzZHI2GU+aYin3TjSIYlZcpLR1iaK+NDW/b5utD/uMvALeWq/TvQ1oTh1zH8Qv/mRggmUP/SG2Zt6SW+rSb3iAyYed3iuR+oBcpYkspVoAcxHbosIca9o6BL+nKTzRWkrT/s98xGdDctL+B6VEKIbXnWOGVrqrxEiHDU6LgjrZNBNnKP7wE20fXyRTv8e+DApc9K3iuqE/XsRnVbPUB3j3JWguqjyKVVTRqGrfufRBG3nM1EJOgDWxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzsqI0qk1dr6Hhr2+RIYX9qGQziq1mkj7grqjHgID9c=;
 b=Gpg2ZuNNB/ClEcKyA3k8BBeV5sMOmimRF0HyexO+sG58kvjf57z46xsMaw5otdBjzG0knG0P58QfRlJJwT/L/ox7JyvrCeYPu4QtsMx+pL08ZYjg37Kh322n+tnluOA5ivYsLjymeKXDZ3e0/WUF/Fg9Iq5e+weCv4faOpPdi3p2/Gcj2z3XPHIwpIGwlvTQIDZqRSCVaXPIQYFUVmjF/Di/KUQe0+jRTGIK9bSZilJ97EbSUOucbRaEa86GQin0uCZD5AuE9HsM9YZxxcr6xKESvXUMJHM+DVYcFjiGlJufRMr+GxnO0P6O7CbIndeNgIFYTFd/sxBiaPKm/3WPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzsqI0qk1dr6Hhr2+RIYX9qGQziq1mkj7grqjHgID9c=;
 b=2nibY0c8N+DRuvxEz9Gv9Vwv10uBRjTXN/gEzoHKZXYwqsMz9U2tYjZwzQwMl3zjizoNlD2JNFno8BzAZEqVAaTZhp3Zxw6s/JCkCQ4eKO6I6nn7doz2kCBfkl4Gvj1u3NW22UWhBBAPmA6tVs3pPOyOgHLDdlcSwg+yNwoeLBg=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 13:17:56 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::4e) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24 via Frontend
 Transport; Sat, 13 Jul 2024 13:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Sat, 13 Jul 2024 13:17:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 08:17:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 08:17:54 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 13 Jul 2024 08:17:51 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.simek@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>,
	<suraj.gupta2@amd.com>
Subject: [LINUX PATCH] net: axienet: Fix axiethernet register description
Date: Sat, 13 Jul 2024 18:48:07 +0530
Message-ID: <20240713131807.418723-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 675d6831-6204-4114-b1d0-08dca33e3521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfntAvXrESEuK7rY4JrjoVraauIhbhAuFwgSUAUOdGd9tTpHfVUEUt4ZN2B+?=
 =?us-ascii?Q?Z2i05yYGiqemA6ndPNChfcYpCbdZIxqL5MMbfOm6wHl/kSik1EsGConoeNBy?=
 =?us-ascii?Q?DnpbFU4TxNym9wGN5J5uNEowSouqooky3aal6F3QO2FrCz/9Dwd1K0UXjo1l?=
 =?us-ascii?Q?rojsCu/ciz/uderie/tnQRw9KZg5joKf87RewL2a7g4iGYeM+i61UIL3a1Nf?=
 =?us-ascii?Q?AQNRYNDvagg3zlen4q0ttvNN4z0yE0ERhEatKAhjJPC7rPDIOoJL6PaSCZx2?=
 =?us-ascii?Q?nukfd9dp0F5DTGQYs1HHu6FZaRGf5SaGomR9rMsR1L42zy265KF3Pk+hEvgw?=
 =?us-ascii?Q?Z+UvU8YBQPNyvaLwLMMUEZGGHG/bUGb47gMT9kZfkVrdVL6LnapmNvuKECHU?=
 =?us-ascii?Q?wJjctOqlSwt56+KLrLdngZsofch0t1lCDHe6HET9nHpsbAH9i8aXrNihmRR7?=
 =?us-ascii?Q?bHdrsoMQMyN0xJ1aFI8iS6I/ld94FdeeLOIQes8BoCD3AuTdyQq8HIzk8ahw?=
 =?us-ascii?Q?tANXV+X8c+7/N0gQuFsGWg93HwWXPoaW5gJUZC/QLIL6rigLj8spxV41w+c+?=
 =?us-ascii?Q?TBkIkwbM4eXUYsDb7IhiU6BAk2EZsJkczcjDbWPjsn8H02BpaBJ1UEXSkjjz?=
 =?us-ascii?Q?cPk78RCqBi+odlubGEosOyw9HYGGVIg54hMfpuJ3fdqpkP4ys9cp0ay48Z7q?=
 =?us-ascii?Q?vY9zSR+Uh0IsELA0ORMTW3mKYnUMSsCEGXi6CmA4lPPRtgHk1s5Ri//Twurc?=
 =?us-ascii?Q?LymcWDO3RPeqhV388nq6nll4X/yZKHuJXhScMhg484i8iL4o5cjWS634v4DQ?=
 =?us-ascii?Q?K19G6jyL5EDTNvKzKHyJ4l7lQ2vK5ujLu9R9SPTCqYfCL6ZHbkPD/885InVz?=
 =?us-ascii?Q?6c2GWW/kdd/UmXAMiqUYf52/PhbPjCPz3jFADxLeTM4/mVEOyova3oOxcvjO?=
 =?us-ascii?Q?HwvR/eL7C6iyv5kPSrAepa0xhKC2i18PqpOFzaXUfXfGMuw7ng5aeJfWnIw8?=
 =?us-ascii?Q?1XyISIpfwtmd0XsapYxyCjSF45qVx9Pbb5QEhvk6YuaNHYBbipWBbBjfTQfh?=
 =?us-ascii?Q?La6mTvBtFiX0OtDQM8kEjFFlBgQIdijOCU3p1hOjdzVuiqcURWEToPeodddr?=
 =?us-ascii?Q?V2clOkgV1la9Hhf+LsyjsB2lLREKYRkt7xRpe5TzFzbTAjTWbyfpScBhI19+?=
 =?us-ascii?Q?9AmcjxmVlPdB1yZgTe7bmCJJUG660ZwUe4JsMTA0VR/tmHNO1nXko+9l/Y2x?=
 =?us-ascii?Q?lu00MxGxDkOL1I8Bmg4yzryIzndZ91F0EcmkSTPOqZuOUJ5fJci6nSr/DpGE?=
 =?us-ascii?Q?bAPbIDbEBWSte2hI5sct9tUwCknsV5qaQqyCwS0VBJxhEk26gms3G5y8xle1?=
 =?us-ascii?Q?5fPFqT63OiJgsd78KxjYLXyJAIlsG1PLA4OvpA3wMFXRcX0Stw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 13:17:55.3843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675d6831-6204-4114-b1d0-08dca33e3521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212

Rename axiethernet register description to be inline with product guide
register names. It also removes obsolete registers and bitmasks. There is
no functional impact since the modified offsets are only renamed.

Rename XAE_PHYC_OFFSET->XAE_RMFC_OFFSET (Only used in ethtool get_regs)
XAE_MDIO_* : update documentation comment.
Remove unused Bit masks for Axi Ethernet PHYC register.
Remove bit masks for MDIO interface MIS, MIP, MIE, MIC registers.
Rename XAE_FMI -> XAE_FMC.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
Since the changes are related to documentation, not added Fixes tag.
Link to axiethernet PG:
https://docs.xilinx.com/r/en-US/pg138-axi-ethernet/Register-Space
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  | 35 ++++++-------------
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 28 +++++++--------
 2 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fa5500decc96..17cca8140179 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -160,16 +160,16 @@
 #define XAE_RCW1_OFFSET		0x00000404 /* Rx Configuration Word 1 */
 #define XAE_TC_OFFSET		0x00000408 /* Tx Configuration */
 #define XAE_FCC_OFFSET		0x0000040C /* Flow Control Configuration */
-#define XAE_EMMC_OFFSET		0x00000410 /* EMAC mode configuration */
-#define XAE_PHYC_OFFSET		0x00000414 /* RGMII/SGMII configuration */
 #define XAE_ID_OFFSET		0x000004F8 /* Identification register */
-#define XAE_MDIO_MC_OFFSET	0x00000500 /* MII Management Config */
-#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MII Management Control */
-#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MII Management Write Data */
-#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MII Management Read Data */
+#define XAE_EMMC_OFFSET		0x00000410 /* MAC speed configuration */
+#define XAE_RMFC_OFFSET		0x00000414 /* RX Max Frame Configuration */
+#define XAE_MDIO_MC_OFFSET	0x00000500 /* MDIO Setup */
+#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MDIO Control */
+#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MDIO Write Data */
+#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MDIO Read Data */
 #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
 #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
-#define XAE_FMI_OFFSET		0x00000708 /* Filter Mask Index */
+#define XAE_FMC_OFFSET		0x00000708 /* Frame Filter Control */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
 
@@ -271,18 +271,6 @@
 #define XAE_EMMC_LINKSPD_100	0x40000000 /* Link Speed mask for 100 Mbit */
 #define XAE_EMMC_LINKSPD_1000	0x80000000 /* Link Speed mask for 1000 Mbit */
 
-/* Bit masks for Axi Ethernet PHYC register */
-#define XAE_PHYC_SGMIILINKSPEED_MASK	0xC0000000 /* SGMII link speed mask*/
-#define XAE_PHYC_RGMIILINKSPEED_MASK	0x0000000C /* RGMII link speed */
-#define XAE_PHYC_RGMIIHD_MASK		0x00000002 /* RGMII Half-duplex */
-#define XAE_PHYC_RGMIILINK_MASK		0x00000001 /* RGMII link status */
-#define XAE_PHYC_RGLINKSPD_10		0x00000000 /* RGMII link 10 Mbit */
-#define XAE_PHYC_RGLINKSPD_100		0x00000004 /* RGMII link 100 Mbit */
-#define XAE_PHYC_RGLINKSPD_1000		0x00000008 /* RGMII link 1000 Mbit */
-#define XAE_PHYC_SGLINKSPD_10		0x00000000 /* SGMII link 10 Mbit */
-#define XAE_PHYC_SGLINKSPD_100		0x40000000 /* SGMII link 100 Mbit */
-#define XAE_PHYC_SGLINKSPD_1000		0x80000000 /* SGMII link 1000 Mbit */
-
 /* Bit masks for Axi Ethernet MDIO interface MC register */
 #define XAE_MDIO_MC_MDIOEN_MASK		0x00000040 /* MII management enable */
 #define XAE_MDIO_MC_CLOCK_DIVIDE_MAX	0x3F	   /* Maximum MDIO divisor */
@@ -299,18 +287,15 @@
 #define XAE_MDIO_MCR_INITIATE_MASK	0x00000800 /* Ready Mask */
 #define XAE_MDIO_MCR_READY_MASK		0x00000080 /* Ready Mask */
 
-/* Bit masks for Axi Ethernet MDIO interface MIS, MIP, MIE, MIC registers */
-#define XAE_MDIO_INT_MIIM_RDY_MASK	0x00000001 /* MIIM Interrupt */
-
 /* Bit masks for Axi Ethernet UAW1 register */
 /* Station address bits [47:32]; Station address
  * bits [31:0] are stored in register UAW0
  */
 #define XAE_UAW1_UNICASTADDR_MASK	0x0000FFFF
 
-/* Bit masks for Axi Ethernet FMI register */
-#define XAE_FMI_PM_MASK			0x80000000 /* Promis. mode enable */
-#define XAE_FMI_IND_MASK		0x00000003 /* Index Mask */
+/* Bit masks for Axi Ethernet FMC register */
+#define XAE_FMC_PM_MASK			0x80000000 /* Promis. mode enable */
+#define XAE_FMC_IND_MASK		0x00000003 /* Index Mask */
 
 #define XAE_MDIO_DIV_DFT		29 /* Default MDIO clock divisor */
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e342f387c3dd..4da6d8726123 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -116,8 +116,8 @@ static struct axienet_option axienet_options[] = {
 		.m_or = XAE_FCC_FCTX_MASK,
 	}, { /* Turn on promiscuous frame filtering */
 		.opt = XAE_OPTION_PROMISC,
-		.reg = XAE_FMI_OFFSET,
-		.m_or = XAE_FMI_PM_MASK,
+		.reg = XAE_FMC_OFFSET,
+		.m_or = XAE_FMC_PM_MASK,
 	}, { /* Enable transmitter */
 		.opt = XAE_OPTION_TXEN,
 		.reg = XAE_TC_OFFSET,
@@ -443,9 +443,9 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		 * the flag is already set. If not we set it.
 		 */
 		ndev->flags |= IFF_PROMISC;
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
-		reg |= XAE_FMI_PM_MASK;
-		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		reg = axienet_ior(lp, XAE_FMC_OFFSET);
+		reg |= XAE_FMC_PM_MASK;
+		axienet_iow(lp, XAE_FMC_OFFSET, reg);
 		dev_info(&ndev->dev, "Promiscuous mode enabled.\n");
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
@@ -463,25 +463,25 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 			af1reg = (ha->addr[4]);
 			af1reg |= (ha->addr[5] << 8);
 
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+			reg = axienet_ior(lp, XAE_FMC_OFFSET) & 0xFFFFFF00;
 			reg |= i;
 
-			axienet_iow(lp, XAE_FMI_OFFSET, reg);
+			axienet_iow(lp, XAE_FMC_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, af0reg);
 			axienet_iow(lp, XAE_AF1_OFFSET, af1reg);
 			i++;
 		}
 	} else {
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
-		reg &= ~XAE_FMI_PM_MASK;
+		reg = axienet_ior(lp, XAE_FMC_OFFSET);
+		reg &= ~XAE_FMC_PM_MASK;
 
-		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		axienet_iow(lp, XAE_FMC_OFFSET, reg);
 
 		for (i = 0; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+			reg = axienet_ior(lp, XAE_FMC_OFFSET) & 0xFFFFFF00;
 			reg |= i;
 
-			axienet_iow(lp, XAE_FMI_OFFSET, reg);
+			axienet_iow(lp, XAE_FMC_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, 0);
 			axienet_iow(lp, XAE_AF1_OFFSET, 0);
 		}
@@ -1793,14 +1793,14 @@ static void axienet_ethtools_get_regs(struct net_device *ndev,
 	data[15] = axienet_ior(lp, XAE_TC_OFFSET);
 	data[16] = axienet_ior(lp, XAE_FCC_OFFSET);
 	data[17] = axienet_ior(lp, XAE_EMMC_OFFSET);
-	data[18] = axienet_ior(lp, XAE_PHYC_OFFSET);
+	data[18] = axienet_ior(lp, XAE_RMFC_OFFSET);
 	data[19] = axienet_ior(lp, XAE_MDIO_MC_OFFSET);
 	data[20] = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
 	data[21] = axienet_ior(lp, XAE_MDIO_MWD_OFFSET);
 	data[22] = axienet_ior(lp, XAE_MDIO_MRD_OFFSET);
 	data[27] = axienet_ior(lp, XAE_UAW0_OFFSET);
 	data[28] = axienet_ior(lp, XAE_UAW1_OFFSET);
-	data[29] = axienet_ior(lp, XAE_FMI_OFFSET);
+	data[29] = axienet_ior(lp, XAE_FMC_OFFSET);
 	data[30] = axienet_ior(lp, XAE_AF0_OFFSET);
 	data[31] = axienet_ior(lp, XAE_AF1_OFFSET);
 	if (!lp->use_dmaengine) {
-- 
2.25.1


