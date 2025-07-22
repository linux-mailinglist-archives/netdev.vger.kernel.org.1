Return-Path: <netdev+bounces-209032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B67B0E0D4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378F3566E1F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0C27C84F;
	Tue, 22 Jul 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="deFRK5Ib"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067527AC48;
	Tue, 22 Jul 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198902; cv=fail; b=VS0EMF4dHeTL2H1NZXvBbetJmW4hgDt13pQyvdFtFIrzCSTXkzIqFGOaSZr562v45FYPZp3dh8htQS4T8ZVUlB0B2oYVedA5VHLoOwaLWuSO+UTvireR3MuVwe6GVcnk3CvCybiuHkV/SNjVtU4FjJZdSHP8W/cXXnJg7P4IwmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198902; c=relaxed/simple;
	bh=KcUIHXGP1A5g9YF5BcWipN0R0xsrNg6yBDpEO0Jn0MI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fa7maa/t/xvUU8L/VqsWVlQ1unorEaHiFLRk5Yy2Jcs/sFSKgDlx5RiXuTQUm0le9sOanOkFfbhqmXke5YqMr6E/jiwasG2ItJTngBp3mP2tfvOjGEpzxVnHp52ji6UuYEYCH+PRo/PCE5GgA3VzECGq/0yElGgVC7faZvGypWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=deFRK5Ib; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5BXlPzNfpsOL30mqGA3t+ggisoT8bxngy8rJs1+vS3dWX0b3ol9WaoS8duWSizg+pEQZi68Pgj2NAfW1lfWMDJFe/Ymkxqav5fFROyhLLzI5MU9cBtOUrFFcl8EEvhmI1ZvflSzMWrLHgjCvKxIvU1SrW4H4mNpn1iMzxpkwTO6YNxQ3z7t/Kp6Dn8UfsT1sKJkP7zxZjOkfLQR/3dEOvyztCI4MyHsE0oL2oKEcP41dQRwBMdkVwf0Qu1n5KQe5yW31FImWUDGwvfusEWWOblXZWDzDqS9U7bXRdrlZEYH7DJFLXxGOfXkomaBbNzLYENwFXY2CXYaDqIL2Hh7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGEcjAoKX8KgnxUvASm0Lx3vnL7NrDmhFX489fmpKSk=;
 b=YEbA4WLi5mBwXa6NU4sjgaZEAQY1NoS05V2OZ6vqIvd5J8odnQxJb5xsI/8IwKv+dcIQV5PXd+NJAKavOBQHbLp9qRZ9c+dssop7ZYsMRuiM28+vehTy+NkR3LD6EcJtHkLePIAS+ShEaMo667QjeL+XL44lcJMKZbVNZ6OrbywTS8aE0lKgcS786U/nHzy5AdxB/utA4EiS/P7/qTiDBCS5k0JC3ccoK6HOn4PyW5sVeEZ4B6cF1lLngTuyp8S3L4e0FPaT9ntaChE4hOnVlSCJZ88NkDvV4qYdDNt7KnfOq/LiYBGJsHssgvDqLPQtrYv+LyMfXxMYJSy9EGeTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGEcjAoKX8KgnxUvASm0Lx3vnL7NrDmhFX489fmpKSk=;
 b=deFRK5IbxFffPPfDOyPkRpJQbwCADV3RqneH6+qLJsAXrRyeBHNtmJLv3utYAFkL1RCgcYCVq31rF/CGFwGztcEq/YB/FGHw8h0Jeem8BVn8yt9fTqfzP2kn+v9ruGolcjQcAkJPXv+nDVQvdylAvQGIhHMKH73KJaVOs8defHc=
Received: from BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17) by
 SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Tue, 22 Jul 2025 15:41:37 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a02:80:cafe::1d) by BYAPR01CA0004.outlook.office365.com
 (2603:10b6:a02:80::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 15:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 15:41:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:34 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 10:41:32 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vineeth.karumanchi@amd.com>
Subject: [PATCH net-next 6/6] net: macb: Add MACB_CAPS_QBV capability flag for IEEE 802.1Qbv support
Date: Tue, 22 Jul 2025 21:11:11 +0530
Message-ID: <20250722154111.1871292-7-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 818bf5e1-45b5-4c1c-0e3e-08ddc9363e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhkattglbXUdERrXEHTZDH/WzuKmbs23rbC4LDCUCVZN7jdy0WyE1gSuNSnJ?=
 =?us-ascii?Q?tiQUZaX77OjEdlXjj9aQ7kkqko5gZNk+g9DDNT+hRW/Fc+SQl+10l27IuK4k?=
 =?us-ascii?Q?5TsMZ9Y4clNP6v3yuyGDgO/Pqpob+Ql8Ap8A7RcQfUPrQw/75KmS//+E6/Ed?=
 =?us-ascii?Q?OmDQ11Qe6z/ufeLHB5jQs6fzY1VLYDxlGGganlhVLXdoDbklSm8fmKTzzTn7?=
 =?us-ascii?Q?osNBKmD2XJ7AFV8C9J2lzEH9AYoaojRBqbEerSv6cR3MAPtApUv9rD8zf2x/?=
 =?us-ascii?Q?zGNkHEpYIbQ6xDf7GuIMDbDnR41L5232GBx0rbRhofUxjM3hRN90N9ASwxIj?=
 =?us-ascii?Q?i92hVd9y2ZkJFx16+o1VkaDBxLKQwjTJZauyOZLTouUqCBlisRaogkwyplLE?=
 =?us-ascii?Q?7IJLWHPN/xLzt8i+aiFKuHfoRsrV1fSngPk11Pw1O79uUciHAHGE7cNPCCJq?=
 =?us-ascii?Q?CWDwyjm4eXvaQNvMVrWMo3tNqEXPpSczkYwxZOTLt2pPI/MGqpgl6yJtUsbs?=
 =?us-ascii?Q?MxLDEzt7lJ9hAMnbCvhYojuoxulim1CdaQvV1Zb7TwKW3//FrksRvHGMIihD?=
 =?us-ascii?Q?ua0a3sxNMiaIZsfpjIP/fmmD9GYqOlldJMHcUEwz/Cq3YALhSJEAfD64W5bq?=
 =?us-ascii?Q?1gfYyzLu+IqcB46sXGSV+LkwHc7y/dYZpfH3tM3v5lYhK7JMDmE2qAeiR9cm?=
 =?us-ascii?Q?48k9UZBNySfAF9OrmPzIJA4+NY0M0xV0YRiptY7GztUt8bw9SBpNxkBDC1ER?=
 =?us-ascii?Q?0If5jimoB+g3swKnmYV83jmFbsAQSOu19BdbZpEmGs8Se5HGl3IzfJ3ViEbj?=
 =?us-ascii?Q?dDDIEMoc+fbl7REnZ3URXNLTU3N9zxqg4uNE1vLPWbKTJc5cZgppAR7TATtc?=
 =?us-ascii?Q?ukaExuuR1PbAsLE3kTjyFsfRsv6L6JWpVVBM8bTZEdggxmRDXkFrKXRmrAJB?=
 =?us-ascii?Q?cjCLX9AuW0H264QYjLqIj07hqVRgdh9OAHjUZ8R4wJoVSSwtOz6FJ/befgwR?=
 =?us-ascii?Q?6KVCeH9UFSf1X80BBfNjNVey0Q0kyiazH4lsXf8WAI/7GJBMLZzwH9xsATbU?=
 =?us-ascii?Q?VUrZIy5JDxXTXaAnACDzh4URX8U2BX02biUq/WKrTnSyUaMb+FgkPCVaH8ox?=
 =?us-ascii?Q?JBNhNKquA5Lu8p0iS13PaEnDkH7IUzUBUbp7khgGrSqGf6b4zlI57EwC6b2E?=
 =?us-ascii?Q?O8wn6I3qaRMoNrMmKu95/KMOGL9AgY4ZYu3A/Ei+WIiyoAIgTo3nXnf74tzC?=
 =?us-ascii?Q?r+1gZdFcTOZlqzaV6xqCUU1aLmndeD7vrbRjJgzBOAz4iw/oJAOgvLqHcNjr?=
 =?us-ascii?Q?hCSotTsNpI2zk+bEZecqQT3qePHbBDAQcWBKxeSAZ/G+mgFvKO0KKqwU0eDM?=
 =?us-ascii?Q?4rKXB22+sKwXQIDrjjg4EZYSBTuspPlb+Ux9LZdYVBlXu3V4Innx9zydDOcD?=
 =?us-ascii?Q?tAkGOfRE10vcoWdafaYNO2xoAMbkm2CO+qkLj/c6eO8/2aA6BjRD0Kzcd9Ds?=
 =?us-ascii?Q?mV06ImdiI2jDpyJKBpvO8kItXGO2mTqnGuwz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:41:36.7735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818bf5e1-45b5-4c1c-0e3e-08ddc9363e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

The "exclude_qbv" bit in designcfg_debug1 register varies between MACB/GEM
IP revisions, making direct register probing unreliable for
feature detection. A capability-based approach provides consistent
QBV support identification across the IP family

Platform support:
- Enable MACB_CAPS_QBV for Xilinx Versal platform configuration
- Foundation for QBV feature detection in TAPRIO implementation

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      | 1 +
 drivers/net/ethernet/cadence/macb_main.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index ef3995564c5c..4e8d5dcc814e 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -782,6 +782,7 @@
 #define MACB_CAPS_MIIONRGMII			0x00000200
 #define MACB_CAPS_NEED_TSUCLK			0x00000400
 #define MACB_CAPS_QUEUE_DISABLE			0x00000800
+#define MACB_CAPS_QBV				0x00001000
 #define MACB_CAPS_PCS				0x01000000
 #define MACB_CAPS_HIGH_SPEED			0x02000000
 #define MACB_CAPS_CLK_HW_CHG			0x04000000
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index cc33491930e3..98e56697661c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4601,6 +4601,10 @@ static int macb_init(struct platform_device *pdev)
 		dev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
 		dev->hw_features &= ~NETIF_F_SG;
+	/* Enable HW_TC if hardware supports QBV */
+	if (bp->caps & MACB_CAPS_QBV)
+		dev->hw_features |= NETIF_F_HW_TC;
+
 	dev->features = dev->hw_features;
 
 	/* Check RX Flow Filters support.
@@ -5345,7 +5349,7 @@ static const struct macb_config sama7g5_emac_config = {
 static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK |
-		MACB_CAPS_QUEUE_DISABLE,
+		MACB_CAPS_QUEUE_DISABLE, MACB_CAPS_QBV,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-- 
2.34.1


