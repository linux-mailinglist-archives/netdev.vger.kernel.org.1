Return-Path: <netdev+bounces-162273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF7A265C4
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A57A1625B5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5A211461;
	Mon,  3 Feb 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6v9koRU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C321128F
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618621; cv=fail; b=lHvUlouZtooRKtKtQN84gH6j/Aqs4blUKu5CXepH7/RyVY0WxbinO/K5qPBFJVO8yo94eG/SZS1jsiosK14v76TlKuarqTDCTSLpVcbcFn4N+v1Uu08TEhNlIb1oNqQU+NDmnKZFkHo/WDLt8686vz+xo5j29S7gATl2w371POw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618621; c=relaxed/simple;
	bh=BVgNVVVd2ghAZz5OEqwRvh2aNz4+Fdk59O1tLRwhkm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QB57CaRaTkxROr5xeJmhMwwsuhJ6ee0DzHOUemjpSyENz/wN+JMNW7l1x66TqCboy8DRKvhyXgSB3qK27mDdoW9Zc4kXi4DvkS0N4o97TJsCXQj5H2eHIp0sS2yjIpBPpD2glaVygT9AsdIs6HCOrq74vfut9nQsKSRX3oPFcMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6v9koRU; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvmNALIeoTM1gsQ/mNhiFKevF0ujFObPux3GoYuVX4zTzJJAmAgPdYH7uX63Pf7a9XTP3HxaLf+Gu4POcqbkQSp6K68A03n7d9kFOlXIoPIwrg3ne6bP9HE3OALh66lgdJtRHy7f6e/BQH54WK4T7jczn8tluisyqEUp24HS4QICOtXqBcye3w4n1PrxnKvdAVwocVI+ejOf1LsavUOy/hkGgZmtefv4waDl5vB/rg6ZsJlR3eJiaRqXpqRfexeZ9CMVuEVdXnxouCH/NAGR7ThDOSeROe86gn/UPpt3jN87Af5KFtZoRs5CAnRUwPmsaouKj0tm/90F/S6hsqBucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5HT+32GCUYysIiDSAS/lIcF3lE/jzebdOg3m2GOGSI=;
 b=cu4HwFXmK0VaJ3rzHE/krlkpW3xlxOzwKmAyA7zhhSFC/e6MZaislnOPlVh8cqSbMyaK43eArbh3UcRWNHHDSFSJgoZsIq38u2nR36lPvNa9CfsHGc70QWjjh5JqtSzwbYLiHySkD4sFxaz5eWUV2UZJD4h4efx/aL9wL62pUF18hGp/V4qYO+eG6WPYUz0NIYS9JDt5LxIPWFZtKJdZ/+jdVROtvxtOEEQG8UgUn07t4fAhrmyQ+kqQLZ7tsC6UwBUdUhYoAO7DnZpIuy+PqELlmXupKBTRRzJP6mgrlpTXf0BIkG8ttltQ9G5GDwxtGtXQ+W+Ce2rG6j4YmbWqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5HT+32GCUYysIiDSAS/lIcF3lE/jzebdOg3m2GOGSI=;
 b=X6v9koRUSV2GFGDyw8o+fFbi9uclrUfOfNasztpt3tFG28YcWVq0CinITT7JhkycHVmqi84CJsupNNFbMu386Qn2vw5F5cLYse/tXZ8TmvfA6aFVycb1YQCmxebX8I3NazZIo0ho3SCaHG4G+lOfXPVWkbTWb1mFR+soLGCy34rBBbWZ6XAHYTG1/0vOBUUymw1UYLQCivhaZ0O7GOoHdPdm+YGlJTptoavHoC90G/Gh0E+ciJ8+Sl7I4i72S9lnJy8N6jWWsBNNKW5O1o9QWXtSVbmQEjPJZNaw4J1aY7yOyXLbFO3aibKfqP0uuqQkDQgpu0B+/2isKGh0NI4lIw==
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:36:52 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::86) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Mon,
 3 Feb 2025 21:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:41 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:37 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/15] net/mlx5: Support one PTP device per hardware clock
Date: Mon, 3 Feb 2025 23:35:09 +0200
Message-ID: <20250203213516.227902-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8520dbab-214b-46e9-5f36-08dd449adfee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZnI4+4eLBZqaILMgqIvyXpamuCu1oNkEKOC3/VvoaNnTwXOa+5UIdFNKK3tK?=
 =?us-ascii?Q?srw39sZKMxUJ2cAeJGg+mzN36oOzphRbpbHxi6BPMvXAFOAiNAX8r7lNYQth?=
 =?us-ascii?Q?Fc0+VmFniCnH21cbHsi1SZmZlZxvFoDag8X4wurbtK/vrjXiaNowhuijtdo/?=
 =?us-ascii?Q?mVIbQSqDGhvmBUoyO63N6JRJsKSOsL1R42mbqs4+XaxKZP89CpvNkSr7FpZq?=
 =?us-ascii?Q?7yzqBbcGOkf49LgIeKtZKIOesflCHXX3WdeMYcLhZ65BT6coJt0NE+Dv2ysb?=
 =?us-ascii?Q?dBuZBRErxG+zgyUJBAQzVnbVchNimBdt12ELb5a9wJEt7/MWFjvJbFiS19FU?=
 =?us-ascii?Q?Fw650bqO+0nhl0R7Ad93ZOhJdXY7hlGfDpFBJufgGixlnA7rgJTqLL6LrSOu?=
 =?us-ascii?Q?N+OT51rZ5CbgGM/QG4zx70y0sLD/sgdRqKaarlIOMmkD8F0I0oxO7uoTW5fp?=
 =?us-ascii?Q?pbMHFRYVQ8eugHIo8t1TrmXdzy+BN5lYV+ESg/VmiDBtb/UVCegWp0OwRObt?=
 =?us-ascii?Q?kW4mw9bo+N43m1Raozo3nYUmMMHf7a1kSFc1n1m1Oupwyn+/N8QrG6mGzzfY?=
 =?us-ascii?Q?x3pUb87Djq5OZrP7G248g3wySGhIhzTfHA1y6ldznGVs6yTsoiD7pEjVgsUW?=
 =?us-ascii?Q?k1J205lavIcwZaapqmPGmVflpGqDKE11t+D15cd/f7DmDmxdyhDuIK4O+H7N?=
 =?us-ascii?Q?m80GvVy0rc6xKVMg1XZqyCla6hI1qxddAUHhrdkyHCC4q2rMoJGmGZ++WyyT?=
 =?us-ascii?Q?in2kxUqDGPeKMiGdFBvk68c/JX4YOLvldfEtp/1iGmn85j3tWJ35gHmjO5yp?=
 =?us-ascii?Q?Im/Lk+vbL7ksv/PRSVeXUvdZ1rMRMlahRvNNFqBwh/6T2G9gZWM7dxG6dDG2?=
 =?us-ascii?Q?8XBOMfRA3WQKWuLt9XdmOipIJVyfuG39JS7tBWwjQobOun51e7qLufq+bIwV?=
 =?us-ascii?Q?OGAyLyEwKFhbGXAMd/uizlNFFxDYlutpY+oVFeArMJAOwNbByQNsZhFR4Wlw?=
 =?us-ascii?Q?+YIyrebG/JeY8g22GwH+IjsBtFTuGQ2IPccdaja14/Z6bIZZVOy8gVSMwiM4?=
 =?us-ascii?Q?9tUxDdd9rE+Ko5uwPyFNCST/lFI4T9A9puMfuvv1IhlW9VyJgkUk25ZO/88M?=
 =?us-ascii?Q?OTuwesHb1WhUAeoKqEny58AqlWlh5i3mqcupTIf2vvthGEyFOm83PpyKos6U?=
 =?us-ascii?Q?7VZOG6NhjkmtaFR8T3ANKtHmnvrAtkIzT0OVVGasCvstkt8WR2pqJqYHY7wN?=
 =?us-ascii?Q?W/KLh/ledhdpgAxRmseViU8dPGN39+fGMC8Ey8fu5o7GasAooh2VXo+6yWOp?=
 =?us-ascii?Q?MBrBgpTOpgFX2uaJ1eE4baGtcYYNsl14k9bmSRE8BqgnKbNwkgsHJoAAzorW?=
 =?us-ascii?Q?sfU2WgSwgY9J7ApTL8VhRUKU90DXgC6tetAtE5+XWY6WjJaNn2h5M4YhSYmR?=
 =?us-ascii?Q?Uzsib3ikng6YTKvJVxdAk7vibn8hlUvhvZRLBIzNRCsrs1hSOvx3jkPY74yt?=
 =?us-ascii?Q?UcjSnUYsPM85OFE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:52.8446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8520dbab-214b-46e9-5f36-08dd449adfee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089

From: Jianbo Liu <jianbol@nvidia.com>

Currently, mlx5 driver exposes a PTP device for each network interface,
resulting in multiple device nodes representing the same underlying
PHC (PTP hardware clock). This causes problem if it is trying to
synchronize to itself. For instance, when ptp4l operates on multiple
interfaces following different masters, phc2sys attempts to
synchronize them in automatic mode.

PHC can be configured to work as free running mode or real time mode.
All functions can access it directly. In this patch, we create one PTP
device for each PHC when it's running in real time mode. All the
functions share the same PTP device if the clock identifies they query
are same, and they are already grouped by devcom in previous commit.
The first mdev in the peer list is chosen when sending
MTPPS/MTUTC/MTPPSE/MRTCQ to firmware. Since the function can be
unloaded at any time, we need to use a mutex lock to protect the mdev
pointer used in PTP and PPS callbacks. Besides, new one should be
picked from the peer list when the current is not available.

The clock info, which is used by IB, is shared by all the interfaces
using the same hardware clock.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 250 ++++++++++++++----
 .../ethernet/mellanox/mlx5/core/lib/clock.h   |   1 +
 2 files changed, 203 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 2586b0788b40..42df3a6fda93 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -89,6 +89,7 @@ struct mlx5_clock_dev_state {
 struct mlx5_clock_priv {
 	struct mlx5_clock clock;
 	struct mlx5_core_dev *mdev;
+	struct mutex lock; /* protect mdev and used in PTP callbacks */
 };
 
 static struct mlx5_clock_priv *clock_priv(struct mlx5_clock *clock)
@@ -96,11 +97,37 @@ static struct mlx5_clock_priv *clock_priv(struct mlx5_clock *clock)
 	return container_of(clock, struct mlx5_clock_priv, clock);
 }
 
+static void mlx5_clock_lockdep_assert(struct mlx5_clock *clock)
+{
+	if (!clock->shared)
+		return;
+
+	lockdep_assert(lockdep_is_held(&clock_priv(clock)->lock));
+}
+
 static struct mlx5_core_dev *mlx5_clock_mdev_get(struct mlx5_clock *clock)
 {
+	mlx5_clock_lockdep_assert(clock);
+
 	return clock_priv(clock)->mdev;
 }
 
+static void mlx5_clock_lock(struct mlx5_clock *clock)
+{
+	if (!clock->shared)
+		return;
+
+	mutex_lock(&clock_priv(clock)->lock);
+}
+
+static void mlx5_clock_unlock(struct mlx5_clock *clock)
+{
+	if (!clock->shared)
+		return;
+
+	mutex_unlock(&clock_priv(clock)->lock);
+}
+
 static bool mlx5_real_time_mode(struct mlx5_core_dev *mdev)
 {
 	return (mlx5_is_real_time_rq(mdev) || mlx5_is_real_time_sq(mdev));
@@ -170,10 +197,14 @@ static s32 mlx5_ptp_getmaxphase(struct ptp_clock_info *ptp)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_core_dev *mdev;
+	s32 ret;
 
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
+	ret = mlx5_clock_getmaxphase(mdev);
+	mlx5_clock_unlock(clock);
 
-	return mlx5_clock_getmaxphase(mdev);
+	return ret;
 }
 
 static bool mlx5_is_mtutc_time_adj_cap(struct mlx5_core_dev *mdev, s64 delta)
@@ -265,16 +296,23 @@ static int mlx5_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct system_time_snapshot history_begin = {0};
 	struct mlx5_core_dev *mdev;
+	int err;
 
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
 
-	if (!mlx5_is_ptm_source_time_available(mdev))
-		return -EBUSY;
+	if (!mlx5_is_ptm_source_time_available(mdev)) {
+		err = -EBUSY;
+		goto unlock;
+	}
 
 	ktime_get_snapshot(&history_begin);
 
-	return get_device_system_crosststamp(mlx5_mtctr_syncdevicetime, mdev,
-					     &history_begin, cts);
+	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicetime, mdev,
+					    &history_begin, cts);
+unlock:
+	mlx5_clock_unlock(clock);
+	return err;
 }
 #endif /* CONFIG_X86 */
 
@@ -372,6 +410,7 @@ static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
 	unsigned long flags;
 
 	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
 	timer = &clock->timer;
 
@@ -384,6 +423,7 @@ static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
 out:
+	mlx5_clock_unlock(clock);
 	return timer->overflow_period;
 }
 
@@ -428,10 +468,14 @@ static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_core_dev *mdev;
+	int err;
 
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
+	err = mlx5_clock_settime(mdev, clock, ts);
+	mlx5_clock_unlock(clock);
 
-	return  mlx5_clock_settime(mdev, clock, ts);
+	return err;
 }
 
 static
@@ -453,6 +497,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 	struct mlx5_core_dev *mdev;
 	u64 cycles, ns;
 
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
 	if (mlx5_real_time_mode(mdev)) {
 		*ts = mlx5_ptp_gettimex_real_time(mdev, sts);
@@ -463,6 +508,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 	ns = mlx5_timecounter_cyc2time(clock, cycles);
 	*ts = ns_to_timespec64(ns);
 out:
+	mlx5_clock_unlock(clock);
 	return 0;
 }
 
@@ -493,14 +539,16 @@ static int mlx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
+	int err = 0;
 
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
 
 	if (mlx5_modify_mtutc_allowed(mdev)) {
-		int err = mlx5_ptp_adjtime_real_time(mdev, delta);
+		err = mlx5_ptp_adjtime_real_time(mdev, delta);
 
 		if (err)
-			return err;
+			goto unlock;
 	}
 
 	write_seqlock_irqsave(&clock->lock, flags);
@@ -508,17 +556,23 @@ static int mlx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
-	return 0;
+unlock:
+	mlx5_clock_unlock(clock);
+	return err;
 }
 
 static int mlx5_ptp_adjphase(struct ptp_clock_info *ptp, s32 delta)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_core_dev *mdev;
+	int err;
 
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
+	err = mlx5_ptp_adjtime_real_time(mdev, delta);
+	mlx5_clock_unlock(clock);
 
-	return mlx5_ptp_adjtime_real_time(mdev, delta);
+	return err;
 }
 
 static int mlx5_ptp_freq_adj_real_time(struct mlx5_core_dev *mdev, long scaled_ppm)
@@ -547,15 +601,17 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
+	int err = 0;
 	u32 mult;
 
+	mlx5_clock_lock(clock);
 	mdev = mlx5_clock_mdev_get(clock);
 
 	if (mlx5_modify_mtutc_allowed(mdev)) {
-		int err = mlx5_ptp_freq_adj_real_time(mdev, scaled_ppm);
+		err = mlx5_ptp_freq_adj_real_time(mdev, scaled_ppm);
 
 		if (err)
-			return err;
+			goto unlock;
 	}
 
 	mult = (u32)adjust_by_scaled_ppm(timer->nominal_c_mult, scaled_ppm);
@@ -567,7 +623,9 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	write_sequnlock_irqrestore(&clock->lock, flags);
 	ptp_schedule_worker(clock->ptp, timer->overflow_period);
 
-	return 0;
+unlock:
+	mlx5_clock_unlock(clock);
+	return err;
 }
 
 static int mlx5_extts_configure(struct ptp_clock_info *ptp,
@@ -576,17 +634,14 @@ static int mlx5_extts_configure(struct ptp_clock_info *ptp,
 {
 	struct mlx5_clock *clock =
 			container_of(ptp, struct mlx5_clock, ptp_info);
-	struct mlx5_core_dev *mdev = mlx5_clock_mdev_get(clock);
 	u32 in[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
+	struct mlx5_core_dev *mdev;
 	u32 field_select = 0;
 	u8 pin_mode = 0;
 	u8 pattern = 0;
 	int pin = -1;
 	int err = 0;
 
-	if (!MLX5_PPS_CAP(mdev))
-		return -EOPNOTSUPP;
-
 	/* Reject requests with unsupported flags */
 	if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
 				PTP_RISING_EDGE |
@@ -617,6 +672,14 @@ static int mlx5_extts_configure(struct ptp_clock_info *ptp,
 		field_select = MLX5_MTPPS_FS_ENABLE;
 	}
 
+	mlx5_clock_lock(clock);
+	mdev = mlx5_clock_mdev_get(clock);
+
+	if (!MLX5_PPS_CAP(mdev)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	MLX5_SET(mtpps_reg, in, pin, pin);
 	MLX5_SET(mtpps_reg, in, pin_mode, pin_mode);
 	MLX5_SET(mtpps_reg, in, pattern, pattern);
@@ -625,10 +688,13 @@ static int mlx5_extts_configure(struct ptp_clock_info *ptp,
 
 	err = mlx5_set_mtpps(mdev, in, sizeof(in));
 	if (err)
-		return err;
+		goto unlock;
+
+	err = mlx5_set_mtppse(mdev, pin, 0, MLX5_EVENT_MODE_REPETETIVE & on);
 
-	return mlx5_set_mtppse(mdev, pin, 0,
-			       MLX5_EVENT_MODE_REPETETIVE & on);
+unlock:
+	mlx5_clock_unlock(clock);
+	return err;
 }
 
 static u64 find_target_cycles(struct mlx5_core_dev *mdev, s64 target_ns)
@@ -760,25 +826,18 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 {
 	struct mlx5_clock *clock =
 			container_of(ptp, struct mlx5_clock, ptp_info);
-	struct mlx5_core_dev *mdev = mlx5_clock_mdev_get(clock);
-	bool rt_mode = mlx5_real_time_mode(mdev);
 	u32 in[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
 	u32 out_pulse_duration_ns = 0;
+	struct mlx5_core_dev *mdev;
 	u32 field_select = 0;
 	u64 npps_period = 0;
 	u64 time_stamp = 0;
 	u8 pin_mode = 0;
 	u8 pattern = 0;
+	bool rt_mode;
 	int pin = -1;
 	int err = 0;
 
-	if (!MLX5_PPS_CAP(mdev))
-		return -EOPNOTSUPP;
-
-	/* Reject requests with unsupported flags */
-	if (mlx5_perout_verify_flags(mdev, rq->perout.flags))
-		return -EOPNOTSUPP;
-
 	if (rq->perout.index >= clock->ptp_info.n_pins)
 		return -EINVAL;
 
@@ -787,14 +846,29 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 	if (pin < 0)
 		return -EBUSY;
 
-	if (on) {
-		bool rt_mode = mlx5_real_time_mode(mdev);
+	mlx5_clock_lock(clock);
+	mdev = mlx5_clock_mdev_get(clock);
+	rt_mode = mlx5_real_time_mode(mdev);
+
+	if (!MLX5_PPS_CAP(mdev)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	/* Reject requests with unsupported flags */
+	if (mlx5_perout_verify_flags(mdev, rq->perout.flags)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
+	if (on) {
 		pin_mode = MLX5_PIN_MODE_OUT;
 		pattern = MLX5_OUT_PATTERN_PERIODIC;
 
-		if (rt_mode &&  rq->perout.start.sec > U32_MAX)
-			return -EINVAL;
+		if (rt_mode &&  rq->perout.start.sec > U32_MAX) {
+			err = -EINVAL;
+			goto unlock;
+		}
 
 		field_select |= MLX5_MTPPS_FS_PIN_MODE |
 				MLX5_MTPPS_FS_PATTERN |
@@ -807,7 +881,7 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 		else
 			err = perout_conf_1pps(mdev, rq, &time_stamp, rt_mode);
 		if (err)
-			return err;
+			goto unlock;
 	}
 
 	MLX5_SET(mtpps_reg, in, pin, pin);
@@ -820,13 +894,16 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 	MLX5_SET(mtpps_reg, in, out_pulse_duration_ns, out_pulse_duration_ns);
 	err = mlx5_set_mtpps(mdev, in, sizeof(in));
 	if (err)
-		return err;
+		goto unlock;
 
 	if (rt_mode)
-		return 0;
+		goto unlock;
 
-	return mlx5_set_mtppse(mdev, pin, 0,
-			       MLX5_EVENT_MODE_REPETETIVE & on);
+	err = mlx5_set_mtppse(mdev, pin, 0, MLX5_EVENT_MODE_REPETETIVE & on);
+
+unlock:
+	mlx5_clock_unlock(clock);
+	return err;
 }
 
 static int mlx5_pps_configure(struct ptp_clock_info *ptp,
@@ -1043,6 +1120,10 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		ptp_clock_event(clock->ptp, &ptp_event);
 		break;
 	case PTP_PF_PEROUT:
+		if (clock->shared) {
+			mlx5_core_warn(mdev, " Received unexpected PPS out event\n");
+			break;
+		}
 		ns = perout_conf_next_event_timer(mdev, clock);
 		write_seqlock_irqsave(&clock->lock, flags);
 		clock->pps_info.start[pin] = ns;
@@ -1201,9 +1282,10 @@ static void mlx5_init_clock_dev(struct mlx5_core_dev *mdev)
 	mlx5_init_pps(mdev);
 
 	clock->ptp = ptp_clock_register(&clock->ptp_info,
-					&mdev->pdev->dev);
+					clock->shared ? NULL : &mdev->pdev->dev);
 	if (IS_ERR(clock->ptp)) {
-		mlx5_core_warn(mdev, "ptp_clock_register failed %ld\n",
+		mlx5_core_warn(mdev, "%sptp_clock_register failed %ld\n",
+			       clock->shared ? "shared clock " : "",
 			       PTR_ERR(clock->ptp));
 		clock->ptp = NULL;
 	}
@@ -1234,11 +1316,12 @@ static void mlx5_clock_free(struct mlx5_core_dev *mdev)
 	struct mlx5_clock_priv *cpriv = clock_priv(mdev->clock);
 
 	mlx5_destroy_clock_dev(mdev);
+	mutex_destroy(&cpriv->lock);
 	kfree(cpriv);
 	mdev->clock = NULL;
 }
 
-static int mlx5_clock_alloc(struct mlx5_core_dev *mdev)
+static int mlx5_clock_alloc(struct mlx5_core_dev *mdev, bool shared)
 {
 	struct mlx5_clock_priv *cpriv;
 	struct mlx5_clock *clock;
@@ -1247,23 +1330,90 @@ static int mlx5_clock_alloc(struct mlx5_core_dev *mdev)
 	if (!cpriv)
 		return -ENOMEM;
 
+	mutex_init(&cpriv->lock);
 	cpriv->mdev = mdev;
 	clock = &cpriv->clock;
+	clock->shared = shared;
 	mdev->clock = clock;
+	mlx5_clock_lock(clock);
 	mlx5_init_clock_dev(mdev);
+	mlx5_clock_unlock(clock);
+
+	if (!clock->shared)
+		return 0;
+
+	if (!clock->ptp) {
+		mlx5_core_warn(mdev, "failed to create ptp dev shared by multiple functions");
+		mlx5_clock_free(mdev);
+		return -EINVAL;
+	}
 
 	return 0;
 }
 
 static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev, u64 key)
 {
+	struct mlx5_core_dev *peer_dev, *next = NULL;
+	struct mlx5_devcom_comp_dev *pos;
+
 	mdev->clock_state->compdev = mlx5_devcom_register_component(mdev->priv.devc,
 								    MLX5_DEVCOM_SHARED_CLOCK,
 								    key, NULL, mdev);
+	if (IS_ERR(mdev->clock_state->compdev))
+		return;
+
+	mlx5_devcom_comp_lock(mdev->clock_state->compdev);
+	mlx5_devcom_for_each_peer_entry(mdev->clock_state->compdev, peer_dev, pos) {
+		if (peer_dev->clock) {
+			next = peer_dev;
+			break;
+		}
+	}
+
+	if (next) {
+		mdev->clock = next->clock;
+		/* clock info is shared among all the functions using the same clock */
+		mdev->clock_info = next->clock_info;
+	} else {
+		mlx5_clock_alloc(mdev, true);
+	}
+	mlx5_devcom_comp_unlock(mdev->clock_state->compdev);
+
+	if (!mdev->clock) {
+		mlx5_devcom_unregister_component(mdev->clock_state->compdev);
+		mdev->clock_state->compdev = NULL;
+	}
 }
 
 static void mlx5_shared_clock_unregister(struct mlx5_core_dev *mdev)
 {
+	struct mlx5_core_dev *peer_dev, *next = NULL;
+	struct mlx5_clock *clock = mdev->clock;
+	struct mlx5_devcom_comp_dev *pos;
+
+	mlx5_devcom_comp_lock(mdev->clock_state->compdev);
+	mlx5_devcom_for_each_peer_entry(mdev->clock_state->compdev, peer_dev, pos) {
+		if (peer_dev->clock && peer_dev != mdev) {
+			next = peer_dev;
+			break;
+		}
+	}
+
+	if (next) {
+		struct mlx5_clock_priv *cpriv = clock_priv(clock);
+
+		mlx5_clock_lock(clock);
+		if (mdev == cpriv->mdev)
+			cpriv->mdev = next;
+		mlx5_clock_unlock(clock);
+	} else {
+		mlx5_clock_free(mdev);
+	}
+
+	mdev->clock = NULL;
+	mdev->clock_info = NULL;
+	mlx5_devcom_comp_unlock(mdev->clock_state->compdev);
+
 	mlx5_devcom_unregister_component(mdev->clock_state->compdev);
 }
 
@@ -1297,11 +1447,13 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 		}
 	}
 
-	err = mlx5_clock_alloc(mdev);
-	if (err) {
-		kfree(clock_state);
-		mdev->clock_state = NULL;
-		return err;
+	if (!mdev->clock) {
+		err = mlx5_clock_alloc(mdev, false);
+		if (err) {
+			kfree(clock_state);
+			mdev->clock_state = NULL;
+			return err;
+		}
 	}
 
 	INIT_WORK(&mdev->clock_state->out_work, mlx5_pps_out);
@@ -1319,8 +1471,10 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	mlx5_eq_notifier_unregister(mdev, &mdev->clock_state->pps_nb);
 	cancel_work_sync(&mdev->clock_state->out_work);
 
-	mlx5_clock_free(mdev);
-	mlx5_shared_clock_unregister(mdev);
+	if (mdev->clock->shared)
+		mlx5_shared_clock_unregister(mdev);
+	else
+		mlx5_clock_free(mdev);
 	kfree(mdev->clock_state);
 	mdev->clock_state = NULL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
index 3c5fee246582..093fa131014a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
@@ -58,6 +58,7 @@ struct mlx5_clock {
 	struct ptp_clock_info      ptp_info;
 	struct mlx5_pps            pps_info;
 	struct mlx5_timer          timer;
+	bool                       shared;
 };
 
 static inline bool mlx5_is_real_time_rq(struct mlx5_core_dev *mdev)
-- 
2.45.0


