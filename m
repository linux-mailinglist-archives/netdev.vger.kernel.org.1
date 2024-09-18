Return-Path: <netdev+bounces-128841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610797BF0A
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F93AB21A16
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B01BD01D;
	Wed, 18 Sep 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wflalkOJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B515A8
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676281; cv=fail; b=Oezja3Yg1ctf/nD30Xc0WF2p/h/cn7qNem3p0Ak8Fa6IAnzS1C18a2BEsYZ/Qo69KZpSyE+TJgIoKRb+scbsQD3o+Ha3QkplbnCp3uBXS22l5A0IQR1YVpwn05QKWZWS+ujHj9h6TR/rlMEZgwmTGla00ulrNWwVIkYIFcy3L/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676281; c=relaxed/simple;
	bh=X2BfUyal9bJX88ry6rtprIFduubuwovJQD6j/b+Sh6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKtmC4jNzRIdwheYjCk9v55cTxDdBui5+Qi3OnN4WV+FIpuVQOtuX3/bAOeRUzetMueMWeBQo/y88Ht3Oo6g6c0KmLHf5lYcKbUM6Hl66+1lvrL10tjV6hgxdan1Iny0NkP3W+Og7QKUYnXANaiJOAfqEEFGy1dzS61CdGKqly4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wflalkOJ; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/BF8DbdKuKE+FjBr+oBgRFDurn/4WRA2MGRusIZHtjfqzFaKh+HK+nDtDkIoGM0Ysr2gTatDkXbb3Mt9IKVZQrBau+FVO4I6GYdfqM8sflrZJbS4XCkv1aGpZ9H01i/F12htjiBuOP/seS5jOkFzKhjrXOdvmrZdpCiN5Yg42jXptxZQlJ0o+OOSIDWQ2AsXXk69cKChJNpN6uZ5Wg1NwrkUyhufCXpwZtcagsiJNIoyMETQw1amYP9Mj4C05EkkM5RnQINtR1LATXUe7seqNGnv6JqpggMCLA99h+96+wHcOnB4HLlNx+ssaLfZQd1sSJZZySdDEKVf5szcT7zUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f6RCqIx5Jt7heTaIeRe0YJcQByO90wG6XihwTtiEc0=;
 b=r0KFnw6FL7fDAZHqiV+Gu4SKx7IrQPfE5OX9FOw99XUaZ0V3khbervWKxSZWYvxoixx6xLcVgnkYae6rn/mepYZpXNNLGNqh17jJkty/+79gZ+baLvez6CabsZzh4jy41U1niMdSByBhIQxaaD8m8sCtWQIWW/ySWPIahVReQctTyAwChnE16RWnSYs9CCd3evdcgEpyYTw5vDi21uJrT0rr6gHSb8fW4+YadRu7irVO9ILGMc95SmlRQSFysGPF3cpXSFATOwlFEarX5yne7wJsVHCjQhISNpj1UpteujKNPtEr1vZW3wGa5qy7IpdO9khc8zCOUjdOtL+EdZTlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f6RCqIx5Jt7heTaIeRe0YJcQByO90wG6XihwTtiEc0=;
 b=wflalkOJ2ReFVt8UR0vKpPdQX9FhJp66drpYifuQKfZNeVQdwVuNsibvXLmFXNI4wAMjgthnTkgNyALmhhcp4XLXunxfOpliNSQFp3xZXS9pXbTqVWjofDN5K4nEFTF5pL8aVjrYzaYsExLOrwt28W4ZG3f1CKs687E0S84c3hk=
Received: from MW4PR04CA0276.namprd04.prod.outlook.com (2603:10b6:303:89::11)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 16:17:56 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::ec) by MW4PR04CA0276.outlook.office365.com
 (2603:10b6:303:89::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 16:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Wed, 18 Sep 2024 16:17:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:17:54 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:17:53 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 1/7] sfc: remove obsolete counters from struct efx_channel
Date: Wed, 18 Sep 2024 17:14:23 +0100
Message-ID: <a23750f44910c31ca6396e0a967a9f1ff6140c29.1726593633.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ed86df-4243-4dae-91f1-08dcd7fd74cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQGsMeK5xLkR4MxOawVYcqTaf1lGcZg+9CBhFWcvwb2VwSl99jq4uJ5ktBaF?=
 =?us-ascii?Q?noEd/sN3QuF1tCd2Dku+ufe4AiiNzZtnQU0BtO1mV1WpOHkCUpy+MQNsYllv?=
 =?us-ascii?Q?crbz+mGozaqWTwFef2aWpJI0rTDmd5g0Tj9G7Q34uL9Pc4sfITAbRsk6v27E?=
 =?us-ascii?Q?xkxOt0t2p5tDZBErCy7st8iiNsvj3NZZV5142VmFHVsAp/9VPHdJ0cIARrZu?=
 =?us-ascii?Q?YmpssE276g9faBd+OHPG89oPcr7Bz9XaPQbuEtCrfG/hPtMmkn8t36TaLU2R?=
 =?us-ascii?Q?lDePNpzKFZihohndaSNOswR8vbEJEltCJb7uIY6t7XB3j68NqqHgcJXWAMUX?=
 =?us-ascii?Q?xJI2+Gqg8A/KuCQjWXOQrp7OKa+KUVvB/SvAhzErqXyrokwKLhh4Xb8ptTJu?=
 =?us-ascii?Q?JBp47eEQRwBYhqbC82707Qp9AnZOA4+Py1rjmJWHzwZl+0B1WfCGd9oZCrLf?=
 =?us-ascii?Q?fC5gaY4yJYQJ75bw49uq7uaEM9s3z1px3pnj8JVDTfhz1qQvlJO4LXfy4RMQ?=
 =?us-ascii?Q?y6pnxjzMuSkf1B85HBfG6U6SSAD+5GcoPVCRQznWicv85OlZWBfhfQ+ExOb1?=
 =?us-ascii?Q?NUia56TrX55/t3EE9gpuFryExRWWzR+uPOso68akdzaLYgRLick5puc/2Ock?=
 =?us-ascii?Q?Xah3UwjE/tC1XR776XHF0cBjTPMaIzafT70wbhVJf7tX4PUQrjbARimAQ311?=
 =?us-ascii?Q?CqQQQFqBskv6dFHs4FqtN5XIGcHyNteLGODLpC0R4hSuyM1G/FtELa6PoSXF?=
 =?us-ascii?Q?65aQbYqx5x48n3qX8Da/bUdAMPLH6GzxUfiT+E+WyYOsoNopTT8qHgGTPFZ+?=
 =?us-ascii?Q?Ho85c2jewr36ly1Iigoza1P3q+DVdFwnJjhdKe/i6tL85opY3dx6/TVnvj1G?=
 =?us-ascii?Q?eHd/rsPBKGUXc1hdxS+sK//hrxgDqsJ4UQl1KJ7pCnIChuiTsc6g2wdU+hYN?=
 =?us-ascii?Q?vsVNUM9ypwdH630ERPQNAfJGkmTB7voruW13ycZR+uiN1zth3fbsAbErctnG?=
 =?us-ascii?Q?IIv0tFBhrqWSgSQvP3Wc6rSd+ekJhfDhNMrz0IbzPv1JXRyTywU/ebW1BvC8?=
 =?us-ascii?Q?SPSGhSceEuwxLPkK1YL+1XWauXQhzQX2c3WBmhF9ACDl0PT1loYVDQHEyzUv?=
 =?us-ascii?Q?0uSxTWHTOdOY2FQD6gTAa+svndZci7Yz1Gg5uNMRYs3WW9qjkOMt5IW0+dsf?=
 =?us-ascii?Q?JrM9OiuB5ss2T2ySj4SF+PVeIUNu7EcJjdZjk1bMnQ4kkSWaM5uP9Py/BXtT?=
 =?us-ascii?Q?AuTWDocrCbth9iYcqwe/qzXQYa3Oe5ie/s4Img2eiOuNOznloosATDeUMN6i?=
 =?us-ascii?Q?DHhSJeuYzPzy6KG+fqnzz/HJ47AU6M2xw0Osn0HA/Nm2qPQPSYnA1IPvazg5?=
 =?us-ascii?Q?JC6F3qA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:17:56.4401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed86df-4243-4dae-91f1-08dcd7fd74cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

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

