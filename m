Return-Path: <netdev+bounces-125611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E696DEA0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314FB282A3C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DAE19E7FB;
	Thu,  5 Sep 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yRMcbqdE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865119D8AF
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550956; cv=fail; b=uoBRwux2OL6sD3nzcsgNwukYLpLnvRSZ0Ab+BGATsWvMiQ9gbEce8rv8UNegueqt/FETb7vKpK8cOepeMN/OA9tGXXOF8lHm8aIrOwkoONiuEyjqRDV3cnjD+hq6pamrvGO7EpSrKJhuWuRDFdFFuHqWkW8CdAXKZxTs2qUa374=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550956; c=relaxed/simple;
	bh=X2BfUyal9bJX88ry6rtprIFduubuwovJQD6j/b+Sh6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac7mhvKk91wuEFtRv0q7fi5KduYDs7rorkJIQT6qKQqqGRhCDjU+LI9tCul/0o3md8FMDzQ/cam0y4EqPog387M84Ww1EldvAs+PausM5xbWREXn5KJFW2k8MwZ+yYUWPUshZWNtn2lOquMkOkvx6D/RhX9RJ1gLNGAPAHhvI3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yRMcbqdE; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoFVCV8Dkwa8aeFHuka4m04OfGYx1lfKN/YlXCTYKeAskQysUeXFleVcNglEkIDOOK0OIVV8CzgDNW2tcPDqIl/yZlbtl/nZAVp0mG8bqQuUy6ibWyMpyB4ef06w2kxvGPjGYHD/MuosgDMYjE+GVHkK6LMyJQ8CxRlX+iiNETIkNG4XlR6gXptr8bJcBx7ss50TfxoWptn4LwTh1iz5o0A09NNZdg2C+xkwMRO7Q9dPE2PchwXPrP/iipaYxp1ZvjzczoPOS9yE+WAtOrxcXyzSpsfow7FC2F7oBtU+4t6glyopGWEjDS50eKsn733m4VY/Okxy5MrwGfu6lMAJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f6RCqIx5Jt7heTaIeRe0YJcQByO90wG6XihwTtiEc0=;
 b=STwHpkeU+of76lB8rziulkIGT0MTppmv1nx9iW7M7heUVs8DQM0DT+HdaTy3ASYFVe3RUkLE6FfCU2xiInwfT/in+U/PTvtCgyXZcECLtuEEWy/cBaxwNNc+HU+GAEBb2wNgTxpn9spfyGm1zRM4mM50U34wI13WBTbFUZHT/j/OB0lloBfDHDn7EoBa6E+H3Ncr4i5OnCkQv/ZaxL4scS/TUIWUlloNbUkxGYUhzlTpq0zWEK5spkdqc1lph0XVC95tBEQWXsXIFjoIRDx7oi2nkke1yhDwnKwVqCwT6IB57iKSioF/VHQy/GK8AH2l2Gzca64Q3oBeGTfLd0l9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f6RCqIx5Jt7heTaIeRe0YJcQByO90wG6XihwTtiEc0=;
 b=yRMcbqdEozNwUsaUM65qDVwpOFgiBG+SIc43cdPkIr37aZj3yja3SwyQQZNfwXz98elC0++y2BLxrkv61/7sSrTAcMT+pt+K2ZcE1sOczEc0jOBSiovcoeaRBApDNnYxdxXw1xGwuhbeFceAvh+PUDPJH3k+pdd5dDf273CGfVg=
Received: from BYAPR07CA0088.namprd07.prod.outlook.com (2603:10b6:a03:12b::29)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:42:30 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b9) by BYAPR07CA0088.outlook.office365.com
 (2603:10b6:a03:12b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 15:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:42:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:23 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 10:42:22 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v2 net-next 1/6] sfc: remove obsolete counters from struct efx_channel
Date: Thu, 5 Sep 2024 16:41:30 +0100
Message-ID: <a0131a42086c237db1257278f680577fd7928711.1725550154.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1725550154.git.ecree.xilinx@gmail.com>
References: <cover.1725550154.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: b91ff6e9-953a-42aa-3191-08dccdc159e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DWMmh9wv4pVpqv+/LnwGd0RNiLhWnpwNdy8XhgwJTKXwVxZSgQ/0XEtCKY2M?=
 =?us-ascii?Q?b1THGNGaVJ6L1K4DSJVxBtJA4RPMaR5ua4a44AQsnwmx9TzCkxXsHdENL8JS?=
 =?us-ascii?Q?cwHz6VCeM9AMWipTo1upP26MLIJMJRu17UoJaYTqzdCFXHrJJka7mcN5P+2n?=
 =?us-ascii?Q?qE/r6tULhlnWywurBYFKSbiu+YB/+Q9PXp8PKKkbM8/wIWgi2y5QPSefuDiB?=
 =?us-ascii?Q?TK7tdv8RNSyVIaHxdJTXX/ggqhhhTCnGvqC+zznWlkpjhQBZNKScXTfqRmW1?=
 =?us-ascii?Q?Gms0FZvrXk9urwaRToEs+NWjHoJ/PEmQouk4Ge8M3yYaLnOjnB7CKfwfXPDN?=
 =?us-ascii?Q?RBtKVk6RmifE1PoZzXR0mT2q9XTUQ4R8QkW4b8MfADXw4aHFlV2UNw5+yvUF?=
 =?us-ascii?Q?BBo6A5b4BTWqcsU63/zk7GAV1tZq9/w6E2p3cluRQVagWvt2n8cwQIJtse86?=
 =?us-ascii?Q?dmmvUklKTj0jMKDOqwtrXGIM3mpbTxyE8roZjP8y46RNRByMU6IjQbOk+mOC?=
 =?us-ascii?Q?aeqGhYxhw4zCfvfw8fQps7qOZ2n87FydgGOA+BSgshUe3zDCTnUfCucC29eM?=
 =?us-ascii?Q?zvhwvc/NynmOCuYAcR02IWyJGYyUrsBP9ycyLWpYle98iWJRSl3tnhH+x0a7?=
 =?us-ascii?Q?IN1VpzAWG8T/7FuINGOSZeTrq650Ne0gGqeIy4z8B+FsY7ViP5XS2HPwR+Vn?=
 =?us-ascii?Q?gjVsctQjdw+UZlMPnI6i/Sv0USNO+ANlCt1zaHaLrXjtNsVYeH2NcPLMwg6H?=
 =?us-ascii?Q?LrJpCWz1ebzuN0WwjrLd+aDgGclolbIEypn8vs7Gu3ipCU0JvI7LIamq1IKP?=
 =?us-ascii?Q?Z+w79UyxDvmrefQX8Ke18ZsB/G//f49CZBaDxMfJkJ0642g4OshXmzHrBZT9?=
 =?us-ascii?Q?kyCaRlJNoaogp+MS31H/XypyeQvnZYV0vMRF+DwH4NDHRgkmRPtmEjrwvzxP?=
 =?us-ascii?Q?1Dud6uCYrpQOAG7i9nEypAZmKvZ300EdouY9b47wWhH/m6Fazx8LVSKqONxc?=
 =?us-ascii?Q?zApBrDmiQxHqEZlf0xHGK12ZCKq0PyktGX8+VzxzfAoa/KvNyPtDtUqjrlb+?=
 =?us-ascii?Q?8+suzb1b84qBbjBhO6c3Hx/ByuBccMbIvqruDrIPW8VAhowZ+hivlamw/vRs?=
 =?us-ascii?Q?LEprgz472FfDxvLzcf1anKPHRqy+axRM4FjRaBxVWsl1sMjzy5w3sff2CuKR?=
 =?us-ascii?Q?/5qPMm1CFM1tvJx+68bpiAB8ft0RFNmNuDja+lJ5SjPVxelgL7Ve4AgDt2NK?=
 =?us-ascii?Q?JAG6qoNMRbu/h92lkz6ONB5DyvjI2J15W2CrnOkCx7GAaCTjI5SLv8SUEuuD?=
 =?us-ascii?Q?txX425eSpdzWxw+ieVcOfFYcZR0Uw3oU2GBJsHexP0bDZy6bSz553J1uPUde?=
 =?us-ascii?Q?8g1BVs98S3LQjBLVtXd/ogknZ/S2DFXwaFr8/2jp8XY8UvOI+DTXiuWppRAO?=
 =?us-ascii?Q?Ef9soNqVSsVo0t56mifJyvqJ6HmRfHts?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:42:29.8739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91ff6e9-953a-42aa-3191-08dccdc159e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

From: Edward Cree <ecree.xilinx@gmail.com>

The n_rx_tobe_disc and n_rx_mcast_mismatch counters are a legacy
 from farch, and are never written in EF10 or EF100 code.  Remove
 them from the struct and from ethtool -S output, saving a bit of
 memory and avoiding user confusion.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ethtool_common.c | 2 --
 drivers/net/ethernet/sfc/net_driver.h     | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 6ded44b86052..a8baeacd83c0 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -75,7 +75,6 @@ static const struct efx_sw_stat_desc efx_sw_stat_desc[] = {
 	EFX_ETHTOOL_UINT_TXQ_STAT(pio_packets),
 	EFX_ETHTOOL_UINT_TXQ_STAT(cb_packets),
 	EFX_ETHTOOL_ATOMIC_NIC_ERROR_STAT(rx_reset),
-	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_tobe_disc),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_ip_hdr_chksum_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_tcp_udp_chksum_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_inner_ip_hdr_chksum_err),
@@ -83,7 +82,6 @@ static const struct efx_sw_stat_desc efx_sw_stat_desc[] = {
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_outer_ip_hdr_chksum_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_outer_tcp_udp_chksum_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_eth_crc_err),
-	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_mcast_mismatch),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_frm_trunc),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_events),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_packets),
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b85c51cbe7f9..4d904e1404d4 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -451,10 +451,8 @@ enum efx_sync_events_state {
  * @filter_work: Work item for efx_filter_rfs_expire()
  * @rps_flow_id: Flow IDs of filters allocated for accelerated RFS,
  *      indexed by filter ID
- * @n_rx_tobe_disc: Count of RX_TOBE_DISC errors
  * @n_rx_ip_hdr_chksum_err: Count of RX IP header checksum errors
  * @n_rx_tcp_udp_chksum_err: Count of RX TCP and UDP checksum errors
- * @n_rx_mcast_mismatch: Count of unmatched multicast frames
  * @n_rx_frm_trunc: Count of RX_FRM_TRUNC errors
  * @n_rx_overlength: Count of RX_OVERLENGTH errors
  * @n_skbuff_leaks: Count of skbuffs leaked due to RX overrun
@@ -511,7 +509,6 @@ struct efx_channel {
 	u32 *rps_flow_id;
 #endif
 
-	unsigned int n_rx_tobe_disc;
 	unsigned int n_rx_ip_hdr_chksum_err;
 	unsigned int n_rx_tcp_udp_chksum_err;
 	unsigned int n_rx_outer_ip_hdr_chksum_err;
@@ -519,7 +516,6 @@ struct efx_channel {
 	unsigned int n_rx_inner_ip_hdr_chksum_err;
 	unsigned int n_rx_inner_tcp_udp_chksum_err;
 	unsigned int n_rx_eth_crc_err;
-	unsigned int n_rx_mcast_mismatch;
 	unsigned int n_rx_frm_trunc;
 	unsigned int n_rx_overlength;
 	unsigned int n_skbuff_leaks;

