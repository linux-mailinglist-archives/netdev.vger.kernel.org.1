Return-Path: <netdev+bounces-233060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C90C0BB10
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 453B934953E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9D2D239A;
	Mon, 27 Oct 2025 02:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VKwu3R5L"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686716D9C2
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761532736; cv=fail; b=Jp0xanFEWg3RNHMpxrUsIUYbyKUt9zKPPcfckM0NEyz338ULz6i/A6sCE6FDDTWCiv5nn9SpJ5hWMZTfSXB1iwCINX/70L2vMGPv4sVfYFQXEXq2RB7zZMbXprGzkwWU6okmpnc7XUWxhL4z0GfhacR39pP9+fy8/NTVl/S6olU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761532736; c=relaxed/simple;
	bh=fp6hLdv3s3g8KQ8VM9S9TR8dHGqyeb792tRLTl7007s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UVy0SfpVSO3VmxMGBIooJZEOCNft2r3h5RsZDDvfALQ8xBBZAsCD7ui8ttfNTm71fohCc/HYmzJcX7Z+Fykr3VS6hQBkPdWXNPAxowmYYIta9k5VQFLv3uqBMqsh/MEVvzMCcrjQ728wsN+JFLOIyLOmkSqVtCH/LPKb371kvgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VKwu3R5L; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxomHkZ36IuH9y061YJzEdEIOnBcAgrv+CSmX2392EOPuaw3yRSNV1xdGwFqxWzX3931LFtZiU60vuhAX02UHzYCY2ZJgn+KpW8FamEuQ2VRHiHI4WeGhDHiuc9nEXrl+8GskPkCJxwqtqGhPVkSir8zlEs6I8j80FFd4Xd3jHWpEHkn0mhoy0QvzTuZukwXv+6KOIYgCjpA6v9ViurdenIaS1p9DwmB7bE6hxoK7Hq4/M/UgBqeOWTpcDeD9D6hwTLZLrD8IsJMg+nmowm4Fb7K4r37t9AcCt7rgHbyJy+JxuhYEm4gDeGeFBsF7wVG6hQDgbbuqltMRVu2i3NR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwjxhb/OppNOkzh6rTGeD9Nm5HlFaP07p209ERcg+Ao=;
 b=jGhXzFZBg0BJWTyzLkbMkuZd1IU3nndGH+tzeR3pDorcHs9Ta/fQHwi8PKYc13xV5gDRsAqKHcpdt0BNVuTIvB1ij/33y1wUPLvDMckU/5PMD3o27Dj3o4WNasaOxnhrTTRXU9cB9913ipCFNcIlVhqgOvZ/1RsaxmmzxS5O6Y0wUYaPw5pZuXb51910He59k4O2GAV+l66HagZVXRY3oGqDK4adFnZioB3Jkb8tjERrLkHKYreUD0YPR0S7vFCIzUTfjdF5wZsViWRJ2UQE2bpTHJW3yHsrdWQHcjrFC1Mw9R+rfPu9eVtpnWjIGNDq1BfT1hU0WKUjXyGLAhRvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwjxhb/OppNOkzh6rTGeD9Nm5HlFaP07p209ERcg+Ao=;
 b=VKwu3R5LY0SoIfOgrWOcL7FrR2nvJuS9U+FdTwU9K+bhdvIeOKOTv4we4G/WIfHtodAXpXdi0znGeJlcyaQX5PUgCfskkRYJLLnlNx4kz6qAoSImZa/4DLxaMxTJY54Cs5LeiP+xx5ZwRvKi20CejdIIIQJpsUYC4laSLOTemBCatbkCKXI/p6FNueSEa1KXxPtVMpwb5jbrKK7rNAON/u9nnll1PIn60adNLpqcFcCdvQSf3a1XCN5WhW5jmFASGvpac72tlnzTWVWg9RPTQjw1Ks5cl3xopHVC78ugTAq8uE9m+hkJoQHR8Y6rkVXpCq6pSgSUukiimOasSSpjvw==
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Mon, 27 Oct
 2025 02:38:49 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::87) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 02:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 02:38:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 26 Oct
 2025 19:38:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 19:38:32 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Oct 2025 19:38:29 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: [PATCH ipsec-next v2] xfrm: Remove redundant state inner mode check
Date: Mon, 27 Oct 2025 04:34:21 +0200
Message-ID: <20251027023818.46446-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 441b3384-3fa0-4963-6f0e-08de1501f53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5m1I65YDcW9FXWcapbWRQlsfgV2HT0NJVT13I/Vn6WqAYv5JJfaLbTy221n2?=
 =?us-ascii?Q?l5Abc8W4kl7VMbetordviPrAPYZ3P/HlQzVtd5logQena/N8yGEwnz50OhlK?=
 =?us-ascii?Q?UjIhpXupG04DZ8fBq9CqxIS0TTVjJSfzDvlyshk98sbtoKWwftVoCdqRG/Iq?=
 =?us-ascii?Q?rgZvGoF374Z8HXbQkkE7vS6F0vL2OiEVs4whUy5rDtTYwRcaJiSwwcgfOT31?=
 =?us-ascii?Q?iCS+htDg6lwThA1ONOOdZA5rml8PG+XQPrMIqTQML4V4pakh/zWflT6fRzEK?=
 =?us-ascii?Q?1MTXHtRjnTOda+lke68KxxSFTIYNrdYY2ojejMIXQHgftDE0OTTMWibsoPko?=
 =?us-ascii?Q?pyxr3GMp+uKoxOUlseuLUPJJtQRsdgLBjPzQoiRxVWhJ6CrSlfpezLAR8/YX?=
 =?us-ascii?Q?3mN5ZY8mMApDD1e4k+l4shz4YUchD5UdIckQzN0vdAB9KOO29JyCI5JS5wT3?=
 =?us-ascii?Q?ps9Q8X1nOLK7rtkVeJ3iES2V9TSYzorRJHGKtb/hpZzHeqbDdRJrssIZjKRs?=
 =?us-ascii?Q?509mIi9Nyt0G7cHAqifuxmZbcVpK+zGTtljl8y4qj1AMwbBOK66n+tHBC57N?=
 =?us-ascii?Q?Y5B7ZLsk8TJaTAWeKBXHcDoA7Fm25G2irkKZxWIiN9IlcWje37SUSikBCZey?=
 =?us-ascii?Q?XhQuuB2lwjatbtaJ0f6bWf8SI9u8gc6DETtC1uXzNbiep3lhin4QQyCX0M11?=
 =?us-ascii?Q?qDUUI6STVxa8X31Z999yFsPYdac4MK1akxo3DRZSG8xDl6wOW+6OhdbKUafg?=
 =?us-ascii?Q?DqguJy0t8OOJs3xYLqFPVBQNxwejtfQzln0QyRpJfXXxnSB+/gO1QBday1h3?=
 =?us-ascii?Q?cyTehO9PjWWsKOe9IE0hh65ZkrlZ1JkAI3ArxZp4FC67G/XFGzYnRP8iYGgh?=
 =?us-ascii?Q?4Rg6J3fyIZTHFyEt2CavwP3ZNaNegr2zoKgn9zhbc0WnU2VOEtZLu3DPU7R8?=
 =?us-ascii?Q?JKXAioPUXINxoeTmqVtdglWw+h1MvBlHwoLlHC7Ydcd2DyToDXRGQFuJlSn1?=
 =?us-ascii?Q?7sX+9j9lBeZepJA5wGvqQeNFnL6p7YLRvejyIexu5GuTLdT78r25vSE2YkIk?=
 =?us-ascii?Q?lux9kL0CMBLK4Ko9wmr78roIlFcT5aW2HMWq+0yKqFgha2DRCYkfNni2rH83?=
 =?us-ascii?Q?+yrndQ0Sjo2fi6VbWJh/8k21/ikaqR2V3W4s2fxIgpcdrKY2fKdJUWazyy1t?=
 =?us-ascii?Q?Gx1w6ASDl1exvq8nyDkrYHsMLBLqvBHaGqmukhFnoUvAsECL31NUyhBpCkGJ?=
 =?us-ascii?Q?YN23U4SgUL3zy/4/Em0dq9rsw5x5dIJ6uo0sxmzST7bAuOdkzCMSeJ2g++o1?=
 =?us-ascii?Q?h/lxpnryayKFSLosQpKHfaRSJp0u4NdcW9zfydnLgKLO5i2gUiWMp7CCr0NO?=
 =?us-ascii?Q?voCHcl44zziu6Mt36Lom1KXGxQhfGM9n3r86/azvkpa2IL1z+drDiQPzwsKa?=
 =?us-ascii?Q?62HeCrRvm8bLnVmPg54RAF4ny9/EtTcEDn4DpRfZbCetOab1kAym4an6yEzE?=
 =?us-ascii?Q?eINFCeLIJYHSl7pOIAiDx6YT7DJjsaedls0BvWrryE3h6yxjHlPdQE7cvEVq?=
 =?us-ascii?Q?1VyPqFke2nvzVXerfs4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:38:48.5387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441b3384-3fa0-4963-6f0e-08de1501f53e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

This check is redundant because xfrm_ip2inner_mode no longer returns
NULL, because of the change in commit c9500d7b7de8 ("xfrm: store
xfrm_mode directly, not its address").

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
V2:
 - Change subject prefix, and send sperately to "ipsec-next".

 net/ipv4/ip_vti.c              | 8 +-------
 net/ipv6/ip6_vti.c             | 8 +-------
 net/xfrm/xfrm_interface_core.c | 8 +-------
 net/xfrm/xfrm_policy.c         | 9 ++-------
 4 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..91e889965918 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -120,14 +120,8 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 
 	inner_mode = &x->inner_mode;
 
-	if (x->sel.family == AF_UNSPEC) {
+	if (x->sel.family == AF_UNSPEC)
 		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-		if (inner_mode == NULL) {
-			XFRM_INC_STATS(dev_net(skb->dev),
-				       LINUX_MIB_XFRMINSTATEMODEERROR);
-			return -EINVAL;
-		}
-	}
 
 	family = inner_mode->family;
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..67030918279c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -364,14 +364,8 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 
 	inner_mode = &x->inner_mode;
 
-	if (x->sel.family == AF_UNSPEC) {
+	if (x->sel.family == AF_UNSPEC)
 		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-		if (inner_mode == NULL) {
-			XFRM_INC_STATS(dev_net(skb->dev),
-				       LINUX_MIB_XFRMINSTATEMODEERROR);
-			return -EINVAL;
-		}
-	}
 
 	family = inner_mode->family;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..7084c7e6cf7a 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -389,14 +389,8 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 	if (xnet) {
 		inner_mode = &x->inner_mode;
 
-		if (x->sel.family == AF_UNSPEC) {
+		if (x->sel.family == AF_UNSPEC)
 			inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-			if (inner_mode == NULL) {
-				XFRM_INC_STATS(dev_net(skb->dev),
-					       LINUX_MIB_XFRMINSTATEMODEERROR);
-				return -EINVAL;
-			}
-		}
 
 		if (!xfrm_policy_check(NULL, XFRM_POLICY_IN, skb,
 				       inner_mode->family))
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..a1d995db6293 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2711,15 +2711,10 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 			 */
 			xfrm_dst_set_child(xdst_prev, &xdst->u.dst);
 
-		if (xfrm[i]->sel.family == AF_UNSPEC) {
+		if (xfrm[i]->sel.family == AF_UNSPEC)
 			inner_mode = xfrm_ip2inner_mode(xfrm[i],
 							xfrm_af2proto(family));
-			if (!inner_mode) {
-				err = -EAFNOSUPPORT;
-				dst_release(dst);
-				goto put_states;
-			}
-		} else
+		else
 			inner_mode = &xfrm[i]->inner_mode;
 
 		xdst->route = dst;
-- 
2.49.0


