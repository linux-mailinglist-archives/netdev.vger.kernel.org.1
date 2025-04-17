Return-Path: <netdev+bounces-183931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64432A92CB0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB4C7B5764
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FD5213E71;
	Thu, 17 Apr 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QI1Qmx+e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C922172C;
	Thu, 17 Apr 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925410; cv=fail; b=gKapLWvJowmbGoK49dC6qNqvwPo439lIGuG857FZC3FkDaGUmt5+l/spFu3jQJIOTQxmh8XvZS6OA0uWv9g3jYk8vfG74ZCJQLAnpSOk6n61m0y14MR6mO7mKjvBEtMCRHRPhL3Vx15kwjnFLY1GKMpcX0hPBhtf0d7RTgLBzx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925410; c=relaxed/simple;
	bh=zIdd9aVb00+ZrWE5EE6sVxgC5E/S5q5crzFQokVb5UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKr8aiySi/SUjsCnM99Qlph2+Lq/8eHrqMCzHY6wkc+nxGTgtKxX1L32YEAyi2DgRMJds9FbNcvGBKLCLh1BChf4AplucXkk2Mc9SCGRA5JQ/qn0UY6bktOlthyjpzpc1O2HP/TPYdeSdrMKlaYbt2+XkFUPVZEgf1IUUSOlZP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QI1Qmx+e; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEMTGO4Lezy49ZJcg8X262jAususHtMfM+ewCwUOmdtwtQn6WdeLsD32imN3zG4bkbKppeAyu/VFe2I7iYilw8unbRLJ1+OUbt6R/aWt1SMQAFt8Byfsru4Ej/gQMGMi6twq5EI6sx09eOmu+nllttTHp8YLjG5E2HFmL4oKqg4QuffKXss4wIxqJKDH7FmsOn/xt6JcEzSzkZ9GHKS9fkd3YtNVyKQzQ4EBaVQ3YdShDkaMNqKmO4UqtLXEL4sNpHMoKdgc+5LuLu9COBk3KeqruptZfKTcowjGAkc9Zop9Qp3pCJQg1P0AuDqU79SPfMclDdSQAee5YoyIRvTgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw2GKNjL6WHRiEsxZbh9AJhYO0jLA203g70yxeWS+6I=;
 b=tpUxP42CKHBYO/zGHeMWJI5bAcSCzS2didDBDA4xdr1qS4EktZx7a9ThhwUTAMMLF176aI0MOSMVq+Q1AfZ363HkBbdqc9PfHDWyXMXukAC0XfQG9ZkuXtjFb/0DcokfXfeTtNhJxahBTQVHUGETaMe2StRu4/vdhco55O9xwEaqbGYgACANvrRPAfXOWmWnn0ujaEip7LFW+rajoQTXKL/51OAQ2zElAsrh1vGmq4sM+O4n+Q50Pg5fN34ijWdEjPNxXHWU+UPfaDaSZ77b+dn9gp3vR/yE8CkP0BOgGi+1PDPo/vHBr5RLEhXKoOaYotgwmNt607YKvS/yW46Bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw2GKNjL6WHRiEsxZbh9AJhYO0jLA203g70yxeWS+6I=;
 b=QI1Qmx+eLmPSY9Q18utSkkpw2nuSdUi7LBRy3pOCaFbgWV2jXoazvArH1uEmhHHBhoGFJJkocHH3p187V1X7tVivliw/cmumGwkLXCUh6USQnMOwlvi8/mGrZjnOY45XM2eTuRZxRqG1vm5DaXd+Ii7pzhKPW6CnjO3eW5o66a0=
Received: from BLAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:36e::24)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 21:30:04 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::1a) by BLAPR05CA0019.outlook.office365.com
 (2603:10b6:208:36e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 21:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:30:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:03 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:30:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 18/22] cxl: allow region creation by type2 drivers
Date: Thu, 17 Apr 2025 22:29:21 +0100
Message-ID: <20250417212926.1343268-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 36350e0a-65e8-478e-fa15-08dd7df70455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXZjp24+MyvHlVJG6QMeDG2+VjCryagDAhF9jcJCbzFvSzedv6U80ikhC96T?=
 =?us-ascii?Q?8sYNL50gZ3gqN3fDdMcY3msEm23dl0xmnjpqVqO8DQ5sBBwtWq8VF7XtfEwn?=
 =?us-ascii?Q?UC2PJp8bfdbNARcqzrMQd4egZvC6SdG8JphvhgBGHfYyV1OF9x9kgD94rsRb?=
 =?us-ascii?Q?CGz5e8f0391RWge4Y7h7Y6Y5jbSKZCjwjEvmUWUYK1l3Rb0ohIieKc77q8RG?=
 =?us-ascii?Q?1Omfp7lz3mpkUeJM+0I8FHIDXqmwDGzuWtKc7Vz7wXsrP8v6Ck/SFcXDhtBm?=
 =?us-ascii?Q?a110l0u8gCtIUF23YJUt/HzJYbVs+GM43nYPcvXBFj/L11apDAqjatdDD10t?=
 =?us-ascii?Q?ufu0zevmY7UgzqIcqHcVug/BEP+Qcw4cS4tB04UVNQFdNGBUIGkqdWWS2WE7?=
 =?us-ascii?Q?migRiKZkZYvJVl8W5+9sWgrhf7s9TWdnZ6dQqKve7ZzmPiYdOueglacOIICH?=
 =?us-ascii?Q?Muu7u/5+jo7BS6xZXtS6ThFG/O1BUMfGqlCcylhcg6jQU7aouJ06laKm7BTH?=
 =?us-ascii?Q?mwtnJxh704OYn7hDoevUyQdisZ5HZILec7LrrrAYenzyNXhOvXjsKxRA1S5U?=
 =?us-ascii?Q?s7VRakwRquBh8WAcdfFDOwOkfmKW2YYev7Zw+ZGrMYOiR9kSKtbj/opmG8NR?=
 =?us-ascii?Q?mLeaM6g+eLxBz02/dHakxxbT9K3qQI2rkCahXs3Cx7FxP7lacqRUnxN7KG3r?=
 =?us-ascii?Q?Pxxk2V1XHU7gs/3iLj8jX5ILwqS/sRPFe8VTOUiqTcbTkL/RiWi9SIlDdZ3U?=
 =?us-ascii?Q?tEP9b/R46cQIVk3Hxjt5ZNHenzDgF95rMNvr3FQIqcY3unHw7c9TIoJjjLj+?=
 =?us-ascii?Q?A3bVHdR2XEiYMnflIFtYCHUNdbZA1qW1VZiwVs+2wvv6l8enjKjNfSJ78DPf?=
 =?us-ascii?Q?PfIfi/UIPUzbQH4bGYEswbThc79/Wf1MatifAtbxtq1fajTGy5b0qNRK/FXb?=
 =?us-ascii?Q?VN4kbH3id2LHSu87jO9HTU0MYyeR4Ooe80scgE1RvmInRIh0J4O4RPJ0c377?=
 =?us-ascii?Q?ZqmeUVBHPkneVQ05e5y33+Sk2L2wibvd+jGFMLpGaJa9RaIXMjpxCJNNOC1R?=
 =?us-ascii?Q?gSn60pcOUv6aC2+Qlw5HgMaf7zikZ0s7458phh1kP7R917Xhv+CKymQXomST?=
 =?us-ascii?Q?M2+wo0/O3Ahq6PhrdiAOQmUCVkeezX62ARYTRmUfTZMqp6iH3z3cJt6mR7YT?=
 =?us-ascii?Q?h2u8sDjZggwDt5BWIpwvBqkXrhpWINWjie96tHdjcWdCBF9rMiz8WB3uUsNX?=
 =?us-ascii?Q?OFPZiJtsBl6/wYaGjEiP0ESzJUBhvymwt9w/0Y/6PKfaN19BI31unW0oizpl?=
 =?us-ascii?Q?wtjF/OTmRKH9UX9DyRmR+ZXqpnrZdusP7ht6CZoJSHgf26dLRoH1t5paXkq+?=
 =?us-ascii?Q?WxDZ/9yaa/PchkiomhxaCnvdjJw2lQR2pv9riID7JfnkjTQNmSfAknF/8988?=
 =?us-ascii?Q?Z2bSxfSjbp6EvbUzlMvfL6HHC7u/Y3ZGexM7i/TIjeI1jzHNcSZZs9HpuHWs?=
 =?us-ascii?Q?N6dB0+5k8zhZ9H7a1L8IbtePnxHsoD5z6BwLPqbvi2AA9L2CgeiX6pHwcQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:30:03.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36350e0a-65e8-478e-fa15-08dd7df70455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 133 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 3 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index af99d925fdd0..f55fb253ecde 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2314,6 +2314,14 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	guard(rwsem_write)(&cxl_region_rwsem);
+	cxled->part = -1;
+	return cxl_region_detach(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2820,6 +2828,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3524,14 +3540,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
@@ -3540,13 +3554,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
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
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3557,6 +3581,99 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__);
+		rc = -EBUSY;
+		goto err;
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
+	if (rc)
+		goto err;
+
+	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
+		rc = cxl_region_attach(cxlr, cxled, 0);
+		if (rc)
+			goto err;
+	}
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return cxlr;
+err:
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_region *cxlr;
+
+	scoped_guard(mutex, &cxlrd->range_lock) {
+		cxlr = __construct_new_region(cxlrd, cxled, ways);
+		if (IS_ERR(cxlr))
+			return cxlr;
+	}
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
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a35fc5552845..69b8d8344029 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *root)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c75456dd7404..ca8dd6aed455 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -266,4 +266,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


