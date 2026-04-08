Return-Path: <netdev+bounces-276463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBBtOT9D1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:59:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580063BB9E6
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE763108E94
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10D3BFE5A;
	Wed,  8 Apr 2026 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JHLrZljG"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B13B8BBF;
	Wed,  8 Apr 2026 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649260; cv=fail; b=YMcZ51r1Kue6v6Oo72ziLYQLzLgAgnIrm8Mwt8GOKXo4EIp0bBIHOqWlheObQyLUPQsLer440FlWMjZFM1d9EXqYd//GG2ekTD3JLBl70YmE/s5TfgaC7ok7FSarzpP8hlnZ6X7KiAAMu0gL9IKS5XsnxUfO6TmxXR8zMR1lDyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649260; c=relaxed/simple;
	bh=t98NrpvfPvTUgFUOCns332XZgRQQ3r9QikNceKwYLcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcKHu4MwjuJLfaAlqSIaLal5IdflzKisBFl7hUh1HjWIf5/LpRLgOZz1cp3X4JOykaVmF4nEL2dZPxKol3CEijUTSaICRw/MahKQlMsL/qDVvWLGG4ELgDv3KztcpEj1hFug2bbv0ONgKQe3qVqqiorRu+xTlZ+L5gg3nSuZs20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JHLrZljG; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxcD9A9+YzVKOGbwzzl+HUC6BebWRmCcdBIPboRfn/1U6PmUNRnJJyAgTNgc+2HvVUm0wZUXwdShGVfJZtZzCdNoRERLEWBxSH/HcDHczELnM7juYm2mvZbMNeUevB8PbT7ENBLuPbDtSh20aZtxW0rGedBLIEuOleOeamHxD5YsH4RjkenPRUM+jx3OQxRDMngF7PtTWf7/opOX7eFvgxexk2VCxoR2Wab5fwAoXiLwxIJ5Aw/WJ90OxSo0R0mtjXYnx4ZVheUtdnU3c7sviUwhiwUDWlL4n1UzmjhyA0PJBRmLPnk6/TUOiNfMvxxGNyrLK//3zYSDFZ0vlRmuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPm+QtMuzpPOCa7QhnUErJbaTOuKlY92Ldf1QLG3Ldk=;
 b=auTtKUjO/Kf7dWRc97inVhPkA/Cd++ko2OIPbK2pWG0fphoPEhMdUz1umjCSrIZ/ibYUVqSd9NmgAUloGdjoEgRgWM3wqciRU/lGImh/PT30klgLkTLpJVjjaiR5cYSVDuNCFzMi9xVD3ttdXwtJe/oAp5EOYN2PhSdJA4fXQp+JWegG4681Z8TP0KoVw/f0PuOLzeE2NyHOcHH7DgHkg2315DFzUTdmtNRhmm2FxPofxGhpijpfKYchZGU58voBUd3qwQ3D92fGeacmRetx2kPdcsTNcWr39+EC8uohqXE4Ej9tLtyCTe9HZAA6KUlwWDF7S5MKEAGen+m+TdYYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPm+QtMuzpPOCa7QhnUErJbaTOuKlY92Ldf1QLG3Ldk=;
 b=JHLrZljGWoTUdajpX6jLatTn8tvJd50800JNLKf7vYyV0SYaMiOlYSQBM33+0jbeZJHp3t3iaeDSQ3HFv/cdbvKS53LBRQA4G9HV7saNMFaBN3fpC9NYuYzogkvOL5spdf5jBoeFgMmKZWpdym3ehR1Z3wLVyyGXXI+7Ovw5QeR5/d2atx4Y2yTUqqL0YO6ref5uzuVTjTpBBGN2iMV32V5hHXvtz+imUHxkLDxr2ITVBmzbPubMuzV8TRHderMxwnpjtjsyNDbONRv+JlbkvG6Z6Vk3bpA/EkHPwTEyZkiRiA1kKmGqICuGzG3Z7R/EnTkBw9jZsTv79a6atohpzg==
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 11:54:09 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::98) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 11:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 11:54:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 04:53:55 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 04:53:51 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v8 1/4] selftests: Migrate nsim-only MACsec tests to Python
Date: Wed, 8 Apr 2026 14:52:37 +0300
Message-ID: <20260408115240.1636047-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408115240.1636047-1-cratiu@nvidia.com>
References: <20260408115240.1636047-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: b94b1f90-4ebd-4c97-f124-08de95658b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8+8+AXivW0wKeFsfDV9oNxh+Nqvws41FaNNJRM70sVdcroIMn216kIvj7qIGRVpT5e5Sns5PiHqppPLCtmychyzcxd2q9pXsUMaVSZEuXwWvoGx87ShZoKnEb7izi57TOPLwoqGgSSGheiz/SgWtgJfns+SslWeQQBmH2XsWXSvGgyXWw2Jtr3GRh9pvuS+Vm3iU3O5sUVMfoVCsFA4ZyYN86zV6TXwWuEDkRFTXcDXfnY+u2waiaHhl4WYSxjS06CaHKurDQwuKXrTSHFb/tBEvF4M2cNd86x4TYAsKQ1suXSTHq3oScfCUIu9ZcN5Lck2jpPWq2uuRJCyJ3nH4D44ons37EVf3wHKUkHLXLVS9pRK5VPf5K9Ed8KYA67gXTApFxlPmdICBdU1S4S9EhEMxmQV5AsR6XpWG6IGy5SbZ7J8J5dT93NVVcw3vHDPnPckLOfEotHGkDsYG5CPaTuXXoSFQMo61ch8+/d/kIKVFgKNyLleDtgEKHMBJZbZHglz8taQYOdYYX+/yLX4oux4NPu6LdXodCXKepw+TZigSHHJNFkks3iMEzNFOD2waZFu2qe31Vem4HiG10SttOIXBm20lgvD6/dw+xcZCegrDcLadNjPlX1QNVzVpBr28k7qEIQET008IeTTfTRqjj4O+FF+2Rh4xYgdHp/uDjtDnqxrIDBRP8UuoiVEnJLtZgnnpDabAboNiXhepuo1OB+7zeArdiWQ2FUJu9eDwriZ3o9FRfD895SUVJHm41zKJIoOE0+cDouYoXW/Dbl6mWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jdwVylBNWYHyyVosBimHNygyCidpL4IKERgm6WfSHB6Ap76xFGOLBlZyyGxf7NfbPTjdR19hjhqfffv3ZMDEQexlNiepxTNJm4zfK2d6sDeWGxzZUoLSvtpKodGoEj7j3VQ1zAVWbrOs7KkcGqy80IWWqFtRGQfgCt8MJFzIGUgf9LYIzKWTql/0WPCvJvHPvmO1xt24utLEtwpDmETEBRPY8Hs2Et8RtOQcvdEdjGBjfkImqKRVTgvl9jD15YwbrybcR3stfX+RoXgcQzUB3rSbYm17Bh1l8VKtQbk/hMRtAXKu/BtkMZ8kKAOVsrXhwifyqrjRvtztgSjkXrHlLj2J3KMITcNvJOXoes4SGCBuEZdzMkmBjwCvEu3RG5EBrk7NlZBKUKExUejuKzuXCpcgBq7oW7fRjGrwJC/yjfPc8iO/DkoXJ7nWbHCCHkSg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:54:09.4524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94b1f90-4ebd-4c97-f124-08de95658b52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276463-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,macsec-offload.sh:url,macsec.py:url,ethtool-common.sh:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 580063BB9E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move MACsec offload API and ethtool feature tests from
tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh to
tools/testing/selftests/drivers/net/macsec.py using the NetDrvEnv
framework so tests can run against both netdevsim (default) and real
hardware (NETIF=ethX). As some real hardware requires MACsec to use
encryption, add that to the tests.

Netdevsim-specific limit checks (max SecY, max RX SC) were moved into
separate test cases to avoid failures on real hardware.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/config    |   1 +
 tools/testing/selftests/drivers/net/macsec.py | 202 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 ----------
 5 files changed, 204 insertions(+), 118 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/macsec.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 8154d6d429d3..5e045dde0273 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_FILES := \
 TEST_PROGS := \
 	gro.py \
 	hds.py \
+	macsec.py \
 	napi_id.py \
 	napi_threaded.py \
 	netpoll_basic.py \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 77ccf83d87e0..d4b31a317c09 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -3,6 +3,7 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_INET_PSP=y
 CONFIG_IPV6=y
+CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
diff --git a/tools/testing/selftests/drivers/net/macsec.py b/tools/testing/selftests/drivers/net/macsec.py
new file mode 100755
index 000000000000..5220c0656c0c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/macsec.py
@@ -0,0 +1,202 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""MACsec tests."""
+
+import os
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises
+from lib.py import CmdExitFailure, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import cmd, ip, defer, ethtool
+
+# Unique prefix per run to avoid collisions in the shared netns.
+# Keep it short: IFNAMSIZ is 16 (incl. NUL), and VLAN names append ".<vid>".
+MACSEC_PFX = f"ms{os.getpid()}_"
+
+
+def _macsec_name(idx=0):
+    return f"{MACSEC_PFX}{idx}"
+
+
+def _get_macsec_offload(dev):
+    """Returns macsec offload mode string from ip -d link show."""
+    info = ip(f"-d link show dev {dev}", json=True)[0]
+    return info.get("linkinfo", {}).get("info_data", {}).get("offload")
+
+
+def _get_features(dev):
+    """Returns ethtool features dict for a device."""
+    return ethtool(f"-k {dev}", json=True)[0]
+
+
+def _require_ip_macsec(cfg):
+    """SKIP if iproute2 on local or remote lacks 'ip macsec' support."""
+    for host in [None, cfg.remote]:
+        out = cmd("ip macsec help", fail=False, host=host)
+        if "Usage" not in out.stdout + out.stderr:
+            where = "remote" if host else "local"
+            raise KsftSkipEx(f"iproute2 too old on {where},"
+                             " missing macsec support")
+
+
+def _require_ip_macsec_offload():
+    """SKIP if local iproute2 doesn't understand 'ip macsec offload'."""
+    out = cmd("ip macsec help", fail=False)
+    if "offload" not in out.stdout + out.stderr:
+        raise KsftSkipEx("iproute2 too old, missing macsec offload")
+
+
+def _require_macsec_offload(cfg):
+    """SKIP if local device doesn't support macsec-hw-offload."""
+    _require_ip_macsec_offload()
+    try:
+        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    except (CmdExitFailure, IndexError) as e:
+        raise KsftSkipEx(
+            f"can't query features: {e}") from e
+    if not feat.get("macsec-hw-offload", {}).get("active"):
+        raise KsftSkipEx("macsec-hw-offload not supported")
+
+
+def test_offload_api(cfg) -> None:
+    """MACsec offload API: create SecY, add SA/rx, toggle offload."""
+
+    _require_macsec_offload(cfg)
+    ms0 = _macsec_name(0)
+    ms1 = _macsec_name(1)
+    ms2 = _macsec_name(2)
+
+    # Create 3 SecY with offload
+    ip(f"link add link {cfg.ifname} {ms0} type macsec "
+       f"port 4 encrypt on offload mac")
+    defer(ip, f"link del {ms0}")
+
+    ip(f"link add link {cfg.ifname} {ms1} type macsec "
+       f"address aa:bb:cc:dd:ee:ff port 5 encrypt on offload mac")
+    defer(ip, f"link del {ms1}")
+
+    ip(f"link add link {cfg.ifname} {ms2} type macsec "
+       f"sci abbacdde01020304 encrypt on offload mac")
+    defer(ip, f"link del {ms2}")
+
+    # Add TX SA
+    ip(f"macsec add {ms0} tx sa 0 pn 1024 on "
+       "key 01 12345678901234567890123456789012")
+
+    # Add RX SC + SA
+    ip(f"macsec add {ms0} rx port 1234 address 1c:ed:de:ad:be:ef")
+    ip(f"macsec add {ms0} rx port 1234 address 1c:ed:de:ad:be:ef "
+       "sa 0 pn 1 on key 00 0123456789abcdef0123456789abcdef")
+
+    # Can't disable offload when SAs are configured
+    with ksft_raises(CmdExitFailure):
+        ip(f"link set {ms0} type macsec offload off")
+    with ksft_raises(CmdExitFailure):
+        ip(f"macsec offload {ms0} off")
+
+    # Toggle offload via rtnetlink on SA-free device
+    ip(f"link set {ms2} type macsec offload off")
+    ip(f"link set {ms2} type macsec encrypt on offload mac")
+
+    # Toggle offload via genetlink
+    ip(f"macsec offload {ms2} off")
+    ip(f"macsec offload {ms2} mac")
+
+
+def test_max_secy(cfg) -> None:
+    """nsim-only test for max number of SecYs."""
+
+    cfg.require_nsim()
+    _require_ip_macsec_offload()
+    ms0 = _macsec_name(0)
+    ms1 = _macsec_name(1)
+    ms2 = _macsec_name(2)
+    ms3 = _macsec_name(3)
+
+    ip(f"link add link {cfg.ifname} {ms0} type macsec "
+       f"port 4 encrypt on offload mac")
+    defer(ip, f"link del {ms0}")
+
+    ip(f"link add link {cfg.ifname} {ms1} type macsec "
+       f"address aa:bb:cc:dd:ee:ff port 5 encrypt on offload mac")
+    defer(ip, f"link del {ms1}")
+
+    ip(f"link add link {cfg.ifname} {ms2} type macsec "
+       f"sci abbacdde01020304 encrypt on offload mac")
+    defer(ip, f"link del {ms2}")
+    with ksft_raises(CmdExitFailure):
+        ip(f"link add link {cfg.ifname} {ms3} "
+           f"type macsec port 8 encrypt on offload mac")
+
+
+def test_max_sc(cfg) -> None:
+    """nsim-only test for max number of SCs."""
+
+    cfg.require_nsim()
+    _require_ip_macsec_offload()
+    ms0 = _macsec_name(0)
+
+    ip(f"link add link {cfg.ifname} {ms0} type macsec "
+       f"port 4 encrypt on offload mac")
+    defer(ip, f"link del {ms0}")
+    ip(f"macsec add {ms0} rx port 1234 address 1c:ed:de:ad:be:ef")
+    with ksft_raises(CmdExitFailure):
+        ip(f"macsec add {ms0} rx port 1235 address 1c:ed:de:ad:be:ef")
+
+
+def test_offload_state(cfg) -> None:
+    """Offload state reflects configuration changes."""
+
+    _require_macsec_offload(cfg)
+    ms0 = _macsec_name(0)
+
+    # Create with offload on
+    ip(f"link add link {cfg.ifname} {ms0} type macsec "
+       f"encrypt on offload mac")
+    cleanup = defer(ip, f"link del {ms0}")
+
+    ksft_eq(_get_macsec_offload(ms0), "mac",
+            "created with offload: should be mac")
+    feats_on_1 = _get_features(ms0)
+
+    ip(f"link set {ms0} type macsec offload off")
+    ksft_eq(_get_macsec_offload(ms0), "off",
+            "offload disabled: should be off")
+    feats_off_1 = _get_features(ms0)
+
+    ip(f"link set {ms0} type macsec encrypt on offload mac")
+    ksft_eq(_get_macsec_offload(ms0), "mac",
+            "offload re-enabled: should be mac")
+    ksft_eq(_get_features(ms0), feats_on_1,
+            "features should match first offload-on snapshot")
+
+    # Delete and recreate without offload
+    cleanup.exec()
+    ip(f"link add link {cfg.ifname} {ms0} type macsec")
+    defer(ip, f"link del {ms0}")
+    ksft_eq(_get_macsec_offload(ms0), "off",
+            "created without offload: should be off")
+    ksft_eq(_get_features(ms0), feats_off_1,
+            "features should match first offload-off snapshot")
+
+    ip(f"link set {ms0} type macsec encrypt on offload mac")
+    ksft_eq(_get_macsec_offload(ms0), "mac",
+            "offload enabled after create: should be mac")
+    ksft_eq(_get_features(ms0), feats_on_1,
+            "features should match first offload-on snapshot")
+
+
+def main() -> None:
+    """Main program."""
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_offload_api,
+                  test_max_secy,
+                  test_max_sc,
+                  test_offload_state,
+                  ], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
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
2.53.0


