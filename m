Return-Path: <netdev+bounces-196596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482BAD585A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142A9166884
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C1D28C855;
	Wed, 11 Jun 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E+LEDeWB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FC10A3E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651433; cv=fail; b=o9AxDAzda6Dbg/mgXnBItimL26cT3GAeJaqVt9fAKi+Zq9LdUnDNC11tQ9npgFckUSMZWU9Qw45LqihdvVi5j5PgdUwbFL9eyHTnNkzV7QT+NJit2j9i7Ox1jcAi+CbTvkZZvNneMFBgve+QeXsZSnObjQ5vXFO8UsVoy2UmIkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651433; c=relaxed/simple;
	bh=x9ZHEYfsDoOONzG9vIepBlm7rMTbVClSxn028vh6G6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8AiAxAGHbA3hjE11x7ESwT5ul3j6wCbMZYRLnl5t6gwhIqmQ2LN0JPYO32fsRQp9WMoQS7Gwrr6HgnSMOR+pMm0Wc8vSDPspDbfG6JaoVgedHLuu/7RJOSaOlmPZDf2fzUgCPazUPa9WT+AkKh5oo+1Mwq1jVFQm1+LNCynwC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E+LEDeWB; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9niEpXFBd70lPm3pjNkjTQV014C9X7HzljS1ChXqGENyDGY1Znpzm34Yv6lkhgmO4jlgkXmmPmvKP39z4W0kpLPCpC+wJOkWsxyng9lcfFataSpoqrg4h/psphSuPGjDSGd+JGfTZDuu3Kn6yxh12DiFr3UeP/NX4wIDogoUdUiwJIoswwxykqqRy1K+W/pWgXBew2xMT02xPVWnmThYzoQCC6M4KMpggb90wDkepM9ynxpW+PXxoa0YsfPh/nygNBt8Bv05MWdqQvFz6fsyGw+c4KTAfOYlQb8UzWPaawcPBc7lqIIDZqcmTQGIDPp0N8BUHOWKqR174kTPO4FTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d9XZDkd1/v6/d1DB9bHuVr7zcvKgOiThNMvkN2Y6FA=;
 b=N2dg5oKPw16gN6rrtngo/SgMvqEXY6r5G44F7RvFPrainW3YVsRVr4ot80+4WeDQnsDo3E3JXwb2yvyojkZdX5BBm0PHL7GLj+33ez5ZR4nMhORubsX2yhJ8dIT+PPx3jRQw8WGXUsot/Hmn9JGK7803v5S3yVXKrqe3hHL2l3DYc13a6TSyCvD9UauEU+hiKCVWl+4HZhnQe15XBjZnTJZ3SbaEQchwj3tZX8wxDMT3xEHQr3xVRv02DFDcbo6gdLZ5fyUSMt4hiXsvNZVYqo9geaHbieekxaLOuOXJD7LlrYFAT+PuVpXvBCK9d5KQq0yr0OgSwK4cEjGSX4108Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d9XZDkd1/v6/d1DB9bHuVr7zcvKgOiThNMvkN2Y6FA=;
 b=E+LEDeWBgm2FtDyKPvzBVsqe6b8q8LvZTg5pADofcGv7B1hf5rY4g/m+ep0WyyKYb2HQ4YmmG3lKZMsIUrdbDKiH6hA27uZpFvqRc+8SlGg41kFL9DVoOLx4p3hJcLEFsKQM2AVyS0aeXba8eg/VzvFEc14FfP6t3QJwcTYl88vK8XFcgFhwPBnFDz1wLW2WLaYvZBvmYeCWMM40jPsR4Tg5XATwY36DBUuCYiZPFJJRXyQ/4Y76lmbx709gfKPvsgIle5C7/Se3zgScbKmyisAstB6bqRNYkJWxdfpiQ2ybgp2bq/T2DsUTQOMNimeRoC4VjW8oHQzLv7MyGjWRxA==
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Wed, 11 Jun
 2025 14:17:05 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::d2) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 14:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 14:17:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 07:16:51 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 11 Jun
 2025 07:16:48 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <daniel@iogearbox.net>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: net: Add a selftest for externally validated neighbor entries
Date: Wed, 11 Jun 2025 17:15:51 +0300
Message-ID: <20250611141551.462569-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611141551.462569-1-idosch@nvidia.com>
References: <20250611141551.462569-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f65a0f-e446-40fa-84c8-08dda8f2a47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P09vK06+k/MWTl0AbeZC6Akd15MQt9BtKDt7kpf4L3CadDhjcr0iX3iHTWpT?=
 =?us-ascii?Q?ega9ZNLIqo+KEswHWUYXuiVBba5CJ9zp51L9a8XE2DPaPQ4RNA/2ZFzcRaiX?=
 =?us-ascii?Q?bX2/3Uxd3i8bZlq0lDv7u7Qs2GVTctEBgH6qYahSp8L7EYUppKl4hCPfc9XW?=
 =?us-ascii?Q?G75iBc7Hy1tjikDFf5WDR+gY33I0rcwm7ZKTasE3LGi3ermQQj0cli+6wb6w?=
 =?us-ascii?Q?I+psqCVbnxX1wK1akiYCgZyc5YkgHZ9jk9JvvSLC38BIZrp6FEVUZd/0GNWE?=
 =?us-ascii?Q?GPHo5zu70gIktgWC/Cc3UB4XstRfw8/MK2eY1JGheHoRAsSnw23Iq8KmRk2m?=
 =?us-ascii?Q?xrx2a2S//U+Dfo+oar2aZm5x1VC6m4D10e847fGRYfOIJariQayAuyY+xot4?=
 =?us-ascii?Q?D3Tj7IER+K5ydTE3UNRfzNR3hk9Rgf5TTAOXSqe/LSzKhl0H2HOCI+vMXqvU?=
 =?us-ascii?Q?yWkpMhO/S6jR1fQLwuMDPiq7tLEWsMEHL1JkJk4BqXumKVDnKNaeHEsWaSz5?=
 =?us-ascii?Q?iBzojygJ/aH0EWf4iTIsgpVvgN6B/UW+Z8giWdpmairczvhG7JjgMkwWFRIq?=
 =?us-ascii?Q?ov18y8jDQY3Q0vhk95KU/XcwJ8vQyeUHGx9GURwMnlRuAtUDkC/f1jNWbkNO?=
 =?us-ascii?Q?BeOdCEQcVDk5C5dR7jS0AzLbzpgjy8rYYgX6T1vLxNIbJ2EcEwzS3wtp/rcN?=
 =?us-ascii?Q?vSKwBBcekjrbkAYuybW6dGuumXzlKt3MYXWgleCSxKryRknbbimuo75amMS+?=
 =?us-ascii?Q?WDFdAAzIQzn+hoyXH+rAWlfaZLlH9qCODGJTEEPS4XTzt8AUx+704lXAE1B/?=
 =?us-ascii?Q?rTvpxLcW0tBZjraiE3cdUFWnLNiGTXjpPkFOPbrYi2ROsbcOMrwrF27XRBrA?=
 =?us-ascii?Q?YOr2/9cd5xAV47VdMRm7pTsyQC2OQG1tWR8E4zwm2Lf76LA+87WITHv0FBVd?=
 =?us-ascii?Q?OR/CPlCmUxVBcM7FznCmXQjxPwJ4L/ZaIlscYP6XGmsKoWev4WwlBxC+yfFA?=
 =?us-ascii?Q?wSwDntYnL9mlUj/rTWIt7qlhe9dfTGq4bJcRotFX+SHwa4wMpj6TUppSimlM?=
 =?us-ascii?Q?og9gNronhG4CD93v09a4sMDGfbjf7UYxahplY2z78hqsBt6ul/Bl4ePLvEOB?=
 =?us-ascii?Q?Z/dqNLWzdhV0DpANGu7wE16U5bssHLiFNzcLqj4tmrI74lFxFiUG1itCZRm6?=
 =?us-ascii?Q?myFUUghu3g8syIrPUz7j44WUG0Vqhdp16WgDT6Xggny2VpgFM7JwUx1FaKGl?=
 =?us-ascii?Q?plljcQbo53OrXOQs40pCrcEehWu2yjqvrtFz1Ru5iNuRvlImURo3Ka5jxTz/?=
 =?us-ascii?Q?13KBOywHnDcbrY0YdejvoUHwwCqx4yIpywyhBwR3y3fn54E3kMWnaFstfCcN?=
 =?us-ascii?Q?JwPE5XrUIYBTmu7Ib4/bsh3jXw13opxAZeQYcCgN0yA41nfUzxtJzmFoWxuh?=
 =?us-ascii?Q?nqN5lANHUml6lc2LwP6x0KesLaaBtBvPT6qg3J0qnPyIEnKk+WhcwcebQJ2g?=
 =?us-ascii?Q?FMvXiDTMfD/LXdB72ckIzmKIJakIexXfTa/f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:17:05.1349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f65a0f-e446-40fa-84c8-08dda8f2a47e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Add test cases for externally validated neighbor entries, testing both
IPv4 and IPv6. Name the file "test_neigh.sh" so that it could be
possibly extended in the future with more neighbor test cases.

Example output:

 # ./test_neigh.sh
 TEST: IPv4 "extern_valid" flag: Add entry                           [ OK ]
 TEST: IPv4 "extern_valid" flag: Add with an invalid state           [ OK ]
 TEST: IPv4 "extern_valid" flag: Add with "use" flag                 [ OK ]
 TEST: IPv4 "extern_valid" flag: Replace entry                       [ OK ]
 TEST: IPv4 "extern_valid" flag: Replace entry with "managed" flag   [ OK ]
 TEST: IPv4 "extern_valid" flag: Replace with an invalid state       [ OK ]
 TEST: IPv4 "extern_valid" flag: Transition to "reachable" state     [ OK ]
 TEST: IPv4 "extern_valid" flag: Transition back to "stale" state    [ OK ]
 TEST: IPv4 "extern_valid" flag: Forced garbage collection           [ OK ]
 TEST: IPv4 "extern_valid" flag: Periodic garbage collection         [ OK ]
 TEST: IPv6 "extern_valid" flag: Add entry                           [ OK ]
 TEST: IPv6 "extern_valid" flag: Add with an invalid state           [ OK ]
 TEST: IPv6 "extern_valid" flag: Add with "use" flag                 [ OK ]
 TEST: IPv6 "extern_valid" flag: Replace entry                       [ OK ]
 TEST: IPv6 "extern_valid" flag: Replace entry with "managed" flag   [ OK ]
 TEST: IPv6 "extern_valid" flag: Replace with an invalid state       [ OK ]
 TEST: IPv6 "extern_valid" flag: Transition to "reachable" state     [ OK ]
 TEST: IPv6 "extern_valid" flag: Transition back to "stale" state    [ OK ]
 TEST: IPv6 "extern_valid" flag: Forced garbage collection           [ OK ]
 TEST: IPv6 "extern_valid" flag: Periodic garbage collection         [ OK ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/test_neigh.sh | 337 ++++++++++++++++++++++
 2 files changed, 338 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_neigh.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index ea84b88bcb30..f7c8dac525de 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -98,6 +98,7 @@ TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
+TEST_PROGS += test_neigh.sh
 TEST_PROGS += fdb_flush.sh fdb_notify.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
new file mode 100755
index 000000000000..5bf9153aa7a6
--- /dev/null
+++ b/tools/testing/selftests/net/test_neigh.sh
@@ -0,0 +1,337 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+TESTS="
+	extern_valid_ipv4
+	extern_valid_ipv6
+"
+VERBOSE=0
+
+################################################################################
+# Utilities
+
+run_cmd()
+{
+	local cmd="$1"
+	local out
+	local stderr="2>/dev/null"
+
+	if [ "$VERBOSE" = "1" ]; then
+		printf "COMMAND: $cmd\n"
+		stderr=
+	fi
+
+	out=$(eval $cmd $stderr)
+	rc=$?
+	if [ "$VERBOSE" -eq 1 ] && [ -n "$out" ]; then
+		echo "    $out"
+	fi
+
+	return $rc
+}
+
+################################################################################
+# Setup
+
+setup()
+{
+	set -e
+
+	setup_ns ns1 ns2
+
+	ip -n $ns1 link add veth0 type veth peer name veth1 netns $ns2
+	ip -n $ns1 link set dev veth0 up
+	ip -n $ns2 link set dev veth1 up
+
+	ip -n $ns1 address add 192.0.2.1/24 dev veth0
+	ip -n $ns1 address add 2001:db8:1::1/64 dev veth0 nodad
+	ip -n $ns2 address add 192.0.2.2/24 dev veth1
+	ip -n $ns2 address add 2001:db8:1::2/64 dev veth1 nodad
+
+	sleep 5
+
+	set +e
+}
+
+exit_cleanup_all()
+{
+	cleanup_all_ns
+	exit "${EXIT_STATUS}"
+}
+
+################################################################################
+# Tests
+
+extern_valid_common()
+{
+	local af_str=$1; shift
+	local ip_addr=$1; shift
+	local tbl_name=$1; shift
+	local subnet=$1; shift
+	local mac
+
+	mac=$(ip -n $ns2 -j link show dev veth1 | jq -r '.[]["address"]')
+
+	RET=0
+
+	# Check that simple addition works.
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_err $? "No \"extern_valid\" flag after addition"
+
+	log_test "$af_str \"extern_valid\" flag: Add entry"
+
+	RET=0
+
+	# Check that an entry cannot be added with "extern_valid" flag and an
+	# invalid state.
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr nud none dev veth0 extern_valid"
+	check_fail $? "Managed to add an entry with \"extern_valid\" flag and an invalid state"
+
+	log_test "$af_str \"extern_valid\" flag: Add with an invalid state"
+
+	RET=0
+
+	# Check that entry cannot be added with both "extern_valid" flag and
+	# "use" / "managed" flag.
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid use"
+	check_fail $? "Managed to add an entry with \"extern_valid\" flag and \"use\" flag"
+
+	log_test "$af_str \"extern_valid\" flag: Add with \"use\" flag"
+
+	RET=0
+
+	# Check that "extern_valid" flag can be toggled using replace.
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0"
+	run_cmd "ip -n $ns1 neigh replace $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_err $? "Did not manage to set \"extern_valid\" flag with replace"
+	run_cmd "ip -n $ns1 neigh replace $ip_addr lladdr $mac nud stale dev veth0"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_fail $? "Did not manage to clear \"extern_valid\" flag with replace"
+
+	log_test "$af_str \"extern_valid\" flag: Replace entry"
+
+	RET=0
+
+	# Check that an existing "extern_valid" entry can be marked as
+	# "managed".
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh replace $ip_addr lladdr $mac nud stale dev veth0 extern_valid managed"
+	check_err $? "Did not manage to add \"managed\" flag to an existing \"extern_valid\" entry"
+
+	log_test "$af_str \"extern_valid\" flag: Replace entry with \"managed\" flag"
+
+	RET=0
+
+	# Check that entry cannot be replaced with "extern_valid" flag and an
+	# invalid state.
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh replace $ip_addr nud none dev veth0 extern_valid"
+	check_fail $? "Managed to replace an entry with \"extern_valid\" flag and an invalid state"
+
+	log_test "$af_str \"extern_valid\" flag: Replace with an invalid state"
+
+	RET=0
+
+	# Check that when entry transitions to "reachable" state it maintains
+	# the "extern_valid" flag. Wait "delay_probe" seconds for ARP request /
+	# NS to be sent.
+	local delay_probe
+
+	delay_probe=$(ip -n $ns1 -j ntable show dev veth0 name $tbl_name | jq '.[]["delay_probe"]')
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh replace $ip_addr lladdr $mac nud stale dev veth0 extern_valid use"
+	run_cmd "sleep $((delay_probe / 1000 + 2))"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"REACHABLE\""
+	check_err $? "Entry did not transition to \"reachable\" state"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_err $? "Entry did not maintain \"extern_valid\" flag after transition to \"reachable\" state"
+
+	log_test "$af_str \"extern_valid\" flag: Transition to \"reachable\" state"
+
+	RET=0
+
+	# Drop all packets, trigger resolution and check that entry goes back
+	# to "stale" state instead of "failed".
+	local mcast_reprobes
+	local retrans_time
+	local ucast_probes
+	local app_probes
+	local probes
+	local delay
+
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "tc -n $ns2 qdisc add dev veth1 clsact"
+	run_cmd "tc -n $ns2 filter add dev veth1 ingress proto all matchall action drop"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh replace $ip_addr lladdr $mac nud stale dev veth0 extern_valid use"
+	retrans_time=$(ip -n $ns1 -j ntable show dev veth0 name $tbl_name | jq '.[]["retrans"]')
+	ucast_probes=$(ip -n $ns1 -j ntable show dev veth0 name $tbl_name | jq '.[]["ucast_probes"]')
+	app_probes=$(ip -n $ns1 -j ntable show dev veth0 name $tbl_name | jq '.[]["app_probes"]')
+	mcast_reprobes=$(ip -n $ns1 -j ntable show dev veth0 name $tbl_name | jq '.[]["mcast_reprobes"]')
+	delay=$((delay_probe + (ucast_probes + app_probes + mcast_reprobes) * retrans_time))
+	run_cmd "sleep $((delay / 1000 + 2))"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"STALE\""
+	check_err $? "Entry did not return to \"stale\" state"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_err $? "Entry did not maintain \"extern_valid\" flag after returning to \"stale\" state"
+	probes=$(ip -n $ns1 -j -s neigh get $ip_addr dev veth0 | jq '.[]["probes"]')
+	if [[ $probes -eq 0 ]]; then
+		check_err 1 "No probes were sent"
+	fi
+
+	log_test "$af_str \"extern_valid\" flag: Transition back to \"stale\" state"
+
+	run_cmd "tc -n $ns2 qdisc del dev veth1 clsact"
+
+	RET=0
+
+	# Forced garbage collection runs whenever the number of entries is
+	# larger than "thresh3" and deletes stale entries that have not been
+	# updated in the last 5 seconds.
+	#
+	# Check that an "extern_valid" entry survives a forced garbage
+	# collection. Add an entry, wait 5 seconds and add more entries than
+	# "thresh3" so that forced garbage collection will run.
+	#
+	# Note that the garbage collection thresholds are global resources and
+	# that changes in the initial namespace affect all the namespaces.
+	local forced_gc_runs_t0
+	local forced_gc_runs_t1
+	local orig_thresh1
+	local orig_thresh2
+	local orig_thresh3
+
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	orig_thresh1=$(ip -j ntable show name $tbl_name | jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_thresh2=$(ip -j ntable show name $tbl_name | jq '.[] | select(has("thresh2")) | .["thresh2"]')
+	orig_thresh3=$(ip -j ntable show name $tbl_name | jq '.[] | select(has("thresh3")) | .["thresh3"]')
+	run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
+	run_cmd "sleep 5"
+	forced_gc_runs_t0=$(ip -j -s ntable show name $tbl_name | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
+	for i in {1..20}; do
+		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
+	done
+	forced_gc_runs_t1=$(ip -j -s ntable show name $tbl_name | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
+	if [[ $forced_gc_runs_t1 -eq $forced_gc_runs_t0 ]]; then
+		check_err 1 "Forced garbage collection did not run"
+	fi
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_err $? "Entry with \"extern_valid\" flag did not survive forced garbage collection"
+	run_cmd "ip -n $ns1 neigh get ${subnet}3 dev veth0"
+	check_fail $? "Entry without \"extern_valid\" flag survived forced garbage collection"
+
+	log_test "$af_str \"extern_valid\" flag: Forced garbage collection"
+
+	run_cmd "ip ntable change name $tbl_name thresh3 $orig_thresh3 thresh2 $orig_thresh2 thresh1 $orig_thresh1"
+
+	RET=0
+
+	# Periodic garbage collection runs every "base_reachable"/2 seconds and
+	# if the number of entries is larger than "thresh1", then it deletes
+	# stale entries that have not been used in the last "gc_stale" seconds.
+	#
+	# Check that an "extern_valid" entry survives a periodic garbage
+	# collection. Add an "extern_valid" entry, add more than "thresh1"
+	# regular entries, wait "base_reachable" (longer than "gc_stale")
+	# seconds and check that the "extern_valid" entry was not deleted.
+	#
+	# Note that the garbage collection thresholds and "base_reachable" are
+	# global resources and that changes in the initial namespace affect all
+	# the namespaces.
+	local periodic_gc_runs_t0
+	local periodic_gc_runs_t1
+	local orig_base_reachable
+	local orig_gc_stale
+
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	orig_thresh1=$(ip -j ntable show name $tbl_name | jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_base_reachable=$(ip -j ntable show name $tbl_name | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
+	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable 10000"
+	orig_gc_stale=$(ip -n $ns1 -j ntable show name $tbl_name dev veth0 | jq '.[]["gc_stale"]')
+	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 5000"
+	# Wait orig_base_reachable/2 for the new interval to take effect.
+	run_cmd "sleep $(((orig_base_reachable / 1000) / 2 + 2))"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
+	for i in {1..20}; do
+		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
+	done
+	periodic_gc_runs_t0=$(ip -j -s ntable show name $tbl_name | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
+	run_cmd "sleep 10"
+	periodic_gc_runs_t1=$(ip -j -s ntable show name $tbl_name | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
+	[[ $periodic_gc_runs_t1 -ne $periodic_gc_runs_t0 ]]
+	check_err $? "Periodic garbage collection did not run"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_err $? "Entry with \"extern_valid\" flag did not survive periodic garbage collection"
+	run_cmd "ip -n $ns1 neigh get ${subnet}3 dev veth0"
+	check_fail $? "Entry without \"extern_valid\" flag survived periodic garbage collection"
+
+	log_test "$af_str \"extern_valid\" flag: Periodic garbage collection"
+
+	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale $orig_gc_stale"
+	run_cmd "ip ntable change name $tbl_name thresh1 $orig_thresh1 base_reachable $orig_base_reachable"
+}
+
+extern_valid_ipv4()
+{
+	extern_valid_common "IPv4" 192.0.2.2 "arp_cache" 192.0.2.
+}
+
+extern_valid_ipv6()
+{
+	extern_valid_common "IPv6" 2001:db8:1::2 "ndisc_cache" 2001:db8:1::
+}
+
+################################################################################
+# Usage
+
+usage()
+{
+	cat <<EOF
+usage: ${0##*/} OPTS
+
+        -t <test>   Test(s) to run (default: all)
+                    (options: $TESTS)
+        -p          Pause on fail
+        -v          Verbose mode (show commands and output)
+EOF
+}
+
+################################################################################
+# Main
+
+while getopts ":t:pvh" opt; do
+	case $opt in
+		t) TESTS=$OPTARG;;
+		p) PAUSE_ON_FAIL=yes;;
+		v) VERBOSE=$(($VERBOSE + 1));;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+require_command jq
+
+ip neigh help 2>&1 | grep -q "extern_valid"
+if [ $? -ne 0 ]; then
+   echo "SKIP: iproute2 ip too old, missing \"extern_valid\" support"
+   exit $ksft_skip
+fi
+
+trap exit_cleanup_all EXIT
+
+for t in $TESTS
+do
+	setup; $t; cleanup_all_ns;
+done
-- 
2.49.0


