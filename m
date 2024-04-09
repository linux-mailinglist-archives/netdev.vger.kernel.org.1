Return-Path: <netdev+bounces-86083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BEE89D7A2
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8312AB20DC5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CD84D02;
	Tue,  9 Apr 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYvc3X+0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF78594E
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660960; cv=fail; b=URY0ig6R9Ml2A+3+ZxvX5T16F6WdALn0kDhSMSpqtIj2hwBUpdHzoJpfhbUGVXJCOPx1XPwc7+KvNbhxqDq1hFpM1x8NS5MUHbq9hOepgE+wkqT0gz4uThMI9Yph2oCYpIRzr0QTwYCiyWcO0AvzX3osXgXfOmn2/NN+TOsNQu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660960; c=relaxed/simple;
	bh=+DhS7CYkHkdMSOW5e0drI5RVEWLy18FKfidB0EERvjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D30I6a52yJRiVD6IH5U2F2MXbrKjkSwL8iSVTxGTj6PcUuLnY405JVY0ZuL7hzm7Qqbgs5JqdaxmFvw4AcVYxhPQQx6EAMfUEETn6mxRDepG0pTyppIVMfCQUtGu1TxkYG0A6Lh6H9b4zyDvYNfbmWABmnXv+Ti3QpREchJxXXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kYvc3X+0; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqPPvj5oaGHo9IcxbqQxFfAuVTTImTp0LW4M59t/h2p9yXZZcDdxllcaEGbl7ecy944VuIYBaDYcurW5nsnwoYCdNPiCz2kbJ73A7viXMfQ5jDTdA60Rizvf8BDiU7n8h+3wZGny+WBZMeCn9Mr8ePVqhGogT/wElGUCBfyvoXYdt2S112RsCZgIwVGUdz+oZYx0RQpiBImtUaDq6gkTnhRlAVUklfXHSXC51kiHCQ74R7Wcc9TEL2P4ad/HLiqVwbGUylZUS/Gr56Ke+36K57JsTrtkcVp8JUhRS8ZfYexFqHrA2HmGiR+wQQvjkb52k1D8dUNy0kP67vcKeoxLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRgTFggJbnBVVu6ZhJfO97/UwlHRlT/dBpb7Pps483o=;
 b=dSXHJggqXCVpwJELnwcIzERlJQ7ol/qf7nIUR0NHAZ8OR55sXVYJaNFXaAXz1aq1MnlB40IbkxloBs1ZFtAzfPudPRxfRw2QQ1eCUWcPvDNnesfRONX4g8iLOc1IUq65+2z8uGFxb/cnCgT0S6pBvmF6cDW9w+2O4Ivrc78hwMQvC7RiciQBkarTK+67+LrktfetspkcIJzR20stGWsQ0XagMRcaUlMcSDSZILm0sBP3JEJ9FfaCJcts3JKdOmekOnXtbDpHCUNhCZNji6iVCDSCvuMMdD8AZUkRXaf2tOUFH0ycnBF0XSSFc0mj6h2Tc3KitCNr16DYiiFw8qp6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRgTFggJbnBVVu6ZhJfO97/UwlHRlT/dBpb7Pps483o=;
 b=kYvc3X+03t6PLKqTAWDRw1FRc2H03SaBI7G6NZmbzgF6r8NfbKyPM/xh03ptCj4rPp4o8Y9fRr8eUIw87yIjNTeSDD3j5pvfskkbfkqlCqdlDZLeZlaf0GVYqwiGQzuN6RrmCk+hzjmu1kbYuR1AAASuH+uAISJWB2RuQ5sSimGSWzGHhaXzzYY9L81LrrnNgczBv/R7SUJq7Shle3un6WYgYuynCpnpo0ZmGyLTmXPdaZvo18GaGyDLZK7lQz6OP5Dd15wXNQ91rbXLVbf3clqGQfHwRpi2SRhRTXBhi/4tAhF6ZcB51a5l5u1cONb/2Teri/k3jk+WPqALIU3/iw==
Received: from CH2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:610:4e::38)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:09:16 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::cc) by CH2PR02CA0028.outlook.office365.com
 (2603:10b6:610:4e::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 11:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 11:09:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 04:08:55 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 9 Apr 2024 04:08:52 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@gmail.com>, <liuhangbin@gmail.com>,
	<gnault@redhat.com>, <ssuryaextr@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] selftests: fib_rule_tests: Add VRF tests
Date: Tue, 9 Apr 2024 14:08:16 +0300
Message-ID: <20240409110816.2508498-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: f4256739-420b-4b15-b18b-08dc58857e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+5wt+IWQBPteLVI3/5xqfTrihDAP0+h1GkgmXygPTKgGVoLobSOHpC05im17OzTJVFmCsskWcA2qaWtymQMj4s6BGploRkDLCGzS7I0X9cOIHuDGtfbltyZshGQ1rj1dZ0VEyhy1x4BKRpaMB/E3520sXJkSYv8JY6gqRhDdbCLCNjxtnR1gb+TNGa619ee2qup7N+lQBTcJx7bIEnKms3fb3ouIqbbW9Y2BushPgjsRW69IcDbcRFXCEITXN9lVSofcLN0AFDY0OfOV5SFN+dFAWwevqYaotR+rm7M5f0KaZBaqEWKoARBMZvS/gGAabyKtFPqzDdVqSYTmKoseM/meaFedZFoU5Vkanlzzkrm2tzwB9dTF18kV3iw/bAQNsDBBsj4/AGaYgRQSePdlXPSGzICqNZjdQYYWhmppxFjRxayNizEgdG6Eiybl1y0+MlPwbfSGC5MEL+Lork8/j2pGXbQdKghiLuriGW9RXUAr27CMTaPj+SGtMEMtidvviAkHEC+KaVMv8fqkLgDhmVS9VCcJ4s7G9w+LrJjbO9wLWordy+mP/JVQ868SCJKKBz3In5IavSU52jl7khsgqtFrtBpSdnNarRDwac0MPdd4plExBQO31CtTwlQyV5JVpCERmMX7XHh0ICyVEDMk9uyDVwh46/blAEVaOw14ELPdawwBk3iT3ASvAOte1s7JqEj6+Gjppdh5UuDvpTJH23irfO6cedkRXAukwPIdrIw+lp4Je2EOfJrbaFNcD0+g
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:09:15.4896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4256739-420b-4b15-b18b-08dc58857e89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

After commit 40867d74c374 ("net: Add l3mdev index to flow struct and
avoid oif reset for port devices") it is possible to configure FIB rules
that match on iif / oif being a l3mdev port. It was not possible before
as these parameters were reset to the ifindex of the l3mdev device
itself prior to the FIB rules lookup.

Add tests that cover this functionality as it does not seem to be
covered by existing ones and I am aware of at least one user that needs
this functionality in addition to the one mentioned in [1].

Reuse the existing FIB rules tests by simply configuring a VRF prior to
the test and removing it afterwards. Differentiate the output of the
non-VRF tests from the VRF tests by appending "(VRF)" to the test name
if a l3mdev FIB rule is present.

Verified that these tests do fail on kernel 5.15.y which does not
include the previously mentioned commit:

 # ./fib_rule_tests.sh -t fib_rule6_vrf
 [...]
     TEST: rule6 check: oif redirect to table (VRF)                      [FAIL]
 [...]
     TEST: rule6 check: iif redirect to table (VRF)                      [FAIL]

 # ./fib_rule_tests.sh -t fib_rule4_vrf
 [...]
     TEST: rule4 check: oif redirect to table (VRF)                      [FAIL]
 [...]
     TEST: rule4 check: iif redirect to table (VRF)                      [FAIL]

[1] https://lore.kernel.org/netdev/20200922131122.GB1601@ICIPI.localdomain/

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 46 +++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 51157a5559b7..7c01f58a20de 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -9,6 +9,7 @@ PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
 
 RTABLE=100
 RTABLE_PEER=101
+RTABLE_VRF=102
 GW_IP4=192.51.100.2
 SRC_IP=192.51.100.3
 GW_IP6=2001:db8:1::2
@@ -17,7 +18,14 @@ SRC_IP6=2001:db8:1::3
 DEV_ADDR=192.51.100.1
 DEV_ADDR6=2001:db8:1::1
 DEV=dummy0
-TESTS="fib_rule6 fib_rule4 fib_rule6_connect fib_rule4_connect"
+TESTS="
+	fib_rule6
+	fib_rule4
+	fib_rule6_connect
+	fib_rule4_connect
+	fib_rule6_vrf
+	fib_rule4_vrf
+"
 
 SELFTEST_PATH=""
 
@@ -27,13 +35,18 @@ log_test()
 	local expected=$2
 	local msg="$3"
 
+	$IP rule show | grep -q l3mdev
+	if [ $? -eq 0 ]; then
+		msg="$msg (VRF)"
+	fi
+
 	if [ ${rc} -eq ${expected} ]; then
 		nsuccess=$((nsuccess+1))
-		printf "\n    TEST: %-50s  [ OK ]\n" "${msg}"
+		printf "\n    TEST: %-60s  [ OK ]\n" "${msg}"
 	else
 		ret=1
 		nfail=$((nfail+1))
-		printf "\n    TEST: %-50s  [FAIL]\n" "${msg}"
+		printf "\n    TEST: %-60s  [FAIL]\n" "${msg}"
 		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
 			echo
 			echo "hit enter to continue, 'q' to quit"
@@ -130,6 +143,17 @@ cleanup_peer()
 	ip netns del $peerns
 }
 
+setup_vrf()
+{
+	$IP link add name vrf0 up type vrf table $RTABLE_VRF
+	$IP link set dev $DEV master vrf0
+}
+
+cleanup_vrf()
+{
+	$IP link del dev vrf0
+}
+
 fib_check_iproute_support()
 {
 	ip rule help 2>&1 | grep -q $1
@@ -248,6 +272,13 @@ fib_rule6_test()
 	fi
 }
 
+fib_rule6_vrf_test()
+{
+	setup_vrf
+	fib_rule6_test
+	cleanup_vrf
+}
+
 # Verify that the IPV6_TCLASS option of UDPv6 and TCPv6 sockets is properly
 # taken into account when connecting the socket and when sending packets.
 fib_rule6_connect_test()
@@ -385,6 +416,13 @@ fib_rule4_test()
 	fi
 }
 
+fib_rule4_vrf_test()
+{
+	setup_vrf
+	fib_rule4_test
+	cleanup_vrf
+}
+
 # Verify that the IP_TOS option of UDPv4 and TCPv4 sockets is properly taken
 # into account when connecting the socket and when sending packets.
 fib_rule4_connect_test()
@@ -467,6 +505,8 @@ do
 	fib_rule4_test|fib_rule4)		fib_rule4_test;;
 	fib_rule6_connect_test|fib_rule6_connect)	fib_rule6_connect_test;;
 	fib_rule4_connect_test|fib_rule4_connect)	fib_rule4_connect_test;;
+	fib_rule6_vrf_test|fib_rule6_vrf)	fib_rule6_vrf_test;;
+	fib_rule4_vrf_test|fib_rule4_vrf)	fib_rule4_vrf_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 
-- 
2.43.0


