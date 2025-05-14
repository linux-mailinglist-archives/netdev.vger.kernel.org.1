Return-Path: <netdev+bounces-190427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94345AB6CAA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFAC19E8959
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0327A914;
	Wed, 14 May 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fCRYiPT0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1A27A465;
	Wed, 14 May 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229301; cv=fail; b=atJTmv53KXrLmYmXWoOyfYAdZFgeiA4bZxhcWBIWxurcTzqk+ZwTqQnCFyro4r0+x730dxDthagfbXTbmmUmevxvac39/5iTOLt04Nvtd01ohB1ppEm9sFNbvcLLAnS2WdTY9i/UUJd67kNMxHakrtvGD7N5wC8wSbflidS2HJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229301; c=relaxed/simple;
	bh=Y5O7sKrIsQM7D1Ytm2rhOAHA7sZfC522v0M2DD9FG+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+UTmGBLxq+FRrSQPdv31mbx3fcCXX2n4vUufx3bNgwg951P+E7kcIp9jsPIAxd87L3zD0YaiK7aZ8oxm5ojys7JZSdaHEkMSuZdqBsBQa04PNguK/mJG9Q42gUkaAkEpiGa86ZDjE4YArk7jNdzg1fHiGADh5dWqY3vHW71XI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fCRYiPT0; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSel2/RiGm2aUqUQVOkp4jl/RiAfDkpCQBzahE/08yHyHILQZpcRjve+Wh3tl/VPtjnHj4NjPNfvJPtyrkMc3/TbXro3Y1f1oGcoTxqEIEdBiMGRhPOsiiJlOrINnlteBTVg2Q2T2vaYEt9sQXtrXofTbnuLPC+GOKRo94vevzMJ2L8iDyDaY3769a3P/zCsO1Zf6vXob6kJTAar02h3TUJHwrrOOatzfZTKhGwbUnNDg2e2oZNlflAE9Xm4Alf/xYelMiluc4DzaSzNFbvXWjhKDzJy3gyP+ojx2MBD7v/MPMkYjqNmPSj2D3Uj7Rs4Aay8fMSPPL5KH0dlKVjkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK+nc63Z0RKoDvZc7Fom+5deXWTtq8gAQvl+nRGIjv0=;
 b=ZQgjE9ETvIPsfocjWnB6AYLSLcgekRfYc4kKMEYJe13aCFtgQif4eCjDy3yp1qnVz3xj1n4NBapCV2rrG2nfVKsHgg6FjB11/38C5XnnEQihtQX5fU22/QSjk5XsWiUiUq0Si4mURfOveO7yB51jPgMc9hLKcCpzKFtyBsr+/f2xdo6uBNHMlSu+rQvigdSfhCGiAvmE6CwfOshUaXZn6l1DVuYuUTnk7f3uKmi2+pYxdlT9qt61XIVX7p+XvWM1pY5juV7QmuROCwH9uWHnnSkwKzisuzLvxbpwL9FVYSvZ4mytl6e75T59b3kKeiQ5k7yIqEKlNd+Hf9qz2FVvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK+nc63Z0RKoDvZc7Fom+5deXWTtq8gAQvl+nRGIjv0=;
 b=fCRYiPT0tieyXOq8+e5T6ZaJP2DCjwXvgYlS0CEc6MXvFv1FXYQKR79ZUEf7s82FD3SmuHw4ti481gqv4ox79xaiZz+U6CNmBRloxEEJsDUpQhdi2wB+8PtlnOhyPtzakjXfq4u7dREa2Ccxh9i+VYAms0i+LKaj8lBjrH9Q2OA=
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 13:28:15 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::8d) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Wed,
 14 May 2025 13:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:11 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:10 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 12/22] sfc: obtain root decoder with enough HPA free space
Date: Wed, 14 May 2025 14:27:33 +0100
Message-ID: <20250514132743.523469-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4813cc-87ea-4f40-6946-08dd92eb2e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BKDjc8dGe5dK/4PEzlPI3LbZ8fqEUsTV5lrqksm1z2NI7Hp6LpjTTKcJkhR?=
 =?us-ascii?Q?qdubK3UzhGzUCmMpAy5mE3Zsy1oodxbWN+TFjq70g+vEbrOIHJwxaOIGH32q?=
 =?us-ascii?Q?fPhXM0S2yZEiv2DV76670+0TTYOTr3vaW93AZ1q6xELqc9UcGeDFMZOmGx8J?=
 =?us-ascii?Q?0CxMDaOJ7SxLNTyj3N1FNsr6F5yH8jj4hSWI2kZqIWl6r+8EKdLhJ4vm7L8j?=
 =?us-ascii?Q?KY+xcuE3eKnSANfpg7UXhKe2a5uAiPCoiqp8KAX2kWAVMtKdyZPeEiAF8BTQ?=
 =?us-ascii?Q?aEKInqdzJ7Qj6nu/g8F3Mv1m94dtsb4OMOh4yJDgIYvb/xbmnGO6l/GTlOTR?=
 =?us-ascii?Q?ahKSbhfjpc50HTVhIbql2mBcfCSXAHjlG3Xwxe2uHozh4x/utGXO2eMEcOOH?=
 =?us-ascii?Q?gwUJqyJhYeevqKBpofce22cGZF55u65UdojIpHEfL5roA0uoFwv3R0C/WYYZ?=
 =?us-ascii?Q?Y8/QvYcfZ8CBl7m6Vh0ZxsAZSqzLHSfAD1vtXQWMu+oA5G4YjtaBNCoq2nZk?=
 =?us-ascii?Q?Hjy9L+CcyU6WcWpcsBh7VvTrGsMjBtFaKexj+7uD6icCbatv2K0Ava+TVDfe?=
 =?us-ascii?Q?OnKqcM1J9AXAtJPLxs1mX925ck/IAHek12fh3Kxe5T89FdRwXLHIgmP2tqIb?=
 =?us-ascii?Q?7IkJNwrDDEdr3imgTIZtIbepqZaoHeneF6VI8VRrhqQkqTP+hvEwaBuzxTTG?=
 =?us-ascii?Q?sSS133rCi+oC2ct0yDc96dJRIrwRNKftx7Qu1z+8Hs7Z57WlsgUTPMcztys1?=
 =?us-ascii?Q?Nl/doW0QkkTiTtmCYhoKe8W8IHQfjhdigkR3NgV2iBfJteuVzF8mz9dxXAJV?=
 =?us-ascii?Q?pB7q26Cdugi9MqoyIWGNmYl3VjHHVs9ASkON3lj9tzIwl2ju7GJz+17ZyvuG?=
 =?us-ascii?Q?NgAaU4rlg6tGtDAgiPMlLQjVRAfl5H+vX8X+Ois6HpKkwVbAi9buz/zIw2tx?=
 =?us-ascii?Q?JbqG2LikRMKtY6hcUBPW/wPg8o9cqn2Q/dcSu0996Bq1V/zAq9LLjnUACQMD?=
 =?us-ascii?Q?Nbd4t9Nd64t0lLOO3AOIgt+3zdg5k0oKUHZ5WglhqTBULhR+heLEI0IHRm3P?=
 =?us-ascii?Q?FWViYbB+S7AyfMXAoI9wQ7XOT7eJTGVJdFltK7GI0wKJCqLIogWhwy3i8hGQ?=
 =?us-ascii?Q?YggHgbshlDxdOz8Qx65K/+PqB2dPp1I2hUulkbFLkIaPSyQusplrUPRY+Cfa?=
 =?us-ascii?Q?LWRuBjltklGP7TyQ98QwKR3d4JcazU41yXD98RDYPSsqSjor0SfrX0NtIDw7?=
 =?us-ascii?Q?nnLjdXjfUbryUXIChY54zj9qy0RpFB+CObDP3gdmTpE7TIVAbPJQ85h/Ninq?=
 =?us-ascii?Q?+Q4Wi8ALgzkoIsShvV9DYYszp4XRS/LRoWqNjbptGwWFSkYMnYvraeedCOds?=
 =?us-ascii?Q?eBAuimX8znhZzpbkD6WnEPWc7Tpyn57xV1ZOkAfmFD/rDWVTt+/8BlKPkK0D?=
 =?us-ascii?Q?g8prgj/PYpzJvdvsD/lNphWEXEE6wWvdIN7vIVo98QQPCvhgzcEMJlHVSkQC?=
 =?us-ascii?Q?Hi5368M0LQSM7wdDYvR26wYeo42SG/3ipPt7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:14.7258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4813cc-87ea-4f40-6946-08dd92eb2e48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609

From: Alejandro Lucero <alucerop@amd.com>

Asking for available HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Make sfc cxl build dependent on CXL region.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 979f2801e2a8..e959d9b4f4ce 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS >= SFC
+	depends on CXL_REGION
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 53ff97ad07f5..5635672b3fc3 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct cxl_dpa_info sfc_dpa_info = {
 		.size = EFX_CTPIO_BUFFER_SIZE
 	};
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -84,6 +85,22 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		return PTR_ERR(cxl->cxlrd);
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		cxl_put_root_decoder(cxl->cxlrd);
+		return -ENOSPC;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -91,6 +108,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


