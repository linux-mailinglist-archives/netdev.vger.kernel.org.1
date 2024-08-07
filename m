Return-Path: <netdev+bounces-116508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3C94A9B4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B24828476D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8387A15C;
	Wed,  7 Aug 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+Wodajq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FC79DC7
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040086; cv=fail; b=qLb1u0lyCDh6lXMq30aRSRaf3r6uSJtoJf2nIhGts507INgAwfv6312EZaHNbxzHw3mfsUpi9L95tLyAhoQO+nXjIlHl5l0vMPSYRKYt97wvmPbwZ0Kr/XXUdNsBn7LjVHJL4+IwkehJUhSbFpF1nQE++WSAgSacqwGLOcaC7AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040086; c=relaxed/simple;
	bh=9qGDhISJtwGHPlymcD5XtK7W9tPZZUCFKo04MWALO5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxDC1VBS86+lvYiHwzyL8Z5sIN3JB9C85VT9wDdQdBXYW2WqzDLP3ewvcUG0Oahv/PqpXsAWBFsek9mM/RcCT22gbVbhF7c1BRS4Qg1SgH+tSxCbBmtr2UC2Hpd8kU2T0IJA7ZU0sPeztfc1SauEZFLxnWglq2Eg4lEiYI90EL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+Wodajq; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuYQVwYqkUduXqxJPYQftxlCUoeNX8PyJorjHMvPzpelGlodP35+PIc3mPBE0l4Xd6toAhya5atXind3psVOQWan+3+ZhOeaHekDBGIxjsx+LlMNEy5H3JE+8AdHDneO+B0qvOfaKiR1VhbgXuKLgLF/wieb1iIkERYcs7C1MKn7YEeE1FpwD4FSh/z+DesAVmwn4vtEMOZEyXSsBGjcwxScQz+NJCRPVpyyEC8WnWfvwswUONAY/ICgraHRYdaw4mMwwk/dMvkNRkiC+NA9944useU0lf218l5DJYieg2SDhmdGu/AT43LjbKEmYeYLFHkHPVNpsGAqHU44ebUcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX2uBN0mJWCzzXI8w2mQSiIxArKCz2G+Zpu3qlVS/Oc=;
 b=p2olj1zh1jpwU5mBzFTO/3WTeMu2DlfDYPV2vnrOy8WiXJvy7H5AjRguK8OD1NTwk1bTduXZycbSalY8tZXz1KaYkQIBPBbwXEGIX9zuewGxWisxVNAcV3BWdlqoq4mTHdUeeMpTRA9TMe3jjNiOTF4cuy1auAlYnR44RvfjO4ssEYoXs61necx1/iqu82WuPyBCQcplQU0xAIG0R/jffPMPhVFpoBW812xH5Zns8ag+i64CJ3NZlsLOq02G3a+eomgevHbmexeiAW/FZebozqTdaNChMarwjXEaNIsO8CBJb+Dtb65kWXOWI79yx4JKsCRRiF5WWMpO13TIdVJFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX2uBN0mJWCzzXI8w2mQSiIxArKCz2G+Zpu3qlVS/Oc=;
 b=T+Wodajqg1tgX+E2aV8tH1ajoXIBFAqnrHbQLvHMKYYnbNrqVApLglmqla0XH6OjyZPQnGBG/hvzGvPAOj+67paBTP4QO0ZjGe03gQyusGq5khMB+ep3ae96ISfVJdMOag31B7wMKU9w5o9jCL9+f+jbix/P0Y3D/Erp3RFq7uYQuJOcJeVPBXKzAtsS7VHbofQ7+lgiQ2bGuJWBEQGzLa9ac5MYS7oZH432Q/mdhpZaGoaMBO28AEsPxVyOSzyQn5XzxQ9HacTsyAOb8ySBONUNrHBQOPwNhYE3Fa0uVHh0RRMn/c4+t7cPslzHBne2W2JMxwYitCC9o0C3JVGqmg==
Received: from CYZPR02CA0007.namprd02.prod.outlook.com (2603:10b6:930:a1::24)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 14:14:38 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::ef) by CYZPR02CA0007.outlook.office365.com
 (2603:10b6:930:a1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 14:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 14:14:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:21 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:15 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 2/6] net: nexthop: Increase weight to u16
Date: Wed, 7 Aug 2024 16:13:47 +0200
Message-ID: <483e2fcf4beb0d9135d62e7d27b46fa2685479d4.1723036486.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723036486.git.petrm@nvidia.com>
References: <cover.1723036486.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcab629-a7a6-4c4a-fe61-08dcb6eb454c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tiYgbRw2asWuVSj8p8eZV/hpkST5j3WbjgxXbBQPga3rx02VJC+HfwMBCwlt?=
 =?us-ascii?Q?LGTgqurIIcBedQ33As1I6zjPkBLct9eiwRv+7QdUfNLlCqknsnfLfo1qfZ8w?=
 =?us-ascii?Q?h3DK4Ju93N+QYdtKNzlVT2N5HZMTsJ5gygXIKilLCPUkbIaKzqdwePWPYNNq?=
 =?us-ascii?Q?H4Fh6v4pDqvSmnWT5Du5Cvjk90SMyFut8j31LUxIuyHG8xGwws2SqBZv7fhP?=
 =?us-ascii?Q?iG6r2xF9Lis7wa2WhjAbjXmpcbsrUd8Go0mgPjjKH6Xpy2xjFqYjO+/ciGam?=
 =?us-ascii?Q?P9e8KpNdg8gIrjE8S06rPf29PqoeF01yx2oO0L7WR1AFbngGeErRG5gliQaQ?=
 =?us-ascii?Q?qN0m0n0MEibtltsCdMMjL7lbydeD7e+mAIkrJO6Zp45VPsSrWyTE1od3HKJm?=
 =?us-ascii?Q?mCJtLdu2hs357nNTP2Tf9YSlz5OqFkKXhAgwlRxMku1YwuhXMqpI/vDi9ixD?=
 =?us-ascii?Q?6s5hOCJiWTmSjY9uBG7ixxC1DA+IG4geVw9vwHx0D86/KERTKEqN9kaT4lwD?=
 =?us-ascii?Q?Wzwdh9/Fuc1bJOCJwz2ABdTmcPap33uq2uMNjQJx8VNDwCv5tJSgSNMzutmO?=
 =?us-ascii?Q?pv3qrvbkbFCD5R//A+TbQp8duTh6flU/vOLBQ0AgNBGBvfd8u50Yy3JhEuht?=
 =?us-ascii?Q?npVZ3z6TR5rtIn1xX1XxT/Oe08OiHxKFo85ONyjwnuL+PHAp22tex39JTHUl?=
 =?us-ascii?Q?cFuN9n0z7Gx7c2447BZ7E3z/h21coQYXb+z2ma+Oug2X6apJuT1x42SUDTjj?=
 =?us-ascii?Q?oGei4ycot6a19ORe2W0Gx7oqBjLd/IxJ6n+gW20em4pa38zvGO/GiSd98T/Q?=
 =?us-ascii?Q?jguDgJKla6TIGgyzQ/Xu+T6E3kcR/2r5O9v1Scdkkvqvpzir5HvkGFSgkWok?=
 =?us-ascii?Q?53A6FAb8/EtluSPAxIi0t2wSFkKKimM/N1On94obtpzz2G6u/AdDXKcSaz9c?=
 =?us-ascii?Q?SXPLxg3TDTRfZ+RN9npst32FbtIV6fUwe+/8ww+KY2d45eVJ58q6MVKcubha?=
 =?us-ascii?Q?/hJoB6hs6Vbb96CzEvlra5MYUfPcjbHhqLR9IOtcWoOGB/NePFk47BiDXekE?=
 =?us-ascii?Q?3NUrnw+gkFXgl7JJeIDOMVACa1XPQHHwVTg8r1OQajLjwe2bzuho96MEF2SA?=
 =?us-ascii?Q?iK//HjPmfAivUPHmelKMsO3W7u4u9CFvDcWvGsQNR11hJCvyxkPIvrRk07SZ?=
 =?us-ascii?Q?0vAotk4HzzkhKCcOZ9u1QO0M4YsAjogbMWWyY5pnX5v9DsZWbzTxReqXbl4N?=
 =?us-ascii?Q?0BQr2/kbRSnSt/euyeMcpW+ZeES7OqANz/fmZKpyJGGzzALnT2wJGyhmT8Sa?=
 =?us-ascii?Q?6IKv2Qpxix+vVFSO8sxtmsH3nZ5Qr2QVCB6SrbSi/rWP42r0eOcyoxZqCb1A?=
 =?us-ascii?Q?F8rVzgrIpJn4tFNOl6+B1S4dEmFJJ/ef4YPt/6ez/Is2N3wTxmgKpns5o0Xe?=
 =?us-ascii?Q?bRu0N7X/ae28KjYntiWbvHroHsFq0c9x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:14:37.4917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcab629-a7a6-4c4a-fe61-08dcb6eb454c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815

In CLOS networks, as link failures occur at various points in the network,
ECMP weights of the involved nodes are adjusted to compensate. With high
fan-out of the involved nodes, and overall high number of nodes,
a (non-)ECMP weight ratio that we would like to configure does not fit into
8 bits. Instead of, say, 255:254, we might like to configure something like
1000:999. For these deployments, the 8-bit weight may not be enough.

To that end, in this patch increase the next hop weight from u8 to u16.

Increasing the width of an integral type can be tricky, because while the
code still compiles, the types may not check out anymore, and numerical
errors come up. To prevent this, the conversion was done in two steps.
First the type was changed from u8 to a single-member structure, which
invalidated all uses of the field. This allowed going through them one by
one and audit for type correctness. Then the structure was replaced with a
vanilla u16 again. This should ensure that no place was missed.

The UAPI for configuring nexthop group members is that an attribute
NHA_GROUP carries an array of struct nexthop_grp entries:

	struct nexthop_grp {
		__u32	id;	  /* nexthop id - must exist */
		__u8	weight;   /* weight of this nexthop */
		__u8	resvd1;
		__u16	resvd2;
	};

The field resvd1 is currently validated and required to be zero. We can
lift this requirement and carry high-order bits of the weight in the
reserved field:

	struct nexthop_grp {
		__u32	id;	  /* nexthop id - must exist */
		__u8	weight;   /* weight of this nexthop */
		__u8	weight_high;
		__u16	resvd2;
	};

Keeping the fields split this way was chosen in case an existing userspace
makes assumptions about the width of the weight field, and to sidestep any
endianness issues.

The weight field is currently encoded as the weight value minus one,
because weight of 0 is invalid. This same trick is impossible for the new
weight_high field, because zero must mean actual zero. With this in place:

- Old userspace is guaranteed to carry weight_high of 0, therefore
  configuring 8-bit weights as appropriate. When dumping nexthops with
  16-bit weight, it would only show the lower 8 bits. But configuring such
  nexthops implies existence of userspace aware of the extension in the
  first place.

- New userspace talking to an old kernel will work as long as it only
  attempts to configure 8-bit weights, where the high-order bits are zero.
  Old kernel will bounce attempts at configuring >8-bit weights.

Renaming reserved fields as they are allocated for some purpose is commonly
done in Linux. Whoever touches a reserved field is doing so at their own
risk. nexthop_grp::resvd1 in particular is currently used by at least
strace, however they carry an own copy of UAPI headers, and the conversion
should be trivial. A helper is provided for decoding the weight out of the
two fields. Forcing a conversion seems preferable to bending backwards and
introducing anonymous unions or whatever.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---

Notes:
    v2:
    - s/endianes/endianness/

 include/net/nexthop.h        |  4 ++--
 include/uapi/linux/nexthop.h |  7 ++++++-
 net/ipv4/nexthop.c           | 37 ++++++++++++++++++++++--------------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 68463aebcc05..d9fb44e8b321 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -105,7 +105,7 @@ struct nh_grp_entry_stats {
 struct nh_grp_entry {
 	struct nexthop	*nh;
 	struct nh_grp_entry_stats __percpu	*stats;
-	u8		weight;
+	u16		weight;
 
 	union {
 		struct {
@@ -192,7 +192,7 @@ struct nh_notifier_single_info {
 };
 
 struct nh_notifier_grp_entry_info {
-	u8 weight;
+	u16 weight;
 	struct nh_notifier_single_info nh;
 };
 
diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index f4f060a87cc2..bc49baf4a267 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -16,10 +16,15 @@ struct nhmsg {
 struct nexthop_grp {
 	__u32	id;	  /* nexthop id - must exist */
 	__u8	weight;   /* weight of this nexthop */
-	__u8	resvd1;
+	__u8	weight_high;	/* high order bits of weight */
 	__u16	resvd2;
 };
 
+static inline __u16 nexthop_grp_weight(const struct nexthop_grp *entry)
+{
+	return ((entry->weight_high << 8) | entry->weight) + 1;
+}
+
 enum {
 	NEXTHOP_GRP_TYPE_MPATH,  /* hash-threshold nexthop group
 				  * default type if not specified
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 23caa13bf24d..9db10d409074 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -872,6 +872,7 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 	size_t len = nhg->num_nh * sizeof(*p);
 	struct nlattr *nla;
 	u16 group_type = 0;
+	u16 weight;
 	int i;
 
 	*resp_op_flags |= NHA_OP_FLAG_RESP_GRP_RESVD_0;
@@ -890,9 +891,12 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 
 	p = nla_data(nla);
 	for (i = 0; i < nhg->num_nh; ++i) {
+		weight = nhg->nh_entries[i].weight - 1;
+
 		*p++ = (struct nexthop_grp) {
 			.id = nhg->nh_entries[i].nh->id,
-			.weight = nhg->nh_entries[i].weight - 1,
+			.weight = weight,
+			.weight_high = weight >> 8,
 		};
 	}
 
@@ -1286,11 +1290,14 @@ static int nh_check_attr_group(struct net *net,
 
 	nhg = nla_data(tb[NHA_GROUP]);
 	for (i = 0; i < len; ++i) {
-		if (nhg[i].resvd1 || nhg[i].resvd2) {
-			NL_SET_ERR_MSG(extack, "Reserved fields in nexthop_grp must be 0");
+		if (nhg[i].resvd2) {
+			NL_SET_ERR_MSG(extack, "Reserved field in nexthop_grp must be 0");
 			return -EINVAL;
 		}
-		if (nhg[i].weight > 254) {
+		if (nexthop_grp_weight(&nhg[i]) == 0) {
+			/* 0xffff got passed in, representing weight of 0x10000,
+			 * which is too heavy.
+			 */
 			NL_SET_ERR_MSG(extack, "Invalid value for weight");
 			return -EINVAL;
 		}
@@ -1886,9 +1893,9 @@ static void nh_res_table_cancel_upkeep(struct nh_res_table *res_table)
 static void nh_res_group_rebalance(struct nh_group *nhg,
 				   struct nh_res_table *res_table)
 {
-	int prev_upper_bound = 0;
-	int total = 0;
-	int w = 0;
+	u16 prev_upper_bound = 0;
+	u32 total = 0;
+	u32 w = 0;
 	int i;
 
 	INIT_LIST_HEAD(&res_table->uw_nh_entries);
@@ -1898,11 +1905,12 @@ static void nh_res_group_rebalance(struct nh_group *nhg,
 
 	for (i = 0; i < nhg->num_nh; ++i) {
 		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
-		int upper_bound;
+		u16 upper_bound;
+		u64 btw;
 
 		w += nhge->weight;
-		upper_bound = DIV_ROUND_CLOSEST(res_table->num_nh_buckets * w,
-						total);
+		btw = ((u64)res_table->num_nh_buckets) * w;
+		upper_bound = DIV_ROUND_CLOSEST_ULL(btw, total);
 		nhge->res.wants_buckets = upper_bound - prev_upper_bound;
 		prev_upper_bound = upper_bound;
 
@@ -1968,8 +1976,8 @@ static void replace_nexthop_grp_res(struct nh_group *oldg,
 
 static void nh_hthr_group_rebalance(struct nh_group *nhg)
 {
-	int total = 0;
-	int w = 0;
+	u32 total = 0;
+	u32 w = 0;
 	int i;
 
 	for (i = 0; i < nhg->num_nh; ++i)
@@ -1977,7 +1985,7 @@ static void nh_hthr_group_rebalance(struct nh_group *nhg)
 
 	for (i = 0; i < nhg->num_nh; ++i) {
 		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
-		int upper_bound;
+		u32 upper_bound;
 
 		w += nhge->weight;
 		upper_bound = DIV_ROUND_CLOSEST_ULL((u64)w << 31, total) - 1;
@@ -2719,7 +2727,8 @@ static struct nexthop *nexthop_create_group(struct net *net,
 			goto out_no_nh;
 		}
 		nhg->nh_entries[i].nh = nhe;
-		nhg->nh_entries[i].weight = entry[i].weight + 1;
+		nhg->nh_entries[i].weight = nexthop_grp_weight(&entry[i]);
+
 		list_add(&nhg->nh_entries[i].nh_list, &nhe->grp_list);
 		nhg->nh_entries[i].nh_parent = nh;
 	}
-- 
2.45.2


