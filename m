Return-Path: <netdev+bounces-144578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4E9C7D00
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D22B233F4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708E1208982;
	Wed, 13 Nov 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NbEGtwTH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7EF433CE
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530064; cv=fail; b=OrILS3f4Fo8VSIoQAPoNTbwXqylUwgi8LSsrzpTtqcPhbQQlU5rN3RffEkax2HpXDgAGvbSGjwzk/jC01NpJ2X+JMTHTCelViqtH8GLtrxI+tCZquDHp2nZvMAmt+4exR5nsVjcnvgwa7wLB5Qe3FgmRkj/j52VJNUpmMHJsM4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530064; c=relaxed/simple;
	bh=AoNJyR+aGh7y4SUHWoSGDahjhqIo3D3kmH7HiFuOKQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeWAqcxrzRwbuuSIrlP+UoevFth8+kcIriZ1ppdWtIxIVGSmtBB9G5l4fBxnPiz62td5M51327FtDdU4eN9nH0/+3HHrw6JD/9daUyf0jUmMq3F7DL/m+UNlIFJJdfGhFb4bOObzZZQ13S0JZanY7SkVTFdJ9/Ef1kSzRuSGUwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NbEGtwTH; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzHrqZLoWAeTWhRiijU0r0Cn+yk72nftjIAXxnwQ0g+H9gF0VN08xbMvG+29pSZXYbdjljrDQvrzUAB+SSAsrdhvhlzPfJArodnOKqBwR2s4IsoQT7xzPq/tgVM6UzWDChZ2x+QlmpWkhs0UM2/+ZeaUvRQjzrf+faZH32InI1uWQ2+HDk0cfdl+6xTsByypmhMJhd0oVzUouq1wCEt2SXdvZKiN+0349Xz7ITQNMpwV5zYe66r4iSDfUIcxHbUqF/2fJoXKE8z6B5YgtDkUBrAqJ7dc1XdQL7//D31nSrIuOC3fixFyS+iQeHgesn2Qo0ILqpbt+3sONoTtLApnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hOK8IxJkE2N9UWHVGimpYbuc0M/nv5+3Yd0HhzNbzc=;
 b=F+SPdf2dMwkViVaIVWijQ6YJlJ9bfzaows4gpShd214ZViWtGtV4a1i1rTbkivyL3P0L2WshPn+MSP+4oiIAGoyRZ2zB7Obj5NhC03B/FY3BdRCFAJTed96tOSaUw191yJIPbZAPyqKbWybN+GGtqgRKBHHBrZIFNJIr6MhIZE4Umbg8SaOIryURGJXcVOt+V69kWHugzJbJbBjKUbZ8MEKJbI61nvC6WcVObxxo8TUDrnWwA3AjZ82H6aGvzvV7bZL/vRn2GzN2vrJY2UZsuI1yMGkRKPse0QR1Yt3bCXlCGIxVYo3NJJH9jiUMn2TuaazWBFhzZRkhjPlteUgHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hOK8IxJkE2N9UWHVGimpYbuc0M/nv5+3Yd0HhzNbzc=;
 b=NbEGtwTHwl09ONatnn0u2phUrSrwtj5BLO5pFsjdQOSTn+rkJJVXZE/zehvAs1kxsyeIdXzIFaa+TT3Isy23OG4Wk7K7etAGRplxsiuDMRPOmHJUV4C6ep1hSsvNMmAIxl01p4Q5hu0zN2JZ7j33b7ok3aI3Biq8iNjLOndJefW01XKhXZJOOC9W9inecVr5sgfYmAMwYGcdt5QmSnvJN8j8ITXVrEnUbI+7JCEXjlLfJkcf15pbmXORcMb7LOhTFxRvNEqOwlMsf4968nlxwV2KkMlIOd8NeroQsL37gZKdhhg5ogumWsg+/wXPBfB2FO888en0aMuyrw1qS5OVOA==
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 20:34:13 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::ae) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 20:34:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:51 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:49 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 05/10] devlink: Introduce shared rate domains
Date: Wed, 13 Nov 2024 22:30:42 +0200
Message-ID: <20241113203317.2507537-6-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: fe87dcd1-4607-483c-d778-08dd042288f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nkosOxCH+1bZhIDgT7KD3er3kXVejOMdU88VIHJUYMHIUQ2vK6OiLBEDa1E7?=
 =?us-ascii?Q?hj1ocI0jpBZvJJR8AzW+cH0ntcidbF5gOJlB0n1TmrOpBhKkOjAVa0HJQtxX?=
 =?us-ascii?Q?Cp7UTJMcXh5Suta+ytrb1J5Hmj2GBplKlLbrC7TlC0ZgK3Yu3wCfZXIWhUhp?=
 =?us-ascii?Q?Cgf3ucFc4clhlCN4uptZyM2u9f4HV8+1yqLiaiudRcy0V5P/FCq+HHn32LjU?=
 =?us-ascii?Q?bTrLJRSPQGODT4fuPC3cMedYmNvHuX8ffBg87YM8BSRt92m8EyeTMKHFCF6O?=
 =?us-ascii?Q?gvPBg7Dk0tRIScbhlHLBQOi71QaAeH1fT6UIcwK7fiUoL3fX+ZQcI5ef5UAr?=
 =?us-ascii?Q?WVBZQv8xmRjj9cfzyK4CuDLmwikCJPielfIO/SyEevpWuWaDTCtVvUwjmCtD?=
 =?us-ascii?Q?bOBLi15oEnZlSZBK/l13382LgtND10yn0dgAG4Ncr/QuX00/J8SF0BZu1UvY?=
 =?us-ascii?Q?MB1TwYmXgEgr/60dZDze7Lhb9h45i/bPzZ+/NNkkqGp5+mts9c4GXtD2OOaU?=
 =?us-ascii?Q?YWbBrIRQYr7p3CZnJwAfKSwGIOX5vb0OhiItXwDtwZUDg4VGZU59y6BexNHy?=
 =?us-ascii?Q?R0PwOmps1dC6qXoaiN16mdkHC4hJfroW/au3e3byudXPn50BbNw+0OBT8iMW?=
 =?us-ascii?Q?Uu3crjswZlzBMJEwFow8bvEMFhEb8Z+FW3ojLPQD5xeDt1qfknZDzyV+RUTX?=
 =?us-ascii?Q?q9lRg0U0xTiEBJ6nr2pzFXQtWIR/UVdfMx0ahsc0VBkTtNTgbbOlM8AwVPdD?=
 =?us-ascii?Q?988fryR9QCjdYqcz/kyenLMrYja4+xZ6txZFMTIZbGWDO8V0umobgeZe3yGB?=
 =?us-ascii?Q?4dQz8tKYj3A18QcpncSVZkFqwHoL5NBm4pHWLyRi8oASA0kqAhG/pCuKWJSq?=
 =?us-ascii?Q?r+Dc+cVNflhiuo9zPoagaBHjHd3ahrF0x+5m6smLmJhpoeahgSLk/Gmdnj/s?=
 =?us-ascii?Q?6zw+WTvtUu4Zj9F/86TAnJ9F9tZA5O/dI0XA0pKdyk6fc14TdJGpkSzKiZMB?=
 =?us-ascii?Q?tHsNJ6ufmoKOGlXXOOVSDMNY4HZ+i82rxzbljAfYbgcu+YTY55MOP19KHSwN?=
 =?us-ascii?Q?5WXcuFfsSxPbSp9T/P9XyvRXD/n6FVvm1GA38Mx8gqXsyp/8PlvogalbKqml?=
 =?us-ascii?Q?oOYJ8XFlgGuuVneBLFt072n4uMU/7kT86RKU8Y9CZpaJ5VUb8Akm4adRXlz1?=
 =?us-ascii?Q?L0CmDlXnPR2MzSp8Z4ZUqTsu7YGn40LDksKVSLaCaayAtgidKuxwq0BHToNf?=
 =?us-ascii?Q?qFMp9577M1wHC/CDt7t30RUbRrEsjzvonrA7JTpLQZBDfKbGu1kdcAUD0jpO?=
 =?us-ascii?Q?T8wdjZZkjRh/v2Cni+ATMaNH9nRO0x2KXKm3D3NpxAV5suc8ynSEJWOhYo3R?=
 =?us-ascii?Q?4YtJEadYdQEmLI6jZVfcNfmJDyYR4e5w1vrvOr08DQnSECr9zA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:12.8818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe87dcd1-4607-483c-d778-08dd042288f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

The underlying idea is modeling a piece of hardware which:
1. Exposes multiple functions as separate devlink objects.
2. Is capable of instantiating a transmit scheduling tree spanning
   multiple functions.

Modeling this requires devlink rate nodes with parents across other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

Based on the preliminary patches in this series, this commit introduces
the concept of a shared rate domain.

1. A shared rate domain stores rate nodes for a piece of hardware that
   has the properties described at the beginning.
2. A shared rate domain is identified by the devlink operations pointer
   (a proxy for the device type) and a unique u64 hardware identifier
   provided by the driver.
3. There is a global registry of reference counted shared rate domains.
4. A devlink object starts out with a private rate domain, and can be
   switched once to use a shared rate domain with
   devlink_shared_rate_domain_init. Further calls do nothing.
5. Shared rate domains have an additional mutex serializing access to
   rate nodes, acquired by the previously introduced functions
   devl_rate_domain_lock and devl_rate_domain_unlock.

These new code paths are unused for now. A caller to
devlink_shared_rate_domain_init will be added in a subsequent patch.

Issue: 3645895
Change-Id: I045456c4d06fd7018ba0da345688ee43e1d0fd74
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 include/net/devlink.h       |  8 ++++
 net/devlink/core.c          | 79 ++++++++++++++++++++++++++++++++++++-
 net/devlink/dev.c           |  2 +-
 net/devlink/devl_internal.h | 26 ++++++++++--
 net/devlink/rate.c          | 15 +++++++
 5 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 917bc006a5a4..18da697f6607 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1553,6 +1553,14 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+/* Can be used to tell devlink that shared rate domains are supported.
+ * The same id needs to be provided for devlink objects that can share
+ * rate nodes in hw (e.g. contain nodes with parents in other devlink objects).
+ * This requires holding the devlink lock and can only be called once per object.
+ * Rate node relationships across different rate domains are not supported.
+ */
+int devlink_shared_rate_domain_init(struct devlink *devlink, u64 id);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 06a2e2dce558..eb96a97a9e44 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -289,6 +289,80 @@ void devl_unlock(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devl_unlock);
 
+/* A global data struct with all shared rate domains. */
+static struct {
+	struct mutex lock;    /* Acquired AFTER the devlink lock. */
+	struct list_head rate_domains;
+} devlink_rate_domains = {
+	.lock = __MUTEX_INITIALIZER(devlink_rate_domains.lock),
+	.rate_domains = LIST_HEAD_INIT(devlink_rate_domains.rate_domains),
+};
+
+static bool devlink_rate_domain_eq(struct devlink_rate_domain *rate_domain,
+				   const struct devlink_ops *ops, u64 id)
+{
+	return rate_domain->ops == ops && rate_domain->id == id;
+}
+
+int devlink_shared_rate_domain_init(struct devlink *devlink, u64 id)
+{
+	struct devlink_rate_domain *rate_domain;
+	int err = 0;
+
+	devl_assert_locked(devlink);
+
+	if (devlink->rate_domain->shared) {
+		if (devlink_rate_domain_eq(devlink->rate_domain, devlink->ops, id))
+			return 0;
+		return -EEXIST;
+	}
+	if (!list_empty(&devlink->rate_domain->rate_list))
+		return -EINVAL;
+
+	mutex_lock(&devlink_rate_domains.lock);
+	list_for_each_entry(rate_domain, &devlink_rate_domains.rate_domains, list) {
+		if (devlink_rate_domain_eq(rate_domain, devlink->ops, id)) {
+			refcount_inc(&rate_domain->refcount);
+			goto replace_domain;
+		}
+	}
+
+	/* Shared domain not found, create one. */
+	rate_domain = kvzalloc(sizeof(*rate_domain), GFP_KERNEL);
+	if (!rate_domain) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+	rate_domain->shared = true;
+	rate_domain->ops = devlink->ops;
+	rate_domain->id = id;
+	mutex_init(&rate_domain->lock);
+	INIT_LIST_HEAD(&rate_domain->rate_list);
+	refcount_set(&rate_domain->refcount, 1);
+	list_add_tail(&rate_domain->list, &devlink_rate_domains.rate_domains);
+replace_domain:
+	kvfree(devlink->rate_domain);
+	devlink->rate_domain = rate_domain;
+unlock:
+	mutex_unlock(&devlink_rate_domains.lock);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_shared_rate_domain_init);
+
+static void devlink_rate_domain_put(struct devlink_rate_domain *rate_domain)
+{
+	if (rate_domain->shared) {
+		if (!refcount_dec_and_test(&rate_domain->refcount))
+			return;
+
+		WARN_ON(!list_empty(&rate_domain->rate_list));
+		mutex_lock(&devlink_rate_domains.lock);
+		list_del(&rate_domain->list);
+		mutex_unlock(&devlink_rate_domains.lock);
+	}
+	kvfree(rate_domain);
+}
+
 /**
  * devlink_try_get() - try to obtain a reference on a devlink instance
  * @devlink: instance to reference
@@ -314,7 +388,7 @@ static void devlink_release(struct work_struct *work)
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
 	put_device(devlink->dev);
-	kvfree(devlink->rate_domain);
+	devlink_rate_domain_put(devlink->rate_domain);
 	kvfree(devlink);
 }
 
@@ -428,6 +502,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	devlink->rate_domain = kvzalloc(sizeof(*devlink->rate_domain), GFP_KERNEL);
 	if (!devlink->rate_domain)
 		goto err_rate_domain;
+	devlink->rate_domain->shared = false;
 	INIT_LIST_HEAD(&devlink->rate_domain->rate_list);
 
 	ret = xa_alloc_cyclic(&devlinks, &devlink->index, devlink, xa_limit_31b,
@@ -484,7 +559,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
+	WARN_ON(devlink_rates_check(devlink));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index c926c75cc10d..84353a85e8fe 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
+	WARN_ON(devlink_rates_check(devlink));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index fae81dd6953f..7401aab274e5 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -30,9 +30,20 @@ struct devlink_dev_stats {
 	u32 remote_reload_stats[DEVLINK_RELOAD_STATS_ARRAY_SIZE];
 };
 
-/* Stores devlink rates associated with a rate domain. */
+/* Stores devlink rates associated with a rate domain.
+ * Multiple devlink objects may share the same domain (when 'shared' is true)
+ * and rate nodes can have members from multiple devices.
+ */
 struct devlink_rate_domain {
+	bool shared;
+	struct list_head list;
 	struct list_head rate_list;
+	/* Fields below are only used for shared rate domains. */
+	const struct devlink_ops *ops;
+	u64 id;
+	refcount_t refcount;
+	/* Serializes access to rates. */
+	struct mutex lock;
 };
 
 struct devlink {
@@ -121,9 +132,17 @@ static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 		device_unlock(devlink->dev);
 }
 
-static inline void devl_rate_domain_lock(struct devlink *devlink) { }
+static inline void devl_rate_domain_lock(struct devlink *devlink)
+{
+	if (devlink->rate_domain->shared)
+		mutex_lock(&devlink->rate_domain->lock);
+}
 
-static inline void devl_rate_domain_unlock(struct devlink *devlink) { }
+static inline void devl_rate_domain_unlock(struct devlink *devlink)
+{
+	if (devlink->rate_domain->shared)
+		mutex_unlock(&devlink->rate_domain->lock);
+}
 
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
@@ -307,6 +326,7 @@ int devlink_resources_validate(struct devlink *devlink,
 
 /* Rates */
 int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack);
+int devlink_rates_check(struct devlink *devlink);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index b888a6ecdf96..daf366ca0575 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -675,6 +675,21 @@ int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *ex
 	return err;
 }
 
+int devlink_rates_check(struct devlink *devlink)
+{
+	struct devlink_rate *devlink_rate;
+	int err = 0;
+
+	devl_rate_domain_lock(devlink);
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list)
+		if (devlink_rate->devlink == devlink) {
+			err = -EBUSY;
+			break;
+		}
+	devl_rate_domain_unlock(devlink);
+	return err;
+}
+
 /**
  * devl_rate_node_create - create devlink rate node
  * @devlink: devlink instance
-- 
2.43.2


