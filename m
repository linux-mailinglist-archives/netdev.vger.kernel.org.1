Return-Path: <netdev+bounces-149421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457DC9E58F7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38F228193E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649FF21C9E8;
	Thu,  5 Dec 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NJ+PMCQ2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3FC21C194
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410540; cv=fail; b=uI+t5EVnbYC1ROWwnWcaPxJAB/m1XEH31flDDDwUNgJcJa0BjFEsOHgwg2xe/0RBiRRRb/akQ+qL2QT9rEqZIC3aPhncDUPUmCYyCWnWEU7MraY4gP9N+NK0x99hKDCpKGl54LBVhz+ZxXugXPbGLMsAULDZ+G2VugQ0+8vSQhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410540; c=relaxed/simple;
	bh=Vi+T0DawDJ9AgnaxjFTeGSrEU37kPYhN3+aDvX8lUTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJlaWYgniGBiezX3ZpaAwhs/+KW/Xw7zY5PNHeRcCChRaTL04D6P41r/ve37uj1y2rMYxCgHw2qvLY/esDL2xQxrV1oc1i9oLPwiKHOqKXOcpJ7hSX7yA62f1iNEWLys2fGj4yPA6xT/VTKcWK76O6aDUR4WerhiJQxoyUWq25w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NJ+PMCQ2; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDcuTKXs9De1lNEuFSdgdS6rW4tdEd3CVHtfg5HwsQ0Dm4M2xCBF9WC6QjURc1JNDURM48XngUBLUO3VqDcZfqYGZNPj/M1zbMNHtv+8wkBOJqSVKhxkWAdWPOuoR+2RiVNra1mvFlEAcjHWnKCeMirujuyAV/Lx+/HJbT1d72+SN29FB2B0L77rEdLaAuMymfnnLJCpymM4eqZ2MTjP8sZ/aYhst9dcyCWFu5XiCvZu6Zljw1Z7Zu8yi4LGdvfTgTKAF5W7EAG9vnUF+UpZNSSNiUDe0EvA5hfShbxXsSOLBoCV3CCzwNGnR6dwDWSRxKp1/1CcAWrz1t5Ic5B6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNs3x6XJpHkc5UQw94PMWTIqrd5arHRRQQnb0GzgY+Q=;
 b=GCxcADi0191/rxF+CQ43Z5vvG/X3xO8L89oyc3FSCdYJOqUDmFBYE3ZLurXIrXU698OQOQmY8DR5OIlLTfolAypSJSsNwzn0v+46YgPfyhYBmMY/f3SstpCYYvFxJONz1BEvGvrpm47JgvWivdSJBaQqmE36DkUT3H7xVi0+Zy8+HbhDcJErebXR9XV1Hzusa8U/4SXIL+ml2ZVlKByrEYhXywlN5DisBlmbHxaGp7UagUrzimknuGRU9LIa2rsV/toQYXDI06VzrTQ6va1sM2FzakDUXUkHmeE1vGDgqSBtDcbFVoxKKq10Dc+tkmR/71uyqFo4vGr/+WxTnHicpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNs3x6XJpHkc5UQw94PMWTIqrd5arHRRQQnb0GzgY+Q=;
 b=NJ+PMCQ2+9q1rX2eFRLwDjqa9jT9sxM+HJ2rsVRCzP3i+JgB6+Ijrdkn5WN96YWGm0rUnFm9k3qYwHQzOqxBKEhQNeebt62aHnQjvzy9R1P3+WvtkkjPdPrxq9SkRDXG9C1leb7M/35Ppu6jUUt8uDDZw+PKDjvcgeOALB2ikBfT5Y4EhBZrhukrVIdUx7J98XwCuEvj+MtA5DH2dn/YHYil//0EtGP1Szq/iUT53lRhJopoXEWlPQ62XApYvEsncow00fpFtsPJDm2hngzRzG+K81pJ5YNpZYEz7ujaKI0LydFwLr0KZSUyX19WX+dDkBM+/UdGSti1w0TvtnvERA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:55:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:55:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net 2/5] net: mscc: ocelot: improve handling of TX timestamp for unknown skb
Date: Thu,  5 Dec 2024 16:55:16 +0200
Message-ID: <20241205145519.1236778-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
References: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6aac80-beb0-4c92-c8b1-08dd153cdd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nAZl1+ms7Qe/RwsuLNO5vMQMAKrQIeTOIgUpCYu5aIW5DVbOO2OdnCqZcUNW?=
 =?us-ascii?Q?fPns5KlPZXihxC+F8aZKDgBzQKOMYOqBWRp3dA4jX4nafOMBgs6KrRqgrmYt?=
 =?us-ascii?Q?q+8Gt2bADw07EME8mXzo1lFoMEBAX5OHkjH9/88IXE49dMotYzL1aVB/szTb?=
 =?us-ascii?Q?8VOxA90EbsqSse+CrTf6YoXQYmLntUh3UNK8uwvLSyNpWGvZxGh1CzLnHh+I?=
 =?us-ascii?Q?QRiKLm5o6FGa8CcgmrZ47uLNrEDIc4Gcw48jMNcc6oBV/BeCN6Ip5Iyhn0MI?=
 =?us-ascii?Q?3Kew6OeEdMnQChYHTF63dAZZhPM2igF019hIFzFKNsd5zNWThMRM94T+AofN?=
 =?us-ascii?Q?W1H4nQ/aBPvWKPn3w6g51xcb3KqUH0y1fCDo/yJkS2Ac9i7arKEk+iXBMoBG?=
 =?us-ascii?Q?DYeMorLxJIlvsqLc1rzFSE61UXHvbefTwIbeCmQTz0udO8Ost1BiDTVnzemF?=
 =?us-ascii?Q?pXWxHIZZSsncJcqWeLjm2BbCCsFlYDSA0BJ/fdoAOTLWQdmd3d9l34b4eQMP?=
 =?us-ascii?Q?HEvN6mUsQ+3mnORWTFOeCbJ5iRFmXVX/IjiwsuDE6Qkm+xJ4If3kFuRvx+7A?=
 =?us-ascii?Q?nQDUgPo/Q3OKlrjAwQvkeyBnTRJawF0frD7MXgzSiv7V2m51a6orPCN0J/rh?=
 =?us-ascii?Q?pjihUTjcIykNlBDZpjAxHhnO6XTFA2SFV7PDeXL12lMPCp4poKk4xVcW+JlH?=
 =?us-ascii?Q?hxGvkBuEXA8BbZFWkNrk+dMYVEk707HE6AmckasuojWiB2kD0cXOEVwjQPgn?=
 =?us-ascii?Q?RaDwzBIQW9kSvs9xgkXiD2HZxJmrDYifNJhXkESoMHH0GfTJkpwM23yw0pbS?=
 =?us-ascii?Q?bHudBd4RKx9PCC1ASKu454blTacf8A5806EkOVZjxLckqAdkfKQFbtLHRtnw?=
 =?us-ascii?Q?Gno+bLgV+MNEZ+QxqjxWqZHxQnaFXSH3oy+zwqfuxEvsc08ID5QFeKfANMlK?=
 =?us-ascii?Q?tF/ttzjLkxYGsC490jhhCcd80IcpvkXW1VtZUydcsgA/bNrckJm/OJRnTiWx?=
 =?us-ascii?Q?h4HH75u6r2AuGru/TjSthnwymo8g1EV0n5GdokKQn06M/Ullu9EF2iwK5I4C?=
 =?us-ascii?Q?cf73jYxKEHIZqJTg27FaHU22vns8tOBMJzJ2Hv7m0lnvQQVCpdeMaZ9YRIM1?=
 =?us-ascii?Q?fIIiDaU6kw6RoRrfBX9uumrnMC4ojG6M/9bz8fHG7cr8mXPHsPq4qe3ne8TU?=
 =?us-ascii?Q?aKojWbCVhd3xED9U3Y4M90QeNaMNR9tQBGg/dnlBmpMubnMWRwlX0qNSvYUr?=
 =?us-ascii?Q?F07H3zZ+Nm0uG89vkc1K3VqObpcUZi7005J2M1FSTkz4lFyDLmOyuC/l9Fvz?=
 =?us-ascii?Q?C2k/a7DzQvKNS1/XsHj2+wjWYvTjjnTtLPKEm1EWD0mYUBYHll8VUeXPXlf6?=
 =?us-ascii?Q?N8dBBs50aZzVCepW4GGqt1ByNwvk1bQFRy1/TSbKNEtIJTwYeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?enA/1MBeFPLBFSUYk82+RLlh0MB+3jO8fagt2T7itzH+O1wSTOke4suVNUvo?=
 =?us-ascii?Q?PJvP4Q59l6aIOKEhGKUR7BnxzRxYoIhoc79BrqO5aJHoiZnNxCdklthuvscJ?=
 =?us-ascii?Q?ePR32HZadACDmwqxGozNOnik0BYvNHwOM4os+N8NRTHvdAC02PB+fnq5/HP7?=
 =?us-ascii?Q?DjCMroaG4vvZrsg7mjQNyPpWn8Ri6XReUmrJ5xVruAT3bTFdWnMF3M8ONaz9?=
 =?us-ascii?Q?dQMY5z+3FNoYq7ImSwt7f/Q4WRln5vajSMzOPcCdZ4BcIXgBR/vdB1CNXJ58?=
 =?us-ascii?Q?MzoQQlOcYGjlNMJ3ADd8jq23Nds3ASYU3INWwj1VwaOYoZ/AIp11E4sJ6JpW?=
 =?us-ascii?Q?1NCBU0zHzOE8P1y4V7u1Onp60bqKHnp5RCRE8vaQVUo9vasWBlQNb4iPvZkA?=
 =?us-ascii?Q?reIHNA8aY+2WUtJHaRKwFcsx/pR+eIQLaI1+v2hJHHaaZsoJzFgDsR3sy4hl?=
 =?us-ascii?Q?riqM31HZoGtYtVB8Kjzte2TV/xNHPeVxpjkfBLcnPUP39F+VlRUBAdNjEW/u?=
 =?us-ascii?Q?Q5/uu8dsh/Eg7LBa+6+722Zmy1ZuHFW45EsA/mH4BV+3IHN/GfQO+wJm4jxG?=
 =?us-ascii?Q?/LBGFRBHKIFEt3XWUp/Z0xXG2Z9QG6C57ONF4SYD6e/bSiw6tm3BjlWsZNTP?=
 =?us-ascii?Q?bVdPO2A1dCTiTtjxFxJCyulnmnISJhmXnl+CQGWNNDTQeU0LmBklFecZAf69?=
 =?us-ascii?Q?hWpYL4Tymgj59YSJL99YhJtqECkSrInR5rEHIfAzu31vuzoP0MOzH6dTHB/U?=
 =?us-ascii?Q?7yTXLevHrNDCub5XQdN2Hy3HBMi99Z4DUw0CRcZ2dGqq/gpdZmuCcpZlhnF1?=
 =?us-ascii?Q?ltEMdhg5A4zolVsKy7zc3J/bjvux0SvlD04HDocyRXFByuqjnXaonzCABxLa?=
 =?us-ascii?Q?kz82IhogqnV/CDyZWKN9bazCfL9I6yqXmGjRHQImbXiTLOJLBuTIyGwPVkyl?=
 =?us-ascii?Q?/AGx6OKKRmoinq9XK8tYPECtwGk8Isw6RMwcdVX7qTfADqFzSrZHYJyDvgJe?=
 =?us-ascii?Q?dvPsD6ZeSLliitStARqnIRdHFx2rRQpMjOvBhH8p7I/izBTjJCTnKuwaWsri?=
 =?us-ascii?Q?UhkeKpChlIQ2U+m+NsbKRSOk8i2Rw1NQ/8N+CC5xC6WdG8oox5Jaba+HJSV5?=
 =?us-ascii?Q?ugPdr4UOAclmtbkzcgcWt0ql5WimXQwTNdBk/Gxrex8toJyOgCBPNSkx2ROJ?=
 =?us-ascii?Q?pJDdQHkUZGTaQ5uHFWRU/0VcWePzrvZKPMSokaG29XBu3vmIDsFMqmqF5IJs?=
 =?us-ascii?Q?QRpgPglrHjYrTu9qd/+J4eGEIx8yNnOcRigdnVCtDSri0A/4CYonqHKQe268?=
 =?us-ascii?Q?FpnJktACusDp+EyKwOuyaLYiZ7k/1Fxsop3FQ2Ntsn6SOZDzUlj9k4IF80jq?=
 =?us-ascii?Q?zjsZio0xnrMF1Vo021CICGOSZyPlDhTqrMKNIWo20K/jf3Ej8GnLH26bcJ1M?=
 =?us-ascii?Q?/RwbymiV0K2GCmW7l9M2vUs6y1uM4gAc0jX1//7P5x/KRDP5mYvVAEDp8SQ+?=
 =?us-ascii?Q?i85No3sObOFFmgjqipPrbSqwfHxxzKCj7fEIAYy22Vys8EipNX2E6b3FCQFs?=
 =?us-ascii?Q?Psu8dBv394/vduNKXQPk2S3fUffUEH3YIG7o0MUWBtLDnJtAATn+0i+wETjG?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6aac80-beb0-4c92-c8b1-08dd153cdd25
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:55:31.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03H1DOh8zKNg6gs7Hrv88lWtPEVkVYQzzbQR73BFFtdex+tqE5rZ2pHnZuB5ZthsutE7kr/1G9uysHIsdsZxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

This condition, theoretically impossible to trigger, is not really
handled well. By "continuing", we are skipping the write to SYS_PTP_NXT
which advances the timestamp FIFO to the next entry. So we are reading
the same FIFO entry all over again, printing stack traces and eventually
killing the kernel.

No real problem has been observed here. This is part of a larger rework
of the timestamp IRQ procedure, with this logical change split out into
a patch of its own. We will need to "goto next_ts" for other conditions
as well.

Fixes: 9fde506e0c53 ("net: mscc: ocelot: warn when a PTP IRQ is raised for an unknown skb")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index db00a51a7430..95a5267bc9ce 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -786,7 +786,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
 
 		if (WARN_ON(!skb_match))
-			continue;
+			goto next_ts;
 
 		if (!ocelot_validate_ptp_skb(skb_match, seqid)) {
 			dev_err_ratelimited(ocelot->dev,
@@ -804,7 +804,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		shhwtstamps.hwtstamp = ktime_set(ts.tv_sec, ts.tv_nsec);
 		skb_complete_tx_timestamp(skb_match, &shhwtstamps);
 
-		/* Next ts */
+next_ts:
 		ocelot_write(ocelot, SYS_PTP_NXT_PTP_NXT, SYS_PTP_NXT);
 	}
 }
-- 
2.43.0


