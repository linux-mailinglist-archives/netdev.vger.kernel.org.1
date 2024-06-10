Return-Path: <netdev+bounces-102386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388EB902C31
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60AD1F22E3B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DA152161;
	Mon, 10 Jun 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xwjYJTAz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9441514C6
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060854; cv=fail; b=Nh4jsI+6L9lGkOXxFje0rH8Tyaj86Fr4DqmsU2wJk1+mtkXB6+k5xQv71qavhyTkQf+tiHfLX4+edHdTnf23KJK99JL3proYSNvDCQ9l3XcCCoKv6gTbzWuQROJQe2aCj9B5LHKcZ7jwXWCd6+VSMg3F49yuWnPkFWrRufz7A7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060854; c=relaxed/simple;
	bh=HZjdImqtamQrkJWYKbbno01bBTayJ+KNIatTxJUp9aE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NbAMdfygbR7e7p3TSfsSvCCaWgKoNWrGiJbSVnRMp803bR3V5MN/M41vICpX462a0NQANnoDi1DN7c+o4PdLTxLH/kqsZnIj2QYx/NFI1I6DrMMOPvT3MwXB6QX1NZr1GoGlWhapycSjnnRPOp91kNYtAjV+Rx7qhcoaUkbrEEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xwjYJTAz; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIxjzhZ/7crXF62yKUEcSPiaehpoFNM0CmsHwMgGAnU9qB/XNCX46tjjddY8D7wfgfnPsPwE00Roxi9KNMtfSx7+2TvK09ZZlJsxxjPdl+mHypXTRalgyGNu7vMXUtYwwONe+Dsd8AOUFJr9MWSrSQhL9dB4kHrRayY5egg7sOXhgKECpdntBnTP2JVKtQA0lRDo1wL7xinMtReesRiLQMEUhK5hCUM03MG9EBsPd1EKDFbAbCukuaFSKrdzsJWNcz83jUfpATDQU862GG3y+AiEfapKL2RQmzvrQZf6ulGXJWbk7BwJ/WBYWJa3DGfpA95BHLbXqMkS4xL2W8IApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REMCIoKfW2pwEfteFwPujr0CMsSC8BEqm3qmn6e1Bek=;
 b=ezm0Hzizw3ZWcfWO7uqdzDp55+QvTHXeb1wWK9x2qAFFunk0CfWAcsC6SsosKPsG63bovfaC4LENpCYm0UhgpUI74hzBaisQjuAEw+vFCu4WrsHyPFcK1t0EgV13mHNTUETOWk4htjDH3jRbR2bO94HR26l4xyXg6efIPAuj0gyBYpFphE4bHE7fG8NrJQ5A7b879D3dgJQmQ06XUVDsRmbe+la5u/osvqi+BTWS62fiCTWmRv+WAfvgQc6IdXg0Ir7deP0NJcLTbl7MatmmKtIKdkpxYeAcxX4lbWQEjFP68Rtp5BvelwnvlfY/NcQnXtLlTyYhG7mHnroVXwlKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REMCIoKfW2pwEfteFwPujr0CMsSC8BEqm3qmn6e1Bek=;
 b=xwjYJTAzfkpz7J1CB6hFuxsSyJMd4VsGHg8Nz+eFz2q8CKD0Yii9+WS+qTI+v+Km1yEBi7rj83h5Mdez3I3Sd96GuXMt/TN+hAQ3hV/dDm6qrKdeebQJkuobtVuP/a/tZiW/ZxFviO4DGmazkhV9CBLV4mFYEi9JuFz+pW7I5xQ=
Received: from DM6PR11CA0018.namprd11.prod.outlook.com (2603:10b6:5:190::31)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:29 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::ba) by DM6PR11CA0018.outlook.office365.com
 (2603:10b6:5:190::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:27 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 0/8] ionic: rework fix for doorbell miss
Date: Mon, 10 Jun 2024 16:06:58 -0700
Message-ID: <20240610230706.34883-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 696f4a02-5688-4316-734e-08dc89a219bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2+naZ0q5rGabJZIjT9HeyaL3qTCQGbl1gCPfIXtmm0BaJd9pDHJgLg+ZlTIR?=
 =?us-ascii?Q?W0dvj1yQksauQxMyFSXcKz4xbGp7YWgmy2ftoKv0jWiCkpbuLYLoLMiLjB8k?=
 =?us-ascii?Q?Sh/+OWuzvKT/N2mDTwSh1EM2Fca4kd/zg2RkIxK7uSFAhjnD4Qr06Udu2zen?=
 =?us-ascii?Q?v33nTsBvRkUXnOFn3UFruB46/5tvcvPphWPHifxR7K+ga4T8YDMJEc/mHpU6?=
 =?us-ascii?Q?yfG1S1ggUMpukj6+ADovro2pd9jfGPh/HN8jizwbmXj8ZSq6fd2wn6dAw98v?=
 =?us-ascii?Q?hzZsfGntDR1vrIQ8Bk5ffZ/AnOKbi6TvRuyVuUsJ8qFNZokd0QC2oXw5/o/L?=
 =?us-ascii?Q?dTVU76yCHZbNx+9RJWSfkuVORzEn1pRuS3gSGB+N2CzdJrK8CgYa/CkmmrSf?=
 =?us-ascii?Q?imf5EVts757wa432J9EQKT6K+rfc5Pzw5gnLkG2j+AZ07Ri4R/t5T6acIZ//?=
 =?us-ascii?Q?tPW5/TpTC27RGAoX/e/M5/6ArIzciduYvvRybOT2bytcGDbAV+LDvkUIZ4IN?=
 =?us-ascii?Q?RDMVZfelKk5ru3sZn8FuFPNDj1x92sHs3assj45LWjeqil9Q7t1tE1p8J9Me?=
 =?us-ascii?Q?aOExRrDc46F/fo374MwOXgh6p72xMLjiv6UdQN5aEsTXIEJESs94LkbFUMw7?=
 =?us-ascii?Q?7BbXW+UnNVIPUITKZ+j4ra1Xz4RpF4sTIZ/H/UIjsrx+VAclIQxuHCJUCnDk?=
 =?us-ascii?Q?1/usSb4xCsYCuLkOR9YjfyQ90bphQJ+K+i8LRYUdapvua//mVpZtWQ9WnKPT?=
 =?us-ascii?Q?HrOOfwlHuHUdz1fGNwFfkPHPvLQ0SvL4eMpojuT9fM+YMf77RJrD9NyurQxV?=
 =?us-ascii?Q?0IuaIpR39X2m7KplAMnYeACa2P9HJRWpKJvtTzN48MY5inAEgLV+ZzD13iku?=
 =?us-ascii?Q?x45fxcCPGbi5K5zEX7nuVax+7o1dOJjLCfIVrdRihFZad9gkVtZFTbWMPkbv?=
 =?us-ascii?Q?wjI8UJskeKvwwOBJh4ACzTjU8vVxfkiQnDq1gNlaSzhxzcsiw/HdnfkvRfBs?=
 =?us-ascii?Q?1wFwOMgsVHILXDfJGKmQ3HINpFnTm8+lGvTq8GCaBXrbSaay4iO+/XogSvra?=
 =?us-ascii?Q?2dYwmmTMXSqntSG1grY9itR/duM/+s8n5TkoNZsM1CqzG8g3P56noVu9Jwza?=
 =?us-ascii?Q?TnR4uaHEoOacE9EpV/0m4mzOq1ZS3hMNM33tQQS/xfg+SuUXVUkDIdZk0g4d?=
 =?us-ascii?Q?edUqYuP+YlXIlMr11hK5b3mY1dHiw5nm0t7vrgtr8Rx5CYCdqxvdl+bWflSc?=
 =?us-ascii?Q?Y6fBeTNbiv+4j9yHLjoMs2eT0sRfB1DclTULcyzEDUncl+5qXcQQIy6wssXm?=
 =?us-ascii?Q?KE6UDQxxjtMHRuSudA0NtYXfXLyYcxk8xRLjzQ+wcL5K3ueGnvCO1iu9VTA+?=
 =?us-ascii?Q?DSsku2S9cfEeEzmL3GvZFPgFr9WM3M/SUvc8wiDhDhO7Cy20ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:28.8227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696f4a02-5688-4316-734e-08dc89a219bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

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
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |   1 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 128 ++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   8 +-
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  10 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 146 ++++++++++++------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   8 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  |   2 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  24 ++-
 9 files changed, 260 insertions(+), 74 deletions(-)

-- 
2.17.1


