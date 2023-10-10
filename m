Return-Path: <netdev+bounces-39563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F467BFD39
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15E5281D18
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521747342;
	Tue, 10 Oct 2023 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YHubY3Qc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8945F7E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:22:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7D3FB
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4/baHxHABK3ERuJcaZTcrbwX52Kozu9kcrjOWG++QCvFfeJOlb2ZoJRGKZKFC3Bk3+Oaw+xCv5YJWo7izB+Wap21kxWAkQD3A3KUVSE6oLiomihDzAsYZP5wr/sf70i/wJQUVULvae84uDhnYhf7uLeLzL3dW4nbnVvlHD9FG0SQqNTbaoLlMIOwxfioIJ35R+QHhDJaYbZjmv5DruCvbFWQXRv2jZIM5uTuClzy+nzSPdh/XJXq+sE7qn3jQ1vnYZNOG2RhaoKF2Ug+SbcIxT0y/ZwuO9aqKTk2/0X8YwFIHdm574doe03xWNfDd5aQ2jAwDEoXZLZVmK+oM5pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx0A0uhpyy2cVvtmpLbUDaxpPOqziDwPkPwNe/C72DA=;
 b=gpLM00DEDmjRwO/pDb7ecVwyMS0R91jTCP1sbIEC/TLmU0ygwmc6PycExQMG0NCShZdjiEaPdLNdY+Ab/Mmx0YQPu5dxPR1TXOOGF9kFEufmf2bxai1kfG1x0LEZOpy/knxOIY4CuMTEl/zo0lZlsJl9dMA6ZvR6oievQaS6wXf7sNQovR0yOShN/pvk+4nSO1AWyu6OQ/dbJmQuktLAQNDPdQuVkwCHVx+syAvxM4mpzgySkJZogpl107YuvZCwSIqPdnUWSsgv4W6K9+GuYvwOCl2QouGHTgrQE9GE+GmWLupFrXrOZ4Q9qC1m92YBpaSYmzo74BNdzOtP6HVt4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx0A0uhpyy2cVvtmpLbUDaxpPOqziDwPkPwNe/C72DA=;
 b=YHubY3Qcs6GjibpIRYT5CEgm9ucwQc51qGryHEU2HVk3rRfc/dS2wJXgbgZ9RvStv8L4+FHUnELGROleX6eeMFWa2qekebALWzjH5FnZjiblpN/f2rroASljSzbdqOFxb71vRqZBNKWtJZ7m6aSqBadEtSKs7IzYUKZVsjiITrU3+rT6tf0jwqpw6gKHUn/7v6s6vHisaQ9dhRTPoeX6NCT23B7iCTotuzg6+LVdJLGVLuLBKSNEeHJ78cVYpgEZSdDymK+F1Dia9dVf/eFVmJznAZlg+j1wZbKhTHsTn6hmgIQt6/ORcRYifC47VLBQR2tCVR+amY3DpbupZ4bPxA==
Received: from MW4PR03CA0210.namprd03.prod.outlook.com (2603:10b6:303:b8::35)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 13:22:11 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::a0) by MW4PR03CA0210.outlook.office365.com
 (2603:10b6:303:b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Tue, 10 Oct 2023 13:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 13:22:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 06:21:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 10 Oct 2023 06:21:56 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@gmail.com>, <sriram.yagnaraman@est.tech>,
	<oliver.sang@intel.com>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] selftests: fib_tests: Disable RP filter in multipath list receive test
Date: Tue, 10 Oct 2023 16:21:12 +0300
Message-ID: <20231010132113.3014691-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010132113.3014691-1-idosch@nvidia.com>
References: <20231010132113.3014691-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: e42f2e2c-b94a-4419-4b39-08dbc993e983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O/DAE9meXNFvNzQb/GlA2kGOr20NWdW3mpGRdyGQfFttfBr1J6tmLNRNk+9DK6gzlZnqOm1MWbIz+Afl4lh+nk4Ci29rPcKk6svp2eKR73pDQzf7dJQaDVgL4u4gRj/lo35PJQYM/leavj9uyYv2x4Rex2fymXO7v/2/e4ULfRnMMM8+90jKhdwKWqOxfJgGyz7tAKpZeQCBBGogF0/a6NjJsQxf4NNalFxDR+Zk2DB6vw4Sxo6GyV/5gBNj7d2hCCIj0MnNoWjRBPIQDXUs6gyohPMNxNaAt84X82du0oGGsDisp+ZtnhUCJvcb++HqL3xwP4SIcKvdBYfSAGbbD7sp6gSP22XYY9ooDZM/4pCvyMtzdovGiV2wJzfzDIuySKiNpHzqxNbaRw+98Ob6pEcStr3+edrZhHUynsDkXRcdg8wOdIllEASAznt83XP7EuS5yhwp0x9YaCVxpFSsADsyrknVdBnVQ6j6ZobAtn6nL6G8Kf+8Ld352dDYmIAlj4LmBMm6NvG4rcx69+yRsS+noqaj0hmoeC41DWsCTdbS6pePK+bpTDQC14Hj6BM9ZqUWlay/4ikjwyydtZbJtjoI1urSR7Qexk0GU0qe5m+yZnl9Uj2k2IzINjsp50ohnVa0oHKM8+6JvtvaVUZayWlKcMnsIG67XRcjA5cPf1itxlsZcMZlsOd1UGoFXX7XFFxrNdQNvC8u2Tr0GjagORrFDqMS4luJfvRRltAxQ0RSoK7F/eCocac2f1kLJ8La/aPgPCEjjmmfpySRtBlE4w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(26005)(426003)(336012)(1076003)(2616005)(16526019)(36860700001)(41300700001)(6666004)(47076005)(8676002)(8936002)(107886003)(2906002)(478600001)(4326008)(54906003)(70206006)(70586007)(966005)(316002)(5660300002)(6916009)(82740400003)(356005)(7636003)(86362001)(40460700003)(36756003)(40480700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:22:11.7190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e42f2e2c-b94a-4419-4b39-08dbc993e983
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test relies on the fib:fib_table_lookup trace point being triggered
once for each forwarded packet. If RP filter is not disabled, the trace
point will be triggered twice for each packet (for source validation and
forwarding), potentially masking actual bugs. Fix by explicitly
disabling RP filter.

Before:

 # ./fib_tests.sh -t ipv4_mpath_list

 IPv4 multipath list receive tests
     TEST: Multipath route hit ratio (1.99)                              [ OK ]

After:

 # ./fib_tests.sh -t ipv4_mpath_list

 IPv4 multipath list receive tests
     TEST: Multipath route hit ratio (.99)                               [ OK ]

Fixes: 8ae9efb859c0 ("selftests: fib_tests: Add multipath list receive tests")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/netdev/202309191658.c00d8b8-oliver.sang@intel.com/
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_tests.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index e7d2a530618a..0dbb26b4fa4a 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -2437,6 +2437,9 @@ ipv4_mpath_list_test()
 	run_cmd "ip -n ns2 route add 203.0.113.0/24
 		nexthop via 172.16.201.2 nexthop via 172.16.202.2"
 	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
+	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.veth2.rp_filter=0"
+	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0"
+	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.default.rp_filter=0"
 	set +e
 
 	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
-- 
2.40.1


