Return-Path: <netdev+bounces-265254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IMMDbBBrWnv0AEAu9opvQ
	(envelope-from <netdev+bounces-265254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB022F320
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 030183034649
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7108361647;
	Sun,  8 Mar 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2FKJutky"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DB186E58;
	Sun,  8 Mar 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772962175; cv=fail; b=CWmXITFzi0sMdgt9/3Q+DXh2NW9fSz5lwhTmYmSEu9WRdwIrL/B3Ufdp2UOvX0ue74JU+ZLl/RCCpZUsC7B03V1bnbD+x8dhAZ8mUcreDP/2sbzPDYs6XmIssRWwUVwwbz7okJoqS8k2XkM2bKMKdpGwnjyDWu6KKFrJMI62T0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772962175; c=relaxed/simple;
	bh=qayjMXvE8takw+eh+IN8NuZpLAns0VMe+8v178bAJhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIKbTp1Rla2NN2zIFTSP0I2zBJpbWGnocxiNpD/obU7wXBdjxl8pPwyl5yQU6fvkmQ/2xBRzhnLuYBls0n5IGnrH4xxWfvdNNxDoWfPlB0XB7dSsbT+6WZnRzWlIRq+I/hEmT5Sf+A3Nf2ME5ekWyn3+DoRG37wDwcEGn7RzwZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2FKJutky; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcd7JUDC8GyDYcF/0hkRcfkBDjJ4tVI3IUQVwyv2C84AQuiRO0WpT3C0eHgF55JVgc8CtuCZMtCip1bELbqEkCAtSN/C1hqPalHyD5dxUmQSxRTClboOi3/GpwlDvfc30xNmBoY+MoOaM0Hpk1OATYqnfFG9lbVtI/+hENTb6IFtjBcU1oD2Lm4pHqW1W83YyNCdK8iMmDIZxrPL2AIw6RPsndFeWDO+mHg3ecf2FHx8cy5ABEjCFzS9+t8gxUm7kGWWTL/7Ukzzz0ohYQJ4omttT1L0kAKozBaeyCqv1/y4gg8HilwlvIO0eQFEFoRp1FkJpp3O9YE6YcrUvl5I/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1WIWGnJIXRxLg75wGiu0BuqYE8gB0xfR09nLxvGB7g=;
 b=MdrWLiflymNKvPTAm6M3nS07E7AeapGJY8HO0uux0ClUauuF8TSSRMJb93/0KjThahyMr+Ggn7CdUXDKfeV8vgdZKRPUnNwfAo2wPMlLgHG8LGmmkf0teEbXU7l/cB+7iD6TqwEnifDJJoNA3xY+oYR1EOlHBbXLkaTBQoEysATbxFDLnYI4n0SCElHaje1ELNnTtuEzNtdxFnLOGKVFTN7ir4kxaInC8rhAg2EeieRzSu1dZDaXGHWhqVc8Cd8BMvpIl55YEXeOKyDHEclHZny7+MrUJhT7jIBtl2cw/Vp6tRUfrcYPQQTsuKvYWIO3qx/b0nng9TI82Eeb/8BObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1WIWGnJIXRxLg75wGiu0BuqYE8gB0xfR09nLxvGB7g=;
 b=2FKJutky97pfXK/erf4orRZeJo8rey13qu6GdcwIWXEw3NQzgFR91VW4P+PV3NfutjMZa+RSRoDfJo2tHuc5yRBCm/hAPWkUMnSAn3rt1VzuDNz9wOzPzvCF9z2848eZtoaVGX00Pl8SvwFC20Fr+wvbGVzG3gTvMpN7mqzNpiI=
Received: from BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.9; Sun, 8 Mar 2026 09:29:27 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::21) by BL0PR02CA0003.outlook.office365.com
 (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Sun,
 8 Mar 2026 09:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 09:29:27 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Mar
 2026 04:29:24 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 1/2] amd-xgbe: Simplify powerdown/powerup paths
Date: Sun, 8 Mar 2026 14:58:50 +0530
Message-ID: <20260308092851.1510214-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260308092851.1510214-1-Raju.Rangoju@amd.com>
References: <20260308092851.1510214-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f1f7a8-3ffa-4e20-c91e-08de7cf531af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	8mdWEjJLqKKwa76J6ARHLA683reN3w/KRYQ0ED0mycT2OqlUaxJmpOnwuBPLQbknEaQOC8kAQbGdRXlAH+J4fcoE8UboA2YHZMf4fAQSSkJ2lvjocPYhtKSd7l8MFsbku8KNYfUQYYMY/P3waOGWsoDNVNXvqoa4KTsRtzMoZq0131QHUWFgBAjdgtCjyI6y7/o9+tnLJeN2uS06mMy3KvlQvQGkNbrjwgIpixvv1WZRfJx1HTNp+bYjg4OflDGsmp+ox7ULDE7q62367grsoNBLTQRz1vChLFyeQdonEfhq95SgtyJuRlYb6hjhpnKA+wvTccMDo9rKSD7puTZmDvB5GrXbBBXADDiHzLqeoNPA3vSQ6GoYX8FEe1Bc26COXc8aTcYwgAZYcRDxC+aD1DZtSdyo5k0yKGCSIXjszS8Lg+OABaAPnVNVkKJG5YOEahwxWmYAcLz7TN5qyvWzD6mrnNDaJOi+rFkjov5eFHB1de20Qj4JOKVUyVwerBzyeZSbC+tAe7US6pVMlT9KoorP/NzCNWPSP+Nk1A720il0XgM56N7ld7zCpo5Lz83+hxt8EEU7woLOC8vCR8aQj9QYtUKcvpMJ3YML+l4UuUIH2pjP3XHcjSxsiGFurXsUkI9mXGzN6vWh/ze7KbSlNJMsjQyrco4eOiNMU3mWveFCgpcSdVWGu5sg5Mv91orj0grE6u/4YwMaPZQF2UofCx8h6uX1iTUt06LFKBxOc04lbQ69w6pRB+pB6CXzDAq2bkMvkVuDfGE+FFjKR2wGfA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rdwbq4hi9Sdo498rhR15oSDu7BqFyQLBs/nFdvdqi4nIoSKy3LnUkfkB9sd3Mu0ztaav8bYVdUhYRNQRQqnHyKt7hKeXK0pGIUIEZKd+gP+5OUNNDXbAbB4RwhWAtNeLaGN+L95ok7NZUcXlmEgk58ULSvaJPCcdbVXgHB7AnxEUdnN5ydym2XKDR85USN1gufBc2zx3hu0oYjVBEa1hE9kPHzCS52Zfjm1RIqyYnZKd5ziscaHd81GqQrSjNw+OY10kOHe4/NxuHiWGkgMGt0eMGS82B6zVP2wg4JoUk5euNn2R8n7KiLYeF2EQXiOUWgxMQAS2DsOhDlF3lZhwib6Alefo5+DkC+jgjWz9q9I14KW0Qice5AG/Z7okBgRMsSzoRJbCQDGRHJs9Nw4bF/+lIVKgK+5skYfa/LUlVPvnSZ/jmCU4yoZc0MmIQqAe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 09:29:27.5267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f1f7a8-3ffa-4e20-c91e-08de7cf531af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
X-Rspamd-Queue-Id: A1AB022F320
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265254-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The caller parameter in xgbe_powerdown() and xgbe_powerup() was intended
to differentiate between driver and ioctl contexts, but the only
remaining usage is from the driver suspend/resume path.

Simplify this by:
- Removing the unused XGMAC_DRIVER_CONTEXT and XGMAC_IOCTL_CONTEXT
  macros
- Dropping the now-unused caller parameter
- Reordering operations in xgbe_powerdown() to disable NAPI before
  stopping TX/RX, matching the order used in xgbe_stop()

This makes the powerdown/powerup paths easier to follow and keeps the
ordering consistent with the rest of the driver.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - Fix compiler warnings when CONFIG_PM_SLEEP is not enabled.

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 47 ++++++++-----------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 16 +++----
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  8 +---
 4 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 8b79d88480db..d57daf6306e1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1116,69 +1116,62 @@ static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
 	return pdata->phy_if.phy_reset(pdata);
 }
 
-int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
+int xgbe_powerdown(struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 
-	DBGPR("-->xgbe_powerdown\n");
-
-	if (!netif_running(netdev) ||
-	    (caller == XGMAC_IOCTL_CONTEXT && pdata->power_down)) {
-		netdev_alert(netdev, "Device is already powered down\n");
-		DBGPR("<--xgbe_powerdown\n");
+	if (!netif_running(netdev)) {
+		netdev_dbg(netdev, "Device is not running, skipping powerdown\n");
 		return -EINVAL;
 	}
 
-	if (caller == XGMAC_DRIVER_CONTEXT)
-		netif_device_detach(netdev);
+	if (pdata->power_down) {
+		netdev_dbg(netdev, "Device is already powered down\n");
+		return -EINVAL;
+	}
 
+	netif_device_detach(netdev);
 	netif_tx_stop_all_queues(netdev);
 
 	xgbe_stop_timers(pdata);
 	flush_workqueue(pdata->dev_workqueue);
 
+	xgbe_napi_disable(pdata, 0);
+
 	hw_if->powerdown_tx(pdata);
 	hw_if->powerdown_rx(pdata);
 
-	xgbe_napi_disable(pdata, 0);
-
 	pdata->power_down = 1;
 
-	DBGPR("<--xgbe_powerdown\n");
-
 	return 0;
 }
 
-int xgbe_powerup(struct net_device *netdev, unsigned int caller)
+int xgbe_powerup(struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 
-	DBGPR("-->xgbe_powerup\n");
-
-	if (!netif_running(netdev) ||
-	    (caller == XGMAC_IOCTL_CONTEXT && !pdata->power_down)) {
-		netdev_alert(netdev, "Device is already powered up\n");
-		DBGPR("<--xgbe_powerup\n");
+	if (!netif_running(netdev)) {
+		netdev_dbg(netdev, "Device is not running, skipping powerup\n");
 		return -EINVAL;
 	}
 
-	pdata->power_down = 0;
-
-	xgbe_napi_enable(pdata, 0);
+	if (!pdata->power_down) {
+		netdev_dbg(netdev, "Device is already powered up\n");
+		return -EINVAL;
+	}
 
 	hw_if->powerup_tx(pdata);
 	hw_if->powerup_rx(pdata);
 
-	if (caller == XGMAC_DRIVER_CONTEXT)
-		netif_device_attach(netdev);
+	xgbe_napi_enable(pdata, 0);
 
 	netif_tx_start_all_queues(netdev);
-
 	xgbe_start_timers(pdata);
+	netif_device_attach(netdev);
 
-	DBGPR("<--xgbe_powerup\n");
+	pdata->power_down = 0;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f54a5040a493..9e09b269cb1d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -360,14 +360,14 @@ static void xgbe_pci_remove(struct pci_dev *pdev)
 	xgbe_free_pdata(pdata);
 }
 
-static int __maybe_unused xgbe_pci_suspend(struct device *dev)
+static int xgbe_pci_suspend(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
 	int ret = 0;
 
 	if (netif_running(netdev))
-		ret = xgbe_powerdown(netdev, XGMAC_DRIVER_CONTEXT);
+		ret = xgbe_powerdown(netdev);
 
 	pdata->lpm_ctrl = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_CTRL1);
 	pdata->lpm_ctrl |= MDIO_CTRL1_LPOWER;
@@ -376,7 +376,7 @@ static int __maybe_unused xgbe_pci_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused xgbe_pci_resume(struct device *dev)
+static int xgbe_pci_resume(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
@@ -388,7 +388,7 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
 	if (netif_running(netdev)) {
-		ret = xgbe_powerup(netdev, XGMAC_DRIVER_CONTEXT);
+		ret = xgbe_powerup(netdev);
 
 		/* Schedule a restart in case the link or phy state changed
 		 * while we were powered down.
@@ -461,16 +461,16 @@ static const struct pci_device_id xgbe_pci_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, xgbe_pci_table);
 
-static SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops, xgbe_pci_suspend, xgbe_pci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops,
+				xgbe_pci_suspend,
+				xgbe_pci_resume);
 
 static struct pci_driver xgbe_driver = {
 	.name = XGBE_DRV_NAME,
 	.id_table = xgbe_pci_table,
 	.probe = xgbe_pci_probe,
 	.remove = xgbe_pci_remove,
-	.driver = {
-		.pm = &xgbe_pci_pm_ops,
-	}
+	.driver.pm = pm_sleep_ptr(&xgbe_pci_pm_ops),
 };
 
 int xgbe_pci_init(void)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 47d53e59ccf6..98b03a3f3a95 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -384,7 +384,7 @@ static int xgbe_platform_suspend(struct device *dev)
 	DBGPR("-->xgbe_suspend\n");
 
 	if (netif_running(netdev))
-		ret = xgbe_powerdown(netdev, XGMAC_DRIVER_CONTEXT);
+		ret = xgbe_powerdown(netdev);
 
 	pdata->lpm_ctrl = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_CTRL1);
 	pdata->lpm_ctrl |= MDIO_CTRL1_LPOWER;
@@ -407,7 +407,7 @@ static int xgbe_platform_resume(struct device *dev)
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
 	if (netif_running(netdev)) {
-		ret = xgbe_powerup(netdev, XGMAC_DRIVER_CONTEXT);
+		ret = xgbe_powerup(netdev);
 
 		/* Schedule a restart in case the link or phy state changed
 		 * while we were powered down.
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 4333d269ee84..3b9345506c2b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -146,10 +146,6 @@
 #define XGBE_MAX_PPS_OUT	4
 #define XGBE_MAX_AUX_SNAP	4
 
-/* Driver PMT macros */
-#define XGMAC_DRIVER_CONTEXT	1
-#define XGMAC_IOCTL_CONTEXT	2
-
 #define XGMAC_FIFO_MIN_ALLOC	2048
 #define XGMAC_FIFO_UNIT		256
 #define XGMAC_FIFO_ALIGN(_x)				\
@@ -1309,8 +1305,8 @@ void xgbe_dump_rx_desc(struct xgbe_prv_data *, struct xgbe_ring *,
 		       unsigned int);
 void xgbe_print_pkt(struct net_device *, struct sk_buff *, bool);
 void xgbe_get_all_hw_features(struct xgbe_prv_data *);
-int xgbe_powerup(struct net_device *, unsigned int);
-int xgbe_powerdown(struct net_device *, unsigned int);
+int xgbe_powerup(struct net_device *netdev);
+int xgbe_powerdown(struct net_device *netdev);
 void xgbe_init_rx_coalesce(struct xgbe_prv_data *);
 void xgbe_init_tx_coalesce(struct xgbe_prv_data *);
 void xgbe_restart_dev(struct xgbe_prv_data *pdata);
-- 
2.34.1


