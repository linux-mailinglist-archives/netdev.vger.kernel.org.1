Return-Path: <netdev+bounces-176560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5DA6AC93
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0AE189720B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F47226173;
	Thu, 20 Mar 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2AI/LrR7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795D1E9915
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493514; cv=fail; b=WuSdm+e3X+sVXVboMaL6W7lc1Wojv6PKXtB5CuQXpVNzCCCKunQe8YHmTP8FkoTmkUdgnpiWI1fIuejN3bCg9B1chn03iGGrdRQGlqncmD7IZRe+Vq2scuafMk05KX54/YiUCG0xD8OP/+Mw2RS5TBf/CItcWfAOU9Y590hwM/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493514; c=relaxed/simple;
	bh=tq5xibINP9Aac/MHgAMd3w5cL0lSmVUcWv7YCyxVi7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giwDN5vyvXOjgkLzvBuCkhvi2Mkp/xfRTSvgA4Y8Gu0/gKkqTuhcLGMS08yDT++oB0PAd+7CekCSjxAhNpIZpGDgc2OsLd5kzn26qnaqcn5/7E0HBFo2gi/GVbPim+e5k36NZsewONl6r0EsLJntZSU95FON2rF1j+8qNbTzfyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2AI/LrR7; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLML5DYwbFNDZHsosOqe0/4pkFYKvXjDQ4o/YsPPrRJ1gf2qHCHQNNKsxZLUByYOasuoKkf5/wed1nnxdMoczhZQSNIUbjR8sGuoDgOvi8GOvjnrab35i31ce3Gd2UFCTY1MMlLReZBmRpKYagctMKno/WvA3u3kLTkPalzZPh7boRX/e2uWGXzxYVXMke7s5KSu65HiWRrN1kybfwlY0+CQJJh8PCNQkYHljJaxmwCnTuscjmYIRoGZ/C1AL9dRQQjqu1z26S3bXvuZZqGDoiyBw8EfI06dVCaw2BGGKlSU2E345UgEobDTk16Mtk16+sD+qgNok0SPlcNVBGz4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n55dyE0g6ok2B8x8PnZQbB1/PPiURlOAOxU6hCo1mHU=;
 b=UMxbuERM3X/8iPLt+6lNgwo2ThVoi/6IS49RCkzD2xuHIR+KZxxIkRr3Yfo2oVJARvpedYmQPVyY0uJ8XR1iZG85l27jbE1ur0aXEdCkbnIqrkNYCL6c4mJtkc6pHjOkK293f2QE6Yh9c6Ro7/8kGLN7dDzdWfHB25E9vLvSw21u68DBdsaFJ7gtsGfgIhEUJJlFEbLEQ62yJgjCKFMmcincyC6M9hLjAlA5PPQSH0eRrECBTAX07gT+m5nLEz/tuLKfnB5W3PT7sAX9JfhJ4bWe6Lb70yeqJ0NNnTj1clTgE0mqAIxB7AaF/sKL7MK0MpFFhzv+VEGwhSvNnk2KYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n55dyE0g6ok2B8x8PnZQbB1/PPiURlOAOxU6hCo1mHU=;
 b=2AI/LrR76yQUFKWqtjsItWgFJYEYAjs4tYHYmgyRvhchem7weNPUpx+tk1re4wkhGL0O0ydJoEOihJr9z37V/LIHE/Y0Tln+PE29a285kGEMuhGoZXM9jA7hSQk92XaCJucTwPu6/H8X4ClsTyWer+jrB1Zs08yRAC/+5jBvDh8=
Received: from MN2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:208:120::17)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 17:58:26 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:120:cafe::15) by MN2PR10CA0004.outlook.office365.com
 (2603:10b6:208:120::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 17:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Thu, 20 Mar 2025 17:58:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 12:58:25 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Mar 2025 12:58:24 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/3] sfc: rip out MDIO support
Date: Thu, 20 Mar 2025 17:57:10 +0000
Message-ID: <aa689d192ddaef7abe82709316c2be648a7bd66e.1742493017.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1742493016.git.ecree.xilinx@gmail.com>
References: <cover.1742493016.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 47aa3bae-d220-4cc0-72fc-08dd67d8d00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXqBp3bAqiEovo9bZiM3dhmOXZZ11Ly6WejCQYdx59/vPKoyimHfhu0ItAxd?=
 =?us-ascii?Q?99EwM84LVueEasuMF0nPS0W8ujN/cPGe+J7Wbi8J07T0ANPnll/ixo9XZKJJ?=
 =?us-ascii?Q?Iuyjst/kKXdWm61nEiok1d9BQlsmrnsZbIDnWj5H/EuezKfh16DxSi08k4hI?=
 =?us-ascii?Q?oQtb7R5bL0uwsgncsEFb5CcRfgBQWlKXyfMU9uoi9VhCj+73fRghN+z85egp?=
 =?us-ascii?Q?ypHSPcYdtjhgXwB7rc4y1vUhancNi6A5q3nPB9d1O43GLXYk3/Y1ZXQZBUue?=
 =?us-ascii?Q?hylRcG1oyI5mrkYTO9hBj76kpS56HvMgEEYGReZoEHcI0UPGGD/VUiFbsiPO?=
 =?us-ascii?Q?NIU1aHyX7o5J8a43aupX1sgxDgxRSuEni+BPMkNGFRTUdmzL0qe5JHX17nKK?=
 =?us-ascii?Q?5LbfbOCUgjS9bR/m90s6oGdEN4uZCzg53qZ9cIddRBbKYLGGzfXVYhhTmuet?=
 =?us-ascii?Q?ZxXfkJOcCkHGETDIRACtWD07g7f63ZqIlzNZFAPt4N30jhTwVHPQPCVAllKd?=
 =?us-ascii?Q?GjiQv9zY1Y++rC67jqti+DSXUalGKJuKI42t8/3gVmbOukKfytSaBJhyrU3w?=
 =?us-ascii?Q?g1kcZsofq2iWMVyWy8rV4xezU9B5LkvUFHIVgjCu7nxS2hxQofPQAbgInq1R?=
 =?us-ascii?Q?r6XTc1PgPsZ0WMKDxq45HnIHO/ycNND4uWFql1yTjzbp0m5R2a/ryrGIqR1r?=
 =?us-ascii?Q?JaBDuuw09cd/WYBZIZerX64sMIbqpbKfOeJYmNn6bbMuz96EIFVtZhdAfOyc?=
 =?us-ascii?Q?NgQMTG5eQG4TEYApPbh4MfDa3lmN9DJtMF4hWAIZ3F1tt5J8kp9Vaecocl7m?=
 =?us-ascii?Q?E9y+gRxP1iNlQmWMi8QEdMO7ETaouq+mCf/7kfU/rVIhYVfnmjgeAbmwdMxz?=
 =?us-ascii?Q?30UGjppnq31o/v3q7932D/olp8EYTyUfnQXoWhcKsUmGX8MlVFdWv914POzc?=
 =?us-ascii?Q?ZZEaF1LFqFT7m/8s0HyM7w57XkYVGWyfnaeHd8puTLtiDsAfeR7caj5BuRHn?=
 =?us-ascii?Q?KkKXctweT8FVLeKTL3onEl3n8lxS6LSQ1IKjdI2hrEGyJLYTOk/QpgyKgrvI?=
 =?us-ascii?Q?Kv3vFlP+aVpZO2fOnx/86V5jiOTiNUpuNWmS9FIfM1zDpMMSR2XN98OpJ+ma?=
 =?us-ascii?Q?dvlnRzmOaogHvRytxbbPzA9ce5C8PvtR/xbqej0N+eWRFipCYesumGwn0DYM?=
 =?us-ascii?Q?L4luW6zMIGje6G00sZx8kLHBZR8Gaj5DmId+cRQebwPMwtTzXlO7G91P/KkP?=
 =?us-ascii?Q?OaoQwn0bdMDtEUNOMYscF9uks/ek9UiDJql9WawIrFM1JjksdmBfi19BpLrn?=
 =?us-ascii?Q?E3JduPENL+L+7ccemyR3l2cSS/58Jxzhe5J/s9QUgd8RjXfOFaF7QMdVQSqv?=
 =?us-ascii?Q?wWDriDH4Uj2lLPHezZf62i6IluhE+Yxid6kcrfxc3ZM/WjrG7Z/OHu3MkP9B?=
 =?us-ascii?Q?9mmP3W9WrWeXQqoA3mMLVTnDN88SMwX35JpUJKPG60AVmV18Yq+eW7C79b+8?=
 =?us-ascii?Q?bmtYNG5V7+oOPlg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:58:25.7148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aa3bae-d220-4cc0-72fc-08dd67d8d00d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887

From: Edward Cree <ecree.xilinx@gmail.com>

Unlike Siena, no EF10 board ever had an external PHY, and consequently
 MDIO handling isn't even built into the firmware.  Since Siena has
 been split out into its own driver, the MDIO code can be deleted from
 the sfc driver.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_netdev.c     |  1 -
 drivers/net/ethernet/sfc/efx.c              | 24 ---------
 drivers/net/ethernet/sfc/mcdi_port.c        | 59 +--------------------
 drivers/net/ethernet/sfc/mcdi_port_common.c | 11 ----
 drivers/net/ethernet/sfc/net_driver.h       |  6 +--
 5 files changed, 2 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index 7f7d560cb2b4..d941f073f1eb 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -452,7 +452,6 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 				  NETIF_F_HIGHDMA | NETIF_F_ALL_TSO;
 	netif_set_tso_max_segs(net_dev,
 			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
-	efx->mdio.dev = net_dev;
 
 	rc = efx_ef100_init_datapath_caps(efx);
 	if (rc < 0)
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 650136dfc642..112e55b98ed3 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -474,28 +474,6 @@ void efx_get_irq_moderation(struct efx_nic *efx, unsigned int *tx_usecs,
 	}
 }
 
-/**************************************************************************
- *
- * ioctls
- *
- *************************************************************************/
-
-/* Net device ioctl
- * Context: process, rtnl_lock() held.
- */
-static int efx_ioctl(struct net_device *net_dev, struct ifreq *ifr, int cmd)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	struct mii_ioctl_data *data = if_mii(ifr);
-
-	/* Convert phy_id from older PRTAD/DEVAD format */
-	if ((cmd == SIOCGMIIREG || cmd == SIOCSMIIREG) &&
-	    (data->phy_id & 0xfc00) == 0x0400)
-		data->phy_id ^= MDIO_PHY_ID_C45 | 0x0400;
-
-	return mdio_mii_ioctl(&efx->mdio, data, cmd);
-}
-
 /**************************************************************************
  *
  * Kernel net device interface
@@ -593,7 +571,6 @@ static const struct net_device_ops efx_netdev_ops = {
 	.ndo_tx_timeout		= efx_watchdog,
 	.ndo_start_xmit		= efx_hard_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= efx_ioctl,
 	.ndo_change_mtu		= efx_change_mtu,
 	.ndo_set_mac_address	= efx_set_mac_address,
 	.ndo_set_rx_mode	= efx_set_rx_mode,
@@ -1201,7 +1178,6 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	rc = efx_init_struct(efx, pci_dev);
 	if (rc)
 		goto fail1;
-	efx->mdio.dev = net_dev;
 
 	pci_info(pci_dev, "Solarflare NIC detected\n");
 
diff --git a/drivers/net/ethernet/sfc/mcdi_port.c b/drivers/net/ethernet/sfc/mcdi_port.c
index ad4694fa3dda..7b236d291d8c 100644
--- a/drivers/net/ethernet/sfc/mcdi_port.c
+++ b/drivers/net/ethernet/sfc/mcdi_port.c
@@ -17,58 +17,6 @@
 #include "selftest.h"
 #include "mcdi_port_common.h"
 
-static int efx_mcdi_mdio_read(struct net_device *net_dev,
-			      int prtad, int devad, u16 addr)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	MCDI_DECLARE_BUF(inbuf, MC_CMD_MDIO_READ_IN_LEN);
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_MDIO_READ_OUT_LEN);
-	size_t outlen;
-	int rc;
-
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_BUS, efx->mdio_bus);
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_PRTAD, prtad);
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_DEVAD, devad);
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_ADDR, addr);
-
-	rc = efx_mcdi_rpc(efx, MC_CMD_MDIO_READ, inbuf, sizeof(inbuf),
-			  outbuf, sizeof(outbuf), &outlen);
-	if (rc)
-		return rc;
-
-	if (MCDI_DWORD(outbuf, MDIO_READ_OUT_STATUS) !=
-	    MC_CMD_MDIO_STATUS_GOOD)
-		return -EIO;
-
-	return (u16)MCDI_DWORD(outbuf, MDIO_READ_OUT_VALUE);
-}
-
-static int efx_mcdi_mdio_write(struct net_device *net_dev,
-			       int prtad, int devad, u16 addr, u16 value)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	MCDI_DECLARE_BUF(inbuf, MC_CMD_MDIO_WRITE_IN_LEN);
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_MDIO_WRITE_OUT_LEN);
-	size_t outlen;
-	int rc;
-
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_BUS, efx->mdio_bus);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_PRTAD, prtad);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_DEVAD, devad);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_ADDR, addr);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_VALUE, value);
-
-	rc = efx_mcdi_rpc(efx, MC_CMD_MDIO_WRITE, inbuf, sizeof(inbuf),
-			  outbuf, sizeof(outbuf), &outlen);
-	if (rc)
-		return rc;
-
-	if (MCDI_DWORD(outbuf, MDIO_WRITE_OUT_STATUS) !=
-	    MC_CMD_MDIO_STATUS_GOOD)
-		return -EIO;
-
-	return 0;
-}
 
 u32 efx_mcdi_phy_get_caps(struct efx_nic *efx)
 {
@@ -97,12 +45,7 @@ int efx_mcdi_port_probe(struct efx_nic *efx)
 {
 	int rc;
 
-	/* Set up MDIO structure for PHY */
-	efx->mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_EMULATE_C22;
-	efx->mdio.mdio_read = efx_mcdi_mdio_read;
-	efx->mdio.mdio_write = efx_mcdi_mdio_write;
-
-	/* Fill out MDIO structure, loopback modes, and initial link state */
+	/* Fill out loopback modes and initial link state */
 	rc = efx_mcdi_phy_probe(efx);
 	if (rc != 0)
 		return rc;
diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index 76ea26722ca4..dae684194ac8 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -448,15 +448,6 @@ int efx_mcdi_phy_probe(struct efx_nic *efx)
 	efx->phy_data = phy_data;
 	efx->phy_type = phy_data->type;
 
-	efx->mdio_bus = phy_data->channel;
-	efx->mdio.prtad = phy_data->port;
-	efx->mdio.mmds = phy_data->mmd_mask & ~(1 << MC_CMD_MMD_CLAUSE22);
-	efx->mdio.mode_support = 0;
-	if (phy_data->mmd_mask & (1 << MC_CMD_MMD_CLAUSE22))
-		efx->mdio.mode_support |= MDIO_SUPPORTS_C22;
-	if (phy_data->mmd_mask & ~(1 << MC_CMD_MMD_CLAUSE22))
-		efx->mdio.mode_support |= MDIO_SUPPORTS_C45 | MDIO_EMULATE_C22;
-
 	caps = MCDI_DWORD(outbuf, GET_LINK_OUT_CAP);
 	if (caps & (1 << MC_CMD_PHY_CAP_AN_LBN))
 		mcdi_to_ethtool_linkset(phy_data->media, caps,
@@ -546,8 +537,6 @@ void efx_mcdi_phy_get_link_ksettings(struct efx_nic *efx, struct ethtool_link_ks
 	cmd->base.port = mcdi_to_ethtool_media(phy_cfg->media);
 	cmd->base.phy_address = phy_cfg->port;
 	cmd->base.autoneg = !!(efx->link_advertising[0] & ADVERTISED_Autoneg);
-	cmd->base.mdio_support = (efx->mdio.mode_support &
-			      (MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22));
 
 	mcdi_to_ethtool_linkset(phy_cfg->media, phy_cfg->supported_cap,
 				cmd->link_modes.supported);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 8b0689f749b5..6912661b5a3d 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -15,7 +15,7 @@
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
 #include <linux/timer.h>
-#include <linux/mdio.h>
+#include <linux/mii.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/device.h>
@@ -956,8 +956,6 @@ struct efx_mae;
  * @stats_buffer: DMA buffer for statistics
  * @phy_type: PHY type
  * @phy_data: PHY private data (including PHY-specific stats)
- * @mdio: PHY MDIO interface
- * @mdio_bus: PHY MDIO bus ID (only used by Siena)
  * @phy_mode: PHY operating mode. Serialised by @mac_lock.
  * @link_advertising: Autonegotiation advertising flags
  * @fec_config: Forward Error Correction configuration flags.  For bit positions
@@ -1132,8 +1130,6 @@ struct efx_nic {
 
 	unsigned int phy_type;
 	void *phy_data;
-	struct mdio_if_info mdio;
-	unsigned int mdio_bus;
 	enum efx_phy_mode phy_mode;
 
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(link_advertising);

