Return-Path: <netdev+bounces-198299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6387ADBD19
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D7C3B6F7C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42D221FBC;
	Mon, 16 Jun 2025 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wk6OgJK7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E262248BA;
	Mon, 16 Jun 2025 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113904; cv=fail; b=hkEPANlzQqXYv8ktIW9q/KydnFjaE3AzjcghulqdE86yKP5JZS2McznyJlJUeCj/DF44aVDF2EAbb9MocKrqRWCd16rElXPEncUohsYDcereRmBW1H5BDLCvaSGd694lenhLwi7LSFVU/0WrqZTtL5FWYK+fJe70MzKFbHoihmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113904; c=relaxed/simple;
	bh=PFlRVb1dp1AWKuEWC+mwTj6mdqUKGZi60NK2sHpp6LM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KKwIxp4YtwxBbjA0VcUeiBbhCZOhmIXa4ZrygnbNieKWfQ/zG9VZVbuOMaPHOodeNE8PVC61ffZzY+rrDH/Y+1Z9+wbc5S8B3xSJC0F7EpH9YNZwyTLXkkc8vYxPMwi+EUMwPI+fsWGvhmh/JcmJaRXRiqd1ZyROFcG98kK4TgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wk6OgJK7; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p66x/ZiIc9Kcs1gOz+Yzv+fIY2CC5xF/facB+ZKistZ3hMhc3Iz+Hprvb5IshuJ1PzmELtBCY8+gShe2b1SVRSKYzARAVfysoJmJkhMLwT5TaVjLbSalgcGfB+RummyBULUCqdqdtbiQzlaC4m/nd9HqcVSmcW+zsjKP6Rivss/mx85rLLV9gw7rjtVZOuDbGFrPuT7cizoyBvQgf8xvFn0ssbqKbfbbqHH0RxhzQ0YuTzF9yfkQ9+5vXAT+Eots0zPqEU4qgXVwbx/OqzxjGfVvHq0/e3oFxeDS4/+x9ttjvuIp3VQ2dGzOLC0y2UPPPsXcJ2GgP791xXymi2fy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MklNlaOpnO+58a5YDxiYCqEgTuBB4F3pzrukERE9unY=;
 b=CzW00zD/S6+zClkUOXOvUgTrS/DvgTTL7++jQjCo9xbEJQloWN5qHZRN6LF9h/PIMefzJdXELa532TfnL/CF22KoVsYfeyEtPvdFK3F+xW39Fcs9aIfwNgc44Hq4WbF0xxHTtThNsC/pz4cCMwPYuhmyDSGjkwOcqhGLmUXqFbcvMQWNdIXFYeFLOo/fpkx0ll/THbOJuqoWEv/Imo5QeHPjqHFkTTNQxlrh1TjuEz25pPt+kJ661BnBdxu17LmzdAxLNJulG44QjlPs/ElmQksYNVl8nNge/kpaBD+f+BOxiHQR4Pk+8jJvp2ZDVX100JjiPil2PbFV5jdnMFvD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MklNlaOpnO+58a5YDxiYCqEgTuBB4F3pzrukERE9unY=;
 b=wk6OgJK7C0CEnhfJdZUUb8v+HbWB94oEbr6R2C2CGwYmwL3oSNkG4mg5KhYmCQyc56jw5xrh4RS4pippsgTzHfo5924SCs1wGvRyEmEKo5j8WT+zxFpUsW7bDkX7YqrEnmkMI8RQBGwQvW4sPLPNf33cgZcWvtC5v6zeonXZTQo=
Received: from BN8PR16CA0022.namprd16.prod.outlook.com (2603:10b6:408:4c::35)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:45:00 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:4c:cafe::25) by BN8PR16CA0022.outlook.office365.com
 (2603:10b6:408:4c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 16 Jun 2025 22:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:44:59 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 17:44:58 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH] MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file
Date: Mon, 16 Jun 2025 15:44:37 -0700
Message-ID: <20250616224437.56581-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0e71a2-790f-4059-e3a8-08ddad276ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s5ZZSPSOaoOev2m+Rh4bjRotGcJn6UXnMklP6r+aE3QZTEplBN2eG2Oin1Ed?=
 =?us-ascii?Q?D2Hf4yBXsHHUX5K+cLfgkwBBV5z9A79k+B+oM4/rltjrAMmPFz/dxt+4dJn3?=
 =?us-ascii?Q?8ykk1A4eoYUohR/TMeJXITDB2okzR1fmwBK/y75kHUTg60RfvOw0hlbLnzaU?=
 =?us-ascii?Q?3AY1cu8NrQuGCu59iFh5gh4vQLvMmD9I2/4Z8g1AMghbYoD5tfH3KEX8VlyL?=
 =?us-ascii?Q?JYa5nwoD4HbdKW+of1QNdLWXy2b9GkN67cxp92ZiqqjXHm437w6Hmrxt9hiN?=
 =?us-ascii?Q?Jg5K22AAtbbKtotune6zjVloY2b35c09IVOeaMhJzD+Odl+VkRLxKCQQ/72J?=
 =?us-ascii?Q?jYFv2UiNV6YN5OB7pYkIgG1bF2ycbjHWM7+LhxEG3phlGInpZkrvsMgw1FaB?=
 =?us-ascii?Q?TlKn6IMY9WnUQlXesSBxboOYLO3HphJwIesmCf8uqHrTLdUjj2u+MdzVfL8r?=
 =?us-ascii?Q?V/XzcSCT4Iz+SHjc56WSRJYKGTBmDMgHYg8rIqSK72Y8XMZ9rNSiFJibN8uu?=
 =?us-ascii?Q?RPLEbYzT5BmE2cRjZjgR99CXcS21IvSMwjE0k3wX77/QLgyQmvWJTIri1sTk?=
 =?us-ascii?Q?lY9N24LSFDPdc0U1LFlWgk0IP+lBFtYDc8gFkWqD2/AXsQcnT6G2KwF1k0w1?=
 =?us-ascii?Q?naM91hii3/I7SWExI/S8ZvJfquyo+LXqsK2tHEYGkxK1ESSivNVHBD2K2FJu?=
 =?us-ascii?Q?KQiZW0bF4XCPZivTH9el8F9J9GOvmM7X4WHsKT+s+GW4sMl7ldUUT3mK/S05?=
 =?us-ascii?Q?AgnYsuBPLJi+ic8czBK6hBM0nJ1K+7dcrw9a0uA0ZbMKfB8SZBWOrORJ/hFP?=
 =?us-ascii?Q?WxeUo+FQ+suhZ+61T3jEj9ohIQjh0/UN7+ywreJ0nk+NIg67uRh6bQNQSKtS?=
 =?us-ascii?Q?wbioT3tWtJZZLSiAUFGLc+arGJhByFHhOldDbyMWVpajCqevjTMm/ZJMXCIh?=
 =?us-ascii?Q?UuRMdz2UZkYnNP/8Zw0LRCZ1y+IlIKFNGEVs1LbxSUYGVRM7xj/o1r8tz2dD?=
 =?us-ascii?Q?hR/NJHMTjTAOwYk7BKrJE5SEbTnqAbOFw5G4UdbB9p2tZmqp4QNP9AEio0q9?=
 =?us-ascii?Q?+B4WLrz+gRuPfYRQpLqjN433JXgOU4YgdLy38R3XA2B95gkxzOTxfsT5ttF/?=
 =?us-ascii?Q?+gPOAI+aag7tWyuqt1gCNQhuwZkBdzOAD7xcv4YOaWRy8BrI2HFPR1E229NH?=
 =?us-ascii?Q?Y+NIa4DI+S5FPs/u1iXXEh3uVib+dGhj0KWJAF318WZTczQPJrbklUeu4Of4?=
 =?us-ascii?Q?WDe6tzf45Ec0e6ITqc2cGvQCFvB4XOrRz1EgztPi4afdhSyWmi9KnXA6Bh2y?=
 =?us-ascii?Q?QvvJgKniOJRVqwZJc3MYWVyfljvMU/fdGPmf3igif2tp/fgu/RyuGG6Sj88E?=
 =?us-ascii?Q?kFdkGzPm2wJVbbFzVWNg+EUw7i/Wtq4tqxAWdIFiKnAMu2pUAcf/TFd8eOP6?=
 =?us-ascii?Q?gw1/fFyUS3EfourH6GqLIxBh5ezJ6DdLcF7RnWHT8KH7LMkJFNH7UH6iXQs3?=
 =?us-ascii?Q?TwlyNetfq4OQGDhmQvtTndnqOrSSkPQoAgAz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:44:59.6814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0e71a2-790f-4059-e3a8-08ddad276ccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

Brett Creeley is taking ownership of AMD/Pensando drivers while I wander
off into the sunset with my retirement this month.  I'll still keep an
eye out on a few topics for awhile, and maybe do some free-lance work in
the future.

Meanwhile, thank you all for the fun and support and the many learning
opportunities :-).

Special thanks go to DaveM for merging my first patch long ago, the big
ionic patchset a few years ago, and my last patchset last week.

Cheers,
sln

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 99fbde007792..437381aeaa71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1157,7 +1157,6 @@ F:	arch/x86/include/asm/amd/node.h
 F:	arch/x86/kernel/amd_node.c
 
 AMD PDS CORE DRIVER
-M:	Shannon Nelson <shannon.nelson@amd.com>
 M:	Brett Creeley <brett.creeley@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -9941,7 +9940,6 @@ F:	drivers/fwctl/mlx5/
 
 FWCTL PDS DRIVER
 M:	Brett Creeley <brett.creeley@amd.com>
-R:	Shannon Nelson <shannon.nelson@amd.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/fwctl/pds/
@@ -19377,7 +19375,7 @@ F:	crypto/pcrypt.c
 F:	include/crypto/pcrypt.h
 
 PDS DSC VIRTIO DATA PATH ACCELERATOR
-R:	Shannon Nelson <shannon.nelson@amd.com>
+R:	Brett Creeley <brett.creeley@amd.com>
 F:	drivers/vdpa/pds/
 
 PECI HARDWARE MONITORING DRIVERS
@@ -19399,7 +19397,6 @@ F:	include/linux/peci-cpu.h
 F:	include/linux/peci.h
 
 PENSANDO ETHERNET DRIVERS
-M:	Shannon Nelson <shannon.nelson@amd.com>
 M:	Brett Creeley <brett.creeley@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.17.1


