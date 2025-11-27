Return-Path: <netdev+bounces-242256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D463EC8E314
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBF33AEB93
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083EB32C949;
	Thu, 27 Nov 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KQ0gxyg/"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9432E141
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245371; cv=fail; b=oz+u6Kl1zXU6WQXNtu93OYPAsT0x1DvolrfndiceGat2nvXs2NyzJOJoPvvDj4ZuLAyZHEvPzplWhBgdf92SSy3XdjodwIkrHgfmd9sCzonL2STw8iofe2fVJBhf+sh5k+/IYipZ6QbcZtKWNBggU3OWmRls1K+7z23W/1PDyIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245371; c=relaxed/simple;
	bh=l/i9jg7aMI3Yr3+zdNQtzxKN3gH0IB9NH/B66QJbkMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEFsKACz2Dj9tUe8s0NzzyPTHr1FIzl4bePFeSGtgPe/yhl7j/iO+/dGH3LQajJkhblQADqay3kv8o+EJA/Iwhw9c3DOKZEbVpXpmnYSNBejjHTVEB1hX1lKzYPO6S9GiQQCP0UclIzPbaB3u6ECRrgCV/y7WwM+tW86DYyhnTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KQ0gxyg/; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB0uxCj/ccz75/sxNzDaR24JXjkWCGEQn3vmSjeqgDbyLNXyJ8f7KYUqUGj+5udTjhqHxcqXAXSZkWdhra+rFe+tnpErVJcBz0HnKWnw8yW1qKr48iSvaYP7xbwNml+EM7G+jZqGuwsqGvu4AT6iREMYG6klzE2eX+ibBRfPPNIdSHPSDcUc58+7e1/Rr6VsxlBaJc1aInm+zBFoYI1FnNY1WK2aKV394+Xu43ojuQyVa/mIze/lwOP3/RxMkYM4RcRsz/QZBog4AD+CUGkh9o7sYahaUUOmxvnfjz+urPkWT7HjzOtT2jZRkM/xjkfcfy6slZJJcuHazqCs9fweGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4g4ZSvon8x9zXvBd5bS7480iYinLwDvV8rSd9gRRX0=;
 b=f2Wc1xLGe5dL5gfZN/JGx5U8h314HjhLDaE7rmKX8xL79Lgp2CgTRypGtqNGvOlwLz3GB8bTmf3FgfRjBNJIcFRlm2yUzfvIWn2DCLjsZ7lDhuXybyQQ1KMGZljJo9TtUZduyqsUXgpNlPyga2+L6W/2Q8N+o+qAF4IQ2x2D7HCuNzrRE3DzkVZAMBsl5TDNW+z5cEjEiG7vc2ZZoiAmgUldG34nZwbhA3ILOmQStp7TcO6qZMdKbq0FYqRkzkZnvhz5YjvkkiPspfcbH49KngKKkEUH/6LyLuRFYUPzv4sqYjwfqY1AAHga1uNZ5y6Wu/9rB7yAxZDh+8hO0xjecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4g4ZSvon8x9zXvBd5bS7480iYinLwDvV8rSd9gRRX0=;
 b=KQ0gxyg/B4L8fnImyry5XAHnW93gIE2HuEHD3P8N6bzCOPIv58DOrMbz23VO0LwK1DBP789QPpgbX5/s6BniLIV7idFrZqHJWzH+PEN3Us8MWc43CH352CPJnZm9WvFKJ470mzqBGmDFaUE1sigMLtHosinoyr028BCt7KLb77uOP7yRiyi07GfBgQXfdF/6eEPMfAaTBNcN2n95RymE/ZbSlVszaRNPHhOKMRR9xu4lC7yopkDo7WYSFwiOQQBu0LRNqDCzdcVEDZ4AQzVUiFS24/J9ILVyBaWcjlbCHsEsl0J22rhKhl/h8ydvsgZXinaLA4mFYHD31yelARM92g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB11196.eurprd04.prod.outlook.com (2603:10a6:800:291::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 12:09:22 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:22 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH net-next 02/15] net: dsa: tag_brcm: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:49 +0200
Message-ID: <20251127120902.292555-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: 99182c6a-dc27-4beb-30f4-08de2dadccf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|52116014|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ajMTzhfItmWSLbS7vRgytwOjm2LH7+slA4VaZcmuLu7zxm9wU4upv7ohG+P+?=
 =?us-ascii?Q?2yl7U5fq37E2QbDANh4sYfV6Zpsau6UtgF7EXaVlPL5HV/eborTA4sNf9VeP?=
 =?us-ascii?Q?xOZXu/VF61+nx8ld62pyyZvaKoPC1BIojQ9AqVzi/AQUsMZRDyz6d4+RgbVe?=
 =?us-ascii?Q?KfPwqbn51uwOvEJ8iYtTi7om0uR2xZQsaz1du/8NpvOziP2Yf81R4u9RsOy9?=
 =?us-ascii?Q?uFF60+wQ9C3uYsC6mFLqvZYm453hfsFlXsdCB2FEmLNb9+APHrjwrEvPvHhY?=
 =?us-ascii?Q?fDpfECX+7jqcjSgC9mH8escV+EDxRoysXSjzb45ae9spzSD1qhhnvER6lmwL?=
 =?us-ascii?Q?7hpwL3PhBIeHY70+gPCiB41lt2nWhI6PkN6qYsAMvZFP3C/u77p/Vi7uiVy9?=
 =?us-ascii?Q?xQShvh+w84iI/nf1QoIpzyhbY9+RUvv3Mo6rG6H4bxlgoGb6mSHELoERtk1l?=
 =?us-ascii?Q?EMcS4uWIeFILIGPmHOo6+8l6+f6dp33OjyWlv1DPEoFwOrGgkZTuGaTT5UoS?=
 =?us-ascii?Q?9DcNceKiNur0/5xKFXEJpfnBh8juuI6voVJcnsLH1tB/GU8t/NmlC8e+1fR2?=
 =?us-ascii?Q?S+dSBderWY6okS4VzoS8Iyzy1U/pmh9cV2XcJMksiKUtk0PodeNBRBLkLapn?=
 =?us-ascii?Q?lZ+UqbxNpwR2YhO7DbEDOL9ZwaFJnHd9A8NklcBUbVDvcYSbUKE5013HlFvp?=
 =?us-ascii?Q?A7/HbHuFUuBK4Oa6ixaMl9d48GjXdNtq4DbZEwY5BQTv+20+n5TqHXjNuxW8?=
 =?us-ascii?Q?eXnStrfNS0sEC47x7+ak8T5ITOxm43ugE5J1GqCBPaWyYGVzclmXMv4Fttf0?=
 =?us-ascii?Q?IsILk46a58U9w3kSWCVhEh2rxU5hhGPBBD9T3zFnXJAcLu38tiWUVxXAfx7r?=
 =?us-ascii?Q?nuwe+AHAOzmQDNmJUrZeShR/tjjejOjIE4JCSHANFtpIakGbnzA42iECg+Lv?=
 =?us-ascii?Q?n9Sl1qCLvWC2bvZYflgU3AUEJ0XZGUnB8xasALgpOVYNgX1RDl+v8uUXtvVk?=
 =?us-ascii?Q?WBiw3q0HRt+ngtQjQBwFVrabE9v64iMCd7s13LQHKB3lm+HH+weo1YKmNMtu?=
 =?us-ascii?Q?E/R4z/QUGKY5JKBZoxkjQYhp0cajdjj66iSUNtWJmTgCUo1/KiZPukEFZqFb?=
 =?us-ascii?Q?3Z+Ql3LCDgIgOX+aPM30Qc0QS90tmgz4gwqTn+gEP4CTQcaJCPC6HCKLSxAh?=
 =?us-ascii?Q?5kiWClRDa63wJADYz8vs3eBIGr76GSCExEdP4rRKjZFitqgxdOFPTFExPcVb?=
 =?us-ascii?Q?xCkk9BCjQxNCGd6A3mq+PSsEppCRW1tDi4ny20KL5NGm65GNT2cw0plivfAu?=
 =?us-ascii?Q?pplbpWgDa+8BWEzXekGiY+zjTuiYP1SfysjlGnEnCHV/xIryWkkKatjDY41b?=
 =?us-ascii?Q?K7rVjN5miX3hBNRRTSOxmQejg47k/NzGxVrq+hoTU65bej8pcoVixUdd+Hks?=
 =?us-ascii?Q?9Gy97VaEar0cjKabz5trSDnsqvs7rPP1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(52116014)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZNtzFiF/oIGIefZHu4155QD4oeXzV21nxbCc1Cm8brj19JYw7zPpjgMBOeT?=
 =?us-ascii?Q?2PxnKcLCdj59VjLQKrfdXNG2DgXdnmyjDyGcnkcgexZCwYK24BVv4umGteku?=
 =?us-ascii?Q?CK8GwHJPga1I4dsBD6RU5fBFz2aGI+vzQIQqbcVjPsorjg2ObpU/shA+0GIM?=
 =?us-ascii?Q?0t/BqucjJbL1zvmyLhcfSRt0QzzPxsoWz8W/JDGdJJ2YriCAvAG7BX1hv0Tr?=
 =?us-ascii?Q?fuqXDh2j1Q8Hf4lMA6WFJUghXa0RGNWQvFmyqwIT79v0P75lVVTRezeEWVeu?=
 =?us-ascii?Q?ih3gWP5Gi4B7EGd2/1aP+q2i00rpu/3QV8xWYwjpyQxXWND9kASkqoTDHWAK?=
 =?us-ascii?Q?ugQ+eqrSs51MeKDHjAjja24r+to2XhT7+xePpYYDWD61Bb9GBXUl05nsiIJG?=
 =?us-ascii?Q?OeJ88HSUeyGRHNlTThkDYH3mqqpzI2y/uYjWBVoigjDDj9Ix2C+Y/GtrUhj8?=
 =?us-ascii?Q?oGsT/dfd6FArfQ/cjCMBSorvHFLXqBhbc5tPdirPF6MOCmY+JLDRAzZLTJFZ?=
 =?us-ascii?Q?p03qRK1oL8sIhgfm/OpaaHbpQqgO8C2iynHNlSXiX45b0EmUlNDVsMSdsBdP?=
 =?us-ascii?Q?BYDqlp191+dp7FoRrc2LNmG4JRZhMw+UqOVVclBw2MGchNLdPoFL2XulbOHW?=
 =?us-ascii?Q?xQv38Pu6+zeBxqWrWdcmxLLzTQvjFmW8YA67e79iMywdWJJc7+h1QtG9dOcO?=
 =?us-ascii?Q?ebsdKEnIqYn4KOMApq7CtvVAOccm+ncNWKHDGgLDwKN0TpT6HS7vT+W/8Ffr?=
 =?us-ascii?Q?eswIXvU75haQv18KRlNqe+vNspH0Mw4d0tdaqIoxG3BJ2JDE0nqWnpljF+FD?=
 =?us-ascii?Q?4aukVv9WA9kHEJXhkzvsgch9MiqQ/P5/urNW5yPJTXE1v4D1RvrJLZwNAusX?=
 =?us-ascii?Q?NoZaVQSHOW7N2wuXzlrRN99/PjoqKkAdB4jjc4/GyQ8jTwAumafgcPPDs1nR?=
 =?us-ascii?Q?F/ZaaG/rINJyOQbP6/NbPM74Lm3I9WFkds2xcOkuNtVgGOL6RDHJ2UEueN6X?=
 =?us-ascii?Q?MeBSltFswwyoEfYperPdmBH5wzHhthzPuQWl3Vd21EaEfFuj7y4AwRmXZBqM?=
 =?us-ascii?Q?RALM33zTQPV/Mn9sAy4hPIe5Y8VV5e6L8k3ABPl+DTVfVc7I2m8WIpj+Kpr7?=
 =?us-ascii?Q?NXhAhARveiVQ5v698Y+4k7aTcmdMqtMyrDmGFN38G8mIUieb131tBRaP/Kl1?=
 =?us-ascii?Q?sZsHhz2uqKVZcxxWCJsWIMUwSyshjwVN2ZgbnE65uve503e7o9EqCJNnWg8R?=
 =?us-ascii?Q?HB+UQBChKA8PnZPC97m5nK73lnYopzZUf5JAivwytXGvyRzb2L5o7hlvpqpI?=
 =?us-ascii?Q?4X9d3diJXK1dDdE/rb+RwiGI4OSoQde8Ak1H80/vLLrbjw19mdCUGavJtBrk?=
 =?us-ascii?Q?LpkwXhIHczmZI57n9aPSAscqy3HCG1pggI1ZkztQG6Ye6zLMgWQVurp8HVSl?=
 =?us-ascii?Q?TRxQqaCmAgzsj2ICuXfItf/EMTpz7x2/IhDbdA0w8ax2T5TDDZ2AxdBnzOSh?=
 =?us-ascii?Q?Jl0YuJK5WWrUTxUpxPFiJdYAuDRuupo5wgpHhLvMpp5hZD/Xm5hGTbvKYYnF?=
 =?us-ascii?Q?OVplYSkbT7IB7Ctf02d+y8I3zaGozJ9qKM2XSz0OaWPz1Tn8JaYTu5hD9CqR?=
 =?us-ascii?Q?IL4tBYjjVD/v+RDmRg6JumTOto+BwvVWsa88ly5pdGWR90oZEcP2j+f/nEHY?=
 =?us-ascii?Q?6u5Ahw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99182c6a-dc27-4beb-30f4-08de2dadccf8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:22.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg6KB1EhhnRkDH1wi8ohDTEkxqWTQqxh4EJnA51hqDE4oVHeaMUdpsNiqPN6POxpgcrd4jM4C2clx6teMJRz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11196

The "brcm" and "brcm-prepend" tagging protocols populate a bit mask for
the TX ports, so we can use dsa_xmit_port_mask() to centralize the
decision of how to set that field. The port mask is written u8 by u8,
first the high octet and then the low octet.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_brcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index eadb358179ce..cf9420439054 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -92,6 +92,7 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	u16 queue = skb_get_queue_mapping(skb);
+	u16 port_mask;
 	u8 *brcm_tag;
 
 	/* The Ethernet switch we are interfaced with needs packets to be at
@@ -119,10 +120,9 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
 	brcm_tag[0] = (1 << BRCM_OPCODE_SHIFT) |
 		       ((queue & BRCM_IG_TC_MASK) << BRCM_IG_TC_SHIFT);
 	brcm_tag[1] = 0;
-	brcm_tag[2] = 0;
-	if (dp->index == 8)
-		brcm_tag[2] = BRCM_IG_DSTMAP2_MASK;
-	brcm_tag[3] = (1 << dp->index) & BRCM_IG_DSTMAP1_MASK;
+	port_mask = dsa_xmit_port_mask(skb, dev);
+	brcm_tag[2] = (port_mask >> 8) & BRCM_IG_DSTMAP2_MASK;
+	brcm_tag[3] = port_mask & BRCM_IG_DSTMAP1_MASK;
 
 	/* Now tell the conduit network device about the desired output queue
 	 * as well
-- 
2.43.0


