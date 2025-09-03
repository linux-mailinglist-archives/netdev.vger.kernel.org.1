Return-Path: <netdev+bounces-219655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1BCB42856
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8235E480744
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3044320A01;
	Wed,  3 Sep 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CVqq9r1y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D8273810;
	Wed,  3 Sep 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921820; cv=fail; b=NafGG/K+BOXyhD0BY9ZXPSLJK+edcxyynMgNzkVHjoL3lKbIc5iiBM8RPpjgPf/2X3BPIUvHK8c5TNC9a/vk9dPOLa7/TJlPW1S0fCWOmuHTzTGu12maS0jTdaDx71TBB1oQEtigSvs3S6n2LCQdyJMlpIybjr6qZkAyMdL1+Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921820; c=relaxed/simple;
	bh=0V1y0R6ZN4D9m5v2YiOEFhQ4/FotehiqTChJrs0Xdys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ahaACgc3LwN2TPX9xOvOxtleMu0XNf+E+iaLrP50Z2237HcOl6F1fUrPtBb9fPv14pZNm9Om3gjFn/kyqz2L8CNoBhkQyPHUgRzaM7uK3H+3dAWek3eYwFer2Cd1HXrQjJ0fjDSzXWZysmvXGf6jJPkh6rZAzdHUPy0U5pVLu7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CVqq9r1y; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRJ7vTR+Y1iZYsAE5qSst1lvFYlACtsVOYNbsHK2Ngoig8mPZ6GGztd4PzWXZwldaFVQGyudKfVgSW6jlm/XaQT9bCBoD6Dmz/INwUXaAeVWOKboOvC1udYFXClpsETEQqm/bhDrMBeTok88ge4xh1wB418uC6/YjYzc2dhAnyR0giMNAcYYa5kbWgkGq8jrkN+41BHjIvmKJW3XF9MH10vCH9VIxEnnE/XSVfuuYexRq2XPM7+RxbAH/K79372yU17Lr0ocQ92CmJzyNEUXDmmRSkkI9ueq+qVOXKFHV+bPDcHTHA7W1ZNjjzoRJhFmJCqFiY7UyidA4TkjXgBnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nT8qCHt/7aH6AAWvgMF34RTpBEJ373UGB6CA58s72s=;
 b=JjEw4onxEsBQV/Rk3YKL5HkHUcJGvDXVLIVozwSscPMFa4oW8lFoK+84thCUtELCHt+HhxUAxF9Y3C5Q/vacLekQki2b2Qfqkdez9iIbEl81NY1rRMDzZwZzrw7ljAxaFs1DFmMUuc7vQnT6sZQk8nwEwEaalxgriptxzFLOHuDoN1K4OFtCeybSceQ/DIUQiqbjL+3z40cmzDU+O16cfJJp+XZ7wcQO3qYQaBNxZNLPKtRzczuaP7pUwAOJob2WVHeNUCPeJw7J8Ks3fM4WR4I3emDtTskjF+TLh+gOYQojcDeatBsL71qbAYr7wru3h3/YiWtfwmgnjVx5F3SGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nT8qCHt/7aH6AAWvgMF34RTpBEJ373UGB6CA58s72s=;
 b=CVqq9r1y5sJY7294LKje3CzQdU31egPmOqk5atPaIKNZq+Io1FasVavyq8CqbVF7PaQ3BjChsb6FixInCpnOtN0/Qyavxcd++FT6Y8haG7CPhUVMaZpx9b7EnJcBP7vuqPX/JmBm6dKKtEACsf+uxWKkJ4jXihtaeYdw+tCcVCw=
Received: from CH0PR03CA0442.namprd03.prod.outlook.com (2603:10b6:610:10e::32)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 17:50:16 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::c3) by CH0PR03CA0442.outlook.office365.com
 (2603:10b6:610:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 17:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 17:50:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 12:50:15 -0500
Received: from airavat.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 10:50:12 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v4] amd-xgbe: Add PPS periodic output support
Date: Wed, 3 Sep 2025 23:19:53 +0530
Message-ID: <20250903174953.3639692-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dfa24c-5b14-4606-acee-08ddeb12572a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a9RAwRI6MPUr6kQyJm3eReRUopMmSUiyWqsGy+BvE+M6vQowVc5JqZ3+3wEn?=
 =?us-ascii?Q?UxlMSbA47z7jPr+4dKbmNPC2xqkXxB1oymAKn79cX3Q8DQ2yZvLoU+3fkOlX?=
 =?us-ascii?Q?IKo4eBg61J8VLmEYgU5ZWaq1UU4t+yKSdjaIEyn9duQGnriRGLo5QOy4eouG?=
 =?us-ascii?Q?a9rWk4BynnasEYQDYorelr7ybl0J2/qk0X1oLTBeYqjmQHMIPEWZETUtEP3O?=
 =?us-ascii?Q?AQxjMFs+uACyMZvsaAtjQYhmQipXQzV1finojOAQpB9/OU8uH4rJBEDnMrU9?=
 =?us-ascii?Q?kOfKUHAJZhZfER3wzgkb4r8MpO6qQgsrM69dIq8zAMy5aLJa7P0CqzttjLKP?=
 =?us-ascii?Q?VYSdhzcJ97oSDR9ae89WcO2Xc+YbH9q7VOJ/siGu8+tJ5GSOkyhO5w80NH9j?=
 =?us-ascii?Q?kDZMTkL9O33v63gd97mCkYA1wOmr4x0LBKc8srVmrFeOlUEZ2d6GkkHt0E/C?=
 =?us-ascii?Q?lp2O+4o+wVQs17Ef7gn75tYf9UhnpFwrNJagscVA1bxfxs4JnJDENrYzLbZW?=
 =?us-ascii?Q?Ui77Lq4SbOXN9pdjkn+pw1MRKQuqSGxUDlhNgyvy2EsRGJDrbplUfYSXfZ2R?=
 =?us-ascii?Q?9nX1mL8rrkJpoXK+qjLsfWre2XJTWVWa6EK+uxCz2fBJnEHUrWF71JmXds1z?=
 =?us-ascii?Q?CKmW1KZiSLDF6bb7zkcnKnlmSil6eeyYIvSQPxKeVOsMik6i9K2PeMvqertk?=
 =?us-ascii?Q?kbInvExIm6ZIdYg4cC09fxOg3/QIJl97q2Ls8Bd2Vunv+5sqP7YHioIXmVBJ?=
 =?us-ascii?Q?LD1LtfFGjFICoNX5Pr0SzjKthktmuFQJBlOQE9SFfUzljUtQG0uDwNYvH8dE?=
 =?us-ascii?Q?FcKQ63WNxK04WwIXu8Tk/2Sowq/wTcVI25jXjRcl1rNOq+H+aF1l/6POfcdJ?=
 =?us-ascii?Q?tUFxcXna1ub/oJISnlLWUtP8uhEL7nDKSzZe6qJ+FDxw3suMNJWbtjYfVEnD?=
 =?us-ascii?Q?r795LFDApAhBfEjSDXIZqpyXJEfoiP10+dc1/9CWKdwg8xDoElU9k/h9Z6gE?=
 =?us-ascii?Q?WgWAqcy3U4+oE8odnJo3aF7balo8v8jaK1xWHNog5lO75bbAdM2LjmPl1uOd?=
 =?us-ascii?Q?orcmcImvFxaLMMW2UPKdjH4GSQPUGtbPalsmElIJfLfDT7yHUxfhp70ur6NZ?=
 =?us-ascii?Q?WcgLAKxw6xNTEbl4b6SkkJfAvm4S40XwsDpttMTA1izvYOWf1casbVck6Alf?=
 =?us-ascii?Q?yX90xPI02Pl1mZPTKOicrpp9JYghmKXhLyjOI0887o8XVIfQ4SS654KwufpX?=
 =?us-ascii?Q?Mbol+N5uZTboeiYIBx9acwsOFS9J6UlzlqwpfutbWj3DQF2Dndhl2rHfSmHy?=
 =?us-ascii?Q?q0q4Jbn0VAzt9cSPytbnfsUpFESuIxEIfaX1u6vRCxTvATISDSIub1rfmdMY?=
 =?us-ascii?Q?KvmfYYgEDhkSrNmouEMPxUFpnP+JTybYjvnIBWgQjUeIVbDi/Fgczgl3Eorn?=
 =?us-ascii?Q?cYrtFJJQ8EZXVSl8J+AUGE18CpjObX9082q4fB2QdKKRE/BcQ7B7nKjCKp09?=
 =?us-ascii?Q?b26xgT8p8SPr6Rm+5AZq1svfkdCKQ9ITrMqD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:50:16.0022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dfa24c-5b14-4606-acee-08ddeb12572a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

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
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 46 ++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 15 +++++
 drivers/net/ethernet/amd/xgbe/xgbe-pps.c    | 74 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    | 26 +++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 16 +++++
 6 files changed, 174 insertions(+), 5 deletions(-)
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
index 000000000000..6f7f1773312b
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
+	unsigned int value = 0;
+	unsigned int tnsec;
+	u64 period;
+
+	tnsec = XGMAC_IOREAD(pdata, MAC_PPSx_TTNSR(index));
+	if (XGMAC_GET_BITS(tnsec, MAC_PPSx_TTNSR, TRGTBUSY0))
+		return -EBUSY;
+
+	value = XGMAC_IOREAD(pdata, MAC_PPSCR);
+	value &= ~get_pps_mask(index);
+
+	if (!on) {
+		value |= get_pps_cmd(index, 0x5);
+		value |= PPSEN0;
+		XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
+
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
+	value |= get_pps_cmd(index, 0x2);
+	value |= get_target_mode_sel(index, 0x2);
+	value |= PPSEN0;
+
+	XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
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


