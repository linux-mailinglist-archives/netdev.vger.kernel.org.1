Return-Path: <netdev+bounces-212855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1FDB2242C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03ED67B63A9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3712ED163;
	Tue, 12 Aug 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nl41+PDd"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320532EBBB0;
	Tue, 12 Aug 2025 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993299; cv=fail; b=W6/44Un2Hj8NsrvQlourkK20pxqupZKNIqVZK/CJV9jO2g55BIvDNz9b/fu12BTQM06AbdFjMxXyQV5ykYywFpyL6xm0lO7fuRF2aCZDyyTd0QWp+ZXn9jaumaHMbSzJi+0klDUTJSuBUHGw2ao5KrfiwufpgBPxo2Iz2YMog7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993299; c=relaxed/simple;
	bh=5tyWpFE2HZ8eqQmKsft/nfUZpDZ2IpSHKEUYhD+qDlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPpBgqutW4Vgchmacpw2cEhGxqmPXNuXm1Qyt7Jc2U9dCHOvzjRvR1ocAjKdFAoLqExps68dzIzTU4KQhpk5tXVVyuXUxvnQ8w/E6tZNyjMOaF0w3gBfJehaAK4zH3fYqBCrRngkOPFoYFVtutlZj3vMHtbYv62ifBqYO5sV4sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nl41+PDd; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMzR1cCehGBD7z1PLmJOIY9iF6LB3eXdBltPnUjuyDJz8DQWuJLCT82af2kj5BeU3qOOP7rNhE3RdJbozssSKFIcUAQr9hEwEHPMjOJaVPEQwyjnaXGrGrdRYgjUKpwUwgVR0OYn0+O9MQrQgvYbKiaDcGaMN4DFyfyu9MGhX2AIup2Y97F+q2DXCfJwkPNcLtMm3hrjf4MQSo9V4pTeLHNP0zcrJDzXNNGJUK3OaTT+yraIgUSL0S27wqxl3ihPfAyA5zHIMd5wNc7ThQonLu76gDyljEdXMk947pXllXBC8VBqjZbxswpTuKrbrJXsSw4p6Cz7wGCgJLH0GQDD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBX6SwmDNNzLy47gvmN9xIiUYTmexXi59RubYIdf+R0=;
 b=wluYu/m+c8JUd2h/lgZqVdg9cN4X/KmMNjNRtoCnLQkJpEJfm0X1wQo+z3sNSTiW0jndKvz+BDPXgq3T5jrdgVcdpEFQ1x6yj2dJmXurhKckDHfN1w7yU47T50GEcvJ9WQET2/dsQBbEZEh+P0+KqYbl7G6xdXqkiGQnqLVvlQKZRJ7gAQjQqu1BOQxPY0e8Rob16+cS+bz+0c/lxaMdSIFftF7RjO4eftzmWBvrw1lQJy7QsZxz+jom/mj4NEBmTQFma1vvzeenL/7RFBrXY+vHtfpbMdWSu79q1oazpSP6yXLu0jMNuutiZ+47vdPXz5pbyIwGcTowBYQK0bfbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBX6SwmDNNzLy47gvmN9xIiUYTmexXi59RubYIdf+R0=;
 b=nl41+PDdZpUtEn3Dxt5CGK6NIqgzgqktnEu7p+H37EYnHxjGgArFu+NcLGFo//7T4REnKg9bZbmaPOlJGBKoFIAmM+hyLma50YN9GYQEFlM+Pm79lyhiEFgzF84Pr3+MxYza+6HKddt2ua8SDACBxPXmcXbOGQe2/5psWamnfay/vHRHui2HI9DTHZAReevIDFOG6Xacv8ho2XxRuJUk+2bXGmC90xSGUO5e4IOb1zN6TmgCsgqbL9jDy3HbuXhZTJkl7vRGp6oh5wOiGsqXTI3luCr0FzUKUqry7gQ11sgTPwU3spGZxRU9Q7pjFZ9XK+Gio5O1hKDq0eRh7aDOCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:08:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:08:14 +0000
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
Subject: [PATCH v3 net-next 11/15] net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync packets
Date: Tue, 12 Aug 2025 17:46:30 +0800
Message-Id: <20250812094634.489901-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 26486f4d-a31d-4126-b2a7-08ddd9882686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HOO2arP5lC1BGqbsxwbrLCf7hgy5MolEgaeZAKaxs0WamkLuKsu6HFfEFVjE?=
 =?us-ascii?Q?Ad9P1phjUl+bi6u6nEv7euMjblc4MLxeWIozIKTqtyhfG6m8ze5NTtmuMR3V?=
 =?us-ascii?Q?oGav/M8iDqkVxSIZ18aYT+9QUii1Lmp9mLA8c6dG0v2PZGDnwkfRErRmSw3V?=
 =?us-ascii?Q?05QLt2uyQNa8gP2x1+/B/DKe9VFhmdqBX3QyRie4oten+P7ZIyjPKnP6vZbe?=
 =?us-ascii?Q?gq0fO6MW4qJxIwyXyFEWwxTeIoE3/k/13Hpt+G1k1mrHSDI1TxNBtitkCIY4?=
 =?us-ascii?Q?tPj7E3zC3xWVmnH7SiFz/HCNGdDLzIJdPEJnApX0u+TCQLGsxmMZirEja0lm?=
 =?us-ascii?Q?EZ2hfoJ2DBxvdiizm42NdhW0Jjw2FcClHmTnDe3n6ZUWjoDfoBXuoDefCBgN?=
 =?us-ascii?Q?jkVN6qO4RzNRT+ymcoJiIwaLIzsc1Mi7sX59UOVtRuCcLSwQi+2/jkl28QXd?=
 =?us-ascii?Q?HEj9aacW6qhPR03oqhKPnSrG242SSLYb75Jh507DqNVykGKAyFXx5q/nv3+M?=
 =?us-ascii?Q?F6x4s9+9xtgI0Gd4IZWHWZs6kgspWdJGgt5VDYgEqltA9A8tBW/RAlJa5EG4?=
 =?us-ascii?Q?Ex10pTbvPl+6V1qeR19Pq6LMjOK18ervscWteZnRfigCfVHLKwJ8NBn0Tj8c?=
 =?us-ascii?Q?YVE16Y9i6lnWrL7qxesTWC3vpYYgNjrkPb4JsJd6tpayGZukspSg09evvv6w?=
 =?us-ascii?Q?TjPvS3fyk+7RtNXBaTuN+5bUIEsfudkqZn8DrsjwWQ8uH3yP3pwVpsvx/xHQ?=
 =?us-ascii?Q?NNQgzkCUhm1r3Qe81+Lk6P/dMfxDAomQdO4vWqewvH8zEqCOQNu7zuWz9dQr?=
 =?us-ascii?Q?gRkYtkFdiEIZ9p0WtO0Llb+rN4s0czXXzs7XZV08WmFkNmcs2yTby4+0NySI?=
 =?us-ascii?Q?/ZoPCFtDhSjnRL8rB/IrfCxRyiH6ZXphs4XM3ZCsV++wyVX5JxTWTztKb1+v?=
 =?us-ascii?Q?yGJuj64nGyAwVjqFyRnBSNXbsU0LgIy2+2yp61fWcEUsLNTPLC6a6u3Nlxgq?=
 =?us-ascii?Q?foMIDtC2OrtTB2GX4vwm9FC7DJ3gC712PbIGAghE5g0/zwFu8kqnJLnE/tJB?=
 =?us-ascii?Q?n2/+44HQZK8yzhz9Qx0XPUINabUMQGGcW/ormJRkHm4g77ma9HJ+57ab8ed2?=
 =?us-ascii?Q?5+7rgF6Ptz8aSxGxFSDac9qZFPVPay4j0XBxd36/uApYmnj7DhinfbfilF95?=
 =?us-ascii?Q?3qZMQyt+x5ri6hKwnIMtkDT6Oxc3RLz51g3oKqxBi3zGAy/svD7jin1wRQSD?=
 =?us-ascii?Q?BWl0KMDzbsFkiwrHvlETQgy3P3kQBXP/xA1hkF1PCbHnsOEOxPuSsDbaC/Ad?=
 =?us-ascii?Q?mAmV3KrByUHHuTG5+lgQ8Xa3AAzGiS9re2Id/ut7aM+BvWJsvh430beeGATK?=
 =?us-ascii?Q?bX/E0EC3zUGUZC8FpHX7D0rslL9iIMKsHBzdjzW5cFBqJsQBxL7jD598iAbe?=
 =?us-ascii?Q?OJcT9mHQS7iviUM5Pt1g6RAEx0WPTczhmv2B/JX1Iy9Yl7GNYH/ilO6Ph9c/?=
 =?us-ascii?Q?YTICX3yzX95MyDM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BBjgUP7SR/OR3/jpZgpLBRUkNTZG0WJ5SfDNQ/bA5JUHdaGSQe0M6cDeuhNy?=
 =?us-ascii?Q?MxI1KwjfTj3AIhMMZclcxyaYHAddhJNIZTzTnmO6eFCB7XM1IeE35FhfTC4x?=
 =?us-ascii?Q?envsVzVOSRl/AW61G/K/+nx2HdCyG42K6zFT90khuxBBNrdNICmvCmin26cF?=
 =?us-ascii?Q?jzNO5efx1edCYC4/NtHpI5LwLY1o3p7O18KB/CWnHnkVBy9V0wF1UIW8wV//?=
 =?us-ascii?Q?kiT+Nz8YsHUDmSkGmM0InUSdikG8zXaykhKK5YEHoTLNfWThPnBRq0bgvPYb?=
 =?us-ascii?Q?dnVPsp8bSXUMuaX6PVvnF/4Wz8KAjVaQQR6E3czIv1CxoZc8dqhI7BGBSCI7?=
 =?us-ascii?Q?KyXhKPnjZJeKQ1NLPctLl5YY0AaGdoEaVhBp3hudLxKRtM3lv1OFekVRuCLB?=
 =?us-ascii?Q?qojZxbAkayWlcG8Hm39W1Ty0UZTbfYHe9Xi8DSQShQ+VDmD8e+ktdaVMsP8V?=
 =?us-ascii?Q?p/5tkXMpShOl+0KSrhN2LpfwvNjogSg6/RjZ7lRx0bgUsQdBseVJDI1YCVeg?=
 =?us-ascii?Q?yySkfNrSTgU8ffjxuKBBaTBb32VoTA0M3DvIo2rEQ9E+WaCWD1Zmep6NoWKU?=
 =?us-ascii?Q?m1jptGkxaMnYKekz7/fGHSbgC/uowJvZ7IECVBMhAkmQMo1UQbJWeHw6V2xh?=
 =?us-ascii?Q?FWFWNfH9uIv1sgWLc4UO6ATClGAjctVWfPnDelja88bpKgrjoIuqcxc9et3J?=
 =?us-ascii?Q?AvllvVk7DoY45eBqd1BRbF/ZzHeY2YW5Eq96ZfqkPEPHVrDZ+glqMKltWjuL?=
 =?us-ascii?Q?yvxcrPa/UFFf00JcFAU8Q3N+cum8v3q9//UgqFVd9rc+y++bTByiXv4AREIk?=
 =?us-ascii?Q?dehkXI069bELd6YY8mxlm9EPE4J+pBGktM/ZoROQfl4P40Hsn7w3aIgc4eAR?=
 =?us-ascii?Q?SiyT3gbgOhvLJJJ5BqAfAptW59YOecMIl16yI3Jm9YZCNjbk3xfEOA1LHdRJ?=
 =?us-ascii?Q?wnfGaqBfy0TFk1xtelZwxeAA8JTtdgR5Q8aDOS5GJzIMvxbuXR8GoqmSVKwM?=
 =?us-ascii?Q?7ciIzxq+GqK6g3Mzums4+4I5AfKv7h4uJNA+NLWU/oWSd12DvL8af4GQSRvh?=
 =?us-ascii?Q?gqMIy5ITrayLF+fwRCto4Dp+TxfVhp2MMhXonWCXebtO6+TpWlstWNj+CcFW?=
 =?us-ascii?Q?/yK7rJRWQscy/m0j0t427A5sVduainaRl8w1I2uMG6Bvd1KMTAYz3D53ik7k?=
 =?us-ascii?Q?LHPeIBljPaXS4R1wQmyBoy7e6vCLQQ66g1tK4mNDZgF2vhIQjPIM55jVVvbB?=
 =?us-ascii?Q?MMQIXcXRrDU4J5P3KhSJ/Tnr67jf2bT9dXXCuLR5loNGIzWZOvoyw5eX52j0?=
 =?us-ascii?Q?KiAt6eEgKqWcWnXiHbySKR4JtITkUYXSxaMpI1Nfl0NPxNQ/f/Bo85WNkOws?=
 =?us-ascii?Q?zO2JRT2pNqZpCPdux6BqIXNJP5kXEsbSLeMCSG08VxomF//1lXjK2V9ZilVC?=
 =?us-ascii?Q?f7y4TA2N5fNk6VtUndX8Ph7lWMELrawyCrTfN7H4MqD8QcvUFHnMU+wpq+aq?=
 =?us-ascii?Q?TMpjj0MxTThGA+AUYwYrO1io4/2vxGkIqc0UAjEgeeIx9Z8gTuiqbIQtQdSb?=
 =?us-ascii?Q?poqXKyRgR5WWlj3WOaUBOyYecV03YntweF0EcFN2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26486f4d-a31d-4126-b2a7-08ddd9882686
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:14.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfZ2ZDWYewIDOEmbfDvHKXsicLjpymM7Az+UcKBvq7y+rKIX9knWIEag+1Ji71gec8ca2ewGt/mznOcR9I4DPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
function enetc_update_ptp_sync_msg() to simplify the original function.
Prepare for upcoming ENETC v4 one-step support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2: no changes
v3: Change the subject and improve the commit message
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 54ccd7c57961..ef002ed2fdb9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
+				     struct sk_buff *skb)
+{
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+	u16 tstamp_off = enetc_cb->origin_tstamp_off;
+	u16 corr_off = enetc_cb->correction_off;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	__be32 new_sec_l, new_nsec;
+	__be16 new_sec_h;
+	u32 lo, hi, nsec;
+	u8 *data;
+	u64 sec;
+	u32 val;
+
+	lo = enetc_rd_hot(hw, ENETC_SICTR0);
+	hi = enetc_rd_hot(hw, ENETC_SICTR1);
+	sec = (u64)hi << 32 | lo;
+	nsec = do_div(sec, 1000000000);
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanseconds field
+	 *
+	 * In addition, the UDP checksum needs to be updated
+	 * by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong
+	 * checksum when updating the correction field and
+	 * update it to the packet.
+	 */
+
+	data = skb_mac_header(skb);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_nsec = htonl(nsec);
+	if (enetc_cb->udp) {
+		struct udphdr *uh = udp_hdr(skb);
+		__be32 old_sec_l, old_nsec;
+		__be16 old_sec_h;
+
+		old_sec_h = *(__be16 *)(data + tstamp_off);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+
+		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+
+		old_nsec = *(__be32 *)(data + tstamp_off + 6);
+		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+					 new_nsec, false);
+	}
+
+	*(__be16 *)(data + tstamp_off) = new_sec_h;
+	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
+
+	/* Configure single-step register */
+	val = ENETC_PM0_SINGLE_STEP_EN;
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+	if (enetc_cb->udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+
+	return lo & ENETC_TXBD_TSTAMP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
@@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u16 tstamp_off = enetc_cb->origin_tstamp_off;
-			u16 corr_off = enetc_cb->correction_off;
-			__be32 new_sec_l, new_nsec;
-			u32 lo, hi, nsec, val;
-			__be16 new_sec_h;
-			u8 *data;
-			u64 sec;
-
-			lo = enetc_rd_hot(hw, ENETC_SICTR0);
-			hi = enetc_rd_hot(hw, ENETC_SICTR1);
-			sec = (u64)hi << 32 | lo;
-			nsec = do_div(sec, 1000000000);
+			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
 
 			/* Configure extension BD */
-			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
+			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-
-			/* Update originTimestamp field of Sync packet
-			 * - 48 bits seconds field
-			 * - 32 bits nanseconds field
-			 *
-			 * In addition, the UDP checksum needs to be updated
-			 * by software after updating originTimestamp field,
-			 * otherwise the hardware will calculate the wrong
-			 * checksum when updating the correction field and
-			 * update it to the packet.
-			 */
-			data = skb_mac_header(skb);
-			new_sec_h = htons((sec >> 32) & 0xffff);
-			new_sec_l = htonl(sec & 0xffffffff);
-			new_nsec = htonl(nsec);
-			if (enetc_cb->udp) {
-				struct udphdr *uh = udp_hdr(skb);
-				__be32 old_sec_l, old_nsec;
-				__be16 old_sec_h;
-
-				old_sec_h = *(__be16 *)(data + tstamp_off);
-				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
-							 new_sec_h, false);
-
-				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
-				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
-							 new_sec_l, false);
-
-				old_nsec = *(__be32 *)(data + tstamp_off + 6);
-				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
-							 new_nsec, false);
-			}
-
-			*(__be16 *)(data + tstamp_off) = new_sec_h;
-			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
-			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
-
-			/* Configure single-step register */
-			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-			if (enetc_cb->udp)
-				val |= ENETC_PM0_SINGLE_STEP_CH;
-
-			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
-					  val);
 		} else if (do_twostep_tstamp) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 73763e8f4879..377c96325814 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -614,6 +614,7 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_STATS_WIN	BIT(7)
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
+#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
 
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
-- 
2.34.1


