Return-Path: <netdev+bounces-164122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D9A2CAB0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACFB3A87C8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A7195381;
	Fri,  7 Feb 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aU/8coHR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49423C8D8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951284; cv=fail; b=t7tPJi4wTmd3GDMQZ707HdNC5pzzkbZ+merIDBJ7XVUhmi5kTayVtq0lTpWzaWGMSx88V6+S53Q1NVlOYsE0Lkt+YAhzhFjoMqA6eq7I1HHgXeFlh7p4Jrf/8EDXVKBUhACpPqQqWhVLkt1M0C9OmLH0HnO9mvfaxC1WMoy03ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951284; c=relaxed/simple;
	bh=kNiFhD29d7+VZ+rJGTvAem+vvabdb6jBu2vxeZQAQ3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQ4rX30K0aJt8LOqAlBB/qsltNWh8v4Cqgo3kTKa0xd6yJDoJFF7yCNjyvhSGphWK2bCxBlxh1W56Al8PEW+TSx5PyDapQjm8+Er965vJueWTNd8Es0XwY7cBIx7QQLq70YypwlGYwCBvk5ImoHbN6lZpPpRVToOdqQq/jQopAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aU/8coHR; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUhqYiOKPntsIwGwRP1GMXLjFVsqKAMArS+IqAvt8TzN+AnV7nMe6B5E2Y1mCKi5L1ZfPoJcjGcJMeeVLpPE2dk6QpUZGNaTfAUOjSnfCNQrIiyCl4D7K7pT++mHr9A4P8nik/o8eXeCHeYhg6aHKe2wI3wvCMwJLSXoLGO2Ri05EROdsFJiVyCYwMjToOVxcz73QBS4YMDBwmUDds1ZHvuNppUB8+IuVzcN3w12jssNZcsd9WRM41ylM0Jo9W/bdl6CbjgPyuMsEQCZ1xfW7b9OEnVmb/Gcd3a2+c/HxRi9/9Ha9+ftV+w0U1fCNV4L1/Zyvy805N1NgcD8b5CrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHJ/fg8OO39i0v277nPHCF2bDAGWOvmKi/DAK6woWhI=;
 b=g6MrS+xSG30tGa1JDskLDmfeqIGH9Xg86F9vNGALy9NcfN5/8THxwSnfP2KJ5OOa7QJgo7peU0VjhHM9kWGP5rfmYildQbciY7SLYE+cBuCqB/Afc8HrnOHjzFX6lxNlRBuS4t/7vuw3E/Z21EvisRS2fSJGBs0y4AurFSu+x2JE3QhGHWA8dKIWtNEAgRJWcOjSl0AIjODBD5f63HQSJvGwf/4H8MU1uaZZm+zygUSWRDz/1RA3hoUFBI3BhFncMx34D1Y3aa1DNq9Xko+rQ5UAjAy1XXkJuf8mg+EI8tzxgT9xwC+4vb3g8TB93gMImvv6quwKjg0JGMLyYC6Z8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHJ/fg8OO39i0v277nPHCF2bDAGWOvmKi/DAK6woWhI=;
 b=aU/8coHRSckPE4YZ7OAFT/JkCa/cli8dgjb5g2A8eAa0WjYyokx9XY77fXlRb83TYCYch3PTBWcsoDi0w6cTwFjU4Mhr4e9QUZFzi46Ilf0iTLW9zeRBHibkOR7L9CyrwG3OCO1lRxVhI/AhYnSvDn8UxOVnQiLlnLncFepDgTKUuJvaqGyaIgFeOK759lh6CKbnioyqVWj1kieYLtvfbNMjLjPGBgiJdUzeULQb/jU3PUvyUOMMZ4UnyqudQx3ZoHeXxLlOBEjTosd/w2ZEjqFf4vHaBg2gXH3EcBx//wA+JwHmLN6SooXHbboskDDlm/n+CmgFIXDd8GbPnaN7kQ==
Received: from SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) by CYXPR12MB9387.namprd12.prod.outlook.com
 (2603:10b6:930:e6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 18:01:17 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::d4) by SN4PR0501CA0111.outlook.office365.com
 (2603:10b6:803:42::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Fri,
 7 Feb 2025 18:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 18:01:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 10:00:59 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Feb
 2025 10:00:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next] mlxsw: Enable Tx checksum offload
Date: Fri, 7 Feb 2025 19:00:44 +0100
Message-ID: <8dc86c95474ce10572a0fa83b8adb0259558e982.1738950446.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ea7c92-31a6-4ca9-ab31-08dd47a16aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pyuw2gKeyz1f0Hv43uUXP5o/FF54HdP8uVd2DE150sVgyVB4ndWPsF3bOkar?=
 =?us-ascii?Q?m7R618tX+GrMJL+SzSlIua39xdCpH8KN93zTQzbVeKjpij5ewzxexzepbYFD?=
 =?us-ascii?Q?6fMiEhic2cAGsU8XRWbv/nt9GE0IxFN2eUSKsSKKSzFCJMjIw51AjQCQgPmz?=
 =?us-ascii?Q?DfEMDQ7f/qhLbcwlaX4m0PYahbW87qMEdpbNxBgNX6VsELx7CC0Xl3/oQuzu?=
 =?us-ascii?Q?xiFjyyaqFvOVzv72sHmhjTsXtmEzeb+IHvnd7UQIT4FTbcSwBn1cpWf46f6Q?=
 =?us-ascii?Q?ww8Pnn/k5ivodTLmULVLdvlXTZ1kfaqOzE4J3wk7LVJ4BNusJODF65Bu4IKS?=
 =?us-ascii?Q?wEDu2E2U7HZzeJtLEnIR+lDoAUI+dZaj2k9VgtFhDhZI7OE3eICoDFF111l/?=
 =?us-ascii?Q?I5JnnI07CR1u8uF14oPKVBxZQfapyIhizlTmwAx3Z95WPhzYlp1LuLs1ZHqK?=
 =?us-ascii?Q?xrxOJywLyaIQArpw5Fb+FYea2HY72rqtLHzhDtXiuCrYYtq/+o+3MX81xgJK?=
 =?us-ascii?Q?L7xOtEu4DmGfp7CmqYB3bulUK694MCq0DhySk5ysNCZ2RQTTBKPMcx9blag1?=
 =?us-ascii?Q?VYgqxePaBC9QmdbdskQTI3qXD9rNfDIFyHPTHpRBbGkXMmcOSRMWdHDcK06E?=
 =?us-ascii?Q?++nsPoc/f0v8FHQgXEhgEFxxz+0OOo230Mbvvfe5E//NTi4POZkW3IfZBADH?=
 =?us-ascii?Q?a9407/Uxc+zMVPdvpzG7GJs4tVX2JyoI4upRfgj9mmnqxDdclSHnZn21tcqC?=
 =?us-ascii?Q?w8N/dMW7yGxfsRyLX7m+TZ1d1lGKbh2zUAT1VjuvP1MQmHEykJnoTZzUKyCv?=
 =?us-ascii?Q?RzVtmmwqRq/oHWraDDv3Zzvcu4rS+qhLq3wHtQLdj+W865NXbdyMQgfN2wWx?=
 =?us-ascii?Q?2LT316PDbCEz06zJYgb62ShXS+gBGt9OUVRVgOOLsE3w34ikASlHyl55JAYe?=
 =?us-ascii?Q?IQqTRBaQeYVqvbowqy0xRGKvXBDJiOweW4xkFRqTa74StYOsJhSuivmWIohs?=
 =?us-ascii?Q?2ZxStxOSABJ6EFpnuP8FV6Hqs54lWZXDZJFyEHGYpA3Z/xmsd/9bPr1u0661?=
 =?us-ascii?Q?MSJ4Ji8fO1Dk3DAPT/w2ZJqifhuThJGZpo1ywuSZBlLpA6c9JhTBaR00N1dN?=
 =?us-ascii?Q?mPFZ87tkeC0P7ET/I0SfBm60i+SzQYc78C4Ub7DGCxt9Muoah138CvSkAXgQ?=
 =?us-ascii?Q?Sv7kVtjrOAkTU0lDiMJlHzg63G7pQtkNrrjqwA4XiC5cm4nHlHGiyHpHJ3Io?=
 =?us-ascii?Q?iuNqdnkMHk2hXcgOZMQhQuETLuGlwFS7eF2Ne9gF24qF/O+tYMqMaZqbLs+C?=
 =?us-ascii?Q?m1o1lF8L/BRYdks/bk+Kl9CVrGQKaR6bBf/cwdDodk/RSxIuOvFJfLpkoDX7?=
 =?us-ascii?Q?/gOjDGItvBWZytErXO3Lsuo98+6Y4ZSU2EyLdrf6ESkYx0SbO8S8AbM+C1N2?=
 =?us-ascii?Q?jbVb3kviu5+jfDHGNez+QBmOlmX++frNJ2TC67DszoNSxRFzM8ypuB75Ax/L?=
 =?us-ascii?Q?1ZbbBc0N2/3X63U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 18:01:16.2045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ea7c92-31a6-4ca9-ab31-08dd47a16aca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

From: Ido Schimmel <idosch@nvidia.com>

The device is able to checksum plain TCP / UDP packets over IPv4 / IPv6
when the 'ipcs' bit in the send descriptor is set. Advertise support for
the 'NETIF_F_IP{,6}_CSUM' features in net devices registered by the
driver and VLAN uppers and set the 'ipcs' bit when the stack requests Tx
checksum offload.

Note that the device also calculates the IPv4 checksum, but it first
zeroes the current checksum so there should not be any difference
compared to the checksum calculated by the kernel.

On SN5600 (Spectrum-4) there is about 10% improvement in Tx packet rate
with 1400 byte packets when using pktgen.

Tested on Spectrum-{1,2,3,4} with all the combinations of IPv4 / IPv6,
TCP / UDP, with and without VLAN.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c      | 2 ++
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h   | 5 +++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 6 ++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 2c34c420af56..3488d6e4fbf1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2595,6 +2595,8 @@ static int mlxsw_pci_skb_transmit(void *bus_priv, struct sk_buff *skb,
 	for (i++; i < MLXSW_PCI_WQE_SG_ENTRIES; i++)
 		mlxsw_pci_wqe_byte_count_set(wqe, i, 0);
 
+	mlxsw_pci_wqe_ipcs_set(wqe, skb->ip_summed == CHECKSUM_PARTIAL);
+
 	/* Everything is set up, ring producer doorbell to get HW going */
 	q->producer_counter++;
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
index e56da24e9e9e..882e01abd9c4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -96,6 +96,11 @@ MLXSW_ITEM32(pci, wqe, lp, 0x00, 30, 1);
  */
 MLXSW_ITEM32(pci, wqe, type, 0x00, 23, 4);
 
+/* pci_wqe_ipcs
+ * Calculate IPv4 and TCP / UDP checksums.
+ */
+MLXSW_ITEM32(pci, wqe, ipcs, 0x00, 14, 1);
+
 /* pci_wqe_byte_count
  * Size of i-th scatter/gather entry, 0 if entry is unused.
  */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 98632c046170..2f4e14d2f2e2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1630,8 +1630,10 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 	netif_carrier_off(dev);
 
 	dev->features |= NETIF_F_SG | NETIF_F_HW_VLAN_CTAG_FILTER |
-			 NETIF_F_HW_TC;
-	dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK;
+			 NETIF_F_HW_TC | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK |
+			    NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	dev->vlan_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	dev->lltx = true;
 	dev->netns_local = true;
 
-- 
2.47.0


