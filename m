Return-Path: <netdev+bounces-130405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C398A653
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018231F24189
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2372191F99;
	Mon, 30 Sep 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P0DHc2K7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B9191F98
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704409; cv=fail; b=JLhYzsmqhYo+7I4lU6IsoMBaTdwLFh71dUFpXB9hBrA2sa1GcdNXDdVqThlLEQLY51MjMWI6vRdesIjhei9VnDJoieyp1bPNVwJW+gr+DCvZy0E8RkeSqAAhThO2ATaCLbEHput00trdFetDQ4Hp0kwJFBsS9h7EOl44tFf/6hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704409; c=relaxed/simple;
	bh=0/70hIQQICgzkO7E0pa6R7OVvuAqhL/r0D9ioGXmsZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeHomkdYj1lDop088PTVl+WZTbIbVLnD5tm979+p+S39Bqg2w1OwE4j+RkyQHAgDJlIy7feu2XeOlsF3EyzJ8N2ZEKzaxKXMRv2iOUO5UTVutyUBwemg9YrGOjdXwem2eO8gh/s3d+j2jRFs0qkt8myA6BDa/ic5e+9IbGFxX3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P0DHc2K7; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dysKDOgpR+ax2QoGvEHBTZptu+BNo8MYCeLpl9+V17dKrc1iWopQe60e8AruSrU6u/HmynM7PWUWOko9exCho0R7KsMk9cN3O1jCIAZXav03KPUyR5U83cigdkpt97vzXtWSyM+86wtZXjx4EBGkIZj4m5hNgBLBqt9642ZbiEIqmAFSAw0VC8h5l5+u9pvgzlG4BCaPFRpaiPaDLp9g8CfgAJKq/rb5XrWAkeHDEfREsYAAs6eIO1JP3KtqMyzFrrUjStVQ+aCsvUbRTCqhqoels8ydvaGn+1uSL9qi7Ac1HxMLvSMwfZPiaMDJY1yMjka6VWnO7ZvMYj8jI3O4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCsl4DNyN0oLo4i5pw34tWd1c7vE91RPdbeEum7kDpQ=;
 b=DAJwzxTPrPvaLZxZpO0cle6tiEH5BNycAQoRT4ILFgGzAkQ14Mf7gMZwL0y2bROfA9MB3Oaz9CCD6GAIwb/HEj3ssyVfbCW5iTdkUWhyR1SJJKNsJNlHxbb8zAJA9PryEZLowo4oxP8YS9FiYhhSS5whVBLh6giwwvdZ3J+txdr7YcfhriPhm1b33qDs9E/0yWPL49PYbUEM8uqYN09y4gIsej8mVVduOGK0ie+oiyY/Oqckj0+5efHTYDExzIhuv9KZX9AqpgDi45v3BbgrfFyuGZapAsvgPeGeJBKgS4zaXx/C4CEmtHTCeR2X7jU6ZIbKKEytpb34TgNUFZCXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCsl4DNyN0oLo4i5pw34tWd1c7vE91RPdbeEum7kDpQ=;
 b=P0DHc2K7RhLwRFfZ+3f6cidEppizsCxLiJNcs8L+e0eQozjzz8CyNXIn7hkxKurtz+9b/TzSf3skFaEwOtI5DXJ6cXfNw6wtgnQrpBNIqyLaJPmiBvJNs1HdOcelP3N+9WYrNwA0sieYdS7HdGOKwqNb4XWs3R+9z+mEr1uBLjM=
Received: from MN2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:208:1a0::36)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 13:53:23 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::65) by MN2PR07CA0026.outlook.office365.com
 (2603:10b6:208:1a0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:21 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:20 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 6/7] sfc: implement per-queue TSO (hw_gso) stats
Date: Mon, 30 Sep 2024 14:52:44 +0100
Message-ID: <8318093725878504a2bd75aa807cf8e8d6d9feb7.1727703521.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1727703521.git.ecree.xilinx@gmail.com>
References: <cover.1727703521.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6b9fbb-cfd3-44ff-b40a-08dce1573fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VYxkMR1aPpcIfgNX4K5phVWZ2XsRBni9hypcXeJVkMtLA/sX1yr0RaxShHlF?=
 =?us-ascii?Q?JxUIDR2sTyyWlo5hvlhwAgv2GMVxjQ7xuGo2j3FJ0ar833xcGH/BrbVYPXd7?=
 =?us-ascii?Q?BG/tHgI6P7lPkw4X9CDyMxSYLRif9lzeBanJiknfbjCKUkLuQ6x2FRTOt7ST?=
 =?us-ascii?Q?CJlLcQhSEs5FRwC/g8uV1hWSZKJNSC5qfCR8sKFn4XjPbJ0yLkd3wq/Z3N9G?=
 =?us-ascii?Q?tZeix29PT57xhM8EqMk9MoTVcWznoaWXvQx6SIRNFdJuIMAD4LRAuhL4IEYG?=
 =?us-ascii?Q?53AM7wkTPT/0Ghirsgt5JMYIN8Lum98PaURs6oFxRGQZ2648NyP3E/wSAT6r?=
 =?us-ascii?Q?T+llk4QFfNZS2RJAxm2hmDup2jv1RK5cnJGd4/81L6zwT4Kqkp/5i7vacYLM?=
 =?us-ascii?Q?CbmEWZ/4n8zLkotonnWKeH2/ifVgy9+wqfjqDOnrtC5yCUmbBls2vreUjEf/?=
 =?us-ascii?Q?srLZlaJc/+jQF2qBL594vk3nhct/KeVr9q23wPmiV17Hy8NoXKCu+J5Q+o1j?=
 =?us-ascii?Q?Ua1P4PepjK4WyiygqItp2mCJ7t3Xmc3Y4Jq6IUSOLQlgsAKonJrmMXxm7dIb?=
 =?us-ascii?Q?oIL6sE93zUi6LlyFyp2IEmBnj3frrcwAF9CVM2cMhJGFp376liL4blbX6QsT?=
 =?us-ascii?Q?Ud93ZZnVaBQ5ZELUnD7Rrio3nCxytC77pg20PUSO0Cnzc/ELoprTF7Sr1gHF?=
 =?us-ascii?Q?IxFVZseA4ZA/XzDTR3af9qi8fY2vJpp3N4F90JE6wGTtbtIhckTWwx8ESrXl?=
 =?us-ascii?Q?GQ37BekAVmXUER5OKY9WE8k0zLsi0l6i3IIjCI0mAuFouKo4G9Jncb9Mp9F3?=
 =?us-ascii?Q?UdHxuLUJJ0e10+DB7LHUoMwZ1J92Q6AzoI6XXYCmSjypeWGeK4O6+b/I0iGm?=
 =?us-ascii?Q?G8Ft6pd7xKHbCGK55u+E+6wjuOvqmc528Idn9X2AvbEjiC0wvHmNg9td/ekI?=
 =?us-ascii?Q?CCmbWoRI/M2TDE7kcc6WpgkegdB3s/iKJDoBcPdhwgEl4Ho+ySVYlIVkV3KU?=
 =?us-ascii?Q?1ORl9x0HwMIiJyvOZ0ul9CNIzR0ExTTm8aYmUguRb4jrWy+n/xFO1TFHKokz?=
 =?us-ascii?Q?P+yNepNqUsM79kqgOcTQP1P3CfOf+lLaGA1UerXNs3quCiCVdJ4gGCgwrxFt?=
 =?us-ascii?Q?rMZDY1HWeYzVSAuyD09xu5iVa3eadoAOQu6Kv7AQLbEg32ArvQ8Hg0yt2eqj?=
 =?us-ascii?Q?66P72Ak1zpGS4cAYi0iC2hbWjWjDiKP38Ll2BfeTvbhwB/H7p3hd0hznSkJs?=
 =?us-ascii?Q?EqIrt8/+sTOPGw7RJgcBpDEigBZQzLY4ZmJi2gr0AHPTWGGRVp/Z3gWVlspE?=
 =?us-ascii?Q?qhMGG7pGC9yZB5o/AbpXyvVxFfzoHsLW3DxLBC/QlAMG0w0zzVIfZkzFmuEl?=
 =?us-ascii?Q?4Zt8BDkOWzR3y/hFVTLvc9bA+iGrWK0udV70RTlp9jZpEmv1szTbB1roxGL7?=
 =?us-ascii?Q?2AoWYib6/MY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:22.5174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6b9fbb-cfd3-44ff-b40a-08dce1573fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

From: Edward Cree <ecree.xilinx@gmail.com>

Use our existing TSO stats, which count enqueued TSO TXes.
Users may expect them to count completions, as tx-packets and
 tx-bytes do; however, these are the counters we have, and the
 qstats documentation doesn't actually specify.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c        | 16 ++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  4 ++++
 drivers/net/ethernet/sfc/tx_common.c  |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index b0ea4ca82cd8..68ddb28d3141 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -654,11 +654,21 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
 	channel = efx_get_tx_channel(efx, idx);
 	stats->packets = 0;
 	stats->bytes = 0;
+	stats->hw_gso_packets = 0;
+	stats->hw_gso_wire_packets = 0;
 	efx_for_each_channel_tx_queue(tx_queue, channel) {
 		stats->packets += tx_queue->complete_packets -
 				  tx_queue->old_complete_packets;
 		stats->bytes += tx_queue->complete_bytes -
 				tx_queue->old_complete_bytes;
+		/* Note that, unlike stats->packets and stats->bytes,
+		 * these count TXes enqueued, rather than completed,
+		 * which may not be what users expect.
+		 */
+		stats->hw_gso_packets += tx_queue->tso_bursts -
+					 tx_queue->old_tso_bursts;
+		stats->hw_gso_wire_packets += tx_queue->tso_packets -
+					      tx_queue->old_tso_packets;
 	}
 }
 
@@ -676,6 +686,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
 	rx->hw_drop_overruns = 0;
 	tx->packets = 0;
 	tx->bytes = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_wire_packets = 0;
 
 	/* Count all packets on non-core queues, and packets before last
 	 * datapath start on core queues.
@@ -697,9 +709,13 @@ static void efx_get_base_stats(struct net_device *net_dev,
 						net_dev->real_num_tx_queues) {
 				tx->packets += tx_queue->complete_packets;
 				tx->bytes += tx_queue->complete_bytes;
+				tx->hw_gso_packets += tx_queue->tso_bursts;
+				tx->hw_gso_wire_packets += tx_queue->tso_packets;
 			} else {
 				tx->packets += tx_queue->old_complete_packets;
 				tx->bytes += tx_queue->old_complete_bytes;
+				tx->hw_gso_packets += tx_queue->old_tso_bursts;
+				tx->hw_gso_wire_packets += tx_queue->old_tso_packets;
 			}
 			/* Include XDP TX in device-wide stats */
 			tx->packets += tx_queue->complete_xdp_packets;
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index f6632f8185b2..4ca48db3e168 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -197,6 +197,8 @@ struct efx_tx_buffer {
  *	efx_init_tx_queue()
  * @old_complete_bytes: Value of @complete_bytes as of last
  *	efx_init_tx_queue()
+ * @old_tso_bursts: Value of @tso_bursts as of last efx_init_tx_queue()
+ * @old_tso_packets: Value of @tso_packets as of last efx_init_tx_queue()
  * @read_count: Current read pointer.
  *	This is the number of buffers that have been removed from both rings.
  * @old_write_count: The value of @write_count when last checked.
@@ -276,6 +278,8 @@ struct efx_tx_queue {
 	bool xdp_tx;
 	unsigned long old_complete_packets;
 	unsigned long old_complete_bytes;
+	unsigned int old_tso_bursts;
+	unsigned int old_tso_packets;
 
 	/* Members used mainly on the completion path */
 	unsigned int read_count ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 2013a609f9be..a22a0d634ffc 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -88,6 +88,8 @@ void efx_init_tx_queue(struct efx_tx_queue *tx_queue)
 
 	tx_queue->old_complete_packets = tx_queue->complete_packets;
 	tx_queue->old_complete_bytes = tx_queue->complete_bytes;
+	tx_queue->old_tso_bursts = tx_queue->tso_bursts;
+	tx_queue->old_tso_packets = tx_queue->tso_packets;
 
 	tx_queue->xdp_tx = efx_channel_is_xdp_tx(tx_queue->channel);
 	tx_queue->tso_version = 0;

