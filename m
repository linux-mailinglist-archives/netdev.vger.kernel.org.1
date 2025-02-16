Return-Path: <netdev+bounces-166821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E780EA3768D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCA016D80D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534119F41C;
	Sun, 16 Feb 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KZg86YqV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4319D890;
	Sun, 16 Feb 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739730338; cv=fail; b=DpbDvw1symqBJns0vPVBjC0DS2v6NmuSVmCe4QkuGwERvn3i+FzMyNdi6hZSLhGMsSAli4DR1LUxqJqEEXpgDRjK1LgiKAMGO08U1I+yEZN80e7ECP9g+scNEhdEgI6k/aaDC7cY0QAkrXpzkHfTMPwWIMCgFcZoDTsqJvBG+XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739730338; c=relaxed/simple;
	bh=3Yf1Yiz9zlI30Cl3184wqZy46qcHqwQ6kOa1iJnl5zA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKvpVjmSCEyJQSwPEPUSask9ahXBKIUDb5JMppNUO1+f43tQNEyaxvIhBbc6Lzb1sA79XRtxbncd1Kijdg5Sr7KUCYU0HtwKlEku7Xgr16yB/8oS+0/HoVP69w/wzldspewbUbpLSlfY6ExFj+g5wvBScqAt80X9ejf7yc6WXok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KZg86YqV; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCfIj2dY3pb+JGQj3vbUEt329tGnNn/OQPllO7iXV8E20gG6Xsmu6MC8nxBIYEzaWFq9G26PMvQ4aBmcoqhJzgT5Y5Ba5m37O4PtpDPdgC7vRHUR7pY6cLhvvnaqw0IzwuSklaBVscQW33d7kqPaEEBtNBOa1So5NhrwNUR+JnnsT5XzYgXmx+qyaVuqkzDONANcPU9IXY9z1q83XmbYNC7wOkjaih4tcvzuf1v8oaAIHvEtpXP6XJaKC4Y/eR8C4nm1D6tylKQSljXkw4j2x0L2pxombtUJFr5cPZT9fQ/wxkYW57eIy2mjaVrcCw3pW5A7/8u8vs6XnsNfnnULsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pEk9LeTQV7b4MeTGyjV2I7T9MdTPZ3rzEGJ1+oDPuM=;
 b=HxT2jZsm+3uTS6PymlQT96L62NRm8aRI9nbknkA93zWTPmVkWi9PqMHt9XGW0CdDLnbYbW1Nq1qexTbk/PB0ir5VsOgytIQM1mMsWq0pn69gizk/9XoXMZ37lu+SYwc58QcFdG5vE29ZBVb2WRytstqkVll5vuO2WAMNgJ+bacZn/G8/pvs1vU1AYdg6m9aCmTtunZnkeVElPvXFEYk2NOcLqDHt8X76ctGjLzt7qdNgvcDWheA63u3gOsoAz9+z6A+b/N7VJcAt2tPXE+luXOO5XTE9Hv0XKxeW4wK5pQxpyyXewUBVN2ktHqsqIDx3d/bN74SBcN7Mt+x80m8T8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pEk9LeTQV7b4MeTGyjV2I7T9MdTPZ3rzEGJ1+oDPuM=;
 b=KZg86YqVkyfnVm/8y7Amxj15Py8tZ6YX5uAWxuJtyZsHRZ4K8gmvQI2o8DoUCot1ygZF/312jdM5U0alM56aTU9Zj+MOF+rPoYwNN3871oW+sgDPbqI46/4GCd/JBINMTNrLsNm5VUaj9PXnNdmMMUQmaiNZgKl0VeENV0tte7xORvzO8CBajD+DDaBXWj3Q3x19uUw+CG0wpC4OYkvOXgL663ccyR+h1FJyK4UGze7end4O7L/Youfx6YpFASDuBMGdasfEdOEqy2K96iTSf/bQkg5MKhOGAasq4/ezjfZD6aepJSDKFC056DAaZfc8uXHhLdEiu6tgjbkfk+d/0w==
Received: from CH2PR18CA0031.namprd18.prod.outlook.com (2603:10b6:610:55::11)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Sun, 16 Feb
 2025 18:25:33 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::d7) by CH2PR18CA0031.outlook.office365.com
 (2603:10b6:610:55::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Sun,
 16 Feb 2025 18:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 18:25:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 10:25:25 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 10:25:24 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 16
 Feb 2025 10:25:20 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v3 5/5] selftests: drv-net-hw: Add a test for symmetric RSS hash
Date: Sun, 16 Feb 2025 20:24:53 +0200
Message-ID: <20250216182453.226325-6-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250216182453.226325-1-gal@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac44ff1-6e61-4615-4e96-08dd4eb74cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BxRkJ0DhsXEHf0A/jixr76MKmqSkzGG18tbFzmLEZuQPOQDA6oA1ODOq+xkA?=
 =?us-ascii?Q?+UQC+y1Inadms7Xx8NbiByxjqm+7cU8RRYKzcnBR+BRns6e2gjm06kdFJ4xm?=
 =?us-ascii?Q?eepEpV+zdUElg1lxmzp9OqLIdN1NDEfC6OdHyVi+m4BJYrU8xX2b8Jwrb5uv?=
 =?us-ascii?Q?38CfONzuVFeQFl4EHAFFEb/uJ1aNNYaeAVHDGLujgw5OFYUPzXX8u0j5TmUn?=
 =?us-ascii?Q?kvpgOHESEouVowm3FfSSY0qJ3yz4HyQ6KfCEoswOuzrcPJif/719woZfI+xf?=
 =?us-ascii?Q?ldsx6MTZ7I3lRogccvboIBIXoMv9kKyGU9uuSd7bj31rVP0SqLQkRkW1f6oo?=
 =?us-ascii?Q?/WAeNgVl8+22XF5JPSpPLpiLv72gnSoyRecyshMzNdQIxnLRXQZ8z17/QrVv?=
 =?us-ascii?Q?Jl40OhOCo/l1vjL3u6pl/cPqMtzIEI2A3ZIStw5BM8Scc8sKbhHNxC/jZQ0A?=
 =?us-ascii?Q?UUU/2k/EeM3sogVyPP55ZxEBnBVkXt8rJjgQhjn78LZoNQEqily9QRBa0R7I?=
 =?us-ascii?Q?pIp2Mm5UPhpHddHGbyHm061/S0me/u5PFgsccHZwhoxfbq2Ge0o7D28p9ZnZ?=
 =?us-ascii?Q?BAILvvLFuT3/rBJQQyGUGCHfoYPQzdRXgciguvxiOTpT4oHVlgRKZUSX7Hyk?=
 =?us-ascii?Q?ggBcig97oVpxzPplSEESGgV30t46xnTCwvAd38dw8nb6FbDUR7Hhb1nFkTxs?=
 =?us-ascii?Q?JqDU8MoxCFi+jfxJvX8PbrOTUWFsCDXGuLcHhpJFtUKlYK2LzwEAOAVvnv1j?=
 =?us-ascii?Q?4IpV2SnqH63kim93uMOiOKB0IFhXqrOcIc3wp/fYpn6Wo6tSthCLwVrs8DF4?=
 =?us-ascii?Q?1bv/l1qQmiH/NSNx7XoMlb7uKjAlGIW6L+m0Fk7UVibFANZpxnfICSMvFTyU?=
 =?us-ascii?Q?BMXAGHdkyHVdZl29RW1aCh3QdTXs564E8ELmjWFAe+hm3swMhrhS0ubfH323?=
 =?us-ascii?Q?2stQOuDXJoR9UPcx2+3YiIbz+LcwVW1CPZ76HL3x1NM1xzxqKg7egq8SiWj4?=
 =?us-ascii?Q?7qmxm+PTaljfpvBEZLLmcvCbo5tfF4KWlhTGX/IIvvxh9TB4vGe991lFNrVX?=
 =?us-ascii?Q?vgiry+05TzNSyFwA6eZeZr/kB7X6XFszpM1B9HCDnl11pCLdIYCW6Hl9/MzP?=
 =?us-ascii?Q?Dr8wWrgomruzgvZ5DYGif3CNSboUKsg/CUnpGWk3oHUYUF9YjRFZyH/Xw+/r?=
 =?us-ascii?Q?MUYGVi5mxwIFAvXnxBUTTqA4WNMwnDYzqVLIbzPwOpr6z7chHv9K921RkRY5?=
 =?us-ascii?Q?R2Vi/Cs7J0DUhRyk+ZTfThuaaKYYWL/g0tyJmzzQUckinwV2O6iaBlGPWgtV?=
 =?us-ascii?Q?/r11Qt6r8ls8nX/F47IeRjfsCgJIpQphAyBxBrfTV+iv/oX2ul1wUNC8rMAA?=
 =?us-ascii?Q?D8U5UUbHHA4lAJ1vP9D8yIOucy3TKpvnSvzUp42Ieas6FXiylBfLhdnGebz4?=
 =?us-ascii?Q?bFJatspzW+O4hAmTY/G9etIElLPtAu8IzWU0onWtN69Z0yIZFqbiLsULxkMt?=
 =?us-ascii?Q?ZWZ1Oyrt+NJOHwA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 18:25:32.8135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac44ff1-6e61-4615-4e96-08dd4eb74cb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411

Add a selftest that verifies symmetric RSS hash is working as intended.
The test runs two iterations of iperf3 traffic, swapping the src/dst TCP
ports, and verifies that the same RX queue is receiving the traffic in
both cases.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../drivers/net/hw/rss_input_xfrm.py          | 77 +++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  7 +-
 3 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 21ba64ce1e34..23dca086f84f 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS = \
 	nic_performance.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
+	rss_input_xfrm.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
new file mode 100755
index 000000000000..e32df852f091
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -0,0 +1,77 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_pr
+from lib.py import NetDrvEpEnv
+from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import KsftSkipEx
+from lib.py import rand_port, check_port_available_remote
+from lib.py import GenerateTraffic
+from rss_ctx import _get_rx_cnts
+
+
+def _get_active_rx_queue(cnts):
+    return cnts.index(max(cnts))
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
+def test_rss_input_xfrm(cfg):
+    """
+    Test symmetric input_xfrm.
+    If symmetric RSS hash is configured, send traffic twice, swapping the
+    src/dst TCP ports, and verify that the same queue is receiving the traffic
+    in both cases (IPs are constant).
+    """
+
+    input_xfrm = cfg.ethnl.rss_get(
+        {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
+
+    # Check for symmetric xor/or-xor
+    if input_xfrm and (input_xfrm == 1 or input_xfrm == 2):
+        port1 = _get_rand_port(cfg.remote)
+        port2 = _get_rand_port(cfg.remote)
+        ksft_pr(f'Running traffic on ports: {port1 = }, {port2 = }')
+
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg, port=port1, parallel=1,
+                        cport=port2).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+        rxq1 = _get_active_rx_queue(cnts)
+        ksft_pr(f'Received traffic on {rxq1 = }')
+
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg, port=port2, parallel=1,
+                        cport=port1).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+        rxq2 = _get_active_rx_queue(cnts)
+        ksft_pr(f'Received traffic on {rxq2 = }')
+
+        ksft_eq(
+            rxq1, rxq2, comment=f"Received traffic on different queues ({rxq1} != {rxq2}) while symmetric hash is configured")
+    else:
+        raise KsftSkipEx("Symmetric RSS hash not requested")
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        cfg.netdevnl = NetdevFamily()
+
+        ksft_run([test_rss_input_xfrm],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index da5af2c680fa..76aaa65c0367 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -5,7 +5,7 @@ import time
 from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen, bkg
 
 class GenerateTraffic:
-    def __init__(self, env, port=None):
+    def __init__(self, env, port=None, cport=None, parallel=16):
         env.require_cmd("iperf3", remote=True)
 
         self.env = env
@@ -15,7 +15,10 @@ class GenerateTraffic:
         self._iperf_server = cmd(f"iperf3 -s -1 -p {port}", background=True)
         wait_port_listen(port)
         time.sleep(0.1)
-        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
+        client_cmd = f"iperf3 -c {env.addr} -P {parallel} -p {port} -t 86400"
+        if cport and parallel == 1:
+            client_cmd = f"{client_cmd} --cport {cport}"
+        self._iperf_client = cmd(client_cmd,
                                  background=True, host=env.remote)
 
         # Wait for traffic to ramp up
-- 
2.40.1


