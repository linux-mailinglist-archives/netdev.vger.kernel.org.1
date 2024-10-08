Return-Path: <netdev+bounces-133274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF19956AD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2353DB27AB6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7D20FA85;
	Tue,  8 Oct 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rX7koj/f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC6215F47
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412444; cv=fail; b=HeRomd9DxeYWdi2Tghu1nV4K7r1xLfJ6lrX31MyEu9UqcTkh03GasLJKAvSBRoiU75FB0l2ClveLqEIn6ZZllSSmte0PNE1IX6lq0UvjnVCvA8A5peISi7Hg3fbZNKLAUpDBKnVcOIqnY0mdLATvsy9y7H7zVGabIkE/XR0M8KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412444; c=relaxed/simple;
	bh=6OMkpsnz6PM+W4tnhIr8ZaDbmd2gAzN7iBcANUpdMVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmSZhXVIEX9pTaihARN5wD9AmDVYGYh1hbv4Po5Z1y099iEVovAVN0HcOfkDPE+RSGRfQ14/kBtro/wlxcrn2k6ZGyv9WeYHYCoAA+v5Rmm76Y46OdigOex8Ktd/Uw0ZcpMN3CWetrUZXpoPzUFZta/i4ZaanUkgBF2VliCAYhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rX7koj/f; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rH3NTd0ohzr1KAkA0ZcXAM+bpTfsw2V0lJwVeL5LW7UbL3f3L21IcLZjAtmVCPIW3WlW29uBzO9PbhDLTAtJyD5KNvIGSBklrsY6eIPPkoM6G7hP7ZFetdr5iywYl2kMLDsKCYFrbOVyARxQo32EOav/Cjz15msBZJOWzFeqcKGAk0dy8IdgizLvkNylPG0G5TKm9BMq48NrtjJEsq3VwFJ2iScvB85BadL05E31lIecxjzn7IzdkmwYjvV+ibbTALKl43mTvzXXNMdXyQeegmJOeaDhh0Ga/BXQk89wVZS20cnPV/iAo+BLzD3KCZPDIsa94d6K6sktmK/Ll5k1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZN/yWKg1KOG821pyAddTAAi+JzDpYvHu3v4OtEI1bo=;
 b=CiX4t8OIhLkcf8zwc94LqH6coKQJfCNgrMgVItqKPnT4SKKG0uFHmQSXjouOHmaHgeVHvEszg/l+Q5oCFHs3KhgOyHgUKWmwkVzMLJ/9g6XbCxCdZgC1xGXouxIRqJVLSu2BTtx4XWKqBxeqqE72W4VlyodgRBaJwHls58/5nQeY/L1ZxLEYGeqpTT4kCwIFsWV5j6pY3hCr2Ub9Gn7v1SOAtNUyD/d1R+bkU2/S/Og8OLfEan4ZytXa8vHXrJZ8t66DgD/3BCq9b2IfqkBjbjO7JUlFhkLgiv3vGMZ61H/5k/xidexATjq2FL1yueG6WKitM24fwkmTt31UNwFmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZN/yWKg1KOG821pyAddTAAi+JzDpYvHu3v4OtEI1bo=;
 b=rX7koj/fpYUWwhFaT85gtNx5YliNT7gjPmUt3cw7jDvBxhGA42ZChci655TWLNC1r5bUrT3VB0EYmyPNmaGi3Fx+73A/Fc0r6GIXqp3zW88Rp7XfuMtAn2k1l4ylwEOeDhW2sltdXHepX4dq4ro5kPjWNHCoUugW6ttLNOhW9m9k8Pcn6OL88p47kGEjtfbiw9VcaANzqMQ2BCioA/mM163O088iNCIiR8MbV/3ZZd0pKMlr5P0RaZ+pixIdl5LjePWrnQPRlMVNRvYJnFG3jZDC2ZDuOdW+24jWlbYtHLDw+7fpJazN/j2SSzm4//qSqCKrNcGen0ogJ8iEb4BcXw==
Received: from PH1PEPF000132E6.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::26)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 18:33:55 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132E6.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 12/14] net/mlx5: qos: Refactor locking to a qos domain mutex
Date: Tue, 8 Oct 2024 21:32:20 +0300
Message-ID: <20241008183222.137702-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
References: <20241008183222.137702-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: d4aa694b-c9d9-473a-3d4b-08dce7c7c3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Va8ddxLwI6k7o0kjyRGrVj7do0eM7Zq1htAJdlnUUzIVPCbOP8PlSd1q3XGB?=
 =?us-ascii?Q?qGuTlXKbBuHQ5pgWFhN2cxhMt/Uut6ajDBYYuHcw45jxKOQA5dAWrlUAEDgy?=
 =?us-ascii?Q?7WxIUo+yGTv2F4FSGG6By+sHxP/6TAC2HzG7BAC2O+YKcnBRxAphPiDwp2Ze?=
 =?us-ascii?Q?l+yvuETpbmG0xCXYp3DebMUFWi7/qVJ5LRM9tFactuGfkLt332M3cfCy6jpt?=
 =?us-ascii?Q?OVsFynShtFlYnvlLvk0Y69b1lP3sVpVS+s7BTnXdWtWM/EtpnRm6IKDZ0Z+6?=
 =?us-ascii?Q?A9R5/Ox35ZkMTKoDlbe43IFFBWEDh8XMjHx3WlesxZ2oPn8rlswKqILVhQN3?=
 =?us-ascii?Q?tg7nZd0X9m0M8tZ5MadYyZ0VEVzG6SP66A0JxMnap0aYcgEJ4l8gAIgqiWQD?=
 =?us-ascii?Q?M5epIwkh7l/b9PfVC1cVO7UuMbJshf3HAoxIQEf9zbTSVZ6m+E7T25V/7bhB?=
 =?us-ascii?Q?SPpqWXPPAw83D3uYUpWZWCaUhthgltQDf2zlnHyRk8yHHcn+L8iQ7KLrHrUR?=
 =?us-ascii?Q?PsL2P2e/g/mTv74pTvD6K/9WP3k3m1JcG/Lp873BigR8CW1dsJxVL628jTbA?=
 =?us-ascii?Q?uP2FIxRv9BXJ7huOXCBCHYFyjahz2h75KRbJ9yOgUZJ5ONflrJoPUsl3P+e3?=
 =?us-ascii?Q?Jiu2QdMHVVvvW1h3A/vLZ1ljAmE4tfYQ/yMMj0oAY1S78WJJNDxWpF+kI/YY?=
 =?us-ascii?Q?XIHjWN9E9tUGdfNZ6ds8rn5xsv5IQJppld3Txp9mMgm/5wp2MPHsUgWmgTJQ?=
 =?us-ascii?Q?LfjfQUm1Krb7sDO5qFQhhPNla1TB+LmUbjuh5h/4ZPgQJH+WFEcWrvEMJ7A8?=
 =?us-ascii?Q?j9OynqZHixHcz2Wwg25GnF/u5J5pNtG0moN45eo8dCoL80N+WmBodZGciso7?=
 =?us-ascii?Q?D+m24AmT3GnedElgbctJSEwgxHwFBddSHqWemjzH9VKZfkiG0Rx1MncB333v?=
 =?us-ascii?Q?dpydwCIoMDzeUHBv02f8Zr8dpMa/x4R6EqAuOFFfMi5OgcG/VHA9YGctlg/P?=
 =?us-ascii?Q?PdDQ5A2BQ7Tjwf9LbTOnejqA7EFaIFcpFZnyLwpSvLPDHRFMmzEBeu/i4UpA?=
 =?us-ascii?Q?FYqtJS0dVFQ9atAlW6vAdcZ02gR12MRFFKmVIxkBBLgWynN/TgwLlnDoLtgT?=
 =?us-ascii?Q?xdSwsSde5sJSkP6IOOb493QqBT8njebvzHRzRsATAYNBkc+n3b8Oyj+1P3xt?=
 =?us-ascii?Q?N9EKMJXimnkIvymzaVks523WOcWUNxI4HxoQhsrYc19g4zBs5Tdc99XWU7fg?=
 =?us-ascii?Q?2WocRCJ3fn+MBrH/MXIkuyvL2aBk6fi0qs6RiMH5tqlBbvUyTe5Nx4uhIWKt?=
 =?us-ascii?Q?BG2f6V6z+QKQu9s9dwPAp922zVTaON9URCGyr42ICNXOAymnffrAR2I3bBpp?=
 =?us-ascii?Q?csdZq2tS+XZBwv7QF6bDgXs+CZ0j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:54.6476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4aa694b-c9d9-473a-3d4b-08dce7c7c3ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

From: Cosmin Ratiu <cratiu@nvidia.com>

E-Switch qos changes used the esw state_lock to serialize qos changes.
With the introduction of cross-esw scheduling, multiple E-Switches might
be involved in a qos operation, so prepare for that by switching locking
to use a qos domain mutex.
Add three helper functions:
- esw_qos_lock
- esw_qos_unlock
- esw_assert_qos_lock_held

Convert existing direct lock/unlock/lockdep calls to them. Also call
esw_assert_qos_lock_held in a couple more places.

mlx5_esw_qos_set_vport_rate expected to be called with the esw
state_lock already held.
Change it to instead acquire the qos lock directly.

mlx5_eswitch_get_vport_config also accessed qos properties with the esw
state lock. Introduce a new function mlx5_esw_qos_get_vport_rate to
access those with the correct lock and change get_vport_config to use
it.

Finally, mlx5_vport_disable is called from the cleanup path with the esw
state_lock held, so have it additionally acquire the qos lock to make
sure there are no races.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/legacy.c  |  6 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 92 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  8 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 +-
 5 files changed, 74 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 3c8388706e15..288c797e4a78 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -513,15 +513,11 @@ int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate)
 {
 	struct mlx5_vport *evport = mlx5_eswitch_get_vport(esw, vport);
-	int err;
 
 	if (!mlx5_esw_allowed(esw))
 		return -EPERM;
 	if (IS_ERR(evport))
 		return PTR_ERR(evport);
 
-	mutex_lock(&esw->state_lock);
-	err = mlx5_esw_qos_set_vport_rate(evport, max_rate, min_rate);
-	mutex_unlock(&esw->state_lock);
-	return err;
+	return mlx5_esw_qos_set_vport_rate(evport, max_rate, min_rate);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 06b3a21a7475..be9abeb6e4aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -13,10 +13,27 @@
 
 /* Holds rate groups associated with an E-Switch. */
 struct mlx5_qos_domain {
+	/* Serializes access to all qos changes in the qos domain. */
+	struct mutex lock;
 	/* List of all mlx5_esw_rate_groups. */
 	struct list_head groups;
 };
 
+static void esw_qos_lock(struct mlx5_eswitch *esw)
+{
+	mutex_lock(&esw->qos.domain->lock);
+}
+
+static void esw_qos_unlock(struct mlx5_eswitch *esw)
+{
+	mutex_unlock(&esw->qos.domain->lock);
+}
+
+static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
+{
+	lockdep_assert_held(&esw->qos.domain->lock);
+}
+
 static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 {
 	struct mlx5_qos_domain *qos_domain;
@@ -25,6 +42,7 @@ static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 	if (!qos_domain)
 		return NULL;
 
+	mutex_init(&qos_domain->lock);
 	INIT_LIST_HEAD(&qos_domain->groups);
 
 	return qos_domain;
@@ -249,7 +267,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 	bool min_rate_supported;
 	int err;
 
-	lockdep_assert_held(&esw->state_lock);
+	esw_assert_qos_lock_held(esw);
 	fw_max_bw_share = MLX5_CAP_QOS(vport->dev, max_tsar_bw_share);
 	min_rate_supported = MLX5_CAP_QOS(vport->dev, esw_bw_share) &&
 				fw_max_bw_share >= MLX5_MIN_BW_SHARE;
@@ -275,7 +293,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 	bool max_rate_supported;
 	int err;
 
-	lockdep_assert_held(&esw->state_lock);
+	esw_assert_qos_lock_held(esw);
 	max_rate_supported = MLX5_CAP_QOS(vport->dev, esw_rate_limit);
 
 	if (max_rate && !max_rate_supported)
@@ -451,9 +469,7 @@ static int esw_qos_vport_update_group(struct mlx5_vport *vport,
 	struct mlx5_esw_rate_group *new_group, *curr_group;
 	int err;
 
-	if (!vport->enabled)
-		return -EINVAL;
-
+	esw_assert_qos_lock_held(esw);
 	curr_group = vport->qos.group;
 	new_group = group ?: esw->qos.group0;
 	if (curr_group == new_group)
@@ -552,6 +568,7 @@ esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	struct mlx5_esw_rate_group *group;
 	int err;
 
+	esw_assert_qos_lock_held(esw);
 	if (!MLX5_CAP_QOS(esw->dev, log_esw_max_sched_depth))
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -665,8 +682,7 @@ static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	int err = 0;
 
-	lockdep_assert_held(&esw->state_lock);
-
+	esw_assert_qos_lock_held(esw);
 	if (!refcount_inc_not_zero(&esw->qos.refcnt)) {
 		/* esw_qos_create() set refcount to 1 only on success.
 		 * No need to decrement on failure.
@@ -679,7 +695,7 @@ static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 
 static void esw_qos_put(struct mlx5_eswitch *esw)
 {
-	lockdep_assert_held(&esw->state_lock);
+	esw_assert_qos_lock_held(esw);
 	if (refcount_dec_and_test(&esw->qos.refcnt))
 		esw_qos_destroy(esw);
 }
@@ -690,7 +706,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
-	lockdep_assert_held(&esw->state_lock);
+	esw_assert_qos_lock_held(esw);
 	if (vport->qos.enabled)
 		return 0;
 
@@ -723,8 +739,9 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	int err;
 
 	lockdep_assert_held(&esw->state_lock);
+	esw_qos_lock(esw);
 	if (!vport->qos.enabled)
-		return;
+		goto unlock;
 	WARN(vport->qos.group != esw->qos.group0,
 	     "Disabling QoS on port before detaching it from group");
 
@@ -741,6 +758,8 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	trace_mlx5_esw_vport_qos_destroy(dev, vport);
 
 	esw_qos_put(esw);
+unlock:
+	esw_qos_unlock(esw);
 }
 
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_rate)
@@ -748,17 +767,34 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
-	lockdep_assert_held(&esw->state_lock);
+	esw_qos_lock(esw);
 	err = esw_qos_vport_enable(vport, 0, 0, NULL);
 	if (err)
-		return err;
+		goto unlock;
 
 	err = esw_qos_set_vport_min_rate(vport, min_rate, NULL);
 	if (!err)
 		err = esw_qos_set_vport_max_rate(vport, max_rate, NULL);
+unlock:
+	esw_qos_unlock(esw);
 	return err;
 }
 
+bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate)
+{
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	bool enabled;
+
+	esw_qos_lock(esw);
+	enabled = vport->qos.enabled;
+	if (enabled) {
+		*max_rate = vport->qos.max_rate;
+		*min_rate = vport->qos.min_rate;
+	}
+	esw_qos_unlock(esw);
+	return enabled;
+}
+
 static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 {
 	struct ethtool_link_ksettings lksettings;
@@ -846,7 +882,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 			return err;
 	}
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	if (!vport->qos.enabled) {
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
 		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.bw_share, NULL);
@@ -861,7 +897,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 							 vport->qos.esw_sched_elem_ix,
 							 bitmask);
 	}
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 
 	return err;
 }
@@ -927,14 +963,14 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 	if (err)
 		return err;
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	err = esw_qos_vport_enable(vport, 0, 0, extack);
 	if (err)
 		goto unlock;
 
 	err = esw_qos_set_vport_min_rate(vport, tx_share, extack);
 unlock:
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -953,14 +989,14 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	if (err)
 		return err;
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	err = esw_qos_vport_enable(vport, 0, 0, extack);
 	if (err)
 		goto unlock;
 
 	err = esw_qos_set_vport_max_rate(vport, tx_max, extack);
 unlock:
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -975,9 +1011,9 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 	if (err)
 		return err;
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	err = esw_qos_set_group_min_rate(group, tx_share, extack);
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -992,9 +1028,9 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 	if (err)
 		return err;
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	err = esw_qos_set_group_max_rate(group, tx_max, extack);
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1009,7 +1045,7 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Rate node creation supported only in switchdev mode");
@@ -1025,7 +1061,7 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 
 	*priv = group;
 unlock:
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1036,10 +1072,10 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	struct mlx5_eswitch *esw = group->esw;
 	int err;
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	err = __esw_qos_destroy_rate_group(group, extack);
 	esw_qos_put(esw);
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1055,7 +1091,7 @@ int mlx5_esw_qos_vport_update_group(struct mlx5_vport *vport,
 		return -EOPNOTSUPP;
 	}
 
-	mutex_lock(&esw->state_lock);
+	esw_qos_lock(esw);
 	if (!vport->qos.enabled && !group)
 		goto unlock;
 
@@ -1063,7 +1099,7 @@ int mlx5_esw_qos_vport_update_group(struct mlx5_vport *vport,
 	if (!err)
 		err = esw_qos_vport_update_group(vport, group, extack);
 unlock:
-	mutex_unlock(&esw->state_lock);
+	esw_qos_unlock(esw);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 44fb339c5dcc..b4045efbaf9e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -10,6 +10,7 @@ int mlx5_esw_qos_init(struct mlx5_eswitch *esw);
 void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw);
 
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min_rate);
+bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
 
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 9de819c45d33..2bcd42305f46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2068,6 +2068,7 @@ int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
 				  u16 vport, struct ifla_vf_info *ivi)
 {
 	struct mlx5_vport *evport = mlx5_eswitch_get_vport(esw, vport);
+	u32 max_rate, min_rate;
 
 	if (IS_ERR(evport))
 		return PTR_ERR(evport);
@@ -2082,9 +2083,10 @@ int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
 	ivi->qos = evport->info.qos;
 	ivi->spoofchk = evport->info.spoofchk;
 	ivi->trusted = evport->info.trusted;
-	if (evport->qos.enabled) {
-		ivi->min_tx_rate = evport->qos.min_rate;
-		ivi->max_tx_rate = evport->qos.max_rate;
+
+	if (mlx5_esw_qos_get_vport_rate(evport, &max_rate, &min_rate)) {
+		ivi->max_tx_rate = max_rate;
+		ivi->min_tx_rate = min_rate;
 	}
 	mutex_unlock(&esw->state_lock);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e57be2eeec85..3b901bd36d4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -212,6 +212,7 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
+	/* Protected with the E-Switch qos domain lock. */
 	struct {
 		/* Initially false, set to true whenever any QoS features are used. */
 		bool enabled;
@@ -363,10 +364,9 @@ struct mlx5_eswitch {
 	struct rw_semaphore mode_lock;
 	atomic64_t user_count;
 
+	/* Protected with the E-Switch qos domain lock. */
 	struct {
-		/* Protected by esw->state_lock.
-		 * Initially 0, meaning no QoS users and QoS is disabled.
-		 */
+		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
 		u32 root_tsar_ix;
 		struct mlx5_qos_domain *domain;
-- 
2.44.0


