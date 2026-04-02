Return-Path: <netdev+bounces-274472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFgQJHxQzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:18:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3842638835F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A7F304BD19
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A503BBA17;
	Thu,  2 Apr 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMWjbqNf"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8E39EF16;
	Thu,  2 Apr 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128287; cv=fail; b=P5bM35NpPaRE1i8lO/0sFbcbh3Ry/64ltGB96WlXQflDryKjlSzydz7SUee4f/jrXNEe4FkpE1hWgBmHT5HufLEuO5ht9v6tH0LKjTzbmaDk/dipK9KvMXmPAUiFf3rJRGQJXKoX72YAUOSTFTsz3FHv+ZrTzsxvzDDUlyu9VU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128287; c=relaxed/simple;
	bh=yuDchkuztKUT0TuBrLasNaIkImVn/QMuy8JcD6y6zUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoLbvMlGUhds0CCuIvEpPxvlEupqPv5YwBAVzS8mYmXdU9ux5sHSubYssXvFRmbI+TN1950UAW+JE9PX/TrbQJ6/gIbr/H8IoSf0mfgNB5WyEUfn0Zfe0y5PHOHmW24Jp6lQHEY8QPM3ER2PC7NKjv6LWZgpxqqnEepKo1yf5fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMWjbqNf; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP89ofFbD49UiUJWy8pgo5oFOpYfglx2qls4uE50bgYP9XSJ/RcVVpIPVPJYd7q2FBc3vznkS60giFDeTEynz60l1M6dYhdjqkluXzO729sKquVTMcxE6IsowbdT5lV8Tef+REeQ9Tt7LLX+o7PRkwR4eYhQ3ozfww6TAMNaiBZk1ENm7fcjwGRehG0ESmsSTuZ/UXE2Ou1yiX9yhbgDhAWwm4MniZMFI6BEPTC5+oi2sAASujTrTCYUGrsrCnC8Gv/13vO/e3FSabpJKN9coRYI+GUV/Y9VlC07hf+RqjEjE4spPj+bEPpeI+kwPAznArZ84tGtwQjfKTPtEk5xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3ScPnheCtIKgWkB+rm48sBAMyvPeWnG+lQzaleQJG4=;
 b=U9kavnWg3JfR8HFOfidofoxJH3mLfWewjflZuXofo2nAzslCD6JPdiI4cGYCf4NVb4GIcdSc0zI8VA6PwsaRgp7WA4Glp0+yGQ2ME9VYoyJDEtcs7nl5oW1/63/1Um+ib2xg2HEnQBmzbvd3gGA1djbkcsSviF3J63kOqmKabcxlB47UfUGfnpJO2xxtSG6dmgasUeuHoO7NJovthrTkVTLZikWot4bxfhpMir8YyWn56RfuCcDh0083nfu6v50zGEHytYWma4x5Rw1U58TDjCebtP5KJZ1wPOiwf7zHzjOE6ZbYF5OdThkqWkAxXv+b6UB7f8FNlPM1ccJbyN5gog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3ScPnheCtIKgWkB+rm48sBAMyvPeWnG+lQzaleQJG4=;
 b=dMWjbqNfQOfWXUFYEMlvAueE7Yh+K8wqO/F5+To9Pt8ewmnGLorLxuWufg45CmzFKYQtb5ZEkvik4wfNe6wEfqR46/oWzmUh1zmGZabAgUKXuVQ9swKShJDmmmjslQGK4UwBpYtr2sscj2niGZFAKjlQYnJDa4BjLfSWnZTeMLesfCJeIxQNGXyl+8BGF20AvW6n8ZDOU2xKDkjgGuXBDsC3OAjbCaodnJXSNT5uZWN9+8VKAT3MhNzxMciLA+HDjr6Acz/DqSCQGJx0xmIbCTqE5bRj86VgqYh/mTSIXBchAaTYXRm8jXxpTra2ZjmrnktzdUVGu2xnSbRuFXA4oA==
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 11:11:18 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::45) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 11:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:11:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 04:11:00 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Apr 2026 04:10:56 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v7 1/4] selftests: Migrate nsim-only MACsec tests to Python
Date: Thu, 2 Apr 2026 14:10:31 +0300
Message-ID: <20260402111034.1494714-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402111034.1494714-1-cratiu@nvidia.com>
References: <20260402111034.1494714-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 776db868-d0c2-43bc-6c22-08de90a89054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0NnLJuIX0DVtnjApLv0qyr5IfNTXp/xrWpqL17LHtQrogi7Y9Njyv+ZV/n3XuAGFDl7CJ4tVE6W5cX6xcoKQu3SDbAkF/AufYL9lDLr0JVs2Bjv4VVYPWc9iwX9w43AqkvoiIj/aNqJ6E+LqQjgQvZGVLbqT3TARYCz4wjENC5ru9JYUWUozjeg3XH4fhm4AaExTKPuMoyWinTAtIA4K+6QorSGaLhhONfkGQDajy4TGGYrHyivtHBLETOC1qJVSA+Ih6Qu1MwGs0NGgjcCFaK4ZK2UACFnZoo9k1gIxUDEtl84zm++sYdIYSP6dIVkOa5k+DIaj+1nS86UUf6cTAzsab5mrKtfG3lIElBVE3v7UH8nAQAArBoaCSX2tFy+9tJiiqMq4MDpdApkCxab0/q4OfIyowyXdBPv0A5GdfBjttG0J6zXq4tCkmzGuAHOgUzA0n/37WWsRbm0tQZfOMWCg+6oP53eYunKUBlc3Gu/kaf+L42cDY9BoUdnM2CuirQUj3DbQelBH0NLs6tiwDIfDz0m45cknzzaSiAHW/PiAzsDrvOmlKCX/GBro5wM9DyiPvV1yMJ6K+4vqO9nxi5X8C9IFKvabi6YIeMl/7L4RTlxbDOMEPRe7ZlEAenXeN5lEIY2+9H1iCAxRu5GTmJVS/QtEUFVus0QtWJgbJjKgTQqjCue5Brlb/JraJItH+6qdsD0srhNSPEqNoMUGMuDO8T1Hzt6RBw+trNEPMRYaMT2LhBCsT620bTLSGdXNkjXBnVASv80IDflJpWATZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qVVIXWXlKSxC26Oli6MTKukXsYCW8twrHTjovTgG0rXwN2wwkafT+CFx1k6aDGKFd6jLpLTsK7Gh4Wj5Jkn2jJxfbGcIb8l9fNwQKCUIazmtjRrhhZ2USf0JlouRGDCOrMHe9p5gnL51QOYJR/7ZYfrzS4NJKN3Da0GDigGhztcaQl4BUZuoTE3P7nhk8rAkmJ5H+urilkWDzRSIsZuWcE0o1rF2oDQV9N3qD3L1nldrzWZhWWjXU8cp+rfJ1j65TphCp3YBoLUjn/fb0iO1q+s6PetxgiPPSpt52fG+1SK4KgfpVoY2mPm0Zu+ybHazRC1swSHBKQOWVS4ZgA2ZTWounxV8wrN8/r/zHfmZ1xPaFxi/pilTSR3gprKDx5cxjS8+9aCnhuG/N8nwvHegg9y1oIB9s+UT7Ga6srGMfoX5iKYAQWoeVr7X7OkpsW1S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:11:18.2236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776db868-d0c2-43bc-6c22-08de90a89054
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274472-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,macsec-offload.sh:url,macsec.py:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3842638835F
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
index 000000000000..7bcfae7800fe
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
+        if "macsec" not in out.stdout + out.stderr:
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


