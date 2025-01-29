Return-Path: <netdev+bounces-161497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88EA21DB6
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FEB3A8475
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B913957E;
	Wed, 29 Jan 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MoctiyB8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D637E0FF
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156591; cv=fail; b=F7xHxqItEzQipgas9UWBLPw6OWB115XROPG/fPQgx5E6EBVi/M8DynUkA9v1WGXQdTOTN3PBtPOI0kWy9ofx3BPHK8WeBk2WF9tNSoi7pLKLdEyF46YW3yzyoij2uws5oBfzq3RcUB5WBf1U5jO2pOz680SnQ2OdZaBGl4zknB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156591; c=relaxed/simple;
	bh=Rdi8yJnk7TU6tRWoMU82KfsEckLWh0qojsotTZ6zi58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDB/BfYDSOJWP9aTvwQThRJp71InzHNX+CHEi8UWWxCxZAbWuBVr0abf7Um573byGWhPJrPOfyH9hhIfPQOdn9QRb4XWr5/1BYjsKk86FMiM1tx2lbA18w/ue0XXOFwRpIC4ixf6H97J7thC8iyRyvtRjUAx5wseSdvv6BI3vT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MoctiyB8; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg5zdNzs7RLV2Nz/DRTGakeI6R+xaNw1id98vnWDhgg7Qt46Rh9CQ2gFt4QaI0zSiG7hJlwRY+Gul17/UkW1eqSotpsHbMdb3OSaw4Mq+dW6CEei6T4EATh4H4Ewf4YIJ7z0/aFJs5WonC5+85/V/fu8QXpY7EOT54sqSZSg0OKa222iNNVXhtrn2NZpmmCaG4rWU7PlssvKUzkaBFXL1Pm/ipXsOGWs/5BWrkGY8NVxCTMh70DTj8O4qir8vIlbP6LX8vuxzf+Si5XqFk8EagYhEKpIfXdQ56c4broFATeo7BaF1X+K3FzvL1U1gr7ewaRHQ3sXqTg09jItiW1YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9JGit/uADGkyZmnxHHYXj9eBsYH8wNHIAhvnezfx3s=;
 b=foVEK1UAg88j0gckLAH1kXwZfhGX5kFqQFL/VT6jHV1z8dLojgUMn8B9LpZrPck1cG7w2l2a0yNFfhIrfHN8G0adk3M9+hpyo3alWX0Aw3UTxKYjb9HB/npfaA6ewoApCiGNkd27qSp3EUYnMxGpKltIvxrhjM5ymuRa7viPFLd/6GgdhD1FDbKLiSp84fJFi2Q85Z9UZJn92U+GDvJNYBfjAksilNWEefnUC2VC6sUb9Yhzjg2ifOvMsH09neQcrcQvg66iATSQDMPEQUHBt8boUf+uW3+J9SdeicBnuH0c5yZW0bPxkfTcPHJwX7IRz5Ip5zgGnbsCEofcLgc6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9JGit/uADGkyZmnxHHYXj9eBsYH8wNHIAhvnezfx3s=;
 b=MoctiyB8vISJtMGxeCLxjMMyDEed+MVCszz7SiCZBDn0zGruuR/SghX4r6bWW4fVlSwHvPrL7uJiRVGFfig+5Jnp5OR8tQayCG28rpraPbuCh5tq41jwmW2MtWcBxUsh1cZ2MnyuNjvn+lETTro3KM7KjqB8aas0XD4WRMk6k6CNjdTvoaVA+ecmWQ5wP+f9YGMSW2Rm3DUO4kPIRgKqrYdT2dkC7COMfGpr3bYWuiu9Dlm61Kp1reS4re+HQ5G42QzCAVV7gsNbUPP2ySjKKYjuhs/sLYNG7KZ8AUu+mMZI5/1SDU8pEXbe2RFu8x6e4buoQA9nTLX4e9vsLVRcJw==
Received: from PH7P220CA0163.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::24)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 13:16:24 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::a8) by PH7P220CA0163.outlook.office365.com
 (2603:10b6:510:33b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Wed,
 29 Jan 2025 13:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:07 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:05 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 02/14] sff_common: Move sff_show_revision_compliance() to qsfp.c
Date: Wed, 29 Jan 2025 15:15:35 +0200
Message-ID: <20250129131547.964711-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250129131547.964711-1-danieller@nvidia.com>
References: <20250129131547.964711-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: f542ef2e-c90f-476b-dd73-08dd4067214a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DKD+hE+hts2NuAUPN3hSrCjEnSb/eEwRv3SyWHhqzmP9PgSUNMbiHkMPwYWc?=
 =?us-ascii?Q?epQ3gtKcbzAZ1Ztkw1Z62CXLdggAI1jM3c0Xl1eFYPh3BUViHKZfO7SX6OTg?=
 =?us-ascii?Q?/OR6aR7b7AqIRmVpbGBwz9mpLxZfcjND51lp7A37tYDxXNQW6E9pxjC6wF6y?=
 =?us-ascii?Q?XxsDl7RyrFYRR7oRWoyCvdn/H61a03C1PccxRQeXsbbBADyc93C7Ns9mRC18?=
 =?us-ascii?Q?Usqj7eKYutPBL4l0Ws5szKif/wngDZN5MifiENehahoK1WARUX+4cyUxoX/c?=
 =?us-ascii?Q?+36BLykNN4uJEfpQGCkh5dsO1/MiyS4IThzCLXE5QsipvBhDhC+CF4jT3acd?=
 =?us-ascii?Q?v3OYqLq766k8bQZ22Tbjh8SZNZhyvvp6SaVAexOngPSYxsrW8TJCRtSsS31t?=
 =?us-ascii?Q?DkIgwlxrQJYQ3em2g79J4nZ7vCasivddFozheMqNY+9ldPsgk7vs/KS8h92o?=
 =?us-ascii?Q?++fsLy167pyFYC41iASl17mSnLq/KRt3lwxqAfjGVsfKiHMIhkXNErUilJqu?=
 =?us-ascii?Q?+Sp6lKKl/HVmWmkPP86u3q6DU2GJSXy2WDJR2nLGfNuXSQeMCe3vEXUNR6cZ?=
 =?us-ascii?Q?qF8b3VvGtPJgbXau8Cefvab+flF8+cHkT9iQ8wGdnQudEervUfsvPNn6iZbF?=
 =?us-ascii?Q?o8KZu/0R8YGuUA4oiPx9amIFKjnvJaO0uvcbg5Qq8u6zGkDdxywlWb2ondR1?=
 =?us-ascii?Q?+Acyq+7SLoM91aLO2X6mkOsHBr58h9Jn7K9lt1Jln3FklUNq6BRgsSKIznKY?=
 =?us-ascii?Q?IozSVPu34aY33FCASl1wyvnwyFhj7wQ+2ut8ToeuC/gR+lEWA1YGfBP1LBFz?=
 =?us-ascii?Q?0eXJvFRiH+b06Ga/Ngx0xY58/nb4K9sx3QKU+pDgwXo1hZidajTkf7uhZMC8?=
 =?us-ascii?Q?jkIf0tu6P0PNSntDFNsFW4dh2GHr7AD3sYcoX5DC6VeZInKhPqzEAu6kqRzf?=
 =?us-ascii?Q?W4R63dDJIuw2T6RxfgQrywJzSjqJm0ARTPMj+26YTtcWKoPZFD5wOFE48Cel?=
 =?us-ascii?Q?U1WHfwtxThrnCv5yOJv+Jztg8ykRrW+wyT5Mp+q7JGIZcXef88ock03DosFQ?=
 =?us-ascii?Q?fWrCZMJufeS4Wm6kDiePOOUOES5I5CMwh5QntEQxQYuLEvazNyveD3ORSB0p?=
 =?us-ascii?Q?wNmak/NGwM8rWBpUd1ec6NOf6ZSIxel2q4N1ky1QxNezYXMrcdmnywi2/B6z?=
 =?us-ascii?Q?SOY4NnBfXgQUyk4N9DBvviZEgSVWsSL6atU5YiRLG4iKeBFoTzmcerGmfLD+?=
 =?us-ascii?Q?di6t3ki8tXWuqOgSfbrvUwfB++TzepNn0WeFD2FxxmOfiScOD1JCYQ4D59q6?=
 =?us-ascii?Q?sy8hh+5QAqZBrbg+E7GIIfq0TeLhBpXXKlNE6xLuGOPEOI9fTQPIh+j+aAKR?=
 =?us-ascii?Q?j1GnSOFDdCr34TV81vSYwxxeda6AKAzFQ61yG7pEHu7IHaM0Cd/9wKiK0cwP?=
 =?us-ascii?Q?9SGghgFh1qR2thdh3EmEmjJUFty837qy+RFBhfoidgNFHKOhZqbBPzqbrz1q?=
 =?us-ascii?Q?YfAbq8bf0YNAPEY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:23.9435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f542ef2e-c90f-476b-dd73-08dd4067214a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031

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


