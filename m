Return-Path: <netdev+bounces-212784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F71B21F58
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6813B30E2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262422D9ECD;
	Tue, 12 Aug 2025 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rzjJwLDw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634942475F7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983223; cv=fail; b=htnt0hDhBHPOWmjscI2Jj0g5Lif849BjOSlGOVX7U/C62WroVOvlW+v/z9J2Q2vLE0LHO5PhuhDHtbQX3Qv+1EtsVarcQzWrsVrCu7sl33CF8V2GSJKzGE1L3TdJOWCHSD7Igrzq4EUf3cC2n/JBe7wOJMpgDEGXiHnhpMyrycI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983223; c=relaxed/simple;
	bh=kcNxJ4uPB2YfoIgeP67Fv/qlYEysZS+1cthazNhSkq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tdfg3e0nTWbIL9rsG7T/JX2+n8+wFbmMir7x/zcLYvUJjnKyCWPubWwa2iPNrlFy4Hgoob6c+3oHvdklMn6hCxKiOx2HBoQSFyULMjinlopgoQBNp1BOeNfRBPdsLTgZjniSH52Z/gxBwz39uUdD7VrOnEA9NPN5YHxRSIdI1fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rzjJwLDw; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeDc5G34WBkPuTomyxzM32GHPcLxXYdv8ss3oMGMgaMtAhDViavmQVsgwld0FX266UzhSlH6VlzD5cJ1Am+DXN9PbPx6G4nd4IDXb0oUaCeKDgcgX0wzFvHGH1DVPpviRrijCh8Vs3MWCun+4npQhdLgTG8oqOnpl+/8wAloRnzYLcYCG2l8hFyKdxGfM59bbmxHcWOuiK8zN0tZAExFTIIpYMQ1B7SoTaK8fk1kjgmsAPlHTacB8YwQeJvfMoE4y4eia57sA1tTkzY2RfPDOToEj2CY15TtvZL+E5ut8mqT8WRxsmRYfUvzNYX8Hw9bfBkqUp5fRgni8lDfwz8drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCIYO2AVsS0EmmzDLYlpCb/pqSDPKygjfjBDNbgjRgw=;
 b=Ttw/g8qI63V8IVISnzD+7aS6MKz0GslrqSvT/aT7C+AUyCkDQmEo5tdmzJc35vS5gWXtmckU4GpVO1LfxkJPsCS8XxgVAR5HwnrOtsUt6VSJlJ+aArqKv+3hZ4nGWz5v4lQZLSmIlwjkAV0V52TP8VtOnAmdmXt4i0eg0uNHwhrahSQ80SnItyBzSa8wDjpBPpQGy2KG8UO0dPDIDKVJ0cqKZYWFGD1CGThdl7rx1Ot60OxFtyU5go3rCY3YLAiMGoCyFO3pNPRmYAUCf98rIilYaWGtrVG7Mg1KAM+IapmXT2T+cRW7pIn/lKKZQwtwKn4083J8brClUEL8YpsnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCIYO2AVsS0EmmzDLYlpCb/pqSDPKygjfjBDNbgjRgw=;
 b=rzjJwLDwL38XXEiqlWH8fRYGpw5kvXUN3gNTJJCjd6rznw45N2TNIs0dFet3KFo2ffi0hhogriqKr2s5ypdNbFFxY/qzgyk6Jo0ratz82Eqpi9H4BmBeJJX/ZcN8C4lwRTj7zbRcK7D882gwNvO6ILUbNidITK3GixVKzf/7W+oTdtK7ZuzWQWUkBwakSrX3jdL5WB/0zwQxKCI3cDOA5ajDyiXJ1bl1VYbVcdXTeN17zaBGFlvwEBnuVdLsjtTE9rAdWYbLXPFcRX7OmtAld/wthIw8+v7JsAr3TmnS3oqcEy6XWq8fa6qgVhPV7p71zK01Md8b/om84ZKnvKfQPA==
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 07:20:16 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::a2) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Tue,
 12 Aug 2025 07:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 07:20:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 00:20:01 -0700
Received: from shredder.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 00:19:57 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <petrm@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next] selftests: forwarding: Add a test for FDB activity notification control
Date: Tue, 12 Aug 2025 10:18:10 +0300
Message-ID: <20250812071810.312346-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aef2907-149c-4e15-ac22-08ddd970afa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H4PeUU1ku00gVSw0dp8RFBjXUyUbRWyO+WR6SdcyPML6cO+ZanXeBEIsCUli?=
 =?us-ascii?Q?kCd3OYD4J6MBsLYmJ5PU5Wn3ycJz8NRhU5owaQq3OjDDCXWjT6Oi8+zneT0Q?=
 =?us-ascii?Q?V8BLNk963HqHgY4nfTZ8mFXHG/T3PDkVLIc8OxuuDgfLsKjdE4IGfVwG/oZl?=
 =?us-ascii?Q?I04biGckXbyzM7dS8J6kvIkoMIi8lzuJ/Oz6zgch92l8bD21Xo/3wKFSQZPu?=
 =?us-ascii?Q?fIFJMZt+D8HUh8/EnhcwMcQJ07/sVerxy+rB1+tKBZETRy6Ru11CP1Xx72dZ?=
 =?us-ascii?Q?zx6ppjfLSHBYGuwEqnQzeL/JoL7Pumj0SIKVQBQWt0/iMATpvEUcBGROhgGc?=
 =?us-ascii?Q?93M+Fcl9c9LRhHHkID4INZ8kL5u9kVlkI6+sTpWBCNLJMI8v0pDF8Nc08KnW?=
 =?us-ascii?Q?PBrgfaV+JI0FcBGbnnZH94YWvSeXu/r3jg2WgK8nWGXe1F0c31rFZWW85iG+?=
 =?us-ascii?Q?47MxNVlrYhXp5szOf21BznmC0mVV+1C3RsHDyxqHoYwV/iU8ExLCgu8cOVBY?=
 =?us-ascii?Q?KBPnrDPRG5/zIt46lXd8+Jsl/rzpcEEf/RlszibWyaj7yEqSudqHscRnAkjq?=
 =?us-ascii?Q?tLtO2VeWlp2oEDCl31qRrQfEjrtI7XflEYIDVXiKQ5tywYQp7X3vU+NtA5ln?=
 =?us-ascii?Q?OVtOronc9XneTs60LpusrdQvQWqcMQg3o3C9TMfeHWgzPc9hlKGJc57V2Rpx?=
 =?us-ascii?Q?xwF2DowSFZ4y5tzQ0sKWiRMbg+5yT01TdepraPvQ2vaJZPaHV1Bg67SQ0CTZ?=
 =?us-ascii?Q?45WKcF25ymyla9jHkuM1B3ji6UjNC4mVzqdPkreipX7nFUX4JkBbezlaZz0n?=
 =?us-ascii?Q?k0jCqMOf++MCtoIgLeCP4oU9XaJYtHZNYQzBvOP1s7Zl94J1cE39Z/1avyNN?=
 =?us-ascii?Q?tmaJUvlvrMF4+fedHyJT8ESWlROHvxl5dJyJdJrLy6UWqqyQFu8ho9oWVmZC?=
 =?us-ascii?Q?Pkys9vrT4ElwWN0DJzJFB4mxSx23QXdwiJfBfccSQ5ESl/qvVE25xUAEHkbV?=
 =?us-ascii?Q?AyQWEU8OiW+CaoT7CSzv/eqA3APMzsVetn7sLWNQqz1FMJOP03eDLamczZ2+?=
 =?us-ascii?Q?JKeLfxKl1LII5FcAxNg1jugWJSjZeL+Fue573Dd/UfOA7vhDx3xPWGIfwrMZ?=
 =?us-ascii?Q?vc7jl8OelzUAOZT+uHRHZn+KP62x7HtglnNgRMHJoFMwFwKkQB2czCYYXgdg?=
 =?us-ascii?Q?hisa655OILf6vtEkfdEypmLsdmuuxCUhC87o51xKIphqSr7O9HEQrGaCNR0c?=
 =?us-ascii?Q?nnuyKKfw5XAttQWIv7jLfZOQr0cEcNNqykJnUqZXZ4dKuR7CEyCHTgPj1LU7?=
 =?us-ascii?Q?N7nS9vWOjW05Ovevj+sowl4EXUVda4Z1AUS8rnDG/FhhrZVWpdlfh2tN/AN3?=
 =?us-ascii?Q?SACcyh4nVhvfPkqzUDvf7s6miciagFp0DCf4h2UWcCEv5/KIpJlbXUdxy2Uj?=
 =?us-ascii?Q?3reslrswV3PtkUWxOMcx8m2YaqlsNlHB0C33X0MrOxxqV2cOOUo2sVcawwyv?=
 =?us-ascii?Q?9sw6rsIn3Zuoos2b+ffnA5j6S22+1+PSEuWS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 07:20:16.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aef2907-149c-4e15-ac22-08ddd970afa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

Test various aspects of FDB activity notification control:

* Transitioning of an FDB entry from inactive to active state.

* Transitioning of an FDB entry from active to inactive state.

* Avoiding the resetting of an FDB entry's last activity time (i.e.,
  "updated" time) using the "norefresh" keyword.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   4 +-
 .../net/forwarding/bridge_activity_notify.sh  | 173 ++++++++++++++++++
 2 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_activity_notify.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index d7bb2e80e88c..0a0d4c2a85f7 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_PROGS = bridge_fdb_learning_limit.sh \
+TEST_PROGS = \
+	bridge_activity_notify.sh \
+	bridge_fdb_learning_limit.sh \
 	bridge_igmp.sh \
 	bridge_locked_port.sh \
 	bridge_mdb.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
new file mode 100755
index 000000000000..a20ef4bd310b
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
@@ -0,0 +1,173 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-----------------------+                          +------------------------+
+# | H1 (vrf)              |                          | H2 (vrf)               |
+# | 192.0.2.1/28          |                          | 192.0.2.2/28           |
+# |    + $h1              |                          |    + $h2               |
+# +----|------------------+                          +----|-------------------+
+#      |                                                  |
+# +----|--------------------------------------------------|-------------------+
+# | SW |                                                  |                   |
+# | +--|--------------------------------------------------|-----------------+ |
+# | |  + $swp1                   BR1 (802.1d)             + $swp2           | |
+# | |                                                                       | |
+# | +-----------------------------------------------------------------------+ |
+# +---------------------------------------------------------------------------+
+
+ALL_TESTS="
+	new_inactive_test
+	existing_active_test
+	norefresh_test
+"
+
+NUM_NETIFS=4
+source lib.sh
+
+h1_create()
+{
+	simple_if_init "$h1" 192.0.2.1/28
+	defer simple_if_fini "$h1" 192.0.2.1/28
+}
+
+h2_create()
+{
+	simple_if_init "$h2" 192.0.2.2/28
+	defer simple_if_fini "$h2" 192.0.2.2/28
+}
+
+switch_create()
+{
+	ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0 \
+		ageing_time "$LOW_AGEING_TIME"
+	ip_link_set_up br1
+
+	ip_link_set_master "$swp1" br1
+	ip_link_set_up "$swp1"
+
+	ip_link_set_master "$swp2" br1
+	ip_link_set_up "$swp2"
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	vrf_prepare
+	defer vrf_cleanup
+
+	h1_create
+	h2_create
+	switch_create
+}
+
+fdb_active_wait()
+{
+	local mac=$1; shift
+
+	bridge -d fdb get "$mac" br br1 | grep -q -v "inactive"
+}
+
+fdb_inactive_wait()
+{
+	local mac=$1; shift
+
+	bridge -d fdb get "$mac" br br1 | grep -q "inactive"
+}
+
+new_inactive_test()
+{
+	local mac="00:11:22:33:44:55"
+
+	# Add a new FDB entry as static and inactive and check that it
+	# becomes active upon traffic.
+	RET=0
+
+	bridge fdb add "$mac" dev "$swp1" master static activity_notify inactive
+	bridge -d fdb get "$mac" br br1 | grep -q "inactive"
+	check_err $? "FDB entry not present as \"inactive\" when should"
+
+	$MZ "$h1" -c 1 -p 64 -a "$mac" -b bcast -t ip -q
+
+	busywait "$BUSYWAIT_TIMEOUT" fdb_active_wait "$mac"
+	check_err $? "FDB entry present as \"inactive\" when should not"
+
+	log_test "Transition from inactive to active"
+
+	bridge fdb del "$mac" dev "$swp1" master
+}
+
+existing_active_test()
+{
+	local mac="00:11:22:33:44:55"
+	local ageing_time
+
+	# Enable activity notifications on an existing dynamic FDB entry and
+	# check that it becomes inactive after the ageing time passed.
+	RET=0
+
+	bridge fdb add "$mac" dev "$swp1" master dynamic
+	bridge fdb replace "$mac" dev "$swp1" master static activity_notify norefresh
+
+	bridge -d fdb get "$mac" br br1 | grep -q "activity_notify"
+	check_err $? "FDB entry not present as \"activity_notify\" when should"
+
+	bridge -d fdb get "$mac" br br1 | grep -q "inactive"
+	check_fail $? "FDB entry present as \"inactive\" when should not"
+
+	ageing_time=$(bridge_ageing_time_get br1)
+	slowwait $((ageing_time * 2)) fdb_inactive_wait "$mac"
+	check_err $? "FDB entry not present as \"inactive\" when should"
+
+	log_test "Transition from active to inactive"
+
+	bridge fdb del "$mac" dev "$swp1" master
+}
+
+norefresh_test()
+{
+	local mac="00:11:22:33:44:55"
+	local updated_time
+
+	# Check that the "updated" time is reset when replacing an FDB entry
+	# without the "norefresh" keyword and that it is not reset when
+	# replacing with the "norefresh" keyword.
+	RET=0
+
+	bridge fdb add "$mac" dev "$swp1" master static
+	sleep 1
+
+	bridge fdb replace "$mac" dev "$swp1" master static activity_notify
+	updated_time=$(bridge -d -s -j fdb get "$mac" br br1 | jq '.[]["updated"]')
+	if [[ $updated_time -ne 0 ]]; then
+		check_err 1 "\"updated\" time was not reset when should"
+	fi
+
+	sleep 1
+	bridge fdb replace "$mac" dev "$swp1" master static norefresh
+	updated_time=$(bridge -d -s -j fdb get "$mac" br br1 | jq '.[]["updated"]')
+	if [[ $updated_time -eq 0 ]]; then
+		check_err 1 "\"updated\" time was reset when should not"
+	fi
+
+	log_test "Resetting of \"updated\" time"
+
+	bridge fdb del "$mac" dev "$swp1" master
+}
+
+if ! bridge fdb help 2>&1 | grep -q "activity_notify"; then
+	echo "SKIP: iproute2 too old, missing bridge FDB activity notification control"
+	exit "$ksft_skip"
+fi
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.50.1


