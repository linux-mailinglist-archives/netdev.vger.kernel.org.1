Return-Path: <netdev+bounces-111093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33192FD2E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9931F224A0
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE8F1741D0;
	Fri, 12 Jul 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="du4xOLCT"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FA171E74;
	Fri, 12 Jul 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796874; cv=fail; b=POww72mmSMLRclL0MU1WVrmQkisNzqju9cBXZGW3I9JG6QmPWWw4ldaUWcMUBdTrxcn3f+KMBughTAAIpUGkPmNKVNAotlvx8zWmiEcfcWSbhHZMm0FhNrkA3udEkW9+aNk8AIpTzSTy8Y/eUb9nDuMuGDYuyksZpkBbYwVqCNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796874; c=relaxed/simple;
	bh=nW5o9jacrjPWOuxhoPe08F5HjFKbOisKW55vInEX5jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n99PjD7JLnnFbt7C/DwL7pYgtP/YJOm69QICQGfDUwtbZ+Gj7BBbNXG0HgwibiLQqyBBpeO8vQvB7jlzQgBpjVZN1ZtupE5w2R4wVODB11IvSmH6yxDohLei946WyLPNxafaXIdxmitblmt1+wwfwfjtmt712Mz7AiznG/usqc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=du4xOLCT; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkQnxyEJALzsPZa5jA6SWnM+819WrSJnsYoUoEIShCiE4LCv2VJFHpOLN/MXFclEFtsbUddKADPYQB6LgJQOAawMVC/xfzMHPC0jvJp47ZtyLe22koMtpg/Q/N46E7GY0b7TYTFRg0/XQW+3iguWYBlhwfIIyPJxgZDe60bMAX7gkWDGu+RbMg1cpgFfE0uqiVIztZ2OUSU5R+dN4DvvOqwPp++P/8dYrhzAXAEiN/fxl5FEN4zLETz285s28ZDswN/Xx52coRCC3x2CvO18VCuIk0kPwrylDs8x3uVOM9zUpTo3Sl4iD1h3Xn12vCdcSlCS97Dq/A2bOgSsnFN6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ggROmr7pEozEH/Ekc4IbP5so+Dk1/2A8pLpDjNwcBs=;
 b=VtU8v/fvIMjLdEIey0ruPdh7kHf3s8ugXmxhqaB8W3tke7uLElyZn66K0rLdKNbR/AaI9UXtaxFzs9KtGTLM+xH4F6SAaRGCll0q5Y4XyOSlW/WdmppcS9SfYG6oilJBL2knc81OiVhnGiDLO+t7F7aKLg3DPcn7QPlWu7WLT3VzTClV2PBro1/xU37utHGdTm71UdYoK+9VN/OzN06qzH4EtnQJ/FhNSIys2oNVreJQz2iFNe1CKbojn011RxhmKe972w5K7iJrcpgUae8hAnyp5QwPnyiMr25Q6LBj9XUCyYr+UECGRD8XLTsj8jFrOnLmyl50MY1OdhQFP5Ppaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ggROmr7pEozEH/Ekc4IbP5so+Dk1/2A8pLpDjNwcBs=;
 b=du4xOLCTVjzhPqYDmaUX7KAg8vlILrUhwowVlRLsVfP64RvaZvAhn00oFzA1U7xqGXdmoVQw1h97gmJ/jSak8BKEC00IqXtu9U2QB7jKsRhG6cjDFRcMWXOxDhTLqrmPLudSiwc9Ef0Zpi6oRteJsxfshNR4UlOWVcB5H+OnjVo=
Received: from DU2PR04CA0236.eurprd04.prod.outlook.com (2603:10a6:10:2b1::31)
 by DU0PR02MB9322.eurprd02.prod.outlook.com (2603:10a6:10:415::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 15:07:47 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::2a) by DU2PR04CA0236.outlook.office365.com
 (2603:10a6:10:2b1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 15:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 15:07:47 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 17:07:46 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>, <kory.maincent@bootlin.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 2/4] net: phy: bcm54811: Add LRE registers definitions
Date: Fri, 12 Jul 2024 17:07:07 +0200
Message-ID: <20240712150709.3134474-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712150709.3134474-1-kamilh@axis.com>
References: <20240712150709.3134474-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DU0PR02MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 318d8b23-6041-42ce-d60b-08dca2846415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWhvOVNrRWFtYWxsUDU3R1lMMk8vT1hzSy91KzNYS2pscUkxaTZxQldESFNB?=
 =?utf-8?B?cXlIQ3RSVDhYbERjblp5anRWRFZiTjhOUXY0VEcxd2x3WlhNV0hlTkFwZWk0?=
 =?utf-8?B?UnBpM3dFWUQ1RHFjSEZwMWNIb3crQ1YwdC9pNlpQMGZydm92WU5KeitScXJ0?=
 =?utf-8?B?bGVtdWlURGlmRmdMU2txRmR2VlE5ejZxNzMvN2svTzQ4ejFzb3pkZytNSXFm?=
 =?utf-8?B?VFZNTmtwZ0llL3NidmNUS0NmU0hORTN4UnhoaFFNemRPeW1kNmszejdSUVdk?=
 =?utf-8?B?eXFkQmxLb0R6UHJLRis5WlNDYXRuTXFzMjVMbHRJWVhBK2JhRDg1VDZXNHMw?=
 =?utf-8?B?TlJSMWo0b2tvM2xUa3JaSWZGZEwwRnBYL3h1RzdIZ2VDZGNUNVFCMFREUGpv?=
 =?utf-8?B?aGtXSGM2ejk5VlJxTU5WUG8yS3o2dEpGS21pT0ZnUE90SDVrV3U3aFlaOHU0?=
 =?utf-8?B?K2IzamdGUnRwcVZFT2NNSW1ITGlTeEFOektQL0dOSnlyQlRYdEpMSFV6UFFj?=
 =?utf-8?B?Syt5allrSU1oSW1yWlJQWERIMFRTV050enFsTFlnblpnWTBKN1YyZTRUVm9L?=
 =?utf-8?B?QXlMYzB1WlJkUld6NzQ5TzJsWkhzdWViVUVKaDcwSi9EN0xUaWdYTXpYVGtt?=
 =?utf-8?B?YlpCTjRyWWNBelExSy91bHRacWtyVk1aRmd3SW5yNDJIZnp3eHlpaHhJR0NG?=
 =?utf-8?B?NWFiYTNJTDJ5VlptZ3hlZFRlaVJtNWhHMmErbnlqNWI1NWYyaHJiMUxaeGhM?=
 =?utf-8?B?ZG5GYUtlOUJ6SFJkTkZnelVoL3FhWmhiM2h6Tk4xVXc5cGQyQ0RUREt6R0o4?=
 =?utf-8?B?aGdORVRuQVZpbDM2YTNVWkJKd0ZkRlNsT29aSjhVcFhLcDFldDFUd01DWE5D?=
 =?utf-8?B?RHVYOWgrb1JIY2FnRHFlV2RTb3Y2KzFoaTVDMndnNXJEcnlRRHNOSEl0UlMw?=
 =?utf-8?B?VG80QlJCSERPOHBGVXBNa0pmTllGUWdOVVBHaG5QZDhHbjRJNFIrYlRWSGFy?=
 =?utf-8?B?eE5Sd2gwNndOSGZxY3pxOGlSdVlwVXhZZmtzU09ScnVlM0oyWEk5VTRPZjVI?=
 =?utf-8?B?akdSRjVXaCtvV0J5bVVDa2V3c1VzdGhmSi9sR3hnQS9xYnhkbHJwenZDK1BQ?=
 =?utf-8?B?QmpzNWpKdDd5eTdyYW1BZFBsNXZjdWlqK1Z2bXR0azZFMUp4bWZxZms5UXlB?=
 =?utf-8?B?L2RDZHZmWEoxNkwyWXF3R1lCMVdYejM1S0dLdkVUckpzRW9iazg5ek1YUnNH?=
 =?utf-8?B?REhqYVQwd2I2STF3UGhKdGRETzdEVGp5cVdETUhJUENhTC9EOFNNWlpiaEhh?=
 =?utf-8?B?RlZXQTZTMmdtWEZPd0lLdG5UNGZ4cUMyL3g0ZzNvVzJZaEZBZmdsTmcyU1VH?=
 =?utf-8?B?Zi9HTlBUNUpiUXd1TEtlNk5ORHZIMjF2TXNBNmlVOWhHN1gwa1VpbHB0NEdB?=
 =?utf-8?B?c2g4a2t4WjA0LzJMckp1OXdEd2t1SEhIZU11RXpYSWFpNURLWG96V3dFRXI5?=
 =?utf-8?B?VUFtU1hLQThKbE9kQUNKdU5iVEQyNVFrQ3kvbUU5UldTbDB2VmxkRzg5TWkx?=
 =?utf-8?B?K0VKUjJBM3QwR2xHSlZMQXV4ai9DMzl5V2pldkZMWXpmbnlGYnlPd09kV1Bo?=
 =?utf-8?B?S2RBZEdhSFFjby80cGxaSUlvNlcyU1ArN1FDd0FWWlR3SHpYM01WY0FGMTQ4?=
 =?utf-8?B?U212U0NhYUo3cTgyUnJWb3NmZUllVW1haWVnK1VhUnUrR0VhZGFmcXQwWXhO?=
 =?utf-8?B?WmQ0Wnd1MitYSXhDSXVsMlRCenJZVDVKK2JhYndsTG9OSTMveGhzOTc1OEJN?=
 =?utf-8?B?MWlLcWZsWFhzellZenBxZmQ2ZUxQS01YTTlkMWFBZ3hnUEFZTVMyZ0MxUGdH?=
 =?utf-8?B?elNwd3c1eWhmN3ZaTzlMbjZraW82RkpjQzg2M2huaGZaKzVrdVZ1NUo2eHRm?=
 =?utf-8?B?ZHJUMnV3ZlNqRHV6VTBIaklVSnJHdk9JbFMxSTRld1pNWmcxUWQrbzduTkNs?=
 =?utf-8?B?ZVN0bXp5MWFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:07:47.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318d8b23-6041-42ce-d60b-08dca2846415
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9322

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


