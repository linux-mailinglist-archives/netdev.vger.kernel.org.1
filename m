Return-Path: <netdev+bounces-218655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B32B3DC74
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ECD189D2A9
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4B2FABEB;
	Mon,  1 Sep 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRBz5naN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79B2FA0C6;
	Mon,  1 Sep 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715581; cv=fail; b=H6ahAloAFBOQ8tYmVzRsw2DSe63lk/YzedLWSRrqy1S0kbqqwBi9a4Sad4cwGsPeCDl848jXvtIGyzeJWz0oAP06hQMni/xe1Q/WEamO6tMxADStG0CLYxxMYSQvDRfvjM/4ruGTTMszBSjTMWiaJezW0v2R0Qu3RBbsybqta+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715581; c=relaxed/simple;
	bh=mZYzsiFwxoE+HCdk0GNHD8eE5Eiv46/9isbf5ifXrJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCF1ibokiFXprb9mxvOZiXn/Y4AtnDbil7HZ+O5c8bqIggUa1kcl1GQeUiTvo2ehPy2uPrIY+ZZu6tKj8DqSRrQP9UjCbfjVGLbGmne8lfmZHQlc23abEWWKwPiAT0Rd+nLYEbwVQztxLf9v/WuFYKlqv5KmWKg6DY6m+JzbqlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nRBz5naN; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3YYvEZPtx86PifBjrGmV7gD2iBz56mstEJhtq7aHriv3VpWWiYS5YljqVQ8cZxnTICssfj4ymzXoiqvXgfDUZt45S0Z5l4ov+/nxvgPNfKV9wVkPoHRMrMHbbPMjmlt6411wNfnnnuo62illa0sjl9bE3DM+jbAaDCIU4LocD2uQRR04mzud3nVFsQEeTKoOrpIIqCSJXUo8DzQY3BTRiUneiRcvzz9axVt6QXqUEnw2Aj6mKTF8TTYRcsF6D2D81cpno02N9n8aa8rqxiKAb5E/eA96TYDeoFOplqRIcHpIz5Dggp5uNXnI1WRV1GtrWoTzDRrUoPNNnt3aaUnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPx65eLImKAw5xWeIWS3LcNtWbYBB3nLW34VFzKn9kA=;
 b=elJAv4M2jYAJ+yuqqnEygNF/H9UFRWpW29q3rqhA/3Kmx4DWKdZJmABddCO+vQrGSmaFpShFXLsBuQh7HecaDUbvKSaeeUcF3W7v7rlB44QhRXni1AicYeUB9781jKFyHw05HaxnUw91ht44HjTD5556nNW/9Uv0xQ1vn9xb27R0i+hSO0FDaE32ruXSny+ELYTpgxqNutXWpzeYWB/07qqg95AEllnpqodqOKom7yp+/i290XEJh4huv/GezGfBT10TiA1LRhpGzTlvHXl/wZpUKO9GS/MLlI6lbB8+XVRyK2byadM8l3tLsV6aOtu7DHgmhHSdBHn1EuusSwqVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPx65eLImKAw5xWeIWS3LcNtWbYBB3nLW34VFzKn9kA=;
 b=nRBz5naND+wbbwi31aR6Hk0jR+TStzIe95mfr5dOE/h0AEopbyH+2fCUtgNtOs//qBytnIg6IwOflteriLOr/vrGGiwWBiVjA5uzcUnpq6S3CQWZmO6qxZlAYCPwY+KYMxLjLQCCQYZE4e/z+s14SQMgFNCYXvHI80LXAmwZo2SBoyeVUQB+I2cTa76igLVRKJ1pbGNq8MI4l9Pw/o/TQNoYML7T4Kr1SAb/03I6hOjoaVll5aEb4Ksm4KGmOps1BPQO4KFhbDzvJMHtFVcGWPCjalSkHXVeZfH7ouv+fEoov8QxBNjfCeOgs4hrUxchQZxThD+R2wJGn0FOKy7L2g==
Received: from PH2PEPF0000384B.namprd17.prod.outlook.com (2603:10b6:518:1::68)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 08:32:53 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH2PEPF0000384B.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.21 via Frontend Transport; Mon,
 1 Sep 2025 08:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Mon, 1 Sep 2025 08:32:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:32 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:28 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/8] ipv4: icmp: Pass IPv4 control block structure as an argument to __icmp_send()
Date: Mon, 1 Sep 2025 11:30:21 +0300
Message-ID: <20250901083027.183468-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 97919ad3-04b3-4857-986b-08dde93224e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSYyTWaqRN4c0xdO+oZxjcLV8HTPBvW4qyK1DNB9c7zgiw5Y854c1N/Ts0tG?=
 =?us-ascii?Q?sSv85jsAtB6/3HYyYtto3T0zZ9oEjPl/2fAkktlD7WtsOEXTG6qxAcNRnMpo?=
 =?us-ascii?Q?2OJ+igb3yRe//izmJOMQOZ7vw9rJlHCc2RLusdCHWcUxnP+53/gQc0HqrG+2?=
 =?us-ascii?Q?5Z6oMW2GpOrO238Ad7WJH+PYpXv22FaIVs6oOJTP1VeUMh50s/5DKb6+hPAy?=
 =?us-ascii?Q?BQEd2jm7icxzRPLEX7E9+1aCyL+Vyv/beI8ymsVlg1BCbmsjU9DxGT+AerjA?=
 =?us-ascii?Q?G9q76BJn1DW9882MbwBkhlMkLmuRuqckoghGivnz4776exxNf6xHWg/5cbNf?=
 =?us-ascii?Q?035MZeXNs0ndbd66dr7sjcwiR+0HrfSwK7vOJXHV4QwMWqwoO7FY/sjJ20g6?=
 =?us-ascii?Q?hey6xvMLMY6tiQsf9d55iszoa6pftVPu/Tk8MHNdaGYNAEDBFJyjpgCFtwm5?=
 =?us-ascii?Q?XSTsN3ezHIIwY/UBmvXf/XOs5f3OEHKX5FH1DaDjxhTkaokCSdUcqj+tYckU?=
 =?us-ascii?Q?lvJwSVb8AjO8HQk00OkxelSfymtMohjDupKtC6kfOgAxDtewKftplPmdrMcG?=
 =?us-ascii?Q?YKQG0Tkm+jFzM7wcnVM3034kv6CeG6baxxf3ccwuM1XZtAT37qPs72xvpoi2?=
 =?us-ascii?Q?JVrK8x8KkOEuuDflZzPrFvUSZCydfGqaVFtLEIcEWxqHDlg2oSfWIiKCvqPb?=
 =?us-ascii?Q?qj+4NOtsHZ81qtaFIt/LeeTNHoFWx4HOySSDGAx7lFojNGQIVx3bZVfZrJmI?=
 =?us-ascii?Q?koZ8ZYaUCaRaNrA4In6rwL1EC06C9N9y6T2JF+k8k7Zqp756w/Nob4yXhv1K?=
 =?us-ascii?Q?04BgeTOIzG56C8JMLpz1GxH6iPa9Jy3eaPGYp4+1IvKa57Kbt+CgFzY8yqWR?=
 =?us-ascii?Q?sG52UQd5qR5eyMsI03UrLVYHY4sFZQW2X+r2A4JSY/mL4y6mzzKxdEmF92Ar?=
 =?us-ascii?Q?BILqb+On3gmi68YVXNiuyKRJR2jqbv9qec1mld7OvHbobRqC30I1NlCbbc6o?=
 =?us-ascii?Q?wx63Es85vKQN3bhDQzBFbIZeRD2oO3e7T12Pguepjov1ezvqyQfhMes7/j5S?=
 =?us-ascii?Q?jJpYGdwFamK1CMkoRGnPyzVxLJVKqEe6h6x1FamRBgy7LuNcTX4BkolJrs9E?=
 =?us-ascii?Q?wKP7UHZwDvQ0NddZnQ95x/uoOP4NwUxCca1TjWr1M1hN/HbQwQrt8QsIbemR?=
 =?us-ascii?Q?EQR0XJ/ydk8K+7GPXLLvbVT0jjiq/N9nTlGzJPO816t3+L+MY81zsu/RZ1qh?=
 =?us-ascii?Q?mv/9xlZNKTEe0Gz3nF6vLNNzt7znk20sSaecGJAXQSzEM/GQa6LDZFFMRjeH?=
 =?us-ascii?Q?jBnHnjG9pQyTB29QjoLpSrkrqo+0GZgViPTXiU0LS1GmRuUJK4LoC/6E5zA/?=
 =?us-ascii?Q?ld2nZWq2OqE8oA22gBNsP060VxYrYCFqbJ+pwWRlp+PRoeIaYhp8/VZzGiBq?=
 =?us-ascii?Q?eF9TBEopxlKocC41j2YHrD4oTt4wmopc99tUN18D2zK7u8EJzVZQc4NG2oiE?=
 =?us-ascii?Q?soKRM8+zpZi1eodZ52B5+BxTlwb0TJbe20LM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:32:53.1647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97919ad3-04b3-4857-986b-08dde93224e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

__icmp_send() is used to generate ICMP error messages in response to
various situations such as MTU errors (i.e., "Fragmentation Required")
and too many hops (i.e., "Time Exceeded").

The skb that generated the error does not necessarily come from the IPv4
layer and does not always have a valid IPv4 control block in skb->cb.

Therefore, commit 9ef6b42ad6fd ("net: Add __icmp_send helper.") changed
the function to take the IP options structure as argument instead of
deriving it from the skb's control block. Some callers of this function
such as icmp_send() pass the IP options structure from the skb's control
block as in these call paths the control block is known to be valid, but
other callers simply pass a zeroed structure.

A subsequent patch will need __icmp_send() to access more information
from the IPv4 control block (specifically, the ifindex of the input
interface). As a preparation for this change, change the function to
take the IPv4 control block structure as an argument instead of the IP
options structure. This makes the function similar to its IPv6
counterpart that already takes the IPv6 control block structure as an
argument.

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/icmp.h    | 10 ++++++----
 net/ipv4/cipso_ipv4.c | 12 ++++++------
 net/ipv4/icmp.c       | 12 +++++++-----
 net/ipv4/route.c      | 10 +++++-----
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/net/icmp.h b/include/net/icmp.h
index caddf4a59ad1..935ee13d9ae9 100644
--- a/include/net/icmp.h
+++ b/include/net/icmp.h
@@ -37,10 +37,10 @@ struct sk_buff;
 struct net;
 
 void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
-		 const struct ip_options *opt);
+		 const struct inet_skb_parm *parm);
 static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
-	__icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
+	__icmp_send(skb_in, type, code, info, IPCB(skb_in));
 }
 
 #if IS_ENABLED(CONFIG_NF_NAT)
@@ -48,8 +48,10 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info);
 #else
 static inline void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
-	struct ip_options opts = { 0 };
-	__icmp_send(skb_in, type, code, info, &opts);
+	struct inet_skb_parm parm;
+
+	memset(&parm, 0, sizeof(parm));
+	__icmp_send(skb_in, type, code, info, &parm);
 }
 #endif
 
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index c7c949c37e2d..709021197e1c 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1715,7 +1715,7 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
-	struct ip_options opt;
+	struct inet_skb_parm parm;
 	int res;
 
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
@@ -1726,19 +1726,19 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 	 * so we can not use icmp_send and IPCB here.
 	 */
 
-	memset(&opt, 0, sizeof(opt));
-	opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
+	memset(&parm, 0, sizeof(parm));
+	parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 	rcu_read_lock();
-	res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+	res = __ip_options_compile(dev_net(skb->dev), &parm.opt, skb, NULL);
 	rcu_read_unlock();
 
 	if (res)
 		return;
 
 	if (gateway)
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &parm);
 	else
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &parm);
 }
 
 /**
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 823c70e34de8..92fb7aef4abf 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -594,7 +594,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
  */
 
 void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
-		 const struct ip_options *opt)
+		 const struct inet_skb_parm *parm)
 {
 	struct iphdr *iph;
 	int room;
@@ -725,7 +725,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 					   iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
+	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in,
+			      &parm->opt))
 		goto out_unlock;
 
 
@@ -799,14 +800,15 @@ EXPORT_SYMBOL(__icmp_send);
 void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
 	struct sk_buff *cloned_skb = NULL;
-	struct ip_options opts = { 0 };
 	enum ip_conntrack_info ctinfo;
+	struct inet_skb_parm parm;
 	struct nf_conn *ct;
 	__be32 orig_ip;
 
+	memset(&parm, 0, sizeof(parm));
 	ct = nf_ct_get(skb_in, &ctinfo);
 	if (!ct || !(ct->status & IPS_SRC_NAT)) {
-		__icmp_send(skb_in, type, code, info, &opts);
+		__icmp_send(skb_in, type, code, info, &parm);
 		return;
 	}
 
@@ -821,7 +823,7 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 
 	orig_ip = ip_hdr(skb_in)->saddr;
 	ip_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.ip;
-	__icmp_send(skb_in, type, code, info, &opts);
+	__icmp_send(skb_in, type, code, info, &parm);
 	ip_hdr(skb_in)->saddr = orig_ip;
 out:
 	consume_skb(cloned_skb);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 50309f2ab132..6d27d3610c1c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1222,8 +1222,8 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct inet_skb_parm parm;
 	struct net_device *dev;
-	struct ip_options opt;
 	int res;
 
 	/* Recompile ip options since IPCB may not be valid anymore.
@@ -1233,21 +1233,21 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 	    ip_hdr(skb)->version != 4 || ip_hdr(skb)->ihl < 5)
 		return;
 
-	memset(&opt, 0, sizeof(opt));
+	memset(&parm, 0, sizeof(parm));
 	if (ip_hdr(skb)->ihl > 5) {
 		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
 			return;
-		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
+		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
 		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
-		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
+		res = __ip_options_compile(dev_net(dev), &parm.opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
 			return;
 	}
-	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &opt);
+	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &parm);
 }
 
 static void ipv4_link_failure(struct sk_buff *skb)
-- 
2.51.0


