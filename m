Return-Path: <netdev+bounces-270515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O6PAXg1wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:43:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C7A2F21DC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D1930692ED
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D0D39F16A;
	Mon, 23 Mar 2026 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="plJm/TGk"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68D39A05D;
	Mon, 23 Mar 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269443; cv=fail; b=pkxvTumYkv53iAox0iQQlZzWkMANKjRlWYvbWALIBuvZa4E2pIk4gQDXU/cO2ohTL9OsP9vMwKF3ZkHJnJOdTtJ5ZzNizBQ3RZAjxkGWFnlFsxHeo8CJRyWLaFyNdxuw17Pijrrroo0uaa1ZpCrrfi50oP0VzA80u2JLj82lHJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269443; c=relaxed/simple;
	bh=6wC4fotriqMlEgEeljY8JVNTOJQzUZf9LyPNxeKRXPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH8gawbkX4XmWp+Zzj/xfkmAjAFgbrs6OCcSET5V1TS3HEA8WVKhZpVeDoYxW01vV0cb4iz66lzV2Qwqq3Ubo4j+pvXiWAiMmpovRWnEHkQbYHMfxZmDGA5i9EOHZeiK7Cdgw1N0yIR8qwAmN4FfJe7+HAUbygPEYKYGihL3Q24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=plJm/TGk; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdvEeXO2jFMIKI5d6nEO8qpt1X2bWg5oF3rdnyCJnM+ScaM1gwIMjtQhTj1APHGkfj/iYmnyXEQPhZhc13hz/nL1c+J0AFAyQ8/e7KEMffJgVd8cZcnRc5tJBUX6PCLcEkZYBbUlpFOsErUEt8DEqvj9p8eeYTnxpOCa34QJRQ3mx6Kqpl8+OFSNlYIqcPetX3anP9RlgK3YZqRAWywZk/OUmvh4pM6+NyH9DQ4+znbu9eMIDcUmlbyBo0WTLKu5wSUVHEF2aRumxf1row+bpCkMtyBCf2kldRoVAU0gpLiK9Xq8fAiufg1x/XY4N98TgkeTHcBgmQ4jRvEiz2PwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8ZTs6rHlM38u2GBzRf9Vg804oj/3LXKmF31nmZuTs0=;
 b=D1dJGoetPDTomyQDRV5hGxrhJI2IGBcrb0s5HLXC5uztBCm9CX6zBcneutmPIQMp/E+bufGzj14qLvK8Qsnjtv8hF+2oTNvV3V3th4W4FDXtHoKFtL+eJsViXuODdajajmpJKAwKJHLDX/h6m9jntEs3lEcOQRBtB4k7Uf2Y8lWqcsD5jStlNnqUsp3g65Xo8eG7FjnJy7l/wVE0uAeBEmnBIy9N1IUo9v8LV1Ej/9kFh7Ksx3KAQOBSdOtfy8EeD9bF5QuFACojU/tWIrxHZcKzm5CWlYjVE4wcrR228aCqVDfuKshIOs5yGqx71pBxYhLnhOjmcA9m7rB5pPOIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8ZTs6rHlM38u2GBzRf9Vg804oj/3LXKmF31nmZuTs0=;
 b=plJm/TGkpbuq006T2KOu1EuQHGK9FmlutCD2TJgD9Z7G8oKeNM3o8uCcKnhDuykPwzQ96WkLxhrKpEV32ThkVwWx0JxPTgLKTOmg/b6mtSrfdLOGy9wCjLDOBjkbhqQtzJoW58uNvgY2//kWLJ2iV/ESG7D4ITBZYhMhkuXfL9BQktAD5GqXxeCVVXO8PYkC2HfItAh117CDKNHzlPR2WDrtsuScPhyHkkDW4X3yEIsseyTh8fUUjryc48wDr/7NCT07gNBgGbxy9UjbbPudkXADP0218LPQ8DgyShPi3m//RdKIzI8Ecs7VCQV6jHoK4+tWmw3sbOCaawXpizbXkQ==
Received: from SJ0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:a03:39e::32)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 12:37:14 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8b) by SJ0PR03CA0297.outlook.office365.com
 (2603:10b6:a03:39e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 12:37:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 05:36:59 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 05:36:56 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v5 1/3] selftests: Migrate nsim-only MACsec tests to Python
Date: Mon, 23 Mar 2026 14:36:31 +0200
Message-ID: <20260323123633.756163-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323123633.756163-1-cratiu@nvidia.com>
References: <20260323123633.756163-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2629916b-cdb3-44e3-58d2-08de88d8e8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	viplKV4Ytwh4Ps9yaNXQqD/23EZwlcdx28OjUn4UjjSrP2550UShGDS5y1LWNA6buy52EF1ZT2etkGX1asNiNkTKJ4991xBoCHKuBdmM/be1+iHM+Et8g2uahy1Qnw0Hnp254jIFOusikV1ruwCl9rb96F8xB3derV86qCKwvbou4qZN5VG0FYLIrys0kg0oLiPhssmF9x2tux0WkeVm/nNm9BZN8vKTzziHv3luh/BUFoZnIuA9Op1lsCN2Gq6WAolZRPcwGincXj1zla+46fzfeXInbJYg8981YR7ijXlBbLXP/Jgu1vQWUz1GJsD5+ARC1Cw+9/h/nBXUPxHJkPiYnHI+FzUNasj06NQjaimd4RN7sIOUlWoFIwt3nXYjczKDXne2j6788GS+w6XGLgaOii5b99V5/GY0xUl7p0GQbtxCTay+20HzJ16wHllgSGpb5b/dvqqn1jDL4/uO7GysT2uIoqTzrkwJSi7ZGK6NSnuiEb8/mBzZRjbt/soPct2vZRF4GbC75IMJeP1v2TrhpsMgaW3eCehf1pXgpmwNZ0rvtdyiAbq72QU5Ypu6ckzjYParascuqpht8WXzTaKxxdrQCycl6q1N19xOImfKYUHmxxOUy6vzTISeE2ewRkzjki/YAaYH+KAa2bGT5jqIjkbsKgQO+b+9go4fPa9T5lbsnh/2MOtHuk9kXwWbYR1Az37Pcp0r9hMoJUVFAuc9n2+Bf+rCVrQmcEdVHgnjHlh8JhRWf4KAatkEe3aQbTstDiS7IaiaZdXhHDU6ew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HrG0Qf4q17pEdQ9qZ3d2NvkS5rjjU4rP01EVA8aipoFS6es9Jak4+6oqBEvRriOiQqaTZS4g657Y4a36e2xqsJwHDljsgMReerxSN7DVsAgr7P46hcUkdkPc61FRb/gQJkUbxBEUvzXYLtgbJA//cjZT9oXjF6rzt/QfM/zXFZLCMd97WBVmDqGT69Z6ChfSs/Ehic0BYfgsVxYhJXc+ETg0tyoQC+mNSYx1V1LGwa06WfM0+aOnYfel/pljCaLXmGo/jNx3Ra7uWsSABdBiqmj9GLp3Q6OzRWuq6fvf5mgsDSExdQeXdp5hYCLA1vWvKbfra6cJ7nNtitRuo8e+q4MkX18s04/TfKwTL7V5Ypgqw4v0c8r5yDTDlKnAo6/8r3fl12hJ/cuSZu3bTOqW7+Ayg4MkLm3atbCZY7K/EuLqHssuD/RJK4xWVQ83aa+R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:37:13.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2629916b-cdb3-44e3-58d2-08de88d8e8eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270515-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool-common.sh:url,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url,macsec-offload.sh:url];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 59C7A2F21DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move MACsec offload API and ethtool feature tests from
tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh to
tools/testing/selftests/drivers/net/macsec.py using the NetDrvEnv
framework so tests can run against both netdevsim (default) and real
hardware (NETIF=ethX). As some real hardware requires macsec to use
encryption, add that to the tests.

Netdevsim-specific limit checks (max SecY, max RX SC) were moved into
separate test cases to avoid failures on real hardware.

Finally, MACSEC was added as a config option to drivers/net/config.

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


