Return-Path: <netdev+bounces-190418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76CAB6C9C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170354A8041
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F1027A91E;
	Wed, 14 May 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XSTSoM2/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCA279904;
	Wed, 14 May 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229283; cv=fail; b=U2YhNWYY6cRsOiZRMfO81fE8si8CUetOcj/7uir2+kU99it7xUjo6w4Kbt95X6Vf1654tlFKFTGyf636bSjOF9eacivxk5vrmjMvMgYVUDudfGWomzsTyKwCaCIX0Y+0LYe1Hhkj9cWiz9DgNDPF9wS+JEndiv9DmMtPRahdtZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229283; c=relaxed/simple;
	bh=FuU7YeXkhQyClR/KEAxth7jbql/xAe9laEgkxcpkLm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcwRybcajkELBo9bWuPGtLQUpMuElm96pLiwLvr1KAcH6pwvYDuSQc6ImCW6jxi5guxFP/zlxLZT4OsXW/1EVghqFi/3+QLjpZ9hMIKBMW+KZabyuWSlUt4LmXYUjMu0wUzZ5BCqzmivL2gKk93WarEb8TfeJ7cEjD1LqSH93Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XSTSoM2/; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM6tQFCqeOSLYJftIjAkuIEPx8xB36VYsOh6wfFue+HVyq/uEtdD4YNQXR6BImVYjtIFr8cNQw+Gwzr2POGGIQu7ZlWXAa90bzWh8TOuIg0rtGu0UPyuJRn2L4PHyRUVjFEQzE1CLqEd3veIvUxdk/RJ5LSXWVWkNia4BParIROrdFG+tEobF7ept72TTioEyw8kl2Uf758Pc84+5AQ9d+1StZKlC4qbk/HGEN5V4b1frZ/Euh39lIv9aSj4qhy7zYcRRLHqHNMy24iJ5fiFMljKZLyQxpO5qdHYd16z64qUyqC65ArgEOK/1m6BNc+BruuRC2RMfaMLQ7mBuozjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld/Koiry/SfKac8V4f2HR7yztjtork+KpGnpokKk2gQ=;
 b=Bqm/Si3y5l+LFIoFHKSparLdt7dgOxjvAv+YozPewsIMF8g9ePbdC1/SHxwTZhVc5/5wkBb7ccZyfHjciBTm9RA+dY7+JGop56oNDUe5R6KfZkl4baI+OHE3C3c2OvrlT2qxeVEDr98IKQsxr0jNym+NkGz1SJ9mGEOksmz4Ght+qC9TfZe6PwfKNCGgmeScdrjZotJd2U416vppJdSxXlQwQmnlgosUFXg7XBwm7nk+BJNl5RV2P3UAbfLAtSdDUzUUyezFRo0Ul9uA6msE9oH/mJ4v9bAYDbKl8JakE+7Q7l8u1ruFS7IMcsNqLGT6BD6Ui+TZyDzxcp0hG8d6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld/Koiry/SfKac8V4f2HR7yztjtork+KpGnpokKk2gQ=;
 b=XSTSoM2/sQQR0rywJTvt8JrsPaXKjCBISXIvmPYYy7tHLIN5aXrjYT5mfymCZ4C4pbZWkF+DFkVPxIYqDeh4zDUMfh1j+flY6//7SJaR/Y49h7tafTj4x17WsOlPwn2WtC7ecsRRBV00U81HDbbjvsIiCrsJU32OQ15DmQK3ZQY=
Received: from MN2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:208:239::14)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:27:58 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::2d) by MN2PR08CA0009.outlook.office365.com
 (2603:10b6:208:239::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Wed,
 14 May 2025 13:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:27:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:27:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:27:57 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:27:55 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 03/22] cxl: Move pci generic code
Date: Wed, 14 May 2025 14:27:24 +0100
Message-ID: <20250514132743.523469-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 0738a6df-da08-4889-30be-08dd92eb2445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKTCmH8UfE7ZzEoL4Pcs6+/x4tseZ02vQJfrnIu5Aq+VwtaKXrzPlNNzdwKt?=
 =?us-ascii?Q?K4gq4sCRD9clieF+4+43F8NhRmPOmXaS+GluPie4AoPAFqSC5qqcpYJmrAdR?=
 =?us-ascii?Q?EaPk03jAHwIdbrIHgilUlnwsCojURtnHe1G90lyNTNJX5JJMqAFFWKvB5FJn?=
 =?us-ascii?Q?M9WhjxM5qieRWr/Z/Itqrm2wHKsPumT+ErBMLKu5c7tB20xG1nV94z5X9Z5n?=
 =?us-ascii?Q?CMvYUEc0W6PAXrLUT4Kqsot2afzQmD/sVCxzDHiqp5tz1v6Iwu7gICKIDRr+?=
 =?us-ascii?Q?nt2AXyTAhoqkwXypXENi8pj7jni+RjIEyTrrru2BCodbPaNO+RugV4hlQlJp?=
 =?us-ascii?Q?2AZSVxHp8qlQpR0HvvApOZNMJRK94rz9AD16zlgBMbUwmAvcV82TRiZlFWtr?=
 =?us-ascii?Q?hLzdh6FFluxRQRGHDuXib+hLEUMV9//ekMlostPSy4TNINgVQ6A7V6kUz5DU?=
 =?us-ascii?Q?LvTCOUEWKiJ4jBDq+8SuxWDL4AC/Ztlol6VhuVbGuWU+H5M+duvnSEQCpL5u?=
 =?us-ascii?Q?FJ4uEjeohECoe81ct2Cvm4bsVY973lXULWTmYO9fip14RUv6dOMtT1RhLBMU?=
 =?us-ascii?Q?gSR2tet6+z+/AFjJt+/8GN2D7RRuro9/jNkUaMYHikYL7MwkCsuymnSHsFhU?=
 =?us-ascii?Q?zz3ROWiFFigEn/S4pBJBunIWM9SxYGstel5XY8T5I29s3vaAO5ZXQYaMFDB8?=
 =?us-ascii?Q?JM8W40AtVFvu+RxPRMhrQWdPJTGsaw7xzjF0QOJ/AewgiW8wh9/CFp+eAV4i?=
 =?us-ascii?Q?ix75fH5gugVUkAriaC8xHxwqzrJ2xQvic3qtdZtXjfkI2s56MyN9FPeCglhU?=
 =?us-ascii?Q?Vn3svyXQq5U8M9p+3TMZ6ybtl39pEmKx3ZaAnN+5wsKLJR1x/dxn/JYsfqTt?=
 =?us-ascii?Q?4+PmDXVIltFxVRoslMRPjsTZjb15qOE3VDJv7e4N4/PF4TGyS3fHtIFEEhQ6?=
 =?us-ascii?Q?AOyDuCsdVUXXs8ikwWXLFpMSSf4o8GSVKCoV0QtlhndctXRyg3z1hD8/i0aZ?=
 =?us-ascii?Q?sVVTbIZl7x4NEbnzFoAHJu+hs2CLrKumx0WD8C1f7iqI/2/FiuBiFer8bN6Q?=
 =?us-ascii?Q?FKSjPAZutd6MD1Vm9mLf2FDXGdmqD2tZEeOXoSe9hCTl55Jm1GSDQvGKUZ2P?=
 =?us-ascii?Q?imnhY1fv+z8r8+7Sj4sV4XcxyhIgJeqQ2JM5+xFYqS6aCG4hWZf3MhVOXf1D?=
 =?us-ascii?Q?kMMgqrGOJcPF7Y7TbONNeefikGOPZksvmwlTRJA0g5nh3tYgFZG5OAj4RtcZ?=
 =?us-ascii?Q?koTSbvJ3mFAKLcD77RiDjsVFKRM13t7RW87pMxsM4ZDeSK+7HhS6vZJ9FyZ7?=
 =?us-ascii?Q?F8R23FhlzSpyKy3BKrw8xoBVHFmZc6nqydLwAo8zVbxqXpP+gUYkVyPziuWW?=
 =?us-ascii?Q?WE0ADw9cPxhRo/R3F0v77YPJaGv0TWrfNEfCNDwlECpVF+oKYYMuTlQFe2d1?=
 =?us-ascii?Q?cRtGEcJEBUwzCeAwxB9/6pWmAvxoZrQQ4QWZoTwftvRddGI4eMVB1ZiyCZ90?=
 =?us-ascii?Q?d5B41HkOrLjNQrbuNMd4ziL4N3SGJ4nLQxot?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:27:57.9488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0738a6df-da08-4889-30be-08dd92eb2445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Fix cxl mock tests affected by the code move.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h       |  2 +
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c       |  1 -
 drivers/cxl/cxl.h             |  2 -
 drivers/cxl/cxlpci.h          |  2 +
 drivers/cxl/pci.c             | 70 -----------------------------------
 include/cxl/pci.h             | 13 +++++++
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 ---------
 9 files changed, 79 insertions(+), 91 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 17b692eb3257..2f39944074f6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -134,4 +134,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0eb339c91413..447dc8d3138f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1033,6 +1033,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
index ecdb22ae6952..fdb99d05a66c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -642,4 +642,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 844dc0782a5f..b60738f5d11a 100644
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
index 570e53e26f11..0611d96d76da 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -114,4 +114,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0d3c67867965..57f125e39051 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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
index 5729a93b252a..e1a1727de3b3 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,19 @@
 #ifndef __CXL_CXL_PCI_H__
 #define __CXL_CXL_PCI_H__
 
+#include <linux/pci.h>
+
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
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 387f3df8b988..2455fabc317d 100644
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
index af2594e4f35d..3c6a071fbbe3 100644
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


