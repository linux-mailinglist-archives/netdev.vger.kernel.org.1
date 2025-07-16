Return-Path: <netdev+bounces-207582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D8B07F26
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC521A418FD
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4F2274FF4;
	Wed, 16 Jul 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YDpkfk5C"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078661CD2C;
	Wed, 16 Jul 2025 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699050; cv=fail; b=C5oAUYVzJ9xl/OM0/1xE6Nty0Hg0E2FssMtUkdWTI18cQ8QxYBSNQ0ctFJetFA7SQwARsv6PYKKTpDPAW3BNSeCWVUPO7TktrCGUCIBJ+gGdLuyBzbyLum4zK2A+1cHqdV8wJLfvG65iSjq+NoR342x6dmJecO8okzBuo9p63Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699050; c=relaxed/simple;
	bh=CxWwGPc1J7a0uxQOvD75bRR+Dp4sUbLqr3D3E+1S5j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huqq1YfeQzRJMkje//Pvw1XxHTcJ27ZcekpKB+Hg46vcXYU9gky7GILneW7xQ/E8tZOL23eb6/0oLUSbdO5HJsNWJ+SWlrS8JyoesDkp2TDhU8MOQ5KP6sbxTimKqpNGEUJh+SD8akdhcSw0AegdpISHy3r/tYRIpqS57R+WWJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YDpkfk5C; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKzKytwXurgfRTOh/WWAeDVHeHYV+Wm0AeKoi/3yNaalsE7gbPgZ/wkTQ0b4G174OfPTI9abS1dU+MuZxgL0GdEJsfqGGQttY/H0XhHKFHaJalx/Yoxm/6BjhniDq7dtzw7niTvoGR+2qF0396Ms9FxkBwp70EEXLHN39Up/cLK6IzJRVgzTCypoiLBz2vUsCjVBX++/yxZ6f5moim69mw9mldQW4lEuCvX1tD5yQD6ULhXJVNMFzwd2A5ZQz+fLkhEFPZoH1cPlrE0Nb5AU0iWovp6VBdc53D7VFvYAYfaHbg53UYfY6GfpqCSOBWm7KV0a5J33iMuNKkszSN6yHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGqA7y/jwqzB8exsLt2UYI/SGKJQr0tygy3VMixjTY8=;
 b=WWfO6VwJCZe4rurDlc6d4tS2pKlb1j3PeSsBoKDEQanCWs4MlyR7lCbw8TdDSBidTPDsL6s5AzVjZSOU5m9GnuVL6AU4oRxM/s3a0rJ6F7k+QSzAR3en1bvSs6+bw9LiHbkm/X7k+0XUBnk/ksi4p1m+T1mE7AA1jRQi+tIHQWnBVH29KaLNgKyKwsTYoQ6VS02IdHAlw/prCmVsYF+QiEnInCYdcLaPHVOHaWz5/QyNltQ7pBFL79Z8c0mMIqKFpj6XLy5JAzDKOtd+yL+Hh3K7snnwArCRhxxsSt9h+2f7F4Moif1jd7W9FcV64I6HBIPFBF1GzGx8hNr7Hn4wSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGqA7y/jwqzB8exsLt2UYI/SGKJQr0tygy3VMixjTY8=;
 b=YDpkfk5CKP62INE5xiq0laIx4+9j66joP8+wM0bJock2YSihlgoy51x1wH4Zp7O1IPPBR3FOn8c6iwCJQTybliq4oukGiL3Vk6vRulBuAqI4Lwa9edkAEu5xuxG0V7qP5+ld2eQusWkMdhWhnIrHfBJYmGVyhT6NGuHz7Mn12mkgBPWFLEnj0pGzYkd2XYnlnrM/0WYUzAUQJWwJpDsHOMQwveDbR1zdfbhgOBMSBNH/XqQtq/KHq0zLYvH6oTSTW//dKGBv4k9N5BT0Niin3znCx+NtVFF76cIiB3mgxZFmu32FH02AbbAt069589/xPuSFMQ4JyTbkk4sewpQShA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9677.eurprd04.prod.outlook.com (2603:10a6:102:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 20:50:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:50:46 +0000
Date: Wed, 16 Jul 2025 16:50:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 11/14] net: enetc: remove unnecessary
 CONFIG_FSL_ENETC_PTP_CLOCK check
Message-ID: <aHgQnx6a8iHhgtJC@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-12-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: e947fbd7-3a83-4d7b-c3d2-08ddc4aa702c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d42TKBtsju69XaiVqM51L7HCY4ncrIaGjNcuZleAP+N2grDxPUyokPQeZJUY?=
 =?us-ascii?Q?QKRg7KLJgoPxlfF/r9dDuLxpuoQfEmXD2pztKocaUYXj5ST0lRREYMF/FnyC?=
 =?us-ascii?Q?BqahgKs8qfIJJhoC9vAsvDTM0IVZmYov+EOfSXGW96BhMRydT4kFZbYmoP0+?=
 =?us-ascii?Q?VcPGOw/ikdS0iq4d+kTc4BaS/z77PLECFaMIJofh0Aec7yBkYQF81RnfXYks?=
 =?us-ascii?Q?HTc+02vliM+fbDiCBeRJww/ZqvfbWCnT7bGVEq4ieBAqZUpmYCKkkHidnwzr?=
 =?us-ascii?Q?2CRE5oY7+3o5sgRSP5pEfM5qjFPfGMmPF3q5VLluw92+pKVjjhnyzSLAbRIE?=
 =?us-ascii?Q?QtSkv9PJ/5cVzLDaN5TeV9v/x1TalanaQfCPSRHtB/rFS7jzWqBzcKb5dB+Z?=
 =?us-ascii?Q?7DN96W2ePq6UBSI7f/0clI9QLypKxuvnMuE2oD4xidoJsfS4TWvtjJbQSqWT?=
 =?us-ascii?Q?FAYDq9ZgOOhESG/fvg4hsMVtszqW3vbi4AIQGKXL53g9qC+vL1oM6/Ap7/0R?=
 =?us-ascii?Q?JRW4pStNNuSjlrcldU/Jggo3Vxk9N8jZfwqvhVrijK5wa5ytT0vX3HDPUORj?=
 =?us-ascii?Q?D5+luSJuG0lpnTmSvXue34ZL1Te4itbZccAF5l7j1cWMQ3G7xlFtzS6lzr0u?=
 =?us-ascii?Q?myXC2Z2t2PfjvlZtpRWzh23tG9EV2g33rRe/CkcjgGFqJb/JGfTEAejfiZZU?=
 =?us-ascii?Q?Y6PvDiC5IYP+qwYWLCNdROvFRzTkFcbSY9nzLdMJ6c2dDdpSXky2ffbaMiu8?=
 =?us-ascii?Q?RucLB06DfYhuXvJG4lf1CvppKTYbMTtMyo+t53reJmS2rLxJdeHzYVt2qurI?=
 =?us-ascii?Q?rv276qsQnTu79wG7z5nujP1rInSo88PbKWPHkFhm3rDJSfxTFl5pzoXPJ6vi?=
 =?us-ascii?Q?1YFAtQVOlcUmG1IONPYIAPhnFGq/fCBetSwNxUZFUKU0i6Wo3uU+ZHyxCjsD?=
 =?us-ascii?Q?2YIB430IoWdecwJMkKvwpT5rr7ZYERJKbzU9q7L9MPzQIPHuesTGhzWEM/3W?=
 =?us-ascii?Q?cSHrxlREyEjbAOqcLFEkt+1DjDhJyTVKlpVFpPKm37T0M7dmu06fc4OCXH0Q?=
 =?us-ascii?Q?EVYVnICL/v4YTYXYTqvz8JRmTfOEFk1yN9ejXle+XiQa2SCPxhBxey1T29jC?=
 =?us-ascii?Q?x4VUmL2sA7AYmoc4YIEBl+t9NRmbPRxD/GDWtb4cVjjgpT43LQUDVyzXCgiv?=
 =?us-ascii?Q?U4/xtTXFTuW5hkl5TXtpOnn2WKCY2VSzLMOMelLD399mfGzlvtCeA0U1N8Ae?=
 =?us-ascii?Q?VBKMMT+8Ojm7zxuLoCpvpw8hp0vbg6vGzi0ym05+rZ/Gbi8R4XAA8PC0Pq8a?=
 =?us-ascii?Q?dbA3w9ahp8ezXjk++feJVnPtuMaP4I/1qviS8BPUQzoo+W8xZrqvs2FWpqmb?=
 =?us-ascii?Q?cFB6Q+IhKDecYGbs9QgDvJuTUlLP5Ea7+5vMAhu3gWDfxOfQ6BwRNQCG2L5l?=
 =?us-ascii?Q?3RjFADDZcqbMYOk1S+/4HY7vEM/DDhCjHhfgfBKUqIpND7l85QGcyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pk0P218SJb9JJ1oNX/37o+ekTJdpp4uljOZ1jtXIyP6hC25MbFwWupc8Gjr5?=
 =?us-ascii?Q?1OEaWL/F2NbZZQTgF9674KOpsx5zgCrOBohc7hE3L+0qRUdoLif+FDPvDNzX?=
 =?us-ascii?Q?cipKcNKxynhh0PwGYFBICGjzd23N7su56QOun24u1lltlAePnesvHoUBMV3Z?=
 =?us-ascii?Q?hS8okbZ0PSJYMxDeZ7wVCu4n8LA7x7FUaQAc+NnQ2hX57bG9T8CJ/vh2AV9G?=
 =?us-ascii?Q?xwXErxumiSRRI+4CUKZqAHZS0fnNrhtLcq6bCL+tkTDrmDoOCuW9o6vEDq4j?=
 =?us-ascii?Q?jZKWTwCTl7IXNurxjOTCDoQ/1swWooHahPVI625mUaJwT2EoRBTkujzBHUL1?=
 =?us-ascii?Q?oqNtCUz/+05pp4bxCGbMiuZjGG9ikHKVDCf1s5ZClgWuKrp6sdf7ZqKiCfVL?=
 =?us-ascii?Q?vAQ9Ih9dkSMUGVtI35bnuCStQQ4MnCoB2gwyEEgnvM+3YZMm7JkqrdBLYMjH?=
 =?us-ascii?Q?HOFDBpotI8KnH83pztgSVzhMsmPr17UBTvnZB8Gdwm2BxnytOOBCv6+kIRy/?=
 =?us-ascii?Q?mrSKC7w17L7+Xf2bpwf5W5J11ShpFSMVaFhbxcm+5zLV//mwFyz9kUqa/gL+?=
 =?us-ascii?Q?W/anfwLXeVd+SuOQmvcqVECwsL98vvhlXyIj2ERYKwQhr6wgE8hNvY9FLlRl?=
 =?us-ascii?Q?8atmH5Ec5+0XeH7H13f3Mh1SPn0uoxmbZ7n83lgW4ZD7tpcG/s5D66sXMpbJ?=
 =?us-ascii?Q?lb8iBuD/ZqsFGpPAm3myEB8kKvwYMY/2mWKlgLOENINexFgt4Mj6JOW6f00W?=
 =?us-ascii?Q?ugJ8dKLOMM9nn1jFfZUMGCrq6G4mQOdIm/ZmGTUI8zr/e7di0/hy55VubRhT?=
 =?us-ascii?Q?J7m6dkSNkjrGsfhIeFtj3rO0H6fiLpzDMhMXhODpaIi6a18pgK3LdcAyvMl2?=
 =?us-ascii?Q?98D8vX5t54WzudSBzVqlz2dMVICMX29MRy5rrVpHj12BrAWQmAm3zq5e3NiU?=
 =?us-ascii?Q?hx6T59SezfdWqETlYm5XY+nmOZKwAnp9oWfq6nuTNUgtquIGRUr4hZIxoJfW?=
 =?us-ascii?Q?Hqs66P7ZkVS79jYFetw+itqphg1wZjJKI2YyfONEHJn/CquiFGIo7GR0bvv3?=
 =?us-ascii?Q?/MXRCTkbrRxv7pSxskyYcjHigQlPm7MhEJ/1mx+4B16bPOS7l8uD1AyjHbpK?=
 =?us-ascii?Q?rfW87O867dQiuyJ0zGjJTO42td9pcD0EHWqxXP9+exp7uIqE/BOkzBSBMB7u?=
 =?us-ascii?Q?FkpZy0vvLUpVprsGYRkyuFwz4fOGCsx04JVEO72t+DGSWb0AlBQ/7vufuy1H?=
 =?us-ascii?Q?mGL/BerV3acGiCa+uMu+3zLkg5vy1eeE+nHWOKre93remjsijYV9Co5gLZha?=
 =?us-ascii?Q?qZCO+MyimHFEOQTxdghadjxY5HA971u2fkSyMwYzqeSDJTyA1kbNU3slUeRx?=
 =?us-ascii?Q?5uAAO4f3eytNx8TLUGKp3C+zw4fDxbwnFFk1ViwhKF7UYCgf93gUeuOt/KC3?=
 =?us-ascii?Q?f4sg1j/CMMs24b4rY539TKkwa1Zkm878KH294eD6u1oMoen1pDDIkG9jkV0x?=
 =?us-ascii?Q?U94vhxDWnUx2JpcnG1UHN6LVp6fcJUJCjUywqOJiDrZKg173h8y8zzBpXpgJ?=
 =?us-ascii?Q?KE5KURW9cY/KHI+ubV5VPyG7URNEKfJDM87OSpeZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e947fbd7-3a83-4d7b-c3d2-08ddc4aa702c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:50:46.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCfY1VF03rBOWerVQX1NOnD7G/gZTnKwesEc83bVhSEXPHAzZGaMwqYrlJ7z9E1msrj4QzSOX8g777b4P6ee7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9677

On Wed, Jul 16, 2025 at 03:31:08PM +0800, Wei Fang wrote:
> The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
> only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
> safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
>  drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index ef002ed2fdb9..4325eb3d9481 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>  		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
>  	}
>
> -	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
> -	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
> +	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
>  		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
>  }
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index ce3fed95091b..c65aa7b88122 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
>  {
>  	int hw_idx = i;
>
> -	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
> +	if (rx_ring->ext_en)
>  		hw_idx = 2 * i;
>
>  	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
> @@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
>
>  	new_rxbd++;
>
> -	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
> +	if (rx_ring->ext_en)
>  		new_rxbd++;
>
>  	if (unlikely(++new_index == rx_ring->bd_count)) {
> --
> 2.34.1
>

