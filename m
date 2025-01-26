Return-Path: <netdev+bounces-160971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E51A1C799
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F9018860A5
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD6156F44;
	Sun, 26 Jan 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pdiPzRxf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F1156C6F
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892648; cv=fail; b=LTKxqwpIu3gxFFLk88WgE/dwhIyMSrBCf2MSt3MmzqoiauGh0nDSnvIpIv3MQoZbFfbBzroOUMVptB9oHxmNz9Ta0zgSQTQx/N1obZvWncqVqXBDB/oa6iWCUlxEP1BBK1X85PkzOnyLVCdOX7CRir0P96InFgl8WIxPHW5HME4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892648; c=relaxed/simple;
	bh=1nEktTpVz7IrCEybBH8GyMY3kGTwiZVWFjZP1ZqlcDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwnjWEfrralaIQS23i6OFjPEahSuJYPsPjBw7xxxZ8v0YMyYkdQKOIw00tFknajElnzPhC9aonN53+21taYG/qryKWnydlJdSQAgTYlCpgpKoyumnSWmRVqWgyVdhGhj1ZEIXHzwUfT+FU6HM4qoA8pPi/H4vx6VST5JRlnQmpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pdiPzRxf; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glUG64xVavuCh4zpvbDCe+p/tqF1jlOtrVTbvFku8ysZ8tU6rp1tT76QeKoGzNMQmSEzzEpp5Q3+7oB9nHcrPe8GEc6aUL9i3IrpaXnVh4LMOWg7Pbc+KZTrHO061aTWHFn9lcEBOoxlT9tuuQlHLg1Mbw3kIpOzAEcyL0m6w8OCH05hh5pkBIpfP7fdQSSGPtAw3Hpo3TJgVjfaXD+kTWarNaKuQEuSokSzB4m0UnI28Y14Wo8WzV7yWeftphxawPtCuMdv8yRVNS2+eq+1pNVYqgCy3uJuQC+/V7aDP0BLJ/pmRvSRCzRXZdS/7BqLO1npzOoqCb3vEnjvIlO1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC6dvvx5mRKHvoXcOQVZPTlnMPRhfjKfGgjK+JtWd7Y=;
 b=tdwABiU7XWs0OUCINaYYhOdkeBsf1G+1jX/Oe1hnJ0hdEaxw5mgJBU/kwFI0MLkyu08I44PNyYfF5CKvWyfkhCFmN+K3r6Jo5ngDAxB8NpntGo52GR9oU3EbvUwJFWjrRi6C+Y/wu+fxCKGzQXSyGnvUzr5XCDx5Lyy6p2ephD8cDVwxXbzJmXLkCf3vJw7Yc4wsfPvb3IyR4XUzzNgoLtI9XJHKZsphlCyDFXVP5Q0HnOAGjrIchgOKc2XGfh1uWr0UpAi5KRoGpvN1JH/39ilDb/bfBFRqW78nirM7kX/abZ8cZax+cjaI1bK2SJ+ZAKZBfDyYapteonrb2+b+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC6dvvx5mRKHvoXcOQVZPTlnMPRhfjKfGgjK+JtWd7Y=;
 b=pdiPzRxfXkli8VUnTa9aTSCQTbE/PXcrIZ7431uph3PF/jmlKaXCHDJgxDOg5CPqxBQfWpSoboD9tvYOGmeijvoU8vwF21NWpPFIc+uf7tfFvPHO/kr50UVztNj3baBZsbZnSFFiFEfD2d/2Ysj/PgnJnh9KHIp/uOyxEejdLpyPxhNGbWiooV9pW8YGbxHg60MX1zvglRx95ASBqexVPCQdqJQhsfPgieyS2K0h8B8pYoe+X9FEwMMEH/6aMT0zu/H2+ncubRC4WU7FSWJ0Vcv3avBEa1Z6WfRBqe4Ks5F2TWrZZbI5PKjOOwsNc97zl/w/t0pmOtIZy0ZudorY3w==
Received: from CYZPR11CA0001.namprd11.prod.outlook.com (2603:10b6:930:8d::28)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 11:57:20 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::27) by CYZPR11CA0001.outlook.office365.com
 (2603:10b6:930:8d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 11:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:05 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:02 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 06/14] module_common: Add helpers to support JSON printing for common value types
Date: Sun, 26 Jan 2025 13:56:27 +0200
Message-ID: <20250126115635.801935-7-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b744070-507b-4495-cb63-08dd3e009684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GA5e0/WR5VyhwvaBS1CiRLLQJ5+Nxc9/QRpmMC1WCwhTrmfh4XkoOD62dPES?=
 =?us-ascii?Q?DTU1ZD2G5Y1QJ/Gz//b15dXl0HS9jIfjFRvKwHGs2ycbbuUX9RioposGOydW?=
 =?us-ascii?Q?IT1k2Kx5hqrr8fHjUMig3JGUFNKHXUIsHs5L2TBjGif8YE06guw/9hiBZUvs?=
 =?us-ascii?Q?iFzlbv7OX1nxAPu8eUd3oOLK+OES8/yiMOw8kz25s+9j9dng4vLajQ37/RkX?=
 =?us-ascii?Q?rC4fU2jfoYMY6Gj99w12BiJ5snll26xsoZb2MnOfrivcA+5ramUDJiCu0rNJ?=
 =?us-ascii?Q?jaM7p99wuNlwhG0GWWMA0CHC0AF8q6+RwOb6AoT0eO3I8gwcLbv9swvfJJqc?=
 =?us-ascii?Q?GwW1Ol7kdSDcoFzSwBJzLffSOXbrUrm+YT1m5l7Cdyk37nS+fkX0RSDO/QGy?=
 =?us-ascii?Q?gHtygI6KuM5BDQCW0oqFGA7uMtiffi/1Tcgdw1XmUHLBm4yvtcQs5uEheQ9Z?=
 =?us-ascii?Q?PA2RVdIq7L+vYy9shI4NEv/YBfQCiZw9/2voErPs+u1cu5Bf8TNpLSJX6JsS?=
 =?us-ascii?Q?9iN8T6uipozaFqJOl3y/3iwyzUiqNeEKetIBTJP3WZWJLj9XFGEBR3tBBtwo?=
 =?us-ascii?Q?kgbRzvfMezX4GFn6APWpL1LnC+9pG5REoUBRK7cIQUf/5N5WvxAxFv1DVSTY?=
 =?us-ascii?Q?g6MEHsmn903cTLPamCbMOCo+/+3dUWBSaEg9lcKSvcqFesdoxz2+p1nyP5qN?=
 =?us-ascii?Q?w0zoA004aG5WM6kRru+nseAQn1jJDk4U48aeZSzGj7h1+TjP/1qjpQE0LTmU?=
 =?us-ascii?Q?zrHdl+jyMxW6ckzU108fNxSA3NrElcIjld9CqUtnnIX0i88fMnYL01zcDS88?=
 =?us-ascii?Q?YbhFeQfc9OEjfQcpghtligEQIRPKHqWhCPbnKqndvV39mflBiaCq/urNyOyl?=
 =?us-ascii?Q?UXqgQTYTmyP2eVxwM+o4iBua+XkFGuFDsQnTQ2f6sb7tnyIzLr8rW2+WzuDK?=
 =?us-ascii?Q?WwSLW2X6GRITV3esxFecLGSj/ITI+vBWp6JC6gFhLcl8TsLl84ZlWRvhWdYl?=
 =?us-ascii?Q?UQzaERii8QrE8zNHt1NHmxOt9BXtBNdl3bmex6RfU7TXHk0ZJZvHHTUui+jB?=
 =?us-ascii?Q?U8USN8Ay+oRMv7TYltUbyUH3ZirHFbV0Un/twQRJ3t/ri6Cz2t/K3NEzQpjk?=
 =?us-ascii?Q?ys0UVCq868vYSNtMr7y53xIxSHSWfaZqMljHwUg6YK+IPJdkS6h1uBiLM7D3?=
 =?us-ascii?Q?VBaeXDeJK7U7YSEGHX120wle2u2ZOXXLy8GhBdENOoVEQrvRLykiHb3yN+dD?=
 =?us-ascii?Q?QtuzyBLxcafgpgTm1w1CHan99kdMQ1FTFk8Bwd2jb/qwVDCSpsbB12KCErz0?=
 =?us-ascii?Q?oAf86M5uUVWw2GwzVxizPfCKzYKmcPFh/It64Zmo7qKfuW4W/xbOJLijB7Tw?=
 =?us-ascii?Q?IN4Kt0NbTgPoAcMj58whYU4NQ0n3mSpj/bEtrjf4TnJUtiyj2X0KDPosvabj?=
 =?us-ascii?Q?kX9/Rboanxvc2+VTWY7aM0bAHBcjAjiHptNtKndoRtalMz08fodCcSZ2gi9i?=
 =?us-ascii?Q?LSUJ1RbxlL16BTg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:20.1124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b744070-507b-4495-cb63-08dd3e009684
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999

Upcoming patches will introduce JSON support to the ethtool dump. The
ethtool dump currently handles various field types, including strings,
unsigned integers, floats, etc.

To facilitate this transition, implement helper functions for commonly
used types. These helpers will enable consistent printing for both JSON
and regular dump formats.

In addition, add JSON support for common functions and defines to use in
the upcoming patches.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 module-common.c | 367 ++++++++++++++++++++++++++++++++++++------------
 module-common.h |   7 +
 sff-common.c    |  98 +++++++++++--
 sff-common.h    |  41 ++++++
 4 files changed, 407 insertions(+), 106 deletions(-)

diff --git a/module-common.c b/module-common.c
index 4146a84..e6fbbb2 100644
--- a/module-common.c
+++ b/module-common.c
@@ -5,6 +5,7 @@
 
 #include <stdio.h>
 #include <math.h>
+#include <ctype.h>
 #include "module-common.h"
 
 const struct module_aw_mod module_aw_mod_flags[] = {
@@ -198,309 +199,491 @@ const struct module_aw_chan module_aw_chan_flags[] = {
 	{ 0, NULL, 0, 0, 0 },
 };
 
+void convert_json_field_name(const char *str,  char *json_str)
+{
+	for (size_t i = 0; i < strlen(str); i++)
+		json_str[i] = (str[i] == ' ') ?
+				'_' : tolower((unsigned char)str[i]);
+}
+
+void module_print_any_units(const char *json_fn, const char *unit)
+{
+	char units_fn[64];
+
+	sprintf(units_fn, "%s_units", json_fn);
+
+	if (is_json_context()) {
+		if (unit)
+			print_string(PRINT_JSON, units_fn, "%s", unit);
+	} else {
+		if (unit)
+			printf("%s", unit);
+	}
+}
+
+void module_print_any_uint(const char *fn, int value, const char *unit)
+{
+	char json_fn[100] = "";
+
+	if (is_json_context()) {
+		convert_json_field_name(fn, json_fn);
+		print_uint(PRINT_JSON, json_fn, "%u", value);
+	} else {
+		printf("\t%-41s : %u", fn, value);
+	}
+
+	if (unit)
+		module_print_any_units(json_fn, unit);
+	print_nl();
+}
+
+void module_print_any_string(const char *fn, const char *value)
+{
+	char json_fn[100] = "";
+
+	if (is_json_context()) {
+		convert_json_field_name(fn, json_fn);
+		print_string(PRINT_JSON, json_fn, "%s", value);
+	} else {
+		printf("\t%-41s : %s\n", fn, value);
+	}
+}
+
+void module_print_any_float(const char *fn, float value, const char *unit)
+{
+	char json_fn[100] = "";
+
+	if (is_json_context()) {
+		convert_json_field_name(fn, json_fn);
+		print_float(PRINT_JSON, json_fn, "%.04f", value);
+	} else {
+		printf("\t%-41s : %.04f", fn, value);
+	}
+
+	if (unit)
+		module_print_any_units(json_fn, unit);
+	print_nl();
+}
+
+void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
+			   const char *str_value)
+{
+	char json_fn[100] = "";
+
+	if (!given_json_fn)
+		convert_json_field_name(fn, json_fn);
+	else
+		strcpy(json_fn, given_json_fn);
+
+	if (is_json_context())
+		print_bool(PRINT_JSON, json_fn, NULL, value);
+	else
+		printf("\t%-41s : %s\n", fn, str_value);
+}
+
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit)
 {
 	unsigned int val = id[reg];
 
-	printf("\t%-41s : %u%s\n", name, val * mult, unit);
+	module_print_any_uint(name, val * mult, unit);
 }
 
 void module_show_ascii(const __u8 *id, unsigned int first_reg,
 		       unsigned int last_reg, const char *name)
 {
+	char json_fn[100] = "";
+	char val_str[32] = "";
 	unsigned int reg, val;
 
-	printf("\t%-41s : ", name);
+	if (is_json_context())
+		convert_json_field_name(name, json_fn);
+	else
+		printf("\t%-41s : ", name);
+
 	while (first_reg <= last_reg && id[last_reg] == ' ')
 		last_reg--;
 	for (reg = first_reg; reg <= last_reg; reg++) {
+		char val_char;
+
 		val = id[reg];
-		putchar(((val >= 32) && (val <= 126)) ? val : '_');
+		val_char = (char)val;
+
+		if (is_json_context())
+			val_str[reg - first_reg] = (((val >= 32) && (val <= 126)) ?
+						    val_char : '_');
+		else
+			putchar(((val >= 32) && (val <= 126)) ? val : '_');
 	}
-	printf("\n");
+
+	if (is_json_context())
+		print_string(PRINT_JSON, json_fn, "%s", val_str);
+	else
+		printf("\n");
 }
 
 void module_show_lane_status(const char *name, unsigned int lane_cnt,
 			     const char *yes, const char *no,
 			     unsigned int value)
 {
-	printf("\t%-41s : ", name);
+	char json_fn[100] = "";
+
+	convert_json_field_name(name, json_fn);
+
 	if (!value) {
-		printf("None\n");
+		if (is_json_context())
+			print_string(PRINT_JSON, json_fn, NULL, "None");
+		else
+			printf("\t%-41s : None\n", name);
 		return;
 	}
 
-	printf("[");
-	while (lane_cnt--) {
-		printf(" %s%c", value & 1 ? yes : no, lane_cnt ? ',': ' ');
-		value >>= 1;
+	if (is_json_context()) {
+		open_json_array(json_fn, "");
+
+		while (lane_cnt--) {
+			print_string(PRINT_JSON, NULL, "%s",
+				     value & 1 ? yes : no);
+			value >>= 1;
+		}
+		close_json_array("");
+	} else {
+		printf("\t%-41s : [", name);
+		while (lane_cnt--) {
+			printf(" %s%c", value & 1 ? yes : no, lane_cnt ? ',': ' ');
+			value >>= 1;
+		}
+		printf("]\n");
 	}
-	printf("]\n");
 }
 
 void module_show_oui(const __u8 *id, int id_offset)
 {
-	printf("\t%-41s : %02x:%02x:%02x\n", "Vendor OUI",
-		      id[id_offset], id[(id_offset) + 1],
-		      id[(id_offset) + 2]);
+	char oui_value[16];
+
+	if (is_json_context()) {
+		open_json_array("vendor_oui", "");
+		print_int(PRINT_JSON, NULL, NULL, id[id_offset]);
+		print_int(PRINT_JSON, NULL, NULL, id[(id_offset) + 1]);
+		print_int(PRINT_JSON, NULL, NULL, id[(id_offset) + 2]);
+		close_json_array("");
+	} else {
+		snprintf(oui_value, 16, "%02x:%02x:%02x", id[id_offset],
+			 id[(id_offset) + 1], id[(id_offset) + 2]);
+		printf("\t%-41s : %s\n", "Vendor OUI", oui_value);
+	}
 }
 
 void module_show_identifier(const __u8 *id, int id_offset)
 {
-	printf("\t%-41s : 0x%02x", "Identifier", id[id_offset]);
+	char id_description[SFF_MAX_DESC_LEN];
+
 	switch (id[id_offset]) {
 	case MODULE_ID_UNKNOWN:
-		printf(" (no module present, unknown, or unspecified)\n");
+		strncpy(id_description,
+			"no module present, unknown, or unspecified",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_GBIC:
-		printf(" (GBIC)\n");
+		strncpy(id_description, "GBIC", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_SOLDERED_MODULE:
-		printf(" (module soldered to motherboard)\n");
+		strncpy(id_description,
+			"module soldered to motherboard", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_SFP:
-		printf(" (SFP)\n");
+		strncpy(id_description, "SFP", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_300_PIN_XBI:
-		printf(" (300 pin XBI)\n");
+		strncpy(id_description, "300 pin XBI", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_XENPAK:
-		printf(" (XENPAK)\n");
+		strncpy(id_description, "XENPAK", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_XFP:
-		printf(" (XFP)\n");
+		strncpy(id_description, "XFP", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_XFF:
-		printf(" (XFF)\n");
+		strncpy(id_description, "XFF", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_XFP_E:
-		printf(" (XFP-E)\n");
+		strncpy(id_description, "XFP-E", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_XPAK:
-		printf(" (XPAK)\n");
+		strncpy(id_description, "XPAK", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_X2:
-		printf(" (X2)\n");
+		strncpy(id_description, "X2", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_DWDM_SFP:
-		printf(" (DWDM-SFP)\n");
+		strncpy(id_description, "DWDM-SFP", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_QSFP:
-		printf(" (QSFP)\n");
+		strncpy(id_description, "QSFP", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_QSFP_PLUS:
-		printf(" (QSFP+)\n");
+		strncpy(id_description, "QSFP+", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_CXP:
-		printf(" (CXP)\n");
+		strncpy(id_description, "CXP", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_HD4X:
-		printf(" (Shielded Mini Multilane HD 4X)\n");
+		strncpy(id_description, "Shielded Mini Multilane HD 4X",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_HD8X:
-		printf(" (Shielded Mini Multilane HD 8X)\n");
+		strncpy(id_description, "Shielded Mini Multilane HD 8X",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_QSFP28:
-		printf(" (QSFP28)\n");
+		strncpy(id_description, "QSFP28", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_CXP2:
-		printf(" (CXP2/CXP28)\n");
+		strncpy(id_description, "CXP2/CXP28", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_CDFP:
-		printf(" (CDFP Style 1/Style 2)\n");
+		strncpy(id_description, "CDFP Style 1/Style 2",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_HD4X_FANOUT:
-		printf(" (Shielded Mini Multilane HD 4X Fanout Cable)\n");
+		strncpy(id_description,
+			"Shielded Mini Multilane HD 4X Fanout Cable",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_HD8X_FANOUT:
-		printf(" (Shielded Mini Multilane HD 8X Fanout Cable)\n");
+		strncpy(id_description,
+			"Shielded Mini Multilane HD 8X Fanout Cable",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_CDFP_S3:
-		printf(" (CDFP Style 3)\n");
+		strncpy(id_description, "CDFP Style 3", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_MICRO_QSFP:
-		printf(" (microQSFP)\n");
+		strncpy(id_description, "microQSFP", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_QSFP_DD:
-		printf(" (QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628))\n");
+		strncpy(id_description,
+			"QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628)",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_OSFP:
-		printf(" (OSFP 8X Pluggable Transceiver)\n");
+		strncpy(id_description, "OSFP 8X Pluggable Transceiver",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_DSFP:
-		printf(" (DSFP Dual Small Form Factor Pluggable Transceiver)\n");
+		strncpy(id_description,
+			"DSFP Dual Small Form Factor Pluggable Transceiver",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_QSFP_PLUS_CMIS:
-		printf(" (QSFP+ or later with Common Management Interface Specification (CMIS))\n");
+		strncpy(id_description,
+			"QSFP+ or later with Common Management Interface Specification (CMIS)",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_SFP_DD_CMIS:
-		printf(" (SFP-DD Double Density 2X Pluggable Transceiver with Common Management Interface Specification (CMIS))\n");
+		strncpy(id_description,
+			"SFP-DD Double Density 2X Pluggable Transceiver with Common Management Interface Specification (CMIS)",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_ID_SFP_PLUS_CMIS:
-		printf(" (SFP+ and later with Common Management Interface Specification (CMIS))\n");
+		strncpy(id_description,
+			"SFP+ and later with Common Management Interface Specification (CMIS)",
+			SFF_MAX_DESC_LEN);
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		strncpy(id_description, "reserved or unknown",
+			SFF_MAX_DESC_LEN);
 		break;
 	}
+
+	sff_print_any_hex_field("Identifier", "identifier", id[id_offset],
+				id_description);
 }
 
 void module_show_connector(const __u8 *id, int ctor_offset)
 {
-	printf("\t%-41s : 0x%02x", "Connector", id[ctor_offset]);
+	char ctor_description[SFF_MAX_DESC_LEN];
+
 	switch (id[ctor_offset]) {
 	case  MODULE_CTOR_UNKNOWN:
-		printf(" (unknown or unspecified)\n");
+		strncpy(ctor_description, "unknown or unspecified",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_SC:
-		printf(" (SC)\n");
+		strncpy(ctor_description, "SC", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_FC_STYLE_1:
-		printf(" (Fibre Channel Style 1 copper)\n");
+		strncpy(ctor_description, "Fibre Channel Style 1 copper",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_FC_STYLE_2:
-		printf(" (Fibre Channel Style 2 copper)\n");
+		strncpy(ctor_description, "Fibre Channel Style 2 copper",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_BNC_TNC:
-		printf(" (BNC/TNC)\n");
+		strncpy(ctor_description, "BNC/TNC", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_FC_COAX:
-		printf(" (Fibre Channel coaxial headers)\n");
+		strncpy(ctor_description, "Fibre Channel coaxial headers",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_FIBER_JACK:
-		printf(" (FibreJack)\n");
+		strncpy(ctor_description, "FibreJack", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_LC:
-		printf(" (LC)\n");
+		strncpy(ctor_description, "LC", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_MT_RJ:
-		printf(" (MT-RJ)\n");
+		strncpy(ctor_description, "MT-RJ", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_MU:
-		printf(" (MU)\n");
+		strncpy(ctor_description, "MU", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_SG:
-		printf(" (SG)\n");
+		strncpy(ctor_description, "SG", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_OPT_PT:
-		printf(" (Optical pigtail)\n");
+		strncpy(ctor_description, "Optical pigtail",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_MPO:
-		printf(" (MPO Parallel Optic)\n");
+		strncpy(ctor_description, "MPO Parallel Optic",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_MPO_2:
-		printf(" (MPO Parallel Optic - 2x16)\n");
+		strncpy(ctor_description, "MPO Parallel Optic - 2x16",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_HSDC_II:
-		printf(" (HSSDC II)\n");
+		strncpy(ctor_description, "HSSDC II", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_COPPER_PT:
-		printf(" (Copper pigtail)\n");
+		strncpy(ctor_description, "Copper pigtail",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_RJ45:
-		printf(" (RJ45)\n");
+		strncpy(ctor_description, "RJ45", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_NO_SEPARABLE:
-		printf(" (No separable connector)\n");
+		strncpy(ctor_description, "No separable connector",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_MXC_2x16:
-		printf(" (MXC 2x16)\n");
+		strncpy(ctor_description, "MXC 2x16", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_CS_OPTICAL:
-		printf(" (CS optical connector)\n");
+		strncpy(ctor_description, "CS optical connector",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_CS_OPTICAL_MINI:
-		printf(" (Mini CS optical connector)\n");
+		strncpy(ctor_description, "Mini CS optical connector",
+			SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_MPO_2X12:
-		printf(" (MPO 2x12)\n");
+		strncpy(ctor_description, "MPO 2x12", SFF_MAX_DESC_LEN);
 		break;
 	case MODULE_CTOR_MPO_1X16:
-		printf(" (MPO 1x16)\n");
+		strncpy(ctor_description, "MPO 1x16", SFF_MAX_DESC_LEN);
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		strncpy(ctor_description, "reserved or unknown",
+			SFF_MAX_DESC_LEN);
 		break;
 	}
+
+	sff_print_any_hex_field("Connector", "connector", id[ctor_offset],
+				ctor_description);
 }
 
 void module_show_mit_compliance(u16 value)
 {
-	static const char *cc = " (Copper cable,";
-
-	printf("\t%-41s : 0x%02x", "Transmitter technology", value);
+	static const char *cc = "Copper cable,";
+	char description[SFF_MAX_DESC_LEN];
 
 	switch (value) {
 	case MODULE_850_VCSEL:
-		printf(" (850 nm VCSEL)\n");
+		strncpy(description, "850 nm VCSEL", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1310_VCSEL:
 	case SFF8636_TRANS_1310_VCSEL:
-		printf(" (1310 nm VCSEL)\n");
+		strncpy(description, "1310 nm VCSEL", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1550_VCSEL:
 	case SFF8636_TRANS_1550_VCSEL:
-		printf(" (1550 nm VCSEL)\n");
+		strncpy(description, "1550 nm VCSEL", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1310_FP:
 	case SFF8636_TRANS_1310_FP:
-		printf(" (1310 nm FP)\n");
+		strncpy(description, "1310 nm FP", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1310_DFB:
 	case SFF8636_TRANS_1310_DFB:
-		printf(" (1310 nm DFB)\n");
+		strncpy(description, "1310 nm DFB", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1550_DFB:
 	case SFF8636_TRANS_1550_DFB:
-		printf(" (1550 nm DFB)\n");
+		strncpy(description, "1550 nm DFB", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1310_EML:
 	case SFF8636_TRANS_1310_EML:
-		printf(" (1310 nm EML)\n");
+		strncpy(description, "1310 nm EML", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1550_EML:
 	case SFF8636_TRANS_1550_EML:
-		printf(" (1550 nm EML)\n");
+		strncpy(description, "1550 nm EML", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_OTHERS:
 	case SFF8636_TRANS_OTHERS:
-		printf(" (Others/Undefined)\n");
+		strncpy(description, "Others/Undefined", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_1490_DFB:
 	case SFF8636_TRANS_1490_DFB:
-		printf(" (1490 nm DFB)\n");
+		strncpy(description, "1490 nm DFB", SFF_MAX_DESC_LEN);
 		break;
 	case CMIS_COPPER_UNEQUAL:
 	case SFF8636_TRANS_COPPER_PAS_UNEQUAL:
-		printf("%s unequalized)\n", cc);
+		snprintf(description, SFF_MAX_DESC_LEN, "%s unequalized", cc);
 		break;
 	case CMIS_COPPER_PASS_EQUAL:
 	case SFF8636_TRANS_COPPER_PAS_EQUAL:
-		printf("%s passive equalized)\n", cc);
+		snprintf(description, SFF_MAX_DESC_LEN, "%s passive equalized",
+			 cc);
 		break;
 	case CMIS_COPPER_NF_EQUAL:
 	case SFF8636_TRANS_COPPER_LNR_FAR_EQUAL:
-		printf("%s near and far end limiting active equalizers)\n", cc);
+		snprintf(description, SFF_MAX_DESC_LEN,
+			 "%s near and far end limiting active equalizers", cc);
 		break;
 	case CMIS_COPPER_F_EQUAL:
 	case SFF8636_TRANS_COPPER_FAR_EQUAL:
-		printf("%s far end limiting active equalizers)\n", cc);
+		snprintf(description, SFF_MAX_DESC_LEN,
+			 "%s far end limiting active equalizers", cc);
 		break;
 	case CMIS_COPPER_N_EQUAL:
 	case SFF8636_TRANS_COPPER_NEAR_EQUAL:
-		printf("%s near end limiting active equalizers)\n", cc);
+		snprintf(description, SFF_MAX_DESC_LEN,
+			 "%s near end limiting active equalizers", cc);
 		break;
 	case CMIS_COPPER_LINEAR_EQUAL:
 	case SFF8636_TRANS_COPPER_LNR_EQUAL:
-		printf("%s linear active equalizers)\n", cc);
+		snprintf(description, SFF_MAX_DESC_LEN, "%s linear active equalizers",
+			 cc);
 		break;
 	}
+
+	sff_print_any_hex_field("Transmitter technology",
+				"transmitter_technology", value, description);
 }
 
 void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
 {
-	PRINT_TEMP("Module temperature", sd->sfp_temp[MCURR]);
-	PRINT_VCC("Module voltage", sd->sfp_voltage[MCURR]);
+	PRINT_TEMP_ALL("Module temperature", "module_temperature",
+		       sd->sfp_temp[MCURR]);
+	print_string(PRINT_JSON, "module_temperature_units", "%s", "degrees C");
+
+
+	PRINT_VCC_ALL("Module voltage", "module_voltage",
+		      sd->sfp_voltage[MCURR]);
+	print_string(PRINT_JSON, "module_voltage_units", "%s", "V");
 }
diff --git a/module-common.h b/module-common.h
index 8c34779..9c0adbb 100644
--- a/module-common.h
+++ b/module-common.h
@@ -264,6 +264,13 @@ struct module_aw_chan {
 extern const struct module_aw_mod module_aw_mod_flags[];
 extern const struct module_aw_chan module_aw_chan_flags[];
 
+void convert_json_field_name(const char *str, char *json_str);
+void module_print_any_units(const char *json_fn, const char *unit);
+void module_print_any_uint(const char *fn, int value, const char *unit);
+void module_print_any_string(const char *fn, const char *value);
+void module_print_any_float(const char *fn, float value, const char *unit);
+void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
+			   const char *str_value);
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit);
diff --git a/sff-common.c b/sff-common.c
index e2f2463..fb3945c 100644
--- a/sff-common.c
+++ b/sff-common.c
@@ -29,50 +29,120 @@ double convert_mw_to_dbm(double mw)
 	return (10. * log10(mw / 1000.)) + 30.;
 }
 
+void sff_print_any_hex_field(const char *field_name,
+			     const char *json_field_name, u8 value,
+			     const char *desc)
+{
+	char desc_name[SFF_MAX_FIELD_LEN];
+
+	if (is_json_context()) {
+		print_int(PRINT_JSON, json_field_name, "0x%02x", value);
+		if (desc) {
+			snprintf(desc_name, SFF_MAX_FIELD_LEN,
+				 "%s_description", json_field_name);
+			print_string(PRINT_JSON, desc_name, "%s", desc);
+		}
+	} else {
+		printf("\t%-41s : 0x%02x", field_name, value);
+		if (desc)
+			printf(" (%s)", desc);
+		print_nl();
+	}
+}
+
 void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
 {
-	printf("\t%-41s : 0x%02x", "Encoding", id[encoding_offset]);
+	char encoding_desc[64];
+
 	switch (id[encoding_offset]) {
 	case SFF8024_ENCODING_UNSPEC:
-		printf(" (unspecified)\n");
+		strncpy(encoding_desc, "unspecified", 64);
 		break;
 	case SFF8024_ENCODING_8B10B:
-		printf(" (8B/10B)\n");
+		strncpy(encoding_desc, "8B/10B", 64);
 		break;
 	case SFF8024_ENCODING_4B5B:
-		printf(" (4B/5B)\n");
+		strncpy(encoding_desc, "4B/5B", 64);
 		break;
 	case SFF8024_ENCODING_NRZ:
-		printf(" (NRZ)\n");
+		strncpy(encoding_desc, "NRZ", 64);
 		break;
 	case SFF8024_ENCODING_4h:
 		if (sff_type == ETH_MODULE_SFF_8472)
-			printf(" (Manchester)\n");
+			strncpy(encoding_desc, "Manchester", 64);
 		else if (sff_type == ETH_MODULE_SFF_8636)
-			printf(" (SONET Scrambled)\n");
+			strncpy(encoding_desc, "SONET Scrambled", 64);
 		break;
 	case SFF8024_ENCODING_5h:
 		if (sff_type == ETH_MODULE_SFF_8472)
-			printf(" (SONET Scrambled)\n");
+			strncpy(encoding_desc, "SONET Scrambled", 64);
 		else if (sff_type == ETH_MODULE_SFF_8636)
-			printf(" (64B/66B)\n");
+			strncpy(encoding_desc, "64B/66B", 64);
 		break;
 	case SFF8024_ENCODING_6h:
 		if (sff_type == ETH_MODULE_SFF_8472)
-			printf(" (64B/66B)\n");
+			strncpy(encoding_desc, "64B/66B", 64);
 		else if (sff_type == ETH_MODULE_SFF_8636)
-			printf(" (Manchester)\n");
+			strncpy(encoding_desc, "Manchester", 64);
 		break;
 	case SFF8024_ENCODING_256B:
-		printf(" ((256B/257B (transcoded FEC-enabled data))\n");
+		strncpy(encoding_desc,
+			"256B/257B (transcoded FEC-enabled data)", 64);
 		break;
 	case SFF8024_ENCODING_PAM4:
-		printf(" (PAM4)\n");
+		strncpy(encoding_desc, "PAM4", 64);
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		strncpy(encoding_desc, "reserved or unknown", 64);
 		break;
 	}
+
+	sff_print_any_hex_field("Encoding", "encoding", id[encoding_offset],
+				encoding_desc);
+}
+
+
+void sff_show_thresholds_json(struct sff_diags sd)
+{
+	open_json_object("laser_bias_current");
+	PRINT_BIAS_JSON("high_alarm_threshold", sd.bias_cur[HALRM]);
+	PRINT_BIAS_JSON("low_alarm_threshold", sd.bias_cur[LALRM]);
+	PRINT_BIAS_JSON("high_warning_threshold", sd.bias_cur[HWARN]);
+	PRINT_BIAS_JSON("low_warning_threshold", sd.bias_cur[LWARN]);
+	print_string(PRINT_JSON, "units", "%s", "mA");
+	close_json_object();
+
+	open_json_object("laser_output_power");
+	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.tx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.tx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning_threshold", sd.tx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning_threshold", sd.tx_power[LWARN]);
+	print_string(PRINT_JSON, "units", "%s", "mW");
+	close_json_object();
+
+	open_json_object("module_temperature");
+	PRINT_TEMP_JSON("high_alarm_threshold", sd.sfp_temp[HALRM]);
+	PRINT_TEMP_JSON("low_alarm_threshold", sd.sfp_temp[LALRM]);
+	PRINT_TEMP_JSON("high_warning_threshold", sd.sfp_temp[HWARN]);
+	PRINT_TEMP_JSON("low_warning_threshold", sd.sfp_temp[LWARN]);
+	print_string(PRINT_JSON, "units", "%s", "degrees C");
+	close_json_object();
+
+	open_json_object("module_voltage");
+	PRINT_VCC_JSON("high_alarm_threshold", sd.sfp_voltage[HALRM]);
+	PRINT_VCC_JSON("low_alarm_threshold", sd.sfp_voltage[LALRM]);
+	PRINT_VCC_JSON("high_warning_threshold", sd.sfp_voltage[HWARN]);
+	PRINT_VCC_JSON("low_warning_threshold", sd.sfp_voltage[LWARN]);
+	print_string(PRINT_JSON, "units", "%s", "V");
+	close_json_object();
+
+	open_json_object("laser_rx_power");
+	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.rx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.rx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning_threshold", sd.rx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning_threshold", sd.rx_power[LWARN]);
+	print_string(PRINT_JSON, "units", "%s", "mW");
+	close_json_object();
 }
 
 void sff_show_thresholds(struct sff_diags sd)
diff --git a/sff-common.h b/sff-common.h
index 161860c..3c02a69 100644
--- a/sff-common.h
+++ b/sff-common.h
@@ -26,6 +26,9 @@
 #include <stdio.h>
 #include "internal.h"
 
+#define SFF_MAX_DESC_LEN   120
+#define SFF_MAX_FIELD_LEN  64
+
 /* Revision compliance */
 #define  SFF8636_REV_UNSPECIFIED		0x00
 #define  SFF8636_REV_8436_48			0x01
@@ -71,19 +74,53 @@
 		      (double)((var) / 10000.),                           \
 		       convert_mw_to_dbm((double)((var) / 10000.)))
 
+#define PRINT_xX_PWR_JSON(string, var)				\
+		print_float(PRINT_JSON, string, "%.2f",		\
+			    (double)((var) / 10000.))
+
+#define PRINT_xX_PWR_ALL(string, json_string, var)		\
+		is_json_context() ?				\
+		PRINT_xX_PWR_JSON(json_string, var) :		\
+		PRINT_xX_PWR(string, var)
+
 #define PRINT_BIAS(string, bias_cur)                             \
 		printf("\t%-41s : %.3f mA\n", (string),                       \
 		      (double)(bias_cur / 500.))
 
+#define PRINT_BIAS_JSON(string, bias_cur)			\
+		print_float(PRINT_JSON, string, "%.3f",		\
+			    (double)(bias_cur / 500.))
+
+#define PRINT_BIAS_ALL(string, json_string, bias_cur)		\
+		is_json_context() ?				\
+		PRINT_BIAS_JSON(json_string, bias_cur) :	\
+		PRINT_BIAS(string, bias_cur)
+
 #define PRINT_TEMP(string, temp)                                   \
 		printf("\t%-41s : %.2f degrees C / %.2f degrees F\n", \
 		      (string), (double)(temp / 256.),                \
 		      (double)(temp / 256. * 1.8 + 32.))
 
+#define PRINT_TEMP_JSON(string, temp)				\
+		print_float(PRINT_JSON, string, "%.2f", (double)(temp / 256.))
+
+#define PRINT_TEMP_ALL(string, json_string, temp)		\
+		is_json_context() ?				\
+		PRINT_TEMP_JSON(json_string, temp) : PRINT_TEMP(string, temp)
+
 #define PRINT_VCC(string, sfp_voltage)          \
 		printf("\t%-41s : %.4f V\n", (string),       \
 		      (double)(sfp_voltage / 10000.))
 
+#define PRINT_VCC_JSON(string, sfp_voltage)			\
+		print_float(PRINT_JSON, string, "%.4f",		\
+			    (double)(sfp_voltage / 10000.))
+
+#define PRINT_VCC_ALL(string, json_string, sfp_voltage)		\
+		is_json_context() ? 				\
+		PRINT_VCC_JSON(json_string, sfp_voltage) :	\
+		PRINT_VCC(string, sfp_voltage)
+
 # define PRINT_xX_THRESH_PWR(string, var, index)                       \
 		PRINT_xX_PWR(string, (var)[(index)])
 
@@ -129,7 +166,11 @@ struct sff_diags {
 };
 
 double convert_mw_to_dbm(double mw);
+void sff_print_any_hex_field(const char *field_name,
+			     const char *json_field_name, u8 value,
+			     const char *desc);
 void sff_show_thresholds(struct sff_diags sd);
+void sff_show_thresholds_json(struct sff_diags sd);
 
 void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type);
 
-- 
2.47.0


