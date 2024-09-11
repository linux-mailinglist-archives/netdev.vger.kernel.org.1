Return-Path: <netdev+bounces-127312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E6974ECC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1841F25907
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD941836D5;
	Wed, 11 Sep 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKw3yr04"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29539FF3
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047518; cv=fail; b=dN9oDFiOb1J5KxC6HJ7A4o0LNzxBygWkOQbAzrDHsWWWdqmLawXVKLZeqkMUbFJjuhk7I+HYtIWRBfeukEZxDYjrcn2hABcQwo7fyJeLyPEUBuFPvAjchZ3jPVVoYRFsVLoRSyDUEl3+d0bDGv5wlUyrjQDhaHaUjQ3uw7HCmq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047518; c=relaxed/simple;
	bh=Af7KONBFvon/D5HMVVrkT3BIFFl4a1ZDMyGB3XQZmvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcOawU/I3fwqerGGUL/T77TYKK30vGjPzV9AzL+rx/8K57o60eHfWsDhejccQUZmS/Ti2pTJFiFOKHk9BTEipyN0Yh++Bl7VIXIYL399CyM9gIGBY6IrIfvlpNpxq+oIfEaiDXyxwPWisTCFe4/GEculZMyDkt4opKt5Xo+M4DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKw3yr04; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcfBqpdtySKOn4Rd5jDHwZMjVLOqAWpR+Aw2kWCYBNbKnBxwq3ucGMe7UW2BcL92UYETXK1YuO37pYJ63RPR+rDLoSwAu9xfhXYN7aDO+9VbJFyuv/K+nvacVTmvuhQgJyRW3tWTjxJRQT/kiXkuSUJFS5Lu0bqrG4w+RRoXfcZiOQFxs0mZI/CACg+GnUTPMHBlg4zslbEV8gt7r6T7ypKdsFvFjGTxDLi8TA3C4KoLR3myxCkk0cqtrADVYuVTiJT4ksoSd3UcOoqCMMg6HMg+XPvy8ozN524W2OQ9eyNi+/iRiPJ52deI4qn2t0/rD9UZzlky/p37FApznXjmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l5M7MNYkupqF3wT/36K79w15PSDgq/MBcgwnzNi75E=;
 b=osMbpVHXA8YgrcUySpKKAe5h63uFy/twyX2PZ2ZlMV0o1FLgTtGnNAqKn+6F4SRqzQeCUqztiBwWQql9iTqoW2UIoQkEiA7Py8dEw6VDGtIyhq1g2aZYNfB0Eg2RJpEMhH08wHb9YnqUUhHVdtlg/C5y35/k4c6T0H1IHv5HFdRrcxWB+P16Hp5sK5NJTLLCDIOs5/R51oHJz92sYW/AITUQzY1U8Xcwbf8tk+ugr/CX9tQsmVMPVid4CKfSJptPmEX5t1YzWRrDFgnw9EbTKRMxTjchiRHYsdKIqbAXTvZdcbBu/T0X6IOh9IRhY9D0V8ADQyPiH4VfMRPZqmT5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l5M7MNYkupqF3wT/36K79w15PSDgq/MBcgwnzNi75E=;
 b=oKw3yr04BmVW+UU90T25IUREA+PxZYnguZXqRaI5HvklTVQgnMOHOnGJ9XSzhac2SyU/+u4scdBJ1dS4cwKgRDqr8bHmGOCODozCgRtPiTVMsRvl2tE4OFI//3jhDSQWWwgigTvSeIttpwHfwZvo43+RCJ3Nje+OriVpN2etrTU8uUEK0iwPSGOO5VWlJUhzczz2HMemCShDhD/p2igtrPeyxaUJe1pWHWPKfOputQZu9vlYhe87GmsyOeMPnvsYAAU1JtPxRQjeuZJVuCs38gs7Vw27dJ4hYdslD4rii7IjoF1GSDFBqrLxiNEMukCB4w+q0L9dBH6ariVLTV7LtA==
Received: from PH8PR07CA0046.namprd07.prod.outlook.com (2603:10b6:510:2cf::24)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 09:38:33 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::45) by PH8PR07CA0046.outlook.office365.com
 (2603:10b6:510:2cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:38:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:17 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:14 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 2/6] ipv4: fib_rules: Add DSCP selector support
Date: Wed, 11 Sep 2024 12:37:44 +0300
Message-ID: <20240911093748.3662015-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911093748.3662015-1-idosch@nvidia.com>
References: <20240911093748.3662015-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 29201721-123e-4c6c-b784-08dcd2458054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LLvyZLhdUrmvTpDej2Qz3lBzIyit8ZSPWYN9JO1vRA3me3AgLeYQEdTVIjnW?=
 =?us-ascii?Q?YQAkzQlfSj8K2lpZ4MpbnPd1UmW+kz5IPrE0Zk65wkhIPGCmSXJsbJbxGxfB?=
 =?us-ascii?Q?I5c6cym/JHrvmSgKQTwxTqjIgO0kmiB3pitGUZf29m7TcBo0OxL1EqjV+1H+?=
 =?us-ascii?Q?wVu9V291FqFZfqjmd8FEVAD93WTGgWJJJTl6mu2uaAnv5bFB/j9cr83EjXhP?=
 =?us-ascii?Q?FK5n1a5VPYiAvqxrptil3Ag8brxbFl/mtlvN1qiTQqrCmUqeyIjWek2TyonI?=
 =?us-ascii?Q?Ddvdnubzqu1DJJgzBQ1cl49TQ9GpI2NQ8kzehnZBJj75uabi4689JmKB04iK?=
 =?us-ascii?Q?ExYNrCMwMaLYz00KNWh7JHAAmMTHzt530WYbZx1cNP18wmjClVTSK8NdE3Mg?=
 =?us-ascii?Q?okFZb9AWB2EcGZBGkpD1UVQwBrjKQTGQEjdcCvE+aMJpPsl6mbQkYtNOYnFr?=
 =?us-ascii?Q?tlDBGwiJDW38q+8JsiERVb3ZTFWeQOykCgvXHMK9vel19pGP+vgJ8ht3geVG?=
 =?us-ascii?Q?SCTwTKbvploGCJFluFwJbfc2RdXAjPzdT5o+ztDhicNDVSjZ/7fP9seqs0Tj?=
 =?us-ascii?Q?hwWrY0uje2EIlt4yuaro+DjDDj2nB0DGmM9MsVVEEMpqVB/juSucDpMSJdpD?=
 =?us-ascii?Q?JeeTPAXicBbaSrQ3HeSQIJEMqi+v//NSebkb3PTvyWjq7gzyikdsVoPQqdqu?=
 =?us-ascii?Q?GzjXg5B7y0UjCrkoHCO6/XAAsMDxWjtgFOv06wsnogqD30cIopOcWqp9AAkc?=
 =?us-ascii?Q?/gINZM6fqnfnKqKpbok81/xPt0DMPZCjj4ersa/jSCh4aiI2gwQtBmfgEk7I?=
 =?us-ascii?Q?+wm7dq0WMPQqwU68VxW4jqippfib3tFdVLMW6KefBS+z/rd9qCu/1r7CBItg?=
 =?us-ascii?Q?PlyOwLyapByvGY0hC5Nbwvp71kV8BMXVmOSLBctxz1uf3nGBc/ej2Z3jTtHA?=
 =?us-ascii?Q?eJcHWiIb/IKcpGP7cbpCV6WSDhY3Bck3/dPiJLo40HlLmLoXVrF5jPq/XpdH?=
 =?us-ascii?Q?4l0eo1E/lTpWLfDc5AABiSKxsK9lHh1vW1/gkUC3Cvj3YS2HNoY2yhVVsAYr?=
 =?us-ascii?Q?Vc8SJn/fXxRhPboTeNQxjCIVf6psfnv0rde4mIQGx8bI9sDO8NPRPO1KU/cp?=
 =?us-ascii?Q?WtneTJrKU/no1YQUUlPBUfEPeHVEp3wzNs7WjjcDGBef3ZTU3XJf74yq0Pas?=
 =?us-ascii?Q?2uAxC9ObThdS41ze8isd2tsJft14a+vevz/X0h8N8uvT7k5Scf/d4kCL/kPM?=
 =?us-ascii?Q?F4ya+8Ie7U50Elk+Cohg6ZDs1evO/zQ+hpU7Cp8zVm9OH/B3Nu7ULV248GOP?=
 =?us-ascii?Q?//DBbZqhLEq2bvza2Kp7J/mXwm96w7foUFx4fnO9V79pUwy0VPpvAdYvDmwW?=
 =?us-ascii?Q?9TKL91U0+T9NVD5uiwXdY8Nzpams1BiLNVhaIALH8WO3rV3fB58e48CSovFJ?=
 =?us-ascii?Q?dB2OaIf+KxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:32.6442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29201721-123e-4c6c-b784-08dcd2458054
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194

Implement support for the new DSCP selector that allows IPv4 FIB rules
to match on the entire DSCP field, unlike the existing TOS selector that
only matches on the three lower DSCP bits.

Differentiate between both selectors by adding a new bit in the IPv4 FIB
rule structure (in an existing one byte hole) that is only set when the
'FRA_DSCP' attribute is specified by user space. Reject rules that use
both selectors.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/fib_rules.c | 54 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index c26776b71e97..b07292d50ee7 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -37,6 +37,7 @@ struct fib4_rule {
 	u8			dst_len;
 	u8			src_len;
 	dscp_t			dscp;
+	u8			dscp_full:1;	/* DSCP or TOS selector */
 	__be32			src;
 	__be32			srcmask;
 	__be32			dst;
@@ -186,7 +187,15 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	    ((daddr ^ r->dst) & r->dstmask))
 		return 0;
 
-	if (r->dscp && !fib_dscp_masked_match(r->dscp, fl4))
+	/* When DSCP selector is used we need to match on the entire DSCP field
+	 * in the flow information structure. When TOS selector is used we need
+	 * to mask the upper three DSCP bits prior to matching to maintain
+	 * legacy behavior.
+	 */
+	if (r->dscp_full && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))
+		return 0;
+	else if (!r->dscp_full && r->dscp &&
+		 !fib_dscp_masked_match(r->dscp, fl4))
 		return 0;
 
 	if (rule->ip_proto && (rule->ip_proto != fl4->flowi4_proto))
@@ -217,6 +226,20 @@ static struct fib_table *fib_empty_table(struct net *net)
 	return NULL;
 }
 
+static int fib4_nl2rule_dscp(const struct nlattr *nla, struct fib4_rule *rule4,
+			     struct netlink_ext_ack *extack)
+{
+	if (rule4->dscp) {
+		NL_SET_ERR_MSG(extack, "Cannot specify both TOS and DSCP");
+		return -EINVAL;
+	}
+
+	rule4->dscp = inet_dsfield_to_dscp(nla_get_u8(nla) << 2);
+	rule4->dscp_full = true;
+
+	return 0;
+}
+
 static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct fib_rule_hdr *frh,
 			       struct nlattr **tb,
@@ -238,6 +261,10 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	}
 	rule4->dscp = inet_dsfield_to_dscp(frh->tos);
 
+	if (tb[FRA_DSCP] &&
+	    fib4_nl2rule_dscp(tb[FRA_DSCP], rule4, extack) < 0)
+		goto errout;
+
 	/* split local/main if they are not already split */
 	err = fib_unmerge(net);
 	if (err)
@@ -320,9 +347,19 @@ static int fib4_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
 	if (frh->dst_len && (rule4->dst_len != frh->dst_len))
 		return 0;
 
-	if (frh->tos && inet_dscp_to_dsfield(rule4->dscp) != frh->tos)
+	if (frh->tos &&
+	    (rule4->dscp_full ||
+	     inet_dscp_to_dsfield(rule4->dscp) != frh->tos))
 		return 0;
 
+	if (tb[FRA_DSCP]) {
+		dscp_t dscp;
+
+		dscp = inet_dsfield_to_dscp(nla_get_u8(tb[FRA_DSCP]) << 2);
+		if (!rule4->dscp_full || rule4->dscp != dscp)
+			return 0;
+	}
+
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	if (tb[FRA_FLOW] && (rule4->tclassid != nla_get_u32(tb[FRA_FLOW])))
 		return 0;
@@ -344,7 +381,15 @@ static int fib4_rule_fill(struct fib_rule *rule, struct sk_buff *skb,
 
 	frh->dst_len = rule4->dst_len;
 	frh->src_len = rule4->src_len;
-	frh->tos = inet_dscp_to_dsfield(rule4->dscp);
+
+	if (rule4->dscp_full) {
+		frh->tos = 0;
+		if (nla_put_u8(skb, FRA_DSCP,
+			       inet_dscp_to_dsfield(rule4->dscp) >> 2))
+			goto nla_put_failure;
+	} else {
+		frh->tos = inet_dscp_to_dsfield(rule4->dscp);
+	}
 
 	if ((rule4->dst_len &&
 	     nla_put_in_addr(skb, FRA_DST, rule4->dst)) ||
@@ -366,7 +411,8 @@ static size_t fib4_rule_nlmsg_payload(struct fib_rule *rule)
 {
 	return nla_total_size(4) /* dst */
 	       + nla_total_size(4) /* src */
-	       + nla_total_size(4); /* flow */
+	       + nla_total_size(4) /* flow */
+	       + nla_total_size(1); /* dscp */
 }
 
 static void fib4_rule_flush_cache(struct fib_rules_ops *ops)
-- 
2.46.0


