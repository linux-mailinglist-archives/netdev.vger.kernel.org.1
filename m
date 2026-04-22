Return-Path: <netdev+bounces-280436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL/fNYLW6GlJQwIAu9opvQ
	(envelope-from <netdev+bounces-280436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:09:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D013E44715A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD86C3058CE0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76F3ED5A9;
	Wed, 22 Apr 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z3I1CWSr"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7D03EAC71;
	Wed, 22 Apr 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866871; cv=fail; b=asyzhoO2H8+CEfdJVmpqaaDBpSJCjvgWmTJNU/TXIWGVcD2mhhjQ2yaup7AfYyASKw8hWqjhqq9ZWboEZlGC3yhmCGvE2AkvGdeDbrXgU1yYVrhpyQ/Cz9rVRNAs+TT/whkFrYrvsnZrTyhhXy9XK7COpg7V2IDOJN5DoFW/hsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866871; c=relaxed/simple;
	bh=0nSM6fvCriqroBRupWLRgGXFbBDrzmWUuyc/9zpty5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sjjv7V5SW7ZFgFESAhxA0QinNmt+O8JybrRnSMkgxZXJJbAZPBiiGypD/pGcdqZkEsAvZVRIdvsVWB5J7jksVg8i2GMOz6SglB5BPBNrmZUL+L/RY1XLCMTMJIL+/SFNW3sSp67xahEM7yvRIP/XqpSQV9/YoxqEsmC3X/60P5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z3I1CWSr; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaT7yefCrFQ64uocpExJMrZLp6ZY0iVXA1vPr0WJODt6GyM6r3aM5jmFFr6OjUFICaxf2vHXdtUolJyrw4JI309NmuNpuizMtOFbHpYhuzG1LeKpK+BM+wHbg/cK2wdcUmVt8EItALk7AMN/VOyqZLYU2eJQZHgIwqxt1mKzDo4emNbMacdB5jZe6bZ1CHohwSCUCzqczeERHxBHeayEpe9RH2peos1xtvpOyDNDg4wmtj5REKg/QvEbF3CALiPL5qLeOZGPjaAV35/lw198Tm1/vMp9ebvb5ProVM6IeHyykIrQdtzF3Ac1C/FO7UzG/HZsiJPBof5vmbBxKhSGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGT89Cyo9ouy/e4Yl62H6jMUjnJEaFQdvHre6LBkBvc=;
 b=edKd8t7yK3lveS/40f4wegroV1raGQIp/7uXKkAcOAuygHkTVMbLFPt45DZyQaPlh9uWqM/0OmnMawHAS4W50jinEYcBKdrfYWgeK3B2McoMR39WOIHQrerLQZIeyW6Jf1FjZFolDlex0LCWtuN4GBmTycoPLjioCD9AMTD7RETRQKEoxRFnjjXZgigLH9iIDCTQ5cCwsyvWqcNuaApqOrsqXzpVzCxQBuhPUOwj+1aUs+FKMdnDIiiAGOBngPFP+JD883FkpyWo+KU3S/VTgGCYAzjymWAS7Z7Oqr6Kq0ARbJ9VidbA12SzUA1MGS6b87LGvDfR3h/X5lgmFZuIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGT89Cyo9ouy/e4Yl62H6jMUjnJEaFQdvHre6LBkBvc=;
 b=Z3I1CWSr7Zo/aAaXvJTdwLgBSYpnPV2E6NjEn/1Nt7VDJ3VPpe7g6hM3aVdH7i6UXvHRjOteUkbrDSRCpZG6UyT+VXMEBo8DE5jqR8E9FsURTpNV3jPHn/npvK16YVSyVi9jPlToNOK8tDGtPFGI3eympxxd2vhXyAUi6SKYSiYy2SmmxU1Mij3kpZsFL+m8oF6VFD7FvW6+EAJRjdl3QsVqwTAiTE7tIQOfq6EahBUQik4gyIwUi9b1dTeqq25U9BVllofmoBAMc1NBpaw+bMQ9/xjwfRN0eq9xys/7OGVAZI6hg3+06D0sV4IClaldHDTeWgbXyLHC89AZKdkcZw==
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Wed, 22 Apr 2026 14:07:44 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::a4) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Wed,
 22 Apr 2026 14:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 14:07:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 07:07:19 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Apr 2026 07:07:15 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH ipsec 2/3] tools/selftests: Add a VXLAN+IPsec traffic test
Date: Wed, 22 Apr 2026 17:06:47 +0300
Message-ID: <20260422140648.3877129-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422140648.3877129-1-cratiu@nvidia.com>
References: <20260422140648.3877129-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: e46d3cfd-d16e-4a0f-1f2c-08dea07885c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BEpTpiKfAaTbpLteM+tfjofiNbZNfEqQeHvhWgf4Gq037ymAlLjjXQsD+082raCxJffbkAVCCv2hy7eAZXGzDc66n8tSB86IYut1lgvnUwxOYOWSwXIZxi1CvZk9svg8X8cIsjf119hmTG9tQCCao5kL/ChTRiASR+P9lf5noeW5BjMCrtJkG2RqfmgiR3XdPlSZ355HKt2oAP7HMwWCrk91eoaG5iFmo6Rr4t/6T78QtJXunAcoFq3REj8NrFHN5+qAYC1vI3lAZLFVxfY5ZnLl09O9VSgziPhc7eBZMAxsRad83LXAez/zoSIdHdtNZWDfHHmd0DbyFbKJSeu0q7H8Cy+A8tU5o5Js//T8jm2TGWiOeOSmmGoLo2iQRCe0mOe7gRVUP8u43CbCOgNB25bkxDhaBe61HFh9+JR0HRCL69lpqFKLc6Nh5bSMJT+qwtGYhkuPI+2t673Rl0BhVfpzEYCiIikK14J59dCUTsxE70xGc70Fi66gYeIV3edIKVl3FFrONc1qWk4DhVBBNMjyaxI6mEWUseNgm05f4wcnX/rqsukQ2QLgryCWgFQ3AZz2DjV24sVCVvkHaM9KxerxlNP3ux9pAJtvxMIJrYZNN/kIyqsY6nS/2JtndTFVmHByPh1AgSSRtPWcENhVJbjEp0SGn0T+V1RTmQ20D3JogWN5CgCbHYFKy8GDNwKNXZRaDEheq4g+53H7t+aMjqSSAvEy+pB6YM/nhCIUYEmr3mo3vC8rJFHZsBSMguptvIKDUG3pOCmZyjxtVnYHWg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e0KMwi8P2DOsKHxrW6fJFKVRJr9fy1lh7Bjl3cDMfEFLQGhBlXCXnJFXNQycYJp1fLQrdGytwOwyM3WszPcmlI3ynIE7qvcZRhogaUC5G7CUYMkhxgosRKmGwObTsRFMNhvIJ9a1N1E57nVQqB2CirxyZFumS9kR0CPC8ywXRAurmyb7Gm2JcvO8CfOEkF0ZUtqZOS1XCOz73h32Ve1Yv6YvAmL0Yiiz5RtjOgsNa6sQJFnP6Jldped1BADYtJm/kTEYUw5kSWTDxLwMDHYg2ZBG9HxBiVDhRJSwSChJsQL4+N79fk9YNjNSz1dxGj+bnpvd7M5hi9WISaz7/DPRmImaPAbcNmE+wPzu34fV8mGJOtclLmcaKzS5lOjkDwFun5w0PWCB/bA2bhLtawhF+Iu+lil+RQXbsLe91nXGBLquGNk1HybxeBTtffFi7Pu2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:07:43.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46d3cfd-d16e-4a0f-1f2c-08dea07885c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280436-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ipsec_vxlan.py:url,lib.py:url,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D013E44715A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are VXLAN tests and IPsec tests, but there is no test that
combines the two protocols and exercises the tunnel-over-ipsec code
paths. Fix that by adding a traffic test with VXLAN and IPsec using
crypto offload. This is runnable on HW which supports ESP offload (so no
nsim unfortunately).

Traffic is done with iperf3 and the test validates that there are no
packet drops and iperf3 can get to at least 100 Mbps (a very
conservative value on today's crypto offload HW, as it can typically
reach multi-Gbps rates).

Ran right now, the test fails due to a recently exposed bug in xfrm,
which will be fixed in the next patch:
 # ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
 TAP version 13
 1..4
 # Check| At ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py,
 # line 161, in test_vxlan_ipsec_crypto_offload:
 # Check|     ksft_eq(drops_after - drops_before, 0,
 # Check failed 189 != 0 TX drops during VXLAN+IPsec
 # Check| At ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py,
 # line 163, in test_vxlan_ipsec_crypto_offload:
 # Check|     ksft_ge(bw_gbps, 0.1,
 # Check failed 0.0015058278404812596 < 0.1 Minimum 100Mbps over
 # VXLAN+IPsec
 not ok 1 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v4
 ...

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   5 +
 .../selftests/drivers/net/hw/ipsec_vxlan.py   | 204 ++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 85ca4d1ecf9e..3b6ff4708005 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -30,6 +30,7 @@ TEST_PROGS = \
 	gro_hw.py \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
+	ipsec_vxlan.py \
 	iou-zcrx.py \
 	irq.py \
 	loopback.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index dd50cb8a7911..ae0168c2bbe6 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -12,5 +12,10 @@ CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_ESP_OFFLOAD=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_UDMABUF=y
 CONFIG_VXLAN=y
+CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py b/tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
new file mode 100755
index 000000000000..0740a4d85240
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
@@ -0,0 +1,204 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Traffic test for VXLAN + IPsec crypto-offload."""
+
+import os
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge
+from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx
+from lib.py import CmdExitFailure, NetDrvEpEnv, cmd, defer, ethtool, ip
+from lib.py import Iperf3Runner
+
+# Inner tunnel addresses - TEST-NET-2 (RFC 5737) / doc prefix (RFC 3849)
+INNER_V4_LOCAL = "198.51.100.1"
+INNER_V4_REMOTE = "198.51.100.2"
+INNER_V6_LOCAL = "2001:db8:100::1"
+INNER_V6_REMOTE = "2001:db8:100::2"
+
+# ESP parameters
+SPI_OUT = "0x1000"
+SPI_IN = "0x1001"
+# 128-bit key + 32-bit salt = 20 bytes hex, 128-bit ICV
+ESP_AEAD = "aead 'rfc4106(gcm(aes))' 0x" + "01" * 20 + " 128"
+
+
+def xfrm(args, host=None):
+    """Runs 'ip xfrm' via shell to preserve parentheses in algo names."""
+    cmd(f"ip xfrm {args}", shell=True, host=host)
+
+
+def check_xfrm_offload_support():
+    """Skips if iproute2 lacks xfrm offload support."""
+    out = cmd("ip xfrm state help", fail=False)
+    if "offload" not in out.stdout + out.stderr:
+        raise KsftSkipEx("iproute2 too old, missing xfrm offload")
+
+
+def check_esp_hw_offload(cfg):
+    """Skips if device lacks esp-hw-offload support."""
+    check_xfrm_offload_support()
+    try:
+        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    except (CmdExitFailure, IndexError) as e:
+        raise KsftSkipEx(f"can't query features: {e}") from e
+    if not feat.get("esp-hw-offload", {}).get("active"):
+        raise KsftSkipEx("Device does not support esp-hw-offload")
+
+
+def get_tx_drops(cfg):
+    """Returns TX dropped counter from the physical device."""
+    stats = ip("-s -s link show dev " + cfg.ifname, json=True)[0]
+    return stats["stats64"]["tx"]["dropped"]
+
+
+def setup_vxlan_ipsec(cfg, outer_ipver, inner_ipver):
+    """Sets up VXLAN tunnel with IPsec transport-mode crypto-offload."""
+    vxlan_name = f"vx{os.getpid()}"
+    local_addr = cfg.addr_v[outer_ipver]
+    remote_addr = cfg.remote_addr_v[outer_ipver]
+
+    if inner_ipver == "4":
+        inner_local = f"{INNER_V4_LOCAL}/24"
+        inner_remote = f"{INNER_V4_REMOTE}/24"
+        addr_extra = ""
+    else:
+        inner_local = f"{INNER_V6_LOCAL}/64"
+        inner_remote = f"{INNER_V6_REMOTE}/64"
+        addr_extra = " nodad"
+
+    if outer_ipver == "6":
+        vxlan_opts = "udp6zerocsumtx udp6zerocsumrx"
+    else:
+        vxlan_opts = "noudpcsum"
+
+    # VXLAN tunnel - local side
+    ip(f"link add {vxlan_name} type vxlan id 100 dstport 4789 {vxlan_opts} "
+       f"local {local_addr} remote {remote_addr} dev {cfg.ifname}")
+    defer(ip, f"link del {vxlan_name}")
+    ip(f"addr add {inner_local} dev {vxlan_name}{addr_extra}")
+    ip(f"link set {vxlan_name} up")
+
+    # VXLAN tunnel - remote side
+    ip(f"link add {vxlan_name} type vxlan id 100 dstport 4789 {vxlan_opts} "
+       f"local {remote_addr} remote {local_addr} dev {cfg.remote_ifname}",
+       host=cfg.remote)
+    defer(ip, f"link del {vxlan_name}", host=cfg.remote)
+    ip(f"addr add {inner_remote} dev {vxlan_name}{addr_extra}",
+       host=cfg.remote)
+    ip(f"link set {vxlan_name} up", host=cfg.remote)
+
+    # xfrm state - local outbound SA
+    xfrm(f"state add src {local_addr} dst {remote_addr} "
+         f"proto esp spi {SPI_OUT} "
+         f"{ESP_AEAD} "
+         f"mode transport offload crypto dev {cfg.ifname} dir out")
+    defer(xfrm, f"state del src {local_addr} dst {remote_addr} "
+                f"proto esp spi {SPI_OUT}")
+
+    # xfrm state - local inbound SA
+    xfrm(f"state add src {remote_addr} dst {local_addr} "
+         f"proto esp spi {SPI_IN} "
+         f"{ESP_AEAD} "
+         f"mode transport offload crypto dev {cfg.ifname} dir in")
+    defer(xfrm, f"state del src {remote_addr} dst {local_addr} "
+                f"proto esp spi {SPI_IN}")
+
+    # xfrm state - remote outbound SA (mirror, software crypto)
+    xfrm(f"state add src {remote_addr} dst {local_addr} "
+         f"proto esp spi {SPI_IN} "
+         f"{ESP_AEAD} "
+         f"mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"state del src {remote_addr} dst {local_addr} "
+                f"proto esp spi {SPI_IN}", host=cfg.remote)
+
+    # xfrm state - remote inbound SA (mirror, software crypto)
+    xfrm(f"state add src {local_addr} dst {remote_addr} "
+         f"proto esp spi {SPI_OUT} "
+         f"{ESP_AEAD} "
+         f"mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"state del src {local_addr} dst {remote_addr} "
+                f"proto esp spi {SPI_OUT}", host=cfg.remote)
+
+    # xfrm policy - local out
+    xfrm(f"policy add src {local_addr} dst {remote_addr} "
+         f"proto udp dport 4789 dir out "
+         f"tmpl src {local_addr} dst {remote_addr} proto esp mode transport")
+    defer(xfrm, f"policy del src {local_addr} dst {remote_addr} "
+                f"proto udp dport 4789 dir out")
+
+    # xfrm policy - local in
+    xfrm(f"policy add src {remote_addr} dst {local_addr} "
+         f"proto udp dport 4789 dir in "
+         f"tmpl src {remote_addr} dst {local_addr} proto esp mode transport")
+    defer(xfrm, f"policy del src {remote_addr} dst {local_addr} "
+                f"proto udp dport 4789 dir in")
+
+    # xfrm policy - remote out
+    xfrm(f"policy add src {remote_addr} dst {local_addr} "
+         f"proto udp dport 4789 dir out "
+         f"tmpl src {remote_addr} dst {local_addr} proto esp mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"policy del src {remote_addr} dst {local_addr} "
+                f"proto udp dport 4789 dir out", host=cfg.remote)
+
+    # xfrm policy - remote in
+    xfrm(f"policy add src {local_addr} dst {remote_addr} "
+         f"proto udp dport 4789 dir in "
+         f"tmpl src {local_addr} dst {remote_addr} proto esp mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"policy del src {local_addr} dst {remote_addr} "
+                f"proto udp dport 4789 dir in", host=cfg.remote)
+
+
+def _vxlan_ipsec_variants():
+    """Generates outer/inner IP version variants."""
+    for outer in ["4", "6"]:
+        for inner in ["4", "6"]:
+            yield KsftNamedVariant(f"outer_v{outer}_inner_v{inner}", outer, inner)
+
+
+@ksft_variants(_vxlan_ipsec_variants())
+def test_vxlan_ipsec_crypto_offload(cfg, outer_ipver, inner_ipver):
+    """Tests VXLAN+IPsec crypto-offload has no TX drops."""
+    cfg.require_ipver(outer_ipver)
+    check_esp_hw_offload(cfg)
+
+    setup_vxlan_ipsec(cfg, outer_ipver, inner_ipver)
+
+    if inner_ipver == "4":
+        inner_local = INNER_V4_LOCAL
+        inner_remote = INNER_V4_REMOTE
+        ping = "ping"
+    else:
+        inner_local = INNER_V6_LOCAL
+        inner_remote = INNER_V6_REMOTE
+        ping = "ping -6"
+
+    cmd(f"{ping} -c 1 -W 2 {inner_remote}")
+
+    drops_before = get_tx_drops(cfg)
+
+    runner = Iperf3Runner(cfg, server_ip=inner_local,
+                          client_ip=inner_remote)
+    bw_gbps = runner.measure_bandwidth(reverse=True)
+
+    cfg.wait_hw_stats_settle()
+    drops_after = get_tx_drops(cfg)
+
+    ksft_eq(drops_after - drops_before, 0,
+            comment="TX drops during VXLAN+IPsec")
+    ksft_ge(bw_gbps, 0.1,
+            comment="Minimum 100Mbps over VXLAN+IPsec")
+
+
+def main():
+    """Runs VXLAN+IPsec crypto-offload GSO selftest."""
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([test_vxlan_ipsec_crypto_offload], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


