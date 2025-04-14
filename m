Return-Path: <netdev+bounces-182289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B40DA8871C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94823B9FD1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A72750EA;
	Mon, 14 Apr 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fzCcislI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56562741CF;
	Mon, 14 Apr 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643644; cv=fail; b=MyB8oWkwJ8+GeEHZfiHZDSlIgqwU9X+T7tKI9wRiejXdEHTDsffs6JTY9FQv/JRdiNXgzEjHc2AomDfFuwfSfhC15spIhHDtKHr2/Ycn8xnVdulvlXvZ+JAC/WRt6oW0c98RjmgPR1s+nyZH24xUdmd2ydKM/h7/ukR9eTuZdRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643644; c=relaxed/simple;
	bh=VBFtsIdCfQoG88SVI82iE/fq/RSq8N0LVB57pjCbtyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqXZ/VCqCqxZNNtPO9CMU4REWWhV+dajpsr1guvMFT8OFSs7wv6Ltv7nA45VSkMpWZjnhWgdO8eig2yYMtijr6wxoPG9pQjSNs15HDJsW/IGXvhbRapJKXYpkkaSWbuc5FHC4XI09zMRTHh3WNREqJqzKsxpUqmiAWgJ4JU2Po8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fzCcislI; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVJH/K+9dpHg1rjKL4wL4DXASKAVaNTtJNPtgnRBVqPoD9AFklrEyc6uTtx8zXiAyECVL2+DO5vg30r5SOAxoK04Rwig0gafI9PZf9fMMJylVphx6Sn+fmrnqE3ugNg7f8yeWAvLjFFEaWU84IkGAzIrsYwyws1/axOLzIDeUhvvO5R1o73ggkdaF6ZzThvlxWK/UDuVWS22rk7z7MxwEiFNlp+mm9a/A+WQkh+MKYo4SDXvaLkr5sCt3Z7wcnI7iFtNY1SDEUO34xM0NQQZmR50Ivx7OaNZJSrrENAPfM9B6qGS4n9XeD+had9lodbDrVj7mVj2dEypqEXo/bIa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMCuddHSwkWlzk0NShGT0jO0bAyAiIzHQxl7E6jDN1U=;
 b=FytaLAuCcFW0LMX1HrUxh91ZAH+kAHKV0AJvOVQWeD/0fQNRM/bQ6Eact4NV+arpqOoJ6URLEg7mslRXkrhE507JY7RbMd93UsF5a/uysk/HXy2TZoE4/FbQrmYcDtg19BY5ViJsIueO3ilhDT6FkQczND3AlxmFZd4we6uGKL94ig7X8rEfbZtNhPFf9GEirjAt6CsduXPXoSFHTbSV3lbh/Qv5SFcUHwTavKalmvX15OZbRit0Dc4R9LX9c+zMeSg6lLWcXSkPFU2YsEiF8z3dBp/XUVmor3vu4dcyUm7LZZJ845h/gfW+gzkxvDV3hXV2w45lqSZqHXeEgppfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMCuddHSwkWlzk0NShGT0jO0bAyAiIzHQxl7E6jDN1U=;
 b=fzCcislI0oE8lX+aV13ju5zhygFQgIsU/++oYcVFgu0I/moimaZsFXPtszXPOC69UQfj8x5Tuh2ObSnfrl/rWLLKWZBBxnF+5uSsnfGrIUjHG8l75+2cs6cIuIPDqbMG8LMICxXNA1HKfSh7o46V3dpyOktGAgn+X2e7inVe7D8=
Received: from PH7P220CA0095.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::24)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 15:13:57 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::2f) by PH7P220CA0095.outlook.office365.com
 (2603:10b6:510:32d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:56 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:54 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v13 07/22] cxl: support dpa initialization without a mailbox
Date: Mon, 14 Apr 2025 16:13:21 +0100
Message-ID: <20250414151336.3852990-8-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 969d1dd2-bf31-474e-4023-08dd7b66fa42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6KiheNbfpDHay+gtlYjsbP+6aGuv5tij2n9f2JXqsBR0QjBr6Iis5PqfuUF3?=
 =?us-ascii?Q?gbuTEUtud5mIMLdazEy42XIgm7pWev/R5BRXMePHajRV5MciMkO2mqT0EPi8?=
 =?us-ascii?Q?+7LV6DQ0PuxOzhYbzvsEJxh4vBZzi0iJ2C2bJstApx9u9EpZMqw5lChKZCNQ?=
 =?us-ascii?Q?HUpz/qDEIlq647fZ+dNim+gaMQ/rx+7saOEGsSDELYUtpYv8qw9EASn2i/Ol?=
 =?us-ascii?Q?yNx/7a3LGmEiy1lvQkMlm4NeShMskFHU0y9tA3DihO+DFeV6v1hKRc0aRcq7?=
 =?us-ascii?Q?hn2c8cfgYM1YOAjaiBqTNLlpJg8uaJ6+g8z/kxI2airvrxw89acOdC6XIwif?=
 =?us-ascii?Q?xz/VSCkIoz6PgljN+FQQoYx3KIO1aNbO9+nBujY3ZnNZ4yVjtsmMYGfOYCmJ?=
 =?us-ascii?Q?duk8C7ff/YDlCwO6ERqKXUZtpW0Yazc4PDoxj2PUr4GyckEcomkJKLoJvFES?=
 =?us-ascii?Q?S0MhHHM3b7PWevU5tLRAStBL0IQmTtxoG9trgjgLwCHCUFrtQwZ1+0qouhoS?=
 =?us-ascii?Q?apVd6TrtGOa1eVbsVFmFUt46lliLIN49bjlr+vD8DREFL1XIa6mDnPTenYWb?=
 =?us-ascii?Q?T6aox2x2NSqXHiqSRTO1i1GlZRBRlO0Tjzl/hdLRuxGA+VMXkFvKeK9kIkZ0?=
 =?us-ascii?Q?2kV8tmMUJiW120UOi1UtxAlxZ/EJlV89sMyQDbn8RDSQs7ZD0WX3NlRG5WAe?=
 =?us-ascii?Q?LYDWaFKZXzedBVzPupkVaFNpD52GJT4AZVYr1QmEzPrFbr/x0yGEDOhG3xa6?=
 =?us-ascii?Q?nnNuUwn54oJwIcvWWqiLw+DgJVtY0Zmz+fDJ1VC6Mr4L3j3dYRmwKqpBF2xx?=
 =?us-ascii?Q?LVxtKVrtOxTfGXNg2oyJld8MzCNX/mWIwOsoa/AZVlAki0Bpwnl6cd/gvyhw?=
 =?us-ascii?Q?VDMLblQeIM+lr7esNyDBwpw2zJUGuXvF8t/oQ475C/iT+uOo6NBAkXGGi8Cw?=
 =?us-ascii?Q?fG9rGjBHM1yty/+BJdXQRSMjgfyGzG3CjnUKKU61H6B2VPor1K9WVqR4bllP?=
 =?us-ascii?Q?44qSOu0ygxJm8dirvQ4sNKyyBj+yEgXsn5mX+2PFFt/mN9EVAXltuYfLRR3g?=
 =?us-ascii?Q?SQHKLfvzW93uOacAqzUD1SMYJnvMZfjNt+NkAMYaihQ92SO80gj78vWTbiyk?=
 =?us-ascii?Q?CtwCHfXi9+IORdM18PsoRvj5dqaw36NCuIBzxAXAvU3RtreM8FDw9CFMj6Ts?=
 =?us-ascii?Q?ILuXoJdMFCyJOfwnT/AV3nAlvF1iCAL+YOcl7IKwvFTgNs849TILxg/bqfkD?=
 =?us-ascii?Q?utGq3qGp2Kca978IBFjJZrcM8HuoAfL6ThAjrNNt4xfjlbCtrx47CnKJrvLF?=
 =?us-ascii?Q?bxapBgCl5lrYjedrz3kAZwOYNVyVlTlHn81JM1GeYxpqAg6ILHg80YbhClMu?=
 =?us-ascii?Q?1yMoU7lxHFbgUHw87XKZAaoou48JIorLh+C2E8FrzEMfuIHEYtN+S+etajsm?=
 =?us-ascii?Q?Uc8VESOgp89nKA+wxk1XAAe/sOxUMuQVJt2g/OzLddnYuPUIBvER9jtPLHQS?=
 =?us-ascii?Q?t1940VI3dk21d1C5w+zRD0FltL0024EHK79b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:57.0442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969d1dd2-bf31-474e-4023-08dd7b66fa42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DMA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile and/or non-volatile hardware partitions.

Export cxl_dpa_setup as well for initializing those added DPA partitions
with the proper resources.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/mbox.c | 19 +++++++++++++------
 drivers/cxl/cxlmem.h    | 13 -------------
 include/cxl/cxl.h       | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ab994d459f46..ef1868e63a0b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1284,6 +1284,15 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 	info->nr_partitions++;
 }
 
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes)
+{
+	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, volatile_bytes, persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");
+
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
@@ -1298,9 +1307,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size = mds->total_bytes;
 
 	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		cxl_mem_dpa_init(info, mds->volatile_only_bytes,
+				 mds->persistent_only_bytes);
 		return 0;
 	}
 
@@ -1310,9 +1318,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 		return rc;
 	}
 
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
+	cxl_mem_dpa_init(info, mds->active_volatile_bytes,
+			 mds->active_persistent_bytes);
 
 	return 0;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e7cd31b9f107..e47f51025efd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -98,19 +98,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 2
-
-struct cxl_dpa_info {
-	u64 size;
-	struct cxl_dpa_part_info {
-		struct range range;
-		enum cxl_partition_mode mode;
-	} part[CXL_NR_PARTITIONS_MAX];
-	int nr_partitions;
-};
-
-int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
-
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)
 {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 729544538673..d1bd136fe556 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -214,6 +214,17 @@ struct cxl_dev_state {
 #endif
 };
 
+#define CXL_NR_PARTITIONS_MAX 2
+
+struct cxl_dpa_info {
+	u64 size;
+	struct cxl_dpa_part_info {
+		struct range range;
+		enum cxl_partition_mode mode;
+	} part[CXL_NR_PARTITIONS_MAX];
+	int nr_partitions;
+};
+
 struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 					    enum cxl_devtype type, u64 serial,
 					    u16 dvsec, size_t size,
@@ -235,4 +246,7 @@ int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
 struct cxl_memdev_state;
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 			     unsigned long *caps);
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes);
+int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


