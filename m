Return-Path: <netdev+bounces-126116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E696FE74
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50ED289C11
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03D15CD55;
	Fri,  6 Sep 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oWL0N0hS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991F15CD41
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665204; cv=fail; b=AyoPypL+BEnTVPsbUtuyg24eYQ1LoyRJM4s72bHoycmkI7KeoPthrXon/d4klSspvUkA0XuMBrbQvu1KhLprtQ9xYWUzohb25jo1CQPEwQA94E0k09veqXuNtrk1h3hnyHZoY6EymmRbdCKy+6YcTxJJMhqhP04lTsFt4uix27A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665204; c=relaxed/simple;
	bh=P1iuEsv9LD69F33rtPLd2XByel8YtzLzRox4UQvB+ZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AaXz4TVJ+NlJkhffPLz0+F7Hffz6a3L2eZixctE1B1kJxoY3Kq8srYe93NijtwXH0XMRX7TJ5zEPLQsRP+RVJWFO8nBT27fT15T4uD+BdqSMHzhYVTGi8+tmYK+9wE+VaI6vKX2KhNPWey97KzQfqBkOepWlbBlxaP0D4v67UjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oWL0N0hS; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7MI7/PtYEeFc5rVXRkPZZ6y74JFq6mUOlUx2ggBjnNnAHBcVah2neRghkbfJHgcQC5kyG/IZvRTWq1tdqE4JXUQXGRrCKppqyPjzHEQFBs0+jDbn5HI2nNlAh3icGbcEe9byog4al68Zb0IHEyBX62sYKsTr4UCkM801ny/FfRxe9rPPDx+bHGWS4yAcorc22mT0ngYN+U5V7r1nIM/vcW1xDVkRfXe2oocTDkfZG8GDjMW/f37pXLilrDXX8nKYhUCqMx6crE6LFqq8ORU+WxoB1FzXnSq/bdpUrysxoMz9YrZ9bafQSSeNciBnd10HqFeqNfFURz1YDdWFt2GPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v08DcKISfrC0g/iIQOaWWnLOkeTg9M28w2v96XQQjQQ=;
 b=c5q7Awg3t+U0WlUcQW+CxahieJ4PJbpN+ItxhXfI6sfMP5pgrheWvBA7Z3heI5qFZAkk8rypRbEZdPMdKzHi1MzTQXi8tSSO4kqQJLXtXwYd+2EoMTpu/O48s0jYhMIyezoeAVV2PRpGSHS+nBIDi5QUd/bswi9VwTpqUPhcbiLiimMXnxBp6YMVSml4bCDJ16TsfQvJCR5frdWX9XT0QHUvJrNTQrhKuQeR8tLw8Mpfa8DQb0LEb4PmbgS27++ulE84ja81zBibQ6OCKsNInbD0w/K8QmsWxb7e4XMruZjpElFOcLKbkGBYjTJ6U8cS6URzI/gTmLS/R9hyq3lGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v08DcKISfrC0g/iIQOaWWnLOkeTg9M28w2v96XQQjQQ=;
 b=oWL0N0hS8c9P94TJ33vhC8xHtX+4oGFWI8qzyMk/61563jHXV1scKzvVENLlVJuzy7RGr+BP1Ff+ZaB/VAIolFsi24aVd09N1QOI9fhSoLwjekCKuXRVC0FRw+1qOrj7tIShbX4e4pcAfyGFXHz6pIadgCTzSODqNkq0IWb/+Tk=
Received: from PH7PR17CA0071.namprd17.prod.outlook.com (2603:10b6:510:325::28)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 23:26:35 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::ed) by PH7PR17CA0071.outlook.office365.com
 (2603:10b6:510:325::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:33 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 0/7] ionic: convert Rx queue buffers to use page_pool
Date: Fri, 6 Sep 2024 16:26:16 -0700
Message-ID: <20240906232623.39651-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8ef53d-53b4-4742-20e4-08dccecb58d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eBSwUZ9uNzXO5ChI6Y8Rsv6snnwLP1T93aU/46w7nY542V9bWR+PH5ffB7PO?=
 =?us-ascii?Q?Ekh1algBf3jST5SbntDWE47h3BXCO5MeqA8PbYXeqZD8du8Y1YaDhxpw14g5?=
 =?us-ascii?Q?pT5YxMNdIS1n5HQMnLFQuicIcBVdOTLc3yfCHK4U3chmoyNfDUAINB6m/Akl?=
 =?us-ascii?Q?NSWjbJJHsNqxU/uw7AQhRxHRiMP9Qu43Bp8N571R1opaQJbBKRSok5/fNldx?=
 =?us-ascii?Q?lUvGNRsOASo1mYg0wE3P22Vn7+CHVnwyownebJN6GQ4697ul9UeGtkZ5fdq8?=
 =?us-ascii?Q?Q9ETkLf1sw8b0GKNIRrpNCDsFlyCMD/YF/1i/K67UihFVGlZkHpFXsjj/1qh?=
 =?us-ascii?Q?uhpBt/8BdpkOK7qEMZZW9zSZYyw7Qs36Dg+CGHRXVh9sLAnfhLtVt3W/AqD4?=
 =?us-ascii?Q?DYCYTbjJcmLtgo6ilqV/bepSiOOC3c8Az7I9eCp2j3U5yPug9G9ejXp1xazK?=
 =?us-ascii?Q?oyp6rDa5Lt5kq0OHkNRoVdulBB7ksaf3r3gTZHzkY5U6UonRGPfxAfKE6EfN?=
 =?us-ascii?Q?wldguKzPwUwotFt4qw6i6wlVzbyn8agVZgO0Q4kpafnikwsjZS2oW6GjAmWx?=
 =?us-ascii?Q?WSYN/dsH9QXiIeEIWW9Gmp3yLwJGBXillIHVVB2V3gc35QMzFOkIBK93nA/Y?=
 =?us-ascii?Q?SfvWae8DiirkA4RLC72reaVP+8YxKk+QTsvBFdLlKl+y1P+NbqfkYXDgsof5?=
 =?us-ascii?Q?OjVCnsgqNuxe2aedD64RMV97eH14vl980yuM1LLDHSPZVT0h4xNuuvAQwJyI?=
 =?us-ascii?Q?MEz8VG7hFnrNlhu8GsIkw0ZmF6X59fmEOVaU7nuxvk5+dZtvgDI3r7LRv6PP?=
 =?us-ascii?Q?GhNa86LJhr8YlQLDNjZ00PscyO/XVixLac2bQhkQBPwDVE9YDI0zamjJsZHo?=
 =?us-ascii?Q?DWgTPXKr3zv1NzeTsVz/+9KbSL+lahKklccSIvmUQvBjLQtY5gd1k+6wwEq7?=
 =?us-ascii?Q?XI/R+4cpa6C5XwlX+ldzjbVbE5nFntnbzOx9aIkbpfeFNHjrBeH67NwF6r9E?=
 =?us-ascii?Q?oHP86ywfBVWyXMmLucBc1ICDZOZMLEKoFOlgLiZztYY9P8TvkJcR1roWC18L?=
 =?us-ascii?Q?bLImnoo0PwkGRy7wgDwsx+2zTfFmUFQT/q7m0BmGjW+IMS9MxsgXWeoN5AJN?=
 =?us-ascii?Q?H/fafuPeOjKq4gRbo/RmiYTdB9svitmFznyEhHssIpwW/pGEc5iMdPcilLvo?=
 =?us-ascii?Q?RFSgcnLaYhqCUXJWkRMX0rx5UZltN90ji1yW8FIp5JV6Uvsi3GM0IAT2oeC8?=
 =?us-ascii?Q?YQ+IqHdouMoNoL38R03phQ3fjm2FajQ45lTJRkKlMu1ujmAn3+eOarG1s4ID?=
 =?us-ascii?Q?QXTqvsURhbQ117WKaWxxuOFSCFIidDf/zfsSKZqH5C+OiUFeYguJAhv4m+jy?=
 =?us-ascii?Q?IvmaXwW4jVCEAg+NKDeFQOS6/siFn77g3qfbXpDbm4spmTtFWgF4XO2fRyyT?=
 =?us-ascii?Q?miD0BA6Bceq5Rtc7x/35iStjogOhcYjB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:34.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8ef53d-53b4-4742-20e4-08dccecb58d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544

Our home-grown buffer management needs to go away and we need to play
nicely with the page_pool infrastructure.  This patchset cleans up some
of our API use and converts the Rx traffic queues to use page_pool.
The first few patches are for tidying up things, then a small XDP
configuration refactor, adding page_pool support, and finally adding
support to hot swap an XDP program without having to reconfigure
anything.

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

v3:
 - Fix overflow issue introduced in patch 5/5 from v2 (patch 6/7 in v3)
 - Fix/add ability to swap non-NULL XDP programs and do it without
   having to reconfigure queues
 - Fix stress case when swapping to/from a NULL XDP program many times
   that resulted in xdp_rxq_info_reg_mem_model() to fail with -ENOSPC

v2:
 - split out prep work into separate patches
 - reworked to always use rxq_info structs
 - be sure we're in NAPI when calling xdp_return_frame_rx_napi()
 - fixed up issues with buffer size and lifetime management
 - Link: https://lore.kernel.org/netdev/20240826184422.21895-1-brett.creeley@amd.com/

v1/RFC:
 - Link: https://lore.kernel.org/netdev/20240625165658.34598-1-shannon.nelson@amd.com/

Brett Creeley (2):
  ionic: Fully reconfigure queues when going to/from a NULL XDP program
  ionic: Allow XDP program to be hot swapped

Shannon Nelson (5):
  ionic: debug line for Tx completion errors
  ionic: rename ionic_xdp_rx_put_bufs
  ionic: use per-queue xdp_prog
  ionic: always use rxq_info
  ionic: convert Rx queue buffers to use page_pool

 drivers/net/ethernet/pensando/Kconfig         |   1 +
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  23 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 159 ++++---
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   2 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 420 +++++++++---------
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   4 +-
 6 files changed, 330 insertions(+), 279 deletions(-)

-- 
2.17.1


