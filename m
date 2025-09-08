Return-Path: <netdev+bounces-220719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B59B48566
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F388189DD40
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255242E8DF4;
	Mon,  8 Sep 2025 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOgHyRy3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAE2E7F22;
	Mon,  8 Sep 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316921; cv=fail; b=LL7GMcXmhgP+NniqBP9Kz2zV/iE/uw5yJ3NvsSHyUpNB7w56HlfQZi+J8k3y1e6Z+Xz00wd7J7AYu1T+XYMrvykF0ZUm2RWDBgUZkj1nEh0lrODH6OITilkfSASzJNYM9cptWJ39R6j4W/s3JS54fdhoKFITzIKM+0SyGkziTxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316921; c=relaxed/simple;
	bh=3u//c1qdlA58//JR2VWPMOJUZ++Iy2U5yZdYboCuxZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT+S8cNu98jIjjb3wUv1swECRUvzSYvMFJl2cX4mO6wME9ty40Z0AYdgWTHsb9ghJkyDUglxteB94J6ZOuTLxOyJYW1cNd+PXx+hZpE2SlLtuB1iS+nn1IArcXs99oqrCiYNuEhycrNWv9NQGGlSDcP36oe0oL84oQHT6Vb4vgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOgHyRy3; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL4yROpKidHBdnOsXeBPC4jgTss+Tbgi9DtqWLrajBUnAbtfpoaeO7R2pkFz42hTMcqblUHdVL2sI0zw7StclSRgxgv5PGsiha8Yr8THC+A/cZbGLzGx6ebLWWpya3w4omGxns6Q3uIclRBgYVBXRoIMRA5xbDzsaYzuW73YdaCRQ2+Dhe9v+Pi4XC8b3vFPqVlEYrt4IK4mQ0WiEoXIzz6jE7OlmiMgOTLCOP0ZFoK2EBExMXYR0Ldnjfsqr9KiTO8fvoW6earwIkKgmJ6otHZS80DgXGt3PYNFJVkNu+y0/ahAEloe8Z7Z+ohaGBrlBCCcnGx1GsctXR1506QA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mAAmTrsGBrkNlrbZJkCBxMP0aOmbaH396+COEqX+h4=;
 b=omMAiMQRd3bA1topRIDJFe5VhHCv9dV5ElOWLtvRFHxbwnkLSZ0wMnWNOpY5kW17oVYkMKQU0tsIxSeBz0gNK1P52xuh4L0TUHIZ8OITo+4malEdyAcs32zOEos5jVMOYZL7AJxKbQfseeiR9qxsF7g6yVhsjtBIWs36kBLUJ2nDjXc1saelqIoaXzor7rrtoki1RviizoDZFcXkVPJQr9k7PfQA/sTrqBV3iBQuoUUPC1t2NonpOc1L9wpNGmn+/L47IaQN6jLx3fca8nQxoOI8HnGE0f0RETQaP1rC3hr2j4eYUcvY1pRY9i5NBt6onnY4h7u00mA6oxCon10wfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mAAmTrsGBrkNlrbZJkCBxMP0aOmbaH396+COEqX+h4=;
 b=FOgHyRy3GrskW1APa71DYBUyvSKXTKSi2TxvxGe8rkpP0+SBXIcdaM0mnhlkFfH1VzmsGhSa+HjA/D+UvwbU+y2iMYl5JyEeDzAQWsbZSbt09A6xal6FK+41SoXKXLkGZQ2YLhIg1DO0bWww7I1tLNmiyiVZYMMnz5KPAtv60+PhRPv7RB85FxiLymJBpXuAmVeNGU57i+Eb81S98Mu0hdEaulUDSkpzMS5bFo05tqk6MxeuHxRJxAomIuwplmR2AmqNEuNJ0ltLLlu/a1qEcS2Y7/8ijwxyXgRy/CqewecKma4TrHyLJM5dg50xS78UCmUBhjSB6jgn4n/YeSuaQA==
Received: from CH2PR10CA0021.namprd10.prod.outlook.com (2603:10b6:610:4c::31)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:35:14 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::17) by CH2PR10CA0021.outlook.office365.com
 (2603:10b6:610:4c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:46 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 4/8] selftests: traceroute: Return correct value on failure
Date: Mon, 8 Sep 2025 10:32:34 +0300
Message-ID: <20250908073238.119240-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c52c397-c87c-4f94-6a2e-08ddeeaa3fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qSSwRtAjW467KestDyPT9Bjsczwu51uZY1KTRmlUn+LWCWkg4gm/M5PxDOz?=
 =?us-ascii?Q?X7AP4tAzUeN9/m0J0k2HRuICpe2p4Vt3kjeK8juDd3im7c9et0qfFVr6FL6B?=
 =?us-ascii?Q?yvFp1BG58JsAnLquoXhpt5WiZQXIk7d/Xsl3pcG9brQGBJKEJ8hDUAikVWOK?=
 =?us-ascii?Q?T8g3aHSA32CWHWPZkiHFAQIiTZxNeHJLeBYIiFBaQjwx0Ds1RnLWvnatr9XD?=
 =?us-ascii?Q?N/p1J73JE1V3B+ISrNaqTJxtJzj2+TMTclIbdSSYNJegfcWVZ039FVJxH0rd?=
 =?us-ascii?Q?Ra2RDuI95bpBfagR5XiPvQI/+rqPReogn6gNIkq+2PvlX6JvRrti17pS/u/S?=
 =?us-ascii?Q?chRwKu+or/Y6Srx++JMUXzC7P1KXuRCXMxsu6E6eGX/deJzr6VO1jk1ZViTR?=
 =?us-ascii?Q?HxQqhCmztwKEs+hXQuEXg0JJvRwg9z3XlWRupbMD7HbZDpQPr+a8Yaj0hMVp?=
 =?us-ascii?Q?kLtZunMB//dVEBowJs1aJPPnWJgXfqb0I9WfkLJHpe4h+kx12Zhezi6UVx2c?=
 =?us-ascii?Q?wz/TyUqRmzsqtbW81vH3ApLVLkDfzPSQPzwQtGx19T7apKk37OWw8LMJ6Bdo?=
 =?us-ascii?Q?rWA51Cg/tbPHQbZAlaRzikhYMrIlKbm+VacvfCDVDkOXjDgZ8nWOURuMqQQM?=
 =?us-ascii?Q?8D0PVWSHm2aATTFT6KI7dsuScQKoC+1VukHUN1uYh2jsKxT9Auwkrt3fNlCU?=
 =?us-ascii?Q?EwCZ+DgaXGiIdhR+5Tyl9QEHy8NslpN5HeESfkh2knkwcMHyq/Ro3mhJVoNR?=
 =?us-ascii?Q?24AOvG/95rGJMWX7JbTKrVNS3Jm2iogGuSNABumBAmsPAPTDyTCldqt6GRWU?=
 =?us-ascii?Q?2gcOjJGGk6PzDJ+HjgCvATTOCe3TJiYXjM1YbwtTzDFDw4ZneLxZeNmSPj+P?=
 =?us-ascii?Q?8NZBuhwrdGgbn0sXVCe2qLefvcxvLg+3JYuzJOtrwzrCBixjhrgJvtc+AhHJ?=
 =?us-ascii?Q?LnrIfMbBFft5Niq6/wNIEmPyZbKrhgWUh57+rszZlw+Akr0jUOgyrNiAzmwS?=
 =?us-ascii?Q?P5I+yhpMyneEgXV/l0OFgv4ViopMQJjh7c3mMqocWtoLqYcClvb/mqeIG8Ge?=
 =?us-ascii?Q?DAjlTHKWs155lhaFSOUfXEYFoITq4EpYCMlAlmc7aIfMN0uc43Squ2yiizTO?=
 =?us-ascii?Q?eqYh+dnVtkpS8/Md0nJ0FAUzJiULnNC9ZvAbKAjsJ2zm5I6vgnTCjrAQmTMD?=
 =?us-ascii?Q?p79gwNvBkCgcUCYJiZFo1g3V+eAEH6S7yf46fHMzJwCgnWmCK/YpUZIEPZbh?=
 =?us-ascii?Q?XKS0fiyPtShbI3e5zs+T4tdhonanvUScZxh6JIJ/j85GOTjNd2qHC8LGodSD?=
 =?us-ascii?Q?clqjaFb2egtG1ADO0CO6gfooIiwRdE9OBKKbTqgR700EgL+BKbUMZrQB3wP2?=
 =?us-ascii?Q?/cLkZoLhrh0rs1dA/w+wdADMnme7TU6fHmQ1ddzE8quux7LQ2uNfvpi2753h?=
 =?us-ascii?Q?5dgGxsiKxDaDCJTDW9MVzfz3J2goCHBOMF4XjcOhQ+x8bHmdCsZ6VVKDTiNH?=
 =?us-ascii?Q?/sqZtJqSBr4/pXZ6m+6/RxkSDm+seoT3a84f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:13.5958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c52c397-c87c-4f94-6a2e-08ddeeaa3fce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0

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
Reviewed-by: David Ahern <dsahern@kernel.org>
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


