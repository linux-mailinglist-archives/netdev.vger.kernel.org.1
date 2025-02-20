Return-Path: <netdev+bounces-168115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6489A3D8D4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE623BE793
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AE01F3FD9;
	Thu, 20 Feb 2025 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JRaw3wqA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6361F12F6;
	Thu, 20 Feb 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051322; cv=fail; b=FkcCy2jLCIbvOHk+RT6P2qXPR23GqnDMCWCiGabgyhfVdHBHlB/95MMSqySPFUalAivNbJyp43QXEIZYtYq8Re1QsQ6cMH2SRyLbke4r96vvJulidomVUYzxfXmmmpHyLHr03ylTqwgMWPDvaQyWmEI5OW6BmJEiy+/x5i7Z0iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051322; c=relaxed/simple;
	bh=dHo5wDkTuWGHpqrsh6vBnHjjsA2O+LOlevIFJAKqJng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF5s53lol1UTeuSxBylWeosZTGDLlr0tZmS7spDq56p5CA7b3qk+WD26qcLaRPSOUwsPrGtR+pyMmGabgtOZdhK5e6gd3iqAyV/R9a9+4JpoLiZMdWCxHfxedOM7bIGnHTRbX7/w7UI9ZKHpzMCq5MJFvSwz3MACl/0HX4wFwBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JRaw3wqA; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaXRMRCo+Wnh2aGVwJ2ZeKcvgWbexqWCEKBuFXZkZidR6cCigPtIOfZW8Ekg3J0KZgy3yMIeoCqOPW0kDJkzkhaCCKpHVg0eW7E7apVJjRJKcUzGeOXHn22DfXSilE8HbVj2i2Tcs6ZGESM3Ul+4bfI+UILEne7DaNyjT4CVmQEcHfVAvkQDPNx3TR4M7HpogkW+4er/B6vrXBPf0hY0kIdCq/bgKggOyt6RCK7WAoHFledirJW0tY5GgHCYoeYmOheJpMAUOH4bITKtfEu7zRe3hv6Q5d61DGkoVfODkrku1tK1MUYmgTPQEPB1X7lNKr4fsBFlAnfIAmynvWPfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVgyejacV35cUoJDUj3z9CeeOKJm0gPJ4zoro5cRN14=;
 b=zHwYO5b/huao7jp9sgfvG6U0w0Hiwj3JJR3fGYDpDFLzYiQ2zIHmKQGJx5RJehhxRxz0quSg4KHYRWKsdAJDtwJHxyyR3SltDD+n8C0XvB0FhPEH9hrdy7tlu6a5FfbbuN1lPTXOx/AUDot3Pd98jMHZMXSZSgZ7Tht8R3hG1ZfWdwcHA7i9rOyrqNga1xZzsYlhbKG0VJ5tebju9oEBpPgboQ6IkcdlDUP/LSUzL6+Za0LzPsWHSl4nNWBAHS0i8++nfghwA/QOa9+qeXsjaPoU3yB3LQjOA99X2ChZ/4RQCo/XLbZEzJ+ycdeP9jSxpBB6rfLP+Z+4SNm68ld4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVgyejacV35cUoJDUj3z9CeeOKJm0gPJ4zoro5cRN14=;
 b=JRaw3wqAnh0iCXXJ4t/0YZe5nJmKoSQpXdOBv/Tf43MFnHywyYUMoPunBoI3940Tbq6KoOMQpLOqlEqVh4rMQgwHKDNpCU++zftV06/q3xbQCiqwuuPJBQzCFOr9YW1AkCUpiXM/xEWUUfxV/rmLvHMB8HwS0mvCNEQrY0JVcz+hE3pNQXgg7rBu4FqHm0fhwQz9oFG57+EsPaHqSQVnnJ3FBbfwXx06pU4kKL2HlwVg0rvdTsCxbuhpEOm0kkq3LMFQjldtsi+ecxqUq63ok1xRzn7fvh5ljlnoBFZtQpgZZTwqImioVzPz9S0hvpf9bzphV1SC6B4OSrGsqeSX1g==
Received: from SA1P222CA0180.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::17)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 11:35:16 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::2f) by SA1P222CA0180.outlook.office365.com
 (2603:10b6:806:3c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 11:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 11:35:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 03:35:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 03:35:01 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 20
 Feb 2025 03:34:57 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v4 3/5] selftests: drv-net: Make rand_port() get a port more reliably
Date: Thu, 20 Feb 2025 13:34:33 +0200
Message-ID: <20250220113435.417487-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250220113435.417487-1-gal@nvidia.com>
References: <20250220113435.417487-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 406a219f-bf06-4010-7148-08dd51a2a584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tzL32l3aDLUoiFPpMCEAV96xBkhesuDKiz2YAEBo63XFMrO8gAyr9pBhibvI?=
 =?us-ascii?Q?gIWQUPnI2Rt5rVTjj9jMcQzVurDhMvGH0NJ5FwBgzKu/kCfhWYmScjFls6Sp?=
 =?us-ascii?Q?Km3ZRBc6tzlYUGw0bknjzAtvMcO/HRGwQgO9AiqMr6PdXiMzy+kHaeIqlJnE?=
 =?us-ascii?Q?tG5DPJfdqNkE0gXPHUo8mN3/btDJc1MuEd12LRDf/nuwFtYUE80WbM/Vz4+8?=
 =?us-ascii?Q?B0UD0gjVzF991kWm2jl4C/lVV/TraCl9bsQF+Q8Ncfc8DSj8iRZLvRimJpVz?=
 =?us-ascii?Q?S8cj4stqiNBnvcNrlkQnASWtd6EB7oIy4rDAtmjwUa9rCioms3WGheZRLYhl?=
 =?us-ascii?Q?btvDV6xfcixTruL6LqQlYvpMRhzvwkrRCAER2zhBetGYUsSByimfpkDbGtDj?=
 =?us-ascii?Q?K9vehYzfcMLEnANVGcBodysk510Rf/aLQ2XhqmVhqUdJz4D1y3q0zasMaKeA?=
 =?us-ascii?Q?EG0B0qPz2ixPHIiI/9fUquUZeHQ5ucOTHy8o6OXmipgBqclUMJbbehHCSrDq?=
 =?us-ascii?Q?unEdB98/kBp6fOz2SVRwnqC1Lt1Fy4Bh/SjVXp8VszhX3URUobxV4VmqHBpW?=
 =?us-ascii?Q?BbYP9UfW2p2ZtAP4RBuJtB0hsb9hw+fAEx5p3Zi8OpS8oOFTtWwiuoh3n1z+?=
 =?us-ascii?Q?FsTo/63R0okyUfekoOU5o7l0Pxo3fk0mWh+HBuSqdAtwsBf4kZ7yiYKv6iuh?=
 =?us-ascii?Q?XGW40hNYhL88DPYVZ3NqDxEQRb2ogBRiVcT4ML2e8D4WlGVKDxuOKUX5UpZU?=
 =?us-ascii?Q?Ew110OyJtjHJ5Tabb+yogjBpFQILoFg2J6rOtBN6SbfjowPKhLBOPAS6lsEa?=
 =?us-ascii?Q?4pT+ZPyCbeh6/dtFP204ZcpKuDDSlI8ZhjwmWf2ozVps/vkzt9x1XR09pXQX?=
 =?us-ascii?Q?6CzAqMtf4K+3fUkXW3Z0EvZvLU/p9ZF06uGWihmcXj41xfirHmc0XmxhRYDV?=
 =?us-ascii?Q?BpJgtyzBHLAfjgDb2TVLDFsVY81Qlb2yCS3PngvtkYKUigfWsuWIWZaJeG0S?=
 =?us-ascii?Q?9vw/WtutyU8Dbeh3IZ5sVrq9zuu72mpQgduMipnOCHLCiJllUNZi9p5MaNB0?=
 =?us-ascii?Q?ILgwsGvrvmhxJpoLFBZl7/coNE2lQLdSB8Pyt9bEiuiA+rj8pbxr6kwFRrjP?=
 =?us-ascii?Q?jJEy7f5ZsEQmkOHtXk1++FV1F+C2I9UwgMm2BUxZbjUsCDw3Tdprj5trD+qD?=
 =?us-ascii?Q?o9JJbVHA/QE4rUWHuuGXR9F05Jo8xss20C5Pjize1dcND5Wirxbm7iDupl8c?=
 =?us-ascii?Q?L/hNeSqGxnnxHC2f4r3gxG68cFheeWQDdK7BNUJMa5EGCxOw29t9kVoHk1hU?=
 =?us-ascii?Q?sac92Bf8stFfLMLbMxFl6PEafVWR0s01VfT3dGn0Z1U9QrOP+ljJUPFopS4L?=
 =?us-ascii?Q?wiB62t8OawYs/a1rOiwHaEw8rKN37britZoJOFBeXBoEPgHEXpdtOVlqJ7if?=
 =?us-ascii?Q?bs/I3/n1ZowUi/GSoGxCi1czEIBBHka5sHQZLFKSTfG2zXRV+bWfWVOLmFBf?=
 =?us-ascii?Q?8EJ4lFFcmEOsE+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:35:15.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406a219f-bf06-4010-7148-08dd51a2a584
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

Instead of guessing a port and checking whether it's available, get an
available port from the OS.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 9e3bcddcf3e8..5a13f4fd3784 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -125,18 +125,11 @@ def ethtool(args, json=None, ns=None, host=None):
 
 def rand_port():
     """
-    Get a random unprivileged port, try to make sure it's not already used.
+    Get a random unprivileged port.
     """
-    for _ in range(1000):
-        port = random.randint(10000, 65535)
-        try:
-            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
-                s.bind(("", port))
-            return port
-        except OSError as e:
-            if e.errno != errno.EADDRINUSE:
-                raise
-    raise Exception("Can't find any free unprivileged port")
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        s.bind(("", 0))
+        return s.getsockname()[1]
 
 
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
-- 
2.40.1


