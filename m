Return-Path: <netdev+bounces-175342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC84A654DB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6251897685
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7F241690;
	Mon, 17 Mar 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZeZYGoK7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B923F39E
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223699; cv=fail; b=lOo790ORhaFF3fE54OqdEvEd1KYdN52dhAN0jKa/OTEdDyF43xpm/ptPgbje5oi7SJ+DSjtvFQqPTJI7XEte+rpB287A80FYnGBNulCxBZL8D3+cK661w+KpZUBSOlpm5mV3FBL8oSmK0R//VoPQOiGyIc0M+Bn3ytFGosczUxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223699; c=relaxed/simple;
	bh=tq5xibINP9Aac/MHgAMd3w5cL0lSmVUcWv7YCyxVi7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOe17Oat/zxb6CEe7eOxMR/QR7k5Wq4hFNFjNYxZCwOXEtl3Leq1OhQ8G8Pf3A4BZMBI9i9iarVAJNZDR1jP5gI+rWSlkHeXOjpMPTiYS9eKe0lVlhBqZY1KiKg2tuMTDsfbiuS/F55x9hoomdLK/fH3y1ozA6i1vTb62is74dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZeZYGoK7; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjLss9RhIIyw6t4PbPYThU5Fwb24HDzOyYkOwPt/Pp4+NBuPUz2e/mPhsw9hsALsFOct5BHuYpBiXPGhaTXWkxG7E0MyeFV0qQkB7MpMJCSmtBURYFJzh9t75ciqsvWRB3wgLkwy7ReY3W6JwOQwc83WSg5U4/LG3Y9ZHIjAjCpOSzKRQT0R40PcA2FqVvIjC/pjMElFTHGQL/S0tZXQheg/D8J6RS/ieoCseCd8RNH+TOmGGBeNyIY004COZtG0q0aeEPXcq37wuI2xFiMArxCAJ0BfPWhffpsKdNLXOXkAwY9qEOADgsmuMKeuX14myV6E7+JfFJz3C/fOxbzgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n55dyE0g6ok2B8x8PnZQbB1/PPiURlOAOxU6hCo1mHU=;
 b=p9b9Sq/FxrVg9fRDSxL25CKzE0Z/w9RFnp1TzmaHTx5XB5vUC4QG+8MeMfBrVqFNo8hkJfNKCPp62BAJDB2zF4pHWq3jVyejBwyDa+RmqGvhaWl9O+ACT9PDz8KkAtMWik91opMx2QTPjl7Re53PBS2isWAhAJXa8+RYXVPfeNduTDNNTRwV0Lwhkrs5hHkFph1VdhWEOtP0F0sNMuVgkuBxMqQQsCGgk58dwU7Bnc9PvpxT2Mt6jnbwuocIWseY8qdqSMtFEQxzDT08jciF9c7ejh8C2p1lIJHf3biAccVFE7LCfSKMjuVZIUNefMJuuIYNNqhJT2dkMzb84h4DKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n55dyE0g6ok2B8x8PnZQbB1/PPiURlOAOxU6hCo1mHU=;
 b=ZeZYGoK7t9sFrwc2r94HRIvDxX5OKVDjyl6iNJDWFawfxANgqHl3xnS2Z42Eb9FLDGqVxPcbLOy3mSKE7Y83LhcFKAALJj4rFxkDZKAx81ZjkFaBah2XGgWBX+8ht1VKjqDhQL8vd+Flk+gZX1omf5NhV/CtvN9+1HlhBb41qEA=
Received: from BN9PR03CA0355.namprd03.prod.outlook.com (2603:10b6:408:f6::30)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:01:29 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::69) by BN9PR03CA0355.outlook.office365.com
 (2603:10b6:408:f6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 15:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 15:01:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 10:01:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 10:01:28 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Mar 2025 10:01:27 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/3] sfc: rip out MDIO support
Date: Mon, 17 Mar 2025 15:00:05 +0000
Message-ID: <aa689d192ddaef7abe82709316c2be648a7bd66e.1742223233.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1742223233.git.ecree.xilinx@gmail.com>
References: <cover.1742223233.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 145ea7df-65bb-40e3-8ec5-08dd656498a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FCDzp+Mm/ghJokrJwg1xisJC+OkKiUFvDWz0KRUfUl3ijkcw2cmF8g03C5RO?=
 =?us-ascii?Q?6dZdFebznQ5x6uP4HBeYonfb370WXspJi1Z/UrCt/IWB1Bbn0xCiWIr1MBuZ?=
 =?us-ascii?Q?l3rRXmbltfQtVakjmhWXXOcrTJWA9ScFuANG6e3s8oRegdZg6TUU/vY/d6mD?=
 =?us-ascii?Q?IC0OewHk7oy/wiUbBIqTdoCv7k+MkmmspjjfT1tMsMa4JoAjTAnqZVsbQVF3?=
 =?us-ascii?Q?8xz0KxGBqD/GxAcBPwpVybWOQNk2Hyk5dTnOeukjldCEiklCUejicaiOe0Fe?=
 =?us-ascii?Q?1HP8bMNd+Li760eWghH/BqjVFbN69GSNazyX28eCvrmm9RWQDZYTAp/cTtwL?=
 =?us-ascii?Q?saJswfFGtaD/5XiKMog47x+DNGVjsET/KAXzYS1RUjQNIveA2Il4Yl2Y0/eq?=
 =?us-ascii?Q?QOXBjkoyyB82y+U4b477IBk0yIcmV2xGKvrW3o+fcuAx01qKzx/nxcbUZdqG?=
 =?us-ascii?Q?00AcZNVaoNXGhTW5t4fgmc8SC6s5WMnlztdyMK+pUxCsevbsKQRvtAlqw7rG?=
 =?us-ascii?Q?+gL6HfgcaB+S3MEuBvrX55K+wz0zYQoI2L5U6/4jmUwRLZZRq+/CJ71j+NDY?=
 =?us-ascii?Q?ZMd7mJRHnlXyjmHx49EeufUpf0R4SPvRH+MExIbU2Fpk7MMqmX5j1rdRmiF7?=
 =?us-ascii?Q?47GiXY8XBq3IxndMbFDxPYMCezL0sjnqZ4jlox2pnmPrjCnWkuzFKq1/PTb9?=
 =?us-ascii?Q?k5updQels9pKKsM5r4zKb92wUfjh3OyEXfS7ZdKADLqw93aF0IyetkGo4Wig?=
 =?us-ascii?Q?9j0+clLe4KV2iaZtFQ2ALS6+RTP0fnNheJrHF/WHK/lkZfEue1ftgxJeU92X?=
 =?us-ascii?Q?fj2vkqIlu2vUYANk6KXpX98aJctxwtOa1AOZnF4NtrjgLEhDYg0EUMUin3h9?=
 =?us-ascii?Q?vh2WMFuabeUpZNj1dNU0IF8x+IjS4RLyyifM4AcpP6BrX2b5Ltc8qfsPSUpQ?=
 =?us-ascii?Q?flDCBwDzM6/ks5IHHSj9Y/0B9gjf3BK5vzndAvERQpgKiXfNlNjsGlkZBqh3?=
 =?us-ascii?Q?3p3/FGoSAWU0/4tq+Pb/LeObK8SnE8qoc0PPq/XQfNRUyWHBciphVftgT5k5?=
 =?us-ascii?Q?n3bpltry/NmREf9YB6PLhe4h2/KMQSOt62kMUf8Os3rPoOGB4i8RplT3UCpg?=
 =?us-ascii?Q?WcEX0GQ5a0fSDjDjImaEqTvNErpJAL0tJWP+/g5H1G2PveVSJ8vx8KCa7X0r?=
 =?us-ascii?Q?+Vcsbd7plJW1zZRaRg8a1fVtXRwTXiCmni/Gvt0CCbAJ7YD4qIfnbOqaqfHu?=
 =?us-ascii?Q?Ru7IiW6quhmJDOcuIRPLpI00hBmmxRRY7MQHJZZcjSJFGhxafJRRPoyISC+N?=
 =?us-ascii?Q?j1EmHR7xG1aN7YfzXXp76buE4VAnDS9Ez512DiHbi6oIB9OmyUgZ6K9cN6UY?=
 =?us-ascii?Q?vqUth49GJnu4yUjHTwJtkzOBWP5a7ySDvcjpAlILMkj0lcRU2OT7REIGv+Zr?=
 =?us-ascii?Q?hRj4Bjb3Jg7iKySUwsRUgNamojE1kHOvcolACcE/VQhTkQmqgYtaxwsyX2XL?=
 =?us-ascii?Q?usjFhU/PRG1Sux8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:01:28.7869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ea7df-65bb-40e3-8ec5-08dd656498a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

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

