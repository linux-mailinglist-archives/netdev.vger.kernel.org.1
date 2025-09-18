Return-Path: <netdev+bounces-224320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB7B83BD3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAF94A7F05
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC232FF643;
	Thu, 18 Sep 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NS9mJgAt"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564402F9DB8;
	Thu, 18 Sep 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187108; cv=fail; b=h0ab1S+gBi9Zp6rhRX3LF73JBf2IQv+p6oq+nBH/UfCKArd3U9ELICt6uJTMcMfcPGX8eNETorvf74ppMuqSLjPvm5dVOXlVJ9Fk68lvjFarEdS6cQo0NoJsLiadY6vlo5DBEr+lXmfq4mqUZqFsRsxo/6di/Zp1giMv9hj1kUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187108; c=relaxed/simple;
	bh=cEtihse3iAgNRJy0L0xCMf5ZceXrV6sCpbfds47X4CE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bX1+kxm55ocuQnOGNBHXokGJQh/nD5mubL/zJBa5h5/O57bHAuNVkLi/NZJEISvkabHV7eAidOuoeOAqZ3N6JU9EThYtKBy9Okxax+WCd7qXn+AsMdpElv/h45ME88eCI+c3o4YiQHFCWEKguLptdFILaX56+1Tp4Y3dVRZDFi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NS9mJgAt; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMAG1xigsOvnG21s0dbx5fpWlmpSFiMmb7ZpTeXwQn0JCm5BUPvjX/byqm54NWXzGlWS7w7pU1EEqE6UsYB+ggvqGHX+L5uAQr8uR1aJJmPyfhK1q0CgfgGNVqdG/IXl8FaYxNxNFOifgb0VUhkjg2SM0e4jPX0RW9XteEFKXEnNp9Xlbx3ALqG67/PuuAmIan9HwXSxXR4q8cUfAC9BwlSsNRHOzLRZUBkojlU1avDvO26TlFY2zuBO7co8GvBwp5QShiuv3rZDYT1e4101Q5m57bTZepNnMDRkr6UpR87XFR4rBWbVjgLjkt+OLf9PeOI+MoQk0LPFzlYXy/NR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6oM1Z1zqCwEZQywP5AnXe87UqVlVOtVGVtxjx4IXT4=;
 b=W+Dp9rhieL50yZs41PAmDHd++/yYtK+J4XGCCnDkV6G621NNktej2xWOiAfm5rWByIC3Uegpd/1R7jCeDqYlwYGssKLpPasVfaRmydKYR2LIaAU6JBbuOBZVYJJLOwskOqQQ6QMqD+rjvlezFWVvHtNmvBwsWteZqd9iiL9lcmaesfegN7VDVFLdDrq1zX56qpEKHqraP3iB27U7CpoKcQ0S+DfQQO5ALUECBG1VpXrOyqHQ8DgV6u+LOJCVV2at6FEw8rKe+SB0XhE2BFmHQzJOsKqP/at/Ix9feKpgIPelwi7UkMcDRT5xvJY1LtETORnqA+ExEitsK3NyQD6LZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6oM1Z1zqCwEZQywP5AnXe87UqVlVOtVGVtxjx4IXT4=;
 b=NS9mJgAtTPINURrIABKSeCB01hxxgpT1T+BoymcXKyeNoC52AorvuvBfiT3pJAVDM9UekWWTKNFjCmLe3JN6IjAYGVAg7aIXndj1sH3mbpQNPEzV0MtTHth02k/MhCP0xr1+oBS+4/nLc1kEJSilbgVBARxGSjFd0gBhPu41dI8=
Received: from BL0PR0102CA0049.prod.exchangelabs.com (2603:10b6:208:25::26) by
 PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:22 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::28) by BL0PR0102CA0049.outlook.office365.com
 (2603:10b6:208:25::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:09 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:08 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:07 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v18 05/20] cxl: Support dpa initialization without a mailbox
Date: Thu, 18 Sep 2025 10:17:31 +0100
Message-ID: <20250918091746.2034285-6-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b41fa3-c2b5-41bb-a6cd-08ddf6945045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wpy93HN/txlIjqUQUsQomuekRVEzSMdOvP08vBtQisndj2PoP2dTLSeSN9FE?=
 =?us-ascii?Q?bjW6lu6v2Kc/F7ZnB9IOGJWITKtNwQZzRuGYnI0AYd4ZMwoZdnfavWS+OuO8?=
 =?us-ascii?Q?DD2A+XZSXvnoAtYVMiBL8qeJ7+m484g0aNLFp77w6jnpDUqTK/CKsvZSJONQ?=
 =?us-ascii?Q?Y7G9J0FcHYIsf7N7avDM8KafQE5FUeDGfrQy37OMe/sCw8Yn4pFUTtJOn/z5?=
 =?us-ascii?Q?jWJdIeQAjjJJWVcTlr2r1cQ4gNqB49JajQSyhXzfElicMbNpRgVVMAbxcmBz?=
 =?us-ascii?Q?HMAQbJmj7GD2OXp9W6W69lqUInQxIAd6txwea9+1D3E08YCoOGwqcqwb93FC?=
 =?us-ascii?Q?GoleHMlqTMVQN3UoLfpG2gJ51SfO9Y+HgLb77jaIxHbyQHyYm0H2x5/NwWIx?=
 =?us-ascii?Q?z8GFm6pRcPwGyZC+uscEN2wnwIopu5J/6li/OjYZr4u1h2fElXQtyl4h4eR8?=
 =?us-ascii?Q?esyjbPgjaWuIzdqZVMHmo0YFXTg6xogW7kr8a5BLdBxORN91/ERAJbY7h8xR?=
 =?us-ascii?Q?E1UcNLdn0R4mEEdwY4K0F2KanRoQn/fkuQO/2A/TK6dRqfzGtu1MAx82PGVt?=
 =?us-ascii?Q?042alVCvSIexCXE7218BDJZjde8BwCzYJdlkmJAUL+WUgF6YvOXT7RgkgXIL?=
 =?us-ascii?Q?3wbcuNJ0Kp7PbLnWDwA2jVlksEUS34bwNWCXYCFo99NdPFJkSvpEFPaQeSm4?=
 =?us-ascii?Q?vipjiW9+jZhfm9ZHBiS5ycO0fF1dQYkCy29otUFwvk8343okFMeOokzttJCz?=
 =?us-ascii?Q?0CGk+lADmBwRQVy3RSS/P7eijb67GRDdVe0oTP94RX6dzFCV9D2rKsQe2S5Q?=
 =?us-ascii?Q?Fa89sySpj5TueJpb0E/fsHupCopQ3dVKMjQvK+iJSwD4UsOk5fYArFbLLS69?=
 =?us-ascii?Q?qEiBDq2vZRC0lMkxpqCT3kkblBvIvPnMf8HYNaXCfBQsTAtNnMu76w6dT0yA?=
 =?us-ascii?Q?6MKU34FyAVeC5oXyhAd+AYCsx6BoieGSBKi/6IRI0OtzHia4/a6dUv+uEs49?=
 =?us-ascii?Q?ilQ9R9+YrHZpHPCWqeLqh/QCH+fd/aEwgIXTfK0j8pbaNkDxsn4Tr+NYlcTU?=
 =?us-ascii?Q?xk788Bf0Diguy7lMWWIr6C94TZNB+65oh1JDwG1odWd2DVXyc9eq1jiel+bR?=
 =?us-ascii?Q?LBIm+i7ObMGlLAZEIGgKIDLIrLIdNjDlnczj1iSNTeWHq78Mj7vOJ3j1cot+?=
 =?us-ascii?Q?OyIgsgTZlq0/WEmpJnvwLxbdaSyciQziqt4tfRg2iWwN05e8CqXOZYV5/V6y?=
 =?us-ascii?Q?RxejAvWmF+HoEMGrL1CHN2t61MN6tFqEbtC40l9nnBdJi50w0SAU/ORYqoLP?=
 =?us-ascii?Q?GiTqvgtUk3sJz3qLBJOCQEcatw9GkFbQmdqy3647+1/DbuW9eOCfY8K3KbMt?=
 =?us-ascii?Q?iv8Irhh5QZ/tAjF9kOSEam4O0TCzccZA8ZsEOSxt2eo16eyoeJyywD736G0w?=
 =?us-ascii?Q?l4ZtqjAmqw9D4U6JwdyBQOc63tbpTUGUUqqDBvc3fhJZu/IW/Ae41CXGPA+1?=
 =?us-ascii?Q?uYywmbImr7tlfw+HTBfA+txYOOy4glxBdv2T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:21.8387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b41fa3-c2b5-41bb-a6cd-08ddf6945045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Add sfc driver as the client.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h            |  2 +
 drivers/cxl/core/mbox.c            | 51 +----------------------
 drivers/cxl/core/memdev.c          | 66 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  4 ++
 include/cxl/cxl.h                  |  1 +
 5 files changed, 74 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index d96213c02fd6..c4dddbec5d6e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -90,6 +90,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+struct cxl_memdev_state;
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bee84d0101d1..d57a0c2d39fb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1144,7 +1144,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * See CXL @8.2.9.5.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
@@ -1300,55 +1300,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
-static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
-{
-	int i = info->nr_partitions;
-
-	if (size == 0)
-		return;
-
-	info->part[i].range = (struct range) {
-		.start = start,
-		.end = start + size - 1,
-	};
-	info->part[i].mode = mode;
-	info->nr_partitions++;
-}
-
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
-{
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct device *dev = cxlds->dev;
-	int rc;
-
-	if (!cxlds->media_ready) {
-		info->size = 0;
-		return 0;
-	}
-
-	info->size = mds->total_bytes;
-
-	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
-		return 0;
-	}
-
-	rc = cxl_mem_get_partition_info(mds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
-	}
-
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
-
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
-
 int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 97127d6067c4..d148a0c942aa 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -556,6 +556,72 @@ bool is_cxl_memdev(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
+static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
+{
+	int i = info->nr_partitions;
+
+	if (size == 0)
+		return;
+
+	info->part[i].range = (struct range) {
+		.start = start,
+		.end = start + size - 1,
+	};
+	info->part[i].mode = mode;
+	info->nr_partitions++;
+}
+
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = cxlds->dev;
+	int rc;
+
+	if (!cxlds->media_ready) {
+		info->size = 0;
+		return 0;
+	}
+
+	info->size = mds->total_bytes;
+
+	if (mds->partition_align_bytes == 0) {
+		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
+		add_part(info, mds->volatile_only_bytes,
+			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		return 0;
+	}
+
+	rc = cxl_mem_get_partition_info(mds);
+	if (rc) {
+		dev_err(dev, "Failed to query partition information\n");
+		return rc;
+	}
+
+	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
+
+/**
+ * cxl_set_capacity: initialize dpa by a driver without a mailbox.
+ *
+ * @cxlds: pointer to cxl_dev_state
+ * @capacity: device volatile memory size
+ */
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
+{
+	struct cxl_dpa_info range_info = {
+		.size = capacity,
+	};
+
+	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
+	return cxl_dpa_setup(cxlds, &range_info);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
+
 /**
  * set_exclusive_cxl_commands() - atomically disable user cxl commands
  * @mds: The device state to operate on
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index cdfbe546d8d8..651d26aa68dc 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -78,6 +78,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE))
+		return dev_err_probe(&pci_dev->dev, -ENODEV,
+				     "dpa capacity setup failed\n");
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 3b9c8cb187a3..88dea6ac3769 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -243,4 +243,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


