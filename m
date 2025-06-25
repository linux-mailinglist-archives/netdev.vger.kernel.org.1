Return-Path: <netdev+bounces-201281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8554AE8C55
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0BA189D43D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841C2D5439;
	Wed, 25 Jun 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fxss6MTr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292942D5415
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875970; cv=fail; b=lYCrIyeelA02BNIBaeMsXsGvIyeqQJTrlwPyQQirpLQu2hc8cSNDh8bZGORYGqKi/P0dotjEmTI2nrRKLQeKhLIYJoLJCQ2r9jYIXNpg7dgvLWnRZd1c5QoaXvU5ETDTF8o37/kpDQf5Yov1FRsenjJ8khhjPYbCqbWvxHLjohw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875970; c=relaxed/simple;
	bh=RTU0LVY6s6Pa2LvKVG3vhZ4V2E6m6gqWBWbp7WlOtnI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qv9ouI5binBhiFTt43yD5raEGI/MEnR3XyI2W+VYCNLgSnZOuW3KN33/BfReTTqQD1HsCqLtephRZl936zNRjMG74qaFKlRjXQT+9qpnj1ZMX4Igeyxy2yAwp3tg4122bpB88VAA8jzbMine0i7YSBd0glrq+Ho7U2wj88bxXxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fxss6MTr; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw8rFrIq2hi++/bRNdIjsMtFGqe8KwS9UyAI78rMx82eQrPM03H1gdYtQpp8tYtMjvRQ3JGzUoXAQ0glYSoZeV4VoZqhVLZi9TOvOFN3Xh+z3biCyMsxJQd4YdKgqn4DtRtoF8BakKFKnGR/+zJ83XnnT5FMytYOgDOfhXHp/hh4PqsiWKuSJcwxX/XSM5Gc20qvgDYFIifM4+b1AZOQPv+xLMOnpImc6XdpGBXwnBSHCuGbRSKA+C5NUqyH3J/Hc6GHjd/pLniHGpUcNIg1aKAo0yc3jEZz6WkIyGI6azM0qApROqnrs0iKJ4z+stIeVhrXVj6scK9ulwg41ZEffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS0a1tdUEHV3TySqKZWEhx17P4MhJueYakQJNMXjOv8=;
 b=Yci/3zgYPAN44dQi3m499euLWGcnCNG0sTKfUKBdXxoFObbF/ZY6Kk2ouqeLgRUxQtQeqnIEsu538KkxGhWnBKRLRZerMMza3LgKVwy2yW/J+z7Mva7YssJ1Eo5gY2gvrPGO9XzLXpC1ccWqxw27OIbo4RvxPNK6hxv9SV5dm/PZgcxS8FTbTQkGG/JbhJnfnJqehGc/IXVt2w0i0WuSFt1WcC9fdVdGIja3+TYP0KiVFqJ3UC8ZLDDm9Q/pAv/ErpCzWGak9hneY6SDYlW8B1JUK6Kbx+ME6ckZqGYe1u3SaREC0Q6SVN/3vCB4nuKJRNHV2AiaAtOweTshrcOBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS0a1tdUEHV3TySqKZWEhx17P4MhJueYakQJNMXjOv8=;
 b=fxss6MTrVzHWadcMO+fRu3v6ml4C6rJlvthExlF7/JckNrwoGafhPdwTmBrDWthrhuGwuL/9r5pSFHOi2hxfyEe+dZoqLQOrt+/RgGI3qjnyt5i8h/nWPmS9zckInbXM+FV03SKVuSGEzxP96YpDFoqizAiysf8Sg9dg5S6dgE4635fahcYVP97xov6z1Dvh9RDYnE/cOAnMLMOO4E2vX0BK6MCU0SWKHZvkVEzKC2P3yG+HO3zS/BN2ncpdd1opYeImmL+lu9+vHYeih5qtRknCW4UJnCgwyGKLrmPvrIPiWlmE8wiias1P2oZGywx5X1OQHHpm1T/MiBJGR92uzw==
Received: from BYAPR02CA0019.namprd02.prod.outlook.com (2603:10b6:a02:ee::32)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::997) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 25 Jun
 2025 18:26:01 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::d8) by BYAPR02CA0019.outlook.office365.com
 (2603:10b6:a02:ee::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Wed,
 25 Jun 2025 18:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:26:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:25:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 25 Jun 2025 11:25:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 11:25:47 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [RFC PATCH iproute2-next] devlink: Add support for 'tc-bw' attribute in devlink-rate
Date: Wed, 25 Jun 2025 21:25:45 +0300
Message-ID: <20250625182545.86994-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 16210c40-5bad-4e39-8153-08ddb415bcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eV9bLaF0Kz4bPAl+xNqCh7CiVNwedemuw2ekPWH2+ddgT+JVPuDTHV3eI50n?=
 =?us-ascii?Q?JXjFrBgtbOxL86bNF4njoVnwH1O7oT5snMW1ZeqS18us9AFiboW2ap53iLye?=
 =?us-ascii?Q?IFbewqTu51H+aaBCZue5DQUCkEZmSK91zztCOPhItqxTHCadMerhpJ/cw5o7?=
 =?us-ascii?Q?F7b4IcDWQRWIaR8mC02GSnGhQuDVQpofaR0oW4YTQRwG0a7DRUxN8/Ee2Iof?=
 =?us-ascii?Q?Q+sGHP9ELWneDgbhBauXQF2OyNTK2jDpr+9ihT5/Roh07rJLlz66P73Ea2Je?=
 =?us-ascii?Q?hNolEVIwiVT5nQ4wfmceP8Ww5+hnJcslcAwI/z2kcvsMM2HdiWU/3ZmwzHai?=
 =?us-ascii?Q?GnJFzWZqO+2fCiQ4TssLsvCRDcNzHRQIV61Q7Y053MoX1oNFfxK0yrA7Cd+9?=
 =?us-ascii?Q?vW2788PFDDf2FlkdrVFfJ//EVfBXG4ZwpMiBo6OPxC59d9csrwiWdh6OdG+r?=
 =?us-ascii?Q?kmSzX2dgPRbh0BzE/9FQYITX+yVzPXfN5etMim8ptcBk4EPJpDXtVbZhJvHq?=
 =?us-ascii?Q?3UYuHkMUv84xnuCQlS0Hcx8nKJqqi3wt3F7wwkt9e/QpMIExDcy/9YSNGvMg?=
 =?us-ascii?Q?qpMJmpD0PYYRHmlCKjwvKqpRb69ggUNtW5ojDFkoQMnK4nv7WkBkJ9MccF7T?=
 =?us-ascii?Q?EnlfGtDvQKAJ79l6xIv64KZ9YikHhgbWwUA5qHbFRONOQ04oqEnHysWsa6Xy?=
 =?us-ascii?Q?Z11wKyY6+jeUNYlkixL2dxKMwL6fttMf2qenbMqi0BqMjnve5hPQuK5m3Aqf?=
 =?us-ascii?Q?p2RKBN3ZT17iiH2TUcEeilslppHZEKkM0dSVOCcWmUW3Cyvf+1Bubb/U8tLq?=
 =?us-ascii?Q?9VfFE3PBVNTb6V0jKJpOfbNoeqY+kyI+7QIigAoTJUiyvp00hDItfKCE4NH1?=
 =?us-ascii?Q?LsOQh2mZXeS1zL9g1UWzeYBtihzzAedRJtDQZ3807w2cSHICglkzB4yVmPzv?=
 =?us-ascii?Q?QdiU98ccY8RCc7XqFwNQplyaXcw2YYsZDalMl5zDWJjcLV0CSHUbsKYIL0xI?=
 =?us-ascii?Q?ZfS9EEcrbUsz8Yf7NqjUo98HspcUfPGF0bvUE/nK6w27SlJlOewMGHDV24av?=
 =?us-ascii?Q?oV3ma8VgCsaWKJks/wMePQUn1pccduH9oFdlij117Z14xPqlvRk5RlRPS8f9?=
 =?us-ascii?Q?psaRN51MRIenwW1EPW33w86dBVJ+ch2BNbrvABHU0d3kg5t0Y95PQtiBAGdl?=
 =?us-ascii?Q?EUbkkT2oVZvPQj0sY+s+aXqQvXq/t19EJ9GhkIwTEF6MHps+faOqNtF4wzTx?=
 =?us-ascii?Q?j6CuAtJZ5cjrRgmFVSujWxx0pfnjM7XZt5P1en5b2vzrwaWdB9vnBS7wtMik?=
 =?us-ascii?Q?j1E8+zJpNc4aJEG1k4U4RYHN0MnA6Rj/rgKa3HRjMDe1dQ2joLu2WnNUK30u?=
 =?us-ascii?Q?04yDwWjXn7JNw4PMjlbFigvWADiPdYoa+7fYWiJxB9raiAu6Ey9R6FmfXIDO?=
 =?us-ascii?Q?Gjtoh7GGBbOv3E4b8JI5z4p740vVj5MtB6stGBB8DPoSqf3ABGLxLn0+nHaI?=
 =?us-ascii?Q?0oMeLPSGPuZ1JKdeYWTU2tMFOMNMa8UrkjX92NGDJMJED4rpQwzdQpmJog?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:26:00.9156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16210c40-5bad-4e39-8153-08ddb415bcb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4

From: Carolina Jubran <cjubran@nvidia.com>

Introduce a new attribute 'tc-bw' to devlink-rate, allowing users to set
the bandwidth allocation per traffic class. The new attribute enables
fine-grained QoS configurations by assigning relative bandwidth shares
to each traffic class, supporting more precise traffic shaping, which
helps in achieving more precise bandwidth management across traffic
streams.

Add support for configuring 'tc-bw' via the devlink userspace utility
and parse the 'tc-bw' arguments for accurate bandwidth assignment per
traffic class.

This feature supports 8 traffic classes as defined by the IEEE 802.1Qaz
standard.

Example commands:
$ devlink port function rate add pci/0000:08:00.0/group \
  tx_share 10Gbit tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

$ devlink port function rate set pci/0000:08:00.0/group \
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---

Per Jakub's request[0] this is the iproute2 patch for the rate
management support series. Support for this is added in v11.

I've incldued the header file changes in this patch for ease of use.

[0] - https://lore.kernel.org/netdev/20250521152431.56a77580@kernel.org/

 devlink/devlink.c            | 191 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/devlink.h |   9 ++
 man/man8/devlink-rate.8      |  14 +++
 3 files changed, 208 insertions(+), 6 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d14f3f45..75ade8bf 100644
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
+			 } else {
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
 
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9a1bdc94..78f505c1 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -221,6 +221,11 @@ enum devlink_port_flavour {
 				      */
 };
 
+/* IEEE 802.1Qaz standard supported values. */
+
+#define DEVLINK_RATE_TCS_MAX 8
+#define DEVLINK_RATE_TC_INDEX_MAX (DEVLINK_RATE_TCS_MAX - 1)
+
 enum devlink_rate_type {
 	DEVLINK_RATE_TYPE_LEAF,
 	DEVLINK_RATE_TYPE_NODE,
@@ -629,6 +634,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
+	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
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
2.34.1


