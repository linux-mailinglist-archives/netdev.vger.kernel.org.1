Return-Path: <netdev+bounces-128844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BC97BF0D
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F45C2839AA
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71E1C9DD2;
	Wed, 18 Sep 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="udLGlRPH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820601C9859
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676284; cv=fail; b=RIEsv0MQKApjHCDUJKQgCDBqqMzX1BlyLMiIIVgWwLI93Br9alBEKSxI0eVvopa/DCOIn7UVNqVYh7B4MCt/OQxfNkKsCSICyAMm3Hk3VlsfjJCdzDaYiIcWkjo3g3vBBDJ0lzR8OOYcoc3V3qCbyOW+6eNhyFzvBaX8PE3O1Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676284; c=relaxed/simple;
	bh=Sv2mycHhzFpVHsrctE7MCekDFFjNnnCL3dK4OGEkgkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgkQmBkhfpWW5ekwxy5QbivYzMCdtmFDgaS/GmbOkHOGJr4v4c/yw6fBH3DRSCIu6juf5x2LQ6+5ky5Mrf/6ZrT2yUtqh1wZNF6REGzE9PJm669IHoheK3Gggc54i+AfvUd+jOjrF7N8uxjGk9PbAz9kX3NHoZucRWZMJqE55YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=udLGlRPH; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy6MTSKZb7uGAj0o3/t1j0sQVLeDVpEOekRVB7B7HkS0djNqUwjgZQFhQsVPucOtqX5z1nhuPiVwA5AQKpjQp+Dns117+l4lRPAIbfzBzPuu3T4nQECXPP6ex6zVLcQye6lJO3NReR34OO9x0Nr7YQ1W6X9iQ6pMAZ3X13rxvsgCvQ08boZ6zMBhmyQUu2QpHYQLoAw5WwU02tPpVH7PfCa/igYZTulkPtrjllZu15F0nUjHDmFGzjIJbV6F9AwmGnVEN8KiDL6NEXoQU8iR7ATf4UkNFkaTi2f22j40yhGVjxvGSM9d12FejqrcxJ3PnV10dbL2ifnJtlUp4qdAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zISJWpQ2SpzB5m7k/RMqxVfAEusBDzbIBbzcmBv56k=;
 b=LOiwSqcpyRNKok/pmwpuBc0GHa80UgXzY9toff/8D9U0/cMYl7UHQbkN3dsTEtdEh87mDdtiVQFah9Ji5Fy3+pcQd4T4wjSXag2U6Nq+pt9dsx6NxnXnyy6uoYLK25aexjIW9C9M0I/ShO3EZZLGlVU7I6GSgyRabiKoDGir9NFBoPtMHJ/KUuHh8/2V40v0Al4nfiBOpUyliLmaoUqeOpEiBqrdAyVUvZKwOZ45HeIHaIs1pGLJqV+/KQDi5G9kHe5qEFA8YgoHxAne3Y60l9+ANxchyboZIz1GMk7oTgkGyA0Y1JyO0e7GgZNxhPEsy9tyx0g3p4kadraAA14Mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zISJWpQ2SpzB5m7k/RMqxVfAEusBDzbIBbzcmBv56k=;
 b=udLGlRPHZH8ECuBXZpqBW6hy/8gpygKu2ZPc6kVcbTlHZOF4FhV69nk4KhGG91hTIlSPwXxx/Pof+jKrpHWOh0kHiGDp4GHsTPDE7oUQ0xGJmNSRgkG5Ehy7XKbrAwPeW1ezEVmblrH2ssgwu2f7Cz9aQTv7GPSYHc0lnsmcyp4=
Received: from MW4PR04CA0271.namprd04.prod.outlook.com (2603:10b6:303:89::6)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 16:17:58 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::9d) by MW4PR04CA0271.outlook.office365.com
 (2603:10b6:303:89::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 16:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Wed, 18 Sep 2024 16:17:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:17:57 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:17:56 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 3/7] sfc: add n_rx_overlength to ethtool stats
Date: Wed, 18 Sep 2024 17:14:25 +0100
Message-ID: <4f5c470b33c7dce945c2d667f3282d7863904a86.1726593633.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0f6e32-53b0-49c8-e782-08dcd7fd75e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LDdMM90CnwyuQjDJqQ6F05YRReFRpi9xD8aF7jGiRQyqkiPY1vpVh9FxJ5vb?=
 =?us-ascii?Q?Rx+3iCH53yuVMuCjsFn3cIbierSaaEwpWCnLFkKds0R+5sTaSPP0gikgVbFJ?=
 =?us-ascii?Q?kZVyaUhNaDRFk1ALnD+koZ/i8wqluxdEJBF+f0pnFxoy1tIOy4h9WQFgB0zj?=
 =?us-ascii?Q?vfWO7uQ5x1QSmig3/O5w2FHCffc3qu+ikeMsEPwlBZW3RBjEGfHtxlt3BTO+?=
 =?us-ascii?Q?cVr8XqeAerxaruaga9f5huPCuOcacCHG/i96W712J3L+vyqk7/ZXHSYFiBSV?=
 =?us-ascii?Q?gBJPt4DuHo4b/RlZLTwo0VOpbBEio0AGvkc5xWa8YFUAKC4cbiS1nNWwPndn?=
 =?us-ascii?Q?jDCB30bLxvDf8/iU4f+9Bceymf63nIVZTC9BZiwwbUn4wLYy7fFobqPdemNx?=
 =?us-ascii?Q?ZRt2XnNoHM0+zZ6cF4RI1blXiOHMHS0eOXb8kOu/Zun5LD5VyJH14ACFgxBb?=
 =?us-ascii?Q?nXK85AZn6K5jKfGdNOJAPhXNSumJPjdVblJF/MgbAyWkMuFPyZ07CxwMeg9F?=
 =?us-ascii?Q?3jfKXbEAlruzZZ0VbZwdsIHx1Vjv5tdfjho6XcCgmWlVgo+rq0ANLQkmp12D?=
 =?us-ascii?Q?a7IoCLW8tZVFaacCFvYL+VHy9ZEdYM2r3Yxbnths1AWXF+icNIEA0CeaISM3?=
 =?us-ascii?Q?SW/HBFQBhBnYJRCw9qdn5q1dSnAqki9B8sOX2ng2jTY+GXEkmwN49296Q/tR?=
 =?us-ascii?Q?o7phLeZoG0iy0/IWkP7rhXIZnicGk8PrNHi/jMChLZfI306pVpKG51EaapMp?=
 =?us-ascii?Q?AZiKCb8mwIuWhhbov69G+fcY9DX/PADN0s80gwrdaS5Ng+2Y0uq53YPm1v0c?=
 =?us-ascii?Q?mkV1gBtAtXuMn4/H1IUBxpxIUIhDYpegAO5sgtfJbzlLpKMPnNM8UjxVkhEY?=
 =?us-ascii?Q?5LENFZDF2WzIm+FU2Rt/TIqJNFn87WwxS6kFEL6fD+OAMgVHqtp9miOgXq+9?=
 =?us-ascii?Q?duwynZOH7maXDKIYUu2f3udYgSYI6rKrVFH1BMAAIVvVbW8pcp4ONahCjkK3?=
 =?us-ascii?Q?McnZP+c8PVAFO3BJiPDOphrOrSovZobFHj+vZTzEHTibfvkggxxwOvjg97rL?=
 =?us-ascii?Q?/ZvDM3yMRnVTv6y10pdL8ht1JAVHBkbg4HclrSrMlf2lGrPTKqBSO1InHjE5?=
 =?us-ascii?Q?8jdWw+gad9CqcBZPHg/ZTcMj8Hph5BH11LbPaemWHr2u4qlR+7eL7HQVWbLD?=
 =?us-ascii?Q?8sDQmz9sE3DqNFt6Dp7ge6aB+Yktv3gfSYKgcbrCD8AoiaFDhyPhXRqcr8Bi?=
 =?us-ascii?Q?/4K8AnaXutMARiqUybWVaXU1lbyO2HTMDEL1JlWPmfYkij16SnZIBnHs6KwH?=
 =?us-ascii?Q?GWvLEDtTzE8A4XS/bu0RwX5Dx6WpVz1rHpBrrEHDUlD/jIb7HYzL+LOFCNgm?=
 =?us-ascii?Q?rXnOOfWhCp2Y3Qr5WvywGIfxn12DzSvpvQR6VA+cbkc8lSEPDfkPQyRCZAzF?=
 =?us-ascii?Q?z/H1//po2/WUgIV4iIXn9AS5p18fWUXM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:17:58.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0f6e32-53b0-49c8-e782-08dcd7fd75e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

From: Edward Cree <ecree.xilinx@gmail.com>

The previous patch changed when we increment the RX queue's rx_packets
 counter, to match the semantics of netdev per-queue stats.  The
 differences between the old and new counts are scatter errors (which
 produce a WARN_ON) and this counter, which is incremented by
 efx_rx_packet__check_len() when an RX packet (which was placed in a
 single buffer by SG, i.e. n_frags == 1) has a length (from the RX
 event) which is too long to fit in the RX buffer.  If this occurs, we
 drop the packet and fire a ratelimited netif_err().
The counter previously was not reported anywhere; add it to ethtool -S
 output to ensure users still have this information.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ethtool_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index a8baeacd83c0..ae32e08540fa 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -83,6 +83,7 @@ static const struct efx_sw_stat_desc efx_sw_stat_desc[] = {
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_outer_tcp_udp_chksum_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_eth_crc_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_frm_trunc),
+	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_overlength),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_events),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_packets),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_xdp_drops),

