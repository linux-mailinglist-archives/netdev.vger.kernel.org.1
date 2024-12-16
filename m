Return-Path: <netdev+bounces-152325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955359F3728
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321DD1884A44
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A12063C9;
	Mon, 16 Dec 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dp4mBu8m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1374206269
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369194; cv=fail; b=CdXGeUofTUsf+O5pnLCapfUzL9c+cltiY41CHXm27J8XfRFOCeh/oqsKCNOUpkfAt1rF1vyAi8vvowcU+1T2F5leFyVvGcXa3G83JQz2s6UUEywA59kQNERGs5zoeS/mMeT/SuI5NY9njoSSTjvpMquQd3xUGpQfHtG9H8xy7v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369194; c=relaxed/simple;
	bh=3+D6t51o4GPnO+YpcXL99EtJU7K6PDea6WMZXQ/u9Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtwymPX+h5j/bxPwWQo5tOOi8O672iJ6nclOg11BxDik/rn6nrt7yx71qsVe630C5JDEC/F7nZnTpYSGuVy5PNnQLNZ01j2iVtvt0U6TdwIUl296AXtrOK001q8wbGa7PzHGnxrU910DXEQSlP1HdPAsvDSQPA/aWtsYkX7aQSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dp4mBu8m; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ2cNBdM/k8K01ngNwIzfdDlFcC9vaj5/Jo/I0qY6sFIBz10pWAVPmGa3OuRsHPfmC0ywwqdKXlo4zEctUZBsmcfATIqVRgSRa6PTgnDTi0wxfllgf/djtA2yrE60FyHNcqx//CNdA3CWzxu2LcHW+E1uPzbX7nnsbXzIaMTt1Oadrb4tGy27DnxIbzCjvGh5IhwEHywFjg6kEFHeE+8hda8dGvnCEGIT8ul9VG8d1KY6mpWxJGT9suGSglgKzKiobs39ox3e0gy0W6LKdj4bxfecx8YNtMVUm2IOp091iLqrFKGy//+LYBz9mJavfsSh2lWxSLqBhoz4ac8Sd3QaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwjUg62U1Cs62+mTR3C6FbZtJhaM4gP7QVbNnu/OrqU=;
 b=yAHSDSR/+KsrfdEFs9hiaks3JVWH2WyS1C9hvtOgKih3ElVGRTr5dkdNn5lsAuqT1qzJRseUBYCKwRb6kJ9qeay3szFtowzcUAJ4sKS8T8rXFdRcI1u5rZDaRyITLTjryBzzEth+mM9gxiv+jpOeorwoeoHcttks29P2tWnf0Y1zQrMx4i5AbLIdn6m5c2G7ZCNTch+0Pf4gV6C5lZonnlwlW85pJckuiWTbFnG1OgEjXl+Qsr6OBCj0Xx/5N62L+IMbzhE+qcl6XY/ZndPKVSogxNxZPkK/3ivIFgb3nI1M0vjqmJMhgVzzF0cdqNLszLPS0UaXsAEo2fMXA4zrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwjUg62U1Cs62+mTR3C6FbZtJhaM4gP7QVbNnu/OrqU=;
 b=Dp4mBu8mihVpZ4cdRpkNI/IJgvI0G7BnhX1NN6HSYNTZA1RNkgGJOiWiilAhQzuEfFhqk/z9Uk2PtXJTGDip6FtquRAdV6k+umKtXGBb1Jj8xO35iOZ4B42mVDoIPiClijgerZED9g1NxlX3sa1ol/aD1a23GrLqMh+hDz1WbIFLzV9HUMlFv2jwtn+29nghnkzH8HWH5Dmj5/rxFmSZpKtvB1CsZvSrSUb99P5mfyf2f0kv0QwkOtGjUMToHMiiZUCX8QBhaQvw3AO11yWHyf97arH9k9ZQ860fgyj2i2ZEH1jxPpucKRK6KANh2nSeiih+v1te9duBDqfdpXHc9A==
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 17:13:06 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::4e) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.19 via Frontend Transport; Mon,
 16 Dec 2024 17:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 17:13:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:50 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:46 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/9] ipv6: fib_rules: Add flow label support
Date: Mon, 16 Dec 2024 19:11:55 +0200
Message-ID: <20241216171201.274644-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d4cea2-4d21-4b87-8ae9-08dd1df4e802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afnjoCF4Gso7YHGSIXde8g+DBgy2mnYXaA/NnfEeXpG1/HpoJOA++ydNdsSQ?=
 =?us-ascii?Q?c34EwatJ7haEClOVSncj5xmqHm+vQ3fkHQ5bINBRgwsXesBOB7+0DrBWAMwl?=
 =?us-ascii?Q?MbLBwUM+qwgv6Jxrb/qVKDLTpilMcazy4FG8eWtLv6B+2iTSQJTy+EmMRqr0?=
 =?us-ascii?Q?j8Nx1a2+3W5hJrn+UEyMUInDswazWiohSAXJJeR6uUECgSRNPV5/u36wZUjo?=
 =?us-ascii?Q?RocRG38Ui4Dzh/NYlnNEfzA/cvL2ABSQeAkhxuFS5dPvSicrdWOlp8sd+FGD?=
 =?us-ascii?Q?tljEh2PaztakqVVHJGd2+UaPQxrnZWA8nC9/IBAF/7qG3oF0a+9AAWh7cSkI?=
 =?us-ascii?Q?lsgjH15Blbi0SEPptJD0MrfFTT3zLxgjbutcbZT948pSotoUvJRHHyV3xHQf?=
 =?us-ascii?Q?uTDxRRmXuqZjOaREH68Tj4JHvgkVrr2sXp9OeWRiqw5L9WSTQ+ID798DEekB?=
 =?us-ascii?Q?euI6yPXnVIH+8FcTRcHhoYJg+zJ1xheYHgVgklkT7PeZ2+siMBv8mkqvUL58?=
 =?us-ascii?Q?Iyr2M7QcAvwPEY9DTUsWQjg150rlRBsXCby2jC3uKuxhwl6gqTD8eDVlpOcP?=
 =?us-ascii?Q?DFHpBDFARieYDtpQttWe/s2tbMXoupZ9nTBOoFCTk044i1hg2PMng16FyeKr?=
 =?us-ascii?Q?TIeike02NP3YgepienXk+wgck5UIbKWc+H3ZiH0aelaNxp6MU5wlGIfjk/b4?=
 =?us-ascii?Q?I52kq5kARuuqrtR0J9qk1I9J6v44CU9En9d+bPNMi5Ai1ROb3myxLWG/4SD1?=
 =?us-ascii?Q?tN1iIUalcz0lXrcpsMQ4RQOHojQViB+mZWq4yBJvkAvz4dxfS11ul3AfAB1J?=
 =?us-ascii?Q?r7ksDGsg8DTZlZKy8R1aAON/jblWsvMTuB7EiepIplHbf4zesyYJmZGxgyUt?=
 =?us-ascii?Q?Mi4HOdIPJWv2pLok5e78tNCTLyi/5Hgb7SX4DaGrVejrti3t4XJTLsWVsVg+?=
 =?us-ascii?Q?WZXNBWZOkbXO8/EZ1CSVGoWiVeutSr390jtLBddj1a3Jzt4/IXT0tqdAkFtZ?=
 =?us-ascii?Q?vghWDaI+N6PBH7PE0c6u6WvreSdZGNaLN+49VQGir6xAigalu7gEfPOQ+Grg?=
 =?us-ascii?Q?ti3/W/ZA36IZl9cfd1AhR4DprXuCVC/PFd+IdrWhRrT3gJgr+eih6xtDnt52?=
 =?us-ascii?Q?qfNPv7VzaLuarXuxTW3x7rPRHTSG2djL0Ob4T68cH0pXar5hU6v+4x2/KZIs?=
 =?us-ascii?Q?C7Ir9hzrufAT4n+hL1uVwIj8TLl2uon5Y0GmYeY5MEbEvmKP/EY1dt8ernfd?=
 =?us-ascii?Q?60RY5aNKKvrJ7F4lcQMvC+SeWaV96Fmur2l6NcVJTtaiOeK48X6U1NSR87HW?=
 =?us-ascii?Q?xRhMLcVRTabCPZf2vyW1BfIRPAycQQ8emJZ4KMXx4ieO+JPB+uYmOh0/Zn/p?=
 =?us-ascii?Q?irX5to0mNAmaxNjWDz5tI2qdQrT3Om+H57JkE3GQ8Kp12FQSnHkU/e3N8RjD?=
 =?us-ascii?Q?PYiqjAy0OuRee/tNhK6fzkoRbJf0HT/f4Yk7KI9yqK0mytdA/dUQvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:05.6466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d4cea2-4d21-4b87-8ae9-08dd1df4e802
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

Implement support for the new flow label selector which allows IPv6 FIB
rules to match on the flow label with a mask. Ensure that both flow
label attributes are specified (or none) and that the mask is valid.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/fib6_rules.c | 57 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index c85c1627cb16..67d39114d9a6 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -26,6 +26,8 @@ struct fib6_rule {
 	struct fib_rule		common;
 	struct rt6key		src;
 	struct rt6key		dst;
+	__be32			flowlabel;
+	__be32			flowlabel_mask;
 	dscp_t			dscp;
 	u8			dscp_full:1;	/* DSCP or TOS selector */
 };
@@ -34,7 +36,7 @@ static bool fib6_rule_matchall(const struct fib_rule *rule)
 {
 	struct fib6_rule *r = container_of(rule, struct fib6_rule, common);
 
-	if (r->dst.plen || r->src.plen || r->dscp)
+	if (r->dst.plen || r->src.plen || r->dscp || r->flowlabel_mask)
 		return false;
 	return fib_rule_matchall(rule);
 }
@@ -332,6 +334,9 @@ INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
 	if (r->dscp && r->dscp != ip6_dscp(fl6->flowlabel))
 		return 0;
 
+	if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
+		return 0;
+
 	if (rule->ip_proto && (rule->ip_proto != fl6->flowi6_proto))
 		return 0;
 
@@ -360,6 +365,35 @@ static int fib6_nl2rule_dscp(const struct nlattr *nla, struct fib6_rule *rule6,
 	return 0;
 }
 
+static int fib6_nl2rule_flowlabel(struct nlattr **tb, struct fib6_rule *rule6,
+				  struct netlink_ext_ack *extack)
+{
+	__be32 flowlabel, flowlabel_mask;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, FRA_FLOWLABEL) ||
+	    NL_REQ_ATTR_CHECK(extack, NULL, tb, FRA_FLOWLABEL_MASK))
+		return -EINVAL;
+
+	flowlabel = nla_get_be32(tb[FRA_FLOWLABEL]);
+	flowlabel_mask = nla_get_be32(tb[FRA_FLOWLABEL_MASK]);
+
+	if (flowlabel_mask & ~IPV6_FLOWLABEL_MASK) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[FRA_FLOWLABEL_MASK],
+				    "Invalid flow label mask");
+		return -EINVAL;
+	}
+
+	if (flowlabel & ~flowlabel_mask) {
+		NL_SET_ERR_MSG(extack, "Flow label and mask do not match");
+		return -EINVAL;
+	}
+
+	rule6->flowlabel = flowlabel;
+	rule6->flowlabel_mask = flowlabel_mask;
+
+	return 0;
+}
+
 static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct fib_rule_hdr *frh,
 			       struct nlattr **tb,
@@ -379,6 +413,10 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	if (tb[FRA_DSCP] && fib6_nl2rule_dscp(tb[FRA_DSCP], rule6, extack) < 0)
 		goto errout;
 
+	if ((tb[FRA_FLOWLABEL] || tb[FRA_FLOWLABEL_MASK]) &&
+	    fib6_nl2rule_flowlabel(tb, rule6, extack) < 0)
+		goto errout;
+
 	if (rule->action == FR_ACT_TO_TBL && !rule->l3mdev) {
 		if (rule->table == RT6_TABLE_UNSPEC) {
 			NL_SET_ERR_MSG(extack, "Invalid table");
@@ -444,6 +482,14 @@ static int fib6_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
 			return 0;
 	}
 
+	if (tb[FRA_FLOWLABEL] &&
+	    nla_get_be32(tb[FRA_FLOWLABEL]) != rule6->flowlabel)
+		return 0;
+
+	if (tb[FRA_FLOWLABEL_MASK] &&
+	    nla_get_be32(tb[FRA_FLOWLABEL_MASK]) != rule6->flowlabel_mask)
+		return 0;
+
 	if (frh->src_len &&
 	    nla_memcmp(tb[FRA_SRC], &rule6->src.addr, sizeof(struct in6_addr)))
 		return 0;
@@ -472,6 +518,11 @@ static int fib6_rule_fill(struct fib_rule *rule, struct sk_buff *skb,
 		frh->tos = inet_dscp_to_dsfield(rule6->dscp);
 	}
 
+	if (rule6->flowlabel_mask &&
+	    (nla_put_be32(skb, FRA_FLOWLABEL, rule6->flowlabel) ||
+	     nla_put_be32(skb, FRA_FLOWLABEL_MASK, rule6->flowlabel_mask)))
+		goto nla_put_failure;
+
 	if ((rule6->dst.plen &&
 	     nla_put_in6_addr(skb, FRA_DST, &rule6->dst.addr)) ||
 	    (rule6->src.plen &&
@@ -487,7 +538,9 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
 {
 	return nla_total_size(16) /* dst */
 	       + nla_total_size(16) /* src */
-	       + nla_total_size(1); /* dscp */
+	       + nla_total_size(1) /* dscp */
+	       + nla_total_size(4) /* flowlabel */
+	       + nla_total_size(4); /* flowlabel mask */
 }
 
 static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
-- 
2.47.1


