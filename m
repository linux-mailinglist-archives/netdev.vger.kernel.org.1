Return-Path: <netdev+bounces-243781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 757FBCA7776
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4972304DEA0
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F332E744;
	Fri,  5 Dec 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E06qH2IA"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58F2192EE;
	Fri,  5 Dec 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935591; cv=fail; b=bHi/8UU8tx5hDsVo3TOR+cgwN3q2oWmJwQR6WcjYYqPjZEA1nxYYlymB3p1du79AkTG8PLJ204wEWn7yNgxc2s9JUMXZhknmrKBnAJ6ljvlf/zmdqvoNlirnNOvZl2KuaJ/BmczE+3plOud7Im1WzicCAWa4abmzNIM6uon4MZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935591; c=relaxed/simple;
	bh=7LzhQqFTiFwFxGPSqsV3KltMR1Jqi1Rwo26fuUiL0BU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvMiEp1wxQt2oXEV7E+WpvEV/jVwY+yPu6iUaAoqObO3PztVk8o9qZjarmGmPXb8SUaR24/zdjWJIwpjBYYuM68MFhbIXWrHVAJqpv9lWFIJk123kSDtA8S323gNvhNHL0Kw+2GVIFQMv8CBnhsSehKP7msqO6/iDuEYdqvZIIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E06qH2IA; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU4+osPRBUf7Pal54ImqINYdWMuYuZr/AHwqZrzC/o0/ygOLm8tstYvoqh50Yv2SkiMyJq70F/TLs6TH5IVvmbX/AyJOelMm2jdpDmm0GD67qBktD8JO0e4cd1VwaJIphFfPj+Z4AlSv62ps/SoC0mKK53EqEuoGEXT/j+ptFXNX4KzJZCndrGXdRHsxsuxcLs1PMvcsYq/OoP8e9Jkod7/iSFUVX54gHFcmlJ8DTPg6KX/YzgF5tf7tSF34hUpsH7yeXA0Zdb+0OEcPW22Q5VSvYne2OQePmwXyqs8PfonKVD9fL+jjVcei4JnfjPkj8gUK6EUzbnfZTjl6vVZv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hunpXleg1IeGNXu4JeCfsFi4gkB7uWs0TGnwdsSqe1M=;
 b=BteiaxRVyseeCFwwqpAgzv2sON2CUjvDWMPgVGLeB6tanQinFGxT7mSUiVxLpgdz8RgbJtpM8To7lcXEhPQXJexA0a03PNrKVqzdNCdHAS8T2WDzb+Vhu7OaFN1LElZ3uZ/9w663K9zPCw57uUGQ+kWB+88KmCjdmpXN4evb/mXOBhOAFqyuGUcNWhx4+nEKIMXX9oc+Cz25XZ2nehKWp6vuuTN+qeVM9PchXc2n10Nt36VVe0JC/GL50d0hRcXl8maCycLE0l5Fmdkxc5BhD/YDzT4UWKhHfUKiCgDzfZZUNivvPNPZJ9zQhPHGBsCQv7LwkgFd//EtHMgNIA9V3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hunpXleg1IeGNXu4JeCfsFi4gkB7uWs0TGnwdsSqe1M=;
 b=E06qH2IAuU3jetjJ9bqS4Ez4hdfUJb3VUQec2IQdcEb/XA7OsN93sKZwLvj7/znrXKR/YMZab8QnnjR6KdI+ElWcOrbzrOtSmzfucxkMX8PdTAyjoo/8Oelxte67qOJYdb9gTgMGvHeJxQWSqjfhp1Dka3wKHVOCyOL2hfo2N2I=
Received: from SN1PR12CA0058.namprd12.prod.outlook.com (2603:10b6:802:20::29)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 11:53:01 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::cf) by SN1PR12CA0058.outlook.office365.com
 (2603:10b6:802:20::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:00 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:52:59 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: [PATCH v22 02/25] cxl/port: Arrange for always synchronous endpoint attach
Date: Fri, 5 Dec 2025 11:52:25 +0000
Message-ID: <20251205115248.772945-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: a0823ecb-e086-4aaa-e7a5-08de33f4d72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uloq8KoB+/K5Y1fUVEAgPjwozpa+wJeCTOenyJqxT31NDGdCRhqNpKdEKK33?=
 =?us-ascii?Q?ZQ7fdK4niPsI5SqYG/lzGYR5mtAJt80H+nAVHWR3ocK2VHYEjWBHbnOWE7Ai?=
 =?us-ascii?Q?moDJbFUGaAJVUC9KH/9+iTzDs1Q4xAAubpd8dEJmTdSKDdQ2/z4VfVurQ7sQ?=
 =?us-ascii?Q?gbUSExf5/csZL5FS+cHLIA/KLPDr64hQNs9awViBUeqA9eICMe2FGWtBauxK?=
 =?us-ascii?Q?DbYrMOO/+OgMIkwnzgNLLh/B/PEgh5YpQkg8jcOQuvB+XRlDgMX2mbWq07ru?=
 =?us-ascii?Q?Auk4vFESHbfBbW9BsS2xTMAno1itQUkH21+gjqx9NUhnjn5K/Mg5TJQLOaVF?=
 =?us-ascii?Q?6yYRosD7yLKLO2Ql31xLz6mExU1586U6dejXN7HyXoUr2qcOk+qhyGewsU1J?=
 =?us-ascii?Q?HR4KdJqMm118VoHU3JIJliOAj5N+ESqmurlbe973F+NE+rBGvpdONgfJ9Rr7?=
 =?us-ascii?Q?rF24tWGpQOZdaen+sQxI+8EBANzi1zHEg/7nCPziOcCov5CEL2Zg3yD6IahX?=
 =?us-ascii?Q?xMi2htLuywFDUBs3hNxc9SCxj346Mc8fzDhhWeYlneKyvw+zBVp537rEBCyq?=
 =?us-ascii?Q?TsaQAt2tBVizbmeZMIvw2iNLL16O4cxKIT0HjOWt4YDUr0w/90niiVOAHkC1?=
 =?us-ascii?Q?rquK1QDpH0dRpCLTiQ3IH7L9YO4aCPAg+JEKMAOf1wgg2xw8T7JNu19oBA0r?=
 =?us-ascii?Q?DQp9PvJJ7i2lkyuetp2KHecY2IiD/HkhVex71t+RTCbURmTE6xQQVssKOoId?=
 =?us-ascii?Q?3XP/Vvw4kUCZSUurFvuAFdwF744iClOnDkXz5l4a7tzBcmKhBf90n0WPVREj?=
 =?us-ascii?Q?zn43rbg20IU6sDYoa/wSIvNDbHmSQf2qySO3ZASmEdxZmJtIZ9oW9oIbqYXl?=
 =?us-ascii?Q?WYoWgLLsngUMgRboeD7BhmuN1CXsT3KGQEOdZdQSdCcLHMuAZYcUmqaqiW5E?=
 =?us-ascii?Q?rQe3MV9uaSFxz17DORYKfSJNgHJp1dfeLPmDwri/1GrxGcboA4/WEY8wIIZY?=
 =?us-ascii?Q?pNQ98xYOoPbdlNTUrJa1x7dHnj6Zz594f4SpsIzp0qb8NwCC6wsu1JWjrkOZ?=
 =?us-ascii?Q?Ry2wg9LpnUKhw79kUoMkXSNTk+Om92/qxyUPspehss02qFQbtwnAeWNqgzPp?=
 =?us-ascii?Q?tEnuI9zRKybtZKCvKuJuewEG3IrGSQ7g0xeda2pEIw/IOM5rdKRqoymq8deV?=
 =?us-ascii?Q?Tas6liKeJXq/VuCF4y+GySJqW2l/0cm9K7NZwDKQAsagXjduQWNL+MASWzjY?=
 =?us-ascii?Q?QyjYmczA4VZxo7HAe7f4MjKmKle0AIOjGOmPgj+QB4JULRiv/HMmue/39Cne?=
 =?us-ascii?Q?/jAMSY/OunWAQy/yIe46sxux1OuCUZPSho8LspbNsDcZ8Woc4BnsvZgIcEah?=
 =?us-ascii?Q?yGjArGOhUXYXJMpebxOuy43iGVLLV1x6B7IZrEn7MaC3gLRxs0Dh6croEzVt?=
 =?us-ascii?Q?cainODpfT1UoZVStrOtNezWN1r+3UzXt4Ik51NJVPMmvHI4H+Wi4FbKc7ldm?=
 =?us-ascii?Q?/KGoWuO1a5K58a89JFGzKhCdWuRsMAGjR3BDdmRk1N7hj8MAyIy2llW+3KTQ?=
 =?us-ascii?Q?ycoSkj8ATW7AmFN+hs4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:00.7489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0823ecb-e086-4aaa-e7a5-08de33f4d72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982

From: Dan Williams <dan.j.williams@intel.com>

Make it so that upon return from devm_cxl_add_endpoint() that cxl_mem_probe() can
assume that the endpoint has had a chance to complete cxl_port_probe().
I.e. cxl_port module loading has completed prior to device registration.

MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
dependency is reliable.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c     | 43 -------------------------------------------
 drivers/cxl/port.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/private.h |  8 ++++++--
 3 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ac354fee704c..8569c01bf3c2 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -46,44 +46,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-				 struct cxl_dport *parent_dport)
-{
-	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_port *endpoint, *iter, *down;
-	int rc;
-
-	/*
-	 * Now that the path to the root is established record all the
-	 * intervening ports in the chain.
-	 */
-	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
-	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
-		struct cxl_ep *ep;
-
-		ep = cxl_ep_load(iter, cxlmd);
-		ep->next = down;
-	}
-
-	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
-				     parent_dport);
-	if (IS_ERR(endpoint))
-		return PTR_ERR(endpoint);
-
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
-	if (rc)
-		return rc;
-
-	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
-			dev_name(&endpoint->dev));
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -289,8 +251,3 @@ MODULE_DESCRIPTION("CXL: Memory Expansion");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
-/*
- * create_endpoint() wants to validate port driver attach immediately after
- * endpoint registration.
- */
-MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 51c8f2f84717..ef65d983e1c8 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 
 /**
  * DOC: cxl port
@@ -156,10 +157,50 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_port_attribute_groups,
 	},
 };
 
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+				 struct cxl_dport *parent_dport)
+{
+	struct cxl_port *parent_port = parent_dport->port;
+	struct cxl_port *endpoint, *iter, *down;
+	int rc;
+
+	/*
+	 * Now that the path to the root is established record all the
+	 * intervening ports in the chain.
+	 */
+	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
+	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_ep *ep;
+
+		ep = cxl_ep_load(iter, cxlmd);
+		ep->next = down;
+	}
+
+	/* Note: endpoint port component registers are derived from @cxlds */
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+				     parent_dport);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	if (rc)
+		return rc;
+
+	if (!endpoint->dev.driver) {
+		dev_err(&cxlmd->dev, "%s failed probe\n",
+			dev_name(&endpoint->dev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_endpoint, "CXL");
+
 static int __init cxl_port_init(void)
 {
 	return cxl_driver_register(&cxl_port_driver);
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index eff425822af3..93ff0101dd4b 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2025 Intel Corporation. */
 
-/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
-
+/*
+ * Private interfaces betwen common drivers ("cxl_mem", "cxl_port") and
+ * the cxl_core.
+ */
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
 struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
 struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
 						struct cxl_memdev *cxlmd);
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport);
 #endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1


