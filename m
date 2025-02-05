Return-Path: <netdev+bounces-163051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C538FA294BF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CAB3ACCDC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB61A83F9;
	Wed,  5 Feb 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IQ6jdPkn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2941953A9;
	Wed,  5 Feb 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768826; cv=fail; b=hz8KGnG95NAtryI/GGlxgab3hNopYl/9z2B4FA/5eGUHPWRb8Da8VAPlVKmqSE0cJbObPZoWKQXDaa5bc+H5iucMRjt9Ww5X2Pp6ck8EP7snYmNMk71g+Ps7DNQADQCAQ88eqjl57h9wZfsj2jWGjUqGH58i9QX886pqKIU58xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768826; c=relaxed/simple;
	bh=hwzaawTX1b2m+haIcFHlya9D+DKYszXktCBGH1VMBIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1XpHE0FQcF4s24PjgEzu421fujEi9DGL4jzKsQrTnool+TZzyGWF8KxGcG0CXJCKjLrdiF5ka1vT5siQJGXVXM3nhySp1MftqWn7uLBHaQmNA8HdQnUUSMJF+Ub5kwywx1avjRYqd96z4TH6fC7vvmSmT9uenAguRDPr53Pnkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IQ6jdPkn; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry6A6xps/BFBxpP2tQQxfXIvMCWy0w7FwWaj9w9HLEJI5w3a/Ng4tUpCuHYYdYP6OmTEvPynV6pSrAL0ur8Ag68820fLn5pmtuFgmMeUcBGpsBtrq3ssxmBiCt/TNs/oHSZLkt+1LEWXCdJVQcphRLpuTqOXhmmPJaWnYDGWshE3FkLXmFcLHWgXQEp9S8DhsO/lRKkdcr77kOTwltakp3pVS7OfojzabQ8Gu1J66HkU1RCYyTlGugImgOaSE2kTB/CSbeXWks3lxnABpbfpdKDtTZXmDmq06RFj9old8f2ESjlZkrxcw8zcGF1f17ZODBADMPJhUWXy15ylT+84AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rC1Q1EQ88YTUCp4MQNRhjFsX1dBZgFim0C25yDmJRw=;
 b=ZhPJwkHfOrw8fp/JhzYddQtdisuxhWVApgJ+Y4QqFHvIke8T3PTliZo9BbOHWWuOjK8o2SYmB6OmE7y7XTy9xzROcwvw7VWZpqsdCKs4K6p+InAod68GEesdiUnIWEfeqGBvupWwdakBQtIeLdXwkoTTNU9G6dh1og2iznal6Zgy1HhMrcxKLxzyC2PWwiLPnamppCU4zd8jkt9QyR+n2urjYDcSUgMZmAbTklCxUHaN9KTCUHHrJq3l73Y/1blzLWW9OxS0IgimX5kO1R5ziQaqRMQmYzutEZQ41jYRAp1/MhSpt7oZgXY4fcGHo9IdVQPUTTwDidSiyaUBY1SU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rC1Q1EQ88YTUCp4MQNRhjFsX1dBZgFim0C25yDmJRw=;
 b=IQ6jdPknlMhDGVroRZufdTcmwsTeLYGgChDodiEjPL3rQyyrrFjTwcSeHyTTvp9Rkycm+gbIomrAtR+ESnyqfRP2oVtdz1UUo0s1OJgfP3Cg7X2+1fp3Z+VLefidfGItloTFML0eq9FCXlreGT79zQWjAYCHspMHQ+wk/GZVraU=
Received: from SN7PR04CA0186.namprd04.prod.outlook.com (2603:10b6:806:126::11)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 15:20:20 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::16) by SN7PR04CA0186.outlook.office365.com
 (2603:10b6:806:126::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 15:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:19 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:18 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 15/26] sfc: obtain root decoder with enough HPA free space
Date: Wed, 5 Feb 2025 15:19:39 +0000
Message-ID: <20250205151950.25268-16-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ee7ed4-d71b-4d5c-e2e1-08dd45f89a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SciPL3K8CXvHGOFEjIQEkkV8w860U0UUKFnE9mjTA7a9/JdULNdlBIM667et?=
 =?us-ascii?Q?NovQD7FP8Rr8hkVr8pebIkqLnteq4C2944F/Hispxw+zv2HdKagpWacMg6Av?=
 =?us-ascii?Q?2bgROvfFDQNexQN893ypQwPuapWNxKcKkcs96iqEHPn0iAg8ENjwm8V9x3SX?=
 =?us-ascii?Q?i+Mbp3sU91ArS6RpLzXbh6NSyp4MkM0iVVqkWdvX3KZRw6DgyytasY6bZIAr?=
 =?us-ascii?Q?US/609YwE541YP/b2MqtCh8F6xQxwxDMDftyvfrwccZLoQzIIT+Lq22xwUwC?=
 =?us-ascii?Q?DD+ujB9l0j7PsTakZEKIMMdrINlg4mSELSKk4FenTEcOzCLGu7B5B26JKDqf?=
 =?us-ascii?Q?NUS3WIR+zPBA6+MjJT2Bs7MfmbcSD8/XzPVTmywuFm6nKLqKZE3Wi3w68JXD?=
 =?us-ascii?Q?tOp3DxXq9R9I/Mt5vyO/T1XwHYclUR1ioyayVl8YDH4aWVmhR68mAWz63ka+?=
 =?us-ascii?Q?/AA2c9A4z08kMcLQQr6QAyql1QPV3zsqLIb7iyGTLiM5PhiHibVt0qtFtLAb?=
 =?us-ascii?Q?V4oAaAapW6/PdKnpMmVHvs522TBDIK+0aO+sSbmthFpmpLSI3T1wNKPYo4d+?=
 =?us-ascii?Q?TGDkWlx8KHgx0gzbRRH5Ad3mflLIyBaY7SzD32RrMc8Y8TNgEzcmRKlmRrp5?=
 =?us-ascii?Q?UKqomDGsJs5t77DyMEwsfYpDb+p85gO8SReGvsEy2pYrZr7iSe+h5gTtsvUB?=
 =?us-ascii?Q?NMcrpZ/I5z2bbsNAeACj0KZ/KN4BFIaIRpsAZzXtGq1MiUViLYf+Wr6eXsU/?=
 =?us-ascii?Q?wnKqztkdfMDtOmKhqPYOCqEQpP67RAl6FJCCiMl8iQW5Oq505LNjLF2+xAea?=
 =?us-ascii?Q?cRoMbBc3D14J2TExLnpTwOLXOu4mPGmu8MOT2D86EinfdVsFgxv3zWS/sFY4?=
 =?us-ascii?Q?go37gC7I96LhhRUh2w5AJJy4bl0f1vKE6f92LSWpvWsNFjY0fCzpoqu5KeeL?=
 =?us-ascii?Q?QMf+yEynoy4mZeoMBnKDZZHPPSalhMWDS9ors5SDjMY9LBSdI/BV4UkkAINI?=
 =?us-ascii?Q?EaJtUdd66aRfJSF8+K9MOndj+FgBiGS1aDHopzB4dvi5So7T6u1KE1+qpYuE?=
 =?us-ascii?Q?RdyUo3RL7Yp5uJeBWA2xw9d3WaM6Lv0SCU6KbIgYVdjsh/TjvNFkDsuX/Yxe?=
 =?us-ascii?Q?MZOh6ilRVi5pMUPzSPYmKwfUu7x9Pg5UTmEsL8NgPnNwhj7UcaWFz4fRPolu?=
 =?us-ascii?Q?EcmW5G9ckzoQimdScpNdwBThipoHvPvSVaoxZvwneY/j9JGTdGFmVzHPLBPv?=
 =?us-ascii?Q?N9fbzEJPiE0uGaQp6YmJsF6vJ1dso1J3LXSj1z48N5BtYf4ZSRGb6JeCinyz?=
 =?us-ascii?Q?JPYsBoNnTBDb7nJN2JJoQPKf8b6bruf78q95jOR3rVYuNTfp+ZNlhQ+d90wl?=
 =?us-ascii?Q?DU79BPFdMAj8tW6DRaHfhMzNd9jrw+hymh1y4eHAeEBA/BHGv46fwcquV5xI?=
 =?us-ascii?Q?iGXwX3xaN0/T+V9zKctcl2nZj203wuUQceuLQ3esI9No01h0AW+lROzH2Yxj?=
 =?us-ascii?Q?3kL3Y27uIOkgx+A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:19.8829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ee7ed4-d71b-4d5c-e2e1-08dd45f89a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

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
 drivers/net/ethernet/sfc/efx_cxl.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 0ce4a9cd5590..f2bc7f5fbccf 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -69,6 +69,7 @@ config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
 	depends on CXL_BUS >= CXL_BUS
+	depends on CXL_REGION
 	default SFC
 
 source "drivers/net/ethernet/sfc/falcon/Kconfig"
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 774e1cb4b1cb..a9ff84143e5d 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -25,6 +25,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max_size;
 	struct mds_info sfc_mds_info;
 	struct efx_cxl *cxl;
 
@@ -102,6 +103,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_regs;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err_regs;
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		cxl_put_root_decoder(cxl->cxlrd);
+		goto err_regs;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -114,8 +133,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 		kfree(probe_data->cxl);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.17.1


