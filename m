Return-Path: <netdev+bounces-58333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C7815E3A
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53901C20EB1
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0600D1C33;
	Sun, 17 Dec 2023 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOdz584v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90D1874
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2jUaYwg7RyAUbqWWC7m00KY3bjSovaj14Sw83YT4TNqYtBjAzYSNIZPsmCXzwzJzxwtghx5aPCB1DNJn6MS9b5m6hj2GZyO3pAqeNVmlLbGu/MBcK2xmgJBNQiDvz4IZyP0XVy2NL0JlfF+dpiqMW7J+W0DohD55bHQVPZHUcuXVeRqmNKW56agMAAgG4RF3/gyzFVSo/Lw0SuO/yMF9V3lFKQrdO3b3RmGOz79awNY5RXyI6HeCjmPg96R2fP1InlOtaRkSu0G39WH8X5D0mdDk4Wi2w4SETj0jx4iFnmdV0CFhXSYcUjGiWXuxAzSOrORlelrYpzgvuFkF8Qunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcSWOMkbVlRQ5+08nDt1bRUq6xiXudPfjwSXMkdn3js=;
 b=WM+GmFRRoTwg2gaF/lWoxrZleReLRqQTkIV4wauszvMBU8Nru9Mf/6Q/7ysltI4ZUtiH7hkfXXLDNBPVF7Oi3MQs0sukplpK51x0+FGG4urc1mZ60Hz37Hj8bZll23sX+jsr35Vm+iZid85H6dk4Ss1nc3/+Wfh7PKhsp6h722wUrjRXJGa2Z+tyF6KyuRE8xUTCrDWs+lJY33oPBAveFQEGN+nLjqNQq6rFcfdS4EHYO80ucgMdjc1oSkhrv9bNLKYiyy/LtNqfdVY1TTtT7UQp0jB2m70yC3tUWK4DIpw+A+jcSMozkABgNdMWilX4pz8UheOrDihiPtb9MlQYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcSWOMkbVlRQ5+08nDt1bRUq6xiXudPfjwSXMkdn3js=;
 b=sOdz584viktmq2KSeEiQYwwWlg786fVcDQGS+0uGNF8CGyLwohFjiTjIGWMXCGPZUw9qWrAryizMHVhpxlpKaeQXmqsbrw2gdcrn44k51KnGHnwBd5yPOUJw1z7dNak5cGQty/t6dV67p3U5eAlJ1cMyztFzrM5AJFNhB0Qw+WSJ93iwnkS+GvlywSrfQJ8akWEdQI8s/ytlNz07i1Ls+cdRTa6h3fz6zuIWYswa0Q8zpUSZR5cLgOLe6tPPP8MWbYU9x3S4AiDGz46r+FTXlzWSVgpFMDgf5rygay8XqGnGbWmJbWf3JtFouJZbAAjUhRKr37UjyvOmt0VqtHdLeA==
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 08:33:55 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::18) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.43 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:45 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:42 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 9/9] selftests: vxlan_mdb: Add MDB bulk deletion test
Date: Sun, 17 Dec 2023 10:32:44 +0200
Message-ID: <20231217083244.4076193-10-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217083244.4076193-1-idosch@nvidia.com>
References: <20231217083244.4076193-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: f37c0462-f644-4c33-6f45-08dbfedae7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mLA5yAPE0G7qFuMhLxfrrsemGgI8OTYDYbjW/zf3ynEMmZg+trUPWoUn5gLGYDo9eosj5LmTK85AFdsECw7x9Iu2qMEp4Lcvxe3xZrK5PasdD25zrQ/nmykDf6HK6MvRKyvXpjV6EBhiF7vL6xgNzYfDSG6pclTmXj4QvO4m1BmeSfgGJbwJLvLMgjz1THfcpWBSOt15QxKm3tIXWD4k0wKWYl4I503Di+Gt3Xf6/zZVkL3ATy3f+rMC/JGYjjnhxkLdV/jFk0DiWRVGA29PBc3Mts/R9TORu2GsIHy7uvoLzrEAtYBwskPIHy4XcoopQrmm459v4wEs5DhAoOhG1JLV0GN0Xjd/lwRJAO1zlqd4xcSazgGR51GIuWvo8h2+mYtRqItD5cfJg7wewzDzkEh7r3YQ4BhYyOAz1UMdYxvuZ8Y45CAeVgKV4Va6n4ArJSahnyUzqy7oWR0FWkwkBq2KbeWjw6hqfs9nlpCTI5kLml1ddGw0Yc5Qs1yimrkLn6ovH0MUuvlsgxEuO+9rIPII63eBSM25Fw7VMk/D29H1wQ4RL6jJydTtsSkCK49TyEIhDMQXXLK0rR+WJLkV/HJEihNEjj42/pxrph0EZz9W0uvuTWTiOkfY6AhHigWKFTxl8xeBWJGQk6x2ZlGs/wzCYJHfFPp5aU8dCIWvYiqeSXjuT8EanVrX4HHkFB/xiqntZOXrmbv2zPjrVZJpaHVYhXE9X5dpbJkPrkybRM5us0hAwPQ99HL93UC1+ytT
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(40470700004)(36840700001)(26005)(426003)(1076003)(2616005)(336012)(16526019)(107886003)(36860700001)(5660300002)(83380400001)(47076005)(478600001)(30864003)(2906002)(8676002)(8936002)(4326008)(41300700001)(110136005)(70586007)(70206006)(54906003)(316002)(7636003)(356005)(82740400003)(36756003)(86362001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:54.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c0462-f644-4c33-6f45-08dbfedae7d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

Add test cases to verify the behavior of the MDB bulk deletion
functionality in the VXLAN driver.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/test_vxlan_mdb.sh | 201 +++++++++++++++++-
 1 file changed, 199 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_mdb.sh b/tools/testing/selftests/net/test_vxlan_mdb.sh
index 6725fd9157b9..84a05a9e46d8 100755
--- a/tools/testing/selftests/net/test_vxlan_mdb.sh
+++ b/tools/testing/selftests/net/test_vxlan_mdb.sh
@@ -79,6 +79,7 @@ CONTROL_PATH_TESTS="
 	dump_ipv6_ipv4
 	dump_ipv4_ipv6
 	dump_ipv6_ipv6
+	flush
 "
 
 DATA_PATH_TESTS="
@@ -968,6 +969,202 @@ dump_ipv6_ipv6()
 	dump_common $ns1 $local_addr $remote_prefix $fn
 }
 
+flush()
+{
+	local num_entries
+
+	echo
+	echo "Control path: Flush"
+	echo "-------------------"
+
+	# Add entries with different attributes and check that they are all
+	# flushed when the flush command is given with no parameters.
+
+	# Different source VNI.
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.2 permanent dst 198.51.100.1 src_vni 10011"
+
+	# Different routing protocol.
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.3 permanent proto bgp dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.4 permanent proto zebra dst 198.51.100.1 src_vni 10010"
+
+	# Different destination IP.
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.5 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.6 permanent dst 198.51.100.2 src_vni 10010"
+
+	# Different destination port.
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.7 permanent dst 198.51.100.1 dst_port 11111 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.8 permanent dst 198.51.100.1 dst_port 22222 src_vni 10010"
+
+	# Different VNI.
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.9 permanent dst 198.51.100.1 vni 10010 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.10 permanent dst 198.51.100.1 vni 10020 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+	num_entries=$(bridge -n $ns1_v4 mdb show dev vx0 | wc -l)
+	[[ $num_entries -eq 0 ]]
+	log_test $? 0 "Flush all"
+
+	# Check that entries are flushed when port is specified as the VXLAN
+	# device and that an error is returned when port is specified as a
+	# different net device.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 port vx0"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010"
+	log_test $? 254 "Flush by port"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 port veth0"
+	log_test $? 255 "Flush by wrong port"
+
+	# Check that when flushing by source VNI only entries programmed with
+	# the specified source VNI are flushed and the rest are not.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.2 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10011"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.2 src_vni 10011"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010"
+	log_test $? 254 "Flush by specified source VNI"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10011"
+	log_test $? 0 "Flush by unspecified source VNI"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# Check that all entries are flushed when "permanent" is specified and
+	# that an error is returned when "nopermanent" is specified.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 permanent"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010"
+	log_test $? 254 "Flush by \"permanent\" state"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 nopermanent"
+	log_test $? 255 "Flush by \"nopermanent\" state"
+
+	# Check that when flushing by routing protocol only entries programmed
+	# with the specified routing protocol are flushed and the rest are not.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent proto bgp dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent proto zebra dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 proto bgp"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"proto bgp\""
+	log_test $? 1 "Flush by specified routing protocol"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"proto zebra\""
+	log_test $? 0 "Flush by unspecified routing protocol"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# Check that when flushing by destination IP only entries programmed
+	# with the specified destination IP are flushed and the rest are not.
+
+	# IPv4.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst 198.51.100.2"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
+	log_test $? 1 "Flush by specified destination IP - IPv4"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.1"
+	log_test $? 0 "Flush by unspecified destination IP - IPv4"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# IPv6.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 2001:db8:1000::1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 2001:db8:1000::2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst 2001:db8:1000::2"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 2001:db8:1000::2"
+	log_test $? 1 "Flush by specified destination IP - IPv6"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 2001:db8:1000::1"
+	log_test $? 0 "Flush by unspecified destination IP - IPv6"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# Check that when flushing by UDP destination port only entries
+	# programmed with the specified port are flushed and the rest are not.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst_port 11111 dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst_port 22222 dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst_port 11111"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"dst_port 11111\""
+	log_test $? 1 "Flush by specified UDP destination port"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"dst_port 22222\""
+	log_test $? 0 "Flush by unspecified UDP destination port"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# When not specifying a UDP destination port for an entry, traffic is
+	# encapsulated with the device's UDP destination port. Check that when
+	# flushing by the device's UDP destination port only entries programmed
+	# with this port are flushed and the rest are not.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst_port 22222 dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst_port 4789"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.1"
+	log_test $? 1 "Flush by device's UDP destination port"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
+	log_test $? 0 "Flush by unspecified UDP destination port"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# Check that when flushing by destination VNI only entries programmed
+	# with the specified destination VNI are flushed and the rest are not.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent vni 20010 dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent vni 20011 dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 vni 20010"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \" vni 20010\""
+	log_test $? 1 "Flush by specified destination VNI"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \" vni 20011\""
+	log_test $? 0 "Flush by unspecified destination VNI"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# When not specifying a destination VNI for an entry, traffic is
+	# encapsulated with the source VNI. Check that when flushing by a
+	# destination VNI that is equal to the source VNI only such entries are
+	# flushed and the rest are not.
+
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent dst 198.51.100.1 src_vni 10010"
+	run_cmd "bridge -n $ns1_v4 mdb add dev vx0 port vx0 grp 239.1.1.1 permanent vni 20010 dst 198.51.100.2 src_vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 vni 10010"
+
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.1"
+	log_test $? 1 "Flush by destination VNI equal to source VNI"
+	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
+	log_test $? 0 "Flush by unspecified destination VNI"
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
+
+	# Test that an error is returned when trying to flush using VLAN ID.
+
+	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 vid 10"
+	log_test $? 255 "Flush by VLAN ID"
+}
+
 ################################################################################
 # Tests - Data path
 
@@ -2292,9 +2489,9 @@ if [ ! -x "$(command -v jq)" ]; then
 	exit $ksft_skip
 fi
 
-bridge mdb help 2>&1 | grep -q "get"
+bridge mdb help 2>&1 | grep -q "flush"
 if [ $? -ne 0 ]; then
-   echo "SKIP: iproute2 bridge too old, missing VXLAN MDB get support"
+   echo "SKIP: iproute2 bridge too old, missing VXLAN MDB flush support"
    exit $ksft_skip
 fi
 
-- 
2.40.1


