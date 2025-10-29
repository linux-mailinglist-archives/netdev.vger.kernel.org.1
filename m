Return-Path: <netdev+bounces-233975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D674DC1AE8D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12B585A1DDA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B96334C36;
	Wed, 29 Oct 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QhI0WtG4"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700824BBEE;
	Wed, 29 Oct 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744203; cv=fail; b=PBAgRXYLfgcP1tzDlzUZcYNLNkfjwy2kUrsPoZDv5Yn3FFkoEej2Iku3fGbk5NVuB8LZw/4mZHH7300zi62e7KVmoIPCkVKKrai2cDHGSusSaBQf6Xj9VZEODO6xSh6KsOh328cYCVDpOsRruLYm2PP137c+aAEsTk9vofd5pu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744203; c=relaxed/simple;
	bh=gTXtZBP0WXapVLrfDNs5GEZpqzcRdv4A5omaPatxdGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sG7o5zV0Y4rO9+0nxpHteJ2YfY/3KXAPSVt77gFuRorYlrgDCAtPiw1P9Hg8Uq4BrBW36WVa8cOqOpFL3yb18COrch79S1cw6t5/MxqrawS1WHrC/3O9s/uaDLGQAkH3EvZSAaGkPa0CfrKxFGOXIO9K14++ImKPrmV49Pgi4v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QhI0WtG4; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0cvvKc800oI5dCvKKBAM4KTHQWuFbXdrpsQvth4esJu/OT83qvPcj4d72/kxCdryUhykgM189SQWVtJVSNy1xfcQOavzw34q5Oeylp8BO1CjtBZXqOo/y+9AJbXj1vPBMQ7if7Beq5PBBUPvAAEauL9+uf8+mqaHNRPJWv+AkxvEqh1fiGE21snhXpJbtJ7yHPViUGJsiwtP7omLehM+RBFyBXnpHTQjgiooSwgD0t1SfoWknFEK6EBU4B/glSvUt8i0zeh5p6ZFR6oHLJI4ALLKAgffnVexYbJFow1oKGFYYX79UlvxKTORuXV3o0RTTJF7FXoy+5FKSS2KY6yBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSDz+8N9mv1hZLz6pp7/WsNrtsuB8oKPf3zOw/TSkcs=;
 b=g0CsU3ZtcrMm1ZcI0v5r4t791LKrBsz3Lzpxhmk30YY3T4749tK63s+K3LreYGgq/lTcqhGMLTyxV8mCGvQlJnVuQXl2A+xJC+nD9NGq84FDrwlv2q4lwF5dlsWR93UiXzJuuT4Lr5j4XebwpN3ky2MzVzg0F2sqF2DmvmhRbuQGLGjiaeGk6+T4cXyLBcSwyyoz8tnmQ1nKhoYmD0mt8mDGfR+dStctMoPoZIwurqYO6/KoNIvqOWZJjp7m+sgQUFP9jbgeqxm9sIg0jivRV6j74kYouE05Wrub3w8nZNdji5fwqAHOU2l83acV0bSIPrKCQhD2VAGbiSgMI0+CrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSDz+8N9mv1hZLz6pp7/WsNrtsuB8oKPf3zOw/TSkcs=;
 b=QhI0WtG45Vc21n/nhZDsCBPm72hMd21VxrNuZ7iWBxByfQUoUkz6ya+pHnMQhTMfu1d8JNgaanQwTLAdzGvcKJrTbYRuJRHQgviUIpCBAAcD/TSDgrTeX889kBUyhxWIsV7aqebB6oF5dt3vFUztzOkjoomUaGKqOU5QY78jPwY=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by SJ2PR10MB6990.namprd10.prod.outlook.com (2603:10b6:a03:4d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 29 Oct
 2025 13:23:16 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::2b) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 13:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 13:23:16 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:23:11 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:23:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 08:23:11 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59TDNBHO4055221;
	Wed, 29 Oct 2025 08:23:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Jakub Kicinski <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
CC: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3] net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error
Date: Wed, 29 Oct 2025 08:23:10 -0500
Message-ID: <20251029132310.3087247-1-nm@ti.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ2PR10MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d65d5b2-cfb8-4e8a-1383-08de16ee51df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?izTvof/HXTK+8rsRCYRGVsZ2Pjprl4KTqd4cY3OgQsBYm8b3V1JoK1hc4uZy?=
 =?us-ascii?Q?9Lp/A/MlYjf7wIm3fhUp+o4jpF9gAB1EXCk0k04+BqMvTlw+9wSw7yJuTKzK?=
 =?us-ascii?Q?AAWB/TbX5tKlmhGf4tMdUdfMF4kaaoLrkosnSkjz85tcVcmY2g7M/6HGDhXu?=
 =?us-ascii?Q?wpnZaPfJo5+WHu+ZBUL2rivuJ0ElJBWJn8uZCjg0yJtUF+smgTU5LUHZlJqV?=
 =?us-ascii?Q?owyZvJnKrFEy8XAH6ZK+hsJJIC6DhUbqyPf2bHldbI2bt0f/QVD/FGsaZltb?=
 =?us-ascii?Q?tJBnuRioBUZo8uBiY01G4DABLQAyxQXgkAhNlB454X2+RDHyLgPZAKpOZ+rr?=
 =?us-ascii?Q?MLNHdq2/+A98uGgy09NW4hwq66aZPzyr9bn4o/tMUeb0ZAaMPmzkEF4qMRn6?=
 =?us-ascii?Q?Ff8IZxzampUvdkg1Www6rp5ezKQDJHAM1TQXOCPHn5dIvET2id+qn0RZrh9+?=
 =?us-ascii?Q?7curCDJZ7iOAzqkAbL80pAfL+MuYRYBFiMRlUnVZLdxR9bITkLFnfpk+rSJW?=
 =?us-ascii?Q?iu7LT1v2WHOJ1zLBWUEsCnMQMWMeWAWTgtPH9L/z5Zl79vjaT1vuB7xB8Tpj?=
 =?us-ascii?Q?t0ZNOU4+FOmje4xSSiiQ9cIFBWdtb/Q+bz0lRBS5kaNmcB/gatYUqlwW9pdM?=
 =?us-ascii?Q?2CDSFIZbylwE8PMy9iLCwdJx5cpLpnZBAPYzUQ1nY0xDxwKPewwwF8Qw1QmU?=
 =?us-ascii?Q?7yB73Mf9VKFdCFw1tia3xnTeJs7XbWaEBh34oAvz1tUULql6xufkbi+n1GlZ?=
 =?us-ascii?Q?43v0V+vDYBqRkcMGMAV9XFbSLEmuzjPig05CRFvclwVFmrG9T9NfvtVNu2BD?=
 =?us-ascii?Q?ifmWqBMKnFLgJmShSBW3rc9h2qFvCB40h/x8yOLxc0WEY+cE/kFB/o2MeG00?=
 =?us-ascii?Q?1d9LHgiMLnwb7ipOB0iWXEByN7nx/rGZv647BKwH4SgmLNunlqn9eyUfE4Hx?=
 =?us-ascii?Q?bYrdoEjgYlLOONPwAkTSFXDCAZ7WqTN8N6TcrQ+B2BCgRNikfDwejf8+z9nJ?=
 =?us-ascii?Q?31t5La4meVbVMAgBEYErL2czHmFBTrRGhOhKFsmgAyAIfEIpKGT1A+8HMK8L?=
 =?us-ascii?Q?lAY5xBqXvnOAzbol3OMWzC5TQPFoUY3lwGh3juUm+s0ufnYETywqfKcW7QFM?=
 =?us-ascii?Q?0pKlWRz+Ldnci7vrhVvr0zdvxCZKI3kvoQ48rH1HSVPkgp+IbjCR0DDDLZY+?=
 =?us-ascii?Q?rfi96l4PpzuVSpcPalCvCQh11bkovTaDbDpXEogrAx2Y0XDpGaZPpE5/tZsz?=
 =?us-ascii?Q?qkOPxZ1V45JFllc8j22JtPBREcnL8DG9Nv3z3igO/WWxfr6atrksTD0rDYor?=
 =?us-ascii?Q?cbGTfftiDL6dQkaY93P3XO01HjHuxw6445EARJdzQ9FOJMlx9lR7QNac7Hx5?=
 =?us-ascii?Q?86sxPL31PhSmWW7GuNIoEhKFbCwgfwQLqXEg51aiGoLhjvGgUgDZCDul78c3?=
 =?us-ascii?Q?c3bP0h+p93uwtMZ3040zF3OQoNvCY9froV/cWcHHLbVQmDL28FNSvBtzHHnm?=
 =?us-ascii?Q?hFvJl29GNhgTuRo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:23:16.3744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d65d5b2-cfb8-4e8a-1383-08de16ee51df
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6990

Make knav_dma_open_channel consistently return NULL on error instead
of ERR_PTR. Currently the header include/linux/soc/ti/knav_dma.h
returns NULL when the driver is disabled, but the driver
implementation does not even return NULL or ERR_PTR on failure,
causing inconsistency in the users. This results in a crash in
netcp_free_navigator_resources as followed (trimmed):

Unhandled fault: alignment exception (0x221) at 0xfffffff2
[fffffff2] *pgd=80000800207003, *pmd=82ffda003, *pte=00000000
Internal error: : 221 [#1] SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc7 #1 NONE
Hardware name: Keystone
PC is at knav_dma_close_channel+0x30/0x19c
LR is at netcp_free_navigator_resources+0x2c/0x28c

[... TRIM...]

Call trace:
 knav_dma_close_channel from netcp_free_navigator_resources+0x2c/0x28c
 netcp_free_navigator_resources from netcp_ndo_open+0x430/0x46c
 netcp_ndo_open from __dev_open+0x114/0x29c
 __dev_open from __dev_change_flags+0x190/0x208
 __dev_change_flags from netif_change_flags+0x1c/0x58
 netif_change_flags from dev_change_flags+0x38/0xa0
 dev_change_flags from ip_auto_config+0x2c4/0x11f0
 ip_auto_config from do_one_initcall+0x58/0x200
 do_one_initcall from kernel_init_freeable+0x1cc/0x238
 kernel_init_freeable from kernel_init+0x1c/0x12c
 kernel_init from ret_from_fork+0x14/0x38
[... TRIM...]

Standardize the error handling by making the function return NULL on
all error conditions. The API is used in just the netcp_core.c so the
impact is limited.

Note, this change, in effect reverts commit 5b6cb43b4d62 ("net:
ethernet: ti: netcp_core: return error while dma channel open issue"),
but provides a less error prone implementation.

Suggested-by: Simon Horman <horms@kernel.org>
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since V2:
* All patches squashed to a single patch
* Updated commit message
* rebased to next-20251029

V2: https://lore.kernel.org/linux-arm-kernel/20250930121609.158419-1-nm@ti.com/
V1: https://lore.kernel.org/all/20250926150853.2907028-1-nm@ti.com/

Crash seen: https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz

 drivers/net/ethernet/ti/netcp_core.c | 10 +++++-----
 drivers/soc/ti/knav_dma.c            | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 857820657bac..5ee13db568f0 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1338,10 +1338,10 @@ int netcp_txpipe_open(struct netcp_tx_pipe *tx_pipe)
 
 	tx_pipe->dma_channel = knav_dma_open_channel(dev,
 				tx_pipe->dma_chan_name, &config);
-	if (IS_ERR(tx_pipe->dma_channel)) {
+	if (!tx_pipe->dma_channel) {
 		dev_err(dev, "failed opening tx chan(%s)\n",
 			tx_pipe->dma_chan_name);
-		ret = PTR_ERR(tx_pipe->dma_channel);
+		ret = -EINVAL;
 		goto err;
 	}
 
@@ -1359,7 +1359,7 @@ int netcp_txpipe_open(struct netcp_tx_pipe *tx_pipe)
 	return 0;
 
 err:
-	if (!IS_ERR_OR_NULL(tx_pipe->dma_channel))
+	if (tx_pipe->dma_channel)
 		knav_dma_close_channel(tx_pipe->dma_channel);
 	tx_pipe->dma_channel = NULL;
 	return ret;
@@ -1678,10 +1678,10 @@ static int netcp_setup_navigator_resources(struct net_device *ndev)
 
 	netcp->rx_channel = knav_dma_open_channel(netcp->netcp_device->device,
 					netcp->dma_chan_name, &config);
-	if (IS_ERR(netcp->rx_channel)) {
+	if (!netcp->rx_channel) {
 		dev_err(netcp->ndev_dev, "failed opening rx chan(%s\n",
 			netcp->dma_chan_name);
-		ret = PTR_ERR(netcp->rx_channel);
+		ret = -EINVAL;
 		goto fail;
 	}
 
diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index a25ebe6cd503..e69f0946de29 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -402,7 +402,7 @@ static int of_channel_match_helper(struct device_node *np, const char *name,
  * @name:	slave channel name
  * @config:	dma configuration parameters
  *
- * Returns pointer to appropriate DMA channel on success or error.
+ * Returns pointer to appropriate DMA channel on success or NULL on error.
  */
 void *knav_dma_open_channel(struct device *dev, const char *name,
 					struct knav_dma_cfg *config)
@@ -414,13 +414,13 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 
 	if (!kdev) {
 		pr_err("keystone-navigator-dma driver not registered\n");
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	chan_num = of_channel_match_helper(dev->of_node, name, &instance);
 	if (chan_num < 0) {
 		dev_err(kdev->dev, "No DMA instance with name %s\n", name);
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	dev_dbg(kdev->dev, "initializing %s channel %d from DMA %s\n",
@@ -431,7 +431,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	if (config->direction != DMA_MEM_TO_DEV &&
 	    config->direction != DMA_DEV_TO_MEM) {
 		dev_err(kdev->dev, "bad direction\n");
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	/* Look for correct dma instance */
@@ -443,7 +443,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	}
 	if (!dma) {
 		dev_err(kdev->dev, "No DMA instance with name %s\n", instance);
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	/* Look for correct dma channel from dma instance */
@@ -463,14 +463,14 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	if (!chan) {
 		dev_err(kdev->dev, "channel %d is not in DMA %s\n",
 				chan_num, instance);
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	if (atomic_read(&chan->ref_count) >= 1) {
 		if (!check_config(chan, config)) {
 			dev_err(kdev->dev, "channel %d config miss-match\n",
 				chan_num);
-			return (void *)-EINVAL;
+			return NULL;
 		}
 	}
 
-- 
2.47.0


