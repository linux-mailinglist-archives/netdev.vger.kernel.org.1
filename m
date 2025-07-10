Return-Path: <netdev+bounces-205720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951EDAFFD8D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA103AD1D3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E41292B3A;
	Thu, 10 Jul 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PLuhBhe9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737F291C11;
	Thu, 10 Jul 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138396; cv=fail; b=PEV5pGL+ZorOjDuSvy1pht6HLg3pHURBud3sm9GkLgW5Uuj9XHCOux/UBAi6msreqanuNkd6MssHYzFhran/10BNQxK1PMN8yphi8M1tS5iIsHv3o+s2KIyRCz1KeKnTVumQLrP9yViN49KcmSnPU25XzqhPcCeXBDNdFXmUswg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138396; c=relaxed/simple;
	bh=lZFP3V4eEkzzycDHPRsnwGoVfPgJGs5kwj6Vh7SjyAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRHkwQwBPliFBaaQmg3DXk12mBneQ61TvU4t20CKtYc4L9ZC3jTPMZ29XtMEO0kOfa6anjsHgw0m78OyIR8Ki+vvaiwDf6mRQSNtk0JZBCmGwH0bYE5eR1c+AXbBB9TdkSMuG+640NG/k9OXlGPFJgcGAqTSw7B+m15v95wzL+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PLuhBhe9; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/S+MhYS/ukIC29Lxd7kUMB/vM0L8dlHN681V6BRigCWqJQViRtItbs6szmzofcXLlLeHkOtXwQn9iCYL8CNbqHkJboH9TG28SJkAUPEbIQORv+SzSBd/negE6WdZm3Fvmg4KVyHjOK28WppA+1v0JG5z1dp/LkJrYBYeSkGKKqiASYlreq7MXFaSexunn/2n5Zy8bRLgSGP7+iM8X+G7+e+cLoz3DYjqrJt5l6O/HiHvNv5wpkiRM0chhPbfpXlb93BwEAjQSC3JKkss1/WAUioso3Gsy3IGnBu6Cnh2Ln8KP+m3i8PxdBRBY3iOVsUtVXMERwRO+IgWPumEmJnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgsmokXQ5bzMcyLzW2yFkC8pFnq+Fa38nd9B15IH+/Q=;
 b=C2aUeFmKTjZa6C5/tijIpkY8bYSfrlhafPdMXaSlSY/na68Qry4QGfoXDhOOWHtY1OGPoEr2QqnnQZvdPZXd95Ay+GTeg/pO1H7svtjekbD4LvLFPRQBQo7gOHU+Mx1E/bS/h4mvA2mzOiBOIned+qQYLOiZjko2sEzX4OyzknarE79G8K/PG8ohJd01oAEqjRX36WpIqtHn9QPRlj88P9A0Tb5B80nW4npkfh4nY9Ll58qyy54TFWI0D5gE0NMSCQM/lZk36ahg1niTYa1NaiuNoTEdG18hAIpeYEix8XRWo0YRz93tig+gijDYuxiNppF3PPTq7wOUmeBKBJsBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgsmokXQ5bzMcyLzW2yFkC8pFnq+Fa38nd9B15IH+/Q=;
 b=PLuhBhe9e3tU1fal3bQ/ZDn+nZ459EGujAuM4G+YEW2xEBASMerNlvQco/Hco1284m8qUr9tzH3BhjXZLk3MhWvW7J/7Fw8aFp5mfzO5yWTlXUuhlaScDXUM64+qn23P2+5EDqpxvL8JIeASvVNnCygle3Bs/QcFWKrDFdH/5bi0tDRJlevmzZdYjhcsJ+ymgbyecOijlhsBib+9dfIDpmoTQWTCBvub0Ny2sOvZKXjOtol1oypvkcawRvsScAXd49u0gXTqOOzPuey/6HgPlwgLYjaeZjyqNaIe8iyvIEu8AMhkSYPURFBvVgRaZCwbMl48lB4GW8EQb2Qho4f/sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Thu, 10 Jul
 2025 09:06:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 09:06:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 1/3] net: fec: use phy_interface_mode_is_rgmii() to check RGMII mode
Date: Thu, 10 Jul 2025 17:09:00 +0800
Message-Id: <20250710090902.1171180-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710090902.1171180-1-wei.fang@nxp.com>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc247f6-e5fc-4453-f796-08ddbf910f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|19092799006|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bv3xXifo6Xgc2xo5+n+WwlPufichm/phxlzK8Vrqf+d685QP6Z4bk6fAo4mR?=
 =?us-ascii?Q?Ex1tSYR3Hju3P4tILYq0bhuhIy7gb+ThMTOdiyYNPPux1YXtgV2JnS3slwo9?=
 =?us-ascii?Q?KpRR8hKVPdUSC/VbYNaapYnL4bifkMPYDxCWrNcxs3B92a7tGF4YrQEOjeS6?=
 =?us-ascii?Q?DERtX6I2AFMmO22aJODqyKgJ63isFjkxN+n2MVfx0CiUARJdQbtAC0P/yV4c?=
 =?us-ascii?Q?/28FlsokpNEb3rvqXU7/AbgHRUlOA87O0A+Q6BpYJK+iqUn4nHE7b5PPMveH?=
 =?us-ascii?Q?bakmvxpPUe5UL2xVNsMv6f+qmuIVENS5d9oXA5sQrALxVbq1sNi1fYDd66x1?=
 =?us-ascii?Q?vpOHGiyZNodliQ2k5aUpu4H3Exvr5kugK9cP2ZyJM2/JPdSrlB/pK/KhRNJy?=
 =?us-ascii?Q?KqSfgNZCAKevYcop1ajV12YcwV57YkjKwXHuu4XLQu2iTEl7mtAPzrgi8zhy?=
 =?us-ascii?Q?8vcQqZvFFmtGmddRkpVArpGNMaA76mkoenK99FeC7qFBH6qc70WAw3rlU5c7?=
 =?us-ascii?Q?5A8UXSazZZ+Vufm3ZMmgN5XTBkjYmh3e0EruovgAxTADvPyHZpa4EoeQP1ug?=
 =?us-ascii?Q?c4Wqa7wi55OZtGWIB589pRCjiwhxSvaMWVuyIpRtsNAs2Vj3+fHDrUXpoGUS?=
 =?us-ascii?Q?O1O4rADSVXaP1EUHuvl6esd2x2BGhD6Drf41C47CSHeQuZf+g8H/HZG7+U3U?=
 =?us-ascii?Q?AWVjdVnKjUQcFJPeE36cka6sQ6w2nRSihaGCTGQ5nky/nPLcKjGArUp0MJ8f?=
 =?us-ascii?Q?PNsiZNK+Nl0IMxFLjBhAIVkDixzPzTw6T38HsJ4q5hwRb82TrihsQ/BrlTW2?=
 =?us-ascii?Q?Jo32jPxWm2i6JXbPmi/POSkjw5HJwBukHXe7xvtGZf3LL3o84cIrNMSMs1+z?=
 =?us-ascii?Q?TBEdODE7GXT0qA/dECu8HcpeDCvathotJjOVC26RvzjTQZ4PmLuhbbStw4SN?=
 =?us-ascii?Q?NVQQY83OqTUvO4qKdLnN13V5FumCytGm01Vu/bV/Fxc8NiYykf+cD5omTrVt?=
 =?us-ascii?Q?VefJ/bPlud6PCO2rs1DxBfcNLKu9lgPldq+e8ltHYvA1V0z9wTXTv/6UWce8?=
 =?us-ascii?Q?eddSYd/C1cQ2tlzKM4UJl2WCNc9WnKr/dj3t3sTs7UKxkBo5W6MflcX5yrIO?=
 =?us-ascii?Q?kcK0AgoYbqt1APOZ6S18PhcpJjcg/NzUeoaw21G+M5f6bgzxXZx09JKhH5rg?=
 =?us-ascii?Q?d+B6HovaipugKLi0rt2KYGzmidHrqK+xyjvhMS640UYO0cH5PsMy6Mr/4mJo?=
 =?us-ascii?Q?vBzGDLJfJwIrFTgKYa+KgMzvzT39hSOl6wjfWFgHkg4j5w4jAtfK8JJc9b3G?=
 =?us-ascii?Q?/4DdC+UfTTkzycXyO3rhXglNLTTf4Hi4Y/s7oS+4aGhxFVVuOIneDnpm1uPm?=
 =?us-ascii?Q?bP5Q11olEoib7zgPgxyjlVUzWUnw35vUVHdS3smNgmyokXd3ZFTUuDo02RNL?=
 =?us-ascii?Q?gucEdJuiwpPtd6FNduqmBcWFXT/zODA1GZ2GEioIMouijiKxjDYqMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(19092799006)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BV11Ywpq7DwlZoRnow9g3AB6hkKTb6muI3Oa3wzxHjSk4ZSyMYPtzfFRdPIZ?=
 =?us-ascii?Q?ATgUb0mFiVTZtik0L4FltfSa/glCPzXrSGPfyIuzoRCCDkcewaSb6I1EHNou?=
 =?us-ascii?Q?qSNBX4m47LBSUVpyZ13tAaUXiVshc7w0KSTHCOZx0sWckIqi7+OUsMm6HZHw?=
 =?us-ascii?Q?QKSaNdQE60coKMfh0Yk4kZ9VGVyMHa8/A6fND6+50h0Dd6o8gwxGhvma+YJm?=
 =?us-ascii?Q?m0016HEtMiQiFM2FZFhys5n+OErfPoSzlrWSFSRs83nGEmJhnfXAICUCn/jT?=
 =?us-ascii?Q?YgslYyA2XGXbuvt9TA2vqPVrmaCl0CbUw5cWS5Vcf2+G6Pi8PHNvYxEsneQ9?=
 =?us-ascii?Q?HOXUV+c6kWaWUljv/08ZeQVMdyTwRvoRuMkeOqDFx160UcDMKuj1Fdyz278k?=
 =?us-ascii?Q?bD52OujKvCNPBBc+dk7G8lhnbkUNz2FaR59x4WKyS4LYC1AT4pIIgI7uqKfV?=
 =?us-ascii?Q?8I4ACutgWryLwl1yxRFfvJCm9qquf889jqXn6htzyMgMeIKqA1vYkpL2E1Lr?=
 =?us-ascii?Q?H6MoIiRA/HXRQEUV5hbFep73xUIm5up8D/e/tGCGpIXPLu+OqqpJ9YFWohKC?=
 =?us-ascii?Q?j+ryihC/4GaqUPH4jqxAmQJU8id8/MDd8p67ZdVcmPluAH5CTdY51o2yYWAQ?=
 =?us-ascii?Q?gYpB55NNFcFJsrGlvFnxOXVwqaOhNTRfCvd/oR3HhIcAxYNKoQRY2MBy/k3M?=
 =?us-ascii?Q?enN0S5lP+0VYShnXVlu5mDLw+j8Gem6c4oHGgjQHyxqBPdqImkwO7wwn329S?=
 =?us-ascii?Q?qcdBWne33up1q+w+YzuRUXRJSshPcpgXjN6myA9jO2rWB8kxCZ9XtlSAbxCK?=
 =?us-ascii?Q?6dn2vE6YW4yIz+HKYLg3afv60yDd0TKghUQBoBLf3RD8zrxDTQdASRHOyfBi?=
 =?us-ascii?Q?ElSVF/e0zk/5kaXG4T558prtsa0uHUlvaAXhy86lpsZ/zSIvWcHatU9nH737?=
 =?us-ascii?Q?I2cCiLSzCDucOWdXVssnspLJZAlpAgnUJcOl6PoY5AouojgovN4JGp9HVQMQ?=
 =?us-ascii?Q?V/ylqGLuGbWys0EboyKilv3YVEORbZN+/u1ncH7iyScMTtgVDRQG36ibhpK6?=
 =?us-ascii?Q?2vE4AvYyx9lhmL53ylAYf914Z4dmy9kbBcE9gbDGA9pFENvvSFR0Am5gPRzs?=
 =?us-ascii?Q?0c6CU5kWfuhyu+c0ffVhzziv7GWoo/vhOGaFb410nAmQVu23nCS6OoyJmMDU?=
 =?us-ascii?Q?kuyUIGhquYY+9+L5SZgV+wj3zhehlBWnCT6Gyr1W39RQhhrdGqPUE6seBLW1?=
 =?us-ascii?Q?i963PUL5336x58FWzJSZom0mDEfs9gi8yfgmnjRJM0Wv5Hm6O9onao+jyJzW?=
 =?us-ascii?Q?JPK4NsRy+P8h3Tqpx2OCWk+dwLknKO1Fr7auzOOJDp15+NlWYpmqQxR+W79M?=
 =?us-ascii?Q?OK67VdczjUGGka5T5nv40BiNtwHAHCCDgMScBzRqo+9NDTGfDrAd654NNZVb?=
 =?us-ascii?Q?9pBYczzhTrBbarKXNMYwBY3/3mQz2Uo8/VaQH+2+4SzIRkwjzUa7NZ65fEUI?=
 =?us-ascii?Q?4KBrukvY8e5fvwabtW/tVSu6J89z/cAa30UbWFUpLAefjvyrK3W/JwVyjcib?=
 =?us-ascii?Q?P/cTRn3QDLLCGTwuZHL0fMFXOfbvucrJ9QDVPe7j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc247f6-e5fc-4453-f796-08ddbf910f67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 09:06:30.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZthTNdEBfLhaU72x4yH4l/p+LT+IUMWNqJ2GDFmITaKboe/2fFxf4m16HF91u2yZM4E+xKk1Jp0Rt/OyMlZmOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Use the generic helper function phy_interface_mode_is_rgmii() to check
RGMII mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
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


