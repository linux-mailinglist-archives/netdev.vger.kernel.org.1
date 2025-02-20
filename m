Return-Path: <netdev+bounces-168119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3AA3D8D7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50ABF3BFD50
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9021F3FF5;
	Thu, 20 Feb 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9FYmktN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9D1D5CC6;
	Thu, 20 Feb 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051337; cv=fail; b=I03On97RFTFm/w64hybUwoV676Pfl7IUigLaj2kDQzbed1aYcQc1ks0vxb+l4xs0m9E98EB4AprtUd2aNFk8uAfFWUPSFF1aJr8oascGewHjJTZEOPAhfwbYFyJ2aLuLQI/RcS8VLeKgE+eqDtdD9Hug53rVsCoQRnYWZ0stpU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051337; c=relaxed/simple;
	bh=AMy162SznCZVWwrem/lLFcB+eLDAPwaIOQOlAxLnGBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tE5LJTIIDohzjJYmdcRL3PkP079A7MZZJDTj7F9tDQ03zVG9RKLQBiuCVcL0BCufToFK4+NgyIO3lgyPKE1w1cG/zigURfE1D9mTxbwuGj2aHjte8Q1OJFwMbrgRiagAvqSAPmEDxatiO7vlUvSQ9KK9j6EEMN0y7+MWWU3zx+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9FYmktN; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgla8A3I1kgnpuBiZhVX3PoxiJ8nft+RcOOIlkNx2ZnJUrd/kT0Eyz8o88yKk3dxS+gmS3+dDpJ9U7bAx/lLosF6nUVvycWny28R0/e1ZzDtM5IgHC8BRFXAf/ar6nNWwwJns1H1tGPBCDkylQCEuw33W0YrL51folbfcLb/gkOUaZ/PmOOiDLTPiyA9dQ5bqAVQXsFSuWrIUTvmbseZtSuX0+eyGyxTLQX04iMm1SxYYp9IehzpyrINLtTntmaQKsrJlSSFeWW+88ceCs6Z74toUSgVpGau9cea6BW4y73++AEUY8SqMReFGuARdYARHjUuswMf6yfAeW1qNrLkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WSY7sBXHvlvAOWM36uraykLeea0n0bk4lAqeETelec=;
 b=LnNCsgShRX4LacXA+G2yo+gwiu0rSB+xNZgCigXvIW294t2OjrT90zqXH0ecBGGwyqPMr4IzBKVoLAcnOBar0nxnHefNUMQlakPqT7Bpald79hkXPAf8r/vcz32oP7DVt2FrX61nmJAwsrJvi7ykcKtbSVmTc35zIk7KxtxLyMTLrcD9vTXfS4+c1qIG4/NqyMfzuIPjeoyyGiRAx2JBy1WF1qVUPzSAwe9UxVqZe+33rmEQfC+EaEYkkWke+kvectSdDDbacsCjd67dLi6YSooCV26E2bF1jxhMIQ5v7aI1rEAaSPKbu1mXL0fd/RZGQe6kdOQuIkNHJ4WQo00B9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WSY7sBXHvlvAOWM36uraykLeea0n0bk4lAqeETelec=;
 b=M9FYmktNVu8lYQn9Eo7QpE0clrDCwzZPRFoL0fegblHqtuwj7AhxlPCCD9EGyXsQ/PG/9RBSqHkJtO7c1cj353mWBzLmg7gI0Zh8WlX5/9RvB0PKmZqPqT++hqRzBgE+UUjParWWRN8EFxlf1OU3BV/7goJBqQGoV3DrxrluMIoV5IksOoMQL1rcFUOA4PkhZCAD01AOGd3K2Y9q4NPugw0Wzs4MGne57ySAE9xZPEFNwA6pvXXPYf1T0ik3m7qjerUPltbmGhZK8E62MMnqs62GRRmDV2SPwKR69tO3HaDZhV2LFkl+rEhnPXY130rYFIZrJp+HkkZDorxCfo/RSg==
Received: from BN9PR03CA0418.namprd03.prod.outlook.com (2603:10b6:408:111::33)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 11:35:31 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::7) by BN9PR03CA0418.outlook.office365.com
 (2603:10b6:408:111::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 11:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 11:35:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 03:35:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 03:35:10 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 20
 Feb 2025 03:35:06 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v4 5/5] selftests: drv-net-hw: Add a test for symmetric RSS hash
Date: Thu, 20 Feb 2025 13:34:35 +0200
Message-ID: <20250220113435.417487-6-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250220113435.417487-1-gal@nvidia.com>
References: <20250220113435.417487-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: fb19d21e-5572-4060-792b-08dd51a2ae4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/gKhaL6ijdb04kzERnbAfp/qNyLfuMmqnGyCQwhfUOfC2NTNaYFER31xTWZ?=
 =?us-ascii?Q?meb4BPs0KiZq5BzK2qAnSuTKDs2DYpkNeuEHCC2ZOA8TmRuJnW5wK4kT/maf?=
 =?us-ascii?Q?cAMwCuYjKlfkFYYJDgjiv7T2mE5L7eCH8HNElioiwbO87R/cnXlBEaWikQYP?=
 =?us-ascii?Q?1FjFS66JN9Yp9nTePrX7mkvRegoYAHcQIWGUpNnRyLyys0pTRFdAQosP6fPN?=
 =?us-ascii?Q?q1IW1rUoZ5D1Gzk8rAl2GXG1oRR7uFnqZCuq8z7uySuGhu5gkuWCFls0X41o?=
 =?us-ascii?Q?ap3QXVougoFhUN1rwKGrakz2cnQoMWKEE3kWEOIlvKQAhPokn499Td1JfLnw?=
 =?us-ascii?Q?kNb4J+ZChZDsQzKgNhihZZPtARYNstNklH2dsZZWuxc41ejv3omzD7lPDRyE?=
 =?us-ascii?Q?2fY8ccAGnU0zjOaMrTVS9qZ/NRodt8oqIBCHJoUm2fRDyV6jTrqJgcMI96QM?=
 =?us-ascii?Q?+7Mu0q8En9ZIAexA1q1mEt50TETTHuWkydlc3QzR5TGLpkKPU2w7qVd36DFo?=
 =?us-ascii?Q?KXv/MQt/mPevvlwShl6r1yIXcTS3+VApaG1bsjHGW4YR4KLi1gnJDaYdPPPa?=
 =?us-ascii?Q?PYkoraUbWOT51V6wocYWK4jbsilfg2UP8BTo6MBgye3e6D8x7Rmg5Zqf9+Ox?=
 =?us-ascii?Q?tvmAaR2sF0eRGEAruTC05Qek08M149FvsVSwDb0waQFxFzGOkB9lohRQg6jX?=
 =?us-ascii?Q?XihcS4K2D8e0f/lpaJzNmgxO8SVjt6UtV1X5ubZn6t5rvyZfWAPF9/rT+oZI?=
 =?us-ascii?Q?adJzY2x0kHsa1hmCChOsnzJd0ZNYWnxR7Vne1BCcdVM1Iiu6MQzES7JOfDTs?=
 =?us-ascii?Q?8ivEVuqx8zDw517aBLbtpGWnTQGXMXk5kPwswl9/7RKQKnouiJU0duWaGyIl?=
 =?us-ascii?Q?gzyB6j4atLQvQ/aIeCvu7XfqobdgFAihI5IcnmhxQP95yHmBK/HKovNevfYd?=
 =?us-ascii?Q?5tqIX+l0X9+3VgNpk7s4XXB+KHyoKKI3b8IvZVavzXn1e4KGqEoa1vuh/OPh?=
 =?us-ascii?Q?zuxnZbvFEYXRJ2Xi9wuNyyYK5/5cxOXiVxrzyR278fouWXOS2NeRz3iqed+P?=
 =?us-ascii?Q?p3G1xptdIgUG1zt48fDiE4LorX9x6agYYWRzyWm4sBk9ZLGJgZ24RXbSzlIH?=
 =?us-ascii?Q?JNh1uUl63N3KA+C4KculsC+lL3ZuhDu3EcCw4VI0NMn6k0a9J4QSZtOAuxUx?=
 =?us-ascii?Q?JRSUpuOIdgvw/QNLJziafD/kPxDxcQVm4awoO/VS8Kn4zk+5TlGD3lvOjjTE?=
 =?us-ascii?Q?0V3VO0DiZoo/o88fZTMEAykimcxJv4PH3VwSSd7VfE5Z63JtecWOtaRhjqzW?=
 =?us-ascii?Q?99bmNaAs+92H/MlbAuLntCeAW9nsMWcx4qf2q20X4ficysXW5VtjMzm7neFq?=
 =?us-ascii?Q?6/ZhfPO1BZeMCG/seXx4erE3AifMpQ95c5ETWo2aREcnE/fWnrd3HBpdJsCK?=
 =?us-ascii?Q?1JmKZc8kA8czWDe9GExicl4E2k5uwzUo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:35:30.3996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb19d21e-5572-4060-792b-08dd51a2ae4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652

Add a selftest that verifies symmetric RSS hash is working as intended.
The test runs iterations of traffic, swapping the src/dst UDP ports, and
verifies that the same RX queue is receiving the traffic in both cases.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../drivers/net/hw/rss_input_xfrm.py          | 85 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index ae783e18be83..fb1b655b4939 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -16,6 +16,7 @@ TEST_PROGS = \
 	pp_alloc_fail.py \
 	rss_ctx.py \
 	tso.py \
+	rss_input_xfrm.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
new file mode 100755
index 000000000000..c0e7eb87533f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import socket
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, cmd
+from lib.py import NetDrvEpEnv
+from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import KsftSkipEx
+from lib.py import rand_port, check_port_available_remote
+
+
+def _get_rand_port(remote):
+    for _ in range(1000):
+        port = rand_port()
+        try:
+            check_port_available_remote(port, remote)
+            return port
+        except:
+            continue
+
+    raise Exception("Can't find any free unprivileged port")
+
+
+def traffic(cfg, local_port, remote_port, ipver):
+    af_inet = socket.AF_INET if ipver == "4" else socket.AF_INET6
+    sock = socket.socket(af_inet, socket.SOCK_DGRAM)
+    sock.bind(('', local_port))
+    sock.connect((cfg.remote_addr_v[ipver], remote_port))
+    tgt = f"{ipver}:[{cfg.addr_v[ipver]}]:{local_port},sourceport={remote_port}"
+    cmd("echo a | socat - UDP" + tgt, host=cfg.remote)
+    sock.recvmsg(100)
+    return sock.getsockopt(socket.SOL_SOCKET, socket.SO_INCOMING_CPU)
+
+
+def test_rss_input_xfrm(cfg, ipver):
+    """
+    Test symmetric input_xfrm.
+    If symmetric RSS hash is configured, send traffic twice, swapping the
+    src/dst UDP ports, and verify that the same queue is receiving the traffic
+    in both cases (IPs are constant).
+    """
+
+    input_xfrm = cfg.ethnl.rss_get(
+        {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
+
+    # Check for symmetric xor/or-xor
+    if input_xfrm and (input_xfrm == 1 or input_xfrm == 2):
+        cpus = set()
+        for _ in range(8):
+            port1 = _get_rand_port(cfg.remote)
+            port2 = _get_rand_port(cfg.remote)
+            cpu1 = traffic(cfg, port1, port2, ipver)
+            cpu2 = traffic(cfg, port2, port1, ipver)
+            cpus.update([cpu1, cpu2])
+
+            ksft_eq(
+                cpu1, cpu2, comment=f"Received traffic on different cpus ({cpu1} != {cpu2}) with ports ({port1 = }, {port2 = }) while symmetric hash is configured")
+
+        ksft_ge(len(cpus), 2, comment=f"Received traffic on less than two cpus")
+    else:
+        raise KsftSkipEx("Symmetric RSS hash not requested")
+
+
+def test_rss_input_xfrm_ipv4(cfg):
+    cfg.require_ipver("4")
+    test_rss_input_xfrm(cfg, "4")
+
+
+def test_rss_input_xfrm_ipv6(cfg):
+    cfg.require_ipver("6")
+    test_rss_input_xfrm(cfg, "6")
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        cfg.netdevnl = NetdevFamily()
+
+        ksft_run([test_rss_input_xfrm_ipv4, test_rss_input_xfrm_ipv6],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.40.1


