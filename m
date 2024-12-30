Return-Path: <netdev+bounces-154585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5D79FEB22
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E573A1FC6
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2441B0404;
	Mon, 30 Dec 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TsmjhOCW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DD19DF60;
	Mon, 30 Dec 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595127; cv=fail; b=Wl4ETfHZsyPc0vefTuVMyUROKAO9UG49EoumcAb3hOnogS6CghWWIpFOOCRvnyD4uAv5n8pO7QcSVCYXMydtwqh/Pi3uTB7V9RrHWjZJN1WodIn3BlraNMkTuW92oxZxcJIZLz0/mEKR9yF1BykCEW3LO6D06zkonWZUAmPZKXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595127; c=relaxed/simple;
	bh=wC2O9Byvty8wfI849ALQCKhSjhyOARKWQnehC3HHniI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmCruhE5XQdERasuIjBsAjTz7kiT64iSbJPGi4kBT9Fg1izscqMgJAWz1UB5S34Ubj/a9afJTG0BInnf5hFGHMq7LNPxr4SqEIqMo8k2oxaCNDo0g7mqlaO2bYbj2ygW77P7LPeuF1HQCmID4BmAhG8hs3KBrwOaQkZ26XHgRSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TsmjhOCW; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CodsF9iwp5MV/LpFYy/FkHqvXp5cZMii8218mrCrf8nhi3irM+o2YorNg26z7gnwq3PGNdp30WOtUjIRHreJrD8c91nPbkjIwEjl2h1ElppOAwRw+pCGtGQ/3Nd66/3uW4K+aR+hec8Tw6nNV4MpeAEaHPgvSLMvu4ivtC4XW5ZsGYGktWFCC5NOoR0Z+an7VOsagXMynEA6wmGSZQf7vbKZmK0pZ5OiOyn5EndNOp1TY3NHlGjmTA4dp9lz/wRzALvGnvDFjfgBME8J11CwUaGgqbawvqMGMV/xm5XlnqlzLI5qZMDsr9CAb4q1PhJzjFfOt/uOX1tGghuBWnRRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meCgjTIY1MrtGIYb+uHheideyjCvJs38+77dZl4hxJ0=;
 b=Ftrc5KJxg+liY+QVqzWTmTy0esmb7wZi/pqLaMsdcz4Gf2ZPX+Mk+wRR5C/+0HMDNBdLK+wSY4Hyl07OmOpbq+zeT9FjaXRml/vpz/6hrT9zj2FsuO6b0F92WOBuJmsADk5C+5CfzOxldqxYXkb5rVbyh/tCe4STTlIjm3twVV2o2Odf3zK5rklpcqSZBpBrNbbWq0PXSWslQEuRxXfZH3SM5EES0dsU9RO4btcRk0b6lTp9cYviIY5Q5ElBiJS2ThQ02XJ+Q3NZB2rhN5a55UW/ZGlEarebczqgo+DYqMgyxBBVTjZLgnZgWWtJ00Qrh5Cw//0LZwSH1TXOvxnV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meCgjTIY1MrtGIYb+uHheideyjCvJs38+77dZl4hxJ0=;
 b=TsmjhOCWcMJCsQM/MYU0b/ndymL7ns3BS+RmVH/PHCqXV3yKMCnOz/iWsCFuGW8Ce9nrtaHRtWcHes+7tECgw2iqPei/L12+EakRwY9XKXycyyQsEe0gyvkSEJLp7EyPj1Yxq1zEox+uWWPFefNkRhpAALu2KR156nh1SP563/s=
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 21:45:18 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::ab) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.17 via Frontend Transport; Mon,
 30 Dec 2024 21:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:16 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:15 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 16/27] sfc: obtain root decoder with enough HPA free space
Date: Mon, 30 Dec 2024 21:44:34 +0000
Message-ID: <20241230214445.27602-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 5834ee6f-3093-4c9d-5448-08dd291b4067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSGQbMlxrempYH38kIEvVTky9gCii0sZfstt86NNGWFU0J6i5aH4dhlfuab6?=
 =?us-ascii?Q?AZuUgDIOdkFF/sFScvTUUoH0b+7NUSVGoLZmEPa8qg/OSChruiNRsFYtkJ1T?=
 =?us-ascii?Q?2UZHIAYs1YlDOPJj0PeBX6gVDJ4IkFxeqEGTGg0pYSQFqArmkd59QG4aFLGj?=
 =?us-ascii?Q?XWA5rK+lpVZ/BbzflKYKUh5e/Qnwr42/EzLadE2QI3cQQvVTo2pEkcPVQzx/?=
 =?us-ascii?Q?jsNa0VGoySkPB8TL7g28s65GKRlYCE2XKd4m0eKATEiqzfjh9epbeRcyZnCn?=
 =?us-ascii?Q?xa2b/oJwrHMIgFZ+0MC/SCeoGcrJy09uiJBzrqJAZPWrirwt0PW3RjwvbqA9?=
 =?us-ascii?Q?HeCeL1sTT/qJQXvcKWlUXt7PBPr+mP3K1NITqGmOGUnEkpH+JzIqBpL5GhAW?=
 =?us-ascii?Q?5YoQRfkhdcazNMhXcmq/3q3A/vFl0BE0C1uz3K9gLAlmrZHEfKqga1tnHGHM?=
 =?us-ascii?Q?kbPeMv1vx4NcnVeVcHNIVB2geX5T5DoGmi3tC9Sr+NMo/nWZ9NmQ4szX8H+x?=
 =?us-ascii?Q?fb9jnAxzpYnpbRKtzLJHOatPUYe3HofcbIOZhExboh2oQJeanfQyOwhRIrGt?=
 =?us-ascii?Q?bApkJHGaqUGuWppRkWHeXtHsS1uuI8Hts4B1/Vk4vhq5tUYBdSZ0j1F1b5fk?=
 =?us-ascii?Q?++6KTB5oLKeVM3Y8VnmqUOJtxvH6VJu2EYpvx1W5cpM8MYEuANMZgjJCWw9P?=
 =?us-ascii?Q?O297uekMzlrNKRYQQXd6ukXTSTonVBC9J6z78GmDTLlyQjEGDJSQ9EO8rO66?=
 =?us-ascii?Q?UcHxSBuDirQnmDCXr4SCJFmS8p2XK3OlDwUTeIuu0xeYkxwmz4gZTw5+w7U1?=
 =?us-ascii?Q?LT38CnkdFXlrIiER/TdSvrvqOAe0TcJ1F5CGmCPz6eHcWl+gLFJ2Gi7DlKru?=
 =?us-ascii?Q?X2NBVw5BVKgIDPAYgnITWFbDlz1KfYXDAcLrVxACM73aAVYu5ms8chzVO0r3?=
 =?us-ascii?Q?xmLYHrPCMfCt3yLILiszmuwJofs/3PZWUndHP0KAZz6AkNjSBxhEMbu77CJZ?=
 =?us-ascii?Q?z47gBoMXdyRh71pYhkuhkV4YiTksvgeUq1RQX9BtOFGKL9fVdI1s1k/y53k4?=
 =?us-ascii?Q?JdwiO9XXWa+x3sv85E22LaEJlUuBm60fwZrGH3huv8LUvM5nedxG5Ake/ZSc?=
 =?us-ascii?Q?3SIcURbPSuEs/kuPGLmmWlUbO1LoQeMRNVJ++4Wq0OH+aOtRUDD1FqYNzg90?=
 =?us-ascii?Q?4sK9fl5w1D2mdxgYWTbF9dqHyQRk01txHkUMc5pqG9jv/d9oSeSsawLjjJ9B?=
 =?us-ascii?Q?QNftRCMqo5ajC+AkmkmphzMCTDTGHYJe78qhMk/gu/3dxATUUtmMzezVNfbJ?=
 =?us-ascii?Q?KLmV0+X+s9WGPP7DGI8QLZpAKVF8EiTKFhx9H7b4+DQ9TMkZCqo1d3EdaANy?=
 =?us-ascii?Q?1MrVFZpXdSQlzINNc1G6hcQNhy6wz4Jb4b55n3holQvFNUwtFo9gcwRQL4On?=
 =?us-ascii?Q?bTJVofgsK9gogu0SVvUoz6WVp4K/UbcsGhgEIb5d+o614h3znXxoe+g3rOvV?=
 =?us-ascii?Q?EL1TCGclmQ2/8Yw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:17.6441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5834ee6f-3093-4c9d-5448-08dd291b4067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

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
 drivers/net/ethernet/sfc/Kconfig   |  2 +-
 drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index a8bc777baa95..36a7c4bec5a7 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -67,7 +67,7 @@ config SFC_MCDI_LOGGING
 	  a sysfs file 'mcdi_logging' under the PCI device.
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
-	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
+	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m) && CXL_REGION
 	default y
 	help
 	  This enables CXL support by the driver relying on kernel support
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f4bf137fd878..9413552d559d 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -24,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	struct resource res;
 	u16 dvsec;
@@ -103,6 +104,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_memdev;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err_memdev;
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		goto err_memdev;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


