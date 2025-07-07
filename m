Return-Path: <netdev+bounces-204655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F88AFBA2B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8126316CE81
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64C2367B5;
	Mon,  7 Jul 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B3ZTixbc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94527288A2
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910864; cv=fail; b=eUEPO4WwZd8J+j+YzyTUr5SE7/SDhRJdmIU+zS/IKAwisC0cFbVOxjNCipTUtrt0NhMhAdTDtsU/snBTS8vvzdXUgWFMgLGyCLPADEC5L8/hVPpvng7GEr6ZWGeFf9KX+1r6N79qurKwLDFzSC5C2CyHXYbcZdEMD/s2FPpB+EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910864; c=relaxed/simple;
	bh=+Iw8n4nu1oGc/i84crmSi76744ZxumHE4adHx8Rpo3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxE/L2W+NZbvrYLsPbvhJVMWJ2WlzN69OIkNkC9xzYLp8qgsjT1d+DqYu60ZTvIK8Eyyz5qqJmWnB0zwGSkPKdwIfX8DXYBdPyDYOH/yCbpAoYA6V5PcgRM86p0VkwJoTkYFmnlpVHV9Ah/sdyYWTD0cLHLTasSRUDNozCh7FqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B3ZTixbc; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6N2swYMLtvlR82npl8/9sX5UgBzBWmmZgkZgwQtFlCFVrydckEpfoLEIQ2CsmJqvOYlOF1DWtEdCEZx8NGvcYekCMHX3pDdZ5NDgxVDP385/IjwW94B7E+olymgn6sIli58artvU7od8btMQyxUQ6P5Lm/0Q4Kv2EItsheHDKS+NlpU0zhlL3Rrhru4GthtGSef0MmOQH1FCPJjIZ7kiR+uowczs9F9YGlySORXSvaS5ADM0viEvff1UHh6xxXwlYqzNBRaAwdPl21y01MLln9litnk8ln8vZeaNkjgcEiWaUO6PJe/Wu7B/NrGnQMUSUnH7GxYb99Ww1pV6A2rYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQSBXTwhkA2Zv2igGIS6+KMpjn4k+55qXxT0ZM3pUhs=;
 b=w+Q8xUbq1cBGdDOoLwrCC0vkZWICN5+H+HBNVO1JkSLri1W57e8V4/KsA7V/WsWnJNUKyiUYgkZocFACSkfoNTbJXqJm1+XwYN48396u6r71IQuVL1IQEd3lRLFFvNIPDCLc0Vu7TPs6QzO++qoyH+bn5o6kUPRJnAfTegfVp6F49NdT9fdi5w2Vm1jEFjOEKZd7MZhkjHLllttpOYT7No+LTDq2ScQwYJibpiYjR68zO7qb+M5RLY0+WfwsXZbGKBRDMgBSS8nFC4mgagh7wodwXOEOQjZXfNDMNUrJS63BPNluyu9/uty1aq42mOoSYTexaNvhb+WdwyLqUbyrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQSBXTwhkA2Zv2igGIS6+KMpjn4k+55qXxT0ZM3pUhs=;
 b=B3ZTixbcHmSldC0aUw0wzFMvM90DkIZYIBEBTQ/n+DrB5OB/nlIj5okbArtnMMMYp6qQXOARnqQVaMB+7ymKB/0IKvfQgvEUbgCWtQm05gsqoyjVHDqH8amWQQ9dOymv+Vq23O1fDy5fT+srrNRX47RP5lujFjjWQKt9FrJadHU=
Received: from BN9PR03CA0386.namprd03.prod.outlook.com (2603:10b6:408:f7::31)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Mon, 7 Jul
 2025 17:54:20 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::fd) by BN9PR03CA0386.outlook.office365.com
 (2603:10b6:408:f7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 17:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 17:54:19 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 12:54:16 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [net-next] amd-xgbe: add hardware PTP timestamping support
Date: Mon, 7 Jul 2025 23:23:56 +0530
Message-ID: <20250707175356.46246-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 487a806e-6393-44bb-21e9-08ddbd7f4c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+t+oK916mYVMYNbGxllbrz/cB0OKgi81tZfuiW3KnnNkukssiSn9V5yX7rbn?=
 =?us-ascii?Q?gaw/mjLgzje41xumxeUsbfNvVjcIeu1Ml9BY6aVqlmMhGej4rat0imP3+9cR?=
 =?us-ascii?Q?+t4Yvw4HDS4uGWXBiExa9LD40avB80FCr2zP5qV8PvrrFyOnrXJtBSObD0Sx?=
 =?us-ascii?Q?FeSUGriFYQ0FndpzbMO5UYV9GQuxGT8daxcGjBnRfqcB41qdRsEz+75deJH3?=
 =?us-ascii?Q?3DTnkYdOXa17zQ2BN/HeRC7dT8GGEM+OPpP6PohAMdUKANyxzwGE71pqVkjR?=
 =?us-ascii?Q?hSrkMplwphfYatMdwH1/n68qdyKZwyAvR5GtbKSpPspz33OIyvqM2oRZMTj4?=
 =?us-ascii?Q?sbmZcW0Hkfh9VnW+yKqZFM4NGutfcwPRe/CrV9JY7h3E5sno4IdBIJCDib4d?=
 =?us-ascii?Q?rFuI5jLSZv9OzfJFvx3+gj1z9Ci2xn5hwt7y384O1Q5A69Po2pXqIsR16EGP?=
 =?us-ascii?Q?hpGQsAtTaCyhTiHUfNUChgIYD7rotavrmc1isHFCjVusX0Ggm/PToYpSG+aB?=
 =?us-ascii?Q?3P10J8toCppIX0o3HGywyLS5JzLOC6pMEAbq9ja4y+LHsuEJxLb+62D/CfhY?=
 =?us-ascii?Q?WeiIxpXxBIMQuG0UXiqnXDrOSFD9FKeByrXIgPNowGglAozoWxHHPbNW0ZxO?=
 =?us-ascii?Q?OuG2p7PtfSqUea+9d46tpx1gLe5EqqIFjCKK3OGioTEb9mCmity5UoEC7zTY?=
 =?us-ascii?Q?mvGK7ElY5QGqONkVFGgVyuQdwRAQU8unatllEh7Udip9yNr8H0JaxlP6yZUV?=
 =?us-ascii?Q?FsdauEmedvJK54S8+N8aAqNyptCKi8Itkikstb8nUmyFv6bJXaRgywkdjpLA?=
 =?us-ascii?Q?csRgessiayAdU/gG0xWTk1andEsfpHdpXwXx4ewj+lE4pJgPzXh9/wCKV7Pt?=
 =?us-ascii?Q?ND8tfs4+0xdpB1+a+JNiPB7bE2mn2Mjhj0asHz4Gmzu56khqPX7vUY3RE5D1?=
 =?us-ascii?Q?ee5rGRNedU6tR/tg/kTP5O/V7jKWYJD4UJ4mS4hu554QoAYWJ9ZGYwYk3V84?=
 =?us-ascii?Q?0bU2J0fqC9on2wt5gHGuDYjcbhAe16dwxDeUaU2XSaMOqp0p1fLps1GXHaqW?=
 =?us-ascii?Q?BVghibVrdsJLK/GIdb4t+xbAzhpxnJLKyQAymVMEMOgIv/9h6l3YqRHx0CmL?=
 =?us-ascii?Q?umWv5i2/y9dTIy5d/7B6K5QVEJ511X1QG8jJxZbfVcBF3bKv5dpq1Q3ryBsC?=
 =?us-ascii?Q?lpfHvH9t2GbDHlJgc61sus7SEHPTyCVb3hqV9TI5XCu7InGRTGTmpDWQLL+J?=
 =?us-ascii?Q?eHDSJ+joHw7SYGkHy2FSfPb6uLixeFTA6QgZNwW2MkiB1ykIOB1njt7ASvYn?=
 =?us-ascii?Q?CrbnlbIziz+c9LHWRzrv7ccYw1mfmuy/OURIcnqPJxKLY6rRFwwIzpSlZ4nx?=
 =?us-ascii?Q?/13CpfUWiW6beB8OZGpvG8vr/oRKYwbDVX3f5aJUm4Fwx+2h8vsPucW1R/bw?=
 =?us-ascii?Q?m0YrsAmyOVOi0IC8yuwKsL4RyuBlzrQdF6Y6v0zdYu18CEs+n6qwVD2f44VI?=
 =?us-ascii?Q?uUKlYlf7qFvpN0wbr8uJKdWk5lrK1P/U4XDi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 17:54:19.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487a806e-6393-44bb-21e9-08ddbd7f4c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

Adds support for hardware-based PTP (IEEE 1588) timestamping to
the AMD XGBE driver.

- Initialize and configure the MAC PTP registers based on link
  speed and reference clock.
- Support both 50MHz and 125MHz PTP reference clocks.
- Update the driver interface and version data to support PTP
  clock frequency selection.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  10 ++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 145 ++++++++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  15 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    |  74 +++++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  25 +++-
 6 files changed, 187 insertions(+), 84 deletions(-)

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
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 9e4e79bfe624..559425fa1846 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1558,6 +1558,29 @@ static void xgbe_rx_desc_init(struct xgbe_channel *channel)
 	DBGPR("<--rx_desc_init\n");
 }
 
+static void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata,
+				    unsigned int sec, unsigned int nsec)
+{
+	unsigned int count = 10000;
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
+	/* Wait for the time till update complete */
+	while (--count && XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSUPDT))
+		udelay(5);
+
+	if (!count)
+		netdev_err(pdata->netdev,
+			   "timed out updating system timestamp\n");
+}
+
 static void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
 				      unsigned int addend)
 {
@@ -1636,8 +1659,8 @@ static void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
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
@@ -1646,39 +1669,18 @@ static void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
 	}
 }
 
-static int xgbe_config_tstamp(struct xgbe_prv_data *pdata,
-			      unsigned int mac_tscr)
+static void xgbe_config_tstamp(struct xgbe_prv_data *pdata,
+			       unsigned int mac_tscr)
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
+	unsigned int value = 0;
 
-	/* Initialize time registers */
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
-	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
-	xgbe_set_tstamp_time(pdata, 0, 0);
-
-	/* Initialize the timecounter */
-	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc,
-			 ktime_to_ns(ktime_get_real()));
-
-	return 0;
+	value = XGMAC_IOREAD(pdata, MAC_TSCR);
+	value |= mac_tscr;
+	XGMAC_IOWRITE(pdata, MAC_TSCR, value);
 }
 
 static void xgbe_tx_start_xmit(struct xgbe_channel *channel,
-			       struct xgbe_ring *ring)
+		struct xgbe_ring *ring)
 {
 	struct xgbe_prv_data *pdata = channel->pdata;
 	struct xgbe_ring_data *rdata;
@@ -3512,6 +3514,87 @@ static void xgbe_powerdown_rx(struct xgbe_prv_data *pdata)
 	}
 }
 
+static void xgbe_init_ptp(struct xgbe_prv_data *pdata)
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
+		return;
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
+		dividend = 100000000;           // PTP clock frequency is 125MHz
+	else
+		dividend = 50000000;            // PTP clock frequency is 50MHz
+
+	dividend <<= 32;
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
+}
+
 static int xgbe_init(struct xgbe_prv_data *pdata)
 {
 	struct xgbe_desc_if *desc_if = &pdata->desc_if;
@@ -3672,9 +3755,11 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 	hw_if->read_mmc_stats = xgbe_read_mmc_stats;
 
 	/* For PTP config */
+	hw_if->init_ptp = xgbe_init_ptp;
 	hw_if->config_tstamp = xgbe_config_tstamp;
 	hw_if->update_tstamp_addend = xgbe_update_tstamp_addend;
 	hw_if->set_tstamp_time = xgbe_set_tstamp_time;
+	hw_if->update_tstamp_time = xgbe_update_tstamp_time;
 	hw_if->get_tstamp_time = xgbe_get_tstamp_time;
 	hw_if->get_tx_tstamp = xgbe_get_tx_tstamp;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 65447f9a0a59..a6b9d0cda48c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1377,7 +1377,6 @@ static void xgbe_tx_tstamp(struct work_struct *work)
 						   struct xgbe_prv_data,
 						   tx_tstamp_work);
 	struct skb_shared_hwtstamps hwtstamps;
-	u64 nsec;
 	unsigned long flags;
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
@@ -1385,11 +1384,8 @@ static void xgbe_tx_tstamp(struct work_struct *work)
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
 
@@ -1776,6 +1772,9 @@ static int xgbe_open(struct net_device *netdev)
 	INIT_WORK(&pdata->stopdev_work, xgbe_stopdev);
 	INIT_WORK(&pdata->tx_tstamp_work, xgbe_tx_tstamp);
 
+	/* Initialize PTP timestamping and clock. */
+	pdata->hw_if.init_ptp(pdata);
+
 	ret = xgbe_alloc_memory(pdata);
 	if (ret)
 		goto err_ptpclk;
@@ -2546,12 +2545,8 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 
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
index 978c4dd01fa0..52764dcd9f4d 100644
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
-	nsec = pdata->hw_if.get_tstamp_time(pdata);
-
-	return nsec;
-}
-
 static int xgbe_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 {
 	struct xgbe_prv_data *pdata = container_of(info,
@@ -50,25 +38,55 @@ static int xgbe_adjtime(struct ptp_clock_info *info, s64 delta)
 						   struct xgbe_prv_data,
 						   ptp_clock_info);
 	unsigned long flags;
+	unsigned int sec, nsec;
+	unsigned int neg_adjust = 0;
+	u32 quotient, reminder;
+
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
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
-	timecounter_adjtime(&pdata->tstamp_tc, delta);
+	pdata->hw_if.update_tstamp_time(pdata, sec, nsec);
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
 	return 0;
 }
 
-static int xgbe_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
+static int xgbe_gettimex(struct ptp_clock_info *info,
+			 struct timespec64 *ts,
+			 struct ptp_system_timestamp *sts)
 {
 	struct xgbe_prv_data *pdata = container_of(info,
 						   struct xgbe_prv_data,
 						   ptp_clock_info);
 	unsigned long flags;
 	u64 nsec;
+	static int count = 3;
+
+	if (count > 0 && count--)
+		dump_stack();
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
 
-	nsec = timecounter_read(&pdata->tstamp_tc);
+	ptp_read_system_prets(sts);
+	nsec = pdata->hw_if.get_tstamp_time(pdata);
+	ptp_read_system_postts(sts);
 
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
@@ -84,13 +102,10 @@ static int xgbe_settime(struct ptp_clock_info *info,
 						   struct xgbe_prv_data,
 						   ptp_clock_info);
 	unsigned long flags;
-	u64 nsec;
-
-	nsec = timespec64_to_ns(ts);
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
 
-	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc, nsec);
+	pdata->hw_if.set_tstamp_time(pdata, ts->tv_sec, ts->tv_nsec);
 
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
@@ -107,8 +122,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 {
 	struct ptp_clock_info *info = &pdata->ptp_clock_info;
 	struct ptp_clock *clock;
-	struct cyclecounter *cc = &pdata->tstamp_cc;
-	u64 dividend;
 
 	snprintf(info->name, sizeof(info->name), "%s",
 		 netdev_name(pdata->netdev));
@@ -116,7 +129,7 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 	info->max_adj = pdata->ptpclk_rate;
 	info->adjfine = xgbe_adjfine;
 	info->adjtime = xgbe_adjtime;
-	info->gettime64 = xgbe_gettime;
+	info->gettimex64 = xgbe_gettimex;
 	info->settime64 = xgbe_settime;
 	info->enable = xgbe_enable;
 
@@ -128,23 +141,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 
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
index 70169ea23c7f..b5c5624eb827 100644
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
@@ -129,6 +137,8 @@
 #define XGBE_TSTAMP_SSINC	20
 #define XGBE_TSTAMP_SNSINC	0
 
+#define XGBE_V2_TSTAMP_SSINC	0xA
+#define XGBE_V2_TSTAMP_SNSINC	0
 /* Driver PMT macros */
 #define XGMAC_DRIVER_CONTEXT	1
 #define XGMAC_IOCTL_CONTEXT	2
@@ -742,10 +752,16 @@ struct xgbe_hw_if {
 	void (*read_mmc_stats)(struct xgbe_prv_data *);
 
 	/* For Timestamp config */
-	int (*config_tstamp)(struct xgbe_prv_data *, unsigned int);
-	void (*update_tstamp_addend)(struct xgbe_prv_data *, unsigned int);
-	void (*set_tstamp_time)(struct xgbe_prv_data *, unsigned int sec,
+	void (*init_ptp)(struct xgbe_prv_data *pdata);
+	void (*config_tstamp)(struct xgbe_prv_data *pdata,
+			      unsigned int mac_tscr);
+	void (*update_tstamp_addend)(struct xgbe_prv_data *pdata,
+				     unsigned int addend);
+	void (*set_tstamp_time)(struct xgbe_prv_data *pdata, unsigned int sec,
 				unsigned int nsec);
+	void (*update_tstamp_time)(struct xgbe_prv_data *pdata,
+				   unsigned int sec,
+				   unsigned int nsec);
 	u64 (*get_tstamp_time)(struct xgbe_prv_data *);
 	u64 (*get_tx_tstamp)(struct xgbe_prv_data *);
 
@@ -946,6 +962,7 @@ struct xgbe_version_data {
 	unsigned int tx_max_fifo_size;
 	unsigned int rx_max_fifo_size;
 	unsigned int tx_tstamp_workaround;
+	unsigned int tstamp_ptp_clock_freq;
 	unsigned int ecc_support;
 	unsigned int i2c_support;
 	unsigned int irq_reissue_support;
@@ -1131,8 +1148,6 @@ struct xgbe_prv_data {
 	struct ptp_clock_info ptp_clock_info;
 	struct ptp_clock *ptp_clock;
 	struct hwtstamp_config tstamp_config;
-	struct cyclecounter tstamp_cc;
-	struct timecounter tstamp_tc;
 	unsigned int tstamp_addend;
 	struct work_struct tx_tstamp_work;
 	struct sk_buff *tx_tstamp_skb;
-- 
2.34.1


