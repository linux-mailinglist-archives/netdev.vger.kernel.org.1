Return-Path: <netdev+bounces-267405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG4xNafss2mDdQAAu9opvQ
	(envelope-from <netdev+bounces-267405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:53:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA64281C6C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 077373044648
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99838D6AC;
	Fri, 13 Mar 2026 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ko4V2FW5"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8ED388388
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399196; cv=fail; b=kYhU1Cmi4hhWcJBGsqwaWNXIGHo3hVs/v0UvrBxV2PajueLEghqLSaMhQB8MTAeL8m8VbTwSOHiig/XLk5KjtaEEIrFlvca3fcMJm1Ipx3l3S6zbgXm3PDQplMDodn6QXiVv7zO/TZdMnhC+GWZueyMKhPAFiV9aL0CmP1t+Y/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399196; c=relaxed/simple;
	bh=VqL+LaVeKbT7My5MY0+qIB8uPCV2NTUcoZn6KUnz/EQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcCJx2iUruA2r43hXeSqJfsODyfNk19rXUS2ZedBkmtb9RV3iUrK/u3KMhpFS+MhUoSstiCV6kSejySby7SEZb0b8mcICqM4ldU1WRX73e8+7cBdnk00VdhsTM9S2gBzqHQo7w2mbWklDa6XvUgRcF43q6GDXvemAuXXQbOBjz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ko4V2FW5; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEu1E39sqE2dYrOPSQw780o4BgSHxsKAXSjaMzsXjoOs55hz0PXybj/fqqoH22/7ekH1RSTS6vSSDvJUL0VWrnzjTMfM3ECF3a3I2Y5YXBor6dIfA6Q1HaJ0+MLCT2v/9+Yxq3B+5SxO3fMwXWss2gu9l2VrOVPDGbMW7XszoiH9pQ19rMVrymd7ERwvqU3wvYUNa4wUWvU851fIvUQqwXd+zHai3NIJ9aD5x7emGBaQ0weiWwvtVvUis5bMc967mwgS3aYxQmfJkNTCzmVLPBx4u74nPglJ0CqMivQpIb4Eb972tW39xDzLT0sOGVvPosLqFSECogORyZ4c5BcTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo4L/QRE//kp0hjdMl4b95IHcfVCCv2L6uCu/IO2Wj0=;
 b=cZxV6fVuAQ7cFK+biEZTG5MKRX5qLoS4LQFkAy732bTm+wqtKZJC8cr9fpEsodOAN62hvrWOFZ+AR9qMRqS9V4z1swTvJyxOeUGwKbViT9WHnxbwH1gYqQ5gYI7p3JUpwOEny77Xzgms4xII2fHRv7YaXRi1K1SZrJKUEKc+1iFTlM0zl0WmTv79X37d5zApCJmX1lq4PSyEc19ytdHVziAS/+/aq+xbawVDHSI4SO+ogElSstbAYe6dSRWr/dpk06Ijh6xgXyLJVbfKiUidftHXAtdATAtpvSSn+ah487kBd3KK8oazIu7NnBWD3dnZzh0Gv0bxEew3LKPg6JgE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo4L/QRE//kp0hjdMl4b95IHcfVCCv2L6uCu/IO2Wj0=;
 b=Ko4V2FW5KKlf3N6hwab7j8sd5teW2R7lNoQdDa1VJXDfXnNRJiqNW3BMYCbL1Sznmt0Yq5Z5fzq3oXEpMSLSiYjsKLe3yVrQyCXItZa2vW5VgCuuyCAq+Ixr9KB+UWgoTkUi3LJUFgLqgyxGGXMvH6rR15Ig6iz++3GuRWwR0P2KdHKHcKBLvZPEiqzNaJnuMDX6IwKr1ad2T/0sgOk8NStxT71QxRAuG527y5Hqq20FcXFvTs5OIItb/gRAMwW8gk9BaOU/ht/Q9kJgzDgHsFHSot/WG1OBuCbaXaWUT5hjq/tQlFnkc4VyQI++hnVPI8iaQy4Iq0tXe7hJyLHwSA==
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 10:53:11 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ab) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.15 via Frontend Transport; Fri,
 13 Mar 2026 10:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 10:53:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 03:52:58 -0700
Received: from pylon.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Mar 2026 03:52:53 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 2/3] selftests: Add MACsec VLAN propagation traffic test
Date: Fri, 13 Mar 2026 11:52:25 +0100
Message-ID: <20260313105227.1884391-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: bf55a1b9-9314-4282-9dd2-08de80eeb7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z8uMFET+zv6u7tu3dyK/LyCkL1I+EbzjN+XGXdulbhkbYiC48kWatxECjX25MuSXKlz52MgHd+YoB5i5G2OX4eZVGA3uXRLQqaWeu0b+nKX1w/YXco9gIbAEXZ9bD9G1B24za+kYpS9tTifeScNhjko5g+ZJB7RfKJD9FgwtFVXl5VKqMxYz8Ifh+lkX4f0FuwG/jd+UHF5c8Z2pCdSO1osDqjg/zVMNzyrLrUGxZcM0BjxqVxNBOcpPVfmTB2AGsyjoZ9YTQWjZOS+EJZWjvcHB9daPs7TnGRH8UBq/EDxRH/V8IhAhxuV5yyzo2F39iiEajYEYZr62TpeyCqD8Mkf/wYQ/4vP/jfVnT4wMWc3tDo0aa/hQOg/jR9pOC4Dxy48VsaxDPzBh0K830pLTnMmWM6TwtzzlV3hcVKZmbyEORTD/7aBK+NlQ8zd51ijNcuvo20opyUR6WE3Y1dWNVxb21beE9SulGL5M7Lnl08RBSpoTqQ0KIKJNHMDLhwQeqg29jDJrPC/NKHKH1T173ELmuoiP5Z2XTbp6c2YaYt0SdVDPNd+xd4vCIxdhfMgD8iCAiHF9JMz8IoxCz2EvmVWp6XO6qfq38AAOMieVjz9eVSk5jGQq+8dBRcbVw9h4CW65X7rqTvi0N5EtdyGFmPFghGLbxIGJ05Zln9Iz0ZPEDP8mVJWv9esz+pqd2Yf+FBPdtAcDdh2LLx2/b7EqTZcXluwNFJKHdzI4CXp+V7QUlCFXEtKqiwZAxnyk4RLVzOzCTlBh6x0OYqjVfTTZfA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/cTsArd/sbFsLsb3HqQGsU+uC+snT6WklWpzkDyQ/4iYyLLyWjv8cj6g/8J5lTnHrjyytujiNs0UETEOndYBTkWREpfqiMu5OBuB2CyVaCaIlXthn8zQtuOMxPgqv0JY7SMIdGdWiGtLMCuEpRY4dOFdwTHqYS0n7q6abNR7vDOfX3PfCQzYMdg8abLQxb9Hs4nqZmLQKFem9ujmNMTGm3LN8xIs2BQm2BbYJmfbHMv0I7rizy8h0+daDY4OppAc5q/MLWjMebWaF5fdSt5lSU9pP0r8k4M3i3Znr7wXw0I+j1s1lbzM132UXS6WAY59nzrH92E3V3WE6Wm9yO3ync8Bu2jx94iK02D6a0ZBjl1BPVd0dZKhgF4ly0eF2+Eu0lDPZJV8/kt62NEUbL5qAj2gY+GCgRAoOxY8e11eLDyKn9/uqmLDRmyFHz80zw2a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:53:10.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf55a1b9-9314-4282-9dd2-08de80eeb7aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267405-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,macsec_traffic.py:url,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,lib.py:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 4FA64281C6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add macsec_traffic.py using NetDrvEpEnv to verify VLAN filter
propagation through offloaded macsec devices via actual traffic.

Test creates macsec tunnels with matching SAs on both endpoints,
stacks VLANs on top, and verifies connectivity with ping. Covers:
- Offloaded macsec with VLAN (filters propagate to HW)
- Software macsec with VLAN (no HW filter propagation)
- Toggle offload on/off and verify traffic still works

On netdevsim this is a smoke test (stub offload, no real encryption).
On real hardware this validates actual VLAN filter propagation.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/macsec_traffic.py   | 126 ++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/macsec_traffic.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 511346b7d9ec..102aba3b2518 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS := \
 	gro.py \
 	hds.py \
 	macsec_api.py \
+	macsec_traffic.py \
 	napi_id.py \
 	napi_threaded.py \
 	netpoll_basic.py \
diff --git a/tools/testing/selftests/drivers/net/macsec_traffic.py b/tools/testing/selftests/drivers/net/macsec_traffic.py
new file mode 100755
index 000000000000..c446c264a749
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/macsec_traffic.py
@@ -0,0 +1,126 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""MACsec VLAN propagation traffic tests."""
+
+from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_variants, KsftNamedVariant
+from lib.py import CmdExitFailure
+from lib.py import NetDrvEpEnv
+from lib.py import cmd, ip, defer
+from macsec_lib import require_macsec_offload
+
+MACSEC_KEY = "12345678901234567890123456789012"
+MACSEC_NAME = "macsec_t"
+MACSEC_VLAN_VID = 10
+
+
+def _get_mac(ifname, host=None):
+    """Gets MAC address of an interface."""
+    dev = ip(f"-d link show dev {ifname}", json=True, host=host)
+    return dev[0]["address"]
+
+
+def _setup_macsec_sa(cfg, name):
+    """Adds matching TX/RX SAs on both ends."""
+    local_mac = _get_mac(name)
+    remote_mac = _get_mac(name, host=cfg.remote)
+
+    ip(f"macsec add {name} tx sa 0 pn 1 on key 01 {MACSEC_KEY}")
+    ip(f"macsec add {name} rx port 1 address {remote_mac}")
+    ip(f"macsec add {name} rx port 1 address {remote_mac} "
+       f"sa 0 pn 1 on key 02 {MACSEC_KEY}")
+
+    ip(f"macsec add {name} tx sa 0 pn 1 on key 02 {MACSEC_KEY}",
+       host=cfg.remote)
+    ip(f"macsec add {name} rx port 1 address {local_mac}", host=cfg.remote)
+    ip(f"macsec add {name} rx port 1 address {local_mac} "
+       f"sa 0 pn 1 on key 01 {MACSEC_KEY}", host=cfg.remote)
+
+
+def _setup_macsec_devs(cfg, name, offload):
+    """Creates macsec devices on both ends."""
+    offload_arg = "mac" if offload else "off"
+    macsec_args = f"type macsec encrypt on offload {offload_arg}"
+
+    ip(f"link add link {cfg.ifname} {name} {macsec_args}")
+    defer(ip, f"link del {name}")
+    ip(f"link add link {cfg.remote_ifname} {name} {macsec_args}",
+       host=cfg.remote)
+    defer(ip, f"link del {name}", host=cfg.remote)
+
+
+def _set_offload(cfg, name, offload):
+    """Sets offload on both macsec devices."""
+    offload_arg = "mac" if offload else "off"
+
+    ip(f"link set {name} type macsec encrypt on offload {offload_arg}")
+    ip(f"link set {name} type macsec encrypt on offload {offload_arg}",
+       host=cfg.remote)
+
+
+def _setup_vlans(cfg, name, vid):
+    """Adds VLANs on top of existing macsec devs."""
+    vlan_name = f"{name}.{vid}"
+
+    ip(f"link add link {name} {vlan_name} type vlan id {vid}")
+    defer(ip, f"link del {vlan_name}")
+    ip(f"link add link {name} {vlan_name} type vlan id {vid}", host=cfg.remote)
+    defer(ip, f"link del {vlan_name}", host=cfg.remote)
+
+
+def _setup_vlan_ips(cfg, name, vid):
+    """Adds VLAN IPs."""
+    local_ip = f"10.0.{vid}.1"
+    remote_ip = f"10.0.{vid}.2"
+    vlan_name = f"{name}.{vid}"
+
+    ip(f"addr add {local_ip}/24 dev {vlan_name}")
+    ip(f"addr add {remote_ip}/24 dev {vlan_name}", host=cfg.remote)
+    ip(f"link set {name} up")
+    ip(f"link set {name} up", host=cfg.remote)
+    ip(f"link set {vlan_name} up")
+    ip(f"link set {vlan_name} up", host=cfg.remote)
+
+    return remote_ip
+
+
+@ksft_variants([
+    KsftNamedVariant("offloaded", True),
+    KsftNamedVariant("software", False),
+])
+def test_vlan(cfg, offload) -> None:
+    """Ping through VLAN-over-macsec."""
+
+    require_macsec_offload(cfg)
+    _setup_macsec_devs(cfg, MACSEC_NAME, offload=offload)
+    _setup_macsec_sa(cfg, MACSEC_NAME)
+    _setup_vlans(cfg, MACSEC_NAME, MACSEC_VLAN_VID)
+    remote_ip = _setup_vlan_ips(cfg, MACSEC_NAME, MACSEC_VLAN_VID)
+    cmd(f"ping -c 1 -W 5 {remote_ip}")
+
+
+@ksft_variants([
+    KsftNamedVariant("toggle_on", True),
+    KsftNamedVariant("toggle_off", False),
+])
+def test_vlan_toggle(cfg, offload) -> None:
+    """Toggle offload: VLAN filters propagate/remove correctly."""
+
+    require_macsec_offload(cfg)
+    _setup_macsec_devs(cfg, MACSEC_NAME, offload=offload)
+    _setup_vlans(cfg, MACSEC_NAME, MACSEC_VLAN_VID)
+    _set_offload(cfg, MACSEC_NAME, offload=not offload)
+    remote_ip = _setup_vlan_ips(cfg, MACSEC_NAME, MACSEC_VLAN_VID)
+    _setup_macsec_sa(cfg, MACSEC_NAME)
+    cmd(f"ping -c 1 -W 5 {remote_ip}")
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_vlan,
+                  test_vlan_toggle], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


