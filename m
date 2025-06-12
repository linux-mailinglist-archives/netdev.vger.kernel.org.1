Return-Path: <netdev+bounces-197195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B21AD7C28
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DE2173440
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F302DCC03;
	Thu, 12 Jun 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwDRGkt0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F2D540C
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759208; cv=fail; b=ESIY13wrRwu73LImYd8km0XArThEoWVifPmIY7gl+aQnGRSubL9ukiSwrIP3pL1OztJ1i2WyRJlIhhSjW1RPMeZ3nz27UsoucKhxKocEQvmsuYwmZDNKze3aCGQLd46RwbFuofhWSE8vPIjM9lfyQNWlG4QASNEi3dQ+DfRMMWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759208; c=relaxed/simple;
	bh=bxjVi6mF+ntpd0dEKSKoDokPPh+KFmetEQ9pItLA53E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW2i0iVL+85wtudGwE9oEKrHsRHNHXyaeTQKPHVzHxD5zqkUMLom4fIkAXBnqI1ylZTCpmmcsMQfHO8V1kftyZYnAzEzQ9UDUtAIckg1M8BwOPGKt2MlYTfgHlnbqbbdjP5bdNpBKm4CdxTdP0rvRNoymy+klHWHRfS16PE4PFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwDRGkt0; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G27SwuEQ3ngUAK83hcqlNwxGLCrEzRqQ6QTI6gFlFuAsmXJBm87tLm65kvRpnJXCRe8Y+HpLBesotz6BRkInNuHZTrpyFnzUwCG9bph2TXsjVyjLx8DIBHG1AxTAT3qoblrM9HWxiXB3y0NMUHaB3Fnqh0fE+nUBd1ZmICos9Jvw5J4dfrE/FoQElqiu4pd+ZplZ7Z3il3BFmcxymfGn9JulSGzKWtWthSx5OQ0k+BZB4jzmHFFSVg1+r/D1+jWAKySBOi56EqUeQ6EgsK4LNEvCvGefkEc/MX6s+qF0wH8oia1/mZYcUSgIxGBqL/9qs8XxUM+YccoeURTjZ+orYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwsjfgPRP6nay3WWigkEH50idmYseD2WFFoKWcbLLNw=;
 b=rZkjdzqQ3YB8BlmvX5t+nTMzDxDmdTxMoVSZDWTPpCjq5ZaXAn8H8XcBAMWeTf3kid/MVoug3O0SPwymfd46Bm1llbxC5Q04Nr6z8pA+1QzXmk15qB/BrUgsdLBG6KUKuGomtvptMnNQWZt5aS1eCApOTwGEgsCEUYixvrzNVnQi7SODzcZyc3wrxW1viGtZGHl7xxZqx9FIOl2Bmni+os3DdS8/OWT+XNdY5Z7gNYhXpgYzAl6yJopRTGUiBled3XUtg21H3z6e+txrgnRlrKu1RN6DXY/Z+QWWFZP2pABDpL9aMobAVTR039azt6ySuiQeVEO+cwYNGop6iXMUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwsjfgPRP6nay3WWigkEH50idmYseD2WFFoKWcbLLNw=;
 b=NwDRGkt0ykpqlb7DV8zCMpjzxAMu0VjCierxX/BD96+zXtetDAL/ID5Hw8TCVZpNS0QxO6B4sz70wS2qs+QjSBiYTUmcH3rN8Q4gO5NmdWJBUgBK/coWOZLvRyG3bW6nP2Yw4VJ+KyjLbGZmIC+uf2DYFcSx5gA1clDcpG+D4Tomt5hap20rDRRIJ7OssHMAjinJHHxEk9mda1jsLTG+SQQ8kKUhzyBbrMWvTFWx3Os5xjlsC1zBvi3ozKJIDbY6nU0sLxT0eveKdkBQCh16Vm+u2uCbrE9Rvw+CZQMpqRdxumO2kOQyKxrt9qSlMSBeEfsKbvKXajXtCE3TVqsfeg==
Received: from SJ0PR13CA0152.namprd13.prod.outlook.com (2603:10b6:a03:2c7::7)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 20:13:24 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::6b) by SJ0PR13CA0152.outlook.office365.com
 (2603:10b6:a03:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 20:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:12 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:07 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, YOSHIFUJI Hideaki
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH net-next v2 07/14] net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain
Date: Thu, 12 Jun 2025 22:10:41 +0200
Message-ID: <c169efdd39667586bec562c9734080e1ba7da255.1749757582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 7441e866-687d-468a-48e5-08dda9ed9536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ltVgkt7AyHAidfTrIXS8DNRVNPwg2MY+eKIYDYHaGlzydb36fRyVt69h3KMI?=
 =?us-ascii?Q?tbpidkZieabfjX7joK7Xe9Ofm/fjtqYFDLqG+W2ls7p+Ja2IYlAlxKoLXPft?=
 =?us-ascii?Q?ljekWJVUXDjqJGTuuyUbCxRK+wYjUQwOJVMKwcjNCna1Bn6gDIMs+psM6gYQ?=
 =?us-ascii?Q?QuaNQBo4g/gOWyCnx0uO6WTpVvVcIPyUglR0LDJ9Miv/JC0HIaQdFdlSVVCB?=
 =?us-ascii?Q?10B/U0N5pXAfS1oqccLVemv8D1QCUs5x3J+Vd1eiE32LWKJ362yioNfvUeWR?=
 =?us-ascii?Q?EtuRGcUJwoj9BqV/12awTmnUiM7zNiTD+zMKKldEt8w1dVYshJ26ZAGrZ2qn?=
 =?us-ascii?Q?nkVHfivOFWaaFIYo1kbJrsP3XSf51f9bJAlyXHvShrz7US4s35xx6FpkxyR6?=
 =?us-ascii?Q?60EBbnRPGoadC8Y2o/ixfBxImu80ifLJq40C4IIsqqqdqjx+jftMwe5U70vr?=
 =?us-ascii?Q?dG0BvdRnBUcC6Nplz9IwFErlo6CPR0CVgl3wP+JQhtWcZoIBEa8GSwJkKAQO?=
 =?us-ascii?Q?igQD/xx1YdIJzXWY2Nmx0frgbEnIiL0E6iRYRU7g2SRLsoI+oSgUTT4VWrBE?=
 =?us-ascii?Q?4WoG4IynsVt4kmzFVApz55JITon3G4w6DchK8BBeFdgvmSynnCi4DfXnCo+3?=
 =?us-ascii?Q?08S3yv3LAGxX16ATA1nIWLRD82NvhxqqV8jgHH6SRBNOYFYweso3oxC8LhcM?=
 =?us-ascii?Q?s2mHbeot7VgPDUstIg2b4QdC7bSqGUcwQuo984pCEMYJrDudSl6fY90GP7sz?=
 =?us-ascii?Q?PapRUQk7xKzbr0pMDmaYHDq5yAQXs2fzxGEfbINffHZ2KnTh/iFlCYZWkM4d?=
 =?us-ascii?Q?V8ENbpQkQBbrWmiKv7XzfzEvBps69AgAn39UCDJ8Y65cLIIaSIhJo9vy6hZO?=
 =?us-ascii?Q?/zpKq045jeai5sarq9+rlPsaLGlM0m6g1/gFMW99GfFMUhw6K0HcnT0TJMkl?=
 =?us-ascii?Q?MNOGl7WelZhhit8EYoZxFs7AUCXisDkl6zQumj85slPntm9PmrCZPssluvT4?=
 =?us-ascii?Q?SQRdLcr0JdkAyv3pm/eG47mPppTGpeAr/gyfJfjxj3PrY0AKjorNzS1ap3YZ?=
 =?us-ascii?Q?F2cDRej3+NoHNPpO3U0O1zGkajeifQGIeKvPcWrjN7ybg5rrb/rgM9c8VHX9?=
 =?us-ascii?Q?jgoFtVVoR3APvDiYd9vxVD/wooO9kibhkRCGySC48lfwv+eHZzxQqqlK/CkP?=
 =?us-ascii?Q?F5JCTsy7iwj4LyI8kmFAGb4Fg+atC7CrAC+zAlMwSrwKlmsxzoCuQ9ViwGa+?=
 =?us-ascii?Q?DqewSw0Rgh/imXD0NNYfoZIjsoWe7f5xurydOR6uN81WQYKmaxaonIdfhQYg?=
 =?us-ascii?Q?LSjmrJZ253eSrIukrZ+V6/P2CbQv4Ca50h9/kQczdy0JVpDHYcRDy8cBeE7O?=
 =?us-ascii?Q?+38D72X/Gnx5jD9KcAeFfAPx3SPw9Zi46zfyTv98YcOtTEqsterzPw9WgKji?=
 =?us-ascii?Q?PyOzJ0dPVdpeypafEKQR4KJfMpYohkLz39Lc66/18ZhxO3w9y+BIhm4ddwGN?=
 =?us-ascii?Q?kCPRzyQfG+MkjOvJU/nDGLONfqYWPoZCXaK3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:23.1270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7441e866-687d-468a-48e5-08dda9ed9536
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

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
index 3276cde5ebd7..63c90dae6cbf 100644
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


