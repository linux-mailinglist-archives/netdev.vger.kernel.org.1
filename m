Return-Path: <netdev+bounces-212426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E7B203AC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294D6189D508
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E962DFA38;
	Mon, 11 Aug 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMNmpl3z"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F72DFA39;
	Mon, 11 Aug 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904603; cv=fail; b=SX5gT1uz+rVaPTsqjZ8fSILlpN15Hl9tzFDBXaFAjxSryiawymMNL58CW29P1JqgesmexCHqM0C9nZs1XVnDQetKhjtV7WtBuyQ1cYrRizt4o9kHjH02PE1bc2GnoMHU8/M0Dj9uAOEvXey8qVUccuKmf8hUKg0dYTAB76I7Uog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904603; c=relaxed/simple;
	bh=1lzm2uRwz1dq8RODjC7tnJe6qzWGXszpM1pgT8FKUoU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e3VbewbE76hLfnTekyaVpyxuDh5uaPZMT/Keiv56wpH+GYTE2lm/ZgVwSJt1H9EN+3YXPtahQp7ZTIJ4TTaBVzKC6h67be3Wlc5mWwL0dzs+macsvC5xRTbvAsTPBNGMlXTsvqx2l5p3azqpkRHSaxtTR037h8SAMHbLRUd6OMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMNmpl3z; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPE/6OOUgjOCzNFi5vrM2+YLJCKLWf6jRLSrmnOqsXhd7URf9VZCyJllppuJu1vtRKpvOHVABFM4CvNSVKQFkIR5x/LXr1PBYGeumiPSgloSYtlpBn2HF1FRpbnNUFrAVkcZncF/GeSNApPujZAtyxtQu+nuSwnPjqjivkI98HDQ+By88Lc2cY4n8Okc0oBNbCBbOm0mI37SR4hYDKjAm0nZK87dF6bjI/Q3BOjU2uMQvcRtrTVUwoP3l5b7BVaGGolqTnRLni0dS3oq5Uw2AnHVdeH9VMFEbCI/JLPRCVv4jkCUOm3Bzyj1xKWzI8GWvXBbfXKt2Ljxb93oq5M39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kaINbqlrf+JZyI6EgP2nSZk9+4VI/9ixOAJ92n3lhY=;
 b=GlHMMIFeQbe2iZmT1QOsqwj0Vm4EJXaMKw0HFgjkvywEqgHvir4NVEbF2but5ypol/EI/4TQX5pjU+8PyqHga7ccGQ19OAVs4R02EUQei1f1/zxZkwmqo00u7pW2t9v8atBY4guzp+40Y4q6Wm5jV8ClbVf7/E3KDYybg5aDtqxVnIM8B2QB37sPlY0dunDcZhopGWGnQXQ10+wFCWONBw+256sa/5pZPDly0xwA/KwjnmRZjST4PFd0f1zmSvZlsUKymDf4MtUPxhRLv+mfr0F696nOQczKB+/TE0ePGMiX5xOwpV1vOcbduSnG0Nmkdtmw5NgdjLW32bFuNiXF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kaINbqlrf+JZyI6EgP2nSZk9+4VI/9ixOAJ92n3lhY=;
 b=XMNmpl3zRma7DdFIArTvTy1Bt9xVmuCZWPYnJv+pRa35SrzfOfWnuFQPZ9vEcz38drhBaBEsMqylmXprw5X+A45dtdrkAQGbmTOZv9sG9EI+ZaRzXYrLgug9cJdPhfUn90tw8S5ZcWJPpbOm99kZpOhG+euOQNmUvt0d91wJv6YyS65gMBmDHE8O5uN8JRCoOD0Y+qQH2kjHElQjrrtMAE9CEYWLXEYRxzkUrdV3/cBKIsPWcnL4lXlay8GFCz9jR2quptEZ7/S4YRTUGIA8vVImoWYFuwX808OQk2LCQPVdBDTprbFtV2K3S5kjRSoZdyh4cqixiN3FrqKS86gMUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 09:29:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 09:29:56 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	max.schulze@online.de,
	khalasa@piap.pl,
	o.rempel@pengutronix.de
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2] net: usb: asix_devices: add phy_mask for ax88772 mdio bus
Date: Mon, 11 Aug 2025 17:29:31 +0800
Message-Id: <20250811092931.860333-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e1051a-a4ea-4f56-d4d8-08ddd8b9a290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W37P9xCLTyEE4djWH/5JwGzduuwHJlZfHLPoMh1DDRljFvpiaGDl+DbY0R6/?=
 =?us-ascii?Q?IqOKPLlhqMlCNVZlmkz0s00nTKfhpwpW45eaGwvBIDXbm7D9NEQOcPRh6Jta?=
 =?us-ascii?Q?2aA7GfSUy7camhKdejwDIbDl3e2QNxULZMsj2iP2kBBqgZ6nJ9I9T4LANgHU?=
 =?us-ascii?Q?LJNhJuU90uA2RfDVf9B7vKM9orU0mMH42MIqWg1Gy3q1sN0E6TmfOMrp6Mp6?=
 =?us-ascii?Q?U1i2nzhS/OmDEqPX4YviTaIYRvMa3iKKKGnybPLyvilR1VKaRxdfpD0zelwz?=
 =?us-ascii?Q?dDIwygTig0/n/qZ2Q4SUCwiK8KSDjNoHgLeGsehJ24HFyzhyfhtxDCKQI4mD?=
 =?us-ascii?Q?T4YqT8nbLVA2eOB816sMuOGcpCGPjLb2kNtdta5z5nAqB0HX0EH5iRBhZ56v?=
 =?us-ascii?Q?WTWm88BnvdPWvYm7l2KEzKdinrtcWAYQPD6l51RodVD1umL1OTHw1YXVwNl/?=
 =?us-ascii?Q?vG97VhAASUVz6UWi639Tiy/Pkrl7260ghaWQ7W2/Wm8ki7jJmTucIzdFPl1r?=
 =?us-ascii?Q?RDMu8t6+g55q02HkzxVjht2SzxCjEfOGeSfk0vbj3+yOss4sYoemQgkL/NRL?=
 =?us-ascii?Q?41QwJH2qfRFvJyjK2/gAFZ4dUtzTRxS8MpA/jKzjSo76c3QqDMLCRyL7MiB8?=
 =?us-ascii?Q?7jz+G3c3DOM0/QFULZe0raCRsiECb9EslT8+Vm8Ip0mitAQ/MDXCjX6VtkLk?=
 =?us-ascii?Q?iyOHYJrVimZpl/qXQrihpTfLfs8Ap+B6eo21R7D0HtBiEGHlQ0n1W0f3FOjG?=
 =?us-ascii?Q?YS/Z17c931O+4hg6/DwYePwvt1Js70RFRGlg24/i0susMVVY41sb3m9xkwEL?=
 =?us-ascii?Q?fu+kdCbU9JObnsC8RtsYrnwGxgR+tO02N8yBWqWtW8dYJSpTRsodtYqVtXn/?=
 =?us-ascii?Q?JGkiKQ+DwjiKO4zvw30ia6xZQH1iVspdGV2tEWARAXnMh4jixSQ15a+B3txk?=
 =?us-ascii?Q?GWXM7uoZvBjv0gDd4ZbkNwwVTOYH3ah/l//r4Q5WEuFjdZnIrOqVMujYVYY9?=
 =?us-ascii?Q?m4StlSa02L6Obm+6F7h1iS1+1VG9XyWGZtV7z9zrrRa/MG1pV4jGR867eo2w?=
 =?us-ascii?Q?8Pb1yNh2+8xVtFR4rRGoG71aQnQVeHrCDzBrUbUkOZRh0QZniP+v7vBSQmCt?=
 =?us-ascii?Q?2nONnW+KlXImw4N9Gur0RA/YZnfWEYHQzdgRsUXfuGx2Hvw5jM7svP/zjhG3?=
 =?us-ascii?Q?feCT+ybDMw4BS4P/GEF6dx93EdMVTTCtRaW6qZZTJjWmaP9TRhS69aeCLvCf?=
 =?us-ascii?Q?/pmbTn6mohrN5xDKEf712rRlMi6VRxUY5aqJCg12MG9Oo1zxldffttVF3/3n?=
 =?us-ascii?Q?HtbwSRydkfblteND3zY+l7GI912Hyu3kbtQxcc8Fgs2n1+peSDQRLGCt8a10?=
 =?us-ascii?Q?f0HmApnku1LqRoS+VppeOSYV29wuCS70SprF9NWgruVHa4RDTFAtpnW+neRC?=
 =?us-ascii?Q?MtmiGHB7PP9m+ed5LVRiuztIWHm2xv1FBgoOqSolbu8MXAyGVRdbGvkyWBLC?=
 =?us-ascii?Q?WvFxlNffbZ3pYm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w7/p7/PfbQVInrKygLVkZHWvChZcT0LPtrJ2VIhZemmt8smMUFzdJvwpF0k9?=
 =?us-ascii?Q?7gmmfjiq/OLzSb49z6WWJt1nQesP0rQMJN+IUm6PnhoT7nv2BL5XVQKR6yql?=
 =?us-ascii?Q?DfaG6GOHxhfRZt12fLH7knB3gRfguyEg2LcK6fDrr0GZlz/VayRAmJ3i2xOP?=
 =?us-ascii?Q?+NuZx2PwDQJq23iFzvTOiZzxyiARnNOXz88DvdyVxHMjty4J/53zsWPgmy6x?=
 =?us-ascii?Q?LVK7dOFYUbmjDv9BdRCZpZB2UEseYtF0zvjl/eOgupVvoHlcseS7o6Ww8Lkk?=
 =?us-ascii?Q?Xa97u5Twox7z1nmTZoYekPe4t0tBhdy8RY/hmRA32g1ptwHMgXZ16X7rCCMh?=
 =?us-ascii?Q?FWRpNq5drX9P5GmCoeTRu6PtGGY8gvO97kOldKkkv5HIVeWCSKOFMGyAd90u?=
 =?us-ascii?Q?gcxmx9DlmgmDDS9e/6x0RTTofW/g2/VmOfw6IzzFXd43/Adr74a2OVdeWPCd?=
 =?us-ascii?Q?WHvFXIZE6D/OBQFfosHQlygaT44K+ujd1aTlMh9f3Kk1GEINwHFQAq00RaRw?=
 =?us-ascii?Q?+uVI/jLzd9W8i1ENayOBlB1gqvSA5n5W97F1SQP7febL5ZU20wdi5uZMp0ed?=
 =?us-ascii?Q?Vwhyfn8qidHvUETrndsA/F7A+F52piEQyfki3bS6C4H4gNvkw2O3CI7/JKLz?=
 =?us-ascii?Q?cBbnRH8mUM9kgI7QwFuoWhF8uRXrdAd7QZD5HKQhtw8CzdJLLq+hVfLa7MTz?=
 =?us-ascii?Q?P7MgRzR9zMiEZWWfCHIqCt1KFEtHYiwaSIKxjCbgW5ACwhy6TmmtkcEXtlGw?=
 =?us-ascii?Q?WQxjJMWoZc4nHF0vHkvh6y3Kc2qJjtWwPrD43iszwjWReGHaYk7DEZurcWOa?=
 =?us-ascii?Q?gGvq7BHccbgrgRSAIq//uzk5PGGGzUNxGiNUY3mvGo7lneJKqdhjXBVXUTjV?=
 =?us-ascii?Q?AXNYKvHNd4i4i3UizBniJ3DJyI3N2OS1s2ZdHC79zMlEdXB53BN8g1dGKvzF?=
 =?us-ascii?Q?+DglUkMwert1VCQRM8orxYfeaC0OTm7QgRqfZSudm1Y1jgAr8ve8RZCVXM3x?=
 =?us-ascii?Q?pJLiIcF9lzmjc6kyELTeFkc6qFo/VFo51FT+wGCJKrH8QIkoGYLd7B43AJDB?=
 =?us-ascii?Q?GowKq7aoRUYK5mMc16Mf1OaHGY5FOF4xdlpl7eWoasMM9P+ZYJmSUR/jPWR1?=
 =?us-ascii?Q?LTZXtnEaBPqfSq9H9TJsVVAKfvafTr8Ac03odRMENKgYR5xb6cWev/GWHMU0?=
 =?us-ascii?Q?X9hKPMaYdwO9Ujr8paX7DLRNjuSpqG0KJeieX/SsiGwHOiTCM8SwEq8Xe5Xr?=
 =?us-ascii?Q?HAjJAd7RUTCAaOrkTveCP1WCEKkOR4gMPq7k2bR4t6wO5R5uganvQPK//yg+?=
 =?us-ascii?Q?lI/NS+voj1b2p/T2dlnkm+WPlUcwq6rFmdSyP7fbtHtBAdB2aQ0OaWJAhpk6?=
 =?us-ascii?Q?8TWYMPV+xHozyVPGo05GKb5lcoByd7BMWPbYsXP3DQeKXJPfrW4kYP34MJ1h?=
 =?us-ascii?Q?LwxVFicJenmde3bY9nPQLHFg1JlPR+YZHmXhpP1snrxP7MVnaE0nv9Rfznnc?=
 =?us-ascii?Q?aVT2aIZMXHOGVuLpwlUNah/MpDna/FxTEvpVHA746sS0Z9g9UreYR6aRdT7t?=
 =?us-ascii?Q?jvqGcO5kMMD4INoeofDaNnlcdAbLoX4aJKKrqzGM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e1051a-a4ea-4f56-d4d8-08ddd8b9a290
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:29:56.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLFJUCvFVWo5dg56OhZ88TlRHHSEoYe2vyfUdUyzyZXsjmfEXeTn8wiQMw+q8ddpQGh+HTW6YqxslB0t1j07gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

Without setting phy_mask for ax88772 mdio bus, current driver may create
at most 32 mdio phy devices with phy address range from 0x00 ~ 0x1f.
DLink DUB-E100 H/W Ver B1 is such a device. However, only one main phy
device will bind to net phy driver. This is creating issue during system
suspend/resume since phy_polling_mode() in phy_state_machine() will
directly deference member of phydev->drv for non-main phy devices. Then
NULL pointer dereference issue will occur. Due to only external phy or
internal phy is necessary, add phy_mask for ax88772 mdio bus to workarnoud
the issue.

Closes: https://lore.kernel.org/netdev/20250806082931.3289134-1-xu.yang_2@nxp.com
Fixes: e532a096be0e ("net: usb: asix: ax88772: add phylib support")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix the issue in asix_devices driver
---
 drivers/net/usb/asix_devices.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index ac28f5fe7ac2..8d50b2c7e1be 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
+	priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
 	/* mii bus name is usb-<usb bus number>-<usb device number> */
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);
-- 
2.34.1


