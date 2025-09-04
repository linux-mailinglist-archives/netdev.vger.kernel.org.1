Return-Path: <netdev+bounces-220061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F321B44573
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CAE7B228A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169B342C99;
	Thu,  4 Sep 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuszCFXf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33098319861;
	Thu,  4 Sep 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010744; cv=fail; b=Mc6ZVJpeM3PMfROsX59Yrd7GaCpLHAq+Q2SUDpSYyGVQQQDL61EXDZU7FX3RS21/dkY97Na1eCCDK+nQDMbKfq1BJ+TVW1FsxAM+rXddy89Z1Nlo0qQVUcGqlLhFljiuwC9aryxwjkV1ic2RsoZf9VrEuXKEsbMkmnovzhoAeyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010744; c=relaxed/simple;
	bh=DOp9eKAppWZSRBEvkU8P5sxdO32HmA8kUQ/KDE4styA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BF15TqbQkR0x4gb+fiHYIyqcSe1j0B0pMl3N48w2iHw5VX+iCaUguJ0c9+Dz7Eicq2JHjEr5CGtBXq7gLExUQm0vSPfvcDOjFsdUm25WGnf9DHb+lOnx5ob6BewkskawyAkOvBp2DJHnzNZHFUK39o6peOeWmWHzs+XMspyktH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuszCFXf; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+KQDVLVpYiSny87Lh+SwYT3OfDhnHvOCcbPAAV6KWhp3HY022Hkvo7OogNghUzpEM3WwuQSL4hQism4cavGQcqVJWg+eMa3wYGq5noLBr7ivTmtYb9GSnqvFk+eBXEDm6IFbdauv7YlFvdfgu90eOQtS+ZqsZOHwGyugNV409J8xNZYXt6+MVda/pUK+LsZSB/gA6/wMCCup+2pR4CTfD/35hmOXWBHyA5zMcv2qYI5/OX5ujPEeih6xxCJ9mrT/D5fF4i5pz5u5NaplW8pUgFOWYaM4RH/z8LEXrHSh860mu0G83dGdroat0yiglcmdI91a3o8ElWCS5KZPFcSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HRVAsF3zrss498QiKgI9lbZtwa2ZhPt3SCJxxxnDTs=;
 b=f+H+GvVrHlHkQXunLIKdwi5zjAxSn/UWwFaOMCEK7Jf1i4DEaLu0aDLyG1jhmrfVwKBhColTpXltagGVJJAHqgx9CS9bbdSlWZlFFHQ3ghIwTcMlv5i+81dUY8X74J3NoRX9mCDF2Q8H3j4Tb+rvcpMqQgiXacl0CzUo/rdIdSvSfj/N69OygvS+b1lATmJm0IbjeHLJxv1V1/cD9KZn6htBmCcbAzWovQb4+M4G+jNZogLHmsAGl/quVJOjZp7YDeff4+Qh2sMlE56xnwU9cx1pBz56SVO4jv0w7u5xGGSkBtR9SQLUoHnPGAJ6Yl+LF+zFXTQkOj8eLJW78DicJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HRVAsF3zrss498QiKgI9lbZtwa2ZhPt3SCJxxxnDTs=;
 b=QuszCFXfeddG6jcNOqYCYyov2tMQorb8kgMsqonKvVgN4OYeiyrfWBw7J6tDfPZ0Us7OGtj4sWxR+qi+q5/D26JTMjXrK91harnBwpHq1Lrub2lgkX/hGZocHt2oJqpfVJzYP7DQtBjWPg617VvjgjtoAnpg7eUMo3wJD38NQEJG/DBU334Cv35SyKTgEuiiJCXVuydfZr0ErJvtdSGxdSA4P6U35o+fQNRx4fMthQEMEDeS5FdB4WT5R10XWyyaQQagNH50gnXSa2H3kYRaqMpmpaH745xgQ3PxtlPHMCHBqfazcvxmAIttlpwtgHolLR1Bgdy05krvYLT8Y9/N0A==
Received: from BN9PR03CA0222.namprd03.prod.outlook.com (2603:10b6:408:f8::17)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 18:32:19 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::45) by BN9PR03CA0222.outlook.office365.com
 (2603:10b6:408:f8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 18:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 18:32:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 11:31:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 11:31:56 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 4 Sep 2025 11:31:53 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Kees Cook <kees@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net] net: dev_ioctl: take ops lock in hwtstamp lower paths
Date: Thu, 4 Sep 2025 21:28:06 +0300
Message-ID: <20250904182806.2329996-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 20449c7a-fc75-4130-df1d-08ddebe16137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AoAimS9CvJ9yu+E5UpYpp13ugeFHXHNJscRI/tItlaN9dEuIjpgEQbPpmeT5?=
 =?us-ascii?Q?fWcUv5VqRAWJdBsmv8/BgogrxFGmkTereXZJWCzaxO/jqRj/DISV2RDPNhu4?=
 =?us-ascii?Q?+zAhwvwSCV70NoLvgrBkYkG1fsSMx9GIsC81OMEkwYo+pyDW5sfb+85VSzik?=
 =?us-ascii?Q?t2FU0JkvoZm+VqFS7uyZSvMuKQlkdiwPrYVBU0xmxzyLUYzdiZ3CIHq1lcPS?=
 =?us-ascii?Q?/XuM+ADnntOI2Pa/ITpvSS9Bxr8Blc4Da9XW5r8pO3+hUFW36O4gKLbW8g3L?=
 =?us-ascii?Q?FAdtnkdhS3eG8mP0NxkTjjz8IhPLNbBIB3M7YDcQKs4s2t5QrQ53q112i4Hf?=
 =?us-ascii?Q?3HAKqkH1YhYpT/G2SUcClWTt9IN0RS3Y9Q9NdwCa9i1MnM7zEOom19tdNMtv?=
 =?us-ascii?Q?trqXBPibsFqPjGxKTx9KJFQJ4duFkTXIGMCEImSM0D6KtmN3Qs5QH4drsxy1?=
 =?us-ascii?Q?Z/2ZxgNaDZWpojKB2AwcJhgKOY9H3rrlRZhry4t0BL4c0E1M3DCCekY9jGbk?=
 =?us-ascii?Q?E0QT9hFh+jugOYs4Od837LW2Rt697oNeVoWbANzp6xcVAauzScY7NbN7EBgW?=
 =?us-ascii?Q?dwDky/DrDwZwGlRRE/I3AvWxJGoOlMVx879hX7RyPMcPT1kVHxNiPWGuCQTd?=
 =?us-ascii?Q?i+Uv+RuIvqbz68Dymyo0HjBVAE1kCCcCvyt4Zxut7BSw18p6T7JrHWogQR54?=
 =?us-ascii?Q?TlKVzbhl6ae8h4E6/L/jZGp9gWCc5958yaZxC1pwT+DnvD6UcGfFv9965y8c?=
 =?us-ascii?Q?cUWtdEvQLB7xM+9PWl9kwf/zDcZihBRC1qWHSzB1PUhA0UiJZefIySa4KtCy?=
 =?us-ascii?Q?DS1H5Qu4nn23cwy8UUvZHTW9l9GYaIJL/84QL0myrncBT7uc0+90+eRslWxm?=
 =?us-ascii?Q?ncHwreQYRkgF4F9OpMzmNIrqwMWbnTb769OWrhF24hDNw8wL8MXy2FITVDFG?=
 =?us-ascii?Q?knDX6v0hvtUSGzhBQTenHG1yZciO/qtqR+UWKWGQCEvR/j2vvBVV/v8MDrRI?=
 =?us-ascii?Q?aQD7z66BmoMf/vea76oVLIwZdX/UnhK9NrCIybcIZHp8dbr3dV/SI4Ka8kUX?=
 =?us-ascii?Q?9yIhjxsF1EPQ70nrOWzGM8Pule3mInpu41+knVHMOypYQjbXmkE+Oy6Y9B1y?=
 =?us-ascii?Q?w5c/hr2AjjPKgcsOiz+e4GfQP/gvycaGi1Y3A9LHe1YGsXQ1rVb4Xh4KULmr?=
 =?us-ascii?Q?zkC3mXwbv9J/4euAST5rM5dYZkAjgDv/wFzDxxO54o2gzUZ7oslOnnKkS0Ox?=
 =?us-ascii?Q?r42KWrDcLE7A7zK6JvUbn2pnKGYizVGOAww/h5fuaQcQlqtlGL81IWcje/ea?=
 =?us-ascii?Q?Y+CdQOfW8Yl4wxxNaqrvy4qY6/hHtvMMo+HraJBwBHw9QzDL6hVaY7BQ0reH?=
 =?us-ascii?Q?3JHqA+Sf1m3GKiUejaygWHNymlyx3KVD7a7tOlbaXsaYZNa72COEL1w9tip7?=
 =?us-ascii?Q?y7Qf9n48vAJ3EHClgLk7J51VY84sJu7qZI9RdWhA+Onp1W+rJs9l2nYisfQF?=
 =?us-ascii?Q?CB4bMPS78CuS0SBoVNpFxcHKJUWBw2XUy7Kz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:32:18.5848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20449c7a-fc75-4130-df1d-08ddebe16137
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994

ndo hwtstamp callbacks are expected to run under the per-device ops
lock. Make the lower get/set paths consistent with the rest of ndo
invocations.

Kernel log:
WARNING: CPU: 13 PID: 51364 at ./include/net/netdev_lock.h:70 __netdev_update_features+0x4bd/0xe60
...
RIP: 0010:__netdev_update_features+0x4bd/0xe60
...
Call Trace:
<TASK>
netdev_update_features+0x1f/0x60
mlx5_hwtstamp_set+0x181/0x290 [mlx5_core]
mlx5e_hwtstamp_set+0x19/0x30 [mlx5_core]
dev_set_hwtstamp_phylib+0x9f/0x220
dev_set_hwtstamp_phylib+0x9f/0x220
dev_set_hwtstamp+0x13d/0x240
dev_ioctl+0x12f/0x4b0
sock_ioctl+0x171/0x370
__x64_sys_ioctl+0x3f7/0x900
? __sys_setsockopt+0x69/0xb0
do_syscall_64+0x6f/0x2e0
entry_SYSCALL_64_after_hwframe+0x4b/0x53
...
</TASK>
....
---[ end trace 0000000000000000 ]---

Fixes: ffb7ed19ac0a ("net: hold netdev instance lock during ioctl operations")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---
 net/core/dev_ioctl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 9c0ad7f4b5d8..ad54b12d4b4c 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -464,8 +464,15 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_get)
-		return dev_get_hwtstamp_phylib(dev, kernel_cfg);
+	if (ops->ndo_hwtstamp_get) {
+		int err;
+
+		netdev_lock_ops(dev);
+		err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
+		netdev_unlock_ops(dev);
+
+		return err;
+	}
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
@@ -481,8 +488,15 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_set)
-		return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+	if (ops->ndo_hwtstamp_set) {
+		int err;
+
+		netdev_lock_ops(dev);
+		err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+		netdev_unlock_ops(dev);
+
+		return err;
+	}
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
-- 
2.38.1


