Return-Path: <netdev+bounces-213603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE9B25CC5
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458CE16FC92
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9920E265630;
	Thu, 14 Aug 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d46iLB9Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBE220F55;
	Thu, 14 Aug 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155479; cv=fail; b=ItsSrc5FskVGKNdlvMjn5AcXqa22WY1mryNiHSxMgosZGo42CBXE8ydpSsYCuGP9pvCFD4Ee5NSbuQFs2jkuhPI8j84UZnLR4jUtg69NrxIDUdaws+I9nY3lAtpe2qXpx/4S69CoiPa/RrmtCICww0pAZ7OXxnHKfav+JPPLnXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155479; c=relaxed/simple;
	bh=HrjLw8OIcWzo3NWwldr7rU1EBh3R+8kn2WWLQsvfVds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IxrAR4TIvDoJDBeDjjG7Fp/nHC7hkRtllfwx6V1Vk1rHb0HPhKRGyVPLfLmtEwmNCECmgwaeY4c67c58PL/eHWA/BcLM7TbEuZxYqfTmgUg3wfCIoyNkyBX+F0WCeuB5Fl02k8AXGMs5p2DwwrWN3qfPhsA54b44duHVqfvtakw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d46iLB9Q; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipyXx+YIEs2CXU/Xq/C2Vjfd77I+bYjo0k3K+TiM7dHUl+8yYjzlqBcs4AvVX9lY5hkl3CMHjkMNeea9karie09rr5iLKiPExEmlkRXfHoFvmV5093TwkY+WbRgar5itacRHDl9NXMy0NbuwECHF6tJysmZgdQS7KhfD0qjVc5jwiMhRWCZ8tUDLhSyD0yzautJfM/zbLrQ9y05HvXb47T3yBafHVh3AP1bSqcFroxBr8VKZxJehevEcCtzeI18m5qrjbacXM1tIejI8qgeo4JwKqITcT+8BUJVd9TZ8MvQ2MnhDyfI4t0UDkYdQCFq9xt1useYGasDwU9aTQojbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LauraE25aBZhT2SLlMw51qQtgeN1Ou5Rpt8ZE/2yrmU=;
 b=t9h9/DReQ2MCcN6H4tpP5+DiTKAwigq1Qdd6+RsdisRWp4EN5ur2ABp6gUepgHz0nwxaHOzU8q6nVq6A41MpzrjBRPh07QBylvhzqzrez1PA1+zeLiUAxAtMscrKypSP/bq9ofFJ/EbL89o1YNj63GG7zwlyk/W8njgNSbADAYKyEG58mx0VY4UVESTJ4u+bGSPnuIzG1BAfgKUm+mlqHO3fls1X2MqL6MswDAzmmP+RWEpWbohIQre/WsOKt3Pq77W1ZhsFkaaScLTZTrU7LHu3VgKzgW3+1Biev8IccJ1zsPaOaBxLAm40v084xMJVIifEp5mYi9QcTAqVT2skiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LauraE25aBZhT2SLlMw51qQtgeN1Ou5Rpt8ZE/2yrmU=;
 b=d46iLB9QaYsHugVMU+mqIZXFKxd8nol23UIo5HeAIYhxcL9arNTXHnEiV6sqsfSafh9tBHcn5aCW0Ari8P2ZoPDg7F5MwX5HZf43fCP/hs+NVmIBTWTG/AXgZ6h9C5XfHbtxDdsOmj5d3Srhq72BTBgBBB1qqE+vfPFW8FEDZwU=
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 07:11:14 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:303:81:cafe::bc) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 07:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.0 via Frontend Transport; Thu, 14 Aug 2025 07:11:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 02:11:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 02:11:07 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 02:11:04 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 0/2] net: macb: Add TAPRIO traffic scheduling support
Date: Thu, 14 Aug 2025 12:40:56 +0530
Message-ID: <20250814071058.3062453-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 32adc4eb-3329-4cd4-3c6f-08dddb01c129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aHNnoqSaDmy5llW64qpGJ7HoGpEu4jBRtL1gn92X0TyCocjVAviGvDzoVhDU?=
 =?us-ascii?Q?pQ9zTsih3mhmnjwneb+DT5i0OtUoyFpEoq0/ti75R73afwCxpBu4o5t5zzvR?=
 =?us-ascii?Q?TKeEMmRFnqIKM1OXcBQwZKP9Zwop+m82JNE+khcoZjq/+2bI0pt34/+9ku3G?=
 =?us-ascii?Q?WC+7CKMErkkY4CeW491EtkKgXnRWQx4wCv070xprPB23U02iVHnOPG7zIdSe?=
 =?us-ascii?Q?/Mn2d9u616a+2JBkj0N89VMvYdkKQ205CStiy7AWMwNj+GpBUB0/WaKqw3wr?=
 =?us-ascii?Q?JDJ9+i+aaFzNcTssiRNr6pLWnnNLLfxg97D/GnFOsElkKTqc6EzEHymKMfHn?=
 =?us-ascii?Q?g2OsBxhMwWKrUBQYs3ifh6wSSqO3muIWLeXiq1N/D2UUfDiw+qnVlEeA8oZN?=
 =?us-ascii?Q?adLLNYTKurZRnxOl5wje1GGPDuWkYJxkRbunlI2Uc7IpAPPUaP3BcdH4dBaU?=
 =?us-ascii?Q?GjmQeLauYa2NSmh1DAFfKAfBeapurtMG4EklSQ2gBkLqo5QnPwvNCskndfqw?=
 =?us-ascii?Q?ufe7SPxcZod2UmECHL3CgxLhBoQT+cMbrVFSqDYuv1wcZ/uyyto3yqGT+G1Z?=
 =?us-ascii?Q?Dvx0uF07MglpWUIL6jfueMTpFbwoFzQqylhqEud7JLsDrSV17zr8RPoDpuGW?=
 =?us-ascii?Q?LJIfxo6r8eFpXTXPgMc/IRJAn6HNrwl6mtDwCi2DsDyX5hOlJBxop/zIZAVZ?=
 =?us-ascii?Q?S+6oqxGSkvHRR47Sm5yy5jY4xLWsUEzEOMeb9TNGGTDB0QIRTuzEMKBusKJD?=
 =?us-ascii?Q?gHp5CeT77DAHhUGDeU/VngZCMCeiAVyUWA5eBicTXuCJJTMqdhj56a5CkH3J?=
 =?us-ascii?Q?cVAkjMSp092+uhFdpY5HRvCk+lLJKDmRQwBIbrwRKmkKtWczHKJ9Vj26Jn6u?=
 =?us-ascii?Q?VerTB55uPRugatdphunCIOV9p+CND/F7FArsQpSEM5o0sKD4c6bSwdyYDF6b?=
 =?us-ascii?Q?I4DAuWQHEpk4rFFpE//QsPV2k92an0GbXT/hEVgB0TF/CSNt79ULDFz8d/pu?=
 =?us-ascii?Q?AwVw5qG4erxL1EIOMSXkhin3GgiUwsGoiA0vh/2dt1tMkQ5Mhw/aTLAkd2At?=
 =?us-ascii?Q?C3UVWuT1O3yNY1qFyq5V4dVhMMYJmbZxlF63/joTEs4IetYqrSIWAwKwZzpv?=
 =?us-ascii?Q?x2Xnvs/ih9/RpWzwA+2rPfdxIKHVUaBZZIaicxkPVEruAdrsAg+9zrcbLoMx?=
 =?us-ascii?Q?1pPTE7P2lU+hyugnHJNA9gXsXjJKQKFv9JD6e07qRBKvKIWypv0F4DoFxY4s?=
 =?us-ascii?Q?svXxDZW7GE3CmO0j4K57zja6Yv/9oZhyVKJr9pYtOR15WcEk0gMD02Vw0lri?=
 =?us-ascii?Q?DlYOPJ3EtLt8D7HD1ekGSvlVKgxUr+HJYyKhPib1PkIoOc+04tJa8aP9zhh1?=
 =?us-ascii?Q?5v3yYN++03iL3yDU4XG997oMmmjfOsMnk8tvHHtyDmt/Vf7b+unbaXF2Z+N0?=
 =?us-ascii?Q?4G8ur22c5LWaaH4IA835ZtgxQ4M13jplurpjS2khRii4cGcOs11zWwxAby1o?=
 =?us-ascii?Q?gHXfZqwod6ombomvMt81o+2F/nH0TMEuDXpkP9nYf6H7KOUYSrsNrj6Iog?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 07:11:13.7285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32adc4eb-3329-4cd4-3c6f-08dddb01c129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

Implement Time-Aware Traffic Scheduling (TAPRIO) offload support
for Cadence MACB/GEM ethernet controllers to enable IEEE 802.1Qbv
compliant time-sensitive networking (TSN) capabilities.

Key features implemented:
- Complete TAPRIO qdisc offload infrastructure with TC_SETUP_QDISC_TAPRIO
- Hardware-accelerated time-based gate control for multiple queues
- Enhanced Scheduled Traffic (ENST) register configuration and management
- Gate state scheduling with configurable start times, on/off intervals
- Support for cycle-time based traffic scheduling with validation
- Hardware capability detection via MACB_CAPS_QBV flag
- Robust error handling and parameter validation
- Queue-specific timing register programming
  (ENST_START_TIME, ENST_ON_TIME, ENST_OFF_TIME)

Changes include:
- Add enst_ns_to_hw_units(): Converts nanoseconds to hardware units
- Add enst_max_hw_interval(): Returns max interval for given speed
- Add macb_taprio_setup_replace() for TAPRIO configuration
- Add macb_taprio_destroy() for cleanup and reset
- Add macb_setup_tc() as TC offload entry point
- Enable NETIF_F_HW_TC feature for QBV-capable hardware
- Add ENST register offsets to queue configuration

The implementation validates timing constraints against hardware limits,
supports per-queue gate mask configuration, and provides comprehensive
logging for debugging and monitoring. Hardware registers are programmed
atomically with proper locking to ensure consistent state.

Tested on Xilinx Versal platforms with QBV-capable MACB controllers.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
v2:
  - Merged patches as per the suggestion
  - Removed GEM_ENST_DISABLE_QUEUE() and GEM_ENST_ENABLE_QUEUE()
  - Renamed queue_enst_config/macb_queue_enst_config,
    reordered elements to reduce padding
  - Moved queue->ENST_* params outside of if (hw_q) block for clarity
  - Cleaned up extra spaces and fixed indentation
  - Removed redundant num_queues check in macb_taprio_setup_replace()
  - leveraged scope_guard as per netdev coding style
  - Eliminated redundant ENST_CONTROL register read for ENST state
  - Used bp->queue_mask to generate ENST control mask
  - Applied standard queue iteration logic in macb_taprio_destroy()
  - Added HW offload support check in macb_taprio_setup()
  - Added runtime state check in macb_taprio_setup()
  - Resolved 32 bit compilation issue and clang errors
  - Fixed CAPS syntax and resolved related clang error
  - Wrapped capability lines to stay within 80-column limit
v1: https://lore.kernel.org/netdev/20250722154111.1871292-1-vineeth.karumanchi@amd.com/
---

Vineeth Karumanchi (2):
  net: macb: Add TAPRIO traffic scheduling support
  net: macb: Add capability-based QBV detection and Versal support

 drivers/net/ethernet/cadence/macb.h      |  67 +++++++
 drivers/net/ethernet/cadence/macb_main.c | 232 ++++++++++++++++++++++-
 2 files changed, 297 insertions(+), 2 deletions(-)

-- 
2.34.1


