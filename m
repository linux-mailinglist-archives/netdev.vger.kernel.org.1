Return-Path: <netdev+bounces-292770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLusGwR0GGq4kAgAu9opvQ
	(envelope-from <netdev+bounces-292770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:57:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D345F54DE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D635630976E0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959B3F7ABE;
	Thu, 28 May 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ex4l6B7X"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0522F7EF5;
	Thu, 28 May 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987048; cv=fail; b=CQfoF+M8hf0Ve18LLrpCz+h6wVdVeCDst4NnEZBclRUBta9LzHZhQhhXXMx/nz3tp0lF+BfMT93iPd/ciNb2CCP7Hzsjg+TbKhjC8LrdlMh8jdqdlYSgIE29SoCyl5VYF1BgBldHObCSHTpUt4YW1PsffOga5Tq0OLCpEFYWSg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987048; c=relaxed/simple;
	bh=fxBZ/4PwuPsjY7lYf91W8pVmqS0bUI/9cS+L2Bn6omo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pOPLrABO3O3xKnE9b4zKQoyz0CcYFqiQk8zKQK0HRRSCdtc7k7nTsAmIGeYvh+lLWlHl9LiP9PMpztvVkweXhp5lCauHaUYsDbs3CSg8g+3nFgPOdjgdgCEFzrdKxp2qq4SP/jcClsAumnmiBn8DvVQekudH/gftar8caTEdIw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ex4l6B7X; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLORvNMhNai3G5iF0M92ubuDfYEC/Y5xpYJwmIyDwonbcrE5a/avihu3AKaS2lxmFRVGU4lV0AeKErpVTkJb6h5g4np1zcvy0zz34hoiE0xbCFsE6cyCiofzIbTN24SE1Ow+iydNmQlb0QWI2VP0bmfM3RBVhAhjArCfIEIjtPH8RbE/JtaXFZg5igJ4S08XAYxF5OTQAoGoO/3Y+98SxVKBNdY1COGbSbHYEUn+NcEdarGlDyVKmw0GSrE5x8avqrrzhbLukhMqot4IAW0UrNgRZHavVdHEKwcfiKZxNN1vIucYwJooWBNP1Hnk4xAgCzCZN60XbRt9AEGOj61hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do4pty/P++vvVmc38QOupx+B0kJjxmyUjKo4HH/GUfQ=;
 b=RFbAFAY4Dhgyw/JleCJrKah6+jPN/gnDwdCd/iVHlstBlXYmLQHLNdvHK6mhCasGAM8nMIvZnGTNihDhuSzGyiJSfbsyrPegEOugasuYMQWeUYTNOXBhM2OMkopfukVAb9uXEWAkzbKpj/XUucxRW8IB+cluxIPqatPx1rR6kW0JvJu50x+1w1UnC2K126+RHupqgQdKak+gGp8kijt6rajP91GMHzZRgPcZln68B13ihxmvv5BHfb3Bax43SpO3HowZBjUW8pE3C9A52BTa4T38dJ1fS/f3Tj31iqlR9vgSVysngdf5AdFVWGMfjA/wLVQVtGXAuRCBMN7OUjdYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do4pty/P++vvVmc38QOupx+B0kJjxmyUjKo4HH/GUfQ=;
 b=ex4l6B7XiaS1IO+Yvc+DQ9v/zzcQle8nGqLixX5gjCtdYuR8Biul907fC3s1XPG8kl4DVihPLL73QB9KFJpl53rM03WgI67orC17pw2Y1QeOk4k6y+bRW/0R2lZ3GkwBYLafAQuxhUnS5by+JoznI9pojxtpFvB2QuXsgbu4PGQCZe/WeVj2wu/0j8ckfzrvb67K7P2gputzOfY+JLPTfXztvYbx14px8ajAyHhq+CM5iO9npTnpdwMooesgG+l7qgUoALTKUrH+jwNV1cy7cCgj8Vh+FAxKvrVpb1V2BK9xQYNOhSuqGmHoJuzNAOfy1dxzibcvptYpFepj1IXIRg==
Received: from CH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:610:32::30)
 by CY3PR12MB9653.namprd12.prod.outlook.com (2603:10b6:930:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 16:50:41 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::4f) by CH0PR07CA0025.outlook.office365.com
 (2603:10b6:610:32::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 16:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Thu, 28 May 2026 16:50:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 09:50:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 09:50:19 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 28
 May 2026 09:50:19 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net-next v3] net: lan743x: avoid netdev-based logging before netdev registration
Date: Thu, 28 May 2026 16:50:17 +0000
Message-ID: <20260528165017.421576-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CY3PR12MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 6047b664-61a1-4c40-acb6-08debcd93f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	F3yVe46PgCl2ith62ZNqgp32lI8DM58ezZeMJvqIFbZOK8fM+7ptwW7PeWk260GXPyXQwGN8DUZzgYhOboL1o66uICvkNLLrmj1nQo1E0WbXrK9KJTYR131Gl8VJM3NxI3/Mjeicuap5vN2zts71LaLNriOF7f4uYNyWFE7dHLm3jfOA5V/c9ZBYt069jvngENGQrMZaOGGkI0Xgxj8aczU8V2qXmv9bi7mOEDNajVbp7yMxogGaQ4IAPC+0EjZYaMHDxafqyJehoMhoZfH3W7VOmAtwajJgNAl8m3tzXscd160/lSu4FbJIGo+Nr0p5rfav+/AOlEwolQgIswFF9z0tOc0H7dVrp0zlVrwXzp+d3zHFLUsqiv2VJJ11MEo5iKqhN43IfrhPJBYtD8ELwatyciIXD4HqBYorTdbF6RW71WGDjKjWE+QZbtIxU2hehQ+BF+ysnIMSfz9FwhcK41g/L2mUPe7JGNvy7OAUVzLPqmpCj3Sx5CvnLdQ+8YbNkE2ud2i/pNP0o3C/OkQbCendt1xYELxadwDw5k9E/XtzJDdsan3AJRi8v2wiKw6O/oXf8lNAXENdaj5HkZnYbyj0BC+y/GWu4RYd0Mpx9BHVDIqJulc7E8IJF/bMMaxQtOnU0u1yRC8UFMMLE1vKYrQKoWDGQLTX/poVwFuU7MvR11K6DTIFZ9rJpfiRlPfMpiVXVQEIpxlLBRzVoD6o4OZUAYpJ9c63i4FzT1DilO8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(11063799006)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SvB0QbBo+aHhOVWo3yruFTs37DICdhmM8Vjt/iJMhr+OmCmduU5trhPVZoBkWWoaPXnBhu6yaed7nXSho9i4UDUv8Y1bjAIMe7mFebldDb4Xfl3RoE6wNMV7PEq35zIOVqfDKXvSbfuFGUjMvyVSmkKfgfrGrnQLD+73cvDvM4iy2fWZD4lOaayUe5nJr4f70pcqEcPBUEB6+r300tneMzBcfprzSlR+fd/8mvPRwmW8GJBpOxYZbV6suAlVIp4P69XiBWLogcQmPgvpdsOztI0i5TJhRZpXVh3O9fplE7qg29gj3bX/Ur7fZjlIV3/NrieKJyb78NARN73SUWxb3hTHsoQDifAwQUDHBbwSKQcTlsJachJ8hxMjzZyn8GMRlGW19dEsPkumn/i2f7CwV/Y2ISzKL9xurSRQ1BWWFV3A0Koz6yHYiIPdYMO4leBn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 16:50:38.6029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6047b664-61a1-4c40-acb6-08debcd93f36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9653
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
	TAGGED_FROM(0.00)[bounces-292770-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D9D345F54DE
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
v3:
- Converted netif_msg_XXX checks and info-level messaging to
  simply use dev_dbg(), error paths still use dev_err()
v2:
- Changed target repo from "net" to "net-next"
- Removed "Fixes" tag
---
 drivers/net/ethernet/microchip/lan743x_main.c | 48 ++++++++-----------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..d40c277af112 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -108,9 +108,9 @@ static int lan743x_pci_init(struct lan743x_adapter *adapter,
 	if (ret)
 		goto return_error;
 
-	netif_info(adapter, probe, adapter->netdev,
-		   "PCI: Vendor ID = 0x%04X, Device ID = 0x%04X\n",
-		   pdev->vendor, pdev->device);
+	dev_dbg(&adapter->pdev->dev,
+		"PCI: Vendor ID = 0x%04X, Device ID = 0x%04X\n",
+		pdev->vendor, pdev->device);
 	bars = pci_select_bars(pdev, IORESOURCE_MEM);
 	if (!test_bit(0, &bars))
 		goto disable_device;
@@ -192,10 +192,10 @@ static int lan743x_csr_init(struct lan743x_adapter *adapter)
 
 	csr->id_rev = lan743x_csr_read(adapter, ID_REV);
 	csr->fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
-	netif_info(adapter, probe, adapter->netdev,
-		   "ID_REV = 0x%08X, FPGA_REV = %d.%d\n",
-		   csr->id_rev,	FPGA_REV_GET_MAJOR_(csr->fpga_rev),
-		   FPGA_REV_GET_MINOR_(csr->fpga_rev));
+	dev_dbg(&adapter->pdev->dev,
+		"ID_REV = 0x%08X, FPGA_REV = %d.%d\n",
+		csr->id_rev, FPGA_REV_GET_MAJOR_(csr->fpga_rev),
+		FPGA_REV_GET_MINOR_(csr->fpga_rev));
 	if (!ID_REV_IS_VALID_CHIP_ID_(csr->id_rev))
 		return -ENODEV;
 
@@ -953,8 +953,8 @@ int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr)
 	u32 val;
 
 	if (mmd > 31) {
-		netif_err(adapter, probe, adapter->netdev,
-			  "%s mmd should <= 31\n", __func__);
+		dev_err(&adapter->pdev->dev,
+			"%s mmd should <= 31\n", __func__);
 		return -EINVAL;
 	}
 
@@ -983,8 +983,8 @@ static int lan743x_sgmii_write(struct lan743x_adapter *adapter,
 	int ret;
 
 	if (mmd > 31) {
-		netif_err(adapter, probe, adapter->netdev,
-			  "%s mmd should <= 31\n", __func__);
+		dev_err(&adapter->pdev->dev,
+			"%s mmd should <= 31\n", __func__);
 		return -EINVAL;
 	}
 	mutex_lock(&adapter->sgmii_rw_lock);
@@ -1215,8 +1215,7 @@ static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
 	lan743x_csr_write(adapter, MAC_RX_ADDRH, addr_hi);
 
 	ether_addr_copy(adapter->mac_address, addr);
-	netif_info(adapter, drv, adapter->netdev,
-		   "MAC address set to %pM\n", addr);
+	dev_dbg(&adapter->pdev->dev, "MAC address set to %pM\n", addr);
 }
 
 static int lan743x_mac_init(struct lan743x_adapter *adapter)
@@ -1370,8 +1369,8 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 	else
 		adapter->phy_interface = PHY_INTERFACE_MODE_RGMII;
 
-	netif_dbg(adapter, drv, adapter->netdev,
-		  "selected phy interface: 0x%X\n", adapter->phy_interface);
+	dev_dbg(&adapter->pdev->dev,
+		"selected phy interface: 0x%X\n", adapter->phy_interface);
 }
 
 static void lan743x_rfe_open(struct lan743x_adapter *adapter)
@@ -3168,7 +3167,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	}
 
 	adapter->phylink = pl;
-	netdev_dbg(netdev, "lan743x phylink created");
+	dev_dbg(&adapter->pdev->dev, "lan743x phylink created");
 
 	return 0;
 }
@@ -3581,30 +3580,26 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	adapter->mdiobus->priv = (void *)adapter;
 	if (adapter->is_pci11x1x) {
 		if (adapter->is_sgmii_en) {
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "SGMII operation\n");
+			dev_dbg(&adapter->pdev->dev, "SGMII operation\n");
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
 			adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
 			adapter->mdiobus->name = "lan743x-mdiobus-c45";
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "lan743x-mdiobus-c45\n");
+			dev_dbg(&adapter->pdev->dev, "lan743x-mdiobus-c45\n");
 		} else {
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "RGMII operation\n");
+			dev_dbg(&adapter->pdev->dev, "RGMII operation\n");
 			// Only C22 support when RGMII I/F
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->name = "lan743x-mdiobus";
-			netif_dbg(adapter, drv, adapter->netdev,
-				  "lan743x-mdiobus\n");
+			dev_dbg(&adapter->pdev->dev, "lan743x-mdiobus\n");
 		}
 	} else {
 		adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 		adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 		adapter->mdiobus->name = "lan743x-mdiobus";
-		netif_dbg(adapter, drv, adapter->netdev, "lan743x-mdiobus\n");
+		dev_dbg(&adapter->pdev->dev, "lan743x-mdiobus\n");
 	}
 
 	snprintf(adapter->mdiobus->id, MII_BUS_ID_SIZE,
@@ -3696,8 +3691,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 
 	ret = lan743x_phylink_create(adapter);
 	if (ret < 0) {
-		netif_err(adapter, probe, netdev,
-			  "failed to setup phylink (%d)\n", ret);
+		dev_err(&pdev->dev, "failed to setup phylink (%d)\n", ret);
 		goto cleanup_mdiobus;
 	}
 
-- 
2.43.0


