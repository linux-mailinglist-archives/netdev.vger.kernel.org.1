Return-Path: <netdev+bounces-115075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669B945079
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DEA281A6F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12821B3F05;
	Thu,  1 Aug 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WUlYrE17"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD91B4C45
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529507; cv=fail; b=PWkooyKand460IwjQLxBm0UR11yMT1fyjC4XtHPMSexCNQM8FY7Ug+Yv2ewxferHTCvCS84D78J0y7qjE7P62PU1WD7kdGQeejgrS9MtQiRcZ8cblujMrbhY0+hc2l7xli+Y+elblDNjSTLSM62FbVz8reeDsli34+WpNPeh4VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529507; c=relaxed/simple;
	bh=JnBU0aLKtJiP42lEmhZAQ1bdHMFyDYXCoJ4+zQjg9dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLkeUqBwCgBxM5oH09kOTWi0Ew1jKkUchv2ldOwYNcyp54xwSVorQ0pkiHKoFkp5GMuhPuFJkCd+gLr30HQ0tYvrpUk8Qca5ynnVPAmiY6myoZxilp9NnddndWUbNY7PPoMeJ6h6Qx4rCVeSlUhv5jzJo287MHPwwtUJBQO9Xr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WUlYrE17; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlklBW9kMoST6SFzNsTJ1XwsuWBKuLqT/xC2Lpm/ILNSruDozaij+vFgVOApvMNVBf5y83lihM5FKD0gEYMZoIPYLTax798d+rYvKnmlkPTBzkdMHg70swrWklCAbk97xZw3+59YfEHCdm0Vt22x3Mm9PO8OReUUEmqA8gPh7OIcvQUl6hKA+UsIQQd5QMpkwaCmu/56MwooR88fLipWrPEXzmImfXQ/A6VnhLahtSpzXz6IN3JEJpIcb15PGF3RtRvF85B/jnjHsMeY6F2UAjNrIZrJPDDMx+Xyufb+y8nF5MJ1731CfAu0k5pU6G5Su5pg39AlSnct+obY4JymcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhR3BS5xU149MkLMng+KhvjP8DLygGB2IVxGu2YiGKk=;
 b=NmN1o938WGrw+BI9hbPym1yx3HNU3RXJZ/Ephgw9mU/6ZZYHGMhpWB/3t2Zjn3XDU8QRCsgq0icSptYeTIufhLx65VpFyR4sKOBpJzVI4hBWzpA13iraFJYGLrhj4N2yqoqwf2r4KHajxfRUsJfSN0L9Cr60pu9Sp++HrA2yrQN6LgQKOQPOWKteiJdN/gIeYfLJEuMItLT95cCKrW8yNCQd4X8tLowrmKe3ONuQLOzs/jKJ61ub0SjqinSlEz46kXerzdsdmzamXtfIwOZF6QdSr0g5G8d1/tmp/35ybDCscYU068hNphxqAs+9Ab+UxD9qFUzmVrP4to7xgALHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhR3BS5xU149MkLMng+KhvjP8DLygGB2IVxGu2YiGKk=;
 b=WUlYrE17I7ygq4DfBQFflgazbORoXYIIbB6Swbf3FkTgCkPikkJtOEge+IaG1AxWCsUVoxJiUgnqRzk5kNxXGxHzq/ywtySdpHNvxGUSbDu5L2NMFXuh79yCIactOHox0ZV/Oze23OE3YPwExzlUieSXuUnWu0gFxkRFoqDiJNWak0scRHsLll/bTsGnzOdpgKS619tLrmGyYUMSpCHcoPUDs6OhDdn4Blwiy9XkMu2nBrv/Pc6DBarXLKvjNDYMHheYXW7wVVvOVGcqYMwlPYOTCRqHCQMcELZSeKZbHwPY2hjWJUxEQ6QJQjq61ke87jR3OELXgBeLeFfLfUinIQ==
Received: from SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 16:25:01 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::95) by SJ0PR13CA0130.outlook.office365.com
 (2603:10b6:a03:2c6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Thu, 1 Aug 2024 16:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 16:25:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:47 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 2/6] net: nexthop: Increase weight to u16
Date: Thu, 1 Aug 2024 18:23:58 +0200
Message-ID: <e0605ce114eb24323a05aaca1dcdb750b2e0329a.1722519021.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b36050-cf15-4bc8-81a7-08dcb2467dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4JgXDHmMsskH5gW9aDcmXyKwnxtPviwENHPcuK/lMOxgQ03tvDUQRP8ftTXA?=
 =?us-ascii?Q?3J0GgpHqvifFKhwycntVu/gpGwHkC6QzXfAyFuQWonAx+jGvwHcvl/t61kBB?=
 =?us-ascii?Q?qNxRAwzAUqbOH1XRaB8GGHXvce15zT6S47pV93zdwYWhBEBPCp3Mb2PFSO9M?=
 =?us-ascii?Q?OMBIWS6ghQJLEtncerSmEpg0/y7gMS7GVK9n5yePTqYr6lxxt84osWwjgYLN?=
 =?us-ascii?Q?HHnc3Ew2OshaM0iTPL53HysAGkTlIn2FT/eVg05RMqntgAtjZAcGmH0jrwZG?=
 =?us-ascii?Q?aDfbT2fd1uin+dyQfuKs79FvhyiwFAburmrr5T8TbMiKLbzJiVrWYQzjd9oy?=
 =?us-ascii?Q?glbpdDwvT91dWi16gReKhzND2ShuEvuoBUl3aY0VXnz6woQFmH9qMPzl1ML7?=
 =?us-ascii?Q?mZ5GgWdVD9OC8ZH32L9qANIfwoiLPujcNZyT66DJbaMPWW027p02NtQqB5V/?=
 =?us-ascii?Q?1M1asoFHdNrKaEouQHOJcL24rn6GaZjw2Hp4fK8CJ7vy55w2k8kGunc2gZbf?=
 =?us-ascii?Q?a4z7/lx8iatVHB2RhszNkKMXd8lpU5mE4M4VoBgl0BjdR9mP9hBjqhWM6hCu?=
 =?us-ascii?Q?r+oMbkXKGbIdhTwenuxJ3dsff+3vR/thacj1rKpsmKJxRInDd3WrnsLC2Ndn?=
 =?us-ascii?Q?N9plyk9AD2tCiL/6ub7U5sq6iO0Ra+NYdBUlSyi9MHCYg4owgXuIOUHjth/l?=
 =?us-ascii?Q?gIk9ax4rI9dZ7+3DVbfAKjxvOCSVfbaDEKcZ9mfPng89HqQ4F2m2THIvBfKh?=
 =?us-ascii?Q?Uptlsc1WGdOportAWXPsxWgLPH6OxjVP9XJCw5s3v4X5AaA91SFNgt2tM3S1?=
 =?us-ascii?Q?yYQ1wyrs/z+JMyWJm6wwKWUKmaCzDzOwffj+uj4z+nIjcrJS/r1UCuq3OJHG?=
 =?us-ascii?Q?MahOyLXzSmQSxQbPTWN2k9f7da3FizeW9NrVSEkdytNY510qngy31DbbCIT4?=
 =?us-ascii?Q?sC4dJaBNk+RZsKdcFHBoRFLpl1JByUVMslndGYFM7gjvKw0V611nP/Hoyu/t?=
 =?us-ascii?Q?XmSOz3oVfCf9OGzO5xxe9Cjle+4EhX4fEyl7POuexxv2cwEPHHyxkVyg2BAK?=
 =?us-ascii?Q?8nCKS+GDMdyVsnC3CHzYQyg2e5FlxIetwvpm670smy1CJNPDDQmVNPSn9DQ9?=
 =?us-ascii?Q?jXcZJIy/bwCEjGlpMtLR00Eb8u8CTJA61/2L7QTVvHbN8FKlQZK4NOEu3ByD?=
 =?us-ascii?Q?GMy0pUzMvo7+Gx+ZVMYJcY535WcUGvMmOuWQn3c5CmY6XzYpTLKrwB0iv9w+?=
 =?us-ascii?Q?2cut3kN33ER0EkrTP9HEPeLstTQytCgYAER866wy9AIldASR0emZA674/T3X?=
 =?us-ascii?Q?elT0VjGCjtFjDgi9bq0G+whdxfNAgzD3Pb1jiol4M7OJGfilz7K4+gonhNFs?=
 =?us-ascii?Q?sF+WggHFxzq7yV+Ztvcea7PNRv1whQbbUpvNDuZ9Ggk+I0wiOvQ8Sc/69TDj?=
 =?us-ascii?Q?ad10Lq1ngnXM+b6bGsuidE9ShzL3ddxW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:25:00.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b36050-cf15-4bc8-81a7-08dcb2467dce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

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
endianes issues.

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
---
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
index 2ed643207847..3f869a8fc949 100644
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
2.45.0


