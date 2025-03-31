Return-Path: <netdev+bounces-178318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613AAA768EF
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8091188D6FD
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502F21D5AE;
	Mon, 31 Mar 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S7TGblwm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709542153F7;
	Mon, 31 Mar 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432392; cv=fail; b=iVpxXChUrKbleDwqeDXJiJ+iEi4Eqh8tg4g6aiKYnFuMbbWdJfMfnN2u/H7ZdbrdcW3MuJ35RTxd/JKhIUUg+xB0eQwTv4naWXcLhwgTPQxO1sMhqpUzrJt8vtQj2EMYu1BkSh4lDh+XrMOZyxh5phMgPfKioX8He1qGvBuztww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432392; c=relaxed/simple;
	bh=vZnWI1wph6/keABrG5+B1adDsxEnNfuySlfJ8N6+/a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVROxfOvr3rTPM/7vc/y8u6K1ZjbDcrFOzUSOCbvTqKON9UqU73TGlqDwRsf2oSkLQ52NU+QrIUiQwqdF8vg4buHyQsSi2R+0Zj4Z029yRKt0hpKD5iTo41W6j6Prkc/bOHVtxbWiYvHx4BpIUi63RGVoLvijdZMJ8ZWbXgoN30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S7TGblwm; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPUfk1h7iouPLsp52ohivsxF1s5fS0RHE1jydDqSeE12SQQeiwauKcpoFeAaLePyq26yUaPoQGbD7FUw6JWjtGkZQjQ5UCmO09AydIeO1DEWLH7iz5mIYEftHlKols6VAdm45hv1TAB4x786KrV6SuN51Gv8KCIReii5uVVHMrjXifjBg3bwum6xx5mddDhT5svFKIZp8FQf2bVCGaRK8fVDZ2ee6YdCe9OXu76483co1fEAK7YVlTOH4/XmJ06anV9elu08q3ELJ6RNIrYN8BlM1LEDnehWYA+3rOqOH1iah2v7/LkgJEegfGDBgn09fhJZQnQmDLoWKR+9mFIP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs5wjJitlkWkBfZXB20ztALgcRGa7FOvb0mSaqhnsMA=;
 b=qu4MzbZ9eVjiGYbQJPYnA3ZYQZd6BqcbkA2srZPWn1+pB+QuB4YRErJfjliLWx/zRm8kfPOD4f96TskjsUVql6ZyqQAxHC88F3ZlQVG2rBhXIfOC8f5Q8GicjA14FSDpqzpilG4GxquxdQ1H/gDFYkb7KIoynafgdeuMNyaIFAetfpQRM6hI0vbo8JibPTYq7IpPMVPi9cYgEK5LwQpzIDqzqwaJAV3LatBknH6fs+CjWjGGsQiU1/ZUaHl9fZKADRCkKqhV4lFo9/b44kM+MDgJx9Y796+TDYA/lhYFXhcwpC4amcf2+bYOHPkqjKrQjpH9E2ezMzP3wZrg73hjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs5wjJitlkWkBfZXB20ztALgcRGa7FOvb0mSaqhnsMA=;
 b=S7TGblwmSvovM81SQgMdsUP6Abe4IOF7dwuJSQxf5H+tjqkZomRRYHqRC4ykk8amcv3ZlJ2+qjUaSSRf1Np3niMV4FdtnOKxYMYGWKvMnP4nidKnID7EYuZMIOQ3yql+N8bb6PLA3jUFEwt6KKj43nWrxNy/QMAkhyHZwJoZ1EY=
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:27 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::b9) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.45 via Frontend Transport; Mon,
 31 Mar 2025 14:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:20 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:19 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 07/23] cxl: support dpa initialization without a mailbox
Date: Mon, 31 Mar 2025 15:45:39 +0100
Message-ID: <20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a121882-e21b-44cf-f590-08dd7062d141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKaAxzcFhfw8bTSygzbjP3TLHrii8rfPe5/OO66vY9t5NVn9qTLwI6vFjRuo?=
 =?us-ascii?Q?ApG+VQ1OxtM51EHrz1nET4+izYLeQsvZesFExc+QVxiSay/qP/d/9mfmXM8m?=
 =?us-ascii?Q?1Fd91jXtf0mAWniM6zCaea0rfV8VMfKd+yVGJknJ07vCG5peYnPNOtL4r4Rl?=
 =?us-ascii?Q?Dhl1bykA8IJr0JdKHz0PTX4ady83ogk0d1neWMJaR4m9a9cuCuuRDy+fylSw?=
 =?us-ascii?Q?5xLQnh0NOdaFRad3kqLO9Z/NM4wgM/358vfX/G0GTjBLEZgnqgwkpGvIy+l1?=
 =?us-ascii?Q?2LVKfyIAUf/j68XWdirDZ48qPMwb9PzJWZDJF1dC8L5crE9Nce8o++fJU6JT?=
 =?us-ascii?Q?+2TCxclrgfV2L3GtZFQkPuJ4VIKfvP/0samFplC4rhjNb05Pn7tbwRkoDK7d?=
 =?us-ascii?Q?fGnJXGW6ZKBQM9tBZBnjPj2jcX0vmvBRbLDrmj3z4jIRMpnYFJ8BtSwGh+2X?=
 =?us-ascii?Q?PwgcqKvE7LH2dNy8PgFdF3YrUUHW0sYLJcdMcGjpTxtIYuM42YHA5IPG5dIu?=
 =?us-ascii?Q?M1OrKUp04bwl39exAxjvwG55tSP3jRyAN/o8e/QmZEQToc+Lg+yqBax9fyCA?=
 =?us-ascii?Q?nATZ61Y92aNvhGkCrpXqyrY3TyxG4It810CMdjYhp2nKYAx4RI5ILxE57Rb3?=
 =?us-ascii?Q?SABACxHteR5yO+q/5siPrZrdFgtQuz0ueugkGtw3sjsYp0Cn9ULP6K1x54jA?=
 =?us-ascii?Q?QJ9RAiuuSE01cooVGg7h1mK5M84DWHhn/lP530yrxUEnCYvm7hZ7ufCxlmuf?=
 =?us-ascii?Q?9xU/Wk0UTQ7Z0JL/lbXyEqX3mRgBF3/kHaysMQBjq44I6cVtFnr55PTBDsG8?=
 =?us-ascii?Q?sB/rRlEMyWoEzHqdf2PN6RuKHmpPp5p5mGvgrjkERpl1kingR9yDClgdpzbg?=
 =?us-ascii?Q?260xcfP5+qs6YE9QsEL6M08JhtkoVZ4yKOkUOPiHX/8qs3Z+MQswclyfva34?=
 =?us-ascii?Q?sEVmFPhXqPD+WPOlqv7vG1rD9ayU8RBn4X5TFUKx/L+/sThdAo8MLJoEdvc2?=
 =?us-ascii?Q?MmeYO6+Y9xbbeG6n3xMFoM4M8aCvYa1NPzg3Kvo+ztOtUf3GP3pme58g7TE1?=
 =?us-ascii?Q?1Sig7bEeVyC7Zb/7IoxMp1ub3EprrtYcg6KZg0OlMWOKddmD1VGAZxAflL7F?=
 =?us-ascii?Q?vcMUulUd7fKDQ9yksO4yOM80Z6kqoJKsRVt21+qgre3HYMmj1PEWchxxrjik?=
 =?us-ascii?Q?y7/GSznwk6HDY+CfjMw4bLyrXayp9Y0lh+BO/Ra4CmvWQT9az/n83PURze0C?=
 =?us-ascii?Q?edO69yYAENcs6HMr9+wa14Hty+GJcn0nrgKGC7Fe0OWqfVYkDn1/7jaiAeUI?=
 =?us-ascii?Q?OmttTHlNtByFyUDrSIKjtcQPd5/ia/JD5CAruXT1coEST8CCQcf0N1wdw98Q?=
 =?us-ascii?Q?ZThMAt/Y04wSSQtJlkoM5TqEcUj5f2CZSVYAuS2O569TcpLqJoeJ9fV68XQM?=
 =?us-ascii?Q?dyofCgpDTxPjuhJj27j6f0lklBAXFFFMZHueyFKgM4ckkJxDJbXAYl3A9rzD?=
 =?us-ascii?Q?3idZWtwlV2N/0kgZLP8zhjVmf41+Dwg5UH8N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:27.5251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a121882-e21b-44cf-f590-08dd7062d141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for dma initialization.

Allow a Type2 driver to initialize dpa simply by giving the size of its
volatile and/or non-volatile hardware partitions.

Export cxl_dpa_setup as well for initializing those added dpa partitions
with the proper resources.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/mbox.c | 17 ++++++++++++++---
 drivers/cxl/cxlmem.h    | 13 -------------
 include/cxl/cxl.h       | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ab994d459f46..e4610e778723 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1284,6 +1284,18 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 	info->nr_partitions++;
 }
 
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes)
+{
+	if (!info->size)
+		info->size = volatile_bytes + persistent_bytes;
+
+	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, volatile_bytes, persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");
+
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
@@ -1298,9 +1310,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size = mds->total_bytes;
 
 	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		cxl_mem_dpa_init(info, mds->volatile_only_bytes,
+				 mds->persistent_only_bytes);
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
index a3cbf3a620e4..74f03773baed 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -213,6 +213,17 @@ struct cxl_dev_state {
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
@@ -231,4 +242,7 @@ struct pci_dev;
 struct cxl_memdev_state;
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 			     unsigned long *caps);
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes);
+int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 #endif
-- 
2.34.1


