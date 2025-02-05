Return-Path: <netdev+bounces-163108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7CA29570
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4195716838F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F71925A6;
	Wed,  5 Feb 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Agkev1pf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416F1922C4
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770947; cv=fail; b=hLHk02CZ6pJsjUkstGhx5dI6nB5xcllR0Q8myAX6msUhzOFe7zsDtrir+pQHKDOtpxvMIKYh369hgeL1tu9hB72m5tE7SJrohMCFjcXfZQVdy2N7WxC6gOjs+sTiiW1l23P0ehPY1/x/xjKx+oyrYhPYYWa1bTmTcjlh7VVtR+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770947; c=relaxed/simple;
	bh=y/w2fFrqupFHAzaSK3QCMuWL8+oxkkH7vyTRGyA01lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVLGcOrJkhdkwi1pp6OpRb0GZXLHEsNGGMp9Ie4CKaj68hzT8TpGubBYn+JMMy/rE+xsxUjoYCtkx0j1vZmOK6lMDJr0IRrjJKLsviP7n34eeyZ+M1tRcIjRxEVjBByvdqF7o0HOc5ac/YrHXWeGsngiqLhEMp85ESJAFyCq9JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Agkev1pf; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeRRFGI4THrnjn7ivOIHL2IDjqQU8VmofP2U3TbJYBG8t04zLOpRn1PbU7gfBlDVT8NZOazw1WohRPWmqO6zY46BomYRJJPZUxoyuSmZILf+FSx81o3qCmV3Xsw8/0AefN0RAu/5sTLFx/sP92MCCec3n9FtyGszfWsXG0cBBmLt2TYgyD3DFcTjTI8Ej7Q4smYjSNAFf/m8lC9kP8jooX21BaBob45/8q2vT7EaHp3K/iRXF+yV1A1M+lHo3QAmIhhXxwQQbwXgx/r2dqwnztOzbGLybDffnng8Tp4hTSbkmKq67cj2GvEiv/HeNumnLWw7dQnEP6opKopLMrznjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsMg8y40z74pTFZ9l4g/DokaWGvg9N4r8c5UR2bRK/8=;
 b=PWIb3wOPpBeQXS/lE5pVyyo8qIS5G723qv3ywc/P0Sr4WYv8FkVThgGmKMGp4QqQ/fVt24a8QstF2O6f8XPopewjcIMsqhFU4NUwRt3UXg6jXvk47QVOuvFQVticCvu9xURArMD+s2gQYArrRcOUk0TJCcvR7erH8AnHRBHT6FcUWbzBsgU4gSZupL8kJWt8MCoW2xYsS21BElUFoasn8dkRqNtTwSmHETG9HVRengH9k+0J/Yt7ss3QzTJIZ9h/OjX3o3LQbqlX2AnqjF5o8nl49mr5rWkTmoTFShwnnOpP8J4XbtH0IG9XE2W/QpZMtfD8NxYnAB8e9w4H8d3rBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsMg8y40z74pTFZ9l4g/DokaWGvg9N4r8c5UR2bRK/8=;
 b=Agkev1pfZAlftamEK3C21ElBvS+dQfPTq6O7HqI17SKbeCCuIONbovNxBBuON1x/VJ8+kbMgsWER52csE9dnLd5EpyibjyasFqFfGfa5shwG/jSa54lPLS6iTTPRBJUR1ft359YjNSMcW/4i3qP2gM868h6pvvECna4EC8VwEvYMFolo1krnKPnpKYvXUMgDE5YWrWlJtTxVPXyfbyKq3ANxu9OWRCSk68f8m/nOcbZt5uHKpxZoc/15oCPQiUrXsd4sKwGcVGIonmA536FFRYbaFSTLFNxgQ6g0SuD/LS64kb6f5haA32ALibF09j03Hhh81hR61M4zCwbLN/lTqw==
Received: from BL6PEPF00013E00.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1a) by DM4PR12MB5938.namprd12.prod.outlook.com
 (2603:10b6:8:69::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:55:36 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2a01:111:f403:c803::8) by BL6PEPF00013E00.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Wed,
 5 Feb 2025 15:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Wed, 5 Feb 2025 15:55:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:12 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:10 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 07/16] module_common: Add helpers to support JSON printing for common value types
Date: Wed, 5 Feb 2025 17:54:27 +0200
Message-ID: <20250205155436.1276904-8-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc806cd-337c-44e6-31ac-08dd45fd876f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NeMqfkjJAR/UJcvD45zzjEMwLutdS6yWPzw9eotlx+f3ywyNJpK3Ks6OnWSM?=
 =?us-ascii?Q?lDMBm+yrJ7S4wWNvRPhrJTtsKDltfNW53LZ75F815GuscDKuQ++F5ZP7KaUg?=
 =?us-ascii?Q?KyRjFkrlH6Yef60ejq+wR8tQpeJDlcB/iu2k3Kc4R/9WnKuxgpwBMbDlpnk9?=
 =?us-ascii?Q?HgK5+V92T4aRaqaH2qsxjJCQeYVFseQHif8pskf9IDKf0fzOWPWs7PhG1R/b?=
 =?us-ascii?Q?7GRR8M8Afe5s7DeT279WlOkVovKp/0Nj8TwwzrgduKXeTolydcvcf1fFhz2Z?=
 =?us-ascii?Q?+QYVNmTB8KJlR5Szkqzs9sgPUWmdG72Alx9TbiURi6K0O0BmP8du3dGQS59L?=
 =?us-ascii?Q?a8xg7AZp2G7zkeeI8+48uqEQVslzHtzRp8dUW16hILRnJlsMpm97gjzqznPm?=
 =?us-ascii?Q?p09mNVh8EmUPgHiVcD1JQTpRL8xTvzH3suO231Uv4haa4r9v2IZncvy8xw7e?=
 =?us-ascii?Q?8WJZY23hQW8EJdc5p6LPwIHzf8tXj5zkrhkrNRaqtGHp8iuix/FtxrWuHu/r?=
 =?us-ascii?Q?dcabH7dYSKs+6sjzya09y2Hg3gEIrizGKcvbpai2qRg+mNSac+xFlJh7XDJv?=
 =?us-ascii?Q?hbFJqc13t50u8ze+4hhvtn4++7E9VbQJ6TXDb2CdbyhmopzRgyqMaCyKFGmD?=
 =?us-ascii?Q?8ZrrRJH9fjDuKeK0WmEeD374H6mvPODo/Mlsl/gqmqlWasYwaO28zixdgfpg?=
 =?us-ascii?Q?iwsOWjr3B4eHUPsvpYOsrgt1w/DK8qaHxUUThgmuke5gbgFeEhd+Y1jeReyJ?=
 =?us-ascii?Q?sFN3cxolvQ4wXqWJX//QKKnK2w15Kofpz8VeWzbzKVPxp4ji/OH9sFkyfFEx?=
 =?us-ascii?Q?is5YMjpANwZ5kCkV0rQOVKfRgdiKe6jjVFzJCZ2CiTwPgg59QRbfYFhDQgab?=
 =?us-ascii?Q?5wJyqYxgHZCsW3s2y4ExhTPYxQq/jhjDQwhkDQdoyNw9F2C+LB7yXe4ViSv5?=
 =?us-ascii?Q?Y+v8RtNdRibomJGT9UNtOb5upzfo+dl6Yts+sq1Nv544EZ83yScxkesx9b6c?=
 =?us-ascii?Q?sLjuJBbDo+nWuNWlnyk2EIsFxCnuA5CPQVy5Uo09byoP/8QjlYlwi0xGgVHT?=
 =?us-ascii?Q?zOKS7Py9opPG9FEH6+luQPzxFrH/C3mvgaSx+hlBrsXoynM6fzqYvC6eOQY7?=
 =?us-ascii?Q?ZMkU4R8m+BnOVW8nzWuK5iM8cfyJ6/YHs0MdQ9No5rYMRgRZgk96qlPntVxm?=
 =?us-ascii?Q?w8+KxJRA8zsfOiVhaAk45+iu3AWfjdSk4QaDaUv2i3vx6TXl9Z5jCw9hQF9a?=
 =?us-ascii?Q?N0Dl3mwPUOhhzdRpF24+W+J0LnQO+J8vg+JkIdnxPR1OzmNSPvfHYS8rdxVx?=
 =?us-ascii?Q?6vTuZ4OLmpo5tksfZIfuSzh1ZwJiyhjg7Eh/BtZHdPH/dE5Zm4URdhIlUrAB?=
 =?us-ascii?Q?aax46t/sXjPtbHLb+ZQwU3ZPl65pqKSJBVVgAacxOZq8v2lwuA08Hflctx9y?=
 =?us-ascii?Q?tic8tC+fDFcwX2ov7BxQm4v/RxBJxbQxf3y5CVWWDMLCQ5qQxCiIP9wOYKgD?=
 =?us-ascii?Q?xKAHPadLBhuCzjc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:35.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc806cd-337c-44e6-31ac-08dd45fd876f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

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


