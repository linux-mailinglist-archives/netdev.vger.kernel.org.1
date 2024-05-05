Return-Path: <netdev+bounces-93503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7233D8BC18F
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645151C20AFB
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9963A2D03D;
	Sun,  5 May 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2DmkRq0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181C1E48A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920890; cv=fail; b=ER5bYiJcEYma5Ti74PS/X6BP4ZEQkMU//dpuWjgDjrKF3k48my6FeKVvN2c0Ks0Ay/QzCJYZ2z4OKIFzbpbgeLeqrpP3du+rhdcNSk1h27cQnxVCThAZj9xrD5dN8EuWO54E0DfLko6IDEflRCUx/+oo+Mlv0QwqjdIcH0GOtsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920890; c=relaxed/simple;
	bh=OlkmrXTBMBUNo9xoqAQ/wDSQp2YwoKfyNUub1ZGCOH8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=toj3Smo8ODKdXngHORTlrYqYZQgpnVh6fdvhSz4u/PSOZmTArHr+KxGrxkk71a+2oVQGq2TrsHtYbvUTDjOMUeKHNc/UqxBs9VX/cbseP5kJM9m2T02li+BY2eq1n2n4nam7lx72UES9Am6jyROcqMRJw7s7euX3OA7Kw6kbYOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q2DmkRq0; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCIXTbc8u+fHG12aDkn1TKcR60xgNvLXHpO4gHIw/q8iMAttNTSRjZp5F360Z4U/FfazIT+4D/Z6tNfNF7VXkS3W+qV6Q0FgV8lLG40kyYDCUYMD0PIMxb1PJSWuCf67ve3JVPFHwxL36/VUAg1FuwFb+MXDCFtr9Ru9A9qpZhmLql5a6buTX1jUNqfOglVsfsKqpsxUUGVjD9gxqjjIsUDh9N0fjWDDnrCh4j/rLEjqx2uzVtalPKbuN36JrGYpTSX6ypoFrv+nFT75fM7hl2ezSBEjQ8zHptdHeprLtE8JuwrN3GyDjLEZF8CV6tcy7gGV5bXwqywvDBgBHTVBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DBlUU6r7IJ0ieUOqVgf4RGsQ2vIrvFZGh7LslDTGz8=;
 b=lC+81DeeSk54J3jTSq24RrSkvU/xV0E9mnCQmIR1Ik2MEd7+Uy8JnJIiLRSCZ4rwaWbAxS2xyQPvGbkJ+sQR/bsPOyW74tQZkGIsl1zfdhSwEwvM7WWpUEsEubXvHE9fyQtxO/+b8Fm9U9LAcs13uBMNgKgRypj3G78f94LgZVLhM+9VoBU3yekloPGZ+6gehDo5c1YKEKXk13b1DY2E7YJQ8u/W0aXzQ53o8IO/+xjsXUdy28oig8x9WcgT/VgGN/VkFWw8hP0zhdUTpFGJroIsbHJ+ttj8rEJffA8AfLeH+caXavP/UCxAs6cyC9kwbz67pfbN5ONxomcbmJTIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DBlUU6r7IJ0ieUOqVgf4RGsQ2vIrvFZGh7LslDTGz8=;
 b=q2DmkRq0ktfnaq3jej5/AJuoxQs1N0ZiGrnrFJJatBUreaJevIod+IimzWFYPd5On3LxECKRhIYCQE90oio70nvGAuy9UHAcJjxLDVKNSIohU7j6WAbqNo0W3ePKcxgm3ogLFSp6uxql49TPTWr79sKVQzghdKoxjsCCbxnFhp8sA9t9lcVGL3BQZzoChSLdp3KzqaoSB/RKEdUhVu5yiFUjWmXEXoILchq6mmGb6O/XqKLYNOzGfKgnwERIrAC5gAr6iSYsRZ2ew1HhJRfxiEFS7lS6NG6JxunE+rVDBDhiBUWqhsojizRSKamDDXsS735RQ1KJobOZc/euU7OX7w==
Received: from SA9PR13CA0151.namprd13.prod.outlook.com (2603:10b6:806:28::6)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 14:54:43 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::d6) by SA9PR13CA0151.outlook.office365.com
 (2603:10b6:806:28::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Sun, 5 May 2024 14:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Sun, 5 May 2024 14:54:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 5 May 2024
 07:54:40 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 5 May 2024 07:54:38 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net] selftests: test_bridge_neigh_suppress.sh: Try to stabilize test
Date: Sun, 5 May 2024 17:54:12 +0300
Message-ID: <20240505145412.1235257-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: d2002172-db2e-4670-fc8d-08dc6d134c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yqZTJ6MviFhOKS7O84SIXtdbFo6hQZU9KGuLHmliRjNw1fVvf32gk1Dw2C9?=
 =?us-ascii?Q?x22CKsjHHxMTC/76Tc/vpyyf+Ysoh6YE5GQFipb1UpRSy16bZfi890SQxd88?=
 =?us-ascii?Q?0xeTDjCT4blUA/bpRaripizV1qeIEuMsIYPnvEeXy6itqT8zHYq1mqd+Wd4f?=
 =?us-ascii?Q?aadzYHD0FWdph8x4MmZ2AN08aMpQL6GWcb1kTNQP++5Fo1OqvJQjvNhPyGHx?=
 =?us-ascii?Q?dV9Sg2t+c1/X8W8kYZW4zq/waq0qRvGaFI9VGvTD4+BJOzb4L+MtWeiQk5u0?=
 =?us-ascii?Q?Z5d1JhWXwL2daK1sb8zU0+YXhj2jEYJ1kQNfLSmG9ukbR4r+MhD1WDaTcKYc?=
 =?us-ascii?Q?MUccKTbVVMhzgV5fQLVwdhb+sxr2PgBJQmR+dAsXBYyLK/4nyBm2zNZdKfmm?=
 =?us-ascii?Q?p6xrp5xF9PEHlGUajngmIBlgLiTWfwNnBQaesuyspt7OxogPfWqAIEHgS9Hs?=
 =?us-ascii?Q?2C4jWY0iwytqsh5qYAaj0IUxBQOygGFZ84BvGWjJK4h5oU9YHfRnxCB2WUJJ?=
 =?us-ascii?Q?gG/hLxd76/21o5Aj33x8unD92chF9kdnqwKd6rELsszj/DI2z6ho2nvLkkJC?=
 =?us-ascii?Q?ytU42p1tg5kPnHuEF69S74qgenk1yAdiYBVWoOB36s9iupZakTO4BxNKUzCX?=
 =?us-ascii?Q?o3gQkekH1OtSXoYop8rXUs2AaOIj2OXWBKZeuvQdmtkap71utL7FJFvDDW57?=
 =?us-ascii?Q?+vn2ukU+FiMWirklnWU3YqM/K64sizGiRrLFHjaie7eUbe2Z4nDMlZsGVSkz?=
 =?us-ascii?Q?LYSslYs49iC2qej6ZAL5xumlzMQVxAqWGeoYl6eRxK7iullyOU6YVrB48Q3u?=
 =?us-ascii?Q?ysZZ+MEvEr6igR7QpQ2a8j9q0QdmjkcoULYsjpvYQOPnQIw2bBzIEK0ZL46a?=
 =?us-ascii?Q?mrnpY60t0prhUIld/TbhwGplI0QuQD/N0uGwiC29x6yDUew73oWLRr0/RsGv?=
 =?us-ascii?Q?NP8hqFhqn1sNmC/4gMQx2IVWIzY+i4YpZf5OmzTwG6XdNWoei2aOoq6OTUfW?=
 =?us-ascii?Q?QIqGVs4wTEUbnpkrwPvOSH+pT2L6f1sCjU0Hn6x8pdcE5nLA8bx79SySS7or?=
 =?us-ascii?Q?U2TOEULE43zXCgtE3Wa/aHddDXRSvmWLa0f3EmnBfov7mLBr5zMEaLrd2MrF?=
 =?us-ascii?Q?ETQoObVLTnluapu+DyNQPYAYMGAS5zvF4ANgnWWXM44RASIiuFFXtC8k24JG?=
 =?us-ascii?Q?dzNueSf9BgGj0bbY6OIYPD2LB5D+z14MSwCcxc5AdQilp3evIokfEhQHKzSd?=
 =?us-ascii?Q?K6yOZXjXzTFt9yZMPy68Jspnrjageu8LYk4XaafBwoP8VXAuG9WqCNuRddng?=
 =?us-ascii?Q?HKmbfD2al96UWjHkJMu9+5cIJ//uNu2+9mVzLm2WI2WTPjeLnwch0ibF4wTB?=
 =?us-ascii?Q?TwnMVK4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 14:54:43.0281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2002172-db2e-4670-fc8d-08dc6d134c4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619

The arping and ndisc6 test cases sometimes pass on non-debug kernels
[1], but fail on debug kernels [2] even when it is the same branch that
is being tested in the netdev CI.

These are the only test cases that are unstable and the only ones that
use a timeout. Therefore, my only theory is that the timeout is too
short although it is currently set to 5 seconds.

Try to stabilize these test cases by using a timeout of 20 seconds.

[1]
 # Per-port ARP suppression - VLAN 10
 # ----------------------------------
 # TEST: arping                                                        [ OK ]
 # TEST: ARP suppression                                               [ OK ]
 # TEST: "neigh_suppress" is on                                        [ OK ]
 # TEST: arping                                                        [ OK ]
 # TEST: ARP suppression                                               [ OK ]

[2]
 # Per-port ARP suppression - VLAN 10
 # ----------------------------------
 # TEST: arping                                                        [FAIL]
 # TEST: ARP suppression                                               [ OK ]
 # TEST: "neigh_suppress" is on                                        [ OK ]
 # TEST: arping                                                        [FAIL]
 # TEST: ARP suppression                                               [ OK ]

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240426074015.251854d4@kernel.org/
Fixes: 7648ac72dcd7 ("selftests: net: Add bridge neighbor suppression test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
I'm unable to reproduce these failures locally. Tried with both regular
and debug configs. Let's wait for the CI results and see if this patch
helps.
---
 .../net/test_bridge_neigh_suppress.sh         | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index 8533393a4f18..83d3e2286e22 100755
--- a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
+++ b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
@@ -310,7 +310,7 @@ neigh_suppress_arp_common()
 
 	# Initial state - check that ARP requests are not suppressed and that
 	# ARP replies are received.
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "ARP suppression"
@@ -321,7 +321,7 @@ neigh_suppress_arp_common()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
 	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "ARP suppression"
@@ -332,7 +332,7 @@ neigh_suppress_arp_common()
 	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
 	log_test $? 0 "FDB entry installation"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
 	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "ARP suppression"
@@ -342,7 +342,7 @@ neigh_suppress_arp_common()
 	run_cmd "ip -n $sw1 neigh replace $tip lladdr $h2_mac nud permanent dev br0.$vid"
 	log_test $? 0 "Neighbor entry installation"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
 	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "ARP suppression"
@@ -352,7 +352,7 @@ neigh_suppress_arp_common()
 	run_cmd "ip -n $h2 link set dev eth0.$vid down"
 	log_test $? 0 "H2 down"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
 	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "ARP suppression"
@@ -366,7 +366,7 @@ neigh_suppress_arp_common()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
 	tc_check_packets $sw1 "dev vx0 egress" 101 4
 	log_test $? 0 "ARP suppression"
@@ -413,7 +413,7 @@ neigh_suppress_ns_common()
 
 	# Initial state - check that NS messages are not suppressed and that ND
 	# messages are received.
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 20000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "NS suppression"
@@ -424,7 +424,7 @@ neigh_suppress_ns_common()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 20000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
 	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "NS suppression"
@@ -435,7 +435,7 @@ neigh_suppress_ns_common()
 	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
 	log_test $? 0 "FDB entry installation"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 20000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
 	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "NS suppression"
@@ -445,7 +445,7 @@ neigh_suppress_ns_common()
 	run_cmd "ip -n $sw1 neigh replace $daddr lladdr $h2_mac nud permanent dev br0.$vid"
 	log_test $? 0 "Neighbor entry installation"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 20000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
 	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "NS suppression"
@@ -455,7 +455,7 @@ neigh_suppress_ns_common()
 	run_cmd "ip -n $h2 link set dev eth0.$vid down"
 	log_test $? 0 "H2 down"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 20000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
 	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "NS suppression"
@@ -469,7 +469,7 @@ neigh_suppress_ns_common()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 20000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
 	tc_check_packets $sw1 "dev vx0 egress" 101 4
 	log_test $? 0 "NS suppression"
@@ -534,9 +534,9 @@ neigh_vlan_suppress_arp()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
 	log_test $? 0 "\"neigh_vlan_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -552,9 +552,9 @@ neigh_vlan_suppress_arp()
 	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid2)"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -568,9 +568,9 @@ neigh_vlan_suppress_arp()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -584,9 +584,9 @@ neigh_vlan_suppress_arp()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -600,9 +600,9 @@ neigh_vlan_suppress_arp()
 	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid1)"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 2
@@ -621,9 +621,9 @@ neigh_vlan_suppress_arp()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 20 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 2
@@ -665,9 +665,9 @@ neigh_vlan_suppress_ns()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
 	log_test $? 0 "\"neigh_vlan_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 20000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 20000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -683,9 +683,9 @@ neigh_vlan_suppress_ns()
 	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid2)"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 20000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 20000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -699,9 +699,9 @@ neigh_vlan_suppress_ns()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 20000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 20000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -715,9 +715,9 @@ neigh_vlan_suppress_ns()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 20000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 20000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
@@ -731,9 +731,9 @@ neigh_vlan_suppress_ns()
 	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid1)"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 20000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 20000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 2
@@ -752,9 +752,9 @@ neigh_vlan_suppress_ns()
 	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 20000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 20000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
 	tc_check_packets $sw1 "dev vx0 egress" 101 2
-- 
2.43.0


