Return-Path: <netdev+bounces-111568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD16931947
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934DE280DD2
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070A5FEE6;
	Mon, 15 Jul 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xgiQj5v2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1B535B7;
	Mon, 15 Jul 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064539; cv=fail; b=DDoXpqQo0YftW/CkmBH6WhinqLlxXXusOsMed7xfeBvT9jSZKb+835XVUY7LfWUCZ6Xiw5CKG6nPXRrs8KkXIu7dzcgM6o3M09YiSTmWNN+2eAXq2Q/Rv2oXSutBygz/tykm9kC9GpjQUKhaVRCa2wEc5Qlp1B+tP6Ble8Pgdzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064539; c=relaxed/simple;
	bh=3TifW9WFW7DjDvpsXYzB3X5fPqgcKoS+0+St87XYMNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTu2Hiwc+nQ79TTCr7c/GUw4QkVsfAZUI2NtWd3GApgdts67W1GmJ5D3sxpkESus8ek1tuHMVHmx1ov/67Ge/P6B+zsP+waur7oQCSTt5iL/Xyzf1bu2JousblYgStR4T8J6mW55o9GZHeXmTKELXOLnVlteagCFNQ+ZgNIEKMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xgiQj5v2; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ/d585n89kFudGFDgcI0iaeVcGzga1KZGGIn0yTA9rjzpPtkzLApfru0iWvKvyFYecrnB0xoyY3WKPvLB3dXvTOE77PXQ2mdez5zTyyxhclNekRilNuwdXhtYDr6qySjms26IhtEntnj/UM8PY1TlytZOG3WwAMfyLTvLJ2nksvidiUojR28GFXtbJSKoXb+tOkbyILZZ46GVmMpf9mRC+uVm84Phfa6kc9BDOQeciuwh/PJECZdU4gDkeggjUGFLsTcU0ucXtivcuOmmm6rL6ZcaX1Om1CWU+4Nm3Hmv55Y1dSYz543qn4Hnxe92VYJ0QW13LpfFkvRkh7+ZBa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2QcRmqYhrwOkpEDbHI3M4kvRFcZfeVsePYkcK6LbgM=;
 b=FreNl4bL74rLusYJTk3OJKCHqds+Oyc7CHXBqGujmAFQhuEjfOqbct8nY6Wt8Kk3wLQDDEFdTmM3jf3S6zVhuauDX620rrT86RKo9UwV+++mXDNGj7LLyPGkx/0SLTce9FXMeFPM/44Cvizd6kdA1YrsLSKGpASVGbGa7tolxlJoxS3t/CghZyoSxLVYnEcCWNcbNg0a02b9p+oOObCc1dWL5uKJGbf0BUMqdgc15efhKyPRQSxvPRP8UrP/O7QpEdAEkLhh4MnSM3xUoXBElaLlTCdIf0bACLCZlm9F3ejv+xQG3CEaDNeQpDHUgt2fGG7y/OZErEbuckdqKSURKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2QcRmqYhrwOkpEDbHI3M4kvRFcZfeVsePYkcK6LbgM=;
 b=xgiQj5v20ygqoIIfWFWyISZtsKp7VGMzj95AKO/D02Y6ffWnYafcP3PIYXWBOQ3QmXE+UDmgg/s/hv5aLQ2aSLFfZEPY9Emur3TmFtJ07QScX4RNEqbiN5dySUjXHR29sPUmqJwCEgaVd+9HXnnZ403RsoLZdy9Pl8L5Vbm+roE=
Received: from CY8PR12CA0032.namprd12.prod.outlook.com (2603:10b6:930:49::23)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:28:54 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::57) by CY8PR12CA0032.outlook.office365.com
 (2603:10b6:930:49::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:51 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:50 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 06/15] cxl: add function for setting media ready by an accelerator
Date: Mon, 15 Jul 2024 18:28:26 +0100
Message-ID: <20240715172835.24757-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b2a20f-734c-4a10-bdbd-08dca4f399a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eb2alPltNkuP0t8NC9hc6nT0Q01LrUSZbqlxn9PhrUupClqNI701jzl+kDcR?=
 =?us-ascii?Q?NSxHwBHLvHSwnHrLJdVKQ+i84rYf3fbMez+bSzlMrtsdoV7WhZMRs7zAr4d8?=
 =?us-ascii?Q?Dh3243Sc5AAC6YGRxRNpW0UH5t4Bf9JYSzxySZdZ+/UPBh8bqRR7LdkXCnl5?=
 =?us-ascii?Q?kjYDT8LSdBOKcQt8MN/XuU1JeHFDp76/eH43oHtEMFtxRQ5LWluyMdDXwi5m?=
 =?us-ascii?Q?dwp9qNVqanhIh4sVgWiM2Nl5jeVTOzyavlCAUZH08+DCra+LtdxPJqwf4BZp?=
 =?us-ascii?Q?obgtL7ADe4OSIKzPucfqh6pcB9DQfspi8jxNoAmeF2/6ANyGLeGA0QrGQHmj?=
 =?us-ascii?Q?qL2GxC8BClB5Rec5PM5BKtffrbYN38k31aWo4gbtUrcBpzr+WH8CkifPejVK?=
 =?us-ascii?Q?Wjas2QY5I0lzunrJRe7OZjV/42ZbZm02Lf0NjRPZWaCggJcYsi1SWn9l5qea?=
 =?us-ascii?Q?N9zdWmZOjNWnNqedcFINJYwkRqKLNr17b3YVXmN07E9UxssafJWxrjKNBIdI?=
 =?us-ascii?Q?kvDdkMT8TSJ/K94j3OC62Y/rLB4BLk/DC2LGZ+In0Coxpbkt63OxlM7Xf7Dk?=
 =?us-ascii?Q?duMXm7paovaLzAd4riBb4Dq4Fc3h7MUWT42Vh5pEqNgFwdwlwNDcsk46W3MY?=
 =?us-ascii?Q?sgZ7OL5zsKg8jFddkExl/EonZjVQfMDAjWFycftmAiyZv/XB3n8xV9s3JBxV?=
 =?us-ascii?Q?nt8fXWF6agD/FYIp8GI4oMY5liuRppsaP7teUHL4q6goefWdEAdq8y7BR+bT?=
 =?us-ascii?Q?9K0qlmAH+slF46wKuNjiJ0aE1JGFh9i/Z8U+o2UQi/N8zyy7H9Fs+nR/raDa?=
 =?us-ascii?Q?+Rr6RpcBqku5TsNSrSpc2WsXLvpLUMcDilv5twxmsJQueIQ8MG/ydhftrJLz?=
 =?us-ascii?Q?jyq2JZm4UyFT0X1dcpgWZ+O/ZX7TF8M+C3b0t3XJ+cDlSLJyNMlIOH5rbScv?=
 =?us-ascii?Q?VnbKI++flcH4Bedw7Ch+SEei/xFEJ/p6Rnv2Sl3tFjT5lIMaLP8ShhStdcBq?=
 =?us-ascii?Q?j3u1pSukQzO5TBtOFzYGRC7+L7+hZ5FkYQCMGxHG0t4qpj93y1vWXIlamfGM?=
 =?us-ascii?Q?o2q5iJoOTB1nVyGWc4iTnuhS89wYXk3YtykYmLnQrS4Gm6qky+8Ep0rXjU+S?=
 =?us-ascii?Q?jDkhi1Zai6G5nharFECBdVvosj0X0/4/EIDiH3zPA2ButeaZ4tuARBygf0Yp?=
 =?us-ascii?Q?iEfupQBYDNrUnQ5hKbgs1q3LfsF9c8cetvUkwNk96HVTdsA4lev9GrFQdph6?=
 =?us-ascii?Q?1K58v66VVJfKPsvAJLBL1Hv3wV0UtaECuOSYCwSAe7otfl4eDBsaWNSrkXsu?=
 =?us-ascii?Q?8A+HT3Dv+NwK9DhiQOmwpS7MqBL64bi+mFd5bCg1AHzJz0gmhOnLprvLMYOB?=
 =?us-ascii?Q?INbpRiGpm69QMDCcJzOYMn0PsOfgR4wnETsiUMx4VQK0IO060fq6B5NyGNtK?=
 =?us-ascii?Q?0ZQePeMtaO5UDKtPjMYiu2UgnjZ33vcLdy+UKF/1q+ZiUrDKgBMWFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:54.0276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b2a20f-734c-4a10-bdbd-08dca4f399a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver can require to set the memory availability explicitly.

Add a function to the exported CXL API for accelerator drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c          | 7 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 include/linux/cxl_accel_mem.h      | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b4205ecca365..58a51e7fd37f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -714,7 +714,6 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-
 void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
 {
 	cxlds->cxl_dvsec = dvsec;
@@ -759,6 +758,12 @@ int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
 
+void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds)
+{
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_set_media_ready, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 37d8bfdef517..a84fe7992c53 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -56,6 +56,11 @@ void efx_cxl_init(struct efx_nic *efx)
 
 	if (cxl_accel_request_resource(cxl->cxlds, true))
 		pci_info(pci_dev, "CXL accel resource request failed");
+
+	if (!cxl_await_media_ready(cxl->cxlds))
+		cxl_accel_set_media_ready(cxl->cxlds);
+	else
+		pci_info(pci_dev, "CXL accel media not active");
 }
 
 
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index 0ba2195b919b..b883c438a132 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -24,4 +24,6 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 			    enum accel_resource);
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
+void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds);
+int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


