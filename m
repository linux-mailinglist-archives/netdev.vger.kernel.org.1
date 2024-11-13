Return-Path: <netdev+bounces-144576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E79C7CFD
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9CB282B5E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417C32076B3;
	Wed, 13 Nov 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fCEuAVCa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FBC204024
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530058; cv=fail; b=tSxhGf8meyem2r7a4MmQ0sTAwo2RhJ0hIMcXcPeqw3H82sXHLKf8uPHvY87goBVxOuASSNv/FqKF6O6xFm35IoC+eD9vZNN8NCAv7d/IeiTjTppQ3iKgp16PVug8j9ExlfcktDd2IPq9UCyLbrezzz2O6sC5Rnl/WcKQmR/L4+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530058; c=relaxed/simple;
	bh=rxQI0Yj9z8KAJWM87Vl+nl5ii+IX1Ekuxco+wObW7To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnVqHSSh87UWSA0NC7QMUHalf/y7UMGV7Q0jmcPveAXiGbWyKh9XUja+H3LT1IZs6fJIPAQVqEtkOjnxelWd6NWJtYlevVcGQtaidPk0hFXmwDCb3b8v662deeuqVArtfit6632R+PUgkHx40jg5WqM0yYNaqwD45P/W3otWBBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fCEuAVCa; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/UDjkZ0p//Lg6Wj4Is5pzY0acse1uyuZQvdz10Pxa9Om8PHxnA8Y+rQBsLSaQbFpei6fSImhM1ZLq16W1FpfdX9xgUN5ryNz5COw3QDzDJuDnkGb99WhZovqDnEm6caxRvYUZSEiQFtAfMc4f3kXN1cdaTclGA8uxy5ZCFQc967FDqdFA3dpKNRyj4jrm6a+LpcDSERI63WfU/cuzQ0+6rXFEFiDo3ydRyBJOsusiO0QHfZGzMGKRrp7uz4wwERBofV1KejCO+bynTDb3kIfM7PjMvwY6ZoLXYHAOzftFYwvzIY6YITduvRp/RWr/5WRtoNDxBZlexh7AeSL/W8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnsBS5CFHGhHbKNOuS++9ZDJ3GeiCjLv+33CExf5Nqw=;
 b=kKE+bti3M03RrKmXnae8G6BEOxTIhxF0wMGVCRiP8war3Vvk8LncCOnuM+sm1Bw8d6xIDAI2E74EP+vk4RIoReKxJHh7yE790blxmcrymEVmezRsyke6Sik60FyhuAQrxIznAHAqOag3SlkgZxx9BFkPLNEy6CskOcX9RO9V77tJ4BqmfOovsciXSYOYRVR/BNxnDmm1MlbAENh8bIVyr9cBE4mbz7Mgqgam0xtcZ8VFy5MmUw0HC0K7CX/cjG8MD43HVpVADM/UFEcvO7lI007a6PuK0kq8nwNe3dnyUeJZyvs/f1ikREJov8u1s1rDZEnqwH3pcQCcT7YiF6uOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnsBS5CFHGhHbKNOuS++9ZDJ3GeiCjLv+33CExf5Nqw=;
 b=fCEuAVCa0ppokSRX9ne97zwmbKtTCLMVNZeOkq7qIzhbgVTH8QoXncj2tbOHuupI29qiA3Je0hRrZB0GBT/nYGerqLqVGHLmYazNuwbyU8nnoC514nGNxk7r32xddr+krltYWLn6hPwta0eXXrratLeB2CTU1oHJPwGDSiCAtpw6wtenL7ZChIrKw+mjnMKlUhuV6j8KV9HS8W3X4xLSP6l6Cq+3SRumcQrmSwmAPAwSbz8nYOToDeTMicdpTi+piY4Q7VG8ucM4Wq+gRuGj0hM28biLYDqSQ8dlfGQrwTjZsruJJQsOeO3Y5lyHuzJZGfzd/FWVKjRv+V+hkXsL8A==
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:34:09 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::22) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 20:34:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:46 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:44 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 03/10] devlink: Store devlink rates in a rate domain
Date: Wed, 13 Nov 2024 22:30:40 +0200
Message-ID: <20241113203317.2507537-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5911225f-9862-4558-df96-08dd04228696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qtXIlU0mtsLZBW67ImpsMHNVD/pdGYWEFnvQN8xfnaZy6ZU/3LWSXoUG2Y+0?=
 =?us-ascii?Q?WnkTvGfRMz04Pwao9ENHQ2rzjrtJFCpeACAmD7/5rkeTM3Fb1Kv5plBY1PWu?=
 =?us-ascii?Q?bzu7oawdHRQmx7GjW9ly1Ohr5N2ok2hhA2Cz0IYRupVmbhthduccDlLOlRAR?=
 =?us-ascii?Q?4+c4G3NEzCnOigKzQN/q58379gX8z7VS59UsFezkSieUpKZVVoFEAh3w4nLZ?=
 =?us-ascii?Q?PEPILtbnIRC7Uf5lg+mZnxc2DE0DrN5ZD6pC/So67USR1Cr6DpYziMCnsCh0?=
 =?us-ascii?Q?ZGXjs/lqvPRoG9YTIBsuoRNtm/2h5EbR3gERMvO8vjZ19ga1AJTzvtmk1mpT?=
 =?us-ascii?Q?vdxgOe53U+lWc48szUhjMjZ711wc9p03qyGf23yhxD0iu2HLbyApwdkZEAFP?=
 =?us-ascii?Q?6ea+yd8yDL+pf4ushns6CgcuuVSP7hyYDcRbeOKqs/a1NxhM3cpmCmKczHGf?=
 =?us-ascii?Q?6Xer3Lr1jFcAyFmxUxPbdaewAVDhLPJuBh5I+fC2kdBNgGovR9zK7OWV4ZTJ?=
 =?us-ascii?Q?iZnpzxNGdrlA52Nhag2ahjjxyFB7r3Bysd0JSRR1Ok+rX1++vRmVJpbuFYKi?=
 =?us-ascii?Q?rIiF6rhes4JG+xgMOiP21hWQe5fVg4mK/AszpR8ZvwuICZS2X+uAIYo3lbAy?=
 =?us-ascii?Q?zHli+UhX49W9HdMAWVl+DswYxXLHvS9GvJwU3ZgNTWlddiNs+ojcl74fAZcB?=
 =?us-ascii?Q?GwToe13aOXjRDX9Ik9gnfDWQ8NAX0s6Itbn/khFEA4S9Zlj4ERhurCA3bLUS?=
 =?us-ascii?Q?5J5MZQNF+RSRpq/h6JKjHb+rUsF1wBAUfYNR6KOc3FaqjMV2cavFSNoY9cx5?=
 =?us-ascii?Q?iPShcafqI4mXMn2BrYhzyRs8sIsY363Bh6p4GNwJ64AK6Ajm9EnG54KhbDQh?=
 =?us-ascii?Q?SJSjZIU2EQ4UnIXyAOulZnSM5dk6akQYntkJA6JXlx6Uc+R6NNZ+NxXnh3G7?=
 =?us-ascii?Q?OWAlgzB8c6REcSaiGGJT6luS9tHj1kpuMIBvstCh/qx74Ywn5be8RV9lZWfn?=
 =?us-ascii?Q?cch1VsezsnbWs/8xlyQhl8YgfSuw4AcknOJeSGCp7qxcFU2RSsmywC+2+hil?=
 =?us-ascii?Q?QfL0XF3OFAYf6elZWJJ4tBwThxwx05M6Slpo60VTSjvqiFdbmPyI4P2YozV3?=
 =?us-ascii?Q?1g0GLg2cXIBMMYixatWKZfcJ+i/Du1p878r3viZuDATEQRPHsvDgdtFmxCqO?=
 =?us-ascii?Q?i76xlei0X84UzTOmtl3/s9Sf/y0lNmEExbflqBUbJA/1ms907szXmme+oeyo?=
 =?us-ascii?Q?aOZWZz9XRdzlqB+f8s7Cz47zUdsB+H5gt7NgJa7EX7ymCnoAZPToKW3THLkH?=
 =?us-ascii?Q?ztjl4qGOM2woLNnaOgrISITWzRCA9GObaDDmFzacaMjrnmB5dpb4/CgUBl7N?=
 =?us-ascii?Q?6znUGjd47sh6z+aOhekNFhuxyJ1DdKX1Fhr7E31+BPATGz+oeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:08.8818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5911225f-9862-4558-df96-08dd04228696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

Introduce the concept of a rate domain, a data structure aiming to store
devlink rates of one or more devlink objects such that rate nodes within
a rate domain can be parents of other rate nodes from the same domain.
This commit takes the first steps in that direction by:
- introducing a new 'devlink_rate_domain' data structure, allocated on
  devlink init.
- storing devlink rates from the devlink object into the rate domain.
- converting all accesses to the new data structure.
- adding checks for everything that walks rates in a rate domain so that
  the correct devlink object is looked at. These checks are now spurious
  since all rate domains are private to their devlink object, but that
  is about to change and this is a good moment to add those checks.

Issue: 3645895
Change-Id: I950064c3e86be0339a818e091dea9011d692c556
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/devlink/core.c          | 11 ++++++++--
 net/devlink/dev.c           |  2 +-
 net/devlink/devl_internal.h |  7 ++++++-
 net/devlink/rate.c          | 41 ++++++++++++++++++++++---------------
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f49cd83f1955..06a2e2dce558 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -314,6 +314,7 @@ static void devlink_release(struct work_struct *work)
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
 	put_device(devlink->dev);
+	kvfree(devlink->rate_domain);
 	kvfree(devlink);
 }
 
@@ -424,6 +425,11 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (!devlink)
 		return NULL;
 
+	devlink->rate_domain = kvzalloc(sizeof(*devlink->rate_domain), GFP_KERNEL);
+	if (!devlink->rate_domain)
+		goto err_rate_domain;
+	INIT_LIST_HEAD(&devlink->rate_domain->rate_list);
+
 	ret = xa_alloc_cyclic(&devlinks, &devlink->index, devlink, xa_limit_31b,
 			      &last_id, GFP_KERNEL);
 	if (ret < 0)
@@ -436,7 +442,6 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->nested_rels, XA_FLAGS_ALLOC);
 	write_pnet(&devlink->_net, net);
-	INIT_LIST_HEAD(&devlink->rate_list);
 	INIT_LIST_HEAD(&devlink->linecard_list);
 	INIT_LIST_HEAD(&devlink->sb_list);
 	INIT_LIST_HEAD_RCU(&devlink->dpipe_table_list);
@@ -455,6 +460,8 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	return devlink;
 
 err_xa_alloc:
+	kvfree(devlink->rate_domain);
+err_rate_domain:
 	kvfree(devlink);
 	return NULL;
 }
@@ -477,7 +484,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 5ff5d9055a8d..c926c75cc10d 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 9cc7a5f4a19f..209b4a4c7070 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -30,10 +30,14 @@ struct devlink_dev_stats {
 	u32 remote_reload_stats[DEVLINK_RELOAD_STATS_ARRAY_SIZE];
 };
 
+/* Stores devlink rates associated with a rate domain. */
+struct devlink_rate_domain {
+	struct list_head rate_list;
+};
+
 struct devlink {
 	u32 index;
 	struct xarray ports;
-	struct list_head rate_list;
 	struct list_head sb_list;
 	struct list_head dpipe_table_list;
 	struct list_head resource_list;
@@ -55,6 +59,7 @@ struct devlink {
 	 */
 	struct mutex lock;
 	struct lock_class_key lock_key;
+	struct devlink_rate_domain *rate_domain;
 	u8 reload_failed:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index c9e471b9734e..58108567b352 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -36,8 +36,9 @@ devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
 {
 	static struct devlink_rate *devlink_rate;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate) &&
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate) &&
 		    !strcmp(node_name, devlink_rate->name))
 			return devlink_rate;
 	}
@@ -177,16 +178,18 @@ void devlink_rates_notify_register(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
-	list_for_each_entry(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	list_for_each_entry(rate_node, &devlink->rate_domain->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
 }
 
 void devlink_rates_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
-	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	list_for_each_entry_reverse(rate_node, &devlink->rate_domain->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
 }
 
 static int
@@ -198,7 +201,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	int idx = 0;
 	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
 		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
 		u32 id = NETLINK_CB(cb->skb).portid;
 
@@ -206,6 +209,9 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 			idx++;
 			continue;
 		}
+		if (devlink_rate->devlink != devlink)
+			continue;
+
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
 					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
@@ -576,7 +582,7 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rate_set;
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
 	return 0;
 
@@ -619,8 +625,9 @@ int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *ex
 {
 	struct devlink_rate *devlink_rate;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (devlink_rate_is_node(devlink_rate)) {
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list)
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate)) {
 			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
 			return -EBUSY;
 		}
@@ -666,7 +673,7 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	}
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
 	return rate_node;
 }
@@ -704,7 +711,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	devlink_rate->devlink = devlink;
 	devlink_rate->devlink_port = devlink_port;
 	devlink_rate->priv = priv;
-	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	list_add_tail(&devlink_rate->list, &devlink->rate_domain->rate_list);
 	devlink_port->devlink_rate = devlink_rate;
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
 
@@ -745,13 +752,13 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
-	static struct devlink_rate *devlink_rate, *tmp;
+	struct devlink_rate *devlink_rate, *tmp;
 	const struct devlink_ops *ops = devlink->ops;
 
 	devl_assert_locked(devlink);
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (!devlink_rate->parent)
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
+		if (!devlink_rate->parent || devlink_rate->devlink != devlink)
 			continue;
 
 		refcount_dec(&devlink_rate->parent->refcnt);
@@ -762,8 +769,8 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
 	}
-	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate)) {
+	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_domain->rate_list, list) {
+		if (devlink_rate->devlink == devlink && devlink_rate_is_node(devlink_rate)) {
 			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
 			list_del(&devlink_rate->list);
 			kfree(devlink_rate->name);
-- 
2.43.2


