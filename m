Return-Path: <netdev+bounces-77901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A088736E2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49271F22468
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535380026;
	Wed,  6 Mar 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oq+SnjVw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96783A17
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729438; cv=fail; b=lgFr3UB/IduPMah8F/T6NoupjIhZ0zDNdZ5GY2yxxmd9nXt4eM3S2HegHE7+G5wHTT9dXJrPmiA8vkQr2vo+SwsPrqRDZasVhJKLKUd/S35JaqILsPEKfQ88GPpoHEEQRGFP9Qx+rw9BfVt6JLfctWIYAWIkic3zsIbddvOb2v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729438; c=relaxed/simple;
	bh=YW+Pw2Q4sNHRqwnJt93AlWVbEKvXM3yNaERMlLYQ6m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1gp/uYZ6VwySuVxhvD+ZLUtcaCOsBgrifh6tn4BOJj8cX2/Rkq4BVbtpBxnTl2S55s/eCEqa2uFxW2EqwL1vuyvMoQuCDZG6Z1xsZaq+xNR78+me12DuVGttGKmTsX5b3mwgW8BSUPm3A6j65teSd6GwTgZlTYq+d1/3Z1Uulc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oq+SnjVw; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtJ1C52hZy04upQjM92Y1NdphQRrPXaZWhEmH9Vhtw15rLF23iXfdNjmfyoWVgmgzIt9h7TBOnmgoYEb5YZ094H9EJ8gk9Dh7EcLc5daB9MHSML8R3T0l9hDugekLb0FtQVxz2etGADlpvXJu5Oy90sMS6Hcb/wvyUKTEoKA8qnRgBgkFQKHToDrfynY29nkKKU24XeCWy/LqwjTlI1umTiTigsbM2gg4DeJjoYwqfriO9zcBLsVV3MKqdWNQQIPd/qR3ZYFOwP6eVhyBQpUoe9VKKIXTo8sQ6yOmxASGO/nk73d5jGMu9eCobJ1cuaBtYsVH0EMfwIpZalBr1fUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KNiW8V5gDSRXmkjYBaDWvZMRhOtGOAMQSTMicQAHGQ=;
 b=DeX7p2h0OqAq9h6pOEnrPfGhknf+gajs0SzGIt42YTNF+INZbHG//Z/P1jG0dKoC6DXmk8CDot7IY8FxY7xXqJqdoVWQ3hlMS9t/7y5/YdOxnifQMSPFthL0Bllef7x9zPb5eoUxo/GLaFjQ5Fntb1bHLCIuXlLgy7nt46iHlqxUuIAcJcJwSNBk8ygX4xOyxEYUWmnIIZeUQbbvqPV4+ygiOhIGf0AD5oYCBZLWlVN/gkRXgi8tbZkcrF9QXkyppzmT9+K0pUgrNMb6pvYn54c/+/d75YwavWBFCP5xK5yDaWatYt4WjtuoWC7AJFrRTeJDOmYatKjjeqT34rRcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KNiW8V5gDSRXmkjYBaDWvZMRhOtGOAMQSTMicQAHGQ=;
 b=oq+SnjVw+UoZ77+fGeJiMLr/XOHOmSUHxk3A5sAEXpIwGcEiXi0YvhB6hxW9NUTQCp6SxdW2+AUkiCUBkuDq5rcSw6kNlaHc8LzfwMcg03BeSHAQUEtZHUPy5eLKvEiPtZ7OAvQk8j/qtZJ4b0XJedq1ZO+ONXF5YLZChkB3fZ16n8FaiJvYjmbyqgDfU1ZU4uevZvDcB4InOar19ytorqDeDgrscOeUG8fKZtCEkPMummUPV7DVMD3csy4WAwxUurM5Wjyv42G5ScgTrS1hlxPJpPseTuqLXC4IlsMLxeyZNQQxRWIx3QSLXFHaVn9SXlDG6oEIcKdLD2DBpmqVIg==
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 12:50:34 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::b5) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6 via Frontend
 Transport; Wed, 6 Mar 2024 12:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:50:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:08 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:50:03 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 1/7] net: nexthop: Adjust netlink policy parsing for a new attribute
Date: Wed, 6 Mar 2024 13:49:15 +0100
Message-ID: <a76b651c734d81d1f1c749d16adf105acb9e058c.1709727981.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 057b31f9-c1dd-48d6-900b-08dc3ddc0315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ieIG19YpSPZZRAg+uZK7ofVVr+pvb1fa/68D7h9EW+DwqWEL6wNQax7H9poj75QiM4jKSfG1LVU8s/bCN61qBzqitDjNQULyBdpHTcby+ZhlYSdSoUk3v3DH9ZnZpy+fvKkGW9g19ZP8x2QxHHI8yhCQcG8sxJFzqjlcldQpAMZp5bENPXFzsSqY8jxzbWzVXl3TZZs1YyCiwZlMkoTPnjVsT/2EPgydGLhlNHR7h9JulFxkR6JWGzyjyXo49DWOTTjgYwK6AGRgSElkOGBdejPTrYiAY4v6HZ0v1L79b/P//Mr1qL64VzYQSdMAkmQDl98DB9phDqch6s8QwmtWdw3ITrwPja5Emh7RXl9BXXXQ8ROAcfPE2hK30VrVYUwv7KnLRYUunk0OksgoYK1BaVA7p4rAtcYK6+SSXYB3350BwYWUKv4UBw7T3kNHRXWioLwwQfYKJ5xk6Qoi2VAtGQ0ijjNQYtvY8TyJ44OeZ80LnwS9N/ZbgehLSxwrLPop5H4MugHAXQe7203lFWxX5AYgutax+47kfr7X/QDUZmINSYX72tHmcSK627nTLkUdDOasF/9wVE+YG5+zsm2eRv3M0G7cOSxZrYtBNsBFxMDL30F5jBD0k48zqypGA3RfjQc515F2yBsfbocP745LaauHsvwXySCg1G0gdZSRbB8DwObz73dSNZOM2lueZl0Cy2usPfpHbLPbzghDgWcGDdPnEaP/Jr5m3WAKxa1hWbK1Q/LNLaOoEybkjIXSRBpX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:50:33.2674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057b31f9-c1dd-48d6-900b-08dc3ddc0315
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

A following patch will introduce a new attribute, op-specific flags to
adjust the behavior of an operation. Different operations will recognize
different flags.

- To make the differentiation possible, stop sharing the policies for get
  and del operations.

- To allow querying for presence of the attribute, have all the attribute
  arrays sized to NHA_MAX, regardless of what is permitted by policy, and
  pass the corresponding value to nlmsg_parse() as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c | 58 ++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 70509da4f080..bcd4df2f1cad 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -43,6 +43,10 @@ static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
 };
 
+static const struct nla_policy rtm_nh_policy_del[] = {
+	[NHA_ID]		= { .type = NLA_U32 },
+};
+
 static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_OIF]		= { .type = NLA_U32 },
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
@@ -2966,9 +2970,9 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-static int __nh_valid_get_del_req(const struct nlmsghdr *nlh,
-				  struct nlattr **tb, u32 *id,
-				  struct netlink_ext_ack *extack)
+static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
+				struct nlattr **tb, u32 *id,
+				struct netlink_ext_ack *extack)
 {
 	struct nhmsg *nhm = nlmsg_data(nlh);
 
@@ -2991,26 +2995,12 @@ static int __nh_valid_get_del_req(const struct nlmsghdr *nlh,
 	return 0;
 }
 
-static int nh_valid_get_del_req(const struct nlmsghdr *nlh, u32 *id,
-				struct netlink_ext_ack *extack)
-{
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get)];
-	int err;
-
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_get) - 1,
-			  rtm_nh_policy_get, extack);
-	if (err < 0)
-		return err;
-
-	return __nh_valid_get_del_req(nlh, tb, id, extack);
-}
-
 /* rtnl */
 static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[NHA_MAX + 1];
 	struct nl_info nlinfo = {
 		.nlh = nlh,
 		.nl_net = net,
@@ -3020,7 +3010,12 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u32 id;
 
-	err = nh_valid_get_del_req(nlh, &id, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+			  rtm_nh_policy_del, extack);
+	if (err < 0)
+		return err;
+
+	err = nh_valid_get_del_req(nlh, tb, &id, extack);
 	if (err)
 		return err;
 
@@ -3038,12 +3033,18 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
+	struct nlattr *tb[NHA_MAX + 1];
 	struct sk_buff *skb = NULL;
 	struct nexthop *nh;
 	int err;
 	u32 id;
 
-	err = nh_valid_get_del_req(nlh, &id, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+			  rtm_nh_policy_get, extack);
+	if (err < 0)
+		return err;
+
+	err = nh_valid_get_del_req(nlh, tb, &id, extack);
 	if (err)
 		return err;
 
@@ -3157,11 +3158,10 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 			     struct nh_dump_filter *filter,
 			     struct netlink_callback *cb)
 {
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump)];
+	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_dump) - 1,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
 			  rtm_nh_policy_dump, cb->extack);
 	if (err < 0)
 		return err;
@@ -3300,11 +3300,10 @@ static int nh_valid_dump_bucket_req(const struct nlmsghdr *nlh,
 				    struct netlink_callback *cb)
 {
 	struct nlattr *res_tb[ARRAY_SIZE(rtm_nh_res_bucket_policy_dump)];
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump_bucket)];
+	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_dump_bucket) - 1,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
 			  rtm_nh_policy_dump_bucket, NULL);
 	if (err < 0)
 		return err;
@@ -3474,16 +3473,15 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 				   u32 *id, u16 *bucket_index,
 				   struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get_bucket)];
+	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_get_bucket) - 1,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
 			  rtm_nh_policy_get_bucket, extack);
 	if (err < 0)
 		return err;
 
-	err = __nh_valid_get_del_req(nlh, tb, id, extack);
+	err = nh_valid_get_del_req(nlh, tb, id, extack);
 	if (err)
 		return err;
 
-- 
2.43.0


