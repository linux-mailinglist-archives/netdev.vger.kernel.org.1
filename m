Return-Path: <netdev+bounces-261475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Dr7Gd97oGmMkAQAu9opvQ
	(envelope-from <netdev+bounces-261475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:59:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9561AB7EE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54AE03154A97
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379E44CF22;
	Thu, 26 Feb 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYKuxshv"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA040B6F5;
	Thu, 26 Feb 2026 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122656; cv=fail; b=u+0m+GBS5ymAEMcwyo1jR9TzV7gI6OZFbKuuwibpJ8EpXGts+z64QEEQnI1U+QtH250D4/28s6w2yxNEakckDT2c0pF9WivVwa3Gh3Yf8rgoVrEbCwF1A88fMZwi/lsRnlJrKZaQ7j5VgkTychySsv+RxIhyi3vEtlo72KTRDy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122656; c=relaxed/simple;
	bh=gdNHptx8UhS42HS7Pacft85Uac/O94kuPDJYEwZ850Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijeTIOqrJUDFYmp4TsbyNwtEEXw8yIBbsa/K4PwMIQtjBo5nUPOfuKJozwqwNVDSze2+01lQOSHVo2G0K0fok52UZza4jM38BC6ZdZGoudbWWspRnkZ8dZ/4bib9BFONYSl/AyzXA4kADIA5NHVps9TH/yKP+I/+XEF+hrieYFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYKuxshv; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veXcrcsFlW+R83+oC79YbF/BEQhcS81PDbdwiGNrgSPam+g6VJZ3QrkSuNXRePYFri2d3IDBVc6i9nSh++h8IW+maxI1xqHRu1o2KNDlb2WoSeT+MI3Q2H8NwXToJ3aIGLxOtfcsvsnRJYz61PgCwwq2zWDgCkoNj7UfeBgKK3dCq/RC6jCNTnXrDuC5gJuDFLNfC0JLunBqXms8H6G+GlajaLI86UGv0RR7KDdIRpvjqUKrnuhrZ2EdikWcyj/iB16p+WhbWnlKWQ8HI0Txq8q+yQhoWC8dtIZM2cr3DJHLJlS5nRl147DbbcxDqkc2ZUGaFsMorxdqW+5qVcW/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nkh6DBRWj4M5g8cFhyDHOdzrJ0y3uLg4MSfOalNa54o=;
 b=k4OXlLurbro5Wqfwf5rGh+MZzcN9Pq0NOZVIIsx+TMuuS8jCr0iKsc/xEDIv3okW70gDz4bwOt8PQgL/m3VKuBloUHOeFFSUKepIpndy7LmRNGUkBnTFaAmdSAkvlFuGoF7J6De2tOTCdF7gmArFRb7m2m0Kod0qU2MO97odjvnZD5YT4fg4ANEQdxOSxwVtohKIV8CjdvERkyOvnfoF6vP+H0L/BPNqkjSY1CnBq3CmfWMTQrWxgRvBE/GJcDNysBE3MPel/T4Ct6CKt4RjZ88kOk8CBr1xEOKkYI9NtyTpUd/6tE22LsxjhZLM2VB/YwjXZhd7tf9mehDNn2UfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nkh6DBRWj4M5g8cFhyDHOdzrJ0y3uLg4MSfOalNa54o=;
 b=uYKuxshv/ZSl0QsKDDisUBmUlCyDrtoVDKm5ANAi/jEcXhTbJivjN03Ga8ubVQfTz12GYAAPmYqHG4yn6kmebwkozWAagyN7EuWNDb2AB4b/VI7WiiLgU8U559kzhB6u13T3OUr225WsCYGvoBNhh2Vi1+JaIXOG0Sa7thT/mo0=
Received: from BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::17)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:17:33 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::6) by BL1P223CA0044.outlook.office365.com
 (2603:10b6:208:5b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 16:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 16:17:33 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 10:17:30 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net v2] amd-xgbe: fix sleep while atomic on suspend/resume
Date: Thu, 26 Feb 2026 21:46:40 +0530
Message-ID: <20260226161640.61246-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5024cf92-068a-410e-cdc5-08de75528c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	3B0e2vREQlCzHWQCfccIItntzW8mY4U/bO96bEQ9/IuWB5Qa2qa9fpjn1Ki5ejM3/FpFL6BlLf29+im18vb+ZExcC/oc2H69HYX0vbhdWrhaITCbFGYrjf9jHOuMWWlvj02/q6vFS4kEj4g6QJvjWF5MAQ8CSPhOuuGBozGAAOqukYMoSVJb/KVhmuejHudJjhr58L78FkKvRzitcanEBxQa8E9jUhwzV67Bs244xq4UwevSrKuFrmlSwbfWe/jjNqRoBAcHKYZTEtDpugnIIRZZk9uljD8EaWmHxyZ1LK2DgEt9ANqftoc/7+c+BKaJhQ0nhiuW9CD3oV42mkfZj68jaTutBJH3Uc+zuwK5lj6xx/eD4Mhia/p1o0DbNtGEOXGHwHxu78vNBS0r7wiYQpG0/Dpoy0n4HkMeYDH2iwCiFuFpAdBmS9omANeLm8rtLcOQuLjXW/4KeTvzyy4+qeo4SHEZl9GTrnVlLzxCfxilIptf0ByyFYItUhddOTaQxYSHjm1jakppuISVYv6h5uN86umedby+l5NFlZgyQHjiiUaBAQ7lUmgqNPitIXeBAaDe0yWw0aXhTmS7xonzCF+jDHoaUrIKIoJ9or+gjra6eJepsi78jnYU7zuTl+iM6JmByF3iKTl1JhNIb0998/Wo4zDnL8gI5QbHl5LBsZyrk1QH4bTrGusZ7Zjt/RNTJquE7zPuxO53KTTHXm0r/SaEOq/fs0N5jGv1VQpqv5iLRvKFC5YiOMIMybY3kNHxf8tAQLW/D3RApYqH0satYVnshlHDcX354fJXZgX8KqZsGvQwRgkvb4U143EGXWmHueotx9YGvBYjFjB2UeqB7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c51VjKfcUq8BSPj8WSOCIKb56hw/dtpnn8HGfV7ftwSDWWiG14qfTZz3u/Lu2zmNN9Ps+vv7F4a2zqdb0/KhK7v3KXYPSRB8XuSs5RMHy10aQJhbpbLSbluXhMBdD2jbG+qstETu3iggHxb9TRHf78xYUIvJRLGHy7xX6q7v/ksPvpBvPLt5SnBj5TtJWr2miOwosUGrlqwSEL0AxD3x4NyQbsat/AA7U5jIOcL+MWLLaES/EceEV9hkSxyLDgX3gJn2M9Z8wiFYPHr5gstHJcfb2pcVJ008YU3sfszLgbC/dUwjtVMoWZOoZvnVlw5d3/jrZN20stDuJJwGjDkVHN65naMGlWx+AsvUiyqGGoZVX1+yqPRque6Ld1yGYwWb+UhLJxKjfa6HynUBuNu6MP/bDsFpIIgIR3N81PiGiFyAQsdgRgqdXDwEMhiPLyvZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:17:33.1343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5024cf92-068a-410e-cdc5-08de75528c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261475-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A9561AB7EE
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

Fix this by removing the spinlock from xgbe_powerdown() and xgbe_powerup()

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 10 ----------
 1 file changed, 10 deletions(-)

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
-- 
2.34.1


