Return-Path: <netdev+bounces-224361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840ECB84074
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3892754388C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669C2F7477;
	Thu, 18 Sep 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OmzJzaJ9"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A722F6567
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190612; cv=fail; b=MnKuKj4Q+nZu2pBYFizfN3Z7coDuggT/yH50mQvXnawCu3FS+B/3IRHIi+JepTjtdbmY3cb7//JcPKb4BOGc1Ugrt2bZLJ6sxHvd+U7JjDR3IUfgRNA59UULAkmf72N9TrLxFEVg3Ayi5Y9zRFXok1g76r/z8GDEr2C5IGwhdh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190612; c=relaxed/simple;
	bh=KImkQ0ZkdEdz/3iLegl4QEkFK1mId0q5iLJnthUt6EU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWfkvyfD5djAlWfCOiLlCjdfYcb7LNZZj2exX61/05bpIauQXHh03YQYJTAPrtxvY8z5bG5o9khDNPXkdhXQz9KvimNei+4kIOp6RMrZFCeW/0/w5ZelfjD+G3JBf+s6BZ+Z6pIrWUni7GDdnvUGt+K8OUVsO3dfEfcmIJ3WHss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OmzJzaJ9; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFmT2b30K/lA6p37hocvUz+LA7hT44R2T0LzB/JOYDE3EY3j/BMdfhcNmdJ2LS7TyBuorrcRssnfj9+fE+Yh1UCFkaAcW3idLt159cBQ7ByVsVw2l96FT7+0Y98jUnhNs1EMAfD3tq49La+RymLvsjcwuPfA5Oa/oz/RQmxNGmKsoHGyuOPfJBciioqZrEQNBr9SsHKFMs0IjDnZrSdIheigLUMMlW9yuPUIweyEpVirjdBTmQddA4aUKn/Bf8qIEJKeggRuvpjPGO4kVOthZztgAfEGtj7PfWkgSzu2hJPywO49P64yHZOzicK+t3deYMYiPFBHDS62fWN0N0Z7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rItsmtE9rMgFeAdIl+w+MMKZuUbf0IAbvxhhRSWim4=;
 b=r7qXrxr6XVHMN5x7lw/E7UGuTEEyDhD4W2UX4eCwuxJE/lvOVXzTURLPOXopqKATTgLbskRxwEYDxInnif8xC6PPkHBkz5udI024+b4miCl242LDoKmbqpxaGz36eqLbKpIstO3KiyCriiE78Ugh2kPHvZ/6O7KgcqLVWr5qV+s9z09C9BAnRE/bye/jfWp9IgfPWc48Zgi8RCYzS6iZHaHQZmByep2EtT5UoBkftsXGZFZWSBJOofKsJtYPfYsVip6oUiUjXHXXEDjFXFoGQkx6bW3x5XMseA3zlKJ+n4t8yTXjUjA2mU2l/2nj75Ew7qHG6herCMpFBZZf7QQLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rItsmtE9rMgFeAdIl+w+MMKZuUbf0IAbvxhhRSWim4=;
 b=OmzJzaJ93pWL4giZKlYJGCD7l5QfLpcr/FyLBGyVQsWuGRfNBhAnEsGNV/neqcQHi+5Cl5BL/yZgHzVVPpPdLZK9+4O/o/q9wSJ2dPnVPKAT9AjT1F/fRyHXp6CIc9+tfrGtp2SkRMi8/nFHXOUvGE5l3Ng69k22Eq5T40l5baxkfS/OEb4z0f7tI30MUGP4YWkJ/j6Tc+SeEcx0LjbLflYQyO4wZsMjqypuydFYkDofAB2bZ4cU0KCoqZ1QPahns3ajHCLs2+MouI7YL93iyoelYMKXYvNx30VvCxa98l/MVarXeD98mfd9XRVyeJlaaMaCmOpXzcpKTu4pncEOMQ==
Received: from BYAPR02CA0069.namprd02.prod.outlook.com (2603:10b6:a03:54::46)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 10:16:47 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::8e) by BYAPR02CA0069.outlook.office365.com
 (2603:10b6:a03:54::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 10:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:16:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 03:16:31 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 18 Sep 2025 03:16:28 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vlad Buslov
	<vladbu@nvidia.com>, Dmytro Linkin <dlinkin@nvidia.com>
Subject: [PATCH net] devlink rate: Remove unnecessary 'static' from a couple places
Date: Thu, 18 Sep 2025 13:15:06 +0300
Message-ID: <20250918101506.3671052-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ef34b4-bcae-4dd1-ab33-08ddf69c7939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eFXyVxlPiI0enCqKr6U17wYszLnhLtQKI++B4LyjSazzKDGl/bJacyHn21VH?=
 =?us-ascii?Q?ltxMxo9QeiNogn8YBwweM9wxVF2gk6NvqeFd0pghXi2r25HBcgqn2tLiVvcB?=
 =?us-ascii?Q?wx2d8v0I+kFdixE2MJGuhahZIy+rd/7+I5wsHOxa+bv8naeGDSu4soMD5/+z?=
 =?us-ascii?Q?RNO+rbg/S14QS87Q7UxvHAUPCVtsr4LPFhfR9q95U13XrPdDmC0rLMh2AvJB?=
 =?us-ascii?Q?s1hXZheqVIFFgc4swcFK1iaQPhq+4weNJgjs9iqkmy/8GjWWaEaiZNGsA66g?=
 =?us-ascii?Q?BB602Kye5JJjSZ60T1rgioNehzi6mZxrgnKmhU39ggUkkH4SCDTT/MggX9K7?=
 =?us-ascii?Q?a8ln1/jYo6AEB4WiJLHurVvDsci/T+RQkkaRhCXtPXHwe7aezaHeCVmPd5CC?=
 =?us-ascii?Q?ByYNhatqncKNKqPb/S0AYqubfq9gIWf46QeaezS8BS6KIAkyg/wHEXX0EK+X?=
 =?us-ascii?Q?STY3/vzzJdBmrP68BNA9LhQOMPsedyaXv/5juWqFvZ/MODgQ+o8hyYSxPWZx?=
 =?us-ascii?Q?QFizj2sN2wm/m4oVq2TEOZ/6sAlwExATzBaEdtIzBMlOyhNhc3NjjnLoRuBO?=
 =?us-ascii?Q?xYkulgo9FRctOh2/wGYBsKAumfwYkWcI++3PqQxaDrUlVOWAh2ySx68FYqR+?=
 =?us-ascii?Q?+Ak7Oek1xBtd/592mLZxyThV8Fi+iKjBpITYlr8e4HmcPN0SlEQxqvO41V19?=
 =?us-ascii?Q?GlyN3zJvs7DD0VIFDjXtENLggvvef1GBX+S04AdGLW1yaHSPA82+Wl3fEgJi?=
 =?us-ascii?Q?zb6uS/DGQh4uSCtffUR5ygw5YI2FefOKtcKvjN7A1ig2opuaGKBKDTYnhi2r?=
 =?us-ascii?Q?YZ9RkruJZBCogg/cMIZbIVfi6osu4t66crBQ++rYPiMb5omZmBVwy1VrIqZv?=
 =?us-ascii?Q?86RKIMfaK/AqhnHmSeZPzBP+sh0UiPNC3WWMC2/NeJP2lkyjqQAwFLnmAb8k?=
 =?us-ascii?Q?9HfAWAJw5bMSANGfkYlTWyespxZ7WVS5p7fZqGH392HhATHeBUMR75b6Hole?=
 =?us-ascii?Q?BoOsrGLUZqlmyUVENm1AOZbEO7FEk/KuUZavqziCuzTXSLhXi93CRh/JQU/e?=
 =?us-ascii?Q?byUkiKL01vFjXlPh7tjBgYmRYSfoLJnoNsNiR90wAHLLFEv2Pyvke9NNJPHW?=
 =?us-ascii?Q?By4ZPJQCOpXv+13mJKM5GPxAafzgqEJiFqy8DqMQ/mr8whuCL/smm1pI6C71?=
 =?us-ascii?Q?F1CJ6ujO2ofgF5hGOXw4biIjpG7hvhniLEL6PZuRuv7qd4rclxpMBtilP/od?=
 =?us-ascii?Q?odZNWmnU4sVL7IlVAeKXebPe1D5yEQxvFY6O3v6vr/HlLz6RV5wjL+nejkXd?=
 =?us-ascii?Q?SD/OHx8k4yGbTyJALODdeO/KKiIdtOP70nWlFM08ADfLdVZPsvqtxFCeRWqx?=
 =?us-ascii?Q?CI+XkaoHU8EY0Vxr8H1Ddi9WYOr1RHGD4B5X5zogdWRMNDcS1mwwWNzt/bua?=
 =?us-ascii?Q?B0ZXyMNZKWNOBgIZamFNkrn55ChXP6oD9lrBH6sl3ezvA96sZMhlsXz4eQ3b?=
 =?us-ascii?Q?BbagBxtJRYOYrmUBJ1NKvzgrVQOAHtM+THCR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:16:46.4375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ef34b4-bcae-4dd1-ab33-08ddf69c7939
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141

devlink_rate_node_get_by_name() and devlink_rate_nodes_destroy() have a
couple of unnecessary static variables for iterating over devlink rates.

This could lead to races/corruption/unhappiness if two concurrent
operations execute the same function.

Remove 'static' from both. It's amazing this was missed for 4+ years.
While at it, I confirmed there are no more examples of this mistake in
net/ with 1, 2 or 3 levels of indentation.

Fixes: a8ecb93ef03d ("devlink: Introduce rate nodes")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/devlink/rate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 110b3fa8a0b1..264fb82cba19 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -34,7 +34,7 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 static struct devlink_rate *
 devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
 {
-	static struct devlink_rate *devlink_rate;
+	struct devlink_rate *devlink_rate;
 
 	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
 		if (devlink_rate_is_node(devlink_rate) &&
@@ -819,8 +819,8 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
-	static struct devlink_rate *devlink_rate, *tmp;
 	const struct devlink_ops *ops = devlink->ops;
+	struct devlink_rate *devlink_rate, *tmp;
 
 	devl_assert_locked(devlink);
 
-- 
2.45.0


