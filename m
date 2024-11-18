Return-Path: <netdev+bounces-145959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB189D15B3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D65B2A809
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A621C75FA;
	Mon, 18 Nov 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TBOcH4I3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6F1C68B2;
	Mon, 18 Nov 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948324; cv=fail; b=a6tt2SgoxdmEgUxc7AN9+TElGeomyafoc+9c7usWG0iZ++ewYvbR/5OO0PGQhup86aa6SSXYm5Y4Zy0dfcHuiAPAvmtV4Jj5aYD3mTzAkpgz6q2Nb3txkG3XQXxOkpTDT1Au/ZroL8nFg9QdCqD0IBWxoAQNJ6LxKsx38LO098o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948324; c=relaxed/simple;
	bh=6fS3IMzGQ65vbuOdU2xN8MSOoVUxo5huzSUg1BqkR4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tn5oB0/DZKROo+jvyYow/zvdKjdVnyEanHPLPrY55PwnJ2Vrc8+U3gEsbbr19h+/KLSq4Dfn3CZf6WqQ86GKs4FUtcVfgwZKK7OxTfY9mTLJnxPH3c/hDvXBcwCZq+9BDj/xkvfXKvhV3r+0C7AZ9CvrhO2YvodzhCqtdfu1f1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TBOcH4I3; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5FC/+/hgbm/s4e0vyqAtg++JGokxRV0VELl2BTX6sGHpwzNpsKhry8HyENI7ylwwACYyVGcemNHviv2WAImil7pnfF40w5NCwu+N8EBYOx9XFd0n5CREtQHEEqVw9PvtLvWGVjtpPnBTiCLVJKGGNUOBMcYLvaEjRQHuRmW1B7KDC3FavjcP7P/xxmqdCXl1DxLF1G2Rj/S7Ihn9Za9gIApcEiga0XuNpLz8LVy13MPForW1ncaO0AWxGezcwotAxhxY8LczRwPTBjCbMMn4QnrYwyuCDRbF4OMCCjRFZz2mRzQsZ2o+Nn6AH1VQ2L7AAw4Un4TwkEyPdsFBMKg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WubTte/ckcogiS9lKn4vEmspzisbu69tyjq8pCWp+s=;
 b=x//dTVD329qJ2HtiE+QqcgQCE+wCcr8HpuSyf4kpmM68LojEuIcDb8Q9q5D5a9OHGouRiOmdesFL2dFzv2Bhr1+vohF7sv4h6PAf2i8vrp0JvK+nhxJfJVsHcirdShsqFAzJ3Vd1S9jLjSQyHpwUDX0O/TVnrlsbKjY7sIvkPkUy2KJeFWgeVxSGwiNh3hINrfRvI+P7vjjjOuwko13NeHVn+3d00PlCv4Rw5gJ6cQ+si53cAQ8x6SgXFA2mJvDfJxENA8xAB5nhfhTls8JjL1k4tMiZLSqd/MWrFATz9ZI9xlVGPwGFvEJDXlsY37LExrArQqEk9hr6boS4EaQ8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WubTte/ckcogiS9lKn4vEmspzisbu69tyjq8pCWp+s=;
 b=TBOcH4I3QZZfqG/uN91NULYRM01g4bntwBO8z3pA5P/nzuiP6DumWLxeabhdp6Qn6kMd8NDdead3z8mlU1gH6xsQ88Kj31kUovcUp3o/1W7gzDBlLUHIFKrsYBfbggHnnFs7DZERgMisuVM5uNlGr3VuBwsiKa98d/9AQKYsOos=
Received: from BYAPR06CA0049.namprd06.prod.outlook.com (2603:10b6:a03:14b::26)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 16:45:20 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::af) by BYAPR06CA0049.outlook.office365.com
 (2603:10b6:a03:14b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:16 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:15 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 23/27] sfc: create cxl region
Date: Mon, 18 Nov 2024 16:44:30 +0000
Message-ID: <20241118164434.7551-24-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b95a20-fb83-4161-74ba-08dd07f06368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/qtAhx+77j5BV02cKpFviLH3GDdLHSGqjqYBrMLOTyj45hCeSNeTo/SvN2U?=
 =?us-ascii?Q?J7JHWx0rIgXJof5zID7hq3kFeQWqJ1vKc0n6Q8aK1upUvN9+ynlvS4tFGvrb?=
 =?us-ascii?Q?P9Tp5XfKYBzJbTJtRNwYe/qz9Lht66iPfrmAUmyR+QL6+ilozz5NJf04r180?=
 =?us-ascii?Q?HItGqjMaCAE43bS09rxXW/RqJYsr/vS4dJZc0VcTawOQT/qIF0AZl6s3iwq+?=
 =?us-ascii?Q?pqR2P51ryTL7LwCZGpWytoLlOYAmhLkG3LENlEBaiZI1KpuZ5mhsyXu146GS?=
 =?us-ascii?Q?wKLcQiLy5lE20Gshaw1izI9n9kVFHl3/kDxQIpXk4EWIio/y4TypdZPgy4Sd?=
 =?us-ascii?Q?gM+cMqpf20Y2H1/c9oKDNE/4ImM2oC42JRXWuVjo4KBx0z+X4NHjAHVHqQQy?=
 =?us-ascii?Q?MSsc3OgCsmzQ2Cq0FxpCUiyUYUAclIpk0vQHwbVPffipP6Oz4B1ug5aREYOA?=
 =?us-ascii?Q?myx6wCYYtzF98+lG2sHY1VzGhpOEqZbGqu+eXDUd5AcToECnQ5PCbhsUGlxw?=
 =?us-ascii?Q?2Y+VLQxgA1RP7lraJ5hz0NVo2V34MaJCUeXKuAbQUGhF6BbKUHM+e2UkNf8f?=
 =?us-ascii?Q?V78kgmlacbcGux/BMA5k4gp4C2xADVW+F/3Fne/Sg23rc/tXbGhxucG06RXY?=
 =?us-ascii?Q?zjjoX1I21HlwLsfk/3dWLM6fqdyI69lZ5h5NTIa2JPSIToYlMZtuCePY9Fd+?=
 =?us-ascii?Q?d6wrhYw/FLpm0wYIetXn7mv395tr14E0ydZMhFzfV0O3He3uaLmQCyc3sOhE?=
 =?us-ascii?Q?pCYwzRdCRL7SPfUKV0eLSB0DNeMEH5VnrIoDtaCbDxM4l/37J4y6Xg9U0lKr?=
 =?us-ascii?Q?2It/h6mIL6yqvu0ZbCNiVan2bf3s9tMz3e8RGQSM+dbeJi1+giWGEX07E5Y1?=
 =?us-ascii?Q?E0mDZPyET6YS2nN5cuvmwmeqL7v7gfoqO2fQntJfsJTW3VxJQuhnUpEP89wf?=
 =?us-ascii?Q?mtc/yoYtUBrfalrwXbDhMebET8bNEk47KPOWJJImGHPfcB6aFvSaQ42XN1rw?=
 =?us-ascii?Q?g/ny4n1n/dnRuf2EkEzGARefMg0Xj6MpudWZ0glkBv90Ne0jweHn2VzYtZ8W?=
 =?us-ascii?Q?zOiHiZgcw+2KoHfaGydzViK22ywwixAhbqckiZemqtLWVo7gsJqpE3E83ICM?=
 =?us-ascii?Q?5T6WTjMU1Xdx97bdM7dtECdeptLByYWPZBF9nUCLTaoU02QQnQDA7WmIJvxZ?=
 =?us-ascii?Q?YLfD3Z7OqKxbMe8MsfbW1gEBKCLuj0HPchy671L1N4Ab+R49YfHyTMZ7VAIH?=
 =?us-ascii?Q?Nw07xu9bac6/Zz/Z+E97eTHDEPW1FX7K6LJvUVHHWN4iCxjVitpmlF5NRyrr?=
 =?us-ascii?Q?+F1k/h6/LztF/ih3lc7bQYYrauIFtCFtxIPeNxcDi4X7lexLTxNENx93fkKp?=
 =?us-ascii?Q?BrWZj98EqJXx4fgNj9i1xugNWxOCOczvv4QyZgGBtuHNkO1XHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:19.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b95a20-fb83-4161-74ba-08dd07f06368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 85d9632f497a..f9f3af28690b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	if (!cxl->efx_region) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(cxl->cxled);
 err3:
 	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
@@ -145,6 +154,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
-- 
2.17.1


