Return-Path: <netdev+bounces-128848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8718897BF11
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC061C2196F
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2F1C9EB4;
	Wed, 18 Sep 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qwqnoh4g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1E18A94F
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676291; cv=fail; b=i3ECwBNFE1S591dc84OLxz7yZgYsK3pDdQTEcGN3fg2cigE4/t37EY7jyH7oyiMJqEDOnkLrmTM5ivjuVLPYGaaE4pbPhsA0FgVhaHSHx3nQ/YH4c/ERTa12HINZ9KuiWRKzh3Ua4yPai4TAjHvsGKJbNxj8zlKDQYrwdY/xxn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676291; c=relaxed/simple;
	bh=wg0yEJ8qRagYgQcGnFNeDtAVK2u1kSRCVY1mv2+MDAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+uCoLY1HWHld9SFq5MlNxLq1bo7aFSqncaf/yWLAnJWgfe70TF7tNzW14Bl3p+uXvdJ4evPMv/ynVpis4oHwsLvUVtHhb9A227uQuqFrBJzVOAaCZiJ9img4q7ilp8G58wsW+tUok8+3W9BtAv9KnzO7x4MmkZWPQ7KjnlhEys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qwqnoh4g; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1gpz3m+Vx+pEgqUwvMvzaEBVvRyq7kz2EqQkG71coa6fzlZnwWTgotytPPZvxOsPHSIpcMbIz2YJE0Sb9g/fXkofnAbCE5eP5XBuL/BPYer56CKmmA9cU88cN9qMAnf+lYYnvFfPbDP51kESQR7j34yP5RqPw7EcQpfRp8C1ubdbBYOs1iQ63AGgqzu3OHFg3fIc1AcCzm97hiq5vDfQfM1GyUMvYUfchOw5WxlYVcBvybnq/WkstdtFO6nR/YGBu+AP839DTaxdxv/AeOdQXYHlgPIc/xLkEP5JSFnp4cfoTJsbMfuNQ+JB49Cs+M9xQiorh/B6AjMmKE3t2WGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXx5JbZemJdRw1Lv6XGS80EQox2jzRpGqE5GpYza0xw=;
 b=H83rd+orrBATrU2Jx+8BYcYaZ1wNzzTuutAFV6QsDDfMyFEoh92OYsxKFko1FTizrklFdex+RHjd+C01Su/Ibneawiav/HVz8CfXMqiCPi5+uVC21KAMTUyH5q70TNAg/0jZb9Qsvjis/mKla3gQTn8bfV5sjB/cMDj2mLBNnUhABJPQO9KN92rxRwIrDLJEP0gYGyiOl69G0QkznJCubyDHNx/jIOKhKA8535YipkpLZPavnaDMl21GYI5u4JnrCDAZIeQaIUcaiPiMxJD0zao9PObG/g0oIvXZEqT823H03bKWxxsjsC7171dZEouafUv3Mtb5qfBP4oH5qiUfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXx5JbZemJdRw1Lv6XGS80EQox2jzRpGqE5GpYza0xw=;
 b=qwqnoh4g/8faG8CugZUK3hNpZHUGvSXJ0sFaw/6MOACmk6sOgsifgQhmfR6mo/BKfof3AKXuwjGbYuuI7JKp4bK7kjdAINnyIJZnCUTrX+0VpSVil8hDha5Z/ln6yr+crIscIa4V6fQ+VsjZkmkXOlkJO2UwYGvKS2MTD+Ar1RA=
Received: from MW4PR03CA0133.namprd03.prod.outlook.com (2603:10b6:303:8c::18)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 16:18:03 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::ea) by MW4PR03CA0133.outlook.office365.com
 (2603:10b6:303:8c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 16:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Wed, 18 Sep 2024 16:18:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:18:00 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:17:58 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 5/7] sfc: implement per-queue rx drop and overrun stats
Date: Wed, 18 Sep 2024 17:14:27 +0100
Message-ID: <a71e850f22bce2d289081d5c3c69fd75ee5f9f5c.1726593633.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1726593632.git.ecree.xilinx@gmail.com>
References: <cover.1726593632.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4c619a-c03b-4ec6-a8e5-08dcd7fd789c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jxvGIr3uMnXHFah0Lgi20Syz7WjfsvA4PVpjY74JruuDjSapO2IBOtLPhTCR?=
 =?us-ascii?Q?VVeS38nt4MzegjBU9frOxrlDXuCK8NkJ0ez0SDE0WmR+YIMFAjbAjpbL91XX?=
 =?us-ascii?Q?4kLSw6JabGcUJq0y3TV4aUyURvjdEGdm/WTk8CyNHVkaEFP5YTisYYEJFOTN?=
 =?us-ascii?Q?o/Lov2Q4TQNc6wa162xeVMUfDjT7dGtAqFE8TlZbb8x5LPEYVpglJ+43z86E?=
 =?us-ascii?Q?tRGJDySKXgXdAAfzzRkWbZAYsykELH5xyzwoe2hPUlZ+qlr2o2ltQRHirVuX?=
 =?us-ascii?Q?E5vKR5Y2qWw3VNV2DRthibChB5lfjuPBNhVe8adr6Pz4bR5BxcYYnZWSgzXJ?=
 =?us-ascii?Q?Y9xHAdZe9FO+BtjgQL7zegzmkfKnlHAa8dG5r1ksg0UmTnCTEjPPuAOz5eWW?=
 =?us-ascii?Q?RGJabR28psoNEKl9+S1GHHam86fxe17ufAxeeTOBoj5b5Y8ffQaA9gko49sP?=
 =?us-ascii?Q?trOX6uK1juKVLdqMjQeYcNkAdcGT9Nod/XPQOwm8jm3rM7s7+yPeG5zrY14H?=
 =?us-ascii?Q?V/GpypuL8uMiUfEPvPrwHDRszdkmvO8SdOrgHdqANuqleqoeRDgRgWpjxPfx?=
 =?us-ascii?Q?uOgY7FLDwKyg27LZYFDYpjZ+cOA06dbldfQjXWgi4An75J/vT/Z5uTJLOmbM?=
 =?us-ascii?Q?sVkxuGbT6/M9hoddyofWPgiSdiIYTWWDrNZsMwCfY+FYH1buGM65NnVhIXJm?=
 =?us-ascii?Q?k7lHPNhXHm3Ir1cY9U5MmE/bUU4GfM7bH7KyrgDAcRErXwzaQTLbsHwlMxbU?=
 =?us-ascii?Q?AqaamT8/MDP0SMKnDimvCHY5SefghAlLnT1bSVIcWIgDhD+r32VtDtfoAzUo?=
 =?us-ascii?Q?ccMaSdpKVK3hBBcgaZCcDpp7B9BPj1PxKrLic/7UmXB3JFDjeQPyJSlcUkc3?=
 =?us-ascii?Q?xOjlPTFkHfp8YtyLyix8zTx5xXui3AmuP+J2h8CTjY36Xl41r0EUAWrPzVDO?=
 =?us-ascii?Q?W/4wjb7p6zHxBgDsahynhJFmUx9wYV7Gaqq1de1vQiNBfRd+SmdveVWOBD2E?=
 =?us-ascii?Q?BtR9yCBnkKPiUgkmcDXQFo/P8caqS6baPqx9ASXd4fDBQYXR3s9ptgEu/0Dx?=
 =?us-ascii?Q?obsS7wFEzbc9PRDSrmX5XPZzIDcCOi+EeObr1mhoZ8QUFj5Fd4x/XQ3cb296?=
 =?us-ascii?Q?t0pC/4aUi7k5YFWEEXvOyGvSUSzRFk5pRuc2lSyrc4ILXVCLYHfh7NP0az/j?=
 =?us-ascii?Q?q79bkEBaZJR4IDIqlFL7YsLH3kchREM3zExnA4xsRHjdprzU61PS01b7NavT?=
 =?us-ascii?Q?Z4u+03zKvITLzWKK9CqwhQ7P88+dExV9f5e3aWu+QTK47NRJz8mktzrWnnes?=
 =?us-ascii?Q?Ox51cwcRu3HAIoVoYY/Kf1iwHZm6s51qxH8pnxq68ArIdDoLDy0Oomh4Tiq5?=
 =?us-ascii?Q?uN9X5mIWQ77LEUL0PyONONGOPkimAn2muYk4InP3LFOZ/5LCebLw+lDYJty3?=
 =?us-ascii?Q?r6vJPbM+ZbSKcyLMVEHkFmyZEEspOnPt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:18:02.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4c619a-c03b-4ec6-a8e5-08dcd7fd789c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

From: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c          | 15 +++++++++++++--
 drivers/net/ethernet/sfc/efx_channels.c |  4 ++++
 drivers/net/ethernet/sfc/efx_channels.h |  7 +++++++
 drivers/net/ethernet/sfc/net_driver.h   |  7 +++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index ea1e0e8ecbdd..b0ea4ca82cd8 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -638,6 +638,10 @@ static void efx_get_queue_stats_rx(struct net_device *net_dev, int idx,
 	rx_queue = efx_channel_get_rx_queue(channel);
 	/* Count only packets since last time datapath was started */
 	stats->packets = rx_queue->rx_packets - rx_queue->old_rx_packets;
+	stats->hw_drops = efx_get_queue_stat_rx_hw_drops(channel) -
+			  channel->old_n_rx_hw_drops;
+	stats->hw_drop_overruns = channel->n_rx_nodesc_trunc -
+				  channel->old_n_rx_hw_drop_overruns;
 }
 
 static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
@@ -668,6 +672,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	struct efx_channel *channel;
 
 	rx->packets = 0;
+	rx->hw_drops = 0;
+	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
 	tx->bytes = 0;
 
@@ -676,10 +682,15 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	 */
 	efx_for_each_channel(channel, efx) {
 		rx_queue = efx_channel_get_rx_queue(channel);
-		if (channel->channel >= net_dev->real_num_rx_queues)
+		if (channel->channel >= net_dev->real_num_rx_queues) {
 			rx->packets += rx_queue->rx_packets;
-		else
+			rx->hw_drops += efx_get_queue_stat_rx_hw_drops(channel);
+			rx->hw_drop_overruns += channel->n_rx_nodesc_trunc;
+		} else {
 			rx->packets += rx_queue->old_rx_packets;
+			rx->hw_drops += channel->old_n_rx_hw_drops;
+			rx->hw_drop_overruns += channel->old_n_rx_hw_drop_overruns;
+		}
 		efx_for_each_channel_tx_queue(tx_queue, channel) {
 			if (channel->channel < efx->tx_channel_offset ||
 			    channel->channel >= efx->tx_channel_offset +
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index 834d51812e2b..44d92c0e1b63 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1100,6 +1100,10 @@ void efx_start_channels(struct efx_nic *efx)
 			atomic_inc(&efx->active_queues);
 		}
 
+		/* reset per-queue stats */
+		channel->old_n_rx_hw_drops = efx_get_queue_stat_rx_hw_drops(channel);
+		channel->old_n_rx_hw_drop_overruns = channel->n_rx_nodesc_trunc;
+
 		efx_for_each_channel_rx_queue(rx_queue, channel) {
 			efx_init_rx_queue(rx_queue);
 			atomic_inc(&efx->active_queues);
diff --git a/drivers/net/ethernet/sfc/efx_channels.h b/drivers/net/ethernet/sfc/efx_channels.h
index 46b702648721..547cf94014a3 100644
--- a/drivers/net/ethernet/sfc/efx_channels.h
+++ b/drivers/net/ethernet/sfc/efx_channels.h
@@ -43,6 +43,13 @@ struct efx_channel *efx_copy_channel(const struct efx_channel *old_channel);
 void efx_start_channels(struct efx_nic *efx);
 void efx_stop_channels(struct efx_nic *efx);
 
+static inline u64 efx_get_queue_stat_rx_hw_drops(struct efx_channel *channel)
+{
+	return channel->n_rx_eth_crc_err + channel->n_rx_frm_trunc +
+	       channel->n_rx_overlength + channel->n_rx_nodesc_trunc +
+	       channel->n_rx_mport_bad;
+}
+
 void efx_init_napi_channel(struct efx_channel *channel);
 void efx_init_napi(struct efx_nic *efx);
 void efx_fini_napi_channel(struct efx_channel *channel);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index aba106d03d41..f6632f8185b2 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -494,6 +494,10 @@ enum efx_sync_events_state {
  * @n_rx_xdp_redirect: Count of RX packets redirected to a different NIC by XDP
  * @n_rx_mport_bad: Count of RX packets dropped because their ingress mport was
  *	not recognised
+ * @old_n_rx_hw_drops: Count of all RX packets dropped for any reason as of last
+ *	efx_start_channels()
+ * @old_n_rx_hw_drop_overruns: Value of @n_rx_nodesc_trunc as of last
+ *	efx_start_channels()
  * @rx_pkt_n_frags: Number of fragments in next packet to be delivered by
  *	__efx_rx_packet(), or zero if there is none
  * @rx_pkt_index: Ring index of first buffer for next packet to be delivered
@@ -556,6 +560,9 @@ struct efx_channel {
 	unsigned int n_rx_xdp_redirect;
 	unsigned int n_rx_mport_bad;
 
+	unsigned int old_n_rx_hw_drops;
+	unsigned int old_n_rx_hw_drop_overruns;
+
 	unsigned int rx_pkt_n_frags;
 	unsigned int rx_pkt_index;
 

