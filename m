Return-Path: <netdev+bounces-288470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBUDCbmVB2pU9AIAu9opvQ
	(envelope-from <netdev+bounces-288470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:52:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9565B558774
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DCE301753E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06AE3EDAD3;
	Fri, 15 May 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvd6i7wu"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A230F95C;
	Fri, 15 May 2026 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881973; cv=fail; b=AhmmlxjJED1zjnxV3903uB/cap4CgpK5+pQL3y4aHBnQZZ4bGleqrS4VS6UOwiDm9s8VnxPhiSUDrbd3LPaqMU33ARzBoYJBOi1AbC/ALtIItt3LnPMYe0lOtyyS12BzaqwARxshSElBHa71SybO9HZJM09UDGTIQ72tHip9hG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881973; c=relaxed/simple;
	bh=UOojlB8iK2Eb6MIqBwBodhFSGduXhBrr/7x4bJ1W54s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wlx5fpJ7moqsXP0pdAxqY+jMd+fmuAnys6bX1U20P83WAm7cA7KG+I9pLZ9fBfTm52B/OsqCbW3Z7v71jZANQQFDLY/phaXzkCsI0pGBlPGPiComLvJ7TH0/RWz3HvFfkgheF2YD22qBqqg5pHx8DHmgmg9+s8HeFDSkuxtcmIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvd6i7wu; arc=fail smtp.client-ip=52.101.53.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf7MLopo4YFk50GtRSmVc4/IlsT+FatBqvdhcjgghfu5qOkKGfRT/t1pdsfT3DyIXSpRTwxRARB6FG9+UpJH9roqbFNj1C8wpgwlLZoe1Aux61SyApGqSyKjVPL3DcuaDB8VhJaHNgkri8whEAdWaE3B/aQLmi9RryCf9l0fA97QZEOBUsKjDrbAg/hv1ypOI1NWWN5TpK4ampkwfcu9kBZ20aLZIUixyFlmUzkBs/Uypolsss1HCGBk05tmgsS7j69maTqa2LOxPh9zYEnf6yFVIgkUvf8qq8qEJnV78AEwgbEGDD+SQMNMavleiNvioN29UQU7Acye8OtSYs1iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfa40nVo5TurXFyv1nJ8VOPLVYxZzUQOAbrHeokSTQk=;
 b=h9+Y+wiz5+14AyWr/oYn4LXBDprJNHbrAXyLtaaApVF7m3UDYAROFCUImENCmX/3y1opxXjsczAMa1CLZlTUDpMI+b8wmCAtzVLrMZRGlaLBckaqz5VK5G0kjj+YafiNxQQZXJclr6PHn6zHm+lqOCgYcpoXd6winz4A2meyBJPO4DgQG7HFoCodgC7iHy7/odffRvhLuDbsOaRiYI1gqBmCMhpB8PA1695bCe/2PFTiSoB9GNuJa/prcx2k4WfgQQzX0W7HV3cZ0ZuaU3+BtLiSlzQfcyKTrn/nZI6xiqh9dDH0GTmrVRORbvcfKySsH1h8vUsJzZM4fCcaizIymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfa40nVo5TurXFyv1nJ8VOPLVYxZzUQOAbrHeokSTQk=;
 b=jvd6i7wut4lRVp9/0A3JvcjrTvWj828vuTaI9fbdDfVI5LN/Mx9MW3CT1FPx7+9n2rNW77nR7YSedPsQtG1ExMzqyat5/ee96i2QD2jW20MdrRXA6i7zC+Ujxl6W5UQ3wdGjFu7R9WvMsKE6gO3ff2d7vzTfFDANfGhH10/gheAyWY6baKPy3xzlayXt9tZDSE4UKh1udJvh5HhkISs7Q1YqpLF9F6LGk+mOqOE38/c3RcRQaoHUR+wOTA57HJ+4gYnl0za+GfHbLHY+lYTSozYvVNpzCSpnwBhz55ByJGvhisra2v/Eh2jOZFYCTbVlbJpuz+MHHxzW6/SSAlbItg==
Received: from DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 21:52:46 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::b2) by DM6PR02CA0114.outlook.office365.com
 (2603:10b6:5:1b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.20 via Frontend Transport; Fri, 15
 May 2026 21:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Fri, 15 May 2026 21:52:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 14:52:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 14:52:31 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 15
 May 2026 14:52:31 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net] net: lan743x: avoid netdev-based logging before netdev registration
Date: Fri, 15 May 2026 21:52:29 +0000
Message-ID: <20260515215229.3881949-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 702598f0-6a52-4100-d2eb-08deb2cc4c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	gKRQIEDWsRb1DBoKdeKjB7whYwuYejOITYgRyI2cyy1ZeRzifh76kTnXjNyBnc5rLJUvU92afr6ToPKGxlUoMXY4Kpw3OIUr5vWVAByRungErm2oNSMn9rKZOhEHWLWjxK2s5zKRTUaxR4w4fPRQX6oiG+qnVOlW2TT36R/aXsO1xbvtBrwtmjwhnyeHevpQZmQSzHiUwLm+W6CICEMjnG7iDnC7F0RdVI1pWnffjc6a23D3pxOzus4VgaCrLxK+49+dMv/UCC7339AJ3itCA+nKudW8gM7DG5yvlc+7945HzLOSM9O6EElOuH5yU/00ckzOhgTiV5/V7pE8kDyK+rRoFc9iimjhvHSuqgZTz1sHZYimxVopnELnaJ/gpnrIFRU1Yir0V0DWcu3epnY1beUoMOtHUHDj7u29u/SCRVcK4Ula4HI6Fofru0vomxiD1ze2bR8WuiDSfRiaQUZTBe8QrOKMTdDvSSP8ASR+0hSorgF35WuyQ56ODxFN6KtWGlcbYPhlbTJbSnr3LGdWGLY9P3bVaR3BU9QHfFYqC4BYrEjeyT+1aOv2BQyrG//3JhfTuMlvSKI9aqOiVoEgjNNodaiUs+Rqx4t0MAIGTEbYzYwebsQVJmkf9kXEQiJHy2b9FaNf/0rtraZ8SZVQ5KkKS7xZgf141gxUAv88xGv7hFyQAzI73wlnwHeGNK0X3Is4Vvgg3/RgfqReILFV4yyolzE3bAVWr028chmc/0s=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uqGxqNQ7FGTpV35fffkj2fgQz4WUZ2Zaf1oMACq/eSw8ftckluwR3ENUDCfsSnNRveHt9bH+uFQNooLngm99PeT+yTUJ8UE5A/e2T3Fyw+7JU9ZlbbtD/EWXxpakDxpES9St6rTZBPw0DO2t5yt2g5OR447Xi8W0ggiIRnVCM/v356o2QwA4eHQslx91E2noR9vgsXYxmrNOXreN7k9kpZeLHK9Dznc8V1W89WNUOFg3Edgyjfd5mDM/31/QN+WwOFv71k3yMOLs0x4K2bul8cCtYq/25Sgzh432MXc9/A6rR9m2Uawl2oibCqo6/5c37iDg0qhmlDnQG8XCndigIVQC60m14NcsU6AVMyuTe7M0gKRnW8/Awt31+u5DJyl7l2B3f3/+ubdlfD0UgfueGGFxN/S/yzJQlx7a4SGxOjqz0rzc1vG6+qvChtfKlxwc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 21:52:45.6860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702598f0-6a52-4100-d2eb-08deb2cc4c6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
X-Rspamd-Queue-Id: 9565B558774
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288470-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

This patch updates the lan743x driver to prevent the use of netdev-based
logging APIs (such as netdev_dbg) before the network device has been
successfully registered. Using netdev-based logging prior to registration
results in log messages referencing "(unnamed net_device) (uninitialized)",
which can be confusing and less informative.

The driver must use netif_msg_x APIs and device-based logging (e.g. dev_dbg)
until netdev registration is complete. This ensures log entries are
associated with the correct device context and improves log clarity. After
registration, netdev-based logging APIs can be used safely.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 72 ++++++++++++-------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..53492573f08d 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -108,9 +108,10 @@ static int lan743x_pci_init(struct lan743x_adapter *adapter,
 	if (ret)
 		goto return_error;
 
-	netif_info(adapter, probe, adapter->netdev,
-		   "PCI: Vendor ID = 0x%04X, Device ID = 0x%04X\n",
-		   pdev->vendor, pdev->device);
+	if (netif_msg_probe(adapter))
+		pci_info(pdev,
+			 "PCI: Vendor ID = 0x%04X, Device ID = 0x%04X\n",
+			 pdev->vendor, pdev->device);
 	bars = pci_select_bars(pdev, IORESOURCE_MEM);
 	if (!test_bit(0, &bars))
 		goto disable_device;
@@ -192,10 +193,11 @@ static int lan743x_csr_init(struct lan743x_adapter *adapter)
 
 	csr->id_rev = lan743x_csr_read(adapter, ID_REV);
 	csr->fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
-	netif_info(adapter, probe, adapter->netdev,
-		   "ID_REV = 0x%08X, FPGA_REV = %d.%d\n",
-		   csr->id_rev,	FPGA_REV_GET_MAJOR_(csr->fpga_rev),
-		   FPGA_REV_GET_MINOR_(csr->fpga_rev));
+	if (netif_msg_probe(adapter))
+		dev_info(&adapter->pdev->dev,
+			 "ID_REV = 0x%08X, FPGA_REV = %d.%d\n",
+			 csr->id_rev, FPGA_REV_GET_MAJOR_(csr->fpga_rev),
+			 FPGA_REV_GET_MINOR_(csr->fpga_rev));
 	if (!ID_REV_IS_VALID_CHIP_ID_(csr->id_rev))
 		return -ENODEV;
 
@@ -953,8 +955,9 @@ int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr)
 	u32 val;
 
 	if (mmd > 31) {
-		netif_err(adapter, probe, adapter->netdev,
-			  "%s mmd should <= 31\n", __func__);
+		if (netif_msg_probe(adapter))
+			dev_err(&adapter->pdev->dev,
+				"%s mmd should <= 31\n", __func__);
 		return -EINVAL;
 	}
 
@@ -983,8 +986,9 @@ static int lan743x_sgmii_write(struct lan743x_adapter *adapter,
 	int ret;
 
 	if (mmd > 31) {
-		netif_err(adapter, probe, adapter->netdev,
-			  "%s mmd should <= 31\n", __func__);
+		if (netif_msg_probe(adapter))
+			dev_err(&adapter->pdev->dev,
+				"%s mmd should <= 31\n", __func__);
 		return -EINVAL;
 	}
 	mutex_lock(&adapter->sgmii_rw_lock);
@@ -1215,8 +1219,14 @@ static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
 	lan743x_csr_write(adapter, MAC_RX_ADDRH, addr_hi);
 
 	ether_addr_copy(adapter->mac_address, addr);
-	netif_info(adapter, drv, adapter->netdev,
-		   "MAC address set to %pM\n", addr);
+	if (netif_msg_drv(adapter)) {
+		if (adapter->netdev->reg_state == NETREG_REGISTERED)
+			netdev_info(adapter->netdev,
+				    "MAC address set to %pM\n", addr);
+		else
+			dev_info(&adapter->pdev->dev,
+				 "MAC address set to %pM\n", addr);
+	}
 }
 
 static int lan743x_mac_init(struct lan743x_adapter *adapter)
@@ -1370,8 +1380,9 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 	else
 		adapter->phy_interface = PHY_INTERFACE_MODE_RGMII;
 
-	netif_dbg(adapter, drv, adapter->netdev,
-		  "selected phy interface: 0x%X\n", adapter->phy_interface);
+	if (netif_msg_drv(adapter))
+		dev_dbg(&adapter->pdev->dev,
+			"selected phy interface: 0x%X\n", adapter->phy_interface);
 }
 
 static void lan743x_rfe_open(struct lan743x_adapter *adapter)
@@ -3168,7 +3179,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	}
 
 	adapter->phylink = pl;
-	netdev_dbg(netdev, "lan743x phylink created");
+	dev_dbg(&adapter->pdev->dev, "lan743x phylink created");
 
 	return 0;
 }
@@ -3581,30 +3592,36 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	adapter->mdiobus->priv = (void *)adapter;
 	if (adapter->is_pci11x1x) {
 		if (adapter->is_sgmii_en) {
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "SGMII operation\n");
+			if (netif_msg_drv(adapter))
+				dev_dbg(&adapter->pdev->dev,
+					"SGMII operation\n");
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
 			adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
 			adapter->mdiobus->name = "lan743x-mdiobus-c45";
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "lan743x-mdiobus-c45\n");
+			if (netif_msg_drv(adapter))
+				dev_dbg(&adapter->pdev->dev,
+					"lan743x-mdiobus-c45\n");
 		} else {
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "RGMII operation\n");
+			if (netif_msg_drv(adapter))
+				dev_dbg(&adapter->pdev->dev,
+					"RGMII operation\n");
 			// Only C22 support when RGMII I/F
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->name = "lan743x-mdiobus";
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "lan743x-mdiobus\n");
+			if (netif_msg_drv(adapter))
+				dev_dbg(&adapter->pdev->dev,
+					"lan743x-mdiobus\n");
 		}
 	} else {
 		adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 		adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 		adapter->mdiobus->name = "lan743x-mdiobus";
-		netif_dbg(adapter, drv, adapter->netdev, "lan743x-mdiobus\n");
+		if (netif_msg_drv(adapter))
+			dev_dbg(&adapter->pdev->dev,
+				"lan743x-mdiobus\n");
 	}
 
 	snprintf(adapter->mdiobus->id, MII_BUS_ID_SIZE,
@@ -3696,8 +3713,9 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 
 	ret = lan743x_phylink_create(adapter);
 	if (ret < 0) {
-		netif_err(adapter, probe, netdev,
-			  "failed to setup phylink (%d)\n", ret);
+		if (netif_msg_probe(adapter))
+			dev_err(&pdev->dev,
+				"failed to setup phylink (%d)\n", ret);
 		goto cleanup_mdiobus;
 	}
 
-- 
2.43.0


