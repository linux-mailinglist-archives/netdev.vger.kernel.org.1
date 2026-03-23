Return-Path: <netdev+bounces-270516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAOhFg00wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:37:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF42F202F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7A9930091E1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB113A381D;
	Mon, 23 Mar 2026 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHyBTnhd"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2F39C006;
	Mon, 23 Mar 2026 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269444; cv=fail; b=n0aBQ+TwZaDOA7XnhA4cvfVBA+jPyL3iaVJwlJHN6nuvRDIv2QculDB5xMW8s9KFurJeLGBjVWDykldNqsGM0Ys20Ai+PT4/wKN8QYD9v+EcwBvFxQo5n0sFbQ6TjdJH7+wWU8BVmSLqTUWPN+7wQIFlk4HeJYaFrl6CgfUVLhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269444; c=relaxed/simple;
	bh=RSdjbx5QmJyRDdmdGtv+TcJMo3eDKhfrzH+RGPd1Eo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZorrcQMDHHshCBbGFFySpD5DQFqREgjF6mEwx8isuiv3VmhHGgoeOQJwFT7psM11prIq4r3QuvzXBoZWk7Ki0eNoSPaw2feE2FQqtqRbHvTF3ZHBH851Tj7q0YY0aiov6pV2aWumDrUEzeagDYxr2XvW8GeF9cPaglwWphzbq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHyBTnhd; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxv+HeSgOLVQCA6waB4rVvDW8BpGztdccYBeIeKoXkoF+wt99BdiOF9djw2449fVxCOmXiycC+WblFvRB52tQWwcuo4yym7u3RhYZysOSYSrOJRwjm1ZpQirVBbyjS1eOJ0iF+N6tW0ThQ9/tRKuqwMLfVcM2S76lqhqetUpBCHz5zpYn5JP2y3mqijVtTcGfYcIn41kA8pQqFneRlP5bpUYPAAqGUIq5X1VJPYG92BoaAaKMXFzH1SG7m/DvABZeMG9+L0hR8BfaPFQGIh0N//WhPWzgmnX2rzE8/4J9MfDB00uALjLKulCzGQFVwcMTi+MZZUhnW6hbGO2PuGc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9arQowmpUowfaQgaeNYBbHugSNm4u/OtZaUPNl2ZEk=;
 b=s7PzhDqqBAFg5cbj3AJ0Tvb0tYE4XxDGHrF1KdljJ4X4aApJ8tFRtL31+y1UfoBMHnNtJiVGwXbcDLC6r7x2CEnTgwMvyH00Xvll0E6ogum+sHCkvtTcoRmCg6zrzMZ87BnrbML0AMUSB3wPcW5DOOis2IeCFp+yA58m/wBnqTaLVO8IcW6yzUufa/c/oxpsEvqOjp9SG1t3XQWDm7uQQBQCrohhSLpb/0CS9ffdUPIinXSJQ0wv8fs7C2QYZ39bieEO/Xa5ExtWJ6/VYPN07ynfSPB/cag5PHSjr8zWF3tTQKfcLWgiouRR7VViLC7Hz8ae9wqx0iEwo1zj7JlaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9arQowmpUowfaQgaeNYBbHugSNm4u/OtZaUPNl2ZEk=;
 b=mHyBTnhdFfqS4x6XxS0RpMYxe9WRBDY+up+CLL8iXbjpaE47MlEDsMlscq0uuOFE+bA/73xXaE/Nhj4OQV+XjgQb8vy+myP4tF0iWgHtTWWE9UI7M2ERTvSfMv7GcZzdD/SuJdKSfqteDfpov4i1pqxCssx5ntNkJ2hV8JP/L5BkyFj6HpgmysCvUjiZe5s9NeyBHlH8TpQR6IcH3p++wT7LGADDlglu/v334JDBM10k8hlVOhl3NtTCRELh+U/pD+rQtX/3vjp2vE3q0UT6qO8fIov36Q2fR6J1H3q1K/vttFSl+HQ5BWw3DecX4Fu33iEEcLEaBY8rs7k14opM5A==
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 12:37:15 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::da) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 12:37:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 05:37:02 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 05:36:59 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v5 2/3] selftests: Add MACsec VLAN propagation traffic test
Date: Mon, 23 Mar 2026 14:36:32 +0200
Message-ID: <20260323123633.756163-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b12214-3b0c-4391-63c1-08de88d8ea20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XA1I1VfOgY6D1W77XCTvzgPvC4zF1Tpcs3ZVtQnCWDb3uy3k26At/r64OcwyCE8DKHp7+VVqqETpmmqOfQ0cTeR40c5OPXrUOs/aBWZA3SDkI/KEbWGC2y+5YYwLBMO5gwoX7Kl4fFG/ZpTA8+XK42/cHlDWdWFZjaNBtprPU7nmlPDT3gTOvKixN/JFZTuaEMNstRBRAawOGU2Cm+vdbaH7KiRN2upIW5fpUooPRyOgrvIujmW+wuScOFH7uqYamO5Hh46a8n10uoqeyl6TAgJpWUsFNdqVu4VPl00FPen0QBfgAOZFuRX2CIabIDnNwB1EvLaP5yvug8kw1hz36F53jwzh+5uIsJU2YktC0jfWkr9xVweq5FAaSFP6+fvO10fiYlUrRCd2V4vfYhu/xHo7V2iw45WlouYbBeN5H9gdcBKwOLIrLv5jNHmtz573yoe5aA4m3fyx9d6+RzwX/KF1UHF7iIKT+IGtm49KvDrNUdm/4z3hHnvjqdBsiMHmPqe0U01BxsKBy1XG10yztu8hW5X9hM6Z881BDWl6kj/eAbytT+skqK29YibuOwLUZeP1o+E7+6XGtFLTo1T7qY9wyq79O1STu0OBtNwCLIxbk5wg/TMbupzrZlXg3K46A3QrHSN24AirZ5heDFTw+eYKitCEz9i7UlOF9Biczx5iW3mTizhTQ3eiXrOI/g+hAu+sbU+BGIxldqY0XcIhf5PclBz1IByk6C0fImNKqWD0lqLI54G+4Ogbsybr69cGfMuHURsAHJxw9ZZM7w+s0A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E8ZIb04ciEAam3rQpRDyP/rv6KkO1FV4qv/TAxrWBzgiuLeBWMZLLqYZLE+AF+mlUcQst5rnYiE4WGZzqx1tHv1AA57E1IOYRJ7GvglgXftPlHU4dmFLyfgFyvReto/1vPuP+sYI88/Oitf0w2u7m9sJirYqjhrIrlAaecxcmsDIuEILhP5Rj56OHZtQN2PfLhpk3R5+CBorMu3FvoUcR/4ELSpI6Besr83tUv41kDZs4EMbSAjTBC/qQphqCO1tV05Ep0QD8nOfsFH4P6aDPPQU8VdIRITkYpXUmLlyzlHwmI/b1OVfB4YNttO2pWul5+1SAd85WehkTeaY0YAw5ZHI/t6G+YRpFMrJ5NOUsJukcQo2CuCzYDeyVj4dzPV0S5b5+PvDWu8qlYuJ8Le+Kc+RSPS/LR3RDksrfgsvpdwD5KFPW+q1Ql43YQOe2cpC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:37:15.4154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b12214-3b0c-4391-63c1-08de88d8ea20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270516-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[macsec_traffic.py:url,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: 50BF42F202F
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
 tools/testing/selftests/drivers/net/macsec.py | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/macsec.py b/tools/testing/selftests/drivers/net/macsec.py
index a17b9f7ef584..68915caca7fd 100755
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
 
@@ -164,6 +250,44 @@ def test_offload_state(cfg) -> None:
             "offload enabled after create: should be mac")
 
 
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
+    cmd(f"ping -I {vlan_name} -c 1 -W 5 {remote_ip}")
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
+    _set_offload(name, offload=not offload)
+    vlan_name, remote_ip = _setup_vlan_ips(cfg, name, MACSEC_VLAN_VID)
+    _setup_macsec_sa(cfg, name)
+    cmd(f"ping -I {vlan_name} -c 1 -W 5 {remote_ip}")
+
+
 def main() -> None:
     """Main program."""
     with NetDrvEpEnv(__file__) as cfg:
@@ -171,6 +295,8 @@ def main() -> None:
                   test_max_secy,
                   test_max_sc,
                   test_offload_state,
+                  test_vlan,
+                  test_vlan_toggle,
                   ], args=(cfg,))
     ksft_exit()
 
-- 
2.53.0


