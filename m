Return-Path: <netdev+bounces-109233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409B69277BA
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD6F286A1F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB421B013E;
	Thu,  4 Jul 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Uci2rd/b"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70441B0100;
	Thu,  4 Jul 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101899; cv=fail; b=jrR9cfE7QtBmnVtdy99qECl+QZgd1V4m4JKt3TtT3Z158H3iJ9jhUHuv5OBj6UVKVsKd0TH6ZulB6WRPuUms+FSEYElypo2NR9ED8fA7uiZqbWKUx7M7be/V+Tmyx6EDdXY8ZhTynMJXNWRFSFBx8f3QA4PcSsXmsWCGCwA7j68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101899; c=relaxed/simple;
	bh=nW5o9jacrjPWOuxhoPe08F5HjFKbOisKW55vInEX5jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aG4wm9hEnN5y5KZOSN1H8uryHipyM7LpmTydqHVWT9f1e5DAOFjTlOWnfJq6/y4lcgMt0ndm0RYuaWdq8+He8m9ypW8N8rcr3fevzk9e8509mCjtxRthwp5O8ImgjWt3fH3e4gXn9cEASY7nRfebX+Ox3SsVk0kNMyc5+yLqevc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Uci2rd/b; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZJLORXRP7Bm3+5NjkMEGVCTIVc2aJfER/4xlJoHpsO4cpX12MO5k4HSadmdmD0hSGtyZW2uycaP0RoM6KnZYvjH0F9h3kl8QOBpykruLYdbU77QDtpEiMnIQpYeQIFOg3DUXNK/XNmnACkTwDP9ssxd0Y08Lb0L1DfwLOb/bFh8tnRoU2vOXwao7blTgnH6c8DKr/9+VJ6KZUOtBLtvV+VQ4cXLZBnjc3qFuwp+szkMkhbet1VCuvCWMnA7cGJiXrRU5E47nNr2iq1K08E14QVKS6oSmUgHwJhAKuCKU5PCbg68aLeo+WDTfDf4UK8/yD69agaWFCNVamFpz6Cn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ggROmr7pEozEH/Ekc4IbP5so+Dk1/2A8pLpDjNwcBs=;
 b=bNF4xiJBw0/+aZubC/RXmf6yZW/ef+YNCrq3i6rEEbQEA3JDupdj9sWRggMxsjWCzsunEhJoDVlTBxuwueQIK4pqo6luxgzgVx0E/fm9U6EESkMkKucZTYwdwr+tiGe2HgjnVMwwk+HULVoHSANcnbVMRDVzoa+F8HJ7PcwErzPx5mcb33MTQ3qLtrsbKYAO0ayfJkJJKc9fObix6M0xPJ0nFkHkr0yPaCp3tpdU5dzyxMeDYeBzhGgoA6obnZIBLmvOgl1i/MNfX22CClWi+5CGCSxQKXpwX1XZRtxzwbCbxLQ+g3lphcvFtjw3VQ+jzdKzWv0LiYidn8MEk5tmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ggROmr7pEozEH/Ekc4IbP5so+Dk1/2A8pLpDjNwcBs=;
 b=Uci2rd/bYTJTyEhaY+NcPQq4Nhv28FhTJp88Jt1vUyaSSvu/EkWE1HGaES03OI1lG8klDKTNV11FDqdmViW4JChIxnkuszsvkbAg/pHWydjLvEOhhuN9vfbN9vyoA7f/p5de4Jxcz96NtyFKWUqq3tFPIbLvDQhXizjgzm0bV/c=
Received: from DBBPR09CA0025.eurprd09.prod.outlook.com (2603:10a6:10:d4::13)
 by AS1PR02MB7845.eurprd02.prod.outlook.com (2603:10a6:20b:4ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Thu, 4 Jul
 2024 14:04:54 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::1a) by DBBPR09CA0025.outlook.office365.com
 (2603:10a6:10:d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27 via Frontend
 Transport; Thu, 4 Jul 2024 14:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 14:04:53 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 16:04:52 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/4] net: phy: bcm54811: Add LRE registers definitions
Date: Thu, 4 Jul 2024 16:04:11 +0200
Message-ID: <20240704140413.2797199-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704140413.2797199-1-kamilh@axis.com>
References: <20240704140413.2797199-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|AS1PR02MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d04e630-b0c4-4a08-c4c9-08dc9c324746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zit6ZHhGU2tCL1NwelhRYTJ1UitPNG9MV21oVkhIUmFkSmRJQ1JmUEN5MU9n?=
 =?utf-8?B?UE9FSVJCNCtiRTI3b3dDUVpuZlVZa0EwZERPdjhGUFFkZGJ5Qjd0V1BtdGxx?=
 =?utf-8?B?M1pyK1NLNVp1TDVCUkxCMkEzWk1mYklwMzRDNFczWm13UHpSU3RFaXBRbTBl?=
 =?utf-8?B?cmtzdy9pTEoyNFpsR1UyQWZxSkZoeVpaR2l4cnFRTis5djhJekU1eVNWT3NN?=
 =?utf-8?B?L3FaZUlPOFlPeUU4aUZYNEhGWjVvSjdyYjdabDVIMzhnbzVLZGF3QlpsWjVZ?=
 =?utf-8?B?OHNiYnBIOTZPZldnWnJZdGR1Y0JkazRlMGY3TTBJWUxpbFM3ampHdmtWblBl?=
 =?utf-8?B?OTg4ejJTSzNic3BMWktXNi9ZcmNvdWtqMXAzTTVBZUs1RWZ5c0VXc3BvU3RX?=
 =?utf-8?B?MjIwdUNiNWd4UlFNWmxhcHFCZkIyd0R1OUh3elM0UzhORzVZR2lqZm5BaXpm?=
 =?utf-8?B?VTZHeTVJbVQ1UU9uT1l6WDdaNjQ4L0lOMFRKWjJUY1RBVVRUMmlDMDd3djN5?=
 =?utf-8?B?WGpBVWpJMk5MY2g1bTgxeTBNRk9ONldGTlVtNmxxUm11eFFuRTl3ZDNNM2VP?=
 =?utf-8?B?Qms5U2JFeHVQaFBHUis4QzhiMFBCdEYwV1drRlNiblV4RmJ6V0RpTHVqSHhP?=
 =?utf-8?B?SElhenUyQXV0U254VUpDWS9lQmVoTGdQYjYzSENVTkIxMThmdnBMVU1QMTJY?=
 =?utf-8?B?QXNBZkdIZU44d3oySzUvZXN2anJYYkJzM3RvYk9pa1B3VTE3dEs0c3g3T0ZS?=
 =?utf-8?B?WXN4WXVJR05XMy9aRFJ2MC85Z2NvclU1eWUyOHVjSVdzdDhjMm9kOVNQYlRl?=
 =?utf-8?B?RFhNSWF0VE9vR2djM0YySUJITzB2aUNibjl0emk1RzdaQkJKVGtSeEl0T1Bz?=
 =?utf-8?B?bUZUMWhKTkxnYWxVd2lWaFQ2SkVoRzY0b1BvSTdmdXN6dnhWTEF3czlWSVJr?=
 =?utf-8?B?WWowaGJZNXJZRlQ1RlhNYSswUXEyY0dSZldGbHNMZGtSd0dDSzFWdXhzdG9i?=
 =?utf-8?B?Rlk2U1RBbFQzUUNCaVhWN2hvb0VzYmR4SS9icmhrTGRQN2dobm1WbHhkb1p5?=
 =?utf-8?B?YWhBb21rR2h4TS9WaVNudWdDRXJjd2hlSHlPMURUVGxMMSs5Z3BOYm1rV1pR?=
 =?utf-8?B?UHczSTJmTFFSZ1dJV2h6SkxoK21rTXBUMlZwKzVwSEh3cjhTL0FKNTZnM1dI?=
 =?utf-8?B?NzBNMmRzOGlUVTRJR0NtUVVzaEdwT3MrZ0Q2eDBQTXJYbE13c0dsZk4xUnRG?=
 =?utf-8?B?TFlSVS9hejBUOG1hN2hZZWlnSmZJR2huRHJreStJYlRYenR4VG9RM2dVSUxC?=
 =?utf-8?B?MW9yRXpzNml4ZUp4ck1rZGZlMEJUUVpnNHJtRUlXdUdLOG9KN3Bnb2NFQkJH?=
 =?utf-8?B?emlVV0FUU0tidSs3NElhWWF3bUkxajNpK2UxYnc1cGFHVHlmMEJ1RHMyM29l?=
 =?utf-8?B?N0hFWDlHQVFIWk9nL0VBbzY1K2c1YTdCd0RsUmNCbW1hYkFGa0xpcENXRWh3?=
 =?utf-8?B?MFJ4RE1VZlZVM3RlVWk2UWx1elpVemJxdW5ZQXhISVh5L2RhQTZMbkw3dytx?=
 =?utf-8?B?azg0clBoYytwNXdIYVNDRFREYzFwMUs4WkV2Yk1kUXIzc2hnV2RDRFZYckV2?=
 =?utf-8?B?cEI4V2ltU1NqN0RjeHBidHM3TmJvOUU2R1h6MUhEV0dFTkNEZHhaaWZ6VUp6?=
 =?utf-8?B?RFA5a3ViRnVxUVNqVWFTM1JhZUpZcldIbzBWcHNHSGNqUVRuYm9JTTFQUkNr?=
 =?utf-8?B?MG0rZWJkeHNXaVRtWVBOTXlRdHBoamRhUGdtYkM5M0JETk05ekVLeGhZSllU?=
 =?utf-8?B?ZmRzL0RqdU1wOWQ5UXFiTDhoY0Nsb25sMkRFaGVqRHNIeWduNDllMytjY3JF?=
 =?utf-8?B?VGtNdGtXQ2x4SHpDelRHblZTbWlhM3JoaitIZ3BWakJYR2ZZa24rdVdUd01S?=
 =?utf-8?B?bTc3WENrZ0hrbnFWcFROUFltOGU2blFCVUlJbnJFQXZzaURkNk1MSjY5UWg5?=
 =?utf-8?B?NHJBMlIxbW9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:04:53.6948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d04e630-b0c4-4a08-c4c9-08dc9c324746
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB7845

Add the definitions of LRE registers for Broadcom BCM5481x PHY

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 include/linux/brcmphy.h | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 1394ba302367..028b3e00378e 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -271,12 +271,100 @@
 #define BCM5482_SSD_SGMII_SLAVE_EN	0x0002	/* Slave mode enable */
 #define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
 
+/* BroadR-Reach LRE Registers. */
+#define MII_BCM54XX_LRECR		0x00	/* LRE Control Register                    */
+#define MII_BCM54XX_LRESR		0x01	/* LRE Status Register                     */
+#define MII_BCM54XX_LREPHYSID1		0x02	/* LRE PHYS ID 1                           */
+#define MII_BCM54XX_LREPHYSID2		0x03	/* LRE PHYS ID 2                           */
+#define MII_BCM54XX_LREANAA		0x04	/* LDS Auto-Negotiation Advertised Ability */
+#define MII_BCM54XX_LREANAC		0x05	/* LDS Auto-Negotiation Advertised Control */
+#define MII_BCM54XX_LREANPT		0x06	/* LDS Ability Next Page Transmit          */
+#define MII_BCM54XX_LRELPA		0x07	/* LDS Link Partner Ability                */
+#define MII_BCM54XX_LRELPNPM		0x08	/* LDS Link Partner Next Page Message      */
+#define MII_BCM54XX_LRELPNPC		0x09	/* LDS Link Partner Next Page Control      */
+#define MII_BCM54XX_LRELDSE		0x0a	/* LDS Expansion Register                  */
+#define MII_BCM54XX_LREES		0x0f	/* LRE Extended Status                     */
+
+/* LRE control register. */
+#define LRECR_RESET			0x8000	/* Reset to default state      */
+#define LRECR_LOOPBACK			0x4000	/* Internal Loopback           */
+#define LRECR_LDSRES			0x2000	/* Restart LDS Process         */
+#define LRECR_LDSEN			0x1000	/* LDS Enable                  */
+#define LRECR_PDOWN			0x0800	/* Enable low power state      */
+#define LRECR_ISOLATE			0x0400	/* Isolate data paths from MII */
+#define LRECR_SPEED100			0x0200	/* Select 100 Mbps             */
+#define LRECR_SPEED10			0x0000	/* Select 10 Mbps              */
+#define LRECR_4PAIRS			0x0020	/* Select 4 Pairs              */
+#define LRECR_2PAIRS			0x0010	/* Select 2 Pairs              */
+#define LRECR_1PAIR			0x0000	/* Select 1 Pair               */
+#define LRECR_MASTER			0x0008	/* Force Master when LDS disabled */
+#define LRECR_SLAVE			0x0000	/* Force Slave when LDS disabled  */
+
+/* LRE status register. */
+#define LRESR_100_1PAIR			0x2000	/* Can do 100Mbps 1 Pair       */
+#define LRESR_100_4PAIR			0x1000	/* Can do 100Mbps 4 Pairs      */
+#define LRESR_100_2PAIR			0x0800	/* Can do 100Mbps 2 Pairs      */
+#define LRESR_10_2PAIR			0x0400	/* Can do 10Mbps 2 Pairs       */
+#define LRESR_10_1PAIR			0x0200	/* Can do 10Mbps 1 Pair        */
+#define LRESR_ESTATEN			0x0100	/* Extended Status in R15      */
+#define LRESR_RESV			0x0080	/* Unused...                   */
+#define LRESR_MFPS			0x0040	/* Can suppress Management Frames Preamble */
+#define LRESR_LDSCOMPLETE		0x0020	/* LDS Auto-negotiation complete */
+#define LRESR_8023			0x0010	/* Has IEEE 802.3 Support      */
+#define LRESR_LDSABILITY		0x0008	/* LDS auto-negotiation capable */
+#define LRESR_LSTATUS			0x0004	/* Link status                 */
+#define LRESR_JCD			0x0002	/* Jabber detected             */
+#define LRESR_ERCAP			0x0001	/* Ext-reg capability          */
+
+/* LDS Auto-Negotiation Advertised Ability. */
+#define LREANAA_PAUSE_ASYM		0x8000	/* Can pause asymmetrically    */
+#define LREANAA_PAUSE			0x4000	/* Can pause                   */
+#define LREANAA_100_1PAIR		0x0020	/* Can do 100Mbps 1 Pair       */
+#define LREANAA_100_4PAIR		0x0010	/* Can do 100Mbps 4 Pair       */
+#define LREANAA_100_2PAIR		0x0008	/* Can do 100Mbps 2 Pair       */
+#define LREANAA_10_2PAIR		0x0004	/* Can do 10Mbps 2 Pair        */
+#define LREANAA_10_1PAIR		0x0002	/* Can do 10Mbps 1 Pair        */
+
+#define LRE_ADVERTISE_FULL		(LREANAA_100_1PAIR | LREANAA_100_4PAIR | \
+					 LREANAA_100_2PAIR | LREANAA_10_2PAIR | \
+					 LREANAA_10_1PAIR)
+
+#define LRE_ADVERTISE_ALL		LRE_ADVERTISE_FULL
+
+/* LDS Link Partner Ability. */
+#define LRELPA_PAUSE_ASYM		0x8000	/* Supports asymmetric pause   */
+#define LRELPA_PAUSE			0x4000	/* Supports pause capability   */
+#define LRELPA_100_1PAIR		0x0020	/* 100Mbps 1 Pair capable      */
+#define LRELPA_100_4PAIR		0x0010	/* 100Mbps 4 Pair capable      */
+#define LRELPA_100_2PAIR		0x0008	/* 100Mbps 2 Pair capable      */
+#define LRELPA_10_2PAIR			0x0004	/* 10Mbps 2 Pair capable       */
+#define LRELPA_10_1PAIR			0x0002	/* 10Mbps 1 Pair capable       */
+
+/* LDS Expansion register. */
+#define LDSE_DOWNGRADE			0x8000	/* Can do LDS Speed Downgrade  */
+#define LDSE_MASTER			0x4000	/* Master / Slave              */
+#define LDSE_PAIRS_MASK			0x3000	/* Pair Count Mask             */
+#define LDSE_PAIRS_SHIFT		12
+#define LDSE_4PAIRS			(2 << LDSE_PAIRS_SHIFT)	/* 4 Pairs Connection */
+#define LDSE_2PAIRS			(1 << LDSE_PAIRS_SHIFT)	/* 2 Pairs Connection */
+#define LDSE_1PAIR			(0 << LDSE_PAIRS_SHIFT)	/* 1 Pair  Connection */
+#define LDSE_CABLEN_MASK		0x0FFF	/* Cable Length Mask           */
+
 /* BCM54810 Registers */
 #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x90)
 #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN	(1 << 0)
 #define BCM54810_SHD_CLK_CTL			0x3
 #define BCM54810_SHD_CLK_CTL_GTXCLK_EN		(1 << 9)
 
+/* BCM54811 Registers */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x9A)
+/* Access Control Override Enable */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN		BIT(15)
+/* Access Control Override Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL	BIT(14)
+/* Access Control Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_VAL		BIT(13)
+
 /* BCM54612E Registers */
 #define BCM54612E_EXP_SPARE0		(MII_BCM54XX_EXP_SEL_ETC + 0x34)
 #define BCM54612E_LED4_CLK125OUT_EN	(1 << 1)
-- 
2.39.2


