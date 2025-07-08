Return-Path: <netdev+bounces-204799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43707AFC19D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19D97A6876
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F623A98D;
	Tue,  8 Jul 2025 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lmyH3WCV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B71E4AB
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947868; cv=fail; b=HTHIYtmDCpF//0dsqX1COffQBKy/3S8tgcIVs4k1rhhCarIVZAT3U3r+IawqRZYTzNgHSgrx3Na1/uKeFVZ61Fvwyx42+l6gB74HoUcXg7CrLxJbaYB0jxsjoVROKf4yGMkfyZxypjyVs+sUb3+rfPhbc6LEQkch6lRTASwnj3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947868; c=relaxed/simple;
	bh=8J43dh2JeXyKjrIP0hgK7EbVEM+C2AvlbOFQPBiAF1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHNRmgx7ZOMwFWDbznLfJPZ6E0k/FSlfk2tE8AiqBlVc7A6FI3mzLogWL/OceOC8KibLMu5Kagdv2YQo/uKVqUJ9AlxYoNk1AABvOrdxzeHtHeZkivKfpu3BgqYA4Yh4DOnD8ig1M0niHOtBvUyVwoQZtQpmwxC5dcY1UTtIOwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lmyH3WCV; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frp8kakYVkLLiI+eHJgW31yCsYCHL++1Crzp+uXjiW3auPppeLA/Om9sKEL03c4UU2YHiqGPmGtyiQ/z8Flzyuk/V4UDgsKyIllgArP0yE+XCXRsc/985tO61Q0my6VYLLZ2Qr+0IqPtqairVSIsQ8CGB/j9KWEnwNSPRmk+kybe+vXpUI3Im3/DksVY2a9yV+3QICf3kwmRC/SurTfDu0GrVUx8/Gj35oV4y/a44L7Kjx7ZT2PUwU79r7TRtepuPW2J14uAARvHvNTOwnHF2crXwVUAVE5J+4tWX3OCV3XvTYb416W7SS6iTw9SnNtak7Xq0oCA6P5phraSVP/QSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYnsRMOK4zZV2q+2TQlTXjmokKj11knQVfXrCyDxjyc=;
 b=p8jRTj9JzFQaqGHGkHwCNYYT8PH88UbGHPhvMyZqSXsz1KRxYrvKMZfhOEvyUYQ9rD5nemggo4FVhoMS57VV2Z3JzwLv8ZZU5XXqECOYUeB0ZPDOAH2wuTZZYRNMUy/VR6QaFrYPCaf3jQnVSBeZg35BUxu6LtA7sMXAz8TDit5NMAG2wQ1OG/6j0tmbS6ru1UXHcLBtOoW6B5MJE295bBDh5jMm29z5RePrR9fA8MnGxeHR9/N3GADlqf/EO2QLxy+WF1XbyRMQnkGUXfh1BB57cf1/PJ21zwbhmHBY8nl5QR9X3YjiAPDbtqWaExbPHaLsc9tWbY69LmDmY33vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYnsRMOK4zZV2q+2TQlTXjmokKj11knQVfXrCyDxjyc=;
 b=lmyH3WCVwHByRKx/hFG60wHi1iJi9AlGc3s3iKWQwbhFKq5Mq5cCgmdq+9o1DETb3LZCJagatJbHM1xe/654e4TQVdlnC7+1KGzQCyeksNGsYbpaK0wbtQyMI8n0GEHVh/wVPEguxhM1t+Jm47b0QDhPkqXl6u/Kx6EIBDW8jac=
Received: from BN8PR16CA0004.namprd16.prod.outlook.com (2603:10b6:408:4c::17)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 04:11:03 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:4c:cafe::ce) by BN8PR16CA0004.outlook.office365.com
 (2603:10b6:408:4c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 04:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.1 via Frontend Transport; Tue, 8 Jul 2025 04:11:03 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 23:11:00 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [net-next] amd-xgbe: add ethtool counters for error and dropped packets
Date: Tue, 8 Jul 2025 09:40:41 +0530
Message-ID: <20250708041041.56787-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fec3c9-8332-47b7-6a57-08ddbdd5746c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vJvSJsVDUGdCzV5hrCiAsu9Cz5hoKTziWfC7fYgHYeCKReh8r7rFyTvjHT63?=
 =?us-ascii?Q?/WjjjCDNDUGAcxgw0cXzutE7ewZ+81ysKrmXI7WLYHa6nmwew06AfSht8jsr?=
 =?us-ascii?Q?lw5EYZXO5ANaNORQjcymo8xFpba3jbgdiw1l6vvfyN7I2xmQ4fKHKEFVyCad?=
 =?us-ascii?Q?nsUrO8OddAmuxHQ/vuiiDs7YjSXPdxO5TLoP4QiztDzxoj8RPpnerRoNjFM1?=
 =?us-ascii?Q?qUqpg/XvdXoMxh6Zmo+2VtP+8i9k2g7TSIoGZ9T11Auv8iq9uhyJlo54Q5qV?=
 =?us-ascii?Q?L9CBraEg5e4JMVjcuPpVzWNVas8a6/mxXiFyEg1UBIqBJFqwAqtVNUAO5nrw?=
 =?us-ascii?Q?zICTdHJEihC17Pg4cK/aF9GratFlsoXIh3I0UFDmDIvbqbu1nC0TmzB7KC9+?=
 =?us-ascii?Q?VaFGfKhcoyCa+DAPrU4Z87F5hQNINEb/cQN3raYcRaFNYLMZjXwfeZfdUd2Y?=
 =?us-ascii?Q?NOHybOv/Z8gpAUo9he1ou9MSKx7Vl2Ph+Qj9jpcpluEltVjd9XFyepf5CwTm?=
 =?us-ascii?Q?xlkjWf00W8lUtnasHxGgSZ5GAX2UnkV9fy8jLOzjnm8kUoiD39rzT8nb58p3?=
 =?us-ascii?Q?zKV2TK5og8LTG9U9vF0OavsZgzUltG6st0csGriiuopUuiTw8Jx6e/VO4sKa?=
 =?us-ascii?Q?hDpqbm6n+JxcypijwfQ//HQZ5VhDVdCQUGMb05C7AetzXbMYV2kbuCAAZKeZ?=
 =?us-ascii?Q?ys31/rqR03zpglUoGfK5CFJfwVtLAQ4+k3kTEX8qkOH5T9t7m2bPNW1ZD9V2?=
 =?us-ascii?Q?wCjaidFOT41WtuEWMXmiQ3WgulGGZmoBb3Loxm5oNK8YSGOvTrwLXC0ZzygW?=
 =?us-ascii?Q?Ul2n6SPa0PU+zT4vSyzvYCnTYfE7sRL4NkPCyssFXwmB2i1zijcZ28w45R1g?=
 =?us-ascii?Q?VTCFgXt6MXRNGc6VAL8Rk4kZ245NVS1Tbi/OHeVeyJ+Vl1dpsPiXYtLmOgeb?=
 =?us-ascii?Q?juiJbRRH8ICVIYZhAV5suKKy6ZANHzxDyj0SFdbdoD5DA0UVSDZLDNW7EezC?=
 =?us-ascii?Q?NOEcTL3I9cE9IZs7+3riPyuT94dxklUot8Ayo35k3bposgrLVP+5WIXG6xQn?=
 =?us-ascii?Q?7pnTE+jyr1C94tZ4YwQ1uXsZxZn8sAeWPLwOn5Ihp+XPRoF+A6iz4PPfMJbB?=
 =?us-ascii?Q?LCRueH1LomQWjYGPIkv4fnHUdDKS4Lht502WLfRuyuYIhPhvPgPuKaSvlyzz?=
 =?us-ascii?Q?JKouRFYmN8PnTMAP8twnDlBhkhtc+ahqb5dJzjPpDqN9CcPJGJ22OrT20KTf?=
 =?us-ascii?Q?D2KLORO9t+Hp/IlOwDn8V50adu/Pwyzh2aAxKLkSKhGHx9AY9RPArhQVr9QL?=
 =?us-ascii?Q?9rXxb2dd9ZZ39s0L33ZxoWggMX4ELP2d+sad6WnT+Sh9tRp7pY2vQb3wmpDk?=
 =?us-ascii?Q?dOvCpvmmreaMc9EEisU/ZL4XPqoNg7pPQYWrnrSirqaoeD39q1doQ5EN8P/Q?=
 =?us-ascii?Q?hf9RqL/PRio3Lvv+87dZGGWgCObQ5yV4a276TmKQKBI6pposc4j3rLiNkMpy?=
 =?us-ascii?Q?irFgHHhhjFjrdvf+qmtOi1bOQeIJMyhLZCvQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 04:11:03.4931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fec3c9-8332-47b7-6a57-08ddbdd5746c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

add the ethtool counters for tx/rx dropped packets and tx/rx error
packets

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 12 ++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h         |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index be0d2c7d08dc..62a80df5bc6e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -47,6 +47,8 @@ static const struct xgbe_stats xgbe_gstring_stats[] = {
 	XGMAC_MMC_STAT("tx_1024_to_max_byte_packets", tx1024tomaxoctets_gb),
 	XGMAC_MMC_STAT("tx_underflow_errors", txunderflowerror),
 	XGMAC_MMC_STAT("tx_pause_frames", txpauseframes),
+	XGMAC_MMC_STAT("tx_errors", tx_errors),
+	XGMAC_MMC_STAT("tx_dropped", tx_dropped),
 
 	XGMAC_MMC_STAT("rx_bytes", rxoctetcount_gb),
 	XGMAC_MMC_STAT("rx_packets", rxframecount_gb),
@@ -75,6 +77,8 @@ static const struct xgbe_stats xgbe_gstring_stats[] = {
 	XGMAC_MMC_STAT("rx_pause_frames", rxpauseframes),
 	XGMAC_EXT_STAT("rx_split_header_packets", rx_split_header_packets),
 	XGMAC_EXT_STAT("rx_buffer_unavailable", rx_buffer_unavailable),
+	XGMAC_MMC_STAT("rx_errors", rx_errors),
+	XGMAC_MMC_STAT("rx_dropped", rx_dropped),
 };
 
 #define XGBE_STATS_COUNT	ARRAY_SIZE(xgbe_gstring_stats)
@@ -107,10 +111,18 @@ static void xgbe_get_ethtool_stats(struct net_device *netdev,
 				   struct ethtool_stats *stats, u64 *data)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
+	struct xgbe_mmc_stats *pstats = &pdata->mmc_stats;
 	u8 *stat;
 	int i;
 
 	pdata->hw_if.read_mmc_stats(pdata);
+	pstats->tx_errors = pstats->txframecount_gb - pstats->txframecount_g;
+	pstats->tx_dropped = netdev->stats.tx_dropped;
+	pstats->rx_errors = pstats->rxframecount_gb -
+			    pstats->rxbroadcastframes_g -
+			    pstats->rxmulticastframes_g -
+			    pstats->rxunicastframes_g;
+	pstats->rx_dropped = netdev->stats.rx_dropped;
 	for (i = 0; i < XGBE_STATS_COUNT; i++) {
 		stat = (u8 *)pdata + xgbe_gstring_stats[i].stat_offset;
 		*data++ = *(u64 *)stat;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index b5c5624eb827..fe6efd97f03d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -626,8 +626,12 @@ struct xgbe_mmc_stats {
 	u64 txframecount_g;
 	u64 txpauseframes;
 	u64 txvlanframes_g;
+	u64 tx_errors;
+	u64 tx_dropped;
 
 	/* Rx Stats */
+	u64 rx_errors;
+	u64 rx_dropped;
 	u64 rxframecount_gb;
 	u64 rxoctetcount_gb;
 	u64 rxoctetcount_g;
-- 
2.34.1


