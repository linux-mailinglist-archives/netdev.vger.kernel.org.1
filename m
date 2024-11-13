Return-Path: <netdev+bounces-144575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9439C7CFC
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE7828253B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006E20495A;
	Wed, 13 Nov 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9JOiwBM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA62071F2
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530058; cv=fail; b=NO5WNXKIFMF07e+tksm6iB6PhcfxK09YZVgR+CeR5qCPqmbnXcePOtSRRmbjvaw0NW/re+9nnZdBEVasNUr/JhuvrPDitBO8/fJsywgoRZ5lCiiYw7swH0VpzM3owJsLfmfPOs7KL/H/eyHnILH3JUzrOx10lkS02Ajg8LWQW0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530058; c=relaxed/simple;
	bh=4TrUrb7H+gY2Z71y/PA6ORO8l2uT8S5KbtPDLHsrYHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaUZ6Bcgczi2DbiZlONRsFRHvE6V3GI8XiGO0eWN22IqsJpJDJkP/trXB+FrGaGtcR67RNZJzeafQllWdpZKr44YpPuyhcthcPC1Ji90ojSzS8u5ymq5XmSn33la65nupkfaZrHahW1MUy8vdzrgTXnArISHffkmL6eaOb7fIZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d9JOiwBM; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhqSJpCh1JrF5yjQSo0vwhZCQqrkcuG/zPBa71mRlszbKY7zEFgkD5IAsNCUajNEuEAbiengiPmrWcJFNkW6lSKGBa67rYuwmeVtYCxuSp/2QJlZRj1cVkGxovhAH5wXz4WIavsgCR+53le80Sm6CJXhOQ1QfLrx3dawkj4YHYEJ1/d+ABBCbZpi4cShDLF+Ni1LoTDOXGlb7XoGox6hANein4Yr54VsZ+tLnQ8ngFAWd5/b/KlNqau3NtrAmv2VUObIzjn7FxIb/nskUv8MSx7/gzNG90XWZAq3zKfyFKrkHn10DhgHq3qlGTLemxK5KMqzNoDsXFvUep+Hh3sS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoS0u0cALuxQswpijIQS8x3wtkg/CkxxUTBHANtONp8=;
 b=UuidCIbdxblDzQ3IcmS4SKOrFMCDNWASCr9EHZAaPU7jZi3D+7xNkSpnZho7dMRjDFAM3RPlc7JoUoPaGUX84uErQrUIuM4I6aX6ZrpZA9xUplvW549jffHws/v2wMWsHERSuC0Yh21yXGjbheLWUEM3ng4KDLJq5tzboom+g3m2Zab7Qg9ypU606EjM6swK6sRK1LyoMBuTivfttzCB77/LxZ3HWv8dDheB0RICSKihojdACFZF3u78slzaAG83H2s9Ac9OX47H0ZuM9Z4fwJwFGb92z4PVQbYvrkT/j/Ajx3oYZ3/QcNH6BCRanroGZ6Vx1FHhTg9X6Pa6/m11IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoS0u0cALuxQswpijIQS8x3wtkg/CkxxUTBHANtONp8=;
 b=d9JOiwBMS3apyVNd82Rw/TeTGqlBH6L3euuQ9gfZjX4duUnpXRV5j2n+YJaeshdBv1jNRZjPMbmBrOvDKK/VccpCC9Ki2QCd1Qj/uEhtlEgEYfY5B4utkIDDZ6GokOJq9D5kG7eCW04en/Z32VtudFf3xQY4P/jggNmdSqDLkZjr3BAJs1SEkj2cVjd7WLa5TdSHUq8Pj0bWux8Ge236N0UIpMpDl8KJVfFXys4K+MtXgn+zOVId1Zm4KjR6pPmExQ4hCQKRuA8yyvCGp/ZDtn9k+ENxNdSRT7Hkrxjy9PyxnuQDtIk3wic6ZG9W5dJ3NXSASGxc4YwP6pcPyoyS/w==
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:34:10 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::80) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 20:34:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:55 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:53 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 07/10] devlink: Allow rate node parents from other devlinks
Date: Wed, 13 Nov 2024 22:30:44 +0200
Message-ID: <20241113203317.2507537-8-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241113203317.2507537-1-cratiu@nvidia.com>
References: <20241113203317.2507537-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6cb3f5-9205-44de-ffad-08dd042287a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcMknFRUMxPss0rNAxTqBzA3Su6NkSfNgF9Acwke4UrKpK5Jhv/Ge+PZvjHb?=
 =?us-ascii?Q?u61Qw2N8U+aGLpEqMzcmkUwr1scLZKWXWjQ6Wald71Bn/SJplyHGhkb1OpM3?=
 =?us-ascii?Q?WkaVeuLxj/DkXtu6JQsAqKtfPNuGRT8Z8HkWBTHyD4tJRYBbojnm2drFEouL?=
 =?us-ascii?Q?cqDt2Bq9SaC8l1IADTLZesv5UIbtFwfGNDppymlG6Pau3BdRZOkpzfnMHRA2?=
 =?us-ascii?Q?7sq0/3VTyxWpJLCYG8VRt+xcqOyJMM5osmoAVmG85Ndua2c3h9CVEiaZ54Uy?=
 =?us-ascii?Q?bz2tDKsO5B/XIZSPAwgt5YE+Hfd+3mypD2g55IvubzR2ieeyd6PRjqQYEISt?=
 =?us-ascii?Q?lt0VCzk5sbjpzk0ZuOnLFQsyeZo77sgUE7+30UYBGrgEDWP3cS2dlkkISc++?=
 =?us-ascii?Q?3rFH/xpN/BhZjqWLguHwcwKQ5Pr9FrOqGyN7Obv+Aa7Bmxk55goahJnFLMgx?=
 =?us-ascii?Q?ib2fd9Xo8ymZ1SuK+u40VZX5VCgzlQuk6GUVxzn81dWMZdCTWIuY8frUQvgv?=
 =?us-ascii?Q?82LnF4NGRZp0HQWhoxlZp5oulkCvsM/kRGTdgF16HeU5fT4uYgPe8e4E+D5Q?=
 =?us-ascii?Q?5YGgglY2XyTvZaQnyQnRZSSOlfzIGH3ivp8971iNzLRLs19FJHdxfObx3xg1?=
 =?us-ascii?Q?VuYy1RJdHD5xWwR5m51sIIWqkKVJnbZEzWV/DZ8Lu5E90JltS7QO2cztjPhX?=
 =?us-ascii?Q?0wZFw9qa7910q0VmUPQHi+0xveLq0i8snNFxkT/jYm/YGVKGTWeollc0joTj?=
 =?us-ascii?Q?TMBWjQxevfTovmRrVbUeshJc6k0jzTMGKCb64S1A6WTALG525S4uINvVIOt3?=
 =?us-ascii?Q?dekW1oa4OFiXLnslu/LkJZqQJEDpaB09WI1gRFX6SiKvi6JkkM7se6TIgQff?=
 =?us-ascii?Q?A3QQSXwBwHRVPjD8hrLWsNJmblAz5HgidCJcS2vN/DVmC5nQlLWv2VKkbQSV?=
 =?us-ascii?Q?Gvo5QffrJ4RSV0zcULsm/gK6hTT8JtjUYpvzh6dJ+bNYg8mm8V+3afYxeuPt?=
 =?us-ascii?Q?JBbbN5p2C2xb/NUQaphzAI2nR5OCZw7gnq19IsOnaiV4VN6THAUrD3UhW/X8?=
 =?us-ascii?Q?Vpme1aUAJU4M+gOhRL+M+QzKdclXs7ZWZQhd8ZbCwsZ3Qq48wYgrLsCUC/Kv?=
 =?us-ascii?Q?N0sx/5MsMq0HsRTYo0Z2fg3RAOb0vbrkAvDylKDb9Aa8/XpeBBFW5c2id+vZ?=
 =?us-ascii?Q?f4SwZFnAe5pRjixGXJgtdnoiCTmTn5O0N5GJOeOx3hsD+41kXLQKO1mSxgBH?=
 =?us-ascii?Q?iVt9ohrBLtjp1/UCmUdSTEGZ++JCR2xovon9Kzyq3iHVFehDhp9gJWN3bgat?=
 =?us-ascii?Q?aZU3XIk24HZLtfFMu3M9oWtZh30AZdwUIgb85ErtADO5ncLZD1BtYALqmrbD?=
 =?us-ascii?Q?xtRw2A36o2XGjRZ8EkWv0RobEyTj2gV8Uv8I627VySMvmcE/aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:10.6118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6cb3f5-9205-44de-ffad-08dd042287a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606

This commit make use of the unlocked parent devlink from
info->user_ptr[1] to assign a devlink rate node to the requested parent
node. Because it is not locked, none of its mutable fields can be used.
But parent setting only requires:
1. Verifying that the same rate domain is used. The rate domain is
   immutable once set, so this is safe.
2. Comparing devlink_rate->devlink with the requested parent devlink.
   As the shared devlink rate domain is locked, other entities cannot
   concurrently make changes to any of its rates.

Issue: 3645895
Change-Id: Iffd9ccb012c3bd2dec97648161b182679eb5ca78
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/devlink/rate.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index daf366ca0575..2f12d65b6709 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -141,6 +141,27 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 
 	nla_nest_end(msg, nla_tc_bw);
 
+	if (devlink_rate->parent) {
+		struct devlink_rate *parent = devlink_rate->parent;
+
+		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME, parent->name))
+			goto nla_put_failure;
+		if (parent->devlink != devlink) {
+			/* The parent devlink isn't locked, but a reference to
+			 * it is held so it cannot suddenly disappear.
+			 * And since there are rate nodes pointing to it,
+			 * the parent devlink is fully initialized and
+			 * the fields accessed here are valid and immutable.
+			 */
+			if (nla_put_string(msg, DEVLINK_ATTR_PARENT_DEV_BUS_NAME,
+					   parent->devlink->dev->bus->name))
+				goto nla_put_failure;
+			if (nla_put_string(msg, DEVLINK_ATTR_PARENT_DEV_NAME,
+					   dev_name(parent->devlink->dev)))
+				goto nla_put_failure;
+		}
+	}
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -292,9 +313,17 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
+	struct devlink *parent_devlink;
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = info->user_ptr[1] ? : devlink;
+	if (parent_devlink != devlink) {
+		if (parent_devlink->rate_domain != devlink->rate_domain) {
+			NL_SET_ERR_MSG(info->extack, "Cross rate-domain parent is not allowed");
+			return -EINVAL;
+		}
+	}
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -312,7 +341,11 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		/* parent_devlink (if != devlink) isn't locked, but the rate
+		 * domain, immutable once set, is already locked and the parent
+		 * is only used to determine node owner via pointer comparison.
+		 */
+		parent = devlink_rate_node_get_by_name(parent_devlink, parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -816,8 +849,8 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
  * @devlink: devlink instance
  *
- * Unset parent for all rate objects and destroy all rate nodes
- * on specified device.
+ * Unset parent for all rate objects that involve this device and destroy all
+ * rate nodes on it.
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
@@ -828,7 +861,9 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 	devl_rate_domain_lock(devlink);
 
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
-		if (!devlink_rate->parent || devlink_rate->devlink != devlink)
+		if (!devlink_rate->parent ||
+		    (devlink_rate->devlink != devlink &&
+		     devlink_rate->parent->devlink != devlink))
 			continue;
 
 		refcount_dec(&devlink_rate->parent->refcnt);
@@ -838,6 +873,7 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		else if (devlink_rate_is_node(devlink_rate))
 			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
+		devlink_rate->parent = NULL;
 	}
 	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_domain->rate_list, list) {
 		if (devlink_rate->devlink == devlink && devlink_rate_is_node(devlink_rate)) {
-- 
2.43.2


