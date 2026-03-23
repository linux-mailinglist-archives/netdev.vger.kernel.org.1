Return-Path: <netdev+bounces-270484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPzgD88kwWmTQwQAu9opvQ
	(envelope-from <netdev+bounces-270484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB42F2F1414
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF8383012D2D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6652396D1B;
	Mon, 23 Mar 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xp1mqYnf"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279439098C;
	Mon, 23 Mar 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265531; cv=fail; b=WGlDPJEYHB9/STzujiRVpK7+xrePtsltB2OW2+7xwVwfg8r7J5QKRz7cpk4zn0+I0jW3Go5IGpefZWt/MAEPHQ42PTiOtTYFEzLDOneKlBQkwslv0QGRpeEFNH+jW2MYTUsXCg+JTyyYwRn3tbWVrx6tB9avd80kY0uiq1y5NiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265531; c=relaxed/simple;
	bh=PL9KpwaYXS2zvCuRJGL27nl1hQuhR0faoPQxstsz9w8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR/otvzdS8LE2mJqu6gvB+RlYbk4d3TCi+WGtWKUohRv7fnhSW1bk50U8jHc7033DiUoPVMQ74fcSPYFLmeS2Uqy1eS7KF0HiggnZIbra95xcLI7GvsjM2Np0gSrzKGuV/JHak5NIkvVn9OkjVCYvmzjLFJt0azvyRNARWFexgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xp1mqYnf; arc=fail smtp.client-ip=52.101.57.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXtxYXg5m+lMnEeIwawHsFRTXmH3yHxuQBRyj7hx5XUBCJpDeEibgTszHL+MoqI4DjEaw2Ectus+/EgSKNHXWOFUx6FN2EMMFIyrtQQ3UQM9XpzNiOBudMsW+6bOm5DZHqVZlOUgHR5EskmFa6j/AKa4jt9pwV6449daoDB6w3aBUh2O61qkFG43wYuCvnloAqjVMbaN22yHuE+m1wvgw+9X7ofgZSbbCM3rg+/tUICLhYbqzg9SZ4BNHzlPA+qsT+yZwxEU69x6cjufyCl6SmUySdsNwFcaxLvApF6I1Jxk95nKPWzbXc4jrsmArXGUzPGPlHE98lqvUa6Ya6DVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vv/YdbqEEY0waL0gKQIQDa/Nklvs7/bSH1/lnvfBwU=;
 b=Fs2EgR3r3B4hdbsSnGLVgjKc9GXxsuEBEDQkKcKtj4pNMhLzTTTIyVjfpo3CutaGUqeREepgRpAOGIhaXuMpEbFlt26lA9c72VMehpCtnxmlqtDf6pL2BtUyV+ulKDKHyLc7uALvL2g/pW2jsPmOcvQ3BTVq5tKzQXeQyfSpllUB56qiBVUwf8MMIs0dpyN9pyie95ZpasLQP3PDlvO79vWO+q3R3vTk+pLSOmaZWSRbV4bM4rhiwYuAy6y31UuJqXYnQhu5aQkjQ1LvohkK+U6bcn8JWpXh+usDHSu4axZA0sMdfo/gu/tenZ8lrq8XqX4jEIss97uJBptfHG6VtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vv/YdbqEEY0waL0gKQIQDa/Nklvs7/bSH1/lnvfBwU=;
 b=Xp1mqYnfhGOTkGN6KdWfdfAzG6nSJaWa1WPLHXmmKb5fNkmrMh3OCLSxWYto1p6y0v4ECNlG081eiW0Vi3H6CXzNe6tn7yzouEIvAdTU5SmBNz4wVIXeM2ryzsygC6n4Rz+iu5qLzQFe65l9Ht5ecGIIl0KaZl+g+gcdF+A7n1w=
Received: from SJ0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:a03:3a0::9)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:04 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::82) by SJ0PR03CA0244.outlook.office365.com
 (2603:10b6:a03:3a0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 06:31:30 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:29 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v24 03/11] cxl/sfc: Initialize dpa without a mailbox
Date: Mon, 23 Mar 2026 11:31:09 +0000
Message-ID: <20260323113117.2352709-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bee2632-cef5-42e7-ccc6-08de88cfcec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7V2Tm7BEm+E6x0BrapHS0MX2+5+ubosxX6ExkwpRRLtlUE2IZuu9TWLGO/1EIofwJPZWsOpaR+fgyP4OqQYsLfCPzasrM0LMaMauoNDtJ8b3pJyxQ+CweddsagZp0e2U+veu79Ber5CDHZ4aLT971/TktIN9Mx2lykZWJaL6PeeNVLhhr2RNNEKNN1lMSe9CfpSZ/R1z1VjvYziaZOKQm6m49a/RwW+3TPMEsqoe+9G3ymHSNf+GNl/X2onOSvR4n2XiRxOrB4P0I0qIqCvGTSyuSWQ81UCPX9tW/XLin64hmcjAHBBesMm6PjEfg7ChQzzZeOXsxJtqNLAJ8yCzG72EOoZULpmccsfzfgAz1YR2nDSKOQCjoZS3BeK33CdKaRLwIkLasoN111u94DlP4HP3/XdBidYdO3dmPoPKNBmAKGIUrD3haH9C7+e3AkcZeqvGqxiJsHgIVfDd4YfPjszWVw23Fu7a9g0mipfpD9XX3dCJJAiHhBcYMUkLpCnMMaHt7n2Q/cUL0H3ohsTvK1uMs/1wE0D5ttqb9jxXvsVi0bJ0S3XGTurWKBl4JlPVFY5rbCW8cQRuO02fcrHPQNbIiuOfP5Uw0/dAbVC1mK4MnLaEWiCeD00JF9Rn8AjJ5iqzGXQ95HDYCt6XKwZ08FG45K5CRIARZmHVxOS85912lY+MKYGQ/Oo9UE6ADsQ2A4qraDHgm2v1gIQZasE+zBDppn4E2yv7ncUfzFVb12j0gvhbgnbjtxoyiVCJ6VM4FJu3VlbSm5F9y+wdtrhkHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LH9+fv0YYxV9MBLohu43iD+P/k3FMuhPjVgySjVLyKGy3RqQ7Fn2qhTbwwjGGWINWd6b+1NxmdJa1eCwmzNywbaNaqRCSiderTyxlNoUJDXDqAJMsvMQtTCd+bePuUdIe+QPST9+1nwHdLOqJnH+ejRhM3b7RPK1Q9y4nnQuI5Jrp7AeLN+Qc+y5Gk9yzptl9tYIrocA3Ie60qcbBAF8bzMbBEuBvOtTV6uY9j9ZbRIFMP+ZtHrJRcj8X5RLqNEdRv13Xm7r0dx2e6zitiTTXhaQOhEmMNjS51k4y6ot30/wN2V+ITHIW/mbPBaNY3T8tc29edh8cs0piAfSQthHvZ9ZIjXdpAX2R//1ls4hl580+5qcCi4vJkhAqleGxXEmF/vAFViG8OtMmxRvaUJVlbCkDS6nDnX0PvJLSavDWRpmgCCfCh1jhLRV+KPNR3wg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:04.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bee2632-cef5-42e7-ccc6-08de88cfcec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,huawei.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270484-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EB42F2F1414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Add sfc driver as the client.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/cxl/core/core.h            |  2 +
 drivers/cxl/core/mbox.c            | 51 +----------------------
 drivers/cxl/core/memdev.c          | 66 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  5 +++
 include/cxl/cxl.h                  |  2 +
 5 files changed, 76 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5539e941782f..77c684744771 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -97,6 +97,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+struct cxl_memdev_state;
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 451ff2287b44..cf37676068c2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1151,7 +1151,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * See CXL @8.2.9.5.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
@@ -1307,55 +1307,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
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
index 99e422594885..166ec6b7d041 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -582,6 +582,72 @@ bool is_cxl_memdev(const struct device *dev)
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
index 7917118e4eba..a52238ac9eaa 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -71,6 +71,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
+		pci_err(pci_dev, "dpa capacity setup failed\n");
+		return -ENODEV;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fa7269154620..1346771edc4e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -223,4 +223,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


