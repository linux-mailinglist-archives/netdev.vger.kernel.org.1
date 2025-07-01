Return-Path: <netdev+bounces-202875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89ABAEF829
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04472188A180
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1D421B9F5;
	Tue,  1 Jul 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ktdvFXNz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957F28373
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372400; cv=fail; b=Ddv3lpVLZk9/4zesXmEbN3lkuKD/UFxJiuSwZKuaOOZrRERnAh1V1dB/OC4Re+AakpHZ79U7EBt6l1m0qli1Vy32slC6PuGOFNjzO/TAUm5TAb4XPW8ij64TMOkXUwJ34fdiWUZm+olrgWxSI2EFk/wKre/qxmww+quP98H7D7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372400; c=relaxed/simple;
	bh=qw0K+jAgV75jWDYi92j7cKfkqnEpalwCRvYK08nIeb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r9ITx8ZFkgnL2/U2wXJHbm4L2rZHfE+bue/jeMHa+mlZboV3DflaIrSFXlth5Pjxvd83YEeoPYu5ufQ8Af3I2afJIyGBddcNX1gRS1NbHMBbklu6elw3WsTjWPAYLNrGOZR3MiLarnErEUQS+Dg8lB69JSaSIRGFyIWKfOuj0yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ktdvFXNz; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/30bWoJN//wN27fgfsrZJMN6GinfVgm8SzbdT0/8BiOX2ohUzudIXmG6wiGicp3/Ad9XDe3epGVrTbLxoYUUg1ygY5e7KoxrgI93RsJs8oWx7N+hhuej8PJlXMeyfIdO2K7g9oHjniFJWcYupGPkumpTDO8g1/mNIyS6JU5LSgNq3X6TuMODrLJ1IHSVe4q7ExuHPrR2/ueNhuiGpbx97Gmv91cvwT1paqSBaoiAh1/R5C5ILsPLsEUfZxG+QqZMBJRMJkkS95h03rAT0zgnriTfhYAgX9rn9nzfuoO4ImOceRhXszLJixA5abUNRSGwkgy3fRHrCjMS0k7WK9l1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djpS309rSSK+WBSP4awCHMOgzKMgW+hU/G5M2a8JuA4=;
 b=KfJPx8HTDrOUgwszmBcPhZ1L/GmCESszzIexp6QY4oe0EHla3GGvRT+l3MjYNwV5dF6ISPTS6iO3Y8f0bXg3h+rGjuBCyz0wfvSQvCPuzLlZQrSjDH+yGE+PRmRzEcuEbl8juHMuz32YkEJnohce5Vp58yXrbYpAT8hlx6+dw3gWqZaaBTS1fDKgO4suGRXQ2sijeLGTyUXWWOJDLi2bVruVyVId4pgNORTRibb/w32MCdvCNrAmZM5IrWsLgOed7qPqkX1QN1k82K9qWbZVXRZTVT2mJKglXRJaOZ70cJHRNbGjg6NIgT658gSmDQUrKj3RLXXDD+dwps2CSbu8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djpS309rSSK+WBSP4awCHMOgzKMgW+hU/G5M2a8JuA4=;
 b=ktdvFXNzquhpXlMVH8Fvm0V6156QQVbhPQCt9l0JUeorTLgSg2bcEqM2AgUK4s4ow7uYFkHLNc1X7XKMFIDjFs66aqibfwPCeN2mEVx3gfQ3Emaf1Xj5YAEUvdGmXAzDO/KbIkfPCcc6kDsH7NdsYda1C3DNoovVPQmxgtyICZA=
Received: from BL1PR13CA0220.namprd13.prod.outlook.com (2603:10b6:208:2bf::15)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 1 Jul
 2025 12:19:54 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::20) by BL1PR13CA0220.outlook.office365.com
 (2603:10b6:208:2bf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.18 via Frontend Transport; Tue,
 1 Jul 2025 12:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 12:19:53 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 07:19:50 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [RESEND PATCH net-next v2] amd-xgbe: add support for giant packet size
Date: Tue, 1 Jul 2025 17:49:29 +0530
Message-ID: <20250701121929.319690-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: a707dbae-86d3-4577-1e47-08ddb89995a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pWWk6M4yj3Z/a17BaCar3vMWFxKou9JQ1xBEPfPzWKkj3ww3DpDEuBRCclbG?=
 =?us-ascii?Q?KmUG6QmZEkM/qSfvZvIpsMp3quJ4AYSBarhsC3Lte14+/+QRIIKdQYeED22S?=
 =?us-ascii?Q?nkJ38YVBUVYvuwDxqqZqsegbCsCT/i+3/gxhm93wmwknMi1DO+aF0YPQSNSp?=
 =?us-ascii?Q?elGcYlx8bD1O2P8wDI1ANhAS1I1LpZQSF/ny9FROLj85ujBshTdxDJ8idZ0g?=
 =?us-ascii?Q?YkJU1zEphdBYs5IfLPnhsE4gi6ggjZ0YQyaVmuhv+iAvZygn5VwpQ9EyT4aT?=
 =?us-ascii?Q?SNgaTSG6PZLGC2mcXTSxwZtVSNIyjILrEtla+UOZa/WoKs8x5OWwy1T6k1rA?=
 =?us-ascii?Q?BQCTbFuq7rw2E2TNQQu2tlvjwxpxKgOFpJOTRx0P4/MXAxkwwAllgnjqJTxq?=
 =?us-ascii?Q?kBs7xSe0iIUbeKk4Baabi6Ua9LzA0oPb87SDvtxAlvWfIjgYCoUCxGjEXXi2?=
 =?us-ascii?Q?aLw/86j6uMO6ZIe/0zpVt2zyhY6S9TJ0653TEEEeD1f5ur5evQD2giwI5M2R?=
 =?us-ascii?Q?rbyC/Ulet1vN+5W+fQoUHRx37iskedepScq2pDYKWno0iVmC+C5nnRuY68M7?=
 =?us-ascii?Q?qq/Izlo6tBojUvjD+hgPW3NKvtiCIUNMQ/EYaK0aJJLnERvC4894zfc7TkpY?=
 =?us-ascii?Q?sLjoLuN8PSr/PSmbFxhfntw35Hto6vbSlFfIoqay6aaJOugFDsIDTAibWx8j?=
 =?us-ascii?Q?CQK4mIM3U/Rwb9VqLXIEyFBPDXbvNqrNn3BOeRmjOf4wyGCAq5MIpZtzWXhg?=
 =?us-ascii?Q?zocIHWVNTiW49Pvk6gCXmEfosbKgK98HGWBAHKm6dj+bV63BC+KPaf/7wLu/?=
 =?us-ascii?Q?PrzJdAPwSWK2rq5yPiH9CZAvnla9yFdNiCs5K+QKdR/FLuMGZPQM8Kg4MPwv?=
 =?us-ascii?Q?ZH6c9hm+JuO7sNFEQPqihNjxRy9e+JW2w8qtjA5pGqdVCfbPJqN8V/2k65/a?=
 =?us-ascii?Q?3DmiBiJasteopaH+GxkH0/l+OFRl78q7v3UbOHzQTZLbeU87QDvDCfHQNxSo?=
 =?us-ascii?Q?mwCS//RuE7ff1jdxHjBX8B5zS+QF2KffAj8KtOkPCY8qR1zASrGn5bM4NHHi?=
 =?us-ascii?Q?XxY0WbQCMKsfZIAZ9YPG6/KF4SAr4rz31fNHhkKMb5pPFQU2rSexQaNRrl7C?=
 =?us-ascii?Q?rsCsbp9N5HjBRI/xx3FjAUj2f7FlN1ATseR+IgXZIAp/t6B33g7RFzGXFsYe?=
 =?us-ascii?Q?McoEtng+L7M5h7gKPThpvLbw8MpK3SpZQNf+J0uBgBrcWLuzZm1wD7G7xx5P?=
 =?us-ascii?Q?mqh6+qCEA0ajVSPd8tul3IrokkaZaMSOwHih5Y1Gc/eACBfNm57foxfkfhpI?=
 =?us-ascii?Q?ubd7KvOiUPi/vN2nh86/VZWExhpvHjuHCfb2WY6/V842txnQCMavKd0RHw1U?=
 =?us-ascii?Q?erMAXnYIL0H037J96gU1W3aYa+k1Wky8o9TPg/S+aHflkM9VSF2pAZ3UFl1w?=
 =?us-ascii?Q?PFykqUQEskJTy/0ona910xYgPBVCi4z6XDwSJSLySGxvS/6Zzzc3Nnw9/a4y?=
 =?us-ascii?Q?rBRzlP9YVUz2K5DUxMy1ig7xnhdojIGkdjAE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:19:53.6199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a707dbae-86d3-4577-1e47-08ddb89995a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

AMD XGBE hardware supports giant Ethernet frames up to 16K bytes.
Add support for configuring and enabling giant packet handling
in the driver.

- Define new register fields and macros for giant packet support.
- Update the jumbo frame configuration logic to enable giant
  packet mode when MTU exceeds the jumbo threshold.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  8 ++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 16 +++++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-main.c   |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index e1296cbf4ff3..734f44660620 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -364,6 +364,10 @@
 #define MAC_RCR_CST_WIDTH		1
 #define MAC_RCR_DCRCC_INDEX		3
 #define MAC_RCR_DCRCC_WIDTH		1
+#define MAC_RCR_GPSLCE_INDEX		6
+#define MAC_RCR_GPSLCE_WIDTH		1
+#define MAC_RCR_WD_INDEX		7
+#define MAC_RCR_WD_WIDTH		1
 #define MAC_RCR_HDSMS_INDEX		12
 #define MAC_RCR_HDSMS_WIDTH		3
 #define MAC_RCR_IPC_INDEX		9
@@ -374,6 +378,8 @@
 #define MAC_RCR_LM_WIDTH		1
 #define MAC_RCR_RE_INDEX		0
 #define MAC_RCR_RE_WIDTH		1
+#define MAC_RCR_GPSL_INDEX		16
+#define MAC_RCR_GPSL_WIDTH		14
 #define MAC_RFCR_PFCE_INDEX		8
 #define MAC_RFCR_PFCE_WIDTH		1
 #define MAC_RFCR_RFE_INDEX		0
@@ -412,6 +418,8 @@
 #define MAC_TCR_VNE_WIDTH		1
 #define MAC_TCR_VNM_INDEX		25
 #define MAC_TCR_VNM_WIDTH		1
+#define MAC_TCR_JD_INDEX		16
+#define MAC_TCR_JD_WIDTH		1
 #define MAC_TIR_TNID_INDEX		0
 #define MAC_TIR_TNID_WIDTH		16
 #define MAC_TSCR_AV8021ASMEN_INDEX	28
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 466b5f6e5578..9e4e79bfe624 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -2850,9 +2850,19 @@ static void xgbe_config_jumbo_enable(struct xgbe_prv_data *pdata)
 {
 	unsigned int val;
 
-	val = (pdata->netdev->mtu > XGMAC_STD_PACKET_MTU) ? 1 : 0;
-
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, JE, val);
+	if (pdata->netdev->mtu > XGMAC_JUMBO_PACKET_MTU) {
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, GPSL,
+				   XGMAC_GIANT_PACKET_MTU);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, WD, 1);
+		XGMAC_IOWRITE_BITS(pdata, MAC_TCR, JD, 1);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, GPSLCE, 1);
+	} else {
+		val = pdata->netdev->mtu > XGMAC_STD_PACKET_MTU ? 1 : 0;
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, GPSLCE, 0);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, WD, 0);
+		XGMAC_IOWRITE_BITS(pdata, MAC_TCR, JD, 0);
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, JE, val);
+	}
 }
 
 static void xgbe_config_mac_speed(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index 4ebdd123c435..d1f0419edb23 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -275,7 +275,7 @@ int xgbe_config_netdev(struct xgbe_prv_data *pdata)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->min_mtu = 0;
-	netdev->max_mtu = XGMAC_JUMBO_PACKET_MTU;
+	netdev->max_mtu = XGMAC_GIANT_PACKET_MTU - XGBE_ETH_FRAME_HDR;
 
 	/* Use default watchdog timeout */
 	netdev->watchdog_timeo = 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 3e90631d0a4f..5d64cd9a028b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -80,11 +80,13 @@
 #define XGBE_IRQ_MODE_EDGE	0
 #define XGBE_IRQ_MODE_LEVEL	1
 
+#define XGBE_ETH_FRAME_HDR	(ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN)
 #define XGMAC_MIN_PACKET	60
 #define XGMAC_STD_PACKET_MTU	1500
 #define XGMAC_MAX_STD_PACKET	1518
 #define XGMAC_JUMBO_PACKET_MTU	9000
 #define XGMAC_MAX_JUMBO_PACKET	9018
+#define XGMAC_GIANT_PACKET_MTU	16368
 #define XGMAC_ETH_PREAMBLE	(12 + 8)	/* Inter-frame gap + preamble */
 
 #define XGMAC_PFC_DATA_LEN	46
-- 
2.34.1


