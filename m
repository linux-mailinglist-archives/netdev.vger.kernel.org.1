Return-Path: <netdev+bounces-25300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7E773B39
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C61C21063
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DAB1401E;
	Tue,  8 Aug 2023 15:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BD1426E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A00A46BD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9SgD2RSx/9jp9f9tkL1c4zg4fVfWvMGQYkem52O5+i277q8HLTKgf4oHyZD2wYuj8pU+Ev6pMvhL3BjHr0q39jyjqz7w2R4WP5lRCNtMOOMVvRcXCogSs08mpaoUzorHofVt85FvpK990GBEBvy7AdO9y7cgMFbYNUUvoLjkkxMazAOhM7qFyxHl8cLpREO/E3QV2CcWFnWWeAD5vW6qdpXYGaTFICqMcASrFZjhoNWk5ZJjv+EtGrllp93EqzagYZ2fTffj2ydBfchZsdOf8juFn5gYDncnIXLWd+TnA6YWr93pBXqCuS8lMYDDyWcgeQCE/iNb5B9VF7nb8iLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um/fADwQBmuOmmzS8/Tpu2zAh9/Wb9BF1IdjvIAIGaU=;
 b=RwQbNs1AbqsMf5T2YYlc/eAA5pSRD9DE/AR8O2koAGd3wzBl1rHGvCjgww3Edgzvrx4XOYrQ20Is0oHzDBVx3ARfmyQFtxKxU7h+3hwfHBBaYLQmlyeP8uqVJ8wjrw+G8OlKrSKz7ncFU/FIRF83s4RU3YBkCWYLoPESfqaJ/nSZihM2/hR9TQyIXd8oMU6IVb8BwoRBpe5vtBcnQmhIuLJOEFgyoTGhlI/pIpaqx1bRmhS8Gc8yTEtkhAbKhTiuYDYA/+WLJoHWDhaJlFw6A1c3CXW1uT/xTxWKhxXPITBURPm1CczidPiQIRqnfaa1XlyTk2vXQJ8izpQEZZ/Hdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um/fADwQBmuOmmzS8/Tpu2zAh9/Wb9BF1IdjvIAIGaU=;
 b=Hb9JDVUUdaA7MW0nuM98maNr2d1w1w+UF/ErtozMdB9fWbDt2eSbuck9LvL9Pg359submnU+U/+2QGTjj5AFv3GgroXe5Afem9ki7IwTwW4ZyWpWHNx8egKuOSA9/PDboF2IxkItHMa5Ff9ZoVGIB+SxNqUYLXYiCa67DAuW7SpSqz9sqBwCzNzDwWHoNZDnHFCf1RUvyqERSzcUDWk6zBXZJZ/xCDmVcIEWuNpBDeEgfigatBOq0C0AzhOSQRKYn4Pzu4L2HCauXomCngOqM2BhYNJMgNaopCe+3FLmIvq1Jh6E1/sHnoCkSKJDpBQJ217XWLX88fPl7H4LcMV8Iw==
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Tue, 8 Aug
 2023 14:16:28 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::73) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 14:16:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:15 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:16:13 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 15/17] selftests: forwarding: bridge_mdb: Fix failing test with old libnet
Date: Tue, 8 Aug 2023 17:15:01 +0300
Message-ID: <20230808141503.4060661-16-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
References: <20230808141503.4060661-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c61740-565a-4cdf-117e-08db981a0e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6sNKShPt4lPaW6QCs+6+BoBlxOWKCFUSjlg/CXz9/5obu7roWD6BW9NWnkwRMW8xGEkWoag4cO7sMCgHbSSILO1zoqh+MCYEGMNkIojL9KOf9v9sXss04u/bdQrkbKolTe7aED/WN6rEiiwFHns+TtSvrLRebtzMAF0CBAgZoQqWGthAg11/Q0IJfl/8rXt1EnknNBT14CthAmCuyuOfBV4J5i259WakLm9g8MjELdOiBiqeaRyoSVm3jD4w+qhuQpGjJrMzmGG+43OaTehQRjiLhD5ZotjxlmN0Z0IJw/jliutKduU2fKoGb+1c4Mx2aTJMFowP+6MWgwQX4Hz6TaRRYD2VCTtiXDj3/DiypaLtzyTjoOasP9g/BvEgU5OJNelSVZaHqVA0U6pSkRSTmoNaTyWtoW4pAhvRpr97d+e2ChBx/636SMMOBIZMdFS2um3xhJCRXRVtM1bxOQECZO72y7SkbZFyoJ1SO3s7tIgc4/45xI7pXc70M3QU5kEIEAQQy7jTOpfiZgAlYRB5XwxRWlNhQCHPGAZ/n/L1JKgFRu5DF0QqLJTOdBMa61icofiweTM5fJOSzzZhccWgYItMW/nEE1TsQsFMDZT3+azGTo/w//VJnkIyfG3EBfW6q6X269oosfwTfSwXItr3JBqmJMn+lSh93aEt1cjslWIs7lDAJzG1Q4GV73BVuJ+kEfr4K/dITtjo9c38tDyjcDIqulbQpPCY4cFMHHqy95hyQUqPKhnBLORDuZDDjiVA0jqVTrSuKMvpjaa/CyVSfFGC2FM1pXhvMiMNcWi4ViY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(1800799003)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(4326008)(70586007)(36756003)(6916009)(2906002)(70206006)(478600001)(8936002)(8676002)(5660300002)(41300700001)(40460700003)(6666004)(316002)(36860700001)(40480700001)(54906003)(2616005)(82740400003)(356005)(86362001)(7636003)(966005)(26005)(1076003)(16526019)(336012)(107886003)(47076005)(83380400001)(66574015)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:27.8295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c61740-565a-4cdf-117e-08db981a0e48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As explained in commit 8bcfb4ae4d97 ("selftests: forwarding: Fix failing
tests with old libnet"), old versions of libnet (used by mausezahn) do
not use the "SO_BINDTODEVICE" socket option. For IP unicast packets,
this can be solved by prefixing mausezahn invocations with "ip vrf
exec". However, IP multicast packets do not perform routing and simply
egress the bound device, which does not exist in this case.

Fix by specifying the source and destination MAC of the packet which
will cause mausezahn to use a packet socket instead of an IP socket.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 46 ++++++++++---------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 6f830b5f03c9..4853b8e4f8d3 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -850,6 +850,7 @@ cfg_test()
 __fwd_test_host_ip()
 {
 	local grp=$1; shift
+	local dmac=$1; shift
 	local src=$1; shift
 	local mode=$1; shift
 	local name
@@ -872,27 +873,27 @@ __fwd_test_host_ip()
 	# Packet should only be flooded to multicast router ports when there is
 	# no matching MDB entry. The bridge is not configured as a multicast
 	# router port.
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after flood"
 
 	# Install a regular port group entry and expect the packet to not be
 	# locally received.
 	bridge mdb add dev br0 port $swp2 grp $grp temp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after installing a regular entry"
 
 	# Add a host entry and expect the packet to be locally received.
 	bridge mdb add dev br0 port br0 grp $grp temp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet not locally received after adding a host entry"
 
 	# Remove the host entry and expect the packet to not be locally
 	# received.
 	bridge mdb del dev br0 port br0 grp $grp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet locally received after removing a host entry"
 
@@ -905,8 +906,8 @@ __fwd_test_host_ip()
 
 fwd_test_host_ip()
 {
-	__fwd_test_host_ip "239.1.1.1" "192.0.2.1" "-4"
-	__fwd_test_host_ip "ff0e::1" "2001:db8:1::1" "-6"
+	__fwd_test_host_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "-4"
+	__fwd_test_host_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "-6"
 }
 
 fwd_test_host_l2()
@@ -966,6 +967,7 @@ fwd_test_host()
 __fwd_test_port_ip()
 {
 	local grp=$1; shift
+	local dmac=$1; shift
 	local valid_src=$1; shift
 	local invalid_src=$1; shift
 	local mode=$1; shift
@@ -999,43 +1001,43 @@ __fwd_test_port_ip()
 		vlan_ethtype $eth_type vlan_id 10 dst_ip $grp \
 		src_ip $invalid_src action drop
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 0
 	check_err $? "Packet from valid source received on H2 before adding entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 before adding entry"
 
 	bridge mdb add dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode $filter_mode source_list $src_list
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Packet from valid source not received on H2 after adding entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 after adding entry"
 
 	bridge mdb replace dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode exclude
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source not received on H2 after allowing all sources"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source not received on H2 after allowing all sources"
 
 	bridge mdb del dev br0 port $swp2 grp $grp vid 10
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source received on H2 after deleting entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source received on H2 after deleting entry"
 
@@ -1047,11 +1049,11 @@ __fwd_test_port_ip()
 
 fwd_test_port_ip()
 {
-	__fwd_test_port_ip "239.1.1.1" "192.0.2.1" "192.0.2.2" "-4" "exclude"
-	__fwd_test_port_ip "ff0e::1" "2001:db8:1::1" "2001:db8:1::2" "-6" \
+	__fwd_test_port_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "192.0.2.2" "-4" "exclude"
+	__fwd_test_port_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "2001:db8:1::2" "-6" \
 		"exclude"
-	__fwd_test_port_ip "239.1.1.1" "192.0.2.1" "192.0.2.2" "-4" "include"
-	__fwd_test_port_ip "ff0e::1" "2001:db8:1::1" "2001:db8:1::2" "-6" \
+	__fwd_test_port_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "192.0.2.2" "-4" "include"
+	__fwd_test_port_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "2001:db8:1::2" "-6" \
 		"include"
 }
 
@@ -1127,7 +1129,7 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
+	$MZ $h1.10 -c 1 -a own -b 01:00:5e:01:01:01 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -q 192.0.2.2
@@ -1140,7 +1142,7 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
+	$MZ $h1.10 -a own -b 01:00:5e:01:01:01 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -v "src" | \
@@ -1167,7 +1169,7 @@ ctrl_mldv2_is_in_test()
 
 	# IS_IN ( 2001:db8:1::2 )
 	local p=$(mldv2_is_in_get fe80::1 ff0e::1 2001:db8:1::2)
-	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
+	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | \
@@ -1181,7 +1183,7 @@ ctrl_mldv2_is_in_test()
 		filter_mode include source_list 2001:db8:1::1
 
 	# IS_IN ( 2001:db8:1::2 )
-	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
+	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | grep -v "src" | \
-- 
2.40.1


