Return-Path: <netdev+bounces-182288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C164A88715
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C466D19019A4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E978E2749FD;
	Mon, 14 Apr 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Es/RxDj7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52437274FF3;
	Mon, 14 Apr 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643642; cv=fail; b=NxflQohHQpSlQarRthropChHI8oMg10tpa6WqnEnfS5n0pjlbYTIzWCe2O3rhyTe5+NJ9k/yPe75GqwCPC37E3qnk/58loBXbS6oPe3NXzWPvaxlGbYlvoXV7PmKZrszRTisnqrUhvNF4/lso2PXCeViljTzNh42Rq/rJU0NJy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643642; c=relaxed/simple;
	bh=SeJsg2p4/Rbo53fTAQFbumcsmNKRhQDdTFj11oooLdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT5FFjuBZ4Utro1AVUorR3DzAl6C9tCUsXBLos5TIaCzAWYkePE99e1tsB+xjkldMohfUoSYrbDC6NOSuSSsQlgiLgkC3vE/ZQ4q2uBPcPdFwkGe84vjg7M/YaRsb9Q/EG447JwGI+5+tcTMXDptCYQKsJWJ0eyBxnZmXa7bM1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Es/RxDj7; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4mNlBqDBLbEym1GSyLfLDKJuNzWRBDGbBNkOCnniFrCZLySS1l6L8wSilPeCCkfBfnGIhwlrQe5bj4G6WX9YUsiPeYAYBUq0jxmBuHGi18yuo0TDJ+Ei6ZL03d+dQFH8sqX3F3dTpxEq6Rdc3GFooF0zEfM5oNFSOT4wEfyWx4FCCnIjRAGKnCkeOpX98O9kWbeHTikj1Ss2hW1VPehBevAHzgkc3B00ZXnAeEblUzbM87O4s6crDBhhnd/1V5GJugntUUCj9QKfRc1hQmz1Qmkd/I66CbzI2KLfEl0leOr9d3MJTemU5gfsANfL0mxtaAk7a/VTBT0ZNIlWtMTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRhVXGCF7jXfTrm7B0xSkd+cISfess9tlDf2PiaQQdE=;
 b=ASLgt0a3heo1eoOuLWrqL59XZHY3/p85Vd19dFHzW0QUoWBp6aQrhL/GHmKTo63EoUtqPMxuNkWRAS375wuKAskbWbTF2IH54VegvymP0d5I8kb+Gl8PlO+mD3rKyR+POyMS6PhwDVSU01IimH05ALrwXhZ+gq25iaB5I/PB8Q/Hr3cSofx6KIBMejn97PxIIo224vUY7NOteOEL+gPWs9GyxaNur0/GVCGWd0AF0ejyvifCpPMiB2iVGokMa+rvP1o9++TiQOUXHqYtjhMsCPDVstYRzbGlDp0LYsVVB1AfRYmOcjIi0Rrf/Gkc5yjM/6UR/pTh6wTP4l0PLeYFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRhVXGCF7jXfTrm7B0xSkd+cISfess9tlDf2PiaQQdE=;
 b=Es/RxDj7l1yk/UWBTf6lDdD+uEZ+DErX8cQ89TlR+GVOp3/I6D/osFbGxPKkLK0uZ4DZGZWDLpRGbU4wAsoejNDvba7aUO92dNEjgADhAyoN7dQ7JpNRdCYSyEOMDq5Exk+XN/g6T1LAcevPpDRarFEaDmJXpuhUTEL1ZU/HZG8=
Received: from DM6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:333::10)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:13:55 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::e3) by DM6PR03CA0077.outlook.office365.com
 (2603:10b6:5:333::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:54 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:53 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 06/22] sfc: make regs setup with checking and set media ready
Date: Mon, 14 Apr 2025 16:13:20 +0100
Message-ID: <20250414151336.3852990-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e01b7b-3f45-4ffe-baba-08dd7b66f932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4yaKJ7ANL7F1zKeOzab673nO24bRbZJQK2IIE3x+ggs98Su2BTY+13iZfbw?=
 =?us-ascii?Q?1sz7jCmFGh6iTy8lsFg95pOxsknNROoD76zz1yvHOC0CuuXR+sXJtYvuPiUd?=
 =?us-ascii?Q?QGSjgmqykus8LepRZWB5m5lqZ0bcPa2/XcJcSPvgkkJnOnFTPSUw7iQz4FYt?=
 =?us-ascii?Q?lYFKFocaZMOii8gcPxCOFm44OIstY4Azvu/xcK/5/0OKsu2uBQjSVudZFEnY?=
 =?us-ascii?Q?JUk5IHK4vU4YyblSLmZFzsYg6vlreGAdN6WiX1Lzwv9tOA1PnPBJPYVynDNX?=
 =?us-ascii?Q?u7ZcFm/tO1PwVt+FH+F8dY8p9vV5u73KaHV6Fdw7kZ5lR1JvZRFXWi0U1ZgK?=
 =?us-ascii?Q?DmEblGKeIMEOC4LiQZn32XXRhhiHXWvb8zOgUYJDl5J88AgBmlga2IDWWmTe?=
 =?us-ascii?Q?5vChtGzIzDMc1LcaRkPxx2AItxdPHPoEPeCTVd6hwbCSrPtzSqNjbaUtOQ3i?=
 =?us-ascii?Q?XH3FOJYfUkFaT0yb3LCUWWoru0eRrLWHA9EF/HMOS0JSoASsy3hNeNSbdRhl?=
 =?us-ascii?Q?zE5eFkMWrKJPmJ35nhC7hicKaJ50XEhTfoN7y9/loKFN+Hhfj0Q8iqxcNFcS?=
 =?us-ascii?Q?D5vhsbtDoVUSePHH7wEs5gOHSM/0hP9J59MbnRyw88Tb4jrOgfCQoH3LAio9?=
 =?us-ascii?Q?vDBTt6HjJyzR6NDDDeRokZD+Ts1ylyDSGW6Hv8uSXKsi9DMoPdeotRMth5rW?=
 =?us-ascii?Q?HOun/lnf7Tf1yKH2N+vXT46C4h46c0Vtrc3bvU4Eg4aox6/TBWqraNCUzvYu?=
 =?us-ascii?Q?g6iPlTMG0X7PtapTpg/c8gdZSfHskYI2m/3GKL98fFnSNn3dNWKCA1B2vdkF?=
 =?us-ascii?Q?rEU0/FYTVHWsbeYLVi9wBcHcHjJOImY1kWYesBxMyU1wtNwMpP6LbLgyfrLx?=
 =?us-ascii?Q?3ZxUC688QvJOuyAzurSMIjq1Y+hEJS1Mc4TeMRgoXp+wWe59jY6YeAAqnyzX?=
 =?us-ascii?Q?uS3Mk6NRp6L8dkHBVzHNrC/aNoJwnB+AwOYphDpl2xS2anHf4elHKHIpoWVd?=
 =?us-ascii?Q?Wakylb5GgxE7be7kdpeFHSOV5dUE5hiB3v+xv+BKmdum4aNxEzVBk/iddd4s?=
 =?us-ascii?Q?eYPplyGQnp82OcfZHiq/GKZWXJHjM+4WegxwCZ7BEs7gqaKWIBgRMdupGgWu?=
 =?us-ascii?Q?ntOuCrJAvOwqV+CP1sCDx8iv/7EzCxxMaIQfEVszg7RKrE9eEiWB9QWqdVva?=
 =?us-ascii?Q?3ZUY9uixTAQ2HPEn6v9R65W5gx809veQnrvzUutPIp9G+zK6LBCy2dwjrh5f?=
 =?us-ascii?Q?shGtZQ0U8mvP5MZARTmFvbUGRTIJz+Iz6b+xM2ynwSSnWiye3OcnH7BbLiw6?=
 =?us-ascii?Q?obv7n1EOOCxXAKeGPTfk7/Xjnyq0FyOKXthzpgtoh5ZnvfKG7iNK6lkmi01C?=
 =?us-ascii?Q?Zu1X4DbdOpJ+uFHa44yjhr6b0kgoXLcE88OduSAor7I+Ve6pRFusYFmekgq3?=
 =?us-ascii?Q?/Mu2OUDdJZHwTeX5lrsDNVpFJRMS2E9D/l/RjQcLWSgrCbcBGkOVBWpVbTHl?=
 =?us-ascii?Q?RbOggzIJ0aZ2X46EYrFlqlUZgpOXdisB5q4k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:55.2647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e01b7b-3f45-4ffe-baba-08dd7b66f932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Set media ready explicitly as there is no means for doing so without
a mailbox and without the related cxl register, not mandatory for type2.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 753d5b7d49b6..885b46c6bd5a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -21,8 +21,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -43,6 +46,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_RAS, expected);
+
+	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		return rc;
+	}
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (cxl_check_caps(pci_dev, expected, found))
+		return -ENXIO;
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both no mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


