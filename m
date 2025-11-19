Return-Path: <netdev+bounces-240149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A9C70CEC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C51FF355820
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66829369210;
	Wed, 19 Nov 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="enNO36dU"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8F371DFB;
	Wed, 19 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580213; cv=fail; b=N7uW7mkPfkuGuj6oV5xYUyoUvXfr6w4XCr07FQE/iiR14yuJrmCQXz6+xJr3CiyTNNOhexRUQhTpcG8l6DUMmdiKs/8HvPJb1+McogkSYGu43XILashqhKpyABvr5B3hHdfYX+VFamCB0WfJK1pu1i011tBlEvpggb3FL3cORtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580213; c=relaxed/simple;
	bh=NieIS7HtTJP/xTwi19nawMtzM/3quW/IJ+c3JAogcIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enCZyVpQWw5pD3CA5El184V5ehgtigNOw+v1SZ4dfkOPeE2d6Q/XNVZSXd3HYv1OmxWc5EHnJomiEuisGcWJ9QTitX8FYYg9Epdr78uIod6/pKMDBdq/GYgkDiJVaPYdKMQRXmyC27S7JjtGYe0dvNYtcxFMU4oRZDn6o8WxQKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=enNO36dU; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imPiCxKeFT+n63XBGBn6bSIAj43T2484pkqkyVIF5Tfj7DqH/SYbEPeKNGUpPnaCfS+GekepabiGjouIPuoSLS8RX2YXxP5ffOmpbszdRv+0Qa0+mGqOigq71+6KAVItkuFLZF3Sk4LzofgOlVVBR/LmVDpoPDpiFNMQ9Zx2ZBwv/+WhF6aOpjFCfaMWaATuxMcCb3aXSDHpxzziA/Bf83aOEu6KC4VcyI44PCF09ZeIOciiJbFNNozvV86pYJXSlUqtgy9WqcsSR5rIBeG5TQCFSY60cd44W/abq2sKgpqme5/UCyhWtxXbNJWnQx4RCi4xWLsC/HfKcIQMU4H6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh4Phell76UuguWg81H+XY6hFN6790OxNnsD4QPMfNY=;
 b=uZ/gPYT7Si7gKZJAPk2+FWpNgfjM++upgS4S5sK2B52DnuT3ocRb3vS6wHjHzM64oFoVCEODOMSeoehDR122WRMlk745bK8/AOvsStXtneubX4Ivjadajgnqh3aUP1d/wA02I6e6PvaklKq2AVu8OhQiD8CZt9kmi30lZxWHTl4E6K242Asd22nAzF0B2WSxJsWtoi2wOmcfzYaRuqJi6sCrj6Hsrv8oocu9atvqZaBHMfoOKdplgSys2H7o+JSoKRif723h59fWSqNVm5bCJwKGmBxNM1sIurn+wW7UJlF6svGnGYaF+ZiX1IL7Bv4dhhwULDPZnXcvtWLDTIw8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh4Phell76UuguWg81H+XY6hFN6790OxNnsD4QPMfNY=;
 b=enNO36dU1sPbakU3uLJ4ZN2gDj47FAtX4hNiBzdq2TwcwOp4OLEbpvM7KAz9Hv5Ey3sddyIq8pM7xyOMCLhIQlMshV63jVlqMpGi7tz+DClQpRdSdbt+Cl1T5+298Z2BNEv17RwM1m4GqbteVtBBqQaAALaKajgTiLFdy1pIxHc=
Received: from BL1PR13CA0449.namprd13.prod.outlook.com (2603:10b6:208:2c3::34)
 by DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:18 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::33) by BL1PR13CA0449.outlook.office365.com
 (2603:10b6:208:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:16 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:16 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:15 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 19/23] cxl: Allow region creation by type2 drivers
Date: Wed, 19 Nov 2025 19:22:32 +0000
Message-ID: <20251119192236.2527305-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: a35bebf5-aef0-416d-01e1-08de27a11846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILgk3n2oNGKgziD5fL4nsaYVRt9npDBfDVSTmPD5zKRuzyqOw2R3rKcNOMQ5?=
 =?us-ascii?Q?lD0qEryTG3I2EMnZUrjTwUwOilLQ+58mqYvcAvXWBGrRaOFYwQRg7lEyDlgn?=
 =?us-ascii?Q?4hxGBpm/WlBmcCPiGyFjwl5lb+yskA92oAqa5okQ9qz7TOe4fe1UcE4Khw/B?=
 =?us-ascii?Q?iNeaTrjxjFqOhwMT2W2LIYy5faKtK5/zhYO4sX4My2YNuVKXd7PwzJOYns6H?=
 =?us-ascii?Q?JnkUlnv4hkm5/xoloeck0Nli2LztDBPC95Xsa8t1lyVyXmVbUQJDf5uwzO9K?=
 =?us-ascii?Q?kC/JXFu3NrCcRf4gUUVNwFhxlEmfwXprrCo2PXWsx2/+V4Hk0QqUUxCspFTm?=
 =?us-ascii?Q?FqeKN9ZSZoVS8MB/LHxkeLllpHqI7jVqieZO+MOPW0FrNnJ66B10PAHL4RO8?=
 =?us-ascii?Q?JahPnZoQLblonJ3zqJjiCwblX3i0RQCJhD85uSnLC3BPmx2oalLwiIsOEd4+?=
 =?us-ascii?Q?SK1D8SxP/nvd2ok9diZXXiq4DMBvmAW9Zjg3wAcag4yLTvd1QbWtTaY9xpHi?=
 =?us-ascii?Q?7tSeUZLUVKBFoezBplEKI/xupoXKm8e8V0KWL3fIWfVbkD3Y+m/gEZxMLBwK?=
 =?us-ascii?Q?ltQYCX8JuoVOFYqlBlG+h+MMf+5mSOOrg36SGfnBvXLIMbyjsvWCluTsI0dg?=
 =?us-ascii?Q?ESuL8euC16r3zhqK4Dkc0bAqDVs6TRe/0l/xjNnpliv9t3szTI2/6WNlUx6R?=
 =?us-ascii?Q?7m3jG2Mw4oMEMAdotk1epP1v+zD/+xAPOcTtKc7NfIjWh6SpLsYh+h/hcnph?=
 =?us-ascii?Q?Ga8zQtX9VdCHnByMowBU7IlJ2FRsLJYoySZLSnEa8I2XpN513hLNJkHxOClD?=
 =?us-ascii?Q?HX6eVcbFG+z4qq0u1Mow/o8C0QLKNsOv/QWl8/SDx+dPJP/mDyD/3dpA3rSl?=
 =?us-ascii?Q?TOBegy93geHQr6ZtSGAdaYDH9bAlB/uyFX2/xvopd+Vwe8zEjcLdq+aJdawQ?=
 =?us-ascii?Q?Bi74RTfxTDKTonE4oqt/Ck/vSK4/7oWQbF885ttfLLE5JAQhmune1/ERf7h8?=
 =?us-ascii?Q?yHp2c4rAsoIKTWz9vkqmV3y7mjB040D8PvaPAGEbPlAgsi+p89CmqnBEdpMR?=
 =?us-ascii?Q?d3yIYJHtUYwxCuAx/GsTFQ2JhWa5b+MyZBRLw/moSivF3RpA5/+4PYjdj3jI?=
 =?us-ascii?Q?lUXTVAHCim0KflZ4DD2qm4qv5nNT1gBnNqIdLV7nB2Z3qaYVvOG65cqNYK3X?=
 =?us-ascii?Q?GAsSUrrT+HITYcBrou++gmE+u88Y3dvDhns49QO4Q44YY05lyXXQymzaD0ju?=
 =?us-ascii?Q?fICvFt5CHDsv4HL+ZFlhIOi6xAmnxCrWgWsUOva3D06eMS0UBZGJGA2lPU+Y?=
 =?us-ascii?Q?dbbWJQxtMFfq3PQwyO5JcxY6/Q0tFRCbK9ePHwDgu6nMhu5LAbqIEdmahr5L?=
 =?us-ascii?Q?nlUJ683NLyQdDTSDQYmseszyVSl+w4a/3oFOmxl3UVPCIsemTwU8qXA8+GbN?=
 =?us-ascii?Q?sH/gRbCMrUC7mTPfg/mQ6YTYlYrB4vRVsXBCBFeG6hfWXI8cdg8qrMs7qYye?=
 =?us-ascii?Q?CJLndNfh3YmchPxM02WF1iuHozhDytfA1gsUYlptjd+yGwsYqodkfmKHu2tK?=
 =?us-ascii?Q?2Tr9BlueKr28lVflWgY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:18.3212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35bebf5-aef0-416d-01e1-08de27a11846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders. Only support uncommitted CXL_DECODER_DEVMEM decoders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h   |   5 --
 drivers/cxl/core/hdm.c    |   7 ++
 drivers/cxl/core/region.c | 132 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |  11 ++++
 5 files changed, 147 insertions(+), 13 deletions(-)

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
index 1b0668fec02e..3af96c265351 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2380,6 +2380,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
 
 static int __attach_target(struct cxl_region *cxlr,
 			   struct cxl_endpoint_decoder *cxled, int pos,
@@ -2863,6 +2864,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3693,14 +3702,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
@@ -3709,13 +3716,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3726,6 +3746,104 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
+				return ERR_PTR(-EINVAL);
+			size += resource_size(cxled[i]->dpa_res);
+		}
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


