Return-Path: <netdev+bounces-218622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE118B3DA4C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444913BA8DD
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1EB25B1CE;
	Mon,  1 Sep 2025 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CqJXaK69"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69951253F03
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709574; cv=fail; b=CyyHEkcjcVGwLtLh90BXky9ttjzI5+EbsardaTy59P49ZIpOAxtU5oF6OQ4wVHqydpi01vhVr8OEzo/lCxup93aFbJM2N2UGYEVTYWLI8OT0SJc7Eg9lW4zS4PXyVxaEhCTU7XPaYS4n2/j+lhY6e6YHgbsDVSBrx8pnf1NCzn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709574; c=relaxed/simple;
	bh=tPKcT0xhgbGfbzyISl4j7UqNq11RrWCco52dhXfmycI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOFUKQGjWmeGhvjgtCHKfRQE0J5HmCGvw/8r7dT3yMpOetskkEwSSFDMx5wGWlLyjM39W8nTUf71VmGzKlf9/yJaPzTflw8h5GmH32aw3PWtuTrSTEln3f41hFfPMCjqTwatzHRcdxtXnYxkNv6q9KREQWlAakWF852EqWUzjCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CqJXaK69; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFX8vPyta0nBvT/xaksWzTZ26nJcGoWDw15cPDSuKcVVhzA/tPd188aCaiShiG8MBT//6ZyUKyDV9R0EWjR6PAh0OOMfe+IZHiMhp5AV7Tqpr3kG9ONUrRje1Kxo9QXZRUg+PksCMFAmxyrOdY9j1WPNvVs8ng1riP7GoW9eF14Yc9k3gKfzXSp3pSY4AZ7jrHC5Yi7zCqPAyH8KpqVptDwmGGthsJiI2b36pql296M6oOtgrZDvJYYbWaqOqfpsJzBcBv3AYjJdI/zT6RewNNkuGEnrL+Y7WeHJChXiVtVn7YLQhDdPCcPyDli4RfRUZsI4uYqr0v5EIBzUrO0dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXXyHVQidfTJ+F4+OhxM0vW/0mTnmonY4tU8eND/orI=;
 b=X3BiqSGCJHbtNHmG2khZBjkXM3rWqnZZTYRvEmZTlHhG1CajbEpxvPWoK/Md+vDkjnbCSlse5eWndr3QxBRFvhgF6WkiEhowAMGMdzUZdac8FcLgdtWxtrmSvB7Oh7OEoaDGMocqEXESbG1ITNRS+6dOtxECqT+O2LE2ZikMtJt7YK6DnB6CsULPEx2oWi9kJ5/nPlwn2ilQ8BMrAICtKf2zD5pYj/Dcr0NMMSjDUYghX4kGnLUQdhE3BUCLlJklLqJSJVdJTOmWWGXqRqLJirTlAphdY+USrv4H6qD1YYikyt7PudF4+hkcogWvTWHzogYZoeNWhRUb7J5VR0o86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXXyHVQidfTJ+F4+OhxM0vW/0mTnmonY4tU8eND/orI=;
 b=CqJXaK692adJoOq1jUJleZ4o9Pe8Z9J7xPZs5x5BHiRA1NI416b2szjf59EQegz82L9kLH+w36Nj2qgUO2J9uNv93cVcwM4QrUoD0ZnDMBvGU3vU4IjZwliLSeA912sZOicgXiG/HpOXiGqsPyspgagCZ8iB+/lBw9JxxQj8JRHg0tzHkEpoIF7NQbTY9Y+NPVdBom3PS0b58/jCH4fprzKJdavCCzKy5SBkZvEYRxUIAQZgsp7Ts4QWl/jNKzOGLD0XGBlOpRX2aV5pFFXzy+wdxnMaoNjes3DucUGYQHyTNaoQWR4b/xto3ZXsqmdAZdb9cT+DV4KD4SWjj+KQzA==
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Mon, 1 Sep
 2025 06:52:45 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::91) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.10 via Frontend Transport; Mon,
 1 Sep 2025 06:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 06:52:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:24 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:20 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<razor@blackwall.org>, <petrm@nvidia.com>, <mcremers@cloudbear.nl>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net 3/3] selftests: net: Add a selftest for VXLAN with FDB nexthop groups
Date: Mon, 1 Sep 2025 09:50:35 +0300
Message-ID: <20250901065035.159644-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901065035.159644-1-idosch@nvidia.com>
References: <20250901065035.159644-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 8146b330-c244-45e5-7a3a-08dde92427e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EaMV0iq6P00Im7hkL9dJKl5dgg5yNE5Ihr/GYserR4Q8r6a8AYICAMq8dYul?=
 =?us-ascii?Q?7VnWwtBz+vXjk2vVpBbuSCrFPbzyOwehWEaacNSr7oEoJmBuNE0bqkrnhWwn?=
 =?us-ascii?Q?2LQnwNGhCJTlu0yXuvfM+bd2ELYfcDmLOSjE1L92Sm5TSUGdhBvZV8gOjDsV?=
 =?us-ascii?Q?Zt76llyY7KF9TxHkZtGns/L1fBkrwhDZcqSJ+jLEbzDPFevh1st+fwFbbkx3?=
 =?us-ascii?Q?cGnm+Qd9IBsqWH2Jn0qaI58zCBVTrkqaHxTVFroobai0SchNwSifWBowR6ev?=
 =?us-ascii?Q?lmRM0fAXTAeC5jXOL6nXfw5UkNGa16KSEhrFNWIfHKbp0Nu5MvErTcPtapa6?=
 =?us-ascii?Q?u2qxWjunATxXigfXIzcj6CYEH4ZfmbjLFA7MIaB6A29HVkpr68nBrYaqxsWT?=
 =?us-ascii?Q?5Fl3zDlwJIE3rKSN8SMjt28e/eFtm+LbmKFA5+kAseg3mOGviCL+hsrnMZ5M?=
 =?us-ascii?Q?OGVch8Bn6u1z3yc1JdYhurdlsK37GrTch7GFPfm9WpFQW0VXikbN9s49wrPA?=
 =?us-ascii?Q?FM5yjYmMoEisQv4q76xS6jH/mbF/9Z9PRCGm5Maw5n2MAtUgGodf/MHLojo5?=
 =?us-ascii?Q?5mjAZerKYlKN5GKXknzyJLEzUwQSX9rrV5GpR/hFxNPkEzxug8jQitffVDVZ?=
 =?us-ascii?Q?l+yoGh6W2Bt5sVOMomlO5fesdm33UnM/0qOvMAXgnv+IL/aBPu1nklXUty0h?=
 =?us-ascii?Q?7IjWSBOPzPGCeAqAog19Sh4/M1Di777mThvQ6Zm7UHoqbmwXlBNpgU0r3ElP?=
 =?us-ascii?Q?kK1h4Eff2duRvXE62o/JnN0FyfYlDEIvNdBt1sAuQrlvWgayG6kI5SbEwy+z?=
 =?us-ascii?Q?n132SvGUngXmNgYvmp/ACtgqzYPoopps7MvViDogOnRCBbF0F84LKTLH62lI?=
 =?us-ascii?Q?LwV67kJRFR82txa7KDJ5TkBhrlZ0e55QPryH4GSdRhN2K+yT0CPzSSUqwe7W?=
 =?us-ascii?Q?U2tWV/53HRJQ7Da9N17O3PwGdxVgM6poxACipXECXrH6w9lH8zWQW2YhAnF3?=
 =?us-ascii?Q?0vfbehdSY5TyCbZ+3tIWH7XWLyBVRCNLqQScw382XQPHdC3JdA12ox7Z0RzY?=
 =?us-ascii?Q?y+Zmy9wg60p3Tg1ZGBCbfKE/Effks6+TegUPdy+al4z8cmDu0nYrVC8WkXgQ?=
 =?us-ascii?Q?+kX4gmm34Anhn5gGZAqw6U1bB+muvaiHN5nfHtmPi8cr7V9MUmR409QcarPf?=
 =?us-ascii?Q?jQJJ4PIYGljz97FJme04UuYRXiAUHwz13bo+O05XK1FG1rXnlyAgeUPTUKVP?=
 =?us-ascii?Q?RouiAdNMler2W0Yfky0zuql28pqMbPNNU25FhdlOrWHvhQexFMPA+n99JCWi?=
 =?us-ascii?Q?kOsEA+JxFMIgcs95NE1HYwzFWh47XWpxFA04AWRyoY4YUDRNmsiuYGVdlVNP?=
 =?us-ascii?Q?bfShPNGgzijoWnyk0NNrF20JBnA2h6FbyD5Hyp0MrECe+dRz4zCtuiyKnv6f?=
 =?us-ascii?Q?ZOKwwO5o1ojl23SCMHCG2vh4Xo2+ljWTI/T6SmqRIkk2o5r5/vtQk+D1nn+x?=
 =?us-ascii?Q?AwSPl1yqo7jD2Q37rrJTPcSg6tRYz+jGtOAh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:52:45.2178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8146b330-c244-45e5-7a3a-08dde92427e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993

Add test cases for VXLAN with FDB nexthop groups, testing both IPv4 and
IPv6. Test basic Tx functionality as well as some corner cases.

Example output:

 # ./test_vxlan_nh.sh
 TEST: VXLAN FDB nexthop: IPv4 basic Tx                              [ OK ]
 TEST: VXLAN FDB nexthop: IPv6 basic Tx                              [ OK ]
 TEST: VXLAN FDB nexthop: learning                                   [ OK ]
 TEST: VXLAN FDB nexthop: IPv4 proxy                                 [ OK ]
 TEST: VXLAN FDB nexthop: IPv6 proxy                                 [ OK ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/test_vxlan_nh.sh | 223 +++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_vxlan_nh.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b31a71f2b372..c7e03e1d6f63 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -99,6 +99,7 @@ TEST_GEN_PROGS += bind_wildcard
 TEST_GEN_PROGS += bind_timewait
 TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
+TEST_PROGS += test_vxlan_nh.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
 TEST_PROGS += test_neigh.sh
diff --git a/tools/testing/selftests/net/test_vxlan_nh.sh b/tools/testing/selftests/net/test_vxlan_nh.sh
new file mode 100755
index 000000000000..20f3369f776b
--- /dev/null
+++ b/tools/testing/selftests/net/test_vxlan_nh.sh
@@ -0,0 +1,223 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+TESTS="
+	basic_tx_ipv4
+	basic_tx_ipv6
+	learning
+	proxy_ipv4
+	proxy_ipv6
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
+		echo "COMMAND: $cmd"
+		stderr=
+	fi
+
+	out=$(eval "$cmd" "$stderr")
+	rc=$?
+	if [ "$VERBOSE" -eq 1 ] && [ -n "$out" ]; then
+		echo "    $out"
+	fi
+
+	return $rc
+}
+
+################################################################################
+# Cleanup
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
+nh_stats_get()
+{
+	ip -n "$ns1" -s -j nexthop show id 10 | jq ".[][\"group_stats\"][][\"packets\"]"
+}
+
+tc_stats_get()
+{
+	tc_rule_handle_stats_get "dev dummy1 egress" 101 ".packets" "-n $ns1"
+}
+
+basic_tx_common()
+{
+	local af_str=$1; shift
+	local proto=$1; shift
+	local local_addr=$1; shift
+	local plen=$1; shift
+	local remote_addr=$1; shift
+
+	RET=0
+
+	# Test basic Tx functionality. Check that stats are incremented on
+	# both the FDB nexthop group and the egress device.
+
+	run_cmd "ip -n $ns1 link add name dummy1 up type dummy"
+	run_cmd "ip -n $ns1 route add $remote_addr/$plen dev dummy1"
+	run_cmd "tc -n $ns1 qdisc add dev dummy1 clsact"
+	run_cmd "tc -n $ns1 filter add dev dummy1 egress proto $proto pref 1 handle 101 flower ip_proto udp dst_ip $remote_addr dst_port 4789 action pass"
+
+	run_cmd "ip -n $ns1 address add $local_addr/$plen dev lo"
+
+	run_cmd "ip -n $ns1 nexthop add id 1 via $remote_addr fdb"
+	run_cmd "ip -n $ns1 nexthop add id 10 group 1 fdb"
+
+	run_cmd "ip -n $ns1 link add name vx0 up type vxlan id 10010 local $local_addr dstport 4789"
+	run_cmd "bridge -n $ns1 fdb add 00:11:22:33:44:55 dev vx0 self static nhid 10"
+
+	run_cmd "ip netns exec $ns1 mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 1 -q"
+
+	busywait "$BUSYWAIT_TIMEOUT" until_counter_is "== 1" nh_stats_get > /dev/null
+	check_err $? "FDB nexthop group stats did not increase"
+
+	busywait "$BUSYWAIT_TIMEOUT" until_counter_is "== 1" tc_stats_get > /dev/null
+	check_err $? "tc filter stats did not increase"
+
+	log_test "VXLAN FDB nexthop: $af_str basic Tx"
+}
+
+basic_tx_ipv4()
+{
+	basic_tx_common "IPv4" ipv4 192.0.2.1 32 192.0.2.2
+}
+
+basic_tx_ipv6()
+{
+	basic_tx_common "IPv6" ipv6 2001:db8:1::1 128 2001:db8:1::2
+}
+
+learning()
+{
+	RET=0
+
+	# When learning is enabled on the VXLAN device, an incoming packet
+	# might try to refresh an FDB entry that points to an FDB nexthop group
+	# instead of an ordinary remote destination. Check that the kernel does
+	# not crash in this situation.
+
+	run_cmd "ip -n $ns1 address add 192.0.2.1/32 dev lo"
+	run_cmd "ip -n $ns1 address add 192.0.2.2/32 dev lo"
+
+	run_cmd "ip -n $ns1 nexthop add id 1 via 192.0.2.3 fdb"
+	run_cmd "ip -n $ns1 nexthop add id 10 group 1 fdb"
+
+	run_cmd "ip -n $ns1 link add name vx0 up type vxlan id 10010 local 192.0.2.1 dstport 12345 localbypass"
+	run_cmd "ip -n $ns1 link add name vx1 up type vxlan id 10020 local 192.0.2.2 dstport 54321 learning"
+
+	run_cmd "bridge -n $ns1 fdb add 00:11:22:33:44:55 dev vx0 self static dst 192.0.2.2 port 54321 vni 10020"
+	run_cmd "bridge -n $ns1 fdb add 00:aa:bb:cc:dd:ee dev vx1 self static nhid 10"
+
+	run_cmd "ip netns exec $ns1 mausezahn vx0 -a 00:aa:bb:cc:dd:ee -b 00:11:22:33:44:55 -c 1 -q"
+
+	log_test "VXLAN FDB nexthop: learning"
+}
+
+proxy_common()
+{
+	local af_str=$1; shift
+	local local_addr=$1; shift
+	local plen=$1; shift
+	local remote_addr=$1; shift
+	local neigh_addr=$1; shift
+	local ping_cmd=$1; shift
+
+	RET=0
+
+	# When the "proxy" option is enabled on the VXLAN device, the device
+	# will suppress ARP requests and IPv6 Neighbor Solicitation messages if
+	# it is able to reply on behalf of the remote host. That is, if a
+	# matching and valid neighbor entry is configured on the VXLAN device
+	# whose MAC address is not behind the "any" remote (0.0.0.0 / ::). The
+	# FDB entry for the neighbor's MAC address might point to an FDB
+	# nexthop group instead of an ordinary remote destination. Check that
+	# the kernel does not crash in this situation.
+
+	run_cmd "ip -n $ns1 address add $local_addr/$plen dev lo"
+
+	run_cmd "ip -n $ns1 nexthop add id 1 via $remote_addr fdb"
+	run_cmd "ip -n $ns1 nexthop add id 10 group 1 fdb"
+
+	run_cmd "ip -n $ns1 link add name vx0 up type vxlan id 10010 local $local_addr dstport 4789 proxy"
+
+	run_cmd "ip -n $ns1 neigh add $neigh_addr lladdr 00:11:22:33:44:55 nud perm dev vx0"
+
+	run_cmd "bridge -n $ns1 fdb add 00:11:22:33:44:55 dev vx0 self static nhid 10"
+
+	run_cmd "ip netns exec $ns1 $ping_cmd"
+
+	log_test "VXLAN FDB nexthop: $af_str proxy"
+}
+
+proxy_ipv4()
+{
+	proxy_common "IPv4" 192.0.2.1 32 192.0.2.2 192.0.2.3 \
+		"arping -b -c 1 -s 192.0.2.1 -I vx0 192.0.2.3"
+}
+
+proxy_ipv6()
+{
+	proxy_common "IPv6" 2001:db8:1::1 128 2001:db8:1::2 2001:db8:1::3 \
+		"ndisc6 -r 1 -s 2001:db8:1::1 -w 1 2001:db8:1::3 vx0"
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
+		v) VERBOSE=$((VERBOSE + 1));;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+require_command mausezahn
+require_command arping
+require_command ndisc6
+require_command jq
+
+if ! ip nexthop help 2>&1 | grep -q "stats"; then
+	echo "SKIP: iproute2 ip too old, missing nexthop stats support"
+	exit "$ksft_skip"
+fi
+
+trap exit_cleanup_all EXIT
+
+for t in $TESTS
+do
+	setup_ns ns1; $t; cleanup_all_ns;
+done
-- 
2.51.0


