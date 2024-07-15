Return-Path: <netdev+bounces-111572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4B393194B
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293D11F2292C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66717753;
	Mon, 15 Jul 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IRsVo9Cr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CA446D1;
	Mon, 15 Jul 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064545; cv=fail; b=eIp0Yoc/GuxTqTx5zxYhSDfaYnJfA+Z4ktcY+S2brfaxPg4bP/fK0bv0G1KxIGXsJtbXhaO9g7SEETD8oXzHPQt7w6brnd+tnnvM0DwbzcXkpJ2XWzFXNim/0fcZXwXejphq1CuZza8lv97isUx9BpUVBtB481O5VXcGt/SLbbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064545; c=relaxed/simple;
	bh=FOW6J+oQinweZYW2Y3V1Roo+XlJheeLT/W5x4VsppN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j09qdy4v7MFM4TxhPDMQv6L1FMLRxTVN1adV4CVv/wU4l/8VD+7jZy8Ofd8TJp4N4X+M71RwB2Hd1nPHZ5lCHMQd/K+nyRx4x2sayl96zBz3jIGAfL2mlsDblBG6Q/hXzgWdXAFkEoWlav7d6ZchAMFaNEP1Ca6+BMQO2WybMYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IRsVo9Cr; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdBWpCKSDQ2PzVkhlp8SEEtgtUL6cuOkk1ajcGMQLLC+QUql7vHgCQ6er4WpJTqwKNMiTsPrRQZ1OrQ4Wz7fg8FgeerfelV2nD3sLbSwwfLSWwt3HJ8ncU9Kjqzuw4qI7GozBff7PW8W5M4ik+BsLRf9cEBVPKT8vfeFNI72JjKPsH8EZiiYvXg3nRPrvmm8h4yGe5EK4Hv7qpZHpLnz6T0wOLbyzuylmGLlYwYXrrELpMfMJmSYfEuYCSV61QIDXkvqO5/mZnDlIV90KvTl7z6NRclRZWMLP+L2v18vNj9IinVIDy90kk+PDggIXgAIfoX4ju/bw/U39mt1s43W4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6htK/OoKboLNfKt5yS2v8d8VTCpFP6cnDFWCkr4RKAo=;
 b=PUTCogWtz8pnaOUNGdRJ/Sm9/KedngR/neWGC6d33qW6to6fMlvtqzfwjyiRr1KRdkVTWkfd3yrUDohY1akP4N17nZgIUMBgk4wkkasYosVSgvhNMKi/+gCglIblH9JmMmuKJ6Sd+J/5gGlZDLowZls04F/0YrLuQgh1Y4GlrY8zqu/hnVg/CVhSCH/TsCm9BO89fblc0EoUCE/MDuzoxQmcdpl8rUmLeaR/wDeaZnNSbxuc+pO+FQdNKmexmJ6hUdbBsS26mQGq3gDvZDSBqXd/d3cEcjN3mpFr9SSp5b6dYY+jo/th5Ya1b7Mp377cWzyWO0kQ1vjXBw0eMyLIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6htK/OoKboLNfKt5yS2v8d8VTCpFP6cnDFWCkr4RKAo=;
 b=IRsVo9CrVNsZh6tvBHLUWI8eugZpVm2PGVuPaYY44u45DLJLTy4cZGvFcci/Co6bhSwNjyOCyMXeh+ITB02PlGgIU645thiPTxwu5RX2Y9acyRI+fkZRfdzhQJqXsFIK+OHjuAp4OLPa07l1bCyXvXiYGPIEbFIjkhGpXwWWqt0=
Received: from CY8PR12CA0044.namprd12.prod.outlook.com (2603:10b6:930:49::10)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 17:29:00 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::7b) by CY8PR12CA0044.outlook.office365.com
 (2603:10b6:930:49::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:59 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:57 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 11/15] cxl: make region type based on endpoint type
Date: Mon, 15 Jul 2024 18:28:31 +0100
Message-ID: <20240715172835.24757-12-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 224f4914-48d6-4966-09ee-08dca4f39d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q4z2NQyT/YXkftEo6LAGc/zB7cQfQr+WU57LOrar8E4iLPXd980nAiobm2fm?=
 =?us-ascii?Q?4Wmn/6H2xM0wCpfkhtDUHgDRrpXMjt260Q11sSa06dZWdheqE/9e0lA02YTy?=
 =?us-ascii?Q?AQIAnomUeY9IENz61ITl5udFyMgy3mUR2nN4yGoHN6ht9JIpq6HSsACcOTth?=
 =?us-ascii?Q?EmIS3fvHRCDlitgHu+cOM9UgKn4G8xBoM4khpEh69GYxYz00CtZa3REU7yO1?=
 =?us-ascii?Q?dYB7xGbGTuQdnK604CbO4Oz0SX8mFUCi/VlUCQHWprgPpqXUX63NE4xKibam?=
 =?us-ascii?Q?npRbg8NcvqrYJ0CdE0Fk8jOgS62oDmQBpgYhbvH6Q9XNPsW8CfpMqyOaMTPk?=
 =?us-ascii?Q?9VfStoei0ok53SSD6mch/AD+V9rFAZFGQjIAton/5euCoJYXOBLyFYOc4xhm?=
 =?us-ascii?Q?Tvpyh3oc77U28mA330UL1lDa3SmZHo6Ng/oTochaPrnfwry2DyOdjsUCzhCx?=
 =?us-ascii?Q?nJYnk0pmQW7EXIWwUeDaToKGr8fiD5dKUrjZJDetno6XehdMQZ0HQzSm9Dr9?=
 =?us-ascii?Q?N2bnJSoAVyJWVePVrCk+0g+YarAj+G9TpAe/pdmyGVm42QQwLODB67+rA9g/?=
 =?us-ascii?Q?GBMprtpb5zG20suWHUqcfYKFr59Y2bRDLoXXGbDlhewS8uRqYmcuRADmleyU?=
 =?us-ascii?Q?hdqvDGBlNkPYlMlj9kDuuMVuqmlxZFp0E9+xgM1ZAKCxzy6lMmt3Ml3VwJk4?=
 =?us-ascii?Q?UdlmVzkqiLz/cm14KRFC/LuHPZI97K2+xRxQi1FF0br9IRPU+9ezQMbXXBD3?=
 =?us-ascii?Q?fBWrMP/qddk+2oyyTVm6vJvCuY9d3kXvcyn59ZnldU6ekoD21fm+IWTVX64J?=
 =?us-ascii?Q?1LG6JM8GbFcXs0lOM3z5THAWBgZBcJ0ugxwjpDdboEG0HtJH8Z2i8gGRzzYB?=
 =?us-ascii?Q?Z8INoGGhIcWpqwb5P4vJUK1iPfNzW4SThw5hc3TsZZ24RfKYsK3WgpgZuV8H?=
 =?us-ascii?Q?s1GX9z6G8w/GFk8cNPjK1R04k58M+pcJKtdZJaGFQO1Zoy2hWSGwZsjVgVOE?=
 =?us-ascii?Q?wjKh1kUcZhmj+HrpbVdguKADj//UuJt+e59EtmDXGTCIzy8ADRmEX6i/VGaF?=
 =?us-ascii?Q?M9Uh92KBVaVoy4TDGjqCDT8GOHP+RSQc/AefV2Lsert82QO93vz5nh+/8iD8?=
 =?us-ascii?Q?bz/7Zbx41bbaBDRPIn42W4YW8gM+7Pi9OZWjTb5PMD9cAl/OMazwuEHP9ZMO?=
 =?us-ascii?Q?2jebwk7MtJBhEl/+m1FtjAt1wdG1kjoH9u8suOsK2J9dIkQon8x6Hbs/dMo/?=
 =?us-ascii?Q?sefaGvO7+ov4x1Myvjf2ND8wKfB9SNkD5YwYfcOZVQ5ssZl32GXn43wIW9/t?=
 =?us-ascii?Q?CvAgemtISaQuPj3RavReI2MIy2q/kDTnU5xR48VHPtPbdDJG+O21SoOYP1Bu?=
 =?us-ascii?Q?p4hrryhQ4LbQwBcHgYki4VXegduESLZ7UXxCCdqD/TqU+OOaWWfHBGL0nKCG?=
 =?us-ascii?Q?fk3P5PodDoiaGVbqogq4XN5BvPvLIdSepfFT085wM27UFoorYA1cAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:59.8714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224f4914-48d6-4966-09ee-08dca4f39d21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Suport for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ca464bfef77b..5cc71b8868bc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2645,7 +2645,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2667,7 +2668,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
@@ -2682,7 +2683,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2702,7 +2704,8 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3364,7 +3367,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


