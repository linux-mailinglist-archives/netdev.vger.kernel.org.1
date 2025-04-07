Return-Path: <netdev+bounces-179982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B076A7F079
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8F87A23E6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D822B8B8;
	Mon,  7 Apr 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5+N0btA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F222ACDC;
	Mon,  7 Apr 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066315; cv=fail; b=Go6gnpjxccUyz7FHWqBekPyFtLBIr3ldGYKtBUdT12ckUK0z9peCmlm8+B9JZNnws5Aaxc/6w3HpZ0TIqyUx5J7FDmLbToD6IgI+v3EFONh1lttCFtmFtvDBkQ9TlnL9Rja4/P9aBIF2TFpWt5V2RvpBOkReJKoXRSRv4NLnpS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066315; c=relaxed/simple;
	bh=KTUTN4rC+085EaXJJjaYdpFiIVXk23GrFrYtJkQJWaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVTFjjFKvTgSlAitE0e2R18fRq2QZp0AXeuhoLKc9cja3EpCv3WPb0ah4vJg67wi9pDlUC6hFSnmbeiPc7UigQyTdFB3YdQkfR65IMgJr7MC+yjiFKZGGPJ9VJlXPuzNfNvlLRUTifehEm0kT49mWycikfKbQjigg5sgVwxc6Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5+N0btA; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w68wFb273lrgt9G68G3RXKQO/6gNXEAdLD9QzKUdwpMEuFbbXL7Z9WmfzApPRbi/jTPoEFEcrr9vy0gzwLHLO8WVo37tWkleqcQyMygQztghOt/f6blyIJBeA1htzLTb096UE6jml9xn2BoKw5+ERIkHvg2tT5LiMeN/JgaQ7yaaiRbyIO7Z0AWH26SkWLkrPKe2Mc444uBeO/vSMUKuLPoS3pyo7Gfjs1HXYVWEbnV3Ad00rhHxj8gUd8eybduMYq0HnGpYaiKnfLkx4I4gZAAMp0VcSJtQOdjsDckqapLHdtisYY0m8y8AfY10ducsqYiHbwr3y9DoWnLHTkmfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3LbZWzWQyUkC85Yl2tj6sDaOCdP5KAPH5dPI3+/cmk=;
 b=uRgH3zNNryGKvqdh74arWZs7zHoJYzfYl5FT3/l5ivTEiKNPNW5RjyuKv7ygvvILJDpUZgosJMFtbCzTcQ6UWD2bgzFlEjZHJaraK72Sg070MUpc5iEl+9fMB/ibzf61mdwX/V74DQyx4eiG8u0jUgqiLe2XgYtLfN0iN8LO+hm9iveVZcYRNC/szsdZK38U0GQ4leWn26e9jZnmILMGjXrPu4+GU6SmJDXh2Sr6hGthoNo7MaMdpx/ikZSz13OPDoUyzH+2zUeERXEZ18NAICGnjYda0ciHXb/S+sabVCaW/sOrQmWJ8TYgOWPqO0L588LFqWGghfphCEV2ja+BDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3LbZWzWQyUkC85Yl2tj6sDaOCdP5KAPH5dPI3+/cmk=;
 b=d5+N0btAFfVBf497w03Ob+T61Ow4L/iaBPno4IKbOtpmDgAjuuddpmFMVio122ac2vT8H8ZCL4M3dxYwsETz3DzyQ1IRMXH9Tl5bFOIWLAWiKUjoLNR+T0NzuhvT2YDF1Doyy5q8nlFxa1Ga+nikHImpeEJ34GZUF6TihjQepsE=
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 22:51:49 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::2c) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.32 via Frontend Transport; Mon,
 7 Apr 2025 22:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 22:51:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 17:51:46 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 5/6] pds_core: smaller adminq poll starting interval
Date: Mon, 7 Apr 2025 15:51:12 -0700
Message-ID: <20250407225113.51850-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250407225113.51850-1-shannon.nelson@amd.com>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f647d00-d987-4309-4b72-08dd7626c804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIJL+sWlZ9kp+6soGRvt6O+cjIhN1hwE6mCmPKJnNG/QwAG+fhMTe7eayEOE?=
 =?us-ascii?Q?csO1eOXnklsmxu3VCCfJ+BR+0GTFi/VSz0wDs9TX71XccMy1/2R0YEytiFYz?=
 =?us-ascii?Q?moIGithhOVCJT62TJJSyPNQMwDKX42bF2WUodw/qfgX2htNWn6ccMAo0hrWu?=
 =?us-ascii?Q?Q6snIqPQ50hsfB6GVpqIctDCzY2+A0tThEa2pg3xpcE1HdpGtFs+ErcWhFfM?=
 =?us-ascii?Q?MIEkloNv2LPkDKZUzcKGhBCev7p5GQ6kmda/8a2oyeOZ7IZRv0OZkvgNprfZ?=
 =?us-ascii?Q?nU8v1ZSyR0nKRRwnceL02eh+cLVtq0dbnpwI1gDCuSg3t0Ni4vPkJxeVao5/?=
 =?us-ascii?Q?qVyCVw0bOqlHpERMQ8hNoVFyUuklCZKpdExXKnEeNLS7wKqaqWFXXM/NVSMP?=
 =?us-ascii?Q?zFu4SsaxJrQOBS9oZXUXUWdyNBh5xHsj0SvyPlQJHHME9iAKKkC/U4ZGEOgf?=
 =?us-ascii?Q?RRitKKnhMgV5K8O5c+0AVeaOOmQF7PeARFWHyzDH4Mdq1F0IScfoHK/yQEn7?=
 =?us-ascii?Q?WYn/JkB/Bg+ujWTSKEFC6wt36QS3ryYhQ5fk5vLdVC3bIBntutIy7ifSV6Rm?=
 =?us-ascii?Q?PvI+O6nkjvNZGLsCx3LW7LUHvNOZDXpeOCMW87QWVkHHKw4KYJ7tF1Wxht3h?=
 =?us-ascii?Q?G5GkmnOm2r7H9OS2No52HNK19iPohx0KufWnMcQbSwdTMfMM8Kj4eYRwh215?=
 =?us-ascii?Q?OOgC5ovsf56V6xIw4xZ4oaLXJdHLUwFvYH8vFjznQrDrUsWf6NNeBN+1Mi5c?=
 =?us-ascii?Q?t1gYnakO/1KSqV6jLCy78vmBxsblHguF2UMjLf4TecHaBd4LSZmUxxtzvN7V?=
 =?us-ascii?Q?WL06P2CE4/oj7vzetaogjki3Y9zqQvqT4yQNIMTTBsUSDYQCZ/Y6K97kHazO?=
 =?us-ascii?Q?CU0lpxfQVLvIpxeaOMcp83kcJZjSzwUsUYms2/CMnj9olxUmvIhvbWlacfqT?=
 =?us-ascii?Q?7XoJhkgLMLURboVRHpncAOT4em64hzj0W9oP3UfDDDjx4SIt/6L3InwB6+wQ?=
 =?us-ascii?Q?d/Dn+YKcN5pyQtijnLxKwRDXy+hG9cXVkAWJC0vdisGPrWrd9p46m7m/oWLe?=
 =?us-ascii?Q?6HuLBeMZr1tWEv8hcU/0MbMsKOxe5eLHFjRdUp5T69O2NARAdrXUN5mYyvY3?=
 =?us-ascii?Q?ijUv9DQCLQ99h6TjDfoJrLHocxZ7YHUSWqs8WaS2kdyLIAd0p8s/eesrfEYU?=
 =?us-ascii?Q?gdqG6HakcN4hoW1UjCrtX/tobGq3kwCBNw8XxF2c+IkA+aoTWdKwbHblqGTd?=
 =?us-ascii?Q?90bkc9DHwj57ek5N6fPmfQ4S6HDqgtk445efL5GTSaC2gZa+OsPY1KQhmAWN?=
 =?us-ascii?Q?PUNEEXmdd6b9MFxGW1ZQS5UCtsTsbuQmArcB5OgIewB9BDMsm1+y4o0vx2uE?=
 =?us-ascii?Q?pnxphS8Bv4gGtrubRrbqku1F4KNxZpKbjOZJniy1IZTmOkrVh3Q8YmPrOvV0?=
 =?us-ascii?Q?N6G40Ow/Lc1Xk7YqT9kg3iOnngX4Ek9kM/TBXBLbBsp4TVsvtnnk6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:51:49.2569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f647d00-d987-4309-4b72-08dd7626c804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Shorten the adminq poll starting interval in order to speed
up the transaction response time.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 4 ++--
 include/linux/pds/pds_adminq.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d533..2e840112efea 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -235,7 +235,7 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		.wait_completion =
 			COMPLETION_INITIALIZER_ONSTACK(wc.wait_completion),
 	};
-	unsigned long poll_interval = 1;
+	unsigned long poll_interval = 200;
 	unsigned long poll_jiffies;
 	unsigned long time_limit;
 	unsigned long time_start;
@@ -261,7 +261,7 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
-		poll_jiffies = msecs_to_jiffies(poll_interval);
+		poll_jiffies = usecs_to_jiffies(poll_interval);
 		remaining = wait_for_completion_timeout(&wc.wait_completion,
 							poll_jiffies);
 		if (remaining)
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 339156113fa5..40ff0ec2b879 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -4,7 +4,7 @@
 #ifndef _PDS_CORE_ADMINQ_H_
 #define _PDS_CORE_ADMINQ_H_
 
-#define PDSC_ADMINQ_MAX_POLL_INTERVAL	256
+#define PDSC_ADMINQ_MAX_POLL_INTERVAL	256000	/* usecs */
 
 enum pds_core_adminq_flags {
 	PDS_AQ_FLAG_FASTPOLL	= BIT(1),	/* completion poll at 1ms */
-- 
2.17.1


