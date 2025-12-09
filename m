Return-Path: <netdev+bounces-244144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE1CB0681
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EFE930D1722
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F572FF17D;
	Tue,  9 Dec 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5OFwwvF"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADB2FF669
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294267; cv=fail; b=iG/sWWLnkJJ8N2iQ8a4zK198WcO2m0JGJ97HW2/uirHBnHffs4wTVqX3NQUiERkNiCM3MjwMRC6oLRSuepztkHqBHdxEYJvuXYugWRIaBnxo+4QbHCxz/+VhbwjA7eyyRF6uzoEaWAWUkDlAKdByraVYQSFCuT7kKLZ5/jQPfTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294267; c=relaxed/simple;
	bh=jDYxlgVoB3E8xhkgfWMcCnqnnFelgYSaKSZODyxozkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaY8A1DNOxxbtJuhLmIQAUJvPlLR6uFqeVGjSe3q8R8o/iQvHDFO05XW9rgYkTG+FQoPw4M5oshF6sKerYHDx+I0SUwfpSiO6icHK+4tik/YGe1hqTot7h/sHJh9phx+ZE1By6S4qssYMRn323Mwl73XsfwN9BlfhmD37ss/uCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5OFwwvF; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQAGEYjki55kf/ZmZ03kjnwL5QX5Xx1bRB/BqBx9q3dl5T8RzAZjoU32up4M/gvkbnna6Qy3BR6fG79m3AkpvtN0LoXPaQ9b0qupFXMZkOIswZEObo5UJO3sB9SDj7Vt/OH1iRyoP9I4+QliZ8QWDcHBMbo8FSqkSCLIa1GwcZ/AmvekjLxkeXd9U15mK9Qv+X4qKeO3LQI0kxRLIR85/vcFoGUhFajr5lYsv+n1HVgl/byW+vsevMOvmJ6GkWwIkJF80bRSTRqHTZ1jnJdwvwX/FOenlZu3Ix72d09HJRqcZu68A+a6Cv6MDOrjyOSsT5iKDxnLA2NBHDXRiZLDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROXOJGyjNbVITBo4GVoqO0PFpC1fQHI170MMrE1nY+I=;
 b=Nv+pAjCMamx2OolYtOTXIFs8AEnUuwcBAwgskDmIPodewb4T1w3Tl6LpevUsdUEElpUYMtIn2VeCzVU/M5l5giMUJsTnhVunP3i8+EFZ1aGKu0xxgx1AS0o8gDufII1G74E4HFOWYN4DqFiS3vXaQxSgzFp62tPqwGVhxeGWZVIbe4NQchonSEpiDwKANOcZTnVzgKL2lXPjTzbOz/F3xcVzf18TF+9Q+5OBey2Qmr1yRbjJQg9VpDeHmkKIy/gHoQT3QSK3dE7Grb3ZImQVXxDQEolGPU1mDu1rhWl5P/BHT4LRF/Huh4iCYYVTE14iI5xddzJXGh+xPDSBHJYKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROXOJGyjNbVITBo4GVoqO0PFpC1fQHI170MMrE1nY+I=;
 b=h5OFwwvFA87TTDdPS6rtR51TpLWZtturXy8RJzwZJqnrkBIVHzAyUzY2xyQ9Lk6uaQON7cyZK88K9ZrIA2PjzNybyS+WCjI3EqYobJlW7acQ/EzAHOaH8xiZ0Om/9jP6qud3c/5iM50xOaSmIh3BD9lqfS8JXx5xK0LswpiM/Zv1X9s1f6oGu9FaAvflGpy8j4TyQRo8qUrQB5Lw0XlOBmHwhMXrIeAU+Ubthm+OxpuJxlCB79JFnVQltV6fD96FbNMW2Xtg0rHJ9AD2icwNz5o2BclB0gFwTZVE64A7YH1De5gLdup1/8ecwaBGs0rWcEEgGBfiSxGN9CmFkb5sag==
Received: from PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::10)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 15:30:58 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:34b:cafe::6f) by PH5P222CA0008.outlook.office365.com
 (2603:10b6:510:34b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Tue, 9
 Dec 2025 15:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Tue, 9 Dec 2025 15:30:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 07:30:24 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 07:30:19 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 2/3] selftests: forwarding: vxlan_bridge_1q_mc_ul: Fix flakiness
Date: Tue, 9 Dec 2025 16:29:02 +0100
Message-ID: <6438cb1613a2a667d3ff64089eb5994778f247af.1765289566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765289566.git.petrm@nvidia.com>
References: <cover.1765289566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d801960-4912-44fb-b638-08de3737f2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1OzR3mAwpw/zt3q1KQGIDNebkSgwxW5HW645vfV94YJF+zHczy+/jyiyvoc?=
 =?us-ascii?Q?Ozpnm0qrnR8au1KSHPmf6p6zivI2DKbIfPx0bThHTykUeq9Yzby0jwwn1vYG?=
 =?us-ascii?Q?bE9FO7ZW3tF+4jTjafQp3UC+DRnUGXz/94glxV/VS0x37KDoprVN90auGOqS?=
 =?us-ascii?Q?ZXr38G8oA6P32p1MvTsZynwa5JQsNQGknUST8MlANA+MfqCXtB39TNmWyZnL?=
 =?us-ascii?Q?IS9N4SVQ35UI1HtL+CwWMA04Kh1UcXnUw4KIDFPZNmdbel2ORGZw058Wya+/?=
 =?us-ascii?Q?lGojwBBXELP+qoH/ohtVvVAYu8V7JSTZWCpkkzaoN8YTJYIHA2ByFeYwrHHM?=
 =?us-ascii?Q?JDYQ60tcDlsAXTo8UVju9LKsG4Pkiqzhf676PHVo+FfjPLf0Jao5h41lDCOw?=
 =?us-ascii?Q?sIj4GYHoNu5xGdep/taNcZMbPZUtSvUJdIThAXyZxQiIaL5Q9+/R49BgeXRV?=
 =?us-ascii?Q?vgv2+GtnRekxJYi4gETeO3v2z2RLpi+f2+rPnmimD/WPuVxAubwPbxpkMi2q?=
 =?us-ascii?Q?5XH20n3ExMLCAdBQ+obbmLOKGCLYbRs42AR52Jaj+uu+/CA1HubSCgM8XLT1?=
 =?us-ascii?Q?KDEm+WXDFO0o3OXg4BI+S6jQfalePGYyYyF7cj3OVb0DCCBGbr/WnJScRi9D?=
 =?us-ascii?Q?IMWVbwoCK/HktmAG8kUgFnl8+A7MMwVuhDyvRiOw824oKTnlTv9qpuzeYbjC?=
 =?us-ascii?Q?/QPxH/oMDHQ5vOjGxuh0Xj7OcwscjJoGHRzWJAhfBRdDqon3IoHr6n+tA7TB?=
 =?us-ascii?Q?ScnqqcIFfwplhCW/d5jf9BkRL4BwG8kZ8uopfWDZf4+eczA+ND0T3Cf4gv+b?=
 =?us-ascii?Q?IR77OOwuiH1MkAeVR2DCdMMjLNZvrjScP/PnYa+lQY7VEGF/dmIKFYn9xx/i?=
 =?us-ascii?Q?uWk4EIsVwnII6z/uGm0pvb9UGjKzGnjcJq1cKbGq/NnaUQ6n7oC/RITjUOL1?=
 =?us-ascii?Q?Em+OWSRYd22GpyjM2NuHH2chw3VO/wJUfmL0KoukiUJjWfs1KEVgUHv6vAlx?=
 =?us-ascii?Q?uodSichYBWxbtKXepsmzJQclCnxU9YcxPVOXhz7xx5UYd0VxLIWYNjAWXWS1?=
 =?us-ascii?Q?zt+V9d9F0waixrFAnuFL4FTQ9Uhev9WXW3WE6y/5Tk1uUlvqG+MX11RtfsFB?=
 =?us-ascii?Q?UP8Bad0S8AzSUxHnFSCeEodASxDw8DQYsMR8+2u6MQNAUsdKOxgJDukvUP5Q?=
 =?us-ascii?Q?sWj4IdtlUmF2llHaKIfLRuNkik1MzTSl+Jov56Qy20GvcYqpyBcKU1Lm1YEO?=
 =?us-ascii?Q?sA/axcspOVR5tbcLPVEP2qqZYPEW2DOBAGce0Rr1Yx/xwYytRL+9/akk1D0D?=
 =?us-ascii?Q?yJVplIiKctNPSL0NPwvKn9q365TrJCl3bmDLA1GQ+4axqkwKagEqtgZ41XwW?=
 =?us-ascii?Q?Zx0rctQ1vVwSMb0XeS02HSgyjkARes7dG54lCRgQMduYY1myyZRKvr8UAc93?=
 =?us-ascii?Q?2tNMTN65K8y0vmpYhMdp980JgGyQkxSfDfW09BBuuFeLo46akMG+uIL1bwRs?=
 =?us-ascii?Q?aGUYBIR3LXbfd+GhDIbv8YPbu70dLaUpoGufAUqktVwyGFDN4bPeuOu0hCZ8?=
 =?us-ascii?Q?ZdpHwtlA96qxvp/gawc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:30:56.7257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d801960-4912-44fb-b638-08de3737f2c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590

This test runs an overlay traffic, forwarded over a multicast-routed VXLAN
underlay. In order to determine whether packets reach their intended
destination, it uses a TC match. For convenience, it uses a flower match,
which however does not allow matching on the encapsulated packet. So
various service traffic ends up being indistinguishable from the test
packets, and ends up confusing the test. To alleviate the problem, the test
uses sleep to allow the necessary service traffic to run and clear the
channel, before running the test traffic. This worked for a while, but
lately we have nevertheless seen flakiness of the test in the CI.

Fix the issue by using u32 to match the encapsulated packet as well. The
confusing packets seem to always be IPv6 multicast listener reports.
Realistically they could be ARP or other ICMP6 traffic as well. Therefore
look for ethertype IPv4 in the IPv4 traffic test, and for IPv6 / UDP
combination in the IPv6 traffic test.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/config       |  1 +
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh         | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index ce64518aaa11..75a6c3d3c1da 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -29,6 +29,7 @@ CONFIG_NET_ACT_VLAN=m
 CONFIG_NET_CLS_BASIC=m
 CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_MATCHALL=m
+CONFIG_NET_CLS_U32=m
 CONFIG_NET_EMATCH=y
 CONFIG_NET_EMATCH_META=m
 CONFIG_NETFILTER=y
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 6a570d256e07..5ce19ca08846 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -138,13 +138,18 @@ install_capture()
 	defer tc qdisc del dev "$dev" clsact
 
 	tc filter add dev "$dev" ingress proto ip pref 104 \
-	   flower skip_hw ip_proto udp dst_port "$VXPORT" \
-	   action pass
+	   u32 match ip protocol 0x11 0xff \
+	       match u16 "$VXPORT" 0xffff at 0x16 \
+	       match u16 0x0800 0xffff at 0x30 \
+	       action pass
 	defer tc filter del dev "$dev" ingress proto ip pref 104
 
 	tc filter add dev "$dev" ingress proto ipv6 pref 106 \
-	   flower skip_hw ip_proto udp dst_port "$VXPORT" \
-	   action pass
+	   u32 match ip6 protocol 0x11 0xff \
+	       match u16 "$VXPORT" 0xffff at 0x2a \
+	       match u16 0x86dd 0xffff at 0x44 \
+	       match u8 0x11 0xff at 0x4c \
+	       action pass
 	defer tc filter del dev "$dev" ingress proto ipv6 pref 106
 }
 
-- 
2.51.1


