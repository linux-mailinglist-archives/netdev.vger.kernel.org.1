Return-Path: <netdev+bounces-148177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D49E099A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B8228278C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D181DED4B;
	Mon,  2 Dec 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o+FPZ1Fl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4B1DED40;
	Mon,  2 Dec 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159593; cv=fail; b=j/41gFKTyKc0vNjmDqnrlzM869RLKRtF4jE614kdu85/jiG2YY943G969ZigrTY9sHjnHxC0IC4INfNJAYu+crx4d0uLtuklIVn/U0jv32fxoPCupBRxyhaEoVQSUSJHEC6EN5jIl9POyTjMV7g8kNmDvOwPvRXBSthfQOG92MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159593; c=relaxed/simple;
	bh=3KjuV3rirr+p05+cSyy5LDZDgtRmkwehhcsprRnZsgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFSLqwJqAzWk9wwu3I+oYK8F2QTECByWNlhguhY0dw1rfeORw7p8oChY+HAURkimRKgn9H3v6cTGN+4J11r7TxcqnUR1Cw63mkmOfEOTnnqvl34XKOCQPDHR4NiwR0MyYwmplJ3G+btstp2HRwwIhvWjoi4dBRBQPsHshLjVBDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o+FPZ1Fl; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beA6POsz0tqTD7cC56O+CzejEDKKJPpxnKaI0Ev1wG8dVrakaP28deBxGzt1Wc/W0hnWi3/n9GoKqoNTBiVEuEsmFyPtWk4+vTmDbV3U4oFYm9yLDO3e8vtUCN5dEHhXYP6ErT2wdeXdRzpFPX3t9h/OfKFvV6xct8Z9JjZ+asu3VHx2pxrJipUKy7SyLczGT5yPojeYmxRxjmX+rFyCJASr6lqdYwtqBb/rSAopSt3dYHM0jx2FKK+Czutlj/ASAuwos8LrRBWE8FuRZwRuyEDlLRyltM1ZVxMgKVIszkikIunDCltbCl8wdyKAkWlLNV617jHiPhIX7ZrSZ87whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRZ3z98mcoTfn10m5OsjngYjtLrLilbDSn+CP5pSe8w=;
 b=mjdZ+EqEbKhH3n7+DcSNX7rH3QIuNKxArWrn2DpfPLxSjgOSkn/wy5jLDACqnjwx+hvuTid5Z/Al4QnYbPTWWGF2oLq34uJmN5RR8vqnsYmQgSZ0ClN1jF41QLlT+Dq34isgUlUJ5fKLeEnQFd0X/mCDpvvCMvN/W+HqMP9k59pdbSJgYdtCNOm8JPaJYsDf0GmTdwAsVg7nwnxMBXEQYj1YfswVX7hhFjSFLmzY5upO5AgV8MiUBJoFZAVvqd4URoijnVSPzpXnNnaGX3vLeWpuy7HIH8XxUclRzN4RoIJmkgRlbga7TchSjVZpQFxlzKjwNy2dT2i92FWFeuwCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRZ3z98mcoTfn10m5OsjngYjtLrLilbDSn+CP5pSe8w=;
 b=o+FPZ1FlMjdc7E2nUd+y86OMw9f303kcDH9ns2ucqTi0awmRTP+ocE3sohupLDTRRtTh/a2Ai5Gh7Lxm5XTSP2gxaOKJMFq3NK00CztFqhqfXkdTtujz727DtGwspqcOi2TgnosbnIQYSNxP0M5/l6GRqSfuuxLvoflCja1Pad8=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:13:05 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::3f) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:00 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:59 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 19/28] cxl: make region type based on endpoint type
Date: Mon, 2 Dec 2024 17:12:13 +0000
Message-ID: <20241202171222.62595-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 44896918-b2b5-41e1-62ed-08dd12f4955d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9M/nEOErt7gPqCc64SGXCRakT+JOXJ4Th1+WOyHD7oaEbpG0UA1CCmmERc8?=
 =?us-ascii?Q?Bph83Jj9nbaNn8hn83j3Wup4pqH0ErxQ8GSEVIvMn5jmdLmJbKjOxzj+vQrA?=
 =?us-ascii?Q?ngSl3quT0iES8JZzmwZvUH8ioycvnPnTPQycKOdlDV5qmlnrDmbxdepPtNLC?=
 =?us-ascii?Q?BRxJ7P/eM61K0j5gIT66x/JrIdSaDylAXICRqiLPbIIr5TpRlSOrQTLu9KE9?=
 =?us-ascii?Q?4bRHndLrG4pETktc7egeQ5WY3MMDbqwHIwZd47Fr4wjTStPmScmK8rQqKW+h?=
 =?us-ascii?Q?umC2sWeg+YFrLGqvMdH2mXle7swWmkSB519sWVFcxa7hxZ0IC1XuPsBhPDO6?=
 =?us-ascii?Q?qi/4MNdL2wp40oJO6Nf1iEbDy3bU6qu7C3UxHk0dmMeay6ltmvzIvi1hmo3k?=
 =?us-ascii?Q?/CZ3ePDpp40n2JlatauuDs3opgMU+QuxLlDUu3Z2WrJXctL4NgyMhdm9fCm0?=
 =?us-ascii?Q?akS652hN88IP4bI5fDpyhJkaB1uQbHaOwe7ldhLl1NlbY2gmYgDf6/QpCwJh?=
 =?us-ascii?Q?q8rLn2BQvxGzPP8kP3UZKMjJvqBtp1eKY1TsMjycfvhZEtnEJ8+9uPJd497k?=
 =?us-ascii?Q?yTKBoC8CMyvXYu/AdtJEb505UbVnLjiRlgTL6qAJu002ArKMJvTME0H+pIPq?=
 =?us-ascii?Q?iQifnq41KLK/3rgm5pqWG4zeXZuWVdU25aDHWGK8U6C0KqSSYFLZoRxW0mzm?=
 =?us-ascii?Q?Dxk51i0JyONQH9FhEFhwndgjPUG5LhQbULn0IYC0LRp0tlcUl2EhyAh8Q/Ll?=
 =?us-ascii?Q?6rOOOLK0qlT7wd0NoYRFnf/wLaMaDPS8EyQGjhQQXufTF3Nl1VgZQTB2qQBM?=
 =?us-ascii?Q?tVb3E47DC5kkYuP+1VboC8TSBgD3O57YH+rmPFJGicx5+B/yvUHbsOSC50EX?=
 =?us-ascii?Q?r+s/PnkdMEUHZwebN3rQlNH/ABUnAEl4EazSg9oLvNUlIunfMYbWCRP9nz7H?=
 =?us-ascii?Q?PLYXq7d3JYNGETo5B1k5RcDVjHvml38VvNxlDtm1o/jeF4OfYWQVkt96pREB?=
 =?us-ascii?Q?y4G2KNPRkq6+fXKu4MsXv2xPDFd2BpnppzwRjmgbW7HimY5rYZYAavPNaqia?=
 =?us-ascii?Q?GEZ8aZxPaQr/I7KfSQGHC22/bzjqEdsRTXlrQbtuk/ZYpT1r3yN45SvfRoU+?=
 =?us-ascii?Q?/1CczRY/zuRIHXpK9ur6lIPqRyW5tgjq8kr112D8xl/2GBU1zNi1C579InVv?=
 =?us-ascii?Q?gbpno1vXI2i/mpkCrFTmoEuO2DFUvYkLFiYBWgAZhd29QSDuJjss3TL1bthQ?=
 =?us-ascii?Q?yS4Z5ymmr4duhYI1J5rDUrKCirusc/Kl0O+lDexCDBbAONHn+aKTGI+MuJQ6?=
 =?us-ascii?Q?sQ8r/AfOFxm9+R0IVRWiEAkt1OK5L570loqEkmWJQdG1iIAjNfu8fRNrTqLp?=
 =?us-ascii?Q?KEldTlGTcCKCBn3YpdBRF8SqJhKJ2Q1O7kHeRz9YiXidgLdQJ9R3lsukrycm?=
 =?us-ascii?Q?c6rjLBUyEeuCfNfdFCoRP2kIl4F68k1zLNHaZ5X/leptw+jYF6e6Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:04.2317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44896918-b2b5-41e1-62ed-08dd12f4955d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2ddc56c07973..5f4d285da745 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2658,7 +2658,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2680,7 +2681,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2694,7 +2695,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3370,7 +3371,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


