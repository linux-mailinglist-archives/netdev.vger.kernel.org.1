Return-Path: <netdev+bounces-169128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C954A42A39
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107EB16CB8B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403F26560B;
	Mon, 24 Feb 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWeZEaPn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E94264FBA;
	Mon, 24 Feb 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419098; cv=fail; b=r0LTiyRMlegoQvvB9AYzk79eX4iUYgeFGyg9ReZnDcIuJdORWOKrFyv0jG3kIw8f80mdWkow5ovEWPbKhdqubLup8PCpbuGESItkm1cEVKadpGt77I8+lHjve1xdsgC+K63jYtJrpZqWFwMcl2I1IDB+PevOBrNucDVjHJn2AvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419098; c=relaxed/simple;
	bh=hx76Jj2/kPDcJk7mJOpUBY+TFUa3pTQ4U1a8hy6t9t8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSDPTEB3dctIDLULu0mFC/16TOXCXV6Z1dTpmFjf66OP441fc6YfQhYeN/MCtkvJ5kFYMAeJmEWUGCFCZge38JDtVc2oIvkc4Gc7wRq94m4AA6iZfavH8pTqdcx/qgviAHkzbkPMLjSPumIjmeultfI+d9GYHc9iTW1XxEjXwa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWeZEaPn; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKPM4ww2XFzBYUb9mF6YhH64HEKmiZ27JGL8YBAV+CzYqkPYAjnqczChJSNXJAizLFZ4BvNKdtaJfdBAkgTUx/2Eg157QF5yBOvK0n9t7JMxiaGq0sjX+sBijDJW9kzKY1jjwRAMt8vtzSlz/XeBRCfmPx9in32rLHR+OplOHjvzISBmKQ+A0R/HFNKWK+w+paJOle3fpN+uq6zSrBBNHzR6kvSAgcrFGlqDfxwlgn+Visup1Ysl/v6ROOK4KxeFSKeJvWFz5PzWQnjzhWrEbHv7nfGusnfkLoMzVQowhMSoLLg2z5vJ5StG9Rexi0Fjx4+zdlk5FBB2Gpv1PiPYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nju8gstTTZ/hXAzlRxyaJP/Elq4Jqk/3xXFuoFtWeiA=;
 b=a4BpvsYF+H5lgKej8V0mweNdXc3PWr2LOMr+flhRhfYU5dFIvTisaF2RjM5hRKYkWEoZXySD7GZhqv2gqBgvZHezHqdh2aG8XemLjJdE6HZrANFI2lAErnCWzUjxAM294J0CtNkMn1aotHYz0gIQEI9z12VO9OAMrJmuQG6OlF4GnsUL+JPV3jY2cmZMnH5RK4fnhUPZj4TbHEza9CK/h4t9seuuahf6Dxxd3folhQVC24CGosnAOTESzhgtvkMdSQ7i4Rj3d6YiyyS0tvc9D2vEQpeGjlvv+jrr6Ww3+rdOqQ8910HuhZOxPsAOmGtbjc6xaw0U6ttO9T6yPBUSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nju8gstTTZ/hXAzlRxyaJP/Elq4Jqk/3xXFuoFtWeiA=;
 b=KWeZEaPngFvxp4omw0swOMK3H4Htc6P4Rh5uoUUN4lReE3IkRjgwwrkYdfpLjDuIjQPV5cBB3UyeZSTmSy23TWfZ8EVGKn8moMoh0LbTlLuI7R/EYGUYdNMWGW0xmmUlHaTMbp/ve+qNym6arLboh0K0Hb7iVHlPsyHnSvK7F7W7WkKYRnCOCUhU537rq9ObQipt/HHmvfKlyAUBO+dj9FY6xBd0lW1c0AdNnT9skP6fBDQ9t29qCZwOM/h9T/vErWZSuh39T0U+Om8XNpKvkIATs0xoTAMpfuIqaiNWYnEgBnJA5KgVhW6dGPkKmWJLBnLWlUfvkIGsHyhADLNMgQ==
Received: from MN2PR18CA0006.namprd18.prod.outlook.com (2603:10b6:208:23c::11)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 17:44:48 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::bf) by MN2PR18CA0006.outlook.office365.com
 (2603:10b6:208:23c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 17:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 17:44:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 09:44:33 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 09:44:33 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 09:44:29 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v5 3/4] selftests: drv-net: Make rand_port() get a port more reliably
Date: Mon, 24 Feb 2025 19:44:15 +0200
Message-ID: <20250224174416.499070-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250224174416.499070-1-gal@nvidia.com>
References: <20250224174416.499070-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c2ab8d-a81f-4601-b86f-08dd54faeeab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hhs1VB7x1M75UXPfot9/jA2MfLVQs/v2xmhBPsCRtcBRdgljRcwwn0ikTZ03?=
 =?us-ascii?Q?UMzEvFBBWDmo6psAMuY8SwYyNLBAdBU6XnKvq5SA/oiTn1RYNwsaJ8OfVrYj?=
 =?us-ascii?Q?JtZZAT5xySeQQVE8IO460HIXYZFPJCQ8MEMOIODCY7jKwGiVrHxTZws2Lawp?=
 =?us-ascii?Q?PEFNSS/6c5ofJ/iWl8JhddWUhavD/QomzuFU8h85PiWNKuW6zL+DeUyerIzQ?=
 =?us-ascii?Q?Zd+5hcyLBZlH4+qBfVQYIX3a3zQbH+Z/d4ira74R3wRWOgxK6k01lYTPWGwY?=
 =?us-ascii?Q?SEc8QZLzl8fg+FUHt6xtOXhAJSgeMSUGWR0IdGu7TFkrPLAH1QOlBn8QaxgU?=
 =?us-ascii?Q?HO4nWQoaIIwKVbF1UP5yvUonS0iDbEJyslDOrziowoT8PXdusBTrlJDPoNeO?=
 =?us-ascii?Q?4kR5VCmHV29AGx8bScA/dKhTz7kenT9xzngDGyj9DTq1LL9640GIluay1uwN?=
 =?us-ascii?Q?EMWQ8dHVIiRK94E7SOjJa7JQ3kXLYNbkH4NZcbWVKlBVVt5OMJPsbuChZVeb?=
 =?us-ascii?Q?putR6avvQsE3bNxs+SCoOomi/KLmoIj9F7mNzY3WLKn2efZmDPvVdw8u1dPg?=
 =?us-ascii?Q?MJYwm7BGxpG2bWASQJ/CicDflhzUlIkBGReyLP8wfbl5nmOVM7bs0Un2R823?=
 =?us-ascii?Q?JZVaCphW1ZqP1ibU77lhxXG0hvoSYqhH6s00e6SZNth0hdhTeXjmuU+tCnOc?=
 =?us-ascii?Q?UIzZ5P+9ZxYMhtHcIN0rY2NEv6fAU2a9azr/fXpJ3xArpPGH8bZeP8nINnto?=
 =?us-ascii?Q?YIO7gJ73ukPYnIPuvB+D1MFmFG0xycUzfvgZM0QZPj6CRXLEADW/IuLP7/KY?=
 =?us-ascii?Q?CxiyImFZABkVIYGmuSW2D9p0Dr8KWdeVjFK3EufW5+t9PkfKUHGg/q9xfAAL?=
 =?us-ascii?Q?SodxGbSN7PEEOWvoQqcCnABpXLAByIMUOGpTmBKiaxMqH+278uuSv0ORDS0M?=
 =?us-ascii?Q?HgRb1lAoOqulTh8smbkP5FUFVmtQ+YxHXR+LheHuiH1OY7iiHAPUd556IWFb?=
 =?us-ascii?Q?yR2NcVN0jyEHGRGHra/v4S/k3x0jxghByHdfjV3liSb25c1doB/VX3juE2A/?=
 =?us-ascii?Q?+bY+BpDlJd/Z2Mg7QA1Y4/xgn36i8eja7Pqn2NtIE3vaK343lOUBeaGTO9h3?=
 =?us-ascii?Q?PL5g+IIuEo4E+b93L3qQV370zwCY291bTHkysMndKicJq/7SrroRNrtUGftR?=
 =?us-ascii?Q?LYj+QA5bZLkU7vmVSNowOCHuTDhidBwwrAaVwHOsKGvv6Xcc0KcK2EHDgE79?=
 =?us-ascii?Q?wiQc60hYRroEikvwTI/nKPHbGpYzSE9GSF0BVewDHvg4v0BO5DG95gFTrypb?=
 =?us-ascii?Q?17/N0b4AKAK2wczF4MERiz+Rk6yGfOchmq6EEhlpjhQTm7XzoKXxpiqlzGKF?=
 =?us-ascii?Q?8XJEREBdr7wMSuklhqkco/UmRPWWWtFNKuJSc7ZSVDERAGsfxQwjdH1+ugV/?=
 =?us-ascii?Q?wtLBYKxyt0bJrLpzyu/aiU1SO3g69SMyRUSG8mMYkfp5TB4ZnbS/x29HKvv9?=
 =?us-ascii?Q?EA/iHEDeUgCCzmc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:44:47.7391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c2ab8d-a81f-4601-b86f-08dd54faeeab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

Instead of guessing a port and checking whether it's available, get an
available port from the OS.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index d879700ef2b9..a6af97c7e283 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -187,18 +187,11 @@ def ethtool(args, json=None, ns=None, host=None):
 
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


