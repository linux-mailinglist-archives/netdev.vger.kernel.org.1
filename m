Return-Path: <netdev+bounces-136672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1949E9A29FB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D659B28766
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46B1E0E12;
	Thu, 17 Oct 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZUlqHVJV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9871EF09B;
	Thu, 17 Oct 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184020; cv=fail; b=GdCEKmsRaP0GMDyAZTevGMXV9+Phqb0GAKmXbANeOGnhgjkRXPdFSNkvJ1IZMrC8f04qSXhdIDYanL9hBpg6hNCpAfbBT4d30TahGQCsbzmpec2yyrrtBDN64XIJ6MhoqQCoZ0uvufTIILueS1JV4fB1Whtu7VZHsqifdaUZVJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184020; c=relaxed/simple;
	bh=uLdGuW6yVMudT004wdaexhblbBXHDhKXktqTQeI/nO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOtnQXPSLo4nx+iq8zD0iKPlxLIHyoLpEckUvDqMOb4NgPSL3u17DQWjCvUnmFabZ/j9jNba00/gNMEfCn8US0UHC27fBFJ7bezVKKXLgFLLqQeza4YSdelghcfhDBvBLLzMdNbYKDrj2jFmMsM+YjPceUEn7OdCor2jAKAqF1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZUlqHVJV; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSj+xerV1LY5XChp1sFADEFhbRIRQUpd0DiB8quG1bdPDwmRE8zeEUOCuXIPkDEF9prJTSk3c4YEfalOufA3rQ1g7CmzYimonOnGBjRFDZFTN4e0fzBMEHufS+dXH/p4plAFCCanFssiEKAtOSCZV8uZlpbOWfvmJu9hmQwnoWTLEnOcUFwEBGL45kx2VNMchvKikj9jMbWNDmv2R8Ti+xpXB0AY9xkcxbiKufxiDPMFmp3sFM6TgFbmYINcH0LD4j9GL/XC/yeVCP2kLC4ntM30Qq1eCyyNILXoA8/ev5Tj1eHX/iWTfDTHsOqWjFY9vznSEH+i/fENC10zMcWjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSG85V5DmsDnjekrHnduOWMtZCsqAB0em3ecH5WQ8O8=;
 b=AecMIvBfiPZxfkH1oP0l6QCEI+XHRrgvNgg+hiEUU0HqvyGRfLt79+99eyV6nywfu75+B47MCsguRVYzfpzfIlLTyQeMTUDj4gVz6om1qWUGwayJ+i3Z2MdHcldQRJn5W9EE6cDqPH4IJhKayyc4ETBGfzkGNxNgyvRVO1zLWBcYVj0QNd5xN+i/JpHBWXDyy1Iwc8BevsSl3AW+mU12MNY843k9WW+D/VDOrgvZBey6CH2zpjOabIUh6vwpsTov19sxMBj0uJEd5Z3+tkW1r5P868f3qXt9HOaJgm7rR8OkPrNkRd3+avHmlS0t0TtJM+3Bh3zstdwRXqNJV0om1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSG85V5DmsDnjekrHnduOWMtZCsqAB0em3ecH5WQ8O8=;
 b=ZUlqHVJVVMhhB362wAMiku2l0+9uAEQwADgfGiLeTA7pMTOyFP9QAQKhzUalxuxqJoysRnCPT/SCxrv0Xor45wVJxSbanoCAQejVjrm6Z3wYVVa9GgcEUl23N+Q/BIw6nka3EdYetLQl4z8A1kTAg2wF0UA1RNMWy8iI46Qmt1c=
Received: from SA0PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:d3::31)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:29 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::c5) by SA0PR11CA0026.outlook.office365.com
 (2603:10b6:806:d3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:27 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:26 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 11/26] cxl: add function for setting media ready by a driver
Date: Thu, 17 Oct 2024 17:52:10 +0100
Message-ID: <20241017165225.21206-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a427185-204f-433e-5ee6-08dceecc3a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BuZ0UfeJvG9PiIhjc6ZkCbzDlws213cB6O42wlOlkQ0geVq2Ca1ScMmjvQCJ?=
 =?us-ascii?Q?edGKsjzKlb6ZIBCuRJ8ZHVRUqPPZiaCpvEjn9DKqmwML+R4hmagBsUxH0qDi?=
 =?us-ascii?Q?DxgEVqlc17NVXymqR4iVUn1hGRnPOrPHnk6ctw5EBHUNIbsgdzI61qPXYoq4?=
 =?us-ascii?Q?rR5h4EMiVQI/ZRR757wRB12XiVozGKZ/IlNw/OmsoLTqBFEIzElP8ydicrjM?=
 =?us-ascii?Q?AY+nxMGYcN88lOwvv2/9eSs3DtGcaTA2gXYlr98Mo7s6efUpfQs5U648+/BY?=
 =?us-ascii?Q?NXYnFC0EiZRut0IBcepVLe2Q3nnffa0so7lI9By0qTZdwFgr58SbiQwanTn1?=
 =?us-ascii?Q?w7qRLSKC7yIapEDRcn+pwO2CtA6MqDJUMZOvIG+cMt7LE35cA5woGutTR2jt?=
 =?us-ascii?Q?xTNoVXX3ywyiG2Dkd2nP4wsUqn4g20vySEUmyDmf8jw53g1cQoL9GZior+Bb?=
 =?us-ascii?Q?SXZYbXTbTQwyofkFWhfnimF004SRW68oBwgDRp6LuE+3FJUYw7HveSwV+7++?=
 =?us-ascii?Q?115/jDcr/CtRFJxr0vjrp/jD1cNHkmMC0vdhLlcFBw/TjQ6/vVRqw69Pvmp/?=
 =?us-ascii?Q?vKYwzFdJtf11+CCNFB3mGMukdinV+elrUP1LomR8ZJGjGIg4PcRRARRcbHHF?=
 =?us-ascii?Q?N8iAYb7PaZZVWOXvfzA0lFH5MC/57h+pyXUd9nqo8V8bc5qfO3YKVYIiiOzu?=
 =?us-ascii?Q?YSTjg960l+DE33LugB1IWQ9cc+PIUsxz/VP1y7xtQEEt+1oFsbeTuPuUt1kH?=
 =?us-ascii?Q?DOWz904KlljyApOxPiE/V+giN+b/BzaLKC7k8OociIv4l92P6m+vXA2jZJ8x?=
 =?us-ascii?Q?ls43jxGPUoK86DTf2YVBmcKTYbGZUCFQaupjjKd+FBdkXptZ/cnQ1xZDOpQO?=
 =?us-ascii?Q?cDWnYEcte4l5uWJsYtMnGU4w6MYVIql0DjpxWjBHUR7OICQxknEk5mym2OZ7?=
 =?us-ascii?Q?y5n1EHvG0xPyn3CHzFtDWAJdYtrPdzh7z14GbthYO8TNmOmId5/XVAWfUppW?=
 =?us-ascii?Q?T/MbGJsR9+yBjjA/wnVqUGCS8MVEVrV0Znwjcoe0YDpezDMY8USvYx4Ia17C?=
 =?us-ascii?Q?s4+KcSL3aLKvtyHohJfKgcrurH5y7b1GO97fw535Z7U5ZQ+LroHog+HZTt4e?=
 =?us-ascii?Q?lVHlKqKlkHTki/dX9dVjzuaJIPMXmVC+oio+TYKqarhBE7ikjwP3oo5+YiZH?=
 =?us-ascii?Q?kboMFEE6h2PcIzGcR+/3CcMmKlYbibXmUwxAPhmwZMcE6C6JxkLOv55alveH?=
 =?us-ascii?Q?jLZ4jRQQn9Nl+Y7u4dltxQWEuxaq2kTg7qrNxNdEB68aRPNlQPOnVCAGchxP?=
 =?us-ascii?Q?nICKcxKu4eTSq7FmEwRVzUbDB6nowMgPoBj2qEKvAbWv7y38HdGS5ooDO6qq?=
 =?us-ascii?Q?GiQSOdZIOu4b5YsnqGzONT/6cUJ/E6HnsE/RXk9zc+lzsdx0bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:29.5515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a427185-204f-433e-5ee6-08dceecc3a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver can require to set the memory availability explicitly.

Add a function to the exported CXL API for accelerator drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 6 ++++++
 include/linux/cxl/cxl.h   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 4b2641f20128..56fddb0d6a85 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -795,6 +795,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
 
+void cxl_set_media_ready(struct cxl_dev_state *cxlds)
+{
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 6c6d27721067..b8ee42b38f68 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -56,4 +56,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


