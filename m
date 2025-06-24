Return-Path: <netdev+bounces-200673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F079AE682E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BF83B1196
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297AE2D6626;
	Tue, 24 Jun 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cx1KuvDI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5C2D6612;
	Tue, 24 Jun 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774474; cv=fail; b=m1nCWpqF1p7nt1VMzKLvOPOeiI6ElYzTDlPk6tFovmFm3R7MRsGOu6SZCDjS0jdK6HaFOwc4KOv1PUnjJ/ATFoiIYwTzHGmayytUnm7UnIVA7yb+07cPxtT+cVwRTvPR6G4fSITjUP8IsXAWOBvBUVA/AT1jsSrN9iqwUob/KfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774474; c=relaxed/simple;
	bh=7JFhZwN5D0YUw1nZX+TVMmLoy/q1j14064DxJc4ePw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbnjMH6xAYZDh2FtwnYlghRoCIFeW+vLoWCHZcsLDdWT2mAuw1Tkk4cJ2U0SKHnREApMFdjF0BM0MTfZ8+Js6yfKjaLp1aEu7yRfLMScvcEiwQxA5UD7GH5jYQnz0zZql6UUKXmwg5BSnPjYrqcw7Xq3Kub2CteKhqcYPFt1n8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cx1KuvDI; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz9XCDW+nurojVYv70VadejqAZAtf7Th+1W8ZxCVGWIbBtWYnN25AGC/cMNFzx0H0yGZJ+6ivBO+s6a4FF1Bn0nFkKAlKZc58fsrdM6SLvip+h4Y3bXm7b8BDFzkqVzBOKJgC+lcE2OQlwRtwMmAiLlZoOXHzrO1nolXMSWZXAIUyyOyUC+83NsHpHMxqyPJ3bVRAbTWKmIWm/YKjL83D0Jaeg4eLuylNL8d23aPbuZR1oN6X84q3zYApWG/XIzLT9/dw/dZRBq0iohQC6muJjYtXRqjP6X8olIgjOKXg/dw63LHJPx5zFqKJ1oIvQmQcRbtIFN4SdGVchCM/3J6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/07oZDT3WmGQMX9lpnw5AqPo6ecCdGxo7CHOjHuxXA=;
 b=wOXVUPP1T0Kv8UBXwntfWzlt4jNOnN48U9dcToRxkYcKN2seqQW/oWr2qxh75Q59/+J/pRWqluU/Dzt6NRw4Oa2ypAzk+OwjN3ZPV8+WyBOIo/mAspfK0z+pYOeYg5IHPOJB3ESkmI7cMOGh9Dmt2QQaqvTyO4yyXh8ZsbqdrwX+cH48KVdUmwqnELpLfq8h58dhuq+5gtjjb3wrq/13rLkvjGL8KWEfofgxPAoqqt3r4CtC/jaTAyrwJlr2Si8ir0srYTBk/4gd3vn6Xmn3SoAYiRTDZ80IazZ/sDjAe0ye7o7Z1Lw9q9WM4Ea2YPJ7BP8NC7zns1XtsWJXnD6QmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/07oZDT3WmGQMX9lpnw5AqPo6ecCdGxo7CHOjHuxXA=;
 b=cx1KuvDIZrpv4/wfsVx8Tdev6/GHWB0ocloY2vMyYso/bvlH+P1pgYEH9EHqs4GAErbToDWZGd2eRoT+95TjeRtdLs7KJOgnEjBhkAbZ4KH//uesYUyGEgD3JO06eMVRHr2JDgo1X62Si37SnszQfK6CaPvGNx//64KnUSrONDg=
Received: from SN6PR05CA0029.namprd05.prod.outlook.com (2603:10b6:805:de::42)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 14:14:30 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::69) by SN6PR05CA0029.outlook.office365.com
 (2603:10b6:805:de::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:20 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:19 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 05/22] sfc: setup cxl component regs and set media ready
Date: Tue, 24 Jun 2025 15:13:38 +0100
Message-ID: <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 188f4c5c-a317-46f2-c276-08ddb3296fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hsBMLqDUI5cVqF4p/Z2TEm3sdtBfU6S7gfYs6XAjQa1KxeBVm9AYLNjnUzkO?=
 =?us-ascii?Q?kkc4NhV3R103/hNEnbz6B3MM6RbVJi5Rks5gRsWtOzGWFfu7pIKzFkWGv73+?=
 =?us-ascii?Q?YGqPE2IZLfLTIzurCGVuEIaCSF1mDSHsWvREw4yh+g8Z7AOJAmROIqHhY0qN?=
 =?us-ascii?Q?u5oxF9EUugVXkgUtunzg+HoTpXqEKe102B8fQlE5Yj48c13xLiUTyizuYcYo?=
 =?us-ascii?Q?vYFJX+LY4GChK/rpTER3XmeR1qii4Vafw00fFXx6YQHXFuq8YZTtyL3QM2jT?=
 =?us-ascii?Q?wTBOEK+MxfXT8yyNwLq6zogiaWSO9psE+leMC+E78cn7cBEbKKQzgCXn5++n?=
 =?us-ascii?Q?enOzTH7FpXWNkuluyGIBg1IEJO8N+dwOvD+d3yBPgNfY+VqyqsQ0Nht6Pbda?=
 =?us-ascii?Q?ck40E0k9eUJu5/cLjUwSNhGGRTSugOLU5ncsyqyqyIOuklvdlaqnu2uN38VQ?=
 =?us-ascii?Q?MGhA8o4QQhGRIwiFc5M0vrfj9N3gxujqA1ow2eRSvK27BkO6XB79bQzuG590?=
 =?us-ascii?Q?dS6qqxTPw7xlxbzh7cjQnc2c7kLf+Co9Hq5TCO67I09Xj+pTizItV+ZizQ0i?=
 =?us-ascii?Q?Z6qeFfXgSWO0s03i/5RkRwvHn+WYCVlu6+gNM/pisuhtWpDDnIIB0B7821tT?=
 =?us-ascii?Q?gXboWbZkJ95Qj5toQUDWyGT1dfzjToeseVCHzohqmbrIS8+ExXIcFtfcd5wx?=
 =?us-ascii?Q?Jo9FJPhZawdI2Co0M9W7VZP0cGQq6TfFMxX7BA4af8gilOUT/y1VgBLBVPtZ?=
 =?us-ascii?Q?aY/vmQXeM92dkgfXPevJwGHZOGvcJL2H0X9mjABPeBAsZo2PnAQQwT7u9kb3?=
 =?us-ascii?Q?YaXfl2tO1CiU+BSNYi/CD0jSRDoD9i3k2KVseP84/5slAqp85dhkItL4XqOc?=
 =?us-ascii?Q?euI/WTI6uD9yZFEWGBVOLYT6jlTcmigSGEHp9nfiEJJI0eZCJQFE/AUCYtP7?=
 =?us-ascii?Q?LguLnd9CssTjxvNdKBIdfBnIv+VmDJWODQ1WOGgQNE6MX7fa0X1UN6Ja/NxK?=
 =?us-ascii?Q?3X2lpnUQ+06HtsuBI+3TrT8D+ikIPaKc8vzc1Pvh7jozFzk74t2WTfsmFtpW?=
 =?us-ascii?Q?t7yBZDlmQFCqzV9tPfCCRiftbuQwSpyM1jDfPc+STI6Sz3b2TLw6Sq+NkkrN?=
 =?us-ascii?Q?9CcBSnnHmuP1tn+v85MZN8S8ivEPTpd0uI33bt3/R06YsNYd6JcqTC/ScwTO?=
 =?us-ascii?Q?vTQ2dkzt25lKhC21Rjnsh2Y1nzBOn6VvDU8m2d79SbepAmSkV3vFXIHD8dqb?=
 =?us-ascii?Q?gZ4GvT7r+p6EVtdyzen+kQvy6Us4ZiqzOX7yo8bnz0x5bPioyHLc2Eo9hMJQ?=
 =?us-ascii?Q?STBajHQ8NlxPfL6NP4OUM57uxxs4KCL60OiL3D0OCiBRPl8jhsCFj+9FgAM8?=
 =?us-ascii?Q?egAmFgm6BltQls3pRMltvDL2AB/DOS6FPPAeKplStaeIt9Nl5yPx64yCGJBu?=
 =?us-ascii?Q?8b0hzubz3jHJU8XJ7hrlGpv4wyDR5TOxCpd1Fr79kLQjcJpMtZvQk3TwO5dC?=
 =?us-ascii?Q?fvwcwc5/4N/VXRyykd7UNJJRxOUwBd/TVII8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:30.3858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188f4c5c-a317-46f2-c276-08ddb3296fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping regarding cxl component
regs and validate registers found are as expected.

Set media ready explicitly as there is no means for doing so without
a mailbox, and without the related cxl register, not mandatory for type2.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f1db7284dee8..ea02eb82b73c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -9,6 +9,7 @@
  * by the Free Software Foundation, incorporated herein by reference.
  */
 
+#include <cxl/cxl.h>
 #include <cxl/pci.h>
 #include <linux/pci.h>
 
@@ -23,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -43,6 +45,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxl->cxlds.reg_map);
+	if (rc) {
+		dev_warn(&pci_dev->dev, "No component registers (err=%d)\n", rc);
+		return rc;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		dev_err(&pci_dev->dev, "Expected HDM component register not found\n");
+		return -ENODEV;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
+		dev_err(&pci_dev->dev, "Expected RAS component register not found\n");
+		return -ENODEV;
+	}
+
+	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
+				    &cxl->cxlds.regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc) {
+		dev_err(&pci_dev->dev, "Failed to map RAS capability.\n");
+		return rc;
+	}
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


