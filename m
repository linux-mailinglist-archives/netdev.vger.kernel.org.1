Return-Path: <netdev+bounces-130936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B2598C1F2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8490F284B79
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ADF1CB327;
	Tue,  1 Oct 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7tG6+hF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D941CB31C
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797542; cv=fail; b=NVQ+Z3Due0BAKtRnWUgSlW13V4QYMRw0d7jrlX/LrVOY3dxdhMUq6O/DkA1UcvWset7oYGBkhYCuOd7ryzzDZ/YrpupNL/psrfZzt33eynINjWqjK3ZdYTLtN5WaWWWIc5y5Mc5XXnpc9WpAtbrdD+0UxJ/WBk3oa0GOCxgPhv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797542; c=relaxed/simple;
	bh=R4HQ6h8qJ5HeNsTCV/OInTmLRbHsWR0GS4zPrJsT8SY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Po+9koF0BDHUoH5FWkIQc4JuWXmFGax22LJWseJp3Y/Dz12iDFQP4uBpW981ybql2BbKbJEi1d9XnxRYiTUKgIIYvILHsJTfiYHb/vaE18eaYEV5ff8mUwpxkL3HcWJuzXzgZlosqgv+2DUhqbPx7CK7PFqJKERKHejw2WIpVbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7tG6+hF; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvIc+JMhARnAW80XWxWtqygjAHjR7BYdrm1OxMjFcYvC11xAzWLvKwVuWTZRLCVj8JtVyRKqziGVdCJT6Wfy1k6xX0PZhJrquo/PvzTo7i0lX+D9t98h8A/dwBMCX/SR3EmmoIaLkKoPJykaozHUbmPbfXKAxa439mE5ro0/EOnyJ9MPEeElb2Nz72UCALVdZN7Vo9oSOCWh5B/8J6cGn52/TEUNX4aOZyACu8eSkh/mzfrjG5X7x8skQiV0vf5OaokKWmdQm0R+xjOEKmIBxszmiwKAIWRG66/n/PeyG30PbDLI5IEV2GRP3oY0aB7XIRRQyNJxOYDuyxRELhPtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsAuyzqqwTN+PBchgNdiSW8ENBndhDxfE12UnJJ5kdg=;
 b=CqJ2IVgrftA+0tW/qE3qa7TbM7OsxrCSYztgTjykGh32lLg6SrN/0xi3DYdlRTAAMgl1TXaU+hyx5DtGlUdLNXlKz8gazTfXL3DYbIn0lA6HRnLHc/iUFrLpycPeodrZa85XSjcwmPBbkclQXFJX2uGFAVkLi+UrGfPcv6A7PRMVQ7g6teWcLxqUYsRwB+lx7UP9dHtz88Eetmg1kLpQGGKeVe3CN0qC13XAE/AAhpI5beTg4xBEnRK9PvJ1h773p2Y6X5/CxWKuSBCNjl1VGuT5GEbwE6W7Bz3jLc02AZt5QZa7CVWQF5DyeLcBPSbp+wrL1ukN7sk7jsEBfz2F9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsAuyzqqwTN+PBchgNdiSW8ENBndhDxfE12UnJJ5kdg=;
 b=V7tG6+hFwjHjV+SrJQauB8lDPOskSIjpF3Gw7Hypdm4xPUEhqYNJTmwVStL7qvMOaiPOhzgnrZwbh4/dKP4r/o/aRmmFv8L1eMyQqhbhQUoDW1IptxWkPu0EcJvp8RjjyUZ8PpkWc0MbxGy4o4L0G5vZCutgL5Fdy6MZ4qJcEZa6ksMh/JUBQN+hesyjzsVKKCp3VqYAyVsE8AXyVKUCezmggHdkF/hhafkVgkJzXa++v/hcPEIIKTa8eMHLxUW88xNrClfT186giONNEGIIJk38/7WSsC+NysWify2cJGwSyRlmktUqds2Evi0i0mQUPAfJ01P2Ueff6LrUXj9qLw==
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 15:45:37 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::2c) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.11 via Frontend
 Transport; Tue, 1 Oct 2024 15:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 15:45:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 08:45:21 -0700
Received: from tetra-01.mvlab.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 08:45:20 -0700
From: Andy Roulin <aroulin@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <pablo@netfilter.org>, <kadlec@netfilter.org>, <roopa@nvidia.com>,
	<razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<idosch@nvidia.com>, <petrm@nvidia.com>, Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net 2/2] selftests: add regression test for br_netfilter panic
Date: Tue, 1 Oct 2024 08:44:00 -0700
Message-ID: <20241001154400.22787-3-aroulin@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241001154400.22787-1-aroulin@nvidia.com>
References: <20241001154400.22787-1-aroulin@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: be7b3c71-a677-4565-1303-08dce230181e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdtx9WC5Prq3Q1p0ZjYrVq979FK3rNlv2RfP4n3uquWi0Tc5FfFA+dXHR31M?=
 =?us-ascii?Q?2Boo0XOWe/S1sq+GIEultkNeFHYd5cxrB6M6AQVo9nvzY/Gl2wezHMlPnNzD?=
 =?us-ascii?Q?2ClrGJkPSEPZn0VkqTITln02lTR2mqEQjr5rbsFOVJuprEULYPKugqCpj+wM?=
 =?us-ascii?Q?M3cemVZQgRiUgcUiHTtIl+oO+LQCp9meKzN3V1xwRmke1ll0y1G3I2kHag3N?=
 =?us-ascii?Q?QJu+ZPcx4YUlZqzbjJb5ZZx9XKAC8kgQlx6YXu43OxSVm/JmMRa/B4Rv73ZP?=
 =?us-ascii?Q?PpnHk/wtc5fozpxfJsJtiki1XF+/QVXgORmm9fXfTUlCwc0kIONHfKJ2JpyL?=
 =?us-ascii?Q?vrZ6S/Ia5W6tHJYNPjWcJHNC6xFRKu+MBnl0Hqwevlm5jrTf5jEK5Fj6Qkvt?=
 =?us-ascii?Q?L2t/6ulUkFFjGvfYJ4kN5lpRzjI8shBfhP8D9sY3NaeDbqnR+hj9eBfoPe2h?=
 =?us-ascii?Q?Yv3kE6C+LKR2PMDDaO7lpreX9t1CQMGIHbY2d77Gunb3j5tdLupC//SEe/xp?=
 =?us-ascii?Q?7N9C1iV/fnTrM/NdqD9TqMovDiT+W6y7zym5r0jjdwC1KPWPqNXxr5SoZLcg?=
 =?us-ascii?Q?Vx1ez6pU1uYBVYw1F1UNxtVgNyGbF4rge32BnYwoOZLA0+dMNA2FQPMjI147?=
 =?us-ascii?Q?YvS3QqMJ0Yyp/zovO5EonwXlkKFLqglTUQhCTivqRCTwWsee345fdXWs+JBf?=
 =?us-ascii?Q?oxma3BuE8l9+tI4KRh59rOUs9XCCSKmIAzciFipdvzNEgQ8C/QoGggeZ4zBi?=
 =?us-ascii?Q?xiWcIgwb9x0kj2xtMjlB6HWbGiozIBTvJeVuO64SzTRfiWGP96LHtI2zeP4l?=
 =?us-ascii?Q?g4LJeRfrr1xBL1Y2ntFLf/jQXZesD1fYyMDaguPC1F5rdq94XqoY9AVLAdyo?=
 =?us-ascii?Q?gztcjJtsCPHsxkhaArvz/O4/n6j5a5dy6QVrAIuxLBae2JM4wKCVG/UYhfYZ?=
 =?us-ascii?Q?4YkXFwoPnxTZy7cKA0EGDWFrUD94+sECnAN+nyER1ke0KWPZmUhEkS+OykZS?=
 =?us-ascii?Q?wSr7Vkh2u1zx5T2H2XC1x0lG168asNcH/fvpcpGYL0eUmiAtvpx7aVUOhiCH?=
 =?us-ascii?Q?0MVq2GPAQYdex/QrMuBv+B7hnqSklOoAq6IQ3Vpu4sTVNU/ik/nYrLs0NcLV?=
 =?us-ascii?Q?LwFgRzB8+wdEVFV0BKQnv7hG0G5EVX/jFjGGuPAEuRBBdSyQq1DWnR3LPXE5?=
 =?us-ascii?Q?CMHh4WjB6KVsQjLlusu23pgMTLdBUUcukCGrF5EU858dmX2uIzbZw4fPFENF?=
 =?us-ascii?Q?dbAb7ihAo8dAah9gAGZ2x9yYI5RAauYkn2o09DCvhVfKDUIwH5c4veJI32mB?=
 =?us-ascii?Q?wzUmXu7lnb58ILKUbfymcibgpNMqVyqMWq+q5oc0bFATNgpx1gaPrDERmC9E?=
 =?us-ascii?Q?raK6tztOJlXBIcgyjT7wDkZ90AOjXhTPckaSYCsI5G/CooMqq8lBNtORid0W?=
 =?us-ascii?Q?NiHIGsK3jQe8CDHvAPPmK144g39RSjF3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 15:45:37.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b3c71-a677-4565-1303-08dce230181e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747

Add a new netfilter selftests to test against br_netfilter panics when
VxLAN single-device is used together with untagged traffic and high MTU.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 tools/testing/selftests/net/netfilter/config  |   2 +
 .../selftests/net/netfilter/vxlan_mtu_frag.sh | 121 ++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/vxlan_mtu_frag.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index e6c9e777fead..542f7886a0bc 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -31,6 +31,7 @@ TEST_PROGS += nft_tproxy_tcp.sh
 TEST_PROGS += nft_tproxy_udp.sh
 TEST_PROGS += nft_zones_many.sh
 TEST_PROGS += rpath.sh
+TEST_PROGS += vxlan_mtu_frag.sh
 TEST_PROGS += xt_string.sh
 
 TEST_PROGS_EXTENDED = nft_concat_range_perf.sh
diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index c5fe7b34eaf1..43d8b500d391 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -7,6 +7,7 @@ CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
 CONFIG_BRIDGE_NETFILTER=m
 CONFIG_BRIDGE_NF_EBTABLES=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CGROUP_BPF=y
 CONFIG_DUMMY=m
 CONFIG_INET_ESP=m
@@ -84,6 +85,7 @@ CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_TPROXY=m
 CONFIG_VETH=m
 CONFIG_VLAN_8021Q=m
+CONFIG_VXLAN=m
 CONFIG_XFRM_USER=m
 CONFIG_XFRM_STATISTICS=y
 CONFIG_NET_PKTGEN=m
diff --git a/tools/testing/selftests/net/netfilter/vxlan_mtu_frag.sh b/tools/testing/selftests/net/netfilter/vxlan_mtu_frag.sh
new file mode 100755
index 000000000000..912cb9583af1
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/vxlan_mtu_frag.sh
@@ -0,0 +1,121 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+if ! modprobe -q -n br_netfilter 2>&1; then
+        echo "SKIP: Test needs br_netfilter kernel module"
+        exit $ksft_skip
+fi
+
+cleanup()
+{
+        cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup_ns host vtep router
+
+create_topology()
+{
+    ip link add host-eth0 netns "$host" type veth peer name vtep-host netns "$vtep"
+    ip link add vtep-router netns "$vtep" type veth peer name router-vtep netns "$router"
+}
+
+setup_host()
+{
+    # bring ports up
+    ip -n "$host" addr add 10.0.0.1/24 dev host-eth0
+    ip -n "$host" link set host-eth0 up
+
+    # Add VLAN 10,20
+    for vid in 10 20; do
+        ip -n "$host" link add link host-eth0 name host-eth0.$vid type vlan id $vid
+        ip -n "$host" addr add 10.0.$vid.1/24 dev host-eth0.$vid
+        ip -n "$host" link set host-eth0.$vid up
+    done
+}
+
+setup_vtep()
+{
+    # create bridge on vtep
+    ip -n "$vtep" link add name br0 type bridge
+    ip -n "$vtep" link set br0 type bridge vlan_filtering 1
+
+    # VLAN 10 is untagged PVID
+    ip -n "$vtep" link set dev vtep-host master br0
+    bridge -n "$vtep" vlan add dev vtep-host vid 10 pvid untagged
+
+    # VLAN 20 as other VID
+    ip -n "$vtep" link set dev vtep-host master br0
+    bridge -n "$vtep" vlan add dev vtep-host vid 20
+
+    # single-vxlan device on vtep
+    ip -n "$vtep" address add dev vtep-router 60.0.0.1/24
+    ip -n "$vtep" link add dev vxd type vxlan external \
+        vnifilter local 60.0.0.1 remote 60.0.0.2 dstport 4789 ttl 64
+    ip -n "$vtep" link set vxd master br0
+
+    # Add VLAN-VNI 1-1 mappings
+    bridge -n "$vtep" link set dev vxd vlan_tunnel on
+    for vid in 10 20; do
+        bridge -n "$vtep" vlan add dev vxd vid $vid
+        bridge -n "$vtep" vlan add dev vxd vid $vid tunnel_info id $vid
+        bridge -n "$vtep" vni add dev vxd vni $vid
+    done
+
+    # bring ports up
+    ip -n "$vtep" link set vxd up
+    ip -n "$vtep" link set vtep-router up
+    ip -n "$vtep" link set vtep-host up
+    ip -n "$vtep" link set dev br0 up
+}
+
+setup_router()
+{
+    # bring ports up
+    ip -n "$router" link set router-vtep up
+}
+
+setup()
+{
+    modprobe -q br_netfilter
+    create_topology
+    setup_host
+    setup_vtep
+    setup_router
+}
+
+test_large_mtu_untagged_traffic()
+{
+    ip -n "$vtep" link set vxd mtu 1000
+    ip -n "$host" neigh add 10.0.0.2 lladdr ca:fe:ba:be:00:01 dev host-eth0
+    ip netns exec "$host" \
+        ping -q 10.0.0.2 -I host-eth0 -c 1 -W 0.5 -s2000 > /dev/null 2>&1
+    return 0
+}
+
+test_large_mtu_tagged_traffic()
+{
+    for vid in 10 20; do
+        ip -n "$vtep" link set vxd mtu 1000
+        ip -n "$host" neigh add 10.0.$vid.2 lladdr ca:fe:ba:be:00:01 dev host-eth0.$vid
+        ip netns exec "$host" \
+            ping -q 10.0.$vid.2 -I host-eth0.$vid -c 1 -W 0.5 -s2000 > /dev/null 2>&1
+    done
+    return 0
+}
+
+do_test()
+{
+    # Frames will be dropped so ping will not succeed
+    # If it doesn't panic, it passes
+    test_large_mtu_tagged_traffic
+    test_large_mtu_untagged_traffic
+}
+
+setup && \
+echo "Test for VxLAN fragmentation with large MTU in br_netfilter:" && \
+do_test && echo "PASS!"
+exit $?
-- 
2.39.2


