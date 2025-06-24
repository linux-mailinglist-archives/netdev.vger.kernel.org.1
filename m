Return-Path: <netdev+bounces-200679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC1AE6844
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1553AB0F6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F38B2D9EEF;
	Tue, 24 Jun 2025 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k3jCF3pL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8A2D2391;
	Tue, 24 Jun 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774488; cv=fail; b=o1K4wtPksASMtBr9C1P0fjPkrcfJ6xnK1NKgxKtFnyG+opF2IJe0XdX3VTyQmevPXFVU74YeW3fQHwSXLGOO1lir8xCMhxeAfD2bPbKyV+gymLwKSpOo1MGHTmV8ulVR7eum+11InIVXfAQBCKgeJkPeuSeaBBIhq2+BTHUaaNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774488; c=relaxed/simple;
	bh=fNaSwHO11YICl8EZdU4Xs/rb+E0j3ALmvtmSjNIUXqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbg8FH77SVRBXL6YR2TsfyIoDLwHq5KYdseBwi2A7P8/M9ghbbgc7yhFdHb7VswyGqZlxt1tH/Hu6YZJZgbg9rkBn3JZBnCX8Xo8Gm/YdjHwXW7AthX2C4OIJpyZZ7XpUihiX2RqiMpk6NcFfJUAV7Qh3kn933vppb4rEE/893Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k3jCF3pL; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l16oavC52CjByTBVVURecbAA3Nook9g9rbRFC7elx7m0CXicekY0ZMZGRmvCp1MziNsK8tWXxdPPDp+WyK2s4ow2qjGwJYvRUBz8LGnqkPTQ4n3oB9JOnmgvmI5QnHIOmj5vv6TReD/MgGUTQlHFU7gEW5p75YbeGUPoRDHh52Hf0LMTVWip73/XKJHVsOj/nMAM8cAZkxBjOypne94PZUD4lG/8pj48yl0aZpw7Qhh7cDWG9zb81kiEPHy7m+Cr3guvPnyJL+MWf1mbn+3hf2/V8E4WcOdbd3W24ceo5RnCpfYfljiCgpE8+fQQukB0vbaizLW9Ts8wtlFgn1NbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+WAvmner7vtjoqroxJcWbVWmhkM5Yx8kuQlBnqb+Ks=;
 b=dMEKEPKQpnNLanEEoV2SlRAEyFJIqTaYeWUzmijLsi5QkQYHPMjMlFufwnJBHyAMZVYQRuxaO47Xndm3NyebxR75ZRtXzq6S99ijQrlJg5mKbYchJZWvAu++uvCuSSx8ZRONpSdSRBiKnFKPwIgVvMY0pLOcPS2guFq/2Bdm1O8Jw4qdp3pr+cpxRbDxTXLXlEIRq6J6f2aWIWBQYV1KJkXm549wrKRXJ+3FGWFUAmMMX7Q0rPYgrKDVqz7QuWA3Ox7xU4WNe3cd2+03dt3xq2Q1Usg2oDB2QokhSeMhHBRhmOjEESe3lnTUl866+PitQfskZRKdmZQe+9uphfD28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+WAvmner7vtjoqroxJcWbVWmhkM5Yx8kuQlBnqb+Ks=;
 b=k3jCF3pLDUA57NdQNTlS7Z/dLebbNQpKBFJkLGSd8sc3c9nfaMOb4aDcaPv6Gek4aM4210eEQSn7k1NqqanTKmt/4p8UjMQP5T5AQ0hvaayeRC17IANemdS8luBY5kgaLoC9pUSobbXmvn6dTkNFpPCkVmYMWEhjpV7SxnoIjdM=
Received: from SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::9)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:14:41 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::10) by SA1P222CA0161.outlook.office365.com
 (2603:10b6:806:3c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:34 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:33 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 14/22] sfc: get endpoint decoder
Date: Tue, 24 Jun 2025 15:13:47 +0100
Message-ID: <20250624141355.269056-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: e8588c44-9166-4c4e-b985-08ddb3297633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L6aY1+4Tpl5OEFLzrd+I6pM2nbIkDK1blHOimHaSkmChSvfrCEcKosGXDGuD?=
 =?us-ascii?Q?ITO1R81mZF2xOtenGYlo0mqzMEUqgenCDFt/+sQMChYoUQnUL4joBv1LVue6?=
 =?us-ascii?Q?aC3pvQ4zv3UyPB/T+OXtlF0QP8PzCzY6BSF5s/ssmWjTC7tvTPFb5Pnh/Tvq?=
 =?us-ascii?Q?pgzpZrIfFYDfyd3/VOG07kNSdsii0MFVRGGx9Z/LeFt/xz43eY+PYVX6kWg5?=
 =?us-ascii?Q?wFMeE3seMjN1bszm0IY8eC3zl1spzExI1VPb3Z/gdnopD5vmK6ZmKB4J4zvl?=
 =?us-ascii?Q?9kBYzpCq5vG93MH06kOSEXBGLiJ+GRTK9sVO/peTY8rRsUeSBh2eTOslxuv7?=
 =?us-ascii?Q?JgKbb6Opgsb5kziQldPMcZGcNk1RUvK4fAqpyTBTlvunKFfpMskYGa/7RS7Q?=
 =?us-ascii?Q?8TeQNOzAuQqnVApKo7EjgBpCCVi6L99PXfO3c/MVGkmRyU6k3guTOmQm5A1a?=
 =?us-ascii?Q?qOo2n0AIEm+yd6fPnmUXlGy5r3tiiAQOEflgLQzjzMXiIxSppxq6DatH+XCA?=
 =?us-ascii?Q?c7xFYvZTFlYu2HrNG1W1Pza0IenGJ41KmVB6wL1S3oPLn8wqAP+IVw45Gsn7?=
 =?us-ascii?Q?+BAwlGeq1cwirtnfY2W0w5q9CucVQXOCnwsAhA0zoE9rVAb5lcVgGjWtAU6I?=
 =?us-ascii?Q?xMlKSJeTTVkwBLp/J6+awJRWAM77A3dn9iL3L+Sbpr0y2EpRw7BJzjuYx2CM?=
 =?us-ascii?Q?ck5lp8F8zHRSLuHuYkyhc3twyKJqgs8J1cbJg1qfdiQYQpx7f+pJeL4JP/A1?=
 =?us-ascii?Q?CPvGxEp7ZGqRtF7xdiclY8xG1kivZkbjnCthc3uztcZk7WISXitJeI4xf6RP?=
 =?us-ascii?Q?+mNmd/YvZmUJr/iZRvy7rJX+b9CHWOH7SyHnKgcaJqE6p4JytcJ+rlu1GVVL?=
 =?us-ascii?Q?vLgHsC0MBElqoOLw5CCtSxCAVyP7Wx/r8C+VnJ3XL654+sUXd8nEpGZJXBP9?=
 =?us-ascii?Q?ga9wb6MLZVWh4h35cVCXpO5C4HOrSE6rUDzCsQP+A4jHy6iej5RLdtOuL1TC?=
 =?us-ascii?Q?S+8HX68yVkmAG5gfP3KcphGCrm74M9UFm/aN9ETQpgUcC/WY4u2Ix9Q80R+f?=
 =?us-ascii?Q?QpGcOYVL33JULkn7Il5ZQxlZJcB+8s/Qq/7r3mLtmLKdAmX886BaXdHog4Rs?=
 =?us-ascii?Q?qXXtKn+GT9JePQAoE3jML0sW7oDWCVSzLXtize5FxmMx3mxW+y2P4YkaZC/L?=
 =?us-ascii?Q?w97VSptty3O14vA1I880C76RYuZei6Lgb+Wu+Wp1AiU3TeD0TLscBBoxLrLZ?=
 =?us-ascii?Q?mTbMUIpMcxebTBwSYc+J+nycTW5Cx59D3000xkM6eXQasfRib6IFk6EWoive?=
 =?us-ascii?Q?5Skex+xHW67VSHSHsylJYPHDM7hQx2y/N7awlQXJQnU9ewwJ3y+3Hyam6c3l?=
 =?us-ascii?Q?YgwaSjyZI+/ObJ8AYR6a4LyAXzRmcHFD0UkYeJJr5zi8iNHeeg10Fc5rLYHG?=
 =?us-ascii?Q?6t4rnTs+DTvttyB6VH9RxOWtep32Bsl+lerEUTk4K1RWfX7B9ipWxWM5+beV?=
 =?us-ascii?Q?5Wkn4CSYt6C8nQ2EC4GSUsWU7UXSjxvB9Gex?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:41.3941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8588c44-9166-4c4e-b985-08ddb3297633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index c0adfd99cc78..ffbf0e706330 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto put_root_decoder;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto put_root_decoder;
+	}
+
 	probe_data->cxl = cxl;
 
 	goto endpoint_release;
@@ -121,8 +129,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


