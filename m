Return-Path: <netdev+bounces-216003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00094B3159D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE85C3B9F35
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42D2D7DC5;
	Fri, 22 Aug 2025 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GTTN8rLg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC41A9F83;
	Fri, 22 Aug 2025 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859141; cv=fail; b=svSkNHnb23RLzSTER4j0HI5wS5ERWO7zNb6ORbEGKneAerroQ+DdHJ8CfunOT45RHzIBaKYIG+qK2VfLKmMtcAZsqBFWJbxTywVn5Gw0zdPvod9gdq4sakgTExd02ZdHBcvNZJC0pkNymXmbdQRqB04kqHFFWSTGvtqWZzrRDFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859141; c=relaxed/simple;
	bh=c+BaljBQQC+V1M5UKImhWVpdLp8KrQzSz+Ak8HVS+pA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y//ESZFRthGmvJ3niOKtFqFTV3eXrAQeCQOQFxYVbB+oMsyHDnkQIb7QvAUtpgw9xBjq39GT4mPpixJyYwDZbYyeiL6X3yQQiWtIw5AyNf28Jra9r7A5mXlqCX+gso+oDjzzFZqBCCSghQshY3l+zbHs2/iP+UunLUyYAEwgou0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GTTN8rLg; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMVdlyW7QDKUAuGyEtkbL5b83GZqL98/08x45/7AAx/ugMvJaP1gNeRGBovAh2qXktppgDdkS8Fe6mUeJ4H2svV+Vim1Dw7ENBr+kCeZUq0NCrIGXgqqB6+ZBR5inCypv8Jaa/yr7PbIgoh/P93FTo4ZBBUy8zDCJRgXlu/RL4JPNuRJnPVW/QY5wpMRfgmjyx1wcsd1Qu9AUtCU4yc6GyCm8/yAJlqthh2iUEY71pTEJHX4D62Fs/MNtq9eJAHA6kauoc0JC6FOU7Joh6+oP+goNnpy8jHre1VYAMWgmJF6VSsUBla5KCzaryhI5lQKAwYY6i9K54A9DLBOrBIxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PucDK6yA66ZPR70Agu68BUhRxmfgBcnUAGZZNQZukik=;
 b=eqBTr6jxWcTs0io9wlEE9TWzqfRsoaDThDWDHqm85zphGvClovw2De3paM1SzUzAsoGxLl+rxa0tl5CKXWGFQYyPvz/LNz/RAbrlj8e006rlTOPtb9lrFbX7TFkK39bHnuqTO39t3h5wPXMbc0V1LwFNokLFvnQdNQZz/IkZuzOk7f2V0HHthiJDrQirubzV4/K6apxUVoIeXdv6XWOOZcmjk003mDVrvhV5AcIXEGAzV/wzMdri/wzeS3lwIejK5wL7lVpkmP51S7W7/4+tF41+fgPobmXzXjJBZna6wmMa+HZE6EcfdHc42AlGDfvaLU1jIqaiZXY5NzyE+f7sag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PucDK6yA66ZPR70Agu68BUhRxmfgBcnUAGZZNQZukik=;
 b=GTTN8rLgnY8A3gF7A37+wjGq9SbDSh2GcwkonvDEPaMOsRuHodDSryjAzBYVC+90x3wRRWKmPwa/f3IdWzNPTOcIXRJaxUBLGh9pZNl1erIGDMaF8U3mrfeD+Wfrbh79B3xk5Ij5fL36fT+2QP1k1LHC2xcYMD/gQRwRAXmPnRM=
Received: from BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28) by
 SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Fri, 22 Aug
 2025 10:38:54 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::83) by BYAPR01CA0051.outlook.office365.com
 (2603:10b6:a03:94::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 10:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 10:38:53 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 05:38:49 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2] amd-xgbe: Add PPS periodic output support
Date: Fri, 22 Aug 2025 16:08:31 +0530
Message-ID: <20250822103831.2044533-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f0392a-0f6e-4997-29fd-08dde1681759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdq16620MIIfgOegiBZdkqEFQjryfsDV3DIlb+6aY5eiHuzaR3AlUhUbBsNC?=
 =?us-ascii?Q?hh9RjgHgVaQ7jMELi5tKluiBnyAQJzVvoTMu44DQCuzNSq10GIpOfKeX+68D?=
 =?us-ascii?Q?8HilJlWfEhBya7sDu7ThNMhF4R8iEoF7MW63/oehiH6HFZonFB35BioDTWJR?=
 =?us-ascii?Q?6EbgHkZw2hszDpXmYzKbigzC/Hz7464acI1N5kf36PzRoBpnbd7paKsjgRJe?=
 =?us-ascii?Q?ARFo7/nAlMFxXb1zMHh+6VADbWvjBRqiiKbksmxyRZAKHz56MKnx5eYRhv/+?=
 =?us-ascii?Q?mnEcMKRt1NZMK4qJ4SrCOXbk2OVwyLhKMDLNPRZvu09KBLk8v6F/fLKlQHHr?=
 =?us-ascii?Q?EG9YlaSvsyNK0zG6SSK/G1UChCiNT8Nmco4KlLwsMdRSOyizVXMM73Z2Vw+p?=
 =?us-ascii?Q?rGiE/PFBAnXDLssTmI8Kl2WVxzV6a2V/km16Amtue16a99mJ6GyKoFqf+q4Z?=
 =?us-ascii?Q?nmgdFsDJkjeaaFoS2kefk0S6zFunQDwBS+dfrfEx7TSWU9aZlU8CSYhA/3Wi?=
 =?us-ascii?Q?xYiufkSd4Z7fvsa/VnxTw9QrA/JR7xA0Cc1AreJAJG9UxZol2iMOtUGifZbj?=
 =?us-ascii?Q?jTQh4EJAYFC0Im+fTOJSFlCUzaPv5D3F1jmrzXWhpkOL1cMo7sNlcPMB1sY5?=
 =?us-ascii?Q?DSXDSA3HE84TpmKohmHrcLv6qN10Lye5i6EJpp24t3Oy7U/uh5iWqshrkvte?=
 =?us-ascii?Q?/bDYCQn0ZbDw1mwZR1wUtDrK0fHdNP/BzrQYOWgv52YUXTEiImgrEM8E/LHj?=
 =?us-ascii?Q?a5Y07EAECb9xYStrUiTigbc8SIn7wo+lxaDwP9O0Dd03EfRaAuBTGpcDJpQW?=
 =?us-ascii?Q?4K6jHhV4JOk/conS6K4XGTMQ/Wb/WSBTtIaZwTvG9aMOSq0cFocPmMHjq+tp?=
 =?us-ascii?Q?OqC7s2P7lQVBCrfVW5i+dUoCvvzZV8SjaNdGjuJaVoL2qHdxVy7vxUPU8m5C?=
 =?us-ascii?Q?FJfyqTrvogHdQW6aqxsSbmkLr2oDEpRIm8wyG18MixEw12001Zk2XROV1IT0?=
 =?us-ascii?Q?Tn47HFs7Q+47Ov2fWOhftaOfCwpixmocE56Uk5URYwoGWHTGctNCRKTO5lal?=
 =?us-ascii?Q?3qUpK7GrL6MvopCgNnBI0JQ1fxJyXbAkWLvde6gFj/U2oPmBfVSuXmg3d8Z8?=
 =?us-ascii?Q?D4ewYq34MXRtNYFlW1p6M5SCs3TYc2/RzFCCZ51pRejfzY7V0sTtt1B4bj4W?=
 =?us-ascii?Q?/fH7FaNZGjS94Dra6OpHXWSH5mJ5AxXdjn6dqObVBLfV42eziYAPmLJN3Wsa?=
 =?us-ascii?Q?bgcL1EBSkAtV1drt4i11ghhQDAR4813r31iX5+RQjNWPUGS1FfJUiDp5tvra?=
 =?us-ascii?Q?GpV16q67ojt+6HytGBmeN3z/71oAZhmr3pcWFlcDocAX+fYDkl3fBNCfNcBK?=
 =?us-ascii?Q?CL0SLu6xgdE8/SnEhpL3GXNNMgkkds9G2pJmfpUEQv4i66+cks4ASfiEZi75?=
 =?us-ascii?Q?TpNUbl/e8vqWv0OWElVWPtdSXQjmOX7F6LltCXLjJCd5OKbqFDs71HQZx5Sv?=
 =?us-ascii?Q?fgFHUNsbnQTGBPYv9kFn2hJHry50A2aO2eHq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:38:53.9684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f0392a-0f6e-4997-29fd-08dde1681759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245

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
Changes since v1:
 - add sanity check to prevent pps_out_num and aux_snap_num exceeding the limit

 drivers/net/ethernet/amd/xgbe/Makefile      |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 60 +++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 15 ++++++
 drivers/net/ethernet/amd/xgbe/xgbe-pps.c    | 58 ++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    | 34 +++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 16 ++++++
 6 files changed, 180 insertions(+), 5 deletions(-)
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
index 009fbc9b11ce..ef4a5c7a9454 100644
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
@@ -235,6 +242,29 @@
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
+#define PPSx_MASK(x) ({						\
+	unsigned int __x = (x);					\
+	GENMASK(PPS_MAXIDX(__x), PPS_MINIDX(__x));		\
+})
+#define PPSCMDx(x, val) ({					\
+	unsigned int __x = (x);					\
+	GENMASK(PPS_MINIDX(__x) + 3, PPS_MINIDX(__x)) &		\
+	((val) << PPS_MINIDX(__x));				\
+})
+#define TRGTMODSELx(x, val) ({					\
+	unsigned int __x = (x);					\
+	GENMASK(PPS_MAXIDX(__x) - 1, PPS_MAXIDX(__x) - 2) &	\
+	((val) << (PPS_MAXIDX(__x) - 2));			\
+})
+
 /* MAC register entry bit positions and sizes */
 #define MAC_HWF0R_ADDMACADRSEL_INDEX	18
 #define MAC_HWF0R_ADDMACADRSEL_WIDTH	5
@@ -460,8 +490,26 @@
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
@@ -496,8 +544,14 @@
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
index 000000000000..449720a60df5
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
@@ -0,0 +1,58 @@
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
index 3658afc7801d..b28f6a1d0e67 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -106,7 +106,37 @@ static int xgbe_settime(struct ptp_clock_info *info,
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
+	/* Reject requests with unsupported flags */
+	if (request->perout.flags)
+		return -EOPNOTSUPP;
+
+	/* Validate index against our limit */
+	if (request->perout.index >= XGBE_MAX_PPS_OUT)
+		return -EINVAL;
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
@@ -122,6 +152,8 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 	info->adjtime = xgbe_adjtime;
 	info->gettimex64 = xgbe_gettimex;
 	info->settime64 = xgbe_settime;
+	info->n_per_out = pdata->hw_feat.pps_out_num;
+	info->n_ext_ts = pdata->hw_feat.aux_snap_num;
 	info->enable = xgbe_enable;
 
 	clock = ptp_clock_register(info, pdata->dev);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index d7e03e292ec4..e3f89fbe1154 100644
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
@@ -672,6 +676,11 @@ struct xgbe_ext_stats {
 	u64 rx_vxlan_csum_errors;
 };
 
+struct xgbe_pps_config {
+	struct timespec64 start;
+	struct timespec64 period;
+};
+
 struct xgbe_hw_if {
 	int (*tx_complete)(struct xgbe_ring_desc *);
 
@@ -1142,6 +1151,9 @@ struct xgbe_prv_data {
 	struct sk_buff *tx_tstamp_skb;
 	u64 tx_tstamp;
 
+	/* Pulse Per Second output */
+	struct xgbe_pps_config pps[XGBE_MAX_PPS_OUT];
+
 	/* DCB support */
 	struct ieee_ets *ets;
 	struct ieee_pfc *pfc;
@@ -1304,6 +1316,10 @@ void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
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


