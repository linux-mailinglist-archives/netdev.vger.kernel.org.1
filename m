Return-Path: <netdev+bounces-164612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654EA2E7D8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08EA1884493
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357B1C5D58;
	Mon, 10 Feb 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0KLfScC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B71C5D52
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180037; cv=fail; b=cR7hoyj7EydV6mH46YJQRukP1N4avdRLsMacoUGdG4M1NxLrzrd453ZgTJj8mhP1bQ3WBqN8sxwehHz+CCfDJTG2VShMO9fHObnpX4O0Fcrz5sAK1cEtWTLK0MnkX0JqSiZn7dPLg9buBIENpPMx+gWvukTkYulIfaVZsmgFuOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180037; c=relaxed/simple;
	bh=88uLZItevA9gyxjPG116f5AI7I5RlkEsEuZvGPsZSoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWWm6BgOB6TEOolOUkYXwVz7TPN15wVPJ52cXL18ahyokZcDSTJu71/pXIMqIem7gIduIU5EbDyK2NF5x/rSxUYPau6o0GddjF1jaECIqDPgXOaNxSDyOPLmltrBtpbK+lUtPnZhcpBJVOcoUSCeZL29Q9EPE5efbtq8Dkqxm6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0KLfScC; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga6mpiiUovNBN24p5o7qAQklCFoRBQB5iia6LGlGkRoYRFGyDXUNMwt0EuVpSOlUQQbg7OlDGCce1XBWC56HSPL8mFNs0lnYnQpaNmwf5/zRswtV+oKgk78XSFjcQ9BQta2DEnvJGXdfinqg8c/oDTfuazlk3PTTb4PTxSWdC6GGAgizHwu1ujlsoA77c+wMUuh50NXIJ0rj2Y4aIjKfBaIKfpwxswVS8o80gZQf9XfgAaeLR+aRe0TgzwJyzmmjl8jSccDZghWtqnXzOSVRCqFej3vTxQmSLJRxbmC1EEIgf6zxS00o33wFBDylc4DjM6gy7XggVnYmxS9aLUUmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdIUgVVW+IwtZBP3MIqDcEckLD30HABukYu3BVrLEdM=;
 b=aSAzmZVHvY9WEB6cBfCr7WGMnnkYnOF6d32RATACzalxaudoKg1Uh43r+wxNkJZJFePCtBEhdBC61ElTCrrsSA96DQOjprzXDffA+bxJeoE5nN7gUrU2vxuThLq+G86IBj487Qv/mAF5wv8qsNBdKERECPEAmWjMSPSeCp1lR+4XtlT9QNOJnnRwAiAcXYfqKl+cQljl8MWEVhgzKr+tMNuC+zPN5ag8i2FBeebSX+7FQUgWJUv0XLZGFYOWiHhrDbTTp0E+juuLfQTiEC0JJDv3fOsRL1KVZGCyeDsWW+Psa10l295KUrQ8fZqEYvsPmqpeHpR5WQGorzFT8LU62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdIUgVVW+IwtZBP3MIqDcEckLD30HABukYu3BVrLEdM=;
 b=K0KLfScCcjFbMj74MJ3lLlsAI+NkkkuKrQo5OKjGQ7kritYmCbl44Tqc1HxVtVnjQC7Fk0lxmJVFlKM8jutwhPeyMZ+1ME6uOhjEz9Qux3HfjXeng8/UcrS2lhilBRN9I1B/0gzF8XRkiiY1ocs0FWpKQRL3VQXrpSaYZ4V+defcI6BP41hS4OQJnPifwKUkdxZjJWQnErQ5NVTq/7bwt5Y9lBklBPJ0+//IdzZ5qtg4tdWBklEndIzpoGc35Uzxw8mprnArWE8n3jzgRXho9l3JoVf5qnHwGzgQXE6oC7P/8kIdUJR8PS28r3vV4zYtin5gsCk8jlYgwFN1CR3mSw==
Received: from CH0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:610:cc::35)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:33:52 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::49) by CH0PR03CA0090.outlook.office365.com
 (2603:10b6:610:cc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:33:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:38 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:36 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 03/16] sff_common: Move sff_show_revision_compliance() to qsfp.c
Date: Mon, 10 Feb 2025 11:33:03 +0200
Message-ID: <20250210093316.1580715-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: c0050b0e-5333-4d74-97d1-08dd49b607a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CSE6pmHRKDjEnnmtGNBP67pc5QFvnL+AwRQeJyYdlYmnY03sO8f1vmlel6+k?=
 =?us-ascii?Q?MK5FrRD15X96f6mKPEZXbyMCcD0gGJZILs2xKSNWA5yjugvUovRoLrtRbbjT?=
 =?us-ascii?Q?ME4evg6J5QOSNoSAZvPlgh9DNV8zEN9zI1B2spKG3OE/osdn25YYeFBGfulY?=
 =?us-ascii?Q?FwaqfbnG6BsbpSq8h/q3yX+OTWkyWmOWK+rjSDFd/m1r2rTZgQT6SWKrl2Aw?=
 =?us-ascii?Q?Aw/v5Jjuni8nodyyzqJxzBY0N4Ysdkr+2NJMFX3RaZk8YD7mNLZX/RHrzaM/?=
 =?us-ascii?Q?YGDatbDgCL2rQrQXmTzjlPWmMH5bRT9N8Gen7hGp2hpIb5/s+7LkxYg21nnG?=
 =?us-ascii?Q?VDuShIr5wV7o5u6n6K3nNrwvZOjrf73T3kUb6VHtQjq5Yj6W/h558Gyqfu7X?=
 =?us-ascii?Q?Bo7dFzHpIw7mjsFM5LxtxGr25iv9ynZjx7QK43mb9B2yw0fy8rq+Ue22L9G8?=
 =?us-ascii?Q?23NUwvOSWtuSTyfty6+wFDZKndQvn5supYsYQi3kzxaBwhH83R/wsCKEgs0g?=
 =?us-ascii?Q?OX7XKQ9NP+m3/MDf7WE7PRZgVk4bQH3NUyxl3WpAPLnV3oey94alWN1K2isw?=
 =?us-ascii?Q?QpyxMhTzhmwtFgCCryAzoDTctgZ6s55iFMhAGaV10UYzkHuSWd4EEsH1FR7R?=
 =?us-ascii?Q?zPnmYlJ2eIMl5msu3ih3q0l5QMHPZQqcTlotLHHXW1Pz3XkRA1Tutt8QbFFd?=
 =?us-ascii?Q?Hc5PWea54EAblH/w5MBb19MeXTMiHUBEN0Ap1XXYBgLPLPeMoeQmMmde2jV6?=
 =?us-ascii?Q?0RxeP7sDRsRkO5tuuhV7xU1QIOVVl2JRcUtzhYomSKsICTeUmN3TJIlKGOgH?=
 =?us-ascii?Q?N41QHuk/AxNQ5qSdzwZ1fEpPKlGgaab0si+qcGeOfdbv4O7vnGCRGlDjKG3e?=
 =?us-ascii?Q?mX3Ly7/yg0k7CrbIBjoAgu31WM95dqfjFiKolfuidzmMzTBKIB4UO/e0Z7vl?=
 =?us-ascii?Q?VJSS9eV2g/2wVlKEKDv/X4dWij/HVblxpZ7g7fsfa57HqXYeronSFaefMGpI?=
 =?us-ascii?Q?D2CTGdFryM2pkP/Ep1QfeEqCya9uktLarCcSGy4mBzk4wYHif7rj4l0jo9ol?=
 =?us-ascii?Q?Sw/Cwbg7gz38UzKfknLHQkQLlvmc/qoo9wGqH3s1rGho+dMGbLkmrZE4Qbc6?=
 =?us-ascii?Q?5ve5ugJHqGwqR1apVpJh+CNpmf9HqVPLoEPuhxG1DH0zUiCRD/U2SQmcUWl5?=
 =?us-ascii?Q?06N0AghD1AO8O8ZF6nPSrIryoWZfzKEwKTKqFpWXtpHdOpsckfR5eOVCOpdU?=
 =?us-ascii?Q?dsSw9RWm0k4LtcOzrgVWN0EYhJaaJJZvwk3oiOOPTgTGSpDRd9RNKwILbb9h?=
 =?us-ascii?Q?Gia4FfnZAYaEFn7UpGsdrbDc/gA0Ow8GZwUJZhDlD/mByt8krBFxoev3if/+?=
 =?us-ascii?Q?9dqM8CDcDdO5m9YsOh7cr2wAxpoiZpFu4SVvo48Yz7QUEV6UiSNiz6VXn3y9?=
 =?us-ascii?Q?V+GCMLlVKG3gFI9AR2ttkVirB2NvIsY3aKLa80s9JK3UOs4hzWcgP5iLtB3i?=
 =?us-ascii?Q?5MnrmQs8a/MX3LA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:33:51.5912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0050b0e-5333-4d74-97d1-08dd49b607a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

The only use of the function sff_show_revision_compliance() is in qsfp.c
file.

Therefore, it doesn't belong to sff_common.c file but it can simply be a
static function in qsfp.c.

Move sff_show_revision_compliance() function to qsfp.c.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
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


