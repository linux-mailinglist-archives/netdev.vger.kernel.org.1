Return-Path: <netdev+bounces-262484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELdeFrAQpWnu1QUAu9opvQ
	(envelope-from <netdev+bounces-262484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:23:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2421D2EBF
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08CDA300B1AD
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 04:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2482D29C7;
	Mon,  2 Mar 2026 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KYe4gvJW"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8E430BB6;
	Mon,  2 Mar 2026 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772425388; cv=fail; b=su/6QgD+J/AowCQ6G4TaoyEbjzNOwUsiYahW+6YVF5vzOI2Nax93EIC9enRX7isp6z6y6/8kl7FUgml9Mr/xwXwZMX2WI4p2BQtNYruCFe6A/t3AHQ6SiqTWknV7EMJ/5r/9dQZ23BcOam1aUp8v9kAnOxVpYRqvb6ehhTy2Fp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772425388; c=relaxed/simple;
	bh=DGHt93zC+K/ImrDzzFZY9EUwc000CcWe5QlQuOtin/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FO9GCJuXu6eN8JiDZTYkZw3pajVpQEOIpT/fV1DGYeFtJ6IJLirlPeGPsTjYWVmedjYa0aBPzExuZtilkK5GjlVhRi+UnDHVIBEnNHNme0SS1G7YafV2sqDCtRm8nBSiOI+0fykP8gHh6nn486itpvppZ29nwGUEdaVLN5bxGl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KYe4gvJW; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMQss+B1YbXBf70Q7MM5bZeYBN0s0cYKc1Se0+tA28YuSuq+Ms4s5j527u8fFaDZu3e3waAzOI9UWtJVptMah46kqo6waz6qWXd7HPlMmRiB2hfiVrNZBhxopljzBrBx/UmOW9+l7Cybam0MzGml5mAN9539O+MCGr5NCTN40i83KtumBsIwGd3q9NNIde6XipdHXcpnHuStZkYx7+2LA7Q7a2PyU4ZfhShZMAmHeKJput4eOPjqM7hItdN3rlYmFpSuA99dUO3RGdAQlx1hy+XGwNwQHsuUBApE365on3bIVlvLje+mqULsU+5ZoRFYVjWLS2K1hYG8txrvYpgggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Jcol82p86cw66HBp7kmKxgKwXu9vdwFUwln52FpqM=;
 b=RWrNp1yLWlqn2hUOvl4a4ZIltjXfHUrPyruXZ9bsV+yz7Qn/A/YKaQF4w8x9NzZdXVfDMH3YvlwqGdqz9JOih1g49hxHG8tPDE5YvvWGG862w+sX96rSMT7GPM05TnASn3aKXAisKdljW6d03lavw/++sxU/a4hKMyKktY6U/IqIzYwWjkAHJNjoM1nnB4K1vGiUH1munEuHBbV6wtrPX8cCg4jJ80JSRuL5YBOf6kB+xuv6qB3a1HwQTKLCg+gFQfYl5PHq0PVXMsJHzy5V38HRBUQ7GAMYeCXR9b7NEx0srPdCmpUXps77ucg5TxcCfxjlwyj5RwZksG1fllmieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Jcol82p86cw66HBp7kmKxgKwXu9vdwFUwln52FpqM=;
 b=KYe4gvJWsUndmVW/kUTTZwxy1l6/Mg+rTb4KimuQwlYkfRiXCmc6EWnqBY2ttuTjShovBi13uUdf2T3/A5S7XHmp+GKoij65h+oXZmiE0arTis/J39wmQ3tQOJoCdeicF4NSOp4xrO4AZ5t3Pu4eqm8GCQNC7nvpGBzmgp+DLeU=
Received: from MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17)
 by CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 04:23:03 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::cb) by MN2PR16CA0048.outlook.office365.com
 (2603:10b6:208:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 04:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 04:23:03 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Mar
 2026 22:22:41 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net v3] amd-xgbe: fix sleep while atomic on suspend/resume
Date: Mon, 2 Mar 2026 09:51:24 +0530
Message-ID: <20260302042124.1386445-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: e92ff43d-7539-4ab9-32b8-08de78136549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	kYUBPqu6LycxXQEBaFLe6XUeivEhKl3deXx8GTs8RI+GBE1KHiJ3hAWA99HtS6x609lXm/Vbq1vzhBYXv3oEzSWw8gGd7z+YON0E+prwstRcjspRvCLU0uUuxN+sg+6vZIKBFN82jxxph87cmNPMnQEcLr+HYss08sQ3Sfoy+SIvDEGt1i5MVKW60z77w7K2CZGDd540hrCfhwm2fD+xvz0zkVsOGpQQ97328R7+nh6MsS/Cmcmdd+kVsRFWfDXNandSR8m0qNWL6WL739gyg2PJPinR9VsrkrlTHbGpSd7bAeVstRoKOiDRlP9fL2Yq/MGCWsRA2i3tpsjLR5lEs+ggRD9Y6wgJNG22iHtxDAymCKp8nBmQ486kJ1zUs+RJjOPAgRWbT8eQqbAzgbP/MnM+poM3cDWLMKr0klahKBDF29HLkP1eqjSb8ex4LPn/vT2ToOALS9UycXW1R4o9BN+LXuifl8gSDzTPAyHI19QQTGE2N0SlEx1GC4DEUXYVuoZgYpM2NSiwtHfhgPz8+/5Ex6UHZNkCEAvnNDtPvJMT4XWdwLBboo5PmBan/xA0iSBNaUhoUO8C++G9j1Mfr4VCKtX3ILg0kKbvUGRTWlWaIeRxHgnkvKLt12FrLYc6d5f1B6WEYlrgWO8AYxKpI3H9J8vYx1pfsxQJZ3Zns3JepHXpGymKND9qdxBZftYx93mVzBdyasgOhpIQnS9vTa0JXVvN350tVy6nMz/oCZFzo5JzH8HWgLspDw4iBwkd8zQNfDnQmjv8dn1UcvrSR/6aWSvVb7sii1wRMHWHqev09flJAdoClAvR6ljKWAysJu09QT+PWFpxc764tJFTgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NoAnHoj4uCR7QOBqWdhi2kuz+4aBhOvePVnsfGOnVdL8W6xg0BdPa2dag+USYT3dTIh1epRTmfCCnpAZ80zPPTLCR7GnTMyMnhfJDBG/XqCnf3NlZXScjq27lYoKiMShY+fF4NNIijQVxPrKpl1D5qBY7NA8a2EUP6RW5O6V6MYeFfZnqYLPBK0mypiM59xPPgVPVbocum791ToLRc6gVEhWCGp0SHd3rt29wHqwX9uzvcGI2hTxbZn4qYCyLSI605qKPp6SHKb0ZPgwYLsbf28vMRYDZuCWV8dFHOV0kcCeidmffV02ZeGOu3Pe6qMA0AuL8wPZT7ELwmPh9kQ/BUp5pHG3ZZl1N07M8z33pTfFw63xjW8XjHQUwxt9XvIXCFj4tOOM/4sb4nvOHUrB3ZPifT98wJpxbhP2VLl5JFnBH/CL5A7aaJCn3fAm4bU0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 04:23:03.1754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92ff43d-7539-4ab9-32b8-08de78136549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262484-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC2421D2EBF
X-Rspamd-Action: no action

The xgbe_powerdown() and xgbe_powerup() functions use spinlocks
(spin_lock_irqsave) while calling functions that may sleep:
- napi_disable() can sleep waiting for NAPI polling to complete
- flush_workqueue() can sleep waiting for pending work items

This causes a "BUG: scheduling while atomic" error during suspend/resume
cycles on systems using the AMD XGBE Ethernet controller.

The spinlock protection in these functions is unnecessary as these
functions are called from suspend/resume paths which are already serialized
by the PM core

Fix this by removing the spinlock. Since only code that takes this lock
is xgbe_powerdown() and xgbe_powerup(), remove it completely.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since V2:
- remove the spinlock completely since only xgbe_powerdown() and
  xgbe_powerup() take it.

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 10 ----------
 drivers/net/ethernet/amd/xgbe/xgbe-main.c |  1 -
 drivers/net/ethernet/amd/xgbe/xgbe.h      |  3 ---
 3 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 62bb4b8a68e1..8b79d88480db 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1120,7 +1120,6 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	unsigned long flags;
 
 	DBGPR("-->xgbe_powerdown\n");
 
@@ -1131,8 +1130,6 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&pdata->lock, flags);
-
 	if (caller == XGMAC_DRIVER_CONTEXT)
 		netif_device_detach(netdev);
 
@@ -1148,8 +1145,6 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
 
 	pdata->power_down = 1;
 
-	spin_unlock_irqrestore(&pdata->lock, flags);
-
 	DBGPR("<--xgbe_powerdown\n");
 
 	return 0;
@@ -1159,7 +1154,6 @@ int xgbe_powerup(struct net_device *netdev, unsigned int caller)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	unsigned long flags;
 
 	DBGPR("-->xgbe_powerup\n");
 
@@ -1170,8 +1164,6 @@ int xgbe_powerup(struct net_device *netdev, unsigned int caller)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&pdata->lock, flags);
-
 	pdata->power_down = 0;
 
 	xgbe_napi_enable(pdata, 0);
@@ -1186,8 +1178,6 @@ int xgbe_powerup(struct net_device *netdev, unsigned int caller)
 
 	xgbe_start_timers(pdata);
 
-	spin_unlock_irqrestore(&pdata->lock, flags);
-
 	DBGPR("<--xgbe_powerup\n");
 
 	return 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index d1f0419edb23..7d45ea22a02e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -76,7 +76,6 @@ struct xgbe_prv_data *xgbe_alloc_pdata(struct device *dev)
 	pdata->netdev = netdev;
 	pdata->dev = dev;
 
-	spin_lock_init(&pdata->lock);
 	spin_lock_init(&pdata->xpcs_lock);
 	mutex_init(&pdata->rss_mutex);
 	spin_lock_init(&pdata->tstamp_lock);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 1269b8ce9249..e1d7d7150e16 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1004,9 +1004,6 @@ struct xgbe_prv_data {
 	unsigned int pp3;
 	unsigned int pp4;
 
-	/* Overall device lock */
-	spinlock_t lock;
-
 	/* XPCS indirect addressing lock */
 	spinlock_t xpcs_lock;
 	unsigned int xpcs_window_def_reg;
-- 
2.34.1


