Return-Path: <netdev+bounces-17652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9A752830
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CDC280F40
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B11F189;
	Thu, 13 Jul 2023 16:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D25200BB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500A31BEB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwrxZGaxo0MtOBbrq/P0qv17WgujEKj8Wc8Wa2MKq/UcNQmtXlH4L4MVNvULGNnbsI+wgHpgHMMtQaJDm1ib0cCYVnipI5pohwCoOe8jTuRAsq5F7M1RoWgKTFv9dRt25fsHrEHRqtrfs6EQ7li5g7ZZBCGZEUEiRBpoqqpCivOoD+jKG0NoAarmV8TAFNnaCM5BQkr7oa/AMifVIVxh2jfGtSPOWgNSjqv+lStxZQZyX23zvYmIMpAM292Lw1iFLvV8GSifLvVNSd63B8/36COleBJXTtcUeq9CH/ofZU2e0qG7bNQnf25FxEEvxE++SNruEV+JfBieDiJYL4v4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcDTvUe+Z0rd4dMVHZiF9FJHS/FnfoniIawLXNO/5iA=;
 b=VaVmLPoMttsfGr1EkTxcFJy829r5geWXtlOhZGQDSBEo5KpgNk5rMcVDmTGZzBII/Gh+ZtfPW86nuSmYG0O9+lBUCofaEFq+naMmQy3ZHPhiQ335/C+KT+5b0NcyAYQ2IRwb5lLdCY4sbJoA092Z6kSGD0mXlElYJ7AEDA9EBx08ydX9QcW7hiNNv8MTMMmiug6dCg0s9TfrYSPYt1QzLZjhrXsx7AimitS1mMn5m6RS0hRjvyPUOsx3madu/X9LfyDH99ewQs2D6HeJBX9mdv2iiLIxZnNkBYKUioN7WvIjKhLz0HBmCK8ouh4h/2gSc+C5lJ0tMoSYLhdlk7jILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcDTvUe+Z0rd4dMVHZiF9FJHS/FnfoniIawLXNO/5iA=;
 b=RdCWLaEYIKx2mZQfn0x2V/j9hmX030V2bqMDPp+R77FMfL21aJFIlUBeof29/9CKKrt9ObLPeVuDzBffHkALIXBE7C8HbU7oIAJLDm2nYQYHjx5xNMWl0Hv6UbyA1SBaKjt0xwlncVv2ilQaObeIp5z+3Wu5TXCOQxcfUvNevWLRKo8Ezwe6DYGNZMBs5aGwLqpLYnZbTWHYs8ohgQEqt4+pi4kdEDMCZpDhsSjvCUtEaw1YWVjATCONeCXgAFHmRW96b/Ifqv/1zegcxK/nZ3DgowM+M0aRSFD4cUJn0veT4D5viCzbHNw1rNc9I4fnxYsvGv7qQIghxNN8LzBQoQ==
Received: from BN9PR03CA0094.namprd03.prod.outlook.com (2603:10b6:408:fd::9)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 16:16:39 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::39) by BN9PR03CA0094.outlook.office365.com
 (2603:10b6:408:fd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:22 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:20 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/11] selftests: router_bridge: Add tests to remove and add PVID
Date: Thu, 13 Jul 2023 18:15:31 +0200
Message-ID: <5b0bddc89d2ca9853ddabc7ed2d5d37db1fa8f8f.1689262695.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689262695.git.petrm@nvidia.com>
References: <cover.1689262695.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: e31e5f09-6ce0-4e32-82ef-08db83bc89d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IjxbCjabbN3PhS04xTJuCtjua8f1SYMHmqrrdEioHBBGEpuZtRYurO4sSRobeI1dd7vOQVoMuX1zx0D9xHyXFU9fyuAzJzDBYQQcCSTBzs95tzK1sZK71UIZnk0O5q8q/hUC02gNoyA+pdJq8dw/RozstpF3ulhNQRGFXlsTqPrWYfDlxc9gTq0NI7JMpddw0Ej4sRfFwD0ZfgajP23RoggakKPrggW2QBWDncjF7oQVehdF4ICayXIql/8camTAwQurAexqs8MfdvXl8f2QTjtvt7shNn1kp8Xs5l4czn0udwEAvG5Wc0F3ePyswL9971LuD83/ybCq0qW9l5tZJkt6u1g2lQ4hlRari4A2tjYszTElhkZjR6N1Dh1CLawGEfe/0DCJP74wjJo4syW66Xcr6FG0c8ZArkD8hLU0iPTwCu5qNesK/86VVxh0Ep3UkSCyWSDQb/uxgl9ZlBSPwOA5FnNPgwu/XMWU75JVZwwHJXuYfr9b46vfbPQByaYSJaPOI4JLwPbOgsK4CKR+aV0yDXg9FZEFLi8hvCdgb92VaOzYBm1k9rkxSqdErQ8okCLe57FNKZmf6Waocqvd73qux8MODWmDm+0x83Iv5jbJupWaepR4rWEjIdQtXnEldlwdg6ARQIoxR4ChuuRC2yRbh5OkUDnWP1MUJQ4xwlHOv4YqoLUkxcnyfVrblAXgL5TZzulJqpbnChdVHPvszr6eHkvqrde7uTAMVXJHO5esstD+9UC4usur/YLyuBSp
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(5660300002)(2906002)(8676002)(8936002)(41300700001)(70206006)(316002)(4326008)(70586007)(6666004)(54906003)(47076005)(426003)(186003)(26005)(107886003)(16526019)(83380400001)(2616005)(66574015)(336012)(36860700001)(40460700003)(110136005)(82740400003)(7636003)(356005)(36756003)(82310400005)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:39.0522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31e5f09-6ce0-4e32-82ef-08db83bc89d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This test relies on PVID being configured on the bridge itself. Thus when
it is deconfigured, the system should lose the ability to forward traffic.
Later when it is added again, the ability to forward traffic should be
regained. Add tests to exercise these configuration changes and verify
results.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/net/forwarding/router_bridge.sh | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_bridge.sh b/tools/testing/selftests/net/forwarding/router_bridge.sh
index 8ce0aed54ece..4f33db04699d 100755
--- a/tools/testing/selftests/net/forwarding/router_bridge.sh
+++ b/tools/testing/selftests/net/forwarding/router_bridge.sh
@@ -1,9 +1,33 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# +------------------------+                           +----------------------+
+# | H1 (vrf)               |                           |             H2 (vrf) |
+# |    + $h1               |                           |  + $h2               |
+# |    | 192.0.2.1/28      |                           |  | 192.0.2.130/28    |
+# |    | 2001:db8:1::1/64  |                           |  | 2001:db8:2::2/64  |
+# |    |                   |                           |  |                   |
+# +----|-------------------+                           +--|-------------------+
+#      |                                                  |
+# +----|--------------------------------------------------|-------------------+
+# | SW |                                                  |                   |
+# | +--|-----------------------------+                    + $swp2             |
+# | |  + $swp1      BR1 (802.1q)     |                      192.0.2.129/28    |
+# | |               192.0.2.2/28     |                      2001:db8:2::1/64  |
+# | |               2001:db8:1::1/64 |                                        |
+# | |                                |                                        |
+# | +--------------------------------+                                        |
+# +---------------------------------------------------------------------------+
+
 ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
+	config_remove_pvid
+	ping_ipv4_fails
+	ping_ipv6_fails
+	config_add_pvid
+	ping_ipv4
+	ping_ipv6
 "
 NUM_NETIFS=4
 source lib.sh
@@ -62,6 +86,22 @@ router_destroy()
 	ip link del dev br1
 }
 
+config_remove_pvid()
+{
+	log_info "Remove PVID from the bridge"
+
+	bridge vlan add dev br1 vid 1 self
+	sleep 2
+}
+
+config_add_pvid()
+{
+	log_info "Add PVID to the bridge"
+
+	bridge vlan add dev br1 vid 1 self pvid untagged
+	sleep 2
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
@@ -104,6 +144,16 @@ ping_ipv6()
 	ping6_test $h1 2001:db8:2::2
 }
 
+ping_ipv4_fails()
+{
+	ping_test_fails $h1 192.0.2.130
+}
+
+ping_ipv6_fails()
+{
+	ping6_test_fails $h1 2001:db8:2::2
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


