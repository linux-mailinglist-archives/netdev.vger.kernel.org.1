Return-Path: <netdev+bounces-223092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDF2B57ED1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD1B3A5A07
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A531D731;
	Mon, 15 Sep 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vpr/N8gI"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DE31A57B
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946211; cv=fail; b=jxCLMB2uc+kYU3QhosZ6WXv4lEtB7RbKbON9eoWqp3wukUAz614vTGPTKNNJHhN28SEblYWSQOD8etMFpWX6p4gWSTFkwgPXInc25CQUrhdqS+1BcJfYEyePyX1zb65Li9hlynFJbHIXwtabyd7X+jV8WTYRO4p81xLGT4cBcQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946211; c=relaxed/simple;
	bh=XQ8T4M9R4p68ih5GMrRpTMbFDDE+k0iHlzqDx+0Dlr8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hfe3WUKYzlXCYQFyqQfThHB5IKh8sIS0Am6IbBqjzVStH1WBChYIyZspYbwHJfcVkjh0teaG7W6wuPvVFaUc3HQL0Z4dc2DknGSyLnObxW9IUYaD0ucgcELxIhYvwaYmNuyumorYYxqm14bcXb4DA0YOfQCZdEX5FKfa6Nibsps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vpr/N8gI; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPttpzxAMLtgCs0IdCKRPimYXUcQY5X6J2wL6MHLofpKrpeUPQTW8z8cfOinon0PLz33SHDDCkxdF4xaQBc+wVHhTIvUR019RjJLmu4ebe0ROKTvxbWJ/2VtXKetpDEd7n6prmfTeAnOos1CM20tXYb2NxKIjD/LcEeXoxKQsaXv/QVU4FQO7xy8XHu6439gg3qkbemSjFLB/vXfwU9z5TZsKgJYqLDhMFvO4Nnz92Fmx+KOuH3tM1OAsAraFtT4lSerOhIEhnx5zZQxZH6KWSXeg3G4+XH1bnXQw33qFv8MpeiK9Bh59p4xJ4oqMkg42mrr6gpzkh3aF4imUiNG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1OlPnGQsoRHXtt5jD/Og1tBdu2uxSqb8P6ruFzIIMw=;
 b=gcCTQDAvrT51WL7jezwUNjCTCwnDJNUSijEGORKX+zjgxewe3IXgIX+hzqVO1UyglFRVh8e9kEOx+m/PImTTUBsAvaA4MeNT13mPVX+9qfDWShRM3RDdlNiNa0vwrX/xJmkrMoEBUyt9dWhtBIPptTULkClJxyB+MIGUvik6YJtrsBGpDXl98h4ec4rzlwuVaFPucxPQOhzSuy8Dd3YB0VKm0x6cRBIVdYeLCJEGt19lyOl8YzA8jdT7PT2/4JXpwNFLzas56l9J28fMySofLyTO4SyhOgq5bOcYTiIj0DqegxTW7h9LPSak74eDKZMZn1UBfO4Q5jFkIrqOk+HkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1OlPnGQsoRHXtt5jD/Og1tBdu2uxSqb8P6ruFzIIMw=;
 b=Vpr/N8gItjvUq6MoPAueRJigK2i4jcQSRnlZfJnMVBjjIUDWttQ94HtP87u+Kje+AkHLEQ19J6TEvH2GeMLkZzLYjEHuoio/wq+TSjHahq9d1ttUTUl82/hnOWy4qPou1QhXrKF1w0i3iD7+yN8nr3WMrmSXTdFoZvPz9/jdezAoVPRN11xoETW9knT3CVuPBV0If1Pqd7zSmn/idMHpew+TxK54acGyD9YwYp97Gh/HXZGRVj8weqcBhJNh7wx49f+yOYSRDHUrVPTU3LPRH/G00eF/MH8Z+d+cW39d57k2NDw5WBJ938+EhSs7yxJ2KS4sFm+bOe/fML1XxruMbg==
Received: from CH0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:610:e4::31)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 14:23:24 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::ee) by CH0PR03CA0206.outlook.office365.com
 (2603:10b6:610:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 14:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:23:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:23:06 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:23:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>
Subject: [PATCH iproute2-next] ip: iplink_bridge: Support fdb_local_vlan_0
Date: Mon, 15 Sep 2025 16:21:33 +0200
Message-ID: <8ca075b0d6052511b57b07796a64c5be831b3b53.1757945582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 207b098c-1743-444c-5ae1-08ddf4636e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLsGmKCDtIQytoNQNu6rJV2XCEKs0k6a5nUWcM28xJcEkG5Gd/0AgUH13cP3?=
 =?us-ascii?Q?AMEd1nGhzHkSolsyAxaUjjBXSi75pCNBoRLYN+MGz5fRjPcNpk2eVhLt3YB3?=
 =?us-ascii?Q?sCl3o1NGMQabXuSw9cjsIjx0nuPUAn42ZCZythKHJpxAkwnxCMYpGcppRQq0?=
 =?us-ascii?Q?+ouPeDtVlnkwu3qOxqSbrRWMiJ8RUp1rAeHeFlANFCxLt3VVdGva03sFWVaG?=
 =?us-ascii?Q?obUPJArMKr0KDgjAqLtV49sp0sotaoPP9owxp7chzhRlXmQoQZlkyq2N1PbR?=
 =?us-ascii?Q?8369msKtroqZLdcOwt6HLPpbl74Y7t/UEjSNo5Heus9sG6vdFwpe9P/7kBYF?=
 =?us-ascii?Q?zy6avKymzxamtw0TSh5UIZUldzHoKgpim7dhoN+N5HM4BRh8HlMa2i8KrNaM?=
 =?us-ascii?Q?a9lDtBe+82h7M4tLfu1s1/doAr60U34rRfiEj9lWuJiGDqXYzvM3V5VrN2wo?=
 =?us-ascii?Q?TdN/0xrg/xqwIHKY5rrMGB217Q8jhCUAsl0EvIBeP2ALhJ80+KDdQXOFSEbI?=
 =?us-ascii?Q?oMZp7Nwxum+T6Agy0tKNYdTl19KoBEABWMisZE8sSfBkWrLc2ERta3/njWyz?=
 =?us-ascii?Q?OuBNPDQ8R3WGJoEWFTOQGx0980CyxAmjEYhBrzJviOfStGfM+gwec+4tAp5R?=
 =?us-ascii?Q?Obqqor2L2Y6VYFuJl4D+Y2hFnlzQ4TAo/az8vxYgS2jdI658HISyYVcD8PMp?=
 =?us-ascii?Q?vSls3iVQSRcC+rZCR+Hz2P5RPgdfHWLEYdD2w7Xc0cHvX8E/wZ7/QiBz0zvm?=
 =?us-ascii?Q?w64DHMIBhse1mKTqsNu/4R/oJIvL6JWHwE38nqVVUgf2KIkZIo0au57uF2a8?=
 =?us-ascii?Q?sr0hx8Ff3j5g19u0pAiOrC/kWpatU+RsRi2UbpRwDYCOEoTusN0MQkR5hekj?=
 =?us-ascii?Q?kBb8ZvHge5MG52Xx27NJpiNKoZqSp4GicZqBn5IumwmK3fFCht2p6lYBwpEl?=
 =?us-ascii?Q?pOTLTBfqMzOh4Gq5WWTMDlExb8q8ujJXX066wdq8jrNdsXpMReXLtCTWHQPX?=
 =?us-ascii?Q?jyIl//Wjza/Gbf7qQrdDhGXs4cjbUBqXKVOZW6kcngQGeiO4p4e+lkjSK2BQ?=
 =?us-ascii?Q?wqaGFcsZ2//i6JdR5MKTdq3aCAsRhlDPhG03RDtNExaX6si3nTIa8HqZOL+0?=
 =?us-ascii?Q?a7E9CgZNHLzZKN5H+65wpEZCbYtQpXLtzRATJT00Cx8bVL6Nvv5KRh9dFYH8?=
 =?us-ascii?Q?k1qc2g/JxIyOOvrZBz5PTd41QI3/TGTHDuGLB0JpPXBMXOOnAMil0EeazU9s?=
 =?us-ascii?Q?h4ySpMuJsbNphIRCncnrwvgww28dau4Hr5BdQfbR2HSnh9RZb55b0dwWQOHu?=
 =?us-ascii?Q?z0+Nk8Psx0HjZAPOL6CjXWqKnUGHvSFRQhdfu+GQCaD9egRrD0K0NLFYjb72?=
 =?us-ascii?Q?RB1/0JDCgcHMbrfpV8KABHz/qwStKzZtOReR+V1jdk1xPrRib1Cy2TOjgemP?=
 =?us-ascii?Q?IoL2DcHmt++Cu5NE3XhfO4KWM2pYGlUh1KeJErTBoLHYZdWEny8jCN4nmhO+?=
 =?us-ascii?Q?Sq3NLv5Uq387Q83DnMaC2PH32qoIWJLWTWX1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:23:23.9447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207b098c-1743-444c-5ae1-08ddf4636e02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815

Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 76e69086..f7f010fd 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -36,6 +36,7 @@ static void print_explain(FILE *f)
 		"		  [ group_fwd_mask MASK ]\n"
 		"		  [ group_address ADDRESS ]\n"
 		"		  [ no_linklocal_learn NO_LINKLOCAL_LEARN ]\n"
+		"		  [ fdb_local_vlan_0 FDB_LOCAL_VLAN_0 ]\n"
 		"		  [ fdb_max_learned FDB_MAX_LEARNED ]\n"
 		"		  [ vlan_filtering VLAN_FILTERING ]\n"
 		"		  [ vlan_protocol VLAN_PROTOCOL ]\n"
@@ -427,6 +428,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 				bm.optval |= mofn_bit;
 			else
 				bm.optval &= ~mofn_bit;
+		} else if (strcmp(*argv, "fdb_local_vlan_0") == 0) {
+			__u32 bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
+			__u8 value;
+
+			NEXT_ARG();
+			if (get_u8(&value, *argv, 0))
+				invarg("invalid fdb_local_vlan_0", *argv);
+			bm.optmask |= bit;
+			if (value)
+				bm.optval |= bit;
+			else
+				bm.optval &= ~bit;
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -637,6 +650,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
 		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
 		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
+		__u32 fdb_vlan_0_bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
 		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
 		struct br_boolopt_multi *bm;
 
@@ -661,6 +675,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   "mdb_offload_fail_notification",
 				   "mdb_offload_fail_notification %u ",
 				   !!(bm->optval & mofn_bit));
+		if (bm->optval & fdb_vlan_0_bit)
+			print_uint(PRINT_ANY,
+				   "fdb_local_vlan_0",
+				   "fdb_local_vlan_0 %u ",
+				   !!(bm->optval & fdb_vlan_0_bit));
 	}
 
 	if (tb[IFLA_BR_MCAST_ROUTER])
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e3297c57..8bc11257 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1725,6 +1725,8 @@ the following additional arguments are supported:
 ] [
 .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
 ] [
+.BI fdb_local_vlan_0 " FDB_LOCAL_VLAN_0 "
+] [
 .BI fdb_max_learned " FDB_MAX_LEARNED "
 ] [
 .BI vlan_filtering " VLAN_FILTERING "
@@ -1852,6 +1854,18 @@ or off
 When disabled, the bridge will not learn from link-local frames (default:
 enabled).
 
+.BI fdb_local_vlan_0 " FDB_LOCAL_VLAN_0 "
+When disabled, local FDB entries (i.e. those for member port addresses and
+address of the bridge itself) are kept at VLAN 0 as well as any member VLANs.
+When the option is enabled, they are only kept at VLAN 0.
+
+When this option is enabled, when making a forwarding decision, the bridge looks
+at VLAN 0 for a matching entry that is permanent, but not added by user. However
+in all other ways the entry only exists on VLAN 0. This affects dumping, where
+the entries are not shown on non-0 VLANs, and FDB get and flush do not find the
+entry on non-0 VLANs. When the entry is deleted, it affects forwarding on all
+VLANs.
+
 .BI fdb_max_learned " FDB_MAX_LEARNED "
 - set the maximum number of learned FDB entries. If
 .RI ( FDB_MAX_LEARNED " == 0) "
-- 
2.49.0


