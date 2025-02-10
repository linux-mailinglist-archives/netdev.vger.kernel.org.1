Return-Path: <netdev+bounces-164618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F4A2E7DC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF88163877
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6661CAA86;
	Mon, 10 Feb 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="idLnA3HO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC541CAA65
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180049; cv=fail; b=qRbsF02vPJwMjAjDZ2VsDAY0alTy7w9fw1c6UdFz775DOGApFPkNo3GFVfXAfzpqch8xXKUO9+HPdzVwox11cUoWzHhGRpW03mihYn+ucQyK+ueYg3cYzUIM/UYv1BW7qYuIGTcv6LCGvrzEtH5p81o+x93sAZgimNxAlduqgPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180049; c=relaxed/simple;
	bh=50745Tp2e44Z9TAl9QbujBz074H8j6epZMNfzYPvigA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sso1aSfM+Rbygpfeyw8+z36JgxbXlwRJs0d9ZH6BXKFMWpFz9nX2vgO4r+IPlCloB1mW0Y1JjR0+hwODbPkVVQWU9RfZRsE84hQDnVOZqE3ACadnueI6oU7l3pnqP0yrBeL5xmnb6rMQbDOHhcaOeQyhvFrMyOLSYvGzKtyKDAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=idLnA3HO; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mcl/lMngIrhPb38XX4g3EJrQbMw8A3XDhhn9PYErTDBhXNjUO7d5Lf0HYuP0WHL5aQNlh1tJyDD35WsX4UmOU2q83f7cJzmiHWF5vMdipi23HfoU9IwIWeLA66AMnxoBPFvatL9vvnaldZX4C5VnOsa9IfH/z3HLuygcz9SiAYZex/9/8mY1fPvrXuWesU5Ycg9cqLqIo7pgKevYyDaqhykezqBUua90wSGgm12zcUkMx4iTw/pbK/UV0qFSwTeNrPP/cNtNR1OXHZdSUT6yQ0ocKglLY8+7KlbiiXj9VssMw9CopXVcdbjYLYjNJXsONM0eJpIvGPF4rqwVjKbjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djJkM5xWj4GDg1DYZqtr+nDALQfPhIOtdroKoUP2K6k=;
 b=yvhSWW1Arx48uwEWXSjoOMQDt49F3r9jf0YGh3ObaZyxCbGsZinLdqVoIx1QJ7iO7UNVcib8Ufby8rlN8N2O1UK0M9tnHRFoZv0g+nIBkc/BeYT1899caZSH1csolOsSS/4Qlmq9QHYzmESD7qMZPz330iM9k59fkodaws1klPJJbtGVPVNWtrr/MXxh9YG9tOIhS56AsQVHlgqR+q4zesp/ats/Jj5EtBQGyVF6SGTwhkKPrwfibYvPC5jS0ghIdYK1BzFCPvWDy/Yk4S60j5/hLboTcowSfspjJGnYRnKcnYTNpCEj2yiAyUhPZKtQc/ElOJHzwy4DkV5AQz3W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djJkM5xWj4GDg1DYZqtr+nDALQfPhIOtdroKoUP2K6k=;
 b=idLnA3HOZWKPxCEO+M9z5iTQAt40pD/I60AO6apYwZJpwpNqSPbnpvE3rTiOuQkAkrxKXn9srP0AaHThNs/LXWah+HpOc11YeK1NaKYp4bYJ41BLhgqcdtjhaxpjtsSuZqhwnJLKCTgv1gZIaFVdUbym5TvYroqIOTAnqg3aFqxFdeKizv+qptCs3xCtxl1Wse6knX7BQm83z5q+Ob0bDpbnnKMkhi6Bo1P7SQ35wpZF216NPIlTOYgidVS9tdS6KqN6w5ifrVL9rEWWBUT7NuzqcAEGDHthXzHqbT190It+xB7BuoZpR2tJWBdVDN5IowoJPfNMYI6zuO/rN7p9QQ==
Received: from CH0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:610:cc::13)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:34:01 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::27) by CH0PR03CA0068.outlook.office365.com
 (2603:10b6:610:cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:48 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:45 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 07/16] module_common: Add helpers to support JSON printing for common value types
Date: Mon, 10 Feb 2025 11:33:07 +0200
Message-ID: <20250210093316.1580715-8-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc4924e-0363-4989-f547-08dd49b60cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D95/ErsnW5k4D0VtKl7wTVaUPwNA/Y/VVbxaWbPLCawTSKmiFs9RfJB8CFt/?=
 =?us-ascii?Q?vNc8aEFhLjP27EdD0x35HrKSJPuucmq/1QsDb8+0AzPYRkrlO5ebxg1Y/kX9?=
 =?us-ascii?Q?Wc/CZjjtjQgQVw6FRm7Tz6CUI9EzrlJE4o5xC81vquAych86VTCL3gGvd5py?=
 =?us-ascii?Q?xOONaqr6GKZYUv0QJlUjZSRFxAvov1ZOrdYQDwq5sAnqeoV13fe6r7dd7t6g?=
 =?us-ascii?Q?AQ6MxiCNNzYxBRC4mj0LLjZE6Ev2jd7DCVNGjXV5KBYexvJ/6yn6lWo825qG?=
 =?us-ascii?Q?w+F1UN7uFzpX4Cym+8DarZ80C34V+XXbjNh7Q1DTu4GOYf/pttxNkzB+k21b?=
 =?us-ascii?Q?O36EattFQDAs/ag4mYj6tvGxJc7Si6PIT7ypXLheCt1x4pgvvjqkZHPyAy8l?=
 =?us-ascii?Q?j6DhbL4dtwrwLFpM5zbEk8nxkthVeisgCpEzy1BXnQiKvufii03+EZ97XZ/D?=
 =?us-ascii?Q?J2qteYXJqr03hXZTXtOLV1oVwqqlq7DRUlgMNd1c44NTc2so8mC+dTixdZd1?=
 =?us-ascii?Q?D/3Er7TDdVw2o9/cRuQMEEOKu2rPOudHuG7nEjsKMw1Qx0NMvDrzEAoq06Bp?=
 =?us-ascii?Q?KtQZ6in+GenRqNdpBiKqpit/HD5kI3kfGWM3dmgvhv6JIpOcrIKG80s1Obmg?=
 =?us-ascii?Q?MDHnSd01yuAC05p84ubXiAMedZ6JplkeD/Jq+tZAwBcEcm7N2wHQ8rbKPQ9W?=
 =?us-ascii?Q?bplMSO5qxfslBnfqOh3NVt/SZe1vQz2NjBqk3jAlXZD7+dDn9rK4GXqrwAO+?=
 =?us-ascii?Q?dbhR7qyhFDL3sdHzJTVKXnNTaWAto2KG2HNrAp3hf6f5+iNXZsDnkC2vp3ZY?=
 =?us-ascii?Q?aSUsfrzqYXoezDbgH4m8SifvoWwuywgUXCRNLYeZd+ZzNGLWhxPkypPxnv3H?=
 =?us-ascii?Q?YChM+PH0tWCxotqQ50IsiVG8JzXpeclkYUa0a9kG3Z6L9oiV568NyYRvKtZp?=
 =?us-ascii?Q?7iJS16N5Hf9mv1DLoCvihCG+yqPd8GPzPvGcN80igK5yYb3LdwKWqMewIyHI?=
 =?us-ascii?Q?bvNu3/OizsFnJbmLyVQs9/Wo5OygawfO3PFYyIrPwxK+k32mlSuwa2DhwFas?=
 =?us-ascii?Q?Q8art5+wBYF3gJSImIEps8GQX/VzZJZbd0sLWVTuYhMFMl8zTI17W8M+iss2?=
 =?us-ascii?Q?9YT8ljaQM+NZF/AeCm787dWRsp4iGz+6SxXrGYepUd7f+wKVePVFAdNkhr07?=
 =?us-ascii?Q?/ICKbaRVSsJ+kglB2C3ZWNK6XIstkcAhT65fWzZ5ubC5CqvKeOQVdWorx5AO?=
 =?us-ascii?Q?V54iVid1wyF+//Ap+3ihT24VTLm1a1qxmOaKYoIrHBSTt7npc8I7vB6txjgH?=
 =?us-ascii?Q?d+Q2/dXv+vj2XzeazhI/jOJqfiLm73ma2kplDL/PeKPSJggryIO91JY3STGy?=
 =?us-ascii?Q?YMag3KGiTc2y46im+90MyA6LvO8XxO8OZHtDmHDcQ8sd/IBLtju2drkomZUy?=
 =?us-ascii?Q?B4lWtzi4ucVPt14XPzEFTtxMJjdEb7Urm58qb8siyPF59kYVzQLFSKMK9kRB?=
 =?us-ascii?Q?L9QMpWia9V/3eA8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:00.4975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc4924e-0363-4989-f547-08dd49b60cf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795

Upcoming patches will introduce JSON support to the ethtool dump. The
ethtool dump currently handles various field types, including strings,
unsigned integers, floats, etc.

To facilitate this transition, implement helper functions for commonly
used types. These helpers will enable consistent printing for both JSON
and regular dump formats.

In addition, add JSON support for common functions and defines to use in
the upcoming patches.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---

Notes:
    v3:
    	* Remove unit fields.
    	* Remove unit printings from helpers.
    
    v2:
    	* Use "false" in module_show_lane_status() instead of "None" in
    	  JSON context.
    	* Use uint instead of hexa fields in JSON context.

 module-common.c | 340 +++++++++++++++++++++++++++++++++++-------------
 module-common.h |   6 +
 sff-common.c    |  93 +++++++++++--
 sff-common.h    |  41 ++++++
 4 files changed, 374 insertions(+), 106 deletions(-)

diff --git a/module-common.c b/module-common.c
index 4146a84..9c21c2a 100644
--- a/module-common.c
+++ b/module-common.c
@@ -5,6 +5,7 @@
 
 #include <stdio.h>
 #include <math.h>
+#include <ctype.h>
 #include "module-common.h"
 
 const struct module_aw_mod module_aw_mod_flags[] = {
@@ -198,309 +199,464 @@ const struct module_aw_chan module_aw_chan_flags[] = {
 	{ 0, NULL, 0, 0, 0 },
 };
 
+void convert_json_field_name(const char *str,  char *json_str)
+{
+	for (size_t i = 0; i < strlen(str); i++)
+		json_str[i] = (str[i] == ' ') ?
+				'_' : tolower((unsigned char)str[i]);
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
+		printf("\t%-41s : %u%s\n", fn, value, unit ? unit : "");
+	}
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
+		printf("\t%-41s : %.04f%s\n", fn, value, unit ? unit : "");
+	}
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
+			print_bool(PRINT_JSON, json_fn, NULL, false);
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
+	PRINT_VCC_ALL("Module voltage", "module_voltage",
+		      sd->sfp_voltage[MCURR]);
 }
diff --git a/module-common.h b/module-common.h
index 8c34779..985b518 100644
--- a/module-common.h
+++ b/module-common.h
@@ -264,6 +264,12 @@ struct module_aw_chan {
 extern const struct module_aw_mod module_aw_mod_flags[];
 extern const struct module_aw_chan module_aw_chan_flags[];
 
+void convert_json_field_name(const char *str, char *json_str);
+void module_print_any_uint(const char *fn, int value, const char *unit);
+void module_print_any_string(const char *fn, const char *value);
+void module_print_any_float(const char *fn, float value, const char *unit);
+void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
+			   const char *str_value);
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit);
diff --git a/sff-common.c b/sff-common.c
index e2f2463..0824dfb 100644
--- a/sff-common.c
+++ b/sff-common.c
@@ -29,50 +29,115 @@ double convert_mw_to_dbm(double mw)
 	return (10. * log10(mw / 1000.)) + 30.;
 }
 
+void sff_print_any_hex_field(const char *field_name,
+			     const char *json_field_name, u8 value,
+			     const char *desc)
+{
+	char desc_name[SFF_MAX_FIELD_LEN];
+
+	if (is_json_context()) {
+		print_uint(PRINT_JSON, json_field_name, "%u", value);
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
+	close_json_object();
+
+	open_json_object("laser_output_power");
+	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.tx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.tx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning_threshold", sd.tx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning_threshold", sd.tx_power[LWARN]);
+	close_json_object();
+
+	open_json_object("module_temperature");
+	PRINT_TEMP_JSON("high_alarm_threshold", sd.sfp_temp[HALRM]);
+	PRINT_TEMP_JSON("low_alarm_threshold", sd.sfp_temp[LALRM]);
+	PRINT_TEMP_JSON("high_warning_threshold", sd.sfp_temp[HWARN]);
+	PRINT_TEMP_JSON("low_warning_threshold", sd.sfp_temp[LWARN]);
+	close_json_object();
+
+	open_json_object("module_voltage");
+	PRINT_VCC_JSON("high_alarm_threshold", sd.sfp_voltage[HALRM]);
+	PRINT_VCC_JSON("low_alarm_threshold", sd.sfp_voltage[LALRM]);
+	PRINT_VCC_JSON("high_warning_threshold", sd.sfp_voltage[HWARN]);
+	PRINT_VCC_JSON("low_warning_threshold", sd.sfp_voltage[LWARN]);
+	close_json_object();
+
+	open_json_object("laser_rx_power");
+	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.rx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.rx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning_threshold", sd.rx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning_threshold", sd.rx_power[LWARN]);
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


