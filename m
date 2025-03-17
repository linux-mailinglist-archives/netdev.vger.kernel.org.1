Return-Path: <netdev+bounces-175343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF18A654DC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AE31898023
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C6F2459EE;
	Mon, 17 Mar 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cSxzS2ow"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC9143748
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223701; cv=fail; b=TzatxK82QynPZrzjdHWZfPEL2IRLj4OVyuP8avwBqkst9IrlwUJTuJH/39qjV9Qgwmlraa6E24PvJClTvMqoc4Vjd0JeQjXjLtJ5KGNaAD1WSkb1+6MOoRnlSbxuaiQLlZqjMN512hE8MFiD1X7+ykJSEZTE8Ov7xKkTYGf3qUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223701; c=relaxed/simple;
	bh=7zTqLjIeVdbsqTFX4gh0xRP8tPxPzbzFdj5nxpV2udA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9fd9z85J3eJgujzGowg3uGB8XWCwVCeCY2Pxl1t+Ud3wQK4m5+TBG90rxolIU8XaRgL1E0J3+gBrZ8VtPwY1cB8sTmQdd91nlTork3I/axMvQOxMDbLlYFgsm4mTWK46KHFuXI4uDbVVXAYYzD/Dkq11LWAk+J0RrJKJebPnH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cSxzS2ow; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6Qd1saBr08SZZ6W1+lG3+ypC3t70rG5BAcbzUW3Oa4ontNbB3FU+bX1nZP8fopA/gfNMuPJQpB2zpHDE5uxOygXcTiDER+8yvJsOR1XfVNz3OhTYHJmWKDaR6rEGLGtCWy4xPWZ6xGWQWrbZyFxcGoJxhScLfcmfrPt2FqAj/9/A3beEbxkmFVTm6wBsBAQp1ymBiKq4A9i1mjHBfmntQcazPOCsWtkLxysJD47cAkRU7gn2XHCbcob+Q0mf+nYQOVyPEKntQVOscMjFOuVy3XGOCkfYtXIOfLusYKKjINo8n1EKf5Gc+CeskRUR8q8ofvYSRtUoYJz9+/ragJjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC06IIL7hzzDhnxeUGXmoJK143rkbS0Yzq0u6EXS2Uw=;
 b=SCvS3DKzTIeVepSNp6N44YcXZmlxZUtdiR9PBSHfMGMQOzEfeh7rsJ6ykeXlWg69mcKDvS8goCgUsyY3NqUiNcKsrV8tEO2GaxKjOFhqVzGayeLd5zhxaReC64qYlvUhGkRLHPMpwf+IVe1k4A0eWSh6DCvyK30AVdUFGK+qNv13MlMr6ohOh4fVn9v3bPvjXLCpShcjZEsHmgdK2+2hECN5H7UDX3qcRaNM16z5d+xP2HPH5150Hrt8KrK2ay5ty24ErgF0oKT/eNDv2+L5jD29ZpGX1Gz3WCliik84Jv7RB68l6YdrhK3xpIhaqk9w8s5G7ld82G1Q3w11UlvU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC06IIL7hzzDhnxeUGXmoJK143rkbS0Yzq0u6EXS2Uw=;
 b=cSxzS2ow2Y8xT88AaGW6jIsBJjdS0g2Z3ImQDpKv/jg0+Do8tENzieA9RkGd+/eez6KK7ovaC7pn78fNsnDwiFZ89KpcVTNtV1XHAVaDKWTvBi0ARbTmQGvL8IBIMjynDAGmAzVbsV3x2n5nio6O6irbL163P0RIkvaMIjMLjzw=
Received: from BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::21)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:01:35 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::b3) by BL1P222CA0016.outlook.office365.com
 (2603:10b6:208:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 15:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 15:01:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 10:01:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 10:01:33 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Mar 2025 10:01:32 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 3/3] sfc: support X4 devlink flash
Date: Mon, 17 Mar 2025 15:00:07 +0000
Message-ID: <6309a6a1b81e7d6251197c8c00b8622e6b17e965.1742223233.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1742223233.git.ecree.xilinx@gmail.com>
References: <cover.1742223233.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 534d5d91-96ec-465a-213e-08dd65649bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GSPWCTBLX7N2NGaZ56JNZzzkFpmHeCKOf8PlH5T/cEYGo1GKu1N+EsAxTAA4?=
 =?us-ascii?Q?NHr1ua/hKYNncV+GFBcZYhMelVBEayEpyYedcKcIcoWb/KMrwqhpl/pSLcE3?=
 =?us-ascii?Q?dkGIn7CUphz/ggamDdE2UzuF+EUGDq//eU/j7GgJ5JPoa/JEIIm6yj4GwOh6?=
 =?us-ascii?Q?uhWIuVZ+3GSf7RJnwbHgjMOEJe7BDsoarCOfLQ4AX2YNN5v7zycIVdvdoz6B?=
 =?us-ascii?Q?wZKxbCmy8K3K4AYZW2edmEuhFHnJxZPuVWZN1CeZLSRnuCPh48+yqpA5q2TE?=
 =?us-ascii?Q?v/4wybexRtRbYLmoGVIzvJefmLeeAtlp6i1x7ZVn6/NHkm5yhBA9RyQR9cBa?=
 =?us-ascii?Q?m6o1WNvjWw7mfq0tYU9GBuc+wFzLoRpsgSdDgaWxb21qGHciaztOJ4mb0IsQ?=
 =?us-ascii?Q?8fRLzzO/s3XMSE9nHCkLMSJ0p+Kxv+rr8H3Mvsox+RbPJIl/kWIk8rOZshx1?=
 =?us-ascii?Q?tT5EUspD/nBBFuEdNFI2+b0CCmuyotQ++J8aUSuaTzdrxCmLCto+SwS4fhQ6?=
 =?us-ascii?Q?gw1LCzokEmE3o3Ef3DdctYOg9FkOA+LZzdlJlSvnpwq3BpL1QGIh6T3d6gjK?=
 =?us-ascii?Q?AHV3ML7J7yoidVA9RyFdc8IKNkiPwg2+G81NezmxrEtFiu7lcyMR0hvaBeLA?=
 =?us-ascii?Q?zBnPMjcpCIXznYOTl4ByrnsalTAqJ6FKHXJ5SVyu2sYlMgfBS/CvoWz9wlLE?=
 =?us-ascii?Q?wC4H7aJRdBehFubCQINhVco28+F0V3m1WykJf7gP4mcc9QjZGseF6I5g1RYH?=
 =?us-ascii?Q?MRbftsis4ZatO9DVx7X/weburS8fIRh0088fxacGneqh2v9IesHoBxLg1wZ6?=
 =?us-ascii?Q?vVKpvY6F7OJSFlEOBpr2sUlmwv4t0t+36a5FW+KdKorqOb1Fx9rCRQwqp8ww?=
 =?us-ascii?Q?//VrkS8t4J1WoR9Fqz/I9VctEWSYevfrcAVCGrdduV6jd85OVgqs+g6vRW08?=
 =?us-ascii?Q?sMNt4+XTDGL4nNPSKe41tgP5i7gAMG36z24p3DzgreJxicNtuOrDJ5nIXxN3?=
 =?us-ascii?Q?jWf7PNxzZ+fiIyNUeQxR5ez6ayfQjqpyso7CQSioECA6i0HEUWiXA1qGdK8m?=
 =?us-ascii?Q?uMLtJulxiidY3BIEyZSX5qP8I9BKKgcfuP3IcI3mL6T938f7jr8Dilj61ahh?=
 =?us-ascii?Q?UrfKnn25nYdZ9Kbl4jP7xPmmVBwjcmfCE8ZImHEbiLGUA7ay65y+hFjnLMxR?=
 =?us-ascii?Q?te0/gkRtrb8kLOQb0V2+gZKZNAbtdtUgY2DXnpdXONfN/HS8cfuF0PxfkAhy?=
 =?us-ascii?Q?dYcaZ7A0AJvZB4HMynjQusoImjqFiAYqmsMhLGTBCjPH7OBYAU4bpfzRhjVP?=
 =?us-ascii?Q?xJH74L9GuhY1waiASBEkKFj+p9F08SDZDCYTweyA673vtISEqJeUbXbpvKwV?=
 =?us-ascii?Q?+PR4UqOsGwlHubt9PL8ac7txtLIG1JlOdX3piP+eEhYHC7o5OBFUEMyGYQZV?=
 =?us-ascii?Q?3p3d/SIrLV24LeYQZtpY9iNrjWcgECl7TP02a+qMoFWFMcTE531mF9Vb8/ry?=
 =?us-ascii?Q?7pwJ+kt/9fFArys=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:01:34.4096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534d5d91-96ec-465a-213e-08dd65649bf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174

From: Edward Cree <ecree.xilinx@gmail.com>

Unlike X2 and EF100, we do not attempt to parse the firmware file to
 find an image within it; we simply hand the entire file to the MC,
 which is responsible for understanding any container formats we might
 use and validating that the firmware file is applicable to this NIC.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c        |  1 +
 drivers/net/ethernet/sfc/efx_reflash.c | 51 +++++++++++++++-----------
 drivers/net/ethernet/sfc/net_driver.h  |  3 ++
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 47d78abecf30..47349c148c0c 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -4419,6 +4419,7 @@ const struct efx_nic_type efx_x4_nic_type = {
 	.can_rx_scatter = true,
 	.always_rx_scatter = true,
 	.option_descriptors = true,
+	.flash_auto_partition = true,
 	.min_interrupt_mode = EFX_INT_MODE_MSIX,
 	.timer_period_max = 1 << ERF_DD_EVQ_IND_TIMER_VAL_WIDTH,
 	.offload_features = EF10_OFFLOAD_FEATURES,
diff --git a/drivers/net/ethernet/sfc/efx_reflash.c b/drivers/net/ethernet/sfc/efx_reflash.c
index ddc53740f098..bc96dd29b675 100644
--- a/drivers/net/ethernet/sfc/efx_reflash.c
+++ b/drivers/net/ethernet/sfc/efx_reflash.c
@@ -407,31 +407,40 @@ int efx_reflash_flash_firmware(struct efx_nic *efx, const struct firmware *fw,
 		return -EOPNOTSUPP;
 	}
 
-	devlink_flash_update_status_notify(devlink, "Checking update", NULL, 0, 0);
+	mutex_lock(&efx->reflash_mutex);
 
-	rc = efx_reflash_parse_firmware_data(fw, &type, &data_subtype, &data,
-					     &data_size);
-	if (rc) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Firmware image validation check failed");
-		goto out;
-	}
+	devlink_flash_update_status_notify(devlink, "Checking update", NULL, 0, 0);
 
-	mutex_lock(&efx->reflash_mutex);
+	if (efx->type->flash_auto_partition) {
+		/* NIC wants entire FW file including headers;
+		 * FW will validate 'subtype' if there is one
+		 */
+		type = NVRAM_PARTITION_TYPE_AUTO;
+		data = fw->data;
+		data_size = fw->size;
+	} else {
+		rc = efx_reflash_parse_firmware_data(fw, &type, &data_subtype, &data,
+						     &data_size);
+		if (rc) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Firmware image validation check failed");
+			goto out;
+		}
 
-	rc = efx_mcdi_nvram_metadata(efx, type, &subtype, NULL, NULL, 0);
-	if (rc) {
-		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Metadata query for NVRAM partition %#x failed",
-				       type);
-		goto out_unlock;
-	}
+		rc = efx_mcdi_nvram_metadata(efx, type, &subtype, NULL, NULL, 0);
+		if (rc) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Metadata query for NVRAM partition %#x failed",
+					       type);
+			goto out_unlock;
+		}
 
-	if (subtype != data_subtype) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Firmware image is not appropriate for this adapter");
-		rc = -EINVAL;
-		goto out_unlock;
+		if (subtype != data_subtype) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Firmware image is not appropriate for this adapter");
+			rc = -EINVAL;
+			goto out_unlock;
+		}
 	}
 
 	rc = efx_mcdi_nvram_info(efx, type, &size, &erase_align, &write_align,
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 6912661b5a3d..5c0f306fb019 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1381,6 +1381,8 @@ struct efx_udp_tunnel {
  * @can_rx_scatter: NIC is able to scatter packets to multiple buffers
  * @always_rx_scatter: NIC will always scatter packets to multiple buffers
  * @option_descriptors: NIC supports TX option descriptors
+ * @flash_auto_partition: firmware flash uses AUTO partition, driver does
+ *	not need to perform image parsing
  * @min_interrupt_mode: Lowest capability interrupt mode supported
  *	from &enum efx_int_mode.
  * @timer_period_max: Maximum period of interrupt timer (in ticks)
@@ -1557,6 +1559,7 @@ struct efx_nic_type {
 	bool can_rx_scatter;
 	bool always_rx_scatter;
 	bool option_descriptors;
+	bool flash_auto_partition;
 	unsigned int min_interrupt_mode;
 	unsigned int timer_period_max;
 	netdev_features_t offload_features;

