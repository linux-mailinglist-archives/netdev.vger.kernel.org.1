Return-Path: <netdev+bounces-207870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87893B08DDC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADFB1888CE6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D02C3271;
	Thu, 17 Jul 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AtjS00X5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CDA2BE039
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757587; cv=fail; b=Fs+tiASFkU/HmXmdV9Ec+w2u//BGqj5T/PqRYZb7uY9Kb91wj9zNLaEKWnwgQdhkyb0Ue4lBlhr/XikdRS6QxRZ0ug9fDoDu3bHG0NH4ZvIdkgzNjgWBMatowszUD+KS1Yqan8o/I95icYMs/qebq3GdTq5jUDd+SEucP8c8m7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757587; c=relaxed/simple;
	bh=seSgXfcC2kcFgOrWt62ayWeGzJcLbsI7x7MygMFXGjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qXdswKf91wAn1XXj6F4IPz7ZWqQf/UTgT7yVfUpqRPb0vLi2m0lTzu1aIwejf/YA8uYjVvrFGMUugAcKkGdu9nJTzpPEkWezl56ZPAkOQmEh+K3JYVw3GOmEygCRhgVjhoDT30hOTdDDvyiBOQ6AkGtgAT0UaYFpyKlYn22gqJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AtjS00X5; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsJckGh+YZYsNW0GXHWshpZaKsheUD0A92319EEHLE/HiRWrjYL1OaUhRXEfM5LQ9Po04YGMkLlu5/szVaWty03ilvbrvYLJWzSy5IWqxYOWIH5ZHq4GWqFSllvR9cI86Z+/cT0V4wKYn3EvuYdQs+iPg829VCskKCe3HtMFNxZhVfdxYCfc3otxMx5v/T8r4CuM6n8Sy/kxelTdF2Rw5R5i/HWHRCs2zv2i09sjuHDrA1Y0Otpwo1jirL5emlpPJ6thS6wp96C/nfuLQRSqZzIkER3JMoxQRUHSyqaUvocll2GaoO8ax0cnq4PMNA1ZvyWWuc4qLoCfL/Pj4c/mVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqZYTlxuc0k2J2lZZhmivsp+ejD6USeo5q964IODtPQ=;
 b=Nl7KWNtTJaS4VP25STglBEO8CBlBUKeVGuI3baMxhYhjboG6FWKauHKn6gZ+WsLdb+dUlQv03YCGSWKhLxoUH5ly4vjzY89WTr9xiFFpafWnBDL2U1eP2pa7HCVUFiD7MFM1gcnFuyktbf5SZbBwy/om9Bu5YjxT+571G/wbDwg8VZ4jkK0LtUYYDm0k7GuYIm1dKs9oNxb9SWlkOHiyqCcf0yjT56J3MZlADtAqWZqdmrSjg/ONl4c1xpyEykBQgZ/DTLAz5uc1aScU10V4sJkmzpvE2MY0WN9sIlAshJEoDsPqffV+d+rzaR4cffaSSi0urgyhvXkKCvCAlCjzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqZYTlxuc0k2J2lZZhmivsp+ejD6USeo5q964IODtPQ=;
 b=AtjS00X5ioxrIZ7aHkcKv09TrX3UJkRQ3IvtjrT1WT4+FphRR+JgQlKHkt3HKrQcg4SKCHd5GT17rROOh5pJLuxsSp3Ohha+u91MQxUKLuFJX7+Hd0oFlIO9KiMnAQDQMc+xd/zqJCRvnLZFK/Scjm6BUkSppr2eEW5BjfO+9PWirPWM/glMYwG3evZZUeslEy13Gri5T37p9YLeQL8CgokpT/xGkYcgjvnccyXC5nyisXjsLg6C8rUHAkFsR76krInWF5IZimRGNyyssoz+EXEXAT+3M7/vlL0baSg9R574tKmW1lnYqm16+/Vrqc7yFV38rb5fvItP+uT0DXM7rw==
Received: from CH0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:610:e5::8)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 13:06:22 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::f3) by CH0PR03CA0243.outlook.office365.com
 (2603:10b6:610:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.22 via Frontend Transport; Thu,
 17 Jul 2025 13:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 13:06:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 06:06:05 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 06:06:02 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next] bridge: fdb: Add support for FDB activity notification control
Date: Thu, 17 Jul 2025 16:05:09 +0300
Message-ID: <20250717130509.470850-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b681205-009c-4b42-ca64-08ddc532b97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wgznaFau0QP8ltxh7Bgydtm1ZEp01s2MPqDIutL9PMA65rNwilZY6RKkuJ2+?=
 =?us-ascii?Q?BVYE1vwQacWtQmufDP3Y4TYgKEqvmjeU85DOYiwzgP7FXSQ1UunRecWCr3GB?=
 =?us-ascii?Q?L8VwTuaadbpwLMdJ0oQhT9bQHDGVgw1otoYX5j/ASjZgndrsWROLqU8MfBrb?=
 =?us-ascii?Q?TuJQjFgxtUBDWhrXhF8mrb/VLfGhi6ugS70IjIi8+Vy7mgW6OfDRDNjeNmC3?=
 =?us-ascii?Q?TY9dTr0h+NMlDVy1GkEWdMFAB/XxoNOomC1c/ldvG0K60JQZCHH2dHtIdftS?=
 =?us-ascii?Q?a0MBbLR3NAq8CGD62b4Yju5QTb5XJuRrvz9l4c5N28E1O2QrnVaPLrOplQ1B?=
 =?us-ascii?Q?IaSkHmPgXjCdVSGhG3BcRMkN1YOacJmIpnbWRA9VpD/kReMzXi/zXzwdF1A7?=
 =?us-ascii?Q?iXIi2gOhRlc4Z4DxU/vi36riEWpTZmV+rjrxS+wcGbqGm7BlCuC37+dyTCiH?=
 =?us-ascii?Q?nN0fQwBAmO3Qwtn+Lb53HsBGkpVpwewxHSUlpVIcArGyfxJKzd87QazUbj6o?=
 =?us-ascii?Q?kVkcZQe9ltsJvd11VBBRlU/B0xtTv6Oi50cSR+PhSFPqIIznAXHVzdji+WoA?=
 =?us-ascii?Q?dXJdpcl08n/Z1lLJduidjsKqSNjz5tOZDEaJ69K5J1d3Cd0PDvKQb1hSGqNK?=
 =?us-ascii?Q?PdRuZ4lGyUCZuKO0+dcdFY9gaJvLkY1bXFajMVqF3C1YXrdroSfvA8/VQXm1?=
 =?us-ascii?Q?IcG0vk6+S2q3KICcX+j0gyKQ1xUyT8gY8YVsh41dBbphBLZGfo8CacvwBDIV?=
 =?us-ascii?Q?r/Ydaa3BsvovZkUOqe0L59F/V+di7VdLYsizbmUedeOwx32Ta+364mKgyHt0?=
 =?us-ascii?Q?4CM4PMcEtVqr5kai1cYgiO4U6+gszROVzKUGZDR1Sp489lifSwQb6cy2DH2v?=
 =?us-ascii?Q?Ul6NEx5pTKal/JVz2NXZ5ZXoJ3grYowubaUrBeYucvix+tRRcXhd/nQJ6vJI?=
 =?us-ascii?Q?c8orP2tGJK6oGdewtNhJ5pn4bAgIrtJK2GoLfFkfRXyesoBxXH3sbOLkzeQi?=
 =?us-ascii?Q?zFugOUBgXXtvbR8IbhKs0WmNNTsdbBwaUfttxr+daDF9aD7vXYKCnOX3++nm?=
 =?us-ascii?Q?WUt5nFB7UhDitRiuIEvhKUJFVoX344ycvy/OkD1u+Pw2blVXTC3SooY/Coxs?=
 =?us-ascii?Q?6ECBOXE6FxlwXueF8aqbQz9Egj2BOTLbtUHltv9LqPcd5Y3tgeH4eTPxD4bX?=
 =?us-ascii?Q?SrA8Jr2qYRa2rcAXYj6UukrbggrxLjvflzw5ZpQLON+CoSQOSvIV9mBV3t63?=
 =?us-ascii?Q?0hUFTUwN10N+tVw5u/IgRjebL4o6I0kcdqD1TbWLFY+ZDTGEOFC27kd5A9+T?=
 =?us-ascii?Q?zKH13URiKd8j++lNKtZGTOfSQQiTAkvH9OQAnNJHMDFBGqBRz7IdB7aEny2T?=
 =?us-ascii?Q?VLVdFxRULhKOVdVlc4z44RI11+JwG9T7IeqwWagFFeCRH8VbhOZHWKKzVoZU?=
 =?us-ascii?Q?x6zA85n3YDrGBrdJyYwgCIUQfdwteNSP7d8ZXY3tZMJYjLhEnLdthLq0dxN/?=
 =?us-ascii?Q?549V6CmXPryWXvuX2sfEeLM8WKT3+Ad7WashL6Kg5JuRMaVsvoilnTg54A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:06:20.5388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b681205-009c-4b42-ca64-08ddc532b97e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367

Add support for FDB activity notification control [1].

Users can use this to enable activity notifications on a new FDB entry
that was learned on an ES (Ethernet Segment) peer and mark it as locally
inactive:

 # bridge fdb add 00:11:22:33:44:55 dev bond1 master static activity_notify inactive
 $ bridge -d fdb get 00:11:22:33:44:55 br br1
 00:11:22:33:44:55 dev bond1 activity_notify inactive master br1 static
 $ bridge -d -j -p fdb get 00:11:22:33:44:55 br br1
 [ {
         "mac": "00:11:22:33:44:55",
         "ifname": "bond1",
         "activity_notify": true,
         "inactive": true,
         "flags": [ ],
         "master": "br1",
         "state": "static"
     } ]

User space will receive a notification when the entry becomes active and
the control plane will be able to mark the entry as locally active.

It is also possible to enable activity notifications on an existing
dynamic entry:

 $ bridge -d -s -j -p fdb get 00:aa:bb:cc:dd:ee br br1
 [ {
         "mac": "00:aa:bb:cc:dd:ee",
         "ifname": "bond1",
         "used": 8,
         "updated": 8,
         "flags": [ ],
         "master": "br1",
         "state": ""
     } ]
 # bridge fdb replace 00:aa:bb:cc:dd:ee dev bond1 master static activity_notify norefresh
 $ bridge -d -s -j -p fdb get 00:aa:bb:cc:dd:ee br br1
 [ {
         "mac": "00:aa:bb:cc:dd:ee",
         "ifname": "bond1",
         "activity_notify": true,
         "used": 3,
         "updated": 23,
         "flags": [ ],
         "master": "br1",
         "state": "static"
     } ]

The "norefresh" keyword is used to avoid resetting the entry's last
active time (i.e., "updated" time).

User space will receive a notification when the entry becomes inactive
and the control plane will be able to mark the entry as locally
inactive. Note that the entry was converted from a dynamic entry to a
static entry to prevent the kernel from automatically deleting it upon
inactivity.

An existing inactive entry can only be marked as active by the kernel or
by disabling and enabling activity notifications:

 $ bridge -d fdb get 00:11:22:33:44:55 br br1
 00:11:22:33:44:55 dev bond1 activity_notify inactive master br1 static
 # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static activity_notify
 $ bridge -d fdb get 00:11:22:33:44:55 br br1
 00:11:22:33:44:55 dev bond1 activity_notify inactive master br1 static
 # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static
 # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static activity_notify
 $ bridge -d fdb get 00:11:22:33:44:55 br br1
 00:11:22:33:44:55 dev bond1 activity_notify master br1 static

Marking an entry as inactive while activity notifications are disabled
does not make sense and will be rejected by the kernel:

 # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static inactive
 RTNETLINK answers: Invalid argument

[1] https://lore.kernel.org/netdev/20200623204718.1057508-1-nikolay@cumulusnetworks.com/

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
I have a kernel selftest for this functionality. I will post it after
this patch is accepted.
---
 bridge/fdb.c      | 69 ++++++++++++++++++++++++++++++++++++++++++++---
 man/man8/bridge.8 | 22 ++++++++++++++-
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 7b4443661e6b..d57b57503198 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -40,7 +40,8 @@ static void usage(void)
 		"              [ self ] [ master ] [ use ] [ router ] [ extern_learn ]\n"
 		"              [ sticky ] [ local | static | dynamic ] [ vlan VID ]\n"
 		"              { [ dst IPADDR ] [ port PORT] [ vni VNI ] | [ nhid NHID ] }\n"
-		"	       [ via DEV ] [ src_vni VNI ]\n"
+		"	       [ via DEV ] [ src_vni VNI ] [ activity_notify ]\n"
+		"	       [ inactive ] [ norefresh ]\n"
 		"       bridge fdb [ show [ br BRDEV ] [ brport DEV ] [ vlan VID ]\n"
 		"              [ state STATE ] [ dynamic ] ]\n"
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
@@ -142,6 +143,24 @@ static void fdb_print_stats(FILE *fp, const struct nda_cacheinfo *ci)
 	}
 }
 
+static void fdb_print_ext_attrs(struct rtattr *nfea)
+{
+	struct rtattr *tb[NFEA_MAX + 1];
+
+	parse_rtattr_nested(tb, NFEA_MAX, nfea);
+
+	if (tb[NFEA_ACTIVITY_NOTIFY]) {
+		__u8 notify;
+
+		notify = rta_getattr_u8(tb[NFEA_ACTIVITY_NOTIFY]);
+		if (notify & FDB_NOTIFY_BIT)
+			print_bool(PRINT_ANY, "activity_notify",
+				   "activity_notify ", true);
+		if (notify & FDB_NOTIFY_INACTIVE_BIT)
+			print_bool(PRINT_ANY, "inactive", "inactive ", true);
+	}
+}
+
 int print_fdb(struct nlmsghdr *n, void *arg)
 {
 	FILE *fp = arg;
@@ -172,8 +191,9 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 	if (filter_state && !(r->ndm_state & filter_state))
 		return 0;
 
-	parse_rtattr(tb, NDA_MAX, NDA_RTA(r),
-		     n->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+	parse_rtattr_flags(tb, NDA_MAX, NDA_RTA(r),
+			   n->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
+			   NLA_F_NESTED);
 
 	if (tb[NDA_FLAGS_EXT])
 		ext_flags = rta_getattr_u32(tb[NDA_FLAGS_EXT]);
@@ -273,6 +293,9 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 				 "linkNetNsId", "link-netnsid %d ",
 				 rta_getattr_u32(tb[NDA_LINK_NETNSID]));
 
+	if (show_details && tb[NDA_FDB_EXT_ATTRS])
+		fdb_print_ext_attrs(tb[NDA_FDB_EXT_ATTRS]);
+
 	if (show_stats && tb[NDA_CACHEINFO])
 		fdb_print_stats(fp, RTA_DATA(tb[NDA_CACHEINFO]));
 
@@ -399,6 +422,34 @@ static int fdb_show(int argc, char **argv)
 	return 0;
 }
 
+static void fdb_add_ext_attrs(struct nlmsghdr *n, int maxlen,
+			      bool activity_notify, bool inactive,
+			      bool norefresh)
+{
+	struct rtattr *nest;
+
+	if (!activity_notify && !inactive && !norefresh)
+		return;
+
+	nest = addattr_nest(n, maxlen, NDA_FDB_EXT_ATTRS | NLA_F_NESTED);
+
+	if (activity_notify || inactive) {
+		__u8 notify = 0;
+
+		if (activity_notify)
+			notify |= FDB_NOTIFY_BIT;
+		if (inactive)
+			notify |= FDB_NOTIFY_INACTIVE_BIT;
+
+		addattr8(n, maxlen, NFEA_ACTIVITY_NOTIFY, notify);
+	}
+
+	if (norefresh)
+		addattr_l(n, maxlen, NFEA_DONT_REFRESH, NULL, 0);
+
+	addattr_nest_end(n, nest);
+}
+
 static int fdb_modify(int cmd, int flags, int argc, char **argv)
 {
 	struct {
@@ -412,6 +463,9 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 		.ndm.ndm_family = PF_BRIDGE,
 		.ndm.ndm_state = NUD_NOARP,
 	};
+	bool activity_notify = false;
+	bool norefresh = false;
+	bool inactive = false;
 	char *addr = NULL;
 	char *d = NULL;
 	char abuf[ETH_ALEN];
@@ -495,6 +549,12 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 			req.ndm.ndm_flags |= NTF_EXT_LEARNED;
 		} else if (matches(*argv, "sticky") == 0) {
 			req.ndm.ndm_flags |= NTF_STICKY;
+		} else if (strcmp(*argv, "activity_notify") == 0) {
+			activity_notify = true;
+		} else if (strcmp(*argv, "inactive") == 0) {
+			inactive = true;
+		} else if (strcmp(*argv, "norefresh") == 0) {
+			norefresh = true;
 		} else {
 			if (strcmp(*argv, "to") == 0)
 				NEXT_ARG();
@@ -559,6 +619,9 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	if (!req.ndm.ndm_ifindex)
 		return nodev(d);
 
+	fdb_add_ext_attrs(&req.n, sizeof(req), activity_notify, inactive,
+			  norefresh);
+
 	if (rtnl_talk(&rth, &req.n, NULL) < 0)
 		return -1;
 
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index 08f329c6bca6..fe800d3fe290 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -91,7 +91,8 @@ bridge \- show / manipulate bridge addresses and devices
 .B via
 .IR DEVICE " ] | "
 .B nhid
-.IR NHID " } "
+.IR NHID " } [ "
+.BR activity_notify " ] [ " inactive " ] [ " norefresh " ]
 
 .ti -8
 .BR "bridge fdb" " [ [ " show " ] [ "
@@ -860,6 +861,25 @@ remote VXLAN tunnel endpoint.
 ecmp nexthop group for the VXLAN device driver
 to reach remote VXLAN tunnel endpoints.
 
+.TP
+.B activity_notify
+enable activity notifications on an existing or a new FDB entry. This keyword
+only makes sense for non-dynamic entries as dynamic entries are deleted upon
+inactivity. An entry is assumed to be active unless the \fBinactive\fR keyword
+is specified.
+
+.TP
+.B inactive
+mark an FDB entry as inactive. This keyword only makes sense in conjunction
+with the \fBactivity_notify\fR keyword and usually only when adding a new FDB
+entry as opposed to replacing an existing one.
+
+.TP
+.B norefresh
+avoid resetting an FDB entry's activity (i.e., its last updated time). This can
+be useful, for example, when one wants to enable activity notifications on an
+existing entry without modifying its last updated time.
+
 .SS bridge fdb append - append a forwarding database entry
 This command adds a new fdb entry with an already known
 .IR LLADDR .
-- 
2.50.0


