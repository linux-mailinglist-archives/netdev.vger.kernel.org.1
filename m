Return-Path: <netdev+bounces-182762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD28AA89D4D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624731900028
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C22957CA;
	Tue, 15 Apr 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mm9C1I/5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8462951C5
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719201; cv=fail; b=k7hGrbMFFdF8jXODeoyc+jECp6U7BoM1lEqQ5EfVkJlEoZ6ZyaowHGP3WxtbbuWsnM8m6UdJcxB20QReWDAET1JqipJ3S4/hxeHHsVA0Zjhs/eXdXvd1yA3uoOSHYfFhktJvlzVriXbWsdbclI9KSeo/9eCkQn3GOflaeQQnsZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719201; c=relaxed/simple;
	bh=YYC4PrfUCbxbaDbSKoQwbZYLnrWGy+M2m+Y8QdI7dBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNarhN0nf/wSLXcCl8FwotkP4ykHrpkafK0rwGO5CE3mUAQmNrshAjT53C3qQA1IHLsRoOXlvRbXQDSlrSc5IWq8J1idR33wLMK7laWQhqcTdPnsPUE7c0w5qDIt+kROQIlvexb+FC/4QBGbndIDdcH4mpRA/zSJOWAqzU9c6ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mm9C1I/5; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIj20XSSg+6iYu6u3DXZTqlqSc3bYycAzoq/+GDUNfC1TyBSfaHVkFW2H6Xrgc0AnRhrjObAXPZNOnZWtNnd99okLhUP/m2jHKafhCdzf6TEdFQNzyeF/x2++Rzbh4R6T3jV9MuchOrloVcJ+E9Y148R1eCBtE45ckNb2ydPYdyQr+jVeSTNByJ6zLjzqo4qkQ/ROnuPM/uWeh/QAKe6+7+hu4bXIfLNu/Qn5+qkqHlrW+zdxBChsLsDUA0zlRh3gfeGWggg7+DqaF+S/GXCm/bqL7FTolqnkR8hHPl/NAL4Mlq4MWrx95WhHlZvL9GChiN7aTrT7T7cRFtYhCcudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+sMHlK7YnwbBFDqNn9cPGcaiPOGCCs3NGxZ5HuL8+E=;
 b=iWS7ziCZpr0uCe0nRoYFbzXSU3ZvsVY7UKx30NI2JKwqMWh0GKZjMJ+6q4iev5Ond8blKVf/36XR1gTGlBrxgKY7XXYKDOZdc1zP8kq9sHmWYPGO7mJ+8UChfqy3vseKJAMpzN6qIjjN9z7ECCRWIrguufNpBbCeWRJZDhvy/qVF5L+F9MlACNKfmPmji3vdgw91Egj3Hqn3zp3vQiTfYpIk9Qb6RTVPrn84xCKIMuDq4wIEz6EQ8b0PCyKNJ2A7UZYfSvtdrf3EZBWtxn84zGAFImTqfYLU+T5jBL8/aaG105wBq70a+QIx1PlXDZchhUx6tKNIJK0LQFefuWfZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+sMHlK7YnwbBFDqNn9cPGcaiPOGCCs3NGxZ5HuL8+E=;
 b=Mm9C1I/5HvuOrwFDE4rVw2tVTHLNWTco4QBMfYF00bnIFEhC9Zgzzflfwt7eMsqr82S90gaG4aZobYXZJ+5lwRA8XRi55UWKH3w1ibnbBcuK9FPKDaw05YScbI9axAiUzKT5JdiQUyWxbHYJvZTpkcQXHav3uVXoVzDl2LRw2I5AloVp9mIqkGRSjeN7B0f91CYD+27ep81r58bGf57Fs0pbcnAa+xTU47Ex26oo7gnUi59v1hkwSEuLgWM6U6M4qUzx12arx+PJqc+gd7H/JQ/2eGIh2fBMNGCcjs58GsE3ccBNn2pW+hjECXcgdqwtXK2IlXx00ou/tPQvje2AKg==
Received: from BN9PR03CA0581.namprd03.prod.outlook.com (2603:10b6:408:10d::16)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 12:13:05 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::ef) by BN9PR03CA0581.outlook.office365.com
 (2603:10b6:408:10d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 12:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:13:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:50 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:47 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 14/15] vxlan: Introduce FDB key structure
Date: Tue, 15 Apr 2025 15:11:42 +0300
Message-ID: <20250415121143.345227-15-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b88b45-dca0-4235-2a06-08dd7c16e08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6ut/X4PP/89e1mGEc0I3jA2HSER8Jf4SD3NsRWBehxBngaUsLHCJCuqn2RT?=
 =?us-ascii?Q?0QPua6mZntrLXihZYpw9QT6PN8sC/6FsBLFotvSADY+EphOxpQtn0Z9sgp/A?=
 =?us-ascii?Q?7dDTjRJL9QgkvAdBHxiTcgXO6o7yYlpM8CmUUKkkIl833EgpCnArR92Jdfhq?=
 =?us-ascii?Q?q1ffCkeaJmTBrBbitsh+LHa5x+P8VSJLPTY0e3X/ZS5FMa/OTk/yaBJX5bfb?=
 =?us-ascii?Q?O88wU0jqTMnE2mMENwHCbedUa1WtUlOcQcw5c2a+Uh88PaSGntliHIDyN8ns?=
 =?us-ascii?Q?yKVHC7WSM7QA50105a8WeBcNJ3OiRLVrbhf8QD9bn/n/0qKtNjXm7Qbj3r+Z?=
 =?us-ascii?Q?oRT4QBbWAg4wwSernB9KT9U0bUNQSonf1FENTGpULXlIlZcjdJojHu9iL9VC?=
 =?us-ascii?Q?Qu0nWIQsGEhqUmla0diY5pS2Vg1k3Mwo2xx1oPdRCb8YaSN3L9wMbAT4bFc6?=
 =?us-ascii?Q?QSGVVf4Idg+hGkImcJL1gMGy4st4zLrOZ64LRp6iL3MmBEdc7F72SBuSESJM?=
 =?us-ascii?Q?Yl7IoNX7+pNzjeJ4BzFr6QxpuoKNlqc2h9EVgwztOn5ClJRfe/Xgw9ae84Tu?=
 =?us-ascii?Q?kb0u1XrBMbo7gdfm5I+F40GJenEn7Ee/elOJ9Y6QqEqK7QgFKqIiapTmIPp1?=
 =?us-ascii?Q?zUHcA99hnJ0153MOxZLmTOYIH3t4LXxMqwxNw2stJkQCddY3/Jx3rhRVjOeq?=
 =?us-ascii?Q?hIha8l4UFZ1pdBYFIXf46clJ13T8d5oWKj/NPX3y4VudxKt6tj57eIhCZ26U?=
 =?us-ascii?Q?3nkEeGjDgxxeo83gRmkAzD1cs4Pr87hIZ7oHYU6DCHj5pfmWAipZVAp2+8Ih?=
 =?us-ascii?Q?S7akJhe1IpPovHs+HmKntNy2j9DO27XxZ4Hq54kejVT6PVPIFz0M20KPVEoY?=
 =?us-ascii?Q?K8NyD85MTXe0iq5iaJKNT5fIQM+BbTWClsPahlSXfwUMDQP4KT4l+eFb3/7C?=
 =?us-ascii?Q?Ava40NXOPJAI50D9o7mo64sxhsBfLNkrITfViun7U9b9MUMm4hcMgOXwPXtr?=
 =?us-ascii?Q?mzlzkvyoQLUzb79/QzWv2nGNtkGkSvLR691u2xqHM5CsLfv03hXYImMWa7Ho?=
 =?us-ascii?Q?Zsv+epKbvisqH06QOhg2URthO7dlRBTXK9atXT+R8fj7MhZMonhnY5ZBrxb5?=
 =?us-ascii?Q?VEcZLtwAdMMJ9YRz9thniQDkFUSVQ0ayFuxHVewt1OHKUrT8diAPecWUKiFT?=
 =?us-ascii?Q?lXdIjGwKenqlEx1Lr/pj2xvU4gj7pLO3A62A7BjkVgNn6wDf8ag/MGk4K2y+?=
 =?us-ascii?Q?kbHiVYzwSIY5wBwIztPKglQ8Oos7Figfh77AOrHi6U6t0jsjTxzk+91OeebB?=
 =?us-ascii?Q?Z4xYQl5L7KG2FB19K1ia90Jbe29+7nRU6Zb+MkMUYesbZIOqxakhJxRpWTWb?=
 =?us-ascii?Q?KZjZqT3NF6XQUELmNpJ00Q6YvL+DWBE1pf2V7vD0UQfJWcdPkel1W/I5rDgP?=
 =?us-ascii?Q?dBhIGBHW+EYAHnlYiEZKYPDoKxdtVdvq6eqr7krlrIdAShfpAG2pF7DjbjZ+?=
 =?us-ascii?Q?ESAUjYiGSb8u3g8Rl7Z4ZoswGn6dPuGH9guY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:13:05.3075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b88b45-dca0-4235-2a06-08dd7c16e08d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

In preparation for converting the FDB table to rhashtable, introduce a
key structure that includes the MAC address and source VNI.

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    | 44 ++++++++++++++++---------------
 drivers/net/vxlan/vxlan_private.h |  8 ++++--
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5c0752161529..8e359cf8dbbd 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -186,7 +186,7 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 		} else if (nh) {
 			ndm->ndm_family = nh_family;
 		}
-		send_eth = !is_zero_ether_addr(fdb->eth_addr);
+		send_eth = !is_zero_ether_addr(fdb->key.eth_addr);
 	} else
 		ndm->ndm_family	= AF_BRIDGE;
 	ndm->ndm_state = fdb->state;
@@ -201,7 +201,7 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			peernet2id(dev_net(vxlan->dev), vxlan->net)))
 		goto nla_put_failure;
 
-	if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->eth_addr))
+	if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.eth_addr))
 		goto nla_put_failure;
 	if (nh) {
 		if (nla_put_u32(skb, NDA_NH_ID, nh_id))
@@ -223,9 +223,9 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			goto nla_put_failure;
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->vni &&
+	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->key.vni &&
 	    nla_put_u32(skb, NDA_SRC_VNI,
-			be32_to_cpu(fdb->vni)))
+			be32_to_cpu(fdb->key.vni)))
 		goto nla_put_failure;
 
 	ci.ndm_used	 = jiffies_to_clock_t(now - READ_ONCE(fdb->used));
@@ -293,8 +293,8 @@ static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
 	fdb_info->remote_port = rd->remote_port;
 	fdb_info->remote_vni = rd->remote_vni;
 	fdb_info->remote_ifindex = rd->remote_ifindex;
-	memcpy(fdb_info->eth_addr, fdb->eth_addr, ETH_ALEN);
-	fdb_info->vni = fdb->vni;
+	memcpy(fdb_info->eth_addr, fdb->key.eth_addr, ETH_ALEN);
+	fdb_info->vni = fdb->key.vni;
 	fdb_info->offloaded = rd->offloaded;
 	fdb_info->added_by_user = fdb->flags & NTF_VXLAN_ADDED_BY_USER;
 }
@@ -366,7 +366,7 @@ static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
 	};
 	struct vxlan_rdst remote = { };
 
-	memcpy(f.eth_addr, eth_addr, ETH_ALEN);
+	memcpy(f.key.eth_addr, eth_addr, ETH_ALEN);
 
 	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
 }
@@ -416,9 +416,9 @@ static struct vxlan_fdb *vxlan_find_mac_rcu(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 
 	hlist_for_each_entry_rcu(f, head, hlist) {
-		if (ether_addr_equal(mac, f->eth_addr)) {
+		if (ether_addr_equal(mac, f->key.eth_addr)) {
 			if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
-				if (vni == f->vni)
+				if (vni == f->key.vni)
 					return f;
 			} else {
 				return f;
@@ -539,7 +539,7 @@ int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
 
 	spin_lock_bh(&vxlan->hash_lock);
 	hlist_for_each_entry(f, &vxlan->fdb_list, fdb_node) {
-		if (f->vni == vni) {
+		if (f->key.vni == vni) {
 			list_for_each_entry(rdst, &f->remotes, list) {
 				rc = vxlan_fdb_notify_one(nb, vxlan, f, rdst,
 							  extack);
@@ -569,7 +569,7 @@ void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
 
 	spin_lock_bh(&vxlan->hash_lock);
 	hlist_for_each_entry(f, &vxlan->fdb_list, fdb_node) {
-		if (f->vni == vni) {
+		if (f->key.vni == vni) {
 			list_for_each_entry(rdst, &f->remotes, list)
 				rdst->offloaded = false;
 		}
@@ -812,15 +812,16 @@ static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
 	f = kmalloc(sizeof(*f), GFP_ATOMIC);
 	if (!f)
 		return NULL;
+	memset(&f->key, 0, sizeof(f->key));
 	f->state = state;
 	f->flags = ndm_flags;
 	f->updated = f->used = jiffies;
-	f->vni = src_vni;
+	f->key.vni = src_vni;
 	f->nh = NULL;
 	RCU_INIT_POINTER(f->vdev, vxlan);
 	INIT_LIST_HEAD(&f->nh_list);
 	INIT_LIST_HEAD(&f->remotes);
-	memcpy(f->eth_addr, mac, ETH_ALEN);
+	memcpy(f->key.eth_addr, mac, ETH_ALEN);
 
 	return f;
 }
@@ -959,7 +960,7 @@ static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 {
 	struct vxlan_rdst *rd;
 
-	netdev_dbg(vxlan->dev, "delete %pM\n", f->eth_addr);
+	netdev_dbg(vxlan->dev, "delete %pM\n", f->key.eth_addr);
 
 	--vxlan->addrcnt;
 	if (do_notify) {
@@ -1031,8 +1032,8 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 
 	if ((flags & NLM_F_REPLACE)) {
 		/* Only change unicasts */
-		if (!(is_multicast_ether_addr(f->eth_addr) ||
-		      is_zero_ether_addr(f->eth_addr))) {
+		if (!(is_multicast_ether_addr(f->key.eth_addr) ||
+		      is_zero_ether_addr(f->key.eth_addr))) {
 			if (nhid) {
 				rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
 				if (rc < 0)
@@ -1048,8 +1049,8 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		}
 	}
 	if ((flags & NLM_F_APPEND) &&
-	    (is_multicast_ether_addr(f->eth_addr) ||
-	     is_zero_ether_addr(f->eth_addr))) {
+	    (is_multicast_ether_addr(f->key.eth_addr) ||
+	     is_zero_ether_addr(f->key.eth_addr))) {
 		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
 
 		if (rc < 0)
@@ -2853,7 +2854,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			spin_lock(&vxlan->hash_lock);
 			if (!hlist_unhashed(&f->fdb_node)) {
 				netdev_dbg(vxlan->dev, "garbage collect %pM\n",
-					   f->eth_addr);
+					   f->key.eth_addr);
 				f->state = NUD_STALE;
 				vxlan_fdb_destroy(vxlan, f, true, true);
 			}
@@ -2972,7 +2973,8 @@ struct vxlan_fdb_flush_desc {
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
 				       const struct vxlan_dev *vxlan)
 {
-	return is_zero_ether_addr(f->eth_addr) && f->vni == vxlan->cfg.vni;
+	return is_zero_ether_addr(f->key.eth_addr) &&
+	       f->key.vni == vxlan->cfg.vni;
 }
 
 static bool vxlan_fdb_nhid_matches(const struct vxlan_fdb *f, u32 nhid)
@@ -2995,7 +2997,7 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 	if (desc->ignore_default_entry && vxlan_fdb_is_default_entry(f, vxlan))
 		return false;
 
-	if (desc->src_vni && f->vni != desc->src_vni)
+	if (desc->src_vni && f->key.vni != desc->src_vni)
 		return false;
 
 	if (desc->nhid && !vxlan_fdb_nhid_matches(f, desc->nhid))
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 078702ec604d..3ca19e7167c9 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -24,6 +24,11 @@ struct vxlan_net {
 	struct notifier_block nexthop_notifier_block;
 };
 
+struct vxlan_fdb_key {
+	u8 eth_addr[ETH_ALEN];
+	__be32 vni;
+};
+
 /* Forwarding table entry */
 struct vxlan_fdb {
 	struct hlist_node hlist;	/* linked list of entries */
@@ -31,9 +36,8 @@ struct vxlan_fdb {
 	unsigned long	  updated;	/* jiffies */
 	unsigned long	  used;
 	struct list_head  remotes;
-	u8		  eth_addr[ETH_ALEN];
+	struct vxlan_fdb_key key;
 	u16		  state;	/* see ndm_state */
-	__be32		  vni;
 	u16		  flags;	/* see ndm_flags and below */
 	struct list_head  nh_list;
 	struct hlist_node fdb_node;
-- 
2.49.0


