Return-Path: <netdev+bounces-273170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPwoJU52ymnZ9AUAu9opvQ
	(envelope-from <netdev+bounces-273170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBE35BAD4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF23300E72B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9083CAE71;
	Mon, 30 Mar 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upzwHjbW"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58D3D3314;
	Mon, 30 Mar 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875753; cv=fail; b=q18EhJZf9OHQsVNduEOlbRpGRXeYDPnE/3p1ujRpBv3cjvqOq/sy4rXJ5iH13lFBEYSqcxeYsHTC3RKqc896ISl+wI151pWFi0PV0bza1edeacnyfOVDYbaD9Yie048QyZQZ1sPolQXpE56iWfpGm8VT3cMzwZGQiXn/7/bWvPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875753; c=relaxed/simple;
	bh=5lFUYj8Bm/zSERa88OBWdPKiS7UjhFAbdB5WbVjVi8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdYj5avPYp1wfGQ27BPrBi+CkdO7LSX7VKu/SF4aBF1Oog1jZUO33IYIX8bbFg1T0Qv8EB2dVXS5cCuk+psRx3fsuHDS/CD8EvZvnTxWxiWRX9I9vk4c21NIa1kgMxePblsYbmSH8D0iYwJrmrryfFU8t9QkD2iJtgVCsLgyI/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upzwHjbW; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoDu1O0/rTE5roNPKE7dwhZFXYuDDng4i2mfmFW894HmKSvprm13p5dInJQkLn5sRocPJ7gHFoWzoww3T7irWh3k7ifpul4pdN/JtVGRxw6Qx8tjOlqMSkCekuQG1Dfl7OEWExLI/tE/p+c5giGdughsJlvmSnm3kcwgiAAPoPloopHzxtBdjCKsRdH/AmJpadkzN6pymNuhKfi4BgBp1EJd6uJc0qX36DQFY5q8ZYa06AadhmET4hIsSRq0w+ZPleq5T9daVSAr2K3IbcMdnMl2nLfmKZ/V3yX2OVutJBfNBTVg1jBczytVjluAtflecoa6obzJAFWkSpDBoDrjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILPT6dLKjbI9zTDnizo3Y0jdZvk5GeGynFzKplXZP1M=;
 b=LhiKAZiHeq3qFp6b8a9PewEwUbOOvN0TPuVAaYO+8z5dQ+aokyvK1iOsq6DVrF2a5RoAkGv0kq+JQDTi7KAZEcMNtQGTsT5mKn82zTj4pWz4gM9cEPzI/XgUo8TKbUXX7+ykjBAP0TvPgoacwSLB6BkmdxOho6E5WDTWxvJqUehXAA0EiUPjm4abE/WCD+v4jT9561XoJ7ncyvcqL6mj1xjAIIvCIOSw/sOXTfoGC1lZktRq9hLDHRuSGOkxqVcL5sYeTCf2gtcZcpah5zHpt9+rt6PEYTc9yRo9EFxHRfq/0Hc5F9nxLT0qHB0ws36iKRrS4zT09h5hUFikCjyn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILPT6dLKjbI9zTDnizo3Y0jdZvk5GeGynFzKplXZP1M=;
 b=upzwHjbWWkKGAf/ue5QmQwF1IVDMRvtWXMdcnBJ5d3t804MB8cpU9y0rvQDec0iRiZQjPVOFSB/hcyXJQ1idZTl5pTYIX1I9hTCAtS+kb5tUFiccSYqg9YWKkKIGpGPjiuLqb1rq/qmsWTB0sxh1Q4k94MhWsZuDjje9NE5lT6LDMmst3LkHCif8PxFf8nZSPgooghj2sPAp4bSEtWVEGzs4FCJRbDv+tTseMzYQP17AbLAkFSupbukdQQMdRpmRlmqqUqTNcJtJHjgLbyoW2pM1EWVFcdTJShukLzgETA7M44Cap3gOOhjzmnc8BN8WWtyQa6n2n6Mxxb9Vno7D4Q==
Received: from BYAPR11CA0052.namprd11.prod.outlook.com (2603:10b6:a03:80::29)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 13:02:26 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::6c) by BYAPR11CA0052.outlook.office365.com
 (2603:10b6:a03:80::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 13:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 13:02:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 06:02:06 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 06:02:03 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v6 3/4] selftests: Add MACsec VLAN propagation traffic test
Date: Mon, 30 Mar 2026 16:01:29 +0300
Message-ID: <20260330130130.989236-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 371f233e-4248-425b-b768-08de8e5c979f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uZSEyU3h6dpgtkQ5mtIVFAfGL1XgV0KKkTh/X/sVBTp9TcEVudpA8ieGB7w60wG9mSfidBIk1xbWIS1TE2bL587FVvEsMJoUe+Iob/RLwO/+lhq+rnxsIigC8bfxqs9zNyDrZNQ6qn1G9vGNounj6Y++G552Ln3VyHuYH3p8OoA+HggVZ5CVJs6WhC1kS7nQ0M08C3o1aXflu+XzpnjymhGxTxRp557IUzcJ5pZwOuhG+qciUGngOtE5ZO/oeU4mCvNZ5Z7MCzBThLtv8NKx7YJMLH1MbG7DhQWf+1Y97hwFLnKTQLTv1fpU31XTC69mRZh9C0n84rgOUpVTvHX4FXO2fdCpmQZ/yKhxJdJHVFb2cbVXYQ0r0GkAah3mdp2kzV/T/UEXHJ8yBBFR8d0VXJNQNvk1/1v6snbHz55R2K+YlMtWkou4VnmvH7VDpvMfjGmk0JLKhPFzQepWLRyL0sAIhNTHuUQmCG9wkf1x8AQv4JifSe0VqsrytKGMUHpx5RwpqO2TBmAxyVuKZEsVzQRok0NPx3JURQufHfmljhFQIvNv5cTLkGJDyU8cYWOOy1T5Y9qxYpfqXskbq97YEP+0Mt/MMXlJZCuJI66xnMtGANrNN47bkzOJmen5YxjyKRnkEMiW5a1eXdjC9LRlgdctut6+OBuXfLyQYB8Vrrf09K72hLPvS9FkedOf0b8W2ph/x75bROOTgXFhqNcaKWeT2pCsJ8ooLXhJMRbrlYqmo/avJz4GliJV8HpavXhDRU4bKeDbJyEM6o8Uhs44eA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PLIOAoENA7LmsGnA9U4RhO1gXGETcGctam/ZwmcQ04nk31odzLoefy/NbU+FIxuHrzax6jlOcAo9tDnOEK97odClxdC0espsbUQ5jC6nS/0VbMlLf9AEAIIHBxpG2c46euDwaVerbE+MBGDYTLbQtlgSSM1Y0cn/3IxsdDBADf3rnL+kLEZGGPLiIeGyf/mw4fz1q8+wSPVaMld4ldGkyXuqvU3zDCdTfkxgM8G1a+RH9HI3l+JHcir9/BZbRxBZtr6Bx/Z3KSKoXM6bEf/eB7zQutJ8mbo0veHV8dc20nWvLysns4KBu3v5aL76iex5953BZikFjq7ZKstdP5z9oaoERPzqVHTWd1AhzJHgzcdTuOdX4q0DgzMB3LY1Nc3FF5fBUbKW991uUoFWco5c3Sw5fjirJeBSYBTxpyUf/RbGO5ty82x8OoXYHdkHJFNp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:02:26.4892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 371f233e-4248-425b-b768-08de8e5c979f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE
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
	TAGGED_FROM(0.00)[bounces-273170-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,Nvidia.com:dkim,macsec_traffic.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E6DBE35BAD4
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
 tools/testing/selftests/drivers/net/macsec.py | 151 ++++++++++++++++++
 3 files changed, 161 insertions(+)

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
index a17b9f7ef584..b634d55e38c2 100755
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
@@ -25,6 +29,16 @@ def _get_macsec_offload(dev):
     return info.get("linkinfo", {}).get("info_data", {}).get("offload")
 
 
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
 def _require_ip_macsec_offload():
     """SKIP if local iproute2 doesn't understand 'ip macsec offload'."""
     out = cmd("ip macsec help", fail=False)
@@ -44,6 +58,78 @@ def _require_macsec_offload(cfg):
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
 
@@ -164,6 +250,69 @@ def test_offload_state(cfg) -> None:
             "offload enabled after create: should be mac")
 
 
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
@@ -171,6 +320,8 @@ def main() -> None:
                   test_max_secy,
                   test_max_sc,
                   test_offload_state,
+                  test_vlan,
+                  test_vlan_toggle,
                   ], args=(cfg,))
     ksft_exit()
 
-- 
2.53.0


