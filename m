Return-Path: <netdev+bounces-136684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF539A29DB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D3E282856
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A701F8924;
	Thu, 17 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WxOQfHsm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3101F76DE;
	Thu, 17 Oct 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184035; cv=fail; b=BgzA0PYZPVVyUHSsWpBZV6VyGjCnq3gQpUR3Bw1JjJ34FCZwPD0jkLvo/+EBt+a9Xb2xB8zekk8zQkccotzqdSTEDo8dcCpdhDUr1fZ0b3i5jJY7LAY4xwWkpuI0CVTKwBTtQJSqWA2h3wTR523yMZJdMm+E3F1ty9RSKst9fP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184035; c=relaxed/simple;
	bh=ceKHClVUL2kSDQGkcz0cpmHNDQz6EGMd5SbZAtfpd6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzW7MtheVrpCfLUNVmLIJv/lzTb4a3HeVlLd6D8qucN93Hs9nvxRgsY6AO+SBtk+ja6xfeoZsj9v/hGaOVEX/YbQHzFIetXEZvBaJrAT2FD9mC4Q4KdnPudCuU3vSxxksEesWoiwPjVQKinGRoaXzGeH0IDD/wknI1C5G2/DFHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WxOQfHsm; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jydmqm/7cr1WxKlWJLXP/OOpNvmjyzQD4ZkR48G79yAazYYDiPUNxnK2ZITSZ744ALlrblRXlqNx1qfwTIUIb4GmhXaWQw/Cai2Y6KHBBfKCKhnZ2Y8pb3QPrrK0+3p13LcePHXmDqw5XZ20vCF47zhjTyLoXP7Er8zArzDiMggMQ2TpunF5eI9O4XXjuCWziShhotk/0eGTinb8hhEGlag5Wv9jaxBUwpKwIOV0wU2T2OXeRlWiWNwjsZ6ct6nUW51G5QdLVO2yMNJn90xTZiHyC9NNFKPeboRzcnFjRk7faJjSmzC8kvzOmqmljUTI/3UJLw92f4iWAxf0yAJtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pApIhIctvycqzMqjSxabIPJ/wnKmQhjPSeu/nm3b3II=;
 b=Qk8OOjO1zYtbS8J9qR49IH+xjdefZRGlW2aUc0hAsxB5DNLzwaYtrkCvmmgsD1b14zLNtzaow+7eYL2jWA1rTNYCls12SCTsbSrFnUzQllDIaBSIIcLqcaXGQWX2SZbdCZiIGgMwHbym2YYIRh3G41MJqstRjAZR2LqyMBWkn58VqrBeT68RWHh+WsdtxVNnPMlIycNPIcYxQewgTSnK5rBtBaq10saiFL0mbzZULrnWVMP7u2tprU6SG0yoJuC9vymwd53+sErA4Sgb0vf6Kj0JLxDUflXj7zm9oQtu2KYMvAUM1TH20yrkLX7IaExCP362gnpCDeQ4lJ2kI9IqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pApIhIctvycqzMqjSxabIPJ/wnKmQhjPSeu/nm3b3II=;
 b=WxOQfHsmLeV36ulnLOM12Cec9SaZb0zlJa2Jr0DzbVry7oew+b+o/l8fv15x4KCciaxb1kLz4/nGyxqXVlK6NDelMFdNg7XKs6Tsp7sgtoompGaXItV/JSTbooqWnwtsch5ZLGmOy0+NElGZ0v/uuSq1BzroSs0VUHZXhbRuHO4=
Received: from BN9PR03CA0936.namprd03.prod.outlook.com (2603:10b6:408:108::11)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 16:53:47 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::f0) by BN9PR03CA0936.outlook.office365.com
 (2603:10b6:408:108::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:46 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:45 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 24/26] cxl: preclude device memory to be used for dax
Date: Thu, 17 Oct 2024 17:52:23 +0100
Message-ID: <20241017165225.21206-25-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cb775e-eac5-4075-b78a-08dceecc44e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QoBc7czo97IU8APJGXHF99ORfdaSNIRAiCQDH8RzTOF4cJ40zwg6hXuOFiq?=
 =?us-ascii?Q?NFOecCUNoXXpIpyNRpi3YArC+k8RlyyTsNZl+sV0M/+PFWJ6DU5w6Mt2ON+H?=
 =?us-ascii?Q?IlY/fDchU7xiPnW9sDhJ79cC82fJ9Pp3Pdf4S6MI9XVeHwhjZf8x6oBiiR8H?=
 =?us-ascii?Q?18PxQFL5GvzPB5gO0FywkA9cBEYcbUlnYrZD8DT9pZI6+YVirr9f5+38Qvq8?=
 =?us-ascii?Q?k3iqKWD9vxdaB2EmmV40ruX8UvuoOU04tesqhxssP6WNeK9jc7OxuMMa9UMR?=
 =?us-ascii?Q?7RS/07MpqSWnG2Bpmn5aYHsWGDLFRGSChpdbrDdN9Bwwg61pUiDD3o5JjqGR?=
 =?us-ascii?Q?pE/b7M8HtgYlMtd0QYg38SQfOUGxXVs2NNDgMzmtmZB70ieztVoNuK9cMTtN?=
 =?us-ascii?Q?s8qtHd8UjP+LRtEHgnooe5Oi19N2csgZqwvV60wrBLfZtd5RkZzZYmWS90KU?=
 =?us-ascii?Q?rbG5czL2U8AfSR+wSeSQ0aNKCRuoZbxZ9ZYUqL386PsmMb8/mFBDebsTz04l?=
 =?us-ascii?Q?jjNiuc/iv7GNwhcAfE8NijJ6rUNKJegUatLNi2WdEgP6JNs0BYV3SJskQ/KY?=
 =?us-ascii?Q?tVfKj9+KEeFJfKEo4n740yIp8P8kWnPv5a+z4DEbdj6TQvzYzqJzgSsUO/Ic?=
 =?us-ascii?Q?qrXkVMgXoXTyPw4yhr/SSXgQReKnHYdTotiZ8US/ECTyVW13zdOgaIKSNB+a?=
 =?us-ascii?Q?S0c1A/xDyI07vNbVCCGhismjbFi/qUr4babKnX1J9G+MITyqunLp/ntvLQ+v?=
 =?us-ascii?Q?pZVNxxyfODMu363t5N+C4aAd28pOqL23+5X5kRIGCwgN32T0Op5g8ltOTCI/?=
 =?us-ascii?Q?K/2tlybvBYnIwkWQ7+wdfxjNTvJDltKwsgQXl7slg6T+Kjb8SQA3mIw68hGt?=
 =?us-ascii?Q?FtsJRCASQwvKQqzGlOm0w6LSwwqTrxHM27yfbSPdvcTrIYqS8uj20Y+ym4yj?=
 =?us-ascii?Q?KNBlaASDi/F5YNY5ytOouw2GATkq/hdJIyNJv/hOEJtAr1QQtRdQ0m5sMo8G?=
 =?us-ascii?Q?+D4emG6T4ZbFmihiVEI4Bg29HYCxZU4+AizmrP85ghQp4/6Wl/htQX/SsCgL?=
 =?us-ascii?Q?Z030ZErPM6CRUhPZibAPVcA+m8+pTE71w99JjrS94g0sI3XA6tUG6zGl2v0q?=
 =?us-ascii?Q?l741SlEhHMm5wfTKTEze0FJw7Oxlsvyc+UCgQHxnFVE5TsNMTFMavUAd4vus?=
 =?us-ascii?Q?Y0tWAFA7JoQpwM0ugffe4RQGJaX22jwfhO58N9vg7NNrZUxmruYYrXH20bR+?=
 =?us-ascii?Q?76I7udp6p6alDiMzlGmzmfIk+3arHLsw3FTtSwM1L4i6jCFiIVixH3RU1lcH?=
 =?us-ascii?Q?rYyIB/NMuCs263ilWITmzXzUdXaMS9+RZ7OK5y8X6w0bP8gTAPRqt4ALOmaY?=
 =?us-ascii?Q?AYFiFdk+2tmW9X0hA//++eHVcdZ0t8zfLXiRnutb8VoxfpEgsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:47.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cb775e-eac5-4075-b78a-08dceecc44e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 04c270a29e96..7c84d8f89af6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3703,6 +3703,9 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_DECODER_RAM:
+		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
+			return 0;
+
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
-- 
2.17.1


