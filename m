Return-Path: <netdev+bounces-145949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F79D159D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC52811A3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAA1C2DA1;
	Mon, 18 Nov 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TSMk1+hU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7F1C2339;
	Mon, 18 Nov 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948312; cv=fail; b=ZSWQoQ5cdLMR6i6IrTGIy557YYvIJvzgsH6rXn+QC39nTFUzUkeFwPMVIlYCfeBfa9tKCCP1BlAML6IWsGa6NwJWJxJa4gdOMiVZZjYb1X61G0ht9xdzUG7x+5z8DGzMN6IFM0419rFv2lwQ3OyVCy5stpZSk9R7bCT7DbKe+zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948312; c=relaxed/simple;
	bh=RhVBs1yZ7D7RiIS2VzNZeuMsAV5ATjWxwR1UVwwUNmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcthCJUGz3Ehzu0YmlmCDw/cXRsOYwxAIHUqAcVGIZ685R2/PRpFKEFveQb3bC8PcflrfL4IKhJhKVmEJIbeK32VgwTunxI4KbqZIkF9U4tWeXzlbz5p8Ujk47WgGHDbHiebfGnSaM5bl0pNh0k1+Lyw6a9USUuFotDYpYFOSVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TSMk1+hU; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H33nJ12KV/j2cmWLJJ7XAl4ifg8GBo+Tu1ggWZWxQMmCW18L5dW/VBUpd2GCrlKWBj+6lHY2TpKSJSXicmVB3+muSypiOOTKSZR9vtqhRvDHCrMh8/yLMrU/E5PC5iojVwrGUkjN5KjbvGpXE0EVnKgDm9/PLLBeJDj2jpL1WUaAH/zMAMW3Hlm3i1UhHd8L6rdOvp+ZFXRzj3vEKhGEP+1vcqAPa9TUltB6grxP9R47c7CMmkQ4+TCVN0tlalgUVz1GAf9lfZvezx8f7JlxO5HtX8LGpI2foWF7Cg3ysGa9UIiV5slrpeoeGITHhBsF3sDh2iUjMFlsPqoFQ82Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jQDa4IFIQF+SzqQDWj4M8+JmNr96yvjH5t5terPZt8=;
 b=ylAdnV+G7/+/Dr5yg6LvjoDfLcvoWqgZ9vqQJ+fccj7gOz42wlcXFmf5FP6KdtFnoBeY2m+g52xg1g9fWFWEfutiGUYVRLtMLvmKIvMIxdOxVKOeJZQRx/gRhz0AYEsYdyiey2gE8znmIfSKGvDfst1TQZPVJcKGaLbRoCEu7pgJvUuLyH3uR1Z7FSoCwR0lS4+Tq3MsRHbCyjz321m3Q9XCpn6ShPTrREb3bV59ZzDUZBq0nmJVKCSUim9Q4E4ZI0dsbyrbKzzmNlqfQ14D7yCPWi1zEKguM0Ptuh3YBrjGgDbkALKPojJDy8nKYljQMQjnmicxVuv60VOOkerqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jQDa4IFIQF+SzqQDWj4M8+JmNr96yvjH5t5terPZt8=;
 b=TSMk1+hUs0HFRq1OlozTqaC1wJN8uhIy+dR4FIrje0zkvpG2uf/NLJiIVxVgfiHFWyl4LhxS4Hqn3CN3p98Z19a5zgKxPH+a+QVmwllxq1ojebRiWFAW3rpUXofQATBoeQZ+unUObUiujMUeX+Dly195KNlC4e57ZVS1bKrD73c=
Received: from BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::27)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 16:45:04 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::ee) by BN9P220CA0022.outlook.office365.com
 (2603:10b6:408:13e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:59 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:58 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 11/27] cxl: add function for setting media ready by a driver
Date: Mon, 18 Nov 2024 16:44:18 +0000
Message-ID: <20241118164434.7551-12-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6594eb-c17b-45d4-d45c-08dd07f059fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pEwkPGZmteOZFblwFrkbhHw694KIqt7LAsA4hcwkvhTbSC/FhLV2JXjyb8Uw?=
 =?us-ascii?Q?a0jEm/ZQuvF4zWM5q/YK5Ic48S+CjHxRZlbSyUb/i/4FTSyIc9DLm695L86b?=
 =?us-ascii?Q?JqjFzSL4RCWaC0Gdk2mqTUC2vhugIRrMxOEYHsY/9mDMXEuWTijLBfud7DjO?=
 =?us-ascii?Q?ptayWcwBhQjKIjWvPuC/GEh1clOjqx808JdrJ2dCplShElznwN7YQcQNvb50?=
 =?us-ascii?Q?MHClzcmBjR9cKiQZiIsoMN+Ta737Cup/gRjKPrSwB9F6Sc/saFEudkBOm5hd?=
 =?us-ascii?Q?LN78VUq7DJVU7hlyouWWfraCTmhnWilA8F9r63uvdC6/yq5/P6ibZumcV4pZ?=
 =?us-ascii?Q?iHtNSgZMlAmxNhvEHnbu0/QDB6Y9PqoMaIV7h5EWS9ggGx1WXd11FGGfjJ6r?=
 =?us-ascii?Q?0PITwIjgyg+0c6ijkr3jPOsvaxqbLERc+E62NZb5nueW8viXI2XzlsWLtlUn?=
 =?us-ascii?Q?tCoxQXTBc4iVxWrNpWr97xCNpCm+3y9yt44lH6MNa/FunbZsk5db/H82sNoL?=
 =?us-ascii?Q?JETRGJQjARUQ51WFPUmB1cklS01jD25YeAT/X8xP+0f9S+r3DoWe2bDIN7jv?=
 =?us-ascii?Q?droz9cw7laMuZWMvWEq3oDC97r8A4pRgCgPZOC4kDQlztRozLVVhhmRHDxcA?=
 =?us-ascii?Q?e9vxFZ6BsQ+3rJq8wbM+/HMapzfDX2b+J9H05jxttCQxHhhcZJkRG6s3Wq92?=
 =?us-ascii?Q?snW68ae7e6LnM8vbqHEA8Ovnk4X8iSP5jXhkpHbuu89pO+KRq82zONcyqPpK?=
 =?us-ascii?Q?vpdQqrrByOkmpWT+lIL5vhKKSRZpxIzYb2R9LkCsR8GmSO4wg68jaIj6e9rI?=
 =?us-ascii?Q?f7Ydj4Ac72PPv0/J6Cy6V/ydA7nM63COhaP4pCBMyJomBgscQcGyRsbP5Af+?=
 =?us-ascii?Q?rX9DB3qxUMM2Y8EHqmUHm/1c5bYMvICRwnHF+PrKbEpD88Xg4f7iPAOEBVrg?=
 =?us-ascii?Q?3NuSpL1rNhabJ0Vjf6txScKebKk869q5yVR/QLSjPeXl/A6UupjmISuw99Aw?=
 =?us-ascii?Q?4PmgQeTsqHvp3vZzPXLAtz68LOioKKJCBJpH/Zi2YnprPVeZ+3KHl1/aRjA0?=
 =?us-ascii?Q?9WMeEGPJgxHwdpO4niA8VecTwA1WnAXQjFxqa/Lpvt88lw2/DXpZc6kFxNzp?=
 =?us-ascii?Q?l6hgLhwBBV/P9I/GZxyfcWyQvbyRGrRU/1U8G3H/Mqzt8BNGgFnxnzaD3R+O?=
 =?us-ascii?Q?OidRExZu3O7cGO1YO5iyrD6d8JBsjGjXlqOgvlFeR+wf4N3D7i/N43CZ1RJz?=
 =?us-ascii?Q?31gh0Sclx7ppTbNgv+IsmvJ3T1y7WABeD+ewv/5qzX3OWM/P6T9CLTsp1i4+?=
 =?us-ascii?Q?IICUzbrPq+BPEhlHhmvGup7pprrjsyCcwSIQxQSm0YS1x85tIdajixaIXIr7?=
 =?us-ascii?Q?ES8V0NkMLbLVzcWGE7powf2TEU7EtJIN12jBat3Kjy9Hpn6NUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:03.8853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6594eb-c17b-45d4-d45c-08dd07f059fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver can require to set the memory availability explicitly.

Add a function to the exported CXL API for accelerator drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 6 ++++++
 include/cxl/cxl.h         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7450172c1864..d746c8a1021c 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -795,6 +795,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
 
+void cxl_set_media_ready(struct cxl_dev_state *cxlds)
+{
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e0bafd066b93..6033ce84b3d3 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -56,4 +56,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


