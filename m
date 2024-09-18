Return-Path: <netdev+bounces-128845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F40B97BF0E
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D781F21E90
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B31C9DC0;
	Wed, 18 Sep 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kMRi9IYA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E671C9859
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676288; cv=fail; b=elEvhTrZzJlAs/SiqJ+6+eJo9fHaBICyvN6Pwrucgjlg3bn5HvlmbXgmC3BXdT2U52H3ymF9ixU0zz+11CKL1fhNVMhAGtW/CEgRJJjZbbFAhbqmofB41R+HHGl4gZHPD6lv6G9rIZdhZX5jrrG9pu5QxkBp7nRkji0yDAuckn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676288; c=relaxed/simple;
	bh=0/70hIQQICgzkO7E0pa6R7OVvuAqhL/r0D9ioGXmsZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sShMi/Hu+kB7yqhGoO87Zrn1SLCRORucqZORq1H9JDImVa/aykWlWILUalRCCG9g3uDCjCp6l/UeETAH1siFn+mhGXFIg1P08tk8I21NMptEEf1KNTMY8jAtMcrtRJi2Nq5zbJWzKgv8XSz+4YZ/QPv8aNcPUcSI6PgrZE3mASs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kMRi9IYA; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu665OgBZNbDXYhJOsjgaEA0nXh+wC/oTTjAu2ZxTLBD/g5F2Es/ijz69Spt3uHpf4wB242CLjyy0G1epFDWEXSUvThut6MC2aPSBU/p9BtWNrqbFh9WGttBRKa59raiiiCGrx6bdPdW/ILur2N24BJdbM4KqhAUpnxs0uPXciX8L5mCRKBOwvOGbpZb87mjg9umMaK/bSh2ZoNEYa9TSo/41jOiqAHrgI4qRDa370jihFQjSCwd8kfB5p+sN7yg2WorT2BiaJkqZngtXJbtpQ2t2jFeShyGqHG8dvMbm06u6lHq/T/IRS1bOw3i1EvRM+aCtaUXGbimbp0VrHehJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCsl4DNyN0oLo4i5pw34tWd1c7vE91RPdbeEum7kDpQ=;
 b=WsXkNGph9MINGPU6BXSJCCmo3OUizz3l1Y8W+5Sfj6Ob5aIy3S1W7azy8pMzIucGAWX851Ht4D+LnCmS10mglbdOOJmSCw0Hpek/8obKZQCDkY7fmhae5tI4kzmMrLIwwxaLYMJZYZACQsKdWD8Hifk8rAjCRVT23ta+pfXestKwZ+xUJktIMz8A2d9TF9dqKPZJjM9lZA67156Hs6jI0LMFRhnR6gxd/WTpRtNxk/BmB7BmCGruwVWmXcj7hrz0zQCvp71EmxeRzzTf+s+AEh4WwhcW4GZuAqRqT65pELTxBR/yGc6a1Xzv14/2V6xxpji2+NtrgFtDaxaiZXzSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCsl4DNyN0oLo4i5pw34tWd1c7vE91RPdbeEum7kDpQ=;
 b=kMRi9IYAZIM/Xeo9BP+VS3U4IUPE7kctuW2oTmD6AKGrqK/WVFPoyxBA4BJGPp3ipgMCXUM+Tw2t0Ch9y2U0mWQQJY8NI+zcW3EbMAh66i68TFUcXEbR3rLo0PaZop7/UmaIeWcq9LnvL7Tgi0xsswpaH7Ay280C/qpiSwgSpR8=
Received: from MN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:208:52d::28)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 16:18:03 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::91) by MN0PR04CA0023.outlook.office365.com
 (2603:10b6:208:52d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 16:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 16:18:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:18:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:18:01 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:18:00 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 6/7] sfc: implement per-queue TSO (hw_gso) stats
Date: Wed, 18 Sep 2024 17:14:28 +0100
Message-ID: <7f2ec1130f96c77785424565d8068e172f88eaa6.1726593633.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad12e4b-c121-4836-85f9-08dcd7fd78cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y9cMMTZzqbVtKX3NEGl/8riU/4MexygCRgBIkibSDIxZujSDBp01blPBazKy?=
 =?us-ascii?Q?ztNg1yb3hkSNhKralUm/1a0wQY2ya+y/oSM3ELtLd8lqQeP9ahQOQVZ5Ofp9?=
 =?us-ascii?Q?k4L7IrXy7GsPOteYrNPmpXyFGb6g5+48O+QGJXnrrnGziw8vedx9ivePrS4m?=
 =?us-ascii?Q?SCD+De3GE7Wt4HmOVRyAiKVR1YmkLyLUouKDbhZJupYeauIjNhui/MKQ2nsL?=
 =?us-ascii?Q?aWsLfkPb6TZ+utCXoAimJ+PpBvJvLbQs6+DFB3GL0kd84CKVoOwnRyGWP9ss?=
 =?us-ascii?Q?kG+PfEnqg873vgeqw9XOTY2PY6PgpHDKUG0BsMOxSKyqfDT/qq5B3lpj2BBz?=
 =?us-ascii?Q?s+gFcTGJxBWz1qYVKTjhqxgmLAXemTgpv12Vo/rDUfssiHs7voCxsFXgkaFk?=
 =?us-ascii?Q?NZLi2Eh9Ptu/zWKGstTInSpbD2TcvOtTYvHzvT7yc60Avi5lm63GrEdc2JUR?=
 =?us-ascii?Q?RNK90a1//CZB5HgJA8IdgPDAvPWW/T2Nvokijufygg9rIxqCcFIDFu3bjzQy?=
 =?us-ascii?Q?B8ANx0fBWk4VjhKY/xqzuo1FdQRKalxC1XPHlipcLrRoJUskcOBsrhyakimt?=
 =?us-ascii?Q?mF8tj+MPL6yDD0DsZhXppQw6VoyFo/zUlNP0pqZEAxlcvXVl1nIg5Dlxkn++?=
 =?us-ascii?Q?TnUm6JALR71B5GM23oHR6fluOYOOMSzimCpK/3DABZN449LcHpoLQU7/MghR?=
 =?us-ascii?Q?mKrTxEbuZf0K2MwWgpUvIboZN3e7gPC+HgMkAraxGZaPK5PD93DA/iQRr4VA?=
 =?us-ascii?Q?hkp4M5Qz9bcyWtW+DEVX1MXsQrPyjer8/J9S7yISou7FZanZ5o1KNCs6Dfpg?=
 =?us-ascii?Q?cL37mT2inT2ooGZCZD49Ovlm2OsiUoas/rsXL/DbZitXPb8b2f5cRslBpkY3?=
 =?us-ascii?Q?IgVzL8c9qOO7CR9b0R2no0RZ5wdtoffgDl0cTWbfgHf9BsKA6bpyqrjY8RQG?=
 =?us-ascii?Q?g/GCTC+5onoIXbsa+bmyh34e+/2it07n/9LysjpkuZf2+wnlz5HRTeR4enoG?=
 =?us-ascii?Q?KfP7VJcpdUJjU2lHX+A+811MZlMvshq4NHSI4MHn6q9VtA2Zm4WTFdDFS+uX?=
 =?us-ascii?Q?5T1Dm1qoqiJSpZkGtS+nn3Yxd9oyRbT5qZyrpKFX3ewNcl5SgY8QcvEce5xS?=
 =?us-ascii?Q?2XeQzF0Om7/z9da4vSjMFcm9PNFmDJfLlF+2mE/s4mdj7CCHi/LAwhDdosgq?=
 =?us-ascii?Q?4XJuQC7+vXNqkPlGcVkilrDhE/te/MKnXarptaG5tKOz+dRkRcWnVwNpqc2M?=
 =?us-ascii?Q?ESECDktLsjl7pQDyAwEWXT/PCYapAngtRWmCE4sahkqLZu7AoCLNjrapJXGP?=
 =?us-ascii?Q?2TNF3r5Wbmykrx3K2L5bccY/LVrhBmKhE7VQveYEmBNvOwpTTd2RhSl0zE8o?=
 =?us-ascii?Q?6oodqYwVN5r3dsZsK0gnU1LdyyAeSmSEy9dNZlEhe9AR9CYwrWi9sxhEij1K?=
 =?us-ascii?Q?vNhZG5zJUT8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:18:03.2419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad12e4b-c121-4836-85f9-08dcd7fd78cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

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

