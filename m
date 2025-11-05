Return-Path: <netdev+bounces-235710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A65C33F5A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 05:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 688C74F1C9F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 04:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ADE268688;
	Wed,  5 Nov 2025 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aHVMJeWB"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC845257836;
	Wed,  5 Nov 2025 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318574; cv=fail; b=OTvs/N6LOrLKr7eUhDzGUCso/LS4AiUrzLx++GCUG38l40EI0vOEvHjDE2knfxABzn0YdNW51p5qDi6fr4cDMDfn94Mz6RcoCYhBa00IgSPgRQDvmwRQtYpjcvfdZ6NPxi2IjFdOnxEdin7lsJL4QGVhWPqtTIOypz9rXTNfUcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318574; c=relaxed/simple;
	bh=MBKc9opRGYcml1W5ODjHbIfGlKPxWiCyLhsY/AKsVFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DK490ySXL9qyX/N59aw2R7IVmWEW4/PHE9pTjzbThihOiv7oZKMItTU4qDsu9HcKSFyCKJFdFQOzayWnvDQL8wnfTLPyhmnLw5wNgK1qFQ9elXFNSL/nItz5LmLiXaerj3yw5HPO4n8AXi5UYXiP22B7h0YlvqQ1pH/V5l2HsFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aHVMJeWB; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGUuzXv1/VK9gUeWWLtxkZCuB4v+TOwoLTuF+HqOQpkB8gY+bU3sgFi/8PQ1tgcPaLIgjzQp1EFx2h+05QRU5wmdANLzkAahNdulxuh3EcX7wseyPbNxTe5aaJIIKgwgpzedsEFYoqZ7pSxw3CPoBPm4GKkebxCVlEJM76KBbzMamY1VU70yQoKKDiho0dGSlQc+w8XtprQsZj075NIiW5fgtwiBs/1w5UlIV2QaBXPcIM0V8BEwflHcK6Km0jmLNiG6lnzoPJ8vtrcxu/ODn2xwoTETlVnC7PBj6dwSGeWaDcekamSF4uUbKG9aVKW3LHxDtycgAVHqffIcd64jFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/eugTD/8CFFhJnQzZHMZfIdCB2duZw7cMIF7/qFu0w=;
 b=B8my4qTtYm7O180YD5U3TN3f++OGbZM7oDPzZoUXN51RhCnuTbsAFP3/RXZO6vdxsENDMWXMq3meZwuI65B/WhuyRl2YC47YITHpWHsY7aG1QuFq0z5GwtRcmo/bnXr337GxFfeckUzIM0mfLUYpPB5wJotp2EvOt0bZGtkVgl6iGBruTbwthU03gl0OgwyMXZmFaDsVdECNNEMZZzzGbzfkVJJTX+3MvCynhaRu7B44GyliRpPGiNQItUsDYlC20QIWaqRJTdmJWc5r3p5qM15YrHotftWm9jZXp0cBHidow8i1eTmWyNvhtkO/DgxCn07/37aO0c3vSLI1sPeJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/eugTD/8CFFhJnQzZHMZfIdCB2duZw7cMIF7/qFu0w=;
 b=aHVMJeWBKILory7+070ejptxJkr8fRcTyB9VyT3IbxuM+MicAfb7rikmj/yYj1Jz0m9A8XU82t56Jj2D9mACO5kyik9pxqe38vGUCdkb2mXG+6WxGLv+rQIRH9RWfB3Rlzw14W85iaXlXbguDa7LhUYJbBVoryzsAi3q/V3uXfS1S2ZgUjDDlYYPfWLg/UycGnZddBIcjAe1XLt/cdoUixcsKVme4Pmyry/+dA8do0Dxp3wvL89W8CUa0SFVvFqmxIYx1cUnfan1wEfbbHuZi7CBKAbf541K/QFFCJGYDfpgDqPJ6fQzCRUG0LDDX1/QqMkLD9/SHWqCCrFWsLlzFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 04:56:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 04:56:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 1/3] net: enetc: set external MDIO PHY address for i.MX95 ENETC
Date: Wed,  5 Nov 2025 12:33:42 +0800
Message-Id: <20251105043344.677592-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105043344.677592-1-wei.fang@nxp.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0174.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::8) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 317f2924-3796-4e14-8398-08de1c27a194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZTAtxizUlt72rCaKEnVaFN29BCXdwnnMo/cyWsyGT/0zRm7tpja2MrODlere?=
 =?us-ascii?Q?6hxlOAOhqC9KIage2CrOl/pX0A470Z+jFuqI0S2jQsd8F7Svi8iEbXV0u5V1?=
 =?us-ascii?Q?Z9KNKvc6kKd3Zn5lyJzXLdbN78P9NRrzvbdMJ0cOE3ADV4XXASMNTZS4T+OK?=
 =?us-ascii?Q?1Z0iyc2O8/TMIC7+yb5gYbTmHPPHhbvR/xOycnscBnoDd1Gw04NtimCKESXq?=
 =?us-ascii?Q?ad9he6yVZGN5thmJ6LPEIxPIb84H6KL6VP0dNWZvH/uGcgciTLavK0NmZcTf?=
 =?us-ascii?Q?KUWoxJ1RLUwHfF60fRYWblNtn1cZJLHQbUh/hMoyZwyLjICizG5xyyPaSZ1m?=
 =?us-ascii?Q?gf0PMNm7ykd7met9oXTFK6MPQSvJOO75PCrE+FT7C8ClfWNd74XpHbFdhCuI?=
 =?us-ascii?Q?fXqRfvvF8ax7fzVAuGlx0He2X+rFnEwJgA9GwKBFxiYLVgasdybWppF25MzP?=
 =?us-ascii?Q?hE0EqUJj/Pq2BuLZnMoYMF6UDBPw18neMrWqOovxxdnWSQCzmitkMtcrMgC/?=
 =?us-ascii?Q?BTMY5VxcvKmXZrCCZMp8Jn5jqGT0aK0a8r7kkCAn3YnAE0FLOmkTAQalr0cw?=
 =?us-ascii?Q?wrkRdPUffOY46uxg6qeHYnEG27WYGj77CHll2rDRS2kR4ifVJz725Y3Mo+fG?=
 =?us-ascii?Q?oxZMid2sGMDfmql6eq4u8AXJ3uuMFhS1dN5At969CRC2G9le3NUPdOCXb6Tw?=
 =?us-ascii?Q?jFYZgq684CgyAsnNPqm+77UAyDjb9UI/T7Nxz2xjfgNa6Ds/1nGIdVBryDBs?=
 =?us-ascii?Q?417XQMKDlVxvftuF4o/uyJm5aekej5un3152H2k6E6dvqvEI9TeNftOnvhR0?=
 =?us-ascii?Q?c2v12aYC9S4vR6D4Cs92KDG51JT8fLe4deg0lse3vyf0ICsL3YJjapgLyUjY?=
 =?us-ascii?Q?RUHscEUAtsPMxMzGOvBX2+2tuEQyenCsSAMOwT8/JI+e4gWPAiR8QxKIuJTh?=
 =?us-ascii?Q?izDDHNiie3e/6NGD8JkRlwgDcebaB5xdrOa32Y4fis4tcEdykUoHUf5VlLpx?=
 =?us-ascii?Q?XvqcrTM/4jMD1J2yRtzam+6Ttr6TeomauuYasaLCMMVu3kpEGbhj7C4fbjLf?=
 =?us-ascii?Q?eU7Fb46MFDxv8LtEQ3YLL3wx3u+sIsidRSYqGFPjYiocqC0EM2XPaVVoUuyS?=
 =?us-ascii?Q?N986bRwPMpmMmFCgh/GNO93p4pkIKpGlf+SnEPuCakCgFeu2oa5xMxhGLY4R?=
 =?us-ascii?Q?li/ZXhtQe/V/rsmhWDBlXSB4N+i4GjZcVYK/pIWKkTPywglBD4nOWI4Ynipl?=
 =?us-ascii?Q?Zr+3RNTN1cvMXvfhF/5d1ZEEt8MaAqCa6Wd8GP/6igc4WNgsvElhW+Fsym/e?=
 =?us-ascii?Q?dvwzdZKSjMHRVy0Yis9KO8cjYuwtodHhaIMSdBKBu3mbxxvU4txklYuDn04B?=
 =?us-ascii?Q?GacF4X0VXoQ6wPO5s0gSaEpwqZPEepcpXmSKVoGJGvbkLn9F69/Qm7vdKtK+?=
 =?us-ascii?Q?JmF+cyYH+V+LyhkU8UNKr8szL7JOEH1EHDXDifEMLx+73p9hjSduJ3hdmSGK?=
 =?us-ascii?Q?SMsVz1k/UrEk19JvnZVd+kQuH4AYADZA8IcB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ulhRqQ3aRn0YZlJgvLSNmoUEIGuSauOgpzU9W4yLiKJZMTO+Kese3J4PU0LB?=
 =?us-ascii?Q?JEVEB/OrEmSmO8lHHbIKsCezEjqMT4F7YY1QvHJcVjHNR7yYvD9GnHX2JWKg?=
 =?us-ascii?Q?sWjUYF5Dn2cZ0nYM60sRx9qJ7EMjg23wDJKxmVQSNxkC910DruF6/YMSpJBP?=
 =?us-ascii?Q?THGIN8NuP2B79q1y4N0WkApZ2w+Dic66GW2bu2Pgo0l3Y/wPJnSfKlGt8h8b?=
 =?us-ascii?Q?JetZ5eUUU54AB/7fteNlrVuY30EdoA6kLR0xiiuy3UQvF8iqnjg3oDYvZgj+?=
 =?us-ascii?Q?W0a5cKNx2vsYxHUUCxg78PIu5hSO/Hi0bKeE3grCNImVXwQ3zVza26+l9ULw?=
 =?us-ascii?Q?u6AajzBw/vdF/tnU/OnSTZsaUXkUCoFoIUb0GPg/mBXnwOZsf6j2QS+jA0x3?=
 =?us-ascii?Q?hlIw4xHGNvGZLkqlVEr0dO63WJlnuFxuvtQdiF7W5BwJbL20bTboNto+QxDF?=
 =?us-ascii?Q?DSrorU+KWktGe1wmzv11jy8vaLm6oqzfULA+wgN5WZF5X9JTxXNDdxDCTP7u?=
 =?us-ascii?Q?XUcZxCma86863C6LZxvXqjju+Kbd1PegWYPBMwbfYsmF3Y6PslpJ8mUTN/nO?=
 =?us-ascii?Q?mxkok2ESHDhs0E83gEADFx3qNTZduo8BihQUKdPq6NwDbD5oaU9CAutuV/2l?=
 =?us-ascii?Q?BGoubbIf0bXAXOkAEUlCUzlw0ihRJK5xAwYMULvcGAmbrQ2HyAaYb+BqnZiq?=
 =?us-ascii?Q?ZROfOd2kTOJZkbhA3U3J59oz/K01wbM61imW1eDWg8vECELL87mCk4H4ALzZ?=
 =?us-ascii?Q?F4Wq94Yhu7bALzDCNDxAS5gu7ELm76W65U6ZhiD7cxoXKI53u+yAyvUFPiug?=
 =?us-ascii?Q?kN7Vnpz+xonwHoD5yiwy/xdtTMdQm4c/KDnb/868VBjukhVrItYFZECU1nDi?=
 =?us-ascii?Q?4sIPZP0u8j0+QFfo3m7gLCapgn+w+bbC9nxeEYo8S0G5BcTBk9eyQDnzo2lc?=
 =?us-ascii?Q?OlZzbLsISUMCOClQEeIPaMvybZvdPD+UVw0o4D+DYhcDQm7zFzR52Ei4AiZ8?=
 =?us-ascii?Q?s7kj9QVr+RJvi68PBEw4I8man6RdaTrnEMaAA0clzjDMB2eIdtFrINskSkuf?=
 =?us-ascii?Q?VhsxVceVZLlD4CNxQ+0juVol3jB0vgmHcVqIp9xp+n2mwxhtMtydxuP1nZvo?=
 =?us-ascii?Q?+7f1Hw2s50s70/hx2IMyXqZUlXwzMaOGFLWk9696z1B8OPDbrnALOOo+3rGH?=
 =?us-ascii?Q?+Rs8arj3d5QlFBsZ7hwiUNAMtTR4SE7PALLkhWFiAeAFQFPmhmvRAECT5Kdx?=
 =?us-ascii?Q?bqg9lE94XYIewLH1/oEno66dsl7wsOieTPEhaEyvuJzpkgYKAKjsSPlG9k9y?=
 =?us-ascii?Q?VDpMI9DuOZxncG6pFQgFUQEQuKoYDaHR75/x0nE793CSwklLlEnF59xucMEh?=
 =?us-ascii?Q?z237UiapzKHNJb4LWbJyVB/nO86OYO9MM2biScAOEhuFRvP5FyAFLL9rCaAv?=
 =?us-ascii?Q?IO2OphKSCUkcCrdEauTez9GINJQiS60vO0MpzMAWDQ7Mh+Ga8o911Nm2cpqp?=
 =?us-ascii?Q?I4PlILR6DwzK3H6HhmoKEnCKrO6PvvK0BTusmr3clQHto8JEKOYjLDUjkeiL?=
 =?us-ascii?Q?KiJHhuTmRXPKwxcWOJGDE5UszPTfHjBjRTg8iRr8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317f2924-3796-4e14-8398-08de1c27a194
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 04:56:07.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuKPcjmMUIq71qEth8u8Q0nt3OTHuB66rGx6Mw9PCcWMD/4ONiiIjFM1TA9o6J7zduSmFhl9Y8aL+qDidgP+vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

From: Aziz Sellami <aziz.sellami@nxp.com>

When configuring the PHY as port EMDIO (by putting an mdio node as a
child of the enetc port) the ierb needs to be configured with the right
phy address. And since the configuration is harmless for the central
EMDIO mode (current default behavior for i.MX 95 EVKs), put the
configuration there anyway for code simplicity.

Signed-off-by: Aziz Sellami <aziz.sellami@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index d7aee3c934d3..1d499276465f 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -67,6 +67,9 @@
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
 #define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
+#define IERB_LBCR(a)			(0x1010 + 0x40 * (a))
+#define  LBCR_MDIO_PHYAD_PRTAD(addr)	(((addr) & 0x1f) << 8)
+
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -322,6 +325,58 @@ static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
 				 1000, 100000, true, priv->prb, PRB_NETCRR);
 }
 
+static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *phy_node;
+	int bus_devfn, err;
+	u32 addr;
+
+	/* Update the port EMDIO PHY address through parsing phy properties.
+	 * This is needed when using the port EMDIO but it's harmless when
+	 * using the central EMDIO. So apply it on all cases.
+	 */
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return bus_devfn;
+
+			phy_node = of_parse_phandle(gchild, "phy-handle", 0);
+			if (!phy_node)
+				continue;
+
+			err = of_property_read_u32(phy_node, "reg", &addr);
+			of_node_put(phy_node);
+			if (err)
+				return err;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(0),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(1),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			case IMX95_ENETC2_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(2),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int imx95_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -349,7 +404,7 @@ static int imx95_ierb_init(struct platform_device *pdev)
 	/* NETC TIMER */
 	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
 
-	return 0;
+	return imx95_enetc_mdio_phyaddr_config(pdev);
 }
 
 static int imx94_get_enetc_id(struct device_node *np)
-- 
2.34.1


