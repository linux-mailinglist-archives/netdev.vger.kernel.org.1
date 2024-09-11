Return-Path: <netdev+bounces-127310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E5974ECA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90929287661
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232B155346;
	Wed, 11 Sep 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwtHlKNf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196E17BB0D
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047515; cv=fail; b=MAUFaLZ95qcFlTuGxE6Ors6lXd09mnkkUkR8Q1e3K7m1F5+WPprGR/Yt6wtklwFk5t6ni+Hww/J9JnmI6rtCBzraKnmDi3ocR7xe3EgtaweOPe2jav3YWNfk/qSlS7MW1xG51DmqXN52TmEpjeamRgcEGUYzFfAeP3eAi6nNIss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047515; c=relaxed/simple;
	bh=yt4SmNf5hoi3KHwArIyKrRYIyNn1RlouTVs/Vjfebps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1C/S8ZmMq0Kq8qIzp6dX0k12F2yP4CG7KGzLkVm0FrFHTih+yWvfaEgJD2zNmVvukLdn4m0Tyt4UMkI+DKHjCnTlAUXji24aO40x+tbVFPaE+IpZF9ClRF/apVrclNDe0neMZOuU+v1sajoRBVHlgt5yrghUV+5b0elSPl/Tp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwtHlKNf; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSvzV23EMODatDUnQuL0JmRUKFs8pHfWWs8pMiOA5G0B6qZC5pDzOWVJyk5VFeDmevDEZtTTQ8cMbB8XCTEVrMYMerxzlxd6wr6+bnGWBG1oimXs98VukS8ktHe8eXYd/gar5xVXxjEJPO63ajssQtPF2GbBw7IpXR+fMTJKsrMBiuIrFoNJP0EKnzixPNRK1wWpsT0Z3P/CbEvJnF1GbrEh8JOpBgoX8icBpJ/TB0Co+eFc+m5oCp6MQxomRYuottg0reMLTn+f79+9d4SVIurobwwIEN4fXBYLFNZM0DZxMPexJiRggkPsSAcoSsv43rHTVkl8K4AV9x4zOt3lgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/khUBJyvSZlDwnsk71M+7WrbfUVT6+Q27PMLCPOKM3s=;
 b=YWI8E76xifcLGwWHhjWRZId07HB52YZAHXdfEq+JKwh6x1efsMMpkjCPfu+8LEldXjtTUfprNqKU8AZx+Dr/ie0AgrnDNfo/hnBWTx3hz2XQmjkKRVo/YjZ2gmlI00gUss0BA51m+clsRNdPT8+diCVUWocHW5InFjH2jYm1+UWS2s7kKo+MxrWeBKLDj5ofdlUM2ASIXPUt1Hfj2+j5Q28ilMa1yn2wrXsLQPHgVrrq58tIHtDdtVctLOoWH0arqu7JyBzk+YxAj+EkqbYKOlxra7Eo99BGuXV73ocEaO8FN/G4aW3pZlqm6I9PmoraiicGgGPSWLskvT9s/Z7LSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/khUBJyvSZlDwnsk71M+7WrbfUVT6+Q27PMLCPOKM3s=;
 b=RwtHlKNffzhSHwku8Zmnf6O/UGuZk42Zax1ffg+D6z+Xs0crsM2w744wp7evugM16Qt4jJnJrVwmmGFfJgEYBHAtvnaVnbWDMsYr3io8YotMqWNWlahwAHPD8AasnE5jxE8PxudpG2zUGa3jEFZkJ09HY0xQoeXMw9cBnoVRyiT/3UfqOPPGNuNQwLFjcXy1RdASLWCUwfdcEHraGMOkjf6I5vdvnKI0vAr9GOIojccyH38ptU0oeZoZ+dvCO8T5i+lVOQH6JKmRbuUccCEqNLk2g9yPBflEN6gYlrEzPR5hQn+WmwxmvS3/gOB48P5MKMa2+w0vOYiBbV0dO3vcEg==
Received: from CH2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:610:5b::25)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 09:38:30 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::13) by CH2PR07CA0051.outlook.office365.com
 (2603:10b6:610:5b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:38:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:20 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:17 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 3/6] ipv6: fib_rules: Add DSCP selector support
Date: Wed, 11 Sep 2024 12:37:45 +0300
Message-ID: <20240911093748.3662015-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb6783c-00dc-41c0-f0ab-08dcd2457eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4zsCBMz0XqFZHvk7Z0iJQAQubquD41ISLPA7quRK4nm405Yi+RJM1VE22OH?=
 =?us-ascii?Q?dzdjeGAa1t1Jcf7LlkzGZ5orj3vaHe4hxMakDC9FkhanHCwfS571DgQMmbFV?=
 =?us-ascii?Q?TLoIUqoFJ7JFA6phFwkwMdqLOrx3l6+AIlGYXOmrLDzAWJLqzN8o+CEiAA1T?=
 =?us-ascii?Q?8ohz5qnXx09YWk/mSkYwmGa8OdFSNarMdnw1isTiKEcbnUxXIOY8LXaNrHSF?=
 =?us-ascii?Q?SDX2ooZIhhN7pWT8nsQtnc4dAiJc0S0JM4WmXBciMxahUycIK8ywk4Igp1OQ?=
 =?us-ascii?Q?CBnTY/KUTRWUVTHp5cs8Ritzaf/RLXnZbMUjRhWZtF76qND3MuCuRz3DnMkV?=
 =?us-ascii?Q?7Fraovv1k2pqHNtVqq0p0VGBRetj+sv8iWUubJZSKAQVY+pTmGIqXQy4PEgL?=
 =?us-ascii?Q?iM0ssblXHJF7Wn2j9fnR4Rs4kwmltzk2Cx6W2UAipYzxG9r9WpXTooWKQucY?=
 =?us-ascii?Q?pz1jSErQB2oGzbnBM4oUeoYuOlocpmYn0PatMjCQ+WpQ1/V4cY/7YHN6ux4z?=
 =?us-ascii?Q?lfYC2DSFG7hta8LOcehZIPuT5LWUhIJAz51MvS3zg9hJdgq9DutC2kODTvKm?=
 =?us-ascii?Q?qnSoaWwVK9ZLdMn2oNAO8HkhCxr/A6RRVhrXvLlh3ezOHitCOKcANR+Woi6b?=
 =?us-ascii?Q?JZjxM8O0eFqzbayzpHczJZORoBd75jgrqQT/VeyZFBHlZUClMA8F78uW5+wa?=
 =?us-ascii?Q?upn0dNiVr/bWMSPAk7yBdsqG66fhoetdTGu9vyG0+gTaFXFrhqYmV1vW3A59?=
 =?us-ascii?Q?uWzPh0SYcTUSyJfS3XK7HwRMkTmDctaH+c4lMLHXKTZ8BY3lAXF+qhp/Gh37?=
 =?us-ascii?Q?ImJep0JzAUGAbH7OwkHAQeLNNtTdzxoh6cOgfxlTuUDqj1PVTURyzizIZuA8?=
 =?us-ascii?Q?s+6z6iapwkDs6V2YRRrkTfF3Q1sFBwJXRdZLDJLJWNw58GoHauDuLFjEgNuS?=
 =?us-ascii?Q?BRdRR/hEF9LrmNWat9mEKN5BCh7mRfP4OSwzdx2Df6Vf9mOCN3SqLRMfrBmg?=
 =?us-ascii?Q?JVXSSdgLMRyyhPLpTO0lkalNxfq5tE4d+LTiKUO75txMKfnizBynF1ZPxURF?=
 =?us-ascii?Q?vTPcwjSduy5GYjtGWWy3o92u7FUWfxk8Bztz9PeZ9g84rgNIVWPUx9gfztf5?=
 =?us-ascii?Q?Knqfkn/y66MwI5IxkylGAEmnqy4g3o6FyGL3oQoGsPLMVMTAyW9FgzM1xdIX?=
 =?us-ascii?Q?j2BB6cgVDvaLMFq69BLpcjF0+O1+Ox9MXBCzU0K5m/ajWINDxcceJ2uGJqH3?=
 =?us-ascii?Q?zcHK3WsAygP+jhTK9gqiPQzDD+uEi1Am3sQV8GQ5rMKSRsUzh9zpNt7w4v7a?=
 =?us-ascii?Q?sTcZ4c7K3p35cnPGuh2sd8ik/pr70IoZRsfb2JMYaQcn6Bt+NLMvZisWBZgf?=
 =?us-ascii?Q?pxvgZMi9KwqLAP7/JByAQ1hgWgv6KREwG6ajUMirVU5BZBtNpxHRKwazIgXc?=
 =?us-ascii?Q?8vL4oq9W93Gj74Pp7bp/qlTcTrTTyChr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:29.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb6783c-00dc-41c0-f0ab-08dcd2457eb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663

Implement support for the new DSCP selector that allows IPv6 FIB rules
to match on the entire DSCP field. This is done despite the fact that
the above can be achieved using the existing TOS selector, so that user
space program will be able to work with IPv4 and IPv6 rules in the same
way.

Differentiate between both selectors by adding a new bit in the IPv6 FIB
rule structure that is only set when the 'FRA_DSCP' attribute is
specified by user space. Reject rules that use both selectors.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/fib6_rules.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 9e254de7462f..04a9ed5e8310 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -27,6 +27,7 @@ struct fib6_rule {
 	struct rt6key		src;
 	struct rt6key		dst;
 	dscp_t			dscp;
+	u8			dscp_full:1;	/* DSCP or TOS selector */
 };
 
 static bool fib6_rule_matchall(const struct fib_rule *rule)
@@ -345,6 +346,20 @@ INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
 	return 1;
 }
 
+static int fib6_nl2rule_dscp(const struct nlattr *nla, struct fib6_rule *rule6,
+			     struct netlink_ext_ack *extack)
+{
+	if (rule6->dscp) {
+		NL_SET_ERR_MSG(extack, "Cannot specify both TOS and DSCP");
+		return -EINVAL;
+	}
+
+	rule6->dscp = inet_dsfield_to_dscp(nla_get_u8(nla) << 2);
+	rule6->dscp_full = true;
+
+	return 0;
+}
+
 static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct fib_rule_hdr *frh,
 			       struct nlattr **tb,
@@ -361,6 +376,9 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	}
 	rule6->dscp = inet_dsfield_to_dscp(frh->tos);
 
+	if (tb[FRA_DSCP] && fib6_nl2rule_dscp(tb[FRA_DSCP], rule6, extack) < 0)
+		goto errout;
+
 	if (rule->action == FR_ACT_TO_TBL && !rule->l3mdev) {
 		if (rule->table == RT6_TABLE_UNSPEC) {
 			NL_SET_ERR_MSG(extack, "Invalid table");
@@ -413,9 +431,19 @@ static int fib6_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
 	if (frh->dst_len && (rule6->dst.plen != frh->dst_len))
 		return 0;
 
-	if (frh->tos && inet_dscp_to_dsfield(rule6->dscp) != frh->tos)
+	if (frh->tos &&
+	    (rule6->dscp_full ||
+	     inet_dscp_to_dsfield(rule6->dscp) != frh->tos))
 		return 0;
 
+	if (tb[FRA_DSCP]) {
+		dscp_t dscp;
+
+		dscp = inet_dsfield_to_dscp(nla_get_u8(tb[FRA_DSCP]) << 2);
+		if (!rule6->dscp_full || rule6->dscp != dscp)
+			return 0;
+	}
+
 	if (frh->src_len &&
 	    nla_memcmp(tb[FRA_SRC], &rule6->src.addr, sizeof(struct in6_addr)))
 		return 0;
@@ -434,7 +462,15 @@ static int fib6_rule_fill(struct fib_rule *rule, struct sk_buff *skb,
 
 	frh->dst_len = rule6->dst.plen;
 	frh->src_len = rule6->src.plen;
-	frh->tos = inet_dscp_to_dsfield(rule6->dscp);
+
+	if (rule6->dscp_full) {
+		frh->tos = 0;
+		if (nla_put_u8(skb, FRA_DSCP,
+			       inet_dscp_to_dsfield(rule6->dscp) >> 2))
+			goto nla_put_failure;
+	} else {
+		frh->tos = inet_dscp_to_dsfield(rule6->dscp);
+	}
 
 	if ((rule6->dst.plen &&
 	     nla_put_in6_addr(skb, FRA_DST, &rule6->dst.addr)) ||
@@ -450,7 +486,8 @@ static int fib6_rule_fill(struct fib_rule *rule, struct sk_buff *skb,
 static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
 {
 	return nla_total_size(16) /* dst */
-	       + nla_total_size(16); /* src */
+	       + nla_total_size(16) /* src */
+	       + nla_total_size(1); /* dscp */
 }
 
 static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
-- 
2.46.0


