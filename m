Return-Path: <netdev+bounces-224335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE78B83C07
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663733A041F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F1306B02;
	Thu, 18 Sep 2025 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mGuuX0xb"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D3303A3E;
	Thu, 18 Sep 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187118; cv=fail; b=pg83FTi3+HPRODls80UOr2GI1ZN699lYfV5yKvZm6FZt5WvbVuAnNS6slEzeO1cvJHTlWnvfSTRxCSpJlIGBv4TRGnF9U2MfzT0b9VwMsIua3m5m8J2qluSEW/LzG2zjMUtr0azZYOT6M8Iw2ig8s51rpkI57xTNM11qiOdE9kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187118; c=relaxed/simple;
	bh=tRB5Ppk1DGUItYo7d8ZNK18J2e9/3Dok0GG5w23IySI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nx4prwzQg3iIia9JPzyFFuTK0p5U+gdC0G38XTCdjgiE06PIJOMnoCvU2Av/xuyxmMPY3ANv2L/dECF/BGKQg0F7fE4wtE+cmxjAqS0sv/Hp+57LsZ3yje2CmzEsC8IBWUWHhbDD6Va+bWilfwkISc4xCMmM6xRVVOYwP42IYmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mGuuX0xb; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3o2xDnnWzSblKXO9sZhMd3OJup0GzIkLeYjaVQ+j8yY0qjRrzVIOUSIx66XrbZ+SGxo2J/w8c1IQEEJ+eT+sIZDulILc5222Fu1MirHRF4ssNtwk9kDPJna8iY8Mv7Zkf+Z8gPPnhNywW9yddvRkowSxCNdQJsYvc5QG6KBNbAkLoT0kAVnKPTjRWS5vOguw/oKd8C/Ft3sFfl4zBYDh9FZyWr0yCRGxcRvwD8kjFVHMrD1QX8BVkFR8fJM3mER6SOlqRW8Kyb2vQZvDY0kgXxos3gbu7cWQWuBjItN5K7Od8z/bHzikvnO6eJWtnnUx4Cyc7yYBtfvTx2Z/sXaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Tkq5461u/NGYixcmEkmbRRG7BNrnf+8ojWeFmChXc=;
 b=tISgw167+LsDdIZKj7D0iigmGoyi+NX6E9mLsErFEGaF71iHtVteeZQujtpvie6cTs2gfL6TftmWVbilSA6duSlsHeBK4Y8WBnLSa0nw23vqNL84FB4Stau6Ln8Egog1dxSjuKDt1MSmRrIbKaXvn7ekpQ2+6POgMf8+QdPHkYTDCWPBssfA07bpiDK2iTxcBZbSzOLlTqfkqKkAFg9SfvZ14lxf5phULMVAV1eqfhtchILqjDLhK0s9d3c+BOSAUqkLNNngNKIGt2/bKgIkxUfeX6z6EOnl8NpoAi1daJfC+ehXeanU1XvPtGXg2uGRlFhyn6oy/J3Y+zvOwNrmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3Tkq5461u/NGYixcmEkmbRRG7BNrnf+8ojWeFmChXc=;
 b=mGuuX0xbzjwWbquCQZCj+zofM7AR7X6M91lMBwVIGj1c33Po1lkSnjyOmr5Y+TsijgUT82TGwqNKAsQydDR2jMPWVgZ8buyeMPE8fDYjY8aq8JBC15pLd8UkLmDS1oCSkfy1EbUEMWA6jwzDFt+j1fkLyDbO79z8y6+oDaMS3Qg=
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:32 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 09:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:31 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:29 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 19/20] cxl: Add function for obtaining region range
Date: Thu, 18 Sep 2025 10:17:45 +0100
Message-ID: <20250918091746.2034285-20-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c77ac9-130f-4c3f-5971-08ddf6945638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lpxVy5XA1Zwt1qh1vkxzl3RDu1t556VPlIxOFmMmpymtz8d6us1c5rtOIg0?=
 =?us-ascii?Q?qM+iWvmbRPedKviIErpnO+64aHEa7tsvbOAmPdJlSR4RRHkfDVVTZDQkVHQ3?=
 =?us-ascii?Q?i9mD7Q9Kj0w5KnS7ZnMkLWuKS/VOMEwLMjqqKT4s5sD6ZQp4X1/sohemdOuV?=
 =?us-ascii?Q?WA0ywMGeqEDhL++XoGVPrToEC9R+BoaScNytlWktAU4/gZzJ22jNDpkS/AvH?=
 =?us-ascii?Q?u2RUQcxZZmNxOjf3Z4DuXy2jHcJn7iJlOmICII7V5Ts1NyELoBa1XhTBsERw?=
 =?us-ascii?Q?PHHMgtqv8LKr+VuRCshMLOLc1CQfdbAXiciTK5z/kFyz1P9FgTmSprtQOYBO?=
 =?us-ascii?Q?J+F+ccklU2yzxvUJDP4j591BgduhSCrDV8a5OLWr/VW/9rmYpIxuU/yb6Wk6?=
 =?us-ascii?Q?SNHFBBZIlqc6aewRettrpaXowdtzTNiQFoxs4+qCWG6xZafZxHDbrYjLPyBe?=
 =?us-ascii?Q?Yz2lVxAddk4wF7arrqbQwS3NGRz5OJPzAyWC4fXlupyP4eQtewbQGRVkHzYs?=
 =?us-ascii?Q?ocF16UHWKVtMrvtZHDBYiSrFzN/+497OBTAyvjd/MpmLHe0BhPdlvqbdcnfS?=
 =?us-ascii?Q?ygq4P3rdp1bRxkArg/vYE1072ghJIGp6+ZpPVT6hXYDEH9AGaFQeyJWC20dS?=
 =?us-ascii?Q?+vTQ9tqWNpH/T0Y42AqApQDXu71W14oIEGifRlddcnFtDCaETfskk9bWfbAy?=
 =?us-ascii?Q?9FBZ3vxRu4zAlk15nHBkuz2Bdjt6sAukZQ0vna35NHGx+vTpnjswMf+gmDLv?=
 =?us-ascii?Q?wtv5Q47/BWDfbPlzntNPSdqLMRvPK0BaIF0JQu69yi7l+o78xQ50wOKidAGv?=
 =?us-ascii?Q?bTwF4KPTvI0qA1D+a4QRVwuu+S06I0S1phT4j4TXhxZBqRKLyL40wuZsEDzU?=
 =?us-ascii?Q?VhBtuMLv5vTjxFXtsUL5ptp8thNnw8+jTwBV5prUpKIaKSkC6kRvZY+mU+vT?=
 =?us-ascii?Q?n057ntBcy3fxgnSCzz6WiMv33lVlIFQff5bwigbEL3ckhXXEddd+311yP+4k?=
 =?us-ascii?Q?d5m2IpeeyADFMN8HLHzUWuyOf19OTVN9wIFqCh9WncrNdrqiM3PzUDIOo1tB?=
 =?us-ascii?Q?Ot8qnrER6js9kVpH2wwHUvaRHOKBOSE0+HiQclGQTCeVfPtoscKCdPII73gN?=
 =?us-ascii?Q?h3fIvdxJLnjSkzAUWAF30qcieKN7s9J87yNnOPs0T91f/DWT8PC+UDy2ieeX?=
 =?us-ascii?Q?4uEwo1HWZT48HOtvoYFrDK2DzGdWz0guEfyCQGB5fi6gYwfkKftYyffB/DQs?=
 =?us-ascii?Q?9dT+/2V4p6axzZgctZ8Upc/6U/KkAuDACLcGo/q2204UH84ZVQopjw8mdQ1+?=
 =?us-ascii?Q?qSZ9jlFTJbKQcuhA01PpOlL6ZuVAfnP0Hpi96MZP9IL0ArZphGWOHX4s7uCZ?=
 =?us-ascii?Q?oho/kh31HFyOo2KVac4me7QStIsjkIzh9Ri87r9Cz42o/QvW+0UQFJR/KXL6?=
 =?us-ascii?Q?zyDWh3tOG9SBaRMsR+P6YLhWN+bRJvLKhA9Kn43p2ah8efsemeUJpa9WrekT?=
 =?us-ascii?Q?hc0OaWQed0XX98gHSlmHMR/joQt7vFVbXLG9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:31.7994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c77ac9-130f-4c3f-5971-08ddf6945638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Type2 drivers can create a CXL region but have not access to the
related struct as it is defined as private by the kernel CXL core.
Add a function for getting the cxl region range to be used for mapping
such memory range by a Type2 driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e39f272dd445..97b2fb68e029 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2758,6 +2758,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_get_region_range - obtain range linked to a CXL region
+ *
+ * @region: a pointer to struct cxl_region
+ * @range: a pointer to a struct range to be set
+ *
+ * Returns 0 or error.
+ */
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e82f94921b5b..673a0aeec086 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -290,4 +290,6 @@ enum cxl_detach_mode {
 int cxl_decoder_detach(struct cxl_region *cxlr,
 		       struct cxl_endpoint_decoder *cxled, int pos,
 		       enum cxl_detach_mode mode);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


