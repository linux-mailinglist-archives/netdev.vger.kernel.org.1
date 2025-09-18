Return-Path: <netdev+bounces-224333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C703AB83BF2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894271C2201D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FE304994;
	Thu, 18 Sep 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tUsgQtDF"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD9302779;
	Thu, 18 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187117; cv=fail; b=rbxz3NgnuNJQCaOweRADlMrLzQd1fAkUPkzTVNOm2Q4QSiMJYO0bMQn/IdPn5dG8ovokwervOR/cPFthHuTc8rOmONbyORpCWZEk0ZH1SUfQYC7oSdp26xTHkXtGy/Y93U1epF5jvJQ5lRIlYxrbxsCVswkQKJX4kYeL4dQ2w3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187117; c=relaxed/simple;
	bh=3kAlfrrVm1Mhb3xhB4Z3oYlwO3Jmcm+NH7AdNDdpEvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9509u+sT5ThV97PIy2lz9ZvF99Pw+jSbm7AKzaFi+Vv3LFqZk2a5cKJI0pnS8Ms/ld5KQ8CAwpoSBY0q6PvW6fNi0Rk2dW441IPe0Z68EpMQbVjSEFi081Q+WN3NskbC/n2EjN913EWghfWrmS/EA8hTmBgqr2WGK1fm8ZYX/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tUsgQtDF; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJTCF+AuwQivjZHT2AKz05qaaihYOdqTUoMgB8DgB9Cf0nmJPgwBoFAMp+NCx97fWDZNR+hcO+PcK8n9ROIc0MGfCl64UONNQl1n+xynuKrWbr30jpCpsbur0UsytADr7Sjblh9w0B59vZFq1VCXe2PSAm5gKMSe/5TFH4zqHyu3b77jWBQtlTOzLbIZfmtTCiKEW0Rhad5DcsH+GlxMhk4/xQRTqHkRyBdm+TQD5SBZ47gFt8SYf9gS28iwjpzb6MYZHuplfhN/cIpabQsl/iwub153F5mXN3id7XEvEH8y79N99jYSf5kyS4CJZZhreHDKM6cFN6zwCeh4qu1fXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Iio0aUQ6pfhq1GS4J6kDAPQf8WZ4kIAJo0MDKkrCB4=;
 b=P+rNC0rCkvzGw2VKUdYiWzcOw1pY38Ewwpq77iuSQRIuS+FELdhitHrZ/0kaBuLUzZ5/iMvTbShF8eWr2iuyoG5Dw5hU7PJuZ1qj5wIt6cMmazPDnlvigt0xHjo/s/VErRKHh4KTKyFexYMPdy+UwEwiuc+MFu5DuESl8Xq5IbgfXCQ2KN0FTGBP8yHGcW+m0AmPY9eHfCm5LoHZuVlhcAM+DO+xjGw/DmF9q6EJ12Fhg19gTVnI6QkQltDoiq4cTnP/H4PTn6UJB3raLQrfGfIxjzLX9romBDbbEZYnPGpCRfO6gPod/l8RYlmFYHMe8g9usKqLC05sc+X3ssNc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Iio0aUQ6pfhq1GS4J6kDAPQf8WZ4kIAJo0MDKkrCB4=;
 b=tUsgQtDF/NUFbyq0+NivUnSec4J+rCIGJpbyOpXYlerTtOijayMDSVeDjJjjMky0bqjr+8XX4zWLFLKkPxVgfR+gyCg+jt4v6m3wWSgAzSDe3XDVUDUXW6TE63tnuqZPcnlF0ALod3K8d9wSPDuoFEvZG17gjbXRRUK7cnuZxOU=
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 09:18:31 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5f) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 09:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:21 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:20 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v18 13/20] cxl: Make region type based on endpoint type
Date: Thu, 18 Sep 2025 10:17:39 +0100
Message-ID: <20250918091746.2034285-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5613ebd4-26ee-47d8-a99f-08ddf69455ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fEDcYO2goz7txlpkwImSRYc7Ce32tQr+a+CgNbevyP5puk3iR0joJb7XOvjQ?=
 =?us-ascii?Q?LzIRPTIRTuxf3BWzxufv07Rdr8fUCFslSAXGLpUnDjUB/WMKDEepQrixrsku?=
 =?us-ascii?Q?6c9f/nqGWOmmHf391N+psu+rVeOz6b90A2JVAf1Bn44UxiN6+euXEbUCJFgK?=
 =?us-ascii?Q?+xMfuPqkKhN15KkqSPe/ieXZadafMOBARoO++yHYlbguAliivNCg6XjvVcgi?=
 =?us-ascii?Q?C0N9g1CYQKt2nlMZhR/R0EL+QqA5zwcXTFxk2apzNFvwN//TmKZB4Wb1/jGO?=
 =?us-ascii?Q?dGiZslNz14AlSNZ65F5MaY1MIGBFCFVW3Q5TzjQ4SehxOTCtszjD1siYuJBj?=
 =?us-ascii?Q?w17faw2e711mcHRYD17RoYKiBw+FXROVgK5wKOy7e8AFJJp2ok+qHqus8Z//?=
 =?us-ascii?Q?xLZuWm57jiHD6UoOjK8JGV5gKXLObJVBWy9lVyc9/ERTf3wMFxzVGVF366CS?=
 =?us-ascii?Q?zRdUPMRaIHQNCmk1nqF6zGIFi/2KCwR7ldcc74dF4rRFgfo3FsWerUUIGArn?=
 =?us-ascii?Q?OnhG90fugLZe10q6w70fGBZQ1wKwZUSdHLMO6MnHCH7R2rQfYwn+4DVZgtw4?=
 =?us-ascii?Q?Lc+7luAwae8IoSO/kdwTRhWAscaK46Ksx8d1xxwc77P+P5x3ul8L3HvVw+s4?=
 =?us-ascii?Q?xEmqmYaC8uoTfyFmvFRJrTPw7F7CVJnLNo2BzY26RuKGfg1+WUpOYqmyU1gg?=
 =?us-ascii?Q?fS0GA2YeVKW6uQcwt6SZofbBubW0OHBC1OUZ7uLBKfq8pNdUNl3vT+nBiZTS?=
 =?us-ascii?Q?Nv9I3RknGPpfNPpUUDxWbQzFIcTKTQwFYakvq8d8UCYnfxuxHVBICVHxjqgw?=
 =?us-ascii?Q?sUDP4U0hpJ0LAr8UIDlQ0sR6mU2iWTFLkEoCi9h0o+/egSV8P39pM1V0hula?=
 =?us-ascii?Q?8dU10aLQfRMNah7/tzrgnvuiUXj/HZpuVeLsx5KowHhCPpQWlEMzCrdTxQMC?=
 =?us-ascii?Q?m5XRQReMBZ3ZwGSWpKwshTNoPNXQcfDbNNDq5TsPV6hi+VrgGIM2JEJZa6x0?=
 =?us-ascii?Q?LW3O9VBjfvp7cb7aUHt69jBLlrEMigkuKcveR3yfeWuhhyc8lP2g+8ZQE+8y?=
 =?us-ascii?Q?uSo9dgkfMc3aWxsUeKDSgo7vHkMoUYmd7TkuDRzpmlaQV/+eewqrlypHfpmd?=
 =?us-ascii?Q?XJJiTKSqNVcwcmUrDDNil866wPCqXcp1AHcnyb3La1ZZNgwQZfOD0YMefJBF?=
 =?us-ascii?Q?+KLRkQZoOZcuChxbxotcCVy4Mp6sz3ei84lsCNa32T0hkYccEl8yedZ3USHM?=
 =?us-ascii?Q?2x9sSF2g3t23B2IxB1FmP5mT37grNy2h2Rs3zXqbbUxUZ/C9BsP2WEP2iMDT?=
 =?us-ascii?Q?bAP0WwmL/+TQ7N3FEdtpxTdgXFrIzvuxqfW7PS3GuMeterzBzb8poYxIrJI9?=
 =?us-ascii?Q?GSJLK8ciJ6cursV6G2M9fRAO7zKSpsGhREs7Z627+4h36a5DVZnZdVMwRqDw?=
 =?us-ascii?Q?EUdB6ywRCmRtVEU0Bhg1cQkj93DFSGh//7pkCmKjEOlB6Iy8P0DvcCYQ+BHa?=
 =?us-ascii?Q?HgSQ9yYkCJCoTX+xunayLWDJIK8aVwWVnhR/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:30.8769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5613ebd4-26ee-47d8-a99f-08ddf69455ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 78f13873397a..3c65ffd17a98 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2753,7 +2753,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2775,7 +2776,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2789,7 +2790,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3581,7 +3582,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


