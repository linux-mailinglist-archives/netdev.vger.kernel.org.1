Return-Path: <netdev+bounces-104004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6773690AD2E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DD7284D67
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED61953A4;
	Mon, 17 Jun 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="YNNWQ1Od"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A37194AC3;
	Mon, 17 Jun 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624474; cv=fail; b=lgB2qKEh1fIDJ1BQmuvrst89xc4LUAP+nbsRleEoohO2GDbX/TJgvfel4nFFmQFypUZ1A/DuHwWcpPvcwQ4nx3TO0tH9fAeZLYawKymCJdWy0rDrCnB0i1qLK+94X4AapxbdpU73R0SOFkZXvC1HfsZonql4TnsLvz0fR59Pfvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624474; c=relaxed/simple;
	bh=j5RHiRyDn4YoqPGIS5EwO1SiAI/OzzoJY2unS/fydVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vg2nqDU9TILzWLr7rwZDUT3Y7CJLnUXbCchQ4Tp/q9+RepKI3bCCj0ZsWOtjWyvvTLFpLS3nJAp4C+T2l+GYKRBzVVfNX4ot3UyksLpHi4TWtK/52UfFZby3NslOrIaE6UZ4WOwz9fqyvAsOiJljAdrPCoSAs2DBdUY5VKLF6RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=YNNWQ1Od; arc=fail smtp.client-ip=40.107.8.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFnfNPAaCX4HtDzi7x20mNVRhxaZSMcemYIqP8StN6qnqEy8V2jarqTNe9Zbo2kET9d9PqnhZExfREifFV/Du+E2SfErlIPQPjWNTUrrCbx0UGNqZGc0i1QO7oMdZFIVtq06kpupUEl9I96Ot26f5Ki2GmSKsUuiM5osPpM79b5bsoyk9WSHJ4EpcTojV6cTGAMTubs5E4KkPKZDMKGJdMEalCwx6LTkw/ao1O8bzRXpC8jQeuyyQ0hR3dOWqzlxADzv1SsFfQR/Ar6zagOiCQPijgUk3Q3HUFUpaeOYehEhes+l+FRj6k7Qf9WCnulzvHFxwV0UtXTPJXcmspqHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv95kUZfkB4FCQmhFRaDpXNt1sq/C5LMLkeRE0SgiJA=;
 b=od2E7aEcpci20HKEkQO9Hhkw47PWs7yvopszIoxJre8YptiN6MC4ocGvpw3/DJYq06YASuzYqXSCyym4Y0oWTftwseozIaOe2HtP4cfuc8e2JJeLM6UD2IYTJIxRiRTgncLYXVHIoJ8E1ib05hw8ahbwgEh7BFeITh2esNzBPtIZT9TQjoYIJ5kOS/Ro4Bi1yFYMMsBFduHRProQB1xYgrbymVtzxxqK1Dbrdc5IF6LzDa3c2PS9yRs5jObA0v4wMvT2KKGvJzXcYb1D+4Spv+Pm3sVWLdy/gpDo+/DRhLsuRTkhriNcQwYLm1iKFfSDqwJRRNKe2e4enLBOlk4acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv95kUZfkB4FCQmhFRaDpXNt1sq/C5LMLkeRE0SgiJA=;
 b=YNNWQ1OdHe2kzNQPffq86vTzWm4J7wMvR+D3iBeEI7mlCcAxsa3uphM+1fR+OOavHjaCG14o77yo4GB3UewRoaxKTA9ILKAZ00HWDQM2kFlDhsG1XXtxIHUJB5vu0GfMHVN664DyyQBjN/Ca0F7e717hlq2vScCzI9Z/pN5hql0=
Received: from AS9PR06CA0332.eurprd06.prod.outlook.com (2603:10a6:20b:466::11)
 by PA6PR02MB10850.eurprd02.prod.outlook.com (2603:10a6:102:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 11:41:07 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:466:cafe::7f) by AS9PR06CA0332.outlook.office365.com
 (2603:10a6:20b:466::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 11:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 11:41:06 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 13:41:05 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/4] net: phy: bcm54811: Add LRE registers definitions
Date: Mon, 17 Jun 2024 13:38:39 +0200
Message-ID: <20240617113841.3694934-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617113841.3694934-1-kamilh@axis.com>
References: <20240617113841.3694934-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|PA6PR02MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c093c0-9e52-44e0-7024-08dc8ec26017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzV5dnNER3JyWGF2bDVCK3lxWkhmWnc2NWlRTTFHNGpwVDl2OGNOQjV0VDdF?=
 =?utf-8?B?KzA2K0tiWVFic0tZOUJUT0ZUT2ZncDI5dkhyeDdRZmpQTEFVckJYNWJuR0ZM?=
 =?utf-8?B?d2ZVVVN2ZWViSUNBQTBld2lOSXBmWWtRckNlRUFldzhFRW45OENiclpEaUFy?=
 =?utf-8?B?eUUrdUwyMHZOcmRqWHkxVXU1eVN2eEdvbEZaZDlNVFJrVytiMTVrclBybkZq?=
 =?utf-8?B?Mm5CN0NDdC9vd0VNdzlsanNiWTdxbFMrN3c0bzI2UG91Q2owbXluN1YyKzFX?=
 =?utf-8?B?NmRZajg1b1docHA3eHY1ZWNCdjVsRFVzVVIxMDhYY29Ld1JzVHZSbk1kdlpP?=
 =?utf-8?B?dHNhaE85WFg5QzVScmhXeFl2WDhZT3JWcXhIMjUyMnhzZC9sTFUveG5BalJQ?=
 =?utf-8?B?OVcxSHVoSEIyVjNuOFU2N2U5RW0xQXlWY1YwcVdqcDBDazJnZ2RxVTQxUkIv?=
 =?utf-8?B?bEdWUjVkNWxnNWdpUFIrZnRhSE1MWEIvczZrOFFvb0hyaFJ0REExQldoSHp3?=
 =?utf-8?B?RXJ5c1M3b3JuY09JVjVLTVFDSmxnR3lCbVdBT2JuM2ZRMjUyWFJSRURNejNU?=
 =?utf-8?B?aC9ZNVNCeGpRL2tvN2xTS1ltb3dma2lLTkljZDVrUFg5V1IySzFWendlQ0pr?=
 =?utf-8?B?bVZLQ3dxTDU3N2VJaHdBWjlyeUplMUI0MTV5TG1iUHNoTy8rZVdYenBKSzdN?=
 =?utf-8?B?VTUvVGxJcWJ6K3NCYlYvalczaHZENzFtb2JMNXpjQU9GOE95RnRxcENjRkJP?=
 =?utf-8?B?eldZTlBRYnFxR1FhQlhOTnU0dW1Rc2ZRRURZbGRGbXBTN3Q0WFVyYTlTa3BT?=
 =?utf-8?B?OFdVZTEzTEIzanU3eit6QW1MWGQybGdTVE9aRVF5YTdFaW80Znp5Q25WbGdk?=
 =?utf-8?B?NG5HT3dlRjZJNFlGUlU2NVJSaytuOHkyNlR2eDV2bGZyekhEQTRvZ0cwUGpN?=
 =?utf-8?B?eHp3WEtpNkUraDJnQ1ROcUQrTDB1N01zNm9HbjR3RllQN1lrN05sTU81b2o3?=
 =?utf-8?B?THZGenpVckk4dGdjQTlTb1dVNzhnb21PNHBma29xOE5DNEgxaU8xcjNqTnls?=
 =?utf-8?B?R0o1VEJQZDhIb3QvSTFLMUJMVGxLeEVWMUl2OG9lZzJ3Skk5dFd0cjBkNkNv?=
 =?utf-8?B?WGVPeXZZTTBrZyt1NlJNY2ZMMGQzV0l2VGVzTGR3cVNVTzlDSkNML2ZLQmpw?=
 =?utf-8?B?SWlKWFgwN0svRDNjMmF0a25EdzhCN2k2MHJLZ0ZoZ1lwZHdVRHYwTEV6SnpW?=
 =?utf-8?B?TDlPaGExb0VvNjJITXVRL3RVTWVMRDZKdTVoRTdJbFVsM2xSK1Q3QU9iK3JO?=
 =?utf-8?B?ZEQ0cFlkZEQxMWdwSERpSzhIQVlNdUI3ZkV0Q3ptYjQvSXJYUGJKOEdmTnlU?=
 =?utf-8?B?bHhDWFByVEVEd013N1NTMUpMTnFRVjUyQU5xZzZoVzVCU1VCVjkvWlIzM3VU?=
 =?utf-8?B?YWtYMnp4M0w1YjMzMlpLNWRCSmpaNE1kTHZic0tVNWIxTDFuZGZGU3V5dEtK?=
 =?utf-8?B?MlV3SG9zYk55OVo1dzlBSlJqQ1NHNUpBMnZ2Z0RjUk1hb1cvZzB0dHh5ckli?=
 =?utf-8?B?ZkM1V2N6UHpNYWdHQmI0c1lPYVRmYmVnZVppUVI0TVJDZmFmRUtvTWRXUXhE?=
 =?utf-8?B?Z0VOS1N2OElZUHp3RktIdy9maDYxWlBYTDg2Ryt2RmZEN09UY0l4MWYwa3ZO?=
 =?utf-8?B?Q0REbkRoQTRLalRqdkxidUdlaVFqcG1mYmNodVFwOUNMTzl5WDZsMDRyeDdi?=
 =?utf-8?B?bGh6c2RyQ0VDMmlPM2pUT05TTjE2U1BjcmdwMGZwZklHTE9BTXgxK1lZbDFW?=
 =?utf-8?B?eHZ5UGcrMDlSTlMvSWRqbWtnTEhaYldVNXNPM2VyN2xiNnR6T09LSG81OFhO?=
 =?utf-8?B?QVhiRnZHNlpkenZMSTAyWW5GL3lpWkVVa012bEorbUpBUHd0UDhZZ3V6N3FT?=
 =?utf-8?Q?HO3kGJfkNCA=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 11:41:06.6247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c093c0-9e52-44e0-7024-08dc8ec26017
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10850

Add the definitions of LRE registers for Broadcom BCM5481x PHY

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 include/linux/brcmphy.h | 89 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 1394ba302367..ae39c33e4086 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -270,6 +270,86 @@
 #define BCM5482_SSD_SGMII_SLAVE		0x15	/* SGMII Slave Register */
 #define BCM5482_SSD_SGMII_SLAVE_EN	0x0002	/* Slave mode enable */
 #define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
+#define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
+
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
 
 /* BCM54810 Registers */
 #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x90)
@@ -277,6 +357,15 @@
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


