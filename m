Return-Path: <netdev+bounces-162554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F5A27387
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AD21887B02
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5A216607;
	Tue,  4 Feb 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KkyEkr9S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784E2165E8
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676453; cv=fail; b=tG9PXAa7VkPjPDOzhlYvZ/dmhXb0h5CLvxcjc/8SiT4HLUnwmW3eihH9EgBmk85X56nkazFGVfK2OJbjZckxiDhAu4+rHun87S8gTPyfIQxr/o57hdpc/P9xGSsrQ95D5TwRdXtqWoHqKk8s15IGurWrOyRMYy6ReXabJgpCOOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676453; c=relaxed/simple;
	bh=OMXUxPpaoTGAa0+BFNZRmrJqxBa8e4wG2Zwx2i64lYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7H07pGXPZ+J1c8d8JSBa37hwhca8hHw0gFct5+QQNPP3ZIygL7TfBmY6vV4E5nrXnB3x/tYGlzDVIBxGTrsL1/mW9QklVUUaG8LOte28KMWjaDLsE2j41EFrqvGndMQ2tlkEtAUMKbMjpoyfIZn0+pMgENGrufZk961kJ4HhNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KkyEkr9S; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI6/anp+/YOnpVJvfIBOJhtbMhTygZRUUpCm7xyFNhhjC+ZRISlCaoIa6iPdpB+zkfukL3GmDTZhik4OOx+jU2XYtlDw3bJkTvb8LGzrXhaOWH55Uv0syMnzQvSx1iDE2vOEmykowAq+xrg90QS8NeRRTn36YoRsxIJlxOYMWy+gX/E6tHQg9rCGVrW09fxDjtLShU/oMs9w0HPfnBPF2XEz2HAFJRaQRLDG3nA6hFitdVV68IhfOPFqwE4a/s/gSlq9E5iZYg5XTnQgD3sj3mw4LTpTrbvZ9tKdy6q8DUrFqOr+kyf2qZE7WeOLoGm1HqNiQwOzZcp6zjxKiu1u4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhDBHLFy62jan21ZOG9LCLCeyXmLMsk5QpYRf0mAyIQ=;
 b=yKTO9/XrAWs+jKqDBVIk/KdGz3dTVWz2y+mwIdGe7uT5q9P1Ul0QzrB6OugIs/9uaZv2wnvufT7py7WLMaBVqRv3kHUhdcWUHjbM2pvtUaMK7Qg2UY+7fwgfaV61P59rBwymS9vKd0AiDOba5GJDMhuRWzUWrYGdD3fQC4rWvqjT6nB8AKdqTXFimRVJHslWfTW4igAYDTLd4eMoAffL9RusB0xcxRc4g/kEUfUkS9aopVXIHSj5xSCPp4j2AM7Mz2dspOblh+JpJV8xE9c2lkv740YPOzsv9CLkNs5UUxZHnz1VeRHpZTqvwbvyVwE9mPWJ9XdR6R39jTlZc0Epdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhDBHLFy62jan21ZOG9LCLCeyXmLMsk5QpYRf0mAyIQ=;
 b=KkyEkr9SXq9up2ZujbdYMtCcD9OelwLtiQ+Uo/Ip6Wx/WcCKC31Uqu706iTfKc2U3GdZLcKLEg1FjcpscG6sjaTOHOQ4DxJSrugbvf2odZ7pBsVa3HrRyBjYpbjg4E0foJuCBtnTgjMeHRtGSvxhoPZIcihSc9HemLbnpgGD8xPc2RwNOgrAOevGfdJlFxuMQjaGXTc94lVmWvED2k07hi9U53ljhskKf+L3ZE0HmOZlLTZFzSYWIwR2hpbgHF/WnVwgKUjcCEB+dYR6/8/YuoS+DnLUvlUt8COYbxBLrlLRTLE6F4PWooV3mWjLtKFLsEokudLcuI9DcaG4uWapgg==
Received: from MN2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:208:23e::27)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:40:48 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::36) by MN2PR14CA0022.outlook.office365.com
 (2603:10b6:208:23e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 13:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:27 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:25 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 06/16] qsfp: Refactor sff8636_show_dom() by moving code into separate functions
Date: Tue, 4 Feb 2025 15:39:47 +0200
Message-ID: <20250204133957.1140677-7-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b15323d-d008-4e9e-87f5-08dd4521888f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1g94IFTQq3FxEKlqdGKcNeHFTkx1Q2AhTQcxkpT4ZakLGNaZ+LNvSff9yvXv?=
 =?us-ascii?Q?9s3sN21hbgoLB4tyssTIsXEMz61mlWZAq740SZWIgwmie00AG6s0dpcKJ6Mo?=
 =?us-ascii?Q?K/qUzTN0IXacPbFYz6PrqVhy9vpXXltHaOomFznrNua7o3YZiUIWqCNskjNe?=
 =?us-ascii?Q?5U3sMVwwWCClHCyxiE/LxOCc+/cvZPmljlyOHxR9+fhuyIXfIB6AJjUCxQOD?=
 =?us-ascii?Q?Ob2Oc9zTRq8VL+5FfgAmSvAOTHV6u6zV3oD8zmiAxFs/FxBdw8A7Oqd+SF2p?=
 =?us-ascii?Q?WtEHikynmq2HtqdXSAhU1HDEerNtXuA3wz5gFD9xoThKaEvMC/eaIrT+r+9k?=
 =?us-ascii?Q?HLTotmKxOYDOOymlzH10syrk0s8evImjMsHyVdKDTXq5rOz0XPTFSaKFLbva?=
 =?us-ascii?Q?Gm6TgUBxT33wExRRSSKQKtLxD3DKFe31nOfv+65DjqWvOJqdTIflbwOp2/yo?=
 =?us-ascii?Q?WFcV0eaUZ+4S2pm9dTSMKqBjDqy+ilP8rOPo5Z3J3XDdVkpdf21mAJBvYCRo?=
 =?us-ascii?Q?5Pu9zOoP/vq8OYqAyymuMfANJYGpCWPLa9mWKbAPWw65P6GFl726XgP7ClmJ?=
 =?us-ascii?Q?z8AmtS+1ZRcdGfXozXDHqqJPJcUOgEwe2j9OhyBBn5/wpgWebLJ+w0LPgnf4?=
 =?us-ascii?Q?WEbVcJjCPyj3ETr+0E1cOiydKkBtfbyvVYT6lzRfCq+lfx+LwabXJ4+ddCoO?=
 =?us-ascii?Q?iTrLJW5VhDLg/kxO/PF4vX0GJovF7yxicUiHTJRzsqGtQkwXr2+52EGK8q89?=
 =?us-ascii?Q?xvT8zTb4MI1Y+1gtLb50I38rDl+PPKlc+DHgPoVAfIQ86GTeJxmIio0IPRNH?=
 =?us-ascii?Q?EkkvqMaydEoSw/CSGYLhuldKwy7YC2dF/QS3izoR1SX1nXBmpvkzrvYdN5Cn?=
 =?us-ascii?Q?r7Et2jVvw7un7gMmIYGc3YXwrxFth7MoX0PrWjlYwBYVBs3KkV3XtaHeaGl6?=
 =?us-ascii?Q?c1dHHowBP8J2ND4LtdQYfHVBU/dfR+aRpAXa02Fqcbi4uuArZ1Yd5sd4RJHT?=
 =?us-ascii?Q?5lZ0sunRVzhlkC5MSnYWJ1x+UpKAYZNwN6sHR9FSaj1lplhsrPYxgZlxE7Hn?=
 =?us-ascii?Q?DDvp66+kRKFJza4m0weXG0UO6q/FI9Ubea1OuoxhUbHN19FCyOFWQbwv1ekX?=
 =?us-ascii?Q?k3O7BwNii1/GRzg8IA/bIaPDkNNYbjRB1mXIy5zvqDe21mywKaiSP5fXIG5/?=
 =?us-ascii?Q?SqZTZ7Ow6vObxheYLGxdbOGrV0rJ+L1AKIs6eUFw1Rr+Woj+sszkiL177SD/?=
 =?us-ascii?Q?W97Iwof6DVNMr5vNGFWbfQqjM3ogwYb7gW39wvAVsStn24ICVMvISoz0jX2v?=
 =?us-ascii?Q?Ql05jRtfBCWnn28n+bYKPrYIipyTb44HZwMw2A73APPdItkgY+HwvEbto0iC?=
 =?us-ascii?Q?nAQ7d7TrG99XJCxCK/jC2mXboNJ/mw3HpAUxqR6XRasD+1KNrRC/CmS++ctW?=
 =?us-ascii?Q?TYIuIGA79lskiPLCGG3eniFN5jxUpr0VKy36/8nPpLU/rP4ZUj1lo8pecWAp?=
 =?us-ascii?Q?esLqI45gvcp8N2U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:48.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b15323d-d008-4e9e-87f5-08dd4521888f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

The sff8636_show_dom() function is quite lengthy, and with the planned
addition of JSON support, it will become even longer and more complex.

To improve readability and maintainability, refactor the function by
moving portions of the code into separate functions, following the
approach used in the cmis.c module.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 qsfp.c | 126 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index c44f045..0af02f0 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -649,13 +649,85 @@ out:
 	}
 }
 
-static void sff8636_show_dom(const struct sff8636_memory_map *map)
+static void sff8636_show_dom_chan_lvl_tx_bias(const struct sff_diags *sd)
 {
-	struct sff_diags sd = {0};
-	char *rx_power_string = NULL;
 	char power_string[MAX_DESC_SIZE];
 	int i;
 
+	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
+		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+			 "Laser tx bias current", i+1);
+		PRINT_BIAS(power_string, sd->scd[i].bias_cur);
+	}
+}
+
+static void sff8636_show_dom_chan_lvl_tx_power(const struct sff_diags *sd)
+{
+	char power_string[MAX_DESC_SIZE];
+	int i;
+
+	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
+		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+			 "Transmit avg optical power", i+1);
+		PRINT_xX_PWR(power_string, sd->scd[i].tx_power);
+	}
+}
+
+static void sff8636_show_dom_chan_lvl_rx_power(const struct sff_diags *sd)
+{
+	char power_string[MAX_DESC_SIZE];
+	char *rx_power_string = NULL;
+	int i;
+
+	if (!sd->rx_power_type)
+		rx_power_string = "Receiver signal OMA";
+	else
+		rx_power_string = "Rcvr signal avg optical power";
+
+	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
+		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+			 rx_power_string, i+1);
+		PRINT_xX_PWR(power_string, sd->scd[i].rx_power);
+	}
+}
+
+static void
+sff8636_show_dom_chan_lvl_flags(const struct sff8636_memory_map *map)
+{
+	bool value;
+	int i;
+
+	for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
+		if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+			continue;
+
+		value = map->lower_memory[module_aw_chan_flags[i].offset] &
+			module_aw_chan_flags[i].adver_value;
+		printf("\t%-41s (Chan %d) : %s\n",
+		       module_aw_chan_flags[i].fmt_str,
+		       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
+		       value ? "On" : "Off");
+	}
+}
+
+static void
+sff8636_show_dom_mod_lvl_flags(const struct sff8636_memory_map *map)
+{
+	int i;
+
+	for (i = 0; module_aw_mod_flags[i].str; ++i) {
+		if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
+			printf("\t%-41s : %s\n",
+			       module_aw_mod_flags[i].str,
+			       ONOFF(map->lower_memory[module_aw_mod_flags[i].offset]
+				     & module_aw_mod_flags[i].value));
+	}
+}
+
+static void sff8636_show_dom(const struct sff8636_memory_map *map)
+{
+	struct sff_diags sd = {0};
+
 	/*
 	 * There is no clear identifier to signify the existence of
 	 * optical diagnostics similar to SFF-8472. So checking existence
@@ -687,51 +759,13 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	printf("\t%-41s : %s\n", "Alarm/warning flags implemented",
 		(sd.supports_alarms ? "Yes" : "No"));
 
-	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
-					"Laser tx bias current", i+1);
-		PRINT_BIAS(power_string, sd.scd[i].bias_cur);
-	}
-
-	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
-					"Transmit avg optical power", i+1);
-		PRINT_xX_PWR(power_string, sd.scd[i].tx_power);
-	}
-
-	if (!sd.rx_power_type)
-		rx_power_string = "Receiver signal OMA";
-	else
-		rx_power_string = "Rcvr signal avg optical power";
-
-	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s(Channel %d)",
-					rx_power_string, i+1);
-		PRINT_xX_PWR(power_string, sd.scd[i].rx_power);
-	}
+	sff8636_show_dom_chan_lvl_tx_bias(&sd);
+	sff8636_show_dom_chan_lvl_tx_power(&sd);
+	sff8636_show_dom_chan_lvl_rx_power(&sd);
 
 	if (sd.supports_alarms) {
-		bool value;
-
-		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
-			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
-				continue;
-
-			value = map->lower_memory[module_aw_chan_flags[i].offset] &
-				module_aw_chan_flags[i].adver_value;
-			printf("\t%-41s (Chan %d) : %s\n",
-			       module_aw_chan_flags[i].fmt_str,
-			       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
-			       value ? "On" : "Off");
-		}
-		for (i = 0; module_aw_mod_flags[i].str; ++i) {
-			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-				printf("\t%-41s : %s\n",
-				       module_aw_mod_flags[i].str,
-				       (map->lower_memory[module_aw_mod_flags[i].offset]
-				       & module_aw_mod_flags[i].value) ?
-				       "On" : "Off");
-		}
+		sff8636_show_dom_chan_lvl_flags(map);
+		sff8636_show_dom_mod_lvl_flags(map);
 
 		sff_show_thresholds(sd);
 	}
-- 
2.47.0


