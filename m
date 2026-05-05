Return-Path: <netdev+bounces-284255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFVvGleo+WnF+gIAu9opvQ
	(envelope-from <netdev+bounces-284255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 000114C8951
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 301AB30684D5
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA973D565E;
	Tue,  5 May 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sfe54fz+"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD53B28D
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969064; cv=fail; b=rOlepmyw3tBAMqHdQ4B1eiKoOZukKRHznl9HBCbOGjJGYlxN0tMxd6IH600f53sDcjcK/66TFj8c+Cg5MZA26wa5yVibxsN5LNzGOchPF04L3fdGJN3jt/lA1wgoNDfL3GH1KVNP53YsJNku77KOyNzBXY+vyEaXkoCPV4Toql8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969064; c=relaxed/simple;
	bh=fx0pypUI2T5VQjiXqS90n9MLjDfOfstC3v63wTfwaBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcYV8a/I90j80dQ8OboVrgo48GnWrtdXTLZy8+vrFO29MGpTDi/NMeIGSy390Ptg4rWq1i6dsRZACvYe2gCy6hA5mSIT8dnyIXlSELwZISBuIFAfi7MYGwdh/N8paPBUPZStF4cEGst/BfddfYzOC8mDseyz+bx92D+LjZD5iMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sfe54fz+; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOLyJ1MY/pl06GAk9zUn+wb8BsEoQY+UNsT3/A769udJt3kqJBVQlBjNerha6piTYyUWF/nrkvLbP2m5tX3uUhPIlY71uQoIQqlRemvkqTutejfBQK8kAjp2ZpgKRQFvWgxSYSq4yDzTekBXW2hv9DZvMmozh/RVHbpdOwfJYehzZPd2UawVGGOpBwVedPf33skrWzsSNedBm3rDWUrRoXjsTYFrDDscBxuPAY5X4bA9kacDhVAzgxf1Q058tvv0flTZQMcXOmbRP1wYZqTd0+3c8SeWXl4OrmiGfJ7rExPhxfaxh8DRo7OFyXEImTkXKXWoH+WQMovRPUaC3oHqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqQQvHAe1jY4kGfaZP8He2oY+/3NqxVCkHc4kRxFCpo=;
 b=oKpEbRi/7S4mo+qAq97dPJzntomLuOtFSFROfAGZC3OVqN1lVG2+EzX+kcr1N+3JAWe9L0cy+RZS+rYYAatR4W8/OyaRHest1HjWAXn8Gcj/dyKZf4Ko9b6N1O1zALJZm8a84szENbn3peaJGgI8IJeNPuSs6Zj77MCkze+NkRfgnNFvsEu9AgYzbiVARPaHQoiDbWuLMJlD5nqyy9DRPYRaxC4nvJy1RMiWzkaAjRBJi0/Z3N1D8LH2oh3fhYcTfLThuoYEGFLfvk4yhUHL4NHI/uQtOOTCtOOC5CyhAbccAVsmTNFYtdmrUZzKkbv1PbhrBeQ0BFa0f8IEBmGE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqQQvHAe1jY4kGfaZP8He2oY+/3NqxVCkHc4kRxFCpo=;
 b=Sfe54fz+dV66gUcRRF6Xd2/gqJ88RKLjdmZZIqBvGRyGzE67QX3oLSzA366MA6wcvh04KFWQmGgHRAMaX+DsCqdCj7eOCuBRHR01/wACxaLZPbtyrsjraH37PA4sw9U2GsA3R6Ko0AANUa+w+Uf28snBoAPZH0HEBZVX51jwSptY/31cOZxcIytrlJ96iUhrfebYAHpscUo9i3kmliJ1qLbr6lSe17dcZ83Jgt6l0ubEGTLtM5wvhuX3tUfswGl0b9AncxWzY8QEfhOxyXna/A3Ba/BBult1/K8bAxP9dr5p5I4itu4SQI7DAmgnpzGFsTGVFTHE6lr/gSbwht6PSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:17:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:17:39 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 1/3] net: Do not inherit operational state when protodown is on
Date: Tue,  5 May 2026 11:16:53 +0300
Message-ID: <20260505081656.463158-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505081656.463158-1-idosch@nvidia.com>
References: <20260505081656.463158-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edf56e8-5131-42eb-fdb4-08deaa7ec5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A645dRREDy8Va5RIrequptGSuNT9xkYEHh6w886mSL218xEVVllZUQ0wsg+0S+rm+UXDbsHMulRZ6wWXdxyp78Hda3TP8wFe+wbUCFPVp6IXezNuVJWkaB6BaQO6A56ttiX62SDH4ht5L9Yf/emwMx5aAkpPPRFBC4VdFHVQ3DVEUj6Ti4+7Q15JEWbjBK/YmRtc98yf7tatJFoQnLN0GJJIjA0NwLKtT0BBtJuGdj41gnb4zmVLeViZ/YqEgCN3sIsRnVqB/uy/+1mwSd224XsHwyH/cpYNzW4/1oi4BTKyseUcKe64yL89Xbuj8WeCinriJlLF5G+aFz3MIZ4bLrHFNZKWPUjcexi5qTu7ywzSFiqU0QCa0rzp51sNRdQ1bvtxER4iQ8N/RpMu1z9E9o8b+obhwBtm8CGqk9BmGJaDeMRDNZ9kX7cUeoEX4dnL96nvRm+1Fzit/ZZa89xuNf7a3bBVcF5IrVmwLNMgkWmK6xRwGyOas0Yb1dNonl3wOuPjreOCgWU3l6UMbvhMoe9pkdNwok0/WpLc8UZ924EuQWpvwKmjh47tvTmmdvUxKuk9BCWMz+qNihJ5fn8G5+Ta7dk70QBMBLq1fcT0Ex0Jlc6UlelNvHsRrRaUH8xe3IHGpHXl92fuqbXoUtZbLbq3247I/JXSGAKe7RlNml5JyqpeeB/czJXF5js+g9yt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTokk/k52R9wG+pipCEzswC0uaGVrrrbmaJUrMw1BZFszCQhJc/EWkzHKSo/?=
 =?us-ascii?Q?nZ09rNq1JN14zWINNaS5IydgEQ4LxUOEeBaYoQ43ls4i1AYXupKKC1P+KaKI?=
 =?us-ascii?Q?HkJPNaXgPRnNkaQ5YI6DLkaxtVCN7R9BdOF1xiFSaOa+HGAKGNdjBVNk24bP?=
 =?us-ascii?Q?x/1uBB9ab+BvodwYvvDcEbfOwfSwh5K8HELA/QpuMSF8Xy/92suU7AFaa1Fi?=
 =?us-ascii?Q?xdhJCbMKe13tVE60fvFz7hD1gonY2SyOkoUgXPU54hsvlvNhPCawmTE5PdcK?=
 =?us-ascii?Q?EzNlGZKsQe9/lITh/kdeDgvs9wBZtnZgzqIGdlAbG/wVlR1oonP4jpTPNuwk?=
 =?us-ascii?Q?FMHDX4u9srB1f2aX1zwqdSCihjsyyMhTzdQ7CohxWfkAoQQuB+nd1Ys9AGR1?=
 =?us-ascii?Q?CZc5h0S04/pd/kKCiigvEKWoQcAMlFyqX4qUlS2lb/1ORUln4N6zgYCEFC0q?=
 =?us-ascii?Q?2hjSMB2iX8tQXyAOGBV//nqTpLSjyeQWVXeEIOEk20k0ti7ZeZgLm7Za2ukg?=
 =?us-ascii?Q?1fFItmrvCAUfvjITJgKpAynMf8VXqdfJUQspNWMV9R3T2CQbG3vqkzrTrqDx?=
 =?us-ascii?Q?lTsuKkBbp0pRpZiOieuNAZfUNbTUTMwyOkjjR0Wd5egBanGI9o5mZhrmpisq?=
 =?us-ascii?Q?QKGUJgrHuDjCRv5Jmcm/BrwX/VzgnlZu7MZR2FURs6aOucLqx9MBXdPhboUn?=
 =?us-ascii?Q?SIf3yYEsLO1iW+vsaRHNIYtQedDGfRyQf7MdcD7DVSZPu4qqbQqwP484SIWO?=
 =?us-ascii?Q?VckSvTh8Py9u0pitIlGaiLOnVMqQdCC8JR1QhLP75uVDLKEdxtzq/bhVPgGs?=
 =?us-ascii?Q?FbiVtohwmP0xJdXwjqT+IKrDhR6ibFqsSg37g7O2tmgxpqZECziw3gY4ekFC?=
 =?us-ascii?Q?VZ6mfoMWG8mOxdtDfJ/YlVfxw3zkfgAYHv6wwFdjR6++WFtnnYwjQGslBP6C?=
 =?us-ascii?Q?nSBr6w+9yhj/btAhrbfd3B3WZNhqzfUL4Ijg1ruTXaG11MZrgG6mLiF0HOwa?=
 =?us-ascii?Q?+EAt6GEPSl0JLrVh6u7uxkYvX3+/c9eilD8oCSRbsp7k2OVjn3taLvo0heMU?=
 =?us-ascii?Q?aYBWehQLHH+IPQ9eil7qYTKNItHTJVehuYxv6KmtgKAX/zrTjrOY5U5CO/R3?=
 =?us-ascii?Q?llDCXoWIf7LIOSXrBGc7fJkHA+uUIGS4pXvnGeBdK+I30x9Pz3jPJPpW8Um6?=
 =?us-ascii?Q?CjackK4pP3SMnnhm3gApZ8eaLIe3C4Z9DbEEXFroaiTXreL492HW6ftEiCoa?=
 =?us-ascii?Q?dlRvBmn6usU7vsVyfjzGb0+wbwxRlFmqTi3li5RsLQ7D7Sd4PtILEPn0xtZf?=
 =?us-ascii?Q?Q2a9uDOgl1NaWf8egcptYita5lwIBKsSSKjzsU+KXTRXHC9szy+nE9EnMQSg?=
 =?us-ascii?Q?lq6eOT8VCgtuXCYbaUT+GW/1iThvxtVwSWA+34Oud7/b7PVXOK1fNUiIGOP0?=
 =?us-ascii?Q?PVH6XJHAYaXMzz7937229sjGnZRHp5k47xJonTWZ5S9whdjxvHFujgNETRxg?=
 =?us-ascii?Q?grLYoEDCdl6ZjUiNvF9KK+DrDe0lu9iDWm4NdkzhsAYTBUCZEcz+7zUMt6kk?=
 =?us-ascii?Q?pJtwWbE3X5C8Cj9X0DAftPSP5eLlFcjMr9ODYYO7bQ8sp+5p436gCKW+YtcH?=
 =?us-ascii?Q?qxiKaXvM3Fz/K9aNVSwrKfnRcmych4TxfGWpffzslcfNvL4D8XrVT3JAKi3Q?=
 =?us-ascii?Q?6xc5U7wiC8ImbRKfZNEL9av0URryN3K+vitsx0ns8Te/G9mZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edf56e8-5131-42eb-fdb4-08deaa7ec5bb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:17:39.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qbna3UVBNw3aD2QmIgmtYYc8xLlanqDjqL4KyXvFByQo73rv0VCSgc/YWFCoSyF3iE/+IsKSgwNk8oFmR1Zqgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
X-Rspamd-Queue-Id: 000114C8951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284255-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]

The protodown functionality allows user space to turn off the carrier of
a net device:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>

Different applications can set different protodown reasons, which
prevents an application from turning on the carrier of a net device as
long as others want it down:

 # ip link set dev macvlan1 protodown_reason 1 on
 # ip link set dev macvlan1 protodown_reason 2 on
 # ip link set dev macvlan1 protodown off
 Error: Cannot clear protodown, active reasons.
 # ip link set dev macvlan1 protodown_reason 2 off
 # ip link set dev macvlan1 protodown off
 Error: Cannot clear protodown, active reasons.
 # ip link set dev macvlan1 protodown_reason 1 off
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Unfortunately, this mechanism is not very useful when the carrier of a
net device can be toggled by toggling the carrier of its lower device:

 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier off
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Obviously, this is not the intended behavior and it is unlikely to be
relied on by anyone. In fact, it is a problem for applications like FRR
that use protodown with macvlan on top of a bridge as part of Virtual
Router Redundancy Protocol (VRRP).

Solve this by preventing a net device configured with protodown on from
inheriting the operational state of its lower device. Note that
READ_ONCE() is not needed as RTNL is held.

Output with the patch:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier off
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..bfb0f297b234 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11113,6 +11113,9 @@ EXPORT_SYMBOL(netdev_change_features);
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev)
 {
+	if (dev->proto_down)
+		return;
+
 	if (rootdev->operstate == IF_OPER_DORMANT)
 		netif_dormant_on(dev);
 	else
-- 
2.54.0


