Return-Path: <netdev+bounces-162551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC91A27385
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782F53A2486
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0C2163BD;
	Tue,  4 Feb 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NsoyOJpl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F02163A4
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676449; cv=fail; b=pOSOq8HYR7zzoVOxmwuPTxgAwzb5+j2RLF6rKlL7oICKnqNGqwgXJOF726PHMaT03xFjjkowc2Cr5j5V38eaYLi0qIExPntqShdEXlcb792FKUaVzIl40TkpHkpstM1KvnAPeevOX6HsC0D/ErM6/qei6XjL20ZE701j7w1ncgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676449; c=relaxed/simple;
	bh=0f6KuQnf3lAoFj8vyeruSJEs867mGiX/LhbGUh6duvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSfYn8ZMRIx7uugZl0AA5w65gBzsqZ96Wz2reXnXlFZutsHNM6vnt4Th3JS4wseTa5E9aCI/tbmzoFAJRyognwaj4NqIaSh4NXt8YzM2FIhhN/k8V8Wwj8BJ5mzxbJP1qD5k13PdrWsiDZBTDHqlOqyB6vpqf5HUzpzqjA6gIuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NsoyOJpl; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geYzThca/BSlDMKDVvSrNHSUumAr26/P9UxDmaUiPbGc98g2IBwG/arU914EakmSQ26ahGcW/ZS9o2lnEYmLHY7TmeyYAji+JvNZcZz6ZufsL2YrYEMEIVBjKQftogsHqZ9Nv2Y/ryfFhDC0KGeTWWKRlUADma99CZzn2OtR0/eEYrVWuw7cN6Ypk7qo4nS6p40nyi3xH8AiIz/YN0NE68tbNLSvgTONTN8aoXNu9Rb1AaCS5eQ1yFMoAhmvG1uKtkWAncDH+tQWQUBo0ZN+A9GdC0gCoOTW2zhuPQl+uCy/5bltNC9UVefLhLxbmn4tmpHqNn/fYZfO01LXg53GmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/PueDSaohZAmRfpS1lN/5u8HCGToD/CmpYA1eTSg3w=;
 b=RMX0x6NtShBd82GZHRQffzUwxCvv/Vaf9y2VM9coEHvdb+jajAswqYwMA3bCtAyqY8xSB94b8d94juA4zokdtVmwSac79HLPSOaPSlf1BQSi7vQ4wtVm9BlWK4r9vwlJ0cG9hYfiyTDExKx3xnu0CniwaK7IKWW3SRevDBj39JDtU4oUjjHSkQ7g51fbioJf7loA0NWY1Q5xB8J5jh6EeT0tUY0/6GSQFvd8ROXd6isqoElPlCsJk2krTea9TZfWYG3rsj/73XIIlMYHT6u9Fd8pv0nwaj2OPMuL9vUmAUml4pRa7yUX8EEy3chZGauEuadIIz/1GzR1IywWHdXIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/PueDSaohZAmRfpS1lN/5u8HCGToD/CmpYA1eTSg3w=;
 b=NsoyOJpl9eOdRAKb0Luno64zRz7BgHAt5Ho1yeUVy760IQWC4li8yLieGS1YxB9rzA/11eA940zHCwp2QANkNb4SCnvUJVavQnB51En7eiIYFvlLmfQW5FDmgqEX4mvw3tbeFRDHiJMjFmk+sibZkhTd1QG09F1HinWwMtuG3N1R/IS7Rj7UbJFUCQFagQyh+UjrD9OjgdnODjzSOhhi+AVYUGQWUi8QtwcfwvFVP+q7XCZ0L6DQb9KKrNmIZ3Z3QWg7bluBxT3k976Fl40eJ8PUy/iayMK/9PWFMuF0vu+gwMIvAmn7Ro04JJ45hYOqSarJGT10M4ZVYM3k44RS1g==
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:40:42 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::c8) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Tue,
 4 Feb 2025 13:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:20 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:18 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 03/16] sff_common: Move sff_show_revision_compliance() to qsfp.c
Date: Tue, 4 Feb 2025 15:39:44 +0200
Message-ID: <20250204133957.1140677-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204133957.1140677-1-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 873238b3-ac53-4ef4-1f2c-08dd45218517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CVVoUAkUOYEWQ0PpnPztGKPmatbNiervwVPjmI5vNMH/Z0n8eOHBB86XfdZi?=
 =?us-ascii?Q?aS8VCGO8pck8dLdiDHpGymcahBTpZJzcDwIRhF8F1wFJEaM+0SuT0fe2yz4h?=
 =?us-ascii?Q?icGoe7PJC6G2ZEHv79gpjguc2PJotGjD+nSGvduMn0c9mBrtygmOqq/LeQ1J?=
 =?us-ascii?Q?cSWirsG1fOiDvphuVwrTROZhLQL+BLDzA1P4RLiEXL1PbVRo/rXgmvzRnhFX?=
 =?us-ascii?Q?Xu/dZQtjcIVhBDx9OH/XsiW/UZjFJu2utyjf189J2qmvLjBejUfv/A9/RExh?=
 =?us-ascii?Q?6Z/rItCg4ACgpw4jXsOWIi7M3w3L6XJARkIeDh/VUgkzY71we2q8i/ipIf63?=
 =?us-ascii?Q?1X2tt+VtcnT4TIfV04LOfcvUKtpkMOeCm3H04DaavKSFn+8vG0UhpYXgn2ZW?=
 =?us-ascii?Q?LmAwGlqMUHfEuBGr7pHCd6w5OgJgTFoIdBV+ca8T+/ZpSAx58GRmyd+7cIPf?=
 =?us-ascii?Q?gI7B/n6bAkSUORN06LFbRHEeFO6NUzd6puh0SDtlBlqwgzvxujuU7bVkOYSQ?=
 =?us-ascii?Q?3KfAh6x9L38xp4zLj0dCeKiqOiUo4btVM9IFYYgOL0cUgd74cg5SrhGGyKPc?=
 =?us-ascii?Q?OOKzyEmUWcazPCv9PDZj27TtHHyOj0o8YSN8vCEbN4T34psrkmaMtbFTzu9M?=
 =?us-ascii?Q?QcgWH1VkhHrjQmP/rQg7gUqYk1aAFv5SB/76YWmtwZvMjID0NKdsOVMYSi8H?=
 =?us-ascii?Q?iqVm+w0f3ZPTfz6SbK4Rp4WFD0eCLej5x5fZ1qWr3VlYT56Plkz3mNLQtFSy?=
 =?us-ascii?Q?PtihjsNq4147ezS69dGJOQ8UQYWMPqzpxArVBpXNjUn7t0zUtWP4plT1vudk?=
 =?us-ascii?Q?GQNvY5HM2gQkH/cw1mP+ZQcKQWFmyDWmIo8HgZziNrjSok89Kp0xK/uRWgb7?=
 =?us-ascii?Q?sLqyi6PRf23NHzSpWuRbUnX3OXHzUPM54AR/FDCvr0PlBP7XLgKDXKa5E0pX?=
 =?us-ascii?Q?b0KTgbUOxBOKbHX+K+cx0we/vmq9jSwpJWOrcny3nbIxCkvkhSrwb6nmuSho?=
 =?us-ascii?Q?ZDmcHfTif78agW3lKPk6JjLZGgAhY5VAsEcvPAquXjo+aBqKgJEELnN1cSna?=
 =?us-ascii?Q?Cw/zjlITnK4xhhNc5xqlv0Icz0YN/AY2+vrfBnGDoGKrcblo6XTOinxhyvHV?=
 =?us-ascii?Q?gfQQER/D2MEqWzusI0CcFfBxh5QuVvVoezk6GDQoiR0rFHWng+4G3N39fUPv?=
 =?us-ascii?Q?nY+TdGJeNg63ky4Sovgrlt2oXWROhsfQir/kxCKc4l9Uvyyrwo41UGG2D4Yr?=
 =?us-ascii?Q?RdqKcuApiSPSrI/Pz0tSUpQlaCt7IEnca58Wy5dhkd2w5kC6qrefaLAIOW4f?=
 =?us-ascii?Q?U7QxESsoLzaJop5yAZQWAYLqSkYVKwCxqML4TzQOK6DcXxAgFaDkaLB0qi2d?=
 =?us-ascii?Q?Syk4BbWOptZBS9cJdDBsm/jZcNeeBcp/7eT4a787etxbjj0wbcWe0Zl5LOz5?=
 =?us-ascii?Q?5zXvY5y5b9WcSBqLuuAJ2wf0i26FoUmMfy/nw5lq3jn5nBUnZrMwFWSG8Pbg?=
 =?us-ascii?Q?ZeuBNCm4tZm1I6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:42.3725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873238b3-ac53-4ef4-1f2c-08dd45218517
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

The only use of the function sff_show_revision_compliance() is in qsfp.c
file.

Therefore, it doesn't belong to sff_common.c file but it can simply be a
static function in qsfp.c.

Move sff_show_revision_compliance() function to qsfp.c.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 qsfp.c       | 40 ++++++++++++++++++++++++++++++++++++++--
 sff-common.c | 36 ------------------------------------
 sff-common.h |  1 -
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index 1aa75fd..5baf3fa 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -514,6 +514,42 @@ sff8636_show_wavelength_or_copper_compliance(const struct sff8636_memory_map *ma
 	}
 }
 
+static void sff8636_show_revision_compliance(const __u8 *id, int rev_offset)
+{
+	static const char *pfx =
+		"\tRevision Compliance                       :";
+
+	switch (id[rev_offset]) {
+	case SFF8636_REV_UNSPECIFIED:
+		printf("%s Revision not specified\n", pfx);
+		break;
+	case SFF8636_REV_8436_48:
+		printf("%s SFF-8436 Rev 4.8 or earlier\n", pfx);
+		break;
+	case SFF8636_REV_8436_8636:
+		printf("%s SFF-8436 Rev 4.8 or earlier\n", pfx);
+		break;
+	case SFF8636_REV_8636_13:
+		printf("%s SFF-8636 Rev 1.3 or earlier\n", pfx);
+		break;
+	case SFF8636_REV_8636_14:
+		printf("%s SFF-8636 Rev 1.4\n", pfx);
+		break;
+	case SFF8636_REV_8636_15:
+		printf("%s SFF-8636 Rev 1.5\n", pfx);
+		break;
+	case SFF8636_REV_8636_20:
+		printf("%s SFF-8636 Rev 2.0\n", pfx);
+		break;
+	case SFF8636_REV_8636_27:
+		printf("%s SFF-8636 Rev 2.5/2.6/2.7\n", pfx);
+		break;
+	default:
+		printf("%s Unallocated\n", pfx);
+		break;
+	}
+}
+
 /*
  * 2-byte internal temperature conversions:
  * First byte is a signed 8-bit integer, which is the temp decimal part
@@ -757,8 +793,8 @@ static void sff8636_show_page_zero(const struct sff8636_memory_map *map)
 			  SFF8636_VENDOR_SN_END_OFFSET, "Vendor SN");
 	module_show_ascii(map->page_00h, SFF8636_DATE_YEAR_OFFSET,
 			  SFF8636_DATE_VENDOR_LOT_OFFSET + 1, "Date code");
-	sff_show_revision_compliance(map->lower_memory,
-				     SFF8636_REV_COMPLIANCE_OFFSET);
+	sff8636_show_revision_compliance(map->lower_memory,
+					 SFF8636_REV_COMPLIANCE_OFFSET);
 	sff8636_show_signals(map);
 }
 
diff --git a/sff-common.c b/sff-common.c
index 6712b3e..e2f2463 100644
--- a/sff-common.c
+++ b/sff-common.c
@@ -122,39 +122,3 @@ void sff_show_thresholds(struct sff_diags sd)
 	PRINT_xX_PWR("Laser rx power low warning threshold",
 		     sd.rx_power[LWARN]);
 }
-
-void sff_show_revision_compliance(const __u8 *id, int rev_offset)
-{
-	static const char *pfx =
-		"\tRevision Compliance                       :";
-
-	switch (id[rev_offset]) {
-	case SFF8636_REV_UNSPECIFIED:
-		printf("%s Revision not specified\n", pfx);
-		break;
-	case SFF8636_REV_8436_48:
-		printf("%s SFF-8436 Rev 4.8 or earlier\n", pfx);
-		break;
-	case SFF8636_REV_8436_8636:
-		printf("%s SFF-8436 Rev 4.8 or earlier\n", pfx);
-		break;
-	case SFF8636_REV_8636_13:
-		printf("%s SFF-8636 Rev 1.3 or earlier\n", pfx);
-		break;
-	case SFF8636_REV_8636_14:
-		printf("%s SFF-8636 Rev 1.4\n", pfx);
-		break;
-	case SFF8636_REV_8636_15:
-		printf("%s SFF-8636 Rev 1.5\n", pfx);
-		break;
-	case SFF8636_REV_8636_20:
-		printf("%s SFF-8636 Rev 2.0\n", pfx);
-		break;
-	case SFF8636_REV_8636_27:
-		printf("%s SFF-8636 Rev 2.5/2.6/2.7\n", pfx);
-		break;
-	default:
-		printf("%s Unallocated\n", pfx);
-		break;
-	}
-}
diff --git a/sff-common.h b/sff-common.h
index 34f1275..161860c 100644
--- a/sff-common.h
+++ b/sff-common.h
@@ -132,6 +132,5 @@ double convert_mw_to_dbm(double mw);
 void sff_show_thresholds(struct sff_diags sd);
 
 void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type);
-void sff_show_revision_compliance(const __u8 *id, int rev_offset);
 
 #endif /* SFF_COMMON_H__ */
-- 
2.47.0


