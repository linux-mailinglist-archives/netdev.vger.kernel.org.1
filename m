Return-Path: <netdev+bounces-75441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7B869EF6
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9010D1C27F38
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959414CAC3;
	Tue, 27 Feb 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ueGOmOU8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2314C59D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057915; cv=fail; b=QRN4uoNuW843HxcJnt0Be9qoAtLhewoTTqUMnCkicNyP7W4GZun71aYRyqhgkLD+m46fglpD8QF726qraLjZ5G9NncjyuxA7w5YUlVrYwjy4pCRWYtW6GvRRInVbDbFSl63uCnBqhtOpvE1RbOJrz/LbtkcxiDavDi7Sz+XuNmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057915; c=relaxed/simple;
	bh=njYE0doFl/w+iNx4kqLtHdADAdOyaa1UDj5st9OGoFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHV8HE6rvJk9+AIIhafSyDkFW+EV9iu+L3hDbZTt2DmwhcAVVdrEPWR+HY91WLCCekWG85k8fCdp6EkAqNP+j4ntF7LZhKqxoGv0UFOLxeKexHFX3STvIkHcf7GgJdGMR4Tx8t5gC0YENCyvHOAD7r0fIWm3wcn8HGLijWnak5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ueGOmOU8; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNrPkE2WtDO2aDMS4muE8XJUSDTiar/eDnX8tz0Nq+80aSV0UNsUsxYa78gGV+sex7Uk9PR43NVNXqgABy8SutBRUSSkSJC+ug9mkKcfZkiT0v/WvqTNeGdOzTJpC0bT3PJpTSuokvXlvQANS1NgeLEIZaxdxaG/wL1D5XhsO/uhKh/QOviqqK89sxUkGH7i236KiIf4sJudmUD/fS9N/tIX3wXQ8WUECnP08zEnuWydaEObE7g6SbulqbqUaAzDR76ztlrsTuxdPG25zs92yLjlSlHDIX1k1i7gCudX/7Lo8hjZA+95O/6hbLQfbIndgu0ena6mGqETaVGV8YxpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofcbX5MBY5TsnMEQ2lVAvVHAjhraAq/cQkjnwHMpzYE=;
 b=AZE/erMvuSybu8SAumNMWwnfPzirkeihk4+Ug3B65RDeF/AQTcl3UkWp8eZGW6oTRuJHA6Flqr2U5BzCBtYJ18nZvZR5yOgY78SvjSAR7oRc59CipHo2414vGtEH2Vw2OD0AEBpw53c3ylMYSqEriSZ7W8v8vGfT7P0u3oQiimBt7SUHOF28k6GMVdxFfILh8TY+PaaIeFtU3YA6w3L0G0MZd7x+nszXjnTFSvRXeeVdRYB59kzs0RJCNcYjxkUl503Gnr9SJFgnzgif7J3nG5vJ1l3+HduUnwc6exDbD7JbbGEI1X9Ue1DtB2wR8yBKYlhtMSl2bkZL17tC7XS4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofcbX5MBY5TsnMEQ2lVAvVHAjhraAq/cQkjnwHMpzYE=;
 b=ueGOmOU8fCj19wcAvZsAEbK90XNxuePE+9VjFRbrqg5k6Kl4BhQUG0ZOW4lJ5UT+sJSpl+kDTbWzwOaW2HCmXPfpM+rAsapZS8QTP9UFwUjRrEiqInFmps6CdEld0CwwTAAkfj1V+ImYPWMjqhAuHWuTy7x/zXh3X4DxgGyY7xoCjywmig1WcoN8EnI7hGwwI1wpCt8qtaX33H8zfIHBse6+M/peage3ABXGm5u1Faeaicr4Y0d5eOD+CBcWh4X00FoxzUUDDXu/c3hOS7c6YuYQk5iZB3EzFiaCH07yxS0NONbkbzSU2PpHIhmsM6Ob4neIbRgwWqo2i3aB7xJAGQ==
Received: from PH0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:510:5::9) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Tue, 27 Feb 2024 18:18:29 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::37) by PH0PR07CA0004.outlook.office365.com
 (2603:10b6:510:5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:18:10 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:18:05 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 6/7] net: nexthop: Add ability to enable / disable hardware statistics
Date: Tue, 27 Feb 2024 19:17:31 +0100
Message-ID: <07dd1f166402658b59c405a0b2e7debce2c5a5b6.1709057158.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709057158.git.petrm@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b00670-7440-46e8-f286-08dc37c07f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GjMa5LsE33/J7aqqW5mQvrUaq/1g6jIGfvh9zUgJrPLNO98xEOOQSydP+cmaHKGBOEOXg+o/GZVJnc70aAg4nocW3FkkXec+shhcUhtOhfkxnKf/OZ6P+nzXBkUag7hDdRvJSpmnzsCZtVZ8cP54fEKvS9J5Jp3av31aESo27hQbR5XU/lLgQJKRhSsrTLqMSpQgJ7sDWv3H2pJ6xrLJYdDLFWzWPIDkEw1fT1QiMPBbFqSnf442nWVVEayL/9kGXqVRjw1/maLQEUa14l4gixO5olIyishIM82jwjifvxkFcb31fxOo3smbQFij93wuwSwm7EgoBM0GDf5iXiaiq15TW8R9HQHahgEyX/tXnILcRd/npNa5S6KQi+eAPNo38Mq1Q8Y4bWE3D8yqXfkbBTVYLu7leDlAy19gmwyFsRNT5U6SgCbJcu/kFpspk7cyDC5m7PlUMEtFvDmDYqEVjQh1l/umRIrVJzvu3D0JqYflH5QYxUhRczUdtr16M0WH8d5XzBMuxvtpRyOYNHR9QU/X/FPJdt3BJa/+2xMY7s7ZVghYKsIPqUJ8pULWjVuk7LOLfArnxKrfsWCnvdVY6Q4m/Bv5EEkG3j/+7ripsozgM06akTGLfRwBs4b9OOYJn4ZSxuNYuPuPo6m+jyoKXMrXl+afxQ+mIG65blH5ZPbhiNhMEv27bmLhCQ7OmHTeLzOj/Wb3b5HHBL+p9a8fD9QCdQ4x1E3w8otIMoSELLuuRGsblKKIZyQFXqNybV8r
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:29.1715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b00670-7440-46e8-f286-08dc37c07f98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

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
index b19871b7e7f5..6d5ec1c4bb05 100644
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
index 0e983be431d6..2e6889245294 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -37,6 +37,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 	[NHA_ENCAP]		= { .type = NLA_NESTED },
 	[NHA_FDB]		= { .type = NLA_FLAG },
 	[NHA_RES_GROUP]		= { .type = NLA_NESTED },
+	[NHA_HW_STATS_ENABLE]	= NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 static const struct nla_policy rtm_nh_policy_get[] = {
@@ -764,7 +765,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 		goto nla_put_failure;
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
-	    nla_put_nh_group_stats(skb, nh))
+	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
+	     nla_put_nh_group_stats(skb, nh)))
 		goto nla_put_failure;
 
 	return 0;
@@ -1188,6 +1190,7 @@ static int nh_check_attr_group(struct net *net,
 		if (!tb[i])
 			continue;
 		switch (i) {
+		case NHA_HW_STATS_ENABLE:
 		case NHA_FDB:
 			continue;
 		case NHA_RES_GROUP:
@@ -2607,6 +2610,9 @@ static struct nexthop *nexthop_create_group(struct net *net,
 	if (cfg->nh_fdb)
 		nhg->fdb_nh = 1;
 
+	if (cfg->nh_hw_stats)
+		nhg->hw_stats = true;
+
 	rcu_assign_pointer(nh->nh_grp, nhg);
 
 	return nh;
@@ -2949,6 +2955,9 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 			err = rtm_to_nh_config_grp_res(tb[NHA_RES_GROUP],
 						       cfg, extack);
 
+		if (tb[NHA_HW_STATS_ENABLE])
+			cfg->nh_hw_stats = nla_get_u32(tb[NHA_HW_STATS_ENABLE]);
+
 		/* no other attributes should be set */
 		goto out;
 	}
@@ -3040,6 +3049,10 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
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


