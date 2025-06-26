Return-Path: <netdev+bounces-201426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDDEAE96D3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C487AA1D6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5EE25D8FB;
	Thu, 26 Jun 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lf2BAcaD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0325C83C
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923205; cv=fail; b=cWh0I6WelmR7vRyd2HHYGb/aCdTauwAukEnAWIdP+WF6PpDSRcdj9UJztn/ZYo025zUmDJnI8zhIxW7I6bDOzvDWGrSPgUXvCILfsEoCPzKZrZcik+doNHbiZ2JOdngs1Te34qhEdsBIyQhd88a9UC6nS51yvnJL/a4Rn+MzvOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923205; c=relaxed/simple;
	bh=LpH9Eni4OmFaM4QGkS6uqilr7OPRlcgYgyVmzOxhJZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8Khe+wV2xqykCOHu6TLF1Jcl0W5dZVpiZH7SqjbzZvuJ80Uk/ArJGhmHJuPcyrskcx+I69ilH0ZM/gGDg/ZL5ewqDu3JVrBQtyD7x3zpIHtWbml1aLCiPlBahZ590MwJ2AwszPQe724VU14DTOnU77XbKZLx92+cmeAoUgMymc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lf2BAcaD; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK7mUy1O3U5z4q1LXFrQz6vtkZLQCO0Ts8K1LrLuPxUHtUmzSpSXP3JM2TxulPRYGr391ZMP0uCXL7qVFcIe0DCqCoQz3Lu3TiSiTuHJhgYY11oWjksrIqDEG1sKAYANAtwtfDTwmGLUL6lpRdCSuE/hh+rBAbq82jD4yKNzTW9c5oASAKAZopgssyOnmvuPnImzHT3Y+UYLcGsGzbbDwlJI0mE8ZGI5KuiSU87ODNygdSvykUweqJN0bB8niHUi1GPeMzn+l9dmflbiYTlzMOngYBhjjRFW+DD0XJgFx4nSLeRG1GzMvAUJGJ7/IGuwU/dGvUmcT7jBPoNSAxj7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJynllkoeBAVXA2Ea7h6PVGJwwvmEeIBSFc8oMDYarI=;
 b=u98CqcqXyAt+zrzQxwR/U81k5JTwBkLd5KLDoM5fcUHdipvpq68Necwhu6D/DBgELs4GJCG2EyuyCSnnVudFTtdZ17UC3ModErM7DorbER+BPK2tttGJ07fbD/wrn5VFhXLwB1SQU1zcGfc5hwXqWYe79DkpHoDgRzXdcPjXtlzIz1hvjqyz1XZ4W48imt4Ld3JEbgBpGdJXCbWTbfGIeyoZzNj39QjzQDvVXXkp4ZRX9r3SzJT/33ovmLJHhptJPaSWx/pxeuo3mQpW8DTWd0j04a3EUO1KHnzuWnICihEwhDXFczixxRo7c6QgcvaspmLgBQw3SPiUjsJd8f0DXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJynllkoeBAVXA2Ea7h6PVGJwwvmEeIBSFc8oMDYarI=;
 b=lf2BAcaDfbz8oKfOsDlw0WrcEUjWGTkb6iIbpauPM286ix1sl8GVmGygBFueZOkrtVhxZ6VEZ3S08puoP5EaUcBUFNEz2idSxV/Pz4duJAzvFGGZjLUEdso17HmbLfsa79Ae3PD2cTVFdszC+YUqwfDnQjQY1h5c4hXbpN7lY6di2MPe8Wg9W+6wyTk2trd0VN9ABXk+0zdgwfhKD9zJTPtxtFd8KH+Fpl2QNbc74VBX2CGsnpqOj78KMpiJr/l5sJGmLTYAEGbUOmNxBwbDcmkiQoQ8kqqhcGGBg3eKQtUJaCl67NeEffXKTjDI1tGAXZfVgV1s1rwwEzbbLE995g==
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 26 Jun
 2025 07:33:14 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::ce) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 07:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 07:33:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 00:32:56 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 00:32:30 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <daniel@iogearbox.net>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/2] selftests: net: Add a selftest for externally validated neighbor entries
Date: Thu, 26 Jun 2025 10:31:11 +0300
Message-ID: <20250626073111.244534-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626073111.244534-1-idosch@nvidia.com>
References: <20250626073111.244534-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: de70d907-e24a-4421-087c-08ddb483b5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQy2d8FsUIYpJgqmqcAcl7g56aFcXQTLb8whjzaicqnhHED3b2A20G3LsKQm?=
 =?us-ascii?Q?IyP8Y+GNB58Klds/6Zjfm47vA6jVzMX/eE4bFdeNkP/JJF3HnWH+Fqoc+VTS?=
 =?us-ascii?Q?KmswZ6AwB+RYbTs/wiewdFZs3c5Arg+o3DtidLHD0Rmy4mIdRynHpBmMlM99?=
 =?us-ascii?Q?tXMl6dkz9dlR7ZdEVcnRmWzEVF507CfrqVC7iK4bHCRr1YwODh6TOO70vndM?=
 =?us-ascii?Q?RBosuyL0cIIFyK+yQRRwGC4dVqdm8GwiUHiSdaykKyxB8ZKRfIcuOAkJhV+s?=
 =?us-ascii?Q?FBiFWiO09hWt3GTvEizKYzfdpgMZoCeaAlZGOBYMMHaSgMcUI4RGUyaWMXH4?=
 =?us-ascii?Q?b14JflZ2tCJ9i0xnVpoVii0LtzjlGMOhhlLBpwAnKeJ4RruCQXH7aNX9uhcC?=
 =?us-ascii?Q?+Y0653o8lscjmUYWmWO9eoMCkt8VezQZc9XONSfp35YXtN7CisJ43j/PtTZW?=
 =?us-ascii?Q?ylURzgncvAFXI1RjfFUjwIGapj+hYHa/qjccegKYeGM60ebYP1R2QGLbi49d?=
 =?us-ascii?Q?0qNhA7QbL6V1q/N9Q3TfoEnWA8TfBWBTZkgzm/6RhgZCpj04w5SkkbKRVDt8?=
 =?us-ascii?Q?2NGdRMF3f0nspgwM6tNV8iYs9KzezNbYpm47CyXrkqdL41WhXKuUnsVT0D76?=
 =?us-ascii?Q?/UtQRRNDV5/eV5+heleXD5rGVzlSN1Ckb4xOTgqsbXlHR//XLRken1reLD33?=
 =?us-ascii?Q?P+TK4dQJ8pgkx269d1JDyDndRHfMsHEtWMYdzy9rSuKWoVh8UY4Sc9D/ZkJH?=
 =?us-ascii?Q?TX2pfp/GfSm7A6EZTa9xOCndAyouAGVfyeH5paPdgMPh8huvZ34lhs1lsC5z?=
 =?us-ascii?Q?75AOW4/KgpLc1S6e0vDNwLhwqbiq1BfG/lU7Hb4U/7ViyA+q3nHcVjooS0Fd?=
 =?us-ascii?Q?yGgD3L1IVakGBCzDnKvxD08uFgegyzXqb8AIc7CSwbvmUSXhTHsATvh56BCJ?=
 =?us-ascii?Q?3pG02fmiBYu/tiiqgaYNscAZDArNEe8DOOzfVTozYsVyHsaLm523Jj5pBRj4?=
 =?us-ascii?Q?xVfbytj9oZf3hRRYAcf+I7a1dRLqTYB2oLowToGXsI5RQwh8YHIoDUrA8pqX?=
 =?us-ascii?Q?T4/OYhSaZKU/Prmnq+0Zczl5vLqaN/ayPl3yygawhcRHcKj1PZPKqXAfnlpN?=
 =?us-ascii?Q?9nPitXy4Szecmpo8jerXDbwm1DsVD/5k6pEIxqPNKhA+4yDiwuRQGYY3GVp2?=
 =?us-ascii?Q?RV+h55cIVc21CTmitZE02ht/h1obKKyuETq/x4dzmIgCmft3r5/nxhGMTNiW?=
 =?us-ascii?Q?ElJoQP9fyAM5pA8DAPiMlqXIlwPAGpWbF6Dn1COJzVLFoTKyrRDAMdv+r5+V?=
 =?us-ascii?Q?BR2vhXFOe6fMAYQiwhTl6tTVC/vtl1rCWOnCyDF7XhyFt0IKgllQcVMq1RPE?=
 =?us-ascii?Q?nYWg2sicCrvjPzKMqNc38qGhxWPebVRyJQfaupZFY0BfTlkbPnn81dvk0bmQ?=
 =?us-ascii?Q?eDGQCSHMh26Xpg2lA1XaVJkc11R3F8hHteIiWdKC1gsY9k14cHcHChzmYxDt?=
 =?us-ascii?Q?+tHGxtsl44WCCstfgq9fRPCAM2alNIE0rGI9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:33:14.0308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de70d907-e24a-4421-087c-08ddb483b5eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

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
 TEST: IPv4 "extern_valid" flag: Interface down                      [ OK ]
 TEST: IPv4 "extern_valid" flag: Carrier down                        [ OK ]
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
 TEST: IPv6 "extern_valid" flag: Interface down                      [ OK ]
 TEST: IPv6 "extern_valid" flag: Carrier down                        [ OK ]
 TEST: IPv6 "extern_valid" flag: Transition to "reachable" state     [ OK ]
 TEST: IPv6 "extern_valid" flag: Transition back to "stale" state    [ OK ]
 TEST: IPv6 "extern_valid" flag: Forced garbage collection           [ OK ]
 TEST: IPv6 "extern_valid" flag: Periodic garbage collection         [ OK ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    
    * Fix various shellcheck warnings.
    * Add tests for interface and carrier down.

 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/test_neigh.sh | 366 ++++++++++++++++++++++
 2 files changed, 367 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_neigh.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 227f9e067d25..543776596529 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -100,6 +100,7 @@ TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
+TEST_PROGS += test_neigh.sh
 TEST_PROGS += fdb_flush.sh fdb_notify.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
new file mode 100755
index 000000000000..388056472b5b
--- /dev/null
+++ b/tools/testing/selftests/net/test_neigh.sh
@@ -0,0 +1,366 @@
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
+# Setup
+
+setup()
+{
+	set -e
+
+	setup_ns ns1 ns2
+
+	ip -n "$ns1" link add veth0 type veth peer name veth1 netns "$ns2"
+	ip -n "$ns1" link set dev veth0 up
+	ip -n "$ns2" link set dev veth1 up
+
+	ip -n "$ns1" address add 192.0.2.1/24 dev veth0
+	ip -n "$ns1" address add 2001:db8:1::1/64 dev veth0 nodad
+	ip -n "$ns2" address add 192.0.2.2/24 dev veth1
+	ip -n "$ns2" address add 2001:db8:1::2/64 dev veth1 nodad
+
+	ip netns exec "$ns1" sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
+	ip netns exec "$ns2" sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
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
+	mac=$(ip -n "$ns2" -j link show dev veth1 | jq -r '.[]["address"]')
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
+	# Check that an "extern_valid" entry is flushed when the interface is
+	# put administratively down.
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 link set dev veth0 down"
+	run_cmd "ip -n $ns1 link set dev veth0 up"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0"
+	check_fail $? "\"extern_valid\" entry not flushed upon interface down"
+
+	log_test "$af_str \"extern_valid\" flag: Interface down"
+
+	RET=0
+
+	# Check that an "extern_valid" entry is not flushed when the interface
+	# loses its carrier.
+	run_cmd "ip -n $ns1 neigh flush dev veth0"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns2 link set dev veth1 down"
+	run_cmd "ip -n $ns2 link set dev veth1 up"
+	run_cmd "sleep 2"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0"
+	check_err $? "\"extern_valid\" entry flushed upon carrier down"
+
+	log_test "$af_str \"extern_valid\" flag: Carrier down"
+
+	RET=0
+
+	# Check that when entry transitions to "reachable" state it maintains
+	# the "extern_valid" flag. Wait "delay_probe" seconds for ARP request /
+	# NS to be sent.
+	local delay_probe
+
+	delay_probe=$(ip -n "$ns1" -j ntable show dev veth0 name "$tbl_name" | jq '.[]["delay_probe"]')
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
+	retrans_time=$(ip -n "$ns1" -j ntable show dev veth0 name "$tbl_name" | jq '.[]["retrans"]')
+	ucast_probes=$(ip -n "$ns1" -j ntable show dev veth0 name "$tbl_name" | jq '.[]["ucast_probes"]')
+	app_probes=$(ip -n "$ns1" -j ntable show dev veth0 name "$tbl_name" | jq '.[]["app_probes"]')
+	mcast_reprobes=$(ip -n "$ns1" -j ntable show dev veth0 name "$tbl_name" | jq '.[]["mcast_reprobes"]')
+	delay=$((delay_probe + (ucast_probes + app_probes + mcast_reprobes) * retrans_time))
+	run_cmd "sleep $((delay / 1000 + 2))"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"STALE\""
+	check_err $? "Entry did not return to \"stale\" state"
+	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
+	check_err $? "Entry did not maintain \"extern_valid\" flag after returning to \"stale\" state"
+	probes=$(ip -n "$ns1" -j -s neigh get "$ip_addr" dev veth0 | jq '.[]["probes"]')
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
+	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_thresh2=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh2")) | .["thresh2"]')
+	orig_thresh3=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh3")) | .["thresh3"]')
+	run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
+	run_cmd "sleep 5"
+	forced_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
+	for i in {1..20}; do
+		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
+	done
+	forced_gc_runs_t1=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
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
+	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_base_reachable=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
+	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable 10000"
+	orig_gc_stale=$(ip -n "$ns1" -j ntable show name "$tbl_name" dev veth0 | jq '.[]["gc_stale"]')
+	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 5000"
+	# Wait orig_base_reachable/2 for the new interval to take effect.
+	run_cmd "sleep $(((orig_base_reachable / 1000) / 2 + 2))"
+	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
+	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
+	for i in {1..20}; do
+		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
+	done
+	periodic_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
+	run_cmd "sleep 10"
+	periodic_gc_runs_t1=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
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
+		v) VERBOSE=$((VERBOSE + 1));;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+require_command jq
+
+if ! ip neigh help 2>&1 | grep -q "extern_valid"; then
+	echo "SKIP: iproute2 ip too old, missing \"extern_valid\" support"
+	exit "$ksft_skip"
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


