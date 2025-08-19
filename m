Return-Path: <netdev+bounces-214958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BAB2C49A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0DF17CAC1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8257343D9E;
	Tue, 19 Aug 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GP1PHEZE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A288343210;
	Tue, 19 Aug 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608369; cv=fail; b=arbSIM9UlxQA/lsjQZj2JHYSbKFF1PB6vlR+DoQjb8FAKy74dzrrG4Zpm6leuyOMO+QoFe+Y6reSS+5vak3hx/kDwc7OINGU/hWTy9zzp0UFdzQCX5qqtz9ANAsZmgvumM68m7tCzuY1zyB6kmJybaQYgIMg3rahZ6zCn5Q9A7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608369; c=relaxed/simple;
	bh=EoN3b6HZ+iH+/Dw5nAfktERm+MDF4+wAYriFn6pBluw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3WxM0vPphaYXzD8Y3qSQ0XO4hsOOiyIOI1NfagFdkbNfSTA5nCi96V4NZaz4MBgkvyWuOTsd4ecSyHxEzIAwO967kcGLqpq7AW37MAZbNly4PR5rkDmq7kbqCXlbdgeqdXV48v3W8kIg1Zl6bFlE87pWLLx2kO4maYexkD3wFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GP1PHEZE; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kd+y+LdZ+xAp6dZHpnkDDu/M48JtnyngPSZS+ptKYxtA5gVXst0J+fhd8uGqFlkO6kgIfpz6Qpg7rid/qf0gHoKd1lH/eAeviv+RauVe/NBfTJhDcRYjW+lzh0mq3JsqHslu+De+vo6Pxp9Jk5iVlPJy0ymA31fs8HMRiHx4d5E9xCVOAE/U5JjRDwxEBrbJBx9MbSRbpFLFXXVLQfukO1P/xf+cale6EbeVxewy/FkgH9P57o0+Wdk01IT7HeIq8X1Hxd+VwYpKF1GLTHMkurIL98RUAhmeEaal/0zuRmPtrgSQifJp8blIzGEAW4e71eph4csJ3cgZaqFx7WWNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxMBCeztjAt7E/wdzRBvs9A9eNgRNA+xrjRa3nkEHlo=;
 b=EK6WFC0JVRHl63GuAI0RHt+uvEAX9Qzsk5kATf9DapKrC6KOnNLNOpp/hJ4s5wm6/vMhufa6g2VsodeigE9E4qbbIlsO6wnw0c5N6gykUbFuwXzUafhHNbsBwufgxutA4f7nfnw/wN0XNCsFhLtOuoRmqDtExgL27guBH645IoHRO1v3NN6wHH2hhKB+/D8dkIzR6kCviMVQvHqri/CeUn9Q0xYI6MqbKFwshwHO1vYoLBqmU+CBROXK5Z4jDOS0MwzoDKE730scZMg6E/r9vigvs+D40sdBBty/SKSJ5BJa1SWjPf0MyGr7+b311S/pQVzcuNrHmrFw1azrFvgL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxMBCeztjAt7E/wdzRBvs9A9eNgRNA+xrjRa3nkEHlo=;
 b=GP1PHEZEpNZdSxPP/3uQavhTO8Yby1HugNY3TM73i1oPYsJuRbOIXFL5S2trV70jYoMvdHQF5vYUEhFlAgbk3NvaZOE0P0SvWu/KPlDDpfLAQ0zJcNRtBqVWBEXAyw2gqBPtKbROhHc5kwgFmaLpTCRacSNAvIjgAH1hZ78uctav6UiYqdcloBcwIXszOCkLrLL2MiCQJDMmtsMQt3BeGz5hVMxRv5gNUfRl2+2pqZduZhcQgGMu0LvrvmXMODvTC8mHK1rstU+UGe5IYr0aAnqNGj7sGL+0GeEa/L4Fl3T787aFnlVgkJ33xbLm8WOlp6LfdK+DzuaOiDHJmUXl/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:59:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:03 +0000
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
Subject: [PATCH v4 net-next 07/15] ptp: netc: add external trigger stamp support
Date: Tue, 19 Aug 2025 20:36:12 +0800
Message-Id: <20250819123620.916637-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ca9274-79b3-467a-aedf-08dddf202bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?62Svu9rr7ncVyTuuRGBt4jeoi/kBbjU+k1vkOmrZZ4uvpB63FL+Ns9wEOrgG?=
 =?us-ascii?Q?ieUyZrz7RWlxZNYJYbW6+JkaEH3JYMLLtJHBGgU8M7LpQRX5YfqfCgrb5sAA?=
 =?us-ascii?Q?pDurExq4THGX3nEqGxL440/uJdVVElwfXLRjvOyls/80T+OqUcWl/vNjVk0B?=
 =?us-ascii?Q?lL2BHKclMCazTEqs+ohW2pOEPjyTDpeZkm8iY9MILsgIUrhSEQPctzVSMmBP?=
 =?us-ascii?Q?9q6vRHejFoaxnuDTxmRSlTRHVEecrEe1ylbGzwCqjlFApDqH0mMuYwKpVpRG?=
 =?us-ascii?Q?c7Ist/U3dR3+PZMVDigQw7oRMbPqxRELIYrxQ8+I1v3tBcQrJuybo4vl1OQY?=
 =?us-ascii?Q?dOUM2OCfINjAPB2pEksiJzI/RfoD01qO9Chz3RHeDu652GLkof22t/2+SdT2?=
 =?us-ascii?Q?gdoA5LsODWrkj0WWxgmoOpkDUxN480wOnVKbg24uFe7SP5ZT3TxVNPPeLOU1?=
 =?us-ascii?Q?WPQyBFTvKjcch3/+8tgSErj/dmFM2czIYkVlrAEtSrTKFX1eWkN0RXnhiSwa?=
 =?us-ascii?Q?/rhNifexS1SGMGyER6YjucMsmyqRGO14mx++eTDp4c3UdxhtVsvAfnkr6gsZ?=
 =?us-ascii?Q?cqaYeWZUxxE0EjN8woBc4Y274/G0DphD+Xb7JaWmPPm/M4yg/cm4x6LPLdzj?=
 =?us-ascii?Q?mLZUKrU/iHi33IRJHH2QROQu0ZAxOgAFeFkoQWzYBCqNneWeS4OTHOZiK2ls?=
 =?us-ascii?Q?r0gRg1DRsLHPRkNMMlA6FIei0PCx/9j5Ney0zpA5KlwwxYTAKT8kMIiAJFd0?=
 =?us-ascii?Q?+zLiXHpA0MFKUq8hHsZYFNlysrYjnqzOoWKVxkyVpF4DUjyWqXg/dhUSCtv9?=
 =?us-ascii?Q?G5xb9WjC/4CR0Qhx97kP9w/sPCn9oY/CZ6/TLA6sC841x8jdkmVjho+3I2Zr?=
 =?us-ascii?Q?Ha/LozD5yicjA4OiugcHFpAlXMcWkYmjNTCLDQWltOI8mGeDTLDjBSxSSwnv?=
 =?us-ascii?Q?JqA9xRaWyCTIu4b8e91odp9eAjxOY2XSNTdtAVvsxpdSWnWvIOnRxwYEXPXM?=
 =?us-ascii?Q?GzaLi/tPkj67vYu8qtHZzU/tW7Bf2Qkx+RQy9SI5rTiGw/2kiGAOqbdVZYk7?=
 =?us-ascii?Q?PejktjT2y2xo5aiHk+ufGHyP8i8jqSw8B6jIYjloQJtELNxrADvZY3deHDEP?=
 =?us-ascii?Q?FEJ5YQ52QGcG3coIGTJhUr9uUHF+48QbRY2EueRi8SmPwmyslP+zrnJxtf6A?=
 =?us-ascii?Q?LAEP42qX667sKImZ9jlB9EgX7aaUcMfafTTkfPcuzWfy3riViCFNNwq9FBBd?=
 =?us-ascii?Q?534M7Fp8xb2JgvIBapgacuS+h5SBbBzqrMw/JLqpQCx6Y/RsMxEklHTY1ZmQ?=
 =?us-ascii?Q?Ic843Gfha8VbE2thwF8H5u1jr9zVe/tRw9TYmwQwhQWLNP39hu6f5SwG2zd3?=
 =?us-ascii?Q?MN4TDPPAHMbQwlgv6KGln5YMZQj4oiqmdi7Lz5RZ24nmaSrTOpy9oqf9ioT7?=
 =?us-ascii?Q?2Hnxlf0pCa63hIFZeSLowesYK3Oi9FqMxn9xmFak0ld4SbTfNpoUSd6WhEPh?=
 =?us-ascii?Q?YsNPpxOwzPPz21Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QgkiXjWOMEpabQ4uwRL0cJFd67i1pk448PF4g345xb54BO7M+lRcJlbIIwNC?=
 =?us-ascii?Q?Ar+xedK/Xtd+pYWb25cco8CgJIMqg4BQ877tF0oL9l5ZBlo6OzlC8F4uNoRo?=
 =?us-ascii?Q?e7RjHqYk4BOp8RRC6ZYq6PUdl7/RhXf+MSSnYsghPRoFd+qhvqBlA5B132nh?=
 =?us-ascii?Q?1+sJH3XVe76pwkLb6s+lVPZI7SK7UyCx52k/k+sOoyhfstuPPZMWKtV1qs0H?=
 =?us-ascii?Q?su/dQQ1Rbf4OlPx+t9tnaWrkYsiKuRyruiA73rh4JlEq2BGqM/5S3+GWzFZv?=
 =?us-ascii?Q?5zfD4FRwrP28PvxD0k88wd9IPKZ6shOyJ4hYE12KI3Y0FlgLuYP4gsPrNYtU?=
 =?us-ascii?Q?mRJB+Hlq54KCjDFbiETEV9kiz7fhgMVNrY71x2EcrIzzfueL2E7b8sd/IPJv?=
 =?us-ascii?Q?fJp/DGS744n0dgnWq9zas/SFQHJKIGMXwwXA9j9TC7bH/dmFPQUpBANdGjfL?=
 =?us-ascii?Q?EQe4opVTYtFU7yO0PqoZySZdgHwJDPdYL79YbdWsh41V0K4PhDkUd+gqKPxe?=
 =?us-ascii?Q?vndFUg6TFYnCLmu62ErwbiHUDmqY8aIRoR2CE7lJwWS0eOYdHiaXSlPO4cMD?=
 =?us-ascii?Q?8n8ALMXAGHKgkMW5HnJ4MlHahFvjsiXE2V2sYWEF3PMwHhakh9s7yLvitZmM?=
 =?us-ascii?Q?77gXuZ7xOmJr/Qg4egbRUXxLjv/SlnWhmZm5KpdCxQG6ZZVJj/MVCqgcDCWE?=
 =?us-ascii?Q?PuqQrpyMxhgy2Hp1DXIGU8VK8VGKe07lCzJ+2XpFTN9k7NqVKL/J804dj6GL?=
 =?us-ascii?Q?3YriXeaVL0QNcjt3UNUOQulZwmSJKofR8p58JFOG5z1huFiMyhBw2ha2pcdX?=
 =?us-ascii?Q?A4AI0WGa7mAymEbRnfVj7pyVO0kWJws4x3UdonAEC7NVLRDu/fQRBBHtaI0d?=
 =?us-ascii?Q?IOTm+UcNJZRFwn+GKVMZcf98hHugUQ5A58H9YnlRZk9S6m3zLEzV29beMIBL?=
 =?us-ascii?Q?JTknicAZdl1Xoh4VdtQTOmX9C8+a9wMDR2aGqb55gE5rXxEwN6WU7xvJZAbY?=
 =?us-ascii?Q?CeHVZjehTO6qtXjiG67O0C6Ie9Y8QRdb/0ZVTKwt1VPTz8IzxvdYMezTHp2L?=
 =?us-ascii?Q?S2j60TKezI0kHN3gDYwA4VotnFs8/b6hMbkktNrBUX7D25xI9NsrezVeV2gs?=
 =?us-ascii?Q?QPzosWYIouSnAk6WlJ8GDOTC8lwFyTpQ3yRm29kmFzJWt9JMC+896FcdGCYZ?=
 =?us-ascii?Q?USCruLZmVWEBxKtOatJONXwb8Xg9GFKm34825jBsgUpmzpyv70GYrf3O7/V0?=
 =?us-ascii?Q?3lCh2uDuJ+1rANr5hET+O7+yfyt1q/wfYmbuJrLTWifWohsMLaca7FQ7HFrD?=
 =?us-ascii?Q?vzLI2c5iqlV4t82vgSzfP/WF99RgAcERP0ZJLl9brj91tEztBXWBNXbahpU/?=
 =?us-ascii?Q?/1BAalNZN4gLEcQWYkcE1S4pt0ZGbsZbiETY1aGnqTkSANxopyfyvkO2jq63?=
 =?us-ascii?Q?Etvs0XvTeKfoBKIScLRU0S/lu0pl6Wc62pgIb4nkol7qGIlkJHOzR0mqofOK?=
 =?us-ascii?Q?fZr1WBxArTezZiT4vfKFewQ8j4gtJpsqo2YG6G7MR5+xNke2lfaJ89SVg0VJ?=
 =?us-ascii?Q?T90muqJd0/fpIwQotXSXWJ/lTTKhZw3Fh3MOmj+J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ca9274-79b3-467a-aedf-08dddf202bf1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:02.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrP6nuJ2ZKUZoLyTP9xtNhxi11rbZxncrnOlGD9rfb2v68sqa/54Q1c2llmsWdsrjNLp6vUmAzCfda+IggGxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

From: "F.S. Peng" <fushi.peng@nxp.com>

The NETC Timer is capable of recording the timestamp on receipt of an
external pulse on a GPIO pin. It supports two such external triggers.
The recorded value is saved in a 16 entry FIFO accessed by
TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
when the FIFO reaches a threshold or overflows.

Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v3 changes:
1. Rebase this patch and use priv->tmr_emask instead of reading
   TMR_EMASK register
2. Rename related macros
3. Remove the switch statement from netc_timer_enable_extts() and
   netc_timer_handle_etts_event()
---
 drivers/ptp/ptp_netc.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index da9603c65dda..7741b5bbe61d 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -17,6 +17,7 @@
 #define NETC_TMR_CTRL			0x0080
 #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
 #define  TMR_CTRL_TE			BIT(2)
+#define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
 #define  TMR_CTRL_FS			BIT(28)
@@ -25,12 +26,22 @@
 #define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
 #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+#define  TMR_TEVENT_ETS_THREN(i)	BIT(20 + (i))
+#define  TMR_TEVENT_ETSEN(i)		BIT(24 + (i))
+#define  TMR_TEVENT_ETS_OVEN(i)		BIT(28 + (i))
+#define  TMR_TEVENT_ETS(i)		(TMR_TEVENT_ETS_THREN(i) | \
+					 TMR_TEVENT_ETSEN(i) | \
+					 TMR_TEVENT_ETS_OVEN(i))
 
 #define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_STAT			0x0094
+#define  TMR_STAT_ETS_VLD(i)		BIT(24 + (i))
+
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
 #define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_ECTRL			0x00ac
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
@@ -48,6 +59,9 @@
 #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
 #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
+/* i = 0, 1, i indicates the index of TMR_ETTS */
+#define NETC_TMR_ETTS_L(i)		(0x00e0 + (i) * 8)
+#define NETC_TMR_ETTS_H(i)		(0x00e4 + (i) * 8)
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
@@ -64,6 +78,7 @@
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 #define NETC_TMR_ALARM_NUM		2
+#define NETC_TMR_DEFAULT_ETTF_THR	7
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -473,6 +488,64 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 	return err;
 }
 
+static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
+					 bool update_event)
+{
+	struct ptp_clock_event event;
+	u32 etts_l = 0, etts_h = 0;
+
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
+		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
+		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
+	}
+
+	/* Invalid time stamp */
+	if (!etts_l && !etts_h)
+		return;
+
+	if (update_event) {
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = index;
+		event.timestamp = (u64)etts_h << 32;
+		event.timestamp |= etts_l;
+		ptp_clock_event(priv->clock, &event);
+	}
+}
+
+static int netc_timer_enable_extts(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	int index = rq->extts.index;
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	/* Reject requests to enable time stamping on both edges */
+	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_handle_etts_event(priv, rq->extts.index, false);
+	if (on) {
+		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+		if (rq->extts.flags & PTP_FALLING_EDGE)
+			tmr_ctrl |= TMR_ETEP(index);
+		else
+			tmr_ctrl &= ~TMR_ETEP(index);
+
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		priv->tmr_emask |= TMR_TEVENT_ETS(index);
+	} else {
+		priv->tmr_emask &= ~TMR_TEVENT_ETS(index);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
 	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
@@ -526,6 +599,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 		return netc_timer_enable_pps(priv, rq, on);
 	case PTP_CLK_REQ_PEROUT:
 		return net_timer_enable_perout(priv, rq, on);
+	case PTP_CLK_REQ_EXTTS:
+		return netc_timer_enable_extts(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -638,6 +713,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_alarm	= 2,
 	.pps		= 1,
 	.n_per_out	= 3,
+	.n_ext_ts	= 2,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
+				 PTP_STRICT_FLAGS,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -670,6 +748,7 @@ static void netc_timer_init(struct netc_timer *priv)
 		fiper_ctrl &= ~FIPER_CTRL_PG(i);
 	}
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
@@ -803,6 +882,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 		ptp_clock_event(priv->clock, &event);
 	}
 
+	if (tmr_event & TMR_TEVENT_ETS(0))
+		netc_timer_handle_etts_event(priv, 0, true);
+
+	if (tmr_event & TMR_TEVENT_ETS(1))
+		netc_timer_handle_etts_event(priv, 1, true);
+
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
-- 
2.34.1


