Return-Path: <netdev+bounces-206099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA2B01760
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DB21C460CF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC7263C6A;
	Fri, 11 Jul 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LZrkHCLk"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DC262FE2;
	Fri, 11 Jul 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225249; cv=fail; b=mS4jwG6y028P3SlQ/IGbvbUYZ+bftM9s98PNUuPvoxIjUrp10/UuSyVgDvIRMZlOFrmCpFZn9RFntKEEaLffezFxD4m2aTCnVIqXu+SCykXP/HfdNYHjHDishnRIXQdqwp+ti2t+baW5g7Bk8dboDIMwY2QCcxX9+CAoijFlIdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225249; c=relaxed/simple;
	bh=hmE4Tn0yuJ8sPH05g4scRBDgNQqPtZSDX9Nsgio4/Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1/nq3uPreUg5nHET7Qh4aBCUub8MkqMK+f70WmN0X2Zo6WqLPV6zY8YLiHgmJf1SSC4n+icU1aN1ZWWuNIKQI7aqBElE7Z7uHF4Fr/C9SBRo6mqyS9qC9fptcrfWaOCFIpNUcdC6U3H7uZdthWWs6lyBThUYbQ8GqswMIxYSW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LZrkHCLk; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgDy/zoxmi6zOMef6m6K5WZ4wkAZxYXzptIMP7RT/HJ0y/X7fR7TJjFC3EE3gtWLoCZuNBmj+rQwKIp1UNLOCKA6VJWb/XL0kgmH3zMXUZ1KYsJOdqDn9Kgw83vN/+pCLmWgaf1e+1oKxekNkDthpi0GAPBI/GqyYJWzvHqsOAAFDq2JYuVz1idwujaz+7yocCKy4cjvJrSn47KItgbLJoSFqXav+95mmdcB1/WHfPhZGK4Pm4BOsocH636FOLwcFPMW0A3k5tIaISrQtU9EpHpzFfzZeVgIOUhNlWx/x1OCNZZ6u2B83Zi6fMGVRoMilCw0s/dVfeMabS+w6Rx+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6960F6+RwJZ5q02vHpKLxBSdrWNsE+s6RllA0aigGgM=;
 b=CUucmLdtSnRJ9itDQyydPdsCUWF2gPutUuEa8vf2jMPaM3NLjtDeSxZdpU33JL/2gQ3+yj4ejD6ZRCDGpicbdqD6BYPfuD0pOe+tWdhVXmB17BWdByf3OWNrTW0Syh9hLN6K97mY7hzk+XnBBF+y9pIV4cdfDRaPgKyP6ktGL2Nc4OVBlzjf4K/WpH0p4sMvjehdORrVfLKt6BEzElAn20YdUSZNUqmxTjNtF5U7d6Jd7/3kNLpwXQX/p2O3oIQxBaR0Gxsk2O6FjEZjrzP8+ewnz4n7S8R+Q4GcDkSJ/aHcdElxRBry0JWZlLyNBV1KD2o5FSw8oDXuva83XXIjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6960F6+RwJZ5q02vHpKLxBSdrWNsE+s6RllA0aigGgM=;
 b=LZrkHCLktsZJGcD1EYNN0rlnT66IipR/JK1BhMfvQ823gEDmyBQcB9XA6LXVKnKMFwsPcryvCKapBPDuhv2h+338zLv2R37fJSuonz+fnOqDuMIBPQ4MGRIxqIXF1lj9geCrFN13SnSq2ALvcCXpvKuehslF3XrXwja0GW7WeM6sbGbEDsT1QCcbzDTN1lu7ZmpL0IDjixHdxBgzrggseh17MRFvPywusyvMYOHKusgxN8A3ceDlkJ/Oj17ceYUzzxIdwSlN/GQ1yVGaYU/Jf80jqSHjbNCS2KinedbnKJq3vhp0Afs93g+dkFMuFM0aYj2Tg9IrRLAhWv4mkfVaFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 09:14:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 09:14:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 1/3] net: fec: use phy_interface_mode_is_rgmii() to check RGMII mode
Date: Fri, 11 Jul 2025 17:16:37 +0800
Message-Id: <20250711091639.1374411-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711091639.1374411-1-wei.fang@nxp.com>
References: <20250711091639.1374411-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: b267591f-7325-4d41-c8a4-08ddc05b47d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xe8dqgP/w8p0XfR6t9eb8h2td+Yj3vupEiQt61uxVVWjWVAl9dJ+BOdNw/xH?=
 =?us-ascii?Q?qjwtYRqLkbz/XCqD7jtxpNo9I2S4qsxtxwi+W2a3xExul5hD3t+mVJAsdnZF?=
 =?us-ascii?Q?U/ujebcrAG0qy+aXRXT3E7FUcSEcUUb0VBukduB9adel2rRzJWlTrqwwM7e9?=
 =?us-ascii?Q?IhqCn7DB2429DTsE0ax2xzZbeDc8csYEBAPzS6BOoKeHxE3AlKpZNeEiPH+R?=
 =?us-ascii?Q?bXkqGb0RGwCtnUO63MOBNGNAG583aN1FNu2e/HlWnDJKtAX20SNU6Czit8Jd?=
 =?us-ascii?Q?963fcLbEmgFRLC+bZq1k0LbKwB8UwbNlVV3dzuvggmtEkknXkhH9YlbEmX+S?=
 =?us-ascii?Q?ceyKjRcUWzIvpruArlo5qdszoEzC+OmCsFVIPOqW2O1pWqvnuf4whOAzMXxI?=
 =?us-ascii?Q?TJ+vAffXe2MXy0OVgAQKl8mppKTWpmjDkmHVEQfL9CH3J/2fzu7w6WXG+/DR?=
 =?us-ascii?Q?Jks/L/EmaFtZtnZlZsuHcRmWCXgROJFS958ertP6nKEHV0ysz94+YhtfSmTM?=
 =?us-ascii?Q?WO+0FLwL7/+9QAKG4nR2sCrBJJS6tfU1w8g2yJywEu/edC8Tv5gHLZ/gS+0D?=
 =?us-ascii?Q?ohalmxQ/BgrHzBqmYpBrMyCuDremFLtfyt4tblYOTqct4hXknfwG12BZ1T7u?=
 =?us-ascii?Q?zyffp4L5WFydVpGFb5gEeF/qzOYHqTED9HYfr8MwCZXGHcWHguO/iiKkJWDi?=
 =?us-ascii?Q?YVLJiHvTw9OEVfLI5cHD6zzrBwjtyYw36ryyNRnFjM4/8CLNdT5fFq+82glk?=
 =?us-ascii?Q?zrMXjRdK4lhp1TfIrUMAHT6tCewU3NAFLB20tmD4fxJVcaPrup70am4YVsAl?=
 =?us-ascii?Q?DxDfSXCfaFyClBpnAo8VjkDdXvby/40spLM8bAImMi+fEzY2+4ohnsgEiiua?=
 =?us-ascii?Q?9pYRAgdm2wiJUJff/0J0DAGgqzZG4mE0J8Rg1DQCnc1NbFZQePo6XKsiK6AA?=
 =?us-ascii?Q?+7w6d6xega4/U5uEdeBAv4PX9d28OEX46LeOeJFKhtHFGZ26xVY6GtSkZpGs?=
 =?us-ascii?Q?lrakI4kthnGt0Xfq2ALLj+rUrM7iqCvskEqlwQlzjTd89HQbPqT9xCU/HDJK?=
 =?us-ascii?Q?yQhCxcj1Mp1ZrDOe/Vg2ZOF4DS6MU6r6nzGxbEfPsOnKcTBnYEUJTLpBf/ue?=
 =?us-ascii?Q?8wPCbb0oT8ajqJ91cHIrGhotoQYfrN7EdMtmyLUD+kKl8uP3lReO96eTqgH+?=
 =?us-ascii?Q?2sDUJ8Y8eW3vKuiIRnlWpQuK10AYYB7zwnZWSz5CcozgA/CZxMkW6irOMWQ0?=
 =?us-ascii?Q?rQZNab+jd3SuBnhgNXoePlIkkcbBmAwOaV8en/nBMzYA5gYNBIJBWpasNE0d?=
 =?us-ascii?Q?/y++6vJHZByMh3IS0h8hAB8GlApWQbLbIKRlDTDFyv0ducJRrGfo7MBsKGdE?=
 =?us-ascii?Q?7xEhEnfVoeHxmf5hB5xJkdAfre8ezi1PUOxWcXtrK5mS7TVpVyLGOUwcPlIS?=
 =?us-ascii?Q?UxMwC936IflkYZAfAKYajxotf9WpLUu/h3mQVXWRzJ3/WeWSL69yRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aw7QPyHR6URkxuMAa906OckeCF3z28rL/QPfX0THGpruA6fIR3w47kVPNGUZ?=
 =?us-ascii?Q?hGpu/DNJ/V3A6EYB+RL9tF7nZoLyru+4Ys2pw08hdpBkCSHxYl/kVOW01L6J?=
 =?us-ascii?Q?RrZ9M3lvihnTw7BlJR2yXFiFLuzb99jJabJqHJ2yNUm5mw/R69WzukcqClLW?=
 =?us-ascii?Q?jKTCYb70X9mwcJg5VLOym75yQ/eHzNPvsaOZ1QGfIIQYcTetlFpaZvHtMa3e?=
 =?us-ascii?Q?bvbUGSXr51C5W5/KlgB+kOihLBEV9hmyhJmCM22tHQenYp3g5FjigpPYywby?=
 =?us-ascii?Q?4x/atKYKgSRT/7wCY+oSqUV0V+P1ASF5iNPDH2Uuv34Vrww9ZvBImfSySBOK?=
 =?us-ascii?Q?xomIDhbcIFJqTkqn7yR6ZtHrDQ32u9OrKTX+4AVjlW7QzkStaC7WV+st7J3h?=
 =?us-ascii?Q?AF4C6SSZujnhI+10UiHLOdSave45tu/IcMFsdTy8ItWNKIXMFpfdEQR/kpkS?=
 =?us-ascii?Q?ukGB/zFTNdC8fLSg6AMfjp8vd3UJ6GkQ7IbbVq4zYQ+oL4wjv9Bhe1WLx3r1?=
 =?us-ascii?Q?xUcj/a+4P5BRA8mlU0NKPhqgUsDhVrXIXLYkqQpUPPqb7NLaEaqxDCwjjvC6?=
 =?us-ascii?Q?HtsON3ScTxdsG3Yydygx83fFXkaPCQhcQj9XURH3DBRejWzOQUS4QvSpWqCt?=
 =?us-ascii?Q?ZelIbYGduvyyKG4tXhsLj8BL2yFlv6DaCcllC3RtwlVU+KZb4WzkeMw2VUxA?=
 =?us-ascii?Q?OcR2iubMqsjKlpE5ea2tNS3EPYALXmmm2GnaaCvHu3xENlzzJS1HCb2SRwpw?=
 =?us-ascii?Q?oeMup1+8KWBQs5NrdXiFsdhusAuzOEKCT5Di+/x7pOlSz2t614nh2TqHmQnx?=
 =?us-ascii?Q?koXVKTxOWaBHvG0pwwqNmmduSwuMFqZZRg0NdDmWwjLGVsg69QQiOBZ8Vhji?=
 =?us-ascii?Q?6WrltuPUDQs2ilAb1Pf6IvzzkUz6DBjzUeBjQ3ksj4oIUbeAi1n1Kn+fOFeq?=
 =?us-ascii?Q?s29OHva6s4y8Ipialq9lsqM9R3Y5dhW9ZMHBe1piGqt4/G9//lJtHnlQg9LP?=
 =?us-ascii?Q?bq8FzfDY6xh9wo9zzhD3CSknLupVHGUr0DsByTTeiyFYHlmwb81BAPMwAWbG?=
 =?us-ascii?Q?D0d1t36IT8sjXkBHG8QDGdijEY9aKjqY44/RT9/GG5iT33KrY5JrVMbIfkNg?=
 =?us-ascii?Q?AJnoSaQRj7WqmifUsZtlcF1XSXREdNJadWH+2oq25wTkmGLw5PXKTrYoJ9Xp?=
 =?us-ascii?Q?ssp0Y3CRW8CMkxsVpFFKkrGRkBqOCNdFRJXJ9oC5CmSr0T78jBOccp2mhBWN?=
 =?us-ascii?Q?zJkWc05KXfHckc3VZntfZKluyNOyA0osrKJkX7r1eEk2g25OTCfXEdP0AKkE?=
 =?us-ascii?Q?mr6HVnB2HeOdu1MVmCRqF1/MjQpvd/CYIvzyjQwlaEm/n4dUrYT53Uw9pu3D?=
 =?us-ascii?Q?dtvhvZPZR2wCPFgGcUoKMMl4SBHPYmcvPoVknvL2zTOqyi7G0QnlWxGhaIR2?=
 =?us-ascii?Q?xuTHHvNPsIdDHy1Y8Rd3q13giV22GaJLcvKXJwDPSpE/mgJff3EfIFrbDCSc?=
 =?us-ascii?Q?+3+ZjTF7vjqhdNbx0ISsdH7IQhntl2GSAwwZzi25LKHudjz1e/vyhwCnatAk?=
 =?us-ascii?Q?tIoP4s8V1kLVHRmz7Pmku85VDO5gU95WgDJu2an4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b267591f-7325-4d41-c8a4-08ddc05b47d7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:14:04.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0oLOsuMeoZzQEzQ2p1BFTqyzYEDLU2vrMQrIwrA+/XlcmfTb742/aXCk4PnTs0ydmCRPYccNJFbu3rwU2Y/PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

Use the generic helper function phy_interface_mode_is_rgmii() to check
RGMII mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d4eed252ad40..f4f1f38d94eb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1194,10 +1194,7 @@ fec_restart(struct net_device *ndev)
 		rcntl |= 0x40000000 | 0x00000020;
 
 		/* RGMII, RMII or MII */
-		if (fep->phy_interface == PHY_INTERFACE_MODE_RGMII ||
-		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
-		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID ||
-		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
+		if (phy_interface_mode_is_rgmii(fep->phy_interface))
 			rcntl |= (1 << 6);
 		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
 			rcntl |= FEC_RCR_RMII;
-- 
2.34.1


