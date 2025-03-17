Return-Path: <netdev+bounces-175415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DEAA65B1A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5841685C9
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98941AD403;
	Mon, 17 Mar 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XRKI2kIR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E71ACECE
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233241; cv=fail; b=stb68IVUXbfVeV6l9lgS3hcTNL1IH+Q784PHphAIq9pVbXs2HS8ofwpsTlctKJK8zkxIY+VhnI78k83LT4ECZ5Yobo42M7kVzvjWgc0aY4UJHauyFiOicWXXaXgITysSyrMao6h8Wntbo6osdw+Z3UrDAQJl4J8iCqznGgkB+IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233241; c=relaxed/simple;
	bh=4gLtf+yt6c62EkfgKWhCgywY/7J2I9czV/pPdq/HpcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7MEiQugkqpkX9mBvOOadg+7lMVStUq97ve7gf4u7fKh/cU63YIdLPNffDpD285uESg/siMKrsHe1Fob09r7eajfTMxqpHhPbWcZaQPeu2JNVR/cql31lI6h1R8VO0T1M13fPJbqoE8RtOIap7M0yyz2ZYSeOrcnIsEdy2HJU4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XRKI2kIR; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYqtSKAYI4PpaW2ffGdx9oNLuIv9sv3R1fMKUWmvELKF3Nu3jrp2sMul1AxqgAJSvmL3wVIaMmjzr7BuwF2B2cR1QrnRDlUA8xlh0cdLg4uZwdC/vFoc91wBr7u1uKS1wXNyXOv5tKI0T4C49rn1S3Mf/YMUyl5u5p+WoGoaYa2B13yr+C2eLYGb+GEw90dDBZfr9O7rG7mb0k/5FOz7DCUj+ISijYO1GqTgIZQzKkki8otkphq641t8eDDatJFUvQNKnkrddNlLdgxCiW856TFN1ou4xHMRTWOcaYUn0NwFAiBp6jt9E95htFDg8GQz+/gopQfsSiZjY6g1Q6Jykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyfjVq5laykueUcFx31nQXMz11sty6JOLXq2+ua0GBs=;
 b=BnkUr1/YMe5zuP4tCew04znH9xd51rc7yTiXegjQ2ZxQDVStxhYxIkbtL6gVH3J07cgOUqvHYEE4x1J9s9chLo0+oKTF2UPZLbZopCbkhDaKW+qngv/GOYEGpNovmdws0SJVEwwjuTd0VTR4BamzeELWTW2w/AXX9uL1alRG9Do3+3YwvBJ/nAkNy7cujYaf9PbD8wRx6pgqMqnOnAFQDnC7bIS9h9J01b+wx6lUhPAIPnNye00p1Bg1HNPVfpmoHLlumlngdN2aStHKIooqjyCINIrH6Qu6DYWq9iKwPQCPNkeFA5Po6NsjGFz4vm65DNQ5vtAPmPFidO1gfvS/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyfjVq5laykueUcFx31nQXMz11sty6JOLXq2+ua0GBs=;
 b=XRKI2kIRq1I7SnGi4uFHd5JFACRgQw41RCDUZgJJFPTOhki5vZwitNEc+J4TtlZrc8CKV5XwqVAVmpmlLVHATlL7gdcVykJtpQ/WyVsR4vu7pgauQQYisDYQVCAHf8Jw6HDwpRsCG0SZy04eHGfhUPjsV6fde+XArdeUK0nl0E/WXQgkObetKavLJ2Zq8mNVkPqwQeDGMwKeZa2qbIZyUzc9yRyQalf1aZCxXhAtZNvyUlLBeLOkYTEPTq9UU5EFHDk1dTNxFYhG1Alyzcr3E4n4VX7EL3elHdoA2XvrjrJccxYP8WpWRxj2XxkdkM7KesLo8sBXxvh73lSjve75yQ==
Received: from MN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:52d::27)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:40:36 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::f7) by MN0PR04CA0028.outlook.office365.com
 (2603:10b6:208:52d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 17:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:40:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:40:19 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:40:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Vladimir Oltean
	<olteanv@gmail.com>, Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
Subject: [PATCH net-next 5/6] mlxsw: Add VXLAN bridge ports to same hardware domain as physical bridge ports
Date: Mon, 17 Mar 2025 18:37:30 +0100
Message-ID: <7279056843140fae3a72c2d204c7886b79d03899.1742224300.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 24115f95-902c-4df8-ea25-08dd657ad321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0nfePRECHFp+ehIod8JfeuWGfncBTF7mB+pqBq1QdToc0qbI95AfFnRB2yMF?=
 =?us-ascii?Q?X7NWncM0YIQWANKK8/DaV9by17glao/lmPFDT5PCxS4DHK5khNeTbySw0KAw?=
 =?us-ascii?Q?CSyvNR11zRBM/iM51EI4/VAP0uTL0DK15oZfENmGjdu3Yw7i6X+hlicpoeC5?=
 =?us-ascii?Q?M85YvJ4i0sAgP1qUvRUmVYgd0LO+fjhaHWHNBN/CdkKIF2Oph9rZ4t/0caVQ?=
 =?us-ascii?Q?uZEN4xsyphy5cX13NLyntCF0xtVuozE6UaP2YZuyis9Psp8D4mDAxRnN8XXG?=
 =?us-ascii?Q?5ByUlhbmtxWva/NA7OVGUHubOuSCBZRzhwg5r7j8P1+vz4FUQ34l1FY6sVZM?=
 =?us-ascii?Q?freggZdwFiA6c16Sr6K+1PruCwSz+g3f8/++tShBKb3bxOMHq67Y1Z6fVGpZ?=
 =?us-ascii?Q?Pzw1a0/V/iNyqYzoGZ/h74UZF+VVtGXDGKwHs6dKfarLGdflOPrA8rX4BMpC?=
 =?us-ascii?Q?kD6L5ndWnIhyz0f+9pylw750p8A8KaQ04PNYztw+ocw+lGojMiKJZPj8eVBL?=
 =?us-ascii?Q?/QvCIWhm8dyFNrZKXIbrtA0ihezC7hse+1VxFStpD57j8gEXPgO+/mfg0OLo?=
 =?us-ascii?Q?ppjR+M9UeVc+gFo1XzMBFZ0SU/ECQJs0Xi+sydBzA7FpMMhXe/2aIOBEEmN+?=
 =?us-ascii?Q?WBAkddcfNVYkGqdTHjO2zkCxZ0h7XihiSyPqMzWTyIQJ6qJCuBvOUVqU9104?=
 =?us-ascii?Q?OCTtqLRwBhwx7qeybotO1UOS4GQJ3pXXy1aqoAjDF5Zr6dGgWxUWIx07vr+Z?=
 =?us-ascii?Q?JHnLv6Lyt8+lRgTBxj9dObH05Xzy4lIv657IZRmsduTuzN2COHe8ciUJ/BCL?=
 =?us-ascii?Q?7UjzqUKjN92+mZXAqFeNOnVyiS4imBVWWahMgKcrekKrewA+aGE0XUpw8dEE?=
 =?us-ascii?Q?/SSj1F7Qv0/Kd2f1gT0LK3B1Yq9tPxjA8qCTQXNu+fEOo0vPaHyZDr0Y2IMR?=
 =?us-ascii?Q?+p++3vYF4d1EV8kP0XJDm0GTsC4bE4hAYO5mplcnuJaZrI6cgzebz+z91MfH?=
 =?us-ascii?Q?3qbP5TJkOpHehM/3ouLRv5EYzEIs/cBPAjm+QrWUspdiFqpfmav6IGss+VU/?=
 =?us-ascii?Q?LtjTBHOuPvZbJDyp7z9YyNKtzuLWYshIUF1UeTaesiFAj1+2QEEGtswHdrvM?=
 =?us-ascii?Q?IovJ1ET5PZU+MQNy3SnDxfQRGZrAdbYwWN0ReV/2iy1K8w52ZKEOeZqQe6pp?=
 =?us-ascii?Q?pthpCcEXMnr/0/vX8sFH1jZN9vPiDnlGsgAs74M8yEVr+c/AMBkKt9uDFKIt?=
 =?us-ascii?Q?9cv3ZIcMNZK/3FUXci0yTQtb9BZOHONxICwqif84b5kOeRCGGlZb2gS+0ai8?=
 =?us-ascii?Q?y7fwXy0UdYeRWg/gqc1/9UC6Sa9K3Sf0K4jEY+49wK1wAl5xVkeTyFxd74/p?=
 =?us-ascii?Q?2phhOsZlYSISwDVjvUtbBfpC2gQ2++ofAAGprW3MWfXWI7Yu+A4NrGw+4mO+?=
 =?us-ascii?Q?pUkSOO8Mbeq9McUaNXeiGNmZqI7uvo0+DS6ZN3VDPtAV+/uzoCK1rLq3wmgF?=
 =?us-ascii?Q?Oo3nRM+W1H4Vxi8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:40:35.7077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24115f95-902c-4df8-ea25-08dd657ad321
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631

From: Amit Cohen <amcohen@nvidia.com>

When hardware floods packets to bridge ports, but flooding to VXLAN bridge
port fails during encapsulation to one of the remote VTEPs, the packets are
trapped to CPU. In such case, the packets are marked with
skb->offload_fwd_mark, which means that packet was L2-forwarded in
hardware. Software data path repeats flooding, but packets which are
marked with skb->offload_fwd_mark will not be flooded by the bridge to
bridge ports which are in the same hardware domain as the ingress port.

Currently, mlxsw does not add VXLAN bridge ports to the same hardware
domain as physical bridge ports despite the fact that the device is able
to forward packets to and from VXLAN tunnels in hardware. In some scenarios
(as mentioned above) this can result in remote VTEPs receiving duplicate
packets. The packets are first flooded by hardware and after an
encapsulation failure, they are flooded again to all remote VTEPs by
software.

Solve this by adding VXLAN bridge ports to the same hardware domain as
physical bridge ports, so then nbp_switchdev_allowed_egress() will return
false also for VXLAN, and packets will not be sent twice from VXLAN device.

switchdev_bridge_port_offload() should get vxlan_dev not as const, so
some changes are required. Call switchdev API from
mlxsw_sp_bridge_vxlan_{join,leave}() which handle offload configurations.

Reported-by: Vladimir Oltean <olteanv@gmail.com>
Closes: https://lore.kernel.org/all/20250210152246.4ajumdchwhvbarik@skbuf/
Reported-by: Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  4 +--
 .../mellanox/mlxsw/spectrum_switchdev.c       | 28 ++++++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index fa7082ee5183..37cd1d002b3b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -661,10 +661,10 @@ bool mlxsw_sp_bridge_device_is_offloaded(const struct mlxsw_sp *mlxsw_sp,
 					 const struct net_device *br_dev);
 int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
 			       const struct net_device *br_dev,
-			       const struct net_device *vxlan_dev, u16 vid,
+			       struct net_device *vxlan_dev, u16 vid,
 			       struct netlink_ext_ack *extack);
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
-				 const struct net_device *vxlan_dev);
+				 struct net_device *vxlan_dev);
 extern struct notifier_block mlxsw_sp_switchdev_notifier;
 
 /* spectrum.c */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 13ad4e31d701..a48bf342084d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2950,22 +2950,42 @@ static void __mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 
 int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
 			       const struct net_device *br_dev,
-			       const struct net_device *vxlan_dev, u16 vid,
+			       struct net_device *vxlan_dev, u16 vid,
 			       struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_bridge_device *bridge_device;
+	struct mlxsw_sp_port *mlxsw_sp_port;
+	int err;
 
 	bridge_device = mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
 	if (WARN_ON(!bridge_device))
 		return -EINVAL;
 
-	return bridge_device->ops->vxlan_join(bridge_device, vxlan_dev, vid,
-					      extack);
+	mlxsw_sp_port = mlxsw_sp_port_dev_lower_find(bridge_device->dev);
+	if (!mlxsw_sp_port)
+		return -EINVAL;
+
+	err = bridge_device->ops->vxlan_join(bridge_device, vxlan_dev, vid,
+					     extack);
+	if (err)
+		return err;
+
+	err = switchdev_bridge_port_offload(vxlan_dev, mlxsw_sp_port->dev,
+					    NULL, NULL, NULL, false, extack);
+	if (err)
+		goto err_bridge_port_offload;
+
+	return 0;
+
+err_bridge_port_offload:
+	__mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+	return err;
 }
 
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
-				 const struct net_device *vxlan_dev)
+				 struct net_device *vxlan_dev)
 {
+	switchdev_bridge_port_unoffload(vxlan_dev, NULL, NULL, NULL);
 	__mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
 }
 
-- 
2.47.0


