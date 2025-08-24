Return-Path: <netdev+bounces-216282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E2B32E52
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EE4243F0B
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B70F269D18;
	Sun, 24 Aug 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJmTFbdV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3925C708;
	Sun, 24 Aug 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024846; cv=fail; b=GOu7DgbcJKlptPGta8W2v3ZiD3m3EWYvlXtY4H9coEkcOkIstGk0Tqx0f0SbERcoBSOiHeR4CFQXlBbh+eeI23fxZJrFsg/SmKQHQxfG8N8KiQTtTAcfowjFrhrCrXw7lRLIUBaNTc2Ty9uK8kMGju0St2TGhprx7b2lzzhuOsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024846; c=relaxed/simple;
	bh=w0QXiYPS6TF929WR+2Lk16OYMVHSl4CqwEr7n0VeJlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArP+kTK2GEKzpu5xfMJzK/1P8CV0e2ltamdQZBVe/zCKaOoVxrRePMCwtGPO0ak5BO9o/pXkc0QkfBV8/4yWcIWPeSLtfl3RDS3JZFCIyJhqpo0S4jR4e48/ZiUuJYw3jcBufluhrIt2Y0qsLiMr8MpYtzK6d1xOZixY0nhYtoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJmTFbdV; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lde+TTAJf4SkUhui/8cde1fZtHVGCQR+ohFfbXtp0K4hY94SyFZYdAoEJw8NjAueMpfHnOlG3sqZ97uw8z4N7OC0jp5rr+26vamWoNBgdBOwN0LsPkexfVc00an6NRB4IpKK9EBgTajZ8/5+mgIsQBsF2WxAbLeTn82wA5LTSLSL8uUUSi8tq6uUZSr/55ZMoQhDFddbUIapbbMBrRbcY3dj2q7byPis9Gvv1fn+oThlKq8YFtj5ZRQ01Q197rDY9LEWaFSXd70kqt9DzeksJNLy8CxWCb9NFXmo4B/mp5CtB0IsK1007TxNa/PUMnij1b+iVkAUBopbQUB0lCZ5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gWVaM0Ds6JBQTgNWbkaYrwFhR9FbkGnYUhsGnpIm4Y=;
 b=kPBjDQShzZ8vZJBY98dC8e8WhS+YAxsqRlV3KJdQ2eDBOO4p8v6HVyGfFC7hnyL8zk9ytMmat+nI2fk9mX59SzsARaSVxW67RL+dPKxJu+XKnuYPzRTV+O0okab4b4fb5fdKQixqm+d0yHTyIdPIez7qtiZoOLNbxn2lORg28ZpfzC5Hak0ZyQ4Z7MPgVPf6C9PTQ0MYxExRRrVitI9HMgHlizREt7/Zbu8Glgpp8+Etdl8S9L4gHTxwRNLBe/ruaHy8m493vSygFCRtmaIQnZs427nXoV/9FZmwo7P8GbQmgLg+B0jfem7HFqeqsERQTVhi7bU4GYImSbAGkLpVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gWVaM0Ds6JBQTgNWbkaYrwFhR9FbkGnYUhsGnpIm4Y=;
 b=bJmTFbdVYZUP0R3KrEOUjAiMqO/jyb3qXiGKKger9HL3TduYXDHEfn/CWN9jlJB8V56J+8dbCjzm/UwQrscb+m74Y6ZjDUb95seVKqH12PrgwKSLT+M3tWiqdJcdGw9UKHAbPnV+UQKS7xbkCckFk6ZLsWP+rtzA9/9peNUKG8WWUe1zii+QEiSqjulRLJE00dEL+TM8h/S1oClOYIxHVmMvKdyPDGrcppco9/mdhTWn+qAtZQh32grUGZyjy6s1Anr1j6b9YLhyJg9dvNODRonEpOcI/7R2oaqrkllFZ/Y1LqTF9B3uL0pc5HfXdoDoSTWc5b8HbrMuCVuAfnhnoQ==
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Sun, 24 Aug
 2025 08:40:38 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::57) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:20 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Parav Pandit <parav@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 07/11] net/mlx5: Nack sync reset when SFs are present
Date: Sun, 24 Aug 2025 11:39:40 +0300
Message-ID: <20250824083944.523858-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed5d553-55a5-40b8-2dbd-08dde2e9e709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvU36WoTOJ7XVkZQaOyU0vCjk0ZZY1VK80NeWukrN2rnO7CFlRGXJu57Yrux?=
 =?us-ascii?Q?oKCweKR8ZSPyqK5KVkdw538X8l7GOzZ9cO1dgGpYTPwAIWQw/vyXcFsUBF11?=
 =?us-ascii?Q?JX1PNhkWlrTV3lPaGlx2OnwkEbGgg1hzrTljf2Dfk+vhAjW0jtY1eTL94gI3?=
 =?us-ascii?Q?qe65tEw4raP7c83Dh6F6soO8otuXnaVXZu9xmVUbj6xmvl2etEMX98bh/cmg?=
 =?us-ascii?Q?/vPLzShy7weFH0LMx/VXgTUhHjFh8mXJWwJSli36KWr1nHlm4i0xAZQejCwj?=
 =?us-ascii?Q?aUsRVuDdA0uddsJcFmZ75sgEhL7WJV9M0/3fvdVF+9OsmhHjmrt01MBXOwS9?=
 =?us-ascii?Q?FeEkeaSK2DSbnB04KPWiljbA8weYQB/xYr+52fFBZSNqVl7Ru9uG9Z0cxWBk?=
 =?us-ascii?Q?tpYI+XboFsQy9DebPOOE9KeHRpVhasO0HrXye5cgDypVgnvPdC/POH+fnwBJ?=
 =?us-ascii?Q?GQ6sB/GPShc1/jadU09y2QSUXJ+LCu4E1OS751Q69/TEEy7kPrxS362DrV6C?=
 =?us-ascii?Q?6yFbqgBcgQ2awua9AvEscEecQwXAw3HDVrqjeVWEeYmbqiI45cfRyUJu8BeY?=
 =?us-ascii?Q?k51buQecIo83L0uODMnGxZmH/KS4z9YKNM3XWbQJk9Vim5YsOcgT6aEWoeOB?=
 =?us-ascii?Q?NTHjqjzvdt4/34Af4lbysyseBoJiKfB7slh7L6GQVNN2FKabPMbQe+YMJr48?=
 =?us-ascii?Q?5gbWvyO2z+xbZ6CEmcPmq79xTAKP+DXAosW4ui3zy+4xRY4QACuKdhJ20nVh?=
 =?us-ascii?Q?Ula8396tJ3S+SHqs/APMyIdBGlPyTZ6wNoCeRWENsQ2p6Y/JFdEaoCUlQfJH?=
 =?us-ascii?Q?KeS5gWcT3MGWzQq4MJ5SmFzwaK0hXbLrzHyNm183onziAsFEc0ZFYHBaSADJ?=
 =?us-ascii?Q?mTUxl6YJqFrpEPN78RLckqrpbHypx8sfqLzXMRSayYo6xHr4OI439u7vu6kq?=
 =?us-ascii?Q?zvGURm2bkSP8U4TAu+MxxEi5uJ6jHib9QG/4sE41WIrrTz3rvME9mDUZgvaF?=
 =?us-ascii?Q?4Pr4Ex/5lOTAhmtYQyXz9BmM7SfFUi169/6YZmK1DcdzRl8NLfBWEof/TU+i?=
 =?us-ascii?Q?Vv1b7Z8siNT9aMibx+emAspWCPZ7QLBs0UL2SMGI8R/ZDg7I7w1NiQBtqcOR?=
 =?us-ascii?Q?2hLjemOUCVb+WHxfqnjNbOEiffZ5q440vPH3C+EbPXs1PXuPuzkgvHuOYJTi?=
 =?us-ascii?Q?JUJnXfxmi3uuvAPzNv8Rx+RFsl6B6uqNC/jRmTap4jykO6jtGujUCenG5Xyo?=
 =?us-ascii?Q?le1Jf7zaJsEzas5Pf7NRW/DkL0w2daj0fiiX8UX05o9R/qDWqD0X5ApCW3s+?=
 =?us-ascii?Q?4UV1T6OpLU+5376lH8/YSIM6xK2N4oJZEWqRZDy/gs06uI+y2d+0CgVp5TLI?=
 =?us-ascii?Q?4KtOO9QQHGptFY9ANlsUXtfKTY354ttvYODYXVzuz2ZVkh4gdZT3MK7YH5wr?=
 =?us-ascii?Q?kNXgRlL+UimItRBoNhDoyVHVqUyJhB6N/LcIaOSiYiTIW6vr2RIgYSHPlcTD?=
 =?us-ascii?Q?It3y3F0BPfHN09zWEtXwxjssU8ztZp/OhZNT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:38.6122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed5d553-55a5-40b8-2dbd-08dde2e9e709
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000

From: Moshe Shemesh <moshe@nvidia.com>

If PF (Physical Function) has SFs (Sub-Functions), since the SFs are not
taking part in the synchronization flow, sync reset can lead to fatal
error on the SFs, as the function will be closed unexpectedly from the
SF point of view.

Add a check to prevent sync reset when there are SFs on a PF device
which is not ECPF, as ECPF is teardowned gracefully before reset.

Fixes: 92501fa6e421 ("net/mlx5: Ack on sync_reset_request only if PF can do reset_now")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c   |  6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h      |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 38b9b184ae01..22995131824a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -6,6 +6,7 @@
 #include "fw_reset.h"
 #include "diag/fw_tracer.h"
 #include "lib/tout.h"
+#include "sf/sf.h"
 
 enum {
 	MLX5_FW_RESET_FLAGS_RESET_REQUESTED,
@@ -428,6 +429,11 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev,
 		return false;
 	}
 
+	if (!mlx5_core_is_ecpf(dev) && !mlx5_sf_table_empty(dev)) {
+		mlx5_core_warn(dev, "SFs should be removed before reset\n");
+		return false;
+	}
+
 #if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
 	if (reset_method != MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET) {
 		err = mlx5_check_hotplug_interrupt(dev, bridge);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 0864ba625c07..3304f25cc805 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -518,3 +518,13 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 	WARN_ON(!xa_empty(&table->function_ids));
 	kfree(table);
 }
+
+bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev)
+{
+	struct mlx5_sf_table *table = dev->priv.sf_table;
+
+	if (!table)
+		return true;
+
+	return xa_empty(&table->function_ids);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
index 860f9ddb7107..89559a37997a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
@@ -17,6 +17,7 @@ void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev);
 
 int mlx5_sf_table_init(struct mlx5_core_dev *dev);
 void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev);
+bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev);
 
 int mlx5_devlink_sf_port_new(struct devlink *devlink,
 			     const struct devlink_port_new_attrs *add_attr,
@@ -61,6 +62,11 @@ static inline void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 {
 }
 
+static inline bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev)
+{
+	return true;
+}
+
 #endif
 
 #endif
-- 
2.34.1


