Return-Path: <netdev+bounces-104691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FD90E0E8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931811C21E30
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5117EF;
	Wed, 19 Jun 2024 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nl01NDVK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF3ED8
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757209; cv=fail; b=UiwW38clQNadvE8OZB0lICnOacQmklpKAf9OIf0oFoqk0picL7J78GbxYr4qz4C1DV/vstq0N9VGJuP+ou/O8kbWazJfa1uztte8dtWOuwurvfKRLbfR92NDXOlqSbUiWLjiVnHL+82jlfdq+/7epidPMSh4DO0s4u/tYixjBfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757209; c=relaxed/simple;
	bh=Y+fljTwByu1fJ0we1vX/HYE5F1cg3+dmqhimDN1QIl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RVDFh6mmuDEFStRkJ0WSB1E8rNzBkks+P2WHrHzwsJPLJdg3qz7X4AgVA+dcizS3D5209Rqq7ZtR+rrDlAs7C628J/T/NmdXhmGA1pSfetSH9TeGqcms5GmTHoVRWawcwG5uulm2fRK01W/flELFJglSZyPc/RV4vbdtp5gYK2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nl01NDVK; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmkKQ6MLqXU1PJQkj1EuA4weGbjp8Vt3DGuYWub1ewtOyOA0J30tsj7NspR0C/G1JkD+gLTDp4vKk2Z2/HP9ENzOMAJUxvMPBNXorm3njh5TqWizPepgvIZu0lD+AXUOp6vGwjttT6+G7HhXgN3JUqjPqNFEWUetiYXm+a0KABFwaij3JlBo+djOxrvq3fO3jo6Ju3wO9DWbKQfoJu96FBZ3pWzBrp4auJ3uPqR1/VqYqF05ZVe7Jpxmqoi2YEnCk3hwAFb1oRKeo6tLFzvc0aR2nQc2zDF1aUZ9OzoowZOuj8hu0YdCKaYJbkiBPg+ICgXLGgQqWVTl5EtpEN5TkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf66m4y5QCaRCxG0HgIfOw1J2yj9g17S43TBfE4+gUs=;
 b=fQDYemWg5kPM139Sgvrkc+6zB7KPuVm0CzBRsbnI2qZRjPhlOgF07U512qHHY2JtB/PS5CIvUTECPLzDVJeACvNYuUbsjsEnyP2QV7KYIBluTOOmeOK5ndCsfzDrskFGVz1w6zvMxLZl4fRKbAYvyfdCfSoE8xF4YCf2Ar7Fl7S/6xbJkU8eAx+nS68K7mxwfS/mzgbTWeaP01tDr8K5xtknhAN7XpZCEQxQA4AhZcX/TtbuvKGovM1zWZWtbbujV2mIa71o2k/uImf3r3/FtIwV09acnAw/cwaMruJtGRLYy3jrXuwRH3BOBHTlTohAC5ORlCy5iG3F/jz8mfcoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf66m4y5QCaRCxG0HgIfOw1J2yj9g17S43TBfE4+gUs=;
 b=nl01NDVK/ojgN5FUUVQfi1BjFKAAB0972rRMJDxqV3BvvbWeoKwUfYKdaPODSN9PH9aNjTrlCV/xEtC9962x0RAN8Z50zQ7MudDql686NOLZ15ZImwwQdEzt3PuOuccYrsNRNJi0wia2F73moXY73LbsAYN2IlbE1VerjAfBvQk=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 00:33:25 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::ed) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:24 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:23 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 0/8] ionic: rework fix for doorbell miss
Date: Tue, 18 Jun 2024 17:32:49 -0700
Message-ID: <20240619003257.6138-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a43729-6a89-43ea-6023-08dc8ff76e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kX3LTJgJajgitAy4FbmM0bX1MaHV+dncHBurYeKSSysses21FG0f7QEvuw+6?=
 =?us-ascii?Q?yl0X3BDfxTFnxLe/C0OOK4pILSVQ+wx6BENUv9dhE4gG3qCVycshF0XeSKI/?=
 =?us-ascii?Q?WE02VkJq4fmiMmOf8fZP2IOWDXOGUf7TEHotCG35/OMn6UzKYEw+z5qW6lbZ?=
 =?us-ascii?Q?VMHbj3omz/3MFLt8/x5wnV/1wmgBlhtD0LjIry21SC6aXNwgHc1a88Bl3ETZ?=
 =?us-ascii?Q?hzh0YSbzf1hIN7agEfsY4Gayofk5pl5QPSsQ+7C90kwy+yazIq9cyFClLtML?=
 =?us-ascii?Q?GzNoTxUbHh4W5e+bXJfdrpH7b4wf4z+aj6eJILJGQsKYbs255xM9exdyY8YU?=
 =?us-ascii?Q?x19zApAYUcKRXf3RjF/eYgqI68pFrURTR6m7J/v0mKnX7jmuMX9Z9MUGNAvv?=
 =?us-ascii?Q?jlKEj5TVklkNZtHBztQ5zrl/sZWAp1wOomWIZQffDJN+hC3uMxalXiKH8Zww?=
 =?us-ascii?Q?kJy4FovZLj/BZKhZMV8e3dCRqdp8PfAGx3zUVj/BBFCs9FaY9/G5eX+C9W3p?=
 =?us-ascii?Q?AUe2aq4aXwumE8L5xioX4KR2JhCMV1ETK/wOhZZKjGErmjb7L/55xGE0KVVq?=
 =?us-ascii?Q?50VpJkGlt8dGJUw3SBHiKOdFvnWlgyWkVLO9OTV3bmrZ60Zu64FHEPQGI35J?=
 =?us-ascii?Q?kaMM7Vyiwn2okxns8pXGshyD/btjOlBiLsEOlhrWDIPnNEZjHSOS9VODxKci?=
 =?us-ascii?Q?QGzvJfrs6uWCrmwyI991JBsgIbJz2WYjwIPYgBleQYjYr1QHuX1zdy/+78Pe?=
 =?us-ascii?Q?iMJKpMutrvcGoA6OUwlK2EUebLfCk+ZOYvb518LsuTVGNVIixA1sunk5ekg1?=
 =?us-ascii?Q?ftQ2Z9T0mJWa2G2Avf/LThF+NpX0KMZU7MEgC/RC3etfQQrzhyWsLJ6HGBH0?=
 =?us-ascii?Q?0Opagzy61Y2I+oU2ML/Mp1P+uwNuRkKhcypC/QSr7dSvTenqTVMQI9qNFpYA?=
 =?us-ascii?Q?H69ssptoYt15wvHXrN6/wIZ5JTc1yIYqT5VaCUanHzvlhf757vlJHsN/Gzy2?=
 =?us-ascii?Q?8O8eTYMedKSreeywKHTRFD8Pjr0PlGFP75ix9gmp/+eOVWHIQnymctkjP8hu?=
 =?us-ascii?Q?e3vs7ukn9anzUyK5rmmB23/sPu4+B/czcsQ9fckluMHNamB3f1FgFZ7SrnpG?=
 =?us-ascii?Q?vNKJ4a19dtq36MbpJHClipr7fgzsoiTRwaCP/bM17twYATGMSjl6KfGZjVWs?=
 =?us-ascii?Q?/bOnX4yqkiwFgAWArwnM70tVGXeohyFBiIX+Aea4Xu0x4EEVcES8/ydy2bHK?=
 =?us-ascii?Q?CUhYKHo9mJO2NJN01TVoEc8BqpWcBpgyPv7+zc/YAy9kOtajXnNtxHhfjoS4?=
 =?us-ascii?Q?AKbt9DkmERM99FHHOzt4yg2qz/94UFwW0whtoh07O0DoLDs/GArqOdyGRlUG?=
 =?us-ascii?Q?JQ0R4WA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:24.8015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a43729-6a89-43ea-6023-08dc8ff76e3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744

A latency test in a scaled out setting (many VMs with many queues)
has uncovered an issue with our missed doorbell fix from
commit b69585bfcece ("ionic: missed doorbell workaround")

As a refresher, the Elba ASIC has an issue where once in a blue
moon it might miss/drop a queue doorbell notification from
the driver.  This can result in Tx timeouts and potential Rx
buffer misses.

The basic problem with the original solution is that
we're delaying things with a timer for every single queue,
periodically using mod_timer() to reset to reset the alarm, and
mod_timer() becomes a more and more expensive thing as there
are more and more VFs and queues each with their own timer.
A ping-pong latency test tends to exacerbate the effect such
that every napi is doing a mod_timer() in every cycle.

An alternative has been worked out to replace this using
periodic workqueue items outside the napi cycle to request a
napi_schedule driven by a single delayed-workqueue per device
rather than a timer for every queue.  Also, now that newer
firmware is actually reporting its ASIC type, we can restrict
this to the appropriate chip.

The testing scenario used 128 VFs in UP state, 16 queues per
VF, and latency tests were done using TCP_RR with adaptive
interrupt coalescing enabled, running on 1 VF.  We would see
99th percentile latencies of up to 900us range, with some max
fliers as much as 4ms.

With these fixes the 99th percentile latencies are typically well
under 50us with the occasional max under 500us.

v2:
  - 3/8: add commentary for why have a private work queue (Jakub)
  - 4/8: no open-code of napi_schedule() (Jakub)
  - 4/8: watch for deadlock with cancel_delayed_work_sync() (Jakub)
  - 7/8: better ionic_lif field order after reducing rx_copybreak size (David)
  - 7/8: include some pahole diff info (Andrew)
  - 8/8: use bool not bitflag for doorbell_wa (David)

v1:
https://lore.kernel.org/netdev/20240610230706.34883-1-shannon.nelson@amd.com/

Brett Creeley (3):
  ionic: Keep interrupt affinity up to date
  ionic: Use an u16 for rx_copybreak
  ionic: Only run the doorbell workaround for certain asic_type

Shannon Nelson (5):
  ionic: remove missed doorbell per-queue timer
  ionic: add private workqueue per-device
  ionic: add work item for missed-doorbell check
  ionic: add per-queue napi_schedule for doorbell check
  ionic: check for queue deadline in doorbell_napi_work

 drivers/net/ethernet/pensando/ionic/ionic.h   |   7 +
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |   3 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 129 +++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   8 +-
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  11 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 144 ++++++++++++------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  12 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  |   2 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  24 ++-
 9 files changed, 264 insertions(+), 76 deletions(-)

-- 
2.17.1


