Return-Path: <netdev+bounces-138266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A943E9ACBAF
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59867281E7D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC21BF81B;
	Wed, 23 Oct 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J/ShAlm2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468F1BC9EB;
	Wed, 23 Oct 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691592; cv=fail; b=JNpaLeV+onvwYGsudTr5H5hbLG4PhajqP4UB42ZFDzcQYh6gRF8D9yGJ6mBs2AUFhYpraopyrRqvuw0KlHMCpghBtZopbYDJS/30BV9sosiJi77XgyhnbgUNyQ0NtsmgekomXfmxgVU1ElN5Uu8kVpZvBfILzfnCkYOE/uLHn04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691592; c=relaxed/simple;
	bh=WFP7RmBPECgC9N/ARtf9EYD0haXHFNnHEAG2WpEGSgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5G9AqpBzJXw+CxM//FhMja7/xzv+Cjjh6CjrQhXVlMT9Oy4NA56rQexif9GIvHVjOrGVjifREZtSDShy9L30Q3hH/G5sxbyKcvxIx3QO3nH+D9J6AlBUd1QgczDRIL+OHoDyz/jorERCv1aTzr2Zr15Cu6xfqeFT/PQinMOmqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J/ShAlm2; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMpC22tpGAfi3xXWELg9dX/OXwUS0jfm3u1TxHnwdEzy/3Xx5MSB6+FfuqqriTrbSktod/IkiI0g/29fQHkapasO/9F7D+SUd6DXw+znQ4c0CkqZR5DlgzmOaEmaSaN5nZjXan2y+B0Pud/Ho2P0ND+mmKWYDk0LwddR3nAIcr/POseQy4jsONEfrlSkV2ad+CjM6LGyKNzhbsRHLSDbL/gBUkuEgxQCNhYgrSu/y/h1VGMMox8JVyIFlNNojoWSi1305xfLtVV6qOKKphhw1QCrbB5LB/zpRicRT08x7sShZmLANQFrGFMfMR/TIkp5iF0WU/5FTZQMF7++e3Qb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3AHksdjf87SjJsNfqjc72/8+TaQDuPWe1fjxFyDWEQ=;
 b=hgRbyhAoIul31m+yhbLk7vIqTdpuldYIyJTxkAOu7UYfDzmycsuOxwV98bXUo5G47EKqWOMEBPcv+v+DJdVlkQKaZ6vagzcRo1NWKJkI94/pOdYaxUnDBQfvi0VLJ2WOhR8Xnsf1lfBSQzj0UMjIV8vGc+vPuXLRMY9syLmma1nE5dZzYP5XCGz7M1Jfu2OKjg82GvSAnA2COztgWGesiQwsBXqlL4ewH3WSigQTbXlDbfEj5zJZan7cauvEeLfVZoIF42+XeVdkAiM5FPax5D0wBKRC+vGohs4uBGjZ+TPz0u7tyBffuzRWmktgF7rksqKAW49Y2qzsXHeISuYB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3AHksdjf87SjJsNfqjc72/8+TaQDuPWe1fjxFyDWEQ=;
 b=J/ShAlm2KD8e+ixvxeV8ZrNWAOYQAJV3GlN1q8i8+jiFoJiVDX4Ymk8KGhovec309fH7uzcRi1iyFGO8jgZ+NiuDgdSce486EZ1Q9AZMGE7rOVhNyIUMtvWHyFrzimi18yhOsAZbdZQS1pFkBipLACZbN2sysV5xPnUC9+/ALXC9WOnHktTjeXkir9C+fJBoyRH50vbPBTCaYihz9ndM/YDC8ze6h4rGFO1PEPZ1FXKaQA50LJsP+Y/TKUNegy0HTpBkgmmsvmY4YYFK9RvL3OtapGQ1/QDjVre91T3aC/iIxKaxX9ATB5Uy6nO88hdGwQLxjw5tlukoPYW7vSkifg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:53:04 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:53:04 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 2/6] net: dsa: clean up dsa_user_add_cls_matchall()
Date: Wed, 23 Oct 2024 16:52:47 +0300
Message-ID: <20241023135251.1752488-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: c97909d1-7607-4232-8602-08dcf36a0452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zauEWOnPF0P3Uv5XHlVloUlHkfBh8rzORBaylRdAiKLLVAczJFiSIlwYo6wt?=
 =?us-ascii?Q?5BLPOdECd8sw0ylHKu6WTMy0Y0dAUlgmmBdOyWSv/XfqTmmf4zh9fHW6C8ZJ?=
 =?us-ascii?Q?OWVe9XlIeaEh4mocA77V6rB0ZSRWdfKfLt9NHLR4e2tBddjn7+enPUKHVxUe?=
 =?us-ascii?Q?pzOKZQmQAKXelQI1gyPenwhUl25APEndr5r8G0ahh2ZlXwW58DSpJN8F8wDB?=
 =?us-ascii?Q?20GbAEuBGPi0yFYAAGEogxeOTqeFIeeNbnp/rGUJ8TYZpl36yezx6FGuas/2?=
 =?us-ascii?Q?i7uWEjWoQL4xCD168zMHc/LkUcmrphdKCH9vrKSfRafHpQyGF4ldEXbysY7t?=
 =?us-ascii?Q?0Gz/UQcbxml3iy1EYYU3klQp97tI6+KJL//bxlcCJJfl97yP0wRP7HKT8DnC?=
 =?us-ascii?Q?WPMe2bLewnvRPIsrjtauxtbK/e7N6p0jkLUeX1aEiULpke+WGlLEGWTHlWnV?=
 =?us-ascii?Q?kfes3DoHdxray/Uy6AP5yxZBS8/2/SpnizdJhX5ydwGU3J1vOltUOgY5U3vH?=
 =?us-ascii?Q?3gFnlIYv0yFxXufwHIGg0NRySbAye/gUJ704zy3BZ5nuSSMhc7z1QRxIMKSi?=
 =?us-ascii?Q?Z4ei/vrZCtQ3oYSkfmbDav+CJR19ZudB8N5sSftYtJxRKGa40Ijac1I3djUR?=
 =?us-ascii?Q?z0aYKl2btvTWPRrNPZ6Zkl6207hHm4i4sMTjhE5lZE36ErgMe7Z/g3pF8LVp?=
 =?us-ascii?Q?K9GARj12mAjCQ+pcN8T/6ZliQNgSV0GrVNLRt4hPzzz1sH38KOvXuHWmVVll?=
 =?us-ascii?Q?FdeDBNT/aHjjBW4uuNHKS+JuyNtnm8TVWx/+BNykCxu1zP0lFvgOKGNDR9vF?=
 =?us-ascii?Q?57b9VW2Xq8XWSGpR7S7RvN45bi2MlRigKHhYrRs0LvMK17GcdNUfFKS+rxWd?=
 =?us-ascii?Q?9jDgvq1yEwRdWZKHVFkrByl3OIPuTooDyF8QnByfPZ2RMDl9q7wQcZqKFeNx?=
 =?us-ascii?Q?JByLZO09AJtCclj4c3kPFzrPS+ivdNUEvFm/7aNkjIbn3+z1WY5V1ot16cl2?=
 =?us-ascii?Q?ovCatpcKh4KwMDxjx8agGPwrgHbnMKjvGEXxOPuS6kjrpsFb4CTJ+EfDHacV?=
 =?us-ascii?Q?kfzduY+H8mOdKvLkCfN/UnyUQLTQn4BJxHkdK19KDIT13MUTidfyhlhzaoCC?=
 =?us-ascii?Q?y7QN/av69eP4viBTAsYHxWgJXlUyndrMyyJCHzPpudota2U8rvidWZYZtDJ3?=
 =?us-ascii?Q?RmHOR9VPNha9JRTVkKNxGAbvXZk/38kzsKO2IRwEa9g/bkyP4/KhIAd3dTIO?=
 =?us-ascii?Q?9hDUKTZMXiVEItbOXAZ06hvX+Lwf+Kg+acaoin1AGyFe+rrVbki5vghwD1x/?=
 =?us-ascii?Q?JZ4+U8cLSByvs73E4zhT7VRlVbEnG5/20jyM26ghaaK6dYnkGMEmgWblH5oo?=
 =?us-ascii?Q?t42/kmE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXawPqTncUO5Fc8EugWMTTc6MLvULCshFzzPcRm+CKomYCStWzDFifRkxYJ9?=
 =?us-ascii?Q?iys/F2qYPIYmcv8+VmcXUU/9Xt0j+neLqtrc7e/KKQXbk40+vZYq04zRTYJM?=
 =?us-ascii?Q?NYxsgEIWJu/TQY8wu4agDaDWhsIrVHbXlvBUkMl0M71kBpGhLEr4uOwPKtro?=
 =?us-ascii?Q?bKjQhfoUHCnXi375r4mj3GTFMVAmO+/sKN9nYsvxkv7YAr2NxJI0ERVqRqAe?=
 =?us-ascii?Q?YwKc8jVOWRjRB4Q+S8OEa71f/E/Ph21roI9BSPisY2Kr95dQl6B8wfNYq98I?=
 =?us-ascii?Q?ChYdo/MRcOPZukd4sQEG1nmdOOaDX5Lhx76EN0nbV6a8Ak+YUoRojiSG8t7b?=
 =?us-ascii?Q?lKHAigcC686BT21vNiLFtZRPv4FGzN5pWT4OhIrN/VASOvZ8N0+QG72dGp/6?=
 =?us-ascii?Q?w8H9Xck+AVRNNJfvo+7ImRkt1MJ07LvQ1a3BZuB4hIb4x3XdAcNXsqrVF1zU?=
 =?us-ascii?Q?MwOijJcOTQhm3CwFW0FLLodc5BjeKIqNI0bUEyUkhvVygK3Qw0pyccIVPo0p?=
 =?us-ascii?Q?j6mMEB0OrH0rRVh0EB/4YpQAkhKVpI2shsASOk5vWZCV/zsGGkDjPg7Bh03J?=
 =?us-ascii?Q?ovTn6iIVNI9CD1p0QfxPdlxw04fh7xtEI/ksKHbyx6BWyTv7W7kSzWXSJX48?=
 =?us-ascii?Q?Rx00DqfYDwKVHCK5fCtn+4LkfsR0P+tik4lrrr6OzOj/K7rwWRPfZp+IU0nQ?=
 =?us-ascii?Q?1jWOCC3yl370UVyPd25Y2uG0Ejk89qYm+V/oaOpUEorMIElXzF3FZSxsGgPi?=
 =?us-ascii?Q?3vSokXcBsMCbXnNfbqOjemTxeUSqe6Qu3XDPTGeo7WXYlmEE3wBFyBZq+xU3?=
 =?us-ascii?Q?MjesmPK43bzs8z0M8bZuRl6bYYzFZY2RJ/TQY1JftgnDvSQ8dxoVa5fO3any?=
 =?us-ascii?Q?NKXhvW/dI31G8HFDBI/erRnPaan1weo6VRpg/pulb0JABpfeFkse7h8owhZv?=
 =?us-ascii?Q?OWAkedUPsVtDPdqUSD6BaC2wcpPYNkBQRtGdAFMMgDBh8LB+txuqG7smuwR3?=
 =?us-ascii?Q?jwV1rplXHlKrUQOymV1Wfcv9w2N9rUmjBkVkgLUZ2fK7vtsCLhAsKoLq54ZM?=
 =?us-ascii?Q?VkstbCoaKNdEUabdIHAsQsCxcNlL2UvgjYkVZAyz4wrDjsN+EfNtfjPzdoSM?=
 =?us-ascii?Q?M4CnH7NjrPze7+4P2vT9acefKdF7fieIgpYzi/vFf+Pq+k/5bPA7uDdryAdU?=
 =?us-ascii?Q?tfo855LbINo5uIPQlBVd6bSC+H0kD/IBRauQAhqV0O6smXYGeLPAwgO6wJk/?=
 =?us-ascii?Q?nlHSviUFrPPOIOGZaCUTCpOxqQ9AlOjZxn2IhwoB9Gh2v5OjjU41sLYy/hqK?=
 =?us-ascii?Q?49aUe+4WQ5TlZSYEAwTrli9LKFmhImoKiiciGA+G4JznOExVUGReSjbnzPtu?=
 =?us-ascii?Q?uNpji8MSd4c+bTDRF5d59rUDya92TwVrvSYLN56uvpD/vAZ0YK5wvEM3vv8z?=
 =?us-ascii?Q?WYu4Rmx9B7/ouwfP8BZb/8jnbLpxvF/qFvMAwfblmfQ6IEyEvZqL7Hg0GKdT?=
 =?us-ascii?Q?xkrxpd4yhfXwSRQkhdSX4WsybGiWeV6juNWoM8ViOmc1j67x9zThhPlw91PZ?=
 =?us-ascii?Q?cice7ctcvWnX7qw2e/sBxOEE978N1G+/mVz6p8RjGzbTZwD5frdFGNgjuoD4?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97909d1-7607-4232-8602-08dcf36a0452
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:04.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qzig9AlGbVMxyRa1bPO2fjsfl8X9GyzfAv48I6T6qub4qCL2UDoJM0L0hRrH3O4g9p4Oge8bohzCGt9jwnHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

The body is a bit hard to read, hard to extend, and has duplicated
conditions.

Clean up the "if (many conditions) else if (many conditions, some
of them repeated)" pattern by:

- Moving the repeated conditions out
- Replacing the repeated tests for the same variable with a switch/case
- Moving the protocol check inside the dsa_user_add_cls_matchall_mirred()
  function call.

This is pure refactoring, no logic has been changed, though some tests
were reordered. The order does not matter - they are independent things
to be tested for.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2: add some more info in commit message

 net/dsa/user.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 64f660d2334b..5d78a881ddc2 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1377,6 +1377,9 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	struct dsa_port *to_dp;
 	int err;
 
+	if (cls->common.protocol != htons(ETH_P_ALL))
+		return -EOPNOTSUPP;
+
 	if (!ds->ops->port_mirror_add)
 		return -EOPNOTSUPP;
 
@@ -1486,17 +1489,21 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 				     struct tc_cls_matchall_offload *cls,
 				     bool ingress)
 {
-	int err = -EOPNOTSUPP;
+	const struct flow_action *action = &cls->rule->action;
 
-	if (cls->common.protocol == htons(ETH_P_ALL) &&
-	    flow_offload_has_one_action(&cls->rule->action) &&
-	    cls->rule->action.entries[0].id == FLOW_ACTION_MIRRED)
-		err = dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
-	else if (flow_offload_has_one_action(&cls->rule->action) &&
-		 cls->rule->action.entries[0].id == FLOW_ACTION_POLICE)
-		err = dsa_user_add_cls_matchall_police(dev, cls, ingress);
+	if (!flow_offload_has_one_action(action))
+		return -EOPNOTSUPP;
 
-	return err;
+	switch (action->entries[0].id) {
+	case FLOW_ACTION_MIRRED:
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
+	case FLOW_ACTION_POLICE:
+		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static void dsa_user_del_cls_matchall(struct net_device *dev,
-- 
2.43.0


