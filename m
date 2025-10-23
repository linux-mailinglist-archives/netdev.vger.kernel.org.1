Return-Path: <netdev+bounces-231997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AFFBFF7CE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1501C3A3DB6
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0802DC771;
	Thu, 23 Oct 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QGg/qNi/"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2F2DA77F;
	Thu, 23 Oct 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203805; cv=fail; b=UkUvGQymsUMyexE+xCYIPQ7fMqAe90YAb8Yy2bJ4jnR6caEnApWoug9uLvcBCmgaCzhmK/8HICCaF58VbonGxLbbnXCJ/gk7r2nN6wCkeYQOkJjOyLPlC0CoCYYX/dRbQh3xrtXDGmNfN3J4yYuTfVZ7ji6Lyxklg2bYaVplnok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203805; c=relaxed/simple;
	bh=d1E0n1nadeue7eBe//A5U6cvs1rsuWgf8TbGg7+3KBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R1RFZhzDFv42TU5o48GM60Pke37I5LFVYC/W1R7Q1Lo60N9b3guY2dhc+gmQVna/PgI0FYZcFTIwQVrjavK6BNwQWR3xLGTXQo/BvKb679Bssb/FbPMIrEyboAmI36lyc8uWLRPPzKpseFHl7GjmVGnCGFaHYNFUXzlBYLE1DM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QGg/qNi/; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXOmq6laPXUmjPjSYHetghI3rTWeXzxuuarlFOoT1D1C0nzr+THqo9Hoi28GaOhME59R4W99eTCDf2o99OZlWZ4+Yfcj4x23/FYuDJygDLy/jnAMSftt2ibzQomXpnbVGKwn4qbSZDvCxjuFLFvp3UigwQjLTl7PCxXe2zxj0e/cgSCMNCM4L8hjUQiPojp+J/D7BEGF6y3mwCpGG/x39O2xtrGt3xwmb+khAvc0M3rP1H3YeJ861t/WMTjpVnzBFpnYlSn5y5vLJ9uBuJFD5viI8xJJZBqqIDuDPa2/5+L3FW8zHc4xkPCHYq354xROEjbaTrudakoB5oEcikDwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgKvh7NPde9OLD9oF0KrLyo84YDiJHPhqRDxTVV0o7k=;
 b=RGQlPjm3l9iy0B6O4JWdZnBgWB6rkrTo/15tI2y+Zpv+i4nbNyh/1t9AKpfjlCh/j8xeslraPLPKuMvxEPnRR8gctAN9y1s7/9/BIUT+syaisBRSC5AAMIRST6roaDXmu+/rTdSrJBYrV1Ow21dhjUxZoXOmiXBzNhm1crqaKfF65AVNZZBmgiFTbZmh3Rvcc4a/2ppv3rDYQJwok3/uf/nmEyyI/+WqCMsbYVLQahf2LJUZrRhZ9IozP7SqYm2uXJzxqtQeAjfwTiV+W1zrVces1a0CJ4hfh4MboCCkA1a1eJbVrsqArhGSZFflur12Aw2hNE32lnWEfyGp0bGyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgKvh7NPde9OLD9oF0KrLyo84YDiJHPhqRDxTVV0o7k=;
 b=QGg/qNi/Ynccx30POFV1OFvbd718dYRaNXip7H/lGsZLsln6y5u6yucPG8xLVSKA1JoPzeFD6os6J9RdPsDSg1dXirTUW6iJF3qW1AINGomzs4Al/wFTW8Vz9NHhxXwEySsvfEpvVen1G4jJ0dLvYRQCSBBUD9ufI28ksL1jrCZC5tiB78X9OBpXlkxONRqEx6dxc+q7iDrpCEYsaaWDgY1v2cVdoEVoxdKzG5HY9fBZZCTlJweZechBNud8KOQGbw2CeIc1Yk5oX8MEVMbjeKyG4J0mstrNprPhQEKcu7VMUG0mHrRziPxXH/oBF8Yeu2qbb6eeg7+h03bEPqR94g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11331.eurprd04.prod.outlook.com (2603:10a6:150:29e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:16:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:16:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 6/6] net: enetc: add standalone ENETC support for i.MX94
Date: Thu, 23 Oct 2025 14:54:16 +0800
Message-Id: <20251023065416.30404-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023065416.30404-1-wei.fang@nxp.com>
References: <20251023065416.30404-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 201ec88d-bfbd-4f11-13d2-08de12041ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KhIATo+jOZHACMYkhgQU7UIDhlSaxI09eSnf0s9gvBI+iRY5pwZp19KM4vKb?=
 =?us-ascii?Q?jf5GXbW8IXL2UhJkLsoY/KaMHf3vMEs4o97T3CilBqqgxdFm+rxv6O+iKXTO?=
 =?us-ascii?Q?UFQTKOIItO8P8OFuwjftPL1Gj77fD2YoOjiJwkvuG+qQO/a3JQtcJBEsyZPw?=
 =?us-ascii?Q?eLnCpo6Wmg2oeWUr4gyFcF74WdJnjJ9ioVQXjCQRPQzlXNlMdWqPCrUs3wmL?=
 =?us-ascii?Q?chEYwyIagGIyf2IdqP0CcR0GMpNPDxkPUH7yGJZraKY0C6KZ21QvyFSHalim?=
 =?us-ascii?Q?Z88mvvwl6llBetfWIMYkSf9cBkhRclVIl1ofr2UAGvPtXMdBNVQMbaNiReOq?=
 =?us-ascii?Q?HMJKQzR6EqajO/1pKA8RA2qkk8YfefEwrdIBxXugxB9noh7lOrSTi0B2LThI?=
 =?us-ascii?Q?FsYDCzyzvioPHnDVESyy3ImYnwDX11360yOqrfDnH7AIhBWCaBlB5cGsMxvO?=
 =?us-ascii?Q?mc4qpA6yor6OB4GbbPa+fRmf1xx3wqZh2Qf9GaqkFDlBV/1sOW2U/eEYebGC?=
 =?us-ascii?Q?nus3yhbb2EUb+UkiJwMiMioJmbTX+7qzv3mVDU0zIBtdt4a+Tif32upSdMVw?=
 =?us-ascii?Q?V8De4SNKUXQzXvAstLwIS+UE27xtk2plzfKxL0iewEkp58uulRB2vxBRtxl6?=
 =?us-ascii?Q?QvGazW4UuW4Cw33AJyoNc2g5ky5RA4TiKnD547jpMdOgEEqBwNLc8o2R439f?=
 =?us-ascii?Q?ht6RAXkw9F2r3saLb9zu2uFLsnbqb4VxNH57sIRzLlJcpTmFHWm3QDsnMJDl?=
 =?us-ascii?Q?T8YtWjx3OI/pZaFRvYcrhQ8o7qyXsFOnYnCWMmb0JzADjnwCAUevnoIpjfCw?=
 =?us-ascii?Q?1RXP6L5qhNqev/3vN5js99Jp5cowSpkphEhTWKQHVgU1mpcYO6vO4KUDsiom?=
 =?us-ascii?Q?nJReSaEs+ATiJ29YYRprEYhZU4OezY7gfGjmLsV/v6p3lh64b9I8ZQ8N7F3+?=
 =?us-ascii?Q?2CqMjdbRiMLN731JHa7Ue/V/0ojYAwuRNi4cXV6TC9OvKklS3NyiE946NYlv?=
 =?us-ascii?Q?h+ffw7tKXhGuC1As/GCGgtMDLfwSLDu+YyRCLpEHuiDefYmy2nZljHZEbVV0?=
 =?us-ascii?Q?NIciXhWJ41/0Bm4CZNSCzvdQGS2wG+ovw9YCiozfdjlGheKXSCCnQ06sp67o?=
 =?us-ascii?Q?J9ugFpMfVP0lpUrwNzgip/sgMsdBQ3KtNxN9Z/6NI+ztV41hdMNBLrQmbHhv?=
 =?us-ascii?Q?0nS53+jkhGgFbTHRWDx2lh2IvfxDM1fbCoaEi8pvsR1A8fyXf0picCVSvoHf?=
 =?us-ascii?Q?tNBLHKaZx8XPudg9GjoGm+TWzZPxPcP9UTKtgFrCVoffRUVJ2GflcJ7bFVDT?=
 =?us-ascii?Q?bS1b58huvMQtvs6T6FKLu9/k0CX5LhmFQeqF9W31sgNVUpSScsNe6wT1fEwW?=
 =?us-ascii?Q?vTi8fu+hsLCTY5Tn5hMUqWmT7A2SorlGiQxv3SVchUy+ZDo+/qfqNIgFUlt/?=
 =?us-ascii?Q?CAbjEx9IaAbGFPCIVGhgG45x53Lek/jLRr98R1g//MrKZotf1ywuuGlK/qH2?=
 =?us-ascii?Q?bn5tqLSkTJ0wDMc7C7uBMHZrjBeS8XBNim+Vcfa8Vi7k4pHyQfGdy5TT/Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nmNNryyw/bCaTBjYsmZ9B6KMvvZOPe2niwiqqUHBen4g4Df3NrSLRoo1ouwn?=
 =?us-ascii?Q?2/pgitCNrHB4BpOWsC7nK4YM3fk/TGalZqGpAct8F0or+Wi4+f/oL4i0vVD5?=
 =?us-ascii?Q?0M9P6WSudYq97+vUrO9R6Hy6ZIw4FhkjrzTlbS+5y1XclR1AYU6W3TJdF+2H?=
 =?us-ascii?Q?qmGL7nVbGsia9q5Ac85fVzBug1Y4hgYhUcLAFDYlyzBQfHaPwxI/dVWdeWwE?=
 =?us-ascii?Q?uD/Ggb9oBUh7U6xFux73gmPaetjhrmChjeZUO58LM9bLtGV9bjwxTv3R28Dp?=
 =?us-ascii?Q?sU0x0vF+cro/FIljtGfGUP0Pr6HaUkdx0z2VnYje1zDJQ7pAr1O/dLFMg4/X?=
 =?us-ascii?Q?/NhdYg6zJESTSvqbvdWZCB1f55sAVMngwnyu93Vd2VCANgGF/P9zeG/GtU1+?=
 =?us-ascii?Q?dCo418dKYelg5vQxyvhVp9TBdhNsel2V803K8tdQwOlMNRITAON/4arKghq9?=
 =?us-ascii?Q?gF77an2hiCekuqpmLMCSqbqVuwQ1Pwmq+aAWkdH1cDpsczQhyi/aC/Kshfdd?=
 =?us-ascii?Q?nEv7hUv0xposGJwkyX6ZTvaArrxyXog1dUyjrRbexz+YR3SOVTg76cF+n632?=
 =?us-ascii?Q?0gaYrwEQiej5sOMa8mGhPhq1urLCR0ODkhWBgPGO1Mzh2rmtl+Dkyye/bh4p?=
 =?us-ascii?Q?TUI5NqUese3EKE00m+kl+2S+8cxZrpDpQks0IuGU+VmoIEU1G32UtzAmVOVY?=
 =?us-ascii?Q?LoVo796qMEyc4PunMUjaJ8Y+NeWVVEgYQS2wckE1+kzcrvueO+WfFUcmvpVt?=
 =?us-ascii?Q?A2f5bxMWZPT7AVwCIIjwlFOn2gYNufxECSCYNArUsXLWZ74TjCuFD0BvjcLo?=
 =?us-ascii?Q?gxda6ywBUCQ4KBeAjy30z+MYDz9Qnf+fLLTtspsQPHKZLBENyb+JKOR+Qe39?=
 =?us-ascii?Q?VSRGE+ju/MFXv113ZqzQ2QW8rfw+MzfoUCqCrmVL0YuQLszVquaOBt/vVwoX?=
 =?us-ascii?Q?/gTHXGi7GLGIV1qb0ymKI5qhLrreXNcveVI7LKnX8Uy1x08xlfWCPjh1dnt8?=
 =?us-ascii?Q?mbzJr2KdI4bN3tL1IQ3+2cnXvbjiKjzkkpgQYSoofg2yhlttv7niZAz6GK5H?=
 =?us-ascii?Q?FUP3+i4eLvwerDGkvLPDv9yQP7LCuwVN9XpWNQiJw7idffo2ZyphC0zmZWme?=
 =?us-ascii?Q?pNrZBdh4pNK8E4uSk34eKAEAQS5yOPB+NCziSMRIcO8tXFej8ugQMG6y88PG?=
 =?us-ascii?Q?3eCC0BenaRzVHgRz0lu9nx2zorCXbpZ0yKJ2QFic26kmyO3GdNdOpH1cfS0X?=
 =?us-ascii?Q?UcUYzCG/XuFByj1XAVIQvWBMqtkoJHJ/4uIR1CWzneeNw5DcPqeYe3Bj4OPL?=
 =?us-ascii?Q?WtGTbF0Nt06nPRYgqOV+aW1qHLgie4CMqZoIypqQQQJPj4ewzwjsvp8TvGxD?=
 =?us-ascii?Q?aqBYBDlXSyMAgzC2HP3PG/uOsRGzkSmRcQrUGdbN+oJ0O2x278qygZjCoUWi?=
 =?us-ascii?Q?O4M1ciZA+cWgLuv3OyUIqwxP+sgqWzdpRhs4N6TqAIiLAU5rao//hduW4F4h?=
 =?us-ascii?Q?1aYzGJIhKhgsALYsLyLbHZ0Jmko3qAZWlO64zaRLBrOQqx1qpyJucjFvPAuR?=
 =?us-ascii?Q?zgTmsftx+ASm+oJOvqY1RVI8UzPBmQvTJoAyWE8q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201ec88d-bfbd-4f11-13d2-08de12041ce6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:16:41.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Lir/eNVu1CgN4UbxLTzIHfQ6w5jbnlsd/29gud0Xv+hdATCTJCYoyZAnLlXDRv2qKaKodItQwfVrPOa61Htvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11331

The revision of i.MX94 ENETC is changed to v4.3, so add this revision to
enetc_info to support i.MX94 ENETC. And add PTP suspport for i.MX94.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 4 ++++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 88eeb0f51d41..15783f56dd39 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3732,6 +3732,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_PPM_DEV_ID,
 	  .data = &enetc4_ppm_data,
 	},
+	{ .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_pf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 5ef2c5f3ff8f..3e222321b937 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -936,6 +936,9 @@ static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
 	case ENETC_REV_4_1:
 		devfn = PCI_DEVFN(24, 0);
 		break;
+	case ENETC_REV_4_3:
+		devfn = PCI_DEVFN(0, 1);
+		break;
 	default:
 		return -1;
 	}
-- 
2.34.1


