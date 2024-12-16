Return-Path: <netdev+bounces-152330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618519F372A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D0616A770
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33562066E4;
	Mon, 16 Dec 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VN1aJPZm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CF2066DD
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369238; cv=fail; b=USf4BP2XuO2yOh61ZOXVFmX9gUPnKK82jTIwNAamdxEAwyneeWp4eR4NFZXFvNurmvD9iy1aXVdauf0JsRwr5DJqwUUdBUKrKXZrtZkO74AtY3K0dqxSv16L5oIt/qjGrvyYNq7/IPlktD5tf7vV/3IB+4mczjvbUv0KIF0fNiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369238; c=relaxed/simple;
	bh=NpV/sxqGPasJdG8gRODm4sHcdLODHk+xr1JTbGNPDKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSqalXZ9j7r/BqiQfMu8Ts39mJMquNGEH6Ge1cii6dgNYd9t1BTLNZl3G/RF8Vn90Y09wBaQr0Hpxm2L/9akekJdJHxusSk43KUELHajreHqzhCCK4zcp8glXKc7XDjHQ8VMnoXBLBHYvVB6N7CpEns6+6WdGL3TZQu97tWWBKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VN1aJPZm; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvZrpJaJME4leYPFAOuiVsywA57ZrARQx2yFRLew1Eksqg+0qWUF1gCIh0vhOS5MA6T1JLxBb00hHaUHuUK9dB90+CqaKgwTwIrWDFFBZnxToERo4uWa758zhakxmfviTn1qTwxMzz9+CMTL1p4pGod9TKbiJZL0kKo19sr2ACo3UjtT+11wOizWdR5bYzkYkzWNUV7OETZWNbZ5ilFggItN2odM6a73U2T1gvSiPl61Yw9ALprqKvxRkGZmEGtPluOcabzd4IDFAgkCYyC+3z2iC0Ze3KT6knTq9WEcL575wtQRT5eiZfWESfvGT91SAPx3SvJsAc8xTq0alL9LLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgvMOCIEsW719Da53AHv359ceb50ndHSzO/SmnFV22U=;
 b=CcPX9p3125X1f1wccRehJzPF2dCaUG+mph/oPnLItj6YnT9+XTjbckye6fGD99y/y5erdL1oFOdNDm/xF4zh+DTfrPD68EgJTcVeqcccAs9NRld9xBIKESWCLqSn+8c+kZx0oI8Di+aNfcCLoH6GZiwJg6y5ZbRFmpDhl0MfuAOEJmsc/cgr/psJ1zDNuYASxif/BJWbiTJuqeMMXJVuUSmXRWcZO/hTGHpAembAlU/rhL+vECQ6Xu4QW5dqyDrjyprqQEtBzdIZg7YKUlObctspMB61T604zTmh4vW01945KbziAYUzteR+VYs6dN/fWr+49qXK0sPsjKrTe8fYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgvMOCIEsW719Da53AHv359ceb50ndHSzO/SmnFV22U=;
 b=VN1aJPZm5BrX8jOQi+ImvXylhAccszqWqQns0y2caiHHLPpWMeOai6S8b20VJpJKxamlSxMMEQox39RKdQ2NZKxfRcZkN5G5e22iVNAANFWCDmG8n1E+XWYpYwTyONZaZngcTV67xoOi8bdfPgVG4qTze5S+gEge02ixiuVtAuuYfeOMBQfKgdRXl7Cvm0hnF9yKcxZm8qzpgP/IcpJVbflXfNswEXdAh9Gn5joCIt6j+Yx0XScP5KFc3mp9csbhSdnHXDpv1Y9yWse9kHE1CURCmMHaetW3lAoqzI6B0aXdz3Cgx+P2LhIaiyl7PCo1wvwPEAglViasIXuQGyBC8A==
Received: from DM5PR07CA0105.namprd07.prod.outlook.com (2603:10b6:4:ae::34) by
 PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 17:13:14 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::9) by DM5PR07CA0105.outlook.office365.com
 (2603:10b6:4:ae::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 17:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 17:13:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:13:02 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:58 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 6/9] ipv6: Add flow label to route get requests
Date: Mon, 16 Dec 2024 19:11:58 +0200
Message-ID: <20241216171201.274644-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
References: <20241216171201.274644-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: af1115cf-0321-429e-fb0b-08dd1df4ecd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvEFXwzpkIXOTBbLghgx9XYEFimrPhwyH0Mj28wawVPFwPY22Ndt9uzZdSAP?=
 =?us-ascii?Q?rKM+ynMJUFGa0/9SJQx2I/ynmjuktog35wN11LOaDp10QIHq93SpiAwRpeEf?=
 =?us-ascii?Q?MUxNlmX54/y8+OzkbOzrIoguIWn8j1hVMKQMUVMdLYXyRK4/hG6W8UvvwfB5?=
 =?us-ascii?Q?N9c0UkgY7grJOmNJxgEyT77D6ahUfQJHr8oRVSQe3ZBUaALuOfxdaAnBPo9C?=
 =?us-ascii?Q?Mtz7PkbMtYU1Cc2NZ7YqmH8e6zUL7cFwD+jMgzi4mHOHc2uALZaEbFA6W0fz?=
 =?us-ascii?Q?siAYkYSKZcIPlDyXLckoP56/ITLvZuhp39+w4LCs2iKz4dd1b9mhzvRJAOql?=
 =?us-ascii?Q?0fkVkm5MSiPVbNv1Y9cWjjT+p5ZDB93TLTommbxAs5qEmmfoY6g0gIo/w05O?=
 =?us-ascii?Q?l/+MQ1etEFQjN5XQlTifvty9jriFPcB08jbIHLleP6W/ORdMXaAdnXvoYYv8?=
 =?us-ascii?Q?Qx6amAWV2pJe51a2lpI84aP0AVCPxqcaTSni2C2DqfhHco+31Md8uId1Lnoq?=
 =?us-ascii?Q?+Ti2pSSfsFcO7x2Pq0Y1l5bVJVEh0TwLjNtscOQDfu6K/FxoV4SqRBYaIBLS?=
 =?us-ascii?Q?GQhstrU//iBtwwREY3VahCsxiMpu31HOxRJfcZz6wYwIc6TVzoPS22sUZYN0?=
 =?us-ascii?Q?chh6ugHvm4i+GUSDbmJgf/YNjnZ0JtQ/0oQZ6FXxhhV+LnuK4tX/RaiBGzYs?=
 =?us-ascii?Q?8LEzq5dify7vdc/0S9rE++uQWSs6xdAjTv/k1trHsjpPxpnvObSBSHmvTLlB?=
 =?us-ascii?Q?7p37hvDh8EVi0ZmqYw5vA45Tn/Cvvlb4vRYFjKs//zTVSQYdxkmpEoX6+kGw?=
 =?us-ascii?Q?LP6q6lHI+NVAjQdu42r2fWQ7tREtwqPhPpCD2MKhweQzc3IeqrDOhfEz1seW?=
 =?us-ascii?Q?/Rom0DEzc5uoCSbpHXgJrDeTxrIlvwbmEakeutubzRz7ydxAuKJQOrFxygaU?=
 =?us-ascii?Q?qpZUDBs7TkYMMZ9kWYScwm7TPSf5yG/bzHqHOra+F8uoXhpsqNz9kEJUnxqZ?=
 =?us-ascii?Q?zDLKH9RyNjby7BDw+oPu6v5z7TOCgQINZSPkcx2bEhLoUHHAyprwGDONR6sH?=
 =?us-ascii?Q?u8SEtoXwmqDv6oyfOL8hygaOxD/aCRAaPyS+SF5dQgddKub17KwYSX3Gzv8h?=
 =?us-ascii?Q?ib/nfHS+DdiETFtI/Vp+WR2+B9eeko0Qu1GF1wTAMtKUQuebjIr3hcc68uHY?=
 =?us-ascii?Q?53GV+7mEs/+hLJU04c3YuLpDQaA2p8f0tpz2u68iW4YiNIAV32b1ukWA4NA8?=
 =?us-ascii?Q?w2Y07v+kwpIpSfNhVv8YYeoWuET6oTjDgbT4dp9Ub8WEwIrmd8nZO814dEQp?=
 =?us-ascii?Q?rddyilJVR7cqC/sBvck4A32S/suCQCOhNHf8XCZiK44Dehb2WPWW5X2Ko7PL?=
 =?us-ascii?Q?8HrH20L0e+xr06dDiMT7e2fBkMEKvtDKlOxOGQt2ZgjDMNC9MylzB6Lf+Q26?=
 =?us-ascii?Q?vvha6q+n2xIyfjRw8wZqq79KMc8fxKCwSLhQEf8AxYQvR3vQbZNuxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:13.7925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1115cf-0321-429e-fb0b-08dd1df4ecd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

The default IPv6 multipath hash policy takes the flow label into account
when calculating a multipath hash and previous patches added a flow
label selector to IPv6 FIB rules.

Allow user space to specify a flow label in route get requests by adding
a new netlink attribute and using its value to populate the "flowlabel"
field in the IPv6 flow info structure prior to a route lookup.

Deny the attribute in RTM_{NEW,DEL}ROUTE requests by checking for it in
rtm_to_fib6_config() and returning an error if present.

A subsequent patch will use this capability to test the new flow label
selector in IPv6 FIB rules.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/rtnetlink.h |  1 +
 net/ipv6/route.c               | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index eccc0e7dcb7d..5ee94c511a28 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -393,6 +393,7 @@ enum rtattr_type_t {
 	RTA_SPORT,
 	RTA_DPORT,
 	RTA_NH_ID,
+	RTA_FLOWLABEL,
 	__RTA_MAX
 };
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 67ff16c04718..78362822b907 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5005,6 +5005,7 @@ static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 	[RTA_SPORT]		= { .type = NLA_U16 },
 	[RTA_DPORT]		= { .type = NLA_U16 },
 	[RTA_NH_ID]		= { .type = NLA_U32 },
+	[RTA_FLOWLABEL]		= { .type = NLA_BE32 },
 };
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -5030,6 +5031,12 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
+	if (tb[RTA_FLOWLABEL]) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[RTA_FLOWLABEL],
+				    "Flow label cannot be specified for this operation");
+		goto errout;
+	}
+
 	*cfg = (struct fib6_config){
 		.fc_table = rtm->rtm_table,
 		.fc_dst_len = rtm->rtm_dst_len,
@@ -6013,6 +6020,13 @@ static int inet6_rtm_valid_getroute_req(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
+	if (tb[RTA_FLOWLABEL] &&
+	    (nla_get_be32(tb[RTA_FLOWLABEL]) & ~IPV6_FLOWLABEL_MASK)) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[RTA_FLOWLABEL],
+				    "Invalid flow label");
+		return -EINVAL;
+	}
+
 	for (i = 0; i <= RTA_MAX; i++) {
 		if (!tb[i])
 			continue;
@@ -6027,6 +6041,7 @@ static int inet6_rtm_valid_getroute_req(struct sk_buff *skb,
 		case RTA_SPORT:
 		case RTA_DPORT:
 		case RTA_IP_PROTO:
+		case RTA_FLOWLABEL:
 			break;
 		default:
 			NL_SET_ERR_MSG_MOD(extack, "Unsupported attribute in get route request");
@@ -6049,6 +6064,7 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct sk_buff *skb;
 	struct rtmsg *rtm;
 	struct flowi6 fl6 = {};
+	__be32 flowlabel;
 	bool fibmatch;
 
 	err = inet6_rtm_valid_getroute_req(in_skb, nlh, tb, extack);
@@ -6057,7 +6073,6 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	err = -EINVAL;
 	rtm = nlmsg_data(nlh);
-	fl6.flowlabel = ip6_make_flowinfo(rtm->rtm_tos, 0);
 	fibmatch = !!(rtm->rtm_flags & RTM_F_FIB_MATCH);
 
 	if (tb[RTA_SRC]) {
@@ -6103,6 +6118,9 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			goto errout;
 	}
 
+	flowlabel = nla_get_be32_default(tb[RTA_FLOWLABEL], 0);
+	fl6.flowlabel = ip6_make_flowinfo(rtm->rtm_tos, flowlabel);
+
 	if (iif) {
 		struct net_device *dev;
 		int flags = 0;
-- 
2.47.1


