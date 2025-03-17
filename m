Return-Path: <netdev+bounces-175413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A9DA65B17
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0997A836B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B31AF0A4;
	Mon, 17 Mar 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YeITCX9N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525E1ABEA5
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233229; cv=fail; b=onc+r4bv7e4D8S3i7vfs1y5J2fjsVdK7fch4L3TY0lgYI+M0lIQBqVwHNaJpz0zhtwfejWVUvl/8ZD1Pm/pb3JymResCZ0T9a71EOk9QQ2c9X2qdazOU+Lw8lZvseIlKAkKAt/jSaCo2V3cjihFnN3cBqEiWqlb75eZBcbwGm9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233229; c=relaxed/simple;
	bh=GPPtvlzFiJaebU9KFUOa9GfAEBPTE+jcVG1IwvgLyYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjtRvlks7ESFMVoIm6NMRuVbam45/iWe0jl/WvN2PBVZN0YphJOu4/yiK8capytkAJndVfQPqZILjpU6CE4FWwzpkrm+1FN83hVHMLgFGPCQh83gXsHWibiuBtPD+iZEqCqY60YpSyVBEHnJt8q3aUA6CyBIT6zrCojzNWZGoi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YeITCX9N; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt/1IARCUneNiIIhUkWgMH1FZg/3ospnmq4CZ6v2LaHeKN+hXr/G8ayAQl7Diue/GahfIS3QewPfe2FaEYtNbR526beWa9MhSC9uZaS/Gh+7dLbYijOaYKzWJoGJb5hXP+PpiQeASI9ixrFqhp4QTa6lZ6jvDLhuviwswBdy5TE940SKGX8nu5Y52XAY54eILGMTOrVMi7M98CG+YS+ragUqT1M5N3N6wkHFt5wXdMUJpw14PC0i4LAVNX/Yz7JqM9c5SYMY4bdk9i0eVrNYOcBwXMJHxEBgcWI2acWsXzKMhBXgm+D3x6Azme9ww4JYskmBXR1I++iFs46iFK9/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS5CZPpUcd7hkZcIRme6IG+s+BQAfE6wReJKpxMxD9I=;
 b=DaA1VtGnDuiRHKI2CBTEofQ72U0I2qfzzpXuNWiuFANchHCkc9hJ+cbmZxUALcTPCsbghaGdccyJyO4tgE7pWzSamVi3Zn1lVQaOEbTk69WvzMEWBqEaSXXmWW5cjp2rew+v165r8rMyiDGykGQZieU6wV+LgRnWn+pm1Ep5k48x8YNPINwD/mfnJzKNCaTRcoE60HZDA9P7ZHv34PKkQm6kxL3PG83vlW2CAfCMEjmhzV/DRf76ERMx+WWd3AjVAzDstHdz1G3GNCiEPSwDlVjPC3ZG1lyEIhinfIAMh4ElqMPMnwRLrER+LR6mMP8PQeWgbPUWoDMZHZvhhEoHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS5CZPpUcd7hkZcIRme6IG+s+BQAfE6wReJKpxMxD9I=;
 b=YeITCX9NIHipSu7eiQd6ZXSobRM5Av7xCGcexiKHsDTdQDQrPjOb8WzOiCWv4Bxsh3MmQLsOJVlXKEDhiOHUgszaB4A7VPcrQkTTYr6G4VhZ95KEAeZQzwFq1S1FXD0280P2o9zCam1LS/tAm5Q3ZQmZ5PDFQMuUpXVlCIphwylljClgmaUXCdZmLTZfQwWB+QYCr7AKSHUjGoQ2Ngfv3dQAfry8VFhMHjP+vzTRRyUHLJSiylAnuBcmVtz4sMoSN5GrrkNWibRhACK2ntxZHBZecoOYVwSCTAjVYhICu6z4+66kR+hSVAub+LsGJz5xOjrQgniY5J+q/+2NRVWJ+g==
Received: from BN9PR03CA0372.namprd03.prod.outlook.com (2603:10b6:408:f7::17)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:40:22 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::7e) by BN9PR03CA0372.outlook.office365.com
 (2603:10b6:408:f7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 17:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:40:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:40:08 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:40:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/6] mlxsw: spectrum_switchdev: Add an internal API for VXLAN leave
Date: Mon, 17 Mar 2025 18:37:28 +0100
Message-ID: <f3a32bd2d87a0b7ac4d2bb98a427dc6d95a01cd0.1742224300.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742224300.git.petrm@nvidia.com>
References: <cover.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: d2979940-c739-4ab3-e2f5-08dd657aca82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+NnaGqqY6VSkibbM/OunCnHpyW+r4rNP+v9HnGicfmnHRRPNUywjVyRSL3P?=
 =?us-ascii?Q?BhQw/x0EN855RFTC70brElpS743pvxu5SVI+rKviksGg4k4gjpaSUvB/rZxR?=
 =?us-ascii?Q?UF+l2W1OoXZSKDtYF6HtfLjY/bJndwCCay4x05GUwtVYEF4bLLFuuklZiWlq?=
 =?us-ascii?Q?l2I6+30a6VfmKXLLwKQS06gXy5geC+5PETdk+6ZaxiXEOJO77MI3Xb9udMSp?=
 =?us-ascii?Q?oUNtrJ5RZN22ovQkpuFjrsENrhwoeS1vUeqhzwg37Yy2kXx1yBwM/IqnHsqm?=
 =?us-ascii?Q?q1smPP7T/jRSh1e27pCL0GzT7Hvt4rJKh73o4B32gW35jYjtCxmG4Q65qFGV?=
 =?us-ascii?Q?sRQ5VWHRdDeHJRzrqgbSZwsSRUIRQ1EsMabwaVQNBmjKx+zc496mBkbn35z/?=
 =?us-ascii?Q?fQNNQWzk5NFeb710FVLDuqriaSJBknQFwKWffFLNyC85CqevcR/IcMkPgbTK?=
 =?us-ascii?Q?IY5JC/vV9q8Tfh4Xz2F1l/6fOL6U0UyE05xzkGHz4+csDwRRewTL/0dRoK2+?=
 =?us-ascii?Q?OIZKOO6PdPHwzpJs5YHuoFl/FWolIlMOZCxrrg9MkPQ9/zEF78F0IEeOZ9aj?=
 =?us-ascii?Q?i/Linwd44Rf7kjaEWlCXWkAsexwq9CbCer0oZlfEp+5JwTT2YYurRRVOl+JR?=
 =?us-ascii?Q?21PJJyKxrWttAZTW/zMbkZ2mEP4F/sSRlfDAzAQhyqNS3vsqVCyRdpwCdgcr?=
 =?us-ascii?Q?Svnheue7QZhEEie1DGsziZYzAv7vEBgI5WvX/GcIALT6nICd4zg+FamN77I2?=
 =?us-ascii?Q?YwoUPlg/aYqv+037ZvYH7Kt8cn/LepeFKLx3IAgXJ+w8ZsAe8MWREfozmSLl?=
 =?us-ascii?Q?VKOeJvBmM3Z0tqMt1+9quYxb5t4sXLXC1Fk8aQit+jmC9PP6cZmuPGh8+HSs?=
 =?us-ascii?Q?sgtT1tPvjtMmZgqrnGdH7d/+1CLJxfrdDIxJaJi/57SqG+CH2RlUxXscNFfH?=
 =?us-ascii?Q?7vwLI76v18+mFYTubABSDuIUFEMFjIKgx0Dz5v1lIXbfJZcRrOTw9lotueSP?=
 =?us-ascii?Q?PsBEjwRKuy2LJmxCWHmlMUvHnn4uLvDjqNEh0C1VamOKaWs5WyeWWRfb+G4P?=
 =?us-ascii?Q?tY0dDdlu4eaK1oMZZWIB47ba4eSpGxFoXLlhlx9WWtEieF1r2jAGvlOGjtpZ?=
 =?us-ascii?Q?Nk67Vt++wvLiXBVejz92s1WV96Za3fxpazZt4z1/oTH36ku4PiqQSka68x4I?=
 =?us-ascii?Q?TsPt4R2SWQsZnmj+iCLHgJRY1pul+LL+8//OVobZ073G6LuzkENOpUq9mhYx?=
 =?us-ascii?Q?QEbSiYBLaEMHfUDGb51dRf2Lm4PxEK9485WzM+3LPAt9tzMFweYvjO05nFwq?=
 =?us-ascii?Q?lE9xG4D5mfD3EwUS+waphFED2gOOypXbgbTaAql6FYmO0C4zxWGft4sMSBtl?=
 =?us-ascii?Q?4s9AwYU4SJGmBrm8781RCLJBx+9E1aMoXIqvIs/3s0zsHesJwnlwOiTk11zv?=
 =?us-ascii?Q?sbiFnjBX00uzfFQygSdL4fWOWKlseD/xYa0HM1af96lE4kzOSt+eTYijTuyo?=
 =?us-ascii?Q?WAJCRqeABkVzgf0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:40:21.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2979940-c739-4ab3-e2f5-08dd657aca82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

From: Amit Cohen <amcohen@nvidia.com>

There is asymmetry in how the VXLAN join and leave functions are used.
The join function (mlxsw_sp_bridge_vxlan_join()) is only called in
response to netdev events (e.g., VXLAN device joining a bridge), but the
leave function is also called in response to switchdev events (e.g.,
VLAN configuration on top of the VXLAN device) in order to invalidate
VNI to FID mappings.

This asymmetry will cause problems when the functions will be later
extended to mark VXLAN bridge ports as offloaded or not.

Therefore, create an internal function (__mlxsw_sp_bridge_vxlan_leave())
that is used to invalidate VNI to FID mappings and call it from
mlxsw_sp_bridge_vxlan_leave() which will only be invoked in response to
netdev events, like mlxsw_sp_bridge_vxlan_join().

No functional changes intended.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6397ff0dc951..c95ef79eaf3d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2944,8 +2944,8 @@ int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
 					      extack);
 }
 
-void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
-				 const struct net_device *vxlan_dev)
+static void __mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
+					  const struct net_device *vxlan_dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
 	struct mlxsw_sp_fid *fid;
@@ -2963,6 +2963,12 @@ void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 	mlxsw_sp_fid_put(fid);
 }
 
+void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
+				 const struct net_device *vxlan_dev)
+{
+	__mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+}
+
 static void
 mlxsw_sp_switchdev_vxlan_addr_convert(const union vxlan_addr *vxlan_addr,
 				      enum mlxsw_sp_l3proto *proto,
@@ -3867,7 +3873,7 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *mlxsw_sp,
 			mlxsw_sp_fid_put(fid);
 			return -EINVAL;
 		}
-		mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+		__mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
 		mlxsw_sp_fid_put(fid);
 		return 0;
 	}
@@ -3883,7 +3889,7 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *mlxsw_sp,
 	/* Fourth case: Thew new VLAN is PVID, which means the VLAN currently
 	 * mapped to the VNI should be unmapped
 	 */
-	mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+	__mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
 	mlxsw_sp_fid_put(fid);
 
 	/* Fifth case: The new VLAN is also egress untagged, which means the
@@ -3923,7 +3929,7 @@ mlxsw_sp_switchdev_vxlan_vlan_del(struct mlxsw_sp *mlxsw_sp,
 	if (mlxsw_sp_fid_8021q_vid(fid) != vid)
 		goto out;
 
-	mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+	__mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
 
 out:
 	mlxsw_sp_fid_put(fid);
-- 
2.47.0


