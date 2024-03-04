Return-Path: <netdev+bounces-77221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D7870BDD
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23021C20E00
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8184E54D;
	Mon,  4 Mar 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mp7muv1i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9C79C5
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585535; cv=fail; b=OSG/YH1ElQrWn9PcxSpvOk6hm/yppv4MBeyeXR66xQamCEUiI6u+Ms/opFoEnuf9DxFJ0HQvleLNUaV6fw6aGO5Seu6uWJPRlY1RiYLNKsoTn3uXa6dFaNSj/VolN1ecNZ/rknYlUZ5lz7LqRR3TLxyrzHxjh6G6YA/d1SsoeJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585535; c=relaxed/simple;
	bh=o83a7sm3Ibbwr9S7qDKmoULgydGq3op1OLmw/eEEdDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTqS6+b56Hc6GFucIcWWbBjs9GImriPP2Nc+9sGUYQmsJQvUyyW/nikS0DvLEw/N8Hi4HHVTAlFInf1E9UqH7tf24JrqSfzXi1GeOlCOCDaFbfPnPkAIhe59D4NBONQ9Gicrle/sOp8m0GjT7uoCwluo50JzOsznSxhKwRDt3DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mp7muv1i; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUawjy3/ID2W/uy4B43dS3E7StxinOydPMKS24kKGTQR3Ye8LMhgOXJkmhXD4Kv+EzH+pJfHTC4AfgULdNDOa3vEx+4quAHG4L+mRCbaWCFsygSK8Fypz/amZ5h/fmRmJZtfvRdKiIsFALKhbY80EgzzvkdQOtOxx4bWXs1BZTe59buaqKbiaBCGobe10WU8VYQZeutuQGfI+pUrmGEMpPS2eWUoHhBW3jsXxlBG1K9VanF0MW2XqajGQnZNJcPvYTsrCBdbVY0qc9cE+PmLel1kDxL+4kZzPQfWAmpPVRpddhe/qNEmv7LQVyF4yJkt08NPqSNfVsZHTQQ6zc6IdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9kjhm+mRSPWBT1Dsit0wjle+8KfH7MUTyWXfoBnXIk=;
 b=aChEVTa4CmFL48w4gfZqTmZXhnMDG8bqS0GOp6YuKCvPrnncBHbMa3WuCT6tkUTmenLICWKSm8smg5oVZFfp3Ns8s0nBv8u+FK1DAaYXf3i9EVNdO3r7zX6mdJKTqk5WMfcps0UPEnHJEnaF1Cus6XniCnlDPljkesKJ2OZBEy28cvPJv2HrwoZzoX+pCTuA+uEMPm0wlM3mh27GSfDD2TvXdfbMLLXWJN0BoSc+OBWjVxbD8mUfhIuhylxZX9/R1Ty6IkpfJEoLDbMfivypnSu6/nhWnIgdzlAFd2W/RNP7HKMK5Mg7C2r+6mnTESUUdFb6OmK+8GZesVJ54Icwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9kjhm+mRSPWBT1Dsit0wjle+8KfH7MUTyWXfoBnXIk=;
 b=mp7muv1iuJsnn23Yoc2HC8jU7klhx4AeDdyA7kSz0l2WJcNWxyQK8oPFHM7cRPvqBx6C8TTHrdhhehMjA0b9sxQ1DVrTiQ6HRJQhwjUOWV+1lXtc7Sre65XmJpWna13vepRvjqlAMycEW8+/DL6BatejRCe0n3pp0jgF7wPCBKtPyTqRtlJKu4uPw42e2C25NBr3rd+1O3OFCdQ32P8ZMOfcznusIO04G20LYiIyOWV2qN9f9Lxs1iyw7odpma5MCptaFjtZczC9orTLWt/A2B6AYpVtp+eJMneqdw4We0f10UQKpCK92GAIrpWLCKks/advxW02SjuIbf/zHKBi4A==
Received: from BL1PR13CA0367.namprd13.prod.outlook.com (2603:10b6:208:2c0::12)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 20:52:08 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::bb) by BL1PR13CA0367.outlook.office365.com
 (2603:10b6:208:2c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:51:52 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:51:48 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 1/7] net: nexthop: Adjust netlink policy parsing for a new attribute
Date: Mon, 4 Mar 2024 21:51:14 +0100
Message-ID: <ef1506fef5b38f92fe0aad82e6dd76084167392b.1709560395.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e414a15-9ae6-46cb-9687-08dc3c8cf4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H5tO8PnnWR5iuAc6R7m8Zg4/fcDIvGQGzeqcwqMbfnpHVAuXP43rQoeTW1DsKlNGa6i8jOFkwXOO1LQyKm3JKj9sc/LeNNZ5erGLeM6qpayAYRm5kYSEM8ni8MazRLU595JHVE2trVR140KiWyXxICPHhCdz9GnZtsOQ7Kms9Q4Wz+VCEmSV7zyihxNZ3SMZEQ1MlEg0qnyJBLWBT8+niDyPC2Itjgkdm2qeBOg79edBB1nnWAszMC49Y7HPhozoe+yPL97gpOnuapH5qemOAHDVVYnMDPnBwruGSJlnJchUu+WU94aaEE9+1l/4Jwu6ht03NWKqT9k7FX974s3ScPRGQ6wQHuRykaDRvzqJBUjD48qwFUfYEHpIdGwT7RaYjfoKy6YP4kTOsizXonuHzZRO6fUiKpJrEcaK39+xzyQoRhwMHyjKFWa20bUnbRQyL8ZW014EGJQDHhNA3/hHjnzewqlU5m3dSyFxdN2Mi58L8Bv0P9E/SanIAin6Rbdw3w85cNGSKJfcViDvLx1HuvBkLE6N/CbUe5iZqit+NsOrzlM4LC4fSq8zdy40Vs8GQtqF/i1yvQ01RjNrwUYiCTjXYtjgpNybhgHqGKubKA2Kx3wdj0B9yKRwpqMGrW/9Oj5ZshlOaj8WcSv38Il/KjveXTUI+/joMARjYN59XJP4LEPdt82FM97EXjHLh6YAHlV4gp9mPvvOXvgszm10hafPzk+Cta/hVugaKaBaswpNRndS69OjekoX8+n4iFCk
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:07.9708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e414a15-9ae6-46cb-9687-08dc3c8cf4e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924

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


