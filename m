Return-Path: <netdev+bounces-237248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E359DC47A1C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF244F231F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96819316918;
	Mon, 10 Nov 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LTL+3CDe"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6F31B83D;
	Mon, 10 Nov 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789072; cv=fail; b=hSyJToL5Q8J4cuBVH9JkZaYvALufMu6586tZSo9sZ0hAbZOkl8AD7DBYAy/i5x0IqJCbhxL1ZdA8+mzgyC5W9ZKJYLxjznZPaDH2U639vlpduF/pZykM1SXkzaiuw41w3AMxoT92Sk1Iz5EfRSVrnPhu17qQFt31v82gPHeAmI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789072; c=relaxed/simple;
	bh=WaFr/Qqb2lyMOhKj3+wAKQJKPUKAf0anzKH8xhx4O8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI9Nn/NfX6spptyvmcZfvs6KfXyf8QMO/NEPk406YVA7PPUpYe3ezFOnhlZpYSc0iwi6152UQrnKmjM/qRpVojQzmCti5x1cNSY7jMJWVdCvPGnmchmhWv7NyQy1R7fOrVI2HnDVeYCDsiOYxMfVJ7JYBqvoZlmhfKBtnZ1zzsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LTL+3CDe; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOxn8pvvzMADn2qO/bDWM2dRuv6nqIF4DuefGS2en/oVRgkUHBAs0PupGWiTho6k4+fa4gpT+R4UdTAqe0l4fb8P0HaRogvvu6sofV0lcxNPEzLnTTintxYx+cjYbFuHKuTSnAVbYJzPY1K7tCEjC9UMHj96qxZtUVSC+D88Hx/H0fiLhA8hZNbVgGl77QFFm7GrDje+gj1mrrY85W+9aJUTVntRp6jNrjdsJlt7YH9MN00yZlvzP0Q1LfUTT53fu95NQPSIE91u/W0V18I3SN9gN8SCiq5UPEMdbbS7YACGS4Ov18aJIPT/CmScpfXGT1BbULLZgU893UICwbISFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTJv0l9S/M19KBI4g+vB+bRYzusbKqbYuY3lBD7FZJo=;
 b=hT9yq/dxFt0e9IxhI8H11V3T2kPhKkfqWnjgtcX0Xbl8Zn4HDmOGbj7emvHwL6a7CDtL8/RohFUILvCt2E9EYhmoi9xJ8R3JylS1WuUfg+jbB5U/D/6UxtCvXPXt2BDtayQMj4M2gbwYvy2wCF5EkW5+WgfvMmSmf6xXD9jWpF3rrsfcX4ibxMhdC1za07FUaAyKuIScJzK7U/wdkk1lli/EhsTKazReFUkSeIxXzCOang6MkO7EgoJawpvSyYOV9ImsHjU9Pp5CAnbCqCbRS0ZQWQaSvIADBXWDNz/OqctB+p40+F6zDiw4eVhsj4v2+TJY5DeNzLWjmxUHS/DNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTJv0l9S/M19KBI4g+vB+bRYzusbKqbYuY3lBD7FZJo=;
 b=LTL+3CDeqclhAXI2RHwC2AusBmjel9yhvMLR8xWG8wUjhqxL6JqZC4UzWa0Bo38m5MCsJ8nzCzpJEHBCCLidhpPA1KV29VjG63JeS3Z9S2Ypo/gKXRRJ2EgotRF5/27clRAcsoRimsQ/UQ+bhy99jInqpvTQpDUGjdM20RrrV2k=
Received: from PH8P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::27)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:43 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::aa) by PH8P220CA0003.outlook.office365.com
 (2603:10b6:510:345::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:34 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:33 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v20 18/22] cxl: Allow region creation by type2 drivers
Date: Mon, 10 Nov 2025 15:36:53 +0000
Message-ID: <20251110153657.2706192-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b043f0-0bf5-41b6-1e4a-08de206f16bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAL/5wlmpgkE8Dtdm3dtzzUOyApSkDE6SLybesTI+bl+w2J/Bd2PNLiB6A87?=
 =?us-ascii?Q?F7lE93ovd3JxksCANwR9lZH3HhJltOsnJ/tfFgTqbBKEm1IPlmPqbER0GgzA?=
 =?us-ascii?Q?vdgB79FHs1gNjoKtEa25tSfheJQQPur41ehAkM+GPWEnlsCxOQ/LQFBB/fcF?=
 =?us-ascii?Q?XcxQD+VcUM/6yz+tcJbRxy5aukPN6qCfT9oQrGKxMbwgvVC/AHYCaBE/LaEK?=
 =?us-ascii?Q?8eWqhc/ihOlhw4ccPFFc+RTAjBx9LGc34lZVcf3PhXbwMTEaK9iyVlzQN0p+?=
 =?us-ascii?Q?tSdy7dSQpuw65QRb01qUXpXCdlf2eZZuDjOwSebaItCUqWUn5zueMswOu6N5?=
 =?us-ascii?Q?OWuCHUe6SJp6i305PbY4mJc0iyS4fBDb0q9HDBYpDIS4vo8JGS9vFDDLASFf?=
 =?us-ascii?Q?yeznRh3sOGKScrUIUhiwThrpyslQHe1e8WvsIHK+lCP0fSVj8SjGADVzzhOw?=
 =?us-ascii?Q?STRrIlkjdFRcGfx0a9yQyh09lFLOndv7S/aa0JUMbZbxQLJm6GgQzkVyMHay?=
 =?us-ascii?Q?isd9eQT7HQqi3joenWX/zk1ZQW8k9WCHy9DPRA4p346c76Jdffbn+hFp4Ok+?=
 =?us-ascii?Q?h9OYASfUxsoSrbivy0uCAOek3yajAMPWBILBaOS9zDd2qULQ4MMlhe/1Y0rC?=
 =?us-ascii?Q?W2Lhayby6fq6vJb2UBSuhQ0RTod1UCLul7f+4PmHod9mx9lsCtVuGOpoEaaM?=
 =?us-ascii?Q?zXQzCGv6FdeUtAbUazednOdOs6SMn1ktAt8wkAqbN3DNSlflDp0IEA4q0bsC?=
 =?us-ascii?Q?sp3yDt0zA9w14PNxtBBJnOzS+euqQnMTyAC9KVo+XWjeD0vyU3qNoKZ0ywYx?=
 =?us-ascii?Q?1F9VHMAn+nFSbGqd40dYNm7aYABJz83NAIOsJgAujQhaE002bhKwWNUBiW3o?=
 =?us-ascii?Q?2xIWuqrQysuuxvSuZ4hvs0N20FXJ8/raXfba0HJdyCZ48TMPzfG44IcMWyV+?=
 =?us-ascii?Q?OdI36H/A8UmERHr8z6rWk4nS9iYTqgq9E5Ca531lPis1wxrQCmQ5FS/shXX5?=
 =?us-ascii?Q?Bfc/PWeGuElXNcRSoPANRYtN39MQTAptLLlQXGO9PQK8adjp+1p4VtsOk1Xa?=
 =?us-ascii?Q?MWSwIt008U1Sk2pjzYyTAcxV9Ue33I+1YkAv1QU5DiJOm9eL5Id5b+Fs+l2L?=
 =?us-ascii?Q?6kYwuVHu2OMiWgBf50745hWjIfCARHOUcPykLg96YtwF2IwBNnuQF/5vF50H?=
 =?us-ascii?Q?6sK+oEld3YqR2eG+v5zpPFKx19D18Oz6IXlcUH3l61OrZensE6pCGhmWCeAr?=
 =?us-ascii?Q?5xpWW6pDE8vMTPwDl1Hux9/fGxrUdaHR/W95jPChAgasbcmkBtH9nzkQzdDK?=
 =?us-ascii?Q?IYUNWrc6LKLQcPMHnaxrQUMc5uwuS4aWU2tWfyaekYjLTQtielOJjmfmg+Mf?=
 =?us-ascii?Q?Jc3edN/iK0fBwfz1qcK2M9bYOF1mhZN8Vy7rQ1oChD/XSsV3lke7pY/caG4+?=
 =?us-ascii?Q?qF68sLkXMo/8pHshV6jD8qCjUt1Sa16wzUt8AeU/hiM091gHL962iSnYePdT?=
 =?us-ascii?Q?wRdaoq1vGJ8DmMZm9MXTpI42evwSpH3eMfcxL6A6SnAGv+XiIrvM12+6XWFu?=
 =?us-ascii?Q?UM7H+5B+dh8ylYxk5RE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:42.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b043f0-0bf5-41b6-1e4a-08de206f16bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders. Only support uncommitted CXL_DECODER_DEVMEM decoders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/core.h   |   5 --
 drivers/cxl/core/hdm.c    |   7 ++
 drivers/cxl/core/region.c | 134 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |  11 ++++
 5 files changed, 149 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1c1726856139..9a6775845afe 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -15,11 +15,6 @@ extern const struct device_type cxl_pmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
-enum cxl_detach_mode {
-	DETACH_ONLY,
-	DETACH_INVALIDATE,
-};
-
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 88c8d14b8a63..33b767bdedec 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1104,6 +1104,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 
 	/* decoders are enabled if committed */
 	if (committed) {
+		if (cxled && cxled->cxld.target_type == CXL_DECODER_DEVMEM) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: DEVMEM decoder committed by firmware. Unsupported\n",
+				 port->id, cxld->id);
+			kfree(cxled);
+			return -ENXIO;
+		}
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2424d1b35cee..63c9c5f92252 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2385,6 +2385,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
 
 static int __attach_target(struct cxl_region *cxlr,
 			   struct cxl_endpoint_decoder *cxled, int pos,
@@ -2868,6 +2869,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3698,14 +3707,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	do {
@@ -3714,13 +3721,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
+
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
 		return cxlr;
-	}
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3731,6 +3751,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
+
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	int rc, i;
+
+	struct cxl_region *cxlr __free(cxl_region_drop) =
+		construct_region_begin(cxlrd, cxled[0]);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
+			__func__);
+		return ERR_PTR(-EBUSY);
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		return ERR_PTR(rc);
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		for (i = 0; i < ways; i++) {
+			if (!cxled[i]->dpa_res)
+				break;
+			size += resource_size(cxled[i]->dpa_res);
+		}
+		if (i < ways)
+			return ERR_PTR(-EINVAL);
+
+		rc = alloc_hpa(cxlr, size);
+		if (rc)
+			return ERR_PTR(rc);
+
+		for (i = 0; i < ways; i++) {
+			rc = cxl_region_attach(cxlr, cxled[i], 0);
+			if (rc)
+				return ERR_PTR(rc);
+		}
+	}
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		return ERR_PTR(rc);
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return no_free_ptr(cxlr);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoders with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 static struct cxl_region *
 cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ef65d983e1c8..033de5a3ffd5 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -34,6 +34,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -43,7 +44,9 @@ static int discover_region(struct device *dev, void *unused)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1cbe53ad0416..c6fd8fbd36c4 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -275,4 +275,15 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
+enum cxl_detach_mode {
+	DETACH_ONLY,
+	DETACH_INVALIDATE,
+};
+
+int cxl_decoder_detach(struct cxl_region *cxlr,
+		       struct cxl_endpoint_decoder *cxled, int pos,
+		       enum cxl_detach_mode mode);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


