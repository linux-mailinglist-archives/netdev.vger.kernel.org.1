Return-Path: <netdev+bounces-158961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC9A13F9E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442913A98F9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4F22CF28;
	Thu, 16 Jan 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qlxmhChs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EBA22CBFA
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045575; cv=fail; b=C/O5ssZsOScdjIS8G6kDdhWFn+reSdTsApHO7NxO6l/aGcWv6kWUzCfdCMJoRq7qifkHoAo9Lsf6WwGER6yasCtTZgT/0OUw7dBYu37lDNMTTTVMrUuBNrNw+DbDFNJXoDl3uVX2fHGiaid8cZ7uNPQH/3J8Kclx+qMWbeGKzAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045575; c=relaxed/simple;
	bh=FIuWgcJOhqhTlanmzp7pP303irSU0JkuPDbiAY8wk+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPB9v7IiJLgDkB9TlyClf5xwq+3nZvQucnbwSMxZgSfZVniyO2i+zhfVj1NNghLBk3868HvzNc5+aCipGpLb4nundCakbXJLQ0dIygsohLQUCSSfF0lWYPwHlwLAMJpLTgw6oBLPCUUFx/ynjYr6zODqMEdPetVLoRbm1v1MNY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qlxmhChs; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wktZEmYL2UMK//QAbBEnjCrpDVO9bUevlg2WO28D808YjO2WA+aTi0E3qQky5q3mgolSwniQ4aUw0sJyfbIJ0PgxUgVpeqRbdDwjVfFdNwPsUXEHr96lS27W6wrZMaiYD+CeXZM95BXZs1251Hy69gjuFkJsn9GQrgzQVv5rP0rTnfcAAF5ppZ+41hGTu2E5vw/6sSHQeEtP0oqEbSr1dyR56XNvl+s78f0XsxOVg116N58qJScmYeTq0b5ieDT588EPUndPnuLORgMtI2CpJfK7kJ70gXCSDSjSrhX3GS/DapffnKIQjLVWTFX6efKZE1442wvzVKjEEroq1YZpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmHP++FsWELmohWdO0E1JwEffKtPDOOq1QJObM/0ntI=;
 b=BNda3gGs2M/yAE7f9r4c9DPt2/LugI+dkz1A64tBgh/fs+QBKiVLpYe26IJTxZAn/NrKMEM1clDDBgX533WKK67wT9zgUKj/A1nynCWOVx9JNBE/HmVMGRZ0eglYGdNzItH7f4kRcuqC3ignstQyktb4QK4cV6AoFg4E7u+Jmalgl0ejyWb5ja5V5mQTkb4rLPCTsc+Zjcg9lm3V/qeuYL0oEo7YSP+HpuQ8nTtg/WJVc08mssjIQCVbt1CDh8gHyDPvQtK/6/HlfJIdLdjM1kan0igNk2IKRstnmiw9WgzYkySW2dpvz8rffwJeJxAzS3fQyVN2AaGrkvcMzfnkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmHP++FsWELmohWdO0E1JwEffKtPDOOq1QJObM/0ntI=;
 b=qlxmhChsCc7/yd1Zyzr7tgwbx9CCPByvHU8FqAAX5EXUcr73THWjZVRRZ8jgbcURq4fWZ7JXa33uMGe4iIdaZ//5CnSXUpjqn8PPIqVdLQGWzRiDoZgwxTrRYye4EzLlHzGZ9cGjk7DlLy1f95r7TelONEabWkdOUV9avlpWUIUzHHNSresGgAH92W6jyoaAJiO8Ow0QAhyz0n/++CLN2xhVFK/+01XEbXWcYFu6GCxI2NaDtcp4I6lT6PQkd/MOkdEqQ2jWP5Ow93A+VCzIQwjliYpWNyMu8G3h3z4+jia0jv9JeHNsWt6xlB9aJIjGrG2R/alUFRLgq5uL8Hmjwg==
Received: from BL6PEPF00016414.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:c) by PH8PR12MB7135.namprd12.prod.outlook.com
 (2603:10b6:510:22c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Thu, 16 Jan
 2025 16:39:28 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2a01:111:f403:c803::1) by BL6PEPF00016414.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 16:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.0 via Frontend Transport; Thu, 16 Jan 2025 16:39:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:08 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:03 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next 2/5] mlxsw: Initialize txhdr_info according to PTP operations
Date: Thu, 16 Jan 2025 17:38:15 +0100
Message-ID: <efcaacd4bedef524e840a0c29f96cebf2c4bc0e0.1737044384.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737044384.git.petrm@nvidia.com>
References: <cover.1737044384.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be9cb0f-582e-4b74-e9a8-08dd364c587f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yl0u1tQub1bWyEVfHvhHtmHN1d4jwO7GHfQ1SZtJ0k4VXdOe9UKs4ZwqdjG?=
 =?us-ascii?Q?O9uGGcWiwdjBf0FxbXnPHVl9hYNH7fiL6e9j1XFCR1+9cG6Rasz40x346E9c?=
 =?us-ascii?Q?mOg5xk/Pezx/VEVDtN4ZbO4Ip9T/eqIZ7q5AlkBYqdT+U2Na7EU19G98gVbk?=
 =?us-ascii?Q?3CPmuFsG4LImu5VWGTUMDyLy9gaZGDT8hEyV66jrtcTMRQ8QuyVVLhSfxPZU?=
 =?us-ascii?Q?B8GnCLj4qmdCXTswbW0L1c+8RP/mNmBFwLLNW4gLAeJMANhTdLBMCQJ+dcEI?=
 =?us-ascii?Q?wCOYBKGmSi6hujQO2EpLQCHHdNTcLfYO4jihA+18GWPx6bT6ICKgwK2235zl?=
 =?us-ascii?Q?DJAFfSkn/5MblO3oNHrEvIznibowExUlIXtI3eFDhtyrEkJibT625wXtS4JA?=
 =?us-ascii?Q?Tt+m9u0vq6P20l3Kauh3r4/g3fPoRoEN0tqsbDM/lArqChcoqbFVd53Nxj2f?=
 =?us-ascii?Q?9yCYoXCmsW1Q5wt7yC0zhjdo7BxEur/z7Rsy6yausxWd6FRidNqI01pfgMGx?=
 =?us-ascii?Q?6Sm51MPGC3iRVNjxnOnttKxzItfDLau9B6MSQQnJ4SaKL7xte3J5QLCDUOd1?=
 =?us-ascii?Q?R3gbwZNSfFjudrdusNZL5uIcITqgFzCvdEQ9l1QoMpYd9NcWVbF3xnoqhqMr?=
 =?us-ascii?Q?15nhWEevt7QZdmJ/CMbQT0EPrPm/rlXJkgBgR6MmuPiRPgKeA7nkwfqIUuR8?=
 =?us-ascii?Q?iyWKNBSwVWDf8QJXWQOufx4BHa08TRgkNWnu0u6iQU4+AD4aKg0FuiD3mjx1?=
 =?us-ascii?Q?Op+cemphrH06Ox6kMeMXQvRmXyon2gD7kAVYsAHH2Ot/Kpa66ih9zaausujy?=
 =?us-ascii?Q?rcTy9W6tum17YdIKXehs0LjdGaAuez59Ko6POVlU4isHsiMA9XYSwPNRu0PK?=
 =?us-ascii?Q?Xi3quIr01xCPIpTfQaEHx28wZBCCzY+Mppy1uubyBePH94ox+LjCg40PmpIh?=
 =?us-ascii?Q?jiQl5CPblvV/6/eHWqmVC6GV/UR5QH6iLeTzM4PeIrnmYYQrapyj1d4NT9iA?=
 =?us-ascii?Q?KX0PYZIv6XH1nN+mRmKl3aa1cyx055ubBXt9f7E483KWfTbDvbYmKahlRJjA?=
 =?us-ascii?Q?GWDKx2io9omBnGD2+eDCJvF2apCwMvdXHg9MBRVffmRTQWuNWbRTCHd2P/JG?=
 =?us-ascii?Q?xh8WWZ15B0q1CTVzynr1kqB4ZbHoSWF3SkzXN+Nrysc9+ncq298+jC8mlh6F?=
 =?us-ascii?Q?xxWO4nSx/5LdGCwO/xh6Bo4MdDWRYqBnmVBwgjLXkDprERa9s90+yiLOV+Qk?=
 =?us-ascii?Q?jcbDSJoaV5i3X3EIvgsIlAmchQyl2DMgidY5x8zJ6eigLYPIbgUr3vOkEO8m?=
 =?us-ascii?Q?Lu2koiJvCRBCTlU2Do5eRyrIQtq2IXXTsa2x2ou2tNJ7xVWT1cHyltnvBIC8?=
 =?us-ascii?Q?YSy/Sel64RaB5+h/LNzovXZmUZ2ZENnDnANpkSqdEd+B3jWxspyBX4id/zc7?=
 =?us-ascii?Q?AfkolFPnVu0ai3ezi19C5G6c/BIfGrZiOTSUKWkfmuId5ESW/M1iKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:39:28.4639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be9cb0f-582e-4b74-e9a8-08dd364c587f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

From: Amit Cohen <amcohen@nvidia.com>

A next patch will construct Tx header as part of pci.c. The switch driver
(mlxsw_spectrum.ko) should encapsulate all the differences between the
different ASICs and the bus driver (mlxsw_pci.ko) should remain unaware.

As preparation, add the relevant info as part of mlxsw_txhdr_info
structure, so later bus driver will merely construct the Tx header based on
information passed from the switch driver.

Most of the packets are transmitted as control packets, but PTP packets in
Spectrum-2 and Spectrum-3 should be handled differently. The driver
transmits them as data packets, and the default VLAN tag (4095) is added if
the packet is not already tagged.

Extend PTP operations to store a boolean which indicates whether packets
should be transmitted as data packets. Set it for Spectrum-2 and
Spectrum-3 only. Extend mlxsw_txhdr_info to store fields which will be used
later to construct Tx header. Initialize such fields according to the new
boolean which is stored in PTP operations.

Note that for now, mlxsw_txhdr_info structure is initialized, but not used,
a next patch will use it.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.h    |  2 ++
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 32 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  1 +
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  4 +++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index cd33ceb2154b..38d1b507348f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -74,6 +74,8 @@ struct mlxsw_tx_info {
 
 struct mlxsw_txhdr_info {
 	struct mlxsw_tx_info tx_info;
+	bool data;
+	u16 max_fid; /* Used for PTP packets which are sent as data. */
 };
 
 struct mlxsw_rx_md_info {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3bd6230307aa..061a3bb81c72 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -299,6 +299,33 @@ static bool mlxsw_sp_skb_requires_ts(struct sk_buff *skb)
 	return !!ptp_parse_header(skb, type);
 }
 
+static void mlxsw_sp_txhdr_info_data_init(struct mlxsw_core *mlxsw_core,
+					  struct sk_buff *skb,
+					  struct mlxsw_txhdr_info *txhdr_info)
+{
+	/* Resource validation was done as part of PTP init. */
+	u16 max_fid = MLXSW_CORE_RES_GET(mlxsw_core, FID);
+
+	txhdr_info->data = true;
+	txhdr_info->max_fid = max_fid;
+}
+
+static void
+mlxsw_sp_txhdr_preparations(struct mlxsw_sp *mlxsw_sp, struct sk_buff *skb,
+			    struct mlxsw_txhdr_info *txhdr_info)
+{
+	if (likely(!mlxsw_sp_skb_requires_ts(skb)))
+		return;
+
+	if (!mlxsw_sp->ptp_ops->tx_as_data)
+		return;
+
+	/* Special handling for PTP events that require a time stamp and cannot
+	 * be transmitted as regular control packets.
+	 */
+	mlxsw_sp_txhdr_info_data_init(mlxsw_sp->core, skb, txhdr_info);
+}
+
 static int mlxsw_sp_txhdr_handle(struct mlxsw_core *mlxsw_core,
 				 struct mlxsw_sp_port *mlxsw_sp_port,
 				 struct sk_buff *skb,
@@ -721,7 +748,7 @@ static netdev_tx_t mlxsw_sp_port_xmit(struct sk_buff *skb,
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 	struct mlxsw_sp_port_pcpu_stats *pcpu_stats;
-	const struct mlxsw_txhdr_info txhdr_info = {
+	struct mlxsw_txhdr_info txhdr_info = {
 		.tx_info.local_port = mlxsw_sp_port->local_port,
 		.tx_info.is_emad = false,
 	};
@@ -738,6 +765,8 @@ static netdev_tx_t mlxsw_sp_port_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
+	mlxsw_sp_txhdr_preparations(mlxsw_sp, skb, &txhdr_info);
+
 	err = mlxsw_sp_txhdr_handle(mlxsw_sp->core, mlxsw_sp_port, skb,
 				    &txhdr_info.tx_info);
 	if (err)
@@ -2812,6 +2841,7 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp2_ptp_ops = {
 	.get_stats_strings = mlxsw_sp2_get_stats_strings,
 	.get_stats	= mlxsw_sp2_get_stats,
 	.txhdr_construct = mlxsw_sp2_ptp_txhdr_construct,
+	.tx_as_data     = true,
 };
 
 static const struct mlxsw_sp_ptp_ops mlxsw_sp4_ptp_ops = {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 8d3c61287696..27ccd99ae801 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -247,6 +247,7 @@ struct mlxsw_sp_ptp_ops {
 			       struct mlxsw_sp_port *mlxsw_sp_port,
 			       struct sk_buff *skb,
 			       const struct mlxsw_tx_info *tx_info);
+	bool tx_as_data;
 };
 
 struct mlxsw_sp_fid_core_ops {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index d94081c7658e..c5a7aae14262 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -1353,6 +1353,10 @@ struct mlxsw_sp_ptp_state *mlxsw_sp2_ptp_init(struct mlxsw_sp *mlxsw_sp)
 	struct mlxsw_sp2_ptp_state *ptp_state;
 	int err;
 
+	/* Max FID will be used in data path, check validity as part of init. */
+	if (!MLXSW_CORE_RES_VALID(mlxsw_sp->core, FID))
+		return ERR_PTR(-EIO);
+
 	ptp_state = kzalloc(sizeof(*ptp_state), GFP_KERNEL);
 	if (!ptp_state)
 		return ERR_PTR(-ENOMEM);
-- 
2.47.0


