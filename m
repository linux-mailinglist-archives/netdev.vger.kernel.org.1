Return-Path: <netdev+bounces-103932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673EE90A66A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBB01F2479C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0739718FC73;
	Mon, 17 Jun 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CriPB39C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404E188CB2;
	Mon, 17 Jun 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607867; cv=fail; b=RosUuFjRBUrV6IjnMVbt+WoczKcNfBxERFtK02N4BWg5/tRk4YT8U1kFUYt5J86Bn6LEUzszLlqbi72UbX+sF0uO3VpubI7je6ULeleEBYJjaEDUbEpVShx9pS+huJSDWrtxEEdTMIh9aMJpnFIzNheBKvjvoCxiqCXaIfmoE1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607867; c=relaxed/simple;
	bh=8T2sIu1A5qyyxLktjUk/3hkTDPit6l/IHgYrOcAXxBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ox3G1IhVir/oNYj7G5vOaGgfpUFMiBQ6566w6RjNE81TZDRm3AFhLEZvdWEx/2hI54V73t031GPk0nYMWWfB+X5XudLTBg9ycYuel8vNxmAvhII89vtE/VFHVz24Y73iDKjR7XYt0dMcYrg9iGPGswabG0rrmB0uZHFIwudnjjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CriPB39C; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdURIFsbA7NZM8ZO+iMYNSlFCxvte9ksYOOn3NrkJbrKsKRHgcF9N+k94Fr+gBUmzZMxvXa3dR+cKfKAmM/lHsEPWiLsHmU+Rz628KhF+m8Ocus/E2WrL1imKC02FsWIfUiVVUmhIYIZyrDaxVxn9Wyq8e5UZvjijIW9B6OgY5G8vpvW4ri3qQPorCmQm9k2GwQGbnnDdl9r13J1lV2bvEii3ORgzU1qr2Y2gdmtMMhss3jCAMyMNr2CiQMEXQlFkxaO/uNyCIdI/Q1SEgj5QbxqWuAwbbPYp2zdY+IA1O+AxNG2mH+oZd6r1GlSQ8X9HucGCtpE+D9sFOTw7/N4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qGkJj32BdmFJ2a+GWtSjwf23HkckDu0wh5c9SBC5r4=;
 b=IFMIxuZpkHpvm6aymqiIQSAzgZUYYk7+ekOm/l8+P8RMX9dbP9KmEsyS6bv04/A7n8rSIW4cnABfDLwzGkRwLKXeNJFnRgfTpf/Rem/c69QkasqQCsytN7v69S9yrHFyyGYSEloNdwuWjdY816mJfN1GoLzgragMKfG3vD4Za8rYGdtTablBbhCxecjX/XmFCF7wf0CCGHy75IUVT+IIAp4/sMRaY7BIMHRoXHgswDLmBJ/q43+GHASHnhIhJiyPYgn0htjY8rNWXWlU3901z+YQcLiYhwCLflGlbBvkvbobKQr0ypXmnfbXDsHVP/3SEkEEzh0tivNQiX+awsbPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qGkJj32BdmFJ2a+GWtSjwf23HkckDu0wh5c9SBC5r4=;
 b=CriPB39CxYzN2HWPUvgp5Bp8Za5hXUaA25Efu5Sm0BsVBf648cKEYIlZHqXI6X1z+gcF+ikLz3E3ltKLA0qqqHvbf0Ize45F+zfEBYg8G/Fg16KtDcBxPaf277TjhTPmnZ8Hozdl1uKuWoqHTHPa3x1UJEroEI2kYnHaiPXvY4k=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:04:24 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::35) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 07:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:04:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:04:18 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 02:04:14 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v6 0/4] net: macb: WOL enhancements 
Date: Mon, 17 Jun 2024 12:34:09 +0530
Message-ID: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: f21642e8-a138-4e91-f76e-08dc8e9bb836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|376011|82310400023|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmJMOVprwsiqWY8+hJWsvGXV8luzaYHEkPfRD7dyCtLZYUhhAd1B7IkZ0J7A?=
 =?us-ascii?Q?CcTkQxBjXgsCEmynO4c0VfB8dexEPJe4wUIpMRGDbgtoZb/45AiByCIVvg3d?=
 =?us-ascii?Q?xqhYvE/QZa8eYpYBVo7SPe6iRV5CCmI1PGx2bDeRRC65+zwwFWfUyxRCqs5h?=
 =?us-ascii?Q?jIwKyN8bGXtw3RNBt9E2/T3BvKF7adyHrYbkZNAMygyZSnCkyB/h1QdBuELz?=
 =?us-ascii?Q?QhbuSeveo0R2FfIh0t07p5O9QKx1oNABUOcLsODxQvx+T5EcYK9NFD8eJybN?=
 =?us-ascii?Q?L8LaxDCfKyU1j5gk4/EuzBfK7xjz4QOTPkGzcFPO6utu3wnvgT7o06I9P7EX?=
 =?us-ascii?Q?zWN93qLBNU3OiBjJske6g/Swn/+E77jUjHVhfOOGTwRAybczlcaXhRqHG7gi?=
 =?us-ascii?Q?F/ZW5pwsfIjdx3Njt2W4pFixrQFzexnHsqFfPwD4DtrEwBBbOguJGth/CCmg?=
 =?us-ascii?Q?2IUA5WbtsUDRKSycI/5TNE5yaeQGW1Scmvl3yO5v8cvrCaxsOWz2TqvouYQM?=
 =?us-ascii?Q?OaGJw/iwC0FILDJB+Bu8oy8Wi3D7QZWVu/nEDkhzckU31W3BK0OPJVAUgBzU?=
 =?us-ascii?Q?bv3YVsMm8346czSBOYJ/52tOY2U9lpAxBCm487M96F68mBRf0g75W9Ir+pI/?=
 =?us-ascii?Q?q4xSbj0wH5LEe3gaQjlUc7s/eo1IIsw7wYLvUN4WeVABAvqcLdhaM6Um6Uih?=
 =?us-ascii?Q?KDGcB3TUNs/mCNZwp8SV8KiVDQCwn+X533X93eFd8yavD/ybu0XpcWlcfqSJ?=
 =?us-ascii?Q?OX0DEFXTLfEVScQzILldspErzN+iEANq7TxZrAN9788QnPhRLFgNfffssvDa?=
 =?us-ascii?Q?1yRAXhVm0yKVEs1WuWGaljZzuLlWaA5TEMJvNytSeJ03VWP0hJhwbYh5iONp?=
 =?us-ascii?Q?mv4Uoo7uMFzQ//n/4lf+nOf0gb5Sh/hpLM1FQTn1uxmgSTmxR9IqrooAhkji?=
 =?us-ascii?Q?C/2lx+02AwQNKqI/WJZhwYH1+FJva40MrVYcVQi/BEzJDmi8k5HdLFF5xwjx?=
 =?us-ascii?Q?mEPtZsB1Sv8qUZHEzEXHmCvIE/D/Tx/ujd28PZz313B/fxGwxNE6RY0lZcur?=
 =?us-ascii?Q?scJEGv58jiPve6irt9sfzWNprUkZaSNc9T+20uaI1p81Ikk/FWuES8gkZpNF?=
 =?us-ascii?Q?ftNhBfDja8dF7GofBSvyYx/N6EC7yt0LqazlmgH6IhhegLv/GHKICr6bNAtU?=
 =?us-ascii?Q?EHY80cMavUWBHA7fIjfqg5/1qgGGzRMYnJZHSfpb4Kj+l5572+DiXg7aIiRt?=
 =?us-ascii?Q?GTqXO0XoTatvRezsoU7Lus0j1dQN8y5u7Sk/YUHm3+oLOhcDMKC5rhEiwFPI?=
 =?us-ascii?Q?JH3e29UrMpu1pzakcKBrsgxk6r3fBskMIrZ7CHEseUfM3kVSmZUoNuoaSIsE?=
 =?us-ascii?Q?KGOKn1kDsb0MlHgwPRmMGtj8oboh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(82310400023)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:04:24.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21642e8-a138-4e91-f76e-08dc8e9bb836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

- Add provisioning for queue tie-off and queue disable during suspend.
- Add support for ARP packet types to WoL.
- Advertise WoL attributes by default.
- Extend MACB supported WoL modes to the PHY supported WoL modes.
- Deprecate magic-packet property.

Changes in V6:
- Use rcu_access_pointer() instead of rcu_dereference()
- Add conditional check on __in_dev_get_rcu() return pointer

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
 drivers/net/ethernet/cadence/macb_main.c      | 122 +++++++++++++-----
 3 files changed, 101 insertions(+), 30 deletions(-)

-- 
2.34.1


