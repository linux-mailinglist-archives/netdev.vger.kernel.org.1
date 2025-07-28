Return-Path: <netdev+bounces-210562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3EDB13F1D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377A8179C37
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547082676F4;
	Mon, 28 Jul 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E15xalf2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094726F443
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717544; cv=fail; b=Zb1nOzzkdqh1Saey2xJEgQ2IZQBvEWGOAayBbkYvxc04cP1JPVX9o8ncZt3uth1iEd2tXz/tzZvjW1s4Hw220Ep2GPFVboFO+DnPK4dgL+oYA0Mitn0WzoJnhGzuuAEA25QCIisRr2eSdMw7vbSOZXBENq5VmnuAGz+vMluysbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717544; c=relaxed/simple;
	bh=nH4uFL/0tkj+D0BUqxpkBQCu9ZWJaoU85JYdf3kBSzI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQ3uvHrkgTvYiFa1g3vMEfqlGFmOavtyXcC2ZFWVhz+XeiA9l7yXyuuVV57wHyR3PcMMqV8I+crXPQp1NzLKkfYAqQj0ARQgalvGkde5zKuhA/6as2OkijzJ+ny3soxZgBiUXwW3JEgQXbcdym/VsjXphYK/WE0Mh+ZZ+piGwTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E15xalf2; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCy1Rl1ckh0cIIwNa/T3MppXhNr813dTg9wllmKkqMVi6W8FBGiIGJFCR9hpHOKWwPa9mJxg0QF/dsDGjHHqnfvI95fQZKT3X25T4LYUPIa29VnVePl7TjXXjieWDdGXjzF4EY83DHIbBMCLNYJ9YyeShY6ZYw/ThA1uNmaImHjOEl1jjpHntZyZdduEsQGwHMsr1R3stvs4HhwM2isjDnnwxznhiu/0agOubfvK7/hBs7xIcX3nibRQU0jFjVMIBG3y5hfN7cwqd1oRD6mVmhODrbKqYR9pXGXwUIWT809l1SNk7Z952XP4rC+ECy/2KMJVWJ/I0GV6nYAwxdCk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UjxySf0Aa9Qsdwzei1Gi1Td7iskSA8Ed17jOYpCqpc=;
 b=Gmz2hSpDaPX7+UErHC2/cjb1Zpj0LHjECPugul2LzCpcu4n3rdJr80HXuTVf79i55nIvjxnw+UCEvgf6AqwYWCLJcMe/aEA+q3GrNB1dLtPxmrVzI1f7E2C8gLGpsvdVTV2zF2av4HPTyNamQ2deK2dVIfrZ3ul7drTeyoAzQO2Ql6r/7QUQOHBrMpXpNZVZhNZKMagtSOyUZ/3YSDVlCmhWXn82ihh8B09XqhpVljcdNW85dWz5P2iCyTvnmMhCom/rQdBt4rj6U3TLOqZptqthrCq2aSTKM96vOHPgq7wJNKE5EHxlSyY1ip941oVVpaBmcy7KyiWVArA8wmRaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UjxySf0Aa9Qsdwzei1Gi1Td7iskSA8Ed17jOYpCqpc=;
 b=E15xalf2DMUZjEpiGO5t6Qj6Dn9P8Qp78g++wUxHvypzLuK+Je53Y6XYZt51qYtOAG/5ILNp5ymZ14f2NFLlB2uqKQgogDMx+4hFHUv3QyKtYMyREuuuZKWw46z+zFgSmRctT9ote+LpzQorANBWg8aJkWbjsCq6cOti4VP2XCKPwVQR57tFtPXlGNliSkzFEVa4rRzxyYElTbsZyTuUMvciG072gQuIxA+2oGFtWook1669Vpr0d2zaOmGbpe9iorEF/DWm+NVn+dOeGsmQHHAiZKB4iVSQsnnTGe8lznpPsBjyG71ZqmoxCcPwlVoss1745ZWiYR7C2eej5uoQbA==
Received: from BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::9)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 15:45:39 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::6c) by BL1P222CA0004.outlook.office365.com
 (2603:10b6:208:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 15:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 15:45:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Jul
 2025 08:45:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Jul 2025 08:45:20 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Jul 2025 08:45:19 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: <stephen@networkplumber.org>, <dsahern@gmail.com>
CC: Jiri Pirko <jiri@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH iproute2-next v2] devlink: Update TC bandwidth parsing
Date: Mon, 28 Jul 2025 18:44:38 +0300
Message-ID: <20250728154438.2178728-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: cf169c40-8a2e-438d-f4a6-08ddcdedcd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8HqUdAq3r0DBBDC2uW5Kapab0JE4mPzhXPN1VAHpy3seXgmpmZE4RwYXeQ4?=
 =?us-ascii?Q?upQhfSYt9nC4VfiIOPp+CzKpmwSn3VGKVB2sYifRZDHUHEFyLviwRBVKswiF?=
 =?us-ascii?Q?tZ0UZYGRaofItm38hS35kUzepwksxP7SA8jtpyU0Vgog9Aev9427a2+dWCVB?=
 =?us-ascii?Q?8WMIaJDtNt3WEg57RgNsqw4onnhHSRUnX/XEvuSzYbYoPZs1cIPHSYbpZgxm?=
 =?us-ascii?Q?bHYKXJCtKAWhC2jioy5meu2aX6RKhmPZFNIL75vGMv3n+KecaYNNZqhU50dK?=
 =?us-ascii?Q?EXLcg+HNBL8sk5QTqSjsDsn3KuADSRB9/fg9cXDPmuwNGU1zuMFGW3lOqgg8?=
 =?us-ascii?Q?HRHMAMlurCNJmrVKP7en81RL2MmvaftjfHeKvLzjpr9djjfbdSxwSMD3s800?=
 =?us-ascii?Q?dVJcXLR00SrOuEjV/ZegsCDORW63VZK+F5UzgY2caH/rU0fF9kzBMo0ftMXo?=
 =?us-ascii?Q?A0bRHu75+TNWlCJTM03h5+qLtsymNjFOyzslGQVijuH0wyNSbwZ6qVrLt62q?=
 =?us-ascii?Q?u8PkhYSUr058x7sbpggCRakHwxTzqIOrADC5u5/MJEdvEWHotQxRFk7OYsG+?=
 =?us-ascii?Q?h0iNCGVugVasmI1z9mK/Qrt9GrNi7QE2dPAwp2rsZrV+LLmDhH1CJS6kmuC/?=
 =?us-ascii?Q?bS+4SfJP1n3ZAG9MyWwUuY9ae0sAhr2SxYPe/V+0oM1JeMMTLQkFkthOYTY7?=
 =?us-ascii?Q?lY0ePnFmYkuv6KgU4i5Quk5Y/4ooeTwjkj8HDSBTIewlV17ra1LrzaMqAPBv?=
 =?us-ascii?Q?P9hujBDWD9oSZM6NmDAzwHsXevVO2e+dMT8XVVs9jaH2PBEqb+oboM9t0hsJ?=
 =?us-ascii?Q?cQsXfccU4036UUN70457Mm3WmvdgxRjb6nzRtAxpYYDEnTUTMR3lxudT4Y15?=
 =?us-ascii?Q?sBrw2pBEgUSZxUyH198BDhgVnwYE01bxojlJiOcdgw0H5fYY3D4xH51LrIc9?=
 =?us-ascii?Q?ym78AZShG3oqtJfI9tK86voL6jnh7yX2w5QSxi433fWfYGdmbo5PqqxdknK5?=
 =?us-ascii?Q?JhOPA13uzwJxoEWhsHVjOAoTKdPMUhEQpYgcdHalmZgPadz1bbqjo0Z8OJho?=
 =?us-ascii?Q?hitsm0umVh6ce3JS9jKEaEtsiL2vZQu/JQPVbRjYC1UBGFZAJaeiU9wrkvZg?=
 =?us-ascii?Q?++1xgtUs31EJeeo+fmKQjgt2OUEtVPFrl0eQAUw4+h/ob9Db7EJUMdohBD8s?=
 =?us-ascii?Q?6HX4+5b97rbKoAOC6S+DTQAfOeo3oD2iou0jqtQR7YUNTHJFYNDChRA4/mDP?=
 =?us-ascii?Q?nn6k3qQqq1SuSjNUa142GwcjPM5I2scjOkc95ytK6vA2jlSUDR0cJosOCkqa?=
 =?us-ascii?Q?jB8cNQ1LmzbsrXkqOJhZ640f+6iJkuGcqGFNEh5d+fg4PWY1ADG+SncGsWzV?=
 =?us-ascii?Q?Kp1P6pjVee0aQO6q+EP8U7rmaps+9Lqst/mguv/cIuRtE+Zmu2HlZvpwZtmI?=
 =?us-ascii?Q?3JwhipRw1KhRMf61gn2ImV5741qBGQNJgINxyxdj5uX5rcJk9U9JHlycRZPN?=
 =?us-ascii?Q?/7pQ8O+x7bf8734yL4cEhpkq96iJKbWaQUIe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:45:39.3428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf169c40-8a2e-438d-f4a6-08ddcdedcd80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261

Kernel commit 1bbdb81a9836 ("devlink: Fix excessive stack usage in rate TC bandwidth parsing")
introduced a dedicated attribute set (DEVLINK_RATE_TC_ATTR_*) for entries nested
under DEVLINK_ATTR_RATE_TC_BWS.

Update the parser to reflect this change by validating the nested
attributes and sync the UAPI header to include the changes.

Fixes: c83d1477f8b2 ("Add support for 'tc-bw' attribute in devlink-rate")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
---
 devlink/devlink.c            | 39 ++++++++++++++++++++++++++++--------
 include/uapi/linux/devlink.h | 11 ++++++++--
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index fe0c3640..171b8532 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2773,8 +2773,8 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 			nla_tc_bw_entry =
 				mnl_attr_nest_start(nlh,
 						    DEVLINK_ATTR_RATE_TC_BWS);
-			mnl_attr_put_u8(nlh, DEVLINK_ATTR_RATE_TC_INDEX, i);
-			mnl_attr_put_u32(nlh, DEVLINK_ATTR_RATE_TC_BW,
+			mnl_attr_put_u8(nlh, DEVLINK_RATE_TC_ATTR_INDEX, i);
+			mnl_attr_put_u32(nlh, DEVLINK_RATE_TC_ATTR_BW,
 					 opts->rate_tc_bw[i]);
 			mnl_attr_nest_end(nlh, nla_tc_bw_entry);
 		}
@@ -5467,20 +5467,43 @@ static char *port_rate_type_name(uint16_t type)
 	}
 }
 
+static const enum mnl_attr_data_type
+rate_tc_bws_policy[DEVLINK_RATE_TC_ATTR_BW + 1] = {
+	[DEVLINK_RATE_TC_ATTR_INDEX] = MNL_TYPE_U8,
+	[DEVLINK_RATE_TC_ATTR_BW] = MNL_TYPE_U32,
+};
+
+static int rate_tc_bw_attr_cb(const struct nlattr *attr, void *data)
+{
+	const struct nlattr **tb = data;
+	int type;
+
+	if (mnl_attr_type_valid(attr, DEVLINK_RATE_TC_ATTR_MAX) < 0)
+		return MNL_CB_OK;
+
+	type = mnl_attr_get_type(attr);
+
+	if (mnl_attr_validate(attr, rate_tc_bws_policy[type]) < 0)
+		return MNL_CB_ERROR;
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
 static int
 parse_rate_tc_bw(struct nlattr *nla_tc_bw, uint8_t *tc_index, uint32_t *tc_bw)
 {
-	struct nlattr *tb_tc_bw[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *tb_tc_bw[DEVLINK_RATE_TC_ATTR_MAX + 1] = {};
 
-	if (mnl_attr_parse_nested(nla_tc_bw, attr_cb, tb_tc_bw) != MNL_CB_OK)
+	if (mnl_attr_parse_nested(nla_tc_bw, rate_tc_bw_attr_cb, tb_tc_bw) != MNL_CB_OK)
 		return MNL_CB_ERROR;
 
-	if (!tb_tc_bw[DEVLINK_ATTR_RATE_TC_INDEX] ||
-	    !tb_tc_bw[DEVLINK_ATTR_RATE_TC_BW])
+	if (!tb_tc_bw[DEVLINK_RATE_TC_ATTR_INDEX] ||
+	    !tb_tc_bw[DEVLINK_RATE_TC_ATTR_BW])
 		return MNL_CB_ERROR;
 
-	*tc_index = mnl_attr_get_u8(tb_tc_bw[DEVLINK_ATTR_RATE_TC_INDEX]);
-	*tc_bw = mnl_attr_get_u32(tb_tc_bw[DEVLINK_ATTR_RATE_TC_BW]);
+	*tc_index = mnl_attr_get_u8(tb_tc_bw[DEVLINK_RATE_TC_ATTR_INDEX]);
+	*tc_bw = mnl_attr_get_u32(tb_tc_bw[DEVLINK_RATE_TC_ATTR_BW]);
 
 	return MNL_CB_OK;
 }
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 78f505c1..a89df2a7 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -635,8 +635,6 @@ enum devlink_attr {
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
-	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
-	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
 
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
@@ -647,6 +645,15 @@ enum devlink_attr {
 	DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
 };
 
+enum devlink_rate_tc_attr {
+	DEVLINK_RATE_TC_ATTR_UNSPEC,
+	DEVLINK_RATE_TC_ATTR_INDEX,		/* u8 */
+	DEVLINK_RATE_TC_ATTR_BW,		/* u32 */
+
+	__DEVLINK_RATE_TC_ATTR_MAX,
+	DEVLINK_RATE_TC_ATTR_MAX = __DEVLINK_RATE_TC_ATTR_MAX - 1
+};
+
 /* Mapping between internal resource described by the field and system
  * structure
  */
-- 
2.38.1


