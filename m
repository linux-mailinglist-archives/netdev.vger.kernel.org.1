Return-Path: <netdev+bounces-25296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF4773B32
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3F5280A89
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36E13FFE;
	Tue,  8 Aug 2023 15:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110C13FE0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533C469F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYkKgCe6v0fvnbPhsj2mzQZmhW7ANCQrkuIBCD6IVIR4T9K+PNUEGul9o/vxzBJVmOM5WraSZd4WU65YsE00NDoGS66/0GACaeDSdIS/uWg1Qgt1GxPs7miIG3gxhpx16m8ePA7LBU80G0La4fJyHn8wS27XV2Y256t4hsRMUzTbz+rhEahx9gO0zthSWW5JsqLtRIcWvm7WSOhC4nHEdzS6gg12i5sEM9hxMOvS8xNPmxkB0Qy06iFLC3/GvQ45ZU4X/CxiwRterzIp/g/kourVGnXDARaGCbZU2KaXpWiYQFqwuTaX3/JQs3atCzX8wgM9qV1J6Dp9I+jw7Ca4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAyjaKdkkSi4w9oUDn5Gji23Sdd6NQwuJmfyh+dK78M=;
 b=NQ0TeW+d24BXF4YUD7YuYnlmV4Mb9M2HQeVGS12b/rwi38/bM6luv7Y7gBVsBR50h0WiawM+yea1sbcY6+7QU9M1Qj373mDi7t7sUxEb0RoLNH7+3agwvF2yYUhrr0fIGEoaSksZMqyypRpyLwKxad/DBCf2eK6HzzypEZLVcxP7X3xgQxs+QkUB4nbWL3dAvQA3jlh7SkWoSypjRY7xsa+heEnTwUxb0f72O/xT9TER4rHMoI5rjPqBcrJ1l37oShXMwEVWtuyIyS40qYe6EpEoUSF3ZZOypa446KTAK6zxm5GsQVmmBvd+0b6VlnCjgcKsmDfaqR49KurxRcNbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAyjaKdkkSi4w9oUDn5Gji23Sdd6NQwuJmfyh+dK78M=;
 b=WBA0C1jAYyM1PVoFEs/joWJ4dFEo2L2uc+6lcoLQ2wdzkIozOB5a4HBROcvwBA59tPYmBHKdFJZ3SQc/4ciwUURVWTlMsC9d1Zm6yri1N+D0GlVsajO6TtM63Cc/+1eU+nD7mkPWTw/0HmRPOgCmE6YsUipCV9Op+R7sKxSyHTjxAYEM/IKzAM9FuCWYE3kG1Oi4bw5EuQPen0uAryAaEMKjUJi5CV9EpVQb8ey2aiBCqYs2tbz5ccpm/fRrlIh0k7anBp40RVA8Mp4BCpC6f55P2Xrb1fXlxwj1sQBx5APZz7Ko2M8fwS+DuK0K8+DnWTpMcCIspPfazo2bpka53A==
Received: from MW4PR03CA0237.namprd03.prod.outlook.com (2603:10b6:303:b9::32)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 8 Aug
 2023 14:16:23 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::25) by MW4PR03CA0237.outlook.office365.com
 (2603:10b6:303:b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:10 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:16:07 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<dcaratti@redhat.com>
Subject: [PATCH net v2 13/17] selftests: forwarding: tc_tunnel_key: Make filters more specific
Date: Tue, 8 Aug 2023 17:14:59 +0300
Message-ID: <20230808141503.4060661-14-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0c3c7f-7b2b-4715-55bc-08db981a0a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AULA2DugIB3MOeB1RQFADx3fr2r5ywTe9fpHnS2oRzwwIwbGXqjwobqym5RGiEk0ZcAcOCYC4A+eTUh0EcgCpMQDXhc3dB4NbJieC20WCpGa9Lq1Nx2q3hU4w1gW3QbPqx+ltiQS89yijrMGKt4Hps3acPfpvTwCP/4jd5zBeSmiKvN3IoXDAT58LgWa0lvTQx+7A0y5r8Nw8PNMq7cfIwVUVauIB3hbbQFGOaLzJ+Ro+n21dJcmBiOfXw0nkJ6gmiUdB7mKTCEb/nkp+ymGfR0cnMRC/X0/h70w2LpERHmuc+526PhPl2QI/1MCTlM5rc7XBaLSKHBEHM0UevytIwOdQlDyuNwenkXKFB0XrVOajYR2SaQN16OtP1MB7yza13siRan3Mr0czY/C3rKcY+7umVbHq9lwUQK21EAiHKhDu0YyJz2PUpbQnlJGpzik6E6jo2O8zc67ZVwhwPNqGl9oLFglrabC5mleXU+mi7oNeJNV7KTAYn5y5nM2ZT2PvFUiZDlv7yR+LcuSAI8zvwrwUgsBv1HwwzqvFIRzRK4ovQGK6wwZrNPI5tQq8Mrm4e3v9jsDA+Ccc3aDhhCPgLCyQqdcGvXAKquxfX2vMFqNp9eqjDzjV4afyUSaDF7oyYdoT0F+zhuMXxgutHuaL0RJAC2ee1OlEvWDwG7kTT8AKZgKVKDEt7QUdEK4XYxQC1nzuWmM60P0uoyM9Hw4j2OhDgFCt23ArBEh6zQCgnc4oWjRa2aUNJ486hHaTfBMba+v3k0Kb/Acpr3tKDwQgLOGawue3c15yrNcbVPXlS8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(186006)(451199021)(82310400008)(1800799003)(36840700001)(46966006)(40470700004)(83380400001)(426003)(36860700001)(47076005)(2616005)(40460700003)(40480700001)(6916009)(4326008)(8936002)(2906002)(5660300002)(316002)(8676002)(336012)(70586007)(70206006)(16526019)(966005)(478600001)(86362001)(7636003)(82740400003)(6666004)(54906003)(41300700001)(356005)(1076003)(36756003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:21.4838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0c3c7f-7b2b-4715-55bc-08db981a0a89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test installs filters that match on various IP fragments (e.g., no
fragment, first fragment) and expects a certain amount of packets to hit
each filter. This is problematic as the filters are not specific enough
and can match IP packets (e.g., IGMP) generated by the stack, resulting
in failures [1].

Fix by making the filters more specific and match on more fields in the
IP header: Source IP, destination IP and protocol.

[1]
 # timeout set to 0
 # selftests: net/forwarding: tc_tunnel_key.sh
 # TEST: tunnel_key nofrag (skip_hw)                                   [FAIL]
 #       packet smaller than MTU was not tunneled
 # INFO: Could not test offloaded functionality
 not ok 89 selftests: net/forwarding: tc_tunnel_key.sh # exit=1

Fixes: 533a89b1940f ("selftests: forwarding: add tunnel_key "nofrag" test case")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Davide Caratti <dcaratti@redhat.com>
---
Cc: dcaratti@redhat.com
---
 tools/testing/selftests/net/forwarding/tc_tunnel_key.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
index 5ac184d51809..5a5dd9034819 100755
--- a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
+++ b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
@@ -104,11 +104,14 @@ tunnel_key_nofrag_test()
 	local i
 
 	tc filter add dev $swp1 ingress protocol ip pref 100 handle 100 \
-		flower ip_flags nofrag action drop
+		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
+		ip_flags nofrag action drop
 	tc filter add dev $swp1 ingress protocol ip pref 101 handle 101 \
-		flower ip_flags firstfrag action drop
+		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
+		ip_flags firstfrag action drop
 	tc filter add dev $swp1 ingress protocol ip pref 102 handle 102 \
-		flower ip_flags nofirstfrag action drop
+		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
+		ip_flags nofirstfrag action drop
 
 	# test 'nofrag' set
 	tc filter add dev h1-et egress protocol all pref 1 handle 1 matchall $tcflags \
-- 
2.40.1


