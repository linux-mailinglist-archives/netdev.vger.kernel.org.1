Return-Path: <netdev+bounces-114885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7D9448CA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925D81F21C1D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83316FF3B;
	Thu,  1 Aug 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ne/zLqmc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA268F70
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505872; cv=fail; b=tU7rmlGwfkITStUP3ybQ1B2qDkBAoc+/8CBB20psCRewNtlRc0x/ZLlPCW8tb2rxqbi4n6qB8jRLOuU6O5nqQonWI/kEOEeWeT9kZCMQAu6/nqhPcl+Xr9/Kz3zekdQocpFw0TP2yQP9cM40bT3sWWgx9JkhqaLqA5+yNcsvviE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505872; c=relaxed/simple;
	bh=7r9n+F17kPfo+tBt2kTzyxDPzfUN9dZEUrnOlmyyZh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz1BVZoaP/NXgcW8o1WuErxp2RE4jygLfqglhAIP3F8wfFRalToUL1/YfsHX2NjiyRYqPqa9OKi02e8vWx2Dagtl4CjG4iWoRJ+xGNKIQ13b/WG34VEgl6AQ/wWcWG3NC9sHuAUpyypOcfe4YV8BSvS4rK4ZCLus3egHOWv7lik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ne/zLqmc; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYU8rcsN6ISG4f/aHHqaY7vBSZYfCnoT1SRx9S5RS/Y1WvSt5UHX4nL74m/JPBXJEDeopxF/N//IvUa5eIfyiRu1kRbBV2z/psakQgJYYcDpCmQCcOLqMqZuXAouPWIwx9gc4Yarc4Lxen1nx7AJBpfIMQn3ibx7tjLnT0DYnMaaiERqd/dG6+OUT6XOodrA1Q+ilZVMWRV4TdpXqbZQqG90BL2ds2chxqXEvJithhGC6mkp7TS4N6IIkDWjBgUdgot8dBdjUtnjbD+4+OrADTGSqkZA0PUchdn9Lh0HBldDQp67DLanm0jd0rx34iZP3FQFAR2LKLFi605j5rJNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4mSTfAi4qiQwUSH/+c0mC2Kqvgr/AJu+0DGkstM/Es=;
 b=MWaux8DBr13ZJagK8DdpUNfkPcRoDzzs8g8LIuY0LDwfC1CAbeqh4WySDYL2ye1auuGeasW+9tl19UG67Quxy6/Uq3qVXplE6g+U+eTpSzgUPqvqR3d2WSvOxqXVUhJiliVBhoRDYsRN25y1FViUw+0nFQwmxQ85HZ5b+pdKHdv16kK0M0ut6tEicU5ip/aoS/IcNyfVdtu6+Yp++t8TEk4ljUeb6VHBq8YDZWv/X3zFFPNvBK/ew73wgKXZyJzYIvIb8c/62OlKGzUp1QVLLTeBGiLBj0jdVeqoY3zVNFKPOP6+JKT9yh0T70G4dmmzwth0eCPMbiCU8kTfQ4ToOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4mSTfAi4qiQwUSH/+c0mC2Kqvgr/AJu+0DGkstM/Es=;
 b=ne/zLqmcuBgOaGRp53sjNXmwlZoOVHGmHwKOcqxd9oYG/dY/58acMagwOuMuP5ecw5vGkiBU7wwhRpu420AoMNZzKmXgbSZp3k4regZ4UKp53je6E8aOAAIo6Tlu7OsNEFQOL1XevGFB2hTO+LKGIeav5H+LnVgUFfkSQcgT2gyf2uwvo9p/Y6w9loFKfcorK3AQ3nYwNvoFI6ccad1NNXXKUQfbDni5isolYTVnTvJblMJQNbzjg/wkWufkHB62TRSNeeDu+ZeNAA3ZJLeQoPoLKYAQ5ogtKqg/Pu0Zn2fVSdvodvdUr1TsX4w4B7ifK1PKt9GXF/zJhCKXfjztdw==
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 09:51:05 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::ed) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Thu, 1 Aug 2024 09:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:51:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:50:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 1 Aug 2024 02:50:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 1 Aug 2024 02:50:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 2/3] bonding: extract the use of real_device into local variable
Date: Thu, 1 Aug 2024 12:49:13 +0300
Message-ID: <20240801094914.1928768-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240801094914.1928768-1-tariqt@nvidia.com>
References: <20240801094914.1928768-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 0265cd8a-9d55-412f-56b5-08dcb20f7567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7mLN5JI7cw4ZOystUXaOVjr5Y2mASf1bmJwnSu2Ll2oy03gtqnQjhw9pNNt?=
 =?us-ascii?Q?6ES3b2mx36MQKYJ5cDuYkcKjFb87wMN4EL6cgcxT5pmJWIrB0F8eeQFMxwur?=
 =?us-ascii?Q?tgzpJtLwZ5mk4OR+otyv0ZN8vd6iPlKQG/Pfl8YaRsQerBOVTmzJ9HPe0whM?=
 =?us-ascii?Q?YIRB7hjsk5Ej0mrX35+jzMymqIcjinvpd+2rI7b/OCZJMHXNndYqTguMK34i?=
 =?us-ascii?Q?Qs2nyFxR0A+38xZGZmo5ShE3xKQBNRB/OxE2X+EK7e6rwDDUJh0bJeaDNDLW?=
 =?us-ascii?Q?gYdVbuYBWrwK4QE0fB0EDqBfLmyW05qQmvo+2dp2jIiagYsyzgyI9XX+cGM6?=
 =?us-ascii?Q?7fjX6L4w88T/BoHCWBqz41ykhoV96/0lWm6/7FLSohw4NTf2W7bAMQJzfZKc?=
 =?us-ascii?Q?SHoVq+a57UTY4UkeifFOz7msuocVheOcEzfFlUqIg+VdKVPXgSI/dQGle0mv?=
 =?us-ascii?Q?mvagTc0RvhG5UVP8MzvfGVAE6g6YvT7zVpmY+Fqvh6ZRB4oBsp7gIq2GI5UF?=
 =?us-ascii?Q?ZbWxzndXO9Kxo8IWYA1Bjw1oqDEhMxPL8hjzzb79HQ/L4G21KbyEvJ9uqkRn?=
 =?us-ascii?Q?xX1PnujaCbLqskWHUwYigDroRodNUJjiQGVQaKbveH+2EJ77x+HqFkDIcohf?=
 =?us-ascii?Q?JjeK6UtyX6yOnwe+qoyVpQ2OIuVp4+AG8eQKnTqCuwGq0M906cASKqAgPhrG?=
 =?us-ascii?Q?JmSAi54U7LxdxQE4eYAEvTn07SJG4iU0MkxriGTpAkQGKGgABVgxXJREkhJL?=
 =?us-ascii?Q?8DTLj6+xLicF2IMlW/SU4phcXwjyUYm1Xu9WYvqCSW/LdKJSBV+1wSTaOFyI?=
 =?us-ascii?Q?EvvcgenVBQVys7GkvF0elFJziiF3cOHX+Lbro8geIHxfQbJlLRaYHC1XKFOg?=
 =?us-ascii?Q?vdQUbqwkQKi84UdPUPNh126/NPOmzJ+bP3Zh7YNwogfH9Io+rGpeKb68RFu8?=
 =?us-ascii?Q?VlluSxCLO/yFE92jdddsVgZy89MHy037ZmnDll0fL/CLe41KAzdEju6OSc6R?=
 =?us-ascii?Q?4p/GUVJPTXFxIxy0yj1v40uNtkq6QHqjnPk+MDWKx04ZaU2DGhA0TOh0WcK3?=
 =?us-ascii?Q?W9uIkCL4LEP7CzYvFPL0bmmNRY3zwmbcHXZ9gP+HSoenMcDzW1IF1btQj0nB?=
 =?us-ascii?Q?1L2esB+gq7onZa30sqg+qR0XVutDrOtY/TOlg9SYPLR9tRi6CvnKt56ArjcO?=
 =?us-ascii?Q?kvAvBdY9jQgfOhjtmOgtc2YlHKte5nPxSVj4wdpwY6otgBXTzYqCTWIOxKkP?=
 =?us-ascii?Q?Aq7OoEWGc82zZnr3ny27glrksv5orw2qP1QGrun/TrBhcDuThiIaYCKo2ndo?=
 =?us-ascii?Q?/gXNNaMLBb0OSoPz56oqzHTUwUGLOJwyyA0LdaaPndi4xJNI5MuRT6EUTC8h?=
 =?us-ascii?Q?MMfAzWS2dSHJt89rSBDJ/dc7utGvysWN4wiVygX0thqSxRbNj4Xpd9zDX8CN?=
 =?us-ascii?Q?sPHykLB6Bl78lskcIGIkyvOIL7oftcSA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:51:04.1853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0265cd8a-9d55-412f-56b5-08dcb20f7567
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899

From: Jianbo Liu <jianbol@nvidia.com>

Add a local variable for slave->dev, to prepare for the lock change in
the next patch. There is no functionality change.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 774d7a39723f..e6514ef7ad89 100644
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
 		ipsec->xs->xso.real_dev = NULL;
 	}
-- 
2.44.0


