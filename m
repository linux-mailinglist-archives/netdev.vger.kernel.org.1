Return-Path: <netdev+bounces-198307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF7ADBD25
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FD417404B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E81218AD2;
	Mon, 16 Jun 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9CzQXGA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD75218827
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113964; cv=fail; b=FgPqUx8VQFpz228BcXLqgsM8MimIFP53r2UDzCmxQaGML6SdAF8CmIYcp+8OSm5XiDqlQ7EZ1++04+EWzKRIgl31ZWKZj3+oX+iWJwpGU2KBsGJeB9yMwnH2Ji5tCikN0TXRxTHXC9RUIq7G+zq/C1xRVs6lHm891eyM3877qeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113964; c=relaxed/simple;
	bh=RUAFOk8Zr8mBh+A6dSgGNnp9l5SOD7DGnAMvSMhNyoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMplOZ2U5a49jy57PnT+xe2dHCrkJAwFpor5weTXjuwMTXBQPG843DhxL3YZZpwb6pmh4PELQFv0wHIuSSPpV6G2WzGPV95sVuZraKj7La8dw26ho17n8X/mBvonN/jFbkUYxqjmB+eH8OFGqBtrJlPZ+PSu0UTlj43UK629OUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9CzQXGA; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRlSbXj7lLeS3T3k1C/vc5vdiIdD+/sVH9gTmmR9eUWsaGSxDnpDm1A5lANvwyJgJGcDJ7PbHbY+2OGaTNBziQRtrYMLP2RWWkdqxfYtMZQJY04t+MT7P07mDfkFJuwCv5AvTgkxaoDHAxmu1zouuEZ6qh3wsWd+SowG5SLNpf7g4t2aQt7QU3bB+flUS588KcQBeTEDkhKepIuqIfOK1eVj4FjZIJtOqta3phWYohqMp6bu2zLLzwlA0H7tPcKRjr56NLx5KIHhuSEPGaW+m9YrpqSQcZHsPLV60VCDxvQr5CL+ox3gOoIJyyrM75hVGgYHNcl/BhrHLxIDFkMONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UITcwLf9HRzw19IaWcQSaV1mti0rET85Ng4pILCaQho=;
 b=sto4PJF1GzyR5vd66qxibaGMXJ86DTxFIyybD70iWnDFQqHfwWTdW8wYux6qJO6NwmI/TzvrUEo5XXIfrtpdEXy373oH8b4jnwrAMbsoU07km3WDYpXlpx9yhqduhkzXq0ArBR6cOpWzH+YZuJLHdzhIvkplK7RSXrC3l+Fk1nAtkICoDo66IBdsqYgPpiv9a+tz47mie/G0hTRmiTkvlfCYGrETcw770VagP8wndsrQndWxkOnRgo093bijm1oagUY5ffw6hXZxinVLjYiPKhdtQBDiDwmrQz73RSUbubPy9wx0cAjYPibmXItEVoq9AJ/oOUcZgrtarcBnIHUMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UITcwLf9HRzw19IaWcQSaV1mti0rET85Ng4pILCaQho=;
 b=g9CzQXGA4PUAokOP2N0Lil52Quuk9prKNuL1GMkYeusJC6t51xE3rsecyzd/iV4X9LTVWhTpI4e3VlpfRUTOoETDTkwx2H8Ac+A331Ucx0fUG9d2Kkgp1RnuxkGo9noLe9UIIvLFJJPf0oThBHUUTf47jMl9Sj2w5EEPxc/fJHJEGj3zCHiPhF7ZGclTU0zoy3WsotEn086DWcDkpbtQ65We/w8IddsIjEbmSB7XocSejVNHY2j9/cC61eEz+SQUPBLrnhabUJbsQqfDT3a/bk0KVeUR/DKovAPR5AAzbvM55ikN6FlPcw/DXcwEmIGLOfKAibyQVz1SpE3trzqWbw==
Received: from CY5PR15CA0240.namprd15.prod.outlook.com (2603:10b6:930:66::12)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:45:58 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::c5) by CY5PR15CA0240.outlook.office365.com
 (2603:10b6:930:66::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 22:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:42 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, YOSHIFUJI Hideaki
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH net-next v3 07/15] net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain
Date: Tue, 17 Jun 2025 00:44:15 +0200
Message-ID: <3141ae8386fbe13fef4b793faa75e6bae58d798a.1750113335.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
References: <cover.1750113335.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1eb0bb-7975-4c63-e8ea-08ddad278f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXxwK5h7naIgPezzZhEmyZG6rzCwFHQcbt8w/5rCmKDCAi25DpHyU6Pd3Hn4?=
 =?us-ascii?Q?nXMVTY7FZLVujeMpV4jq5DPc5+odwwKjvMpgJg7RAv2Qd8a83qyQByeDMFaF?=
 =?us-ascii?Q?GlhQV2oW2j+rK7HLEvBfafcm43fZ+cRX8zYwwlxiH+xVcNQMN2TDSjurglge?=
 =?us-ascii?Q?Kl5K2DGAD4LmDhUxC/JP8jswit+fQi7E4zoSqY8qE9sZqaXTxUzDOOX6qxxB?=
 =?us-ascii?Q?QE7oQEDJrOIrhAHA6E5Fx7pM3kKQHtrB/WcszF+MlWoyE++IAFGilE76abOx?=
 =?us-ascii?Q?dvjbNiqkFLbI/iNv9JkJN1j/lqKmkyDn9lumBJC5B1uzkBfQ0MH0wcZM9kor?=
 =?us-ascii?Q?ib00ZPzH2UgQr4Jd4pd5j49Y/U52OAQkF1W/zbgUcirsbRMQQotMkK1MMnMg?=
 =?us-ascii?Q?3nQeyLu1Fu3nBn986oSM4dBMDN8ZLBycGL3dV8Q1Y39E4l6gbdcXEUTsUMDY?=
 =?us-ascii?Q?LdMBcULVLdvMYThaMfKINn2NX0K+DbuSyZFBtSBwQCO7tpnP6kbAe5PCrVdB?=
 =?us-ascii?Q?yYwkT/2Od2BjtKzsViP0DrdPlXZL+rlAv1FFJtwnnchaAfkEUcz3uksuMCpG?=
 =?us-ascii?Q?WVAhx36+Ye+xQpFxcNS98ph4RNnpq2TY+xY/XY7gde1cE3EJv+QdMTSiLzho?=
 =?us-ascii?Q?6uDyKsa60mT3sJmm7mIt57FnTpN0CbCs/jv3GeHRgMNg2CWSamNtI1eJyjzN?=
 =?us-ascii?Q?FcUK/vx8CteiqvjARMFJSBeEBZZiaxmJTB03P59O78wDW0WbQ7xuRhbjIOg9?=
 =?us-ascii?Q?ACGPDkfxR8/6ovovJtG4cU6zKLaY7YavbkjokiXxm7U8Y/v94SZZ3QslYPCe?=
 =?us-ascii?Q?/JkkjE480zHYI6JcKAr+ZJ3F1PSDYC8hF+t8tH6X9JKBUUta5coptVja4awB?=
 =?us-ascii?Q?U6dkRpftTlIwPf/xRyoOvSuUXQh4WvM1waSQwqeSA+TlLOVc9/cjtV2jNlFs?=
 =?us-ascii?Q?ZW8Fb/Cd0Y+Hq6dGJgZRl0decaFE2+jeXtqhzniBtcRHTQobOiS+nD0ydxyT?=
 =?us-ascii?Q?PzFCFoC8F6HrqX+AbbSXIUjcj7ItEuvbutUZJwfo3h53CMjzGnJvTaiEv00F?=
 =?us-ascii?Q?sTMnkT7C4tEzWhCm/+B0p3gsk8PFzTts6ujPOpE9hZv+Jr2+FBJxSU3YFGGl?=
 =?us-ascii?Q?avpeCs9DoYIl0YRihOB/IP83Pb4JCMxAHcs9QCUe51PEXGXk6yzvfyxW6Ihy?=
 =?us-ascii?Q?GTgWj+uyKY9uoPzD2qNV+HkfQHnT2USNLxwe8FNZhyGGiPVzPXisUn7lGX88?=
 =?us-ascii?Q?Mlc70bpw9+H6wTd9pVokEytuY9zQp3VgLG+3h3QWmnXz23WckBoHY/po8ibQ?=
 =?us-ascii?Q?1bEI56kMpeFlOkLTHVddVQa/IYZJ6LglowUhmxmtOZHWJVThZ2uqG8SDQIcZ?=
 =?us-ascii?Q?bN0V8K3bsMGoK4L/YKpe5/JRHYlISPa2XRvY+er+re4ArbVStqsTPclbIvWc?=
 =?us-ascii?Q?9KSteshsgqLINxAsjdDTCVm21QnCfejvQdoMAZWPqfPpTL/rw/HqsL2TCg1Y?=
 =?us-ascii?Q?hhkQT51/n+lJlXdzdfa+uC4YQOQHnGb+htdV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:57.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1eb0bb-7975-4c63-e8ea-08ddad278f86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283

The netfilter hook is invoked with skb->dev for input netdevice, and
vif_dev for output netdevice. However at the point of invocation, skb->dev
is already set to vif_dev, and MR-forwarded packets are reported with
in=out:

 # ip6tables -A FORWARD -j LOG --log-prefix '[forw]'
 # cd tools/testing/selftests/net/forwarding
 # ./router_multicast.sh
 # dmesg | fgrep '[forw]'
 [ 1670.248245] [forw]IN=v5 OUT=v5 [...]

For reference, IPv4 MR code shows in and out as appropriate.
Fix by caching skb->dev and using the updated value for output netdev.

Fixes: 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast forwarding.")
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    This never worked correctly, hence going through net-next.
---
CC: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

 net/ipv6/ip6mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9db31e5b998c..426859cd3409 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2039,6 +2039,7 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 			  struct sk_buff *skb, int vifi)
 {
 	struct vif_device *vif = &mrt->vif_table[vifi];
+	struct net_device *indev = skb->dev;
 	struct net_device *vif_dev;
 	struct ipv6hdr *ipv6h;
 	struct dst_entry *dst;
@@ -2101,7 +2102,7 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 	IP6CB(skb)->flags |= IP6SKB_FORWARDED;
 
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
-		       net, NULL, skb, skb->dev, vif_dev,
+		       net, NULL, skb, indev, skb->dev,
 		       ip6mr_forward2_finish);
 
 out_free:
-- 
2.49.0


