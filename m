Return-Path: <netdev+bounces-264175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNxkJfYGqWlW0QAAu9opvQ
	(envelope-from <netdev+bounces-264175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31D20ACF1
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 400363042D64
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2D1A9B46;
	Thu,  5 Mar 2026 04:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iLkCRess"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339F4204E;
	Thu,  5 Mar 2026 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685042; cv=fail; b=EmRQmBQhLgN+eqMGjfAEp4CXZCwzxhAbIfk1bYA22ZszoQtpEJMb8G+bkc0Jcz9g4tj3iMXfO2R/g9ZvlvKNcCujeqLDMwh/4pwnZVxBNmdd7OM8jLN3ZBiJ+E9pILWDPZt6jMVIs9doVQ4WzI5IFJti3jAD6KW5BKdbgVlJQRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685042; c=relaxed/simple;
	bh=xfGF7REHJv4xruYlX16/MirQ27yaI0+3sfhG4TrHkUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUkNvAo2nRBIXG7oYHqAeVXflouiMoDHE/LQkjO4TOvvvEDgJCyfBzcUdcx+C7IzKyB8b2GSlNryoMhmY1DOeh3f0wckwojbA6T6IxoCJjLkvRX9AMnaDGirzVr0a9kb3II2FA74irHI8zesc0nBz3y0GL4VlVKMQK1bsprIkhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iLkCRess; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBID3BGVk4VupnPxMHeQtOdTvgu1otos3BBYz/kMvRiCQwj7d/CBKB/nd1jQMq8jtWW3Psq6KTE1iDs9naqg6bZ0lfIzPfgeeG99nv7PXjad8AIpuHgbpjN+BMylQJVU6qprxPDPKCiMAbeuulIdGPXVCL1f5389cfWF7WEaipA1tmfo5Q7VeDFpz+1K/iL/xSfJYmPFGlx5CEEAe466iHgkGJsT1mzztI8UqtKHaugmP0Get10luFhvPgZCKz9e/4Yu+l3uBYtphxCezI+dH2ODJeML76/gVYGdYtuxJFo2q1sfM6n2B9xuIVi1wlYGT2HEORxI04PYEOhk2IXSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rzKqtx61jFvZl04VWR7Ek/6LmXAcZhbyvzd2dIpHGY=;
 b=jH+UauYaVzKSgGikRXdZJ/5PWmJc92+AzE+Qf7dZd2ANappoZnbfMk25hp9kHZmZXod754fG/6DMJBlLrv7RpRhMtrV+I0+Z+g+u5s6y/XV0wA9NbJA7RgDO2+JY5ZugkECYqk2Hz+PT+ieHKIKuYv8tXoUhpC2AKYES1F469qCDeOfAd3ms+rhMXbZ7Ku3RDLU69jeNuI/L+KTt+Ft4XLf8Uqhc8c4BxePvoGggoFNbON7zKRdQT3cLlxZp0WOK86Ptvc9WxS0R7e58/bahLOyPPpHpwZLOoIdqGSBvgaNX8C1ER0LFQfqRc4zeC+61OZwQDyfN+BtP2TXiBEoV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rzKqtx61jFvZl04VWR7Ek/6LmXAcZhbyvzd2dIpHGY=;
 b=iLkCRessWGlgmXO9qkbIcVmxsrvJWbbVgbSKuLp1kHGEXmBsPQRo1zllDmjx1V8I+EgbCsUgcKMcA+6bHYXZJlo0Qu6ZAjs9HVl9pIAfzgU3dJahg5sh6qJ0pGdtzv5z5oi5v0TsmjrY4/sNkV+3m9YCu+y0cR7MoBIlrxJZUb8=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 04:30:37 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::84) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 04:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 04:30:36 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 22:30:33 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 net 2/3] amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
Date: Thu, 5 Mar 2026 09:59:51 +0530
Message-ID: <20260305042952.835926-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305042952.835926-1-Raju.Rangoju@amd.com>
References: <20260305042952.835926-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1f5bec-9585-47ce-4f0e-08de7a6ff2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	tIiC4JMIKoQUc+prJnrUiAg4NPsHp+QRlM+PzFKJaoZIIcOj2rzuJHdDzwmaiYx6AGebVvsalo9f0cyVsdJdXR1my7rmmov+Gu2MTXLFDRMWwAUCa8mx5dMZ4QuAWbESxscuSv9x9SmfmU8tZnpRuFsooXPtsaekRkjAsIxGX//yz1xrGn8jwpNJJxBsfmY2loR6Ak6+Fr2YNolEGJQASNXW3ZRn3u1og3vM07+ljzQKUWY5AWCYs011q0PeRtnlgEoVxDC0KvXCq683eqpZmDNQ/dIHWiEhJ+DqtmGXU5VAhz2tjaR68Z8RYaKarh9izzodfoMAHUEyhKeEDqf6h4abWzLBKygGaMymz+gpByXe2kuETBrcMVjlEzH7eGyTd6lphK+tqXGeEuGq+sFFnYf5Ysgqrl2aR4pTeYQz70ONkpOocCEhBUJ9+r1BR6jJWt8DSS7G6/HbOKn2yJGVvkm5wPPGrR7hwHTwT624ykI8jKVMh++GIiLc9Mi5k7AzylFOPFM/PdimFZIA6kDUpsxm66dJwKdUA26yv8vwWdGF1xV0CYV6PZX1mkfh+tchnbgwBbLNOlqCNau1mZ+sIkE4lbcUJvfhFPwn/h6aCKZz+Z59AWq57oELUgZsWr8xeo7tCycmDsu7r4HYN5rwqfN8M2QM4ebEEzlNmPHc/r7eD3AE5d5HF3oYfC04NbKST6dGYfjAcJcjSJvN4P2FhZieCuUg4y/rbxFCHnXRa0nFYzEIBHrtywJZahNBJ2vh1f6Oze/YsGwUl7mFAMDgJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RheYWDvuTO68ww4/o/cc41KlUg9auZZ/2e4csQ4cwatkMArveTYuWYnjGZG8vRb7EDBwSSKztVhuvXXGtLnfNAdnGnSqJ3lhns/PjP2VUnWhRvhYvYnfsG9nYQ/INk0oDawdPi8JVic3Oll/zQIFH99teiVuLugIph4EcKy/832NyIWxKR8cEI+KKiT776oI01TlYehOJ2P+RpMqz5GojQ9c6nvZlD8DvpFo4dbd66ok0x3XAL6HE3gcVeSf2ERolOovqz3Th47FLNgJGLa5eZfEL0nUMfPoJSBrtP+mOLBxYdVg6wwgjU6fGfBNRwuSsv1g+K8HkHdHm5HuvU0tc6uNRijzuN/5Arnjr1WfusUBE0ep2+h+PrCrmyVnv0FkYCjofiMPSDuUycpBW94zP7qwebDHaFiGwl73w80gtdp7eGfeyW1uSkCgP+gmz8LO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 04:30:36.8482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1f5bec-9585-47ce-4f0e-08de7a6ff2ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
X-Rspamd-Queue-Id: 0E31D20ACF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264175-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When operating in 10GBASE-KR mode with auto-negotiation disabled and RX
adaptation enabled, CRC errors can occur during the RX adaptation
process. This happens because the driver continues transmitting and
receiving packets while adaptation is in progress.

Fix this by stopping TX/RX immediately when the link goes down and RX
adaptation needs to be re-triggered, and only re-enabling TX/RX after
adaptation completes and the link is confirmed up. Introduce a flag to
track whether TX/RX was disabled for adaptation so it can be restored
correctly.

This prevents packets from being transmitted or received during the RX
adaptation window and avoids CRC errors from corrupted frames.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - Change the rx_adapt_data_path_stopped flag to boolean type
   as it is only used as a true/false indicator.

 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 61 ++++++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 457d6049291f..880949051c3c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2017,6 +2017,50 @@ static void xgbe_phy_rx_adaptation(struct xgbe_prv_data *pdata)
 	xgbe_rx_adaptation(pdata);
 }
 
+/*
+ * xgbe_phy_stop_data_path - Stop TX/RX to prevent packet corruption
+ * @pdata: driver private data
+ *
+ * This function stops the data path (TX and RX) to prevent packet
+ * corruption during critical PHY operations like RX adaptation.
+ * Must be called before initiating RX adaptation when link goes down.
+ */
+static void xgbe_phy_stop_data_path(struct xgbe_prv_data *pdata)
+{
+	if (pdata->rx_adapt_data_path_stopped)
+		return;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "stopping data path for RX adaptation\n");
+
+	/* Stop TX/RX to prevent packet corruption during RX adaptation */
+	pdata->hw_if.disable_tx(pdata);
+	pdata->hw_if.disable_rx(pdata);
+
+	pdata->rx_adapt_data_path_stopped = true;
+}
+
+/*
+ * xgbe_phy_start_data_path - Re-enable TX/RX after RX adaptation
+ * @pdata: driver private data
+ *
+ * This function re-enables the data path (TX and RX) after RX adaptation
+ * has completed successfully. Only called when link is confirmed up.
+ */
+static void xgbe_phy_start_data_path(struct xgbe_prv_data *pdata)
+{
+	if (!pdata->rx_adapt_data_path_stopped)
+		return;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "restarting data path after RX adaptation\n");
+
+	pdata->hw_if.enable_rx(pdata);
+	pdata->hw_if.enable_tx(pdata);
+
+	pdata->rx_adapt_data_path_stopped = false;
+}
+
 static void xgbe_phy_rx_reset(struct xgbe_prv_data *pdata)
 {
 	int reg;
@@ -2826,6 +2870,10 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
 		 * declare link up
+		 *
+		 * Note: When link is up and adaptation is done, we can
+		 * safely re-enable the data path if it was stopped
+		 * for adaptation.
 		 */
 		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
 			return 1;
@@ -2833,6 +2881,14 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 		 * retrigger the adaptation logic. (if the mode is not set,
 		 * then issue mailbox command first)
 		 */
+
+		/* CRITICAL: Stop data path BEFORE triggering RX adaptation
+		 * to prevent CRC errors from packets corrupted during
+		 * the adaptation process. This is especially important
+		 * when AN is OFF in 10G KR mode.
+		 */
+		xgbe_phy_stop_data_path(pdata);
+
 		if (pdata->mode_set) {
 			xgbe_phy_rx_adaptation(pdata);
 		} else {
@@ -2840,8 +2896,11 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 			xgbe_phy_set_mode(pdata, phy_data->cur_mode);
 		}
 
-		if (pdata->rx_adapt_done)
+		if (pdata->rx_adapt_done) {
+			/* Adaptation complete, safe to re-enable data path */
+			xgbe_phy_start_data_path(pdata);
 			return 1;
+		}
 	} else if (reg & MDIO_STAT1_LSTATUS)
 		return 1;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 4333d269ee84..450ebce94347 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1266,6 +1266,10 @@ struct xgbe_prv_data {
 	bool en_rx_adap;
 	int rx_adapt_retries;
 	bool rx_adapt_done;
+	/* Flag to track if data path (TX/RX) was stopped for RX adaptation.
+	 * This prevents packet corruption during the adaptation window.
+	 */
+	bool rx_adapt_data_path_stopped;
 	bool mode_set;
 	bool sph;
 };
-- 
2.34.1


