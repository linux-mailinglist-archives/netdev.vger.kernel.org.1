Return-Path: <netdev+bounces-267404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA7+Cpvss2mDdQAAu9opvQ
	(envelope-from <netdev+bounces-267404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:53:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E16281C61
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86B78300794E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600C38A725;
	Fri, 13 Mar 2026 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBznYpvc"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8048B388388
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399191; cv=fail; b=e1GlshpOprszfEJfsp2AEhjSClLLBcJo1igZZ4KE54Z1lS5Evm4cbQFLVQgS4/eV/OY64vIwyvNHiam6sesxbSYp1+UoCsggPgeEakvhrbibRf0eu7yY3ji5nOpPYuHvPUkciWArs9YDXsIZwJLZJqWe8xAMFlExkZ0SFReJWpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399191; c=relaxed/simple;
	bh=svGlYMLq/8oEfvn7M+dGlnhfWTsUO/udbiZQKvkH6O4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=appf2IjAFlFXjjPFzgoBN+i0BNc12JzowaJ6NUkkykPXbT+yGPOSm7rxL2KTqx2nSeng3XpclxxZXBuw9hUHJS4RN4y7rsQTrnr8gumEXVedNmMQjy58aqMHVrkq88JHGRXtYOrtoZJHtdPQT2ivlXvv0PKvoOghEJBOHf3s87o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBznYpvc; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIMDNy0IqtjeZGWmV0yHy1zPAUbf4g4xlPt8XCk56tPkHq82/wK46+4VH0bS5iakJiBy5zg04N97bWWFtWH5CoeEGR1uSNGdYIuy6VhtKjKHhqZakt7guKOEjL/kN9Epyer1hj034Vd2KMvrHCNyTFAsEkm95LPbTIskwgAQ5+CIu+bBzbCX8UmYywoKVF2BQ4vTPlvI4p7DTd2VP7tXSozoXUFhmNMd+VBOYpVkTkKOM0DpSEmcB6fh2DnEBfYgFkr/q3CMVe7MR8l4Ve2DrnU8Yd/e5G7W/dNRCGD4Upr3B65qow/lJe3BuUwDMcnV+9/rAIjQCwRNC1mYlpF/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzu05OqIvSHzqSTqkLYHO2bkJOL0GUg9rjps4uYt7MU=;
 b=A7i3Qaf5aTujSvWm0FjjHtXy0BZAczmQHBs5MVIInWG2/OrfN4NtDhmd4QF/RUrH4CsNtRyX8u8RoeHUGq1ePjeD8DMOi875H/A59QZpsWvSTIx+wa9aiHKNBORh0A2Z4Z1NBqTnu33I/llNnsg8Eox1Yjl9Wpf0wNJpnYQ+5+lOxFK4Onh7zHHmcWyEBOXBWqm5kPU0YFkfYdG4G3arlMyFGgeYly12OvTXutjL3bY5syg0XAXMFtyct5AtpjyfnE4M84qG909C5sUmGyAXRqYLUz/TdkWTD9ZT1wtN72jNFCwRstSgFCW8XItD1pog4CbcrrxegPjt2q2GMVRoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzu05OqIvSHzqSTqkLYHO2bkJOL0GUg9rjps4uYt7MU=;
 b=mBznYpvck2MHwnt7Hy5gZuNjfDK+10n78X53UOAzcd6u0ZRlpaYKgcnkNa38GQxq309G5IxBDXAZu3kEzAUWevvJwuW4cKfikIFcRAGbYmy2E2I+3uq/5YEJcmLqWcZSPg/o9/PRauCjIo+t7+WmON/svKG0WiMV0Oqii2t4nTohXT982RZ4GYFQVXo5/1/OuR+AvrIwEh5i08lntk5tzgNEPsQsFamsFRGr4zPVrvOOzXgvvHP4RAu8YS9Yh+DRPDPVlR79F61k83dBWgdmfEFy+Pb7NqT4lhegnu+HNLJMFQ7dNeFFcTf30ljqB9bmXNqk02VZPExxXdH9riQ/IQ==
Received: from BYAPR06CA0053.namprd06.prod.outlook.com (2603:10b6:a03:14b::30)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 10:53:04 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:14b:cafe::11) by BYAPR06CA0053.outlook.office365.com
 (2603:10b6:a03:14b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 10:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 10:53:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 03:52:53 -0700
Received: from pylon.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Mar 2026 03:52:48 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 1/3] selftests: Migrate nsim-only MACsec tests to Python
Date: Fri, 13 Mar 2026 11:52:24 +0100
Message-ID: <20260313105227.1884391-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313105227.1884391-1-cratiu@nvidia.com>
References: <20260313105227.1884391-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: f216207d-d800-43c3-5a23-08de80eeb3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CT/sPMIsS/OtE5SptlMFsCwM7TwaInXsfjc2MTvpMfmtxpKTggrVfMltTta0VfNWumjVj1rx5Ls0ZSy0c2gmwSN3xEj7MldDVVAFqm/kIC1GfZx6AQZ9rhrtdgv/wPFQn79s4f/y3JAAUA2sRxcpAxadkICIMFBYXOy7/fd0eniBi60hGDWU3ME/kVWSETCdKVpNOC3qxCWDzAasoCGQjuEfqGkT7OndqsXXIZKY3XlfDF+nkDIHcMBuBuPjPTz0oXbwPaIioAvgnmwVuYIAbImqeyF7fsZ/NrJdVdyZci6pubBSE0VrayM5CAjIq19ZCcUAsFFDPCQOpTPcwza6uTuH5FE3YxKt46AEjIdEQFJsO8MWO7xapmrsVkuEzeUmxmy+iaj6daw6IolJZJlr9J5iilP0bTDfEJ9Xbj4wuuZ1FsEYdx51GBeCPVhpB11W8eoIuVNq+Ak/mvoW1UdAy/xColfs2rj/JAzOp6NJstFKPm8pt7/VXDhHON/RMtkgNnvT+RZxAEb2nGkPfnOEIrT4vCIcdJHC5W6jpU+awWNV+v0oTtrdocpyJZaZP4gTeMkubJcY3GXhPFMqtMkWq5Xcq7XVSACAfwlb3+S1MRJHTwFPwloGvAQcH+uEmhYIh8kog7Cqg/0CrgGgi+vLIAKtngThplEUZ8dYntZI03HW2dTlOFYDp5vKXP0wKxXqQ1HpKvEheYhpmt22w+vM8FPhwJk+6a3DLB6+sB2tirOh9ptbMNXr422zjDTZlCWtc6AfYRRhtmC2btYJG57xGg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PCFFeJ+wN6PkDgGgZSb8Agxdi4/agG0vhbgmq04RN0p2t66NQq0PoZkCWiWUK2CG6C4MHRufHRidYdGLMWqpOJpxjKXNobF0rZFXgVgGZli2Xx/JNuUbkojeSwEwxMivGZue6cmgflBrujVWFEiwSKxD3cXGIKdpLSItsuGF4Izka3lslHSRrsXagCtoR9culWuteBoRYbIlu3K84EqALb+DQQv6XASpMw3fYshBultA9APUGvleMnnI/tOAmTHZHa2H4H6CH4iRze+fAiZ3Qw/JEhuh0hf95v3OvT1DD72GpRzIWF909i9MqhesHyz2/nPgNyzDNgpXTjdzZB/WE16eh0Zy1/1XWizzJNt4WVihLCCsz1y03ul4HhoaSoxGmgms3mQhtNnoUfWKw4Ouex3j36r2Z1zcOnyyoCHfI71AqrffOF6It5SBK+eMc4HV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:53:03.9053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f216207d-d800-43c3-5a23-08de80eeb3c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267404-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,lib.py:url,macsec-offload.sh:url,macsec_lib.py:url];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 95E16281C61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move MACsec offload API and ethtool feature tests from
tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh to
tools/testing/selftests/drivers/net/macsec_api.py using the NetDrvEnv
framework so tests can run against both netdevsim (default) and real
hardware (NETIF=ethX). As some real hardware requires macsec to use
encryption, add that to the tests.
Extract shared helpers into macsec_lib.py for reuse by upcoming traffic
tests.

Netdevsim-specific limit checks (max SecY, max RX SC) are guarded
behind cfg._ns checks to avoid failures on real hardware.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/Makefile  |   5 +
 .../selftests/drivers/net/macsec_api.py       | 103 +++++++++++++++
 .../selftests/drivers/net/macsec_lib.py       |  20 +++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 ------------------
 5 files changed, 128 insertions(+), 118 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/macsec_api.py
 create mode 100644 tools/testing/selftests/drivers/net/macsec_lib.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 8154d6d429d3..511346b7d9ec 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -10,9 +10,14 @@ TEST_GEN_FILES := \
 	napi_id_helper \
 # end of TEST_GEN_FILES
 
+TEST_FILES := \
+	macsec_lib.py \
+# end of TEST_FILES
+
 TEST_PROGS := \
 	gro.py \
 	hds.py \
+	macsec_api.py \
 	napi_id.py \
 	napi_threaded.py \
 	netpoll_basic.py \
diff --git a/tools/testing/selftests/drivers/net/macsec_api.py b/tools/testing/selftests/drivers/net/macsec_api.py
new file mode 100755
index 000000000000..1d1185582bcd
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/macsec_api.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""MACsec offload API and ethtool feature tests."""
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises
+from lib.py import CmdExitFailure
+from lib.py import NetDrvEnv
+from lib.py import ip, defer
+from macsec_lib import require_macsec_offload, get_macsec_offload
+
+
+def test_offload_api(cfg) -> None:
+    """MACsec offload API: create SecY, add SA/rx, toggle offload."""
+
+    require_macsec_offload(cfg)
+    # Create 3 SecY with offload
+    ip(f"link add link {cfg.ifname} macsec0 type macsec "
+       f"port 4 encrypt on offload mac")
+    defer(ip, f"link del macsec0")
+
+    ip(f"link add link {cfg.ifname} macsec1 type macsec "
+       f"address aa:bb:cc:dd:ee:ff port 5 encrypt on offload mac")
+    defer(ip, f"link del macsec1")
+
+    ip(f"link add link {cfg.ifname} macsec2 type macsec "
+       f"sci abbacdde01020304 encrypt on offload mac")
+    defer(ip, f"link del macsec2")
+
+    # nsim-only: 4th SecY should fail (max 3)
+    if cfg._ns is not None:
+        with ksft_raises(CmdExitFailure):
+            ip(f"link add link {cfg.ifname} macsec3 "
+               f"type macsec port 8 encrypt on offload mac")
+
+    # Add TX SA
+    ip(f"macsec add macsec0 tx sa 0 pn 1024 on "
+       f"key 01 12345678901234567890123456789012")
+
+    # Add RX SC + SA
+    ip(f'macsec add macsec0 rx port 1234 address 1c:ed:de:ad:be:ef')
+    ip(f'macsec add macsec0 rx port 1234 address 1c:ed:de:ad:be:ef '
+       f"sa 0 pn 1 on key 00 0123456789abcdef0123456789abcdef")
+
+    # nsim-only: 2nd RX SC should fail (max 1)
+    if cfg._ns is not None:
+        with ksft_raises(CmdExitFailure):
+            ip(f'macsec add macsec0 rx port 1235 address 1c:ed:de:ad:be:ef')
+
+    # Can't disable offload when SAs are configured
+    with ksft_raises(CmdExitFailure):
+        ip(f"link set macsec0 type macsec offload off")
+    with ksft_raises(CmdExitFailure):
+        ip(f"macsec offload macsec0 off")
+
+    # Toggle offload via rtnetlink on SA-free device
+    ip(f"link set macsec2 type macsec offload off")
+    ip(f"link set macsec2 type macsec encrypt on offload mac")
+
+    # Toggle offload via genetlink
+    ip(f"macsec offload macsec2 off")
+    ip(f"macsec offload macsec2 mac")
+
+
+def test_offload_state(cfg) -> None:
+    """Offload state reflects configuration changes."""
+
+    require_macsec_offload(cfg)
+    # Create with offload on
+    ip(f"link add link {cfg.ifname} macsec0 type macsec "
+       f"encrypt on offload mac")
+    ksft_eq(get_macsec_offload("macsec0"), "mac",
+            "created with offload: should be mac")
+
+    ip(f"link set macsec0 type macsec offload off")
+    ksft_eq(get_macsec_offload("macsec0"), "off",
+            "offload disabled: should be off")
+
+    ip(f"link set macsec0 type macsec encrypt on offload mac")
+    ksft_eq(get_macsec_offload("macsec0"), "mac",
+            "offload re-enabled: should be mac")
+
+    # Delete and recreate without offload
+    ip(f"link del macsec0")
+    ip(f"link add link {cfg.ifname} macsec0 type macsec")
+    defer(ip, f"link del macsec0")
+    ksft_eq(get_macsec_offload("macsec0"), "off",
+            "created without offload: should be off")
+
+    ip(f"link set macsec0 type macsec encrypt on offload mac")
+    ksft_eq(get_macsec_offload("macsec0"), "mac",
+            "offload enabled after create: should be mac")
+
+
+def main() -> None:
+    with NetDrvEnv(__file__) as cfg:
+        ksft_run([test_offload_api,
+                  test_offload_state], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/macsec_lib.py b/tools/testing/selftests/drivers/net/macsec_lib.py
new file mode 100644
index 000000000000..452b0f9026c8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/macsec_lib.py
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""Shared helpers for MACsec offload tests."""
+
+from lib.py import KsftSkipEx, ethtool, ip
+
+MACSEC_KEY = "12345678901234567890123456789012"
+
+
+def get_macsec_offload(dev):
+    """Return macsec offload mode string from ip -d link show."""
+    info = ip(f"-d link show dev {dev}", json=True)[0]
+    return info.get("linkinfo", {}).get("info_data", {}).get("offload")
+
+
+def require_macsec_offload(cfg):
+    """SKIP if lower device doesn't support macsec-hw-offload."""
+    feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    if not feat.get("macsec-hw-offload", {}).get("active"):
+        raise KsftSkipEx("macsec-hw-offload not supported")
diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index 1a228c5430f5..9808c2fbae9e 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -11,7 +11,6 @@ TEST_PROGS := \
 	fib.sh \
 	fib_notifications.sh \
 	hw_stats_l3.sh \
-	macsec-offload.sh \
 	nexthop.sh \
 	peer.sh \
 	psample.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
deleted file mode 100755
index 98033e6667d2..000000000000
--- a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
+++ /dev/null
@@ -1,117 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0-only
-
-source ethtool-common.sh
-
-NSIM_NETDEV=$(make_netdev)
-MACSEC_NETDEV=macsec_nsim
-
-set -o pipefail
-
-if ! ethtool -k $NSIM_NETDEV | grep -q 'macsec-hw-offload: on'; then
-    echo "SKIP: netdevsim doesn't support MACsec offload"
-    exit 4
-fi
-
-if ! ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec offload mac 2>/dev/null; then
-    echo "SKIP: couldn't create macsec device"
-    exit 4
-fi
-ip link del $MACSEC_NETDEV
-
-#
-# test macsec offload API
-#
-
-ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}" type macsec port 4 offload mac
-check $?
-
-ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}2" type macsec address "aa:bb:cc:dd:ee:ff" port 5 offload mac
-check $?
-
-ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}3" type macsec sci abbacdde01020304 offload mac
-check $?
-
-ip link add link $NSIM_NETDEV "${MACSEC_NETDEV}4" type macsec port 8 offload mac 2> /dev/null
-check $? '' '' 1
-
-ip macsec add "${MACSEC_NETDEV}" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
-check $?
-
-ip macsec add "${MACSEC_NETDEV}" rx port 1234 address "1c:ed:de:ad:be:ef"
-check $?
-
-ip macsec add "${MACSEC_NETDEV}" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on \
-    key 00 0123456789abcdef0123456789abcdef
-check $?
-
-ip macsec add "${MACSEC_NETDEV}" rx port 1235 address "1c:ed:de:ad:be:ef" 2> /dev/null
-check $? '' '' 1
-
-# can't disable macsec offload when SAs are configured
-ip link set "${MACSEC_NETDEV}" type macsec offload off 2> /dev/null
-check $? '' '' 1
-
-ip macsec offload "${MACSEC_NETDEV}" off 2> /dev/null
-check $? '' '' 1
-
-# toggle macsec offload via rtnetlink
-ip link set "${MACSEC_NETDEV}2" type macsec offload off
-check $?
-
-ip link set "${MACSEC_NETDEV}2" type macsec offload mac
-check $?
-
-# toggle macsec offload via genetlink
-ip macsec offload "${MACSEC_NETDEV}2" off
-check $?
-
-ip macsec offload "${MACSEC_NETDEV}2" mac
-check $?
-
-for dev in ${MACSEC_NETDEV}{,2,3} ; do
-    ip link del $dev
-    check $?
-done
-
-
-#
-# test ethtool features when toggling offload
-#
-
-ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec offload mac
-TMP_FEATS_ON_1="$(ethtool -k $MACSEC_NETDEV)"
-
-ip link set $MACSEC_NETDEV type macsec offload off
-TMP_FEATS_OFF_1="$(ethtool -k $MACSEC_NETDEV)"
-
-ip link set $MACSEC_NETDEV type macsec offload mac
-TMP_FEATS_ON_2="$(ethtool -k $MACSEC_NETDEV)"
-
-[ "$TMP_FEATS_ON_1" = "$TMP_FEATS_ON_2" ]
-check $?
-
-ip link del $MACSEC_NETDEV
-
-ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec
-check $?
-
-TMP_FEATS_OFF_2="$(ethtool -k $MACSEC_NETDEV)"
-[ "$TMP_FEATS_OFF_1" = "$TMP_FEATS_OFF_2" ]
-check $?
-
-ip link set $MACSEC_NETDEV type macsec offload mac
-check $?
-
-TMP_FEATS_ON_3="$(ethtool -k $MACSEC_NETDEV)"
-[ "$TMP_FEATS_ON_1" = "$TMP_FEATS_ON_3" ]
-check $?
-
-
-if [ $num_errors -eq 0 ]; then
-    echo "PASSED all $((num_passes)) checks"
-    exit 0
-else
-    echo "FAILED $num_errors/$((num_errors+num_passes)) checks"
-    exit 1
-fi
-- 
2.43.0


