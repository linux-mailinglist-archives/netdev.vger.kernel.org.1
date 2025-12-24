Return-Path: <netdev+bounces-246022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B6CDCD77
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EFCA3030FD5
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EE328B54;
	Wed, 24 Dec 2025 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZlPvJ7u"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5D2E8B6B
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766593145; cv=fail; b=qeRtmXjs/Zex/nG/5JHu6841eHV0bP1gHzKpDTA0n+bGHmWqLm2gtvN4kr11/rBh2Nk2uVketrsApo3/qgPj0X5JCGywzILRZg9rggUxdlYlF+yRRdpCJEQ6VhQEJsw1ElkK/woptFl6m7iFdeL0xbWfxhlsTxedtJxJprKmXKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766593145; c=relaxed/simple;
	bh=LtpXIvWL0P+z9q5MH6Iw43lQmsIZn8VaglDu9XeBTuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+Ptf/zwMP2SztG1ul9C0YLkaQGtIWXdX8VAtOP6lFCO7wv6tG2xWRHNpeXk687ed4Mi93SjQ8NIXNtq2gC447Qh7DAimebhnAUC9+uh902h0XqsvqY00KLILQxdkj95ZX0+fB+9WJJWiyQhvye5XcAOei8Iogip5eqeNMfuNc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TZlPvJ7u; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCn+yUEU4Wf7TbgSLUsy/LuhXeWjK+IiU5VAMOTFaYcOES8ATNlDGg/Gn/Z1zz81ZM5CsIVU71b2jEvwGQ2EHTI1n+qLDW5msKoDA/CqOaztPzWNHUCElp/CjlxBrXw+c5kbbgierTc0LjQtM+BGyhvzYPJSbv9fY/SWFiY17htVpXYPAlYCHjCpcIW2+jSMYMU7rZYkWKUCxvy3USXAAlcHKtYlms2rWbmZJJVi2qloRcZXSnK7ST+9CJ93vXUigqpQLlpnDFwrLGzVhESoLcaNqOzGPeq7IjHWJVqiyxVeomH+I4WgDcgq2FN38SLI/HMQsmsL93Et091D5+gTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF4Gwhwr8lqxsRDNP9z4wU0bmcHJrhu4wBDpieNrYcU=;
 b=Ou0kK6KAs09ttCdz9Pg+m4tPXUB6mWSAcKDIrX0AlnmdKPow/yxHIXgAi7q0MJ7UAUOWwA9NAng6TUnmdF4A7xEWdpz45SDVBizgdNAYHXI2JWvwve2itMu92gJ4Xi2tkrz6pCGqy075ImB7GS0XV8P5XyY/xvAfhlPILeCgCdHnzWeSp58A0y/Mq1XJrx7Tiratyl5uPOkKHziMC3J2vzrUByALLQxmq8BUyIrnfKLAKlwSGlzMmlU3+Sh8tTwYfgfgQSL2W14MIATq2bs/celfj4OZfd0RW5nriPVosSzhqrf4JRswEY6yJIpDIAkun2Y5SK90XxGjGehJ3DofGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF4Gwhwr8lqxsRDNP9z4wU0bmcHJrhu4wBDpieNrYcU=;
 b=TZlPvJ7uz7boczdJFGs/rO86PpQL96z7fVisOymqW8oWvbXsVDS0tbpAkAscURByCFd/Lbwa3r+a+c/QNdMjAtjXaiSWpXd8yqTJguMwKglDxgM2YWMfQkYuJkTsqNg0lrM6kXnw4gI4eg1CCEKuPYUf8WBj7iVV+r215GmGGOj6Fza50qZ5GWF6PHCwjh1RGQIXDS0bTr4aJwpOKY03V67Quo0iBPjhPTJglso156yC7Pff/e9k4TEGZ/4GXM8V2KnZCDXCW81u1MLgCAKsppnluxVOdtxV0HHXe+P+uGzchCkHWh5F1mWthWkyruO+GMYk9LX5UY/The3fVWnVLQ==
Received: from SA9PR13CA0057.namprd13.prod.outlook.com (2603:10b6:806:22::32)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 16:18:51 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::e2) by SA9PR13CA0057.outlook.office365.com
 (2603:10b6:806:22::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9 via Frontend Transport; Wed,
 24 Dec 2025 16:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Wed, 24 Dec 2025 16:18:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Dec
 2025 08:18:43 -0800
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Dec
 2025 08:18:39 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [RFC PATCH net-next 2/2] selftests: fib_tests: Add test cases for route lookup with oif
Date: Wed, 24 Dec 2025 18:18:01 +0200
Message-ID: <20251224161801.824589-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161801.824589-1-idosch@nvidia.com>
References: <20251224161801.824589-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c856e00-3baa-4f8e-4f8c-08de43082055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7teY9JmlU0fNitxnolcpLqeOknbfKVVCpR3CDFT1P0U6Bs5o4ARUaEQwqjnt?=
 =?us-ascii?Q?iZKep18ympAES1qcKCOkWa2n6s2Ol85y5UW0uzvkp4vgBnm+p9krUz2xqOAO?=
 =?us-ascii?Q?XvKdVesqRGgSjZahjD3tVB+ndciUHr01YFdtjp8CD1/WylAsVNTz3jvXAbyh?=
 =?us-ascii?Q?xdMIEJkJwy5IhvKfXchzS8v4LRhWmza77WkD8EseexSi6eqhUFHY+En+mNNX?=
 =?us-ascii?Q?MoBmG5A9DnV/MFgYUP8zHvQ7qnqhlHRg/n/wdbqXIKoP3UtvIXH25ccFPwDc?=
 =?us-ascii?Q?QkunV//0R7WvzfJafEHw34mb8IV8fi5frstR4i0yKlmu9wfjkTUjFAXBoNlD?=
 =?us-ascii?Q?j0paM4cMlUeBJKlrImJa0s7HCmH4IgFTH81WAPvL6hTGKdF/UrlEJbZMSFbn?=
 =?us-ascii?Q?zvBwXwhx6+qJ6ssvgNWzSh8exctnuzkycR5DWg5CVPsVvvXJGOT6LuUm/Fbq?=
 =?us-ascii?Q?5Qlx4v9kHhJ7LZgdpf/DX6zxdoVYjkNeU54+XsU6iSio7zXUWtl2YVaCGDBw?=
 =?us-ascii?Q?V11qmqHgFIgyKQZV9fxpsQUdCxJI7aJBOYlXQZ2mwbX5HpM7m79R/jsA7DpT?=
 =?us-ascii?Q?fOqubrinrom3YxqqgLk+SeFwQLOG4FU4UQ7Qx5viTGDiC52lg5mwZ/9fi2Qj?=
 =?us-ascii?Q?owHsn7TbE+QV9Ne6ExG188CDSBcLRCWfA4mQau+/iv3x+1ITnmF5OGNLk+xm?=
 =?us-ascii?Q?xO1eXGRavgVAdWSwlVVdKbdAwWAtVgHUvm8LuR0X04Od63yCfTOjsi7nQhxE?=
 =?us-ascii?Q?/hOXuVmSlLjlIFypsKV2XmfirN0+XgMcXEx1/tQsCoD54r7X73VqevXKMwWp?=
 =?us-ascii?Q?aBLpgN70d6RO5tm48KT2mLW07B5FmXOdsdA1BIa+1CKSVjCU9iHmy+aTNnPy?=
 =?us-ascii?Q?ybkQL2Fs15bEd03lPUco+dQtVVfXg2OAwHp/CB62hnfWWL3tIFuvCiYnHar2?=
 =?us-ascii?Q?A0hK2vpxWw7kheFHzNBUdaxmJFxgyydFNf2W0+BvzO8OCRZaFdtB/5JP7pGj?=
 =?us-ascii?Q?cQm/Cs8nip4TnHF+FZD7nLuXACMepchfW4mWhxswvjJN3lzn97jQ/adl4UvL?=
 =?us-ascii?Q?iFtAFtiwHjHOVwQkXHfMDHUR+8O7vDxcSH58QkekuveJI43h9TBDI4IVW5qx?=
 =?us-ascii?Q?XfysqR9OJwPqOf4MjcyvH195w0usNbiHZTbPOeKVwNiVU4XK8BetlQak3eUK?=
 =?us-ascii?Q?45bblhjLw/hfUVqSqYTeN+q9G+aNibIFoCq96YrY8iMoTOTRvSI9oZwVqb7e?=
 =?us-ascii?Q?gA0Bueq33YMwvdoPBGVeTdjFDOUQLrr/LIK2ssopEDd6CaGG/NNu/4cKZOCS?=
 =?us-ascii?Q?Tu1if/oDqf1lagDHUzsLZCLtafYFR3GoQ4FnKkADB9ML5bljotI848A1JjXL?=
 =?us-ascii?Q?2WwCuYOSq6HQ0Pr+VC9En77zzkVvsK/s+hEZR+bzbGdhohLAxqkbNXdXcdSz?=
 =?us-ascii?Q?3BN6YiJ9h3mf8m6WYJjiGRgzaIdNKq1kqZvDY1KfIlzjHInpfvGw5dGcKupj?=
 =?us-ascii?Q?sL7uURFMtyxWWKak8nkcAmnE7PL2BXwy3Ek3Ic7rcI/xYVleCh/KKZ89Sxjw?=
 =?us-ascii?Q?S10QPNBYixG8X5XRStQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 16:18:51.3525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c856e00-3baa-4f8e-4f8c-08de43082055
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096

Test that both address families respect the oif parameter when a
matching multipath route is found, regardless of the presence of a
source address.

Output without "ipv6: Honor oif when choosing nexthop for locally
generated traffic":

 # ./fib_tests.sh -t "ipv4_mpath_oif ipv6_mpath_oif"

 IPv4 multipath oif test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [FAIL]
     TEST: IPv6 multipath via second nexthop with source address         [FAIL]

 Tests passed:   6
 Tests failed:   2

Output with "ipv6: Honor oif when choosing nexthop for locally generated
traffic":

 # ./fib_tests.sh -t "ipv4_mpath_oif ipv6_mpath_oif"

 IPv4 multipath oif test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [ OK ]
     TEST: IPv6 multipath via second nexthop with source address         [ OK ]

 Tests passed:   8
 Tests failed:   0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_tests.sh | 108 ++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index a88f797c549a..8ae0adbcafe9 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
        ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
-       fib6_ra_to_static"
+       ipv4_mpath_oif ipv6_mpath_oif fib6_ra_to_static"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2776,6 +2776,110 @@ ipv6_mpath_balance_test()
 	forwarding_cleanup
 }
 
+ipv4_mpath_oif_test_common()
+{
+	local get_param=$1; shift
+	local expected_oif=$1; shift
+	local test_name=$1; shift
+	local tmp_file
+
+	tmp_file=$(mktemp)
+
+	for i in {1..100}; do
+		$IP route get 203.0.113.${i} $get_param >> "$tmp_file"
+	done
+
+	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
+	log_test $? 0 "$test_name"
+
+	rm "$tmp_file"
+}
+
+ipv4_mpath_oif_test()
+{
+	echo
+	echo "IPv4 multipath oif test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 type dummy
+	$IP link set dev dummy1 up
+	$IP address add 192.0.2.1/28 dev dummy1
+	$IP address add 192.0.2.17/32 dev lo
+
+	$IP route add 203.0.113.0/24 \
+		nexthop via 198.51.100.2 dev dummy0 \
+		nexthop via 192.0.2.2 dev dummy1
+	set +e
+
+	ipv4_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv4 multipath via first nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv4 multipath via second nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy0 from 192.0.2.17" "dummy0" \
+		"IPv4 multipath via first nexthop with source address"
+
+	ipv4_mpath_oif_test_common "oif dummy1 from 192.0.2.17" "dummy1" \
+		"IPv4 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv6_mpath_oif_test_common()
+{
+	local get_param=$1; shift
+	local expected_oif=$1; shift
+	local test_name=$1; shift
+	local tmp_file
+
+	tmp_file=$(mktemp)
+
+	for i in {1..100}; do
+		$IP route get 2001:db8:10::${i} $get_param >> "$tmp_file"
+	done
+
+	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
+	log_test $? 0 "$test_name"
+
+	rm "$tmp_file"
+}
+
+ipv6_mpath_oif_test()
+{
+	echo
+	echo "IPv6 multipath oif test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 type dummy
+	$IP link set dev dummy1 up
+	$IP address add 2001:db8:2::1/64 dev dummy1
+	$IP address add 2001:db8:100::1/128 dev lo
+
+	$IP route add 2001:db8:10::/64 \
+		nexthop via 2001:db8:1::2 dev dummy0 \
+		nexthop via 2001:db8:2::2 dev dummy1
+	set +e
+
+	ipv6_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv6 multipath via first nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv6 multipath via second nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy0 from 2001:db8:100::1" "dummy0" \
+		"IPv6 multipath via first nexthop with source address"
+
+	ipv6_mpath_oif_test_common "oif dummy1 from 2001:db8:100::1" "dummy1" \
+		"IPv6 multipath via second nexthop with source address"
+
+	cleanup
+}
+
 ################################################################################
 # usage
 
@@ -2861,6 +2965,8 @@ do
 	ipv6_mpath_list)		ipv6_mpath_list_test;;
 	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
+	ipv4_mpath_oif)			ipv4_mpath_oif_test;;
+	ipv6_mpath_oif)			ipv6_mpath_oif_test;;
 	fib6_ra_to_static)		fib6_ra_to_static;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
-- 
2.52.0


