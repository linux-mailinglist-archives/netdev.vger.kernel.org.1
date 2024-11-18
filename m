Return-Path: <netdev+bounces-145961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B699D15B4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03E71F22EED
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789C1C8781;
	Mon, 18 Nov 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BnGduYIf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3F1C82F4;
	Mon, 18 Nov 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948327; cv=fail; b=i2+ep6I0pz0U5fuduMciZzk6cK/6FP6DhyIhCZLdTp2H+izgGuTZT1cmrUV0ANbf26tEu3/eZy9VqWN+BgrlNKW7tMyCyVXdFPkJj4BUZ2pY+id5leDCKCnt+M/R4d2WIJjMKPtc0VajH5IRlE0J8f+cC42lx+2DgiZ9SYKZ/So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948327; c=relaxed/simple;
	bh=fReNXSoQIhOotVmzMP9hEsG+jVGK9sb0NysQSU1fqHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reAD64HQ8WMXE21EzVDnTpGSZZQMtwbJtKwQrzJBXMHhCZfBu697OpAWYmg3pAglryQlymHz3EOB8Ywo5rroiM1Mj7LacDbfupCUPjEe7pfB+RNKg4rebFmzz4OIK22z2sTdO5Np1GbPSORfOjWb8cfwnCXt6ihtn5zdFB0Vgi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BnGduYIf; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWxjCZ291WEvGGhwN+Zz6f5dnEqYtAkgwxf6czhdfNcQ6mtARqKYMCH8HLeeGdcgwAcXjZ1bQBvjPIeX+lfjnsaYrn0kccVm6T6XpvCiVe5uGMCoLasX4sOAsUtPzlDHWpyWuptY6OS3PTK734JXprUg5AxTatu+w62EIzZXLG6ptgRG8CPyw2Nq4V8LEL9LBa+OwUUS8fEcABpS6hv0+75lsMoiajZ9JxuXtSDIVGMZ53Xic2P5pgFJ68+dHmh2Ue+LIdOo/Q5TOY9JALVC6rls2p3g/5k8sIK+kYy13qIjcvUqv+rMdc18rRYcqqkAJNnzjbYtJZ/1Eat07Ow9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiEF7VdWg9RxbC+/oHpCvz61w1eYxsnC7HExr21FY/4=;
 b=OaAaaSy2uQ3AnpnFzoqsBoW6n7L/SIqvIkbqoT2ONxNM0IG0HqLzCW6+AMOdU1iBSWQZWk/8KExvbfxIpvRmAs4ZEG9wd1Jw/MssFmOfcIZPDmpuRLMPURSzoPhxs5kuJzm7qZ+DNjdSzdISQEnqJ1di2sOjCbNUcmPN/zfb8T0BLEN7dhGFbh9Tu4dwESdUGJNfLlSX5j8Sw1UVut43TDgIRlIpNMsBgFixVPHLlVGFi2Jc9CUf+PVCN1oVm/uvs0oPbrRHv0IMgMgY9Igt/2GnEnruPYz+m7ES5f5gBdaPm3iIUlWqeXwg8VrO49pn+yCxg4NZ/KvdY8Ip/y+P6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiEF7VdWg9RxbC+/oHpCvz61w1eYxsnC7HExr21FY/4=;
 b=BnGduYIfsaJBlYW0+ObIZsbTSn0APo4McYzmb9encE8+DCBj93ZpKlkyqNN82YKC4rT10ChlHvzJ/og2aRYrnzUoYrHGCC0adVJV4VaXynKTJ+qEgcgx9VtFt1FpFE+uRL8Q00PKysAPT7QTcrfUZ2fKd7ABQzdIlHUBzh5lG6E=
Received: from BYAPR06CA0070.namprd06.prod.outlook.com (2603:10b6:a03:14b::47)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:21 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::59) by BYAPR06CA0070.outlook.office365.com
 (2603:10b6:a03:14b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:17 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:16 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 24/27] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 18 Nov 2024 16:44:31 +0000
Message-ID: <20241118164434.7551-25-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ec073c-84ac-44f9-0b56-08dd07f06401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hb1kDgzUiXGvXEWK/D6vY7KfIlWWD2CYIqiP0dCJbN+GvZHSO+LDA9JDcjP0?=
 =?us-ascii?Q?F7W2pQKlPj2dpIJvNMf48l1rpG9ZP/eSMez+XVETRawGQ1jCAfyCNZmfomMM?=
 =?us-ascii?Q?pxbxLffTJqXNrLsWh6AJVz53JatSdJBxVUz38icvxFyu32KuNnFjMOLPvnW0?=
 =?us-ascii?Q?RRD/IScYNikwvsyZYknCMg4PdwDXwdoEUdQUu+1RlNiqv0MX9VNOgeZNjx3Y?=
 =?us-ascii?Q?Yw0+ioQEI6uh/MOPrLykzyntNaXdoeUZyHcPS/3hKFWy01Xz+m6Kp9DXv5eX?=
 =?us-ascii?Q?P6pulzPs6BYSzYYsnAaRwKzbKKuOjtv5zuz7GzFqtIT4Qo9NresaQ08LArOb?=
 =?us-ascii?Q?hR4whx+kj1/xcrQqmn2Kmyxe50FU8x5et8h0Co81aytB/21Oq5hya4wCKLaI?=
 =?us-ascii?Q?IigQ8TS1dyi0/0DR9Xmmephcy+t9H4KLc6KiY89TQTcnvFykeJHMwGc7HA2i?=
 =?us-ascii?Q?paQsBl6bulZCF28/Re464PPNu2JOzsMjcaZC7Z/VNgS5PtcuNbJdqAE5S53U?=
 =?us-ascii?Q?QuxNpquapihGBlUllA5l2ohS/phrdQksz6kJBfTHCYOp5wW3m3wy6IX0FtTK?=
 =?us-ascii?Q?Kx3WK5LrfpmS4cxrhCxNAxLvKw4wJrB13W5gv2CBffdNKuf1tLuFeLG321bS?=
 =?us-ascii?Q?O2yt3WRbf5ZhDIIqZsHRmZbx0d3Ua2xmflddM4JkvTMkwAEw+5s9Rzf8FWN2?=
 =?us-ascii?Q?jT3HagrdCbMOXqhhEOHCNRuaplUwHyE9Mmu985+PVeqPqO4NztFHQWKCeJyC?=
 =?us-ascii?Q?oEl1WFN2rvyt9XjhaaTW1XxUMy+74QIc+OuL9kIY1nuSk10QKAoZWPNr25VI?=
 =?us-ascii?Q?V8dF8vJZJ9EbWlNJppzQtvf02iEuEFVAmKlwSAYIFcswBMXSI9B2XEq/pwo+?=
 =?us-ascii?Q?jtL3RC93wlQrICqosBJoOrYCczXrST/eailQpFwQdVFMM1/tC1O4p5IrhPw2?=
 =?us-ascii?Q?Y7XH8y+PGojb25LwhghEZTDnWmA3NzXVuxKBxReymmmLgG47gDGAGgVBu0oO?=
 =?us-ascii?Q?fUKW3WBkkfuWnOCwhWwST6ej0XhyMSkG0Gt26N59Z2zlb9qy6YbRDFPN73jw?=
 =?us-ascii?Q?73NrjvgmQRn7iyJZcJTblM8B2S1dmM07NapgIdAquMpq+S0RmF3Xn0Ixdcku?=
 =?us-ascii?Q?dFQ+z6p6cm+Oe9TdMh+wJhK74RPveCTAzxekPFfqiQyMkMwcw4IwLC1/WEB0?=
 =?us-ascii?Q?Ew8dtDr3WATK2FbVY4HV3bhFislwcfIHIHmDm7AirWRH0rkkdIBMXaXon8eJ?=
 =?us-ascii?Q?u5cccNq+Tew6GLXqZ+ekENCe+vCwyDAbeocXCShYoGKyN5fMQPvk8vYC+hC1?=
 =?us-ascii?Q?1J4JVaoQ6XDJ3CQ/qkFhd7CzgmO4xIYa/a6ClVoTgYIefSzux2B02ldQ1aGS?=
 =?us-ascii?Q?wCRblqx79zNAZOGEfXrIgxDFGKVlBooQnHmw4C21POppmnZhrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:20.5938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ec073c-84ac-44f9-0b56-08dd07f06401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 drivers/cxl/cxlmem.h      |  3 ++-
 include/cxl/cxl.h         |  3 ++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 70549d42c2e3..eff3ad788077 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3558,7 +3558,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled)
+				     struct cxl_endpoint_decoder *cxled,
+				     bool avoid_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3574,6 +3575,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		drop_region(cxlr);
 		return ERR_PTR(-ENODEV);
 	}
+
+	if (avoid_dax)
+		set_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
@@ -3713,6 +3718,9 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_DECODER_RAM:
+		if (test_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags))
+			return 0;
+
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1e0e797b9303..ee3385db5663 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -512,6 +512,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_AVOID_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9d874f1cb3bf..cc2e2a295f3d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -875,5 +875,6 @@ struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled);
+				     struct cxl_endpoint_decoder *cxled,
+				     bool avoid_dax);
 #endif /* __CXL_MEM_H__ */
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index d295af4f5f9e..2a8ebabfc1dd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -73,7 +73,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled);
+				     struct cxl_endpoint_decoder *cxled,
+				     bool avoid_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


