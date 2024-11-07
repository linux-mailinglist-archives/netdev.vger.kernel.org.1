Return-Path: <netdev+bounces-142948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDA9C0BF5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E981F22521
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01630215F4D;
	Thu,  7 Nov 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nEQiMSEk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8921217B;
	Thu,  7 Nov 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998221; cv=fail; b=EDSdO0dyOuYTGCjYSb0w1A4eCVKFzwv//qbXZa+qIPdC3u6j7+xt74Pax0OaM0k7ppKKeQUujMxILakrGt23UDwpkxKvRugP70s9rRBxk5j5kJiuzzpq8vIitJjnpXB5hKU9NAlNMitVFGHKDb7l6M39hcQCxKUWDD/th9RsyLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998221; c=relaxed/simple;
	bh=JL7JxxVq+FLPbMBZu2OVqYG2glI0sdstEhwp7N/aIB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YFJGQ2nTDl2uS7ugDcpd1bcB3wEwqQ8DSNtKsp+Yw6LWFUw8L6ctK25y6OyDAe4idam2hp8TY4JfabcbzTsh8JjipsnBxkB3N+E5NwJ/oGatlJklwuSCvADPDVv/3B23T6d4mKmHj/xc+hbpT/n8CkCS0ygZv2J2MoRYPKOETBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nEQiMSEk; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKGiB7L1zz71lzHCk1FMQgsgROUiBTbOf0Pmskyu30cMI0S1HWkkLaEKk9857tVnkvEs2DHxMxgZzQPUC/t6Ow19QvMsZ5zoMP5SJLBG7JZv+m7pjwC09ZbQOdh/bZAr5qWntQnsl1oHjxyWxqw2HLG58VQH8kDb3el5OrqsjaHqwIEGH2Bsfk7A8M8j8cMxVjCoshegC911ECvCaTsDU8Hodd3OUhh9AdKrlD8lLCKAtkEVli1JPUeb8013xoSLMEzAmC+TgOGiJTF7GWAHp1XSufoJxRzv3450wex77c5s3dRzZieLpJAGCUPKGqjEbTXe/KJHA9Vp9Ye29Jea3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKKj7+UMeOB2CjPIrW0+JUDjY1kgrJJDdIKtrcLK+zw=;
 b=O+jqNUIJrLfPs7AjOJaxOswqHOjPCqbEo5dkL8qKzcklYfkb1r9e9dyuXpv/7THK8ElLi0JUcs6lPhNEdC7SHy4jgTqEOWPV6am1H4pIQ1uRg/GOdyd3bWuMg0RlZ1Ohyn0Lxr8DRTyGbP3DTA7PRiUQ564snRTGmD1V7BMQEBGhVHgArk8bg9obTqBNWe8wxRYI/4RLfnbQVbi2xbhrwESw3bA54roen58qQUrD3FHnir+aOn4MLCM7Hlim9N+hHT+63xQUfWfki9y26lEta/IyZCptJb+MoWfy1R9hCvChukqRLMljcbkWDw4T2mJDy9hE+Nh9nf9A74q4VGT0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKKj7+UMeOB2CjPIrW0+JUDjY1kgrJJDdIKtrcLK+zw=;
 b=nEQiMSEkyTADbrw67cbc3V2gFA67VXIqYPKRDXiwZbhjbltNGsHbpEjw8rE8KPg8pqJrnTjtjpTd8k9pWfLKO7EqIfOc8Vt+RpIx0c/EYj/FKLdEauxptHQlSXEgCJscSRPJLdxjfui9ZUf4MimKhyuo3qIrbDrce0GqSJikaQbugWUnt49qHpMRZQO3xNOJDPnBZAz3nmWK+sZUoB0B+Wj6uF7Cu1aUdoD1wod+wcZv5yvVfJLTqjxXLgfU8xn+s8z36QQeEA4fYSh/86FcooRrEe/FB2apT0ibeawZO1/L+b3vsdpudQt5nTknunJFomyTislaOY6TkPTyNayuzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 16:50:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:50:14 +0000
Date: Thu, 7 Nov 2024 11:50:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 5/5] net: enetc: add UDP segmentation offload
 support
Message-ID: <Zyzvvu/1Q4GmbUJz@lizhi-Precision-Tower-5810>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
 <20241107033817.1654163-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107033817.1654163-6-wei.fang@nxp.com>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb65cbf-59ba-415f-dffb-08dcff4c406a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2u34kMMM9+OggM4rhdLYTXN9DvgSpa3uI1fhBXdcDc8OXk2IBd0S+1rSlXf?=
 =?us-ascii?Q?xBUy0Io8mfvcVAUlIjN8AZpiKbGEdhb3e8WKSL9SPqUZ0r756lKXBbwTh6LO?=
 =?us-ascii?Q?lKHuj5msdG0R/TmXMk+vlp18VRq48XwW6kLEb2YCX2y9HlQeopFIqnUBbfqT?=
 =?us-ascii?Q?62w5ta4L3M+Z1AYNu7x97sga41LWnYA7vUIWLjiA7Emle2BiMm4gd389vuMQ?=
 =?us-ascii?Q?h9fuZh/Ts8HESG2VR0dD11MCks5+t0lVGta9U6aOo+l73n548EiMsN7GAAfI?=
 =?us-ascii?Q?jTO2BI3xO5J448pZ4sY0kK6MXm97er35XHUIN/b+yr43p3b1vdsbV8BEvAM/?=
 =?us-ascii?Q?w5H7E7Zhn5f5CDTXljTTLvVn5zDuMsNeG1o5fG7fTSo7kJ2kh5jFePUjwgyl?=
 =?us-ascii?Q?k3fWCJf2WKF4cOAe4ZBdzbsLeADuCD9LJ2eC8LqLKeBmUQBZphsYbP+ug2ru?=
 =?us-ascii?Q?tLL69sJZZjzGmqpheapxF7Im7yIanOn61KOomWRidd9eQ8tg41twD0uXnw+N?=
 =?us-ascii?Q?wgTNefG0TaYd2vMnfRVLfT84yPCWT/M1VS6nI0PzUbEfYmgVfgYNMs0JUpXH?=
 =?us-ascii?Q?PSFE9Q2bzQU6GzVk2S9y3ovqHblDxJ7qal1MVTXUuH1u2fAg0CD5M0WoUsCx?=
 =?us-ascii?Q?tqu3L0LdQdTPJ+ZmfsdRFE23JLZXLn57MuC4BcXWls2U8zBjFwulVtxCJWCg?=
 =?us-ascii?Q?xiAvkMDJjtgiVdoV4CKzAO5DyHQHwAs8+Nwa+qNZhU4s8A61WQwNdBmFwTel?=
 =?us-ascii?Q?wD/SJ5igSgH6yQVoQW+F+LlTT2vRSvdhWp77lKeKumI/x6PgfnsCNPmRrLAP?=
 =?us-ascii?Q?M1uqesV+QaSTyUPtN5SHWbfan6flin4tmCnRX3/f1Qhs4+nrfSIKOyWBbk2W?=
 =?us-ascii?Q?fHhn84fsL47u2K9hbwB7KqmBPg848WwVesS+Rx69i+0L4reJsjME3bxLAwaT?=
 =?us-ascii?Q?Z7sYoF0ugRDCtoRHh8dLprZ81wzagOo3mq7KiM7u4pGYXI9YDXd+2NmwCTfJ?=
 =?us-ascii?Q?25JsYtf4jgILQni6Wq/wCvjrbHpSdhFvHf0vx5+P7IX03C+cPPScm1JrFj2k?=
 =?us-ascii?Q?35GVLsQdEV5oHec6cxdTAAvKQBEAZqDryE7sYvsDyANVxyqj25TZNW5U45KS?=
 =?us-ascii?Q?2cgaHh7cghZM4vlT8GHW5JXbj4dsiOq3Zn2ap3yvHd17AnoHifL7L5cxFuWd?=
 =?us-ascii?Q?QTWoxYGZwEbg2IwHK/9RHM5rObY7zh6Gv99pBDT90W0MPRhywkvoJ2l6m5WJ?=
 =?us-ascii?Q?hVoSxFCR6gHxjskzqDqep8JjXmWX6ReKgqAfpVzd2RHJnYoOGLuTveYOL6Nc?=
 =?us-ascii?Q?6U7oBIU2QvkLRxEAsRVGpFyxAwB+FK9fd55AcKLPtNCn7ZOVlYaofMTvyuBJ?=
 =?us-ascii?Q?kwOuvus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVDgufQ9DfTzOHcDoPrHoWg2t8JTBeHIla2AlLjmW8hOEfV3ImeSLACYmfT6?=
 =?us-ascii?Q?2NGWG/8R0xDYQrfDb1rXQ1V419p7j7GZAye9O1Dm/O2iP8h4YmhaNB4UceGx?=
 =?us-ascii?Q?cuWX4xF2vQSlbFJzc6k2Zert/CK3L372gK6KpIuCo8PZD9FUIrFsLWSnSHBb?=
 =?us-ascii?Q?Fw3JWsyPaeXcpWaZGiuNRxWHAmJYaLBCPJWnoNLdGo8SGLYnfVY2w/nnmABp?=
 =?us-ascii?Q?nvxzEUshqmo4dDyUEOvl4ZpnFhvnrCTxkigZgBXnHr1Zixv1znhPxO7k2l7g?=
 =?us-ascii?Q?nNjsNA0nYhXX6y75FqiMdE98XiTSVJMzR273E0PjCZZuGcTpv7GXd1aihBj+?=
 =?us-ascii?Q?cGjVUxGX5cj2MXpnx/RWyW4Ri1zeNtQarXQ8icvOOMlDiKokMEZn7Op8m0BH?=
 =?us-ascii?Q?HbaTf0sPbFs1sf/1r4DMB5ctevcs1LYrccYpvBmDdp21ZUveNOxaHm9WzP4c?=
 =?us-ascii?Q?8A3fThxYAxdDof6Vp5Ar7O62x3rxX66DY3tFCKucBdgKZWa6+Y+MvzD8iGdB?=
 =?us-ascii?Q?RF4GbMgBfkZm/o6IRHkgqqpkSq8fOR4Rtal0YoOGMie3IpKh1WavlMa+sMb+?=
 =?us-ascii?Q?yYr/qcFd+Sh2yE2ChuqtYl4fEKs6kjG8WJEbsCV4IpJkJha5ZeERmwpygw+P?=
 =?us-ascii?Q?BiGW9qQFNwGYhuBM3prxzHA56mK7kncaFQaG+5YvpU1hT4PemAh/1eVfcFay?=
 =?us-ascii?Q?KaNgEL+U+ndCLjHbXJou0E4C+YDAAty7TlKAXSYDJA2inz+BCBr2ADTYxGJq?=
 =?us-ascii?Q?Xs+IDuXZ8N3lU6uXwU3PFIadGGuKIY+CZTKbbt8tl1O4tyij68nkI/p1QsvR?=
 =?us-ascii?Q?sbzqcO6Y3qLV8FOAKM5mnG1qMg6yc4MV7UVtafAxiFAeGGOZbJbrSToCrB3m?=
 =?us-ascii?Q?L+VfsDY4PW3uxjchHVBSSQRDatH9YfTyZS3IEcwQJAY9o/ahD5wzkXpe3T5J?=
 =?us-ascii?Q?yCvfQqh7Gfz3kPHUZxd0wEp45aw50EPC3G4ljo2jPzDa5YhNZKwlcx0RFGbI?=
 =?us-ascii?Q?OUwVw2SUUy6fUlwvVJirSzqoKLb6DLEs9JAsmgrI1eBmLV7EE7oV4jmLZ8Fn?=
 =?us-ascii?Q?qLQHrO+Mh0Ri6SfxGsvyiaybyPSEVzlnWtYSGRsY4a5v2lLl/YCvrCVVOhJj?=
 =?us-ascii?Q?5adJSzmcGdU80NmtRN/tbAT2qm5JXxN65RU9JLptlBUJNYk8StWAqiGY2h+f?=
 =?us-ascii?Q?B2IflwWXm7j9wtlr3CT9n524N+VjFJWAFKlECPTAUCF2vY4SCGxrnHr0KeRo?=
 =?us-ascii?Q?beN56C63QzjEiMwnQxyxBmOWku/b7uSAB4BbFEymurC6aWhkkmBcAOajO+Rz?=
 =?us-ascii?Q?H8Mwk2dXxOoLwkk+gqUx4TFT5GvhN8FaM2xBLAXS2cKbz/OsVVOtGIwLVehS?=
 =?us-ascii?Q?RX9g8KPB4nZ8xG2+pZ0MYgbwgm94wEeWOke3O93iDFsq1gQUN58mCeyDg/MD?=
 =?us-ascii?Q?psaw4kIuEQaKwU1Bj7XFJoEdM5KbbeGl1Z0i6924F8lR5CAwSdU4fIgcCXsB?=
 =?us-ascii?Q?c2wJXr144COHpHMnSFPZy7EsiPRHmJh+99BaJ5ZPo+HeCXnqMt9zx9J3+Msf?=
 =?us-ascii?Q?CAVuFowQbNAVBvN1jE+Lkyl8MIp6x7uC84r0i1Cl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb65cbf-59ba-415f-dffb-08dcff4c406a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:50:14.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQfSCG6muiBFnKtCr6TjCDroSMsibijBTP4Z7PAzQTOe5LTUd39lr5ctlLHCooYNVgUEy3VoMyrSz+KXLbes9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

On Thu, Nov 07, 2024 at 11:38:17AM +0800, Wei Fang wrote:
> For LS1028A, the enetc driver implements TCP segmentation via the tso
> interfaces provided by the kernel, but since the commit 3d5b459ba0e3
> ("net: tso: add UDP segmentation support"), the LS1028A enetc driver
> also supports UDP segmentation.
> For i.MX95, the enetc driver implements TCP segmentation via the LSO
> feature, and LSO also supports UDP segmentation.
> Therefore, setting the NETIF_F_GSO_UDP_L4 bit in the enetc net_device
> indicates that enetc supports UDP segmentation offload.

Set NETIF_F_GSO_UDP_L4 bit of hw_features because i.MX95 enetc and LS1028A
driver implements UDP segmenation.

- i.MX95 enetc supports UDP segmentation via LSO.
- LS1028A enetc supports UDP segmenation since the commit 3d5b459ba0e3 ....

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 82a67356abe4..76fc3c6fdec1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
>  			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
>  			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			    NETIF_F_GSO_UDP_L4;
>  	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
>  			 NETIF_F_HW_VLAN_CTAG_TX |
>  			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			 NETIF_F_GSO_UDP_L4;
>  	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
>  			      NETIF_F_TSO | NETIF_F_TSO6;
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 052833acd220..ba71c04994c4 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
>  			    NETIF_F_HW_VLAN_CTAG_TX |
>  			    NETIF_F_HW_VLAN_CTAG_RX |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			    NETIF_F_GSO_UDP_L4;
>  	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
>  			 NETIF_F_HW_VLAN_CTAG_TX |
>  			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			 NETIF_F_GSO_UDP_L4;
>  	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
>  			      NETIF_F_TSO | NETIF_F_TSO6;
>
> --
> 2.34.1
>

