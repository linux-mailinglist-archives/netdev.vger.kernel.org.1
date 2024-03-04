Return-Path: <netdev+bounces-77227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E303A870BE3
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D981C21C19
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFCC10A1D;
	Mon,  4 Mar 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/82QBnb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E424FC1B
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585561; cv=fail; b=qo5tuhmQ+2hq10dW9I4V/405Engp6jGcc536QY7CCM9UAMukp9SB6OW+GWRQwvuZVVrpOQkFwWa/pzBRw1DlCBRvxv5dGnnvPapgn+hwd4fZk70Jc8HoklxG2SMq0jSlQZ3Ovw5ppHP5YQLZdMUw1gFRZe+1ycLSMisBVGogyIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585561; c=relaxed/simple;
	bh=JdVzaPYHPL+r43q4VywVGu4SexKtQbR7GV5tSx19HbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=END1QogDtjAoIXxL/SKt/Si6WhothIy+7ZRpCeS2QFdExLDriHy5h9csZbBtcL/kOUV3FZReY1mFGG8NSkxQjmxgl736M+HG7aZ7Vs+niUL/njWOXxoIrNk/kzCcDkA/y/LX0vw94YVP+oqYqbo4ubpH7lxi5ou+SIXogjVbk14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/82QBnb; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlUDCIX4ac6mC4xB9Ea8akJ3JfVpjhRua4+A2/4gZly3Mz+f9WdSZ8hZswKlenRAawPU75Co9YVMTzwNWxQJuLByu9U+xZZe6U0GWDEHRLKZNDf7UJ4cMUWK9Kdezfup5vlPgF6gwy4t3KVBnM766a+nhL6V3D/YhIA2hjXTzZNR4PXRY9DOygzqR9GiF30GarKTkvP25CMbVOXw4OmesZORGG7cB7sPt//7OvvLv64HFT28eGkgqi4Hmys2qzcEVOMRb+p+pbqPvpGy9Jv2r7Q0cO64IkJ/OD2eetPpB84kqYQpgS8U3btxdKTHMOeOjdHkRxPDNfMiAJW9SldqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjGLNIUEvQyZzq1n96njwIm/LYQnpq6zgLJ7Sgw8jC4=;
 b=oHC1UoLsBI0E/kMMLUat44mShIV7ZlGI37lO//U2K10wTIx/BVl6M5fd9TFdExCu/pd4R8HMSxZxijPQbYcZw8sLPy82FyyCTMYgbbOXHzv+VmqyBr6tmsT6oMkpAOej4lrOX4oMVgs5zIj/NTVk7Uz24sSrBPvGw6B8J7Ytb9EzXgp7ozna7kW7Bsot6XkJfPwgC/b+GNplHMNphYv3WwbT/Ute79pCcgw8nbitI/ENRbc2NPt8JYujWDtmVb+GkHEOqxqZCvB5zJ4PEuY/lFirbBC1Kl2CMaj9OSSVqe2A6sMcu02QZAB1bJ9ueAXkFJNIZgbBj4YQA8uByYKruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjGLNIUEvQyZzq1n96njwIm/LYQnpq6zgLJ7Sgw8jC4=;
 b=c/82QBnbMqSBFsTcwA8gJ5QFFQBAn+7XkSDjG3UhuLdfcsXOv1TTEOz0M7OWOYWI376y2IzOKzU/uwCbKVFdYNSsOxd7OTIr7NgySgzGNpKUqwcWUiZDvezEdGukWpfP5fjX/nMcgA4no9a3S7B2Jl5bqvJqLjntj8fHKPvx1EV3Puxr70JBNVrGjlFE7wa6R7GUSyhmG5SxP2WZieH5ySW02oMgN4Esb6Mv0EI0yby71ByV1lurZ2C6FEYi5wDySOuWRfNhIEVG4jxZUDwuyXFBOE73oN2oxRGgrOXTRoCzkfy7kwfntgB4PuMC7RhC8Cjm7OCnvgghb7sEntzpJg==
Received: from MN2PR22CA0012.namprd22.prod.outlook.com (2603:10b6:208:238::17)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:52:37 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::4e) by MN2PR22CA0012.outlook.office365.com
 (2603:10b6:208:238::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:52:15 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:52:11 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 6/7] net: nexthop: Add ability to enable / disable hardware statistics
Date: Mon, 4 Mar 2024 21:51:19 +0100
Message-ID: <9c3763308b14b9385e80e3893777f536904b210d.1709560395.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709560395.git.petrm@nvidia.com>
References: <cover.1709560395.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 19843b0c-ab07-49c4-58bf-08dc3c8d064c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ZsubEbgUwA6gEp1gZTjApsJq5qx6nfRIW3jU6XoDo+qmpCoUN57VhsTZVWcJzF0orGyHPlDcdkKPvFUr6uayUV/iRNwLTtEjocTY/VrBHuQcVV2YP5VhKrrbOEPUwC8ICdX0H5H3GVDAC3IamXsa1FFI0l1F6Au99KQaqG88Gewbv4ncLBXuTLuVHaCHpY8wcXB/KK5OmSRZR4BFpw71hbr5e7cBEjuM4D2A8RNF9JTRXjTvrN4ntPMpxZumayQ9lJreB4T0fM9to0XsV27C5T5vWKKxPI29xG+jr+7ZCLNfbFySCf7Y2oK8eNvOSSHItbmiFTnPohuiUI+lfYJgI5+o9isZjvfU7hwqH8MS1j4GrcoDuRqJ2bQSNmZweAcg9Z+lJabCrrzeKLd/6yf9LoRA2KJVJ39tR01h8v6FXiSi2Nzx4MhtDl9pAZpzMb+OF/mAOmVamZb0GB5JJUONSSGUJHKdlJxkVM1pykK5yFuzW3tEo50rjdW4E5oJXVXkMjIJw1GVzLLGXICiVWDHDS/Nqfi+5a1iut9SfrAYht/aZ0rNvLkLFFRqCIVGN1y4NkFJUHpRTmEtmLV7Sqvj4lVacyy3BUcQc+51LmV31Te+v5sd6v9x3OLfiVZ0CFdlrM6XlNv2bLG3ZZGORE0g5U+qgedCz6vkTq5mQdmvW7/J8aCF5yn1xo+KD44du884JSoDkc0cOJgOd+rNuC6iWrTQKiGt2rAl1r+F0cw5TX8y2XT8T8PiWGdn4qEJkbi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:37.1458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19843b0c-ab07-49c4-58bf-08dc3c8d064c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

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
index 22efb7d11179..acd27bcdecc5 100644
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


