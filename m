Return-Path: <netdev+bounces-235180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD479C2D1EC
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA46734351F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E377315D2D;
	Mon,  3 Nov 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Evq6GhEg"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF6314B7F;
	Mon,  3 Nov 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187301; cv=fail; b=ugXmA4Xm8m9lMDzcaOhQ2YgYOe9b3sMUTpDcb/Kh6A7Y1tzIX3y2PW+VgJ/O46luUoPijLyJKX99+axyycSZk0rJXuLVP98KMrLN2x+fp2u9tGLBcxINAVrJaOOWOJLF/k1gKOfcDg5KaAxvT51i7z2ItozsyCFL4Z5cuzrRtWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187301; c=relaxed/simple;
	bh=AN7atLYZpe1VI46gBpqIIo/+RChOdOEUKcE+fRbB+EA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cIVxtCueLMrImkV4NrpCPJxeXLnHzBUfV9NacEb14QVzQmVY9dlASJJqXs2rDYHaES4YF5RBOFeDT65IuAXnng89axlAdqtNyrld5GQE+MjS8ATRCUq9ZHYtT7IvzE9mPKoZjLyWw9dDxrAqmjTorGqVlqqvLf2GvK3zQsGJHKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Evq6GhEg; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g09Klm32sp5BWWhbIAidUgfxTxmLDRFS5O6yoIPFeudj3oF/QnJESCV89qa140ZOFlxhur5V0yPE9NvbHiDNJgE/cNVQHHiVEMltKQJKyujmDWcNQseZNH3grVAMIDZDaZB8zkaWdafIHWK4zmtrAkOAFHZIrBezbM0YplK80XMQIta2KdBmV2iEsvC9Br7CNUvouTvsjQHbSfWsX+SsE+pKuoWF7Ix9I+Jmyz0HJLwnhAlmVpouOOLUNg7cnSpmcXLJ+a3bOhdzMPEyxf92x6iIY6CQk1PK9oaHJiSs0x1qGBAWO5jWLcHEENvzM0Qa3ksNVTt3IsqpGYqUSJjGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfyjJ06MBddLeTNqjRi5wlvpQQZoCc1yA6hgZA6QgqY=;
 b=Z/3uUIKlCEC5tHGAXU8nnXSC6BhyG+snW+HoUofqpYc7SjhIsObffd0zOcXELhIXyvPi2U1rVxJbwQM2NdlrtdevcEOcvBZaytRo+PHmEYphIrnu60xUK15L55+KvkeAPgJwnUkhvT8S8c2Fj1ZPTchPEVIiAbggEB47OpncQRC32HXXHzD1PLUc+rdtx2FK6LqBba8NBKkkTYm2s0F6q7IDo/udo3S8ElpSRPC6Xg087V/Z64QzrgwZEebUTqvMxF22ODmnmCnLLok0MF9MP9x0q7M9Mnnvk7KRE3v5ISKYjMJTB1l/UtkTwcXJH1xAbpOuyvX/pYZo2ghn+AeUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfyjJ06MBddLeTNqjRi5wlvpQQZoCc1yA6hgZA6QgqY=;
 b=Evq6GhEgFnm+opWNN82vttmKsHgYS8HwxTsdjjXnte+G5h52LutSNP9ML1eZt9fpkPOc8Qc+wlCp90qE+uTqpGOp1A4JmXiPHz0gOpcp0zGRf7oMg4icBukCn0n5mibLoF/WKRnRWmScdxA+8kHsbcG1JaD6z/UyFZQmf+LH550=
Received: from CH3P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::29)
 by DM3PPFA632C0238.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 16:28:15 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::8d) by CH3P220CA0023.outlook.office365.com
 (2603:10b6:610:1e8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 16:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 16:28:14 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 10:28:13 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 10:28:13 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 10:28:13 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A3GSD8K423335;
	Mon, 3 Nov 2025 10:28:13 -0600
From: Nishanth Menon <nm@ti.com>
To: Jakub Kicinski <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
CC: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4] net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error
Date: Mon, 3 Nov 2025 10:28:11 -0600
Message-ID: <20251103162811.3730055-1-nm@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DM3PPFA632C0238:EE_
X-MS-Office365-Filtering-Correlation-Id: 01db1656-66b9-4069-fffb-08de1af5fca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZThRDCdODQ9w1cf9BDd8U38ZAnzKmXGfnvwFC8gj+HL03jUNxUVIVCJGnL93?=
 =?us-ascii?Q?BZaGsiguEsptdySdioK2vrhd4+0wAwxY6B2C41uEd0A8NZOmdO99pNxo2i8k?=
 =?us-ascii?Q?Z2RKecSuADlknzI6POo7TxjQ5v1Dfm5obS7Dxb5sPbU2cF0czcpd8j7Qapze?=
 =?us-ascii?Q?r7j1lQcDfiy42BqCFBO5ZiUiQ0kLSaC45oAaybjIxOJvDmXmwRfFspp514ie?=
 =?us-ascii?Q?V349wSYfWondTOATdePaEfrAKITTltH9yZMTT9LjV9hwauneqcScDFSegQ6z?=
 =?us-ascii?Q?ODiJ7eqPab+P0rmsZxPK+fuq53ITyicN87rA1fgg/5fsQybySfgekqSIllCc?=
 =?us-ascii?Q?SVKF+t5YIsKsUMuo8GKnCsIUBzTbiZhzcW+LxoFcXn/MA8HatLq3cy0oLLvi?=
 =?us-ascii?Q?SbQ1B3g4t1r+A1csHIeZhpAniUcAClzOfweF1Xqs10jCdAKsXGry2vv6drgR?=
 =?us-ascii?Q?TPHtWtRDcwQa8eHJEvyIo5cY3tMwzeXtLZkRdQV6CGXePHMavdmFHGmjFtvN?=
 =?us-ascii?Q?/tG+EZNebZXgjWetHyWr/zkhy7kxm8Kow/F+H7SEf0Vh3Z3xqOQuW610QqqD?=
 =?us-ascii?Q?+65F9/PUnFbiATyoSx/eyNVzr5tx0QrJsR8Qj6P8IUeV8u7w15F/NgnTwEXO?=
 =?us-ascii?Q?I/KbZBmaNqCgJQcjeW363v7tjJ7rU1VpxaFqBnwTeJEdDUq7vMtWwWj/rIx7?=
 =?us-ascii?Q?WDtEhuKAPHDb0kHXU/ZPB8kw8vUjcanWknjsMaZv31QVGugthW/lYAL3Aa9k?=
 =?us-ascii?Q?9F5EoUZuVryNU+clVkBAEMNyt8dCaLKcTkmncnDOQIgiJpw4obWwaTCWwAdL?=
 =?us-ascii?Q?1SVTJ+mF/SMKoUeVFqMSmFp6WP248Hqi2rjxyTPIa+5FXKgpQO07MApZCoal?=
 =?us-ascii?Q?b/UNrrYSOZoD+c6gZPbnHziK4AFdR2Ewyv0i66aC8JdrfdAgm1ZoyBwC9M8f?=
 =?us-ascii?Q?75nhwSBBjs4/QVT6KhVIdZrbWnPcJ2xBHzLZUWJQ4xH4Z7aS7acjPkD7NDRL?=
 =?us-ascii?Q?OauBYfsQ0MyL2JTp0+DSrCIpx1W2R7zi/r98nW0Lox/yG67M5irRwcz+eoIk?=
 =?us-ascii?Q?MvDdKAwwulGixsSBda/HR9G6tYOZPlE1lUH5xsKW7RAaopLKSeHyOumCFJAt?=
 =?us-ascii?Q?ZsjiN3ghv5Zk8moJJCo8Sz+PdM8RKdU7CCOjld5iPJkpotEAIptAMl0aJQ+C?=
 =?us-ascii?Q?/jyMsoyWlBc5CBf39D6L23OLVedR0EUZ83jTXVKzFf8BBpZlZiFZKXfl3bLs?=
 =?us-ascii?Q?wxjaCIxIxgYzOTX38Sr/btk6sfsyNMwBONJSejANJc11Ge4zvE+nenRfTo5Y?=
 =?us-ascii?Q?uA/ole51IpgrC6KtxAid5XzCHaa9VBys71b4nPEO6FWhc6/eoFbnaYZmEkfx?=
 =?us-ascii?Q?TqejZ1jnMAe+e6q79pFZT3l7aMXD2c6JhY5Yi5a0/Uenx9JAhVxZ+edO8Ksa?=
 =?us-ascii?Q?kyIcNOVWfF2oW0G1QHXo8Q7LSPu96kEFgG51x5k3/McYRWEJ1JSiABEcMpO6?=
 =?us-ascii?Q?Fo4yvoq+FySf23Y=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 16:28:14.0224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01db1656-66b9-4069-fffb-08de1af5fca5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA632C0238

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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---

Changes since V3:
* Updated function documentation to use "Return:" to be inline with kdoc
* Picked Jacob's reviewed-by

V3: https://lore.kernel.org/r/20251029132310.3087247-1-nm@ti.com
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
index a25ebe6cd503..553ae7ee20f1 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -402,7 +402,7 @@ static int of_channel_match_helper(struct device_node *np, const char *name,
  * @name:	slave channel name
  * @config:	dma configuration parameters
  *
- * Returns pointer to appropriate DMA channel on success or error.
+ * Return: Pointer to appropriate DMA channel on success or NULL on error.
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


