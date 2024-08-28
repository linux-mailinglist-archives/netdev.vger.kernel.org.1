Return-Path: <netdev+bounces-122788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E421B962922
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53611C2183D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB3185B77;
	Wed, 28 Aug 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tldW8Rm5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F028241E7
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852763; cv=fail; b=BM4w2bK7MVrZIoRS9A69J0sb/07rs136UkheV/Ds8ytzEh+1UQ9CLNNGj5lXPcqZFL1KTOq5WgxAwlF9OL3FuqTJnhLT0YCNmKRPBmOCeI/2tCxEH+hqKPjMeCuBDDfeL2SM8nGLO9fZgb+ZF/73UKrgdJ3P6O1NUZyLw11ozKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852763; c=relaxed/simple;
	bh=dBAtAkuh54qvFDem+BzhpEicFd0Uw5gZa5aEg6cc7jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GV15g9LIvTa4a3i0mMG94emHHCsxoaWc5obdzmHGB4UucM4svvJAwfc0yo9n1TVdneigruh0kHQ1vfWUpU82LugsfrCw11QQQSSNpVKb8HwkPzztUFKYqH/0S5I81KQqgWyQaMhvQaLzzgNvzQHZL0eHndeHSG/2/q7ob616eXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tldW8Rm5; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5pQR76LRtiB+FuPaGJFbqzPWMZh4lPsKt3oMzd6SRKOGXgBIxNbOETngJqG4Br/C7KRrIkGi8PGljwg4Xx1tcJtGT9op8ZYtNC0esH9/G6v2aq/kS+NloBUv+/4T3QJ3ho4zkZnmZQvBGkh8av7vqOX/JF+9Tq8oIUgR+H4W5Z1rW97X7vq/o7QWKT2PmHxvuuzilEulYzZsVHEhETjVy9ah9eAOycVfufSRijULX87dxDK18cOId84AaRjaABe+inkrd84KFhI71xHU709xBiY96lWUKHuDfsyut8u8FgkjKPUBgwW5r3aLKG21OYncCWm78CXU0OC/ol4YxmtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pdzz1H6XZdB6hsXiW4gpBVn6mcDmWekWf/ieCGjvxWw=;
 b=LCyeMYU/xfOj+OhO809qHodC5lJCq8d2DZ33Up+GBjcT41IaJ6GvNEhuRXAcRCzvYNEaKJICSdfunLhm5WVeyNwM4RdSr8iAwliqJVFiK39bLSM43om2HIMLuOJJV8IKQFyU8qo77qI68exI6p5N4H2e02yOnvQGI/LXTv3VE3i9J4B4Ry8co3qtFKMrv/j2V1QYdj1wtOzXNsJTZeI9T6qddkMSj/01p47PeK6PhaIW49NEccfCbK8XYgXwNg7vQKhuVtNEN14RdgE/2k8BF+eCn5/TyqclnyxZFfwK/VyY31iLJCaHDCAfXKcyzmaqzxLy/FUUVsUvIg1IRzDL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdzz1H6XZdB6hsXiW4gpBVn6mcDmWekWf/ieCGjvxWw=;
 b=tldW8Rm54qtUPND+2Co7Cmyc8+wzzSf/5Yjnxf0jrOM7Zev7Ixb1vmXLQp89qpRXWhe2wM5orp2iwK0N0kPReULJBN5pkI/txRMNouY0UzRVClgIpr67R9tQN9Z82O7d1gXEu1a9xt5kEoNcubUkx5VJApoc9qm7jkq99Z5OqvQ=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 28 Aug
 2024 13:45:58 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::3a) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:55 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 28 Aug 2024 08:45:54 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/6] sfc: remove obsolete counters from struct efx_channel
Date: Wed, 28 Aug 2024 14:45:10 +0100
Message-ID: <f56eebfebfec5b780ef89e1da095cbce5cbf240a.1724852597.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1724852597.git.ecree.xilinx@gmail.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: ab47fe83-5f4c-4184-f655-08dcc767bec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/j94FcEOBV9Lm7IH/w8Q6mXvPKnWyJOf8cFJZAuPmIs67m2XeSYbHe5eajxW?=
 =?us-ascii?Q?kZ4TE6ST7dRD1VsfDZNZRkkclsV8WBytsAAQB4MpXM/b/iqZGkgN0SqBiVpR?=
 =?us-ascii?Q?8fKzKigM/oVTx7N7K0YMBZFvN4j2o/b4NhJeNl/pdhTV4zjNXyWZnKY2pQNd?=
 =?us-ascii?Q?/IBqAF7xZxmTngf1po4JqdCKi1rO58M0YCSsc5yD6vPp3H4VZ5Z4X8aTX1kL?=
 =?us-ascii?Q?sOil4nHSU6EWw3DIrjtvR4Qixaw3o3hf8BagaLiBv48UL8wa9KlwxOfC+Efh?=
 =?us-ascii?Q?TW3iEW+3x4pT+toXKgXaWTMBYKPqQlEXzxKb8XdJ9CaTTCNQBPzvhfacsqkS?=
 =?us-ascii?Q?cx18wt9R6Kt51PBSeCPIpBScL64BbAD8/rqtwSAe1yw2W/thRHDMQ3cGTcV8?=
 =?us-ascii?Q?2lAbfConV5M2oQTrFGGC7JMfuqK5tE66YeoIJRXchS7peOFYVrvR+RNxKgrV?=
 =?us-ascii?Q?zGwuMiFLpuGbWETQkK/4U2OpldlWIyTPXMUYTRva7YpmAVRHe/03pdUXJ3iF?=
 =?us-ascii?Q?beiF0lgDu3qvZCmAT7cgsq8o+EDrOC+Gz03GxxGmPRGB9uIRYbPQvXLJH1lI?=
 =?us-ascii?Q?x58AvamgFyj0nUGEIBuHsj/hAW/LuoFKL6DK6q2enLWAeFU/+Qkm36fUYvno?=
 =?us-ascii?Q?FWfIhwqvAmjVqvm98a+RLp+KaQnKFOuQCPBEyDsbRCltTAB8/kzyUECnGjXz?=
 =?us-ascii?Q?zagkC3n0R2am5OEI9L2BRVCbK8YC36uu3O2x+Odox4MyIOGx9T4v66aucmUX?=
 =?us-ascii?Q?GdFs5RkaOKd/JU4ggP5woja7gskByO21U7aZwTPbfzdqruiECOwI61ZPF07Y?=
 =?us-ascii?Q?TnK5br3TjvQuaEPgalz2PsqsH8Pemtl+JFLwwZXKQsGT9QFmCTvmCM6t4yCh?=
 =?us-ascii?Q?CEafdGvhzphyL320V6tTTE0FCCjdQr5fXvmND41f96oOAfbRJ11UbfYQopJf?=
 =?us-ascii?Q?7rrpYhFt5nSo2WrLFzYykwsH6Ufxz1kp6FD6KQh0XjiOz/M9Mun3kCnm1zOn?=
 =?us-ascii?Q?87iR4fX+ninbXLG00PvbEq9kVzMzKjXgG1Wdm9BDgcLJpmcu1zEN7JRG+xOZ?=
 =?us-ascii?Q?bkFyZUyxWfmVmfi4dbr84jlrJD0KaKbXALz1Qo05Nay7TCk4QW4AeigrqRmE?=
 =?us-ascii?Q?lRyfoEFm2T+H+5F/n4CY9u+8P5DriU5hLLv3bp5O9LbJnwE6zRQiCXdOrhny?=
 =?us-ascii?Q?94pSAlyyAc7+/ZUj1MBZ7Q5sH+OBTGB1mpLVF0dv2GGR0MqnQj/nQFe3a6nk?=
 =?us-ascii?Q?ooAT9lRscKgDhp4tgs0oLzt07L1ven04BMkbTBgTtuOZlaFM9roybYEpXNJy?=
 =?us-ascii?Q?GvJnRwHil/8Zzu5HcRbkKz32Z0OCGKkS149NJ3u5l7IBjvliIYP8myua45dN?=
 =?us-ascii?Q?gdbKp1q1nF+daG7jSJQCZezWBSx+UfowClHB/mr+7zqTCTuH27iUeWIAOWPU?=
 =?us-ascii?Q?llLt5Ag46F0L+djmgfTzbFJNuxM0ghtb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:57.4706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab47fe83-5f4c-4184-f655-08dcc767bec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

From: Edward Cree <ecree.xilinx@gmail.com>

The n_rx_tobe_disc and n_rx_mcast_mismatch counters are a legacy
 from farch, and are never written in EF10 or EF100 code.  Remove
 them from the struct and from ethtool -S output, saving a bit of
 memory and avoiding user confusion.

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

