Return-Path: <netdev+bounces-224323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FEB83BE0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB71C21E9B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9393019CE;
	Thu, 18 Sep 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FvLORkyW"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3F301038;
	Thu, 18 Sep 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187113; cv=fail; b=jEAo6zQzJHGz+BFyRPbZUIABKKh3zrc1JBdcD+OhEBt8cocOxEarcXAB0UrL/c6fv+fTU40BMhP1ASZFJ5LniInH7R+SuHQZWjEmWGhJjH1pHOmlKzZQQ1CKSzeILZaO9Is+7MYPVkAJOTJVd2tmpjDsF2tIvieTDqwPAdZ9iD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187113; c=relaxed/simple;
	bh=mltZlLQpR/YiRHG4ZgSfUuBnI3KtsFsa6KRVG2L6cMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2sIXQNXfAdf5MqtjwUQBfo9Zcdv/9xo9caRMS+yKLyv8bp4j5q0GSc5M4/HZL9KU/nMPKvAyDqVc4AP6Pv+wJkzRmrumqp7aznl3wL+qwKT+wo00vx9IPY3lPNfTAyvtNRGilgLQQRsN+cUnY0edrZqgRqC9/okEnxo+sbbcRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FvLORkyW; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXgAuEk/ML1HV9aj5inGHuo7t4InwvpjR1JACv0M4098duSRHyK+pNJwQW5m4bSJR6DfD0JZJWfbf+UxYu8YTJyoZSqecAJgCwJcyYK4lxtmXlArn+VC+UjaNq5Pm6a/CKhv3NcdVXKIH68VJGbbUcYrsTLx0m7lMYfTlb2W0Cd/3SWX+XyRNu45P1N3hhA0tB4thB4L2ECSGBJOD9gHsbHBCYSKajdX8UvZBlJc994JLYNBrLcjOBWCEBMKHkMBqhneDE4AijKu78hJ4l9FAfvidOaerH4C1NEhqMxfeU0z93YwVgy5Ov1DulySwIe5+OnPH3QyHCbcfnglOO0y+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK1v38CDnWtvXOW9gDxsQre6u6UqlLr2JvkIqUJooHU=;
 b=hBsGw1QxgvG5f6vomoz9HCcEBlZ2FWj6wKHML2+qZ/ZKT5EnW+c+u8clB2Oz7srS8MZWef0FVKTiGqjD2ImKUgXQRXgjwGwpcJKr71YV1XYXpigcWyMEnwL+LEEIqMvopDWCgbh3rxAwvVpc/3yvCiNlKDqAk1Ng1VtS6JzGL1QyCYgYLM0b8og8+S4NpVBgjXmxlJqGQfVI+H1/qQyrgsyZVIIA0/GyzSxmY25Hj5+3AQqsXilsu4gaa7Ras5brxxoBp7zb057ypqhFXQ3V/r1x/G91PPcH24ZSwauXsPGCGf2J2xxN/Tp5Rl1PBJdvRbHY1RwbsTWb5axX4ZOPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK1v38CDnWtvXOW9gDxsQre6u6UqlLr2JvkIqUJooHU=;
 b=FvLORkyWXWdJGeadISooen2WEhrW3yBLqKOhtbt6s89PtRMoCYLFed1xaIRoQdVgM5diIRowg3+8XRyU2rn9Py/dFeGxgiw5SHuNmMFzU/eGQ7MbVSKddYBbcAT6Shh3iG34/QCSabA8qBjpd5XUp+EkB4lrg6udaY2rtsgolCU=
Received: from SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::27)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:26 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::64) by SN7P222CA0018.outlook.office365.com
 (2603:10b6:806:124::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:06 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:05 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:04 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v18 03/20] cxl: Move pci generic code
Date: Thu, 18 Sep 2025 10:17:29 +0100
Message-ID: <20250918091746.2034285-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ce6f65-0bbe-48ff-00e1-08ddf6945336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0E6tUOOWQ+t5Ag+ivT6PqbOBo/1/0WiKZumWZd0pmEppG/gtz8gstpfXu4N+?=
 =?us-ascii?Q?dXP97+TRi9UE/aIAFbKuA4EIE0ETdUUULiqwsIzNZ3RUnqxVJKOh99ix78qM?=
 =?us-ascii?Q?2WXFr9M89Modj3MFzrLQ3M+CEJ3H6ZmuRVQodlCgFNDG7PB81zRnnAhP1Gnb?=
 =?us-ascii?Q?197Jg4v04NvA2AF3JvuWbdAcde7x8V8LLwLbY3venIVm03VHyGYldBgnxmq7?=
 =?us-ascii?Q?F5KZ6zTSiMThCdl6iV5ygbHf4RICmNTxXOq3sNErpIFI6iqgYbKuhxFbC3lz?=
 =?us-ascii?Q?ZzJP11QGRiJJWwaIYPEal2DyqfOUSY46VhU6Kcz1Yv4l1G94lN/lspPV2YJx?=
 =?us-ascii?Q?4nSWeGYhoD4IojpIGuGtoduzBKaELunuGKQZ2kN6cAcYXh5T0zLzBgMIxlpw?=
 =?us-ascii?Q?ZSEsCNQD22sbJ1XEhZWZlYtb5epGtx3X7IWKrMFFCLAYXBk0yOZpBe2t7XU7?=
 =?us-ascii?Q?N3dYSF+WihDWq2JW9X+sZZt+9AmTKzyevAhHHoxhQwmSkwZ1Y5Jc7RwDAZMJ?=
 =?us-ascii?Q?SzzHfxjZeX/tLriPN7KNHN0jcn6kV5qjY/Y0NqJv6mZ73VXnzbPAsPlIfcob?=
 =?us-ascii?Q?pJ6MO8CS/gZ4Ce7119tV1nOy3LaKumyQzX8GU4lTY/MaUlzqK37NTm4tY2Ic?=
 =?us-ascii?Q?EVFkt7SpuYxjxfteNJM2fWcN2dwVzJ6/4HtE3k/rjCs5FOncN7NGmGYoqz0F?=
 =?us-ascii?Q?hQJGXKln7IL8wBRY4OL7uT/8q9rmSf5c8s7kR3ajBkA3JY4zN3uFDNrcjbm1?=
 =?us-ascii?Q?zUrZK4loaK2x9+FEXGw+TiuAM2cLVEJ67qVg/a2YCHukC1GW0m3j8kgRKYyx?=
 =?us-ascii?Q?sofLHxhjSaQi0kkMm1NzPtml1kISCFs01laROMF0dGslBZCIxdX2to2M4Gzt?=
 =?us-ascii?Q?YnxM220Se01Sy29LRB/ybocpuRmSVw6LTfaBIaSNhDyxlKU3+gAIfvXQGdlt?=
 =?us-ascii?Q?r+uSPl5aMZ1QFw65AFYkSz9cM6fsKiLHoRxYx+bqOjAYbWWUJL34JDs6CXMb?=
 =?us-ascii?Q?8llEfsPfYNpNCDdXF9iHAYb6VxnxRCQQncQ2J4cUP8YAsmkTlBHV15At4fuz?=
 =?us-ascii?Q?HJ8IWsoet0XfCXpBkz9dVyeBAsPvxIqLKFsCs9roi5YwtDdQtGESJCxGhuLH?=
 =?us-ascii?Q?2luVJp8Vowqhx3YkRv8wuTQ/jL9Lvto5SJnACav0sIZ0pwBL/c1ACypjb9D5?=
 =?us-ascii?Q?4gm2oQ47oZN8P9oV6GMAxjw0tjjgKb9g03VFkizb61uZs3TbP4KVMlrSNsmC?=
 =?us-ascii?Q?Np2P3gqhXaoPOyWEsqmkp1XK19mlEzcd+3hhLFtghaiLZgVctuIchoNqv7qA?=
 =?us-ascii?Q?zmG6OhqNyzJHr7ZOSBki7Eiss+bJO9rDGdvqSBCb0CTLPzdGCqkyJeQVd5uC?=
 =?us-ascii?Q?uiQSAp7zwmYbboEEYDbUCCU2/Wf82RI81/zsrRDfF9DWqIGMVA6TpULYGW/M?=
 =?us-ascii?Q?zqFXpQ+FxpKummtuqkCWELyK/AFL1mu6VoJGIUYAtVhL2ZoSN+tnvKiU4hQz?=
 =?us-ascii?Q?sO5HPj05rAqOa7gXJrlHNVMbd1Wc78tRuX+m?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:26.7503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ce6f65-0bbe-48ff-00e1-08ddf6945336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Fix cxl mock tests affected by the code move, deleting a function which
indeed was not being used since commit 733b57f262b0("cxl/pci: Early
setup RCH dport component registers from RCRB").

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h       |  2 +
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c       |  1 -
 drivers/cxl/cxl.h             |  2 -
 drivers/cxl/cxlpci.h          | 13 +++++++
 drivers/cxl/pci.c             | 70 -----------------------------------
 include/cxl/pci.h             |  2 +
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 ---------
 9 files changed, 79 insertions(+), 91 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 385bfd38b778..d96213c02fd6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -207,4 +207,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d3e1ed46b42d..4e5688e7e972 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -728,6 +728,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
+{
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
+		return rc;
+	}
+
+	return cxl_setup_regs(map);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index dee572775913..dcf444f1fe48 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -642,4 +642,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index db8e74c55309..e197c36c7525 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -221,8 +221,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index ccf0ca36bc00..4b11757a46ab 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,9 +74,22 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCIEp with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 65d0d8fc7e99..d556e8be1155 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -468,76 +468,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map,
-				  struct cxl_dport *dport)
-{
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
-		struct cxl_dport *dport;
-		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
-		if (!port)
-			return -EPROBE_DEFER;
-
-		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
-		if (rc)
-			return rc;
-
-		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
-		if (rc)
-			return rc;
-
-	} else if (rc) {
-		return rc;
-	}
-
-	return cxl_setup_regs(map);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 5729a93b252a..d31e1363e1fd 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,8 @@
 #ifndef __CXL_CXL_PCI_H__
 #define __CXL_CXL_PCI_H__
 
+#include <linux/pci.h>
+
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 385301aeaeb3..629880c5b9ed 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
-ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 1989ae020df3..c471400116a1 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
-resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
-						  struct cxl_dport *dport)
-{
-	int index;
-	resource_size_t component_reg_phys;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(dev))
-		component_reg_phys = CXL_RESOURCE_NONE;
-	else
-		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
-	put_cxl_mock_ops(index);
-
-	return component_reg_phys;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
-
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;
-- 
2.34.1


