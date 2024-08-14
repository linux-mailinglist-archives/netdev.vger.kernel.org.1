Return-Path: <netdev+bounces-118443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27BA9519A6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8773C283A05
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA51AED23;
	Wed, 14 Aug 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HaBq7keb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A71442F7
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633880; cv=fail; b=JkiNlEPOpH78qzE+oHBIAVsxHpDYd1SD4KpXxHt2jXIPyvtcB8hSPVGkkFP2Tx6b9SfD5roS6U/cN7qNRGEaACXj5/X1Ofi6F9YFYwWndrKXcLzGvaEbUwv/tTTXx6zU2/fSfnhfu6HTPdSxRBzvnwdcv6P/iPC0TKcKPXmoQOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633880; c=relaxed/simple;
	bh=Zue00ZRP1U0fk6gJ/9JiNeVdBe+PRBvtUFsFMazgGlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5rrT2gBTfJoaQKvrt6tH6Ze5Y5X1aQOsoMK5tkPXH4BPWO0sqLq0v8Elf2ho+rA8SF/RO/IP7knQblPHk2Sp/iwikMqE7qiYIUa5ZtgeaTBepGxcjTVwWbxob5xpUDB2xlVcudjRbOwwzPwJGUOit7iv123bC24W/xAhI4cRWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HaBq7keb; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpLtmnd86PigqokCEG8+EMW0a5u8vTobGzRZpymz+33hEz7ztWdQkc0ummDmZeK/hz//cQofQT1ePoo0LE2D+d5f7xhJ3NFSdNZtWGCICgcAYOmFA79Bo8LdYj6gNSOqP8sEpgT3mHRmqLwnxyISKWPSFTQI+Pb2HfAoeQEmHnp2WG8tYAwlStyLW/YSBCv/a+0N2TVLdV+5pKe5+DUbKSZCDc4JUHmDTrVSTRR16uGduX28g2Ay+O7OQbVkHP37Oyc9u7EZW8eXW8gCtkoHpc/vIwL12IPqgdILntEHd6qBHGNnCOWxr4kh90woxgGsks0FqEBC94pAEYw0tOmhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcKRWOT7rydL7F2EgvytEgrmFWCz/ouUxktoT8yLMkM=;
 b=tJlm+9VJqhQlIogqQs0LBVAW/lYLYVaUisqnYINdZk1RmwkGrxoYYgjzPzvRvi4P5pq4bJM4k8B/+eK0kfECthaMpkv9KgHYj3CpnBvyYwPrHF2lAuUiXeyd2g3VXDaqh+4dFAZFFL8a63OsHmD7UFw3IB/SLov2quD8JzjBRW9DuzHXp35fFit1i2T3CGFUR2rnPu3IYXzfwdpxOTfLsHFbd0R22uc9IY2MixsKi8QwGrtgp6F6aXNMVdmaieehzS0B1UDAjqw8qHHqUq7QAeKWMJAcM98EcTLpbf2gEdPqEhMHiV7K4DHnUUyfFKRHfOtAworvN53dMW+r1TUALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcKRWOT7rydL7F2EgvytEgrmFWCz/ouUxktoT8yLMkM=;
 b=HaBq7kebQAGTcIkyNtZrgKHHE90zNq06NfEZubbCyVckEVWWMaI2Qk9rw4EoMiCPFAiKawJS+74DbG5r7Oza6ZGn0RFxAY8ZMdNnLrksEgJw3dbzweKKLEAuBKp5S8nkT9P/9RIE2YKoyiZfrJnEsNXmF6xbiD3GxgrpnloM7DfHYchUXxUX1nA3Zv1kJ2XFvB0+B/06j7Lq0wDGNsqXN4BirCKd7F6kEPLtMgu+wFI7y/z0zG8JBLtkAOl2TTYTCz+nEf+I3adZ9uDrzxHZQwy58xfN+O0MkyEXno8xxQRnkiNHkBWvE7y8j6OWRn9JtjsdIz6Ubm3stzzZoG15+w==
Received: from SN7PR04CA0111.namprd04.prod.outlook.com (2603:10b6:806:122::26)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 11:11:13 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::46) by SN7PR04CA0111.outlook.office365.com
 (2603:10b6:806:122::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 11:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:11:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:54 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:51 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/5] selftests: fib_rule_tests: Add negative match tests
Date: Wed, 14 Aug 2024 14:10:03 +0300
Message-ID: <20240814111005.955359-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814111005.955359-1-idosch@nvidia.com>
References: <20240814111005.955359-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b2fb97-1f46-4a6e-9c00-08dcbc51cf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jpXSRMc8Cm8OmXxlTSxHi6ZmVDv+aNvd92PzCwqnvSn0elB66l9kFtyXjVwQ?=
 =?us-ascii?Q?KQUlD6TCkqmcV1PwoYzMQpkC2TpKIwPV0VCN9jo7yHvx4gdQ5/WWSMrgidmQ?=
 =?us-ascii?Q?yF21yf/n+JYg92GKTdPl98fFrvSD5h67wX4bLmO7uWP4d6rhwdOkx/huSNWo?=
 =?us-ascii?Q?mYb+b6e4NGSNcOz0fG+wPg6z1IJnxZmww4jwKO8rM2gZtinvcf5cenHAMruY?=
 =?us-ascii?Q?W2hdU1W2S6tLr1bKhi2Cz3OJKgk1/P9ctQvrGufd2eQ+xBANYDC/eScllx3G?=
 =?us-ascii?Q?rwKO1xGynLVW20tg2/QylOyvP77X5pgUH1YmmQ6naZhwXoPBJ1wDRcQqpDcL?=
 =?us-ascii?Q?yH2rvq7N2liJ23hGJOKxD7q0dnCbRuzcDLzL+IstpBmBQqGZPfYrg/wfpwdf?=
 =?us-ascii?Q?fzUHLTQuG+q8+9MaLon/pXF2WbMniMQLxAZOpuB0C+w2X8nyQxsZRbEQd7BI?=
 =?us-ascii?Q?r7t/PO6R5s0+aIBr6DTI8VzvtiBsQuL5tZYlp3KciLTQbly04UiKs8y+K0i+?=
 =?us-ascii?Q?NViGn5jFaGX5b9lDW+6fV0MB9wKZDvEfr1JBk6K4MTpyhuIA86ExsajGf7QO?=
 =?us-ascii?Q?XdICyhB3IiLKUDYrUd3A0Nzyc/PDBF3Na4TOdo9yMRwoFioix7+5oopEl/oP?=
 =?us-ascii?Q?baRt12DAFLSs7Zv86D7P00+7JFeh3iOatWq/4lTTJurYZgQ+4BFjqUWbaU3s?=
 =?us-ascii?Q?VzQMqVkTeYMWsPd0NTGujdRfN9DE3lattRj/8D5sBMxoEeeAw4wjDdHuwvQU?=
 =?us-ascii?Q?xQHvfTGhMAb7gq/esPw1sg7kQIMg9w5INLS6XUBA86qptBgY6KYtPcic8OcI?=
 =?us-ascii?Q?HeQjW3RlbOlVeS2ogWIaCatG6FaMwRmQkxwG1+8ixE5YLyfpSbuZoTulqiE5?=
 =?us-ascii?Q?zq1AuD3ea1/8NLmmGMz0bW1QyG5DYL/WJrOKdubDz7QGcul5an1Xrg+lzHsH?=
 =?us-ascii?Q?NwBziWFW94EjU4t8HIpCezIB8qxeid/MuNAMR83rWBXtM0BuHLSg7FX7ihnX?=
 =?us-ascii?Q?lxHriO1BnxNGtYmGcVKkTkfTVCe4gL2ws0x6dnAd4s4AypzrtF5HPiUCC95r?=
 =?us-ascii?Q?R2vu+ivr+gsErVCxgqekzQ7IfnPxsrDqrWi4RjkYJq89lTZVbuSjz7L5Il2c?=
 =?us-ascii?Q?zEGsOoyOb/EU/JWnLY9Km9gbxmX+KmZButu0dKcT/qOcizCH7AsOyUTfxlUO?=
 =?us-ascii?Q?+AH3e7GJz8Wb0I4Gh7eI/CNhHCUK6qjsVFXkk0ocZ0yIItgsgBYNQjew0GGP?=
 =?us-ascii?Q?gW8ZfCcx8aRMSxiiaP0PQGjvcQgq5AB46WAQIoAvKh2f9xo8LLKhIjqN+npg?=
 =?us-ascii?Q?tBg/THTDYirlt3x9FQjB1Jl3L/9TUkmxAa3edhK4l8pKNNBO9cu/vQ3G6vwd?=
 =?us-ascii?Q?+4veRrebya5Y8J9krbnCYRrfCZAh73eULARkYTSUscSZ53L+Tnlsjv4aj6LN?=
 =?us-ascii?Q?R6K7kHJNLcbgLagCAKoH3COzDJYQDLH+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:11:13.5268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b2fb97-1f46-4a6e-9c00-08dcbc51cf58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

The fib_rule{4,6} tests verify the behavior of a given FIB rule selector
(e.g., dport, sport) by redirecting to a routing table with a default
route using a FIB rule with the given selector and checking that a route
lookup using the selector matches this default route.

Add negative tests to verify that a FIB rule is not hit when it should
not.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 87 +++++++++++++++----
 1 file changed, 69 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 9100dd4d0382..085e21ed9fc3 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -174,12 +174,17 @@ fib_rule6_test_match_n_redirect()
 {
 	local match="$1"
 	local getmatch="$2"
-	local description="$3"
+	local getnomatch="$3"
+	local description="$4"
+	local nomatch_description="$5"
 
 	$IP -6 rule add $match table $RTABLE
 	$IP -6 route get $GW_IP6 $getmatch | grep -q "table $RTABLE"
 	log_test $? 0 "rule6 check: $description"
 
+	$IP -6 route get $GW_IP6 $getnomatch 2>&1 | grep -q "table $RTABLE"
+	log_test $? 1 "rule6 check: $nomatch_description"
+
 	fib_rule6_del_by_pref "$match"
 	log_test $? 0 "rule6 del by pref: $description"
 }
@@ -201,6 +206,7 @@ fib_rule6_test_reject()
 fib_rule6_test()
 {
 	local ext_name=$1; shift
+	local getnomatch
 	local getmatch
 	local match
 	local cnt
@@ -212,10 +218,14 @@ fib_rule6_test()
 	$IP -6 route add table $RTABLE default via $GW_IP6 dev $DEV onlink
 
 	match="oif $DEV"
-	fib_rule6_test_match_n_redirect "$match" "$match" "oif redirect to table"
+	getnomatch="oif lo"
+	fib_rule6_test_match_n_redirect "$match" "$match" "$getnomatch" \
+		"oif redirect to table" "oif no redirect to table"
 
 	match="from $SRC_IP6 iif $DEV"
-	fib_rule6_test_match_n_redirect "$match" "$match" "iif redirect to table"
+	getnomatch="from $SRC_IP6 iif lo"
+	fib_rule6_test_match_n_redirect "$match" "$match" "$getnomatch" \
+		"iif redirect to table" "iif no redirect to table"
 
 	# Reject dsfield (tos) options which have ECN bits set
 	for cnt in $(seq 1 3); do
@@ -229,37 +239,52 @@ fib_rule6_test()
 		# Using option 'tos' instead of 'dsfield' as old iproute2
 		# versions don't support 'dsfield' in ip rule show.
 		getmatch="tos $cnt"
+		getnomatch="tos 0x20"
 		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
-						"$getmatch redirect to table"
+			"$getnomatch" "$getmatch redirect to table" \
+			"$getnomatch no redirect to table"
 	done
 
 	match="fwmark 0x64"
 	getmatch="mark 0x64"
-	fib_rule6_test_match_n_redirect "$match" "$getmatch" "fwmark redirect to table"
+	getnomatch="mark 0x63"
+	fib_rule6_test_match_n_redirect "$match" "$getmatch" "$getnomatch" \
+		"fwmark redirect to table" "fwmark no redirect to table"
 
 	fib_check_iproute_support "uidrange" "uid"
 	if [ $? -eq 0 ]; then
 		match="uidrange 100-100"
 		getmatch="uid 100"
-		fib_rule6_test_match_n_redirect "$match" "$getmatch" "uid redirect to table"
+		getnomatch="uid 101"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "uid redirect to table" \
+			"uid no redirect to table"
 	fi
 
 	fib_check_iproute_support "sport" "sport"
 	if [ $? -eq 0 ]; then
 		match="sport 666 dport 777"
-		fib_rule6_test_match_n_redirect "$match" "$match" "sport and dport redirect to table"
+		getnomatch="sport 667 dport 778"
+		fib_rule6_test_match_n_redirect "$match" "$match" \
+			"$getnomatch" "sport and dport redirect to table" \
+			"sport and dport no redirect to table"
 	fi
 
 	fib_check_iproute_support "ipproto" "ipproto"
 	if [ $? -eq 0 ]; then
 		match="ipproto tcp"
-		fib_rule6_test_match_n_redirect "$match" "$match" "ipproto match"
+		getnomatch="ipproto udp"
+		fib_rule6_test_match_n_redirect "$match" "$match" \
+			"$getnomatch" "ipproto tcp match" "ipproto udp no match"
 	fi
 
 	fib_check_iproute_support "ipproto" "ipproto"
 	if [ $? -eq 0 ]; then
 		match="ipproto ipv6-icmp"
-		fib_rule6_test_match_n_redirect "$match" "$match" "ipproto ipv6-icmp match"
+		getnomatch="ipproto tcp"
+		fib_rule6_test_match_n_redirect "$match" "$match" \
+			"$getnomatch" "ipproto ipv6-icmp match" \
+			"ipproto ipv6-tcp no match"
 	fi
 }
 
@@ -320,12 +345,17 @@ fib_rule4_test_match_n_redirect()
 {
 	local match="$1"
 	local getmatch="$2"
-	local description="$3"
+	local getnomatch="$3"
+	local description="$4"
+	local nomatch_description="$5"
 
 	$IP rule add $match table $RTABLE
 	$IP route get $GW_IP4 $getmatch | grep -q "table $RTABLE"
 	log_test $? 0 "rule4 check: $description"
 
+	$IP route get $GW_IP4 $getnomatch 2>&1 | grep -q "table $RTABLE"
+	log_test $? 1 "rule4 check: $nomatch_description"
+
 	fib_rule4_del_by_pref "$match"
 	log_test $? 0 "rule4 del by pref: $description"
 }
@@ -347,6 +377,7 @@ fib_rule4_test_reject()
 fib_rule4_test()
 {
 	local ext_name=$1; shift
+	local getnomatch
 	local getmatch
 	local match
 	local cnt
@@ -358,14 +389,18 @@ fib_rule4_test()
 	$IP route add table $RTABLE default via $GW_IP4 dev $DEV onlink
 
 	match="oif $DEV"
-	fib_rule4_test_match_n_redirect "$match" "$match" "oif redirect to table"
+	getnomatch="oif lo"
+	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
+		"oif redirect to table" "oif no redirect to table"
 
 	# need enable forwarding and disable rp_filter temporarily as all the
 	# addresses are in the same subnet and egress device == ingress device.
 	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=1
 	ip netns exec $testns sysctl -qw net.ipv4.conf.$DEV.rp_filter=0
 	match="from $SRC_IP iif $DEV"
-	fib_rule4_test_match_n_redirect "$match" "$match" "iif redirect to table"
+	getnomatch="from $SRC_IP iif lo"
+	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
+		"iif redirect to table" "iif no redirect to table"
 	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=0
 
 	# Reject dsfield (tos) options which have ECN bits set
@@ -380,37 +415,53 @@ fib_rule4_test()
 		# Using option 'tos' instead of 'dsfield' as old iproute2
 		# versions don't support 'dsfield' in ip rule show.
 		getmatch="tos $cnt"
+		getnomatch="tos 0x20"
 		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
-						"$getmatch redirect to table"
+			"$getnomatch" "$getmatch redirect to table" \
+			"$getnomatch no redirect to table"
 	done
 
 	match="fwmark 0x64"
 	getmatch="mark 0x64"
-	fib_rule4_test_match_n_redirect "$match" "$getmatch" "fwmark redirect to table"
+	getnomatch="mark 0x63"
+	fib_rule4_test_match_n_redirect "$match" "$getmatch" "$getnomatch" \
+		"fwmark redirect to table" "fwmark no redirect to table"
 
 	fib_check_iproute_support "uidrange" "uid"
 	if [ $? -eq 0 ]; then
 		match="uidrange 100-100"
 		getmatch="uid 100"
-		fib_rule4_test_match_n_redirect "$match" "$getmatch" "uid redirect to table"
+		getnomatch="uid 101"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "uid redirect to table" \
+			"uid no redirect to table"
 	fi
 
 	fib_check_iproute_support "sport" "sport"
 	if [ $? -eq 0 ]; then
 		match="sport 666 dport 777"
-		fib_rule4_test_match_n_redirect "$match" "$match" "sport and dport redirect to table"
+		getnomatch="sport 667 dport 778"
+		fib_rule4_test_match_n_redirect "$match" "$match" \
+			"$getnomatch" "sport and dport redirect to table" \
+			"sport and dport no redirect to table"
 	fi
 
 	fib_check_iproute_support "ipproto" "ipproto"
 	if [ $? -eq 0 ]; then
 		match="ipproto tcp"
-		fib_rule4_test_match_n_redirect "$match" "$match" "ipproto tcp match"
+		getnomatch="ipproto udp"
+		fib_rule4_test_match_n_redirect "$match" "$match" \
+			"$getnomatch" "ipproto tcp match" \
+			"ipproto udp no match"
 	fi
 
 	fib_check_iproute_support "ipproto" "ipproto"
 	if [ $? -eq 0 ]; then
 		match="ipproto icmp"
-		fib_rule4_test_match_n_redirect "$match" "$match" "ipproto icmp match"
+		getnomatch="ipproto tcp"
+		fib_rule4_test_match_n_redirect "$match" "$match" \
+			"$getnomatch" "ipproto icmp match" \
+			"ipproto tcp no match"
 	fi
 }
 
-- 
2.46.0


