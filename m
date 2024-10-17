Return-Path: <netdev+bounces-136686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E659A29DE
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AC31C20859
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728791F8EF0;
	Thu, 17 Oct 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KpkyGqeU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726831F8908;
	Thu, 17 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184040; cv=fail; b=tpyhO1y6Bpo95jowNRNgAb6vLN3OFk1qGsBRovsDw5Zpt4jcbZU5X9lUP8+AwnNKwPXHZlIzhkfeW5PfIhax3vR1kR/XEzc5ooG+qStcer1V06IgDa2jsnI//I55I3um2FBcO78LFLIH2GJm0lsLv1clNuHBWLmOb+A1yE3hjsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184040; c=relaxed/simple;
	bh=Z8vhxf9zpg7F94r/9FLX4DWSfEr0EY/wm6BvikPvWoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTraQKYMHu9Ecf4yYVSOKS2qAl0bptDpCSbxbvoHlzNLmYSjq/BLJw1Y2S9sy5A05kGmoZCTgX/DUTlMnmfI3tr7gliFSKYQC7T2WLJI6nJUSeSyzxyUui6uVH1anyMfUm0obTj0gRsE2R63qrxm1flZUzmu/VxfZSktAdjJ+jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KpkyGqeU; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya5Mt3Pgxb7/FrR+JoH1Ybw9LF6P/KrrVwSCIzdTY3vsHCXZlHu2p/1huJ8qEuVT7QQ4wns8vA9ter488qUAa8shTHpUg5XLK6sp49zqozkT++umaMmRFVhZeYGL2FkP6KrauQsNUrqsTjNjUCoL4i8r09ICpdF0TsBvJBCsuVM7IMd39rcl+b4OE2YzOF6WgCikZFMVuncY6WiLlj4eC6ORr0aXD7IcJMclexaqK0uiRFslE/S0mGsojtd4VkL6ANMQdk7aETQjHi93lU2iO/MxJJ8WcrUVGsOzsTFValpPHVI9DMOAFIHI653mInNruPVdDB22GA+r/p5K0mWIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQtSW4n+HjOVh1d0iJk8uO6RCmVe6Ol4u+aIBgnQMj4=;
 b=x9LFTgmJKNsE6gIhp1NmFxoygy6TDk4LUxUm3/crTbedTnbbAJhbIVvSOVzQCqtfJzfwznq/bk3oH/RahhXSGTU4n44ITMOxkaFx/W1qsDFTrrdmqAnH8OlWRHzzCYvmR4IrWnVbGnJvGrbTRLlqNpk7yY+bljVssTyMMkVgdu0ajfL6vlNC431kujeL5WSVpe3XufchAFloLMipRDch6zZ8nCJRE1S3kBLy44/LA7RZ2zxNq2pZY5HnSEn6qK7cQvOKoH5p+Tzo1t4XoI/rAK3cpbBrIbp14I+1JsUUTIaCteEHlsxIdrYMwAplT27EF/06XYM68q+xJxSGwxlXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQtSW4n+HjOVh1d0iJk8uO6RCmVe6Ol4u+aIBgnQMj4=;
 b=KpkyGqeU1I3t2A2T3XZzP2UD+mIB7sQMtrcr8H2bluihLPEfGbsYfjhnw1rdoBDQtxUlSxx5KD9TF+ODnfK+poDCAG7CHOn+aRcdvQnw84p+RJvB4dnrEK5Q+1qGsirVJ/p61NhSkisoF9n4CAfE/Lwe/qiHiMejEowqfaiuFnE=
Received: from SA9PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:21::26)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:53:51 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::94) by SA9PR13CA0021.outlook.office365.com
 (2603:10b6:806:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:48 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:47 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 25/26] cxl: add function for obtaining params from a region
Date: Thu, 17 Oct 2024 17:52:24 +0100
Message-ID: <20241017165225.21206-26-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4721e2-c08a-4170-b6ed-08dceecc45d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFi8+2M5dK0I7ZVdFmZkJAOUTtj/mgUEC89M0krfXGGmoGKrHj8XaAxgU+A7?=
 =?us-ascii?Q?i9Sh+aPe6LyLNwNzyvrAOXWkRByQCcqgHmHGYhlI65eyfHhj5q6mMCToVcfc?=
 =?us-ascii?Q?JHogo5Ov7ABQhTKKXp6ZGU2zWStGM25I5JED+injhHtUCEiiZdaGiX8E5ivK?=
 =?us-ascii?Q?RCUYGj5CNfBaOCibGDiQRiGU0p9q6lzBasBJGHuP5B9m8pp5e3j9b40L3JFu?=
 =?us-ascii?Q?Qu2HvwrY9J/WGedaLiOw/WseubYdMKbyL8gysgmzgUpd2FOjFrEzXnJK3l9L?=
 =?us-ascii?Q?dFE8j/X4phfRaSfopwwz54WX+C4mwYfT8z3j7BI6zOGfElxIUJNVyqwDV8VR?=
 =?us-ascii?Q?1eq+ntw87WAAhU3d0T5SitrUfOU0aE2uPSgU3KNPLNVJ39SMcmeKEKpr29R2?=
 =?us-ascii?Q?lEDRy4TprLFe7WPYhpdnA/kXS+gOjRf4aXytwDPM9p4TsvPHQiNlLHcpRvyE?=
 =?us-ascii?Q?rOjgvNumsAhfxgM0MwJH5hHoIqPstEh+pWJQES7gWukWpj8b4Bg0zq7ccf4D?=
 =?us-ascii?Q?1lhFueOs7BonJljXX3Jwa7OJNRbqpvFINP6U2AThl5DqSrG/pVC+Ctkao9xm?=
 =?us-ascii?Q?QpGiOGkdi2nzl0x1rdCyTZKlgewg4z45gHrEgy/hWXNiFy8gQwhYCYa7TdZV?=
 =?us-ascii?Q?3omGDhW8wLmSiCf30gW5xNy1Kw7/J0bWWivNEunFxTcaZuXR8LEAjFh/RI6t?=
 =?us-ascii?Q?TDJqDshkc+nZbCa8WVNTbsw4d2zj26wM3VOGS3r7gOlVA+LLN/QcKJHuF3PQ?=
 =?us-ascii?Q?tlQc2Ebk5Z57aNMvGEm7mPYZnsZGC4UBuEbZgGE1dKDWyPhWexeS1ZYXrB0g?=
 =?us-ascii?Q?nYLduc0f6/MQsX7kDKH3+s96mQjS3OSxLoafTfos/SgCbJFFQx7pfCg2UvfT?=
 =?us-ascii?Q?TLzpKUY+hOANfhGtv3lUer2POeLjOwSTts4+QADZ5zSGWEqY0XMadc1ZgnzR?=
 =?us-ascii?Q?Ocg2mpuJJqv+pzx6D0g5wTAg1MNKksZHuYHeD5odOesFqBbFqpaGLOYbzfSi?=
 =?us-ascii?Q?+JFvUQkvtigNFCNv07BDHL8ba7H61j4fjfGLgJwbCODhsvlEN3b360ZVm511?=
 =?us-ascii?Q?px2lFVYYkrtYA3Ktb0WiBfbp7/pGNgtivsaVje+z4tkE0MKUmw8l+9PpOxyK?=
 =?us-ascii?Q?x/3sjUSDLuSSzEWiHYCYAx5UMiGWnk+Veqnbpd5utj6XbK/4gIbVmdl9Ux8T?=
 =?us-ascii?Q?E66tIuem4MrS7/+eyOyE0PkQNJ9pT2fDd81YqMQ+w2zN7fl3tizflf4l8xGg?=
 =?us-ascii?Q?29J5Ar4t4XFbldiVZae2hcM6RAMvCMmDECt4b472UsMjUBY02Br0LGiXO+9s?=
 =?us-ascii?Q?PkLxwXfhhkEf6CJy1W1TbmYXESIh+THc6DHDKyxPJ9JRmfWxQQ2/R3f6QPx+?=
 =?us-ascii?Q?SV8JRPMzfCK4cvam3b/XhCZ7QMmKs7aEIzig6aI0k0ji3arr1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:49.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4721e2-c08a-4170-b6ed-08dceecc45d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for given a opaque cxl region struct returns the params
to be used for mapping such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 16 ++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 include/linux/cxl/cxl.h   |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7c84d8f89af6..60c3aa6ee404 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2674,6 +2674,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end)
+{
+	if (!region)
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	*start = region->params.res->start;
+	*end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2ea180f05acd..79fc3f6f29b2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -904,6 +904,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index c544339c2baf..d76f4ae60fbf 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -76,4 +76,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     struct cxl_endpoint_decoder *cxled);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end);
 #endif
-- 
2.17.1


