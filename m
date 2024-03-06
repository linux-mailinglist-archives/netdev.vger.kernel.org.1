Return-Path: <netdev+bounces-77906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106978736E7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C6A1C20834
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7214D12C53C;
	Wed,  6 Mar 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bYP8m+yG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624F12FB28
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729459; cv=fail; b=d5IphG2j+rPwXHRwTH1Azxv5R1uj0lgdqu2fnQGk9k1+H34NoUOVQDgPkH4IMWQcP6vpR73teaGF2qgH+aMIHQoUoRompkgCy55XglWNZS/+Auskv3zbWc6G5uiH5A0seqLlRIauT2/5ZaXS0rIcxa+5DMXaxDK0FvYC8ZuR2xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729459; c=relaxed/simple;
	bh=m57cvvsXQ3XNKIBMR3tho7lD+6N1TRuHvhRv+qRrFU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMVa8rUW3DwP6j1BgrjQuS8pOacySKjCHp+VA4OmJhikW049cPAeLrugQu/ktGgE0AP1KuTO/hSbOJ+YpX90p/URynXKi8v+eIzZNZLVtyDi3N1gRlICnsojnKOyYHWK+31pmOAP8q/iTDo0TOEyJ5NI/5VbSuM5pNdwOAzxERo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bYP8m+yG; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce9N3ezY4rO4IcT0SMtJaSV1gkqIks2YEM7qSv4z7JTMibB+CUM/hL34V0/HL+t28Rnc+XaH8VN2SW0t0L0NZ6dSDjfuYi/Mo2NO1rPbe8WEi4oDoh+Qi9iUN+e1lhH4KVRducf4YsPNuLDBcLCJYNH/tFWFfMpIk3LqA4kN3aZNw0J/sEdkXem5Z0oFuUYaRRItvyE2WfAIgAyhmSadNClJF1K+v++iDLxPB4c/Wn3k/aLs4NWyAD/9ADnfIKILGOAeJTwfBUNUgElyV+7JgMXnHF6YfZB2Alh5Q3PdMIzssLMzs9/s2eoEXJCBiaRzp6i9qd4VwT8lW0udRlrHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ujs2KBkREBYwHAN6pLiJH9ozVpdg8TBSZx2yq62eYg=;
 b=c7dYjs//paNmnP7dqYvOnbKg/wB9+tIdMZxDtIuAoovNWLLy9/geOasMt5Bm5Ca4FUBlRTzLGtZNgXAuq00oGP3X9+JzEJjwkIgJpV6ebCQ9oxnsST9diNgSiRv3mJ/BsO3Px0+AqiaTo0KDhT51f9GjHn+h/LsNDBdGseXJFe8+rmFbVwjOhfSDhqynhJnbsXskIT44O4BI8C5DKdI4oKSxFXEZu7CkQDtZqC1mCKyCpc5PCgp6bkwyNL/0WKXLheSe/C2SEhAgME9yFgrxbIliC7PC0eokVYoig+5YaWvELWoWag9Jo3O4WvK0ViQx7SqPDdBvS3O8GSjTkvi49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ujs2KBkREBYwHAN6pLiJH9ozVpdg8TBSZx2yq62eYg=;
 b=bYP8m+yGpLNQ5QshAhczNydORtclfDEpObLnHbhXX3++27y6RFEXC+x4fKiNaxA52GM0M8V8asB5oA7YlnoZUtc4/9/D6ZuwreJJ+jLdC1JU+MzAkGuQwr4V/WiSZpXliLxEAjWRu6AU5ZONbKClCPbndBFXbgLXZbFPY/NQ3Y37nwlrwk87FyLFvNlOW5ScKlzN7WptBdp984rT+bJ0xQlCu0XDXmmQSu+yiSrTOgVqlAkJD3k14eg1ZRZ2n2Dlq2490Wo3hM3J+a76E4KIpXBvuR/7XUMB2QnSsRyAO42RUFRAUuT5tcvispORd9tuWdmrxi/WHDAhbin2l1x4nw==
Received: from SA9PR13CA0158.namprd13.prod.outlook.com (2603:10b6:806:28::13)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 12:50:54 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::d1) by SA9PR13CA0158.outlook.office365.com
 (2603:10b6:806:28::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6 via Frontend
 Transport; Wed, 6 Mar 2024 12:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:50:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:34 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:50:29 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 6/7] net: nexthop: Add ability to enable / disable hardware statistics
Date: Wed, 6 Mar 2024 13:49:20 +0100
Message-ID: <957be0d4dc6f452bca4a4cb8be348ac705d022a3.1709727981.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709727981.git.petrm@nvidia.com>
References: <cover.1709727981.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: d03d5ab0-1967-4f35-a46b-08dc3ddc0f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IaEuc8ipjYpyUfZ+cDQCKpmFTtYOpQVepGg6hqEoAtP/cklim6T3pEL73ehlpvKqSrNO9n3VeBNhqgA68GSHd3Hs7fIMa+kr3c8Dcl3Aj4i6Th1c4MN+IH58WrRXxjz6L5YjToZ6yd56As4F9c5VwJ4qqvD1KmymDQrbRUw0BjAnuMBQplWShvKGfYI/3GgjLkAbcWk5NEwp70siyioiAR+jHthIH3S5/EJdStKjwnTL7DTKBAqGj44aPfBUGFEq4zdKK9YcmDd0aJEcqFb2LR5mvkhDPCp5a/shTTc6qNFQpFKpDAwRIrhC/t6IYThibvob1lP5iZHOVkp4Zk2LRX9I7TtrcE4wDX9E6AHvka9gd8ebkp3tgfQ/LRS5fvBcplracZTTvlNPGTI6LkCX4+Pp/P1DYQ8rZ8HQbGIDmfla9yce4JyeMWV+JCBGcR/iiTcbviLB4MBToAqufTl02R28cg/UzIzxBUl3wshFk44TiJCOhjuzwzofzqkBJDi3EoCibLHLDSy9jNeOaIWkZNMOokT1A7lc0JpXWV7utQQgM/jxM1F/Y3c2LeyEiSWqKO0Xuz4oM/eNJMwA3eeTT1PmufvOMcLAZ+r4BtVnGf/Eu5+PrOrOjUfdKf0bQk6CM7iZ1JNiI9h/zuP/Wt2wEIgv7AbZIBELdtLGDcZuoz7lbgI6FicYppL8yt2YE+ixOBVfx32Jr01lhGOeHaKNSk2WirtgW/+VmKa0enTmGsahSIOc/Iotf0Y0XBE49lET
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:50:54.0156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d03d5ab0-1967-4f35-a46b-08dc3ddc0f7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

From: Ido Schimmel <idosch@nvidia.com>

Add netlink support for enabling collection of HW statistics on nexthop
groups.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v3:
    - Use a named constant for the NHA_HW_STATS_ENABLE policy.

 include/net/nexthop.h        |  2 ++
 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 15 ++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 584c37120c20..1ba6d3668518 100644
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
index c0d14e16e9c8..e75b1aae5a81 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -39,6 +39,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 	[NHA_ENCAP]		= { .type = NLA_NESTED },
 	[NHA_FDB]		= { .type = NLA_FLAG },
 	[NHA_RES_GROUP]		= { .type = NLA_NESTED },
+	[NHA_HW_STATS_ENABLE]	= NLA_POLICY_MAX(NLA_U32, true),
 };
 
 static const struct nla_policy rtm_nh_policy_get[] = {
@@ -778,7 +779,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 		goto nla_put_failure;
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
-	    nla_put_nh_group_stats(skb, nh))
+	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
+	     nla_put_nh_group_stats(skb, nh)))
 		goto nla_put_failure;
 
 	return 0;
@@ -1202,6 +1204,7 @@ static int nh_check_attr_group(struct net *net,
 		if (!tb[i])
 			continue;
 		switch (i) {
+		case NHA_HW_STATS_ENABLE:
 		case NHA_FDB:
 			continue;
 		case NHA_RES_GROUP:
@@ -2622,6 +2625,9 @@ static struct nexthop *nexthop_create_group(struct net *net,
 	if (cfg->nh_fdb)
 		nhg->fdb_nh = 1;
 
+	if (cfg->nh_hw_stats)
+		nhg->hw_stats = true;
+
 	rcu_assign_pointer(nh->nh_grp, nhg);
 
 	return nh;
@@ -2964,6 +2970,9 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 			err = rtm_to_nh_config_grp_res(tb[NHA_RES_GROUP],
 						       cfg, extack);
 
+		if (tb[NHA_HW_STATS_ENABLE])
+			cfg->nh_hw_stats = nla_get_u32(tb[NHA_HW_STATS_ENABLE]);
+
 		/* no other attributes should be set */
 		goto out;
 	}
@@ -3055,6 +3064,10 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
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


