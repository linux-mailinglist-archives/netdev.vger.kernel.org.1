Return-Path: <netdev+bounces-163054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2779A294CB
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F331895684
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438571D932F;
	Wed,  5 Feb 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Z/0CQsp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EE1B532F;
	Wed,  5 Feb 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768829; cv=fail; b=ZUyyCw8kanx4TqYuV458soN9oVoHsvphEJl0siMj5q5hbvx9RxAG/KxNWXDHAsNrOfa0rccHZfBcXMJ2aCqE34VC/dkk+PJbMAP1ZpFO8wcvxnz1ZOihxVsB1kV0jUqsAIMkfXkbmYTu2MFZyw68PA3vf+yJ+RufNtNME3epdTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768829; c=relaxed/simple;
	bh=7CjMfMO+FegBIK2GqPlP8+GXHI5E5CbKvwNZWJXhXVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWKnAcynuJ4Rsg49Zt3UIEwDMXm/Ue7p9jx7Nj0m6I+oTX5CmO/C4M5PGOPIPhUreZsUEdLy/aeVs2MyN9YNmzCb24opZtzmmyFJ3MiKmRbpA4UfnOLQqcpekXfHf7VeSP9Ez6uOiy6U6HvPmjoJtaAlujdb8QOrn9+3OExsAx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Z/0CQsp; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3NnNNAX58MMQxIoeckAi1GjTogTq6Hkcp9aHT5ipD3bm/K8g4ffX4627gSZSy1SgrVbiOzkKYwhjd0ukbADINXhhrpUGUNPtW1iqmbTBT35JnzrfWiclusYcK8tk7xW7vT4Fs5IusyO6HuyAe9OPx4ZMf2hhtdr2RVX5ln5srRK50KLAvWpY3HRKIJJcahg6cBrLXSwG+aAtRAxCNO1WzjJDsekfYQFRbV3ww7h7SOkXQtSw34A89uZzrgCeDduRH3xNFOy3zdklXN/1LZIa2akItGzeGjflTv0bDEXWI0pyJaMsN/7GmTA5E7eensCCeXuEHtCgBPFpme/+iWogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqtvEmoOYbsCpRGPZKgDqQJbvULUDaBvEfA9c44GRUI=;
 b=H/L1ljL/Wt1COpvE6Lu8AoHWAMvD5aj9yMAbfyTLmOngCAIFwXDb/mPjgLtBea1zJIIX8nBemSIPAIn4OqJPM2q4sK8gQQ7UcZq4jhDh8WAPwMsd5cV/U2ReF3RSOHfSMh3r3M1j+pbQQp8jeVjpuzioiEBwts4Ww4XsUtA60piAMhgMIzAEJ1c5gHbsMfttAuSWnBdexMYPG2Q7h2SttSPEHnRhJB329ldr/mzNV1QZYYmJ9//idG0hn4OucTl245biFUIlCdH71l7ENYUKWMGzcULI7vI4vROUGXYE94qsPJtrneOBfecbsYeptnp9vPGWDl4D0zQKEJpvOBWR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqtvEmoOYbsCpRGPZKgDqQJbvULUDaBvEfA9c44GRUI=;
 b=5Z/0CQspNCJs0jVPPc9+6kI786CcQFAuKVHiV0hiyBCQYPdAxSViQxCRdFIa71yr9WKMPXyOTDXnC6VgzEmOdWHfJo0Bz5AGUI9XK1ajERIoEslF+0Mtbwp30GtDdofYFBIU5xYrYaxX4SCdAlPLErkjzq7l+CzN1y9OSAB9CYk=
Received: from SN7PR04CA0185.namprd04.prod.outlook.com (2603:10b6:806:126::10)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Wed, 5 Feb
 2025 15:20:24 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::57) by SN7PR04CA0185.outlook.office365.com
 (2603:10b6:806:126::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 15:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:23 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:22 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 18/26] cxl: make region type based on endpoint type
Date: Wed, 5 Feb 2025 15:19:42 +0000
Message-ID: <20250205151950.25268-19-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 43528287-a8f7-4562-d955-08dd45f89d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U9UkmxIJaPbYJ8jOKt2BYphRhNyo72g/kCmcLbJUXEXu/M5xVo9aPW0G5RWK?=
 =?us-ascii?Q?NKBbX1qs4N3vJhc+TfuzwYKmX8bPM/RPXE121cF641NxeQ9x5ILJEBlPGfm0?=
 =?us-ascii?Q?m/mzD3BqMs23noka3wF+1wsaVVB/PzYvwljbs+SpZ3PfxBhxRK3LxKY7llh4?=
 =?us-ascii?Q?wtfBpFTrl9SDdY4fjWol/E+QYs3fvOl8JMtyf9tGtIWJoxqnxMLoxHDhYtvw?=
 =?us-ascii?Q?IHM3hDZbf0aBbqSbYohAS/MxzKLaaMwoD+Wpqnj3JVd3NhvFuo7v2bv16mSY?=
 =?us-ascii?Q?lvCzqBWi56Pd7uhxhJB+mIykLD9Gnc19nHMTE8dfCcOaPmrLZvfB3ZxoWzup?=
 =?us-ascii?Q?37N7e4jHknGQyt9BITcfORCNnU+e7Sqj7bUof7AWTdo5h8WCIXQ+xJWj1wrj?=
 =?us-ascii?Q?bxLhB8gXgMZHIGr/hjm2DCkMjhwC28ujg01mTqlHMZLE/O6asyOxUZ97XG1J?=
 =?us-ascii?Q?q8AAJJqNkft1aZkJ8Han8uox+1undtRQUE+DAAVkFe6d9OrLoPBmt8gIbwGC?=
 =?us-ascii?Q?B7xwoT1p3j2pZxtRYqAxVS1gkwGQD/dS+DEyNMgs1Q8niwyYSuFgobkDRnpp?=
 =?us-ascii?Q?3lTqBDJRrraAlaIBPzc/d8DhSgoDsPUsao+UwAzLWkdWE9M5rR1wJC6d/ujA?=
 =?us-ascii?Q?uzrTbzmeJZzOsr1Va1ku/0RX85bUjmAGHEZ2OfFm0GWrKbaxwTKEVInrzmkn?=
 =?us-ascii?Q?YrcIMlX2NezLaqkZIgxU21TwLoYOG8IGNjx59AKf9EVBDUJZvu3712nUP732?=
 =?us-ascii?Q?SlD2uHEleAnTsIK3NVZg+TNbe3DaaqzYOZLT023K04aBHfDAjyi3th9RQK+a?=
 =?us-ascii?Q?gR2XjuienrSfCMN6tTqWL02a4cZhc/Fz8P2RmSd3A1bOToLrL4eU7/Imniio?=
 =?us-ascii?Q?xXSCFyoWxYPUQpulukxVAOQKfTOm+lzIZ1NqMSAy/nMR935dwl/MaZrRA27+?=
 =?us-ascii?Q?3FcNFWKaqmFSAsCWbSKXtrTU0O8ULVJTw3mIoiViqVXrkfLmth+kiqHvbfUO?=
 =?us-ascii?Q?7wth9A1VyDzYWzKu/siI97/Kkp7/i/HqUFqXLjmZAKhSH4nNNCqLixNzrs6Q?=
 =?us-ascii?Q?fvwtoyPAKfnVipQg7gavhsO8/Y70L05fscxDsXd/2p2bJyfJzMzYZFQptAmp?=
 =?us-ascii?Q?Oz0H9U9MzWHYYcDxR+PO38zOxvx9dBBetLrdSAWweNdrpDa3+HKN5kIrqLTF?=
 =?us-ascii?Q?Qf0/DKbd5QlD7uyNZ4cOdhNZ5NsiRKg0f9oQJCSr/ULPWH1b2FEfsO6FtyId?=
 =?us-ascii?Q?dP8xxmKGlSAZJg1rgSmKFZzDYUvnmF/fZC/sCkiUBH0LPhsqqGHwFex7Rx+P?=
 =?us-ascii?Q?4IGjjO/aziGYsqHUSqo71Qzv4wI5Kzt01NCXBdUw9ILE/GMD7pxKv5qlRJpB?=
 =?us-ascii?Q?lU9NV+DJ5+uPTG6DOl8f85JLV8Id32VoOLwRq1oOUsVD73SwYFH/VMjwxFJi?=
 =?us-ascii?Q?ZQdZoli/dfwjmUhQdJHqJd/OqPejtKE3SZm5ZzlFOSd8KkBujEdAo7T9SLwK?=
 =?us-ascii?Q?6+Mx/EnsZVvt3s8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:24.4611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43528287-a8f7-4562-d955-08dd45f89d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 69ff00154298..22ecad92299f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2694,7 +2694,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2716,7 +2717,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2730,7 +2731,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3401,7 +3402,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


