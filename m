Return-Path: <netdev+bounces-184421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A52A95577
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABD6188F3C8
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE571E8854;
	Mon, 21 Apr 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0HYqiEc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386411E3790;
	Mon, 21 Apr 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257606; cv=fail; b=PMKGlJ7Uxq3LSLxl3G6GoStfCmjfbfcmK7afS4D0+aN9fVU3J7WXe87SNj8BEADeGAQVW5Dx2fIUarVYJa/0b6vwCY5CkM45N0LPVPljCJ1q3mxWu6/VPl56WRQoh3Wdy7afb7saIV6suetQs9olyRvfLC5CTPAjZFdsl2fQalY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257606; c=relaxed/simple;
	bh=R3WVDnBwUSPqGWh8MYGwqQqc/GP9pASk0e+kZs14mKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ul6Zk/eXU/mUlp93f59qQFui6lPxaM4UEih1uU/HH9Q2+RK1KeicaUm6yRTNMsiN455Ct5Kmbn4sYuPQfUDmI4jiAR7HlfWgtAdAW6RrkNx0P9xnsF8ObHE/IXKy03By8szsnXYahDVUr9OC+W5r59CdRa3ob1c5CYBbPpYiDbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F0HYqiEc; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0dfDM0Sr4+6BD2SjSmg6Ddn23MxQy/vZ7VLBdcbWF9Ek7jk5wdej/S8OYD7ekabBE9hcb0PyRR22ALSM3NfwmiYTjYf5juf62YrM8MJMQbUalRH0/7lkjT3128f4320LPk7gQMmQtoOxi+//P+2m0bVuOVoHR5Ges6iEumdja36jcdr0UXfd+Qq+2WmJDg4aPwQLy3Wo1wiE31Q/VUA8wM0MjryfdW3Y4bxMJLwK0hUtx+tgidLsSSOHQr3M2vp21KZbuuyopXkGveAffomUhz0+PDguoQDr4aXSxJ9KQPBFaxBSqT+RB5sRVdBk3rBfnuQEOOhXxJ95vFvpnDfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA1mQJNzMYFz8NkPNVfV5gESjRpsVI3Uq9dKppNtUrs=;
 b=rjYJj8ULlMd96GAf41nRBkN3qD6GH6aNfmg4WyQjUHbzRAR20doDmjzyzWPENGpkzz0j2uTq5wOvKeD6vO9FV3AdDHR5usH2g2juU0V1krDRdoanc9ah1bEbcK3wFUYtE+mlt88kIKRAupP9SSNvx5R4XzJ0Kk4/asiulhdXZNh2YOuAnVMNJGMC3P4GONXC4uIoGubx2nCf/hi++idnaI+QhaumRI3q4X/2buymL6pMykIcv6c+q8toFJt87OOA1zLc4spAodbBW3cPdjFO63p8FHUxaV2j9c/UPb8Co3Lgf+gQ2QunzSIb45Z5d2ZOmZF116se7nLNzDbotbXYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA1mQJNzMYFz8NkPNVfV5gESjRpsVI3Uq9dKppNtUrs=;
 b=F0HYqiEcVRC83njWvh30qmbUMwqSQte8FRs9roGCxSfsJQ/nVuVyobrZfjsAl2cR4wMIvLrcV8llWdmIGoXUoGL+NKvWzuv4VtBylLlGaW3tmu5pfbX3Ty4xpLL8JbmJr11Tor4i+PtLIn3q1jFFR1ozREy8kqiTDS/IKOCLc8A=
Received: from BYAPR08CA0068.namprd08.prod.outlook.com (2603:10b6:a03:117::45)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 17:46:39 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::26) by BYAPR08CA0068.outlook.office365.com
 (2603:10b6:a03:117::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.32 via Frontend Transport; Mon,
 21 Apr 2025 17:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:46:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 12:46:36 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 net 0/4] pds_core: updates and fixes
Date: Mon, 21 Apr 2025 10:46:02 -0700
Message-ID: <20250421174606.3892-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5c6c07-91f4-41cc-341f-08dd80fc77d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7RhLerKG2inBKTBdi1O41vkXmpyPJO5/39/vKoR7IuhdZLKZUBhcwcj3esY?=
 =?us-ascii?Q?ARsHkSPeKGKT1isPRiF8NheIwSr9fPdnb6yOK9BUWJwAAx6wKgKtLO5Yeu5M?=
 =?us-ascii?Q?2OllItyaYkqewvk5rOG3VevU1yQxVPklG00SkmFdvh7xYrFFj58Zt4aDXeod?=
 =?us-ascii?Q?kzFieJWc00jG+FwGU8TCNQZMiNKElBrekBceMAiRSZBl/xJNY9G59fUGI4N+?=
 =?us-ascii?Q?HJr9jn8qiWsIvqyoiSMuqnTC2biZUPpsF9u12ImqhXy1R8T7aUwRmKpYjdSl?=
 =?us-ascii?Q?3OetCV6EAZ1IYB2i7ExWXScuULT92Bj7Ou5+QR7v3MMtweoL5JjUHz2Vuwe7?=
 =?us-ascii?Q?YBtwzqc7U8QRqSGipa0x2ZKeFGPN4nIEfeaNoQUCYtJsF+d8NIG3d8GaCO0t?=
 =?us-ascii?Q?qSYIHQvt6bWN3TwOrgyZ6OMnSBaWgaaBblpwJ7K6eWMWHJfHMImpJgz+4318?=
 =?us-ascii?Q?/l42kHbDoXDt8RCfeykt+cq7pp7d4wQvxdhiI0hHgiOexeoeAgrEJkSO84QD?=
 =?us-ascii?Q?5TBovTdJnA+7vVo5Y/Drwozzk3To1dgk5w4oHd1VmnC88e9EiuXZsdaGTOae?=
 =?us-ascii?Q?QDgcFqW0osqxoIg+xgRJfleKzopR+Y+SUQfVRAzsgHiwxHRcT1yR+SBJGCbG?=
 =?us-ascii?Q?o5+8SD9A4TTqixvf1W23qfe9li/9sAhuM+HcoPEgFi7gILzNGuLgUe/kFC8z?=
 =?us-ascii?Q?HPFQvHWCmpdcbD44eOzGzPg1dBfreseity4xP97f/HHJ7uwWGe3cPfpnE97E?=
 =?us-ascii?Q?v9a4nk3YOX0Y/xNHoq//FXBCcc3mmSHUBobJEMd7AaIj/ik7scb6C81kiKgy?=
 =?us-ascii?Q?TBk7/peKmeq+DEzHywHoyutWs5RyNZhoIEAXvoMl3KxXN5FbL+jKQXN2YgT0?=
 =?us-ascii?Q?0hUML3aNElNgcuykyC6U9TPt52Jz3Y+5KzUBJ5fTJqbzV4rVtpZDDUjm7CdU?=
 =?us-ascii?Q?o1434cOyHf5Vwj9AWm6ozqlHLfz5Nj9pHBwH6aCyKt0sSSwjUiwMU4vOZkPU?=
 =?us-ascii?Q?4c6jg1CxlS9q4oF4heGQKpeNuqwW+68JPR4PVWvBBH0lGh7lJkz/3n7SpUuY?=
 =?us-ascii?Q?4ULFhMM7ROx7nMyacFCQrytM8gjxFwWN1VlkIQ8hYOnwot/J0vzN6+3vhVbH?=
 =?us-ascii?Q?obASwgaVq2fx8O4vn0mrixEMFeKRFAWXzDTCaNnSom/rtlBuf/lR/VttY0n3?=
 =?us-ascii?Q?fpVNglk0IGpyAKp9kiHve5xpT2MHMVmMeCAultfcNR9HYciClYongoQwBupa?=
 =?us-ascii?Q?5OXqH3f3uLMdK77YYi6StJB9bBHzitUDi/yBOrLvXOyEGPoW2qAk6XyjivlD?=
 =?us-ascii?Q?G3xGh79yyNYjbtchy2kuPx4Tl4IqwBVOS023rtDtiJtznbsEignXFk9+jYpN?=
 =?us-ascii?Q?kHwdsu/E3F8LrAxBJpoLEpj0nnZ3pLuZBA1Omw9qY5cMMv0TmSeD1mnl043a?=
 =?us-ascii?Q?KgU7G467MlRRPhT8diA6HaL6zFaeZqVhRWVVIyVpwWMoHD5MEXBVWg7tsBzf?=
 =?us-ascii?Q?U2orpKgE/BTrCZCylgILGSyxNCnGN3aiP+AUVt1k3N6ttFiUcwdnl8R//sgy?=
 =?us-ascii?Q?yd+QGEoBXsY0gmLsPTk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:46:38.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5c6c07-91f4-41cc-341f-08dd80fc77d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

This patchset has fixes for issues seen in recent internal testing
of error conditions and stress handling.

Note that the first patch in this series is a leftover from an
earlier patchset that was abandoned:
Link: https://lore.kernel.org/netdev/20250129004337.36898-2-shannon.nelson@amd.com/

v4:
 - use init/reinit_completion() rather than COMPLETION_INITIALIZER_ONSTACK()
 - use completion_done() to protect from completing timed-out requests

v3:
https://lore.kernel.org/netdev/20250415232931.59693-1-shannon.nelson@amd.com/
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

 drivers/net/ethernet/amd/pds_core/adminq.c  | 36 ++++++++-------------
 drivers/net/ethernet/amd/pds_core/auxbus.c  |  3 --
 drivers/net/ethernet/amd/pds_core/core.c    |  9 +++---
 drivers/net/ethernet/amd/pds_core/core.h    |  4 +--
 drivers/net/ethernet/amd/pds_core/devlink.c |  4 +--
 5 files changed, 21 insertions(+), 35 deletions(-)

-- 
2.17.1


