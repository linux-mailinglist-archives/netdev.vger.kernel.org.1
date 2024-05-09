Return-Path: <netdev+bounces-94995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5F8C1300
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA71F21FEA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29148BF0;
	Thu,  9 May 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DE/WubXZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FA2F43
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272375; cv=fail; b=O03k2zmzdJ754NudIhduKWHNxz+wyYrYrU2Q+h64ioXiheco5cDnqgltUTI3yyWj4UG7f/yWVmSDqZ6/6OoXii9/MrI10z6dJVy2AYULuX6M77G84ejtDLvuSyxVT7t5U7w0roGH8FyJAL6hNGQ8Ux/l8kTF7vQha56LBktxT9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272375; c=relaxed/simple;
	bh=oK+wgcI5jLSHaw04vgYMgxpQWhG4OrFfWm1uDHqHQUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8ADTgnQHxm3NHB5rUCgHlbdweeX6aRxLQJ4E41mBdHRE10EMQDL80mVHrNpyQTh2GNchOc0o0+GohsgOBlkf4/gLA8UAkNt6vdnJ3UCSsMBqD/RdbY/wvXNPC+K6lienuOV19azNx52uHGaSbUW11Bw9EBP+/7KvTyWE/jk4e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DE/WubXZ; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COeMFLmdz8Y29DfUjQhApFNvt3P1RL+nRtYBsfBBMGbtOd24EmBmPWGbUn5As6LklAtuzL/MvuVdPznXCZfJUhMmYNEF/+L4xM0zu/zXuEO0V2vcS8vOaSNjiRVMcKS89o2Fm0LB/6dauCVoKQ6xkqIj4SyuYf2nkgvTxYzug+LkiP11n8mx/LbxCuqejjdUpczfRcr8p/dE2T3qp95a8MhRChlJzuHUX9LvCkYj9ec2SsOU1/wk9e7E1xtRLRAK8zrZGv1OKmTFYNe/mytbk4oAsIWrmpX2qA9mJ9N75wRioO4L5uY/1penmcyypYHqQ3ZNydzfUgvDd+BBgUBsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si1j7bp/JQw2M9bVOFnV28q/NalMfqzdVuFvoPS1/v8=;
 b=YpG86HffSjktSrRV9QvB5xfhg5gJfra7MgN/bbSsbliJfLnNSiNEIeM/VKQ29xFKIBrwAQAl/8F4lgmnzlg+LpHs6pCPvORRzFuyL6bVT4HcWuTDHPT7wq+skrx9lgen4R8Jz1b2RFdyiffYGBu1XkAhZ9MOqu8xrKR0HIlI05Dd+aCVPW9pg898yssGxAqKAkodp9ORg/KtokGjIxTyv+WNQBWs5fZcmK2w5d4FMWtM4u/qldoFtpr4QKuM2drZ0ro9FFX5NUhf//wOQIWvhK7uQTFayFQIB5AbEHpRTjuLh8yCHEMEj+5pHj3ewZ7/xDw9kpvEN3UmvLa/Lh5iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si1j7bp/JQw2M9bVOFnV28q/NalMfqzdVuFvoPS1/v8=;
 b=DE/WubXZg01E4M40mI1gViaeTeV2n1/PrtA2ziFj5tBxvmdLTzSeie3ekqDaiSsZbqRIKD9q+83ioaY6uwMwXOKuqGRWTGGCNgawOJas+TNI+AT5PpUxWzccFsHSX0qO0nt9Koe8zaR+gbSDONU9xDL6aafDlcdHAOY/EQUSb4z8Z9Eg0SQJanR5ShNzf9CsRjPP2SuBje2rMJ/vs9b+ZwH1iN2KRQvZKh1s4U5OXMhrrLcgCQ4FG6zpqV+h4re1N8mbMejGdroLmFXMv7sAsVFlCXMMxDPRcf/w8BwFSrHREwHme5t1O+Jt8uVZKBKpvcWb91fsvv/DgYgLxAJttg==
Received: from DM6PR11CA0043.namprd11.prod.outlook.com (2603:10b6:5:14c::20)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 16:32:50 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::b) by DM6PR11CA0043.outlook.office365.com
 (2603:10b6:5:14c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Thu, 9 May 2024 16:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 16:32:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 09:32:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 09:32:31 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 May 2024 09:32:30 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake counters
Date: Thu, 9 May 2024 11:32:16 -0500
Message-ID: <20240509163216.108665-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509163216.108665-1-danielj@nvidia.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: af355ca3-d3bc-4a5c-892a-08dc7045ab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wyOzbFfXmjWfNNLR/K7wq9KMt+AzwpO+IBRuD5TsOKHYCWdWK8lOT+5neOJF?=
 =?us-ascii?Q?w+ToP1ae3RwsCVQ3oIyqezrilz1L3ed51XnCvny6IvmxpI+MDLXWVtw0pmGz?=
 =?us-ascii?Q?FwLG0wRixZVBmmT/9ZKlmovcYaNOP51NRCgl1PyVxQ3o4QQfFiJC7eaN9EyY?=
 =?us-ascii?Q?7jujd7o9rLaRpHSz/HyUwD6lqz2ZKNFWgCIScKs6sz0nl7gMUIVpFJfoy9vO?=
 =?us-ascii?Q?mEuUE+Serai8JkmBaJzr3QSVTK3/IFFRgoBCKVZsYdGMbRiQHIyScvRn59yw?=
 =?us-ascii?Q?34Ze356/h0tK25fH49/RhzhJr+caKrnvGDlNas6pYO4B2ue4Vq2SfS05t70v?=
 =?us-ascii?Q?jzoZUwjuPyPymkiyxyAu4DHYqcsvRkyztt24xZkcnhVU3CSlTgmVVQr7OmyS?=
 =?us-ascii?Q?rZ8/9R7pFueOZ1e42eCXSvtXklTtjvVbSXZlYlHhULdlYaoOzxrwLguEaI1h?=
 =?us-ascii?Q?964jf3Q+saawmetPqsv+ZhOh9xB1vH0saKOci1paO755GmiFC9Wkv3Q3HWtu?=
 =?us-ascii?Q?CB9T6i+w3ivYpYPl0i1CbVS8OXd0X2Ti23yEM0C0b4qIKDERcZA8jc9exGIP?=
 =?us-ascii?Q?Y7Ztx/+6Bd2pgNdqvkQJOgATPXMuyi8mFzprI7az0W/nr+x62B+Uv/zGd5BP?=
 =?us-ascii?Q?9MVSA4y992fofbObe2Y19Lw1PhS5OmQpDru7tWlt362ehZFc1C6zdN2QId+5?=
 =?us-ascii?Q?K769TRy0pj8NLcTQ4u9FY93YM9iABLCNsEU7EXboqBdY30mSWmUiWgfr/wcS?=
 =?us-ascii?Q?FNwG7SrztUlGF9ZmJB4n1jOh7jQjYHO0NglYJjY7KeEWZ/awfvK+5QjH0hvJ?=
 =?us-ascii?Q?63BMS5I5cfSwbKyStID7zFLlZBZNHWcPalNGLygco55qIE/xKghsIhn8OJRO?=
 =?us-ascii?Q?5gzaMMCELPs7E9EwHHBbYBZM2mHcUw2Y6HwhWjfjG55dj2CBfF7jLoDsZkOx?=
 =?us-ascii?Q?4TRbWHYpfSX1q1r5plTbUa10AbnmDyg+7Gm1am/ZKCLlXtaug5nQMqcojDH2?=
 =?us-ascii?Q?PdJYow/74Rv1WBWXBSnzed7K6M02/SwoUXns42Fh9ah7FkP/sGWb8hotduWQ?=
 =?us-ascii?Q?pf6snw4yQuYqagbfAyvSNl14D3WSGSx/mYFsFteuKJqR0S89CsMXVHcMEdW2?=
 =?us-ascii?Q?EEazAka52PWTrt+5D1308n25rVBwvhOdxbuxEwIudVsdfEISZbZAFnPTN2oj?=
 =?us-ascii?Q?+nwZdn/skOATgIr2goouLaXmavUtC3YUy4jmDs5mruIu1YymL+QE1RDIzoiK?=
 =?us-ascii?Q?UW7g54Yu6frrtKNnp2F6TZl4+qD7CPygeBN+kLMjs2LgRCrlQVuYygeM9687?=
 =?us-ascii?Q?AXpUBiFMD7etJhPgeUn7K8eepZ5VcKh5uHDUgnj+e/ZiHcr0Y8vEuw7zypVa?=
 =?us-ascii?Q?YVREZPI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:32:50.2566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af355ca3-d3bc-4a5c-892a-08dc7045ab08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727

Add a tx queue stop and wake counters, they are useful for debugging.

$ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \
--dump qstats-get --json '{"scope": "queue"}'
...
 {'ifindex': 13,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 14756682850,
  'tx-packets': 226465,
  'tx-stop': 113208,
  'tx-wake': 113208},
 {'ifindex': 13,
  'queue-id': 1,
  'queue-type': 'tx',
  'tx-bytes': 18167675008,
  'tx-packets': 278660,
  'tx-stop': 8632,
  'tx-wake': 8632}]

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 218a446c4c27..df6121c38a1b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -95,6 +95,8 @@ struct virtnet_sq_stats {
 	u64_stats_t xdp_tx_drops;
 	u64_stats_t kicks;
 	u64_stats_t tx_timeouts;
+	u64_stats_t stop;
+	u64_stats_t wake;
 };
 
 struct virtnet_rq_stats {
@@ -145,6 +147,8 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
 	VIRTNET_SQ_STAT_QSTAT("packets", packets),
 	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
+	VIRTNET_SQ_STAT_QSTAT("stop",	 stop),
+	VIRTNET_SQ_STAT_QSTAT("wake",	 wake),
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] = {
@@ -1014,6 +1018,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
 		netif_stop_subqueue(dev, qnum);
+		u64_stats_update_begin(&sq->stats.syncp);
+		u64_stats_inc(&sq->stats.stop);
+		u64_stats_update_end(&sq->stats.syncp);
 		if (use_napi) {
 			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
@@ -1022,6 +1029,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 			free_old_xmit(sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
+				u64_stats_update_begin(&sq->stats.syncp);
+				u64_stats_inc(&sq->stats.wake);
+				u64_stats_update_end(&sq->stats.syncp);
 				virtqueue_disable_cb(sq->vq);
 			}
 		}
@@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 			free_old_xmit(sq, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
-		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+			if (netif_tx_queue_stopped(txq)) {
+				u64_stats_update_begin(&sq->stats.syncp);
+				u64_stats_inc(&sq->stats.wake);
+				u64_stats_update_end(&sq->stats.syncp);
+			}
 			netif_tx_wake_queue(txq);
+		}
 
 		__netif_tx_unlock(txq);
 	}
@@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	virtqueue_disable_cb(sq->vq);
 	free_old_xmit(sq, true);
 
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+		if (netif_tx_queue_stopped(txq)) {
+			u64_stats_update_begin(&sq->stats.syncp);
+			u64_stats_inc(&sq->stats.wake);
+			u64_stats_update_end(&sq->stats.syncp);
+		}
 		netif_tx_wake_queue(txq);
+	}
 
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
@@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct net_device *dev,
 
 	tx->bytes = 0;
 	tx->packets = 0;
+	tx->stop = 0;
+	tx->wake = 0;
 
 	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
 		tx->hw_drops = 0;
-- 
2.44.0


