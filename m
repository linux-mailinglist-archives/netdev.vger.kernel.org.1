Return-Path: <netdev+bounces-182758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C044FA89D49
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E119002C0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF22957D4;
	Tue, 15 Apr 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nmqfr9yl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F97296D1B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719177; cv=fail; b=TUbaPGOcVeQlQq7WoaGYSyM3fpdxfR0PL/xBbaHX8O36W9HA0pJpyy94B7EjEHQUFLLujIy8b1xsCG+ykeLOKvl7OtVgBhhoGbSGO7yuBpA/PhFXbkCY6nTqrPxb7RCRQ4AD+GkeYf2Lmkd+BhiNZVkXuJ0dmmat0plXGmRDU1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719177; c=relaxed/simple;
	bh=H8pUvc3UYWPalr6n+UJDAjUh+Ex7cRBNXAjupW5xWtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQVI+SP3BZGdPvId6DtV9O9QB4AKEvMdyC40bRZcYh4RjFeM6HEIEwxtTqeBWdrhZRCQRWp1VbJyS6OQerdOkVLVFLRSpwabAswS2Ot/LFp2bQvWJ94HL3SBO9NAc66KxOO9myU+3SyxzKx2eLqMIMS06EEqmjzC53uQxfayXc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nmqfr9yl; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZz+yt1Q2DGv+zUZ899KQoHPrPeZOoHI1YpIXmpu+YxYUDrWDuEn/uFVyMgD2wjyt3cbZthbucHjNgRapPOqhE+HC9GV9/WUpEOHdT3asTvitbnEL0ySUAk1OFqzBq1Nb65+WwPOFdhffEJARq4MLSViLUmUrJKIVZBVehFvxTu2Hsbc1jCLGxsSNtl/7dFefp9vsHja5X5/ivn/cWoCskLmp7XpDKC3Hqc/H6QFIhkjDiw9YDcV+Zy7lEMAPu+jmfGwVQ+ky0gQ4EumtdhPEJKP02xSJMc7aEbh+hTtZgDexv27O/T50RugG9SE+YsuKEsf2dcCyM71qMamcxTBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5i/o2B3fJKM6mvWB7FWoRNEDV86SscQiTg3d5mJPGg=;
 b=IYRWr+EAAFt3VwdQoUWi/S0vDK81G6FgkOxwu7gLuQhMHfi3qW2SZDG8rMi/QI0y/mTAqWY8rDWXTNmq3uKPVjulBvSVg3sU/GLZIvPC7M7nPsHRqO3ynENmPkGPU9Hq6nNHIVThODonYxuUO2kZmz9FDy2eByho9Y64XK/1ms3JYGcUXg2E8W4xsJlibI1erc6/F5fzofBiJfVgClMQaxaAkYjWWSqf3ALLCDffRee3qDnjRLdKaGeh0SMEdJXvTIISxn7zktn5mKhV1QDBKBp76E6nEdAW8mVUkF1g9UWhLkEmT5RpGD48Y811dpk3B5/25NktGBlra+JKJx88JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5i/o2B3fJKM6mvWB7FWoRNEDV86SscQiTg3d5mJPGg=;
 b=Nmqfr9ylfO/BkXswj8sg/eUOcte3q2Vt/Qn26iuY/IexR1v1hNZO4rIXCV6gyCSl8QxSJ746wbMWGSMpA278fZQZ+QGlT2zGv5e6z6ipdug7RkvVM/zPtxvm38++Z75Iv23MqXA/Bqy8pyi8P97VnB3tVP+5x7BcFhD07zV5mV/voQ/Q8mXeGzuI4V8+dPagnB28iFf9at14GZFJh07jXVWuUV4F81ZwgTbtzF5AQIcBBJrk+WdNG7eiZu4GUMHQQNtlEm4UYAL5WnWOKUPJ0Ca+1o+MRQXNzXBnW//elc6L/RufN8DklwAPdiwfGdItXwedlVpDs3PVcEdkaPdMfQ==
Received: from PH8PR07CA0004.namprd07.prod.outlook.com (2603:10b6:510:2cd::13)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 12:12:50 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::52) by PH8PR07CA0004.outlook.office365.com
 (2603:10b6:510:2cd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 12:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:40 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 11/15] vxlan: Rename FDB Tx lookup function
Date: Tue, 15 Apr 2025 15:11:39 +0300
Message-ID: <20250415121143.345227-12-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 281b7bcd-fb63-4f09-fcf2-08dd7c16d73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JjhuSiwAVr66L/BD0WsaMZImonIJHDPBBL6IelJjleKAjUkmsfECE7/bCaPx?=
 =?us-ascii?Q?oo11IN+tp89TsaChTNvlKs+RFHRIQce1wr0cSqI3hgkPUW/P38wlIqfpYeqQ?=
 =?us-ascii?Q?XPFuuPyYQVU/rwuh9j3w9Xm7iEOnaPyPsDEGJYGWRKiHiqKMZkbq9G8POEeN?=
 =?us-ascii?Q?YacFaLAEh47PaKwvjQHvtw7jii/w+Rw8VDgcIPE+QhqqkWVGFyo7EQ7ykJOR?=
 =?us-ascii?Q?Btr7QvdiyRZyg1G2LHiJhKdvVJy1NawedRw0S/b3eXCi7qCuunCprfsntDLC?=
 =?us-ascii?Q?1JtAZBxBTVY+3Yk6kXGDVZ1jOJmLSQODqp7XQooXl7l7Q0Rp5Wpx0GGqawbv?=
 =?us-ascii?Q?skW+oRQDldLuxcjC8eqpW1sGxbcVvlTQqBecla3N6onpekWU0huen+9rSLdM?=
 =?us-ascii?Q?gFdMpRCGZ7XY7+dRd+xaPpUBVksQ28zmOf9+eIFN0qerZ/ugf+CNehh2x+YZ?=
 =?us-ascii?Q?YEUFjCVP3PVk/UT11dI1aqX9phOpZu+43IGH22T8yZf3CRzu15o5Y7C1iQmg?=
 =?us-ascii?Q?6NmO9tAoV0/ls7ujvJWn15IGq+DQsbxQ0YTZXSWsB0xWT2lXXSt6A+zaFxJb?=
 =?us-ascii?Q?eZxhVq10gQkoGiBXiDAK4ZrDUsdA5LfwOTUBnAh/ar0f5VSdfdV5avq9PTCx?=
 =?us-ascii?Q?M5uzEvLq98xaLEa5uWkMsmtTYyq1JVTqjUu/haiSzkGbWmwZHiP8tte5RDwg?=
 =?us-ascii?Q?PGqv6ApLh7gjcgdbGS33pSOef9dNHmGiXLTGP8II9VK49RzTiz0Eemzglt85?=
 =?us-ascii?Q?z17jzXibv0p9Y5maUkN3RIWjopk5DCnbjlqRJkWq+2NUN+DmM3wV3Ifh6+2U?=
 =?us-ascii?Q?h0FE81yOzNvLyEsTbwopYlOD0Cp/s6l3x5UbOrIa1R+jux/MC0GEAGAa1j/4?=
 =?us-ascii?Q?4u4H0QZvbMtEUFX57NLSUGP0Mc88Swu1NtFaNovDdB+/P2VL6T4INDn0r3ka?=
 =?us-ascii?Q?aveVDNGFDsTnhXXntO28aAcC+8SRXCmmPgxLMoslOlfuAxtB8qhT92lk3R1T?=
 =?us-ascii?Q?uOx7SBlH938D8H/AqKp/mdoJt7T/WzhiHhK1ufzUPZUFxrxdJZUofoLRUfgw?=
 =?us-ascii?Q?9DlluIosRpHj9rkAiwHTAUMRDdp1eTyD7XPx7HYkomZe8F00I9eZ8xGZIHIW?=
 =?us-ascii?Q?R/V89MlpCqcaZMvRjCpWbJerj98foTPzZIZsXYC0QsIaZPmgm3j9nVCmJ0Aq?=
 =?us-ascii?Q?qi+GQkbVWThk8EXOfqgcM1U0qe2BnSbD56zd7SVlwWJAU6d2Th7lL9TuH/Ek?=
 =?us-ascii?Q?lQpU1i7OmYewYPe42QuoNbU6Ic1hUP3kaAkxqaejPt2ebFODOlDs2D7zC6G7?=
 =?us-ascii?Q?CIz90fOGNV+mn5Z09Iod7hb80Ynlb+vsxSkFOMCc61SD6BZRqrLce90gyBDF?=
 =?us-ascii?Q?dZQDkTnEJFOO1SXkLKlTkkSiSfizBzjhaZMSckjqCG1oZHmR8BimzDrzyTEK?=
 =?us-ascii?Q?7nWsBFQylaqpMIziACyPYaH1G1yZuJ8gQ0S+sDG6eICgcVwbuPjtqGK8kdca?=
 =?us-ascii?Q?2u41g9Jr4MgNz5JCfX2hiEwLW2aU5tVomXXH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:49.7920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281b7bcd-fb63-4f09-fcf2-08dd7c16d73c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676

vxlan_find_mac() is only expected to be called from the Tx path as it
updates the 'used' timestamp. Rename it to vxlan_find_mac_tx() to
reflect that and to avoid incorrect updates of this timestamp like those
addressed by commit 9722f834fe9a ("vxlan: Avoid unnecessary updates to
FDB 'used' time").

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 762dde70d9e9..397b1691ab06 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -429,8 +429,8 @@ static struct vxlan_fdb *__vxlan_find_mac(struct vxlan_dev *vxlan,
 	return NULL;
 }
 
-static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
-					const u8 *mac, __be32 vni)
+static struct vxlan_fdb *vxlan_find_mac_tx(struct vxlan_dev *vxlan,
+					   const u8 *mac, __be32 vni)
 {
 	struct vxlan_fdb *f;
 
@@ -1897,7 +1897,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		}
 
 		rcu_read_lock();
-		f = vxlan_find_mac(vxlan, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
 		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
 			/* bridge-local neighbor */
 			neigh_release(n);
@@ -2063,7 +2063,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		f = vxlan_find_mac(vxlan, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
 		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
 			/* bridge-local neighbor */
 			neigh_release(n);
@@ -2762,7 +2762,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	eth = eth_hdr(skb);
 	rcu_read_lock();
-	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+	f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
 	did_rsc = false;
 
 	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
@@ -2770,11 +2770,11 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
 		did_rsc = route_shortcircuit(dev, skb);
 		if (did_rsc)
-			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+			f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
 	}
 
 	if (f == NULL) {
-		f = vxlan_find_mac(vxlan, all_zeros_mac, vni);
+		f = vxlan_find_mac_tx(vxlan, all_zeros_mac, vni);
 		if (f == NULL) {
 			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
 			    !is_multicast_ether_addr(eth->h_dest))
-- 
2.49.0


