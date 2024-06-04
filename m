Return-Path: <netdev+bounces-100591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3A8FB3F9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04859B28368
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C06148847;
	Tue,  4 Jun 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="L1waOaEa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2064.outbound.protection.outlook.com [40.107.7.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73770148315;
	Tue,  4 Jun 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508245; cv=fail; b=exN0JG6PjIlmX4YBV+sAbk518KXM5BiBu+nMvddUfLCsne83Ecx/QtDjW6pf0y/R8mxr0ZSjQaaqX83fO5K3aWp8/o9NmpfzaUWrQGZOfoBydirltMOYzzaxQof/4atjQ+SshSvW7YN/eHeYjQMMwZbY8T1gFgT5LSQ+A4182mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508245; c=relaxed/simple;
	bh=cptz0IRnup62E0/a4VROp5kRGBymby/FqRfLJeMoidA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5pkZ4LR6OyLuAYycodyuDj6ZyZJ8fgPMNPOYlZuuZT1aJksg5e5bH44G5QzV7vQClomM5CqcewalviMH2YrGIh53VwD1Q1Vrac+ci7wbxEGjqGPJuY3QFYc0rea88Q4u5kimquTe/YRSs9o168tKEE++ZQkiO2+aRn00La8yLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=L1waOaEa; arc=fail smtp.client-ip=40.107.7.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YanvNYrKcA+m6ynZj+QkfYVRLRwGGWs/rAGUD+K9Y0xPXy9jzJMCyYvg9g3jEUvKPv3gD6MLVyUGXDoYOi/HR859jumpVTWlqArLEj5QL07ZfvaPTtl804ZyWc2e15g09oCgBzyrk7dgvZ5K7aAhulsb7cwU0uerVNxen4lSAeus+YvTxKGYjwYmZSKSMMhanTy60K6WM1weK8X67v4pCZOBpGaav8lHgd1qpDljDH412Is4va1cxEBLll68wKU9+UIf0Epu0oA/4IB8dYwuJM4csOWOn9fb3Cpd581YR9synBlzAQDQwkFkCglH6E1V4SqI82bYbHsoJpnR3KFBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1N5IVWmATDtB8x7sZDsKo2B71+DChFJfe1pnJHfUnM=;
 b=diJYziROft5NxA8tzxNovSH9a0D/eDCAW2NS5x8I52rGRTiKc3jXN/dgO/15NW86QXiywz8xPr8ffCfZGIUtHnltS5BaevQiZ85mt6rwCLx9YsM/0Uu2IXgf8FD2Mwdg4qjOitA6SvanFlnLWrT5vKuiAt1NtVupEG0oBB/Pp3TgmlnglGdNXCoVyZ/d9OPahMeUCpohq6HIqvUDSwZx3wwzro37q8JaSkvtnWjqdZrI2fs8Op5V8GW6Ag6yIjpbYIqOw/VXnjKKHV0oWfqCP0qQ8MAwDKPC0DyvGYI7JvErBOMXIl+qaNB6tgN6L/EgFkm70ZGoutxaqIGbpAaDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1N5IVWmATDtB8x7sZDsKo2B71+DChFJfe1pnJHfUnM=;
 b=L1waOaEagOPMPhY17wp/vGe0p31/KN+w2XYlZZK9lerNHI/y68TrzxaU0NYHI1kjt9u7UbJxTWUcNXf+CpX5WNH4XHcX0OPYguf+xAeIl/zUiv41wDmnY/RVIyzRrlz7UFOYjnWPzxgJ0hLG4DBApMO1eOs8+peyYOONQ6xwJb0=
Received: from AM6P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::43)
 by DB3PR0202MB9227.eurprd02.prod.outlook.com (2603:10a6:10:431::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 13:37:18 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:209:8b:cafe::b2) by AM6P191CA0030.outlook.office365.com
 (2603:10a6:209:8b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 13:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 13:37:18 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Jun
 2024 15:37:17 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] net: phy: bcm54811: Add LRE registers definitions
Date: Tue, 4 Jun 2024 15:36:53 +0200
Message-ID: <20240604133654.2626813-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604133654.2626813-1-kamilh@axis.com>
References: <20240604133654.2626813-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|DB3PR0202MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: d766e872-b653-462c-c472-08dc849b7448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmFrLzErY3QxcC9WSHBoYXcvMUF4YUI1Q2tBb0tNV01UempXa1RibjdIcFdq?=
 =?utf-8?B?K0RzalRxU3FONlhrR1ViK3JJK0dyOTZVYmhKaFRWdTBMMUF3WXc3elBzQmRa?=
 =?utf-8?B?aFpvd2NOc2RjSldQSkN1VGhVWWxpSWJud1ozcVVnQlBybWVQdTE3eG5reHV0?=
 =?utf-8?B?WEtiNFFlWlNQbnF2akdXcDhlT0habWdNY2t2THlDRWFxM21kNUc5MGJLYlQ4?=
 =?utf-8?B?akY0ZzIyTW5hN3NyRDNSQnhoR21ySkxzbUM2U1BOOVFIZlZ6T0FOZzUvTjFE?=
 =?utf-8?B?NXlBbldKRHk2bE5ncHFPaUNsUmE5VlRIZFNuc1JhOC9HcFlDSitpTThON2Fr?=
 =?utf-8?B?NTN3WmVRcmU0a29weEZWbmJuQUVjUnZLUWVneVlnL1UwTFhKU3JNYXFXUndQ?=
 =?utf-8?B?aktCL0IxNEdKUFhaUElQUndRTWNIcU0xSlN0UHJydjZaRHFNSm80bUptZEVs?=
 =?utf-8?B?T3ZPVUxCcHpQdkRvN3diU1pFa3RoSFo0NG5wbkNKZmNWZDMxZ21zd21uSjJU?=
 =?utf-8?B?ZnpyelJQWGJpZVZzM0VKL1FNTVA5U3JSSzdDc21YTldoTFNXcUFENTJ4blZG?=
 =?utf-8?B?QlFNMjNJb3pPSkljbkFBZ1dJWkphSmhMOVNKdkFhN2d4bFcybmtFclo4OXlM?=
 =?utf-8?B?aFU2T2FJSzRVWnZ2QTgvbHdHSUNCWTYzLzlDNHVzZVQxZTVSeE5VaUFuU3BX?=
 =?utf-8?B?Z0FPeWdNQXNFVi9IUS83cDVZc0tRNjJidHhKekZMN0lFM0JCdUV4Ym5TUHVo?=
 =?utf-8?B?M3lvSTVWdlMvVHNKV0VkRXNpK1VjODZIOUdkOEVlSjBkQzFHbmVoUzJFaURK?=
 =?utf-8?B?UVgyR3NkWWE2NkVWdlJqWk90MHBHSnpjN3FEQUZKTlVRcTc3M1dyczBHWVB2?=
 =?utf-8?B?bm16S2JqR1phbEhKaExOL0VzNmVvTzNERWpmNC82Y3diUlcrMC9sa1NDTkpG?=
 =?utf-8?B?bWtNVTMxQTU4WHBzclRjVURsSm1GbWx3SjExelN2bE93T25TWDRUaGtrdUZP?=
 =?utf-8?B?SVpoU2FDMzNTZFB1SGdJcGllZ29jRGtBSlRDL2FLcStpdUVITnJSQmlZUVMv?=
 =?utf-8?B?WmJrc3JNOXozSndtSVJVNHRUV2JPMm1sa05jTFhEQ1NsamFyY1ZFT0tVMk80?=
 =?utf-8?B?MCt1bzdWcHZyK3VCbklBeXhSQWZnWlZaVkpBRlRDdytwUmduL0J4UjlOWkdX?=
 =?utf-8?B?Q2xtZVJ1dWFhYy81TE9hK0NPQTIzNWFFTW5CWG5DWVY0MU5qa2tWd2d3Slln?=
 =?utf-8?B?bUx4aEVrZDlVQk1jSzh5UGdOYlgrVGxmSkgrdUl4ekttTG1Od2RCSTVPaDhP?=
 =?utf-8?B?VGJRYnNCTnBZYW56NjEzOTRjQ0hVQWVZclhUMmc0VW5TLzdLWUFjWUNBRG1l?=
 =?utf-8?B?dVZ5MzMvQTQwaVJ2Zm9aSVlRanA0K2g0clY2THBZQ1RiaWJNbHl2VTZsdFlx?=
 =?utf-8?B?bzZZSVhJRk9UeCt1YjRoZ2RKWHM2cXBuVUZVNmEza0l6VDUxNjA0ZHFER3FH?=
 =?utf-8?B?VDRrKzdReGdWSVBJTHdxeWJZTmtrZkZPVDBROW9FL3JGbVJOYjUrOS9CcWZ1?=
 =?utf-8?B?cTYzMENtdjlta1pTVVdIdlNiN1RiRnVlSmdoQnVvclB0U3o5UFhoUDVRT2FO?=
 =?utf-8?B?VWpCcjFHaTgrZ0h1VFB5eWxEOURPMGR6ZmN4TjdHU3l4K21HWmZDbkJDdVN4?=
 =?utf-8?B?citnMlF0RllNbWhUQUxoNzFaZmtaY3pHOE0vWm5ZcTJVU0w4dXphWEFkc3Bv?=
 =?utf-8?B?b3VzRVJWUi8zQXhLNndCc0tsYjZsUTFnR2VLK2tCbUE0WTB0aVprQloyNFhp?=
 =?utf-8?B?WDJJYklPRXliRTJMRkhIeHg3cndpM2xPcUg3RExzUmJ4TEFMVjhBUjcrOGNF?=
 =?utf-8?B?SHQ2Z29aMWU3c1hrVGd3djNiRlBwajdlNWhvZExkaEpiWnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:37:18.5022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d766e872-b653-462c-c472-08dc849b7448
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9227

Add the definitions of LRE registers for Broadcom BCM5481x PHY

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 include/linux/brcmphy.h | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 1394ba302367..1b02e1014583 100644
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
-- 
2.39.2


