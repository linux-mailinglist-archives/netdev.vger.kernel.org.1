Return-Path: <netdev+bounces-125235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C05896C60F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5241F24419
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F11E1A2E;
	Wed,  4 Sep 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Yt3rjK0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F141E1A28
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473549; cv=fail; b=NiQuZw+8G24DrxAU/9/Z8lGLawK4VFTTsMYfK8vyiHQanWGs5ne1DuHEoo5agFq9+qtY0xf5+ekwKiv20o4vnqEkQhuuiBFYqDHt4DXGHvGO6vuKLKhk4PwozRRoWPEC4dwvcqllvvyoXI5Jj137HELLeGvCOElMvcYDjuWW+90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473549; c=relaxed/simple;
	bh=qbltcf3rVkSvvT4OHXpAx26jjxqGynxa+zVDAJNnupI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gNIcIX8xYIt/H+Q2YjulR5HKnuhoKAwkZErxpfN+Y6UFfkYfOyB98pc38q1I6KF40K3Gkfjmphek96TsbqkZkf+BfTsjFCz/W80ZPd80BEFzest/fmVQugsOjPfDAJwSwBoAOqBOpGOJp2dpZoSNA86vzrCsIG7XSQb96zfDkhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Yt3rjK0; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqaurwTLtI6fi5Li5qKShkW4LNEwfd87g+ZN6V6kdIahh5SEULp0N9I3Wxqpdwjb/mTROAqZxdqEypp8MsvRyg8HO+pr/TJA6krDfD7AaIOkQ/aCsIrDU0AbvnNk9a9pWBD1/v+fnnNyfbxx9a2XuiB298xAhOEmXR+oTR9+QM/etmUZb9Ts89ll6HBwOaYyScx6lj5XYlz4ozzR4cVApTTHE/hFhvp1mBypKI4iVqQ/U/xA86ADtJlSPuaFVoEpmsdwYNZQUbvO3FUGbMQ9iLm3JlkVrKMdQDlM0JsS7VHms0f5qVGGyxesvK4+Tmn85k3Jtz5vMR7GG2EQJYywvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dki/knV+7HKh7AStxIkqkaAI6kntLcDoszRIGzAT6Q=;
 b=monlmyxhvz/7ogI9HzsllIB40ACK4sTyWMh1A+RtccCfFsdQrZhZ5kravOwCR37+S/feQs3J+ym+23Fl2AyeKaf92C3JpaMRt5FdFQ+UE38rJgqtSAXjA2wy3bT9BqusCjXzfDyyRggg2KoP0u9YyLFi2oGIhulQHSnGHnUfHePTVh37lR96a2INf6P/3y+zdhXYmQvJet70kAGabXjw6Lq9sfg9+HBqRQyVRTD8+/4CP/5eLu++clByDXoZKhEqXK96GV080W7A3+QHmCDhJgbCcnannl8RLuzuQB3Of8lWudE8Iix8sFNR8MdLjD4qFzgAd+495EvtocMVnsq0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dki/knV+7HKh7AStxIkqkaAI6kntLcDoszRIGzAT6Q=;
 b=4Yt3rjK0JE8IaRffFmTEsoUYV1Yf1JtNrO31Z34k/VxL31CRXS9P0sZ8psO74BNfHNlwLMvOYLlRMhvL2cIwu6S1oZKlB2/A6MIzBQfe3n3pJBRSM5VbsQLysphNHcAZsJkyYKtqizgz2jVl53WXWsA/OKfJxhhrZPy/RDkUHFc=
Received: from BN6PR17CA0054.namprd17.prod.outlook.com (2603:10b6:405:75::43)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 18:12:21 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::18) by BN6PR17CA0054.outlook.office365.com
 (2603:10b6:405:75::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 18:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 18:12:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 13:12:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 13:12:18 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 13:12:17 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] sfc: siena: rip out rss-context dead code
Date: Wed, 4 Sep 2024 19:11:56 +0100
Message-ID: <20240904181156.1993666-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b46e01-5299-47e0-374a-08dccd0d1df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Dkcwwq+abTkD64L5PoCBQbZTAMZJIuHtPim79cbDAWaH4nG38oCwrC7q7W2?=
 =?us-ascii?Q?i/qzfNScY3LnjL/cRiDb3VqbQmhoI8fGvLWzppnzbEDp+Dhte6UYKKEGGTFR?=
 =?us-ascii?Q?HWjtO6nowuARq+CAhlF2DmYHwOrpbEgM8d1JrPgtJE390ej9JOJYLPuG3g2l?=
 =?us-ascii?Q?Cq+QNoDrPw0BUfKfC44enLXeZk28bNpbEeIK0HDDqC+vLQ2JoZdvkIh+dvYS?=
 =?us-ascii?Q?65MYMmVJsreSsuhc83ZODOxiBZPCzSGTEsBP2luYaEoLnoLhJaUdbDKLMsPA?=
 =?us-ascii?Q?6pPPnF7siaYpacbVE3JRda3ZEEi9gVm1Joa+2/lFk6WG9RFeMhvt+f+KjgrQ?=
 =?us-ascii?Q?Tfo72iKo6GFeNFEZ+zLvA9AwRpLbPn6KzRlo7zXV1IKjvNRZlAGDhHkB5sYf?=
 =?us-ascii?Q?IFQCKDw5hbI+6YxykJdHNGez9Z0x2wadRzkSk4om4Z+7mXBvzocXswzGmnin?=
 =?us-ascii?Q?7quHO8rQ/sutbymuIp/XAr/AvvIBO5mhnFSgKKlWHx5DO+EibKbyjt6+3xWb?=
 =?us-ascii?Q?1mB6jzBkkwN8mFYf6K95a37JabqF2Z++7aX2NxTa/9SQTaWOcIiOy0HNcqSA?=
 =?us-ascii?Q?QwQjksiURcfmFRbqPrpDCvylcDymy2qnBZ/58RYzHvN32oOTDDbY7dWlsPbJ?=
 =?us-ascii?Q?2xlxh5La4iY0REk3AdXqKEPLrxFPEk3TpSqcRdnOQsJbWH5myn7HdBMY6y72?=
 =?us-ascii?Q?9FLX2BYNC9jwa+X818gJUGG221Pj7gO9Hvzy4EbYuBy3yvLRa9q4/Yu/ZgXr?=
 =?us-ascii?Q?DZQ6w4c3m7XWTy6CVwWBScO4Dv74GT/7orVRLH1yJZaWtIJokKlJdlNLeyiF?=
 =?us-ascii?Q?1NGNx6JLsHOzRNo2bGlDVWsE8mhJN46DbGvmoHbullnpjSPCMEyTAGkHZO81?=
 =?us-ascii?Q?pJ8kvOljijFFlXAP1pavZy0exemiLhb4vy09GxpMgXiOBre3HI95DXRe3hof?=
 =?us-ascii?Q?yTfS2OjjfGWKZ1mYj+aXHVeS4ve4uaa9sSrVSIiPUQUfDjdkEREZraPpIX6N?=
 =?us-ascii?Q?7Vf4CD36JeJtop31OfzDH+VQpikgm2EMkV+DaFEmKGVGIdaKOBXxjndgG+IR?=
 =?us-ascii?Q?yeRBfnFxSAiTnuTx6I7hw40X8WLbuINxsqZSsppau4Dc/Kzh1IxqQgMgAE7p?=
 =?us-ascii?Q?27JlGsdOLHBwRfPDu6y1gXoSYgEbuyTsvRWmg12YIp08M2Sr5G/M9ImjxL3g?=
 =?us-ascii?Q?bTiZEPlMjhK7D5TP3kkkr9/gR01gwbMnb73WgKohZiJ+COQSwpyg9RZhAX0o?=
 =?us-ascii?Q?bLaXaYlRrxBiXbcKHXfGkqZPPK4To/+257dX2VJa7e7JcxH78evqlTAY4/ut?=
 =?us-ascii?Q?Meopl6dFsviLnYoXfHlIgmlf1EQZDe3jCMlLyZNuQTjp+tjcCwMtxgi4hNWp?=
 =?us-ascii?Q?g8oz7kldxPxF5iY5IlEx9Bwn+bxcU93KPWmu7fGwbSth8WDrDGlORmPCyzMb?=
 =?us-ascii?Q?U9EiHHR06OsNBunh9G+xY2lvdaCSUYuG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 18:12:20.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b46e01-5299-47e0-374a-08dccd0d1df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139

From: Edward Cree <ecree.xilinx@gmail.com>

Siena hardware does not support custom RSS contexts, but when the
 driver was forked from sfc.ko, some of the plumbing for them was
 copied across from the common code.  Actually trying to use them
 would lead to EOPNOTSUPP as the relevant efx_nic_type methods were
 not populated.
Remove this dead code from the Siena driver.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/siena/efx_common.c   |   7 -
 drivers/net/ethernet/sfc/siena/ethtool.c      |   1 -
 .../net/ethernet/sfc/siena/ethtool_common.c   | 125 +-----------------
 drivers/net/ethernet/sfc/siena/net_driver.h   |  26 +---
 drivers/net/ethernet/sfc/siena/rx_common.c    |  56 --------
 drivers/net/ethernet/sfc/siena/rx_common.h    |   4 -
 6 files changed, 8 insertions(+), 211 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/efx_common.c b/drivers/net/ethernet/sfc/siena/efx_common.c
index cf195162e270..a0966f879664 100644
--- a/drivers/net/ethernet/sfc/siena/efx_common.c
+++ b/drivers/net/ethernet/sfc/siena/efx_common.c
@@ -725,7 +725,6 @@ void efx_siena_reset_down(struct efx_nic *efx, enum reset_type method)
 
 	mutex_lock(&efx->mac_lock);
 	down_write(&efx->filter_sem);
-	mutex_lock(&efx->rss_lock);
 	efx->type->fini(efx);
 }
 
@@ -786,9 +785,6 @@ int efx_siena_reset_up(struct efx_nic *efx, enum reset_type method, bool ok)
 			   " VFs may not function\n", rc);
 #endif
 
-	if (efx->type->rx_restore_rss_contexts)
-		efx->type->rx_restore_rss_contexts(efx);
-	mutex_unlock(&efx->rss_lock);
 	efx->type->filter_table_restore(efx);
 	up_write(&efx->filter_sem);
 	if (efx->type->sriov_reset)
@@ -806,7 +802,6 @@ int efx_siena_reset_up(struct efx_nic *efx, enum reset_type method, bool ok)
 fail:
 	efx->port_initialized = false;
 
-	mutex_unlock(&efx->rss_lock);
 	up_write(&efx->filter_sem);
 	mutex_unlock(&efx->mac_lock);
 
@@ -1016,9 +1011,7 @@ int efx_siena_init_struct(struct efx_nic *efx,
 		efx->type->rx_hash_offset - efx->type->rx_prefix_size;
 	efx->rx_packet_ts_offset =
 		efx->type->rx_ts_offset - efx->type->rx_prefix_size;
-	INIT_LIST_HEAD(&efx->rss_context.list);
 	efx->rss_context.context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
-	mutex_init(&efx->rss_lock);
 	efx->vport_id = EVB_PORT_ID_ASSIGNED;
 	spin_lock_init(&efx->stats_lock);
 	efx->vi_stride = EFX_DEFAULT_VI_STRIDE;
diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
index 4c182d4edfc2..88ddc226b012 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool.c
@@ -240,7 +240,6 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
 }
 
 const struct ethtool_ops efx_siena_ethtool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USECS_IRQ |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index 5f0a8127e967..075fef64de68 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -820,27 +820,16 @@ int efx_siena_ethtool_get_rxnfc(struct net_device *net_dev,
 		return 0;
 
 	case ETHTOOL_GRXFH: {
-		struct efx_rss_context *ctx = &efx->rss_context;
 		__u64 data;
 
-		mutex_lock(&efx->rss_lock);
-		if (info->flow_type & FLOW_RSS && info->rss_context) {
-			ctx = efx_siena_find_rss_context_entry(efx,
-							info->rss_context);
-			if (!ctx) {
-				rc = -ENOENT;
-				goto out_unlock;
-			}
-		}
-
 		data = 0;
-		if (!efx_rss_active(ctx)) /* No RSS */
-			goto out_setdata_unlock;
+		if (!efx_rss_active(&efx->rss_context)) /* No RSS */
+			goto out_setdata;
 
-		switch (info->flow_type & ~FLOW_RSS) {
+		switch (info->flow_type) {
 		case UDP_V4_FLOW:
 		case UDP_V6_FLOW:
-			if (ctx->rx_hash_udp_4tuple)
+			if (efx->rss_context.rx_hash_udp_4tuple)
 				data = (RXH_L4_B_0_1 | RXH_L4_B_2_3 |
 					RXH_IP_SRC | RXH_IP_DST);
 			else
@@ -862,10 +851,8 @@ int efx_siena_ethtool_get_rxnfc(struct net_device *net_dev,
 		default:
 			break;
 		}
-out_setdata_unlock:
+out_setdata:
 		info->data = data;
-out_unlock:
-		mutex_unlock(&efx->rss_lock);
 		return rc;
 	}
 
@@ -1164,47 +1151,12 @@ u32 efx_siena_ethtool_get_rxfh_key_size(struct net_device *net_dev)
 	return efx->type->rx_hash_key_size;
 }
 
-static int efx_siena_ethtool_get_rxfh_context(struct net_device *net_dev,
-					      struct ethtool_rxfh_param *rxfh)
-{
-	struct efx_nic *efx = netdev_priv(net_dev);
-	struct efx_rss_context *ctx;
-	int rc = 0;
-
-	if (!efx->type->rx_pull_rss_context_config)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&efx->rss_lock);
-	ctx = efx_siena_find_rss_context_entry(efx, rxfh->rss_context);
-	if (!ctx) {
-		rc = -ENOENT;
-		goto out_unlock;
-	}
-	rc = efx->type->rx_pull_rss_context_config(efx, ctx);
-	if (rc)
-		goto out_unlock;
-
-	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (rxfh->indir)
-		memcpy(rxfh->indir, ctx->rx_indir_table,
-		       sizeof(ctx->rx_indir_table));
-	if (rxfh->key)
-		memcpy(rxfh->key, ctx->rx_hash_key,
-		       efx->type->rx_hash_key_size);
-out_unlock:
-	mutex_unlock(&efx->rss_lock);
-	return rc;
-}
-
 int efx_siena_ethtool_get_rxfh(struct net_device *net_dev,
 			       struct ethtool_rxfh_param *rxfh)
 {
 	struct efx_nic *efx = netdev_priv(net_dev);
 	int rc;
 
-	if (rxfh->rss_context)
-		return efx_siena_ethtool_get_rxfh_context(net_dev, rxfh);
-
 	rc = efx->type->rx_pull_rss_config(efx);
 	if (rc)
 		return rc;
@@ -1219,70 +1171,6 @@ int efx_siena_ethtool_get_rxfh(struct net_device *net_dev,
 	return 0;
 }
 
-static int efx_siena_ethtool_set_rxfh_context(struct net_device *net_dev,
-					      struct ethtool_rxfh_param *rxfh,
-					      struct netlink_ext_ack *extack)
-{
-	struct efx_nic *efx = netdev_priv(net_dev);
-	u32 *rss_context = &rxfh->rss_context;
-	struct efx_rss_context *ctx;
-	u32 *indir = rxfh->indir;
-	bool allocated = false;
-	u8 *key = rxfh->key;
-	int rc;
-
-	if (!efx->type->rx_push_rss_context_config)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&efx->rss_lock);
-
-	if (*rss_context == ETH_RXFH_CONTEXT_ALLOC) {
-		if (rxfh->rss_delete) {
-			/* alloc + delete == Nothing to do */
-			rc = -EINVAL;
-			goto out_unlock;
-		}
-		ctx = efx_siena_alloc_rss_context_entry(efx);
-		if (!ctx) {
-			rc = -ENOMEM;
-			goto out_unlock;
-		}
-		ctx->context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
-		/* Initialise indir table and key to defaults */
-		efx_siena_set_default_rx_indir_table(efx, ctx);
-		netdev_rss_key_fill(ctx->rx_hash_key, sizeof(ctx->rx_hash_key));
-		allocated = true;
-	} else {
-		ctx = efx_siena_find_rss_context_entry(efx, *rss_context);
-		if (!ctx) {
-			rc = -ENOENT;
-			goto out_unlock;
-		}
-	}
-
-	if (rxfh->rss_delete) {
-		/* delete this context */
-		rc = efx->type->rx_push_rss_context_config(efx, ctx, NULL, NULL);
-		if (!rc)
-			efx_siena_free_rss_context_entry(ctx);
-		goto out_unlock;
-	}
-
-	if (!key)
-		key = ctx->rx_hash_key;
-	if (!indir)
-		indir = ctx->rx_indir_table;
-
-	rc = efx->type->rx_push_rss_context_config(efx, ctx, indir, key);
-	if (rc && allocated)
-		efx_siena_free_rss_context_entry(ctx);
-	else
-		*rss_context = ctx->user_id;
-out_unlock:
-	mutex_unlock(&efx->rss_lock);
-	return rc;
-}
-
 int efx_siena_ethtool_set_rxfh(struct net_device *net_dev,
 			       struct ethtool_rxfh_param *rxfh,
 			       struct netlink_ext_ack *extack)
@@ -1296,9 +1184,6 @@ int efx_siena_ethtool_set_rxfh(struct net_device *net_dev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->rss_context)
-		efx_siena_ethtool_set_rxfh_context(net_dev, rxfh, extack);
-
 	if (!indir && !key)
 		return 0;
 
diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
index 94152f595acd..3fa7c652ae9b 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -707,20 +707,14 @@ struct vfdi_status;
 /* The reserved RSS context value */
 #define EFX_MCDI_RSS_CONTEXT_INVALID	0xffffffff
 /**
- * struct efx_rss_context - A user-defined RSS context for filtering
- * @list: node of linked list on which this struct is stored
- * @context_id: the RSS_CONTEXT_ID returned by MC firmware, or
- *	%EFX_MCDI_RSS_CONTEXT_INVALID if this context is not present on the NIC.
- *	For Siena, 0 if RSS is active, else %EFX_MCDI_RSS_CONTEXT_INVALID.
- * @user_id: the rss_context ID exposed to userspace over ethtool.
+ * struct efx_rss_context - An RSS context for filtering
+ * @context_id: 0 if RSS is active, else %EFX_MCDI_RSS_CONTEXT_INVALID.
  * @rx_hash_udp_4tuple: UDP 4-tuple hashing enabled
  * @rx_hash_key: Toeplitz hash key for this RSS context
  * @indir_table: Indirection table for this RSS context
  */
 struct efx_rss_context {
-	struct list_head list;
 	u32 context_id;
-	u32 user_id;
 	bool rx_hash_udp_4tuple;
 	u8 rx_hash_key[40];
 	u32 rx_indir_table[128];
@@ -851,9 +845,7 @@ enum efx_xdp_tx_queues_mode {
  * @rx_packet_ts_offset: Offset of timestamp from start of packet data
  *	(valid only if channel->sync_timestamps_enabled; always negative)
  * @rx_scatter: Scatter mode enabled for receives
- * @rss_context: Main RSS context.  Its @list member is the head of the list of
- *	RSS contexts created by user requests
- * @rss_lock: Protects custom RSS context software state in @rss_context.list
+ * @rss_context: Main RSS context
  * @vport_id: The function's vport ID, only relevant for PFs
  * @int_error_count: Number of internal errors seen recently
  * @int_error_expire: Time at which error count will be expired
@@ -1018,7 +1010,6 @@ struct efx_nic {
 	int rx_packet_ts_offset;
 	bool rx_scatter;
 	struct efx_rss_context rss_context;
-	struct mutex rss_lock;
 	u32 vport_id;
 
 	unsigned int_error_count;
@@ -1220,10 +1211,6 @@ struct efx_udp_tunnel {
  * @tx_enqueue: Add an SKB to TX queue
  * @rx_push_rss_config: Write RSS hash key and indirection table to the NIC
  * @rx_pull_rss_config: Read RSS hash key and indirection table back from the NIC
- * @rx_push_rss_context_config: Write RSS hash key and indirection table for
- *	user RSS context to the NIC
- * @rx_pull_rss_context_config: Read RSS hash key and indirection table for user
- *	RSS context back from the NIC
  * @rx_probe: Allocate resources for RX queue
  * @rx_init: Initialise RX queue on the NIC
  * @rx_remove: Free resources for RX queue
@@ -1366,13 +1353,6 @@ struct efx_nic_type {
 	int (*rx_push_rss_config)(struct efx_nic *efx, bool user,
 				  const u32 *rx_indir_table, const u8 *key);
 	int (*rx_pull_rss_config)(struct efx_nic *efx);
-	int (*rx_push_rss_context_config)(struct efx_nic *efx,
-					  struct efx_rss_context *ctx,
-					  const u32 *rx_indir_table,
-					  const u8 *key);
-	int (*rx_pull_rss_context_config)(struct efx_nic *efx,
-					  struct efx_rss_context *ctx);
-	void (*rx_restore_rss_contexts)(struct efx_nic *efx);
 	int (*rx_probe)(struct efx_rx_queue *rx_queue);
 	void (*rx_init)(struct efx_rx_queue *rx_queue);
 	void (*rx_remove)(struct efx_rx_queue *rx_queue);
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 219fb358a646..082e35c6caaa 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -558,62 +558,6 @@ efx_siena_rx_packet_gro(struct efx_channel *channel,
 	napi_gro_frags(napi);
 }
 
-/* RSS contexts.  We're using linked lists and crappy O(n) algorithms, because
- * (a) this is an infrequent control-plane operation and (b) n is small (max 64)
- */
-struct efx_rss_context *efx_siena_alloc_rss_context_entry(struct efx_nic *efx)
-{
-	struct list_head *head = &efx->rss_context.list;
-	struct efx_rss_context *ctx, *new;
-	u32 id = 1; /* Don't use zero, that refers to the master RSS context */
-
-	WARN_ON(!mutex_is_locked(&efx->rss_lock));
-
-	/* Search for first gap in the numbering */
-	list_for_each_entry(ctx, head, list) {
-		if (ctx->user_id != id)
-			break;
-		id++;
-		/* Check for wrap.  If this happens, we have nearly 2^32
-		 * allocated RSS contexts, which seems unlikely.
-		 */
-		if (WARN_ON_ONCE(!id))
-			return NULL;
-	}
-
-	/* Create the new entry */
-	new = kmalloc(sizeof(*new), GFP_KERNEL);
-	if (!new)
-		return NULL;
-	new->context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
-	new->rx_hash_udp_4tuple = false;
-
-	/* Insert the new entry into the gap */
-	new->user_id = id;
-	list_add_tail(&new->list, &ctx->list);
-	return new;
-}
-
-struct efx_rss_context *efx_siena_find_rss_context_entry(struct efx_nic *efx,
-							 u32 id)
-{
-	struct list_head *head = &efx->rss_context.list;
-	struct efx_rss_context *ctx;
-
-	WARN_ON(!mutex_is_locked(&efx->rss_lock));
-
-	list_for_each_entry(ctx, head, list)
-		if (ctx->user_id == id)
-			return ctx;
-	return NULL;
-}
-
-void efx_siena_free_rss_context_entry(struct efx_rss_context *ctx)
-{
-	list_del(&ctx->list);
-	kfree(ctx);
-}
-
 void efx_siena_set_default_rx_indir_table(struct efx_nic *efx,
 					  struct efx_rss_context *ctx)
 {
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.h b/drivers/net/ethernet/sfc/siena/rx_common.h
index 6b37f83ecb30..f90a8320d396 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.h
+++ b/drivers/net/ethernet/sfc/siena/rx_common.h
@@ -78,10 +78,6 @@ efx_siena_rx_packet_gro(struct efx_channel *channel,
 			struct efx_rx_buffer *rx_buf,
 			unsigned int n_frags, u8 *eh, __wsum csum);
 
-struct efx_rss_context *efx_siena_alloc_rss_context_entry(struct efx_nic *efx);
-struct efx_rss_context *efx_siena_find_rss_context_entry(struct efx_nic *efx,
-							 u32 id);
-void efx_siena_free_rss_context_entry(struct efx_rss_context *ctx);
 void efx_siena_set_default_rx_indir_table(struct efx_nic *efx,
 					  struct efx_rss_context *ctx);
 

