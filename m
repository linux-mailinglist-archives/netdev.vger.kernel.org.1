Return-Path: <netdev+bounces-247721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80811CFDC9B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A65C30BB672
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355E1B142D;
	Wed,  7 Jan 2026 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J3XIo9iZ"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC832DA776;
	Wed,  7 Jan 2026 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790293; cv=fail; b=dwNmuPWu5n9FdXbZf8LRvPFR2Pe/sAj8/7ODBlvHvGSPSe3+oNK4mjIfhlaEoCLs8IhGVr+7x5dOoUIj7zS5MPBW3fwiaUsYcTEv++DP9encvF3Iwdh/ioVkXSz/JEX4xvppG+PglGvRgbk8DmxPbnSzoohifMddnmufnhIM/8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790293; c=relaxed/simple;
	bh=I97r0CvXth5zc1joUpVn2/GP2ftcKhnYzjFCv7yIsMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LunwxTnezSUHPgZ/O0iRRtE3/ZQI4uWqV+zvNfYoCZXDvK+XQ1xaNQCtO8ANbVCJ2cYlnTpy1rQrNMDx0qpSCLEf3p1XIAdrU8PzfKE7FbHimnd+Gs/DKM2Tglji2C1+/ejsQtfVjuNgBT9iWlJN1Oegllia81wX3HEnCJCHgQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J3XIo9iZ; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRmefxvmBaWDroXyEWsomzRbeZ+f1s9ED3nPrhzve2C3EKSWfv/bpUot+dPwQkC44lrUkwX28ee+GlNYbhRZTHDY1E0aI2/EMido1VX9PV5nnHbuUDGMH8xv0gpqvJgFTmX7uGNdiz3G+g8d6ehrpCOZTKA+U321b1WzaC9oA5DSa66N7l5t2PfMDerKUJ2iB/E4p7NHN3UnLInTWN5UUa7mRUvbjO143oy5vROKWwo3g4dXqvHBtshaRcGmlFpEnnTsg55DriEf1stHVLvqYWF/7t9FFq3potgvaiDdOB7mVQfhnesgzfFfyELVWQqdSEAPHNSHqfcUD+ex8UOpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evdp2FF+SlUKdpNZhMqGqiZyrHunsCvKOl4bE9QUom0=;
 b=Dpu4GaoWDKbj+Ln8uPftBkM6RJA84StKFurH3zlA3ZdiGRXP0upE0H0minrK/h8RvAD2riRi36saCsCcWa37Zj3aXPEqpXZvzzfTowswuQrleUJlkxxz/CksJYZnunVFoa7V2yGKwJs/fUVHUnxbqiOLZpIJjvCsro6NyvebC+n8ADBWEchCrw0D3VKp3HXJ06v7n+LXuG93xRh1ytbCWmE5dOUOWJba2a6qBrAvyDhl4+uaNXdhYR58roNDDgzJdNKE4eMjiB89uSj4KtsRHoAGzC2mwLnwAjxcWK6VZ1OLl4SuirY/UZBiu5KvRQL8dwTV0nFapmEuHqj2UmmHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evdp2FF+SlUKdpNZhMqGqiZyrHunsCvKOl4bE9QUom0=;
 b=J3XIo9iZY9GfVxLP2jFGzvYiD2Vwo34e9DBZkxdbNpC24AgkxAPZ8NFXNcvaxFpnQsByh++4xthU0rXjkCC+tjx4/KS2/1WYwT9E3Gqd5sulOIpgYSGJFOMn/jDJKvTuKekWAADCZpsIWdojvKTu8GFBD7+WYCjQfxIcPvvDhh8=
Received: from BN9PR03CA0372.namprd03.prod.outlook.com (2603:10b6:408:f7::17)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:51:28 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::f2) by BN9PR03CA0372.outlook.office365.com
 (2603:10b6:408:f7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 12:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 12:51:27 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 06:51:20 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 06:51:19 -0600
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 06:51:19 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 607CpJ0I4135493;
	Wed, 7 Jan 2026 06:51:19 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 607CpIp6027899;
	Wed, 7 Jan 2026 06:51:19 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <afd@ti.com>, <pmohan@couthit.com>,
	<m-malladi@ti.com>, <basharath@couthit.com>, <vladimir.oltean@nxp.com>,
	<rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Wed, 7 Jan 2026 18:21:10 +0530
Message-ID: <20260107125111.2372254-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107125111.2372254-1-m-malladi@ti.com>
References: <20260107125111.2372254-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SN4PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbc8513-f874-4c4b-5b0e-08de4deb794d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXM6D1ssBboARky5miJD8JBDbmY3ZSw1ZxOVEV2wr4CnA2lQ+fVsVqjvnHes?=
 =?us-ascii?Q?r9lVQ+9HQLZPGbmphyrpV6t0fFT1jhmfUrCQCi/O7JK/t/KxyQ3T7n/zgJ8n?=
 =?us-ascii?Q?H5v4lw/p6ZE+W88mtBgdNwd1OObQo98EbYeb88FPsYOD9vwMDCz3jFMSS1mn?=
 =?us-ascii?Q?pVdEh3cxyFz60v6SNtRuXyhxVkl11imN3xEeHQAo6mn10Cmm9RAiaV/jgGUZ?=
 =?us-ascii?Q?Y+DZV+vW9ZzFOuIkGzl8O8ElC5NT1RKxR5xXPwhX/yOKPoczcgqW/yggPcSm?=
 =?us-ascii?Q?eLQjIi2+YSVQ5iw0hIXIJYGOYRCGpSrNfXR+qYwfSW7GxU1dSA9Mew6WL1Gf?=
 =?us-ascii?Q?ddH/qf3qFojK5Eab9l5RQoZOuAbGHw1lp5JtzacQcq5dpOoLRHz4joHsAUVN?=
 =?us-ascii?Q?uE8yvenaVSzsQdBffxVeUiGAQKgcVSr2NjOJHl31IZJMRK05zOfVpC6luJCM?=
 =?us-ascii?Q?ff5vjogPFtd32pC49U/RU7sXTtzHSSoxp+Sxz4lUq4Mx8V1TWlenz5U9/Gn9?=
 =?us-ascii?Q?A4rRm6So5mfS3yI4j7VW/0p10S7a11YOPesuKMkoxImmfkOE2SctdQ98RgIW?=
 =?us-ascii?Q?2sWFF5aP7Dax9JZvs9NAdpVHXjFksOx/2eD3Xql5PIHG2StnOIND8XNe+YYp?=
 =?us-ascii?Q?oFx4C8W3GHb1yUU/P/jttrR+IC0OKqHzRXs33Yh7WNvH6UQsAfh9skaVcfjH?=
 =?us-ascii?Q?tci+SPSgnKXeR9/DIsYKULZ3mVggJcLLA0ac5AG0RRCWc4lP2slmMkmeAyR7?=
 =?us-ascii?Q?EBPsdpPsWyiimbATHiKi371kDgurjnVQMiPdpjqi7cjdj5Z55S65kB6fAScN?=
 =?us-ascii?Q?syWcZDHhwelWPkNz7CHKEY42nmFL5VSuBVpSauzrft7OOLYUAchiz8qdrhN3?=
 =?us-ascii?Q?C7vdIPciRNWkvPERddnJmClLa0YAQHNyapDRrJfj8o13VEVzK98ZS1MdkHJA?=
 =?us-ascii?Q?HBAlF8DCcXLkCSBXWirTMMzs2ncWa0ljs+sBHNGkM/khstyHPW79PsBBl5J/?=
 =?us-ascii?Q?ypSwXxPdfkBq5u4aryrjtm9Ib7Nr06Bo4Fg2QUcc1smc5RQRjO/7JB/BAK6S?=
 =?us-ascii?Q?93FCr/jgrmAJyGbH1DzfSriVHQLkf9Yuu+KxeSi4I7QtKkGfCRh46NAIJXi8?=
 =?us-ascii?Q?A/VSAa7mUu85PX7LM0caRRlvZtUZLqmEGolulhNFxqPa9RUuvlB7AY8UemXL?=
 =?us-ascii?Q?vN6c88zabtzYjRHxZ+5YZEj1ScKnaMQYbxFPapLumJXMfwqZi/2GJrUXcC8X?=
 =?us-ascii?Q?E0ixGSgaHD0xj2S5b3cdJiykEsdTEKuv6T7lQoHBB/z4KGL/O4X6nzSoRs5x?=
 =?us-ascii?Q?4GMOj4FRTcryk1YtSqAk59WULlqNY6qrWY0SsabfccjJQTWXncdtAQ+Ni9rt?=
 =?us-ascii?Q?rFO3qmyPVASrV9njUbQmw6yBggGCEwvpJeXoM9TJfjw3R8U7oAGhtRG0KPmW?=
 =?us-ascii?Q?zqg1UzaFWnVB+Bl+8HXj6kgvRF1ClIl+QK1Rs0XcyWl41loGa+ygKJRmgfkD?=
 =?us-ascii?Q?RcTCwvNgylyFtQ+PyNDBdK6UHRr4YlYNhO6u?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:51:27.9764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbc8513-f874-4c4b-5b0e-08de4deb794d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605

This patch adds utility functions to configure firmware to enable
IET FPE. The highest priority queue is marked as Express queue and
lower priority queues as pre-emptable, as the default configuration
which will be overwritten by the mqprio tc mask passed by tc qdisc.
Driver optionally allow configure the Verify state machine in the
firmware to check remote peer capability. If remote fails to respond
to Verify command, then FPE is disabled by firmware and TX FPE active
status is disabled.

This also adds the necessary hooks to enable IET/FPE feature in ICSSG
driver. IET/FPE gets configured when Link is up and gets disabled when link
goes down or device is stopped.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/Makefile             |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   9 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 319 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  48 +++
 5 files changed, 379 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 93c0a4d0e33a..2f588663fdf0 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
-icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
+icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index f65041662173..668177eba3f8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -378,6 +378,12 @@ static void emac_adjust_link(struct net_device *ndev)
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		}
+
+		if (emac->link) {
+			icssg_qos_link_up(ndev);
+		} else {
+			icssg_qos_link_down(ndev);
+		}
 	}
 
 	if (emac->link) {
@@ -967,6 +973,8 @@ static int emac_ndo_open(struct net_device *ndev)
 	if (ret)
 		goto destroy_rxq;
 
+	icssg_qos_init(ndev);
+
 	/* start PHY */
 	phy_start(ndev->phydev);
 
@@ -1421,6 +1429,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 10eadd356650..7a586038adf8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,6 +44,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -255,6 +256,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..858268740dae
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static int icssg_prueth_iet_fpe_enable(struct prueth_emac *emac);
+static void icssg_prueth_iet_fpe_disable(struct prueth_qos_iet *iet);
+static void icssg_qos_enable_ietfpe(struct work_struct *work);
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	if (!iet->fpe_configured)
+		return;
+
+	/* Init work queue for IET MAC verify process */
+	iet->emac = emac;
+	INIT_WORK(&iet->fpe_config_task, icssg_qos_enable_ietfpe);
+	init_completion(&iet->fpe_config_compl);
+
+	/* As worker may be sleeping, check this flag to abort
+	 * as soon as it comes of out of sleep and cancel the
+	 * fpe config task.
+	 */
+	atomic_set(&iet->cancel_fpe_config, 0);
+}
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
+	u8 tc;
+	int i;
+
+	/* Configure highest queue as express. Set Bit 4 for FPE,
+	 * Reset for express
+	 */
+
+	/* first set all 8 queues as Preemptive */
+	for (i = 0; i < PRUETH_MAX_TX_QUEUES * PRUETH_NUM_MACS; i++)
+		writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+
+	/* set highest priority channel queue as express as default configuration */
+	writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + emac->tx_ch_num - 1);
+
+	/* set up queue mask for FPE. 1 means express */
+	writeb(BIT(emac->tx_ch_num - 1), config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+
+	/* Overwrite the express queue mapping based on the tc map set by the user */
+	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
+		/* check if the tc is express or not */
+		if (!(p_mqprio->preemptible_tcs & BIT(tc))) {
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				/* Set all the queues in this tc as express queues */
+				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				writeb(BIT(i), config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+			}
+		}
+		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
+	}
+}
+
+static int prueth_mqprio_validate(struct net_device *ndev,
+				  struct tc_mqprio_qopt_offload *mqprio)
+{
+	int num_tc = mqprio->qopt.num_tc;
+	int queue_count = 0;
+	int i;
+
+	/* Always start tc-queue mapping from queue 0 */
+	if (mqprio->qopt.offset[0] != 0)
+		return -EINVAL;
+
+	/* Check for valid number of traffic classes */
+	if (num_tc < 1 || num_tc > PRUETH_MAX_TX_QUEUES)
+		return -EINVAL;
+
+	/* Only channel mode is supported */
+	if (mqprio->mode != TC_MQPRIO_MODE_CHANNEL) {
+		netdev_err(ndev, "Unsupported mode: %d\n", mqprio->mode);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_tc; i++) {
+		if (!mqprio->qopt.count[i]) {
+			netdev_err(ndev, "TC %d has zero size queue count: %d\n",
+				   i, mqprio->qopt.count[i]);
+			return -EINVAL;
+		}
+		if (mqprio->min_rate[i] || mqprio->max_rate[i]) {
+			netdev_err(ndev, "Min/Max tx rate is not supported\n");
+			return -EINVAL;
+		}
+		if (mqprio->qopt.offset[i] != queue_count) {
+			netdev_err(ndev, "Discontinuous queues config is not supported\n");
+			return -EINVAL;
+		}
+		queue_count += mqprio->qopt.count[i];
+	}
+
+	if (queue_count > PRUETH_MAX_TX_QUEUES) {
+		netdev_err(ndev, "Total queues %d exceed max %d\n",
+			   queue_count, PRUETH_MAX_TX_QUEUES);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_mqprio *p_mqprio;
+	int ret;
+
+	if (mqprio->qopt.hw == TC_MQPRIO_HW_OFFLOAD_TCS)
+		return -EOPNOTSUPP;
+
+	if (!mqprio->qopt.num_tc) {
+		netdev_reset_tc(ndev);
+		p_mqprio->preemptible_tcs = 0;
+		return 0;
+	}
+
+	ret = prueth_mqprio_validate(ndev, mqprio);
+	if (ret)
+		return ret;
+
+	p_mqprio = &emac->qos.mqprio;
+	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
+	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
+
+	return 0;
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_link_up(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	if (!iet->fpe_configured)
+		return;
+
+	icssg_prueth_iet_fpe_enable(emac);
+}
+
+void icssg_qos_link_down(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	if (iet->fpe_configured)
+		icssg_prueth_iet_fpe_disable(iet);
+}
+
+static int icssg_config_ietfpe(struct prueth_qos_iet *iet, bool enable)
+{
+	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
+	int ret;
+	u8 val;
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configured) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(iet->emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		return ret;
+	}
+
+	/* Update FPE Tx enable bit. Assume firmware use this bit
+	 * and enable PRE_EMPTION_ACTIVE_TX if everything looks
+	 * good at firmware
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+
+	if (enable && iet->mac_verify_configured) {
+		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, val,
+					 (val == ICSSG_IETFPE_STATE_SUCCEEDED),
+					 USEC_PER_MSEC, 5 * USEC_PER_SEC);
+		if (ret) {
+			netdev_err(iet->emac->ndev,
+				   "timeout for MAC Verify: status %x\n",
+				   val);
+			return ret;
+		}
+	} else {
+		/* Give f/w some time to update PRE_EMPTION_ACTIVE_TX state */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(iet->emac->ndev,
+				   "F/w fails to activate IET/FPE\n");
+			writeb(0, config + PRE_EMPTION_ENABLE_TX);
+			return -ENODEV;
+		}
+	} else {
+		return 0;
+	}
+
+	icssg_iet_set_preempt_mask(iet->emac, p_mqprio->preemptible_tcs);
+
+	iet->fpe_enabled = true;
+
+	return ret;
+}
+
+static void icssg_qos_enable_ietfpe(struct work_struct *work)
+{
+	struct prueth_qos_iet *iet =
+		container_of(work, struct prueth_qos_iet, fpe_config_task);
+	int ret;
+
+	/* Set the required flag and send a command to ICSSG firmware to
+	 * enable FPE and start MAC verify
+	 */
+	ret = icssg_config_ietfpe(iet, true);
+
+	/* if verify configured, poll for the status and complete.
+	 * Or just do completion
+	 */
+	if (!ret)
+		netdev_err(iet->emac->ndev, "IET FPE configured successfully\n");
+	else
+		netdev_err(iet->emac->ndev, "IET FPE config error\n");
+	complete(&iet->fpe_config_compl);
+}
+
+static void icssg_prueth_iet_fpe_disable(struct prueth_qos_iet *iet)
+{
+	int ret;
+
+	atomic_set(&iet->cancel_fpe_config, 1);
+	cancel_work_sync(&iet->fpe_config_task);
+	ret = icssg_config_ietfpe(iet, false);
+	if (!ret)
+		netdev_err(iet->emac->ndev, "IET FPE disabled successfully\n");
+	else
+		netdev_err(iet->emac->ndev, "IET FPE disable failed\n");
+}
+
+static int icssg_prueth_iet_fpe_enable(struct prueth_emac *emac)
+{
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	/* Schedule MAC Verify and enable IET FPE if configured */
+	atomic_set(&iet->cancel_fpe_config, 0);
+	reinit_completion(&iet->fpe_config_compl);
+	schedule_work(&iet->fpe_config_task);
+	/* By trial, found it takes about 1.5s. So
+	 * wait for 10s
+	 */
+	ret = wait_for_completion_timeout(&iet->fpe_config_compl,
+					  msecs_to_jiffies(10000));
+	if (!ret) {
+		netdev_err(emac->ndev,
+			   "IET verify completion timeout\n");
+		/* cancel verify in progress */
+		atomic_set(&iet->cancel_fpe_config, 1);
+		cancel_work_sync(&iet->fpe_config_task);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..3d3f42107dd7
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt_offload mqprio;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos_iet {
+	struct work_struct fpe_config_task;
+	struct completion fpe_config_compl;
+	struct prueth_emac *emac;
+	atomic_t cancel_fpe_config;
+	/* Set through priv flags to enable IET frame preemption */
+	bool fpe_configured;
+	/* Set through priv flags to enable IET MAC Verify state machine
+	 * in firmware
+	 */
+	bool mac_verify_configured;
+	/* Min TX fragment size, set via ethtool */
+	u32 tx_min_frag_size;
+	/* wait time between verification attempts in ms (according to clause
+	 * 30.14.1.6 aMACMergeVerifyTime), set via ethtool
+	 */
+	u32 verify_time_ms;
+	/* Set if IET FPE is active */
+	bool fpe_enabled;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_up(struct net_device *ndev);
+void icssg_qos_link_down(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0


