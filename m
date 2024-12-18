Return-Path: <netdev+bounces-153089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0E9F6C27
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B31616FB0C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D71F9F7D;
	Wed, 18 Dec 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DWN7A2kp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C91F2C21
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542250; cv=fail; b=qsNjHLFPq108raQukYmG5mAAwOBXJ1eXrHo9o1b97wpJIFGsROiqIYJiUxIDxGogu5FsSKTa1wx4Xs4CzP2cmeN9R8ksDsGMgUclvKkJb0kJbSZqacbXtRy9dSYALGOubSLGz23HeWaJ1b42wKwg672ZlAL64h3+HwfCWisKnsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542250; c=relaxed/simple;
	bh=GFaAs6SN0Lv5GiSWvB9K93eQfbNS9FZp8ts8RQU0d8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ0hVbtFz1QmcfqZMiTWGNg1SFnHhx8NXXMzTdkPamMR4MRx9RW1moVhJzm2EEE4wgkxJ9kjYAwNFKaCC416hlJKbu8S06Aw+6FyahD8TSKd5Izb8u2KllI73roDSO62AqvEuPVYn3Bc3+xLViaxkGmYlTR4Lmh15P4SRF88hL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DWN7A2kp; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzX5pS4y3C6pHPEBapKO8aXzwGWr4b2hdnixkFMQ/47k6RMzwVr7e5evgpqYM6yfqLkbhwn9zimDzTX4uAgkUARQKeFpag+lCt+oNCPsE2mwH6NhEtmFhEoYVs3HzEZwW/nRos/vsvv3JwOQWlZGtOatiFW+K83gqX8efdRxrzqLMitD+2jKi7GUTxJK4lF/vXPoiF7zSBn++FHsOeOszPV7fv74joCj0z7G7Yg9qJWJLwxZXV012yiS5mSp+gKgZy7GHkHilVuCg1g73uD50bl1ekrcMQVw8jp3JGcqyErNpD7KciK5QFyio8uJQuR/2qBGm2j7tqaN/xVbuW2k3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McS5knX+eG+NbrBYmzxsRf9TB684IRQqlj2PQBzwZ38=;
 b=B9QKN2BotkV2xwld7i0G6XMOZzdx7Z6ix+ZnqS0j7LxUHDaX2iJLhdox2Qz80gBzFatmDyzt5nKorMPDUV3P9auxHlSLLLUeE3eKXb0XFPq9H4BNmOYDjH+7HRZ7+rGKGAc8PkVwcvJ3tDwEnFHrm8GgVTzKvH8d+HHGYN29Cb4ww1HWMu1vgnA34BSF8ODcjrjx9QgkUBmmNjEcrVRCe5hZoYfovpb7GuLfMpFt8BbQWPV53HHbGkAwsTGszc91XC2AKLUU8VCU7xUPBtawGe205Fdxdf6ZImxFF1uB+cwPUmpQBCfqIuDGiAjWwMpOWM79ehm8OfnKcYDe7jEVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McS5knX+eG+NbrBYmzxsRf9TB684IRQqlj2PQBzwZ38=;
 b=DWN7A2kpEOW7GJf73B020JV1tVIAOP/YwqfDBsorZmNOgeVNkMvRER5nbvJHgu6ZkcfvMe8o6nIwWWId9E8S5txYWeZil7bakc8jo456Cns1BvLKx8Rt3a6y+7vRF9IsaUbgJpFePy9kCamGyuuYWBHsenKT4TVAp7/gzQlq5dPdS17yjWy7cUFY1cWvOoL9zCcrgnPlZGFzhB6xlCeMHHdZH/7vCbSXf865qu0kUHJtFwKa4Xwj4G0xwjKRp3m6XQJJ+izKtzKbrG5nsc8XdIaKLIBU+67P6iLosYMfG5cSVK1HfKk+2lhalNbCSxcfgEczhbsBvoDlvV4/i3bB6g==
Received: from MW3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:303:2b::32)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:17:22 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::2d) by MW3PR05CA0027.outlook.office365.com
 (2603:10b6:303:2b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.11 via Frontend Transport; Wed,
 18 Dec 2024 17:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.6 via Frontend Transport; Wed, 18 Dec 2024 17:17:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:16:57 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:16:52 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/4] net: bridge: Extract a helper to handle bridge_binding toggles
Date: Wed, 18 Dec 2024 18:15:56 +0100
Message-ID: <a7455f6fe1dfa7b13126ed8a7fb33d3b611eecb8.1734540770.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734540770.git.petrm@nvidia.com>
References: <cover.1734540770.git.petrm@nvidia.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 52864803-94a1-4eeb-dab4-08dd1f87d5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t1cbyVcUTObPR1V/sRCHxqJaTWgly4tDdGCrRFeGXQlzji6WnqXRPnNuk99+?=
 =?us-ascii?Q?lpbz1RzooSA4ivqRK39VtzA2549rA6FAdMqy8DntCPA7eGkXWTFDtYezVEXI?=
 =?us-ascii?Q?ee4o3BewoWY81Sb6ofmgB/cEoLz2sfjhzvPNLd/byyO7QTsUlQvpnRuG1tin?=
 =?us-ascii?Q?l7ersTT9XTaKUTglh6TIXqGpYsFa8F23coLXmnGyEnNptuEE4vCL8HULlFlT?=
 =?us-ascii?Q?iN4TgqMm6UutKDswFp/ALAv/DkboCIubq9DA09tmCQfNAh71V4Rx2mi4iUaq?=
 =?us-ascii?Q?+8A4wMfiCio0+XEkTS16Hbp0vwBavZTddmh265gf8UoTWqik+sOLN1W2pXlk?=
 =?us-ascii?Q?skyics1Mm8qDraQrrRp76oxATBZ3uYzRgAaiAmjVbdoPpRBpFJPcaLZZZpVy?=
 =?us-ascii?Q?PT08Y9IcUlIwNbJeCuLc7xmj/Ck/s90eEMHdFJl/5CbZwcHqa3PWf37U6d+L?=
 =?us-ascii?Q?RdP81w8A7tR9TYByiYavVh+aYGgKf1C3lqbr9EA03dxHrDgtZktq14e8z/mo?=
 =?us-ascii?Q?EwUYkciXfmmvOKlZFEGf0sGd5/T9ncxjtDhqqb2CE6lRptnvn8Li1TOYJhAv?=
 =?us-ascii?Q?OxeNT2KvzdZuxU+aTyhbyvMqBepPMudGu1DbRFITw+wChn/W3C0yHArx/Lui?=
 =?us-ascii?Q?XgkseB5qzh5qDm9tfMN3C3I1O8qZWAaaiEb70SIraSWfrINWvS+aqTsUsc/U?=
 =?us-ascii?Q?6iQyaEf16DO8JlnzggpCn3D1MHyX678FMU0Yzq6yO48xwXDsEFJCMI1YoGwZ?=
 =?us-ascii?Q?38aeiMfGkzBPUciN/WPCbS9+1iCPBs+1Y5QRcynQGwc7rEgRafdFAqghZM98?=
 =?us-ascii?Q?TpP6zmMaw18CyAWfHYVBg3T755N80+Pxc3Ny5xSE/rnqJ3k5JPnxVoQG/PpU?=
 =?us-ascii?Q?Ixv7a2u3069k7A0LuUsCu+g5MxCW1FqCpTErSqZABKDSjaCXJRVktXpcZxCt?=
 =?us-ascii?Q?uty2qMix+uOL3edde563niR+gk3UrL4pmBY+hX7Pb+jEBDr3DbK5Ix9CLYtt?=
 =?us-ascii?Q?bqnuef1acywR4nYQb04mspGFYevZ5WHZkcURRFn6LyTYAz3WkegeOFkQMbkq?=
 =?us-ascii?Q?Ea51cPV7bFk/NRTTJelbkghh5WtCMnM5rlZ5Pe16VOa7uDmNce0Y+6ZqMmsA?=
 =?us-ascii?Q?aMOIJjJIct0CkaGs4hJ4yOSwkUfiRqEhpZgjZ6R6x/M4dcjyfThOKvzqSbTZ?=
 =?us-ascii?Q?0ORUVXArABP+CYneHcW3IXJeNnIWLQ+nckg1yWBOISsdFRj73KAALil3h4Ws?=
 =?us-ascii?Q?Wh/EAFvJ2CHJpLcJfe5qPcs59GoBIwhQedaKpdalL7mOEZxQ0cJcZnR+mGas?=
 =?us-ascii?Q?YxfJEnx6hb3lgqyqTzedw7c0Tb5BuTO+3dX2+CKTh1XQVxqCUgRNFce8Y3L8?=
 =?us-ascii?Q?5TJY8d34GPZavGXABUS23jUX8fiLN67EqzeZznGe4+5dQV5ioP7eFGL+nJOW?=
 =?us-ascii?Q?ChCLdP77hupFonhkYsdcXMIbnynCqUvuImwDN5A/jCFkP95JzML7DO8PQSXu?=
 =?us-ascii?Q?SsD46OcXjFuI9Lk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:17:22.4245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52864803-94a1-4eeb-dab4-08dd1f87d5e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

Currently, the BROPT_VLAN_BRIDGE_BINDING bridge option is only toggled when
VLAN devices are added on top of a bridge or removed from it. Extract the
toggling of the option to a function so that it could be invoked by a
subsequent patch when the state of an upper VLAN device changes.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_vlan.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 89f51ea4cabe..b728b71e693f 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1664,6 +1664,18 @@ static void br_vlan_set_all_vlan_dev_state(struct net_bridge_port *p)
 	}
 }
 
+static void br_vlan_toggle_bridge_binding(struct net_device *br_dev,
+					  bool enable)
+{
+	struct net_bridge *br = netdev_priv(br_dev);
+
+	if (enable)
+		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING, true);
+	else
+		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING,
+			      br_vlan_has_upper_bind_vlan_dev(br_dev));
+}
+
 static void br_vlan_upper_change(struct net_device *dev,
 				 struct net_device *upper_dev,
 				 bool linking)
@@ -1673,13 +1685,9 @@ static void br_vlan_upper_change(struct net_device *dev,
 	if (!br_vlan_is_bind_vlan_dev(upper_dev))
 		return;
 
-	if (linking) {
+	br_vlan_toggle_bridge_binding(dev, linking);
+	if (linking)
 		br_vlan_set_vlan_dev_state(br, upper_dev);
-		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING, true);
-	} else {
-		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING,
-			      br_vlan_has_upper_bind_vlan_dev(dev));
-	}
 }
 
 struct br_vlan_link_state_walk_data {
-- 
2.47.0


