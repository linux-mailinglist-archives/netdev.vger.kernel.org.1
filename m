Return-Path: <netdev+bounces-223664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF5B59D97
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F312A41B0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C037C0E2;
	Tue, 16 Sep 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cpOSr8WT"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF1328582
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040072; cv=fail; b=EMs/AeaaMBLZgLeG/JVrTB78Ib/XlKWVqkiP8EJUwLdih5YNx5nLTcBUWcDDsdNvNjcO5Wtc/+9cQBFOBK2CAGk0UIJoUqntoyn5J0ENQgpeY6yJkYUsOsPW8PonV7GpfdK11QKpEY93TlAu6+kk3iBBoMjAP5YFT9vVhzjjmSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040072; c=relaxed/simple;
	bh=wf3hDeLKE6cv40dC2Mhs7BV/NUYsLJ8vte3FG3Ig3zc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fzdfl67GXS99mX0FKNKMi58cz5TQd+/tAIgoUmdu7fTYriYy+2bJEp1Y08HqHa0DMmm/wu3fQZQfMzQe0Ioq7PJvWvPJ78hxkyZ77Xy1+ecxtSs7io00CKDaBe5vZGlNloC0Abx7bielOkwKO+iV2zMRDzMc77GPx+5PVA06nfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cpOSr8WT; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHUUj3MAFrp/jyIyTmRg1inss5B2oxkRNXbMN3kmwRBKVnXLmGam70Bcvt3g1Rpj0GJCgx3qhzwnH9oc4Q8k8b/lrgTFBI8Ypr6zi12fGza8z4nUJsz+43VNUQBNiIXYcOOrf+LcBFoGVyF0M2Llz1Ny2ElruxG32nnyjDJOsE/O/+bZ0j80nrWNWOyK4suwECxwu6su7IiOsPaf4r9ZXhiqxLRVwScndtZ3vQXwhBO6+DCGplhcKIbluIjZpyj/gnO7K4q6IiZ2RKXEw/PnbPEABlpnw2zbUOdtooZXFXImOgNkZ/FiRO19oO/tQsrNrAQvhrUK0X/gFo/wWEkIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjYlcLgX+nqNT3ik/q+ZVWKc786H3XqzzkJKwDpCT60=;
 b=x5XNXcVubWTrrBLfi66q4uzQmoZiffJBghigaHFORnmH2asqGhuxwvLvRXkXEIiow6nd4rrrDABs6W7w7qxCBQkrMRTWAHEVrcqEv4CsaQG5zdZAMs1tKgwXhEk9XF3L6kiEoW925hEVkg3nZ6EBjCHcPcFihQUGUqRRGewPIsN6zHFXGICYiM5asA5jOlWrPXmibJ78SegHPAn4P4d1vYk/hSNno5nxmgbJ9WjWzVb01KHZCpamD3rX8ea2g4ewCdgkWb/o1zNHs2SjdkwE4l264XKo8xHbPqJRbqxoxIjI83IWRMuoy+NZBdR8Cq25fE2ALYXM0jyM21/ZjjsJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjYlcLgX+nqNT3ik/q+ZVWKc786H3XqzzkJKwDpCT60=;
 b=cpOSr8WTpq2VlbPqvzxiVkd3vdpiPgKqKTI5VplLguffqeBf8dLBhMt6f895WgGz9P3tqsICqiRiK2U1ne4mylaPZTrlbxw/odTpP7EbZr6XlcvOx/RlUyPHvi6WdAyKOkYGK5mXjnZRXzqhd9+SjEeFHkg4EcqqPFH07vLIh6zFtgsA8mKAfs1zmb7XAUU5uq1bG6neGUJpMHgbVQZFdKo5RBW8Hst/ls7rSJ6guHUmTv3zBPlzMVpJIRer6VnjjWAnZthTJsNvqY5HM262lIDfgdbU5jvyw20IjoGMq42vSVmHFHKRsJZpF2DWr7aygvzmSmQS4sVaeguPG1c/GA==
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 16:27:44 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::3e) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.10 via Frontend Transport; Tue,
 16 Sep 2025 16:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 16:27:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 09:27:22 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 09:27:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <bridge@lists.linux-foundation.org>,
	"Andy Roulin" <aroulin@nvidia.com>
Subject: [PATCH iproute2-next v2] ip: iplink_bridge: Support fdb_local_vlan_0
Date: Tue, 16 Sep 2025 18:25:46 +0200
Message-ID: <9d887044246a656e15d05df716cde77e9d9ba64a.1758038828.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: fc469442-e2ca-487f-e93c-08ddf53df6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3z8Oh9FXmaDBDix+2M7YAbP+bKOjnswkqx5j1mNeOI2p515JqRM2t2DT/woj?=
 =?us-ascii?Q?7H0O/DS2qn+slRAYAIAY7EyMXHx/xHGJADFxulXYWjMvpkiyV+5OXR2f+JLZ?=
 =?us-ascii?Q?rAhn87gkl6mk74rEH3BRpT3L8s/nef6dryKsonw1YXupHY97sduz5KBLgVbv?=
 =?us-ascii?Q?ldODWE2j72PEZQBVUqIy3rk+hZ/yfyqIPVwvj1Zj1PjT/BE6C2tlnMHou6Ws?=
 =?us-ascii?Q?SknOTihET/e83XJWgpW6TNY+ZEdeRK8FATmBAFhfWo5axKMehrIcYnLyoKyU?=
 =?us-ascii?Q?T4sv0LfUZU3FhE14XVoLWOuhjiTKh49jd+qtHTNUyNgWNrq/eeHnLiAxEdHM?=
 =?us-ascii?Q?edzFIGMxprSSygQGhmWSWKHMoyaZQog/7ApT+Dj8l1WpFEdVGErdrxRm2vKR?=
 =?us-ascii?Q?qWXPUmKbVJZj5XRmnqUNF57zAZhMOWVr1HtBEocvZk+TyB9i8zFcqTSv9hkv?=
 =?us-ascii?Q?cAlCrxIeVvjZouh0oSkZRoEB+2N2JYjhWpcpfGWhb1IR0HHLe8s6Hu4y7Trt?=
 =?us-ascii?Q?EDSHSnrgecAC6hhSQg8JADk9GDPvcS5d8/fxOGNTQJPDlqfTETVexCCjZSOv?=
 =?us-ascii?Q?qBMnz3kFX58OKHbe906Uhd0yfzLOScfYlHhLZxj71rGyAjMINAXZOdh4GGQQ?=
 =?us-ascii?Q?8TXO9IG3BSu1oVCC9H3MM2169igEoiWcmtHupxOTSOyd1F4dp1iSVztXzRgn?=
 =?us-ascii?Q?HOXLpW+B895TCgmy/HpxPPv0FCsw/sULHQnV78jJaFA26GTgLipkuuEGLI8l?=
 =?us-ascii?Q?rfFvTZXkJVKhiqQQswHDobpLcb15GonGO6bc2uGubw89IMtNqbFQDunqI07t?=
 =?us-ascii?Q?TAellBnSzlZ+wkV4GDI5628JYHmfRjqlKx6QtN48mPvOW+a5bqFKrzyGfzJ9?=
 =?us-ascii?Q?wIu7vpMtP5FOppneNXrbfAKI4Flh6NEJDwooRjnmm6MExwjJgtRPZP6AVDxq?=
 =?us-ascii?Q?MEsJceEndWKicUbT/82nJSqkpHKlRqBbFBPI8E8qL0DBgh40XmcFu7AjYeZz?=
 =?us-ascii?Q?MpQg9t+qD6hmS2Rsh97xDNnpUv6Pj4ah9CiXQ7FXCqVIQDhWMKecx6QV2ZOt?=
 =?us-ascii?Q?PgPmM5vqa4kYGvlhsLrNCC9Tad0Inb9Z7bmoRLGgqSzcxrRCXE1nQ++6fkwX?=
 =?us-ascii?Q?xh9M1E7QOKqX7zowyh1q0Fp00WDAlmL1/21e+7SziXE/GQjH4dzGAx4mhprf?=
 =?us-ascii?Q?2yGhI9RAibbYquxRiqZ9/iJb7AMvO+2KsVH818xypmPPKsj1frYgf4kKaQ95?=
 =?us-ascii?Q?nfYcVY1Z65EsDtmRaejpteV/SQR8OGIG2HXEmSndODm9PZHmSYchcDLisqrk?=
 =?us-ascii?Q?dpiyVb2AZQfqEb/2Z0vnSiJ8wsoqJvopss3T4sxy+63/eQbXBvmAIGGGHg99?=
 =?us-ascii?Q?A7Dkp1x6iw2xpwViTo8rWhmlpFd5abXkVcCHlnsbZu3c9LKwI9LGSRmkgXyj?=
 =?us-ascii?Q?9ktj550G+NqZO23njcKeErr3/Ccrgc8cR+1hy3B4csuIs+helWCNmH1nyTdx?=
 =?us-ascii?Q?Pq3PuWqNxwL5s9MWc8VqEVZ3dzSPWIp+OdQK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:27:43.8183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc469442-e2ca-487f-e93c-08ddf53df6d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Maintain RXT in bridge_print_opt()
    - Mention what the default is in the man page.

 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in | 15 +++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 76e69086..af2fc93a 100644
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
@@ -635,6 +648,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 
 	if (tb[IFLA_BR_MULTI_BOOLOPT]) {
 		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
+		__u32 fdb_vlan_0_bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
 		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
 		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
 		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
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
index e3297c57..9bdb5563 100644
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
@@ -1852,6 +1854,19 @@ or off
 When disabled, the bridge will not learn from link-local frames (default:
 enabled).
 
+.BI fdb_local_vlan_0 " FDB_LOCAL_VLAN_0 "
+When disabled, local FDB entries (i.e. those for member port addresses and
+address of the bridge itself) are kept at VLAN 0 as well as any member VLANs.
+When the option is enabled, they are only kept at VLAN 0. By default the
+option is disabled.
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


