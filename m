Return-Path: <netdev+bounces-216375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A9B33552
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C0320281A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAC72874F3;
	Mon, 25 Aug 2025 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/8hOEBi"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23F2874E4;
	Mon, 25 Aug 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096652; cv=fail; b=oTh4a6kUv5wYDDr3uRuudulgSvHC7IyxYbfNsXnjYzsxZ1QZuofBKB68fSYMfqlPwCC/9pl5MtDvC3Oyv0BImasEY0kbH/5HxnZKvpXv+GtkeuMFqFrNj/wKHmeiTGcmeT+h7AmNgrGRU+uqk+lTSP2rzFE6NZsufAUuK4RuFx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096652; c=relaxed/simple;
	bh=CkKuUQo77/6Bsid9gISKPCco9ZCqu6JAyUVn/1OeQVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0ZqjfWKh8ES9JKamdN03SfNkfxxMw5ZgMLPOc62IbULmGDCJzHYJebAr7Sl/F2p/epifLo8efz0HH8ggYZyP7+jQBOHjDbL/sJJF7ag+R+9qq7xApg9tmljJAB87nxyXhTwOnCHZSFWk6DcBBXYA7HZhDHCPoMvebxMgFrrae0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V/8hOEBi; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3z3KbMrox7pvitWAE6AsJoD5bJLFIyW5gzdeaxUVYNECxmeIlZKA+pn/Cfrzkzuj3ezo9xRLcBN9IoclxfoUCAcmIE/17ffCg57HFf4vfWXJEhRf+PI8iKAqg9xSKndWGNbPThw9sU9tKi3kKm/Qs3Vnb5j3iRgEcIDa57FnEZLbDeF6AOzmySrrFVWskXQT5+PlVzAzy9OWFaTonW5iwTdLcQznV/pwXjF4yT+ZF6UqLtyh2qywrxGoyFNYBvokDwJ9MFvbDx/LVAPYuqcPKpfoMPtnBiFOxddNlMLjiHgSpZ+xrEwI8QRAGXgThPSzgHhBi7KGqkrqgrHDPZ5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=BbTNVTMObR/Qm4WsgZCwQyBJcVKWk3dJfTdvbfgklWsV/4nERdzQ8RJ9FNWcPm1QsRDITpk/CD2hi3bSdTbHgK+3Ouajr33I0lx2bCpGz/cD2NokamRpMByehs0zXKn4EAP5uCSolVG0qG8oGFFvq312a/2bdNDq1q0bm70ftbVtKXUKEcki+a282sJCplMeeire6/NRsC2Yqxodb2TDhHbUksnH3BEJM3VfSnwQtu6yrj67I5V2Q7BXgdm1RoQ+4GSJjIiLrPdTShaEe9F99V4TNf56acC//tam8h/3nExvS8UKVfJ75v3tI/ToSO8fv6ztO5RukAeK9qBDsvqDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=V/8hOEBi+9pVvaFSaU41qD4FhC2J98chN61M69AuQ9hhaupRV6IIDVRi36VCaLGwB0lVoJ6es3ghI8wlYii9nX8svjrOSv5TYvu+eTN4/vOaxD7H5pm3+A1XMUT7Da7zi4WwI7G6VAmc5pqMOBlESsM7XOmbePntMNZWlrLvzIzflVH8PldHKGMIR9i/rEGbmZXnlU/YbZyj5+tqA14y8uPYwKXAXMqMaWdYM7OU7v0/od55IXqvVB5M5/rrjthbFslB1/5/0bQByscSsP+UW9WO9uGBk8QgHAnZaG06c6/o5WmX79h6DF/+9o5FLDwkkylznihFB2pDcbhTV71Cdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:27 +0000
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
Subject: [PATCH v5 net-next 10/15] net: enetc: save the parsed information of PTP packet to skb->cb
Date: Mon, 25 Aug 2025 12:15:27 +0800
Message-Id: <20250825041532.1067315-11-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b41f55-3d15-429a-8847-08dde3911875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJ+vwqAsm3JxAhFVzpqd/XiiKD1+kTuS6ylpLmiIdMv/9jyHyGllUmy2djrc?=
 =?us-ascii?Q?nfqUMkHJiYbexP7CYXFwsffiNWlYpQIEEhP3jr9OvoDOdzXjWry+UrV+WHtV?=
 =?us-ascii?Q?jkLU3ElW125/WE5MsH8/AbL4SPnTM1Bv8GiH6XDIfyoc8y50OmYDq0JAlO2H?=
 =?us-ascii?Q?tG5ZM/VafF+DBRZ0e1h8ATGRsJ1vJBSaljuoRhrsbitb34C8yQkiqACFr6EH?=
 =?us-ascii?Q?EZNsBE02WBiXJJ3vvMLtJhk9x/xrY5x4cTbRMhLDT8CN75sYNAOKJvOLvhFS?=
 =?us-ascii?Q?OvHDodASwctUaFyHmw45Vbgpi2DwnlAZVqp97NxFiT+HFHSz2Bc6eQ4hppDh?=
 =?us-ascii?Q?Gfp2l+IgCsajzss2guQg+/xW64eiM/lqHbFdVSPT5J0eP8Y91LxCC2klcmS5?=
 =?us-ascii?Q?bZeVFQ+2K/k4FMGqzL8NNsi54ZpRuwy3b/ZjTDf6ih1XA2IoxFcigKTSn36h?=
 =?us-ascii?Q?zVEnMkuSfdO5SfqiLf/QPFZAGPeMTKxLoy1NseIuR3UMbUqwqfrykThneLI3?=
 =?us-ascii?Q?DJVQcmgKGjouGlBnN0w5T3juMPeB5RK3fPLcYzUqd0TOtdisVSBRgzW+hZi4?=
 =?us-ascii?Q?W7yoQU2NfqLmIktCWKo4yrsZuZlQmAKjLsyeIM+mLXhfW6PIRUK4F6pYhsHO?=
 =?us-ascii?Q?N/S3cQxuIjnURSfAk/TVtZhxiYbKHRABdD9u9hiYCUSXZG9P4vIvjGSU9BwA?=
 =?us-ascii?Q?Xe4GF5AKQuRjf8zI8SW8xY1D9k0Uxzc3ZBu7ZZ5caMv80U0Tbev+wAyWOnjh?=
 =?us-ascii?Q?gmfmF9ogFAT4xa/kJhdPu3tLRhBIUjZgGfns8NLPzX12pWpLAfXjV+pTiWwW?=
 =?us-ascii?Q?3F1rfrDIpfyzmPtaVAzIdTP/9MLr/YwWC33VP41mltuknbRpIukKuC3fWc0P?=
 =?us-ascii?Q?dGMk8OY7Zxk7ASNe90jRuSTjvmYc1SlWxtUcu+NPdfNvjeJXG205F2L5mP84?=
 =?us-ascii?Q?dKsmZiNqZGHaJevqMuLQhfr3D3Wb5kY+cNOzYAsCR++Eq/LRFsqgPO3LsAuR?=
 =?us-ascii?Q?O+R6Nu6vSjSPIZvzgjNoIlZyvfLEAUcfFZj1LHqkc+W8yyNeDMI0uKBSt7Tu?=
 =?us-ascii?Q?YRNe5Lj1MzaXh99pGqNDlaYcK9qY8p0MWCPWr8to4xaT6PCdfKze0mCDfte7?=
 =?us-ascii?Q?/bzy/wk2iG6p5+88xEABwTH5d5p18pnQOzxEfCut1vO62yVkk/ZE9W+9qzxh?=
 =?us-ascii?Q?kIkRph7mdzmhLkG9SWeaBVYpyHdkwhm8ZxyvS8g3d56ztEdkoJk11yY2acCT?=
 =?us-ascii?Q?y1CmZ90t64GRJDyKi68KOPgYV5eNb3cMyCdobvgqdyWwbhVZ6GX4XPXyM+am?=
 =?us-ascii?Q?mnfUQvsnn+bT5zGBSItPUc/Pcnpir9m523wBXpeQn9pm4bMCWmbNAq5EidIL?=
 =?us-ascii?Q?9CKH5OjAn5MD9z94C8jKcK6L3YUT2k15qFGatK7A2/WPa+PaZbFGTUEQw6g6?=
 =?us-ascii?Q?DfXOYgm0Deq0qSo/urv33gXGPkuZvzZFuFJSr4F+/p8gbhUpv+g7zeFdUzJ2?=
 =?us-ascii?Q?tOUiLdFuZyTb2uQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQqoSr5V0BUcLWoaW3LB419NhR2qOEubYnY766We0PF77P3pkxiWwhPL79Rm?=
 =?us-ascii?Q?dGm1bWR0Pz+lNdxhai78P7wneLP7zzlU+GHy1UiTQqBw2r+WIgEVY6S07CWL?=
 =?us-ascii?Q?1lsma67oIoQ6dKywcXxJ0D75rtCnq38/X34+HZQmctxAczHl+T61oWW9oXoN?=
 =?us-ascii?Q?vBRyO0qVHoSAbz3RnMeKbbFL5kDD8EeA2TEUkcK+TBAcyL6oSXUOHz+1lNlC?=
 =?us-ascii?Q?RIqwQir7pW65MX4hT6a0N5P0lRhNDB1gLL9DLDI7xWe+pNw/ZTyhH5scn+Hg?=
 =?us-ascii?Q?mbJL5ZKZ2IXMf5Nwo3Fqmk3v7We7nko8TOYc2YdJHCcbvrc+9AK5Ch8ZzUcY?=
 =?us-ascii?Q?goVBg/bKihVZihkwjzp7zDTeAuocB4knZpqygNhcM4oaXzGqpQtefYxDxJaX?=
 =?us-ascii?Q?88zAxos7GNnlDTq+b+Vgh4e3HNl/n79W2lRDrAy5+qhYuszZAlYC0Dx07ScV?=
 =?us-ascii?Q?97WrVHMAnc7qP2J1lhYEUZcOqFKj+wuWKR9p4ZdZrA+4AP5Rzn8ARy2mmcKn?=
 =?us-ascii?Q?rBLC1NzxeCR5wsufLvmkpZEyDGNoMm8DAWLgtxAsT3fgq+/6LQKUt+PqIwjT?=
 =?us-ascii?Q?3SV45O1nWZ59Y74Yn1locmu7pDaJKSEv5+fFKRjyMQoz5V7H/odUQEiPjpwu?=
 =?us-ascii?Q?xaPQITI3dZkUq1D6o7JnW3urnFfWfjP3tClUh/+7W64Cakf7xl8Unz4pDaUj?=
 =?us-ascii?Q?Tq0Ix+YOiGUk2HMj/vSdKUN1W3JIQSiQUzqC34FKDJwinfeQSLe3MV8a6+ZN?=
 =?us-ascii?Q?WdTaniZQxTDogM3wKXrWZ/GtzNZLlMuxYhN80DgdOSBn4xURaOkzj1qQgvur?=
 =?us-ascii?Q?Thb+/lz+BrueaNuuA7tY5DW3fEdQ9mzVzbGYSJeeTIxd0g5RMX3ac/mNaa8t?=
 =?us-ascii?Q?GhWsbMxXn8BX+s4bXD3Itb+sr+Sb8dcxkmSlFHa3Rnhav8B2zUgcg0JCe/DC?=
 =?us-ascii?Q?7fVhEDEjQmxBcAYrvnvVPhzyjBENnBVcO/cD/iMFsiB62rbFcgXTlnA9H1NJ?=
 =?us-ascii?Q?p3hYStW+obB3oOqpKElUALDMFTbuGX1LoVbyBJWtnDnSBnEQ1uvIlffPnBxj?=
 =?us-ascii?Q?IrTo9pYpAv0fwxdCImqMVt3pcjI2oXhs6lPpldTRAzj0sFbiP6+J4ljNqWlM?=
 =?us-ascii?Q?WA30kxapKwlmxizao5RS0b1F7w/5xOMni33OkOntpA43i7/2QEorAe7SscIl?=
 =?us-ascii?Q?NAOrrSnOXr5NuvVT6ZMGf9Rri8448nAILNRRa7g1Xs9uNzau18KZzN9IN0a1?=
 =?us-ascii?Q?oV/cPi4X1dLx9UoO5gFj4ELHpjJ2UQ+HCw7fP9vpr3X0XSXUMpFrdQPGYX0v?=
 =?us-ascii?Q?k5YLyX4w/F5Cgg6Upbxkn5JTDAJ7W2NO/7qwRgeNm0e7GXO88IrSBzdfDtKL?=
 =?us-ascii?Q?IsE3X5o82MKqyS8JwYkwxO1R4Wxb1yD7bW4oIzP/b74BcsZfpTVgtSNcuClp?=
 =?us-ascii?Q?WT0OMogJLCmW26knqF+gXs6KMMFviMMXp8kuIZA7fb+WtW7ESNGyPTZFwLYr?=
 =?us-ascii?Q?w4tbqFMiWA7uCTtHSpKyq9IiYl80OgkOM9zxxwSqBjLNSmxNRJVYv4AmtzD0?=
 =?us-ascii?Q?zBoXuGvR4Qd+l6V860hzmItPrfWavZZwri9gCqHK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b41f55-3d15-429a-8847-08dde3911875
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:27.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VALaMrxlb7XMmsN53Q7SqcVf5QFtq5q4vI7fSj5zMM3agaxrwcP7pSOgOjqAldJg0Y70UzWllBlxt9GYWXKeNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

Currently, the Tx PTP packets are parsed twice in the enetc driver, once
in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
and is unnecessary, since the parsed information can be saved to skb->cb
so that enetc_map_tx_buffs() can get the previously parsed data from
skb->cb. Therefore, add struct enetc_skb_cb as the format of the data
in the skb->cb buffer to save the parsed information of PTP packet. Use
saved information in enetc_map_tx_buffs() to avoid parsing data again.

In addition, rename variables offset1 and offset2 in enetc_map_tx_buffs()
to corr_off and tstamp_off for better readability.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
1. Add description of offset1 and offset2 being renamed in the commit
message.
v3 changes:
1. Improve the commit message
2. Fix the error the patch, there were two "++" in the patch
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..54ccd7c57961 100644
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
+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
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


