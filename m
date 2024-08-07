Return-Path: <netdev+bounces-116510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA694A9B6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307171C20CB4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5A6F2F0;
	Wed,  7 Aug 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDpBp/cr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC452F62
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040096; cv=fail; b=aI2f4gpiUu2wXM+2rTxA5iD/FTEyob6ZcfUukTY+TCnXqTKXNbqlCTFhnYKLdA0JSK7UtHaB4I+E3KFJPpNGpBgasxyTBTjhxKYbqSJ1lBA/LiKKXDwPk7VezBMCS+D27/in1MbvHwFPFnWamx+KjxxxEVjHUpIgt/huRmY0ajk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040096; c=relaxed/simple;
	bh=hI+QBCXRk3to4qMB9+u/rPFw0Q+SZmFHd0/9PqV7Eww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+GdAHVvix4i2wYbQ3esTfJMfzDxu7uZSx+WPkYvr3Vs1RdZ8Qhe+glDCRDH2eLa5K6uwv4wDuUtJDlJbGtBwiNZgBUXDB2/MkBbgraRO1dUQihl37b01TUXaswdr7XBA6k5hF1JX7vyqShsO5iD+2rCs3eMJ7K8lEPXBr6LysY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDpBp/cr; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYeWRCaewpADMp8kz/odZcQwHVG8FTRZcOd2rOW2sIFoxpxliRkKBgll+c83ibwO3q1ivzciigNXQdP3Z5mUmhj6wuHkRtqCZYjjqrftyY0Nm3nFgHbYYr9EJTksXa4NuV4LjD83mcXagyLdcEo/IVwujY3f/gp72ATYO0iuwi6mnX+FC9gIvVD8/uRsbrEPrqwqPsT/z0kZuexTUxwH6cUxZ4X+VeQftscZwgNd6u6QuDy8k7Hs8qWDYVn0CJI9UD0iXlD9dHyTD6t/528VM83olea9H2TUH2wGAuj1ScJmNqPYv1TlxJe14SyjqROq6xRabXPeldFChUo9KziD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K2FCfNr5WPKZ7pfxHVqrkGhlaRpxee+UKOyYjMxVJE=;
 b=Fq5Fq21MAPYkcLsaSw3K9cOuzDtWUXgv/WcDPyYz5zDEyPHa7qQ/q39oLbmfN0H2Q0GiNFJYNdXPKsGBJvMaaInsVZZcSq/C4dy9PNewdNjTBkyRAg1x3H+KE8h9EjJ1x6/JG1ZcYq7UwUKnigcbOUybLHQqZ4fmNIFiyFmiAPkREWWbxC7m6NtxaWzTMevI3xcljI0q8CkR9nYgRXIHD8IPEzzFQ94MEeykU4Bd+Des+XAMA51WUueLTQtOUlaLw8gM5hNcI4AoxNd8uovqEWxmJJZgpnTDDPOwbJeeckdagEojuYGbfJBJXqMLO/h3+w0za723rYhGClrqJvEdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K2FCfNr5WPKZ7pfxHVqrkGhlaRpxee+UKOyYjMxVJE=;
 b=YDpBp/crKBQ4v/i9qQFye474gN9aFQ3pv6yuLXa7Zo6PevYk3d0UkaYItAjbDUJ1Zf46Hg555eb9EELVZTTRew/CC2dmHjMJj1jD/580TZJfphV72ssa3GPiTtRSU9MMkxsAENkqXGwc89NEx0DyrE+Sr2pwmKX+HC2z3q9R26mUzYq3mpNv7VdHrh7cCr6c8TYPC2WrO/In2B9bDUGUzyBtHBw/aVj8PGWXYb6+2oeQFFn0jaGxMcvtPErNeTiyb382pcxXn5a83BLloiM8nWOtWtNZTp3R4MJhuT0zOTJibE6cLHxhwy9Ypt6saQAtIWTM87+csCdFINQ/DDuiew==
Received: from PH7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:510:339::11)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 14:14:51 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:339::4) by PH7PR03CA0026.outlook.office365.com
 (2603:10b6:510:339::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 14:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 14:14:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:35 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 4/6] selftests: router_mpath_nh: Test 16-bit next hop weights
Date: Wed, 7 Aug 2024 16:13:49 +0200
Message-ID: <c0c257c00ad30b07afc3fa5e2afd135925405544.1723036486.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 367637d8-15bc-4340-9eb1-08dcb6eb4d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vAb2O+RVBwD8Sjhz9nXPZ6fFDhgrV075h7FANDQY5VaxmEX7GrM0amvabDxk?=
 =?us-ascii?Q?NpDWIUem33ELFm6HZlq+225DEPCY+vmCOrhE+xTjnlFtj89Gg11c1OdLocjp?=
 =?us-ascii?Q?+clpcCGOtNjHsNQOMyLh+fcojltBFy9LiIJtMPvC0l4Lvt0TmLM+TVWCbhov?=
 =?us-ascii?Q?UbbvPEgmskHj0jXWyfyE/QCeOGexrOayWz8mcJTK7qRu02WyRdk1G/8VQm3i?=
 =?us-ascii?Q?qdK3QcoNsjGvjgpI64J9EVmu6jPXNXeLX/rC/cYfqxKR68PNPAPLcJ+FqHNX?=
 =?us-ascii?Q?/BSETCu5VTI1GZjrF6Tg5ggqr6WPlVqp7sie09iyfsMAhWtM/otgHPNMCFsS?=
 =?us-ascii?Q?u4JcRB19OZ+xy+gfTQjjSOqhHqGnVvSmXLhnjFPioXdsgbjlcbi9q/qkXx+o?=
 =?us-ascii?Q?RK5tYRBNCjWyIG15jdl6TQn3/O3HyELExQEDSIx7JZaeb7XKlmfREcl35ACw?=
 =?us-ascii?Q?maphWY92c5WI/JyCA/mEC2OLtLHsrVnqfHsIj6ocbl01/6FF+VKHhky7Z/Vp?=
 =?us-ascii?Q?l3Hvm21To74yR9+6WgIRPgurvQRi1yz04cFzkHXAK+gdC+8/OQkjutaMYSNd?=
 =?us-ascii?Q?k3Y23aYEdqttCV1tEyJSkZVJGSA5W5r/fMJL4XXCRUWprSJ9wuP1ztOIxkoZ?=
 =?us-ascii?Q?RtRwxOqli2AC+6u429MARTLQWm0Oy7OdfwVj2K4vEzXExQGdTDDs23iS8jQL?=
 =?us-ascii?Q?j2piJAeNPDl0/mIX2FmvkRTzZuaZCzTyVaUEQpe9frrWDkfb3+a6jQGmkoDg?=
 =?us-ascii?Q?CTN6lAUiSO6qYVU5VUCmiM6wNxsRqzCSuAiAEAKx/vfNJZiHKliosi5BLue0?=
 =?us-ascii?Q?jUZzHWu+9qJuOtxImL24slmnN6eEQPN6NL7nMNGoGjuhsAHmMYm/EVTA0JFr?=
 =?us-ascii?Q?hmua6vIdSaNF30SJKyg2ALnXahB593jcQWH7NOBgr06NlUjiPXyh7UomIr/u?=
 =?us-ascii?Q?P4puaMC0u33xjQj5QVVM2nFKAfqiValgAl6RrOQ+GdaPNfaWbQZqyq/X61Zw?=
 =?us-ascii?Q?Wm1I6yJqAZGuZhnIih+iOwIau4Nifb47bvLgs4j7/Ht5uL7NhUxM6sQTbthA?=
 =?us-ascii?Q?iiu1McFdUso2sHAn7HSar+ENsCBBf4eVxFkKxQTolrMjNgIFPb844ZLu1Go+?=
 =?us-ascii?Q?TsXNCe40ME285MRoWfMPLFfPE6egP75zea8HMkrRx24FMYR/32oGSphLHiRd?=
 =?us-ascii?Q?RLY1VistgrArF88p61GL6xjx+DIr5VExRkUYRzoz2uR8MlK+PzuJk6JLvyat?=
 =?us-ascii?Q?ipLGC8YxsCDwIiF4ZmscHLl6blq3rk5jpyi6bk+T0XnWsilKykiOFmDzUOuA?=
 =?us-ascii?Q?CK/Jdlah8TbrBQUEjhEFFIIEJbCx6pvdW3lwkFZSeMZeazgQhbR88uhJb83/?=
 =?us-ascii?Q?XK8UC9oknhJTZ7sHrKWeqdLm1ScEIAw4FyCNAyXAmYnwxwvZc4lRtnSGu/uA?=
 =?us-ascii?Q?8L2dUTeLT+dIKYBCK5SxOBQQI97RPIUL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:14:50.9594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367637d8-15bc-4340-9eb1-08dcb6eb4d51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

Add tests that exercise full 16 bits of NH weight.

To test the 255:65535, it is necessary to run more packets than for the
other tests. On a debug kernel, the test can take up to a minute, therefore
avoid the test when KSFT_MACHINE_SLOW.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/forwarding/lib.sh |  7 ++++
 .../net/forwarding/router_mpath_nh.sh         | 38 +++++++++++++++----
 .../net/forwarding/router_mpath_nh_lib.sh     | 13 +++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ff96bb7535ff..cb0fcd6f0293 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -509,6 +509,13 @@ xfail_on_slow()
 	fi
 }
 
+omit_on_slow()
+{
+	if [[ $KSFT_MACHINE_SLOW != yes ]]; then
+		"$@"
+	fi
+}
+
 xfail_on_veth()
 {
 	local dev=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index c5a30f8f55b5..a7d8399c8d4f 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -40,6 +40,7 @@ ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
 	multipath_test
+	multipath16_test
 	ping_ipv4_blackhole
 	ping_ipv6_blackhole
 	nh_stats_test_v4
@@ -226,9 +227,11 @@ routing_nh_obj()
 
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
 
@@ -242,7 +245,7 @@ multipath4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -259,9 +262,11 @@ multipath4_test()
 
 multipath6_test()
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
 
@@ -276,7 +281,7 @@ multipath6_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -315,6 +320,23 @@ multipath_test()
 	multipath6_test "Weighted MP 11:45" 11 45
 }
 
+multipath16_test()
+{
+	check_nhgw16 104 || return
+
+	log_info "Running 16-bit IPv4 multipath tests"
+	multipath4_test "65535:65535" 65535 65535
+	multipath4_test "128:512" 128 512
+	omit_on_slow \
+		multipath4_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+
+	log_info "Running 16-bit IPv6 multipath tests"
+	multipath6_test "65535:65535" 65535 65535
+	multipath6_test "128:512" 128 512
+	omit_on_slow \
+		multipath6_test "255:65535" 255 65535 sp=1024-1026,dp=0-65535
+}
+
 ping_ipv4_blackhole()
 {
 	RET=0
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
index 2903294d8bca..507b2852dabe 100644
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -117,3 +117,16 @@ __nh_stats_test_v6()
 			       $MZ -6 $h1 -A 2001:db8:1::2 -B 2001:db8:2::2
 	sysctl_restore net.ipv6.fib_multipath_hash_policy
 }
+
+check_nhgw16()
+{
+	local nhid=$1; shift
+
+	ip nexthop replace id 9999 group "$nhid,65535" &>/dev/null
+	if (( $? )); then
+		log_test_skip "16-bit multipath tests" \
+			      "iproute2 or the kernel do not support 16-bit next hop weights"
+		return 1
+	fi
+	ip nexthop del id 9999 ||:
+}
-- 
2.45.2


