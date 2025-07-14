Return-Path: <netdev+bounces-206558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73344B03774
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8D11731F9
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92455221FD4;
	Mon, 14 Jul 2025 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LiskCIRS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542817C77
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476322; cv=fail; b=N9QWqzJ0u2PmTu6j0vt6C4jYDA+edAkK7u9f3+/wpYj8CBfME9xV9e1NdeFaZdxIfK41MKmIOpHzXIdQSQUVEraHVF+4oDn8kPiRhzZ8cSJtvz3CsPYvCyTmcq/BU8z2C96IpIqWlA5b5oQLtUNUugpmEvf3pKFaHxkF31PJLho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476322; c=relaxed/simple;
	bh=Vrt/N2t3huLFRUbI5WjHq7DdMuCYsvnIcoDKghldF54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRmE/xKrOpllnsMWd6IMyZqoz6PVx1A6E9OIgyT52r87rvwJKzLQJ4ALqs6ChKi02KXeOIuSI06JStq1eJjkInDmFyVath5Y1QRyWGqORrpUB4kdT5FbraknvNVb01OUKUin2aqy8SZ0ixbrhoMsq0VXUDlFDXxwvLl+uo0z2Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LiskCIRS; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRaeL0gnYsE5oN2+vPvBP64f0LFv6X/MaWE4BBvcZOnJ4N6Xft7HmQLs+N36YJyvVRdLlijg6ze7JwLzwhRFs098sPTC0Z1knpXV57O8Go+klKzyJtI++0D4Qf8r4lR5PKiPyJbCdPbJrI8E1NJt7yUcH01bDLDDwwRbaaKFObh7d2FhxgAGbDu2KQnBjRyCWhsD2QBCmbd62+zdP9rRYOZvzkJKPGKzxmPOLTcI83jdEFAYPFNBZuqLqHpQv22wNO6EIBqW4kvNL5Ij5V2j6JKze4qTjzSaWdAkkg6JPawfvXg/U3jE/Bg5Bpy3+0NW/Zp4OUkmAMQCPvx7cdAfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1h/MYO5l3SYmqzcP/+1IpaSFX+svkAYIdn+l1WTYw4=;
 b=YddH9Q+vYDKpfqptIwwEQdA1xCdKOeFMpey9GTeIZejn/yZfzqUQYOi+kmtTch6K2j/YEcYczPVrjvyVPYqhNq2ARzEypFUmtXvkGbgte1uEPot01t6hJpQIxwk2vrFYtmXv0vWNUTr4KAP6PvZf9xiD7F54rG+paLh6j6OAzX4p2kr5JiogtSo4G+LiJMwcPHYKAiNc0EyQ2tdko2pRbXG/H9kWSJHnrWK1JN3RtzVyMk/jTd4hFoHRpgfMmUDZjrgVn4vy5xs28rezaoF0E7yfVDFsw+xptpY68aubaRpGYeMUAZJ92T48GU8N97PXZiQm9LjB1JU9j/Q6crFRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1h/MYO5l3SYmqzcP/+1IpaSFX+svkAYIdn+l1WTYw4=;
 b=LiskCIRS2/iyu7P9XDW7z9Bt14tVIrob+jNMuOSukLst2XXacZZdGqZVA5txkTHW+9kslbLjBlIF+wiVqnbBQQvQ3/uq4JjHjFNypc3KUmRcjtUeYXF7ejFaKkYk8ZOxD83UlNlBfsHj17dwvGRR1bLBe9R9oAcTw6DqV6Hs/s0=
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Mon, 14 Jul
 2025 06:58:31 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::a2) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 06:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 06:58:31 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 01:58:28 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2] amd-xgbe: add hardware PTP timestamping support
Date: Mon, 14 Jul 2025 12:28:11 +0530
Message-ID: <20250714065811.464645-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c5f4d8-0fd1-4d0c-6351-08ddc2a3d7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0kGChEKl7TzcKJbxTRnHibTDTvK6an+sjWplkWatQdo/qzWWA/CC/UmLZcpb?=
 =?us-ascii?Q?c0DE1LDy66xDKFR8GLe7IeCbMhYHqP5a1+a6iI9riRFU9zQsQh23q7rK48xQ?=
 =?us-ascii?Q?g1KDla2aZToEhGM+WByc4mFjwBSBfGczSpTKz1RefY/HBTdT37tq1EDZr1gz?=
 =?us-ascii?Q?PzaWFZuPEm4L7eEp84rW1bmeC0xrOBTs/S48ICKs+cHhe8zoVa1YiGlXckYW?=
 =?us-ascii?Q?ft51huAmnvBx6vzQJdAcQrtonNO/EVHGt/ywRYBfnGkcDx6bgCbR+SOJEiAN?=
 =?us-ascii?Q?wOULw0BK6GszVwRATUPffbOm3XGU038rLaq89exiQSJNKTbUBMacCdXHrspH?=
 =?us-ascii?Q?Gwww6tUK20zB9fcIirbqq+O1ecSJJAKCYj/CZ1dv4d5lsmTTS1HgJps/ncJC?=
 =?us-ascii?Q?rXpaVHChzsQH8uwR2T8El/7ZPRpw1Qw0C8kS7cHLwgjDYTAFUQyrF7xbS9Ee?=
 =?us-ascii?Q?YfOD6A+rAMrpJnI3kgA8ib2KD7w1H/gf+Kr4xtxi1/dL9cmBfDIDp9z65NTh?=
 =?us-ascii?Q?Db9LyZompC71rRE9RhOtCzc1C6rAQOCc+YZ92vDDSWDUKoLM6Pt+F5/mANxJ?=
 =?us-ascii?Q?Ua3dq6qvp9sbDPNQqM58mO2p4eqNUiECBB5RURm2uq3b/cAyUshx/TNHB2Sm?=
 =?us-ascii?Q?iXQ92K3D50k+VkOqSEMFOH98V3mX4t86LgOgluBP6ntvyvHKMLpxgRGPSIu3?=
 =?us-ascii?Q?PN70kQCHZ4tF/kbsGmEjFcra6EbxyUpC5I/Eol/3nhj5rurjpz3RfvnW2hJr?=
 =?us-ascii?Q?rB2v+gZ+xc2ntW6aVbsYsqeAvrVedYehz2Hi8vgEuFQjBHsxkOL5Mlg4VJGa?=
 =?us-ascii?Q?ILhucceP7qQHi1MZf6d9jZoWSFd7Mlxr5VD315idxqVG5RdOS4d2Hjjf/pMk?=
 =?us-ascii?Q?5hNJYgyfKR5xbpO5TF9zKBF+qAUf6mkc0Jjcn5387C/8aCgTgzKll0AUJqoU?=
 =?us-ascii?Q?DCRHMdxSbzBFOHrhlv5avBISK/LDk7g7qD+dyDcPKXXmJ71tWpY1XA/lNHeg?=
 =?us-ascii?Q?oGXDfFamiCs+9JSZupwD3V5udjupioHpZcsa0DrTAPWexPQ9M1070kkHSIpM?=
 =?us-ascii?Q?gyI8ZbcksYTjXU0Il7B/aOSeVWdZp9VeNZORoWWI7iy1FT0mArquIxd1GYtu?=
 =?us-ascii?Q?muZzLYdLaw2gGWhbQEP4nd7BxClzwXrmQcMLNmYU1BR4hekKSJhZF3YCQSdr?=
 =?us-ascii?Q?FgtOl2YGDuvmvSLhMTMwCGKpg+wl7snIVfTQnLd5zT+EJIrX5bcbXNjtPimr?=
 =?us-ascii?Q?BGGZQJLaXNw6yCub7afQ1NGme0lklUgd7s/5MKBHoBAzX4aSEYKD08pWkUdO?=
 =?us-ascii?Q?r9LPIQ0BeeEpK4IUuJ3nhwXzZ3YqJKMgUPQf5a+INv1nW2Y6mHgWGS3teHjh?=
 =?us-ascii?Q?D6ML2VQ8v8S2aR8i18xNSXJGAFGiHo82XR8lSNh3l1uqgqsXiYl1NfQY3ErO?=
 =?us-ascii?Q?8aaJuR+tgtmSiyGdZJ/4hqUsAxYnHM4FF6n075TdAnDaFjxeAp4A1xW5Rqka?=
 =?us-ascii?Q?BPkpU3pnjOGNn/b1g1oBxpYcAge0tBJFaKEv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 06:58:31.4194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c5f4d8-0fd1-4d0c-6351-08ddc2a3d7f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027

Adds complete support for hardware-based PTP (IEEE 1588)
timestamping to the AMD XGBE driver.

- Initialize and configure the MAC PTP registers based on link
  speed and reference clock.
- Support both 50MHz and 125MHz PTP reference clocks.
- Update the driver interface and version data to support PTP
  clock frequency selection.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
- address the comments received for xgbe_init_ptp()
- ensure reverse x-mass tree ordering of variables
- use macros instead for hardcoded numbers

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  10 ++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 145 ++++++++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  15 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    |  70 +++++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  28 +++-
 6 files changed, 187 insertions(+), 83 deletions(-)

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
index 9e4e79bfe624..8c000cbdf7e2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1558,6 +1558,30 @@ static void xgbe_rx_desc_init(struct xgbe_channel *channel)
 	DBGPR("<--rx_desc_init\n");
 }
 
+static void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata,
+				    unsigned int sec, unsigned int nsec)
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
 static void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
 				      unsigned int addend)
 {
@@ -1636,8 +1660,8 @@ static void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
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
@@ -1646,39 +1670,19 @@ static void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
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
-
-	/* Initialize time registers */
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
-	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
-	xgbe_set_tstamp_time(pdata, 0, 0);
+	unsigned int value = 0;
 
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
 			       struct xgbe_ring *ring)
+
 {
 	struct xgbe_prv_data *pdata = channel->pdata;
 	struct xgbe_ring_data *rdata;
@@ -3512,6 +3516,87 @@ static void xgbe_powerdown_rx(struct xgbe_prv_data *pdata)
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
+}
+
 static int xgbe_init(struct xgbe_prv_data *pdata)
 {
 	struct xgbe_desc_if *desc_if = &pdata->desc_if;
@@ -3672,9 +3757,11 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
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
index 978c4dd01fa0..17311b963431 100644
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
@@ -49,16 +37,40 @@ static int xgbe_adjtime(struct ptp_clock_info *info, s64 delta)
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
@@ -68,7 +80,9 @@ static int xgbe_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
 
-	nsec = timecounter_read(&pdata->tstamp_tc);
+	ptp_read_system_prets(sts);
+	nsec = pdata->hw_if.get_tstamp_time(pdata);
+	ptp_read_system_postts(sts);
 
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
@@ -84,13 +98,10 @@ static int xgbe_settime(struct ptp_clock_info *info,
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
 
@@ -107,8 +118,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 {
 	struct ptp_clock_info *info = &pdata->ptp_clock_info;
 	struct ptp_clock *clock;
-	struct cyclecounter *cc = &pdata->tstamp_cc;
-	u64 dividend;
 
 	snprintf(info->name, sizeof(info->name), "%s",
 		 netdev_name(pdata->netdev));
@@ -116,7 +125,7 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 	info->max_adj = pdata->ptpclk_rate;
 	info->adjfine = xgbe_adjfine;
 	info->adjtime = xgbe_adjtime;
-	info->gettime64 = xgbe_gettime;
+	info->gettimex64 = xgbe_gettimex;
 	info->settime64 = xgbe_settime;
 	info->enable = xgbe_enable;
 
@@ -128,23 +137,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
 
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
index 70169ea23c7f..33606333c9e3 100644
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
@@ -742,10 +755,16 @@ struct xgbe_hw_if {
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
 
@@ -946,6 +965,7 @@ struct xgbe_version_data {
 	unsigned int tx_max_fifo_size;
 	unsigned int rx_max_fifo_size;
 	unsigned int tx_tstamp_workaround;
+	unsigned int tstamp_ptp_clock_freq;
 	unsigned int ecc_support;
 	unsigned int i2c_support;
 	unsigned int irq_reissue_support;
@@ -1131,8 +1151,6 @@ struct xgbe_prv_data {
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


