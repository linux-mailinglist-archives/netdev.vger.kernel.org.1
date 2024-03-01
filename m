Return-Path: <netdev+bounces-76390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C50C86D952
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77461F21C8A
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA80383A5;
	Fri,  1 Mar 2024 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aXPJqW8U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39432B9B6
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258557; cv=fail; b=R05JNLbpN8lNoZNbp8Q/fl6xJxXJgJM+MZ7D5I8GMXTbIKmgNLoxUeRBVfoSMmXsO4S0WjnKQUxMR8jJT/mxCRcrcRxX/3sNek9MsYDvBFl5J1MkPtGdFm6Y5+YNZ4dgcvfvTHHo6cpN6Tl01+EP8v7nm2UBbQw43b0HwaqR8lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258557; c=relaxed/simple;
	bh=EY5XIcGe1tc9ThWdoyXH/kddpbMnT7o76TVsaaPgwgs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LcTzdiZBk4hNz5BdJsk+A98ytNIOf4XCCjWdHnj6Yh/XTz6DUNhdgsCQTJbOHhVRTCrIWfCitjrycVlqkDUd0riTs4c/LuwXKcgaQq4qZWU+MJ8/FWbSGRW5A422cHmI3/pG+G1khid3XdI4igvuC4O+ox2+HTIEzxWD6yiVifI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aXPJqW8U; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXEI1jJTjX+zToOsKyi374gJp020nHeTP2j6+S9D0qb2x8XLABRpd7XvbYHhJEFS6cda8AtQQtreQYC8V7aryw3oN10jYrY5VMHWq3KiqxSCJoaApm6PGpFcFKLi/v+6d6LFMf0ee3xGsSetGeM6QbXKx0f8NgkS6rg4uKySc+5PdVvuS2uw66/cn180XbDGUbmKnGY7MBwaSCnyRJHlc6fAQ9Q2ISz/doaqn+EKJdbKhJHpiSthskbRsk6gNgaK3sYuGnPvFLMfPiiO/HUhA5z6yDsCLPATzkXL//ZCcBxnifjlEK2KHZ/LWv/GqmYA91wXGt223/ZqpIBs983AeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9HBjckWW8zq8s8g/IFNLOsmnP4Kh0GjxKoM6P4I5mM=;
 b=P1rRxkdEijGQ6U4c43DAjjzgnsHrZWGtDtuX8giPnoXXlBoZJXvsGorSyHlELlu5ycHcSayVQAJTrDEyRcnmuHr5WSktMPz6SeWqxDulsTetE93hoOg4huh6/FkbKeoAdf7PXOc+06tqqpioV9491IfvPy8bYmfW3rWyfekRAoUi7awJ51vHuTdneAJnrEQQM31PDEk9fNwtZKT5zBmpG/lzdyImiMKW0DIAebl9ZWxfEWzbhZi3ydhKDNCATlsIWr50hjtWei5lrNoL+9/J+S3/8MxXcLv94B3lG08kMIdGWvoqbdHunLzPJQl6iUIkQaklTWHoKfVN4pHvtcx98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9HBjckWW8zq8s8g/IFNLOsmnP4Kh0GjxKoM6P4I5mM=;
 b=aXPJqW8U0baYn2uo/Y+sKXTaNaPFC/IMODTfFFd1M9NJMuPb9OX8H8/bId38qPUJjtHSOxfrsTzJOxBqfgkU9eNi/tqfsUEjiKfKukEs/JnrC5ficxugp/jLbJ3fk0Sb3kjWt/BpcXY73vl7XaCcHKFyEAtI/tfvomSeD3ikXcjAo4EPqQNqBbgJSx+8MCQr7Sd4YjO38yrD+GNFGVws0G+vyZhcM66nv6fkHwUQvMP0Eb56RTpqjV2sXvvIYh7gD8gVrdrdKclbKjVUmjAvGweaUyYfkO5T5P+eBy0wH45/dx84a40EvpPPYnE45UGnNA+eTo/wa4jidTercJSalQ==
Received: from SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 02:02:32 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::2f) by SJ0PR03CA0075.outlook.office365.com
 (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 02:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 1 Mar 2024 02:02:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 18:02:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 29 Feb 2024 18:02:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 29 Feb 2024 18:02:17 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH RFC v2 iproute2-next] devlink: Add eswitch attr option for shared descriptors
Date: Fri, 1 Mar 2024 04:02:14 +0200
Message-ID: <20240301020214.8122-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc71992-f128-4899-b4d1-08dc3993a6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b8yAXAcvZcKDRh7GlJ5bTrNdXmvphYqzGNUTvggbf2U5MW4sjhVptxWQ+Hw5zHu6YegbkTAXPDLXqexY5ScHDCh0lA3iValYogJ3xJ/u3gmtkJuJTgx46rp1hAXaESOK8+6UrK0uJ3IrnhvRD7fFvu9xI4Q52E0v/L1VDaPh0qx7mMnkGmN7mOxf6s1dvyto34qBHzIwFxXxN3Iwlo9JlIpLOQTDfo8RRn+daonz8pXl05MRooJunHfY67u8ZdQy2VhoAnsi2O7hbKWOS1sb0yawJDTfK9IM3l6uk17S9jA/Axuz/Nb+Nr7DfDiT8QZhR+JbW2Lkio9JR0FBzSIaQWVzALhZuBZEsVP2yEGeSreOaAfREEU/nJLXRXhFv4bPV7YpklXdcVeThN5ioyhJNcm28GgsUcl5TKZu7yx6a4z5JWHCp+RNGMlz42Oh5JdH3bTZv8yYJD6u9rwDkXD0c993vHFcDpySg2AF/1GtjMLJvCj+I9ZgveFnpjriN1HiA3aN/soT0enGp0P2UC+GgRmA0e49PZq0EUa6OEIL5lDuUXhf/fRws+VXur+FSqGRReJKgBSk5Rpl9Y++TrA16F0UnuR1iw9C7CXwiKhllT8qXKDkO5JnkqYCxUmjN+l8FPOcWnuYCPOQ3YXH/ktXjYux2+jLYOH7+y+lc/rLcxlgILbwDHHpsgTPmUYH94HQjoSLI+pMff99mEg/w9uMMnARellk1yQL4dA7nIYTL1sZKDS16+jzeJf9NgMoSzcu
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 02:02:29.9609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc71992-f128-4899-b4d1-08dc3993a6c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747

Add two eswitch attrs: shrdesc_mode and shrdesc_count.
shrdesc_mode: to enable a sharing memory buffer for
representor's rx buffer, and shrdesc_count: to control the
number of buffers in this shared memory pool.

An example use case:
  $ devlink dev eswitch show pci/0000:08:00.0
    pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
    shrdesc-mode none shrdesc-count 0
  $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
    shrdesc-mode basic shrdesc-count 1024
  $ devlink dev eswitch show pci/0000:08:00.0
    pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic \
    shrdesc-mode basic shrdesc-count 1024

Signed-off-by: William Tu <witu@nvidia.com>
---
Discussions:
https://lore.kernel.org/netdev/20240201193050.3b19111b@kernel.org/

Corresponding kernel code:
https://lore.kernel.org/netdev/20240228015954.11981-1-witu@nvidia.com/

v2: feedback from Stephen
- add man page, send to iproute2-next
---
 devlink/devlink.c            | 83 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/devlink.h |  7 +++
 man/man8/devlink-dev.8       | 18 ++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index dbeb6e397e8e..affc29eb7cad 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -53,6 +53,9 @@
 #define ESWITCH_ENCAP_MODE_NONE "none"
 #define ESWITCH_ENCAP_MODE_BASIC "basic"
 
+#define ESWITCH_SHRDESC_MODE_NONE "none"
+#define ESWITCH_SHRDESC_MODE_BASIC "basic"
+
 #define PARAM_CMODE_RUNTIME_STR "runtime"
 #define PARAM_CMODE_DRIVERINIT_STR "driverinit"
 #define PARAM_CMODE_PERMANENT_STR "permanent"
@@ -309,6 +312,8 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_RATE_TX_PRIORITY	BIT(55)
 #define DL_OPT_PORT_FN_RATE_TX_WEIGHT	BIT(56)
 #define DL_OPT_PORT_FN_CAPS	BIT(57)
+#define DL_OPT_ESWITCH_SHRDESC_MODE	BIT(58)
+#define DL_OPT_ESWITCH_SHRDESC_COUNT	BIT(59)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -375,6 +380,8 @@ struct dl_opts {
 	const char *linecard_type;
 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
 	struct nla_bitfield32 port_fn_caps;
+	enum devlink_eswitch_shrdesc_mode eswitch_shrdesc_mode;
+	uint32_t eswitch_shrdesc_count;
 };
 
 struct dl {
@@ -630,6 +637,8 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_ESWITCH_MODE] = MNL_TYPE_U16,
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = MNL_TYPE_U8,
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = MNL_TYPE_U8,
+	[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE] = MNL_TYPE_U8,
+	[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT] = MNL_TYPE_U32,
 	[DEVLINK_ATTR_DPIPE_TABLES] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_DPIPE_TABLE] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = MNL_TYPE_STRING,
@@ -1464,6 +1473,21 @@ eswitch_encap_mode_get(const char *typestr,
 	return 0;
 }
 
+static int
+eswitch_shrdesc_mode_get(const char *typestr,
+			 enum devlink_eswitch_shrdesc_mode *p_shrdesc_mode)
+{
+	if (strcmp(typestr, ESWITCH_SHRDESC_MODE_NONE) == 0) {
+		*p_shrdesc_mode = DEVLINK_ESWITCH_SHRDESC_MODE_NONE;
+	} else if (strcmp(typestr, ESWITCH_SHRDESC_MODE_BASIC) == 0) {
+		*p_shrdesc_mode = DEVLINK_ESWITCH_SHRDESC_MODE_BASIC;
+	} else {
+		pr_err("Unknown eswitch shrdesc mode \"%s\"\n", typestr);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int flash_overwrite_section_get(const char *sectionstr, uint32_t *mask)
 {
 	if (strcmp(sectionstr, "settings") == 0) {
@@ -1672,6 +1696,8 @@ static const struct dl_args_metadata dl_args_required[] = {
 	{DL_OPT_LINECARD,	      "Linecard index expected."},
 	{DL_OPT_LINECARD_TYPE,	      "Linecard type expected."},
 	{DL_OPT_SELFTESTS,            "Test name is expected"},
+	{DL_OPT_ESWITCH_SHRDESC_MODE, "E-Switch shared descriptors option expected."},
+	{DL_OPT_ESWITCH_SHRDESC_COUNT,"E-Switch shared descriptors count expected."},
 };
 
 static int dl_args_finding_required_validate(uint64_t o_required,
@@ -1895,6 +1921,26 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (err)
 				return err;
 			o_found |= DL_OPT_ESWITCH_ENCAP_MODE;
+		} else if ((dl_argv_match(dl, "shrdesc-mode")) &&
+			   (o_all & DL_OPT_ESWITCH_SHRDESC_MODE)) {
+			const char *typestr;
+
+			dl_arg_inc(dl);
+			err = dl_argv_str(dl, &typestr);
+			if (err)
+				return err;
+			err = eswitch_shrdesc_mode_get(typestr,
+						       &opts->eswitch_shrdesc_mode);
+			if (err)
+				return err;
+			o_found |= DL_OPT_ESWITCH_SHRDESC_MODE;
+		} else if (dl_argv_match(dl, "shrdesc-count") &&
+			   (o_all & DL_OPT_ESWITCH_SHRDESC_COUNT)) {
+			dl_arg_inc(dl);
+			err = dl_argv_uint32_t(dl, &opts->eswitch_shrdesc_count);
+			if (err)
+				return err;
+			o_found |= DL_OPT_ESWITCH_SHRDESC_COUNT;
 		} else if (dl_argv_match(dl, "path") &&
 			   (o_all & DL_OPT_RESOURCE_PATH)) {
 			dl_arg_inc(dl);
@@ -2547,6 +2593,12 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 	if (opts->present & DL_OPT_ESWITCH_ENCAP_MODE)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
 				opts->eswitch_encap_mode);
+	if (opts->present & DL_OPT_ESWITCH_SHRDESC_MODE)
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_ESWITCH_SHRDESC_MODE,
+				opts->eswitch_shrdesc_mode);
+	if (opts->present & DL_OPT_ESWITCH_SHRDESC_COUNT)
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT,
+				 opts->eswitch_shrdesc_count);
 	if ((opts->present & DL_OPT_RESOURCE_PATH) && opts->resource_id_valid)
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_ID,
 				 opts->resource_id);
@@ -2707,6 +2759,8 @@ static void cmd_dev_help(void)
 	pr_err("       devlink dev eswitch set DEV [ mode { legacy | switchdev } ]\n");
 	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
 	pr_err("                               [ encap-mode { none | basic } ]\n");
+	pr_err("                               [ shrdesc-mode { none | basic } ]\n");
+	pr_err("                               [ shrdesc-count { VALUE } ]\n");
 	pr_err("       devlink dev eswitch show DEV\n");
 	pr_err("       devlink dev param set DEV name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink dev param show [DEV name PARAMETER]\n");
@@ -3172,6 +3226,18 @@ static const char *eswitch_encap_mode_name(uint32_t mode)
 	}
 }
 
+static const char *eswitch_shrdesc_mode_name(uint8_t mode)
+{
+	switch (mode) {
+	case DEVLINK_ESWITCH_SHRDESC_MODE_NONE:
+		return ESWITCH_SHRDESC_MODE_NONE;
+	case DEVLINK_ESWITCH_SHRDESC_MODE_BASIC:
+		return ESWITCH_SHRDESC_MODE_BASIC;
+	default:
+		return "<unknown mode>";
+	}
+}
+
 static void pr_out_eswitch(struct dl *dl, struct nlattr **tb)
 {
 	__pr_out_handle_start(dl, tb, true, false);
@@ -3194,7 +3260,18 @@ static void pr_out_eswitch(struct dl *dl, struct nlattr **tb)
 			     eswitch_encap_mode_name(mnl_attr_get_u8(
 				    tb[DEVLINK_ATTR_ESWITCH_ENCAP_MODE])));
 	}
-
+	if (tb[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE]) {
+		check_indent_newline(dl);
+		print_string(PRINT_ANY, "shrdesc-mode", "shrdesc-mode %s",
+			     eswitch_shrdesc_mode_name(mnl_attr_get_u8(
+				    tb[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE])));
+	}
+	if (tb[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT]) {
+		check_indent_newline(dl);
+		print_uint(PRINT_ANY, "shrdesc-count", "shrdesc-count %u",
+			   mnl_attr_get_u32(
+				    tb[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT]));
+	}
 	pr_out_handle_end(dl);
 }
 
@@ -3239,7 +3316,9 @@ static int cmd_dev_eswitch_set(struct dl *dl)
 	err = dl_argv_parse(dl, DL_OPT_HANDLE,
 			    DL_OPT_ESWITCH_MODE |
 			    DL_OPT_ESWITCH_INLINE_MODE |
-			    DL_OPT_ESWITCH_ENCAP_MODE);
+			    DL_OPT_ESWITCH_ENCAP_MODE |
+			    DL_OPT_ESWITCH_SHRDESC_MODE |
+			    DL_OPT_ESWITCH_SHRDESC_COUNT);
 	if (err)
 		return err;
 
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e77170199815..494a4b61f917 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -195,6 +195,11 @@ enum devlink_eswitch_encap_mode {
 	DEVLINK_ESWITCH_ENCAP_MODE_BASIC,
 };
 
+enum devlink_eswitch_shrdesc_mode {
+	DEVLINK_ESWITCH_SHRDESC_MODE_NONE,
+	DEVLINK_ESWITCH_SHRDESC_MODE_BASIC,
+};
+
 enum devlink_port_flavour {
 	DEVLINK_PORT_FLAVOUR_PHYSICAL, /* Any kind of a port physically
 					* facing the user.
@@ -614,6 +619,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_ESWITCH_SHRDESC_MODE,      /* u8 */
+	DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT,     /* u32 */
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
index e9d091df48d8..4df055778868 100644
--- a/man/man8/devlink-dev.8
+++ b/man/man8/devlink-dev.8
@@ -34,6 +34,10 @@ devlink-dev \- devlink device configuration
 .BR inline-mode " { " none " | " link " | " network " | " transport " } "
 ] [
 .BR encap-mode " { " none " | " basic " } "
+] [
+.BR shrdesc-mode " { " none " | " basic " } "
+] [
+.BR shrdesc-count " { COUNT } "
 ]
 
 .ti -8
@@ -151,6 +155,20 @@ Set eswitch encapsulation support
 .I basic
 - Enable encapsulation support
 
+.TP
+.BR shrdesc-mode " { " none " | " basic " } "
+Set eswitch shared descriptor support for eswitch representors.
+
+.I none
+- Disable shared descriptor support for eswitch representor's rx ring.
+
+.I basic
+- Enable shared descriptor support for eswitch representor's rx ring.
+
+.TP
+.BR shrdesc-count " COUNT"
+Set the number of entries in shared descriptor pool.
+
 .SS devlink dev param set  - set new value to devlink device configuration parameter
 
 .TP
-- 
2.38.1


