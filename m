Return-Path: <netdev+bounces-121223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD895C39C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407592848A3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D3381BD;
	Fri, 23 Aug 2024 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ur9URQvP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0EC364AE
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382692; cv=fail; b=RgTRNceV9LKyhMx+ULPl7mhTfn2xwWli2Lk+Ms9NHy/RrrRyHgxtVLLzaA59T4o5V8unepNi4KKDRfZEsdtKuWRe98Zj1Cq+hnKa6NxNpvhPXwitXqnaRCm95v8xuzm+yUexmrRxmthcWo2k2fQi2g7XA8dG0mq6tJWwtOcOkM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382692; c=relaxed/simple;
	bh=wfDBumN18Pr31KATDLFlAUc9OOxaFtbQm0dnjmPalP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJn1UvegeU+t7SbimuflMpQtzYx+FoVA+DTnOUB+6axb4qZhDvaz2AAlN8NIXi0IDV8pTkOrr3apzamblE9bMm1LZzfycqm9A1T4sFktypZXReeizYnh7nxvfpk02qXrrWmFShFz5DBZ8AdkBzwkwkevzvcVvEuvvsLV/r0mOhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ur9URQvP; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbr445wYLTrJgypgmt3FgEtMuJGgGU9QJV3pqv0+apeSdpq0DY1aSK4UiAvKTHltp7PWEGjn9P8BoIuRi5aPkjulgEzZdFYWgA/lgAaK64Kvmi5sO6AUF/N6YVCzIsjLjHIwhgDwDXgsp6cOiLIm6Hc5SLGRWloK8nqxQqzzlOAMeZU5INFsbCPfhvwoSP7+nBKVXAFjcrtXVPxznR+vsWSi+zuObuLqAH85LIjk2L6n0XPXZOEvyVkjIyt7CC7ER2/v0ddITe3d7cg+ogDg7269uGGsfCrOc6fDbzniZat7Ti6VHlcGqafp8skVREal+xBJUNWuLUk3t/6Sy75yEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7OnddbHJC6ePBbqzqzC8qsiWp/LYNbe8fb79oPz/94=;
 b=mr+YBk4JJf3+fIC25E/u1Xt42YBihtwJcwPNArJbBI0PrIS3nW1URfbFXQVIKXmYv9YQe0+s3HLOCk1q47fsu2a8fwvUdtpFFVA4E16gBEI6NHOlfIm21g+gESdA+22nme2xTiZwjweHNxTBfZZBTsiPN3yobu+ieaCQKj4eIg80Rc6haqsiW6orMlazSzxqAkn8b87sBvJuKRCwZwHcNrhBwAKpUnToKxG0AE5v8IHbA6NX98EgbzyQyJe+1Oa9zpqvbU68T+9DOkbqcjKK46EWd8gZmg5XVlCGkS9co8CYGOCmeEZYvHGXdTwlkPJfhU6eVtlmcqV8zw4c0cXyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7OnddbHJC6ePBbqzqzC8qsiWp/LYNbe8fb79oPz/94=;
 b=ur9URQvP4TvDPN7aZ4bbBnleXCUy9hLsaGYoresSnIyfP1XajY2v+wLGbMrX8MIDzlVOFtTGk6KAJg3iu0fsF+vxHgA4uswfsYktmgKrJYhOtfa1XXEgpf1SqqSe/oRVsh2saFSEjGWICGb/sVTKKNXc1JRnECNzV49tDa0D5SfNrbKa0QKthBoDrezuElPDDOoaD/fuSrFu2Sl97dw2TjZWxrgqN1qEiuwiGwQTxvkRNSd18Vz3KC98HOGuyF/x+/IGaIP03mI6JcdiNtRTIFMedqVr6xprrEd8ACG9kvNVhVDhNlYnoix6AMDenXfI7t2TIwDZVcAYFrgwNqosBw==
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 03:11:26 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a2) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12 via Frontend
 Transport; Fri, 23 Aug 2024 03:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 03:11:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 20:11:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 20:11:18 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 Aug 2024 20:11:14 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net V6 2/3] bonding: extract the use of real_device into local variable
Date: Fri, 23 Aug 2024 06:10:55 +0300
Message-ID: <20240823031056.110999-3-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240823031056.110999-1-jianbol@nvidia.com>
References: <20240823031056.110999-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d05222b-3431-43c8-ab77-08dcc321468c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zw6Yb9XWCysUcOTJFg8T8W4oLBLwK2EIibuMLCz/dsc3M+qsZzlRi7zfCixH?=
 =?us-ascii?Q?dalcQlEdA7EirwOAco6pKD+Qu1eLvc8MwH6ppWlvR8DT2+ucmd/VdsKm0rJl?=
 =?us-ascii?Q?dXEC2x0vuyXUqrnBEbXH8Mwu6iB+9zTFpCHNU/T0YmdmDxhvjLa7+uizJsXY?=
 =?us-ascii?Q?qHKgGsH2TpJVRFwfXhVtl2PIPbphBDsRw8aT8QmOucO/kwpdMvAnwgxKwVtM?=
 =?us-ascii?Q?zfkbWatEgbNyXcdzsifIrgCRvY1L1vsy+FKzTAWST5HTpgDaKYI5w+dTdy0o?=
 =?us-ascii?Q?mRuYktTzRdgizy+M/ssaZ2jBQPBWZgeBi7yS27kCMDMO+661lL8xGPiEq8cW?=
 =?us-ascii?Q?G1f/fmQAmAFZp6/mXobOEeIsHEnWWScs6d0tRIXypY8susaZ402bm47aVUaf?=
 =?us-ascii?Q?Wbt0rUfA3nHy6wNIZuXQAqD5APL7iw49rhS6wvoMhRg6vOU13cEz6q24Utir?=
 =?us-ascii?Q?ihUyZdetmyw4nzHW25Zu57npB6QC0twO+Y7hg7IMjr/O/bFM8hG6unAMrC73?=
 =?us-ascii?Q?ElJp8pLi6mSRyluu5Q93JSwB6zLrEC4Tc8z/a/gCrpi/CYcuYStCzXx+Q8mk?=
 =?us-ascii?Q?ShVAmT9uMkqTzeDIJD0x2Iw5CrG3J/j464LL+8kJmCBp+cgrAiaT9Oyb4/hN?=
 =?us-ascii?Q?8NXod7PGA5CoPSaA/q49HMxghYFq8+fQxtOLIwhM+BYnV0SVhPXUCG5YK624?=
 =?us-ascii?Q?Sy5Y2MS09Iq4x9YyT9nY/w0P7t6sOVYp9HQcp8Gf36bycBrar2mPRue36cYB?=
 =?us-ascii?Q?HTIUuV7S9WO4y+d8cQlF9QyKP5LdecqYw2rBiERY1UBABd6hCDkcB0ue+H5e?=
 =?us-ascii?Q?i/RNxmIBjDcuaxBbD4Vrvz4yUmqdmZMQfUCoQy+WRvUYDFmnYgZmlK6HyAeJ?=
 =?us-ascii?Q?vdOb9osgDuHAKCE//HzyKvRvaXv9XPTBINKyzLh3rF/sT5OOAkcX2UuBzZHk?=
 =?us-ascii?Q?V7ycS8gecOAVNnXrPQ8TGOSl0poxcAQ4MmMHaeXWWcZduPxewmnUx+D1uuxd?=
 =?us-ascii?Q?rBDFnUR2FKFPIa6eRE6EK4HGQAw2XGsPz0IFqbMWeVclPOK3G36Zd0FP9MIw?=
 =?us-ascii?Q?bAI4aJ70lbVT0TJ6ewhQUKAIOGrU/xJtv7boL0LzRhmj0cp63fKQ916LlEQv?=
 =?us-ascii?Q?zMGaNAUAbcCnCtTtyboh2Wy8rndtGgUQ6ON3HD2KRCyDRAyC90hfHi/v+c8k?=
 =?us-ascii?Q?JSYf2fHN8ciai1MhpvSpVpcTQteAX0PRVCoSwkwImaDiL2HuEEyp/BD3HcbU?=
 =?us-ascii?Q?P3V9gyEBhtpl7GHOsy1DFBGsjjdSFuonODRuiGh3oavWLlrecovPYZPDJglU?=
 =?us-ascii?Q?+uxdbMz66eipRQsFVD4w1EDFoyezwgc2QfcxMfXPJqTBQZITpVV820WuX39d?=
 =?us-ascii?Q?W+744ed71QGKjj66PFkJj3lX+Id8FeqOVTqVdyvlMLZRwRKomfRxUbxS9PBl?=
 =?us-ascii?Q?4foITa4O6a5bp+vnCuJcWbWd71INP6lY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 03:11:26.4572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d05222b-3431-43c8-ab77-08dcc321468c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492

Add a local variable for slave->dev, to prepare for the lock change in
the next patch. There is no functionality change.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2b4b7ad9cd2d..f98491748420 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -427,6 +427,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 			     struct netlink_ext_ack *extack)
 {
 	struct net_device *bond_dev = xs->xso.dev;
+	struct net_device *real_dev;
 	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
@@ -443,9 +444,10 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 		return -ENODEV;
 	}
 
-	if (!slave->dev->xfrmdev_ops ||
-	    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
-	    netif_is_bond_master(slave->dev)) {
+	real_dev = slave->dev;
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
+	    netif_is_bond_master(real_dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
 		rcu_read_unlock();
 		return -EINVAL;
@@ -456,9 +458,9 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 		rcu_read_unlock();
 		return -ENOMEM;
 	}
-	xs->xso.real_dev = slave->dev;
 
-	err = slave->dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
+	xs->xso.real_dev = real_dev;
+	err = real_dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
 	if (!err) {
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
@@ -475,6 +477,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 static void bond_ipsec_add_sa_all(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
+	struct net_device *real_dev;
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
@@ -483,12 +486,13 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	if (!slave)
 		goto out;
 
-	if (!slave->dev->xfrmdev_ops ||
-	    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
-	    netif_is_bond_master(slave->dev)) {
+	real_dev = slave->dev;
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
+	    netif_is_bond_master(real_dev)) {
 		spin_lock_bh(&bond->ipsec_lock);
 		if (!list_empty(&bond->ipsec_list))
-			slave_warn(bond_dev, slave->dev,
+			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_add\n",
 				   __func__);
 		spin_unlock_bh(&bond->ipsec_lock);
@@ -497,9 +501,9 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 
 	spin_lock_bh(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		ipsec->xs->xso.real_dev = slave->dev;
-		if (slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
-			slave_warn(bond_dev, slave->dev, "%s: failed to add SA\n", __func__);
+		ipsec->xs->xso.real_dev = real_dev;
+		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
+			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
 		}
 	}
@@ -515,6 +519,7 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 static void bond_ipsec_del_sa(struct xfrm_state *xs)
 {
 	struct net_device *bond_dev = xs->xso.dev;
+	struct net_device *real_dev;
 	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
@@ -532,16 +537,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	WARN_ON(xs->xso.real_dev != slave->dev);
+	real_dev = slave->dev;
+	WARN_ON(xs->xso.real_dev != real_dev);
 
-	if (!slave->dev->xfrmdev_ops ||
-	    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
-	    netif_is_bond_master(slave->dev)) {
-		slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_delete\n", __func__);
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
+	    netif_is_bond_master(real_dev)) {
+		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_state_delete\n", __func__);
 		goto out;
 	}
 
-	slave->dev->xfrmdev_ops->xdo_dev_state_delete(xs);
+	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
 	spin_lock_bh(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
@@ -558,6 +564,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 static void bond_ipsec_del_sa_all(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
+	struct net_device *real_dev;
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
@@ -568,21 +575,22 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		return;
 	}
 
+	real_dev = slave->dev;
 	spin_lock_bh(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (!ipsec->xs->xso.real_dev)
 			continue;
 
-		if (!slave->dev->xfrmdev_ops ||
-		    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
-		    netif_is_bond_master(slave->dev)) {
-			slave_warn(bond_dev, slave->dev,
+		if (!real_dev->xfrmdev_ops ||
+		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
+		    netif_is_bond_master(real_dev)) {
+			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_delete\n",
 				   __func__);
 		} else {
-			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
-			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
-				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
+			real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 	}
 	spin_unlock_bh(&bond->ipsec_lock);
-- 
2.21.0


