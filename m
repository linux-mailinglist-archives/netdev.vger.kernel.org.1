Return-Path: <netdev+bounces-100934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E18FC8EA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EF61C21389
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE4190492;
	Wed,  5 Jun 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qby5Xse5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C619006C;
	Wed,  5 Jun 2024 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583120; cv=fail; b=ga6RyHAfxRvDpgcvsH9UfNkfOhFaCj3uJUBVVIeS8CcX5YwgznuslDXg9C+Txk1eLxLfn7RM5jIalXdnwmFjzFQSjIERBia3yVxXEjqzx+wIb8YK73GePYFrdonvFrtPEZ6m0KnZuIVlIw1zMMo2OQ2ST24UImIxw3XigUAJF5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583120; c=relaxed/simple;
	bh=lHn/eogmSUNUtvRsolCL52C/6ZKm8CZOKhUDaeFl+c0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aY2L+LtVxxvpq8IrmGNqHAH9PlMqZebHGE10wn+BRCVLItplRNvieEO5b+yu3rbfYpB7rUVAmxqVPG64FZxkVghufydSAqpDIrARJpMcXW9Rs8RgDq4yHRz1FXUSGnPIdj42et/4Rh6ibYOg0x9j1KkYzJ6I1O28d7eRKpKyn0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qby5Xse5; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMZ/irCynmG5KRyw28aju+Jg+B0oTtnwtaC1Su37/lp6jZVM/sEHwLco2nJVqLIWTvtd7pSezaEq1GXlFEu5OSAhSu0R+Y9VKRp+ixiueCpMw2zTdDZFGNjWjSFWPiTjTM2wguq7pTwgl8pwfFijWPRMPXUlF8usJnXSnWox/x3fuEy7DicC5eKqBdOtu9602R7AMrhEC6TvgQv0onDjYFm+aIo7KJqbJQ3MboJjqL4mCEIRhaNviLQ+8kPd6WnGo08n/PhK/MJVu33KO0Y7bLgv5IRTDHrLoQWfqoK2J94kmZ4Y7xjLxp+I8BZNzMrYeS8RnYcE8TCpY1QR0o20gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvg1CL9EPrihYe9lH37orXoL1ObTzorPGGzTgBU8TMk=;
 b=EUK5R+7XJs5wd9fQvAJBXF9ylE+x9KXog3EbzoIzqXknJ52H+X0RnL/fAvU7TN7neCNZ65S+4IN1KA9EPaV3ypfIrQzEwZnRAMDVc8K60NWt3lAnO/j/3KJthCCtMRkUa3wcWd+e947LE2PPmGQ5TOFtF/O03uqqSuG1IPMbXKsnTfAESeh2xqi/mm0MkB6QdYstQaeV8uoXRwe5+QUqaVhWHG78smKvx7FD4q3SOkElZL6ZQtOqRihNSltHBah6prmw9mSyL59l3i+OMVeVkd4CNt2eZ4u3o7MXVSdUGHaY4f8QszJ100BJJ8vKt0m82K84P2Zx9TJfa+g0w5NK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvg1CL9EPrihYe9lH37orXoL1ObTzorPGGzTgBU8TMk=;
 b=Qby5Xse5z+LdIAts6bYJ9SHPhE7zYD9y6nkLCTjDBlGfA/i9o04NiDGm6rNsn1VCKmTJHsMe5zBMXbMIq18/5lcGbpdLg2IJTyPdLyzAouhb/Ou0NxaqHINGyvEjntvzm8qmKNBR9m+UbWC7WkSSLGqTIbBbKvLx4nmYIV2ViDM=
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 5 Jun
 2024 10:25:14 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::41) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 10:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:25:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:25:06 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:25:02 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v3 0/4] net: macb: WOL enhancements
Date: Wed, 5 Jun 2024 15:54:53 +0530
Message-ID: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8ba730-4e23-4ae4-cebd-08dc8549c959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|82310400017|376005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJA0hFbgYRrIKTBcBU832Azup6gV+zCQOlyjpagfqUOstlc092+j34xNoW5q?=
 =?us-ascii?Q?A6ZJ4j3XDrOE+mhEoKB+G2KYeq4QyctDLLN3w/1v8IMurEHS0Wyftn7Nvo25?=
 =?us-ascii?Q?vlFQDxFO2tB+5z4dS/OD9ShSw2IEEpXXZq8T5RSkEw575nqS26gIZl3j+vax?=
 =?us-ascii?Q?NL09/yWt6Uyu8p/C1ekN2IFftKiA7Sl0YrL7ogwH85n7H/QTSnWrlYiAVD5S?=
 =?us-ascii?Q?VAQ5H7mFF2ooArvi1zRpUrWl79hF8EzPMHTLJ8l5ZmmcgKMgKWW7ZlVnlqy/?=
 =?us-ascii?Q?2jV4QqV7KHC79VOFWEGMz8XexZ37fDfF0OTFLqx+BOxQTFfOGd0GmZkKborZ?=
 =?us-ascii?Q?3eXCM3RtPTrpeErW3wVIGM4+m7APtPMKsPyVFCiDRJ5u6LFbMpU5sIn6B0ua?=
 =?us-ascii?Q?/D8lKz0/hBagXXZQPicsIdu343qXHelXA8SrtnexW33hUuPFmoTc6pfFRD2W?=
 =?us-ascii?Q?dOa+RCrS6gjukfZkiDSR+f7WaAXeWkGodZIc/ln6p2J+lIHNiL3o38pHTNaB?=
 =?us-ascii?Q?+pRu4kU4XTPAfAryA4mQee94KXVQBfDzQ4Y+NYhWDrEvScLN93s5u6UtkR+q?=
 =?us-ascii?Q?l8qAkz7ybJlHJueZ8L89hqJftANunfpxp+arJOngrsxLxCGT7G1TD+YkKJ9A?=
 =?us-ascii?Q?UKJm1NRgiUcIzA1pMzK/saEC4fAiLzVoYOZZ8Q2IJFrNL1trUN6x+ACadU+f?=
 =?us-ascii?Q?lX6Lr6WjuUwM/LbCToa9HDKyuq4KHwXN2oH+arMjyYA2acs2H18/ve0td749?=
 =?us-ascii?Q?p5vIvbkWssis60d217Y++dLMFc00K9p221BQqeS3IX/shAKyVip194fmjZ7X?=
 =?us-ascii?Q?Bh8TXRjK5Cjdzdpx7FIcqWO0WUVNN/ljvX/NEO3Ti1F8S3J8CrKvExD2lY+I?=
 =?us-ascii?Q?lZObnNRI0G67YQbrlW8Mi7ZpAx9SUWIgp6BGXmDqt9WAYtGf8ZonP7Gja2pA?=
 =?us-ascii?Q?U68EFNWfl5UksI6w/ZEHbT37Q8YlbuPflD1bZMRrFRJfhzpIt6+Fwc8p1MtC?=
 =?us-ascii?Q?S9kqTuYcsGKZ7XoZLOIhk+SZULyXYR+NS84v8QNorb0G03bbfzGzuC/zmKjz?=
 =?us-ascii?Q?H7/mxxggGsrYzQTB4g69yANw8ADifuedGcvRa+Eow7KmlevzKiEnjW/17BLH?=
 =?us-ascii?Q?p88VGE08kbtFEXOC2nBirZHoOmQ7EI7opxvq+UpMDOB2wAC3TtkxJg04mxa2?=
 =?us-ascii?Q?S1EvDleM1UblmKOL9tLtG3wr7MD5bQW4On/xlv0cvhd/mNF4xj3V2uXKQT8T?=
 =?us-ascii?Q?M57eimQ/5U/B746Vp4Gewb23jQlis4UFtJXzvi4yJVIvZsHZUG1uhvxhYcCz?=
 =?us-ascii?Q?aCckxbLUgPvEMnXzL4/zPrpVWuUEi0g+mouQCZwj8ZHq1lOOf9FJH2Z1qg0C?=
 =?us-ascii?Q?M3qEn1KJPoqEGB0S1k4+g9ss4XnW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400017)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:25:13.6043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8ba730-4e23-4ae4-cebd-08dc8549c959
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

- Add provisioning for queue tie-off and queue disable during suspend.
- Add support for ARP packet types to WOL.
- Advertise WOL attributes by default.
- Depricate magic-packet property.

Changes in V3:
- Advertise WOL by default.

Changes in v2:
- Re-implement WOL using CAPS instead of device-tree attribute.
- Deprecate device-tree "magic-packet" property.
- Sorted CAPS values.
- New Bit fields inline with existing implementation.
- Optimize code.
- Fix sparse warnings.
- Addressed minor review comments.
v2 link - https://lore.kernel.org/netdev/20240222153848.2374782-1-vineeth.karumanchi@amd.com/

v1 link : https://lore.kernel.org/lkml/20240130104845.3995341-1-vineeth.karumanchi@amd.com/#t


Vineeth Karumanchi (4):
  net: macb: queue tie-off or disable during WOL suspend
  net: macb: Enable queue disable
  net: macb: Add ARP support to WOL
  dt-bindings: net: cdns,macb: Deprecate magic-packet property

 .../devicetree/bindings/net/cdns,macb.yaml    |   1 +
 drivers/net/ethernet/cadence/macb.h           |   8 ++
 drivers/net/ethernet/cadence/macb_main.c      | 113 ++++++++++++++----
 3 files changed, 99 insertions(+), 23 deletions(-)

-- 
2.34.1


