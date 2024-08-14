Return-Path: <netdev+bounces-118442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F459519A5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF4D1F234D9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B01AE87A;
	Wed, 14 Aug 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYDHAd/0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36811AE875
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633876; cv=fail; b=cFcn4cNWVZqjJbpIZJlszBdxsWkjgAS0eZDpqReyKxfV3KCqz8Qno6rjIIhHTvBkKa44EB/Ka+d9GORO96gm2+4aUJSLAn5nQf7iRrR02TdxKUYYTPBqVNt8vVq2bcNkj0jkyRR+drGb6BCDQP5SFO4ZaRyGtFKLmVprlOTcvrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633876; c=relaxed/simple;
	bh=hOTqOTj3LBYACEUSpJmQEY+rnJlIjbWRM0lCRfBd+lY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPKdoe0WXEv50kW1IuyZ2H3kl8Nc5ZmiioNDb1B63gCRgwVv3TVTqClorRmFGiy14HMj+v4eShoEqNjL88GgR3KFH3VvHJ6B8jN0+g8Ih1/kcW2a5/AvwRSuRYMles6URWMuS2rvBHIryrUJeAelaZho7ukUQANOW1n0U5EStUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYDHAd/0; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWZmdzBO6r48TyBYdjX9SBwkJG3elquYBuQJwkxa6626QT8wnE4x/fnwjLAaerCJuDFDP8sF0349m2FOHahgp9e2V7ddfZbFM/DmI6qoVrbkvPh0Nv2vuN8hId7twfb/UM/CnZ+6WaaHjh7ECSVITU3JisTr5AhI/8YMgynXWdYNXtbgyxx3XOk1Cy+2iJL7vP+o+MOhlLYjD1jFDH5i4yuPMYOTEkapSmnRsXn9q+7+ywcKvsGdulZz4wHMqxI61CHUS0lC9avqnuANkoJs5dnS7CQ4MQOny6d5kxUANpUMworF/whsP/VPAbWNIFq5wRHwxOFHtm/VcScewPBqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nAGVvAM04wuxeiy4Wwqb8ScEAD8YXYsAdcmZBcJrBM=;
 b=zJVdoTGPwmWTTgcCtth1FyOveCS0e3BvUBtKn65a2d0911LDcMlLp+hhs3LkP8NV1ghbapDAHirl0Q2tO/68Jy+mzK2yX++onR4w3m6GO7HOsUxPCLT+9Un7sF65PedYntQL+V0uzvnCNJ/MtaD3HTzgkIIA+3xrRuZ4gZufgd/fln6jpp4hHgtN+fmHcufPT8P3LQ+v7bnenqCPxzGC/JLg13YsZYkb0Hn3SWeKsdsfubsHZTOMscaNUOkNp/EJiXZ2q/0mZ5rKHmeIt8tiPQlk1nJbC5Sp5vejHe5XVjT1lNR3soP8WtdMnBfr4cyB9FiI8Wk+5lG43v0DE1J90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nAGVvAM04wuxeiy4Wwqb8ScEAD8YXYsAdcmZBcJrBM=;
 b=tYDHAd/04655FIq6e7mWrc0gmBrdg08Yqmace15iILUWS5LkXi586U7eyAezf4qsGtpVTRfRtam+pRVao08ib29O2fKZvc9fBg6aimUIp47kqPMOIBMv1AvR3B6gdkXLSm3Rh2ylDeMmmPzOI+FdiObybbCmq6mRT+EWOn78u7ObkqE22mAVh9+rkmVoe+puK07T32B/021pS8x1PwCEFct1cXpG2UMfh2GqaRGRgV6g953jz9ccKHPX7dn33yNjAGKqoayb5VwYir2d9vRoOhb2lEHG60LcwMbE7H4EIl9qUAyx1Ho5CGrDvly8dNFA2ZAJVxxGaa6MW3mvjWJ6kQ==
Received: from PH7PR10CA0022.namprd10.prod.outlook.com (2603:10b6:510:23d::6)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 11:11:11 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::2d) by PH7PR10CA0022.outlook.office365.com
 (2603:10b6:510:23d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Wed, 14 Aug 2024 11:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:11:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:51 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:47 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/5] selftests: fib_rule_tests: Clarify test results
Date: Wed, 14 Aug 2024 14:10:02 +0300
Message-ID: <20240814111005.955359-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: b5901831-d195-42b2-751c-08dcbc51cdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	fhd4wwJtKDnKzYrOZB4IVDRBnRPGIiEP5f0DpZJApntRyEIEwuDxMQcwFv31iSroLu3/kqwCrRsmg3k5i/MAqItUeFJgtGy2wx0bZweK9cyXl4kyRacMBhNEeRhG1trC3BZoOOp+o9NcX3/AhyGAvaxYAD2GaC7OT1mS1995yFeQ9WVS3rD4nrBIT4NcIrzK8nafwJAwXWpNVpCF73mjtcxEODMZTpIqvopaeT0pSnzIve9EMedIFBdd72t+H1WkJU8f/vIetRkHEwaojTLSaAYT98AlrPXpWcGBvrb+h61y6QFfJSz1h9Z6X/cogz4JUfy5XumPyN4c52qllmAHSiIDDsBQPUWSQGvOj1MC8+ZgyI60MowxdhdRaPtKknllPPujpRzRP8eu0fFDru/hpnL0hfm8df3or2D413z+WcU3+LzXorB/Vx9ozVPZOFHjpmFxJnC+jrE4Ng/vtzBGyWBx8uIsFY36X3kI3B6QIUmaYWyLQ6R6uqpsvleAsk3BnYBC4AXhjkwOrDExGOCqzMI3NLhmxYHG5XhjQ5B+1V7Jqz7vnwLlB7czamAXMhBK7PYk/G3B5ZwaYgyk24mWbfXJnU6W4wNRYHjRFkJpEAGl0thzfqvvqz0PV5boIgMkvJnT33cqPn+VoPWisYNNFIWV7GHef1dPeoiNbbo6DwccjlDdleGhfyB2JLLL5OHMjj3V7e52igPR7Zjo+asbgm1q5hDblc/zZCxNNaR1/x8aTtQX4GlF0ujylsEBg1i3
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:11:10.9451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5901831-d195-42b2-751c-08dcbc51cdd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

Clarify the test results by grouping the output of test cases belonging
to the same test under a common title. This is consistent with the
output of fib_tests.sh.

Before:

 # ./fib_rule_tests.sh

     TEST: rule6 check: oif redirect to table                            [ OK ]

     TEST: rule6 del by pref: oif redirect to table                      [ OK ]
 [...]
     TEST: rule4 check: oif redirect to table                            [ OK ]

     TEST: rule4 del by pref: oif redirect to table                      [ OK ]
 [...]

 Tests passed: 116
 Tests failed:   0

After:

 # ./fib_rule_tests.sh

 IPv6 FIB rule tests
     TEST: rule6 check: oif redirect to table                            [ OK ]
     TEST: rule6 del by pref: oif redirect to table                      [ OK ]
 [...]

 IPv4 FIB rule tests
     TEST: rule4 check: oif redirect to table                            [ OK ]
     TEST: rule4 del by pref: oif redirect to table                      [ OK ]
 [...]

 Tests passed: 116
 Tests failed:   0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index c821d91b9ee8..9100dd4d0382 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -35,18 +35,13 @@ log_test()
 	local expected=$2
 	local msg="$3"
 
-	$IP rule show | grep -q l3mdev
-	if [ $? -eq 0 ]; then
-		msg="$msg (VRF)"
-	fi
-
 	if [ ${rc} -eq ${expected} ]; then
 		nsuccess=$((nsuccess+1))
-		printf "\n    TEST: %-60s  [ OK ]\n" "${msg}"
+		printf "    TEST: %-60s  [ OK ]\n" "${msg}"
 	else
 		ret=1
 		nfail=$((nfail+1))
-		printf "\n    TEST: %-60s  [FAIL]\n" "${msg}"
+		printf "    TEST: %-60s  [FAIL]\n" "${msg}"
 		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
 			echo
 			echo "hit enter to continue, 'q' to quit"
@@ -205,10 +200,14 @@ fib_rule6_test_reject()
 
 fib_rule6_test()
 {
+	local ext_name=$1; shift
 	local getmatch
 	local match
 	local cnt
 
+	echo
+	echo "IPv6 FIB rule tests $ext_name"
+
 	# setup the fib rule redirect route
 	$IP -6 route add table $RTABLE default via $GW_IP6 dev $DEV onlink
 
@@ -267,7 +266,7 @@ fib_rule6_test()
 fib_rule6_vrf_test()
 {
 	setup_vrf
-	fib_rule6_test
+	fib_rule6_test "- with VRF"
 	cleanup_vrf
 }
 
@@ -277,6 +276,9 @@ fib_rule6_connect_test()
 {
 	local dsfield
 
+	echo
+	echo "IPv6 FIB rule connect tests"
+
 	if ! check_nettest; then
 		echo "SKIP: Could not run test without nettest tool"
 		return
@@ -344,10 +346,14 @@ fib_rule4_test_reject()
 
 fib_rule4_test()
 {
+	local ext_name=$1; shift
 	local getmatch
 	local match
 	local cnt
 
+	echo
+	echo "IPv4 FIB rule tests $ext_name"
+
 	# setup the fib rule redirect route
 	$IP route add table $RTABLE default via $GW_IP4 dev $DEV onlink
 
@@ -411,7 +417,7 @@ fib_rule4_test()
 fib_rule4_vrf_test()
 {
 	setup_vrf
-	fib_rule4_test
+	fib_rule4_test "- with VRF"
 	cleanup_vrf
 }
 
@@ -421,6 +427,9 @@ fib_rule4_connect_test()
 {
 	local dsfield
 
+	echo
+	echo "IPv4 FIB rule connect tests"
+
 	if ! check_nettest; then
 		echo "SKIP: Could not run test without nettest tool"
 		return
-- 
2.46.0


