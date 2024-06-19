Return-Path: <netdev+bounces-104913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C090F1A1
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380AA1C21F8F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA414F9E5;
	Wed, 19 Jun 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TwdzMNuM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF56FA8;
	Wed, 19 Jun 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809473; cv=fail; b=m/XcUmOMOTPC8ybTTw4gpHg+rkvVb754JBhjOnqlDSTVaslDGzPj5gHU/TDMwsvp4BZoAEhnd+q+oOIRcrtaOxkHu1igge8SmeeVLchTg2bozJFv1icsa0vs1B8MsS9xl1dwFW0qvKzzDL5WnH9cyOngCrt+9UApMWUsfld2KnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809473; c=relaxed/simple;
	bh=j5RHiRyDn4YoqPGIS5EwO1SiAI/OzzoJY2unS/fydVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ho1GsUD5TMgsKWQUBcvi5KIimFm/wnKiVa3S/9KYwxVkJ2t+5IFkisDVz0r8GR8Vw4YOE3dkQi1UY81KfCbmFqTO2YSx+5/8WU6wgCqI3fm1xOCIi2HvLctu6XlBZjCBqrmkqWTZu0PdZe0PRY4FYpQcLbddvashsTM7UGpGI08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TwdzMNuM; arc=fail smtp.client-ip=40.107.249.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMW6yw86iypx95K5IA50wzrYQTtcDNCfWiZBJbULt5Zci52rHStoC6m4OAoqMd7oJLC15JwIYMZTHIf7OQHWfGn4opoEqvXl+NhFRZR4fZwYu+pACf71Q9afQM1CzrVa+vYSWUZ3yxaDq5wAue1Th4KOj0T+Py0qZfDfh0fPbL3cibVJfXaUoTBE3TrW8+ltqIFulqWxkHU5jGI+uec4sOWtZ/BqWWegbT4iXjhNMcgraH0YWvVfvt8fXa0zKu/VZebPtlQyou8ZcpK+eugPiu5+JxH9DEBvOw4xgR70rrtCUBuW5kImuHH8LFwWBKs4V0TQyfU0VpQ79LJm59U9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv95kUZfkB4FCQmhFRaDpXNt1sq/C5LMLkeRE0SgiJA=;
 b=hQB96VJnclPA7uZYzmP3HQ+IRM6JDYOfAEioQdZv92VQf/mqie/TBL2gBDr+cb/fMsyySU4ormeTeOwj1Q1vfcmqSxwNGe//rO9lqx63PzK97c18Q9JjvyAvYGtl/W0slWRjV6v5mG3Bx+ZyUlGtCD+qVFZcaHziUrpidJnF1OAYE/pA0PEt3daOY9q+gJsRA/uQ2wuzD6My62e9uFOyRYIYVcbzs/Qr4/fpQOSQI4alF8b0MS++bRKlm0B9ZhODTLF63LhmcBXh/qXx0DbR9fXuyH447lxs2BscjGD2aI6UciLzwfmDh/I/RTv/Cv7YcIZfFBij1ND9L+UfrPu9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv95kUZfkB4FCQmhFRaDpXNt1sq/C5LMLkeRE0SgiJA=;
 b=TwdzMNuM/zH8a03dC2ObST1KsT71VuldV48Utjyr7hVWojeKq+OzcGYWEv+IlyXvtbxntL06sWSW8jqoNM1uM/muOn/9nZ7o7CTTARr6Gj6QC9ynJlQPuea8ee890E0sV3iWCNunk/CFDHjKFnPzQ/roLjliuktgfdz5dk4urhk=
Received: from AM0PR02CA0222.eurprd02.prod.outlook.com (2603:10a6:20b:28f::29)
 by AS8PR02MB6677.eurprd02.prod.outlook.com (2603:10a6:20b:25a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 15:04:26 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::64) by AM0PR02CA0222.outlook.office365.com
 (2603:10a6:20b:28f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 15:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:04:26 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 17:04:24 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/4] net: phy: bcm54811: Add LRE registers definitions
Date: Wed, 19 Jun 2024 17:03:57 +0200
Message-ID: <20240619150359.311459-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619150359.311459-1-kamilh@axis.com>
References: <20240619150359.311459-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|AS8PR02MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 96904915-9def-42ba-8070-08dc90711ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1F5RjJIR21VckpwbGRFZThQTjRHWVRiY2EyQnFkbXZ1eC9TKzY1OWdmMTFQ?=
 =?utf-8?B?a1lHbmVFQzM0cGF1aHVjRDVROEFYK0R3Ymx4K3YwKzRaUU4zdS9vUFB3Mmxj?=
 =?utf-8?B?aU9nYUZCVzJRb3hEZEZXWnpZblkyMlpSUEFlbVkwVVpDL2IrTEE1ckI0aC9R?=
 =?utf-8?B?QmFacSsvanV6dGhCUG9kak1DditZYlMyanp4azZXeEpJQnFzamJqTWczLzQv?=
 =?utf-8?B?ZDNqM3F3RStyMDRHL2UwTE9qMER3bXlUMnE3UitpUjVIZXJEd0tiMWVuU01H?=
 =?utf-8?B?RVp4V2lUM0VaSXVUcWxUYmcwbWxXTlBUWFBwM25LQW5kVUIrVzNhL01aeEx0?=
 =?utf-8?B?bXJFVVZFYTdLMmxtemZCZGZkWTZYSmVrdVFuc1NKWkY2SlZuQWJqdWh0M2Y5?=
 =?utf-8?B?QXhPSXV1R2xCWThzcDVkOWVyS1JEQU1OM0hBV2RLbVBnNkpqREIxWjhsNkhQ?=
 =?utf-8?B?U2NweU80WEllVXdXNm1BREhLUzlydWdDc2RBdmg0dFZHUmM4d2I2aWNWNCtO?=
 =?utf-8?B?WVU0RmNUaU1xd1M3L2c0V09NUWNWZmdzNjBJZCtmdnQzTi9md0t3TS8yVzNq?=
 =?utf-8?B?SGFNWWVma1BZMk1mcENoUTYvZDA5OTlQWHFvb1BMWHRkeE1WNkRxV1VwY1RL?=
 =?utf-8?B?SlVzSGkydjhnTzJGTmFhQUZMWmc2TU1ldmJkL0RBZHdGOU9XS0t0Q1lpYnVo?=
 =?utf-8?B?M1FhTFlkNVFNSkVRNXdkMFpjNittUGRIVHMydkJ0Nng1eUk2cVVyRDlvQk56?=
 =?utf-8?B?dGx0bzZtWHNUMUswdHVVSld5a3hiR25VS1AwaC9UM0dQUDgzcXlpYmF5cEd4?=
 =?utf-8?B?QWZaT281MlQrR1A2TkpyTE1aTWJISURwbzFJUVZrOVJWUlV4cXFLWXdqQk9F?=
 =?utf-8?B?QXoza3BLOFFqV0JhUWdBeWJPc1F0TGIvNHpMdjZjcTZENFM0UHdMekN0aU5j?=
 =?utf-8?B?Y3dTOVdJMTdjOEF5aEZDb0RBUWxvaWxmcmZCbmlTaFk3M0U3b2VTUGZ4NU14?=
 =?utf-8?B?T3dMek9RQTJCQzloblVEbzlNYWR3Rms2OTc0UnJGVzJEYWZEMU9HYURsQkhI?=
 =?utf-8?B?SndmNXBYZytOMlpSTmp1QkZDRHdxWUFIa2w5ZTNxOSszTk5aNnhjbENlR0V1?=
 =?utf-8?B?TzU0TnpDVVdSUmhMajN1ck9DTHBYMHFyUk1MTkplSkYyeG9GODVKdjNmZE5F?=
 =?utf-8?B?eWlkVnRPSm1CMVpHZU5pK3BPRGJ1amk3MVVGWjRCYXMzRUd4KzRsNmVkV1Nz?=
 =?utf-8?B?eUpQTGhNd0VaTzBxa3BHdFVPdnlnNlA4NmxtSjlSYTJQaE9iT08wbE52MlBr?=
 =?utf-8?B?bTQ5bDM2OTlsaFhqUGMvZUlnVW01eUtRaVd1ckkwUGZSc0dCUWhhVDh1dE1X?=
 =?utf-8?B?L3QwS3BEUERIdjk2czZBWDN3cVdvSkE3QVY3THpSVFpCR2k5Z0lYSW1VNC9I?=
 =?utf-8?B?RklmUEMrK2xhMmN1b3VCSnFNYWIyS1FMc1lYNDJ3RVhFdnY4dmw3SFF4RHhI?=
 =?utf-8?B?NlJ3RHVjZ3hGQkNVYmhJT3BITVZzZHRjL1c0a3c1RHFNbVE4bytuKzhrTHJL?=
 =?utf-8?B?UEpQeW9HQkxYeEtCTithNzFpSjdIWFNzWHpHVTZMbDVvckhlY3o1Y2J1RlpG?=
 =?utf-8?B?K1RsdkpuMDBuaHRreXpCdTkwemxINzJ3ZzdJZHpiTnp6bzRCaVVWWjhZbEdx?=
 =?utf-8?B?ZGRIR0xUTWl0R0xhRzFUWWxKaWEyYkVDYVVCclAza3Nqckc4QnBuNDZ3LzNX?=
 =?utf-8?B?b1czdDN5WGFrenNyenlCL1hPRkt4eFFGYWx0ak9XaFlPd0ZWOFBueThhYUU4?=
 =?utf-8?B?bVREOHdBb3ZhbDJEeURZM2dSaWJRUHJwUGhLYTZpVzVST1VTdlhNNEZGdkk2?=
 =?utf-8?B?MWI2dm5FVmZnekFGSUllWk1lU3ZDUEkxRWRvL1VzTjFmVWtKdEpqOUl1WVNx?=
 =?utf-8?Q?hOACvOXsp7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:04:26.5440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96904915-9def-42ba-8070-08dc90711ca0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6677

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


