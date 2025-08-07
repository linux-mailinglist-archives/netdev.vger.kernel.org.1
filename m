Return-Path: <netdev+bounces-212002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C8B1D166
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22447ADC01
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 04:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271AB1C862B;
	Thu,  7 Aug 2025 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bO7dV7Dn"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A1101F2;
	Thu,  7 Aug 2025 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754539732; cv=fail; b=qg0/GCF0vp2v2XoLDC2oob+2ZNWtbnVPMCc2zKnAHqkXcr+jPUO1mrWICNhm3lAX2BAYG9geErGb95pAw4Y/ko4Ez3tXPRkLZvBI4i6oRGeU6ZNVnmdm1xheERy1JHQT51h5+7gTa4nRWFMKGCs2tg04I5zRugtGLDKk3npH6ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754539732; c=relaxed/simple;
	bh=oeye4o/ZfBCjk1mpAyC1h+DboLlv6wB48gjjveq1mlw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ko+s5njGTou9cF7jwle3GGfBVvWO0dLrycA7qSvZX87o6HQen31NWeBEfECdt44mRycTyMkg/utizb62++KkH2BKViTwLlReSuM+4nsIFk5ujUg0WaUIBFsnjjq7CylnLvXoDF5Hb2kX3xAwZEjXvMdoUkpF4EjjiD6bfbmU/Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bO7dV7Dn; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnJOa8l7fHFC/8Glp/wGCjGGjenahXxdHJLNQatXUwCJvKqdD0GRzxOVO6r63xxslOrDGcRFtY8HgrKaXJlVZmtCSrJmcXEagQ3fiWyCTtiFeYG+OhSU8luYR8Z7LFLNJ82BmZgiGa7HXMM9cSKhCRBGgT/69vOK1YwpBDbTEPPPPszG29/EsyYL6qHgwvZvigfbrQyh1uVvUuhneBQ2GM8qSX58uKLfrHHHO3p/AiFW0L+mwv6lg3VrsGPbRMwSFwSmT2wUoGeMLjk4UwTr5C2eOpXV0NAHwWHQ2alUnMLD0e7+uup/hu5oA5CuKL5VkCeEdzEEzyrVglu9vyFb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcIKrohe4eSKu2vDD9vSpmDmN2ebs8OOMysII1fzLzc=;
 b=dgujwNKBZwRDoQ7QzKj/8oqqZ03Euuo9Z7tkUoBkp5bKnTNiBRnLOH+vwAPAmakJ63jouPcQchxGMkVFJusjlNxlYFAxgXqRNvYbO1aoY8V2CKfN135WAWdZw+VrgS0TDIhrewFQyMAtleUOHAwGHdySC3PYC0bEFIjeUv58e4wwHeHuoD7ugQNEkY2xpXA6KSJmXiQuooktjPzQc4lFHXW9rWclg4ZEKy0n3aidjUbSZdsJWB8jU7eD0xpTM6gI0H/W30GUFnHOXc9Q4RwtJRtxwWdy/RLhowyMTsn85dChHQJ8SGRu3uFlUhajCdgqhesfytwPGyyxZQouuDZXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcIKrohe4eSKu2vDD9vSpmDmN2ebs8OOMysII1fzLzc=;
 b=bO7dV7Dn41/FpIP13oMTv9RquaPcL4At94wqCDPjqxPQibnmHDNhGg5v6WwhasVFysRrPhIpgG2YDnoaSOcB2xyJWh8Grfp8WLqrIS0hJfLCxo4GDqU/nYcTs3O7Wj/sCuTABteKff0mmKkMKg60kYEAKqlbyedcRgFJ0GdmUKx/bQGHmCalY5vFCIBMu3DMQnsiUntlX/0OaCtHWXZJi5L4YBCG6PN8u3CToNSZyMmkq3wJ3onhGCMdnP3f+q5zrcQKPVIarQSP1YdDB5QyYYc1R094GArgxn0yXdQeRIMOFJBaFagt7nd0UPk0pbwdC50XpCbQmU67U4qAX6le2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
 by VI1PR04MB7069.eurprd04.prod.outlook.com (2603:10a6:800:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 04:08:46 +0000
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::5328:8a92:1dcc:e783]) by AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::5328:8a92:1dcc:e783%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 04:08:46 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: andrei.botila@oss.nxp.com
Cc: andrew@lunn.ch,
	ansuelsmth@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	sd@queasysnail.net,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: phy: nxp-c45-tja11xx: fix the PHY ID mismatch issue when using C45
Date: Thu,  7 Aug 2025 12:08:32 +0800
Message-Id: <20250807040832.2455306-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To AM9PR04MB8382.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ea::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8382:EE_|VI1PR04MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c07dc4-6bf0-4602-13e7-08ddd5681b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OvNV+RuhDU2LxNc/w7o+Wbd4GMCQpTUJ4ZP/0kz4jO8bcGwnX7BaBXNaEEdp?=
 =?us-ascii?Q?FjD+kS7KACjGyOJrPRsUKi/wERfGJvz4WVkAG7fl+fiprnbEXk1n5sT/hWRh?=
 =?us-ascii?Q?Kxv0se9eqC6V1lfK4UcavkSFQzHpdAMXhySH+mlVO0lQlSy7eDY5leb1dgNC?=
 =?us-ascii?Q?ihRIfCX786yPVlLTVoVB7X1ZNPGGVDbsUlamDaJtkzsqWj3ORTXMS48+YeAQ?=
 =?us-ascii?Q?wl9ezD8KVTQyjhS4X7pN2G/f8rC7DQEnEAZbaBfacYwvrZjBfGEgxt4vIy+9?=
 =?us-ascii?Q?O+eHSfCh4VtmKd1NH+h3ZDsuz9btWFMSI/TDdbiIgihQKmIuMCdSbFRlkkXW?=
 =?us-ascii?Q?t8o6OU/nYttN7jqNO3AbtxH9adSlj9NfPDJf4sQbo+3KT7GizISH4Ec89eR+?=
 =?us-ascii?Q?iiqbxUIBGc0DcUyPzBqocUjrU75BmoulALuY4jMqB5cOgdV9tC1vlsFnbJDK?=
 =?us-ascii?Q?/75e+4wtrn+WFhplreSmxSP7S77tYmaTMV+KjQoqPXkagp1tGb8YSV8gDToy?=
 =?us-ascii?Q?v7m+CuAd1uUqJOXAeW86/CKuMXvGzqCxdKri0NyR0adSSWQo/xF7j2Yg3LVY?=
 =?us-ascii?Q?pSjmRQOPpo9HVTMzvYKOUBET2Bnvld0U0cN/GPJYELnQR4Xny5ILQywVhXt/?=
 =?us-ascii?Q?93q3bJYFx0ApC68jiU1A/460UfixYXJLDADBKZQLJl06rl0aRPosvcoOVLKm?=
 =?us-ascii?Q?KCp/bVw9696JQ8pBsnnAPIS8uNeKosVdSZWaSxBi7ZsA0nrbzWWgyRgxk5Ea?=
 =?us-ascii?Q?sdy6Mwz7vAHpAbG2u79hu8CPeV5GMFRgeR/W92n4t3m48Rk9BY54K+IY1Pii?=
 =?us-ascii?Q?eIPq2Yq+zkdvVpWsi9YEX8f/QepXm4p2X88mcrgxSabnA8XhosAtDYhMdRG6?=
 =?us-ascii?Q?NRzgT8+l8jBjZrCeinqpbmkdB9/poyWJDCFg70EDYgw/RJ0hw2ae73tbJgXw?=
 =?us-ascii?Q?hRlOYycjthQH5E2P+oVaPB/oqynYjU8xcLfAXotdklNf/Gw+48N6ZDjwyykF?=
 =?us-ascii?Q?gFiOXOOMNPdu4wr8PuJKFW1UekLtDqlJG6SKtICxKHfTvY4CHvMjPJhkInRP?=
 =?us-ascii?Q?cedowTdfNEaq2F+npfVkr6vUqvhxxS1kCFkljkkkQB3zc9y1aGCoteILD7im?=
 =?us-ascii?Q?RsnLGcYryOKxLjsg0J4VSG3AuCbxT5GQBwqqVcYsyoMUTVZIrAe2laKJgSJn?=
 =?us-ascii?Q?onSLlniAvvc66qoaJRkFRX45GSCxW9WlhyEEyxcj2+rjU6yMoaj5J7yQI+Tj?=
 =?us-ascii?Q?8LgAtMXXn7mvPNTZK0PBMvIUPEI/TyN4uHZk5WN0KbnDVMKotLc3nWLYEoB3?=
 =?us-ascii?Q?4oafyJN6hZ3hDBmNZHJxTSk8XtYle4x9QA9iPAy4BwJXQMWH+Qhgv5ySmiLz?=
 =?us-ascii?Q?D3qVUYG6hlev8mqX60aoOBNCyoRJukxYbgcsZj5NMR4hW8vGho8SKqWt7ylW?=
 =?us-ascii?Q?tMgR3g3gQ1wGmvZ8vIMDtvfMxYuh08ImVMsUlgKvem+A8GbV6BsRSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UG5eOyNPB/VpIyaDw1Loc80v1sTnW22u7JWdBNk3yCkr79RzhWRYFHdaguv?=
 =?us-ascii?Q?SwBlHUHQD1uudxmfgZW3UDgm/I1UMDORAg1FhVCFykOE7a9UTnT0GHqOzvIs?=
 =?us-ascii?Q?h1Z1aKp+c66y86PPQro94We78E78IO1ffnNRYzZiRKb16FVAd2h72Pb7JmTH?=
 =?us-ascii?Q?Q2sqSk7MZaFwc+GpH/H+lW30wYfJHRIYBuTvIALuuDoDThO0KO+qys90IH+B?=
 =?us-ascii?Q?qHD5B67wovvXZyd/E/+pDzcqGR91+w21sGfv8YR7VlzMsMdJtEPx6e4j6Q6d?=
 =?us-ascii?Q?0ngtvk8r7tn4VAI7e3h12I2ztsKXqCR/ejHeAF/gtsJh21bn2ehKVxMOfq4u?=
 =?us-ascii?Q?sBd/sCRk2ieeizUKu5KFKuxduS2q6sU5RMWKisRxabZLrJeFhoc9NdVOAEE8?=
 =?us-ascii?Q?ac38NzsArj+MiNxtzyzOLHficGP+dpiU1ZWnbYTJFOzINlpOqPGZ4KIV9970?=
 =?us-ascii?Q?0ds+cM+9aj3vuQWVAQxkxcn3owtAYFhumwhupGjXZPf/+oITIBh35kZFgjTF?=
 =?us-ascii?Q?OsIxKRykIM2+IiiEP6o2/90ERX+Wp2aYoK7KSpD3+A6/AHrQivPd0N29oeKe?=
 =?us-ascii?Q?x3f7AO+OzpZcYSBQUAis5VUOZ0Tk5Zu/nIm/LWMFZ9jJIw423/s3PW3eqwnh?=
 =?us-ascii?Q?YGjp3b0z4jMlVu52Y45MKIfZTSj+Zm8ICJar0tp7a+LUzCM+fsez/HUwNQts?=
 =?us-ascii?Q?5PYSYsgLQFuV1eqlBm/Ky2zyeE+SndS+Y3xrmdPLqXfVjmtHjmrVdaotZ0kM?=
 =?us-ascii?Q?Jn0U/hPODKUHqu591IwBII9hqvn/js4arMU7gjtCQHrkkLlKjFm9ZFaVYHdn?=
 =?us-ascii?Q?1TSqOuGR2EggKLwlvbS3c4x0+M7heTOMIKmZhGAyiRTVk9oTPhVdPYwz5eeg?=
 =?us-ascii?Q?AIXb71Htw23GTyz2yF47KDt9fLG5rmd1vvZ4ekNEohjLbLmRjYhEioKgZq1G?=
 =?us-ascii?Q?mQKjJynEwuTtrTVj61gIuftOamHq9tF8di3zSRYTaG6WdSrcrIDZjo5YVt2k?=
 =?us-ascii?Q?cE5qb3tYci/rnHonhH5RUHWmNVKfKEaOoM1PdphmUBoJ6cgts3mSJum4My1D?=
 =?us-ascii?Q?mqv9+QXxjEPV3oRfrfCwAmK30JnTP1cbRvt5Mu10hYkAI15WeVKkAU630ms0?=
 =?us-ascii?Q?IZK0lBXeADok1NFkbVINP80Ci0jfnaB+V0wyelZrr4snc2l9oUE2PuJv7DvJ?=
 =?us-ascii?Q?dWVPOausdLhXgI6cJ+O3I0S69r4csMZeMi+AnZG2l2NC9rxMKujXhYBgQKxf?=
 =?us-ascii?Q?HzwiIPezyYl9SNXZtdwqb5/ei2Ot6+9vCiocH/uur/ZNEjTtiHXykt8xwWWg?=
 =?us-ascii?Q?CC/UOZ9dbACvQywOOQB2qf+5wmgaP1qvkYNZXtFbQni8QZGUN/dUzsv3h8PJ?=
 =?us-ascii?Q?Krso3AH5mQ9m4sVl2A9zpiTssqKTpfPVDqCOEX6/9BJn3vKWwJAPrp2iEoXl?=
 =?us-ascii?Q?lIdXkzDBYXvM8voPCUDXgzDPIXU38+DKxR0eS4vyPwM/QTDlljwDEkE+/OIf?=
 =?us-ascii?Q?g3OIzsgD9mx0NFdC/rGqlhy18YU7CglV42xeO/W6ki71FzQSLZfKbr9fGF8X?=
 =?us-ascii?Q?SUgI6t7Ng7AaAxF7ZvnrINJ5ueyFgHPwdsygcHFG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c07dc4-6bf0-4602-13e7-08ddd5681b05
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 04:08:46.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvmvfOGskv25TvxG85BtmE39uR9P0pB6MyT50x39nrbj6+Dkpz9wy4cnaG4Fg+8RFyVG2d+tF+OQJeLP6j7LAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7069

TJA1103/04/20/21 support both C22 and C45 accessing methods.

The TJA11xx driver has implemented the match_phy_device() API.
However, it does not handle the C45 ID. If C45 was used to access
TJA11xx, match_phy_device() would always return false due to
phydev->phy_id only used by C22 being empty, resulting in the
generic phy driver being used for TJA11xx PHYs.

Therefore, check phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] when
using C45.

Fixes: 1b76b2497aba ("net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 4c6d905f0a9f..87adb6508017 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1965,24 +1965,27 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
 	return macsec_ability;
 }
 
+static bool tja11xx_phy_id_compare(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
+{
+	u32 id = phydev->is_c45 ? phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] :
+				  phydev->phy_id;
+
+	return phy_id_compare(id, phydrv->phy_id, phydrv->phy_id_mask);
+}
+
 static int tja11xx_no_macsec_match_phy_device(struct phy_device *phydev,
 					      const struct phy_driver *phydrv)
 {
-	if (!phy_id_compare(phydev->phy_id, phydrv->phy_id,
-			    phydrv->phy_id_mask))
-		return 0;
-
-	return !nxp_c45_macsec_ability(phydev);
+	return tja11xx_phy_id_compare(phydev, phydrv) &&
+	       !nxp_c45_macsec_ability(phydev);
 }
 
 static int tja11xx_macsec_match_phy_device(struct phy_device *phydev,
 					   const struct phy_driver *phydrv)
 {
-	if (!phy_id_compare(phydev->phy_id, phydrv->phy_id,
-			    phydrv->phy_id_mask))
-		return 0;
-
-	return nxp_c45_macsec_ability(phydev);
+	return tja11xx_phy_id_compare(phydev, phydrv) &&
+	       nxp_c45_macsec_ability(phydev);
 }
 
 static const struct nxp_c45_regmap tja1120_regmap = {
-- 
2.34.1


