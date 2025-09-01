Return-Path: <netdev+bounces-218656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB7B3DC75
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698BA3BFE14
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E22F9993;
	Mon,  1 Sep 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="piEMcilm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E32F83D8;
	Mon,  1 Sep 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715586; cv=fail; b=LW/o+5HJwj1KuMQ3EjnVFZy9INQmPIkkkAZN8oYiNYETtMpcJOdSIpPXeNnTuaH8K2480PVrMhrhand9Eg8SZVp6ShV8IYpFRlwHmz5+0tQCTTlPtTgC2T5rzuXNQ8Vsyap2lesQshXSy8bRo/ClZRc7RRY3myZMfL0Qz4AUq50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715586; c=relaxed/simple;
	bh=THeQWeHsfqGXNCffkF/BIS2Fh3RRFQ0IKAWqDvmPnfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6ewsGQNUyE/ccKTlAfNKAJZP5kWNwTMcOktBr1pS7oal4vpAKcNN4qkqSrqdgwuN+JbX1yX/7YLNan/zEzDeMgk6a2U1gUCWBrj/iOG+cK0VLJqGHGhw2aLNaKBhEKUUJBxxgsZ5XmFdNEOD+phPj4hHrBH127pOfKn5euMvio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=piEMcilm; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S27BR3DjzdGp0Tdozp9vh2++yJdgpryHBNSy4sntT8oDX9BLwy8NdVteliwCkLXUXSgwscF0hdtG4KMqp0/UuvLiLjiZ7lH6cL8gHuJK37G+MZgT7YyHsk70Zz5UCCLVNt+8MpypAaCTdxElFKtX6uuAka8KHFcAS9YF/Lv9wajoi1Be/hPcTkqS2HCIDXZ976ao/6lWPHYWlW+XvwRVj0pCNQGNyjKo7zgnaptEcfelWmm8FwL8b0tFs8Hb2aXKtZ6Kn6VNcSWE971HhdcXvhkBFoz1PLEo8OxooYmj3Dddu5gYzXHKNlOqRBmvBUcrtx7wEqLn33IW3w5Zcl2pDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVTHYsD3q/WrgK122FFxe+Z11Wwpsl7J2h6FckQ/Gnc=;
 b=DcNhgGpCLSah/iVzc2vEX/uz10AhbA/VBN4RQ5hdssTtRFB5r3ioFBLib2dM4SssvL2gujJlrYYmhnezyJe0OOJpS12men9zBpmUG6ISp2Pdl3l/Jjwn5nublGuyZUdmDwv5gYY6YoMiuRVi55oY0PBZrX0jPcV9oc2BiONfOtRddO10crO/EbH8gWyyOR+hO73rnvHPp1g5h0GpZLosK1QLuPkEHpETUfelCK3xpXj7Je6vcue9XjnLKhkywQqvaM/xEVA7jhwLcG9n9TJGKodbtUD5JNeNYzMmEuuYp3lSTLygQoCaAV56ssiz1ukx9g1pgd8nJungMjh+qpTr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVTHYsD3q/WrgK122FFxe+Z11Wwpsl7J2h6FckQ/Gnc=;
 b=piEMcilmgt/9dliUeyGEND40NTVgRWUdXe1N3KWFFsO7JAZNerSv0yAnjD1rhJvWOJcJlVh9a5VW35xEqiK4LHy7HQhmdlcS7+RyJuqVVaa5GoBxX534/0Sg+u20Jvdru8DYzGJBMNKYcS5W+nbDXDMZ/LOOVXj6c9Yscafflz/93lZqIrqi7QiWFKKUoPLy3LexxT/4bV66P8Loh95hZ1U0ELdTMp9OILUumiY3u/vZvjTK/2nIOI0lWrKJZEieTCkt6fS6AOk57UKKLXOyXcViNxEtQla1heVH/364yLlOqxTmXECANA646F7GVTorbRjDa+GYdqgBvtBhA3iW8A==
Received: from PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::18)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 08:32:59 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::d) by PH7P221CA0064.outlook.office365.com
 (2603:10b6:510:328::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 08:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Mon, 1 Sep 2025 08:32:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:38 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:35 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/8] selftests: traceroute: Return correct value on failure
Date: Mon, 1 Sep 2025 11:30:23 +0300
Message-ID: <20250901083027.183468-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: c546c0e3-e121-482f-0b43-08dde9322839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tskPMUaXEFfqUKQH3OEwXRv+XBDr47nWXf+ed+ttBhaz73RcZLyFZP2glB8+?=
 =?us-ascii?Q?2v32HNo8vL8ZogLCRzlmPvdBjdKGiUDbBOxal4iVkfaBHEy63tSGKH8/wLcr?=
 =?us-ascii?Q?3JSTMqinuWZLfNXKJaEqlTvEJFw5mdr+wqojXJAvKQvRhoQqouCO9nx9RQ8s?=
 =?us-ascii?Q?QNmjsCVq8y19zEEOq5ttk+QtmUluVzuiKD0cgUhnoC7hrzXB+w8IUNzgkqXf?=
 =?us-ascii?Q?s8cDHykP+aBjqF5Rbe7WcjNJY5Ou9M4iqCOrMwzers+y/8nC2OQtfGwvSlXE?=
 =?us-ascii?Q?g4DCebjaijTvktSUM2olYIgcyZTjkn/q5En8UW2FyoZOWXhSIdwaSRqHWXQl?=
 =?us-ascii?Q?Idqsg8GB5SH0Co+us5XDTGgjrZRlvVSzRHSM8BCk1MuTe7chQAbY5bPPTf1V?=
 =?us-ascii?Q?BA2ZzSQ657Gd5q+WmIybFcm3dYTyYGxmc9cejqFnAMJaXC+V41ldJNX3Wrcm?=
 =?us-ascii?Q?DgZmUNLrnewciDRpSnM154JHuPy+CuIBP19H+rW2xaaEXX+bLMaLaNERHEG4?=
 =?us-ascii?Q?HP7uprBuYDeWzaBAQO9G/AjYK6kIUuh4tyr4dBk5PxOA92bzILxxugg1iK4i?=
 =?us-ascii?Q?YEf2sauPb4s2TbJKuQYWTZlA3vZFONsm7HO/8Q1mJUSuoS2iVAb4jrHWlfcf?=
 =?us-ascii?Q?nH78WH2Pul/Efzjo++HWCqyi0epyQPbIH5K1EBTM68zGwg3E6sXzvtVXP9bN?=
 =?us-ascii?Q?WqSGjXrzW0EAm4UY4KTm1CxFJoVIjHf3qz4zTRhn5qS/pgYBlVBMAzw3Ktiw?=
 =?us-ascii?Q?pJVzW82kQGuV6HkiXttSTWKaKMG/FT5MXcFERPvAP2NHc6iFXPHHsK4RBO8t?=
 =?us-ascii?Q?MjZc5NJx4W4zRLM2wYGvn2QpjHYcSEwjM3po8rFwXCa4hapvZnG3GsiC27l+?=
 =?us-ascii?Q?J8yyCd0QjomsQghKK7nFfdcsDPv+oLTj8KwuSoCTLPjzhx986yUriKGayFt+?=
 =?us-ascii?Q?bd+M0db1yZoSOSovQTXfqM4evKnj8gWgrocshBi+OT1uLmfj7nlJkoAnPYk+?=
 =?us-ascii?Q?wHau6XcR/orvKQP1uV8QiT2MZNcxUghzzDqN9FxK4wv3miAF4oJFs8OCf4h1?=
 =?us-ascii?Q?sPMWlxSDutyBSzEfkNafDQOQFHxyYOZkpSqkGJYwoemzAx8ZyVwROUMLs5Ys?=
 =?us-ascii?Q?iDX/IxSg3A73S3QUXVfnUvfHacOaqg6RvOaYV/OvbLp0Whnhjdurw1c2iRR8?=
 =?us-ascii?Q?M8WR9hGSXXY0dMXmD08liuO3bY9Wll5tBs7Qw/KsPKn+s0x8gc/vv0itCoMQ?=
 =?us-ascii?Q?Y8q7LkmStvLfyATB0J/O0n+qw8i+1E3uul0R541bZQ/udLi53wW37sLLjtGE?=
 =?us-ascii?Q?vjpPWFIobn/dgMDikQdWcR6tNysN25rY91BBd0vRIe90UKDUXenMK95Kn+Tf?=
 =?us-ascii?Q?ZL73QLIr1P3+Jhb9elSUyFL3mGmEEJZP9tEHBBrHvp38qkITFk5Gl94A2U70?=
 =?us-ascii?Q?5H5bTzzOZ1m4tDa3CxSr1aJ/innChBFvBeFGGUy1W2RVO8KCOyq8QPZHB6Nr?=
 =?us-ascii?Q?1tqgJxeLidnC6mKM9bCboXpQfriE+PLPjZDD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:32:58.7682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c546c0e3-e121-482f-0b43-08dde9322839
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074

The test always returns success even if some tests were modified to
fail. Fix by converting the test to use the appropriate library
functions instead of using its own functions.

Before:

 # ./traceroute.sh
 TEST: IPV6 traceroute                                               [FAIL]
 TEST: IPV4 traceroute                                               [ OK ]

 Tests passed:   1
 Tests failed:   1
 $ echo $?
 0

After:

 # ./traceroute.sh
 TEST: IPv6 traceroute                                               [FAIL]
         traceroute6 did not return 2000:102::2
 TEST: IPv4 traceroute                                               [ OK ]
 $ echo $?
 1

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 38 ++++++-----------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 282f14760940..46cb37e124ce 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -10,28 +10,6 @@ PAUSE_ON_FAIL=no
 
 ################################################################################
 #
-log_test()
-{
-	local rc=$1
-	local expected=$2
-	local msg="$3"
-
-	if [ ${rc} -eq ${expected} ]; then
-		printf "TEST: %-60s  [ OK ]\n" "${msg}"
-		nsuccess=$((nsuccess+1))
-	else
-		ret=1
-		nfail=$((nfail+1))
-		printf "TEST: %-60s  [FAIL]\n" "${msg}"
-		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
-			echo
-			echo "hit enter to continue, 'q' to quit"
-			read a
-			[ "$a" = "q" ] && exit 1
-		fi
-	fi
-}
-
 run_cmd()
 {
 	local ns
@@ -210,9 +188,12 @@ run_traceroute6()
 
 	setup_traceroute6
 
+	RET=0
+
 	# traceroute6 host-2 from host-1 (expects 2000:102::2)
 	run_cmd $h1 "traceroute6 2000:103::4 | grep -q 2000:102::2"
-	log_test $? 0 "IPV6 traceroute"
+	check_err $? "traceroute6 did not return 2000:102::2"
+	log_test "IPv6 traceroute"
 
 	cleanup_traceroute6
 }
@@ -275,9 +256,12 @@ run_traceroute()
 
 	setup_traceroute
 
+	RET=0
+
 	# traceroute host-2 from host-1 (expects 1.0.1.1). Takes a while.
 	run_cmd $h1 "traceroute 1.0.2.4 | grep -q 1.0.1.1"
-	log_test $? 0 "IPV4 traceroute"
+	check_err $? "traceroute did not return 1.0.1.1"
+	log_test "IPv4 traceroute"
 
 	cleanup_traceroute
 }
@@ -294,9 +278,6 @@ run_tests()
 ################################################################################
 # main
 
-declare -i nfail=0
-declare -i nsuccess=0
-
 while getopts :pv o
 do
 	case $o in
@@ -308,5 +289,4 @@ done
 
 run_tests
 
-printf "\nTests passed: %3d\n" ${nsuccess}
-printf "Tests failed: %3d\n"   ${nfail}
+exit "${EXIT_STATUS}"
-- 
2.51.0


