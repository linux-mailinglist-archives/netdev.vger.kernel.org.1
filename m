Return-Path: <netdev+bounces-145954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9629D15A7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D201F22E6D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73941C07E4;
	Mon, 18 Nov 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PkZXWuTO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908AA1BDA8C;
	Mon, 18 Nov 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948318; cv=fail; b=QMacyq7crgG/kFN0t3yectmGrjLv+khvSBKlz4aAiMKYmfPWtZ6/9h6mwSohzS6MJILCndcr+fywEwXC7PVvqCuq+PrAntOnYkKU9jOi92vzp5Ttjt1CXAoxTMNbI7ihJU81hilVRJOk8t7Rwasp+TQqck07OR2TsEj2ioGeLAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948318; c=relaxed/simple;
	bh=5smm4lZHvgbsybqAB2S3XrFMsH+t3r8/uhtxe9GglLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvlyt5BeUOxsHWxWF011rrcvD/a5zB5biijLNKy8IG0UGuGY7tt8PpnIoSXJ7tpzR+pGdryNtKsmgfgYDEqr53KkoQTw8NG2UibaMsej4t5McaZtx5fXBoJ8n7AtIeQF6vCOhSPGRzGeQLBBOUeNfe09QtCoFmRO4SKNj2Aafe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PkZXWuTO; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an1QLWJJw8bh9Qp4JG8KE+MhQxNVXhtPPq455qHbB2LAGwZQqT8WrtilhKOTXHNAbfGawb3vFTrvm7yQismgaFPwIxQ5nEbI2o/OnVP6PEtrXxS8HoTFLE0KBsIgwhT0Ik9oe8B3LX/I8fn7Ah9nNVFcFY4ubpwja1Oc+Dggq0xb6CZ4OFefcz9tw1b0oJxCuxsv2HcJEFhTce/NvuZ8DgBWDIKbLI0B94NKCkzFDxvt6kVY5XCMYLefJ15ZO4JOanBneviPUvGdO7DJqXN9XkrtdhtPHZ/C8ou9mvR3NfuB3xNQ7P1D/l9c80gp0Bt/41GQfsGrwmzyJzdS8xvyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kipSxJDjXLfgTNhVJvwcIFcsIkToGZWUdB1pRI6iwSg=;
 b=yjGChY5Mytl4UYHP67rYC7JNrv0TeE8IGzdA8tBjWimsgbYoBg474RgwdXeage06ljbaLYbILpeo9LVhMZzAkSS/0VGP32eYCTpWlkmq71B0X8eLxlXuYVJQsjVr96Dfct9eH4niZ8yDuMV5aLhvyKgHkZrn0W2GoPJtlnFF1+P7NIs+xVX80Ozk9fn+uJPuBdQxrADN5mbWz7yq4OuHIbbTTXxQc0/m9R/bqCTYVu1v2NyEIunkTiWwUPPSECBOf4YeA9XKILtWYFE4Yd+8MOGEiZszk6bFvt4uviJJqkd+J1Usx2BYxU59f2fzj3ObF6fLvx/JYA6Pbq+Pk0Wgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kipSxJDjXLfgTNhVJvwcIFcsIkToGZWUdB1pRI6iwSg=;
 b=PkZXWuTOvZN5MBmxGRWTcy/EPJ1Fq6uDEpoGnBqIFeHgZEQP4QUn0vF2O7fiEMcFQDhxnOxNl4jxnXktXConSQMT532zJ/Gyi5YXDtRNFgfg7FSI8zAZuMqqL3aUHnxhT4R+w9v+NAWuen75NWrN5qtH3WwFbgwx5QrpWXlQnfg=
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:11 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::77) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:07 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:06 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 17/27] cxl: define a driver interface for DPA allocation
Date: Mon, 18 Nov 2024 16:44:24 +0000
Message-ID: <20241118164434.7551-18-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: df4133fe-14fc-437a-bf96-08dd07f05e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4yPeJerYT0xTQBK3abHgOP7Nb2clYekQ/LGq22TVz6D4ZwVc7TDFjwJL3km?=
 =?us-ascii?Q?Px5skc95LJlNHPF/NkhehxJDufw/jnpYrzI4fco8U49/Gz6EYXFPZd86LHG9?=
 =?us-ascii?Q?BRA+68mJAsOeN5jskPXexhQ+0YBSK6uIMDpxACrk0LwBumy2g3uz9lXygZrt?=
 =?us-ascii?Q?SMSv8BJcXd+sM2+6leUaq3hvKzE/Vg+RhappAUNrP5NzrQMvYEdcbkGqZrrX?=
 =?us-ascii?Q?/l3ZBMD7DKnn6IsJkjc9e+Ww6YbCTIHFdq+4tExpP8ffGS2moSf1vO3iZFbl?=
 =?us-ascii?Q?v9OD7DSvimOFc8IqSdDphIkShi58pcVh4+DnXO2MYe6W8HxPlDK7l7T2Fu7y?=
 =?us-ascii?Q?41xsLa7gPi3Ey7Ugp9WH/qt11PHmRdF2qgGlDYhmul5va/Hpe2Qum9UAuzJl?=
 =?us-ascii?Q?3+ZL1nFSWVRTkVQCD723Y8/L0lcv5ZLOKDz3F00xEdPnwqwywKcoSZnkoTok?=
 =?us-ascii?Q?+ER55dDM5WpC6DIMxROvUp63VMTN47qsdATArIWPTdCmntn9dF14w1NRxR6E?=
 =?us-ascii?Q?1Q5Vc5xnbUGiiX59s3hl2sp5mVnpLunbCyMh8iQwrTCKu/Y3vPjWz3easDCV?=
 =?us-ascii?Q?VVaXbFxXj/pO2ebrJdyrGkw/9H0Skwqo00JLqfiFQKVxvptXCIRwvWceqXni?=
 =?us-ascii?Q?DrtRtvmDz98GqvIRpKAF1kc9m7mZcm4fHn7mO9AFrhPkfM2CZz5GSyBHsLDL?=
 =?us-ascii?Q?uBZLF/tS9sj2eytLX8ocQxUIBrvHtSvWX/iyxCMZ7xxi4H88BSbt6+47JZ/Y?=
 =?us-ascii?Q?0GIQpFAi58IM1vRY713h2iu4Xqd/2Ws9RueMlKRAFckXiUXDGFtk51L4eVcn?=
 =?us-ascii?Q?FIEG7gMUtnCorA74Ao8K1SBF1cJsH60akZXzXtKYbMJ2WoOirpatY96kE5JF?=
 =?us-ascii?Q?+rK9snxP+8Jt3OwVlwZqLE5nhRmi/hnTaYqgjL1qxtH7Y1DEh9FcuQMIUXCk?=
 =?us-ascii?Q?BDCIBchjiXdaO7dmMHW2vQxDo5EYyMjef5YovmB5C0H4uYIuywlXLSSU+PZa?=
 =?us-ascii?Q?1u8PlgsvE74DX2hayLvPZO+fduQ8tTa0WqwSksK08wiGuBBLbZPJZIr5nebz?=
 =?us-ascii?Q?UixdzCtPAqQPxvWLh5tPNJzT74TA0kAvCuc6xPo9nsVHz3LXVgndqa1baG8w?=
 =?us-ascii?Q?UgAILE+hrX/svynHk41x2IfwjvqGy82/7ryzLCtxJmP8U2b2K33a6X8XYPjU?=
 =?us-ascii?Q?tHIupVGf2PluMpyk3tYgxj91AsiS9NQaQEn+XxjhTPpwXIpt+5ifC2C5FRPo?=
 =?us-ascii?Q?D7GRBro/e0B7paAH9ymvEpN4TPYMLxOT3OhI+FnZYGgTmAzaaZxcWNobk4FF?=
 =?us-ascii?Q?y1Ef7KlWV0BLxRIquDbJ6qkd6IVGAM8GgJ2rZBKA3vw9f6AuSdT2gNstGE2M?=
 =?us-ascii?Q?ezmKo3U8lWhEfcOn+vn2OBwIBVRwPsGzMcgHHyjB4QkO4t/bvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:11.3795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4133fe-14fc-437a-bf96-08dd07f05e74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Given the HPA
capacity constraint, define an API, cxl_request_dpa(), that has the
flexibility to  map the minimum amount of memory the driver needs to
operate vs the total possible that can be mapped given HPA availability.

Factor out the core of cxl_dpa_alloc, that does free space scanning,
into a cxl_dpa_freespace() helper, and use that to balance the capacity
available to map vs the @min and @max arguments to cxl_request_dpa.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 153 +++++++++++++++++++++++++++++++++++------
 include/cxl/cxl.h      |   5 ++
 2 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c58d6b8f9b58..99c32f1a0c97 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -420,6 +421,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode)
@@ -467,31 +469,18 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	return rc;
 }
 
-int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
+					 resource_size_t *start_out,
+					 resource_size_t *skip_out)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	resource_size_t free_ram_start, free_pmem_start;
-	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct device *dev = &cxled->cxld.dev;
 	resource_size_t start, avail, skip;
 	struct resource *p, *last;
-	int rc;
-
-	down_write(&cxl_dpa_rwsem);
-	if (cxled->cxld.region) {
-		dev_dbg(dev, "decoder attached to %s\n",
-			dev_name(&cxled->cxld.region->dev));
-		rc = -EBUSY;
-		goto out;
-	}
 
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
-	}
 
+	lockdep_assert_held(&cxl_dpa_rwsem);
 	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
 		last = p;
 	if (last)
@@ -528,14 +517,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 			skip_end = start - 1;
 		skip = skip_end - skip_start + 1;
 	} else {
-		dev_dbg(dev, "mode not set\n");
-		rc = -EINVAL;
+		avail = 0;
+	}
+
+	if (!avail)
+		return 0;
+	if (start_out)
+		*start_out = start;
+	if (skip_out)
+		*skip_out = skip;
+	return avail;
+}
+
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct device *dev = &cxled->cxld.dev;
+	resource_size_t start, avail, skip;
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.region) {
+		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
+			dev_name(&cxled->cxld.region->dev));
+		rc = -EBUSY;
 		goto out;
 	}
 
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "EBUSY, decoder enabled\n");
+		rc = -EBUSY;
+		goto out;
+	}
+
+	avail = cxl_dpa_freespace(cxled, &start, &skip);
+
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
-			cxl_decoder_mode_name(cxled->mode), &avail);
+			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
+			     &avail);
 		rc = -ENOSPC;
 		goto out;
 	}
@@ -550,6 +570,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_free_decoder(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	if (cxled->cxld.id != port->hdm_end + 1)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @endpoint: an endpoint port with available decoders
+ * @is_ram: DPA operation mode (ram vs pmem)
+ * @min: the minimum amount of capacity the call needs
+ * @max: extra capacity to allocate after min is satisfied
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. So, the expectation is that @min is a driver known
+ * value for how much capacity is needed, and @max is based the limit of
+ * how much HPA space is available for a new region.
+ *
+ * Returns a pinned cxl_decoder with at least @min bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	enum cxl_decoder_mode mode;
+	struct device *cxled_dev;
+	resource_size_t alloc;
+	int rc;
+
+	if (!IS_ALIGNED(min | max, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	down_read(&cxl_dpa_rwsem);
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	up_read(&cxl_dpa_rwsem);
+
+	if (!cxled_dev)
+		cxled = ERR_PTR(-ENXIO);
+	else
+		cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	if (!cxled || IS_ERR(cxled))
+		return cxled;
+
+	if (is_ram)
+		mode = CXL_DECODER_RAM;
+	else
+		mode = CXL_DECODER_PMEM;
+
+	rc = cxl_dpa_set_mode(cxled, mode);
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
+	up_read(&cxl_dpa_rwsem);
+
+	if (max)
+		alloc = min(max, alloc);
+	if (alloc < min) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		goto err;
+
+	return cxled;
+err:
+	put_device(cxled_dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 4508b5c186e8..9b5b5472a86b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -67,4 +67,9 @@ struct cxl_port;
 struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


