Return-Path: <netdev+bounces-233761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA787C17FD0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D2508D98
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D282F0C6F;
	Wed, 29 Oct 2025 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ai6wzg1Y"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F02F0692;
	Wed, 29 Oct 2025 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703299; cv=fail; b=Tw9q5xugPhJ/5Ab7Zxlaog+ba+aKuO/W6OmQigMJETyLWv//Og+7ZNOxPJu99P6VK2tU0XCcncnf71fszt7kCtQ0TaFd092mCZczHKjItOMr4euKv5LWYFRMzcOvbeQnc1DwW+V5whH+T3rSVqejqYd7WSihDGlIHCvmekiYqV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703299; c=relaxed/simple;
	bh=y5AzvqJBGVK2JRjUw2Ta5A5ORE70zYsTcrawD7NIVfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNDibbd1eLwRGBsHapxRilitqf/6JrE9wXZvxXO1tLjCkpLdVJARzC/ivgEA4/LkHpYjD1c0ew7hArvuzbp2OeyTCOLrKNDot0pfeIqQ47xVY96UFHkhtefSCOU2XMO6sSZ9Y8gJPtbo8Q7y41bDOlrkTrJghgBIMcdNovYI32Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ai6wzg1Y; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3y8Bx1Dr0fJa3bFECi0vhOha13MKT+2yFz6BMANMhoqs0kuVOxH7sN9iikMM7Vgc4vewLMA7Nh+8zvH7XSJtf4P7SEpiepD3FzFtWcs2AWO1RzfVAzHvvEksEXU+G7yUJ4iWlLFITUzJ6hwIxUwDf05BvyQlmxN/GAYttTEGQ5hTP12I3PFkQ4DoyRldLL9DGwZ+BPSZ06W1bJ6Z8nkOGTSpiafIDdjBzxu0AHVbQssky+1ytRjVJW9g2f0EHzY7/4ai7uiPqA6IK8wumB6VQojYjGt5mzzlvaWW3U6z4JoLRg/9dOsP6JqKNHa7lzDOMAvfMbm77DtlMbGsw90kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tIZYSwu3uAvy+ROWhM3Y7k5iPFcOt7S4qI/UVNOhbo=;
 b=WL/7w+er86e8edP5aLN6PNTuDLumCoU4Lv6QnP0B9fiO2L17OrgsrBbPxURjXXHprOZkML86qv0i8BB7I1ZKtQMEYyaK6lFaGHWGUIRvmAMnJ5qjJjkUY538LRgiWuEMRXkpfwTbPgsByMwF4DmSwme/wNcw9bG2f1gZHwO6/UAaOlWQq/NU0PGlmKjngAzqqdE1LNiPzRqT/bYMdIC/JIZ8gh8YzTWwUvoMVn/1w+LwJyiH0gzAs8t3pS/Jr2ThXZ9yzYjIH6RVSPy3lGOEws1FmjZPCpcbLCOPOEJLeMILQbO/tZXI7iZA/QHOWa2L6QXeWBly6d4IH7/nHM2zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tIZYSwu3uAvy+ROWhM3Y7k5iPFcOt7S4qI/UVNOhbo=;
 b=Ai6wzg1YxFzdhb8I469tGn1yCLQfLcRRJG3oSya37+JOXGUNJdxABdaVZ97NbD2rhcxViIUstwIXO0Y1RFOmq5Id3MznqJZhnK9hBqwF1hOTA3xTdoAYNZE3KBT/vmbwzTFyFmgyaDx+LMXN7IyZdEOP+m4xeUmdJyuHznAtPrQnwHf+WIiDfRMiJApqlnopGLVOPx7vMwa4rGTa9xeo5C51o6+4bGphG/FYmqg7zKHyG9pizGeHaoGGtw0L8fGvEd4EoDrlYSc8waqe8X/d9ptRlx9iNBXyQ9ROsOOnACxi5ek0CyFb3XD6QCkKAd5J3W/uer4hVzN+KCii8pvtVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 02:01:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:01:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 net-next 6/6] net: enetc: add standalone ENETC support for i.MX94
Date: Wed, 29 Oct 2025 09:39:00 +0800
Message-Id: <20251029013900.407583-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029013900.407583-1-wei.fang@nxp.com>
References: <20251029013900.407583-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c896e7-6fb7-4f26-62f4-08de168f1660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S3hP11j1Rt3+apEmPI4BAQ0cCLqgegdlE3vBVEHjn9hP3cZ8eGW2Sr85V/YF?=
 =?us-ascii?Q?DqnDMyCK0pAoE6uQDt7BC4wwCOQN4QFLsO6RWGqytFVkvNNbgpoMSeqMCfe7?=
 =?us-ascii?Q?odhZYKVyScOs4vS7YjB8mV7SC+cKV2QI11vBLQGONE46rx7xdYwFxTDR3Xum?=
 =?us-ascii?Q?AtUHVS3uUA8BeAhWqgFQS9zwUcbB78yfZIO6qlVWylTpJUy+daG4OtxnxY/g?=
 =?us-ascii?Q?EYfPFOUSwMyntcG/53NhgnBqpEVnOd7udtWjF9RuDx41eJRCOz9EWY3U7B/m?=
 =?us-ascii?Q?dC8gAlB2isKeUDs2MzjN6hLV1k0nFHQu5yy5XfX0mBA2JwW6BqSu2xc3S/cH?=
 =?us-ascii?Q?ze5onwOFPvCqmVn/bhdG9Dosg7QEQbXzFDQMdhL5O0okFl9UgykyrkM2JWjI?=
 =?us-ascii?Q?uMR46kGWfJwTmrzDJ1+BGK2Nc8fW2Ou8Mrd9L+DgG+boTejGjnr3UeA/ibrl?=
 =?us-ascii?Q?qxl4oIklc5xEr/Np3wHkQtSliy9WIeMAlcgxC1mHNH93trD5dLuu17Q6suzn?=
 =?us-ascii?Q?MR5oof/C2/5Z6YoHI+xNpXK2nWMh1znGS2+626NniTe7szweG2cU9/If8jWE?=
 =?us-ascii?Q?XcP7XgTjNkAWb43JAg6X4TLTagT4X3S1IIB8tA0ZxOeh4Y3KiesqKf99RK3l?=
 =?us-ascii?Q?v+a57Ic6V1ua/WrClDupF53uOvpQ/pq26Pk+BdTyUCLd+ruegFPjCD3cMFHz?=
 =?us-ascii?Q?O7WexC+u/ycWK3gqgbPw9Uuo6Sx9Y1FD28FVASZzxn08QqeA+v4tv5Ynv25S?=
 =?us-ascii?Q?vNxXIlgUwBj77cTn9qKRq20qcm1cXNYFJB1L9mixQkbOCpUX6XROU+mX51/G?=
 =?us-ascii?Q?fFenAwqYgKI50iMt38Qd/hwtDr+Dt7QucQQi6Bf2z8//LKAp1WFdC1wrgIZ2?=
 =?us-ascii?Q?GiHafgnr5s7ufQauJ6CPYzAzYYPS6IhOhCMZlmmUe4INy1lykNOy9rvYGRqa?=
 =?us-ascii?Q?ZbKhcijqOyK1KDVcbQ4Oq7fiKZ3APBfm44VA06kez3egobuDegEiAbhpytzU?=
 =?us-ascii?Q?ZJ9aRv8nmmlM0j3f7AiLPALCawNSsXA38XgICBwIZ5K7785oidLu2z464zFh?=
 =?us-ascii?Q?/TOk5qVcDGC4Vym3mKZUdGwotx43a0jwIzshLRcV3rUqFhuLzTHb8LZMv4mR?=
 =?us-ascii?Q?vHFIW9pu32sXEEZMQGcXBLPWhxeSqjqdKWj2hslIFpltpjMvPFcdkoFA6AU9?=
 =?us-ascii?Q?w78/fUUnVkDRv7sOlRDiwpDVq3mAyj6BzDEJb7Y4W/o0OXFIkyUkKRAqnc2m?=
 =?us-ascii?Q?vBuiTFsw6rgAx5U1Yu+esGE8q2NLLKDnyqNFpnxSAXsv3Oy8KhNOgT1RpZlD?=
 =?us-ascii?Q?ynIz+vgQsgTB9iRjmAMhPuMk0UdAT8o3IhyNf7iZCgU7n84Js30PiEW2IlpV?=
 =?us-ascii?Q?n7CczwaDINk5Wn2+2VO+ZjMHbEwBeFTl8DC/ZRcZWkYNoqF4kjpkcxlpJ1q2?=
 =?us-ascii?Q?t2NZM8nAn1Y/xQ+iBZKPFUhLwUxzpuFOayuytyGpVSY1Ubhd9sfS1eYAIwDv?=
 =?us-ascii?Q?Y1o0rYOuI8CuLlF7/j4UFo3tv8bGaNPRzXYt97KGHeHofMI1AkYBlCyrvg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfsAXE9aHGha/04xMYYSvCUT95gN8ZJNeEwlHEQfQ+s6fnur5/T9Asy3sPWL?=
 =?us-ascii?Q?Hs3dg6MxStmAW11WlaBKNPikItG8Xjnk15xHi6pZcUnz45mJZb6IGxjnlzs8?=
 =?us-ascii?Q?6/UprAJXtcmIgHyyhHwYfkr/Ur2bqbkp7mog4YtvYas0zD2Iah013z9Atc+h?=
 =?us-ascii?Q?DodpfFQuQ/7Vbe3W8oIXPEC0SXhbdfNzrsH/VuOmSeAykIQzTWNVZMTJix+l?=
 =?us-ascii?Q?uWAmf7X4QOyR88U5GjqXEkDZMKvLJBod1d1WFz/h0LzkUZ4vnXDFtAOSvvim?=
 =?us-ascii?Q?SIJoYIU5A9q3QBJS08xmnbIMtdCo0pEPsjsoJ6Y2ElZ19S3gRAJeLIVamo88?=
 =?us-ascii?Q?vB4NBstURCkyqsKWaSd4iOIMOrCKH6WGkjH4awhvusiPUzWlbbp30uD3k0mf?=
 =?us-ascii?Q?Avw7zUQjXDUhN49Nh0SXtiepyGVrd6SnQHZL5QPutgdaH8kBidY4vAsWvtOc?=
 =?us-ascii?Q?ICaqdObNj/qfxgwrybkddZPqt5jPnaPNHeNsbEoWFyJWyNtbkpIn4w5T0VUS?=
 =?us-ascii?Q?ww4KphKQwVGyfKGtxSwTWXxuvWLtTYAF51acZifE1Ab2/mO1LZTVFFVSx2+V?=
 =?us-ascii?Q?XHvjwIl2FNji00BixtGEOz99jg0QZMi1rcY+Z3KtxRLjhVYwLCZpifzIIm5l?=
 =?us-ascii?Q?th/TA2xOP8lM3wxLmfmknW/T+VjCaYJPrHChoOxQZpwdAme9j6iuxlJ97bBt?=
 =?us-ascii?Q?3BbeCDDsW8SHdZFc6uOe2/DEbz4DEU+wEpAVHtEd9nqBebbzA1xR3kyggGhm?=
 =?us-ascii?Q?k4dILgPA9l3pgFP5SC6sw90hu6JrZUBvbxBqXj6X3tPEqxOKp1QSHkn1TUrr?=
 =?us-ascii?Q?AMCIXPs2cC0/y4bmP5aiOght6OxE8ETNor7LPLBvBbJyDv0+gJK25kCGcTt4?=
 =?us-ascii?Q?DPJRTTG7vfnMWGtorJD8QXkD9lmnHDowIsmjMPAy3eqs9UAhSDcUA7NP48qQ?=
 =?us-ascii?Q?+7zNAZnddiSlca/v6cCiSgq4O8OAU0CqsW4jvMpuSMoO6TveKzkX/fB9bvGs?=
 =?us-ascii?Q?3S1oSOJgdisA13YpxvLHtXUwJ/ZqNRfcqsp37+wGVSnCxGm1KKTQmiHXCop2?=
 =?us-ascii?Q?DQv1+ZH12S7oVjJVJjYLxprjc/koMDVNIJbfzuWEyOSh8zkkTOCYeDE6kKyu?=
 =?us-ascii?Q?HeIcIQNNTee+tUOecDenk3LI0m2rHnm4wqBxLSSVpuIUPDw1eGlU3SJpixIA?=
 =?us-ascii?Q?UgkCq5KFk93yzAA8cfZGIM59K+AuwC3t7BLgRhid4z6GxMACSsXvxH5siU/h?=
 =?us-ascii?Q?5RcfhfSImAdHfVftKrnmHguyxK8cKq6UMtGqZH4cXpoXj+rw+ngH/l8L63Pn?=
 =?us-ascii?Q?0cAEtCEDDqz74/iaKQQ9jf1Y95E95phHL2eYl0+uNDaD2m4Lr0ngDkFJ+WVv?=
 =?us-ascii?Q?9a9pTvz6MxT3wFtEu7FDBcTncjbilAtJ+50o368i4nHRKuOZaHWiTN7h800L?=
 =?us-ascii?Q?eVB89LTuu3b6vvHGWIemtklo2P2qNpwf8lNCrYKqfR19xelDw0lhYXTpL25s?=
 =?us-ascii?Q?LsOZoxSEYKbrMy82btQ1ktsolvliSRTtvxNCJiTcCdNv4Qaa7yeZRTs+jnN2?=
 =?us-ascii?Q?dSa+WEwH8BYvyZijNAS+TcgKi6KDaOCX1BksvVAJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c896e7-6fb7-4f26-62f4-08de168f1660
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:01:34.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7CDV8Qljbo4ddOw77p3sgulPGFwzYBuQOYXwAbA9av4X7thN6l4tFSWm3mAS6JQQuG+navLVh7Ib0nhhAWW9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

The revision of i.MX94 ENETC is changed to v4.3, so add this revision to
enetc_info to support i.MX94 ENETC. And add PTP suspport for i.MX94.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 4 ++++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3ed0e04eb589..d5e5800b84ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3749,6 +3749,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_PPM_DEV_ID,
 	  .data = &enetc4_ppm_data,
 	},
+	{ .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_pf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 5ef2c5f3ff8f..3e222321b937 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -936,6 +936,9 @@ static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
 	case ENETC_REV_4_1:
 		devfn = PCI_DEVFN(24, 0);
 		break;
+	case ENETC_REV_4_3:
+		devfn = PCI_DEVFN(0, 1);
+		break;
 	default:
 		return -1;
 	}
-- 
2.34.1


