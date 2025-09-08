Return-Path: <netdev+bounces-220722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9434B4856C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330DB17C5A0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E302E7F12;
	Mon,  8 Sep 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3kftTC1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC71FF1BF;
	Mon,  8 Sep 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316930; cv=fail; b=ABXea4m2rrVCzefQw1ueQFIa/CQnlYJUNGU9W8zdzxU3scZqFF5q2msRsKFkMhDhzi263QsADktoxGY6odDd59mroOOjkv77xl4iOeDLu01GaLJbkLaDPTpTfeEX8g4TwEWLlIYyvRuSN2ulJ0ZClIFefEIRTQBIauGk4AndHu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316930; c=relaxed/simple;
	bh=zSav70/srk99vVzC984izqlGhw80HjiWnvN0ik1kCms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDkIZMOtRHhNJlat4d4upr/Od1eae72uMrTpO6hEpEHbygPHf3LbdBlXAuGvK4SX1mOR0fiuqXe9Lo3KTVgUyQar9HNXmJxfQD6CmhXJLLCL1UAZbJR7OVdXjXR02t4qU4acLpMFaWCpQ40ggM2xUuS829kpQnspr3LbIgpNxWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3kftTC1; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1wuu0oU56UhuJptGOBRJd6nfMYe3CZzr3jrF3BQyn2TppVxS1sCmcIibs5iJkLUAMt2pE0KCuYtAcQ5gGMg3qmnACe0ypx7FfmRL1SQ85w0dwXRPpzw+S1Ml31n2omLmcXTiU0VqHoa0pOpx69ivPcY/OQ/wixOp7lOfTS2NYODdWdOmoYXhcFWZKvXMggyRho/4CqrabuZ84hFAYt+cPsPdOnrtZDsRuWyWpngRm57IOjJxGMY/fLxb05Pf8dhhf9fHLgevnG8lDYVRcQZexsZ5KGvza2+IBK7RVdratzJbtu926U2CkPriEuCS2Y7LdB/cJk9/GCV/typw+E+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ37IProkELonIwSbWXq7vUUxaRTuf/p2RfOU8x+UFw=;
 b=UcExl7DbPtCpbEDk+1mq8qTZiL3v9RCX7V09npgjO/2DB0aoSksG5FztSpdZ/tpliTjPRbKnV17GAnUDA9fyMBjekqlYfJXL3NnsJIXZQ5P6FnHicx5idugWTh9nT0ICrbdM+13LAmGmK0tug2G70lxyUE28FXQ/8iND6VpyR9UNiUr9ohWzRYAP+yTracfSvQRO89QnhSpVPH7CNfHcooUAUygIWugbuuu2njahbNrxMigwq5gCnOb7sWArdFPQpazNrFvmTn+QDtPGXO811ecFRy6PO/OHlss5m0E9plX6MnwXG0r1smrfyd20W2Z/mkgup75a7Wd9xx3RQlVpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ37IProkELonIwSbWXq7vUUxaRTuf/p2RfOU8x+UFw=;
 b=i3kftTC1xDlnJpRGoM22DwEqRHzJPwY5HrecqEQOdY/gCH73zPzFaBrJE1tckDYDCHcCRJ0Miz7cStbHHws5b7jdsNRWtA3CZiPAw2Zo4uc1snLOMXMWztKBJOJ8nRBUcK/xrRY7ZCCTtzPYuZU+Mkk3TOizpRPx+ddeOJxEtb2WBVGntO5Q1Ol1Y7MMkWufBMfx0vRaM1jodaUSGv/eHaOAjnKws0U7FefxYmff6Vub5nT/MagKX4mFl/bw0PzrnGn7V7vo/xgT3kPc8H4CmY3CmyA0UJSF4VAQBfD3IAPZc2jh2aVAN3dMhMtP+DQbOgRXBLawOTxKVWPcfpcUfg==
Received: from MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::15)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 07:35:24 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::64) by MN0P220CA0004.outlook.office365.com
 (2603:10b6:208:52e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:58 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:52 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 8/8] selftests: traceroute: Add VRF tests
Date: Mon, 8 Sep 2025 10:32:38 +0300
Message-ID: <20250908073238.119240-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908073238.119240-1-idosch@nvidia.com>
References: <20250908073238.119240-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 333e49b5-7356-48c7-e533-08ddeeaa45f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FyfHmOrpPeQbLp9XexJug4GR7d128HP6BHaRSXOkSdi0k8JeglXe5H2fo63E?=
 =?us-ascii?Q?z/39550tk8FBpoH/ZgqlNITwOJfL0Wfa+BgmSTYZbnVtjiLxHZNXhTr49nuP?=
 =?us-ascii?Q?6ZKcJDNAVXri2skBVqwUpi0KBoKzBWOAqrsJqQWbsR0XOj0ATcSYp+QNfUPG?=
 =?us-ascii?Q?4yYpozCgiQOn+SF81Ag3mVNZ1cPCDt1TFxEgTRA9W8NbYEsTd4wWiDa+cwDC?=
 =?us-ascii?Q?/z+c1pCKdovnSI42yFP+RvbRjm+vKX6Cmlsf+5FjVDoSiuyrcPobGIeBsvFS?=
 =?us-ascii?Q?xLyHq4jG2Q0nvtUqV5NHi8neI2nEjRqceHseHG1SzeNaIKjDDI9xSKcyZTa9?=
 =?us-ascii?Q?xgEf1fj7vchxnZq0hyVGthTN9mKUhVSSjQhLcX2q+ybrrLIi/Woce0HzW15B?=
 =?us-ascii?Q?ECZuzMRQmmvXKRb9HUY3mSa6aCLHxqRLiTosdIzKa0p9pYbZnsTbuRD7fDuf?=
 =?us-ascii?Q?zMasVHg7PDt8B44Hae6zcrK2y6ihL0FhJtiPugc7Ne/Ny9KJaB1yn0vAvoVQ?=
 =?us-ascii?Q?oPl5nsiduI0zAtWV4YGBCVQlXtdcudlSETLNzLbyr6Kjb0FOcLri9+Plkpwg?=
 =?us-ascii?Q?yCDxtjkKXnq8IMGLGmKrbm1+dP0i3z3JI7V5Q0zK6NGna5oLl6wmsJFP2/xP?=
 =?us-ascii?Q?AQJV1vPAHZPukD2WtQBTFnubQBtO4174MB9t5CQVc3Ymy4hcefmhN2dOu4w5?=
 =?us-ascii?Q?OwXS+1U0sqIplNkWHIuiScEdcL/5DrL/1GxVmd5fMCB9rtNZwyIWwXt+eT1Q?=
 =?us-ascii?Q?DiSUmp+EcZngZq2SxwXCvV2HVthCxbyZ2nKhTcyeM1UsUKAi20+xoI3dEv5C?=
 =?us-ascii?Q?LhLmDeFJG1WIbQQztpoetEEeg3GSxPu7D8mZ6FyK8hjxlulg8VGuXCoM4r+q?=
 =?us-ascii?Q?hogbIFO4rfDJ8bZidTRqi0QbQ+puoSKwCc4iZ4nlm5FWVS4XmhhKqdUnXvv0?=
 =?us-ascii?Q?3sjspLoCibtDnRBLj9vDGkGGs+Bt4w7+UB596l2lBU7LCp+SskM5Xp793B9G?=
 =?us-ascii?Q?GA07bCgRYLibvzekLrEPrQyUuqDzcMx6phRIHJYw8qP4CJr0NoysKEMzCHUC?=
 =?us-ascii?Q?/iHNtlatNDtR4n4umIf5WO2tbv+CVumLz60rqiNMv4FMyYBboU6qC3EgY0OY?=
 =?us-ascii?Q?rOEMRBCW0rU0ZZV0VVFux+uHHnJE65DHE+qlF9I+06mLwSYO0rVTnoigE/N2?=
 =?us-ascii?Q?/xb8R3fwrAptVKMW/XprV+lhgiSxoQhX5QbQgM85XYorhvAZ04Z/FOoYBibk?=
 =?us-ascii?Q?fQ/81IN1kJnAnOW0DsBYx3ARJMJoTxKb3tTFBXYayKn6Wh9vL5Yers4PolD6?=
 =?us-ascii?Q?FuCs678Yil2VoETCQ/uv3NWvzxnEYb3hoc1LY1NgaVeX3yVK3InI9yCDR67s?=
 =?us-ascii?Q?sc+ntLtntr5FRiqz4VRb5/WQqwdmsgcQBFrxBvGiuT2YGjYliIsKcnyKDABH?=
 =?us-ascii?Q?0T46hX/adapMCDiIH0QNcvGzq7hxk601bHgTZ7vhkiW76iBEG8qXvPPXTKB1?=
 =?us-ascii?Q?GD/4HkHAsuPaLqHuF/1LsgO8a9Hwsr2HK4NO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:23.9791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333e49b5-7356-48c7-e533-08ddeeaa45f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152

Create versions of the existing test cases where the routers generating
the ICMP error messages are using VRFs. Check that the source IPs of
these messages do not change in the presence of VRFs.

IPv6 always behaved correctly, but IPv4 fails when reverting "ipv4:
icmp: Fix source IP derivation in presence of VRFs".

Without IPv4 change:

 # ./traceroute.sh
 TEST: IPv6 traceroute                                               [ OK ]
 TEST: IPv6 traceroute with VRF                                      [ OK ]
 TEST: IPv4 traceroute                                               [ OK ]
 TEST: IPv4 traceroute with VRF                                      [FAIL]
         traceroute did not return 1.0.3.1
 $ echo $?
 1

The test fails because the ICMP error message is sent with the VRF
device's IP (1.0.4.1):

 # traceroute -n -s 1.0.1.3 1.0.2.4
 traceroute to 1.0.2.4 (1.0.2.4), 30 hops max, 60 byte packets
  1  1.0.4.1  0.165 ms  0.110 ms  0.103 ms
  2  1.0.2.4  0.098 ms  0.085 ms  0.078 ms
 # traceroute -n -s 1.0.3.3 1.0.2.4
 traceroute to 1.0.2.4 (1.0.2.4), 30 hops max, 60 byte packets
  1  1.0.4.1  0.201 ms  0.138 ms  0.129 ms
  2  1.0.2.4  0.123 ms  0.105 ms  0.098 ms

With IPv4 change:

 # ./traceroute.sh
 TEST: IPv6 traceroute                                               [ OK ]
 TEST: IPv6 traceroute with VRF                                      [ OK ]
 TEST: IPv4 traceroute                                               [ OK ]
 TEST: IPv4 traceroute with VRF                                      [ OK ]
 $ echo $?
 0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 178 ++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 0ab9eccf1499..dbb34c7e09ce 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -193,6 +193,110 @@ run_traceroute6()
 	cleanup_traceroute6
 }
 
+################################################################################
+# traceroute6 with VRF test
+#
+# Verify that in this scenario
+#
+#        ------------------------ N2
+#         |                    |
+#       ------              ------  N3  ----
+#       | R1 |              | R2 |------|H2|
+#       ------              ------      ----
+#         |                    |
+#        ------------------------ N1
+#                  |
+#                 ----
+#                 |H1|
+#                 ----
+#
+# Where H1's default route goes through R1 and R1's default route goes through
+# R2 over N2, traceroute6 from H1 to H2 reports R2's address on N2 and not N1.
+# The interfaces connecting R2 to the different subnets are membmer in a VRF
+# and the intention is to check that traceroute6 does not report the VRF's
+# address.
+#
+# Addresses are assigned as follows:
+#
+# N1: 2000:101::/64
+# N2: 2000:102::/64
+# N3: 2000:103::/64
+#
+# R1's host part of address: 1
+# R2's host part of address: 2
+# H1's host part of address: 3
+# H2's host part of address: 4
+#
+# For example:
+# the IPv6 address of R1's interface on N2 is 2000:102::1/64
+
+cleanup_traceroute6_vrf()
+{
+	cleanup_all_ns
+}
+
+setup_traceroute6_vrf()
+{
+	# Start clean
+	cleanup_traceroute6_vrf
+
+	setup_ns h1 h2 r1 r2
+	create_ns "$h1"
+	create_ns "$h2"
+	create_ns "$r1"
+	create_ns "$r2"
+
+	ip -n "$r2" link add name vrf100 up type vrf table 100
+	ip -n "$r2" addr add 2001:db8:100::1/64 dev vrf100
+
+	# Setup N3
+	connect_ns "$r2" eth3 - 2000:103::2/64 "$h2" eth3 - 2000:103::4/64
+
+	ip -n "$r2" link set dev eth3 master vrf100
+
+	ip -n "$h2" route add default via 2000:103::2
+
+	# Setup N2
+	connect_ns "$r1" eth2 - 2000:102::1/64 "$r2" eth2 - 2000:102::2/64
+
+	ip -n "$r1" route add default via 2000:102::2
+
+	ip -n "$r2" link set dev eth2 master vrf100
+
+	# Setup N1. host-1 and router-2 connect to a bridge in router-1.
+	ip -n "$r1" link add name br100 up type bridge
+	ip -n "$r1" addr add 2000:101::1/64 dev br100
+
+	connect_ns "$h1" eth0 - 2000:101::3/64 "$r1" eth0 - -
+
+	ip -n "$h1" route add default via 2000:101::1
+
+	ip -n "$r1" link set dev eth0 master br100
+
+	connect_ns "$r2" eth1 - 2000:101::2/64 "$r1" eth1 - -
+
+	ip -n "$r2" link set dev eth1 master vrf100
+
+	ip -n "$r1" link set dev eth1 master br100
+
+	# Prime the network
+	ip netns exec "$h1" ping6 -c5 2000:103::4 >/dev/null 2>&1
+}
+
+run_traceroute6_vrf()
+{
+	setup_traceroute6_vrf
+
+	RET=0
+
+	# traceroute6 host-2 from host-1 (expects 2000:102::2)
+	run_cmd "$h1" "traceroute6 2000:103::4 | grep 2000:102::2"
+	check_err $? "traceroute6 did not return 2000:102::2"
+	log_test "IPv6 traceroute with VRF"
+
+	cleanup_traceroute6_vrf
+}
+
 ################################################################################
 # traceroute test
 #
@@ -261,13 +365,87 @@ run_traceroute()
 	cleanup_traceroute
 }
 
+################################################################################
+# traceroute with VRF test
+#
+# Verify that traceroute from H1 to H2 shows 1.0.3.1 and 1.0.1.1 when
+# traceroute uses 1.0.3.3 and 1.0.1.3 as the source IP, respectively. The
+# intention is to check that the kernel does not choose an IP assigned to the
+# VRF device, but rather an address from the VRF port (eth1) that received the
+# packet that generates the ICMP error message.
+#
+#                          1.0.4.1/24 (vrf100)
+#      1.0.3.3/24    1.0.3.1/24
+# ---- 1.0.1.3/24    1.0.1.1/24 ---- 1.0.2.1/24    1.0.2.4/24 ----
+# |H1|--------------------------|R1|--------------------------|H2|
+# ----            N1            ----            N2            ----
+
+cleanup_traceroute_vrf()
+{
+	cleanup_all_ns
+}
+
+setup_traceroute_vrf()
+{
+	# Start clean
+	cleanup_traceroute_vrf
+
+	setup_ns h1 h2 router
+	create_ns "$h1"
+	create_ns "$h2"
+	create_ns "$router"
+
+	ip -n "$router" link add name vrf100 up type vrf table 100
+	ip -n "$router" addr add 1.0.4.1/24 dev vrf100
+
+	connect_ns "$h1" eth0 1.0.1.3/24 - \
+	           "$router" eth1 1.0.1.1/24 -
+
+	ip -n "$h1" addr add 1.0.3.3/24 dev eth0
+	ip -n "$h1" route add default via 1.0.1.1
+
+	ip -n "$router" link set dev eth1 master vrf100
+	ip -n "$router" addr add 1.0.3.1/24 dev eth1
+	ip netns exec "$router" sysctl -qw \
+		net.ipv4.icmp_errors_use_inbound_ifaddr=1
+
+	connect_ns "$h2" eth0 1.0.2.4/24 - \
+	           "$router" eth2 1.0.2.1/24 -
+
+	ip -n "$h2" route add default via 1.0.2.1
+
+	ip -n "$router" link set dev eth2 master vrf100
+
+	# Prime the network
+	ip netns exec "$h1" ping -c5 1.0.2.4 >/dev/null 2>&1
+}
+
+run_traceroute_vrf()
+{
+	setup_traceroute_vrf
+
+	RET=0
+
+	# traceroute host-2 from host-1. Expect a source IP that is on the same
+	# subnet as destination IP of the ICMP error message.
+	run_cmd "$h1" "traceroute -s 1.0.1.3 1.0.2.4 | grep 1.0.1.1"
+	check_err $? "traceroute did not return 1.0.1.1"
+	run_cmd "$h1" "traceroute -s 1.0.3.3 1.0.2.4 | grep 1.0.3.1"
+	check_err $? "traceroute did not return 1.0.3.1"
+	log_test "IPv4 traceroute with VRF"
+
+	cleanup_traceroute_vrf
+}
+
 ################################################################################
 # Run tests
 
 run_tests()
 {
 	run_traceroute6
+	run_traceroute6_vrf
 	run_traceroute
+	run_traceroute_vrf
 }
 
 ################################################################################
-- 
2.51.0


