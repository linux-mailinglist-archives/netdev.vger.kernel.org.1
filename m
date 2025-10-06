Return-Path: <netdev+bounces-227929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4174BBD95A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F9D18969A7
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B85223DEF;
	Mon,  6 Oct 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NNpVvgSb"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A78221F2D;
	Mon,  6 Oct 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745046; cv=fail; b=a/bNQKV5NFwCFxuWda7NsI3sihKz3P7fkAU+EMFMSSsCdMfft1AjuYDCQb0IVWO72Pi9KDU9xu3IBi51QdNhR/+/Fh1s6zicWgXwadC2oy440PQXe6bMhS6RySsh2a36gQuudgG7UMeoenY2jyeZ2G1StdckjDRDcllMb8XRxlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745046; c=relaxed/simple;
	bh=v7IUv5x3vglkcXsdUTyxZkHBSWr7tb6+E8vq9S0BcoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/TnkfUbPdRM56xchTBvMmLxQCO3UTUglx9UWPuGgbIfxl+8KIPgMU006GMI44+q5VisO/jikpPB7B+Qu8/j9NK0XMApGxDLwtQKYXgMoFB/4rakpoIkAT0RNjT0mrePcFEGVUPZxB+uz4rIXhFh6Mp+4eytEjDjV1AW10jmdW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NNpVvgSb; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGaW4/qanbtTOq/d238KGG9OCJy9bzUn4j8ZFOtv6my0gmv+fqU6teLyMbtRAsjZwsqW2JKIqSV499q1OLIHmQyZWiciwazcWQulJFEA0Tk0HHQsRtzDLiW/Y2bjhkoBwDHZI54OFKxCh0Sr0oU2/C7SDm5gM8bLP9IghPjiIwIevf/eYYYEUgLWaoafWTg9fIEy9VN1dzXT2W08TcgLO/kjCb0nGpoccEKseM3qub0WPUhxZgw4zkBXUjCBZgxcgapJoZgPwe2iKNeic+dzHFTa4yMUcCYaI4MBkrN9x9GH3IFjWMttgZBpmhlHqcbUGAfxyluuiPRSvl/+0dCh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DomqOMdqOCgFEG9NYEWAhvfib293cfw/MfoRmWWXvmI=;
 b=LWFN59PdBPGM5uTzE8Enr450xL6IxnY/bnJzode2UGj4Owh+PPMcGSmiVOLyUW/D2+3FDb49MaHMZ+Xc07QupJ0/WJro1niGOardeBQBeV7xsxcnbAsPvFnMI3TK3pNOqN2if59zxYwSQoxrfHeZD1WOsHaNjqtRwQam29jMtzv+Pm9/b93TqcbQpjST9pEJNnmbW8BWFV33pPBysDRQcB2BYm6avgc6IC5UHOjPdinJYO26tQwt8jDg7/y7Ep4KM23cEPCekKU2G2vXp+4WDNq8UywunRSs4e2jMwLUtDFaxKSW7xARSzABzw00cViKswUiMRT/T/h+BkAe0/ZNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DomqOMdqOCgFEG9NYEWAhvfib293cfw/MfoRmWWXvmI=;
 b=NNpVvgSboeJ/U4oe4idxO0XicxwUwJ+QRCebryBjq0vuDqk6TX9QDvzOqvcSbBOE9Vn5kv3sg4D3hF3qzCDcaevUglbjJXF9hG7xVMSdshWPu5ze+iYJOLLJ4Uoa0yWTnsWh829ZMSTTb+D1IgWKb6PtENPvSzeLoUw6AeAtykA=
Received: from CH0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:610:cc::11)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:03:57 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::6c) by CH0PR03CA0066.outlook.office365.com
 (2603:10b6:610:cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:38 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:38 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:37 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v19 19/22] cxl: Avoid dax creation for accelerators
Date: Mon, 6 Oct 2025 11:01:27 +0100
Message-ID: <20251006100130.2623388-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a7ecf9-cefd-4085-5ae2-08de04bfaa38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBRE0qe0swurEQfeNql4CIhTxYXE7RQIAti2VNth+74oYclcO5fDz132+Pwi?=
 =?us-ascii?Q?pV3PQNcFeN4ASkWQkDAyKbyDJTNqdPpyAfYOsP5jjrtyhNuE/D4FHnKG07bQ?=
 =?us-ascii?Q?rKCktFJLzvejG/xxGJVWK+qp3SYxv69J0gpvMAnQ0DoHgMUztDQ/LFwo2w03?=
 =?us-ascii?Q?eBqojKR76YVY1v50V8RLwgEHyFSmOl1riMdekBe8E95k5TErSurIwnwkQwtj?=
 =?us-ascii?Q?JELaj5lLn2vjDLeKiIXjMRF+aC9jVrAyA1cyw3zfm/HLb8AqMwVdlPzRgYG7?=
 =?us-ascii?Q?pFfus/a/G27EcuqTZgO24TjBo9VvLTiMu7ngLkZkUVqoRIXmw4va0r2F/eyM?=
 =?us-ascii?Q?1v6eYWR+WuGpMLbnPmQkm9hDRMDl0IF4tHzglT2Nnalx3OYoLXgr9uoslMHz?=
 =?us-ascii?Q?R4fCzG266HQnAk8eAMgtNX/3in5zQIyGR4TJ8QT7AkmaL4xCLEPQFkP3ADSx?=
 =?us-ascii?Q?mFkmcEtsbCQdB9DkNwNvXUEI/T7figEEf3pS/nnb2rEfF28ePmNNBIYDRcf2?=
 =?us-ascii?Q?Gl23JxYOXt3m7OXywvMrESr0iKklfOnuR6kq6S0zfZQFGGTDmx1kQXxUwC1q?=
 =?us-ascii?Q?IdHJrvL/v/1Zb/VrnTp9jnywn0QacupL8NDSGxOFXlPLKoPkUKgXlPqcaq6/?=
 =?us-ascii?Q?bm50RrEzexJeWQlFjLTQn5oaOGnIrG5QG+JsUs22mWpBGuZrb2tSj0lMTXfI?=
 =?us-ascii?Q?KoypvSe5eX2t/uuHX4uOuSBnjfLxedmo/0EBuIUngzXs4VXmq49p1SpQIJJX?=
 =?us-ascii?Q?THN4Jf+l6O+0zZxFZlK9w8s9r0XSS2LEjlC4OHPaeKrZs346DuqA87mv2r2N?=
 =?us-ascii?Q?GSwHnw297z3EHwJ6lAkrlPN5cb90ZTT1k+J0fwa0tDVtJf2giL6tLdI0quUl?=
 =?us-ascii?Q?Kab1b1CWY1BwmztPJVaX11sLhFG0JQ7Wds0HoE9fvSnIUci3x7nM1t0jf2eJ?=
 =?us-ascii?Q?0mr36InHCiZurPnfVVUzNtm3Qv23yTVgaC6NOgWaWnDzOUBfsD8jXfJg3mkO?=
 =?us-ascii?Q?smPFI/U26DqKcHcF6kC86C42ClYDBIVnL5LT/hv55Ps2NuwfQIeV9E9lv7iT?=
 =?us-ascii?Q?9uJS/Gcg+So9461Ytbca0SXE88rYcCZbmFL8ziqR1J/wMVZYGOci4orzUwDH?=
 =?us-ascii?Q?CxKzFD3MWvoQCsRTjuZXcU79QbUbXiUry2L+29nWaunHDY4PQkchcN3TuLLW?=
 =?us-ascii?Q?ehRW6EMczMt7hdDeQ606GrDvBd1SqgO9rXry2GXNn52BGhw4VWj9DI7BQI3Z?=
 =?us-ascii?Q?izi3bpLnIIjtQr1ssYYXfOhMhFDRjTws0hV2YluUXp455WTQYI2vJGE9j87o?=
 =?us-ascii?Q?8coT2sY7MAQdeREEgkpDqCV28P5NJlz8n1ldD561u6n9LeIrs768GtSJ8Tir?=
 =?us-ascii?Q?Ank1iWuhnnInTBaZ2xz6V5SC1jQ4ipi3KzfkZVU3nV0inqIjX0MlQiGgORze?=
 =?us-ascii?Q?BWOmO+59s9UiLiZG1IXH10FGro9evX5nAabzuNusEjpHXhWtgDM1J2e41QFq?=
 =?us-ascii?Q?XHYZMQB90Dd3ta9ge6DWTTyLr9c+WD6TnmNCWSPTSA/CSEcDMIAZLn/1DpS1?=
 =?us-ascii?Q?Sjs1N5dPlE8x55cZHcg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:57.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a7ecf9-cefd-4085-5ae2-08de04bfaa38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e3b6d85cd43e..05f0b77aa229 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3898,6 +3898,13 @@ static int cxl_region_probe(struct device *dev)
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


