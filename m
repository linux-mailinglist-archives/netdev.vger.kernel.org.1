Return-Path: <netdev+bounces-208235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 194C5B0AA76
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9BFA482E2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4E2E6D31;
	Fri, 18 Jul 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DOxp48RG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9232DAFDD
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865048; cv=fail; b=H7Rt5qS6sbEYbU1wJSFxdNRgg7udM/+xiwSR+5Yv5NZzslT+qB4szjGmo3cCspzjsjclyrOewmSvFnYlpjdjukSN8OwkqBaWJ9VUdcih9O5fvANM1xOa2PM3DWaqsdzqfQgB4RtsAOLUyp73fZOA359OCSSnpT8LXmKsFByQ/Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865048; c=relaxed/simple;
	bh=pxtTFWqj3gOoKpLGt23GQwvRVyRyx0VWSkrtqH4zPxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdxpYIZiUqTlM5nMb4dynNYeauSIcW030OSIjLfwEFVF6unmjCiYOt6Wtuo5reoENWV8A+EQ4wlW+MlP3C00X1Uo4WGc9iLe0kKI2YN5XQ+9kbHsG9lFwbbOLS2skDaJob6uL1RWW90IaRNwAXrSkxoDRZvRQ/e8kHRD8MxWovg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DOxp48RG; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV8HohI4hV2lICi6mCaik5o5comcE4Eg8BQgzvk00TwuN8zjgBx2vHHnh5zuV3YEJlec2PEZxmovCoWk1OxDhVxHnz6pL3DZuB8OLzsVULmAlSNwd4xOdUYBCJ2eb04Ly4F6HKob7fCIkqsJZwc2nim0g9hnyxvghgEkylxA/uvoqhJl4wbPTSlAoNtkz65QqMU8kE4zjO9yzf8mj07jHezfojj6nhT/3hfLskAJ351tMkQ/U0aLxNKWutBCIUmjGPCNkxO8lx2k+z/13vFUPndCotMD6nyVLUmODjwO49GqfIy18mHZfS+GU6bs/1JFF42Vwp9n9inC2JEcVG2ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCLiD8iSfeWYr7XL5n/7Vyyrt1eLZEJIE5gcmBrEtZU=;
 b=Ede2aY1HqMezl0Ojp4iwWCOBGreQht/95ztl9dr8hqi6OWoCG/1znFuKTq1JLmX6GktnRxU/07/XffIQgAIRsxsI3zRb7V+1G2J9mELPc7gcCr+VazcCFe7ELl75qJC2gyCcYYeM3MnEfZfV3oZPn4tkizK1/6G6oIt+HpA37OfC0uoWpvxQJlCK8Cgpd4V9M1cTjFs70LupJ2TnS3EoXd/s7VWN83BaQjDc5eLflh8Uq+/rAJ9MGNJIxbqGlavd6pJHQXafqNnYDjKgCU/ZLowqL84ciMGTnKcFQUbPpZ3YufgIFXqMkvl8c7umZAZRDHVb/h2m8Dg1JDa3XATF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCLiD8iSfeWYr7XL5n/7Vyyrt1eLZEJIE5gcmBrEtZU=;
 b=DOxp48RGOaFUPW/yJBe/mkyyQfkuqvHN0wyjlqhH8HMu2EkRteTXgkebNBjtJCaXoMVRN7uVePsmGF1EHiRRhrWU0srXLR/Ev85XWXn1kIAB5Nkw8UaRnpJmSNzhYkrOV/sGAhSQP5Aj2fR25kCA30SQobOOUKvt4G+rc8KxqJI=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 18:57:23 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::a9) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Fri,
 18 Jul 2025 18:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 18:57:23 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 13:57:18 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 2/2] amd-xgbe: add hardware PTP timestamping support
Date: Sat, 19 Jul 2025 00:26:28 +0530
Message-ID: <20250718185628.4038779-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718185628.4038779-1-Raju.Rangoju@amd.com>
References: <20250718185628.4038779-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6279ee36-70f6-4459-139c-08ddc62cee11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?srkAbcA9HLGF6hnkBxRWlbLgDeYGbV7KPJgdg/Q2LpIPQHz159S9wlu7qkrI?=
 =?us-ascii?Q?hGTUNHMp+E5bYavriKJtgurawb1okDO5I/uwYbu2fnzw3gHqLAMYPPSW15yf?=
 =?us-ascii?Q?z5nNUvSz3BRN0woKUuwvHyvODMsjdOoWuV9VNdatVNBLtu214PgM9Vf2xE7Y?=
 =?us-ascii?Q?tQutUta67drU3gYKcidzdHHN9jzRCSIzUUoT9YYhShr9fWzclaptQn47k9YJ?=
 =?us-ascii?Q?Mw0MMSSnQy7eovNcr70FlnLCqefM9mmbNG5QaVY2pRgL6WAZFlEGHVPoiAr+?=
 =?us-ascii?Q?+B16P8dNdzT2TUN9b1/84boKhjgEegyz4TQTBXulgesrXA/IACLj+leIW9pB?=
 =?us-ascii?Q?GRC9kUXw6bQRoiP2D+EYfAIjYIVtLR11A+ayRu2QUrIX/vAq/x0dSAESHW7r?=
 =?us-ascii?Q?WthlBsS38XPve+bdGdyMPdY3WurH3UatRN3HP1DSDpXRYQh93PDLIfewdxGE?=
 =?us-ascii?Q?yUg5FGJBG0hJmiPEcIemMeNTZmCUC8VtW2bil1pi6xsx6ZIfRrINPJPAPnq8?=
 =?us-ascii?Q?nYehcjxN9fgVvy5y02JLCr2O95MU79AJtr0tNz/DMETe2netBgiyBIe9RCYq?=
 =?us-ascii?Q?iDAGVPfrX0QywBgJnBBtas4VNCJH+AWi+chipVPVrj8lKy+kSAkqR4gHek4n?=
 =?us-ascii?Q?FnFN4YojHN0B1QUYmWlsX44RvHMpZOUGDKdKReRRpym9bV1QrHCxnvkGiQ0s?=
 =?us-ascii?Q?XzDhVWq+l5yQm98ZNLY/UW/XDUs1jT8BF1wT4FOJ2E0KTsCr1JhnpR9spaOq?=
 =?us-ascii?Q?E7+d61FvpTDWZhk7Hgam7KJF5iUSTsCUC0hlbtX4UI0KuZH5zl3k8x4VPAMw?=
 =?us-ascii?Q?2GZm+CtlSqkvvAv+ExTp2lIAeXP8SBe4j3Ad03hOHR9jxEINfltMkQPHOGdT?=
 =?us-ascii?Q?0ZArvgfJx0TGfXWzo/HS0YLp1U/6WTrLqiPP4cDk3aub8V90zzH37KFO+VoG?=
 =?us-ascii?Q?oNM1DVvuba7PNmndM6qVaGE8qVhlZPzGo69ODBpJOoL0iSA1dNapgC1ohCPZ?=
 =?us-ascii?Q?+j125dd5lrrQDN53uLkqggEP8XJsFwj9DSWcktXvUx2MdKFkJ4+pr3DgOtvP?=
 =?us-ascii?Q?m53COJaQxqfmMfX1nnWRaZ/9DLoZL/ERboVGfduc7tI8M+8xJuyVpUyxaoNR?=
 =?us-ascii?Q?K5xC7qYa/Kk45Bsg1400Ln0CR7IB2Z5xsa3JafyGu1mcuBxzF6fkpvdLwfGt?=
 =?us-ascii?Q?/1N87sXL7nFQSgLnVGGYIT6W+7ALMk1thHMdaRBLCTEx1F/2KF8BAVQikWkk?=
 =?us-ascii?Q?nJD4A/L4zKhPKpJmDuAcUJ9bbqtnJKXa10NYJouaOoKUeE8TgAY1cDjXEGXf?=
 =?us-ascii?Q?CEdYe1Cf5+cCYwcHzhU/IpWA7tcb8Fqh1E/pjqiPt4c0wrr4Ey4AOp9xn/ur?=
 =?us-ascii?Q?9qWiOji3dPMJ1EMUB96VH5mEs9xlGnJ58Co9G6wDEhN00N2xZh3YbXxfWCL6?=
 =?us-ascii?Q?GA3/vqBDQoKiUD4IOKZXVVgpaJbwwkGGV97yf14jgL9uZvzrl1X2SdrheQn3?=
 =?us-ascii?Q?GSkBN6qVMpLxRvmsT1dB4Xd0mnb98wq3+u44?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:57:23.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6279ee36-70f6-4459-139c-08ddc62cee11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

Adds complete support for hardware-based PTP (IEEE 1588)
timestamping to the AMD XGBE driver.

- Initialize and configure the MAC PTP registers based on link
  speed and reference clock.
- Support both 50MHz and 125MHz PTP reference clocks.
- Update the driver interface and version data to support PTP
  clock frequency selection.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h   |  10 ++
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      |   9 +-
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c | 148 ++++++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c      |  73 ++++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  23 ++-
 6 files changed, 179 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index e54e3e36d3f9..009fbc9b11ce 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -223,6 +223,10 @@
 #define MAC_TSSR			0x0d20
 #define MAC_TXSNR			0x0d30
 #define MAC_TXSSR			0x0d34
+#define MAC_TICNR                       0x0d58
+#define MAC_TICSNR                      0x0d5C
+#define MAC_TECNR                       0x0d60
+#define MAC_TECSNR                      0x0d64
 
 #define MAC_QTFCR_INC			4
 #define MAC_MACA_INC			4
@@ -428,6 +432,8 @@
 #define MAC_TSCR_SNAPTYPSEL_WIDTH	2
 #define MAC_TSCR_TSADDREG_INDEX		5
 #define MAC_TSCR_TSADDREG_WIDTH		1
+#define MAC_TSCR_TSUPDT_INDEX		3
+#define MAC_TSCR_TSUPDT_WIDTH		1
 #define MAC_TSCR_TSCFUPDT_INDEX		1
 #define MAC_TSCR_TSCFUPDT_WIDTH		1
 #define MAC_TSCR_TSCTRLSSR_INDEX	9
@@ -456,6 +462,10 @@
 #define MAC_TSSR_TXTSC_WIDTH		1
 #define MAC_TXSNR_TXTSSTSMIS_INDEX	31
 #define MAC_TXSNR_TXTSSTSMIS_WIDTH	1
+#define MAC_TICSNR_TSICSNS_INDEX	8
+#define MAC_TICSNR_TSICSNS_WIDTH	8
+#define MAC_TECSNR_TSECSNS_INDEX	8
+#define MAC_TECSNR_TSECSNS_WIDTH	8
 #define MAC_VLANHTR_VLHT_INDEX		0
 #define MAC_VLANHTR_VLHT_WIDTH		16
 #define MAC_VLANIR_VLTI_INDEX		20
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 20d688a1962c..2e9b95a94f89 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1583,6 +1583,9 @@ static int xgbe_open(struct net_device *netdev)
 	INIT_WORK(&pdata->stopdev_work, xgbe_stopdev);
 	INIT_WORK(&pdata->tx_tstamp_work, xgbe_tx_tstamp);
 
+	/* Initialize PTP timestamping and clock. */
+	xgbe_init_ptp(pdata);
+
 	ret = xgbe_alloc_memory(pdata);
 	if (ret)
 		goto err_ptpclk;
@@ -2353,12 +2356,8 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 
 		if (XGMAC_GET_BITS(packet->attributes,
 				   RX_PACKET_ATTRIBUTES, RX_TSTAMP)) {
-			u64 nsec;
-
-			nsec = timecounter_cyc2time(&pdata->tstamp_tc,
-						    packet->rx_tstamp);
 			hwtstamps = skb_hwtstamps(skb);
-			hwtstamps->hwtstamp = ns_to_ktime(nsec);
+			hwtstamps->hwtstamp = ns_to_ktime(packet->rx_tstamp);
 		}
 
 		if (XGMAC_GET_BITS(packet->attributes,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
index 3ee641a7ebaf..bc52e5ec6420 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
@@ -10,6 +10,30 @@
 #include "xgbe.h"
 #include "xgbe-common.h"
 
+void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata,
+			     unsigned int sec, unsigned int nsec)
+{
+	int count;
+
+	/* Set the time values and tell the device */
+	XGMAC_IOWRITE(pdata, MAC_STSUR, sec);
+	XGMAC_IOWRITE(pdata, MAC_STNUR, nsec);
+
+	/* issue command to update the system time value */
+	XGMAC_IOWRITE(pdata, MAC_TSCR,
+		      XGMAC_IOREAD(pdata, MAC_TSCR) |
+		      (1 << MAC_TSCR_TSUPDT_INDEX));
+
+	/* Wait for the time adjust/update to complete */
+	count = 10000;
+	while (--count && XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSUPDT))
+		udelay(5);
+
+	if (count < 0)
+		netdev_err(pdata->netdev,
+			   "timed out updating system timestamp\n");
+}
+
 void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
 			       unsigned int addend)
 {
@@ -88,8 +112,8 @@ void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
 	if (XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSA) &&
 	    !XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSD)) {
 		nsec = le32_to_cpu(rdesc->desc1);
-		nsec <<= 32;
-		nsec |= le32_to_cpu(rdesc->desc0);
+		nsec *= NSEC_PER_SEC;
+		nsec += le32_to_cpu(rdesc->desc0);
 		if (nsec != 0xffffffffffffffffULL) {
 			packet->rx_tstamp = nsec;
 			XGMAC_SET_BITS(packet->attributes, RX_PACKET_ATTRIBUTES,
@@ -98,34 +122,13 @@ void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
 	}
 }
 
-int xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr)
+void xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr)
 {
-	/* Set one nano-second accuracy */
-	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCTRLSSR, 1);
-
-	/* Set fine timestamp update */
-	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 1);
-
-	/* Overwrite earlier timestamps */
-	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TXTSSTSM, 1);
-
-	XGMAC_IOWRITE(pdata, MAC_TSCR, mac_tscr);
-
-	/* Exit if timestamping is not enabled */
-	if (!XGMAC_GET_BITS(mac_tscr, MAC_TSCR, TSENA))
-		return 0;
-
-	/* Initialize time registers */
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
-	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
-	xgbe_set_tstamp_time(pdata, 0, 0);
-
-	/* Initialize the timecounter */
-	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc,
-			 ktime_to_ns(ktime_get_real()));
+	unsigned int value = 0;
 
-	return 0;
+	value = XGMAC_IOREAD(pdata, MAC_TSCR);
+	value |= mac_tscr;
+	XGMAC_IOWRITE(pdata, MAC_TSCR, value);
 }
 
 void xgbe_tx_tstamp(struct work_struct *work)
@@ -135,18 +138,14 @@ void xgbe_tx_tstamp(struct work_struct *work)
 						   tx_tstamp_work);
 	struct skb_shared_hwtstamps hwtstamps;
 	unsigned long flags;
-	u64 nsec;
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
 	if (!pdata->tx_tstamp_skb)
 		goto unlock;
 
 	if (pdata->tx_tstamp) {
-		nsec = timecounter_cyc2time(&pdata->tstamp_tc,
-					    pdata->tx_tstamp);
-
 		memset(&hwtstamps, 0, sizeof(hwtstamps));
-		hwtstamps.hwtstamp = ns_to_ktime(nsec);
+		hwtstamps.hwtstamp = ns_to_ktime(pdata->tx_tstamp);
 		skb_tstamp_tx(pdata->tx_tstamp_skb, &hwtstamps);
 	}
 
@@ -317,3 +316,86 @@ void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
 
 	skb_tx_timestamp(skb);
 }
+
+int xgbe_init_ptp(struct xgbe_prv_data *pdata)
+{
+	unsigned int mac_tscr = 0;
+	struct timespec64 now;
+	u64 dividend;
+
+	/* Register Settings to be done based on the link speed. */
+	switch (pdata->phy.speed) {
+	case SPEED_1000:
+		XGMAC_IOWRITE(pdata, MAC_TICNR, MAC_TICNR_1G_INITVAL);
+		XGMAC_IOWRITE(pdata, MAC_TECNR, MAC_TECNR_1G_INITVAL);
+		break;
+	case SPEED_2500:
+	case SPEED_10000:
+		XGMAC_IOWRITE_BITS(pdata, MAC_TICSNR, TSICSNS,
+				   MAC_TICSNR_10G_INITVAL);
+		XGMAC_IOWRITE(pdata, MAC_TECNR, MAC_TECNR_10G_INITVAL);
+		XGMAC_IOWRITE_BITS(pdata, MAC_TECSNR, TSECSNS,
+				   MAC_TECSNR_10G_INITVAL);
+		break;
+	case SPEED_UNKNOWN:
+	default:
+		break;
+	}
+
+	/* Enable IEEE1588 PTP clock. */
+	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+
+	/* Overwrite earlier timestamps */
+	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TXTSSTSM, 1);
+
+	/* Set one nano-second accuracy */
+	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCTRLSSR, 1);
+
+	/* Set fine timestamp update */
+	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 1);
+
+	xgbe_config_tstamp(pdata, mac_tscr);
+
+	/* Exit if timestamping is not enabled */
+	if (!XGMAC_GET_BITS(mac_tscr, MAC_TSCR, TSENA))
+		return -EOPNOTSUPP;
+
+	if (pdata->vdata->tstamp_ptp_clock_freq) {
+		/* Initialize time registers based on
+		 * 125MHz PTP Clock Frequency
+		 */
+		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC,
+				   XGBE_V2_TSTAMP_SSINC);
+		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC,
+				   XGBE_V2_TSTAMP_SNSINC);
+	} else {
+		/* Initialize time registers based on
+		 * 50MHz PTP Clock Frequency
+		 */
+		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
+		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
+	}
+
+	/* Calculate the addend:
+	 *   addend = 2^32 / (PTP ref clock / (PTP clock based on SSINC))
+	 *          = (2^32 * (PTP clock based on SSINC)) / PTP ref clock
+	 */
+	if (pdata->vdata->tstamp_ptp_clock_freq)
+		dividend = XGBE_V2_PTP_ACT_CLK_FREQ;
+	else
+		dividend = XGBE_PTP_ACT_CLK_FREQ;
+
+	dividend = (u64)(dividend << 32);
+	pdata->tstamp_addend = div_u64(dividend, pdata->ptpclk_rate);
+
+	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
+
+	dma_wmb();
+	/* initialize system time */
+	ktime_get_real_ts64(&now);
+
+	/* lower 32 bits of tv_sec are safe until y2106 */
+	xgbe_set_tstamp_time(pdata, (u32)now.tv_sec, now.tv_nsec);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 097ec5e4f261..e3e1dca9856a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -414,6 +414,7 @@ static struct xgbe_version_data xgbe_v2a = {
 	.tx_max_fifo_size		= 229376,
 	.rx_max_fifo_size		= 229376,
 	.tx_tstamp_workaround		= 1,
+	.tstamp_ptp_clock_freq		= 1,
 	.ecc_support			= 1,
 	.i2c_support			= 1,
 	.irq_reissue_support		= 1,
@@ -430,6 +431,7 @@ static struct xgbe_version_data xgbe_v2b = {
 	.tx_max_fifo_size		= 65536,
 	.rx_max_fifo_size		= 65536,
 	.tx_tstamp_workaround		= 1,
+	.tstamp_ptp_clock_freq		= 1,
 	.ecc_support			= 1,
 	.i2c_support			= 1,
 	.irq_reissue_support		= 1,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
index 3b8b4de8f91f..3658afc7801d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -13,18 +13,6 @@
 #include "xgbe.h"
 #include "xgbe-common.h"
 
-static u64 xgbe_cc_read(const struct cyclecounter *cc)
-{
-	struct xgbe_prv_data *pdata = container_of(cc,
-						   struct xgbe_prv_data,
-						   tstamp_cc);
-	u64 nsec;
-
-	nsec = xgbe_get_tstamp_time(pdata);
-
-	return nsec;
-}
-
 static int xgbe_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 {
 	struct xgbe_prv_data *pdata = container_of(info,
@@ -49,16 +37,39 @@ static int xgbe_adjtime(struct ptp_clock_info *info, s64 delta)
 	struct xgbe_prv_data *pdata = container_of(info,
 						   struct xgbe_prv_data,
 						   ptp_clock_info);
+	unsigned int neg_adjust = 0;
+	unsigned int sec, nsec;
+	u32 quotient, reminder;
 	unsigned long flags;
 
+	if (delta < 0) {
+		neg_adjust = 1;
+		delta = -delta;
+	}
+
+	quotient = div_u64_rem(delta, 1000000000ULL, &reminder);
+	sec = quotient;
+	nsec = reminder;
+
+	/* Negative adjustment for Hw timer register. */
+	if (neg_adjust) {
+		sec = -sec;
+		if (XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSCTRLSSR))
+			nsec = (1000000000UL - nsec);
+		else
+			nsec = (0x80000000UL - nsec);
+	}
+	nsec = (neg_adjust << 31) | nsec;
+
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
-	timecounter_adjtime(&pdata->tstamp_tc, delta);
+	xgbe_update_tstamp_time(pdata, sec, nsec);
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
 	return 0;
 }
 
-static int xgbe_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
+static int xgbe_gettimex(struct ptp_clock_info *info, struct timespec64 *ts,
+			 struct ptp_system_timestamp *sts)
 {
 	struct xgbe_prv_data *pdata = container_of(info,
 						   struct xgbe_prv_data,
@@ -67,9 +78,9 @@ static int xgbe_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
 	u64 nsec;
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
-
-	nsec = timecounter_read(&pdata->tstamp_tc);
-
+	ptp_read_system_prets(sts);
+	nsec = xgbe_get_tstamp_time(pdata);
+	ptp_read_system_postts(sts);
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
 	*ts = ns_to_timespec64(nsec);
@@ -84,14 +95,9 @@ static int xgbe_settime(struct ptp_clock_info *info,
 						   struct xgbe_prv_data,
 						   ptp_clock_info);
 	unsigned long flags;
-	u64 nsec;
-
-	nsec = timespec64_to_ns(ts);
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
-
-	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc, nsec);
-
+	xgbe_set_tstamp_time(pdata, ts->tv_sec, ts->tv_nsec);
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
 	return 0;
@@ -107,8 +113,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 {
 	struct ptp_clock_info *info = &pdata->ptp_clock_info;
 	struct ptp_clock *clock;
-	struct cyclecounter *cc = &pdata->tstamp_cc;
-	u64 dividend;
 
 	snprintf(info->name, sizeof(info->name), "%s",
 		 netdev_name(pdata->netdev));
@@ -116,7 +120,7 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 	info->max_adj = pdata->ptpclk_rate;
 	info->adjfine = xgbe_adjfine;
 	info->adjtime = xgbe_adjtime;
-	info->gettime64 = xgbe_gettime;
+	info->gettimex64 = xgbe_gettimex;
 	info->settime64 = xgbe_settime;
 	info->enable = xgbe_enable;
 
@@ -128,23 +132,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 
 	pdata->ptp_clock = clock;
 
-	/* Calculate the addend:
-	 *   addend = 2^32 / (PTP ref clock / 50Mhz)
-	 *          = (2^32 * 50Mhz) / PTP ref clock
-	 */
-	dividend = 50000000;
-	dividend <<= 32;
-	pdata->tstamp_addend = div_u64(dividend, pdata->ptpclk_rate);
-
-	/* Setup the timecounter */
-	cc->read = xgbe_cc_read;
-	cc->mask = CLOCKSOURCE_MASK(64);
-	cc->mult = 1;
-	cc->shift = 0;
-
-	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc,
-			 ktime_to_ns(ktime_get_real()));
-
 	/* Disable all timestamping to start */
 	XGMAC_IOWRITE(pdata, MAC_TSCR, 0);
 	pdata->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 2341c7d213a7..d7e03e292ec4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -119,6 +119,14 @@
 #define XGBE_MSI_BASE_COUNT	4
 #define XGBE_MSI_MIN_COUNT	(XGBE_MSI_BASE_COUNT + 1)
 
+/* Initial PTP register values based on Link Speed. */
+#define MAC_TICNR_1G_INITVAL	0x10
+#define MAC_TECNR_1G_INITVAL	0x28
+
+#define MAC_TICSNR_10G_INITVAL	0x33
+#define MAC_TECNR_10G_INITVAL	0x14
+#define MAC_TECSNR_10G_INITVAL	0xCC
+
 /* PCI clock frequencies */
 #define XGBE_V2_DMA_CLOCK_FREQ	500000000	/* 500 MHz */
 #define XGBE_V2_PTP_CLOCK_FREQ	125000000	/* 125 MHz */
@@ -128,6 +136,11 @@
  */
 #define XGBE_TSTAMP_SSINC	20
 #define XGBE_TSTAMP_SNSINC	0
+#define XGBE_PTP_ACT_CLK_FREQ	500000000
+
+#define XGBE_V2_TSTAMP_SSINC	0xA
+#define XGBE_V2_TSTAMP_SNSINC	0
+#define XGBE_V2_PTP_ACT_CLK_FREQ	1000000000
 
 /* Driver PMT macros */
 #define XGMAC_DRIVER_CONTEXT	1
@@ -938,6 +951,7 @@ struct xgbe_version_data {
 	unsigned int tx_max_fifo_size;
 	unsigned int rx_max_fifo_size;
 	unsigned int tx_tstamp_workaround;
+	unsigned int tstamp_ptp_clock_freq;
 	unsigned int ecc_support;
 	unsigned int i2c_support;
 	unsigned int irq_reissue_support;
@@ -1123,8 +1137,6 @@ struct xgbe_prv_data {
 	struct ptp_clock_info ptp_clock_info;
 	struct ptp_clock *ptp_clock;
 	struct hwtstamp_config tstamp_config;
-	struct cyclecounter tstamp_cc;
-	struct timecounter tstamp_tc;
 	unsigned int tstamp_addend;
 	struct work_struct tx_tstamp_work;
 	struct sk_buff *tx_tstamp_skb;
@@ -1270,7 +1282,7 @@ void xgbe_restart_dev(struct xgbe_prv_data *pdata);
 void xgbe_full_restart_dev(struct xgbe_prv_data *pdata);
 
 /* For Timestamp config */
-int xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr);
+void xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr);
 u64 xgbe_get_tstamp_time(struct xgbe_prv_data *pdata);
 u64 xgbe_get_tx_tstamp(struct xgbe_prv_data *pdata);
 void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
@@ -1281,7 +1293,6 @@ void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
 			       unsigned int addend);
 void xgbe_set_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
 			  unsigned int nsec);
-int xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr);
 void xgbe_tx_tstamp(struct work_struct *work);
 int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata,
 			       struct ifreq *ifreq);
@@ -1290,7 +1301,9 @@ int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
 void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
 			 struct sk_buff *skb,
 			 struct xgbe_packet_data *packet);
-
+int xgbe_init_ptp(struct xgbe_prv_data *pdata);
+void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
+			     unsigned int nsec);
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


