Return-Path: <netdev+bounces-80731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0197880B93
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 07:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C066D1C22702
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A21E519;
	Wed, 20 Mar 2024 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RhS6op1l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168529D05
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917932; cv=fail; b=p/+8PkdFALACAb7f+qGO+kNjGsRap5Wl01hPabxjV5BVKBhAmFWWeE6SGFpOiRmLNuzmLJypk4wQSR/Gi25Sqz9Th8YI6r43DSZIYAi+W0oYeaV28fcFN9/xVO15QNRWH3mTXjYhX0SjusUz7MkUla6hrs/KuQq8Izj5BErJffs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917932; c=relaxed/simple;
	bh=09L1DZyAnNRlDOOeCUeoiQzUaRjXkDMNUR4H1RDHFN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfq0C5FY9JbwevIypJEZKOSU97YBhVviroK7hrKUlrib0uXatzVQ4siSLLUb2eup5VfPvJjd4COQViOnaIDkEme02dmt9t68rC+eJxa9iO/2c1vDb3iDdDEpz5CXhvOVW0z5VcU8iR1UV1ab4p+bCYx9ppYKbozaesXweSTLUno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RhS6op1l; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVhZ3lsuEvd5/jhZoGFIGUfJooXzoPHhPBcuhvd23M4IC/cY43JWprZBYBNoNItvVyQK8pLZiCOnSyOqMv1cv9Q1rEldIeDrR86Nae5eEJ//2DHIUXAaROJhqN+ihCBkpZAfEg6+RDkEMy4Yqr6lv5YKBnVFtT7Il1gEdgQsaXzd26RyBOqC9zYLWm2B14kAHrvavH597yeBzvPJiAUab9olPNlCLUzyi721HeRGLBuJsI1K+TZRkZREcus2O0jzXTJjW35FzsjWD3XyJ+FnG56aTYCheH5NQacCbagM8AoYzsrL2TUm+MaC5vsCQEQCQHvN/IAInsPVOHCaGf8uAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwthvZgqqgImhVruKfytOB8Lys7veEW/Lv8IErbP8dc=;
 b=e9QcMjriBXrGNCUJ024XK5ZkPCKnTmc2EAC4j5PezwM2V7iEl1D4cTuHxr58NXF6cmnBi7zEg90BQva3tgCSBLpV/PuwOzHbW1Jt87VPapFjGML29pSLjqz25FOcs9g2ICh0OnklTmmY556XsWJL4n/mAr2lo9fDO3cgwYOJFH+SMZYiCvJ5+08CNwm0rWQDUruc8kaKqYmkKwVPvsj7eAjAz3GUJGHn0+0e8LmpUf83Ee2mrLjmcr+WHyfPujYIDdnhxSr0LuLYcshtoI1b/V0ZEAroZlTdjXJDAYtPdnQJto1gVs9cK8vUNr7ocSTiwp+Y3C+9RJopV2SsAot8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwthvZgqqgImhVruKfytOB8Lys7veEW/Lv8IErbP8dc=;
 b=RhS6op1lC7RtEI+U5bnl1Yt1WQa1AEd1sbX7V2kxRCVlj4VXDbcL7orYUV0evHC65bX9dAAMM2HQXeVaXI/gl+E7uVf3uaYNTJiU+sVWb6hh8uXZYhc3Y7AQX6Ls7rlR/9JPPF4luGWn17PoVKShUBwkSQX34xG31Ae1usLak/a5MNmFWPT48Xow72YtDtV7e/oqzWYN8Z8Vt7o/SoqOIXumAzB5bs7kwtogP6MRN3NojmmxHZ3j97gtNkLnghvtKUIGITmsODghZG28QKLE3aIUxwPIb5+CavITnGza1Iz/E2eitk2f7wQ0xygAR9FH1noc1PzHBe2ewr4rK+o2nQ==
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:58:47 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::6b) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 06:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:58:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Mar
 2024 23:58:38 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 19 Mar 2024 23:58:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <amcohen@nvidia.com>, <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net] selftests: forwarding: Fix ping failure due to short timeout
Date: Wed, 20 Mar 2024 08:57:17 +0200
Message-ID: <20240320065717.4145325-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b62621-0729-447e-1d08-08dc48ab30b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LJiyv3P5ltE/oxyiSd9mV8PWs5/NgfzFG5MnN6ByJ17HPMGI8CY3NJ51sarOuKhOo9yRAwJx1BhcvaWYv2udIEm+d75ir2EgCt0ihz2XlrY+T/7B8Any6mD/YipUFu8Fio/unsXwjkO5J1t8srgJlcxd0Ty7rMMUHdY7+Cld8brQkDZF0VBk+jWXJYIO4XuaJZXpK0KrYFQ+WSdRbz8dlxsbK6yIIIFTM3HRQIkQQQQwYEuX9ZKyNfBbMQJibUXEOcW1zcV0yKZ0Ja64di6hWVz+UzThu/d4Kjb6C+j1aXP9oiRrQU46BCTtgKav6Gi6iWuCryYiZc5jdmoW9SJ+4gGiAxYu04bqbeXddZOExDv7a7fQ6y3qkStM1hcE4HakiZibpXj466/auDFDIAEBnQtnpRT9odIoYWXOPmhYcrTZ2BiTN4UiZagL0uSZu4didlBV7utzgYKdT3Cfaj7a4c9wycoC3v2jwJADvoq08ZmJGhiCWEYAnfxXxCqeH3bFB7v+ejgWEFVT4DV7Lj9mOpGrIU8fl6GFIeb1crIU1A0UQPnHHAKf5ncFVIAi0XFtZzVFY0pRaf91jA5B3t0zELpNTiSPdLWA+2G19FOv857slaiy1Pa8ORJ+OygzHgEKSo9ResZ7c89HHnuMEQovdxljYh9teyeF/K474JY0tyJMEYotSu/IxxvwBdSZx72VVcsVwF355foEipmQ3b3rn6zP/gEfOO25Ey9lF+Hfy6h95ob8KhWhP82EMazzLDIL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:58:47.1807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b62621-0729-447e-1d08-08dc48ab30b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

The tests send 100 pings in 0.1 second intervals and force a timeout of
11 seconds, which is borderline (especially on debug kernels), resulting
in random failures in netdev CI [1].

Fix by increasing the timeout to 20 seconds. It should not prolong the
test unless something is wrong, in which case the test will rightfully
fail.

[1]
 # selftests: net/forwarding: vxlan_bridge_1d_port_8472_ipv6.sh
 # INFO: Running tests with UDP port 8472
 # TEST: ping: local->local                                            [ OK ]
 # TEST: ping: local->remote 1                                         [FAIL]
 # Ping failed
 [...]

Fixes: b07e9957f220 ("selftests: forwarding: Add VxLAN tests with a VLAN-unaware bridge for IPv6")
Fixes: 728b35259e28 ("selftests: forwarding: Add VxLAN tests with a VLAN-aware bridge for IPv6")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/24a7051fdcd1f156c3704bca39e4b3c41dfc7c4b.camel@redhat.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh  | 4 ++--
 .../testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
index a0bb4524e1e9..a603f7b0a08f 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
@@ -354,7 +354,7 @@ __ping_ipv4()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome ARP noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 10 100
@@ -410,7 +410,7 @@ __ping_ipv6()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome neighbor discovery noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping6_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping6_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 100
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
index d880df89bc8b..e83fde79f40d 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
@@ -457,7 +457,7 @@ __ping_ipv4()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome ARP noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 10 100
@@ -522,7 +522,7 @@ __ping_ipv6()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome neighbor discovery noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping6_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping6_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 100
-- 
2.43.0


