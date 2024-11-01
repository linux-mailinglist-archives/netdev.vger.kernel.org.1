Return-Path: <netdev+bounces-140954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04179B8D3B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12DAEB21626
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC8156C76;
	Fri,  1 Nov 2024 08:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7204087C;
	Fri,  1 Nov 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450402; cv=fail; b=FFiD1HmqmxpkUeu7eNWTUQJU8HLJ2iqvQpCQsIl2drMnuETvvbjoa6f7LG7F34xwjBc1rTKIxXG2iBUzFrHB3yYxyayhFdldRuR7C4Hyjz8VPk7pun3N6nWt5YAiRR5BLDVNmJ/GnNEbDjajJqkpMAgV3nrcEfeqOIoT4qE9SO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450402; c=relaxed/simple;
	bh=vTGuNiMgzbCF86ozU5ijayuiJMiZpAoe1wEWCc0sS8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Av77890bzEiCcE2lMFHDy09YuwJrHDZ+j1tebHGCSPmqbnEvZ0Lqd5F1tZz+Dmv0vxh0fiWfyDtbb/xH3dPPQUd43/n9FsOlBYqkuQn7Q+Ztf6JUJmDU371s5wc4bOC+kQB2sOw4tXdCYo+0i4hhvp4joTX4NnmwWAOG8WeA8Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbY5wj1vyVuePk0j6K1AedbuRIybdzOvvgjgl8bKRLBcnu9DsW3VpPLDiuyHgpmRtD2r601DNqHupCMAV6UbjOWVt+iqj9ZolhKFMx8cP7pymPy5c9YMEIHlJU9l+Bn19GZlIyHnO8RbFXVQc0gkC2ccMGkvUx8yScIKOlxz05X0uKEf9iCx3dX3vV6UNhXP1YbwFS4fg1XCnT96DSXJ1Wg1G91GMahwaesountcb78ofyoQlEzqMiUbGsatVKVUTy6U5VrivJx9tqFGRW3ML+JU5PrSYyKdDXfDhTyS7nzvPuO3iq7y7qBcwhj4Psl6cCtTuKRVgaQ++52xtHZ7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ocbx1Hu/tUzczwxjE82MMfg7v5PsTGIm9P4YuZg1qY=;
 b=KWW6KqeYdS6WqO6j6RsN5ucBoyhVu7W0TlxZU6ehen8sDH7YoQ35C0xOXUtLU1ZwGAVtXkBvgs4chywsykdRG3/wki/WcgABOAzqRGu3xf8Y/Wt76mWwecZiqaSyWClJ1thc69DMf0WPiKStI9s9eXfY1D2vxvn/bmzXBtHWknSWxFkCIzfvk7dBN1CKGFfgbsRZA/mwX4VcetRRa84OidPMdC5BqDx/+SB9Rr4Wek+DNVwRaJKk0hvlTMsNVoXQNqJktvszbqACmB6cRXE/WtgVEoB1/OmrhcdbafTunQKrvSABRxRVnID5BAc86mYn4G8AQMKBcQG2Oy5GSQHTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1107.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 1 Nov
 2024 08:24:06 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Fri, 1 Nov 2024 08:24:06 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [net-next v2 2/3] net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
Date: Fri,  1 Nov 2024 16:23:35 +0800
Message-ID: <20241101082336.1552084-3-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>
References: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1107:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3f102b-a7d5-495d-2b14-08dcfa4e8d00
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	NxJj+c7dcIe/7MQkDkQuwGF+Z/PFuji4Xfc+HowQLylmmnPhnrsc16hEQUaA2PyRQKOOi01hHd4P4vkCyi0KRzVEPF75sxW+jxh0LI8ceiqQ8dxjP7/njAEk5TgDFv5URUVK/uXecxb6fv9r6S3TbRozoQ8I//zjeCh+nJ/iYoLR6D5fQG+FL8saLwz2pFjoPstwbh88lLCV6ponh8qPTJLastwcIOB+1L5WaHIXxD+OD9DuQ3va8o10xKaUmW3EAmon++GweP0zr0TvlXX/YDhlzQztzBUH8xdLOP6SqQcZM5dXUtgtnY+c7Eftpylptg+2vClMsyiWu/4LOZ7A+YCAaHcPxMADPn26KtShxKq60eVKepQ3GyLn2DmNAbZV2i/QyuSrt2VlGvq8cxvNNW61dbEdhQqDgviv5Ki0P+TGfhQSOFSrSECQGoityW5nBEkNiL2HVEBUa5oAoMdoFnKoNBklm5h2mMGxvAWt4/69IGLeNVoEGD+W9x65wTN0fuIy8VDREngWZS1zDV0kOZM0WikOlux/I7bSO8wPRBUsRT/P8gcHrJPsfvHnG2dMX7U7cib8AzvXVDUnKIoBjRIMCv+BniiM1hvxjyU8NghZj6zyF42/QQ6CeWzwjWYK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZyCG19V4Z9xfOjNN5Z4UHDhg/7eTHndAjM/nN8gAsNd+HEK4sJgaDS6XTogd?=
 =?us-ascii?Q?BrXnz7aTovp6NwSqudXFW7GiLZ14ocrOu1ejLFPzM48wv2h5HpCBrQlIbhSC?=
 =?us-ascii?Q?01pVB0is7nAjGV2umr9Nro1HhNf9HrFKFXu4MMiAWlIouvo0NVqWYDUAOPOv?=
 =?us-ascii?Q?ZeA0JvW1dlwTf9EbI/eRbTho4nZK/4c/NbQEC63KewHMt23mo/nhvK994PRd?=
 =?us-ascii?Q?WI5HWGrx7Xa2hEYnI6ns+oeL1tVlU4T5DpE4vwXRC3Y8U9v6HtDK6zWqHdcX?=
 =?us-ascii?Q?wtgeE0Fowpg5SjLWJ5afsKh9S1UJaybMu7mdL8fiZZx/ZNvJMaBV3shz/nuP?=
 =?us-ascii?Q?wa6TTAlh0rjrR8naxAO3e6QwdnLBjzEaeoRYQ5I617UfZcSgPj1QxpxFKwhO?=
 =?us-ascii?Q?xsBA8iLr3OYQALL2twNeO7NTkBZ5AOe1MBwD6+QNBYVo3oWdmswgvhpB8085?=
 =?us-ascii?Q?We8pK0GP+iVPd8QFoErUyDW+tRuSfnwxIk0rEdzCEet2THe9EHfGFPu9Y+1+?=
 =?us-ascii?Q?rdTEU8Rz/TY7S9UjYe8mykHI/WXxY0JvzDFysJy+vWC3fwI1xnTSyT9vDAwk?=
 =?us-ascii?Q?dcl8moIIRp/krKOWE7J23VET6V02Yg3N8Amo3Ssral6yRKIflvy5UsPfTKEi?=
 =?us-ascii?Q?km4+1FeXWhwPeBzW4Zhlz4Lasq9DzYJ2l5kBUHaS0uQluRLDGV+Pvv4StwfF?=
 =?us-ascii?Q?oc7ShX8nKgSn6cVizg1va1JC8ebmN0sei7qgkFcqRKBqHdQercB5YsLslHwJ?=
 =?us-ascii?Q?t1MYXJrl+W+Uy93Jq747R8XAOAUrQIABtNKiYo1Fa5TVkw4WrWk4/sqwKSXx?=
 =?us-ascii?Q?X2qaoMw6ncTuwWmjFsPU/gWbmf5qom1xpIDfI8ss3Pd0AwgUPhbYbCRLN2o8?=
 =?us-ascii?Q?9FtLW7EWt6apWl8VoX0bPqdCDOshTLjswhXGDQ3FJTcmgTCQ4ntqEU2pRwke?=
 =?us-ascii?Q?zoQ46bykpWTKBzngJlppXOuj4ICzAHSZK3BcIV5o0rmjyuX8ByShLA1jrppp?=
 =?us-ascii?Q?m4xL2nVpK5Cz/j7sWJP8bxiNT1Urgcbk5qqWJndHsBp1VEF7L3VrW5QhdGK0?=
 =?us-ascii?Q?pPv40x06GcunIj4i6Fb0JgF2YZFCg9SvDLsPpUPiYuo5tNdx0XVZUhwESRhC?=
 =?us-ascii?Q?o2ttHE9FOlYY4Dzc814h+xq60o2FgRNXKzVkWz7kucu/XSPDu9x/b7ZB6yR9?=
 =?us-ascii?Q?susbc7NeQvT/UDojEAUGPZK1lwgcZC8cGWg4DY7bJVrlNXzYGR//xgNKin4i?=
 =?us-ascii?Q?HtayAH6hpLQeewEgbf+dI2QV66iZfKZBGyvSKPLciue+Zq3dl1v6Tcj8tfpc?=
 =?us-ascii?Q?Qh3A6LCCaWuff14p/XLnYHOs4MFWPvqmEexFEt4+HKgAFEYUl4cUx6NeneOB?=
 =?us-ascii?Q?dgAvNGVKnIAXdP2uVYzmiFnWBQ8wNIxOLQUMAd1TOPe5oQYlNJq5s+mPmn0V?=
 =?us-ascii?Q?7a2Ek9bHIWvf0QwVvkchhucqA+3x1dq7BRfWJWm7dKGdY2ztxoI8g1EpjfgF?=
 =?us-ascii?Q?yTqKKXj2grU3+qsZyisPOxperYwASq4ns4QzPCN38VxooMB6ZeYPbLmAyLOk?=
 =?us-ascii?Q?iWke1h1YUwscz1auW6YfsUuGP3JRgQwtsRLqqJRYf+QrGkCxoNmsStKqEOGk?=
 =?us-ascii?Q?LwfcWJdw/C674TToTzdG910=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3f102b-a7d5-495d-2b14-08dcfa4e8d00
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:24:06.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXx4GbX9D9COhMuuli+icY1Gdo31x4SUqILs7Tz5v6zlQA8Lgelo/5huLksjbJOZyrLenXx9vuWSy/fZrLntadG+AzN94AWnXucMnPCt/3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1107

In order to mask off the bits, we need to use the '~' operator to invert
all the bits of _MASK and clear them.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 7c895e0ae71f..1be77d189ccb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -266,7 +266,7 @@ static void dwmac4_dma_rx_chan_op_mode(struct stmmac_priv *priv,
 	} else {
 		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
 		mtl_rx_op &= ~MTL_OP_MODE_RSF;
-		mtl_rx_op &= MTL_OP_MODE_RTC_MASK;
+		mtl_rx_op &= ~MTL_OP_MODE_RTC_MASK;
 		if (mode <= 32)
 			mtl_rx_op |= MTL_OP_MODE_RTC_32;
 		else if (mode <= 64)
@@ -335,7 +335,7 @@ static void dwmac4_dma_tx_chan_op_mode(struct stmmac_priv *priv,
 	} else {
 		pr_debug("GMAC: disabling TX SF (threshold %d)\n", mode);
 		mtl_tx_op &= ~MTL_OP_MODE_TSF;
-		mtl_tx_op &= MTL_OP_MODE_TTC_MASK;
+		mtl_tx_op &= ~MTL_OP_MODE_TTC_MASK;
 		/* Set the transmit threshold */
 		if (mode <= 32)
 			mtl_tx_op |= MTL_OP_MODE_TTC_32;
-- 
2.34.1


