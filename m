Return-Path: <netdev+bounces-186107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43904A9D334
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436429C539B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E72248A4;
	Fri, 25 Apr 2025 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UjCxvs/L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1FF22370F;
	Fri, 25 Apr 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614008; cv=fail; b=eFFv2MFQBaGkKiUMLRKNHJXzyESLq5HnoFXxueAK+t98jTc6k6ZsyMsKb86IHLe8RJrw+XHavvHDO1PZpNXxo6d/bztEVPXOijKAvPSYGNvchRUDcCYVyS+KEo81v8teuxMVot8KzwlfZnK+0CbpQJexFVonFeaBCZ6ejAkN8xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614008; c=relaxed/simple;
	bh=T7C+Hngt31R5TO0gEPEt7xOtSiPW/34IC+UhPir1HmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9hB/MvoyZev1WGPE3/X9s3z9K4tAVHfvpvQObnIV2eTwtqUur57c5TiardxWvSt26fYwmcdLHDdNZ+L8vWvbo3vJ4BZ8U5K8onYjjRBVZQqShOdKvTgCLjca/uSpxfzcLQqReFA2tQN0l15Ikf9RstvSw6CMldPrMIeuhsi8DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UjCxvs/L; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6PvBbYDoAj2mH+7oPALETGOn2xQ8cBz463K3aNb4T96TsUrewq2EFyEVmZOihTeuoqjpJQsKYVT6ib9SstkU798jXIx7gVHMEWYthlNYruETko5UUkfIjFPsCeNtfle/Mg9GW2vWoyfC01R9t9usS24CXPQD+1y2akX4xeID7ZDKvdoAjjw64KsaYkiQ/8s410PEj02e0xpyXlEjXLSXWjco9u6BvStcHzM1g8HEl85uX3vSfUFIFz4p5xMP+pBU5VooVRYfjIOlXE3oGpl1Hn2ksOyBtv8A1jFz7CpKp347Qn9LqqIXRVkwwXkvkRJxkJ3FBcTlXOJvBFVKx1L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeLtd28lRzgSUr+KXHpIb/7/2qU7mzX5+7qXydQm5X4=;
 b=KS5xTCIcUHAnsIDdILlhxoTW7jR6aqsuUQMn8zgtJ0w0w00hDgy6X1riKA4bj3ed/nZIG0K697qARc7VC+OiDQBmKYTgA8NQy8xyG0T3f35XIVyZHo+8mpW+agGA6y6qSPjt+YmdNEz1IYMLBfrSfG3KnkmX+B4acM+bjyS5D9B9VCfLXynfkLrTwO0x0qt+Rd7xh0M4jjWUT/Rhe+EQUDNqxTcQHvtEO9c/LRFSPypbq05ZJV+jfzQdscuNpZmj1UCBiBZy5hnXptJGeBUCXZlWponHsTYOE+nbPU3Ew9oHUHKUKoBubHhFOJ4aOvKyu1d2/01wHek3CL1O/HJ03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeLtd28lRzgSUr+KXHpIb/7/2qU7mzX5+7qXydQm5X4=;
 b=UjCxvs/LOjj5LlckgMm1qfO8t/xEa55RCFqiTXSoDLLODYENxqj8Y3Ty6xVCZhYgBKsie6VR1wCNyf3m5wi25qzHx/dtMUh107bKv2PWSZu7YLMDRyIzKzjap4R7/B85gH+kpE4JYTVGvYwXI5JuppPb5wjdguwg7dhU7TXnHWE=
Received: from DM5PR08CA0030.namprd08.prod.outlook.com (2603:10b6:4:60::19) by
 IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Fri, 25 Apr 2025 20:46:42 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::89) by DM5PR08CA0030.outlook.office365.com
 (2603:10b6:4:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Fri,
 25 Apr 2025 20:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 20:46:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 15:46:40 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 2/3] pds_core: smaller adminq poll starting interval
Date: Fri, 25 Apr 2025 13:46:17 -0700
Message-ID: <20250425204618.72783-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250425204618.72783-1-shannon.nelson@amd.com>
References: <20250425204618.72783-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 480e5f6e-69fb-4f54-4046-08dd843a489c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A9SEEJJ2zsUvjUKGTF/L3PgOSahOyYMX3IytDdgEhorwel5+ajd5U6Jyv0Oc?=
 =?us-ascii?Q?PP2LD74IA7cJrqPx0uYKPAw2Pz36pOimbwgru0GdZhufghzYzFCNFbVgg8De?=
 =?us-ascii?Q?7UGkwUutDOUAZRNNBNIKLrlNXd6tJX0hsUqouI/WhnQsyMvQx0o4Ipx/7wdc?=
 =?us-ascii?Q?zluOQ1lDV+jS/KdfNP/AvkDViNYCQTO0RA6h7+CgDevEpqCRsRECumJGDlhF?=
 =?us-ascii?Q?km+80czaMA6ng31E+9zSTExnINteusCn/tLcG2wXdKqcQGe+qCaEFXewa0IZ?=
 =?us-ascii?Q?LbEoZ3xur9o2OYgZE8HW2b+GC4W+j29ZKhM1spVuMJCZpfhTNLB8+IxJB8df?=
 =?us-ascii?Q?wSo7sC8iNmN6gc7jlwxT0Pr/7WFJ495f3fmUtMtyKly888ApobxXaEci3W34?=
 =?us-ascii?Q?nHAvO34rpX498omfSn+dtDb+sbinbTOq4+9OLaIUXbtho7zazyBvYhtYd3+c?=
 =?us-ascii?Q?7LSDGbHxGKWNb2zsRmJ3A6hEKMZPIFaM8XBFLHrUwkWZnMParSuhwlr+3ic1?=
 =?us-ascii?Q?PRXZKIXTLaTqsy6TaZOwMtMJHfuW8BmoF6YTXm1herP6gf2NjcfooVQJjaAA?=
 =?us-ascii?Q?qqG36o+y6Gi+te5jJDbKIXJjRZFxHIbBU5QmrM24nQQUB3RD4DXYsNPTfD7y?=
 =?us-ascii?Q?uA2eXa64pfdtQcqxvipTWCTHvdwwbiPlINfHbpST1sODgbUXcyhunY78f4zI?=
 =?us-ascii?Q?Z5WQZ540mBmhfZDZRzGmkrn5OQWG4y1sQUNaEhqCgXQrBntyC00axA52ASgh?=
 =?us-ascii?Q?WnO/jBPe75G/SkoiEb4gciLZR6/iBdk6JXqNxiT9l1EPHAwOHbrjobJ0IxV4?=
 =?us-ascii?Q?pW3MRopXHjyqMIdAKJzpbfJ3xXrarUHXCDU9QimmEq2Gs9OmVJiAYFPbiE64?=
 =?us-ascii?Q?S0795uR1O7iXTfkAXSOQDSIUZRWVViuqd1S0GdU2NqhXLdhoZrnfEgOicNGz?=
 =?us-ascii?Q?mjAaGrYn3RP3gwyPoGgu5dACKwgVqQ4Jncqli4S9HmFsseDoPk5kYJ2ytsIh?=
 =?us-ascii?Q?2qCH+nVnzYWX7J4p1ibCexa33oGITYO2ofrc6AqzF8qC458uleq3+cuI8FqM?=
 =?us-ascii?Q?T/9RJIflZhwDeeq01xCXC4XSgCMLveVBk1eSEPs8L5XoV7iv3L7VZ2QAGZvT?=
 =?us-ascii?Q?5dkTScsv0vY4WoTS+qc2dH12fQrlKWJ1d3nsdf7EiiFuLbqqKHKM8BIkhPW3?=
 =?us-ascii?Q?wCYWmh5RoZ5NhOwCNhS4NY8i2tDVGVHTKP12/CkKFcmSjeDtb4qpcPlyBSzV?=
 =?us-ascii?Q?7qX6LbtNisCXyXR32ofXbe54lJ/RLY9oSM7Grp5uAq5SkzeGw6FzHFsNKJId?=
 =?us-ascii?Q?JA/zJ0953taIDrCNBWRCGvN/4h8VP0dzpKwE228Yf1lLGv2FMhq6WMOo0VWI?=
 =?us-ascii?Q?fPpXnCOZnqyL8w9zkt8CAwxj3aGjMl25RKWaaaqIW6vPVSXjiWT/sHkZ60js?=
 =?us-ascii?Q?05nH9iDCcwFKAtVRUFIJarPmNWjFR91y0vy7x+6BS/+iTDApD/0f8apLCuWj?=
 =?us-ascii?Q?cDq+pTMNsOkQ1JG6um8yG1Oh9Pity4ntwD4m?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 20:46:41.7022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480e5f6e-69fb-4f54-4046-08dd843a489c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388

Shorten the adminq poll starting interval in order to notice
any transaction errors more quickly.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 4 ++--
 include/linux/pds/pds_adminq.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 506f682d15c1..097bb092bdb8 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -225,7 +225,7 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		     union pds_core_adminq_comp *comp,
 		     bool fast_poll)
 {
-	unsigned long poll_interval = 1;
+	unsigned long poll_interval = 200;
 	unsigned long poll_jiffies;
 	unsigned long time_limit;
 	unsigned long time_start;
@@ -252,7 +252,7 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
-		poll_jiffies = msecs_to_jiffies(poll_interval);
+		poll_jiffies = usecs_to_jiffies(poll_interval);
 		remaining = wait_for_completion_timeout(wc, poll_jiffies);
 		if (remaining)
 			break;
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


