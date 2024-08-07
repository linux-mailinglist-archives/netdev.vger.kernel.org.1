Return-Path: <netdev+bounces-116511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518ED94A9B7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756EF1C21179
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ECC76046;
	Wed,  7 Aug 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qN8kIGKr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD37D412
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040107; cv=fail; b=JjIpYHNkxTk3b1v76RrUOiZGibJt5xx229e+8SkUZ7VdizqN6n40kN1wqFyBCNDNUXsJCF0/uKWEwRzZn8QyKscKXyTKE4YBP6KbJUKZarA0XN9ZtcDmx6Ttk1KO9fwlot9ug14G686NJqvdwRMVSbEWtuji66/HA0bfPsg7NKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040107; c=relaxed/simple;
	bh=FcAsofi4kv3owa5vQ6USmdMTJZjL3W4sohtdDm0s084=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3RpOR8j+iwM06OwBMZyRQyHdUo4dm8axiRloTYYSFFRwfV1V9wQwdznAhsOFuGW7ArI9tnlgXMXT67nvaP9JrbKI/ZL29/aDQaZXg68xFE1y7ZFJqdWozG0wFeLKFD/6WHSx/qf+Zx0LInJsUzMrEaMxFbeOCSyohdX2uUvtjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qN8kIGKr; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAAcvlTOz29QDdh1D/2RyXRRlOlb1efOZMoYS4/GBF/PEjkp9grPRRVDjVb26rNU8y0x1HNLdW4pPpAtNFQh0rfjME6ngcdfuWfUtrEjT2anMEOZZddBinyE/+YHEA0A5nKwnvozifxM1pqpXpVWKgztNP5P7CdoQc9yFAhf0DdWjSO3m/PBjh8L4ric28GH2/nGS7pGCk2C7BTOQbkumTx61Tahc9FdX2UsLWPJQIZrdXtEbS9EZRILzHlUIKk62jL2+j85mee3n82nhLmujJMWL+4PpUaUp5YJvFIIFcSEziaga8r/PoXF8uwy+sPmSr+hqf4wOiBnNKZOYk6GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoPrUywe4OwnFZY7KSNlJ89Mi13JdppNjirAIzKgFJk=;
 b=BjFk8xXtBn7Wz+fYbi6cgpkv+7Tz4gZPRv7ABkioWZnHqPXqItvUBkAow2QSghMB5IJzPgGJC0XioNN+WfdODBHFht6O2bpTo40UoaH/VdGzcB65DjNnQmoXrsVEA0ymMeB8541G16PzQsvFfT1iNzEstYhn2QIN/pSJmHOc+16FtEve3jvc6c+nTGWq1FQlwZx964s+3IlelS2Fk1oKt3wmyW68hbKlDhji77EDGeeg+kwNoEZCX366zvkgu1O3OyTCM11QoBC0ZQqdS8rRRzwC2ID48DeE9cdx82Wd23G7dh65q8lqrWXsxVQMwAN49/8itz9n3sFAbEOuUkMsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoPrUywe4OwnFZY7KSNlJ89Mi13JdppNjirAIzKgFJk=;
 b=qN8kIGKrhilAmXq8vtJz8gCNmXcvAjAtsMDN8xpqnyKhIdQMJSgJBZOWHzRF52cus5J1ixPQ/uXvJ9zxz07yya7rc5gLTeN0pX4Zc70s6fUQaj2Z35e2u7qY0A94lOFcQGG5R0qFALDLloYNVDb9bOd322Eqjw3l1a7FASsbUTejVpSeMAfTqdwK6/WitaxTw4mhbLnQX5/hgdn7I7k+sc+aI62qOgQQVvBXzGn0KCwjOUWTJcH9ksrGusGY3tC8zqOgyxdZHEuxMKhblb308/D8ZpA39wNp1DmiFXPVej4pvhAPV81lcivLZaObpKQu3+L+KGU+X8h5a6E0AZJLYQ==
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:15:01 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::b) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 14:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 14:15:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:42 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 5/6] selftests: router_mpath_nh_res: Test 16-bit next hop weights
Date: Wed, 7 Aug 2024 16:13:50 +0200
Message-ID: <a91d6ead9d1b1b4b7e276ca58a71ef814f42b7dd.1723036486.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723036486.git.petrm@nvidia.com>
References: <cover.1723036486.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: e7018cd3-56d4-4abb-9295-08dcb6eb5344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8O9Yb475zSFmibxdOJSjUv/tIbPPB65XK57zklk2zQoistBzDpaM84bOl96?=
 =?us-ascii?Q?iqB4+eY2+QwGv3euUjHlvqWiSFFq/t2OuA+TbtkDPWwykO6NgP1NYMh9xvr7?=
 =?us-ascii?Q?4x6uPArsT1xtyUGT13LAibq9Xiaa8FvW7lPLuZBnJqyc4YQ3I/m3034o/oty?=
 =?us-ascii?Q?bWdyPCEWQ/N5m4DxqlPH8kt5Lb/LwSe12Depw2u1OOwjHArXKhDkuHXKlMb7?=
 =?us-ascii?Q?o5npPzcoLGINAPng50T6h9p/xTKuoTXvLuma5pPqUx1VlzKteHxJuonTe5Pi?=
 =?us-ascii?Q?0TqsD+KSoiev+sIlBDWb+9GZfe98BBlLH2+BDqqhq5PPm6HbeBc3CO7xX04k?=
 =?us-ascii?Q?gqK6lehHZ5+H81TYwG8cjinvGeicT4/6O712Gg2bWGhmA2OBU3x9fo2qIPIZ?=
 =?us-ascii?Q?cdoEUVr0PH/luS6VdTamzB3bobccBHZO13vXTjioVXXgOac0JAD4z90RuJTi?=
 =?us-ascii?Q?USvV5kUOTlA5SYCLYVjR+k5pRyHVSeQouBkoC6t9rSmHY+4qTZcqB+8ibtje?=
 =?us-ascii?Q?WliyhfdvFY76/9DyhvZY38DIPaemZFpZmqwu1Q7bfaejSZ1tuF/SA3vF/nFz?=
 =?us-ascii?Q?/gF+UgbSou0iLE0/II6XNCjboN5od7wQ9YO4jEKdzO0TDaIbxQaq5Hqkb1uW?=
 =?us-ascii?Q?c0VL8fbMN6nc9XfDKw2cvrxDcrJMLu2P1R5AbN5kORyS27KG8gBvyFFP1ZBI?=
 =?us-ascii?Q?3ryTabaNAqLHwDOTWjsjU2XDdXZM1xIpGIHnHgeHtrRsHmnIJvoLJ6A0qUIk?=
 =?us-ascii?Q?y8O23ZoX9IzAq41xMYo3uZEjqgm4msgUWEu+msCdylgUxEZRs0S3CMyO8Ch9?=
 =?us-ascii?Q?s8iRrTmn3dE/vIsC9HkPixhpAMg9E41So6TkjRHJ6vp1X7fbfnJfrYQ5tWpv?=
 =?us-ascii?Q?dt4hEisV746TuMH2fsGKQG0M5Gn34WAOXSgd4MEwdHSkzDvmITXf3CFpiTwR?=
 =?us-ascii?Q?UgYahNdvO3rAZajLqbUlf76gxnxdNOvRI97JbSCRzvsbE/uxM2cW4zDdL98q?=
 =?us-ascii?Q?QrNgcbBtzxIz11KQGfAi6aPdo9GdQ5+sulgTm0fVw1sbrKQ1SBOAuSu+PkY5?=
 =?us-ascii?Q?Nka3SOVh9ln/EjJHWtXNy8h+cKb9SI4L/2zFJb6BEP92ljcJ6mwuqyDUJ1UX?=
 =?us-ascii?Q?2Bm7P4BIIw/Zgn8OJf++YE76DUQKi73PPHscl+T9Kj8nHoAxjvEfwUs0+LFa?=
 =?us-ascii?Q?I068E0ItVWRQJYYqMudqcuyZTHJLzNIhZVaZ8Oz/Q1uYFPQY72lsu9pWOOmZ?=
 =?us-ascii?Q?UXrTwxQ1hmnWlIVb81/DLlRoVBQH+WGCfFmLZcVjqV22Crul6zeZfsLCg4bw?=
 =?us-ascii?Q?1BSO9AEEzFI+JcOy2+byzCO1Aj8D+b/V3yaD+Dx+a2SrWhmINJqZ6KO9k15r?=
 =?us-ascii?Q?T3aKKfh2Q5eEtUk1LOe8KbEv57eDEEy3Aa5n3j0NqZa6Gh384ejvRul3oC4L?=
 =?us-ascii?Q?3q7h1vmXJ0gFX3QosPPaNReW3msYwdS3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:15:00.8934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7018cd3-56d4-4abb-9295-08dcb6eb5344
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

Add tests that exercise full 16 bits of NH weight.

Like in the previous patch, omit the 255:65535 test when KSFT_MACHINE_SLOW.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 .../net/forwarding/router_mpath_nh_res.sh     | 56 ++++++++++++++++---
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index bd35fe8be9aa..88ddae05b39d 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -40,6 +40,7 @@ ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
 	multipath_test
+	multipath16_test
 	nh_stats_test_v4
 	nh_stats_test_v6
 "
@@ -228,9 +229,11 @@ routing_nh_obj()
 
 multipath4_test()
 {
-	local desc="$1"
-	local weight_rp12=$2
-	local weight_rp13=$3
+	local desc=$1; shift
+	local weight_rp12=$1; shift
+	local weight_rp13=$1; shift
+	local ports=${1-sp=1024,dp=0-32768}; shift
+
 	local t0_rp12 t0_rp13 t1_rp12 t1_rp13
 	local packets_rp12 packets_rp13
 
@@ -243,7 +246,7 @@ multipath4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -259,9 +262,11 @@ multipath4_test()
 
 multipath6_l4_test()
 {
-	local desc="$1"
-	local weight_rp12=$2
-	local weight_rp13=$3
+	local desc=$1; shift
+	local weight_rp12=$1; shift
+	local weight_rp13=$1; shift
+	local ports=${1-sp=1024,dp=0-32768}; shift
+
 	local t0_rp12 t0_rp13 t1_rp12 t1_rp13
 	local packets_rp12 packets_rp13
 
@@ -274,7 +279,7 @@ multipath6_l4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -373,6 +378,41 @@ multipath_test()
 	ip nexthop replace id 106 group 104,1/105,1 type resilient
 }
 
+multipath16_test()
+{
+	check_nhgw16 104 || return
+
+	log_info "Running 16-bit IPv4 multipath tests"
+	ip nexthop replace id 103 group 101/102 type resilient idle_timer 0
+
+	ip nexthop replace id 103 group 101,65535/102,65535 type resilient
+	multipath4_test "65535:65535" 65535 65535
+
+	ip nexthop replace id 103 group 101,128/102,512 type resilient
+	multipath4_test "128:512" 128 512
+
+	ip nexthop replace id 103 group 101,255/102,65535 type resilient
+	omit_on_slow \
+		multipath4_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+
+	ip nexthop replace id 103 group 101,1/102,1 type resilient
+
+	log_info "Running 16-bit IPv6 L4 hash multipath tests"
+	ip nexthop replace id 106 group 104/105 type resilient idle_timer 0
+
+	ip nexthop replace id 106 group 104,65535/105,65535 type resilient
+	multipath6_l4_test "65535:65535" 65535 65535
+
+	ip nexthop replace id 106 group 104,128/105,512 type resilient
+	multipath6_l4_test "128:512" 128 512
+
+	ip nexthop replace id 106 group 104,255/105,65535 type resilient
+	omit_on_slow \
+		multipath6_l4_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+
+	ip nexthop replace id 106 group 104,1/105,1 type resilient
+}
+
 nh_stats_test_v4()
 {
 	__nh_stats_test_v4 resilient
-- 
2.45.2


