Return-Path: <netdev+bounces-175414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1420A65B19
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2813B174493
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210121AF0BF;
	Mon, 17 Mar 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhlLTv9y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751911A3BD8
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233234; cv=fail; b=Rm+2McTyAqHQYzshmB/jgzssJMXmfqgpJZEr+tB0smvsXrwoOSX4/pNiOiy92c/wHjoYhquU4n6yL0aLsWPHJ9wonC3bVmjHruNdCYR6cgh62rg9caF8P9KkSQ2f21zlqNT/fM/bnkPt55iQeuCbLHAvd1vHRCfBTB0lOTe720Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233234; c=relaxed/simple;
	bh=CuHdI96jeowwsuQVEzllgMg+cNxtT5+claVO1iiyvkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyMpeFdaKQMues80pSR/nwW4FufaaGJOclaeL6vaZQVymDJsqkZvMVxXrM+gSo2dAleeVnss63qjQIYYWBTzzsx3/aQIEdxEj0Gfa+ahX0u2S/suk77psMz66NF76ZUbB4Sln059YbGBxUuvPs6N+bfLznLLeYUnl/R3EX8Jddw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhlLTv9y; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E59wTTRxfaRdrjWjWUPgjmjrJCOn1B/HQ2JBQhifXBENcvb1XJrgfblIVxhvofZejRLb52Xq33UpDpuDWksyJOJyFiMIpQggI3T9f91AZRxpUdBIYNyID2MRHIh2nax9J9qDk3ylYOmJwdYJvI34psH4BOzbdGsbcGPgxD6cJxKPwpy47Ug6co1sau99y7iJsCAPnW4Mv6LvrG6mqvJiyHcY0hEdnQx5F0rMf/NzUt+jxQVufi423/RczZlW7AK9L7mhuGJQNUP5wKhThnfQwaafFNJYF9M88bNR6BKdx33g/Jqlombffn6FmEMINAG+WLNXNaPU9QsHquM90OcgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u46+UHEKviopyN1/H1v4qeV0ZyLM8r7KQN7wZnRoXcM=;
 b=Jv0iUtpRR4g1tajufad7pUQYXhqcS1XfQrUgNkL50RTo55M5IBb2ESfR12bXQ55d+om9agkA44WzjaWCBO+c1cILbMb1KtUCdEoVuHYNq+RYaLGBMdwjPCirLbz9STtHgEnUKCNB10oV2regqT29cIsO201r9E2FCqRzyCJnCesOBNzzu6m11nQXi/B2PpftowLxkAV2t1r9HbJmwFiLb+n4Vg55H7GpvveRWzr32GLcNDhVpSgQYsMth0TaLC9pCrtnzbYsnDyvnHQCO/xgIXy46AKwcxNRpBgD2IcFaUMCyHb36iCgz+7ckgf+ePH6x1A813zX6nmemtASRFdEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u46+UHEKviopyN1/H1v4qeV0ZyLM8r7KQN7wZnRoXcM=;
 b=JhlLTv9yB14lFpvxUrlpZC2g/mdjgHCQYj7BjKXn11/Qf706SC+452+nWF9beYD+BnVu7u7vAtoMNJmqqIktGDN106VxFrM2luJ9C9zd6C04w60VeTrAsfvVGhnNu0pVcZe102CUM4FPw7kyuM03xNpylAJ4024dyYUBbPgG0WPOdxLC+3LBShy62JGTSWyvBADKQfkK6RAtJKYF0GwYN80Sug3TBzF+7bH75SogWDFieRuD1pp9utKnGf7dNURB3z9aFbMD+s+Y17LT+8Q3z8ICZHmPdqg/2aiTcu3p+ms1aLXt36uzXKSbDcsjGHfZzt0MdmFdGVDBwQP/td02fg==
Received: from BL1PR13CA0399.namprd13.prod.outlook.com (2603:10b6:208:2c2::14)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:40:28 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::30) by BL1PR13CA0399.outlook.office365.com
 (2603:10b6:208:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 17:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:40:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:40:13 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:40:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/6] mlxsw: spectrum_switchdev: Move mlxsw_sp_bridge_vxlan_join()
Date: Mon, 17 Mar 2025 18:37:29 +0100
Message-ID: <64750a0965536530482318578bada30fac372b8a.1742224300.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: e5832b03-6e7e-414d-922f-08dd657ace41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dJlFw39pUelDevV7x+S/bhekQyK3wgjQ+ojX6YoJYjIfyuzmHWFMlEOL920?=
 =?us-ascii?Q?VpngpwBOImxQHRfPSandCGmhiLkbGdQNtc6aJ1zGxbddZDEL5mxIBSrj69Xj?=
 =?us-ascii?Q?rYfzhJKYv5rxoxq9Ew91W5Z7GwokdxZLZI9slEgUemcYpl2aowyoWXQF1E+c?=
 =?us-ascii?Q?eBpELcm0tWqiQIoD2Z785h2epLteT4bOxyy2MiMVkDotQwdQ5Zz0NMARxZTV?=
 =?us-ascii?Q?9l5yKifVzwIku18vwgjiogk3VFLdxRIz6rFpX9puM0hPa3fx1As4xmaQH2vH?=
 =?us-ascii?Q?1Lqyinrv3yXgDh9pvkTw006hzs3H2JP6lo+pI7Ql9kT0/RXRZpjoTjm3xJYg?=
 =?us-ascii?Q?jnUYrGsui0C+hZv+mInHRM+eNl1DhbspOBjeZ8FjsynQVWkfFwcIXUs96Xuv?=
 =?us-ascii?Q?YFM732R0JCD7hMSskIbFcElHsHXqLg5b4X1b/xvwOjUHvc7DsOhslVKHpftJ?=
 =?us-ascii?Q?iBjB2ttbFs9N8YNxp9z+YlKLWuaYxofIBHYBJ2rJ1cdMW98EuPivtK9sRFex?=
 =?us-ascii?Q?a7SYIeRkHsyqqnPURPI7tGi2knw9xf/9VTP/RSAsawI26oGAPvHknl9nEoot?=
 =?us-ascii?Q?rr20GkjxuoT0xEW6DCFw4D8w1X7+TTtXE/BNfeAztX+Y4KDA7Rs0aC1ALiDQ?=
 =?us-ascii?Q?uImcX0CKY32VDEwvfhRb8wbMqPE0s4nfKjOfnBTvhQI+oO4r5jL3/w1nYLBl?=
 =?us-ascii?Q?Bj5zcnh4t1LVI50rBrz5Rz5NmpJjHt5F5Hr9bpzTwk1jJimYkWWVxwip38+y?=
 =?us-ascii?Q?G8VCR9tmkgCIB5DTDRPsaIRSeRzIIoiF9FRJCHLKJM6PpitzoeBptMQfhVX3?=
 =?us-ascii?Q?TLIjb0w98CdG6gGt1VGNBMHPbV6KyVfjrBnRHRh8/Sl2wztTdbPSNNF1bjSI?=
 =?us-ascii?Q?hiSr3mZp188+GqOxAptu8Bble94qhmj7YEODa/h5APgj7PQ1Xd0BsCW4CrZk?=
 =?us-ascii?Q?akDXL3H7q99xE4YA/fxSgvkupjLC5+VGdab2cPPkQUBZAftTUxxzSUmhNGYi?=
 =?us-ascii?Q?VRLBDzEPaMSo+HhDTm4jdr3v8YEHWREK3TPTwTgkGc03exdcfujhbFJUZzeC?=
 =?us-ascii?Q?yRhsLKqwKNarACnR3f4z35am7un32tfGdt4hph3QwjrGsdgpIkE20yQDFN7w?=
 =?us-ascii?Q?Mba/r9/MBCejtMz4WUbtb7YhVgnITR5D+v0oxQQuwUw/MMkRqGiJj41y5DfN?=
 =?us-ascii?Q?Wp/pfzKs2kSFOQHHxSUnEyDZhYwxVwq+SkI8n7sxtztwWaqiQ7ucLs9BbOvL?=
 =?us-ascii?Q?XQZ8qL7gIgUJ2aYcMIOddzd2Q65SMBjt2GSq6TnJwVcLi07Z95TEDQ2Kp6LI?=
 =?us-ascii?Q?XcdUALXHOQnTyeaXTWQBs00YaEXi2sgieZmwNN35jCw98M9LFnhNoJ+SDgDg?=
 =?us-ascii?Q?zbJuu0PsapqRlNOE5c3mlAfJovniNBCfLvUrmJFC6399gr8l04t7+0iXxchr?=
 =?us-ascii?Q?dHRtfnRNjqxCe9lc0Z+6c6vLavoTYmrLEPmfUUFRHwYeIPDYuspwPzBIg6vQ?=
 =?us-ascii?Q?qj0c4F1NEEsjm+k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:40:27.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5832b03-6e7e-414d-922f-08dd657ace41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029

From: Amit Cohen <amcohen@nvidia.com>

Next patch will call __mlxsw_sp_bridge_vxlan_leave() from
mlxsw_sp_bridge_vxlan_join() as part of error flow, move the function to
be able to call the second one.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c95ef79eaf3d..13ad4e31d701 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2929,21 +2929,6 @@ void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 	mlxsw_sp_bridge_port_put(mlxsw_sp->bridge, bridge_port);
 }
 
-int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
-			       const struct net_device *br_dev,
-			       const struct net_device *vxlan_dev, u16 vid,
-			       struct netlink_ext_ack *extack)
-{
-	struct mlxsw_sp_bridge_device *bridge_device;
-
-	bridge_device = mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
-	if (WARN_ON(!bridge_device))
-		return -EINVAL;
-
-	return bridge_device->ops->vxlan_join(bridge_device, vxlan_dev, vid,
-					      extack);
-}
-
 static void __mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 					  const struct net_device *vxlan_dev)
 {
@@ -2963,6 +2948,21 @@ static void __mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 	mlxsw_sp_fid_put(fid);
 }
 
+int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
+			       const struct net_device *br_dev,
+			       const struct net_device *vxlan_dev, u16 vid,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_bridge_device *bridge_device;
+
+	bridge_device = mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (WARN_ON(!bridge_device))
+		return -EINVAL;
+
+	return bridge_device->ops->vxlan_join(bridge_device, vxlan_dev, vid,
+					      extack);
+}
+
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 				 const struct net_device *vxlan_dev)
 {
-- 
2.47.0


