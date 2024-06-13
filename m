Return-Path: <netdev+bounces-103234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7048C907386
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC8C1F24B82
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ABD147C80;
	Thu, 13 Jun 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Q1lc2lm9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EC146A71;
	Thu, 13 Jun 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284884; cv=fail; b=qvNsVN1X3uAyLLe26ewBUZAUldNV0lp1zrYjcc6dg9jEv1Mfj606wqkhbwWCgw71ihtDXSRIsQq2dBdM7lTQ1aKMZE67fqRdO69zm7n+R4pTWbQjPlo42/oRrgZsOnZCIwAn2Kep3MD1bsQSd6LQLiXumQoXTFpjCOrud5szrw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284884; c=relaxed/simple;
	bh=j5RHiRyDn4YoqPGIS5EwO1SiAI/OzzoJY2unS/fydVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmKXtEKz30CkwG+WyjIKw4KODaTMB12zSmOSukjWmT+5567vIiKXnmT3jT49VRcrc96WJA5cm1xsh41wizCRj6fTwhwvngap64ozJWx5gEZj32gpUuNzfLmwfHe6u97sCC1WK+8dRJXaw4UTXCAn/SxXEdHeUxce2mLR2Dpjr/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Q1lc2lm9; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR3Q2xVtPaYt4WRBDMeKLSZLbIvQWDokMMPI0j9O9HaLT4ZYpRWEv4tqhsFEo6/g/xFvff2SWx8kKCIVJkq2kr3q7ANB8cXJsOq+ORXU3/F7vB5QbnHKFQpftjl+483Hb4Gi5ZTzbrWerdSDH/08VhNd+mNR3sarYXya2ueOykf53ZIvVrHGWSZct6pBWpwPNqvlnk7YST/5avdIoCWpkua6Bhtw7Rr4P/7hOWK47D8SfFAyTJMYt6uaJSLk7G5mQoJgTsLpzkIiEKDJN8bWZpCXOsOZQhCTf+8x+r/3UostdujDmTl4nIRDuvfJGiCQjbqqmeWP4rtH2xE1jYTgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv95kUZfkB4FCQmhFRaDpXNt1sq/C5LMLkeRE0SgiJA=;
 b=XmUt/QOd5Lzj177Ha8H3hHfVzFE/8eFDdmomVga9VUspmjH95y3Ox0bNOz/INtVuLSSL7FQlUM5g62qhg+GL8xRtUyjQjRkz9VVdVhoyJ8r01yP3WQObZSTvSbqOmqdBSO4EPhScex4hNcOA5xNPN0FeyUV73KXOYDDnRtiaOQT226BRm/mbhHlEGLhVpdU2NO1nF3DFNgLElPstQWJZhVNG8eg9PPp6fIvK8AA1Dn+EesVZeiQJyqsPMW6Yvoh+sdbYo5S9A6xZKpB1eW/6dPFeDrrKOeDnZHTKFyLWHuPCy0dTi8Ho+FplpVc5iLJuR3SNF9N6z79DS7q5PWySmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv95kUZfkB4FCQmhFRaDpXNt1sq/C5LMLkeRE0SgiJA=;
 b=Q1lc2lm9vVJ94Lp8W36HqXLKaoIVWrkYMgxdwP+G6onzsLAYSBpdA8uR0rF3kIdW0oNH+bq47+2A6csUFevrNzWCMZg0ctExRomn2vLdtdrrJS5PLPxtGM2mdgIexuDdU4lDPW63LqlqhOobTER7J346i2r/ueVgKqwGB5eYL6k=
Received: from DU7P195CA0025.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::30)
 by DBBPR02MB10604.eurprd02.prod.outlook.com (2603:10a6:10:52a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 13:21:17 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::b8) by DU7P195CA0025.outlook.office365.com
 (2603:10a6:10:54d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 13:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 13:21:17 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 15:21:16 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/4] net: phy: bcm54811: Add LRE registers definitions
Date: Thu, 13 Jun 2024 15:20:53 +0200
Message-ID: <20240613132055.49207-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613132055.49207-1-kamilh@axis.com>
References: <20240613132055.49207-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|DBBPR02MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: b20f35f3-e2f5-4c59-798a-08dc8babb53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vnp2ZmZHWG9JaWNUeXNLUVprSjlpZGpzSlJHenB4MnpvNGEvWUtzVVNnY29j?=
 =?utf-8?B?VnYwa3ZTRDBsVjFST2d0R0MvZ0NmYVhEaitrT3FSTmYrVFE1NVhVczNWUE81?=
 =?utf-8?B?V0plYUtPSHBZSkdvRkQwTTlKazJNZW1xbGJwcDNwTW5CejAvaWdhOWVKMUFF?=
 =?utf-8?B?WFFPNHNBWlR1ekNDVEdpdUgyM3M4alFuaDlwOHRqN2tKY0NNcUFEdjF1N2J2?=
 =?utf-8?B?TWZoMU1LRk5BOUtOakNpUUlNVlprNGxabUhYY2R1aTA5WVgrcVoxNk03alBh?=
 =?utf-8?B?eXhQQys1dWhUcDRFbEVjZE9kU0JkVnI4VWxZVWFXT3prMUNoRzJWZ24zbnhT?=
 =?utf-8?B?bDZBcWN6dkEvbkx0MVI0Tk9DeFp0RGxNRWxYR0wrNzdsZUE0NTQ1dTBGL3Jh?=
 =?utf-8?B?Q0JGUGZCNHkwbVBWb0RVeFN1STRybDZlc3JwT251TmpicFZKOU1sdjlTdngz?=
 =?utf-8?B?Rm4wNnlNOVdQbStMS2NJWkRnMmVpK3dSSFlhYXVBNm5hS0kzeVJPVjIwYnpD?=
 =?utf-8?B?Y3pkUWp2L3JnM1QxMVJ2K1NMSXFSaHBPbjhxbWpJVE9OYnloQXlnOGhuU0FP?=
 =?utf-8?B?K2pmMXdjcEIzTTVQTDVBYXozSytqOE5LckpmS2JjemUxS2krVVZFakZ5eERB?=
 =?utf-8?B?OFAzZTVKcXp1d2pxVU9tY2tsY2ErdUUyaEtwTlNqVnE4VUZmVmsvSEVydEY4?=
 =?utf-8?B?VHYvb1BST1gxaVJCdW13ODRhOHRldFJIZWpDWXc3NkdTQ3RJeVkxZnJYKzNt?=
 =?utf-8?B?aDhhUWdveUVZY3lKemJEWGxnVEFYY28ydzl5WHlyTitYekxxVjByaklMMFh4?=
 =?utf-8?B?MVFqb2t6T3FFZjcyWlBtaDVRZldvSUpucHd4dkNyVW0rM1hrK1I2YnJyUkp3?=
 =?utf-8?B?MlA3UUt0ZHdMenlGOVlnLzJIRzBlVFQ4czk0V2VNZExYMGJzK1lLWE0za3ZV?=
 =?utf-8?B?YzdzbXVYdEFDbk1FOWowVisyRUR2NWpQNDNUOHUyMTdwU0tFWlF2N0p2ZkhU?=
 =?utf-8?B?Mm1QRXAyY3JYdXNlUWJPZlNIcEFPYU0yaGZvQTAxQlp2TzJ4RDB4V01CM1pN?=
 =?utf-8?B?N0FLNkRQMnRMUkpXMUtYWmpmZ1I1WFBnZEhoNkRiQkp4NDNDeUZQSXNrSmtr?=
 =?utf-8?B?clB0SkRNR0ZLS294cmRqbXcvdWpieG9lNG0yVDZBbVM2NGhkTkpITXVZTCtR?=
 =?utf-8?B?ME1MQngwZ0dJcDBMZFpmM2ZrbVhTNTdCaHB6ZmVDTS9SeGdSYlBHTjRwcVhl?=
 =?utf-8?B?aDJaeWE3dG9WMmRJNVFPdStxVE9VeFlXNzR1T284SVY3UkxaSS95Q3dLNjlX?=
 =?utf-8?B?dE93NFhraXUzay9IaE9LdHc4U3ZTZnYxZHpNcjNWUlN1Nzlhc0l6dTRIeG4x?=
 =?utf-8?B?VzJvdkcrRWZVOEtwS1VLM1gyUmdGZG9XNFV3Tkt3Y0xZcHhlbFJSUXlUT0ZL?=
 =?utf-8?B?dzdsMmh5N1UvSGtNaVp6dWYwUWJoQVQrUk0zT3RNS1BqbDF4QjE1b1kvZ0p2?=
 =?utf-8?B?cE10KzlGZHhRUFVLbFdNWmhmRkFtVmdXdE5BUFJKYTcwSnNEL0lET2hmQXJG?=
 =?utf-8?B?VTZleDQ1MTZ6dmppMWxXMHlUNitZdEU1RTROMzVkNnMwSDZ0a2hpcVNHVzJX?=
 =?utf-8?B?dW5OaktQNDR2clE0RS9ndG0yTWVrWGRiYVR1bURjd0pURndDNFp1ZGNNMnk5?=
 =?utf-8?B?dkd4dCtQMFkwckVYaGVZMDAxZTdZdVVia0t3a2VmS2c0cVJCL1lXNkhKZjRv?=
 =?utf-8?B?TExYWXZiQUsrMm9tbTZnZzAzb1BwSFNVbjV2VytXLzVDYnFwemRHekdmTVdH?=
 =?utf-8?B?dWJmT3pmeHBnWHMxQjlhcklzczZkRk1FRTlmendWMC9zVWdIRDgxUHYrQlMv?=
 =?utf-8?B?UUNFKzc1Q0Z1WTBWdFRqSVdDUkRadHNCYzhQeGcrRmNObFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:21:17.5163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20f35f3-e2f5-4c59-798a-08dc8babb53a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10604

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


