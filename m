Return-Path: <netdev+bounces-173670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2DBA5A590
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30BA175332
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6E1E0E14;
	Mon, 10 Mar 2025 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fwibGEfU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9B1E835F;
	Mon, 10 Mar 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640663; cv=fail; b=Z3c8kb4x1+QzPPJ0Iy91W28HdMpSYtGn78t6XzO/qQPO98EYCt08O4au3o1y8Q6VDSSxtsO07SQmSXfR5a63+wCT7A9E2ONNaGb2gYACdI8RSjd6l891dj04Q8VqoZ6+lqFOv++jLO5PIm+ewv38Ww/72hZhS86Qji7Jss8uOK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640663; c=relaxed/simple;
	bh=IZlDDA89wTogpnKj4+zXhnJYrfrwsBpuwcfZ4mj78VQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIQ/xmof+ll2pp4U+GmSN0JS9nF6qGQR26MHuBOJt0U77Zq0qf2tsBvmXMrsxKRv1T9j5M3A085y5zzQTCVoLOGJoxF9qeSovZA7EmZcf1b8T8Rr37CyvY4LVkdkpDLh1o8KLwkI/KCmXzE61SRccPx6YbJZfzGUXW/d+hWIhAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fwibGEfU; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rogdD+Lwb99D2ufpyUdsa94p3zD1thyJ//Dj8qundT9oMbRV4Nx9gxEv/lQq5gLOMVqCQ5VqBzgeyqhZfTNN9CEaulct6tWvLhPGUi5g+Op5sNRb0r17Il9K9yGDOnZmQRgQxYvLZWiti2Otszxf59cXCoojX/EgIT2GihM5qhfvNykHgDyHB+QFQcEETKqwfIIZRSy1LtuefxTvKkmqdSkxzDqXXpFbxq/ZIts3d/vci4GYOFoPWTBFOCDdCz49zTUzhPGvPRcbbbbo/EJg3cHAqGQqd5yeMXoL9coEDDFAd/3bLFKYqBZCo9/6xBj5W9ZhYtS5M/ZfH2SoVtdPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZodsISi6aDN9p7SVcn4A48o7yl+V5G3I4T2ZQYePsR4=;
 b=yalP0LzOEKlxRt1Ou58tAydf48VsH2mnOgu066JjYIJBHh0AqBnPE3I3JKzXgPgsYzG0MNyiBmvH+m6MXPktVQRTJk2d7DqyTC1w2bwZ3Z21ytOLuqvFlySJMcd2GodwXw6ydEJeoJWiE7jHHieiB7Bwkyx1RawOhZu/O8pldKo+j9dpgKxnSnWtuoPy7ahpIBj1aIRhUtNr72FX/yzSkc9oCsaJF1NBrT1OuRZ27RJq/jaXUAsj8svFp67sF0iYrVbXPjWkMcFBs44TdJIgxge8sOGgBiCRLhyXFBcd3YKw0+U+XWIqwUQtbmMCG/K5ngDbTJ0woDAMwEk4ez1zBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZodsISi6aDN9p7SVcn4A48o7yl+V5G3I4T2ZQYePsR4=;
 b=fwibGEfU17YhLg0z8qFA4NESwU4H/g+R2EdvIcBZYjLkHCQcSOQe2rU7edDPrtOw2NnCqsoGbNLUNH2Sf96Wpulza15VtBvsUY0k9aB7efzaDiZPKpeH2FGQwcyc2dkVwPuf8oiebmgvAItTtLb3R0djs4UrzQEB86d5D/O/XEE=
Received: from CH0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:610:74::21)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:04:17 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::da) by CH0PR04CA0076.outlook.office365.com
 (2603:10b6:610:74::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 21:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:16 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:15 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 18/23] cxl: allow region creation by type2 drivers
Date: Mon, 10 Mar 2025 21:03:35 +0000
Message-ID: <20250310210340.3234884-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 736f16a1-5056-4d59-cf64-08dd60171ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PyjL1MvI7wVSkAgkHh3DP8WB5bMp60h6Ap3bfm/LS0uGLijknTfbM2MqT24o?=
 =?us-ascii?Q?S3VPZNXnFP125wvulyD1k6y68u7iiy2k6ndCZpxfmlIisjgq5b3l3x4odMnH?=
 =?us-ascii?Q?s/x+ekG5bbtUSomjOMO66TlcEeI1ZJCBJNKyq6vle6CoFUb4Mq3crIKXZrg/?=
 =?us-ascii?Q?RDVYNyJl4aosUxL0bYtLAaK9+u9cERtmXa+TO4KIXtdXmy3wY4mZeg+p2wz6?=
 =?us-ascii?Q?H+oTvj0niyX/i9OdRudoc2ze+qT1suDECqHlrrkx6tWuLSYtDfmI9U+2BNUr?=
 =?us-ascii?Q?KWKymvS466l+XYLlU71BHHrSLNobxZg0uJEEV4NYOJe2+ZisuNrFpwZ0zMt6?=
 =?us-ascii?Q?+d2LCoteWWOZc88OzPSON3cFotx3D/dj1P38m5LuhpMCkSiP2GJtCBXPt9aH?=
 =?us-ascii?Q?zzw3bH44KUBYK6FiRPvTKi2Sh+GsrDvVtevxOcUWokWlr8CskNZo5webhJNL?=
 =?us-ascii?Q?R+JKtDjKm6gxCXvho9yiyFJZ6XpWmymbMj5BtsIrBrikjx35+wKTiRtWU2n8?=
 =?us-ascii?Q?2MNE8M7w+L9u+cO7DLu548Bh/5sKwGV4IB1b+BITMPujDnRq/FF3RyHtix55?=
 =?us-ascii?Q?diA3B5deBox2QWq8RCG7rrtEXwWIJjqZJ+PrkZpXAlo/kGKIAwdCxqrBuRFZ?=
 =?us-ascii?Q?DGxyYuR5jARD3uHg0iKNELYtnEBjex1uCyKewfxfC+paLSKibcfjuA5JvQUj?=
 =?us-ascii?Q?7AWCydtyYCgSur+wwNlVfl+7uUOMj+9t/R5I4mymQGi7ECAcBOykaFNvImmG?=
 =?us-ascii?Q?APitBuLVEXFiAYM6O3239nHJl7eRAqanF6CrFsXYUtdy+L3dGQZcdA0DvLjx?=
 =?us-ascii?Q?nB0usehff7HZ1Fww6p6gWi3SsHcHZ9Cgifg9sgZpuUvAsIFg46ZIW8pH6K9+?=
 =?us-ascii?Q?VdE1QVxxGmzUx/PRF4swU0O/N1Tp/t7JkECELIJRqBmncZr7xLNghR+xS2H/?=
 =?us-ascii?Q?hSjgji8rjNfT/D11tAy5lr52ONxxPIbI2qMm4gBYSreKnmTNt6AU0QGZPsVI?=
 =?us-ascii?Q?O1o6fj1kw72fEd9CNWppDZ2uqd84JzA6Cam0iGlb73V98oYlRVz8DueLokme?=
 =?us-ascii?Q?CLtqHig5+n2pxngTUzyLhUSUprF+9k7ogUrmvsYer6Ghh0xO6+OJaN6yNdNS?=
 =?us-ascii?Q?nEU/aHR7b4GWYu+TxbfSuQz1nkfdIEKL2QUB0UIE/ncvq84RKyYYYKcH4c+Y?=
 =?us-ascii?Q?1yE4qQ0nzEwvKk8e0l7/LHKu7Y8D7xm8a/7iiEKgcjx00ZHiFIKqTBv7Iuv1?=
 =?us-ascii?Q?komZ7bkRbK9c5i9IDiRxcGM+xRW6ltH8iByjATvMwsdkBKCJ321S+78F0FHz?=
 =?us-ascii?Q?K9bfFGXF5t/rVC4Jnb6p4oTNj0GI9CMES5OYtipFjXNPzx5k5KUGHF4wsmsl?=
 =?us-ascii?Q?E68B1cQsRGyTxd6ok+zJ7S6DFHe3exjyNUNI9vAcYF7cao1nLETtVXmFu6XT?=
 =?us-ascii?Q?1RuDNNMv+cwRrXuNCOLOV2ElpetyC0zM5Y1yF3AG0iBcCH95JK1/wIlbmXXV?=
 =?us-ascii?Q?yNQDvg/IadXpYBU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:17.2360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736f16a1-5056-4d59-cf64-08dd60171ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 133 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 3 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e24666a419cd..e6fbe00d0623 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2310,6 +2310,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+	cxled->part = -1;
+	rc = cxl_region_detach(cxled);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2816,6 +2827,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3523,14 +3542,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
 
 	if (part < 0)
@@ -3542,13 +3559,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3559,6 +3586,96 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_dpa_rwsem);
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
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+
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
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d2bfd1ff5492..f352f2b1c481 100644
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
index d6b2e803e20b..9212d3780a5a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -259,4 +259,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     bool is_ram,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.34.1


