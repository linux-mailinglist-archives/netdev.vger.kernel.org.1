Return-Path: <netdev+bounces-258051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABi6Ch37imlBPAAAu9opvQ
	(envelope-from <netdev+bounces-258051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 10:32:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF47118E61
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9446B3003E81
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4AF33C53D;
	Tue, 10 Feb 2026 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhKAH1vM"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2018C03E;
	Tue, 10 Feb 2026 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715929; cv=fail; b=JpWMngQVCaF++DI8KdHFGi/JjjG+xxiQeoofoWmUq/T0dmh96EFhOr8JzYKttCqVYDdBRuJQ21WXZS0qC90h5UiLd5/ccBH5NAfeQZxcL6QChb4leY2tjVN7qT9QJ/Kx8S8WfczOh/2puHNcElReA3xhktiHV/ERABlfSwO/X8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715929; c=relaxed/simple;
	bh=z62uKFejWYrl87I/9mwd9s9vLL9hi0o+9iUmdsLIYOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mWo5IsIMDimvCYTOfH4I+PmaJMNMrvjD4fWctc98XE/+XBu0O22DimZEF8ea7BgKTkzI8/Xe91zBC6N+pkYEcqPiw945XGnWQjrCjiPWZ5CzAylh8VcsVhx+0xwX5YWLvg7H7T/wZIThCeMxceS59ST6cZRW/yGL3u6k0fUGMso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhKAH1vM; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeDRdde+Jv/fOt5WioW65N1BFSeFf9KzRMqO+GAwNQpqwfoCPEOcIqe5EE9XPP69g8ZL+IiH7ue6zYtdEUs9l6dKXL8J+niJ2BtomK9QFoXN80R//I9KLdMCRxXdyhUiaWT6Q8eWxJ1ro3abSt4xvpTmcCPTcSyBO6XPqaOFo2tafCJofSvTQJ/VOC1knxD+sD7o4CXGzjzA7d2Z8xGjUMmvGp337z25I/n4WzjYFwJUbGHUB0zYcHwKbmD9SYDqLD4xIXZfr7//JP4IE0tmqDp3blMwT1h3xCR9AKmdv4tjhrRIxsun08kMAMCT0DqiBCvF7yvPLorlh97iLYDCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPMNxKbpDpKr5qQ+zJhoeNjz0E6p+lmLlGkyfrJEtVA=;
 b=tWORbxjCucMfUOU04LI0zuXthhNWZUHFrzJ+wje0zBA0t3VVhewk8f7QoIJ5LdaEltl2LMcikAwRV0K3avpXOIB4d3RwYSKX2UDUHMlSG7aKTUt+zahKdeczU3y4roey0jjaUpss6rap8Z/ZNe/XxpYj1H8bCwiFyPPkvLlCJFG0qGmBja5/PfFJLx8anoaCjWU0jKV1IryeKBb51hsrXDpOU3iOzupq/Y9f+gJfnGBadfDop7LAeGvko6i3Ji3vJn8AtXrOwQi6rNRilN6cnZuM0xNP/pSxEVofXfpk2C5PcXwECEW2lTcQdps1vp5IR/dMrFxJV9CvXD3TGGoYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPMNxKbpDpKr5qQ+zJhoeNjz0E6p+lmLlGkyfrJEtVA=;
 b=JhKAH1vM5s6lEwliqJDRCVyc/zcCPblvEmKaJPOPImGh/CvqwR6vPNBtws7bjvCBLfV+rTIjDS7OwhIzHtFY/ScA81Y0pBJXlF63rJKuPII20ahbmJPvxxAfOZxJbP7Eo8/DhUZ6/GvS/5VurdWQxkghiiFW6JLbyz+U+C2MvZO9/i4CNYLk1iLTLDgqTSqPWvPHCx5ynGHhl58vFtYDPbdLT3HGekrbhN3cnWS1j+pukAN4bOq0W8muIEERKRb7OTq2z33Kufjqhd4iUsZ/msyNNUxM68eTvbvx+Xti3POPfDBv6CC5eJvpBduRl3A0ALB8Jaq+FemimR+YTwwR+Q==
Received: from PH8P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::7)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 09:31:59 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::91) by PH8P220CA0006.outlook.office365.com
 (2603:10b6:510:345::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 09:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:31:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 01:31:15 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 01:31:15 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 10
 Feb 2026 01:31:11 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	"Petr Machata" <petrm@nvidia.com>, <linux-kselftest@vger.kernel.org>, Gal
 Pressman <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net] selftests: drv-net: limit RPS test CPUs to supported range
Date: Tue, 10 Feb 2026 11:31:10 +0200
Message-ID: <20260210093110.1935149-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: f255718f-ab4c-45c9-0129-08de68873cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YrII3hgoMzy9spFBmmCUBbYUULPeWxUzSSZ2G7q3nJH39siQekT55+EkJSXw?=
 =?us-ascii?Q?O2ku7vhBWihLEdhcPzw3DycFzsf2deSYN46xkcaQYPSba4CQwjvmUrt8Ub1e?=
 =?us-ascii?Q?EdnrgKkD7pdHSBTh/pj6HpmSTWnxYB03YiCXkGvQZL3xLCZDsEdcty6RYCV8?=
 =?us-ascii?Q?XjQJOZldHG6RxMkgcjemaa5AGXh3XIlNbcJDZ8O61m3Al9bY8WRrgd4ILxWJ?=
 =?us-ascii?Q?DJU7EYl53J+TOmfK1GwNCS8QwgPMBO8w1FVGqqnMOCj8jBfCiF2f8TriyopB?=
 =?us-ascii?Q?w0LZBvZYmfi4tCTPB/h+PHAYK5Ob3EGHHvLrdLo+2trrlsbuiTjQcVNQtuee?=
 =?us-ascii?Q?j7URBp9AnM7kToquBYIVl/V0wUnjnipeU0lNoKbDlb0PmACYRWL8DDSMIUd4?=
 =?us-ascii?Q?D1GqLJOW2a9E3NZwfm1iIvY+iqXix6+3mLqe9/y6CZGyer2YTjbNIs+vr5Bm?=
 =?us-ascii?Q?MNKz0ISPg4ZzMij+C0I8u6lTUiiSt+JUZYkiZEBK/vwJXk4x1cberSSJ6Eqn?=
 =?us-ascii?Q?/hqf5qyzB8PRhEyGcU/nHeccoZB9/jHQ8bQoE2L+XC3w3O65wnM1SBmCT5oG?=
 =?us-ascii?Q?3CHi7QXhq67i/8kWppDwWwZOr1EL1nku1EeKspC9/2KfAL1meLqm/ewHJZGW?=
 =?us-ascii?Q?2Q3W6xXzI2G7oovJ6f3wtGfgQnbSQ//VDPCIvzv3tHUgeFUlURuz9BBS97Nc?=
 =?us-ascii?Q?XFMwgkhQVxACE0EGxlzSRdiMn4p5ZnuJ8DoKx8DrD+uXY7NeeJMVTyJKtVbz?=
 =?us-ascii?Q?dIKnf1pzWJbHD6WHplkvzDV7gF393hXizlQ5vsT65CMFe3zV7H1TOWnEg1az?=
 =?us-ascii?Q?ozYJ/qrwUBh+rtjVvYJ5XMEdrRn0u9qSiUElGU+MEA6iZT7xYyvGEQTpwoNj?=
 =?us-ascii?Q?B4gGt4JsHH0eA1bgk4yoRrDu9f4n0TJdCV+BY/GFXLbeT1i68CrnyCbxTYZo?=
 =?us-ascii?Q?o+lmTp5GaTtV61Q8LHg7dziTuxiRAwrlus99emvt3Zjk71m+M33DRsdXmGnr?=
 =?us-ascii?Q?WwG4HHTQvnxKe8B8S3J0uk8hMHC+IcWaafS8RBfkMMQUkGi98HN5YcuV74JT?=
 =?us-ascii?Q?8UElPL6uznE62YKTe22RWEQvimKk4e1VdZ6E+EHE2PnUoxDHNwRDBwwUMa1i?=
 =?us-ascii?Q?dLcNPLWWueexaAaHAaLd7JWkz8CXifHArdQMmCR5T6uXbntI3cSmJ/thkgdJ?=
 =?us-ascii?Q?mGjPHp+cfQPx4Wfz69dCbGEIz9G0EdkInpyMSlBibXKqU1y4F5fEze+RTyPI?=
 =?us-ascii?Q?8cdekt74IeAX9A4BE024ECkWLhO87WQ2fDpzPMCOSA8c6tsFr41JMJGF8F/7?=
 =?us-ascii?Q?M3REYTdpCKLjtlejmk2x74XauXQBt433v6W4WGNH4TG3+EerZqZqQE1Ay/OK?=
 =?us-ascii?Q?1wKg+zFYZg5SpjpwiFS/RSieKWNSo1XcXkhfrFzRUDrGIK0ZiAVQnbKJc9KN?=
 =?us-ascii?Q?q5RZvzAx2j13zRiDtvOeQe8avQPStPd3dP2keSOF6GTCArIvHgGRq1L9Ex9e?=
 =?us-ascii?Q?IGEE0Q4p0JNXypwwU+toAujAS72Qknhl6PCI0OxFDApni73yNgAr+F9O58uU?=
 =?us-ascii?Q?/4yQR+rmn97m0nrOYRLYJMY/zQmHCKpzWA/zvJBy3MCGsQJ6HoEgYR+HiNvQ?=
 =?us-ascii?Q?UxpAFmuZonhW4CzfgeLwCNpTkfq8H+j+hbo1FiHeDnuZkGMVt0le7bbPPGFY?=
 =?us-ascii?Q?cdTCbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IGygneXoDi1PgzUmRVHtDc/rxj+VgZLHwNcKp4ok4tJahZdXN3xMt34SkVKOoXER26otedMarcYlbjshUniKKrDLnEUi767FVMouGf8fxKcyXyipFx/ct9jZoqAJ8aHSVlw3+kibmunAqfgAKQ28MruG66QDRx8mVDx3WevJT1eyoy1voBdBorEHzsNUKMLvhbD5gImvY2iati0ntlWl6OKOW7vtrbTT79XhjmG4VtIsMhNWKlOsKhoXcLEOmOmebm0+czo8kg1bdtXijFNYKZ99khRr9nBy2cxryMT7QjEghY1jQfTPp4XzXpHdNrjF4/8GxMtovblUTMtqLBHCfpec+6lDbA0svb+bxZymDkYKcN/RVkACSwPcSMWOrs1C2kaLDRcvl2mgmAIkzHuQK5IqFjizgjM4bI0K4lLe41jmSQbwxbfUbz6BJ6tGD9wb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:31:58.2869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f255718f-ab4c-45c9-0129-08de68873cdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6FF47118E61
X-Rspamd-Action: no action

The _get_unused_cpus() function can return CPU numbers >= 16, which
exceeds RPS_MAX_CPUS in toeplitz.c. When this happens, the test fails
with a cryptic message:

  # Exception| Traceback (most recent call last):
  # Exception|   File "/tmp/cur/linux/tools/testing/selftests/net/lib/py/ksft.py", line 319, in ksft_run
  # Exception|     func(*args)
  # Exception|   File "/tmp/cur/linux/tools/testing/selftests/drivers/net/hw/toeplitz.py", line 189, in test
  # Exception|     with bkg(" ".join(rx_cmd), ksft_ready=True, exit_wait=True) as rx_proc:
  # Exception|          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  # Exception|   File "/tmp/cur/linux/tools/testing/selftests/net/lib/py/utils.py", line 124, in __init__
  # Exception|     super().__init__(comm, background=True,
  # Exception|   File "/tmp/cur/linux/tools/testing/selftests/net/lib/py/utils.py", line 77, in __init__
  # Exception|     raise Exception("Did not receive ready message")
  # Exception| Exception: Did not receive ready message

Rename _get_unused_cpus() to _get_unused_rps_cpus() and cap the CPU
search range to RPS_MAX_CPUS.

Fixes: 9cf9aa77a1f6 ("selftests: drv-net: hw: convert the Toeplitz test to Python")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../selftests/drivers/net/hw/toeplitz.py        | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
index d288c57894f6..cd7e080e6f84 100755
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
@@ -19,6 +19,8 @@ from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, KsftFailEx
 
 # "define" for the ID of the Toeplitz hash function
 ETH_RSS_HASH_TOP = 1
+# Must match RPS_MAX_CPUS in toeplitz.c
+RPS_MAX_CPUS = 16
 
 
 def _check_rps_and_rfs_not_configured(cfg):
@@ -67,23 +69,24 @@ def _get_irq_cpus(cfg):
     return cpus
 
 
-def _get_unused_cpus(cfg, count=2):
+def _get_unused_rps_cpus(cfg, count=2):
     """
-    Get CPUs that are not used by Rx queues.
-    Returns a list of at least 'count' CPU numbers.
+    Get CPUs that are not used by Rx queues for RPS.
+    Returns a list of at least 'count' CPU numbers within
+    the RPS_MAX_CPUS supported range.
     """
 
     # Get CPUs used by Rx queues
     rx_cpus = set(_get_irq_cpus(cfg))
 
-    # Get total number of CPUs
-    num_cpus = os.cpu_count()
+    # Get total number of CPUs, capped by RPS_MAX_CPUS
+    num_cpus = min(os.cpu_count(), RPS_MAX_CPUS)
 
     # Find unused CPUs
     unused_cpus = [cpu for cpu in range(num_cpus) if cpu not in rx_cpus]
 
     if len(unused_cpus) < count:
-        raise KsftSkipEx(f"Need at {count} CPUs not used by Rx queues, found {len(unused_cpus)}")
+        raise KsftSkipEx(f"Need at least {count} CPUs in range 0..{num_cpus - 1} not used by Rx queues, found {len(unused_cpus)}")
 
     return unused_cpus[:count]
 
@@ -181,7 +184,7 @@ def test(cfg, proto_flag, ipver, grp):
         ksft_pr(f"RSS using CPUs: {irq_cpus}")
     elif grp == "rps":
         # Get CPUs not used by Rx queues and configure them for RPS
-        rps_cpus = _get_unused_cpus(cfg, count=2)
+        rps_cpus = _get_unused_rps_cpus(cfg, count=2)
         rps_mask = _configure_rps(cfg, rps_cpus)
         defer(_configure_rps, cfg, [])
         rx_cmd += ["-r", rps_mask]
-- 
2.52.0


