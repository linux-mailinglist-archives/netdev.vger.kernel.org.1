Return-Path: <netdev+bounces-220721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A48B48578
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779127A7BC8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C072E7186;
	Mon,  8 Sep 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZ6x2P74"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604827B328;
	Mon,  8 Sep 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316927; cv=fail; b=CmppOAVULmT8JXRj6AQ4VyciP80wnOaRyVo1clJQLBPo86e/0pHVqkdAMECBmZ1rnIBWN2ic534GZA+O5S0xR5dUK2n9bKRLoBqURsQyRpG3uioX+x3U8qBWike5dt2zaUCQVa0dUkwUmYvDmrhVfF2TeoLWfrQuCqgIrspa9j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316927; c=relaxed/simple;
	bh=3lT4GnudNS9ie4KQeHX+VPeWqj8Po8zY52TslDrAt0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eld2IkAJBGs2d5+O+wKoL8taF5rxoN1o8VzR1S3Iu28x5t2i2H1Qu1zxsUnmf2HZ8lwSqguWKpymmpKyC3gvmH1p4nWYVHqqM6MkotYoSQ7Sdvb2enuI5oPNJL/Eoc/9Cb13CqKyZ/32do6HLzMfYKT8DkNSdYKPklcjy/sa7No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZ6x2P74; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plP1Mk2AdTCUsCrsBFQggUqc5I8dDQwhusxTFiRPra5lZ9+hQNDJTQR5O/UUsiOTj6oUC/aomHRPoJkO4zaNYEjA2dNdLHIPs+uzYvsIUf1Sdk+UHKkRzIa47fbd2E5fSlNsdO6J0IGoHeQa3jxWGU9Ayf5A303S2/TgHGcUnoZxBAuaUn/Jb9c7W7k1xysc7+kBUVFHkORwYzLqMV6dHFLfU7Mkg8K6RCMsxM+3lfP4ihpE5r2p4zw3U9OYqlNtSLbQZTzD91oA2b2Nq1xyghEwJ2MuDL9CMpwtzMhXW/duAhgUQdzHPGh8xRJMIhWpPcSDZDSkApOAhL/kHZETHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp5ioPshhopxfPpTDWWijiAEU0BzuUKSqNrMNWsBGRM=;
 b=tmsoDFFjVmfmYi7LKj2K6scpSRKeOF/mSYiYBMb7FZ7Xnpc8miFrJmwN1n7EPE2SkwlAhVLdMeee+/6mXsB2V09Po/oAGHOSz1m5Y8Az600kd+v/ikbfGXFOPVi9TaeKrXPGPIdTxcMsDvk9ANdZR4pP173QHC7fx//4YQ59SMe3Ze2KbFjUP1U3u/bpD0X1AaO5gYsnmbJoGLXIjknHk1AC3yYgEbqyIkd1K54WlIG1vYwJc6j/Kvn4l6By9c07gY2bC4i+f4XDVMsJM4u9SbFB3LbK0yqFwTmHwP72A4XKGk/Vfz9vCVsj4Evr6oQfcg8lAEkuz5a8BQVP9K0OVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp5ioPshhopxfPpTDWWijiAEU0BzuUKSqNrMNWsBGRM=;
 b=ZZ6x2P74EYu9Z3UKb7FbsjgaMZBIHS3WMwPBhjIiCOwZmxT9JmCgfT6UDtdV3G8wxiv/AwdPSM5MQGYiyrT4zJQskhIeBgqFuRlhbt11af6Rj1Uh/eP+VO5jzB7AdFSFnt3ZjM7Hwb0EJ0oZN2DHVdZKJIe4ps+3ucI7+U8qEfPu5UNDHKyOYVtqIpHSQU11IhHm4CtEZrqexIZoQcegTcuYXrZFkikZjLFY5oLLkKc5T+6j8t+G1eAMKUfGGX3Dfo6IzAF/XSSVst6OdN6Y0gZL/Hffs/mLFj33lthbGn4ViTWwjidLWnaFFGtseYMIZ3gBXSsdPa9yii76eo6sAg==
Received: from MN0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::14)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:35:21 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::a) by MN0P220CA0019.outlook.office365.com
 (2603:10b6:208:52e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:56 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:48 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 7/8] selftests: traceroute: Test traceroute with different source IPs
Date: Mon, 8 Sep 2025 10:32:37 +0300
Message-ID: <20250908073238.119240-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908073238.119240-1-idosch@nvidia.com>
References: <20250908073238.119240-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: b739e780-0b79-4200-1239-08ddeeaa445f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KCqwjUxtkQrDGpEtI/iSdsn7bqSwGpGW17FQcG8KAOPCAitiwxICNxHvoAuy?=
 =?us-ascii?Q?fZl1PCaoNBwxxra0ObJBd8wnt2/hqrGMu91GQezXwO94h37rKRQrZBXKof5T?=
 =?us-ascii?Q?FbdZ0lYrWcZIfyQm1RmN4Q7ydXQZIMs9yilVGcLGsrk8zFPsWzDhYUG9Ay6X?=
 =?us-ascii?Q?v/0NoNydXJelPsjz32QhFBbOAnoIUoIeUeB4S1KjXZv6uI7GsyH8KZEadfoQ?=
 =?us-ascii?Q?Uw1hwzxm938yraXjuktJSnyYbCFuRswnrl72J2MdAX8Pd8GRoRJPZzP/2bDj?=
 =?us-ascii?Q?qyBVOQYAvlFNnMj2gpEd/pgaGlZwEnLtemZMJYqq4g2UFJJW9b3teUJ0yaE2?=
 =?us-ascii?Q?9IqkMtfxqa9D0yQF9JIqQ6756SVJpSKOLMTCOl04OKgf9NWHDfipDVvX9E69?=
 =?us-ascii?Q?NKftJcLRiS7JO+fnde/MI6Y2VjgXB7lcYA1ibNJtVXiiefNtcHNmyJ8+d4qc?=
 =?us-ascii?Q?M6bLCtAQ/riK+Ik3bSqVG3g3X++pkRvsCVuS7ecZSqo/4Y4dXMXvHjG7O5cE?=
 =?us-ascii?Q?Q8tBaYUAnRVQgFxZwdkmJOUGLAW8MxCFtCOeJaejTCFLHzQFsEX6d1LKucVO?=
 =?us-ascii?Q?o4hCG02ysr4WOF+oRJirFGH7/d2N62GUuurG157qhFTYR7/BHgDcs4u3dbun?=
 =?us-ascii?Q?0xkZJqm1efaWEIkj5QYGdVlUe/lqqsLRGgi1YcYgxsSw+KpShykdbuvdWBkU?=
 =?us-ascii?Q?YU/utrSU7Rs7WStf99YXcuXZ0CHMSG8g1btu1Wk027zgw8RsINmFGLytEZJj?=
 =?us-ascii?Q?uP4yQZY0EVc0w5aK4oVJZYqieNqCEUmLb73F34poxBNIb+pMc2Dw6dtVy4AK?=
 =?us-ascii?Q?+3aWkvwnjga/BDNFt7ELEPOSXSdJaaC7d12QPio1d7hlhRARR+klFllrIbhd?=
 =?us-ascii?Q?5My0znR7PBCs1DgchlWklC6YEtuIUOgDdr05ignYwDWxWjAcaWpbZemdfbFq?=
 =?us-ascii?Q?vGjJuBgueis6A+dc1VolMzWorBjp5JlE7dPNeqXzlYOu5fJV5ZGFsctn6PdP?=
 =?us-ascii?Q?tU+j5Q3l380ssJ1Scrtc2MW5sQYG7Lxb6ARK9Mp9dOUA7tkbj1y6ha7uhMQj?=
 =?us-ascii?Q?1CbGDDsoDqRbzxwjNoalDQ69/qLnYm6O8GrqJ5g4uUAzFlQIae/ywhjFRthJ?=
 =?us-ascii?Q?ubycaX/ji6UzxOe6Sc2cS0qafxHG0N07z20QPnSm9RPrJa/ce83tv31fwZN5?=
 =?us-ascii?Q?Dxr4JVqw3ROPdL4KkyI2puOMtmz0rGgOBiitaJg+XqeoW1dCJSlhN4tWoeIk?=
 =?us-ascii?Q?G4H6Kt5bjHVZRUz20/qiOmmFKmJnqe1JZ4NBuIowqEN3gWtYbGT2FOMB2YNu?=
 =?us-ascii?Q?xpuft+DxI0yCo26dKvteDFxFlShAcBP3Hx9XwvLPL/k7V7CSsU7WPiOvbQgZ?=
 =?us-ascii?Q?+JoDkAxT59T/B27XNaGaHwhQEwSBzduVR6mlD7uWhpubY9o8Jt/yEpfaAo14?=
 =?us-ascii?Q?X/ZhH6xCH/6zmYundNRky7jGZ/OG5IPjQvEFIDJ/4V19Y016bZCUANlPOMJV?=
 =?us-ascii?Q?URx9pG36F4bwFe5KpvsiBg8hDF03MH5nwrY+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:21.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b739e780-0b79-4200-1239-08ddeeaa445f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325

When generating ICMP error messages, the kernel will prefer a source IP
that is on the same subnet as the destination IP (see
inet_select_addr()). Test this behavior by invoking traceroute with
different source IPs and checking that the ICMP error message is
generated with a source IP in the same subnet.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 8dc4e5d03e43..0ab9eccf1499 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -196,9 +196,10 @@ run_traceroute6()
 ################################################################################
 # traceroute test
 #
-# Verify that traceroute from H1 to H2 shows 1.0.1.1 in this scenario
+# Verify that traceroute from H1 to H2 shows 1.0.3.1 and 1.0.1.1 when
+# traceroute uses 1.0.3.3 and 1.0.1.3 as the source IP, respectively.
 #
-#                    1.0.3.1/24
+#      1.0.3.3/24    1.0.3.1/24
 # ---- 1.0.1.3/24    1.0.1.1/24 ---- 1.0.2.1/24    1.0.2.4/24 ----
 # |H1|--------------------------|R1|--------------------------|H2|
 # ----            N1            ----            N2            ----
@@ -226,6 +227,7 @@ setup_traceroute()
 
 	connect_ns $h1 eth0 1.0.1.3/24 - \
 	           $router eth1 1.0.3.1/24 -
+	ip -n "$h1" addr add 1.0.3.3/24 dev eth0
 	ip netns exec $h1 ip route add default via 1.0.1.1
 
 	ip netns exec $router ip addr add 1.0.1.1/24 dev eth1
@@ -248,9 +250,12 @@ run_traceroute()
 
 	RET=0
 
-	# traceroute host-2 from host-1 (expects 1.0.1.1). Takes a while.
-	run_cmd $h1 "traceroute 1.0.2.4 | grep -q 1.0.1.1"
+	# traceroute host-2 from host-1. Expect a source IP that is on the same
+	# subnet as destination IP of the ICMP error message.
+	run_cmd "$h1" "traceroute -s 1.0.1.3 1.0.2.4 | grep -q 1.0.1.1"
 	check_err $? "traceroute did not return 1.0.1.1"
+	run_cmd "$h1" "traceroute -s 1.0.3.3 1.0.2.4 | grep -q 1.0.3.1"
+	check_err $? "traceroute did not return 1.0.3.1"
 	log_test "IPv4 traceroute"
 
 	cleanup_traceroute
-- 
2.51.0


