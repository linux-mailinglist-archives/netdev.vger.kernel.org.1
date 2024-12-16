Return-Path: <netdev+bounces-152302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24EE9F3594
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732DC1698EB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D7207DFE;
	Mon, 16 Dec 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MTloHyUx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB522080F3;
	Mon, 16 Dec 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365496; cv=fail; b=kmkHGbMp63Cxnrg2986pnUPKcAzNAZq6OurUis+zfdexzk8G+yD5c2EZHzYPoJS5asovPOtalIsuhVMmMutRM97fy8De38yFZZR0FdcJ1krR/8dSfDiRDIvonZvzww2by/TDm/2GllNSiJk4hBpQgWIBlA+AmKoIckI0kHdjxmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365496; c=relaxed/simple;
	bh=qIX5/weRJDe48Y+dE2YbH3zeexbNpTeAxZrvPqkntRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O64d9uJ3Gw/7t0qMsZEqIMyTTpYP+GgtGfyJodNhKedI0crPH1CjUh6frc4Cqyok5uAPrXAJ5PmQfOwl1VPjLkavbGvwWLwyyqFkdU4WFLDhquJUq1LtEEk6r5tznm/lMw3x1Q0I+CDQ1SzqhbgUbP09YQQBU7RRbOTtQ+Pvcv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MTloHyUx; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeFGI6Qut1mtu5JPn6zZudyEfIE0AY3JFMJDyTrdB6/5YzCoj9V8ugk8NOtfdNdNq9jn5wRqWXNVHJWt6QygR7h/TPGgVq5PBMUMmprA98uzzqNhjhl0V9GMuXAcpzjrkCid/Kuw5T/GjxuIvec4pV+clrCucOn6pIuGmyYS/Aiz398g9kQUjylnbGwPfdRfly0+ekeAlBM4mrfWEfyhGhIbCuwFLi6dw/P1D+xwQEPy+al7h/4FqMZcLwERobHXHrkIE45jkBRHzfr5nOXokbUXHOJ0fo5MqtEbUBA2+BLuXH4cfK+o3MqVWnoTSwZ6cWp05V1Z+utKMvAWPKJ7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw075ScXKqmsaVNwbeON4AVUcyUqvKtxtW1zwXrvUc0=;
 b=tQIcNA5njrp6B+3mRlykPCzM+piRO/NA6NT4sLomKHBE4uGuPSpUOuLngL6/sqNNbgUjUK7Ve2Eq1cH6vUSLeUMOhtNay31L3IKexE/vpS4GErXnPxDCTVA5PIOsaIAwd+1dnkowylLsqsYbvPH0b2WZ0oP1bdK1fhvAiwLnmYB7jjULlAXmJdsutABVyrlkc0FnAnkAbs0cTZ2zhk1xaJddiQ2p+2+hR1muM6jrv4aNzoy3rXwBnNL0rvUXE3f1cvZS85+3RRwg4uPaxAo2qhpeDbRe7pbBoT+ssEsd0WzkDejZFi74aEnkZkdLSHmPedYAmaGWWTKHJgXZYWdwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw075ScXKqmsaVNwbeON4AVUcyUqvKtxtW1zwXrvUc0=;
 b=MTloHyUxn7IRVNtJuSmBpa5agO9N7L5+hXPkObH/2m+YxvQty6mlOkjBIz4YdRi7KyADmo1naJGc0xWUQpXNswjhKIxFK6HdZXvHgiDYDW6XRtzoh9Ybj8yenDjwn15E+WH3ClcMMMg/eZWUApO4Dris6V9tFTq5FbsvxWXcYjM=
Received: from CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::10)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:29 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::9e) by CH5P222CA0021.outlook.office365.com
 (2603:10b6:610:1ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 16:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:28 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:27 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 25/27] cxl: add function for obtaining region range
Date: Mon, 16 Dec 2024 16:10:40 +0000
Message-ID: <20241216161042.42108-26-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c70aeb-9011-4445-e19d-08dd1dec4c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KNq+knURq0B0TP98borGKTIb2PwWzkQx4IwCxUYLCs/wSAqtS60Wtre6azdu?=
 =?us-ascii?Q?e52VOl70Ym+TLcvrVGHCW68/VEpvtssCjeJXM5uvVx+Dmwz8NvHAf9BKLZAJ?=
 =?us-ascii?Q?uWLvwmy+1AiuFcFxjNsU0NsAl55afc11xW0UO5cMBDYmso4LZVRojX+aoQge?=
 =?us-ascii?Q?Zuj63t+omI3xsjCa5QpSXaZ5IDA3QiJ1eJNPuTYDmr1yBM3+Z+oC1BL5jSOq?=
 =?us-ascii?Q?alFGqyqyapzKNOxrS52NOGtKRyCoKbrVi2gpLxs3qNRkxkFWw6a+T/tzVhd1?=
 =?us-ascii?Q?CS7etlizsoRYrNRqC1LQwMa/KzHYs4gldtFSNRBvtlJYxbMTC+Tp9/wyJUuo?=
 =?us-ascii?Q?R9lPPf4BwjrhTnABdNydY9ElVReo0K1AeGOaqiFSO6rVGsDOXlj6h/5CkmLQ?=
 =?us-ascii?Q?d25dgwYSiyUcnpz4yNuJyxE3VQU/5CACWP8JxUkIpI0+Wf9HlrJUntizHW6u?=
 =?us-ascii?Q?+AL49Pe5XtkOvvVHs2JFVi/OtxTwf5anplJtuKzf0fAVLZ7XcEtR5MS2sWJE?=
 =?us-ascii?Q?5V8DEPXFQ4ie4PtSw2+4CEeZmjzp34GByBfNRW+F8lTWYp5cZ8Bi2dmzH4pz?=
 =?us-ascii?Q?FPYh5FyEgCEhpKpI4Gz57YRI9k3i1AUwf5fpov/cYkvfLr+LdJHNdXp24ev7?=
 =?us-ascii?Q?QBMPRHPawQTGzgoiVBfZJ6YYxdaC9wwFdSRMF1HxpvuI+4eLc4lmwirVxmiQ?=
 =?us-ascii?Q?iYkKJnRGsB450hiD2hUOdGDl0nnOO19uZj9fKw/TJTF7QKEPhO4jzMaURQ0q?=
 =?us-ascii?Q?wDq/b7B2LsY3JlDGrKHeGg7xQtAvPu89lK0g51pp148YrnpMH4VRHmlLjodz?=
 =?us-ascii?Q?CR/rp0Pnlr99teeV4fSjt4EQnhJiQzxsqRLu/6Lb+Yjij6C+Am15+RFwU4cU?=
 =?us-ascii?Q?cgWhfO4F9RdTVgIsBauEqV0rhjHpb743lxPZYiS5BVNyZ6gYQJRqTe7QvwKb?=
 =?us-ascii?Q?otjt15eoGy3nJgOTRK8NMDc2hbP40JD+9ohwjzBh6K7zvlo/owg75lVh9SJg?=
 =?us-ascii?Q?WZaadM5GvKRSKMRJxyTtxkVZxvA3DLJLHwBXyhxqsAqLNpTLmmxbBseQXv+x?=
 =?us-ascii?Q?bLnEAH1N7HS+q0ec8MxWo5kCOSpkuxoLKRDsjGo2jUjq20lNUlRXJmTxUlq3?=
 =?us-ascii?Q?ooVU5UCKs9mDGuQHOP0T9rkoQvQP/90iGEQZkh4mrwdn3O0aOsGQ0+r3Qsqq?=
 =?us-ascii?Q?FhfARcJ8Iz0iO7PP44oBfIp6yMzaaAfkfyIbw4nGMCpk9rek2YIPNFCc7bpz?=
 =?us-ascii?Q?klK31tdTR9Jbvstj0wSLK3AYHa2d6opvUXBBA0VH5CMOEV1nuw8NBcxPZ73z?=
 =?us-ascii?Q?eGJD02D4YBw/MdKeA6Y8GFKv33EUSfCu4oBayRv+/F6r9qSmTQnDknVmUxK9?=
 =?us-ascii?Q?yMsxwSmKHzTok39F5VnVvpstxNTZyuNoML0K0T6JrqnG2DBOLPnRswvBYkER?=
 =?us-ascii?Q?MBBFlGsWmsWgcgpO9M1BEa0PVv7b4hYxzBu3XYDroNK7sMHo8fCP+joHdMYH?=
 =?us-ascii?Q?bt/8Z/hySdfctqQ9zx8HYra7LOkXN3y81ARN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:28.9460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c70aeb-9011-4445-e19d-08dd1dec4c8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 include/cxl/cxl.h         |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index aeaa6868e556..7a2d568b3fe2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2676,6 +2676,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cc9e3d859fa6..32d2bd0520d4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 14be26358f9c..0ed9e32f25dd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif
-- 
2.17.1


