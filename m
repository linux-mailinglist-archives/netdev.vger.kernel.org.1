Return-Path: <netdev+bounces-113639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4427593F5C9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C881F23EDE
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E227148848;
	Mon, 29 Jul 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rc9P7Ly+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BE146D6D
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257157; cv=fail; b=tavgnHgT1U7Vjis0dFLhS8kF4T2631oTFZy9IGUayZdmJ7lXuGs+MPwdmKRAPefsWyVP1c+HfWDCPKfNfq14mzbEcKXGRMrBMVrQAmiSN4Xnx02mtvx5r7ZrL93O+zBfZz9Gm55UX9TLrUcCcLVA6aSk1YCbagej+sVSAHiM1EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257157; c=relaxed/simple;
	bh=leC1XJZVPdo0cVoilOITy1hjaFpd18fahP3k1OHecvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gvnc51xvjMwDSjcsyDm9EiHkG6Y3EcnKJg+LkQ5T2yboRwkGHbBGUOHwytzYFVji9xjfPdI18S3Ok2fwcCd7OmUY6rkTdPtcSVZJ6N5xIx4nQxzUhF9PepHRClfdO36hPjQulQkbltgMgQlpXkI5SyHitPPf8I4hm9UAJs5EqEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rc9P7Ly+; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNieJLBijaUmS/eptEAzcl2mW1og0yR+1+hy4q9XLgg/BTt5bPTDlcpwfwphQVo6zqFp3LqMXNCRf0uMF0bOGiFfuved8eMtafrKUxadJzh3leG3lVJ6dTGQfpc94/SYJvMaR9/5eJ8dPDO3nmiPflqzTUU5Lld8vQTCMyaPk4jWJ5vnp6YzaJCTZkqcFt2pPI9xw752gDAgfj+D1T5P7Ry/Sw+qdwOuH/Zc8mYzHTW/9CSQe3t8g3AYbCXD3qnhcFCGlcEk2a5IvBoNcuM/HkJEYK3XczMqLnTLCwD65UZ7yTg2S2cDpQZ4cUjiMtdBSgRqdwZ8cvkBiL180OKGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGNds7oya0lHxMQcqk+74XviBd+fbe1EQ/rs3cKyYEo=;
 b=ty+fhPpovPj01hGJ8Bk038qMUGW9IBLsN7GM7+Ae7iWAfIT7t/UH+eGBuLReafSrYIbliFinNS7joftd+FIdhFZgehMbbMbMVfNBDVFoH2P+1C4AVTjIMl++2A+L1jXthiRE9zMJYPs33NkN5+aGV6zPUdmme8Rk3XP34sqwfjnTXknxhAYOBtLd7UStTKDmhHBJQoaPTeIzxmUVMPtqYJWiGQUOF+d37E149qYsAlB4ebMdSx6Y1fCGM5R/cOf5sbBVwDBLOS9VtZCJQNvJP8v5Fj9sRMp6CN6iDxoCcpTsi0ceQrGc8OhENkmhAvOe/Jh9I9HPYRy5p3AUj6E4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGNds7oya0lHxMQcqk+74XviBd+fbe1EQ/rs3cKyYEo=;
 b=rc9P7Ly+3V10Nfh/KzxDrv219IOh7KBIMmJTbI1puQjy2kdlp/l7UXuQAg1LjhrtFfaUS65uraVn99J/7TYXFzMKk04rWYbFulvkbpQf7aEXIgQ2+XrNnl6elTk+nNWXiabzvHgdA8Z2yCgMt145PUBi/GbrjSFO8t4QrfOJo1Ahxpmh5/xcxldlCRuYzpoBsG25xQ0F2Acog32Gf51JJ4LcTU8yqQaNQQkAmMtKFRp6Y/CmIbMpTO1XSSmiJNgAvbX3dknIGqt+aoDco1njj3Rnp6CHUFh6w7ClmTGTq0hrZpPtcahXR20QzUQTY4XibwRCm1LlG/fXk3uI8U9zLA==
Received: from SA9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::25)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 12:45:51 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::ed) by SA9P223CA0020.outlook.office365.com
 (2603:10b6:806:26::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 12:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 12:45:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 05:45:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/4] bonding: extract the use of real_device into local variable
Date: Mon, 29 Jul 2024 15:44:04 +0300
Message-ID: <20240729124406.1824592-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729124406.1824592-1-tariqt@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc4ea4d-6cd2-4284-2fdc-08dcafcc60fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?309NqObb7VRCtdSdaGbePtj8Mdr8Ty7HIPZtiG08yLOEJoSZOJqTXYMn3scQ?=
 =?us-ascii?Q?WSmETL/gipAazlCTHY8nT0YyVJeiDQjqs8EAlO1DblhlPUjHuKj5Y9Ggj6zm?=
 =?us-ascii?Q?A1g7w1ySyds+t3wY7WNtU+LmKGoSpmTQbnYctre4RwQo9dY3kXiQVktkxPUo?=
 =?us-ascii?Q?UMfVxSHflDeW/PMHzoHxh4xVc3orMZsFTGZGwacrTQ/hQf84qS98ZD6NxMQn?=
 =?us-ascii?Q?WRoCscIQ7O0/BgJnRfnErY1a3W/Ipv+i8h6OdBShEu9ajECS9KZvxGRiK4Nd?=
 =?us-ascii?Q?p6SBIaZnplRlpAISW6kgnQIls7EF+E7sjDezC62fdFKYbHxVb5zuTSNdAjNK?=
 =?us-ascii?Q?yzAUo22CpSOr18YEc6LkZiCO/htH8pmkBQqMNHbqaphWNDVqpFDHTYBartzk?=
 =?us-ascii?Q?aC8HYgiprJpkTeWcGjdFF9Xx6SsycJSHkq/ldim55fAsJPJXwqU3Jajanl7z?=
 =?us-ascii?Q?DoHtKTk7v172WXLpM/VhXCs0BKTuFQraDxajPBvQ2dRdNg6uf9dj30XqL2aU?=
 =?us-ascii?Q?hq1097PZymn7nDm3xRHA1M++qLZpl136whs1vNkswpM/OxbcYZ9LyOE0pnlX?=
 =?us-ascii?Q?TmhR2Fk4Wg/Ul7gM/5wZmMf91YiGhtOMeXUFJOalyYeqvNgmdTbzBifSGCpr?=
 =?us-ascii?Q?hmW1Xw5p3EvnuTLlAoj4WnbN39GLinnIN0HZ+YOVsXYr0WduMl39+StTO++L?=
 =?us-ascii?Q?fw0tYBgEQk3JViZGrKajozS0We49W5lS0QHPrJfjeesVa44zm6qRg+1b/CJP?=
 =?us-ascii?Q?lcDYu3x/yxk7+lyTHn8kt5bDQ3wBLWYnTuIzvKMH3GubGBjwodO6Mp4uu9gK?=
 =?us-ascii?Q?RQowClL++GlTuvHnY6CCQVlKKP8ceFOjlE1p73ig3A1795lNMMwndpk93+1w?=
 =?us-ascii?Q?/SLNsz/PlPeXc09DgQ5RC4o74y4mXgUy7M4AjK+wDLdrYm69fCCAZsbRfG0t?=
 =?us-ascii?Q?gwnYVTgeto6A/zJ7glY1L7XIvaxpVvvOThBj22GE5orZFLFEZsPKJsnkGLsB?=
 =?us-ascii?Q?KABZSkTrN5ne0b43n3WH4NigvgngfJy2XtrDA9ObJG2zw+tjcKQl/dVYFkM9?=
 =?us-ascii?Q?rK0iHCHfbwEnOs7IBhFMY7QbEb5CnmZrIE12h5v5EwyDSScYh6EH/eMpaHpd?=
 =?us-ascii?Q?6en3AeJVYRUeXuCfcuCCcKDl3UozTgQI6j7nxmNVMqV+MdEeYlOpUJ34z4of?=
 =?us-ascii?Q?XiZFHP1mePODJ24+a4fzT2HMgQz/QEm+PXDF2hWavVWVu4ynzx2jROmy71xX?=
 =?us-ascii?Q?1owHTpR/fImfU3BrTE5dGRY2hTy6wijbY0qioH/9CJrqqhE0NDQa6xTCI7c7?=
 =?us-ascii?Q?4CeXL1UuYG9XvA+lrAhN4gBxTyuDxwKVCpuIgCkC+rluUDPxCvWfabTFM+ee?=
 =?us-ascii?Q?Cu32Xm6jIG6L92+1/ZXEwW+KMPFucwawd9gz5aqB6h2c2bdR88qE+bt7lD80?=
 =?us-ascii?Q?2YVks/4Whgf0sG60jTGDHIdreCZfveeY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:45:51.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc4ea4d-6cd2-4284-2fdc-08dcafcc60fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

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
index 551cebfa3261..763d807be311 100644
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


