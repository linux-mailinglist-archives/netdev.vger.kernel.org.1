Return-Path: <netdev+bounces-111567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8FD931946
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B251F228DD
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086D55896;
	Mon, 15 Jul 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4FlbBdEx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528750285;
	Mon, 15 Jul 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064537; cv=fail; b=ZcbqYCpJddVcAQb0B7KD2iZ+01BFWNnQ5jlS9jMN+Y0NncDmXO0oH8lpgC9RYekC7XgSGZqERcydAQNZy/0u5Fac5iQZNzi01/VC5ybPmlAKTQY/tNvwKolvYTVOsW50lfIVH5xqXvmJMJlEJJaChpF0qB+Soq5OqolmYqyoHfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064537; c=relaxed/simple;
	bh=jWl2LN9rAvMP12J+Jb5x05YIg2LLk0ytcompyghuznY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klJFXg/Yr0PCF3qFaQsuozSqdGahEnOErWjFU52f3JW1ssrt4wjeMoHJlmszxMU6IcBhMXZ+paELGzAGSIhAiYJXQnZ2OuW63G83Tem0LJgKtGb1z4ktU1kT6SlwK4LfyTDHkgBPr9/IFoPlZi2IwwJ/QxXpC09weQ3Iz8KVWSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4FlbBdEx; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7M+pomQEIJTyZsALy5kk3BQHfB/fi/A7i0Qf5Lr3sbME0er5JkxotRyuNtjSvw4MiVA/aQgb/Hso9lStUORuh2wso58AjJh3EZok9ojL4HuRAs4ex4EQXSX9XrXJkj4IzzRbDvXi6AFtkzIck2tpnLCPSIGCFQ7VSfm4Smkv5bwMOq0RFNRKGr1+Zr0M/ygE0z1jNvVzHEuKNsR/wBCoyNMDu3Jsok5SPVL5rTe7Ax2aA6QsvvTgRc/QLm76ODo0NQ308ry/w+ek4DLa9l+8tdDuA2otHE8ovV7HDGmJ+Wk3VuPUmjhq83Y+Cbu1vaREXYAzu/jANcjgKGMdIPXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3vC5F3A/E95qWGqMXa9QOWGkI3xa+Vj8uXJAL6p01k=;
 b=sDDKOepsZeTybT+tU0FA9S16Vh9b3i0X1lnHCQkrhQXptWxZSDBQUg9QeUA3mm8RtGcdAOtPTbbtoQbUFVBtg3PHNEkgiUMT4MZVKaRYVuYAsZiNUFAwHEuOojM5fWSVWZ1LXomjRUGTVRdVC1PRalv1zTO8RiOcc6BIG4D6X/IAqVQ/sk/5M0eHzptkDhwShEVGh0nXc0RdQ0h5M33iKQ5AgDbmdihLa/tkT6RYamIcTsH+T0lMYgwA0vKMKyDlVTRRFWwwJMH93P9/ou3dXwfgAGAMLBaoLFhJ8YhnIppbHYK7znTi3TimcLQu7t/O/8IJNdH9WBIH9G/6fkc7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3vC5F3A/E95qWGqMXa9QOWGkI3xa+Vj8uXJAL6p01k=;
 b=4FlbBdEx1aiwEarsnwOU2OrCUcQYy+JTss0L7aPxPBm0rRjuGVknFE08DEmTOpxy/8Q0g5HASoUjBXdMqt9/Kxtqg3d6xm+7+IhDuQlTQF012DphX3nl+EiyS1I682/QZ8rLbLZ2vTjfklLCmXheC6KxYEeSfL9CwAOhpo0HP00=
Received: from CY8PR12CA0026.namprd12.prod.outlook.com (2603:10b6:930:49::27)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Mon, 15 Jul
 2024 17:28:53 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::63) by CY8PR12CA0026.outlook.office365.com
 (2603:10b6:930:49::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:50 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:49 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 05/15] cxl: fix use of resource_contains
Date: Mon, 15 Jul 2024 18:28:25 +0100
Message-ID: <20240715172835.24757-6-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8b144b-87bd-463c-2494-08dca4f3994d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O3b2mkGo20isTVj7WbO7mv2Oew3AnM8D/1JB58qFtWGPb9J3bkHjxQl+Dc4Q?=
 =?us-ascii?Q?jH2Bmb7HRzTD3+AdgYzlc2Brp0kv7Bqd9+mO0wbxV7WA7SqPV9D4S/yyy6uP?=
 =?us-ascii?Q?i074w5+dkOGz23IZKKXbUG804qEBTIRLa6IIWclc+c2ctScbqXhoE2t26KGM?=
 =?us-ascii?Q?E/4a+RO09whrxaLmtBDJj+TiTMq2hLo/1r5IoLq9eOZ9o7jUeq+b1H8Lo2BN?=
 =?us-ascii?Q?zaTBsNuSxxpi8fUrK6I2/PQxVzD+n+OFDCcyYgCincGnC9pxLHDhoYF0buuq?=
 =?us-ascii?Q?TYylBamiOyR+c7uf1m1E1eJErGd2BNlstk0vC0mmkB2g+5Gj49vx4UqXm3Mp?=
 =?us-ascii?Q?8eyKjJGutz4qzRlGsFH5lA8YKdaiqAn5tAaVtREPQNl0bFjUJzDXHBvJ4ftl?=
 =?us-ascii?Q?3rU0+DjbVtckyQErnPueXYRiWV9xZxi35LX+wo3rpbV62r7a7AH3WK4uONYt?=
 =?us-ascii?Q?itXuVvTX+KPIl9Ljo1hemymPl4lCvU3eMJ/a/VK+WKr3BSCLleNczGfo/Yxz?=
 =?us-ascii?Q?4Ptm6GQrqyGgXDSIhpidXPCvWRALoaS8Y52RcizPgktydFdvBYBnd5xrxzdm?=
 =?us-ascii?Q?mW6b8bOvblUJI5ODrmrB76EE0pcYK2STVBVKWJlV5sZoLttdwQwBzF4asW1M?=
 =?us-ascii?Q?bamUiOnQHVwPJYkFUJP1+vx5dvXHi8ikQxZ6vbk+AHfBXa3ncxilwdFlmpzi?=
 =?us-ascii?Q?Eu215wgVMcb6QaFXij4HopQupgMhB+kIOiiKqYNHPAtIGUAQNN/ZjKAZUP5T?=
 =?us-ascii?Q?9ZOg2jncTRrcQBLjUnH2PvSq9e4O8rQMKqY2EFtInQi4oKv6JZm3NOHYsf+7?=
 =?us-ascii?Q?G+9fqbgZAtsVLxZyJFdOQke6CUvCMtq5Ar9SjETVmyP84urDb8os8+BCPs5C?=
 =?us-ascii?Q?Q6uubxMHLRr5aBASEfhPOtsgy2t1lYvcy8RMNEPdOjWDc6HZQqKfnQpwdeMg?=
 =?us-ascii?Q?YjQsvAP6gbf7he6YbS4NnqWrqKABe4sXuajwVAXkjhyw1Ygiiq8+7y5laLbX?=
 =?us-ascii?Q?90gl4hsi1UJRLkmx/QGfBQI9dD+sazHVvsZvJHGyHJci4dcltgfrWyUrXvl6?=
 =?us-ascii?Q?B8nen1mkfEudJXyErsjgOvc9pBN3GqDN+Zwv0mN9fedDK53FVO8c6RpUr7W/?=
 =?us-ascii?Q?3SyHJxE/N+HrUc40kMVwEyUkU5fXsL47s9bfwOlQQLi32pxEAVZ+aVmfFIrV?=
 =?us-ascii?Q?+RJpk4xlWntTws/JLi7rSo30v0hG5Ag7SfWGRU+BCNjmPFFjOxLQ9LyMm/x/?=
 =?us-ascii?Q?dtUNot4vq8//l9EaA23LCO6o1kd8/4vEeQ7VEpt1QQIzI6sC9zoNPvMnINgj?=
 =?us-ascii?Q?0cnXFjpJ8gakGWtkJCDmzmCw0iM0/1UjGGUG+YO9wE8vtp+oYaQC2ZMvLlo4?=
 =?us-ascii?Q?Ek9EFlZQP09fz77kCFGOVPMlIxyTZ41BEb/QfjJTXc5L4zbjfpl/LdYOiUA1?=
 =?us-ascii?Q?5UEQScCk5a+bQi2jk0xHxvO7zzNHKHtG0LxT1dVeuT2TKgFabjIPlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:53.4339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8b144b-87bd-463c-2494-08dca4f3994d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448

From: Alejandro Lucero <alucerop@amd.com>

For a resource defined with size zero, resource contains will also
return true.

Add resource size check before using it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a327..4af9225d4b59 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
-	if (resource_contains(&cxlds->pmem_res, res))
+	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
+		printk("%s: resource_contains CXL_DECODER_PMEM\n", __func__);
 		cxled->mode = CXL_DECODER_PMEM;
-	else if (resource_contains(&cxlds->ram_res, res))
+	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
+		printk("%s: resource_contains CXL_DECODER_RAM\n", __func__);
 		cxled->mode = CXL_DECODER_RAM;
+	}
 	else {
 		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
 			 port->id, cxled->cxld.id, cxled->dpa_res);
-- 
2.17.1


