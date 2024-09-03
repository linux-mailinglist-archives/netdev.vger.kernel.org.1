Return-Path: <netdev+bounces-124551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF208969F7D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B98D1F23B93
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A188489;
	Tue,  3 Sep 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQx5/cLe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABD4AEE9
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371676; cv=fail; b=ChZzYLYYFDYfaszEmifftk3zX5JlNVJjND4NqdAI+4wW9z1KIPXci7NYsZtNUJbfH+yQLvyETTGP0Z8Z+Twh8uXZI4uvxtYsPac0+48KGeYf1xICzPlPOk9/PvsMUC5K1u0JdfyagM8fdMRJZ7P0NdrbqnEz8hMwnWUuhpOIIbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371676; c=relaxed/simple;
	bh=zeVDw167jHDxBK+f+SdqP/pqibi4B1FA/bGiMTKZYIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StAyK+8N2gwQ1YOdMqkR5TgKoG7QG9EJYSKRKDX9j2B2jvRPJxZv6NBIg710bDrB1xn4A4HwBp7xdcl0TWPk9QEi8c613WVquD99qhFVRH+1y3rGxTjsUWBoTGhqvopQp47cOKSVxSMqG7fYE5XlEOO5hfNMCZc4lRvnUDN684E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQx5/cLe; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHM9n61X8pDgvvSIphziK8zPYUgUPUGeByu5NRZL4CfDCBD35fPpiq0/OeURbAk/K44fTcR//1ikufkG+onFNYTMrxdOUO3RK91G7KkqkcwUBOXrJJLdx3jGm8trWyxuqcU/3Ezz65hgYG4u1I3Vl3Mp2a57iADtQnbRC4i+Q1L+Bc1ZyyrEVqfalS+5qwI3KZZjACNA068xzJ5KfH6I0HhsXb0gJzHW70ZUPs2bLYjS517A26GoPPyECmuq4LQnIDv0fsC54armtVVMdMRbfpNtDVeEO5j4lNuiSPyC32bxcS9SouTv1t39hudgyKrbcclfUCPcay0NNsOCzGFmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MP4wW4Inim7GH89ZTQg/X2a8EFxFOyKhb9HkbnXz8Y=;
 b=olwv436cdWcB7Ob7WatmZLk5QmoYVr5w4YZMrO4srfP2GIj4RcOoyS8FyP03xLsoIhSCpmyp9sj0MEkZkZugPDS98aVBaCpyE27VMzDvpa07iX5/RXAbgUWqfVs11/A+BN+UCHz/RYfi32RwdXh8dikfAAnxsfgyS0rRDblKaZKD9g5Z09D1pqxJ6/mHta7qy0KpHk/rrJ6t31x7PBYN4CftOh4w/Gckee3GGS+N+3PMvDfvtghKRH59MycsJb1yBZBwmi8QdzILlWQGzXw+wR5369bTkersxzNehaBpqlWBg+KuNnUC73g2luYEd5nPqR0ZNGjcsPJzhSKDFRLkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MP4wW4Inim7GH89ZTQg/X2a8EFxFOyKhb9HkbnXz8Y=;
 b=tQx5/cLekI/WS6iCwWh75VE5Jm7NfG81EEdnAPAV0cE/nOEgRiVo85dACDX0U/4ywihO+tm2wb1MYJfpq8lkN7uZzFcDQzJPtLGNKoJeGmD6iyH6wVh9YhH5iZWzl9aPzGunrReyqgoDXsOAyfylSvX6RH+xvLQUthkMhJPv3Z7NNpBacMrEZ/kqq385UVm8Lt0uV8Xn2U65jGqYX1ow/kZw71ijBUWp0ZW+eJsFEn4UBU7WAKlClBuJhQIx/mLoZ1BSSRXGomA1vZPCkh+RkVMo1IIx7qIZv6STxvbnmlkKIPLbjVNo394KjCW6aL6xEPIYEIUJzr8Eig+sabhQTQ==
Received: from CH5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610:1f0::16)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:54:28 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::d8) by CH5PR05CA0003.outlook.office365.com
 (2603:10b6:610:1f0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Tue, 3 Sep 2024 13:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 13:54:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:18 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:13 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 3/4] ip6_tunnel: Unmask upper DSCP bits in ip4ip6_err()
Date: Tue, 3 Sep 2024 16:53:26 +0300
Message-ID: <20240903135327.2810535-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903135327.2810535-1-idosch@nvidia.com>
References: <20240903135327.2810535-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c44bca8-1efa-4017-1ba5-08dccc1fede9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2rt6oiz8Ym/Rb45qAB6UwrNbm9rlSkHeX6JHXPwFKR5MD1awpJUp2kvr0Lr?=
 =?us-ascii?Q?2iETpkfDTYTcY/m0dsZ+9TBFSqqfJB1fOaxZqU4AYvZ01aP6RZMzwhxO+1/s?=
 =?us-ascii?Q?1wYrga3w6NgOIZGd9IKm/pHESQR1kfiI4hvmVUfpQx5r2DIhHiRp01GBn94x?=
 =?us-ascii?Q?vlbiQVttMayDtXpTZjv8MHKnBFTWqck1vLXbk6laZR+w+ZbAPUp7kmqmiLAa?=
 =?us-ascii?Q?Mh7kFKPZ/hfx0H7Ww+ahOpmRGOG/d5oBcJEnL4ttIOaj0JJjyDRKGwo6hWST?=
 =?us-ascii?Q?+ZoKKLP8o7KVIrTn3XvumG/t4e0gZANUCeNHhY5daSkQ6IDb8xj6ENiwIaEO?=
 =?us-ascii?Q?+EOlrmfUslpDtHHtZdP6IkhhDwNcRKtl2rCJ9NULt4Hl/g/uU+OvVyFaBz42?=
 =?us-ascii?Q?ahvlJRIxfVQEeWTQ5ouVVQkcNpVM4nVveOttBGFR1EvCuCmX+yFnbvldNwkV?=
 =?us-ascii?Q?h6OCXyJ6vpGyKh2KqCwxJAFBYXn+sM5lxpCyZNuSmnKu0H5HuWixn9Wyre0w?=
 =?us-ascii?Q?DByBB/MslgRUq1FmGKb4Z9b72HqQdP1s5BHPgH7mj+1SpjxcGV4uIv9WGkDV?=
 =?us-ascii?Q?L/lU0sGwpTdOuQiceHj2K4/vam5WnIqD7Tnwix86PwPWEy6QaoudwG6wLn2V?=
 =?us-ascii?Q?hip5FGGToI2RpAPNB0HCN8W2jtJPV9ndT1zIuJk8hk4PH15X9irNXpF6Rtq6?=
 =?us-ascii?Q?FLeAPBt54mIHJEz24OjLnEf5XE6X3d6bv5ZGFn58TVc5SAl7L+LdEMilB4z5?=
 =?us-ascii?Q?dAWgqlaL4dPYUUJI6iz9rYYiKFaKneaif05H4tvSU77aKlp0RZf0PQVG0J68?=
 =?us-ascii?Q?fCn9H6AZVEwHrOGbpZMSAqrr4u7eqRWZz2/5y/06qK4u2QvNHi8Wfeyu9fZS?=
 =?us-ascii?Q?lG3p2VGqCCekFfpNfYpH2Z8bfyv2Mxctcqstupr6Bwckj3hAleLKuCxjir+H?=
 =?us-ascii?Q?Pw3gKLbT8mCeWDODh8lmtsQz28FKs1uiDeS7aL4DONHE8ZRT5vRNTM9uFqX7?=
 =?us-ascii?Q?gTif+5pKdexNR6ddqRQW90ajGY8ukuJEUtPQmoPbEvyrXAAxZawZ9gTfo1Q0?=
 =?us-ascii?Q?9IG5C+mYrm8cFfGuQuAtpgnvGCNKbDgO0NU1gobSGfCsy8iNrmIUqDRDHiV2?=
 =?us-ascii?Q?nj8NZyQBSO5JjgsQc5kgZZLI126ReWmVymqkEkZo3qTyYUW7poVSUPf6k+bI?=
 =?us-ascii?Q?7oyF7KRNrizUq3sIXBMrxt4+b0KNgiKlAoUgo+zZUWHgLhrOP82aH3c8Pdx2?=
 =?us-ascii?Q?XLoKdU37pUWXLRUY+vfyN0HUU3qiJEKMKEyvTWAZRp3gN8JKdScwmPPeQRAt?=
 =?us-ascii?Q?c4CKGqNzItxL0Wse8s1TJDHKEnp+pmFq0OHO+EY+I5vPZqC/1hPlD4sIxmlz?=
 =?us-ascii?Q?lkILAXyZ9Fr6PTqYLdcfOMMKTj6ju6jZHOqOTMBxuqDD48YAfJjd18dnUr3v?=
 =?us-ascii?Q?Hfg9DFOJ27XESwR0/kQg949rMm4dzoxs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:54:28.5734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c44bca8-1efa-4017-1ba5-08dccc1fede9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486

Unmask the upper DSCP bits when calling ip_route_output_ports() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/ip6_tunnel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index ec51ab5063e8..b60e13c42bca 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -53,6 +53,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/dst_metadata.h>
+#include <net/inet_dscp.h>
 
 MODULE_AUTHOR("Ville Nuorvala");
 MODULE_DESCRIPTION("IPv6 tunneling device");
@@ -608,7 +609,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	/* Try to guess incoming interface */
 	rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL, eiph->saddr,
-				   0, 0, 0, IPPROTO_IPIP, RT_TOS(eiph->tos), 0);
+				   0, 0, 0, IPPROTO_IPIP,
+				   eiph->tos & INET_DSCP_MASK, 0);
 	if (IS_ERR(rt))
 		goto out;
 
@@ -619,7 +621,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (rt->rt_flags & RTCF_LOCAL) {
 		rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
 					   eiph->daddr, eiph->saddr, 0, 0,
-					   IPPROTO_IPIP, RT_TOS(eiph->tos), 0);
+					   IPPROTO_IPIP,
+					   eiph->tos & INET_DSCP_MASK, 0);
 		if (IS_ERR(rt) || rt->dst.dev->type != ARPHRD_TUNNEL6) {
 			if (!IS_ERR(rt))
 				ip_rt_put(rt);
-- 
2.46.0


