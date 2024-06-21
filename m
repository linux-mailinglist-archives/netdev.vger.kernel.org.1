Return-Path: <netdev+bounces-105673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03448912397
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263811C25230
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A998217B43A;
	Fri, 21 Jun 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BZLdh/Sa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28417332F;
	Fri, 21 Jun 2024 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969246; cv=fail; b=jmucKLNjJQPvYpx+srfYuDX1wLzrW9bkPcf+Wkolx36NgAU+UBOtld4HSVz0f3MWEmlnBwSf7i8fxbRrl5hG3We7sFNgJSYwhIy21PHe2ZA93DcbpVr9YHZ9Fhc4tw55TeDI23jj8liAZMndXeSDk4WYVm2du3gttn2NcBgyxak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969246; c=relaxed/simple;
	bh=wSb4NGFZtiADWGILNRVYqIKRfEaJM2LKzenjiz7qtW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnBgWE1sMOUYR8JxU5GerAcNpnKs15GlP1r5v65Ke3MXE3trqa3kQLkKbUR8AXWdqSRMatEvVwlt4bT+6Cc+TAGr6zHBL1XE9d694i2QSHVa/pVjpYwc/3tLjXd5i+OnXyBMuUXRDiAXMk9DO/SVS+7P+/r9WtEO2wgZ0FtRU/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BZLdh/Sa; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/i6GlhCgJnYmfFV/SVsjXsRH25JvpNZRzkNGB91AwHX+HdZC6M4ZOP2VhPjT/p3YETAXHM0MhnGnrkw/8SOpK6W4BNKz7PQTVnUIaGVBO1Y6jBp1/a6Sf7P6LQm0p+0dOcfOXOt3CVD5Zms/GvCtbsqTMu8TJX1RI+P6z+QHaJynZpqkkePoq51XuGDhVP7ktGzn6OvGScrtgcKq4Ew1L0shPziSSjV/2PY2sZK7AuELTVFKUhWDMRkPVAlPeofsiqWV73eWpGNUEaurvTkoL/iPsO3HSSL/ZC1edJyRfhR+I/3+xqqkBSOeDrZCAvb5jVEE9K48gNpbT0TYPefFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFvzx5qqCPA1rRTN+NbyJyj2+TuGDlXQ3Q6rJWm5ip4=;
 b=gENURDyeAm87rMjv1UE6TAhRb84VnJSkwL4m1HqQ9VIMqEXg1uXuCtl3aawk9cT+yCju5QS4CUTkbz50ApWHKy1imvDQvoHNDeTZapS0RW3SYXGD/dcpg99tNlP/L+fM7sA4IDX3AbJ6GRo4k4YvreTl0pK7L4OhhtgCiuMovkcbaT7q+diQ4z6O6bZ60DSoa7nWQLrh5hF0ZUzqqdqW4TJwZkoip+Uplt+hUPvCwLQSTW7HlgsNB8BN3sO1YqkYWOxZBDWGSI5970tezwXOtXZ5OdzxrbxZ4hOX5dOPihagLO4b1/Fgg/C7fnuNo81OcrLUPab6drsaXthfoaCPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFvzx5qqCPA1rRTN+NbyJyj2+TuGDlXQ3Q6rJWm5ip4=;
 b=BZLdh/Sa/MV59N2dyWKyxpWsYXyA94ZkzSOxhuXXHEG9lYHDI8YDqy6TVIlMnwwCcghrKCYPG7PVLo21KbFhuCYbZerhlELAW7fkY2vl/aGkNllYHiVKIDX+YUjlQXCf+Htp41vKPHgf0sR7ns3Yf/Sjf6wAo0g2Bl80Zgk/BW8=
Received: from AS9PR06CA0130.eurprd06.prod.outlook.com (2603:10a6:20b:467::17)
 by AS8PR02MB9092.eurprd02.prod.outlook.com (2603:10a6:20b:5b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 11:27:21 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:467:cafe::87) by AS9PR06CA0130.outlook.office365.com
 (2603:10a6:20b:467::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 11:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 11:27:21 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 13:27:20 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/4] net: phy: bcm54811: Add LRE registers definitions
Date: Fri, 21 Jun 2024 13:26:31 +0200
Message-ID: <20240621112633.2802655-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621112633.2802655-1-kamilh@axis.com>
References: <20240621112633.2802655-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8PR02MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 597cb6ab-abb2-4cfc-28e7-08dc91e51db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|36860700010|376011|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnBMRWdZNFdPc3JUeWdiMVFsODFTa25NdUJlUlFvWk9LMUlwOFBOVEtQZXcy?=
 =?utf-8?B?eXl2b1c0bU5iRDh0Um5BUWdiUTVyc25iT0ZSLzdGNCtWNFBJRU00ZjdrYTdJ?=
 =?utf-8?B?a0c4NGRDNEU0eHA0RmxtV3FLMnNSN2Y4Z3RlZ1FhcnRwaDkyaEhxQVRIbEJV?=
 =?utf-8?B?THBZZHppdy9tTStqQ3ZhZTNoU1FEWDBnNU5uc0FqSTE1ZS81NklvbDRWekpM?=
 =?utf-8?B?dUhzL0UzUzE3aXFoOGhzaDJocEh0LzR3amUyQmlHNzhiOWRTNVZBOGdUeVNU?=
 =?utf-8?B?ZmJDbWZSV1lsVTZxYlhLWktZdXBENEEyK1ZyYXgxcFlhMCtybWZXTkpVenRR?=
 =?utf-8?B?OGFjRmMwbXhnY1pISnpMNmRFbENFS01uRTkyY3pWL0IwSjNwWTFRYVc1RS90?=
 =?utf-8?B?UFRTUU1hTjdvbzBCUEhGOUNDVGZlbVdueFVtaUdad2JHMHpncjdBSDl3MXRh?=
 =?utf-8?B?cmVaY0NpVEFiejBFeGMzZGRuYW80Z05xTDRJL0RXNzhWYlpPTnRWZEJ3K2l2?=
 =?utf-8?B?Y0tRUm44dkZXOFl4dUZYdU5lTEVoR2lpakdCTTl5WHRzaEhjSTd1OUpxQ0p0?=
 =?utf-8?B?Mk1QWkNjakhFbVY3bFJsMTE2Vm81N3plZkNuakh0SEdQRmU2cjBOaWJPem5R?=
 =?utf-8?B?bW44MXF3RHdjbzc1cEs3ak1wVEIvcUNPbytHSENUK25uYXBQbnB2ZEllQi9R?=
 =?utf-8?B?UnV4QWt6aVpDR1RTUFFwMnZNQWd5M0JkL2MyRmlldDdIakJ0Mlh0a2I0R1Fq?=
 =?utf-8?B?S01JNndmMzdQay9TQ3hZdnlZa21lSlBQTmdSK3RVNWVmejE3M3JXU0dlbnFN?=
 =?utf-8?B?L3FqNmhBUHdBU2xkZ1JWSUJ5U0QxNlAwRkhjeVNBQllsbzFLdXRYbWg3WFM0?=
 =?utf-8?B?TWJENTkxNGhXYUxodVZocERReEw5ZTAwUERTVm5mbXB4Nm5xaDlRWm1aYk5Q?=
 =?utf-8?B?eWIvMThmRk04bk9ONFYzUE5XNnFtemRKZFZPUndyWTNaKy8vYzBHWGg2OTQ1?=
 =?utf-8?B?WVhhV1c4VVFBYWZyS0lqQXB2RGRST2ZOVllFN2lQMjBqVEdRSWMrTVMxOEJK?=
 =?utf-8?B?RGRzaDA0cVVRekFEK2hsR3A0TFF1clVUb2I3RkFzNzBzV3FaN3lmZExYcG9a?=
 =?utf-8?B?UW4xdC9NY1c0ZlF0QmI3TlNVSTYwYmZuZ2FwYXdTOERVeGUwUEM1eVJnKzRQ?=
 =?utf-8?B?dWFTc3RxdWR2bUFERXVYcWlaUnBjQmpsM0wxZktKSlZrRW5HcjU1WkdOLzNZ?=
 =?utf-8?B?M3BleFV2bk9HbTFHVEx3N2lBWXVOQjVrcTEySVFFT0RsY3RiaDIvM3ByUnN0?=
 =?utf-8?B?RkFGM01XREdrNkhDQS9yajFmQ3ZrTGt4Y0NJZEc0WnQ3L1dXaEJqbWtISkxw?=
 =?utf-8?B?Q05CU3N2aEtxWmJrRUg4a3NBTHIwUG5aTUJmZjlzUFpnWWdPZmpqL2xRdnF4?=
 =?utf-8?B?WkVNdS9COVM4UkpXQ25DOFRERkdXV2pxQXNYUHNTQ1NwSytKT21UcC9xajZ4?=
 =?utf-8?B?NVBLem5KT3FkYVNaRjM0emFWVy9ZMTBCbzBMbW82VlJONUdHdytCaXZtd2kz?=
 =?utf-8?B?QUdiMG41YnZhb2pFamNBMXFnZU5OTmp1MTZZWEQySFN5b2lkMWRzQjFjZWxM?=
 =?utf-8?B?Z2tKTG5Ia0dUaWNrSTdMWHB2QS9kN3VWZnpYQ0dmUTVmVTVFK0ZCTHJRcjM5?=
 =?utf-8?B?R0l4UWI2MXA4dW83ZHFQeGJwRytVdE9OY1JnbmRVNGRndGJrY3lYWThVZzdv?=
 =?utf-8?B?MUxyN0laL3RBMnlZQWJUOFM5MHFWaVowbGZhaDhnTGk5OHZwTGNSOWxEQW5P?=
 =?utf-8?B?MHcvS3hUVXdrM205MEozV1JHY0cxYUpiNW5wak9sZTRxYUc0Zi9lVHMzRm1Q?=
 =?utf-8?B?aytLYVdVc0doNW10S0Q0N3NrdUIzNzlsdWNjcWIrYXVjVlg1cUh2TmZKNUlG?=
 =?utf-8?Q?Yq64Y5E54Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(36860700010)(376011)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:27:21.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597cb6ab-abb2-4cfc-28e7-08dc91e51db2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9092

Add the definitions of LRE registers for Broadcom BCM5481x PHY

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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


