Return-Path: <netdev+bounces-75439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077E869EF3
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E82290C22
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11A14AD20;
	Tue, 27 Feb 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jVSUyOk7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12714A4FD
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057909; cv=fail; b=B+DzJmWRXIaRavUmXEGOFBbzyxWzGdnXzaaq4Q2PNGX53MY3kTbrH7ghdp8EOhQtnkR+ZqLW7kJ+MY0yoL6i1TjfO2oT51xlooOcXHhk1Tb4PemxBDhRz2evn4/iKeagm6Jf9mcwE8AdaJyUoZairPnDmv/UQfKZy8T5lGUozcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057909; c=relaxed/simple;
	bh=YcPaVQaQO/9PS4ZsnmUuvWEXupWz42NNLpx7kEpHaHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpf6auiujyKaOm1KCU6YJ1rMUo1sejdMwFhe8wZsmRlPcjIMYlnCBajV1N+LgWNmaQbPUNDGRXygDYVpHDJqQeWGy12mGuW+JsrYE3GO4ot56Mu3ZSSMjINKbCkCFrpheofbDUq2/2NVHfEK0/qR9Y3/i0dCyzaugoYczvea+38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jVSUyOk7; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUS2lBLXUN5HUafaHMtFlEbabqQDO3w8TiErkTfMrD7bZbBMm3qnqck4iufBQEp1HsIQOSzDBJ87I/8BlOMaIqDOrF3eLSC/u0EqhLSCSr9vyavNtYO+ixFMziaMjbBzz6DiCT1MPbi6m/vlsfjPS+pzg9etM9zRD7YndYVw06YBj2rvFA/b0YwojZqpwJQ3GMgWDvWclsFWeX16GLULuaxd/+Y0gM2rMZ+0vfbXYDOfT0EUpdq42NzDmfQ3E9fd4ACuG6380flruN/axcJENWZAWJbiaQJeAVd6rElOBgiGjSJ7RAR+TVcIWhhvdlAXVCI6cIBAgE7aB3rv+fr6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQvQZQRHOhfCSa0I1LUIhik0nDtRAPowxqTn37Dpa7Y=;
 b=NMPMdEOoEG1szNE5rVBC9Ym0mSFqbpXndDK0ApTFGxfg7G7yKKXXi/cbdCAU/v0KYFiFwvEzhhwOvX2Vie1NvCiHvWS3ZUrn6UAuJ3zVHzQ7SVmAt4OBIFcvbb496yE9NJ+WuIWssS6iTEzge7ihd6Y5ToY8Rl/9lxvkxdqKrRTlzo/tPzh7jj1lsehX7rd0p7vsW7NYPJc4Q1sqcJTdsHw6WlXoY0zZYMdAz/PI2Slb60KtD2VkA10N7Ux60F3ARhYd3DSidJnj61/ZulQt/me06nLaeETbi66nTE8L9z6J44+N0L8SxwNAFSyW3fTtCKgbsVufsnHd9/zUBMm+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQvQZQRHOhfCSa0I1LUIhik0nDtRAPowxqTn37Dpa7Y=;
 b=jVSUyOk7LrzJHSuwLE7g3VzzhALFX085ldjNEIel+hNH4nVLacNSdwbB3yqqnNDOhu6LKRH/QW9YFXrmTO4pIE8H3KFzJqeNe62hne5ZZHyPh5c4vp7a3eIQgCjNYE7W5n/M2XpsV3YqNyoB3YAOVkNx7IoYtcyd81rqu3Wgfvp5qACDzYjVkyzi6P5F5EXGgNkjGgvPvldjsG2N3K0HMwVxoDDqFZiIZllavDcKdycfmUNiVqT1aQFI3R1ODac57eGmL5WMaHiEimBNygFlmQTlQ9jyCjOgJXa8xeNL+mYk1OlkZfz0g9DrOmCKOWCTPoEd+TjiYHPdCfi4wRMuTw==
Received: from PH0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:510:5::18)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 18:18:18 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::a3) by PH0PR07CA0013.outlook.office365.com
 (2603:10b6:510:5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:17:55 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:17:52 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/7] net: nexthop: Adjust netlink policy parsing for a new attribute
Date: Tue, 27 Feb 2024 19:17:26 +0100
Message-ID: <a0d1b760391800101e4554981b1f80bdcbf352cf.1709057158.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: fe65d4d4-b921-4969-241d-08dc37c077b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OyI5tGNRZd6T/CQmpxP7B2u3/zFV9wtXkUIa9xq1jUZ96yogwvNRGcckAU2JPOeOCplpEhsd4yhTJNKOG5RwFO02VGUrqauLAqM6CjekV6TB3GVhiqy1hvkXP1c052EQapKYp7eQHhaAiUT0Rz3c70p7VW+g14qftosvu4ERZdEJ1Oo2B3c7jfzMzHq9Yuh4szs/tOc2Aw10gJynO1/6CXHzdxDUErOhAJlhb2Tfbcf+kGjVqASAU8OsL5pTm/C2fn9kIOLBt15PHXZeupd0zC7JyYrtSrM3qM28itB9GKeNb8w4j6q6YqJmou2AsySQK5VXEK3M872iCtVINnn2d1sZcuJ48w23VqmTg9DcHFE/np+CHLo3B/3bFxMc+U/tsaLGsJyqWD/svhp0poESx5XvVzFooqQaitO8hsw2KZbx81hgtvXbr6OYXd2jiEVWERMxPBzsAujQKnV7nz7bBa8qE7WTMCh2uWhQNWioIHyCVdK/08f6Aa0spzQatu72j0HmUradnCxuiQiDhj8tiiTXEuMRR8P18AYteN8jsbHV30Pb7Cz3k1suA28+csyNK5Wy8vFiwefCFi9XFwGDPbysjTTAUwQ4q0/l0RH2tbx06nRktEbKZID04dPDXBP8oRjoieGgvLqvvN1o6Q3IDPH1TGWONOn7BxFYXH9SpSmjZx14qFt0ikQAmBOcDdYvD8PxQRxWAWsdkGt2bHvqLzcBBg6bKokxmUwvKgGpej6XmaMZQ66mXEnQXofq39fg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:15.9838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe65d4d4-b921-4969-241d-08dc37c077b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

A following patch will introduce a new attribute, op-specific flags to
adjust the behavior of an operation. Different operations will recognize
different flags.

- To make the differentiation possible, stop sharing the policies for get
  and del operations.

- To allow querying for presence of the attribute, have all the attribute
  arrays sized to NHA_MAX, regardless of what is permitted by policy, and
  pass the corresponding value to nlmsg_parse() as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
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


