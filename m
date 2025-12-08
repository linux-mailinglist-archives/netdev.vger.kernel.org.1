Return-Path: <netdev+bounces-244002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C0CAD181
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 13:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC33E301511D
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148932D63E3;
	Mon,  8 Dec 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qd0c1F+o"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300728C014
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765196359; cv=fail; b=p4hiUSyS5KhGQyBweDxzI50RH7SvC2IpJOkdLfPZnOD8YnG63z6arMKntAVrcRfzBNYeU9i6/uLORKaqTgelyRGK/g5dEf3p2busy+N2xeoobPbE6ovH+NcTvWeQxw4ZphHqVqDh1f1VI+mwClqXUv1qqjYpBK4p4sxyh/Wba5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765196359; c=relaxed/simple;
	bh=rwWGAse/uehNLRbG/NJ5kGtTbDolkKeBFZ5eF1bZELs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+9EaB2p1mL4Eyk7MKhP5YIpDt8zR9+mOYJAVzZAwRVZ+ChTGxbxDlPmQaTK/7lPyfYsyEzdfZXW6dcwdpOxwoTMDMLSOQWJa0ut17WDgQta9sU1HUticRqjyxWtA0Oa7yO/ahp0M6FgQocAVao17Mbdd3JOHY9xQfkSHtVsGBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qd0c1F+o; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkZSqibq0fJpqyOG+RMv+yrzEPt8luEnitkkA52FOIdLt531HqeBT13NA0+/v0T+oj7lworZPtev1BHPKmRTA4gAmziRCeKNjWRPq44nUA6ZAvaE5ShVkZLp/brsWZHwi0+fu42oF0cGeY3T/+OTi4KokXzVLbJxvKtVjMHYghrZEjNtgUywoXvaf4KShtTagmKaZxDDNGb3bxh6d//hjtwzwxgyvNtOHahvrPQTyIwtJUX3qvf05pWTGJ28MKP1l4+M/BhIaGIheIkJnvKHTJLbTk5Y567e2/EQUKPRYR5yhaOndlHVO5S07nG6CFYHW+uRr779PJqaa3YCqO0t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mdap1nXyXtHrT09web4eaiMkyr9DqHNY2Sc1wnyPow=;
 b=B1IhuLDyhSe9HvjWNNVb0maE+TwRpHTbtWY8cgjYAP+5PVxGW1i/O1MH1L7wTVni7lye9CHdEcRQ/JAFk1wm0cYDXtTBLpyaMP9DfCGKR+8zzc0u0sAHMgxgIrnPqX52aw4H1eVcFcXM28uyCE6gPSjJ38sjSe0i/jzRLHnh6i1pRVw+znT3vvErOh+rgFsorzw5GIiH9MIl/NGoXtaRssckcpl3+w0/Sz0jqWAJ7NPdY4YBPgWplcOdSeumvwHpP1tZWwTiaUtjJaZRwKH+rEcwf/Vv8vJSYzcILONQnm0E51UF1+deNpVfoPupxJ8Q1z0poocN8+PTWRN2OEkONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mdap1nXyXtHrT09web4eaiMkyr9DqHNY2Sc1wnyPow=;
 b=Qd0c1F+oRvK3dipalNRj4vGL0bN4B1a0AH4ZoxlAmb4zZe7BxDY4Nn+NpW3ptssXIW/aU0ogaWXaV9Mi0X1ubva7Er6UMGJL4Nh/6kblgYuKvzl8q5Gr8A8d7S53OJLWxQOIu8QHAVZ7/i+2/fS72WRvijb7DpsAaeptcWLNOmX3pQk5gN7DxbXxeBcFKK1YJnEeQxzc+/00UT49YQqQ0uli29zyN+ESzmZM/ALLhL/QnFCNfWc6mpjG7TaSh8o8gi9OHFrxLi+CIsnI03wzfWAIGNkyvRDPSdDENjwdmFE/f21K6yAmmGGdycLlFjCrBCYeDtm894XnwpMb2wZXWQ==
Received: from DM6PR10CA0020.namprd10.prod.outlook.com (2603:10b6:5:60::33) by
 LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 12:19:12 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::6e) by DM6PR10CA0020.outlook.office365.com
 (2603:10b6:5:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 12:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 12:19:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 04:18:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 04:18:58 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 8 Dec
 2025 04:18:55 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: [PATCH net] ethtool: Avoid overflowing userspace buffer on stats query
Date: Mon, 8 Dec 2025 14:19:01 +0200
Message-ID: <20251208121901.3203692-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdb4bd0-f0eb-487f-15fd-08de3653fe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POLJseGZCj5We/0SrXS/DVaqGpNbqH86XLiLP5ZKfS/Bbgu4HWvOckcWBcqu?=
 =?us-ascii?Q?6GiU1RYsi3MJqIx4fFwfGktJbl1dQI+gDkM4vqy9i8/H1JDo2ZkTKeGxO8Xp?=
 =?us-ascii?Q?FP9V33jzzoVxNLd0JbHabX3z7bTOmF/rZgYsy33yTeDaE9bMnIwdAcIbHK6J?=
 =?us-ascii?Q?8ljCMFMyhgoJH1e3MA151LLQz6z6usPZV5n3YLlIHF0xiba0GGg9++HlYdBe?=
 =?us-ascii?Q?zVWrBcs2xTbZ3CR/+EFT1tshJR1KnXHFO6KL5gNPVtxzMryZOBv7YCV/fIdN?=
 =?us-ascii?Q?ti+DFN5iLKw8czcsOJBS+qRDCvHf+IZPsF86zjUev5sm8AP3RYbV54UMkpeC?=
 =?us-ascii?Q?CDaEbswf8YyI6LaiU9SEcKjbaO/6f8n9kHQQ7Eyvj4nD+6muMbkWxydDv/ML?=
 =?us-ascii?Q?Eq1vibm0RR403Zv5SLpDa0km6K/fTfjR2JVDDy/M9cbCtnglParOnxepsf0g?=
 =?us-ascii?Q?Ch+EVITjQR+yTMQDEN+muNZJVvl1PJjkozQ638VFzgK7m8kcyLP+lwYmLw/0?=
 =?us-ascii?Q?HcY1/x0pR36eJsQ9e07pUc57ix6t2mnTxzrBiCXKpMAwFHpPIKlLtoRD4yYb?=
 =?us-ascii?Q?uhyRt7PfzytCLGBXiy6w2FG93IGBY7gRp3uWyqfqzZE4cDydDQ7MMzi4a3/b?=
 =?us-ascii?Q?tSBgal/XIBkcS7GSorYIVnLsphabRpfL8TJ+lLXXK9NbpU8wkZPtY9HzOYDN?=
 =?us-ascii?Q?tU3EBwJM0Yiu1We5ezj1ympqOdcLv/mTeWTeCZbblSyr0X2O0Mi5lcb6gBX/?=
 =?us-ascii?Q?zNaAUP6Yj0pF/c9HAQCkE2jgFKBqx2ZJ8FaYeYihO0QerHv80xPkoK+iINh/?=
 =?us-ascii?Q?wx1RSIlubjaKsOgzRNf36/xRLGEYLfeGHSMoq0YMkRPDTWDs8yXJNzx37Eb0?=
 =?us-ascii?Q?bLfHAB3T2d494ovAC9MsEZzI1Wi8Yu0D0/fk7T9M8Y3LyUnKR+c2nFBbIsvR?=
 =?us-ascii?Q?0AlrQGq5X/3dk0PuDWsbWb15VnJvK9KRW+r6AWlZVaG7nGvmGr/yktDoUWC3?=
 =?us-ascii?Q?/TllvjoFUxMl1m3rZ8Ks/sY1A3vGj1c+cVI7C9zR5H7ia4NWaOaFVu/jeAVv?=
 =?us-ascii?Q?b5oZ1EwJKdDfh7RVxMeDLEVNjXllb/FrQoM8G0VX0upiUUrjrj/+OHGvgp/c?=
 =?us-ascii?Q?MYKIdjTBzjoD+dKyZMK0x5a8PCB4V/JVs27iY2XA7fZE/p/K7GEO7EdH8fiH?=
 =?us-ascii?Q?UPj2jUfS2ONMeD9T5JJRCdqfgdEGWyh4hwAEL48nCk4UN/enkPBsJohZ4Buk?=
 =?us-ascii?Q?fsbSE1VH+2CEpLxJmLgjg3DppGPp9xpGSimymf0bhk6lG93IwBr+FvCeu/9m?=
 =?us-ascii?Q?1BJp8vt2YdAfSjEIMopWU/Wt4Rmf6yCwMDhJk4IQeI6dDAGW9FBkrrd988AE?=
 =?us-ascii?Q?ne9HzQV+DijyDtv7ObfcHEWof+biV+2ErdWm7YGHT68jN4/R/ZHNB4nbAZpT?=
 =?us-ascii?Q?uv2t1klZI7i+ZcSWl3L6zW0nzGPtsiSHuA4d5CI5a8p77ZsmtBomJm5r5jUo?=
 =?us-ascii?Q?9xUr2yLJDZzdSXp3czM6JGnbmvoRo2MYcNb9XYq2ijf0CpWliR8sYIMZFAtO?=
 =?us-ascii?Q?Lfsc1C7jpcq3IL92cbA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 12:19:11.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdb4bd0-f0eb-487f-15fd-08de3653fe94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

The ethtool -S command operates across three ioctl calls:
ETHTOOL_GSSET_INFO for the size, ETHTOOL_GSTRINGS for the names, and
ETHTOOL_GSTATS for the values.

If the number of stats changes between these calls (e.g., due to device
reconfiguration), userspace's buffer allocation will be incorrect,
potentially leading to buffer overflow.

Drivers are generally expected to maintain stable stat counts, but some
drivers (e.g., mlx5, bnx2x, bna, ksz884x) use dynamic counters, making
this scenario possible.

Some drivers try to handle this internally:
- bnad_get_ethtool_stats() returns early in case stats.n_stats is not
  equal to the driver's stats count.
- micrel/ksz884x also makes sure not to write anything beyond
  stats.n_stats and overflow the buffer.

However, both use stats.n_stats which is already assigned with the value
returned from get_sset_count(), hence won't solve the issue described
here.

Change ethtool_get_strings(), ethtool_get_stats(),
ethtool_get_phy_stats() to not return anything in case of a mismatch
between userspace's size and get_sset_size(), to prevent buffer
overflow.
The returned n_stats value will be equal to zero, to reflect that
nothing has been returned.

This could result in one of two cases when using upstream ethtool,
depending on when the size change is detected:
1. When detected in ethtool_get_strings():
    # ethtool -S eth2
    no stats available

2. When detected in get stats, all stats will be reported as zero.

Both cases are presumably transient, and a subsequent ethtool call
should succeed.

Other than the overflow avoidance, these two cases are very evident (no
output/cleared stats), which is arguably better than presenting
incorrect/shifted stats.
I also considered returning an error instead of a "silent" response, but
that seems more destructive towards userspace apps.

Notes:
- This patch does not claim to fix the inherent race, it only makes sure
  that we do not overflow the userspace buffer, and makes for a more
  predictable behavior.

- RTNL lock is held during each ioctl, the race window exists between
  the separate ioctl calls when the lock is released.

- Userspace ethtool always fills stats.n_stats, but it is likely that
  these stats ioctls are implemented in other userspace applications
  which might not fill it. The added code checks that it's not zero,
  to prevent any regressions.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/ioctl.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index fa83ddade4f8..9431e305b233 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2383,7 +2383,10 @@ static int ethtool_get_strings(struct net_device *dev, void __user *useraddr)
 		return -ENOMEM;
 	WARN_ON_ONCE(!ret);
 
-	gstrings.len = ret;
+	if (gstrings.len && gstrings.len != ret)
+		gstrings.len = 0;
+	else
+		gstrings.len = ret;
 
 	if (gstrings.len) {
 		data = vzalloc(array_size(gstrings.len, ETH_GSTRING_LEN));
@@ -2509,10 +2512,13 @@ static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
 	if (copy_from_user(&stats, useraddr, sizeof(stats)))
 		return -EFAULT;
 
-	stats.n_stats = n_stats;
+	if (stats.n_stats && stats.n_stats != n_stats)
+		stats.n_stats = 0;
+	else
+		stats.n_stats = n_stats;
 
-	if (n_stats) {
-		data = vzalloc(array_size(n_stats, sizeof(u64)));
+	if (stats.n_stats) {
+		data = vzalloc(array_size(stats.n_stats, sizeof(u64)));
 		if (!data)
 			return -ENOMEM;
 		ops->get_ethtool_stats(dev, &stats, data);
@@ -2524,7 +2530,9 @@ static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))
 		goto out;
 	useraddr += sizeof(stats);
-	if (n_stats && copy_to_user(useraddr, data, array_size(n_stats, sizeof(u64))))
+	if (stats.n_stats &&
+	    copy_to_user(useraddr, data,
+			 array_size(stats.n_stats, sizeof(u64))))
 		goto out;
 	ret = 0;
 
@@ -2560,6 +2568,10 @@ static int ethtool_get_phy_stats_phydev(struct phy_device *phydev,
 		return -EOPNOTSUPP;
 
 	n_stats = phy_ops->get_sset_count(phydev);
+	if (stats->n_stats && stats->n_stats != n_stats) {
+		stats->n_stats = 0;
+		return 0;
+	}
 
 	ret = ethtool_vzalloc_stats_array(n_stats, data);
 	if (ret)
@@ -2580,6 +2592,10 @@ static int ethtool_get_phy_stats_ethtool(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	n_stats = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
+	if (stats->n_stats && stats->n_stats != n_stats) {
+		stats->n_stats = 0;
+		return 0;
+	}
 
 	ret = ethtool_vzalloc_stats_array(n_stats, data);
 	if (ret)
@@ -2616,7 +2632,9 @@ static int ethtool_get_phy_stats(struct net_device *dev, void __user *useraddr)
 	}
 
 	useraddr += sizeof(stats);
-	if (copy_to_user(useraddr, data, array_size(stats.n_stats, sizeof(u64))))
+	if (stats.n_stats &&
+	    copy_to_user(useraddr, data,
+			 array_size(stats.n_stats, sizeof(u64))))
 		ret = -EFAULT;
 
  out:
-- 
2.40.1


