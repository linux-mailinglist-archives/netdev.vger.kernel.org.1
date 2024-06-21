Return-Path: <netdev+bounces-105534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B79119D9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32CF1C213B5
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288C12D1EB;
	Fri, 21 Jun 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JX46NLHk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803CEA4;
	Fri, 21 Jun 2024 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945869; cv=fail; b=Ol5uIU1vKavhy93ts07iELg8rCJRpS5e+fly1O3VGCy9/dUCUN6O0OoOI1DZ4KNGZy6Mhxhk2+H+4RK+C4Zq5sePP5P8lpeGQfAbypob8vf9zrr6dUQlHxHn1AgnhLXw5SDyuMJu6cERLnh3GPRkIyWLIsqKSwVgNQjaBRhwSRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945869; c=relaxed/simple;
	bh=1rW0NQIPlnhrNMgVe5psvTjJUzgIiPbxqgAroMC3Rv0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s+Q5lTVbvjjKuSXYs0KoKUj0gitbQrIa+gkHlMw8JlPdmOBiX75p5pd7ieUXMtb7/irF1vwq3Ef30YgqjyLiM0N3HU66ufor7UDJYa/mFnrurQtXa9njYv/THo2ti2kOPm5dPnKmJR932K8mpWKBfeDXaKcDqzCvV3PDsWuBpVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JX46NLHk; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kcd+LHGl3o23BGGmin2BZjky/frfG4ep5v5ffaJaBVYiZ4y1buQXOJ8EEY26mZA8+ugRQSsFGRniRQhzOsjdMGZ2PV/hnx2Rnbb9/FZZ023jeIcFs35qgHpXphynKutgtMfhVpKyVsGiNqAvuIuiao4ZUlJlR1pn0rM8EUzy7y4VHlMgNbVLk2dRfsWZj8GP/IFzm6LTtWyQmYNp9zPSbCW6wdKOCiEOLmbaq343c7Qtvp5V/6mioD2m86Aa00SD7jCC3ynGSAge0jpX1zdWApGqEdFKt/rTUith0zhz70y/0vFIB8/FEHpfd7qz+75ZTTTRKEq8O4UUA8iCquQU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JQe7GkGGdNGHjO8VwLZlIC1PtkwbAy1ivUb1RUlCOE=;
 b=NYXFBwvFOVpiRmzOPtucQcf3r/xCpjMMuD8q5mUeBJnyVvRjVYnyqBRAcSgy31gGpOUHERVBCHH0yxgCdvvKCgfls9QbFqWcZMbvu5prFhIR4yztK+Mqvea6ZITY+gp0sXY8Ndqm2NsUDbsN2R+SYo11VCTFHXDPXhXvci+YNU5D3+gdo3AoFv7SdTJBb05dfNYFiqYETklMuQv0FSWX8ljeBUYBPCvngBzA30gHCle5kb9fXSY3yJcYi02p/Afo36rGi4M/bbVGSgXiNiv63zohS33duJnwf/vrdofF+88aD7ugOBmyhk5iZzJ38jFYwZrVsVtBzhd5lGLY5MAMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JQe7GkGGdNGHjO8VwLZlIC1PtkwbAy1ivUb1RUlCOE=;
 b=JX46NLHkAYSxt8h5bAUinFbZaD6dihqMtXYtaZqw/bk3Je8EWVQ6BhI30dnFXoCw0/Zr2GAcMbzkiXp995Gsv550SuEIWjJi07ZuyxaHGf66KHCxYW1+7+guzUEa1NUn8vlb5xyI5j6FqNMYUYw/9YKQ7VCB1NCRSRME2xpsp8c=
Received: from MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 04:57:42 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::13) by MN2PR05CA0053.outlook.office365.com
 (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 04:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 04:57:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:57:40 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 23:57:36 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v7 0/4] net: macb: WOL enhancements
Date: Fri, 21 Jun 2024 10:27:31 +0530
Message-ID: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: b4244be6-90d5-4c46-9d28-08dc91aeae8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|7416011|376011|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbD9Q7wWn3zomJcOaLkyxkGBjRVLPmnmd8IflGTUU0KD2O1bp6pfWMNX66JQ?=
 =?us-ascii?Q?8yt9BIJuE2T6DQG1GXcunSdyvP1IXqm86oPV2jXModcTMXNW6TivCzS+8Gry?=
 =?us-ascii?Q?8l9sXFv9/5gMyYmPLtkqFUXp+vQ2KyHtXeSrCieSak5ka+c2gjv2IyJOx2u3?=
 =?us-ascii?Q?I4Nzg533JkNAgZpBXtbrHu05UNE3d7g24qh0SXWo50DMS0zDy+i4eX1RijTv?=
 =?us-ascii?Q?dwb9RLgukuAvU2hxHzCx3zUhe7ElBtfQrIOavJISj4tK0AG1BH7bWnVkX3Gz?=
 =?us-ascii?Q?WUh5DA+yh5ryu/O4AikcZMfDGKVxtFAIlT8rdNcHkeHjPdi7S72kKVcoz37u?=
 =?us-ascii?Q?hXtdTNVix0FivtTKSbXrtwifD7ntYg3al2Um+VyWARA/7Tvf+tqUgfiApfxU?=
 =?us-ascii?Q?taPvojSIRG9xoNCIqIYW2+ZlNLLCqpUm3iFsVfqjL7HaPaJzuzMvyhEcanms?=
 =?us-ascii?Q?jNaUyvpak0mhL+ihFKFBXdfXjyFpBWOd/+wEsKYAPC6bMJQjk579iYqvlSLQ?=
 =?us-ascii?Q?kshTLgAG8qA3Y3s/u27YMlbmM9h+l/lK/bOp9MdsiqqV3CiKpTcFyo9DsQtj?=
 =?us-ascii?Q?LRZonGB7nJFOVR0/hpbLebSEZ0S8B4gZoCDhmUJLIL++9RbrVseS7DQfG44F?=
 =?us-ascii?Q?ZdTDRLIbsLSIhEu8QL1qlnDQPW9Thvl75qwJFLRHW5jlWnv4GK7y0o6jzHY2?=
 =?us-ascii?Q?uxYNfHlThkUg05gAakLEE3R6HXWvZPujz/yXyF6JGs30Vfr/7DJ6E1w1TPNV?=
 =?us-ascii?Q?RAiW4W4AbQT19/kRvJFwpdx7zRacLjYhEAdOw+Us9MjYVT/tvEak7/w2LREM?=
 =?us-ascii?Q?C7AhuXiAxShyVbYq0Kz+QacCRL/kS1zegMm2L+wfS4C5Wp+SAIN7F0o9cOsQ?=
 =?us-ascii?Q?dEmWkKv2BFyY7/NRwlD24DD52l1i0NHIDbUAdECzxR6S8rOMVnzaaASOhUpz?=
 =?us-ascii?Q?M3r32vkJeRHrdwFghY/UOagK1MYrMY9GiB0/bRqRMlHtR13oca55s2ifaHDt?=
 =?us-ascii?Q?qF3NvYlOmr1dKTrZ3WFeeYQRWYa2whlATi7N1zPo65BupHRI+nXPJksHa8pL?=
 =?us-ascii?Q?c80hKxwLt7KZ7knlFQS9yveqj4pjjFMMfKOOab1w+s3M/K8x8AOJxJcl2klT?=
 =?us-ascii?Q?kScqqq9w96VPfo0Nh7nh//0W6fjbYcDdosWXbaf4Auqy4c7+5NprSCExPpUe?=
 =?us-ascii?Q?7OEFqLlD4OrGACxzqQLPxdev9WY0RGPWjO9lrsRyD7SCa6IQxoQ3/mRdVzTE?=
 =?us-ascii?Q?zHAhaSWgURlFGSMBnRi23b8Rq9MoXIjfrvlnnbiy2Vq9IxOZKcwzmLX7UMlw?=
 =?us-ascii?Q?qGvLwWgEiHdLsFyo5/dv5HAMr/zaJ2yCn3R1uAQMbAmSoCXXFSLru7Y7HMxT?=
 =?us-ascii?Q?li+f9FA2Am5bpYW1cq3o7JuZz5Ir?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(7416011)(376011)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 04:57:41.7865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4244be6-90d5-4c46-9d28-08dc91aeae8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345

- Add provisioning for queue tie-off and queue disable during suspend.
- Add support for ARP packet types to WoL.
- Advertise WoL attributes by default.
- Extend MACB supported WoL modes to the PHY supported WoL modes.
- Deprecate magic-packet property.

Changes in V7:
- change cpu_to_be32p() to be32_to_cpu(), eliminating unneeded conversions.

Changes in V6:
- Use rcu_access_pointer() instead of rcu_dereference()
- Add conditional check on __in_dev_get_rcu() return pointer
v6 link : https://lore.kernel.org/netdev/20240617070413.2291511-1-vineeth.karumanchi@amd.com/

Changes in V5:
- Update comment and error message.
v5 link : https://lore.kernel.org/netdev/20240611162827.887162-1-vineeth.karumanchi@amd.com/

Changes in V4:
- Extend MACB supported wol modes to the PHY supported modes.
- Drop previous ACK from v2 series on 4/4 patch for further review.
v4 link : https://lore.kernel.org/lkml/20240610053936.622237-1-vineeth.karumanchi@amd.com/

Changes in V3:
- Advertise WOL by default.
- Drop previous ACK for further review.
v3 link : https://lore.kernel.org/netdev/20240605102457.4050539-1-vineeth.karumanchi@amd.com/

Changes in v2:
- Re-implement WOL using CAPS instead of device-tree attribute.
- Deprecate device-tree "magic-packet" property.
- Sorted CAPS values.
- New Bit fields inline with existing implementation.
- Optimize code.
- Fix sparse warnings.
- Addressed minor review comments.
v2 link : https://lore.kernel.org/netdev/20240222153848.2374782-1-vineeth.karumanchi@amd.com/

v1 link : https://lore.kernel.org/lkml/20240130104845.3995341-1-vineeth.karumanchi@amd.com/#t

Vineeth Karumanchi (4):
  net: macb: queue tie-off or disable during WOL suspend
  net: macb: Enable queue disable
  net: macb: Add ARP support to WOL
  dt-bindings: net: cdns,macb: Deprecate magic-packet property

 .../devicetree/bindings/net/cdns,macb.yaml    |   1 +
 drivers/net/ethernet/cadence/macb.h           |   8 ++
 drivers/net/ethernet/cadence/macb_main.c      | 121 +++++++++++++-----
 3 files changed, 100 insertions(+), 30 deletions(-)

-- 
2.34.1


