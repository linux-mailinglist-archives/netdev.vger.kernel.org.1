Return-Path: <netdev+bounces-158962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F98A13FA2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EA8188E09D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3622BAC0;
	Thu, 16 Jan 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nH8csihK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066422D4C0
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045584; cv=fail; b=m4wdp6CGTCTGDEtKwI4FTJnenJvIYk38LVuI4XhYbTZLUnbi++Q66Ws17cqkLBYiXWrIXaouCK9MIIGeYH5EOKvNJTMb+XjhYFxb8MByZuSEjHDlmsIDO5ZxfYocFw+GBqnaEeag2vFK55acEA1xFIv0JLxk+BSRwRUbmjXRtd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045584; c=relaxed/simple;
	bh=AnEpKqpSF6mzdjIQWPGDKQC5aUhE9uAYD6mWLYudkRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhrnkPLNQIB2E5+67NLtZeV0JAsyunkhSYrWPynwd1/eJ56bvFX8jXfp6xCcfGKOPgG5LN3TlypdU7gBgzOssczynWQWfIGcTDN09qDOPrQz2KB4Jdie7v5q3Djkm4BWANqFBJjakS3Haa7GYW59KYFG+Bqmpffc6ivK7zCri90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nH8csihK; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8vrhE29eEDbxTDxGnrUmFVgCecMJ3vZpLpJXwiG3h442+CDno0QSG/vY/pgk+V83W1SU5Su3bz0a07fuQtaEJRewo71FYp4PQkBt7tYktYirSyYorkAxUNwwHnCfnYUR7kk0P0ks9TT2qgy5H1huqulVRYQGuisUGezgUQ31XtPE1caE7GAv9TqI7mCjCXHDV8Zj6GmftgeMsKp52fmIe5++6ci41swbGn/Fhkd2e+lc3SZndfvFXvZq/O7BaHlc1Q20NS+D+SEW65q+Tyq/Sn1qYxhn1WgJrzUr2ZzMZoPwkOVXl4bIlPibJrqgKL4PAUmEJDRv65/GpMzlto3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+ObXwRZCkU/VBwi/o7yYoiCz/Rag5RD5aBdVEJBfxs=;
 b=RqJwA4TDKokMBtt86Esx6zVg6xl6or2HdUTgq/NetvY3RMWfxYOyAhuCG1PzzfsvNmptIzLndLMC8kGliPj4F1xd6HkFykqsjaWmLp+thspgFasig/wSZE8gUq46IURRiMFSlGZms9X4hExBLWsic6zQ1kXIII/3PXNexikGPVXj4QbGAf5bj+ykWVm/Te05JfsYKbROkN8izcSXMAwrUI/mVDfmBwTLb8gGuUoZipQ+oyDhS9JBc+6UyFHWfp4ESzieBsDtZhUaE6NEtI7/1r0GUTLal7LPNVu81eGyj46Rf8jtfzc78NAzTwmgOcF0drM7nWOSCNlcR/G4Rlc+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+ObXwRZCkU/VBwi/o7yYoiCz/Rag5RD5aBdVEJBfxs=;
 b=nH8csihK0b21T+0hRRg6WQoiMTvH/5iFdLWoSgNdPRimRQkUMqtomcBMgpbx6+fmkd+/h+sGZu281RYcUs8TSE5yE5+hpX97vdvfRclXMDJolEENwvOx6hR4PEilxmJZgCQ9hk12nNfXKT2ELmpohQ/YNDx05r3zyWlOe0WrbjlBBi98R650jWFli0cshgVgZspvoFuWRybXKI9x2KxvhZwXDeTk6ERLL9A2tybzWDzI91mrLjJOj6JMkk5mX8GYV5oxAhpFIQUMaSlowfFOh6rxiLc47R04OszFGynhdfG0HyMT2KqmTDcDQKxd6V4OLIew5HXwLB/lL2c668A3IA==
Received: from PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::39)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 16:39:36 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH1PEPF000132F4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 16:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 16:39:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:18 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:13 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next 4/5] mlxsw: Move Tx header handling to PCI driver
Date: Thu, 16 Jan 2025 17:38:17 +0100
Message-ID: <293a81e6f7d59a8ec9f9592edb7745536649ff11.1737044384.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 2208d631-dc69-404c-9d85-08dd364c5c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydIuezjxedgqmecyLClmtrCwYk2oBFlDuERdeLDmrnbyyLWM7dS5mVKoep6x?=
 =?us-ascii?Q?AnrbvTXv+0Wqc+jMmwKTOKvFpdJnSnCG3JLFeBBVIzF9qnhyJRKmCE46dcba?=
 =?us-ascii?Q?jJRU4lBR7xJhxedr84Bp7dRepP8SRbjAjvt8O96AfEzrPDwwcc2NeTHG7G7R?=
 =?us-ascii?Q?2BbJxy3AZu9kcgKR2YoaovsPkbyadjpffhKMzHGux9VsYN/HKVjFR3FIOeXR?=
 =?us-ascii?Q?hOAKSOFf76vkDXI6ioXEjOXyyOCISpySFCCwYbr/naZiunwnLC4oTQhcweoE?=
 =?us-ascii?Q?Sci6DGhhhz2mMZkuRGmzFpT3aGawpn5kjftrE409MG4cJdX2dZMTeq6Ub7X5?=
 =?us-ascii?Q?JMlKigpmmfBZOMR3dgnmZFdAsLr4erq/9fXuFD3o3TWWiGzwVs/hRYAORRs7?=
 =?us-ascii?Q?kuUFPA2mi0R0xesOOusSrYXynF10hixic6zkLMawqUs1B4hDlBKBkQFjJc7r?=
 =?us-ascii?Q?LnjUIUODkQp0t1yL3cFgJMJEe09Z7d0/EkU2/eDk69cCaf912zvy5oKQu04q?=
 =?us-ascii?Q?mBFZqg+voJwxsZisVZxZbcLhUDkAttSpA7qDQvCass3JmJsQTP7g5HZEPEGm?=
 =?us-ascii?Q?xvNsqB/t6EL5PCzV0kqUO55G9QYr2j0gNwzequ5iKMooDu1cVIQJP+Buk2zv?=
 =?us-ascii?Q?9coK2e5Hsizb5VR4Kag6pV6UpPzNWaVdgAcwzE28v/Fdq6M4lQhC0T4VOPdU?=
 =?us-ascii?Q?aRejHbQH8BefX2NhacEkQJxDdqtkLFg58UWXLjB6mwU7MewV/2+GKtWZGbkl?=
 =?us-ascii?Q?jgTs75uSj5OXmrkstmwZQv+XJv0f6OcOT/r8sil6589Wa5IR8Vpurx8xouvZ?=
 =?us-ascii?Q?F51IYJpdnOQOyc36ZFYbiT67QkWZhCbaqH1PyFEEHCqDePHHDHKbBkKqM45X?=
 =?us-ascii?Q?zpV9AYqLWnEzBWlhxeK7Um5+40APojvP1TETeX6hMlQTRrrvrWEBozeiJ5NW?=
 =?us-ascii?Q?TLNpwpg5FNO44Do0L0kT0eMYX0cngwnRA/wAIczqHZybk+vMobEb+t5dOE/m?=
 =?us-ascii?Q?zid3omXRSW2qLL2Z72QjoGzhWBurepQrI7mHb+86o34UxHhKfXpEV3ahygG/?=
 =?us-ascii?Q?+8orSImFrz/Qw3f7UfIZmjWaTgtqHnuz8uAr8RtEPh/kiHseu3l8+bE8h2d+?=
 =?us-ascii?Q?jZXjF7pRd2trr7agfC6CmndHDyrtFfvUgDFgrSQ8kGJV51LGUhepe1cl+0Z/?=
 =?us-ascii?Q?nMTkIgl2qiaAFjl1sNvUGoSClHKBH1S4aMvuukOncJ2qQGcwQw9Q2hPa3L7D?=
 =?us-ascii?Q?CVw1Utpdb9iIFde4bAPTCUl5XA4PS8hMV9fXJFXk7xvdzsTHVifaYlJfkG2x?=
 =?us-ascii?Q?PyRyTNanPCYk1wh7sgrL7TKK1ckcns17hOO1znUxyU1tHyZq85d6t6YtY4fQ?=
 =?us-ascii?Q?ihFWKeBUPEbGKzYT4yj/vKeJdrqKQ6dZb/OR2xJ7VAa09gHYds1phyOuG3Wt?=
 =?us-ascii?Q?a4tN2XoYXFqFqRJFw9xXuydWUmxqyQ2tSIlBm+pTGe049zhZc2WZ0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:39:34.9339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2208d631-dc69-404c-9d85-08dd364c5c51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

From: Amit Cohen <amcohen@nvidia.com>

Tx header should be added to all packets transmitted from the CPU to
Spectrum ASICs. Historically, handling this header was added as a driver
function, as Tx header is different between Spectrum and Switch-X. See
SwitchX implementation in commit 31557f0f9755 ("mlxsw: Introduce
Mellanox SwitchX-2 ASIC support"). From May 2021, there is no support
for SwitchX-2 ASIC, and all the relevant code was removed.

For now, there is no justification to handle Tx header as part of
spectrum.c, we can handle this as part of PCI, in skb_transmit().

A future patch set will add support for XDP in mlxsw driver, to support
XDP_TX and XDP_REDIRECT actions, Tx header should be added before
transmitting the packet. As preparation for this, move Tx header handling
to PCI driver, so then XDP code will not have to call API from spectrum.c.
This also improves the code as now Tx header is pushed just before
transmitting, so it is not done from many flows which might miss something.

Note that for PTP, we should configure Tx header differently, use the
fields from mlxsw_txhdr_info to configure the packets correctly in PCI
driver. Handle VLAN tagging in switch driver, verify that packet which
should be transmitted as data is tagged, otherwise, tag it.

Remove the calls for thxdr_construct() functions, as now this is done as
part of skb_transmit().

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c    |   6 +-
 drivers/net/ethernet/mellanox/mlxsw/core.h    |   2 -
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  38 ++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 121 ++++--------------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  10 --
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  40 ------
 .../ethernet/mellanox/mlxsw/spectrum_ptp.h    |  28 ----
 7 files changed, 65 insertions(+), 180 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index a3c032da4b4b..39888678a2bd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -737,9 +737,8 @@ static int mlxsw_emad_transmit(struct mlxsw_core *mlxsw_core,
 	if (!skb)
 		return -ENOMEM;
 
-	trace_devlink_hwmsg(priv_to_devlink(mlxsw_core), false, 0,
-			    skb->data + mlxsw_core->driver->txhdr_len,
-			    skb->len - mlxsw_core->driver->txhdr_len);
+	trace_devlink_hwmsg(priv_to_devlink(mlxsw_core), false, 0, skb->data,
+			    skb->len);
 
 	atomic_set(&trans->active, 1);
 	err = mlxsw_core_skb_transmit(mlxsw_core, skb, &trans->txhdr_info);
@@ -995,7 +994,6 @@ static int mlxsw_emad_reg_access(struct mlxsw_core *mlxsw_core,
 	trans->type = type;
 
 	mlxsw_emad_construct(mlxsw_core, skb, reg, payload, type, trans->tid);
-	mlxsw_core->driver->txhdr_construct(skb, &trans->txhdr_info.tx_info);
 
 	spin_lock_bh(&mlxsw_core->emad.trans_list_lock);
 	list_add_tail_rcu(&trans->list, &mlxsw_core->emad.trans_list);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 38d1b507348f..d842af24465d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -432,8 +432,6 @@ struct mlxsw_driver {
 	int (*trap_policer_counter_get)(struct mlxsw_core *mlxsw_core,
 					const struct devlink_trap_policer *policer,
 					u64 *p_drops);
-	void (*txhdr_construct)(struct sk_buff *skb,
-				const struct mlxsw_tx_info *tx_info);
 	int (*resources_register)(struct mlxsw_core *mlxsw_core);
 	int (*kvd_sizes_get)(struct mlxsw_core *mlxsw_core,
 			     const struct mlxsw_config_profile *profile,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index e8e0a06cd4e0..5b44c931b660 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -21,6 +21,7 @@
 #include "cmd.h"
 #include "port.h"
 #include "resources.h"
+#include "txheader.h"
 
 #define mlxsw_pci_write32(mlxsw_pci, reg, val) \
 	iowrite32be(val, (mlxsw_pci)->hw_addr + (MLXSW_PCI_ ## reg))
@@ -2095,6 +2096,39 @@ static void mlxsw_pci_fini(void *bus_priv)
 	mlxsw_pci_free_irq_vectors(mlxsw_pci);
 }
 
+static int mlxsw_pci_txhdr_construct(struct sk_buff *skb,
+				     const struct mlxsw_txhdr_info *txhdr_info)
+{
+	const struct mlxsw_tx_info tx_info = txhdr_info->tx_info;
+	char *txhdr;
+
+	if (skb_cow_head(skb, MLXSW_TXHDR_LEN))
+		return -ENOMEM;
+
+	txhdr = skb_push(skb, MLXSW_TXHDR_LEN);
+	memset(txhdr, 0, MLXSW_TXHDR_LEN);
+
+	mlxsw_tx_hdr_version_set(txhdr, MLXSW_TXHDR_VERSION_1);
+	mlxsw_tx_hdr_proto_set(txhdr, MLXSW_TXHDR_PROTO_ETH);
+	mlxsw_tx_hdr_swid_set(txhdr, 0);
+
+	if (unlikely(txhdr_info->data)) {
+		u16 fid = txhdr_info->max_fid + tx_info.local_port - 1;
+
+		mlxsw_tx_hdr_rx_is_router_set(txhdr, true);
+		mlxsw_tx_hdr_fid_valid_set(txhdr, true);
+		mlxsw_tx_hdr_fid_set(txhdr, fid);
+		mlxsw_tx_hdr_type_set(txhdr, MLXSW_TXHDR_TYPE_DATA);
+	} else {
+		mlxsw_tx_hdr_ctl_set(txhdr, MLXSW_TXHDR_ETH_CTL);
+		mlxsw_tx_hdr_control_tclass_set(txhdr, 1);
+		mlxsw_tx_hdr_port_mid_set(txhdr, tx_info.local_port);
+		mlxsw_tx_hdr_type_set(txhdr, MLXSW_TXHDR_TYPE_CONTROL);
+	}
+
+	return 0;
+}
+
 static struct mlxsw_pci_queue *
 mlxsw_pci_sdq_pick(struct mlxsw_pci *mlxsw_pci,
 		   const struct mlxsw_tx_info *tx_info)
@@ -2131,6 +2165,10 @@ static int mlxsw_pci_skb_transmit(void *bus_priv, struct sk_buff *skb,
 	int i;
 	int err;
 
+	err = mlxsw_pci_txhdr_construct(skb, txhdr_info);
+	if (err)
+		return err;
+
 	if (skb_shinfo(skb)->nr_frags > MLXSW_PCI_WQE_SG_ENTRIES - 1) {
 		err = skb_linearize(skb);
 		if (err)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 4e4d1d366d6c..d2886a8db83d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -165,61 +165,6 @@ void mlxsw_sp_flow_counter_free(struct mlxsw_sp *mlxsw_sp,
 			       counter_index);
 }
 
-void mlxsw_sp_txhdr_construct(struct sk_buff *skb,
-			      const struct mlxsw_tx_info *tx_info)
-{
-	char *txhdr = skb_push(skb, MLXSW_TXHDR_LEN);
-
-	memset(txhdr, 0, MLXSW_TXHDR_LEN);
-
-	mlxsw_tx_hdr_version_set(txhdr, MLXSW_TXHDR_VERSION_1);
-	mlxsw_tx_hdr_ctl_set(txhdr, MLXSW_TXHDR_ETH_CTL);
-	mlxsw_tx_hdr_proto_set(txhdr, MLXSW_TXHDR_PROTO_ETH);
-	mlxsw_tx_hdr_swid_set(txhdr, 0);
-	mlxsw_tx_hdr_control_tclass_set(txhdr, 1);
-	mlxsw_tx_hdr_port_mid_set(txhdr, tx_info->local_port);
-	mlxsw_tx_hdr_type_set(txhdr, MLXSW_TXHDR_TYPE_CONTROL);
-}
-
-int
-mlxsw_sp_txhdr_ptp_data_construct(struct mlxsw_core *mlxsw_core,
-				  struct mlxsw_sp_port *mlxsw_sp_port,
-				  struct sk_buff *skb,
-				  const struct mlxsw_tx_info *tx_info)
-{
-	char *txhdr;
-	u16 max_fid;
-	int err;
-
-	if (skb_cow_head(skb, MLXSW_TXHDR_LEN)) {
-		err = -ENOMEM;
-		goto err_skb_cow_head;
-	}
-
-	if (!MLXSW_CORE_RES_VALID(mlxsw_core, FID)) {
-		err = -EIO;
-		goto err_res_valid;
-	}
-	max_fid = MLXSW_CORE_RES_GET(mlxsw_core, FID);
-
-	txhdr = skb_push(skb, MLXSW_TXHDR_LEN);
-	memset(txhdr, 0, MLXSW_TXHDR_LEN);
-
-	mlxsw_tx_hdr_version_set(txhdr, MLXSW_TXHDR_VERSION_1);
-	mlxsw_tx_hdr_proto_set(txhdr, MLXSW_TXHDR_PROTO_ETH);
-	mlxsw_tx_hdr_rx_is_router_set(txhdr, true);
-	mlxsw_tx_hdr_fid_valid_set(txhdr, true);
-	mlxsw_tx_hdr_fid_set(txhdr, max_fid + tx_info->local_port - 1);
-	mlxsw_tx_hdr_type_set(txhdr, MLXSW_TXHDR_TYPE_DATA);
-	return 0;
-
-err_res_valid:
-err_skb_cow_head:
-	this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
-	dev_kfree_skb_any(skb);
-	return err;
-}
-
 static bool mlxsw_sp_skb_requires_ts(struct sk_buff *skb)
 {
 	unsigned int type;
@@ -242,46 +187,38 @@ static void mlxsw_sp_txhdr_info_data_init(struct mlxsw_core *mlxsw_core,
 	txhdr_info->max_fid = max_fid;
 }
 
-static void
+static struct sk_buff *
+mlxsw_sp_vlan_tag_push(struct mlxsw_sp *mlxsw_sp, struct sk_buff *skb)
+{
+	/* In some Spectrum ASICs, in order for PTP event packets to have their
+	 * correction field correctly set on the egress port they must be
+	 * transmitted as data packets. Such packets ingress the ASIC via the
+	 * CPU port and must have a VLAN tag, as the CPU port is not configured
+	 * with a PVID. Push the default VLAN (4095), which is configured as
+	 * egress untagged on all the ports.
+	 */
+	if (skb_vlan_tagged(skb))
+		return skb;
+
+	return vlan_insert_tag_set_proto(skb, htons(ETH_P_8021Q),
+					 MLXSW_SP_DEFAULT_VID);
+}
+
+static struct sk_buff *
 mlxsw_sp_txhdr_preparations(struct mlxsw_sp *mlxsw_sp, struct sk_buff *skb,
 			    struct mlxsw_txhdr_info *txhdr_info)
 {
 	if (likely(!mlxsw_sp_skb_requires_ts(skb)))
-		return;
+		return skb;
 
 	if (!mlxsw_sp->ptp_ops->tx_as_data)
-		return;
+		return skb;
 
 	/* Special handling for PTP events that require a time stamp and cannot
 	 * be transmitted as regular control packets.
 	 */
 	mlxsw_sp_txhdr_info_data_init(mlxsw_sp->core, skb, txhdr_info);
-}
-
-static int mlxsw_sp_txhdr_handle(struct mlxsw_core *mlxsw_core,
-				 struct mlxsw_sp_port *mlxsw_sp_port,
-				 struct sk_buff *skb,
-				 const struct mlxsw_tx_info *tx_info)
-{
-	struct mlxsw_sp *mlxsw_sp = mlxsw_core_driver_priv(mlxsw_core);
-
-	/* In Spectrum-2 and Spectrum-3, PTP events that require a time stamp
-	 * need special handling and cannot be transmitted as regular control
-	 * packets.
-	 */
-	if (unlikely(mlxsw_sp_skb_requires_ts(skb)))
-		return mlxsw_sp->ptp_ops->txhdr_construct(mlxsw_core,
-							  mlxsw_sp_port, skb,
-							  tx_info);
-
-	if (skb_cow_head(skb, MLXSW_TXHDR_LEN)) {
-		this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
-		dev_kfree_skb_any(skb);
-		return -ENOMEM;
-	}
-
-	mlxsw_sp_txhdr_construct(skb, tx_info);
-	return 0;
+	return mlxsw_sp_vlan_tag_push(mlxsw_sp, skb);
 }
 
 enum mlxsw_reg_spms_state mlxsw_sp_stp_spms_state(u8 state)
@@ -697,12 +634,11 @@ static netdev_tx_t mlxsw_sp_port_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	mlxsw_sp_txhdr_preparations(mlxsw_sp, skb, &txhdr_info);
-
-	err = mlxsw_sp_txhdr_handle(mlxsw_sp->core, mlxsw_sp_port, skb,
-				    &txhdr_info.tx_info);
-	if (err)
+	skb = mlxsw_sp_txhdr_preparations(mlxsw_sp, skb, &txhdr_info);
+	if (!skb) {
+		this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
 		return NETDEV_TX_OK;
+	}
 
 	/* TX header is consumed by HW on the way so we shouldn't count its
 	 * bytes as being sent.
@@ -2753,7 +2689,6 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp1_ptp_ops = {
 	.get_stats_count = mlxsw_sp1_get_stats_count,
 	.get_stats_strings = mlxsw_sp1_get_stats_strings,
 	.get_stats	= mlxsw_sp1_get_stats,
-	.txhdr_construct = mlxsw_sp_ptp_txhdr_construct,
 };
 
 static const struct mlxsw_sp_ptp_ops mlxsw_sp2_ptp_ops = {
@@ -2772,7 +2707,6 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp2_ptp_ops = {
 	.get_stats_count = mlxsw_sp2_get_stats_count,
 	.get_stats_strings = mlxsw_sp2_get_stats_strings,
 	.get_stats	= mlxsw_sp2_get_stats,
-	.txhdr_construct = mlxsw_sp2_ptp_txhdr_construct,
 	.tx_as_data     = true,
 };
 
@@ -2792,7 +2726,6 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp4_ptp_ops = {
 	.get_stats_count = mlxsw_sp2_get_stats_count,
 	.get_stats_strings = mlxsw_sp2_get_stats_strings,
 	.get_stats	= mlxsw_sp2_get_stats,
-	.txhdr_construct = mlxsw_sp_ptp_txhdr_construct,
 };
 
 struct mlxsw_sp_sample_trigger_node {
@@ -3954,7 +3887,6 @@ static struct mlxsw_driver mlxsw_sp1_driver = {
 	.trap_policer_fini		= mlxsw_sp_trap_policer_fini,
 	.trap_policer_set		= mlxsw_sp_trap_policer_set,
 	.trap_policer_counter_get	= mlxsw_sp_trap_policer_counter_get,
-	.txhdr_construct		= mlxsw_sp_txhdr_construct,
 	.resources_register		= mlxsw_sp1_resources_register,
 	.kvd_sizes_get			= mlxsw_sp_kvd_sizes_get,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
@@ -3992,7 +3924,6 @@ static struct mlxsw_driver mlxsw_sp2_driver = {
 	.trap_policer_fini		= mlxsw_sp_trap_policer_fini,
 	.trap_policer_set		= mlxsw_sp_trap_policer_set,
 	.trap_policer_counter_get	= mlxsw_sp_trap_policer_counter_get,
-	.txhdr_construct		= mlxsw_sp_txhdr_construct,
 	.resources_register		= mlxsw_sp2_resources_register,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
 	.txhdr_len			= MLXSW_TXHDR_LEN,
@@ -4029,7 +3960,6 @@ static struct mlxsw_driver mlxsw_sp3_driver = {
 	.trap_policer_fini		= mlxsw_sp_trap_policer_fini,
 	.trap_policer_set		= mlxsw_sp_trap_policer_set,
 	.trap_policer_counter_get	= mlxsw_sp_trap_policer_counter_get,
-	.txhdr_construct		= mlxsw_sp_txhdr_construct,
 	.resources_register		= mlxsw_sp2_resources_register,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
 	.txhdr_len			= MLXSW_TXHDR_LEN,
@@ -4064,7 +3994,6 @@ static struct mlxsw_driver mlxsw_sp4_driver = {
 	.trap_policer_fini		= mlxsw_sp_trap_policer_fini,
 	.trap_policer_set		= mlxsw_sp_trap_policer_set,
 	.trap_policer_counter_get	= mlxsw_sp_trap_policer_counter_get,
-	.txhdr_construct		= mlxsw_sp_txhdr_construct,
 	.resources_register		= mlxsw_sp2_resources_register,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
 	.txhdr_len			= MLXSW_TXHDR_LEN,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 27ccd99ae801..b10f80fc651b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -243,10 +243,6 @@ struct mlxsw_sp_ptp_ops {
 	void (*get_stats_strings)(u8 **p);
 	void (*get_stats)(struct mlxsw_sp_port *mlxsw_sp_port,
 			  u64 *data, int data_index);
-	int (*txhdr_construct)(struct mlxsw_core *mlxsw_core,
-			       struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct sk_buff *skb,
-			       const struct mlxsw_tx_info *tx_info);
 	bool tx_as_data;
 };
 
@@ -712,12 +708,6 @@ int mlxsw_sp_flow_counter_alloc(struct mlxsw_sp *mlxsw_sp,
 				unsigned int *p_counter_index);
 void mlxsw_sp_flow_counter_free(struct mlxsw_sp *mlxsw_sp,
 				unsigned int counter_index);
-void mlxsw_sp_txhdr_construct(struct sk_buff *skb,
-			      const struct mlxsw_tx_info *tx_info);
-int mlxsw_sp_txhdr_ptp_data_construct(struct mlxsw_core *mlxsw_core,
-				      struct mlxsw_sp_port *mlxsw_sp_port,
-				      struct sk_buff *skb,
-				      const struct mlxsw_tx_info *tx_info);
 bool mlxsw_sp_port_dev_check(const struct net_device *dev);
 struct mlxsw_sp *mlxsw_sp_lower_get(struct net_device *dev);
 struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find(struct net_device *dev);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index c5a7aae14262..ca8b9d18fbb9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -1683,43 +1683,3 @@ int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
 
 	return 0;
 }
-
-int mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
-				 struct mlxsw_sp_port *mlxsw_sp_port,
-				 struct sk_buff *skb,
-				 const struct mlxsw_tx_info *tx_info)
-{
-	if (skb_cow_head(skb, MLXSW_TXHDR_LEN)) {
-		this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
-		dev_kfree_skb_any(skb);
-		return -ENOMEM;
-	}
-
-	mlxsw_sp_txhdr_construct(skb, tx_info);
-	return 0;
-}
-
-int mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
-				  struct mlxsw_sp_port *mlxsw_sp_port,
-				  struct sk_buff *skb,
-				  const struct mlxsw_tx_info *tx_info)
-{
-	/* In Spectrum-2 and Spectrum-3, in order for PTP event packets to have
-	 * their correction field correctly set on the egress port they must be
-	 * transmitted as data packets. Such packets ingress the ASIC via the
-	 * CPU port and must have a VLAN tag, as the CPU port is not configured
-	 * with a PVID. Push the default VLAN (4095), which is configured as
-	 * egress untagged on all the ports.
-	 */
-	if (!skb_vlan_tagged(skb)) {
-		skb = vlan_insert_tag_set_proto(skb, htons(ETH_P_8021Q),
-						MLXSW_SP_DEFAULT_VID);
-		if (!skb) {
-			this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
-			return -ENOMEM;
-		}
-	}
-
-	return mlxsw_sp_txhdr_ptp_data_construct(mlxsw_core, mlxsw_sp_port, skb,
-						 tx_info);
-}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
index c8aa1452fbb9..102db9060135 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
@@ -49,11 +49,6 @@ void mlxsw_sp1_get_stats_strings(u8 **p);
 void mlxsw_sp1_get_stats(struct mlxsw_sp_port *mlxsw_sp_port,
 			 u64 *data, int data_index);
 
-int mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
-				 struct mlxsw_sp_port *mlxsw_sp_port,
-				 struct sk_buff *skb,
-				 const struct mlxsw_tx_info *tx_info);
-
 struct mlxsw_sp_ptp_clock *
 mlxsw_sp2_ptp_clock_init(struct mlxsw_sp *mlxsw_sp, struct device *dev);
 
@@ -78,11 +73,6 @@ int mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
 			      struct kernel_ethtool_ts_info *info);
 
-int mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
-				  struct mlxsw_sp_port *mlxsw_sp_port,
-				  struct sk_buff *skb,
-				  const struct mlxsw_tx_info *tx_info);
-
 #else
 
 static inline struct mlxsw_sp_ptp_clock *
@@ -157,15 +147,6 @@ static inline void mlxsw_sp1_get_stats(struct mlxsw_sp_port *mlxsw_sp_port,
 {
 }
 
-static inline int
-mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
-			     struct mlxsw_sp_port *mlxsw_sp_port,
-			     struct sk_buff *skb,
-			     const struct mlxsw_tx_info *tx_info)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct mlxsw_sp_ptp_clock *
 mlxsw_sp2_ptp_clock_init(struct mlxsw_sp *mlxsw_sp, struct device *dev)
 {
@@ -211,15 +192,6 @@ mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 {
 	return -EOPNOTSUPP;
 }
-
-static inline int
-mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
-			      struct mlxsw_sp_port *mlxsw_sp_port,
-			      struct sk_buff *skb,
-			      const struct mlxsw_tx_info *tx_info)
-{
-	return -EOPNOTSUPP;
-}
 #endif
 
 static inline void mlxsw_sp2_ptp_shaper_work(struct work_struct *work)
-- 
2.47.0


