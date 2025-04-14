Return-Path: <netdev+bounces-182295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14680A886B1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2AA1785BE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067672749CA;
	Mon, 14 Apr 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qsUipL5Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391DF2797AD;
	Mon, 14 Apr 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643653; cv=fail; b=ccuoo5oHQYXpaRjwv0wJmnaIUcreT4yEaSaWI7cMPef1GChlELT6P/z+RsFLPikL+m8dLltFiKPv/xFSUiHHMf8rn/z68o/FIRtCyrAs7MXTNS3ke5UGS69SYLB8YWryt8UJlzcQY0Cmt+UZY2cSp+UHWR9Nfvh7qaRt4xmCH8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643653; c=relaxed/simple;
	bh=TlYzICp7Hbxav2ebMAwoHqBIMXjMEylfnf5Y6upUYv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVS5t8j2r9k821qLnzaq2FfPgPW4acuzP6VP/R8453s8ls+OIM2i24YbR8HCuxskovYKs2umGb0G1Ql2xPOgIaYvxFB3XOIqjtsOMU2CsIFYzS5j1ri16O/WvcqWegN2K0KyL/FzJche5qQuGfb+YejVDurWXcV6FbA59bOFIH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qsUipL5Y; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzBmWudGdhlNvDqXZDyl5OlABA17gx+k1KHKqXXVUQFxeIu/x7FZGjRMhuamNg4gxXmygwCKKATu8K7YFGoX3Dew9vzlfnS7iiynsTjqc2/Aqr/Si1n4Og4V6qNutYs1Gc7Rg6OiOS1gi0iVsc6YuvL5/FYuPusyI2Je3B4U4ub4FQU1h/uUtUIFJAWQ1/D2TsJW293HKk0CtPyUPya9XQtaWnclfXZUBY93OjZUQ7/R1gTqqe3qgMZ+fZ3pvtlAbGWl6iB1sxQl5nW4C3bkYzx41bQrbdepIfSJDSNhmK1GY6l4UVHlqJSNU9abKYzsB4aV314hcCIbeecQD/A4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbOA0G8cV8mD6Ia4ZJaCDh+oV1FS4n9ARcC6RcB2Gg4=;
 b=Jjf7PFcY4GX58ScuvIdycLyrvLLtwZ8Dl7HzSGeu1muInBAVE4G2C5qxqGkzPsioM+BzSOCOp6qjuSRFnpd1bLKn1eI4xpGjFil7fhXnyR9B6IXgIFFKjUUudlrLIu/c4J1NMWKiuN2ITcXiNJRj7sjMRL0AK1wsPfrxLfTq5bu/YoFO1hgewqUbf/I0YwB9HKh+CVRwDi4Krx9NCJQGqnDmlAJOvsRwm9pUfPD61F3IIHT8WB4qFc8475LgX+0IxeWTUGJQ2SfXk9byFiyIC6Qx/ZatT1m3XAugYIft7H/aj6U5cQe21Xvs6vwKtGXquwL0/bBBv1mgqTLkalZEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbOA0G8cV8mD6Ia4ZJaCDh+oV1FS4n9ARcC6RcB2Gg4=;
 b=qsUipL5Y654xorPgCfPJ46huRMlQN2SIOe4nMgU/NEC8kOd/+Y52F2ixlbt0otst224hIosONgGkG6tidVQI0IL1TWEL1fEN+48R99wzrVoJgVJ+HMJo3at9WaSVcvUO/gMgqGL9o1FLDE7FPNqE/t2QHZdCc7UYQXvWlPsiSX0=
Received: from BYAPR21CA0013.namprd21.prod.outlook.com (2603:10b6:a03:114::23)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:14:08 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::97) by BYAPR21CA0013.outlook.office365.com
 (2603:10b6:a03:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.9 via Frontend Transport; Mon,
 14 Apr 2025 15:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:05 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:04 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 13/22] cxl: define a driver interface for DPA allocation
Date: Mon, 14 Apr 2025 16:13:27 +0100
Message-ID: <20250414151336.3852990-14-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1723e65a-53ad-476d-d396-08dd7b66fff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EIs7e0iCjQzFSim0JVJF9PxPB4PrFEr+wSLwH+atxWDgR7gsrGSifYQK5OGA?=
 =?us-ascii?Q?Jb1MFs7crSWxeXPy7gzwwjPTZTtRI0hVkaDcMmuiDm6cYJuhIH1/gKef2Qg9?=
 =?us-ascii?Q?/MdghPAMOm8IrFhTqHnzuS/KPGTDNRV5qiJWl7GtIxRq6kkD/rOrD9bcbeG4?=
 =?us-ascii?Q?1DpslNIGZUyPKjWM/F5SqGnXPuCdFlmZCy7zPvqNlKoXThLkPejJW3tNNhXc?=
 =?us-ascii?Q?Yv3x1tru3DKU70FtiSt7vQhUFmy/kD4HsAsJKtftRSFQEZbQycrCmcPpbMfs?=
 =?us-ascii?Q?8rRxUZSytaj7lxeeLw1Pul4FWbyDkocp/MoYO2/QoRQsyUz+lXXp27+U1+S0?=
 =?us-ascii?Q?diJAWAJj2SM/OTigpN1bkhonRHSTLUN9cveJgm2rTFGwT222NGtJBDruG2PI?=
 =?us-ascii?Q?witCmVslukVBunI5k65kiM3w2qFRRhUFbc5/GBCSL5hCxovTZRCRqjy7L1Bz?=
 =?us-ascii?Q?FdwlJAkGhJt3K7Xk5iA8B5Cvl6BXr+WdlQHYjhto0ECUBHUb0qz+6jExNVCQ?=
 =?us-ascii?Q?QL1iAKLM+dM2/T0zfBjDZZ8exXzEPD8OkNZUCaKYso8bsskFY3c+8dbIwzh4?=
 =?us-ascii?Q?z+/5qXGPhAo93C4iNdJXGLl+v4Itpmw9lv4Lq2QIB/3NOAXl1wtipv9/s7x2?=
 =?us-ascii?Q?iPbsZRtDX1rNqAS76CbLAU6Df/k00e8KEinFYqJxnVKjG8V5pY4QXVzj4tYQ?=
 =?us-ascii?Q?NrpqPogZN4ESxigDMK+vvXGsekewjsRbrOKM2fR4rRKgONh+uTmY3Gx8fbJ1?=
 =?us-ascii?Q?sGTWACPltG/MX2PYedqYBZ+FVjCJylKB5hnNyEKSxMNMN0zVyQXrEc7c0Q2/?=
 =?us-ascii?Q?B1S1ALAFJ0wimvQoYamRM3ERfSFOa3hiePZNU2kutlMLqw2L1WU7Z+6+Mw6Q?=
 =?us-ascii?Q?OAizeAcHnXC+3rw9aLsw60ydelZhjS1WrgDcQ8CEw2T+pE1O3ChJ2P8XSPhZ?=
 =?us-ascii?Q?zeD60IiEdWL4Z4dj23LTwU8+7f84fpSAz8n0vawtSnHaUsdkfw46gFGK+0Pf?=
 =?us-ascii?Q?oB6GDjS8M8dehQAXOo6FOebaO6ZF1+ptcNmVzKfkvIIefmuhDchUrcPT1Fej?=
 =?us-ascii?Q?hlJ/4tmYMHetR8JfckhF1aQyngwD0YCp52jVfdq+KDB7pExhOj2D1lU3heas?=
 =?us-ascii?Q?A/jMYbaMgylyUWG2dVshqA/zEbRfoBeyKhn0D5nHL3oF+69kx9Ysb/qm3rKX?=
 =?us-ascii?Q?1LI/kIk58lYB4zC6SPQ2qrQNW+BanB6rjWwAlMk6Cr8sCW534WBcZ24+zguG?=
 =?us-ascii?Q?IPNmDl4Iu76D1LlacbCE5LwhtxG96BM/9tKs72Yws4YKDeG71WtY0OZbhJuG?=
 =?us-ascii?Q?oCbWuIDmIIVn22SVUQz7t4K3LjGuTk172zSGvitY5kd3h4nyQqqTWypyAHij?=
 =?us-ascii?Q?gh8psk4mfNQ9pIlffeJVDicmvSbfHyzdAPnwnluHPa9dECQKOeUr/bGyhHLQ?=
 =?us-ascii?Q?xzLz1io3uDWeXvhn/2mmPprt7sz4HXZ4sqooYjrFmRnsgLara5F1IJSceGHD?=
 =?us-ascii?Q?XGKesY98PK17xkpVcM5RDeIpXt/X7lYuBagsdT5tqBXhJGdM4etgCUvNhA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:06.6359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1723e65a-53ad-476d-d396-08dd7b66fff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Define an API,
cxl_request_dpa(), that tries to allocate the DPA memory the driver
requires to operate. The memory requested should not be bigger than the
max available HPA obtained previously with cxl_get_hpa_freespace.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  4 +++
 2 files changed, 81 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..18a6ee74f600 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -572,6 +573,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -686,6 +688,81 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_free_decoder(struct device *dev, const void *data)
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
+ * @cxlmd: memdev with an endpoint port with available decoders
+ * @is_ram: DPA operation mode (ram vs pmem)
+ * @alloc: dpa size required
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. The expectation is that @alloc is a driver known
+ * value based on the device capacity but it could not be available
+ * due to HPA constraints.
+ *
+ * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct device *cxled_dev;
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	down_read(&cxl_dpa_rwsem);
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	up_read(&cxl_dpa_rwsem);
+
+	if (!cxled_dev)
+		return ERR_PTR(-ENXIO);
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	if (!cxled) {
+		rc = -ENODEV;
+		goto err;
+	}
+
+	rc = cxl_dpa_set_part(cxled, mode);
+	if (rc)
+		goto err;
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
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 0334c8cc9a01..5d07a75aaab5 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -262,4 +262,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
 void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


