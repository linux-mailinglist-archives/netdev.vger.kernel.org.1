Return-Path: <netdev+bounces-187622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F338BAA8464
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 08:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518CD179CDA
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550816DEB1;
	Sun,  4 May 2025 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGwV12g8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CD13FEE;
	Sun,  4 May 2025 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746341457; cv=fail; b=VwlYEvt5uF3syj/g+6tODh1pM1/LgmcIASgPJDcaAuG2VyAXb0YWbsfDEOdRDbHopWVXrN7ug3DXpeytpLvvX8QdEX+INNm6qB/m10dubavtllk/+O0GjUS96UpBbt6EdjhxL6JLSwjMCyMA75SL1OFODXm+M3JJJw5tB6PtPSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746341457; c=relaxed/simple;
	bh=6b9eje3fi2p/zYvGovYD3xqAcTYB41yN2qQVLPKxjig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RmV36M5ZKccs0E/nqSS99TsUqAIHWGtW/g9UWQPKZHNSKkSeSo2Lhrdaf2LXV4Piv82Sp6LNrzvMh6JlsMQPYPe6olw5mA6vQ8rt31blDX3t18ZA1Z+17o1yCLjd2dfefIvh0rp5C1x7HYwZv5HDETi1B3C0cFYsHbjdaT+84yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGwV12g8; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr17Rcy8AmPH7bG+M52TwWITmvMNQeWgtMH1TIhEhBywn4zWy+iX71wIMs9YVaeKg8NULYkzJLDBu2y0yn4gWRl0JjGdfcsBRXw7d8UvTpEH/uMi7TEH2osHTlxC7hTUx3YekejeiLiU5SWL6FUHKKZa7wb5nof0nfrKk75ZsuDcrw0EKPDDp1HzlPu0txX5eeUYeKL7OZUWsssSTAb7COqqc46E0nu9fmuDMVGD7CnPu7Gsk2rFrAMAO1OqRww4ZB1mclvIXUk7n3idC6NgXtfzdf5CWQutQ1AAa1u/cOpFuCW2Vy7wukp2ExRue/JcG6nWF9apw2nWvExSXrorwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6To9JVL8YBIpcZXzkjcKfDs/KksFBFzQh5wl+HnRvE=;
 b=i5KQSX5IXedv9/sDTMQWfghtOF8IdOLLwBBJvRyQBByrlOMJ8vuhB4W1GAnJHdoT79A8t8GNvgiwq5w3jUpoFwycKwdi8X5Y5HMJCmMag3chcZCaFLjCWvWVhnnPfTXmSQX09whW4AqcrcrbXmsSYqtjK9Mc73Savk76BzkZL3TG7oOX6gpAPHCg/uBu67X4/Sj2JN24oDZ64iYWDGyEE70N4r+I9UayennwbB7cNJ9Sj6sky7Tm7dXSeBkp1yFsrhFU57akpcbMUW7/AArGRlBwFxS9k+bovrHtVVdxq3YrC/ABvm9pMHgIsy59IfFZuenN5K57jFitcSa3w81pIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6To9JVL8YBIpcZXzkjcKfDs/KksFBFzQh5wl+HnRvE=;
 b=RGwV12g8CmREgyGiCSuC4MJjbqz8JAFFJoU4oHm5IDa5og900+0uE90On+u28iG7ltxQd35mw6ZMsLw/Cxk3tf4J3zz1Nc+9PVZN6q5T1vDjgOcTBMc0ZvqYZVTQbUXiPXpzUrUSxDvow29rjpZy3nvWl8u9AK8A27zkjAB1a2bnXOL2SlU6ifAYH3snPh7YtvDL6f/7TqLeNTHjd0GXtTRRpPPhYqoQSKZ54+zSEvIW7Lc/lhiPEhtNNkJeO4nuBqmIFkT4jktbKJGzIQdK2SBK+2UBiXlazfyB/QBwquMxtm7CN0IMGn1AnIgigwQqbbzZr5yH+UL7kn1popIcog==
Received: from SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::7)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 4 May
 2025 06:50:51 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::20) by SA1P222CA0159.outlook.office365.com
 (2603:10b6:806:3c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Sun,
 4 May 2025 06:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Sun, 4 May 2025 06:50:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 3 May 2025
 23:50:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 3 May
 2025 23:50:38 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 3 May
 2025 23:50:34 -0700
From: Shay Drory <shayd@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>, <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [PATCH RFC net-next] net: Look for bonding slaves in the bond's network namespace
Date: Sun, 4 May 2025 09:50:19 +0300
Message-ID: <20250504065019.6513-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ac4693-94d4-4fc5-41cb-08dd8ad801c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yY2NPMCezqdOvt5v7RJIht7eX60/26GBqlBeuYtcfNfl2yBA3wkr2V+FMgjN?=
 =?us-ascii?Q?daWW8aZdTNNb1vjlrCIvL5X+c4C1Ghg0G0+LN+uvKh9h7DjZanESUpd+UzjX?=
 =?us-ascii?Q?pBA31l8mWiSGGdsK2oYe3tOlrR1BMy/LXBJW7GLEvCvYszOHhIw1/o1q7m/C?=
 =?us-ascii?Q?Y4kev3tkZ6j+wGcC4CLL09HhACafbNYEVLdwutvvWady/wMMm23dHqluSkdH?=
 =?us-ascii?Q?scRm/cENnmwsOBwNUz9B1NtIuPIf2vOpsPzlUcbsQqIHllN2u2+/Fm18ZK/0?=
 =?us-ascii?Q?FqJY1FRiln8qsu/pVD85SzNND4VV9awFfXl77X6XxFCoUTEx1zQ9i+PS34Rw?=
 =?us-ascii?Q?NTpsaCty6Vq3D5lq38VHDfEprQW2OggCUJYKfc3ewUmIVi44AiC6gCIgZjvC?=
 =?us-ascii?Q?JTs2n2XFuGffTVVYOOYCYekshqwOKdTvD/6dxeLFcICVBzGB63edxMTZM0Hd?=
 =?us-ascii?Q?6sd+bsmM9msqsEzU9Ef/RRQ9kT5hmMEEjuuge50xK6llcymlssMYe8vrcwQO?=
 =?us-ascii?Q?VBz33/bAO8iTW90V1OLw5XscjT7Vj++Tgp67b3oK59CxQz3a6VH0c/QoLLj8?=
 =?us-ascii?Q?dmj1wszu2tAgaF/kj7GySUU5G5u0I043jz84nr5L2OjA0NMbIaLlzRrlSlo0?=
 =?us-ascii?Q?Z15pp25oX5i+0kQdmzvE9SPdNF+gONXLB2Z5YUmq5Amv5gA5ltehQvIg6fPB?=
 =?us-ascii?Q?YJ9xlwH1g1CH2EIeEr/y/HhAESqIFIetXva7w/nyhJe0xlD5QRLJ7Cc07+2v?=
 =?us-ascii?Q?ktle6KG7JE6Fwfb54tatlDyI3MV+W416qVk+rhrkxDyuwzujj2XSlDWhibuW?=
 =?us-ascii?Q?8pwgLqNCZxJJShW222VLUxyTpdp8aSMKkoO0mUj6nAkp1bFpiINavdQQEj+T?=
 =?us-ascii?Q?tch+rX78XsCiV86Si72MEdxXPe1k1eJTI54FOEFecErpsJX7czSF3yvrIbWB?=
 =?us-ascii?Q?73D1sSTvxMIbpyYToJl1EHFlUrcMg6LROx+YPABc8oWl2is5VhInHQG+oZFi?=
 =?us-ascii?Q?v92wT5dJoHaTTmW0PNgkMrN6igbOKIHgS9WDGzc6VXYIgnmZM8BKV5JucuL5?=
 =?us-ascii?Q?bDC0xj/GBozzXXFz7Oj34trH1Dk5aIc+4PeBA0HbPA7M7Fce9wvvP06XzNkv?=
 =?us-ascii?Q?4Z+W+I+PjmJ4nenRfgiNkO1rFPQFmNEnRo9IyEiSczQHMbikUzI05xTekTih?=
 =?us-ascii?Q?fboHS79b/YIOTObClFbKfksf/KrRB5b0OHskE7AyBAQdJcR93+v4xlWA/RC5?=
 =?us-ascii?Q?ie0ccO0Xwf4MJ4EVvKuVRu6I05fvGGhn+91maySGgaBaynkWOPqlpyKXowgd?=
 =?us-ascii?Q?s+RgtSWd3gJ1cDghgCWdiIrVrKjCE72QqGfgAJnVbNyNFu0OXfktl5fRGsgt?=
 =?us-ascii?Q?ItGXsD+rggeFr4iqhy6+lbxNu0zyFbGq6XcxAPdgyZvYACJ3Rl/Tl2/yFYIp?=
 =?us-ascii?Q?XQnHkKtJxAPG+GzS6D/M02BRkbw4hcGX/S8b1slNUhnDCNu4tFaWEaY899yY?=
 =?us-ascii?Q?86VKEU4ZB+gvHjhEl6/mvipz83yFXLF4N0h8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 06:50:50.2301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ac4693-94d4-4fc5-41cb-08dd8ad801c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

Update the for_each_netdev_in_bond_rcu macro to iterate through network
devices in the bond's network namespace instead of always using
init_net. This change is safe because:

1. **Bond-Slave Namespace Relationship**: A bond device and its slaves
   must reside in the same network namespace. The bond device's
   namespace is established at creation time and cannot change.

2. **Slave Movement Implications**: Any attempt to move a slave device
   to a different namespace automatically removes it from the bond, as
   per kernel networking stack rules.
   This maintains the invariant that slaves must exist in the same
   namespace as their bond.

This change is part of an effort to enable Link Aggregation (LAG) to
work properly inside custom network namespaces. Previously, the macro
would only find slave devices in the initial network namespace,
preventing proper bonding functionality in custom namespaces.

Signed-off-by: Shay Drory <shayd@nvidia.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0321fd952f70..9a8fd352d91f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3266,7 +3266,7 @@ int call_netdevice_notifiers_info(unsigned long val,
 #define for_each_netdev_continue_rcu(net, d)		\
 	list_for_each_entry_continue_rcu(d, &(net)->dev_base_head, dev_list)
 #define for_each_netdev_in_bond_rcu(bond, slave)	\
-		for_each_netdev_rcu(&init_net, slave)	\
+		for_each_netdev_rcu(dev_net_rcu(bond), slave)	\
 			if (netdev_master_upper_dev_get_rcu(slave) == (bond))
 #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
 
-- 
2.37.1


