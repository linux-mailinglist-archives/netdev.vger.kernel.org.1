Return-Path: <netdev+bounces-118857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60895342E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DD628A10D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719FF19FA9D;
	Thu, 15 Aug 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ut3J93oI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CE1ABEBB
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731791; cv=fail; b=qaFU7rbf0DqldgbTIm06D9KTkqBpal4u1W4es4ljs5Bm7LgIMLGeHLUcIogeFMu47XE6mIzGQdLmQE1BVByeJaCkk0mrKUGYu9C4e8pzD7zbW7YwGu1KZloLa/s0EWkBdsMJDCWw3FVW9PhkW2MAcvvpV3U0DA2YkwZPhpze82o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731791; c=relaxed/simple;
	bh=zWCHMdFBoMCzZmLhYJuL1RHS6S/vaxpeAOhB+eZN9H0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5Y/Irh2s+pNWxc2dwrUppGzF0XDhbmgX+VpTvJmGTn2bH1TnDAzDgXfW97gSS0oyTmRwWguxLfULmKjaAUYsEewxsydSDcwsvUSeCJS5HvJfxWXJ206S2OH6fSxprYSlTcV1E2r70sA0yxPj3hdyRVQTckCRxnCDskHNnrrPcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ut3J93oI; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKwE7ZuNXhs6pphqe/IOp+Zdq4NOMhIrho+nvEqgmE5ifaZaq5KnSXHTXJMHFm76zRPmPwjO8yNCx7Vg4uHNVVYVJ5CiWYESpMRWbJrcxzDcsPlJp6u7rziqJ4hC1AD4bC5/e6N5hs2utuxX2fdlmc6en9eEe0f8PPqmS1vNNiJpyFpZVZy0Q3COrlTIL2qasEn3QCjIo6g1Qz3tmfVA3iOSYvtcYd0Wvlmp3DjIzf2EQqNDvhfz8YBidYFS6yN13sFCC0mUTcvoIRMZEzbFSeF+iinREermdXsRibCPUVM9k5gEkKqCC2JhzxPZwGiapH4sY6sqIXxh4uVKH1VE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnya978e8JwPPBVM9L084/LJxSE38jwMOEF6C/6WvIk=;
 b=StZmLqdP7CyjP0qNjcfcs/A1dCqwGxSmsllt9RXIxsOTJbKlJtWLoaDI1XGTfC9aY+SG8KYCsl8VuPZlzM+G+5GLO+yLlorquxNsXvmIJ8JlhPaRRgPEyrYDNd1pFJmvLu5CCzcT3x2cBthpPY1iWYA9MXQAmhZxnhb24r1lr/EWjTACSB0A7VntbemZgF9T2OkwSbPb9LA3rY2oMtpId2vsIiCmvbTRLcu5hGJPISOayMH4Y7wwD/POYwQPUgk9iNFTDKCaV6Ke5tW/rY97Ygu/dBPzAYzVnULBkzdR6QtSWaXHtS+mH6vLlegMAub1dC5NfDsKsi5UK1s09U8Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnya978e8JwPPBVM9L084/LJxSE38jwMOEF6C/6WvIk=;
 b=ut3J93oIzJ2+A15CNFKf8OrGF+gQUmoWeXKtsPz9aqMvDHdi/O3lShLh6zR+088D3QzyRxXqfh64SBgrhCXDU+BiUdYUPghThUbvrjHgGqHH2u+6I9QwbsKBynyPRENx+8q+ZA5+s3dmv0g4MuUDnggA+Sge3OJnUO80gxXfrYAzyByLTFdn/d771gUoL9WVwFRzh1uVXv14/kO0b/UsUeSg2C7Aujz9NWCbsDveNMEwlU22eIcAxlU6GURUFud2WWOHXeqRtBbKOt4IBzbEzCPoKSV1zqSH15OMSy9fUdGUG6Dq+PfleiHr1LTCiBt4pCjpRNg4sDQg0VTOWhFOGQ==
Received: from BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 15 Aug
 2024 14:23:05 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c3::4) by BL1PR13CA0445.outlook.office365.com
 (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 14:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 14:23:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 07:22:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V4 2/3] bonding: extract the use of real_device into local variable
Date: Thu, 15 Aug 2024 17:21:02 +0300
Message-ID: <20240815142103.2253886-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815142103.2253886-1-tariqt@nvidia.com>
References: <20240815142103.2253886-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1291002c-313e-4bc9-8b71-08dcbd35c6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXv4CU6XzRAV1Ss20W7DK6nFy47qK27tFBBDQujKJ8Ss10532e9YRPKIq/F4?=
 =?us-ascii?Q?+q/01KHPOo4Jlq9/jGRmDpUUoCyB7svLw+vjq4QFxq1lsQvG/ky018nCu1cJ?=
 =?us-ascii?Q?JyF3jSH4UUEIJuSmpha/tv9pPO3/88/3MwwKX/fEaDIr3E98p42F8o3KIRXx?=
 =?us-ascii?Q?yDIoByJtL6R8fH94ZfSGamc0yB3rn5htLrs3gZJiBi7S7dHLGHQSZidoMQTq?=
 =?us-ascii?Q?hTiseA5ASsfecnhWt865ugNCCVww/gWWW6DgvqWc20etF57sqI33FgqRShMp?=
 =?us-ascii?Q?Ao84WHSd+A55QgYKD7CtWrzysDkzXayZjmvEnnUcgHhnNKZaGnS2aBISOkSR?=
 =?us-ascii?Q?8Ut74iPxv/QNYGgKLBDdVCbLwuUys4s/PgrZTKZ0CXZp9+cAXWW/b8M9pRYt?=
 =?us-ascii?Q?c0mK7JwOo8woKi8pVYMw4opBYj0YD/dWqCbNfKwHV74sQ875upd4mhspUOoB?=
 =?us-ascii?Q?auXrG9zqk14zGV/f5up1oXrInL2xN2QI+RrWhdzYGuwFHRqwVJyQyAkQ7LP9?=
 =?us-ascii?Q?jT8Z3jOOU8o+Vx3y5TtrF3N8bC/IOIqJX5B4LSKaGeNvdPCwdXaXKuY+/FWy?=
 =?us-ascii?Q?w2JK0NY2lDMiODw2ouf0RkMY3Piz66ERmRjDW2Whs0hnK8CO7Pwtbxw2ksbd?=
 =?us-ascii?Q?WYXYBIlOnV9ieouMJCJQimtj4pU7rQ08nZQA4s4B4XxVF6Y6HOonrbVlNCoz?=
 =?us-ascii?Q?EuQJSiP5oL6abQ1tjnfwkGtzPjLZB8L4DlUsTf3E6/AUTI8SqdYYgDK4TuS2?=
 =?us-ascii?Q?4vV33rEYDvWp5jZzcjP3oG3s8BoEqJqVPQpNdGrParBDIs+Zq6UvPa3bZXNn?=
 =?us-ascii?Q?558wxuHYd+hakj0tCjkBgwRVqoO25IEJtukSX/l4CVxh9NxF0/TISl8QyGxk?=
 =?us-ascii?Q?VOSlQtWoxfVZCvYsP2j35B1rMvQK1UUvZtjTEGdN0yusaz8svPGv5liIfPjG?=
 =?us-ascii?Q?S40cAwo+PQhP1qcDDSDSHdeTp1uN/brnevLLiSdQoA+fb6Jl1uZ2V/JEZ0tr?=
 =?us-ascii?Q?afJEIUHb+Q+RxmSfOpPzL14V4NWlDASZq/ztY5W7qFyCevMK8fmSY2ATqmCt?=
 =?us-ascii?Q?hduaNWR3bYkscg3w0fEfEYDBeHsG+rHnXSEoUZGFka+/mSVydsFhijuPa+HI?=
 =?us-ascii?Q?GgRKQMl34gUfh2N6S/tiLxYmkbODXIBMbnLsioY7OKhtdVgkVq4JJKCFmrmN?=
 =?us-ascii?Q?pX+zcZ1g4oLlA0z5Nsuy6uy2daiQFMMKa69T09ZoCpf2/qNLiAhgrXM6jNQ7?=
 =?us-ascii?Q?KYfvSFCy151QKvs7WcCnGc3jEp7RRLdYmXTIHFf86yS2tTUONofE1PBbnS8k?=
 =?us-ascii?Q?P0pxdynB2w9OIiI94D0hvwsbcTMVlInyCwZ1J0YX8wPn8PoeqSzin9LKQMl6?=
 =?us-ascii?Q?XQ6o9TPu5TZZyeLyyWGhWF79ICW3r4Zf/3/iUpPWPidaR9xbAWv1dZFno8Px?=
 =?us-ascii?Q?gbeN76EWeFnaYjg9XIpqn55vIuHGrqcK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:23:04.3765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1291002c-313e-4bc9-8b71-08dcbd35c6ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

From: Jianbo Liu <jianbol@nvidia.com>

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


