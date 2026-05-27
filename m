Return-Path: <netdev+bounces-292424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKX/CSA3F2ra9QcAu9opvQ
	(envelope-from <netdev+bounces-292424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D45E8F34
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2E130A9308
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AFF46AF3E;
	Wed, 27 May 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MoE9R8Dm"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538346AF2D;
	Wed, 27 May 2026 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905981; cv=fail; b=n7eM6d29Mg4hRtGqaeIX8oG7j+wqmJg7AXkaoKULW7z6nCNGsAn+o9ajBr7Dead2BDTOGcrp+Y4L8dyvIo1C9rSawrE4EN/0FE8otCJx5IRPyJ33praAwUiQHUjHPHXJEiLSsXEThLwrFJ6g9u+qWfUdGSLM+fi2fn6etNwwn9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905981; c=relaxed/simple;
	bh=z8HlvWXiql2aZz6+i1Y/hTOXHxHJDtEO21vwcPOej+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPURH4+/oQRk+I7PeKPDpDCp5RyZSDAQipafobzxDh+InS18ocChL1LE1isTcpiJaeCaxDAjtS5vqGh91ilEO4OxZNx0DKAmA2ONWz8VLxacRlLrW2zNpfIpOKGOet42jyQsaxlkD6Afaccb+6Qi/f0HYL8Hs9g1LGgnVXc1K4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MoE9R8Dm; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4QRvW07Z9alPT54kqZAFMUb95n6KOHmjdPK3bz7weoU7uiRTpQk+eQ6oqiAtyMjmKML2Vlbw5gtunQUuAyr9oMA5X/wNan42hzIUmTxr9Km8GUy8RbDCEE8lXm5Ky4IIy9ZpzArjbBvOHXJ7lQ03zEEN9nF/uenYUkKqlu21NpBwWGRK3RggKtX8gs7Dg5WDw8k5zYnPAPJcCkMKlZgoFDYMpOoW/ms2AkW/o5qxR+xwdy0IS+rOmq0jDwNfQRldMweS+IyO7VK3kW/JHDAYLqzqH1yVnTeOw8lD3rarCJQmz+OLTj7LtMgF/GvCeNWCkK0po0zAukpRnk1QkXygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj19Fcws16X5HU7Husnn1UIRXTtiGFwNvBb1WU97I3A=;
 b=l+JybX3d0LPtSY9MZF0WayAnwpSwqSW7H6ugWPx9g/3evN3IyPC114o1VgpQz9f3zH3kiSLbAIezKElB7YprpnwkKyBsfCQ9pym2bMhoB84g+XjQEEpqWxLNRKguQvjWfRKvy5Ijxdl8kRPtyU+AiY5y5oPrzoC3jl0oJnHDlKHLbvplTZXyZXOgNOL7qvQxpNlH4H74nI6PTVkvH6jURDPNyefSP7go5Eo1pCTEZb500mQh+H2wKVFrrCHrYia0Wpyr52Cg5rSbTtfVMgrJ9I9UPlT0LHLzvZW18gI8Cu2tGdFXqGmJcOCw4ZR5xOES3Fmu1bbx6nx/aw7887lawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj19Fcws16X5HU7Husnn1UIRXTtiGFwNvBb1WU97I3A=;
 b=MoE9R8DmxP3iKU/wESW/uXM4LGsV4sqetHq9h8iKdUUTGLBjulRZPrjM10tetCROSsv4HR2z8DongUGw6d6PTauvVZ+WtlSj/lv+VYqnB3HbKKNwBjt2rdvDafWdBmGDQdc2OnqnBa5CNSf9wi6ooXBmKA8uhnWezDpr3snAkal8QQ7Zm0fX4vvUOI38xJGwt/rYQTPdEHCtA9d1ctjW/gSCpdt9HKwOw7QE69gwk/bzv6TfpuesAadEbB1sypdeA2d/nLr/njScrQqr1Y8pykphMYO2+XhVvmycVjMgbnNDBqgUyAYqQA016JmJKfIupYDurg7iGfJ3qkHgvFMAdw==
Received: from DS1PR05CA0009.namprd05.prod.outlook.com (2603:10b6:8:457::6) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.18; Wed, 27 May 2026 18:19:31 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:8:457:cafe::78) by DS1PR05CA0009.outlook.office365.com
 (2603:10b6:8:457::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Wed, 27
 May 2026 18:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 18:19:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 11:19:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 11:19:09 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 27
 May 2026 11:19:09 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net-next v2 2/2] net: lan743x: avoid netdev-based logging before netdev registration
Date: Wed, 27 May 2026 18:18:58 +0000
Message-ID: <8909217245395f6418cdc2699147511c443085e4.1779903597.git.davthompson@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779903597.git.davthompson@nvidia.com>
References: <cover.1779903597.git.davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c096982-c542-4ec0-80ed-08debc1c7ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bysj4sRpdXXf+/yQc66PiAA6yv5muJbyY016z+uM2AduPVBZnw9YI92TpgQ1/byWTw3xJfRGU6ZO//t5r8YtjyIfjYQb6iOOWen6QqiRs7c5uPBALgNA4Dyuukmrbf4ar07YqIDo2orQ/6LpZMBjWCSUoo1PCCWbe52vwW/97bTR2ygOokf4kIwhl4nQD+hL3aRfqlDa5PP5F3LPop70KZPFmuJ4BHDHqWBARltHyM81yEhdBvGRkOqRVew+3BTbOlmIapHSWCfG1WH1L79PSaQYmv7/gDgNBcCUP/VzO6ZJL172Q+CDL8mBotKzdgDjClv5miyudHb+ygmZ94Pk7YJi8xMGe+6QY7ySog4KE9y2f/JBhFH/yGUS3tITmYzljXLwSBwAYwGgmB8JP3778qcd/r3RgQUAXBEyEOUReQKMeoPKTpbB+MyKALt9m/4JjTN+G5NnY1YfNAIEIL8cTxXTJ8dJjqQudwnM1wAj3UH2heL2ni/ynknPy/VJnm/BHX3SjJOYQ6WijoMuIJ7M9xoi7HI/HmDvm0YXM+nd7lZFNl4iG0Gh8HrPr9IDVYw0Muo638u8OdAVUuMYT6RigFzeMB2SWRnH+pNtoBck0AKrIKfNPXhx0RK9DpCdBufzFJyL3/r/ppNzm1dZIMqpka1sN6NbWxAJgVS82SRL8F2ukqGWtVjDPNcQpkb/RImfJImhEXwtM5TldPvSLtlbJ+i8BakigJkgnD4pS5nSGtA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kmdtQx4QS6S2zsoBPw5FTuVNmBrwhgZYaH8S1UKxCNj97a3C55H2f0E4VZ4il+YQXyoIwOydXK7wnqhKlHXqImJQD6z1nHAzzjGu0fcHIwSNxGE9N7FseMGV8gM2ok+SO+LwnqZ3qoA3XQSO8Yw3cyJfmGlqhSBnPb1Tegv/kArgeIm3sYJTc2/oltRc5dq69LLsTYJIGa3Ohoy+I9HEZRcbLqd7sC09uF47maKESSApsV44fHLRpqOoNZwjUMmZ429QkI1ZRUre6PPTiwKRHKH/ZIlMkSy0Pfi04sFyN07o+vkb8WTU/mrTP398JsHa9wBE+xh4cON6R52Pj6GXUO1mjJc1Sgl7TaKL3Bgx4KpEj725GCiOQVMB2aocBczgzBULthFPMfS+mo2kFEN4YI0kMa1MuRkVY6/ZrtF9uBRCQKnmGl4agfscLwfjeyiB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 18:19:30.6162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c096982-c542-4ec0-80ed-08debc1c7ee9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292424-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 829D45E8F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch updates the lan743x driver to prevent the use of netdev-based
logging APIs (such as netdev_dbg) before the network device has been
successfully registered. Using netdev-based logging prior to registration
results in log messages referencing "(unnamed net_device) (uninitialized)",
which can be confusing and less informative.

The driver must use netif_msg_ APIs and device-based logging (e.g. dev_dbg)
until netdev registration is complete. This ensures log entries are
associated with the correct device context and improves log clarity. After
registration, netdev-based logging APIs can be used safely.

Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v2:
- Changed target repo from "net" to "net-next"
- Removed "Fixes" tag
---
 drivers/net/ethernet/microchip/lan743x_main.c | 72 ++++++++++++-------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 793633cced19..bca2f3d1ad41 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -119,9 +119,10 @@ static int lan743x_pci_init(struct lan743x_adapter *adapter,
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
@@ -203,10 +204,11 @@ static int lan743x_csr_init(struct lan743x_adapter *adapter)
 
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
 
@@ -964,8 +966,9 @@ int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr)
 	u32 val;
 
 	if (mmd > 31) {
-		netif_err(adapter, probe, adapter->netdev,
-			  "%s mmd should <= 31\n", __func__);
+		if (netif_msg_probe(adapter))
+			dev_err(&adapter->pdev->dev,
+				"%s mmd should <= 31\n", __func__);
 		return -EINVAL;
 	}
 
@@ -994,8 +997,9 @@ static int lan743x_sgmii_write(struct lan743x_adapter *adapter,
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
@@ -1226,8 +1230,14 @@ static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
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
@@ -1381,8 +1391,9 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 	else
 		adapter->phy_interface = PHY_INTERFACE_MODE_RGMII;
 
-	netif_dbg(adapter, drv, adapter->netdev,
-		  "selected phy interface: 0x%X\n", adapter->phy_interface);
+	if (netif_msg_drv(adapter))
+		dev_dbg(&adapter->pdev->dev,
+			"selected phy interface: 0x%X\n", adapter->phy_interface);
 }
 
 static void lan743x_rfe_open(struct lan743x_adapter *adapter)
@@ -3179,7 +3190,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	}
 
 	adapter->phylink = pl;
-	netdev_dbg(netdev, "lan743x phylink created");
+	dev_dbg(&adapter->pdev->dev, "lan743x phylink created");
 
 	return 0;
 }
@@ -3592,30 +3603,36 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
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
@@ -3705,8 +3722,9 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 
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


