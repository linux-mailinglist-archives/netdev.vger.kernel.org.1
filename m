Return-Path: <netdev+bounces-213323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693CFB248D1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71931B685BB
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF002F6574;
	Wed, 13 Aug 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WNEC4Dwi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1802F83CC
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085752; cv=fail; b=cSKvF4xzx6E9AuM8VcQLcohpcMiA8YrfitZQjg6lo7mfEreUN+AyUygvUZ5EQyKHVLJyFFoKfz7C/Hqyg9O5yhsbWJ5m9EHjqb/AfwyQ5yvnfRy8BCobyu5igj9kpV6C90o466mIQQkPkKo/c7BRC8BLQQKswjplXKMLF+6MkRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085752; c=relaxed/simple;
	bh=71aIZOEX8HKYmRxVW16jcOnSqRJzg4zxV7qHQ58Kkdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEMcD4Akv6SOxZ/uKq7N2vtV6LbgC1uo3rMksWR2sTH+n+L8Z9w+LuRNtUTa2J0tKeDJx4PDPXcKFZzLLlTFARvCCCKkmZM2zVw0E9Chts4dPg0StAcsJdeMB0qL5LEelsFDVQ3ggvW3MwlLAJmA0ypkz27W8wL5Lv223m2Bw5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WNEC4Dwi; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsosTeNGyEBgihkYjT6ojvG/bJ6JNk8ixMcAWUa/twO2qr8OMfYxJKEjmdb52mWS6OOAAbNo+fbN6QAgyJPcDovrVkSGhBJ1gC5wEq1KG+UPvStg3s3FH4zFpZg/FEHvtIcec/KeAJV7SFUZyHNDusQCa2SYsko0EOMcN6ZyiwNtZY7TIZdwe93OSyod9ZcoYdZaM2cbB0RIwv6tX+tNmDU/qTULrYAQMkR8VxvV9W20tlhOV8gmw59s/kULn+L+PsavicfNuRTLQSNlAsZVK3dNSa7/XGO6n7JuQR9E4MHtYbvd0Ug671h4oOwsGs8kM6YqxQF3umOQm5DU38y9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RpR3J/bON/DP851dAtAwUDl5khivQis9t5DPEZownQ=;
 b=y3+vl5Xz3nwJXemr7y98Cx3gxrKzL57bfr/79YxZxqIFwf4mgC7FWtk+NP65mSYngk506xNS4v9z4sgUWbGT6y4Ok+lP8f86qgb3GNJEviAiRnCsuSmRoJyCL7MVAOizfqO9bVa8Y3Fv0x1n1VwD9oWnKuIhUWI3x6Zo+MKgS3OTF8rM2x7quaj0IyF1bkw2GjVkXbomCTf1iEuR9h3h5mW14RYwEOnzbCYotZrmzc9NxvNfpzmLtyIPuCcgnKMP7qZ6FDZocv8n5R1MrXhZoWZbU4WCMorBPJ3E/6RP0/cxF1Wx15G/Xe2OkqdItLlSAuA5394P3Gi/40ePHiDfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RpR3J/bON/DP851dAtAwUDl5khivQis9t5DPEZownQ=;
 b=WNEC4Dwi/mcWQ1op23YR1+cOeyNX4yntIwsI/Fh1otoMuDpFPY4nlSYjw7syV3VLY3YxMZY9noKf0p6vaRuNxoZFQwK6GO0GOIFwOFB4ENabETmrBc2+E5aKste3ix3UZNpXuKQjGkOCi66GmsThL74q8QaOhDmJaZ7XzsodaUN7uX+qqQRID22nqSRCROkxfSYpWwLLsW8wJX1zf3DrdO3kKMKtIrApskNabwPtIDdJKMbpvBFw0pQDSfT07yoWsBbOmhjF7oID+m0wR0SWKyo1KDC8YQUkE9XM35Lrr5npcVACvIj6mGm0JNRhPud9n1rubV2G+5CScOJgba1raQ==
Received: from BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 11:49:06 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::41) by BLAP220CA0021.outlook.office365.com
 (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Wed,
 13 Aug 2025 11:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:49:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 04:48:50 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 04:48:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<mlxsw@nvidia.com>, Zoey Mertes <zoey@cloudflare.com>
Subject: [PATCH net 1/2] mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
Date: Wed, 13 Aug 2025 13:47:08 +0200
Message-ID: <47fa24543ddcc6a7022444ca7ab8bb194fa7cdae.1755085477.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755085477.git.petrm@nvidia.com>
References: <cover.1755085477.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 759d70e0-c7f8-4327-e7df-08ddda5f6864
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?m5ZFcZPXWWoV8I8G4hd/nSOZmljRd4ABncyZA+ut3QjWW4vGoR0YjAJ8nNEW?=
 =?us-ascii?Q?Ol73Z77tYOjXG+U8vE1UMVSaJsJSuStRyBUz+a3eFRlZgfPaxBF7vhfN4Pmz?=
 =?us-ascii?Q?lO9BUmrk72utqznSiGoOIvrGu9uchEWD/9AB184SLYNkUKbqMOl74RoI9Nzs?=
 =?us-ascii?Q?BN1KYtWoOBj74ccJJibSMYf9dDmi45dvN9OOSmebZj5YcO8nwGJ7+uk1Xa5T?=
 =?us-ascii?Q?Nh7O1cUGpIwzTSF3lG2/4cRDFgShXAf/MavqpGbPi68jqktqPVJuEFYtkG6j?=
 =?us-ascii?Q?S1ohWlx4u5iWUn5MWKNbDp/0dos/8hrQHwrUrHQzWisoRf6dhzHlRXta8rSV?=
 =?us-ascii?Q?vlB7PaBVU+Ku1kie7N2vYlNINFu1NbHSIV50UFnI5FXQNKDEu2NUEo+B9FCS?=
 =?us-ascii?Q?pbIlxdjcE5WPG+qLshnLst+QIsJ9nUbOX6d5SJgNOO44/5JjkAPUB56DXRkL?=
 =?us-ascii?Q?HDTqWfzYrO0cC7+zuT7hXq/ssYLEvoqqDUhGEvsKV8aBICjLDxkyfHNiHy9x?=
 =?us-ascii?Q?ago89rJi0ZedmQoBtA//GWTs26XDnfn02J0VCzPaCvYnLdDg/NIyc3UuWJcw?=
 =?us-ascii?Q?7qcfF524cTaGTZn41LoMOqkSPuW2vzl7Wu0cSX7UKfXttClhcbsHAJ6o3IHB?=
 =?us-ascii?Q?smHhCVHblH9zrZCfGigiiCoZrKhA6H6f+dxoO0f76YA1X/1OX6lPWiAqiof4?=
 =?us-ascii?Q?l5RkJTAQetj/LRD6cGGB2UYt7ZDDR8kypZkmWER8Q06awQaMxcR7Eddn94AF?=
 =?us-ascii?Q?RopooWMOTqMFXW6WuQBgDAXcDF25WgeLNUb5P3MEFhvTy6WMT0nLfiUygsOA?=
 =?us-ascii?Q?w8LNTYY9HojIWNpf2e7cwb7UaOnQSV06I4ohnpZrY9vHbfNNjjRk9hjRZk06?=
 =?us-ascii?Q?82tWrUcJZsr3pvGFXzNmYfMjSCN8opZ8CGcuzkpuCSjn87e9utrvIeWcn2RK?=
 =?us-ascii?Q?fNDKe9dNtyHmpO8Bvu8aY5KZ/YleIkSJQlnFqjr/JY5qpK31iSdI/IG9y3Sd?=
 =?us-ascii?Q?1xAIPGlQIuMIHpS6HcUFyA8YnguE4h0fUeyKRCNN00EWLwSEhXB0N+l5V6z4?=
 =?us-ascii?Q?gkFIu9H4pj0uJC1NTK2ICZ8oYzCTKjLZxg/wnNp0lHPTlIUjcEQMnrygOwFD?=
 =?us-ascii?Q?sZSfHXO0NPBaHW6FlQHGxgXQqpJSwCtgFG8kHy1t4j9W+urGKqOcGpFHjp02?=
 =?us-ascii?Q?EdwGFtN3/Qj87cD3Z3ri2kDAZUz1NXXtW7ndUpw30abFfiOGQX4MXAosh4sL?=
 =?us-ascii?Q?Bzw46GiT5Hur0iNPodKV5Op5MMWUMIR+n4353QqXsxqLHMQ8wHQgMSqLaVb7?=
 =?us-ascii?Q?PdWzynZeoBTZkZtwM43lzyEqLiZqZk0/UknVrfnFolDoQMDWd0YatPYYRvUz?=
 =?us-ascii?Q?o8HCY9XI4f5HOveqBVt7aHvI737yNLfB7BnpgyNLvqtNjUKOVfnEer5A2fml?=
 =?us-ascii?Q?YK2jLW6euL2zUrwfS5uhR+pIsVDO9LzkrsKeJkD25C2enc63RVnI8w9a0Q9l?=
 =?us-ascii?Q?25mFH9lfEusHXhGDv34s4WOy+44ZLmE+btDj?=
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:49:06.2805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759d70e0-c7f8-4327-e7df-08ddda5f6864
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126

From: Ido Schimmel <idosch@nvidia.com>

By default, the device does not forward IPv4 packets with a link-local
source IP (i.e., 169.254.0.0/16). This behavior does not align with the
kernel which does forward them.

Fix by instructing the device to forward such packets instead of
dropping them.

Fixes: ca360db4b825 ("mlxsw: spectrum: Disable DIP_LINK_LOCAL check in hardware pipeline")
Reported-by: Zoey Mertes <zoey@cloudflare.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 ++
 drivers/net/ethernet/mellanox/mlxsw/trap.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 618957d65663..9a2d64a0a858 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2375,6 +2375,8 @@ static const struct mlxsw_listener mlxsw_sp_listener[] = {
 			     ROUTER_EXP, false),
 	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_DIP_LINK_LOCAL, FORWARD,
 			     ROUTER_EXP, false),
+	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_SIP_LINK_LOCAL, FORWARD,
+			     ROUTER_EXP, false),
 	/* Multicast Router Traps */
 	MLXSW_SP_RXL_MARK(ACL1, TRAP_TO_CPU, MULTICAST, false),
 	MLXSW_SP_RXL_L3_MARK(ACL2, TRAP_TO_CPU, MULTICAST, false),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/trap.h b/drivers/net/ethernet/mellanox/mlxsw/trap.h
index 80ee5c4825dc..9962dc157901 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/trap.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/trap.h
@@ -94,6 +94,7 @@ enum {
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_SIP_BC = 0x16A,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_DIP_LOCAL_NET = 0x16B,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_DIP_LINK_LOCAL = 0x16C,
+	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_SIP_LINK_LOCAL = 0x16D,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_IRIF_EN = 0x178,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_ERIF_EN = 0x179,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_LPM4 = 0x17B,
-- 
2.49.0


