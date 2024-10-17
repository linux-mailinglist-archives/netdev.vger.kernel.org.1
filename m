Return-Path: <netdev+bounces-136666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E79A29C0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64291281C55
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB871DF986;
	Thu, 17 Oct 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gqMUj6Jr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AE1EABC3;
	Thu, 17 Oct 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184010; cv=fail; b=Qkzx5w0RpiEIp2VVohe2kZXLpoWmzB/uwK0rGlwCKrtgZb7WQegqRE/unwKQi13kZMl9w/O9G0G1C1MYRQ/PoCFB1R9XO+SI3y4pGN/cUvnXtKv4rrEYdOusPTRme0U84tRQhR7d3xKlQNCXOvso6D9cUSVBTuvEoPZz4BxecFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184010; c=relaxed/simple;
	bh=MwbNfIWoHzBKaci0YSM1FimPnKYeqVjeoJHYRXAjYNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVwmDAOlpSk0NIQQKds0lMHJGmkQMfNfPIYbVLNi3v7EBBe+pcd3ZSQbkhb6/vOjkAD4EzJ8OVhRO/VUdr3+UeZZosStYWfGiz7Pdn17lZoZe+g6M0dOqTeav/WR9u7YxLdLqt4pMLKilfEsX2EGp4fxhAK6ZugxYTqSawGY/XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gqMUj6Jr; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKtQGiQ4xCWAAPFJyN2379Py0ZlgsLzRzUWe4sItpbHHDaPgvAuseP2aD+K2HH9HNRK+IIjpWaQeU9V+XmWxaWxx8+xkcb8xH+e3vnHiKBa6p2aixnO8+GEkcIS6YKqtp4qM0awrt2G1E/mv4SMcUQ4LxdOfkZwO4HYHsCxxh9j7mR7ib5XYHwXwYyO1Q7gkjyLCFdpvqnrTf6WUfn3lYp6p5JTysEhOoI3Ki66kizSgMKdkKzSOd/eRqG/nMmnUehU+6Mxg+ULBU/N/wEx56hXzixnIowyZGxB/S9sZrZrgYgdxBPogsx6Z5lDzlyiZRkypE1AIeZ4+HbqAypisPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1SSu4lG3DlnDayGi7lAAABeQ4zGlIIl5BlkpqVst/U=;
 b=tYScfyfD3mHcVRXunF+odCoZKUZz2AynczWO9UoxD09yfndES6AWDwsbU+FFdZbj6pQm3xDPHoHLdhr3ocbfvRu5e1lzYzsAXAtR+J7Vk8jE691b+UhuREMKrBg4qJdH8erJ1MryPye0TTtNzKqQ0/bYkWdaEFL84fZxt7U9bxam3Ehhsj7wuum741YbrUWJP2NNSitVrWKDi7HWDUFq65tJ3NSWsikIJxrg0lxKNBV5W1z71bkPX2YhFdbDlwwfv2YfyfFVLd7lzeierCTdkG+PqO2ms6qb6rZdgNnEFEI3fAGZR9VnCPvO1KffkDMX5ckswjeeSRtwM8wBHr22gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1SSu4lG3DlnDayGi7lAAABeQ4zGlIIl5BlkpqVst/U=;
 b=gqMUj6JrDylHcc0LRuN//iBJV1w0ObS2YGq0zvNLt6Av4MU61KKW1UDe5iRr2a8dtwZ8HByscYcIkJvdozjRFTHwiBVtzy9FiF2l4S0vBmDEWRSnE7WtzfOlr4yikjdRKxOUkZtiV3LDxhwriKZezLZKYXA2LRLUHzYckaTyjt4=
Received: from SN4PR0501CA0102.namprd05.prod.outlook.com
 (2603:10b6:803:42::19) by IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:21 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::ec) by SN4PR0501CA0102.outlook.office365.com
 (2603:10b6:803:42::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:20 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:19 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 06/26] cxl: add function for type2 cxl regs setup
Date: Thu, 17 Oct 2024 17:52:05 +0100
Message-ID: <20241017165225.21206-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: c547786d-829c-4d0d-40a6-08dceecc3539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4B8P/TzHtrv3rTYkrRUIwblm2tUqxKPYlKIqjvg7GgASja0oyLMdDoOLSWmv?=
 =?us-ascii?Q?ZBt6xNu+m4/2TvPcbkCBHrgT4PuhJHXSQAGkZtlQqn86ozZqZ0sxfgDTnH4T?=
 =?us-ascii?Q?yaFNLZALRkzlizHNRaXKA4XNgvX+9mh/6L5W5gvLwoRh7WlqL/q15VKDJxQG?=
 =?us-ascii?Q?QR4kC6f0PqpnSDyftCIPtz97nLBS65qkfSfT7vBshlC4+EOVkct6hrOhPa6B?=
 =?us-ascii?Q?eEWnrhyMVaQkCPHaMgtbUXailrwCsXYa9NJc9gaZ/E7ec1qak1UjXiOkAcL6?=
 =?us-ascii?Q?Vx0KzQzsoHpMellXMu81tnbB7cW6RTWOxi/EHVuouIdCA2gb0Ae2++7Rf6EY?=
 =?us-ascii?Q?V2U9R+ZuDXLcw4fQf27DPAyzILnuLS/4vW5chKgj8tN26I80h+btukzH9teg?=
 =?us-ascii?Q?WpVnbaUQAFMSQdyfCwNGykOSNB899tU0ogjNdwXYUuGHToF7ejsMQaHEDsWT?=
 =?us-ascii?Q?Tt8I6vwqpHuc/2SLPQdhoH5SM02fAk4ZRgXSiqgGGUsKDhkMvNoETX85TO/Q?=
 =?us-ascii?Q?i6vNZVjStIp6gras2IZrjYlu5H5YfQN4AR8NxfyCe3Zv/TFf/7KpewXnlsw0?=
 =?us-ascii?Q?PBndnbcbPKgE7Scl08AYo+5BFTlFajWt1whe750SFnGa5S/ueDrIYOtpmSAe?=
 =?us-ascii?Q?ShFchB1rbOfAF406x8W8gWx33jaguCKA3FFpVw9Ir4pLsgiYq15s26O6TzB7?=
 =?us-ascii?Q?xUNqU5dbKuS0cgc2Ww3gUkj0OGPRktJUNcff0lst6t/cycSN6MrlPXzyuihR?=
 =?us-ascii?Q?9bzUl7KjHacsI2NTC31jaW+zdyKTTSsFfvbEAHyqX1PYvy9D0df7/66K7m2n?=
 =?us-ascii?Q?M4xvIE0rKoU8BOpjvM6mhPMDdVbEDbtDJitdUtPQuOcOzPQj7lkz7hUvfAm6?=
 =?us-ascii?Q?idhIsN8VRJKeSkV5nhyNGnBxVz4ycJOm4Edv7yitpWg/QheUi5xRWga8tNVH?=
 =?us-ascii?Q?IJZVz6yr7LVShMdbfqkKHp2BK9dwDNxCKcQXZFyXpzraV1TnuX6J07mUihHO?=
 =?us-ascii?Q?pNmKE/YBOkFzacaSaA0cttqzveCYagthTqYGg9Ut/MlzQbMc8HfOmntvie+s?=
 =?us-ascii?Q?4j3CDWWlFSlVq+1ke06RvDZazd2lvA+kW8jFxS3Huabjiaz0fL8HC9Nm9ejX?=
 =?us-ascii?Q?uFvKOLL7Lrzy5pZDctGTcRSn3p3raLaZeOi8XsoFWJaQ7DNYJiDrP9VZE+3e?=
 =?us-ascii?Q?eW+BcX2HzfSLmkwymcKlujZUIh6yXajuMs3xVlimI8ZXJaZTV6QmWq7AJJs8?=
 =?us-ascii?Q?IkpgPcnCIk7nFTRw69IJ+x08W5pMNoMTDgwLtG2blV7klK+zzZbQ+ZD8b/Le?=
 =?us-ascii?Q?UE9vFdTVqkfF7CsKiI3uc6PhOdYc85MlJLY8fwXNH2cYOpbnzgl1H3mo14tD?=
 =?us-ascii?Q?J/i4PZ+tPQzfCoJCe9lyw8vXJ6I+qVHKI7GVXdYS0F0d5kcwcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:21.2670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c547786d-829c-4d0d-40a6-08dceecc3539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c  | 47 +++++++++++++++++++++++++++++++++++++++++
 include/linux/cxl/cxl.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 99acc258722d..f0f7e8bd4499 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1141,6 +1141,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
 
+static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
+				     struct cxl_dev_state *cxlds)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
+	/*
+	 * This call returning a non-zero value is not considered an error since
+	 * these regs are not mandatory for Type2. If they do exist then mapping
+	 * them should not fail.
+	 */
+	if (rc)
+		return 0;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, cxlds->capabilities);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+		return rc;
+	}
+
+	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
+		return rc;
+
+	rc = cxl_map_component_regs(&cxlds->reg_map,
+				    &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
+
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
 			unsigned long *current_caps)
 {
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 78653fa4daa0..2f48ee591259 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -5,6 +5,7 @@
 #define __CXL_H
 
 #include <linux/device.h>
+#include <linux/pci.h>
 
 enum cxl_resource {
 	CXL_RES_DPA,
@@ -52,4 +53,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps);
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


