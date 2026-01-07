Return-Path: <netdev+bounces-247679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04266CFD3EB
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 629A0300162B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A9531960A;
	Wed,  7 Jan 2026 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DBevecBf"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329E3191A9
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782886; cv=fail; b=sj6FV2DKki16ZinLzJhPV98bktjbiAZZNxBiObrsckemQn/pZ5MlaWvNoRYx3kMM+sXFb5VQwlYUMhXWZPAEzv8l8DdfwY/GLl/DcNGe/bEa4yMbHSqevWIiIkr669s4mvhdt9KLs0icZ5L9y7dRSb8/C8HhnVQ+TZ63u3tvCXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782886; c=relaxed/simple;
	bh=YQ1CmID2IUuBphfjvK94icK21K0/5APPI48406AxZwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDuPAIWgJJ6m1UXsaUKn/jODoaFlDHK8h1o3AqAdKv8x9uF6DoOxCVAXMPAkjrTVk5kd6adiKxcqt9rURPRqP/Nczp/L/vjlUB7Qg/DFmY8wLfV0aB1vHj/2Zl/4/7yJjumSRo8Q7mgtqNOpjQLzQHoUun6KvegwoH9m0QHQlp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DBevecBf; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KplCdAtVX5i+dz2EssaDEdDURkICmsaEXtWVxYNF3pW5QLSyG2T/xZT1XPgxthSY3xOshA/L5r+4THF00qdLPZph0Qq+odRPFnPGNhgjsX0UDPYO/TxFJaEsMRC4XN7byg5yLXh2V5c+uVKrPO5LDGO+vsscq8EJfyonbo9r7IMtfLy2rwUskWlsdjeo+JknD5LsEMkejDQ6KXPHJurUCezswO2UvsffeJ9O4sG5oOPgDMxJT4D5pKlaTamVwmAYpZ2DSPBtU8rFWJLdBkmjacNdW701niAPjd0HSQz4DWvIwb7Wq6Ca8N0LAZfBjeeOUd8t9NbrrHEsIrsFNvirYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEaa4Y4vrfIFsL1aCnpN8w0MOhyy2Vy8ls+5n5++W/g=;
 b=fSE44Nuj3lCQT5cBcV51Y++CG7zbPLjkDh70tRerDUt4aH/qNxXvv5hJX3zneE0GULfdUCfjpdFUGVL6D30bBWvv6f7P9MjOv8pmcbesiJxGdltSxXfyxjYk10pKrp2H/vT5oQi7MWsk8WJ4pzl/Gmt4yy5HvyY5zNNTDNlnGmt+SYkBNvYOhUYm5AeJC38YmieRRmoVnfdfviyOxJOOmf7P+lFvqARhj2gDNcoayiplKScsGMJ61aJP/6bATucFJ3e83oF/a5bIp+VdH27+fwUp3vsZKODYo9vZwFupgdCxO2YhDvJ6XJNMmHbVJ3VgP6zBvYkLh6bfVV/u86NbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEaa4Y4vrfIFsL1aCnpN8w0MOhyy2Vy8ls+5n5++W/g=;
 b=DBevecBf9wyK+51shz/CLXROYYMhK5CEF6+YlZEr1e4KvyjwdFH4LJxwWSifUg6MNMDyLOj399QdmaAILvgKkyLa4YB4mO+hJUy5rER7oEY4E4YPfLqjH9hMXBILWrDr8lLiLyvEztPTwVEWHn20TItWUMtUaidbssEino83g93Qoz3u+PODiHhV7Xcrwc6Q+1F2PIEA9WuS8z81FzazMKZJruwfHC/eMRXYuLRkgvWLHIhUnl07jRnkkUx/0siNnwLv9p+f9ZhheVUZ8MwcUKIZ8uGeJJ0v913fNBq2WGNxFCnOzRMO8kNjbZqgWb1WNM+WdJjv9PO2cmYAjkfIYg==
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 10:47:59 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::ad) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 10:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 10:47:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 02:47:50 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 02:47:47 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net] macsec: Support VLAN-filtering lower devices
Date: Wed, 7 Jan 2026 12:47:23 +0200
Message-ID: <20260107104723.2750725-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d18328-ec43-472a-c608-08de4dda38e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ra6MURsP3YoPixCcI6agOM9XkM+xTyBRTozhrfQtnOe/1Ti91UotRKJ0dxXJ?=
 =?us-ascii?Q?t++k/7Qzz0BnYuQP2FZbOmwIXEM42n+yajPYH+wmx2nXBvJq0RpZn505Gr3V?=
 =?us-ascii?Q?12e5q8BNQXKDHFDi579ITbYgJvGpI0gxyF+co9cH7lVfhUPpsIHsaV5HgkJw?=
 =?us-ascii?Q?eXAm2KOquEroS8PjbxS2vJC5GE60Qw91/aKwj/Udtwu+lXzMJDwMK10ELhwv?=
 =?us-ascii?Q?RJgHUaOR91O6YPH7be0+Md/Ee5xFptYT+lBn8I1FniX+RXMejLfE+9+9mI/a?=
 =?us-ascii?Q?h7dW1FQ1J9SH2VSEU5ROArlYfBJnrm5PYkJaAhWSv4wdTQTaZ6cEPOW1UtHm?=
 =?us-ascii?Q?YxeEipRrYwMIrKIAm/6Q2iQGd9f8HbDvlDfkeRwUjoIA9X9G6zHpnCJXMBDG?=
 =?us-ascii?Q?6DQPkbJ2hPIAZ2nDrRy7kMw+pReXVFchBz9/Me7Y6aWjRdfTlbM7k12kHaMS?=
 =?us-ascii?Q?0x0DL6+0uUKu/pmzsKZxOmoAGCUOxUnmVWkQySjx0mUpnqUcPbaOUkMeOQCl?=
 =?us-ascii?Q?qtBHeGiENv9N3+Y0TUkNcH5pg0pgRCt8DUAOyHSc73C70LqIxvAp239Dcltl?=
 =?us-ascii?Q?XN+BnaGG709HoFt4+hXJJGUrdmfaiBjjKFxOOCQPQIiJ/BS3p1ipADqIISLl?=
 =?us-ascii?Q?bym+RChLdY509+3Uk3nyK68MgbxGFs899iJdkEiUJGzj7NG5QLqhCbEBANUX?=
 =?us-ascii?Q?LwZT1ivRZWvvKcJFcbvHkeYZKKOhINs7fb0IkaMXQ6BUOz7uJuTShog+nhT2?=
 =?us-ascii?Q?XY8hTNoXdkw47yKs5kO2QWvIQU0SX+r1sVXOh27pNNYvUdzAUT0sq/7XUlAD?=
 =?us-ascii?Q?CZt2+fRdchhVVbm1fyWPkljrSq7UbCFcYpzf39X1tk+NuSWoB2PeWvXBXi8E?=
 =?us-ascii?Q?XU5bgHNiofdtyhpg91wG0egL/LyOtRDyMuWFklupr2WDz+ZsZ23wDCE67/zP?=
 =?us-ascii?Q?QCfeDFMZNltCsVqaDYgw1R90NgjSxFvPesOfpCYS5rUkybROkqZgHQwDO3/e?=
 =?us-ascii?Q?TrBP2lXCVLsEtrZYMqE+IeazO0hSZR9mBdz9yU3GrOUkLpKqsd4Ii8gImMjY?=
 =?us-ascii?Q?b5+Jxx/1poOIF1NzdwcJ5+HTYrN5ErM8CxiaqYPkMNELnXY7oIJL+eVpQFGy?=
 =?us-ascii?Q?9NT10npO65h39IVZE06ZwU/+kf0bNZD6WG3Lhah4Vytp7lDTCJBa2um1GdiA?=
 =?us-ascii?Q?oQsr+zbzM9ekpee7aA/nUgqkOOOcv7I4GzQLk4GWw8UfhHF6K7WYDZM4B2QB?=
 =?us-ascii?Q?p+hGOvgAJ3MHOWMLnqrUSol81E+KxsFy5dxo2QdlgmT0bkhNEEaNyt+/DTaG?=
 =?us-ascii?Q?dzbmYNCO8Lq7mBQ3gX+kfEfaD08y/wQhCAe8mFZLz/5xemoczi+DI5qm0XHY?=
 =?us-ascii?Q?SUBR84gVnwPSgsQkXmYYhxsf9w0KXmXEUO4WVYWo5gVzJ4h169QsFDgQdXMW?=
 =?us-ascii?Q?T9H9tDk9vn6qYZxoxuLKYpSpBIF+TqHk5/a8Wnaapm4p7nEU/Uk2aODH1+yj?=
 =?us-ascii?Q?5c6KUKWAeXkYc6eB8jmUcST5cVHKgVqa5NTcE/lUFb8o655BiP+uQc7M0mg0?=
 =?us-ascii?Q?4YNSdRLVjFMWjOoPbS0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:47:58.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d18328-ec43-472a-c608-08de4dda38e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

VLAN-filtering is done through two netdev features
(NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).

Implement these and advertise the features if the lower device supports
them. This allows proper VLAN filtering to work on top of macsec
devices, when the lower device is capable of VLAN filtering.
As a concrete example, having this chain of interfaces now works:
vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)

Before the "Fixes" commit this used to accidentally work because the
macsec device (and thus the lower device) was put in promiscuous mode
and the VLAN filter was not used. But after that commit correctly made
the macsec driver expose the IFF_UNICAST_FLT flag, promiscuous mode was
no longer used and VLAN filters on dev 1 kicked in. Without support in
dev 2 for propagating VLAN filters down, the register_vlan_dev ->
vlan_vid_add -> __vlan_vid_add -> vlan_add_rx_filter_info call from dev
3 is silently eaten (because vlan_hw_filter_capable returns false and
vlan_add_rx_filter_info silently succeeds).

Fixes: 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/macsec.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 5200fd5a10e5..bdb9b33970a6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3486,7 +3486,8 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 }
 
 #define MACSEC_FEATURES \
-	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
+	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
+	 NETIF_F_HW_VLAN_STAG_FILTER | NETIF_F_HW_VLAN_CTAG_FILTER)
 
 #define MACSEC_OFFLOAD_FEATURES \
 	(MACSEC_FEATURES | NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES | \
@@ -3707,6 +3708,23 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 	return err;
 }
 
+static int macsec_vlan_rx_add_vid(struct net_device *dev,
+				  __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	return vlan_vid_add(macsec->real_dev, proto, vid);
+}
+
+static int macsec_vlan_rx_kill_vid(struct net_device *dev,
+				   __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	vlan_vid_del(macsec->real_dev, proto, vid);
+	return 0;
+}
+
 static int macsec_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -3748,6 +3766,8 @@ static const struct net_device_ops macsec_netdev_ops = {
 	.ndo_set_rx_mode	= macsec_dev_set_rx_mode,
 	.ndo_change_rx_flags	= macsec_dev_change_rx_flags,
 	.ndo_set_mac_address	= macsec_set_mac_address,
+	.ndo_vlan_rx_add_vid	= macsec_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= macsec_vlan_rx_kill_vid,
 	.ndo_start_xmit		= macsec_start_xmit,
 	.ndo_get_stats64	= macsec_get_stats64,
 	.ndo_get_iflink		= macsec_get_iflink,
-- 
2.45.0


