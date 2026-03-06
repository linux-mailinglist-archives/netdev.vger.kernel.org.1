Return-Path: <netdev+bounces-264749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBiyIlK4qmkiVwEAu9opvQ
	(envelope-from <netdev+bounces-264749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:19:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD021F8EA
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451B9305DA46
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5734A794;
	Fri,  6 Mar 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hNBONUgN"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B873346BE;
	Fri,  6 Mar 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795875; cv=fail; b=DJCok9usTVQCrh3ZDUS4xtLO8g+Dtbdi/SOAHebiobtegkwESgerzpSqNz1E4ErErgYCDaVvPLZHND31BmY6mFQXR3GGdQTs0Tmq3TC2AqTSKkC1s3uuNTAIldLqnH6MpFwJJR1sMnI/XPWIyJogM/TaBD2jTh+aS36AqzkZ/MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795875; c=relaxed/simple;
	bh=k7A7FkC8cDVluwIlFS/sYDPcldWOpupBBLs6RZUMlNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IldxX0pkaoqRpdLHFNN86vn0A8inDZfWyWAJGSsWhXEV0rZqr+hGkI1bCiuMdzQbgy6FHXxTeyouBvH51X4Eg+VYU/evVXfhgNQlSXbbhx8vk8PGCkVMKjgvZT33uPUIz0CbwsuONTOynQs+UySDpewaJ92b4E1bLJLmjidExT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hNBONUgN; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItdJXHTF851xYawSeggTdpIqI2L9TxMG6JYMM2yft+138DF1p2MWaLPn+NU3rd630ESWAJnrWezOsyZybBgowK+eidLccHBdSQ5OuVaf0/zaxJXgm6/8QwN/Z+DG83oIQdStHEK2e+qc/K8cW7yNgy3kZSkS9f1mBHm1K+xXXd6SyNlX44E222lBcMPfmRa1qZ6zRqgVgTpOuJS62zQ/1YkPX4K6A5148lU040vmOioZSKECxaC/yYU0lOGhAA1zu2AQ3UEgEAJi1HJfPsU98ChOVgp1HMYU2R4NeRwpqQEgpaMqHLRg9XwaOsGzbZpbLRCzHY8v76CrQb+7UKEchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqESdwc0WWToIrnEWk465Ht0H2mb7Ghg7x8kRAehfT8=;
 b=TLqFZMeCSfGjKBHXCOaFmBTchIvDzI6QTDT0eWhO3hnPyOOmvfamRkNF7RJOYX9sQyMl5dKgA6WJjH93YIUxaj0UKZvLb+IZBOTq7kb7mY5KaSUERVPQL3sbabCGrc4UM4y2pd0J6SlF3vzEmMCWKWKD92WGj89OwKb65Hp8WRbEnu2NMzpELP8cZYRjMfCjPZDhxO2VejSs66cRjNDniaa/+IqM8z0AMpBmY54/GBmA2NPHsePnDLs8Kp3psyR4jYBr4ofZcgRAo/CGi+4ScagCh09Kl2zEMbuCMycA1ra6aLex72LCmn3qvM0XmGnjiuyLLayQPmiWuvCZ8CbJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqESdwc0WWToIrnEWk465Ht0H2mb7Ghg7x8kRAehfT8=;
 b=hNBONUgNa5jc08x4tQIQ9XCbDleiYpNCDsjepkxwqIWThUrbubDtAOPt5iHToBWGd52g25dkBb0dwbWuIN/t++d7Uv66w6mLy+LMu/AR1nAQGwuB2okH2e76t0NaSPkix70exR4dQ3SHor6smLbWIkDDBuPyEEqUYTijA7c30NI=
Received: from DS0PR17CA0020.namprd17.prod.outlook.com (2603:10b6:8:191::27)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 11:17:50 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::c5) by DS0PR17CA0020.outlook.office365.com
 (2603:10b6:8:191::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 11:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 11:17:50 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 05:17:47 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v3 net 2/3] amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
Date: Fri, 6 Mar 2026 16:46:28 +0530
Message-ID: <20260306111629.1515676-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
References: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: f1643aa7-d312-43c9-f527-08de7b720102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	8aR3Zs7eiVQPr+S2Rg5x7+ylkg45r33PiAMLTKDT3Y3J+JhTfDL0+kv0q1n4JbzWumyU97CWYZ1N/G80KdWENlXQRrrguYS/eVfo3Mv8etMS7VEKTek/lq7npd5lCIugiVBs7QeuOD5y1lsLr3pqtV/RWoeOYq0gytwx8agj7/S9a55m+3ezf6xoy7TcSP+0rwCzffaSWlN7YbmV9UoviXnsUOP3LEIjTbYeXmC57JczaSm5rfnjofKzyGJDYCtLrjPocGRWBF5/pODvwMdaILFnEpmg3o/Xx17RK3i33NOmlzs2sJKr90lIsTXV3zCaI6y3GAOzyCCQWoseA/n6dIyLVEwmta+WcVAWCBx2GdeRx2kcAJwKkAz4vNm3oYPDA1lZwUXnGcq5PNIkL+T4CMztINgqXDU1bVcnbT3GuXmTvq1ph+/czl34RlT2sQ8JJvmwBk8F20RPPHpYiuLkyvPF+mh42vPgxkHmESCqL1A9vDD7jlltOAspzBcqgI7186mYm61GHqgx4FsGaOdPj9q9h3LwW8tYDTNBuDsXJahM/amac76IPYJtHpqEUM7PYVZto+js+WSMhQNvfbvAFqf5jnd5ucGNgpws7vge0fRKlEiPFxgYWRzK31x/ho5oje76h9g5zbpUPCUNyQVYuhdAWvXSQwYoQszYtHSDeHbjK5an1TeAURntI/acxQ+H5tKDUv+CS72sbl/c566pi9jFIDF6FiHvqnalcHI85Qi+YLKBDJRkheWg4cZA/E9td+yJ1ZNraAFq3hcZ7TMw/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bNGRGZVM2aI6Xf6XX0D0cbfZfDpSwEZ8CjTyghaNLro1IsEHDasGkzlk1Gjo6Y5PcO1+uxP8itxvHA0hcLxaVZYn3YYWAcM5pIPPu/fh/PSvOjIof4pQzVUMyOC34QJopg+ziQ4b6IZVhyS1J6qVqj+XIXngmieNhFl1/OxSQNUO2QNQx6N1H7QOivclv6QeHTs3BSvoKpC46oAXqk9tfTHjDPY2YftziF/huVzMsxRgqFlx8O1hlvsTLcVIxi2wuuI1QYjcvjPImi+A0rKwtT3IFQHkoqTI7o7H2q5INVxnQS3bKKOLxYRJFUN9++yD8Rga/Rv/BBWX3fRMcfpl+QzKgDdJpA+iKjJ7sKOpKg210pWB3lqAJ6QkjR8SU9IjTRIMdrQ2UHbUOzeRdozNS1And7zEpSWGfMMLyITAQeJWTd+h95FwYm1XqAFtthVI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:17:50.5857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1643aa7-d312-43c9-f527-08de7b720102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
X-Rspamd-Queue-Id: 04BD021F8EA
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-264749-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

The flag tracking the data path state is synchronized with hardware
state in xgbe_start() to prevent stale state after device restarts.
This ensures that after a restart cycle (where xgbe_stop disables
TX/RX and xgbe_start re-enables them), the flag correctly reflects
that the data path is active.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - Change the data_path_stopped flag to boolean type
   as it is only used as a true/false indicator.
Changes since v2:
 - change the data_path_stopped flag to be cleared in phy_start() to
   ensure it is reset on device restart

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  4 ++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 63 ++++++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 8b79d88480db..39da2f811858 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1277,6 +1277,10 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	hw_if->enable_tx(pdata);
 	hw_if->enable_rx(pdata);
+	/* Synchronize flag with hardware state after enabling TX/RX.
+	 * This prevents stale state after device restart cycles.
+	 */
+	pdata->data_path_stopped = false;
 
 	udp_tunnel_nic_reset_ntf(netdev);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index b330e888c944..59a074ed312a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2017,6 +2017,48 @@ static void xgbe_phy_rx_adaptation(struct xgbe_prv_data *pdata)
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
+	if (pdata->data_path_stopped)
+		return;
+
+	/* Stop TX/RX to prevent packet corruption during RX adaptation */
+	pdata->hw_if.disable_tx(pdata);
+	pdata->hw_if.disable_rx(pdata);
+	pdata->data_path_stopped = true;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "stopping data path for RX adaptation\n");
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
+	if (!pdata->data_path_stopped)
+		return;
+
+	pdata->hw_if.enable_rx(pdata);
+	pdata->hw_if.enable_tx(pdata);
+	pdata->data_path_stopped = false;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "restarting data path after RX adaptation\n");
+}
+
 static void xgbe_phy_rx_reset(struct xgbe_prv_data *pdata)
 {
 	int reg;
@@ -2826,13 +2868,27 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
 		 * declare link up
+		 *
+		 * Note: When link is up and adaptation is done, we can
+		 * safely re-enable the data path if it was stopped
+		 * for adaptation.
 		 */
-		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
+		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done) {
+			xgbe_phy_start_data_path(pdata);
 			return 1;
+		}
 		/* If either link is not available or adaptation is not done,
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
index 4333d269ee84..7f125d2b20c2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1266,6 +1266,10 @@ struct xgbe_prv_data {
 	bool en_rx_adap;
 	int rx_adapt_retries;
 	bool rx_adapt_done;
+	/* Flag to track if data path (TX/RX) was stopped for RX adaptation.
+	 * This prevents packet corruption during the adaptation window.
+	 */
+	bool data_path_stopped;
 	bool mode_set;
 	bool sph;
 };
-- 
2.34.1


