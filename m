Return-Path: <netdev+bounces-274478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGTFJDZPzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:12:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32380388277
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1051E301CC89
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7D53B894B;
	Thu,  2 Apr 2026 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="exdbr9Bo"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A5396B7B;
	Thu,  2 Apr 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128350; cv=fail; b=SGkamYy1juYH5ypUmk73gF+Q6Qjkn5a5RsttnpIdNmzNNgXCS1zWVM/jyHNjl5l4lMgXBycjb8w1Z4YP+td8+7IJfKEPKqgJD6FcpZi66O6zg7OJdKs4jaNBMZRj8hL2anc6UvmcD5aFeoIjWhyKffO2r7zysRb0DkWxFsTiTc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128350; c=relaxed/simple;
	bh=SLL30Waz7qeM7cGUIt3nHJkQlVvt1P3SCkydDxU3OrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlCJhz87I497BFXiOHhhDjSpCqi/V3D8G2Pn9giyiC107C5lTq6PhsYa2JgUImsfeeaiBgQa2dUaIAyn1UY7TVZxE9PkEfZo0+ALKzytviJwgLgRgVCIOoplMln5YBk5kRgfAveWNy4cqG+Fpt3n+wxQzGCysqlgp8ObMxawtcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=exdbr9Bo; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK9KQFLLhGw8RCFOIRkvioOJo3G0DSxyBf3Z+jZMewpgIP4tQGkrI+qHRaMkz8D/WBQYLTL95v67Z0i4aoXUGUNwGCm1rtv1f3Nklfxom/IavKmSVcaCBP3rD1P+MHRfA1zWzw24GNomtFr9HmmrA4m87ntSsNXU7/jVrV6SmXFd30e0y0/EsGoNnTCzGxxR3jUAsApsDe72PTJepQ3hwORsd92ON4Vl8loAtY/hiLeSQ0YnoWS4/AoWBuH6xBAZYpLYGf2LbuOC4pobCpCBIf0NgWUjAV0gdXtZfo2/9oZBmSsOBrsEXT8A17ASDgMqphmB4xK+i0bcPivczjSHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2YmH3n+QpalNTMETDbGno8U7lu2xp/n3CyH8QpPp00=;
 b=NztbsCBMn/PGPMYqwB3RYN+2mAelDjuerq9jbSvKSY2CnOI5ftgYJ8/HHLjaLocbxD5y03kzO3S1vSLnH9QTfSEOnCnY9OivbzX96lwiT1o57P3xeNs4MqglnH88aJtAfPS/x78BBgGiH4snI2ayBJkoL/1TZHlQEss76sixcPzJkT6wiotqN2wz+vAjj6gZD7hED0BpqjQhYdZA1U91iDBddmSh8yRQ50F+RDU9DM5o7yebWjpaI9lDQjL9+CFze7av6fBbhVgVIbjnWnPSIK0wMtXEUX6ZxJvQyw9KnB+81nwXMOhrQoPBzjtHqzg0tDU699SB0XS7HT+vRvW2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2YmH3n+QpalNTMETDbGno8U7lu2xp/n3CyH8QpPp00=;
 b=exdbr9Bo7Uu3HjvCYAQ5c7Zfs8w21XIKx1V6Rz37qT6HO1kcHGJEHgYL9GSoXLEEiIl5yBLYvnpZpWftJinb2fGZcvE4hZjD4JXv9ngKO/TSkPNeCChE1bGr8dRlOC7Ata4UIOcbm19M0M6is/MWNrswlHwjtxVMv1UtAdCEkIDIzC7TcChD81jU2ItRtU/m7iWgjjh79szJJ/63rPZpvLsI6knJd1K/qzatByVBi4mET72KPfiCDywkFYYOVbYv4ES3yUN7KzD7VY/sZq/l5zhrM6EvyBnal5eyieJGxS4wQ/dyNAhhjYfy5fjoOd28IWeUjV157CfNCFJ7HZPGAA==
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 11:11:27 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::b2) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 11:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:11:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 04:11:08 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Apr 2026 04:11:04 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v7 3/4] selftests: Add MACsec VLAN propagation traffic test
Date: Thu, 2 Apr 2026 14:10:33 +0300
Message-ID: <20260402111034.1494714-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: ab85baa3-10b4-4a8e-b2f3-08de90a895b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mNmo+63zUV+b+TjkIVW89vMQeSlwh+5Q91FU6N6vu2wGDH7ZPf5sK3tf1cH6L8AR06C39QycRqcjRgkleiuDLEfkDt6A2EyZijszg8qioD6frbB8svGUgDmzi6fw6eqoEVprMS0UmojldpO4mX5Jm4rdaFkv5xbdTMXnDckiOOfaGaUlptj19O4kSTb8qSRsbgi5jcX3WXcaXlqNP6B/+RoRmBa3jcVMnHesVlekxFZw7DwBYHxjoKBZ8N8aluDoL0W4BJkTnmYev5oYBSR0h1HlAADLT5etAtgLr6mQrO74t5G7/DSXrwxuaxPb+Q5YMv6RUQWtpDKNUBrNDrAmFFSKBTER79M8pfPp/kLNfVpvkzNyETJAQlTI4LdR2Kn9xh77oMB+jBvyPCuTUtFR28FvuSnuEX7IuvmnpMommUID45z7Zq6fXOgYrPrLC2UjJoLHMrM+bJiU7iXN6XLfexVVQEdAL+UvSa/w8wnMMnUAheeVhWUYufE6yBk3nIbtnzZ9V6ml0iIL+GY/9fDDLXXlw8Zffa2S3PIF8hiqe8O4go8ZKpgez6JdEKxxiWlYswd276wOu067WTlexMJS8pTp9FYy3c/8I2PdU3KLZMrcZUmA/BkHIxzdZFPlq4y2USZ4HVJizTc72U77flg3zpqIYiSLVmxE2hmS0ofNdnQDR9bM+Mrye0+8YxzfCgZH439zuM7VvHTwbTtTLeF2yqJEb+RUhtgB5s6vnVhXA0unzfB6+YvliRP21cPFDI4+P8cApyWfiEfspxR3KtKb0w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WYybxtwKPpxm823+COD/FLCX38ONzDxgXmGMxk+g3mPohbO5zQYt64bn4sbPgUwCqnYNchBEVnTHLdua4ezFg9fIBPoR/j9V6SxRtKYjaTMl6GV5zFK1RDckcEzf0me8TbytYZRCtxgI0u9ULbUZYr8SP5UK+ScMnLLk+QH4apcIfbw6NQ3nIHfiRUThhmOASrlumP/TZEhJSadgm+xf6/KgDJbUJnQ/pSPisNxkVtX4ngvyn+0xPwLBcAt6IFjlLj3krN+iffKjmIADgL7/qOWa7PNwWK6I/MTGop3XUHcNdaYy/WOEfAfGq/tMIs4EMobYl59YeOiuy8+0uA7+8ZO5XnyJcMovaDW0UNPvAEfaFtZRh0S4y7CRsCmKQXmMPSAD9SR0ipwwi0MhWbQIhn16b2EnEfqHFqwJONYt2gTaHN15BX/tHFUHVfvIaSAG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:11:27.2290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab85baa3-10b4-4a8e-b2f3-08de90a895b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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
	TAGGED_FROM(0.00)[bounces-274478-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,lib.py:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 32380388277
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add macsec_traffic.py using NetDrvEpEnv to verify VLAN filter
propagation through offloaded MACsec devices via actual traffic.

The test creates MACsec tunnels with matching SAs on both endpoints,
stacks VLANs on top, and verifies connectivity with ping. Covers:
- Offloaded MACsec with VLAN (filters propagate to HW)
- Software MACsec with VLAN (no HW filter propagation)
- Toggle offload on/off and verify traffic still works

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
index 7bcfae7800fe..5da80cfc4346 100755
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
+    vlan_path = nsim.nsims[0].dfs_dir + "vlan"
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


