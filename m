Return-Path: <netdev+bounces-182294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E4A886EF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B033B633E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC66275111;
	Mon, 14 Apr 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cXCW26DQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BF27466F;
	Mon, 14 Apr 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643651; cv=fail; b=a/DPvB59jdQ7hA0RbtuWwMjSSjoIj7K2wz9Md1yBHmNvVDI2ew4+sWcMt97fmdx0RMQLRIxZL81X1iTr5c9ZyKdh7jINEoVhMk5oXEtqRPM9Ke6KGPFdFdL2RISobQgaFhFpUAY7l7x9VXjI4zLZHt69OGD6xj5U+aCcEdz2GF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643651; c=relaxed/simple;
	bh=0RLeB8txp29ExDSUfJXVm1TrZtoZfGuiLII3YBybtsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzSkdAH8x4vePP5hb0lHvS3LzTAaUNY9sPPduye64CngkBXamLnnRvaTNH3zL9RTbv7O6wyaZ3JDFgMREKFHPX+N8BXfObMUE+8tZPKU4SA96FpI7mLv91QAhTdtOI/qT9gFTl7MbsIE6PirXOPd99vNhbXB0AfOrVlbl7iKn84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cXCW26DQ; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpEwB4CT8L3IiF5R9qMZ2INIZniKRjfSlJ2RyXqdkWK8813Q3rugMwABFayyFgr4rSyqj2YoJpIQuMVHbixRUJDx5uA4qqSe8GPLfMUOt/e7XYUi39AxFV7rc0c+oda6tnnyYnq/Gpkwt8VvqjH5nZhaiKsOhlE6uf86bopO3U4xHU0GqT1xqEIzWXbv2HKPF5mLD8hbd5GqWf2wgH/XjWgGZr+NIQBlELc+2DBLW5JV8c0lTK/bf+T/te+7I97LbD6/dXxU+z9JG6EfWM86sHsvE8EY87ueDkGnKjHmyMfDnM9FCgDNwYndbj17/BByfym/+dRKIfSIGVbTNZMDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxnVywWscdfKWL0sL9OUxCQAn128j9rorybp7Ui8PnI=;
 b=x5qe2offDDLjucbmXwtoak5EiLdkJCfySG6Wk/NAUZbCYj2zGPVXCXxM5FO6ICdp8WBCNdWyKyHMrsE+/SO1Q4Xz4/knsu7Hijc/ZViwVXfClUj/W1c5fnRvojGkVJU9H2N12Hnt9gYTwB/P3rBxjr1nO5obOOThtwXEoT7pyEUWA/oISsBTu1mE8Ih1oZ+y6QT9dndoq+ioo6swF/ibA9dw4XOs5DUChKpPIV+ec3vHnYwVeOGY4vjM/Gu/QX7ySI8dsPqttsdur892Zz46kMyfcgnqX6rwvo4m3NfntpED+bBJAODNGEq6AmMnf/SNBjScVFw0uEV1RsdcW5cOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxnVywWscdfKWL0sL9OUxCQAn128j9rorybp7Ui8PnI=;
 b=cXCW26DQKwdf3psMvGhqLCPFPjhqg66E1aKIfh7+s4ZcG/FNViVfd9bpOZXAwLHbP6iVF61LHEhldN11tNfnDqwF9CkAV3RmyMuF21/eyvjv0Ievdkfv+IHj3DoS4qh7JaXQaynZ7T9q8MbV1jaea4cGmdQTA8m9rtJHWC5Xszw=
Received: from BN9PR03CA0969.namprd03.prod.outlook.com (2603:10b6:408:109::14)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 15:14:05 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::88) by BN9PR03CA0969.outlook.office365.com
 (2603:10b6:408:109::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 15:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:04 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 12/22] sfc: obtain root decoder with enough HPA free space
Date: Mon, 14 Apr 2025 16:13:26 +0100
Message-ID: <20250414151336.3852990-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: e8705850-7154-4ce7-c557-08dd7b66fec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FmSqXBxNxnJ1j2I+bIWzVVX4cmtBzX25B8Mh7fdmJ88geSn3fNGU5/Yn5Ru1?=
 =?us-ascii?Q?wRgC7hcgzJ5MBRJkYMNNk/JJyKyuQl1ueoIT7p8OYOmtKX3YWfmNs6ytDjlF?=
 =?us-ascii?Q?Tk5r4UllMMMRcpVGNfPEqa3M3PULkMV6DY6Pst5gLRYWsh+twCb2CJK8HkRu?=
 =?us-ascii?Q?4kjN6AwQ+oDnziufljmc2gwcZVUpW9yXhRpeqKDwn0pf3Sh2WfPGMd6qrLIp?=
 =?us-ascii?Q?uGOZaNeXCw+5O1u/rIGXq48Bv31wdbTztNygaSDRZDhk/YcSmi0JviY/h0AZ?=
 =?us-ascii?Q?wYVPt4kNnU8oK8tBNtC9chQIZScDuKvZtR34P4g7Ni3suw4AW0794ev3sGbk?=
 =?us-ascii?Q?mrUBsB09qcSbP6jniZ9H1j3x/0ok2AtecjThsGss5reKNyf+zi9Err3cwhrI?=
 =?us-ascii?Q?e27X3wA76EBrNCrI5dISoSXHim5YfweS7c74XOXqHed2LD2yNDA3+hYjnuLm?=
 =?us-ascii?Q?/vvTrZprnuhWt13Ed78kfUNHIxXIWq02xm2csvdBy14GjeWfnVrK8dwGmteV?=
 =?us-ascii?Q?r/fE6yJcfgKr5PbFKBkRPhhzAKh8zHU5QiD0rhXEAb+qx1UHYb4QCCuCYCsj?=
 =?us-ascii?Q?3M/aRaBvgliE+o/8ZdqAzDkHP4qBSoypsA21cqc2/ucFuIPwoWYLBz6z1LmW?=
 =?us-ascii?Q?d3rP4iOOgW/0wjLiHPVrFVcn4decaniO2FvIldWzq/B7/Kcr8DijpXXRhyil?=
 =?us-ascii?Q?xsnPq+DOovKWSqtHfI8V/gW+xp1Vv7lX3LKlWzVXS36eId6rNTGUAmZ1auxK?=
 =?us-ascii?Q?LG2bbQplJ5KCJ1j+VEn/mHFzzCvuLSoQ8KtsCnHJz1RPi3/N9KWnqVDMEVVy?=
 =?us-ascii?Q?Aasow1PWlqM8W4FOo+yJqCGZdmwVb3ct8GcyE1zA+DERH8mh4OIT2AnbDunf?=
 =?us-ascii?Q?QMXAqeWHB5b3GEoKdYnZYSxLSo3PHWCOTgY7r1rrHjcNsZrOGeSz9b0e3xgS?=
 =?us-ascii?Q?JpVAcUkQY0bahCKU0Lx30ee3DuIvpzZ/4yGWy+GKVwTpCBQH2giLIscu0cSn?=
 =?us-ascii?Q?teWUwgw3IU6OaVgEYvXi11KWN5N3LAMxChTev/Wj6XnvKwBUiEUiiSqSwNFK?=
 =?us-ascii?Q?M7tLjDA6ie/lx8OEu/rqQqIgwLYjko2xodUg8dR8J+vc+Jp8m9pKIKPgT9/s?=
 =?us-ascii?Q?OmULCJta7LVDeD55OWb0HOGkNpDCXhnzFuS9Svz6zwSc6rfx6H9dRLQj7dKe?=
 =?us-ascii?Q?8DugI4tb20MRT3d+3GdPb4lGp5dBzq3zYlI2S3E7zs9mENM8qVS4XpJxKjjS?=
 =?us-ascii?Q?HD15JCuzdju2qmFp6pGYmIh/h6k9WQKJgtX2LOFqZhHKoxBOAdDGloXk0I6Z?=
 =?us-ascii?Q?+oUDXSBL2Xs6dE00Ew+FKZqAb7z6+bEGMlEunuqUxZlYP1zpBt3JeEbK8XdF?=
 =?us-ascii?Q?f70yJF9kECASJtuHT55UiEB3GFS50RIoaUPCLi1g3QdfbFGPkz8w0M01oyrm?=
 =?us-ascii?Q?LxRoRSUc2qobkQ+RHdkbmfuS5KY/AXPniLkswg+Tpla6aZRFqwL8WPxXgozu?=
 =?us-ascii?Q?5RFwY/+Pvn1zeqRfWa3zgLPfnnON8eV+vGlm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:04.7264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8705850-7154-4ce7-c557-08dd7b66fec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

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
index 82400dd7e678..7236d255e36e 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		.size = EFX_CTPIO_BUFFER_SIZE
 	};
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -86,6 +87,22 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
@@ -93,6 +110,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


