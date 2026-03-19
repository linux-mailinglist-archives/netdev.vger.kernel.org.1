Return-Path: <netdev+bounces-269544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEodJ8EnvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69FD2CF02D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 334C93077A9A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06063EE1F5;
	Thu, 19 Mar 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tRz86PEB"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAF3ED13F;
	Thu, 19 Mar 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938030; cv=fail; b=N8W1qWxcdj10tP6VyXJ6QAUy6VAVeaFln27ROXesOIkoErXgMw9GXJq2et7Hj0I/pHs+zlkUGXYSl4plQt9BobV8SB5YSg0/fq2LXCbIEMsv6xvtU3G0tezmJ2NLrVEk+TA88RCI6i+EnTWnpuxetC/DUmK9jLDu+g7/YCTZ5QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938030; c=relaxed/simple;
	bh=eCUxtM5FqvzQDqmro94RyRcsJOYAr+LNrUVPBX4/2Ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQk1fJvgBMZZOgy9eenqZjnD098AccL6/7ACopGUtUYWdJOJECcurMUhkz2zCb3EOZQqgneLRRiFfxZl1PH+IMzyL+GsB6JZuA6VuHkPMP9mC/ogmoExEmtI6y8zV5rGf696rPm+LpDG2O5qqBwewjbqN0QVumSZXo845Hbbkhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tRz86PEB; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s48czP0db0q6iLw2WsEA9s7Qc1U7bEOs3lNp/G8Q0VCnmu04La/UPClLgS382X7Tz04qUNPdoH9I9cYNlOQRki4sM7uYzPf1x+5+uvMN83nM8psTQvKfW1dymBUzTipvKi6xCRmmwPYU4wCdc/um0wEScsZ1+1Qtydo5Bo3uX2yA4kQAph1AVltXmOQ726+HTEatdoQveZb6uirKbMhf0v7MhSGi/6UGCX8Z7aTiiME48PPe3HdsKd1qaP86vXgrxJ6ky1HgG03z99DUU7qtXf5GTWhc6J9gX8StubCiU+cv81KjvYZqC9S7g3hkuF1b5boD9ukC2c1DSVom3tnWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPA7GXa1M8456vwl6JOknyjUmuPRoj7F1evgbsbQHOQ=;
 b=r3sWt9f5dB4mnyFhHcOS5Chim70C3LvR3Il01aWSUvaA8DHY2TujvpIdZw0QLVcAq1BkwcSFxnJfUEcmWdRkzjQVeXF7qNU4lcw03UMEOQvoRW7U4vhaZqI7G4rKWYTefELM8iz99cWWp6pTVnUPaUmwIexzsVzSdwcuBXuA4yKQ6ETJTKZBTCk/JPmyExuk14ZxM56C5ZN1vT4QeJT6CTPoI0O1Bdn5Yi8f00fEc/sKgdZAAFZ4Whbcp2QRUatzeT9yctqPf69Mv219OY5TqxXU7yzTm8LUUxKkB1vKBSTgp+ENdHUF+bLqs52ibbeWsp4ZOnKcxe/mggBmt5RIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPA7GXa1M8456vwl6JOknyjUmuPRoj7F1evgbsbQHOQ=;
 b=tRz86PEBzjerpPbIen1Dc9OedVGL+pM/NItLuuIgDYf3SkJdnG3cK2xiVveQKeACL3Nnls7DQvrBlLptwHJQwki7jGavUYiJbaxkH7WZhAhsvyLSbuYy7TcetHRs+hSj7+gYlMRYkaSA6QpMbqYYSyexPwZLjNNFgrSn+K8gveM=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Thu, 19 Mar
 2026 16:33:37 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::ec) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.30 via Frontend Transport; Thu,
 19 Mar 2026 16:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 16:33:36 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 11:33:33 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH v3 net-next 3/3] amd-xgbe: add TX descriptor cleanup for link-down
Date: Thu, 19 Mar 2026 22:02:51 +0530
Message-ID: <20260319163251.1808611-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
References: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1447bb-e6a7-4d6e-fd74-08de85d544bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+rpNIyjUuWMYyt8yQJjt7C/nkSkU+wgRcwsw0/zPmQ1w1GQKijrGYxHAA2FfNriItJBNqF4g0TSXULxy4g2VLWPbByoXQfHIaXLR+M49ipv2Wa+DMYNaC3Bh7EY3rlD/vnZx9QE+sYc1M2HNkeFNawhbRUr6DaXJnVLlSDHjFiSr9VS+PzzXfAjUJIRRQMs0UIkIW9hpZpOCDey1Ic979Wx4yTCX9s2+v4yeV3JPe+/XT+cGUDt7ycLyst04sazZ+szXSLv9GzUbTmA7GU+an9TKSMARziPqx/8TzAEvjEkmTDQKtuUwNXGB4g+9m+UfwQAfOLR66KbXZnX9hN3kPRMqLuIlS/sqkas89XlFbwWg5AJoz/EP1RNB1awaB0ADpg4sixGux//CQznrYnz7bbzftcSioDggWzDzBE+B6w9Qn8OdegOug+W+RVly4//VPPhxKhz2kmg2s6McBFZZpvd8IXFm0InyRhbh5iSxn+L4/ApN9YqK4f8xUnn/8CNRFrZBaNeJF7u0Ed4W9Ksy1FRBfPa9ckV0RaGWkh7f8UjMbId//wREgpFjGuM/UsK7ifoQIvXyi5YVxDoHG0o3sPp/wl+yENJ3zLQW9vAz6sOD6dVqzkcLaoLASFRA0I7l/zwzXNtpsH7LbugN82ALooUEuv7QHYRFaujC0pcROwVZw2OFZLsJ4384HhkEhqTA51h8h+tNIrh6rlTM+5uvWOoQCDaWSoYl11K3nJlKJyPOjkFC/YGOZNgrCvIFgywkl38m1ARhTT7fwe05IxLyPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iiIHsjfi6i7ctwOuiNFAWD4kWq5TJXkZodYVZy6pyLqG8n+ucCrV1xPd/Q9rFa6Z0wfnjHAJyHOx2ur6aV+f/f3Vjzqhbdk1ojr6XcKtFCA+1Z5dana+NqErm8wW9O3c3UgLMEKvK9ePOAhSFppr2mrIvIA6U/sWCP8smVpAAz50E4kWOnW6g7cxpi70TM1ePps8hHIXAG31nasdMROa5pTqvgJbn8gxYZiDp3g7V/t80oqvHQsNVBK3VuLWHs6e9LM9Tq8u0oq7AfB7qdtQl1vxbv0rFHgf2oyN9vT3UfYKP7GHxcIGfBqtKrbfazKylEvBqV3yIS/K0STyIHFNBEXB+EGVKOyarj/ENMV5IriuXpYjtFcHXFC8JTDvt6xu51kQrc2VDJpOu4MwzAGq9zMi59s4wU+9jT0JLYrLZYn2+cR0/iCQ0yX0vwyjaVAs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:33:36.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1447bb-e6a7-4d6e-fd74-08de85d544bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269544-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A69FD2CF02D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add intelligent TX descriptor cleanup mechanism to reclaim abandoned
descriptors when the physical link goes down.

When the link goes down while TX packets are in-flight, the hardware
stops processing descriptors with the OWN bit still set. The current
driver waits indefinitely for these descriptors to complete, which
never happens. This causes:

  - TX ring exhaustion (no descriptors available for new packets)
  - Memory leaks (skbs never freed)
  - DMA mapping leaks (mappings never unmapped)
  - Network stack backpressure buildup

Add force-cleanup mechanism in xgbe_tx_poll() that detects link-down
state and reclaims abandoned descriptors. The helper functions and DMA
optimizations support efficient TX shutdown:
  - xgbe_wait_for_dma_tx_complete(): Wait for DMA completion with
    link-down optimization
  - Restructure xgbe_disable_tx() for proper shutdown sequence

Implementation:
  1. Check link state at the start of tx_poll
  2. If link is down, set force_cleanup flag
  3. For descriptors that hardware hasn't completed (!tx_complete):
     - If force_cleanup: treat as completed and reclaim resources
     - If link up: break and wait for hardware (normal behavior)

The cleanup process:
  - Frees skbs that will never be transmitted
  - Unmaps DMA mappings
  - Resets descriptors for reuse
  - Does NOT count as successful transmission (correct statistics)

Benefits:
  - Prevents TX ring starvation
  - Eliminates memory and DMA mapping leaks
  - Enables fast link recovery when link comes back up
  - Critical for link aggregation failover scenarios

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
 - remove the stale function xgbe_reset_tx_queues(), otherwise it would
   result in undefined symbol during linking.

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  4 ++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 77 ++++++++++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 43 ++++++++++--
 3 files changed, 108 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index c17900a49595..66807d67e984 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -330,6 +330,10 @@
 #define MAC_ISR_SMI_WIDTH		1
 #define MAC_ISR_TSIS_INDEX		12
 #define MAC_ISR_TSIS_WIDTH		1
+#define MAC_ISR_LS_INDEX		24
+#define MAC_ISR_LS_WIDTH		2
+#define MAC_ISR_LSI_INDEX		0
+#define MAC_ISR_LSI_WIDTH		1
 #define MAC_MACA1HR_AE_INDEX		31
 #define MAC_MACA1HR_AE_WIDTH		1
 #define MAC_MDIOIER_SNGLCOMPIE_INDEX	12
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index b7bf74c6bb47..2de974213090 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3276,28 +3276,83 @@ static void xgbe_enable_tx(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE_BITS(pdata, MAC_TCR, TE, 1);
 }
 
-static void xgbe_disable_tx(struct xgbe_prv_data *pdata)
+/**
+ * xgbe_wait_for_dma_tx_complete - Wait for DMA to complete pending TX
+ * @pdata: driver private data
+ *
+ * Wait for the DMA TX channels to complete all pending descriptors.
+ * This ensures no frames are in-flight before we disable the transmitter.
+ * If link is down, return immediately as TX will never complete.
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout
+ */
+static int xgbe_wait_for_dma_tx_complete(struct xgbe_prv_data *pdata)
 {
+	struct xgbe_channel *channel;
+	struct xgbe_ring *ring;
+	unsigned long timeout;
 	unsigned int i;
+	bool complete;
 
-	/* Prepare for Tx DMA channel stop */
-	for (i = 0; i < pdata->tx_q_count; i++)
-		xgbe_prepare_tx_stop(pdata, i);
+	/* If link is down, TX will never complete - skip waiting */
+	if (!pdata->phy.link)
+		return 0;
 
-	/* Disable MAC Tx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_TCR, TE, 0);
+	timeout = jiffies + (XGBE_DMA_STOP_TIMEOUT * HZ);
 
-	/* Disable each Tx queue */
-	for (i = 0; i < pdata->tx_q_count; i++)
-		XGMAC_MTL_IOWRITE_BITS(pdata, i, MTL_Q_TQOMR, TXQEN, 0);
+	do {
+		complete = true;
 
-	/* Disable each Tx DMA channel */
+		for (i = 0; i < pdata->channel_count; i++) {
+			channel = pdata->channel[i];
+			ring = channel->tx_ring;
+			if (!ring)
+				continue;
+
+			/* Check if DMA has processed all descriptors */
+			if (ring->dirty != ring->cur) {
+				complete = false;
+				break;
+			}
+		}
+
+		if (complete)
+			return 0;
+
+		usleep_range(100, 200);
+	} while (time_before(jiffies, timeout));
+
+	netif_warn(pdata, drv, pdata->netdev,
+		   "timeout waiting for DMA TX to complete\n");
+	return -ETIMEDOUT;
+}
+
+static void xgbe_disable_tx(struct xgbe_prv_data *pdata)
+{
+	unsigned int i;
+
+	/* Step 1: Wait for DMA to complete pending descriptors */
+	xgbe_wait_for_dma_tx_complete(pdata);
+
+	/* Step 2: Disable each Tx DMA channel to stop
+	 * processing new descriptors
+	 */
 	for (i = 0; i < pdata->channel_count; i++) {
 		if (!pdata->channel[i]->tx_ring)
 			break;
-
 		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_TCR, ST, 0);
 	}
+
+	/* Step 3: Wait for MTL TX queues to drain */
+	for (i = 0; i < pdata->tx_q_count; i++)
+		xgbe_prepare_tx_stop(pdata, i);
+
+	/* Step 4: Disable MTL TX queues */
+	for (i = 0; i < pdata->tx_q_count; i++)
+		XGMAC_MTL_IOWRITE_BITS(pdata, i, MTL_Q_TQOMR, TXQEN, 0);
+
+	/* Step 5: Disable MAC TX last */
+	XGMAC_IOWRITE_BITS(pdata, MAC_TCR, TE, 0);
 }
 
 static void xgbe_prepare_rx_stop(struct xgbe_prv_data *pdata,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 6886d3b33ffe..2d6d00e3689b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2169,6 +2169,7 @@ static int xgbe_tx_poll(struct xgbe_channel *channel)
 	struct net_device *netdev = pdata->netdev;
 	struct netdev_queue *txq;
 	int processed = 0;
+	int force_cleanup;
 	unsigned int tx_packets = 0, tx_bytes = 0;
 	unsigned int cur;
 
@@ -2185,13 +2186,41 @@ static int xgbe_tx_poll(struct xgbe_channel *channel)
 
 	txq = netdev_get_tx_queue(netdev, channel->queue_index);
 
+	/* Smart descriptor cleanup during link-down conditions.
+	 *
+	 * When link is down, hardware stops processing TX descriptors (OWN bit
+	 * remains set). Enable intelligent cleanup to reclaim these abandoned
+	 * descriptors and maintain TX queue health.
+	 *
+	 * This cleanup mechanism enables:
+	 * - Continuous TX queue availability for new packets when link recovers
+	 * - Clean resource management (skbs, DMA mappings, descriptors)
+	 * - Fast failover in link aggregation scenarios
+	 */
+	force_cleanup = !pdata->phy.link;
+
 	while ((processed < XGBE_TX_DESC_MAX_PROC) &&
 	       (ring->dirty != cur)) {
 		rdata = XGBE_GET_DESC_DATA(ring, ring->dirty);
 		rdesc = rdata->rdesc;
 
-		if (!hw_if->tx_complete(rdesc))
-			break;
+		if (!hw_if->tx_complete(rdesc)) {
+			if (!force_cleanup)
+				break;
+			/* Link-down descriptor cleanup: reclaim abandoned
+			 * resources.
+			 *
+			 * Hardware has stopped processing this descriptor, so
+			 * perform intelligent cleanup to free skbs and reclaim
+			 * descriptors for future use when link recovers.
+			 *
+			 * These are not counted as successful transmissions
+			 * since packets never reached the wire.
+			 */
+			netif_dbg(pdata, tx_err, netdev,
+				  "force-freeing stuck TX desc %u (link down)\n",
+				  ring->dirty);
+		}
 
 		/* Make sure descriptor fields are read after reading the OWN
 		 * bit */
@@ -2200,9 +2229,13 @@ static int xgbe_tx_poll(struct xgbe_channel *channel)
 		if (netif_msg_tx_done(pdata))
 			xgbe_dump_tx_desc(pdata, ring, ring->dirty, 1, 0);
 
-		if (hw_if->is_last_desc(rdesc)) {
-			tx_packets += rdata->tx.packets;
-			tx_bytes += rdata->tx.bytes;
+		/* Only count packets actually transmitted (not force-cleaned)
+		 */
+		if (!force_cleanup || hw_if->is_last_desc(rdesc)) {
+			if (hw_if->is_last_desc(rdesc)) {
+				tx_packets += rdata->tx.packets;
+				tx_bytes += rdata->tx.bytes;
+			}
 		}
 
 		/* Free the SKB and reset the descriptor for re-use */
-- 
2.34.1


