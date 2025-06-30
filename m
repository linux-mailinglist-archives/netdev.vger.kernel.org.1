Return-Path: <netdev+bounces-202534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18578AEE26C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6257D16511D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF128DB68;
	Mon, 30 Jun 2025 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rbNm6WtQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489EE25BEE8
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297384; cv=fail; b=SsU0gNNnpPGwsOS1nxc4kUECwmTASUHOi+QpSyinWxeUrXKvAJDVkk3g0DBDsLvtTOe+ah5tfoo9FF9cYUsErz9Kq4aM2+wzVHnDPeWk2jb/A69qjtOTD5QJj3AxCGSsBsyUUcqTlzn+WiUucpuhtN8BJMRGagFgWYEao6HZ8PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297384; c=relaxed/simple;
	bh=UwOUrf3GRZSNm0U7R9y4QtPsgTfQ4bE3UlRz9Br5LnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCIrY8+q+y/o+TMgSlkcliguVxhX4sjOFHxrmgARvKdyLA0/DaM1Ur4kLd6JwRAIvkgHlY1cCdmP7xS5JsdjTIL0LamFIeFjja81v9KHwSOi5UvazjDwg6jvR+vjBRAuZdJniLKn32vsjgFWxcuZZn3WDJnEq+/AoUWarUOdsFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rbNm6WtQ; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/oVwzSVM3xgEqjoxAx6NEKFUsSvnDSsIWscphXhfuFYx/2R5QmQiZG5YZOJkfNyQeJNP7R1iw+bEyJrCrd/lNEnXjZ99Lve3em+T+PzfCTIxO2BoTWhK3MnVpcA663C4zZDFWSFNWJ2BJYSAz2kQVuuN3bOqfBt4da1kexSHj8DMxDEQlOa2AwAEUqiLnwog+SaOltzgF8er4G/K/neZRlGUhfUd9cPkBPY90kiE3AYK5o5saDiH4QtRyCkj+/0vNWDIbTgFeijA2fbDhIQnVt4H64CNO7xveFkqyPLrlvpsTN0oHy9yk98ffuqDNY9kxOednKQ0bZJlVdHy0HIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGbAovGuWZ0j1OtH8Dg9gcEmqw/gK+9jq9FtjgTz3NA=;
 b=c6dvq0EgtNO+zBuVJk878Cf+qydwoZri+ZdYbDwynsh4c8jMZHKsrOiDbtk86GtjL2en/N0TJtD6ykKLseOXU1K+AS6EuWmmN7y9UDYyU67tSgGvLYedia0GBn/MuPMM6IIRyxHdIHIWvy2jCxLmC5Oy77Zk7hSS6zu0UbNS3H/b5oDi+phPvP6gRa1hwYqyfbuib2oPNJHOT4t94iaGCipuualHjwuN1Q+bHExSh349VDZSwrFcBfN4z1P3jYhF+Xu50HG2QkbhPYSeVrazcCit3hMqWrULbcl/I33xYmNhaOkagGIzFBUcHsKR8kFEKw3r8D9J994TyIldvOA6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGbAovGuWZ0j1OtH8Dg9gcEmqw/gK+9jq9FtjgTz3NA=;
 b=rbNm6WtQUTAatYXYSH8Y/+MGliJpzBGyXOLB43Z3Sraq38kYny0/uNbJ0iCrUis/YREu+bJoMVyXXWqye17Vsl9QDBFNkbtqMboyOT+aypRBn9d33duEuVLhXs/ghUvHrQxGpTdCNncPJQckGjnoLa3VWPd8mCkjEtn8+q2e2tk=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 15:29:37 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::65) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 15:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 15:29:36 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 10:29:34 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2] amd-xgbe: add support for giant packet size
Date: Mon, 30 Jun 2025 20:59:01 +0530
Message-ID: <20250630152901.2644294-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: dc25f12d-ccbc-4708-6fb3-08ddb7eaec16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjVVBWRb//Z4JdKpdrCvDoN4/vEMMv5jCCPVraj3lKGDKqapyV5BnaY3++ol?=
 =?us-ascii?Q?svWOZxvAKzhZCCKy0KMbHs17Bvux7OzLhmzJR9blcbiNWTH+veFtoX83Uwjt?=
 =?us-ascii?Q?oZstGqfyJMzV/w44/0o5PsDCiheqjWDa8PKUUZd5p2Q4KSYFnR8Bx8tYaebE?=
 =?us-ascii?Q?6RcNYj5HfPH12HVTxF3l4fNd0TVM/x6mvpC1GtnsJH9SBehOXG3ViOXe9z/n?=
 =?us-ascii?Q?Rm7WDpisseEWnVzIvWJd/ygvV8h60Kj83Zs0VEfGciGcP6VrPr2kF2+3SEuH?=
 =?us-ascii?Q?pokCX0WHDwsenYyda4pk313LgvZrpC87T/pxv70W4qr9NmMKLAT4F+wiCOiW?=
 =?us-ascii?Q?a1ixZnEDqJWsTzYavZsJwzHGRFRIQsYWma58xeyIn+tNLlONBt3Gaoe3vlzA?=
 =?us-ascii?Q?/MK+nYlgmwjH0hgFYfByTEnMmjSAr6F1yMuCObUi2Bz23gxiQD1POo/rXDDm?=
 =?us-ascii?Q?81ebjHFZFYFLp/wGyi9lHJ/k6H0ct8XKeDaMziabExpDx42R4KSab4IsZdQR?=
 =?us-ascii?Q?T46EuA8asIXINHwTBDAxgc0A0/hQtvgFH9iRXoBJvFwTqZ66dq1023TbrrPp?=
 =?us-ascii?Q?GBw56M/t8C/YAMOLlvmNviNVzfYN6H8jy0xzqijNbVsiY8DrrLc5YTKiBXlV?=
 =?us-ascii?Q?668PHO2+19m332Z/fVdLQ8rP4BV2rNpGm2xe2aVD6wQGO/wusfKCiHAskJ/n?=
 =?us-ascii?Q?xMTb95hA2jx0AI5rwc+YeSiPOkooOMnl5NOZhVlsDPd/l5n3GHTHKhV3pSp2?=
 =?us-ascii?Q?N0AGH1b6AYht6dRbtnm2AlyOZpFHfLtusUDU/XwXIp3yjo+cx/CR6GPwOtOH?=
 =?us-ascii?Q?Z9yy0orXtSMQYqBZ2OnBQJi1MNO3QFkSyqfwyIJA67QBSYuxNKj+yUlBkG9y?=
 =?us-ascii?Q?zyL8rspTUYPGmzNrqBK3nl0LtQ+5mTXBC6dJJhpRytd7VPT/7D8Ui07cbVUF?=
 =?us-ascii?Q?5/DG1DRgGF9e/cZe+xQ/qFptSa2L19kFHOH+8jHNcB6rqdkE6aImXdLGKvxV?=
 =?us-ascii?Q?RfEB0f05OppIzHnVOAiODcnobUkA6wu/+1kXTs8TI79Iig+fkOlZzs5pjaCM?=
 =?us-ascii?Q?RSqp84jf5hKQ8F3/o14c3PszGZumkmUIkUMZt9FHQomWqTKdE3gJ6WoAg77A?=
 =?us-ascii?Q?3lb1kg7jFIhFEH9pK4eGBh7RJTizBKUTIR1m9QC+XVjf/bTy8J21ehtgXg7q?=
 =?us-ascii?Q?y82r231x5IKpgDM6TKEpEjNVQ7Kpi1jNJ244eGs2UNv7likC71h8XT1zPHmf?=
 =?us-ascii?Q?424C0ZmUHisKvr7JAa6wArWpZmkISVY1Dqx+N/ptuSbqDilA/qnlJCHEYr/K?=
 =?us-ascii?Q?rirICYhYyTNXHiBHBZPiTB2jJ/agNiG1vUiiHFQJF457KkJmTknopjPzdeUu?=
 =?us-ascii?Q?5Xi6lQks6BsSCVrAhjkf1pbJLrkCNSdn8tGcx/ujJxQIBK8+Dvez/lmwOfqH?=
 =?us-ascii?Q?P8EX7D9ZFNIyxfkQXfgaG+Y+MeAT3b8Fnv7hH8gXyeN/N3GN2HfYNxe6ofX0?=
 =?us-ascii?Q?F/87U1llDsBToiJ7mNRC+LS3ThxPMcK7DQ/B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:29:36.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc25f12d-ccbc-4708-6fb3-08ddb7eaec16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

AMD XGBE HW supports Giant packets up to 16K bytes. Add necessary
changes to enable the giant packet support.

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


