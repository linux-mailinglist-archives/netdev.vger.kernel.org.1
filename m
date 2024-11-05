Return-Path: <netdev+bounces-141992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB929BCE2E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB2528348B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031C1D5143;
	Tue,  5 Nov 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CCKZS5Cj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F31B3951
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814091; cv=fail; b=pM8kH/H9gJ/nEGPTJSxRybkjSp8jMSEvoPk9j+UYFnfW5V5z3lAtYKSX+2Xmbkwctxe4yRBLd5MsEcpy5UWUcOlxjlwbnoz4qgi/V2Q2Li6A3c/GbIxpXVjqdDu6VJKlOUAYTBE9w2FYWgG2QV/rGzqc0TdWuY6bCrdYe7qgVoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814091; c=relaxed/simple;
	bh=zAwkrG/n1aOCwaDvs3B7Yj0PtRZnBZmGRSyVJKE0NFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uz5JDbdEbdoFdQLrcN2AHtBpF2C0mmcB4RMG7O81jUGBwTrKfKGpfKL3/6e0V6fDB7w971uxy6MfozzgME65UPVS4d+FXTepHDYXBhSDW0KMthYNaF+f5i9aMUPk9Va3irZMdWSj1dgMt/4r6iZPE+LmqhdTw8GULJNaAsbxy0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CCKZS5Cj; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oou307H5WrbXCiSX0DmZWc9VHwQLXc8sj1a7A4v+xCYYgT+0RMVdoST3XxhJeCB21hEhNfrTlrtUnF6In7ts9WVmdVdygFoBuwp9dCds97ML1WIyXLXZdSwesuGzyAo82uK8XjM9SWc5CdjtS30HSyXD1byfiyyN6kTizO3E2LQh9U8PW/PvNwrqBWW3d2cRrx9YqtmXOQsD9ESmaPvbLUWrmNSnhpRTatqDN0Z1bFVecLHuOsof5EOz17cABll7u9Tdo0XVAIoV55ij7ubmkhxoRN3tXO1ymKnIpF2t2K9R/untYyKO5/ep2xJa4AMyH/yyBr2c9zcBAtehgoyfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvZo0jLiRBX/cnS6N37wof/eFhQFWfKjGMfWyLF+2eU=;
 b=pYeLubZvyv4rEd6iN5yPj3947HrrJscE1t4fhWSgJQHw6TyF/qgUjX+HOXNQ4iOdkuQ2rxX57Hq6YBl2TsV8KP2ohEW2uYhI8rw49noFW9TJV5MeKGKAuELLmKx79SydJLNuEsiEmJmnyq3FuWqyaaksR7NRsICKucSpbxvBbVefcsHKpMBZLjx8/Gv6pxBXBlIvy6jGf0lHg5Ojg2MbtX88OwuXk76ihy/boevAQl2ONcWjhgCA97gvizxKKXwT4epAFgREbNiqlBWXMNAqiGlRygn0EsYPFrWgLwRFx3woha2sWP2EWAJOId93EJ4gv3KxW03PZChpRenLfn6OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvZo0jLiRBX/cnS6N37wof/eFhQFWfKjGMfWyLF+2eU=;
 b=CCKZS5CjyJAMcubaIaM9/UyVdk7krt2ZNSUbb5KN+WusX94G3p4GyPd0yI2J9hJlVNPMLQXyMwW/C/P/tbFru/D8grtQ/qL1Yf9LgBz6FufTtc8NmEpcLRq3e5FtAdqqEw5GQ91N8jLmYHuTE+Gi3lblN2RCqbfbKeu+wlwWP94UpK0ZCn+ZSjYboNZkzozyT8LdLIVXeS4d0j1Nh/xord23HYKf3lv0ecdqUEEvbsNUMPVz8RuhnVo6NROilE4MA9ACZB1HnGMzXlqJ0GTRTSwTWo746itVJq0vRSXE7p5FVcfMukspK7lHoW9Ua8Kicde8m7Naj2boX270qu3ONA==
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 13:41:24 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d8) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 13:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 13:41:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 05:41:11 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 05:41:06 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<horms@kernel.org>, <petrm@nvidia.com>, <aroulin@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next] bridge: Allow deleting FDB entries with non-existent VLAN
Date: Tue, 5 Nov 2024 15:39:54 +0200
Message-ID: <20241105133954.350479-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: e3acb4c8-b146-43d9-7794-08dcfd9f8a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+CpS5Gm2CzqPQawwEJCE151YHNBlEnKPNaTY6zX5d0rCmpEqLAiMJP7rrfQ?=
 =?us-ascii?Q?21qoAhw5ft8DXbu09iKQyJWrtuzOWb+vt6fot4nMtxkmx38R/i4iaRJnonY/?=
 =?us-ascii?Q?bsxDpB+zelFw3bk+XrRlOZN+nzFKczDCDZMhLY8be7Cv7V88HIOZZyAMCRTr?=
 =?us-ascii?Q?iKRgst6CeYB2Ed5P7T4+7+ldC2r3lmaRgaz5OER2nae7/zHkuTG1A+3T4uBL?=
 =?us-ascii?Q?ChNYiBjSlOoioVRFN16teDxQQNwtq79TUFJyKpwus/W4MkJrNm+jqPgLy7tE?=
 =?us-ascii?Q?YaXB+FzLbQ76pCkcDZ3t/K0YabXt8dHz6ZOkoOWHvmK+dtZC50Qtw6WI9ns8?=
 =?us-ascii?Q?GvL9ovW9z8sXnC5hgsKNh9/gjmQBX1xpS+b/NfXdLYx9WDrfSuXjTyo1KNDM?=
 =?us-ascii?Q?nTHIJeElTpSmufRH3dYDuUn8fps4NIKf7+51dp5e8a69XSSUMiYDX1A4iiLI?=
 =?us-ascii?Q?29OupGqEFxLriwYOM60tf0zO7QfmOiKaS5+p6hAU3gjGdfkbfpII+doWg9wX?=
 =?us-ascii?Q?9pJt/yXs1Jeb8mbFBj0S/6VFiR/LGRrypzPAn21DD+6FkxXWPKeG2H1V0kux?=
 =?us-ascii?Q?ZMe8262X23W6QDDktEGnKd5A6OJ7B4wbG2Rp2qcz+glSJnXoTot9IpBiT/hm?=
 =?us-ascii?Q?L1Ma63Y0vg7MazZi4RbdsDTVSKZ0CZxoEa60RUycT+ibPFCdqhF3H4GUqhFk?=
 =?us-ascii?Q?GVFRJRUfsLx7/DaDs3fCUQzE1wGa6bsVZeSZxfSZzzY3keZheNXL72Lqx/S9?=
 =?us-ascii?Q?Eo4vRFFIwbRyLeNbQMIJm1nR5viahpB0c5w4O+FnTVL8H887Vvlonm9ntbNM?=
 =?us-ascii?Q?UOLFwrn/dO3bwjDjFkE0XBk5FrUmk+9BPdjf6dHpHhf08HRVMUI7oSF5rot5?=
 =?us-ascii?Q?wZsrQLzEwIfrQ+evi1Kk37Uu+yKJrLD2gwrArcG+Ho+7gJ11GeRkrfLYZSgn?=
 =?us-ascii?Q?jRxHVuf/ZELurbKJGT2qqBJh+BEt8JBcSZDtiDOqUPzW8uCUPdmacae5h/Sd?=
 =?us-ascii?Q?WcoVYoujPxRZd7iWtdEZMlMXLXMDmaz6urdSOQ68JiUcvfHU6cXZ5u0j0CbK?=
 =?us-ascii?Q?mKc9mlQ6ueSNDw1lk5qRGnNC8oq2EmHyk5clO+PI53Ux7CiAinMuQSnH4MT+?=
 =?us-ascii?Q?f+PmpPfC6jzkMyk5a8JJke1UHKVsYDTfVlpOSXGCDLboJ2nIVJdgZ0AUk/hI?=
 =?us-ascii?Q?Kz09elIdF1ga8wG0vO+qCHus2ytfOIYGLQCidblOorimz9EDL6uge04JOWdk?=
 =?us-ascii?Q?a6GAsK6OtYCglFftdrvin78SzN1qezBocGbJCXcc7pNXFHrSIMCY22qLLoqh?=
 =?us-ascii?Q?iWtKKGA4tw3yEMEzmvNxzfC1mYzBNoWZ3frq+Vb0EjGgJCIz4hej2n8iwQ3d?=
 =?us-ascii?Q?dZwTfCC+6+XsygCIxGOFsm/e/9DZjB/x+JLorVQGpi8hJRuY6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 13:41:23.9958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3acb4c8-b146-43d9-7794-08dcfd9f8a51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140

It is currently impossible to delete individual FDB entries (as opposed
to flushing) that were added with a VLAN that no longer exists:

 # ip link add name dummy1 up type dummy
 # ip link add name br1 up type bridge vlan_filtering 1
 # ip link set dev dummy1 master br1
 # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
 # bridge vlan del vid 1 dev dummy1
 # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
 00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
 # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
 RTNETLINK answers: Invalid argument
 # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
 00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static

This is in contrast to MDB entries that can be deleted after the VLAN
was deleted:

 # bridge vlan add vid 10 dev dummy1
 # bridge mdb add dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
 # bridge vlan del vid 10 dev dummy1
 # bridge mdb get dev br1 grp 239.1.1.1 vid 10
 dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
 # bridge mdb del dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
 # bridge mdb get dev br1 grp 239.1.1.1 vid 10
 Error: bridge: MDB entry not found.

Align the two interfaces and allow user space to delete FDB entries that
were added with a VLAN that no longer exists:

 # ip link add name dummy1 up type dummy
 # ip link add name br1 up type bridge vlan_filtering 1
 # ip link set dev dummy1 master br1
 # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
 # bridge vlan del vid 1 dev dummy1
 # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
 00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
 # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
 # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
 Error: Fdb entry not found.

Add a selftest to make sure this behavior does not regress:

 # ./rtnetlink.sh -t kci_test_fdb_del
 PASS: bridge fdb del

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_fdb.c                      |  9 ++----
 tools/testing/selftests/net/rtnetlink.sh | 40 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 1cd7bade9b3b..77f110035df1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1319,7 +1319,6 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 {
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
-	struct net_bridge_vlan *v;
 	struct net_bridge *br;
 	int err;
 
@@ -1338,14 +1337,10 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	}
 
 	if (vid) {
-		v = br_vlan_find(vg, vid);
-		if (!v) {
-			pr_info("bridge: RTM_DELNEIGH with unconfigured vlan %d on %s\n", vid, dev->name);
-			return -EINVAL;
-		}
-
 		err = __br_fdb_delete(br, p, addr, vid);
 	} else {
+		struct net_bridge_vlan *v;
+
 		err = -ENOENT;
 		err &= __br_fdb_delete(br, p, addr, 0);
 		if (!vg || !vg->num_vlans)
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 87dce3efe31e..6e216d7a8e2f 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -25,6 +25,7 @@ ALL_TESTS="
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
+	kci_test_fdb_del
 	kci_test_neigh_get
 	kci_test_bridge_parent_id
 	kci_test_address_proto
@@ -1065,6 +1066,45 @@ kci_test_fdb_get()
 	end_test "PASS: bridge fdb get"
 }
 
+kci_test_fdb_del()
+{
+	local test_mac=de:ad:be:ef:13:37
+	local dummydev="dummy1"
+	local brdev="test-br0"
+	local ret=0
+
+	run_cmd_grep 'bridge fdb get' bridge fdb help
+	if [ $? -ne 0 ]; then
+		end_test "SKIP: fdb del tests: iproute2 too old"
+		return $ksft_skip
+	fi
+
+	setup_ns testns
+	if [ $? -ne 0 ]; then
+		end_test "SKIP fdb del tests: cannot add net namespace $testns"
+		return $ksft_skip
+	fi
+	IP="ip -netns $testns"
+	BRIDGE="bridge -netns $testns"
+	run_cmd $IP link add $dummydev type dummy
+	run_cmd $IP link add name $brdev type bridge vlan_filtering 1
+	run_cmd $IP link set dev $dummydev master $brdev
+	run_cmd $BRIDGE fdb add $test_mac dev $dummydev master static vlan 1
+	run_cmd $BRIDGE vlan del vid 1 dev $dummydev
+	run_cmd $BRIDGE fdb get $test_mac br $brdev vlan 1
+	run_cmd $BRIDGE fdb del $test_mac dev $dummydev master vlan 1
+	run_cmd_fail $BRIDGE fdb get $test_mac br $brdev vlan 1
+
+	ip netns del $testns &>/dev/null
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: bridge fdb del"
+		return 1
+	fi
+
+	end_test "PASS: bridge fdb del"
+}
+
 kci_test_neigh_get()
 {
 	dstmac=de:ad:be:ef:13:37
-- 
2.47.0


