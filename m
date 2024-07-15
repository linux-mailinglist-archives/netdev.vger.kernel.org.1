Return-Path: <netdev+bounces-111566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A67931945
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8626F1F228FB
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8D50A63;
	Mon, 15 Jul 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4YVMii4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B8481CD;
	Mon, 15 Jul 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064536; cv=fail; b=CAQmnwglEJNhoJ++7cybPnYKs7YEZ/uTsxIt2xzG7DYokgTEvWHPPYJ5T4Q5JBfQdBLBIQV3evAO5qFcyJvjsxGWIjlim0BsqXJ37pEr/O8Tbj3BWxTrB0wLgoy0ruJNqJvcu/yCH5SrzxR7zstCODn4kznTppNZn7zWIUp7DS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064536; c=relaxed/simple;
	bh=Oa/e9wb5h3jNEP3DHIepxNpYhzzLgaOQrgbxp5b0rxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g11mBdE6A8ticJ9AV40QbrkS6RYglWsAef9ImWm0fNDRNo6kbawkLCzZHI9REct1x4i8a7g8EKxUbTG45KvDeSv9L4y3XIAXXHQxTJsapt+EU2o+ekkZ3EYmMGrSa4fHJ7B+zqO3LVlss+TYTF3x62BS8GpW+xrPv/9lD8G3EEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4YVMii4; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvrOLBh+0KT8qqIKFDwkNkiJeO7W/2/hxc7DwZrEhRhHouBNr/3IwcyzIN6xkQ492EaU7SW+JNp25F8lxEYaslQFqKBVbusLL+iLbacBwreL1T9tYghF+mAABTS+7eivYO9qFdt0E58RD7DGGyDhvd+NEMf5NHS9o2BX7ySA607VXugqVotHW4frxJBJQyVMlaPvTMOt831tyHIhhTOhFJn9utUJcMXF+wTovd2Dudaxc2xxGsLqV9yXof3Q/lwL3sEVSQ9gKJ4+Z1Fy2oMb1oHN6SHzCG3T8DSSkf5ohDuqw6VEk9l0SR1lJNiEg8dNzN2q1962Lf3PCaKf3ma67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMNBtYKx5gHyDrtdQ/82TEODfgFpLHEKyB2LfAdsiOE=;
 b=fAmwZECaxz/Ftqe4iXUvJnXvCjTfW/0G0r6m9MqKafcKRKHnU8Rj9RbRXXmuAHF8G1xrNDzarcPCKBIaHHOYABjFCpZPIxqwt1L3QSYvaAR83cXHv+Yej2fM6XFEFaKCyNVkeRGsmv8ugFTF/ypgC/BKxC8sJ7Ak8GdHa/zBtOfLDo5gPxY6+xn+Fn2eOMWvkTCaRuNYHaMHy7FlXm0tGheddlF2HWQa4sdGp7nT/Bqynt/NW3vSEuaKjzWvDujMQoKyxyLStwPGPYYnEFC8wuDPm/dErzppcPfYB8Ms857BlsQECF60qWAFcvdxG1bPgF+teSliW1IPMSa4lgkZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMNBtYKx5gHyDrtdQ/82TEODfgFpLHEKyB2LfAdsiOE=;
 b=S4YVMii4fnlAWMBEumBC3i4o6m38+UdNtLxuYMgllrPgSe2ha1RkmUbfc6EXu+cfQq1VsUpDzc3mnyak6+IZK7TN++sHORAj4ArzFffTVKQligvkC+YsitHiZS771qOHspnu5kEGOTUgkCkGUTqxpu+ZPg6k5NeL0k5lPWMt7y0=
Received: from BYAPR07CA0064.namprd07.prod.outlook.com (2603:10b6:a03:60::41)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 15 Jul
 2024 17:28:45 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:60:cafe::7d) by BYAPR07CA0064.outlook.office365.com
 (2603:10b6:a03:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Mon, 15 Jul 2024 17:28:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:44 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:43 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 01/15] cxl: add type2 device basic support
Date: Mon, 15 Jul 2024 18:28:21 +0100
Message-ID: <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: fd750184-5d36-402a-fecc-08dca4f3947f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+nrcrbMOW95CQ8TL1MmdUFHHaKvqEVmnB7MH7swcVA22p2gbvAss2L0C8Nok?=
 =?us-ascii?Q?DXPKxSEhhFGnvCpUYWudKNHuxxu7GIpCoMrLhuaoK+lmza1hpxlS+B8u02EC?=
 =?us-ascii?Q?iLfCqDDnk8WsRjYjQCI/mop4Aisdb35nFlEHJ5pzl5M9mixzx/80MGBYoC/K?=
 =?us-ascii?Q?/tdtT6AAd6KVHVRy8Brq5Ve6886x0E5mJkNH7s97/NJr/xCgnI8rOGpB3guF?=
 =?us-ascii?Q?04IFChz4WlQ5vlVfkLfL8P0qUxRkJSPo8HhSO6cmfzA0QE/DItgyIb6XbZI5?=
 =?us-ascii?Q?8V8n4rNLais42Or+z0afseYYQkXdLjzWcjPlHMFI1+GKFmSjuB9HbMsAmSfX?=
 =?us-ascii?Q?ki9VS2vnPhmtweeU+QNvvtKYETCAWF/1FYXjqkgeUBwgeeayN+sOT88kyIQz?=
 =?us-ascii?Q?cqQygpHzELn+1dXQE/ju3lT+wm3bzLqvfMrgwA9EYUbCym1YQoTav+c7qUOy?=
 =?us-ascii?Q?KXg30nTTvucAj8iUjh5l5QD1At/MNJctgaoxGtf4Hb0fGSV7mbLoEwWUfvYZ?=
 =?us-ascii?Q?hygXC/fhv36iIEZGMauYLF607WLVN4bDL+BLZl0TfzypdhCIt1+hHkOCdlpz?=
 =?us-ascii?Q?dLs1djtnpr13fcgq8FYM+UUAkB9IYnZAnzNGWF1X6XHXankipk94Kf1TsCfD?=
 =?us-ascii?Q?n+oRBzESX3h1WeuPe3u/68asj+WIm3mgTHHDuHbIkHfZDiOIo4X9xvV0SaX1?=
 =?us-ascii?Q?qwG8XcMNlGaUGIjxLK/kxhZoONE0lsjgKlFWUYcaqWSybAgjzW0LQySoXyzd?=
 =?us-ascii?Q?1gfgJzxCZtX4/HLDgBV86EDyrUNi5V3ljOOx2smU+DeXP2TKgl578jl54qvu?=
 =?us-ascii?Q?KoQa9JbP7ti9NK03ywlj8NmBzgIpl3AtMtEJb+IY6QJJUA46luCTLekw2P75?=
 =?us-ascii?Q?rBipcLpW04HXL1+SCeEHrGCYsbTB1pLoHxJhmtHIF9+GyykC9evJqYG79ea9?=
 =?us-ascii?Q?WC9P90Mn3T3Dg3fXfkdGsYSoeQCZVt+AK2YNkvDbUrd7h8pS01M4brItde/S?=
 =?us-ascii?Q?DdE1keaMzYfF96/6JPv8k9LAG7ORQdWoayXe5STf2m05ilzHCSyw54PuBOZI?=
 =?us-ascii?Q?kw0buh2sAq5vY8KSV6flm6rMo9JjI5K4yfZx7CR8S7RJBi9umv/ETlY8tbay?=
 =?us-ascii?Q?g9Z2lw/vAQTo+5vUa37j6kCNpKEAC6qfT0+/ViOmm4AJLOJbETarDpquo3ph?=
 =?us-ascii?Q?FS7yp3gIt+1oX5lOT9svdS2CbWdC/HNhcLdefks3dNRNVYP9dwrhfvssIglV?=
 =?us-ascii?Q?TTUSPfJHg0ZzX6pb6uG/MqAE0lVcsEAp4+JzJTGg/apN5c+3NBaBi/sC8/eP?=
 =?us-ascii?Q?IaPb+ISXux1NfGARK6jPzQzfZK7jnrhauXpmaPgC+kf+SLN3/x+KwnRbKoMV?=
 =?us-ascii?Q?junCh8MsCXhBqHqhGEll7iuwVY7EHCeG025Hg+GSwao89o59wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:45.3786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd750184-5d36-402a-fecc-08dca4f3947f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

From: Alejandro Lucero <alucerop@amd.com>

Differientiate Type3, aka memory expanders, from Type2, aka device
accelerators, with a new function for initializing cxl_dev_state.

Create opaque struct to be used by accelerators relying on new access
functions in following patches.

Add SFC ethernet network driver as the client.

Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c             | 52 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/Makefile     |  2 +-
 drivers/net/ethernet/sfc/efx.c        |  4 ++
 drivers/net/ethernet/sfc/efx_cxl.c    | 53 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  4 ++
 include/linux/cxl_accel_mem.h         | 22 +++++++++++
 include/linux/cxl_accel_pci.h         | 23 ++++++++++++
 8 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/linux/cxl_accel_mem.h
 create mode 100644 include/linux/cxl_accel_pci.h

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..61b5d35b49e7 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include <linux/cxl_accel_mem.h>
 #include "trace.h"
 #include "core.h"
 
@@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
+{
+	struct cxl_dev_state *cxlds;
+
+	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
+	if (!cxlds)
+		return ERR_PTR(-ENOMEM);
+
+	cxlds->dev = dev;
+	cxlds->type = CXL_DEVTYPE_DEVMEM;
+
+	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
+	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
+	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
+
+	return cxlds;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
@@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+
+void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
+{
+	cxlds->cxl_dvsec = dvsec;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
+
+void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
+{
+	cxlds->serial= serial;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
+
+void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
+			    enum accel_resource type)
+{
+	switch (type) {
+	case CXL_ACCEL_RES_DPA:
+		cxlds->dpa_res = res;
+		return;
+	case CXL_ACCEL_RES_RAM:
+		cxlds->ram_res = res;
+		return;
+	case CXL_ACCEL_RES_PMEM:
+		cxlds->pmem_res = res;
+		return;
+	default:
+		dev_err(cxlds->dev, "unkown resource type (%u)\n", type);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 8f446b9bd5ee..e80c713c3b0c 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
 			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
 			   ef100.o ef100_nic.o ef100_netdev.o \
 			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
-			   efx_devlink.o
+			   efx_devlink.o efx_cxl.o
 sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index e9d9de8e648a..cb3f74d30852 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -33,6 +33,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -899,6 +900,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
@@ -1109,6 +1111,8 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	efx_cxl_init(efx);
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..4554dd7cca76
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+
+#include <linux/pci.h>
+#include <linux/cxl_accel_mem.h>
+#include <linux/cxl_accel_pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	(1024*1024*256)
+
+void efx_cxl_init(struct efx_nic *efx)
+{
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl = efx->cxl;
+	struct resource res;
+	u16 dvsec;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+
+	if (!dvsec)
+		return;
+
+	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
+
+	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
+	if (IS_ERR(cxl->cxlds)) {
+		pci_info(pci_dev, "CXL accel device state failed");
+		return;
+	}
+
+	cxl_accel_set_dvsec(cxl->cxlds, dvsec);
+	cxl_accel_set_serial(cxl->cxlds, pci_dev->dev.id);
+
+	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
+	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA);
+
+	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
+	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
+}
+
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..76c6794c20d8
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CLX_H
+
+#include <linux/cxl_accel_mem.h>
+
+struct efx_nic;
+
+struct efx_cxl {
+	cxl_accel_state *cxlds;
+	struct cxl_memdev *cxlmd;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_port *endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *efx_region;
+	void __iomem *ctpio_cxl;
+};
+
+void efx_cxl_init(struct efx_nic *efx);
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index f2dd7feb0e0c..58b7517afea4 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -814,6 +814,8 @@ enum efx_xdp_tx_queues_mode {
 
 struct efx_mae;
 
+struct efx_cxl;
+
 /**
  * struct efx_nic - an Efx NIC
  * @name: Device name (net device name or bus id before net device registered)
@@ -962,6 +964,7 @@ struct efx_mae;
  * @tc: state for TC offload (EF100).
  * @devlink: reference to devlink structure owned by this device
  * @dl_port: devlink port associated with the PF
+ * @cxl: details of related cxl objects
  * @mem_bar: The BAR that is mapped into membase.
  * @reg_base: Offset from the start of the bar to the function control window.
  * @monitor_work: Hardware monitor workitem
@@ -1148,6 +1151,7 @@ struct efx_nic {
 
 	struct devlink *devlink;
 	struct devlink_port *dl_port;
+	struct efx_cxl *cxl;
 	unsigned int mem_bar;
 	u32 reg_base;
 
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
new file mode 100644
index 000000000000..daf46d41f59c
--- /dev/null
+++ b/include/linux/cxl_accel_mem.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
+
+#include <linux/cdev.h>
+
+#ifndef __CXL_ACCEL_MEM_H
+#define __CXL_ACCEL_MEM_H
+
+enum accel_resource{
+	CXL_ACCEL_RES_DPA,
+	CXL_ACCEL_RES_RAM,
+	CXL_ACCEL_RES_PMEM,
+};
+
+typedef struct cxl_dev_state cxl_accel_state;
+cxl_accel_state *cxl_accel_state_create(struct device *dev);
+
+void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
+void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
+void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
+			    enum accel_resource);
+#endif
diff --git a/include/linux/cxl_accel_pci.h b/include/linux/cxl_accel_pci.h
new file mode 100644
index 000000000000..c337ae8797e6
--- /dev/null
+++ b/include/linux/cxl_accel_pci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
+
+#ifndef __CXL_ACCEL_PCI_H
+#define __CXL_ACCEL_PCI_H
+
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#endif
-- 
2.17.1


