Return-Path: <netdev+bounces-175412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A263A65B13
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D4B3BA87E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE71ACECE;
	Mon, 17 Mar 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMQ0twEX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42517D346
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233223; cv=fail; b=Yjv8gfojWE9V+8FI3KSDNtONDHdWFLpiw18e12YVe8UFBE7drObJ6/ah3H5cTlZkIAAUp61uQHaOlNuqzRYDSwszI2TZxL5pQQ5QhJwy9jVf4VQMqCXRSN0nbiZv6MALw7O+xb/M0TGdZWMPOjLLpQidHZezWDroNb5ugQ8PsWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233223; c=relaxed/simple;
	bh=AZEDJRFStbuBN+7ndH1MQjwYeEifT6zOGRKIZKczMvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRqloUN7B84Rx5WY3wQPmymRX1MfHpLD2BVjKAMv3lvTgnX6oQB5C5FpHxVX78Z5IgPwSUqKhkwq7mCpdZOKqQkMtGJenopHuNKuoQruSOqK0WqaQGX+4u9oSWVsYCSV5IkM3H//qL7Y/yLooGmcrhPgQBrIFiW+JdK9UfR8aTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iMQ0twEX; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgqVvhJmZdu/MvoKnNlgjQVrnmFMFWdiAVdojrfGHpvhhe6+FPYz4fBeHSfsOUa2jBtIo4t9t0YrzKHu4lkq6rp4fw8Cy4yTq85N3LWocvnV1c84cuOvwgOj91qOcOYB3S7J8inbLW2hvTfa2qrwVy1St4oXadqXkRRSxwp/P7EvjouncfhgrHCpAIdh/BryuVqYFnQt7KvCkw+4xYACqLWjJn+2CNX5gsPMENYwo8Zbz0st/mhSNJ0TPf9Dp2ynW0F7p+AEzjnH0JPFhWrOurS+1kQMvlXfDMIm1Ru/CROa8yDHVPTpTrAY6LZg7n6fMkkJUDdr5ZGP/HhUMM5BnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6/5Tk6K5qIDGHag+80GovjF0N6dse4ITi0Xps+8ooM=;
 b=dmvtWPFEyo7Q16poneM82LmVj7MuFdu5+GmLaOzuhOAJbfFflDsYfRqigTH5npVnF8EqAqjC9r7rScU4YFF7o3vaWDew9Fxbf0/EkqpE46Zkk2gcHn915i97e3tzp2BmaVipzqrhvPScSmfu9GElV4ujUX1fsRlLRf+E0eMJl/ozx7RHExwW8kIHV93Pxl6uX8Gq6ujyiPp6VG7hmK3PqWPnZ6thWihH6TVpePn+OD7Bj0fHF56JTu2+6qnEfet36SEsFEouX0zzvIhD1MwoZRm+enuPGcGMyUTHuNC27o4clOAHSSA+Pu8nhVEJGclImQoPXu8tsjeebrKfvKgQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6/5Tk6K5qIDGHag+80GovjF0N6dse4ITi0Xps+8ooM=;
 b=iMQ0twEXldkVJk64J4By2lAX91rfk1KuGY7/4aZMBZ7IKbU0fk+7H8cLAF4XKHqfXW5z667sjKt8XAOAygN7ZVj45ut87tefVq86x99xfuy1hkK2BnBWE6IuBA79a/yw9z27iJTMXaCBNJC+XXTpK35Tskg+XoXxBWxL9XzXOjwRZN8Qw0o3wQWltzMvq+FTWmz3kezJd0E/HDo18NbfD0dPXjv95iv7nJhLHzehXE0j4UZRV7MlHJOHSpVOBK6RsDzBFl1/Hnn9GO6ItL6FiZPKCtTdizr8BxNjg7JBgEYMkxHM71d2sRXPil4fWXWa4PVe0JSpw7JlCSiXaD0hng==
Received: from BN9P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::21)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:40:15 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::9c) by BN9P222CA0016.outlook.office365.com
 (2603:10b6:408:10c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 17:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:40:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:40:03 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:39:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/6] mlxsw: spectrum: Call mlxsw_sp_bridge_vxlan_{join, leave}() for VLAN-aware bridge
Date: Mon, 17 Mar 2025 18:37:27 +0100
Message-ID: <994c1ea93520f9ea55d1011cd47dc2180d526484.1742224300.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 17df3c30-54ed-41d8-00d1-08dd657ac6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2X7pT604b5TWDZrigGSHMgr7vyHKzVZ4IJKX0sY4DINiPER5zXwPJV9Tr1QM?=
 =?us-ascii?Q?fcV3sDF4BUVtX4V5o0LwmkzQiT7xLRu6ynSy8McbgyrsmuwOvlMrPCzdoTN9?=
 =?us-ascii?Q?rutCXHVY012oWi8gChK2YxyYX93zX2ZpuN24V8n2skLGkxO+YuiEr0SIp648?=
 =?us-ascii?Q?6HNHf2YA6ByM0/6hwmy9iZd6p0OKpsrT1mBA5ja1QWxNLPS8Xv1qL736gdK3?=
 =?us-ascii?Q?sLDHMxBeLoKU4OQkDNr1BH2XhvTqoFY5TYNc7j1fOOdMJuGzmHg4N/e1SuPA?=
 =?us-ascii?Q?iVfdEhnsAYokQY72GmUdRlJ1Ov7Lk8lCLjVCCR5uBx7rQoKbIgQe7JignElj?=
 =?us-ascii?Q?IFguyv8OFx7jePuKvelIlZcFrm17Q1TV0v3ZaXdwUzjtDlj+UuHj3I+GwAFE?=
 =?us-ascii?Q?rv8yGIDF80a5stPQ+7zbV8xFkY0seIYuKHIyhK6KYMGWeAT9ousEf+7btaJi?=
 =?us-ascii?Q?rTdbbmXEaeOIXeVAAIowHr2rKktJDIZ66+7VGdQHK1m0aqGUpfcRxhfLyuWt?=
 =?us-ascii?Q?5xRaRnu0uf5bfSuVcxsTKIc5OCh+CMdRQI4h57AgL4kcZvR7cH3326wL1BjA?=
 =?us-ascii?Q?a7FMlZHS3tRAK2dH8YUaCovSRYVNdGIo9dnCzUj8zGHecQ9rGYCet9b1wfP3?=
 =?us-ascii?Q?tS25LIyeD+mSaD1VE5zW4sqTgfuyLmpLAGY5CyqSaWFzg5YPY0CvUTZQ8ANd?=
 =?us-ascii?Q?264StIeKP0JRkpeaw9lbf5a2UtEt9OZN1owWa6OFlqaqx9r/BzEqkiHm6FPm?=
 =?us-ascii?Q?1pglgUnDZT3I0/754ldPSYTimc0jLzCuQRwrJG3MPoSKa00zHSroll1L/Qq5?=
 =?us-ascii?Q?KcxMOBwlP8TQxLVeB1cxQKtMQauzhrOaS7kRLNBHOXwOLD/PMHvCywFJSqt8?=
 =?us-ascii?Q?pEF8k05NBMmYyK1wI6rbr+YwxNzoGtKYIbB/Eg0ZkC96wVWAtmUIpkexR25g?=
 =?us-ascii?Q?vIswYi/vca5le+W6w/Q5F6amHeJTEd/ok7JFAai2R+2h1XAiGV5YCtCmT7J+?=
 =?us-ascii?Q?0kusY/rpTbSsiPNmmCdpglHM1z5JMtSPwPFayPJfQzxJe8YVZwaNj0WvbEfE?=
 =?us-ascii?Q?a56bO485IcpFmgVwQLf2RNpgXkIyvQSNS4ez8V8exlnxlTo2Bs+WQGfquzgq?=
 =?us-ascii?Q?O4hGE1KZCjPNhIDpgtF8pZJjaCuoK9qWGkWhfGuG7Q/Hh3zdqX2uc0eYGT9b?=
 =?us-ascii?Q?pOOfm5Xg8lsEckWwDLO49LMlt6Df1Nq8IXYmaN+FtkP/AEqpcQf+ZCsOKcu0?=
 =?us-ascii?Q?AWuMxdBZIFopJtFkADbueFm7A3Lj4kAPvtPdkynjkwJd86sLoDDAEiFjyX61?=
 =?us-ascii?Q?bFIL39hQJd/5zeDpnEfqBaOujEqsB2/eXzM9AXLSIJB9Tb98oezacCNkjGx3?=
 =?us-ascii?Q?tJwvsnzQq4qu/A8k902D2Ugwp8lXP5bcwKIO1sc2NIlH29nTakG/IQ1fXohQ?=
 =?us-ascii?Q?kJSikhoc9tuWNFztNyYs93asHRkY88DBLUNgnteoeZ7eBMhILCFDw+b2G/Ce?=
 =?us-ascii?Q?B7xCKh4cCV7vpjw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:40:15.0947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17df3c30-54ed-41d8-00d1-08dd657ac6db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413

From: Amit Cohen <amcohen@nvidia.com>

mlxsw_sp_bridge_vxlan_{join,leave}() are not called when a VXLAN device
joins or leaves a VLAN-aware bridge. As mentioned in the comment - when the
bridge is VLAN-aware, the VNI of the VXLAN device needs to be mapped to a
VLAN, but at this point no VLANs are configured on the VxLAN device. This
means that we can call the APIs, but there is no point to do that, as they
do not configure anything in such cases.

Next patch will extend mlxsw_sp_bridge_vxlan_{join,leave}() to set hardware
domain for VXLAN, this should be done also when a VXLAN device joins or
leaves a VLAN-aware bridge. Call the APIs, which for now do not do anything
in these flows.

Align the call to mlxsw_sp_bridge_vxlan_leave() to be called like
mlxsw_sp_bridge_vxlan_join(), only in case that the VXLAN device is up,
so move the check to be done before calling
mlxsw_sp_bridge_vxlan_{join,leave}(). This does not change the existing
behavior, as there is a similar check inside mlxsw_sp_bridge_vxlan_leave().

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 20 ++++---------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 2bc8a3dbc836..3080ea032e7f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -5230,25 +5230,13 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlxsw_sp *mlxsw_sp,
 			return 0;
 		if (!mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
 			return -EOPNOTSUPP;
-		if (cu_info->linking) {
-			if (!netif_running(dev))
-				return 0;
-			/* When the bridge is VLAN-aware, the VNI of the VxLAN
-			 * device needs to be mapped to a VLAN, but at this
-			 * point no VLANs are configured on the VxLAN device
-			 */
-			if (br_vlan_enabled(upper_dev))
-				return 0;
+		if (!netif_running(dev))
+			return 0;
+		if (cu_info->linking)
 			return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev,
 							  dev, 0, extack);
-		} else {
-			/* VLANs were already flushed, which triggered the
-			 * necessary cleanup
-			 */
-			if (br_vlan_enabled(upper_dev))
-				return 0;
+		else
 			mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, dev);
-		}
 		break;
 	case NETDEV_PRE_UP:
 		upper_dev = netdev_master_upper_dev_get(dev);
-- 
2.47.0


