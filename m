Return-Path: <netdev+bounces-172992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA2A56C91
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7985E3B7A8A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAF21CFFA;
	Fri,  7 Mar 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pF3LKBhb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A362DF71
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362559; cv=fail; b=YOhxM0zV/N0uoYpJmU0RS41goKDGpWS5qTUUePEicFM+zmkqi+mtp/5yNKLk8H4mIkM0IhcH0WwcSaej47pSNXiZB9dY6JlYVOQd2mva4vaksH7U4PowFT4v3+4iMLEXdWNzcRzlZmlbuHkkvATr9NKu6qeWJW/do0uJS7dqM/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362559; c=relaxed/simple;
	bh=jr/+mRHfBAqvYfSn3DPfbju0zc9DAD36HqaAIM53j0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgeFeCg4m1I25BlpPzwN3tz8qHDSf2VnCQNHBH8HLZol36SAsFrY4KM8z6QL/Qnb3LPoVhzb8J+dfJNfGa1l3+Lqp9/eYQElZwSLH2uvjf4RxO5icOyX7Ifdw48uWLWQw/pzkkQvwPXFM6FdPb8bGbMI18D7KAg5VkIvIriFNlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pF3LKBhb; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLvJfSFcaPtSCXjX0jBiiJll3nlbu0yUDlUHgU2WnEfePyiwN3xJfGxKsY2/h+p1bl9Y1wtaSSdKCSB1wxuqLpr5VqYphtGAQIv8u5Kz+IBMSjUU+lprCjwbNuPS4trnXjEYajXDAExsxNLOe7+wBKhjGxQoQT7Fh1qAK1Xv+ZI4ecbLW4ubsR2FR+KLrfeqKntOtbZATPivjKES++DogYxeegN3DODNv/Nt/jIeZAu4PPxpZfN43Oz5NKoYirP8GpfQtLBlYLfq//l5oWtsbv8T7cC/G7f/nnoVN02KeCTUPUNuvdtNMCjj81Q7c/9h+G0j12D5yM/rh6Y9OT+MMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI0EUKqgzPOxQQtFP9LYdi9/qNyBZMZwKFpO5IobNZ4=;
 b=uOvzg7OflOYwh/pfYAlDtqHl4cNPrih/RUKuY9HEjPBogZuPCiZ8HEgwQUtjBh3rDxYZMW7w1SymmuquDo3SFcWhz7Dz1LI5UqdugFB7ts4eDIqS/7PnrS+IYJsqHAaVpaUvtlrQR1QAurpk+uPfvu5pCJ2oZaqZms6o+hO17eQLijT2eDl6QAYA8EKK/cvcETbUtJ4IDQS4yYP+ojc6vZ+yJpiBzu6GogjFpsAbbnW/x3juT4iGEwOZGCDthU3dMuGd3O8xEYNQJPQ3oSgk6CjAQJWBNKt4eJl0r1ljkX0XJGlmUTTBlMY0dqoc8EiB8xImF/6jWwhKm6OA4Uk+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI0EUKqgzPOxQQtFP9LYdi9/qNyBZMZwKFpO5IobNZ4=;
 b=pF3LKBhbj8ExrsK3swF/O/VibJoa8PMlwzwg40FQ1z3ODFiSQgpWERaAna1auAa8hHtr1A9radNglgAqIJy0EQrlunhU6Xm2jn7RofhAIXbwG7s4TVETDgH9Ab2CKWdgzZOM4mtwILJ1g5PuebZVKfKWIF4TJtUkr8IjUKt746w=
Received: from BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Fri, 7 Mar
 2025 15:49:15 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::cf) by BYAPR07CA0007.outlook.office365.com
 (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:49:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:49:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:49:13 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 7 Mar 2025 09:49:12 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH net] MAINTAINERS: sfc: remove Martin Habets
Date: Fri, 7 Mar 2025 15:47:31 +0000
Message-ID: <20250307154731.211368-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 32acaf9f-f2d3-4e1e-afb9-08dd5d8f9ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iuq62TFaychfNU419mh0KWvs9dOM6h5LY+tck1P5J9cE3GweMlbBDWaLwhyg?=
 =?us-ascii?Q?S3EADxRK0IPln4PoAqItFcU2UYIJ5hXbIhyhyQh8brW65FQxDtEr6FhS4DvM?=
 =?us-ascii?Q?DeGzCX2h7/9MfdSgHRF51LL+2TsVgietq1yD/mMLcX9GkcihMPuCBwj49Nsz?=
 =?us-ascii?Q?BkaWZgz6qUMa5RSJi2ZmIn37Ae2zEE4R67GZDxgPHtloPE6XOVOTwZvS63pw?=
 =?us-ascii?Q?JfrEXErMHr8+oY+zum68ibbs0kz/KSbK87xc4bsm1SmKcXqi+E0c+rWSj3GG?=
 =?us-ascii?Q?1N46vrRqnoHD+vqPmIcQ8xm0ieFY3UGrzwjqkl2sROWf9kN3CNYra1gj/dDu?=
 =?us-ascii?Q?XSvTvFZ07L+hFUxcRnnkeYL+K/QBZC5fm04thj55T50cDJbckmO9rCpql1bF?=
 =?us-ascii?Q?rsuKUJmMPEY7WRo+jpB6wqROUG6Jkp7mIsuf2aTKaBPgPUQBSxVQWYBGEylh?=
 =?us-ascii?Q?OR8NeDzohWW6Bw26s2Il5EdiezN8aZ6KxhTsYM2Y4igtnIGkiDFAe4Te8Qu+?=
 =?us-ascii?Q?E4MPjrr7OwVxKT/hgaFjVG+ekhHYGZZ2WK9D9heGt9XksddSozS98ICEo03I?=
 =?us-ascii?Q?yzql8tkILeTbDcl+cwHp3cCy9W8mViL++iQW0BCxfUXH8N5sAyi+oSZFq1kU?=
 =?us-ascii?Q?mRS20g+MdesK4B23WyxRx2l7LKYpS6zdCUjVvIOMCfudPI7U1nAWKlvvHxxc?=
 =?us-ascii?Q?DZ3r5XiaPOtf9/cX/P2JNBK6WnZqPhEuyrKNTNKo/mzwEABngB1TqNMtgf06?=
 =?us-ascii?Q?HEaSYjaPS666QgeKfJ2XTeNpVomj6C5VntuBkDN6ehNDoleaQGEDz7BZmBEe?=
 =?us-ascii?Q?byrFjiPGi5hxelKpBNFdFCSKmhp7lI3hNIebyE9xtPu/gVpgmJYlIYEoK4PJ?=
 =?us-ascii?Q?NAFxN29NtwB0rQWdKrRaUipuH7sx06Pd0zhsltht/+tztt1lxGmWqhHs9EIu?=
 =?us-ascii?Q?DC8/gyzmhYwzJqnqAzMc1oOkcDl40yn5d8rsgCTGsTdnKjUwQb6UBxKEAbHh?=
 =?us-ascii?Q?xAYAuxkQhsIyo0WST+qqsxaTWj60JLxvle7K6Nacph2SJN5h1gSgbJ7TbDWT?=
 =?us-ascii?Q?9DIpL3s4O5ibjeobmfpJCJCCm4FzIg6LXz3MN+ZxGdEZpZkJlpqaWYZYFkGg?=
 =?us-ascii?Q?m9gDa3Pl1FJJ8lytpsYmRWuyA6/JBuj/BGyFItURb6+8tzoYT0DS83wOgYni?=
 =?us-ascii?Q?iz9/jG8iKd7fz4z5R/ABLMKlqB+qP9UCmL7KuqPtjUL95TRd1R4MFkkBkuWJ?=
 =?us-ascii?Q?JKOVfGeGCqamG9p6nHKlDm4F0emMnL7Mq9iTfNWF4NoUj0U+JSWH9Vso4vct?=
 =?us-ascii?Q?Y7P32vzIVjRiF+WHZsyDpJKz1ukgEHUGCAbT/Ez5b/y1u8Q7hO31oWEOsv5S?=
 =?us-ascii?Q?10tSUIqOT4qYrPy+YJaPczg2rxexQ6qq73HBdkpFQR3w3ASGD7TmyQ+XMMut?=
 =?us-ascii?Q?RprsxAeNcpUV8RMsyvw+hPpvHPuEcrvzBGr5cK4wY2Nmjjl4u2791kt/0O7D?=
 =?us-ascii?Q?2AlJdzcYx9Iw+UY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:49:14.8568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32acaf9f-f2d3-4e1e-afb9-08dd5d8f9ce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840

From: Edward Cree <ecree.xilinx@gmail.com>

Martin has left AMD and no longer works on the sfc driver.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca11a553d412..07b2d3c7ae5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21502,7 +21502,6 @@ F:	include/linux/slimbus.h
 
 SFC NETWORK DRIVER
 M:	Edward Cree <ecree.xilinx@gmail.com>
-M:	Martin Habets <habetsm.xilinx@gmail.com>
 L:	netdev@vger.kernel.org
 L:	linux-net-drivers@amd.com
 S:	Maintained

