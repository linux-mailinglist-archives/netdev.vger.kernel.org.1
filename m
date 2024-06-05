Return-Path: <netdev+bounces-100914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C668FC869
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CDE282B69
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CC190056;
	Wed,  5 Jun 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gpnOmFjW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365A18FC7E;
	Wed,  5 Jun 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581434; cv=fail; b=L9v2Jsil4IOoVCGnZ3fsQdDhj7JSRUIFKBUUk7BdhYYbVje1DFQ3kakjgI8pqsJJPRCfcryO9Yn5SQKhmi7G3VkZCmbSWlyZSMHTIn/+g40cBH8hjUUWc3F/cEyoaMfx7CazU5DaQ8ZbT1vexsZTKAa1ncmJJCbl5WFjZYyBISY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581434; c=relaxed/simple;
	bh=cptz0IRnup62E0/a4VROp5kRGBymby/FqRfLJeMoidA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvaPk31TY4aEEC0PzFKOf6bFJl0l6pQO0d8kcW/g8SLp3Z/jM/REDLx27LCbzw/YuJ+9MqBLe00mjfMiYsFL9CmXMBgF6x618aYLDSfCFbDne+XcbzaHeq8LMKEroQfHDiOmjltZk5XGyIJXEu6/FHqKw3DCcG0jErAw2ZvBpNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gpnOmFjW; arc=fail smtp.client-ip=40.107.13.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6HOtKThjaDMsMzJHAdnB+f8RZeiACUDS6VGLingq4/GuIPLVHdIYuEPAuCIqyVt5XdHLnMkOrDEni7r48U0RYmdtkWxWJJGzGPEMp5Nw6lvzcr1xVfrv8eAAMcInfoxiyM47J+M5YgxY3O21swI3b1YFfZVmC/0a9EiNQiVet/v9aq8RF3oK6uzp/WIw5bxDC9X56Ctc1EpQsX4e03UGJ5rWle21v5K5OV+B7rpDA1qTu1LeBnYFszzbAlQyyWFH4c6ocI6snSLKGXPSlkW+9OMVESBOBpNlpCCYhR3lag8toELJbc3k9WbXa8EkRc/08X1QzHzxKWOUU9RUYfH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1N5IVWmATDtB8x7sZDsKo2B71+DChFJfe1pnJHfUnM=;
 b=bEK5Rmbx3vcqG3H2mI1aNIzUu9oRS8IdvfcEbj000iGns6Fl4kW4P/h/LbfeXptnONQhCZzeSKL9dRbkTBahsDJU033dtxcBKIAsSzOSPj7X9HMGNaaVgfK++NbdMFlM4SoP1yzCFuNC++aeAZta9hy2XJEKL5ZdrkLl4dqholaUBvUMuD4OmVK4IXdYKD5tUtbBm06vrdaEJOAVe7x/5OrR4slMmpu5TDYW3MDUtcD4DPCRICJzJAyPNtu0yHhiUxuT63Clx8nGMlpAPnYGBivsgDCZAQCR2VDBtn73Rt/NaOJ7IcHn+WA8+BeYgIBVH7+ZTOTvTdCbVGAeRF8+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1N5IVWmATDtB8x7sZDsKo2B71+DChFJfe1pnJHfUnM=;
 b=gpnOmFjW3KkFF252T62QGMTSdtyXJkapnGxaZeCQgXJPIxpWROfqdQSu/fByPr7xH3EkVjzM1h+OIcUHaRBqhPwdKHPzJGu0niEegupE4Im3GX0bh4CwktHrNS1W9pHsujljbHU/D8QIYisY9ZXH80T0v8JTB2HOs2+y4Uym0VU=
Received: from DU2PR04CA0213.eurprd04.prod.outlook.com (2603:10a6:10:2b1::8)
 by PAWPR02MB8957.eurprd02.prod.outlook.com (2603:10a6:102:331::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 09:57:08 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::b0) by DU2PR04CA0213.outlook.office365.com
 (2603:10a6:10:2b1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 09:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 09:57:08 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Jun
 2024 11:57:05 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] net: phy: bcm54811: Add LRE registers definitions
Date: Wed, 5 Jun 2024 11:56:45 +0200
Message-ID: <20240605095646.3924454-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240605095646.3924454-1-kamilh@axis.com>
References: <20240605095646.3924454-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|PAWPR02MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 473df659-bd7d-43c5-563f-08dc8545dcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1QybHNoZWtJVHljeFY2WE50VzZwREtiRm5nR1ZDV216bW9vNkFrakYxRHhJ?=
 =?utf-8?B?M0JMM01lZEtRSmVpVHNZdU5hZEJQZTF2L1NYWlluN0haWmdEU3QzdjZVVGVY?=
 =?utf-8?B?M3pUc3I0NUFTYWJDNkgxUFppWmVUZUdGbW9GNGdCQUU3WkJGcVdDUkZDYjh0?=
 =?utf-8?B?a2hqajlablRhTjkwSmJLSEpKenhWMFZueENPakdsMGgxK1BkZEZKQ2xtc2o4?=
 =?utf-8?B?Szc5c3R0RDZNR2JWWTBYd09qMzZoSmxIKzBXNkxCTVA0ZGNSZlRhelplUWwx?=
 =?utf-8?B?OGZ3ZkZFNkQxdWZwNUh4WVpZSldoMWVERTd0VFRtc3hFVGJLUHc1S0ZMVTlR?=
 =?utf-8?B?RlZmcGRnZUp5V0Vxdm9lcHFabUh1anJZeVIzdkEvSEg5MmZzRUxhOTlVYVpm?=
 =?utf-8?B?RW1PdlZ5TCs2cm9vUnZ6ZUxLWTM5dGxRb1IvWnNkV2hOWEF1akNqaWs0YlZm?=
 =?utf-8?B?eUhQTEJrZXBSL1ZEVUcwUVlGODBXK0JJdkFnYTBreDllYTNmRU5YR3lZVW56?=
 =?utf-8?B?QTFjZkRKbWJzQ3VPNzJ3MlJyWjVNNHdsRjNDemFFMEoybUNrbCtoUzdzYUlN?=
 =?utf-8?B?bFN3RWhCNnNlSE8rdFhqa1padEo0Z0lNRGZlQjlWK3ZHQ2phQ2xyeE1nM29r?=
 =?utf-8?B?ZzlpQVZ4NlpqUkp2OVlVcmxMMG93NE01ank4TnIreUFCalNBb1dsZGJOUDAw?=
 =?utf-8?B?RzlpU1draU84eTY4dHdvVHpFOGQyU0Ivbkd1ZkQzQUsxdmJMM1NnUUFQS1Z2?=
 =?utf-8?B?TlNGRVlBSzZyZVBXdWRBRFd6aXNVQUgrMkMzN2hTd1lncnd1N0hNNzgzQk9i?=
 =?utf-8?B?TXUya05iOEJhcnFLbmdBNU9QWWZNZHM2Zkc3dForWkJiRWEwUmx2SjYwUm1E?=
 =?utf-8?B?enFTTld1d1lCMERSMkZlS3M5bXpXSUovcWs0NjFadWlMNHFCQ2gvWXdRTGJx?=
 =?utf-8?B?VU9Yd1gxQTdQRXZsMldIdDA0bzNrcEpIdndNR0x1bDhiYzhFQkpzeWMxV0Qv?=
 =?utf-8?B?STdiYzA5eEt2ZUZmQ3lVSWlpWXhLZGd3K0RUaTl0OExYdWtIVlg1OWJIRTRl?=
 =?utf-8?B?OWdqWm5KVlphck96bEpmajdUUm5lZHJrSDZxa0t2Mmw2OG1ER3RoVkprT1d3?=
 =?utf-8?B?azQwN1QwR21WVUNhVndtOGdHTkEzdGtMQXFBVktMcG1QeXd3Qkg5ZFY3Ti9u?=
 =?utf-8?B?TzF5cVBjVktncGJGSWhkM2lBZ3ZEd01YUDFGamdvVEk3T3dYZnlDVWxUWlV4?=
 =?utf-8?B?aWFhODlpcVFmUTZlTnUxSnFDZ1E0SkY5eSs3cmlibHVNSHRtQ3RYVUxTb3dH?=
 =?utf-8?B?a3JsZHljMXBVbk1kK3R3V3M2N3c5cHB1SUh4ZStOMjVNTzNPMzdhQktxRHlF?=
 =?utf-8?B?TjEvbHJJMnlVVXh1dVhGcHZnTTVSek5yUGhBV1BGd1RRSUxoV2p2NG56c1Ez?=
 =?utf-8?B?YmNRelp2S1FQMkJ3b2kxUVdCelpNUDY4ejI1Qzh5eThQaitaRDFvM2dEdWEy?=
 =?utf-8?B?U0dJK3JDVkJENm53QVd1bjJuUXFrTmxiVDdLRkZzaEpGa1ZJdU9QelEyaTlw?=
 =?utf-8?B?L3plUUV2bWtER0t0OHNoSG9kVGZUWTlHK1gyMVh3NHVlV1lwRnJxZlVhd01C?=
 =?utf-8?B?M2xjaG0vdmtvblpkK2ZLZUk2ejlsWDBiRUMxWEI5bTJBNFQxaXpnaWFDZzNK?=
 =?utf-8?B?RENnZlcrZVRqUHlWS0pBNE12TE5JQ2RVdHV1MVpWQzh3UitDUHJIeUZoMmNS?=
 =?utf-8?B?Q0oreU9CWjZQdGtKYnlmaXlqNUQ5Y3IvRTZaWEVBOHlwc3ZVN1FJMis0b2RN?=
 =?utf-8?B?N29pRVdyZGJ4NEFsa0dGWFRBUE1BbjVRMDVpd05VUGxvcGJUWU00UEc4L0xY?=
 =?utf-8?B?NE9vNGpCNzdlczczMFVYU1ZoZWwrY3dhTlBHeW9wdUxuU0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:57:08.0808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473df659-bd7d-43c5-563f-08dc8545dcb3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB8957

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


