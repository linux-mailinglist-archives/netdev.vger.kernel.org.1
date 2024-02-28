Return-Path: <netdev+bounces-75793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9886B320
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F68C286BB6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188315B97D;
	Wed, 28 Feb 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZwW22/py"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB115B97C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133987; cv=fail; b=VfIrarU6W2xbMaqV1KanPat1I5uSI1JaZkuvY/iGXWz5tqF1lOGhwBgPbVyIie05J0RUNjqqLATK0grhenrrSNJTbbgW4Dz8Nh4obA78/Hk88znzhpmvTvB6hGSOgrnksoqAdjGp+LcerNRyKNXc3EamfHfsG8TnpW5+hZ2ZRns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133987; c=relaxed/simple;
	bh=AXqHRmgItTtUVqd23TYVrTwicvjLRjmJWGviwhYsufY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNaBxk3P1HG0lnrzSZIBvHnyIYcZDOK9Mg6CX4vF+iOtZUcaodsJ0LVjWsnmTv82KI00bImdNhpZKRRRD/Qah8lv1SX1wpZIEA1tHRNe5HBuH8m/bzfi5683N1x9bNqg4It7C3JYt+E32xOQHRWEJNSzmqhdUUx6SMLlYMuLt7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZwW22/py; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVq7bt9LDyQETLWe/LfYh2QI8HTtettitbzu1j84vR0BIFI0bsKteTCV7BP0Dv0GNBt0K+TFaou6dUTWeAMtPemtdorQTYH4Q8Jm8vQf7AMKeVaCEF12PwSVixBYSy9wuMkscOcR9C6lMTA3Dfi3ewwKd+P/pkJbd3HpbfXNpQ3rU30uLD7pxfQAFmPDw6SP+1Rw8as9YXXTJyYkKB1Zet6fQlmDK1EyqaRrZh4GROCcd/fDb1XeajVxz/Wk7OL2CQgH3PgwPPI7Th+T57olpvj1AuaNKvMI+j+GhoNJM2zQilpiqd++f0dZh9aEEVUcC/8dVxlKNWUazuOHklkOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Vm3hTK4W9MkoGoIFJar5Yw1xKfcMqcbfWi5Omko+sc=;
 b=R1QJQ4ligvVb6zJ9IRc9FBkK4i9oqvQpOXILaMD3sMzu3scfTT4tZhPLpjc4/QZJuzIscSVMQS5HzBe7+kD2Ex1EnKlep4l7yiCB+URyPt2X41GnxhOCxI93EcJAbxP9F75LYA37JEezDK1dqIpNmJIVXx/JrockViys8ithbk6GwcSyZR8PLEdLNg6NVCpW7MaL0c4EjJDYTBmvumCtGpt8NrbXFLs+LqVlp6EMFlTX3wp3Do1ZHbz0e8o9P4xzYG1UblnuVRzGIMJKBC0ZaWVmjHgXmtbSns/pYShv1Hq98DcDmyaQqHZoLfc72ES9ewsbuHGK1qcseHVtdUg4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vm3hTK4W9MkoGoIFJar5Yw1xKfcMqcbfWi5Omko+sc=;
 b=ZwW22/pyIPA+F4gD6KcojzGkA2O/QOSg2kiGxAAxuO8t6JZcS8qon3yYBaLBtmxMA7x5i2Um02kyPPfxMFrEl8AGBdldrkt3Zptlk+Z7xh9f7nuybjBOTSRv+3arTLRh9h7NHjxHMzn75SxJU6FKHgeFdqpXZbOGumKTa+hCkOwH3P3/Wrmx88BGmMpHDt5o1D72YjY2c2/J6DgrI3eAMnvbXSx/iI5qSuki1cpGGvzsR5HPEjlfSrMCqzFMyrbfHNMoco9bXcDQjedAKW/VtIn8U2DArFNMqIH9tDIReWgrBh0myPBQ7TngqxDRyPePdAidOeAlq80CXdPGOpr+gA==
Received: from DM6PR18CA0028.namprd18.prod.outlook.com (2603:10b6:5:15b::41)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 15:26:17 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::40) by DM6PR18CA0028.outlook.office365.com
 (2603:10b6:5:15b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 15:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 15:26:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 07:26:05 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 07:26:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Wed, 28
 Feb 2024 07:26:03 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH RFC iproute2] devlink: Add eswitch attr option for shared descriptors
Date: Wed, 28 Feb 2024 17:25:48 +0200
Message-ID: <20240228152548.16690-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7089f4-9f5e-430d-047d-08dc38719bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wjMV/wi+sBdUDdzG/yUSERFeBQ1yNGtXM/s2SzFJNxiuTpolPNhlapAEQd6U+Qtte4Mwt4LxXiARcL+UzDjA/DWR909clYUInbIoRbEpXOP1quCrT2GRug5VdsHWONj2JKpAs37rEd5sibD8qydTWG9cQw7d6deh1GW1yIrM0brc/NZ2wBiv06BybLYaeDmXxAzZJqwz/lAExHmes9C4CisIQ9evI3lKXr05a4ULY0w0OwfITaEZ6+mhW+rmcacplKkCSL5VKbwsaJCcCJhc3suIolDk81EnZtOO0ow6s/ch3qRVG0MTHWSY9ohN+NfmXy0LRPtVd91eiiDPK5WhZxXVV+1NCyDNcoaL/V97/EvsqAFGrGrkMup9JOuMq3+j5KbC4g8wfZtH5eSSuS/7utF3EGyt/fDdCzdlBhV1gwHfahsxckbCWeWS5oS4z/UN6FvZ4fyP15OktOFFKxx0GK+gbZlTZlCQn3L9OfUaa5n6vQijYLXUws+INab/IuiHWYAflemqx4B18bIhgL/tAwE1zo5RDhPe+exbwHM5J+8K5ugBXFo5SNMbFqq3qYUEREkqq7+TQVhx+2PMv+bEYuYooR0dRY3ufWDoj51SgyKzn23eZuZVxCrDP542iOxdR9wTRn1Ov9xaOSHlOxu18PrgoQQqOlW6qxOOnhw6Jlv/6GXxV72oUvrvCoiKe1bcUy0QyyI5D/s9HO0MV6+hWEDtMmEyxHjd+Wn+e3btBMHQ1JSwgpipl80IYB6vBPA8bVHEKcErnI8tG6eEuPrecIofD9dTUH1aKqNfbvIrhe8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 15:26:17.3969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7089f4-9f5e-430d-047d-08dc38719bcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
Corresponding kernel code:
https://lore.kernel.org/netdev/20240228015954.11981-1-witu@nvidia.com/
---
 devlink/devlink.c            | 83 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/devlink.h |  7 +++
 2 files changed, 88 insertions(+), 2 deletions(-)

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
-- 
2.38.1


