Return-Path: <netdev+bounces-138269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883BC9ACBB7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC13FB22273
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC91C7B9C;
	Wed, 23 Oct 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lNInH8wM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A81C57B2;
	Wed, 23 Oct 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691600; cv=fail; b=FA+3fD5L2F1UXgr6pvK94MK6l1JtF/MpyOEyZ3QkkLC+A0uwC2uft29KEyQQiU/lurxC/CjsyxDkY/8YX9SDeaH8ZWmaDkogAPvBo6N4NU6l6yvbwMnggGT65pO1dswRZ6Y+uTZa92ZBX8QlfFgt9U4NMqXa6MgoGpYUaumlf+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691600; c=relaxed/simple;
	bh=lrGkvdsI6XLjEnZzrR73ZfsBLSRkvTMFWldVUxxDBjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWRbESiaRd+ww2XuvtU33/jqC/9+rbMilp77/HvfAEjUkFNhiEfp6RjvR3Ot7HLh8XaEK4YVEsa8lTFDC06U3IhoOd3FdxHiT5tp/WSzF3RzSm0tUv1qjmfAek5wAgsVkyH5jigroUnTkrHZ65HPeHHjAFV4qv9a72Z5oEr9MAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lNInH8wM; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEloULr0oWz26vQ1ggeFaDf8dlNTTckS6ZdDS4DsfT+1xfaBofBS5ch9O1ZLsWUo0hgdK4IwG+83fVlBwMTqk9IEjndi0KPtnACehkX+k7ggEXHWVEdyhTu3w/1K9ocG2Ssyg4PfT4DnkiA7Pe6ltsjUbT5L1UkOlAG39gEA3Uzm1jzBhRpSUyxhSPfG7kDSCQTQn5l9MUXFTIGVFfPsnrGgxGylioEseyAEH87vo7jGBzjdRVhReDsMytf+pQQDNvTYO5zIVfWVlTr3gKkscNeZXN65JkXBgSBKdq0G+5n5oCpCFUb/cvOv5DKMzdQC5CHI2+sA2/gq9AUTdw4Krw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxg9EYijX80sgLTTaQx7ElHE1MHgP92O8KU++Jqszbk=;
 b=oBC2Ok08waQjLGFKYUY1lhoZUYlKcWuWqMcdp7jxYgTwN19AQLkNcVynnjjccjuMh9uMok1dsPLLocEuklp3I6+wYK40t+1OaBnmLxrn1cD13BHimEA4gQY+eOq6yNo07cRVLrsXX2zyBIp8tRf13XtmNvz8cAR22Xs0gbxNUdlBEVr3oCh5xPISidSGRjoH71tys7CYwGqxZnUQZKq144qY/kkP02kLGTa3hHR1zLrXm0Hon2FmrZBKIKhV9aQQZCB2E5lPtEa0RTPXNa/LzeKqehaNYBjYZeqhWiWWuSb6wBzYaxdlqwAQblS9UBeb1ymNTiqq1E3zixXIHOVe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxg9EYijX80sgLTTaQx7ElHE1MHgP92O8KU++Jqszbk=;
 b=lNInH8wM+TzDrSVRQw09wJhrbseocEOkS5ZX45btIVUntEiGamASm68YR/nL5vgqzstrXsbnWLSN97g1ukE1Cx60tlar4V5IaTXNP010c1J8x8PZoT/0PZXC3qiqruAFGsinBWkBC0lHq7qGC37ajpunKKt0WUwTybiOSDeRec1w0wS4+OUubi0mfgv5KVov0d7uiiaS3ZbKv1Xs7YMOXOhmRjK7EgK9pkOuw8/en3EcM9yoFztOLHzAaICx4WGkyUiW7GyD7eTAGD37JM4N/Us7CuhZ5iy/TyzpECtR/rRs39WJ8WjLgQo2vMKuom8x9OEXwpYadTeNTVwmjCHSDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:53:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:53:09 +0000
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
Subject: [PATCH v3 net-next 5/6] net: dsa: allow matchall mirroring rules towards the CPU
Date: Wed, 23 Oct 2024 16:52:50 +0300
Message-ID: <20241023135251.1752488-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32c9522a-1acf-4874-f62d-08dcf36a06f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZRsbP6jscWG7YU7cMPWM3EX4ncsCVWr/fajgn9a+4/RrKSQxvvxanCU2rdHy?=
 =?us-ascii?Q?oA/tdq6+MC50lyTHWc5rRxC/HuAvABqDtygPfg8SkUaR7VX+bKjaopZSSxWO?=
 =?us-ascii?Q?H2pvTMYiUG+xAlLjKuEvbcNxE2GA+MVUDvz6/z32pUfnRY0PhG+v2cLwMc44?=
 =?us-ascii?Q?cu40HIBTiKTXxEx1KTXsK3w4B3QL8B2CGE+qCCk3DVfjBO2rgoGLo5CUO/OL?=
 =?us-ascii?Q?BS2TeUDrMBqngwuvLWmZiA2G0nZnvbLfqUlWHiPg+0pUsP9vdwvHhuXIiJOh?=
 =?us-ascii?Q?e7KpOzxgvhHEDlbKApBrkXfpPjoeOWx3MoRl402ZSWIh4THVdKbGLRZk/b8n?=
 =?us-ascii?Q?zC64vBXBiQ0CpqmX3evUfMgWfnyxHNmxSj2dcFgjZxSBHDaBA72lui+uy9xT?=
 =?us-ascii?Q?qMHmiLuv7HHLljAbMcBwAGeFOTVvzyYd2Huc9Zhh0cqA3PoTWoTU2653zzTK?=
 =?us-ascii?Q?pfmaZEEYnDUFzNJK1Z4HNd/9zIcSQy6gRbDTTDNFE0UaXy1x0fYguIlXUzr9?=
 =?us-ascii?Q?P7EoTP8CL7HilHkTV8vy8lVriaW1zjmXpaNvxHkLlp9LHMVsMlFvmwCcyYT1?=
 =?us-ascii?Q?EWlEohr39Fr4dAy1eZUnbZYNZuqJawYKftcSucyiXkBRaEWe9N//hyjOm3c2?=
 =?us-ascii?Q?1QDQS8d/gAiTPXzozmQPtS9ZU1l8DkbA703VDknW/SCIbw9IlAfkIE63NbzJ?=
 =?us-ascii?Q?G1JuT4KHh1Mg0d8hEEtsPpj0UDxOdSdS65rXUy6PjlpCUeeDBIvMMBN1qxKG?=
 =?us-ascii?Q?O6lciSHGF4p+WtuLMyPNhtrVYTrG0/KFwFxwJSQclSzQRVFQNXZ9cXX/ECDE?=
 =?us-ascii?Q?XUWHpgW6YY0iKvqQrxHZm92WsgLsgVGbKRWchC5SXai3AwQO1mBV30gRyp3b?=
 =?us-ascii?Q?SaO5vlPIF2WmTOitogporeFm1w0uYyoADlSbnFhIWNJjsHknB9tfOdpqSnHP?=
 =?us-ascii?Q?I5h5IzaS8hxpy4KK3avXAY4wPXgt0svb3bzbdvalI93cwXIZWcEcvzblcbg1?=
 =?us-ascii?Q?lvfvoARB0JtalsLmxDRrtVFkAChoGCx0VUE4Syp8gnapQDqxkZqBiqWAmg2c?=
 =?us-ascii?Q?eINpu83AuyjvQqaGW2fcoFW7zfpPoSyKKYeyKAszUl7nmkv9eKpgNHxQvAvN?=
 =?us-ascii?Q?7zUHglb8YIJLuCEMYaO8MK0rT1VEqT8o9M9Vn804nmyDhFZ80iIngfml4mAK?=
 =?us-ascii?Q?eMXriK3XT1wPgQL5g86IuVwur/0yzOC1Ucioqo6eRd6mV0e/7Y6gfDzbviN5?=
 =?us-ascii?Q?E1fYEmtTqDVziCRIpswit8U2MbW2g6mNbBs++l2dkUdIfZjR/MvjyR0EyKOi?=
 =?us-ascii?Q?w0Jimea2TjRnFvr6KcqE80b6kFUejW5YcU7FhwYXC7xE/EBtAOsFTN8ecuQI?=
 =?us-ascii?Q?kqHg6JqkJVELeVOJcE9/BFX7n87G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQd5YbzBmLXHsMoPetK36PstV9NWMN2CW+HdLK9J/Zyh37wxz1LnkaepcxDE?=
 =?us-ascii?Q?efokZeBD+3hEpg7w0Xq2C1oR8yw3LNFeSrdmDqFrmujdhmF3h2MqVNHhGB/6?=
 =?us-ascii?Q?i/gyMEnwDcqCKonvfEeOg7gu5PdgFZr/L/PVvc/pQfk9daxpbWb3c4zCypBx?=
 =?us-ascii?Q?P9nUDa4Uh5ub+gWuWjZt06XcsnHZ3v5nbjk3X9YsQUOX9arVw6Ll0ZoAzEz0?=
 =?us-ascii?Q?AnOppZKZZiXdxYOBOeMgSaMjz/ACmbpLx5G9ezwOXXftxGI7iyrUgK3c0xCl?=
 =?us-ascii?Q?9oLFcnQfHOEKZy3MBBAMmyRS8TuVJUpJNbYfo0D4Aa7+6hbRD5XIDDcfRIxa?=
 =?us-ascii?Q?Ax12ty0F1ceLFIeeH2ojqvnY3wvG8IdxlRSiyn6cvSWi5AWxXRhL0qPJDnZC?=
 =?us-ascii?Q?Ne84FlyExy9U5fCwhkEQA3xS+Bsul3RzRnwYhVrYWS/m4JzFzXx6E+xQmGvU?=
 =?us-ascii?Q?PRLeTbquee5BvubSkSINT8K3YOHycjKGsOhBqbfSyaoxqpwbIjqG5jCpHuj3?=
 =?us-ascii?Q?h9EYt7KSanj9VQHOSmtq3tg4tHDcQiJtDcODPEmF7ZD/UzAXmVuhUWS1dJ1W?=
 =?us-ascii?Q?22OUwK00BiIeYexiMpgMJ3efy0dSkiRZFBTq84uwRnQkTG0wM6Xmcfwa96Em?=
 =?us-ascii?Q?1JNQhjMjxMW4Ajwn2KO1Box/EczMMc+NteQopVNc/uhTaYcn5N3bspv7r1DC?=
 =?us-ascii?Q?y6jgxfkA+ODgjNxzXmnBYNG20cMFpCoGEeVrOVg4+vlvhLdfnIiAUISR0Q6M?=
 =?us-ascii?Q?m7KeMMAxrvznjGsiqdYsTf0Gg950POkr0qbyIb0cSxifPcl3bvGry+p001uz?=
 =?us-ascii?Q?c+eO4pkDv35qs7u0S0sEwXU8JHcUqmkem7vwQYJUVRSJj2yxEcVTbBF7dlhS?=
 =?us-ascii?Q?YZMYFj3xAjG2t4wJMnHzB/nw5plzoSBSIm1H7A479hrR6QuJ6FCU4ectHD3h?=
 =?us-ascii?Q?JZCTxXaed+n4D/+qi1VsndcoYCkFTD0gD59zE+FMp/s7oJJ8gk3TQC2qfiKE?=
 =?us-ascii?Q?itvVGmt5IMg0vO2RinPEly2sPLfpxqOJaFvDpZ6zlUhMPCWt0xcR2JKss8xy?=
 =?us-ascii?Q?AubhLQ7DeX0GV59EVXKK3AS62xK3PszOcOSIKO44yWBYCzhRUr6+o23Es0xp?=
 =?us-ascii?Q?7AWsJ00JDtzkOBRi2PjIZi0Qyp9oeLesunTeZ4vwMSaVGEjhoxQeUM7T3tNh?=
 =?us-ascii?Q?DOfnemZY7XoACeu6R8BwwOxejWt7VaVqte2szFptXhA5YQe69QTsQcmLaLHI?=
 =?us-ascii?Q?RfHl1sJFYPOPMK+4hOlcIZ78XPm2HBzVuv0Nck+oPUDwx3bpo2gaI/tfWZAW?=
 =?us-ascii?Q?WUmEBAL+YR+tJ/V7NwvwWbxZCcNkEGOY+7jNEBSLiC9ZJg+0HdlEhPHy2Pgu?=
 =?us-ascii?Q?Di0Sl1o0DiM+fi/S65uUvBw0Z6qmVuhBH7p1uzMatMDWn2m5R31QoA7N7pT8?=
 =?us-ascii?Q?IncD05ls8CuA8NJsU61RcBTOyejVadUPc00MmfWRSeHD+XiwrBW4Ozh+Y8bH?=
 =?us-ascii?Q?hv+8Q7EvNZuYZIt8YP4/2Gu+kBM1yrqC4ACvcJhVoaOGOuTUpfcbNzIqsHuV?=
 =?us-ascii?Q?RFrcEdOvnL6AwTKwz6sKPY0Y3GTVsbOgrugJ2mlHdtWR3pwQWEmg8DmZc6Fk?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c9522a-1acf-4874-f62d-08dcf36a06f3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:08.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dXe9QsUIaCOt8Mjxg3KuF/VGAJj9IW0R3KTEUAFrLWfkWxSaHEOjCu4prgeUu8p8DWeE2c4gRVEQQwG2XfNIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

If the CPU bandwidth capacity permits, it may be useful to mirror the
entire ingress of a user port to software.

This is in fact possible to express even if there is no net_device
representation for the CPU port. In fact, that approach was already
exhausted and that representation wouldn't have even helped [1].

The idea behind implementing this is that currently, we refuse to
offload any mirroring towards a non-DSA target net_device. But if we
acknowledge the fact that to reach any foreign net_device, the switch
must send the packet to the CPU anyway, then we can simply offload just
that part, and let the software do the rest. There is only one condition
we need to uphold: the filter needs to be present in the software data
path as well (no skip_sw).

There are 2 actions to consider: FLOW_ACTION_MIRRED (redirect to egress
of target interface) and FLOW_ACTION_MIRRED_INGRESS (redirect to ingress
of target interface). We don't have the ability/API to offload
FLOW_ACTION_MIRRED_INGRESS when the target port is also a DSA user port,
but we could also permit that through mirred to the CPU + software.

Example:

$ ip link add dummy0 type dummy; ip link set dummy0 up
$ tc qdisc add dev swp0 clsact
$ tc filter add dev swp0 ingress matchall action mirred ingress mirror dev dummy0

Any DSA driver with a ds->ops->port_mirror_add() implementation can now
make use of this with no additional change.

[1] https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: s/cls->skip_sw/cls->common.skip_sw/
v1->v2: allow mirroring to the ingress of another DSA user port
        (using software)

 net/dsa/user.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 2fead3a4fa84..6b718960f40d 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1365,7 +1365,7 @@ dsa_user_mall_tc_entry_find(struct net_device *dev, unsigned long cookie)
 static int
 dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 				 struct tc_cls_matchall_offload *cls,
-				 bool ingress)
+				 bool ingress, bool ingress_target)
 {
 	struct netlink_ext_ack *extack = cls->common.extack;
 	struct dsa_port *dp = dsa_user_to_port(dev);
@@ -1397,10 +1397,30 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	if (!act->dev)
 		return -EINVAL;
 
-	if (!dsa_user_dev_check(act->dev))
-		return -EOPNOTSUPP;
-
-	to_dp = dsa_user_to_port(act->dev);
+	if (dsa_user_dev_check(act->dev)) {
+		if (ingress_target) {
+			/* We can only fulfill this using software assist */
+			if (cls->common.skip_sw) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Can only mirred to ingress of DSA user port if filter also runs in software");
+				return -EOPNOTSUPP;
+			}
+			to_dp = dp->cpu_dp;
+		} else {
+			to_dp = dsa_user_to_port(act->dev);
+		}
+	} else {
+		/* Handle mirroring to foreign target ports as a mirror towards
+		 * the CPU. The software tc rule will take the packets from
+		 * there.
+		 */
+		if (cls->common.skip_sw) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Can only mirred to CPU if filter also runs in software");
+			return -EOPNOTSUPP;
+		}
+		to_dp = dp->cpu_dp;
+	}
 
 	if (dp->ds != to_dp->ds) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -1504,7 +1524,11 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 
 	switch (action->entries[0].id) {
 	case FLOW_ACTION_MIRRED:
-		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress,
+							false);
+	case FLOW_ACTION_MIRRED_INGRESS:
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress,
+							true);
 	case FLOW_ACTION_POLICE:
 		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
 	default:
-- 
2.43.0


