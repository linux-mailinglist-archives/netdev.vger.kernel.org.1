Return-Path: <netdev+bounces-247125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A0CF4CAC
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84F5305BC37
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC2332EA5;
	Mon,  5 Jan 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wx6DPRqx"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F21AB6F1
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630837; cv=fail; b=dez7gDRaeAiG6s1IGprwv5eE/XoVscb3RNVPXIsQBBzPgHQCogrcaUerw2+cEVfd2m+0JMvvUvyTvliC77ERWbEdwa1J/GhGB6usUremwfIlt8kqWJiZrmYLolA9FupIQ14Qp2IqMYz0o1gBpDf1E92/fTi2fHDQ6F/fo/gPyRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630837; c=relaxed/simple;
	bh=9z+PSjH7NzefP0gYkjKLQnS7+TcMAIaeJO7z+wtp/1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUEAICaRGYlOTsrcBAaXj3SZCzUZ4G3h4pOiO+dJA/5I2HLSVqE3oLCGKUUNxyLijShpjUTdNE/Ts4LsTTfJ0bq2QBWZWkqbHgJR/iWH4panALREV++3NF3xVYHlwbC9z7tWqUJEcPexu0Hnz2E8As+h2vN1LO81C13SvZGQkfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wx6DPRqx; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1oR+k56uUUbHgmotQqZl/uw/xHXD9EMS/GeLaogVPA66yMWP+1CBBCr6ptD9NNDK96JKh+R0VUai/+cjE6gzJ1m5bNrVulGdjUZrpk3Hs7y5My+CIDUHB4YN0cHOIG37ruUlevsuZFfOY1WTM3F/QNHQYxGlcqg9JPXsZM3oUWWYVaz0E/n+Svjsf797j8B9/hkcP63QTZtJJg+PnU7/1Kjx4DZYMwOa60mKlYiBVWmyrZ6vBEMU8PfDJJR8+ogSX5/M6ETDUZKdF4yjiRq4faNQ0WaUex2+Gjn1Tzym/ifCvYZ/7aGgh+UtTW+2AfMLvhzU/DIC29NZmh4OJm5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1apVbP1aGPTX12YLwY+KoO7Mz0GbROc+nyOjR8wUGvs=;
 b=ldkUOm/0O1K9mrxYxSqKq2fkM9cg3yLcgyh1HCdbYc3zoyFDjBc6Jz7PsgDtEbS9hV0agDYGMPAhnZSi/k67ly3Mr18eTM0p+VM+/0gkJ2+oCKomozSESdvSG/0qIMCOhw8LUPwUAYoZjAVkziYFyz5ewH8CEQHGxP0vLuTWS1Aa0qn4J/tKVzYFBZy4D2KvEpOFILqPUJNHPK4i6E1ClnxbKibhi42HVUo9dP3qEDKlsmyzt23mUl67Y/+m0XJMOg+7wSop/I/RWG60epGMmR/3M8vlKvnR7A3beL4LHHjlvLVHlgqV1yixqzzaxu70M0S5NLX0WlyhhwVfmiEHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1apVbP1aGPTX12YLwY+KoO7Mz0GbROc+nyOjR8wUGvs=;
 b=Wx6DPRqxo6gvl0W2c1Nc8eVp8o64Z0W/QFgdmjpNNooTFqyENDz3PJISsuRcXv2iIyoxCshYhKcadJWwp6XcsVFpHf9BXxGtns4H+fzUm8OWnBSlTqc9US9a2RfMknvU/cjcFgwbUSYtkar+c1xVzMDKtaQWEOHAfCrgxfRkE1VfZoTTUOms8bVMQAmK2Tet4Mu/cR6WsafyoKnphMQ8SEhnjz9XpTAr69UZn0WXGlL0TglE4jbPENYme2j/U1l07jrjjgJ3r5aYa41Ss3DJqnc3FPaTVJ763tl4OcCzhaiRJPvch0OEHZ/cSu7JM1eNJrK59P0kXqXzRdDxShNhew==
Received: from PH0PR07CA0100.namprd07.prod.outlook.com (2603:10b6:510:4::15)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 16:33:50 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::68) by PH0PR07CA0100.outlook.office365.com
 (2603:10b6:510:4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 16:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 16:33:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:33:24 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:33:24 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 5 Jan
 2026 08:33:21 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, <linux-kselftest@vger.kernel>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next] selftests: drv-net: Bring back tool() to driver __init__s
Date: Mon, 5 Jan 2026 18:33:19 +0200
Message-ID: <20260105163319.47619-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dff65b-8687-49b4-152a-08de4c7833e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAr7SCOP9coLEpL6XR3xFcaRfGr+LHi15A65Ug+yK+4aRsUWbV/+fPKioEQp?=
 =?us-ascii?Q?WkpyEI/ui13AFHehDchTkQgeLqSdMbM4tF+6aid3aS+q0IBR5hrofTNbLl5E?=
 =?us-ascii?Q?QNcpUbRMPapc9/ThZU5mmRZbyr4Wg2GGzNUaF8r+5GSu3CDvRA35DXPjvYi0?=
 =?us-ascii?Q?L3Wrk8Qs8ZhvS/QF3ieueu/Uzjkm6QLnOtONKNMhGenCYzcCBvxg+NdChsP/?=
 =?us-ascii?Q?R+omE2du3cNw1nBtqMDIxctvC0uiqFD43ZjSNt2DiG+qr8WdYbyD332Veg3U?=
 =?us-ascii?Q?YPQmPOOyNViGqd+ublm6z8lATTIUkDHF0zxrItqwjk31rLCJnjuAp8Mi+0Nu?=
 =?us-ascii?Q?85VmKGIHuPZKcLCly//k0mPGwWfTpzC3a+Lz/aZKxbxJI792OdCLmsPAOblK?=
 =?us-ascii?Q?D2ZAJG9IjiUdKXP1rb+WiFAFGus0fcuSY5xlOyBx41f8oXZQFrD/uV3wCaoE?=
 =?us-ascii?Q?BspumVPUYn2F713eBTBBnOCeg03vpkeBluM1F5yvyDqI0EE50TWAn8G5cHoa?=
 =?us-ascii?Q?ySSTYz1c/ReK6RAm0Lb/i3eTIiO3Wo0P4dRulUV3pwDhiSOEiE+hOMOFmTVR?=
 =?us-ascii?Q?KTXR/H8uaF4pHE5lCMwxIxU67uh/qmEX2p5UJr89g802rN3xHm/lxEgBFUkP?=
 =?us-ascii?Q?8PKSKMaZFK442hozOrAhxzgv5SLCKQZZ2fI7PrRdNd0dXpWsu0gM+FWEe7yf?=
 =?us-ascii?Q?/xMAYoa1xT/GUM3CjXpS0dkk0MheRiE9LjRyvLCQ8qk8eyDpoptVtulTMFdF?=
 =?us-ascii?Q?itzb+xigVV+zbEHxOTLWI0WXVs12zqu0owzgq2NFDuJCbr3QVzn4qwo9pqQJ?=
 =?us-ascii?Q?BYZih8A2/RWueKtpM854ayZDoum5B9bdtOdKfW/CGcE3lBinQSGaU+KcBEAi?=
 =?us-ascii?Q?UZTucqNvGSU8CLSG8gALx9iQ8gNLurG9e2SbB1HYb5930tPVBBCgE13AvH6H?=
 =?us-ascii?Q?tB1rOpCI4K0+HLn6S36rbeiJBHn8DQRlIy+NFOLU4RA10380rmvo1LXQ6OcI?=
 =?us-ascii?Q?+c18wQL8erYQmxlNT2074sgC501LZFC6e8WqwrOlTKpF0QHfl1gATF+YCUxl?=
 =?us-ascii?Q?HL0qAMp9zaO/FPobVvicCqVm02TzsMPAqO84qPpgT2J+iCIC+p/qHxpxrGUJ?=
 =?us-ascii?Q?z2DmlAE+ivBq0rmORuTlE8peAjg46mbs4KD+ttJRicR9CeQBPL4cs92aRLau?=
 =?us-ascii?Q?o6wIaWViva+coj0XANzXY3hijYMQRclDUZCTXbuHy92OgkFtu17rXHJ+Q7gs?=
 =?us-ascii?Q?Spjz7++twugHTKkr0ytT65SXBU/KlVqR6owCD8h0UE8djli7m+tDVoUJw+qN?=
 =?us-ascii?Q?kMS6vlKaP52potw0qQ3RBXCB88opIf08VK2rus5osezhz7Llaj07Djma6zYR?=
 =?us-ascii?Q?G9xL9/j0TyPRmf5VxKTltSI7hqV5EuJtWFRgOIjapxTse3Rq4bauARr68wfe?=
 =?us-ascii?Q?puawXdHBXdEDkhq1VoTSevyaSusBIAHA2eALoZ1gplqkDwmVF2+xgGTr1Tl5?=
 =?us-ascii?Q?Eu+fNeI1jbxgKDMkW1HKf9HRX/35hCDEsa+5x2Iwf6kxRQw3XX25B6umvFyN?=
 =?us-ascii?Q?jutEC1Pe3vre/RZSPc0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 16:33:48.3287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dff65b-8687-49b4-152a-08de4c7833e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

The pp_alloc_fail.py test (which doesn't run in NIPA CI?) uses tool, add
back the import.

Resolves:
  ImportError: cannot import name 'tool' from 'lib.py'

Fixes: 68a052239fc4 ("selftests: drv-net: update remaining Python init files")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/lib/py/__init__.py | 4 ++--
 tools/testing/selftests/net/lib/py/__init__.py            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 766bfc4ad842..d5d247eca6b7 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,7 @@ try:
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file, tool
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -37,7 +37,7 @@ try:
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port",
-               "wait_port_listen", "wait_file",
+               "wait_port_listen", "wait_file", "tool",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants", "KsftNamedVariant",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 40f9ce307dd1..f528b67639de 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -13,7 +13,7 @@ from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
 from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
-    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file
+    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file, tool
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
 
@@ -26,7 +26,7 @@ __all__ = ["KSRC",
            "NetNS", "NetNSEnter",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
-           "wait_port_listen", "wait_file",
+           "wait_port_listen", "wait_file", "tool",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-- 
2.40.1


