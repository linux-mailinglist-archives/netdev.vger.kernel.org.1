Return-Path: <netdev+bounces-224508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61794B85B3A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C2B7A0F74
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDD130F7ED;
	Thu, 18 Sep 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j1VMWq2j"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23430EF99
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210076; cv=fail; b=rWvupslJOBH3Rv//eSfiQt4hUZxpSYHP4FUeroCsdcuClQ/kfvuxiwwBi8eCaCGhzlIImdmFmiroJY0buFFiSJaqlTyUIa4c0yoDqCP/7hwGpHlPfc989dMxOcxn3p0Kny86HUz199UtJjVz+RL8DsfrfJliCcGadVDQFwErvek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210076; c=relaxed/simple;
	bh=kBeFSYoLhn1Mgp+gAjXvhRarspANNOukUqVmxhJNWCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MDzj0OV19qOSu1rgQze5qXaBg0YFqMy2zjXFfMo7j+a+he4Y+ZDlfCRKl+1DWSo5J2CM97SjXgXNkj6un3Osxgt0XWi+P9Ow13ovSPx1rNCibtSsjKyj4x++seFduOL6g7r+AeZHwfS1AqOGJN0EaEqI3sF7lu/DcArYy1tl0wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j1VMWq2j; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkT8OcykOtzCgNl4JNYF0+uEg1JdR5EiY0GT8XcAzzmRM4CwB/qSZEsXjZ0c6E+j23rtJ/C4KyBXBMyPRN3M8dy7MBMbP8jbdkX6bSHHSj47vJ2A1s+UKtNcDIJgpKoD/ZKpWPdmI5GYBgCeGYYgL1ZHwk1ggpt5zLpYdfKzSk9p6bsNxcqZoGCseHJHU30NfaVEZB9d9F/kMSmc7iRl0V02BdelwBwg4j9wMYSTruSg7+VEzdgLoZwOQzbbHYr/7nCzKPCJUVOLF72jKEnl2KX8fdorJmWLlyVLR7gQtWTNdoqPhZXKgNNf5cCnVHuIFibG32eCZd7Uzc5TJ/sOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNH/8Cgic2a5pbPXzdR4t8faiZhyrh5cVlpkvYsg1VM=;
 b=cd6ZEKbGVKW/d+F5Plh9PZ3w1tzxrrKITG2NY1Eb3QmXTf4mSBMtNyDZFF/QBfTy1pb1ZiEyai4eC/ScfovbD9BwnCMt8KZ30C2s4/JlhariCQFP/aL5TnFrn0fFhdmiQlh+D4GKm6PwlLkZbwshrWGMQxZjBMdLNPxg44Nz9t8RdoEBKJBdaG9b0q4qT4QPfW4iVUAmVD7KBlkpaUvjUj9d7w3paz0OIm0cBr7lUxzYBngLhM6s6FSaMkCD6GKLHEiuMgA2TAGy99q6YYeN/mnk1DclwHKaA5DaxHlUguEMQ/+8hW33ZBZ4Y9uSpmB2A8TNGW8JnLbr/+eLG02KXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNH/8Cgic2a5pbPXzdR4t8faiZhyrh5cVlpkvYsg1VM=;
 b=j1VMWq2j93nP9iQk+Qqxz6MCVKir6FNmEZPsdIRX9KdRTzlLMKJNz92MpFBxtM3dbXIyqrs8MPV5zpaVji9byWm/E+PLnLBA01JxeWYzlCVYVTE1A/amZ/q9qwS5EF/AbNtc8j+XQoa4xe4NqBxvxOpnbXDYWTqb6RJt+NmLlruA4UScl9c2ec+b48pUZ3T3uNi/vebZ9lFmdcnLYDOn4ttcuMOBDeiWGwhLZhwnCkVEgQdam67xDV8gJpils4NgQVuE55qRdQZk7He06T62b9qXhI2a1KdinyUqrouIqoF/Xh762AM8tb6+OGMelVdFzaFWc/qJG0BBKPXAR5SHPQ==
Received: from SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::8)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 15:41:11 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::fb) by SA1P222CA0171.outlook.office365.com
 (2603:10b6:806:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Thu,
 18 Sep 2025 15:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:41:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 08:40:46 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 18 Sep 2025 08:40:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <bridge@lists.linux-foundation.org>
Subject: [PATCH iproute2-next v3] ip: iplink_bridge: Support fdb_local_vlan_0
Date: Thu, 18 Sep 2025 17:39:26 +0200
Message-ID: <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8c2380-7bd5-4ff8-8988-08ddf6c9cb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GkZR9T/TUXdvHELQFcPU5KPDKgnKG/Y0O51Vm9KdkUqEAioWhdRu7SbxHHoP?=
 =?us-ascii?Q?4jgpCzy86cLcUZbyeAL2r2wU5qlFhVMxtfHo7T8mr5p4Sm/WzFVLVOw4tfnK?=
 =?us-ascii?Q?a8hpi84DQenkzYrtfQy5wVWMkfPzM/qnpsVmcYxh3Q1/Y0wOEjg4G6P1hS35?=
 =?us-ascii?Q?Gtnz5i1cjX68PXoRbcqFViTl0J+d/Uwe0t7zfB9htm4zDUE8FlukmYvvXzjH?=
 =?us-ascii?Q?mNNj9hVAru2gRj4nX04K+WQS29WFWU709qNvAC/aKbJpMwwm5D9x700I/88m?=
 =?us-ascii?Q?Z6TFlxXhsVgJewhdh5YP4DHxbEO+EPY6egZnJNevcylNjaZkt/udrE/1tQ3/?=
 =?us-ascii?Q?TG8qIMIQdJJNrb1q3l6GQ4QFOc31KumBn+S4vFONyllVT1o6o+YlOPjtiIPp?=
 =?us-ascii?Q?nWDZ1scIEy7YfZtKg4mEljgWVNgcFpOeuRoL8ZEQhQeXO0jZjptXuQdupyAZ?=
 =?us-ascii?Q?qrNsVUjH5I1Xg1cc7FyG7wORPb3nNek9LSD8nyKVp4DOBhgTeTxNQmtcO71L?=
 =?us-ascii?Q?2pMAYMHLrTL8GPOvc2H/ruhJnUS22kyG4W8HsDeUrc3vQON2x8f+lw8iW+dd?=
 =?us-ascii?Q?w1vcbepDQr8H/wA6aq1k1nQJrs8QuX2hQjiRMg4OxlwBhIi/lARvzxsUoCGF?=
 =?us-ascii?Q?/tXocOobaJvHElOvlW4Hn/6HJARyFGajtEPY0CJ8l0zo8MZkDa0omn85NWzi?=
 =?us-ascii?Q?tyP/DaBpYHUyiMRFuPHqGeZStiWu/EVYfu2agnrCbtX1NlRo/ZUlq5SPuoR4?=
 =?us-ascii?Q?gyDmeNHYDqU6Ucz33P0VKaw3rHGUNSWz4Z7dc5jnRG7qwyVPcBN30DdDiIOS?=
 =?us-ascii?Q?oIrCgZph8ft3gu+GHRhJt7rKvQjzv8Zuv6QEeucf9WyK1XPGB0BKIQQ6tn4K?=
 =?us-ascii?Q?R4pKCSRPAt9eA3zNc7TBXTfFZCKUEL/8tsfoBe5SspfiocgD/vGmpkjT02hw?=
 =?us-ascii?Q?8cxj1rTiQNicNCtKvm46lQKbUs8DTaOCjHlWu6A/6c/al7vMUMPUW3FKyd5Z?=
 =?us-ascii?Q?nWJqzt2EJUzJVxRVcNsfP1QaX+UYtmQ6wCTFn0lcLPPDJ/nt3JI7qhNR8xGx?=
 =?us-ascii?Q?kcCUL1ZtQq6Crm9vfmyDmSXV9x8kqSGnAoY2sCIKHvHy0NcMjgXiyURg1Bfn?=
 =?us-ascii?Q?4giuOc8aIkKJU4BWjJHLZlhB+bezCEj/ct1Qv/jYawcC2d89i4QpEMtpYS8I?=
 =?us-ascii?Q?sqczBaOY9AdINFMEP/jQPCTRBZ8Yj87NAtLQY7V/CzKgIWksF/5qYNreUoqa?=
 =?us-ascii?Q?mq2Htg+GP0rPXsfKC4KZCfIZiMFU6jJM+bsV5KMPQSFjbEKGvvMsZHy4w6QT?=
 =?us-ascii?Q?KtOVOI4TRw27sFQ5N+ISDKc/BjMkzdC0zy+7sJFDqWQDd2SO+sQuyq94801f?=
 =?us-ascii?Q?QxIFTMXiWy+KczKaSieGa2ZSphD+QJv3dl6RzRn6GpqKA2FZOjjGnowaS27F?=
 =?us-ascii?Q?xNpZLEwcDfXZUXHxZ+GWOx60sIMaHLxx7+TOL3UZ/7PkBkF4FJ7zDnkPtQRz?=
 =?us-ascii?Q?TMovamGl9HM8jto75jMdaPj5WBg7678cGw7p?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:41:11.1511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8c2380-7bd5-4ff8-8988-08ddf6c9cb1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277

Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v3:
    - When printing the option, test optmask, not optval
    
    v2:
    - Maintain RXT in bridge_print_opt()
    - Mention what the default is in the man page.

 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in | 15 +++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 76e69086..df3264c3 100644
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
+		if (bm->optmask & fdb_vlan_0_bit)
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


