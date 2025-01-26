Return-Path: <netdev+bounces-160966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B570A1C794
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22894164E69
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEC156677;
	Sun, 26 Jan 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jDoCt9/s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9E86358
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892631; cv=fail; b=ksZlcoL511ZK2Z/VO4eSeSxf5HhcyWh6gwgI5BGJpZC72CSl3siQod7wSTKn6qf2gdx0qoW1P3lHNfjke8lLOg9K9B4bfUxlPQdgPWuWCjbvr/G7Cfw55g4ijWYPi7WrVPd4y1P4fKJZcsAzQ/wgQNtXDKI7UeZmKWkX3q5kWjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892631; c=relaxed/simple;
	bh=Rdi8yJnk7TU6tRWoMU82KfsEckLWh0qojsotTZ6zi58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brp4SEY1nT8qs96ywRXImUj9WL34smXbQZkt5WoYDgT7eB0ltECg+O4PlOE7ljeCIhYksLZRyoXm5J/X94NqxoMnZ4LcwBLUI9kvyfn+Rw9LJuOCecRxn6cMlQTPRO/Bh7pfw9wcbofs1CzkjareCxNP38oT9CRJ9tdn0/uDGJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jDoCt9/s; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RezitWl6oNB7FHHu/gAoOBy8xg7p9IaIs+G7cn/IIUrwixQRbQ+bQUFJKizO9kbg40S4IMOo1wcByLEP29SaibkHG9gDYJeSwRMfReZ+fZYEBfySpVVfoiWTMfHhMuW/elyocmX6fXBhlxzTPcnULmlU1wlfNnvhGq5RJAjbnP4OZwZwg+0iJMh4j4fj0IGoNtBZf22R5wxB8y9gmVXc47ycQBRs6eoz09Uc0ZqTFeaM5Tqnw5LmX6WNnsxI/lB5esCDafhtlRZn9FpeSvCjCrY3bGIs5RDMGIe6LJXRmVSZGz0i80ZpvJY07SUZagcdA5TePw39nOtoFs5s9KPAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9JGit/uADGkyZmnxHHYXj9eBsYH8wNHIAhvnezfx3s=;
 b=H29QY7u9fLblOaU5PyI8wJRVeX/n5cW0GzKVws5gz2rNKvhJSI3ksd8tAqh1BgNYyZ01Xtv5WROChvwBe9CQB0kPlR5EYOYwDdyEF3qGwIZWKCowbcOskXujopiI9atSM5draB+If60QjUgpnA+3Ztvp0oyO8EEgfHV/gZQJ/VDklPuzltD9PjlAXBRMybMxG3bXXOnMyWUHaMZSTgEGNod2lYbYkwUQPohdZan7k07PMCMs/VeBxHWzaa60i29Zf8aCTA1PGvBIGSFb8/JmmvBuvrdahcJ8UxXvIuw6cgy7xTPs6GyHCrY6BVcsJMsluIx/5WePwHmOEvrohWlacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9JGit/uADGkyZmnxHHYXj9eBsYH8wNHIAhvnezfx3s=;
 b=jDoCt9/sqtFgcJiByOHI2q0VEa+oEHxqi8ipfsouSd+p3Dc41F6mcy4Pig3MPQC+tnjcGZFGqrKmuV4Z7kmuEb0Kd+JNJ0aMsoeR5nUJ5Nyr5qtLAwPZJKtZiakfoTaH1X5is+KiiWYJxDOBlyyBkW9fteU4HCBflL6I0oAitj6F+qCKo+xXgj4+Cmmj7UWY7Mc1BtEZInm3cZJ7D8tpYEkRhEFzQH1gvxrxeoJbHsjh37uV4C5AIg5D9enkRy028yhAHv3WUdZQQcZeSximDNGjs6n64FrsCaZH6yW7H7HidPxgEDakEOF5yu0DTx41ummSyWcJ7gXE0P95aWwM+g==
Received: from DM6PR14CA0056.namprd14.prod.outlook.com (2603:10b6:5:18f::33)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sun, 26 Jan
 2025 11:57:05 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::4c) by DM6PR14CA0056.outlook.office365.com
 (2603:10b6:5:18f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sun,
 26 Jan 2025 11:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:56:55 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:56:53 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 02/14] sff_common: Move sff_show_revision_compliance() to qsfp.c
Date: Sun, 26 Jan 2025 13:56:23 +0200
Message-ID: <20250126115635.801935-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126115635.801935-1-danieller@nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: d85b688b-716c-4cf6-b41e-08dd3e008d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UuC5EB4Lp6ZWkqfE4Y83smU/hwvU8gIsZavIu8byM0XCWcjSkIc2S7PnaP1U?=
 =?us-ascii?Q?QVXl8RUbyQrDW5kyAoeNI7Oq9A9NinO1DPUrRNkyiOV2Nt7M9hBUfGsu1Rh+?=
 =?us-ascii?Q?/nN2bIW6xECSHK+EsOIwoscKME9Ouao3HTkaXKfMvJFSLvELLQFPj1BNIdjt?=
 =?us-ascii?Q?YBfbk6aJMscrIbbdTiV4oIoM6bKL7tSG6iyrOUCYUC2GkfqETTw+V3FTCZlI?=
 =?us-ascii?Q?5c4qo1+Hig8n8O648kR4q4AfD+gxUhEKhAcVEuTg4S4Hm6MSw6kq9HJEwkxT?=
 =?us-ascii?Q?bY+BBwsbROLPrU6RqyKQI+K6M+S21pOPyPozc6dyCRqPZOzDoot3z7f971r3?=
 =?us-ascii?Q?/P1YoOeM2XkGOQ8HTCFcyjqCnmBQRo9hjXC/uxye5pX95/ZfGLkub8lujNWz?=
 =?us-ascii?Q?Z61DgQMp7rRT3C//g+6y6IIbPa/n/8Y6OlefdU+L0A1M/SurML/xlayXwicT?=
 =?us-ascii?Q?2B79uTUW73KvbWlZC/ZqtknEoSWwUtmF2AwRO9adDY8F49ySpmoMkI1O2ZY2?=
 =?us-ascii?Q?L01CCoce1Z/76vwwO3o05TNCuarcJzIF4wn/ipYhFeM3kCIsAJ3hnPGAurxa?=
 =?us-ascii?Q?gP0UkIHN4GpGqxk7hrKZg8G3wTYdYlCbA5g6UF5S7HxWGop8tAQH34KkfD/G?=
 =?us-ascii?Q?N8BSWx/HNGgHru70nSH+bWWQDjLAU7bhmuRqvarPxRg6Opl+v4XvMqLwHFOc?=
 =?us-ascii?Q?lawV0NIx/ho6AuamWkKTqcn2M2seSGx1TzaHDypLvEyaIKBEovWe+Terbtsg?=
 =?us-ascii?Q?M3AK3ytNXaJOZWVycBYOO2mGSQKPryiGhSGbe1FWGyJhGBY2Zs79YtS84LLW?=
 =?us-ascii?Q?XckZng6GLUkWQltF+VVZuaL+xE6sMlRADg0xkH1MKQ2DweYyzahoH7eFB7Bd?=
 =?us-ascii?Q?R5Ffoc5QVmJyrVlFttD1qgD4aRnoPfyt4/M1nm988mwFTYNXOtTzQm4OzBUW?=
 =?us-ascii?Q?5W9eoNf8s+IBzo7oWp8czqydmXtvdLi9GWw6y618AFUln0VEgpurdJBEKTDg?=
 =?us-ascii?Q?5SMu2U69w6UuYFq1xza88xO9Prohtqg1W4P0ZTF0mDsNtuWMjnfe7r7D1TWK?=
 =?us-ascii?Q?tP53qhSxzAjlq8SvlbZMleoe1lV4QVphhcEZ1xBEbjE+4yQPJiaJ6YRf5/HA?=
 =?us-ascii?Q?ueH0d9wjsR16Ux9xrwJynUzRnKnvLY5Us53I0MCEuo5w7FV8ViWfEFFwm7cn?=
 =?us-ascii?Q?1JStzyNw0/VQkxUskpKSGKfwLj1u8Z22Dp0Oq4g5vQciKrY7edv3SfQdbP9i?=
 =?us-ascii?Q?OxY48AqL8xSh9cwqCphyWNPvmH3Wh83quc71WZ/OBZGopnEF1JuyGR5RIl1c?=
 =?us-ascii?Q?pzpheiyHi5zQu5hdmOOZyvXIWMPe1zNfatf5DvHGOAJiVipejD2I5hb90sTp?=
 =?us-ascii?Q?pMXrYbOVxEc2ADQtGMszvOgxuEl8T4L3HOx5szLJnzecCAKdrR6wF7mJkit9?=
 =?us-ascii?Q?jyNjDEOVxzSk4UHHvIXgTbN6jb7cxhgfCnYnm5M95TvYuUFO3+F7UXB94qgk?=
 =?us-ascii?Q?R1WASN0OtmX7KeM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:04.6739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85b688b-716c-4cf6-b41e-08dd3e008d4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

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
index 6d774f8..6c7e72c 100644
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


