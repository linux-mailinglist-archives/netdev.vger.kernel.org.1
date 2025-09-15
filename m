Return-Path: <netdev+bounces-222952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA79B5735E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE6017ACFC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2B12ECD34;
	Mon, 15 Sep 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZOoHV2I7"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4B2D5C61;
	Mon, 15 Sep 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926045; cv=fail; b=s7Ry3+ZgeBFKnqWBEh6taTDPUfn7coCzSPex3GIYfuUqc7R2Vy7kl7jIhG2ag5IbXnTnaLN3XN/3Gu9EbdBddBeV8+Hp9229zI0a91UXhJPRfa1X4kAgObsVS6fvP5rzd6bsHRrthHzj8eqAR0+218RIu8M7FiZo1FXaxDuGQqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926045; c=relaxed/simple;
	bh=lQ4aatYPPehxx0vsNWfO/Ri9fjYtzoh3Y81B6ErAGCs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u7MB8OSpB+j4onXCiJrHZJcQ7bmaXr8KGqU1DS+ABHpqy0kp/6lUDM/mbORTiYpAuXZFgerr2fIp+Jtx9ZOMYyeQquM78VFt+2R8N6OqbViYqFEEsGVnoqsOU9yRlS7qIkEn5f+LMyqou9W5Gcof7Hs0+XaYDUMSnSoIN8hpxdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZOoHV2I7; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB9L2ZIEqI84rZ+EfeGjszSmQMDY1ORmmPWgt0JmktxA3hDOjgkQrKuEnWsVQ8rrltOroyiHG6mGqDeqiMsqDwvAAgabX5iR3RLmch0bckjA7tFlS3HnSu26M9lvx79WUY4UzYaGh4AtILGeKK8DOaYZnkG160gOD4jgyFkA3rolfJ4gEPzwSyG71sSXUEmELoLVdCETLwM7W7LfE0g1gNyx/GOt0Dzs/K+Ey9dzZlw+lB4k6nH0JGlXEYKtwAckBLcgnV3t1g5IR32PCxLzRAE6eVxazlttevf0eKggxkiBldZg5wnBkxH8b7HkVWm5RrE1SRtEq9kE5HUKgTQEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znwwAll8NY6RVMeyjy12bDCdQqCYMsVSIpcoY9CplhI=;
 b=FP8mitNc47WdFMJgcl2z7DmWfr9PR5znNral6sBNn/brNu3S39TALcsGEOYdKB9AizrKbNVoFhwOZctZlbz3XRzNdjLO4ExMApc1VTBb4aUWUHAnfSqIkLu+rKmSm5v+AYqryD3bcMSUnMJlC5a1RFh497tcj9F8CtqdRpTIeq4JSg+mM0XQKFC3BkNwqqZiLehEd2eJIO+bbgfnFpaZvw+AIe9IpoE3OdtXMHwt5GF2fcm1QEnE6NaP4zjZA6pMk8DiK3bh4DiKPVL1rEHlx/CqPC73fb6dNSHLq3JSzfsH+yfQ3P8knIZllBvAH0VHPTEf0foFYqnDoNnX8thtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znwwAll8NY6RVMeyjy12bDCdQqCYMsVSIpcoY9CplhI=;
 b=ZOoHV2I7csFExI2rgJKngj/5S/fwym4SNqed3yi6TDBhCHTrjVZYl/gSXb7DFSHqL3pdBXIl5XNJ+uID8SNdAui/GYJF4V/FgnoIwAv28vwoib1Ch7WaDI5TlZvLm2j+nxmB4OWqexbzBDpn9zMDIp7X0DI9YbFEo3AYIg6qp3UpMEXgg+q/pDSSztseqGAKwfQSdLhVsimHWcw2Fhx+Fcp27zNhmMpaeo1CRGL/gad4W46e0Q7RZczDcqHMAogNyRIFmaHlD+RLuHHA6vEuNPtD8cZLyIl4rS1qXLZZqbpnV1eIlUxHkIjcW4LxcxSkvt0XXRJGUyDEiRVAGkTcCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 08:47:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 08:47:18 +0000
From: Wei Fang <wei.fang@nxp.com>
To: xiaoning.wang@nxp.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ptp: netc: only enable periodic pulse event interrupts for PPS
Date: Mon, 15 Sep 2025 16:25:28 +0800
Message-Id: <20250915082528.1616361-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 706e134b-3e7d-4dcc-453b-08ddf43479f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpGi7e7T7r5kiyYszIaaJ7Vur2gQuyJnaW1ZN9yKuvYDpMchn5I9bLPW8iRQ?=
 =?us-ascii?Q?NY3frgpVUJg1OVPX8cCme+Dpl4H7CeYrU2ERRaBobw7c5eTHoPO2UiOCWS0D?=
 =?us-ascii?Q?FU9+VrEbjeSdrOjF7TrMYFB4BijxxJZ/cXgpWtCuyFw3lWLvRtO2is7Ekgpg?=
 =?us-ascii?Q?mXa0U7ZURM4Krynsm1jS1xL3cU8ANhEGl9zz9dgw39OaebV2BQ0bYWJMfGgS?=
 =?us-ascii?Q?H+blhfAQpJDyVQWa2tJsRFvuUoZj7+Cq6CX7kcrE8GLKqSXmIuLwXvVuUY0A?=
 =?us-ascii?Q?L0hwlo5XjX6+O7PVVS9AK70/NwYOeCDHJhB29p14vaEwm693nuCcycGROHsj?=
 =?us-ascii?Q?h8lXhZhQe1nCpkzxh5BwgGlGcuOSJ5w1r1da3PQkDLAExVIMrpKj9uNSBOIb?=
 =?us-ascii?Q?sCfmHwnWTuCNqMjC6yfwj8Xpl5G/8p7dPtXG0ZcZbzLu5YCR8Kn/8szfV6h1?=
 =?us-ascii?Q?1GBs7LWb54nhOE6llH/Lu1pFZndfAAjRvYwn98XUMw5ThXIffo+kGcHO+dcG?=
 =?us-ascii?Q?9MIPfE/WS7/tbx0mVLNhTMSlrhWET2xQHRyEoC7akOmq45/PqAT750/a6oK7?=
 =?us-ascii?Q?Q5PofC+csNyCyW1MTL2v0YsLZxEQdlwmW0r+BbQ7gXgBOQLvYM+J8UNwj9US?=
 =?us-ascii?Q?HgXVaVkzg6FR88ia2btZ/b1fEPxiQkU3miTTN30kmhIpnnzG4tjvZRh4yEUn?=
 =?us-ascii?Q?ewU/pNwSgZH0Wku7wnCbX6j664hKWFyt1ViBSIXGQH2+fA3HG6+M22sDtd5l?=
 =?us-ascii?Q?t0XCED3aiZ7s7x1q0YfDOZJYqsIYojB00BKqcbqSQsgoHvF5q3T9B3MpUbLr?=
 =?us-ascii?Q?CJfHuS7uzwhcpRprUoztgU3PJrQuK2DPDw0ndrq5HXc1UcgCxeix+qg4QMjA?=
 =?us-ascii?Q?NoT32TfDY4kPTU239mU58QTofWxXoR6cXAxrpQY6n1Vil1Zfjji0gNgbbaf+?=
 =?us-ascii?Q?jiCnWWilEDL7ivBS0Zg3um9WGY2JK+IbLWerUAUTCIhI59ZtfzxcNLAZRlag?=
 =?us-ascii?Q?v6zCv1f2mjtJEDSNiXyoikPM6UR7Xb33fM9CXYPqEwVMXqM7pWevDt4iWSF2?=
 =?us-ascii?Q?8LTqUvACniVFsEMNwJ8L45EYlgrSvve5Huv3o6iMonaXVuisIG6wbY7wn5HP?=
 =?us-ascii?Q?vcpSsg8gf48HWUvZs4XCPZqZR6SCs3Hcp9EHl30Q3oW0+l5ce0fU8d/8wU7K?=
 =?us-ascii?Q?IhXQS9RQfV6lV+xE0EFnUUoCcbuDDJDED66MoM487sJvEoSyB1JB0Obo8k40?=
 =?us-ascii?Q?h044ULiaQcc4NaBJXasD/qJHvYkSDbpRlZ6ZRKvUp8pRchBvjX6Nq/QJLSAK?=
 =?us-ascii?Q?cEpKxIzxXyAiEYADRkX11t1VrkUQ3XM1ykTTqSJ8ICOowxI0pLryKk0FZq/L?=
 =?us-ascii?Q?GNd1wHaHtLwS8YOPR7J80Iqf3e/PninckZTiRw5erNPIpxOfunWKLYXKlRSF?=
 =?us-ascii?Q?1vF9JEucMbVinGRleI42Oo1A7ST0qQUJkXWvpZr37/5YvFNaZE+FqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DB8uXGD+PoRoVoiVXPr7gyf+D668VoBy9qmp4NBTu8QbGX7hlx7K20N23zUm?=
 =?us-ascii?Q?Xp39dMnJNVmKOVVrvNCguabEmiHarp0PKIlYi+slJgQA2TMiIhj1b8rF6w2r?=
 =?us-ascii?Q?P4yKgi9KBKJRR0IIbj1DxN9ff+4FVKNf0grYhQvRYqG6hh53GYM2fXFhr/WF?=
 =?us-ascii?Q?PyBixlDItNIOsNHhc7Hp3QB3pe1Be5VyoCSvDQFj2GjrDx1+jfXkr5Mp9eZJ?=
 =?us-ascii?Q?5DQRSnXyFw4+AwaAJOmlerMnssOnv8y7UkeVcdUvcN+9GpVB5eK96i9JjVPM?=
 =?us-ascii?Q?uVvjR1goomkSd+MEtbElr1wdnENWlfl+qEWVEeZ2PDYodDBEeu6r52Fd5W9q?=
 =?us-ascii?Q?tz9E4OCgYtLP+5E63Er2ny/cSzcs2Vp/JUk4Gzh1udvrdRdIoY2MH4eWlbeg?=
 =?us-ascii?Q?SBrhHoEyVovKbqPCsQyf8ooGjTcVspS7T4mgdgKcGu8Rvu8kWNEJKnywBPT3?=
 =?us-ascii?Q?sOkWHSXiW+t3+sj4kQjt0+vMeT4oIUd4CuJsFNxilc474nsYmKwdWwUBCRKO?=
 =?us-ascii?Q?l5uOUIdd4EUIyVMi4Zs1OOBshVQpfDBalQOUrpSnufbkfxlYukS2eZpzGncD?=
 =?us-ascii?Q?rw8vBVS8N4gGQTNrkFmydNfYpDV/HWR+uc+3hYaInMjJWvx+TYWiOfNlvrZQ?=
 =?us-ascii?Q?jP8bB4J8lCuz+NtW1ixmplcAkLxabv57Cm1P5a9U8qecJiytng/ULTvz56F/?=
 =?us-ascii?Q?zDKSv/zzuuSugZSioyenr3c8iFOqpNzP2ndCHsxfBCl1XerF9CLmwyWe2AH+?=
 =?us-ascii?Q?ZrKmR8rrPJCtPf4hDUVXH+/O0nHTH8vp9D5Qij5zHDeVCdEaS9wC5aLeUNTQ?=
 =?us-ascii?Q?BqW70zIcmof0qbiq4RySaJP/6fn0CMJhpA8AhfCTWFwZbzYf4lmBWKLKDw3a?=
 =?us-ascii?Q?ooX7YUGCB6aK19Gswr/ShzmU4X4jQFr7PJF/jMROBiYJ0pCiiw12hSVEtT6k?=
 =?us-ascii?Q?NOyOzskzQEeBKZ5zwtgdyN8at4S/3sTb1VrQ1asZxbYFbTVnq5yeSMy4tSH/?=
 =?us-ascii?Q?e9UdiIUf4xSAY4OyvqcQO555SnMAbX7pmOXNVu2UrZHlsbOMY+U4lRQmMQSS?=
 =?us-ascii?Q?N1k63n/cRSZO4hhSH/zN2sVTAG2JqxYpF3jt2kV1xzRuw7F8Vv6pUSL/JqAZ?=
 =?us-ascii?Q?cnhYTg1al+z9U0KNiMlx0dUdOm5DhWUGbzxTrNXB5oX2Kq/hf4Fkl4+rkZxu?=
 =?us-ascii?Q?UovWs9sS7++Hli+0lofLgl0x5qHMWKExDs/ii8THFakPyEY7aOrHaoU1aAp4?=
 =?us-ascii?Q?7EBEsH3ODLtsw4Y3YxSF2La6327JgZVebZsIGMq7rmzbnGHJFHvlbCExnCpS?=
 =?us-ascii?Q?bo52UUktXrENK0eYXFhKdbpOZybD1AMn7Hnuup4AGP3HbbY/KXq4gmlATv5y?=
 =?us-ascii?Q?NgIZtgNqLk09H+H6Am/yVQL6DztJ7E4OVqJi5bTUOzQOhGWEySFNDI8pw8gI?=
 =?us-ascii?Q?ketLnv1SFMCVaYXl6heit6HyvKYJXuH5S8MPY5l26Olf396hODZ38uFvJcLJ?=
 =?us-ascii?Q?dQImIpBev0fRJLkTDtTJF054Z3Lh71jZfXWiI4q9Ilh6Z0hYD4TxtrMm2mGT?=
 =?us-ascii?Q?IS2997bO6gqXuTQKU/gMGybbn5GzYU7ecqYRJfVe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706e134b-3e7d-4dcc-453b-08ddf43479f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:47:18.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRKsehFFR2dnpovAJrDOCLw+FHZb5NMjR0aKtHuiNpO+flMufavz0ZiPD2g1hQAjeEjO/j8M8Tn4B9lrASYIlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040

The periodic pulse event interrupts are used to register the PPS events
into the system, so it is only applicable to PTP_CLK_REQ_PPS request.
However, these interrupts are mistakenly enabled in PTP_CLK_REQ_PEROUT
request, so fix this error.

Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
This issue currently only exists in net-next tree, so the target tree
is net-next.
---
---
 drivers/ptp/ptp_netc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 8c5fea1f43fa..4fefb5ef3685 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -304,13 +304,14 @@ static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
 	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
 	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
 
-	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
-			   TMR_TEVENT_ALMEN(alarm_id);
+	priv->tmr_emask |= TMR_TEVENT_ALMEN(alarm_id);
 
-	if (pp->type == NETC_PP_PPS)
+	if (pp->type == NETC_PP_PPS) {
+		priv->tmr_emask |= TMR_TEVNET_PPEN(channel);
 		netc_timer_set_pps_alarm(priv, channel, integral_period);
-	else
+	} else {
 		netc_timer_set_perout_alarm(priv, channel, integral_period);
+	}
 
 	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
 	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
-- 
2.34.1


