Return-Path: <netdev+bounces-176561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88183A6AC97
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C1B3B5865
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3982226173;
	Thu, 20 Mar 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bm66i1N0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332111DE3A8
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493543; cv=fail; b=cUBJREurblIqpv5MFiTafVclkzIns5Akhy4gTgqM44n58HQhEOTO/x32eZ03xEI9Z1M1R4ZhmXb2fSXttF2DjCiw57SN5psKmJGjdkmfE0c1t+HPSifEsJ5rZ6M0CyPC6AJSY37PTBaiplLpgjJjpjdSi7zlVO4X7tgtqsfFk94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493543; c=relaxed/simple;
	bh=RnBMTzcxlQtcJuY+noUJRuw5QH+1DLHqHwGunDT5RKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUpJLre/KSn9X9O5IRLmljsmJcvh2CJGBtUAP4N3oJWPoiDxaJTdkhIVJ0sy1GT4bU4Ro7Lm79kMaCqd/OUt6cviYb6fMMRgSBQvxTOnWjmTJ5e5N1leWoUb1PwoJlzI2Z7k4duO1G3d4svF7Ie+OUT2RMIysbOT1najcXrqk3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bm66i1N0; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKYag8iFXeNMp23VGbwYsHtCB29OXXu8OeoNt1JIIVSSMBwo83rpKZXGV0RVPTw6O/gSM2MQCZ08jIv90a588iDkhLl7/HZO1hCeuXvUKKfIyVa8TxNsonnVQHU6TlSfr8WunhWy8WRRdSKn773WuxwX9BFT738ufPmB6Aqjkd2VOqwI1pJv/wNgb4Yptw8I8Yb6hmPBhhTxozfOSYC4EfFQ8IP0Vxh2jJhmwT6s6OUEKk263yTHdszMMcD7sgOdxsTmfZCnUFNI0ZAvjPnI5+p80spHCByJ/0Xzaw4lORROylE2aoc73LawxZObTRSO13gHCk1QriCWO0uK5b+Etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djxRENELeu5NDvZehwmt2TUamriMsyMoQ7qqRLlNjrM=;
 b=mP2YlXBBUMBUvDKU0gcPbyaG2+cfMmNIdGJ3fHUP0GL3aMipNw+RxchM1D9GacNOcpCp6M4oP3PpdikSN4Fkl19Con+gfmm0jeoaX+Q+WkiBB/q66GoIM0ehF2qO4BpbgLYO2WgBkfshLbcrRXk7lFAi2fyOCn0BR4D4cGxMkFFNSLknPmPbyxyJAYIxvLoouUJBbOdtvoBNY9mErewQuxJfLJG1ntCEjWtGj8RJQ+Ttbc3w3e7s4DHToqnjqVdiJ6LdJkhsiPHW0nluuJdEQb1PwI3YifowguqTVv6rdzryj8IneYGHbF9ct4zfA1gH98QL1vJ168LB4aj9NR1edQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djxRENELeu5NDvZehwmt2TUamriMsyMoQ7qqRLlNjrM=;
 b=Bm66i1N0I/BgskxInL9ad6UX8iKNYSbz0x1OYyEOKX+lno9hW5WSaIq7VBnmIZ7afkEhvCqt+wB4MISEKhzN8ak5M1YnZY050p+OrgZRvFh7M7corqahyBeKCWDu2WHo0RbSofjAos3hc22RSoKUzfZDMA6sI2w984HEp7XF+AI=
Received: from SN4PR0501CA0041.namprd05.prod.outlook.com
 (2603:10b6:803:41::18) by SN7PR12MB6837.namprd12.prod.outlook.com
 (2603:10b6:806:267::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:58:58 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::af) by SN4PR0501CA0041.outlook.office365.com
 (2603:10b6:803:41::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 17:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 17:58:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 12:58:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 12:58:30 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Mar 2025 12:58:29 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/3] sfc: support X4 devlink flash
Date: Thu, 20 Mar 2025 17:57:12 +0000
Message-ID: <9a72a74002a7819c780b0a18ce9294c9d4e1db12.1742493017.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1742493016.git.ecree.xilinx@gmail.com>
References: <cover.1742493016.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 1746e12a-06d1-4a77-08e7-08dd67d8e3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A4ujezJdSMqsHSPbluLwlMiapxc5Blbg4DtfFGJAUiQ3DE0JrNmmQx7CMaR2?=
 =?us-ascii?Q?5nK+U/pKLlqnyd18FgPssFyTZtTb24yAigeMgwGvDuBP8GNrNLQsqhSODUYX?=
 =?us-ascii?Q?E7Tfriiub7h77kdaNjMVzLyUTCdOED82Vl4kqVct9Caul8KOUZ8OZkekQVnC?=
 =?us-ascii?Q?J9qr4z6czoXjEhFnn+0qKmdpmto6nzjhdYS3hG51MviI076MijKS61JsaYjC?=
 =?us-ascii?Q?glZ3w+KMuE8gSAixOsECivwtkkjs2Pw9Zv/D/vhofdMASv0qj57cDyYVZw6F?=
 =?us-ascii?Q?GS8Pzl8CESVFjWhOQOIlpBK8pz9irqEQ9w/9REuWkk6/eWae8IchGAhdSVBl?=
 =?us-ascii?Q?sTSxt0nkc/cDREGaxmGgXLaw0FQ0rj3zGQuMV5Hdpl62FBQ5ywYpANUeMiVn?=
 =?us-ascii?Q?k7YN0Gnu3ewz8ia5nkMCMHYxW6UHyP5gQ+MQ3XoHY1C1z5SkvatPu7nnwgcU?=
 =?us-ascii?Q?9dNyFvne1IdVII3XBY0cg5avARdnsF+/R9uOXEHdMEDVxPhnpT/x45gyHWZX?=
 =?us-ascii?Q?QwHiNLVeyLtgcIG6gack6mwlhdvNDVHsIkOBOwJ7aDt5LxkS5c3WN46NKtpd?=
 =?us-ascii?Q?PG8AnmCARhgsj2tENJ52C7geJOBzEi5A01veBaMhv2Mrz/Lf0e/Dn1dWPS56?=
 =?us-ascii?Q?EnZF4Uy+7/mnaLppr+vHAxlZp56ZO4mFU3TGeESNZ74XV/XZi7dQ9P3rrChF?=
 =?us-ascii?Q?6WdM0jbgAIdudsiSRZb8Lo2RkeyXTcBW1LcQO6pmoPFT0k6URIueRdfTln07?=
 =?us-ascii?Q?ErLjnI8Se4kWqAO4sY1Nb9Dhb+4I5jUr9Rv9wWeBg+1+qKtnYy2c5AZfgZiM?=
 =?us-ascii?Q?iqMebQUWVw/z3ao5GyyqlxuERnfeeXEic7lw0QezjP+NuDgGQRta993kox4r?=
 =?us-ascii?Q?0e3AGJR2uvKrp3yK0FW59Rbt4mZ7XyI1IFhagnpDgXP22PM6bnDT6Bz51H2g?=
 =?us-ascii?Q?kJmeeqzJUAddBB8U6h22th+sirqkY6PPyM39RUU7FZrCjJmaramp0bnZxyRl?=
 =?us-ascii?Q?X8fWPuyk3CPES6Ulpr4Wf/LRPX9ZmkgEKRGbHDERfN9LYEyEdyg5zCk1WMHP?=
 =?us-ascii?Q?+P+guSDxSVNi+TPZfYCV188cSt56l1pPxV8Ailg2sbtro29WxLl2TzQBUXOI?=
 =?us-ascii?Q?/qRUzw21DnSbWUAlU9Hf7IDcIcqI55ysH23o8FtmBu3N3Ov2NZWV138PreDR?=
 =?us-ascii?Q?ChVdFTTZyvrTDqw2AM9MlOhlhuK1Z+LAcjUdMLQKX2KGObKUqSo+/HUwrULR?=
 =?us-ascii?Q?Y5quzqAISNn4nb/qKGT8PHxg4A0stYj1WHZnyQ9xdm97KGzPqxv/i72V7Qhf?=
 =?us-ascii?Q?IX1dDMLC2mMGu1Y6UieacnCXJjD4BNt4iB62WR7Mzf+ZWd5ixWJG/nqtRCem?=
 =?us-ascii?Q?cZdr+lwwPFJYyWYhByvPUnDpde3tWWfP06eTaZIX3b6/5l18g0+1eXrUssfl?=
 =?us-ascii?Q?AJESMDbuCNm+pxGUSj/A692VU4QMebS/jx1+wKx5F80hIuvNr2Fs3GSSe6QE?=
 =?us-ascii?Q?i3vzWXnOxrYZQrI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:58:58.7987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1746e12a-06d1-4a77-08e7-08dd67d8e3c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837

From: Edward Cree <ecree.xilinx@gmail.com>

Unlike X2 and EF100, we do not attempt to parse the firmware file to
 find an image within it; we simply hand the entire file to the MC,
 which is responsible for understanding any container formats we might
 use and validating that the firmware file is applicable to this NIC.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c        |  1 +
 drivers/net/ethernet/sfc/efx_reflash.c | 52 +++++++++++++++-----------
 drivers/net/ethernet/sfc/net_driver.h  |  3 ++
 3 files changed, 34 insertions(+), 22 deletions(-)

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
index ddc53740f098..b12e95f1c80a 100644
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
+			goto out_unlock;
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
@@ -506,7 +515,6 @@ int efx_reflash_flash_firmware(struct efx_nic *efx, const struct firmware *fw,
 		rc = efx_mcdi_nvram_update_finish_polled(efx, type);
 out_unlock:
 	mutex_unlock(&efx->reflash_mutex);
-out:
 	devlink_flash_update_status_notify(devlink, rc ? "Update failed" :
 							 "Update complete",
 					   NULL, 0, 0);
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

