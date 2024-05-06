Return-Path: <netdev+bounces-93743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8098BD081
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0841C2460D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913B154448;
	Mon,  6 May 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ho3CV7O0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CE153834;
	Mon,  6 May 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006508; cv=fail; b=TJAiuEbPZ76RTvXKBMLvmnk9jOT0LP1Iazel95TwnZIm0A7hpVtcFfIeBpmukFhpHPMPwRSyxSRWClY1Mw6PJ9hBE9P7VReIEPDz2BjS5ba2y3KcwEiSiKGkZSDZMwUWZLrCJHOKKZt6RtDMERhEt8kh/xXGNKSJWUnunS1GJS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006508; c=relaxed/simple;
	bh=DYqFGcoNFDoHBokmsqHRgZB9QQYz8/pV46TOgqTZh8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBpadO0/6Q3LfbeCyvI98vNdhAuEobBV78kEREAZdD3a6evZgZnZhwkBfPrOtwS3Hg8Qw5l/9ysTSTS35fUL9wpdWYp965iEv80wGYWPX/+ReH/DrTYPBTBylALAqRMYULVz5xA+Oek/fmeinVWygI2kuKn5SNOatpf+YDI7WSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ho3CV7O0; arc=fail smtp.client-ip=40.107.247.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3AGKUg7DyXMmWHp/xWRUnjSoCLQlrQIdX0cTkC+2BBkCP1HNGRzNrH2wjgkw6JJiCJZvAfqjSwrvpQKwg83GWdzcdVY5+rjqX9npeIdtqOUiiFbam5J02aM3rT8X0xf2vy9bxV0kYAKpi/i5a97/QDBCeuFSbm/HbxVR+ih/OBdv7iAskM24R7HmeMm8dBXJbxeROehzYV+LQHCMkVTsyRzV3+DVIqxVEtqiwhb7mFHWRDffcbuTDmQXsOWsfHfGn1TcGWIpfPu9wuPkYNv3Wf2O97TXrOiChJfBvqlhQ5s7iGvF5wzH6YFvmk12qRzNOJcgp2WxtYiXg54UoTk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H48Bn+YtoQpRblEDvG6v5+WSZ3Vtl0voti3vm89jKSo=;
 b=A7GCjwbrO4cjWGAnFOziZOymkHEPiUMquTmx6wh7ynztiVD+MOsBAdu5xIRa4X2vVfrU7TGYOh884pvZs0Ieis8U/7L06RdCHMic8wGeXlV42plCMFbpbkZqYKHdB46JCdxAxZPH/gpu/CerNO5Mzy1SC0eqywyXyG315qcqH21Qy9ZBzBZiFjjR1A3iG2G/I2yXyl1HnvOV3nI768L2ng6FoOwzH5sqfKcZ2Pa5rTCtsHORl8p0U+460JoFGdXcsI3B6Qa3Ocq5UteUd+ZNSBlGAti+hFt+tn96clmXwoiVxK1mnChzcGXgFxsyDLpDCxj8Sj9d9tHX24L6m0guLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H48Bn+YtoQpRblEDvG6v5+WSZ3Vtl0voti3vm89jKSo=;
 b=Ho3CV7O0BS2pmhre3YD2SUk3XCUhEcGE4g0DHiDNgOUkaGosPLwn6jnETTL31TkG+qkinTvzVNfaY1QPmTf79C0/dF/6+MEg0lTr10eE9zcJPOVSfm1dfXlxym5C1ar1PxWCsAaiKwF7Zt2EDmcE8Yx3CG4FVqE5fnHobc6LPWo=
Received: from DB8PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:10:110::28)
 by DBAPR02MB6471.eurprd02.prod.outlook.com (2603:10a6:10:191::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:41:42 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::d1) by DB8PR04CA0018.outlook.office365.com
 (2603:10a6:10:110::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 14:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 14:41:41 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 May
 2024 16:41:40 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] net: phy: bcm54811: Add LRE registers definitions
Date: Mon, 6 May 2024 16:40:14 +0200
Message-ID: <20240506144015.2409715-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506144015.2409715-1-kamilh@axis.com>
References: <20240506144015.2409715-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|DBAPR02MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3fe91c-c50e-4e8d-2ed7-08dc6ddaa4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/58IhMzqNlOc3b1Nqg5Mw54qbHCh4Y/0kg4qgAxfHf4S18rns9Lyop1sYO5?=
 =?us-ascii?Q?1SrdpIeVNkV63GOXi/VlNu04jdnc1venwCyEoKnsRTQOPTer6x00tjpoCuCo?=
 =?us-ascii?Q?WOxaIUrvUzg9YO5Q0opTJ3CE8JsYolmfoNR/IWIvEvsOXN1u++GSyGZqEPWK?=
 =?us-ascii?Q?Lj6XRpWgFsP6v+CMv4GBIf3njf85PdljXt0cdxJikBpeO9zW3KkH9wC2WGWG?=
 =?us-ascii?Q?Mn7e681Pp96HNa+iXwsjYfVoSLACdNL0P1fcMetW8HDK3QX+gQFwO4drXoiO?=
 =?us-ascii?Q?oR4pAWsuqEtlw/+2f+AXIbYtGXjEuNAH9IZQMhmbqHm2L6/N3ObG9lYD4in2?=
 =?us-ascii?Q?PLU76QoGI2yXstxZVFW4hOc5CdLNZt8H0PxHq5RcKIY1yUHlCLp2ZGPFWojP?=
 =?us-ascii?Q?T/p4NUQ3Xioy2Z+1+OctcVOt3UpF07cSj3rMmSFK5jjNSiyFG+B1eAkCNBwJ?=
 =?us-ascii?Q?xorSfwsn2I+UXe4r3I2IyWl1yzje+IPwCTNJ3rEBHsRPRIAVQo0/EntxOAeo?=
 =?us-ascii?Q?GpP9dMJFcu1AZdo/H2OewGg8vqasN3z7VRmauX/JxDuqwsCPZJc9XUWtfVre?=
 =?us-ascii?Q?kYCwTOYforiMC0HiVgm3H7hw/b3SG/2m1pBTVVrG2kmNN9CFJm6WSm0n7cbP?=
 =?us-ascii?Q?c8f7rHfEGpqbmJ5ohNKIaoWtr2ZV517U0b86MDaqLuGJH2f39F+lZXvF6STX?=
 =?us-ascii?Q?dwIq9Vhe2OWSZmu6DHHBU1Pq75M4+qCme9UA3+lziNvMt4weYm4XmOCtYOni?=
 =?us-ascii?Q?egl4qvLh99UBGmW3q2lcAo6WPSKA0E/caKq6ibGoqzrOglGtcRwSUG1Jqyir?=
 =?us-ascii?Q?G/Nbwx/TClXEkJzKtLF/Ebn1/mMcBHQ09ERxA6G58/iAosYucyh5P5QHoQU7?=
 =?us-ascii?Q?XTkZH4mwtkDZg0fAM+PAby7kyocAWtPmhxGQwyCtC4F6D9w7qUW2HcgCy3n/?=
 =?us-ascii?Q?xwpa38d1XAcHMtPP77e6I0zaHXcpyW1qdBHeqVRRXyi+do5wM7+A9A29T6L0?=
 =?us-ascii?Q?cwTlExPBdanREzfIW+OHUvb8KoOFWgzIAsfsVOMKQrq4XdPDPbe5iaPKVrh9?=
 =?us-ascii?Q?NRKAnwO6vMAmjQh1KQCsGWst0dGUvF4JIoXjk1TURHhOntq6TEOtpYUAyAvU?=
 =?us-ascii?Q?vJ/7TkzuVGdTVcoPBJuvvGrlKji17uHH3me8ybn7Rjn02TyML9/H7tewQ4/S?=
 =?us-ascii?Q?XQk78t8yynJNF1KEUzZSYT9hE3xzALIJ5+VKBXHi6kQdnrQV1MRkaZuPJYVN?=
 =?us-ascii?Q?WllizaOgyckXbowMgNZ714NFz63AtmD/uVtUKxxJxG980BF+UejEOWBE0aIG?=
 =?us-ascii?Q?fAYioBOJ28Om0R8aoG7xgyPneBou9UIIgT+N326KPPmXDgQ1cEm1AbMTw2wF?=
 =?us-ascii?Q?JPtxPX2KcxRFSIESW0EmzAdjGXSE?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:41:41.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3fe91c-c50e-4e8d-2ed7-08dc6ddaa4ad
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6471

Add the definitions of LRE registers for Broadcom BCM5481x PHY
---
 include/linux/brcmphy.h | 91 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 1394ba302367..9c0b78c1b6fb 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -270,16 +270,105 @@
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
+#define LRESR_ERCAP			0x0001	/* Ext-reg capability          */
+#define LRESR_JCD			0x0002	/* Jabber detected             */
+#define LRESR_LSTATUS			0x0004	/* Link status                 */
+#define LRESR_LDSABILITY		0x0008	/* Can do LDS                  */
+#define LRESR_8023			0x0010	/* Has IEEE 802.3 Support      */
+#define LRESR_LDSCOMPLETE		0x0020	/* LDS Auto-negotiation complete */
+#define LRESR_MFPS			0x0040	/* Can suppress Management Frames Preamble */
+#define LRESR_RESV			0x0080	/* Unused...                   */
+#define LRESR_ESTATEN			0x0100	/* Extended Status in R15      */
+#define LRESR_10_1PAIR			0x0200	/* Can do 10Mbps 1 Pair        */
+#define LRESR_10_2PAIR			0x0400	/* Can do 10Mbps 2 Pairs       */
+#define LRESR_100_2PAIR			0x0800	/* Can do 100Mbps 2 Pairs      */
+#define LRESR_100_4PAIR			0x1000	/* Can do 100Mbps 4 Pairs      */
+#define LRESR_100_1PAIR			0x2000	/* Can do 100Mbps 1 Pair       */
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
+#define LDSE_4PAIRS			0x2000	/* 4 Pairs Connection          */
+#define LDSE_2PAIRS			0x1000	/* 2 Pairs Connection          */
+#define LDSE_1PAIR			0x0000	/* 1 Pair  Connection          */
+#define LDSE_CABLEN_MASK		0x0FFF	/* Cable Length Mask           */
 
 /* BCM54810 Registers */
 #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x90)
 #define BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN	(1 << 0)
 #define BCM54810_SHD_CLK_CTL			0x3
 #define BCM54810_SHD_CLK_CTL_GTXCLK_EN		(1 << 9)
+#define BCM54810_SHD_SCR3_TRDDAPD		0x0100
+
+/* BCM54811 Registers */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x9A)
+/* Access Control Override Enable */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN		BIT(15)
+/* Access Control Override Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL	BIT(14)
+/* Access Control Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_VAL		BIT(13)
 
 /* BCM54612E Registers */
 #define BCM54612E_EXP_SPARE0		(MII_BCM54XX_EXP_SEL_ETC + 0x34)
-#define BCM54612E_LED4_CLK125OUT_EN	(1 << 1)
+#define BCM54612E_LED4_CLK125OUT_EN	BIT(1)
 
 
 /* Wake-on-LAN registers */
-- 
2.39.2


