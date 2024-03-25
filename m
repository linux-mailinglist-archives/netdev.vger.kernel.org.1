Return-Path: <netdev+bounces-81531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E588ABE3
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B7AB65A21
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D712F5B9;
	Mon, 25 Mar 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D3ONBIfi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D813A88F
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353085; cv=fail; b=lSgUCbn3ixcfVvDnXUIYm2chZDoSBkQfdacgFy8SrW6Z0U/Wloks9tYOc9H0Jd1Q+ZOe83fqYUGfvuuxKUeOEwIXoXKk6evUGrB6cidAWY2E7HZDMxZiEZKEFQ2V8OVWDZ0N3UcLI5iOZ0QWvgJAAO7Bg4KiX0j9dKuUQFSYpKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353085; c=relaxed/simple;
	bh=ZtiFyDxRbiXR4JJ7JLe9RkD9joVELYxHcBDNo1YAjYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UuBFItTRzZAT52lzegR6neuScsSvultzz6KGaZ8X5YEcQZY61eokDMf5kXMZFCRGY/mnYHZTb4oIx2nwzDHahFicRe0cX+ttYS7FgyBAkzGX37xr+zLzxKyoT0sFUROMa1OtCxwlTHAOYpFp6AthyGP6Q4WwJMpZFGFEM7MoDFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D3ONBIfi; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCq+jskGac9GrOLyA/FTeNU3rDGvSsIG/PGjbyqQYGHSWllKr2e64hsIl0oPVANkYEuhf1OUFxxyfSjoNrFiR2tCZPSC8uypgAFIMtvUjOKCQ0ft/u9xkIdeTJqsM80G/qZG337yWx8cta0zQWjmCq6ifozFIqGJXPDTMvl45oZqOCWYw2MPNQLA8Sd+3SDMREqX0Er62nl0tpBjIHZ7uuUW4gVUrI/2U7fTe0UqmgCMkqVoAwXFhmlHhqaUsvEpLrKRN090zn88ExXxu41VxitDAc10FLt066cscdwFyy2VwURlPxTkW7rmnba5CW/yIZTkoZvE7Zw6VtEL9Muz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98iL2Ih3RwSqT6lI2GjtIoRBrG2vvMGeuR3yKr4Bujg=;
 b=Arv/4H0MCDV5EVL6t0YnE3qNrKy3R4Gmo56elC6rHMhXKBl27UynoJzvRJJAQY4GzY8XGDHgdaVam/fW9famgrTe/6FesUsqyoFt9dXioCxe4xgmKDeWBOZ4pvYAdcdBOk+9Pv0QFhmUTVNGXGYXNsLpfpV+E/8XdS7EK/lvAIBRqkeTjMVNy1+O01J3jMc5tSxJauRVTn2aN9cB6IaK5w8/cyUJct0ULrEqV9cG3w9BB8QEFmiswoxhLHb/dBzSTV9J4ymSggKiLzaPk2xtlPJUZ8PBjAe5ov6pUvV61Z8rxO+eKdLN9MUaknjEr/Seetp12J9TXGUj4jEYWI9iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98iL2Ih3RwSqT6lI2GjtIoRBrG2vvMGeuR3yKr4Bujg=;
 b=D3ONBIfiDQTXz0Pb/qfdZh5RGvg0zez5X0ZkABERu2YRKnAABFyK2e+ESjIiRfatu9r2UIIeAl07fAL1P1CiP6wMECH/8pNWZXgtluqBT6Bf7bX0uj+30I/KFu89Q4WrWGBhb0GNGjFa77rwqAesUHPZ0ndmTDKl4Sf8ltRNc0XUg69eHLGq6QlJMhgdWYPBJ0COZE4JPlkjmD1p9B69t4RCVvWUpLt8+BNT8/hJU0UyxHgT+CsmuJTb9z+E1QL8ST8Zc0KkwMVbqw2mjjWmSDJ7V2Y2UI+vhRGe3Q+adOVyG7HK+4/COnIJEHHqGTebJwsvDFnEx2ivd8OslJo+tQ==
Received: from CH2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:610:58::18)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:51:17 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::a2) by CH2PR20CA0008.outlook.office365.com
 (2603:10b6:610:58::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 07:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 07:51:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 00:51:06 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 25 Mar 2024 00:51:03 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] selftests: vxlan_mdb: Fix failures with old libnet
Date: Mon, 25 Mar 2024 09:50:30 +0200
Message-ID: <20240325075030.2379513-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cb4125-a39f-40a2-2869-08dc4ca05a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EeJtux84pb5FxgbqEwUxJMYKqjRZIGA3K30uVuYSeO+ZeyxZYLeZYGXC//PKVDC9SwgSs3eOYXSKnV++OBd/b4WcV1Mg15wQNXRoG2EB3BUwZ436DgGkUY6+xgrCTv9kNLcRlIyiQK67uHSYoHYhvZvRqAq5cKqao9RBcZqycf1wlhN7L0wlQM0e0Uow5QokXdmgkas+eKgIrRQrhlRrNDMp9Gp9YD2WbL2XIgC49U/kpKRzn4ProkDJc3VkZZNdaZASfOSk2gsXT9o2H9OSwN6vF2zrJJVppJlARNMx+r+wjvr389ANtdw/ZZYeEwDmAQlYcHoZFh6uJxgxBvmNaydG8i5aR0Obmu9BDiBnaZOzgJ4WQnj9OxzXGiZwswEMk8RqBVBXSYqhMereHo+AvvZsC9CVaDewQHxGMXWCEny+eyMeLZ+IJkgHV+a8woRwoUv9qkXhNmud+OFDeyqcsJs8woijezmWz/FGOZImuB25V3IFRedoF+Du06vFi1+zbWC/4fRN71WkKI+gQepN0uOcytnx6rphGnkmSw2QfJZO5QcqTpzEgjcCfAiPTOPAGGN21K1eU9cHfbBwLCf7pkVjirHEQGQByG9bhmiKdehkaYo9EsVP+6qseOXPfrEm6HVXhmekuuQh8aVk30lE3mwNvwA2TqoXoNTqgIzEjZilL62z57z67eiSGfBcK0k1HZK810lbyzgj9RndkospbIZNsgR4EbwcW7ilj76LvAef/etnpn7f5iVl9QNnzWam
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:51:17.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cb4125-a39f-40a2-2869-08dc4ca05a4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

Locally generated IP multicast packets (such as the ones used in the
test) do not perform routing and simply egress the bound device.

However, as explained in commit 8bcfb4ae4d97 ("selftests: forwarding:
Fix failing tests with old libnet"), old versions of libnet (used by
mausezahn) do not use the "SO_BINDTODEVICE" socket option. Specifically,
the library started using the option for IPv6 sockets in version 1.1.6
and for IPv4 sockets in version 1.2. This explains why on Ubuntu - which
uses version 1.1.6 - the IPv4 overlay tests are failing whereas the IPv6
ones are passing.

Fix by specifying the source and destination MAC of the packets which
will cause mausezahn to use a packet socket instead of an IP socket.

Fixes: 62199e3f1658 ("selftests: net: Add VXLAN MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr/
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/test_vxlan_mdb.sh | 205 +++++++++++-------
 1 file changed, 128 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_mdb.sh b/tools/testing/selftests/net/test_vxlan_mdb.sh
index 74ff9fb2a6f0..58da5de99ac4 100755
--- a/tools/testing/selftests/net/test_vxlan_mdb.sh
+++ b/tools/testing/selftests/net/test_vxlan_mdb.sh
@@ -1177,6 +1177,7 @@ encap_params_common()
 	local plen=$1; shift
 	local enc_ethtype=$1; shift
 	local grp=$1; shift
+	local grp_dmac=$1; shift
 	local src=$1; shift
 	local mz=$1; shift
 
@@ -1195,11 +1196,11 @@ encap_params_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent dst $vtep2_ip src_vni 10020"
 
 	run_cmd "tc -n $ns2 filter replace dev vx0 ingress pref 1 handle 101 proto all flower enc_dst_ip $vtep1_ip action pass"
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Destination IP - match"
 
-	run_cmd "ip netns exec $ns1 $mz br0.20 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.20 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Destination IP - no match"
 
@@ -1212,20 +1213,20 @@ encap_params_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent dst $vtep1_ip dst_port 1111 src_vni 10020"
 
 	run_cmd "tc -n $ns2 filter replace dev veth0 ingress pref 1 handle 101 proto $enc_ethtype flower ip_proto udp dst_port 4789 action pass"
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev veth0 ingress" 101 1
 	log_test $? 0 "Default destination port - match"
 
-	run_cmd "ip netns exec $ns1 $mz br0.20 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.20 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev veth0 ingress" 101 1
 	log_test $? 0 "Default destination port - no match"
 
 	run_cmd "tc -n $ns2 filter replace dev veth0 ingress pref 1 handle 101 proto $enc_ethtype flower ip_proto udp dst_port 1111 action pass"
-	run_cmd "ip netns exec $ns1 $mz br0.20 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.20 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev veth0 ingress" 101 1
 	log_test $? 0 "Non-default destination port - match"
 
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev veth0 ingress" 101 1
 	log_test $? 0 "Non-default destination port - no match"
 
@@ -1238,11 +1239,11 @@ encap_params_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent dst $vtep1_ip src_vni 10020"
 
 	run_cmd "tc -n $ns2 filter replace dev vx0 ingress pref 1 handle 101 proto all flower enc_key_id 10010 action pass"
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Default destination VNI - match"
 
-	run_cmd "ip netns exec $ns1 $mz br0.20 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.20 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Default destination VNI - no match"
 
@@ -1250,11 +1251,11 @@ encap_params_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent dst $vtep1_ip vni 10010 src_vni 10020"
 
 	run_cmd "tc -n $ns2 filter replace dev vx0 ingress pref 1 handle 101 proto all flower enc_key_id 10020 action pass"
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Non-default destination VNI - match"
 
-	run_cmd "ip netns exec $ns1 $mz br0.20 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.20 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Non-default destination VNI - no match"
 
@@ -1272,6 +1273,7 @@ encap_params_ipv4_ipv4()
 	local plen=32
 	local enc_ethtype="ip"
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local src=192.0.2.129
 
 	echo
@@ -1279,7 +1281,7 @@ encap_params_ipv4_ipv4()
 	echo "------------------------------------------------------------------"
 
 	encap_params_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $enc_ethtype \
-		$grp $src "mausezahn"
+		$grp $grp_dmac $src "mausezahn"
 }
 
 encap_params_ipv6_ipv4()
@@ -1291,6 +1293,7 @@ encap_params_ipv6_ipv4()
 	local plen=32
 	local enc_ethtype="ip"
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local src=2001:db8:100::1
 
 	echo
@@ -1298,7 +1301,7 @@ encap_params_ipv6_ipv4()
 	echo "------------------------------------------------------------------"
 
 	encap_params_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $enc_ethtype \
-		$grp $src "mausezahn -6"
+		$grp $grp_dmac $src "mausezahn -6"
 }
 
 encap_params_ipv4_ipv6()
@@ -1310,6 +1313,7 @@ encap_params_ipv4_ipv6()
 	local plen=128
 	local enc_ethtype="ipv6"
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local src=192.0.2.129
 
 	echo
@@ -1317,7 +1321,7 @@ encap_params_ipv4_ipv6()
 	echo "------------------------------------------------------------------"
 
 	encap_params_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $enc_ethtype \
-		$grp $src "mausezahn"
+		$grp $grp_dmac $src "mausezahn"
 }
 
 encap_params_ipv6_ipv6()
@@ -1329,6 +1333,7 @@ encap_params_ipv6_ipv6()
 	local plen=128
 	local enc_ethtype="ipv6"
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local src=2001:db8:100::1
 
 	echo
@@ -1336,7 +1341,7 @@ encap_params_ipv6_ipv6()
 	echo "------------------------------------------------------------------"
 
 	encap_params_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $enc_ethtype \
-		$grp $src "mausezahn -6"
+		$grp $grp_dmac $src "mausezahn -6"
 }
 
 starg_exclude_ir_common()
@@ -1347,6 +1352,7 @@ starg_exclude_ir_common()
 	local vtep2_ip=$1; shift
 	local plen=$1; shift
 	local grp=$1; shift
+	local grp_dmac=$1; shift
 	local valid_src=$1; shift
 	local invalid_src=$1; shift
 	local mz=$1; shift
@@ -1368,14 +1374,14 @@ starg_exclude_ir_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $invalid_src dst $vtep2_ip src_vni 10010"
 
 	# Check that invalid source is not forwarded to any VTEP.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 0
 	log_test $? 0 "Block excluded source - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 0
 	log_test $? 0 "Block excluded source - second VTEP"
 
 	# Check that valid source is forwarded to both VTEPs.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Forward valid source - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
@@ -1385,14 +1391,14 @@ starg_exclude_ir_common()
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep2_ip src_vni 10010"
 
 	# Check that invalid source is not forwarded to any VTEP.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Block excluded source after removal - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
 	log_test $? 0 "Block excluded source after removal - second VTEP"
 
 	# Check that valid source is forwarded to the remaining VTEP.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 2
 	log_test $? 0 "Forward valid source after removal - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
@@ -1407,6 +1413,7 @@ starg_exclude_ir_ipv4_ipv4()
 	local vtep2_ip=198.51.100.200
 	local plen=32
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1415,7 +1422,7 @@ starg_exclude_ir_ipv4_ipv4()
 	echo "-------------------------------------------------------------"
 
 	starg_exclude_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn"
+		$grp_dmac $valid_src $invalid_src "mausezahn"
 }
 
 starg_exclude_ir_ipv6_ipv4()
@@ -1426,6 +1433,7 @@ starg_exclude_ir_ipv6_ipv4()
 	local vtep2_ip=198.51.100.200
 	local plen=32
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1434,7 +1442,7 @@ starg_exclude_ir_ipv6_ipv4()
 	echo "-------------------------------------------------------------"
 
 	starg_exclude_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn -6"
+		$grp_dmac $valid_src $invalid_src "mausezahn -6"
 }
 
 starg_exclude_ir_ipv4_ipv6()
@@ -1445,6 +1453,7 @@ starg_exclude_ir_ipv4_ipv6()
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1453,7 +1462,7 @@ starg_exclude_ir_ipv4_ipv6()
 	echo "-------------------------------------------------------------"
 
 	starg_exclude_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn"
+		$grp_dmac $valid_src $invalid_src "mausezahn"
 }
 
 starg_exclude_ir_ipv6_ipv6()
@@ -1464,6 +1473,7 @@ starg_exclude_ir_ipv6_ipv6()
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1472,7 +1482,7 @@ starg_exclude_ir_ipv6_ipv6()
 	echo "-------------------------------------------------------------"
 
 	starg_exclude_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn -6"
+		$grp_dmac $valid_src $invalid_src "mausezahn -6"
 }
 
 starg_include_ir_common()
@@ -1483,6 +1493,7 @@ starg_include_ir_common()
 	local vtep2_ip=$1; shift
 	local plen=$1; shift
 	local grp=$1; shift
+	local grp_dmac=$1; shift
 	local valid_src=$1; shift
 	local invalid_src=$1; shift
 	local mz=$1; shift
@@ -1504,14 +1515,14 @@ starg_include_ir_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode include source_list $valid_src dst $vtep2_ip src_vni 10010"
 
 	# Check that invalid source is not forwarded to any VTEP.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 0
 	log_test $? 0 "Block excluded source - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 0
 	log_test $? 0 "Block excluded source - second VTEP"
 
 	# Check that valid source is forwarded to both VTEPs.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Forward valid source - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
@@ -1521,14 +1532,14 @@ starg_include_ir_common()
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep2_ip src_vni 10010"
 
 	# Check that invalid source is not forwarded to any VTEP.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Block excluded source after removal - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
 	log_test $? 0 "Block excluded source after removal - second VTEP"
 
 	# Check that valid source is forwarded to the remaining VTEP.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 2
 	log_test $? 0 "Forward valid source after removal - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
@@ -1543,6 +1554,7 @@ starg_include_ir_ipv4_ipv4()
 	local vtep2_ip=198.51.100.200
 	local plen=32
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1551,7 +1563,7 @@ starg_include_ir_ipv4_ipv4()
 	echo "-------------------------------------------------------------"
 
 	starg_include_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn"
+		$grp_dmac $valid_src $invalid_src "mausezahn"
 }
 
 starg_include_ir_ipv6_ipv4()
@@ -1562,6 +1574,7 @@ starg_include_ir_ipv6_ipv4()
 	local vtep2_ip=198.51.100.200
 	local plen=32
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1570,7 +1583,7 @@ starg_include_ir_ipv6_ipv4()
 	echo "-------------------------------------------------------------"
 
 	starg_include_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn -6"
+		$grp_dmac $valid_src $invalid_src "mausezahn -6"
 }
 
 starg_include_ir_ipv4_ipv6()
@@ -1581,6 +1594,7 @@ starg_include_ir_ipv4_ipv6()
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1589,7 +1603,7 @@ starg_include_ir_ipv4_ipv6()
 	echo "-------------------------------------------------------------"
 
 	starg_include_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn"
+		$grp_dmac $valid_src $invalid_src "mausezahn"
 }
 
 starg_include_ir_ipv6_ipv6()
@@ -1600,6 +1614,7 @@ starg_include_ir_ipv6_ipv6()
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1608,7 +1623,7 @@ starg_include_ir_ipv6_ipv6()
 	echo "-------------------------------------------------------------"
 
 	starg_include_ir_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $grp \
-		$valid_src $invalid_src "mausezahn -6"
+		$grp_dmac $valid_src $invalid_src "mausezahn -6"
 }
 
 starg_exclude_p2mp_common()
@@ -1618,6 +1633,7 @@ starg_exclude_p2mp_common()
 	local mcast_grp=$1; shift
 	local plen=$1; shift
 	local grp=$1; shift
+	local grp_dmac=$1; shift
 	local valid_src=$1; shift
 	local invalid_src=$1; shift
 	local mz=$1; shift
@@ -1635,12 +1651,12 @@ starg_exclude_p2mp_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $invalid_src dst $mcast_grp src_vni 10010 via veth0"
 
 	# Check that invalid source is not forwarded.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 0
 	log_test $? 0 "Block excluded source"
 
 	# Check that valid source is forwarded.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Forward valid source"
 
@@ -1648,7 +1664,7 @@ starg_exclude_p2mp_common()
 	run_cmd "ip -n $ns2 address del $mcast_grp/$plen dev veth0"
 
 	# Check that valid source is not received anymore.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Receive of valid source after removal from group"
 }
@@ -1660,6 +1676,7 @@ starg_exclude_p2mp_ipv4_ipv4()
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1667,7 +1684,7 @@ starg_exclude_p2mp_ipv4_ipv4()
 	echo "Data path: (*, G) EXCLUDE - P2MP - IPv4 overlay / IPv4 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn"
 }
 
@@ -1678,6 +1695,7 @@ starg_exclude_p2mp_ipv6_ipv4()
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1685,7 +1703,7 @@ starg_exclude_p2mp_ipv6_ipv4()
 	echo "Data path: (*, G) EXCLUDE - P2MP - IPv6 overlay / IPv4 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn -6"
 }
 
@@ -1696,6 +1714,7 @@ starg_exclude_p2mp_ipv4_ipv6()
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1703,7 +1722,7 @@ starg_exclude_p2mp_ipv4_ipv6()
 	echo "Data path: (*, G) EXCLUDE - P2MP - IPv4 overlay / IPv6 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn"
 }
 
@@ -1714,6 +1733,7 @@ starg_exclude_p2mp_ipv6_ipv6()
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1721,7 +1741,7 @@ starg_exclude_p2mp_ipv6_ipv6()
 	echo "Data path: (*, G) EXCLUDE - P2MP - IPv6 overlay / IPv6 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_exclude_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn -6"
 }
 
@@ -1732,6 +1752,7 @@ starg_include_p2mp_common()
 	local mcast_grp=$1; shift
 	local plen=$1; shift
 	local grp=$1; shift
+	local grp_dmac=$1; shift
 	local valid_src=$1; shift
 	local invalid_src=$1; shift
 	local mz=$1; shift
@@ -1749,12 +1770,12 @@ starg_include_p2mp_common()
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode include source_list $valid_src dst $mcast_grp src_vni 10010 via veth0"
 
 	# Check that invalid source is not forwarded.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $invalid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 0
 	log_test $? 0 "Block excluded source"
 
 	# Check that valid source is forwarded.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Forward valid source"
 
@@ -1762,7 +1783,7 @@ starg_include_p2mp_common()
 	run_cmd "ip -n $ns2 address del $mcast_grp/$plen dev veth0"
 
 	# Check that valid source is not received anymore.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $valid_src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Receive of valid source after removal from group"
 }
@@ -1774,6 +1795,7 @@ starg_include_p2mp_ipv4_ipv4()
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1781,7 +1803,7 @@ starg_include_p2mp_ipv4_ipv4()
 	echo "Data path: (*, G) INCLUDE - P2MP - IPv4 overlay / IPv4 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn"
 }
 
@@ -1792,6 +1814,7 @@ starg_include_p2mp_ipv6_ipv4()
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1799,7 +1822,7 @@ starg_include_p2mp_ipv6_ipv4()
 	echo "Data path: (*, G) INCLUDE - P2MP - IPv6 overlay / IPv4 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn -6"
 }
 
@@ -1810,6 +1833,7 @@ starg_include_p2mp_ipv4_ipv6()
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local valid_src=192.0.2.129
 	local invalid_src=192.0.2.145
 
@@ -1817,7 +1841,7 @@ starg_include_p2mp_ipv4_ipv6()
 	echo "Data path: (*, G) INCLUDE - P2MP - IPv4 overlay / IPv6 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn"
 }
 
@@ -1828,6 +1852,7 @@ starg_include_p2mp_ipv6_ipv6()
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local valid_src=2001:db8:100::1
 	local invalid_src=2001:db8:200::1
 
@@ -1835,7 +1860,7 @@ starg_include_p2mp_ipv6_ipv6()
 	echo "Data path: (*, G) INCLUDE - P2MP - IPv6 overlay / IPv6 underlay"
 	echo "---------------------------------------------------------------"
 
-	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp \
+	starg_include_p2mp_common $ns1 $ns2 $mcast_grp $plen $grp $grp_dmac \
 		$valid_src $invalid_src "mausezahn -6"
 }
 
@@ -1847,6 +1872,7 @@ egress_vni_translation_common()
 	local plen=$1; shift
 	local proto=$1; shift
 	local grp=$1; shift
+	local grp_dmac=$1; shift
 	local src=$1; shift
 	local mz=$1; shift
 
@@ -1882,20 +1908,20 @@ egress_vni_translation_common()
 	# Make sure that packets sent from the first VTEP over VLAN 10 are
 	# received by the SVI corresponding to the L3VNI (14000 / VLAN 4000) on
 	# the second VTEP, since it is configured as PVID.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev br0.4000 ingress" 101 1
 	log_test $? 0 "Egress VNI translation - PVID configured"
 
 	# Remove PVID flag from VLAN 4000 on the second VTEP and make sure
 	# packets are no longer received by the SVI interface.
 	run_cmd "bridge -n $ns2 vlan add vid 4000 dev vx0"
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev br0.4000 ingress" 101 1
 	log_test $? 0 "Egress VNI translation - no PVID configured"
 
 	# Reconfigure the PVID and make sure packets are received again.
 	run_cmd "bridge -n $ns2 vlan add vid 4000 dev vx0 pvid"
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev br0.4000 ingress" 101 2
 	log_test $? 0 "Egress VNI translation - PVID reconfigured"
 }
@@ -1908,6 +1934,7 @@ egress_vni_translation_ipv4_ipv4()
 	local plen=32
 	local proto="ipv4"
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local src=192.0.2.129
 
 	echo
@@ -1915,7 +1942,7 @@ egress_vni_translation_ipv4_ipv4()
 	echo "----------------------------------------------------------------"
 
 	egress_vni_translation_common $ns1 $ns2 $mcast_grp $plen $proto $grp \
-		$src "mausezahn"
+		$grp_dmac $src "mausezahn"
 }
 
 egress_vni_translation_ipv6_ipv4()
@@ -1926,6 +1953,7 @@ egress_vni_translation_ipv6_ipv4()
 	local plen=32
 	local proto="ipv6"
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local src=2001:db8:100::1
 
 	echo
@@ -1933,7 +1961,7 @@ egress_vni_translation_ipv6_ipv4()
 	echo "----------------------------------------------------------------"
 
 	egress_vni_translation_common $ns1 $ns2 $mcast_grp $plen $proto $grp \
-		$src "mausezahn -6"
+		$grp_dmac $src "mausezahn -6"
 }
 
 egress_vni_translation_ipv4_ipv6()
@@ -1944,6 +1972,7 @@ egress_vni_translation_ipv4_ipv6()
 	local plen=128
 	local proto="ipv4"
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local src=192.0.2.129
 
 	echo
@@ -1951,7 +1980,7 @@ egress_vni_translation_ipv4_ipv6()
 	echo "----------------------------------------------------------------"
 
 	egress_vni_translation_common $ns1 $ns2 $mcast_grp $plen $proto $grp \
-		$src "mausezahn"
+		$grp_dmac $src "mausezahn"
 }
 
 egress_vni_translation_ipv6_ipv6()
@@ -1962,6 +1991,7 @@ egress_vni_translation_ipv6_ipv6()
 	local plen=128
 	local proto="ipv6"
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local src=2001:db8:100::1
 
 	echo
@@ -1969,7 +1999,7 @@ egress_vni_translation_ipv6_ipv6()
 	echo "----------------------------------------------------------------"
 
 	egress_vni_translation_common $ns1 $ns2 $mcast_grp $plen $proto $grp \
-		$src "mausezahn -6"
+		$grp_dmac $src "mausezahn -6"
 }
 
 all_zeros_mdb_common()
@@ -1982,12 +2012,18 @@ all_zeros_mdb_common()
 	local vtep4_ip=$1; shift
 	local plen=$1; shift
 	local ipv4_grp=239.1.1.1
+	local ipv4_grp_dmac=01:00:5e:01:01:01
 	local ipv4_unreg_grp=239.2.2.2
+	local ipv4_unreg_grp_dmac=01:00:5e:02:02:02
 	local ipv4_ll_grp=224.0.0.100
+	local ipv4_ll_grp_dmac=01:00:5e:00:00:64
 	local ipv4_src=192.0.2.129
 	local ipv6_grp=ff0e::1
+	local ipv6_grp_dmac=33:33:00:00:00:01
 	local ipv6_unreg_grp=ff0e::2
+	local ipv6_unreg_grp_dmac=33:33:00:00:00:02
 	local ipv6_ll_grp=ff02::1
+	local ipv6_ll_grp_dmac=33:33:00:00:00:01
 	local ipv6_src=2001:db8:100::1
 
 	# Install all-zeros (catchall) MDB entries for IPv4 and IPv6 traffic
@@ -2023,7 +2059,7 @@ all_zeros_mdb_common()
 
 	# Send registered IPv4 multicast and make sure it only arrives to the
 	# first VTEP.
-	run_cmd "ip netns exec $ns1 mausezahn br0.10 -A $ipv4_src -B $ipv4_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 mausezahn br0.10 -a own -b $ipv4_grp_dmac -A $ipv4_src -B $ipv4_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "Registered IPv4 multicast - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 0
@@ -2031,7 +2067,7 @@ all_zeros_mdb_common()
 
 	# Send unregistered IPv4 multicast that is not link-local and make sure
 	# it arrives to the first and second VTEPs.
-	run_cmd "ip netns exec $ns1 mausezahn br0.10 -A $ipv4_src -B $ipv4_unreg_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 mausezahn br0.10 -a own -b $ipv4_unreg_grp_dmac -A $ipv4_src -B $ipv4_unreg_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 2
 	log_test $? 0 "Unregistered IPv4 multicast - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
@@ -2039,7 +2075,7 @@ all_zeros_mdb_common()
 
 	# Send IPv4 link-local multicast traffic and make sure it does not
 	# arrive to any VTEP.
-	run_cmd "ip netns exec $ns1 mausezahn br0.10 -A $ipv4_src -B $ipv4_ll_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 mausezahn br0.10 -a own -b $ipv4_ll_grp_dmac -A $ipv4_src -B $ipv4_ll_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 2
 	log_test $? 0 "Link-local IPv4 multicast - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 1
@@ -2074,7 +2110,7 @@ all_zeros_mdb_common()
 
 	# Send registered IPv6 multicast and make sure it only arrives to the
 	# third VTEP.
-	run_cmd "ip netns exec $ns1 mausezahn -6 br0.10 -A $ipv6_src -B $ipv6_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 mausezahn -6 br0.10 -a own -b $ipv6_grp_dmac -A $ipv6_src -B $ipv6_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 103 1
 	log_test $? 0 "Registered IPv6 multicast - third VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 104 0
@@ -2082,7 +2118,7 @@ all_zeros_mdb_common()
 
 	# Send unregistered IPv6 multicast that is not link-local and make sure
 	# it arrives to the third and fourth VTEPs.
-	run_cmd "ip netns exec $ns1 mausezahn -6 br0.10 -A $ipv6_src -B $ipv6_unreg_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 mausezahn -6 br0.10 -a own -b $ipv6_unreg_grp_dmac -A $ipv6_src -B $ipv6_unreg_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 103 2
 	log_test $? 0 "Unregistered IPv6 multicast - third VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 104 1
@@ -2090,7 +2126,7 @@ all_zeros_mdb_common()
 
 	# Send IPv6 link-local multicast traffic and make sure it does not
 	# arrive to any VTEP.
-	run_cmd "ip netns exec $ns1 mausezahn -6 br0.10 -A $ipv6_src -B $ipv6_ll_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 mausezahn -6 br0.10 -a own -b $ipv6_ll_grp_dmac -A $ipv6_src -B $ipv6_ll_grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 103 2
 	log_test $? 0 "Link-local IPv6 multicast - third VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 104 1
@@ -2165,6 +2201,7 @@ mdb_fdb_common()
 	local plen=$1; shift
 	local proto=$1; shift
 	local grp=$1; shift
+	local grp_dmac=$1; shift
 	local src=$1; shift
 	local mz=$1; shift
 
@@ -2188,7 +2225,7 @@ mdb_fdb_common()
 
 	# Send IP multicast traffic and make sure it is forwarded by the MDB
 	# and only arrives to the first VTEP.
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "IP multicast - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 0
@@ -2205,7 +2242,7 @@ mdb_fdb_common()
 	# Remove the MDB entry and make sure that IP multicast is now forwarded
 	# by the FDB to the second VTEP.
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep1_ip src_vni 10010"
-	run_cmd "ip netns exec $ns1 $mz br0.10 -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
+	run_cmd "ip netns exec $ns1 $mz br0.10 -a own -b $grp_dmac -A $src -B $grp -t udp sp=12345,dp=54321 -p 100 -c 1 -q"
 	tc_check_packets "$ns2" "dev vx0 ingress" 101 1
 	log_test $? 0 "IP multicast after removal - first VTEP"
 	tc_check_packets "$ns2" "dev vx0 ingress" 102 2
@@ -2221,14 +2258,15 @@ mdb_fdb_ipv4_ipv4()
 	local plen=32
 	local proto="ipv4"
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local src=192.0.2.129
 
 	echo
 	echo "Data path: MDB with FDB - IPv4 overlay / IPv4 underlay"
 	echo "------------------------------------------------------"
 
-	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp $src \
-		"mausezahn"
+	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp \
+		$grp_dmac $src "mausezahn"
 }
 
 mdb_fdb_ipv6_ipv4()
@@ -2240,14 +2278,15 @@ mdb_fdb_ipv6_ipv4()
 	local plen=32
 	local proto="ipv6"
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local src=2001:db8:100::1
 
 	echo
 	echo "Data path: MDB with FDB - IPv6 overlay / IPv4 underlay"
 	echo "------------------------------------------------------"
 
-	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp $src \
-		"mausezahn -6"
+	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp \
+		$grp_dmac $src "mausezahn -6"
 }
 
 mdb_fdb_ipv4_ipv6()
@@ -2259,14 +2298,15 @@ mdb_fdb_ipv4_ipv6()
 	local plen=128
 	local proto="ipv4"
 	local grp=239.1.1.1
+	local grp_dmac=01:00:5e:01:01:01
 	local src=192.0.2.129
 
 	echo
 	echo "Data path: MDB with FDB - IPv4 overlay / IPv6 underlay"
 	echo "------------------------------------------------------"
 
-	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp $src \
-		"mausezahn"
+	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp \
+		$grp_dmac $src "mausezahn"
 }
 
 mdb_fdb_ipv6_ipv6()
@@ -2278,14 +2318,15 @@ mdb_fdb_ipv6_ipv6()
 	local plen=128
 	local proto="ipv6"
 	local grp=ff0e::1
+	local grp_dmac=33:33:00:00:00:01
 	local src=2001:db8:100::1
 
 	echo
 	echo "Data path: MDB with FDB - IPv6 overlay / IPv6 underlay"
 	echo "------------------------------------------------------"
 
-	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp $src \
-		"mausezahn -6"
+	mdb_fdb_common $ns1 $ns2 $vtep1_ip $vtep2_ip $plen $proto $grp \
+		$grp_dmac $src "mausezahn -6"
 }
 
 mdb_grp1_loop()
@@ -2320,7 +2361,9 @@ mdb_torture_common()
 	local vtep1_ip=$1; shift
 	local vtep2_ip=$1; shift
 	local grp1=$1; shift
+	local grp1_dmac=$1; shift
 	local grp2=$1; shift
+	local grp2_dmac=$1; shift
 	local src=$1; shift
 	local mz=$1; shift
 	local pid1
@@ -2345,9 +2388,9 @@ mdb_torture_common()
 	pid1=$!
 	mdb_grp2_loop $ns1 $vtep1_ip $vtep2_ip $grp2 &
 	pid2=$!
-	ip netns exec $ns1 $mz br0.10 -A $src -B $grp1 -t udp sp=12345,dp=54321 -p 100 -c 0 -q &
+	ip netns exec $ns1 $mz br0.10 -a own -b $grp1_dmac -A $src -B $grp1 -t udp sp=12345,dp=54321 -p 100 -c 0 -q &
 	pid3=$!
-	ip netns exec $ns1 $mz br0.10 -A $src -B $grp2 -t udp sp=12345,dp=54321 -p 100 -c 0 -q &
+	ip netns exec $ns1 $mz br0.10 -a own -b $grp2_dmac -A $src -B $grp2 -t udp sp=12345,dp=54321 -p 100 -c 0 -q &
 	pid4=$!
 
 	sleep 30
@@ -2363,15 +2406,17 @@ mdb_torture_ipv4_ipv4()
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local grp1=239.1.1.1
+	local grp1_dmac=01:00:5e:01:01:01
 	local grp2=239.2.2.2
+	local grp2_dmac=01:00:5e:02:02:02
 	local src=192.0.2.129
 
 	echo
 	echo "Data path: MDB torture test - IPv4 overlay / IPv4 underlay"
 	echo "----------------------------------------------------------"
 
-	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp2 $src \
-		"mausezahn"
+	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp1_dmac $grp2 \
+		$grp2_dmac $src "mausezahn"
 }
 
 mdb_torture_ipv6_ipv4()
@@ -2380,15 +2425,17 @@ mdb_torture_ipv6_ipv4()
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local grp1=ff0e::1
+	local grp1_dmac=33:33:00:00:00:01
 	local grp2=ff0e::2
+	local grp2_dmac=33:33:00:00:00:02
 	local src=2001:db8:100::1
 
 	echo
 	echo "Data path: MDB torture test - IPv6 overlay / IPv4 underlay"
 	echo "----------------------------------------------------------"
 
-	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp2 $src \
-		"mausezahn -6"
+	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp1_dmac $grp2 \
+		$grp2_dmac $src "mausezahn -6"
 }
 
 mdb_torture_ipv4_ipv6()
@@ -2397,15 +2444,17 @@ mdb_torture_ipv4_ipv6()
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local grp1=239.1.1.1
+	local grp1_dmac=01:00:5e:01:01:01
 	local grp2=239.2.2.2
+	local grp2_dmac=01:00:5e:02:02:02
 	local src=192.0.2.129
 
 	echo
 	echo "Data path: MDB torture test - IPv4 overlay / IPv6 underlay"
 	echo "----------------------------------------------------------"
 
-	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp2 $src \
-		"mausezahn"
+	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp1_dmac $grp2 \
+		$grp2_dmac $src "mausezahn"
 }
 
 mdb_torture_ipv6_ipv6()
@@ -2414,15 +2463,17 @@ mdb_torture_ipv6_ipv6()
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local grp1=ff0e::1
+	local grp1_dmac=33:33:00:00:00:01
 	local grp2=ff0e::2
+	local grp2_dmac=33:33:00:00:00:02
 	local src=2001:db8:100::1
 
 	echo
 	echo "Data path: MDB torture test - IPv6 overlay / IPv6 underlay"
 	echo "----------------------------------------------------------"
 
-	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp2 $src \
-		"mausezahn -6"
+	mdb_torture_common $ns1 $vtep1_ip $vtep2_ip $grp1 $grp1_dmac $grp2 \
+		$grp2_dmac $src "mausezahn -6"
 }
 
 ################################################################################
-- 
2.43.0


