Return-Path: <netdev+bounces-254155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNoNONTQeWk0zwEAu9opvQ
	(envelope-from <netdev+bounces-254155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:03:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33E9E994
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6A1F304BC07
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DF33C53B;
	Wed, 28 Jan 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b0KPPrCi"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AA33BBCF;
	Wed, 28 Jan 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590947; cv=fail; b=if8sttSvMpJllgDR59PHTAU0TMoKOQAK3xN5K0BJTEY/ytEKKNHqkbXQlAv6md5Ii0cyECCd9UEaUthzgxrhTPa0BUU9dF8wLpnNfUVFqccUQvEk1bSPYKKCn0Al5AFlV4345S0z1M5CaUGnB1R/IumGUiMLEMC07MEbhSxlEWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590947; c=relaxed/simple;
	bh=l/2APZu2GwwL+paAocdRg3LEoTGUdOKphU7/I/cmvKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UePl0Adw+ckOo5LODqmkRXG4Bv+fq3UfhacSGhliRxzmU5iXmpHSZoHK8uy1br7idwVUT6YeauRGKrqNTOIkSCGBfpnB2OoXlYrCFg1BVjIZDlZZeue7BIScFOHUrYWuACuW3pyadPusgCTLBAwV9AsDHSxZYxPdUws9V6Cl5wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b0KPPrCi; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plX7TOzVNiu+xpRIiV7e7So61D3Y91puJMN1x5TsmNQAbtyIUQ7bC9kkfFUa/WSEmVYeySaP5IKcRZrtFkUl1MzaAzL7K4V9BSjl4pXNfLNMRfYqihPN80+1CXmyNwMO5pUxqKHbCIgVUhIqWeAKItdXEiPst/QwFzljcIowL2wNBL1gG9IxRXTThocGBQ1ZZTpYRxIebT/AZmfYv47F0TKahIaYnXzO/upy3IBjtTuGO2esC9RlMAM8SmO6tVWqmn/llo25l1wxQbFAImOdoMxFBuDJAkrurq7+t8Xfjd0wFXt2rqOXtCH1yXZ/odX1J9mWFEZ4WHndwNYn2ksrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hbV42zdU4kOdRtE1hywYgvgHlbgRH8VcuO3jBlyKNM=;
 b=NW+hZXFT0vAplfINN8012VPCkq37tpWehv4ynVd+8fcib7rV9DRhHajrSADi42SPjGwZCmUepaQVcZQUG75sdgHQkT6fBap9vTyPnHd2/RmM7snkvT52SE8k+KRiC5Gckm+XlrtO1VL8DzYmJhi2BBDo/zgpxXZBZbAJ7xy/DHX0eiuZYV8dwJa0C5t05LgotFEc7DE52XjSk7VauXEU/NSH4tHY96U07HtltmLt6+U1LA96g0hu8QWJBqrY1i7vWOfyFEqKCnBnfH+SxG4Ui8b73vTAh0zkSfwK0he6BKApTPatPJlzHJg5znvpYWsHh4sj3Yl78CqqUxTw1iDLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hbV42zdU4kOdRtE1hywYgvgHlbgRH8VcuO3jBlyKNM=;
 b=b0KPPrCiA3NTKInD5kNF/XQVCaLzBQD2BC3y60rIU3TzCsS+qOqHo/Zo8tUmkSFGMO9ubrtgNrX4MRQ+9Q0kBFjNzAps2VlHM6zuGwJlKEsEW4sb+FNgKgkAVLyFXEWUlPw7K3bAPnR9Hh3D4Gj0I0H4/Wp1TaWi4/RU2vxRWZ9dOYrHRqDAIjEthfT60pvr5PUw0qLVxfcgpQBh3a+kXwfSKQ/6MijW1m9dVun2f0JEW59U9lgyHfPd0nhMoSTouNKduUy13V3ESsVyJAmDpYJBjGsLgy+7B62ZnTThiogKLbQWS2+M3YzmbFfkq0XDwEndm2BrjAJ5XTpP3d02Cw==
Received: from BL1PR13CA0302.namprd13.prod.outlook.com (2603:10b6:208:2c1::7)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 09:02:22 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::66) by BL1PR13CA0302.outlook.office365.com
 (2603:10b6:208:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 09:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 09:02:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 01:02:07 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 01:02:07 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 01:02:04 -0800
From: Nimrod Oren <noren@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next] selftests: drv-net: rss_flow_label: skip unsupported devices
Date: Wed, 28 Jan 2026 11:02:17 +0200
Message-ID: <20260128090217.663366-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f030148-95f9-4335-ad63-08de5e4bf1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f8DWqu/kNkdXbm3Q7TLR8R6MuWFLC5fe35hUpfL1rJemYuUhz4i0zYskQYeu?=
 =?us-ascii?Q?ax5lX4rRFfMfjfWiVVypK+A6zvZ4rPSvwTZjIV27VzDcP9/asOeVPcZqMRuE?=
 =?us-ascii?Q?OSuxmqez+IDuoQ9aIdEx4omx+C8F/Gaz4aadrD+xsPMVPPbKGqqr0BJkIJ6f?=
 =?us-ascii?Q?xmtz+Ikv2+9DDPqIiGGWgM0y/F4sg2rjV0vAKzLiFr+DvVH8E2oAWZtyppP5?=
 =?us-ascii?Q?XuHz5crFvWaP4ZnOsHxX680XeLEvM+kJrQLmNmQYpyy7k7PDKOa/OUhm3wHo?=
 =?us-ascii?Q?TOXhXxjWS6kuMJfFjKr/4++IkZs+sE/f3PBCnanLZWVzYgpQThfxPMvxv3NV?=
 =?us-ascii?Q?1O7wc/4AiteReCmArkTrgxYXR/Wy2XsEPq1asGitMGzk2orYcZbwfPL40WfL?=
 =?us-ascii?Q?4iFt3dfeTXBNfdliVDjd7C3TJAyKvFHk0k1YTkQLo+PZFZ6zx3CvAvnYjU5g?=
 =?us-ascii?Q?SE9jwYyIMl2IvPjtkduzKPn6vAENTF3odjGQYteSXfd74lW1NSdvlzmpwgwF?=
 =?us-ascii?Q?4SfCiL7ZkR7MTcLmhBptNS9BVYeQVkxAnpaEH7ySxpvRMJBO7k22+/ycx2CX?=
 =?us-ascii?Q?OwiYEo/cCW8QVmx/+k8oiFrt1+k6irBZifOe92sYTQV6P6gZ4MT9ER62mKo/?=
 =?us-ascii?Q?vIq/iawJGVrXn89w+8BmFQ2qn8u+UAqyzhgoQuav9BfOmyCoVGGwVXxeE5w3?=
 =?us-ascii?Q?hOJ/p4GQ75fHQuC9p+WghWlWXORuk6LvzOHPwwVwdOKNTWTaYZHEaXFBV7gD?=
 =?us-ascii?Q?9eddamyy+8exWYD8Cb7VMs6oTSuVIW8xqwPErRLhGV+qMSRhhmom72R+M/lq?=
 =?us-ascii?Q?b3HCFjb2rRDcXCeYcd29RTiH27sxhyRTZEV5yOkD/qBMVkplvy4UfDEtlgOr?=
 =?us-ascii?Q?aE970c7CIDHTiHBLVJYLwapIRl/L22ztodN95m2oc4ITK7GELkhfrB/y5wMd?=
 =?us-ascii?Q?Q+eclccXSUvSIcAh3H+DQArEZ9taqoMhVP0wBUQ+vbZBshEwSPfXwcu2pjQV?=
 =?us-ascii?Q?1R83TKfi4l+bliZRg6YJjHG4eLQWnNtyUEY1jO+N/LRnKsq6188+0gKYvsbF?=
 =?us-ascii?Q?Vy5QeYmeicC+fAGz27Wm5YlxN5cs8tFP10R812Ls+VMTXNxQbOrWYQAkj5lp?=
 =?us-ascii?Q?l0FQRT3PDrQf/pugjrIxyb8YqIfLjFwut6Z47BXFC9WeK4cWb4CipTrhN3Qx?=
 =?us-ascii?Q?EdoxEZRTqM6LyaFfLra/hPQYIzO6nzbbYwbCYs1PsvR9lwD3euHuEK/Ro6Y/?=
 =?us-ascii?Q?XJJD3gXPr9Uosc9Pwk1/upfcxiFdu1tslpkxZ7kS6bA7Sg+RmbMYdxP5nv43?=
 =?us-ascii?Q?1D2srwlFBqOrslABRL+0tSDw9UsH63YPUQo+x4TBJtkzP69Q78F9QknOeSVg?=
 =?us-ascii?Q?z0xLKCcxGCyd5tTJDojlW/VmrpeKUcJ0XgaEyxL7JmK9j9jRKetiH1rdVTq3?=
 =?us-ascii?Q?EIvbfA6SIQxuaA0JY/yEx+9nZegzGqsutYnNyWlM45MBQ+IY72gRt4V6S99e?=
 =?us-ascii?Q?RJ7+Kd0wSnMJJA8C+YhKSg+ZPFOQQKFrp1E5iPUHDBhwWQlUGIxdb67SGdeJ?=
 =?us-ascii?Q?4bsz989jQZOrbi8YPJ91+f4sYjbXV+/uw49tPeMy2SmDqARIml4jg/Cx0FTy?=
 =?us-ascii?Q?n8utZpAAee8Y1dOc3iQeOM9YkJZENKcJtkBHSOoydH3o5LzJYA0WZofoQGG1?=
 =?us-ascii?Q?56xeNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 09:02:20.6758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f030148-95f9-4335-ad63-08de5e4bf1ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-254155-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5F33E9E994
X-Rspamd-Action: no action

The test_rss_flow_label_6only test case fails on devices that do not
support IPv6 flow label hashing. Make it skip neatly, consistent with
the behavior of the test_rss_flow_label case.

Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
 .../selftests/drivers/net/hw/rss_flow_label.py        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_flow_label.py b/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
index 6fa95fe27c47..7dc80070884a 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
@@ -145,9 +145,14 @@ def test_rss_flow_label_6only(cfg):
 
     # Try to enable Flow Labels and check again, in case it leaks thru
     initial = _ethtool_get_cfg(cfg, "udp6")
-    changed = initial.replace("l", "") if "l" in initial else initial + "l"
-
-    cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {changed}")
+    no_lbl = initial.replace("l", "")
+    if "l" not in initial:
+        try:
+            cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 l{no_lbl}")
+        except CmdExitFailure as exc:
+            raise KsftSkipEx("Device doesn't support Flow Label for UDP6") from exc
+    else:
+        cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {no_lbl}")
     restore = defer(cmd, f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {initial}")
 
     _check_v4_flow_types(cfg)
-- 
2.45.0


