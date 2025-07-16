Return-Path: <netdev+bounces-207395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA614B06FAC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55839507746
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1583292B42;
	Wed, 16 Jul 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hoJ/yqPW"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF722877C8;
	Wed, 16 Jul 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652329; cv=fail; b=i2ndGwd/xkiH9bNDBT/g4tn+x0+rFMaD15jtHDWCeqlEoI2KtDirjGLMotmcghVa8eLlj/iMq1uwygT8n4fNkAQ3fGO2bc93OfgeH0KI/a51gsXj42Wf9JezGwaHCUU93GpDXcbo/PXilhjcltxHdrCeczPM1S5I8/omSf4a2EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652329; c=relaxed/simple;
	bh=9IkTq3IzrjFQmMsjwOhzbppJ7MDLXG6rOV2I8OM6SXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciGs/BgfajKkccJpsVFYg0eqhxzROJVwXjX+ggrikdjZy2k74mWooR2WyZD00vDQAlp0nH4+4FAJ/6CG0gOLRmrLafuLDQ2sZI8VC4LTzkO+F8gIGzAihHYDXdGMr1RaXtTX273cmoy4dkTOpXxt3cupujH/zl6jcqJNiI1ixzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hoJ/yqPW; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgYQrQpj5UgUwBvotvluCg8UkDAMFNvTHOl1IrYZwzAjzEWV02F/Hg3OlhUOPIvgpRyO9ANcf/c+l9CytBBurrF+tJwar2CQxIfcjLx9d+OQbMj5r/0KgnZoWhMzAi5b13w+V0Q/Vdf/ZzJ5pVb17XvLErokBzz6vQPCoEjXqMyJpphcru9uMl4HmQ1Yf6Bt/0Nnt1FjKxc3sqnLKUPRuZjAuNYBUdt44VG1L+o52N1NH+LMLKQsj1J/0D5T7q/aaNr+i18wouWqjB7UOP8HX+aqG2cVDEPG9Nqp1XuXkQR68TDlmmkgRhCbB5SPCIuGgi8XSlq7h+yRuHPUgI/zYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8uJsEzpns5nxhMW2zRv1+V8BQQPQH+AljtnVvfkOe0=;
 b=Knx46M3vIPrrHHrpSYbIUgAPUFYJtTN/sRJxYr2UxsMmbACbdwk6D3y5xDsazLNhT4Iqoi1ZQHe/FHhwWcc4zrc6zvAOmVUz2M7V8i4qsI7i//9WDfRz07VIP+dOQp694vZCnBju9hYH2bkgEfASLPYs/QU43K/fcDR047nPQPO31RSzZjM2N1AM40kv/YawKys9uPxkACEVy0CWSSvYv7dwpPjiW2kAegsoLyby2v138UXBp2khxH3d/oCBv4eCjVmzVXbCxheTfc8mnZCpUskerM7KTBuvYUYlh3zU+1JwRZSiuZLINQ3bJtM+bcfUnivBeH47+ElSScquIxIM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8uJsEzpns5nxhMW2zRv1+V8BQQPQH+AljtnVvfkOe0=;
 b=hoJ/yqPWrgqFKREoan1mu0u+W8m/YWASgvr/0dtvhTB6IGdr3m4NEXa4d+7vrMXmKOARXvoaE3DP2yHiiGKCRj8bDaJS3ylaE187oKYCmxXbkH4bCoj3TTmQtDIxfSbnUV7zdRvXRTZidFj+RjKBR6qfqgPMs4cvGUrUwn3qTnFJFO4sDUoaH5FtkWJXWjzuC4Aocc9eX2y2m3EIjYnzkv8dzgJAdzftaeKT19GPbYYoM6XwfhNdjrkLkwGW3xfI5D4hflYg3unG5p82xcfIU/F0V9GCxDuGTL7Yd5MDy7JTCWap7FXv5XrHmgpG6otvSr38nxWknHMMzWFZXdDRBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:52:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:52:04 +0000
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
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 09/14] net: enetc: save the parsed information of PTP packet to skb->cb
Date: Wed, 16 Jul 2025 15:31:06 +0800
Message-Id: <20250716073111.367382-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 62519afc-9d4a-47d5-7a39-08ddc43da78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9w+kQtQePMYekVAdLxgH/Q4Hdv52XHpvFLGs9eMtgY1wkWZBGcUgvOPpuDwR?=
 =?us-ascii?Q?66P3zaViQgbTV9dSOWPhz+ZhUQoZgUo1KbFxgRUylD47ZgHLUzt9CbSBQVkc?=
 =?us-ascii?Q?KGwFRgUN1T0kuHqr2yPcqSHrQUUI0CWLkKY+t/3rptmGfcnCar5y3oVL0URh?=
 =?us-ascii?Q?idSeoZgrIevZsOdCYya31kzmFdlJ+rgtrqgWyUz3Dca50PLwyPZszXxqVS8l?=
 =?us-ascii?Q?wQ7Vf41iybsoksTkDSuvdmv8AN9o/v0k2egtBsJS4S+gim7eQOsBNZDzJhw+?=
 =?us-ascii?Q?ZSaOe+W6biV1efUuFjsEulh6/DOTyHpSlq0RkPliCF/kFdSNZf9w0RwNqypZ?=
 =?us-ascii?Q?ucuyIM/zhZ8IQrkhN2SARX1hgzSpb9sG3cnV1N+KMgQS+RCzhDC1CQQkIbqr?=
 =?us-ascii?Q?x0lajZCUk5o3DjrqqBmO/cc/62pdxA/M32dNcgaWxx8CG1vebTAZ0ZD+D8hA?=
 =?us-ascii?Q?uTcDq0dR8bxM5UgjlNjGS62is3pQEiJJFzC0dKx16V1rUzPtzQy4zKbdbqZP?=
 =?us-ascii?Q?tsNTeQd/tWGm7vyH5Gh8S/oA9X9OgCr5dBfJrBvNFKq0wC+1kmCcbdsHIeqK?=
 =?us-ascii?Q?Rrx5tQ3RVRkOPuDbeYRiuqjrvWOXsS8BC6FItmryDo3IxZiutoDEgcsqb4cN?=
 =?us-ascii?Q?HG1p33cfUoDgb17oWCYIHw3xwEZOOln9UD9dCOD+iAPHnD+BgXFwKRjaZzbl?=
 =?us-ascii?Q?1rfFzxhesTHur1H8yAV2nFr1wINyGp7+nDIdbuE8ndXQSplL+NwQzVgYhlp0?=
 =?us-ascii?Q?HyuqRs9uHKk2bQY2ZXx1uVJ+8kU1y0YOyoRaPfjMy5AKYvfW8WQRjcyt3hpv?=
 =?us-ascii?Q?Y2/TGF+d+cvxuymBA5NnsirlTR4mU3acOb2pQb72wxaKR5rtAG+aTJH6dpCC?=
 =?us-ascii?Q?SS4aUJcB2N6AY36OoFRljxNN8a15kWwrhKTzxpeJCSfAIYzL9khd8SxZ4fBc?=
 =?us-ascii?Q?CSmlelKZszc/YRCgYXq00Y+x6n0Xf/5mFqyWyeJa5hjldnfHcujhpECDKnUW?=
 =?us-ascii?Q?l7tOEWO/ys8IWmqZYN/SpNOLpurMpPRSTOzrINbNpnOLYBU4jPDewER6fGgO?=
 =?us-ascii?Q?XuvYduVqfN9xw8UiSJbN+4Jeiz2LpbdMi0oPX4Zm1fVpXoFdrDcX3WFqteOT?=
 =?us-ascii?Q?FuH/GNTdedbVYlTS5vPm2lnZnrmNwqMmyhkKX6b9TFzjYxp9dSJQwWfO8Ege?=
 =?us-ascii?Q?Bf9xbjDS+/DKMCigFEGr4XKwnJJYeNmFdmrX7uO2RQU2nUFP/qIUv0l+wp6N?=
 =?us-ascii?Q?61Wo9AF+99Q9tTr9nxe9NeFTVpwHpUrD/lLtXQx2daZ2ldiHUJ72twhCc59e?=
 =?us-ascii?Q?Bzu8lwwzVgoZtf3fyXwzxjAn9xhIBMXGtMz+SMIMnqQJCetQO5XfxmEyclcx?=
 =?us-ascii?Q?Ay1LY74zTDbw4W/u89T7dVdSUpor8eITmx0UL+SXyY4PVB8uUz11ejpQL7f4?=
 =?us-ascii?Q?7asP+4yk/7X7Hqq7j5sPZbpxQAdda5FFOwD+YSy1XeAiwPHmww3hbb67psFu?=
 =?us-ascii?Q?FSA/ZUBMizgxQyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ODI9TRorjzxoryTXkSYNURgE3JRvmu2WSKzXw4cna2MxOAGYfVXVf9n/TOYM?=
 =?us-ascii?Q?6K31CgKK3o8Sl8ASEJlq842RGZUPGLdzHT9wVN3YyIk13pP5R0GNplb1Z1O+?=
 =?us-ascii?Q?QK1oCVfmPWbL0Tl9Jw2jvKijJf28cWg27f5hgw1JQ+w8sy7lpgNVAaU6iptY?=
 =?us-ascii?Q?58eZ3ScK0tuXS1XxAupEbPszGaHQhtqlmjnZ3n6zI25Ha37PZo4K3WhS2G7P?=
 =?us-ascii?Q?PYYGOOeSUHzJUWbKa8ctCWQd9ZGtqbjonj0rU4/yrKWBedczBZtZxTqnZHFu?=
 =?us-ascii?Q?reeJIPcz22JZYW4wS++4D4cmUYE17TQ7G/pbv0kRuxPN8GoOrRoPxuYQgE4n?=
 =?us-ascii?Q?YpSmrdGSklKmndPZm1IBN/f6RSMBeqV48dIfWDRv3kwSROeVCO6DUTp+KPwH?=
 =?us-ascii?Q?qW8VWeeUOlGKXjIlypU8U2UAnoZhSnXExEkpXdehrZCW7cwlAoYTBPGVUKtY?=
 =?us-ascii?Q?f9DZgQtOut00PqOTRb3aJwjD1pxqPtT42WdnWFkR8gQu2msLeeIypmKqUgRN?=
 =?us-ascii?Q?QR4upqvGSTD9jYHJoJHj13LMpwM+asI8jTCY0fT1xs9YiWxapvWZjB0hhLd+?=
 =?us-ascii?Q?6DOwWiN974EFfhAUkIHixeBkZZtD94DLo77y817F7Xrl5DV6fQ/CwTibCdWc?=
 =?us-ascii?Q?2DR36v3x1YCbhBVE1jy6WptOECDKvyUBM5fJKx5fxXUdjSPN+iDkCnlpBsbh?=
 =?us-ascii?Q?9mdkzEemLNFp5jOc+xf02AYd2z2azpMoylseUHv7i0Wyg7JAUBwXS0891LBk?=
 =?us-ascii?Q?ZdAOMqAdThMgkjxCDmradYZi8olI59ityn948ArPj2tLiHZzVLwarn90B0K+?=
 =?us-ascii?Q?vmBuLPoIjRAdonqNdxFeMrXTgXTzoCc56FYB2fcJ3ONRGYJrMx/Ar+QD9W1O?=
 =?us-ascii?Q?P8z36QtuBbcZPXXyEA/P1Zdzw0nF+GaZuNW/dcRREAJGrO6o7/m0g/LFzL7q?=
 =?us-ascii?Q?HONO/ucy5zffJMLz0WSX60SdlU+AWU9pCei9bdAL5OYbu5aOP1mX6Xo5sAS6?=
 =?us-ascii?Q?DGxM51HLx3Fu7fLWNcSt2Qzxid1OS2zdAWmLpOrnezWd4oktQ8McAn8SK/3X?=
 =?us-ascii?Q?yB3jKWNlUqL4x+OQAd+gDAKa+8t3ITisnEHvOfVlv0uba8ajCUoJkE19wekc?=
 =?us-ascii?Q?pNloGZKH6heZ9Vzd7oe4OrE3bKXJd1xLpOxbuLgI4V5Az/JTKajc1gLED4+a?=
 =?us-ascii?Q?827Mnrw3QRZNbWOBJhext9jPoPx7Hr92VhpoGkNQLjS83gd8jwFvq3jw5bl6?=
 =?us-ascii?Q?hinrzG4VE/lh6PhrU5VCo5KLMUTX3mdFAuC9S6EkQrBS6IoHaV8moIZajzbk?=
 =?us-ascii?Q?gMLi08mu+m3S2Wcy7mS6l7bGL0d0TxhjmHD6/Fdchwkw292QQH7HNl0ass3k?=
 =?us-ascii?Q?RiuAAxKj47RFEX1uI9RgsVTlEebeff9osuE7zif2kJC173G3ZRzUc+4Wv/es?=
 =?us-ascii?Q?Mt931OcHBb4UWkCLV7xTrI1n1x1NXlRZ4ZBZjdm92A2s0fqmHspMXAr5GW3f?=
 =?us-ascii?Q?hUDJM/q+Gcg8M+lbpc1KUdns6PK4QJybsWpT2NWjcbg2Kj25/5lNtqFrrq/5?=
 =?us-ascii?Q?KP07TOQ01LAmsdmvrS+3Cv5+Z3j8ngsVaBB3lc/R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62519afc-9d4a-47d5-7a39-08ddc43da78a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:52:04.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsittfjKuDu5z1yMqyABT3Pw2Mn2IhfanKgpInu/OJIatIerlDLEHhptxxJAKsWA8z0u17/iFhcD5RvmRdIYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736

Currently, the Tx PTP packets are parsed twice in the enetc driver, once
in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
and is unnecessary, since the parsed information can be saved to skb->cb
so that enetc_map_tx_buffs() can get the previously parsed data from
skb->cb. Therefore, we add struct enetc_skb_cb as the format of the data
in the skb->cb buffer to save the parsed information of PTP packet.

In addition, the variables offset1 and offset2 in enetc_map_tx_buffs()
are renamed to corr_off and tstamp_off to make them easier to understand.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Add description of offset1 and offset2 being renamed in the commit
message.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..c1373163a096 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
-	u8 msgtype, twostep, udp;
 	union enetc_tx_bd *txbd;
-	u16 offset1, offset2;
 	int i, count = 0;
 	skb_frag_t *frag;
 	unsigned int f;
@@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
-		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
-				    &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep)
-			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
-		else
-			do_onestep_tstamp = true;
-	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
+		do_onestep_tstamp = true;
+	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
 		do_twostep_tstamp = true;
-	}
 
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
@@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
+			u16 tstamp_off = enetc_cb->origin_tstamp_off;
+			u16 corr_off = enetc_cb->correction_off;
 			__be32 new_sec_l, new_nsec;
 			u32 lo, hi, nsec, val;
 			__be16 new_sec_h;
@@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			new_sec_h = htons((sec >> 32) & 0xffff);
 			new_sec_l = htonl(sec & 0xffffffff);
 			new_nsec = htonl(nsec);
-			if (udp) {
+			if (enetc_cb->udp) {
 				struct udphdr *uh = udp_hdr(skb);
 				__be32 old_sec_l, old_nsec;
 				__be16 old_sec_h;
 
-				old_sec_h = *(__be16 *)(data + offset2);
+				old_sec_h = *(__be16 *)(data + tstamp_off);
 				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
 							 new_sec_h, false);
 
-				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
 				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
 							 new_sec_l, false);
 
-				old_nsec = *(__be32 *)(data + offset2 + 6);
+				old_nsec = *(__be32 *)(data + tstamp_off + 6);
 				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
 							 new_nsec, false);
 			}
 
-			*(__be16 *)(data + offset2) = new_sec_h;
-			*(__be32 *)(data + offset2 + 2) = new_sec_l;
-			*(__be32 *)(data + offset2 + 6) = new_nsec;
+			*(__be16 *)(data + tstamp_off) = new_sec_h;
++			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
++			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
-			if (udp)
+			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+			if (enetc_cb->udp)
 				val |= ENETC_PM0_SINGLE_STEP_CH;
 
 			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
@@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
 	int count;
 
 	/* Queue one-step Sync packet if already locked */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
 					  &priv->flags)) {
 			skb_queue_tail(&priv->tx_skbs, skb);
@@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
-	/* Mark tx timestamp type on skb->cb[0] if requires */
+	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
-		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
-	} else {
-		skb->cb[0] = 0;
-	}
+	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
+		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
+	else
+		enetc_cb->flag = 0;
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
-			skb->cb[0] = ENETC_F_TX_TSTAMP;
+		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
+			enetc_cb->flag = ENETC_F_TX_TSTAMP;
+		} else {
+			enetc_cb->udp = !!udp;
+			enetc_cb->correction_off = offset1;
+			enetc_cb->origin_tstamp_off = offset2;
+		}
 	}
 
 	return enetc_start_xmit(skb, ndev);
@@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 		if (xdp_frame) {
 			xdp_return_frame(xdp_frame);
 		} else if (skb) {
-			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
+			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+
+			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
 				/* Start work to release lock for next one-step
 				 * timestamping packet. And send one skb in
 				 * tx_skbs queue if has.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04..ce3fed95091b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -54,6 +54,15 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_skb_cb {
+	u8 flag;
+	bool udp;
+	u16 correction_off;
+	u16 origin_tstamp_off;
+};
+
+#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
+
 struct enetc_lso_t {
 	bool	ipv6;
 	bool	tcp;
-- 
2.34.1


