Return-Path: <netdev+bounces-214543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF426B2A124
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E6D1899267
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE827B35B;
	Mon, 18 Aug 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AEKb/r/W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BA261B80;
	Mon, 18 Aug 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518405; cv=fail; b=chRaYpbrdANkn8+QPyGa/HCHviMNc0K75LL2RTU1+DMSUg+IalWX0qu8kk9bRNPmse4+Otexrb1E2dWiejrcMsZBKQapZ4fHKcSgpVUaDW32haFddl19PqJHpYHRuOZMDF65PNnJRqP/jXEhoublpFsdk8Ebex8jC3nKjXJ+B8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518405; c=relaxed/simple;
	bh=x3h0hLOdt8BbcYkM8AX+D7qKzT6cDkLF2eHnp5qkTks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WsOTsRmfyMzyGvn/jo2vx4iN0Ypxehe5JCorbSxkOmAyO5FuO4AzyBETAtRk4kxrxNeJNDSGraNvCb8uwMb4i8pHNKiJyQQhDkhs/JcmnXoxrkilrgqRHXt5wlvo5cWnYLXvtYa8uxaGElsCJon9fCElYqluDXMaVg640yDUwNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AEKb/r/W; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB5sLUmytiBBO+EdAR7LhNcbUnKqJQnWG6Ut+ssktZUh/MKWE6RjWxQsclOkUL+nIipxZyHQ8prPr6Pn2nhucZKqXJyetng+JUM6G13tIzhKRRr4f0sELRh0ULXlEXecwAiJonHaA+jqz7H//TKsFQ2hAGFJgjEwW3xV43t74Z7kjfO/Lppl0mQ/XG6cbWC6ePe28P/e4yCwTRElDg+R8rx6Hyt+ngEVS9RX+wwf1svytA5SuTG4B+ll6nS7DbtWaVD+DkbEmAaRBNAna5AmqWHxx1GQ/L2uK+k4W1sqjLdIsBc/Z1besIQZ68zrNVKUqf+7cM5yo3YpmqdvbGjlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GmlGOxV0y0ajPkQJPvBV4zt0bKLLVVHgjJRdAMdJ30=;
 b=Jp2/Q6LTJl/OO3EqGiEMXx/EAdOCVnKmAcjY80eQfgDkUnFu0gPY4KsJ6RaJRQ3mBk+UkX62aUayTjquqacqoFJnvDZHGGOPSi1Y/yBX1dTWuf/uza8lCCiNeNs6El+DMCWM8Z9SbkZJPWGqF3QDnaDnFyQKj/K3Op4Es8tF7S/7Pk8Gr3JgJ02eaFpuLZL2O5EJjAjIZ2bBDnm35qqyUksD51rf/bvujITfi4SUXV719GbCUYQLQSo2FliId1jyWZdhLdP+f3sYzLZ+kxsZw3eY1XATc2R+a4W6iZu70gIlGg9F6hiBahF19zixmAqHJJTSvCzR8dll1/hvlTll7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GmlGOxV0y0ajPkQJPvBV4zt0bKLLVVHgjJRdAMdJ30=;
 b=AEKb/r/WdGUmQ/uQq58UxA5gU4RovqAwXrMepT9HS8UAHj00tUJiOIDa2aReU2zIlq0badLQlnskxBRUS+I6nk0ORJ/yPgcq/mHsQilEW5WWUqpEaQ/Hkmn8DcOW6ZB/xyi6SGJlV82Q20/L1L28dSB+52MRBZhEnikLJin6tsk=
Received: from BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:59:58 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::1d) by BN9PR03CA0868.outlook.office365.com
 (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 11:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 11:59:57 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 06:59:54 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next] amd-xgbe: Add PPS periodic output support
Date: Mon, 18 Aug 2025 17:28:01 +0530
Message-ID: <20250818115801.2518912-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: cc425fa1-16db-4aae-b6a0-08ddde4ec095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OiowHKhAIU6IHZphE+WwV9s1a30QDLI16NewW91qFJb/9XEgyKQzN571xrEs?=
 =?us-ascii?Q?vCe0AYIAkMERc5/HT5JyBcCpLTbBuAUMAQKao2k4umi+IAhHhz/bGrmZ9x/3?=
 =?us-ascii?Q?75NKsvxUr/EX4QgCRJchyAKhbcGgTPcgf2BmCIfTzyMVABIvV6tnP+Hcogoq?=
 =?us-ascii?Q?yQKZlMJsVlfvb8bpSO8XgDU1o1jAbxBYSShXf6bfbEnqDAJxLBy4O4YqPHe5?=
 =?us-ascii?Q?SgF1jgDIpGAfqqZneUjB5KFdY7194qUqDW2kuj+NXZ0Lj4nk9aFqrD4qsmCf?=
 =?us-ascii?Q?cmHtsFU6FKmUvA1QDDHLvWYlMmzd57R3BRtT6TSbiBGdJuWxbU2NSYmQAKCo?=
 =?us-ascii?Q?e60l70cmBVREBstq1sFblsd8taYeGqyhyQJulWDrDKnAWVvnqmE8yjvXtDzW?=
 =?us-ascii?Q?AtptzmpP9y6beMBSQgg+6CredsE4YtZowatp1HyxBmRhG/wEUDsAO841TABa?=
 =?us-ascii?Q?YIcP9F8Kca2REAJZGyBh5R/kIlFH3XzI4qdF3ii79d3FioyfW4NmdNUBsi0f?=
 =?us-ascii?Q?RblC3plXGms/UbZ1F0Cs8+WKlaa3qsL+gnDUYhRWVVrTzEjn5DM/T8b1SKCj?=
 =?us-ascii?Q?+ulTmFm+R6muJPqt/RQxCzcaw645Ms2RD9iJK1g9Lqo87bpSnHOeIBIil4qY?=
 =?us-ascii?Q?CN0QGjKnK8uHPaagf8wiGCCKIdGfa+gExJro8tOfLnpMEgIhiLNa9ZV6qAez?=
 =?us-ascii?Q?uzPd121Rwb7fXhj6Q3/F6BTHQBvQ6MD7tpXDjwE6YxuCc6qZqVvFCGswdwZX?=
 =?us-ascii?Q?Fge4UFcZQdNG6ZpHpTZBjqBdaD7G844InwB3in0QVXCNh9lNn9V6GBzzYU6f?=
 =?us-ascii?Q?y4gjnTqTJ6GyNg3hgt+HF1Ro3YptHoVZM2jajN8tojf8ID7PgPe8FZrM3P9h?=
 =?us-ascii?Q?MB1ejzrz/SLK+DRCyOgmgYUx53QCFDj4mOc6w1s3mPy8dgkABFl8udCWsyrX?=
 =?us-ascii?Q?CdEb5HS2WDekvEx6zg36Gm2NuPOa5/l3oBoBl12l9NQ+TY385n5Kt1jEHaZU?=
 =?us-ascii?Q?LrJObmMHuQdxYjqMsl8pWsPqc2x8GJDB0/li8Ie50OCBlOV5D94x49zuUFoh?=
 =?us-ascii?Q?8sHdMuBFrrBC9UR+Y7DVQaaJceofLMqlh5qxVsDOOZiqsypNyx3IntPUe4B3?=
 =?us-ascii?Q?/yj1TzGOzrzECKA9PCPR7kjnGo3UoWWSFuCE43/Kx9DJup5cdgNtnD+PniGh?=
 =?us-ascii?Q?5yALDfPdOStfAl5bh/+W6ZGpUTOkgQVWQxfiS4BW2PE0QoJAwMhhRM6lXg0m?=
 =?us-ascii?Q?fgy9Kna7TI8Atr7Ap+sNMvwHFe6kVfR5OfGa+Tzd+6qolio4dBNN4lb1dcym?=
 =?us-ascii?Q?IDPmiYmUo8D2cg3dZ15IiOfhK1SDbtotqAD6B/DJWH3tF2QZjxYDMYn7Hs39?=
 =?us-ascii?Q?HfEEIJy+VOv6wQRtcNEkTS/+6nZl0tA26JqQEWmW1MSKl9xwfcq43TgPU89A?=
 =?us-ascii?Q?oomWYC7uXp6Jq5Dbz1/CtSSRc93W5Kst7tqWCVyIwqKsk7SEb8a3GnW0d2PX?=
 =?us-ascii?Q?18NR3sgpe3fw8Tfw61zJJF6NJbCKb8cXdGHt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:59:57.5898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc425fa1-16db-4aae-b6a0-08ddde4ec095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

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
 drivers/net/ethernet/amd/xgbe/Makefile      |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 60 +++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-pps.c    | 58 ++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    | 30 ++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 12 +++++
 5 files changed, 157 insertions(+), 5 deletions(-)
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
index 3658afc7801d..c4b7dcf886ec 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -106,7 +106,33 @@ static int xgbe_settime(struct ptp_clock_info *info,
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
@@ -122,6 +148,8 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 	info->adjtime = xgbe_adjtime;
 	info->gettimex64 = xgbe_gettimex;
 	info->settime64 = xgbe_settime;
+	info->n_per_out = pdata->hw_feat.pps_out_num;
+	info->n_ext_ts = pdata->hw_feat.aux_snap_num;
 	info->enable = xgbe_enable;
 
 	clock = ptp_clock_register(info, pdata->dev);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index d7e03e292ec4..adc2b5f69095 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -672,6 +672,11 @@ struct xgbe_ext_stats {
 	u64 rx_vxlan_csum_errors;
 };
 
+struct xgbe_pps_config {
+	struct timespec64 start;
+	struct timespec64 period;
+};
+
 struct xgbe_hw_if {
 	int (*tx_complete)(struct xgbe_ring_desc *);
 
@@ -1142,6 +1147,9 @@ struct xgbe_prv_data {
 	struct sk_buff *tx_tstamp_skb;
 	u64 tx_tstamp;
 
+	/* Pulse Per Second output */
+	struct xgbe_pps_config pps[4];
+
 	/* DCB support */
 	struct ieee_ets *ets;
 	struct ieee_pfc *pfc;
@@ -1304,6 +1312,10 @@ void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
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


