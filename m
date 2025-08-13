Return-Path: <netdev+bounces-213284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D1B24611
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD981733FC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD262FD1CD;
	Wed, 13 Aug 2025 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTRsgWwu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395812FAC09
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078361; cv=fail; b=mH18v7PdQ5doSuc88SDlQRMafNCSRE4Hln4S9Xa4D3n8HPpUkszr+aUappw4og5h+xttK9n67P5lmj/f84VuV5AhxzI18FzfaG52w0dVNqVvgjxUGjPTDU6RlpAhQyc8i8DdAYPmKHG9AfH51WwE1kp9JbKAbIPWIVyWTbnweCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078361; c=relaxed/simple;
	bh=etMD4ojYPKMIq5zxiC3PyOtekvfoqzl64SCYKWthTY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7vW0NPrDu8Ni27Ngj2z6y0Hm953fkz4eXUXsPb+XIqx8F8s/jnXcGZ78JA6q2tl4iI54eU7gcHnRDibVc5NSJPpyy4VJp3CgMw7zBeRSkiORoTzIXnLBOXPOzYp4HjEK/98/YbH2kyH5rapvTCGH+WVRovpmRb5Ynxfos+11QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTRsgWwu; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6teOzSDTXCww0DN5WfW00QvWxAOwi6qpp3vK+rruQ6Y1aEyLVC5xZ15fn3EKN9Q5jSYsoZ6hSWM8bUqiQAco0RSoeVSCntQic9VSK3IUKPVRT7oPE78ApRtf5v9CIfUC5z10GFmFy2Bm57caVw9Y4octCyr+/hzz7foVaE7Y9/XzuOegYEMvHsVKGnNbLsWzUO00vy6FPNQFiWVYOuTgFy8g0k/RtGwsTYcAWIwBe3C6Bqfh6IKWFHqfIepEKB1RjIPFZzZfmWO+fGc+AAvN4oV5m0TB1k2J91g5WpMNsC92YDAbTeekiXtxQeuNOTcJUAJo4pjJFRQwHDiNEmCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6DvFu/JbDBkU7v/MLQe5CuoU9GdwQiHs4LjnMIKtJI=;
 b=zPMbRfMnTM+RqQ0I5f3x6MHrqZ/U1Id2te6mk6QPD/lE2wJR6cZkNdH2mP6Q0oBAYOTmAOvUCuJko7NLCS5xBveGlKj1ysPyQG33zqyfV4iFUMr0l0DRfH4JONAh9H6LTaNV1c4F4gCeEi8KqvByCAQDKtKEcxONoNIw+/KcZdbx80kAafMyNNg5HA5HVp9af057OA3YTOIzwMXkaOsTpgiO2XDCGsopO+kgXUm4U6trsXWnnEIB8z+a/6gs7RaDOiCP8rOr200knbqVmv9+pa9Y1NNsG/QdnZnU1y8Q3thAzjaExvaJpy5PL1qyas0ZrS+/zNgedczcyepTGzPThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6DvFu/JbDBkU7v/MLQe5CuoU9GdwQiHs4LjnMIKtJI=;
 b=WTRsgWwuu97rUl+FQbQaoBgIQ6lzd/imp3TxCdXdlUj6cxR0T94TBYlwXXjx/sofVWxUs2Yqj8W/aC2KDYlvk3R9nUFele7kGEWbVQJMzTqBTUSovraGs/OJg9Nc88FAkSVOtLMcqXJawRabf8E/7D9GWe/tnTp6pmvl0st+n8Lla0Srm7N60b+grch3725ArHaFdX3DO5pDY5UXb+L1lRoa1AU1KH2KsmGssQSHGok3qHU7dedBGw3FDDrKGZd2cfD1FVEkUgosZMWGwts92RzqDt1EdNuE3hrwXnunmjE+RWzS4re+7BAl5jSYfGHaovNm+KaNtc1wfak1+G+JKw==
Received: from MN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:208:530::16)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:45:56 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::69) by MN0PR02CA0015.outlook.office365.com
 (2603:10b6:208:530::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 09:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:45:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 02:45:36 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 02:45:34 -0700
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>
CC: <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next v2 1/2] devlink/port: Simplify return checks
Date: Wed, 13 Aug 2025 12:44:16 +0300
Message-ID: <20250813094417.7269-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250813094417.7269-1-parav@nvidia.com>
References: <20250813094417.7269-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: b337c06b-1660-47d6-fde4-08ddda4e3330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?smRUiKFUVPvmR76KBCn2fp3S8y4TtzcH7Ow73en5lCVPK0HIZ72WQJjkTB/Y?=
 =?us-ascii?Q?bGc/8q0qLcXfdWlsYZxAjr47YlBUV2YnZm/RgIpcDqWysJHT51axmYZpy0u4?=
 =?us-ascii?Q?X8bcP5HnmZ7uBtlV2MwM1kcgQ/28LN7O05AeLe17xkh/sPbaU5dlqT7ojQ27?=
 =?us-ascii?Q?rHfaQ7ZSWrDfcUX6DV196FrpuHm+GkvNiL7V6EvApAHtZsS60CfDAOvqR7/r?=
 =?us-ascii?Q?DrW8noi+jxXBfTPw48iF2aTvyOxGY/2Rqlzx74AkQ1kXWKjheteEQ12KqFIW?=
 =?us-ascii?Q?bNjMPe9dbW1jUTXvlvuchOlHCk0u6PhxmKytfiq0fnvo1GC3BIpplvR/Y/+y?=
 =?us-ascii?Q?W4EhvOWX+SPQ/P8ZK50IctEsX5MhEtlyIf0pFMqERg/vwjUl7WwD6ZWoWP0L?=
 =?us-ascii?Q?hzvkjOQMSmQfJlnFrC5TGdd47LklnDailelpDkj0QMN8iEKnKWKU7Ax+BXuJ?=
 =?us-ascii?Q?Z/M9U5uX4vvGETXqSGPkYg/+Dvm/TfZh2rjkVRtrDeJ/me3GA83uFStauL9G?=
 =?us-ascii?Q?hT8d0G+jWtl9uL9GRpeQ29veICpviax8rMD4BSHIRCWL3tKu1R/A7Y/qqbdC?=
 =?us-ascii?Q?JK/oeFsNweOQV9RjNGWBbRhcFeLtNToKDkwiDMAraR62XTn52I2AsAlebh+v?=
 =?us-ascii?Q?1h1l5uQ2NZOb5BHEkx0OLvQTISDfQr+LyE0Y8fohWSuRxZBk1dcnwptfSqi+?=
 =?us-ascii?Q?hYHl8tV1+KjwCOA85Qod5sSIqxVk4aexJaCurF8lu2puAtdXiBxpFtdFXRLl?=
 =?us-ascii?Q?0+5LlLbpEQ7+0pHk2mSmkgx3OaMgA/406QXuKFh0f50FaYckCigbVIYRl8Jk?=
 =?us-ascii?Q?GYhppG16uGYYO7jYIaRcXJ0nFbeJ601Y5afbXyvrNMvGV3LCxBhX94o895Xq?=
 =?us-ascii?Q?gnr6jtY9xTFNtPOv5RX6Nad2Q14uJOQoMNuxiglY2MHl1a9FRFNqRKjOcCmY?=
 =?us-ascii?Q?vNS7HsEB9qiXMHn5kiUx/9wci4LSiotyur8bEB/QU8SNN3Tf/9v0oOsgCzcn?=
 =?us-ascii?Q?QgfwMxAMmVWq09X44MGI1gJkiSN9bKJ7PF+MMpOYhbablJAiXDjorEAYWwax?=
 =?us-ascii?Q?ZWu249ru4ZDpjfm1yUccAJISZzA51PhdQlSrCkvlW3Gp40oszn3Fru7dL60Q?=
 =?us-ascii?Q?sJrKgkTlU/FiRH9yafu63AXWSr7r6lEeBfJ2hmA1yDJ2FJ0sQI7/tyJ+3TSN?=
 =?us-ascii?Q?5QFNaNaoHXgqRIIsWSos18iYmLGxipjannVSlfX0+z6VuIhd6Jl0Tjk6S3gs?=
 =?us-ascii?Q?RxiYsEyyOAHhHG3cgiWLRhqfgdrRLWrYDYO2WUSj+VHS3HGdf9xi0Ty3I/I7?=
 =?us-ascii?Q?5lLTr5SlcQi7ycOml9L9GRMu0xHdCJ2ju9mt+xnzYEYnIVnzFfGaxPrDp95p?=
 =?us-ascii?Q?t0ucZqdNw0yWmd0dbHtJZj/Jji/Esq1lsQOW+Mpm+UWo3EHIPVLdVx45yah0?=
 =?us-ascii?Q?/AiOlkASmjYO8LE3Nd5QkAda3xHRsdoQUjnNbTjeqfCf6MovBD5Ng7Gy8Gqy?=
 =?us-ascii?Q?1PmMijJEpkLLQxn7+iQQDZCFm2olZfcljc8dC5Llt8RboUtJwR/EV7G/oQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:45:55.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b337c06b-1660-47d6-fde4-08ddda4e3330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

Drop always returning 0 from the helper routine and simplify
its callers.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- Addressed comments from Jakub and Vadim
- changed patch order
v1: https://lore.kernel.org/netdev/20250812035106.134529-1-parav@nvidia.com/T/#t
---
 net/devlink/port.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..1bb5df75aa20 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1333,8 +1333,8 @@ int devlink_port_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
-				    enum devlink_port_flavour flavour)
+static void __devlink_port_attrs_set(struct devlink_port *devlink_port,
+				     enum devlink_port_flavour flavour)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
 
@@ -1347,7 +1347,6 @@ static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
 	} else {
 		devlink_port->switch_port = false;
 	}
-	return 0;
 }
 
 /**
@@ -1359,14 +1358,10 @@ static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
 void devlink_port_attrs_set(struct devlink_port *devlink_port,
 			    struct devlink_port_attrs *attrs)
 {
-	int ret;
-
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 
 	devlink_port->attrs = *attrs;
-	ret = __devlink_port_attrs_set(devlink_port, attrs->flavour);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, attrs->flavour);
 	WARN_ON(attrs->splittable && attrs->split);
 }
 EXPORT_SYMBOL_GPL(devlink_port_attrs_set);
@@ -1383,14 +1378,10 @@ void devlink_port_attrs_pci_pf_set(struct devlink_port *devlink_port, u32 contro
 				   u16 pf, bool external)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
-	int ret;
 
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 
-	ret = __devlink_port_attrs_set(devlink_port,
-				       DEVLINK_PORT_FLAVOUR_PCI_PF);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, DEVLINK_PORT_FLAVOUR_PCI_PF);
 	attrs->pci_pf.controller = controller;
 	attrs->pci_pf.pf = pf;
 	attrs->pci_pf.external = external;
@@ -1411,14 +1402,10 @@ void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 contro
 				   u16 pf, u16 vf, bool external)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
-	int ret;
 
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 
-	ret = __devlink_port_attrs_set(devlink_port,
-				       DEVLINK_PORT_FLAVOUR_PCI_VF);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, DEVLINK_PORT_FLAVOUR_PCI_VF);
 	attrs->pci_vf.controller = controller;
 	attrs->pci_vf.pf = pf;
 	attrs->pci_vf.vf = vf;
@@ -1439,14 +1426,10 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port, u32 contro
 				   u16 pf, u32 sf, bool external)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
-	int ret;
 
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 
-	ret = __devlink_port_attrs_set(devlink_port,
-				       DEVLINK_PORT_FLAVOUR_PCI_SF);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, DEVLINK_PORT_FLAVOUR_PCI_SF);
 	attrs->pci_sf.controller = controller;
 	attrs->pci_sf.pf = pf;
 	attrs->pci_sf.sf = sf;
-- 
2.26.2


