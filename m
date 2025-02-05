Return-Path: <netdev+bounces-163106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A8A2956C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957AD3A31D0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4401917E3;
	Wed,  5 Feb 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rR2Ku7Hs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30831957E4
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770938; cv=fail; b=TPww5aVQpZlefLAoaJdFvXXXFXpPp0xsP1fYuwsjxqSQHpkWplvd2a3sWkbOfu18wBPcqHbW37VJj5J+ae+DO163WsE9rVJUoJfdmSpMeDov/ykAETAtRfqpX/yyPNWmoBsCCTeW00QpqcJQxv9uAWRlslZ4QfbSdr/mpEOhK0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770938; c=relaxed/simple;
	bh=OMXUxPpaoTGAa0+BFNZRmrJqxBa8e4wG2Zwx2i64lYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvz/IMJ4Ecj+TEOY90LFksKK2usBQoE//G1tUim1hy3UULqO7eWNUWL5n/BC1UQguF6F14EXmb1d+SHLawQSOe60ukvc3WLKi72SrZUxJVDZKrfVd/s3jcuhiLo8ywGeqfBpLhhpdZQ92E3+6xPICv6WoZwlnklh8EeHYd/e8XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rR2Ku7Hs; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYy9IHpNh+CBXr5ZokeEwqsP6kricOwa4/q7eLetRWZWHHNcu7mZKpJo7boQqJyrsYPLl6jmQkW/6v/peth6utU0f/zWBNSd6HOfXNTSzwEHyRj9lFxfFpNDstPbXbZVVIctwh3QbQKinUeD2CzhiCaYPrr6aQHSU3RaKrB8q/kFddvRRW9PAmkYbF6FSr/1CXB+KZ9ccp6kUlAGqRRoiqV1XyKbCnxi2pUHoXG0IQti5GIYwrzhnMv/Dvstx8N9xIXqX2aC4shut1VQ9ZGaZFjwZW+kyNPYzqA8eEmLj4xkPdiJ0zoNIP+eySfIJ2+ml1prk9x/8LeQbGsxnAG+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhDBHLFy62jan21ZOG9LCLCeyXmLMsk5QpYRf0mAyIQ=;
 b=ZqYitaOQLKFI31rn4YPukZ0OwBCbJK2dqbG7KDq1UGNTMCuHpFFmfojjU/9Y+4+6iLn9zNl+Vhq1Y4zMCU+/7nyDFbIaYIkTXi+S+QstVv2BNGJVp4Q63MnJKkBPOcgYyTDWvGKgMCPIswldh+++FJEyjILbREB//s5E9jFL2Pxc7Qf8iaAzuFBD8df7B9JJqB2c4GTjuukL0KBhXp3eIytwETbKol/YEJQSF70Qm9q0LKt/ntGE2VkiejAwJsVSQObPkfRb/LVe2wScb82apG3BQ5xyynmrJ4oOzk/E5wnxuQjukmOFHdnRMu0YSx6u+bAzYH0DstK7usbIZpUfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhDBHLFy62jan21ZOG9LCLCeyXmLMsk5QpYRf0mAyIQ=;
 b=rR2Ku7HsuR59uQP79W1OngwlqzQGkHogtBww6wtnBX9mEaj6ecgZmYlAtc8F7mtbgefSa5u9lFDXQES7l+X3XgiqYy57Z2jjldv7U6H+//yuZ+4k9sfy8cFwdHrp6unwe77IaqnyRsVLkvVd66HXlYwKxRHfO0qffokj6CvQz9csMMg3JUZ4x2I5M1V3E+7Z+U30+a6aPeg9NmtI4QaBjk7Qq+adRUY+5OHDnqQfCXYDURM8wkt4FJh+Q+js7RUvarf08mgWFDOGkGFdPb/GZH1+0RKbp6PhMIt6BK+D8nriGU7jMnRBxulaAlUeaZWipMd9CxBMzTWK263AokA1pg==
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:55:30 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::b8) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 15:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:55:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:10 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:08 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 06/16] qsfp: Refactor sff8636_show_dom() by moving code into separate functions
Date: Wed, 5 Feb 2025 17:54:26 +0200
Message-ID: <20250205155436.1276904-7-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 643fe388-44af-42c9-f2ba-08dd45fd8451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81IZ5L5Dg8r5wF+vo6A/NOjS/YKHoARcQU4elPmim7hLgLnYug3FNPadpMst?=
 =?us-ascii?Q?N5c84IUL35OmAqefUgFgiNrrmttx9X8cr6my9y7YSnViHlx96OXFxkH6vTz6?=
 =?us-ascii?Q?4zkLjL0oi3jkQfgNbMYf9/TJ7woRYO7ZBhkSY0+Zha62XKvQktWKzswao8/G?=
 =?us-ascii?Q?nUAwUlnMIBoVY8Ysq+AaoD/qmegf7vIXWcnESupp1lHw5gBZa/QQGM/PYBX8?=
 =?us-ascii?Q?8oHK3ZxbrL9gGbtsV4m5rrKowIR19LCzbyipJK8fx2T7zEXpRIIMjxagev55?=
 =?us-ascii?Q?RLE1wfEPH7SDW9faoeoCOY5gsd8ijKDAtedTMn4++yWEJt7HEcmL/2En1pd5?=
 =?us-ascii?Q?U6F5pYyXCtHzq7KebIVmrbXzD2X+HbHsHWqQZ7LijV24hIN3erFSMjjaTl7V?=
 =?us-ascii?Q?hq8PgH7ybzLHUz6tgNH16iwjan4oyxoxOL6oNMd+PfbHzuegLjIx2o+bwKVa?=
 =?us-ascii?Q?0pVUEP/Z4WPi01MnjY7mHHH5FDZhfjUFmhBMVFslKre3+gtWmDGCqOx5Zxhi?=
 =?us-ascii?Q?odzaVv0u4X7EPYMJYqElsT+muE40CdgNioTq9J5IhRFs7jVR59mQIvbMKVFe?=
 =?us-ascii?Q?VE7FY696sjxPvn8snCjyat+Xfz9eHup06gxLKN4Mnflzk8eaekYeU82jJ/0d?=
 =?us-ascii?Q?aLmH82y2HOLT4C/tqJOgAxmn8/RE4XNDvhti1DJe2SAH8llv/dgZhjh62/eD?=
 =?us-ascii?Q?52vQsgti4QwfieI9wk3si7GEnGtNiX9q7Qkib8XKdmdYav3uqLeEYiaUWSsZ?=
 =?us-ascii?Q?Ah2ORDvIxN5H45syHIMhhOnIGyY7FOVeEB8tBlCuMX19RxE+xcdx7g4pscLx?=
 =?us-ascii?Q?OUDMLg/MzTm8wVsJKRkLMdjjcESOHU6E6yLr+5PGcWGTgzBrO/TTunsgwNYZ?=
 =?us-ascii?Q?D74ayWJK1/PRusv9kIMQ+P8Zf6lRraqJDcNRc3i7Ls4xk23vlWs8JgVZEYUn?=
 =?us-ascii?Q?ubqWbqkzhp4BYDpTT5KZmlpCqctep3OQWq2gCn93SDSZqtQF6f/WccMYO7vh?=
 =?us-ascii?Q?FpdbQC1SdH/kWqjb+d2tn/UQ2qdFwgHOV6NhIpxbtL52i6qRGsIlWHvXtSjU?=
 =?us-ascii?Q?5nfhztuiuqzOg5S31CLGDx+bcdkMMFbZPQZu6b3GDnjOgHC5X6jYFwlSNzyj?=
 =?us-ascii?Q?ok06vJiabVTHqBN6P/S3kQQixR1UvpR6tj9UulKLUSL7U1Hx9/dfZi0Aaneh?=
 =?us-ascii?Q?fEbhXgjdwaq2ksbpE4nQ+rB5kyrRYgLBXz+XWYcqipkxooohA+fEmvuV4a9X?=
 =?us-ascii?Q?f9tUFQzHrhV8n3qtiOjMoW4YJ8jK1Ho01NpQ0xdqLYKQHl+jHiChCrOtVX3k?=
 =?us-ascii?Q?EBlbICoCWz+H05aiMPDltL5jWtokN8CvmRQC1kE5vj2wVMwfeqhkDK8QRxfI?=
 =?us-ascii?Q?oVJnTrbZ/cItxLGJXvzoJbTMYlQe/wjk/TYQaZn7kuv9TTpC53LfApDnqaep?=
 =?us-ascii?Q?GDteq9XUauJlRNYkSp07CWuUP6bMFYYzhGJ0KYeYbyAsIjfraOvNX0G3YvJ/?=
 =?us-ascii?Q?aT348XEMaNj5JRk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:30.3608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643fe388-44af-42c9-f2ba-08dd45fd8451
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092

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


