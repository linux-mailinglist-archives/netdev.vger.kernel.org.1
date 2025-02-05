Return-Path: <netdev+bounces-163110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9CA2956F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB74A3A6176
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB71A76BC;
	Wed,  5 Feb 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mc1nWCKF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC4190678
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770948; cv=fail; b=QxE1FBzUXKHE30JYs5EUjXcUqU17x6315VObF8ly147xIWav6Wm1LRhrYJxeITId8sqlY8OzMUyfPijr4slOn28jqI2CtdzMHtjlw//KVRnV1BC5PhvuItvTNeOBf4pW17qs9SRT9RCNjUd9tYMhBXjmD3dScPcMLOvBbga9oy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770948; c=relaxed/simple;
	bh=BLup7I95hPC/GjM5PUtIJmpC1ifIKhOTuVxQG50gGbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhzQ9J7wS1JC6AEOTvwzGDW36USUoiusyCpn4eWkhwpP01JIMDm9vEddqOn/VVS6dovNr1cmgJzhD72Iw9m2WR9h1kGhQUyLgJ/5WH4R7S0XQ4SAxwQ4Uci7aqOkcjyvYcqMMWrD+U0YWAaNJ0dtCoKjLxqc9cOTOeIu596ka6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mc1nWCKF; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA89UvVeUnanbA67bN0k/EGgjJARkaqgP9DcyoBZO+g2FM0BlY/OSvKVpRQ6Pm/x53p4xggh/IvtwyqqJQz+hp7Q4KPFGTtHDU6m7wvsUqkb1aPV2albLCg0J0HopW3dsk0NxDDhxnL79gaQ8k1GS0OirpUha5HgduPbkA1go9okx8wqcUbp5KngdwfRnbhNHaGEWqaadXO0ALF4/lfXZcVz4vHJaQZwrA2fh6fjbGyAXQrHeatuyaqPFgij6t5bkpFzT9DWMD/oWmdfuDJShk3T2m1YAr21n961x0pnuJb9OppACYht2ZsO6oAfZ67BUmyC68cCWzJpuf4co3UsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqqEq8wgpKHTwH34RUK74krLZ5QHdSPonM3IfZaESKg=;
 b=xQnmLz3ZfA3r5peVGyDMzGg+w0B0SrCoia/H+nZbFzOSnhigV0YtBQtXzy7IayqEfjUvVtgenP/BOhACLjFDJCxM5BweKeNvaHv2UV2tVhArlQxCoU7YuQHe6sVZna3DU9XWlsJDnHGwg3WVcnddRxhMpdkSBr03m2NLbRlCLaHiaaE0gSxF7XP8btQmgTtpcNYDQzhY+D0wb0kjHA49TdPfxKNuB7tHJZp+HslD1S+vBmO4cxFdedwlmlAdHW7S9Z4NVj5f2siHy2BZgD5SGXs5WFt3PcCEyLLuah/Ks/r/y6nzWyhyZ2TJvQ940YMuvpafb+Nt/v0bBHA9rAAq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqqEq8wgpKHTwH34RUK74krLZ5QHdSPonM3IfZaESKg=;
 b=Mc1nWCKFql+5Bu6z9626+UYPpPLnteK32csZurfRt+K2qdWB0Q0cjtVG/qoRSHaeNtM2VfAIZb5fFD9OCzczB84hYG0bnRpJ6rq/FDyighMCAisqU4LUVbY+6iFBxgNQvLPy/3W2Kfd9/l8arvyHY0FXfj4FVeCBuyJRd+8UmzNq5PKvgctSyawFYCBgPL4V5DTj7GA5BZquCVWhhxs//NFAC/ir4pthGTzL4UK+b0C7I4Bi+3fr7GPsWV4pspDpZl4Uk1g4zO5N6xAz1JWCIIp4CSRHzMdqvuvuPLe7V1A94TZ6LSof4UYdFx3NtIYZ7Wc7cx1HCPNU8x2GkiQH6A==
Received: from BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::12)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 15:55:38 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::92) by BL1P221CA0001.outlook.office365.com
 (2603:10b6:208:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:55:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:19 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:17 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 10/16] qsfp: Add JSON output handling to --module-info in SFF8636 modules
Date: Wed, 5 Feb 2025 17:54:30 +0200
Message-ID: <20250205155436.1276904-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9fa1fa-46c5-4b9c-bbd1-08dd45fd890a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUV4tMuhMG9BiRWvXIX+AI7TPyNfWFgPid6Ze0YDSHpd8+i2T5T0N7SRTiVT?=
 =?us-ascii?Q?ITIofFm62QQ6/NDRm+qV4wqN7ajMo1Eq0HuNriq/GZghOJG04mwZogjI8GUW?=
 =?us-ascii?Q?SmVTWQIIyAkuFnzsHWLowIPoR8nk3NulU/h7IzegkUynQ2+j1RpvjeVrcK2u?=
 =?us-ascii?Q?c18yow6WvFj2nzSr0hKV+IjCBuiJzPgfoKcgqw4pL6hVefjudQ4c2oiIYxJc?=
 =?us-ascii?Q?gTTScmPJm9NCCfMfwkiqdUn8G/eSSB+nDOhHzdba2YVUnF8zCuvc91RVj4V8?=
 =?us-ascii?Q?pWLCix8FYsBmE0WtyQIDggsgWPMol8ipIVXHw2wDPRvGpqnwCXTScFcjEYpp?=
 =?us-ascii?Q?67ez0TjowMr2pzvj7A7lKvkeVKiGoFdwlS13n47uZM2gyIoMLCTKqlyjstnO?=
 =?us-ascii?Q?vCqp97OrDheeshJaXxVsgju1+byKR26wVwj8DwszPHDJv+i04xRyn5YfQIXS?=
 =?us-ascii?Q?CDHiP1gjscuoQfsgAEYg86EmS4SfhOuL5JDTJUNQZlGqYXTm6CZjMTHVIcse?=
 =?us-ascii?Q?mNuj2OCth9p0OwpzEuEhXxbkp/6vr4YCZYoB/FkWKAd/LrCsljX1ckaEQUUd?=
 =?us-ascii?Q?pgCnEePQd7kp0uaf+Vu8WIIZ2uVZqNEapyCkNqoupgBqqYrxBgYCFT2R7k6T?=
 =?us-ascii?Q?+ioLtMcLbeVcIUwaSuWJHvydYne8zqBWKKS1WMWpDx8V/HaRkkpjOlhXRwzd?=
 =?us-ascii?Q?S3N782AShP0hHXADgDbewNolqKv3A4KWw82bxSoUwMhFm7gmPsH9m0Wvkvac?=
 =?us-ascii?Q?b1bl7B2OkbYuHnXZoCh0cSBmOTP19SQeoeOvzYmZLmR1+nBmSZAq9ngS/G+X?=
 =?us-ascii?Q?pkJ0z7TvmGpJ5gJ69S4Pr6effJ4f55EXMb03L5n3ROTBHw8S2EG3UzfMFzqu?=
 =?us-ascii?Q?9iqMouaVJFsRy8fxFEog01aDol41gnt37LMWy9wXBiuZWogfvzvbMFWhHLm+?=
 =?us-ascii?Q?bfdDTYzCsCouVKV6aAzqhPdMsBbBKF3aDNGjgplm18CBFjXNqpwS5+f9MkrW?=
 =?us-ascii?Q?7xwJys7bGPqhqD2+qlhI3AzEOSgEoFbKSlEDyMhuxjyWyfrZjian3/4XHtv4?=
 =?us-ascii?Q?lzbNArcr+jU7DgpXpPKTCHgelWCqg3CmP5AeM1lD7kak3m8WZQz8lUlwy25E?=
 =?us-ascii?Q?ei4YgP+QOGSV/872asDLMUY7ZzT9lnER35kyjCO4QuElebFZVn2KCN8LUdUU?=
 =?us-ascii?Q?pnB5fe5j01ZXijOPeFn6P28iP25pvZemi3pZ8vkEOzywBBz8kLPwzp9NpWkc?=
 =?us-ascii?Q?XRIBSP14GBWmg2BbHRQeM8JKg0575/hZ6+QQ1RmwDuTh4jB/Oyl4pSb4UReq?=
 =?us-ascii?Q?2Z5W+T5Nx7HkDGy4nAuxM+X2kuMFI53uK6yocuWmP0wQX11POc7/KM2CeYXP?=
 =?us-ascii?Q?C73JAI487TFCxWLREceQ7ducuB6iLyX3M5Yjb6dkyI+kTUwP5MKhjqFPLFEp?=
 =?us-ascii?Q?/c26eAeoazHYah9Hdc+PS4whI86+/kEWX6MjdfOCOGnDXI/JGD3fxnEZrapK?=
 =?us-ascii?Q?q97f1ZASmNbdKDk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:38.2827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9fa1fa-46c5-4b9c-bbd1-08dd45fd890a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481

Add JSON output handling for 'ethtool -m' / --module-info, following the
guideline below:

1. Fields with description, will have a separate description field.
2. Units will be documented in a separate module-info.json file.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub fields.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v4:
    	* In extended_identifier field, use an array for all
    	  descriptions instead of 3 different descriptions.
    	* Remove duplicated definition of YESNO() and ONOFF() defines.
    
    v3:
    	* Remove unit fields.
    	* Reword commit message.
    	* Fix JSON output in sff8636_show_dom_mod_lvl_flags().

 qsfp.c | 536 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 331 insertions(+), 205 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index 0af02f0..1076685 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -82,64 +82,94 @@ static void sff8636_show_identifier(const struct sff8636_memory_map *map)
 
 static void sff8636_show_ext_identifier(const struct sff8636_memory_map *map)
 {
-	printf("\t%-41s : 0x%02x\n", "Extended identifier",
-	       map->page_00h[SFF8636_EXT_ID_OFFSET]);
-
 	static const char *pfx =
 		"\tExtended identifier description           :";
+	char description[64];
+
+	if (is_json_context()) {
+		open_json_object("extended_identifier");
+		print_uint(PRINT_JSON, "value", "%u",
+			   map->page_00h[SFF8636_EXT_ID_OFFSET]);
+	} else {
+		printf("\t%-41s : 0x%02x\n", "Extended identifier",
+		       map->page_00h[SFF8636_EXT_ID_OFFSET]);
+	}
 
+	open_json_array("description", "");
 	switch (map->page_00h[SFF8636_EXT_ID_OFFSET] &
 		SFF8636_EXT_ID_PWR_CLASS_MASK) {
 	case SFF8636_EXT_ID_PWR_CLASS_1:
-		printf("%s 1.5W max. Power consumption\n", pfx);
+		strncpy(description, "1.5W max. Power consumption", 64);
 		break;
 	case SFF8636_EXT_ID_PWR_CLASS_2:
-		printf("%s 2.0W max. Power consumption\n", pfx);
+		strncpy(description, "1.5W max. Power consumption", 64);
 		break;
 	case SFF8636_EXT_ID_PWR_CLASS_3:
-		printf("%s 2.5W max. Power consumption\n", pfx);
+		strncpy(description, "2.5W max. Power consumption", 64);
 		break;
 	case SFF8636_EXT_ID_PWR_CLASS_4:
-		printf("%s 3.5W max. Power consumption\n", pfx);
+		strncpy(description, "3.5W max. Power consumption", 64);
 		break;
 	}
 
+	if (is_json_context())
+		print_string(PRINT_JSON, NULL, "%s", description);
+	else
+		printf("%s %s\n", pfx, description);
+
 	if (map->page_00h[SFF8636_EXT_ID_OFFSET] & SFF8636_EXT_ID_CDR_TX_MASK)
-		printf("%s CDR present in TX,", pfx);
+		strncpy(description, "CDR present in TX,", 64);
 	else
-		printf("%s No CDR in TX,", pfx);
+		strncpy(description, "No CDR in TX,", 64);
 
 	if (map->page_00h[SFF8636_EXT_ID_OFFSET] & SFF8636_EXT_ID_CDR_RX_MASK)
-		printf(" CDR present in RX\n");
+		strcat(description, " CDR present in RX");
+	else
+		strcat(description, " No CDR in RX");
+
+	if (is_json_context())
+		print_string(PRINT_JSON, NULL, "%s", description);
 	else
-		printf(" No CDR in RX\n");
+		printf("%s %s\n", pfx, description);
 
 	switch (map->page_00h[SFF8636_EXT_ID_OFFSET] &
 		SFF8636_EXT_ID_EPWR_CLASS_MASK) {
 	case SFF8636_EXT_ID_PWR_CLASS_LEGACY:
-		printf("%s", pfx);
+		strncpy(description, "", 64);
 		break;
 	case SFF8636_EXT_ID_PWR_CLASS_5:
-		printf("%s 4.0W max. Power consumption,", pfx);
+		strncpy(description, "4.0W max. Power consumption,", 64);
 		break;
 	case SFF8636_EXT_ID_PWR_CLASS_6:
-		printf("%s 4.5W max. Power consumption, ", pfx);
+		strncpy(description, "4.5W max. Power consumption,", 64);
 		break;
 	case SFF8636_EXT_ID_PWR_CLASS_7:
-		printf("%s 5.0W max. Power consumption, ", pfx);
+		strncpy(description, "5.0W max. Power consumption,", 64);
 		break;
 	}
+
 	if (map->lower_memory[SFF8636_PWR_MODE_OFFSET] &
 	    SFF8636_HIGH_PWR_ENABLE)
-		printf(" High Power Class (> 3.5 W) enabled\n");
+		strcat(description, " High Power Class (> 3.5 W) enabled");
+	else
+		strcat(description,
+		       " High Power Class (> 3.5 W) not enabled");
+
+	if (is_json_context())
+		print_string(PRINT_JSON, NULL, "%s", description);
 	else
-		printf(" High Power Class (> 3.5 W) not enabled\n");
-	printf("\t%-41s : ", "Power set");
-	printf("%s\n", ONOFF(map->lower_memory[SFF8636_PWR_MODE_OFFSET] &
-			     SFF8636_LOW_PWR_SET));
-	printf("\t%-41s : ", "Power override");
-	printf("%s\n", ONOFF(map->lower_memory[SFF8636_PWR_MODE_OFFSET] &
-			     SFF8636_PWR_OVERRIDE));
+		printf("%s %s\n", pfx, description);
+
+	close_json_array("");
+	close_json_object();
+
+	bool value = map->lower_memory[SFF8636_PWR_MODE_OFFSET] &
+			SFF8636_LOW_PWR_SET;
+	module_print_any_bool("Power set", "power_set", value, ONOFF(value));
+	value = map->lower_memory[SFF8636_PWR_MODE_OFFSET] &
+			SFF8636_PWR_OVERRIDE;
+	module_print_any_bool("Power override", "power_override", value,
+			      ONOFF(value));
 }
 
 static void sff8636_show_connector(const struct sff8636_memory_map *map)
@@ -149,232 +179,262 @@ static void sff8636_show_connector(const struct sff8636_memory_map *map)
 
 static void sff8636_show_transceiver(const struct sff8636_memory_map *map)
 {
-	static const char *pfx =
-		"\tTransceiver type                          :";
-
-	printf("\t%-41s : 0x%02x 0x%02x 0x%02x " \
-			"0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
-			"Transceiver codes",
-			map->page_00h[SFF8636_ETHERNET_COMP_OFFSET],
-			map->page_00h[SFF8636_SONET_COMP_OFFSET],
-			map->page_00h[SFF8636_SAS_COMP_OFFSET],
-			map->page_00h[SFF8636_GIGE_COMP_OFFSET],
-			map->page_00h[SFF8636_FC_LEN_OFFSET],
-			map->page_00h[SFF8636_FC_TECH_OFFSET],
-			map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET],
-			map->page_00h[SFF8636_FC_SPEED_OFFSET]);
+	static const char *pfx = "Transceiver type";
+	char value[140] = "";
+
+	if (is_json_context()) {
+		open_json_array("transceiver_codes", "");
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_ETHERNET_COMP_OFFSET]);
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_SONET_COMP_OFFSET]);
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_SAS_COMP_OFFSET]);
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_GIGE_COMP_OFFSET]);
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_FC_LEN_OFFSET]);
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_FC_TECH_OFFSET]);
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET]);
+		print_uint(PRINT_JSON, NULL, "%u",
+			   map->page_00h[SFF8636_FC_SPEED_OFFSET]);
+		close_json_array("");
+	} else {
+		printf("\t%-41s : 0x%02x 0x%02x 0x%02x " \
+		       "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+		       "Transceiver codes",
+		       map->page_00h[SFF8636_ETHERNET_COMP_OFFSET],
+		       map->page_00h[SFF8636_SONET_COMP_OFFSET],
+		       map->page_00h[SFF8636_SAS_COMP_OFFSET],
+		       map->page_00h[SFF8636_GIGE_COMP_OFFSET],
+		       map->page_00h[SFF8636_FC_LEN_OFFSET],
+		       map->page_00h[SFF8636_FC_TECH_OFFSET],
+		       map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET],
+		       map->page_00h[SFF8636_FC_SPEED_OFFSET]);
+	}
 
 	/* 10G/40G Ethernet Compliance Codes */
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_10G_LRM)
-		printf("%s 10G Ethernet: 10G Base-LRM\n", pfx);
+		sprintf(value, "%s", "10G Ethernet: 10G Base-LRM");
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_10G_LR)
-		printf("%s 10G Ethernet: 10G Base-LR\n", pfx);
+		sprintf(value, "%s", "10G Ethernet: 10G Base-LR");
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_10G_SR)
-		printf("%s 10G Ethernet: 10G Base-SR\n", pfx);
+		sprintf(value, "%s", "10G Ethernet: 10G Base-SR");
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_40G_CR4)
-		printf("%s 40G Ethernet: 40G Base-CR4\n", pfx);
+		sprintf(value, "%s", "40G Ethernet: 40G Base-CR4");
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_40G_SR4)
-		printf("%s 40G Ethernet: 40G Base-SR4\n", pfx);
+		sprintf(value, "%s", "40G Ethernet: 40G Base-SR4");
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_40G_LR4)
-		printf("%s 40G Ethernet: 40G Base-LR4\n", pfx);
+		sprintf(value, "%s", "40G Ethernet: 40G Base-LR4");
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_40G_ACTIVE)
-		printf("%s 40G Ethernet: 40G Active Cable (XLPPI)\n", pfx);
+		sprintf(value, "%s", "40G Ethernet: 40G Active Cable (XLPPI)");
 	/* Extended Specification Compliance Codes from SFF-8024 */
 	if (map->page_00h[SFF8636_ETHERNET_COMP_OFFSET] &
 	    SFF8636_ETHERNET_RSRVD) {
 		switch (map->page_00h[SFF8636_OPTION_1_OFFSET]) {
 		case SFF8636_ETHERNET_UNSPECIFIED:
-			printf("%s (reserved or unknown)\n", pfx);
+			sprintf(value, "%s", "(reserved or unknown)");
 			break;
 		case SFF8636_ETHERNET_100G_AOC:
-			printf("%s 100G Ethernet: 100G AOC or 25GAUI C2M AOC with worst BER of 5x10^(-5)\n",
-					pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G AOC or 25GAUI C2M AOC with worst BER of 5x10^(-5)");
 			break;
 		case SFF8636_ETHERNET_100G_SR4:
-			printf("%s 100G Ethernet: 100G Base-SR4 or 25GBase-SR\n",
-					pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G Base-SR4 or 25GBase-SR");
 			break;
 		case SFF8636_ETHERNET_100G_LR4:
-			printf("%s 100G Ethernet: 100G Base-LR4\n", pfx);
+			sprintf(value, "%s", "100G Ethernet: 100G Base-LR4");
 			break;
 		case SFF8636_ETHERNET_100G_ER4:
-			printf("%s 100G Ethernet: 100G Base-ER4\n", pfx);
+			sprintf(value, "%s", "100G Ethernet: 100G Base-ER4");
 			break;
 		case SFF8636_ETHERNET_100G_SR10:
-			printf("%s 100G Ethernet: 100G Base-SR10\n", pfx);
+			sprintf(value, "%s", "100G Ethernet: 100G Base-SR10");
 			break;
 		case SFF8636_ETHERNET_100G_CWDM4_FEC:
-			printf("%s 100G Ethernet: 100G CWDM4 MSA with FEC\n", pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G CWDM4 MSA with FEC");
 			break;
 		case SFF8636_ETHERNET_100G_PSM4:
-			printf("%s 100G Ethernet: 100G PSM4 Parallel SMF\n", pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G PSM4 Parallel SMF");
 			break;
 		case SFF8636_ETHERNET_100G_ACC:
-			printf("%s 100G Ethernet: 100G ACC or 25GAUI C2M ACC with worst BER of 5x10^(-5)\n",
-				pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G ACC or 25GAUI C2M ACC with worst BER of 5x10^(-5)");
 			break;
 		case SFF8636_ETHERNET_100G_CWDM4_NO_FEC:
-			printf("%s 100G Ethernet: 100G CWDM4 MSA without FEC\n", pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G CWDM4 MSA without FEC");
 			break;
 		case SFF8636_ETHERNET_100G_RSVD1:
-			printf("%s (reserved or unknown)\n", pfx);
+			sprintf(value, "%s", "(reserved or unknown)");
 			break;
 		case SFF8636_ETHERNET_100G_CR4:
-			printf("%s 100G Ethernet: 100G Base-CR4 or 25G Base-CR CA-L\n",
-				pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G Base-CR4 or 25G Base-CR CA-L");
 			break;
 		case SFF8636_ETHERNET_25G_CR_CA_S:
-			printf("%s 25G Ethernet: 25G Base-CR CA-S\n", pfx);
+			sprintf(value, "%s", "25G Ethernet: 25G Base-CR CA-S");
 			break;
 		case SFF8636_ETHERNET_25G_CR_CA_N:
-			printf("%s 25G Ethernet: 25G Base-CR CA-N\n", pfx);
+			sprintf(value, "%s", "25G Ethernet: 25G Base-CR CA-N");
 			break;
 		case SFF8636_ETHERNET_40G_ER4:
-			printf("%s 40G Ethernet: 40G Base-ER4\n", pfx);
+			sprintf(value, "%s", "40G Ethernet: 40G Base-ER4");
 			break;
 		case SFF8636_ETHERNET_4X10_SR:
-			printf("%s 4x10G Ethernet: 10G Base-SR\n", pfx);
+			sprintf(value, "%s", "4x10G Ethernet: 10G Base-SR");
 			break;
 		case SFF8636_ETHERNET_40G_PSM4:
-			printf("%s 40G Ethernet: 40G PSM4 Parallel SMF\n", pfx);
+			sprintf(value, "%s",
+				"40G Ethernet: 40G PSM4 Parallel SMF");
 			break;
 		case SFF8636_ETHERNET_G959_P1I1_2D1:
-			printf("%s Ethernet: G959.1 profile P1I1-2D1 (10709 MBd, 2km, 1310nm SM)\n",
-					pfx);
+			sprintf(value, "%s",
+				"Ethernet: G959.1 profile P1I1-2D1 (10709 MBd, 2km, 1310nm SM)");
 			break;
 		case SFF8636_ETHERNET_G959_P1S1_2D2:
-			printf("%s Ethernet: G959.1 profile P1S1-2D2 (10709 MBd, 40km, 1550nm SM)\n",
-					pfx);
+			sprintf(value, "%s",
+				"Ethernet: G959.1 profile P1S1-2D2 (10709 MBd, 40km, 1550nm SM)");
 			break;
 		case SFF8636_ETHERNET_G959_P1L1_2D2:
-			printf("%s Ethernet: G959.1 profile P1L1-2D2 (10709 MBd, 80km, 1550nm SM)\n",
-					pfx);
+			sprintf(value, "%s",
+				"Ethernet: G959.1 profile P1L1-2D2 (10709 MBd, 80km, 1550nm SM)");
 			break;
 		case SFF8636_ETHERNET_10GT_SFI:
-			printf("%s 10G Ethernet: 10G Base-T with SFI electrical interface\n",
-					pfx);
+			sprintf(value, "%s",
+				"10G Ethernet: 10G Base-T with SFI electrical interface");
 			break;
 		case SFF8636_ETHERNET_100G_CLR4:
-			printf("%s 100G Ethernet: 100G CLR4\n", pfx);
+			sprintf(value, "%s", "100G Ethernet: 100G CLR4");
 			break;
 		case SFF8636_ETHERNET_100G_AOC2:
-			printf("%s 100G Ethernet: 100G AOC or 25GAUI C2M AOC with worst BER of 10^(-12)\n",
-					pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G AOC or 25GAUI C2M AOC with worst BER of 10^(-12)");
 			break;
 		case SFF8636_ETHERNET_100G_ACC2:
-			printf("%s 100G Ethernet: 100G ACC or 25GAUI C2M ACC with worst BER of 10^(-12)\n",
-					pfx);
+			sprintf(value, "%s",
+				"100G Ethernet: 100G ACC or 25GAUI C2M ACC with worst BER of 10^(-12)");
 			break;
 		case SFF8636_ETHERNET_100GE_DWDM2:
-			printf("%s 100GE-DWDM2 (DWDM transceiver using 2 wavelengths on a 1550 nm DWDM grid with a reach up to 80 km)\n",
-					pfx);
+			sprintf(value, "%s",
+				"100GE-DWDM2 (DWDM transceiver using 2 wavelengths on a 1550 nm DWDM grid with a reach up to 80 km)");
 			break;
 		case SFF8636_ETHERNET_100G_1550NM_WDM:
-			printf("%s 100G 1550nm WDM (4 wavelengths)\n", pfx);
+			sprintf(value, "%s", "100G 1550nm WDM (4 wavelengths)");
 			break;
 		case SFF8636_ETHERNET_10G_BASET_SR:
-			printf("%s 10GBASE-T Short Reach (30 meters)\n", pfx);
+			sprintf(value, "%s",
+				"10GBASE-T Short Reach (30 meters)");
 			break;
 		case SFF8636_ETHERNET_5G_BASET:
-			printf("%s 5GBASE-T\n", pfx);
+			sprintf(value, "%s", "5GBASE-T");
 			break;
 		case SFF8636_ETHERNET_2HALFG_BASET:
-			printf("%s 2.5GBASE-T\n", pfx);
+			sprintf(value, "%s", "2.5GBASE-T");
 			break;
 		case SFF8636_ETHERNET_40G_SWDM4:
-			printf("%s 40G SWDM4\n", pfx);
+			sprintf(value, "%s", "40G SWDM4");
 			break;
 		case SFF8636_ETHERNET_100G_SWDM4:
-			printf("%s 100G SWDM4\n", pfx);
+			sprintf(value, "%s", "100G SWDM4");
 			break;
 		case SFF8636_ETHERNET_100G_PAM4_BIDI:
-			printf("%s 100G PAM4 BiDi\n", pfx);
+			sprintf(value, "%s", "100G PAM4 BiDi");
 			break;
 		case SFF8636_ETHERNET_4WDM10_MSA:
-			printf("%s 4WDM-10 MSA (10km version of 100G CWDM4 with same RS(528,514) FEC in host system)\n",
-					pfx);
+			sprintf(value, "%s",
+				"4WDM-10 MSA (10km version of 100G CWDM4 with same RS(528,514) FEC in host system)");
 			break;
 		case SFF8636_ETHERNET_4WDM20_MSA:
-			printf("%s 4WDM-20 MSA (20km version of 100GBASE-LR4 with RS(528,514) FEC in host system)\n",
-					pfx);
+			sprintf(value, "%s", "4WDM-20 MSA (20km version of 100GBASE-LR4 with RS(528,514) FEC in host system)");
 			break;
 		case SFF8636_ETHERNET_4WDM40_MSA:
-			printf("%s 4WDM-40 MSA (40km reach with APD receiver and RS(528,514) FEC in host system)\n",
-					pfx);
+			sprintf(value, "%s",
+				"4WDM-40 MSA (40km reach with APD receiver and RS(528,514) FEC in host system)");
 			break;
 		case SFF8636_ETHERNET_100G_DR:
-			printf("%s 100GBASE-DR (clause 140), CAUI-4 (no FEC)\n", pfx);
+			sprintf(value, "%s",
+				"100GBASE-DR (clause 140), CAUI-4 (no FEC)");
 			break;
 		case SFF8636_ETHERNET_100G_FR_NOFEC:
-			 printf("%s 100G-FR or 100GBASE-FR1 (clause 140), CAUI-4 (no FEC)\n", pfx);
+			sprintf(value, "%s",
+				"100G-FR or 100GBASE-FR1 (clause 140), CAUI-4 (no FEC)");
 			break;
 		case SFF8636_ETHERNET_100G_LR_NOFEC:
-			printf("%s 100G-LR or 100GBASE-LR1 (clause 140), CAUI-4 (no FEC)\n", pfx);
+			sprintf(value, "%s",
+				"100G-LR or 100GBASE-LR1 (clause 140), CAUI-4 (no FEC)");
 			break;
 		case SFF8636_ETHERNET_200G_ACC1:
-			printf("%s Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below\n",
-					pfx);
+			sprintf(value, "%s",
+				"Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below");
 			break;
 		case SFF8636_ETHERNET_200G_AOC1:
-			printf("%s Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below\n",
-					pfx);
+			sprintf(value, "%s",
+				"Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below");
 			break;
 		case SFF8636_ETHERNET_200G_ACC2:
-			printf("%s Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below\n",
-					pfx);
+			sprintf(value, "%s",
+				"Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below");
 			break;
 		case SFF8636_ETHERNET_200G_A0C2:
-			printf("%s Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below\n",
-					pfx);
+			sprintf(value, "%s",
+				"Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below");
 			break;
 		case SFF8636_ETHERNET_200G_CR4:
-			printf("%s 50GBASE-CR, 100GBASE-CR2, or 200GBASE-CR4\n", pfx);
+			sprintf(value, "%s",
+				"50GBASE-CR, 100GBASE-CR2, or 200GBASE-CR4");
 			break;
 		case SFF8636_ETHERNET_200G_SR4:
-			printf("%s 50GBASE-SR, 100GBASE-SR2, or 200GBASE-SR4\n", pfx);
+			sprintf(value, "%s",
+				"50GBASE-SR, 100GBASE-SR2, or 200GBASE-SR4");
 			break;
 		case SFF8636_ETHERNET_200G_DR4:
-			printf("%s 50GBASE-FR or 200GBASE-DR4\n", pfx);
+			sprintf(value, "%s", "50GBASE-FR or 200GBASE-DR4");
 			break;
 		case SFF8636_ETHERNET_200G_FR4:
-			printf("%s 200GBASE-FR4\n", pfx);
+			sprintf(value, "%s", "200GBASE-FR4");
 			break;
 		case SFF8636_ETHERNET_200G_PSM4:
-			 printf("%s 200G 1550 nm PSM4\n", pfx);
+			sprintf(value, "%s", "200G 1550 nm PSM4");
 			break;
 		case SFF8636_ETHERNET_50G_LR:
-			printf("%s 50GBASE-LR\n", pfx);
+			sprintf(value, "%s", "50GBASE-LR");
 			break;
 		case SFF8636_ETHERNET_200G_LR4:
-			printf("%s 200GBASE-LR4\n", pfx);
+			sprintf(value, "%s", "200GBASE-LR4");
 			break;
 		case SFF8636_ETHERNET_64G_EA:
-			printf("%s 64GFC EA\n", pfx);
+			sprintf(value, "%s", "64GFC EA");
 			break;
 		case SFF8636_ETHERNET_64G_SW:
-			printf("%s 64GFC SW\n", pfx);
+			sprintf(value, "%s", "64GFC SW");
 			break;
 		case SFF8636_ETHERNET_64G_LW:
-			printf("%s 64GFC LW\n", pfx);
+			sprintf(value, "%s", "64GFC LW");
 			break;
 		case SFF8636_ETHERNET_128FC_EA:
-			printf("%s 128GFC EA\n", pfx);
+			sprintf(value, "%s", "128GFC EA");
 			break;
 		case SFF8636_ETHERNET_128FC_SW:
-			printf("%s 128GFC SW\n", pfx);
+			sprintf(value, "%s", "128GFC SW");
 			break;
 		case SFF8636_ETHERNET_128FC_LW:
-			printf("%s 128GFC LW\n", pfx);
+			sprintf(value, "%s", "128GFC LW");
 			break;
 		default:
-			printf("%s (reserved or unknown)\n", pfx);
+			sprintf(value, "%s", "(reserved or unknown)");
 			break;
 		}
 	}
@@ -382,96 +442,98 @@ static void sff8636_show_transceiver(const struct sff8636_memory_map *map)
 	/* SONET Compliance Codes */
 	if (map->page_00h[SFF8636_SONET_COMP_OFFSET] &
 	    (SFF8636_SONET_40G_OTN))
-		printf("%s 40G OTN (OTU3B/OTU3C)\n", pfx);
+		sprintf(value, "%s", "40G OTN (OTU3B/OTU3C)");
 	if (map->page_00h[SFF8636_SONET_COMP_OFFSET] & (SFF8636_SONET_OC48_LR))
-		printf("%s SONET: OC-48, long reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-48, long reach");
 	if (map->page_00h[SFF8636_SONET_COMP_OFFSET] & (SFF8636_SONET_OC48_IR))
-		printf("%s SONET: OC-48, intermediate reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-48, intermediate reach");
 	if (map->page_00h[SFF8636_SONET_COMP_OFFSET] & (SFF8636_SONET_OC48_SR))
-		printf("%s SONET: OC-48, short reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-48, short reach");
 
 	/* SAS/SATA Compliance Codes */
 	if (map->page_00h[SFF8636_SAS_COMP_OFFSET] & (SFF8636_SAS_6G))
-		printf("%s SAS 6.0G\n", pfx);
+		sprintf(value, "%s", "SAS 6.0G");
 	if (map->page_00h[SFF8636_SAS_COMP_OFFSET] & (SFF8636_SAS_3G))
-		printf("%s SAS 3.0G\n", pfx);
+		sprintf(value, "%s", "SAS 3.0G");
 
 	/* Ethernet Compliance Codes */
 	if (map->page_00h[SFF8636_GIGE_COMP_OFFSET] & SFF8636_GIGE_1000_BASE_T)
-		printf("%s Ethernet: 1000BASE-T\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-T");
 	if (map->page_00h[SFF8636_GIGE_COMP_OFFSET] & SFF8636_GIGE_1000_BASE_CX)
-		printf("%s Ethernet: 1000BASE-CX\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-CX");
 	if (map->page_00h[SFF8636_GIGE_COMP_OFFSET] & SFF8636_GIGE_1000_BASE_LX)
-		printf("%s Ethernet: 1000BASE-LX\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-LX");
 	if (map->page_00h[SFF8636_GIGE_COMP_OFFSET] & SFF8636_GIGE_1000_BASE_SX)
-		printf("%s Ethernet: 1000BASE-SX\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-SX");
 
 	/* Fibre Channel link length */
 	if (map->page_00h[SFF8636_FC_LEN_OFFSET] & SFF8636_FC_LEN_VERY_LONG)
-		printf("%s FC: very long distance (V)\n", pfx);
+		sprintf(value, "%s", "FC: very long distance (V)");
 	if (map->page_00h[SFF8636_FC_LEN_OFFSET] & SFF8636_FC_LEN_SHORT)
-		printf("%s FC: short distance (S)\n", pfx);
+		sprintf(value, "%s", "FC: short distance (S)");
 	if (map->page_00h[SFF8636_FC_LEN_OFFSET] & SFF8636_FC_LEN_INT)
-		printf("%s FC: intermediate distance (I)\n", pfx);
+		sprintf(value, "%s", "FC: intermediate distance (I)");
 	if (map->page_00h[SFF8636_FC_LEN_OFFSET] & SFF8636_FC_LEN_LONG)
-		printf("%s FC: long distance (L)\n", pfx);
+		sprintf(value, "%s", "FC: long distance (L)");
 	if (map->page_00h[SFF8636_FC_LEN_OFFSET] & SFF8636_FC_LEN_MED)
-		printf("%s FC: medium distance (M)\n", pfx);
+		sprintf(value, "%s", "FC: medium distance (M)");
 
 	/* Fibre Channel transmitter technology */
 	if (map->page_00h[SFF8636_FC_LEN_OFFSET] & SFF8636_FC_TECH_LONG_LC)
-		printf("%s FC: Longwave laser (LC)\n", pfx);
+		sprintf(value, "%s", "FC: Longwave laser (LC)");
 	if (map->page_00h[SFF8636_FC_LEN_OFFSET] & SFF8636_FC_TECH_ELEC_INTER)
-		printf("%s FC: Electrical inter-enclosure (EL)\n", pfx);
+		sprintf(value, "%s", "FC: Electrical inter-enclosure (EL)");
 	if (map->page_00h[SFF8636_FC_TECH_OFFSET] & SFF8636_FC_TECH_ELEC_INTRA)
-		printf("%s FC: Electrical intra-enclosure (EL)\n", pfx);
+		sprintf(value, "%s", "FC: Electrical intra-enclosure (EL)");
 	if (map->page_00h[SFF8636_FC_TECH_OFFSET] &
 	    SFF8636_FC_TECH_SHORT_WO_OFC)
-		printf("%s FC: Shortwave laser w/o OFC (SN)\n", pfx);
+		sprintf(value, "%s", "FC: Shortwave laser w/o OFC (SN)");
 	if (map->page_00h[SFF8636_FC_TECH_OFFSET] & SFF8636_FC_TECH_SHORT_W_OFC)
-		printf("%s FC: Shortwave laser with OFC (SL)\n", pfx);
+		sprintf(value, "%s", "FC: Shortwave laser with OFC (SL)");
 	if (map->page_00h[SFF8636_FC_TECH_OFFSET] & SFF8636_FC_TECH_LONG_LL)
-		printf("%s FC: Longwave laser (LL)\n", pfx);
+		sprintf(value, "%s", "FC: Longwave laser (LL)");
 
 	/* Fibre Channel transmission media */
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_TW)
-		printf("%s FC: Twin Axial Pair (TW)\n", pfx);
+		sprintf(value, "%s", "FC: Twin Axial Pair (TW)");
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_TP)
-		printf("%s FC: Twisted Pair (TP)\n", pfx);
+		sprintf(value, "%s", "FC: Twisted Pair (TP)");
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_MI)
-		printf("%s FC: Miniature Coax (MI)\n", pfx);
+		sprintf(value, "%s", "FC: Miniature Coax (MI)");
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_TV)
-		printf("%s FC: Video Coax (TV)\n", pfx);
+		sprintf(value, "%s", "FC: Video Coax (TV)");
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_M6)
-		printf("%s FC: Multimode, 62.5m (M6)\n", pfx);
+		sprintf(value, "%s", "FC: Multimode, 62.5m (M6)");
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_M5)
-		printf("%s FC: Multimode, 50m (M5)\n", pfx);
+		sprintf(value, "%s", "FC: Multimode, 50m (M5)");
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_OM3)
-		printf("%s FC: Multimode, 50um (OM3)\n", pfx);
+		sprintf(value, "%s", "FC: Multimode, 50um (OM3)");
 	if (map->page_00h[SFF8636_FC_TRANS_MEDIA_OFFSET] &
 	    SFF8636_FC_TRANS_MEDIA_SM)
-		printf("%s FC: Single Mode (SM)\n", pfx);
+		sprintf(value, "%s", "FC: Single Mode (SM)");
 
 	/* Fibre Channel speed */
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_1200_MBPS)
-		printf("%s FC: 1200 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 1200 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_800_MBPS)
-		printf("%s FC: 800 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 800 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_1600_MBPS)
-		printf("%s FC: 1600 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 1600 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_400_MBPS)
-		printf("%s FC: 400 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 400 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_200_MBPS)
-		printf("%s FC: 200 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 200 MBytes/sec");
 	if (map->page_00h[SFF8636_FC_SPEED_OFFSET] & SFF8636_FC_SPEED_100_MBPS)
-		printf("%s FC: 100 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 100 MBytes/sec");
+
+	module_print_any_string(pfx, value);
 }
 
 static void sff8636_show_encoding(const struct sff8636_memory_map *map)
@@ -483,8 +545,10 @@ static void sff8636_show_encoding(const struct sff8636_memory_map *map)
 static void sff8636_show_rate_identifier(const struct sff8636_memory_map *map)
 {
 	/* TODO: Need to fix rate select logic */
-	printf("\t%-41s : 0x%02x\n", "Rate identifier",
-	       map->page_00h[SFF8636_EXT_RS_OFFSET]);
+	sff_print_any_hex_field("Rate identifier", "rate_identifier",
+				map->page_00h[SFF8636_EXT_RS_OFFSET], NULL);
+
+
 }
 
 static void
@@ -496,58 +560,65 @@ sff8636_show_wavelength_or_copper_compliance(const struct sff8636_memory_map *ma
 	module_show_mit_compliance(value);
 
 	if (value >= SFF8636_TRANS_COPPER_PAS_UNEQUAL) {
-		printf("\t%-41s : %udb\n", "Attenuation at 2.5GHz",
-			map->page_00h[SFF8636_WAVELEN_HIGH_BYTE_OFFSET]);
-		printf("\t%-41s : %udb\n", "Attenuation at 5.0GHz",
-			map->page_00h[SFF8636_WAVELEN_LOW_BYTE_OFFSET]);
-		printf("\t%-41s : %udb\n", "Attenuation at 7.0GHz",
-			map->page_00h[SFF8636_WAVE_TOL_HIGH_BYTE_OFFSET]);
-		printf("\t%-41s : %udb\n", "Attenuation at 12.9GHz",
-		       map->page_00h[SFF8636_WAVE_TOL_LOW_BYTE_OFFSET]);
+		module_print_any_uint("Attenuation at 2.5GHz",
+				      map->page_00h[SFF8636_WAVELEN_HIGH_BYTE_OFFSET],
+				      "db");
+		module_print_any_uint("Attenuation at 5.0GHz",
+				      map->page_00h[SFF8636_WAVELEN_LOW_BYTE_OFFSET],
+				      "db");
+		module_print_any_uint("Attenuation at 7.0GHz",
+				      map->page_00h[SFF8636_WAVELEN_HIGH_BYTE_OFFSET],
+				      "db");
+		module_print_any_uint("Attenuation at 12.9GHz",
+				      map->page_00h[SFF8636_WAVELEN_LOW_BYTE_OFFSET],
+				      "db");
 	} else {
-		printf("\t%-41s : %.3lfnm\n", "Laser wavelength",
-		       (((map->page_00h[SFF8636_WAVELEN_HIGH_BYTE_OFFSET] << 8) |
-			 map->page_00h[SFF8636_WAVELEN_LOW_BYTE_OFFSET]) * 0.05));
-		printf("\t%-41s : %.3lfnm\n", "Laser wavelength tolerance",
-		       (((map->page_00h[SFF8636_WAVE_TOL_HIGH_BYTE_OFFSET] << 8) |
-			 map->page_00h[SFF8636_WAVE_TOL_LOW_BYTE_OFFSET]) * 0.005));
+		module_print_any_float("Laser wavelength",
+				       (((map->page_00h[SFF8636_WAVELEN_HIGH_BYTE_OFFSET] << 8) |
+					map->page_00h[SFF8636_WAVELEN_LOW_BYTE_OFFSET]) * 0.05),
+				       "nm");
+		module_print_any_float("Laser wavelength tolerance",
+				       (((map->page_00h[SFF8636_WAVE_TOL_HIGH_BYTE_OFFSET] << 8) |
+					map->page_00h[SFF8636_WAVE_TOL_LOW_BYTE_OFFSET]) * 0.05),
+				       "nm");
 	}
 }
 
 static void sff8636_show_revision_compliance(const __u8 *id, int rev_offset)
 {
-	static const char *pfx =
-		"\tRevision Compliance                       :";
+	const char *pfx = "Revision Compliance";
+	char value[64] = "";
 
 	switch (id[rev_offset]) {
 	case SFF8636_REV_UNSPECIFIED:
-		printf("%s Revision not specified\n", pfx);
+		sprintf(value, "%s", "Revision not specified");
 		break;
 	case SFF8636_REV_8436_48:
-		printf("%s SFF-8436 Rev 4.8 or earlier\n", pfx);
+		sprintf(value, "%s", "SFF-8436 Rev 4.8 or earlier");
 		break;
 	case SFF8636_REV_8436_8636:
-		printf("%s SFF-8436 Rev 4.8 or earlier\n", pfx);
+		sprintf(value, "%s", "SFF-8436 Rev 4.8 or earlier");
 		break;
 	case SFF8636_REV_8636_13:
-		printf("%s SFF-8636 Rev 1.3 or earlier\n", pfx);
+		sprintf(value, "%s", "SFF-8636 Rev 1.3 or earlier");
 		break;
 	case SFF8636_REV_8636_14:
-		printf("%s SFF-8636 Rev 1.4\n", pfx);
+		sprintf(value, "%s", "SFF-8636 Rev 1.4");
 		break;
 	case SFF8636_REV_8636_15:
-		printf("%s SFF-8636 Rev 1.5\n", pfx);
+		sprintf(value, "%s", "SFF-8636 Rev 1.5");
 		break;
 	case SFF8636_REV_8636_20:
-		printf("%s SFF-8636 Rev 2.0\n", pfx);
+		sprintf(value, "%s", "SFF-8636 Rev 2.0");
 		break;
 	case SFF8636_REV_8636_27:
-		printf("%s SFF-8636 Rev 2.5/2.6/2.7\n", pfx);
+		sprintf(value, "%s", "SFF-8636 Rev 2.5/2.6/2.7");
 		break;
 	default:
-		printf("%s Unallocated\n", pfx);
+		sprintf(value, "%s", "Unallocated");
 		break;
 	}
+	module_print_any_string(pfx, value);
 }
 
 /*
@@ -654,11 +725,18 @@ static void sff8636_show_dom_chan_lvl_tx_bias(const struct sff_diags *sd)
 	char power_string[MAX_DESC_SIZE];
 	int i;
 
+	open_json_array("laser_tx_bias_current", "");
 	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
-			 "Laser tx bias current", i+1);
-		PRINT_BIAS(power_string, sd->scd[i].bias_cur);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.3f",
+				    (double)sd->scd[i].bias_cur / 500.);
+		} else {
+			snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+				 "Laser tx bias current", i+1);
+			PRINT_BIAS(power_string, sd->scd[i].bias_cur);
+		}
 	}
+	close_json_array("");
 }
 
 static void sff8636_show_dom_chan_lvl_tx_power(const struct sff_diags *sd)
@@ -666,29 +744,49 @@ static void sff8636_show_dom_chan_lvl_tx_power(const struct sff_diags *sd)
 	char power_string[MAX_DESC_SIZE];
 	int i;
 
+	open_json_array("transmit_avg_optical_power", "");
 	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
-			 "Transmit avg optical power", i+1);
-		PRINT_xX_PWR(power_string, sd->scd[i].tx_power);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.4f",
+				    (double)sd->scd[i].tx_power / 10000.);
+		} else {
+			snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+				 "Transmit avg optical power", i+1);
+			PRINT_xX_PWR(power_string, sd->scd[i].tx_power);
+		}
 	}
+	close_json_array("");
 }
 
 static void sff8636_show_dom_chan_lvl_rx_power(const struct sff_diags *sd)
 {
+	char *rx_power_type_string = NULL;
 	char power_string[MAX_DESC_SIZE];
-	char *rx_power_string = NULL;
 	int i;
 
 	if (!sd->rx_power_type)
-		rx_power_string = "Receiver signal OMA";
+		rx_power_type_string = "Receiver signal OMA";
 	else
-		rx_power_string = "Rcvr signal avg optical power";
+		rx_power_type_string = "Rcvr signal avg optical power";
 
+	open_json_object("rx_power");
+
+	open_json_array("values", "");
 	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
-			 rx_power_string, i+1);
-		PRINT_xX_PWR(power_string, sd->scd[i].rx_power);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.4f",
+				    (double)sd->scd[i].rx_power / 10000.);
+		} else {
+			snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+				 rx_power_type_string, i+1);
+			PRINT_xX_PWR(power_string, sd->scd[i].rx_power);
+		}
 	}
+	close_json_array("");
+
+	if (is_json_context())
+		module_print_any_string("type", rx_power_type_string);
+	close_json_object();
 }
 
 static void
@@ -698,29 +796,53 @@ sff8636_show_dom_chan_lvl_flags(const struct sff8636_memory_map *map)
 	int i;
 
 	for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
+		bool is_start = (i % SFF8636_MAX_CHANNEL_NUM == 0);
+		bool is_end = (i % SFF8636_MAX_CHANNEL_NUM ==
+			       SFF8636_MAX_CHANNEL_NUM - 1);
+		char json_str[80] = {};
+		char str[80] = {};
+
 		if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
 			continue;
 
+		convert_json_field_name(module_aw_chan_flags[i].fmt_str,
+					json_str);
+
 		value = map->lower_memory[module_aw_chan_flags[i].offset] &
 			module_aw_chan_flags[i].adver_value;
-		printf("\t%-41s (Chan %d) : %s\n",
-		       module_aw_chan_flags[i].fmt_str,
-		       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
-		       value ? "On" : "Off");
+		if (is_json_context()) {
+			if (is_start)
+				open_json_array(json_str, "");
+
+			print_bool(PRINT_JSON, NULL, NULL, value);
+
+			if (is_end)
+				close_json_array("");
+		} else {
+			snprintf(str, 80, "%s (Chan %d)",
+				 module_aw_chan_flags[i].fmt_str,
+				 (i % SFF8636_MAX_CHANNEL_NUM) + 1);
+			printf("\t%-41s : %s\n", str, ONOFF(value));
+		}
+
 	}
 }
 
 static void
 sff8636_show_dom_mod_lvl_flags(const struct sff8636_memory_map *map)
 {
+	bool value;
 	int i;
 
 	for (i = 0; module_aw_mod_flags[i].str; ++i) {
-		if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-			printf("\t%-41s : %s\n",
-			       module_aw_mod_flags[i].str,
-			       ONOFF(map->lower_memory[module_aw_mod_flags[i].offset]
-				     & module_aw_mod_flags[i].value));
+		if (module_aw_mod_flags[i].type != MODULE_TYPE_SFF8636)
+			continue;
+
+		value = map->lower_memory[module_aw_mod_flags[i].offset] &
+			module_aw_mod_flags[i].value;
+
+		module_print_any_bool(module_aw_mod_flags[i].str, NULL,
+				      value, ONOFF(value));
 	}
 }
 
@@ -756,8 +878,9 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	    (sd.sfp_temp[MCURR] == (__s16)0xFFFF))
 		return;
 
-	printf("\t%-41s : %s\n", "Alarm/warning flags implemented",
-		(sd.supports_alarms ? "Yes" : "No"));
+	module_print_any_bool("Alarm/warning flags implemented",
+			      "alarm/warning_flags_implemented",
+			      sd.supports_alarms, YESNO(sd.supports_alarms));
 
 	sff8636_show_dom_chan_lvl_tx_bias(&sd);
 	sff8636_show_dom_chan_lvl_tx_power(&sd);
@@ -767,7 +890,10 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 		sff8636_show_dom_chan_lvl_flags(map);
 		sff8636_show_dom_mod_lvl_flags(map);
 
-		sff_show_thresholds(sd);
+		if (is_json_context())
+			sff_show_thresholds_json(sd);
+		else
+			sff_show_thresholds(sd);
 	}
 }
 
@@ -808,7 +934,7 @@ static void sff8636_show_page_zero(const struct sff8636_memory_map *map)
 	sff8636_show_transceiver(map);
 	sff8636_show_encoding(map);
 	module_show_value_with_unit(map->page_00h, SFF8636_BR_NOMINAL_OFFSET,
-				    "BR, Nominal", 100, "Mbps");
+				    "BR Nominal", 100, "Mbps");
 	sff8636_show_rate_identifier(map);
 	module_show_value_with_unit(map->page_00h, SFF8636_SM_LEN_OFFSET,
 				    "Length (SMF)", 1, "km");
-- 
2.47.0


