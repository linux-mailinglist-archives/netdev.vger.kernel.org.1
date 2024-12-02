Return-Path: <netdev+bounces-148183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7729E099E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F980282117
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4921DB37B;
	Mon,  2 Dec 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u29AcvqW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703991D9A41;
	Mon,  2 Dec 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159602; cv=fail; b=SA1dcnChWdJGHV4oAhjKAtckcRQBJTDOWh1PCjR5IUQXRA0ejWgiwzbqYTPYQqVB1ULJcx75QKv5zP+Y8idnBgz01SC/yFHIsq8pcJ+hzFVeZ944JoBozXwYFOE+7gxhSZodMiZ+33Req8fcwNcQCNXAsdQb6ThEqBASQc87C1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159602; c=relaxed/simple;
	bh=Uz78SNMD1OwxxswFKhWd1kso3i3cwy8E81sU5ZlpSh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvLxMMZUYMwoCA0fMKVhYFxtR4aFEKYoWYZ9SPXl/FwbpvOhguTkIWjS3A7YEAb/3o33L7BiqBPfsGOoQXZr3K+GtHHuaTG7i9RjMjgmCSmD8m9/NJFhTr6ABuDGRCMH1/SJjN6urCREfL0bVPse5Xn3k3FejejmvEGArgIqRYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u29AcvqW; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOUqRO9EhbrHc+bgUmB+t3fMXVs6sCbKCN2lgqhfAlevcBKAMCZ9P6w0YFhbKXQ0o9zz0ETWQyBnnrvbTT9gVB5TeV1LEKqg1aPrZdzia9A2Ka9bZ8n2wjtRas4dZ1RxhFtqWzslvVA2XRbciYqJApZvCukQbw3j60ndt4rB+GvJgU9ikAcxHp+/KlNFb9a12fkuMgbF8qjZuoilO5Bg3kxPgqMOygj4oPExBbFr7866X/oXAMdXs+exJEpLuWFW/J2Y936pGhw+NyAS8yrnn+YtIc/y9DdLJSYZ833JCcKvxAh29bbGKOzqn1cIlUT2DjP5iTOlFcUWJu7wqBjl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAPQ77X8CeERoVKJG3V7zI4Cqou6K1MtxcwTfA068AE=;
 b=iF8m1Wr7YK1sNdZWRNFjXqvlQAYqhyzlqk8G7EL4mcyXzcyy5Gy8xUZUq7jNI/E9KbKWhOxOs3n6opv97xn5fz/ipgGuobqbOud5ttHp+LgqDexMuJ1ttqxWLZk4b7rN15bXgLKLJrzGocUnq4i80rBAQCunyEtu/zvRIRRV1JrhKCfQCGAL/ettbVfPAvhe5WCtFkXjWJd+sB9ChDc2+4kdyJ5qG1YqToCU/1cJMxL4YYiQy797/MMMaV8pojCt2ndBhxezp1QBYTUR6XxAw4y/5uDC8pWbzhb0iHP87KfP2/4FWBm3iFe3ztvMYG+xuyEls9hG1IrNkAxRMnfaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAPQ77X8CeERoVKJG3V7zI4Cqou6K1MtxcwTfA068AE=;
 b=u29AcvqWCY09NM5Plo0JwSjkTSR/fv30dFwLIbFnNhJsyxd2Upq21v6FT7x7gBDmgZnREsQLgXmBig1EGqL0tpP1PQ/atK8FnIh1UNE9hH6XleJBUszfcSszRBa1JfFsgcQjPUynwf4rT4J0ITWlDZtf0WqNw7rQqBvKHxQfqqc=
Received: from BN9PR03CA0514.namprd03.prod.outlook.com (2603:10b6:408:131::9)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:13:02 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::4e) by BN9PR03CA0514.outlook.office365.com
 (2603:10b6:408:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:58 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 17/28] cxl: define a driver interface for DPA allocation
Date: Mon, 2 Dec 2024 17:12:11 +0000
Message-ID: <20241202171222.62595-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c14bc6a-74dc-46ab-9636-08dd12f49480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ljcpdgv/SCORSwvwviw3MSRWxWRssm8MDGay+iRdcS8YOGiw7vmDDcSnAvby?=
 =?us-ascii?Q?EVEsg/Z8l1rKnYe+crkcW/oriSt4iceT6GoviIp3vGgt3bQFfYDNKNVjIpbQ?=
 =?us-ascii?Q?8RozyqyTZO234IV5UslRK4V+a0dp7St6QwEOO0oT3C12326HfNdwn968g+SS?=
 =?us-ascii?Q?N4LYJFXQ5e+OOTr9o1iuB0s5Gwzm6xVlPXhK/8qVRFUJLH4AHUdlxq1K7W2C?=
 =?us-ascii?Q?s/Sk0uzMz7jbrXyur9sFKF/8byDk1mKjCXjszzzypMZar5KKrG8pUprfmkXk?=
 =?us-ascii?Q?vwCXPr+UCgPSeWTfRs8nxWLCOVCyZkPPcYJho32yAVM4rxfuWkAav2MwRPbu?=
 =?us-ascii?Q?/UCPqZexxh9wc8jgCfBJApVQpVquSmWKq40ecKEYvbraEkqXfqwXoyXE0019?=
 =?us-ascii?Q?R9vkFjjKLUNTlq6kOyBtQC8K+61Xnsvsl8sOcLtmHohw88WrAaJMmOBRhTsc?=
 =?us-ascii?Q?OqKm/TbjxV0K5HHKtaLeEqGW5UW9Qfsnr0zeslkxjZEPZyM1TnuTkFVXDwo/?=
 =?us-ascii?Q?WfZ/mz3uusrmbOfimv7RfwQsOfPWkq0GLBAhG067Y4fwmmpgQjyf0igxWb2s?=
 =?us-ascii?Q?aWu7lL+jiQ+VbSD8CI9U2KuJzrfZpmIYQhNgqdtjTn1Ynq3W/l/aIHqpOo/F?=
 =?us-ascii?Q?WX35WIqz/nQcRCPHAIoc1uJ1E696OboceSnt1JMS1DRXYDURTPGSlD3gu+Dw?=
 =?us-ascii?Q?bjG15PYRG8Zacws+qu6+mPCiXkprDXHXSXGUvDStSD2sVY8zjgtJMbtYMAmN?=
 =?us-ascii?Q?dKDBdSN+dz4FQEXJcuM47CciXqro0FICI8iXC9vPlDST6vaC0CE2OThS0Qro?=
 =?us-ascii?Q?9nzcjotzRP/EGKaTOjIk+ytiijtovJoLzPY8zFnEn7QirJakCqf1O2lxe5us?=
 =?us-ascii?Q?aUO61wtvX3bWrzbmlztAYjkueYUZj3wC1NbDhJUzyRazMeLpojmvwyuDskbU?=
 =?us-ascii?Q?UAB8Y+BFTYzWIdRtWBvOuvzQxJ84nv9ZiQNxwYYX4TtmXYA/dh6WyUiN3Jp5?=
 =?us-ascii?Q?3ogWtZbX3+NSKNkU2nlhGXYscQQClMAxmKncy1SUbj/iQtSCa4fwQPU924bA?=
 =?us-ascii?Q?XhEXbSn5ivpWTwEV7u0Zwddg8lQ4o+kKEDv4Px7vCDWiG9yBbnBuLdrRa8Z0?=
 =?us-ascii?Q?fOTK4VJrP42tKBJuDMaWg6/Lbf6p3bI+s4UL4pPqhgjaXXk9jS528WzVftMd?=
 =?us-ascii?Q?xJROHScREVaPoRaNt8mVsuTIP3CKhgAFUEvgR9zkXkkegAfjt4ywgRRgYAGE?=
 =?us-ascii?Q?Fwq7PuQ9G6+ksSIs+jimvN3v5E4llar61JmtxlycxvWy7hR0c5GzjTyh0qGG?=
 =?us-ascii?Q?r1tHuWXt2ecZqTElb+YXe8QV1OM8ONw+GDRc1HkWXiRqlJgwUEsdJpWDIslm?=
 =?us-ascii?Q?NbIo75UkxboATF13fb4iaZGeJaI2NPtGUVyXlNl7I0O6rk8AVpytrrxFtDgr?=
 =?us-ascii?Q?YYIeHxPk1uTeOZiAiJIxa1zF6cxXJ38jtm0CI9h7tNBfYpp5vFnHtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:02.8628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c14bc6a-74dc-46ab-9636-08dd12f49480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628

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
 drivers/cxl/core/hdm.c | 154 +++++++++++++++++++++++++++++++++++------
 include/cxl/cxl.h      |   5 ++
 2 files changed, 138 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fef6f844a5c3..30ced3c1fef6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -419,6 +420,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode)
@@ -457,31 +459,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	return 0;
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
-
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
-	}
 
+	lockdep_assert_held(&cxl_dpa_rwsem);
 	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
 		last = p;
 	if (last)
@@ -518,14 +506,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
+		goto out;
+	}
+
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "EBUSY, decoder enabled\n");
+		rc = -EBUSY;
 		goto out;
 	}
 
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
@@ -540,6 +559,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
index eacd5e5e6fe8..c450dc09a2c6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -55,4 +55,9 @@ struct cxl_port;
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


