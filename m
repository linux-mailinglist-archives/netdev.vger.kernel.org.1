Return-Path: <netdev+bounces-76282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BDF86D1EF
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B4F1C21EB5
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4B7A129;
	Thu, 29 Feb 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OH5PUDsy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD778286
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230839; cv=fail; b=pmY6L27xqVggzO4itnbQ4qlhmmX7/btIn2ix90/U09UDXntSg4VhwmGRJCeSwWcg/sS8dJ4hVQBW83JuxPLsgGzCYDPF6WpU9FZQvll9OSOUmn0edYR8iWPfeA6kaSCiL8hjfAOs8XAwdUVPhuoSEonWLt1pjXWBXuGLe2blMRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230839; c=relaxed/simple;
	bh=35mYSa4ZgiJSFdzmXb8QxoKLYdSwhtP5NQB/bk7a5m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YM/MmM+EZSLr/gNfVLd6lA8fedecICinH34RO3Qg3SYXkHs4VQdl7VtRTMBgiWeEdKoBuRrwm4O4ljPGDP4dowBW3XBzCA6T9jYu0sIaHXqnu4qTrEaY2L8hbDd5wQjh2gB8vHV6oO8pj6/OyDZllltA+htsYcrLLtqQNrnqdgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OH5PUDsy; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX6m4dFTxCIKUf61PHFknT7sw/JOL1bLyXanKL6X23MpX7BJrrH4/iAPyAzcGTDHibUK5NdN+gRJYXlXjqkox9f760ueI0HarsXzd0D/dlcIUQequN34XrxR+lJly43M4t08zMpVZJ2yxFCq/yOzMkkmse9+GNtJk6Ydw5QrTPJVH1OUS6bbc9Rpn+QCQcwcQtfeG+4kSmETnBHxPjBja9Oo4iXoTKGeFVrZLMt86rfkuj1vOC6o2QXXv9YLYUdFmlClKNgaJ2SyApDseoOZwRC96nsvf6f2OCX3SFZbfwSVtYg+BFdXEnQ6MyEgtXfa2rhCcFl/JNo4U8jnCLzI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6ZIWhxWNq5KxVsPVGsgGs9xVWmMe+DbSa9pUn/HCMw=;
 b=l7c9J15j2F6vWtgRWv8AOQwcdNphZO/GI1O75OrRy0/Yehh461OMXnzo1Y7CDbrFoPONdmfLE3vPrF18a8dtGIlGbqRVCIj6bF2os/Vg5OTkmkn6MGXjTFa8HLKibwH1zhMxKq3sYsJl3FVaaqOzGGE58Zo1mS4iiL2M6OYWXyDC6waiZztn9Zpdu1uAcKBy3sOVoURQJDjzJ7MBnBOSk4K6X7xx040KuSgJ8eNNNgaZdw9XS2wTmLR+bbogMDziOYFdSpaDNgA1tVtRNiyFNS2qzWkFioUEGVGf0/5zcCJ/k20AI6+Sq6NLunRnnmTW0FED1LpWUx7v13VgZfoIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6ZIWhxWNq5KxVsPVGsgGs9xVWmMe+DbSa9pUn/HCMw=;
 b=OH5PUDsy1lzl483hoAYZboYFNTEfOCDC03iwVCzO+Zgbtz9B2VEx/Fek4f7DGYmdA/S+uAuOG0pj6s1AMrVdAvbbdIkO3UrrHQ5KpuAIo+mGBT6EjWdfC7RyP0/lq4v1JNKDH2Aij3hxnQM4TFSMiRTor8sSwLdXAafSs5eTyVAroed+xkOkmIymMrOBLJ1ec2QEEcfoQPTsdY+SZpm1avhKXqSqwk9+pED/OE50v5//2bph6bcd74XoOkzfW2PjFTbHiZpvMtxk4TYMq7dmZCYvK2bXnjpVd/oUsW/r8bp58TqAX041I6Z1/gHll1YySCE2TnNhcqmbUBqG2B6Hpg==
Received: from MW4PR03CA0343.namprd03.prod.outlook.com (2603:10b6:303:dc::18)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 18:20:35 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::fa) by MW4PR03CA0343.outlook.office365.com
 (2603:10b6:303:dc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:20:15 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:20:09 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 6/7] net: nexthop: Add ability to enable / disable hardware statistics
Date: Thu, 29 Feb 2024 19:16:39 +0100
Message-ID: <5766037d73a81ddc72106cde93943bbca9289ae2.1709217658.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709217658.git.petrm@nvidia.com>
References: <cover.1709217658.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: ea054b38-2ee2-41fe-ee8a-08dc39531f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	51aoOu0nN6YRtlrMaEcEfeNkiFM1zncjNHnVwFYnb/MamPy0SAeYV3ZvQr6LOjLWYNdEDEIA59rnG9pg7bLItFHUgNE3DW8IhO49M4Qync/4b2y/3ef97NvhZnUTOHIw+SnhnHimT+rvD4jNE3P1wsfGFFLEjHyauzJOzSBO4Yf6gpyW+rZEVBy5jh+oDe/b9kdh7gktTD3HGGPKWWlyIPxkggv2r9ZmkDbxEf9QSKEs5d4nCIttOoi1/8cad7fLbzj1cqVJT+eGtRkDIKoJ+mFmRIGS5UyyZqfkv0AiVuwgNNh5YbDEe21+T8LE1dQ1hTBuNiDVUNYYBgoPPBexRRA8TZxamG25dfq5MKMl1FPa0VPhwbnAzj3N3rXgGirg+4HV8MTTA6LSZSWMC6H/dN/6QjFz5U49+lAptbPn4MQQMkBFIGR/n02GBbqUb+VWUtu/+kPLcS1UAd+tOaljFNQAmfvABr8hiyrPLtqk4fizwau/J4PiIkR5jrdpNGYAMNoEMx+LpT30/5EHU734QCWpP4+OJ65AjEe4FhIDBdqWIu+R5ihT6yw0LurZU/Sbtz1KexyBCe5Fx8Go/EghKetqMzO/ePRypAnqcF8/NUbT5mO9BOHsbHwxa8xp9//7Ew8mX+T7CMrtPq+L8Oi4h4wTRAAMiC8C0t3KJoMfidrZbzHhCXqpQMPvVsOc9il5j03L+okB/CgspmpOhC/5ewsNnGAsumxjo4MpPWIuJxmvq/fA2jlHjnfLboxVn+AO
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:34.9100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea054b38-2ee2-41fe-ee8a-08dc39531f4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173

From: Ido Schimmel <idosch@nvidia.com>

Add netlink support for enabling collection of HW statistics on nexthop
groups.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 include/net/nexthop.h        |  2 ++
 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 15 ++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index a8dad8f48ca8..20cd337b4a9c 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -47,6 +47,8 @@ struct nh_config {
 	bool		nh_grp_res_has_idle_timer;
 	bool		nh_grp_res_has_unbalanced_timer;
 
+	bool		nh_hw_stats;
+
 	struct nlattr	*nh_encap;
 	u16		nh_encap_type;
 
diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index f4db63c17085..b86af80d4e09 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -68,6 +68,9 @@ enum {
 	/* nested; nexthop group stats */
 	NHA_GROUP_STATS,
 
+	/* u32; nexthop hardware stats enable */
+	NHA_HW_STATS_ENABLE,
+
 	__NHA_MAX,
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 02629ba7a75d..15f108c440ae 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -37,6 +37,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 	[NHA_ENCAP]		= { .type = NLA_NESTED },
 	[NHA_FDB]		= { .type = NLA_FLAG },
 	[NHA_RES_GROUP]		= { .type = NLA_NESTED },
+	[NHA_HW_STATS_ENABLE]	= NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 static const struct nla_policy rtm_nh_policy_get[] = {
@@ -765,7 +766,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 		goto nla_put_failure;
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
-	    nla_put_nh_group_stats(skb, nh))
+	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
+	     nla_put_nh_group_stats(skb, nh)))
 		goto nla_put_failure;
 
 	return 0;
@@ -1189,6 +1191,7 @@ static int nh_check_attr_group(struct net *net,
 		if (!tb[i])
 			continue;
 		switch (i) {
+		case NHA_HW_STATS_ENABLE:
 		case NHA_FDB:
 			continue;
 		case NHA_RES_GROUP:
@@ -2609,6 +2612,9 @@ static struct nexthop *nexthop_create_group(struct net *net,
 	if (cfg->nh_fdb)
 		nhg->fdb_nh = 1;
 
+	if (cfg->nh_hw_stats)
+		nhg->hw_stats = true;
+
 	rcu_assign_pointer(nh->nh_grp, nhg);
 
 	return nh;
@@ -2951,6 +2957,9 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 			err = rtm_to_nh_config_grp_res(tb[NHA_RES_GROUP],
 						       cfg, extack);
 
+		if (tb[NHA_HW_STATS_ENABLE])
+			cfg->nh_hw_stats = nla_get_u32(tb[NHA_HW_STATS_ENABLE]);
+
 		/* no other attributes should be set */
 		goto out;
 	}
@@ -3042,6 +3051,10 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 		goto out;
 	}
 
+	if (tb[NHA_HW_STATS_ENABLE]) {
+		NL_SET_ERR_MSG(extack, "Cannot enable nexthop hardware statistics for non-group nexthops");
+		goto out;
+	}
 
 	err = 0;
 out:
-- 
2.43.0


