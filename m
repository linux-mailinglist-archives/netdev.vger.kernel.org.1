Return-Path: <netdev+bounces-109817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809592A025
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7B01C21551
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E797C6C0;
	Mon,  8 Jul 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bWshMsOk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFA78274;
	Mon,  8 Jul 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434473; cv=fail; b=OAzCqBynTKO/WIDc6redmQR96NjXz6u1iWwPqtWsEJxiG/hPmgdpcrVCdECU3rc1ybTWnVJw9/7eh8+pb2BhUOIHZTc3BBDoCdLfMxNrn9hR9bHjJwz96lFxiRH52onnjKjwympHM2IQTbifoH0KZFjbK3d3OBKp989pPMX6JGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434473; c=relaxed/simple;
	bh=nW5o9jacrjPWOuxhoPe08F5HjFKbOisKW55vInEX5jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkcucmpYalqD7I9yWNByj1KqAlxAVG1/sJkk+q79qiJc6H0fI9ix0d5vlfJTPGWfnh5XcVYA/ijz5z4KXNLFsRfNvKmzz/4ICpr1Z5rZQA7kNpT9jWcOjeKmqJQM1srALTCqiYAf8UMe8USYIkCd01M9QHaC6Mpd2e0LGLptXNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bWshMsOk; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSxpk0ut9qFYfkx6YALiIvHDeMMHsgtcT+RjLzOUlw6ZSjPEWA5jVKpW5I1b2xd2bSbxT7nZzKnRdynHzmE2bE15s0gfxQUi8nudMsnWd23qONvjUvUKj9HEKsDaovXyFDoCon4X/ulZ3V38/CIpcpwuQT/+N1kC9fUKdmda721n7TCbz9d/tex7tVA4ovXK57TOI86DG/6A56PAXpVKmKJ0b2nZuUyzzqsUkDyIFTjW26nz0bPOAkvMsMh/fc4Ze7ec/T4GKP6o+nXkGMGqAM29YtwwJank2oY11/vbZwfIjmXVfoVgswmQmsUqeW5wUrTMoIe0wU9mVr+1Jt8PDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ggROmr7pEozEH/Ekc4IbP5so+Dk1/2A8pLpDjNwcBs=;
 b=d2c5jeuwvhey4FgRIqW3+WV+L1jNv/+h9Nq36WCVwLZ6GEiMyIOFF7zc/0r97wdoaEfhbd/3fKKTj/bAN7Wl7YD7lmZ9sICvhmporC49R0EnE+JdBgbXi2akY5DCkzr7EfGKLnNkUy+iDcDVRN8cLSMnvJqLtSrESwDzaXlnQI1qyGqBuv7Mh6/OPyN75ElDtNtStcN7BfOq+uI2ZJTTnGfqeo5UnAumeLFTeTAgmhkvZtTQMZmlGDZQnIAHRrVtPJqm0pSKeUObTh0J2aR9P+M6CM/HSdMRpw8rTzt6CvAGgLhY3e3eVBJ3+kRivVhT8TrisWXxYxUtZywXxY0a/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ggROmr7pEozEH/Ekc4IbP5so+Dk1/2A8pLpDjNwcBs=;
 b=bWshMsOkhKjdX9YWQFODMh+PR+Te53WO2TSc0QALVfqaxRbaB6kkHGocCXqU4rmx6X66JnFhiDuQtm6g25irban+8qjYnYY92o8heTw5P8Wd8YNL7TRHIJ2P3+l71GOL2bHUcahpGAebVf21N10QWFRYAmNU+c6pdRsUNGLO0Pc=
Received: from DU2PR04CA0083.eurprd04.prod.outlook.com (2603:10a6:10:232::28)
 by DU0PR02MB10013.eurprd02.prod.outlook.com (2603:10a6:10:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 10:27:47 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::9b) by DU2PR04CA0083.outlook.office365.com
 (2603:10a6:10:232::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31 via Frontend
 Transport; Mon, 8 Jul 2024 10:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 10:27:45 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 12:27:43 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 2/4] net: phy: bcm54811: Add LRE registers definitions
Date: Mon, 8 Jul 2024 12:27:14 +0200
Message-ID: <20240708102716.1246571-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240708102716.1246571-1-kamilh@axis.com>
References: <20240708102716.1246571-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|DU0PR02MB10013:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfb6189-1191-4763-fdc8-08dc9f389ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S210MW9Za1VTSkQ0SU96Z2c2V2RVRWliWkU1V3c0cU00REtHOS83ZC9VMlAw?=
 =?utf-8?B?bUZzNTAxcmhxc2RjU3dVQjUyNG5mV2cyWDRSakFoRC9RUjRXenR5VCtkOFBC?=
 =?utf-8?B?TXk0aEp4UkxUOTErT0JRS0hwSFFGZzVvbmp0WDkwdmdUSTRIZzU1TG9vOTYv?=
 =?utf-8?B?dTFqTjlzZXNTZzM1OHB2em9uMlFJZ21ac2ZsUEhrOENpQnVPT04rTUJZbzBK?=
 =?utf-8?B?d2tzLzNDR2FHTHFLWFgwcmorWDdUMjcvZytyU1hSajd6SW1oNEsza1VDa1Zz?=
 =?utf-8?B?QWc1VXNVbklGYkNZK1M3K3VGMjF5QnZLb1lwZjk1OHR2QnRzWVRTQ0pSb3Zy?=
 =?utf-8?B?NDRLUDZWMi9nL1pscDMwOStCSHNmV3RrUW1Vdk94RlIwalNQeVpucnBBNkJE?=
 =?utf-8?B?MXBZaCtKdkEzaEZGYktLK1FNMHRyRlRBckdFOEYza3BTeVYvZHNYU1lmMHc2?=
 =?utf-8?B?QmFsV2g4bHFBWGhiaHdXSGxEaGJJRWQ0Rk1UZWRMVmErbS9IZzVLL1k2bGlM?=
 =?utf-8?B?YXZCMzJJYXhlcmVPTndmektkUmU0enJmZFpScXJlUW9Yb3NNMXRTbTJBMXRD?=
 =?utf-8?B?ajVwL1RROGEzNU9NYXBsd2xPU09iN0l6aGZzMDh3c2VOL1kyTERHTU93M0dw?=
 =?utf-8?B?ajhud2hGb0F1L29DdHZ3eDl2MThJUkluaGVMQ0JtM1YyR3JQdjFRSU1ZckhC?=
 =?utf-8?B?dGhtT3ozRFBGQk5KRlNBdHhmSE04YUdEQVhEWTVHY1Z2UFB2eXp4dWRMN2FT?=
 =?utf-8?B?ek1HQ1FSNmtPUVMwNFNDelpwcHNpeHVFaVdUZkY3Sk41dEg5d0VBb0pmR2ZK?=
 =?utf-8?B?TGhlUVRqYjZ4M1ZwR20zWVFUZHprZ1pDR3cySjU2Y09CTk5nZ0hpVHB5bnJM?=
 =?utf-8?B?V1UxYjdHNmpQWlg4a0ZBbHNhZ2ZtdklBc0ZjVEt5eUFGTUVjcjNRaUJTOXpZ?=
 =?utf-8?B?cDNsN3FCdTg2c3pENDBDbzRnVTRlVkdUd1JYSVQwenV4Rmw3SDlsZkkybXJ2?=
 =?utf-8?B?YTVEWGxNSFk3UkplV014Zkk0dnBYN2tnUGJ4UGx5MDBwU0FoQlJuK1VJendx?=
 =?utf-8?B?SkZtNzdIaDErSHJ2ZFpYY0E1Zmt6N01ZQTExTFpiS2UzUVZFekJOMXJkWkdZ?=
 =?utf-8?B?Vzh4ZERibVI1STZ0MHYzZ1hEZUZKYXE1WHIzSjlXZkdRQzBQdHZSejdIL1B4?=
 =?utf-8?B?T3BSb0Q3RnQ4bG02Wmk5QjFta2JINkNnUXYyMXVtbzNDUmVNUFJIZWRxa1FJ?=
 =?utf-8?B?c1VzaU5KZEpWVE50OFNPMXBpSWpvSDJ4L3R3Z1FaL1Y2MVVPK3hvcERZUUdG?=
 =?utf-8?B?eEpLazhKYTVKNWpMNzczMFppbVB0Y3BFL0labDA3NWo0aG5rOWk2S1RXWkMx?=
 =?utf-8?B?cXIzVkRZRlVIRmp1M0lZeFVsZHNpYWlCQm1zWDdHdStMS0g3KytCTVFXUXBm?=
 =?utf-8?B?QjROWTh5NEZPVHZ0aU9sS2lIcHFuWUQ2YlJURXM3c1poYXF2Z1ZPdFkwUVFm?=
 =?utf-8?B?MGdWenFsRE44ZEpJODhHYStzZXZOaEpnR0lrVXpsSFIrUU1RTXB6eldPVk82?=
 =?utf-8?B?bjJWQUtUQ01uazNLZ0VYSDdISHQ2am9jL1poRUFZREh6eVB5VHJZWXpaZzYv?=
 =?utf-8?B?M2ZnNDRaL05lcFprT0ljT0ZIMnFxblFSbEZpazBxN1o4Q3JjdmFDdzBaNGI5?=
 =?utf-8?B?K2JxazJSQ3UyNFp2SGdmbjRPUjZCYmlac1dHOVZ3c3puU2hxQjhkWFVDTnE3?=
 =?utf-8?B?bU5pL2Y3UThjQk1hcFBkbFB3V3JPaTZqNXFsdjZITHM5RXQ1bUcvcSt6NzFQ?=
 =?utf-8?B?b25uT2FlMG1XK3pQVGtlL2dZbTRJdGdCYW1XNVRpRjRJWHA0dlVZYkFyYk9C?=
 =?utf-8?B?QzZPUFgvLzFHNzllZkE3Tm0zM1VXSURmdUFRQmg5dGh0L0Vpa2o0empYNE03?=
 =?utf-8?B?bXlHTkROaGJKMjVuc3haOEZ3ZkUzbzRwRUpYK1kraHlvNnJjYUdZeWh3THhF?=
 =?utf-8?B?STJIaS9DaTNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:27:45.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfb6189-1191-4763-fdc8-08dc9f389ba5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10013

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


