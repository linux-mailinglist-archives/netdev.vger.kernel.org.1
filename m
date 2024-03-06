Return-Path: <netdev+bounces-77902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2138736E3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B5A2845E8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DBE84FAC;
	Wed,  6 Mar 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OE1B/9PU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57383A17
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729444; cv=fail; b=j/xA5AWHd5PDlx/IMUX81IeE1/a37mrduEQbB0t3/IBeqUHS2RVFipsImtLP0svU6473Y6YaqKfhHa4k2NmS7Cv74SIYEqmhI3Kff3HiTUOxsq29qSuNI5Nv7EC6KDCA2r+6Nu5aPFDjHi87YgMvCBH86NinOkVXFN0Wop3KtcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729444; c=relaxed/simple;
	bh=gcEmvWJ2xAUpDohudtnhK2ACZt2MuDJkso9bJq/qQlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3oOoTgCvaGKWQBfY6rC0pza5OMHVVxFBzxTVks/x+8Dbxce7GEJJjXLu1zU6npYUV97UE0epI+2f5Xv7e4oIunTETx0mxkVNZyRd5aDfVBOGM31QCaDgaEQgpdJfd6i1aT0mK1vtiRfziluOzU33juwAIXYJWRGp7TxJ2S9Y18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OE1B/9PU; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK0hzIaILTnNxVxDKOOTXBO9sP3V8pE3EQhX0FMu1y24gqVxGbAcNSsvsFc7tsTY9z36AtQF36C3M5HQwpq/59gosKej90V38bMfAZPd9gsDvFBxxGoaC0h06AGOxx6gNxB15N6JYIWdbRFrmb/sGyp8pznsfN9tu8od7WYWxHtOqkzkZTinulVWwSN6KNSqKn4WSApGuAK2g4EG4WjqX354Ym8duOICuQzvbK7a6oWI3WvviQF/Il3iYVHHLrxlixvYII8MTXdI02T8lddOosO+T7wElaiNEjJnC9UMapBmF6BCs61annNNYA3eyQQmTdvU7bc1Z7eHyaA+NTVOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA/BOFop/K5jDNnT0tp8gmgLmajuWgwyaGXlsQNcwWQ=;
 b=lhMggf9TPtv+bTteuRiFSg9qIaiUSS2+Aj3btxToFY9NfvB7x21rqmDAj+ki2H8pyBEaPwDRIgUzCijbDBkHOyDokjHe+LA3j7tstIkN88fWVDMWdHNybEy4QvXmiZmMHkNhDgPz4IHKDaBMxCI8iDWsuvBlD0wB7HTXTS4X/FS+zoYX2nxZHxsXhVgN1na3z4zJ+DZ3PXqjeUodtIbuEmOYLnrBZWHQF/4wwfbTDM8ZdiJGjaaKMKv3KD8kZPKACzqM8HGlDjdRHazKQYNymJc23TftZjWdkwQJO0Xbjo/FFTcc2nr0PSIZPXhXvvQ+5hUlpMRwEZbqgtC/PLkExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA/BOFop/K5jDNnT0tp8gmgLmajuWgwyaGXlsQNcwWQ=;
 b=OE1B/9PUtB2HreGJwmED/03SA8RcMJQekIwwYUgUhIyVZ2RLNj7WVEy4g7Z63dAZfb+FXeszsmho4OdYR8JIxTt819tEcc7OBmNNa4vNaceQolpSDwvCE5N+dDTi8FgWUboChrA7Axc55DLYwJUPtSLz1cfNQAKguoQCy/AUByE3aH+G4bgTxAg9/Z9Mg8Blc7iz/NeCQCbuT39Itf4Nes1D/1pHcJipS+/viodvneDGXFgG80TZq2w0PCURysV9SN61NNt6WYuvRV7prdcPZ1wWx3rZ03o2aWEBG+gDj0tMCkio4huf801z6g7KlKRRGswUtt0X6WHDmgJhPDGKUA==
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 6 Mar
 2024 12:50:39 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::81) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 12:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:50:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:13 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:50:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Wed, 6 Mar 2024 13:49:16 +0100
Message-ID: <b66eaea956cb860a38c7ea77bf8571e386de5221.1709727981.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d69c0a-4924-4547-4007-08dc3ddc069f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SYxfuVnqPOnTEkCSp3D2Fq89TD2k2fRcQq3dWJypsjjAVig8z56Wizr2ym1rIDThiiLhFsJEFm4/4fTQGnCnUaD1XfgwAKmWd5oSSlavlKBcnyrAXcKZLWXqBv1e70utLT1lCQ0T6kGApvJ23S5EiZJkAnnDEHBrHg9bVoDfXQzOqRjAI08UUyE5aCH8/yV++noFyUTb3RECn7OUk1FRwr3fp0QIcU/8KxwqSX0pIW9SNwUBAsuFdr94mqOVv+Te4YcfSv+VLs/H+Oy2WA8JRHBx0L6r/P1b4Oudw7/hAS2bxFjup0LCnnJeu7sNiJb/iyPbYLKHIZfelUatwBd6/IUjbM/8xQ04Y2r/vr1k9Volo+XqAogV0+Sz2gh0hwE3ioanFaz0ZtKRt2xT6L/uuN/SEb+3PRg89OrdbJKCJ51KJLo5BzVmVN3Rqj8+hjVuu1ImgODdFn40z9qV0YOZSFJXyPFebHbgHk7FO3SPftYu/1aU0OSdiNFHv7SpG+zflSbV6okFN/a/gZXqeuVukOXLoP4ssbnkiyzXTX1mrWUbAp6NlJIRYfhIkmPOMeqUj8j4/lVtgUpH9Wb1GWjhuHNCjUpzkx9CNDuqsgf4XbfLHFX+xCZAqcZcva0tS07CRigmgdqroEfku3H/h2wWulR/avmYbZrcgrBrft//9lSxM7EjUTQzdH+5b9Dyl6yJDPvTvBne9JVGi23sxJyFO2le0YqfRzmYTVQgwx/psP7DAfU2/7eJy89cLhQd0fsa
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:50:39.2029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d69c0a-4924-4547-4007-08dc3ddc069f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502

In order to add per-nexthop statistics, but still not increase netlink
message size for consumers that do not care about them, there needs to be a
toggle through which the user indicates their desire to get the statistics.
To that end, add a new attribute, NHA_OP_FLAGS. The idea is to be able to
use the attribute for carrying of arbitrary operation-specific flags, i.e.
not make it specific for get / dump.

Add the new attribute to get and dump policies, but do not actually allow
any flags yet -- those will come later as the flags themselves are defined.
Add the necessary parsing code.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---

Notes:
    v4:
    - s/nla_get_bitfield32/nla_get_u32/ in __nh_valid_dump_req().
      Not sure how this crept back in, it was correct in v2 :-/
    
    v2:
    - Change OP_FLAGS to u32, enforce through NLA_POLICY_MASK

 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index d8ffa8c9ca78..086444e2946c 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -60,6 +60,9 @@ enum {
 	/* nested; nexthop bucket attributes */
 	NHA_RES_BUCKET,
 
+	/* u32; operation-specific flags */
+	NHA_OP_FLAGS,
+
 	__NHA_MAX,
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bcd4df2f1cad..576981f4ca49 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -41,6 +41,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -52,6 +53,7 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
 };
 
 static const struct nla_policy rtm_nh_res_policy_new[] = {
@@ -2971,7 +2973,7 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
-				struct nlattr **tb, u32 *id,
+				struct nlattr **tb, u32 *id, u32 *op_flags,
 				struct netlink_ext_ack *extack)
 {
 	struct nhmsg *nhm = nlmsg_data(nlh);
@@ -2992,6 +2994,11 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
+	if (tb[NHA_OP_FLAGS])
+		*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+	else
+		*op_flags = 0;
+
 	return 0;
 }
 
@@ -3007,6 +3014,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 		.portid = NETLINK_CB(skb).portid,
 	};
 	struct nexthop *nh;
+	u32 op_flags;
 	int err;
 	u32 id;
 
@@ -3015,7 +3023,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, &id, extack);
+	err = nh_valid_get_del_req(nlh, tb, &id, &op_flags, extack);
 	if (err)
 		return err;
 
@@ -3036,6 +3044,7 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct nlattr *tb[NHA_MAX + 1];
 	struct sk_buff *skb = NULL;
 	struct nexthop *nh;
+	u32 op_flags;
 	int err;
 	u32 id;
 
@@ -3044,7 +3053,7 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, &id, extack);
+	err = nh_valid_get_del_req(nlh, tb, &id, &op_flags, extack);
 	if (err)
 		return err;
 
@@ -3080,6 +3089,7 @@ struct nh_dump_filter {
 	bool group_filter;
 	bool fdb_filter;
 	u32 res_bucket_nh_id;
+	u32 op_flags;
 };
 
 static bool nh_dump_filtered(struct nexthop *nh,
@@ -3151,6 +3161,11 @@ static int __nh_valid_dump_req(const struct nlmsghdr *nlh, struct nlattr **tb,
 		return -EINVAL;
 	}
 
+	if (tb[NHA_OP_FLAGS])
+		filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+	else
+		filter->op_flags = 0;
+
 	return 0;
 }
 
@@ -3474,6 +3489,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 				   struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[NHA_MAX + 1];
+	u32 op_flags;
 	int err;
 
 	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
@@ -3481,7 +3497,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, id, extack);
+	err = nh_valid_get_del_req(nlh, tb, id, &op_flags, extack);
 	if (err)
 		return err;
 
-- 
2.43.0


