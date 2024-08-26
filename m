Return-Path: <netdev+bounces-122012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AB295F91D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0411F250D6
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EC195FE3;
	Mon, 26 Aug 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1GRi1pws"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCA81AB4
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697885; cv=fail; b=DnP88YFKzTYFh1VAkKZsSQ+rjJ4vEPwBbl8GeUH/LfqSVHgUZL5wdqBZBDc+OzEzhVwPN1oSnxOyR8JYHNVIACqKqiVEOcbtA9MLLDbGJVM1HVo8dgSlriny/UlxXplhpJ0zKCYx1wUZpazXnvaKGXfa7Q0/wxkfj3QNrYMEQA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697885; c=relaxed/simple;
	bh=2vR5w2PeYeQjKtFasJYLM/snbB9i6t392SqrvGM8In8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u0lS617LIVNTIR35dfcFXFFC1thaYSgVfWxKcWM8dZL2cZgr/HWPMUI6LgnW3FwXV3InPVOzTOjjm2wU4HHRh96+gRe5LmzG0i3XlPPUAbiRR1SCjNOHNYnSJULYjKkBKriLXSQ8BagEhiunGdTEAhpEj4HD/Ae/ymqYzQFvyCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1GRi1pws; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM8DZGa31gQqwwm8AHadFqG80V/u47QbuCKSJHs6wfobQcSYTedbU8nsZTfwJtDY9lW5NAzjQYWnZoMV73fg96WOwpTuh0b6t/B+0AfU+DaPscDUzySSprp4JCbFjRMZVyFKZ24E8BinGMTjei1T/F28LqHzBY6cGDQgLd15yE9KOiyQ/9LEVy6Fjur2gbbyfk4Ux7Rl7nZSf+4V06DGTfKgKXj4yylX0lI5yWGxYwKIenzClm+jGyGSq88U26oGDVD+o15uVEENpRFSEPBYjqIPDKkYkamj/aGjwF+0bO+N3UGN+hip/clq9NZxGdhNEh7cdgEfeAMPfk2jZn7S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwSxwl3NveO7UA4zaHqzvIr3StB0XP8T3vQFC7Pxr1A=;
 b=rufQpqNfK/Jnyu3/4XSa6dvpVMa3Vj0UjEtK1f7s5gQzbKoj85dHj2MaZfOXDLyeLaeKSbEa8FsbEzpZMrRzDZiz8aHicimcWgwfTOmig01sNcbNieEvl6nWLv52PfvJ1jcvmexRHM+lUyJhoqGy3HGLAOMkJgFVmZHKq4vBJlJqLh0Ka6e+sea794re7MNo0/48z2YYh6sTl8EFUEyxJiQ0DoLGyPqNxcXAoKgwiObK27rf037NgxpSAq9x6m5J1T20yuz5vGBEexWZJkP1u+Jv9SboDenSmIWn/SLEFaEBDhzbeVsIOfSPpkv4RSIa5VtTo3CwbR9cQF05LDRf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwSxwl3NveO7UA4zaHqzvIr3StB0XP8T3vQFC7Pxr1A=;
 b=1GRi1pwso7eZ1d1J3pRTrvfP+7g5i6Abaz9UKu/RswD3hPl+D6R6Ur1jAzlDZqxXRXZZ72kL3WrfT+LUYOw4jmotSIqA85v6tHY257kwRs0Tv4v8ZPK1N3735I0c34GqGkWwQ2lPqJAH+vjhbKGmKj6VpSFZmvJ0BCKpaA1elpk=
Received: from CH0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:610:74::13)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 18:44:39 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::bc) by CH0PR04CA0068.outlook.office365.com
 (2603:10b6:610:74::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 18:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 18:44:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 13:44:37 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 0/5] ionic: convert Rx queue buffers to use page_pool
Date: Mon, 26 Aug 2024 11:44:17 -0700
Message-ID: <20240826184422.21895-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: b9aae6ec-3d74-4797-3067-08dcc5ff23fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?66gRJAwPkAgdmwGQhzJ2Zx/SZXSmZW3EteAsejAcSaJUXl3P1aYppeY0PkvR?=
 =?us-ascii?Q?ykMxzIFsGq/4Mmd44JH/arPkiLCOucDRs1DxreunKBTy2kNmF2Ct4sno6tJ5?=
 =?us-ascii?Q?hA/hMMrMztCc45l4v2jf0lMaEGgh9sHTjgoHYlQb3gl0CUfFRpEOCVZwXCse?=
 =?us-ascii?Q?+Dp3wtm+MBT0wYwmY0YGQAo3PVwSBS/E4bmB1xY4kJn0IoopbkUZYiB4da4b?=
 =?us-ascii?Q?2WkM2JvtXn8p4IzZhKi6UwLQPrTMkO82OsYQ9DEWzNAyJ1UIU05ksSmWP6nD?=
 =?us-ascii?Q?u/C027kOptIQC9l2iiXd+cHo7sAl+f962B3GSkbdaZfQXm9aeu95yiXwYMqN?=
 =?us-ascii?Q?C0ol4iI3hw2wCIqWTWQgcZKFBbubBNzK0bgDIx31DkOSnIfjgD4b7jOpXHr4?=
 =?us-ascii?Q?g0jnIYU0g1XLHQyZIOWwg8HlwGTs028Ix00N3kFWs7zfTwOeXr+fNQFZegaK?=
 =?us-ascii?Q?LOGFJOhGvshf3HeGXYanI94ZLItVC0nH2NxDgRqdCjx8ANQVFwrQm2JQ0HOq?=
 =?us-ascii?Q?Rwkf2lMtEDzAUKPQy9I9msN3i08PlRM/4TKrsuNak3F0Wz7T7pkffd6mL+SL?=
 =?us-ascii?Q?qBAoJxQvZw2OW6Rf41p51RFFGW8yM4JunWG9p2yAJx/2hYOJ6wKJSvIGVZ+1?=
 =?us-ascii?Q?Fc0U7MpfVkwMq5QRFJIAZYy/TSJx3VelByAgZWc4YlhINuiLccRuh5VLR13c?=
 =?us-ascii?Q?p17Sn186wSK8F/OWQZD9ynCqr+sZIe++TNB8M5Z5bIlj7ABNZ/XN5onMpKlB?=
 =?us-ascii?Q?paKjZTi3QkevyZpQe6MkW1Uht2NeMBXbaMpw5lWHk+Y78KuYGrgHFzeeyL/W?=
 =?us-ascii?Q?E9Rt8sqr13yumdnkYyHbJtF3glA2Z+oxYjTHNuJKgJnkaCY8POfFSrFsqgxY?=
 =?us-ascii?Q?WbiEhEx9K8OJQQw9OUM5xLvsAzcexcRGeJBSiWJgrPLSAhhm3Zy+x8Jxm3T8?=
 =?us-ascii?Q?+jX+CJYivrTAQxjRtp3myoCTkyKjamVkU979eTWokfToK0jwvzVIACwCpvrJ?=
 =?us-ascii?Q?s/HWAvt8GqVVca/pROKYEcgf/h9VZZ6F0dDn3m4VJrKS61aET+vPl3aJFDtH?=
 =?us-ascii?Q?799yNpIb6X7GlcgjGFhek9ZIo4QTCWuW8pQjLoBWOYcxbgmwG8kbXIUr2DAj?=
 =?us-ascii?Q?/+GpH4V2ka+CudvO08IBplGYQSqYeYcEADtOIrGEemD1wqWZXkT15yLWtP5T?=
 =?us-ascii?Q?eEfx5aYPg2kOFG8O2FCPVoYvf7rEqrr2LM3JPw9ZCH5B4JpPl1TUxanbCIxe?=
 =?us-ascii?Q?51lrBLeUdiDegvSOjz+KrF1V4O7VEwKMys0WRKzfrjed3b7bbmAX1S+NGD37?=
 =?us-ascii?Q?Ql0ANpGcN9fHdSWsJCZ53nUuWBpas5AxAQk1LTZl665kxes0Ueit9EQUjxuF?=
 =?us-ascii?Q?znpm4KByDuq9VSLhqO5If0VAhEnKEQYqOOVueODKMxybddMg4DgU9zn5cOcE?=
 =?us-ascii?Q?I113qcam3G9D5prvr76NBf4DVP06R8Zf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:44:38.9983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9aae6ec-3d74-4797-3067-08dcc5ff23fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

From: Shannon Nelson <shannon.nelson@amd.com>

Our home-grown buffer management needs to go away and we need to play
nicely with the page_pool infrastructure.  This patchset cleans up some
of our API use and converts the Rx traffic queues to use page_pool.
The first few patches are for tidying up things before the last patch
which does the actual conversion.

The result is code that more closely follows current patterns, as well as
a either a performance boost or equivalent performance as seen with
iperf testing:

  mss   netio    tx_pps      rx_pps      total_pps      tx_bw    rx_bw    total_bw
  ----  -------  ----------  ----------  -----------  -------  -------  ----------
Before:
  256   bidir    13,839,293  15,515,227  29,354,520        34       38          71
  512   bidir    13,913,249  14,671,693  28,584,942        62       65         127
  1024  bidir    13,006,189  13,695,413  26,701,602       109      115         224
  1448  bidir    12,489,905  12,791,734  25,281,639       145      149         294
  2048  bidir    9,195,622   9,247,649   18,443,271       148      149         297
  4096  bidir    5,149,716   5,247,917   10,397,633       160      163         323
  8192  bidir    3,029,993   3,008,882   6,038,875        179      179         358
  9000  bidir    2,789,358   2,800,744   5,590,102        181      180         361

After:
  256   bidir    21,540,037  21,344,644  42,884,681        52       52         104
  512   bidir    23,170,014  19,207,260  42,377,274       103       85         188
  1024  bidir    17,934,280  17,819,247  35,753,527       150      149         299
  1448  bidir    15,242,515  14,907,030  30,149,545       167      174         341
  2048  bidir    10,692,542  10,663,023  21,355,565       177      176         353
  4096  bidir    6,024,977   6,083,580   12,108,557       187      180         367
  8192  bidir    3,090,449   3,048,266   6,138,715        180      176         356
  9000  bidir    2,859,146   2,864,226   5,723,372        178      180         358

v2:
 - split out prep work into separate patches
 - reworked to always use rxq_info structs
 - be sure we're in NAPI when calling xdp_return_frame_rx_napi()
 - fixed up issues with buffer size and lifetime management

v1/RFC:
 - Link: https://lore.kernel.org/netdev/20240625165658.34598-1-shannon.nelson@amd.com/

Shannon Nelson (5):
  ionic: debug line for Tx completion errors
  ionic: rename ionic_xdp_rx_put_bufs
  ionic: use per-queue xdp_prog
  ionic: always use rxq_info
  ionic: convert Rx queue buffers to use page_pool

 drivers/net/ethernet/pensando/Kconfig         |   1 +
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  21 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 121 +++---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 372 +++++++++---------
 4 files changed, 267 insertions(+), 248 deletions(-)

-- 
2.17.1


