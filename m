Return-Path: <netdev+bounces-111570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E10E931949
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F225B1F22378
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD51A61FC5;
	Mon, 15 Jul 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V25qE8Mp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F76CDC0;
	Mon, 15 Jul 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064541; cv=fail; b=Xak9eXewzwP6uyK2BAx42Dk2K/ebBlYUIzUjAFj7Q6PQXPIccrQFVNg1qopisvXmL1WSjPTrNLmOMtdjlzXiPoCQIKbdhpJWWxdQCO/TSZK9xQVI9XmMFrKRO/ohARmswUwuUeOx2bgFq3k2GTsgeCWHPR7FPamnAZNe1dVdKjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064541; c=relaxed/simple;
	bh=gv8IqeUd/PvmEVS7FXkAfTqWkvW5R7riZvLEbUSb8ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uookPFpdVcZbg2x5AVtMf8N2esx69BYLVmqOzsq/eL096yuTRSGdOPNPSoLx9gwPljlT5GS48g8eoBVTdhOgA4yGpHCfPR3KZRyWmV7WoW/iHTPzf2nG3AVgpR1cEz29jTEUJZ4VxbiazHkFilz1PhxjgeaeKSaHjebQReJ+YC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V25qE8Mp; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwPSO7g8n3UhU4QmLivk0bumNs02cn5idemFwxPg6A/z11ydXtIiIduPSBphGarlXKQmyU/KekwDV0kj5CtSD8/KLZWVQR62L7SzEfYczUXKa8Iy+SjvV+CpyzYwiejxuaQ2MvmKLrZJ8Y26fvGKIQBw+ag5nsMXq7bCTXUk8W9OpQw66p3Qs0vMaZ0OxwdWq00j5n9Ww2cgLfQinPKJ4cbP5Ycslc2PIf2HqJlmSJJkinlHGJ9jbfR1f0mC+hpTmCAN7HC83fPjOAMT2Ri9vTYCUzLhhNtf53X7f3SpeILJyo3yH5dya+lB+IoouBgSXiGwJepriIh0MCty/TMzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1h2bTIlDVA5eUc+B8YwO9nUxz2ompCDE5qER87lyeg=;
 b=PwKrWeOOdgg1AeMRUdDjR0ehC4zi4Mx6OrQeNM2WRKst9byB3Ewc1Gn/kiC7u/HDbDlU/abGBxJ+i6A2lD/pZuScnfCR0Bc0wqZFRc2tCIsbLk+nbcZcjeGCIrj0e1sCwaR+sTaKZ7+9JuIrKjP5TuNTsLBYZJo+BLykFi9SySKl2IggnpiXtfX/dw7WOX3svsH/nmYJUD1/NdPQ4alZVuqefEw6nye79zvjWplw+PcDIaAkl+RQuOeVVmAyYgMyVGnXO8BMuMph4O41advq++efRKElQm8LNQy90ADaFbDsQfKrAzuBigM7+683T0AD2D90sZEYlLUU6qBuahgNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1h2bTIlDVA5eUc+B8YwO9nUxz2ompCDE5qER87lyeg=;
 b=V25qE8MpfYLTnfcQpNf3rrBE7Ll/Rt6MgkkGYp1yqcI9CrPMJilEfjeyxsge9xwN0rgRQvZBb58vrpKQb8tiVggo9eLWuInXw3M2Ite6P3AQpCZ5z/wjnBcRpreqUBFsq2PMC/fbkWYUXmSOF5T08sHZ+sylEf29ai4/GvlDlU4=
Received: from CY8PR12CA0034.namprd12.prod.outlook.com (2603:10b6:930:49::22)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:28:57 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::a) by CY8PR12CA0034.outlook.office365.com
 (2603:10b6:930:49::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:54 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:53 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 08/15] cxl: indicate probe deferral
Date: Mon, 15 Jul 2024 18:28:28 +0100
Message-ID: <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a4338f-ea7e-4089-d32d-08dca4f39b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDKE2x7QzmGz6gCFCyWzZjPishiAfOe/wkoV6Vi4hjanhZGgnDgwx5x0tMeW?=
 =?us-ascii?Q?93JcnvgXgnujVieGic7mNz+zZpACeu4xzN5mKSNmC7LrF0QyUDq1pPQOHs5w?=
 =?us-ascii?Q?43cXABYTz9+fLwINKbhU0cHxXWenwx+kbnQGhTrX4SoYdyE+VP3YlzuD+iZO?=
 =?us-ascii?Q?ZV2IbzM6939pRBSoufa0q6kHICXaMmjHVq1VoTZxd0+ewYvxHf/bawaSWnwO?=
 =?us-ascii?Q?D473SQ4Z65OgH6phIBNGQyaT94ocqcwc1Mm7Rw9lomD/CSj6ltLauEWLv7qq?=
 =?us-ascii?Q?YeyY3A5F9wn3pZ7Mhl9TzGKNNPiBXgx4iQHbUGp6Z/annrCUW4i6tVc2MiKQ?=
 =?us-ascii?Q?WcUOliY2+mO76IJQ1sBcJGUqkkQRXS39ndJU8ZzZhTb3HeT11ZGy5IVbUzzB?=
 =?us-ascii?Q?Gs26b64VBSeWse1+rHMpGjTuV+dVJTbWM82aui6DfXILyB8fz6I+4HvBNjfk?=
 =?us-ascii?Q?K7bFeI/6ZF0t939OsbbZk3q84YiDF9d2poB6dNExGvyhAEnEYJajBYtEpJPK?=
 =?us-ascii?Q?ofUAtvUyvGU4gsd8LV0pl6OX5YWqNNlNZ5g6ecBkD3clUKYkES+uyoKCg3N4?=
 =?us-ascii?Q?NU4A6jUE6z2LsIsF34QIya7RK2kScg/3uDR25xmLlcdXuVAYhXT3PW1uTDdq?=
 =?us-ascii?Q?fOmaIZFfrGdHYNpbPiT1Lt3kL/PTqhVMOyXX8zWZqczXdYJXBcua9m/Y68K6?=
 =?us-ascii?Q?gNbaZVObCPfEoxjQSyfuswEJZmnFh5MvKf/rn+mesNWKikNgjfkZdgudMbXC?=
 =?us-ascii?Q?MhJIvCx3q3tx5iZIfgZw8AVlKUKJ6plQeslRVymHXIr2s9sliuA2TDrjXcWu?=
 =?us-ascii?Q?HmmtFABhEAdDsLszMvWYQK3T7ovQHQGdCgORAugO2MMtJf++eG47j7S4A9xx?=
 =?us-ascii?Q?KUUPLDyhu8/DGEDT6ajSPKHMeS3srW5tS5yiPL+FMOD/8bS/0ZRDU33rnNLs?=
 =?us-ascii?Q?RVzc/GcW6z+PsIzOYvKvGRNa2aRH4QoPpNxM6nFf7Yo/8SgO1L5fegWbIV2A?=
 =?us-ascii?Q?szAcIW7eFFppwM7pjTz9nGpeTb/qn149MC9rbLXPXPJXGyN1aZQy00mQlc+H?=
 =?us-ascii?Q?yCBt+I4MIXeFLSq+a5lZJ+N1d5R1aQibLMZ5a5Vn9KRRWD2WLxFcMaO3WWFR?=
 =?us-ascii?Q?WAtLkPciQ8SjwCdH7/Ti7RU1RNM3ZSSlipMqm76pbUTvVYFQ+uGuJek/E+YW?=
 =?us-ascii?Q?i+19jwjs03EqDNKJSFJ1sRT6TTXEOCkazgZxGRsfcro2xKT5TkhAQSJLCFlq?=
 =?us-ascii?Q?fuT18xKSGXOykhpAe1nleaXWA0TUcPRuiEnYMbbIaxXKRamLUtLbffBhlRje?=
 =?us-ascii?Q?KQtVX60ckyRJfye7TIAQ7IZ+FZm6hpI0rbfU7cSVVltkPrlttGc5hTAQnRyV?=
 =?us-ascii?Q?Hrd8LngWX5LZW/91wB6NRDpW7Xj7Ez8jOqZkM5ELdh7t++VdZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:56.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a4338f-ea7e-4089-d32d-08dca4f39b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471

From: Alejandro Lucero <alucerop@amd.com>

The first stop for a CXL accelerator driver that wants to establish new
CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
topology up to the root.

If the root driver has not attached yet the expectation is that the
driver waits until that link is established. The common cxl_pci_driver
has reason to keep the 'struct cxl_memdev' device attached to the bus
until the root driver attaches. An accelerator may want to instead defer
probing until CXL resources can be acquired.

Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
accelerator driver probing should be defferred vs failed. Provide that
indication via a new cxl_acquire_endpoint() API that can retrieve the
probe status of the memdev.

The first consumer of this API is a test driver that excercises the CXL
Type-2 flow.

Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c          | 41 ++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c            |  2 +-
 drivers/cxl/mem.c                  |  7 +++--
 drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
 include/linux/cxl_accel_mem.h      |  3 +++
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b902948b121f..d51c8bfb32e3 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 
+/*
+ * Try to get a locked reference on a memdev's CXL port topology
+ * connection. Be careful to observe when cxl_mem_probe() has deposited
+ * a probe deferral awaiting the arrival of the CXL root driver
+*/
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+	int rc = -ENXIO;
+
+	device_lock(&cxlmd->dev);
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		goto err;
+
+	if (IS_ERR(endpoint)) {
+		rc = PTR_ERR(endpoint);
+		goto err;
+	}
+
+	device_lock(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		goto err_endpoint;
+
+	return endpoint;
+
+err_endpoint:
+	device_unlock(&endpoint->dev);
+err:
+	device_unlock(&cxlmd->dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
+
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+{
+	device_unlock(&endpoint->dev);
+	device_unlock(&cxlmd->dev);
+}
+EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
+
 static void sanitize_teardown_notifier(void *data)
 {
 	struct cxl_memdev_state *mds = data;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d66c6349ed2d..3c6b896c5f65 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	parent_port = find_cxl_port(dparent, &parent_dport);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index f76af75a87b7..383a6f4829d3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 
 	rc = devm_cxl_enumerate_ports(cxlmd);
-	if (rc)
+	if (rc) {
+		cxlmd->endpoint = ERR_PTR(rc);
 		return rc;
+	}
 
 	parent_port = cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
-		return -ENXIO;
+		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
+		return -EPROBE_DEFER;
 	}
 
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 0abe66490ef5..2cf4837ddfc1 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -65,8 +65,16 @@ void efx_cxl_init(struct efx_nic *efx)
 	}
 
 	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
-	if (IS_ERR(cxl->cxlmd))
+	if (IS_ERR(cxl->cxlmd)) {
 		pci_info(pci_dev, "CXL accel memdev creation failed");
+		return;
+	}
+
+	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
+	if (IS_ERR(cxl->endpoint))
+		pci_info(pci_dev, "CXL accel acquire endpoint failed");
+
+	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 }
 
 
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index 442ed9862292..701910021df8 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -29,4 +29,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
+
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 #endif
-- 
2.17.1


