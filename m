Return-Path: <netdev+bounces-222010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FAB529EC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372CA1C265E9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486C2741C6;
	Thu, 11 Sep 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i2BTNQNq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A127467B;
	Thu, 11 Sep 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575717; cv=fail; b=BRSE+DlG6PBzwz0wfTf7qo/bePjed+Tf8N4MR86NQav02kGrAT9PElTDjrWVmgs9nqzJK764FSfpJ/3InC0Q53wkNASsndOIcCEY7XWhheeUw6etG5f0eZ1hSkUFfOZxetjadUqreV1znQFG9DW0G2hUOhewqJpYHzOkSlEYEQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575717; c=relaxed/simple;
	bh=JOtDIo4jVwkuRkQNSx+seuu/sRSVaWbHm44YQuSAHQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+mf/6DA2fKo1usqma24as8nLQJdf7wsDRZhbD148EbQFTsY1UvKhZbAvv+SLqYes78HfOtZPjAICvcqtF/1Oza48No3s9KQgh79C5eeSscS42lSuB3rM1LKlYtNqHDSccGVJXQ7fnDIhe6l6x2E2JRb7RNCVLK+vBiI2ObXkyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i2BTNQNq; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7HUTdq7KwIqxqKjlvwXsMHNwRj4JDU1md6X5eNcQqoHYs3WAuCCyHCk063Yt3AtOQCUYu4PU68U6GOXCss7X/QfA2H3sZrxbwlgJq7+wQt5JRFqgl8htAZciIk5lAR6YRjlSHm8EowUkIefuIt1pkHJBDSebWc0rrT+dGItWiDlrH+surELvgU7s93IX30ZUKuEhDSVAmrpAxPIMloVollvA2yjsEHLIQecu9NArubzVyV5h9jfW6TZbKIQKREFq6ffdkInwSmy5G8hCsLAbKqsMHK8PicQV2nVHWltKbZB5I+5W+Y/RttEb2wofcMhvNIyCTHLvY7Wuit219Ggmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DN51fWwkZ0BzktN8t0oKatmLADdpIg1n5KeuTj1rmo=;
 b=GSC/B66ct+zi3Zp5bpP7bQ/rLffpYFtzvf12e5sd77ePdV15kzNcIa11hUzm1QmHI/lhZx+y/Hl3cUPo2t8ui3rJvdSMNluWbWMHq9XgElO+tUBgP5XB+cSkeEpew+NpTDLQTolvrpmkC4hcjg5yUMCMgFjlx9GJtTsRN4oAupGCnPczgrK9/XfkGRMinS802xjrZ/0aynwcXrOPbz5JHqJfF3KQwWhkpspsywL40Sj9DYDYyewnpd/fvm6VkzHbdzhh3uJyu1wtqTEUxOsL/FwWXxthk/8LHO7u9z+A7Gcd55zGbEhY/oIQum7wS3SjI9xyr8HC9oCAgUbq9vvHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DN51fWwkZ0BzktN8t0oKatmLADdpIg1n5KeuTj1rmo=;
 b=i2BTNQNqXQpVk5qGW7JmiSFn7HkH5msioErGVoDcXpjlYIWYd4V0jYTXEZyuO82RnI/o8kyztmPzoi9KG6DQRMgs9spZEPsRfCsLDH3M6XVgSrNpzJkHhRX19xUvEleP9YQktzxGJahyPEK9gv34S63ku6kHWoHIfoYtVLZ1dt8=
Received: from DM6PR04CA0023.namprd04.prod.outlook.com (2603:10b6:5:334::28)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:28:31 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::14) by DM6PR04CA0023.outlook.office365.com
 (2603:10b6:5:334::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 07:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:28:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 11 Sep
 2025 00:28:30 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Sep
 2025 02:28:29 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 00:28:25 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net-next 2/2] net: xilinx: axienet: Add inline comment for stats_lock mutex definition
Date: Thu, 11 Sep 2025 12:58:15 +0530
Message-ID: <20250911072815.3119843-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250911072815.3119843-1-suraj.gupta2@amd.com>
References: <20250911072815.3119843-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dcefda-9731-4675-050c-08ddf104cec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+M4yv1Mj+BU0Lnf4yR/ROsa0k3PXuRgaAd6kkMkDuF7W4zwNGiUkS8RS5lvt?=
 =?us-ascii?Q?5y81OM6LoTQ0hGIfmT9NDUQU05Km/y+IyvKKyIDVsgtLYHnEoprqHB6SryIb?=
 =?us-ascii?Q?EySse0xbnR7F3+VL1wPpPKZo0ekGkNoGP+Ic18QGC9rCLR4bv6GbIw1g8mlU?=
 =?us-ascii?Q?qXGXrxvjXfthxppqh4y+eBe+YNkzhFtWNg4S92Y0TS+C4Yn2Ji50j2PFu5m+?=
 =?us-ascii?Q?N9tEkTfpttbofFpo/+bJ/31pV4Yz5cLkdzQwejuqZpFS9lKih+XFBf1FP83t?=
 =?us-ascii?Q?lFzu4GBLfzBq4oyzOlZzUuacz4RFZKhtwcwYXQ3IwcyNeo2g62QuiNhtfEYf?=
 =?us-ascii?Q?3Z+DAT1fyS8PgcOh1VwtFsjmmaTDO5efRf7s/QLSsHczaINkzAqC5yTCwjGQ?=
 =?us-ascii?Q?F4YCF7Jq1wnzyzRzFpMKoZOtF8lJkXe4S4x+2Vf8YBHF8Uj3KRHrfZ/272r0?=
 =?us-ascii?Q?BPPZUNjP8/LqLIg7/1mfbi31HtbDGVabOLpd0IxEFcSQL0NTCTVwcGL0jKqg?=
 =?us-ascii?Q?4wumDmWgtgncrvJeBbdA0dcLO2N3A6XI7iUiTCL8WEnPfZySKkxzsAxaol/M?=
 =?us-ascii?Q?EtPQConV37UP8Z0pMbpnV+PPJ5GiQyAneLDshwCVnGC0VdGyuoO/0fWREx4A?=
 =?us-ascii?Q?ps+1gAgjm5O316MXyIPeLs8eIF1mFohaqaPyE2E74/LM0BXwhGW0/Za5B5ae?=
 =?us-ascii?Q?5FnNfyBrqFkRhg5XaByqBNCeiB2sD76Y54hORq+iajMBBFyLc555AKQbr9K0?=
 =?us-ascii?Q?BZ/cFHPYYSqLRyEAt5wjRYOcOiAvio7Ei4bVwD2iHS4MXJiE7C7/SS+bD1Uk?=
 =?us-ascii?Q?7GwAFwUydw65gO0vHRoDYc6veZDomabtZMqIeADsat74BI5adJAP7vz2dFse?=
 =?us-ascii?Q?AW9bnaKGT0JF7op0ztz/mY8tRVaRdGntY1pCEjMOhkhMrY+HexKGGePurK62?=
 =?us-ascii?Q?o9Z8n5Yvy39Pm2OBok08d472LIE5ANT0FOq5+XPKpg+4l9Hjm53EN3rKoeLF?=
 =?us-ascii?Q?Fb+Xw7ILZJzvX7dBB6frelMKMoxlly4bSN+Ked39yjlX1VAvVHlUuPOHpP8E?=
 =?us-ascii?Q?Yif3oEOEDzRZqvc9RTA8iVqc98d6nHn6F4mJ1i6GtNNUp7Dcjs9lIxsFmN+q?=
 =?us-ascii?Q?axfsS3EO1LnRprjiJUFk5QzlI0sIE9T7sws8isNqicib2/O4ifULCBwhY543?=
 =?us-ascii?Q?G/wfeFdFtL+crxuXglNA5ke4FS5MECeCpGlZtVXfGr+6wHqQxb65vBKGrYJg?=
 =?us-ascii?Q?QXnolJwej6ESTedI89Fj0FxXMSSmj3HPquGkryFr2aA2/zaUm/pN3qW5t4mR?=
 =?us-ascii?Q?zySMi2LJYCMihD8Eds0qYOQGCjI7hyvqv3Y0eI4m0/CryybDb1FO/7HjkUbx?=
 =?us-ascii?Q?EgFGj+7UsfftW4xXqAJt4zyi+7aSkdHg1WzNuYbmdI2rKsQj1GZh4Y/GjbK0?=
 =?us-ascii?Q?Q934ImKcKGeBnRIJywsjchAgXy/adYrgCBOoiAHR68jGBZei4FJsbKac/7jZ?=
 =?us-ascii?Q?05GsjaLA8ikxN7hQhu6yWYCkrvr/drxA0s+K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:28:30.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dcefda-9731-4675-050c-08ddf104cec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

Add inline comment to document the purpose of the stats_lock mutex in
the axienet_local structure. This mutex protects the hw_stats_seqcount
sequence counter used for hardware statistics synchronization.

Fixes checkpatch warning:
CHECK: struct mutex definition without comment

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5ff742103beb..99b9c27bbd60 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -598,7 +598,7 @@ struct axienet_local {
 
 	u64 hw_stat_base[STAT_COUNT];
 	u32 hw_last_counter[STAT_COUNT];
-	seqcount_mutex_t hw_stats_seqcount;
+	seqcount_mutex_t hw_stats_seqcount; /* Lock for hardware statistics */
 	struct mutex stats_lock;
 	struct delayed_work stats_work;
 	bool reset_in_progress;
-- 
2.25.1


