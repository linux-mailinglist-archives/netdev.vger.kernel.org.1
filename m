Return-Path: <netdev+bounces-115631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14295947483
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DF21C20AE1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75F13D52A;
	Mon,  5 Aug 2024 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZibU6CLl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33445381BD
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722834372; cv=fail; b=RIcDVxNOgXGGqViaXH+BlQoOX99HFwkeyWB7cdz9rTwPWXOn1PBpl4va2s68VWyIoahVctSyHoDp1+dAm7xibHyp8KqyZOFthGjh+8Clbrh+9uK27bCTF9f87XCoslwcQ6QAdaWl+D/z7DvDDJINxiGPFHiVhmpPdb+WsNpLhB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722834372; c=relaxed/simple;
	bh=6WczBtx4nheguhG2lnAA+hwRVowP8chB97sI8hy8rP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDP2fDvbOrzpWHI5GO6+46/n5eNvhKORJZOjQ4mLQIXbdyQuTEWwXXqQ3IadGA7D3QRNaEfI6KXziHvPYA2cMFlos3X/8sUrNTVERLYGPyXYmoHhajfRX2c1byj/vHnm0+xzoiYh/g/SRPp7BWFyPvOp+aOPlznyY4Z8vG+u/KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZibU6CLl; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KySJZJr/alJNRRhNMc6JeEiyRJIx5E3Mrfe6iIHUsaVD+kkjgiBBRww/6+6V7uuGfVKM0m6dQ+t07ETv1ap7jzYaVBGYZd2hqxUImoq26GXoQCxVf2UURayA+T+2WA4uMcjEtmvKBsDSwa7qcR4kraBrpouxBqX8BgpSjukfERW/9vt+XTAlRzFWn2kEj/yQ8fn5BxGNrmlqYgwPhzImBCT5p9wqTAw79fPz4soz7JJM7PU3jXiuOY9jT9D/dlX6Hz3k3EEchuvfvBNvKo85AGkR7ouL7ItnLrCIVdnjW01yiyBi7yMnEooGzEmwIhzuvodpKTfrKFPsRj6DlZMb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrqqaKNAfZ9Yvk/b40dTa9e48d4cE30MIHGA3WyNk/A=;
 b=oxFoVNPjFjQCVn+CVZy1kUnDYag67q6tl7K0uxqisX0+C9EQG7a2a/9jqGvfbmpfAlCE0yy9FjotWFBRxF4wAWGHlmAIiKBa8VTqZiUtlpezQAEN/sfXUz3RaZ6Nt2IfNezO18vfeoxskjgUnuar4hE5j6yEZnEhsakcVFFrkJr+gMPnQZazF2O9qKYIbMhylBbS3Y17LLtakId6KR3MZM2KlnlfEqNhEupqR18XK4H2iaCegFhk1OpvS4PcrIfBlnrUlAkf95MWDabjx/yvwTaMAzFZEed6Rl2Aq/3wp1qI1Gm3bCdPW2K+BgYprfpe8qcY1+ZPNG95wNHC7chepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrqqaKNAfZ9Yvk/b40dTa9e48d4cE30MIHGA3WyNk/A=;
 b=ZibU6CLlmgu4oUJ+r2/oEisQE3LZf+l1U+jR6yBqDYbrf15ZAmmKqWHvRhCweFjS99cJbbkY4M7H7R3SV3YgQfP7oGaPksinPlzpZr3wM4Yj/uXl6khFnmeF9bi5HVBu+USVk3adyJWrm0ApZ8gujWKxGKaAnWfK8BKHxZL6c+iOt2yog6YHo/8QyuE+WNdX1p/we4VnwUahVrEqzh6CDVzPoUAcvgbomY7g2QEBfx00qfE5cNODSOpb1KliAivJBLHHWNSfaxQy+8jPWB7br8nX0fwL0DnxIdbcbeS46FLz6bY2La0FPyHNym54bSrHHUIJPk/E36vH/6R0LdgZLg==
Received: from BN9PR03CA0447.namprd03.prod.outlook.com (2603:10b6:408:113::32)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 05:06:06 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::e) by BN9PR03CA0447.outlook.office365.com
 (2603:10b6:408:113::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 05:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 05:06:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 4 Aug
 2024 22:05:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V3 2/3] bonding: extract the use of real_device into local variable
Date: Mon, 5 Aug 2024 08:03:56 +0300
Message-ID: <20240805050357.2004888-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240805050357.2004888-1-tariqt@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 7439ea4a-f01e-416e-235f-08dcb50c4f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/mEZnYh/EG9ZuEPtk+qw1ZaDLcJ8orvpukX3DCAfpuG3gqleEOfQM78SnPi?=
 =?us-ascii?Q?Vgv8NbjXGcqD8v+luG7wrT0VNVnAGeR0k8rtBmIVJV8OCd/+mt0ucMPmnitw?=
 =?us-ascii?Q?jVBwNPUepOxsTEsF4kW5Kergt9JvzqpX95JOyoEqbqrQ4E/vUq+U5ixMScQL?=
 =?us-ascii?Q?rM+91U95hMM5v1dCgFtAY0iOE4Qbg/kpek8zHMVIaA3VsWNlL5UuXrqe2LOX?=
 =?us-ascii?Q?ncLyrhs2ppnZG5vQdoxlCZPD2Lin6OQoj07ywWdnNPVkIRQ5KtlAAFmxzINy?=
 =?us-ascii?Q?LItPwOkbThICHPnNLc/3zePCCNydcJzPF2pnj/naAB9fvGcui2P+xFlLSNPi?=
 =?us-ascii?Q?n/37xw6GRaMeNOAMmsx1sT3gph10PDXkgoxUPZWc0QGgYAa11LHoYlgnNcqI?=
 =?us-ascii?Q?MQZiNQqI+zKFiXLSnxt7flBso/9kwIfIjfg6FBeQkwc8dWNSan5Bv6kQPdwl?=
 =?us-ascii?Q?qoE3jQh4QeQMcBJPBHyr3urqEQyCV+pXAuLRgHAUYHwJRiRyG7CGQcqdv3sO?=
 =?us-ascii?Q?xIRQhsV5berBsr4OL6ZssNeHI+1269hLXpYfY/dHIdHdE2mmkj/0c78Zaq6Y?=
 =?us-ascii?Q?8yfCePJN1fKCUnhnn7D6NDrOgLA22aHhfvaahTVWhQdxP8OjD5YYyGXwGaau?=
 =?us-ascii?Q?Cc6oJ4gafuNiGrBVUpXWsqTfxvNJ+cVSCHb3yqbdQ1jrL2syvMuFn/yZS5d9?=
 =?us-ascii?Q?tAusvYclEBFf2ER88ldv+TuwLV654Uh52yJSIe4jv+nWc09xEQWk4wIlnDy5?=
 =?us-ascii?Q?g3hFJ0qC3C1VAqUy237hRVqmZz+spSHKcAhub3lCjgBuarbcyaMrJgatP5+8?=
 =?us-ascii?Q?H2XA/PIQBSKdSUN9awE7g9Z0epLpm/3z7Pc3CbLnfzFepWGhBv3FBBPAjtyL?=
 =?us-ascii?Q?2Acx34rEP0t0nH7wAngPNWUdnOrCNclw5UOQBl9nP6Ulddbo9sWNYPv6ZBZK?=
 =?us-ascii?Q?m/r7xdsg7fHbfZDLcQo2mYffortpwOH3eSCiMO7dVBeeYEY0c0jsHAlVjbCN?=
 =?us-ascii?Q?ZDCvfv0/agtWl+r27tTThfZ7Q6NCXfajzKtBqIFieNAqWj3obfFiMePLu38Y?=
 =?us-ascii?Q?SkbvvbOya1jHHw6isAzdTTD2SY510SZcKDjxSToLkmPcruf3x/6/3ImfogIs?=
 =?us-ascii?Q?r8eOLaCIBkSZMV8PSPTClf19NElgAIsKtKO/ZjiShbGRfEwoUqX5YDlve8S3?=
 =?us-ascii?Q?McyamvgxvLkktmu6syVrQEWP9Qm/47qER6LDBgNy/sxpdzA6VVuNbVwykSTe?=
 =?us-ascii?Q?jSBp+3jaJunXZHaWLDVr8xK+YeAiPyeyNRzebNKbGncMWKG3N3y2rCqhESRc?=
 =?us-ascii?Q?/aSLj9HjN12oqwocBkxvVW5jMe0JhLMcCWDLPq2CiP5BblbgNcEOlnryRqRR?=
 =?us-ascii?Q?O6tsR6c5MkOikdU6inCul3Qogf43t8dmsy5o3KXXi06OgncT9O1JhTwa5O66?=
 =?us-ascii?Q?084kLWVsUK3Qifsd/IAghA7x94F1AL8P?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:06:05.3868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7439ea4a-f01e-416e-235f-08dcb50c4f63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

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
index eb5e43860670..e550b1c08fdb 100644
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


