Return-Path: <netdev+bounces-154589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B49FEB27
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FB5162648
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628F1B4227;
	Mon, 30 Dec 2024 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wayOOJmB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3A1B4147;
	Mon, 30 Dec 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595133; cv=fail; b=GCfgVZNBLjiuSF+oTYlVljGnwwZ+MuUZ/G69O+nK6CoeGiikKxeY5CzmCJfGXhfZ98saFVz81BF89+W/8MQaHErifUa28KuOKhvG57di/8PF5csGqEthGOooZgf/taoIBGrQO4i59QT4uow2+rhtjXXOSG9W9HxsqvTfEXVHRbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595133; c=relaxed/simple;
	bh=EoKRdlhJ/JTgL3EGm1DRJ2A9jWVEdkHt9wUzVzoShaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhQvEZGHusNCQKZL+2I24ztCxJUBaOv2oUgOqmqzuwPrXwcBYvkguhW0YtRkgeoQgWMAGYSN7DIVvruKRJngsM3+H4AAWOnfjnMZoPpELpnaI2bwWZqo+Pu9GOWSKw8SeVHyr5O8arW3a+Lsg1DxYVsnwHzKMcDu7EN1CBvrLjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wayOOJmB; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC5pHV6ehdqd3vQGKCxCKIs/lMkj2Y1wowdvBWXW6cKUXjqJ+SfC9+FQqhp0w1gPUqZQhmqxdceyc8Oqgsrm9FsWJC46XUVTcY3wMkfpe77wChsbYv9w7S9iK22A2CKR5MeaFg8QNb2gtxGcFTRiDZyIv++cv6j6ofnarqaYn4UBLeKGL6M4hSSOaN43T92lUWTg/NZ31ObnoD6NSz5ukR4Y3zZPoOGjb/sV3QChZAA2wXwvC7hTBWWOwvobuvS/O2qt9d0Q0i1iWF+ZK5BVkgGi8CsgU0VHOXQ+gkWD4HNzOaIF1aPM02374S4IJUUbI6rBtDhWHrLS9rHab7fwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgoE9XYgU7o5rreuYMpskkekMEIN4byE8U1pbbLiIRE=;
 b=Eek1u/JStyMTF6fvy/POwB9qdR7/g1yv7NZu1H+IcJwvyBO22z6PNOK/4KgPc6zYBByFfBFsjo4xoernVilIhtS2KlJE8QNsGcXN1+Yt9oiEjN6Ay3of9+upzC1j030GlnDmkwgwyo5feQB9wZ05rxMephuXEkvbjDW1JLGUzif0DioIKqxs2HCfIbz/5kXQoKfKlRfiwhXmKRcioHNNzNqlVXqh6yoG0lzGdklAQ7z91KV3bZi9wTIvodWS5SnFIrRq+ybBIJbJ+bkynkHAjJdrAxK8dSjm6J8XcULzXn6xvHhDVbLf5M69ir0L19i+RQVHMj5YVV2U0Th2Z3HQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgoE9XYgU7o5rreuYMpskkekMEIN4byE8U1pbbLiIRE=;
 b=wayOOJmBd9XOz8IWmYFza4OnSZcm5JlBNXiJJubomQSpqBlWumIc5ZVPXp49S3eDGennUE//yhwhll5BRkH+BOEj1G40JTRSaD9L+2ac7pFNyo2SnT13vdHojZwdl1eRdk9NU2rtTBQXEsLXOXNc5NxckzGHgy7Oo6xdx/Tgq6o=
Received: from MN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:52f::25)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Mon, 30 Dec
 2024 21:45:22 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::19) by MN0PR03CA0012.outlook.office365.com
 (2603:10b6:208:52f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 21:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:20 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:19 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 19/27] cxl: make region type based on endpoint type
Date: Mon, 30 Dec 2024 21:44:37 +0000
Message-ID: <20241230214445.27602-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: f31ebf8a-e93e-4601-f69d-08dd291b42ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRx6t/T0yhFsg22/DMFiyDEeEK0DGhlPi+ajzJ8A/ol68pHeAgujz3msLtU0?=
 =?us-ascii?Q?8gNGIity8yoNjN2gfFYoQadGHFN0LdakGvkT9fY+/B3zhoynJo6HcRqYxQEz?=
 =?us-ascii?Q?e6jGifP1nWZALhRKpVXNN+2s+tu/p3lfZENqZpQRHBXux2rNt4phxpN3HHWn?=
 =?us-ascii?Q?46IJxlkrmVzbYqpdeR+DiuvYfRL88FAdsazH1jLfqgl+rELnDA8zJHV1yqcU?=
 =?us-ascii?Q?vqftN2diahQIO8V57/VFHvOWxPt9ebigQZ9/2W37MeBiYuJ621gFOu/3Dxl3?=
 =?us-ascii?Q?opz7oXnIiamktj4mXB1Fu6GY7Wb3GoOT6FMoUJ6Y4sJXzlE/bpX5DI2JUTTi?=
 =?us-ascii?Q?uycJGwBHgIpgH3jPWzvsgWkQOrSlTWNKepZ7nNuTwy7VXFmLWrd2R+PLSV8r?=
 =?us-ascii?Q?TDkzr7GcaZc6QjkNf2QWfwG7ccV0ZHfzAVUKiHRKhNgG68WYdJ22X7ymBUK4?=
 =?us-ascii?Q?h2C4+P0itvZJg6OAs4lDKhKTTI9phqF+sUiUfIegZTU/HLpn+dwa0qXp5she?=
 =?us-ascii?Q?Fm1fV8yWlGMixk0xH29CsLKi43yC0LpwfMFi7zOa7V9ub8gwTLufxqriqotM?=
 =?us-ascii?Q?wchtg08BpYQL1CtZdTxWNd2bNx/V6vm6wv9G3Ll7VgREuafyFI6K1oXRExVS?=
 =?us-ascii?Q?hqkRs9+IIHWrsxwYEXeSl1UEHJr6khlviTzKlZ0ZWyxjONVyGljaux2V1pf/?=
 =?us-ascii?Q?N4WZVnJOr4CvxtfKjpmqafzurYUCTo1+qrOjK06dOUzds6eJ5xPnwnb71xcl?=
 =?us-ascii?Q?OZxIs8umbnBbwO/EXfmOyKzAFU+FtzRqxJXTd5gJOWIJHm4gpjKCNVrv2NEs?=
 =?us-ascii?Q?Bjxk81K8K8hMPE4B6Dn3TzS//tQRhLhDXsyhKL5y3iUKZmRaiNutPljhvVTR?=
 =?us-ascii?Q?YhqRlGKZ6PNN9//MfzcAODiDn1A3Y06i46N5zisS917SC+Lp+MF1k1NJeIhz?=
 =?us-ascii?Q?zjzFX4esyVpyFzlPHYnNGblOxqYXwZc7m5CMbHgfM5Vm1K7UscFNfk4QDrzL?=
 =?us-ascii?Q?KgMVWazautd7psyjmMD4kHGbwFs3K99C3LBZ+85jI4xqT81ZJCVULfBtL7+7?=
 =?us-ascii?Q?hUEDj5DI4iKm19kBONpjhQ/kfAM3fBlvLEG7N8q/lg3hS4lFOzyuG3N0JjSq?=
 =?us-ascii?Q?gcAkVoqEMIHeYTDGU0meEyEDdXHtBFYAQ923C6W4EExDqkzLKjL+19gNGJOR?=
 =?us-ascii?Q?vSUq+3FVTou9QEKLdKSwR2Y2gQUE59Jh0lVCCXqY0LnY4quBjhd7xFB4VSji?=
 =?us-ascii?Q?HEos+u7XuoZwdzerbUFlszhAI7Eb5WCmRB57QxDCVAemXYeuZsv0BUXnlJ0o?=
 =?us-ascii?Q?F1Gg898T82PDXEnj0ndRevi0FtMVPWF7dIE+5KKANatA20u9ecG3wm+qXXSb?=
 =?us-ascii?Q?oRPfWAJyIybbFrz+y6e1l8lexlSmpSyjFNfWZI/NVzy647ZxuKw2FzbX585p?=
 =?us-ascii?Q?5d7WGi4XdesDyCmerr5hVgD86teQSqdAhhWvHovUtASJXNBGEmz379WN/loq?=
 =?us-ascii?Q?qvCiLdxfWZvKNhs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:21.6102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31ebf8a-e93e-4601-f69d-08dd291b42ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788

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
index 239fe49bf6a6..8cc959859ede 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2668,7 +2668,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2690,7 +2691,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2704,7 +2705,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3380,7 +3381,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


