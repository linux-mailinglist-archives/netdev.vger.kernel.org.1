Return-Path: <netdev+bounces-221178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BDB4AC20
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35A61B254BA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281B2E8DF7;
	Tue,  9 Sep 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ERnYbwwJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A582307ADA;
	Tue,  9 Sep 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417534; cv=fail; b=oBtCj80ZVtmkJNNQHsJsal5ctb196dA+3T+FKzlogpYJ8nnnAZPLWYlMgSVurJFw9xo1tLk51lO/37KfIfJ7qulKTCCYxj2PJaKJyeIf7awbGYwlCRbhtI3S+XB7XMc9X2wfiQvOsljCFCIWzBw7a2VIAS1Qm+E5GUAAzwpws2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417534; c=relaxed/simple;
	bh=gzhxKxZcwgHLTPN8UDu0UTd/t6asQzZaPRvHchQI9tY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVAc/6jr9VCDtWWg5F0MfxGrir5asuqifb1ing8+j4/poMM9gYLvo/kTmSQG8/CHZ/QewhhXA5R56VEi0vJFNQprsT/js3niGHwChRTMPBJRLiPxAjuKbChtMCBAGwQE+Ijp0pUBBRGH+JZCD977AU30VIkxK/WeuUFxNAT/lN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ERnYbwwJ; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf6CHvPRcZlLOF8FUec0RKaS/2JwKNlxOMCXEcHa5YV0o0AFApJ1FQf2QWrd2+elkxWP2DTCXUimmHhZy1SyYwmAnNTJ/gtsqqid7s/VuUWgg1QQqvsimnmGuwtDU76yYXRVr7SWMv2vmisES9A4R0YWp0GKb15191qr7ELisRw74JR8fbBiQOd5b/nHV3lStnsdkTXJzTUmC9+LjomGKOwYFt49C6PzisLK4nDOFgZAt+3rIF3GX7rawvFATZEeh/LOUW+oKEAdO4IxHWvN1NecQcu9en+67ionPnSPUfqI3wNCbSO1cvHBznHncOPbteWEnEHPOG/CC7O+GFMP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um/CYtq7T8ahKUOW2oGWFFULPoYn1b3KrMYfI4PwTM4=;
 b=UTO92H3a12z1nZEGRoXduDOSAp12Cec/l40eZdCrCjUTy8qByl4YcPseJqAqEskOdSHQuL9gsCJmc0fqZW+Wwycda8BeAh0PaQz4F4xCtAjfMQow5HkvSoaLWIqXpU8Mdh0KT1cQmPQFPW8uwudhUlsw+6yL0k50qC0hgSA+AIn6rn5JWx7MWacYAFxutH+RsxDnbXLg29ElAhO6MaUYUwVJMpE7YMNhKBCvNUNbP7rqBRNmXqCTqToaqFHPqD1JKxrX0GQhmzLFCKNNZntbiiSuHRmyYMOFx2mvnzT+usByor8mBuGO3Vb6SMfFQwL9SNNikalyrm3UUAz9nnxIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um/CYtq7T8ahKUOW2oGWFFULPoYn1b3KrMYfI4PwTM4=;
 b=ERnYbwwJCqiIlj84bO1JOVKYJ/MHQkqxu9lz4y7HlQaqaaE8Hk+BluHnMBRwtg/uva+5JIpiPnR9b7s0/bIV8Gx94UwHQZwWC4+VcqhaFYtlaZQdUDrBP6ZSuDVaEkHwYttBPh27jK1CldfMVrO3n9RH6OBtWCFR1RcU1oYyakw=
Received: from BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:32:08 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::f3) by BYAPR06CA0036.outlook.office365.com
 (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 11:32:08 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:32:04 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v5] amd-xgbe: Add PPS periodic output support
Date: Tue, 9 Sep 2025 17:01:43 +0530
Message-ID: <20250909113143.1364477-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b272d5c-e5d9-4d5c-fa84-08ddef948297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UsjZGYYCxMrKmcugN2Gowxtaun5zefpZQFpkx3SQ0gtjDRB1ElllyzCql9g8?=
 =?us-ascii?Q?fJCITQGBYjCiF9DiEKyLYZA8P4Rx7RuWFbNVKIUxVni+w3OGMdWTB3hFzYX3?=
 =?us-ascii?Q?E5+WYM7Ev6A4tPR1IBU7G3XY61arO8G+Tk1Vz3ksJrSPIOeN7pNstHkqEYyv?=
 =?us-ascii?Q?fdvuhgTIPakqE7lwIYl9N2FlbVhiv8+v/4xBvQLF61GM1cLL3M8JW6acU+gL?=
 =?us-ascii?Q?XCZ3zjlLuvXnYRgOqxoYvlKk+6IvK87O3pBg3nkUN9+wuAENRUCi5QlmEexq?=
 =?us-ascii?Q?+6IQJwG1NC5U1jL3B3BNcVxqDrvertdfhqpLa+WEPL7nRGssqSG9mxASOIB1?=
 =?us-ascii?Q?qZXfz11fbDsj6NxSrbwQMLjlUeG/PUPOhPzCzod7wULF7Qw2d2jXrWwrPAP0?=
 =?us-ascii?Q?A34YRkSFfLsEa8/IuFFVHF80KZbFVcYXvnDz+3038fF29FrrQLdt9uCC2G28?=
 =?us-ascii?Q?f+jn1o3gzdMZkxnsnS/4Bvqtespnap/KGIciCf89uFBanIBeRy/6/hdc0Un7?=
 =?us-ascii?Q?l1Kmg4ts4HzbXlySg8BBVAALz3jGZOlHIFSpNC2OZ7Jvcgc/sJqudwmxJxFw?=
 =?us-ascii?Q?LNff3ob4k180ptmMX3w4ZKhR7lctgiKc6i1p/Zg1sqtGgvvXsi0FuwPgVulH?=
 =?us-ascii?Q?K1BkWs+89vAVXTUe2dnbi4gsoTALt90xy7QnzLCOJbibgK/imPw7X827sSxB?=
 =?us-ascii?Q?CTLkiVRITfPW+5NqiomXx+5BT1Ac1oOurOibJX0SulAD+l4pjELVv4RU3cAN?=
 =?us-ascii?Q?HQEdJqYDf9TkAGOaqFeN8VGr4yOWaI+6p3IWfEE07MhFsoqz7cTHufuzj1em?=
 =?us-ascii?Q?fazb7BfkmBkv2TRWcT08gGGrPnkyscVv+b2MO1P9mcnDcdw5pgmIs1UsyiBu?=
 =?us-ascii?Q?GDrdI5yPLtpEOEidNt5QOGRtWcQjxOdqF3B9pzCqDlhM3EOuo298EWhZvCyF?=
 =?us-ascii?Q?kL2VGBGsgNP6ai8x27LiRbu8uIp/W5tlGO+s6/pA4ZXAfK7sSpugOilHb5r+?=
 =?us-ascii?Q?jSxchKY8TnV7YtH8enxUVW4fqIYiMwtyZvLFZ8T7NE9+B2i68fELzmKWZ6uL?=
 =?us-ascii?Q?laV7TsXhouB6NDLnTJYDBbh3WBqH+1dZm1eez2JsDrxEeZzqqurw99YAEPak?=
 =?us-ascii?Q?xp7GZTJ+Scw7mUbVpL42LP6ULJ+WAQIU1lAgaq9OICoakYlefSvUyogWodzy?=
 =?us-ascii?Q?tb3zwe4q8+wxosX7wHlcKSphDvI2pB23hqq/vT8GcwbTSMjMpxqVj4Ws6UNM?=
 =?us-ascii?Q?4gmQ7XIw3lo1ZpJJqGh8I5RJnlGLdoo1XrZb/m+VmAPrYmt7nF+wI+th3txf?=
 =?us-ascii?Q?aBu4PMOZPH1h3hG5WOdGgTZ15qC3vVRVhzdIDzUQdZeEH7n46OpaqduII/hL?=
 =?us-ascii?Q?MFiojlulMnK6TE/wKDDG3rKh7i0J5vqRVgCwZMfk2eZ0aOivEfiiGVak0Aak?=
 =?us-ascii?Q?fxlR9KCmY24OGu+JOeq2LnlJjiZJQPlVbqMzvimz50kOT3YakprUYdLdqk/Z?=
 =?us-ascii?Q?Dh8mn7pQnxgoKyrs9fxcGKeEteHjiRdXZNr7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:32:08.0346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b272d5c-e5d9-4d5c-fa84-08ddef948297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

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
Changes since v4:
 - define the constants used in the code
 - remove unused macros
 - optimize the xgbe_pps_config() code

Changes since v3:
 - remove redundant outer ()s
 - use bool instead of int as appropriate
 - remove inline in .c file

Changes since v2:
 - avoid redundant checks in xgbe_enable()
 - simplify the mask calculation

Changes since v1:
 - add sanity check to prevent pps_out_num and aux_snap_num exceeding the limit

 drivers/net/ethernet/amd/xgbe/Makefile      |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 22 +++++-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 15 +++++
 drivers/net/ethernet/amd/xgbe/xgbe-pps.c    | 74 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    | 26 +++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 16 +++++
 6 files changed, 151 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-pps.c

diff --git a/drivers/net/ethernet/amd/xgbe/Makefile b/drivers/net/ethernet/amd/xgbe/Makefile
index 5b0ab6240cf2..980e27652237 100644
--- a/drivers/net/ethernet/amd/xgbe/Makefile
+++ b/drivers/net/ethernet/amd/xgbe/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_AMD_XGBE) += amd-xgbe.o
 
 amd-xgbe-objs := xgbe-main.o xgbe-drv.o xgbe-dev.o \
 		 xgbe-desc.o xgbe-ethtool.o xgbe-mdio.o \
-		 xgbe-hwtstamp.o xgbe-ptp.o \
+		 xgbe-hwtstamp.o xgbe-ptp.o xgbe-pps.o \
 		 xgbe-i2c.o xgbe-phy-v1.o xgbe-phy-v2.o \
 		 xgbe-platform.o
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 009fbc9b11ce..62b01de93db4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -227,7 +227,11 @@
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
@@ -235,6 +239,18 @@
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
+#define XGBE_PPSCMD_STOP		0x5
+#define XGBE_PPSCMD_START		0x2
+#define XGBE_PPSTARGET_PULSE		0x2
+
 /* MAC register entry bit positions and sizes */
 #define MAC_HWF0R_ADDMACADRSEL_INDEX	18
 #define MAC_HWF0R_ADDMACADRSEL_WIDTH	5
@@ -496,8 +512,10 @@
 #define MAC_VR_SNPSVER_WIDTH		8
 #define MAC_VR_USERVER_INDEX		16
 #define MAC_VR_USERVER_WIDTH		8
+#define MAC_PPSx_TTNSR_TRGTBUSY0_INDEX	31
+#define MAC_PPSx_TTNSR_TRGTBUSY0_WIDTH	1
 
-/* MMC register offsets */
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
index 000000000000..6d03ae7ab36f
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
@@ -0,0 +1,74 @@
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
+static u32 get_pps_mask(unsigned int x)
+{
+	return GENMASK(PPS_MAXIDX(x), PPS_MINIDX(x));
+}
+
+static u32 get_pps_cmd(unsigned int x, u32 val)
+{
+	return (val & GENMASK(3, 0)) << PPS_MINIDX(x);
+}
+
+static u32 get_target_mode_sel(unsigned int x, u32 val)
+{
+	return (val & GENMASK(1, 0)) << (PPS_MAXIDX(x) - 2);
+}
+
+int xgbe_pps_config(struct xgbe_prv_data *pdata,
+		    struct xgbe_pps_config *cfg, int index, bool on)
+{
+	unsigned int ppscr = 0;
+	unsigned int tnsec;
+	u64 period;
+
+	/* Check if target time register is busy */
+	tnsec = XGMAC_IOREAD(pdata, MAC_PPSx_TTNSR(index));
+	if (XGMAC_GET_BITS(tnsec, MAC_PPSx_TTNSR, TRGTBUSY0))
+		return -EBUSY;
+
+	ppscr = XGMAC_IOREAD(pdata, MAC_PPSCR);
+	ppscr &= ~get_pps_mask(index);
+
+	if (!on) {
+		/* Disable PPS output */
+		ppscr |= get_pps_cmd(index, XGBE_PPSCMD_STOP);
+		ppscr |= PPSEN0;
+		XGMAC_IOWRITE(pdata, MAC_PPSCR, ppscr);
+
+		return 0;
+	}
+
+	/* Configure start time */
+	XGMAC_IOWRITE(pdata, MAC_PPSx_TTSR(index), cfg->start.tv_sec);
+	XGMAC_IOWRITE(pdata, MAC_PPSx_TTNSR(index), cfg->start.tv_nsec);
+
+	period = cfg->period.tv_sec * NSEC_PER_SEC + cfg->period.tv_nsec;
+	period = div_u64(period, XGBE_V2_TSTAMP_SSINC);
+
+	if (period < 4)
+		return -EINVAL;
+
+	/* Configure interval and pulse width (50% duty cycle) */
+	XGMAC_IOWRITE(pdata, MAC_PPSx_INTERVAL(index), period - 1);
+	XGMAC_IOWRITE(pdata, MAC_PPSx_WIDTH(index), (period >> 1) - 1);
+
+	/* Enable PPS with pulse train mode */
+	ppscr |= get_pps_cmd(index, XGBE_PPSCMD_START);
+	ppscr |= get_target_mode_sel(index, XGBE_PPSTARGET_PULSE);
+	ppscr |= PPSEN0;
+
+	XGMAC_IOWRITE(pdata, MAC_PPSCR, ppscr);
+
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
index 0fa80a238ac5..e8bbb6805901 100644
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
+		    int index, bool on);
+
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


