Return-Path: <netdev+bounces-22877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF1769B31
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33508280D71
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2319BA7;
	Mon, 31 Jul 2023 15:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46318AF1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EB9199B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJQubQ91o0tV4Ea6H0P5gq8Dr8RXi9eX9CXf7yPImPWE0NzMk3qBSv6lWDHC0/e9fbULoogg3Jiu4HJjnmUEhYLUZgHcPn7QdqLxHvm1YWN9f8Eb4JqJH+atngmSUX3bWbJAAnrEqCFzDWCcsMVGNVc8jNQAKJpc4aWV5Pnp6Mqq2m83RDCrHp1A+RfoyIEzeyw/QauicwYDssFD+6vKGcvXwC4rBdYxsUK7DPLCXYbTa9NyE1c80fCKYkf4/xJEWlRnWPIJP7dB5dI/fVi1hYIMksjXoiJcrj0B3Rioxjf4nGs8oHnNUbg2qcMjuyuhV1p94sI5eJQWv0wBvbVZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqnAbjbTGWHCHu9yOuqMPTDU3TK7zOkJ1k4B0l9IgQ8=;
 b=nzerVzg0gCDnawiVgSmkbyMkAEtUhSFImP88B2A+DKXwVeEITeWJwE6gQcJOJlWuitbtjDcz5UOEquRFbZ6n/FCVyHXYbAezR7xyoD5AmiOjFJKdx8AFsPMA+2J5CXOytVXFWQBIdOi51CQ0Ha1DkMpW0nwWzdOkM5fyGiFSk67H/QorxStLUPhdmb9jv4lh+Gc1lw9TpjiAHuPT//D6VJk1ozu6UNznNRwlt83su/d+JSaP4curX8FUquAigQS0EhYgc5tPPWTbSSkgd4A9xj81+VNCvyEMyqj3gdgfLCv5edtKG5SZHu2q8EkTTek5WPwTXP2aixfYQUxoxV1yKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqnAbjbTGWHCHu9yOuqMPTDU3TK7zOkJ1k4B0l9IgQ8=;
 b=HVqRnMJZ2cynH3FgsZpOLFM3XSvxDFslliiM1zlW40JQbPjUY0P2Av+Km2C4tmNKVL7AtRQ4S2eHJC1CopG+waFbxQiuf8KOEzRN4rHK7FXG7WAdekEg97rP0XFVf7kxW2VMq2R25cniG1fNwDzptgfzqb1uzXkzmPFZqMvCSlbASVHKHo0n5tzTYwpuDvdS9UKH5nnImp1yUABRavjcEd/e7dx+9aXZPzWYssrxRTnq3/XuNPpYzqREWR+NCkKbbr9dyqC+0VNtd3MiZk9q+7zK/8Udnkli8b3PZlPaXx5Rcxb1inF8/jd5Gb9pKD381xGqoifgVh9dWyhCcP+kBA==
Received: from SJ0PR13CA0090.namprd13.prod.outlook.com (2603:10b6:a03:2c4::35)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:48:20 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::f6) by SJ0PR13CA0090.outlook.office365.com
 (2603:10b6:a03:2c4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.16 via Frontend
 Transport; Mon, 31 Jul 2023 15:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 15:48:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:48:04 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:48:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 6/8] selftests: mlxsw: rif_lag: Add a new selftest
Date: Mon, 31 Jul 2023 17:47:20 +0200
Message-ID: <a5880ab16d98ac585bfd232effbff95ac677ab12.1690815746.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690815746.git.petrm@nvidia.com>
References: <cover.1690815746.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b71864-bcc7-4b9e-3e16-08db91dd9055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6aXqt/25oPYQ4j26yIgJvT2y8DEeZM8/Wv9ed/fUTWVMBNtVFbFW/DdK3Ge2nYgNQX1YKC6R27GxRrqEkytRwzV/ylyNVMj9phway0AoCdOl6SaP+r7TlFcctqUTiexdoAobzoQ5KJM+LUjQ8Z75nL9QcMTDyJGSJm+j54YwRQ/7uOXADdewEMijE0bxLu6w9u51ZChD9fzVuEX7QFQeuNYGtypKPNJpphoYwbqj0UWnt9CyNbm0Hz+U3VmI6xe1ltvyKPtU5R4AD1vHUD25NC1VAgIhCVbQ3k7rcYJ/XbVeX6UjnazsshmTuu8bcgFcib9yrQ390qMwXb1c4qUf2PKKU/ey8QqWLep54ERS9hOjY1oj0J/yFpzZuyV2Z+YAAFnBSnFHgTJ7ZjGPaYRL5MkjgJXjjBiPfc2jfadRz4VOaEXYczanQ234zFvckGNiSpFdWd4pc/PHt4mPVL+qU8ZIG5x1knHMLSVRHFe3qRtDSMOVAu8T5jArCo0iw3zW5iwfEfsdQ3jsoWB26fDOx+8MNjta0ptW26PCW7cLpm9RZz8qDJIP1GdLjOihIxWVuZ89/RQYaCo5nDlDcy/huHsAArr0d7hB3Edir4nusJ2u5BP0QSB7EoN7/3n1i7jlBMHXjFM1GIkOg0+4TCZv7oApnlMMLxBdBCNZT+C5U20Uh02R3CaH7XDNZajud8fY+B/CL7xAByzmN53G2OUbMh6ZOIJBqF1P84+rIvfG6/xkNSok1Hmw7Lp8GJgrYtAa
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(5660300002)(2906002)(70206006)(70586007)(4326008)(110136005)(41300700001)(54906003)(316002)(16526019)(2616005)(6666004)(7696005)(8936002)(26005)(8676002)(336012)(186003)(107886003)(426003)(36860700001)(47076005)(356005)(82740400003)(7636003)(478600001)(36756003)(40460700003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:48:19.6800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b71864-bcc7-4b9e-3e16-08db91dd9055
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This test verifies driver behavior with regards to creation of RIFs for a
LAG as ports are added or removed to/from it.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/rif_lag.sh    | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh b/tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh
new file mode 100755
index 000000000000..e28f978104f3
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh
@@ -0,0 +1,136 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+lib_dir=$(dirname $0)/../../../net/forwarding
+
+ALL_TESTS="
+	lag_rif_add
+	lag_rif_nomaster
+	lag_rif_remaster
+	lag_rif_nomaster_addr
+"
+
+NUM_NETIFS=2
+source $lib_dir/lib.sh
+source $lib_dir/devlink_lib.sh
+
+setup_prepare()
+{
+	swp1=${NETIFS[p1]}
+	swp2=${NETIFS[p2]}
+
+	team_create lag1 lacp
+	ip link set dev lag1 addrgenmode none
+	ip link set dev lag1 address $(mac_get $swp1)
+
+	team_create lag2 lacp
+	ip link set dev lag2 addrgenmode none
+	ip link set dev lag2 address $(mac_get $swp2)
+
+	ip link set dev $swp1 master lag1
+	ip link set dev $swp1 up
+
+	ip link set dev $swp2 master lag2
+	ip link set dev $swp2 up
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	ip link set dev $swp2 nomaster
+	ip link set dev $swp2 down
+
+	ip link set dev $swp1 nomaster
+	ip link set dev $swp1 down
+
+	ip link del dev lag2
+	ip link del dev lag1
+}
+
+lag_rif_add()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	__addr_add_del lag1 add 192.0.2.2/28
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 + 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Add RIF for LAG on address addition"
+}
+
+lag_rif_nomaster()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev $swp1 nomaster
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 - 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Drop RIF for LAG on port deslavement"
+}
+
+lag_rif_remaster()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev $swp1 down
+	ip link set dev $swp1 master lag1
+	ip link set dev $swp1 up
+	setup_wait_dev $swp1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 + 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Add RIF for LAG on port reenslavement"
+}
+
+lag_rif_nomaster_addr()
+{
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+
+	# Adding an address while the port is LAG'd shouldn't generate a RIF.
+	__addr_add_del $swp1 add 192.0.2.65/28
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "After adding IP: Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	# Removing the port from LAG should drop RIF for the LAG (as tested in
+	# lag_rif_nomaster), but since the port now has an address, it should
+	# gain a RIF.
+	ip link set dev $swp1 nomaster
+	sleep 1
+	local rifs_occ_t2=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0))
+
+	((expected_rifs == rifs_occ_t2))
+	check_err $? "After deslaving: Expected $expected_rifs RIFs, $rifs_occ_t2 are used"
+
+	__addr_add_del $swp1 del 192.0.2.65/28
+	log_test "Add RIF for port on deslavement from LAG"
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.41.0


