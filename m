Return-Path: <netdev+bounces-78744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9498764AE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17E5284210
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC711E48E;
	Fri,  8 Mar 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lyk6iOe7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9C1CD20
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903020; cv=fail; b=fmNSSgVp7nkNVxrqNm/p72jJwGrxIFyZxhxrtSQu3QRk/7HKaZWwpP9cUIl28LoTrBftxPIb7xjqdjkkwCb8tfXSuypUP+I4uFJYdFmhqeKFP1TvC4ONraEBg5Ygv5rq015w35ojGlAXvZ7E6JXvqHCN1P6B+PlR2Ap45yStnOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903020; c=relaxed/simple;
	bh=bBDcS4DLEyoA3A2s0DqpD9Mxc5daRv9SUnBGZf+jTTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txMYBLMSycwnIqJfSjQWNz5TfaEsOfDpqPRQSRZO3e80XMCtS8A7gGEzV2SkgyLnHvdZ6rFHSf6g6IoTp4UZ7cnpbpwPUanSwzCfKDEhQkuIW6W9ddqlbvmTNxrXyn1uaBI26LgnyxqisIzgN9HURPenlZDJX1FhlqxowfAMedI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lyk6iOe7; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArcFqsdDEvCRiv32dBFJjg0ZloNA3l5NIZZkHv38ycM6Cotxqh0Sj9TsQU7uSoPQd59z0Nw7wVmheI0yjw0FYbyTxEeW1FMghEjwEwm9GhM0MqJX57fU55WpOh7Bo/ZMAbu3LhOM9LX4ySvUze+/ApjRCKToD6kXReR5P+3aCGZcSxVb+RwZQjbS6eBhtPVb2juSMdcjTt7Cnnu/pJCoyi6O1crpdl/fOQ9KRtIdrvh5v9BvYhzNNfHic48Hr+JbSoDIVhigwrDy0IfXcgqZ+9aqtlo635FjKArqQpbYl9V4fti4Nu418/pSIFjkDx0G9RuNBft+SQG6tawA4NZ8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX16NSAhwbIYw1NnHZC3F4kW6In3aTx3xIjLjgMFci4=;
 b=QB1Bv2GuIEZTFMA9WRALOpKlYqvbCfn614edgt1KXMYAoj6FakkQQWDEKaTWeV8mEbX6usDDyujv45HUGry9g4OAEVvVyW1/TTWTMJeU0SthKJ0ewbpx3Feg0508p96IRjm59R5k4NRxjDr2l8zxPnR0PK/1HshBCrGIp/s6O+mOtuOyOSUi3Qk2STpxHw5ar0svWIIbTeysldJpHJqxkhQQbzfFMb4xU4tJLvvInpq5s7ZbEa+E+6H6H7J6ja0RD9dqC58sNq11/zKVCjJPFp0jFutrNsyStw6gHF+OwFx5mKp1zkaivm1oDKcUNQETLemf1tgOkPRU4T1mpWuyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX16NSAhwbIYw1NnHZC3F4kW6In3aTx3xIjLjgMFci4=;
 b=lyk6iOe7ut2UxWQNCIH0sLy6LCMMrMFVo3jZSosjgWE5vD5UWhfTWxoCMBGMad2YZGTBIQPSSmfYxa30fgSKxSyL0GAUvAx+850X+p4ZxYRqYMP946bINmtDGmBLuEjxpfM1sas/rOYqnCdw4WuxGXSkDEMOSsvZtCvZtcVQa89If3NB58sOArcJeYYtXDgoAa24c87q8osZtRsmyloRfaFI/bE1bo+8QJEir/rKhZDSiS2Pwh1jQe5kNAmOmXL4WS+vPvfPQdF+fchv/GpV1ricupC4Wo4w1yZv4NeN5a+qL2gkgAlT6q5RUDcTKzhqXaHSFIWC0U9cW+icBXFO/Q==
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 13:03:34 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::b5) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 13:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:03:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:03:09 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:03:05 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH group stats
Date: Fri, 8 Mar 2024 13:59:55 +0100
Message-ID: <2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: f60525cd-e9de-4987-5b8e-08dc3f7028ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0+R30TdwDAgYcSN+rwJt5tJqkSMeLFpIeoVno5Gr6Vl17ZYn506Nd9qetcWvg1p91hySOdusMMOKwAwL0+13u7jjxtdFNT6a9aiiL6myd9P0MerPQleMYuvMimUuspl0PhCEgEaNTsoFD2ZajTLGvWI/OifsxcNnHYzgaWKjaK0uCvHl/cY0Ax8UKamNKmIbyzbcwg6iThfXi6wpQfebcnlNZuyIfsI/0P3cv4tgouz1yKdbLQSUoxBlyIqc5hK1/Ql5UpcaUgkBkqUpsk45UGiPJRZ34JT9PYTwhCyKn5rnRfAXYm4Mjh67QCwW0cfDKhJ6WlULpkiBw/DxqyZUKQHfqanQA1G91mC5nxkFpu+62qLH4k42kxpvE8FMkpo1vCp/pcGwFBfcyl8zeR2BwLaVAK4W7CcxxFC6+D10x+TibiZIY+fE3FaJC+Uf0A9Lu0HsrW/41TGLv1LY2VLYU7exc1mxvw64CS2dpVM+DuIa4JQ+R2WwqHuLzB1oa/IcGq9uT5bEVTr95d/4Fk2WiUMFnQdcD1WqJiCzrF0jfTZs3jx49CQe3pBQZSZ6w1qpbPO1Si5E6NLw1omdu2l/wFzrUy/yvC+PF9Wk7HMM4CJc1CqCRHSLWLAF2N4fOlexrdE6D1NsdJ55jYb7HBsYlBKVxLqgeOsxX/ibuS9YnH3hRvrelkNtdcsDauLGo86inYoA+4iuvMxoF3+yjWO/tjd2ZF6PMiRmlR2uDNy7mhxlW7rc8YsIKpjre5mqqpm8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:03:33.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60525cd-e9de-4987-5b8e-08dc3f7028ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

Add to lib.sh support for fetching NH stats, and a new library,
router_mpath_nh_lib.sh, with the common code for testing NH stats.
Use the latter from router_mpath_nh.sh and router_mpath_nh_res.sh.

The test works by sending traffic through a NH group, and checking that the
reported values correspond to what the link that ultimately receives the
traffic reports having seen.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |  34 +++++
 .../net/forwarding/router_mpath_nh.sh         |  13 ++
 .../net/forwarding/router_mpath_nh_lib.sh     | 129 ++++++++++++++++++
 .../net/forwarding/router_mpath_nh_res.sh     |  13 ++
 5 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index cdefc9a5ec34..535865b3d1d6 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -123,6 +123,7 @@ TEST_FILES := devlink_lib.sh \
 	mirror_gre_topo_lib.sh \
 	mirror_lib.sh \
 	mirror_topo_lib.sh \
+	router_mpath_nh_lib.sh \
 	sch_ets_core.sh \
 	sch_ets_tests.sh \
 	sch_tbf_core.sh \
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d1bf39eaf2b3..e579c2e0c462 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -900,6 +900,33 @@ hw_stats_get()
 		jq ".[0].stats64.$dir.$stat"
 }
 
+__nh_stats_get()
+{
+	local key=$1; shift
+	local group_id=$1; shift
+	local member_id=$1; shift
+
+	ip -j -s -s nexthop show id $group_id |
+	    jq --argjson member_id "$member_id" --arg key "$key" \
+	       '.[].group_stats[] | select(.id == $member_id) | .[$key]'
+}
+
+nh_stats_get()
+{
+	local group_id=$1; shift
+	local member_id=$1; shift
+
+	__nh_stats_get packets "$group_id" "$member_id"
+}
+
+nh_stats_get_hw()
+{
+	local group_id=$1; shift
+	local member_id=$1; shift
+
+	__nh_stats_get packets_hw "$group_id" "$member_id"
+}
+
 humanize()
 {
 	local speed=$1; shift
@@ -2010,3 +2037,10 @@ bail_on_lldpad()
 		fi
 	fi
 }
+
+absval()
+{
+	local v=$1; shift
+
+	echo $((v > 0 ? v : -v))
+}
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index 982e0d098ea9..3f0f5dc95542 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -7,9 +7,12 @@ ALL_TESTS="
 	multipath_test
 	ping_ipv4_blackhole
 	ping_ipv6_blackhole
+	nh_stats_test_v4
+	nh_stats_test_v6
 "
 NUM_NETIFS=8
 source lib.sh
+source router_mpath_nh_lib.sh
 
 h1_create()
 {
@@ -325,6 +328,16 @@ ping_ipv6_blackhole()
 	ip -6 nexthop del id 1001
 }
 
+nh_stats_test_v4()
+{
+	__nh_stats_test_v4 mpath
+}
+
+nh_stats_test_v6()
+{
+	__nh_stats_test_v6 mpath
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
new file mode 100644
index 000000000000..7e7d62161c34
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0
+
+nh_stats_do_test()
+{
+	local what=$1; shift
+	local nh1_id=$1; shift
+	local nh2_id=$1; shift
+	local group_id=$1; shift
+	local stats_get=$1; shift
+	local mz="$@"
+
+	local dp
+
+	RET=0
+
+	sleep 2
+	for ((dp=0; dp < 60000; dp += 10000)); do
+		local dd
+		local t0_rp12=$(link_stats_tx_packets_get $rp12)
+		local t0_rp13=$(link_stats_tx_packets_get $rp13)
+		local t0_nh1=$($stats_get $group_id $nh1_id)
+		local t0_nh2=$($stats_get $group_id $nh2_id)
+
+		ip vrf exec vrf-h1 \
+			$mz -q -p 64 -d 0 -t udp \
+				"sp=1024,dp=$((dp))-$((dp + 10000))"
+		sleep 2
+
+		local t1_rp12=$(link_stats_tx_packets_get $rp12)
+		local t1_rp13=$(link_stats_tx_packets_get $rp13)
+		local t1_nh1=$($stats_get $group_id $nh1_id)
+		local t1_nh2=$($stats_get $group_id $nh2_id)
+
+		local d_rp12=$((t1_rp12 - t0_rp12))
+		local d_rp13=$((t1_rp13 - t0_rp13))
+		local d_nh1=$((t1_nh1 - t0_nh1))
+		local d_nh2=$((t1_nh2 - t0_nh2))
+
+		dd=$(absval $((d_rp12 - d_nh1)))
+		((dd < 10))
+		check_err $? "Discrepancy between link and $stats_get: d_rp12=$d_rp12 d_nh1=$d_nh1"
+
+		dd=$(absval $((d_rp13 - d_nh2)))
+		((dd < 10))
+		check_err $? "Discrepancy between link and $stats_get: d_rp13=$d_rp13 d_nh2=$d_nh2"
+	done
+
+	log_test "NH stats test $what"
+}
+
+nh_stats_test_dispatch_swhw()
+{
+	local what=$1; shift
+	local nh1_id=$1; shift
+	local nh2_id=$1; shift
+	local group_id=$1; shift
+	local mz="$@"
+
+	local used
+
+	nh_stats_do_test "$what" "$nh1_id" "$nh2_id" "$group_id" \
+			 nh_stats_get "${mz[@]}"
+
+	used=$(ip -s -j -d nexthop show id $group_id |
+		   jq '.[].hw_stats.used')
+	kind=$(ip -j -d link show dev $rp11 |
+		   jq -r '.[].linkinfo.info_kind')
+	if [[ $used == true ]]; then
+		nh_stats_do_test "HW $what" "$nh1_id" "$nh2_id" "$group_id" \
+				 nh_stats_get_hw "${mz[@]}"
+	elif [[ $kind == veth ]]; then
+		log_test_skip "HW stats not offloaded on veth topology"
+	fi
+}
+
+nh_stats_test_dispatch()
+{
+	local nhgtype=$1; shift
+	local what=$1; shift
+	local nh1_id=$1; shift
+	local nh2_id=$1; shift
+	local group_id=$1; shift
+	local mz="$@"
+
+	local enabled
+	local kind
+
+	if ! ip nexthop help 2>&1 | grep -q hw_stats; then
+		log_test_skip "NH stats test: ip doesn't support HW stats"
+		return
+	fi
+
+	ip nexthop replace id $group_id group $nh1_id/$nh2_id \
+			   hw_stats on type $nhgtype
+	enabled=$(ip -s -j -d nexthop show id $group_id |
+		      jq '.[].hw_stats.enabled')
+	if [[ $enabled == true ]]; then
+		nh_stats_test_dispatch_swhw "$what" "$nh1_id" "$nh2_id" \
+					    "$group_id" "${mz[@]}"
+	elif [[ $enabled == false ]]; then
+		check_err 1 "HW stats still disabled after enabling"
+		log_test "NH stats test"
+	else
+		log_test_skip "NH stats test: ip doesn't report hw_stats info"
+	fi
+
+	ip nexthop replace id $group_id group $nh1_id/$nh2_id \
+			   hw_stats off type $nhgtype
+}
+
+__nh_stats_test_v4()
+{
+	local nhgtype=$1; shift
+
+	sysctl_set net.ipv4.fib_multipath_hash_policy 1
+	nh_stats_test_dispatch $nhgtype "IPv4" 101 102 103 \
+			       $MZ $h1 -A 192.0.2.2 -B 198.51.100.2
+	sysctl_restore net.ipv4.fib_multipath_hash_policy
+}
+
+__nh_stats_test_v6()
+{
+	local nhgtype=$1; shift
+
+	sysctl_set net.ipv6.fib_multipath_hash_policy 1
+	nh_stats_test_dispatch $nhgtype "IPv6" 104 105 106 \
+			       $MZ -6 $h1 -A 2001:db8:1::2 -B 2001:db8:2::2
+	sysctl_restore net.ipv6.fib_multipath_hash_policy
+}
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index a60ff54723b7..4b483d24ad00 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -5,9 +5,12 @@ ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
 	multipath_test
+	nh_stats_test_v4
+	nh_stats_test_v6
 "
 NUM_NETIFS=8
 source lib.sh
+source router_mpath_nh_lib.sh
 
 h1_create()
 {
@@ -333,6 +336,16 @@ multipath_test()
 	ip nexthop replace id 106 group 104,1/105,1 type resilient
 }
 
+nh_stats_test_v4()
+{
+	__nh_stats_test_v4 resilient
+}
+
+nh_stats_test_v6()
+{
+	__nh_stats_test_v6 resilient
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.43.0


