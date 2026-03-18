Return-Path: <netdev+bounces-268989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK97Co6WumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:11:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A63182BB454
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2FF303C032
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FE3AEF5A;
	Wed, 18 Mar 2026 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zo+eIOeQ"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A136AB76;
	Wed, 18 Mar 2026 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835846; cv=fail; b=M8KMgFEUMc/IAz2CCy6/sZLUic/WnpeJi02Rbulb6Dbz4hEcmHsyHPevFWQBhn0imy0bfvIgVdVjHB6fx/Fs6Ttt2aEMWyJb/vtqVWMUdDxuFt9mF0i5I9x4Hlc/45I+mF2cc9QGPH8dg7SDI1ADDHCpu4yYE81JjmFuPWwg0Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835846; c=relaxed/simple;
	bh=5t4NKf0j+SXzgf5SCIsB//5lQpHU0Kzix4I4EDcI6hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/D0Tdi6UwBoitri48DqDYlrGELPMWdgc0eTVpWCpouKrYimjD4ye+HmDQQInrJMxIMMoOnWXFZpkiv1/7RxZKFS5FLq3ULgrhXOHKUS3Nmkd6eLzXGGhECQPWNHU5SIzcLuHeDWrDiiWCPlbn+BwKA0zVypqKb5Elev/Np49Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zo+eIOeQ; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7O6yWkDhJSZavlR4TjS45gQ8rPGsnGYKcm6QUHQ53bFuc1w3HxYJ54LsiZupR5t705tEwoq4YsfRwdHBtyb/0CO6+zvxeCi4M8zFCbMV3cyElltGyYw3pTzpgtyY/blEkGXOd0eNABVNMxsefGvaonws6/dLQw/69WB2uYyogQKNnUcFCIfGzYzurhbXEdk8qIkPPtCL+IKDaIe1icmmyUXQ7+n1l6eRV0OHFhx8mCiysCdZQniZyd6fyJz2FYLv86qTT7LJl00jUAsevN/3NJjxPzo/yJDuxaEjTECd4XLws5AQTTcxZxDcsQGvXixP84MHZc6zwuwlqBGNrmFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRyarCsVsCZSla8kHKhCHaGZGv7x8BLtoxROpxUPfCE=;
 b=thn2dQehegnsD+niGYShGj1pfdwxNEarFxumdDDf3YaTHQQwljr64WpznBbVKNhNoY0zIlBHeJUeTINnWaKb/86wn2XwopX4dcqKPo1F8vRLWucUfr2bnhn+FOyyn9KmrkuDQ0l9ijdmah5BkeQEE1IWM/JzA/tDVM83NQs5IVUdF5iS/xpQ5hCYFKSJ9vfXn6FsjAvW4MSStfsZxPXQ4CJocumhgukibgDJbrThH606GDrGlxznsFH3s1Tn7I/X/bIiuibfngvBVuUksK80zoieACd113aGe3ofuQDjm1pJweJQN6U4N601YMsyroijq8fHl8s/3oiiVLVozsr8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRyarCsVsCZSla8kHKhCHaGZGv7x8BLtoxROpxUPfCE=;
 b=zo+eIOeQabqjeZSI4hPvbDzJccub4jLGHkv93+xYAnvEPjZUOcwRY1VsUEjT1tVgQmy7YWMZ8+T215LvU+qjbvFK/sSIFWr57OAPBKF163GWSzA3AjDbK4+LV2qYdFqFdXDwovo6M5HcaEkxGikwXhSktNjdfyOUjSKhJlpVoNA=
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 12:10:41 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::d7) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 12:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 12:10:41 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 07:10:38 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH v2 net-next 2/3] amd-xgbe: optimize TX shutdown on link-down
Date: Wed, 18 Mar 2026 17:40:05 +0530
Message-ID: <20260318121006.1565435-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318121006.1565435-1-Raju.Rangoju@amd.com>
References: <20260318121006.1565435-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf7558e-962f-4475-5e74-08de84e75fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FHc2caaOwOagVLUCIqSKJUd6dA7uOrrbdGLI1J+SMirNJ8ZTe9QJ4LqMOPLgE3V0BcIEP7h+b7RmTs1BDkoSb+N7ElBWju2jvuVGfB8ywvqEWP08ZGKcTtInrTejiZY8gInsha+mAjGBVO4ub4RZPDxzjlgGFhCCPi/RBX/SauEhwjVHOTznX9e8vC4pQUMEVAQUmboD/bDhnGJkQpFQQkNjPBEFZxJSfkqTbYmX9u+nergyORxpwI/52G+zrDqn1LMYZa4TNLGZjRS9pGh4+HoidXJM4tiJ2qgfrui95QX5q6WvzvTxKczmqJPDQz5Qn/hM6nMP0whKysnNUqlXjkVhm03PO0Z5ECo60+mHbbFbB7yMe25p1wmbzZDqZ8p/UVZrVtv14bcYJYEwfh7qMTXddgmJXx7/GYH8b8WZ9QSLPsHCqBZ8Rm2nY8YiTsrn8KSpLdrVxSZICQSd4ORBd6DJ7Ce2fka2YCY/Mj9fpRzz9N0acEG45evIYrreodCn/hGu+8IbSj1ZcWfQjeAfp2OILLH1LfH8zJCzV2gtnBWn7SoGTX+1JFwyJZppp5+D77SRYOmeERuFbZVBOaOLA4PBw6zSzCgA7LfgJXs1QUs9mXBce1tN6SVI5mwb2tN56X/LSmgjFsJmyj+LANZkwoaYGIwzHnlYEyWx2KMt0ygOREeBWF70a0CUiwyYaqY5kcqye0lTy+67CcGKC5oI2vM65AFYfhkDxLuNF4GLMyr0q/CS56X/AwgcT+Wj+PH63Cyw1x84KCd1m0jObvmvoA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BaTzrExqAM60wXjcWa+mk+pwfMRcwgL5lR/7v7rOpV0bUzrkUEvM2A37M34zCFSnb4Z3ipL7Spvdj0blPbMDvcRV+AQrFks24r00hPHaSADpggeR1zGzg+7PtNEVEgxIjzFzOPSKhBSqSqn+erEda69CBLdcD66M43YVbiUE7WRTcVh9v1I2g5/AnEQleQ86TheRmK/NwAus251UjQSOcCFkixBj2tRSZZiI5looyV06Bg/T/HfbV1SXfyup87iI2Pd4vbqvksGlsj85mAGQXBmk/v+uhye5rLmgr5OtZp3T3/ydvrUJGUKaJtkqF+qG47oov6pt6XUsOK2Nw3PvSfucGX+pSeHSsxncG/d1SpgoD9vUGI+0LIZG+aGSNkbfNnGo46movU6YVPmnvJ+zxvWvMBkNTD5vIEz9pjCCbJe8FgUAktbOpZYll+EMA/Tx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:10:41.1472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf7558e-962f-4475-5e74-08de84e75fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268989-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A63182BB454
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Optimize the TX shutdown sequence when link goes down by skipping
futile hardware wait operations and immediately stopping TX queues.

Current behavior creates delays and resource issues during link-down:

1. xgbe_txq_prepare_tx_stop() waits up to XGBE_DMA_STOP_TIMEOUT for
   TX queues to drain, but when link is down, hardware will never
   complete the pending descriptors. This causes unnecessary delays
   during interface shutdown.

2. TX queues remain active after link-down, allowing the network stack
   to continue queuing packets that cannot be transmitted. This leads
   to resource buildup and complicates recovery.

This patch adds two optimizations:

Optimization 1: Skip TX queue drain when link is down
  In xgbe_txq_prepare_tx_stop(), detect link-down state and return
  immediately instead of waiting for hardware. Abandoned descriptors
  will be cleaned up by the force-cleanup mechanism (next patch).

Optimization 2: Immediate TX queue stop on link-down
  In xgbe_phy_adjust_link(), call netif_tx_stop_all_queues() as soon
  as link-down is detected. Also wake TX queues on link-up to resume
  transmission.

Benefits:
  - Faster interface shutdown (no pointless timeout waits)
  - Prevents packet queue buildup in network stack
  - Cleaner state management during link transitions
  - Enables orderly descriptor cleanup by NAPI poll

Note: We do not call netdev_tx_reset_queue() on link-down because
NAPI poll may still be running, which would trigger BQL assertions.
BQL state is cleaned up naturally during descriptor reclamation.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c  |  9 +++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f1357619097e..b7bf74c6bb47 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3186,7 +3186,16 @@ static void xgbe_txq_prepare_tx_stop(struct xgbe_prv_data *pdata,
 	/* The Tx engine cannot be stopped if it is actively processing
 	 * packets. Wait for the Tx queue to empty the Tx fifo.  Don't
 	 * wait forever though...
+	 *
+	 * Optimization: Skip the wait when link is down. Hardware won't
+	 * complete TX processing, so waiting serves no purpose and only
+	 * delays interface shutdown. Descriptors will be reclaimed via
+	 * the force-cleanup path in tx_poll.
 	 */
+
+	if (!pdata->phy.link)
+		return;
+
 	tx_timeout = jiffies + (XGBE_DMA_STOP_TIMEOUT * HZ);
 	while (time_before(jiffies, tx_timeout)) {
 		tx_status = XGMAC_MTL_IOREAD(pdata, queue, MTL_Q_TQDR);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 7675bb98f029..fa0df6181207 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1047,11 +1047,29 @@ static void xgbe_phy_adjust_link(struct xgbe_prv_data *pdata)
 		if (pdata->phy_link != pdata->phy.link) {
 			new_state = 1;
 			pdata->phy_link = pdata->phy.link;
+
+			/* Link is coming up - wake TX queues */
+			netif_tx_wake_all_queues(pdata->netdev);
 		}
 	} else if (pdata->phy_link) {
 		new_state = 1;
 		pdata->phy_link = 0;
 		pdata->phy_speed = SPEED_UNKNOWN;
+
+		/* Proactive TX queue management on link-down.
+		 *
+		 * Immediately stop TX queues to enable clean link-down
+		 * handling:
+		 * - Prevents queueing packets that can't be transmitted
+		 * - Allows orderly descriptor cleanup by NAPI poll
+		 * - Enables rapid failover in link aggregation configurations
+		 *
+		 * Note: We do NOT call netdev_tx_reset_queue() here because
+		 * NAPI poll may still be running and would trigger BQL
+		 * assertion. BQL state is cleaned up naturally during
+		 * descriptor reclamation.
+		 */
+		netif_tx_stop_all_queues(pdata->netdev);
 	}
 
 	if (new_state && netif_msg_link(pdata))
-- 
2.34.1


