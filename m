Return-Path: <netdev+bounces-159801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDAFA16F78
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7003A07DE
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680EE1E990A;
	Mon, 20 Jan 2025 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUxkXs0l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80F1E98FF
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387833; cv=fail; b=Dm/VzIG9dPbbJitM4YMk7P6n+7kLL5U0cTN85Tkh5qWp8Itmfya0iagsgLx8fCjLIqTBSb/Rn29DnIZIX3XBmA27sF9XMQ1EtohU7mq9Qmgpl+hWEOrETXo4Mk1K09uNl8Pt1Zl5cda8l/1p5Ao0b4Q1PtOUA8Lxhfb2aYTitKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387833; c=relaxed/simple;
	bh=X05pLYeCHs2dWFcO5qcIIZP7nAkTRrc7ik9P56TeeJM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRVKuOF6kPcBTlmAc57+Uz/r0bVnU3JrI3HpxpE6EwOx67fOMk5fILV/X5JfCV2be0dYFn7WBxX/r3Vzc1ur4SnvTEAOltjwi3T/537WdigJMpkxR/G4mWhSKYD07kGtIywImlCRd1ekpKWdkmQYrO5Tzf7TG4uK7KDzRLkdDXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUxkXs0l; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuUb+xRObE3Oh95Cnmh9YkYnYqo9Vq8oZqAGwOih8SFaDE9KprlwH+X7lKxrDbVVYTwH3PQR7fjFZsfH52zHREaaAPW7p2EHxeUxB5NoeKJgMaIQ6tSNcrq8XCo/fwh9o68o3f3dNyoPAZxOkB3IVfoM/z6UUXR40+A8+XWL4s9xKpXO43s5vvjUwFz3gP91zzOuIkQWTbMq89F1ivnr8wJF480dRNqwDvvirqRElG8WYruNMsiBtLlHFBmlKMWbxFBrT8JqGQpHz81HR4qXdjTwt6Ybz3DO4MeslYIQrL7PUM0KwQj7bQbeXF7x+m0qDLFXN8ptFrZ8OlNuZ3VurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2CUYEB4xmsespaKUANIA5mLW1C4umCiFXzjunJZe8U=;
 b=UYUkbIIDjtYAKzeVXbow+pJ8vszgPP9318PoyGkD8Rqq92HzWeYKx7CG7GX0JQcXuZb99+9C1Apeid8AfElj5pdNT4Mua1zegjrk9pndC8qTH76j4ZuT9zEh78mA4TcaS90xGydy3zsiXZSzZpx1SQqXv2s7TH3NFQ4o8qudYUeTu3obGqbFDjp/7zB4j+IfxhYN/xH7rpdKdNqkACaO4WCsE06jD3SSHlYUaGk8AriI5wFtqjioUatrZk3HOWmTWgqCGLAXC9soDOmNeiBqvRsZiRoJ+7TkR1ohluV3pemgRNGnx/U7rfry6iQ0I97zRctN2xwVMypO6HK4ULq64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2CUYEB4xmsespaKUANIA5mLW1C4umCiFXzjunJZe8U=;
 b=oUxkXs0lg7nAtMH/SwMIjvWCQ1uqy+fZRsaq5lXnR9BU8N2k7Q0iT8Y2kCslGgWw29gizARU8zwkdauBjTpQ4XC9qkaU0vo0f4Dpafvf5tOAD1K8ZrrFhAFMNzVu16aJL+2xWlgygFDFMPiOKjPoJPvzQz1VtGLSriMUDxFCDtz4OQ2SKDL3nbJbLvbLrcjp0DU5uV5TsYKOaepdKq1jnONAjpimlX6flZTcHZYikm6t1k/jBXBd2D5cS2j1C2yM+U66fhE4EYNROXGIxINpr2yJ4UT0eQozs7alTrMRWQodPwDprXxb/iAxyCpK8mGCgs68UYCUQSNexBEtpZav1Q==
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 15:43:47 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::d3) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.12 via Frontend Transport; Mon,
 20 Jan 2025 15:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 15:43:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 07:43:32 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 07:43:29 -0800
From: Petr Machata <petrm@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next] ip: vxlan: Support IFLA_VXLAN_RESERVED_BITS
Date: Mon, 20 Jan 2025 16:43:06 +0100
Message-ID: <5eaf7a5df51b687f3354d9e065c3358f56b5ad34.1737387719.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: c139263e-2f4b-41d5-8b9f-08dd39693a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qqn1CpQ9x2g4UJCfhj0l4YlAeR9LFoMErJ8WJzWymDykbAyoTxQqGbqGOO1A?=
 =?us-ascii?Q?WCYpP+HWw2VFYH+4a1IiMdt4jVAiQAKt2sGAMAUDmZxQaHoy5owfY9RXCMgs?=
 =?us-ascii?Q?1zpBGXPgY1RtbpccyFmUeJT/Hum94VsJ4ViRnH3grke6IbfKamoXD95FIo5d?=
 =?us-ascii?Q?/ZxrZYstdlelVlho4UXYNjrAWu8OK10+/v4zbkJW/RI1wWGNQGznjYNWEbFl?=
 =?us-ascii?Q?71HSkEwbdS4c9qe7wYfMqcvnhGRGH8/AYCm67nWRpdLrxGmZ9+IQmwmHDjpS?=
 =?us-ascii?Q?oghs1qkiSZAy5kiCYSe3iaNnlUYpxZEFDfF7CyrpNgk+Yd1YC+l79KaieggU?=
 =?us-ascii?Q?xGuHY8iv9S2R77Taz78jS+aC9dj2NuR8RhTSteAbqyUh81IUDSvRTW4K14WT?=
 =?us-ascii?Q?RfNKEQ+t/enut3THpGAGJ32VN1MO82kE86l5ZDqzobakJoXlfBwCaM9vzYGp?=
 =?us-ascii?Q?MvAxCgVKN0fo8MxABPiqKbJs+LcDlxqHJTgsQrKXfuFaL4VK9apaxM6Yd5Fx?=
 =?us-ascii?Q?pyJlSG6sagThvJBybnq+Ut7fTAjS83QEGMxvMwvG5biFOcyELA+O+QTUkYnp?=
 =?us-ascii?Q?3ODKAeKUyRC2tAQWQ5E+lBJQt/CyhvA2bGXc5w+r/4V6vQMRrKpRTosvWHUu?=
 =?us-ascii?Q?6IWnx2X2c014MemO3p+ulmI5Bm25YSRkHviq6InBU9yqKGwH+g/gdFXKGfBC?=
 =?us-ascii?Q?VtuGK3P2cuvI3mlfxl5fLLnE5cMqZb3Dj7GZnpZhDDGYme/hwATDg0dDBs3+?=
 =?us-ascii?Q?2LXhTO0LTGdABMy6b2XUzoMjT86JcN3QyxarhJdlujoZcFHABy7hUebX5vDb?=
 =?us-ascii?Q?bhOjR4nVO/9KVgA24WQ+4zJKEvUfJGOh0xRyUiM1U5DJAnyZBH8L1/HJ9anN?=
 =?us-ascii?Q?cpkImT2SUT0LwrcswCPE4mq8a/qmMKuwvOjg9WoyDldkav1ziZ725FAdJ/bG?=
 =?us-ascii?Q?Q7dgkODeK5QxOcbEXbPoQmbl6xbbS/WF5D9Wwm4hAamE0yHP94fuC/9riSq2?=
 =?us-ascii?Q?jRpBg/DCzXtkUpIY6lrlnruRj1zAnooYBNcbWSHM8xIFJZScvTyCoIO+HhxV?=
 =?us-ascii?Q?Tekmpgvsehx+bIYKhQe1FKxj8Z+2iJZQO8hQcqR4jo4lC9AXMvDC1DrnCKnm?=
 =?us-ascii?Q?Xbk5NokV22CaDnth3Db0XApDUQM9KifiHy1pH93AksfvH4nXYClWVGYgARHd?=
 =?us-ascii?Q?72ayxEmUJtkqprOSPRfEOhmiNwZMTgVPt0ywVdey37y2ViqJpbtpscCDm70D?=
 =?us-ascii?Q?6HMvE4MrEzVX6oOkGG0QuurcT+fCng59LfqgAIkz9VYpB5LnHMkidpNXJBd3?=
 =?us-ascii?Q?j1AfbK03cZKzZ0RF2t/CBQMI0+4Bfk1D257T6IoUYwGma/UJL3gmrq57ZtZw?=
 =?us-ascii?Q?luAmVZ8BkaW1/Ef/eg0R7wDnal68yzr9MmI0EDbhQiALoyTs7zTQCRZ/38Qv?=
 =?us-ascii?Q?q2KXcDQOMZUNZEIwXtmxVF/Ts4EcuLjzPSAYZ4jnMdEq9pSpjFGJJ2vjlZ42?=
 =?us-ascii?Q?zk+G/Ry8hbea8D8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:43:46.6957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c139263e-2f4b-41d5-8b9f-08dd39693a4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

A new attribute, IFLA_VXLAN_RESERVED_BITS, was added in Linux kernel
commit 6c11379b104e ("vxlan: Add an attribute to make VXLAN header
validation configurable") (See the link below for the full patchset).

The payload is a 64-bit binary field that covers the VXLAN header. The set
bits indicate which bits in a VXLAN packet header should be allowed to
carry 1's. Support the new attribute through a CLI keyword "reserved_bits".

Link: https://patch.msgid.link/173378643250.273075.13832548579412179113.git-patchwork-notify@kernel.org
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/iplink_vxlan.c     | 20 ++++++++++++++++++++
 man/man8/ip-link.8.in |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/ip/iplink_vxlan.c b/ip/iplink_vxlan.c
index 7781d60b..9649a8eb 100644
--- a/ip/iplink_vxlan.c
+++ b/ip/iplink_vxlan.c
@@ -52,6 +52,7 @@ static void print_explain(FILE *f)
 		"		[ dev PHYS_DEV ]\n"
 		"		[ dstport PORT ]\n"
 		"		[ srcport MIN MAX ]\n"
+		"		[ reserved_bits VALUE ]\n"
 		"		[ [no]learning ]\n"
 		"		[ [no]proxy ]\n"
 		"		[ [no]rsc ]\n"
@@ -337,6 +338,17 @@ static int vxlan_parse_opt(struct link_util *lu, int argc, char **argv,
 			check_duparg(&attrs, IFLA_VXLAN_LOCALBYPASS,
 				     *argv, *argv);
 			addattr8(n, 1024, IFLA_VXLAN_LOCALBYPASS, 0);
+		} else if (strcmp(*argv, "reserved_bits") == 0) {
+			NEXT_ARG();
+			__be64 bits;
+
+			check_duparg(&attrs, IFLA_VXLAN_RESERVED_BITS,
+				     *argv, *argv);
+			if (get_be64(&bits, *argv, 0))
+				invarg("reserved_bits", *argv);
+			addattr_l(n, 1024, IFLA_VXLAN_RESERVED_BITS,
+				  &bits, sizeof(bits));
+
 		} else if (!matches(*argv, "external")) {
 			check_duparg(&attrs, IFLA_VXLAN_COLLECT_METADATA,
 				     *argv, *argv);
@@ -601,6 +613,14 @@ static void vxlan_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	    ((maxaddr = rta_getattr_u32(tb[IFLA_VXLAN_LIMIT])) != 0))
 		print_uint(PRINT_ANY, "limit", "maxaddr %u ", maxaddr);
 
+	if (tb[IFLA_VXLAN_RESERVED_BITS]) {
+		__be64 reserved_bits =
+			rta_getattr_u64(tb[IFLA_VXLAN_RESERVED_BITS]);
+
+		print_0xhex(PRINT_ANY, "reserved_bits",
+			    "reserved_bits %#llx ", ntohll(reserved_bits));
+	}
+
 	if (tb[IFLA_VXLAN_GBP])
 		print_null(PRINT_ANY, "gbp", "gbp ", NULL);
 	if (tb[IFLA_VXLAN_GPE])
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 64b5ba21..d0f30556 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -632,6 +632,8 @@ the following additional arguments are supported:
 ] [
 .BI srcport " MIN MAX "
 ] [
+.BI reserved_bits " VALUE "
+] [
 .RB [ no ] learning
 ] [
 .RB [ no ] proxy
@@ -725,6 +727,13 @@ bit is not set.
 - specifies the range of port numbers to use as UDP
 source ports to communicate to the remote VXLAN tunnel endpoint.
 
+.sp
+.BI reserved_bits " VALUE "
+- by default the kernel rejects packets that have bits set outside of the fields
+required by the features enabled on the VXLAN netdevice. \fBreserved_bits\fR is
+a 64-bit quantity specifying which bits it should be possible to set in a VXLAN
+header. Each bit set in the value is a tolerated bit set in a packet.
+
 .sp
 .RB [ no ] learning
 - specifies if unknown source link layer addresses and IP addresses
-- 
2.47.0


