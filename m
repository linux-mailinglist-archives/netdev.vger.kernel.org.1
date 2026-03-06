Return-Path: <netdev+bounces-264761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KikN6bEqmnVWwEAu9opvQ
	(envelope-from <netdev+bounces-264761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:12:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D922042B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A212630518EC
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E70938B7C5;
	Fri,  6 Mar 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xNWq6SGq"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B237FF7F;
	Fri,  6 Mar 2026 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799080; cv=fail; b=KHdMTjyQvF8Vqgne+PQaUog0sRyeNqo4vy20Y9Bd17baLqHbKKWENQaSPNPDVQvgBPbotfwCElkEJF0ia13eIA8rNFWwEa8HDm5jS1sfSKPV4qY3Foo1qDhBemo3Tdn/aj1z9D54umCPuwQcU3loUs3mT8NH2VPHlTP79y3mh/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799080; c=relaxed/simple;
	bh=LO1SP7HTQWWnAz67t/XXf6q4w17eyXZC2dbY+ID4uX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmOLvXH1XRgnu663ROpcmdrQOXxxm1LaM3H/cmw3/7whMhBsX2TQFmrRZHeLLwORNMF21petAksHv2jS1qkDmFHbMtzo34IUPOpkVvvwXGRJD423MJ8ZcnwW/4bRVmfU3gEvupJnNB9+7o8P+oAWR/WEdEm7XCu7+OVofdrwe9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xNWq6SGq; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTT8q1gUIZbldw0Fj5ewNkv0n2x+GJ6x7k05+0eGaNJ/mLu3ruRrPk6lK2SmN3CEZz1ngihoeZd5AZQDywRilGaB8z2gEj0wqCZl+QbUXSOPnDULRrbcLLUYLICocEJ3u9zsJk2ycqDsxDvVpi5f44ZGqBtFChnvrxHPtBMIkeyoBPqrHD5UCInlf0QlIfve6by9yaC7nWb9fJEkt7nZiy22dGIBy+knpTxoaOX+hlif0RhQxlgjZx/r7BTdhUxLRE9F0qicErzELrljQ8eaPCq/X4LsdE9tbwBVraKetUAXWIs8JY0cjmCMI+lwmwE8h+S8JTcYYYBnXfotTuSHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbdCZf3D2cSZOTjrQ0f32zYWHz9akhQ9PgcRgXeJBps=;
 b=ecVF/xo+iy4SAIERJZhQdvtyIBeSnfHAMsENNEd8c2MQCVyhN99PwPWa80lUHW2i68l7wTyStvBIfgfs+x15jCmkpT29PlcVMflSik7bPZEOoba+TZV/pKibdlo0SIRja7brQ+Eq0TEWvBR+ZZLUeaRv9mAZ8VA7lOrD7NdSc0nnMltMtqKnQA3mpJ9dmPoKtNSdmTpL4Jg++kMOnGr4HaVqIcpa+riGe5CfpkHunVWy3noPYlFTMgc5Wmu73HmLTUwqMNA/mmDdLO+rRyKx6R3kPjr+PQEpVLEEt3B1hcbwn+y3JCqO2rqrtVolxE8EoNFquGxfrnWMUfSOmRZ84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbdCZf3D2cSZOTjrQ0f32zYWHz9akhQ9PgcRgXeJBps=;
 b=xNWq6SGqQJXghBNjoJFUxUoFqPF3j7iRBiT4lPa9WZLBRhgIlsDSVHoFQ07NB/wIiXosBCc/dbfHT01tU/k3TEUk9x+x4vkjO1t+N3oT3SV5f04wq4V/ZVeOIriEGxR2m0+UxOhzsa8JMzJS423N+wKIu0fAxMgNsm0V7MS3Q1I=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.5; Fri, 6 Mar 2026 12:11:13 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:60:cafe::39) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 12:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Fri, 6 Mar 2026 12:11:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 06:11:13 -0600
Received: from airavat.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 04:11:10 -0800
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 1/2] amd-xgbe: Simplify powerdown/powerup paths
Date: Fri, 6 Mar 2026 17:40:46 +0530
Message-ID: <20260306121047.1231755-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306121047.1231755-1-Raju.Rangoju@amd.com>
References: <20260306121047.1231755-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: e0116cd8-8a31-47c4-928f-08de7b7975ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	C/iXYBbaYtIRoGgK/RjKFVbssj1vYtshj0Fv7HDx/Uz9vREimbGtF8fAxC+IeiJFHtfJcYb3Ke7CkGrO+eMFepMC+dVsWiOngnkqBcDpwlT8YRMl44NQaeSUkURxdus4dHkGGhYl5IGI3pnbnTQtE5aQWQeaiWZYZ6lSlkC80FQInhiq/ZCza8AcfZPvtJaLgaK2mODdeJCR62ZG0SfUAWAvRFcY0LsQu2UH42lg03fb5FZ8ZnXbpwJC8FcnOnTS2ty2QXD6q+TTXEuiB2x2wg8mLam4UDb/Qs68M80dGnjFYNuvhrRQDnhlF316w+PIBnne091XUVJh4bKzGQufjPH0ozXCf95maAcErBVFgbsLIhn0TyEpSnG0l972YEHZxILVyMU/tWlnoi7l2MpbFbxbN9dw2KoI2ekwaSkFwShkps0ccql0atoogEL0prrf/iH4ay9yd/Eu7sEryhAKvlXhRoysKzChLPeE/LxpTyR1hRidQkrXrdE6RkMU8LUK7XAu/zSuBnp/UuWX2/qltl5nTxdDu0VLlm/NZR/zqGiDiHny2uqextmpBduKTGd1EedClQG6kDmJlBDfumAxhZVdH5YV+IqQE6ve1G+FKsfQh5A7KPqY7I5oqJoukiyDLZKklXxIx+ng0tYu134/QgRkACCZG3uV4+2dkAMy7e6AJVvVNADChik8zyX+SA2Wkyg+8q7MvexXtVqHK3s7pAOEp+5S6TdBOxKTWmFGKQ2CPK6+UzulbohUB+PkG9aor26q7JW3hQuPYsi0rNNHWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6QtydX2257FDyYDwmzM8fiAMdQf/s6KsBXwyVoAZtHmXYR2/QEDlZQfWbb2TA+CQFz59C/sCRc0D7EVwasjkdRvASDV9aFU45C0rfJk55wH7fv0oKS+cdBNzIEOH5HPqIbYW/CLMMjoQpiwy1PVdTXl5OPJu7h3wjelUeZa5hwGr/LNwyFdAJundScXCNtIhusST5RILbfss0hccK/Y+kT41Hz6XayIOnjrn6PhqCjY1E21GnmApUanAGcygtXhkdAD5HfwQMiFxl119w5J+vA/Zv2M6eFLSSlU2SzmUFbbXFcCS8MWtHYIpvyl9auR/HenthJBahy94lMYSyhicem89gO133qHVE02TnbNiHubsiIzB4LCtzYDQiJwbPaFFm/XmoXxhSTxaFu3+QuncLUH8PW9xR+N4XPLO9if1vUfESNuCZv+IxsJs/llEu28k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:11:13.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0116cd8-8a31-47c4-928f-08de7b7975ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
X-Rspamd-Queue-Id: 9F2D922042B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264761-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
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
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 47 ++++++++-----------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  8 ++--
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  8 +---
 4 files changed, 28 insertions(+), 39 deletions(-)

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
index f54a5040a493..d8c1037dec45 100644
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


