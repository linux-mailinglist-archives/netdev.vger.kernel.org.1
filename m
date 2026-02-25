Return-Path: <netdev+bounces-260884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIAJHYPWnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:01:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620051962A2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D746130390A1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC72393DF2;
	Wed, 25 Feb 2026 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ApxdU6dQ"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AE393DE4;
	Wed, 25 Feb 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017263; cv=fail; b=hD4zyFyF992YxVLMCzK15tw+FS2XccOFEBezPuV6Vlt7mimT0kGabqmQvvnd61GDjCS2DRJ3CJ721NXCwbkcyqo2pSI45BmfPC2+AzW+pPWnal7/Zr+AnuD47Xihz2t5F+8vNE0blljNYBg0uJSo22zKLC3DahJ7n32CDWri5OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017263; c=relaxed/simple;
	bh=DfqssogX200t76qC0xUrKO6MbDyqqu8ftptZdgAJbIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtuDhXZUR13kVy+CJQzVOpwB1meFsWlQvO/lNn8CzD074eTxOnoUxj21Jcp4Mv2w8BSQFqOUaYjZwbpPULOfq6NQmORz0fpqKj6sr62hpZTkoz91LOHiUlxH6aecuUlIj7O1qcztAQCG+iL+K0Hvj268afvtgi4x5r08w17i0HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ApxdU6dQ; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWKV8O6Al/nffiT4QRzDwWvVJONzMhQ/9XR91c7DsLPaOZOlGOSGqxDMR72Wbn18GUac2M5sMJqrt72zX2jEFUq0Yi2ljC9oLXgRxN2z5nocJ5OT/DZlW74YF1r6t3XYsMSPG4WuBVV2ou9hQcK/p/AeaPhYvAIufUkHmMVc9VOhcInKSOZZsdxzC0ID7bfPjQsU3bQN0xFgbXmwoZpvlCNeNW913qbg01IDeCC6lrhbuW8PSL8YVZ76I2UE4/mF9IebxDeegZyNnKtmSaOuVjHqf3wLNtPUxMxxINxcr/mUsyKz9GVGxMtGl/RyOjtvuyyINXJacrnv13UjxQU+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHQTcyb7XrgVbFyYELd1C0ZJ1P6r6AwMbMR6MxH7k5Y=;
 b=nAUnc0a13x0eyfF0HffLRgPR3XcxRD+6psDvW7kp5RloP3cvyWuPCXXGdMGQrBWEhlolLanBNyuMenmyhTFj4lYh0/p8FqWcLVvyMXEaFctx1gLly79CdWK/IUREir5iRwJsEFs1nVbIxDva23X40My5bzUZcF2jvap/xmZtAHh0Hww2gK4P03FoTiNMfHEumWK2OgqjX+duvQjGqnbq+vRIO3oc9nNJqFMoS4a/CnwzJrvKROKzQne7U2eQSJqF9BDPtWhnT5NgeYKeM6hW09cipmtVhkF9M8q9T+GG6ehWsMf4qAE9MYPqPvDT+Yp5ibnuOXf0Q4PTlIQFZ5VwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHQTcyb7XrgVbFyYELd1C0ZJ1P6r6AwMbMR6MxH7k5Y=;
 b=ApxdU6dQwPBN+u05BqoyqylqNEtrOqk3G34ahibhoz3vCSRRd0RPJcRnOxFszTeexNRlQBQ5Y4wkeeCQaiIjTS78qMOWLKIRTPPriprxp2Cs59u//cjzKkYavBhXarP00m2HhxwDdB833O31f6qdggF8Ha+KsWHUtyZj6UQomcc=
Received: from BL1PR13CA0078.namprd13.prod.outlook.com (2603:10b6:208:2b8::23)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 11:00:54 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::49) by BL1PR13CA0078.outlook.office365.com
 (2603:10b6:208:2b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 11:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 11:00:53 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 05:00:51 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net 1/2] amd-xgbe: fix sleep while atomic on suspend/resume
Date: Wed, 25 Feb 2026 16:30:00 +0530
Message-ID: <20260225110001.1000014-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 311ac72c-a37a-4271-9af3-08de745d253e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	e+4TpdMUmuL1L/fNAg2GO6rNh6pfcqAw+nwBFtveE6Gb8Xa/+lvjYi/SyqS/Ic34rj7xPgdXe9JThl+HoABGB40N3cXcqvB8V9Cfyo0mncnvs75lXbh42Ff7HPrV6aZgDnQKMtMXZ6wY2l5Lknc0Xg8roV2YCDhfkLxwR8Sj7NRr3jR5VRs2GWF8mxN70nEortoQrgFy6Uil1yZB8Ey8bhSFduMWx7YCRpT7X1WWrUgmHErYgh+x7ROjQwmbptYWZOL0tHnM10sYXKil4IVgYwam+MBqqQ8kFe5roWJ7alkxP4Zy78AAGTZlqT+ND914HbjQGK9qK7Yv9/7eCwRVPMMyNlharQt0mJmhosZLf7okoX1dIetTFqTbZbIyw+ryqUo8bcfamhHvZ4ajS/nRtCPnUGLseMeDHZiN3QspcZGW2ZD1qzcOlsILR1mmXpnZecaR89fp92ziSL7m4F4aschuw1mejYjM2BU3E8ARntGR9blfO30E27Rrh2bQ1c4CQkYN9iCkOWI1YGT0gC7WMCfZGCsNhYKd7VhDrJMEC5tEwU3PVAwylmoaaU8gyW52tws8D0XbvBQC+dbgvnyLKoD7XE7H2ONapk7e2Ww0vlDzPThOa3r7pLt6I/gEGGU8ynXXzR/DF36aESZtPqesZxTwR2tUTwWumGF8/idXSSFcDOt2Nd66BdojdNEU2zKSkheg4Q9FBdaGzMv9jQJ5gtRfAZAzCxEAvRhU+fW11d6vdJBsQ8bwbDUeYZvsnfaeURkYET6HbLOOzi7DTsodc14BBuG6u3ORwsVr4Bi2hP0K1iCwzG0w2PTSS4IS6Gg5BDrCnnA7oPt2IdH0jbCXLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ePF/EMolHKx/znWnjj4+7i0yoX2XJBF8MUEbMTCiuN/B4AMgLhK+AZqkNSkw4VfRve+MHPku8DbLGflnN0kbmfUIQrCkUZfRYpPbBECfJjstzAmZUjpkW5EqXtGGZRjiuHq6BXOsJ2ToqS7/XwEfs/ud7XqygFRV48531mwkj3JZe0itwbqpx+eaZvrh3xPQRWsWeCGjcpyRe8IAep4/GBB9w+GDH30mOM1vxcjKkK0TxtcdQM5ap9tMVCAdwk3GasctHhZZrERmp2fl7PhdU+96/Ophb3ZgW5O9GqZoM6KR5wX0Gfw0HvhR9GW4OKn+qX6JQ/dKaoPZDhJXLy5I2H+NlKwog326yLsSlj/zodWnbdbc0uWfDpd3ug93Y5A8eMSd/h9B/8QkXvkb9RFAPrShyDMFt1msBVLfqGYpHfKkwERT3P6ewgfd0F4NuPlD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:00:53.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311ac72c-a37a-4271-9af3-08de745d253e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[amd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-260884-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[raju.rangoju.amd.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: 620051962A2
X-Rspamd-Action: no action

The xgbe_powerdown() and xgbe_powerup() functions use spinlocks
(spin_lock_irqsave) while calling functions that may sleep:
- napi_disable() can sleep waiting for NAPI polling to complete
- flush_workqueue() can sleep waiting for pending work items

This causes a "BUG: scheduling while atomic" error during suspend/resume
cycles on systems using the AMD XGBE Ethernet controller.

The spinlock protection in these functions is unnecessary because:
1. The functions are called from suspend/resume paths which are already
   serialized by the PM core
2. The caller parameter was used to differentiate contexts, but the
   only current usage is from the driver context (suspend/resume)
3. The power_down flag provides sufficient synchronization

Fix this by:
- Removing the spinlock from xgbe_powerdown() and xgbe_powerup()
- Simplifying the function signatures by removing the unused caller
  parameter
- Removing the unused XGMAC_DRIVER_CONTEXT and XGMAC_IOCTL_CONTEXT macros
- Reordering operations in xgbe_powerdown() to disable NAPI before
  stopping TX/RX (matching the order used in xgbe_stop())

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 57 +++++++------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 10 ++--
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  8 +--
 4 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 62bb4b8a68e1..d57daf6306e1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1116,79 +1116,62 @@ static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
 	return pdata->phy_if.phy_reset(pdata);
 }
 
-int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
+int xgbe_powerdown(struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	unsigned long flags;
 
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
 
-	spin_lock_irqsave(&pdata->lock, flags);
-
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
 
-	spin_unlock_irqrestore(&pdata->lock, flags);
-
-	DBGPR("<--xgbe_powerdown\n");
-
 	return 0;
 }
 
-int xgbe_powerup(struct net_device *netdev, unsigned int caller)
+int xgbe_powerup(struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	unsigned long flags;
-
-	DBGPR("-->xgbe_powerup\n");
 
-	if (!netif_running(netdev) ||
-	    (caller == XGMAC_IOCTL_CONTEXT && !pdata->power_down)) {
-		netdev_alert(netdev, "Device is already powered up\n");
-		DBGPR("<--xgbe_powerup\n");
+	if (!netif_running(netdev)) {
+		netdev_dbg(netdev, "Device is not running, skipping powerup\n");
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&pdata->lock, flags);
-
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
 
-	spin_unlock_irqrestore(&pdata->lock, flags);
-
-	DBGPR("<--xgbe_powerup\n");
+	pdata->power_down = 0;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index e3e1dca9856a..112d7697174c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -352,14 +352,14 @@ static void xgbe_pci_remove(struct pci_dev *pdev)
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
@@ -368,7 +368,7 @@ static int __maybe_unused xgbe_pci_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused xgbe_pci_resume(struct device *dev)
+static int xgbe_pci_resume(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
@@ -380,7 +380,7 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
 	if (netif_running(netdev)) {
-		ret = xgbe_powerup(netdev, XGMAC_DRIVER_CONTEXT);
+		ret = xgbe_powerup(netdev);
 
 		/* Schedule a restart in case the link or phy state changed
 		 * while we were powered down.
@@ -453,7 +453,7 @@ static const struct pci_device_id xgbe_pci_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, xgbe_pci_table);
 
-static SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops, xgbe_pci_suspend, xgbe_pci_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(xgbe_pci_pm_ops, xgbe_pci_suspend, xgbe_pci_resume);
 
 static struct pci_driver xgbe_driver = {
 	.name = XGBE_DRV_NAME,
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
index 1269b8ce9249..4e1ab4172abb 100644
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
@@ -1289,8 +1285,8 @@ void xgbe_dump_rx_desc(struct xgbe_prv_data *, struct xgbe_ring *,
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


