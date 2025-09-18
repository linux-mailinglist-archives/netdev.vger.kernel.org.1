Return-Path: <netdev+bounces-224324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6ABB83BE9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C775524EE5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508EA2FBDF5;
	Thu, 18 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tXtguJw1"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C73019A1;
	Thu, 18 Sep 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187114; cv=fail; b=TIo3RXUZnKfVBxpIZjPW+K/Me3WgYXVXEUGXFKS1I63LfiKt+CPTN644TW4cbLinJdq4+lheUpGE/bnyjp8AnSx/hlAA8vnb5SoJTHfi/TjUUNUneSjzHQH8W5U0YULP4LA1jgqJhNeVwb86HVmaZfNw/5gPOL5I/Qovyb0iexw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187114; c=relaxed/simple;
	bh=lVs1d35z712/U82CMRSVBo7Hk+sSU9jsIjmJrPNLr/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIRUqi2IdsYU1AeS/qVYNsJDoPWWoc+7uJdr0DwsKfFFldIYN9RJt/z9AxcmgXAC90GlTf46LgO/wT/+AGp/kZLRspt6Dht08xQULAEsldkNjaK4MDvn9FXa8jMd5hYDnISRZ41vljx54KkULDQ91qeOnA0uCOnlynzqGucASx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tXtguJw1; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHJa8zmYKjvkv3z9Ecw+veAgi3y3AFVSaZTMhkBXftHUIVsBiOpPAGQ6cDXsIHr54A9pE6twQ+6l+tOenwUjopaKEvthgtPfj9i5zpiPiZ5s8dcnrRkuej66+ew6sZFAz7fcRgNqu1fEUYXx8HnuJj4XrQf2xOBY+dYY86St+efwk4ArUisV37StC1BevNAz7YU2WBnfeyKLoq769Erq7rOzm0I+eBFePuSKoFUUe0jdT7mqqUm+AhXWddD6xcI3auzjghWqYxhcpgSX6CbRYTh0JhlTTtQurYUhrtUOmK1gF6ZcEQCgp2+zMdmPLBo2fMCSzo+JjkU2XkSPt7tWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGzjfYjf7XkwK/vuUu5oAb3ik9NxxLrhZvoU45/BYt0=;
 b=srlmwUGOyaWJF50YP6E/XREGrXzpXQvxwTuYeLDKkuhu6zNi1u5K2OvHGDn90p+pqx9MZq6FmnshGk0T0RzfpRta02cA3t/FjrZTsLpIqQQQW6eNyqOKF51ghK/Qtb8Hs8tvZufg7F0Uj/1ZLO26E7wjoPdF97HP0u52gu+03zjMrJLPVGpwUoK/IehMywlfWHJjt8mQRhERko6MsiMRqHR66gY6Bs74+sR75ImvT6bpq0o1JEmMqQMhO6diBVvcqCcRVpkz5X3N+aW05V1ftrb5mzQH+UvU3MlbrRmVxOnJgx4UGamVTWBzD1autCeA8pdOtQKqN61ggHjn/X1pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGzjfYjf7XkwK/vuUu5oAb3ik9NxxLrhZvoU45/BYt0=;
 b=tXtguJw1PsMxAVMZRd0tG4UsSPpHug0d/U89sYN0qJr5VtjDB5GgI7jIhNI2U1GQV2/K1OrszDJLYhZvn5UxrIj9WFwez++dSt44O07ehRtsKa3hns3z9X02r4U37VcGGlMzVYL+hngN/6yAyn4ITAUkWHtixbm6Un97lS3p8OM=
Received: from BN9PR03CA0510.namprd03.prod.outlook.com (2603:10b6:408:130::35)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 09:18:29 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::52) by BN9PR03CA0510.outlook.office365.com
 (2603:10b6:408:130::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:28 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:28 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:26 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v18 17/20] cxl: Avoid dax creation for accelerators
Date: Thu, 18 Sep 2025 10:17:43 +0100
Message-ID: <20250918091746.2034285-18-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 425469cb-9ddd-48c6-3512-08ddf6945483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gK0brPUsLrGvMdcu9NPDMoPZPessfX0nxb/lRJyRMdPBDR2M/wD9F2TzWjAl?=
 =?us-ascii?Q?Si1khx0kVIBhtzyfrAY128pYFsJlgVnX6CxU4zE35ry4Ctjk9x3UPWmPOxjM?=
 =?us-ascii?Q?wQbZ/Dlut0H4RSIodfDcfm7POf804qdQC8TTEB7PbxymcoUgQTA1FWGXMyhL?=
 =?us-ascii?Q?FxkTC8V/nAj0jkj9lw+qA4zi69cpcpQkWMpKsIUgCMUu6s3qaT/SwyUNqcLk?=
 =?us-ascii?Q?kN1n0O6MPsprOx0fN800AAAe0jm9LJ7URq5tPiX+wK1ZJrjuNdomHvKUeMzr?=
 =?us-ascii?Q?aJygg0srT1SzG576K9d5DjC0NgpgmL8v95sp+Cw2t73TP2XNZtpmDCsvaQFA?=
 =?us-ascii?Q?Ec+9fnhcJNyvnzpmq5lBpVS9eqanmLoQ5X6PG64OSw0W+PCcC6FXS/D9o9FN?=
 =?us-ascii?Q?zHtY/KAdIFC2e9+1nuyEs9b0uWZ+TeiQwfEDibsZf7p6ZJK8ZbALCqmTMuVF?=
 =?us-ascii?Q?LJrB4U4V3KHeomvQifi5etPjhTT6/FEoQ885Ei/BNRnXtukcJs7cSq12lQWg?=
 =?us-ascii?Q?VSRpI/CaZbD3G+9CM28S720n6Nj75pi/p50Dhv0EVBP7IS+WsLw+XNz5/F39?=
 =?us-ascii?Q?HpvGztLKkhla8qcmO4eQ+tjJAWPEy5xS7RI23ORV/mLYN12CNfVv1gbB8sJY?=
 =?us-ascii?Q?+Zn2VAlAR27GMcgrLeaacJqT29jyDy1eshNppOYbx0T1QgxA/t2MEJ9pHd5B?=
 =?us-ascii?Q?fQDCFOmoDkq8bael7h6h9Wruh0C3/2QGa/Q2Mx9LW+xlYlmAsepkZbphE9PI?=
 =?us-ascii?Q?A0kSSrgdMdNeK2DFegBthahr13yAYd2uSHYhm1YK9k+ChPIGxBPke1a/CP9U?=
 =?us-ascii?Q?92kWr/HVYq7iNsczj2Dy6hu5cs5R8ng+tRTGqiqHThXmRxPyJW2XlLoDz/Nf?=
 =?us-ascii?Q?6A3x0IIXzj9rCT2pjAY2vbIo3+gwZPfyEEaf9ZNARX24hlwB6p3TtQ7ppqEd?=
 =?us-ascii?Q?w5E8nAxysw+gXlU6R781DmrJcrBssj14Slmz79gRa0ETceUkihseXcaLEB0Z?=
 =?us-ascii?Q?HllB5ZHaHq536hR//OpP/4QbHgGyUYx/P1rnKsICx8T14U63LLobeTNK2in8?=
 =?us-ascii?Q?jj3sS0YuNE7kg0YrJDRG5N5Th5Bd1v239zNYsVPXbpR+umXalWAtWAFdth6p?=
 =?us-ascii?Q?svRgwZb/JOqaEzJvPSfEEiFPJkXMo/50LanmIHEdwvrFR6Hpgg6J8jQLUtIs?=
 =?us-ascii?Q?BQ/nzNIzApBtGmFRdfkKSgo0XkWvLC4FBkfR2YzCxkvv1xNd/VkmXowT0Edx?=
 =?us-ascii?Q?vxNlYmoz8T5ORxtRWg1eSeNf0sMFF0grcuD0EK3vvz2qpUfmxYoxSp1YQAcG?=
 =?us-ascii?Q?mBycXtBGy5m+2b3vVNMO8/oiqG8cIOAFqK7E8h97PrLWzSjl+YjTJ07nOC9N?=
 =?us-ascii?Q?7oN4XQIj+QRBcF62W+00u1hiWqUXFVb3p+zWL18DH08WBlsNAxoJ/PFLTKln?=
 =?us-ascii?Q?w2dK0XVt7439Lm7OAAqk9OJC1w+x9XD/Ja0wZfLfCmC/8hHejTzck52lzK1R?=
 =?us-ascii?Q?RotRP3qQzRKX8b2c+Ge/LgJQ2MA27krOAJuf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:28.9526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425469cb-9ddd-48c6-3512-08ddf6945483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 20bd0c82806c..e39f272dd445 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3922,6 +3922,13 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		rc = devm_cxl_region_edac_register(cxlr);
-- 
2.34.1


