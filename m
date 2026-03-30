Return-Path: <netdev+bounces-273171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEdAHlR2ymnZ9AUAu9opvQ
	(envelope-from <netdev+bounces-273171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD9035BADD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADA23010145
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EACE3D348F;
	Mon, 30 Mar 2026 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m2I4Sr1z"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362163D332A;
	Mon, 30 Mar 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875754; cv=fail; b=KCmJXRSK9R3VGlOm3jqQGrkyQ5lkv3ZXf16Li+sGdsbb1rMwp+LgZErQJTW5uXDrscC06I7NO1Abx3aAkOupSD9gEh5nph8JNCpSRUAqMS/kkGZ6DXMO5Jra0qa18JViK3Sm+oLRc4IVp+5yEVvuWaEQ0TFqFaQwjBMqXCW5Dik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875754; c=relaxed/simple;
	bh=lHRpSU7TsMfeUYmBDX58BiNOL4gpnpjc3L3T3jEWA4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S09se7rvTgx2i0dqbMakU2tiSpgooCdOBIcLBZMQc+CIVfMAS8Yd0Qpq4PspCLS/fBWZWy/Qsqu7Uj8amOhUtjHv0rySKMD0xWpK4bl2VXGyJfQmfbCNffLUVO8SbkPxQT63iLgxUUYJy8OrxB4zk3/XDIWSnIN1gdagd0xsWJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m2I4Sr1z; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdlFf54WnuXaaNutcOv6vcJ8RkHgMM2vXUgCRsEXqeOkE22ecc7qsdsJPlyCgbM/VuZ+5IsMvNHYtG5fW+zVVQpLVinSFu+Q45YNjb7ydE3TFv4d9K8/1KZfDCSJUVoh4VC4po9fww/ZwZFq3sY6KFNpRJCuhVgs8LlbPPGPjiBnIh5TV+h3VcZLC4Vg1B+tyfS13qfCmFo3H6eCC7yWXolkwNpWWWfy0mcVzIFnRMQbgo04b0pD717d44pOuVK5WI8bp2zb1MqgeVhHHQCf8LPo3VhXRlTg5qb+KhYCJbazrBXVhS/zMW41BaYcpFZodL62aAPM7x6jufN3TIaP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR3O7nvxvNHEd0jQHsunsU6Dxis0U/hkaXp2JFkE1cU=;
 b=T8rHC/ByoM2wzPv4goSnWZfWRDA5s46VTrI9KdSmdMOkClzeKA9f3r/y96SzSj6/93dhfBVRybd38JsspFFZjMZELYmAaflRMgCH/JA6q4pnPX1wn/jqoghrehXZb09Ev7DO3W+nWTwZpPfYFOAJ8M/ilCqqy26n4OhLeH9TXC/X3Y/twU1C4hwoK442+VnuVWismV8ROZx4W+vheo8D7oEBaaICnMS9ghUeTZYpdjaZ0HKjcpDfftpR3x8c5EEb9iKstO3xWj/mu5+bdRcKsGOkaHfW2Y5fKAq7P4EftSPcm+XyXr8OW+8bi/d6Tm1GtW6o2/pxsWVrgvQ+DLCATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR3O7nvxvNHEd0jQHsunsU6Dxis0U/hkaXp2JFkE1cU=;
 b=m2I4Sr1zP6Na5VIIsKZw5Ha2AhdkT78LtvNm/NSFxjQQr8RMcWub3G8TikgLbPcZDpd6UA3/O9HClsjhMulm9jDgAVMVPrLMBj9Sa18GA/Xf3jKj5II/L0KOcgdVKV49swItie2/0PqCe4N1ws90ZT5P3tA/hw/QRiIxWUBRT+iCh9LtEsivmZbtD8H2tGCIELNMtHWxKcecAXQRRxAhCJhkG/xBK/mOM5xAd09m2rwvgzLCAfprYlnDg6x3Q31wNU/gP+vTjMnA/Bh1MOmdc3lz6KuM0hsMVLrA2ky9rLirIxlKI18tLMzK+wPUcGpUXxapH1s19+b78irWF0TSTw==
Received: from CH0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:610:e5::29)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:02:24 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::8d) by CH0PR03CA0264.outlook.office365.com
 (2603:10b6:610:e5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 13:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 13:02:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 06:01:59 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 06:01:55 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v6 1/4] selftests: Migrate nsim-only MACsec tests to Python
Date: Mon, 30 Mar 2026 16:01:27 +0300
Message-ID: <20260330130130.989236-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330130130.989236-1-cratiu@nvidia.com>
References: <20260330130130.989236-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ce26c8-0fb0-4613-2f42-08de8e5c966d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5cLhBAKgyj+6RWUoiMYA40tq8J1XElyKIHIyDBeKrGQdBTt+oo+0uszmmbd70AK4iirsZLmGHMXbiCU3MoeCaMMGgmp+qP402mSoDkewZOBth41QnVYOWLiYO8GRZnUaE7n1Ux6eRjDxAVutfV+gxG2vAx17I5uUmSqPsaSlDGNpn0FFmm7vDF1ALzbr4zVMNKcvT6LD8P1uYzo0ulSRFR46KwIhs3uSr3CrEWsb6fWgkCRrAEMj3ZDYIJhkg+VjUI2g1Rbzp+Uki8YifQNCZbQZjCJNRuJ1RIFRD1+eMGWJeZBq6Ui8FwvDNTs8cX+5n7jzJ6uoILrK0LFVAg9ZhdkLaec8SmJtgOLfdAww2Db29SvVUw5KR1hCtTUUl85NrnTR37aXW8kvRitV4nc/tFHUjqVOeUA0M4L8ZWt0ieZR3vK/hOdJdVs7yNw2/KlLwUOF39HSF0Xl7ON5O9qtY2We2ixTuOQJ98/+n0HHmozSNVKLALsqddtNRrluU5kn5r3lFZg/VwOgu9FOMjLtutshA6xG2jewPsN3WNIvfrMIMvIhLu7BAyNBTFKPUe0bJ9dRL9eOtS/Zwq1r+J6csdh4LUr8IbGjuaibdyQO7VbVdo63nsRounsNDkMEZga6ryGCqq37eK06svi0m29foJS3RrcVhSgp9UO2hIB2Pn8vwyav7Z9YeynR6/5ERKnzCbBboyLjzMyRy7IqGmMwhBpExd5DmZ75VxKv6I6HCe15MHxtiZBVRjTvGRNOdDOcUT8tGoKi78yk04soOvh5og==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p6rS89bZv8xwIA/95n/nmcImZE6yShbm0KyiDx3bU57s+5QyPJT9c7efYrfHay2+JJzNou7yjtvAnbQ4Xc3h7TY8GmwIoBM905CVEb3J9KxGq4sSv8Hkl0aa0QGto+9cyaolFBYJlUCBiKJ+xGZazoUwETtwnnS32VV+iVEMnR+5uWqpXe6cV0KS/wflIWpi8KxbpY3srdCG4yCJNpWVb3No4yUIbwCuVRR9aF3nEt/B9B2kseCkpCMWcBNH8w8I2mFL6fPI8BpU2fEFLnYgqIEbTie3dOauwGYtN/fX1bYV6BSw0gq7Tr9B8l4RfVL9a4jqdwLehlhQ/KT7Lvv6jwYbZpLuL3qnFcJboo++Li9t6jIbUJ0UY6s//00jid1jRrqd8+OpeeNb9PU3aJezTT7duFfVG9+C1qBlQUdpzxO9rUsX499l7y2scrEnWcM+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:02:24.3437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ce26c8-0fb0-4613-2f42-08de8e5c966d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273171-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,macsec.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url,ethtool-common.sh:url,macsec-offload.sh:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CBD9035BADD
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
 tools/testing/selftests/drivers/net/macsec.py | 179 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 ------------
 5 files changed, 181 insertions(+), 118 deletions(-)
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
index 000000000000..a17b9f7ef584
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/macsec.py
@@ -0,0 +1,179 @@
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
+
+    ip(f"link set {ms0} type macsec offload off")
+    ksft_eq(_get_macsec_offload(ms0), "off",
+            "offload disabled: should be off")
+
+    ip(f"link set {ms0} type macsec encrypt on offload mac")
+    ksft_eq(_get_macsec_offload(ms0), "mac",
+            "offload re-enabled: should be mac")
+
+    # Delete and recreate without offload
+    cleanup.exec()
+    ip(f"link add link {cfg.ifname} {ms0} type macsec")
+    defer(ip, f"link del {ms0}")
+    ksft_eq(_get_macsec_offload(ms0), "off",
+            "created without offload: should be off")
+
+    ip(f"link set {ms0} type macsec encrypt on offload mac")
+    ksft_eq(_get_macsec_offload(ms0), "mac",
+            "offload enabled after create: should be mac")
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


