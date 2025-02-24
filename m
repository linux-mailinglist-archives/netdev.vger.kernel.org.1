Return-Path: <netdev+bounces-169129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37256A42A3D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49915188B648
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0326562A;
	Mon, 24 Feb 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MmeiSniP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0E264A92;
	Mon, 24 Feb 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419104; cv=fail; b=j0+ExFdci1dlulgNHwK0RcNR5eb5Dq0o2k8lrPd52L7fmu9UZihj+3IeNbZH1E9C6R5DcEOJJzbojyGtfkBfwxi+znOq3pL7mnz5oj6hM2iTKmUILVTP0BkQ3mvNL6xejQGbe230PurHOB+TvyuwA+CljFV1tcMBaaY0EGRvpbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419104; c=relaxed/simple;
	bh=xGq92Mu+/vSg1P4lor7rQfhrIgEmuS9tub1yrI/vEVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqLrg0mptiXgyf4QTrdj9WFpYQStP6V4VGWNImrbvYlCUiExdDAhOzipBhHg+8jWFIdro8f8UYC1oDOuJms2bBiMHilaNJwRzOU1HLsCWbaf1qWZphTAv9w2sT2fSm1zWCdGjUR65u6hTrCEGTpzjbHw189q7xMHKy8UBrPCb64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MmeiSniP; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+/P8zOLuoCjSne0l673BJrno1+Sxu2+qp8CTQf5esrRZwquCggO6mN3TC8QYWnJaixdHcBMEKyrQRbFHJs8NTQdlqfHpaAt/L6nCtGnvO5dbgVHCVa9a2lchpYJd74cNdN5+x221XzR0jQvj+CnJiB0SM88f7/mv128eFFzYhyv3bUXiHKS3hWdPs4dDLzQvqefZfZkq8NCHB7c4SqjkATUX4lU02AlfFyTtbcZbUgBTJPMMKFW80iX2YBQu7JNYXhBVx9mvL5x7M3dZCuJoWvx7BCjNaS0pekNZHQmSU/bInfU8Z2lJ64Ihngv7KeHNMwyxedPSUJgorSab7k4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZseUKxTOpe3hZZqHE8ThX8bdEcUrDh2kgS5SWwXbtw=;
 b=qwBzrYcNoWav28UX18DO1fIyb1+bjdULczT/zq/YV4TgyBVCd4qh2zROkRLjrK2Mxf+2S8QOPwrsLCTxfGT3YhcRcSQ01EV9Pp02hCCNGAQM/y2tsFOLzmuJ4lEnrqoNP7dc6YMLFB1VFxDpb6QhUgAzaGJIIxbRzsEAF/PKSFen302mjx9SvW4t98hGFGjiL2OxwevYBJNoGASAEgglZt+dGJMk26zXXOjp2GLKlZFhVNQYoWh753MxlVJyVonOXwmqPNXbppOiY/oBUdOI6ZrgUgU2KISQLHHo3rE5YwQjQCepwmAHIYEQC8LAjZd3uUjJYSFJn3hYssdP4E/npQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZseUKxTOpe3hZZqHE8ThX8bdEcUrDh2kgS5SWwXbtw=;
 b=MmeiSniP6F4M5K2RFOpXfDg6KzaBO65oeYvPmG5k/MHFFyYYsojWKljTOf+n80/OwgCf4Pn0i2VqdKEbmosBZbgAsl96hGBETzcDv4RlGHIsJhF3/LCjM8Ue5mlC28QIYB9cKifkp9vxC3cL0i+D3Dp8cagqxHBL8un7HifJ7nZsCQN7+t/Ur9h7VQdJBXmJCx3gp3da+VFEB+bOLg6JonOYmzznkQCWi/kS8r6yYLRp2piBm/s9brx5DMWSfqbsZACdOB1D+CSDr6YI7iWa6xsAbsL8jEj0oP7zdTCqPAg0aDUbvmSPqR57LuHJZ7RUQBvCrEzwXEMyTwO25hj+hQ==
Received: from BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 17:44:52 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::76) by BL1PR13CA0258.outlook.office365.com
 (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Mon,
 24 Feb 2025 17:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 17:44:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 09:44:38 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 09:44:37 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 09:44:33 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v5 4/4] selftests: drv-net-hw: Add a test for symmetric RSS hash
Date: Mon, 24 Feb 2025 19:44:16 +0200
Message-ID: <20250224174416.499070-5-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250224174416.499070-1-gal@nvidia.com>
References: <20250224174416.499070-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ee584e-6caa-440d-88c4-08dd54faf151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+bgG7BWK6NPMWW3yAdLteyYBDpxDBEZ2Xo+YDX3+HJMMW3dZznZuXZb6Pnp5?=
 =?us-ascii?Q?ftTeKc/Ddgdw1UvjRbcX2OtLj+qjdbZpksRHtkIr30ZVxFZXSkV/x7CNp4f/?=
 =?us-ascii?Q?5Tgrc2uXsWisgFz/JWzSbMYtRbWekkz0mNZYHxXxD/fvnkPbIbi29PaJAY2Z?=
 =?us-ascii?Q?u4zwUmQAmxdlNdJWk8p/aad6kwCMO1JV519A9dO9K5qQ6SeKGfzd1Z+9OdiQ?=
 =?us-ascii?Q?YW5mXa0MZKBJqEdiqmB2pE+NIeXs9zS3PALRvAfyYsR0hhGMOqqyoRswqnRr?=
 =?us-ascii?Q?blW6YpSLznB2UzpnEMTxl2QwWqgXw0ClIkqhzdP8pOFu02aZdFlMeSxST/Od?=
 =?us-ascii?Q?u076dTUjAZwaU2ZELpe6cfc5ps7NZXkkm0AmZyfTHNdWgFWeblnT9xh5a6S2?=
 =?us-ascii?Q?PZTCSaTET0CFhC+GAGwBCVDqZXvl2mAnzAEkCbPlqxuOsoHOERy+BP8RBfTW?=
 =?us-ascii?Q?gkB32XKAofELEtXrY28iq11mbqrs8bjMevVrvGDvBuf7oZE8evhxflWweyoK?=
 =?us-ascii?Q?/h+p37QSgRVKB0er6SmYkEtgVGxT5IsxNiCBhXC0Mu3Tok4LrggaKMmlkBqO?=
 =?us-ascii?Q?NGr/HcrN+h0vM1BK8r+I39d8TWf1YSEBXIvPXN9mL4sCfsAEhen+5p2GrXth?=
 =?us-ascii?Q?wT6sr5M3Z1MBMz6Odlo52X5domCl4xFTC15n9o20VpV4Iua5+Sd3etxGq/Uy?=
 =?us-ascii?Q?/WtMLmXXEh2lsjwv9M5AWVW9KlbX30aOorM2HaNNvEUmsShd3rLB3KJEEGeg?=
 =?us-ascii?Q?A/r6atdcxdFvFcUllyGPjr6kipUY4TA6XIS3bQ0tLy2eRJF2KWMmMN6JAqIf?=
 =?us-ascii?Q?paSuOI8cH8y70NieIfW7EoJzz9/5i55o2TiCU2B7HVwVgqmLigHwrSFJpyzG?=
 =?us-ascii?Q?sSpriN0PkF4kVhEZwGaei+gsyJ80ITbI8WsMdIL8MhwU/CP0EYeSu9DonSuL?=
 =?us-ascii?Q?X2kn/R4zPsweguXAwZ7Do6YZLq/4fwI+A2HOCeEYXavIfZMCrxE7v7G4D2Gj?=
 =?us-ascii?Q?9t+IryYtoAWXpV7FSKpDJ29E2/jNva/85h81m29liSnpP7qs/LiFcMSSEts9?=
 =?us-ascii?Q?5qBuhuMGItlUKWaWUyAMxH+COI8lpnDjGMMnIzzwepAvpW0+y3djxhWmvxTx?=
 =?us-ascii?Q?0WRmeY3p9LBlxIfnLqcfPLXZAp5Lwl0HDKKvLp8Bfv8nGmED98hCIh2AufVQ?=
 =?us-ascii?Q?b663ZZdHYPA2bVfUVoBV3ijOk/raEK1tclgE5Ax7fpGFcrfx1lDl6TkFuKQt?=
 =?us-ascii?Q?TcS34VEZ7BkbvI07tmvJKDXzz+FWGrdKLJKGHUZlWS3AimgJYJYqmEfCmZX0?=
 =?us-ascii?Q?UAgLDaT8eVLxEOC4chFQ18HxQCVjs4Fsd9iJL7KbreYE2wVXiL4OAiFDP8t7?=
 =?us-ascii?Q?niGE/jD3taPkm67dWjSjnaMpmzCO2hQdv0fueqdQkaIqR9rtbLynEAnIsmBh?=
 =?us-ascii?Q?OwwqeoyrxoZPPHtkdOAD2rq6X9a+lX3F98LHoRPdMiwBx4ttVrVCIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:44:52.1969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ee584e-6caa-440d-88c4-08dd54faf151
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

Add a selftest that verifies symmetric RSS hash is working as intended.
The test runs iterations of traffic, swapping the src/dst UDP ports, and
verifies that the same RX queue is receiving the traffic in both cases.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../drivers/net/hw/rss_input_xfrm.py          | 87 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   |  4 +-
 3 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index ae783e18be83..b2be14d0cc56 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS = \
 	nic_performance.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
+	rss_input_xfrm.py \
 	tso.py \
 	#
 
diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
new file mode 100755
index 000000000000..53bb08cc29ec
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -0,0 +1,87 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import multiprocessing
+import socket
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, cmd, fd_read_timeout
+from lib.py import NetDrvEpEnv
+from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import rand_port
+
+
+def traffic(cfg, local_port, remote_port, ipver):
+    af_inet = socket.AF_INET if ipver == "4" else socket.AF_INET6
+    sock = socket.socket(af_inet, socket.SOCK_DGRAM)
+    sock.bind(("", local_port))
+    sock.connect((cfg.remote_addr_v[ipver], remote_port))
+    tgt = f"{ipver}:[{cfg.addr_v[ipver]}]:{local_port},sourceport={remote_port}"
+    cmd("echo a | socat - UDP" + tgt, host=cfg.remote)
+    fd_read_timeout(sock.fileno(), 5)
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
+    if multiprocessing.cpu_count() < 2:
+        raise KsftSkipEx("Need at least two CPUs to test symmetric RSS hash")
+
+    input_xfrm = cfg.ethnl.rss_get(
+        {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
+
+    # Check for symmetric xor/or-xor
+    if not input_xfrm or (input_xfrm != 1 and input_xfrm != 2):
+        raise KsftSkipEx("Symmetric RSS hash not requested")
+
+    cpus = set()
+    successful = 0
+    for _ in range(100):
+        try:
+            port1 = rand_port(socket.SOCK_DGRAM)
+            port2 = rand_port(socket.SOCK_DGRAM)
+            cpu1 = traffic(cfg, port1, port2, ipver)
+            cpu2 = traffic(cfg, port2, port1, ipver)
+            cpus.update([cpu1, cpu2])
+            ksft_eq(
+                cpu1, cpu2, comment=f"Received traffic on different cpus with ports ({port1 = }, {port2 = }) while symmetric hash is configured")
+
+            successful += 1
+            if successful == 10:
+                break
+        except:
+            continue
+    else:
+        raise KsftFailEx("Failed to run traffic")
+
+    ksft_ge(len(cpus), 2,
+            comment=f"Received traffic on less than two cpus {cpus = }")
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
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index a6af97c7e283..34470d65d871 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -185,11 +185,11 @@ def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
 
-def rand_port():
+def rand_port(type=socket.SOCK_STREAM):
     """
     Get a random unprivileged port.
     """
-    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+    with socket.socket(socket.AF_INET6, type) as s:
         s.bind(("", 0))
         return s.getsockname()[1]
 
-- 
2.40.1


