Return-Path: <netdev+bounces-217681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA19DB39854
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBACD3B2E07
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E572E0910;
	Thu, 28 Aug 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nhzZo1+B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789881DFE22;
	Thu, 28 Aug 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373390; cv=fail; b=nqQ1RbAkV0NgzXsWvPf0XM6CQd1S/PXiVu04uQccDjIALULjYxracBZErTRRpx2VnuppST7CcHSK14LsQYut6mTWUQgQ//he+7K3BcMt4LgGtrq8uXAFjz2POlV5M/MAuCxD4PtBGWOLZ+wfe2W1yd2+WU0u/Xag/SK5czIghQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373390; c=relaxed/simple;
	bh=PFK1L17PAjPyWNKagfvVTjkOBhUxWboI1xbNeZt+fTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9Fg9ONgR+Bw0wtCV2Uznw/FtSJsUGlevwnsBB3zCxE9kE7QDH9n//alWEYiU0APS51FjiBMbKHMi8P0IJwokoLoYY+vtnJIErs+wdWhhAeP4WkxukRw5t1X9uD8i8/rRw9OiIHcpcKovenX09KMYFDVPNWcuU936ZL3dyXD80U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nhzZo1+B; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s243dLvNepmivpJ65pujPc06WgjGot/SUDiv0BQfo1hOx5Or1BDzahdvlTfJq2MEEoDBHBdLbY5pFCCqDwWQXtLzctBKDGvceg17dih1p69kXBC9PAY3TNzAEs+vh6IQzy2KdXyGSTAvM9spYHc8SnXhAsHAhnuDi1kq6Wrkrm5i3c3zj7iBG3ILgbReK7eZwGxp3wUv+5J29qI7u55ffR0IGAOmQnGxHX6w/8enrzMxvmPB1ZOk38q7UnWLO4psza3IxapGCp75VLEHyXHKvWTN39y3Iu9MJD9qscy8li1ybbOD/tTJHBiWelv9OtBuNrcaevui5vQTpFQK8wNaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbp+7yphGRAop2NHWWY4w9KMAXkSmvOzfc/qFiHDisI=;
 b=OALYMfFLtOgi5+q5r0flkZywbLvaZe6S3UuqXGqgcvDg8pQ9nuJJc/NrOyVhgkcLySu4gr1NOTyDr3gehQZ4OeyMXrqCfXg41PoyYxaPR1D30dOILvZmshF6y1vVO+s1yqYW4G6Ce/0xRfulWhMZ++s0XtH058Oc32NYU15Mw2jFWDKnDJy6HrWUjLk99S6ZdxNKtBGfiO/2xOCbcVf86bNbmjJSB8nVRruDr2bUOhgK9BBH9vq567PU3jF5f8LZJxHNlE0hTqAQBXFKRBDZkwySg+0KmIlkbF7CcF+0Hgu+4VBE+N2jciBgO/Tt0J1rdmj7cxbioOH8B/SvoUvkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbp+7yphGRAop2NHWWY4w9KMAXkSmvOzfc/qFiHDisI=;
 b=nhzZo1+BhhqpI3BkueZ4rYE6GbMnAJGZvtM12Z6AEIKGew3TnY1GszbNR7+ba0Hci1kdR6k0sGJNEG/90Un7swmpUufw5/d7lPTdISyXKtsUUJ/XqBflrNV1SnyE/P1DzQ4sxlRN4uA7xhrWnCP4LYzIPi9vN+ojl3CeCSyw2M8=
Received: from SA1P222CA0057.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::6)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 09:29:37 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::8a) by SA1P222CA0057.outlook.office365.com
 (2603:10b6:806:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Thu,
 28 Aug 2025 09:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:29:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 04:29:36 -0500
Received: from airavat.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 02:29:33 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3] amd-xgbe: Add PPS periodic output support
Date: Thu, 28 Aug 2025 14:59:00 +0530
Message-ID: <20250828092900.365990-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b95040-9d8c-4c5c-f69a-08dde6156839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5S+S6uY3csneFupJi3itMJBOFQ9JLqHBE/rXA5f1uuEboLrwW+1q6p8ylUgT?=
 =?us-ascii?Q?brUxwjhfh8l72oLsWRsthqJ9N1mIpf4h9D5apn/ILS3aE3bCY2L6F6S7Xdfw?=
 =?us-ascii?Q?3E03VcpqryLAGL7ea6pk6b6tFp6+FMeLPGTn114Co4JqC/53kvVHMfTBv5Lp?=
 =?us-ascii?Q?l9bKpyWEzXBihQhvek172LJD7MMYAD3o3nGFy4OX0Pg3ZWM3UGTtxsazGqtv?=
 =?us-ascii?Q?1WgDb1ba7bXde7PSgY05U12+zsuzl311xBbquGQOfIGIguh6D0Gl+aA6Dler?=
 =?us-ascii?Q?u2iMw5YYzoLsIe5SBJLQmboWZ3bUlza9j/dWkXIQqbGruazcrt5RWcUpfp3w?=
 =?us-ascii?Q?loXxF1upbKPCbuDLOvCt9dYo5D7xiIqAUuWu2eE/sg3UEl95QAewQrAvRQ4f?=
 =?us-ascii?Q?nZHG8ZU1AiaSlHZkYmErUFBau+HZFuOFG2PrIGkLf5N6JK/fGylzaAVEr1dc?=
 =?us-ascii?Q?W+KWkJPGu6tB8PIjJxPd5OTO8Fwzv6SS81haClel9aMciwUtPqM4s+Xa+sng?=
 =?us-ascii?Q?BjXm6WJpvsVB2LwjNCKlHwfoFxYZ45BldxCjEsdTrFa97RASyMCs1yvIqntq?=
 =?us-ascii?Q?AGgxW7yDgcKk5rgWOMct5klpERwFMSHNHPlmAuiwomW2CwDkEqp2iJJHmHja?=
 =?us-ascii?Q?yhFXj5P7ZU7J29tQhljTMKHUDTV9N6CTy9XO17gadpU3VmLJphHxtZdkKyeb?=
 =?us-ascii?Q?1NtJG2IfhZEkjd7gYA+2l5OLfpHdPLegpTRp6B/5BlkOCMureoWJOzWipCVO?=
 =?us-ascii?Q?8CMwfxTpGYrtQgBa/TNxpisG9ftOlDd3wBKOiYCYY0T907a3NrMND2Z4NeSj?=
 =?us-ascii?Q?2eHpcP+iwv6skR1wZtj0g3xkzqH7m8Qrdd2qoRI6E9vISd1ZDr4BwjPx2Q5n?=
 =?us-ascii?Q?YC5kuzOTynk9fnTELF03/yVlKJWRX8NVYwECFXecBlQ6Rj9GGfm9ZwpUbaNe?=
 =?us-ascii?Q?RZf7eJpz6w9BMHdbkqm3dpMvo7JbeUGIg2/VR7e3fxex1VyELy8dMcoGSbNl?=
 =?us-ascii?Q?m+P83SgsH6nUtO9VlIT3KEiyIBrDNYH2Hlc9KxyPTilCckzyGaA04K7VHHF1?=
 =?us-ascii?Q?/LajgkTB4pANeT5D88tN39887nleoZAC8c31YbSfAERCiUcCOqBK+c9O3Skh?=
 =?us-ascii?Q?gUxNExjyJ4XKAZxrNp/t939SL4uZx1v0J7BgUq/SOJidsBv7nO6HlUuuMp7b?=
 =?us-ascii?Q?iw5QpYhXOvFfaOsifmPiYrOdnh1eC98ZVlfQjCgMfWAI2Xrb/msTBgLGE//L?=
 =?us-ascii?Q?HWUZEkGp9KI5bDdIFcCKV0HQ1hUtKX7EA0fWgM6DbR8L15ndD3MHrJ7ArSeC?=
 =?us-ascii?Q?F8GdyT35drHHychOH7pJgel7Ol8fkOM53X7C388g2UItls0mDC5zxxVSJKXX?=
 =?us-ascii?Q?1yyV8/8H7s/Yosm8Vq3kNX0Z/pOK8YOA+510sBDFhgVeQarEp0dnvYli2zWq?=
 =?us-ascii?Q?lzZ3RmGY6ASkIw1sLj6KggOZCScSTpysCGPELKng03JNa1iBjRmGLbtFj4Al?=
 =?us-ascii?Q?NmyC4B1f9s8o8SMMjwfygF6wattxNf58rBv4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:29:37.3078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b95040-9d8c-4c5c-f69a-08dde6156839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

Add support for hardware PPS (Pulse Per Second) output to the
AMD XGBE driver. The implementation enables flexible periodic
output mode, exposing it via the PTP per_out interface.

The driver supports configuring PPS output using the standard
PTP subsystem, allowing precise periodic signal generation for
time synchronization applications.

The feature has been verified using the testptp tool and
oscilloscope.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
 - avoid redundant checks in xgbe_enable()
 - simplify the mask calculation

Changes since v1:
 - add sanity check to prevent pps_out_num and aux_snap_num exceeding the limit

 drivers/net/ethernet/amd/xgbe/Makefile      |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 46 ++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 15 +++++
 drivers/net/ethernet/amd/xgbe/xgbe-pps.c    | 73 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    | 26 +++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 16 +++++
 6 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-pps.c

diff --git a/drivers/net/ethernet/amd/xgbe/Makefile b/drivers/net/ethernet/amd/xgbe/Makefile
index 5b0ab6240cf2..d546a212806a 100644
--- a/drivers/net/ethernet/amd/xgbe/Makefile
+++ b/drivers/net/ethernet/amd/xgbe/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_AMD_XGBE) += amd-xgbe.o
 
 amd-xgbe-objs := xgbe-main.o xgbe-drv.o xgbe-dev.o \
 		 xgbe-desc.o xgbe-ethtool.o xgbe-mdio.o \
-		 xgbe-hwtstamp.o xgbe-ptp.o \
+		 xgbe-hwtstamp.o xgbe-ptp.o xgbe-pps.o\
 		 xgbe-i2c.o xgbe-phy-v1.o xgbe-phy-v2.o \
 		 xgbe-platform.o
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 009fbc9b11ce..c8447825c2f6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -223,11 +223,18 @@
 #define MAC_TSSR			0x0d20
 #define MAC_TXSNR			0x0d30
 #define MAC_TXSSR			0x0d34
+#define MAC_AUXCR			0x0d40
+#define MAC_ATSNR			0x0d48
+#define MAC_ATSSR			0x0d4C
 #define MAC_TICNR                       0x0d58
 #define MAC_TICSNR                      0x0d5C
 #define MAC_TECNR                       0x0d60
 #define MAC_TECSNR                      0x0d64
-
+#define MAC_PPSCR			0x0d70
+#define MAC_PPS0_TTSR			0x0d80
+#define MAC_PPS0_TTNSR			0x0d84
+#define MAC_PPS0_INTERVAL		0x0d88
+#define MAC_PPS0_WIDTH			0x0d8C
 #define MAC_QTFCR_INC			4
 #define MAC_MACA_INC			4
 #define MAC_HTR_INC			4
@@ -235,6 +242,15 @@
 #define MAC_RQC2_INC			4
 #define MAC_RQC2_Q_PER_REG		4
 
+/* PPS helpers */
+#define PPSEN0				BIT(4)
+#define MAC_PPSx_TTSR(x)		((MAC_PPS0_TTSR) + ((x) * 0x10))
+#define MAC_PPSx_TTNSR(x)		((MAC_PPS0_TTNSR) + ((x) * 0x10))
+#define MAC_PPSx_INTERVAL(x)		((MAC_PPS0_INTERVAL) + ((x) * 0x10))
+#define MAC_PPSx_WIDTH(x)		((MAC_PPS0_WIDTH) + ((x) * 0x10))
+#define PPS_MAXIDX(x)			((((x) + 1) * 8) - 1)
+#define PPS_MINIDX(x)			((x) * 8)
+
 /* MAC register entry bit positions and sizes */
 #define MAC_HWF0R_ADDMACADRSEL_INDEX	18
 #define MAC_HWF0R_ADDMACADRSEL_WIDTH	5
@@ -460,8 +476,26 @@
 #define MAC_TSCR_TXTSSTSM_WIDTH		1
 #define MAC_TSSR_TXTSC_INDEX		15
 #define MAC_TSSR_TXTSC_WIDTH		1
+#define MAC_TSSR_ATSSTN_INDEX		16
+#define MAC_TSSR_ATSSTN_WIDTH		4
+#define MAC_TSSR_ATSNS_INDEX		25
+#define MAC_TSSR_ATSNS_WIDTH		5
+#define MAC_TSSR_ATSSTM_INDEX		24
+#define MAC_TSSR_ATSSTM_WIDTH		1
+#define MAC_TSSR_ATSSTN_INDEX		16
+#define MAC_TSSR_ATSSTN_WIDTH		4
+#define MAC_TSSR_AUXTSTRIG_INDEX	2
+#define MAC_TSSR_AUXTSTRIG_WIDTH	1
 #define MAC_TXSNR_TXTSSTSMIS_INDEX	31
 #define MAC_TXSNR_TXTSSTSMIS_WIDTH	1
+#define MAC_AUXCR_ATSEN3_INDEX		7
+#define MAC_AUXCR_ATSEN3_WIDTH		1
+#define MAC_AUXCR_ATSEN2_INDEX		6
+#define MAC_AUXCR_ATSEN2_WIDTH		1
+#define MAC_AUXCR_ATSEN1_INDEX		5
+#define MAC_AUXCR_ATSEN1_WIDTH		1
+#define MAC_AUXCR_ATSEN0_INDEX		4
+#define MAC_AUXCR_ATSEN0_WIDTH		1
 #define MAC_TICSNR_TSICSNS_INDEX	8
 #define MAC_TICSNR_TSICSNS_WIDTH	8
 #define MAC_TECSNR_TSECSNS_INDEX	8
@@ -496,8 +530,14 @@
 #define MAC_VR_SNPSVER_WIDTH		8
 #define MAC_VR_USERVER_INDEX		16
 #define MAC_VR_USERVER_WIDTH		8
-
-/* MMC register offsets */
+#define MAC_PPSCR_PPSEN0_INDEX		4
+#define MAC_PPSCR_PPSEN0_WIDTH		1
+#define MAC_PPSCR_PPSCTRL0_INDEX	0
+#define MAC_PPSCR_PPSCTRL0_WIDTH	4
+#define MAC_PPSx_TTNSR_TRGTBUSY0_INDEX	31
+#define MAC_PPSx_TTNSR_TRGTBUSY0_WIDTH	1
+
+ /* MMC register offsets */
 #define MMC_CR				0x0800
 #define MMC_RISR			0x0804
 #define MMC_TISR			0x0808
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 2e9b95a94f89..f0989aa01855 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -691,6 +691,21 @@ void xgbe_get_all_hw_features(struct xgbe_prv_data *pdata)
 	hw_feat->pps_out_num  = XGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, PPSOUTNUM);
 	hw_feat->aux_snap_num = XGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, AUXSNAPNUM);
 
+	/* Sanity check and warn if hardware reports more than supported */
+	if (hw_feat->pps_out_num > XGBE_MAX_PPS_OUT) {
+		dev_warn(pdata->dev,
+			 "Hardware reports %u PPS outputs, limiting to %u\n",
+			 hw_feat->pps_out_num, XGBE_MAX_PPS_OUT);
+		hw_feat->pps_out_num = XGBE_MAX_PPS_OUT;
+	}
+
+	if (hw_feat->aux_snap_num > XGBE_MAX_AUX_SNAP) {
+		dev_warn(pdata->dev,
+			 "Hardware reports %u aux snapshot inputs, limiting to %u\n",
+			 hw_feat->aux_snap_num, XGBE_MAX_AUX_SNAP);
+		hw_feat->aux_snap_num = XGBE_MAX_AUX_SNAP;
+	}
+
 	/* Translate the Hash Table size into actual number */
 	switch (hw_feat->hash_table_size) {
 	case 0:
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pps.c b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
new file mode 100644
index 000000000000..b5704fbbc5be
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
+ *
+ * Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+
+#include "xgbe.h"
+#include "xgbe-common.h"
+
+static inline u32 PPSx_MASK(unsigned int x)
+{
+	return GENMASK(PPS_MAXIDX(x), PPS_MINIDX(x));
+}
+
+static inline u32 PPSCMDx(unsigned int x, u32 val)
+{
+	return ((val & GENMASK(3, 0)) << PPS_MINIDX(x));
+}
+
+static inline u32 TRGTMODSELx(unsigned int x, u32 val)
+{
+	return ((val & GENMASK(1, 0)) << (PPS_MAXIDX(x) - 2));
+}
+
+int xgbe_pps_config(struct xgbe_prv_data *pdata,
+		    struct xgbe_pps_config *cfg, int index, int on)
+{
+	unsigned int value = 0;
+	unsigned int tnsec;
+	u64 period;
+
+	tnsec = XGMAC_IOREAD(pdata, MAC_PPSx_TTNSR(index));
+	if (XGMAC_GET_BITS(tnsec, MAC_PPSx_TTNSR, TRGTBUSY0))
+		return -EBUSY;
+
+	value = XGMAC_IOREAD(pdata, MAC_PPSCR);
+
+	value &= ~PPSx_MASK(index);
+
+	if (!on) {
+		value |= PPSCMDx(index, 0x5);
+		value |= PPSEN0;
+		XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
+		return 0;
+	}
+
+	XGMAC_IOWRITE(pdata, MAC_PPSx_TTSR(index), cfg->start.tv_sec);
+	XGMAC_IOWRITE(pdata, MAC_PPSx_TTNSR(index), cfg->start.tv_nsec);
+
+	period = cfg->period.tv_sec * NSEC_PER_SEC;
+	period += cfg->period.tv_nsec;
+	do_div(period, XGBE_V2_TSTAMP_SSINC);
+
+	if (period <= 1)
+		return -EINVAL;
+
+	XGMAC_IOWRITE(pdata, MAC_PPSx_INTERVAL(index), period - 1);
+	period >>= 1;
+	if (period <= 1)
+		return -EINVAL;
+
+	XGMAC_IOWRITE(pdata, MAC_PPSx_WIDTH(index), period - 1);
+
+	value |= PPSCMDx(index, 0x2);
+	value |= TRGTMODSELx(index, 0x2);
+	value |= PPSEN0;
+
+	XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
+	return 0;
+}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
index 3658afc7801d..0e0b8ec3b504 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -106,7 +106,29 @@ static int xgbe_settime(struct ptp_clock_info *info,
 static int xgbe_enable(struct ptp_clock_info *info,
 		       struct ptp_clock_request *request, int on)
 {
-	return -EOPNOTSUPP;
+	struct xgbe_prv_data *pdata = container_of(info, struct xgbe_prv_data,
+						   ptp_clock_info);
+	struct xgbe_pps_config *pps_cfg;
+	unsigned long flags;
+	int ret;
+
+	dev_dbg(pdata->dev, "rq->type %d on %d\n", request->type, on);
+
+	if (request->type != PTP_CLK_REQ_PEROUT)
+		return -EOPNOTSUPP;
+
+	pps_cfg = &pdata->pps[request->perout.index];
+
+	pps_cfg->start.tv_sec = request->perout.start.sec;
+	pps_cfg->start.tv_nsec = request->perout.start.nsec;
+	pps_cfg->period.tv_sec = request->perout.period.sec;
+	pps_cfg->period.tv_nsec = request->perout.period.nsec;
+
+	spin_lock_irqsave(&pdata->tstamp_lock, flags);
+	ret = xgbe_pps_config(pdata, pps_cfg, request->perout.index, on);
+	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
+
+	return ret;
 }
 
 void xgbe_ptp_register(struct xgbe_prv_data *pdata)
@@ -122,6 +144,8 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 	info->adjtime = xgbe_adjtime;
 	info->gettimex64 = xgbe_gettimex;
 	info->settime64 = xgbe_settime;
+	info->n_per_out = pdata->hw_feat.pps_out_num;
+	info->n_ext_ts = pdata->hw_feat.aux_snap_num;
 	info->enable = xgbe_enable;
 
 	clock = ptp_clock_register(info, pdata->dev);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 0fa80a238ac5..75246699d399 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -142,6 +142,10 @@
 #define XGBE_V2_TSTAMP_SNSINC	0
 #define XGBE_V2_PTP_ACT_CLK_FREQ	1000000000
 
+/* Define maximum supported values */
+#define XGBE_MAX_PPS_OUT	4
+#define XGBE_MAX_AUX_SNAP	4
+
 /* Driver PMT macros */
 #define XGMAC_DRIVER_CONTEXT	1
 #define XGMAC_IOCTL_CONTEXT	2
@@ -673,6 +677,11 @@ struct xgbe_ext_stats {
 	u64 rx_vxlan_csum_errors;
 };
 
+struct xgbe_pps_config {
+	struct timespec64 start;
+	struct timespec64 period;
+};
+
 struct xgbe_hw_if {
 	int (*tx_complete)(struct xgbe_ring_desc *);
 
@@ -1143,6 +1152,9 @@ struct xgbe_prv_data {
 	struct sk_buff *tx_tstamp_skb;
 	u64 tx_tstamp;
 
+	/* Pulse Per Second output */
+	struct xgbe_pps_config pps[XGBE_MAX_PPS_OUT];
+
 	/* DCB support */
 	struct ieee_ets *ets;
 	struct ieee_pfc *pfc;
@@ -1305,6 +1317,10 @@ void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
 int xgbe_init_ptp(struct xgbe_prv_data *pdata);
 void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
 			     unsigned int nsec);
+
+int xgbe_pps_config(struct xgbe_prv_data *pdata, struct xgbe_pps_config *cfg,
+		    int index, int on);
+
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


