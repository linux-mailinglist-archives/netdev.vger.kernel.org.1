Return-Path: <netdev+bounces-276464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDU0MGhC1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:56:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFB3BB86A
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECFF430345D8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6B83BC66B;
	Wed,  8 Apr 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qw0XOENq"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860163C0603;
	Wed,  8 Apr 2026 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649262; cv=fail; b=WnvY2aHySwH6su9OX0gSC8uMJ9Ewxtc/D14zA4eAh5TJZBJ9Y+GegwNlv/xhlTH6jnt7lEwlCZxW5ixMOZC1pDlzvqPVAnKo1d5TIQdBTDNaDJOy/Rtm833iC4VqHBWeT1Uhg4Cp2kyjGoza1tnjCrU5TWFbv2yDdb8DmIfHE18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649262; c=relaxed/simple;
	bh=p3hob7M40UaqPyj9iC46UGApvK4kkIPOmDF/CGT4sHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsgYbjAa3LeA4/Yu1gIuJfWGqSw87Ju0v+YybUSmO2G+G5CqMcT+p+TAmWTJ3XH5EaezfkQQryTCeI27ve7zIhsmIPR2oy7jTprpUyiswsoKVl8px1QkStIpmbc9PYI5HlFti/CL3laFpMvs0qOsmKqMsQEM7Y97WXr2uDgPTkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qw0XOENq; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL028/8ZSDAO0/eIjV/O5jkQtk2VDwO+FrRNawTRk6oWkrROF31FuRV4WkCG/I8zZ4iddS6OXnkBYQ5UUqOOAzIkDa7qKuOvi7dC8XLZtEkXhZKTOBCgVM1AX28wwJRsIN1+0uGePPLoKZaMBHe2/Rdqi5v5C2MjsMJuT4N9Qz23Wgx6a0V0MtFtqwROwZg08Pw5Y82HsLr6vZthS2z7OH9icoxKquBWvFffwj1aV03CinfMRiQRX/DBmC4fP9TXvRF9FovwTCUO2BMKePyDnhRKZDlUxfhDR5tzt3L4sNM4GVlZcahkt4iG3UE7Kym6VIThiaPxkHicsGpvSfXGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVMC9rrSv1e4w4UDkovyE4mljPy0kWijq7YHc6ly+08=;
 b=W+dMLqsYjuVyKKJwdP9fz7w29nRWeFqsioQnMtMUcd+DLEc0683p3Y2au5+3CxmhRhWJjdKbw8VSRRN+29um41sH4FC9TDvwynV4SZDFfhneDtXcxELSEZAWC/Czat/zKrJZ0Pah0hL0CboW38lbhAgSuwcISxJyYeFi6X6Kd6v6omcpgXqKCFr8uYeqShyyYGzI3pAQEUmqFNk+CVyiu+5UNWHA0c1QqAjoCaX12Z+1EhksUluXspjxQz3mxz9uxJYl4qHlPsNQLHCsvVRVcCdBESqz3zEXw/USaZqDjiKP+Xq0b4Oe2nGWImQmouo60lSo7ONNHiH9QdWGQAnJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVMC9rrSv1e4w4UDkovyE4mljPy0kWijq7YHc6ly+08=;
 b=qw0XOENqWQOYARkW7E+PxAKbRMYzWpyIG0msypmx71jq7oISJhM11VM1P6gRdtpCxilfz+IWPXa1bR+0BDQqLXu+Lmb7Nef7GLsPfwauo/kLohKqbUU8JDf3jK1itADk1AbqhVqdbGuZRpmn0H+sqcBtaDBBJIEiwUuwHE1vpHvAt5mPSpubrpdJfz3XFT4iBwXeCoWYdhhjnN82Nh4P31sc0dMbOQI7oLckJfr18jWCGBltQUn+CcOzGilso0G/L7/QyIabRlluzQ3SZftc28HeypY3XrutlOWGLUX8fYjfmgA/jE1G+mmdhVw6+Simjj2F3nGftp6A0Rn2XcN24w==
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 11:54:15 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::d0) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 11:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 11:54:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 04:54:03 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 04:53:59 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v8 3/4] selftests: Add MACsec VLAN propagation traffic test
Date: Wed, 8 Apr 2026 14:52:39 +0300
Message-ID: <20260408115240.1636047-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: c670a6d3-885f-4c8e-87c8-08de95658e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KuQrCEy7W++WQdK7jvSDxDPFNNWdV1pgW4v4YXwHL9qv+ubXBkwuxnHHGr59uiTW+F6BbYIL3FOwn6ImaNOR6gGXCYLTF87IbRPNg3ucom9L19AajMAb9QSxqN0XoQpxkqFNUnHNnltqazg+q1kiLDyw252M6shXcyVJIC2zscwbKGtsbbzEtyUR5ZvI2QMu86eLK+GjPhmJYwBDRx03YL1bWdvn6GT/kGtyOj9mOO1ateS4q4D+BvbTV/uWwnQAEMaU46IGZB70Xx0/7G9FHd+tEIFfWAOn3d6BnOUAOn4elo+6xmRhCDw/sFW3ZD0L/t2nQRyFGhz7OqhFs8tpPIMEcJQ8dAILC2lxBlSJAQUCbmsU8i9h7fosGETWhWtX97UGqFpehaXwkHpFAvupJFIGi1OunNyP4ZYBcYnefm3uPkR5adotz6euI/6fJFnsHFXAD6LPzgboPPPCEON5Psh0vUMd2kxT+if98yRova8gvbWPeimI7PVwuUAdCXZ5+OKs5AIFYGU4+g7Yzcbe5Y0oUPVgpuSxjdnoJyP15UOiArHWWtzVK3C8Uq23wd0QRwrkh2jgUt7Rjo9bVRraYDHJNxEw/M4vhzEK6r+71+oOEpbp1dS9kaYlX7RSp2gJPC0cImIZQnTwsKO+a84/WmXbYzQoh9N8hbm0idC+A8ngY3KOipQtK5U9MB2uPL/JEpHPr6ET9PjEmx6H6TANZd46LT3NW03LOn1TRycgwdq9yNiKFZ+4K1s6idBz4M/T3pu3/LpvQAk74cCgX5veIw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CxYwbLYbhpmjq8PiOLOTBatXRLeg177CxKE1ORTRwraZVWY7xBN4U1Pb4CqmUNrHdpx5YG77oKNct4tlYY6ZH9CxzV34lPvXdg8CcOQboT5If68SMu6KY0b8ooiP0e7zyMlLKuUVdgwnohXUUVFVVpF8sRIT+FQ9b34HIfXop5dyqAOC5vMGahb7XsKjIMalGfm/0tiTnsjrnepo712HnV/PEBLkspy3lHCLPjE8jW717EUzlYUo1s8/zim+CPwqZEaL+dOhTobZAggV/VeGUG3N3p10GdXsjvcFBA3d8ZR7BqOefwNvCSrJXCcqF6V7fQkNF3MybA6PlU0ZwT8e2D4uMtdHXs+ZO/dm8ttbZs2dBq9HZBUqu5cnvdOIfyVWxjGEI/pr30zmkoCBT97gCSfBko5WBqkMM0oCHaTX7zSh2KFxguyezFsh/xPFfdjC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:54:14.9227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c670a6d3-885f-4c8e-87c8-08de95658e97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276464-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 80FFB3BB86A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add VLAN filter propagation tests through offloaded MACsec devices via
actual traffic.

The tests create MACsec tunnels with matching SAs on both endpoints,
stack VLANs on top, and verify connectivity with ping. Covered:
- Offloaded MACsec with VLAN (filters propagate to HW)
- Software MACsec with VLAN (no HW filter propagation)
- Offload on/off toggle and verifying traffic still works

On netdevsim this makes use of the VLAN filter debugfs file to actually
validate that filters are applied/removed correctly.
On real hardware the traffic should validate actual VLAN filter
propagation.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/config    |   1 +
 .../selftests/drivers/net/lib/py/env.py       |   9 ++
 tools/testing/selftests/drivers/net/macsec.py | 141 ++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index d4b31a317c09..fd16994366f4 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -8,4 +8,5 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
+CONFIG_VLAN_8021Q=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 41cc248ac848..b80666277e36 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -255,6 +255,15 @@ class NetDrvEpEnv(NetDrvEnvBase):
         if nsim_test is False and self._ns is not None:
             raise KsftXfailEx("Test does not work on netdevsim")
 
+    def get_local_nsim_dev(self):
+        """Returns the local netdevsim device or None.
+           Using this method is discouraged, as it makes tests nsim-specific.
+           Standard interfaces available on all HW should ideally be used.
+           This method is intended for the few cases where nsim-specific
+           assertions need to be verified which cannot be verified otherwise.
+        """
+        return self._ns
+
     def _require_cmd(self, comm, key, host=None):
         cached = self._required_cmd.get(comm, {})
         if cached.get(key) is None:
diff --git a/tools/testing/selftests/drivers/net/macsec.py b/tools/testing/selftests/drivers/net/macsec.py
index 5220c0656c0c..9a83d9542e04 100755
--- a/tools/testing/selftests/drivers/net/macsec.py
+++ b/tools/testing/selftests/drivers/net/macsec.py
@@ -6,10 +6,14 @@
 import os
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises
+from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import CmdExitFailure, KsftSkipEx
 from lib.py import NetDrvEpEnv
 from lib.py import cmd, ip, defer, ethtool
 
+MACSEC_KEY = "12345678901234567890123456789012"
+MACSEC_VLAN_VID = 10
+
 # Unique prefix per run to avoid collisions in the shared netns.
 # Keep it short: IFNAMSIZ is 16 (incl. NUL), and VLAN names append ".<vid>".
 MACSEC_PFX = f"ms{os.getpid()}_"
@@ -59,6 +63,78 @@ def _require_macsec_offload(cfg):
         raise KsftSkipEx("macsec-hw-offload not supported")
 
 
+def _get_mac(ifname, host=None):
+    """Gets MAC address of an interface."""
+    dev = ip(f"link show dev {ifname}", json=True, host=host)
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
+    """Creates macsec devices on both ends.
+
+    Only the local device gets HW offload; the remote always uses software
+    MACsec since it may not support offload at all.
+    """
+    offload_arg = "mac" if offload else "off"
+
+    ip(f"link add link {cfg.ifname} {name} "
+       f"type macsec encrypt on offload {offload_arg}")
+    defer(ip, f"link del {name}")
+    ip(f"link add link {cfg.remote_ifname} {name} "
+       f"type macsec encrypt on", host=cfg.remote)
+    defer(ip, f"link del {name}", host=cfg.remote)
+
+
+def _set_offload(name, offload):
+    """Sets offload on the local macsec device only."""
+    offload_arg = "mac" if offload else "off"
+
+    ip(f"link set {name} type macsec encrypt on offload {offload_arg}")
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
+    """Adds VLANs and IPs and brings up the macsec + VLAN devices."""
+    local_ip = "198.51.100.1"
+    remote_ip = "198.51.100.2"
+    vlan_name = f"{name}.{vid}"
+
+    ip(f"addr add {local_ip}/24 dev {vlan_name}")
+    ip(f"addr add {remote_ip}/24 dev {vlan_name}", host=cfg.remote)
+    ip(f"link set {name} up")
+    ip(f"link set {name} up", host=cfg.remote)
+    ip(f"link set {vlan_name} up")
+    ip(f"link set {vlan_name} up", host=cfg.remote)
+
+    return vlan_name, remote_ip
+
+
 def test_offload_api(cfg) -> None:
     """MACsec offload API: create SecY, add SA/rx, toggle offload."""
 
@@ -187,6 +263,69 @@ def test_offload_state(cfg) -> None:
             "features should match first offload-on snapshot")
 
 
+def _check_nsim_vid(cfg, vid, expected) -> None:
+    """Checks if a VLAN is present. Only works on netdevsim."""
+
+    nsim = cfg.get_local_nsim_dev()
+    if not nsim:
+        return
+
+    vlan_path = os.path.join(nsim.nsims[0].dfs_dir, "vlan")
+    with open(vlan_path, encoding="utf-8") as f:
+        vids = f.read()
+    found = f"ctag {vid}\n" in vids
+    ksft_eq(found, expected,
+            f"VLAN {vid} {'expected' if expected else 'not expected'}"
+            f" in debugfs")
+
+
+@ksft_variants([
+    KsftNamedVariant("offloaded", True),
+    KsftNamedVariant("software", False),
+])
+def test_vlan(cfg, offload) -> None:
+    """Ping through VLAN-over-macsec."""
+
+    _require_ip_macsec(cfg)
+    if offload:
+        _require_macsec_offload(cfg)
+    else:
+        _require_ip_macsec_offload()
+    name = _macsec_name()
+    _setup_macsec_devs(cfg, name, offload=offload)
+    _setup_macsec_sa(cfg, name)
+    _setup_vlans(cfg, name, MACSEC_VLAN_VID)
+    vlan_name, remote_ip = _setup_vlan_ips(cfg, name, MACSEC_VLAN_VID)
+    _check_nsim_vid(cfg, MACSEC_VLAN_VID, offload)
+    # nsim doesn't handle the data path for offloaded macsec, so skip
+    # the ping when offloaded on nsim.
+    if not offload or not cfg.get_local_nsim_dev():
+        cmd(f"ping -I {vlan_name} -c 1 -W 5 {remote_ip}")
+
+
+@ksft_variants([
+    KsftNamedVariant("on_to_off", True),
+    KsftNamedVariant("off_to_on", False),
+])
+def test_vlan_toggle(cfg, offload) -> None:
+    """Toggle offload: VLAN filters propagate/remove correctly."""
+
+    _require_ip_macsec(cfg)
+    _require_macsec_offload(cfg)
+    name = _macsec_name()
+    _setup_macsec_devs(cfg, name, offload=offload)
+    _setup_vlans(cfg, name, MACSEC_VLAN_VID)
+    _check_nsim_vid(cfg, MACSEC_VLAN_VID, offload)
+    _set_offload(name, offload=not offload)
+    _check_nsim_vid(cfg, MACSEC_VLAN_VID, not offload)
+    vlan_name, remote_ip = _setup_vlan_ips(cfg, name, MACSEC_VLAN_VID)
+    _setup_macsec_sa(cfg, name)
+    # nsim doesn't handle the data path for offloaded macsec, so skip
+    # the ping when the final state is offloaded on nsim.
+    if offload or not cfg.get_local_nsim_dev():
+        cmd(f"ping -I {vlan_name} -c 1 -W 5 {remote_ip}")
+
+
 def main() -> None:
     """Main program."""
     with NetDrvEpEnv(__file__) as cfg:
@@ -194,6 +333,8 @@ def main() -> None:
                   test_max_secy,
                   test_max_sc,
                   test_offload_state,
+                  test_vlan,
+                  test_vlan_toggle,
                   ], args=(cfg,))
     ksft_exit()
 
-- 
2.53.0


