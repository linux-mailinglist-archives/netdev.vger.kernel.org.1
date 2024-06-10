Return-Path: <netdev+bounces-102152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDF901A3B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE21C1F210D4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCCCF9CC;
	Mon, 10 Jun 2024 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X3vhCa9D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5B1400A;
	Mon, 10 Jun 2024 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717997993; cv=fail; b=SRqXgu0D0X6YHK0esPzchk1hDNE7Bh+dvfHbPaSlFDdnk2DMxdIo9YOqdEGDhdJHXxnfTcYrDSxRetKfbJ1Tl5qqKKkY4zpa2lAqfov7/87IEgMTuXTLV1+Wg5CrTTyoovKe1UFjnj3N1VHZ3mGJg0rfKGCHeUGV6Bvmb+wcTHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717997993; c=relaxed/simple;
	bh=BkRt+PK4h2q/gUfcjGqWjU2QsW3Fqv2KJEyJzBFOkIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SajouPHKy5fum49BPRA+lq6+M4Zc5Hm+93hqylWFD7HoIo0HDwCs5bjoLW6i2fPym6U9GaeYWW+IHdrMsMhuFp6gDkiq+Ay4sjpBT5LluZKXxWAe7t3WZZhSUqJd9rq2Sszdq4m43s5Ii/1KrFZSlXZalN0Cw72Irv3AXLw7nyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X3vhCa9D; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqzBrE0u/Gq36JVuG2scuhVRWYWuaJ19F00dnkWa8PXAfk6khXONpAaHxZBr04sSlGh7lVNVexU0tlXsph0VONbrDyztb2e0KKEg2PNQkEGt13n6dsAgxHf1p3iZxpt8jcs8bEuIRjm9rtaqMv37yZIW8taQ7MpQo1CMbGeGZniRmT1yLaYkkSgF1gfDtywxeA0UdktWzkV8N1yj1bMmeT30Er1sR2aFJefCNlJWEg65iCQHd88OvuiWGFaagIvVz9TZj0YSGm9U6SerrxN0ZOnao8ci29J7DanahsKDMtmYH20vW2KKUnzpRO/u+3kSG3P1n2sCfKTYgFENTZeG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU9Xff99lbJvR1rL7BQU9wZPeJVP9SxHQ6svRyzy79Y=;
 b=RY9kYR28fLae+f6uZ/Ofy96CpUe/uoy2jPu9gOjBMeUlMJ0u8w3S9zf/18B3EF/X2wBqHmU6/K3PNjPpptBN+6bYkweYZhjKlCGcqj+Wl+f8B+t/OmRlQE8gLyQf4K9Ip12AIP80BNECqakwTkXlWBfLYujVdwVlI9Ho5v2i/VbwyHWo5upvmCppApqiWY55bWIDqQ3m+Z4odopFtWRLZQD0IJ1E7kBs8sI9ry66X7EXrXYTsTw0NM9KGpcB2bNP4HKiRLXEM0l4/E7yc24re5onb/JdESf6J69ZSmUEsHZoehnJ3pZA/iJztIDa78fznTclUZ4sNCCMhwt2uBNbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU9Xff99lbJvR1rL7BQU9wZPeJVP9SxHQ6svRyzy79Y=;
 b=X3vhCa9DvJnxGxwJ6GYkMu+Fwd2UQubhoubCDwzSyyBZSIEDBreSveT2wwzDHvgMfm1RZ2N3TFFLQ5B0Qu65kINksmSXJBJymuz6uC+PvgN6CAP82ktVwHTMDfX2qZOAELUndiSU+Q31zUaOzC6pfXRfzCFYNMHr3hA5tjn47RQ=
Received: from PH8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:510:2d1::28)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Mon, 10 Jun 2024 05:39:48 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::f6) by PH8PR22CA0019.outlook.office365.com
 (2603:10b6:510:2d1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 05:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 05:39:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 00:39:46 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Jun 2024 00:39:42 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v4 0/4] net: macb: WOL enhancements 
Date: Mon, 10 Jun 2024 11:09:32 +0530
Message-ID: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc7e479-abac-48eb-aaed-08dc890fbd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|7416005|36860700004|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HC5mHpGMSDs3DgQEZ3t0bLyII3TWIvFxIU8iVRCdPu9sCN/6QuQ7Hxauw6XY?=
 =?us-ascii?Q?w3TJfRluQtUQK5uB5J+iRI3abJgQf/fO4JqKD1wKxNDQ0+lGkYpOGK6kXTA9?=
 =?us-ascii?Q?J6iatdK/iBnCldnj124p6iYFmodfHKdVI/yfpL1+3NBPtTFHJ6e9YD/tT6bv?=
 =?us-ascii?Q?5RkoNjOWnNrYWczGEw9vPi8UEu+8FbbaHA1+59GJ66jOmSSmGfhTZzRgGJMq?=
 =?us-ascii?Q?lWnffS6QCKmyHSVTGieWKhVEirPoBtc+j1kcUhhkiSVYWRVezzd5hCYADqqs?=
 =?us-ascii?Q?ydRHbfa8rzLHewNJDYDMXf2Le7X/tNZ3SgccxKV/kyeBB41ko7XBweJhl1my?=
 =?us-ascii?Q?/fp1uvux2EI3cqoJ49J1SEB9kRrsQ0/i99xF0by2DAyLpseFW0zKjehlz6++?=
 =?us-ascii?Q?grz2TQ1maId2uwkhyemI4oS8YgwgVhquxlwxoDitpBQUFtdo40gYF2JP3o3w?=
 =?us-ascii?Q?rEcrbDY/yrCPjezYo3pr7fE9qtqSoNFCBp5RJ7YbTy2ZJKwVanB/Ovyx/r5L?=
 =?us-ascii?Q?AlgarUcuMjdoBB4MGzUURxK18fWTh7XETi7jG9K7fGjS4nQqrMQbIzi7CLxa?=
 =?us-ascii?Q?CIBqvabAIGbybQUOisdyl18TWkPZPPpBBy3ADCgXFQ7D4ZtRIBFGJxMWG4fT?=
 =?us-ascii?Q?yXyWz3FeOjFKYYWqMC0qToClvvgahkg48Fb8my5Ve6jlHi5P3bKbN6jpefWn?=
 =?us-ascii?Q?6H5FIZ3SgIh5cwV2eKWQ+LbXU2jC19VJ5/9IWMTpYYoFFLF4U5loO3wI/e+j?=
 =?us-ascii?Q?42aiW/zlRCSqkIKWDB/UMpgtKRzHVNQ9ST6yX37DtRQbYsUlWFd3h8sZvFk7?=
 =?us-ascii?Q?QIcSKP2bw91XAnhUmdMHKVF9aN0Dj+axJavyu+ke+MQiCpiBT/E0JHhvUAhX?=
 =?us-ascii?Q?2qypBU41h/ZRcGrenbiL50bwW8YvnEnEysdJSrUjs4SXxmNdVpgztAUKFMK3?=
 =?us-ascii?Q?HGhpQ6GEwiiRdAlyn5x8q/7wXLSnuwDQy2SXhTxoKl/5B6wJYoQ8kwpLDrWu?=
 =?us-ascii?Q?ZmFphVz47DNDBUbePhPeP3Z41Dheln9WRGsmC4G6pq8haTz7olwDieBHKIqh?=
 =?us-ascii?Q?nr7ADPD9/MJEN2X6oYLSTcTicTltztf0DDy7P2cJQPNROEytaky+FrkUG0Hr?=
 =?us-ascii?Q?MX1cKKfsmbPt6RLTVHlonHcCRNYlUlUczdjFIcds5PxiKf3CivQma3nTRRNV?=
 =?us-ascii?Q?LjUM0arFVWCs53xnTGktE/SNg8JIEHzHQ1Ec+AEdTghAyMaiOaVLDRi0urlE?=
 =?us-ascii?Q?7a4sar/PJBb/2CBQogO5FU5uupoC5wW36VdIaiIBkXvQTlNxWEe1VZxeMAvh?=
 =?us-ascii?Q?wHcx2W8i7ZqPVJqU+CpL9QGwZ+szjuzSmBy5mg0xUVV/dIwG5FHX0IGyt9po?=
 =?us-ascii?Q?YTDEEwCxkNHvlveUtfI/7f2DYeDa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(7416005)(36860700004)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 05:39:47.5061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc7e479-abac-48eb-aaed-08dc890fbd85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745

- Add provisioning for queue tie-off and queue disable during suspend.
- Add support for ARP packet types to WOL.
- Advertise WOL attributes by default.
- Extend MACB supported wol modes to the PHY supported WOL modes.
- Depricate magic-packet property.

Changes in V4:
- Extend MACB supported wol modes to the PHY supported modes.
- Drop previous ACK from v2 series on 4/4 patch for further review.

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
 drivers/net/ethernet/cadence/macb_main.c      | 119 +++++++++++++-----
 3 files changed, 98 insertions(+), 30 deletions(-)

-- 
2.34.1


