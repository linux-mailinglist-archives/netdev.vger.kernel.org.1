Return-Path: <netdev+bounces-168117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F724A3D8D6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C483BFB06
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FF91F3BB9;
	Thu, 20 Feb 2025 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZUhx3xO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578321D5CC6;
	Thu, 20 Feb 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051329; cv=fail; b=hhIYZufiLLN28zIiLTLohqc1vvsmhmGimXVHBJTKkronpDmdSiAJZPIUAnrFXQEDnddCUsfHKBFi3//Gq+XksapMMiAZkkpKaDrdN+UNDp5oKIlLXSwv0FZvtPLTYlqfW84jOTmk6nZ/ILWhBptx3jejgvzsZsDUINPtRs2GLHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051329; c=relaxed/simple;
	bh=NLkYE5HOT7xJwAeeFKTm4J+gC1LcB3xmVMoNtrE9KJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvrPpZ+YQJvcAZWS6y2+X1rWKNxheR3llxKbwSborjDaQ2L2/puKbBBSrmrr7aDLpv6AF+meq+TI2JIGiP1elTSDpeJIbCZT2GUN+xCLRMzd3wDlFXZCXm47vXniBeVI3cWmQJ2tXIGcco2sOO2eHHpeKOgk/sKSvn68mQGcTEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZUhx3xO; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq8BhUMpX5HgfkvQ3yPyF1hYjE7frQakkciWxS3WmgyOoH5mPpKEFDXDUyizivBk7vikXNp69mYrs41qLCaoUTMz7IQ4nG/I0fR6XMWXAG13Lme2vLXSZSTi39c+pTI7BP7NnE39eS0xRhs59zSlA7geyusruIgPW6tmRQDL899ZRwLuiYVWiAdmctny3YImIpUJdS0amXjiF7fNdK5ukzWFpB8Onc6zWfyJCKovAyE/aSq8oG6gxSACHyYgSUvJShxTteFXXZ0caKxcE0gj0yuC3Rwy9lxfAYHILUN9CXdyNlpqZIPXDPsxyUF8I/pcBk0hhRUvU6uza0UJe5FeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs2x7GsY+Q8mv45wh/hP8xsKfiBJPgQpO0a3QQd5LRY=;
 b=k9wQXSDF42ggxHzSVKkneKUyaher3brtASBLGqokl8P49B0aIEnIn+gPo8DNTLnOzxgnz/77/wjAyogMCHBVWnEr5ENc1+V3sGu37+tKYwdPYGBWdoHpPS8MRiLqrUUb9KnJOtH2oQuOl4jKFquxlcawPfolSkAHDomciFg6xezO9pG10RhJKNMXesLfhkIO+63Y+rj76BOxmZB8zgiaRnhtyllwqBJdPtelJG0wNYCXeA9XOuQwR+RSDLO555gZ3uYeLGflavjOGg+W3ocwKLFxzZSkMuD+x9bcOM7j6G5XGFtCan6FaDgZpLf+omxAlZ0rBF5ngFvMNCqd5UWUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs2x7GsY+Q8mv45wh/hP8xsKfiBJPgQpO0a3QQd5LRY=;
 b=kZUhx3xOOSgoxuRIQzbuWk+JzNPoE8bF0u6fZjZN/OXGYyoohyRcbABYKdpJBNQNj+0NdjQZ3gVyTvOjcTKalGliMR3WPZ0IpLZibZnm9bxPBUHd3dJkqADgoIV2hrAtE7dKUagk/BWVcn11GlQlaYb5wvF1sVmzkb8CDkccxWKYgqrsAY/rwx/1MSXF+IoKNY8o2XetNOqTB8nKunpnV/Fa9q1I0Uw2EbXZuO51q0oxCDc96qOncvifOMu3kttw+h+op2l15jIEWhGChLJX3eEhCUrbtYw5iNiyVeZn3ViOc3Syt6+mH3MDC/SzPhwrzSfEelJAf/1OWYN5cRWZAQ==
Received: from BL1PR13CA0177.namprd13.prod.outlook.com (2603:10b6:208:2bd::32)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 11:35:25 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::c6) by BL1PR13CA0177.outlook.office365.com
 (2603:10b6:208:2bd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 11:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 11:35:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 03:35:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 03:35:06 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 20
 Feb 2025 03:35:02 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v4 4/5] selftests: drv-net: Introduce a function that checks whether a port is available on remote host
Date: Thu, 20 Feb 2025 13:34:34 +0200
Message-ID: <20250220113435.417487-5-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: e8789825-2057-4cf5-1d06-08dd51a2aa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04fqBDnhIEyIQo5HPKh0d8akyqJNRvv7rGfGc2K3o6ybwPcq0JAyZqStuNXq?=
 =?us-ascii?Q?qTzPYeRlyTfG9ReCozkCQTMVr6RmrSBEeY5GEmvIU+gM0Y7LZO2D1XUgfjDa?=
 =?us-ascii?Q?k9Lr4CnIWU1Dq7/va02ObW3fU1twFiPVDKqrqbXaOBqdU3tM9w6jHORoS4n4?=
 =?us-ascii?Q?fc8mcHhA3LILwiyqT2jBOQ6RkBy5C0L9v86SDWoNqJyuAjW/+iCWKLKERvii?=
 =?us-ascii?Q?kJgIv72ygRh2//O4hD10t3pixZFzKUEasdfX3R2EpeUYcJIZQ1Ew38PGbF2m?=
 =?us-ascii?Q?Qo0Wrwlighwy5YCci+/4kT2eZvi/pmGpHLwaYV/Kg+hJXPp4ZAsrT0k5nVJS?=
 =?us-ascii?Q?YOR/Z+b3yWKYgPXWyaccK9wThKAIXQl89mRI0pjB036sLKQPBS1myCR/6P7U?=
 =?us-ascii?Q?bGRFvOa593ofPHUeYmlGlkT1Wo91kkjHS2DZGd+l8c5VeFL85POT6KiEt3B1?=
 =?us-ascii?Q?4NlXV0xMlrBMii3xQgPsgGb17tCUsOGPr0m7dVcVkP4yqsoF4h9gkmdKayb+?=
 =?us-ascii?Q?urjoOhwOzO3r6ZPlPZos3XXyIFxQxU+f8XM73fHqS6sBUr7mZV+qsqzBQ0X4?=
 =?us-ascii?Q?a0Bk7ksJNsP4tidpI+XqjOs9MySC4DdhizlipbbzEBueAj0OsrAHpd5DClES?=
 =?us-ascii?Q?5bEOKgkdR9q1ZOCeAw/Djl3qqxUAukUNMMLHx9F3vb8X6udT6phJxE4+Rbn7?=
 =?us-ascii?Q?lkOeI4KhTZDnpuloV5BpcPQj3NnmNLZpuf3SH7NbuPa+wUeF1mUPFTNirEef?=
 =?us-ascii?Q?wKQfTWW4DP9xgS+NNozR6tZvn7z+B2uoQoDITuoL54gaO8F08PBjzjDcRrcu?=
 =?us-ascii?Q?Z9lEZFkj+O4Ha050ZwH7QfhX6aJvrt8+BN9WNIDhNz09J0K28cQ6cBiu7CPK?=
 =?us-ascii?Q?iSndS1OLgk+CxRBa7ZRSvakOqgfHNy0AN2vLqDna7hzucVwkL4oXKcYmCqog?=
 =?us-ascii?Q?2ynk0/vxHllRENVaA+h+bRej98KAOFyGuEi/TMobUlskkleFzztcAhoiEtbU?=
 =?us-ascii?Q?lGlS9nBeAndzSfcnTK1w2O//NZrgudpGrDY3N0YdFouzI60PXknByZAEs2yP?=
 =?us-ascii?Q?eUqQja2fNtGeia5lkmM5+OOwbZ8/XFiyrDI4NWgmwbPcHRQtMYojABD21ChA?=
 =?us-ascii?Q?cI0P3czm+A6CtodNs2VWXRM9nvA08xOzB6mJkJTlwwQSaxmvprstkvT+fmFA?=
 =?us-ascii?Q?wrhmOrph0Xh6rCmohH2TK9U/ALGNP3MjjnHkodSwLVJ4mxOYpV+t6DsoH4xg?=
 =?us-ascii?Q?Jl8MnXGelsiOgblY9JFFJ+UElBt/wZ67uaViwzeZH2PPbCzwaGnw+06zlji/?=
 =?us-ascii?Q?yU2pNWaiBUn7Xg1dzQY0i+TsVSYct2Q9IQ0jeOXE7eLdgUp5omN87DCc8yLY?=
 =?us-ascii?Q?Wfv/VWR18f9aGgDhTvNC4DRe+dspS/Qbv8ru1AHmBD49XsNY4rZmYANMLFKm?=
 =?us-ascii?Q?/oaxVlGSFjgLm6oQS5LqwEKzNP+C6mJ1DIeW7Od1SFAJx3SrkQUVmOxcWf8o?=
 =?us-ascii?Q?FxY0KDzzCcE/x40=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:35:24.1980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8789825-2057-4cf5-1d06-08dd51a2aa87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

Add a function that checks whether a port is available on the remote
host, this will be used downstream to verify that ports that were
allocated locally are also available on the remote side.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 5a13f4fd3784..903cc042ed0e 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -123,6 +123,13 @@ def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
 
+def check_port_available_remote(port, host):
+    """
+    Check if a port is available on remote host.
+    Raise exception if not available.
+    """
+    cmd(f"python3 -c 'import socket; s=socket.socket(socket.AF_INET6, socket.SOCK_STREAM); s.bind((\"\", {port}))'", host=host)
+
 def rand_port():
     """
     Get a random unprivileged port.
-- 
2.40.1


