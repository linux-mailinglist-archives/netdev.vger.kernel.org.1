Return-Path: <netdev+bounces-77031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31986FE27
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128E8282524
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B762230C;
	Mon,  4 Mar 2024 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EsfPxXrx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C13224E8
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546226; cv=fail; b=KvNXHx7x18h4qVoZlQ4Oq45iZKLkwPhgqB0QQNMrsWMtPqQhhedYLOY/eY604+C9TivTzcS/7T8uyY2SSj03KGkxzAPVR76MOXCjlkGWDly3+cexvswvDLU+VjsRWeCbrAuGyULTeIKZ7ejOavWIEbbr2t94FXtcgHQNBIbbdhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546226; c=relaxed/simple;
	bh=jg0pz0kyYv2hE1wf2DJfVncZJVjL2aInrBZVi3lN9D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huwJPI9aKARt24VugZ/2jO+zMZknW46wUyV+oNRQIthNx4mKPJ6XxJUjG0NiBgMvnrHfR2gWhkC2vRqV4ey2eZeG4ud1zY3vykrcGrFyAAORCgNEo6Ie3MlDUlUeWs6yaUTu4Dd1YNAWtyCxyRb9GRdUaO4VJAzkY0RBZ2ww01s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EsfPxXrx; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xzxsdgdf0gZmO2uAx2ZS4eqef+1M/j+3YKsFKFUmSEriTF8Oexe+BJ58JBvcm/bYdWpaBQqb4H5ICeOkfduVqJunIh3UkKPa457BC/r6dQqH7FySyK4XQgD9nJrMhexdDx0Et3nQbJaZVSjRjVpOCv5oCzBn4NOe8fBgmJAOsWR6yVdAKZs6ETVFV/gUeGnRf1XM8JBY5FrjqhlIQH7SDsLVRRaFKTesPXM4qLRzF4Gh0GI8oSSc/dUuOnW3419mzL2ZBGHFCP96v4XjKQg61P2fRFGkihbWxFo7o6NpkkLcOGppTkdwp+WjmPxA1QE8JDwqFFG/gSrrLM1yFDc3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7scL4UJmnMIs9hbzuXXD4YKrNY3zOYAVSDK2D7IjtQ=;
 b=GAzxy3aaR4IQMOOijFKkKgdm/MJ8PH3+UmwrysvNg+V4XFzEFZFA4mKqH4bnzrOsThuU0dv9j/CDikgerwu/Pis3KAOYjdKNh/iCVBdTkY16KsJ/opeHA/8VhGEZwp5JODSEfiZMowlvgha/2fqodTgsjiKXx80S3J1/yWzFOnvQZtbL3XF4+HyWupYJSd4fGvaCj0WYtbG28uwTkYXBy1vzixL/kB6cpDQHOtmeo8H1FX+K5adLmBzeHg+98ctFSpKiAciJrd/LZwU0ZL5yII1wuOOFSClOIy6IP4hEGFjmOuDt4pNxnYJbS8QTMBscpIUvIUKI6PGKWN+CXL+Ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7scL4UJmnMIs9hbzuXXD4YKrNY3zOYAVSDK2D7IjtQ=;
 b=EsfPxXrxavaHeDPPMO3H7CFS1D1JUx5OWOMjgCr+kr/gLEWPVGvdysPrzN6wk/47YTNiQnHcykbL717WaTqXv+1jf1YigGvyon+tgBGTuvjDkUauZvM3fFmvX2u2BH/MOJOx+S5LZGOuquNw7XNHRoaQljqMWqVdZSmOzFu1kHTYNwVKfK2omylo4/3DZIwwfLFT6N4eeTe1j1jMrjk0eZYD+vfoghr770faHL8bvI+PHYYBMKFzsgO2tjijKysgKf8bWRCY/cm4ddRMhpcs89tuDGSiykV/NgcIQgXFL/+npRqTQDaikMnI4LJB6kdSX1X0HARAFR6IH7ZwC2/NKA==
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Mon, 4 Mar 2024 09:57:01 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::23) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22 via Frontend
 Transport; Mon, 4 Mar 2024 09:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:57:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:56:46 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 01:56:44 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
	<shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/6] selftests: forwarding: Remove IPv6 L3 multipath hash tests
Date: Mon, 4 Mar 2024 11:56:07 +0200
Message-ID: <20240304095612.462900-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304095612.462900-1-idosch@nvidia.com>
References: <20240304095612.462900-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0e56de-1e45-45e6-1cb8-08dc3c316fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gj74kgdezcT1RHe3DO6/XtI3fxG1Zh9wNCLPi2lKutFBVQ2DBjSlEUg7GqhJhINE1Z7/Rk3S1LRKztoTc/gQ9TbqfnN33+/uByct5ocOg5EH+ZF0S4XX/PIKls0wYbX6hiWkLzhodFr59BluGEn6FqVxigGdmzBj2jmUBYfebVkVoelkP1W4Ob4G7p5tP/utyhW8Ft7hk+H3fwmRSdjIML0R2eicau9jDcgHd+Ns704g/C5YUe40NFIofNJoTcWyAhHsyeOeJplVOEA+nIdDtg0obb0dQ4WRORtv6yqfYhqANWGrQ/DYl4TE3gRUXuoZIrk44pqHoNaOmyTlZaWEMmF+CeSq0PWpp3TOWKSGt1UGF2lqjpUiLikEcP+1LTIXoYwSNFcBldQFf9b7RqvLBz/ie6VbEkGEsLvObsSEDtAeIZokNPgSjR2TdM/O7AnrLi155LzlsezqVbCwhzYPFUDlp0Z0wwE2igLhFCSbqUD36amCU5OoVjq17yusNsSa4xC+ey/SZUBRgUif/3/NhM2ZDkJODesR6SekveReyjHmC6CJcn+m+kha1SFyZQznE/7o6YWJ2T4txGxFPTzqLxLHzfT8GX5hdG1NPGLeqTaKNLn0mWsfLopjSbPWaep2L9pd9KQJkO7qG61MZivJqy9Qjg1HxA7ls+P6tnLGvlw5b06y+4oC+prCzEbZNCfQNz21I5I1MXaGyTX8xRXrTVT4MGrhazkmukIK5f/z3+agq1qjEtG0ViLWGM1RllNL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:57:00.4942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0e56de-1e45-45e6-1cb8-08dc3c316fca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304

The multipath tests currently test both the L3 and L4 multipath hash
policies for IPv6, but only the L4 policy for IPv4. The reason is mostly
historic: When the initial multipath test was added
(router_multipath.sh) the IPv6 L4 policy did not exist and was later
added to the test. The other multipath tests copied this pattern
although there is little value in testing both policies.

Align the IPv4 and IPv6 tests and only test the L4 policy. On my system,
this reduces the run time of router_multipath.sh by 89% because of the
repeated ping6 invocations to randomize the flow label.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/forwarding/gre_multipath_nh.sh        | 37 ------------------
 .../net/forwarding/gre_multipath_nh_res.sh    | 38 ------------------
 .../net/forwarding/router_mpath_nh.sh         | 35 +----------------
 .../net/forwarding/router_multipath.sh        | 39 +------------------
 4 files changed, 2 insertions(+), 147 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
index d03aa2cab9fd..62281898e7a4 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
@@ -64,7 +64,6 @@ ALL_TESTS="
 	ping_ipv6
 	multipath_ipv4
 	multipath_ipv6
-	multipath_ipv6_l4
 "
 
 NUM_NETIFS=6
@@ -264,34 +263,6 @@ multipath6_test()
 	local weight1=$1; shift
 	local weight2=$1; shift
 
-	sysctl_set net.ipv6.fib_multipath_hash_policy 0
-	ip nexthop replace id 103 group 101,$weight1/102,$weight2
-
-	local t0_111=$(tc_rule_stats_get $ul2 111 ingress)
-	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
-
-	# Generate 16384 echo requests, each with a random flow label.
-	for ((i=0; i < 16384; ++i)); do
-		ip vrf exec v$h1 $PING6 2001:db8:2::2 -F 0 -c 1 -q &> /dev/null
-	done
-
-	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
-	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
-
-	local d111=$((t1_111 - t0_111))
-	local d222=$((t1_222 - t0_222))
-	multipath_eval "$what" $weight1 $weight2 $d111 $d222
-
-	ip nexthop replace id 103 group 101/102
-	sysctl_restore net.ipv6.fib_multipath_hash_policy
-}
-
-multipath6_l4_test()
-{
-	local what=$1; shift
-	local weight1=$1; shift
-	local weight2=$1; shift
-
 	sysctl_set net.ipv6.fib_multipath_hash_policy 1
 	ip nexthop replace id 103 group 101,$weight1/102,$weight2
 
@@ -339,14 +310,6 @@ multipath_ipv6()
 	multipath6_test "Weighted MP 11:45" 11 45
 }
 
-multipath_ipv6_l4()
-{
-	log_info "Running IPv6 L4 hash multipath tests"
-	multipath6_l4_test "ECMP" 1 1
-	multipath6_l4_test "Weighted MP 2:1" 2 1
-	multipath6_l4_test "Weighted MP 11:45" 11 45
-}
-
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
index 088b65e64d66..2085111bcd67 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
@@ -64,7 +64,6 @@ ALL_TESTS="
 	ping_ipv6
 	multipath_ipv4
 	multipath_ipv6
-	multipath_ipv6_l4
 "
 
 NUM_NETIFS=6
@@ -267,35 +266,6 @@ multipath6_test()
 	local weight1=$1; shift
 	local weight2=$1; shift
 
-	sysctl_set net.ipv6.fib_multipath_hash_policy 0
-	ip nexthop replace id 103 group 101,$weight1/102,$weight2 \
-		type resilient
-
-	local t0_111=$(tc_rule_stats_get $ul2 111 ingress)
-	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
-
-	# Generate 16384 echo requests, each with a random flow label.
-	for ((i=0; i < 16384; ++i)); do
-		ip vrf exec v$h1 $PING6 2001:db8:2::2 -F 0 -c 1 -q &> /dev/null
-	done
-
-	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
-	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
-
-	local d111=$((t1_111 - t0_111))
-	local d222=$((t1_222 - t0_222))
-	multipath_eval "$what" $weight1 $weight2 $d111 $d222
-
-	ip nexthop replace id 103 group 101/102 type resilient
-	sysctl_restore net.ipv6.fib_multipath_hash_policy
-}
-
-multipath6_l4_test()
-{
-	local what=$1; shift
-	local weight1=$1; shift
-	local weight2=$1; shift
-
 	sysctl_set net.ipv6.fib_multipath_hash_policy 1
 	ip nexthop replace id 103 group 101,$weight1/102,$weight2 \
 		type resilient
@@ -344,14 +314,6 @@ multipath_ipv6()
 	multipath6_test "Weighted MP 11:45" 11 45
 }
 
-multipath_ipv6_l4()
-{
-	log_info "Running IPv6 L4 hash multipath tests"
-	multipath6_l4_test "ECMP" 1 1
-	multipath6_l4_test "Weighted MP 2:1" 2 1
-	multipath6_l4_test "Weighted MP 11:45" 11 45
-}
-
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index a0d612e04990..2ef469ff3bc4 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -218,7 +218,7 @@ multipath4_test()
 	sysctl_restore net.ipv4.fib_multipath_hash_policy
 }
 
-multipath6_l4_test()
+multipath6_test()
 {
 	local desc="$1"
 	local weight_rp12=$2
@@ -251,34 +251,6 @@ multipath6_l4_test()
 	sysctl_restore net.ipv6.fib_multipath_hash_policy
 }
 
-multipath6_test()
-{
-	local desc="$1"
-	local weight_rp12=$2
-	local weight_rp13=$3
-	local t0_rp12 t0_rp13 t1_rp12 t1_rp13
-	local packets_rp12 packets_rp13
-
-	ip nexthop replace id 106 group 104,$weight_rp12/105,$weight_rp13
-
-	t0_rp12=$(link_stats_tx_packets_get $rp12)
-	t0_rp13=$(link_stats_tx_packets_get $rp13)
-
-	# Generate 16384 echo requests, each with a random flow label.
-	for _ in $(seq 1 16384); do
-		ip vrf exec vrf-h1 $PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1
-	done
-
-	t1_rp12=$(link_stats_tx_packets_get $rp12)
-	t1_rp13=$(link_stats_tx_packets_get $rp13)
-
-	let "packets_rp12 = $t1_rp12 - $t0_rp12"
-	let "packets_rp13 = $t1_rp13 - $t0_rp13"
-	multipath_eval "$desc" $weight_rp12 $weight_rp13 $packets_rp12 $packets_rp13
-
-	ip nexthop replace id 106 group 104/105
-}
-
 multipath_test()
 {
 	log_info "Running IPv4 multipath tests"
@@ -301,11 +273,6 @@ multipath_test()
 	multipath6_test "ECMP" 1 1
 	multipath6_test "Weighted MP 2:1" 2 1
 	multipath6_test "Weighted MP 11:45" 11 45
-
-	log_info "Running IPv6 L4 hash multipath tests"
-	multipath6_l4_test "ECMP" 1 1
-	multipath6_l4_test "Weighted MP 2:1" 2 1
-	multipath6_l4_test "Weighted MP 11:45" 11 45
 }
 
 ping_ipv4_blackhole()
diff --git a/tools/testing/selftests/net/forwarding/router_multipath.sh b/tools/testing/selftests/net/forwarding/router_multipath.sh
index 464821c587a5..a4eceeb5c06e 100755
--- a/tools/testing/selftests/net/forwarding/router_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/router_multipath.sh
@@ -195,7 +195,7 @@ multipath4_test()
        sysctl_restore net.ipv4.fib_multipath_hash_policy
 }
 
-multipath6_l4_test()
+multipath6_test()
 {
        local desc="$1"
        local weight_rp12=$2
@@ -232,38 +232,6 @@ multipath6_l4_test()
        sysctl_restore net.ipv6.fib_multipath_hash_policy
 }
 
-multipath6_test()
-{
-       local desc="$1"
-       local weight_rp12=$2
-       local weight_rp13=$3
-       local t0_rp12 t0_rp13 t1_rp12 t1_rp13
-       local packets_rp12 packets_rp13
-
-       ip route replace 2001:db8:2::/64 vrf vrf-r1 \
-	       nexthop via fe80:2::22 dev $rp12 weight $weight_rp12 \
-	       nexthop via fe80:3::23 dev $rp13 weight $weight_rp13
-
-       t0_rp12=$(link_stats_tx_packets_get $rp12)
-       t0_rp13=$(link_stats_tx_packets_get $rp13)
-
-       # Generate 16384 echo requests, each with a random flow label.
-       for _ in $(seq 1 16384); do
-	       ip vrf exec vrf-h1 $PING6 2001:db8:2::2 -F 0 -c 1 -q &> /dev/null
-       done
-
-       t1_rp12=$(link_stats_tx_packets_get $rp12)
-       t1_rp13=$(link_stats_tx_packets_get $rp13)
-
-       let "packets_rp12 = $t1_rp12 - $t0_rp12"
-       let "packets_rp13 = $t1_rp13 - $t0_rp13"
-       multipath_eval "$desc" $weight_rp12 $weight_rp13 $packets_rp12 $packets_rp13
-
-       ip route replace 2001:db8:2::/64 vrf vrf-r1 \
-	       nexthop via fe80:2::22 dev $rp12 \
-	       nexthop via fe80:3::23 dev $rp13
-}
-
 multipath_test()
 {
 	log_info "Running IPv4 multipath tests"
@@ -275,11 +243,6 @@ multipath_test()
 	multipath6_test "ECMP" 1 1
 	multipath6_test "Weighted MP 2:1" 2 1
 	multipath6_test "Weighted MP 11:45" 11 45
-
-	log_info "Running IPv6 L4 hash multipath tests"
-	multipath6_l4_test "ECMP" 1 1
-	multipath6_l4_test "Weighted MP 2:1" 2 1
-	multipath6_l4_test "Weighted MP 11:45" 11 45
 }
 
 setup_prepare()
-- 
2.43.0


