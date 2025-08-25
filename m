Return-Path: <netdev+bounces-216379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCFEB33555
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791A71B2334C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA32288C2B;
	Mon, 25 Aug 2025 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lmJIrQhJ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605D27FD5A;
	Mon, 25 Aug 2025 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096681; cv=fail; b=eIxNFoedezaZ4gk2uJP2OL4ns4n5C1OTuj96fwmHZ9e4iV03vVvFUBV8jxR7ThVNZ6+eLDXdVpfftNnfdiXiQUu7nFcA4kts53HUYxzfIxirRqeCiKo6DNS3LEGoc8DD8yXmeZpoIkEe4P9glDSJhozfpcNBJsDtEU8urQuQTvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096681; c=relaxed/simple;
	bh=XKim+Apovg3ClzFH9GZkEj197hgDaqrgI4nW5tEW1BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQQ8bJ1dt9bAfTQaVVrpxwCLx9pYGdmX2Ad3WnDxdc1JRfmkv2NGtGd7TFB2viHBbjE/hIAyq/Cr1LXp2QcikqxNYKQ+mUA2dv7UjYAgkqjxPaTUFyiZvW5V59f2xeCMSnkiDQ/lG0VUOlLUzNgXofa7UwPboQSe9unQlUSehcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lmJIrQhJ; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTYZ49GSHkEpG75DXfFilL7wKyQLDm2r5JMrvgSJjNFi2G/vQwvZ6IKFtTA2Qz8ODmred0a3PdQgyIlSt2UPTvy9Ty0zWMplyb5PBTH4a3HvFpHhwKqODOUYVLOsc9Dl+UqeAFW8FGBA+CofLziWYNaT7U/tiyTe/gub79WDU/pptDCIsiMbrKLe8SRSbqB38wZ8OVZbtMVdoDDmeAoUtCAzVWIy0wm2FhHgQ0/iF60AQbzmRY6Yx6zcyO/H3l8/8bZ1vhcX9Umxie0zhAEI6vuUuU6LNwwuNTfUbKioxhyJaO3ap2FLAkI6QXgtoDXmrelR8qz+C0KbvC7pwLVp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=ST9ILaNNK3nQf3ykWg391v2qjttex0lINGEK2W2IQTiz9WKbkMktpCUyyTqVWkm6hNF230hbZZ9g8ynfPfiGK91O3qtl9gXhVu39oRgm2jF4QbBZwPGjBQ4NNWpH+4d7Yqu+2ZCF/WCSdMo03++WIsNZxjHqfR6Uf8PUfhoxqE1+urabpuwnIYnuojddVB7li6k0gh3BNXzSsoNT4zfBXCkAPvcSoeLZjWhzU5kdd+bhRruzXcpnztKgRmqa1oy4898qaOrtv1m5wVe65Uzaa4kYUoEYGDUhLgJA7YHfpp70JgSCHjyEcIvxwXP/Nn9+11jZe/OVyAhmkqC1JCy2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=lmJIrQhJZz1Xan7CBeeKhMZk/NezAtK4wSbulyCN86YG7v7+4XN/E6uaO3WRtymBTEWgTLVqP9kaO4XGjy9sEHW70X3BH/QtXyeNM4eEBlzeJ/rOjjoqGsz5IkK2E6KYrBMSrgT9Q5Bvc75zQm+yE3FulOToCDQnavKzwRyGGUdxRY+CPFyU6NEWnjBgrbNWJm0TMy/4LdNipksWNBpb3WoZnU8Crd1vm2lhO6iaXx+9a7jFAx92yIPBJIW8eyBgvwaQfvEmMtEjG9R1Px8S1qSLIXjUgTKRHYZjqk1G7QnlctWkXyL9fuR+emT9cAiMpduUqZ84UK/fOwJPBz5QNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10570.eurprd04.prod.outlook.com (2603:10a6:800:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 04:37:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:54 +0000
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
Subject: [PATCH v5 net-next 14/15] net: enetc: don't update sync packet checksum if checksum offload is used
Date: Mon, 25 Aug 2025 12:15:31 +0800
Message-Id: <20250825041532.1067315-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10570:EE_
X-MS-Office365-Filtering-Correlation-Id: da26b3b8-5384-4402-8da6-08dde391286c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R/F4FMYst03+hFjUyrbN+7+bdZVPzryA5pbDSA4tglZ+MwWG3r+M4vLlB7kB?=
 =?us-ascii?Q?3skPGFshZ09oRQO2+HF7cLk31jCnBYQ3uM8GiAEK7I2uhr2y0i6Q0/pOUhoO?=
 =?us-ascii?Q?BGAFL9hpmQHNUtT1DDSIDJUUoxR9JUyqYwhRGrHUOFyYpN2W50AOfNPDzofE?=
 =?us-ascii?Q?g+Wy/EaCqXg/nqBEf2qEGu4hzeSu+EzEW0ZFe6qF+hdaiVzHBIsMCpv5FIMy?=
 =?us-ascii?Q?waIRXQdocuWhhP0GBJwUs+4760Z7WQj8JWBS5cgOeKQUsvHoYytM+u3jnmgd?=
 =?us-ascii?Q?GdLtwWpDmvDMJdaUcMS6KwtUTdpxBpHfuHrESMWSrlgCLSh8NF6vGClWFuSI?=
 =?us-ascii?Q?sO0KssYkxy8dbccePQOyJEJc1uSFPoMWdzJttD2oa39Hy8pvsH/6cwJZJY97?=
 =?us-ascii?Q?uZGTXnFlWU/y9YeoAIgHdH9kfmnP1pXKzGkDbjucpr2CpsJbDN7sQ21SZJdI?=
 =?us-ascii?Q?WMifb9tOLK1IbuqC7f2qroOinrzWj4cUPnvBJi3D8lHN3es8ac8u+Ib6PNbL?=
 =?us-ascii?Q?8JRLOS3iWWcgLRAAfrby8iG6lzKZJ+I112+AS7oMH1QH0dkoN4Dji7n+G0Om?=
 =?us-ascii?Q?gummw98HAX67hI1h15JoVCeqeHa8wegWYi7O4zNOVsD9iCFuH+USDZcrg2+t?=
 =?us-ascii?Q?zDcx4UAe9gi4JGYAIlFBNqdFk03BHJ2w4z4AVIjpvqkhYCNUbctYTzcNJt9x?=
 =?us-ascii?Q?BVLey7Tf+ad2OckE7W/GJ/ePjlvyCYp1hA8bruwHEd2vJm7XAW/U+Fo393Ah?=
 =?us-ascii?Q?WeZ42RnVP1rSdWdxPaCmDEP0+m7DvRCTios0JoMzVtTBHs+QJ9ymSSRcze9D?=
 =?us-ascii?Q?+vu18+8Q3+lrblCLMOZnQcT3ZwO5DfC2qMTZVv2PZBvdLWPvo8/NnP0QvOsL?=
 =?us-ascii?Q?sQN8wQK2gz6VFhYuMvKT0xvXzsBxfbsz9ADmI09oZsJUPK0Ms7wNGvVxpx8o?=
 =?us-ascii?Q?flJ4w77TAUefRlvZ2BinwDU3sTO1Ic5/vuh+HW1Bc/2wUSWE3BtL5YdgJRc8?=
 =?us-ascii?Q?wRwCLaKmDflztxbfnzsQmHIpkpT4osstsTzz4hUXikocZpl7jtM02l3gwipW?=
 =?us-ascii?Q?/YLO/fgUyJQeU10ZeSU71K0Dy/3D+C6v9osV56GkqoWqiAhyBlTJR19H2jXI?=
 =?us-ascii?Q?ZTqx9dLdS5yEY9GyXn9104065AHBlB5FpOti8XZrsvhh7CqUOgXPkqQ/m8v1?=
 =?us-ascii?Q?JBUmSolzcnOYldo/Tt2GjEOXUs/A5xHcTlWH1VZIanJHyFZwAgRtKBadf+dX?=
 =?us-ascii?Q?roM1DpL9lf7+kXk1idjPsryPq1PpgS88HMCYoIqmfA5r+VJwVlpooFfVMGtF?=
 =?us-ascii?Q?ZVhCRRdDyUqhxaYrp6u/dp+lXxelt8rrcgkOLzw7wrcEb033gusxZqSv3h4J?=
 =?us-ascii?Q?eUpHdgB19hif1xapHB2T07C4hbSSqfSixFmyHfVgQL/Fxl8QGsIcgbx8Okit?=
 =?us-ascii?Q?aQ9Rycw5Hvs8jPDXdLpy9NmE/4Rttd8bRiggLroktSVnTU2MosuCqI7pBWWC?=
 =?us-ascii?Q?0lPfRFt3U/zmS7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rp0Uh+sTedIkxd9e6b0Dup8FRjJgzBdg17xKpPTCQkiyjwK6tE8fXDdr/CT9?=
 =?us-ascii?Q?iYzTtFOjF/wbvi6i9K/iIAce6yvKFL9V5vnceqTddeWt4FR9KfN1qQulxj/g?=
 =?us-ascii?Q?z4GhjT69NSgvZAECF0hB0UIvMA2/lGiQWwm1spVvbqcTa35oczAENNMzIc+K?=
 =?us-ascii?Q?f9x0iL4gcvGWioNvxJDf5ZNHgwAJMTVncjQ2jZb2Pu0lbXoAKnoBOHkDL7Yu?=
 =?us-ascii?Q?rQLNtwveJlitwQsDvaPEeV1HF45pFEWusLhsG82yFTC6w83/7q67xoXkI3MH?=
 =?us-ascii?Q?6kW7yQvBaiSHsCOgf/a93u5ccxTBxCNP1Q0Ph9Dx5J988EGqcseUn69EJ0CU?=
 =?us-ascii?Q?yyww5YEJMSDFx2AAHIwjTdRXV3ONKL4KNpoSiNzuZGmvKX7quRpq2XtIIC3K?=
 =?us-ascii?Q?MApJ0izzJx9w+uY7sRFjrKmjol0T/Z5WkW8A/Z4/gG/YktxnO9/z9ki6MrPD?=
 =?us-ascii?Q?kYnE4uXCq0DhhBB4aAqq4xVwbgPED6v1DDQH2Y7d69z79dquiJ/vmmC8Ok2q?=
 =?us-ascii?Q?8Q/XQjnOws04GxGSoVoILPLjn93R6HbclP8bObhd3WDylM4SRPYfeY3aPLLL?=
 =?us-ascii?Q?11oAg2vkhiJIApA/8ddA/yfEucuqUjt7+IfJ2S88ZcQDadQN/UwAJPu+t56o?=
 =?us-ascii?Q?YZa76CteGDFKSw6lHF3uMmRvfogO/72Ct0D2/bMmVc0xGIfD4Zi5st2vCx/6?=
 =?us-ascii?Q?mSzNdvTgWdJwEksC3BGxeS5aLChGRF1GZTRAH0F7kmKlppI7/jSTaC0SZ5j9?=
 =?us-ascii?Q?1eAqvw+TTBhoJqZB6POL8FqmYxal2rjd2/Kpvxkp5jNcEN6PYJs25j8nfwuq?=
 =?us-ascii?Q?2umpcB5cfgM+rlFukc4inAq/bEvRvtKplMG1LsVmcS2eG3zbfsze7zXQAm17?=
 =?us-ascii?Q?8cv6xU2M/E4DAeWrJXNmG6aJ8A/G5N2iOMrYjYOYG4s/cV/kL7YEzoWjvWfG?=
 =?us-ascii?Q?WmhZdg5ROjSMpUt/prHjOKXnlPsEvSuaa9UP/2JyCo5pW8leUFTpnbZKOk8k?=
 =?us-ascii?Q?ufKaX0bQakYzGiCoFIt0qAz6318fboMUcZLKdCA31RZJSuJ2II4K71pOgz0K?=
 =?us-ascii?Q?s2OWp99Gpa/ZYMRRKykxymow+wu+P91D2qFck4Agyv7UCUDAJW+r3n/2s2cA?=
 =?us-ascii?Q?vFnCSlTvN+VhsIf8VFfrehNMboos50Hobvmx5yZ9eZE+Q1YL13JEDnZtR36+?=
 =?us-ascii?Q?dowvPYhD29x9fbmjROTnUZ4RfaZwVFaGrJHz9tdhDLzLBk+x2pZ6Nvl1vcaD?=
 =?us-ascii?Q?ZMO0Xid9JJX8Ly2ijrYQLwgCuoGxdHNK2vqOVRrf1wuitGexeEIZgBtyBmPu?=
 =?us-ascii?Q?OgUuEN+hk3j9HSBdqkoAg5uWC8Oq39lkzORZ6DmQkfXTdziucItzSAyQpJpl?=
 =?us-ascii?Q?GXeQvxQJvOE3JFSvbro3ec57ifveNnVdwzIXf3CR6+YpnKnQZ7A1WvNxSJyU?=
 =?us-ascii?Q?gd2IeG7tv8h0Kx/3oaBTWxTG4lrclRKWFMHpV2TxxMfcDuPLVZJ8oxnl2j1x?=
 =?us-ascii?Q?wrLHGnvYAdHMZ3HeXZDNbqbhQh7+yiiVkJvOhDbZ8qFsqnbcXJmdMJzDx8Oq?=
 =?us-ascii?Q?W/Hqk9wYJRnPcWvLr6/nZx4LPVP5V2oZM3N96Ho8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da26b3b8-5384-4402-8da6-08dde391286c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:54.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TC4WVbwULjPzfRXbQfpBBV119pOEam8hmE2byS7DCJs+BcOsfFN3Q1mKVpGF9Pgq6uf34dfD/UU29F0U1Ngbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10570

For ENETC v4, the hardware has the capability to support Tx checksum
offload. so the enetc driver does not need to update the UDP checksum
of PTP sync packets if Tx checksum offload is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v3: no changes, just collect Reviewed-by tag
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6dbc9cc811a0..aae462a0cf5a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -247,7 +247,7 @@ static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
 }
 
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, bool csum_offload)
 {
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	u16 tstamp_off = enetc_cb->origin_tstamp_off;
@@ -269,18 +269,17 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	 * - 48 bits seconds field
 	 * - 32 bits nanseconds field
 	 *
-	 * In addition, the UDP checksum needs to be updated
-	 * by software after updating originTimestamp field,
-	 * otherwise the hardware will calculate the wrong
-	 * checksum when updating the correction field and
-	 * update it to the packet.
+	 * In addition, if csum_offload is false, the UDP checksum needs
+	 * to be updated by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong checksum when
+	 * updating the correction field and update it to the packet.
 	 */
 
 	data = skb_mac_header(skb);
 	new_sec_h = htons((sec >> 32) & 0xffff);
 	new_sec_l = htonl(sec & 0xffffffff);
 	new_nsec = htonl(nsec);
-	if (enetc_cb->udp) {
+	if (enetc_cb->udp && !csum_offload) {
 		struct udphdr *uh = udp_hdr(skb);
 		__be32 old_sec_l, old_nsec;
 		__be16 old_sec_h;
@@ -319,6 +318,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
+	bool csum_offload = false;
 	union enetc_tx_bd *txbd;
 	int i, count = 0;
 	skb_frag_t *frag;
@@ -345,6 +345,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
 							    ENETC_TXBD_L4T_UDP);
 			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+			csum_offload = true;
 		} else if (skb_checksum_help(skb)) {
 			return 0;
 		}
@@ -352,7 +353,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		do_onestep_tstamp = true;
-		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
 	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
 		do_twostep_tstamp = true;
 	}
-- 
2.34.1


