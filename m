Return-Path: <netdev+bounces-180420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08FAA81473
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7292885878
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54EC23FC54;
	Tue,  8 Apr 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eiXqGDWD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E123F272;
	Tue,  8 Apr 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136443; cv=fail; b=aDrZzfXFKryzJPer1/HANhEd03ME20QnBUC9nkMjOLVYyYYwqoj27j/I7TDRphWXYpCRL8qiJY1TVj7Em+GFxfJ4fBao6ZRhiGSlsnxKfkgUX4NebJo088hZ/vbLY4ROXruRJxvLEftLQ5BN2hKxPDOndfgVoRO3QYNoLay664E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136443; c=relaxed/simple;
	bh=PckhD1YeyxdD98DKNXKOBeoPevqSAoq+y/8K+P9/cpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzFNHzpRb+kLHl2RGewB7dWzypxIgvjQPolhq5RQYdXBGqa1VLJTziccK7SeA6o1YxxqSyZgbsIqF5A48uRje+MKJtBuAYGOfrdD2/Dv7twdH0xOv7CkthUh7I6WD4C5AaW64flS+5FI2Kv+V2ZFXQD5DWAiYGjfxA0BMDJYVcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eiXqGDWD; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPmtWoCt8+YerYEikgy40Q+IssHCtotecBcH1UuIFfwEmiGu2s5+a9vutnl1vDaYiCfwNBirq26yoWctGv2ndzcPbBPa7dx3T86m0z6DIUOTwjlfaf7DtvcxFV4468By9YdZxANV11+OL3+oaVwT1VdAjk7KeG2qAJ6a42GcEtAqYmRTt0/Ywk7qYKCOUI+5oYIm29KhvqdDsjffrYZPWUKfxDf/Q2GD5iKYMfNjSEeuLYx4FAX1qQSOBDGGz9miYLiAw/kuyNFoCwUbGDrvKVBB46pfzlCwh8UnhTTlTz6UEVHF3Fvb6ajBuHHJkI0CK5MB+Vp+HpCxeWe3Ey2tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuFIdXaFTJwNCzGW18qo58ySdJDjN456xS80ytzOHN8=;
 b=LJs+6LiICX8eccLhLUiSxR/3dwbdwO2D1gR4LGQrSsBGQr0PxSBC5y1VGh/l45BfxsSmvChw0VER+mQknU/dbXQsS4GAe2cKN1qverhLDa/+OB3ZpFImNOahsDd2Ul3lbgUFiE3PC0loT/r25KZV1I8i8W85H6vah02G/PfhaopdaPaUrLpf9Xs2nKk3dD+341yB5FdAcgeS2sr9H+tFnoUYxKcL+M3ijYM2zxGwffXHy+2T8Uewv1b68el9gkVl7xzYh2RWStMNA66U1u0MLEVnzUZreVjpEtXhIiI321sU9uknLFmrgzW/xLfD+OnQLeBXjfqQ4WI1ge2T7TMDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuFIdXaFTJwNCzGW18qo58ySdJDjN456xS80ytzOHN8=;
 b=eiXqGDWDkP/D9V+UwueJkE+2RtTqnGvWp7maB3+wUSYqXT+auCPW14AsBxC5m5hculqVX3QaUmkeli3kjgIHPW/lJNVp7k3Tpm9b7HlU+52T1s+l58yBKJjhqxbeMmiafIhlA17aULaDiK7JcG0OWJACZnCa0XF0RY06vjgB/zs=
Received: from BY5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:1e0::24)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 18:20:38 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9d) by BY5PR03CA0014.outlook.office365.com
 (2603:10b6:a03:1e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 18:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 18:20:37 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 13:20:34 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 2/5] amd-xgbe: reorganize the xgbe_pci_probe() code path
Date: Tue, 8 Apr 2025 23:49:58 +0530
Message-ID: <20250408182001.4072954-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea2e564-752c-4a76-7e85-08dd76ca0ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRe61hGLj0OdUfaMlOHmtLKWEHYSqThci2poShvz9KBxQLnvKvPj1xpkbNpk?=
 =?us-ascii?Q?TzT+Qcnif+TfxajC/2IKMX8FRRdweWlcF9hKvTsydFR7jzAXblF7h2AdAn6v?=
 =?us-ascii?Q?CU4ugLws5nRFg4UVo+RLyAOBUhwOZyhUczZ9LevSwiXeACY0L9uIyv0SHHNy?=
 =?us-ascii?Q?kF5JopjqZBuCTfHVvspFq6K76jwPtcj6rvvgvn45X5VXT0ongahYVPOgtPzO?=
 =?us-ascii?Q?GYHudSTl962lfsUEJz/kSPgI9BztRg/QAkU3Rqv4D/RugYyl1G2PteEWLqwb?=
 =?us-ascii?Q?ove5zTYtoT0E9u6sM7rtg2480RGj9YCAs0CJfUUlnpcTRldYzhCEQbAmHHQV?=
 =?us-ascii?Q?ShOzj0idotx37WwUGlZIw64jfN1o8bu1QRuqvBEYie61YFJk9C7pRrqpe7jQ?=
 =?us-ascii?Q?1K9zHbBfTALTCByVdmJBztcbkt+JzPQEDd1YEP8QZDOAXxBvWAuphOJycPZn?=
 =?us-ascii?Q?Jdi1F7wWswVDWb2nNoUE3ojwUqqo77t943WaJXYMgpJc6ceSbIRjiQtdpLv2?=
 =?us-ascii?Q?4w12nbsvNL5oESTFFQIvSQGolOXYn0tIyYsm+XyS7Ph6Db+96qxsy8ehxBfw?=
 =?us-ascii?Q?Kg1pjSQ6C7mPKDwoMHpMRUCGNwPViiRhcgmAIuAz9mtJg1pw2PZcdNGFJiPl?=
 =?us-ascii?Q?+AtoQRniid0r+zap/Azpenbc9mWLfMJ1Q48VDEF2YYjz/u/tT3w3JLKJ51b7?=
 =?us-ascii?Q?D1DnIRrIIYx8pZWCxptS5hOE2D2XSDt08fSsVwk14FMdfzOD0oAB4q788fvU?=
 =?us-ascii?Q?sx/XeVscfoQ4/tW3+y7HV66LWboDOOEA06W8b0SNWAJjEKdYgfInCCDEcOvR?=
 =?us-ascii?Q?4sVuwYN2Bd2whfYAGPLuewSAPLP2l9clOSG2myf4nISojGgurBP44lfmJkJd?=
 =?us-ascii?Q?zk/X/wT69gdLBJsQFRkJ/NAj9O3xd0I69Jb+ao1j42Y0qK9bqFpF4memP7Ro?=
 =?us-ascii?Q?ahyb8IuOinS6+45WX4WncVq0xf8lH5YF+tEURGJDUa3KR4qr/phs2LeNHjKx?=
 =?us-ascii?Q?+XuoaNoujQXZ5dxL5Qwf1xTH8AfV2dz6HF8QvsTzmWUeI4Tk8dVs2Qzl+hs6?=
 =?us-ascii?Q?wHTd+GD+7KWbhv+JHTelMv030Pc2T/DtLQPLCk+Sc+WAwVtSSqbhqHbqMMNE?=
 =?us-ascii?Q?DAojGICOLBM1z9skg4nSKAesqtNRvFwow8ojXMv3b/rtc7QLwztFZ/CbUDXq?=
 =?us-ascii?Q?WMQ60U0q5WsER67vbNzAw25XJnLBAEaFb1Z9VhSFtOXZbupdCshL1r3UEpP5?=
 =?us-ascii?Q?SNBHfHng1Fp0x4nmhuXCmj5zVwUYsiS78S0whBjf1XDand1XENlzV2BLncok?=
 =?us-ascii?Q?CQzBC7hEOa1XcMOZQdYobiSi8m+41YfrBd5sDFkzPciOxJd3X3RQT5XEMj3I?=
 =?us-ascii?Q?l+EQlOYTTI6GJ8KjL05jQ09Cvt6uIhjctxPBgm0TdvR/LlF2Gkkz057PRrMS?=
 =?us-ascii?Q?dS0gzK2sx+iYGaNieS7n2tH8ykPvvTuJIlz7OYyzUI1ifem+0BBWlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 18:20:37.8159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea2e564-752c-4a76-7e85-08dd76ca0ff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

Reorganize the xgbe_pci_probe() code path to convert if/else statements
to switch case to help add future code. This helps code look cleaner.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 35 ++++++++++++++----------
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  4 +++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 3e9f31256dce..d36446e76d0a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -165,20 +165,27 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Set the PCS indirect addressing definition registers */
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (rdev &&
-	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
-		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
-	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
-		   (rdev->device == 0x14b5)) {
-		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
-
-		/* Yellow Carp devices do not need cdr workaround */
-		pdata->vdata->an_cdr_workaround = 0;
-
-		/* Yellow Carp devices do not need rrc */
-		pdata->vdata->enable_rrc = 0;
+	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
+		switch (rdev->device) {
+		case XGBE_RV_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
+			break;
+		case XGBE_YC_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
+
+			/* Yellow Carp devices do not need cdr workaround */
+			pdata->vdata->an_cdr_workaround = 0;
+
+			/* Yellow Carp devices do not need rrc */
+			pdata->vdata->enable_rrc = 0;
+			break;
+		default:
+			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
+			break;
+		}
 	} else {
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index e5f5104342aa..2e9b3be44ff8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -238,6 +238,10 @@
 		    (_src)->link_modes._sname,		\
 		    __ETHTOOL_LINK_MODE_MASK_NBITS)
 
+/* XGBE PCI device id */
+#define XGBE_RV_PCI_DEVICE_ID	0x15d0
+#define XGBE_YC_PCI_DEVICE_ID	0x14b5
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
-- 
2.34.1


