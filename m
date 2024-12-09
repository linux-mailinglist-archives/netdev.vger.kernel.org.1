Return-Path: <netdev+bounces-150343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9169E9E90
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A3E188752A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556619F487;
	Mon,  9 Dec 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1oAmEI+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEC19F43A;
	Mon,  9 Dec 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770500; cv=fail; b=bDOcs8KnyxhxyQrRb16TCOZ8uVc3i0QokGoctAMm31QU5EJVRQtkpn+0M+GgkVgtVyo6kfCheWNw9EBQOu7bKTm6IiHGT6i/fQdruPgV8t/8OZd/TkwSHDLfMhGqGjxTxcTlKAWlHoS/YzJFB9bhwU5uRajn0CPBvu0ARcJIj1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770500; c=relaxed/simple;
	bh=SBktf+O1HL1llmuQXTza6TpomAcDKYjNe04l/7IubNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfyU7L1MfX+pE6x4coLOrLMCN55MR0QGTfMG1jZBQUGjFlPKtcvDS6BMsvu0gvJXstok/KFisdI0S1S94jxH8k46u/PPl96T6UEmNIJ2IE8N54H9y5AU32YY3VoS0QjgblcxLa/JwqkT5Tluz2CxYjCGcA9VcN9Xi9O1lTaUmxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1oAmEI+; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1mHb6vXcAmlV0citjWqRXUTHyOVb+ksJBiT/J/tBEikTseS0RwtzyRCDJpzl+8TT1/kC+2BZZ6D3QPgQsq53hUbiOlaOMJyvXC0WWHQhDBCsnC7UmSOJ/MMb76l3IRFFisC6tZ1neMFK91uVLaps4Atiy4uoeAJ4MkVzpikbFAJcWjt6JGBDjzEFYnMlmCFxdmZ4wTqC41SHP3SCS9+svBVevJo1g+peSBQpAx5669XUr2cld9R7/tH8pNaKAXLGnJjgX9quicQfUCO+CSIPedCZtXxLOwAI/385SeASpUqlz8d/CjPeYJaR8a+tJVFx18Tawflr6rj4N6pF3Agzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y1Yswsx27rhVh3kIKnpme2N5P7pTPK4xAK8ek3z+oo=;
 b=IsN8s1KgC9Z9GxUCWg4/0b+PxZf5NuP91fistDj0H4Okv+AacYJBa3SANti0Px3shH14KQtEqTZL3LRR0d8GIPqO1kFJxXjLrtMrlW7PjuYSbByYX04XZ+iWdO5N9y7/MMl+DmM6EMl2uLfHt06sTechQugGh5LiUYKyKLoZTA2LLM/FZDKMAIZQfzaDAV41hz/Y7V6ElWwe5SG/JxQiWSiQzWeyQNh70kkXNKK4BPFMelUUO31qtwwfx/B7oak17HZdFWAd8nmzhDfnXJ0CdbjuqKXfaMSVtj4h+QUq72BrxJJDcb27X/9bhqY6xzE+Zkl/VJqIvc5fHXxSKZ7I9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y1Yswsx27rhVh3kIKnpme2N5P7pTPK4xAK8ek3z+oo=;
 b=L1oAmEI+wDPGIQn6YF8oyMvccfshjIa93aDc2HskfpHMB4rSGyHsydwlTVZlppkFJLyHZjTa/O4oXWYCecQyhURae2WW1Zl4+BYzWcd8SYUwFr9yOkdI4fM/4rU5b7iV+wk/PbOJsWjBydMP6BMWSAQOe9WcHclnoQ/HAZHh7sU=
Received: from MN0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::11)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Mon, 9 Dec 2024 18:54:55 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::a5) by MN0P221CA0004.outlook.office365.com
 (2603:10b6:208:52a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 18:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:54 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:53 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 11/28] cxl: add function for setting media ready by a driver
Date: Mon, 9 Dec 2024 18:54:12 +0000
Message-ID: <20241209185429.54054-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d1565b-5e2c-4374-208e-08dd1882f890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7XS0+mZElrA2LXK4sMkSKAQ+OsBRkmRj2CSUO5FkFUkSac/L2nUUrtlv/kTy?=
 =?us-ascii?Q?jO1aZqukOg7arRRC0MMhpLMmSHG7swENTcozTnc8l5QuTeucDUGFv5rBNeQa?=
 =?us-ascii?Q?mdM+c4LP1FgG7xuZLH9222vFfhKI5wTeCilEPHYLBuCXfcgQ5UDP7tb/rrXX?=
 =?us-ascii?Q?jrffy13QvZdZUQ+Z7ZDyGBFhdi3hbYXjfG7T9ZNWyJk06mPhZMJzJhVfCIaj?=
 =?us-ascii?Q?cBjlgEduwmOa9zXeB38HrZPJw3QHeu5SVFm8DzFu/xrpolEuIPcbmxixjOJ8?=
 =?us-ascii?Q?UI+6M2yKnzpaQzvfHAt1/r7ZrVbMuo3pRmCAtVi8f/yX2FqfvfZOryp/obs/?=
 =?us-ascii?Q?XMevkmj0Y1kxGejiTHE1evRASUEXA2Hw3PYisbSlbDWE0l50BXvvEYe/+HGT?=
 =?us-ascii?Q?ToutYlbMjpdNKNofehPXVAY6RAHRwb5LLn1OwVmEK2Lpgwaq7PjerSjI0Lev?=
 =?us-ascii?Q?s/Cfe56kUR2I6lkAAqlVYgyFQquE5BE8P4npi/PwcySXHjBayDNhsgaSzj33?=
 =?us-ascii?Q?QyJVUXeDIUK0zlo2LF1VhPzZNZ+F+6aD0F3+DtGiwPP36fAi42tibwwwc0dl?=
 =?us-ascii?Q?pboGtdV2unydGWHeg1KJYSiC3OMTCfdRtSTmXfbzB1xKypznyePwiuFV54Om?=
 =?us-ascii?Q?XLGZjXC9+FTNd7oAms5vE/JC0zSN/P51V2KgH+RPScNWMwQe4EmF+fFkp5HY?=
 =?us-ascii?Q?czQeoX4aQwtL0l2x8FUE9ExSz2czPX7w9C8mOfL9rtasFaOLWIH55OANwq2v?=
 =?us-ascii?Q?WPu8rLjfgGWC1xadBdn9Ig3QxH0NwVWnlf8+fZ/qxYHA+LzOWqI/aaRXKxpw?=
 =?us-ascii?Q?ImngTtpZvW54aiw6YMHIpiHOwXzWXLdx9cOoM6TX8L2ya5gZCQpy8adD6zC7?=
 =?us-ascii?Q?6/2Pw8pPquExM3Nvw+Ov6xkfLXD7VJFwKSWB6FbKyj8HFMkU2/XkzEbFEgSu?=
 =?us-ascii?Q?vJLuYUA6Ys/4mXeSDVkkDMzfR4DFL95I1pI42q1Rpxk6BKh+44oxr5Y/BLUA?=
 =?us-ascii?Q?ZiW/sKXqSM8xt3d57wsfmUD9uLHTiyZyqAeWCmslRHplmGoUop5X76XGnPlJ?=
 =?us-ascii?Q?8KAChno4oSoARDsvazWj3AZZjZH488lg2yuuKmgmbNsZXsuGcjzaYIVK4T4j?=
 =?us-ascii?Q?2rMVJEI6HoBwTaKCKbIzBm6Shydlu3Qe1KMmyYi6o0pp1pW4aKLGqTyMBOdb?=
 =?us-ascii?Q?CLBGdzMFgMogLw0Diq8pHHP23kVY9+58tb+783NNGIZojlLV0GE0cHcUTDJ/?=
 =?us-ascii?Q?AUsSoDiju+hdisVsGAetUHjOPFgVZheL5jKWGKgWxqGzPV63U2/fMEoysYHn?=
 =?us-ascii?Q?H5QvdRCax5sdwMSYwF1xBkLMLL9b2sfCIZUFcm15Ufp4JGcQlC6WQ3uRkVzR?=
 =?us-ascii?Q?IxgSPt7+j8OlvH1ZL284GEHkYyCBUNDJtxbrC2TYIovGYqCHFAw8M3wMDCeP?=
 =?us-ascii?Q?9a2CWBlMAGCkDgd9nJjfgMMhUww+VsLgEQ/2PNQ+GKHBbls/CbWlHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:55.0863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d1565b-5e2c-4374-208e-08dd1882f890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver may be required to set the memory availability explicitly,
for example because there is not a mailbox for doing so through a specific
command.

Add a function to the exported CXL API for accelerator drivers having this
possibility.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/memdev.c | 6 ++++++
 include/cxl/cxl.h         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c414b0fbbead..82c354b1375e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -789,6 +789,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
 
+void cxl_set_media_ready(struct cxl_dev_state *cxlds)
+{
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, "CXL");
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 44664c9928a4..473128fdfb22 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -44,4 +44,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


