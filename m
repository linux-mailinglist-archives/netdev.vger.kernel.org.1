Return-Path: <netdev+bounces-243798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59ACA77A0
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDCF93154427
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AAC330B2B;
	Fri,  5 Dec 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b1wVT4lS"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F831330322;
	Fri,  5 Dec 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935618; cv=fail; b=eR4laZ1wU3g8I1lHR/+Op4bbPhsSE9ACY3HVUhlrYXLDNk+ofuwYplNum7Tjg8Gov7Xg3jEL1p38O7B5uhqpkfucEYGt3owq/L9oIQahOlVhdhYSafewX3k0zv3nGJV8hwCS+LLXxSk3YjgPchcPj2H+QgBM655dZiKtX4XXnQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935618; c=relaxed/simple;
	bh=NdiH78gXJkJAzid2gcUnZQkAxo8om8SJYmLRXe+E1pA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZJ9rKm61vKI2G9gozpTFaFVRB/CF0yhdQ7COL09wlx4uOYbepqgEu7etdwlf2V0JDe9Mk1l/iGtMo2Mcw4FoPl28SD6wkdMQTTAfY8FgOHHygPtVzrp132nffTBFBUyLGBfg19muJ+y5c7lQK/x1EmYCl6eDPZsK5MmFgLEX6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b1wVT4lS; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGNabkA+qPlX2l8hT/LBOWrPBbCQD5Tmkx7ls0Tplk0T4Gkirvpm4m39k4z3N5eoapB8BK5fmuP5MM0nFjc1hUEIfQtwfilxXwxVlLDVnyp9MRpdGLV5GPBhDRkZbPTybxvTLf3zhv/d0LTxYtRZZF786muEdotQnQ0OtaqQkdgd5I+G84OICv6/8/WbwJyHItuF3tVu3ebfkdO+9cO2yyxdMBOvPJsyPDMdEBwltgATw7dM0aaED+9QzaJwrxmjpzSqYzGpaJLp71PrBLaZRiNT5CmhE8d6LdDRZ2seE5iBmQDWuraBAt6+a+Q/yYa4G6adnL7YcL8A++aDKJNZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW3ANAYqvEoV0sA4dxPUE9mSTNsRp+pzF7Cvi5akQd0=;
 b=aU3ECtEAN6ujBqkInvi0pqvLG+wnMmztL9kWYO0Sjee1dUKAhOsyGzJg2FuEscDQlutGFTnjfsDJZw+ChPT1eYF2Xy7uSUEY0mMDDTg5Eqz0N0hD3Rozcv8PRLAhOlpTbmUhlzr1klaad/gQUCsVGMTwIj+cE4yTv2ke4QVnBzbWCsOVe4BPbbygrPEJry892wTh+cvckU8XSqbTtzQU86q2wsui/xWIcbR3v9VMiqyNUoRZSi3QMLk/SAhJu/KBaku9hnCEPDc+CnPyiIa9MQMmVqZrGzggAjj7zCg4S6cZTcziuY3ytjss3+dlf/yaM3nDARcrpf/WP27e7lq3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW3ANAYqvEoV0sA4dxPUE9mSTNsRp+pzF7Cvi5akQd0=;
 b=b1wVT4lSzju4djLZSR4sWAunPUepc0B9hLw6pjcqZdPkXg5bX3M4iMkbuYqVcxSlYmS2e/7iSeGzjgnmKRiUE5LA8b92Hg2Tln0iMcX84ayh/jtyJjODLDBO7LlpPcTmWaQb36m30/F3gkjbncptiTaInkhy2imx8uM9vkVvoSE=
Received: from SN1PR12CA0054.namprd12.prod.outlook.com (2603:10b6:802:20::25)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Fri, 5 Dec
 2025 11:53:27 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::7f) by SN1PR12CA0054.outlook.office365.com
 (2603:10b6:802:20::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:26 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:24 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v22 19/25] cxl: Make region type based on endpoint type
Date: Fri, 5 Dec 2025 11:52:42 +0000
Message-ID: <20251205115248.772945-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a7a3bd-84f2-4b88-6ff8-08de33f4e6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPztO+Z3KELXKj1TxAt0zTFFnz2xrYHZSlrwLV6GAaDBnZSFXYJYcCuOiPu6?=
 =?us-ascii?Q?vw4Cf6yQLoxFE8+9zyxpkaUVYCGQdvvS2aOUn9I/lt69T5rsAvZUeOoaTNT3?=
 =?us-ascii?Q?/2pkWfSg23OlGZRfxSC3CLQuITWiIGs/1LMYyN52ODDlHCVab55ee1gkHhqI?=
 =?us-ascii?Q?X7vSfJfDDMHxeQ+4ph54oqpY4rZ58r9WAJv1vikdjzx2RSl9YMfEiKxFMbx6?=
 =?us-ascii?Q?ypeSJn02QJ67Z1Fp1TJ8EBgrVCuhf1/mWV443OJ/IWGpFDryegRaZsruNwN5?=
 =?us-ascii?Q?tBdivDVeEfnFxeqRhoSXCkLIIMGR/DCYDojHsnpkDjcCmKXEKu4iDpaRFRuX?=
 =?us-ascii?Q?lkdZaHjTlQWUUPXN0XKCBkXXc4ePPGhbd5BSbV+/gBgX4NzE0SBAsVfwK8LB?=
 =?us-ascii?Q?P/DvyiFNzdO/BJrEdxGVXqagekTf/p8lHn8Cp7uaEtvkGqBnIIJ38MxiLQ4l?=
 =?us-ascii?Q?L5G6bbkujDDcCY6Br1gA0VcSrEkX1fX+K2/7qqp+P/O84Cmh9j97jue/c+Lj?=
 =?us-ascii?Q?f6NIu/uNvX9WIhTdpDI7dQg1K85l4zLkGy3VhBXMW0T+hH+CJO1vJincLguy?=
 =?us-ascii?Q?yefFEDD0NTmAU3DYnUtpHH1tfaVMPBha0g3Co15p2SjOfoPlU0HdsW2Gsl9J?=
 =?us-ascii?Q?gUefQ5DTtzByornsVn7x/0VFNXQdQ5BPy79Z0mi6SfU0t8Ca4Enkn64HKIu3?=
 =?us-ascii?Q?wZyrNsmO2dvWuiTJ6Z2GocSp1v+CRGajSPhpIRJYYOaKd3mKGkysFkWuj4zi?=
 =?us-ascii?Q?v1NRZZWsFmqpNJeIQ1tlwuIJtc3A3IYhCdfFxh94end/4cn5NmzDTyqnvgrD?=
 =?us-ascii?Q?PsZHV+FD5HoiGovMiQg8VQyP4/OZXzixecjgdp/ETRWThqCW9B4FSBsTVq+W?=
 =?us-ascii?Q?pxUmr9MhCFEUHfKTaBzXy93BGGrANoLMg2sH8fLykUh9StsxvCmQEjXk1tkt?=
 =?us-ascii?Q?KNL+6R3g1sI00uwCHDUJjfxZFKp7++3KYzB4jbUnZHBd+q7yXPzPkSQ1q2jG?=
 =?us-ascii?Q?KULPwcMKaA8uwOX5A0AWsImScdXh1fDT6qW8KcF7BjOSDMSko2huJ1/IRG0B?=
 =?us-ascii?Q?GjaB13lw2TvEHvHbGQGwEmJhNdOa10AjpE+VPbdr0JGfYHKfrw9DUQhs+GQQ?=
 =?us-ascii?Q?wYYQ1VoUoLDz4STM7J6kseYGqB35bOld6S5Rzg0WcFws+FA/qREeF/mDPwZJ?=
 =?us-ascii?Q?SnoAQs5SN9ycXUSkfFd5akgEr2YIl1KuC+A85ykogzTvZxON4eNkl2RD0kKY?=
 =?us-ascii?Q?I0GPTpIGXBly+kgAX/thRwy0l5CcRCwsengsoVbLni7knnP8qA20skDbc1Ip?=
 =?us-ascii?Q?bPKXn9S+dyfHT88gL29yICF67IWpRpDcp7nKPSlYJnOm83RomMZDHn37MfyW?=
 =?us-ascii?Q?FIl4O0ZavM54ZhPnoilDRM1ZQG/uGDzFpyVKkmc0qx9CJdX2p/dRdTo5vBzo?=
 =?us-ascii?Q?+RhkXZ56RFsZ51MeT2IH7vkZZgOLGroiH7Igqv9Juu4Au2SLa1fZ1m5g64kg?=
 =?us-ascii?Q?fVKvoJAYNyed610/Cy0wXq2ZhWG/dEUzVwACL8voipoMNedOvURpx9+tw1cd?=
 =?us-ascii?Q?O/oMDBbAUBwgkOiAu4k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:26.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7a3bd-84f2-4b88-6ff8-08de33f4e6c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index be2b78fd6ee9..9aeee87e647e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2783,7 +2783,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2805,7 +2806,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2819,7 +2820,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3713,7 +3714,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


