Return-Path: <netdev+bounces-130401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18EB98A6A0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E67628116C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DD19994A;
	Mon, 30 Sep 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qmIL3HTP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99B191F6C
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704401; cv=fail; b=M8qjwoPE1F69SwtsdZ6iVuaBz/xx1oHI6jGeCLhsaqRaXIlq9gROQNw4e/5ErCDg3PlNGXdT4TdYhVOY75P1f54UWCNzvm8Ftew0wNpOH0yekDYHlnNQZ4D/bvUWhokhslhrTdnL7EPwUY4RoN8SLF/0Xs91zc5f2bJPCObKSUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704401; c=relaxed/simple;
	bh=X2BfUyal9bJX88ry6rtprIFduubuwovJQD6j/b+Sh6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iy0q/zhtrlLc4vX8CvAmbtWEVJ4XrcJ4ucORGgRR1Gh1hLi7RODsE+JYF4x40D5/EdBllJdnzlF0zqkRMurIo3tVdI6oloW9n/mHPAOqSSjsAdY4/io+PMBsgwQ/IHsEQBs+K5yG3RNmEZPz0PMylsQqnWGfLdw36pLKe/AnQlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qmIL3HTP; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyPgsmH0/1+2Q+Yz0LSQqzcexL6VLcU/dNmerPaj7mOmYLd5FImYwd/R2SY4lHm5Wf9LUPBEBmRJLyO0cC/n7lp2YMmFazzDziKlsCIemMdPRljCLkvDG1Hpurns+0u5adkO5xDIFdHKWqZIrk6xBOU6ANWZR7tdvvBWoOibhdJpNmAs6y/MkuRzKu3D8V23NA3PtQ8TtuR/1l1Bq4kaOdy4Gn8W9B1FxG1DOfxenOHgUx7q39GibP1nnvBmFQZHFx0GIsQkqxOlG1eEH8NBCuY/e3Uy18/pxzS6d+wT12eEhnq4gHzrUmFYOaGgTccRO4wLCVwXwSk+t44/3EVSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f6RCqIx5Jt7heTaIeRe0YJcQByO90wG6XihwTtiEc0=;
 b=CMzZokn36ztTZeacfAmYQuxXcs5H8QWKXL2qlTrlSZKZNxRFhivXCY/A6wJf5QizAB8Y7oT2espCL+hfKZtFhZWRPZJUIkokCl+3BcS8tTvgPjbBzgIVQKSxl15Jm4v5f3hDBpDLQrxyTtj2uZPicSnMCZWOl/tCiCogF8PJ/YEUEg7s35qfAOUGBFOokEjhnLZCKINnOWL1HdkxhL1yhFKabDPoQDuBrihGy9I0l27WgQPerhqRNWp48/F/onSKUMSlNbMhqxUkEcKKOlKXG2IZ8cTamK/GRpSWIgQLkK78HKZOZelp/zrfd+l5mMkDLDepP9cn0zJy3bDswZ6w7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f6RCqIx5Jt7heTaIeRe0YJcQByO90wG6XihwTtiEc0=;
 b=qmIL3HTPHcXJ4DkKfkqkJz8OGhJ+zEj/jcKM2Laa6z5zu0mek/iFhziitpHFpdrKoB0ZQ1cBbzUychXA+71WAxqf8VUMoqHGWWbrKKcVD6fVK2QN5vjIG7IG1Tk2jEmm8dgcaT4XfKnDCatoda4QqFTN2S0WZYj9cQAjwCeXn0k=
Received: from CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::18)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 13:53:17 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::d0) by CH3P220CA0019.outlook.office365.com
 (2603:10b6:610:1e8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:15 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:14 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 1/7] sfc: remove obsolete counters from struct efx_channel
Date: Mon, 30 Sep 2024 14:52:39 +0100
Message-ID: <68e29384cc3b50ebe1922ae495c7d9de7aac7fdc.1727703521.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 525229a1-f4fb-4b45-14c4-08dce1573c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4C++LoPrOd0dFoL2z4GVHgp1s+eP7rSfObVp5qmr04DxDb7FC218u7Uy9jSD?=
 =?us-ascii?Q?dT5lTFhd7Ojg9gC1InB4bFGlrd9I0IFtcCxJmH1IvP1vD3m2c+0I62iQsSwS?=
 =?us-ascii?Q?GOfMPxr6vLszz8jShp1A7Wi7kK2ZX9K4prQlSShh08Mu5xJnnuiYQs5EY+/W?=
 =?us-ascii?Q?BH5orN3eQBMiJx31qD5DmJWIxJQeV7FvUJVFjD3VS39HmKFdLcBeqXYKQfrH?=
 =?us-ascii?Q?dee26p3lI22OFrnrS4BMxd+bqWvpzWdUQ5TkiNt8YD5XSygFji6iaeI6AbaB?=
 =?us-ascii?Q?lL+bT5tYqasprHzAnwOZXFfkrXiyMN/KCcyBZEa1MKtTu5ZjNZVVXD4tw28v?=
 =?us-ascii?Q?uPwzBjhBg7TT+qQlK7o624OUoX2HBDRWi3GfkqZW3LB0monUZfZ/30aHZFRQ?=
 =?us-ascii?Q?Ed1CguMsVhYh+FpS+61fyfwPOW6o2pc/9HqX1zC6Hj8UdxKiHjSfDMh0ENvx?=
 =?us-ascii?Q?SgW8jRyjtSMFw7b4O+cvFYuU36CaXmXIJZv2Ly9Qn2dcPybcZqRNkqc3i0hG?=
 =?us-ascii?Q?1tnWF5C55Jgs16oxfiV7ZDohgavcs6mS/jaKVM8QkxLpPwORPmLlagxrUZPP?=
 =?us-ascii?Q?jcfSIxvTeqv0/W20knaDnj9OzkrseZgClrbQfogPPJfvfo+0OFcYbvxmgUjO?=
 =?us-ascii?Q?XUjxgpNVFXmg5nlaIIT1NFHkanrhYUZe/mKlDttaci5VYTVVIj+Cm7feY6aJ?=
 =?us-ascii?Q?Dy9MVud128rqpC6VaAKUPvNJvgbFISiEJO/fS5LM9n46f0uArL6SUwpvl18P?=
 =?us-ascii?Q?3BD4sQRgK3sKSNlauw+oTBJpHP4T4Ru34+LIa1Krs7RbBCWjfTmLCQGmzm+2?=
 =?us-ascii?Q?89owhEwUbSfu5Y9mTm/2axJe+DRLJvG1g1YdpSRVC2i0s4YQCzvOnyOI8ChF?=
 =?us-ascii?Q?jaUvs3gMH8PvmeBYB3gzRcNz7OJFCwqHy/PDmaILZtLHf/oCJTjyWjiV3be9?=
 =?us-ascii?Q?J/EuzliqLO9+6JkgtJsPSAiTpDsWn/IoF5LZs5kVVPmwr2uLzxU6e6QRT36S?=
 =?us-ascii?Q?iThQwK6V7T5EHJnq6rdqFbAAqscrJsTZn8w+uktfTA73UvuWaiT7pdPbRENl?=
 =?us-ascii?Q?6mRKz8SFZMz64NjBhAcB6rKKo1YJdiwWnoQ9jcixEcJaNb/is33QV50Ve9yx?=
 =?us-ascii?Q?qX3UjRVchVgvUTZ7HAKJC0vHNuJaQxPjWSYlz03Ythu+OMJruwMmb6GtySZz?=
 =?us-ascii?Q?BkX6KadYu2YvkBZxc+FGJ+AHBVV9Fk6LyB7Fm0bsJJ/4oOZdef8Iov+zeHAA?=
 =?us-ascii?Q?SK3+zsuRXFWgWKEBKRyqzKqZrwXGYetum2zygbW1P1SsWF9BiAdBlZYdOHKK?=
 =?us-ascii?Q?tWTyFCvHr477fpdE74+ul3tsaEUBYXCI/soRCelaTNHvrc9/34nVLxc9U77E?=
 =?us-ascii?Q?87oMx+4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:16.7739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525229a1-f4fb-4b45-14c4-08dce1573c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

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

