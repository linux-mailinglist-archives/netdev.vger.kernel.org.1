Return-Path: <netdev+bounces-189813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F84DAB3D26
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A624638A1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E9253F05;
	Mon, 12 May 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l/1mz11r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D09253B64;
	Mon, 12 May 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066274; cv=fail; b=LEtltsgg0HBk6l6oAF+UmM+IRB8eFq9Blhl2D+E/PsvEsH+FVhUNjzo8YZv1/eelsxijDvlZkL7VB6Xvk8NlTyTQ1CVizbhiw+lNjOps0SM0bXsvYNqJ5ojhcFrfMfbc4u7vF5levsV82xuOC4h5uhzkE/+jMqBpNN/eiinXFQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066274; c=relaxed/simple;
	bh=iFQTvnDXPzFOq0+FR6hr+H8PCuRGeuRY/bSIlhXrdvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otjxpQpYk87+An0HbTdrHwlECz/B2AX/KWHCJoc94RCipFBryb/+pqghCPPttp5+VBypO7xHEFw5uGgKbU6qdYxSAvt9Q9+5BWpfS0etb/ZIJIsSCvSn+d5etTVbANI5dgvBFb2bKNqYF6R/E7q5+ve6Q0yHSrtsSZUeRjq0YJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l/1mz11r; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSodIr3BT3Z+46ZevceEaAQuc6HZKbPETkhc6jPPPGoUPmg2k/X5XeO5i2CIAU3IWWX83KvdKH6RQNLc/cTjtCGueA/AzG6dsWmlg91x5BVgGyiHHgQGATH6zGgXLgj4AqIMAh24Sd6BPoEpVvtku+teGMvBbG5hBt8ptTNM05XC6C6lZH8isVOzuf8HHLWDxtICr6RAc4KaXPY2B/nXVPQRLZS7qSVQAtoG8PeU74up3lbqDiwFtDfC0+qzNCdnJEiNhlb972MlhpAQqVzGvZGagroBpXDxKZnYSj7ggVIP8lr9GiSn/vOryysgijZ1XCX5xZG/Ow17n4quQ5EUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDS5Vb1hF1vUGfR9uzaeBYPTOHwk0v6sE9konisWnsc=;
 b=UqVuvsGa7hHM5HzBH9dnwNcZ50zLOsIUIe9yjUks0gtbEt49U6fv2agsi47MqWA3Ju0xBv1EsTmM9pOuifEFyhx9BxBfZ2K/e95eKRPjhT92YBN9URsPA0T8H1sSKGeIx9FcBwpyw0fPG23HNq2gfu7Q2Wsq3IJLABF9I3ElucbnZZ6+ek3lqP2QrOHo2IxZCYu2e6igpRs2s9gmeS40KXpvb6RbJ3EOfRouYUSfSz18GnjyqYb+QUn2pVjGZMGzS7lFCcYqnVwknjtO9y+kn2b4BE83gPaXzSSLpwuEp2k59SIm/UeteVjYMl75ghpY/q5KaZ9mhXCyEpql74owhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDS5Vb1hF1vUGfR9uzaeBYPTOHwk0v6sE9konisWnsc=;
 b=l/1mz11rmPBXyizkmZ7C50T+nF6PESsFE8phdzfmQV48nhkiaX+nu+NIHT0P3FfW40IRTBArS3PWEqbAFtyTLK17BaCZJKe6rZ5faCs2mx6A4b5Lh/oRlimmXIzKo2h1fIzKIj7230syMwtGrn+/BF5DFSvIZEuOuSTKJnMwZ14=
Received: from SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20)
 by DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 16:11:09 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::53) by SN6PR16CA0043.outlook.office365.com
 (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 16:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:08 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:07 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 03/22] cxl: Move pci generic code
Date: Mon, 12 May 2025 17:10:36 +0100
Message-ID: <20250512161055.4100442-4-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: 79abf13a-30ca-4e57-92d9-08dd916f9b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6aVI42Z22lCeeQKFIUQ3TaSLGqbtXs/ZKBM+LKna8QOtDL83Gs+a2ma03fW+?=
 =?us-ascii?Q?PQPN93mBgiMwcFQW/y0cpJsBIh5Uu4QQ0dURYexHc6edOFy4WOoFePtkJCwd?=
 =?us-ascii?Q?W4mfWZJ3uehatcOUe8M+Hi2NB0xZ3UujaWE8XwhkMzv/uRxCr8fxqEkZ2k8C?=
 =?us-ascii?Q?EyD9oVubzWyyGF729Grvl8cWWlBYE6UJF6/zixpja9V5EEtLRpRDZoCa894z?=
 =?us-ascii?Q?5dE1sRN7MTejP/Y7Yd8XdP5mxUVhoVR7wPgkNsUDROS1M63CkzSxLOLByqLy?=
 =?us-ascii?Q?IeKcaJiEQPZf9VVuHK2xwJhTk7uVsqXZ43Z+53oWxYsdvSNw4Ny+9uWz3J/o?=
 =?us-ascii?Q?ZI5OEXK51Mzy3nT9x8ztKkmbnpOx4WcbR6mccjiWvBR/s5Wohi+PIluqNrQn?=
 =?us-ascii?Q?127tV9MRpA4EWWyim45LBXjiJVAKgqznnEaK66RVYwJJT95gZFDIP7cDN9w6?=
 =?us-ascii?Q?YF8fgfO9zbzZ+KATyjS4ejbtGgQLgDJ7bncN91gMNdRaFGXQbQ/qf0jrJUoj?=
 =?us-ascii?Q?v8vxNRF9q3zPrtMv0UCgQ3gsMiH9MmfYBdGcR9uN2fpM+t43maDTf23Oin1P?=
 =?us-ascii?Q?8h0a+yDbyGm3cIk4kZwLwlz3FyxLaauUfzmsUXIQG57JV1bHx/TsremNAGop?=
 =?us-ascii?Q?4n9xRZFjIGL8Y+q3b1H5mn8SBYzc5rVSvXgz51CNTRRESwNO1VK2xVEyuZPL?=
 =?us-ascii?Q?BD368wvlBtnd+6IWLRiCKyyZjpQIvs9y6cQhn9W2LnmHjwsZfkowNZc7pI1Z?=
 =?us-ascii?Q?y6IbuecJ4xXBbzINUvEJKXVZ3mrw4/9m+u+q96/Ha8nw5YAMqGZ8MuWDmM6W?=
 =?us-ascii?Q?OC9NQ9puo8X52/5OokZg2Q1HJv+5/GA2w15IgZiGFx8szauWz0ZVJxjzUCs5?=
 =?us-ascii?Q?OVsPXMBn+cR2TYqg3hnuvNjZomOOSZXRBrExU2NvtYuws/RyKqmvYASQb23R?=
 =?us-ascii?Q?Hmo/OpLDAkn0MO3YsImf/sZnSo+2bHWKI74ARWTsXOK1R6eiIyHbG4Z/tzbv?=
 =?us-ascii?Q?l76OZUGe8GJCBW3qF8ZKkWQ3ZIKozfL8PE8OaCNHweTBgQbDgoKLLCBylwta?=
 =?us-ascii?Q?HkHCR4z7aKqxIPhcPHHEW2MRX3wpsl51ftXwNZov3l+xBwxkSqWcX2r2FYHB?=
 =?us-ascii?Q?x4Dq3smaJ9eYW77zloJocAG+IUlLGCVPGayuoOq5ty2ZHMt/Osxs54uKQ6J0?=
 =?us-ascii?Q?B8qHt3b93unHrowj6LVe+ObFC9VHMN9AQIbiShNDt6cUqjweU0vu4NKSNvlJ?=
 =?us-ascii?Q?vKMU8qYNdWuhFimMYmYDlnv9uNfjPyYAK5mW7tkEjV3Q+GE3DRmGRmfopbsV?=
 =?us-ascii?Q?BO6yU8gAiv8Q4g+/XxeIws75P4A+yn5Rp7yJP3BodVg7QxDVPibS3cYuxW/Q?=
 =?us-ascii?Q?TGxbTGt8pMchCosQU4a1mtDLjKj9OIzetGA3uvrClnCvJSUV5NeiBfsxEISR?=
 =?us-ascii?Q?TgJkchXiQIzChcMx/RxgHBrQYmwGoirHtVXHCjE/ZN3zSl8t3E+rYss0oiEX?=
 =?us-ascii?Q?TQ3Z3bJbmHmXhVaoqDTRCf0XBoAMydLiIPv6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:09.3678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79abf13a-30ca-4e57-92d9-08dd916f9b99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660

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
index c73f39d14dd7..78e393e72ae9 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -134,4 +134,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ffbf41c00259..d27daec2ef64 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1047,6 +1047,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
index ccefe24f5af9..19bdbf5278ee 100644
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


