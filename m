Return-Path: <netdev+bounces-240148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8621C70CE6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0B92356057
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817CD36828C;
	Wed, 19 Nov 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ro178GRV"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EC30F95C;
	Wed, 19 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580212; cv=fail; b=lucKVX9uxnQvzbw/L71+Th5M2EihxCktt/CrXNGeV8gp3bVkE2vYMlOpk739w/RdVN4LLV9dnDFnsgJ4ez64xmM7RQQ2mHnzBhajT8L28PvhmdkwrlrHLU+3ORmx181uxjTqXqCrsWFyuwz6ev+rFL7JYrRzI8/Gi7isshLvaQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580212; c=relaxed/simple;
	bh=MC3O+Q4uwAiTtttHUWFzhMUHAYbLr4f+O8a5qUvmJos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dU/VNIUDN5fVUiwKExt16fT55APt/fno7BxHiDm0eG/Pnd3EgcyU5Np5wEY4U1jRr7kfSeOGPSLuysUATCGwOk12LipKODPaulz/QwAqD0HS+4tJPXNNPxH+PlwywiJAsqRbSwTrTzJm4Pp6OB8Sdc5BPMmHzDCxLMtoNWY+X1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ro178GRV; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCs/bL72o9aIx6f6GLYn1mgpbCmiale3rNW2RJVosfUW5kzs9vaCht8boqMU2SEcC1wExUdHWu3zuu6r65/MGDQqzKaIL9SPWmRIskSObpS3ZnBhKce8hEH3rmcu/oGUJ6E7Gm0anfOQvSSIMim61zFn1KJ3NJljQckVXbq6ztCiCEsulI4RRfuGESE6zCZbLOSrrhba43vbvOknyZKUycyKalW4P0fMAHimyoiSEusOE2zysl86Om/4sEKcbZi/rpzz0g17qw7wwaSn3f5yaD6QwIMA6a/h6Qpo1DbGegGKf4MNW/Nx28BjFxtd6odnJss5DSvI+j0ts2SnzJnlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvDyLicI/dttLMCq+8xTAbTLrdbFHBjN19VrEmxOZRI=;
 b=IVfZbs3lXoyJDwqPeBnTC5534q6/wkQLhFhs87rqubEPKM56rsgz5QXgXIHO5x11pTBkeRaae/6ERVYon2tu7mPvjvIBayL3ySX+7eXF6kx88u9abOjRnoc8sOmzjZxnRMjg54/FYtfdxEhe0vAfkB5hK6SomWieA4zu/hCiKK1VhsKblmWI3hoNtI9jeSSbEIHvK7m9WdRXy6p2zDobFWDaIdK2lzQiKSUy+hOUYx/V6xb+YUsXHHTc7fA88gamQN0sFoasp9kAVbjb4I3dTGt0FUjvSNAPbsBE2iIXUPdgMqWcRxDrlcRUyjoRyQcotFYtRqDgD+drDhkNqj9azA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvDyLicI/dttLMCq+8xTAbTLrdbFHBjN19VrEmxOZRI=;
 b=ro178GRVXjTRb90P0zRM/27qzEmIB0sdlyLXG9dFF9w5ggEjgMFAMKgaYK++7M/eEVZL1MsHjMTX1l8gP5a1/UqJee2zj+IPuPsj1AHS1U7DUyM64W8OJ7TWb7/gp8MLA8P9FFG5bYUcWxh7yDTov7Ai2FPMnlvjdFanM7Edpd4=
Received: from MN2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:208:239::20)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:20 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::2d) by MN2PR08CA0015.outlook.office365.com
 (2603:10b6:208:239::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:19 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:19 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:18 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 21/23] sfc: create cxl region
Date: Wed, 19 Nov 2025 19:22:34 +0000
Message-ID: <20251119192236.2527305-22-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 8780ec53-77db-4ce3-3131-08de27a11971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJ8XhbeQSsxiVBdAWh7EYos9YUeJ9t9cAf9vmUQVKEGX5dxM9WKUF8dDJW5U?=
 =?us-ascii?Q?LRMCd0h5Y6NtX3JQti/AN7xiy0x8eHRgfrOW93nx/zDenhdHfGp5aoB1s0Yf?=
 =?us-ascii?Q?rBbXARSGHJo6WYTZdeP0nbjzi3IML8MZdqFuarLYEnmrqeB4T1dqAJzBKwKl?=
 =?us-ascii?Q?BksUAPbqpC9jtV+LZYHTD8WpmD/bXRRtpZvxEb6gpBQ+SJ9RxSzn6eoY1RJp?=
 =?us-ascii?Q?1LAMn+BuF2YTdAlbjloYMN/WcWL5EuUEldDvK9PIU8Vu8xCP+tdz2v5lmQh3?=
 =?us-ascii?Q?D5MlAerqIGv9zq+5k8jrxFSZdCqnDXm4UyHafAVFkMxvhEvj6e7kRcGWeL0b?=
 =?us-ascii?Q?jageh777mhBUiD7kbFGfH4e4oPxJW7Dbtt7+w3uCqB1bZs9Jng8HNANp4BFp?=
 =?us-ascii?Q?SY/D7TdW+5d6IXUlOF34LaCYXZq5T7VWst8JSIyf2XA4cPiY1KlRDsaHzDFw?=
 =?us-ascii?Q?dbE0BGGGieLJuz/XzZJMHdNbhVg6i7teaxk5qstOKGezzMoqra2/wua8KJhr?=
 =?us-ascii?Q?UOJCueFvEuuGSEL0T3H16TlOQqgV8Xi2n3mbMGlvdz0nOzCA5Ry5C5usB/5W?=
 =?us-ascii?Q?3IkH4tEwXgsQNpxIy1cfRNoN9B0sn+aCpXipMKPqy+AGwcbZX00D1TYUbDsc?=
 =?us-ascii?Q?D7AQKOyn7hdpsNv138mnWpNN44cxW+cdQBjMvQNaWQwj8Ww9WU/o+9X4Tq7n?=
 =?us-ascii?Q?dWRJ2Da2QHkC8M2wu9boPo3yPDn/qkcgK6zGwpq+DNaIMLbaCx+4H/lXd0f2?=
 =?us-ascii?Q?SeGF929g9DJbE8AETnX7cV4PlR6okBNW9JcJV8kxjHoarFw4GWcNngx9DFfx?=
 =?us-ascii?Q?cwAqEsi6f0sxAGe40Ds5T+zYlcEEW5SfQeETiHM6YgzMj4Lb9tyKTjMOlUNu?=
 =?us-ascii?Q?5jPNBjqRAXthcVrKO0Hjrlp7XIlHUH5A+J8WqADX+EKWFBeVQX6rux7izaWZ?=
 =?us-ascii?Q?r5MaO5otFiWe/c4blRsXKztq9BHRknPg8xsV/Qv2JFO7+hkoBua009JEOJrj?=
 =?us-ascii?Q?ILG85Kxc/dXXa2cPV7zF5SIcKpWwmLlsOwZLi1BN2kgr1S6VJM18cx0MWyon?=
 =?us-ascii?Q?vUgIWQb1TJ8RxvXOFoHBglvZdFQu3LPFJELPUfiDCPNCSyj2pKvShHHNAqER?=
 =?us-ascii?Q?A7WABaJ00qmIe+lEm2JSZgsZPJyMAqUe5SLPIZ4M36q+tuRp5GuptTd7yQE7?=
 =?us-ascii?Q?lIEg/mS9K5L1l7AaKZyAkpriQ9z1PpyKjAU6tqKLZyFIKyynuhUwuVXB+Q2/?=
 =?us-ascii?Q?jHS5IpAZp2Qq9Iv6lloFmzdqUBY8T8KBLMylpLMnhwYJCDxXyDHo2jXCeFka?=
 =?us-ascii?Q?SzlSVmeIG0wf9MxYCTev1Wtaei9queo1yo2PWSqU4P8X+QlCU3A+BOWU/ZCx?=
 =?us-ascii?Q?5Ya7+tLvW/wdC+A1NTyk0KfEL5JcTsB2VYIfBbt9IEq3fbaqoNo9+6qgdhWO?=
 =?us-ascii?Q?/Bkx2uJDb3KK/eTKbewhtr8QsdLoLJ00crELgq48qWkxNZSTSsBnxgGapro5?=
 =?us-ascii?Q?OBVktYgrgoJH2FDG3DVrCam7TRSpfeih671cjnEVRSiAuc7IwN4tqdx47ivx?=
 =?us-ascii?Q?xFeMXOP7kHn2LT2nBEM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:20.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8780ec53-77db-4ce3-3131-08de27a11971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 1a50bb2c0913..79fe99d83f9f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -116,6 +116,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxled);
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		cxl_put_root_decoder(cxl->cxlrd);
+		cxl_dpa_free(cxl->cxled);
+		return PTR_ERR(cxl->efx_region);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -124,6 +132,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
+				   DETACH_INVALIDATE);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


