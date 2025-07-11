Return-Path: <netdev+bounces-206083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D570B01459
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7F416DA1C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701C9218ADE;
	Fri, 11 Jul 2025 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KoV0Nvba"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A121770C;
	Fri, 11 Jul 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218293; cv=fail; b=bDkPkXTg6EoE33PieRiMEk37JX7y73YwllecoVs+mTFk3dEiv8/uad2kwps+U+4n1PkCN7DGruIu/gyf/tXJh2qMePJX5cKw7ugzXorvvPWUXIUY5Kwf+iPiAqYKaHcoeY0wgOLZQoYlHwRdbHw26Tycn3gjJEhuZDfNVbVntGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218293; c=relaxed/simple;
	bh=znNl1XY52TQYXeyi/1T2MgZUROcqjASY2yNUVz5r4qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxBxWh0PperfU31udQEo7Kw1gJjabjM5fsjmR9bf2SKfKK+oTHdo9A8hIXeGPiisCDqIhCK04LLAQmHlDTNcAeVp0Gvf+A/xzb6p3F54XdpbhmFwo4N2A3P2NrYBtyViL0+polSL2ksJS/2j0fi2X3mFHhB7EzMEaaD8t/RIMm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KoV0Nvba; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tX3maVap55gFm3f1ZSOAQ2GCXqCBAawR8PqGDePqrX3hlkARHKl4dE2b4RB7J7RRKishZVY37knbFbiNFvzBlEzDPKRKrnV/RA0GSmHvbOKycWLvKlSfjS19S4zlNo63E7iRLZco1honoMMqbkPRk6y3lL2MCJiKC2b4JZ7HHTe67MKqCFhznCyZIv35EdMdGMJ+DAA6muxhZw8QYE0JorEREnNX6dsreIzG6oGbayUzGLuH7/Pa+mlpIJTZ2VDlsCbVZM/BPvJPaO3dyytPnurFsKdmPA10ux8GLPGq9CjyMxPZluHfgJUhIcRAltjoJogtTr237gsIBwypzoBU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSYUsd4x/QyCHTuSZ5/l9CySLkFgkJCewfuKRqxgd8s=;
 b=mRSn09tqiaz0+DBA6cgkzWlBqKA5n6WI8N+WTho8rlT31QgFgD32nslbtiVe3bggckfIrOlSqqoeOr4GDcV9RExeBpHP3yJib+C5jEJrv2ZBGOD1vdXz9SyqAngx31dRC5/K1dzR/J3GmHlwezv36+7lrG1HxjBPZ43Jkjg09hzNNbqUt6+taXDGZwhe9NkXESqnrAKdPlHu6M9P6mFYwjLRMFimoFZP5o5Z8cRMZPy4obOyxJV+Cmanf/shXkpCQx/C6t6gFoTttIFjliLuNKBUTm1faA+KH3GhiEW2fsndm9oPuJlLhzR3sPTg2ZvhlFv4IDPeyDEWMns0do3D9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSYUsd4x/QyCHTuSZ5/l9CySLkFgkJCewfuKRqxgd8s=;
 b=KoV0NvbaYE9lIDK6Nl/eJO7NuO3ugFlzJ1VCU02d4Pem43CR5aiw9BLmcMPJJWawnJYbr5xXjsqlO0r/HmB2aDG13HeLhT5Y4dYDloikyqal8XmsIewUN/qWC00rO+lktzAbAlz5sgeFq95M/g37GJCDLrICC2/H9yw4ShtSkgfElCwpvSDyPb1orzjHCYQAW/tRP6han7pUfaddADime7NgeN+Vb15JcYwGCaEw4P2hImofuBII+1wHhJISioYHX53gKxX/EintZKCKf5NqdSlc7bEP4jgd4hdRKQrPIAS19o/QAumxEvd+cVmkyAZlVT3tmq8W23Ont9CghGwaiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:18:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:18:09 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 10/12] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
Date: Fri, 11 Jul 2025 14:57:46 +0800
Message-Id: <20250711065748.250159-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: a263a394-fbd1-4c0c-a46b-08ddc04b166a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hz269/uRsaGWE9Fbd2CzAz68/NF0Ifzu9m2B9kfCo0zgc3XBK4SwhUbewLvh?=
 =?us-ascii?Q?VnwsBWe0N/KRGsnLWmRN/prBYhK3yJDhmhrP55nJ/o2ljvL4n2MvezL8AToM?=
 =?us-ascii?Q?RLT4AU21s1CapwtIA2oB9Lga89k/AK0leUkBhggzVdjAzAYsbL0WTIB/g8ll?=
 =?us-ascii?Q?yCmis9A/Knv+599xCa65xOpllJUSPrs5/Kw4CHD2ck8jK5GGGPBxHRtr7NoB?=
 =?us-ascii?Q?Y7JymmjV/SrhBTj2nziGd78N7DUe+mk5vzpb+NwsHLO4O/pQ3I2E851jXGkE?=
 =?us-ascii?Q?PEVpkuA16BB7T16TI+ivxOp8Oi8OpFjbLiZI8zbu2oNvB60PxXNdeT1/tQrc?=
 =?us-ascii?Q?KT9XoPtpR2KG/8BIj0JewLi3iM8HcEm/cMQTi1aYVHhVnanEqRodLIJ59Idb?=
 =?us-ascii?Q?lfoWi+jFgNHavRO3lGH1JvlnZDfmAx+XRcNuTWRTistoYlfg4ko6wLAxs4SZ?=
 =?us-ascii?Q?qJbRFFPhHOnAmV2HUDtJaIJvAcs1ZzKW9zRawrmmdn4wN7c20ID/yHihmv5B?=
 =?us-ascii?Q?rBndwQFzQ27Gvt0OV6sGG/eUtgNCNvUoC4C9+i4AESX9efr+BEm0RaD8AnNC?=
 =?us-ascii?Q?ZPpPdfV7ME3i4n4MT+Qf35TCJtbmJOC1ym0r2gVZ/Ly4BDZH5LayRusOS8l6?=
 =?us-ascii?Q?0lM9gsXjmWKJal/PhsBACu6t/JOkNie9eOo35Kh9vwjOnHAxKtWeuqBWMeR5?=
 =?us-ascii?Q?uJpwGGSq+aFZttxhOpRr0h9SyAKShyjILZ01bqAQJmYK2rLOiiQptQfM/cCj?=
 =?us-ascii?Q?CRfZi4HRmmzRQcn+mca765yLmychTu9cxdNk3rNkG4pPtY3bIFjHMARePiWi?=
 =?us-ascii?Q?uJ7fvyvekPsmi+PgDb3T278VqCdZNLc14/9Qnjwdg9frWMAj4r0nTwdlSWwj?=
 =?us-ascii?Q?kf2FOROitXbdl+S89nkUuecBLixsTL8JQNfmVNyu5N6NdgzvFulDKGJrHdft?=
 =?us-ascii?Q?Rwp6i3MohVVvzzI8zo9bpdFibh0Qmhu4px4WCmk0uU9iZeVZcuG2G7RHtAbM?=
 =?us-ascii?Q?qNELCQKk5Lt/t2dnWvrfrGXZ7Sxb/CnqoGHG45EY3Eo12lkeOKxyQJNHxhGK?=
 =?us-ascii?Q?OXX6F7TiHR1nacnOIRlIgHtN8f7M8WQu3LtaG6du2WTb/ZyB0XDnrZko7R6G?=
 =?us-ascii?Q?ImI9TUYjyW16JdMuxIOtkCHgto/M5HATV+qddWEmCdcKphgUlHx7mc866UOZ?=
 =?us-ascii?Q?8SlYAONXYqsm5uyXXFTPRAcOPpVo44u5OcHcISAtn0nqPx3JvzlnEiyTpKMy?=
 =?us-ascii?Q?zXCYmmrk6NTJGYxxYVfft2Qr5zvXp5MvNgIzCuU8+X/Kpi9QZGzKV5nsVN34?=
 =?us-ascii?Q?+P3ElqtZIewKP1FAaamiCyurpBvzbyuGYb3N7BDaJxFjQAkEDfzyrOjXdR+L?=
 =?us-ascii?Q?bqnlCIQ1N4ZAlnDw8EA4lTC0bMwoA+n9nQFzKUoc2y4uBMb3TFoWnLGCHZb6?=
 =?us-ascii?Q?+fPX0Id3zNgYJyM1T8cAMyQSZ7NkQ4IL+KXX34/WF0R61Xjrt4+Qp2Cf7bfm?=
 =?us-ascii?Q?JHQtR+h5DLco+O8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VAY7KlcFilCvjuQLr06x2nZGi9tOxdYFrJNDHH/hC7aTdjuXNG3P34ZJz2rU?=
 =?us-ascii?Q?kccPRcuBKo4TwzAu9yo8VrsbC5kMrNsMrPdnaSDqeCmJCRvw340ULCJgt7ZY?=
 =?us-ascii?Q?EaHgIFcupv6lWtX9U816nyMZYHwRMgcRm2RNxl8cTy4Qmy1JaeAdYf6Th/7F?=
 =?us-ascii?Q?p1qhm+Ia7INyTUR2GmjLgMDbvj27pwsEhYwS9CMQyGHNJOoBmEZzAOR7b3Oj?=
 =?us-ascii?Q?mReEk7O+awJVoPY/juNl0liqrh9HT21S33/xvbIhqhKYDVIvJwFXeD7EIzfm?=
 =?us-ascii?Q?c5x9qEQB7jTIWtmAKiQ50taATaEQs8Tk3mWfABmhFEDsvkewrzTD7f01Ayyt?=
 =?us-ascii?Q?+kpeshRe9pcJlYv//yGtruoJFYpjXzpP1UjE/0fXtxA+tTXQBUu7OcD6CMFI?=
 =?us-ascii?Q?j8zmZYfhL/0/7wu9Au6EQOFs+htqW+iMPvEDNYJ7NV92PKwbn49k/jb5Z/6/?=
 =?us-ascii?Q?SyX9+ALPeeszEtycpq2TLuzGHy+ZFyNYZKI3biRQbLnIzYi88q6rvCjl6Kk1?=
 =?us-ascii?Q?xyXyk+uhwKY+A65iAhabPmDVoJqHsIE7RW+ciFnSFEewAkWe/CSLyZUFjqpl?=
 =?us-ascii?Q?c9DpRxO5LjPufcoOBW7c3G545wchXhGszWmfSK405xDvuMdbKP/PMuG+umw6?=
 =?us-ascii?Q?BKPIxx+KGV1TPFxFtY5Ziz/kd8sYEf0GAYXNntdHyVsYJz31aXOvoE/N7b0x?=
 =?us-ascii?Q?u2o2RaUiE34aMsIDxmjaZxZ2fiK+/KL9S+ZfaqTsddFc0+puBpyxBKnf4GhT?=
 =?us-ascii?Q?gSLHYsViSrFWaGCJDf4O/Q+71KRaZv9hgc1gw1/XWTFg6zMk1iGDR4WA6rES?=
 =?us-ascii?Q?H4FKgTYkenSBfywkzYA4eZ7guoCJpXLx7Xz9zGoK1XoMArZ0VCNx6jTGDTLT?=
 =?us-ascii?Q?cj3ubztUSw+UxeFePqMmG1zbTPIV0YOIrt8litcL0EScwOChbbQG3pyI8AKx?=
 =?us-ascii?Q?XEu9TMfQCsz7hcioI/BHVLJqkcsha0TdpSkEDx53augaEQ/+Xkj96AxzqdFl?=
 =?us-ascii?Q?056MH3ivJqDrXHLpxvsOgeta16jdcwVHv7ENZAnf+KlFbUEVsD/5ORUTL2Jn?=
 =?us-ascii?Q?tdAFSpEoEYXE07D0WVpy0PM63JmZcEPY1L4WHXhO4gsLOETtNS74ZgV4gQ19?=
 =?us-ascii?Q?JI4HPH0E6+8dqjoYzxLVtUahK438t6Hp8ZkZ3aXnwhxhtMGJQGQEXii0hNWi?=
 =?us-ascii?Q?c55WS5anFIzLH8wk5xI2lkosh73la5ULfSQlpqvWLhfGw7vp9osM5aC4JBJa?=
 =?us-ascii?Q?HPKcKYLMzz4U+nH8tWOjytR7emCOdSShZi3R5QtcirWiv7nUQAEvUAQwc7Qb?=
 =?us-ascii?Q?2vPJkQH3idC1hwKYHnsNu104kQP/hNgm6kyPEyT5jyH9rHMI/25pb/5nWGCS?=
 =?us-ascii?Q?Yirq2NQz0vtdCQHuYCBUVOqsxj8p/Rm4czWfc6zXx9oRwFFTNUYAiyJOeq0+?=
 =?us-ascii?Q?zDM8D6o3koXyzENV1wAyBnDNSinTjLrMnisrVNpK4SvHnDPjgysa5Dym4Wgo?=
 =?us-ascii?Q?JCM1U3J5qfwQRdRhlsr5RW6/b8TpYVYcMgqLwbQx7OTzcF8SXcpcaNEHlDZ7?=
 =?us-ascii?Q?5j8xdK4FLBbJk3wH4k4s23JuKb0zgx8sVVvT7MJH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a263a394-fbd1-4c0c-a46b-08ddc04b166a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:18:09.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XysaaP93jvxnvmjqBMHXOGsQyKG0Jkj5S1D7CBEFw9lnFZdtcB8od3d5H1oC56YzovisEEpLPwmKdJ17Xe7pSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ef002ed2fdb9..4325eb3d9481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
-	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
+	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ce3fed95091b..c65aa7b88122 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
@@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		new_rxbd++;
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
-- 
2.34.1


