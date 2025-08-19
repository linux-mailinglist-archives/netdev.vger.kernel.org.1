Return-Path: <netdev+bounces-214956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A4B2C49F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B2A016FC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9DD3431F3;
	Tue, 19 Aug 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Al5w+Jpm"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAE342CB0;
	Tue, 19 Aug 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608361; cv=fail; b=TkGXwq+c86i5k3lqe90HD+9tdgTGKQ+D5tDBEogbgCEcWkZGqizMFTWx8uDBxwkuaCqStYQjaeM7BAPbQjB/nKUkA19Us+BcV2xznBAq1325Tzj5nSrcN4O9P3Y9dJ1cdVnKkbIf73H8RfJM/38Imf7+kp+nx+eTugdlOSrhjuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608361; c=relaxed/simple;
	bh=kGn6AIvyNES8kEZIAln8Afa4zbOkRmAhaGn+ok+d328=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUPc22sfmp94FaL/z/qXgYuhcuVkywxVgZZZeHLZkvatZ4SIrojveZsrP/JBkeNBYEJcH7Z9TuwHsV836AAtbAv2ejyyYUHEnvrGbUxpN5gbnapaoenTNiNmTD8H/P0FKjU9FpzGSzpfxWIzb3RkyhhfQGSLxAh9h/5JnVI0dfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Al5w+Jpm; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxN4HUxi0lOph6P29+Gdq5FFNelIz8aifMPFPbECSB+mqdMbkAAO5G3ihdBjocVvI04FGky+m9zuAirOUzzF+Go9ZFCjUeuMsnXdYQZTeIyebVS6mkOFQO0tc6A3L5DnwZsqIM0zVq93FetyUkHFbWuUi2wGLcbw/ocka71J/mzudu876WaIeBo9QXQElmxiGBogqby4AWuFYOFO84CQ4q7jAfb0ZlDHf+mbn/LRLeyJbFPYNLOYtdscpy730iQKG4TJUOCDuyVsUxHiEEmqwLpsvLpm7OipFwA4KmYnc3WsGTs3JjdFmdubZqV3xijIC3QPnDUKLdtg/1dNOfwmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvjmBy+w3ZUhvob88q0A8TETZjv3WAM2fZ7AIl8ikqc=;
 b=UrWcZIYfM7mxqzIiSWUtHtlJliWzoGpr2SNYUnKc9ya8yqrKmF5WroDnaUPOKC4Ym8iPlKUyolU4yxCfC/xd3V3D/EWynWWZaklYf5INBkKqYWQWwq1uc0mtjrl+7QIRLmpUwlOklfTENOKbtWVEpSw3iEzjgEoNyIbha7sxSqUJ4xBkG/mSvc9YgA18/T/ZxDe4HSDOEUCQnUTr1l5kAZFjcuFGgLyUfI/yPNA1ZpIMQeNayzEJbM9SzoEvYsXq/o86rMKvJBpGXOGD1RUmKPvVLnh2YvQpDLLHlT7S7T78QTOAkgJEMpDArKdBVU0sEorm9lU3KPZwXplrOAtumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvjmBy+w3ZUhvob88q0A8TETZjv3WAM2fZ7AIl8ikqc=;
 b=Al5w+JpmjzMTpk/VrO3jnUHj9tEvA+EqoIwAESf3bwgQ3gFur1ZFa31R50zw+55GWo5uk5XNzO/nY9rOOlYSarw2fZjaK9D094nThVyVzyvFpRcX3MUXXt9GONU2QaxEaXnArU/VWoI3izGMl3yC3V1PJa2S2YAag1Kf78SP7UjNQAIuPZKD6c0BsFaHNw1wbe6p7ksZWxaxI9FS4xeHi367A7EbkOEuIP9UkJ9Epk/amV3THzUYO03FOSaxd9wgV7yCHEwhqhGpX/Xf+ujsdRyCt/oCIycs2uRMWppmDj0MGQNOBO6UU9CiY4QXsdihcmb74J6d1dxyUb2eGVhXvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:58:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:58:56 +0000
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
Subject: [PATCH v4 net-next 06/15] ptp: netc: add periodic pulse output support
Date: Tue, 19 Aug 2025 20:36:11 +0800
Message-Id: <20250819123620.916637-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60f1cb49-5037-46fd-0645-08dddf202766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cyNjTGYkRFMQLu26QuTUEyPAOLoPVHr0eyUgaHBP85/jOrf2n71FInUcmLrf?=
 =?us-ascii?Q?etoiJ7XrHt3lQ/ROqfiwCdkX0uQLTiyiAobayo+5rFui7JRq/l0bb3EX5S3k?=
 =?us-ascii?Q?0/GXMDfNjsphIdun6qQNjPitzCzMVv3HpY16BwdRsvord4Czr019erFZD0vl?=
 =?us-ascii?Q?loFJYYX8IdN3z2IoW3K4iSo87dpvOKcJKxi9eSHwVnscFtrk3ZWXgUnc7Tqd?=
 =?us-ascii?Q?S3r6D+W3t7EZDuq9KpdY6v5oE0LtvggHTFtB60UfShIZ127dYQfMrhnuGpQu?=
 =?us-ascii?Q?rzBSxrmFQq6TxT9XGpsdcwfJvZd5xpPP1iK0JQavnOQKnXVw2QgP4hJ1+oiu?=
 =?us-ascii?Q?RcYO4PL/F6MN9DG0zaotk86NqjxDTpl9WYM+tI2QYPXkNUX6JlCVNc9iDmGH?=
 =?us-ascii?Q?/7bqhhjUISaKt4h/5GlbnHN1BdQMTM7SoIDyLw7VFpVINuoko7xx4Yf7trBk?=
 =?us-ascii?Q?qOp81b16xMkrOn5JKq9DMPH9SZUBl5559DmE8inWD54+tplgSjxYEfWLW5Ql?=
 =?us-ascii?Q?QfzwxPdmUyUkHEWLsvxfcpP0R+osBEKeayuxq8aMLujMDP2snq+Yz4Vm6z71?=
 =?us-ascii?Q?HAacocJjlZocVwl0sd0HM+uXUrP4mm/Qk/nWjdinHOer9E4ft6b/i1HVCiDT?=
 =?us-ascii?Q?2taMMNoBANQX+zfIqFSdDdAfRI3U9H9CBwQ9P0FaRF9SbbpIFGR5Z53Y3Tk+?=
 =?us-ascii?Q?Dh4dvnM7RDyeR8N9Tja6F0SmOuMKHGQ1wJldkA/PgfYRo/wVWv98EsHSLJfi?=
 =?us-ascii?Q?YHuqf631fGTx2+MItleSOXos4GnIMpuoPzGxzMQzIrpVQV+5QHYR1vIskzJF?=
 =?us-ascii?Q?aJ8uH8z3MrCdQmTJW2SIvWaGMd5pjEY3at58pqY1CYHXdXkw6Aw69ifHaazj?=
 =?us-ascii?Q?c+sJaEDkdqG3RNieIRpsFhwv7mFtgiAOgXykGUUlbOut/eM0qyyfVhbkZu43?=
 =?us-ascii?Q?l+NmJ1wv+K2zU9D1qZAhX6p1swThXc4UihlwXtD4/6HjamHc8QnkmNEiHpRq?=
 =?us-ascii?Q?jFs0+xx95G277jSR/kY9nJ1Gi0rZnOFr0igilRowtuS+Kgphan+5p0kpufeP?=
 =?us-ascii?Q?B+kBF1tFIzUemwOHV69leAZY+ORW32FOjTnmq5NpqdJkk3pOSsCo7MC5Ng0A?=
 =?us-ascii?Q?b8Ew1fp5cQLY1MlvyRRDWsAVxxjjO1zb4F/e0RYHzgQNY8mG8lNcaPkKEvIP?=
 =?us-ascii?Q?QqaBb0JSN6eRj43tJtOZsu4uKMoasf7/Quimy8n0OaSsfyR95tSDTPwds9uV?=
 =?us-ascii?Q?yiVU5euc05X/r9nuqD8F25K6nwhQNS67kHqIgtlrV4DkB+lthktNtNpW0nwK?=
 =?us-ascii?Q?DoCNi0SAbyBPDzyPPw98Cp1YYL2BSKA9h4spgf0E0+CIskOIRQBMljY8XLfZ?=
 =?us-ascii?Q?MmZRMrsnRPRvtQ4oQjbcJR8gUcZGenbfp8MzX2UFPR08OzgKK4Z3jU03rOqh?=
 =?us-ascii?Q?zJVHD+H00hYnKbhIlOfyDYp7AMVHowE3RviLVoYrvrzrxoQs1QxQEevBlw59?=
 =?us-ascii?Q?RSO0vzTdxSVnugQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XLHEzr2aMlDvwVtRssDIZkMLQJm+lul5DuBlwx5x8zWJgQpHtKfV4A4mvum?=
 =?us-ascii?Q?jbwS9nnEvxNgBPFT0NWCx2tVLiGXll1CIpvNpa7sZ/d/r+UG5y1N75ELeDn7?=
 =?us-ascii?Q?48Ha2lADMzk+ngfcdJA9RSiH1FqrmW8xJHWf/VzBMm8cLJhdcRRblie0cJGa?=
 =?us-ascii?Q?2NWoGP9fBoZB2CmGTRhlY7haOrvyhJdnS78djWVSHRW3zpjSxCZZq1gJMJIe?=
 =?us-ascii?Q?tsQxrX+Bzt1oZDQevTyhB1TXwnpJM+mkbxKc1RTphByHeDUrDUVcyaC33EUN?=
 =?us-ascii?Q?Z2hKDkMZnDvqBNRGDpVhv7eVH/vdbnQ1leiubgGXuMc5VpS24mnTAwNIPHgz?=
 =?us-ascii?Q?YchJA8m5TgYkwzFfVENC1Fk2JADXL+Q/SeEs1A/bKN87iHcwZYzRAs/YZnrH?=
 =?us-ascii?Q?jlnmPITWi3bP5kIYJ5o+NvKt0waqYRgIL2MD6ra81G86mvI/XiZyb25EyELu?=
 =?us-ascii?Q?bBxcsWM9xqx9kPq+75ElSHhaTrVL+zSzoqiUiTLH3hQe6BX+IDJ2xRHsiti5?=
 =?us-ascii?Q?H9PO+SICTFfnpwCBGxJ8Skl/iGpPBua0l9sjX5GqWddIYk/9uAdiS0e8qc33?=
 =?us-ascii?Q?UruCZXWzxX4J7s6Ra0vBT/qViscRImw2P/PowK1R+ePK60j/ie0Sl8Yy3/LN?=
 =?us-ascii?Q?CXRV2Yy//JrA1Ftwl6ZpQeZAMvz1cGKKZY5aCNOBjt/z5aTKj/8vpEoFxUYP?=
 =?us-ascii?Q?yTR31/fVbujhuHHIsRAAZ1ArF7+QZi9jvNoV8zN0kargy66v6KdenceQG9Vo?=
 =?us-ascii?Q?30npF8WFhcO5rng/nhcq04ovfdDKEG0PDqITN/oQHzx5wVH5ncpAbLS02UP1?=
 =?us-ascii?Q?lRLGQKGBdpxHMnIkO6PhG42dNJaHdLAIRR+MECMAdBcAfbDJOwfeHnXaM8o+?=
 =?us-ascii?Q?40KXkwPbdOEmu4mKBw7mEVFfiZm08g+QFtTBHFocBXOBBPSIvh5c61Tyvruj?=
 =?us-ascii?Q?mukigmQcRz8Yv5I3plOqW8szG1h7rUjKLufxTgKWRxsg0LoeP4MaP+9aYQ0R?=
 =?us-ascii?Q?GvHWSHSUjxH50YaiwFa9Vcz6KBb+wAvWm3dSIJjND/jk1cgm1j+rBYa74no/?=
 =?us-ascii?Q?HStWkvZEV+iHy0RvCIss2UfQDjvZK0IIHEwTksrQyaWGKa+UGRQ36lsSh4AH?=
 =?us-ascii?Q?++7SfYuZsHWDXVsGrEfrZg/0wJBgQ1f823egKrXKKJUl0E0OmrDuvMOoqzc3?=
 =?us-ascii?Q?aMGfKoIl4fAHQZWxPylUxFFUvSkfj4Td4ZLW2j1nYwXQGnFmm9rrM0qBgnoB?=
 =?us-ascii?Q?iVnLCOxU34jzwKkk2yICEg+GzvRzGkvpzUzliAdgzYyyKKWx8H9e/fylqZxU?=
 =?us-ascii?Q?hpASSY9umV7P3UtufTFfPG6FgA5SWJCniWCs85PYXn1KLN1FRLtMHYQ++WWN?=
 =?us-ascii?Q?FumF1qrX7rAzX7+wkR8LHNs3MFNV1j/AJLiRocUZ/v8cSA1f1qYI7PhscAlj?=
 =?us-ascii?Q?4vyouElVHyxwL+ROQ5RjQZbcoBVQzlBiRhK6QjEG+pWXiH7xzgwkM/WC7Ru/?=
 =?us-ascii?Q?Ubm1dzjL+sYBLG5cO6JzG7UdSl9o5ibLhYAwbgZVNC2ixYW4lkvLaEnlMmdv?=
 =?us-ascii?Q?7s31Ok4JjPxdFMZav+UVXFv/od4aJ6lidvOUgheM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f1cb49-5037-46fd-0645-08dddf202766
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:58:55.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzHfkJwu+OMY4/g2ciaJijlFBbYwByqcyrc7PkqmFeiDVuQr3t7i3gE7C6ihCrQlHQxbqiUO7KYKeB+Fx6Lkkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

NETC Timer has three pulse channels, all of which support periodic pulse
output. Bind the channel to a ALARM register and then sets a future time
into the ALARM register. When the current time is greater than the ALARM
value, the FIPER register will be triggered to count down, and when the
count reaches 0, the pulse will be triggered. The PPS signal is also
implemented in this way.

i.MX95 only has ALARM1 can be used as an indication to the FIPER start
down counting, but i.MX943 has ALARM1 and ALARM2 can be used. Therefore,
only one channel can work for i.MX95, two channels for i.MX943 as most.

In addition, change the PPS channel to be dynamically selected from fixed
number (0) because add PTP_CLK_REQ_PEROUT support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2: no changes
v3 changes:
1. Improve the commit message
2. Add revision to struct netc_timer
3. Use priv->tmr_emask to instead of reading TMR_EMASK register
4. Add pps_channel to struct netc_timer and NETC_TMR_INVALID_CHANNEL
5. Add some helper functions: netc_timer_enable/disable_periodic_pulse(),
   and netc_timer_select_pps_channel()
6. Dynamically select PPS channel instead of fixed to channel 0.
v4:
1. Simplify the commit message
2. Fix dereference unassigned pointer "ps" in netc_timer_enable_pps().
---
 drivers/ptp/ptp_netc.c | 356 +++++++++++++++++++++++++++++++++++------
 1 file changed, 306 insertions(+), 50 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index ded2509700b5..da9603c65dda 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -52,12 +52,18 @@
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
 #define NETC_TMR_REGS_BAR		0
+#define NETC_GLOBAL_OFFSET		0x10000
+#define NETC_GLOBAL_IPBRR0		0xbf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+#define NETC_REV_4_1			0x0401
 
 #define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
 #define NETC_TMR_DEFAULT_PRSC		2
 #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
+#define NETC_TMR_ALARM_NUM		2
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -66,6 +72,19 @@
 
 #define NETC_TMR_SYSCLK_333M		333333333U
 
+enum netc_pp_type {
+	NETC_PP_PPS = 1,
+	NETC_PP_PEROUT,
+};
+
+struct netc_pp {
+	enum netc_pp_type type;
+	bool enabled;
+	int alarm_id;
+	u32 period; /* pulse period, ns */
+	u64 stime; /* start time, ns */
+};
+
 struct netc_timer {
 	void __iomem *base;
 	struct pci_dev *pdev;
@@ -80,8 +99,12 @@ struct netc_timer {
 	u64 period;
 
 	int irq;
+	int revision;
 	u32 tmr_emask;
-	bool pps_enabled;
+	u8 pps_channel;
+	u8 fs_alarm_num;
+	u8 fs_alarm_bitmap;
+	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -190,6 +213,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
 static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 				     u32 integral_period)
 {
+	struct netc_pp *pp = &priv->pp[channel];
 	u64 alarm;
 
 	/* Get the alarm value */
@@ -197,7 +221,116 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 	alarm = roundup_u64(alarm, NSEC_PER_SEC);
 	alarm = roundup_u64(alarm, integral_period);
 
-	netc_timer_alarm_write(priv, alarm, 0);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
+					u32 integral_period)
+{
+	u64 cur_time = netc_timer_cur_time_read(priv);
+	struct netc_pp *pp = &priv->pp[channel];
+	u64 alarm, delta, min_time;
+	u32 period = pp->period;
+	u64 stime = pp->stime;
+
+	min_time = cur_time + NSEC_PER_MSEC + period;
+	if (stime < min_time) {
+		delta = min_time - stime;
+		stime += roundup_u64(delta, period);
+	}
+
+	alarm = roundup_u64(stime - period, integral_period);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static int netc_timer_get_alarm_id(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->fs_alarm_num; i++) {
+		if (!(priv->fs_alarm_bitmap & BIT(i))) {
+			priv->fs_alarm_bitmap |= BIT(i);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
+{
+	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
+	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
+	 */
+
+	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
+		       priv->clk_freq);
+}
+
+static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
+					     u8 channel)
+{
+	u32 fiper_pw, fiper, fiper_ctrl, integral_period;
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	/* Set to desired FIPER interval in ns - TCLK_PERIOD */
+	fiper = pp->period - integral_period;
+	fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+			FIPER_CTRL_FS_ALARM(channel));
+	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
+
+	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
+			   TMR_TEVENT_ALMEN(alarm_id);
+
+	if (pp->type == NETC_PP_PPS)
+		netc_timer_set_pps_alarm(priv, channel, integral_period);
+	else
+		netc_timer_set_perout_alarm(priv, channel, integral_period);
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_disable_periodic_pulse(struct netc_timer *priv,
+					      u8 channel)
+{
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+	u32 fiper_ctrl;
+
+	if (!pp->enabled)
+		return;
+
+	priv->tmr_emask &= ~(TMR_TEVNET_PPEN(channel) |
+			     TMR_TEVENT_ALMEN(alarm_id));
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+
+	netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static u8 netc_timer_select_pps_channel(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			return i;
+	}
+
+	return NETC_TMR_INVALID_CHANNEL;
 }
 
 /* Note that users should not use this API to output PPS signal on
@@ -208,77 +341,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 static int netc_timer_enable_pps(struct netc_timer *priv,
 				 struct ptp_clock_request *rq, int on)
 {
-	u32 fiper, fiper_ctrl;
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-
 	if (on) {
-		u32 integral_period, fiper_pw;
+		int alarm_id;
+		u8 channel;
+
+		if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
+			channel = priv->pps_channel;
+		} else {
+			channel = netc_timer_select_pps_channel(priv);
+			if (channel == NETC_TMR_INVALID_CHANNEL) {
+				dev_err(dev, "No available FIPERs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+		}
 
-		if (priv->pps_enabled)
+		pp = &priv->pp[channel];
+		if (pp->enabled)
 			goto unlock_spinlock;
 
-		integral_period = netc_timer_get_integral_period(priv);
-		fiper = NSEC_PER_SEC - integral_period;
-		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
-		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
-				FIPER_CTRL_FS_ALARM(0));
-		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
-		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
-		priv->pps_enabled = true;
-		netc_timer_set_pps_alarm(priv, 0, integral_period);
+		alarm_id = netc_timer_get_alarm_id(priv);
+		if (alarm_id == priv->fs_alarm_num) {
+			dev_err(dev, "No available ALARMs\n");
+			err = -EBUSY;
+			goto unlock_spinlock;
+		}
+
+		pp->enabled = true;
+		pp->type = NETC_PP_PPS;
+		pp->alarm_id = alarm_id;
+		pp->period = NSEC_PER_SEC;
+		priv->pps_channel = channel;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
 	} else {
-		if (!priv->pps_enabled)
+		/* pps_channel is invalid if PPS is not enabled, so no
+		 * processing is needed.
+		 */
+		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
 			goto unlock_spinlock;
 
-		fiper = NETC_TMR_DEFAULT_FIPER;
-		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
-				     TMR_TEVENT_ALMEN(0));
-		fiper_ctrl |= FIPER_CTRL_DIS(0);
-		priv->pps_enabled = false;
-		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
+		pp = &priv->pp[priv->pps_channel];
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	}
 
-	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
-	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
+}
+
+static int net_timer_enable_perout(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	struct device *dev = &priv->pdev->dev;
+	u32 channel = rq->perout.index;
+	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PPS) {
+		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
+
+	if (on) {
+		u64 period_ns, gclk_period, max_period, min_period;
+		struct timespec64 period, stime;
+		u32 integral_period;
+		int alarm_id;
+
+		period.tv_sec = rq->perout.period.sec;
+		period.tv_nsec = rq->perout.period.nsec;
+		period_ns = timespec64_to_ns(&period);
+
+		integral_period = netc_timer_get_integral_period(priv);
+		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		gclk_period = netc_timer_get_gclk_period(priv);
+		min_period = gclk_period * 4 + integral_period;
+		if (period_ns > max_period || period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %llu\n",
+				min_period, max_period);
+			err = -EINVAL;
+			goto unlock_spinlock;
+		}
+
+		if (pp->enabled) {
+			alarm_id = pp->alarm_id;
+		} else {
+			alarm_id = netc_timer_get_alarm_id(priv);
+			if (alarm_id == priv->fs_alarm_num) {
+				dev_err(dev, "No available ALARMs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+
+			pp->type = NETC_PP_PEROUT;
+			pp->enabled = true;
+			pp->alarm_id = alarm_id;
+		}
+
+		stime.tv_sec = rq->perout.start.sec;
+		stime.tv_nsec = rq->perout.start.nsec;
+		pp->stime = timespec64_to_ns(&stime);
+		pp->period = period_ns;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
+	} else {
+		netc_timer_disable_periodic_pulse(priv, channel);
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+	}
 
 unlock_spinlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	return err;
 }
 
-static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl;
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			continue;
+
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
+	}
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl |= FIPER_CTRL_DIS(0);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
-static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_enable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl, integral_period, fiper;
+	u32 integral_period = netc_timer_get_integral_period(priv);
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+		u32 fiper;
 
-	integral_period = netc_timer_get_integral_period(priv);
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
-	fiper = NSEC_PER_SEC - integral_period;
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
+
+		if (pp->type == NETC_PP_PPS)
+			netc_timer_set_pps_alarm(priv, i, integral_period);
+		else if (pp->type == NETC_PP_PEROUT)
+			netc_timer_set_perout_alarm(priv, i, integral_period);
+
+		fiper = pp->period - integral_period;
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
+	}
 
-	netc_timer_set_pps_alarm(priv, 0, integral_period);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
@@ -290,6 +524,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 		return netc_timer_enable_pps(priv, rq, on);
+	case PTP_CLK_REQ_PEROUT:
+		return net_timer_enable_perout(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -308,9 +544,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
 	if (tmr_ctrl != old_tmr_ctrl) {
-		netc_timer_disable_pps_fiper(priv);
+		netc_timer_disable_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
-		netc_timer_enable_pps_fiper(priv);
+		netc_timer_enable_fiper(priv);
 	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
@@ -337,7 +573,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
@@ -347,7 +583,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -384,10 +620,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -401,6 +637,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_pins		= 0,
 	.n_alarm	= 2,
 	.pps		= 1,
+	.n_per_out	= 3,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -558,6 +795,9 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	if (tmr_event & TMR_TEVENT_ALMEN(0))
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
 
+	if (tmr_event & TMR_TEVENT_ALMEN(1))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
+
 	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
 		event.type = PTP_CLOCK_PPS;
 		ptp_clock_event(priv->clock, &event);
@@ -602,6 +842,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 	pci_free_irq_vectors(pdev);
 }
 
+static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
+{
+	u32 val;
+
+	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
+
+	return val & IPBRR0_IP_REV;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -614,12 +863,19 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		return err;
 
 	priv = pci_get_drvdata(pdev);
+	priv->revision = netc_timer_get_global_ip_rev(priv);
+	if (priv->revision == NETC_REV_4_1)
+		priv->fs_alarm_num = 1;
+	else
+		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
+
 	err = netc_timer_parse_dt(priv);
 	if (err)
 		goto timer_pci_remove;
 
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	spin_lock_init(&priv->lock);
 
 	err = netc_timer_init_msix_irq(priv);
-- 
2.34.1


