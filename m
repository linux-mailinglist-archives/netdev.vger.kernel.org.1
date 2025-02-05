Return-Path: <netdev+bounces-163105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA636A2956A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A893188509E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB354192598;
	Wed,  5 Feb 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RzMkaRyy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7019068E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770935; cv=fail; b=m/uFdYAUCkxrIaGoPTSsBdfLTaGb/x/cV51ejlU68gxoiIQawIhHIGmyNTRHcExUPF7hwbcyp9SNDXD/CdsI5NkF75UlGdcceUzgIjUEAn4vqYI16f0lcajPalJWIURCnHXECn8PSbyhKI7qzf7arvYLLx9qlkbeoedq1y4hDYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770935; c=relaxed/simple;
	bh=ZHSSEtEeuHoIju1YAj1fdObzJg6neqk5rEqhD3FYP18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tToaF6dFYz/cwWx0psIYZZ56aC9lhjnobq39kN4sQelcPoNQ9Yybd25aV4qDvJsWYZe8+96vTqWInB4sotE8PRlJV6YphKY/9vW4IO0Mw06Zv+jyvBZiHzm2R/s2WW5+Mmwx4+G1CHkOaljlhVTKnSsbT8gCchkPJQ5i4TWVtqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RzMkaRyy; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEB8GhUGc5PIWVxpy769mF4zyoBCcHN6pUZ7pWBPIcq8mYDOpBBk1OuuMOv+Eafn2jC8IHIjM8eOdn9ziKOmQzVrZjF8lqOM2kBWTfh9o87GGB/1IJyvygW0PiFy7P2NqLnSUzsGnKhipKwutccj/P2G6Q4gTQLSsGBMkzEpREMmQv0KbNV8aGXOPpKoqdJ0v+RTtuc3UkDe0hHAjQKKMkAJcTVvNcJK2v4iCVEGWbtsGd/blS0GVjj9JrMx5xzq0EqPQAIF9Xe9UwwXrWuOZm3WWy5B5oZd7NIrzGeLr60xazgBb/GnuZ1+yNIAc9wzCGYR2aj2NlkMiTluCQQYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMd7JNSG1MXZURwkEpUYq6oSlRvrTzhriiIBmJssAWc=;
 b=SrdLrCsjVO9m62W/EZwK7R6t4yLCjuZZN5LOf1lWmDugUaj2ATJ6NqvwcjFR+it2NoFavEAK0TX5vaY9VAqMTKGI1DZrdSnw8Iknl9T6O7mDhWStUpB42dlDu6CzKgyu+3mEu2HXW5rq22bWBDqe231esWZRsmFvwnULgHvBeXijPCFLF3H/flKm2umcrmje2eCUEO9L2lvtvwFYx3Zl9hcaSYxoXwxFFU3nJAKNvOenQcnOUlCDP8hRs+YZsxbh83X8anI/sOfQ3TkMAt5ntFjyXnN/5D8+dfPUmxOvm4gS1iaH/SiioprubCNhJkjjdE9sqJJIlV2ZGHt1Y5ltEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMd7JNSG1MXZURwkEpUYq6oSlRvrTzhriiIBmJssAWc=;
 b=RzMkaRyyXjbrNWPJezdgFO4VGwaOuZHiEQdzjEfnTa/DC/g4OWVVVA/DfSp6NKo2LP1Mb1/Ibu6MXImXA+kqBgdyjUOPrkXwGgZ48SlaDAK6u2HENqRT+Me20nKvrdHNnMjdh9aiiwO69uhvGvlV1wDRbMcFpMCI+2y79HlysJzy55/qRkx08G3RE2BylYUszOWodGT1F5Xc5PQAm6xZ6KSjf4jOdQ08bNukusBIqomJtUcABQaSiPYQK8b1DFCqwjko7p72Zz1dPO2m+ncTIVqzog5wXXB0zhnTeb6P0qD/I1FBVC9X/m+gtyXmIgaKKrKz4+0UKbvnCAHhEQ9M5A==
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:55:27 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::6d) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Wed, 5
 Feb 2025 15:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:55:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:08 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:06 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 05/16] qsfp: Reorder the channel-level flags list for SFF8636 module type
Date: Wed, 5 Feb 2025 17:54:25 +0200
Message-ID: <20250205155436.1276904-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250205155436.1276904-1-danieller@nvidia.com>
References: <20250205155436.1276904-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad3f33d-2c19-4be2-a7f3-08dd45fd8245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MFBfiMFG97r+pAZJGqQDPg5KiQB868gA7zKxO7ChrUXSHEwPGe/AbasRXdjO?=
 =?us-ascii?Q?XfkIQtSRaS0K+CexYX7xw5U+J2Rb0z9OYnkwjy4sMPrhkC6qBgC4xBK9lpbs?=
 =?us-ascii?Q?86yJob1J7qTznocaQHoan02VwtrjvAjIQCi3mPZm04AwHgBHtb94ER/bwe8J?=
 =?us-ascii?Q?1DlCA1AjxxRsvpEYJlxZuUBst9LljCiQtljssMXpMD2jPGgsWKOcEh22BT8C?=
 =?us-ascii?Q?T8P9omr0QgtG0PL3FMYWU61mr0Y2MA9eOSE2C+fl7ZLw04MsjPouclrIH+ny?=
 =?us-ascii?Q?Q/uFhDlTQDkYyua9cEJH3E4IDS0nkRkyMQ7KDjA3E0Pchc055eR2jelc/iTT?=
 =?us-ascii?Q?Xij+JncdbpMJhnO2iVM5B2VowzF74ldjEZGw9yO7ooWh2ikbFdM/sdqn6UJI?=
 =?us-ascii?Q?gcny5ZtfREUa/PTvZwehst6s7QKOGs5NKpt91hbEk1IcxhG5An3Cmef1ZNaT?=
 =?us-ascii?Q?Alu254Ia9bKiDIRM26yL/+BsFRHv0hyuqzOZLb6MhvuhyB8q1+asl2CzAXbK?=
 =?us-ascii?Q?qODAaeO1ZwbrIAUCc3OOKl0I0Q34UolkYUtY6y3NphhWLojDxVuCvoIqNIOm?=
 =?us-ascii?Q?fkvWgXNnkPa2KLIwMMSGiVrkoi3Olz3ZCkqYVd8XoXjxclcrQUOwni24k+Ui?=
 =?us-ascii?Q?0svCfYuYykJQDlkIZnc9WAa3Lkg4Bt7/piYvauRX5xF0udwIZpw3YYLZWwzs?=
 =?us-ascii?Q?n+Xr6hKTnjKLegLhireQQDbemxKP+AhCx6b2pJfBaPWZcVFmJn2zL1v8DJ4+?=
 =?us-ascii?Q?9AFCMnobngmjadMGyZhFL09Q5Mf5Ukm/j5BdICMpw6/XDxQcPCdla7OBbp47?=
 =?us-ascii?Q?vUJnuglOmGcM+HTHrA5FQnJH7/GpCJd+AkAhCPB/uWCbvb+EF0wmZ4B/lMcO?=
 =?us-ascii?Q?I3jjDAaG4JCUZHqwclODz1x+96b7Ji9Z2/KNbEaKEYettGXqJxmoBX3K4lLg?=
 =?us-ascii?Q?e50wgmrE4ZzlBbOdAazIClpgSW/p0nz/3Mrb31kAqA1aRixJsXjXjKQmmgf9?=
 =?us-ascii?Q?75I6LZnINDJtEMftwBpGs9dMKIyE+UvMVttfUA638UJ7iPZXr68Mf1/v9Myq?=
 =?us-ascii?Q?eVVugXfMQirESsmjqwQMqwTcWuppaCnndiFR5asZRSABhRajheSe0rW+pS0u?=
 =?us-ascii?Q?EEZRoTU+LqTKsKFqMCfhvvIFXje9d3mvTsSEoIkWM8YSg7H/csxSEsQEv9ug?=
 =?us-ascii?Q?yAbo895jKI41MnJI/ts7sceSgR4QJPvrnj0RnwgCMa4bJOzt+sV/yWRf3b2Q?=
 =?us-ascii?Q?dKGdtur29Iajt92UmoAnaSoraQD0/OxpoSopMsNz578u/cEpXn/mRGM1CK8C?=
 =?us-ascii?Q?f+qFHYv771X4w74Q1ZHRH8Hj4Lxtr2GT9x4p+saHJI/nRbQZfhjLbuhpqqZJ?=
 =?us-ascii?Q?aOFwpScSc7cuwFEe7gVleGihYLhdaCoLwrWy6f/pjMhERNUkg2O25Z4ooqrc?=
 =?us-ascii?Q?PUEW4l4CDJAnVYRAEHu0nQWZhaYAMq2ClShcVPAEO7Qcyiag4GCPyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:26.9092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad3f33d-2c19-4be2-a7f3-08dd45fd8245
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589

Currently, when printing channel-level flags in the ethtool dump, we
iterate over a list where each element represents a flag and a channel.

The list is structured such that, for each channel, all elements with
the same flag are grouped together.

To accommodate future JSON support, where per-channel fields will be
represented as an array (with each element corresponding to a specific
channel), the presentation order needs to change.
Additionally, the hard-coded channel numbers in the flag names should
be removed.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Simplify sff8636_show_dom().

 module-common.c | 168 ++++++++++++++++++++++++------------------------
 qsfp.c          |  17 +++--
 2 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/module-common.c b/module-common.c
index ec61b1e..4146a84 100644
--- a/module-common.c
+++ b/module-common.c
@@ -87,112 +87,112 @@ const struct module_aw_chan module_aw_chan_flags[] = {
 	  CMIS_RX_PWR_AW_LWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
 	  CMIS_RX_PWR_MON_MASK },
 
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 1)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 2)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 3)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 4)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LWARN) },
 
 	{ 0, NULL, 0, 0, 0 },
diff --git a/qsfp.c b/qsfp.c
index 5baf3fa..c44f045 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -711,13 +711,18 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	}
 
 	if (sd.supports_alarms) {
+		bool value;
+
 		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
-			if (module_aw_chan_flags[i].type == MODULE_TYPE_SFF8636)
-				printf("\t%-41s : %s\n",
-				       module_aw_chan_flags[i].fmt_str,
-				       (map->lower_memory[module_aw_chan_flags[i].offset]
-				        & module_aw_chan_flags[i].adver_value) ?
-				       "On" : "Off");
+			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+				continue;
+
+			value = map->lower_memory[module_aw_chan_flags[i].offset] &
+				module_aw_chan_flags[i].adver_value;
+			printf("\t%-41s (Chan %d) : %s\n",
+			       module_aw_chan_flags[i].fmt_str,
+			       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
+			       value ? "On" : "Off");
 		}
 		for (i = 0; module_aw_mod_flags[i].str; ++i) {
 			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-- 
2.47.0


