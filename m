Return-Path: <netdev+bounces-39565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE967BFD3B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706C61C20DF6
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269DF4737A;
	Tue, 10 Oct 2023 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fhYuck38"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244445F67
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:22:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D93B0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMpi0n2vxHyeg7XzpFLH/WZYi2T4La+8zwkfvUizp6RuUk+7uw/RkYvc5FuRBkM4h/QB6q3Vv/cmmKvnHY1EIpa5sd7ehuU7zbUgKfPEsmn8jjgHgbdaU7seNT6PAcbf72nQJP3xPlQJnYRR2ceEnUBXoq9Q+e+AJYEzFaF6s2suDRV7CoI0ZkLAR9VIdSWhJXEZsEIe1y3b93dJqYarCioa+xkfWkECZ9j3pzFcMX7LEes3RGjKzXRj76MgVEwt6Uy10sM479+QmzOVaNDTevSzMO9uyDXKz69nlWAR5J2S0nO+s0n6iYyW9uiCw3VzOa6lsUbAI3+kaBGd6SnNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N9m6fCc5YwOali2jETsn1tAC4Z7Xj+0sofk1Y5UHTo=;
 b=hSTYYYOH6+xBNZ47n9K1uGBA2M4BgFf82At6i3xJRksyxHbDIP4Qwka9ZxOgl9sSUlDWG0cWyWBpMIfFiI/OxJDBIqmgwMluapt/VjCeJ5LmQAXQZuWT6i45Lj81ysFMV0jSVZrcaW3oxhO1840zg81rfgVwHr0l7w5fjGsHNK7+cJg+4lV7RKNyI1OYuGt/Xg68CTAtwziZrwVYrKVjxyv7+tIvR1d+MRo4yZAVDfUAIyALvYWsyjNldMYp73HJAtK/qvBOx5FhFavDigoNIz1/XBWKziAkZPrJRQYHMFcbffqPnEiYEhhMLZ+jDOVX2kRGA89YGKeZ69HchYTWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N9m6fCc5YwOali2jETsn1tAC4Z7Xj+0sofk1Y5UHTo=;
 b=fhYuck38Hvr7Q88hqphH7mmKjVoCzCnmkYZJAGwBCjx3kkzlZct1zyQWHoU6b7oFV6coHgJVP7fENqmQpg/u7GZyVi6TlNP6R5zay2rsGpCO3LAHQgoHvbeqIDwO++8P9VBCIhnE6E4aheI8grVYOGdA9jZq6wW5I+6Oivhny0VpqVRRi97/LUQfcwUP0dnl+t8RKMlR08LfRw34kCBrs40Zdie61wWgOFghnNXGm1z8Lu8Ehl1pJcm7PQyS5M+BvjaJCWVRtFAP4nDQhVnP2e//O9HrxCpEDvDxua8xsTtkBE4CaqLmICXO9tuSv0SGPEr/lB521cbf7Wm0NVu5Og==
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 13:22:14 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::2a) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 13:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 13:22:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 06:22:01 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 10 Oct 2023 06:21:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@gmail.com>, <sriram.yagnaraman@est.tech>,
	<oliver.sang@intel.com>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] selftests: fib_tests: Count all trace point invocations
Date: Tue, 10 Oct 2023 16:21:13 +0300
Message-ID: <20231010132113.3014691-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: b1aa84c9-1c01-49fd-10f0-08dbc993eb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YRkffeq9XIdWLD36IRYya0XPWu1kC0qnysYzjwV32RxjhKtwRKJAMOQQw84nnxZWytAskjRUFUd02fvjE3ieEDdTQoMSwuCFV1B7wyovJdLIn8Cshnr88FZO88cwyo2rmcuIPFfmBanzbJ9FBwZYxg709vyLLHmPBaYxSVxilAdsbB0XiWne4sRxNX+0w2h+8XIuXX3Mqe4EUwlrtJ1SjbzgXRxqQSfc6ABe3XH2TdihqOCtquzeVCOipIv7NCiy/EiFpbG38h1gHAJ+qxY4DTsvtdPj1i8eyZ4pjNn1EDxqLl2WazJmSgBkBkT9Ih3d36XEPJ48DSdyJ38DtLxKEm6AjSmUGvx72NaWKZFmgqHuYtDpwoth/P18krrF6MhsTEIAVDTawGsxtV2+pWtOUF+hrdEN3DZN36cozqdPYBhXgOIfIaq/OMROfGhO8E+XA0OEo55pS4PiB+6ILYbwR/7GhfC636qoFGaXF4QBphi4JCoAEeVkgEFIeaBJf8lWzpfxTJgFQXT7d/SP+I55qHPVMUYu3ipdJw3CkCsbZ0ml93dUPps4wLAVCDejOe2eShrYkpYQrQIPyss/9H6kPXzV/jW1007gUW+UAtjZK7OS/6kH5aDCtfR0dEN+XhpCw+NqcERIqmXqh6QlhOXvaItEm9CtN5Uv2kTLTna0+RkQqVp4nyMOOHLc0wi9bBHrkv3jPRtcCyvhT9hGrdkGVLFZDm9GlnMc5nNvPnZBnj+kwKr7dBznvMo69+Yj5DBtPU7Xq/alAcfTS1VoEhCoz/r9EFSlVWvray5mAVjT2SY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(2906002)(82740400003)(40460700003)(2616005)(336012)(1076003)(107886003)(426003)(83380400001)(16526019)(47076005)(36860700001)(316002)(26005)(70206006)(6916009)(70586007)(54906003)(4326008)(5660300002)(41300700001)(966005)(478600001)(8936002)(8676002)(6666004)(36756003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:22:14.4066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1aa84c9-1c01-49fd-10f0-08dbc993eb2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The tests rely on the IPv{4,6} FIB trace points being triggered once for
each forwarded packet. If receive processing is deferred to the
ksoftirqd task these invocations will not be counted and the tests will
fail. Fix by specifying the '-a' flag to avoid perf from filtering on
the mausezahn task.

Before:

 # ./fib_tests.sh -t ipv4_mpath_list

 IPv4 multipath list receive tests
     TEST: Multipath route hit ratio (.68)                               [FAIL]

 # ./fib_tests.sh -t ipv6_mpath_list

 IPv6 multipath list receive tests
     TEST: Multipath route hit ratio (.27)                               [FAIL]

After:

 # ./fib_tests.sh -t ipv4_mpath_list

 IPv4 multipath list receive tests
     TEST: Multipath route hit ratio (1.00)                              [ OK ]

 # ./fib_tests.sh -t ipv6_mpath_list

 IPv6 multipath list receive tests
     TEST: Multipath route hit ratio (.99)                               [ OK ]

Fixes: 8ae9efb859c0 ("selftests: fib_tests: Add multipath list receive tests")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/netdev/202309191658.c00d8b8-oliver.sang@intel.com/
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 0dbb26b4fa4a..66d0db7a2614 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -2452,7 +2452,7 @@ ipv4_mpath_list_test()
 	# words, the FIB lookup tracepoint needs to be triggered for every
 	# packet.
 	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
-	run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	run_cmd "perf stat -a -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
 	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
 	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
 	list_rcv_eval $tmp_file $diff
@@ -2497,7 +2497,7 @@ ipv6_mpath_list_test()
 	# words, the FIB lookup tracepoint needs to be triggered for every
 	# packet.
 	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
-	run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	run_cmd "perf stat -a -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
 	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
 	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
 	list_rcv_eval $tmp_file $diff
-- 
2.40.1


