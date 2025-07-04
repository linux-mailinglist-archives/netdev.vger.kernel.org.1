Return-Path: <netdev+bounces-204139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFDAF927A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AB7584845
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325D52D6606;
	Fri,  4 Jul 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rw2aWhMI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8EC2D6404
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632117; cv=fail; b=WOHBLLAqsVcpsnLDE3cHSMQnnIkExnzTFQ9iWQJnG2Ss59c0WJSMyF/mdcwMsGB1XVrAn2sn+sg4VkDAIURIl9Q5MbVWoYcRIW0RV3rd//CxFcFVwLCQriRwHKfiMhHbfs/WVOWVwiRoSdES87IwojxDGOMn2vP3Ogn5GUMJQGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632117; c=relaxed/simple;
	bh=aYEhdDiLc2hA7uPTYbKk8/m6rbfCwNaOeA9MVrnNpvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQuWCDVT/ASMefGPyOp+ikKHm58HsriJq8fxjX10BvI9PL2lJDZ7H8vsYNROPRG9uPqpwNBDQbh1XmW28JjstsjWcW/fK8X8gX+WMHFamPPS4sXwnkFJqGH1L9JsODVkQFdiuGzFoSpwjphPHX60T5pPrWMMwxt9/QxOHJgNTkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rw2aWhMI; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBybEYhhFZ8HYXHx9c2tImrADX3b6LvjXN7iuW6LULgw9K94C5MyaAph9sYOoH4RYcOgdw2DbASJVuGjFDqOkO3hFd1zIoGItzAm1aJfbVea6H7dagM1EsTrUHl3rjtb2LFARMpbBB9oYxb+hDd2dV2z3ejm6jFJbOWpOD1Li5lxTnjwttNNXwLfUZNuFn1CrWUABXh6p5hadyCsePPqzZBDjOdD/NhuDIVcMFnmP2cchCuX5rXR3jptWLWqhPVCTJMBuQcQcMDI/TIOR2oqel3sGJ2c2vadNVKx7sB1yvIVVdPJMCr4Y5WbGyP1QnBxbTsfsEYcpFRlKNFYVUSUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9sud8hQELON0EzAQKCFup5f/NRF4Gafn55pKZzn3tM=;
 b=vnmgFy394vGfeqXblGaCvmHRG/OX7Wx3YW5ns/tNnLB+5ArefcwmIcFs9QNeo+Fl0pMkgWOsYjWWTarmTRbxqfFfYUA3znSCgD1VU9KSMNCayHM726yfyXdEb7GAQjIuRkyfICDLkhCVqAZr0L+poPEUpxrNJqs60EiLKGyoslWCq9jshs/sW7+CEudWtDuzYDkmBcHjgCD5IL+NsZnrBoRiM4sP6DK6vobQC7CIuyd6AWpt6ALKoB2OOfH/F+0UZ8RfQlzGUBER+4fWirDuXR0A0gt8Rfl8UxdCLTwUziIF15xOAKtU2cXKXombOHYO8jVo73dm2JGcKe8KApwz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9sud8hQELON0EzAQKCFup5f/NRF4Gafn55pKZzn3tM=;
 b=rw2aWhMIWPeQyZenELYf8Lo/TATws8dLuwcD3uXxZ0idkowMlVGJ9dqfxY3CZ7FzmuL9tBy8++iLT3vvQaaWGdGr/GQLriX48Bw16/8kt/zMV4vZWcOC00v7JWWvM2k4P3041I2dHlt+03hLae8pp9UrZbnp5ORxri8cbdhkbSDJuKoCik7T9mU/N0x29xpOe8cfbfr4cxnnPQufoERrS7f098+Y8IAJ6QVnuaIxUF/3vb/ux9j404bsivWeL0RKwwdvT5Flq5Oo6mQwDA0i9ov/av4vy9wqTKFh5/x6ZRzG9fVUYP4zjWVsbZfLmFSfc6JMwu+DF0Dc+FOCcanEdw==
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Fri, 4 Jul
 2025 12:28:30 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::dc) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Fri,
 4 Jul 2025 12:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 12:28:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 05:28:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 05:28:29 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 05:28:26 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: <stephen@networkplumber.org>, <dsahern@gmail.com>
CC: Jiri Pirko <jiri@nvidia.com>, <netdev@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH iproute2-next 2/2] Add support for 'tc-bw' attribute in devlink-rate
Date: Fri, 4 Jul 2025 15:27:53 +0300
Message-ID: <20250704122753.845841-3-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250704122753.845841-1-cjubran@nvidia.com>
References: <20250704122753.845841-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c931ac8-a8b6-48d0-baa8-08ddbaf648ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0RKtAnDOrgj+W/0aZAGFLRT/p20pnpS6Jaz1gqHtKDHg4JWUmI6iIra5AD6/?=
 =?us-ascii?Q?Lq9EzNTtwyykVuu8S/LQ9mTZuxkhh79T9QYiyxHb3EIvbOF7Alw3O1Zlkx8p?=
 =?us-ascii?Q?50nsDX4nFbUruevmiBFcg/LA9hH7qHARlMHoFtvzUpyE3/nYWoQHTlYAEjpB?=
 =?us-ascii?Q?yef9cRnGrKs6qBeGnrtdiHzzw02QN4sS4yufWfWUNWHkuxX+GxNi+BNqe+tg?=
 =?us-ascii?Q?ZbhwcW+Dzvia5YjVuxgLkIJO5A+DSybzRA4+t+Yg9LwrOWEF2pjSzrZVlCiB?=
 =?us-ascii?Q?5MLc338UXCZympYEwqWTaYUl/kRJuqbJwNdSph+ngv4b+Nz/x8P5z10u5dQQ?=
 =?us-ascii?Q?V0GoHIKr4jTCzfa13b+l3jhg84AiDENstoI4d3CWCEZV5pqe9KJaIXTFDXMp?=
 =?us-ascii?Q?64DMEo0mHNcrUHsf+Srpr80QwCQerwTxcV3Dx/XIqY8jZZTJo2hqF5dUaW+l?=
 =?us-ascii?Q?O/U4a1Luc8bPlZMRSEwM+QPJD3Guhs3oTaywaQxLNR9xaJpT3ZpvgF3fgM4n?=
 =?us-ascii?Q?P166Ja/gU6mz2+a2mxe8NjkuJ9Yan/p02xdRHX5tQcmpISUzCH/Prq5UhMI/?=
 =?us-ascii?Q?jUM+n0Y7d73cBMryHykCnEmS33F3Y03vJv/MZuFSG0qjBAbZbVjQr5WpC0u4?=
 =?us-ascii?Q?2vwqU4Cw8+5bBGp6CBOVxa6jv7w8egCJeTf6UTxN066VOxM0F1PmrharktGc?=
 =?us-ascii?Q?rNUV2+Z1JiYTJDsRupkMigei6CvI6Jg7Yzvz1L2l0vcNJ2wa852z8xueXD9u?=
 =?us-ascii?Q?TaP/xJbG4dGDLd3bhzk+B1ZQb8yIc65zZKe+qpAtlCoIHJIdq8PnMzjPQ0ha?=
 =?us-ascii?Q?AFaVkuyRiZMMEyg/Ll7SwrShlfUKDi9AVpCIWyxNrmlsm9twg0sYQ+u2cEs6?=
 =?us-ascii?Q?NrXgwlg2iykBbHjI84t7fyd2JWipcLcuXm0dbu9oPFgM0XtZYV/ATUGSEIvp?=
 =?us-ascii?Q?wV1u0Xzse5qKcW2Vv+TfyyARCzdc/JRf8DVwb3JutviFOTOZyX3XuZcaWjac?=
 =?us-ascii?Q?wtmwauYKwJu+ZvwyixJB8U7jYf9gei82ExgyIsVxHUesvccMORA89b2vX1Ts?=
 =?us-ascii?Q?3d2n9CGMRU4sDDC8TbUeqrY3EkKJW7/DxRbVf+CCa4iNVoH2eMbI8HTTWhAa?=
 =?us-ascii?Q?hFD6jz4VzUR3UP0Xsm8DBRbUk/82UXVpePlAwpuZXA0ELuqcwxmCgM1Zckib?=
 =?us-ascii?Q?8lXnapROrYQ6pSvkOR66q6oiPXu7e869fHbn4/E75I2fRidFxM+uhMWvWrH3?=
 =?us-ascii?Q?GMvNpmp097x1a5yjFTLlpcmrxpMRk/yIw3TqmhLN9lo4AdPOH4u/NBqVLc2v?=
 =?us-ascii?Q?bNoeAvNV20ys16N2R0MK7eW4WFrJEwb94lPhmbibge7gR8hEmVWrIYRZIn/R?=
 =?us-ascii?Q?E7+TQcX+7FNk4AFFHttvDr5NJilRVOd7Rzztl1Gec69V1dpnOvtVgAfbXhXv?=
 =?us-ascii?Q?LY+2Yd2xbvwtHbXYZFdPejBvSJSgZ3Q1SatEJLw1Z3RQo5kY3jk25NoXYAW1?=
 =?us-ascii?Q?1BPSujv9+04JYLqkD2uItwQaudfvs3ttBu07?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:28:29.9757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c931ac8-a8b6-48d0-baa8-08ddbaf648ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

Introduce a new attribute 'tc-bw' to devlink-rate, allowing users to
set the bandwidth allocation per traffic class. The new attribute
enables fine-grained QoS configurations by assigning relative bandwidth
shares to each traffic class, supporting more precise traffic shaping,
which helps in achieving more precise bandwidth management across
traffic streams.

Add support for configuring 'tc-bw' via the devlink userspace utility
and parse the 'tc-bw' arguments for accurate bandwidth assignment per
traffic class.

This feature supports 8 traffic classes as defined by the IEEE 802.1Qaz
standard.

Example commands:
- devlink port function rate add pci/0000:08:00.0/group \
  tx_share 10Gbit tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

- devlink port function rate set pci/0000:08:00.0/group \
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c       | 191 ++++++++++++++++++++++++++++++++++++++--
 man/man8/devlink-rate.8 |  14 +++
 2 files changed, 199 insertions(+), 6 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d14f3f45..fe0c3640 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -310,6 +310,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_RATE_TX_WEIGHT	BIT(56)
 #define DL_OPT_PORT_FN_CAPS	BIT(57)
 #define DL_OPT_PORT_FN_MAX_IO_EQS	BIT(58)
+#define DL_OPT_PORT_FN_RATE_TC_BWS	BIT(59)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -372,6 +373,7 @@ struct dl_opts {
 	uint32_t rate_tx_weight;
 	char *rate_node_name;
 	const char *rate_parent_node;
+	uint32_t rate_tc_bw[DEVLINK_RATE_TCS_MAX];
 	uint32_t linecard_index;
 	const char *linecard_type;
 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
@@ -1699,6 +1701,84 @@ static int dl_args_finding_required_validate(uint64_t o_required,
 	return err;
 }
 
+static int
+parse_tc_bw_arg(const char *tc_bw_str, int *tc_index, uint32_t *tc_bw)
+{
+	char *index, *value, *endptr;
+	char *input = NULL;
+	int err;
+
+	input = strdup(tc_bw_str);
+	if (!input)
+		return -ENOMEM;
+
+	err = str_split_by_char(input, &index, &value, ':');
+	if (err) {
+		pr_err("Invalid format in token: %s\n", input);
+		goto out;
+	}
+
+	*tc_index = strtoul(index, &endptr, 10);
+	if (endptr && *endptr) {
+		pr_err("Invalid traffic class index: %s\n", index);
+		err = -EINVAL;
+		goto out;
+	}
+
+	*tc_bw = strtoul(value, &endptr, 10);
+	if (endptr && *endptr) {
+		pr_err("Invalid bandwidth value: %s\n", value);
+		err = -EINVAL;
+		goto out;
+	}
+
+out:
+	free(input);
+	return err;
+}
+
+static int parse_tc_bw_args(struct dl *dl, uint32_t *tc_bw)
+{
+	bool parsed_indices[DEVLINK_RATE_TCS_MAX] = {};
+	const char *tc_bw_str;
+	int index, err, i;
+	uint32_t bw;
+
+	memset(tc_bw, 0, sizeof(uint32_t) * DEVLINK_RATE_TCS_MAX);
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		err = dl_argv_str(dl, &tc_bw_str);
+		if (err) {
+			fprintf(stderr,
+				"Error parsing tc-bw: example usage: tc-bw 0:60 1:10 2:0 3:0 4:30 5:0 6:0 7:0\n");
+			return err;
+		}
+
+		err = parse_tc_bw_arg(tc_bw_str, &index, &bw);
+		if (err)
+			return err;
+
+		if (index < 0 || index >= DEVLINK_RATE_TCS_MAX) {
+			fprintf(stderr,
+				"Error parsing tc-bw: invalid index: %d, use values between 0 and %d\n",
+				index, DEVLINK_RATE_TC_INDEX_MAX);
+			return -EINVAL;
+		}
+
+		if (parsed_indices[index]) {
+			fprintf(stderr,
+				"Error parsing tc-bw: duplicate index : %d\n",
+				index);
+			return -EINVAL;
+		}
+
+		tc_bw[index] = bw;
+		parsed_indices[index] = true;
+	}
+
+	return 0;
+}
+
 static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			 uint64_t o_optional)
 {
@@ -2237,6 +2317,13 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			dl_arg_inc(dl);
 			opts->rate_parent_node = "";
 			o_found |= DL_OPT_PORT_FN_RATE_PARENT;
+		} else if (dl_argv_match(dl, "tc-bw") &&
+			   (o_all & DL_OPT_PORT_FN_RATE_TC_BWS)) {
+			dl_arg_inc(dl);
+			err = parse_tc_bw_args(dl, opts->rate_tc_bw);
+			if (err)
+				return err;
+			o_found |= DL_OPT_PORT_FN_RATE_TC_BWS;
 		} else if (dl_argv_match(dl, "lc") &&
 			   (o_all & DL_OPT_LINECARD)) {
 			dl_arg_inc(dl);
@@ -2678,6 +2765,20 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 	if (opts->present & DL_OPT_PORT_FN_RATE_PARENT)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
 				  opts->rate_parent_node);
+	if (opts->present & DL_OPT_PORT_FN_RATE_TC_BWS) {
+		struct nlattr *nla_tc_bw_entry;
+		int i;
+
+		for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+			nla_tc_bw_entry =
+				mnl_attr_nest_start(nlh,
+						    DEVLINK_ATTR_RATE_TC_BWS);
+			mnl_attr_put_u8(nlh, DEVLINK_ATTR_RATE_TC_INDEX, i);
+			mnl_attr_put_u32(nlh, DEVLINK_ATTR_RATE_TC_BW,
+					 opts->rate_tc_bw[i]);
+			mnl_attr_nest_end(nlh, nla_tc_bw_entry);
+		}
+	}
 	if (opts->present & DL_OPT_LINECARD)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_LINECARD_INDEX,
 				 opts->linecard_index);
@@ -5366,7 +5467,55 @@ static char *port_rate_type_name(uint16_t type)
 	}
 }
 
-static void pr_out_port_fn_rate(struct dl *dl, struct nlattr **tb)
+static int
+parse_rate_tc_bw(struct nlattr *nla_tc_bw, uint8_t *tc_index, uint32_t *tc_bw)
+{
+	struct nlattr *tb_tc_bw[DEVLINK_ATTR_MAX + 1] = {};
+
+	if (mnl_attr_parse_nested(nla_tc_bw, attr_cb, tb_tc_bw) != MNL_CB_OK)
+		return MNL_CB_ERROR;
+
+	if (!tb_tc_bw[DEVLINK_ATTR_RATE_TC_INDEX] ||
+	    !tb_tc_bw[DEVLINK_ATTR_RATE_TC_BW])
+		return MNL_CB_ERROR;
+
+	*tc_index = mnl_attr_get_u8(tb_tc_bw[DEVLINK_ATTR_RATE_TC_INDEX]);
+	*tc_bw = mnl_attr_get_u32(tb_tc_bw[DEVLINK_ATTR_RATE_TC_BW]);
+
+	return MNL_CB_OK;
+}
+
+static void pr_out_port_fn_rate_tc_bw(struct dl *dl, const struct nlmsghdr *nlh)
+{
+	struct nlattr *nla_tc_bw;
+
+	mnl_attr_for_each(nla_tc_bw, nlh, sizeof(struct genlmsghdr)) {
+		uint8_t tc_index;
+		uint32_t tc_bw;
+
+		if (mnl_attr_get_type(nla_tc_bw) != DEVLINK_ATTR_RATE_TC_BWS)
+			continue;
+
+		if (parse_rate_tc_bw(nla_tc_bw, &tc_index, &tc_bw) != MNL_CB_OK)
+			continue;
+
+		if (tc_bw) {
+			char buf[32];
+
+			if (dl->json_output) {
+				snprintf(buf, sizeof(buf), "tc_%u", tc_index);
+				print_uint(PRINT_JSON, buf, "%u", tc_bw);
+			} else {
+				snprintf(buf, sizeof(buf), " tc_%u bw %u",
+					 tc_index, tc_bw);
+				print_string(PRINT_ANY, NULL, "%s", buf);
+			}
+		}
+	}
+}
+
+static void pr_out_port_fn_rate(struct dl *dl, const struct nlmsghdr *nlh,
+				struct nlattr **tb)
 {
 
 	if (!tb[DEVLINK_ATTR_RATE_NODE_NAME])
@@ -5412,6 +5561,7 @@ static void pr_out_port_fn_rate(struct dl *dl, struct nlattr **tb)
 			print_uint(PRINT_ANY, "tx_weight",
 				   " tx_weight %u", weight);
 	}
+
 	if (tb[DEVLINK_ATTR_RATE_PARENT_NODE_NAME]) {
 		const char *parent =
 			mnl_attr_get_str(tb[DEVLINK_ATTR_RATE_PARENT_NODE_NAME]);
@@ -5419,6 +5569,9 @@ static void pr_out_port_fn_rate(struct dl *dl, struct nlattr **tb)
 		print_string(PRINT_ANY, "parent", " parent %s", parent);
 	}
 
+	if (tb[DEVLINK_ATTR_RATE_TC_BWS])
+		pr_out_port_fn_rate_tc_bw(dl, nlh);
+
 	pr_out_port_handle_end(dl);
 }
 
@@ -5434,7 +5587,7 @@ static int cmd_port_fn_rate_show_cb(const struct nlmsghdr *nlh, void *data)
 	    !tb[DEVLINK_ATTR_RATE_NODE_NAME]) {
 		return MNL_CB_ERROR;
 	}
-	pr_out_port_fn_rate(dl, tb);
+	pr_out_port_fn_rate(dl, nlh, tb);
 	return MNL_CB_OK;
 }
 
@@ -5443,12 +5596,13 @@ static void cmd_port_fn_rate_help(void)
 	pr_err("Usage: devlink port function rate help\n");
 	pr_err("       devlink port function rate show [ DEV/{ PORT_INDEX | NODE_NAME } ]\n");
 	pr_err("       devlink port function rate add DEV/NODE_NAME\n");
-	pr_err("               [ tx_share VAL ][ tx_max VAL ][ tx_priority N ][ tx_weight N ][ { parent NODE_NAME | noparent } ]\n");
+	pr_err("               [ tx_share VAL ][ tx_max VAL ][ tx_priority N ][ tx_weight N ][ tc-bw INDEX:N ... INDEX:N ][ { parent NODE_NAME | noparent } ]\n");
 	pr_err("       devlink port function rate del DEV/NODE_NAME\n");
 	pr_err("       devlink port function rate set DEV/{ PORT_INDEX | NODE_NAME }\n");
-	pr_err("               [ tx_share VAL ][ tx_max VAL ][ tx_priority N ][ tx_weight N ][ { parent NODE_NAME | noparent } ]\n\n");
+	pr_err("               [ tx_share VAL ][ tx_max VAL ][ tx_priority N ][ tx_weight N ][ tc-bw INDEX:N ... INDEX:N ][ { parent NODE_NAME | noparent } ]\n\n");
 	pr_err("       VAL - float or integer value in units of bits or bytes per second (bit|bps)\n");
 	pr_err("       N - integer representing priority/weight of the node among siblings\n");
+	pr_err("       INDEX - integer representing traffic class index in the tc-bw option, ranging from 0 to 7\n");
 	pr_err("       and SI (k-, m-, g-, t-) or IEC (ki-, mi-, gi-, ti-) case-insensitive prefix.\n");
 	pr_err("       Bare number, means bits per second, is possible.\n\n");
 	pr_err("       For details refer to devlink-rate(8) man page.\n");
@@ -5503,7 +5657,8 @@ static int cmd_port_fn_rate_add(struct dl *dl)
 			    DL_OPT_PORT_FN_RATE_TX_SHARE | DL_OPT_PORT_FN_RATE_TX_MAX |
 			    DL_OPT_PORT_FN_RATE_TX_PRIORITY |
 			    DL_OPT_PORT_FN_RATE_TX_WEIGHT |
-			    DL_OPT_PORT_FN_RATE_PARENT);
+			    DL_OPT_PORT_FN_RATE_PARENT |
+			    DL_OPT_PORT_FN_RATE_TC_BWS);
 	if (err)
 		return err;
 
@@ -5538,6 +5693,25 @@ static int cmd_port_fn_rate_del(struct dl *dl)
 	return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
 }
 
+static void parse_tc_bw_entries(const struct nlmsghdr *nlh,
+				struct dl_opts *opts)
+{
+	struct nlattr *nla_tc_bw;
+
+	mnl_attr_for_each(nla_tc_bw, nlh, sizeof(struct genlmsghdr)) {
+		uint8_t tc_index;
+		uint32_t tc_bw;
+
+		if (mnl_attr_get_type(nla_tc_bw) != DEVLINK_ATTR_RATE_TC_BWS)
+			continue;
+
+		if (parse_rate_tc_bw(nla_tc_bw, &tc_index, &tc_bw) != MNL_CB_OK)
+			continue;
+
+		opts->rate_tc_bw[tc_index] = tc_bw;
+	}
+}
+
 static int port_fn_get_rates_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct dl_opts *opts = data;
@@ -5563,6 +5737,10 @@ static int port_fn_get_rates_cb(const struct nlmsghdr *nlh, void *data)
 	if (tb[DEVLINK_ATTR_RATE_TX_WEIGHT])
 		opts->rate_tx_weight =
 			mnl_attr_get_u32(tb[DEVLINK_ATTR_RATE_TX_WEIGHT]);
+
+	if (tb[DEVLINK_ATTR_RATE_TC_BWS])
+		parse_tc_bw_entries(nlh, opts);
+
 	return MNL_CB_OK;
 }
 
@@ -5578,7 +5756,8 @@ static int cmd_port_fn_rate_set(struct dl *dl)
 				DL_OPT_PORT_FN_RATE_TX_MAX |
 				DL_OPT_PORT_FN_RATE_TX_PRIORITY |
 				DL_OPT_PORT_FN_RATE_TX_WEIGHT |
-				DL_OPT_PORT_FN_RATE_PARENT);
+				DL_OPT_PORT_FN_RATE_PARENT |
+				DL_OPT_PORT_FN_RATE_TC_BWS);
 	if (err)
 		return err;
 
diff --git a/man/man8/devlink-rate.8 b/man/man8/devlink-rate.8
index f09ac4ac..47e2ebc5 100644
--- a/man/man8/devlink-rate.8
+++ b/man/man8/devlink-rate.8
@@ -28,6 +28,7 @@ devlink-rate \- devlink rate management
 .RB [ " tx_max \fIVALUE " ]
 .RB [ " tx_priority \fIN " ]
 .RB [ " tx_weight \fIN " ]
+.RB [ " tc-bw \fIINDEX:N " ]
 .RB "[ {" " parent \fINODE_NAME " | " noparent " "} ]"
 
 .ti -8
@@ -36,6 +37,7 @@ devlink-rate \- devlink rate management
 .RB [ " tx_max \fIVALUE " ]
 .RB [ " tx_priority \fIN " ]
 .RB [ " tx_weight \fIN " ]
+.RB [ " tc-bw \fIINDEX:N " ]
 .RB "[ {" " parent \fINODE_NAME " | " noparent " "} ]"
 
 .ti -8
@@ -101,6 +103,12 @@ As a node is configured with a higher rate it gets more BW relative to it's
 siblings. Values are relative like a percentage points, they basically tell
 how much BW should node take relative to it's siblings.
 .PP
+.BI tc-bw " INDEX:N"
+- allows the user to assign relative bandwidth shares to specific traffic
+classes using the IEEE 802.1Qaz standard. The values determine how bandwidth
+is distributed between traffic classes in proportion to one another.
+If not specified, the default bandwidth allocation is applied.
+.PP
 .TP 8
 .I VALUE
 These parameter accept a floating point number, possibly followed by either a
@@ -142,6 +150,12 @@ To specify in IEC units, replace the SI prefix (k-, m-, g-, t-) with IEC prefix
 .RE
 .PP
 .TP 8
+.I INDEX
+These parameters represent the traffic class index in the \fItc-bw\fR option.
+The traffic class is specified as an integer value, ranging from 0 to 7, which
+maps to the defined traffic classes under the IEEE 802.1Qaz standard.
+.PP
+.TP 8
 .I N
 These parameter accept integer meaning weight or priority of a node.
 .PP
-- 
2.38.1


