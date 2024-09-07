Return-Path: <netdev+bounces-126221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1357A9700D5
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AC7284150
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C520414F9E2;
	Sat,  7 Sep 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z9dsAZwZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F014AD22;
	Sat,  7 Sep 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697192; cv=fail; b=CrvaQ7cXMpyQdGuFz1VXL/nzu7MiX4PbdHhkMNXA8fFf4Mzy8hpLMs80fKzg+zsjM2zTN2GvAczw7M68DytwD6Fj0NtoaViusx4ZhIeGBp+gogjamUcXNMaat/TP3gtVnWjSipoVYkolAsR0mdMljOB3Sd392KtrwB7sFSNIUEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697192; c=relaxed/simple;
	bh=NMDKmCMmDP2HOl0Wzb9WsNa1tnuy0FCCRw2rBLEQl3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1CVdOF3RUqUt9VNvom+JsbDPrzbiLUlWaI/a/wWjnYNkut6rtgsK4pGTg15dFYtzKI5IpKzOarjD/JNtkyRaWGNYp1y+aw5dgopcZedLmYw0lOAfwqGijO8dI0XLr06X7+bsvi2qC42iZlVQTLtwM/ZmQx9hy14aRiHXxlWGec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z9dsAZwZ; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTESdCkJlwhduMd+n/fENfEHPs03dMuxCQtzeffsGxtvgyi77k85cYbIWRpk57sbfRs3X5WL6Auz4AxyVQ5MVWLCY9yKvLu8b5XJIdf9Kg3+8pYL+ZvuUlPlAJXCILcaoaOc8jNP//1fhp0EnAbBgMbUP9TtFhDAYBjvf1Sr/L0NG3wDzV4dZsc1loqWTDEhEwjgtX1Yd2S9dajnLgon/ffrki5i+s7K/4LDuSksq/f5Gtm9jA1dBl2VxcECwza5XwVUytMjjbh2PIlIUaQqlJMt81ulKmjTUutlkV0prw+KgKBRH+H6EZag6glvv1lHq8OvDZbqq5FXEOGy+zu4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w4TrBvPOtvcnfy91SlHDCbID1qMXwCEVL7yytr9VOE=;
 b=WeHBxNnIFdNHMbLmL38aRVDUts7jNY4/vZ9/iHRxM47FMDusjW8au6GG3w79VIlRABOnGiMsNYoL9nwK78XQGaqoiBcfkFwRM8VXaVre1jfd6s9Rf2YASpIoAWvXTLBodDpLDvLXWLKjUGxFnIznCTRrELTE6Rb9Z2vzUvDlf6C7gke5eQ3MLvMdwxtUMrCnSqz5YRE2aU9UEvzwjTmU0IqJ6DVV4GvJERFEeppV9MILqo7csb0Xxvcf+SLrGD2tQlgUzU29tu+OIl3Jtu5jPJxjMq4vK13L0BYo1rBgQHgXBBJF85eEyHiwouNBSl8jYtiduEHN/ZSFYvzzA6wE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w4TrBvPOtvcnfy91SlHDCbID1qMXwCEVL7yytr9VOE=;
 b=z9dsAZwZeyw3Ugrg9Dl3lzevWRuc3jGZt559R6KSoz07RYtLtapwel19yPOkiWj46SuQHkcUnpQwC+XCEBWAsb2fTvOEBoEpUW/CID0WYQOklucdtQKl50m0HZF/G41yfr2anolZgDxWY8VqIt5nyqiQGUy58mD3uocb2Ri09qI=
Received: from DM6PR02CA0135.namprd02.prod.outlook.com (2603:10b6:5:1b4::37)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 7 Sep
 2024 08:19:44 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::1d) by DM6PR02CA0135.outlook.office365.com
 (2603:10b6:5:1b4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:43 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:42 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 13/20] cxl: define a driver interface for DPA allocation
Date: Sat, 7 Sep 2024 09:18:29 +0100
Message-ID: <20240907081836.5801-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3b9c36-8b5f-4738-d9ac-08dccf15d47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c40h1b/aK1Xxmzy/Qs7Ts3LpH5sL0tzQ0R7Py6CIE50pn6oFmRgp77MetCmF?=
 =?us-ascii?Q?QZ7Dxpzps8ad90CACT9s7sac/ohBWzBpckvpiZvaYlh9csY31F1lfHqDRFLe?=
 =?us-ascii?Q?oB7jijn3EcFoOojplK5d9n7CWNp0ABBbCXh2wUJ5WSR/l8G8l8IKZgeF4I9N?=
 =?us-ascii?Q?oP58f0kW+oVzi//pCtLrceuBNcRtpWzSRYIXUKOO9YNoElTPSOqJaeWMz+x7?=
 =?us-ascii?Q?p5MHV2QJVBABpiomr4hl9Qjuey6tH64trbz460JJn2nt/JKFOgzXG0QpxtiA?=
 =?us-ascii?Q?C7okj4+/Rcw5/rJH+1I9zUGxkpUdMccLKTrU0WS7aXIUwTfsWlpQXCai8EzB?=
 =?us-ascii?Q?17xHKn2IikYauOPnoD/TvxeM9fhuuG8HNqZNFcnghCPz2ORTzynhoh6tkY0m?=
 =?us-ascii?Q?1bZCyZ6Dc+mH51+JH1hixA07j+yeMIGTutdWkRlXDy6QBCmb5D6RekfFZx1H?=
 =?us-ascii?Q?013rm/sgG62BbuWZoD2nWdGXvvYSB213GcBtL4YcPKHO3g0Ha2JvkmtJ9D0f?=
 =?us-ascii?Q?S2DDJTiZ908+2YIR5p+sd5Vjw0vWcHzQaWrmf+b4x0Wsy3dgrZaMt290YEGe?=
 =?us-ascii?Q?ByeEmUILs2QwQrpYp0jO7Qg1uxF3og4A3Z2kRR2csr3r5602qNO0PPHOKYEb?=
 =?us-ascii?Q?ruM0iWEC5ILfB7IKW9ar1eRBWPPko20bJYi3UUeUfcJsOsQFIRz6qYlJR3Wb?=
 =?us-ascii?Q?gL9oTl2ojf5wqDesdKsgAVAGezbJWa5+302J9mJTReYM6Vvd6dYgepo9gqHy?=
 =?us-ascii?Q?NbUsazDO7L3N0xQ8iH3xG40/BQxuV2f3YxYVBUYbhIYO20iPQYokQuWRX1tp?=
 =?us-ascii?Q?Yq+1kvcJahuyf98qMHYRQAT8EbbOwuD6freQALMbdu6+OV4J19XOX2UEBb+U?=
 =?us-ascii?Q?E2MaARcY3kQ4PN4vmrm1z1CFNVj9QsKwbQjckYRA58vwem2zEqXhkDr/x1n0?=
 =?us-ascii?Q?Fb45kFSW8Txzt15iJ8EMWaUosyUGDL/KQgnHAwM4MFOshY8JmPzrIjsKh6Eu?=
 =?us-ascii?Q?isOoM+mVZj0WZ5ta/f9W41o2yZkg14bh3uqLZtrDtzglglz/kJftwMub1Wqv?=
 =?us-ascii?Q?LHYTmxeYkj/ZHuOrMyjW+lxDk8iizulhbQqLS++kw8dhrD1IPRwXAqF0wPYd?=
 =?us-ascii?Q?8WPElOZOokI40jPnviLgNpMkUlt9KQg7ZlYSIcgjz33FMKHrYzbfaHG6yl5v?=
 =?us-ascii?Q?lkYSmQdzMYq4xNJc8G/OLYuBcn/F4ytuW/BkVIUquW3KuGxo5x4K3+J7Hpku?=
 =?us-ascii?Q?bK0u+N1Wu2A3H4UIppSo/RptGao2UWhduc3LMrjt0bdo8njbs1Ej+h8y3zap?=
 =?us-ascii?Q?onZTgQAGn+xfOzySN3P/5eTGPjK5gBKTJeCHr+HqbfHfiFczBToSrMwB/Qr4?=
 =?us-ascii?Q?11t+vB7hjqQKI9ykDO0L0ATa7Y7ZDU+wqCs1ZR+El10y7PNxsFXa4KQuXSvp?=
 =?us-ascii?Q?imFa+dNO1NFUi8JTyCvCjizg5Lk+yUE3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:44.5045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3b9c36-8b5f-4738-d9ac-08dccf15d47c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

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
 drivers/cxl/core/hdm.c             | 153 +++++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c |   9 ++
 include/linux/cxl/cxl.h            |   5 +
 3 files changed, 147 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 953a5f86a43f..1d034ef7bee3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -418,6 +419,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode)
@@ -465,31 +467,18 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
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
@@ -526,14 +515,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
@@ -548,6 +568,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max)
+{
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
+
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	if (!cxled_dev)
+		cxled = ERR_PTR(-ENXIO);
+	else
+		cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	up_read(&cxl_dpa_rwsem);
+
+	if (IS_ERR(cxled))
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
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 826759caa552..57667d753550 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -117,6 +117,14 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->endpoint, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err_release;
+	}
+
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 
 	return 0;
@@ -134,6 +142,7 @@ int efx_cxl_init(struct efx_nic *efx)
 void efx_cxl_exit(struct efx_nic *efx)
 {
 	if (efx->cxl) {
+		cxl_dpa_free(efx->cxl->cxled);
 		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
 		kfree(efx->cxl->cxlds);
 		kfree(efx->cxl);
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 60a32f60401f..3250342843e4 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -67,4 +67,9 @@ void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
 					       unsigned long flags,
 					       resource_size_t *max);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


