Return-Path: <netdev+bounces-126216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD59700D0
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835981F22C40
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836843ADE;
	Sat,  7 Sep 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pedaAAbO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACF14AD2B;
	Sat,  7 Sep 2024 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697180; cv=fail; b=j6S2Q29Xa0icjPcsWMeVO+7y8LMJEluEbc8DxVU2ktygbzVkRft5A8dkTHjMdZ7Nk3R/JSI9p5QBbOHOdmGRO5r9nYt0QnLix0rosqLGwMm7SAGxDrmZp81ShSrcyfbQcFap+NiXEKsDpMnhSF1Hq3VqQRvpKgObHzobhvm6qyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697180; c=relaxed/simple;
	bh=wVszij8loj0aktksCsbVzt9ZbDi/g54X/YMIlTfkT64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW+v5vRe5ptiIrEGiH77nh1l8EztD5EC5ENf4SJo07czFX0XU8Tpuea9omzJGYJMc1b27wl4XY27rIuo/ATKxydhtDO7tyP2LBnQ5PUXe9xCf7c5fowWv9DAzrQCU1kVI9kXG0h/LdZ+ZP0C00HB4efQm5QdjLT7WTt2Wv0TyV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pedaAAbO; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBm+FzmcRor1uKMBTx6btOAsEgyhpMTg0Pd2GdPXAo3UFY4KBza6kP8Cxd8FlKLKUhC/Jq7U2RTRbJsYRv9In7S9+SD0sBgDNi4i99a58Rb4WK7/W6tq8sobxmsEJASuSVtbLKqYb4zT1oMmVN1PdXF7Df6jyD6FtWlcQTJg2Xk+KyGxrji4OyaZJOdfQUEZ+Fnuh50Yy2tUNJJSpQqKY7RpL5maFLzqUl2TouzzE3VEc5UeHqY0AMD8goiCUu1aNJG03+5naE6qkoxEdy/KwdiIrtZL4i4vRsktW0jX5rUB05JKLDi5q3tJo0sKgBPsqxTuuX6F190sNGWr/qNeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8Ri2IevzBpOepKFq8WTEVypmC+OTzRlYeV0cboBam8=;
 b=gEhRoiDFyU/O0WusGACyY9o9GscJvF1GLyNicdVL2wNuhX2MukuVFRvOhK3+E5RyO+c3wV/xo+6NJsuNjo+OQoOXk9mj1uS9GZxpS+Oo75vn4gt5vThigCQWi2rDY8vPtQdNT7q7IODbnyzqcct3MDNefwAbHoJyLPqCz7DXi8hZRWX3zYqT9PI8yKq9SHBSQRktiB8l0kKTMTPt668ezh66UJF/1/9k43fUxzDMJbvf97+bB0v4Shg5DWo2+8QR3oBIyXog+mpqm8ETqAs2R3vDuyrgK88AlpwIRNek/IAz+Eu60R0Mpzrs8HssRaFmw7KujCaZgqIMvfirNXnneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8Ri2IevzBpOepKFq8WTEVypmC+OTzRlYeV0cboBam8=;
 b=pedaAAbOUluFyC/XQben21I36EQ0pg0ELzXZPt5ZRPXkUgH2sFnYR+v3h32ipws/vJxKBBfGKN0XsEdz5Jze6d86rA2r0nnatF2sya+n/FS9ZbVHcRn2MeZpWAytnJoQ/HVSb8kqel4FnWfVzt9nm5l3+qx25FSJyt+sNX94Lcc=
Received: from DS7PR03CA0140.namprd03.prod.outlook.com (2603:10b6:5:3b4::25)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 7 Sep
 2024 08:19:34 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::85) by DS7PR03CA0140.outlook.office365.com
 (2603:10b6:5:3b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:33 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:32 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 08/20] cxl: add function for setting media ready by a driver
Date: Sat, 7 Sep 2024 09:18:24 +0100
Message-ID: <20240907081836.5801-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3fbe87-0b8c-4737-9be4-08dccf15ce6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04Tvo9PLxwxgzKgHBfdWAlWPlTzTaiMAzN23DSFHCsMl0nGLOQoJmOw8z3mT?=
 =?us-ascii?Q?MuU9RkmGfra85sylaZGw1mRUUmQkVT73wjnzcXLJBFkdYq5qC9Cy81DcMKTz?=
 =?us-ascii?Q?YqpXsskPEggMQ1aeuVFFVBK0ruDTgjgOCAwdRw3O4RRriwNeLCKoRV4o8F5h?=
 =?us-ascii?Q?HdApIcZpbWNPgRW8Pbs7hczaZAhdaYmpaA8pX0H033jxmjm36DOS9VPdWaIB?=
 =?us-ascii?Q?HJL5VDbpTprPbMuPldKGVXOCcH7uZsWC6SM/rnnyUOR4k7yLssYdjF3HXgwG?=
 =?us-ascii?Q?A8nf6YBwDwo3u4hM2Xr5xJ6qkTQ8xcNPJiqeBkJn0u/fnb70/FEjJp/r5mHs?=
 =?us-ascii?Q?Um8+F9J43IY/sOWIKNGabjBD+ep8VwNB9w/NnOjqSrIFbIb0MNSgxD9Hh8x3?=
 =?us-ascii?Q?RCE/3c/VrmKL0uXrk2GVlmt0eWwLNeFNRuikxAtTRCmf9gD6gHSYCAACrqb/?=
 =?us-ascii?Q?I02HpG1V53S6vM201dLHEtBqa8p01BWAyNqpnZIsaMlFYCzVbq0TaedMJZU3?=
 =?us-ascii?Q?S3YudYuwSdlV8ZLc3WT+5DFE1jlyBuxLQwtsq7Z7el4AE74hjAyreSB+F1V8?=
 =?us-ascii?Q?4s4jXnNSdazs1DWtyEeXRqbPzWVU5j9etwQkKr4y5wXZuj2UvPTn4qle2kIL?=
 =?us-ascii?Q?dmdlZ+H5WOohIkqtnHXQq8fbN7fsCDlnlOVLhdMlD2Eqio8SQjrkKVV2WSmz?=
 =?us-ascii?Q?1VRVpCYhSmjK2Ly+w8uA9L4K4VIMZ9/+Z7FhQZwEHLesLQdOU+Sw78A2SAl0?=
 =?us-ascii?Q?Sj/c6mfIRgY98auTNtBYUzKmj+miYKzqCKYYg71+YD7QR5i7sk66FoPYxuhx?=
 =?us-ascii?Q?FreyyCzaX+D8Y6I39OO9o6RJSTVULLVbWJPTPyX5vVpN4jdxXQiqEeEUD4O+?=
 =?us-ascii?Q?vZIJv1mJ+p6qVMlUQlXjhgaWitQ0PNlx4R1/wSVSkcVQHCCG+hNA6Mqi9Qkb?=
 =?us-ascii?Q?I92ZDTQHD/wIgQyNVGxfYGpmz4peR5dK5b2eo67zJP3oprccmY1WPIqiSTFx?=
 =?us-ascii?Q?s9S0g+kKwqg/DXGrs9LjVV3TH8u1AIYLqzKOe6OEYiTG5w7vI+1HddcZBCEt?=
 =?us-ascii?Q?Bycj1hvT7+W22o1p8LeVlJTNyKIuQuIWjuuycHfdKrRqiVKhvphpYfPIN2xN?=
 =?us-ascii?Q?Kwvs5JxtMY9rAoJDSRuXLy04AOJ7a9Ml1NHDCp3segBUyBYp2UsV/0IhITQO?=
 =?us-ascii?Q?eYU3xVkM/3u1IWwMu3jFCC+ZfSwmOTPoo2HZqkWENJ40DHuS/Ld3njfeMHeo?=
 =?us-ascii?Q?kQteXURtiZJ5nNe+72fEaT5igcqjN+b4/7pk4WoFxberoioM9wmBUD9C4MXs?=
 =?us-ascii?Q?18QZonT5iNEwxx8DJloP4kS2Bser9Kg0+rEqnzIQhkam9NfDfvlMEV555rJg?=
 =?us-ascii?Q?HImJWEE5lfE/PSJZEM3/wCEfKcCk7NxbzkeUhW+9EnFj+6qocA20wsDDhpRV?=
 =?us-ascii?Q?ItXSRMaFf6BvQFoQY8HXlVL4J9fUAm0q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:34.3292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3fbe87-0b8c-4737-9be4-08dccf15ce6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver can require to set the memory availability explicitly.

Add a function to the exported CXL API for accelerator drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c          | 6 ++++++
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 include/linux/cxl/cxl.h            | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a7d8daf4a59b..836faf09b328 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -784,6 +784,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
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
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 80259c8317fd..14fab41fe10a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -78,6 +78,11 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err;
 	}
 
+	/* We do not have the register about media status. Hardware design
+	 * implies it is ready.
+	 */
+	cxl_set_media_ready(cxl->cxlds);
+
 	return 0;
 err:
 	kfree(cxl->cxlds);
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 22912b2d9bb2..08723b2d75bc 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -54,4 +54,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


