Return-Path: <netdev+bounces-183049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A555A8AC16
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32ED57AA2F7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD0E2D8DBC;
	Tue, 15 Apr 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WmE3pnvT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE141990A7;
	Tue, 15 Apr 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759801; cv=fail; b=ERYJ2StUSJ0WzHUZSPhp4XtnP6pAMdY6u0g4FcGGNd4m0Avzc5Z72qd7/cTQLV81I9bN0JyUE20d5VtFjwYDUPdptyJ2htx9W2WnA/kjJq0HWkw0tPGewhEdkdViGR210aUSfgsRIiU6nPh4aOjVqaV/Uq/3L8Ab64/uryXKFwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759801; c=relaxed/simple;
	bh=kFcCi1dgN+s5OaAOzsKO1pxsO7twBvPvIbCTJjJhJ78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndvhlga6YTh+OSvaI4zt007NPVHRdpEt/sy2slnE1Y02Bip3zGoSM363JMvU6hiE6Q6/NdzxeYFfgcPpScVjp8oWZo36xfhU1b+RpiTqHVcoJLgD9u0ZG3F+17W0ot6RxQFBTT6vvOuk4xIPBdBGmms348BWuIreB2yAaot8dJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WmE3pnvT; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXZdX7R2LmyweVqqhCi+dLiDhT4Quuv6kjqvcrYCHoMp4BKwuK9Gew4mJ+YpeedCvGpTOWw4b7VvfkTRQXheC83SFJHDcBpWGVmAPSR7vzeYcnV49U4a8KZK5SbWcq0qv3lz2EQhhwXmqkZbcCSqjvcgRyTjaQr4/iViV5+2xP6+/JRQoSPF1mWdfD78JUW5Uh+qI4chU7ldB8gPkyfqV1y5wtd8wh+wkbhDEHwK9G+ped+F8pvCgFSnKFPASDfpWPUYvQHox6V6fRX06hgHUZUfvgAI8G2Cks/iOxCE+Gcf8bFY+7YPT2BhcjzpMBP222z4dE/rd0VOiuAi+AQIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHI1W6AmZKnZj3tr3MUhqFxZqscxWNXPz/uwGHGxJM8=;
 b=YL6JCRRshl0BnltbyadQFfEf+F5vUarZjL2DwFCKVYH2G8Z8v4ecXw4b+yPB1H06BSdhFlso4gmO0Cq+2RiTATwmS6D6oS6xjjIBYCKEFnwXJjQagaNKeQMXjjkAkq2v0Wy6zQaHnZ5oXKhgZGfejX30wQySvZ0jMWsH+NzwWuDbIyR4qnbuMZfiImuqbkNFAnXG0DbtLcQBxfhLsSsFpdWol21uequ2+6wnjRs0H2G/9+FP3Em9CQ64HH+AemOFU4cHw3jKYSy8Tkn3b3UaPhVwzDu2sU6/sUVCGs5wAQeTPyhjO/OEthXw9IY72+0ri/k27/Bx/uZrnKNE6c6ULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHI1W6AmZKnZj3tr3MUhqFxZqscxWNXPz/uwGHGxJM8=;
 b=WmE3pnvTBMehZuDkiGQKO4dolSVeLBf3t8ILNYqhI28REmPUSrRq0iT4wTjX5EYgYYKtRWFfv3ZUEeOO7IIzvEs1Av6fqB8eg0rHcJ+QhUSZQV9dIpYAwqPas3zwydUpwiYKIg2CrU+mgyLE1PFFP7YFaNYoB5zXe2+unXhuzTU=
Received: from SN7PR04CA0233.namprd04.prod.outlook.com (2603:10b6:806:127::28)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 23:29:56 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::48) by SN7PR04CA0233.outlook.office365.com
 (2603:10b6:806:127::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 23:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:29:56 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:29:55 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 net 0/4] pds_core: updates and fixes
Date: Tue, 15 Apr 2025 16:29:27 -0700
Message-ID: <20250415232931.59693-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: e523c700-989c-4ad2-bfab-08dd7c756ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1f7tFG6Yt5D8UNs1o9JBsFBL3s/jzL7SIx1UJ6xcG5CwXuBXh7I+ejwnq7o0?=
 =?us-ascii?Q?fzBQe+7LCGbJmJNF8gKnj4XrPUTeHoH7qnwcB2sfQs4PI0v8g9sRLzZ9b9wb?=
 =?us-ascii?Q?PutpVhp3rt7YdS0KMRgyPMBga0XEtrLNKldKOTXrzgmh72fmO43IkLrWmLuY?=
 =?us-ascii?Q?bcMxyFPBdLGyk2NhX3UUFBq/fHqMm0o/Fj1w9Ldll2aTvQlmtc5ra/zRhvFT?=
 =?us-ascii?Q?5gRitnAMcUFlxlETs8FEK4C7beG0NA/8xl1i+e8bjPR9I2UynuIIZsHaUEE5?=
 =?us-ascii?Q?E2RoqvrFjP3lUNeLRDNNxyD4TpGZyvku2fPHd9YRju62TqG4uYqjRg5VBrOS?=
 =?us-ascii?Q?Td7i3mIdb866kYEzFqvxOoQOiHJ2qepx/t2TOM6OCv+OMlGC/h5c+L9yHgM0?=
 =?us-ascii?Q?MYaDCKE7e/NryLX32xZOMK/c5BK7t2CC158lL+IwUep6eMHG2Ln0FF15p5pu?=
 =?us-ascii?Q?hR9ecCj+s6vWQxXt9NxL1fmH4K/8VDUQiw3AB5ztAi/XddKH/9HibqbC9nkZ?=
 =?us-ascii?Q?hppHRrTrIJOpqoRpTE0kB4LRNdJa30pU/cn71CoDrrvjuL4ibrjlNUTni02p?=
 =?us-ascii?Q?2SoEHPf7fkn9uzOaTEjebYifMqvJOyXjuLXo009AGWr6ZscyBzIzUHwLTB2P?=
 =?us-ascii?Q?mNlsWd5p6gjnHJ1WY7pBWhuEO403zm6X9QHeGZFxCLz+tLgkF7yiwXBTilaH?=
 =?us-ascii?Q?XASzzkBjTye0WzzWL7YWN1qsseB6WWKfhBrdqVnvuNIsF+LiZLYRtGVwpEC7?=
 =?us-ascii?Q?VNIulIlnMJDqbDjyWdL5lUgPr1HGyR0GFAWwV+KD9vs3HIuusH8GpsuM67qU?=
 =?us-ascii?Q?j/Q3XDA59CRFGgao70mAXglN6Ph1Bho7puIQ4M+GLfsNxGjooMhjY+b9Pr0M?=
 =?us-ascii?Q?+2dgJ9Bycs+kkodIFhC5kfC+koNvT83bEZyvulcgl4RQCSIIIXseqTRt6zid?=
 =?us-ascii?Q?umMbIHRpX88ws2rF8peuFhAP/bkBIPBFBUl87lUNI3sQ5N8aSrTk8AO7+hDp?=
 =?us-ascii?Q?n3ei0tp4/UhoCI/UWmwlmQ2GTMnnrjdIRfHEDSz10heQzVUysFVMltJW0Pup?=
 =?us-ascii?Q?ShdfEduOZb5EQm9q4A5mXNj1GR9CFpjtwpkEhhyUGgJA4eLEmvhQ5eSO7j/4?=
 =?us-ascii?Q?xwr/3Pl532oOf+QjCkcL4huB+CjK0t3L2k5mhVkOOsxVOJ6jDwH+RfQu0BZG?=
 =?us-ascii?Q?BHY1isRCUyrwowM9oGkIFV3eCzjqsXQLxJjBX2Cf76OMnfUeoyKhN5rWjzDS?=
 =?us-ascii?Q?lphfUxNdq2uUn3AY2QDoWl/o5LnmSN47QDjEg0sopLZbMzOoxKOyWV4deEDw?=
 =?us-ascii?Q?tnxl0QEbgNmMH9DjUTUXMmeDYqBX/fuKMfPKQxqd4bktbs/eBcQlQOk+3FvD?=
 =?us-ascii?Q?Aww8Y+eojlpLkNBLyEky8BEeWdR3pyd4zkKC/MTMX/ZmAu4lLumA0cWoPM1q?=
 =?us-ascii?Q?6xY5Rz23UnE0FwZJH+uaSzg6aBzoDRdGeuBU7OsoL0+5Cwr6CGOzf/xpB6oB?=
 =?us-ascii?Q?tr2awlsNheOgCCsNlDazQLYtDSy8uGndQOEPh2oyQQAA5rHP0NhGRUrQz31l?=
 =?us-ascii?Q?RbIGh/nQHwx+mzvNrpI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:29:56.4874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e523c700-989c-4ad2-bfab-08dd7c756ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

This patchset has fixes for issues seen in recent internal testing
of error conditions and stress handling.

Note that the first patch in this series is a leftover from an
earlier patchset that was abandoned:
Link: https://lore.kernel.org/netdev/20250129004337.36898-2-shannon.nelson@amd.com/

v3:
 - dropped the kdoc complaint fix, save for later net-next update

v2:
https://lore.kernel.org/netdev/20250411003209.44053-1-shannon.nelson@amd.com/
 - dropped patch 5/6 "adminq poll interval", will send for net-next later
 - updated commit comments and tags

v1:
https://lore.kernel.org/netdev/20250407225113.51850-1-shannon.nelson@amd.com/

Brett Creeley (3):
  pds_core: Prevent possible adminq overflow/stuck condition
  pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
  pds_core: Remove unnecessary check in pds_client_adminq_cmd()

Shannon Nelson (1):
  pds_core: make wait_context part of q_info

 drivers/net/ethernet/amd/pds_core/adminq.c  | 23 +++++++--------------
 drivers/net/ethernet/amd/pds_core/auxbus.c  |  3 ---
 drivers/net/ethernet/amd/pds_core/core.c    |  5 +----
 drivers/net/ethernet/amd/pds_core/core.h    |  9 ++++++--
 drivers/net/ethernet/amd/pds_core/devlink.c |  4 +---
 5 files changed, 16 insertions(+), 28 deletions(-)

-- 
2.17.1


