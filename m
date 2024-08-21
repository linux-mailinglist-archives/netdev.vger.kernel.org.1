Return-Path: <netdev+bounces-120484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB95959866
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F971C208DD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4791C2DD1;
	Wed, 21 Aug 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEFrqtDK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0619ABCB
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231150; cv=fail; b=T9YsSlEote3nnug65EK+GIGajRCJ4Lnv2X0fjYywucfclNXxGZ0fWTtCfeyv25kKkvYLuvwUGnexsbLiv+Wlg8JRqOGW3YQxMfkvocR8HP+7dK6MmsXhISXNXp/8OO+3D9EW0SFv5sGkieBteM0qQ87+NkUuqs0Hdo9igqyWpbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231150; c=relaxed/simple;
	bh=UArijaNlkkZA9WtJPXFEOj5wJP/hMr1zn1x4eQ07aTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uonA/T6lrRJUE1qNQgUuqOHPYRNBi4BydmuD+ZdrN6dE2TCKKec+JtFQEex4eqUgdaIdPKFmCWxzVWRXOXbiJSkp9lLZX+lOXTYs/PaVfzhUuENZdq/bRjDAElNUUFyX8ppsFrM6BxUsjO/43peoNbzyX4iRTAP+WN4FaO+8ba0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HEFrqtDK; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvANjK8o4fbdYt+n6sdSTIkNJ22ObGSe3GwPD9+Rv44FgNM+Rs7prn6qu0jSOPEV8gdX/UI55d4msiFbkInsk5FSIcmEjpmfqqAQp8l7bNO+5dfM7S2MGefPxDtVtQJJ4iHgAmJRDsdOZI0bUIkgxgU6BjEBBFw8wrkiGCB4qrHeEyfYCE7L9+8z/bBc6HSVEDzjm7A1JL2+bsHcHRgEl7CJG64lsLgFr8T7M8A3vm/BlScNFzgsraUxb+VX1SKkOCWJyxe+8xkaIlOxTp2TqhGywm7vomSNgFtVnY1CFFFqMlay8lOcVCCXnTZdpXpLjS3z52eKnDxtoUvzfKf79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54PR9Ilo+GtlMgDbbPMzpb3bt10aWnPez/OQG1ac7Po=;
 b=gl095132AxXqXMVpgiaCQsqFricRpx6yYrt0mLcTiBIRT8ws2KF0nT+d7zrY6CG5kjQqb2kYXIAaXw0BfZWNz0DLAoSyPEOMDlX1dcRV4lqkuYkQdg+C5ThJUsAqEHlOAft7tDD7GlCSZFRVe9jvqKO4TgPk4p/2mYh6Lq9zP4CT6KzRaUOlwT2JT3k6azU/S2DeLddkWx326khp3JaYM6r7bT2zcht54JX3d2I0X9MrerSHQSthSRA659JFEjODZAWcIulZbe4USMgFBWmepseopN9zwDjl5qTjmY9ggoOkCAGatYZ+skGnT1hjKxG7Ae4wrcjB6PqZX7cVQqeq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54PR9Ilo+GtlMgDbbPMzpb3bt10aWnPez/OQG1ac7Po=;
 b=HEFrqtDKQKJSOGolh2gr7yGRREmOOwq2trL0lMYLQCwVP6TNJ4pKGtd856VGhq0j3z+qKwgUnes/dKkFlAWp4OzyO0ESxqyS+q+Seua+nH5r4PWKk+35FsDrDpzF1Agh1EGvyVwMjrmZEkZLVE/62OpkwU/UGTirsuUZdq7PmoeBPzHZrjsxclhBNMPUlqODfJEiEJeGaZwEOCSrNyLJ3YAV/vNcbaUm++UD0cTVpQ4iwdAv0csKgioOuM3U/yZNI2QYh24acaB7SX+rIkPTi9tFiu74XxHeDYf5WvrhH4k/RjYhDfoUWmsPpOhfP77GAV9gCtkpVU5BAwqF/f2FdA==
Received: from CH0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:610:cd::15)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 09:05:41 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:cd:cafe::80) by CH0PR03CA0100.outlook.office365.com
 (2603:10b6:610:cd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 09:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 09:05:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:27 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 Aug 2024 02:05:23 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net V5 2/3] bonding: extract the use of real_device into local variable
Date: Wed, 21 Aug 2024 12:04:57 +0300
Message-ID: <20240821090458.10813-3-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821090458.10813-1-jianbol@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f027989-3a88-4bb1-0e4d-08dcc1c06ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ePQW57S+IhWF8pKvIp6OBTNke+wA9+n47kl64w/zM1qZlhSTOmjU0l0oA1m?=
 =?us-ascii?Q?4gmWRBM2DF1kwKjfySgULu1nLyosXMFDvH+xKGtQMLx8/Hm+22KQppHGycha?=
 =?us-ascii?Q?L+S94h5bcvAbkYKnfuWGWMC3F3pA4hjgrqW/8DYT/lgPef8SCKTTm9MKiroP?=
 =?us-ascii?Q?IstdppBOIkJueU05dSmrq6BSVC9zKjFc/MKAeL8IQMwySksrkObJp5iMqOlD?=
 =?us-ascii?Q?m7F9zYJ401GYFdPTXzo9YARPILObUpdz4A7FduE9qzKByUPjKamsihThWvTj?=
 =?us-ascii?Q?ho0RS2HeVfHZ1lPRVQr434wQ9JBeZLGTextj2srP6yHSzwNcTtk0JXuQ5QLm?=
 =?us-ascii?Q?jNFJvZla+p4Z50C6/CLKfAb0v+jENrm58G0K0J6hgG83axztXQ9PeRLCClI+?=
 =?us-ascii?Q?bEH5gI+aIiU/bsBJd/zARKShPqmsHYNHgdSeGAiD54m/EtL1cokHNNvTw0RH?=
 =?us-ascii?Q?jf1CnecmIydEOlOndOrfNOHyWB0u8Lf6R1EALWvnIkdop+rzt9kJjdDsudEZ?=
 =?us-ascii?Q?KP5jHKuwPszWNWtvWWd2jqP7+ybJnvKW3YKyadIgU8/ipRwB0kqx/in5TDQn?=
 =?us-ascii?Q?csXISJJbS2bdj+zc0FUaeaty/ViK5NCvn2wecqIO4siIRMBQ+Dztdg+HHq3c?=
 =?us-ascii?Q?AebNdK7bXq4P1qZqTe+ovEE45wGLHofOfNOz3ziKchFQbWogAWXdVyNcn3aj?=
 =?us-ascii?Q?FSiykvrclLA93F2Qp0Vp/Qpb0ud8XalECSUFi1bFh7lUcihjt0MgptfoJQQS?=
 =?us-ascii?Q?tFY1zDjDVQ701keEab11NO8agH07VUJu6uXzeIV2GGs++y+iR/S2K34XOroG?=
 =?us-ascii?Q?AwuO0gexy0vbbcMnM+CUFxMivhIlMoF6qtJCLgo2KKd8G/dQXgE2t2gAFKwd?=
 =?us-ascii?Q?lwbVYzVcAEHMApPYTWnOSgi+C5TTwvCMpUxzLX9NS8hVHxC8wND+B4RcC3bc?=
 =?us-ascii?Q?QxXCGIE3aOiyQ1+ngaLWAO459xOipl0kuWvYTy0++OU2EsMiW9XeJX23dYdT?=
 =?us-ascii?Q?NSpslbqX3UFVJS62EvocXOe2r+HmyQ4d8Vf6NRUxNDKzvDeVNAq7hUrepGhC?=
 =?us-ascii?Q?wFU8fjAbYQyvFcyCyLJcBY6troIdYyPM4C+XmzM4mR/BDNrgHfr7DBiJIzdR?=
 =?us-ascii?Q?tlIrRmo5VSnXpi61ahiNcNRvIMFYlMRCTPIACV9WQq1ag67FEIj7zQWB3E83?=
 =?us-ascii?Q?B9wPMts3QMC6tcFERBrPzUPPrOUvm2BTjZLAOL+yh/qKZlMIkX9r/I+HcWlG?=
 =?us-ascii?Q?lAhbk+ilkK7m9+q7dp5QW/OJl5mK6NRo7XdYl2f1YpzzvkWgn1P+vwn6laWm?=
 =?us-ascii?Q?IBkRVHadR78DFWHv55J7KYGsc1Z3e4ly6gDX0LgnydzswQKOxeXtRouUfoDB?=
 =?us-ascii?Q?+5ZSFTzkQPO53NJo+30YluECbrnr9FAnTibOhOQKMhPe9V7KfsEapag/TYRD?=
 =?us-ascii?Q?H9R8xBYN+2lWL7EVVVQIp1Z7QbBG9y5u?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:05:41.5649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f027989-3a88-4bb1-0e4d-08dcc1c06ed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

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
index f191a48c7766..0d1129eaf47b 100644
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


