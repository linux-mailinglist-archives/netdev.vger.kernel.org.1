Return-Path: <netdev+bounces-183778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA86A91E5B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C7019E7934
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474924E004;
	Thu, 17 Apr 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D1FzhQzV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA124BBE8
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897460; cv=fail; b=nrAGSGq9JniEDbre/51kmB75PJOqx1L9auxFjGczcqjQeoMLOsr6lUH+VzmSbYAv3U2gXqsMk69QaXQKNPLWwWENpg2eBOLvSk0bWrqA8hJqEsykIGj31186DRMgmIAWSQcJ3PgjOufLzWg2IKpvzLtlC6P5zpQ2PHTJ1KmocWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897460; c=relaxed/simple;
	bh=BSIagurI0DK9WTHz0vsXFzdlYe0koJwtpjnwXdRThKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRhC6uxoUmgajBquKOpJhUBl9JMKLDCP8J+mtOD4Xvt+ypIP54HGVLbwDAdStihf0EwBcfZFEUsupMkfBnm0V6E4rKczaYbL4ham4/yOzCy8bsOU6TFrt10zPSGFI1+wOn16WAhwBT2Gd5Qw94JtNVlxgmHcEAv3ngsqRV/gW1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D1FzhQzV; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfePWdWrlTrFm8CgwsMRzb8fPLfZNFFbPuUvcewMOlaQaEye6mgODk+X7Q6b+ZnDUQlQJNMPhphJt9QQqCs6MT7yHlYmGYKjG3j3d5hepD1m5/uBtwNf/6tXnK9JYYcCD/l91tKSCh3h2Sg1WYN9W0zBGHrrC1BWYEZkFBj2RJMqVwpIt1f/YhJqFjqQnJVKDjJhmwSPgW70tCU96FwDuVZWk8qp3GalVVtL4z2Aj00JJ5YoFlVUgUiGvhdGOUszYdJLEW3ajWk9IeUUEwvMOmtL3s1GBWZPhYUGojH9em6J6MzFZab/6rR2sQq70yqT7VGyw3ZMZMrLw3VUgShhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+N+hxbWXSrTpYTm4TRWvDQrj/0LGE9dJgLFZQgjzzw=;
 b=M6kxvD4BnS7qdRvpqhTRQheAeX+329w0Th5JTax/ehgdigqanP9Q5NUEgM2cog39WAeVob2VPHBLA65LlcUrhMVB2g6YIomJCBgPpPI4UuYlqfk9HrwseO7i1kP/cyIxjFodL56tuky/Zr7pyLJqT1P5uzUwjXykXnW57Y13UoNan421QtFG0H55WkhbI5bHEjm+OGgWP9O0A161/e4gEQE28fIapoAbycbbTn6C+JyD7aThKMcBQft1hcKoS3cavZ0yGbIlNKEa1o3OJ6gR8M4AdVfPUTLGHTmhpJcTTpJG20K3qX3vejPA0iBZWr26i0+e18ImGu20xpTO6pIU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+N+hxbWXSrTpYTm4TRWvDQrj/0LGE9dJgLFZQgjzzw=;
 b=D1FzhQzVi0dLpWQZUPBGwzcHANtmjXjGNjQzXkdZ1KYf+mFrxqhzvYj/9xGqhBEblP2MwGLgctaDCXhV0zzP2gAR5tDDCrSdDNEh8yubphP+zsXfhdUJc+d2hOWX9Wdbg+YhJHfbiOZerZXgwJO9idmDgb4QbHUmM4+qhZjLEeXtKFXrCCPAGtKy5SEXH5+V+0BP5tiabhdpxBf13wx/pCr/KGbs8lK06EtJ2HJl4nQzU874t4y0yL7n69RLVcJPfyCEi3tG6/ToDiKfQ07/vkdhhFIkc0xDwbQYzGP2J/5Kby4tfzQWWWSUTroHZ6VtY8OESYDod7DEl/oIcBrpvQ==
Received: from CH0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::20)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 13:44:13 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::d0) by CH0P220CA0025.outlook.office365.com
 (2603:10b6:610:ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 13:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 13:44:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Apr
 2025 06:43:57 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Apr
 2025 06:43:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux.dev>, Yong Wang
	<yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/3] selftests: net/bridge : add tests for per vlan snooping with stp state changes
Date: Thu, 17 Apr 2025 15:43:14 +0200
Message-ID: <cee6216f125ea6c829e22c879b47a47c14db9af7.1744896433.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744896433.git.petrm@nvidia.com>
References: <cover.1744896433.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 465091b6-569f-4288-530d-08dd7db5efb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nqCGMeULeg7YgXgR7d2kNWzHcDCO+3pOPZTUMhFwJafT1PeR3BHmM+XZ8zbs?=
 =?us-ascii?Q?pO8U2CFNT0+d7CyID0jGsUfI7eFIqCLQkIsWQb0PLuc0ELimZDVAec0sjZkZ?=
 =?us-ascii?Q?xNp58Z4v2LRjZkHPxFW98LfNx4t0LzLPFv17ckd6HKXOoiKrYN839o9h01Hh?=
 =?us-ascii?Q?y0lWFyUHck5vzGZnQ9CbxnJOFpNmBPCt9aBR/ttY1DvOHKhrxNhbzq0+Koxs?=
 =?us-ascii?Q?/vfF3cJ843I+yF79TMRoR77y8Cb9cjLa3xSL0BhroP1Rv/4IVdUcmwxMKDEv?=
 =?us-ascii?Q?qZbXVm0aVaxWyeMVs3HhZJUzArtIghVW1Pn5oOJ3Ad3wsCeQSTJtJfkP3HBl?=
 =?us-ascii?Q?YznARLVDGuIYCOUDCqUvpNAmGPe/51QtAC5x6FVPfgQCZ+qu7/28zUD4qgwo?=
 =?us-ascii?Q?B9qs3+hud5wxaAOfl03HQbmHB0FftAbZbsjCjdpyPO7voSt1mYmZvCN2Dyih?=
 =?us-ascii?Q?7XjTh2SIG2s7EiF0IV574NePE5jpzcioTH7jwvaNj0tli5uudPGSENqmOgto?=
 =?us-ascii?Q?RTPJYn2NIE6f0kgc7ZswdtSKZ92F/k3L1/QFuzzuGjpv+y92CvNxeOhyUqdw?=
 =?us-ascii?Q?72tqLjwxU9VXCuqDAjMnwKg5L154VFvebwzFlALS9v9GgsOd+fvb6Gc5QMzW?=
 =?us-ascii?Q?lkCBzZBGq5H4GGN0GnKzxjpWqw21Vg2eQvQ3/VJ9vNgCZJK2ytZkIv1hX+uF?=
 =?us-ascii?Q?OdKte2+3fK1oX4NDlNgbJE3+MDPP9zb4FaV1CoLg2pmKVvB3RdfT/O65tSlx?=
 =?us-ascii?Q?RKv8YfE1OY6pysxwjiNIwn13tk9OihNuPrv7m8xJ7yQjjcyqt8BAHY2oupDz?=
 =?us-ascii?Q?SKx+yyUNkk3Ek4/Rl3v0vVMOtSgdbVGgESPhdEw21APddCY59TkigmwWKlBg?=
 =?us-ascii?Q?kTdnWz1Tuoy4R/ecbsvKfGMB+W6M11X8UhiY1lNGjACmGi2nAmfYq/nDcMGw?=
 =?us-ascii?Q?bQHfL8tOajIGv5TwZiXY28nBqxAcxreLaJ4ilcEBUbnOVuJmBllqiqCbA12I?=
 =?us-ascii?Q?D5TUnvXsy3ReMVP5UddsZou2Q+pWWK5LBEY69xz565fn+DaHpwqhn41QW5Wk?=
 =?us-ascii?Q?2xApX/Het6+jnUjbOeACMT1w/o9fG3k+kOP8u9tzlEETncGRRywJHX7vzRZ2?=
 =?us-ascii?Q?m4Zjgr5TBawgpuoI38W+WHBc6dbGOS1hM1kYfqzLxT/hebJDudd9kY+os88o?=
 =?us-ascii?Q?lwbG7I2eanYdSJbVsSig12T8ga5EEE2eV1jZ9YU5M4+ot0Q8H21xW2nLL0L9?=
 =?us-ascii?Q?37q8xqctAYZveSAV3nkKIlEkds7YGUbSyXmTm2Qb6+6Pta+96wW2TxrQgCJi?=
 =?us-ascii?Q?svxENZ0jORVrRTx5QPQxuejiWi3sib+gdFnnOwk/Yi9ex1VGNZ+iq3gdyabZ?=
 =?us-ascii?Q?664tpdZWTHp2cWennkV/sANexClVpAU0/Ya2ddogkyQV+uBEMnxtDLhZpDim?=
 =?us-ascii?Q?d/m0e5yxtIO5P5+RHbvrE0EO+pPniDFfMtSSnH2uNOYFE0JIrly1X4KcaYa0?=
 =?us-ascii?Q?HjOVF76ULitabQPCqfdvfqu7UeHGViZtLwsg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:44:11.8956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465091b6-569f-4288-530d-08dd7db5efb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874

From: Yong Wang <yongwang@nvidia.com>

Change ALL_TESTS definition to "test-per-line".

Add the test case of per vlan snooping with port stp state change to
forwarding and also vlan equivalent case in both bridge_igmp.sh and
bridge_mld.sh.

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/bridge_igmp.sh   | 80 +++++++++++++++++-
 .../selftests/net/forwarding/bridge_mld.sh    | 81 ++++++++++++++++++-
 tools/testing/selftests/net/forwarding/config |  1 +
 3 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index e6a3e04fd83f..d4e7dd659354 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -1,10 +1,24 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="v2reportleave_test v3include_test v3inc_allow_test v3inc_is_include_test \
-	   v3inc_is_exclude_test v3inc_to_exclude_test v3exc_allow_test v3exc_is_include_test \
-	   v3exc_is_exclude_test v3exc_to_exclude_test v3inc_block_test v3exc_block_test \
-	   v3exc_timeout_test v3star_ex_auto_add_test"
+ALL_TESTS="
+	v2reportleave_test
+	v3include_test
+	v3inc_allow_test
+	v3inc_is_include_test
+	v3inc_is_exclude_test
+	v3inc_to_exclude_test
+	v3exc_allow_test
+	v3exc_is_include_test
+	v3exc_is_exclude_test
+	v3exc_to_exclude_test
+	v3inc_block_test
+	v3exc_block_test
+	v3exc_timeout_test
+	v3star_ex_auto_add_test
+	v2per_vlan_snooping_port_stp_test
+	v2per_vlan_snooping_vlan_stp_test
+"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -554,6 +568,64 @@ v3star_ex_auto_add_test()
 	v3cleanup $swp2 $TEST_GROUP
 }
 
+v2per_vlan_snooping_stp_test()
+{
+	local is_port=$1
+
+	local msg="port"
+	[[ $is_port -ne 1 ]] && msg="vlan"
+
+	ip link set br0 up type bridge vlan_filtering 1 \
+					mcast_igmp_version 2 \
+					mcast_snooping 1 \
+					mcast_vlan_snooping 1 \
+					mcast_querier 1 \
+					mcast_stats_enabled 1
+	bridge vlan global set vid 1 dev br0 \
+					mcast_snooping 1 \
+					mcast_querier 1 \
+					mcast_query_interval 100 \
+					mcast_startup_query_count 0
+	[[ $is_port -eq 1 ]] && bridge link set dev $swp1 state 0
+	[[ $is_port -ne 1 ]] && bridge vlan set vid 1 dev $swp1 state 4
+	sleep 5
+	local tx_s=$(ip -j -p stats show dev $swp1 \
+			group xstats_slave subgroup bridge suite mcast \
+			| jq '.[]["multicast"]["igmp_queries"]["tx_v2"]')
+
+	[[ $is_port -eq 1 ]] && bridge link set dev $swp1 state 3
+	[[ $is_port -ne 1 ]] && bridge vlan set vid 1 dev $swp1 state 3
+	sleep 5
+	local tx_e=$(ip -j -p stats show dev $swp1 \
+			group xstats_slave subgroup bridge suite mcast \
+			| jq '.[]["multicast"]["igmp_queries"]["tx_v2"]')
+
+	RET=0
+	local tx=$(expr $tx_e - $tx_s)
+	test $tx -gt 0
+	check_err $? "No IGMP queries after STP state becomes forwarding"
+	log_test "per vlan snooping with $msg stp state change"
+
+	# restore settings
+	bridge vlan global set vid 1 dev br0 \
+					mcast_querier 0 \
+					mcast_query_interval 12500 \
+					mcast_startup_query_count 2
+	ip link set br0 up type bridge vlan_filtering 0 \
+					mcast_vlan_snooping 0 \
+					mcast_stats_enabled 0
+}
+
+v2per_vlan_snooping_port_stp_test()
+{
+	v2per_vlan_snooping_stp_test 1
+}
+
+v2per_vlan_snooping_vlan_stp_test()
+{
+	v2per_vlan_snooping_stp_test 0
+}
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index f84ab2e65754..4cacef5a813a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -1,10 +1,23 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="mldv2include_test mldv2inc_allow_test mldv2inc_is_include_test mldv2inc_is_exclude_test \
-	   mldv2inc_to_exclude_test mldv2exc_allow_test mldv2exc_is_include_test \
-	   mldv2exc_is_exclude_test mldv2exc_to_exclude_test mldv2inc_block_test \
-	   mldv2exc_block_test mldv2exc_timeout_test mldv2star_ex_auto_add_test"
+ALL_TESTS="
+	mldv2include_test
+	mldv2inc_allow_test
+	mldv2inc_is_include_test
+	mldv2inc_is_exclude_test
+	mldv2inc_to_exclude_test
+	mldv2exc_allow_test
+	mldv2exc_is_include_test
+	mldv2exc_is_exclude_test
+	mldv2exc_to_exclude_test
+	mldv2inc_block_test
+	mldv2exc_block_test
+	mldv2exc_timeout_test
+	mldv2star_ex_auto_add_test
+	mldv2per_vlan_snooping_port_stp_test
+	mldv2per_vlan_snooping_vlan_stp_test
+"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="ff02::cc"
@@ -554,6 +567,66 @@ mldv2star_ex_auto_add_test()
 	mldv2cleanup $swp2
 }
 
+mldv2per_vlan_snooping_stp_test()
+{
+	local is_port=$1
+
+	local msg="port"
+	[[ $is_port -ne 1 ]] && msg="vlan"
+
+	ip link set br0 up type bridge vlan_filtering 1 \
+					mcast_mld_version 2 \
+					mcast_snooping 1 \
+					mcast_vlan_snooping 1 \
+					mcast_querier 1 \
+					mcast_stats_enabled 1
+	bridge vlan global set vid 1 dev br0 \
+					mcast_mld_version 2 \
+					mcast_snooping 1 \
+					mcast_querier 1 \
+					mcast_query_interval 100 \
+					mcast_startup_query_count 0
+
+	[[ $is_port -eq 1 ]] && bridge link set dev $swp1 state 0
+	[[ $is_port -ne 1 ]] && bridge vlan set vid 1 dev $swp1 state 4
+	sleep 5
+	local tx_s=$(ip -j -p stats show dev $swp1 \
+			group xstats_slave subgroup bridge suite mcast \
+			| jq '.[]["multicast"]["mld_queries"]["tx_v2"]')
+	[[ $is_port -eq 1 ]] && bridge link set dev $swp1 state 3
+	[[ $is_port -ne 1 ]] && bridge vlan set vid 1 dev $swp1 state 3
+	sleep 5
+	local tx_e=$(ip -j -p stats show dev $swp1 \
+			group xstats_slave subgroup bridge suite mcast \
+			| jq '.[]["multicast"]["mld_queries"]["tx_v2"]')
+
+	RET=0
+	local tx=$(expr $tx_e - $tx_s)
+	test $tx -gt 0
+	check_err $? "No MLD queries after STP state becomes forwarding"
+	log_test "per vlan snooping with $msg stp state change"
+
+	# restore settings
+	bridge vlan global set vid 1 dev br0 \
+					mcast_querier 0 \
+					mcast_query_interval 12500 \
+					mcast_startup_query_count 2 \
+					mcast_mld_version 1
+	ip link set br0 up type bridge vlan_filtering 0 \
+					mcast_vlan_snooping 0 \
+					mcast_stats_enabled 0
+}
+
+mldv2per_vlan_snooping_port_stp_test()
+{
+	mldv2per_vlan_snooping_stp_test 1
+}
+
+mldv2per_vlan_snooping_vlan_stp_test()
+{
+	mldv2per_vlan_snooping_stp_test 0
+}
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 8d7a1a004b7c..18fd69d8d937 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -1,6 +1,7 @@
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
 CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_VRF=m
-- 
2.49.0


