Return-Path: <netdev+bounces-160972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DFA1C79A
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAAF1886205
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3749615ADB4;
	Sun, 26 Jan 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oHSil/YT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B7156F39
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892649; cv=fail; b=i9ZuA8m33nm7V3dLGKlB+yuVkMUSXmLMPOMQMKBcl53WIDbB/OXjC7d6HtiDDeRDU4sg5DvxWo8bbL9N0M4d7AOquOD0NmzkwM8rphXyVuHVM6kF9X4VvKIMS1ZHdZuxNzCTA2PWu4a0gSw5lb5vQiIuIsKRtRpxyzZ2H1AjUR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892649; c=relaxed/simple;
	bh=bjKen3qQ3QTMcd5TYDd051eRv9ZRCBcyqkPhJ6f4mDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG+qOnAEEFbj9XMaisVSP/Zx5JlRk9zfn8EToM+Jv0KzSSjw9OfacyjddapxYMMJfJiNhPSi4IutspBmSPOimlMFl8DZj5h5oxsRlVpM/S++r7qrG9DCJwf3JqttZ5q5ADbU2N9f4U4KL9RxvYp1kHVBOoVm8O81kuaXbuDfXt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oHSil/YT; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY5usZNDuSb8vUvY6sJdQSD0QmHcXu3hsRrBhnX6V45TcPrXdxaXFqeDusikUUWR8aQaZfGx6m8A+80Zc8InCESKfIOr4IRd7dWQov7fGFnOpGd8uQg9LFSC36EanOpus/Ced/ylXSd8OWTDoCm68c1xGy96pV3Cl+nqksmcJSseLHSqwHyjFUkNQKjWkMu2KxwyNkMpKalBN6cF0Wrquc7tza6P/9UxON0gt3ZJhyt09G7DqZ4bmbQpiBOZmrSfpG7gBAa87UEX+bX+Q7jCjwiM0ME/cw17CQC+0vCIoSBGG8qz+5W3jNRSE3/daBGkVZ8XUzZM8NjEfZVRdNzjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWN+TXB5m18+0Gknfc6z455q1phIF5e+6tS7BcYOxec=;
 b=dEE0oCBvJQi4Eu2oiDdEg6Ra0nsPkd2zRwxiAYMHDm/M3K5C9YtwD/HsBr+x3ZTPOr4w6eMFp9JEvVBzhVD+iiF8higqOS/bR97WewiyTnOQt4dzmh8RGV9cc0vzXj5475qMpaRIxQ6rSc4jlyEcswg0MLVUO6KGEue1jFd1uwKjCeHETySS1WqGx8w/u1PDcItxlCjJ2IgySFhmJOBs5OsCurU0DBOoBA3hTkI5/tuRpMQtl+cyF7f/zJM0Dxx9Kbe8F10HRwqWQi3n1D1Uknu3fDIMdpf+tVf+4MhotuBMM4HaCyAUefzNYpgoZfotYIbMmm167Uav3eavVbajtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWN+TXB5m18+0Gknfc6z455q1phIF5e+6tS7BcYOxec=;
 b=oHSil/YTcxIxduWmpYzsbU/7FgPHcgAEdroLfrRwKw8g+/zWhtWnCDse94julUXpfT7Ccw0Sm+XqH/VrxA/Z0vE3qjp4OuEDk/xUna697jXwHzO/IBFEcKKWl+UH7174DUj1bRsc+vDBewXJ0dDOspT1k96kA/X3ABgQLcvyw2+eRpOotw6Olis+QFQsEfjotV4/2Z3FAsH8ci6rtfl7Y0/SQE/kyGmJx0877Np52JuFbLYt/zs5UGaf90OtLbUTwHNaka4CpZrfhRPnC2YhLMBQ+Yodt8Z2p1fU54kKwb0ZBLgoj1vCQbwBd0PbX1Is8JABg9Y+axLuQJbb3xAlAA==
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Sun, 26 Jan
 2025 11:57:21 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::43) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sun,
 26 Jan 2025 11:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:07 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:05 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 07/14] cmis: Add JSON output handling to --module-info in CMIS modules
Date: Sun, 26 Jan 2025 13:56:28 +0200
Message-ID: <20250126115635.801935-8-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2b4649-8b4f-44fa-2269-08dd3e0096c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBB03dd6pEPCn1G7S/Yof0WdivoxrLlRdKWJT6SHT01JOgQOkEj6jfWlE8a/?=
 =?us-ascii?Q?GDruuX7G3uDsNvW44YMnqP6hERecSIRMCc8MUZk7CMsHD+OGRTUdZmvGlN6V?=
 =?us-ascii?Q?zFcB/7RePutx+Nvo0xQ7Qbbdr7cTEC4oWB6SINfeuHpLnluk+cMmMlznJF8+?=
 =?us-ascii?Q?hrMwYJQ5EFQ4AgvEXu2+kTrsucgC6awwyLsTi87pKXhwCaWOcoGamgUOKDok?=
 =?us-ascii?Q?Thc97IdClEojImyt8voEXV/B8d5ogBwuEKAbAmnjk/kVYqlct4i328C+SjmX?=
 =?us-ascii?Q?uPFLlTCec+PzEgax7UdHRPTHN7e/oXFZOCqWrB/T5uMz68MjrCFqj+IgenoJ?=
 =?us-ascii?Q?En7JG7zC8YLkDrK0eNQYlZX4MnubUZ59voF05mIdTwb6XHWWwwG0I7qqRg+g?=
 =?us-ascii?Q?+clOLgFvgiuRXPWLzrVS/Zz0gk+VljM15qbEhCG9v0M5EsHSE0FQENwEAoid?=
 =?us-ascii?Q?9mGEsmVM2W9hMOt03qmNvjMsBhERk0P5Kyd06aa/oTbgCmwh6F0kj6DZx9JN?=
 =?us-ascii?Q?MLpe8LcEd41Xp0+DVYoQIWJNABbNT2xwjy+tV3JbUEZsaW/TMspYEBja0oUL?=
 =?us-ascii?Q?t9bqgt8GjPkME3Bklb1XY8ma5+d5g9mQ7mqIeOJjjhGmDWkzsdxNBRtK/NGE?=
 =?us-ascii?Q?IxZy9WSj+r0l1O9JdKoGEr6FdbpwX2Av0VX+MREZiXEtlqNB2owhey6aglsP?=
 =?us-ascii?Q?old3IofsfctG/x2H9IYBa8/qYuT+BQzOWfU6K2KWly0TeOqMWpNt17Qce0X4?=
 =?us-ascii?Q?xWHpeSmoj4/FWHeGloQsSK+BCnbXQK7dlWqMmteVIVsRKsTJo0CAoGRE9xkv?=
 =?us-ascii?Q?+Zb3Vzxj+p9RMIuWmTSWRuH2MGTxbJIxMJXEBM977hah8K/9d4hAubqsCJkx?=
 =?us-ascii?Q?vTKTI71jhhWEOVA1W6BFz9w/qG84XOWRTIQ4Q3tBPJ97TqU232a+kBlEu6+g?=
 =?us-ascii?Q?290xo1NG2lN17LkhYqismPktKhoeDaAUUSeCiN5eEzw+KBzHDV9F3/Ay/zjq?=
 =?us-ascii?Q?WHnyL/VTYDa7NG/DFvsSfaV9F68ZwBXMUv1wtH6KTO4QNjBv7KMTYEN6GO2S?=
 =?us-ascii?Q?1U+DlAGIeFp5pReRkn5ydG9uX5zkz5hrzzn2OCNT5WxYxRaWe8nfnL1WMWUu?=
 =?us-ascii?Q?RL8cywmg7wUB63KQ9Pu2TvSabGZjx4PIBYHO1QhyByJGePPYoa+xaWM4AECe?=
 =?us-ascii?Q?9AFME5Kdmp1U9t3cC2MJmbnhIAAoEQYeJkRDaYP/OA1qqM/f5rdEG2kJoKj4?=
 =?us-ascii?Q?KC0yyQBgmA8HbCPZuSE6IAtoMSs7UmuctZs2lyjRu0EmqJHPoC1Hme/zdbmH?=
 =?us-ascii?Q?WjEQv+O5sk8vASv7uHNuJu4JbJTJ0QEwHio5UjoW1/JQsnij9xjtud1GknWs?=
 =?us-ascii?Q?2S4YDlxn9mjdSaeqFKFFgHsHI+uQrdRpu/eQKFYDi/hixbvDXs+WO3+NP7m7?=
 =?us-ascii?Q?TIhfg1UlrXzwD1eTE8jyiz3rZse1rgmJTXnVP5nTooadslGz+ZRpJX9T2NTB?=
 =?us-ascii?Q?T0lo0I+iMxWjwUU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:20.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2b4649-8b4f-44fa-2269-08dd3e0096c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

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
 cmis.c | 285 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 196 insertions(+), 89 deletions(-)

diff --git a/cmis.c b/cmis.c
index 9d89a5e..4901f57 100644
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
@@ -623,25 +685,39 @@ cmis_show_dom_chan_lvl_rx_power_bank(const struct cmis_memory_map *map,
 				     const struct sff_diags *sd, int bank)
 {
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
+	char *rx_power_str;
 	int i;
 
 	if (!page_11h)
 		return;
 
+	if (!sd->rx_power_type)
+		rx_power_str = "Receiver signal OMA";
+	else
+		rx_power_str = "Rcvr signal avg optical power";
+
+	char rx_power_json_str[strlen(rx_power_str)];
+
+	convert_json_field_name(rx_power_str, rx_power_json_str);
+	open_json_array(rx_power_json_str, "");
+
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
-		char *rx_power_str;
 		char fmt_str[80];
 
-		if (!sd->rx_power_type)
-			rx_power_str = "Receiver signal OMA";
-		else
-			rx_power_str = "Rcvr signal avg optical power";
-
-		snprintf(fmt_str, 80, "%s (Channel %d)", rx_power_str,
-			 chan + 1);
-		PRINT_xX_PWR(fmt_str, sd->scd[chan].rx_power);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.4f",
+				    (double)sd->scd[chan].rx_power / 10000.);
+		} else {
+			snprintf(fmt_str, 80, "%s (Channel %d)", rx_power_str,
+				 chan + 1);
+			PRINT_xX_PWR(fmt_str, sd->scd[chan].rx_power);
+		}
 	}
+	close_json_array("");
+
+	if (is_json_context())
+		module_print_any_units(rx_power_json_str, "mW");
 }
 
 static void cmis_show_dom_chan_lvl_rx_power(const struct cmis_memory_map *map,
@@ -672,10 +748,13 @@ static void cmis_show_dom_mod_lvl_flags(const struct cmis_memory_map *map)
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
 
@@ -692,11 +771,16 @@ static void cmis_show_dom_chan_lvl_flag(const struct cmis_memory_map *map,
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
 
@@ -711,11 +795,19 @@ cmis_show_dom_chan_lvl_flags_bank(const struct cmis_memory_map *map,
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
 
@@ -745,8 +837,12 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
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
@@ -756,14 +852,24 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
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
@@ -811,7 +917,7 @@ static void cmis_show_cdb_instances(const struct cmis_memory_map *map)
 {
 	__u8 cdb_instances = cmis_cdb_instances_get(map);
 
-	printf("\t%-41s : %u\n", "CDB instances", cdb_instances);
+	module_print_any_uint("CDB instances", cdb_instances, NULL);
 }
 
 static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
@@ -819,8 +925,8 @@ static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
 	__u8 mode = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
 		    CMIS_CDB_ADVER_MODE_MASK;
 
-	printf("\t%-41s : %s\n", "CDB background mode",
-	       mode ? "Supported" : "Not supported");
+	module_print_any_string("CDB background mode",
+			        mode ? "Supported" : "Not supported");
 }
 
 static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
@@ -828,7 +934,7 @@ static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
 	__u8 epl_pages = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
 			 CMIS_CDB_ADVER_EPL_MASK;
 
-	printf("\t%-41s : %u\n", "CDB EPL pages", epl_pages);
+	module_print_any_uint("CDB EPL pages", epl_pages, NULL);
 }
 
 static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
@@ -839,9 +945,10 @@ static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
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
@@ -853,8 +960,8 @@ static void cmis_show_cdb_trigger(const struct cmis_memory_map *map)
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


