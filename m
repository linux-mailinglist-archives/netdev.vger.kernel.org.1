Return-Path: <netdev+bounces-75438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A8869EF2
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183C2290B7F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD9148FE5;
	Tue, 27 Feb 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dz8yUgjZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4AA14A4F0
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057906; cv=fail; b=IezAX4a85kn9e0h46LWNjwvBuu23RZR8qoHu3qeuucs0C9nbkoXy4S5qe6w3dchcA9c6OVa1U3TyaSkfszjWVYtXPRK5sxPaxJ3yU6h5apj6m005CZ/KWKr1xG3GJ4GGl0TZxBi+j88+BOVjNow/AYsJ0zKcSCGb1zGW/ag0wvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057906; c=relaxed/simple;
	bh=Zkj/z2ye/0nl5QOp7gsAzDDx9dDlSdLOblWG6mv1n/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W29sUL2FgnNguvzPPaS075FkkGI5aI1eb4ruksGIatWDDspF+Qc+sAmfM1xOj/mjsR4gmGANX+hrnbFAabUmcuu+hZ3ml2sXy02yclg427aDln3mey2/46KZGhluQCTfwd/43xbJgcHBiyYy+jaSaMYF0mT25TlfdWrS5z2Qjqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dz8yUgjZ; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLbq6zPKEG9GKea4l8MXHKxpdSoH9NDVUXXizvVpCOPuKv81aBPTA3PV4iaMSPwfHe5++O7ORCkehcnFdIOFe+5ezGFqAzfdovKHPtfdhq2VH/cRtdWhWuTBlOCGzeQ+MIousHYyq9VFL9uHAu83dTaTTJBvRcn+vhT8Bfd1tdwa3/eyXXojhANpq6WkbU7VvxCyBLtsedMAXiYRHdRrooD0ysb5+Hj2jm4zuszRC4gHnvEvqxe4MLC1N2XcfI5jTgAArEyUoH8fqP77c7ZJ3Rk6NvbzXBxxtc+Z6QDDLPheP0mkT6mg5j520ZmCqphH269bmgS2kiR2+0pB0ifItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=386vtyWJEsahvAYm6rqfpRN9Dnzkd/FkRxSYWx7u2Vc=;
 b=U9N7XNM3onkIfRC+iQOQoqtUCwNNJvGjws37Tb+WHCXl9LL9oGkmMhJIDa7U7csDAmuQ1xKRUDtVghNk8NiJ9wMhjLfZGZJEWXNF3Y4T0kNpM9cixN97nMjhEMLWPbu2xSLMU9a1Y5vAKBW4A+pCG+oH0zf4oTLLq7VMXlHtK+DImXlFDUTDyCkKgn7idIYRDZHjVoe2nTA8Z+1oaDnPDr+1K3LFrMLI1Bk3UHTe5kqAHBOdXZhNEZTckQyKlxn8CxKRd/sHxzs/jmdSJLW7dLO7YlUiv6POA+Eecblfj4sTt+B/g0ju87QRZM9tqBTAGzKhdGLdZSMtCVcbzv4LrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=386vtyWJEsahvAYm6rqfpRN9Dnzkd/FkRxSYWx7u2Vc=;
 b=dz8yUgjZbfgQNF3A4s1F07Zy9bJvHyxl27PLJIwtSbq+kWX5oW0d/zL3vBKyVsgEURxRddSNoZibrzcs+wYVUw+vYIqjJgq2rW4uzdlgO1TGKbAWLEAEiiA+9AvxiK4n+humobbnV4ZnTfJoujgN9tzTVJ50gI0s66Svwxa8XL4r1o4aLMxPB3K3YTSK13FiHa7W1aqU744BJumIgyQAgzuWgR6qSsUyXNtzvRtkvzEPN3luVdpA/W/57KxpNheT9F4zqb07fzoqhdO3DbIcT/HSCm3aE5insRom4RwlwHVBm/TSykGQMJT1DEqo+rzqcyfedviUzpdLruZpadXhyA==
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 18:18:21 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::a5) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:17:58 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:17:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Tue, 27 Feb 2024 19:17:27 +0100
Message-ID: <4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b17716a-fc60-40e7-e070-08dc37c07a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rzx+zc5XOQpXhG7AlX7u16Vr9RRdCI+BgwcKb2Z4r9YqzxsIPZUF/wQs6+JcqRmg0JSmxBPFM0T4iz9Mb2yl+tEAkaCaKULQXYZ0VSH5hL94jdgG5FOl+k2Zhp93bW+UGP8zTx9aVbIckveKvqgrczRAg3g/iy+ebEWOM4scH22sgy6Q/OmbWdokrGlXMRgInmjfOqnKr3xSeLslMTj0Q9Nti8KhNIBliYXkgg6e+qG9gj0kkXWsq2vbuZWYCsZ1HjtS076uL/pO0iV6uHq4R5rPz74EYBHuEmyfFVRZlbRnTXAacCcEMweVxmD0I6LQYylhChU3CRaoD9lfsHLFBX9l6fz6nX11Ie2VV3MH0N/8Ngfj/2Xdut/niZ2uNv5KCV4AFdE50G9VfU67tUZZBNxC3AFyC/53PkIkWmtA4HsdtxukO1sNcijkbBJpL32w3+XmcK2tn7QDiSm7nfoKRW/eZcOZ6QC3iHJJp0OEDBlEf4INWGmPb8SVka6tq4tBPbKGCltFmdhfp/AZu1pvukkv4THu1zYlQY8IxnjuD9Y3+eqYHQqFylFwSp7ZOq3U6xUpHCbMoygWw3VxRNid+I0vvChzdVkSY22ErpiMUj7UZir/33mvW0OFuC/skkGbWtUvWtd9GzKWfWfRe1o4mMMmwE3ljlHtEsobRCap9faVkvAVqR/YGMnPbpuzBW+MB2HwqoxyVnGwIUroZmIeZNbtpa5ns7pz0lNWqqDs1tSLWWKHlIgLM/4uanpwqykz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:20.1245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b17716a-fc60-40e7-e070-08dc37c07a36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index d8ffa8c9ca78..0d7969911fd2 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -60,6 +60,9 @@ enum {
 	/* nested; nexthop bucket attributes */
 	NHA_RES_BUCKET,
 
+	/* bitfield32; operation-specific flags */
+	NHA_OP_FLAGS,
+
 	__NHA_MAX,
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bcd4df2f1cad..e41e4ac69aee 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -41,6 +41,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
+	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(0),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -52,6 +53,7 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
+	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(0),
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
+		*op_flags = nla_get_bitfield32(tb[NHA_OP_FLAGS]).value;
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
+		filter->op_flags = nla_get_bitfield32(tb[NHA_OP_FLAGS]).value;
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


