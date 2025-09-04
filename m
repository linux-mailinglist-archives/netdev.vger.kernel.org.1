Return-Path: <netdev+bounces-220134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E3B448AA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537133BE9EC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78E2C1580;
	Thu,  4 Sep 2025 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HyTs2Ieh"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA12C08C2;
	Thu,  4 Sep 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021885; cv=fail; b=fpYohWyn1ny6zW0lwj1z70RjKOOq56lsqA/yn4NRYssgTUqcka122nDYgn5Snw7vbUdN3N5OS0lQKHTUNep1bHV0lhb69j6M31bCPK1k6SZT326aqrO4vEX8vkc/YsKPuGVZ6KWyAsF9STfqmS+YT/zASiJ6z7iWbjYfPxz79QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021885; c=relaxed/simple;
	bh=vuTscOQdf++yeKmSni0M1dsuE8TXlUIzP0GPFV2f/U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nidqInHCPiyLd723aOqFk4/6M4zTA+GCykVBxIWuM6+JDoKtuvTgm3qCo4DQQHhecAVwPBFZ7uD3tCKdD32I6VhvtqqUbo+3gi0xk/mR2E2APY0wEMTIjliH+G2mHcBYi4KNkqQhDrdWe3rSY2xNnam04wzWUoCKWzUY353/kmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HyTs2Ieh; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COSAaSEI8tYZ6mVQ7KnJZGouKuDrTJIZWQnnTF3rT9jYym5N3hFktI4JNClcopOE1Ca9sttdTyq1S9SaN6eSfqXB7lg1HCfBul2XUk1A03UYd/xLEQHjKgI5Q+T1RTWaVGCbBAOO+2XLxN7/Sx+bbvP0S7qn9eaXys6Txl0tQ0Q4FsL3v6I9HA1NQhi2VQdOwP4+GD8uDnfQd7jE7H4FCoNZkurgW0pYRBjkNP+JHtz2e4LEl9VVByviUhrhMj9jmJ1nl8kMrxJRjbajNzParFG2GLEq39Wa8jtHtFBJbdfP6baGBIaQSWoU8B8QBBb8FTZ063JG2fRIprKZD4p2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGyL0ur0/C+rRrM0Lr38GQEa2yMRX3yCFW1grZfSe9c=;
 b=yHZ1982l8Ip6509zawObu7z4r47+VQHEzASd7T4o0xNgPs39MDcDML4Eq7MYgeoED/CR80rchDCdWzSmVc/7PK/0e0Ea59o8tU0Gxv4FLB6sIH0M5ygy8yh6KvA992SbwyeK5YXDq7IWgZeuedtaVGzodcWkhIm3xC5QLJFmPbXo7mi3bFBO1nHNC3r0Svm1yVo4dJuhjVIgBorUu8nOuefkydE+xQxk4EOoWaEcipmQ00/xMLAJproIKonw2tvK14gdloqGSlDm4YBGCmt3gkZppV7Lp+e/EUD3wmaC+4YrGTDrqEvPQlRZAW57ToIf+MOoOW7iC8MT4/r3vFRDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGyL0ur0/C+rRrM0Lr38GQEa2yMRX3yCFW1grZfSe9c=;
 b=HyTs2IehB5OLj7HwF4TwHlLwriSCorSNeOkMK7XecoCfnfx5SnRzcj3SB/ogegiF+KEVTmJz1ukO1ztcES8pl+DSZGY31WPaOAJ372hP8Jl7H5QnwYR6h5NE62RuSzubMdsGT21Vsc285rjICXuL2WCRQTtm6fynVVEezR4UIEvfO03g24F/5N1LBc+rxSUDW0autziE6JZSlWpgX/ikE5czT9pzDCz4TeTjjgbbmMJd7lXxG4j4OCryNXw4a+i0oikWcochOrji+p8KJRJ0Kg8oKoUeEW6KLH/SJfXiYFZvp6Kfx2v+ZHI4adeOzCretRTy/wbEux7i4nXOFJyoMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB11409.eurprd04.prod.outlook.com (2603:10a6:10:5d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 21:37:57 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 21:37:56 +0000
Date: Thu, 4 Sep 2025 17:37:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v5 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Message-ID: <aLoGqxZYQYB4QyBH@lizhi-Precision-Tower-5810>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
 <20250904203502.403058-5-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904203502.403058-5-shenwei.wang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB11409:EE_
X-MS-Office365-Filtering-Correlation-Id: a4defbf9-624c-456f-2d22-08ddebfb4f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HllEQQTezw/aH5BL4Svp2JKuz0Y5bU+f9DgVhkbbqcDWQQaEEFriYKS/dMLn?=
 =?us-ascii?Q?QT7fIwZDfBgaZd46v38FbSQMYXGzCGSlGbaG1zm5dokfqItw/4qiQJk7CafQ?=
 =?us-ascii?Q?oRB9YYwNc12FcBntDbnPfcSnakuEosClFfRVukXpgSuo6bXAfLx2ZJJwDeB2?=
 =?us-ascii?Q?CkPhd/5ijSFHz5nNqRrMyiIuHC2aa62YiHZ717CvKV5uivgN83xzkJ2FDv3Q?=
 =?us-ascii?Q?vAlZsEw7VMf1/sawRDzGC7wa7O4n61DKvs6M4/rfzSgXDlwh2ZAPWd6AgUtl?=
 =?us-ascii?Q?WKAckKb6rfjxJHgBLkvT1itsItvEMwDD6NTV3vPKx+wYhFkQguLp/FJ8xx2d?=
 =?us-ascii?Q?xf2CMtUIFLH1fP7mGmKL0aQz1XTrWbTdJFwQi6WyjjTFbpIQTItJmJBgQEOP?=
 =?us-ascii?Q?HsBfjfmK7lZ6a0kt3JqPmvBCzMAEHwNU0Dyje4q66/LM9Po7D1qzjFqDh+8m?=
 =?us-ascii?Q?ZidJoKWP8vZp8dmjd7tgcd6cAwbhv+hiKiSeOQOvzByV9io19BKnKOVD+fWc?=
 =?us-ascii?Q?+csKAgNqnEcOmMxGARxcg74zjpe+I2GGMSm9YZlkONmeIJ5bDYj0Z/rncO5M?=
 =?us-ascii?Q?vgbpFHAqyIxm+yotUcayaqw4aGuVfD+G3WDUTZxh3JEDGLVmlsbr6wC+yh46?=
 =?us-ascii?Q?6vsVO4v3nJcHuyOT5gwRVeJAa1DJ7pxT/5EorypZz7lZ7To5RRgO/Ih7t0Ik?=
 =?us-ascii?Q?TsSLVSfdDo4K98vFUTtt5FCHYnJD0X+7p3ggEZYndUrpsJKJjLEAnvN6gzBR?=
 =?us-ascii?Q?rk9BKrdHJyMbX+UO7f2UpHEpVqShs94SQsCyJ5qBwANFIF/lOG7zBQjJjJ4t?=
 =?us-ascii?Q?JLg1g2eBEp8wjTg+MhBOHKrSmfhiU9QLPi43v6saWOsIGafUn7UUALA3fJsI?=
 =?us-ascii?Q?AMRISW7HNYbZcpj0KCFoc9t0NyqfJhRz8K7XOaC//fwSm9UTPFV9qSmbaYYb?=
 =?us-ascii?Q?qay0k3EmnAvQsCpVFP5xUOLtvuYYB2ZVKqZBFBe7KJeW9dJFpr2FQrfFJpzk?=
 =?us-ascii?Q?RwvmA5nPI4h6WwWP19ylomChj86wo8rcbO4FgBE+34N3sQN86MHfVBImWwSt?=
 =?us-ascii?Q?mCT6Wknc6Dsp1l88pc7Fvf/lzu7+1xLveeK2DmvUBYiMI/xQ5kKRkClz3DF4?=
 =?us-ascii?Q?GkcwGpmtAgh6b6PPUQ2knRc3Gz31vtGlB+RP5s0CGrZMEEp2GicBMyiP/cuo?=
 =?us-ascii?Q?7SMuBoZqug9VbywqH8kWDiGazSsruevZ8BtuoKMTn+8AC0UcMoJYZwprrhJa?=
 =?us-ascii?Q?IoRcj4/O6m+tBSQPe7M1LoPtbhzmEZ/f3fHJ13m3XugMSNQDJOYjEQrx3xHH?=
 =?us-ascii?Q?ZM0w+z1/in5RyBwPRnnywAZPUv72Lq9Im/iphd4P9RnMKUCG0m4NMSWMjMJ7?=
 =?us-ascii?Q?hGqiarArHGmqaxiNhEJFwuWZcCTRClixaAKrKUJw+yAIMMCg7ifej+E9pOq5?=
 =?us-ascii?Q?REDCLevR59xWy5rvB5PZQ5mIUkpHcLS+KTQkqgCrQ9LEoMBOB4Hswg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tdJmAd27QEBpECnfkavdKzTeyiKLynRzLELEZmiyj/LFhHYy9+JLz8zNawJz?=
 =?us-ascii?Q?2oYoBEwk/JfG7/TkLLp2A0jD3QJjInPe3WiSxm7UmL3KclBtlwpsIz83YCyx?=
 =?us-ascii?Q?XMwgvAD295oBaimJzsMl1EEdlMQTfGgqkLoYoaJxgnLLN/4PqrfAQ2OqBcYY?=
 =?us-ascii?Q?mUZ+WC2maBgyzPgPaM3oUL0zUCazZD/NMvmE0mMKDaUXXUrmoPr8K3+260RG?=
 =?us-ascii?Q?vMA+EDc0CYirg03QHIlgcFoaSxmABqMYemDzRDj7Mv1h47FLyMdqFe6UHjfE?=
 =?us-ascii?Q?DzvSBQwBGgMfwY9BOu0Vqk3hG5ACATpNzmVHyNk02de351neXZ8H3C2kOILA?=
 =?us-ascii?Q?SRknSt9f57lA3su2ptdF9aWJGREXCnFLQ9ZhnRfCNWKnqNz8xjr4hZvx/GmC?=
 =?us-ascii?Q?iAv1/L7C/CTW5r36k7AZ68qCPadtLOk0Zt0kSG9NJnHljIFYBMb0YJ0tc1O3?=
 =?us-ascii?Q?AHmNgDpz4afk089PFRnyHnAdDIdJCTtmPfi4fAlMF0ADirwDJNqxO5u+gkH+?=
 =?us-ascii?Q?8d640aRalmemOiWG55UzKFPrhLPh5jYJuJqUcIZic0uez29R7/9zwcuvqRqB?=
 =?us-ascii?Q?tJAXf8WTJtpeUAfAtvNWDP4Rh6v4NDLt8Le5I/2g9KDqJHiUxOq06Yg2/N4f?=
 =?us-ascii?Q?CKVVSlwqsYy5/UpUINtLXr0iZIyelCgPPjqS5mzYhb1h1PdryS/LtJ4q26MC?=
 =?us-ascii?Q?3ZTu3SxZYMMjasfHh42+8GHvRNTK6kpk99myoeNFCzZnnszicZQSzese9vS9?=
 =?us-ascii?Q?1CyP7fd1d+FoVe5k1xVTGGPl/6Z3SooQVca9itzsbX2SAY46mygpr2xxPESa?=
 =?us-ascii?Q?bGVvX06Zb9X++hMQW72BFJR3pKe6sD+hoe3D4Jv/lbRXC73Zl3Q57LpkCgQM?=
 =?us-ascii?Q?wfMI3tnBJwsc2uULpzMFIjthliItRCZNZyrE3tGJWUk2ytOZ0uQn7KJ3vueD?=
 =?us-ascii?Q?7VN7rl4L1vXwm6YuZJ3b4d4F3+/hJ0vbFhnfSoKn3PuT0QXJK74W/KphBGnO?=
 =?us-ascii?Q?oFsQBBh0TfDUZat2voPtxRd4wknK4vB772+C7muW6M6xwy5Q0PeDvo+IEdyP?=
 =?us-ascii?Q?KCBHJyihc98Z1Ayut/fRWiO4UO1yxEk5fkmKJQEssVXCSkkoJD+IR7//wdYm?=
 =?us-ascii?Q?WtwJL2wDoHh0mo5WPb3gSgu3BkJAOOsU2ZKS+EeeGg0QuUsyKiA33RV+l5Hk?=
 =?us-ascii?Q?XTZ91Kyeb7itpqQLCdws9I0iCDKci/XKa+N3YMb7OlnqAunAdP55/fRvBHQY?=
 =?us-ascii?Q?E63OaShK6GlwMDDJl0sdgplm0YZ8BqXxY8zAeFMBofZzmSXnwz5G83lVFV9x?=
 =?us-ascii?Q?npXHZlwaBCKJH+BQ0Kx19PglrhHckIUq+oC6k373FlL0asSCa02SFXEXjNil?=
 =?us-ascii?Q?wFwwefSJdaR+9bEKYADtKHyOC9H5Jw5ASQ4yPIZTRJJIsLd13IrOGGDqgZij?=
 =?us-ascii?Q?y5Orfnr/wAzu0Tp/48YPbujm9Fwbf+1xfKAbVihhRnHC0a9ULqZ9y8EVT039?=
 =?us-ascii?Q?NL2owTep+OUruaLXeyFY5f5SJk4Ap99Zd+xTm+bJOyLkBP2K9FFfdIq8/DB/?=
 =?us-ascii?Q?qOU+06uf4d1VADcMUz52ggUKEgBXatqTrHwB+i00?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4defbf9-624c-456f-2d22-08ddebfb4f74
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 21:37:56.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apc9VdbjJNQAOPa09Q/ZrEYAlXJE3EbZjptSQmGsiC2yPAPUuRDf50ft7mjYa8+NQ1n8HavdvK9K5VV2yhKzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11409

On Thu, Sep 04, 2025 at 03:35:01PM -0500, Shenwei Wang wrote:
> Add a fec_change_mtu() handler to recalculate the pagepool_order based
> on the new_mtu value. It will update the rx_frame_size accordingly if
> the pagepool_order is changed.

Remove "It will".

>
> If the interface is running, it stops RX/TX, and recreate the pagepool
> with the new configuration.

If the interface is running, stop RX/TX and ...

>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  5 +-
>  drivers/net/ethernet/freescale/fec_main.c | 57 ++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index f1032a11aa76..0127cfa5529f 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -348,10 +348,11 @@ struct bufdesc_ex {
>   * the skbuffer directly.
>   */
>
...
>
> +static int fec_change_mtu(struct net_device *ndev, int new_mtu)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	int old_mtu, old_order, old_size, order, done;
> +	int ret = 0;
> +
> +	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN + FEC_DRV_RESERVE_SPACE);
> +	old_order = fep->pagepool_order;
> +	old_size = fep->rx_frame_size;
> +	old_mtu = READ_ONCE(ndev->mtu);
> +	fep->pagepool_order = order;
> +	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_DRV_RESERVE_SPACE;
> +
> +	if (!netif_running(ndev)) {
> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
> +	}
> +
> +	/* Stop TX/RX to update MAX_FL based on the new_mtu
> +	 * and free/re-allocate the buffers if needs.
> +	 */
> +	napi_disable(&fep->napi);
> +	netif_tx_disable(ndev);
> +	read_poll_timeout(fec_enet_rx_napi, done, (done == 0),
> +			  10, 1000, false, &fep->napi, 10);
> +	fec_stop(ndev);

I think you need move fep->pagepool_order and fep->rx_frame_size to here.
incase update rx_frame_size impact running queue.

Frank
> +
> +	WRITE_ONCE(ndev->mtu, new_mtu);
> +
> +	if (order != old_order) {
> +		fec_enet_free_buffers(ndev);
> +
> +		/* Create the pagepool based on the new mtu.
> +		 * Revert to the original settings if buffer
> +		 * allocation fails.
> +		 */
> +		if (fec_enet_alloc_buffers(ndev) < 0) {
> +			fep->pagepool_order = old_order;
> +			fep->rx_frame_size = old_size;
> +			WRITE_ONCE(ndev->mtu, old_mtu);
> +			fec_enet_alloc_buffers(ndev);
> +			ret = -ENOMEM;
> +		}
> +	}
> +
> +	fec_restart(ndev);
> +	napi_enable(&fep->napi);
> +	netif_tx_start_all_queues(ndev);
> +
> +	return ret;
> +}
> +
>  static const struct net_device_ops fec_netdev_ops = {
>  	.ndo_open		= fec_enet_open,
>  	.ndo_stop		= fec_enet_close,
> @@ -4029,6 +4081,7 @@ static const struct net_device_ops fec_netdev_ops = {
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_tx_timeout		= fec_timeout,
>  	.ndo_set_mac_address	= fec_set_mac_address,
> +	.ndo_change_mtu		= fec_change_mtu,
>  	.ndo_eth_ioctl		= phy_do_ioctl_running,
>  	.ndo_set_features	= fec_set_features,
>  	.ndo_bpf		= fec_enet_bpf,
> --
> 2.43.0
>

