Return-Path: <netdev+bounces-218660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DCDB3DC7D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C8189D52F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267342F83D9;
	Mon,  1 Sep 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7bcMhjE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC02F8BF1;
	Mon,  1 Sep 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715596; cv=fail; b=aUDrvIpLEzY9XxvGgfrEMVFcwJKl8WToYX8MwksVvITM1CIEWZkSztAlUA4PZR5PE+tKCov5SKvD30fq7iPna0Mvj6L5j4/GTMKH66eFMLg7BFSi77Pob38s4knkN+ETO3w6o/E/aHagHNVaUZ2zZtw7It6pli5IsSlfBm+bg+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715596; c=relaxed/simple;
	bh=PFMRUPLrOAA559oy4PLFWbCjccy1CFltr2k/bOd1bNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Znl8ceN6eiHh/bMU3fuS30e7YEWyIJ9+SitxVmDeNnAgqoaIQ7A6OC548FjlWSU1ll3GwO+yo58toPkb3Q1b2Jt/wrWYzTiX2URfeDe4jJWeQmHRgoZaoqTsxp0yTy+qnLIbk67Tex9vlYO+2lj6LN7QFmjuNfaeaJ/jhaDtP6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7bcMhjE; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7KyJKZ3A2zMx1YjT9AscPq1BvAzD7NfU98NW1ETXFLgZwo+8SGjMZxXpFsueTGoq+i6envGVMSEoJ8lJeleHV4BCILNl0C3PdlrF+88B3q26uDxFE1/Vd7b4KDnwqHcRmg7ife7f1jM/F1KuL3xv2BSsGsNNhWSyT7qu2Og4E7UI+6ikMk6GdttQM/Q6y06mK7vF9Kz4KCiQPJd42ywpjtTEnIiKH9kYF2mA2DDL7W3w0DT8GXzrmIeykO0smFvjbYN0yQ1TS2ntlwYVlLisUoDHt+/7a3Ix2kArKlO7MviGOS9a6fXwiEfE+81+lq9fh7a4NJXhIazdhNBiyG1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTHEx5UhGjdRfmIvhG0SP35b9MzmIyiaz9WVmKocHJI=;
 b=eX1ueX6yzSRi41Tlt80HeA2afZSJ5HMCjttaQPcwhCi4GasQPP2pnYpgIttORJYi8QSRkF1LVAXgrlU4MIuzjj5d/HK4Lh/bIDYRmOJ22qNmMTqFOhwbxz7Nb9a4SUE6E15Y1YPQVRRx6j05KA3of+HgdF+lyLK4PMgIpmEyBt2RcdDdUUiQwN8eFy3iRawpgu6Z9ahnSWBlRmh5o4GoWReBccpzGCsz0nSFJBCu9ucBPXRwd3l4kpHjJQoPQvZxw1I1lJjGzsviCEX/7BeBhlnFaAkNIDNJs8cqIQpltxgc+CxpmXZqtrQjIX2hxcNhBDZQO8nkkgZ1GfiQPxHylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTHEx5UhGjdRfmIvhG0SP35b9MzmIyiaz9WVmKocHJI=;
 b=l7bcMhjEdTgQeG4jj5vdv2Zgy4KYlmyLKIqCYoqgTVUxxDuNMjs0N5NcMCVGq1359UzxnG65C88c2FruQ1f6on6p45UG0wIjFif3S1RgDR9DKwl3eF+XtFe1CDSHVbMmaYQ1ZlXsYmRuJBZby7b3j5x3K6BKPKAKZoD9Rof+nSpBlYH6n8M4loUbJISl2k51jv2dAVKSAZ/Uu3j+N7OfAl/tRe7nbYUSQ/kuVSeY849oK8cUHO07bDPijBaJTumpSqn8GYbhTd7BZfySKxPyxVCGQsjdjaJaJyw25BQIrXdOOTHorKgm/ZlTrqTTQdx1j7Cto8xDMdIQy+mu2e2cQQ==
Received: from PH8P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::21)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 08:33:09 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::fa) by PH8P223CA0028.outlook.office365.com
 (2603:10b6:510:2db::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 08:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Mon, 1 Sep 2025 08:33:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:52 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:48 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 8/8] selftests: traceroute: Add VRF tests
Date: Mon, 1 Sep 2025 11:30:27 +0300
Message-ID: <20250901083027.183468-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b09773-3a5c-423b-0099-08dde9322e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G+do6o0AaiUXI4xxu5UFCJVNmGL4j14/VyNUoj/5JzQTEaekeUBpSUFfGNiF?=
 =?us-ascii?Q?QttVPuxMRUIchYtsnQAeSFkef2Vuzzjx/B61y5JhVX0D0hT1cKRah+pba/hG?=
 =?us-ascii?Q?VNSjXXqfc2h4xdzlSg2JH+dzQv2eYYr0vfQfxbMPg/acBzfOsyHoBgG20NVg?=
 =?us-ascii?Q?J9RAjdVyLUb51ZbWEZU4jSkFB/UqeQ7ejcdIZwgNxwEg3uaCoHvuV57xKs8O?=
 =?us-ascii?Q?Gf8K+TQGPfI35tomyD/+tjxFCtuJoaaPNug9Ja0x/Tx5Gr4gDFAdYtex6xch?=
 =?us-ascii?Q?iHaLEBehAthWDgd47fiHe7wz2KOUvOvSpSA7dOKcjRKGCK+Hgq8sd/QfI/K4?=
 =?us-ascii?Q?0Z5nwXjY5r8ZJicEWmNR8DZZGKxR9Zb6JI/EXAoJ7uWez/1cV5doztJDbYhi?=
 =?us-ascii?Q?zRn5aBbN8b8eyZBrr+dQErD88ATVsuVz4zgrG90JHObrE4GQ5vJsapyGr4fv?=
 =?us-ascii?Q?y9yitWyjwK0MR+ivMWWKA8mkIS3SuOy0Yi0CVmsJdwKv01xrL01WjDxCumzf?=
 =?us-ascii?Q?iFn65RFt03iPXVoSkU3atQr1gjiK+XDsqwG9BMM4Q+HOury7mPIgpIvWcWTg?=
 =?us-ascii?Q?Mkjfusmyl/iF+KGK1Fi8++L3HAptAUyVbODB7WgIqChoKmvewyfLa46YH3yV?=
 =?us-ascii?Q?dMjJMhmnDkAak3L3tFS3S/CL1Q6oT3iBTcG8YqE/EyP/veS+BiHcX8mcAUY3?=
 =?us-ascii?Q?TMsIOuGIow34C8dK8Ur7GfZex5uqECxbJmPhwpJr6q7EJSAhTwyqqx/Q9NP/?=
 =?us-ascii?Q?txvnPIIPLb9QsbjnmKUsvrvUEt727mSd9nh7Vc7xUU6zRc+b1xCDc38dplJp?=
 =?us-ascii?Q?xRM4zwi8G3BRWROk2DfdGpGNsGQ3xLb+6nOrxzgoZQbfxFobbZRTEbIO8NrZ?=
 =?us-ascii?Q?Pgc92E1n7B2FEyifVnFKBKkfW2Y1O0Jw6GkrtjZclsk93mGVZ8m50Nm+3JNJ?=
 =?us-ascii?Q?aVPazT8taT09igjkd1pOFCY1UYv9XsoX5dA300pLO700qreyFtlQKwVZg7qM?=
 =?us-ascii?Q?NpPMLBvePO320npViDsmhjjek4usrwRE9egM1cX6qU2hWHsNRdU+/0E6N3+7?=
 =?us-ascii?Q?cPBpYc+RNUNaScXTrIz5B9F7ViVamoCzPLA5uvCy5qNWeGlzH43KV1944Sey?=
 =?us-ascii?Q?iuCWbnpPAzl4KRB5VUBJCKM4ReTpQgkO6zpmF4+zROAqptIzT4Y6hveM7Py6?=
 =?us-ascii?Q?0S03gU/7yCLBRwPpxXCP0m7BYM2vxrLJWjgnFSAVyyrYHQXBXW5zb/MCFySe?=
 =?us-ascii?Q?FaZhHYGz9/CFgsZUxCNQgGtjiYsnpQAXz2g5Jtu/KPjoW9AkRs8VIXwbhNso?=
 =?us-ascii?Q?tr6qGjHC5okNfaYs4A0Vb1OmPEaPqavNYOVlcIXI5TmoRfQ6NbZS7HPTL0Y4?=
 =?us-ascii?Q?nR+1ky5b9ErlFjR1ecESzZ7dZuxavIenr2/gPY2XTULRDTpvFDkG+3QjoiSh?=
 =?us-ascii?Q?n3tZmqVt9d7onnde5BsxzTkhM/G3bFtfzo4vouv7sd92AioUeIcdJiEPsapu?=
 =?us-ascii?Q?fJs3nc+o2c0B59JI9MB4pOggn6ObPvAo5Uza?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:33:09.3415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b09773-3a5c-423b-0099-08dde9322e86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

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


