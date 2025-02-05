Return-Path: <netdev+bounces-163107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B8A2956D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604453A6598
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00183193077;
	Wed,  5 Feb 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZPqqT+MU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489441922C4
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770941; cv=fail; b=oWm5thUdwRhZd4P7ZT/ISkJYzm0choDYLtXGexfZ+7F3QigPTwBqyQjANUboAC5VVtsG7xJlVO8Rk30CNWY+r4FPd9zHBsjY2VzwelJkeJUa6JJ8tpQhYA8J8JAaTD7u7Gv4vTkkL85b4y0fMDhgLaLtHv+K+ndSR/ZuVUlIjZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770941; c=relaxed/simple;
	bh=0f6KuQnf3lAoFj8vyeruSJEs867mGiX/LhbGUh6duvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFFa2IOl33zBCndh92dogVTwrFsyxSv7ycSCiPiGRlQ1nM4dUexoTf4RsTf1O/8lhmt7+w12z9Ck4/jr3uSw+J+cqi1jSD+TOh7PCM0z37gFaownx2GfvbFektcZQuffRYtZtwgMzaXw1PgiaKtnqqdXYmlr7qiaZ5szzd0LXoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZPqqT+MU; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLmcOwOlK0ld/zaofnfU33fRtchaisHE4DeNt4slXM8DWG9CwgiLPMKkYxssoC2MESFiEKDoWEHcxgO0196E3q8w6osw1VC7KShAeSr9w6IB7WZiHQ1Jq5T+rG8JLA4JzA7CtPBdJxvVEKOk5e/qKow5XTBfwoisJa4mcWesun7/hwB3aQQ06LI337aVCFk7linKEAj7cQbGMRrmsYIlkryONwr3XQHYdhZ7UHwRjjOMvgdnZ7MgNxI6jOVNdu1i2nV26d33D2+vG737E6a6Vh/kOEYKRV8w6TRuUgE8exSrYN4IeffLln4swKkM09WcyBflBdx0qrJQ0qwurhsakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/PueDSaohZAmRfpS1lN/5u8HCGToD/CmpYA1eTSg3w=;
 b=D8sZ/wGIaB+ZzC6Wq/wZM6nmsMlxRIcoeqqeKiZJxQvStWtTRg7FgQzafvNJVzxE+q/r9oS++7NMyC55kagIkhbz3HMLYfVPeLw0XGwKfoWQ3Gijz73+INp1ABhyQv0IqigG3XqSOYA8H/APb/T/ap7tkS/C/8Ks7ieh1wsQJ83gVPtIyD+GnSdNxkNh404yiKnvNuUf300lhGuiRT0b2Qj6VqHsmFSwNoiZRAoQExioxWjWL8UQeGT6rfpsWVFPKn3QdYLo+KvHFaBsEXf77/Y4RcQp0vN6QHiefcIGzCl2+LAb3Bdl1M16zLtnr4qSWaXa8XuWe7UkOFq+UmO3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/PueDSaohZAmRfpS1lN/5u8HCGToD/CmpYA1eTSg3w=;
 b=ZPqqT+MUwBiCOYWy+TpJCNRarVBjFnV1DP3UFJU5DHcGXMbYz9m1Qf5gjWdkwpP8CIe8MrcFULuQ3iTh1yYw93AKeXo/Ev8aZHMIMw5uyeCXsqBLVezFCUv7SegiFtK6m5CsgoGGvvzonZfUn37BukXJlxcWmD8/VVvzeDPEIdhr6eCItHRak4JWpaJjR6AxcPXHjwpPM/ed0p7QVhfMhMeNPkf5nCjL7FLJioqYmmMJS5NUDSmyg4QpIpSOsdKbfPHvyjpuriqGKLSHciGXIiCOTusVXMJ6VfqghZpNmzqxDnRBEkQnD6slnK7X4nWYZbi9uKwNPuQw182wsWBxHA==
Received: from MN0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::16)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:55:26 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::bb) by MN0P220CA0018.outlook.office365.com
 (2603:10b6:208:52e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 15:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Wed, 5 Feb 2025 15:55:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:04 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:01 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 03/16] sff_common: Move sff_show_revision_compliance() to qsfp.c
Date: Wed, 5 Feb 2025 17:54:23 +0200
Message-ID: <20250205155436.1276904-4-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 1370ae35-b98d-4ec8-39e0-08dd45fd803c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/o3ibIqHT3E/i39r5h1QRxATSJHvSkPpKOQaG7JWghO7NkiSy1Z4thnFxRAA?=
 =?us-ascii?Q?dghYLG5+SCbJk4KosCDfPbI6SP5+KChIaW9lpszT9v7zC8OwMcfFgbjkVzGu?=
 =?us-ascii?Q?9OUrAy+44Sm5M1DXh2Vj1hd6GM5iidbvl8nEPSA9RJJ+dWGsqC7uU1xN/3k9?=
 =?us-ascii?Q?PBGa4ULtD5olaSKsGvYDFFbHtCXwG2B2NDUu9IfDvx7UM6tYe7Lt7Pw/Olcs?=
 =?us-ascii?Q?mSfVUeZVIc8JcLxUBBQEv/qpdSTvl+wOqwwNmL7/LqMW+QVscz1sQ6UoNx+1?=
 =?us-ascii?Q?Zj/s8O08si12NJE/8ujG7CsPIz9RfATBvhjREGL371kKiLOg3hOGGBaa5lhA?=
 =?us-ascii?Q?sEprBoDWk8Hv8cisoAfMLw1WJ+G1DmFtuHjONNwa4JlTxHL67Z8BLoeJsjbT?=
 =?us-ascii?Q?BBViOGo1IblImQJYZkCYMVm67N8GcLp7nVykLQBu0N0kiMq7gM4XJpAoAA7e?=
 =?us-ascii?Q?Fbtc4maLJX+X1qQzZpd1pstXZaGL+rKOyTuD12cOZp3au2DQ2HAKignnqfDS?=
 =?us-ascii?Q?76BZOdRIaNyEqg+qNauTPDPBpAd+e9BYtnE9jYZAIRUOMv35uvLL1cEsJf9k?=
 =?us-ascii?Q?JWe1DtO/jlAqSSVy1p85Np7HL2sFmhdo5q9St9icUJzmRM33GOc1rZfsrNdU?=
 =?us-ascii?Q?ZACqlLrjdCUD3AyGNgpNs0Q6FnaOPERy3U4L2ySKDCFnN+NWa9UrNBbolG4Y?=
 =?us-ascii?Q?w6xbo5kBzpDX+bSbjtOjuZAtOegc8a/eOSz9qDdxUCO37hz4Vis5fBzromfC?=
 =?us-ascii?Q?w+hyS5rN3A6MA90B11NlzDaA/5M40CeepFT9x55iSc1gjSJDB5zupqK03f4H?=
 =?us-ascii?Q?ah1Tl4mUZn5hQJudrml9ygVP5jAsEVgQ5XCzDHLlC1vneeYzYFclvw0QN1Rd?=
 =?us-ascii?Q?I9BD2DT/VGCto5v8AySZ5av97xe03BngJqUvggX0uSyLPHA+wO9VWtvLOrCC?=
 =?us-ascii?Q?ayMzOKhYV0rqo+8KVNYTAoeWRRsgOQQpb36l0pBmzxq4qnS8I/10Ml4wvayY?=
 =?us-ascii?Q?KTw53h7datagnE5sEvEMZzxWn4J14t6nYX9j9Nl3Mgb5eXN60ZCNIDGnScSt?=
 =?us-ascii?Q?YD0HKo1OVYPsiZRjcybVjpT2cfj9ETvG1HdTAN80pLFyt/o91T1i9u9wgpsj?=
 =?us-ascii?Q?ghDZv2j5FKE5B0loQbiqGN/3CCCxT8NZaHp1dKEGHXJQ0RDhbWzbm8S0IB4l?=
 =?us-ascii?Q?N/2b6/xs7rDdLWsQBylm38+oW55RRigDx6+fAIVu+Hkp+a5j9J/JbvORsMti?=
 =?us-ascii?Q?ZTHfqs+sZr560Wr0JpkHuLP1WzPrAK/pBVAOlJMRPHGQD+PaIWnnNK03T7Rh?=
 =?us-ascii?Q?NTU7h0LaPiB6YMN3gnx40zPSrvEEB+cXn02N6QpQqLMH8Si7pxZaYJDNK3JV?=
 =?us-ascii?Q?OvpJCvb0jq2NzRUj7ezSucpe7a0md7+WhNLaq4sHr8pASQziIQpFMeV4EAck?=
 =?us-ascii?Q?KpOT9ULa0jlHUiX8dI5b5sVbyotfrQSuDd8/XO880RN44/CFnHXhssHW1r21?=
 =?us-ascii?Q?Am9PVxIeGh20GI4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:23.4920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370ae35-b98d-4ec8-39e0-08dd45fd803c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

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


