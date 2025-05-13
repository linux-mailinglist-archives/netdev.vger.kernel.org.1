Return-Path: <netdev+bounces-190005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E83AB4DEB
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC451B40A1B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FC41F5846;
	Tue, 13 May 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MD27QnJL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7F2AEE1;
	Tue, 13 May 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124390; cv=fail; b=UTDEwByNdwVnUdtuJIFQYi1FP8xPHTBHOhAc0UqL0c71GiUcNv+sDzjYLDJF1CK7D09tRd0VuBS79PqpqLzn6DCUiRWtfKmXlytqCbyKPt77gwszH/iyqhYRkuomt3DRbH5oS0GFlEsoA7QnHnFra8ZTHH6S0lzrJGgLHEZC158=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124390; c=relaxed/simple;
	bh=gGb3LSxOOl0TAhqi9hnSyuxG0GMovTW01VXW0Ume7BE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=frMDOuEhIfvV7dZojJKu0Na9wcQLygNYS3ch4IXNqb+W/mYw0wnePtiwpeXT/DNarm+anbEnrBQE8B5ZAEzSiYXUMuSeLz46ZjPBj6abjLSUuV2rAEXRxnVQB0IqPU8ANREEPlmHIpnpz3wq1efO9djwqpn5FISG1jlT92kuZTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MD27QnJL; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPozsrki4VAbuVrk5esHdBQeVhOAIUEZqR1/412KhPuaVO7Nup7oXDbm6bdst1hIDPVPJ3hYZtg3CXEpVtmWuQUbSK2jaMPtg+7BIhP2S4Nd3vnK/VwBz4XqwI/9RqBCxkx6Xga5nViNPq+0K1yjyhtyD07qd+VOZ83PMAxdG09NPVWfR7zk1IssdHhLADdY+5uKIECz/QYRFteRuOYDKiASrfbGstZqjYrkVamvl4LQ4lCHJuS6DCR1E7LcDqBJja5QbTPNIJTLpyVQ0ckxtNAl948QP959hzfeNXL8Yvy2E3S8foMUHv/Z2N6OeReCXkxpbMbWWIHYD/nP+2tiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI9ERr0aViaU0hYgBbe4DUUHFtPS1a/q+SlCewbP3mY=;
 b=iAQPTqE07w8xUY8YwQi85/A6pC2AmsXsLQV+aem86OTeZzUkBwneae3dWjRZqQf5oDytugEHwxYnIB6ePSYemPRovGNWMnKW+UqrPokvbV3vsLou9V0R5m7WsmdajmudbWqKlNByw0CxLNe23y1w12tS+kN9D0VjZuIlRk/sxtyWC5uv9BF/U9ERfESPrT43LVj+IobWeYr3wGSLFkHFTMZh/k8EmHCqULGpzPNru2ZiYvuMf2oAi8b0TqEDYhuCQtwYgfmYIgM2IHIIrEBen4unkGzu7/4+V7l2fkp3VTwCci/5lRkOZtpoLiZ4ulSdon23K96e9rUK0/2C3IPaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=jvosburgh.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI9ERr0aViaU0hYgBbe4DUUHFtPS1a/q+SlCewbP3mY=;
 b=MD27QnJLyqa7+kFzwydaqtu0mTb60zbldnkBTfzTjXn7Qew/G3J2p8LJFF03bYnGQz1EDTt8NTzEgKtVdFDV+yB5kE8RgnmMxVP9PIhQcF0m6Yf7Zq85XRmD73UZKCU4d2y1QVuVWPWTWOvDn8IwggL+3/FORr5WA7luJUZ//WAcpMAIXI6qO6wqvDe8YMgc4A+R32i26UOCaIlbLeoIkn+yHGM9mQgeAocLR/vsEtdekmws7khEe536yOeshELMCEcilcsM9Ci5bCCMGJvkb7AeLKSELI1uLEOgxdflOFScpG/yYS3te5zQ0ln3IJLeA+qrgf/luIRnmF/17hLH0w==
Received: from SJ0PR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:334::6)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:19:45 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::a8) by SJ0PR05CA0091.outlook.office365.com
 (2603:10b6:a03:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.23 via Frontend Transport; Tue,
 13 May 2025 08:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 08:19:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 13 May
 2025 01:19:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 13 May
 2025 01:19:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 13
 May 2025 01:19:26 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jay Vosburgh <jv@jvosburgh.net>, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shay Drory <shayd@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next] net: Look for bonding slaves in the bond's network namespace
Date: Tue, 13 May 2025 11:19:22 +0300
Message-ID: <20250513081922.525716-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 081e7ca7-5a93-469c-298b-08dd91f6eb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UhzZpBig1GaFTgmDYZ7CpAJPJlxLngEZyeYDvztKO+UWFSwXmVs5IWlVHGHb?=
 =?us-ascii?Q?XrXgI1uJ2t0IseK8wlTD0GkPbQfPPSfv4gT6vlRBdHIrcTUJfSokVAu31O+6?=
 =?us-ascii?Q?Giq8Aj58EQ4iPPWz/hUuKyftxaI/Wq7pbGZmdYzXyNFAsS9jY5BeWseaeCWf?=
 =?us-ascii?Q?RXmTdSkyxnHv3bKM2YRGBcPBrg4na6wT+1UOY7uYJ//MceOZONR4uHSy7w2c?=
 =?us-ascii?Q?wYQfj2pqq4yodtI4m7aKZc/yTS6AgZvKdpIhcSNV5h5tW8EBCEYhSrMM1WUe?=
 =?us-ascii?Q?rWnzlkxVA3IZcD/zIB3E7zMgrXb72xEnFd6QBONVQ7i3FvCi8GKAQ5H663ch?=
 =?us-ascii?Q?Anitngh4y2T4X/Jgu+uUylKlGMe6MZwY22Pxu+QDdtpKilLMSB+t5/vWWXBq?=
 =?us-ascii?Q?eP5v6fT2GkiRSXxOwB8n70qXMngv6LsSNRk5vxVHXs/Psa3MvzTQ1cf+4okf?=
 =?us-ascii?Q?0TI351J/l3eLDgU8gkgTyz45SOzHZiJRuqqZSRNYshQAqrGgpGntXEXz8iDc?=
 =?us-ascii?Q?r39JAqooDd8XNNtWvz8DyWYRBavWmD0Feb1G88ngzy21VER4n7dhYnVJOYz8?=
 =?us-ascii?Q?tYIntI9NhWwOZxbT96egbDMkovBPL5aeTA9k1wdXJSQXUwP+jWd2gE7+m46t?=
 =?us-ascii?Q?zZ0C4vDYcDN0l9hN8vvu2ngL3GdQmQJhdRj7DIVlf0S0cHQMGLpcK4a9/ZAC?=
 =?us-ascii?Q?w3ImP03BItVrK6tH41McZqkduw4STaKC2V3AGaTXOTmE8Q3ip3KJsXqKv/AN?=
 =?us-ascii?Q?RdmkagGEtS5LkOqREnnmuE/HX27d7u/N254uhE/Ho5G+dkuL06QiAn3FLR7z?=
 =?us-ascii?Q?/+KDzVJ7ytpEaXFMOqV2kttd2KvM7DjFOSUbCEhwbi7R06EI2+BGtaW8bor0?=
 =?us-ascii?Q?NiD9gYN/ZabW7/HtEg4aWBfC/JjdGQHc9x6E+rhpOpFOAchZAH12kOntkxbc?=
 =?us-ascii?Q?n+0wGUAf0DEyW2EDWRiFOqRn3XbOLauzNIwht5lWNTWlsqEa2T2lW2g1bGVA?=
 =?us-ascii?Q?2N4YXxXufofj+a8jn8l2iJhKR2tpEqBn463nRXJXXZ8Qu1KcUftKiqtAcxxs?=
 =?us-ascii?Q?FGMxQa4HRVFobsv0DGzxOVVx5TWuvg3anFvlInW2szzIIOperRn0rMxLcnku?=
 =?us-ascii?Q?4VAHseJ2rhug3ZN1XAeLh63k1ch1Acpk13HDkhCk6FDQ7bPvER40PMl7o9FX?=
 =?us-ascii?Q?9wigcRSC0gzp4sP/AOmedFlsJfMTK9OVOdJN24eWrLvxlnLYxjSdZ5yx/+Kr?=
 =?us-ascii?Q?VGl/vevD9Z1KxNwKkVeJoek8ciy7GR2Y3r9Ccuz7KUAFiIoew+G0eVMU7exh?=
 =?us-ascii?Q?QybbCMY6YebTWfQAtLN/SyyksTTnmL7tPcgLDbhP1iBuaPTR3G14/6XuUp9/?=
 =?us-ascii?Q?vykXdsf+XAQHY6gi2ednhi7z1F803/GU157LZ+BOe/N6ATYPQ7UwuAUpfKtY?=
 =?us-ascii?Q?hnuSnuhiBGhMA0aPlO/REqV57bT3heJFXB8MMXbQK28MadIpC8jplBM8fMb1?=
 =?us-ascii?Q?wQ9e7qZNjcMgheOgrxm3KetluGpBux91HdkC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:19:44.7403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081e7ca7-5a93-469c-298b-08dd91f6eb09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

From: Shay Drory <shayd@nvidia.com>

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
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 773167508c82..d584faa2dc4b 100644
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
 

base-commit: e39d14a760c039af0653e3df967e7525413924a0
-- 
2.34.1


