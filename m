Return-Path: <netdev+bounces-160970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD0A1C798
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E699188613D
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED815990C;
	Sun, 26 Jan 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AKRO593+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F80156887
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892641; cv=fail; b=GXmsMFzcWjAxWqS4qsPvllOUWYByr0z1cMUeTRbegPBZp5b9K+Y4B75ucSF6GuYaC3Hg8gb+NVPMPYA0KAv2UGYIElYi62EFP38NCyRrgELr+xQg61xpvWTlp2rb9n380UZJ3L5xIToMhG0xgcZJtzNMGaQTSHc9bAAaKXPjQwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892641; c=relaxed/simple;
	bh=B9b1KRk8vbF2cPb+/ZmQHQkWE3WSmy7CrEpGg4Ttwr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYWOiYMP5z0zqGhdA2rJWmRX8Dv0ol3bMQI5aXE/Np/Bh+u4HhXJcWr52aQhzIXo/ZkFVv6z3Nk6QA9zggzd3a+vFUGzri7zmRjV3JGEzQOA5aKt9OU8szf8OpRJOf40ePWCGdodOLYc7m5vK57Bg+gUNy1p5lRGUxUicDQf7JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AKRO593+; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn7MXKQe0yJdBlsYUkybFw1jc/kBOP+o+dJ+EILP/TGx49DvFZ3ArftaU8jiFC32rkppbCmVzQmgWFaZdu1Gy4oV/iA978GVyrE76RJLfdCAivt1v0h74nKcMRFkFT0yLVXWhDRvJrlH2ON1funUV8T5yOcX7ZIYLh1J5f3cH1cnP7qXgOnTVElUPoRU5507Ip14PQfbVP2cVQA9N+lMAsrrMqsOaOx5vxSY076ytBdeM8K5ULP6wsnZ5imkkpWDYoh2t/LEARZnTUwmo1uVC+HiLBYIDFcELYEF6jdAZMl9SZEauBO1OzUFtTN745QAtg+5BOSfpPe0NI5s1aeM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNnf+WwWCcayBUN7V1Cv5Zvszg/6IYfXYvXWdFMM0AQ=;
 b=JDlu9TzAVjqYNOD2tT3QRf1HWHUIrzYhnr/Z7jqK3/g1u1qSnENGQpdOp64VZb28ORg3WsxPPCkl/Yk4uY3HAyMmIhgSJCy1V2GgWvaSgwXyMZ5NGyM0rMqPu5pRu59U8ufX/afGLO3xjrIKkfetWvnkUMPMGzbn1kYS4i24tXD/M8VoG0Uc0oHq61IpxGNNdBEWcCiPGs5su7wIGNi20xcdhcLdjUAUyd5in3nCKkDvV0fQf+gA8G+cdb6s05t+wQNw4YJSCvYkXuaPOxr951WXb6aKVTvyBoCWVZJ9aTYeq+s25fu3CWyMOqlhl09ia8PsQqK3ugcpymlihBzLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNnf+WwWCcayBUN7V1Cv5Zvszg/6IYfXYvXWdFMM0AQ=;
 b=AKRO593+50DsPzk1yK8Qk5XaTWPbayPczykp42d/yznOMJB6G7N2tFj5fjNwpuRaK/Wa+Rw+0B39tCEGqrbjlrT+pQ8gpZkLOF/CHRbq7vJ+/NFGjIhKJzG7dWzwFw3+XfBILUOHDg8K7GC2XDEW4nMYBS36SgPupJ4AQ/Q305e89/dEWMpWIWXhfjF3OvlW3MLWxYNu5aWUCnAE/zjPawE43e21bMvRGQZ4PrelfyS3zPPqtjA/xEsN5fRz2eOnX2EIn7rwl3Y8nckUcIz7wBf9atD5gUGFuu1jmxveyc1cCkYBRGMSTUKmgaaIZOnKrN2H/PKU2IRP6lcfJYqTgw==
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 11:57:15 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::c2) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Sun,
 26 Jan 2025 11:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:02 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:00 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 05/14] qsfp: Refactor sff8636_show_dom() by moving code into separate functions
Date: Sun, 26 Jan 2025 13:56:26 +0200
Message-ID: <20250126115635.801935-6-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: a535135f-8a8f-43a4-28ec-08dd3e009377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OJ1dmFbUXwGU1eYbf8tphydYeRLPuBz8Jq1Yk9roKe5f7/oLXG60lcdFT1rw?=
 =?us-ascii?Q?AHMFH0avSrme8ZXHtyTc3BaPZwvdpxCwnP3Pl3CIrU9KIzvZzDkFTQwwicW3?=
 =?us-ascii?Q?Uom/aAYSUPZeCqABJQqOkXlI29Ubd1wHF2hZ76/N4zxO0q4jENO70LHgRNHY?=
 =?us-ascii?Q?0w3tIgbVkOiqcC/zWheSanlpfeLRRUz8eMdYuWmcr1bJrEbriZPO+HUfr6zH?=
 =?us-ascii?Q?YYBZUsUGb1+RN4ZOJ7w0zjt4Mai72+K1f9yjnGzeBIfWwmQoeFw5r3+Adbiw?=
 =?us-ascii?Q?k4sqPfcJQXTER85xpNSx40RoqNis2eo9JaSJEFbsRJ0yUagNxqmtmZCx93GZ?=
 =?us-ascii?Q?BYOqShDddES/pf+T7GFXFe9qGno5S5xkquun/+OzvIkvnPjLyut3sRDjlTTw?=
 =?us-ascii?Q?UyxJhbxfcxPZm3oCHQ22edZaYiTeNYQXTXfe8ReC1yqLzKXvGr7CVCFxEt2/?=
 =?us-ascii?Q?QRc1M1+G43vnRRI5h+u6QQsbQwXoZ1Otv4s+Z88zSKFvGOyYqzQJITA11eca?=
 =?us-ascii?Q?zMq1rC+FEy818bu5VpEA2yXeA2VrT7wFfsVtgphaAeXlpFqkzjI+Ssp6ZUKP?=
 =?us-ascii?Q?JHcSu9Hpa0PVqYPfMlipQa6ngTcqMXmxHlN8yeXKA1w6yZrU5a1Ak0sq3NXI?=
 =?us-ascii?Q?tHsG7yqP23aCMVkPwBCRuu1ivvob5JpmZp2TtqEP025BL5TcUnR1MYnd+p5c?=
 =?us-ascii?Q?9ljErbLv1/TyzWulyFdhQV5QhMSp1JXXNYhQIeXL3vd2XeVXNQB2LN18mDQ0?=
 =?us-ascii?Q?wFaDHEi98XlCdjjQMO5WC4h+OyrOV4XncWMi4gbUlcQTbtVu5vJnulIFrYbD?=
 =?us-ascii?Q?Zjb5bN8BOC5ALc8UJYCj3Gc5PYl6lUYCcyPchpYT0HL+1I5v71I63oJ4kMAN?=
 =?us-ascii?Q?nfXvkwumOVFGIloxppwyUBKRbGc7Ok5LnC2s4xT+zayv5M5LIykPw0jtolmM?=
 =?us-ascii?Q?s7hNLOX0LJTqvwOr6lhjnBSkP1CZP5dJIuoB7ykra/tLzttcRnJuKIwATGmx?=
 =?us-ascii?Q?Gg5wPNCUo0O+4vlP7humKHS+j82gk8/ocoxcLMbal4DzEzBbjTmmH3SQXj/H?=
 =?us-ascii?Q?CSCsEXh+i8u3kYFaHK3Yed6YKgel91l2jJPB7vzjBxw0i+w8GJPgnPD1YRJS?=
 =?us-ascii?Q?8L/UJ17nnp3CbnPHI/qyAvj7ez0F+qGkaUvBw8r60+/4orQ7FLa2mgSC288X?=
 =?us-ascii?Q?zNH7dJEayQq0vxl4ExXwuAatXjoCXE27GiUvR3tBQUZdek3YQ/NU3q/Kg5Wt?=
 =?us-ascii?Q?FHdvX8AXoPDQJSTu3Vhm7fwGn5MNtrX7TPYErzPstAfO4BdUvLzlmSxuvMWg?=
 =?us-ascii?Q?2Xt6W364UY71gj+33ud4FqC2tfk/W3hhrS/S3scLmHWwTJJAeSTLf1SpTvLg?=
 =?us-ascii?Q?vElIho9zdzHBiSkXCfnbVoZnwOymrJRNw6nL4ClEc5WlWl3S3VLY/L01ZIci?=
 =?us-ascii?Q?zsZaguzI1O2PE0qDrYCkcwRSCbyQcAxCJe8MGrs/H8QwllQnHR5ZCGNYfLFX?=
 =?us-ascii?Q?mRbCAn5NBQI37h8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:15.0054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a535135f-8a8f-43a4-28ec-08dd3e009377
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143

The sff8636_show_dom() function is quite lengthy, and with the planned
addition of JSON support, it will become even longer and more complex.

To improve readability and maintainability, refactor the function by
moving portions of the code into separate functions, following the
approach used in the cmis.c module.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 qsfp.c | 144 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 55 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index 674242c..13d8fb7 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -649,13 +649,94 @@ out:
 	}
 }
 
-static void sff8636_show_dom(const struct sff8636_memory_map *map)
+static void sff8636_show_dom_chan_lvl_tx_bias(const struct sff_diags *sd)
+{
+	char power_string[MAX_DESC_SIZE];
+	int i;
+
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
 {
-	struct sff_diags sd = {0};
-	char *rx_power_string = NULL;
 	char power_string[MAX_DESC_SIZE];
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
 	int i;
 
+	for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
+		int j = 1;
+
+		if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+			continue;
+
+		do {
+			value = map->lower_memory[module_aw_chan_flags[i].offset] &
+				module_aw_chan_flags[i].adver_value;
+			printf("\t%-41s (Chan %d) : %s\n",
+			       module_aw_chan_flags[i].fmt_str, j,
+			       ONOFF(value));
+			j++;
+			i++;
+		}
+		while (module_aw_chan_flags[i].fmt_str &&
+		       strcmp(module_aw_chan_flags[i].fmt_str,
+			      module_aw_chan_flags[i-1].fmt_str) == 0);
+		i--;
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
@@ -687,60 +768,13 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
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
-			int j = 1;
-
-			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
-				continue;
-
-			do {
-				value = map->lower_memory[module_aw_chan_flags[i].offset] &
-					module_aw_chan_flags[i].adver_value;
-				printf("\t%-41s (Chan %d) : %s\n",
-				       module_aw_chan_flags[i].fmt_str, j,
-				       value ? "On" : "Off");
-				j++;
-				i++;
-			}
-			while (module_aw_chan_flags[i].fmt_str &&
-			       strcmp(module_aw_chan_flags[i].fmt_str,
-				      module_aw_chan_flags[i-1].fmt_str) == 0);
-			i--;
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


