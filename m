Return-Path: <netdev+bounces-215690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA847B2FE5E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F271DAC553C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79322C326B;
	Thu, 21 Aug 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E682BXa4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158B288C22;
	Thu, 21 Aug 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789691; cv=fail; b=EDb2etYmMzM6oklRcwBfQckpNyrQGFYG0uuw20ra5srRbdULipCHB2qKpflLDt9+yd/Tk8T+J7uopMA9IXS9LYoY9LlDdnD9L45T1ERLZM+PhrLNY6sKkeZ+UeM2x7kPrBf0CJkzaFjpNewuvnqria071ke2MqGW+KKAf+b/6qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789691; c=relaxed/simple;
	bh=SCqmxOKDIm2qWTcNHAh1iK9IURczPHwI+RIxp57SFdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhDWyqAcAlQRNcydTP/WYGk4knlkj/VeSCx3o5LVl2xV6zN7QTYUUT1yXSYM+7FqA3zMekvIffjLhCsRwTnOGQF2xYrwQn5ckHtliUtBKgy22UQD8j98PoJ9bzRTzIgUiPcXVnev7oamdHauB/xud1AOMsjmGcjzlVLE6ro0wU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E682BXa4; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPL2kazwUDdhDR5lRTzAMT+9XVmGWYphMKmpoh68pXi0Z84L/XxSj8FUgLNPnbMPrzp+fVYkwPhWPRc1OV4IJFAbRYbqaTTLFMBhHEXrPh2H5LYj3fMGKCvZwF8+MlRyR1kI2KzwZZ+25D+pk3J2lHAzxkSEeAE8Y0rT+7sOmGXVyklRbVkGNdHFxZ2lFHLtZvkPeFZR3XYd5qVQafw6Z5QznnIBsaCii6xpeahDQXRAIc8wkglskAwmTet27a7l+ocj0wU33d3DTW5HWx2PA8Cdva3m2l2Z84tx2ipSdSgbsROld20BwgwMdjtkTfM/IaErqwDZnDR1DclvPwrTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj7SlPVkCBGuSSnls28sZTXSY8KlmW5lLd6Kjegf8TY=;
 b=XgyJBJtfi7Hebqe1oqc+T9AmamjzsVKYJrnYWI8KNC/Ax4l+1KcPfMtZoT8KGtlzzSihY2x1/bVxUqzMJdZ8CDdhDv+of0yZNJwVVnJ+GRcSfo86eDUU0O7+cIQLnTvFEcPDpQrljVcsTYNXJ1g+VxqGKxf+mByAfSGUJMM2N7FfkuNOTlYetPCKkJzjMwF+B/YB+ZSBTgHpRzNLhD68Z7eOHcUlZXY2CXVve5PqJprUmYLKmKTmzys6cQ5sp15kO5mXRuBuPN+1/EzlN3rwd4gLzb8LXY1cS6GMAzdIefZHRu48zoT9WSzaoy7pPJCvlY1+HyeLfPohO4G2o8VXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj7SlPVkCBGuSSnls28sZTXSY8KlmW5lLd6Kjegf8TY=;
 b=E682BXa47OUEl0d9iJq3my34zTZoA0rxk5PQdH+a2HJXwlt4oyghet0im0As0nx3YSnR4QrszwRcYbOiK8L6Py2BBEvRrvaAIALrKEowEFKsgS2uvOeSjAbveK7rV15beOsnzhlWF+W9n52nDSXbJyv+oKmKr31mllCXHd1P0lDUsyK1ssGx7MLITTrq5jx3wjRci5OefmWUhza0PeU4FMPVkUUgLlSPnKMtD22YH7IXMrSIlOLZpDbhtcDfh5uoRqtcA3fWnAPk1QDPjkvRZfCVN2dsSKrl77Sa/x90HNW7JPGuCTLBjwe2fEmsK3puxnDNZiTAMMtiUvstDcdfug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:21 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net-next 06/15] net: phy: aquantia: save a local shadow of GLOBAL_CFG register values
Date: Thu, 21 Aug 2025 18:20:13 +0300
Message-Id: <20250821152022.1065237-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: 99443d4b-17d3-4ff0-069b-08dde0c661fc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Cu5yVaCohHdByU0LJeC9iFkFRE4ITSJy+c9yr213xDFEmRYRvDdUL2jQ5oFi?=
 =?us-ascii?Q?bPN9J6WYTPJxfrtV7gHxPFZAwZPu3jm3ZrSRWzOTuviMxWBNG0STr1Fgqqa7?=
 =?us-ascii?Q?FFuf5rzq6vzyVSizNJvNOtrwq6grNyYFLS43vCUs7NSkjkdSzqBj5j7X1kar?=
 =?us-ascii?Q?umUF/u0TtpN06oxTUZF4NRpo6D/6RtbfuRdF22WPM+2ehPKZ9imDhkj7KIAL?=
 =?us-ascii?Q?zVKVh5ZtiG64S0toraxxtlHNBj+qcDARFZ2Cq3+ad86dCvJZB/e1PUF8RHOB?=
 =?us-ascii?Q?vVDMDKUZZu0ndFoqkvmu2Ii4cfOaruYMjNp7OC0/HcfqsPBAWMCdFmd6sV4h?=
 =?us-ascii?Q?T6MeBqqJ2kUIvrr+vEeQGMFNuR4P++Eh5oD6q/ABnsObL9mjsrielmVTY/vR?=
 =?us-ascii?Q?42IgkoFPXU2nRXsDRyxEXrRCtKoA4HQrIzQt8scvEn3U/G3uPwT+XwJCUa9i?=
 =?us-ascii?Q?329QSLbHFCZMTA23JtUMX4adIXPs8JOBKqewW4ZTwEDRx6jSPznhsbsklrec?=
 =?us-ascii?Q?87aFZUtsRZEVPm3FbWz46SH2j22R9Yv8rz2ewYzYm+S1dq79He2gF8NvoAiE?=
 =?us-ascii?Q?lGBbJPIxNKvGogboeiN3pSyPu6pcbd1D/e47CpNJHuBa8d2kcoL/HSlZ9JXn?=
 =?us-ascii?Q?nSNA0A1CXnhGJXY/10W5HuyZ/cab7XLUCIaGD3VlVx6wOTKvSj+4B7M1SAg/?=
 =?us-ascii?Q?gLsUV8xPjE44wS1HC909sFEXFmFMuWEDbM7IbGpouu/QmC1sYu1pazAle0ZL?=
 =?us-ascii?Q?Ik/ETDs9rSy6GfsgzL0h+JEpS60yTd1RzSU79IDtbaDceNDkFCvAEACLFVJ2?=
 =?us-ascii?Q?eBcLYnow9obOS8YCYJHHy80Mkh6BiMxiBomORENtbcRfm2+q5boTD93RZYkk?=
 =?us-ascii?Q?yIQizs5cIDAVVzMPN9YVUq1ro9We/583X4m8gApLAP/bIHXQeYg4S6WvmsWh?=
 =?us-ascii?Q?ihjsS0W+pRa0uqdUFzeZScWKg3vVK8UfG9CUWBBRgV2VeZPi/vacnDLcCxag?=
 =?us-ascii?Q?eWMw71wxi8eLKVNOwr0Jm4ITajARCsl+cK/aFyiH/E3g8CU8KGIUqQNsJvAM?=
 =?us-ascii?Q?0TLuDeeziKfTKjC3tJx6rvl+Wutn7Yb56w9CtcCPeuNvTIOUXvx1oW5/HE0Y?=
 =?us-ascii?Q?cTyCOD1np1u1ks1Q+C/ePndrh8WOX/Ul5B5CbYNBNiRtGvKyJo+VE0heqwrL?=
 =?us-ascii?Q?2OOiHu4mLpMN9FmiipYPNVSr3DBpnwt+65pJnsFAE7XLfqN+EAJ1AXZjf6ED?=
 =?us-ascii?Q?sr6FXrGoe24x/xpI++EUdI/PaYbbQpDORnzZ9puWj5tmb/S30d397Ls+b6FD?=
 =?us-ascii?Q?QjQamjTYeFFg+t18LdwLJOCCN0cfhy1PEm3NQr7O9TecDlAt+xBQI4ctAWoF?=
 =?us-ascii?Q?a5CpvxlEaZcQeDQRjzethTgFn0QiqdomcirSgLVvPE4bKu/tZHFb0sFRPm5f?=
 =?us-ascii?Q?vdQojP+NY5qUG2bTCpPVQ49q7zoJHzAT1km+f7iUk3OwoffkayFnPA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?wxsq4Qg24qJkUWIYTGPob/1vqaGo8O0jPFkEMRxBd6gky/U60RtiNKnR1cPP?=
 =?us-ascii?Q?EKGr36HVkeUazAruF63icRHIL4MhWCwpAU9cz166CytKilODjEAAgtOk7Ro8?=
 =?us-ascii?Q?UX6xXTSFizHmsHrDkmnzVW3RBEAVEi6nnygwBHOcqIv8WRNgRVIJCLYzll/m?=
 =?us-ascii?Q?HjgAmWiW5+PgtnvA1DSoUD8IuLSq37yz/LtaQpnPcRppSkOv2OJ3iukTJfAd?=
 =?us-ascii?Q?bi8v+nahHEcFeEHNmTKC5u6n/WksQGmBh9ibm/2zCdN392YfBZLQPA99Lk9m?=
 =?us-ascii?Q?ISEv0Y9sHPva4NVd2vjUbZRPM8nybwHCTfz00bHXPcryd2Qucf3FusvH4x/+?=
 =?us-ascii?Q?I7jpDzaMIsOMdKpD+0FkQk0ITDfzcSs5r/TsvMsAs7IpNIJ3yL9oCFbtkDse?=
 =?us-ascii?Q?/QIPlg4qtNg1DUBHDmO7tf0boh9YQ3ylU70AeO08amEJvbAlx5gfK0FFMd7H?=
 =?us-ascii?Q?+y4bBzSKnp7+bximi+QTcnQ/p29Q5A1hVprwCyuXA4hkWx0GWyfWjrq2dMRM?=
 =?us-ascii?Q?i/tR4ucG1+tta6ESW0F6O+KxViPBhrlwrh/kI1Z6ldELPhE5HJq9cBW5wlU0?=
 =?us-ascii?Q?VjYU5PwnBEkU5Pv4dX9zdck3T8Yx1zoZ9qcX6elR/9Lu3S7bi1r4azAM4DqA?=
 =?us-ascii?Q?oC1E84nQYUJeECDoX0nA07Dgpp4Icot/N/YS8ay778eeTfe+7OQN7NHE/gU9?=
 =?us-ascii?Q?IVku41twjMAH1rG4aMV8dU8kl4XnP8QJGEukEm6LcZ/1gkqG9m/WwD0EzBcg?=
 =?us-ascii?Q?Skqwzkz0VWVOECWLadcwqOKRn4z3429ryHkOzrmk7a1oPiPgUEMHSdyCJlFs?=
 =?us-ascii?Q?y7mWZ9YcRZxNU6q/r1CTUIvjB6xM1eCxivWXia9HE4P9g3HJOdiOoxMuQwe1?=
 =?us-ascii?Q?hB43nW4emP64f0BZ2/5owPqXfMnYutGcge6BjTPoa2XPP9upV8hWPx69N6ql?=
 =?us-ascii?Q?N/bGthBqo4irZ7ozMdgBWxIUXhag+KlZuVVEUWquZS3c+pKutxcZ+fMisyfa?=
 =?us-ascii?Q?J8MvmmWNqOGSmduYlBrCvDdZtjnQS0Kq4ZRf8R9ZBfo/2tF4PvvsXDfVImJc?=
 =?us-ascii?Q?W3q2KCStb4w2jgepliuN/WFfUjtQfD4DZ2XqZWOesVMhBqkzfI+S9yd94L9u?=
 =?us-ascii?Q?qeuAjrkjqQ8x2KdlJlwKaSEWnc9LLMZQVRKnUaYek1eA6d0uLKYd0favS17w?=
 =?us-ascii?Q?gYBzANxslmhmduHB7ESHCenXGbddc84k5/mjHz8q+lXyus3OYx9hfUuaXp2n?=
 =?us-ascii?Q?3m4VXN7KgE6fsNFbBdd0FWvVjddA2FhrVrPr4btk5thzSuG66oZkVQBr9i1A?=
 =?us-ascii?Q?tY2ErSn1dztKc5nKWxqeGA8ji1MMiNcgPI5AxVNqVWuOrVzYsQ7TSGf9CNO3?=
 =?us-ascii?Q?FffoJ3Bqcgz5N2rs2fgeW5aMUDGnWOtlZNP6PF4Y02d/r80+wB2XSYa/gSvD?=
 =?us-ascii?Q?bVB7whSPblQCd0SpQfoW0PQtaglQVU4O7zFQUU5w0OfYSTBV9eo1MfW46o1D?=
 =?us-ascii?Q?ZauihOS3iq+yN6dzaNBqwFBFJeFme72HQB41IXsfMMgCfhJBkiiwJT/5EJ6P?=
 =?us-ascii?Q?wJ0lgBgjl3sMblM4CxhRpIHloHIhYgNSLHP2J05Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99443d4b-17d3-4ff0-069b-08dde0c661fc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:20.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/QTcU26HeI/GK0G0w52096jv5xrSKzUaP6tYCTchSqDb9mW9WFK0hgl5XyOMsZ9UzVLbIkzpox2RWB7YpF1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

Currently, aqr_gen2_fill_interface_modes() reads VEND1_GLOBAL_CFG_*
registers to populate phydev->supported_interfaces. But this is not
the only place which needs to read these registers. There is also
aqr107_read_rate().

Based on the premise that these values are statically set by firmware
and the driver only needs to read them, the proposal is to read them
only once, at config_init() time, and use the cached values also in
aqr107_read_rate().

This patch only refactors the aqr_gen2_fill_interface_modes() code to
save the registers to driver memory, and to populate supported_interfaces
based on that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia.h      | 27 +++++++
 drivers/net/phy/aquantia/aquantia_main.c | 91 ++++++++++++++++--------
 2 files changed, 87 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 67ec6f7484af..492052cf1e6e 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -174,11 +174,38 @@ static const struct aqr107_hw_stat aqr107_hw_stats[] = {
 
 #define AQR107_SGMII_STAT_SZ ARRAY_SIZE(aqr107_hw_stats)
 
+static const struct {
+	int speed;
+	u16 reg;
+} aqr_global_cfg_regs[] = {
+	{ SPEED_10,	VEND1_GLOBAL_CFG_10M, },
+	{ SPEED_100,	VEND1_GLOBAL_CFG_100M, },
+	{ SPEED_1000,	VEND1_GLOBAL_CFG_1G, },
+	{ SPEED_2500,	VEND1_GLOBAL_CFG_2_5G, },
+	{ SPEED_5000,	VEND1_GLOBAL_CFG_5G, },
+	{ SPEED_10000,	VEND1_GLOBAL_CFG_10G, },
+};
+
+#define AQR_NUM_GLOBAL_CFG ARRAY_SIZE(aqr_global_cfg_regs)
+
+enum aqr_rate_adaptation {
+	AQR_RATE_ADAPT_NONE,
+	AQR_RATE_ADAPT_USX,
+	AQR_RATE_ADAPT_PAUSE,
+};
+
+struct aqr_global_syscfg {
+	int speed;
+	phy_interface_t interface;
+	enum aqr_rate_adaptation rate_adapt;
+};
+
 struct aqr107_priv {
 	u64 sgmii_stats[AQR107_SGMII_STAT_SZ];
 	unsigned long leds_active_low;
 	unsigned long leds_active_high;
 	bool wait_on_global_cfg;
+	struct aqr_global_syscfg global_cfg[AQR_NUM_GLOBAL_CFG];
 };
 
 #if IS_REACHABLE(CONFIG_HWMON)
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 21fdbda2a0e0..9d704b7e3dc8 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -860,44 +860,24 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static const u16 aqr_global_cfg_regs[] = {
-	VEND1_GLOBAL_CFG_10M,
-	VEND1_GLOBAL_CFG_100M,
-	VEND1_GLOBAL_CFG_1G,
-	VEND1_GLOBAL_CFG_2_5G,
-	VEND1_GLOBAL_CFG_5G,
-	VEND1_GLOBAL_CFG_10G,
-};
-
-static int aqr_gen2_fill_interface_modes(struct phy_device *phydev)
+/* Walk the media-speed configuration registers to determine which
+ * host-side serdes modes may be used by the PHY depending on the
+ * negotiated media speed.
+ */
+static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
 {
-	unsigned long *possible = phydev->possible_interfaces;
 	struct aqr107_priv *priv = phydev->priv;
 	unsigned int serdes_mode, rate_adapt;
 	phy_interface_t interface;
-	int i, val, ret;
+	int i, val;
 
-	/* It's been observed on some models that - when coming out of suspend
-	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
-	 * continue on returning zeroes for some time. Let's poll the 100M
-	 * register until it returns a real value as both 113c and 115c support
-	 * this mode.
-	 */
-	if (priv->wait_on_global_cfg) {
-		ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-						VEND1_GLOBAL_CFG_100M, val,
-						val != 0, 1000, 100000, false);
-		if (ret)
-			return ret;
-	}
+	for (i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
+		struct aqr_global_syscfg *syscfg = &priv->global_cfg[i];
+
+		syscfg->speed = aqr_global_cfg_regs[i].speed;
 
-	/* Walk the media-speed configuration registers to determine which
-	 * host-side serdes modes may be used by the PHY depending on the
-	 * negotiated media speed.
-	 */
-	for (i = 0; i < ARRAY_SIZE(aqr_global_cfg_regs); i++) {
 		val = phy_read_mmd(phydev, MDIO_MMD_VEND1,
-				   aqr_global_cfg_regs[i]);
+				   aqr_global_cfg_regs[i].reg);
 		if (val < 0)
 			return val;
 
@@ -931,6 +911,55 @@ static int aqr_gen2_fill_interface_modes(struct phy_device *phydev)
 			break;
 		}
 
+		syscfg->interface = interface;
+
+		switch (rate_adapt) {
+		case VEND1_GLOBAL_CFG_RATE_ADAPT_NONE:
+			syscfg->rate_adapt = AQR_RATE_ADAPT_NONE;
+			break;
+		case VEND1_GLOBAL_CFG_RATE_ADAPT_USX:
+			syscfg->rate_adapt = AQR_RATE_ADAPT_USX;
+			break;
+		case VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE:
+			syscfg->rate_adapt = AQR_RATE_ADAPT_PAUSE;
+			break;
+		default:
+			phydev_warn(phydev, "unrecognized rate adapt mode %u\n",
+				    rate_adapt);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int aqr_gen2_fill_interface_modes(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+	struct aqr107_priv *priv = phydev->priv;
+	phy_interface_t interface;
+	int i, val, ret;
+
+	/* It's been observed on some models that - when coming out of suspend
+	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
+	 * continue on returning zeroes for some time. Let's poll the 100M
+	 * register until it returns a real value as both 113c and 115c support
+	 * this mode.
+	 */
+	if (priv->wait_on_global_cfg) {
+		ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+						VEND1_GLOBAL_CFG_100M, val,
+						val != 0, 1000, 100000, false);
+		if (ret)
+			return ret;
+	}
+
+	ret = aqr_gen2_read_global_syscfg(phydev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
+		interface = priv->global_cfg[i].interface;
 		if (interface != PHY_INTERFACE_MODE_NA)
 			__set_bit(interface, possible);
 	}
-- 
2.34.1


