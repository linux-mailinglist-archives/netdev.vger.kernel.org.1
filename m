Return-Path: <netdev+bounces-218121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1FEB3B28F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83EEC1C86988
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754125485F;
	Fri, 29 Aug 2025 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OJBlh/LK"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD0253B71;
	Fri, 29 Aug 2025 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445316; cv=fail; b=IlmlPabsLOG0f4/zynO6BOZbA7wiulVvqrEPsch9M37fXotVga1W3zDHrxm4NR9ivdSK4Bad83RvMJY+1MBRQ09Ips+y4gPUCVTmVhT0kheEPdbVbOYTQmXTnFU9qCFYZiucsTdoi0Qb16hlvW7X0c3BA7vCQdpR9yMcdfKgdDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445316; c=relaxed/simple;
	bh=XKim+Apovg3ClzFH9GZkEj197hgDaqrgI4nW5tEW1BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czyFNphFsAukSytVR8S5yWKUmpONGj9zpZg5RicWfXLuxdQE39AAK6cKFMwuh2y9/76cpL+CqZTMCLTR8hW6KSi0OaPoGg0xxNSLFZUXzcNaEwUhZipApoI03EuJT2fzNmStv0JLYnYHd1MxiTRCxHffUUqn2GFbf6UZPRfPXes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OJBlh/LK; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQtBR0nQVr21bV60ZIRv7teloPGjZA+YyQ9XVKmOTaZM+Unh6M8QeWrBKPvuC8w8gnt7NXA4DaDKKxDcXNorahUDFQJ8jOws14CcEEwYGEtqhhfG7y7MpBbjAi27iUA5N++voRQ3OcXrX3gx6hHuCanADppfK49wz44ncaJGxhoF8+6ru+bX6A8QHZGrHKD7gUyBeuCKUaw2k6gfi8PYpRseq6V0+moOPR+i+4S1a4i4PI85dPqtke6sJFf1ZlBs83KMhu68nkY4C6uGcIZyCNgz/S75LsCEUwWxJLySdzpJCx0nPXJZx/yCDe92IDnJYQH7QV1CDlRCIDCRYN9l2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=qelQDoo8/WbSv86/yOUFDLoK9QCt53wqKEl1/jTZmXo1F8enjBCgGfRTf/rfdIm6Af3oByZbaYOO58yOm5cFsVbNA1T1mOTTF4dJwXM9wBRZKXfkC/xBSmMV1EPovPDUp9DqNyVtUqzwVhGOqSiOHW6TMVSUN0fEj4rqxiM7ZElXEHZxyivjc47b7wLPh7/ArafeSKndR1a/8hoe1Mdx3j/Qw2Pd2cSClUpoHfDoNH1TruX2IiYEInwREOAKAc4Uil87tLpOYMC+3Fp2pNtq+1g5Ib2DeyK03JEAlOfGKozcOzL+5udBSk28LlU7Fayj471crUbUOYM6AJCguV71Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=OJBlh/LKrAA8O3n3c6AHBEjQxqaGV/mngwyW8/9krurHApbLTm150UN///QVrDJsNiuJb9fFJL0rOwE1p/iys9LJJOdI53P50zY9/1MBoAqAhoN7Bog5ZWcKD9LVhrA/rWy1LPGb1iA/d36jImlW1uURIvQONw1h4ka37tTr4/3/rsZl7V2xMsOQz2hQ4AG0IFgrcqMql3S81spSnbWu2QnuReNlK7QE3SkWEnCFyjQcvKxOXxqwlC163ROhPLg0ShDPJIJeMeSNM+sLd/AahUW67Lsw+O+01BRSIBsu/BztovxGU6IEmQcFFZs4pDBUTKeat4Vh0poTXG9EC+9RXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:28:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:28:32 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 14/14] net: enetc: don't update sync packet checksum if checksum offload is used
Date: Fri, 29 Aug 2025 13:06:15 +0800
Message-Id: <20250829050615.1247468-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: f31c42c3-3768-461e-768d-08dde6bce480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5tSp+2jfYJjZ5sizs259Wp9pRKksYmv9Ni+VCRFEDF1l9cpzvowM5pfLaFN?=
 =?us-ascii?Q?u9kBC7SEnvpF1X5moMnUE8cNjqlKlBN2LyPSkKLkh+tB0wIhDynoN7zJyUzo?=
 =?us-ascii?Q?VSSqZheH52r0M4y2UibwaeLyRm9bhejdJrmKg4QIucWjJ3cbv9lty20sZ9G1?=
 =?us-ascii?Q?wICyrWS0xGbDpFODjH82zsrFzd/xZwkeYklqRBaMv9OpNDUsON/fJiGvUWdf?=
 =?us-ascii?Q?IznF1zbvsuv6PcMdzR6gW+sO00zXnoudanYRMO8ruHhQBpHcpSBgF3qEuhgG?=
 =?us-ascii?Q?z5IwPUNhvSgisccbscBiguRudEvwCbglIiaMdD818wFU2JSBulExa2HV0YaD?=
 =?us-ascii?Q?ISMXlENSAKQV4BNs98oJE3QSK4ff3kHy781jtPajAovp3atIpxGFauml7F6O?=
 =?us-ascii?Q?AXfBExk25+QePTQoNQOF7G1Z/E4Bq+HJJ1qcbtSgmfmWge3Wk2WzsB3rUSKu?=
 =?us-ascii?Q?NXYSS+BgOGSRw2+RFhx8lY185JzlGFUR5uXPf81JsqPyT4jzNGnzKn6Ff1QJ?=
 =?us-ascii?Q?lXLkFg7FErBtd/TpyAv6mKtyrHYTFRienPdH+De2Sgby81AygVO1b4I9WJD1?=
 =?us-ascii?Q?8NTC6VbfHHttic9albvOSOXaxbiT/Trw/StcWwl/iqig5SXpUOCxtqEKXyo/?=
 =?us-ascii?Q?wylVpZXFRsRa+3B7jglBWtOKANQ6gR01RNQhSqX+zZ5YkAiaRXvIBN2ntm8i?=
 =?us-ascii?Q?X3pKI08U7+VEh/ZKrkzD6OqrSMXaJflc7vbWlGToMdPm4tC2e0eXW5PCGpHF?=
 =?us-ascii?Q?mviWaYquY6j/yJNoQgYAAqlh802q1orp/C/v9Fhvt+xBy1pVdZcmi/zaomMT?=
 =?us-ascii?Q?U1dzyQ6ZuMN1TjyM/4y0/QIBgaXAtIzxyIG+8ZA4yljRoJWWhFQop2EOz8BJ?=
 =?us-ascii?Q?7MZlFSCqxBXjmJxjRQoh/PeM4auCT+gw7x4i5g9wy9kdVyU2svgbFPyLa0tY?=
 =?us-ascii?Q?M6bYbIXCilbEi7qNtBCN9T2EhkTQtzJjv/XvF3x3zzW7c9JuZYYdTuQQXmWB?=
 =?us-ascii?Q?s411giBushkTvAVXSpSkQTsqil5qJ+T0hmXjC6Q0HPySsap0OfSyq5ujjN/J?=
 =?us-ascii?Q?cm8WhKJVHJmXEJYtvOe/74AqpFbje73sg53UyaiUFTxOyiQ4mKcAycd2n1GI?=
 =?us-ascii?Q?XySJqnuu1X5JsESFwnOWXsv6FWktKfsk6I7npBsXne9eGahMAxU8dZ7QZJ1c?=
 =?us-ascii?Q?DzJZxwcXrIsaKav4MavhNOSk1KKigGuNFp5V2yZ5zGUDKHujXgFG43ryp2Tr?=
 =?us-ascii?Q?OTT8jJkLlJo7KKlmvI1ip6rzCUPhkqdqGMxeo1PJ1z9ceGr5ezNMksFK9iTX?=
 =?us-ascii?Q?9y507CjUQ+W8673tna8GpRhveHui+rewH3IgdiKtv/KVY3hsnDLDOYLBZ74L?=
 =?us-ascii?Q?WVXggzxODSr6PKn6w5Tl86fcLa7bZQA47HLC01qtweYYBTamMBkUhAokU4TN?=
 =?us-ascii?Q?fWKi6lCcEq5OBDOzq8P8kkX7QpGNRZWaKekZy1kdRZ7GZjyt6XSwSwGV+6zG?=
 =?us-ascii?Q?AIqa4RO9sxKbFfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+VuwXEFLvZbOwuxCepJgTwytGaK+brLxH7mVtZbgLCy/KQ6xRESSB941RyWb?=
 =?us-ascii?Q?hJHt46f23i7WwikS3gIYVshWACHFPUP8rYmj+6q9CcJ8lFfZ3tiYXHPceWSb?=
 =?us-ascii?Q?+N7c6IRdy/C7WXa1WPmfDPUsK4oCIzjNw34SAkogeIUVl3XNmMuzZn+LboA7?=
 =?us-ascii?Q?1GCQ22Luj3TjBwTiTpIrUp9eN/SCHeUMd1ltwIUd8Wz+/WlAPUEEaAeYFxVF?=
 =?us-ascii?Q?AjSsp8keP65wUMXP3tNeSzk09d2soTYrCmwRJmBKMfHkUvWjfSnMq3T7tc5p?=
 =?us-ascii?Q?SEbnax8yMb3YTN+F2BSw3uJUObgrY+5vWGneyZZfCvE6Yj/JvfDA9cOwubbj?=
 =?us-ascii?Q?jRKHKaroFFcV3jZOdMaFSYGHlbngL6YZaFpQunECWkNSDyAqeybf5EQuYIHi?=
 =?us-ascii?Q?n4BHle2Dmuufe2M69XGF1JHwlXbXR1hPHsTKYpC7r/h9Z0vsCQBFxo9VoP5v?=
 =?us-ascii?Q?ftGwi3rZIE9AlTkxahzcd5uzaPwWBifq5vH4JLT0I1ju46vkp3brwAYpMqoJ?=
 =?us-ascii?Q?O0BPfiJOOIf2sqgpzacb25Y5lUZJP4hpEO+s7IB1h1tiZUyxi/gCWDIVn09P?=
 =?us-ascii?Q?P4P6Lp7cwa4JCkq7G409Gf3hJnrWgaL0lSrGNXMWWjfsed11hU/x2L4ZwqoY?=
 =?us-ascii?Q?iF4jidlgp7PWhr27VQb/KZoi3ezq9aOTMTnS5bTqRdsiWyhe+FZ4NagalXok?=
 =?us-ascii?Q?dXdyIlx9yjtyHycH6g2GZ1eHmDZspYQGQjyymeGAbf2ui/GC4DogXpo5kHSG?=
 =?us-ascii?Q?EFzKk3hI1JtUVW19WtKNLqwdxe4lvtmeVw6v72FfiMvvcjzQD+fLSxsjLh4G?=
 =?us-ascii?Q?54FsdUodGGwiKqkhrPU/srtmZCwfQiwzH6NQPli9dkvVN6LJDHawNaGKJieO?=
 =?us-ascii?Q?mEj+xHF2qUUatNVBRLOpadQqeNLdMPNoezrN7BoP33iqF70faGDGPYhn8/Nv?=
 =?us-ascii?Q?emFFZzUI+S1lw0kj0wy3XuimrrGMoHKL2/nw1Go1WJMlnfC+9/Sv+aNvg/IL?=
 =?us-ascii?Q?4lhLXhy8OwcIUk6l5Y3na6MDGsLX4AiApK8/yJu/Sj5i+EiZ50pyuMxficrx?=
 =?us-ascii?Q?SgL0hZa4CKsjy+1kv+DxBV75/57/QoeVLNwnPw7SXHY84YAwYdmzUSevK1d7?=
 =?us-ascii?Q?fL4n/R6YK59YedrvrSLHDIPxxD2SvWE19EgKmC+/BkLfpFhKQ77JTxL6ebR/?=
 =?us-ascii?Q?3ap9y63XId4jGspm1lpPtD3mC4BqgP0WASqHvGPKkVauqp3q/8q2Uz4MBhZ6?=
 =?us-ascii?Q?YKwWqJm1wzdWHoddq89IZIRagmmiEJJ1lMhhNzPljWKSd0w7grfXNNdtXa3O?=
 =?us-ascii?Q?I0hWn6EXq8zkKABDwvYpt0iYIcQBFEBU3SWIPaKGxtFAddUZUh0/3nUkhYDO?=
 =?us-ascii?Q?TDKPIrO3ETnd5+j0SM5cdmeWGkvB993Ja6m0SIGgcYSk7otWGVMb+AHtmRPY?=
 =?us-ascii?Q?zzbWCMTxqV7PAROhhGQ8v1JKy+F/JSQmfoZNU0ZM/uGYoGqMvIf9D+q7pIoc?=
 =?us-ascii?Q?LtJL7qKhD/t2ISPxbFg2cabuTRiDDG/w9fP5PnhKqZ+glKsA9Ev1zw6+f5jO?=
 =?us-ascii?Q?x/tTt4nW53rfM+Ar4IVl44ebCn8cvMe2hFUHbAuw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c42c3-3768-461e-768d-08dde6bce480
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:28:32.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8X7EWNn7Bkk2ymMY2JXW+P5vuS+lIOwLaooUGJb0jerbKb0eb+vKsOspNFxwXZ1nsV0R8d0uEo4KRIvgoDurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

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


