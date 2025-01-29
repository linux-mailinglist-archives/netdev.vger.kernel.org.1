Return-Path: <netdev+bounces-161500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB35A21DBA
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA5216844B
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29632C8B;
	Wed, 29 Jan 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C+Aq9SgD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC30BA50
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156601; cv=fail; b=NUST98ct7vJ87jWBoYcTyGzFf+bLRzDAemAzKYc2sczqILmaDPSBYN/Za9yQ16/9OhkSd9BQ8dxHXxAx1l2krUnivYWx/gtoAxMT51C8ACWqsPtn2T04QwnWtKCaWK92MebTivvpsJLwTrvAkrPBB8VD5PcSKGBQtk2i5ZFasjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156601; c=relaxed/simple;
	bh=+IYP2J32R1natP5PJ8n/yuepDnuxG9YkTtW1TnqmPhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyyi5Y1NDZC7SMRJ+lGZ3paP5PJ2jlozhnqfaMEjbih8yzPoXyo8E8ej7ufOMOtoGVUcG5nIm5qLpjyncWvLVyTjofH++Lxfmz8UCbk5VnJG3HEeM90GvmHqb2sgGLfyHY2jTxQHMiU19EPe+ddJ3tQNt7cyXnYxmti+dTqG4zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C+Aq9SgD; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUu11efMUAaNGguLUbeSAamtdgZMYwgdMSnCc3HqZNB7IhrpIcnHBZ05sgvKPNQ0dpLOAHORaG9NguQl70LEpVoTmYjLLKcs8DeZGy9ODibtyLBdr/4CV8YpZUEh1NnmdSwAhSJX8K/hRygyJzKk/nAf3ZBcg3sgmXGIqhKM+E63Af26KfD1ZQhC3bGZIkFX5Yqq01E36uKTqjKqn2aJg8jM/Hzf5/P8NI1JK2EOfjbIOxAX04Frn1euT7Z+htl/jBvdLPCLC75yOayi7Dd3hx1zYXJOXQRz1vIPVpmYjMFwfkcLwXwTNHHhS7lFwUTomCwVopObtvH95xdyRvtfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tuIE61Ct+pKS4jr5tGLxYP76rd+40WfPjql2Nt8hkk=;
 b=Uk1YHCtlyQwvyugJpjj7hupBw7woFUesVZA71yW+FtiPA0TJ9tmwX/KjebXTCslc9Lvm2PF2gUPbZjyY2S/Y/H2WGSTVe6ImH670z0YtMnm5LE/86+UaNwbqEdrwzXcq7ygQFj/DzdDXywHTx6FFWl5N7ELaTdbiP2pD2uJAi8hAhk/dCX0oNQ4yDIdIC4DcxFvPlGdjjHkvLB0r5/dHlyENNa90+c0Zf3n4A8tJScNS/h2KoQnvMhBZ2OAEGdZ1hPz6AJWRiHuCOtsU6145gjZiIf9IFhHx00xcn7RNczzR60kzoNGUB2doXId8IaO3x/fMaUD6/CXDey8x5sYJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tuIE61Ct+pKS4jr5tGLxYP76rd+40WfPjql2Nt8hkk=;
 b=C+Aq9SgDL3hWTYUxGA/kPS+303btc6G5Pkbbgn3VUobg5Ns3XGZtd3tuNOKZV940vIUcSCq+1GA80UTLZfU5Llz1SmZZUHoActE7gCr5w34Qvi0dHT7pS6xCIiE4N65ufxeZdKlhfK6rN6eqlFv2n8rN7XetYal1cDa8Owo4ySPO9SQTtRauXKH86pvvPhcNI/pras98RXMz5uXy+4bgKdHANRYchXnXoBgCTqyevhY5XA1QUkQO38NiFb+y/MqQXPkTlRck9+klif2f1GRFe2Np00rTnJyOFgApWhgQ8fXYsV8E0owePFl5/Fni9RMOGtaQrVmYpvM3/f9tXLqzeQ==
Received: from CH0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:610:e6::20)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 13:16:31 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::bd) by CH0PR03CA0285.outlook.office365.com
 (2603:10b6:610:e6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 29 Jan 2025 13:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:19 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:17 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 07/14] cmis: Add JSON output handling to --module-info in CMIS modules
Date: Wed, 29 Jan 2025 15:15:40 +0200
Message-ID: <20250129131547.964711-8-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 6826a7d7-ef35-4b32-88b3-08dd406725ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3HdA1eXfAMt2jxX2iNy3tq4lj3dwpbYbiZytdb9xbY6AagDwPeed1J9d2Z7B?=
 =?us-ascii?Q?xyMPtnZ2Q4R8Eej9oMl5m6KJYq1b+dySGKQcNg3X0KMBwHA7JGha6yXXo21R?=
 =?us-ascii?Q?PRm5Dah2Lnczq5sPRuQLNRWXmt9JMXBIRwHjYINeti57vO7hVTrAjGWb62mB?=
 =?us-ascii?Q?TLwgjjObJM25YMh4cGTOnmcEK9AiT60ug+4Qu0ieIAxtdRVw7pVKv8Qyo7eV?=
 =?us-ascii?Q?fqLkjwHTUovRAAOvuKRLkYGNtCVPSAql0nVp3KFXxUsf/TetT4ZEe/x35zP/?=
 =?us-ascii?Q?jktBvZwo9yZx/fOlJHo7KGLKKXTs3s9Pts8wq+uJAGMYk/X5A7eYbPZ3vBJw?=
 =?us-ascii?Q?+jpJ1IPe7czucBanfkmulUMN/Lg44Gt43wShSo8ctMvJjZdhtz35HF4IJ0bU?=
 =?us-ascii?Q?Ccy0vFDo8EYVDPFdxtSsAAZsQ9UVGCK0LDDJ637wgGZkOSrwW55LwgRms5V6?=
 =?us-ascii?Q?WcnROISzl2BMF50zU6l3N0c10X8MzqPkJB5ZRXoDKQAp9zq1c6dp92RUI4Tc?=
 =?us-ascii?Q?5kjicX2iEbMNbAEvXsFwAgiBCEV5Txfka/at4GklS3nsEVSHFs1FZ5Ehe9Vw?=
 =?us-ascii?Q?wkLl0x8kepSikCUGs9FACOUOm7s1n+6n14f1Bgrv3rOchE3AYnJstuYYU0vj?=
 =?us-ascii?Q?4zeb3ntifTV7o7tw4hplKVg3nrwMTK3CCRAfylQi4/PLVintqvME/ClwF5yK?=
 =?us-ascii?Q?nX0v8WMY86u5pdVRNQ3UIXYE8A+T34DDQlFuIWArNsxD91qtCPI22SABTm6I?=
 =?us-ascii?Q?5mb8GNmCu9w+gQ+XR8CRuSzhCSFcDa2eNcL7hgjc4IrLhdVOOqm/dmenHttJ?=
 =?us-ascii?Q?ydI484ceZ/T81oaJbDn2Hy+Pw7vOXJku03Ot+hcSRqznhpLZYG4mE2ulNEad?=
 =?us-ascii?Q?WQDlNTpRcDLhK3IcZ6X+VOhEpETu9ztSrFay8/E1QbR5TRjLe2QqQYzCiDce?=
 =?us-ascii?Q?W5836U4gkkgKSpstuyn/2bMu8ddS3aYDcqeB3BQ6AdBX2snQPuyWP1krhc6t?=
 =?us-ascii?Q?gSXSXpO9k9ZXVlV6PVFvxu/qrseh3ybUiGBoqyE706Ob5ZWPYdzJ/ZSTXJuw?=
 =?us-ascii?Q?Ugc+rv2chkotoqjFYm24u2lYwNOmLFHrjbqXtHxK+tPyApcYNm4cI0u4hSZL?=
 =?us-ascii?Q?gpoqla/7BTYhPu9wAWqOVbaLsqP85d7GbmqMlmYd+z6O74RAejRe1OSf2d87?=
 =?us-ascii?Q?NI1TJ/NIZk5szViGn772dcs5xxS+Lr4feuBhhReZXJqLyfovLKzGpal+By8r?=
 =?us-ascii?Q?vEvpmO/WO9QGqklu55j6QaG8vRAwiAxbKz90Imt41eNVMcUEOLmKPodTM5QN?=
 =?us-ascii?Q?wSpjVG/50dX3ENStIKKgpdJ5UL+dRd3F9ZJ9m+riJq4ZVRNjv5YOr6sBWT+g?=
 =?us-ascii?Q?lrbbfrnZwDbBDCx59w1q+hRoNeT9YNFovZT9ekYD1L6f4KKa9ETuvRu+cwi7?=
 =?us-ascii?Q?2HnS+wYhhqGYVh9LLK6mTz9PibmAiymHq3hyOefi5oF5r//HAXsXNYrlHxhd?=
 =?us-ascii?Q?fkGI65I2/6eqOGM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:31.2879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6826a7d7-ef35-4b32-88b3-08dd406725ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708

Add JSON output handling for 'ethtool -m' / --module-info, following the
guideline below:

1. Fields with description, will have a separate description field.
2. Fields with units, will have a separate unit field.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub fields.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Use uint instead of hexa fields in JSON context.
    	* In rx_power JSON field, add a type field to let the user know
    	  what type is printed in "value".

 cmis.c | 284 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 196 insertions(+), 88 deletions(-)

diff --git a/cmis.c b/cmis.c
index 9d89a5e..4c759e8 100644
--- a/cmis.c
+++ b/cmis.c
@@ -62,7 +62,15 @@ static void cmis_show_rev_compliance(const struct cmis_memory_map *map)
 	int major = (rev >> 4) & 0x0F;
 	int minor = rev & 0x0F;
 
-	printf("\t%-41s : Rev. %d.%d\n", "Revision compliance", major, minor);
+	if (is_json_context()) {
+		open_json_object("revision_compliance");
+		print_uint(PRINT_JSON, "major", "%u", major);
+		print_uint(PRINT_JSON, "minor", "%u", minor);
+		close_json_object();
+	} else {
+		printf("\t%-41s : Rev. %d.%d\n", "Revision compliance", major,
+		       minor);
+	}
 }
 
 static void
@@ -123,8 +131,8 @@ static void cmis_show_power_info(const struct cmis_memory_map *map)
 	base_power = map->page_00h[CMIS_PWR_MAX_POWER_OFFSET];
 	max_power = base_power * 0.25f;
 
-	printf("\t%-41s : %d\n", "Power class", power_class + 1);
-	printf("\t%-41s : %.02fW\n", "Max power", max_power);
+	module_print_any_uint("Power class", power_class + 1, NULL);
+	module_print_any_float("Max power", max_power, "W");
 }
 
 /**
@@ -143,7 +151,7 @@ static void cmis_show_cbl_asm_len(const struct cmis_memory_map *map)
 
 	/* Check if max length */
 	if (map->page_00h[CMIS_CBL_ASM_LEN_OFFSET] == CMIS_6300M_MAX_LEN) {
-		printf("\t%-41s : > 6.3km\n", fn);
+		module_print_any_string(fn, "> 6.3km");
 		return;
 	}
 
@@ -168,7 +176,7 @@ static void cmis_show_cbl_asm_len(const struct cmis_memory_map *map)
 	/* Get base value from first 6 bits and multiply by mul */
 	val = (map->page_00h[CMIS_CBL_ASM_LEN_OFFSET] & CMIS_LEN_VAL_MASK);
 	val = (float)val * mul;
-	printf("\t%-41s : %0.2fm\n", fn, val);
+	module_print_any_float(fn, val, "m");
 }
 
 /**
@@ -202,7 +210,7 @@ static void cmis_print_smf_cbl_len(const struct cmis_memory_map *map)
 	/* Get base value from first 6 bits and multiply by mul */
 	val = (map->page_01h[CMIS_SMF_LEN_OFFSET] & CMIS_LEN_VAL_MASK);
 	val = (float)val * mul;
-	printf("\t%-41s : %0.2fkm\n", fn, val);
+	module_print_any_float(fn, val, "km");
 }
 
 /**
@@ -212,22 +220,26 @@ static void cmis_print_smf_cbl_len(const struct cmis_memory_map *map)
  */
 static void cmis_show_sig_integrity(const struct cmis_memory_map *map)
 {
+	bool value;
+
 	if (!map->page_01h)
 		return;
 
 	/* CDR Bypass control: 2nd bit from each byte */
-	printf("\t%-41s : ", "Tx CDR bypass control");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x02));
+	value = map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x02;
+	module_print_any_bool("Tx CDR bypass control", NULL, value,
+			      YESNO(value));
 
-	printf("\t%-41s : ", "Rx CDR bypass control");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x02));
+	value = map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x02;
+	module_print_any_bool("Rx CDR bypass control", NULL, value,
+			      YESNO(value));
 
 	/* CDR Implementation: 1st bit from each byte */
-	printf("\t%-41s : ", "Tx CDR");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x01));
+	value = map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x01;
+	module_print_any_bool("Tx CDR", NULL, value, YESNO(value));
 
-	printf("\t%-41s : ", "Rx CDR");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x01));
+	value = map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x01;
+	module_print_any_bool("Rx CDR", NULL, value, YESNO(value));
 }
 
 /**
@@ -247,21 +259,25 @@ static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 	module_show_mit_compliance(value);
 
 	if (value >= CMIS_COPPER_UNEQUAL) {
-		printf("\t%-41s : %udb\n", "Attenuation at 5GHz",
-		       map->page_00h[CMIS_COPPER_ATT_5GHZ]);
-		printf("\t%-41s : %udb\n", "Attenuation at 7GHz",
-		       map->page_00h[CMIS_COPPER_ATT_7GHZ]);
-		printf("\t%-41s : %udb\n", "Attenuation at 12.9GHz",
-		       map->page_00h[CMIS_COPPER_ATT_12P9GHZ]);
-		printf("\t%-41s : %udb\n", "Attenuation at 25.8GHz",
-		       map->page_00h[CMIS_COPPER_ATT_25P8GHZ]);
+		module_print_any_uint("Attenuation at 5GHz",
+				      map->page_00h[CMIS_COPPER_ATT_5GHZ], "db");
+		module_print_any_uint("Attenuation at 7GHz",
+				      map->page_00h[CMIS_COPPER_ATT_7GHZ], "db");
+		module_print_any_uint("Attenuation at 12.9GHz",
+				      map->page_00h[CMIS_COPPER_ATT_12P9GHZ],
+				      "db");
+		module_print_any_uint("Attenuation at 25.8GHz",
+				      map->page_00h[CMIS_COPPER_ATT_25P8GHZ],
+				      "db");
 	} else if (map->page_01h) {
-		printf("\t%-41s : %.3lfnm\n", "Laser wavelength",
-		       (((map->page_01h[CMIS_NOM_WAVELENGTH_MSB] << 8) |
-			  map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05));
-		printf("\t%-41s : %.3lfnm\n", "Laser wavelength tolerance",
-		       (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
-			  map->page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.005));
+		module_print_any_float("Laser wavelength",
+				       (((map->page_01h[CMIS_NOM_WAVELENGTH_MSB] << 8) |
+				        map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
+				       "nm");
+		module_print_any_float("Laser wavelength tolerance",
+				       (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
+				        map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
+				       "nm");
 	}
 }
 
@@ -314,6 +330,8 @@ static void cmis_show_vendor_info(const struct cmis_memory_map *map)
 				  CMIS_CLEI_END_OFFSET, "CLEI code");
 }
 
+#define CMIS_MAX_DESC_LEN	64
+
 /* Print the current Module State. Relevant documents:
  * [1] CMIS Rev. 5, pag. 57, section 6.3.2.2, Figure 6-3
  * [2] CMIS Rev. 5, pag. 60, section 6.3.2.3, Figure 6-4
@@ -321,31 +339,40 @@ static void cmis_show_vendor_info(const struct cmis_memory_map *map)
  */
 static void cmis_show_mod_state(const struct cmis_memory_map *map)
 {
+	char mod_state_description[CMIS_MAX_DESC_LEN];
 	__u8 mod_state;
 
 	mod_state = (map->lower_memory[CMIS_MODULE_STATE_OFFSET] &
 		     CMIS_MODULE_STATE_MASK) >> 1;
-	printf("\t%-41s : 0x%02x", "Module State", mod_state);
 	switch (mod_state) {
 	case CMIS_MODULE_STATE_MODULE_LOW_PWR:
-		printf(" (ModuleLowPwr)\n");
+		strncpy(mod_state_description, "ModuleLowPwr",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_PWR_UP:
-		printf(" (ModulePwrUp)\n");
+		strncpy(mod_state_description, "ModulePwrUp",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_READY:
-		printf(" (ModuleReady)\n");
+		strncpy(mod_state_description, "ModuleReady",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_PWR_DN:
-		printf(" (ModulePwrDn)\n");
+		strncpy(mod_state_description, "ModulePwrDn",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_FAULT:
-		printf(" (ModuleFault)\n");
+		strncpy(mod_state_description, "ModuleFault",
+			CMIS_MAX_DESC_LEN);
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		strncpy(mod_state_description, "reserved or unknown",
+			CMIS_MAX_DESC_LEN);
 		break;
 	}
+
+	sff_print_any_hex_field("Module state", "module_state",
+				mod_state, mod_state_description);
 }
 
 /* Print the Module Fault Information. Relevant documents:
@@ -354,6 +381,7 @@ static void cmis_show_mod_state(const struct cmis_memory_map *map)
  */
 static void cmis_show_mod_fault_cause(const struct cmis_memory_map *map)
 {
+	char fault_cause_description[CMIS_MAX_DESC_LEN];
 	__u8 mod_state, fault_cause;
 
 	mod_state = (map->lower_memory[CMIS_MODULE_STATE_OFFSET] &
@@ -362,24 +390,31 @@ static void cmis_show_mod_fault_cause(const struct cmis_memory_map *map)
 		return;
 
 	fault_cause = map->lower_memory[CMIS_MODULE_FAULT_OFFSET];
-	printf("\t%-41s : 0x%02x", "Module Fault Cause", fault_cause);
 	switch (fault_cause) {
 	case CMIS_MODULE_FAULT_NO_FAULT:
-		printf(" (No fault detected / not supported)\n");
+		strncpy(fault_cause_description,
+			"No fault detected / not supported", CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_FAULT_TEC_RUNAWAY:
-		printf(" (TEC runaway)\n");
+		strncpy(fault_cause_description, "TEC runaway",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_FAULT_DATA_MEM_CORRUPTED:
-		printf(" (Data memory corrupted)\n");
+		strncpy(fault_cause_description, "Data memory corrupted",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_FAULT_PROG_MEM_CORRUPTED:
-		printf(" (Program memory corrupted)\n");
+		strncpy(fault_cause_description, "Program memory corrupted",
+			CMIS_MAX_DESC_LEN);
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		strncpy(fault_cause_description, "reserved or unknown",
+			CMIS_MAX_DESC_LEN);
 		break;
 	}
+
+	sff_print_any_hex_field("Module Fault Cause", "module_fault_cause",
+				fault_cause, fault_cause_description);
 }
 
 /* Print the current Module-Level Controls. Relevant documents:
@@ -388,12 +423,17 @@ static void cmis_show_mod_fault_cause(const struct cmis_memory_map *map)
  */
 static void cmis_show_mod_lvl_controls(const struct cmis_memory_map *map)
 {
-	printf("\t%-41s : ", "LowPwrAllowRequestHW");
-	printf("%s\n", ONOFF(map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
-			     CMIS_LOW_PWR_ALLOW_REQUEST_HW_MASK));
-	printf("\t%-41s : ", "LowPwrRequestSW");
-	printf("%s\n", ONOFF(map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
-			     CMIS_LOW_PWR_REQUEST_SW_MASK));
+	bool value;
+
+	value = map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
+		CMIS_LOW_PWR_ALLOW_REQUEST_HW_MASK;
+	module_print_any_bool("LowPwrAllowRequestHW", "low_pwr_allow_request_hw",
+			      value, ONOFF(value));
+
+	value = map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
+		CMIS_LOW_PWR_REQUEST_SW_MASK;
+	module_print_any_bool("LowPwrRequestSW", "low_pwr_request_sw", value,
+			      ONOFF(value));
 }
 
 static void cmis_parse_dom_power_type(const struct cmis_memory_map *map,
@@ -557,14 +597,25 @@ cmis_show_dom_chan_lvl_tx_bias_bank(const struct cmis_memory_map *map,
 	if (!page_11h)
 		return;
 
+	open_json_array("laser_tx_bias_current", "");
+
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char fmt_str[80];
 
-		snprintf(fmt_str, 80, "%s (Channel %d)",
-			 "Laser tx bias current", chan + 1);
-		PRINT_BIAS(fmt_str, sd->scd[chan].bias_cur);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.3f",
+				    (double)sd->scd[chan].bias_cur / 500.);
+		} else {
+			snprintf(fmt_str, 80, "%s (Channel %d)",
+				 "Laser tx bias current", chan + 1);
+			PRINT_BIAS(fmt_str, sd->scd[chan].bias_cur);
+		}
 	}
+	close_json_array("");
+
+	if (is_json_context())
+		module_print_any_units("laser_tx_bias_current", "mA");
 }
 
 static void cmis_show_dom_chan_lvl_tx_bias(const struct cmis_memory_map *map,
@@ -593,14 +644,25 @@ cmis_show_dom_chan_lvl_tx_power_bank(const struct cmis_memory_map *map,
 	if (!page_11h)
 		return;
 
+	open_json_array("transmit_avg_optical_power", "");
+
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char fmt_str[80];
 
-		snprintf(fmt_str, 80, "%s (Channel %d)",
-			 "Transmit avg optical power", chan + 1);
-		PRINT_xX_PWR(fmt_str, sd->scd[chan].tx_power);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.4f",
+				    (double)sd->scd[chan].tx_power / 10000.);
+		} else {
+			snprintf(fmt_str, 80, "%s (Channel %d)",
+				 "Transmit avg optical power", chan + 1);
+			PRINT_xX_PWR(fmt_str, sd->scd[chan].tx_power);
+		}
 	}
+	close_json_array("");
+
+	if (is_json_context())
+		module_print_any_units("transmit_avg_optical_power", "mW");
 }
 
 static void cmis_show_dom_chan_lvl_tx_power(const struct cmis_memory_map *map,
@@ -623,25 +685,40 @@ cmis_show_dom_chan_lvl_rx_power_bank(const struct cmis_memory_map *map,
 				     const struct sff_diags *sd, int bank)
 {
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
+	char *rx_power_type_str;
 	int i;
 
 	if (!page_11h)
 		return;
 
+	if (!sd->rx_power_type)
+		rx_power_type_str = "Receiver signal OMA";
+	else
+		rx_power_type_str = "Rcvr signal avg optical power";
+
+	open_json_object("rx_power");
+
+	open_json_array("values", "");
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
-		char *rx_power_str;
 		char fmt_str[80];
 
-		if (!sd->rx_power_type)
-			rx_power_str = "Receiver signal OMA";
-		else
-			rx_power_str = "Rcvr signal avg optical power";
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.4f",
+				    (double)sd->scd[chan].rx_power / 10000.);
+		} else {
+			snprintf(fmt_str, 80, "%s (Channel %d)",
+				 rx_power_type_str, chan + 1);
+			PRINT_xX_PWR(fmt_str, sd->scd[chan].rx_power);
+		}
+	}
+	close_json_array("");
 
-		snprintf(fmt_str, 80, "%s (Channel %d)", rx_power_str,
-			 chan + 1);
-		PRINT_xX_PWR(fmt_str, sd->scd[chan].rx_power);
+	if (is_json_context()) {
+		print_string(PRINT_JSON, "units", "%s", "mW");
+		module_print_any_string("type", rx_power_type_str);
 	}
+	close_json_object();
 }
 
 static void cmis_show_dom_chan_lvl_rx_power(const struct cmis_memory_map *map,
@@ -672,10 +749,13 @@ static void cmis_show_dom_mod_lvl_flags(const struct cmis_memory_map *map)
 	int i;
 
 	for (i = 0; module_aw_mod_flags[i].str; i++) {
-		if (module_aw_mod_flags[i].type == MODULE_TYPE_CMIS)
-			printf("\t%-41s : %s\n", module_aw_mod_flags[i].str,
-			       map->lower_memory[module_aw_mod_flags[i].offset] &
-			       module_aw_mod_flags[i].value ? "On" : "Off");
+		if (module_aw_mod_flags[i].type == MODULE_TYPE_CMIS) {
+			bool value = map->lower_memory[module_aw_mod_flags[i].offset] &
+					module_aw_mod_flags[i].value;
+
+			module_print_any_bool(module_aw_mod_flags[i].str, NULL,
+					      value, ONOFF(value));
+		}
 	}
 }
 
@@ -692,11 +772,16 @@ static void cmis_show_dom_chan_lvl_flag(const struct cmis_memory_map *map,
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char str[80];
-
-		snprintf(str, 80, module_aw_chan_flags[flag].fmt_str, chan + 1);
-		printf("\t%-41s : %s\n", str,
-		       page_11h[module_aw_chan_flags[flag].offset] & chan ?
-		       "On" : "Off");
+		bool value;
+
+		value = page_11h[module_aw_chan_flags[flag].offset] & chan;
+		if (is_json_context()) {
+			print_bool(PRINT_JSON, NULL, NULL, value);
+		} else {
+			snprintf(str, 80, "%s (Chan %d)",
+				 module_aw_chan_flags[flag].fmt_str, chan + 1);
+			printf("\t%-41s : %s\n", str, ONOFF(value));
+		}
 	}
 }
 
@@ -711,11 +796,19 @@ cmis_show_dom_chan_lvl_flags_bank(const struct cmis_memory_map *map,
 		return;
 
 	for (flag = 0; module_aw_chan_flags[flag].fmt_str; flag++) {
-		if (!(map->page_01h[module_aw_chan_flags[flag].adver_offset] &
-		      module_aw_chan_flags[flag].adver_value))
-			continue;
-
-		cmis_show_dom_chan_lvl_flag(map, bank, flag);
+		char json_str[80] = {};
+
+		if (module_aw_chan_flags[flag].type == MODULE_TYPE_CMIS) {
+			if (!(map->page_01h[module_aw_chan_flags[flag].adver_offset] &
+			   module_aw_chan_flags[flag].adver_value))
+				continue;
+
+			convert_json_field_name(module_aw_chan_flags[flag].fmt_str,
+						json_str);
+			open_json_array(json_str, "");
+			cmis_show_dom_chan_lvl_flag(map, bank, flag);
+			close_json_array("");
+		}
 	}
 }
 
@@ -745,8 +838,12 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
 	cmis_show_dom_chan_lvl_monitors(map, &sd);
 	cmis_show_dom_mod_lvl_flags(map);
 	cmis_show_dom_chan_lvl_flags(map);
-	if (sd.supports_alarms)
-		sff_show_thresholds(sd);
+	if (sd.supports_alarms) {
+		if (is_json_context())
+			sff_show_thresholds_json(sd);
+		else
+			sff_show_thresholds(sd);
+	}
 }
 
 /* Print active and inactive firmware versions. Relevant documents:
@@ -756,14 +853,24 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
 static void cmis_show_fw_version_common(const char *name, __u8 major,
 					__u8 minor)
 {
+	char json_fn[32] = "";
+
 	if (major == 0 && minor == 0) {
 		return;
 	} else if (major == 0xFF && minor == 0xFF) {
-		printf("\t%-41s : Invalid\n", name);
+		module_print_any_string(name, "Invalid");
 		return;
 	}
 
-	printf("\t%-41s : %d.%d\n", name, major, minor);
+	if (is_json_context()) {
+		convert_json_field_name(name, json_fn);
+		open_json_object(json_fn);
+		print_uint(PRINT_JSON, "major", "%u", major);
+		print_uint(PRINT_JSON, "minor", "%u", minor);
+		close_json_object();
+	} else {
+		printf("\t%-41s : %d.%d\n", name, major, minor);
+	}
 }
 
 static void cmis_show_fw_active_version(const struct cmis_memory_map *map)
@@ -811,7 +918,7 @@ static void cmis_show_cdb_instances(const struct cmis_memory_map *map)
 {
 	__u8 cdb_instances = cmis_cdb_instances_get(map);
 
-	printf("\t%-41s : %u\n", "CDB instances", cdb_instances);
+	module_print_any_uint("CDB instances", cdb_instances, NULL);
 }
 
 static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
@@ -819,8 +926,8 @@ static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
 	__u8 mode = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
 		    CMIS_CDB_ADVER_MODE_MASK;
 
-	printf("\t%-41s : %s\n", "CDB background mode",
-	       mode ? "Supported" : "Not supported");
+	module_print_any_string("CDB background mode",
+			        mode ? "Supported" : "Not supported");
 }
 
 static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
@@ -828,7 +935,7 @@ static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
 	__u8 epl_pages = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
 			 CMIS_CDB_ADVER_EPL_MASK;
 
-	printf("\t%-41s : %u\n", "CDB EPL pages", epl_pages);
+	module_print_any_uint("CDB EPL pages", epl_pages, NULL);
 }
 
 static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
@@ -839,9 +946,10 @@ static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
 	 * units of 8 bytes, in addition to the minimum 8 bytes.
 	 */
 	rw_len = (rw_len + 1) * 8;
-	printf("\t%-41s : %u\n", "CDB Maximum EPL RW length", rw_len);
-	printf("\t%-41s : %u\n", "CDB Maximum LPL RW length",
-	       rw_len > CMIS_PAGE_SIZE ? CMIS_PAGE_SIZE : rw_len);
+	module_print_any_uint("CDB Maximum EPL RW length", rw_len, NULL);
+	module_print_any_uint("CDB Maximum LPL RW length",
+			      rw_len > CMIS_PAGE_SIZE ? CMIS_PAGE_SIZE : rw_len,
+			      NULL);
 }
 
 static void cmis_show_cdb_trigger(const struct cmis_memory_map *map)
@@ -853,8 +961,8 @@ static void cmis_show_cdb_trigger(const struct cmis_memory_map *map)
 	 * page, or by multiple writes ending with the writing of the CDB
 	 * Command Code (CMDID).
 	 */
-	printf("\t%-41s : %s\n", "CDB trigger method",
-	       trigger ? "Single write" : "Multiple writes");
+	module_print_any_string("CDB trigger method",
+				trigger ? "Single write" : "Multiple writes");
 }
 
 /* Print CDB messaging support advertisement. Relevant documents:
-- 
2.47.0


