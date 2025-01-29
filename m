Return-Path: <netdev+bounces-161498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC52A21DB7
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D94E1682D0
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5314D5AB;
	Wed, 29 Jan 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ctfv22wN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED780BA50
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156596; cv=fail; b=c8Oe0C82VG1qABEDK+zHQqxjWTEntWGgAb/7/sX8gJczKpexJf/uIX7oSfriFUPvJkZEAT4UIXBOzHSqYe4cgqcV3AiCCVfA/FsH3j1fKB4/2CCjI0Bg1CUNFuaw1+GOJBnRCycSjUs/qDQ7NT4/TqbtWsKoZt+Mqr+u/05KeME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156596; c=relaxed/simple;
	bh=keBP1YsQy1UZq+wcfS2PkNZruIq5A5hogQiiuJZZ5zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZB/VPPpUyp421gGVe0S8UQjDUCWq0VUqlpzYyb2XhF3MdPyCBDwN11IfS01EGIjmyM1GwGHAF0z9w6HEhj8z7Ueq8QlnMY+LLhzZFhcRNlNOyxCp0nkmVkdsLEEKPZ4FKumvNbJEYVryarRMi/cwezNlz/ZAIx0Uy3ZOPn0gpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ctfv22wN; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrMVgdywTeJ7t2phiYrp3QBKuKtgJ6+T9076BD+uoioLU5IQA0sxZi8Ds1jAIsx3w+dsP6JUp8RujFcrluBBzzzGhCwfBVGV8dDsECcj7ar3cjw8P0ejOa2RTZJzpKrDHOwNAUoIZDPvgK9HtZumNlUNfQ7/fRDxpt43YNsjU9J/u1ChOrbH2unGpdSTuv2fUrnc+tmqphqQCS7woBSo6YYROuBUUWX+VFjlNr80fdqvVig2HKyapDK7kHQQg88+WXlm3YeH6EMqIf4Eq7LLOUR3lgWOE3QzvwnbRy+5uRcnhMcJ5V0kWsFObyGatl7T0KBIH9qTPGyGnu9RIqKdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFUaKWf8rOHuP1UnwvR1+nd0YVDpmwvrsEbUuZRUr1o=;
 b=erxtuzGMwpa7O+21ITM1xuqHq0jkA3SqJzRZqp8wE5gh/o5SihCfKQZGeI00litjj3VLrgSWBfdedW1NBDutQMk3Y8IE5p4GRdHSo/1dtR/wllgJejATjTdO9TG0U4MRx3Rzb6ZGFL8Q8HppIUZN9P6IBgosDqbCInNIjmES5qKCCfm384WvgEj3MXliWHtHS09FeJrZKVdGy/nwOnEJr/y9uZ5J6rPgt8Q3ClFarK3nYzeVqBYjQPgrdJHb/MKR4kTVkc5PiPYPuTO+64V8YUcLsw4DtZpzhjlZLUAREArPgpGLevBkX8hoPgddHbs4HS+CTalKpDKtlsZ8hbC14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFUaKWf8rOHuP1UnwvR1+nd0YVDpmwvrsEbUuZRUr1o=;
 b=ctfv22wNSAbO0WnnSYmhXIxxDDQinEGWD0M2ApulBBr0UOoKA7d1JP1ToCG5LZA1C5gEEVdDPnALNmTtWrJ0El4fHUBb2HoNDJ/7QIIAFadzOPIQkMijjkEEOU2OUE8D8QUpTAhXpxjlReEdWxtNf12DozemwT92W9IbSihjIv0XjTu+GM3rHC6oJUtCRLNKVzJCe0ya7OHWRC0ZtvmmNbrecdek9Yl0aYGo5WM/tg2w02je5HuJ/63oRzwO7kQty238ObqjUeiyk/wxkIEfnDT3aIP+biJf3Lve4/T2r+ofehsGf1JDJMVRjc6O9yW/52YXWIJYWr4tdwgRxWTO4g==
Received: from CH0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:610:b3::22)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 13:16:30 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::1a) by CH0PR03CA0047.outlook.office365.com
 (2603:10b6:610:b3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.28 via Frontend Transport; Wed,
 29 Jan 2025 13:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:15 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:12 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 05/14] qsfp: Refactor sff8636_show_dom() by moving code into separate functions
Date: Wed, 29 Jan 2025 15:15:38 +0200
Message-ID: <20250129131547.964711-6-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3f956c-e36d-4c2a-5658-08dd406724d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gIK4eLDPQhjiRqT3+EvYOUbItKXZ3A1B1dyWzMQtIxhviKwDAv9G7CvybyX?=
 =?us-ascii?Q?IUNchhn8X8uQ5RMs7THMsDzSdHxXPRr0H9EloJiEqouiyrL97MfzllmlcRPU?=
 =?us-ascii?Q?/7Hgez3o/a5y4SyaPr0dFkmhr/hshhfV0/yDskpx+th/EoXGP2oQCYSsQ+Qu?=
 =?us-ascii?Q?F5qBlUzZIAw7pZg3DE98oNpI9cXS9wPQ6uW2SD6loHbQteR9QCkzYcVvaWIL?=
 =?us-ascii?Q?lGqDxeOMnbEJxF4Ncl0DoxbAQ4B8wQaib1jGTguQQoJ2B9ki8KAVv0Uk4/88?=
 =?us-ascii?Q?mTUF6HjkINaVtIe4HWwve5vnB3wQ+uRAHl148A9Mm+O7PxyYaKDx6MD0XSBR?=
 =?us-ascii?Q?cbYjtfuAgUcOrqhpCpQ8aIUtxB1ayFlRdUxL8UWr1JPpuTbj4f4kq36/ke9b?=
 =?us-ascii?Q?jyfhpaaPFEGZ8MZFc2YP8XGNbiSdPm3mYF+1p1SPLVcVzQ6AZfYKMITbndTz?=
 =?us-ascii?Q?ugUo2SWVtzsZ6d5E4Lnsz6rxJObjJ9YrSjWW5saOkcUqtHgOYxUwAwy0C2ol?=
 =?us-ascii?Q?xNqybA8/3OH9vzUFe1CCcDB7JZafP9ZwimWLbMOm+7bGfRJFIcT/odbCT9ph?=
 =?us-ascii?Q?SrCjLt4OK7YFs+sIvTYS2kSbwJWMGifzKwB2iXiAI3sS8ZWISPKFKrCbT+AX?=
 =?us-ascii?Q?iD0IOE7OSBJXj+nwG5CroQvk5uJ+nqHi9QA4lfAvFMrXqgX+TXAnoyPSFBrH?=
 =?us-ascii?Q?1K0UCTj/ewgHoPIayGTtsB4dX0kmjtLVbildoe9Q3l+4+YzDMJUhJgbP+5sD?=
 =?us-ascii?Q?/sk0cTEGYoy6FXqEH+wgTWSQx9ZjUyJ90GoGQdPKVY9plmAGC5zYwhN/Wubb?=
 =?us-ascii?Q?Ml/Lj+Dz3f/rU57klKOKp+6vphwdvwn9IAdVhvq7lUJlZmIHQjvdzZ47J5I9?=
 =?us-ascii?Q?uaEruwCnUuvFfZDRIZ1MspXD93SN70Xbqny71IJ0Fa3Mg7gOamcN7v677xFH?=
 =?us-ascii?Q?ik6L4uW/MC+YZbnr513iwopbQyXwdlXI7zgv07aszTEI7mKCuou3UJsUd8nx?=
 =?us-ascii?Q?CN805eYgZOZWDQgNcxVOSyVWE+7Yp6oRyeqB6D2U5HVkHaV82pFhA2cRm77r?=
 =?us-ascii?Q?SeUe50jdayOBtxq2v8VsNZDe6F2JYshgFdnHKrYi/Atu7lBLqrhwfw4Hg/kg?=
 =?us-ascii?Q?vGmjeFz7YiTO/c8bO2+YE5dxWq4d5bfIBVhGccD8GCJiwFicytACQEbLvDXN?=
 =?us-ascii?Q?GcnB2ljoEqhwyEjKSMRs7FR6bwcb80nFJTLrOLx/jXKR5nrv9E79AnJ7Xn1p?=
 =?us-ascii?Q?/x2ge/wP4N+UFHPqD1NDa97VwbSrLJJ61uMEHPKY3Tmoeaa1IFHJXsUH/UG/?=
 =?us-ascii?Q?Ztgd3AC4ZeWmiau5Kto2fSDVFvrhYFgdDcyg3ILs69o3+e7AsYo0iF3vLY5C?=
 =?us-ascii?Q?RkKW9fI9LOE+TtqN8ZJGNintMFJQiSYYG1IvoBgudOybIpXxhgxJIeKHwGME?=
 =?us-ascii?Q?P0dCo4EQrQ/zRAGjqYLY5YGuRQ7PCJFwBxziaU7aSeeW744+d0WnhnxBqTSw?=
 =?us-ascii?Q?OBQFBpe9WC5QJrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:29.8595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3f956c-e36d-4c2a-5658-08dd406724d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

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
index d272dbf..994ad5f 100644
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


