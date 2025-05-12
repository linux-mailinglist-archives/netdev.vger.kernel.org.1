Return-Path: <netdev+bounces-189814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E3AB3D1E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22FE7A1230
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667D24EF6E;
	Mon, 12 May 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OLauYkHS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D61253B73;
	Mon, 12 May 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066276; cv=fail; b=Te7OQNss6boUkIWXZjrYEsCbDJGr6WdQr3VzEcKcO9tIOcP8lKHGbqzsKF+xwOJv6048YwMIj6/Rj5TaWPz3s98FGm+1ZM3i5xPqJEaCyi7oAZF4RX+yCrCoec8l3r1cGdJRsGMppYUTzLlgOR/w9IxYGb/vWSaPQhUf1IxinOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066276; c=relaxed/simple;
	bh=lHBkT/crbNbHVsNemNY7pBw+kRSaYPEKeg6HeFogTT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6RhCmCe5g5cdotbh733UNd1qTN4VqQYXXuoIPtLzjgmSoH53yaoUxf33kiUh1NVsz2lDOLmyECvXQk0R5bvzjnw9nMc5kbMaPf5tyQBVWRw0Jgao+//jf1GWDrhGcBYZjFXjvPep670zFRmOvDzeEb3eArUprwswcAitx55EFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OLauYkHS; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkpKuIL8hiEbUUcj+VpzClEXqwkhKrGLPZtih6g5APKxUliYOJAot+303THQ0T/ndyph7pW4sd6cEce+tc7MnjpDKOVDEczb2LCw/oK/Hk8attMWGqje8uuPEx+3alQesXzrrv3qGMRYhCkwhXy8txZbDJW/12MhrbO/QwikcGaGz21giyG58j4+ej/3ENeoPgZpPiquoF8VChpeZInx6ojc8xT783RqyvjVQwpIPao7FawaS9LwWyA/VKQV4VnjBCSqaT60hO6x+JupXvrh17IwJr51aKK5oa0CgVGLlbQbNJKPJObm5x1Ep9lb9DJk6q5980jpehyD7CQ8uK0aRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIeUIE6KuG2piGqgXa3vWk+/10DniFzDKjzwvwkw+I4=;
 b=mjtBLmIY1F9vI9PgD9PGIbElFMpn1SEdKuB7mtzvtFoDQ/2F9LO26m16gkxLKRrdyFwGZaOnNeWNgU60JfAyfgL8r1vemSOxJar1maAoBXf8L9gvzAMa5EktspWJn0M6OtDXBXFiHbFqYRYQ27KZV3/T/yCFMe+mOfUYYayaSFAp2pBNoKwX3pujAlyBDleplK27bKQKBPVdcvGoFbvPrnvsU2PisKSR+mAHmi75dKicYzVMUBGosSkiD8bfrP2wLjQZUcNtJgEvzvzs9+KinDrCv2h77gVW7HJnTR886lShd9wln5NeUJLwZtl8HJVpnssH9Ok0Xi3YnATFqwtUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIeUIE6KuG2piGqgXa3vWk+/10DniFzDKjzwvwkw+I4=;
 b=OLauYkHSMngDhtYuIxFsxZXVHkGjv7ZfakeLrjDNsJT0wQd2IgaRgGdVg1JCzbsMrcDFQPyhPBn2j/H1sTLngNyE2+kXpAfIaYYBqBhb5bFPvWDxl1UQKANs2Rof6ber8PdqYwFikboXrbhX/wQZtqTdNFS4rxsNOqFJRwBR+PQ=
Received: from SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 16:11:10 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::93) by SA0PR11CA0076.outlook.office365.com
 (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 12 May 2025 16:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:10 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:09 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 04/22] cxl: Move register/capability check to driver
Date: Mon, 12 May 2025 17:10:37 +0100
Message-ID: <20250512161055.4100442-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: d0338a4b-eced-4941-0fc6-08dd916f9c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0BsAPQ1Vf8NsIgUE8qxiIYELggTNYNZWUP9iL6g+kvVOEQQjdLnUbiCQxabj?=
 =?us-ascii?Q?75y9zi0TMyEefVr1NH2/s53L/7ve2HNYyw7uhc1mgZM0zr5Mv504cga8D+zQ?=
 =?us-ascii?Q?6XwquIn7V7UbLjL+BiKcQlXTORLMpQ/f7259OCcyXXQfIXJFLVtu23kWJilE?=
 =?us-ascii?Q?H4BQxIC9Y7L01XQBtn84G43a7KigMwQgBHfmWh2rmVc99rhmmXmwZLc8e+Oo?=
 =?us-ascii?Q?BxjCjfkcriqj+7+jBLK57APQ2eXjaFmIuH0378ie27fn8MWc19mAS5+5+HSI?=
 =?us-ascii?Q?eYnWHZwmBrbRO6qWRZIoWpunRaVryHqaYvuYck2kkA6iVwKI69MjZ9vr2Apo?=
 =?us-ascii?Q?qS96EGJ5FmyyLb7LsttdjJjTorTf82FrlZQOgaJFUCv+kbn9WW95qqnZJRRO?=
 =?us-ascii?Q?NtA1i7sk4MysSnYtyZkibT++Fk8j66NK1/51Jd9f7Ae1qri7xKnU37AqLmvD?=
 =?us-ascii?Q?+lKbTCGXinKRjGKO77/ky6a3KL215QORWSQswpt3/tgSFIg9Nxt9crw+l75R?=
 =?us-ascii?Q?zM4cOZk/CFNjmkyHVs1wb/y2OTM/cI6WHYsf4a0fY4oTlS3Du1aWmV90foVN?=
 =?us-ascii?Q?q4fP1+NzwcY9N7sNch9aDsTPTkXCXs523Yzd7hvvTYRmhCMxbdTFziLNajHu?=
 =?us-ascii?Q?NoNFcT+pj0ShU5tCohYMYJzQEK0TI84K/ziO1IMS0qVw9uVCxJkrMVIjKvly?=
 =?us-ascii?Q?C1R0yRDbEv3+SX8pRGxAqz8fUyngOKNoqFmvfT2mb4BwW2CvfSfVzRwp5dKo?=
 =?us-ascii?Q?t5N7sYmHTHG3Bu4pqwpVsKfu2iCUKSaeQkXUYbbHX/vv4XKsO0W9QmAeN9Mg?=
 =?us-ascii?Q?p4CFzZUQie9dtuXXDbxBBt4tlSXCilpInKQXx+Q7f+WfKR2TJyss8QSagdgR?=
 =?us-ascii?Q?/oJN3feq4ldWBnrKMZrbobQkfiThW+tK07zSd+3MRoups1ZECkRItK3KuFx4?=
 =?us-ascii?Q?ono5Var+H6AIvk36ULHknl2wc6l95K/Wz8sE8lihHrKBFZLZ0MPUKzmaPF2r?=
 =?us-ascii?Q?OcZhd8zy23WZxRIaqoJj1e/ft2JcyE6WUh+jVmB9OV8qq1z1rx1QXIlrWvA1?=
 =?us-ascii?Q?ZRg2nWcYSLCdxQuOt0y/CxhRQqyYuEqRUOcj1pFHlBz292xmVdCzRB6MZsOJ?=
 =?us-ascii?Q?D/4o/loim+OhSWvWkWf0sGJ53xMJJhrseqezNYfw10Vsi5s1c1kfBq/BKlXS?=
 =?us-ascii?Q?AN3tD2/Ykys1ng+cDMZb7Sgzzll0Sc+euQeqZXZLRIu/Pi1vVQNpjCYsFcQC?=
 =?us-ascii?Q?FNVZ7+qSp9In/qKt3cpKP79MgUQ04VZNRPz/F6Xt9wjwYOK4hZqvoerQZWBK?=
 =?us-ascii?Q?7xJShYCAclhjGp4gVuBo55lCx1r4YG2mdTQO1ihFXJHrTrUEltuGGSMXJbjm?=
 =?us-ascii?Q?Y33orRyiEDnJqeIYYS65BfCh6a5TedcMPgnNJCpelDg3xg5+K8ZXnDh5Ncsq?=
 =?us-ascii?Q?z96x0Ujw/g1w00uj4f9RHuDjsjipHDKpey+lEKcOJvrHH1hWAHaS769i/8tn?=
 =?us-ascii?Q?V3O61vsMno8uS36t7N2DzVrKj+3ydDn5TJ1/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:10.8626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0338a4b-eced-4941-0fc6-08dd916f9c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

From: Alejandro Lucero <alucerop@amd.com>

Type3 has some mandatory capabilities which are optional for Type2.

In order to support same register/capability discovery code for both
types, avoid any assumption about what capabilities should be there, and
export the capabilities found for the caller doing the capabilities
check based on the expected ones.

Add a function for facilitating the report of capabilities missing the
expected ones.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c  | 41 +++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/port.c |  8 ++++----
 drivers/cxl/core/regs.c | 38 ++++++++++++++++++++++----------------
 drivers/cxl/cxl.h       |  6 +++---
 drivers/cxl/cxlpci.h    |  2 +-
 drivers/cxl/pci.c       | 24 +++++++++++++++++++++---
 include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
 7 files changed, 114 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d27daec2ef64..703d35d4b4b9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1075,7 +1075,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map)
+		       struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -1105,7 +1105,7 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		return rc;
 	}
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
@@ -1232,3 +1232,40 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 
 	return 0;
 }
+
+/**
+ * cxl_check_caps - check expected caps are included in the found caps.
+ *
+ * @pdev: device checking the caps
+ * @expected: capabilities expected by the driver
+ * @found: capabilities found
+ *
+ * Returns 0 if check is positive, -1 otherwise.
+ */
+int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
+		   unsigned long *found)
+{
+	static const char * const cap_name[CXL_MAX_CAPS] = {
+		[CXL_DEV_CAP_RAS]		= "CXL_DEV_CAP_RAS",
+		[CXL_DEV_CAP_HDM]		= "CXL_DEV_CAP_HDM",
+		[CXL_DEV_CAP_DEV_STATUS]	= "CXL_DEV_CAP_DEV_STATUS",
+		[CXL_DEV_CAP_MAILBOX_PRIMARY]	= "CXL_DEV_CAP_MAILBOX_PRIMARY",
+		[CXL_DEV_CAP_MEMDEV]		= "CXL_DEV_CAP_MEMDEV"
+	};
+	DECLARE_BITMAP(missing, CXL_MAX_CAPS);
+
+	if (bitmap_subset(expected, found, CXL_MAX_CAPS))
+		/* all good */
+		return 0;
+
+	bitmap_andnot(missing, expected, found, CXL_MAX_CAPS);
+
+	for (int i = 0; i < CXL_MAX_CAPS; i++) {
+		if (test_bit(i, missing))
+			dev_err(&pdev->dev, "%s capability not found\n",
+				cap_name[i]);
+	}
+
+	return -1;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_check_caps, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..e3b384cebe8d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -757,7 +757,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 }
 
 static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
-			       resource_size_t component_reg_phys)
+			       resource_size_t component_reg_phys, unsigned long *caps)
 {
 	*map = (struct cxl_register_map) {
 		.host = host,
@@ -771,7 +771,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
 	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_port_setup_regs(struct cxl_port *port,
@@ -780,7 +780,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 	if (dev_is_platform(port->uport_dev))
 		return 0;
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
-				   component_reg_phys);
+				   component_reg_phys, NULL);
 }
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
@@ -797,7 +797,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	 * NULL.
 	 */
 	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
-				 component_reg_phys);
+				 component_reg_phys, NULL);
 	dport->reg_map.host = host;
 	return rc;
 }
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index fdb99d05a66c..2ba997106434 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
@@ -11,6 +12,12 @@
 
 #include "core.h"
 
+static void cxl_cap_set_bit(int bit, unsigned long *caps)
+{
+	if (caps)
+		set_bit(bit, caps);
+}
+
 /**
  * DOC: cxl registers
  *
@@ -30,6 +37,7 @@
  * @dev: Host device of the @base mapping
  * @base: Mapping containing the HDM Decoder Capability Header
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * See CXL 2.0 8.2.4 Component Register Layout and Definition
  * See CXL 2.0 8.2.5.5 CXL Device Register Interface
@@ -37,7 +45,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -85,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			cxl_cap_set_bit(CXL_DEV_CAP_HDM, caps);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -92,6 +102,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			cxl_cap_set_bit(CXL_DEV_CAP_RAS, caps);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -114,11 +125,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
  * @dev: Host device of the @base mapping
  * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * Probe for device register information and return it in map object.
  */
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
+			   struct cxl_device_reg_map *map, unsigned long *caps)
 {
 	int cap, cap_count;
 	u64 cap_array;
@@ -147,10 +159,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
 			rmap = &map->status;
+			cxl_cap_set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			cxl_cap_set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -158,6 +172,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			cxl_cap_set_bit(CXL_DEV_CAP_MEMDEV, caps);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -434,7 +449,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -444,21 +459,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(host, base, comp_map);
+		cxl_probe_component_regs(host, base, comp_map, caps);
 		dev_dbg(host, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(host, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
+		cxl_probe_device_regs(host, base, dev_map, caps);
 		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
@@ -468,7 +474,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -476,7 +482,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 19bdbf5278ee..790f7dcb9500 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -202,9 +202,9 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
+			      struct cxl_component_reg_map *map, unsigned long *caps);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map);
+			   struct cxl_device_reg_map *map, unsigned long *caps);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -219,7 +219,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0611d96d76da..e003495295a0 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -115,5 +115,5 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
+		       struct cxl_register_map *map, unsigned long *caps);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 57f125e39051..694bdfc5b7ea 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
 	struct cxl_dpa_info range_info = { 0 };
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
+	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -871,7 +873,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->rcd = is_cxl_restricted(pdev);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	/*
+	 * These are the mandatory capabilities for a Type3 device.
+	 * Only checking capabilities used by current Linux drivers.
+	 */
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_DEV_STATUS, expected);
+	set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, expected);
+	set_bit(CXL_DEV_CAP_MEMDEV, expected);
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, found);
 	if (rc)
 		return rc;
 
@@ -883,8 +894,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxlds->reg_map,
+				found);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
@@ -895,6 +906,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (cxl_check_caps(pdev, expected, found))
+		return -ENXIO;
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index a3948505107b..d22a80e75cb9 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -25,6 +25,26 @@ enum cxl_devtype {
 
 struct device;
 
+/*
+ * Capabilities as defined for:
+ *
+ *	Component Registers (Table 8-22 CXL 3.2 specification)
+ *	Device Registers (8.2.8.2.1 CXL 3.2 specification)
+ *
+ * and currently being used for kernel CXL support.
+ */
+
+enum cxl_dev_cap {
+	/* capabilities from Component Registers */
+	CXL_DEV_CAP_RAS,
+	CXL_DEV_CAP_HDM,
+	/* capabilities from Device Registers */
+	CXL_DEV_CAP_DEV_STATUS,
+	CXL_DEV_CAP_MAILBOX_PRIMARY,
+	CXL_DEV_CAP_MEMDEV,
+	CXL_MAX_CAPS
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
@@ -223,4 +243,8 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+struct pci_dev;
+int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
+		   unsigned long *found);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


