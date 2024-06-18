Return-Path: <netdev+bounces-104679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D4E90DF46
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A906C1C22791
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403618C359;
	Tue, 18 Jun 2024 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IIFSQ0Fe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522918A92B
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750740; cv=fail; b=KfNd+28Z2PEQ9BiCjpOln12lUu9f8c2OKk1ukRvHzrTLXVLmniFzG4ixc+8vaIn2rr1gapCc2ALGiIwLlu8efaFNPMdJy6s+Om8jAXTmo47EvnT3t/uYsSHDqVU0gE+oTH3h9RIuD5YfdF49p2sZwckQnKXfYTJHw1QthL9tTZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750740; c=relaxed/simple;
	bh=Z7FHXmDNtu1RjFAeTdNCdI5TSKD357du2XKXfXZ8ZPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI/jRMPOYBjnFO3d8UUKg8W0quRv0ZGPlf5T1MHw+fhqTkT9C79sNWrZmp3sLQZ6BmX2KJy2gjj6JJ+O0C9aBiSjeHKdqcWr8AJVkbGR4dRZ1s1zxuZDYR4SNrpprbrs0tAP8I3Maz5EMaDuH9mzllBlwRIJqBHOQ2QBFypp3EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IIFSQ0Fe; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXYfDR3ImauHV4BP1hS7oj6Rr0bSfLXQzCmNqd4afbctljQRhP5C7ut7SB14+Wm8GJy3VFRuXwoOhU63mMNXNUuVwuovvM3Apt0TsB9NY76CPqzZUm2fSnufWARCmrXfAuufXEGxow7PoLsihgDI0dqStd/qgoKIYzv8ke+7buIVC4CpuHs7mIKOb0Bvi9tasoQefCbdTEPOTvL4lnpQaQ0sQXHMdLOajjrQ8S6DY5qDUxM8rVz31tnPdO1ClMStYwcuOa+odhasuB8dY0HE7174z1IW4Yf+dtWJAzikcmzLCHHb8nPwm+Y7tkZG8iPgMmw2UH8M37q3Elu4Y6GShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6ApXcJaOzlNHkHbzwJUSgN6Gxn0FPCywac8F97RQ4I=;
 b=Ais/8MS46/EYN138pWfq/jtmuyEp85lJDUzxdtUrteyb+FBY1FmqS7eYWMMOt9NFkXOd0QygSHiC2ynGOSIjWSEgVUDoDtxKnOmPBGHQ/VxRzirxbSP+4QP4jcCUIEM6wmZemy3BWRRw+890PZ9f51NutM0DumIBn//s+Ya6rL1+SAWTGFjBihInLJpLe4UFsAKGGy51rn0lUrbQryoO7/Y6Tiayv+ZdbMwRD2E+oauWb871CjqaLrYqX4XMCzRQtcJTxCSyLqW2GPcW+WL93WzCUQuNZfqvWP9MUD1MrQDy+F3LObpTqj50eMgNenLGfzOwNgGH1NMPnfOjJbmv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6ApXcJaOzlNHkHbzwJUSgN6Gxn0FPCywac8F97RQ4I=;
 b=IIFSQ0FeWjU8iTkReBASH1h6KaFgz9rY6rMD4Yy7yrABJJUzbcXuoF+wPsVHhUs16mssgp+4Aq/G4JIpZOlUfRa6ZBJc4AwcZn8fch3erdNA+DGrkK74cUUk2Ju5BCC5W3+EJ3wGP3TI7KQ/BjCh3x5IMj2J3wliclga7jiHPco=
Received: from MN2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:d4::19)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 22:45:33 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::52) by MN2PR04CA0006.outlook.office365.com
 (2603:10b6:208:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:31 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:29 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 7/7] sfc: use new rxfh_context API
Date: Tue, 18 Jun 2024 23:44:27 +0100
Message-ID: <0fc7557a7f0db3c04f1adc4c9f598c6abc8941bb.1718750587.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718750586.git.ecree.xilinx@gmail.com>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: f392a030-bac6-4f02-1b17-08dc8fe85c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H93DdQIsdFH8HBDL2uJg1K/8NueIYjuxFtXYAfzeVYbZsVrWWISvGZVN/66+?=
 =?us-ascii?Q?hTq4QRU//lj0glknPUFCeUyOMkO7s3OxA8Lomt6ROnkMBiwGeZ3AEl9WIE+E?=
 =?us-ascii?Q?M9PtzMNxHnFWqJrHvT02cDjT7mb/oHFq2fBwQqnrSFxFakQSti4hdCCetHti?=
 =?us-ascii?Q?RzulRspKC5ZSj8fy4SIkefe7o+9HVSXOHZcnXZRrW9HDxsyjffWHlxu+tnc0?=
 =?us-ascii?Q?kbCQsqXZaM2IDvSjM6HkVCvH3a7Hw3+d34l4/v0deiibdXZ3T3hSlcUbwBiw?=
 =?us-ascii?Q?Uqpr7YsQI1e1RekaR20UfjnkUANYQujprRpzz3U2TsdWQK3m1DqZt8+SyK+T?=
 =?us-ascii?Q?xUFYRJVJT/+/g7wr63Jh6JqYRohjw9OK/4AbFagQCLYZXzOIW+fbnjQWoiOG?=
 =?us-ascii?Q?Pk2mtbT5Kt6t/kxDKCeR+JTROwpQuk+Q0mWtdZcn1Qx/9Ux1vISQ7zv6RIZ3?=
 =?us-ascii?Q?6Q1D2i5PpzZwp3QA+VMbKujfTANWEhdmtI2dMQoTFc+nOgLrdwcXFCvAraB7?=
 =?us-ascii?Q?K8Q3pv0MFYJo3WmPqqJFdOh3oca5GEl1oeR04ZRlqgvna+ptDhNwO3ymkfcZ?=
 =?us-ascii?Q?b9S+1ANSLYK+FmS6HkoVNtPZXe8hOIDSieKOMzwbcfrrZ5BFS1MYVsAITXhI?=
 =?us-ascii?Q?gqgLufk+YRX/tVjRxkOzz5SRX3WppFaJlO8pb1thmPSNv3IuLfxMur4wU8YD?=
 =?us-ascii?Q?LZyrY/dcE9ePteRWVKxJvhAUG/gnn07kM7DOEqBvrev390t+WO5ADTiLJ4Pi?=
 =?us-ascii?Q?ULnbm9UdJnXBQ4k3cd2xbbWvrFuaORsd6ChZ58IwiUv8h9MJJqiGRRU9Q/v8?=
 =?us-ascii?Q?sL8Z4vuN9eygOtl8IXOFSsfEjGWH2PAdc12cfvXoTLYYzmLvf0YhdBjp0rI4?=
 =?us-ascii?Q?s9iyRCQU34RkEDi1qLHCj/rOWPVNITwaJqN/dhLzTYKRaKSpgpt1QwZ4+YFb?=
 =?us-ascii?Q?OSiDELcn3gyfxtJmSx6aaZhe5wPx+jyaDRt4R/klhQzeNyXXPA93uJ4XslZ5?=
 =?us-ascii?Q?h6H+pKhSqq2mpK3LLtwEEZxB/N7K4CGKZ+jb3f61Rax4D/hHBVWe0Ko+vixS?=
 =?us-ascii?Q?9HtukleEhA2mVb6jrH1sYhbmt94miaKtimGjPz8dao6/6SVK3eyZd3NWZDUE?=
 =?us-ascii?Q?zidwhX/g9ceAUNvsdcEQL33xvBLDkPj+sYQ66552qGQDnLihGd6ORoQ8diB4?=
 =?us-ascii?Q?0Icqg7+MoB3LEuSEdTl0Mps6BU5ljj/xYxcMXAgkZVZ5A1qJFid0WUfG+WpU?=
 =?us-ascii?Q?ErPZA2H7EYuz6sJoGvyoB3VzHdFUbpfaj3HHBbvL8qeD1XJgz3HwgjzgmFd+?=
 =?us-ascii?Q?Q7j6TLvod5omy2hFRDyPP6T7kzn7VmcoEZI/9MzZ2Rg6kFoT5WhkoA5F3l6A?=
 =?us-ascii?Q?K7q1KNCsvo0rFPNOabMddw1xhllGST+ag1OAxWY+QR2Dz2gs5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:32.7996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f392a030-bac6-4f02-1b17-08dc8fe85c9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

From: Edward Cree <ecree.xilinx@gmail.com>

The core is now responsible for allocating IDs and a memory region for
 us to store our state (struct efx_rss_context_priv), so we no longer
 need efx_alloc_rss_context_entry() and friends.
Since the contexts are now maintained by the core, use the core's lock
 (net_dev->ethtool->rss_lock), rather than our own mutex (efx->rss_lock),
 to serialise access against changes; and remove the now-unused
 efx->rss_lock from struct efx_nic.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c           |   2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c  |   4 +
 drivers/net/ethernet/sfc/efx.c            |   2 +-
 drivers/net/ethernet/sfc/efx.h            |   2 +-
 drivers/net/ethernet/sfc/efx_common.c     |  10 +-
 drivers/net/ethernet/sfc/ethtool.c        |   4 +
 drivers/net/ethernet/sfc/ethtool_common.c | 148 ++++++++++++----------
 drivers/net/ethernet/sfc/ethtool_common.h |  12 ++
 drivers/net/ethernet/sfc/mcdi_filters.c   | 135 ++++++++++----------
 drivers/net/ethernet/sfc/mcdi_filters.h   |   8 +-
 drivers/net/ethernet/sfc/net_driver.h     |  28 ++--
 drivers/net/ethernet/sfc/rx_common.c      |  64 ++--------
 drivers/net/ethernet/sfc/rx_common.h      |   8 +-
 13 files changed, 208 insertions(+), 219 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 8fa6c0e9195b..7d69302ffa0a 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1396,7 +1396,7 @@ static void efx_ef10_table_reset_mc_allocations(struct efx_nic *efx)
 	efx_mcdi_filter_table_reset_mc_allocations(efx);
 	nic_data->must_restore_piobufs = true;
 	efx_ef10_forget_old_piobufs(efx);
-	efx->rss_context.context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
+	efx->rss_context.priv.context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
 
 	/* Driver-created vswitches and vports must be re-created */
 	nic_data->must_probe_vswitching = true;
diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
index cf55202b3a7b..896ffca4aee2 100644
--- a/drivers/net/ethernet/sfc/ef100_ethtool.c
+++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
@@ -59,8 +59,12 @@ const struct ethtool_ops ef100_ethtool_ops = {
 
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
+	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
+	.create_rxfh_context	= efx_ethtool_create_rxfh_context,
+	.modify_rxfh_context	= efx_ethtool_modify_rxfh_context,
+	.remove_rxfh_context	= efx_ethtool_remove_rxfh_context,
 
 	.get_module_info	= efx_ethtool_get_module_info,
 	.get_module_eeprom	= efx_ethtool_get_module_eeprom,
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index e9d9de8e648a..6f1a01ded7d4 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -299,7 +299,7 @@ static int efx_probe_nic(struct efx_nic *efx)
 	if (efx->n_channels > 1)
 		netdev_rss_key_fill(efx->rss_context.rx_hash_key,
 				    sizeof(efx->rss_context.rx_hash_key));
-	efx_set_default_rx_indir_table(efx, &efx->rss_context);
+	efx_set_default_rx_indir_table(efx, efx->rss_context.rx_indir_table);
 
 	/* Initialise the interrupt moderation settings */
 	efx->irq_mod_step_us = DIV_ROUND_UP(efx->timer_quantum_ns, 1000);
diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
index 48d3623735ba..7a6cab883d66 100644
--- a/drivers/net/ethernet/sfc/efx.h
+++ b/drivers/net/ethernet/sfc/efx.h
@@ -158,7 +158,7 @@ static inline s32 efx_filter_get_rx_ids(struct efx_nic *efx,
 }
 
 /* RSS contexts */
-static inline bool efx_rss_active(struct efx_rss_context *ctx)
+static inline bool efx_rss_active(struct efx_rss_context_priv *ctx)
 {
 	return ctx->context_id != EFX_MCDI_RSS_CONTEXT_INVALID;
 }
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 4ebd5ae23eca..13cf647051af 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -714,7 +714,7 @@ void efx_reset_down(struct efx_nic *efx, enum reset_type method)
 
 	mutex_lock(&efx->mac_lock);
 	down_write(&efx->filter_sem);
-	mutex_lock(&efx->rss_lock);
+	mutex_lock(&efx->net_dev->ethtool->rss_lock);
 	efx->type->fini(efx);
 }
 
@@ -777,7 +777,7 @@ int efx_reset_up(struct efx_nic *efx, enum reset_type method, bool ok)
 
 	if (efx->type->rx_restore_rss_contexts)
 		efx->type->rx_restore_rss_contexts(efx);
-	mutex_unlock(&efx->rss_lock);
+	mutex_unlock(&efx->net_dev->ethtool->rss_lock);
 	efx->type->filter_table_restore(efx);
 	up_write(&efx->filter_sem);
 
@@ -793,7 +793,7 @@ int efx_reset_up(struct efx_nic *efx, enum reset_type method, bool ok)
 fail:
 	efx->port_initialized = false;
 
-	mutex_unlock(&efx->rss_lock);
+	mutex_unlock(&efx->net_dev->ethtool->rss_lock);
 	up_write(&efx->filter_sem);
 	mutex_unlock(&efx->mac_lock);
 
@@ -1000,9 +1000,7 @@ int efx_init_struct(struct efx_nic *efx, struct pci_dev *pci_dev)
 		efx->type->rx_hash_offset - efx->type->rx_prefix_size;
 	efx->rx_packet_ts_offset =
 		efx->type->rx_ts_offset - efx->type->rx_prefix_size;
-	INIT_LIST_HEAD(&efx->rss_context.list);
-	efx->rss_context.context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
-	mutex_init(&efx->rss_lock);
+	efx->rss_context.priv.context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
 	efx->vport_id = EVB_PORT_ID_ASSIGNED;
 	spin_lock_init(&efx->stats_lock);
 	efx->vi_stride = EFX_DEFAULT_VI_STRIDE;
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 37c69c8d90b1..0f5c68b8bab7 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -268,8 +268,12 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.set_rxnfc		= efx_ethtool_set_rxnfc,
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
+	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
+	.create_rxfh_context	= efx_ethtool_create_rxfh_context,
+	.modify_rxfh_context	= efx_ethtool_modify_rxfh_context,
+	.remove_rxfh_context	= efx_ethtool_remove_rxfh_context,
 	.get_ts_info		= efx_ethtool_get_ts_info,
 	.get_module_info	= efx_ethtool_get_module_info,
 	.get_module_eeprom	= efx_ethtool_get_module_eeprom,
diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 7d5e5db4eac5..5647e3286705 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -820,10 +820,10 @@ int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 		return 0;
 
 	case ETHTOOL_GRXFH: {
-		struct efx_rss_context *ctx = &efx->rss_context;
+		struct efx_rss_context_priv *ctx = &efx->rss_context.priv;
 		__u64 data;
 
-		mutex_lock(&efx->rss_lock);
+		mutex_lock(&net_dev->ethtool->rss_lock);
 		if (info->flow_type & FLOW_RSS && info->rss_context) {
 			ctx = efx_find_rss_context_entry(efx, info->rss_context);
 			if (!ctx) {
@@ -864,7 +864,7 @@ int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 out_setdata_unlock:
 		info->data = data;
 out_unlock:
-		mutex_unlock(&efx->rss_lock);
+		mutex_unlock(&net_dev->ethtool->rss_lock);
 		return rc;
 	}
 
@@ -1167,31 +1167,33 @@ static int efx_ethtool_get_rxfh_context(struct net_device *net_dev,
 					struct ethtool_rxfh_param *rxfh)
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	struct efx_rss_context *ctx;
+	struct efx_rss_context_priv *ctx_priv;
+	struct efx_rss_context ctx;
 	int rc = 0;
 
 	if (!efx->type->rx_pull_rss_context_config)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&efx->rss_lock);
-	ctx = efx_find_rss_context_entry(efx, rxfh->rss_context);
-	if (!ctx) {
+	mutex_lock(&net_dev->ethtool->rss_lock);
+	ctx_priv = efx_find_rss_context_entry(efx, rxfh->rss_context);
+	if (!ctx_priv) {
 		rc = -ENOENT;
 		goto out_unlock;
 	}
-	rc = efx->type->rx_pull_rss_context_config(efx, ctx);
+	ctx.priv = *ctx_priv;
+	rc = efx->type->rx_pull_rss_context_config(efx, &ctx);
 	if (rc)
 		goto out_unlock;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 	if (rxfh->indir)
-		memcpy(rxfh->indir, ctx->rx_indir_table,
-		       sizeof(ctx->rx_indir_table));
+		memcpy(rxfh->indir, ctx.rx_indir_table,
+		       sizeof(ctx.rx_indir_table));
 	if (rxfh->key)
-		memcpy(rxfh->key, ctx->rx_hash_key,
+		memcpy(rxfh->key, ctx.rx_hash_key,
 		       efx->type->rx_hash_key_size);
 out_unlock:
-	mutex_unlock(&efx->rss_lock);
+	mutex_unlock(&net_dev->ethtool->rss_lock);
 	return rc;
 }
 
@@ -1218,68 +1220,81 @@ int efx_ethtool_get_rxfh(struct net_device *net_dev,
 	return 0;
 }
 
-static int efx_ethtool_set_rxfh_context(struct net_device *net_dev,
-					struct ethtool_rxfh_param *rxfh,
-					struct netlink_ext_ack *extack)
+int efx_ethtool_modify_rxfh_context(struct net_device *net_dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	u32 *rss_context = &rxfh->rss_context;
-	struct efx_rss_context *ctx;
-	u32 *indir = rxfh->indir;
-	bool allocated = false;
-	u8 *key = rxfh->key;
-	int rc;
+	struct efx_rss_context_priv *priv;
+	const u32 *indir = rxfh->indir;
+	const u8 *key = rxfh->key;
 
-	if (!efx->type->rx_push_rss_context_config)
+	if (!efx->type->rx_push_rss_context_config) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "NIC type does not support custom contexts");
 		return -EOPNOTSUPP;
-
-	mutex_lock(&efx->rss_lock);
-
-	if (*rss_context == ETH_RXFH_CONTEXT_ALLOC) {
-		if (rxfh->rss_delete) {
-			/* alloc + delete == Nothing to do */
-			rc = -EINVAL;
-			goto out_unlock;
-		}
-		ctx = efx_alloc_rss_context_entry(efx);
-		if (!ctx) {
-			rc = -ENOMEM;
-			goto out_unlock;
-		}
-		ctx->context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
-		/* Initialise indir table and key to defaults */
-		efx_set_default_rx_indir_table(efx, ctx);
-		netdev_rss_key_fill(ctx->rx_hash_key, sizeof(ctx->rx_hash_key));
-		allocated = true;
-	} else {
-		ctx = efx_find_rss_context_entry(efx, *rss_context);
-		if (!ctx) {
-			rc = -ENOENT;
-			goto out_unlock;
-		}
 	}
-
-	if (rxfh->rss_delete) {
-		/* delete this context */
-		rc = efx->type->rx_push_rss_context_config(efx, ctx, NULL, NULL);
-		if (!rc)
-			efx_free_rss_context_entry(ctx);
-		goto out_unlock;
+	/* Hash function is Toeplitz, cannot be changed */
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP) {
+		NL_SET_ERR_MSG_MOD(extack, "Only Toeplitz hash is supported");
+		return -EOPNOTSUPP;
 	}
 
+	priv = ethtool_rxfh_context_priv(ctx);
+
 	if (!key)
-		key = ctx->rx_hash_key;
+		key = ethtool_rxfh_context_key(ctx);
 	if (!indir)
-		indir = ctx->rx_indir_table;
+		indir = ethtool_rxfh_context_indir(ctx);
 
-	rc = efx->type->rx_push_rss_context_config(efx, ctx, indir, key);
-	if (rc && allocated)
-		efx_free_rss_context_entry(ctx);
-	else
-		*rss_context = ctx->user_id;
-out_unlock:
-	mutex_unlock(&efx->rss_lock);
-	return rc;
+	return efx->type->rx_push_rss_context_config(efx, priv, indir, key,
+						     false);
+}
+
+int efx_ethtool_create_rxfh_context(struct net_device *net_dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+	struct efx_rss_context_priv *priv;
+
+	priv = ethtool_rxfh_context_priv(ctx);
+
+	priv->context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
+	priv->rx_hash_udp_4tuple = false;
+	/* Generate default indir table and/or key if not specified.
+	 * We use ctx as a place to store these; this is fine because
+	 * we're doing a create, so if we fail then the ctx will just
+	 * be deleted.
+	 */
+	if (!rxfh->indir)
+		efx_set_default_rx_indir_table(efx, ethtool_rxfh_context_indir(ctx));
+	if (!rxfh->key)
+		netdev_rss_key_fill(ethtool_rxfh_context_key(ctx),
+				    ctx->key_size);
+	return efx_ethtool_modify_rxfh_context(net_dev, ctx, rxfh, extack);
+}
+
+int efx_ethtool_remove_rxfh_context(struct net_device *net_dev,
+				    struct ethtool_rxfh_context *ctx,
+				    u32 rss_context,
+				    struct netlink_ext_ack *extack)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+	struct efx_rss_context_priv *priv;
+
+	if (!efx->type->rx_push_rss_context_config) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "NIC type does not support custom contexts");
+		return -EOPNOTSUPP;
+	}
+
+	priv = ethtool_rxfh_context_priv(ctx);
+	return efx->type->rx_push_rss_context_config(efx, priv, NULL, NULL,
+						     true);
 }
 
 int efx_ethtool_set_rxfh(struct net_device *net_dev,
@@ -1295,8 +1310,9 @@ int efx_ethtool_set_rxfh(struct net_device *net_dev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->rss_context)
-		return efx_ethtool_set_rxfh_context(net_dev, rxfh, extack);
+	/* Custom contexts should use new API */
+	if (WARN_ON_ONCE(rxfh->rss_context))
+		return -EIO;
 
 	if (!indir && !key)
 		return 0;
diff --git a/drivers/net/ethernet/sfc/ethtool_common.h b/drivers/net/ethernet/sfc/ethtool_common.h
index a680e5980213..fc52e891637d 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.h
+++ b/drivers/net/ethernet/sfc/ethtool_common.h
@@ -49,6 +49,18 @@ int efx_ethtool_get_rxfh(struct net_device *net_dev,
 int efx_ethtool_set_rxfh(struct net_device *net_dev,
 			 struct ethtool_rxfh_param *rxfh,
 			 struct netlink_ext_ack *extack);
+int efx_ethtool_create_rxfh_context(struct net_device *net_dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack);
+int efx_ethtool_modify_rxfh_context(struct net_device *net_dev,
+				    struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack);
+int efx_ethtool_remove_rxfh_context(struct net_device *net_dev,
+				    struct ethtool_rxfh_context *ctx,
+				    u32 rss_context,
+				    struct netlink_ext_ack *extack);
 int efx_ethtool_reset(struct net_device *net_dev, u32 *flags);
 int efx_ethtool_get_module_eeprom(struct net_device *net_dev,
 				  struct ethtool_eeprom *ee,
diff --git a/drivers/net/ethernet/sfc/mcdi_filters.c b/drivers/net/ethernet/sfc/mcdi_filters.c
index 4ff6586116ee..6ef96292909a 100644
--- a/drivers/net/ethernet/sfc/mcdi_filters.c
+++ b/drivers/net/ethernet/sfc/mcdi_filters.c
@@ -194,7 +194,7 @@ efx_mcdi_filter_push_prep_set_match_fields(struct efx_nic *efx,
 static void efx_mcdi_filter_push_prep(struct efx_nic *efx,
 				      const struct efx_filter_spec *spec,
 				      efx_dword_t *inbuf, u64 handle,
-				      struct efx_rss_context *ctx,
+				      struct efx_rss_context_priv *ctx,
 				      bool replacing)
 {
 	u32 flags = spec->flags;
@@ -245,7 +245,7 @@ static void efx_mcdi_filter_push_prep(struct efx_nic *efx,
 
 static int efx_mcdi_filter_push(struct efx_nic *efx,
 				const struct efx_filter_spec *spec, u64 *handle,
-				struct efx_rss_context *ctx, bool replacing)
+				struct efx_rss_context_priv *ctx, bool replacing)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_FILTER_OP_EXT_IN_LEN);
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_FILTER_OP_EXT_OUT_LEN);
@@ -345,9 +345,9 @@ static s32 efx_mcdi_filter_insert_locked(struct efx_nic *efx,
 					 bool replace_equal)
 {
 	DECLARE_BITMAP(mc_rem_map, EFX_EF10_FILTER_SEARCH_LIMIT);
+	struct efx_rss_context_priv *ctx = NULL;
 	struct efx_mcdi_filter_table *table;
 	struct efx_filter_spec *saved_spec;
-	struct efx_rss_context *ctx = NULL;
 	unsigned int match_pri, hash;
 	unsigned int priv_flags;
 	bool rss_locked = false;
@@ -380,12 +380,12 @@ static s32 efx_mcdi_filter_insert_locked(struct efx_nic *efx,
 		bitmap_zero(mc_rem_map, EFX_EF10_FILTER_SEARCH_LIMIT);
 
 	if (spec->flags & EFX_FILTER_FLAG_RX_RSS) {
-		mutex_lock(&efx->rss_lock);
+		mutex_lock(&efx->net_dev->ethtool->rss_lock);
 		rss_locked = true;
 		if (spec->rss_context)
 			ctx = efx_find_rss_context_entry(efx, spec->rss_context);
 		else
-			ctx = &efx->rss_context;
+			ctx = &efx->rss_context.priv;
 		if (!ctx) {
 			rc = -ENOENT;
 			goto out_unlock;
@@ -548,7 +548,7 @@ static s32 efx_mcdi_filter_insert_locked(struct efx_nic *efx,
 
 out_unlock:
 	if (rss_locked)
-		mutex_unlock(&efx->rss_lock);
+		mutex_unlock(&efx->net_dev->ethtool->rss_lock);
 	up_write(&table->lock);
 	return rc;
 }
@@ -611,13 +611,13 @@ static int efx_mcdi_filter_remove_internal(struct efx_nic *efx,
 
 		new_spec.priority = EFX_FILTER_PRI_AUTO;
 		new_spec.flags = (EFX_FILTER_FLAG_RX |
-				  (efx_rss_active(&efx->rss_context) ?
+				  (efx_rss_active(&efx->rss_context.priv) ?
 				   EFX_FILTER_FLAG_RX_RSS : 0));
 		new_spec.dmaq_id = 0;
 		new_spec.rss_context = 0;
 		rc = efx_mcdi_filter_push(efx, &new_spec,
 					  &table->entry[filter_idx].handle,
-					  &efx->rss_context,
+					  &efx->rss_context.priv,
 					  true);
 
 		if (rc == 0)
@@ -764,7 +764,7 @@ static int efx_mcdi_filter_insert_addr_list(struct efx_nic *efx,
 		ids = vlan->uc;
 	}
 
-	filter_flags = efx_rss_active(&efx->rss_context) ? EFX_FILTER_FLAG_RX_RSS : 0;
+	filter_flags = efx_rss_active(&efx->rss_context.priv) ? EFX_FILTER_FLAG_RX_RSS : 0;
 
 	/* Insert/renew filters */
 	for (i = 0; i < addr_count; i++) {
@@ -833,7 +833,7 @@ static int efx_mcdi_filter_insert_def(struct efx_nic *efx,
 	int rc;
 	u16 *id;
 
-	filter_flags = efx_rss_active(&efx->rss_context) ? EFX_FILTER_FLAG_RX_RSS : 0;
+	filter_flags = efx_rss_active(&efx->rss_context.priv) ? EFX_FILTER_FLAG_RX_RSS : 0;
 
 	efx_filter_init_rx(&spec, EFX_FILTER_PRI_AUTO, filter_flags, 0);
 
@@ -1375,8 +1375,8 @@ void efx_mcdi_filter_table_restore(struct efx_nic *efx)
 	struct efx_mcdi_filter_table *table = efx->filter_state;
 	unsigned int invalid_filters = 0, failed = 0;
 	struct efx_mcdi_filter_vlan *vlan;
+	struct efx_rss_context_priv *ctx;
 	struct efx_filter_spec *spec;
-	struct efx_rss_context *ctx;
 	unsigned int filter_idx;
 	u32 mcdi_flags;
 	int match_pri;
@@ -1388,7 +1388,7 @@ void efx_mcdi_filter_table_restore(struct efx_nic *efx)
 		return;
 
 	down_write(&table->lock);
-	mutex_lock(&efx->rss_lock);
+	mutex_lock(&efx->net_dev->ethtool->rss_lock);
 
 	for (filter_idx = 0; filter_idx < EFX_MCDI_FILTER_TBL_ROWS; filter_idx++) {
 		spec = efx_mcdi_filter_entry_spec(table, filter_idx);
@@ -1407,7 +1407,7 @@ void efx_mcdi_filter_table_restore(struct efx_nic *efx)
 		if (spec->rss_context)
 			ctx = efx_find_rss_context_entry(efx, spec->rss_context);
 		else
-			ctx = &efx->rss_context;
+			ctx = &efx->rss_context.priv;
 		if (spec->flags & EFX_FILTER_FLAG_RX_RSS) {
 			if (!ctx) {
 				netif_warn(efx, drv, efx->net_dev,
@@ -1444,7 +1444,7 @@ void efx_mcdi_filter_table_restore(struct efx_nic *efx)
 		}
 	}
 
-	mutex_unlock(&efx->rss_lock);
+	mutex_unlock(&efx->net_dev->ethtool->rss_lock);
 	up_write(&table->lock);
 
 	/*
@@ -1861,7 +1861,8 @@ bool efx_mcdi_filter_rfs_expire_one(struct efx_nic *efx, u32 flow_id,
 					 RSS_MODE_HASH_ADDRS << MC_CMD_RSS_CONTEXT_GET_FLAGS_OUT_UDP_IPV6_RSS_MODE_LBN |\
 					 RSS_MODE_HASH_ADDRS << MC_CMD_RSS_CONTEXT_GET_FLAGS_OUT_OTHER_IPV6_RSS_MODE_LBN)
 
-int efx_mcdi_get_rss_context_flags(struct efx_nic *efx, u32 context, u32 *flags)
+static int efx_mcdi_get_rss_context_flags(struct efx_nic *efx, u32 context,
+					  u32 *flags)
 {
 	/*
 	 * Firmware had a bug (sfc bug 61952) where it would not actually
@@ -1909,8 +1910,8 @@ int efx_mcdi_get_rss_context_flags(struct efx_nic *efx, u32 context, u32 *flags)
  * Defaults are 4-tuple for TCP and 2-tuple for UDP and other-IP, so we
  * just need to set the UDP ports flags (for both IP versions).
  */
-void efx_mcdi_set_rss_context_flags(struct efx_nic *efx,
-				    struct efx_rss_context *ctx)
+static void efx_mcdi_set_rss_context_flags(struct efx_nic *efx,
+					   struct efx_rss_context_priv *ctx)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_RSS_CONTEXT_SET_FLAGS_IN_LEN);
 	u32 flags;
@@ -1931,7 +1932,7 @@ void efx_mcdi_set_rss_context_flags(struct efx_nic *efx,
 }
 
 static int efx_mcdi_filter_alloc_rss_context(struct efx_nic *efx, bool exclusive,
-					     struct efx_rss_context *ctx,
+					     struct efx_rss_context_priv *ctx,
 					     unsigned *context_size)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_RSS_CONTEXT_ALLOC_IN_LEN);
@@ -2032,25 +2033,26 @@ void efx_mcdi_rx_free_indir_table(struct efx_nic *efx)
 {
 	int rc;
 
-	if (efx->rss_context.context_id != EFX_MCDI_RSS_CONTEXT_INVALID) {
-		rc = efx_mcdi_filter_free_rss_context(efx, efx->rss_context.context_id);
+	if (efx->rss_context.priv.context_id != EFX_MCDI_RSS_CONTEXT_INVALID) {
+		rc = efx_mcdi_filter_free_rss_context(efx, efx->rss_context.priv.context_id);
 		WARN_ON(rc != 0);
 	}
-	efx->rss_context.context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
+	efx->rss_context.priv.context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
 }
 
 static int efx_mcdi_filter_rx_push_shared_rss_config(struct efx_nic *efx,
 					      unsigned *context_size)
 {
 	struct efx_mcdi_filter_table *table = efx->filter_state;
-	int rc = efx_mcdi_filter_alloc_rss_context(efx, false, &efx->rss_context,
-					    context_size);
+	int rc = efx_mcdi_filter_alloc_rss_context(efx, false,
+						   &efx->rss_context.priv,
+						   context_size);
 
 	if (rc != 0)
 		return rc;
 
 	table->rx_rss_context_exclusive = false;
-	efx_set_default_rx_indir_table(efx, &efx->rss_context);
+	efx_set_default_rx_indir_table(efx, efx->rss_context.rx_indir_table);
 	return 0;
 }
 
@@ -2058,26 +2060,27 @@ static int efx_mcdi_filter_rx_push_exclusive_rss_config(struct efx_nic *efx,
 						 const u32 *rx_indir_table,
 						 const u8 *key)
 {
+	u32 old_rx_rss_context = efx->rss_context.priv.context_id;
 	struct efx_mcdi_filter_table *table = efx->filter_state;
-	u32 old_rx_rss_context = efx->rss_context.context_id;
 	int rc;
 
-	if (efx->rss_context.context_id == EFX_MCDI_RSS_CONTEXT_INVALID ||
+	if (efx->rss_context.priv.context_id == EFX_MCDI_RSS_CONTEXT_INVALID ||
 	    !table->rx_rss_context_exclusive) {
-		rc = efx_mcdi_filter_alloc_rss_context(efx, true, &efx->rss_context,
-						NULL);
+		rc = efx_mcdi_filter_alloc_rss_context(efx, true,
+						       &efx->rss_context.priv,
+						       NULL);
 		if (rc == -EOPNOTSUPP)
 			return rc;
 		else if (rc != 0)
 			goto fail1;
 	}
 
-	rc = efx_mcdi_filter_populate_rss_table(efx, efx->rss_context.context_id,
-					 rx_indir_table, key);
+	rc = efx_mcdi_filter_populate_rss_table(efx, efx->rss_context.priv.context_id,
+						rx_indir_table, key);
 	if (rc != 0)
 		goto fail2;
 
-	if (efx->rss_context.context_id != old_rx_rss_context &&
+	if (efx->rss_context.priv.context_id != old_rx_rss_context &&
 	    old_rx_rss_context != EFX_MCDI_RSS_CONTEXT_INVALID)
 		WARN_ON(efx_mcdi_filter_free_rss_context(efx, old_rx_rss_context) != 0);
 	table->rx_rss_context_exclusive = true;
@@ -2091,9 +2094,9 @@ static int efx_mcdi_filter_rx_push_exclusive_rss_config(struct efx_nic *efx,
 	return 0;
 
 fail2:
-	if (old_rx_rss_context != efx->rss_context.context_id) {
-		WARN_ON(efx_mcdi_filter_free_rss_context(efx, efx->rss_context.context_id) != 0);
-		efx->rss_context.context_id = old_rx_rss_context;
+	if (old_rx_rss_context != efx->rss_context.priv.context_id) {
+		WARN_ON(efx_mcdi_filter_free_rss_context(efx, efx->rss_context.priv.context_id) != 0);
+		efx->rss_context.priv.context_id = old_rx_rss_context;
 	}
 fail1:
 	netif_err(efx, hw, efx->net_dev, "%s: failed rc=%d\n", __func__, rc);
@@ -2101,33 +2104,28 @@ static int efx_mcdi_filter_rx_push_exclusive_rss_config(struct efx_nic *efx,
 }
 
 int efx_mcdi_rx_push_rss_context_config(struct efx_nic *efx,
-					struct efx_rss_context *ctx,
+					struct efx_rss_context_priv *ctx,
 					const u32 *rx_indir_table,
-					const u8 *key)
+					const u8 *key, bool delete)
 {
 	int rc;
 
-	WARN_ON(!mutex_is_locked(&efx->rss_lock));
+	WARN_ON(!mutex_is_locked(&efx->net_dev->ethtool->rss_lock));
 
 	if (ctx->context_id == EFX_MCDI_RSS_CONTEXT_INVALID) {
+		if (delete)
+			/* already wasn't in HW, nothing to do */
+			return 0;
 		rc = efx_mcdi_filter_alloc_rss_context(efx, true, ctx, NULL);
 		if (rc)
 			return rc;
 	}
 
-	if (!rx_indir_table) /* Delete this context */
+	if (delete) /* Delete this context */
 		return efx_mcdi_filter_free_rss_context(efx, ctx->context_id);
 
-	rc = efx_mcdi_filter_populate_rss_table(efx, ctx->context_id,
-					 rx_indir_table, key);
-	if (rc)
-		return rc;
-
-	memcpy(ctx->rx_indir_table, rx_indir_table,
-	       sizeof(efx->rss_context.rx_indir_table));
-	memcpy(ctx->rx_hash_key, key, efx->type->rx_hash_key_size);
-
-	return 0;
+	return efx_mcdi_filter_populate_rss_table(efx, ctx->context_id,
+						  rx_indir_table, key);
 }
 
 int efx_mcdi_rx_pull_rss_context_config(struct efx_nic *efx,
@@ -2139,16 +2137,16 @@ int efx_mcdi_rx_pull_rss_context_config(struct efx_nic *efx,
 	size_t outlen;
 	int rc, i;
 
-	WARN_ON(!mutex_is_locked(&efx->rss_lock));
+	WARN_ON(!mutex_is_locked(&efx->net_dev->ethtool->rss_lock));
 
 	BUILD_BUG_ON(MC_CMD_RSS_CONTEXT_GET_TABLE_IN_LEN !=
 		     MC_CMD_RSS_CONTEXT_GET_KEY_IN_LEN);
 
-	if (ctx->context_id == EFX_MCDI_RSS_CONTEXT_INVALID)
+	if (ctx->priv.context_id == EFX_MCDI_RSS_CONTEXT_INVALID)
 		return -ENOENT;
 
 	MCDI_SET_DWORD(inbuf, RSS_CONTEXT_GET_TABLE_IN_RSS_CONTEXT_ID,
-		       ctx->context_id);
+		       ctx->priv.context_id);
 	BUILD_BUG_ON(ARRAY_SIZE(ctx->rx_indir_table) !=
 		     MC_CMD_RSS_CONTEXT_GET_TABLE_OUT_INDIRECTION_TABLE_LEN);
 	rc = efx_mcdi_rpc(efx, MC_CMD_RSS_CONTEXT_GET_TABLE, inbuf, sizeof(inbuf),
@@ -2164,7 +2162,7 @@ int efx_mcdi_rx_pull_rss_context_config(struct efx_nic *efx,
 				RSS_CONTEXT_GET_TABLE_OUT_INDIRECTION_TABLE)[i];
 
 	MCDI_SET_DWORD(inbuf, RSS_CONTEXT_GET_KEY_IN_RSS_CONTEXT_ID,
-		       ctx->context_id);
+		       ctx->priv.context_id);
 	BUILD_BUG_ON(ARRAY_SIZE(ctx->rx_hash_key) !=
 		     MC_CMD_RSS_CONTEXT_SET_KEY_IN_TOEPLITZ_KEY_LEN);
 	rc = efx_mcdi_rpc(efx, MC_CMD_RSS_CONTEXT_GET_KEY, inbuf, sizeof(inbuf),
@@ -2186,35 +2184,42 @@ int efx_mcdi_rx_pull_rss_config(struct efx_nic *efx)
 {
 	int rc;
 
-	mutex_lock(&efx->rss_lock);
+	mutex_lock(&efx->net_dev->ethtool->rss_lock);
 	rc = efx_mcdi_rx_pull_rss_context_config(efx, &efx->rss_context);
-	mutex_unlock(&efx->rss_lock);
+	mutex_unlock(&efx->net_dev->ethtool->rss_lock);
 	return rc;
 }
 
 void efx_mcdi_rx_restore_rss_contexts(struct efx_nic *efx)
 {
 	struct efx_mcdi_filter_table *table = efx->filter_state;
-	struct efx_rss_context *ctx;
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
 	int rc;
 
-	WARN_ON(!mutex_is_locked(&efx->rss_lock));
+	WARN_ON(!mutex_is_locked(&efx->net_dev->ethtool->rss_lock));
 
 	if (!table->must_restore_rss_contexts)
 		return;
 
-	list_for_each_entry(ctx, &efx->rss_context.list, list) {
+	xa_for_each(&efx->net_dev->ethtool->rss_ctx, context, ctx) {
+		struct efx_rss_context_priv *priv;
+		u32 *indir;
+		u8 *key;
+
+		priv = ethtool_rxfh_context_priv(ctx);
 		/* previous NIC RSS context is gone */
-		ctx->context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
+		priv->context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
 		/* so try to allocate a new one */
-		rc = efx_mcdi_rx_push_rss_context_config(efx, ctx,
-							 ctx->rx_indir_table,
-							 ctx->rx_hash_key);
+		indir = ethtool_rxfh_context_indir(ctx);
+		key = ethtool_rxfh_context_key(ctx);
+		rc = efx_mcdi_rx_push_rss_context_config(efx, priv, indir, key,
+							 false);
 		if (rc)
 			netif_warn(efx, probe, efx->net_dev,
-				   "failed to restore RSS context %u, rc=%d"
+				   "failed to restore RSS context %lu, rc=%d"
 				   "; RSS filters may fail to be applied\n",
-				   ctx->user_id, rc);
+				   context, rc);
 	}
 	table->must_restore_rss_contexts = false;
 }
@@ -2276,7 +2281,7 @@ int efx_mcdi_vf_rx_push_rss_config(struct efx_nic *efx, bool user,
 {
 	if (user)
 		return -EOPNOTSUPP;
-	if (efx->rss_context.context_id != EFX_MCDI_RSS_CONTEXT_INVALID)
+	if (efx->rss_context.priv.context_id != EFX_MCDI_RSS_CONTEXT_INVALID)
 		return 0;
 	return efx_mcdi_filter_rx_push_shared_rss_config(efx, NULL);
 }
@@ -2295,7 +2300,7 @@ int efx_mcdi_push_default_indir_table(struct efx_nic *efx,
 
 	efx_mcdi_rx_free_indir_table(efx);
 	if (rss_spread > 1) {
-		efx_set_default_rx_indir_table(efx, &efx->rss_context);
+		efx_set_default_rx_indir_table(efx, efx->rss_context.rx_indir_table);
 		rc = efx->type->rx_push_rss_config(efx, false,
 				   efx->rss_context.rx_indir_table, NULL);
 	}
diff --git a/drivers/net/ethernet/sfc/mcdi_filters.h b/drivers/net/ethernet/sfc/mcdi_filters.h
index c0d6558b9fd2..11b9f87ed9e1 100644
--- a/drivers/net/ethernet/sfc/mcdi_filters.h
+++ b/drivers/net/ethernet/sfc/mcdi_filters.h
@@ -145,9 +145,9 @@ void efx_mcdi_filter_del_vlan(struct efx_nic *efx, u16 vid);
 
 void efx_mcdi_rx_free_indir_table(struct efx_nic *efx);
 int efx_mcdi_rx_push_rss_context_config(struct efx_nic *efx,
-					struct efx_rss_context *ctx,
+					struct efx_rss_context_priv *ctx,
 					const u32 *rx_indir_table,
-					const u8 *key);
+					const u8 *key, bool delete);
 int efx_mcdi_pf_rx_push_rss_config(struct efx_nic *efx, bool user,
 				   const u32 *rx_indir_table,
 				   const u8 *key);
@@ -161,10 +161,6 @@ int efx_mcdi_push_default_indir_table(struct efx_nic *efx,
 int efx_mcdi_rx_pull_rss_config(struct efx_nic *efx);
 int efx_mcdi_rx_pull_rss_context_config(struct efx_nic *efx,
 					struct efx_rss_context *ctx);
-int efx_mcdi_get_rss_context_flags(struct efx_nic *efx, u32 context,
-				   u32 *flags);
-void efx_mcdi_set_rss_context_flags(struct efx_nic *efx,
-				    struct efx_rss_context *ctx);
 void efx_mcdi_rx_restore_rss_contexts(struct efx_nic *efx);
 
 static inline void efx_mcdi_update_rx_scatter(struct efx_nic *efx)
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index f2dd7feb0e0c..b85c51cbe7f9 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -737,21 +737,24 @@ struct vfdi_status;
 /* The reserved RSS context value */
 #define EFX_MCDI_RSS_CONTEXT_INVALID	0xffffffff
 /**
- * struct efx_rss_context - A user-defined RSS context for filtering
- * @list: node of linked list on which this struct is stored
+ * struct efx_rss_context_priv - driver private data for an RSS context
  * @context_id: the RSS_CONTEXT_ID returned by MC firmware, or
  *	%EFX_MCDI_RSS_CONTEXT_INVALID if this context is not present on the NIC.
- *	For Siena, 0 if RSS is active, else %EFX_MCDI_RSS_CONTEXT_INVALID.
- * @user_id: the rss_context ID exposed to userspace over ethtool.
  * @rx_hash_udp_4tuple: UDP 4-tuple hashing enabled
+ */
+struct efx_rss_context_priv {
+	u32 context_id;
+	bool rx_hash_udp_4tuple;
+};
+
+/**
+ * struct efx_rss_context - an RSS context
+ * @priv: hardware-specific state
  * @rx_hash_key: Toeplitz hash key for this RSS context
  * @indir_table: Indirection table for this RSS context
  */
 struct efx_rss_context {
-	struct list_head list;
-	u32 context_id;
-	u32 user_id;
-	bool rx_hash_udp_4tuple;
+	struct efx_rss_context_priv priv;
 	u8 rx_hash_key[40];
 	u32 rx_indir_table[128];
 };
@@ -883,9 +886,7 @@ struct efx_mae;
  * @rx_packet_ts_offset: Offset of timestamp from start of packet data
  *	(valid only if channel->sync_timestamps_enabled; always negative)
  * @rx_scatter: Scatter mode enabled for receives
- * @rss_context: Main RSS context.  Its @list member is the head of the list of
- *	RSS contexts created by user requests
- * @rss_lock: Protects custom RSS context software state in @rss_context.list
+ * @rss_context: Main RSS context.
  * @vport_id: The function's vport ID, only relevant for PFs
  * @int_error_count: Number of internal errors seen recently
  * @int_error_expire: Time at which error count will be expired
@@ -1052,7 +1053,6 @@ struct efx_nic {
 	int rx_packet_ts_offset;
 	bool rx_scatter;
 	struct efx_rss_context rss_context;
-	struct mutex rss_lock;
 	u32 vport_id;
 
 	unsigned int_error_count;
@@ -1416,9 +1416,9 @@ struct efx_nic_type {
 				  const u32 *rx_indir_table, const u8 *key);
 	int (*rx_pull_rss_config)(struct efx_nic *efx);
 	int (*rx_push_rss_context_config)(struct efx_nic *efx,
-					  struct efx_rss_context *ctx,
+					  struct efx_rss_context_priv *ctx,
 					  const u32 *rx_indir_table,
-					  const u8 *key);
+					  const u8 *key, bool delete);
 	int (*rx_pull_rss_context_config)(struct efx_nic *efx,
 					  struct efx_rss_context *ctx);
 	void (*rx_restore_rss_contexts)(struct efx_nic *efx);
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index dcd901eccfc8..0b7dc75c40f9 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -557,69 +557,25 @@ efx_rx_packet_gro(struct efx_channel *channel, struct efx_rx_buffer *rx_buf,
 	napi_gro_frags(napi);
 }
 
-/* RSS contexts.  We're using linked lists and crappy O(n) algorithms, because
- * (a) this is an infrequent control-plane operation and (b) n is small (max 64)
- */
-struct efx_rss_context *efx_alloc_rss_context_entry(struct efx_nic *efx)
+struct efx_rss_context_priv *efx_find_rss_context_entry(struct efx_nic *efx,
+							u32 id)
 {
-	struct list_head *head = &efx->rss_context.list;
-	struct efx_rss_context *ctx, *new;
-	u32 id = 1; /* Don't use zero, that refers to the master RSS context */
-
-	WARN_ON(!mutex_is_locked(&efx->rss_lock));
+	struct ethtool_rxfh_context *ctx;
 
-	/* Search for first gap in the numbering */
-	list_for_each_entry(ctx, head, list) {
-		if (ctx->user_id != id)
-			break;
-		id++;
-		/* Check for wrap.  If this happens, we have nearly 2^32
-		 * allocated RSS contexts, which seems unlikely.
-		 */
-		if (WARN_ON_ONCE(!id))
-			return NULL;
-	}
+	WARN_ON(!mutex_is_locked(&efx->net_dev->ethtool->rss_lock));
 
-	/* Create the new entry */
-	new = kmalloc(sizeof(*new), GFP_KERNEL);
-	if (!new)
+	ctx = xa_load(&efx->net_dev->ethtool->rss_ctx, id);
+	if (!ctx)
 		return NULL;
-	new->context_id = EFX_MCDI_RSS_CONTEXT_INVALID;
-	new->rx_hash_udp_4tuple = false;
-
-	/* Insert the new entry into the gap */
-	new->user_id = id;
-	list_add_tail(&new->list, &ctx->list);
-	return new;
-}
-
-struct efx_rss_context *efx_find_rss_context_entry(struct efx_nic *efx, u32 id)
-{
-	struct list_head *head = &efx->rss_context.list;
-	struct efx_rss_context *ctx;
-
-	WARN_ON(!mutex_is_locked(&efx->rss_lock));
-
-	list_for_each_entry(ctx, head, list)
-		if (ctx->user_id == id)
-			return ctx;
-	return NULL;
-}
-
-void efx_free_rss_context_entry(struct efx_rss_context *ctx)
-{
-	list_del(&ctx->list);
-	kfree(ctx);
+	return ethtool_rxfh_context_priv(ctx);
 }
 
-void efx_set_default_rx_indir_table(struct efx_nic *efx,
-				    struct efx_rss_context *ctx)
+void efx_set_default_rx_indir_table(struct efx_nic *efx, u32 *indir)
 {
 	size_t i;
 
-	for (i = 0; i < ARRAY_SIZE(ctx->rx_indir_table); i++)
-		ctx->rx_indir_table[i] =
-			ethtool_rxfh_indir_default(i, efx->rss_spread);
+	for (i = 0; i < ARRAY_SIZE(efx->rss_context.rx_indir_table); i++)
+		indir[i] = ethtool_rxfh_indir_default(i, efx->rss_spread);
 }
 
 /**
diff --git a/drivers/net/ethernet/sfc/rx_common.h b/drivers/net/ethernet/sfc/rx_common.h
index fbd2769307f9..75fa84192362 100644
--- a/drivers/net/ethernet/sfc/rx_common.h
+++ b/drivers/net/ethernet/sfc/rx_common.h
@@ -84,11 +84,9 @@ void
 efx_rx_packet_gro(struct efx_channel *channel, struct efx_rx_buffer *rx_buf,
 		  unsigned int n_frags, u8 *eh, __wsum csum);
 
-struct efx_rss_context *efx_alloc_rss_context_entry(struct efx_nic *efx);
-struct efx_rss_context *efx_find_rss_context_entry(struct efx_nic *efx, u32 id);
-void efx_free_rss_context_entry(struct efx_rss_context *ctx);
-void efx_set_default_rx_indir_table(struct efx_nic *efx,
-				    struct efx_rss_context *ctx);
+struct efx_rss_context_priv *efx_find_rss_context_entry(struct efx_nic *efx,
+							u32 id);
+void efx_set_default_rx_indir_table(struct efx_nic *efx, u32 *indir);
 
 bool efx_filter_is_mc_recipient(const struct efx_filter_spec *spec);
 bool efx_filter_spec_equal(const struct efx_filter_spec *left,

