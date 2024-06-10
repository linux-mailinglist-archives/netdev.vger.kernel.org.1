Return-Path: <netdev+bounces-102154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFBA901A40
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C01C20F97
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1A17C8B;
	Mon, 10 Jun 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TaLaY0MW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D5179A3;
	Mon, 10 Jun 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998001; cv=fail; b=FMzQ2w+H0vWOY2jCPxvJbsQISOm+ZIpcDeaYmmhh797PIAdaTh6vtWKtX6D56Kg1cvMQNKGAhJE7Km7enmIY+MoShU9tlGtLO5YkB/wNkc80QiDzwtd2jBOK5nCLpqdFxWYEn0xjTmEJRzmclbxenF4H3UVOJFtkwP+JUcHPUSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998001; c=relaxed/simple;
	bh=c9//7KBKsuH5+IUhfBJzhCb1fw21P1RreQw5z6GuW40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUDThKOf/8ujI48GMfHgX1ySsc2MI8nYR7FDYypVQRBxShDvFZdc9FCPURHObbhPxBYu6E/j4aEM/c1VOKT+W7MOWNNEqyP+bv+oFEq2ej/M3+hjmkh4ES+X7taygoWh9SIGha68xZv7C9ogLrU/L0Sfd+UvmalyOqADrmjYyTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TaLaY0MW; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4ZkacDMU41+GItrKA4MJ5Rp064EtrNh1hHWC3JNAeTVdkJ4Q1eWgBUSJ4Q6//w3m0RIbK3+2R46nPZR/QkS85H+cAW3fdoz7SxCGa5fV7on3I85gFSNjGzi0FzJvaClMNKdvBRVuUTojnGKfnULKiw0d6zoz22tNVxouh+xmmc9rHI4v9bSEPmHDsEXpw+FDqQoJvdviK6BdpAd0o/ebGxdEzAygcATzXzFILZxKtTO/9BP//ABQ0j7Aw9Aputxp2WdiMyc/Zydk9Koj+oqRf8UpgWklcp98+nMOEAO58NO3xGHYrFkrm0xk94MyKFWerRAeXcZh7CQPj5h1T/G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=fMYaVfRJmCgfpLY5drp54XFucHz7qJhBI9Lkj4yRyMdB5WeSTC8GJTu0tqwKDckf9hM9T2RwK5Ht3xh/p6cm8JTAseXqe7NPgQmrMsMyjPcqKxlGmvDpBfzIexYdHkuxBfvKz+c9BmK/84/Fdk6+s5lA0Zp4+r5lkODMPNq40KUbX8Bl1Gz64Umjmrxzb5T9srO9fi3hylD8wcCoB9vZVjwLpfW1XingzJL+TiaLoMqrM/KWjK4SKz7eKZGElEEY+MZl2wr5P8Kx+ngWl33+xdgiW3xQdbh7gVp7xrEusmlBn5LqgTB03ZZdUxVuSVXrLsHe1MGhLzfFNYJLwIisRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=TaLaY0MW0TH29Jd7hqe+DOGYsXpuoaR7x/r7Ojd4phkv8JgMxV7sdRvhPQ7fZGqvbb6x26AKMJ3qb032efFeAa6bW/Ch4n7Kj4k/pzAuYDoOWf0ts/u7E+CpV6LVtFyqD/37iMBD+5lyVv/khoP9iguXGver/X2bPpYY3q7OAts=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 05:39:56 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::94) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 05:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 05:39:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 00:39:55 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Jun 2024 00:39:51 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v4 2/4] net: macb: Enable queue disable
Date: Mon, 10 Jun 2024 11:09:34 +0530
Message-ID: <20240610053936.622237-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
References: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 549985f6-6ec1-4be4-bb84-08dc890fc2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400017|376005|36860700004|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tKV2GZyIOwl/tJhBX2fKKeOOtUw26LXoH4sHSBpzDDHFgzPd7G2a9u4KjF0m?=
 =?us-ascii?Q?Lo553G+PRHp5BsXiTgo2a8nblKmgUiBpQ3lmVslHG6sBb7CexAAMpoIxcPwQ?=
 =?us-ascii?Q?r0z0U9+Fg5d8M5EwIp9FMicY2wb4eyj7zjhbiFTaswW+Cnes0joveVFvpts0?=
 =?us-ascii?Q?a3ffLed7sxBMOpnF+b4Vf8svvtV2X3ONDGZVZ12D659W1gTmpsxOTUnuOwgr?=
 =?us-ascii?Q?eNJHkUN9CK0zpP1aWqMUqks+rOtAZwJx1N8taYqmqhup/0pG31JCsaLlyPpa?=
 =?us-ascii?Q?PGMA3t66ZurkKQ0DNJH+9ebiKHO+MBOWXrUZx3fztcgE6prxssSCdIrvGFSD?=
 =?us-ascii?Q?BI5c8RPLLLfpEyaEB1wcpjedu3nqM8bLpAKjigs8bAGwKNPgfK7riOiZIT2X?=
 =?us-ascii?Q?QlbLTJcbxIiXXmKSiF4CISRzWk9Djcyl2P7Pd+hCx2X3maz39kNLj2VhjcIu?=
 =?us-ascii?Q?wJpqBpJzyr+Gpm1aq/5XTEPGJA29K9NloEqs7SwWfOGh2Tov4asy/LKF5qWs?=
 =?us-ascii?Q?DP9h+Zm8Yq99WLslgfOJuBElYcX3UTUse9b0PDEZEWE/umTmH03+iu3XUd4M?=
 =?us-ascii?Q?YR8hbw//rHzc0h0BByXDDddZy3hpXA08YG5nLBPOzJd1VDnu9QGjU9qJ4dGs?=
 =?us-ascii?Q?U1HgQGlh6aIj7waWXUqlYHW8fjgwsf0N44jkmwstjXg8awND1Lku1t76SmuA?=
 =?us-ascii?Q?LxblbIbGo3fbWMR6wb9KLN8LcJTpQjTtVaOlbnLk/BG6QA/k0d+j11ZrSlIn?=
 =?us-ascii?Q?F9Fm0zp+6kxjr7DZglWWKgeGTbuq5eSKJX5Iknj/EFw87cj43/iwuNeep05y?=
 =?us-ascii?Q?+GkhbbDMnATCCozMz/rERnDuFWT3/Gfy+KDr+8XXFADK7CbyZmuLR2g+pJye?=
 =?us-ascii?Q?T6moOE1177mAOTA7Q7vBwpTWMwCHUXaDKIsmq+N9ZTwRVAKqT5Z1Z2G7CT36?=
 =?us-ascii?Q?O4oX0Uwses3p6A5rb2X1CjPOO/lzLmUFvx1vtppcCAePqIO9kZJlhvVWKTGc?=
 =?us-ascii?Q?zFakTW4OyNpULuLALI7NpbUF68yMM9Y9WLGljyqrbPnF5/ed97RhT7aCYac0?=
 =?us-ascii?Q?OAggawOwiPNZ3JrcSOhXGaNG3daYa4JrSmc0rMs8/8Fu6OVk+KoRap7C8OJU?=
 =?us-ascii?Q?1qB60SqANctN/ai9tL6xfi1fcOIZDTEf+aSXxjzhey5orvPT3Ppgi20Fgr4N?=
 =?us-ascii?Q?hZewKGqRFqOQcV83fm7UI5CBDzz//CIWLZ6BA2USLJb7xeI9Kum9uElctUZY?=
 =?us-ascii?Q?tCU6uLHp49oo1tpZG+fhS2QZ6gI4ooCh3cHdKNVNOPg63zPV/GBFs9J75AOq?=
 =?us-ascii?Q?Ago0NH6wWexfrPb1Jk/zKqEujfoV6VJ41YE+yZeMt5yi1mSoKvb6UhKAl8AJ?=
 =?us-ascii?Q?DlXlre4yMQdPD8N9QBDglnrIQVGMjq4ccIk0AZMEzFwM22F+77VMYi2S0qEX?=
 =?us-ascii?Q?FUUo20jzRR8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400017)(376005)(36860700004)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 05:39:56.4744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549985f6-6ec1-4be4-bb84-08dc890fc2db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

Enable queue disable for Versal devices.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9fc8c5a82bf8..4007b291526f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4949,7 +4949,8 @@ static const struct macb_config sama7g5_emac_config = {
 
 static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK |
+		MACB_CAPS_QUEUE_DISABLE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-- 
2.34.1


