Return-Path: <netdev+bounces-166819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04571A37689
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CD3189079D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F019DF8B;
	Sun, 16 Feb 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUNjvfDp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E4154C05;
	Sun, 16 Feb 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739730337; cv=fail; b=dCfasI2tn3+YYD6G6vLJf4DnXwrlWtA2RA/1dXJBZDx7r1mFzZPPkHPr2eKp4+dJRzx8OAGhZ1ZlCvboBtXaroGGiMQjaUYMeETmZ5k+tr3eEtXXnkhjZVvZC/KGmVX2A3/WlLyLAFF0QfUUxTCS+zLZXB5ii1lDEcMxfdgMizU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739730337; c=relaxed/simple;
	bh=dHo5wDkTuWGHpqrsh6vBnHjjsA2O+LOlevIFJAKqJng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltLvrmsuTsUa2cZGB5NH1O8QXQYHSuhbmfpt/AdVSwaqQQECMqOXuiyAaDYVQxrwYLJo+Swua+RbCztLqmsTa1wkh2QSUwnqm8cTmdaWJWU58XPve+6plV12eEMdmSr75je0WhRrhFdPWeQfG0ApeidSB1Yqf9yOM6KC0fGhhGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUNjvfDp; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWeegmuHk5tlC3AA43un8uYnmJNnJiKTzsTrpd8XIj3uYEQRfwk0XpIS1sTZTzzVYz0B8UkahN6zfxOvDmSafIB2JyddGk2lFeGPZUNcK0kFjqHaVKaWmoUP6SMnY8FvHoiElbw5iB+AtHOAGjhTfqAC5QKuleIobm1x6e5xWWZ80cFDduefgdSI/i3FBfCO1yVcWUuVVf9AmHv8v/X8QmXqdoPeksf1sb4RXK37k4Nx+QTrouZ7EOpNqhP1pJ03THbeAcnYkDGBQVaRpFluT0GnQSpFIWrBI0ZoKOjb5HEJJrfvwIzPQy7L2zw2OqfRJz08151FuNCeL+FKuPgQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVgyejacV35cUoJDUj3z9CeeOKJm0gPJ4zoro5cRN14=;
 b=Pzq5MwZxcxh9aa/kIrFDzQ1yLrbSBSYIF6JjcRp48gAHhLqNwe5+edDJZeg1leVJpIawavATimcB0zABPp6K2eLVmjbqHG44nMfhd6sGFgQbtASHzGyVIOtms7SrdnrNrltnW+XAl5S/3IUE/TeJ7SX1yPTFkZjbLdUTcieKKIhDXrnfYLYnUfPETjxsli10tzHJeQRTTlkDXRmZ3b7xP6B+2X06KmaVJhdRpPUX1FTKmr1ACZqk4/3UlLiDmwOo6KNY7HcblxBXDKdh9SuiRU5rZrfMSSGoZzm3QyZoL00sCulVOCEky3Iqt5XaZXuspKKm9vbTeTjDjRzTI+MumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVgyejacV35cUoJDUj3z9CeeOKJm0gPJ4zoro5cRN14=;
 b=TUNjvfDpDwIQdG0X2PXPd/YNCDYdS0qoP5Ms/Tz+aJtu0TXQV+LsLfuMaUEzSN1fNVkftoyCips5F71XQOCluOE6Su3hL/5hqpDLQNzUlJLZ3+JYrRiuPbu+ghqHGX789doJabKlPz8ajRpyVopjdkrNXReFY7VtRXZaMGgV+PAj7OiBiYJV23BfyuZgfn3c0/W2PJv8qUMqxRY1tFFocoy4fn34TQMbCD1BaKWbfnAUYAzXxEhQmvrIzFQcrmqVw6G3J7a9O0Mvrs9UMjKeUQF1K9AmarJ6oQY+LJwupeoAJ/frsy5CkRIgePZQLwc3Ny0SU17ZVI/P9zgikkPgCQ==
Received: from SA1P222CA0049.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::26)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 18:25:30 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::d7) by SA1P222CA0049.outlook.office365.com
 (2603:10b6:806:2d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Sun,
 16 Feb 2025 18:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 18:25:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 10:25:16 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 10:25:15 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 16
 Feb 2025 10:25:12 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v3 3/5] selftests: drv-net: Make rand_port() get a port more reliably
Date: Sun, 16 Feb 2025 20:24:51 +0200
Message-ID: <20250216182453.226325-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250216182453.226325-1-gal@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f276d33-f0b9-4854-b1e4-08dd4eb74b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?amg4HEsWym3JUVpbI0GljeVMgqoqCvDMLwW33pbXSPswhOPyOHuMQwB2Vu13?=
 =?us-ascii?Q?1atDIKgJWKbH3TgPwetJVOpxUEQ2L2/zbsg7Xb9qp0APVHmG9EbpFF0tDfW1?=
 =?us-ascii?Q?MXmqlPYAqpi+Chqdru8Tbor3AsVj2v8XkKGQE0SXBY6zd1cSeUm2OHsJ8vFe?=
 =?us-ascii?Q?1i/30Bi56XE5lAPoKPKxRJuBgtQIdDHxEJ3VDAEYA81FPbJCY15BksO8S5yk?=
 =?us-ascii?Q?uMtQPjijZMgam1xxjcadaiRwxMGDLjwph+tQEeWGmLfkfGSwjUxPQR5yyNZe?=
 =?us-ascii?Q?yfLlvj9zrluPqYUUhgwBjIxu2C5rZOnaPC9puXLYS/ai6RzxoEAI5TVd+gPz?=
 =?us-ascii?Q?4e7Lqwo+vN2qJyLB/ySUpNQsjYjC29f3O5c/hW0G+770Q9F59ZyxnayRENUp?=
 =?us-ascii?Q?saaK6kY8IRjbOWQbqTEQb32FWIO4VweaB2MmrOzYFZnDGDGf9whk4218t25v?=
 =?us-ascii?Q?oEoBqckxGZFCzPrTXAyfnpjuTcgsLoOKFNEF932Dfs0a8JaN4TNuSVFYHGLy?=
 =?us-ascii?Q?yMFC/D2mqHpDo0SpdqIKSR7rMWI5E/Iyhuxor2h3AbRu9LBFkG4Fqh6aQRaW?=
 =?us-ascii?Q?q/v0efGhzkASSrQ+mf6Gm2LpvyZUc4AOPvgqRW9feCt8HJUaCT2s4xJWE9MI?=
 =?us-ascii?Q?nQyOu7dWhUu7KOWjE6wEsux49k7zoks9LYE7sUB8d7iFXLUbFRjW0KPjwV5p?=
 =?us-ascii?Q?LXOsssle77Q0xZPm2/OBGiyPAM5vL8jyXUm1yULKNOW9PjYknDZ21NW9/yYf?=
 =?us-ascii?Q?gQPR5BulB9+U2PiDDqpTaVz87ByrGSpID4b1KDs8G3zNdUc0b23hOuOBfH4k?=
 =?us-ascii?Q?H6kPGMrGJysutyRntXZuDZpkPjB50XLyNIrNfcefQ5DmY/XWTuB4YRcj9AY8?=
 =?us-ascii?Q?e0xRKnorXNOFMLc/hZzxZC0TM15cJ1EpJq2YTwyB7x7jEW1uSFfQwAENfKf7?=
 =?us-ascii?Q?snq0p4We02sHor9GEmbs3dMFMwzoBTFSKQBFhvJQ2gNGTjFx63jb3Mh6rCVE?=
 =?us-ascii?Q?hlGkLCqMUrvcV0oxK1cr+UCewUS1OQXdeOdGXBYexKR8q5IwNdpG7+UxvirV?=
 =?us-ascii?Q?OWVJXyc30a9UXe51E4Il3Fi72t3E82ZRlqYamIvpHmn1XP1YoarGdabXEYPI?=
 =?us-ascii?Q?5m3EXCdX5F0xQuPuCXh9/aYNG0NqK2DTFwNexfCjpPByjc05Dl7WDAofCaCs?=
 =?us-ascii?Q?ZcFkUIhoeJXWJAH5JiaNNNEiMtjgrahLPQ118Ri3SBqr5jwTkRpcfvOApWBB?=
 =?us-ascii?Q?uPszScUZw+xDM2l1olYGnrv9M/pG10MNw2SyDaIPjiJE7vdvklOOHrzj6ZPC?=
 =?us-ascii?Q?Pkf7BBMD3ROUaczNuIKSaBSdO5dAOK8/ELjrHv/kUAy+6fZmg5bFyxrGRn2c?=
 =?us-ascii?Q?kV7bQNxR4/eYTlDSKSukoEdOvbovccKvKbXOUKfs6AVcClUDyGE7hk3nl7gM?=
 =?us-ascii?Q?WTuQCKAgbBX01MYjPPOCaWtm+IXaGtjDbmZMrjJyU3PKrgymK1HBsg8rPe2c?=
 =?us-ascii?Q?sd3fPvwcvceCF3M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 18:25:30.1815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f276d33-f0b9-4854-b1e4-08dd4eb74b25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

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


